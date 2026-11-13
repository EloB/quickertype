# Roadmap

Goal: a complete, byte-identical replica of quicktype (CLI and JS API) in
Rust. Progress is measured by `cargo xtask parity` (10,132 golden cases) and,
for the JS API, by the differential suite.

Each work package (WP) is one branch, reviewed before merge (see
CONTRIBUTING.md). Packages within a phase are independent and run in
parallel; phases are ordered by dependency.

## Architecture: one Rust API, three front ends

```
                 quicktype-core  (engine + public Rust API)
                  ▲             ▲                 ▲
    Rust programs │    quicktype-cli      quicktype-wasm ◄── npm quicktype-core (TS facade)
```

- `quicktype-core` exposes an idiomatic, documented Rust API mirroring
  quicktype's concepts (`InputData`, `JsonInput`, `JsonSchemaInput`,
  `Options`, `quicktype()` → rendered files), with `Result`-based errors that
  carry quicktype's message names.
- The CLI and the WASM bindings use **only** the public API (dogfooding), so
  it is always complete.
- I/O (schema `$ref`s, URL sources) goes through a pluggable trait: std file +
  HTTP implementations behind cargo features for native builds; the WASM
  build plugs in the JS facade's `fs` / `fetch`.
- crates.io-ready: rustdoc with doctested examples, semver discipline.

## Phase 0 — Foundations

- [x] Workspace layout, lints, toolchain, CI
- [x] Golden corpus recorded from quicktype `c39af7d3` (10,132 cases),
      cross-checked against quicktype's own output snapshot
- [x] Parity runner with ratchet baseline (`cargo xtask parity`)
- [x] Corpus self-check: 10,132/10,132 pass against the TypeScript CLI
- [ ] Research notes per area (`docs/research/`)

## Phase 1 — Leaf modules, data model, CLI (parallel) — ✅ done

| WP | Branch | Scope |
|---|---|---|
| A | `feat/js-compat` | New `quicktype-js-compat` crate: JS number formatting, UTF-16 strings, V8 TimSort, `JSON.stringify`, `unicode-properties` table, `pluralize`, `wordwrap`. In core: `support/strings`, `acronyms`, `markov_chain`, `integer_range`. Differential test vectors generated from Node. |
| B | `feat/core-type-graph` | `ty/*`, `attributes/*`, `graph`, `graph_rewriting`, `union_builder`, `unify_classes`, `messages` (error type), `support/{support,chance}`, collection-utils hashing (`EqualityMap`). Graph printer identical to `--debug print-graph` for stage-by-stage diffing. |
| C | `feat/cli` | CLI-behavior golden cases (help, version, stdout, stdin, directories, errors, a full renderer-option sweep per language); language registry + renderer option declarations; CLI parsing and exact `--help`/error output. |

## Phase 2 — Engine (parallel) — ✅ done

| WP | Branch | Scope |
|---|---|---|
| D | `feat/core-json-input` | Two JSON readers (stream-json semantics for the CLI, `JSON.parse` semantics for the API), `CompressedJSON`, JSON inference, `Inputs` (`Input` trait, `InputData`, `JSONInput`), `RunContext`, `DateTime`, Postman input, inference-affecting language metadata (`stringTypeMapping`, `supports*`, date-time recognizers) |
| E | `feat/core-pipeline` | `rewrites/*`, `MakeTransformations`, `Transformers`, `CycleBreaker`, `DeclarationIR` |
| F | `feat/core-rendering` | `Source`, `Renderer`, `ConvenienceRenderer`, `Naming`, `GatherNames`, `Annotation`, `Comments`, `Converters`, the renderer trait; the Rust renderer as the first language |
| G | `feat/core-json-schema-input` | `JSONSchemaInput`, schema stores, `urijs` port, YAML, schema attribute producers; `Input` glue after D lands |

## Phase 3 — Integration: first end-to-end language — ✅ done (parity 7,331)

`Run` (the pipeline driver) and the CLI generation path, wiring JSON input,
the rewrite pipeline and the Rust renderer end to end: the first
golden-corpus passes for generated code. Then Go as the second pilot
(aligned tables, `DependencyName`, GraphQL).

## Phase 4 — Language fan-out (parallel) — ✅ done (all 27 languages; parity 11,177 / 11,177)

Eight packages along base-class families (research 04), so no two edit the
same files:

| Package | Languages | TS lines / golden cases |
|---|---|---|
| L1 | C (cJSON) | 6.7k / 314 |
| L2 | Crystal, C++ | 4.9k / 631 |
| L3 | Pike, C# | 4.3k / 1,317 |
| L4 | Java, Kotlin | 4.4k / 1,659 |
| L5 | JavaScript, TypeScript, Flow, Zod, Effect Schema, PropTypes, Elm | 4.5k / 2,273 |
| L6 | Ruby, Elixir, Python | 5.3k / 955 |
| L7 | Swift, Objective-C, Dart | 5.0k / 1,025 |
| L8 | Haskell, Scala 3, Smithy4s, PHP | 4.9k / 1,235 |

Cross-cutting items each language package must pick up:

- `TargetLanguage::supports_full_object_type()` returns `true` for
  TypeScript, Flow, JavaScript (L5) and JSON Schema; the trait default is
  `false`.

## Cleanup backlog (cross-branch follow-ups)

- Dedupe `transformers.rs`'s `lookup_*` helpers with
  `attributes::type_attributes::{transformation_for_type, follow_target_type}`
  (generic over `TypeLookup`).
- Move the remaining per-language `intercalate` and JS number-formatting
  copies to `support::collection_utils::array_intercalate` and
  `quicktype_js_compat::number::to_string`; switch the Rust renderer to
  `match_type_unsupported`.
- Stale "not ported yet" comments (`input/inputs.rs`, `tests/run.rs`,
  `tests/json_input_vitest.rs`, `tests/json_schema_vitest.rs`) and the
  CLI's own `trim`/whitespace helpers in `js.rs`, which duplicate
  `quicktype_js_compat::whitespace`.
- `input/io/node_io.rs` says the WASM build implements `Io`; it implements
  `JsonSchemaStore::get` through the facade's stores instead.
- One name for the reference checkout's environment variable
  (`QUICKTYPE_REF`, `QUICKTYPE_REFERENCE`, `QUICKTYPE_DIR` today), and a
  recorder for `crates/quicktype-core/tests/data/target_languages.json`.
- The clippy lints that `rust-version = "1.88"` turns on
  (`collapsible_if` with let chains, `manual_is_multiple_of`; about 50
  places in 30 files) are allowed in `[workspace.lints.clippy]` until the
  open branches have merged. Then fix them (`cargo clippy --fix`) and
  remove the two `allow`s.

## Phase 5 — Remaining inputs — ✅ done (GraphQL, Postman, URL sources, --graphql-introspect)

GraphQL (`quicktype-graphql-input`, with a port of graphql-js's parser) and
`--graphql-introspect` — ✅ done (`feat/graphql-input`); Postman
collections, URL sources.

## Phase 5b — TypeScript input (via the TypeScript 7 native compiler) — ✅ done (wired into the CLI)

`--src-lang typescript` needs a real type checker. Route: drive the
TypeScript 7 native compiler's type-checker API (MessagePack over stdio to
`tsc`, no Node) from a `quicktype-typescript-input` crate, plus a port of
the `typescript-json-schema` subset quicktype uses; the resulting JSON
Schema enters the normal pipeline. Parity with the reference (which runs
`typescript-json-schema` on TS 5.9.3) is proven against recorded TS-input
cases. Feasibility spike: `docs/research/07-typescript-input.md`.
(TypeScript as an *output* language is just another renderer.)

## Phase 6 — JavaScript API and distribution — ✅ JS API done; npm distribution of the native CLI pending

- The JS API runs on WebAssembly in both Node.js and browsers, behind
  quicktype's own TypeScript API as a thin facade:

  ```
  user code ──► npm quicktype-core   same TS API (quicktype(), InputData, JSONSchemaInput, …),
                   │                 taken from quicktype's own API layer; does input
                   │                 collection, option handling and I/O (fs / fetch)
                   ▼
                quicktype-wasm       one call per run: inference, rewrites, naming, rendering
  ```

  The public classes, `.d.ts` files and option types come from quicktype
  itself, so the interface is identical by construction. I/O (file reads,
  `$ref` fetching, async schema stores) stays in JS as today; only pure
  compute crosses into WASM.
- Custom target languages (user subclasses of `TargetLanguage` /
  `ConvenienceRenderer`) cannot render inside WASM. The facade keeps the
  original TypeScript engine as a fallback for those only; all built-in
  languages go through WASM.
- [x] `crates/quicktype-wasm` (one call per run, schema fetches through
      the facade's stores, structured errors) and `npm/quicktype-core`
      (quicktype-core's own sources with `Run.ts` dispatching to the
      engine; Node and browsers; identical `.d.ts` files)
- [x] `**` on `wasm32` = the host's `Math.pow` (`js-host-math`)
- [x] Differential API test suite against the reference npm package
      (including ports of quicktype's API-level Vitest tests), in CI
      against the package's own TypeScript engine
- [ ] `quicktype-graphql-input` on the engine (after Phase 5's GraphQL input)
- [ ] The engine parses plain JSON text itself (with `JSON.parse`
      semantics) instead of receiving quicktype's TypeScript-built
      `CompressedJSON` tables: in browsers the warm engine is only about
      as fast as warm TypeScript today, because reading the input is still
      TypeScript and the tables are converted at the boundary
- [ ] The facade's fallback for `Object.prototype` enum option values can
      go to the engine now (after a differential run)
- [ ] Browser playground on GitHub Pages (`site/`)
- [ ] Distribution: per-platform npm packages of the native CLI,
      `cargo-dist` release archives and installers, and the TypeScript 7
      compiler built from pinned source and shipped next to the binary
      (`cargo xtask tsc`)

## Phase 7 — Performance — ✅ first round done

Benchmarks against the TypeScript implementation (startup, small and large
inputs, the full corpus), profiling, and optimization without changing output.

- [x] `cargo xtask bench` (CLI vs TypeScript CLI, corpus, in process vs
      warm TypeScript) and the first round of profiling-driven
      optimizations: see [BENCHMARKS.md](BENCHMARKS.md) (CLI 8–96× faster
      than TypeScript, the engine 2.4× faster in process).
- [x] Streamed JSON samples (64 KiB chunks, Node's chunked UTF-8
      decoding) and `CompressedJSON` in blocks: 2.6 GB input 7.2 → 6.2 GB
      peak memory, output identical.
- [ ] Share identical per-string attribute sets during inference (about
      2–3 GB of a 2.6 GB input's peak), keeping the exact counts enum
      inference needs.

## Phase 8 — Big inputs (planned)

Inference from running tallies instead of a full copy of the document, then
parallel chunks (threads in the CLI, workers in browsers) whose tallies merge
in file order. quicktype's decision code stays as it is; the tallies (counts,
distinct values, first-seen order, combined string attributes) must equal
what it computes from the full value lists. The current path stays as the
reference: every test and a seeded random-document generator run both paths
and require identical output. Memory then grows with the number of distinct
fields and strings instead of the file size.
