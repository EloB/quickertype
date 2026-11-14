//! Not a quicktype file: the scan of string bodies that both JSON readers
//! share, the stream tokenizer
//! ([`compressed_json_from_stream`](super::compressed_json_from_stream))
//! and the `JSON.parse` reader (`compressed_json::from_string`). It reads
//! eight bytes at a time.

/// Whether a run of plain string characters ends at this byte: `"`, `\`
/// or a control character. stream-json's string state matches runs of
/// `[^\x00-\x1f\"\\]`, and `JSON.parse` rejects a raw control character,
/// so both readers stop at the same bytes. Every other byte is plain,
/// including all those of multi-byte UTF-8 sequences (0x80 and above).
pub(crate) fn is_string_stop(b: u8) -> bool {
    b < 0x20 || b == b'"' || b == b'\\'
}

/// The high bit of each byte of `word` (eight bytes, little-endian) that
/// is a [string stop](is_string_stop), exact for the lowest such byte.
///
/// Each test subtracts from all eight bytes at once. A byte that borrows
/// may make the byte above it look like a stop too, but a borrow only
/// moves upward, and no byte borrows before the first stop. So no byte
/// below the first stop is flagged, the first stop is, and only the
/// bytes above it may be flagged wrongly.
#[inline]
fn string_stops(word: u64) -> u64 {
    const ONES: u64 = u64::from_ne_bytes([1; 8]);
    const HIGH: u64 = ONES << 7;
    // The bytes of `v` below `n`, for `n` at most 0x80: they borrow, and
    // their high bit was clear.
    let below = |v: u64, n: u8| v.wrapping_sub(ONES * u64::from(n)) & !v & HIGH;
    // A byte equal to `b` is zero after `^`, so below 1.
    let equal = |b: u8| below(word ^ (ONES * u64::from(b)), 1);
    equal(b'"') | equal(b'\\') | below(word, 0x20)
}

/// Where the run of plain string characters from `pos` ends: the first
/// [string stop](is_string_stop) at or after `pos`, or `bytes.len()`.
/// It tests eight bytes at a time while eight are left, and the rest one
/// by one.
#[inline]
pub(crate) fn plain_run(bytes: &[u8], mut pos: usize) -> usize {
    while let Some(word) = bytes.get(pos..).and_then(<[u8]>::first_chunk::<8>) {
        let stops = string_stops(u64::from_le_bytes(*word));
        if stops != 0 {
            // The lowest set bit is the first stop's high bit.
            return pos + (stops.trailing_zeros() / 8) as usize;
        }
        pos += 8;
    }
    while bytes.get(pos).is_some_and(|&b| !is_string_stop(b)) {
        pos += 1;
    }
    pos
}

#[cfg(test)]
mod tests {
    use super::*;

    /// One byte at a time, as the readers scanned before.
    fn bytewise(bytes: &[u8], pos: usize) -> usize {
        (pos..bytes.len())
            .find(|&i| is_string_stop(bytes[i]))
            .unwrap_or(bytes.len())
    }

    #[test]
    fn stop_bytes() {
        let stops: Vec<u8> = (0..=255).filter(|&b| is_string_stop(b)).collect();
        let mut expected: Vec<u8> = (0..0x20).collect();
        expected.extend_from_slice(b"\"\\");
        assert_eq!(stops, expected);
    }

    /// Every byte value at every position of a word is flagged as the
    /// lowest stop exactly when it is a stop, whatever the plain bytes
    /// around it (just above and below the stops' values, and 0x80 and
    /// above).
    #[test]
    fn each_byte_in_a_word() {
        for fill in [b'a', b' ', b'!', b'#', b'[', b']', 0x7F, 0x80, 0xC3, 0xFF] {
            for b in 0..=255u8 {
                for at in 0..8 {
                    let mut word = [fill; 8];
                    word[at] = b;
                    let stops = string_stops(u64::from_le_bytes(word));
                    let lowest = (stops != 0).then(|| (stops.trailing_zeros() / 8) as usize);
                    let expected = is_string_stop(b).then_some(at);
                    assert_eq!(lowest, expected, "byte {b:#04x} at {at} among {fill:#04x}");
                }
            }
        }
    }

    /// Every stop at every offset from the start of the scan, in slices
    /// of every length up to three words and a bit (so the stop is in a
    /// word or in the byte-wise tail), from every start up to a word in
    /// (the scan's words need not be aligned to the slice).
    #[test]
    fn one_stop_at_every_offset() {
        let stops: Vec<u8> = (0..=255u8).filter(|&b| is_string_stop(b)).collect();
        for fill in [b'a', 0xC3] {
            for len in 0..=26 {
                for start in 0..=len.min(9) {
                    let mut bytes = vec![fill; len];
                    assert_eq!(plain_run(&bytes, start), len, "no stop");
                    for at in start..len {
                        for &stop in &stops {
                            bytes[at] = stop;
                            assert_eq!(plain_run(&bytes, start), at, "{bytes:?} from {start}");
                        }
                        bytes[at] = fill;
                    }
                }
            }
        }
    }

    /// A stop at every offset of the first two words, from every start,
    /// with a second byte of any value at each of the next eight
    /// positions: a borrow out of the stop can flag the bytes above it,
    /// never one below, so the first stop is still the one found.
    #[test]
    fn a_later_byte_never_hides_the_first_stop() {
        for start in 0..8 {
            for at in start..start + 16 {
                for first in [0x00, 0x01, b'\n', 0x1F, b'"', b'\\'] {
                    let mut bytes = vec![b'a'; start + 26];
                    bytes[at] = first;
                    for later in at + 1..=at + 8 {
                        for second in 0..=255u8 {
                            bytes[later] = second;
                            assert_eq!(plain_run(&bytes, start), at, "{bytes:?} from {start}");
                        }
                        bytes[later] = b'a';
                    }
                }
            }
        }
    }

    /// Random bytes, mostly plain with stops and bytes next to them in
    /// value, against the byte-wise scan from every start.
    #[test]
    fn random_bytes() {
        let mut state: u64 = 0x9E37_79B9_7F4A_7C15;
        let mut next = move || {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            state
        };
        let palette = [
            0x00, 0x01, 0x1F, 0x20, 0x21, b'"', 0x23, 0x5B, b'\\', 0x5D, b'a', 0x7F, 0x80, 0xA2,
            0xC3, 0xFF,
        ];
        for _ in 0..20_000 {
            let len = (next() % 40) as usize;
            let density = next() % 16 + 1;
            let bytes: Vec<u8> = (0..len)
                .map(|_| {
                    let r = next();
                    if r % density == 0 {
                        palette[(r >> 8) as usize % palette.len()]
                    } else {
                        b'a' + (r >> 8) as u8 % 26
                    }
                })
                .collect();
            for start in 0..=len {
                assert_eq!(
                    plain_run(&bytes, start),
                    bytewise(&bytes, start),
                    "{bytes:?}"
                );
            }
        }
    }
}
