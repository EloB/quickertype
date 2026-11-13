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

## Phase 4 — Language fan-out (parallel)

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

## Phase 5 — Remaining inputs

GraphQL (`quicktype-graphql-input`, with a port of graphql-js's parser) and
`--graphql-introspect` — ✅ done (`feat/graphql-input`); Postman
collections, URL sources.

## Phase 5b — TypeScript input (via the TypeScript 7 native compiler) — ✅ schema generation done; CLI wiring in Phase 3

`--src-lang typescript` needs a real type checker. Route: drive the
TypeScript 7 native compiler's type-checker API (MessagePack over stdio to
`tsc`, no Node) from a `quicktype-typescript-input` crate, plus a port of
the `typescript-json-schema` subset quicktype uses; the resulting JSON
Schema enters the normal pipeline. Parity with the reference (which runs
`typescript-json-schema` on TS 5.9.3) is proven against recorded TS-input
cases. Feasibility spike: `docs/research/07-typescript-input.md`.
(TypeScript as an *output* language is just another renderer.)

## Phase 6 — JavaScript API and distribution

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
- Differential API test suite against the reference npm package (including
  ports of quicktype's API-level Vitest tests)
- npm distribution of the native CLI (per-platform binary packages)

## Phase 7 — Performance

Benchmarks against the TypeScript implementation (startup, small and large
inputs, the full corpus), profiling, and optimization without changing output.
