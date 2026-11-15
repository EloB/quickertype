//! The `tsc --api` process and its message framing.
//!
//! Port of `typescript/dist/api/syncChannel.js` (TypeScript 7.0.2). Every
//! message is a MessagePack `fixarray(3)` of `[type, method, payload]`:
//! `type` is a positive fixint, `method` and `payload` are `bin` values.
//! Requests are strictly serial. While serving one, the server may call
//! back into the client (virtual file system); the client answers each
//! call before the response arrives. Payloads are JSON text, except for
//! binary-AST responses.

use std::collections::BTreeMap;
use std::io::{self, BufReader, BufWriter, Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Child, ChildStdin, ChildStdout, Command, Stdio};
use std::sync::{Arc, Mutex};
use std::thread::JoinHandle;
use std::time::{Duration, Instant};

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

/// Per-method request statistics.
#[derive(Clone, Debug, Default)]
pub struct MethodStats {
    /// Requests sent.
    pub count: u64,
    /// Payload bytes sent.
    pub bytes_out: u64,
    /// Payload bytes received.
    pub bytes_in: u64,
    /// Time from sending the request to having its response.
    pub round_trip: Duration,
}

/// What the channel has done so far.
#[derive(Clone, Debug, Default)]
pub struct Stats {
    /// Requests by method.
    pub methods: BTreeMap<String, MethodStats>,
    /// Requests sent one at a time, each waiting for its answer.
    pub round_trips: u64,
    /// Calls back to the client (file system callbacks) it answered.
    pub callbacks: u64,
    /// Pipelined batches sent.
    pub batches: u64,
    /// Time spent in pipelined batches (their requests count no round trip).
    pub batch_time: Duration,
    /// Time spent blocked in `read()` on the compiler's stdout.
    pub blocked: Duration,
    /// `read()` calls on the compiler's stdout.
    pub reads: u64,
}

/// Set to any value to have each channel print its [`Stats`] to stderr
/// when it closes.
pub const STATS_ENV: &str = "QUICKTYPE_TSC_STATS";

impl std::fmt::Display for Stats {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let ms = |d: Duration| d.as_secs_f64() * 1000.0;
        writeln!(
            f,
            "{:<34} {:>9} {:>11} {:>11} {:>10}",
            "tsc request", "count", "bytes out", "bytes in", "ms"
        )?;
        let mut total = MethodStats::default();
        let mut rows: Vec<_> = self.methods.iter().collect();
        rows.sort_by(|a, b| b.1.count.cmp(&a.1.count).then(a.0.cmp(b.0)));
        for (name, m) in rows {
            writeln!(
                f,
                "{name:<34} {:>9} {:>11} {:>11} {:>10.1}",
                m.count,
                m.bytes_out,
                m.bytes_in,
                ms(m.round_trip)
            )?;
            total.count += m.count;
            total.bytes_out += m.bytes_out;
            total.bytes_in += m.bytes_in;
            total.round_trip += m.round_trip;
        }
        writeln!(
            f,
            "{:<34} {:>9} {:>11} {:>11} {:>10.1}",
            "total",
            total.count,
            total.bytes_out,
            total.bytes_in,
            ms(total.round_trip)
        )?;
        writeln!(
            f,
            "round trips: {} one at a time, {} pipelined batches ({:.1} ms); {} callbacks",
            self.round_trips,
            self.batches,
            ms(self.batch_time),
            self.callbacks
        )?;
        writeln!(
            f,
            "blocked in read(): {:.1} ms over {} reads",
            ms(self.blocked),
            self.reads
        )
    }
}

/// The compiler's stdout, timing the reads that wait for it.
struct TimedReader {
    inner: ChildStdout,
    blocked: Duration,
    reads: u64,
}

impl Read for TimedReader {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        let start = Instant::now();
        let n = self.inner.read(buf);
        self.blocked += start.elapsed();
        self.reads += 1;
        n
    }
}

#[cfg(test)]
thread_local! {
    /// Makes the next batch on this thread fail as if the compiler had
    /// called back during it.
    pub(crate) static FAKE_CALLBACK_IN_NEXT_BATCH: std::cell::Cell<bool> =
        const { std::cell::Cell::new(false) };
}

/// A running `tsc --api` process.
pub struct Channel {
    /// The compiler, for errors.
    exe: PathBuf,
    child: Child,
    writer: Option<BufWriter<ChildStdin>>,
    reader: BufReader<TimedReader>,
    stderr: Arc<Mutex<Vec<u8>>>,
    stderr_thread: Option<JoinHandle<()>>,
    files: VirtualFiles,
    stats: BTreeMap<String, MethodStats>,
    round_trips: u64,
    callbacks: u64,
    batches: u64,
    batch_time: Duration,
    called_back: bool,
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

fn write_frame(w: &mut impl Write, ty: u8, name: &[u8], payload: &[u8]) -> io::Result<()> {
    w.write_all(&[0x93, ty])?;
    write_bin(w, name)?;
    write_bin(w, payload)
}

/// Reads one message: its type, method name and payload.
fn read_message(r: &mut impl Read) -> io::Result<(u8, Vec<u8>, Vec<u8>)> {
    let marker = read_u8(r)?;
    if marker != 0x93 {
        return Err(io::Error::other(format!(
            "expected fixed 3-element array (0x93), received 0x{marker:x}"
        )));
    }
    let ty = match read_u8(r)? {
        0xcc => read_u8(r)?,
        t if t <= 0x7f => t,
        t => {
            return Err(io::Error::other(format!(
                "expected a message type, received 0x{t:x}"
            )));
        }
    };
    let name = read_bin(r)?;
    let body = read_bin(r)?;
    Ok((ty, name, body))
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
        let mut command = Command::new(exe);
        command
            .arg("--api")
            .arg("--cwd")
            .arg(cwd)
            .arg("--callbacks=readFile,fileExists");
        let mut child = command
            .current_dir(cwd)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .map_err(|e| super::locate::start_error(exe, &e))?;
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
            exe: exe.to_path_buf(),
            child,
            writer: Some(BufWriter::with_capacity(1 << 16, stdin)),
            reader: BufReader::with_capacity(
                1 << 16,
                TimedReader {
                    inner: stdout,
                    blocked: Duration::ZERO,
                    reads: 0,
                },
            ),
            stderr,
            stderr_thread: Some(stderr_thread),
            files,
            stats: BTreeMap::new(),
            round_trips: 0,
            callbacks: 0,
            batches: 0,
            batch_time: Duration::ZERO,
            called_back: false,
        })
    }

    fn frame(&mut self, ty: u8, name: &[u8], payload: &[u8]) -> io::Result<()> {
        let w = self
            .writer
            .as_mut()
            .ok_or_else(|| io::Error::other("channel closed"))?;
        write_frame(w, ty, name, payload)?;
        w.flush()
    }

    fn count(&mut self, method: &str, bytes_out: usize, bytes_in: usize, time: Duration) {
        let m = match self.stats.get_mut(method) {
            Some(m) => m,
            None => self.stats.entry(method.to_owned()).or_default(),
        };
        m.count += 1;
        m.bytes_out += bytes_out as u64;
        m.bytes_in += bytes_in as u64;
        m.round_trip += time;
    }

    /// Sends a request and returns the raw response payload (empty means
    /// `undefined`).
    pub fn request(&mut self, method: &str, payload: &[u8]) -> Result<Vec<u8>> {
        let start = Instant::now();
        let reply = self
            .request_io(method, payload)
            .map_err(|e| self.failure(method, e))?;
        self.count(method, payload.len(), reply.len(), start.elapsed());
        self.round_trips += 1;
        Ok(reply)
    }

    /// Sends all `requests` before reading any response, and returns each
    /// response payload in order, `None` where the compiler answered with an
    /// error. The server reads and answers one message at a time, so the
    /// answers are the ones serial requests would get; only the waiting for
    /// each round trip is gone. The requests must not make the compiler call
    /// back: it would read the next request as the answer to its call and
    /// fail. Checker and program queries do not call back (the file system
    /// callbacks happen while a snapshot is built; imports, references and
    /// packages in `node_modules` are resolved by then). If one does, the
    /// process is ended, the batch fails, and
    /// [`Channel::called_back_in_batch`] says so, for the caller to start
    /// over without pipelining.
    pub fn request_batch(
        &mut self,
        requests: &[(&'static str, Vec<u8>)],
    ) -> Result<Vec<Option<Vec<u8>>>> {
        if requests.is_empty() {
            return Ok(Vec::new());
        }
        #[cfg(test)]
        if FAKE_CALLBACK_IN_NEXT_BATCH.with(|c| c.replace(false)) {
            self.called_back = true;
            let _ = self.child.kill();
            let e =
                io::Error::other("the compiler called back (`readFile`) during pipelined requests");
            return Err(self.failure("(pipelined)", e));
        }
        let start = Instant::now();
        let replies = self
            .batch_io(requests)
            .map_err(|e| self.failure("(pipelined)", e))?;
        for ((method, payload), reply) in requests.iter().zip(&replies) {
            let len = reply.as_ref().map_or(0, Vec::len);
            self.count(method, payload.len(), len, Duration::ZERO);
        }
        self.batches += 1;
        self.batch_time += start.elapsed();
        Ok(replies)
    }

    fn batch_io(
        &mut self,
        requests: &[(&'static str, Vec<u8>)],
    ) -> io::Result<Vec<Option<Vec<u8>>>> {
        let Channel {
            writer,
            reader,
            child,
            called_back,
            ..
        } = self;
        let writer = writer
            .as_mut()
            .ok_or_else(|| io::Error::other("channel closed"))?;
        // Writing on a second thread while this one reads keeps both pipes
        // draining: with one thread, a full stdin pipe (the compiler blocked
        // writing answers nobody reads) would deadlock.
        std::thread::scope(|scope| {
            let sender = scope.spawn(move || -> io::Result<()> {
                for (method, payload) in requests {
                    write_frame(writer, MSG_REQUEST, method.as_bytes(), payload)?;
                }
                writer.flush()
            });
            let mut replies = Vec::with_capacity(requests.len());
            let mut failure = None;
            for (method, _) in requests {
                match read_message(reader) {
                    Ok((MSG_RESPONSE, name, body)) if name == method.as_bytes() => {
                        replies.push(Some(body));
                    }
                    Ok((MSG_ERROR, name, _)) if name == method.as_bytes() => replies.push(None),
                    Ok((MSG_CALL, name, _)) => {
                        // The compiler reads the next pipelined request as the
                        // answer to its call, and fails (`unexpected message
                        // while waiting for … response`): the protocol cannot
                        // serve a callback here, and the session is over.
                        *called_back = true;
                        failure = Some(io::Error::other(format!(
                            "the compiler called back (`{}`) during pipelined requests",
                            String::from_utf8_lossy(&name)
                        )));
                        break;
                    }
                    Ok((MSG_RESPONSE | MSG_ERROR, name, _)) => {
                        failure = Some(io::Error::other(format!(
                            "name mismatch for response: expected `{method}`, got `{}`",
                            String::from_utf8_lossy(&name)
                        )));
                        break;
                    }
                    Ok((t, _, _)) => {
                        failure = Some(io::Error::other(format!(
                            "invalid message type from child: {t}"
                        )));
                        break;
                    }
                    Err(e) => {
                        failure = Some(e);
                        break;
                    }
                }
            }
            if failure.is_some() {
                // The sender may be blocked on a full pipe; ending the
                // compiler makes its write fail.
                let _ = child.kill();
            }
            let sent = sender
                .join()
                .unwrap_or_else(|_| Err(io::Error::other("the request writer panicked")));
            match failure {
                Some(e) => Err(e),
                None => sent.map(|()| replies),
            }
        })
    }

    /// Whether the compiler called back during a pipelined batch, which ended
    /// the session (see [`Channel::request_batch`]).
    pub fn called_back_in_batch(&self) -> bool {
        self.called_back
    }

    /// Statistics of the requests so far.
    pub fn stats(&self) -> Stats {
        Stats {
            methods: self.stats.clone(),
            round_trips: self.round_trips,
            callbacks: self.callbacks,
            batches: self.batches,
            batch_time: self.batch_time,
            blocked: self.reader.get_ref().blocked,
            reads: self.reader.get_ref().reads,
        }
    }

    fn request_io(&mut self, method: &str, payload: &[u8]) -> io::Result<Vec<u8>> {
        self.frame(MSG_REQUEST, method.as_bytes(), payload)?;
        loop {
            let (ty, name, body) = read_message(&mut self.reader)?;
            match ty {
                MSG_RESPONSE if name == method.as_bytes() => return Ok(body),
                MSG_ERROR if name == method.as_bytes() => {
                    return Err(io::Error::other(
                        String::from_utf8_lossy(&body).into_owned(),
                    ));
                }
                MSG_CALL => match self.callback(&name, &body) {
                    Ok(reply) => {
                        self.callbacks += 1;
                        self.frame(MSG_CALL_RESPONSE, &name, reply.as_bytes())?
                    }
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

    /// Describes a failed request, quoting how the compiler exited and what
    /// it wrote to stderr. The channel is unusable afterwards: stdin is
    /// closed and the process is reaped (killed if it does not exit within
    /// two seconds), so the exit status and all of stderr are available.
    fn failure(&mut self, method: &str, e: io::Error) -> Error {
        self.writer = None;
        let deadline = Instant::now() + Duration::from_secs(2);
        let mut status = None;
        loop {
            match self.child.try_wait() {
                Ok(Some(s)) => {
                    status = Some(s);
                    break;
                }
                Ok(None) if Instant::now() < deadline => {
                    std::thread::sleep(Duration::from_millis(10))
                }
                _ => break,
            }
        }
        if status.is_none() {
            let _ = self.child.kill();
            let _ = self.child.wait();
        }
        if let Some(t) = self.stderr_thread.take() {
            let _ = t.join();
        }
        let stderr = self
            .stderr
            .lock()
            .map(|s| String::from_utf8_lossy(&s).trim().to_owned())
            .unwrap_or_default();
        // Where exec fails with ENOEXEC (a file that is not a program for
        // this system), the C library runs it with /bin/sh, which exits with
        // 126, "cannot execute", before answering anything.
        if cfg!(unix) && status.and_then(|s| s.code()) == Some(126) {
            let why = match status {
                Some(status) if stderr.is_empty() => status.to_string(),
                Some(status) => format!("{status} ({stderr})"),
                None => unreachable!(),
            };
            return super::locate::not_a_program_error(&self.exe, &why);
        }
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
        if std::env::var_os(STATS_ENV).is_some() {
            // A diagnostic: nothing may fail here, not even writing it.
            let _ = write!(io::stderr().lock(), "{}", self.stats());
        }
        // Closing stdin ends the server; kill it in case it does not exit.
        self.writer = None;
        let _ = self.child.kill();
        let _ = self.child.wait();
        if let Some(t) = self.stderr_thread.take() {
            let _ = t.join();
        }
    }
}

#[cfg(test)]
mod batch_tests {
    use super::*;

    /// Building a snapshot reads the (virtual) project file through a
    /// callback; inside a batch the compiler cannot be answered, and the
    /// batch fails with the channel marked, not with a hang or a mix-up.
    #[test]
    fn a_callback_during_a_batch_ends_it() {
        let crate_dir = Path::new(env!("CARGO_MANIFEST_DIR"));
        let Some(exe) = super::super::locate::for_tests(crate_dir) else {
            eprintln!("skipped: no TypeScript compiler");
            return;
        };
        let dir =
            std::env::temp_dir().join(format!("qt-tsc-batch-callback-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        std::fs::write(dir.join("a.ts"), "export interface A { a: string }\n").unwrap();
        let config = format!("{}/virtual.json", dir.to_string_lossy());
        let files = vec![(config.clone(), r#"{"files":["a.ts"]}"#.to_owned())];
        let mut ch = Channel::spawn(&exe, &dir, files).unwrap();
        ch.request("initialize", b"null").unwrap();
        let snapshot = serde_json::json!({ "openProjects": [config] }).to_string();
        let result = ch.request_batch(&[
            ("updateSnapshot", snapshot.into_bytes()),
            ("initialize", b"null".to_vec()),
        ]);
        let err = result.unwrap_err().message();
        assert!(ch.called_back_in_batch(), "{err}");
        assert!(err.contains("called back (`readFile`)"), "{err}");
        drop(ch);
        std::fs::remove_dir_all(&dir).unwrap();
    }
}

#[cfg(all(test, unix))]
mod tests {
    use super::*;
    use std::os::unix::fs::PermissionsExt;

    #[test]
    fn a_crashing_compiler_is_reported_with_its_stderr() {
        let dir = std::env::temp_dir().join(format!("qt-tsc-crash-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let exe = dir.join("tsc");
        std::fs::write(&exe, "#!/bin/sh\necho 'panic: boom' >&2\nexit 3\n").unwrap();
        std::fs::set_permissions(&exe, std::fs::Permissions::from_mode(0o755)).unwrap();
        // Another test thread forking while the script was still open for
        // writing can make exec fail with ETXTBSY ("Text file busy") for a
        // moment, a race of tests in one process on Linux: retry.
        let mut ch = None;
        for _ in 0..50 {
            match Channel::spawn(&exe, &dir, Vec::new()) {
                Ok(c) => {
                    ch = Some(c);
                    break;
                }
                Err(e) if e.message().contains("Text file busy") => {
                    std::thread::sleep(std::time::Duration::from_millis(20));
                }
                Err(e) => panic!("{}", e.message()),
            }
        }
        let mut ch = ch.expect("the script stayed busy");
        let err = ch.request("initialize", b"null").unwrap_err().message();
        drop(ch);
        std::fs::remove_dir_all(&dir).unwrap();
        assert!(err.contains("compiler exited"), "{err}");
        assert!(err.ends_with("panic: boom"), "{err}");
    }

    /// A file that is executable but not a program for this system: the
    /// spawn fails with ENOEXEC, or the C library hands the file to
    /// /bin/sh, which exits with 126. Either way the error names the file
    /// and what to install.
    #[test]
    fn a_compiler_that_is_not_a_program_is_reported_as_such() {
        let dir = crate::testing::ScratchDir::new("channel-not-a-program");
        let exe = dir.join("tsc");
        std::fs::write(&exe, b"\x7fELF\x00\x01\x02 not a program").unwrap();
        std::fs::set_permissions(&exe, std::fs::Permissions::from_mode(0o755)).unwrap();
        let mut err = None;
        for _ in 0..50 {
            match Channel::spawn(&exe, &dir, Vec::new()) {
                Ok(mut ch) => {
                    err = Some(ch.request("initialize", b"null").unwrap_err().message());
                    break;
                }
                Err(e) if e.message().contains("Text file busy") => {
                    std::thread::sleep(std::time::Duration::from_millis(20));
                }
                Err(e) => {
                    err = Some(e.message());
                    break;
                }
            }
        }
        let err = err.expect("the file stayed busy");
        assert!(
            err.starts_with(&format!(
                "could not start the TypeScript compiler {}: ",
                exe.display()
            )),
            "{err}"
        );
        assert!(
            err.contains(": it is not a program for this system. "),
            "{err}"
        );
    }
}
