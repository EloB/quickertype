# Roadmap

Goal: a complete, byte-identical replica of quicktype (CLI and JS API) in
Rust. Progress is measured by `cargo xtask parity` (11,177 golden cases) and,
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
- The CLI and the WASM bindings use the public API (dogfooding) plus
  `quicktype_core::internal`; like any `Input` implementation, the WASM
  bindings also reach into hidden modules (`ty`), see
  [ARCHITECTURE.md](ARCHITECTURE.md#1-crates).
- I/O (schema `$ref`s, URL sources) goes through a pluggable trait (`Io`):
  std file + HTTP implementations behind cargo features for native builds.
  The WASM build has no `Io`; it fetches schemas through the JS facade's
  stores (`JsonSchemaStore::get`).
- crates.io-ready: rustdoc with doctested examples, semver discipline.

## Phase 0 — Foundations

- [x] Workspace layout, lints, toolchain, CI
- [x] Golden corpus recorded from quicktype `c39af7d3` (10,132 cases),
      cross-checked against quicktype's own output snapshot
- [x] Parity runner with ratchet baseline (`cargo xtask parity`)
- [x] Corpus self-check: 10,132/10,132 pass against the TypeScript CLI
- [x] Research notes per area (`docs/research/`)

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

## Cleanup backlog (cross-branch follow-ups) — ✅ done on `chore/cleanup-backlog`, its two follow-ups on `chore/clippy-188-lints`

The branch also moved `acronymOption`/`convertersOption` into `support/`
as in TypeScript, corrected module headers that named missing TS files,
and made GraphQL input's linear-time test independent of machine load.

- [x] Dedupe `transformers.rs`'s `lookup_*` helpers with
      `attributes::type_attributes::{transformation_for_type, follow_target_type}`
      (generic over `TypeLookup`, which lives next to `TypeGraph` and
      `TypeBuilder` in `ty::type_graph`).
- [x] Move the remaining per-language `intercalate` and JS number-formatting
      copies to `support::collection_utils::array_intercalate` and
      `quicktype_js_compat::number::to_string`; switch the Rust renderer to
      `match_type_unsupported` (now every port of a TS `matchType` falls
      back with it, and RENDERERS.md's cheat sheet says so).
- [x] Stale "not ported yet" comments (`input/inputs.rs`, `tests/run.rs`,
      `tests/json_input_vitest.rs`, `tests/json_schema_vitest.rs`, and the
      skips they described in `tests/run.rs` and the CLI's `tests/cli.rs`)
      and the CLI's own `trim`/whitespace helpers in `js.rs`, which
      duplicate `quicktype_js_compat::whitespace`.
- [x] `input/io/node_io.rs` says the WASM build implements `Io`; it
      implements `JsonSchemaStore::get` through the facade's stores instead.
- [x] One name for the reference checkout's environment variable:
      `QUICKTYPE_REFERENCE` everywhere (`QUICKTYPE_REF` and `QUICKTYPE_DIR`
      still work, with a warning; the recorders share
      `xtask/reference.mjs`), and a recorder for
      `crates/quicktype-core/tests/data/target_languages.json`
      (`xtask/core-rendering/record-target-languages.mjs`, which reproduces
      the committed file byte for byte).
- [x] Follow-ups (`chore/clippy-188-lints`): the JSON input tests use
      `quicktype_core::internal::block_on` instead of their own, and the
      clippy lints that `rust-version = "1.88"` turns on (`collapsible_if`
      with let chains, `manual_is_multiple_of`) are fixed and no longer
      allowed in `[workspace.lints.clippy]`.

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

## Phase 6 — JavaScript API and distribution — ✅ done

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
- [x] The engine reads JSON text and bytes itself (with `JSON.parse`
      semantics), instead of receiving quicktype's TypeScript-built
      `CompressedJSON` tables
- [x] Browser playground on GitHub Pages (`site/`)
- [x] Distribution: the native CLI on npm (`quickertype`), dist's release
      archives and installers, Homebrew, the MSI, and the TypeScript 7
      compiler (Microsoft's pinned package) shipped next to the binary
- Parked: GraphQL input and `Object.prototype` enum option values on the
  engine, and a compiler of our own (see [Parked](#parked))

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
- [x] Share identical per-string attribute sets during inference (about
      2–3 GB of a 2.6 GB input's peak), keeping the exact counts enum
      inference needs: superseded by Phase 8a, which keeps one combined
      set per place.

## Phase 8 — Big inputs (done)

Inference from running tallies instead of a full copy of the document, then
parallel chunks (threads in the CLI, workers in browsers) whose tallies merge
in file order. quicktype's decision code stays as it is; the tallies (counts,
distinct values, first-seen order, combined string attributes) must equal
what it computes from the full value lists. The current path stays as the
reference: every test and a seeded random-document generator run both paths
and require identical output. Memory then grows with the number of distinct
fields and strings instead of the file size.

- [x] 8a — Streaming inference (`feat/streaming-inference`): the readers
      emit into a `JsonSink`; `input/tallies.rs` counts, per place in the
      samples, what `Inference.ts` reads from its value lists, and
      `input/tally_inference.rs` runs `Inference.ts`'s decisions on them.
      The CLI and `JsonInput` use it; `JsonInput::from_compressed` (the
      WebAssembly facade's tables) keeps inferring from `CompressedJSON`,
      the reference. The equivalence argument, one section per tally
      operation, is [STREAMING-INFERENCE.md](STREAMING-INFERENCE.md);
      `cargo xtask streaming-fuzz` compares both paths on generated inputs
      (graphs after inference and whole runs), and generated documents are
      compared with the TypeScript CLI. 2.6 GB input: peak RSS 5.0–5.8 GiB
      → 60 MiB, as for the 40 MB input it repeats; a quarter to a third
      less CPU time (see
      [BENCHMARKS.md](BENCHMARKS.md#streaming-inference-phase-8a)).
- [x] 8b — Parallel chunks (`perf/parallel-read`): the CLI reads a regular
      file of 8 MiB or more whose top-level value is an array (or standard
      input redirected from one) on several threads, cut where a scan
      that knows strings and escapes finds the commas between its
      elements; each part's tallies are appended in file order
      (`Tallies::merge` is the merge), within a memory budget, and
      anything unexpected reads the rest in one go. The design and why it
      is exact: [STREAMING-INFERENCE.md](STREAMING-INFERENCE.md#reading-on-several-threads);
      1M records 4.5× faster on 12 cores
      ([BENCHMARKS.md](BENCHMARKS.md#reading-on-several-threads)).
- [x] 8c — Workers in the browser (`perf/browser-workers`): the
      playground reads a JSON array or JSON Lines file of 16 MiB or more
      on up to eight Web Workers, by the same rules
      ([BENCHMARKS.md](BENCHMARKS.md#reading-on-several-workers)). The npm
      library still reads on one engine instance ([Parked](#parked)).

## Parked

Ideas deliberately not done, each with why. This is the one list of them:
the phases above have none left open.

**Speed**

- **SIMD in the JSON reader.** Tried natively with NEON (November 2026,
  M2 Max): the split scan found each 64-byte block's quotes, backslashes
  and brackets in four registers, and the tokenizer its string runs
  sixteen bytes at a time, with the same output (tested against the
  eight-byte code for every byte at every place). On 12 threads, after
  the parts-in-flight fix: the 3.0 GB cards 0.98 → 0.91 s (6% less CPU
  time), the 657 MB cards 0.21 → 0.19 s, the 2.5 GB text-heavy array
  (strings of about 210 characters) 0.30 → 0.23 s; on one thread about
  1%. What is left is mostly not scanning: classifying strings (dates,
  URIs, UUIDs) and tallying. It needs `unsafe` code (the intrinsics, in a
  module of about 130 lines), which the workspace denies
  (`unsafe_code = "deny"`), and code of its own for each architecture
  (x86 would need SSE or AVX); the reader scans eight bytes at a time in
  plain Rust instead. In WebAssembly, simd128 gained under 2% (below).
- **simd128 for the WebAssembly engine** (`-C target-feature=+simd128`).
  Under 2% on every input measured (pokedex 2.20 → 2.20 ms, 20 MB 151–153
  → 149–152 ms, the 100k records 55.5–56.1 → 55.1–55.3 ms), for a module
  79 KB smaller, and it would raise the browsers the engine needs to
  Safari 16.4 (from 15), Chrome 91 and Firefox 89
  ([BENCHMARKS.md](BENCHMARKS.md#where-the-time-goes-in-the-browser-phase-by-phase)).
- **Packing a compressed JSON value into 4 bytes.**
  `input::compressed_json::Value` is a tag and a 32-bit index, 8 bytes;
  with the tag in the index's top bits it would take 4, halving the
  compressed form's object and array tables. `Value` is a public enum of
  the Rust API, so this is a breaking change, and the CLI and the
  playground's large files read into tallies, not the compressed form.
- **TypeScript's `initTypeNames()` made lazy in the npm package.**
  `Run.preRun()` seeds TypeScript's Mersenne Twister on every run, before
  the run is handed to the engine: about 8% of a tiny run's time in a
  profile of 20,000 of them. Making it lazy means changing
  `attributes/TypeNames.ts`, an upstream file the package keeps verbatim
  (the engine's own type names are already seeded lazily).
- **TypeScript input's remaining engine phases.** At 10,000 interfaces
  the engine's part is reading the schema (1.15 s), making optional
  properties nullable (0.71 s) and resolving intersections (0.41 s). Each
  is linear now (the quadratic steps were fixed;
  [BENCHMARKS.md](BENCHMARKS.md#typescript-input)), the whole run is about
  3× quicktype's speed, and these are ports of quicktype's passes whose
  order decides the output.
- **Linking the TypeScript compiler in-process** for TypeScript input. The
  compiler is Go: linking it into the Rust binary needs cgo and a foreign
  function interface (`unsafe` code, which the workspace forbids), a Go
  toolchain in every build, and an API the compiler does not offer as a
  library. The pipe is no longer what costs: the requests go out in 8 to
  15 pipelined batches whatever the input's size, and what is left is the
  compiler's own processing (2.0 s of the 10,000 typings' run).
- **Reading in parts in the npm library.** Only the playground reads a
  large file on several workers. quickertype-core's `src/native/parallel.ts`
  is internal: a public API would need workers in Node.js and in every
  bundler's browser build, which the playground provides itself
  (`site/src/part-pool.js`, `part-worker.js`). The library reads a large
  sample on one engine instance.

**Distribution**

- **A trimmed TypeScript compiler of our own.** The release archives
  bundle Microsoft's unmodified `@typescript/typescript-<os>-<arch>`
  package (about 7 MB per archive, 9.5 MB for the Windows zip). Building
  our own, with only what `tsc --api` needs, would save about 2–3 MB per
  download, at the cost of maintaining a compiler build for five targets
  instead of checking a pinned hash
  ([RELEASING.md](RELEASING.md)).
- **The TypeScript compiler in the shell and PowerShell installers.**
  They install only the archive's binaries, and dist (0.34) has no setting
  to install more; Homebrew, npm, the MSI and the archives have it.
  Without it, TypeScript input names the package to install.
- **The npm package's GraphQL input on the engine.** Runs with
  `quicktype-graphql-input` (npm) go to the TypeScript engine, which gives
  quicktype's output; the CLI and the Rust API run GraphQL natively.
- **Enum option values from `Object.prototype` on the engine.** An enum
  renderer option whose value is a name only `Object.prototype` has
  (`toString`, say) goes to the TypeScript engine, as quicktype reads it
  with `in`; the engine does not model it.

**Generated code**

- **C (cJSON): reject enum values that are no case.** An enum's getter
  gives `0` for a value that is not one of its cases (quicktype's
  behavior, which the port keeps; it only stopped the getter from passing
  `NULL` to `strcmp`), so lists, maps and unions store that `0`, and a
  class property's `0 == cJSON_Get<E>Value(v)` check rejects a case whose
  value is 0 (`qt-enum-values`). A first attempt (on `fix/quicktype-bugs`, reverted in review) added a
  `cJSON_Is<E>Value` check at every call site. Lessons for the next one:
  do it in the getter (an out-parameter or a sentinel), not per call
  site; mind nullable items (a `null` in a list of nullable enums is not
  an error), union containers (lists and maps that are union members) and
  top-level lists of nullable enums; don't add rejection paths to maps,
  which leak the map when they reject an element; `cJSON_Is<Name>` is
  also how union check macros are named, so pick a name that cannot
  clash; and match each value against the cases once, not once to check
  and again to get it.
