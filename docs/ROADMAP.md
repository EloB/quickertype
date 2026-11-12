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

## Phase 1 — Leaf modules and data model (parallel)

| WP | Branch | Scope |
|---|---|---|
| 1 | `feat/core-support` | `support/*`, a `js_compat` module (JS number formatting, UTF-16 string ops, JS sort, `JSON.stringify` escaping), pluralize port, Markov chain, `Messages`. Differential unit tests against Node. |
| 2 | `feat/core-type-graph` | `Type/*`, `attributes/*`, `TypeBuilder`, `TypeGraph`, `GraphRewriting`, `UnionBuilder`, `UnifyClasses`: the arena-based type graph. |
| 3 | `feat/cli-options` | CLI option model, two-pass parsing, exact `--help`/`--version`/error output, all languages' renderer option declarations. Adds CLI-behavior golden cases (stdout/stderr/exit code). |

## Phase 2 — Engine (parallel, after WP2)

| WP | Branch | Scope |
|---|---|---|
| 4 | `feat/core-json-input` | `CompressedJSON`, JSON inference, `Inputs`/`InputData`, string-type detection |
| 5 | `feat/core-pipeline` | `rewrites/*`, `MakeTransformations`, `Transformers`, `CycleBreaker`, `DeclarationIR`, `Run` |
| 6 | `feat/core-rendering` | `Source`, `Renderer`, `ConvenienceRenderer`, `Naming`, `GatherNames`, `TargetLanguage` |
| 7 | `feat/core-json-schema-input` | `JSONSchemaInput`, schema stores, `$ref`/URI resolution, YAML |

## Phase 3 — First end-to-end language

One simple, well-covered language wired through the CLI, proving the whole
pipeline. First non-zero parity baseline.

## Phase 4 — Language fan-out (parallel)

The remaining languages are split into roughly 8 packages along their base-class
families, so no two packages edit the same files.

## Phase 5 — Remaining inputs

GraphQL (`quicktype-graphql-input`), Postman collections, URL sources and
`--graphql-introspect`.

## Deferred — TypeScript input

`--src-lang typescript` (TypeScript type definitions as an *input*) is out of
scope for now: it is a niche feature, and reproducing it needs a real
TypeScript type checker. The native CLI reports it as unsupported. If it is
wanted later, the route is the TypeScript 7 native compiler's type-checker
API (MessagePack over stdio to `tsc`, no Node) plus a port of
`typescript-json-schema`, with parity proven against recorded TS-input
cases. (TypeScript as an *output* language is unaffected: it is just another
renderer.)

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
