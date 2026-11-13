//! Port of `packages/quicktype-core/src/language/TypeScriptFlow/utils.ts`.

use crate::language::javascript::java_script_renderer::JavaScriptTypeAnnotations;
use crate::language::javascript::unicode_maps::is_es3_identifier_start;
use crate::language::javascript::utils::legalize_name;
use crate::support::strings::utf16_string_escape;

/// `{ never, ...tsFlowTypeAnnotations }`: the type annotations of the
/// runtime typecheck helpers, with the given `never` annotation.
pub fn ts_flow_type_annotations(never: &'static str) -> JavaScriptTypeAnnotations {
    JavaScriptTypeAnnotations {
        any: ": any",
        any_array: ": any[]",
        any_map: ": { [k: string]: any }",
        string: ": string",
        string_array: ": string[]",
        boolean: ": boolean",
        never,
    }
}

/// `quotePropertyName(original)`: `original` if it is a plain identifier,
/// otherwise the escaped name in double quotes.
pub fn quote_property_name(original: &str) -> String {
    let escaped = utf16_string_escape(original);
    let quoted = format!("\"{escaped}\"");

    match original.chars().next() {
        None => quoted,
        Some(first) if !is_es3_identifier_start(u32::from(first)) => quoted,
        Some(_) if escaped != original => quoted,
        Some(_) if legalize_name(original) != original => quoted,
        Some(_) => original.to_owned(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn quotes_only_non_identifiers() {
        assert_eq!(quote_property_name("name"), "name");
        assert_eq!(quote_property_name("$ref"), "$ref");
        assert_eq!(quote_property_name(""), "\"\"");
        assert_eq!(quote_property_name("1st"), "\"1st\"");
        assert_eq!(quote_property_name("a-b"), "\"a-b\"");
        assert_eq!(quote_property_name("é"), "é");
        assert_eq!(quote_property_name("a\"b"), "\"a\\\"b\"");
    }
}
