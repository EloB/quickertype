//! Port of `src/URLGrammar.ts`: `--src-urls` grammars.
//!
//! A grammar maps each top-level name to an expression of URLs: a string
//! is one URL, an array concatenates the expansions of its elements (their
//! cartesian product), and `{"oneOf": [...]}` is the union of its options'
//! expansions.

use indexmap::IndexMap;
use quicktype_core::support::recursion;
use quicktype_js_compat::json::{self, JsonValue};

use crate::messages::CliError;

/// How many `expand` calls the reference CLI (Node 24) nests before its
/// stack overflows: a URL inside 2,226 nested arrays or `oneOf`s expands,
/// one more level is `RangeError: Maximum call stack size exceeded`.
const EXPAND_MAX_DEPTH: usize = 2_227;

/// The deepest array nesting `String(value)` survives where the reference
/// CLI reports a grammar that is not an object (measured like
/// [`EXPAND_MAX_DEPTH`]).
const STRING_ARRAY_MAX_DEPTH: usize = 2_734;

/// V8's `RangeError` when Node's stack runs out.
fn stack_overflow() -> CliError {
    recursion::stack_overflow().into()
}

/// `panic(message)`: an internal error.
fn panic<T>(message: String) -> Result<T, CliError> {
    Err(quicktype_core::QuickTypeError::internal(message).into())
}

/// JavaScript `String(value)`; nesting deeper than
/// [`STRING_ARRAY_MAX_DEPTH`] is Node's `RangeError`.
fn js_string(value: &JsonValue) -> Result<String, CliError> {
    json::to_js_string(value, STRING_ARRAY_MAX_DEPTH).map_err(|_| stack_overflow())
}

/// `expand(json)`: all URLs an expression stands for, in order. `depth`
/// counts the `expand` calls this one is nested in (1 for a top-level's
/// expression).
fn expand(json: &JsonValue, depth: usize) -> Result<Vec<String>, CliError> {
    if depth > EXPAND_MAX_DEPTH {
        return Err(stack_overflow());
    }
    match json {
        JsonValue::String(s) => Ok(vec![s.clone()]),
        JsonValue::Array(items) => {
            let mut result = vec![String::new()];
            for item in items {
                let expanded = expand(item, depth + 1)?;
                let mut appended = Vec::with_capacity(result.len() * expanded.len());
                for a in &result {
                    for b in &expanded {
                        appended.push(format!("{a}{b}"));
                    }
                }
                result = appended;
            }
            Ok(result)
        }
        JsonValue::Object(map) if map.contains_key("oneOf") => {
            let options = match &map["oneOf"] {
                JsonValue::Array(options) => options,
                other => {
                    return panic(format!(
                        "Value must be an array, but is {}",
                        js_string(other)?
                    ));
                }
            };
            let mut result = Vec::new();
            for option in options {
                result.extend(expand(option, depth + 1)?);
            }
            Ok(result)
        }
        other => panic(format!(
            "Value is not a valid URL grammar: {}",
            js_string(other)?
        )),
    }
}

/// `urlsFromURLGrammar(json)`: the URLs of every top-level, in property
/// order.
pub fn urls_from_url_grammar(json: &JsonValue) -> Result<IndexMap<String, Vec<String>>, CliError> {
    let JsonValue::Object(top_level_map) = json else {
        return panic(format!(
            "Value must be an object, but is {}",
            js_string(json)?
        ));
    };
    let mut results = IndexMap::new();
    for (name, value) in top_level_map {
        results.insert(name.clone(), expand(value, 1)?);
    }
    Ok(results)
}

#[cfg(test)]
mod tests {
    use super::*;
    use quicktype_js_compat::json;

    fn urls(grammar: &str) -> Result<Vec<(String, Vec<String>)>, String> {
        let value = json::parse(grammar).map_err(|e| e.to_string())?;
        urls_from_url_grammar(&value)
            .map(|m| m.into_iter().collect())
            .map_err(|e| e.to_string())
    }

    #[test]
    fn expands_products_and_unions() {
        assert_eq!(
            urls(r#"{"Foo": ["https://x/", {"oneOf": ["a", "b"]}, ".json"], "1": "u"}"#).unwrap(),
            vec![
                ("1".to_owned(), vec!["u".to_owned()]),
                (
                    "Foo".to_owned(),
                    vec!["https://x/a.json".to_owned(), "https://x/b.json".to_owned()]
                ),
            ]
        );
        assert_eq!(
            urls(r#"{"E": []}"#).unwrap(),
            vec![("E".to_owned(), vec![String::new()])]
        );
    }

    #[test]
    fn rejects_other_values() {
        assert_eq!(
            urls(r#"{"A": [1, 2]}"#).unwrap_err(),
            "Internal error: Value is not a valid URL grammar: 1"
        );
        assert_eq!(
            urls(r#"{"A": {"x": 1}}"#).unwrap_err(),
            "Internal error: Value is not a valid URL grammar: [object Object]"
        );
        assert_eq!(
            urls("[1, null]").unwrap_err(),
            "Internal error: Value must be an object, but is 1,"
        );
        assert_eq!(
            urls(r#"{"A": {"oneOf": 3}}"#).unwrap_err(),
            "Internal error: Value must be an array, but is 3"
        );
    }

    /// Where the reference CLI's recursion overflows Node's stack (a
    /// million levels used to overflow the native stack). On a thread with
    /// the CLI's stack: `expand` recurses 2,227 calls deep.
    #[test]
    fn deep_grammars_overflow_like_node() {
        std::thread::Builder::new()
            .stack_size(256 << 20)
            .spawn(deep_grammars_overflow_like_node_on_a_large_stack)
            .unwrap()
            .join()
            .unwrap();
    }

    fn deep_grammars_overflow_like_node_on_a_large_stack() {
        let overflow = "Maximum call stack size exceeded";
        let url = r#""http://localhost/x""#;
        let arrays = |n| format!(r#"{{"a":{}{url}{}}}"#, "[".repeat(n), "]".repeat(n));
        let one_ofs = |n| {
            format!(
                r#"{{"a":{}{url}{}}}"#,
                r#"{"oneOf":["#.repeat(n),
                "]}".repeat(n)
            )
        };
        let nestings: [&dyn Fn(usize) -> String; 2] = [&arrays, &one_ofs];
        for nested in nestings {
            assert_eq!(urls(&nested(2_226)).unwrap()[0].1, ["http://localhost/x"]);
            assert_eq!(urls(&nested(2_227)).unwrap_err(), overflow);
        }
        assert_eq!(urls(&arrays(1_000_000)).unwrap_err(), overflow);
        let top_level = |n| format!("{}1{}", "[".repeat(n), "]".repeat(n));
        assert_eq!(
            urls(&top_level(2_734)).unwrap_err(),
            "Internal error: Value must be an object, but is 1"
        );
        assert_eq!(urls(&top_level(2_735)).unwrap_err(), overflow);
        assert_eq!(urls(&top_level(1_000_000)).unwrap_err(), overflow);
    }
}
