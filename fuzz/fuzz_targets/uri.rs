//! The urijs port (`quicktype_js_compat::uri`): parsing, every accessor,
//! `normalize`, `absoluteTo`, `equals`, the setters and the component
//! coders, on arbitrary text. Input: the URI, then optionally a newline
//! and a base URI.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_js_compat::uri::{self, Uri};

const BASES: &[&str] = &[
    "",
    "test.json",
    "dir/sub/t.json",
    "/abs/x.json",
    "http://h/",
    "http://ex.com/a/b/c.json",
    "urn:///x:y",
    "a?q=1",
];

fuzz_target!(|data: &[u8]| {
    let (input, base) = quicktype_fuzz::first_line(data);
    let input = quicktype_fuzz::text(input);
    let base = quicktype_fuzz::text(base);

    let _ = uri::decode_uri_component(&input);
    let _ = uri::encode_uri_component(&input);
    let _ = uri::strict_encode_uri_component(&input);
    let _ = uri::encode_path_segment(&input);
    let _ = uri::decode_path_segment(&input);
    let _ = uri::recode_path(&input);

    let Ok(parsed) = Uri::parse(&input) else {
        return;
    };
    exercise(&parsed);

    let mut bases: Vec<Uri> = BASES.iter().filter_map(|b| Uri::parse(b).ok()).collect();
    if let Ok(b) = Uri::parse(&base) {
        exercise(&b);
        let _ = b.absolute_to(&parsed);
        bases.push(b);
    }
    for b in &bases {
        if let Ok(absolute) = parsed.absolute_to(b) {
            exercise(&absolute);
        }
        let _ = parsed.equals(b);
        let _ = b.equals(&parsed);
    }
    let _ = parsed.equals(&parsed);
});

fn exercise(u: &Uri) {
    let _ = u.to_string();
    let _ = (u.protocol(), u.hostname(), u.host(), u.is_urn(), u.path());
    let _ = (
        u.query(),
        u.fragment(),
        u.hash(),
        u.filename(),
        u.suffix(),
        u.directory(),
    );
    let mut normalized = u.js_clone();
    if normalized.normalize().is_ok() {
        let _ = normalized.to_string();
    }
    let mut set = u.js_clone();
    let _ = set.set_path("My Type-1");
    set.set_fragment("/definitions/a");
    set.set_query("a=b");
    let _ = set.to_string();
    let mut set = u.js_clone();
    let _ = set.set_path(u.path());
    let _ = set.set_path(&format!("{}-1", u.path()));
    set.set_fragment(u.fragment());
    let _ = set.to_string();
}
