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

#[cfg(test)]
mod tests {
    use super::*;

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
