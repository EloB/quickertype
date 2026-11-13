//! Port of `src/URLGrammar.ts`: `--src-urls` grammars.
//!
//! A grammar maps each top-level name to an expression of URLs: a string
//! is one URL, an array concatenates the expansions of its elements (their
//! cartesian product), and `{"oneOf": [...]}` is the union of its options'
//! expansions.

use indexmap::IndexMap;
use quicktype_js_compat::json::JsonValue;
use quicktype_js_compat::number;

use crate::messages::CliError;

/// `panic(message)`: an internal error.
fn panic<T>(message: String) -> Result<T, CliError> {
    Err(quicktype_core::QuickTypeError::internal(message).into())
}

/// JavaScript `String(value)` (what a template literal inserts).
fn js_string(value: &JsonValue) -> String {
    match value {
        JsonValue::Null => "null".to_owned(),
        JsonValue::Bool(b) => b.to_string(),
        JsonValue::Number(n) => number::to_string(*n),
        JsonValue::String(s) => s.clone(),
        JsonValue::Array(items) => items
            .iter()
            .map(|item| match item {
                JsonValue::Null => String::new(),
                other => js_string(other),
            })
            .collect::<Vec<_>>()
            .join(","),
        JsonValue::Object(_) => "[object Object]".to_owned(),
    }
}

/// `expand(json)`: all URLs an expression stands for, in order.
fn expand(json: &JsonValue) -> Result<Vec<String>, CliError> {
    match json {
        JsonValue::String(s) => Ok(vec![s.clone()]),
        JsonValue::Array(items) => {
            let mut result = vec![String::new()];
            for item in items {
                let expanded = expand(item)?;
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
                        js_string(other)
                    ));
                }
            };
            let mut result = Vec::new();
            for option in options {
                result.extend(expand(option)?);
            }
            Ok(result)
        }
        other => panic(format!(
            "Value is not a valid URL grammar: {}",
            js_string(other)
        )),
    }
}

/// `urlsFromURLGrammar(json)`: the URLs of every top-level, in property
/// order.
pub fn urls_from_url_grammar(json: &JsonValue) -> Result<IndexMap<String, Vec<String>>, CliError> {
    let JsonValue::Object(top_level_map) = json else {
        return panic(format!(
            "Value must be an object, but is {}",
            js_string(json)
        ));
    };
    let mut results = IndexMap::new();
    for (name, value) in top_level_map {
        results.insert(name.clone(), expand(value)?);
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
}
