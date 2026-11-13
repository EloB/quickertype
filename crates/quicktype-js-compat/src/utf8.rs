//! Node's UTF-8 decoding of bytes into a string (`buffer.toString("utf8")`,
//! a stream with `setEncoding("utf8")`): every ill-formed sequence becomes
//! U+FFFD, one per maximal subpart, which is what `String::from_utf8_lossy`
//! does.
//!
//! Inputs are nearly always valid UTF-8, so both functions validate first
//! (much faster than the lossy decoder) and take valid text as it is.

use std::borrow::Cow;

/// `bytes` decoded as UTF-8, borrowed if they are valid.
pub fn decode(bytes: &[u8]) -> Cow<'_, str> {
    match std::str::from_utf8(bytes) {
        Ok(text) => Cow::Borrowed(text),
        Err(_) => String::from_utf8_lossy(bytes),
    }
}

/// `bytes` decoded as UTF-8; valid bytes become the string without being
/// copied.
pub fn decode_owned(bytes: Vec<u8>) -> String {
    String::from_utf8(bytes).unwrap_or_else(|e| String::from_utf8_lossy(e.as_bytes()).into_owned())
}

/// Node's `StringDecoder("utf8")` (a stream with `setEncoding("utf8")`):
/// decodes a byte stream chunk by chunk with exactly the result of
/// [`decode`] on all of it. A sequence cut off at the end of a chunk waits
/// for the next one; one still incomplete at the end of the stream is one
/// U+FFFD. (Node's decoder agrees with decoding the whole buffer at every
/// split point: 600,000 random splits of ill-formed input found no
/// difference on Node 24.)
#[derive(Clone, Debug, Default)]
pub struct Decoder {
    /// The start of a multi-byte sequence the last chunk ended in (at most
    /// three bytes, valid so far).
    pending: Vec<u8>,
}

impl Decoder {
    /// A decoder at the start of a stream.
    pub fn new() -> Self {
        Self::default()
    }

    /// Decodes the next chunk of the stream onto `out`.
    pub fn push(&mut self, chunk: &[u8], out: &mut String) {
        let mut rest = chunk;
        if !self.pending.is_empty() {
            // Complete (or reject) the pending sequence with the first bytes
            // of the chunk: at most four more decide its fate.
            let pending = self.pending.len();
            let mut joined = std::mem::take(&mut self.pending);
            joined.extend_from_slice(&chunk[..chunk.len().min(4)]);
            let consumed = match std::str::from_utf8(&joined) {
                Ok(text) => {
                    out.push_str(text);
                    joined.len()
                }
                Err(e) if e.valid_up_to() > 0 => {
                    // The pending sequence completed into a character.
                    let valid = e.valid_up_to();
                    out.push_str(std::str::from_utf8(&joined[..valid]).unwrap_or_default());
                    valid
                }
                Err(e) => match e.error_len() {
                    Some(len) => {
                        out.push(char::REPLACEMENT_CHARACTER);
                        len.max(pending)
                    }
                    None => {
                        // Still incomplete: the chunk was too short.
                        self.pending = joined;
                        return;
                    }
                },
            };
            rest = &chunk[consumed - pending..];
        }
        loop {
            match std::str::from_utf8(rest) {
                Ok(text) => {
                    out.push_str(text);
                    return;
                }
                Err(e) => {
                    let valid = e.valid_up_to();
                    out.push_str(std::str::from_utf8(&rest[..valid]).unwrap_or_default());
                    match e.error_len() {
                        Some(len) => {
                            out.push(char::REPLACEMENT_CHARACTER);
                            rest = &rest[valid + len..];
                        }
                        None => {
                            self.pending = rest[valid..].to_vec();
                            return;
                        }
                    }
                }
            }
        }
    }

    /// Ends the stream: a sequence it ended in becomes U+FFFD.
    pub fn finish(&mut self, out: &mut String) {
        if !self.pending.is_empty() {
            self.pending.clear();
            out.push(char::REPLACEMENT_CHARACTER);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Decoding in chunks of every size, from every offset, gives what
    /// decoding everything at once gives.
    #[test]
    fn chunked_decoding_is_whole_decoding() {
        let pool: &[u8] = &[
            0x41, 0x80, 0x8F, 0x9F, 0xA0, 0xBF, 0xC0, 0xC2, 0xDF, 0xE0, 0xE1, 0xED, 0xEF, 0xF0,
            0xF1, 0xF4, 0xF5, 0xFF, 0x90, 0x22,
        ];
        let mut seed: u64 = 0x5EED;
        let mut next = |n: usize| {
            seed = seed
                .wrapping_mul(6_364_136_223_846_793_005)
                .wrapping_add(1_442_695_040_888_963_407);
            (seed >> 33) as usize % n
        };
        let mut samples: Vec<Vec<u8>> = vec!["aé😀€".as_bytes().to_vec()];
        for _ in 0..3000 {
            let len = 1 + next(10);
            samples.push((0..len).map(|_| pool[next(pool.len())]).collect());
        }
        for bytes in &samples {
            let whole = decode(bytes);
            for size in 1..=bytes.len() {
                let mut decoder = Decoder::new();
                let mut out = String::new();
                for chunk in bytes.chunks(size) {
                    decoder.push(chunk, &mut out);
                }
                decoder.finish(&mut out);
                assert_eq!(out, whole, "{bytes:02X?} in chunks of {size}");
            }
            // Two chunks, split anywhere.
            for cut in 0..=bytes.len() {
                let mut decoder = Decoder::new();
                let mut out = String::new();
                decoder.push(&bytes[..cut], &mut out);
                decoder.push(&bytes[cut..], &mut out);
                decoder.finish(&mut out);
                assert_eq!(out, whole, "{bytes:02X?} cut at {cut}");
            }
        }
    }

    #[test]
    fn valid_text_is_kept_and_invalid_sequences_are_replaced() {
        assert!(matches!(decode("aé😀".as_bytes()), Cow::Borrowed("aé😀")));
        assert_eq!(decode_owned("aé😀".as_bytes().to_vec()), "aé😀");
        // A truncated sequence is one U+FFFD; a stray continuation byte and
        // an invalid lead byte are one each.
        let bytes = b"a\xE2\x82b\x80c\xFFd";
        assert_eq!(decode(bytes), "a\u{FFFD}b\u{FFFD}c\u{FFFD}d");
        assert_eq!(decode_owned(bytes.to_vec()), "a\u{FFFD}b\u{FFFD}c\u{FFFD}d");
    }
}
