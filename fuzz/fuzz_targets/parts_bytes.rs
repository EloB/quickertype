//! A large sample read in parts on several WebAssembly instances
//! (`input/parts.rs`): each instance hands its parts' tallies to another as
//! bytes, which that one appends. Bytes that are not such tallies (here:
//! real ones, corrupted) must give an error, or some tallies that append,
//! never a panic, and never an allocation the bytes do not account for.
//!
//! Header: byte 0 the number of corruptions (0 to 15), byte 1 flags (bit 0
//! JSON Lines, bit 1 `handleRefs`); then, for each corruption, two bytes of
//! where (little-endian, modulo the bytes' length) and the bytes to put
//! there: one byte, or with its high bit set, a count of 2^31 or 2^63
//! (the low bit picks which). The rest is the part's text, read as the
//! elements of an array (or JSON Lines), whose tallies' bytes are
//! corrupted and appended after a part read before them.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_core::date_time::DefaultDateTimeRecognizer;
use quicktype_core::input::compressed_json::{CompressedJson, StringSampleLimits};
use quicktype_core::input::parts::PartTallies;

fuzz_target!(|data: &[u8]| {
    let [corruptions, flags, rest @ ..] = data else {
        return;
    };
    let (lines, handle_refs) = (flags & 1 != 0, flags & 2 != 0);
    let count = usize::from(corruptions % 16);
    if rest.len() < 3 * count {
        return;
    }
    let (edits, part) = rest.split_at(3 * count);
    let limits = StringSampleLimits {
        max_depth: Some(256),
        lone_surrogates: false,
    };
    let config =
        || CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs);
    let mut there = PartTallies::new(config(), limits);
    if there.read(part, lines, false, false).is_err() {
        return;
    }
    let Ok(mut bytes) = there.export() else {
        return;
    };
    for edit in edits.chunks(3) {
        let at = usize::from(u16::from_le_bytes([edit[0], edit[1]])) % bytes.len();
        let value = edit[2];
        if value & 0x80 == 0 {
            bytes[at] = value;
        } else {
            let huge: &[u8] = if value & 1 == 0 {
                &[0x80, 0x80, 0x80, 0x80, 0x08]
            } else {
                &[0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00]
            };
            bytes.splice(at..at + 1, huge.iter().copied());
        }
    }
    let mut here = PartTallies::new(config(), limits);
    let first: &[u8] = if lines {
        b"{\"a\": [1, \"x\"], \"b\": {}}\n"
    } else {
        b"{\"a\": [1, \"x\"], \"b\": {}}"
    };
    if here.read(first, lines, true, false).is_ok() {
        let _ = here.append(&bytes);
        let _ = here.into_shared();
    }
});
