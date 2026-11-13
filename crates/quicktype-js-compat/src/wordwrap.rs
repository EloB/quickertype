//! Port of the npm package `wordwrap` 1.0.0 in its default "soft" mode.
//!
//! quicktype wraps description comments with `wordwrap(90)` (start column 0,
//! stop column 90). The algorithm, faithfully reproduced:
//!
//! 1. Split the text with `text.split(/(\S+\s+)/)`, which keeps the captured
//!    word-plus-trailing-whitespace chunks, and skip the empty pieces.
//! 2. Start with one line of `start` spaces. For each chunk, with every tab
//!    replaced by four spaces: if the current line plus the chunk would exceed
//!    `stop` UTF-16 code units, strip the line's trailing whitespace and start
//!    a new line for every `\n`-separated piece of the chunk (its leading
//!    whitespace stripped). Otherwise, if the chunk contains `\n`, append its
//!    first piece and start new lines for the rest; otherwise append it.
//! 3. Join the lines with `\n`.
//!
//! Quirks that fall out of this and are kept: an over-long first chunk leaves
//! the first line empty, so the result starts with `\n`; words longer than
//! the width are never broken; and `\s`/`\S` are JavaScript's whitespace (see
//! [`crate::whitespace`]), so U+00A0 and U+FEFF are break opportunities while
//! U+0085 is not.
//!
//! Out of scope: the "hard" mode (`wordwrap.hard`), which quicktype never uses.

use crate::{utf16, whitespace};

/// A soft word wrapper, `require("wordwrap")(start, stop)`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct WordWrap {
    start: usize,
    stop: usize,
}

impl WordWrap {
    /// `wordwrap(width)`: wrap at column `width`, with no indentation.
    pub fn new(width: usize) -> Self {
        Self::with_start(width, 0)
    }

    /// `wordwrap(start, stop)`: indent every line by `start` spaces and wrap
    /// at column `stop`. As in JavaScript, a `stop` of 0 means
    /// `wordwrap(start)`.
    pub fn with_start(start: usize, stop: usize) -> Self {
        if stop == 0 {
            Self {
                start: 0,
                stop: start,
            }
        } else {
            Self { start, stop }
        }
    }

    /// Wraps `text`.
    pub fn wrap(&self, text: &str) -> String {
        let indent = " ".repeat(self.start);
        // Finished lines, and the current (last) line with its UTF-16 length.
        let mut lines = Vec::new();
        let mut line = indent.clone();
        let mut line_len = self.start;
        for raw_chunk in chunks(text) {
            let chunk = raw_chunk.replace('\t', "    ");
            let chunk_len = utf16::len(&chunk);
            if line_len + chunk_len > self.stop {
                line.truncate(whitespace::trim_end(&line).len());
                for piece in chunk.split('\n') {
                    let next = format!("{indent}{}", whitespace::trim_start(piece));
                    lines.push(std::mem::replace(&mut line, next));
                }
                line_len = utf16::len(&line);
            } else if chunk.contains('\n') {
                let mut pieces = chunk.split('\n');
                if let Some(first) = pieces.next() {
                    line.push_str(first);
                }
                for piece in pieces {
                    let next = format!("{indent}{}", whitespace::trim_start(piece));
                    lines.push(std::mem::replace(&mut line, next));
                }
                line_len = utf16::len(&line);
            } else {
                line.push_str(&chunk);
                line_len += chunk_len;
            }
        }
        lines.push(line);
        lines.join("\n")
    }
}

/// The non-empty pieces of `text.split(/(\S+\s+)/)`: an optional run of
/// leading whitespace, then each word with its trailing whitespace, then a
/// final word that has none.
fn chunks(text: &str) -> Vec<&str> {
    let mut chunks = Vec::new();
    let mut rest = text;
    let leading = rest.len() - whitespace::trim_start(rest).len();
    if leading > 0 {
        chunks.push(&rest[..leading]);
        rest = &rest[leading..];
    }
    while !rest.is_empty() {
        let word_end = rest.find(whitespace::is_whitespace).unwrap_or(rest.len());
        let after_word = &rest[word_end..];
        let chunk_end = word_end + (after_word.len() - whitespace::trim_start(after_word).len());
        chunks.push(&rest[..chunk_end]);
        rest = &rest[chunk_end..];
    }
    chunks
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn wraps_at_width() {
        let wrap = WordWrap::new(10);
        assert_eq!(wrap.wrap("aaa bbb ccc ddd"), "aaa bbb\nccc ddd");
        assert_eq!(wrap.wrap("abcdefghijklmnop x"), "\nabcdefghijklmnop\nx");
        assert_eq!(wrap.wrap("a\n  b"), "a\nb");
        assert_eq!(wrap.wrap(""), "");
    }

    #[test]
    fn split_keeps_captures() {
        assert_eq!(chunks("  a  b c"), ["  ", "a  ", "b ", "c"]);
        assert_eq!(chunks("a"), ["a"]);
        assert_eq!(chunks("   "), ["   "]);
    }
}
