//! `YAML.parse` (`quicktype_js_compat::yaml`) and `parseJSON` (JSON, else
//! YAML) on arbitrary text.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_js_compat::{json, yaml};

fuzz_target!(|data: &[u8]| {
    let text = quicktype_fuzz::text(data);
    if let Ok(value) = yaml::parse(&text) {
        let _ = json::stringify(&value, None);
    }
    let _ = quicktype_core::parse_json(&text, "JSON Schema", Some("fuzz.yaml"));
});
