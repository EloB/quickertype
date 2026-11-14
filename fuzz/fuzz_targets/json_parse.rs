//! The `JSON.parse` port (`quicktype_js_compat::json`) and the API's
//! JSON reader on it (`CompressedJson::parse_string`), on arbitrary text.
//! What parses must survive `JSON.stringify` and parse again to the same
//! value. As JSON Lines (`JsonSample::StringLines`), the reader must accept
//! what the port's `parse_lines` accepts, and fail with a syntax error
//! where it fails.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_core::JsonSample;
use quicktype_core::date_time::DefaultDateTimeRecognizer;
use quicktype_core::input::compressed_json::{CompressedJson, ParseError};
use quicktype_js_compat::json;

fuzz_target!(|data: &[u8]| {
    let Some((&flags, rest)) = data.split_first() else {
        return;
    };
    let text = quicktype_fuzz::text(rest);

    if let Ok(value) = json::parse(&text) {
        let compact = json::stringify(&value, None);
        let again = json::parse(&compact).expect("JSON.stringify output parses");
        assert_eq!(json::stringify(&again, None), compact);
        let _ = json::stringify(&value, Some("  "));
    }

    let mut cjson =
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), flags & 1 != 0);
    let _ = cjson.parse_string(&text);

    if flags & 2 != 0 {
        let lines = json::parse::parse_lines(&text);
        match cjson.parse_sample(JsonSample::StringLines(text)) {
            Ok(_) => assert!(lines.is_ok(), "the reader accepts what parse_lines rejects"),
            Err(ParseError::Js(e)) => {
                let lines = lines.expect_err("the reader rejects what parse_lines accepts");
                assert_eq!(
                    e.message(),
                    format!("line {}: {}", lines.line, lines.error.message())
                );
            }
            Err(_) => {}
        }
    }
});
