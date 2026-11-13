//! Replays the urijs 1.19.11 vectors recorded from Node by
//! `xtask/core-json-schema-input/gen-uri-vectors.mjs`: parsing and every
//! accessor, `clone`, `normalize`, `URI.decode` of the normalized string,
//! `absoluteTo` against several bases, the setters, `equals`, the
//! `encodeURIComponent`/`decodeURIComponent` family and `Number(string)`.

use std::path::Path;

use quicktype_js_compat::number;
use quicktype_js_compat::uri::{
    self, Uri, UriError, decode_path_segment, decode_uri_component, encode_uri_component,
    recode_path, strict_encode_uri_component,
};
use serde_json::Value;

fn load() -> Value {
    let path = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/vectors/uri.json");
    let text = std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    serde_json::from_str(&text).unwrap_or_else(|e| panic!("{}: {e}", path.display()))
}

fn s(v: &Value) -> &str {
    v.as_str()
        .unwrap_or_else(|| panic!("expected a string, got {v}"))
}

/// `{ok: x}` or `{err: "Name: message"}` as recorded by `attempt`.
fn outcome(v: &Value) -> Result<String, String> {
    match (v.get("ok"), v.get("err")) {
        (Some(ok), _) => Ok(match ok {
            Value::String(x) => x.clone(),
            other => other.to_string(),
        }),
        (_, Some(err)) => Err(s(err).to_owned()),
        _ => panic!("bad outcome {v}"),
    }
}

fn ours<T: ToString>(r: uri::Result<T>) -> Result<String, String> {
    r.map(|x| x.to_string())
        .map_err(|e: UriError| e.to_string())
}

#[derive(Default)]
struct Mismatches(Vec<String>, usize);

impl Mismatches {
    fn check(
        &mut self,
        what: impl FnOnce() -> String,
        got: Result<String, String>,
        want: Result<String, String>,
    ) {
        self.1 += 1;
        if got != want {
            self.0
                .push(format!("{}: got {got:?}, want {want:?}", what()));
        }
    }

    fn finish(self, name: &str) {
        assert!(
            self.0.is_empty(),
            "{name}: {} of {} checks differ:\n{}",
            self.0.len(),
            self.1,
            self.0
                .iter()
                .take(40)
                .cloned()
                .collect::<Vec<_>>()
                .join("\n")
        );
    }
}

#[test]
fn uris_match_urijs() {
    let vectors = load();
    let bases: Vec<Uri> = vectors["bases"]
        .as_array()
        .unwrap()
        .iter()
        .map(|b| Uri::parse(s(b)).unwrap())
        .collect();
    let mut m = Mismatches::default();
    for entry in vectors["uris"].as_array().unwrap() {
        let input = s(&entry["input"]);
        let parsed = Uri::parse(input);
        let want = &entry["parse"];
        let Some(fields) = want.get("ok") else {
            m.check(
                || format!("parse {input:?}"),
                ours(parsed.map(|_| "")),
                outcome(want),
            );
            continue;
        };
        let u = match parsed {
            Ok(u) => u,
            Err(e) => {
                m.check(
                    || format!("parse {input:?}"),
                    Err(e.to_string()),
                    Ok(String::new()),
                );
                continue;
            }
        };
        let accessors: [(&str, String); 10] = [
            ("s", u.to_string()),
            ("protocol", u.protocol().to_owned()),
            ("host", u.host()),
            ("path", u.path().to_owned()),
            ("query", u.query().to_owned()),
            ("fragment", u.fragment().to_owned()),
            ("hash", u.hash()),
            ("filename", u.filename().to_owned()),
            ("suffix", u.suffix().to_owned()),
            ("directory", u.directory().to_owned()),
        ];
        for (name, got) in accessors {
            m.check(
                || format!("{name} of {input:?}"),
                Ok(got),
                Ok(s(&fields[name]).to_owned()),
            );
        }
        m.check(
            || format!("clone {input:?}"),
            Ok(u.js_clone().to_string()),
            Ok(s(&entry["clone"]).to_owned()),
        );
        let normalized = {
            let mut n = u.js_clone();
            n.normalize().map(|()| n)
        };
        m.check(
            || format!("normalize {input:?}"),
            ours(normalized.clone()),
            outcome(&entry["normalize"]),
        );
        m.check(
            || format!("decode(normalize) {input:?}"),
            ours(normalized.and_then(|n| decode_uri_component(&n.to_string()))),
            outcome(&entry["decodeNormalized"]),
        );
        for (base, want) in bases.iter().zip(entry["absoluteTo"].as_array().unwrap()) {
            m.check(
                || format!("{input:?} absoluteTo {base}"),
                ours(u.absolute_to(base)),
                outcome(want),
            );
        }
        let mut with_path = u.js_clone();
        m.check(
            || format!("path() of {input:?}"),
            ours(with_path.set_path("My Type-1").map(|()| with_path)),
            outcome(&entry["setPath"]),
        );
        let mut with_fragment = u.js_clone();
        with_fragment.set_fragment("#/x");
        with_fragment.set_fragment("");
        m.check(
            || format!("fragment() of {input:?}"),
            Ok(with_fragment.to_string()),
            Ok(s(&entry["setFragment"]).to_owned()),
        );
        let mut with_query = u.js_clone();
        with_query.set_query("?a=b");
        m.check(
            || format!("query() of {input:?}"),
            Ok(with_query.to_string()),
            Ok(s(&entry["setQuery"]).to_owned()),
        );
    }
    m.finish("uris");
}

#[test]
fn equals_matches_urijs() {
    let vectors = load();
    let mut m = Mismatches::default();
    for case in vectors["equals"].as_array().unwrap() {
        let (a, b) = (s(&case["a"]), s(&case["b"]));
        let got = ours(Uri::parse(a).and_then(|x| x.equals(&Uri::parse(b)?)));
        m.check(
            || format!("{a:?} equals {b:?}"),
            got,
            outcome(&case["result"]),
        );
    }
    m.finish("equals");
}

#[test]
fn components_match_javascript() {
    let vectors = load();
    let mut m = Mismatches::default();
    for case in vectors["components"].as_array().unwrap() {
        let input = s(&case["input"]);
        m.check(
            || format!("encodeURIComponent({input:?})"),
            Ok(encode_uri_component(input)),
            Ok(s(&case["encode"]).to_owned()),
        );
        m.check(
            || format!("URI.encode({input:?})"),
            Ok(strict_encode_uri_component(input)),
            Ok(s(&case["strictEncode"]).to_owned()),
        );
        m.check(
            || format!("decodeURIComponent({input:?})"),
            ours(decode_uri_component(input)),
            outcome(&case["decode"]),
        );
        m.check(
            || format!("URI.recodePath({input:?})"),
            ours(recode_path(input)),
            outcome(&case["recodePath"]),
        );
        m.check(
            || format!("URI.decodePathSegment({input:?})"),
            Ok(decode_path_segment(input)),
            Ok(s(&case["decodePathSegment"]).to_owned()),
        );
    }
    m.finish("components");
}

#[test]
fn string_to_number_matches_javascript() {
    let vectors = load();
    let mut m = Mismatches::default();
    for case in vectors["numbers"].as_array().unwrap() {
        let input = s(&case["input"]);
        m.check(
            || format!("Number({input:?})"),
            Ok(number::to_string(number::string_to_number(input))),
            Ok(s(&case["value"]).to_owned()),
        );
    }
    m.finish("numbers");
}
