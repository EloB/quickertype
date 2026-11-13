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
//! [`CompressedJson`] is the state and the builder (TS: the abstract class
//! `CompressedJSON<T>` and its protected methods). TypeScript reads samples
//! with one of two subclasses; here they are two methods, and a
//! [`JsonSample`] says which one reads it:
//!
//! - [`CompressedJson::parse_string`] (`CompressedJSONFromString`): the
//!   JavaScript API's reader, `JSON.parse` semantics (`1.0` is an integer,
//!   array-index keys come first, the last duplicate key wins, V8's error
//!   messages);
//! - [`CompressedJson::parse_stream`] (`CompressedJSONFromStream`, see
//!   [`compressed_json_from_stream`](crate::input::compressed_json_from_stream)):
//!   the CLI's reader, stream-json semantics (`1.0` is a double, source key
//!   order, duplicate keys kept, stream-json's error messages).
//!
//! The JavaScript facade can also hand over tables a JavaScript
//! `CompressedJSON` built ([`CompressedJsonTables`]).
//!
//! Differences from the TypeScript that cannot be observed: values are an
//! enum instead of tagged integers, objects are lists of key/value pairs, a
//! [`Value::StringFormat`] holds its kind instead of interning the kind's
//! name, and object keys are interned when they are read rather than when
//! their value is committed.

use std::cell::RefCell;
use std::fmt;
use std::io::Read;
use std::rc::Rc;

use quicktype_js_compat::json::{self, JsonValue};
use quicktype_js_compat::utf16;

use crate::attributes::string_types::infer_transformed_string_type_kind_for_string;
use crate::date_time::DateTimeRecognizer;
use crate::messages::{JsErrorName, JsException, QuickTypeError, Result};
use crate::renderer_options::RendererOptions;
use crate::support::fast_hash::HashMap;
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

/// One JSON sample, and which reader reads it (TS: the type `T` of
/// `JSONInput<T>` and the matching `CompressedJSON<T>` subclass).
#[non_exhaustive]
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum JsonSample {
    /// JSON text read with `JSON.parse` semantics, as quicktype-core's
    /// JavaScript API does (TS `CompressedJSONFromString`).
    String(String),
    /// The raw bytes of a file, URL body or standard input, read with the
    /// CLI's stream-json semantics (TS `CompressedJSONFromStream`).
    Stream(Vec<u8>),
    /// A file, standard input or any byte stream, read chunk by chunk with
    /// the CLI's stream-json semantics, so that it is never held whole (TS
    /// `CompressedJSONFromStream` on a Node `Readable`).
    Reader(SampleReader),
}

/// The byte stream of a [`JsonSample::Reader`]. It is shared, so that a
/// [`JsonSample`] can be cloned, and compares by identity; the first sample
/// that reads it consumes it.
#[derive(Clone)]
pub struct SampleReader(Rc<RefCell<Box<dyn Read>>>);

impl SampleReader {
    /// A sample read from `reader`. To report a failed read as Node's
    /// exception, let the reader's [`std::io::Error`] wrap an
    /// [`IoError`](crate::input::io::node_io::IoError) (see
    /// [`CompressedJson::parse_stream_reader`]).
    pub fn new(reader: impl Read + 'static) -> Self {
        SampleReader(Rc::new(RefCell::new(Box::new(reader))))
    }
}

impl PartialEq for SampleReader {
    fn eq(&self, other: &Self) -> bool {
        Rc::ptr_eq(&self.0, &other.0)
    }
}

impl Eq for SampleReader {}

impl fmt::Debug for SampleReader {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str("SampleReader(..)")
    }
}

impl From<String> for JsonSample {
    fn from(text: String) -> Self {
        JsonSample::String(text)
    }
}

impl From<&str> for JsonSample {
    fn from(text: &str) -> Self {
        JsonSample::String(text.to_owned())
    }
}

/// The state of an object or array being read (TS `Context`). The current
/// key is held interned.
#[derive(Debug, Default)]
struct Context {
    current_array: Option<Vec<Value>>,
    current_key: Option<u32>,
    current_object: Option<Vec<(Value, Value)>>,
}

/// The compressed form of the JSON samples of one input, and the builder
/// readers fill it with (TS `CompressedJSON<T>`).
///
/// One instance holds all samples of a [`JsonInput`](crate::input::inputs::JsonInput):
/// they share the string table.
pub struct CompressedJson {
    date_time_recognizer: Box<dyn DateTimeRecognizer>,
    handle_refs: bool,
    supported_integer_range: Option<IntegerRange>,
    root_value: Option<Value>,
    ctx: Option<Context>,
    context_stack: Vec<Context>,
    strings: Vec<Rc<str>>,
    /// Only looked up, never iterated; shares its keys with `strings`.
    string_indexes: HashMap<Rc<str>, u32>,
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
            string_indexes: HashMap::default(),
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
            Value::InternedString(i) | Value::TransformedString(i) => self.string_at(i),
            _ => panic("Trying to get index for value with invalid tag"),
        }
    }

    fn string_at(&self, index: u32) -> Result<&str> {
        Ok(defined(self.strings.get(index as usize))?)
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

    /// `internString(s)`: allocates `s` once, the first time it is seen.
    /// Like the TypeScript, whose index is a plain object, `"__proto__"` is
    /// never found again and gets a new index each time (harmless: strings
    /// are compared by content).
    fn intern_string(&mut self, s: &str) -> u32 {
        if let Some(&index) = self.string_indexes.get(s) {
            return index;
        }
        let index = self.strings.len() as u32;
        let s: Rc<str> = Rc::from(s);
        if &*s != "__proto__" {
            self.string_indexes.insert(Rc::clone(&s), index);
        }
        self.strings.push(s);
        index
    }

    /// `makeString(s)`.
    fn make_string(&mut self, s: &str) -> Value {
        Value::InternedString(self.intern_string(s))
    }

    /// `isExpectingRef`.
    fn is_expecting_ref(&self) -> bool {
        self.ctx
            .as_ref()
            .and_then(|ctx| ctx.current_key)
            .is_some_and(|key| {
                self.strings
                    .get(key as usize)
                    .is_some_and(|k| &**k == "$ref")
            })
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
        let key = self.intern_string(key);
        self.context()?.current_key = Some(key);
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

    /// Reads one sample with the reader it asks for.
    pub fn parse_sample(&mut self, sample: JsonSample) -> Result<Value, ParseError> {
        match sample {
            JsonSample::String(text) => self.parse_string(&text),
            JsonSample::Stream(bytes) => self.parse_stream(&bytes),
            JsonSample::Reader(reader) => {
                let mut reader = reader.0.borrow_mut();
                self.parse_stream_reader(&mut **reader)
            }
        }
    }

    /// `CompressedJSONFromString.parseSync(input)`: `JSON.parse`, then
    /// `process` the value in `Object.getOwnPropertyNames` order.
    ///
    /// ```
    /// use quicktype_core::date_time::DefaultDateTimeRecognizer;
    /// use quicktype_core::input::compressed_json::{CompressedJson, ParseError, Value};
    /// use quicktype_core::messages::{JsErrorName, JsException};
    ///
    /// let mut cjson = CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), false);
    /// assert_eq!(cjson.parse_string("1.0"), Ok(Value::Integer));
    /// assert_eq!(
    ///     cjson.parse_string("[1,"),
    ///     Err(ParseError::Js(JsException::new(
    ///         JsErrorName::SyntaxError,
    ///         "Unexpected end of JSON input"
    ///     )))
    /// );
    /// ```
    pub fn parse_string(&mut self, text: &str) -> Result<Value, ParseError> {
        let json = json::parse(text)
            .map_err(|e| ParseError::Js(JsException::new(JsErrorName::SyntaxError, e.message())))?;
        let result = self.process(&json).and_then(|()| self.finish());
        if result.is_err() {
            self.reset_partial_sample();
        }
        Ok(result?)
    }

    /// `process(json)`, iteratively.
    fn process(&mut self, json: &JsonValue) -> Result<()> {
        enum Step<'a> {
            Value(&'a JsonValue),
            Key(&'a str),
            FinishObject,
            FinishArray,
        }
        let mut steps = vec![Step::Value(json)];
        while let Some(step) = steps.pop() {
            match step {
                Step::Value(JsonValue::Null) => self.commit_null()?,
                Step::Value(JsonValue::Bool(b)) => self.commit_boolean(*b)?,
                Step::Value(JsonValue::String(s)) => self.commit_string(s)?,
                Step::Value(JsonValue::Number(n)) => {
                    let is_double = self.parsed_number_is_double(*n);
                    self.commit_number(is_double)?;
                }
                Step::Value(JsonValue::Array(items)) => {
                    self.push_array_context();
                    steps.push(Step::FinishArray);
                    steps.extend(items.iter().rev().map(Step::Value));
                }
                Step::Value(JsonValue::Object(map)) => {
                    self.push_object_context();
                    steps.push(Step::FinishObject);
                    for (key, value) in map.iter().rev() {
                        steps.push(Step::Value(value));
                        steps.push(Step::Key(key));
                    }
                }
                Step::Key(key) => self.set_property_key(key)?,
                Step::FinishObject => self.finish_object()?,
                Step::FinishArray => self.finish_array()?,
            }
        }
        Ok(())
    }

    /// The compressed form with a JavaScript `CompressedJSON`'s encoding,
    /// as the JavaScript facade sends it (research 05, §4.2), together
    /// with `roots` (sample values) encoded against it; the inverse of
    /// [`CompressedJson::from_tables`].
    pub fn to_tables(&self, roots: &[Value]) -> (CompressedJsonTables, Vec<i32>) {
        let mut strings: Vec<String> = self.strings.iter().map(|s| s.to_string()).collect();
        let mut kind_indexes: HashMap<TypeKind, u32> = HashMap::default();
        let mut encode = |v: Value| {
            encode_value(v, |kind| {
                *kind_indexes.entry(kind).or_insert_with(|| {
                    strings.push(kind.as_str().to_owned());
                    (strings.len() - 1) as u32
                })
            })
        };
        let mut objects = Vec::new();
        let mut object_offsets = Vec::with_capacity(self.objects.len());
        for object in &self.objects {
            object_offsets.push(objects.len() as u32);
            for &(key, value) in object {
                objects.push(encode(key));
                objects.push(encode(value));
            }
        }
        let mut arrays = Vec::new();
        let mut array_offsets = Vec::with_capacity(self.arrays.len());
        for array in &self.arrays {
            array_offsets.push(arrays.len() as u32);
            arrays.extend(array.iter().map(|&v| encode(v)));
        }
        let roots = roots.iter().map(|&v| encode(v)).collect();
        let tables = CompressedJsonTables {
            strings,
            objects,
            object_offsets,
            arrays,
            array_offsets,
        };
        (tables, roots)
    }

    /// Imports the tables a JavaScript `CompressedJSON` built (the facade's
    /// path into the engine, research 05 §4.2). The integer range only
    /// matters while reading, so the result has none.
    pub fn from_tables(
        date_time_recognizer: Box<dyn DateTimeRecognizer>,
        handle_refs: bool,
        tables: &CompressedJsonTables,
    ) -> Result<Self> {
        let mut cjson = CompressedJson::new(date_time_recognizer, handle_refs, None);
        for s in &tables.strings {
            let s: Rc<str> = Rc::from(s.as_str());
            if &*s != "__proto__" {
                let index = cjson.strings.len() as u32;
                cjson.string_indexes.entry(Rc::clone(&s)).or_insert(index);
            }
            cjson.strings.push(s);
        }
        let ranges = |offsets: &[u32], len: usize| -> Result<Vec<(usize, usize)>> {
            let mut ranges = Vec::with_capacity(offsets.len());
            for (i, &start) in offsets.iter().enumerate() {
                let end = offsets.get(i + 1).map_or(len, |&e| e as usize);
                if start as usize > end || end > len {
                    return panic("Invalid CompressedJSON table offsets");
                }
                ranges.push((start as usize, end));
            }
            Ok(ranges)
        };
        let object_ranges = ranges(&tables.object_offsets, tables.objects.len())?;
        let array_ranges = ranges(&tables.array_offsets, tables.arrays.len())?;
        let (object_count, array_count) = (object_ranges.len(), array_ranges.len());
        for (start, end) in object_ranges {
            let flat = &tables.objects[start..end];
            if flat.len() % 2 != 0 {
                return panic("An object in the CompressedJSON tables has a key without a value");
            }
            let mut object = Vec::with_capacity(flat.len() / 2);
            for pair in flat.chunks(2) {
                let key = cjson.decode_value(pair[0], object_count, array_count)?;
                if !matches!(key, Value::InternedString(_)) {
                    return panic(
                        "An object key in the CompressedJSON tables is not an interned string",
                    );
                }
                object.push((key, cjson.decode_value(pair[1], object_count, array_count)?));
            }
            cjson.objects.push(object);
        }
        for (start, end) in array_ranges {
            let array = tables.arrays[start..end]
                .iter()
                .map(|&v| cjson.decode_value(v, object_count, array_count))
                .collect::<Result<Vec<_>>>()?;
            cjson.arrays.push(array);
        }
        Ok(cjson)
    }

    /// Decodes a JavaScript `Value` (`tag | index << 4`) against the tables
    /// being imported.
    pub(crate) fn decode_value(
        &self,
        v: i32,
        object_count: usize,
        array_count: usize,
    ) -> Result<Value> {
        let tag = v & TAG_MASK;
        let index = (v >> TAG_BITS) as u32;
        let in_range = |count: usize| (index as usize) < count;
        let value = match tag {
            TAG_NULL => Value::Null,
            TAG_FALSE => Value::False,
            TAG_TRUE => Value::True,
            TAG_INTEGER => Value::Integer,
            TAG_DOUBLE => Value::Double,
            TAG_INTERNED_STRING if in_range(self.strings.len()) => Value::InternedString(index),
            TAG_UNINTERNED_STRING => Value::UninternedString,
            TAG_OBJECT if in_range(object_count) => Value::Object(index),
            TAG_ARRAY if in_range(array_count) => Value::Array(index),
            TAG_STRING_FORMAT => {
                let kind = TypeKind::from_str(self.string_at(index)?)
                    .filter(|k| k.is_transformed_string_type_kind());
                match kind {
                    Some(kind) => Value::StringFormat(kind),
                    None => return panic("Not a transformed string type kind"),
                }
            }
            TAG_TRANSFORMED_STRING if in_range(self.strings.len()) => {
                Value::TransformedString(index)
            }
            _ => return panic(format!("Invalid CompressedJSON value {v}")),
        };
        Ok(value)
    }

    /// The number of objects and arrays, for decoding values against this
    /// compressed form.
    pub(crate) fn counts(&self) -> (usize, usize) {
        (self.objects.len(), self.arrays.len())
    }
}

/// `Tag`: the low bits of an encoded `Value`.
const TAG_NULL: i32 = 1;
const TAG_FALSE: i32 = 2;
const TAG_TRUE: i32 = 3;
const TAG_INTEGER: i32 = 4;
const TAG_DOUBLE: i32 = 5;
const TAG_INTERNED_STRING: i32 = 6;
const TAG_UNINTERNED_STRING: i32 = 7;
const TAG_OBJECT: i32 = 8;
const TAG_ARRAY: i32 = 9;
const TAG_STRING_FORMAT: i32 = 10;
const TAG_TRANSFORMED_STRING: i32 = 11;
const TAG_BITS: i32 = 4;
const TAG_MASK: i32 = (1 << TAG_BITS) - 1;

/// The tables of a JavaScript `CompressedJSON` (research 05, §4.2), with
/// each `Value` encoded as in TypeScript: `tag | index << 4`, where a
/// `StringFormat` value's index is that of its kind's name in `strings`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct CompressedJsonTables {
    /// The string table.
    pub strings: Vec<String>,
    /// Every object's keys and values, `[k0, v0, k1, v1, …]`, concatenated.
    pub objects: Vec<i32>,
    /// Where each object starts in `objects`; it ends where the next one
    /// starts.
    pub object_offsets: Vec<u32>,
    /// Every array's elements, concatenated.
    pub arrays: Vec<i32>,
    /// Where each array starts in `arrays`.
    pub array_offsets: Vec<u32>,
}

/// Encodes a value as TypeScript does, `tag | index << 4`, with
/// `kind_index` giving the string index of a transformed kind's name.
fn encode_value(v: Value, kind_index: impl FnOnce(TypeKind) -> u32) -> i32 {
    let (tag, index) = match v {
        Value::Null => (TAG_NULL, 0),
        Value::False => (TAG_FALSE, 0),
        Value::True => (TAG_TRUE, 0),
        Value::Integer => (TAG_INTEGER, 0),
        Value::Double => (TAG_DOUBLE, 0),
        Value::InternedString(i) => (TAG_INTERNED_STRING, i),
        Value::UninternedString => (TAG_UNINTERNED_STRING, 0),
        Value::Object(i) => (TAG_OBJECT, i),
        Value::Array(i) => (TAG_ARRAY, i),
        Value::StringFormat(kind) => (TAG_STRING_FORMAT, kind_index(kind)),
        Value::TransformedString(i) => (TAG_TRANSFORMED_STRING, i),
    };
    tag | ((index as i32) << TAG_BITS)
}

/// An exception while reading a sample. [`JsonInput`](crate::input::inputs::JsonInput)
/// reports its [`message`](Self::message) (TS `errorMessage(e)`) as a
/// `MiscJSONParseError`, except for [`Read`](Self::Read) errors, which it
/// reports as they are.
#[derive(Clone, Debug, PartialEq)]
pub enum ParseError {
    /// A JavaScript exception thrown by the JSON parser: `JSON.parse`'s
    /// `SyntaxError`, stream-json's `Error`.
    Js(JsException),
    /// A quicktype error raised while building the compressed form.
    Quicktype(QuickTypeError),
    /// The sample's stream could not be read (in TypeScript, the stream's
    /// `error` event).
    Read(QuickTypeError),
}

impl ParseError {
    /// The error's `message`.
    pub fn message(&self) -> &str {
        match self {
            ParseError::Js(e) => e.message(),
            ParseError::Quicktype(e) | ParseError::Read(e) => e.user_message(),
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

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;

    fn cjson(range: Option<IntegerRange>) -> CompressedJson {
        CompressedJson::new(Box::new(DefaultDateTimeRecognizer), false, range)
    }

    #[test]
    fn integer_string_fits_the_range() {
        use crate::support::integer_range::INT32_RANGE;
        let r = cjson(Some(INT32_RANGE.clone()));
        for (s, fits) in [
            ("0", true),
            ("-0", true),
            ("2147483647", true),
            ("2147483648", false),
            ("-2147483648", true),
            ("-2147483649", false),
            ("000000000000000001", true),
            ("-000000000000000001", true),
            ("999999999999999999", false),
            ("99999999999999999999", false),
        ] {
            assert_eq!(r.integer_string_fits(s), fits, "{s}");
        }
        assert!(cjson(None).integer_string_fits("99999999999999999999"));
    }

    #[test]
    fn number_classification_like_json_parse() {
        let mut r = cjson(Some(INT64_RANGE.clone()));
        let mut kind = |s: &str| r.parse_string(s).unwrap();
        assert_eq!(kind("1.0"), Value::Integer);
        assert_eq!(kind("1e2"), Value::Integer);
        assert_eq!(kind("-0.0"), Value::Integer);
        assert_eq!(kind("1.5"), Value::Double);
        assert_eq!(kind("9223372036854775807"), Value::Double);
        assert_eq!(kind("9223372036854774784"), Value::Integer);
        assert_eq!(kind("-9223372036854775809"), Value::Integer);
        assert_eq!(kind("1e21"), Value::Double);
        assert_eq!(kind("1e400"), Value::Double);
        let mut unbounded = cjson(None);
        assert_eq!(unbounded.parse_string("1e400").unwrap(), Value::Integer);
        assert_eq!(
            unbounded
                .parse_string("123456789012345678901234567890")
                .unwrap(),
            Value::Integer
        );
    }

    #[test]
    fn strings_are_classified_and_interned() {
        let mut r = cjson(Some(INT64_RANGE.clone()));
        let v = r
            .parse_string(r#"["2020-01-01", "x", "x", "http://a/b.JPG", "1"]"#)
            .unwrap();
        let items = r.get_array_for_value(v).unwrap();
        assert_eq!(items[0], Value::StringFormat(TypeKind::Date));
        assert_eq!(items[1], items[2]);
        assert_eq!(r.get_string_for_value(items[1]).unwrap(), "x");
        assert!(matches!(items[3], Value::TransformedString(_)));
        assert_eq!(items[4], Value::StringFormat(TypeKind::IntegerString));
        let long = "é".repeat(65);
        let mut r = cjson(None);
        assert_eq!(
            r.parse_string(&format!("\"{long}\"")).unwrap(),
            Value::UninternedString
        );
    }

    #[test]
    fn objects_keep_js_property_order() {
        let mut r = cjson(Some(INT64_RANGE.clone()));
        let v = r.parse_string(r#"{"b":1,"1":2,"b":"x"}"#).unwrap();
        let entries = r.get_object_for_value(v).unwrap();
        let keys: Vec<&str> = entries
            .iter()
            .map(|(k, _)| r.get_string_for_value(*k).unwrap())
            .collect();
        assert_eq!(keys, ["1", "b"]);
        assert!(matches!(entries[1].1, Value::InternedString(_)));
    }

    #[test]
    fn keys_are_interned_once() {
        let mut r = cjson(None);
        r.parse_string(r#"[{"a":"a","__proto__":1},{"a":2,"__proto__":3}]"#)
            .unwrap();
        // "a" once; "__proto__" every time, like the TypeScript.
        let texts: Vec<&str> = r.strings.iter().map(|s| &**s).collect();
        assert_eq!(texts, ["a", "__proto__", "__proto__"]);
    }

    /// Deep samples are processed without recursion, on success and when
    /// `JSON.parse` fails after the root value or inside it.
    #[test]
    fn deep_nesting() {
        let n = 1_000_000;
        let deep = format!("{}{}", "[".repeat(n), "]".repeat(n));
        let mut r = cjson(None);
        assert!(matches!(r.parse_string(&deep), Ok(Value::Array(_))));
        assert_eq!(
            r.parse_string(&format!("{deep} x")).unwrap_err().message(),
            "Unexpected non-whitespace character after JSON at position 2000001 (line 1 column 2000002)"
        );
        assert!(
            r.parse_string(&format!("{}x", r#"{"a":["#.repeat(n / 2)))
                .is_err()
        );
        assert_eq!(r.parse_string("1"), Ok(Value::Integer));
    }

    #[test]
    fn tables_round_trip() {
        let mut r = cjson(Some(INT64_RANGE.clone()));
        let v = r
            .parse_string(
                r#"{"d":"2020-01-01","u":"http://h/p.png","s":["x",{"k":null}],"t":true}"#,
            )
            .unwrap();
        let date = r.parse_string(r#""2021-01-01""#).unwrap();
        let (tables, roots) = r.to_tables(&[v, date]);
        let imported =
            CompressedJson::from_tables(Box::new(DefaultDateTimeRecognizer), false, &tables)
                .unwrap();
        assert_eq!(imported.objects, r.objects);
        assert_eq!(imported.arrays, r.arrays);
        let (objects, arrays) = imported.counts();
        let decoded: Vec<Value> = roots
            .iter()
            .map(|&root| imported.decode_value(root, objects, arrays).unwrap())
            .collect();
        assert_eq!(decoded, [v, date]);
        let mut bad = tables.clone();
        bad.objects[0] = (99 << TAG_BITS) | TAG_INTERNED_STRING;
        assert!(
            CompressedJson::from_tables(Box::new(DefaultDateTimeRecognizer), false, &bad).is_err()
        );
    }
}
