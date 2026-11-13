//! Port of `packages/quicktype-core/src/input/PostmanCollection.ts`.
//!
//! Turns a Postman collection into JSON sources: every request with a name
//! and responses whose bodies are valid JSON becomes a top-level, with the
//! request's name, `METHOD url` and description as its description.
//!
//! The TypeScript walks the parsed collection with JavaScript property
//! access, so malformed collections fail with JavaScript `TypeError`s
//! (`null` where an object is expected); this port reports the same
//! messages. It also recurses, as does `String(array)`, so very deep
//! collections exhaust Node's stack; this port is iterative and reports
//! the `RangeError` at the depths where the reference CLI does.

use quicktype_js_compat::json::{self, JsonValue};
use quicktype_js_compat::whitespace;

use super::inputs::JsonSourceData;
use crate::messages::{JsErrorName, QuickTypeError, Result};
use crate::support::parse_json::parse_json;
use crate::support::recursion::stack_overflow;

/// The result of [`sources_from_postman_collection`].
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct PostmanSources {
    /// One JSON source per request with valid JSON responses, in the order
    /// the TypeScript visits them.
    pub sources: Vec<JsonSourceData<String>>,
    /// The collection's description: the folders' `info.description`s,
    /// innermost first, joined by blank lines; `None` if empty.
    pub description: Option<String>,
}

/// `sourcesFromPostmanCollection(collectionJSON, collectionJSONAddress)`.
pub fn sources_from_postman_collection(
    collection_json: &str,
    collection_json_address: Option<&str>,
) -> Result<PostmanSources> {
    let collection = parse_json(
        collection_json,
        "Postman collection",
        collection_json_address,
    )?;
    let mut sources = Vec::new();
    let mut descriptions = Vec::new();
    process_collection(&collection, &mut sources, &mut descriptions)?;

    let joined = descriptions.join("\n\n");
    let joined = whitespace::trim(&joined);
    Ok(PostmanSources {
        sources,
        description: (!joined.is_empty()).then(|| joined.to_owned()),
    })
}

/// A JavaScript `TypeError` that escapes the TypeScript: the CLI prints its
/// message as is (`Error: <message>.`).
fn type_error(message: String) -> QuickTypeError {
    QuickTypeError::js_exception(JsErrorName::TypeError, message)
}

/// The deepest nesting of `processCollection` calls the reference CLI
/// survives (Node 24.16, the default stack; measured on the CLI with nested
/// `item` folders): 3,731 folders around a request.
const MAX_COLLECTION_DEPTH: usize = 3_732;

/// The deepest array nesting `String(value)` survives in the reference CLI
/// when it formats a top-level request's `method` or `url.raw` (measured
/// like [`MAX_COLLECTION_DEPTH`]). Inside nested folders Node has less stack
/// left, so its limit is lower; that is not modelled.
const MAX_STRING_ARRAY_DEPTH: usize = 2_830;

/// `obj[key]` for a JSON value that is an object (`typeof obj ===
/// "object"`): `None` for `undefined`. Reading a property of `null`
/// throws.
fn get<'a>(obj: &'a JsonValue, key: &str) -> Result<Option<&'a JsonValue>> {
    json::get_property(Some(obj), key).map_err(|e| type_error(e.message().to_owned()))
}

/// JavaScript truthiness.
fn truthy(v: &JsonValue) -> bool {
    json::is_truthy(v)
}

/// `typeof v === "object"`: objects, arrays and `null`.
fn is_object(v: &JsonValue) -> bool {
    matches!(
        v,
        JsonValue::Null | JsonValue::Array(_) | JsonValue::Object(_)
    )
}

/// `String(v)`, as a template literal converts a value; nesting deeper
/// than [`MAX_STRING_ARRAY_DEPTH`] is Node's `RangeError`.
fn js_string(v: &JsonValue) -> Result<String> {
    Ok(json::to_js_string(v, MAX_STRING_ARRAY_DEPTH)?)
}

/// `processCollection(c)`, iteratively: a folder's items first, then its
/// `info.description`, then the folder (or request) itself as a source.
fn process_collection(
    root: &JsonValue,
    sources: &mut Vec<JsonSourceData<String>>,
    descriptions: &mut Vec<String>,
) -> Result<()> {
    // (collection, its call depth, whether its items have been processed)
    let mut stack: Vec<(&JsonValue, usize, bool)> = vec![(root, 1, false)];
    while let Some((c, depth, items_done)) = stack.pop() {
        if depth > MAX_COLLECTION_DEPTH {
            return Err(stack_overflow());
        }
        if !is_object(c) {
            continue;
        }
        if !items_done {
            if let Some(JsonValue::Array(items)) = get(c, "item")? {
                stack.push((c, depth, true));
                stack.extend(items.iter().rev().map(|item| (item, depth + 1, false)));
                continue;
            }
        } else if let Some(info) = get(c, "info")? {
            if truthy(info) && is_object(info) {
                if let Some(JsonValue::String(description)) = get(info, "description")? {
                    descriptions.push(description.clone());
                }
            }
        }
        add_request(c, sources)?;
    }
    Ok(())
}

/// The second half of `processCollection(c)`: a request with a name and
/// responses becomes a source.
fn add_request(c: &JsonValue, sources: &mut Vec<JsonSourceData<String>>) -> Result<()> {
    let Some(JsonValue::String(name)) = get(c, "name")? else {
        return Ok(());
    };
    let Some(JsonValue::Array(responses)) = get(c, "response")? else {
        return Ok(());
    };
    let mut samples = Vec::new();
    for r in responses {
        if !is_object(r) {
            continue;
        }
        if let Some(JsonValue::String(body)) = get(r, "body")? {
            // `isValidJSON(r.body)`
            if json::parse(body).is_ok() {
                samples.push(body.clone());
            }
        }
    }
    if samples.is_empty() {
        return Ok(());
    }

    let mut source_description = vec![name.clone()];
    let request = get(c, "request")?.filter(|r| truthy(r) && is_object(r));
    if let Some(request) = request {
        let method = get(request, "method")?;
        let url = get(request, "url")?;
        if let (Some(method), Some(url)) = (method, url) {
            if is_object(url) {
                if let JsonValue::Null = url {
                    return Err(type_error(
                        "Cannot use 'in' operator to search for 'raw' in null".to_owned(),
                    ));
                }
                if let Some(raw) = get(url, "raw")? {
                    let method = js_string(method)?;
                    source_description.push(format!("{method} {}", js_string(raw)?));
                }
            }
        }
        if let Some(JsonValue::String(description)) = get(request, "description")? {
            source_description.push(description.clone());
        }
    }

    sources.push(JsonSourceData {
        name: name.clone(),
        samples,
        description: Some(source_description.join("\n\n")),
    });
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn sources(text: &str) -> Result<PostmanSources> {
        sources_from_postman_collection(text, Some("c.json"))
    }

    #[test]
    fn nested_folders_and_descriptions() {
        let collection = r#"{
            "info": {"description": "  outer  "},
            "item": [
                {"item": [{"name": "A", "response": [{"body": "{\"a\":1}"}, {"body": "nope"}]}],
                 "info": {"description": "inner"}},
                {"name": "B", "request": {"method": "GET", "url": {"raw": "http://x"}, "description": "about B"},
                 "response": [{"body": "[1]"}]}
            ]
        }"#;
        let result = sources(collection).unwrap();
        assert_eq!(result.description.as_deref(), Some("inner\n\n  outer"));
        assert_eq!(result.sources.len(), 2);
        assert_eq!(result.sources[0].samples, ["{\"a\":1}"]);
        assert_eq!(result.sources[0].description.as_deref(), Some("A"));
        assert_eq!(
            result.sources[1].description.as_deref(),
            Some("B\n\nGET http://x\n\nabout B")
        );
    }

    /// Iterative, but with Node's stack limits, as measured on the CLI.
    #[test]
    fn deep_collections() {
        let request = |method: &str| {
            format!(
                r#"{{"name":"x","response":[{{"body":"1"}}],"request":{{"method":{method},"url":{{"raw":"u"}}}}}}"#
            )
        };
        let nested = |d: usize| format!("{}1{}", "[".repeat(d), "]".repeat(d));
        let ok = sources(&request(&nested(2830))).unwrap();
        assert_eq!(ok.sources[0].description.as_deref(), Some("x\n\n1 u"));
        let message = |text: &str| sources(text).unwrap_err().user_message().to_owned();
        assert_eq!(
            message(&request(&nested(2831))),
            "Maximum call stack size exceeded"
        );
        assert_eq!(
            message(&request(&format!("[{},[]]", nested(1_000_000)))),
            "Maximum call stack size exceeded"
        );
        assert_eq!(
            js_string(&json::parse("[1,[2,[null,[]]],3]").unwrap()).unwrap(),
            "1,2,,,3"
        );
        let folders = |d: usize| {
            format!(
                r#"{}{{"name":"x","response":[{{"body":"1"}}]}}{}"#,
                r#"{"item":["#.repeat(d),
                "]}".repeat(d)
            )
        };
        assert_eq!(sources(&folders(3731)).unwrap().sources.len(), 1);
        assert_eq!(message(&folders(3732)), "Maximum call stack size exceeded");
        assert_eq!(
            message(&folders(1_000_000)),
            "Maximum call stack size exceeded"
        );
    }

    #[test]
    fn javascript_type_errors() {
        let message = |text: &str| sources(text).unwrap_err().user_message().to_owned();
        assert_eq!(
            message("null"),
            "Cannot read properties of null (reading 'item')"
        );
        assert_eq!(
            message(r#"{"item":[null]}"#),
            "Cannot read properties of null (reading 'item')"
        );
        assert_eq!(
            message(r#"{"name":"x","response":[null]}"#),
            "Cannot read properties of null (reading 'body')"
        );
        assert_eq!(
            message(
                r#"{"name":"x","response":[{"body":"1"}],"request":{"method":"GET","url":null}}"#
            ),
            "Cannot use 'in' operator to search for 'raw' in null"
        );
        // Not JSON: `parseJSON` falls back to YAML, whose error is reported
        // (its wording is `saphyr-parser`'s; see "Known gaps").
        assert!(
            message("{").starts_with(
                "Syntax error in Postman collection JSON c.json: Unknown exception YAMLParseError: "
            ),
            "{}",
            message("{")
        );
    }
}
