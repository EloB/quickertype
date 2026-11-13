//! The `tsc --api` process and its message framing.
//!
//! Port of `typescript/dist/api/syncChannel.js` (TypeScript 7.0.2). Every
//! message is a MessagePack `fixarray(3)` of `[type, method, payload]`:
//! `type` is a positive fixint, `method` and `payload` are `bin` values.
//! Requests are strictly serial. While serving one, the server may call
//! back into the client (virtual file system); the client answers each
//! call before the response arrives. Payloads are JSON text, except for
//! binary-AST responses.

use std::io::{self, BufReader, BufWriter, Read, Write};
use std::path::Path;
use std::process::{Child, ChildStdin, ChildStdout, Command, Stdio};
use std::sync::{Arc, Mutex};
use std::thread::JoinHandle;

use crate::error::{Error, Result};

const MSG_REQUEST: u8 = 1;
const MSG_CALL_RESPONSE: u8 = 2;
const MSG_CALL_ERROR: u8 = 3;
const MSG_RESPONSE: u8 = 4;
const MSG_ERROR: u8 = 5;
const MSG_CALL: u8 = 6;

/// Files the client serves from memory through the `readFile`/`fileExists`
/// callbacks; every other path falls back to the real file system.
pub type VirtualFiles = Vec<(String, String)>;

/// A running `tsc --api` process.
pub struct Channel {
    child: Child,
    writer: Option<BufWriter<ChildStdin>>,
    reader: BufReader<ChildStdout>,
    stderr: Arc<Mutex<Vec<u8>>>,
    stderr_thread: Option<JoinHandle<()>>,
    files: VirtualFiles,
}

fn write_bin(w: &mut impl Write, bytes: &[u8]) -> io::Result<()> {
    let n = bytes.len();
    if n < 0x100 {
        w.write_all(&[0xc4, n as u8])?;
    } else if n < 0x1_0000 {
        w.write_all(&[0xc5])?;
        w.write_all(&(n as u16).to_be_bytes())?;
    } else {
        let n = u32::try_from(n).map_err(|_| io::Error::other("message too large"))?;
        w.write_all(&[0xc6])?;
        w.write_all(&n.to_be_bytes())?;
    }
    w.write_all(bytes)
}

fn read_u8(r: &mut impl Read) -> io::Result<u8> {
    let mut b = [0u8];
    r.read_exact(&mut b)?;
    Ok(b[0])
}

fn read_bin(r: &mut impl Read) -> io::Result<Vec<u8>> {
    let len = match read_u8(r)? {
        0xc4 => read_u8(r)? as usize,
        0xc5 => {
            let mut b = [0u8; 2];
            r.read_exact(&mut b)?;
            u16::from_be_bytes(b) as usize
        }
        0xc6 => {
            let mut b = [0u8; 4];
            r.read_exact(&mut b)?;
            u32::from_be_bytes(b) as usize
        }
        m => {
            return Err(io::Error::other(format!(
                "expected binary data (0xc4-0xc6), received 0x{m:x}"
            )));
        }
    };
    let mut v = vec![0u8; len];
    r.read_exact(&mut v)?;
    Ok(v)
}

impl Channel {
    /// Starts `exe --api --cwd <cwd> --callbacks=readFile,fileExists`.
    pub fn spawn(exe: &Path, cwd: &Path, files: VirtualFiles) -> Result<Channel> {
        let mut child = Command::new(exe)
            .arg("--api")
            .arg("--cwd")
            .arg(cwd)
            .arg("--callbacks=readFile,fileExists")
            .current_dir(cwd)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .map_err(|e| Error::Tsc(format!("could not start {}: {e}", exe.display())))?;
        let (Some(stdin), Some(stdout), Some(mut err)) =
            (child.stdin.take(), child.stdout.take(), child.stderr.take())
        else {
            let _ = child.kill();
            let _ = child.wait();
            return Err(Error::Tsc(
                "could not open the compiler's standard streams".into(),
            ));
        };
        // Drain stderr on a thread so a chatty compiler cannot block on a
        // full pipe; its text is quoted if the process dies.
        let stderr = Arc::new(Mutex::new(Vec::new()));
        let sink = Arc::clone(&stderr);
        let stderr_thread = std::thread::spawn(move || {
            let mut buf = [0u8; 4096];
            while let Ok(n) = err.read(&mut buf) {
                if n == 0 {
                    break;
                }
                if let Ok(mut s) = sink.lock() {
                    s.extend_from_slice(&buf[..n]);
                }
            }
        });
        Ok(Channel {
            child,
            writer: Some(BufWriter::new(stdin)),
            reader: BufReader::with_capacity(1 << 16, stdout),
            stderr,
            stderr_thread: Some(stderr_thread),
            files,
        })
    }

    fn frame(&mut self, ty: u8, name: &[u8], payload: &[u8]) -> io::Result<()> {
        let w = self
            .writer
            .as_mut()
            .ok_or_else(|| io::Error::other("channel closed"))?;
        w.write_all(&[0x93, ty])?;
        write_bin(w, name)?;
        write_bin(w, payload)?;
        w.flush()
    }

    /// Sends a request and returns the raw response payload (empty means
    /// `undefined`).
    pub fn request(&mut self, method: &str, payload: &[u8]) -> Result<Vec<u8>> {
        self.request_io(method, payload)
            .map_err(|e| self.failure(method, e))
    }

    fn request_io(&mut self, method: &str, payload: &[u8]) -> io::Result<Vec<u8>> {
        self.frame(MSG_REQUEST, method.as_bytes(), payload)?;
        loop {
            let marker = read_u8(&mut self.reader)?;
            if marker != 0x93 {
                return Err(io::Error::other(format!(
                    "expected fixed 3-element array (0x93), received 0x{marker:x}"
                )));
            }
            let ty = match read_u8(&mut self.reader)? {
                0xcc => read_u8(&mut self.reader)?,
                t if t <= 0x7f => t,
                t => {
                    return Err(io::Error::other(format!(
                        "expected a message type, received 0x{t:x}"
                    )));
                }
            };
            let name = read_bin(&mut self.reader)?;
            let body = read_bin(&mut self.reader)?;
            match ty {
                MSG_RESPONSE if name == method.as_bytes() => return Ok(body),
                MSG_ERROR if name == method.as_bytes() => {
                    return Err(io::Error::other(
                        String::from_utf8_lossy(&body).into_owned(),
                    ));
                }
                MSG_CALL => match self.callback(&name, &body) {
                    Ok(reply) => self.frame(MSG_CALL_RESPONSE, &name, reply.as_bytes())?,
                    Err(msg) => {
                        self.frame(MSG_CALL_ERROR, &name, msg.as_bytes())?;
                        return Err(io::Error::other(msg));
                    }
                },
                MSG_RESPONSE | MSG_ERROR => {
                    return Err(io::Error::other(format!(
                        "name mismatch for response: expected `{method}`, got `{}`",
                        String::from_utf8_lossy(&name)
                    )));
                }
                t => {
                    return Err(io::Error::other(format!(
                        "invalid message type from child: {t}"
                    )));
                }
            }
        }
    }

    /// Answers a virtual-file-system callback (`syncChannel.js`/`client.js`).
    /// `readFile` returns `{"content": …}`, or `""` for "not ours".
    fn callback(&self, name: &[u8], arg: &[u8]) -> std::result::Result<String, String> {
        let path: String =
            serde_json::from_slice(arg).map_err(|e| format!("bad callback argument: {e}"))?;
        let ours = self.files.iter().find(|(p, _)| *p == path);
        Ok(match (name, ours) {
            (b"readFile", Some((_, content))) => {
                serde_json::json!({ "content": content }).to_string()
            }
            (b"fileExists", Some(_)) => "true".to_owned(),
            (b"readFile" | b"fileExists", None) => String::new(),
            (other, _) => {
                return Err(format!(
                    "unknown callback: `{}`",
                    String::from_utf8_lossy(other)
                ));
            }
        })
    }

    fn failure(&mut self, method: &str, e: io::Error) -> Error {
        let status = self.child.try_wait().ok().flatten();
        let stderr = self
            .stderr
            .lock()
            .map(|s| String::from_utf8_lossy(&s).trim().to_owned())
            .unwrap_or_default();
        let mut msg = format!("TypeScript compiler request `{method}` failed: {e}");
        if let Some(status) = status {
            msg.push_str(&format!(" (compiler exited: {status})"));
        }
        if !stderr.is_empty() {
            msg.push_str(&format!("\n{stderr}"));
        }
        Error::Tsc(msg)
    }
}

impl Drop for Channel {
    fn drop(&mut self) {
        // Closing stdin ends the server; kill it in case it does not exit.
        self.writer = None;
        let _ = self.child.kill();
        let _ = self.child.wait();
        if let Some(t) = self.stderr_thread.take() {
            let _ = t.join();
        }
    }
}
