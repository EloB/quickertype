//! The CLI's streaming JSON reader (stream-json semantics,
//! `input/compressed_json_from_stream.rs`) on arbitrary bytes, read whole
//! and in tiny chunks: both must give the same compressed value or error,
//! since chunk boundaries cannot change the result.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_core::date_time::DefaultDateTimeRecognizer;
use quicktype_core::input::compressed_json::CompressedJson;
use quicktype_fuzz::Trickle;

fuzz_target!(|data: &[u8]| {
    // The first byte picks `handleRefs` (strings under `"$ref"` are kept).
    let Some((&flags, sample)) = data.split_first() else {
        return;
    };
    let handle_refs = flags & 1 != 0;

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
