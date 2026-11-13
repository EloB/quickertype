//! The JavaScript side of the boundary: reading the facade's request,
//! calling its host callbacks, and building the result and error values.
//!
//! Every call into JavaScript that can run user code (a schema store,
//! `onTiming`, a replaced `console.log`) is made with `catch`: a thrown
//! exception must never unwind through WebAssembly frames, which would skip
//! Rust destructors and leave borrows held. What it threw is kept by the
//! run's [`JsHost`] and rethrown unchanged when the run returns.

use std::cell::{Cell, RefCell};
use std::collections::HashMap;
use std::future::Future;
use std::pin::Pin;
use std::rc::Rc;
use std::task::{Context, Poll};

use js_sys::{Array, Object, Reflect};
use quicktype_core::internal::{CompressedJsonTables, CompressedTopLevel};
use quicktype_core::{
    Clock, CommentOptions, DebugOptions, INFERENCE_FLAGS, JsErrorName, JsonSchema, LocalBoxFuture,
    MessageValue, MultiFileRenderResult, OptionValue, QuickTypeError, Result,
};
use wasm_bindgen::JsCast;
use wasm_bindgen::prelude::*;

use crate::assemble::RunHost;
use crate::wire::{
    CommentRequest, DateTimeKind, EncodedValue, InputRequest, Request, SchemaSource, Sourcelike,
    WireError, decode_value, join_blob, split_blob,
};

#[wasm_bindgen]
extern "C" {
    /// The host object of `npm/quicktype-core/src/native/bridge.ts`.
    pub type HostObject;

    #[wasm_bindgen(method, catch, js_name = schemaPrepare)]
    fn schema_prepare(this: &HostObject, store_id: u32) -> std::result::Result<(), JsValue>;

    /// Starts `store.get(address, …)`; the facade later calls `settle`
    /// with `call_id` and the outcome.
    #[wasm_bindgen(method, catch, js_name = schemaGet)]
    fn schema_get(
        this: &HostObject,
        store_id: u32,
        address: &str,
        call_id: u32,
    ) -> std::result::Result<(), JsValue>;

    #[wasm_bindgen(method, catch, js_name = schemaTopLevels)]
    fn schema_top_levels(
        this: &HostObject,
        store_id: u32,
        names: Vec<String>,
        refs: Vec<String>,
    ) -> std::result::Result<(), JsValue>;

    #[wasm_bindgen(method, catch)]
    fn timing(this: &HostObject, name: &str, milliseconds: f64)
    -> std::result::Result<(), JsValue>;

    /// JavaScript `String(value)`.
    #[wasm_bindgen(catch, js_name = String)]
    fn js_string(value: &JsValue) -> std::result::Result<String, JsValue>;

    #[wasm_bindgen(method, catch)]
    fn log(this: &HostObject, line: &str) -> std::result::Result<(), JsValue>;

    #[wasm_bindgen(method, catch)]
    fn error(this: &HostObject, line: &str) -> std::result::Result<(), JsValue>;

    #[wasm_bindgen(method, catch)]
    fn now(this: &HostObject) -> std::result::Result<f64, JsValue>;

    #[wasm_bindgen(method, js_name = panicked)]
    fn panicked(this: &HostObject, message: &str);

    /// A value encoded by the facade's `encodeValue`.
    type EncodedObject;

    #[wasm_bindgen(method, getter)]
    fn tags(this: &EncodedObject) -> Vec<u8>;
    #[wasm_bindgen(method, getter)]
    fn numbers(this: &EncodedObject) -> Vec<f64>;
    #[wasm_bindgen(method, getter)]
    fn counts(this: &EncodedObject) -> Vec<u32>;
    #[wasm_bindgen(method, getter)]
    fn strings(this: &EncodedObject) -> String;
    #[wasm_bindgen(method, getter, js_name = stringLengths)]
    fn string_lengths(this: &EncodedObject) -> Vec<u32>;

    /// The facade's request (`encodeRequest`).
    type RequestObject;

    #[wasm_bindgen(method, getter)]
    fn lang(this: &RequestObject) -> String;
    #[wasm_bindgen(method, getter, js_name = rendererOptionNames)]
    fn renderer_option_names(this: &RequestObject) -> Vec<String>;
    #[wasm_bindgen(method, getter, js_name = rendererOptionValues)]
    fn renderer_option_values(this: &RequestObject) -> Vec<JsValue>;
    #[wasm_bindgen(method, getter)]
    fn switches(this: &RequestObject) -> JsValue;
    #[wasm_bindgen(method, getter, js_name = leadingComments)]
    fn leading_comments(this: &RequestObject) -> JsValue;
    #[wasm_bindgen(method, getter, js_name = outputFilename)]
    fn output_filename(this: &RequestObject) -> String;
    #[wasm_bindgen(method, getter)]
    fn indentation(this: &RequestObject) -> Option<String>;
    #[wasm_bindgen(method, getter)]
    fn inputs(this: &RequestObject) -> Vec<JsValue>;

    /// One entry of the request's `inputs`.
    type InputObject;

    #[wasm_bindgen(method, getter)]
    fn kind(this: &InputObject) -> String;
    // JSON
    #[wasm_bindgen(method, getter, js_name = handleRefs)]
    fn handle_refs(this: &InputObject) -> bool;
    #[wasm_bindgen(method, getter, js_name = dateTime)]
    fn date_time(this: &InputObject) -> String;
    #[wasm_bindgen(method, getter)]
    fn strings(this: &InputObject) -> String;
    #[wasm_bindgen(method, getter, js_name = stringLengths)]
    fn string_lengths(this: &InputObject) -> Vec<u32>;
    #[wasm_bindgen(method, getter)]
    fn objects(this: &InputObject) -> Vec<i32>;
    #[wasm_bindgen(method, getter, js_name = objectOffsets)]
    fn object_offsets(this: &InputObject) -> Vec<u32>;
    #[wasm_bindgen(method, getter)]
    fn arrays(this: &InputObject) -> Vec<i32>;
    #[wasm_bindgen(method, getter, js_name = arrayOffsets)]
    fn array_offsets(this: &InputObject) -> Vec<u32>;
    #[wasm_bindgen(method, getter, js_name = topLevelNames)]
    fn top_level_names(this: &InputObject) -> Vec<String>;
    #[wasm_bindgen(method, getter, js_name = topLevelDescriptions)]
    fn top_level_descriptions(this: &InputObject) -> Vec<JsValue>;
    #[wasm_bindgen(method, getter, js_name = topLevelSampleCounts)]
    fn top_level_sample_counts(this: &InputObject) -> Vec<u32>;
    #[wasm_bindgen(method, getter, js_name = topLevelSamples)]
    fn top_level_samples(this: &InputObject) -> Vec<i32>;
    // JSON Schema
    #[wasm_bindgen(method, getter, js_name = storeId)]
    fn store_id(this: &InputObject) -> u32;
    #[wasm_bindgen(method, getter, js_name = sourceUris)]
    fn source_uris(this: &InputObject) -> Vec<String>;
    #[wasm_bindgen(method, getter, js_name = sourceNames)]
    fn source_names(this: &InputObject) -> Vec<String>;
    #[wasm_bindgen(method, getter, js_name = sourceConverted)]
    fn source_converted(this: &InputObject) -> Vec<u8>;
    #[wasm_bindgen(method, getter, js_name = topLevelRefs)]
    fn top_level_refs(this: &InputObject) -> Vec<String>;
    #[wasm_bindgen(method, getter)]
    fn additional(this: &InputObject) -> Vec<String>;
}

fn wire(e: WireError) -> QuickTypeError {
    QuickTypeError::internal(format!(
        "Invalid request from the JavaScript facade: {}",
        e.0
    ))
}

fn get(object: &JsValue, key: &str) -> JsValue {
    Reflect::get(object, &JsValue::from_str(key)).unwrap_or(JsValue::UNDEFINED)
}

fn get_string(object: &JsValue, key: &str) -> Option<String> {
    get(object, key).as_string()
}

/// Reads the facade's request.
pub fn decode_request(value: &JsValue) -> Result<Request> {
    let req: &RequestObject = value.unchecked_ref();
    let switches = req.switches();
    let switch = |name: &str| get(&switches, name).as_bool() == Some(true);

    let mut inference_flags = quicktype_core::InferenceFlags::default();
    for flag in &INFERENCE_FLAGS {
        inference_flags.set(flag.name, switch(flag.js_name));
    }
    let debug = DebugOptions::default()
        .with_print_graph(switch("debugPrintGraph"))
        .with_print_reconstitution(switch("debugPrintReconstitution"))
        .with_print_gather_names(switch("debugPrintGatherNames"))
        .with_print_transformations(switch("debugPrintTransformations"))
        .with_print_schema_resolving(switch("debugPrintSchemaResolving"))
        .with_print_times(switch("debugPrintTimes"));

    let names = req.renderer_option_names();
    let values = req.renderer_option_values();
    if names.len() != values.len() {
        return Err(wire(WireError::new(
            "renderer option names and values differ in length",
        )));
    }
    let renderer_options = names
        .into_iter()
        .zip(values)
        .map(|(name, value)| Ok((name, option_value(&value)?)))
        .collect::<Result<Vec<_>>>()?;

    let inputs = req
        .inputs()
        .iter()
        .map(|input| decode_input(input.unchecked_ref()))
        .collect::<Result<Vec<_>>>()?;

    Ok(Request {
        lang: req.lang(),
        renderer_options,
        inference_flags,
        alphabetize_properties: switch("alphabetizeProperties"),
        all_properties_optional: switch("allPropertiesOptional"),
        fixed_top_levels: switch("fixedTopLevels"),
        no_render: switch("noRender"),
        check_provenance: switch("checkProvenance"),
        debug,
        leading_comments: decode_comments(&req.leading_comments())?,
        output_filename: req.output_filename(),
        indentation: req.indentation(),
        on_timing: switch("onTiming"),
        inputs,
    })
}

fn option_value(value: &JsValue) -> Result<OptionValue> {
    if value.is_null() {
        Ok(OptionValue::Null)
    } else if let Some(b) = value.as_bool() {
        Ok(OptionValue::Bool(b))
    } else if let Some(s) = value.as_string() {
        Ok(OptionValue::String(s))
    } else {
        Err(wire(WireError::new(
            "a renderer option value is not null, a boolean or a string",
        )))
    }
}

fn decode_input(input: &InputObject) -> Result<InputRequest> {
    match input.kind().as_str() {
        "json" => {
            let date_time = DateTimeKind::from_name(&input.date_time())
                .ok_or_else(|| wire(WireError::new("unknown date/time recognizer")))?;
            let strings = split_blob(&input.strings(), &input.string_lengths()).map_err(wire)?;
            let tables = CompressedJsonTables {
                strings,
                objects: input.objects(),
                object_offsets: input.object_offsets(),
                arrays: input.arrays(),
                array_offsets: input.array_offsets(),
            };
            let names = input.top_level_names();
            let descriptions = input.top_level_descriptions();
            let counts = input.top_level_sample_counts();
            let samples = input.top_level_samples();
            if descriptions.len() != names.len() || counts.len() != names.len() {
                return Err(wire(WireError::new("top-level arrays differ in length")));
            }
            let mut rest = samples.as_slice();
            let mut top_levels = Vec::with_capacity(names.len());
            for ((name, description), count) in names.into_iter().zip(descriptions).zip(counts) {
                let count = count as usize;
                if count > rest.len() {
                    return Err(wire(WireError::new("not enough top-level samples")));
                }
                let (mine, others) = rest.split_at(count);
                rest = others;
                top_levels.push(CompressedTopLevel {
                    name,
                    description: description.as_string(),
                    samples: mine.to_vec(),
                });
            }
            Ok(InputRequest::Json {
                handle_refs: input.handle_refs(),
                date_time,
                tables,
                top_levels,
            })
        }
        "schema" => {
            let uris = input.source_uris();
            let names = input.source_names();
            let converted = input.source_converted();
            if names.len() != uris.len() || converted.len() != uris.len() {
                return Err(wire(WireError::new(
                    "schema source arrays differ in length",
                )));
            }
            let sources = uris
                .into_iter()
                .zip(names)
                .zip(converted)
                .map(|((uri, name), converted)| SchemaSource {
                    uri,
                    name,
                    is_converted: converted != 0,
                })
                .collect();
            let names = input.top_level_names();
            let refs = input.top_level_refs();
            if names.len() != refs.len() {
                return Err(wire(WireError::new(
                    "schema top-level arrays differ in length",
                )));
            }
            Ok(InputRequest::Schema {
                store_id: input.store_id(),
                sources,
                top_levels: names.into_iter().zip(refs).collect(),
                additional: input.additional(),
            })
        }
        other => Err(wire(WireError::new(format!("unknown input kind {other}")))),
    }
}

fn decode_comments(value: &JsValue) -> Result<Option<Vec<quicktype_core::Comment>>> {
    if value.is_undefined() {
        return Ok(None);
    }
    let Some(entries) = value.dyn_ref::<Array>() else {
        return Err(wire(WireError::new("leadingComments is not an array")));
    };
    let mut comments = Vec::new();
    for entry in entries.iter() {
        let lines = || decode_sourcelikes(&get(&entry, "lines"));
        let comment = match get_string(&entry, "kind").as_deref() {
            Some("string") => {
                CommentRequest::String(get_string(&entry, "text").unwrap_or_default())
            }
            Some("lines") => CommentRequest::Lines(lines()?),
            Some("descriptionBlock") => CommentRequest::DescriptionBlock(lines()?),
            Some("custom") => CommentRequest::Custom {
                options: CommentOptions {
                    after_comment: get_string(&entry, "afterComment"),
                    before_comment: get_string(&entry, "beforeComment"),
                    first_line_start: get_string(&entry, "firstLineStart"),
                    line_end: get_string(&entry, "lineEnd"),
                    line_start: get_string(&entry, "lineStart"),
                },
                lines: lines()?,
            },
            _ => return Err(wire(WireError::new("unknown comment kind"))),
        };
        comments.push(comment.to_comment());
    }
    Ok(Some(comments))
}

fn decode_sourcelikes(value: &JsValue) -> Result<Vec<Sourcelike>> {
    let Some(items) = value.dyn_ref::<Array>() else {
        return Err(wire(WireError::new("comment lines are not an array")));
    };
    items
        .iter()
        .map(|item| decode_sourcelike(&item, 0))
        .collect()
}

fn decode_sourcelike(value: &JsValue, depth: usize) -> Result<Sourcelike> {
    if let Some(text) = value.as_string() {
        return Ok(Sourcelike::Text(text));
    }
    match value.dyn_ref::<Array>() {
        // The facade only sends shallow, string-only Sourcelikes.
        Some(items) if depth < 64 => Ok(Sourcelike::Sequence(
            items
                .iter()
                .map(|item| decode_sourcelike(&item, depth + 1))
                .collect::<Result<_>>()?,
        )),
        _ => Err(wire(WireError::new(
            "a comment line is not a string or an array",
        ))),
    }
}

fn decode_encoded_value(value: &JsValue) -> Result<Option<JsonSchema>> {
    if value.is_undefined() {
        return Ok(None);
    }
    let encoded: &EncodedObject = value.unchecked_ref();
    let strings = split_blob(&encoded.strings(), &encoded.string_lengths()).map_err(wire)?;
    decode_value(&EncodedValue {
        tags: encoded.tags(),
        numbers: encoded.numbers(),
        counts: encoded.counts(),
        strings,
    })
    .map_err(wire)
}

// ---------------------------------------------------------------------------
// The host of one run

/// A run's connection to the facade, and what JavaScript threw during it.
pub struct JsHost {
    object: HostObject,
    /// The host calls in flight, by call id: filled by [`JsHost::settle`].
    calls: RefCell<HashMap<u32, Rc<CallSlot>>>,
    next_call: Cell<u32>,
    /// Exceptions a callback threw, each with the [`QuickTypeError`] the
    /// engine propagated in its place.
    thrown: RefCell<Vec<(QuickTypeError, JsValue)>>,
    /// The first exception thrown where the engine cannot fail (`onTiming`,
    /// `console.log`, `performance.now`). TypeScript stops the run right
    /// there; the engine finishes, but every later callback and print is
    /// suppressed and the run ends with this exception.
    deferred: RefCell<Option<JsValue>>,
}

impl JsHost {
    pub fn new(object: JsValue) -> Rc<Self> {
        Rc::new(JsHost {
            object: object.unchecked_into(),
            calls: RefCell::new(HashMap::new()),
            next_call: Cell::new(0),
            thrown: RefCell::new(Vec::new()),
            deferred: RefCell::new(None),
        })
    }

    fn aborted(&self) -> bool {
        self.deferred.borrow().is_some()
    }

    fn defer(&self, exception: JsValue) {
        let mut deferred = self.deferred.borrow_mut();
        if deferred.is_none() {
            *deferred = Some(exception);
        }
    }

    /// Records an exception from a callback the engine can fail on, and
    /// returns the error the engine propagates in its place: a JavaScript
    /// exception with the same name and message, so that the text is right
    /// wherever the engine might quote it.
    fn thrown(&self, exception: JsValue) -> QuickTypeError {
        let name = get_string(&exception, "name")
            .and_then(|n| JsErrorName::from_name(&n))
            .unwrap_or(JsErrorName::Error);
        let message = match get(&exception, "message").as_string() {
            Some(message) if exception.is_object() => message,
            _ => js_string(&exception).unwrap_or_default(),
        };
        let error = QuickTypeError::js_exception(name, message);
        self.thrown.borrow_mut().push((error.clone(), exception));
        error
    }

    /// `console.log(line)` for the engine's debug output.
    pub fn log(&self, line: &str) {
        if !self.aborted() {
            if let Err(e) = self.object.log(line) {
                self.defer(e);
            }
        }
    }

    /// `console.error(line)`.
    pub fn error(&self, line: &str) {
        if !self.aborted() {
            if let Err(e) = self.object.error(line) {
                self.defer(e);
            }
        }
    }

    /// Fills the slot of host call `call_id` (from `schemaGet`) with its
    /// outcome; the facade polls the run afterwards.
    pub fn settle(&self, call_id: u32, outcome: std::result::Result<JsValue, JsValue>) {
        if let Some(slot) = self.calls.borrow_mut().remove(&call_id) {
            *slot.0.borrow_mut() = Some(outcome);
        }
    }

    /// Whether a host call is in flight (a pending run is waiting for
    /// one; otherwise it could never finish).
    pub fn waiting(&self) -> bool {
        !self.calls.borrow().is_empty()
    }

    /// Reports a Rust panic before the instance traps.
    pub fn panicked(&self, message: &str) {
        self.object.panicked(message);
    }

    /// The run's outcome as the facade expects it: the result, or the
    /// value to throw.
    /// The run's outcome as the facade expects it: `{ files }`,
    /// `{ error }` (see [`encode_error`]), `{ thrown }`, the value a
    /// callback threw, or `{ unsupported }`, the feature this port does not
    /// have yet ([`QuickTypeError::unsupported_feature`]), for which the
    /// facade runs TypeScript instead.
    pub fn finish(&self, result: Result<MultiFileRenderResult>) -> JsValue {
        let outcome = Object::new();
        if let Some(exception) = self.deferred.borrow_mut().take() {
            set(&outcome, "thrown", &exception);
            return outcome.into();
        }
        match result {
            Ok(files) => set(&outcome, "files", &encode_files(&files)),
            Err(error) if error.unsupported_feature().is_some() => {
                let feature = error.unsupported_feature().unwrap_or_default();
                set(&outcome, "unsupported", &JsValue::from_str(feature));
            }
            Err(error) => {
                let thrown = self.thrown.borrow();
                match thrown.iter().find(|(e, _)| *e == error) {
                    Some((_, exception)) => set(&outcome, "thrown", exception),
                    None => set(&outcome, "error", &encode_error(&error)),
                }
            }
        }
        outcome.into()
    }
}

impl RunHost for Rc<JsHost> {
    fn prepare_schema_input(&self, store_id: u32) -> Result<()> {
        self.object
            .schema_prepare(store_id)
            .map_err(|e| self.thrown(e))
    }

    fn schema_get(
        &self,
        store_id: u32,
        address: &str,
    ) -> LocalBoxFuture<'static, Result<Option<JsonSchema>>> {
        let host = Rc::clone(self);
        let call_id = self.next_call.get();
        self.next_call.set(call_id.wrapping_add(1));
        let slot = Rc::new(CallSlot(RefCell::new(None)));
        self.calls.borrow_mut().insert(call_id, Rc::clone(&slot));
        let started = self.object.schema_get(store_id, address, call_id);
        Box::pin(async move {
            if let Err(e) = started {
                host.calls.borrow_mut().remove(&call_id);
                return Err(host.thrown(e));
            }
            let value = CallFuture(slot).await.map_err(|e| host.thrown(e))?;
            decode_encoded_value(&value)
        })
    }

    fn schema_top_levels(&self, store_id: u32, top_levels: Vec<(String, String)>) {
        let (names, refs) = top_levels.into_iter().unzip();
        if let Err(e) = self.object.schema_top_levels(store_id, names, refs) {
            self.defer(e);
        }
    }

    fn timing(&self, name: &str, milliseconds: f64) {
        if !self.aborted() {
            if let Err(e) = self.object.timing(name, milliseconds) {
                self.defer(e);
            }
        }
    }

    fn clock(&self) -> Option<Clock> {
        let host = Rc::clone(self);
        Some(Rc::new(move || match host.object.now() {
            Ok(now) => now,
            Err(e) => {
                host.defer(e);
                0.0
            }
        }))
    }
}

/// Where the outcome of a host call lands.
pub struct CallSlot(RefCell<Option<std::result::Result<JsValue, JsValue>>>);

/// Waits for a [`CallSlot`]. Runs are polled by the facade (see `poll` in
/// the crate root), not by a waker, after each `settle`.
struct CallFuture(Rc<CallSlot>);

impl Future for CallFuture {
    type Output = std::result::Result<JsValue, JsValue>;

    fn poll(self: Pin<&mut Self>, _cx: &mut Context<'_>) -> Poll<Self::Output> {
        match self.0.0.borrow_mut().take() {
            Some(outcome) => Poll::Ready(outcome),
            None => Poll::Pending,
        }
    }
}

// ---------------------------------------------------------------------------
// Results and errors

fn set(object: &Object, key: &str, value: &JsValue) {
    // Setting a property on a fresh plain object cannot fail.
    let _ = Reflect::set(object, &JsValue::from_str(key), value);
}

/// `[{ name, text, lengths, spans, messages }]`: each file's lines as a
/// string blob, and its annotations as four numbers each (start line and
/// column, end line and column) plus their messages.
fn encode_files(files: &MultiFileRenderResult) -> JsValue {
    let list = Array::new();
    for (name, file) in files {
        let (text, lengths) = join_blob(file.lines.iter().map(String::as_str));
        let mut spans = Vec::with_capacity(file.annotations.len() * 4);
        let messages = Array::new();
        for annotation in &file.annotations {
            let span = annotation.span;
            spans.extend([
                span.start.line as f64,
                span.start.column as f64,
                span.end.line as f64,
                span.end.column as f64,
            ]);
            messages.push(&JsValue::from_str(annotation.annotation.message()));
        }
        let entry = Object::new();
        set(&entry, "name", &JsValue::from_str(name));
        set(&entry, "text", &JsValue::from_str(&text));
        set(
            &entry,
            "lengths",
            &js_sys::Uint32Array::from(lengths.as_slice()),
        );
        set(
            &entry,
            "spans",
            &js_sys::Float64Array::from(spans.as_slice()),
        );
        set(&entry, "messages", &messages);
        list.push(&entry);
    }
    list.into()
}

/// `{ qt: { kind, properties, message } }` for one of quicktype's
/// messages, which the facade turns back into a `QuickTypeError` with the
/// JavaScript `messageError` (`message` is only for checking); `{ js: {
/// name, message } }` for a JavaScript exception.
pub fn encode_error(error: &QuickTypeError) -> JsValue {
    let result = Object::new();
    match (error.message_name(), error.as_js_exception()) {
        (Some(kind), _) => {
            let properties = Array::new();
            for (name, value) in error.properties() {
                let pair = Array::new();
                pair.push(&JsValue::from_str(name));
                pair.push(&message_value(value));
                properties.push(&pair);
            }
            let qt = Object::new();
            set(&qt, "kind", &JsValue::from_str(kind));
            set(&qt, "properties", &properties);
            set(&qt, "message", &JsValue::from_str(error.user_message()));
            set(&result, "qt", &qt);
        }
        (None, Some(exception)) => {
            let js = Object::new();
            set(&js, "name", &JsValue::from_str(exception.name().as_str()));
            set(&js, "message", &JsValue::from_str(exception.message()));
            set(&result, "js", &js);
        }
        (None, None) => {
            let js = Object::new();
            set(&js, "name", &JsValue::from_str("Error"));
            set(&js, "message", &JsValue::from_str(error.user_message()));
            set(&result, "js", &js);
        }
    }
    result.into()
}

fn message_value(value: &MessageValue) -> JsValue {
    match value {
        MessageValue::Undefined => JsValue::UNDEFINED,
        MessageValue::Null => JsValue::NULL,
        MessageValue::Bool(b) => JsValue::from_bool(*b),
        MessageValue::Number(n) => JsValue::from_f64(*n),
        MessageValue::String(s) => JsValue::from_str(s),
        MessageValue::Array(items) => {
            let array = Array::new();
            for item in items {
                array.push(&message_value(item));
            }
            array.into()
        }
        MessageValue::Object(entries) => {
            let object = Object::new();
            for (k, v) in entries {
                set(&object, k, &message_value(v));
            }
            object.into()
        }
        MessageValue::Display(text) => {
            // An object with its own `toString()`: a JSON Schema `Ref`,
            // which the facade parses back.
            let object = Object::new();
            set(&object, "display", &JsValue::from_str(text));
            let wrapper = Object::new();
            set(&wrapper, "__qtDisplay", &object);
            wrapper.into()
        }
    }
}

/// A `{ error }` outcome for an internal error.
pub fn internal_error_outcome(message: &str) -> JsValue {
    let outcome = Object::new();
    set(
        &outcome,
        "error",
        &encode_error(&QuickTypeError::internal(message)),
    );
    outcome.into()
}
