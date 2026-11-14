//! The CLI's streaming JSON reader (stream-json semantics,
//! `input/compressed_json_from_stream.rs`) on arbitrary bytes, read whole
//! and in tiny chunks: both must give the same compressed value or error,
//! since chunk boundaries cannot change the result. Also read as JSON
//! Lines (`JsonSample::StreamLines` and `ReaderLines`), whose errors name
//! a line, which chunk boundaries cannot change either.

#![no_main]

use std::io::Read;

use libfuzzer_sys::fuzz_target;
use quicktype_core::date_time::DefaultDateTimeRecognizer;
use quicktype_core::input::compressed_json::CompressedJson;
use quicktype_core::{JsonSample, SampleReader};
use quicktype_fuzz::Trickle;

/// [`Trickle`] over bytes of its own, for a [`SampleReader`]: 1 to 7
/// bytes at a time.
struct OwnedTrickle {
    data: Vec<u8>,
    at: usize,
    step: usize,
}

impl Read for OwnedTrickle {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        self.step = self.step % 7 + 1;
        let rest = &self.data[self.at..];
        let n = self.step.min(buf.len()).min(rest.len());
        buf[..n].copy_from_slice(&rest[..n]);
        self.at += n;
        Ok(n)
    }
}

fuzz_target!(|data: &[u8]| {
    // The first byte picks `handleRefs` (strings under `"$ref"` are kept),
    // and whether the bytes are also read as JSON Lines.
    let Some((&flags, sample)) = data.split_first() else {
        return;
    };
    let handle_refs = flags & 1 != 0;

    if flags & 2 != 0 {
        let mut whole =
            CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs);
        let a = whole.parse_sample(JsonSample::StreamLines(sample.to_vec()));
        let mut chunked =
            CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs);
        let b = chunked.parse_sample(JsonSample::ReaderLines(SampleReader::new(OwnedTrickle {
            data: sample.to_vec(),
            at: 0,
            step: 0,
        })));
        assert_eq!(a, b, "whole and chunked reads of JSON Lines differ");
        if let Ok(root) = a {
            assert_eq!(whole.to_tables(&[root]), chunked.to_tables(&[root]));
        }
    }

    let mut whole =
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs);
    let a = whole.parse_stream(sample);

    let mut chunked =
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs);
    let b = chunked.parse_stream_reader(&mut Trickle::new(sample));

    assert_eq!(a, b, "whole and chunked reads differ");
    if let Ok(root) = a {
        assert_eq!(whole.to_tables(&[root]), chunked.to_tables(&[root]));
    }

    // A second sample on the same builder, as for several samples of one
    // source.
    let _ = whole.parse_stream(sample);
});
