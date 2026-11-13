//! The wire format between the JavaScript facade and the engine (research
//! 05, §4.2), as plain Rust data.
//!
//! The facade (`npm/quicktype-core/src/native/encode.ts`) flattens what a
//! run needs into strings, booleans and typed arrays; `js.rs` reads that
//! object into a [`Request`]. Everything after decoding is plain Rust, so
//! [`crate::assemble`] and these decoders are unit-tested natively.
//!
//! Strings travel in *blobs*: one string holding all of them back to back,
//! plus their lengths in UTF-16 code units (JavaScript's `length`), which
//! saves one boundary crossing per string.

use quicktype_core::internal::{CompressedJsonTables, CompressedTopLevel};
use quicktype_core::{
    Comment, CommentOptions, DebugOptions, InferenceFlags, JsonSchema, OptionValue,
};

/// A run of quicktype (TS `Options`, minus everything that stays in
/// JavaScript).
#[derive(Debug, Default)]
pub struct Request {
    /// `lang.name` of a built-in language.
    pub lang: String,
    /// The lowered `rendererOptions`, in the order the facade read them.
    pub renderer_options: Vec<(String, OptionValue)>,
    /// The eight inference flags.
    pub inference_flags: InferenceFlags,
    /// `alphabetizeProperties`.
    pub alphabetize_properties: bool,
    /// `allPropertiesOptional`.
    pub all_properties_optional: bool,
    /// `fixedTopLevels`.
    pub fixed_top_levels: bool,
    /// `noRender`.
    pub no_render: bool,
    /// `checkProvenance`.
    pub check_provenance: bool,
    /// The `debugPrint*` switches.
    pub debug: DebugOptions,
    /// `leadingComments`.
    pub leading_comments: Option<Vec<Comment>>,
    /// `outputFilename`.
    pub output_filename: String,
    /// `indentation`.
    pub indentation: Option<String>,
    /// Whether `onTiming` is set (otherwise timings are not reported).
    pub on_timing: bool,
    /// The inputs, in `InputData` order.
    pub inputs: Vec<InputRequest>,
}

/// One input of the run's `InputData`.
#[derive(Debug)]
pub enum InputRequest {
    /// A `JSONInput`: the tables its `CompressedJSON` built and its
    /// top-levels.
    Json {
        /// `compressedJSON.handleRefs`.
        handle_refs: bool,
        /// Which built-in `DateTimeRecognizer` the `CompressedJSON` has.
        date_time: DateTimeKind,
        /// The `CompressedJSON` tables.
        tables: CompressedJsonTables,
        /// `_topLevels`, in insertion order.
        top_levels: Vec<CompressedTopLevel>,
    },
    /// A `JSONSchemaInput`. Its store, the schemas given as text and URI
    /// normalization stay in JavaScript.
    Schema {
        /// Identifies the input in the facade's host callbacks.
        store_id: u32,
        /// `_schemaSources`: each normalized URI (`toString()`) with its
        /// source's name and `isConverted`.
        sources: Vec<SchemaSource>,
        /// `_topLevels` before the run: name and `Ref.toString()`.
        top_levels: Vec<(String, String)>,
        /// `_additionalSchemaAddresses`.
        additional: Vec<String>,
    },
}

/// One entry of `JSONSchemaInput._schemaSources`.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct SchemaSource {
    /// The normalized URI.
    pub uri: String,
    /// `source.name`.
    pub name: String,
    /// `source.isConverted === true`.
    pub is_converted: bool,
}

/// The built-in date/time recognizers (TS `DefaultDateTimeRecognizer` and
/// the Kotlin and Swift subclasses).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum DateTimeKind {
    /// `DefaultDateTimeRecognizer`.
    Default,
    /// `KotlinDateTimeRecognizer`.
    Kotlin,
    /// `SwiftDateTimeRecognizer`.
    Swift,
}

impl DateTimeKind {
    /// The kind the facade names `name`.
    pub fn from_name(name: &str) -> Option<Self> {
        match name {
            "default" => Some(Self::Default),
            "kotlin" => Some(Self::Kotlin),
            "swift" => Some(Self::Swift),
            _ => None,
        }
    }
}

/// A malformed request: a bug in the facade, reported as an internal
/// error.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct WireError(pub String);

impl WireError {
    pub fn new(message: impl Into<String>) -> Self {
        WireError(message.into())
    }
}

/// Splits a string blob into its strings, by UTF-16 lengths.
///
/// The blob arrives as UTF-8; a lone surrogate in the JavaScript string has
/// already become U+FFFD, which is one UTF-16 unit like the surrogate, so
/// the lengths still line up.
pub fn split_blob(blob: &str, lengths: &[u32]) -> Result<Vec<String>, WireError> {
    let mut strings = Vec::with_capacity(lengths.len());
    let mut chars = blob.char_indices().peekable();
    for &length in lengths {
        let start = chars.peek().map_or(blob.len(), |&(i, _)| i);
        let mut units = 0u32;
        while units < length {
            let Some((_, c)) = chars.next() else {
                return Err(WireError::new("string blob shorter than its lengths"));
            };
            units += c.len_utf16() as u32;
        }
        if units != length {
            return Err(WireError::new("string length splits a character"));
        }
        let end = chars.peek().map_or(blob.len(), |&(i, _)| i);
        strings.push(blob[start..end].to_owned());
    }
    if chars.next().is_some() {
        return Err(WireError::new("string blob longer than its lengths"));
    }
    Ok(strings)
}

/// Joins strings into a blob and their UTF-16 lengths, the inverse of
/// [`split_blob`].
pub fn join_blob<'a>(strings: impl IntoIterator<Item = &'a str>) -> (String, Vec<u32>) {
    let mut blob = String::new();
    let mut lengths = Vec::new();
    for s in strings {
        blob.push_str(s);
        lengths.push(s.encode_utf16().count() as u32);
    }
    (blob, lengths)
}

/// Node tags of an encoded JavaScript value (see [`decode_value`]).
pub mod tag {
    pub const UNDEFINED: u8 = 0;
    pub const NULL: u8 = 1;
    pub const FALSE: u8 = 2;
    pub const TRUE: u8 = 3;
    pub const NUMBER: u8 = 4;
    pub const STRING: u8 = 5;
    pub const ARRAY: u8 = 6;
    pub const OBJECT: u8 = 7;
}

/// A JavaScript value (a schema document from a store) encoded by the
/// facade's `encodeValue`: the nodes in pre-order, one tag each; numbers,
/// collection sizes and strings (object keys before their values) in
/// separate streams.
#[derive(Debug, Default, Clone, PartialEq)]
pub struct EncodedValue {
    pub tags: Vec<u8>,
    pub numbers: Vec<f64>,
    pub counts: Vec<u32>,
    pub strings: Vec<String>,
}

/// Decodes an [`EncodedValue`]; `None` for `undefined`. Iterative, since
/// documents can nest deeply.
///
/// `undefined` (and values JSON has no notion of, which the facade encodes
/// as `undefined`) is dropped from objects, as if the key were missing,
/// and becomes `null` in arrays, as `JSON.stringify` does.
pub fn decode_value(encoded: &EncodedValue) -> Result<Option<JsonSchema>, WireError> {
    use indexmap::IndexMap;
    use std::rc::Rc;

    enum Frame {
        Array(Vec<JsonSchema>, u32),
        Object(IndexMap<String, JsonSchema>, u32, Option<String>),
    }

    let mut tags = encoded.tags.iter().copied();
    let mut numbers = encoded.numbers.iter().copied();
    let mut counts = encoded.counts.iter().copied();
    let mut strings = encoded.strings.iter();
    let truncated = || WireError::new("truncated value encoding");
    let mut stack: Vec<Frame> = Vec::new();
    loop {
        // The key of the value about to be read, if inside an object.
        if let Some(Frame::Object(_, remaining, key)) = stack.last_mut() {
            if *remaining > 0 && key.is_none() {
                *key = Some(strings.next().ok_or_else(truncated)?.clone());
            }
        }
        let finished = matches!(
            stack.last(),
            Some(Frame::Array(_, 0)) | Some(Frame::Object(_, 0, _))
        );
        let value: Option<JsonSchema> = if finished {
            match stack.pop() {
                Some(Frame::Array(items, _)) => Some(JsonSchema::Array(Rc::new(items))),
                Some(Frame::Object(map, _, _)) => Some(JsonSchema::Object(Rc::new(map))),
                None => None,
            }
        } else {
            match tags.next().ok_or_else(truncated)? {
                tag::UNDEFINED => None,
                tag::NULL => Some(JsonSchema::Null),
                tag::FALSE => Some(JsonSchema::Bool(false)),
                tag::TRUE => Some(JsonSchema::Bool(true)),
                tag::NUMBER => Some(JsonSchema::Number(numbers.next().ok_or_else(truncated)?)),
                tag::STRING => Some(JsonSchema::String(
                    strings.next().ok_or_else(truncated)?.clone(),
                )),
                tag::ARRAY => {
                    let n = counts.next().ok_or_else(truncated)?;
                    stack.push(Frame::Array(Vec::with_capacity(n as usize), n));
                    continue;
                }
                tag::OBJECT => {
                    let n = counts.next().ok_or_else(truncated)?;
                    stack.push(Frame::Object(IndexMap::with_capacity(n as usize), n, None));
                    continue;
                }
                other => return Err(WireError::new(format!("unknown value tag {other}"))),
            }
        };
        match stack.last_mut() {
            None => {
                if tags.next().is_some() {
                    return Err(WireError::new("trailing value encoding"));
                }
                return Ok(value);
            }
            Some(Frame::Array(items, remaining)) => {
                items.push(value.unwrap_or(JsonSchema::Null));
                *remaining -= 1;
            }
            Some(Frame::Object(map, remaining, key)) => {
                let key = key.take().ok_or_else(truncated)?;
                if let Some(value) = value {
                    map.insert(key, value);
                }
                *remaining -= 1;
            }
        }
    }
}

/// A comment's lines as the facade sends them: strings, or arrays of them
/// (TS `Sourcelike`s made only of strings).
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Sourcelike {
    Text(String),
    Sequence(Vec<Sourcelike>),
}

impl Sourcelike {
    /// `sourcelikeToSource`.
    pub fn to_source(&self) -> quicktype_core::internal::Source {
        match self {
            Sourcelike::Text(text) => text.as_str().into(),
            Sourcelike::Sequence(items) => items
                .iter()
                .map(Sourcelike::to_source)
                .collect::<Vec<_>>()
                .into(),
        }
    }
}

/// A `leadingComments` entry as the facade sends it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CommentRequest {
    String(String),
    Lines(Vec<Sourcelike>),
    DescriptionBlock(Vec<Sourcelike>),
    Custom {
        options: CommentOptions,
        lines: Vec<Sourcelike>,
    },
}

impl CommentRequest {
    pub fn to_comment(&self) -> Comment {
        let sources = |lines: &[Sourcelike]| lines.iter().map(Sourcelike::to_source).collect();
        match self {
            CommentRequest::String(s) => Comment::String(s.clone()),
            CommentRequest::Lines(lines) => Comment::Lines(sources(lines)),
            CommentRequest::DescriptionBlock(lines) => Comment::DescriptionBlock(sources(lines)),
            CommentRequest::Custom { options, lines } => Comment::Custom {
                options: options.clone(),
                custom_lines: sources(lines),
            },
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn blobs_round_trip_by_utf16_length() {
        let strings = ["", "a", "héllo", "𝄞x", "\u{0}\n"];
        let (blob, lengths) = join_blob(strings);
        assert_eq!(lengths, [0, 1, 5, 3, 2]);
        assert_eq!(split_blob(&blob, &lengths).unwrap(), strings);
        assert!(split_blob(&blob, &[1, 2]).is_err());
        assert!(split_blob("𝄞", &[1]).is_err());
        assert!(split_blob("ab", &[3]).is_err());
    }

    fn encode(value: &str) -> EncodedValue {
        // A tiny encoder for tests, over a JSON-ish notation.
        fn go(v: &serde_json::Value, e: &mut EncodedValue) {
            match v {
                serde_json::Value::Null => e.tags.push(tag::NULL),
                serde_json::Value::Bool(b) => e.tags.push(if *b { tag::TRUE } else { tag::FALSE }),
                serde_json::Value::Number(n) => {
                    e.tags.push(tag::NUMBER);
                    e.numbers.push(n.as_f64().unwrap());
                }
                serde_json::Value::String(s) if s == "<undefined>" => e.tags.push(tag::UNDEFINED),
                serde_json::Value::String(s) => {
                    e.tags.push(tag::STRING);
                    e.strings.push(s.clone());
                }
                serde_json::Value::Array(items) => {
                    e.tags.push(tag::ARRAY);
                    e.counts.push(items.len() as u32);
                    for item in items {
                        go(item, e);
                    }
                }
                serde_json::Value::Object(map) => {
                    e.tags.push(tag::OBJECT);
                    e.counts.push(map.len() as u32);
                    for (k, v) in map {
                        e.strings.push(k.clone());
                        go(v, e);
                    }
                }
            }
        }
        let mut e = EncodedValue::default();
        go(&serde_json::from_str(value).unwrap(), &mut e);
        e
    }

    #[test]
    fn values_decode_in_order() {
        let text = r#"{"b": [1, "x", null, {}], "a": {"c": true, "u": "<undefined>"}, "d": []}"#;
        let decoded = decode_value(&encode(text)).unwrap().unwrap();
        let JsonSchema::Object(map) = &decoded else {
            panic!("not an object")
        };
        // The order the test encoder emitted them in (serde_json's map
        // order, which depends on its features).
        let source: serde_json::Value = serde_json::from_str(text).unwrap();
        let expected: Vec<&String> = source.as_object().unwrap().keys().collect();
        assert_eq!(map.keys().collect::<Vec<_>>(), expected);
        let unsorted = EncodedValue {
            tags: vec![tag::OBJECT, tag::NUMBER, tag::NUMBER],
            numbers: vec![1.0, 2.0],
            counts: vec![2],
            strings: vec!["b".into(), "a".into()],
        };
        let unsorted = decode_value(&unsorted).unwrap().unwrap();
        let keys: Vec<&String> = unsorted.as_object().unwrap().keys().collect();
        assert_eq!(keys, ["b", "a"]);
        assert_eq!(decoded.get("a").unwrap().as_object().unwrap().len(), 1);
        let items = decoded.get("b").unwrap().as_array().unwrap();
        assert_eq!(items.len(), 4);
        assert_eq!(items[1], JsonSchema::String("x".into()));
        assert_eq!(decode_value(&encode(r#""<undefined>""#)).unwrap(), None);
        assert_eq!(
            decode_value(&encode(r#"["<undefined>"]"#)).unwrap(),
            Some(JsonSchema::Array(std::rc::Rc::new(vec![JsonSchema::Null])))
        );
        assert_eq!(
            decode_value(&encode("true")).unwrap(),
            Some(JsonSchema::Bool(true))
        );
    }

    #[test]
    fn malformed_values_are_errors() {
        let mut e = encode(r#"{"a": 1}"#);
        e.numbers.clear();
        assert!(decode_value(&e).is_err());
        let mut e = encode("[1, 2]");
        e.tags.push(tag::NULL);
        assert!(decode_value(&e).is_err());
        let e = EncodedValue {
            tags: vec![9],
            ..Default::default()
        };
        assert!(decode_value(&e).is_err());
    }

    #[test]
    fn deep_values_decode_without_recursion() {
        let depth = 100_000;
        let e = EncodedValue {
            tags: vec![tag::ARRAY; depth],
            counts: [vec![1; depth - 1], vec![0]].concat(),
            ..Default::default()
        };
        assert!(decode_value(&e).unwrap().is_some());
    }
}
