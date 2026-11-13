//! Turns a decoded [`Request`] into the engine's [`Options`]: the inputs
//! become a [`JsonInput`] (from the facade's `CompressedJSON` tables) and
//! [`HostSchemaInput`]s (a [`JsonSchemaInput`] whose store is the facade's
//! JavaScript store), the rest maps field by field.
//!
//! The JavaScript side is reached only through [`RunHost`], so this module
//! runs natively in tests with a mock host.

use std::future::Future;
use std::rc::Rc;

use quicktype_core::{
    Clock, Input, InputData, JsonInput, JsonSchema, JsonSchemaInput, JsonSchemaSourceData,
    JsonSchemaStore, LocalBoxFuture, Options, QuickTypeError, Ref, RendererOptions, Result,
    RunContext, SchemaCache, TimingCallback, get_target_language,
};

use crate::wire::{DateTimeKind, InputRequest, Request};

/// What a run needs from the JavaScript facade.
pub trait RunHost {
    /// The first step of TS `JSONSchemaInput.addTypes` for input
    /// `store_id`, which the facade runs on the real input object: wrap
    /// the store in an `InputJSONSchemaStore` when schemas were given as
    /// text, or fail with `Must have a schema store to process JSON
    /// Schema`.
    fn prepare_schema_input(&self, store_id: u32) -> Result<()>;

    /// `store.get(address, debugPrintSchemaResolving)` on input
    /// `store_id`'s store; `None` for `undefined`.
    fn schema_get(
        &self,
        store_id: u32,
        address: &str,
    ) -> LocalBoxFuture<'static, Result<Option<JsonSchema>>>;

    /// After `JSONSchemaInput.addTypes` of input `store_id` succeeded: its
    /// `_topLevels` (name and `Ref.toString()`), which TypeScript keeps on
    /// the input object (a later run starts from them).
    fn schema_top_levels(&self, store_id: u32, top_levels: Vec<(String, String)>);

    /// `onTiming({ name, milliseconds })`.
    fn timing(&self, name: &str, milliseconds: f64);

    /// `performance.now`, if the host has one.
    fn clock(&self) -> Option<Clock>;
}

/// Builds the run's options.
pub fn assemble(request: Request, host: Rc<dyn RunHost>) -> Result<Options<'static>> {
    let lang = get_target_language(&request.lang)?;
    let mut input_data = InputData::new();
    for input in request.inputs {
        match input {
            InputRequest::Json {
                handle_refs,
                date_time,
                tables,
                top_levels,
            } => {
                let recognizer = match date_time {
                    DateTimeKind::Default => {
                        Box::new(quicktype_core::date_time::DefaultDateTimeRecognizer)
                    }
                    DateTimeKind::Kotlin => get_target_language("kotlin")?.date_time_recognizer(),
                    DateTimeKind::Swift => get_target_language("swift")?.date_time_recognizer(),
                };
                input_data.add_input(JsonInput::from_compressed(
                    &tables,
                    handle_refs,
                    recognizer,
                    top_levels,
                )?);
            }
            InputRequest::Schema {
                store_id,
                sources,
                top_levels,
                additional,
            } => {
                let store = HostSchemaStore {
                    host: Rc::clone(&host),
                    store_id,
                    cache: SchemaCache::new(),
                };
                let mut inner = JsonSchemaInput::new(Some(Box::new(store)), Vec::new(), additional);
                for (name, r) in top_levels {
                    inner.add_top_level(name, Ref::parse(&r)?);
                }
                let has_sources = !sources.is_empty();
                for source in sources {
                    inner.add_normalized_source(
                        &source.uri,
                        JsonSchemaSourceData {
                            name: source.name,
                            uris: None,
                            schema: None,
                            is_converted: source.is_converted,
                        },
                    )?;
                }
                input_data.add_input(HostSchemaInput {
                    inner,
                    host: Rc::clone(&host),
                    store_id,
                    has_sources,
                });
            }
        }
    }

    let renderer_options: RendererOptions = request.renderer_options.into_iter().collect();
    let on_timing: Option<TimingCallback> = if request.on_timing {
        let host = Rc::clone(&host);
        Some(Rc::new(move |t: &quicktype_core::QuicktypeTiming| {
            host.timing(&t.name, t.milliseconds)
        }))
    } else {
        None
    };
    Ok(Options::new(lang, input_data)
        .with_inference_flags(request.inference_flags)
        .with_alphabetize_properties(request.alphabetize_properties)
        .with_all_properties_optional(request.all_properties_optional)
        .with_fixed_top_levels(request.fixed_top_levels)
        .with_no_render(request.no_render)
        .with_check_provenance(request.check_provenance)
        .with_debug(request.debug)
        .with_leading_comments(request.leading_comments)
        .with_renderer_options(renderer_options)
        .with_indentation(request.indentation)
        .with_output_filename(request.output_filename)
        .with_on_timing(on_timing)
        .with_clock(host.clock()))
}

/// The facade's JavaScript store, as the engine sees it. `get` goes
/// straight to the JavaScript store's `get`, which caches, swallows fetch
/// errors and prints `--debug` traces itself (TS `JSONSchemaStore.get`).
struct HostSchemaStore {
    host: Rc<dyn RunHost>,
    store_id: u32,
    cache: SchemaCache,
}

impl JsonSchemaStore for HostSchemaStore {
    fn fetch<'a>(&'a mut self, address: &'a str) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        // `get` is overridden and nothing else calls `fetch` (the input
        // has no schema text of its own to wrap this store with).
        Box::pin(async move {
            Err(QuickTypeError::internal(format!(
                "The JavaScript schema store was asked to fetch {address} directly"
            )))
        })
    }

    fn cache(&mut self) -> &mut SchemaCache {
        &mut self.cache
    }

    fn get<'a>(
        &'a mut self,
        address: &'a str,
        _debug_print: bool,
    ) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        self.host.schema_get(self.store_id, address)
    }
}

/// A `JSONSchemaInput` whose first `addTypes` step (the store wrapping)
/// runs on the facade's object.
struct HostSchemaInput {
    inner: JsonSchemaInput,
    host: Rc<dyn RunHost>,
    store_id: u32,
    has_sources: bool,
}

impl Input for HostSchemaInput {
    type Source = JsonSchemaSourceData;

    fn kind(&self) -> &str {
        self.inner.kind()
    }

    fn need_ir(&self) -> bool {
        self.inner.need_ir()
    }

    fn need_schema_processing(&self) -> bool {
        self.inner.need_schema_processing()
    }

    fn add_source_sync(&mut self, source: Self::Source) -> Result<()> {
        self.inner.add_source_sync(source)
    }

    fn add_types(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut quicktype_core::ty::type_builder::TypeBuilder<'_>,
        _infer_maps: bool,
        _infer_enums: bool,
        _fixed_top_levels: bool,
    ) -> impl Future<Output = Result<()>> {
        let debug_print_schema_resolving = ctx.debug_print_schema_resolving;
        async move {
            if self.has_sources {
                self.host.prepare_schema_input(self.store_id)?;
            }
            // Schema text is parsed (and timed) by the JavaScript store.
            let result = self
                .inner
                .add_types(type_builder, debug_print_schema_resolving, None)
                .await;
            // The top-levels found, also when the run failed after finding
            // some (TypeScript adds each to the input as it is found).
            if self.has_sources {
                let top_levels = self
                    .inner
                    .top_levels()
                    .map(|(name, r)| (name.to_owned(), r.to_string()))
                    .collect();
                self.host.schema_top_levels(self.store_id, top_levels);
            }
            result
        }
    }

    fn add_types_sync(
        &mut self,
        _ctx: &RunContext,
        _type_builder: &mut quicktype_core::ty::type_builder::TypeBuilder<'_>,
        _infer_maps: bool,
        _infer_enums: bool,
        _fixed_top_levels: bool,
    ) -> Result<()> {
        self.inner.add_types_sync()
    }

    fn single_string_schema_source(&self) -> Option<String> {
        // The facade ran `preRun`, schema passthrough included.
        None
    }
}

#[cfg(test)]
mod tests {
    use std::cell::RefCell;
    use std::collections::HashMap;

    use quicktype_core::internal::block_on;
    use quicktype_core::{
        JsonSourceData, OptionValue, quicktype_multi_file, quicktype_multi_file_sync,
    };

    use super::*;
    use crate::wire::SchemaSource;

    #[derive(Default)]
    struct MockHost {
        schemas: HashMap<String, JsonSchema>,
        log: RefCell<Vec<String>>,
    }

    impl RunHost for MockHost {
        fn prepare_schema_input(&self, store_id: u32) -> Result<()> {
            self.log.borrow_mut().push(format!("prepare {store_id}"));
            Ok(())
        }

        fn schema_get(
            &self,
            store_id: u32,
            address: &str,
        ) -> LocalBoxFuture<'static, Result<Option<JsonSchema>>> {
            self.log
                .borrow_mut()
                .push(format!("get {store_id} {address}"));
            let schema = self.schemas.get(address).cloned();
            Box::pin(async move { Ok(schema) })
        }

        fn schema_top_levels(&self, store_id: u32, top_levels: Vec<(String, String)>) {
            self.log
                .borrow_mut()
                .push(format!("top-levels {store_id} {top_levels:?}"));
        }

        fn timing(&self, name: &str, _milliseconds: f64) {
            self.log.borrow_mut().push(format!("timing {name}"));
        }

        fn clock(&self) -> Option<Clock> {
            None
        }
    }

    /// A JSON input the way the facade sends it: built by a `JsonInput` that
    /// keeps the samples in compressed form (as the facade's JavaScript
    /// `CompressedJSON` does) and exported as tables.
    fn json_input(name: &str, samples: &[&str]) -> InputRequest {
        let lang = get_target_language("ts").unwrap();
        let mut input =
            quicktype_core::json_input_for_target_language(lang, true, &RendererOptions::new());
        input.set_tally_inference(false).unwrap();
        input
            .add_source_sync(JsonSourceData {
                name: name.to_owned(),
                samples: samples.iter().map(|s| (*s).into()).collect(),
                description: None,
            })
            .unwrap();
        let (tables, top_levels) = input.to_compressed().unwrap();
        InputRequest::Json {
            handle_refs: true,
            date_time: DateTimeKind::Default,
            tables,
            top_levels,
        }
    }

    fn request(lang: &str, inputs: Vec<InputRequest>) -> Request {
        Request {
            lang: lang.to_owned(),
            output_filename: "stdout".to_owned(),
            inputs,
            ..Request::default()
        }
    }

    #[test]
    fn json_tables_render() {
        let mut req = request(
            "rust",
            vec![json_input("Person", &[r#"{"name": "Ann", "age": 7}"#])],
        );
        req.renderer_options = vec![("density".to_owned(), OptionValue::String("dense".into()))];
        let options = assemble(req, Rc::new(MockHost::default())).unwrap();
        let files = quicktype_multi_file_sync(options).unwrap();
        let code = files["stdout"].lines.join("\n");
        assert!(code.contains("pub struct Person {"), "{code}");
    }

    #[test]
    fn schema_input_goes_through_the_host() {
        let mut host = MockHost::default();
        let schema = quicktype_core::parse_json(
            r##"{"type": "object", "properties": {"a": {"$ref": "other.json#/definitions/B"}}}"##,
            "JSON Schema",
            None,
        )
        .unwrap();
        host.schemas.insert("main.json".to_owned(), schema.into());
        let other = quicktype_core::parse_json(
            r#"{"definitions": {"B": {"type": "integer"}}}"#,
            "JSON Schema",
            None,
        )
        .unwrap();
        host.schemas.insert("other.json".to_owned(), other.into());
        let host = Rc::new(host);
        let req = request(
            "typescript",
            vec![InputRequest::Schema {
                store_id: 3,
                sources: vec![SchemaSource {
                    uri: "main.json".to_owned(),
                    name: "Main".to_owned(),
                    is_converted: false,
                }],
                top_levels: Vec::new(),
                additional: Vec::new(),
            }],
        );
        let options = assemble(req, Rc::clone(&host) as Rc<dyn RunHost>).unwrap();
        let files = block_on(quicktype_multi_file(options)).unwrap();
        let code = files["stdout"].lines.join("\n");
        assert!(code.contains("a?: number;"), "{code}");
        // The JavaScript store caches; the engine asks for every lookup.
        let log = host.log.borrow();
        assert_eq!(log[..2], ["prepare 3", "get 3 main.json"]);
        assert!(log.iter().any(|l| l == "get 3 other.json"), "{log:?}");
        assert_eq!(
            log.last().map(String::as_str),
            Some(r#"top-levels 3 [("Main", "main.json#")]"#)
        );
    }

    #[test]
    fn schema_input_without_sources_is_not_prepared() {
        let host = Rc::new(MockHost::default());
        let req = request(
            "typescript",
            vec![
                json_input("A", &["1"]),
                InputRequest::Schema {
                    store_id: 0,
                    sources: Vec::new(),
                    top_levels: Vec::new(),
                    additional: Vec::new(),
                },
            ],
        );
        let options = assemble(req, Rc::clone(&host) as Rc<dyn RunHost>).unwrap();
        block_on(quicktype_multi_file(options)).unwrap();
        assert!(host.log.borrow().is_empty());
    }

    #[test]
    fn sync_runs_reject_schema_input_like_typescript() {
        let req = request(
            "typescript",
            vec![InputRequest::Schema {
                store_id: 0,
                sources: Vec::new(),
                top_levels: Vec::new(),
                additional: Vec::new(),
            }],
        );
        let options = assemble(req, Rc::new(MockHost::default())).unwrap();
        let error = quicktype_multi_file_sync(options).unwrap_err();
        assert_eq!(
            error.user_message(),
            "Internal error: addTypesSync not supported in JSONSchemaInput"
        );
    }

    #[test]
    fn timings_reach_the_host() {
        let host = Rc::new(MockHost::default());
        let mut req = request("typescript", vec![json_input("A", &["1"])]);
        req.on_timing = true;
        let options = assemble(req, Rc::clone(&host) as Rc<dyn RunHost>).unwrap();
        quicktype_multi_file_sync(options).unwrap();
        let log = host.log.borrow();
        assert_eq!(log.first().map(String::as_str), Some("timing read input"));
        assert_eq!(log.last().map(String::as_str), Some("timing render"));
    }

    #[test]
    fn unknown_languages_fail_like_language_named() {
        let error = assemble(request("cobol", Vec::new()), Rc::new(MockHost::default()))
            .err()
            .unwrap();
        assert_eq!(error.user_message(), "Unknown language name: cobol");
    }
}
