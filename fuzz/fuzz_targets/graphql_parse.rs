//! graphql-js's `parse` (the hand port in
//! `quicktype_graphql_input::graphql`) on arbitrary text.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_graphql_input::graphql;

fuzz_target!(|data: &[u8]| {
    let text = quicktype_fuzz::text(data);
    if let Err(e) = graphql::parse(&text) {
        let _ = (e.message(), e.position());
        let _ = e.to_string();
    }
});
