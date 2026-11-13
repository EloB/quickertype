//! Port of `packages/quicktype-core/src/input/CompressedJSON.ts`.
//!
//! JSON samples are not kept as trees of values but in a compact form that
//! keeps exactly what inference needs: one shared string table, and objects
//! and arrays as flat lists of [`Value`]s. Strings are classified while they
//! are read: a string that looks like a date, UUID, integer, ... is stored
//! as its transformed string kind ([`Value::StringFormat`]), a `uri` keeps
//! its text for the URI attributes ([`Value::TransformedString`]), short
//! strings are interned as possible enum cases and long ones are dropped
//! ([`Value::UninternedString`]).
//!
//! [`CompressedJson`] is the state and the builder that a *reader* drives
//! (TS: the abstract class `CompressedJSON<T>` and its protected methods).
//! Readers implement [`CompressedJsonReader`]:
//!
//! - [`CompressedJsonFromString`]: the JavaScript API's reader, `JSON.parse`
//!   semantics (`1.0` is an integer, array-index keys come first, the last
//!   duplicate key wins, V8's error messages);
//! - [`CompressedJsonFromStream`](super::compressed_json_from_stream::CompressedJsonFromStream):
//!   the CLI's reader, stream-json semantics (`1.0` is a double, source key
//!   order, duplicate keys kept, stream-json's error messages).
//!
//! Differences from the TypeScript that cannot be observed: values are an
//! enum instead of tagged integers, objects are lists of key/value pairs,
//! and a [`Value::StringFormat`] holds its kind instead of interning the
//! kind's name.

use std::collections::HashMap;
use std::fmt;
use std::future::Future;

use quicktype_js_compat::json::{self, JsonValue};
use quicktype_js_compat::utf16;

use crate::attributes::string_types::infer_transformed_string_type_kind_for_string;
use crate::date_time::DateTimeRecognizer;
use crate::messages::{QuickTypeError, Result};
use crate::renderer_options::RendererOptions;
use crate::support::integer_range::{INT64_RANGE, IntegerRange, integer_string_in_range};
use crate::support::support::{assert, defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::transformed_string_type::{TypeKind, transformed_string_type_attributes_producer};

/// One JSON value in compressed form (TS `Value`, a tag plus an index).
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum Value {
    /// `null`.
    Null,
    /// `false`.
    False,
    /// `true`.
    True,
    /// A number inferred as `integer`.
    Integer,
    /// A number inferred as `double`.
    Double,
    /// A string of at most 64 UTF-16 code units, by its index in the
    /// string table; a candidate enum case.
    InternedString(u32),
    /// A longer string; its text is not kept.
    UninternedString,
    /// An object, by its index in the object table.
    Object(u32),
    /// An array, by its index in the array table.
    Array(u32),
    /// A string of a transformed string kind (`date`, `uuid`,
    /// `integer-string`, ...).
    StringFormat(TypeKind),
    /// A `uri` string, by its index in the string table (the URI attributes
    /// are computed from its text).
    TransformedString(u32),
}

/// The state of an object or array being read (TS `Context`).
#[derive(Debug, Default)]
struct Context {
    current_array: Option<Vec<Value>>,
    current_key: Option<String>,
    current_object: Option<Vec<(Value, Value)>>,
}

/// The compressed form of the JSON samples of one input, and the builder
/// readers fill it with (TS `CompressedJSON<T>`).
///
/// One instance holds all samples of a [`JsonInput`](super::inputs::JsonInput):
/// they share the string table.
pub struct CompressedJson {
    date_time_recognizer: Box<dyn DateTimeRecognizer>,
    handle_refs: bool,
    supported_integer_range: Option<IntegerRange>,
    root_value: Option<Value>,
    ctx: Option<Context>,
    context_stack: Vec<Context>,
    strings: Vec<String>,
    /// Only looked up, never iterated.
    string_indexes: HashMap<String, u32>,
    objects: Vec<Vec<(Value, Value)>>,
    arrays: Vec<Vec<Value>>,
}

impl fmt::Debug for CompressedJson {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("CompressedJson")
            .field("handle_refs", &self.handle_refs)
            .field("supported_integer_range", &self.supported_integer_range)
            .field("strings", &self.strings.len())
            .field("objects", &self.objects.len())
            .field("arrays", &self.arrays.len())
            .finish_non_exhaustive()
    }
}

impl CompressedJson {
    /// `new CompressedJSON(dateTimeRecognizer, handleRefs,
    /// supportedIntegerRange)`.
    ///
    /// - `date_time_recognizer` decides which strings are dates and times.
    /// - `handle_refs`: strings under a `"$ref"` key are kept as references
    ///   (the inverse of the `ignoreJsonRefs` inference flag).
    /// - `supported_integer_range`: whole numbers outside it are inferred as
    ///   `double`; `None` means arbitrary precision. TypeScript defaults to
    ///   the int64 range ([`CompressedJson::with_int64_range`]).
    pub fn new(
        date_time_recognizer: Box<dyn DateTimeRecognizer>,
        handle_refs: bool,
        supported_integer_range: Option<IntegerRange>,
    ) -> Self {
        CompressedJson {
            date_time_recognizer,
            handle_refs,
            supported_integer_range,
            root_value: None,
            ctx: None,
            context_stack: Vec::new(),
            strings: Vec::new(),
            string_indexes: HashMap::new(),
            objects: Vec::new(),
            arrays: Vec::new(),
        }
    }

    /// `new CompressedJSON(dateTimeRecognizer, handleRefs)`: the default
    /// int64 integer range.
    pub fn with_int64_range(
        date_time_recognizer: Box<dyn DateTimeRecognizer>,
        handle_refs: bool,
    ) -> Self {
        Self::new(date_time_recognizer, handle_refs, Some(INT64_RANGE.clone()))
    }

    /// The configuration `jsonInputForTargetLanguage` gives a target
    /// language: its date/time recognizer and its integer range for
    /// `renderer_options`.
    pub fn for_target_language(
        target_language: &dyn TargetLanguage,
        handle_refs: bool,
        renderer_options: &RendererOptions,
    ) -> Self {
        Self::new(
            target_language.date_time_recognizer(),
            handle_refs,
            target_language.get_supported_integer_range(renderer_options),
        )
    }

    /// `dateTimeRecognizer`.
    pub fn date_time_recognizer(&self) -> &dyn DateTimeRecognizer {
        self.date_time_recognizer.as_ref()
    }

    /// `handleRefs`.
    pub fn handle_refs(&self) -> bool {
        self.handle_refs
    }

    /// `supportedIntegerRange`.
    pub fn supported_integer_range(&self) -> Option<&IntegerRange> {
        self.supported_integer_range.as_ref()
    }

    /// `integerStringFits(integerString)`: whether a whole number, given as
    /// the decimal string of its literal, fits the supported range.
    pub fn integer_string_fits(&self, integer_string: &str) -> bool {
        match &self.supported_integer_range {
            None => true,
            Some(range) => integer_string_in_range(integer_string, range),
        }
    }

    /// `parsedNumberIsDouble(n)`: whether a number `JSON.parse` produced is
    /// inferred as `double`. For whole numbers below 1e21, `toFixed(0)` is
    /// the exact decimal value of the double.
    pub fn parsed_number_is_double(&self, n: f64) -> bool {
        if n != n.floor() {
            return true;
        }
        if self.supported_integer_range.is_none() {
            return false;
        }
        if n.abs() >= 1e21 {
            return true;
        }
        // `n.toFixed(0)`: exact for |n| < 1e21 < 2^70; `-0` gives "0".
        !self.integer_string_fits(&(n as i128).to_string())
    }

    /// `getStringForValue(v)`: the text of an interned or transformed
    /// string.
    pub fn get_string_for_value(&self, v: Value) -> Result<&str> {
        match v {
            Value::InternedString(i) | Value::TransformedString(i) => {
                Ok(defined(self.strings.get(i as usize))?)
            }
            _ => panic("Trying to get index for value with invalid tag"),
        }
    }

    /// `getObjectForValue(v)`: the object's key/value pairs, in the order
    /// the reader produced them; keys are [`Value::InternedString`]s.
    pub fn get_object_for_value(&self, v: Value) -> Result<&[(Value, Value)]> {
        match v {
            Value::Object(i) => Ok(defined(self.objects.get(i as usize))?),
            _ => panic("Trying to get index for value with invalid tag"),
        }
    }

    /// `getArrayForValue(v)`: the array's elements.
    pub fn get_array_for_value(&self, v: Value) -> Result<&[Value]> {
        match v {
            Value::Array(i) => Ok(defined(self.arrays.get(i as usize))?),
            _ => panic("Trying to get index for value with invalid tag"),
        }
    }

    /// `getStringFormatTypeKind(v)`.
    pub fn get_string_format_type_kind(&self, v: Value) -> Result<TypeKind> {
        match v {
            Value::StringFormat(kind) => Ok(kind),
            _ => panic("Trying to get index for value with invalid tag"),
        }
    }

    fn context(&mut self) -> Result<&mut Context> {
        defined(self.ctx.as_mut())
    }

    /// `internString(s)`. Like the TypeScript, whose index is a plain
    /// object, `"__proto__"` is never found again and gets a new index each
    /// time (harmless: strings are compared by content).
    fn intern_string(&mut self, s: &str) -> u32 {
        intern(&mut self.strings, &mut self.string_indexes, s)
    }

    /// `makeString(s)`.
    fn make_string(&mut self, s: &str) -> Value {
        Value::InternedString(self.intern_string(s))
    }

    /// `isExpectingRef`.
    fn is_expecting_ref(&self) -> bool {
        self.ctx
            .as_ref()
            .is_some_and(|ctx| ctx.current_key.as_deref() == Some("$ref"))
    }

    /// `commitValue(value)`.
    fn commit_value(&mut self, value: Value) -> Result<()> {
        let Some(ctx) = &mut self.ctx else {
            assert(
                self.root_value.is_none(),
                "Committing value but nowhere to commit to - root value still there.",
            )?;
            self.root_value = Some(value);
            return Ok(());
        };
        if let Some(object) = &mut ctx.current_object {
            let Some(key) = ctx.current_key.take() else {
                return panic("Must have key and can't have string when committing");
            };
            let key = intern(&mut self.strings, &mut self.string_indexes, &key);
            object.push((Value::InternedString(key), value));
            Ok(())
        } else if let Some(array) = &mut ctx.current_array {
            array.push(value);
            Ok(())
        } else {
            panic("Committing value but nowhere to commit to")
        }
    }

    /// `commitNull()`.
    pub fn commit_null(&mut self) -> Result<()> {
        self.commit_value(Value::Null)
    }

    /// `commitBoolean(v)`.
    pub fn commit_boolean(&mut self, v: bool) -> Result<()> {
        self.commit_value(if v { Value::True } else { Value::False })
    }

    /// `commitNumber(isDouble)`.
    pub fn commit_number(&mut self, is_double: bool) -> Result<()> {
        self.commit_value(if is_double {
            Value::Double
        } else {
            Value::Integer
        })
    }

    /// `commitString(s)`: classifies the string and commits it.
    pub fn commit_string(&mut self, s: &str) -> Result<()> {
        let value = if self.handle_refs && self.is_expecting_ref() {
            self.make_string(s)
        } else {
            match infer_transformed_string_type_kind_for_string(s, self.date_time_recognizer()) {
                Some(kind) if transformed_string_type_attributes_producer(kind).is_some() => {
                    Value::TransformedString(self.intern_string(s))
                }
                Some(kind) => Value::StringFormat(kind),
                None if utf16::len(s) <= 64 => self.make_string(s),
                None => Value::UninternedString,
            }
        };
        self.commit_value(value)
    }

    /// `finish()`: the root value of the sample just read.
    pub fn finish(&mut self) -> Result<Value> {
        let Some(value) = self.root_value.take() else {
            return panic("Finished without root document");
        };
        assert(
            self.ctx.is_none() && self.context_stack.is_empty(),
            "Finished with contexts present",
        )?;
        Ok(value)
    }

    /// `pushContext()`.
    fn push_context(&mut self) {
        if let Some(ctx) = self.ctx.take() {
            self.context_stack.push(ctx);
        }
        self.ctx = Some(Context::default());
    }

    /// `popContext()`.
    fn pop_context(&mut self) -> Result<()> {
        assert(self.ctx.is_some(), "Popping context when there isn't one")?;
        self.ctx = self.context_stack.pop();
        Ok(())
    }

    /// `pushObjectContext()`: an object starts.
    pub fn push_object_context(&mut self) {
        self.push_context();
        if let Some(ctx) = &mut self.ctx {
            ctx.current_object = Some(Vec::new());
        }
    }

    /// `setPropertyKey(key)`: the key of the next value in the object.
    pub fn set_property_key(&mut self, key: &str) -> Result<()> {
        self.context()?.current_key = Some(key.to_owned());
        Ok(())
    }

    /// `finishObject()`: the object ends.
    pub fn finish_object(&mut self) -> Result<()> {
        let Some(object) = self.context()?.current_object.take() else {
            return panic("Object ended but not started");
        };
        self.pop_context()?;
        let index = self.objects.len() as u32;
        self.objects.push(object);
        self.commit_value(Value::Object(index))
    }

    /// `pushArrayContext()`: an array starts.
    pub fn push_array_context(&mut self) {
        self.push_context();
        if let Some(ctx) = &mut self.ctx {
            ctx.current_array = Some(Vec::new());
        }
    }

    /// `finishArray()`: the array ends.
    pub fn finish_array(&mut self) -> Result<()> {
        let Some(array) = self.context()?.current_array.take() else {
            return panic("Array ended but not started");
        };
        self.pop_context()?;
        let index = self.arrays.len() as u32;
        self.arrays.push(array);
        self.commit_value(Value::Array(index))
    }

    /// Clears a half-read sample after a reader failed, so the instance can
    /// read further samples (the TypeScript leaves the state as is; it is
    /// never used again because the error ends the run).
    pub fn reset_partial_sample(&mut self) {
        self.root_value = None;
        self.ctx = None;
        self.context_stack.clear();
    }
}

/// `internString(s)` on the string tables.
fn intern(strings: &mut Vec<String>, indexes: &mut HashMap<String, u32>, s: &str) -> u32 {
    if let Some(&index) = indexes.get(s) {
        return index;
    }
    let index = strings.len() as u32;
    strings.push(s.to_owned());
    if s != "__proto__" {
        indexes.insert(s.to_owned(), index);
    }
    index
}

/// An exception while reading a sample. [`JsonInput`](super::inputs::JsonInput)
/// reports its [`message`](Self::message) (TS `errorMessage(e)`) as a
/// `MiscJSONParseError`.
#[derive(Clone, Debug, PartialEq)]
pub enum ParseError {
    /// A JavaScript `Error` thrown by the JSON parser (`JSON.parse`'s
    /// `SyntaxError`, stream-json's `Error`), by its `message`.
    Syntax(String),
    /// A quicktype error raised while building the compressed form.
    Quicktype(QuickTypeError),
}

impl ParseError {
    /// The error's `message`.
    pub fn message(&self) -> &str {
        match self {
            ParseError::Syntax(message) => message,
            ParseError::Quicktype(e) => e.user_message(),
        }
    }
}

impl fmt::Display for ParseError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.message())
    }
}

impl std::error::Error for ParseError {}

impl From<QuickTypeError> for ParseError {
    fn from(e: QuickTypeError) -> Self {
        ParseError::Quicktype(e)
    }
}

/// A way to read JSON samples into a [`CompressedJson`]: TS's abstract
/// `parse(input: T)` / `parseSync(input: T)` of `CompressedJSON<T>`, which
/// the subclasses implement.
pub trait CompressedJsonReader {
    /// The sample type (TS `T`).
    type Sample;

    /// The compressed form the samples are read into.
    fn compressed_json(&self) -> &CompressedJson;

    /// `parseSync(sample)`: reads one sample and returns its root value.
    fn parse_sync(&mut self, sample: Self::Sample) -> Result<Value, ParseError>;

    /// `parse(sample)`. Reading itself is synchronous in Rust; the future
    /// exists so readers that wait for input can be added without changing
    /// [`JsonInput`](super::inputs::JsonInput).
    fn parse(&mut self, sample: Self::Sample) -> impl Future<Output = Result<Value, ParseError>> {
        std::future::ready(self.parse_sync(sample))
    }
}

/// `CompressedJSONFromString`: reads samples with `JSON.parse` semantics,
/// as quicktype-core's JavaScript API does.
///
/// ```
/// use quicktype_core::date_time::DefaultDateTimeRecognizer;
/// use quicktype_core::input::compressed_json::{
///     CompressedJson, CompressedJsonFromString, CompressedJsonReader, ParseError, Value,
/// };
///
/// let cjson = CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), false);
/// let mut reader = CompressedJsonFromString::new(cjson);
/// assert_eq!(reader.parse_sync("1.0".to_owned()), Ok(Value::Integer));
/// assert_eq!(
///     reader.parse_sync("[1,".to_owned()),
///     Err(ParseError::Syntax("Unexpected end of JSON input".to_owned()))
/// );
/// ```
#[derive(Debug)]
pub struct CompressedJsonFromString {
    cjson: CompressedJson,
}

impl CompressedJsonFromString {
    /// A reader that fills `cjson`.
    pub fn new(cjson: CompressedJson) -> Self {
        CompressedJsonFromString { cjson }
    }

    /// `process(json)`, iteratively: walks the parsed value in
    /// `Object.getOwnPropertyNames` order.
    fn process(&mut self, json: &JsonValue) -> Result<()> {
        enum Step<'a> {
            Value(&'a JsonValue),
            Key(&'a str),
            FinishObject,
            FinishArray,
        }
        let cjson = &mut self.cjson;
        let mut steps = vec![Step::Value(json)];
        while let Some(step) = steps.pop() {
            match step {
                Step::Value(JsonValue::Null) => cjson.commit_null()?,
                Step::Value(JsonValue::Bool(b)) => cjson.commit_boolean(*b)?,
                Step::Value(JsonValue::String(s)) => cjson.commit_string(s)?,
                Step::Value(JsonValue::Number(n)) => {
                    let is_double = cjson.parsed_number_is_double(*n);
                    cjson.commit_number(is_double)?;
                }
                Step::Value(JsonValue::Array(items)) => {
                    cjson.push_array_context();
                    steps.push(Step::FinishArray);
                    steps.extend(items.iter().rev().map(Step::Value));
                }
                Step::Value(JsonValue::Object(map)) => {
                    cjson.push_object_context();
                    steps.push(Step::FinishObject);
                    for (key, value) in map.iter().rev() {
                        steps.push(Step::Value(value));
                        steps.push(Step::Key(key));
                    }
                }
                Step::Key(key) => cjson.set_property_key(key)?,
                Step::FinishObject => cjson.finish_object()?,
                Step::FinishArray => cjson.finish_array()?,
            }
        }
        Ok(())
    }
}

impl CompressedJsonReader for CompressedJsonFromString {
    type Sample = String;

    fn compressed_json(&self) -> &CompressedJson {
        &self.cjson
    }

    /// `parseSync(input)`: `JSON.parse`, then `process`.
    fn parse_sync(&mut self, sample: String) -> Result<Value, ParseError> {
        let json = json::parse(&sample).map_err(|e| ParseError::Syntax(e.message().to_owned()))?;
        let result = self.process(&json).and_then(|()| self.cjson.finish());
        if result.is_err() {
            self.cjson.reset_partial_sample();
        }
        // Dropping a deeply nested value recurses; drop it iteratively.
        drop_iteratively(json);
        Ok(result?)
    }
}

/// Drops a [`JsonValue`] without recursing, so deep nesting cannot
/// overflow the stack.
pub(crate) fn drop_iteratively(value: JsonValue) {
    let mut stack = vec![value];
    while let Some(value) = stack.pop() {
        match value {
            JsonValue::Array(items) => stack.extend(items),
            JsonValue::Object(map) => stack.extend(map.into_values()),
            _ => {}
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;

    fn reader(range: Option<IntegerRange>) -> CompressedJsonFromString {
        CompressedJsonFromString::new(CompressedJson::new(
            Box::new(DefaultDateTimeRecognizer),
            false,
            range,
        ))
    }

    #[test]
    fn number_classification_like_json_parse() {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let mut kind = |s: &str| r.parse_sync(s.to_owned()).unwrap();
        assert_eq!(kind("1.0"), Value::Integer);
        assert_eq!(kind("1e2"), Value::Integer);
        assert_eq!(kind("-0.0"), Value::Integer);
        assert_eq!(kind("1.5"), Value::Double);
        assert_eq!(kind("9223372036854775807"), Value::Double);
        assert_eq!(kind("9223372036854774784"), Value::Integer);
        assert_eq!(kind("-9223372036854775809"), Value::Integer);
        assert_eq!(kind("1e21"), Value::Double);
        assert_eq!(kind("1e400"), Value::Double);
        let mut unbounded = reader(None);
        assert_eq!(
            unbounded.parse_sync("1e400".into()).unwrap(),
            Value::Integer
        );
        assert_eq!(
            unbounded
                .parse_sync("123456789012345678901234567890".into())
                .unwrap(),
            Value::Integer
        );
    }

    #[test]
    fn strings_are_classified_and_interned() {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let v = r
            .parse_sync(r#"["2020-01-01", "x", "x", "http://a/b.JPG", "1"]"#.into())
            .unwrap();
        let cjson = r.compressed_json();
        let items = cjson.get_array_for_value(v).unwrap();
        assert_eq!(items[0], Value::StringFormat(TypeKind::Date));
        assert_eq!(items[1], items[2]);
        assert_eq!(cjson.get_string_for_value(items[1]).unwrap(), "x");
        assert!(matches!(items[3], Value::TransformedString(_)));
        assert_eq!(items[4], Value::StringFormat(TypeKind::IntegerString));
        let long = "é".repeat(65);
        assert_eq!(
            r.parse_sync(format!("\"{long}\"")).unwrap(),
            Value::UninternedString
        );
    }

    #[test]
    fn objects_keep_js_property_order() {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let v = r.parse_sync(r#"{"b":1,"1":2,"b":"x"}"#.into()).unwrap();
        let cjson = r.compressed_json();
        let entries = cjson.get_object_for_value(v).unwrap();
        let keys: Vec<&str> = entries
            .iter()
            .map(|(k, _)| cjson.get_string_for_value(*k).unwrap())
            .collect();
        assert_eq!(keys, ["1", "b"]);
        assert!(matches!(entries[1].1, Value::InternedString(_)));
    }
}
