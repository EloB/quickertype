//! Port of `packages/quicktype-core/src/input/JSONSchemaStore.ts`.
//!
//! A [`JsonSchemaStore`] hands out schema documents by address. Its
//! [`get`](JsonSchemaStore::get) caches what [`fetch`](JsonSchemaStore::fetch)
//! returns and **swallows every fetch error** (a missing file, invalid JSON,
//! a failed request all just mean "no schema"), exactly like the
//! TypeScript abstract class; the JSON Schema input then reports
//! `Could not fetch schema …`.

use std::collections::HashMap;
use std::rc::Rc;

use indexmap::IndexMap;
use quicktype_js_compat::json::JsonValue;

use crate::input::io::{LocalBoxFuture, grow_stack};
use crate::messages::{MessageValue, Result};
use crate::support::support::console_log;

/// `JSONSchema`: a schema document or any part of one, as the JavaScript
/// value `JSON.parse`/`YAML.parse` produced. Objects keep JavaScript
/// property order (array-index keys first). Collections are shared, so
/// cloning is cheap: the input hands out sub-schemas of cached documents
/// while it builds types.
#[derive(Clone, Debug, PartialEq)]
pub enum JsonSchema {
    /// `null`.
    Null,
    /// A boolean (also a valid schema: `true` is anything, `false` nothing).
    Bool(bool),
    /// A number (YAML can produce `NaN` and the infinities).
    Number(f64),
    /// A string.
    String(String),
    /// An array.
    Array(Rc<Vec<JsonSchema>>),
    /// An object.
    Object(Rc<IndexMap<String, JsonSchema>>),
}

impl From<JsonValue> for JsonSchema {
    /// Converts iteratively: `JSON.parse` accepts any nesting.
    fn from(value: JsonValue) -> Self {
        /// A collection being converted: what is done, and what is left.
        enum Frame {
            Array(Vec<JsonSchema>, std::vec::IntoIter<JsonValue>),
            Object(
                IndexMap<String, JsonSchema>,
                Option<String>,
                indexmap::map::IntoIter<String, JsonValue>,
            ),
        }

        /// What converting a value starts with.
        enum Start {
            Leaf(JsonSchema),
            Open(Frame),
        }

        /// A leaf, or the frame for a collection.
        fn start(mut value: JsonValue) -> Start {
            Start::Leaf(match &mut value {
                JsonValue::Null => JsonSchema::Null,
                JsonValue::Bool(b) => JsonSchema::Bool(*b),
                JsonValue::Number(n) => JsonSchema::Number(*n),
                JsonValue::String(s) => JsonSchema::String(std::mem::take(s)),
                JsonValue::Array(items) => {
                    let items = std::mem::take(items);
                    return Start::Open(Frame::Array(
                        Vec::with_capacity(items.len()),
                        items.into_iter(),
                    ));
                }
                JsonValue::Object(map) => {
                    let map = std::mem::take(map);
                    return Start::Open(Frame::Object(
                        IndexMap::with_capacity(map.len()),
                        None,
                        map.into_iter(),
                    ));
                }
            })
        }

        let mut stack: Vec<Frame> = Vec::new();
        let mut done = match start(value) {
            Start::Leaf(leaf) => return leaf,
            Start::Open(frame) => {
                stack.push(frame);
                None
            }
        };
        loop {
            let Some(frame) = stack.last_mut() else {
                return done.unwrap_or(JsonSchema::Null);
            };
            // Store the value just converted, then take the next child.
            let next = match frame {
                Frame::Array(items, rest) => {
                    if let Some(value) = done.take() {
                        items.push(value);
                    }
                    rest.next()
                }
                Frame::Object(map, key, rest) => {
                    if let (Some(value), Some(k)) = (done.take(), key.take()) {
                        map.insert(k, value);
                    }
                    rest.next().map(|(k, v)| {
                        *key = Some(k);
                        v
                    })
                }
            };
            match next {
                Some(child) => match start(child) {
                    Start::Leaf(leaf) => done = Some(leaf),
                    Start::Open(frame) => stack.push(frame),
                },
                None => {
                    done = Some(match stack.pop() {
                        Some(Frame::Array(items, _)) => JsonSchema::Array(Rc::new(items)),
                        Some(Frame::Object(map, _, _)) => JsonSchema::Object(Rc::new(map)),
                        None => JsonSchema::Null,
                    });
                }
            }
        }
    }
}

/// Dropping a deeply nested schema would recurse once per level; this
/// takes the children apart iteratively instead.
impl Drop for JsonSchema {
    fn drop(&mut self) {
        fn take_children(value: &mut JsonSchema, out: &mut Vec<JsonSchema>) {
            match value {
                JsonSchema::Array(items) => {
                    if let Some(items) = Rc::get_mut(items) {
                        out.append(items);
                    }
                }
                JsonSchema::Object(map) => {
                    if let Some(map) = Rc::get_mut(map) {
                        out.extend(map.drain(..).map(|(_, v)| v));
                    }
                }
                _ => {}
            }
        }
        let mut pending = Vec::new();
        take_children(self, &mut pending);
        while let Some(mut value) = pending.pop() {
            take_children(&mut value, &mut pending);
        }
    }
}

/// Values nested deeper than this become their `String(value)` in error
/// properties, which keeps every `MessageValue` shallow.
const MESSAGE_VALUE_DEPTH: usize = 64;

impl JsonSchema {
    /// `schema[key]` for an object; `None` (JavaScript `undefined`) for a
    /// missing key or a non-object.
    pub fn get(&self, key: &str) -> Option<&JsonSchema> {
        match self {
            JsonSchema::Object(map) => map.get(key),
            _ => None,
        }
    }

    /// The object's properties, if it is an object (not an array or
    /// `null`).
    pub fn as_object(&self) -> Option<&IndexMap<String, JsonSchema>> {
        match self {
            JsonSchema::Object(map) => Some(map),
            _ => None,
        }
    }

    /// The array's items, if it is an array.
    pub fn as_array(&self) -> Option<&[JsonSchema]> {
        match self {
            JsonSchema::Array(items) => Some(items),
            _ => None,
        }
    }

    /// The string, if it is one.
    pub fn as_str(&self) -> Option<&str> {
        match self {
            JsonSchema::String(s) => Some(s),
            _ => None,
        }
    }

    /// JavaScript `typeof`: `"object"` for objects, arrays and `null`.
    pub fn type_of(&self) -> &'static str {
        match self {
            JsonSchema::Null | JsonSchema::Array(_) | JsonSchema::Object(_) => "object",
            JsonSchema::Bool(_) => "boolean",
            JsonSchema::Number(_) => "number",
            JsonSchema::String(_) => "string",
        }
    }

    /// JavaScript truthiness.
    pub fn is_truthy(&self) -> bool {
        match self {
            JsonSchema::Null => false,
            JsonSchema::Bool(b) => *b,
            JsonSchema::Number(n) => *n != 0.0 && !n.is_nan(),
            JsonSchema::String(s) => !s.is_empty(),
            JsonSchema::Array(_) | JsonSchema::Object(_) => true,
        }
    }

    /// The value as a property of a quicktype error message (`messageError`
    /// stringifies it by its JavaScript type).
    pub fn to_message_value(&self) -> MessageValue {
        self.message_value_at(0)
    }

    fn message_value_at(&self, depth: usize) -> MessageValue {
        if depth > MESSAGE_VALUE_DEPTH {
            return MessageValue::Display(self.to_js_string());
        }
        match self {
            JsonSchema::Null => MessageValue::Null,
            JsonSchema::Bool(b) => MessageValue::Bool(*b),
            JsonSchema::Number(n) => MessageValue::Number(*n),
            JsonSchema::String(s) => MessageValue::String(s.clone()),
            JsonSchema::Array(items) => MessageValue::Array(
                items
                    .iter()
                    .map(|item| item.message_value_at(depth + 1))
                    .collect(),
            ),
            JsonSchema::Object(map) => MessageValue::Object(
                map.iter()
                    .map(|(k, v)| (k.clone(), v.message_value_at(depth + 1)))
                    .collect(),
            ),
        }
    }

    /// JavaScript `String(value)` (`` `${value}` ``): objects are
    /// `[object Object]`, arrays join their items with `,`.
    pub fn to_js_string(&self) -> String {
        grow_stack(|| match self {
            JsonSchema::Null => "null".to_owned(),
            JsonSchema::Bool(b) => b.to_string(),
            JsonSchema::Number(n) => quicktype_js_compat::number::to_string(*n),
            JsonSchema::String(s) => s.clone(),
            JsonSchema::Object(_) => "[object Object]".to_owned(),
            JsonSchema::Array(items) => items
                .iter()
                .map(|item| match item {
                    JsonSchema::Null => String::new(),
                    other => other.to_js_string(),
                })
                .collect::<Vec<_>>()
                .join(","),
        })
    }
}

/// `checkArray(x, checkItem)` of `support/Support.ts` for schema values:
/// the items, or an internal error (`Value must be an array, but is …`,
/// `Array item does not satisfy constraint: …`).
pub(crate) fn check_array(
    x: &JsonSchema,
    check_item: impl Fn(&JsonSchema) -> bool,
) -> Result<&[JsonSchema]> {
    let JsonSchema::Array(items) = x else {
        return crate::support::support::panic(format!(
            "Value must be an array, but is {}",
            x.to_js_string()
        ));
    };
    if let Some(item) = items.iter().find(|item| !check_item(item)) {
        return crate::support::support::panic(format!(
            "Array item does not satisfy constraint: {}",
            item.to_js_string()
        ));
    }
    Ok(items)
}

/// The schemas a store has handed out (the private `_schemas` map of
/// TypeScript's `JSONSchemaStore`).
#[derive(Clone, Debug, Default)]
pub struct SchemaCache {
    schemas: HashMap<String, JsonSchema>,
}

impl SchemaCache {
    /// An empty cache.
    pub fn new() -> Self {
        Self::default()
    }

    /// The cached schema for `address`.
    pub fn get(&self, address: &str) -> Option<&JsonSchema> {
        self.schemas.get(address)
    }

    /// `add(address, schema)`: caches a schema; an address is only ever
    /// added once.
    pub fn add(&mut self, address: &str, schema: JsonSchema) {
        self.schemas.entry(address.to_owned()).or_insert(schema);
    }
}

/// `JSONSchemaStore`: where the JSON Schema input gets schema documents.
///
/// Implement [`fetch`](Self::fetch) (and give the store a [`SchemaCache`]);
/// [`get`](Self::get) is what the input calls. A host whose own store
/// already caches and prints (the WebAssembly facade's JavaScript store)
/// overrides `get` instead.
pub trait JsonSchemaStore {
    /// `fetch(address)`: the schema at `address`, `None` if there is none.
    /// Errors are swallowed by [`get`](Self::get).
    fn fetch<'a>(&'a mut self, address: &'a str) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>>;

    /// The cache [`get`](Self::get) uses.
    fn cache(&mut self) -> &mut SchemaCache;

    /// `get(address, debugPrint)`: the cached schema, or the result of
    /// [`fetch`](Self::fetch), which is cached unless it is `None`. Fetch
    /// errors count as `None`. With `debug_print`
    /// (`--debug print-schema-resolving`) every fetch is logged.
    fn get<'a>(
        &'a mut self,
        address: &'a str,
        debug_print: bool,
    ) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        Box::pin(async move {
            if let Some(schema) = self.cache().get(address) {
                return Ok(Some(schema.clone()));
            }
            if debug_print {
                console_log(&format!("trying to fetch {address}"));
            }
            // FIXME (as in TypeScript): handle or log this error.
            let schema = self.fetch(address).await.ok().flatten();
            let Some(schema) = schema else {
                if debug_print {
                    console_log(&format!("couldn't fetch {address}"));
                }
                return Ok(None);
            };
            if debug_print {
                // sic: TypeScript's message has this typo.
                console_log(&format!("successully fetched {address}"));
            }
            self.cache().add(address, schema.clone());
            Ok(Some(schema))
        })
    }
}

impl<S: JsonSchemaStore + ?Sized> JsonSchemaStore for Box<S> {
    fn fetch<'a>(&'a mut self, address: &'a str) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        (**self).fetch(address)
    }

    fn cache(&mut self) -> &mut SchemaCache {
        (**self).cache()
    }

    fn get<'a>(
        &'a mut self,
        address: &'a str,
        debug_print: bool,
    ) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        (**self).get(address, debug_print)
    }
}
