# Architecture

A map of the Rust port for people who know the TypeScript quicktype: how the
crates fit together, what one run does, and where each TypeScript construct
went. "TS" means quicktype at the commit in
[`tests/golden/REFERENCE`](../tests/golden/REFERENCE), which is the
specification. This page links to, rather than repeats:

| Topic | Where |
|---|---|
| Parity rules, dependency choices, known gaps, bugs kept for parity | [PARITY.md](PARITY.md) |
| JSON inference from running tallies, and why it equals quicktype's | [STREAMING-INFERENCE.md](STREAMING-INFERENCE.md) |
| Porting a renderer, the TS → Rust cheat sheet | [RENDERERS.md](RENDERERS.md) |
| The TS architecture as researched before porting | [research/](research/): 01 type graph and pipeline, 02 inputs, 03 rendering and naming, 04 languages, 05 CLI and API, 06 dependencies, 07 TypeScript input |
| The npm package and its engine selection | [npm/quicktype-core/README.md](../npm/quicktype-core/README.md) |
| Workflow and porting rules | [CONTRIBUTING.md](../CONTRIBUTING.md) |
| Plan and status | [ROADMAP.md](ROADMAP.md), [PROGRESS.md](PROGRESS.md) |

## 1. Crates

No crate depends on quicktype-cli or quicktype-wasm:

```
quicktype-cli              → quicktype-core (feature "http"), quicktype-graphql-input,
                             quicktype-typescript-input, quicktype-js-compat
quicktype-wasm             → quicktype-core (no default features),
                             quicktype-js-compat (feature "js-host-math")
quicktype-graphql-input    → quicktype-core, quicktype-js-compat
quicktype-typescript-input → quicktype-js-compat           (not quicktype-core)
quicktype-core             → quicktype-js-compat
quicktype-js-compat        → no workspace crate
xtask                      → no workspace crate (runs the built `quicktype` binary)
npm/quicktype-core         → loads the .wasm that quicktype-wasm compiles to
```

| Crate | Ports (TS path) | Notable external crates |
|---|---|---|
| [`crates/quicktype-core`](../crates/quicktype-core) | `packages/quicktype-core/src`; also the CLI's `src/CompressedJSONFromStream.ts` with stream-json's parser (`input/compressed_json_from_stream.rs`), `collection-utils` (`support/collection_utils.rs`) and Node's `fetch` (`input/io/fetch.rs`) | `indexmap`, `regex`, `stacker`; with feature `http`: `ureq`, `url`, `flate2`, `brotli-decompressor` |
| [`crates/quicktype-cli`](../crates/quicktype-cli) | `src/` (`index.ts`, `TypeSource.ts`, `URLGrammar.ts`, `GraphQLIntrospection.ts`); also `command-line-args`, `command-line-usage` (with `table-layout`, `wordwrapjs`) and `chalk`/`supports-color`/`chalk-template` | `indexmap` |
| [`crates/quicktype-graphql-input`](../crates/quicktype-graphql-input) | `packages/quicktype-graphql-input/src`; also graphql-js 16.14.2's lexer and parser (`src/graphql/`) | `indexmap` |
| [`crates/quicktype-typescript-input`](../crates/quicktype-typescript-input) | `packages/quicktype-typescript-input/src/index.ts`; also typescript-json-schema 0.67.4 (`src/tjs/`) and a client for TypeScript 7.0.2's `tsc --api` protocol (`src/tsc/`) | `serde`, `serde_json`, `stacker` |
| [`crates/quicktype-js-compat`](../crates/quicktype-js-compat) | no TS file: JavaScript runtime behavior and npm packages the output depends on (section 4) | `ryu`, `saphyr-parser`, `regex`, `indexmap`, `stacker`; `wasm-bindgen` under `js-host-math` |
| [`crates/quicktype-wasm`](../crates/quicktype-wasm) | no TS file: the bindings the npm facade calls (section 5) | `wasm-bindgen`, `js-sys`, pinned to the `wasm-bindgen` CLI version |
| [`xtask`](../xtask) | no TS file: `cargo xtask parity`, `diff`, `golden` (`xtask/src/`) and the Node recorders (`xtask/*/`) | `serde`, `serde_json` |
| [`npm/quicktype-core`](../npm/quicktype-core) | `packages/quicktype-core/src` verbatim except `Run.ts`, plus `src/native/` | npm package |

The crates are published as `quickertype-*` (the CLI as `quickertype`),
so `cargo -p` takes those names (`cargo test -p quickertype-core`); the
directories and the library names (`quicktype_core`, ...) stay as above.
[RELEASING.md](RELEASING.md#names-and-versions) has the table.

In [`Cargo.toml`](../Cargo.toml), `default-members` is `crates/*`, so
`cargo build` and `cargo test` skip `xtask`; `cargo xtask` is an alias in
[`.cargo/config.toml`](../.cargo/config.toml). `unsafe_code` is forbidden and
release builds set `panic = "abort"`. quicktype-core has two cargo features:
`fs` (default, provides `StdIo`) and `http` (URLs, implies `fs`).

The public Rust API is the root re-exports of
[`crates/quicktype-core/src/lib.rs`](../crates/quicktype-core/src/lib.rs),
mirroring TS `index.ts`. The modules are `pub` but `#[doc(hidden)]` and outside
semver; `quicktype_core::internal` has helpers for the front ends. The CLI uses
the root API plus `internal`; the GraphQL input and the WASM bindings also use
hidden modules (`ty`, `attributes`, ...), as any `Input` implementation must.

## 2. One run, end to end

`quicktype --lang rust -o out.rs x.json`, by file:

```
crates/quicktype-cli/src/main.rs      main → cli_main → block_on(run)
  cli_options.rs                      parse_cli_options → CliOptions
  main.rs                             make_quicktype_options: sources → make_input_data → Options
crates/quicktype-core/src/run.rs      quicktype_multi_file → Run::run
  run.rs                              pre_run, then make_graph: InputData::add_types into a TypeBuilder
  run.rs                              process_graph: rewrite passes, GC, gather_names
  target_language.rs                  render_graph_and_serialize → render → serialize
crates/quicktype-cli/src/main.rs      write_output
```

### 2.1 CLI to `Options`

1. `main` runs `cli_main` on a thread with `STACK_SIZE` (256 MiB), which drives
   the async `run` with `block_on` (`quicktype_core::internal`).
2. `parse_cli_options` ([`cli_options.rs`](../crates/quicktype-cli/src/cli_options.rs))
   parses argv twice with `command_line_args::parse`, as TS does: leniently
   with the global options (`GlobalOption`) to infer the language, then
   strictly with the globals plus `TargetLanguage::cli_option_definitions()`.
3. `make_quicktype_options` ([`main.rs`](../crates/quicktype-cli/src/main.rs))
   answers `--help` (`usage.rs`, `command_line_usage.rs`, `chalk.rs`),
   `--version` and `--build-markov-chain`, then collects sources by `--src-lang`:
   - `json`/`schema`: `sources::get_sources` returns `TypeSource`s; files and
     URLs are opened now and read when the input parses them, as in TS.
   - `graphql`: `graphql_sources` (`graphql_introspection::introspect_server`
     for `--graphql-introspect`).
   - `typescript`: `make_typescript_source` →
     `quicktype_typescript_input::schema_for_typescript_sources`.
   - `postman`: `postman_sources` → `sources_from_postman_collection`.

   `make_input_data` adds them to an `InputData`, which goes into
   `Options::new(lang, input_data)`.
4. `quicktype_multi_file(options)` runs the engine (2.2 to 2.5).
5. `write_output` writes the files (next to `--out`, or to stdout) and the
   issue annotations (to stderr). A failure is a `CliError`
   ([`messages.rs`](../crates/quicktype-cli/src/messages.rs)), printed as
   `Error: <message>.`.

### 2.2 Inputs

`Input` ([`input/inputs.rs`](../crates/quicktype-core/src/input/inputs.rs))
is TS `Input<T>`: `kind`, `need_ir`, `need_schema_processing`,
`add_source`/`add_source_sync`, `add_types`/`add_types_sync`,
`single_string_schema_source`; the async methods default to the sync ones.
`InputData` keeps one input per kind, in the order added.

| Input | Rust | Notes |
|---|---|---|
| JSON | `JsonInput`: running tallies ([`input/tallies.rs`](../crates/quicktype-core/src/input/tallies.rs)) inferred by `TallyInference` ([`input/tally_inference.rs`](../crates/quicktype-core/src/input/tally_inference.rs)); the reference path, a `CompressedJson` ([`input/compressed_json.rs`](../crates/quicktype-core/src/input/compressed_json.rs)) inferred by `TypeInference` ([`input/inference.rs`](../crates/quicktype-core/src/input/inference.rs)), for `JsonInput::from_compressed` | Each `JsonSample` names its reader. `JsonSample::String` goes through `CompressedJson::parse_string`: `JSON.parse` semantics (the JS API's reader), on `quicktype_js_compat::json::parse`; its values are kept and walked into the tallies. `JsonSample::Stream` and `JsonSample::Reader` go through the stream-json tokenizer ([`input/compressed_json_from_stream.rs`](../crates/quicktype-core/src/input/compressed_json_from_stream.rs)), which emits into a `JsonSink`: the tallies, never kept whole. The CLI always passes `Reader`. Under WASM the samples arrive parsed, as `CompressedJsonTables` (`JsonInput::from_compressed`), and are inferred from those. Why both inferences agree: [STREAMING-INFERENCE.md](STREAMING-INFERENCE.md). |
| JSON Schema | `JsonSchemaInput` ([`input/json_schema_input.rs`](../crates/quicktype-core/src/input/json_schema_input.rs)) over a `JsonSchemaStore` ([`input/json_schema_store.rs`](../crates/quicktype-core/src/input/json_schema_store.rs)) | `$ref`ed documents are fetched lazily while types are built, where TS awaits. The CLI's store, `FetchingJsonSchemaStore` ([`input/fetching_json_schema_store.rs`](../crates/quicktype-core/src/input/fetching_json_schema_store.rs)), reads with `read_from_file_or_url` on an `Io` and parses with `parse_json` (JSON, else YAML). As in TS, `add_types_sync` fails. |
| GraphQL | `GraphQlInput` ([`crates/quicktype-graphql-input/src/lib.rs`](../crates/quicktype-graphql-input/src/lib.rs)) | graphql-js's parser is hand-ported so syntax errors read the same; the introspection JSON is walked with JavaScript property-read semantics (`src/js.rs`). |
| TypeScript | `schema_for_typescript_sources` ([`crates/quicktype-typescript-input/src/lib.rs`](../crates/quicktype-typescript-input/src/lib.rs)) | Starts `tsc --api` of TypeScript 7.0.2 (`QUICKTYPE_TSC`, else the npm platform package in `node_modules` of the working directory or a parent, else `tsgo`/`tsc` on `PATH`: `src/tsc/locate.rs`), talks to its checker over MessagePack frames (`src/tsc/`), and runs the typescript-json-schema port (`src/tjs/`), which replays TS 5.9's union order (`src/tjs/order.rs`). The schema text it returns goes to `JsonSchemaInput`. No Node involved. |
| Postman | `sources_from_postman_collection` ([`input/postman_collection.rs`](../crates/quicktype-core/src/input/postman_collection.rs)) | A collection becomes JSON sources. |

### 2.3 Building the graph

`Run::pre_run` ([`run.rs`](../crates/quicktype-core/src/run.rs)) first passes
a single JSON Schema source through when the target is JSON Schema and no input
needs the IR. Otherwise `Run::make_graph` creates a `TypeBuilder`
([`ty/type_builder.rs`](../crates/quicktype-core/src/ty/type_builder.rs)) with
the run's `StringTypeMapping`, lets `InputData::add_types` fill it (timed as
`read input`), and `TypeBuilder::finish` yields the first `TypeGraph`
([`ty/type_graph.rs`](../crates/quicktype-core/src/ty/type_graph.rs)).

### 2.4 Rewrite passes

`Run::process_graph` is TS `processGraph`, pass for pass and in the same order.
A graph is never mutated structurally: a rewrite builds a new graph through a
`TypeBuilder` with rewrite state
([`graph_rewriting.rs`](../crates/quicktype-core/src/graph_rewriting.rs)).
Where TS tests whether a pass changed the graph by object identity, the Rust
rewrites return `None` for "unchanged". Each pass is timed under its TS name
with `RunContext::time_result` (`--debug print-times`, `on_timing`).

| # | Pass (timing name) | Function | When |
|---|---|---|---|
| 1 | remove indirection intersections | `remove_indirection_intersections` (`ty/type_graph_utils.rs`) | a forwarding intersection was added, or `$ref`s are handled |
| 2 | resolve intersections + flatten unions, until both are done | `resolve_intersections`, `flatten_unions` (`rewrites/`) | schema processing needed, or `$ref`s are handled |
| 3 | replace object type | `replace_object_type` | always |
| 4 | flatten unions, until done | `flatten_unions` | always |
| 5 | combine classes, combine classes cleanup | `combine_classes` | inference flag `combine_classes` |
| 6 | infer maps, while it changes the graph | `infer_maps` | inference flag `infer_maps` |
| 7 | expand strings | `expand_strings` with an `EnumInference` | always |
| 8 | flatten unions (asserted to finish at once) | `flatten_unions` | always |
| 9 | flatten strings | `flatten_strings` | schema processing needed |
| 10 | none to any | `none_to_any` (`ty/type_graph_utils.rs`) | always |
| 11 | optional to nullable | `optional_to_nullable` | the language lacks optional class properties |
| 12 | fixed point | `TypeGraph::rewrite_fixed_point` | always |
| 13 | make transformations | `make_transformations` ([`make_transformations.rs`](../crates/quicktype-core/src/make_transformations.rs)) with `TargetLanguage::needs_transformer_for_type` | always |
| 14 | flatten unions (asserted) | `flatten_unions` | always |
| 15 | GC | `TypeGraph::garbage_collect` | always |
| 16 | gather names | `gather_names` ([`gather_names.rs`](../crates/quicktype-core/src/gather_names.rs)) | always |

`--debug print-graph` prints the graph after every rewrite in the TS format
(`TypeGraph::print_graph`, `set_print_on_rewrite`), so diffing both CLIs'
output finds the first stage that diverges; see
[xtask/core-type-graph/README.md](../xtask/core-type-graph/README.md).

### 2.5 Names, rendering, serialization

`Run::render_graph` calls `TargetLanguage::render_graph_and_serialize`
([`target_language.rs`](../crates/quicktype-core/src/target_language.rs)), TS's
shared `renderGraphAndSerialize`. It calls the language's
`TargetLanguage::render`, which parses the options and passes a new renderer
to `render_with` ([`convenience_renderer.rs`](../crates/quicktype-core/src/convenience_renderer.rs)).
`ConvenienceRendererExt::render` runs `assign_names` (namers and namespaces,
then the global algorithm in [`naming.rs`](../crates/quicktype-core/src/naming.rs)),
`process_graph` (`declarations_for_graph`,
[`declaration_ir.rs`](../crates/quicktype-core/src/declaration_ir.rs)) and the
language's `emit_source_structure`. The `RenderResult`
([`renderer.rs`](../crates/quicktype-core/src/renderer.rs)) holds one `Source`
tree per file ([`source.rs`](../crates/quicktype-core/src/source.rs));
`serialize_render_result` turns each into a `SerializedRenderResult` (lines
plus annotation spans). The files form a `MultiFileRenderResult`, an
`IndexMap` in the order they were finished; `quicktype` joins them with
`combine_render_results`.

## 3. TypeScript concepts in Rust

### 3.1 Class hierarchies

| TS | Rust |
|---|---|
| `Type` subclasses (`ClassType`, `UnionType`, ...) | one `Type` struct: a `TypeKind` plus `TypeData` ([`ty/ty.rs`](../crates/quicktype-core/src/ty/ty.rs)) |
| The `Transformer` classes | `Transformer` plus `TransformerData` ([`transformers.rs`](../crates/quicktype-core/src/transformers.rs)) |
| `TargetLanguage` subclasses | the `TargetLanguage` trait, implemented by a unit struct in `language/<lang>/language.rs` and registered in `ALL` ([`language/all.rs`](../crates/quicktype-core/src/language/all.rs)) |
| Renderer options objects | `static` slices of `RendererOption` ([`renderer_options/mod.rs`](../crates/quicktype-core/src/renderer_options/mod.rs)), read from an untyped `RendererOptions` map with TS's coercion rules |
| `ConvenienceRenderer` subclasses | a struct owning a `ConvenienceRendererCore` that implements `ConvenienceRenderer` (the overridable hooks) and so gets `ConvenienceRendererExt` (the machinery) |

The hooks are generated from one list. Abstract TS methods are required; the
others default to the function of the same name in
`convenience_renderer::defaults`, so `super.x(...)` becomes
`defaults::x(self, ...)`. Two macros keep subclass chains complete:

- `forward_convenience_renderer_hooks!(module)` implements every hook as
  `module::<hook>(self, ...)`. The module glob-imports the level above
  (`defaults`, or a family's hooks module) and defines what its own level
  overrides, so no level can forget to forward a hook.
- `family_methods!` does the same for a mid-level base class's own methods
  (TS `JavaScriptRenderer`, `PythonRenderer`): `[declare module]` in the
  family trait, `[forward module]` in each leaf's impl. Worked examples:
  [RENDERERS.md](RENDERERS.md#mid-level-base-classes).

### 3.2 Identity: indexes instead of objects

- **Types** live in a graph's arena and are referenced by `TypeRef`
  ([`ty/type_ref.rs`](../crates/quicktype-core/src/ty/type_ref.rs)), whose
  value is TS's `((serial & 31) << 26) | index`, because type identities hash
  it. Whatever inspects another type takes the graph.
- **Deduplication** depends on collection-utils' hashes and linear probing,
  so `JsHash`, `JsEquals` and `EqualityMap`
  ([`support/collection_utils.rs`](../crates/quicktype-core/src/support/collection_utils.rs))
  reproduce them bit for bit, keyed by `TypeIdentity`.
- **`Map`/`Set`** become `IndexMap`/`IndexSet`. Where an object is a JS `Map`
  key, `SameValueZeroKey` and `JsObject` model SameValueZero.
- **`===` on emitted items** (`emitLineOnce`, `emitItemOnce`): a
  `Source::Text` equals an earlier one with the same text, a `Source::Name`
  the same name, and a sequence (`sl![...]`, a TS array literal) nothing
  (`contains_item` in `renderer.rs`); see
  [RENDERERS.md](RENDERERS.md#item-identity-emitlineonce-emititemonce).
- **Transformers** are shared `Rc`s, so `a === b` is a pointer comparison.

### 3.3 Attributes and names

- **Type attributes** ([`attributes/type_attributes.rs`](../crates/quicktype-core/src/attributes/type_attributes.rs)):
  the `TypeAttributeKind` singletons are a `TypeAttributeKind` enum, values a
  `TypeAttributeValue` enum, and `TypeAttributes` keeps JS `Map` order. Each
  kind has a typed handle implementing `AttributeKind` (e.g.
  `NamesTypeAttributeKind`) with the TS accessors (`make_attributes`,
  `try_get_in_attributes`, ...).
- **Names**: `Name` and `NamespaceId` are ids into a `Naming` arena
  ([`naming.rs`](../crates/quicktype-core/src/naming.rs)); `assign_names`
  returns the `Names` that resolve them. A `Namer` compares by identity, as
  in TS. Names a renderer assigns live in side tables of
  `ConvenienceRendererCore`, not in graph attributes as in TS.
- **Random type names**: each run has its own `TypeNameGenerator` (TS seeds a
  global one in `initTypeNames`), installed by `with_type_name_generator`
  ([`attributes/type_names.rs`](../crates/quicktype-core/src/attributes/type_names.rs))
  around every poll of the run's future (`WithTypeNames` in `run.rs`).

### 3.4 Async, I/O and fetching

Promises become futures that are deliberately not `Send` (`LocalBoxFuture`).
They exist exactly where TS awaits, because the order of schema fetches is
observable (which `$id`s are known when, the `--debug print-schema-resolving`
trace, which error comes first): `Input::add_types`,
`JsonSchemaStore::fetch`/`get` and the `Io` trait.

- `Io` ([`input/io/node_io.rs`](../crates/quicktype-core/src/input/io/node_io.rs))
  is what TS `NodeIO` takes from Node: `fs` calls, stdin, `fetch` and
  `fetch_with_init`, with Node's error texts (`IoError`). `StdIo` implements
  it on `std`; with feature `http`,
  [`input/io/fetch.rs`](../crates/quicktype-core/src/input/io/fetch.rs)
  reproduces undici's `fetch` on `ureq` (redirects, default headers, content
  decoding, error texts).
- Native I/O blocks and completes on the first poll, so `block_on`
  ([`input/io/mod.rs`](../crates/quicktype-core/src/input/io/mod.rs)) is the
  whole executor.
- The WASM build has no `Io`: `HostSchemaStore`
  ([`crates/quicktype-wasm/src/assemble.rs`](../crates/quicktype-wasm/src/assemble.rs))
  implements `JsonSchemaStore::get` with the facade's JavaScript store, and
  the facade drives the future (section 5).
- `console.log` (all `--debug` output) is `console_log`
  ([`support/support.rs`](../crates/quicktype-core/src/support/support.rs)):
  stdout, or the per-thread sink installed with `set_console_sink`.

### 3.5 Errors

- Every fallible function returns `Result`; a TS `throw` is
  `Err(QuickTypeError)` ([`messages.rs`](../crates/quicktype-core/src/messages.rs)).
  Nothing may panic on user input, since release builds abort on panic.
- `QuickTypeError::new(kind, properties)` is `messageError`. `ErrorKind` and
  its templates are listed in `Messages.ts` order in `error_kinds!`;
  properties are substituted with `String.prototype.replace` semantics,
  `$`-patterns included. `message_error` and `message_assert` are the TS
  functions; `support::support::{assert, panic, defined, ...}` return `Err` too.
- Exceptions TS lets escape from the runtime or a library (urijs' `URIError`,
  `JSON.parse`'s `SyntaxError`, a `TypeError` from reading a property of
  `null`, graphql-js's `GraphQLError`) are a `JsException`
  (`QuickTypeError::js_exception` with a `JsErrorName`); the facade rethrows
  the same class with the same message.
- `QuickTypeError::unsupported` marks what is not ported; the facade then
  runs the TypeScript engine instead.

### 3.6 Recursion and JavaScript's stack

Where TS recursion overflows V8's stack, the port reports the same
`RangeError: Maximum call stack size exceeded` instead of overflowing the
native stack:

- Recursions over the type graph (a renderer's type-to-source function, C#'s
  `needTransformerForType`) wrap each level in `support::recursion::guard`
  ([`support/recursion.rs`](../crates/quicktype-core/src/support/recursion.rs)),
  which fails after `MAX_DEPTH` nested guarded calls and grows the native
  stack with `stacker` as needed. `grow_stack` does the latter only.
- JSON Schema input models V8's stack: each nesting level costs an amount by
  keyword (`Edge::cost`) out of `JS_STACK_BUDGET`, reset after every `await`;
  `NATIVE_DEPTH_LIMIT` and `ADD_IDS_DEPTH_LIMIT` bound the rest. The costs come
  from `xtask/core-json-schema-input/measure-stack-depth.mjs` and are pinned
  by `crates/quicktype-core/tests/deep_schemas.rs`. Postman input
  (`MAX_COLLECTION_DEPTH`, `MAX_STRING_ARRAY_DEPTH`) and YAML
  (`quicktype_js_compat::yaml::MAX_DEPTH`) have their own limits.
- The native stacks are large on purpose: the CLI's thread (`STACK_SIZE`) and
  the WASM module (`-zstack-size` in
  [`crates/quicktype-wasm/build.rs`](../crates/quicktype-wasm/build.rs)).
  Limits and differences from Node: [PARITY.md](PARITY.md#known-gaps).

## 4. The JavaScript-semantics layer: `quicktype-js-compat`

Each module of [`crates/quicktype-js-compat`](../crates/quicktype-js-compat/src)
reproduces one JavaScript behavior that quicktype's output depends on and
Rust does not share, documented in its header. When to use which:
[PARITY.md](PARITY.md#rules); how each was verified: the
[dependency table](PARITY.md#dependency-choices).

| Module | Stands for |
|---|---|
| `number` | `Number.prototype.toString` (`to_string`: ryu digits, ECMAScript layout), `**`/`Math.pow` (`pow`), `Number(string)` (`string_to_number`) |
| `utf16` | string `length`, indexing, `slice`, `substring` in UTF-16 code units |
| `sort` | UTF-16 string order (`compare_utf16`) and V8's TimSort (`sort_by`), which quicktype's inconsistent comparators depend on |
| `json` | `JSON.stringify` (`stringify`, `quote`, `number`), `JSON.parse` with V8's error messages (`parse`, port of `json-parser.cc`), JS own-property order (`JsonValue`, `insert_js_property`) |
| `whitespace` | JS `\s` and `trim()` |
| `unicode` | npm `unicode-properties` 1.4.1 (Unicode 12.0); `unicode_table.rs` is generated by `xtask/js-compat/gen-unicode.mjs` |
| `pluralize` | npm `pluralize` 8.0.0 |
| `wordwrap` | npm `wordwrap` 1.0.0 (`WordWrap`) |
| `uri` | the urijs 1.19.11 subset quicktype uses, `encodeURIComponent`, `decodeURIComponent` |
| `yaml` | `YAML.parse` of npm `yaml` 2.9.0, on `saphyr-parser` events |
| `path`, `path_posix`, `path_win32` | Node's `path`: `path.posix`, or `path.win32` on Windows, as Node picks by platform (vectors by `xtask/js-compat/gen-path-vectors.mjs`) |
| `verbatim_path` | not JavaScript: the plain form of the `\\?\` paths Rust's standard library returns on Windows, by the standard library's own rule |

The tests replay vectors recorded from Node
(`crates/quicktype-js-compat/tests/vectors/`, by `xtask/js-compat/gen-vectors.mjs`
and the generators PARITY.md lists). JavaScript libraries only one crate
needs are ported in that crate: collection-utils, stream-json and undici's
`fetch` in quicktype-core, the argv, usage and colour libraries in
quicktype-cli, graphql-js and typescript-json-schema in their input crates.

Feature `js-host-math`: on `wasm32`, `number::pow` calls the JavaScript host's
`Math.pow` through `wasm-bindgen`, because Rust's `powf` there differs from
V8 in the last bit for some inputs. quicktype-wasm enables it.

## 5. WebAssembly and the JavaScript API

[`crates/quicktype-wasm`](../crates/quicktype-wasm/src/lib.rs) exports through
`wasm-bindgen`: `runSync` (for `quicktypeMultiFileSync`); `start`, `poll`,
`settle` and `cancel` (an async run as a future the facade polls, settling
each schema fetch when its promise does); and `supportsLanguage`, which
renders an empty graph (`has_renderer`) to learn whether a renderer is ported.
The request is a flat wire format ([`wire.rs`](../crates/quicktype-wasm/src/wire.rs),
read in `js.rs`; encoded by `npm/quicktype-core/src/native/encode.ts`), which
[`assemble.rs`](../crates/quicktype-wasm/src/assemble.rs) turns into
`Options`. A run ends as `{ files }`, `{ error }` (a quicktype message or a
`JsException`), `{ thrown }` (what a host callback threw) or `{ unsupported }`.

[`npm/quicktype-core`](../npm/quicktype-core/README.md) is quicktype's own
TypeScript API: `src/` is upstream's `packages/quicktype-core/src` byte for
byte except `Run.ts`, which after `preRun()` calls `runNative`/`runNativeSync`
in `src/native/bridge.ts`. Per run, the TypeScript engine is used when
`QUICKTYPE_ENGINE=ts` is set; when `encodeRun` finds something the engine
does not model (a custom language, input, recognizer or attribute producer,
an unusual option value, GraphQL input); when the `.wasm` cannot be loaded
(an error under `QUICKTYPE_ENGINE=wasm`); or when `supportsLanguage` is false.
Otherwise the engine runs it; after an `{ unsupported }` outcome or a trap the
inputs are restored and the run is redone on the TypeScript engine (after a
trap, with a new instance). `engineStats` in `bridge.ts` counts the outcomes.
Loading in browsers and bundlers and the remaining differences are in the
[package README](../npm/quicktype-core/README.md) and
[PARITY.md](PARITY.md#known-gaps).

## 6. Testing

No Rust test needs Node; Node and a built quicktype checkout are needed to
record fixtures and for `cargo xtask diff`. The npm tests run under Node.
Each tool takes the checkout as a path argument where it has one, else from
`$QUICKTYPE_REFERENCE`, else uses the first built one of `../quicktype` and
`../../quicktype` next to this repository (the second finds it from a
worktree). The xtask tools (`diff`, `bench`, `golden` and the recorders in
`xtask/*/`, through [`xtask/reference.mjs`](../xtask/reference.mjs)) look in
that order, and between `$QUICKTYPE_REFERENCE` and the directories they still
read its old names `QUICKTYPE_REF` and `QUICKTYPE_DIR`, with a one-line
warning. `QUICKTYPE_REFERENCE=self` only applies to the npm differential
suite (see below); the xtask tools reject it.

| Layer | Lives in | Run with | Recorded by |
|---|---|---|---|
| Golden corpus: recorded TS CLI runs compared byte for byte (files; for `cli-*` cases also stdout, stderr, exit code) | `tests/golden/<fixture>/<input>/<hash>/case.json` plus expected files; runner `xtask/src/parity.rs` | `cargo xtask parity` (`--filter`, `--strict`, `--bin`, `--report`, `--keep`) | `cargo xtask golden [ref-dir]` (`xtask/golden/record.sh`: `record-hook.cjs`, `finalize.mjs`, `record-cli.mjs`) |
| Parity ratchet | [`tests/parity-baseline.txt`](../tests/parity-baseline.txt): ids that must keep passing | `cargo xtask parity` fails on a regression; `--update-baseline` records new passes | |
| Live side by side | `xtask/src/diff.rs` | `cargo xtask diff -- <args>`, `--each <dir>` | none: runs the TS CLI live |
| Renderers in isolation | `crates/quicktype-core/tests/render_cases.rs`, `render_scenarios.rs`; fixtures in `tests/fixtures/core-rendering/` | `cargo test -p quickertype-core --test render_cases --test render_scenarios` | `xtask/core-rendering/` ([README](../xtask/core-rendering/README.md)) |
| Stage-level differential tests | `type_graph_scenarios.rs`, `json_input.rs`, `json_schema_input.rs`, `js_vectors.rs` (quicktype-core); `graphql_input.rs` (graphql-input); `graphql_introspect.rs` (cli); `differential.rs` (typescript-input, skipped without TypeScript 7.0.2); `tests/vectors/` (js-compat) | `cargo test` | `xtask/core-type-graph/`, `core-json-input/`, `core-json-schema-input/`, `graphql-input/`, `typescript-input/`, `js-compat/` (each script's header or the directory's README names its outputs) |
| Ported Vitest tests (`test/unit/*.test.ts`, names kept) | `crates/quicktype-core/tests/*vitest*.rs`, `render_java_kotlin.rs`, `run.rs`, `windows_schema_paths.rs`; `crates/quicktype-cli/tests/cli.rs`, `url_input.rs`; some module unit tests (`naming.rs`, `markov_chain.rs`, ...); API-level ones in `npm/quicktype-core/test/differential/scenarios/api/` | `cargo test`, `npm run test:differential` | |
| Unit tests | `#[cfg(test)] mod tests` next to each module | `cargo test` | |
| npm package | `npm/quicktype-core/test/`: `package.test.mjs`, `engine.test.mjs`, `differential/` (the same API calls on the reference quicktype-core and this package), `browser/` | `npm test`, `npm run test:differential`, `npm run test:browser`, `npm run check:upstream` | |

CI ([`.github/workflows/ci.yml`](../.github/workflows/ci.yml)) runs fmt and
clippy, `cargo test --workspace`, `cargo xtask parity`, the `wasm32` build and
the npm tests. Without a quicktype checkout, the differential suite compares
against the package's own vendored TypeScript engine (`QUICKTYPE_REFERENCE=self`).

### Re-recording against a new quicktype commit

1. Check out the commit next to this repository as `../quicktype` and build
   it (`npm ci && npm run build`).
2. `cargo xtask golden ../quicktype` rewrites `tests/golden` and
   `tests/golden/REFERENCE` (commit, Node version, date). If the version in
   quicktype's `package.json` changed, set `QUICKTYPE_VERSION` in
   `crates/quicktype-cli/src/main.rs` to it: `--version` prints quicktype's
   version (the `cli-version` cases), not this port's own (the workspace
   version, see [RELEASING.md](RELEASING.md)).
3. `cargo xtask parity --strict --bin "node ../quicktype/dist/index.js"`: the
   new corpus must pass completely against the reference itself.
4. `cargo xtask parity`: the regressions are what changed upstream. Port it
   (section 7), then `cargo xtask parity --update-baseline`.
5. Re-run the recorders in `xtask/*/` for the areas the change touches.
6. In `npm/quicktype-core`: `npm run check:upstream` lists the files of `src/`
   that differ from upstream and the guarded files (hashed in
   [`src/native/UPSTREAM.json`](../npm/quicktype-core/src/native/UPSTREAM.json))
   that changed. `node script/sync-upstream.mjs` copies the new sources. Port
   a `Run.ts` change by hand, review `src/native/` against the other guarded
   files, record their hashes with `node script/sync-upstream.mjs --accept`,
   and update `commit` in `UPSTREAM.json` by hand.

## 7. Keeping the port in sync with upstream

**Finding the Rust file.** `packages/quicktype-core/src` maps to
`crates/quicktype-core/src` file for file (snake_case names, `Type/` as `ty/`,
`language/<Lang>/` as `language/<lang>/`), and the CLI's `src/` to
`crates/quicktype-cli/src`. Every ported module starts with
`//! Port of <TS path>`:

```sh
grep -rn 'Port of `packages/quicktype-core/src/rewrites/InferMaps.ts`' crates
```

`crates/quicktype-cli/src/compressed_json_from_stream.rs` only keeps the
mapping; that reader lives in quicktype-core. Modules without a TS counterpart
(`support/recursion.rs`, `input/io/fetch.rs`, `input/io/request.rs`) and
generated tables (`support/chance_data.rs`, `language/python/identifier_table.rs`,
`quicktype-js-compat/src/unicode_table.rs`,
`quicktype-typescript-input/src/tsc/generated.rs`, each naming its generator)
have no such header.

**When a TS file changes:**

1. Re-record (section 6) and let `cargo xtask parity` show what moved.
2. Port the diff into the mapped file: same algorithm, iteration order and
   strings. [PARITY.md](PARITY.md#rules) lists the JavaScript semantics that
   are easy to get wrong.
3. A newly used JavaScript library or runtime behavior gets a port (in
   `quicktype-js-compat` if shared) and a row in PARITY.md's dependency table
   saying how it was verified.
4. If upstream fixed one of the [bugs kept for parity](PARITY.md#bugs-kept-for-parity),
   drop its entry.
5. Re-record the stage-level fixtures, run `cargo test`, lock in passes with
   `--update-baseline`, and sync the npm package.

**Where additions go:**

| Upstream adds | Rust |
|---|---|
| A target language | `crates/quicktype-core/src/language/<lang>/` (`language.rs`, the renderer, and `utils.rs`/`constants.rs` where TS has them), declared in `language/mod.rs` and listed in `ALL` (`language/all.rs`) in TS order; follow [RENDERERS.md](RENDERERS.md). `crates/quicktype-core/tests/data/target_languages.json` pins each language's metadata and options (`tests/target_languages.rs`); re-record it with `xtask/core-rendering/record-target-languages.mjs`. |
| A renderer option | a `static` option in the language's `language.rs`, added to its option slice in TS declaration order and read in that order by the renderer's options `parse`. The CLI and `--help` get it from `cli_option_definitions`. |
| A global CLI option | a `GlobalOption` variant and its `definition` (name, type, help text) in `crates/quicktype-cli/src/cli_options.rs`, plus a `CliOptions` field |
| An inference flag | `INFERENCE_FLAGS` and `InferenceFlags` in `crates/quicktype-core/src/inference.rs`, and its `--no-*` `GlobalOption` |
| A message | the `error_kinds!` list in `crates/quicktype-core/src/messages.rs`, in `Messages.ts` order |
| A rewrite pass | `crates/quicktype-core/src/rewrites/`, called from `Run::process_graph` at the TS position |
| An input kind | an `Input` implementation; a new crate if TS adds a package |
