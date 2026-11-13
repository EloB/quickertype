# Progress log

Newest first. Parity numbers are `cargo xtask parity` on `main`.

## 2026-11-13

- **Parity 10,796 / 11,177 (96.6%), 0 regressions.** Merged Go + JSON
  Schema output, GraphQL input (hand port of graphql-js 16's parser;
  228 input cases, 2,510 parser vectors, 38 introspection runs identical),
  and a recursion-guard sweep (14 languages used to abort on cyclic
  schemas; all now return the reference's RangeError). Every input type and
  every output language except C is on `main`; the remaining 381 cases all
  need the C renderer (in progress).
- Phase 7 (benchmarks + hot paths) started.
- JS API after merging wave 2: languages the engine lacks (cJSON, Go, JSON
  Schema output) fall back to the TypeScript engine via
  `QuickTypeError::unsupported`/`has_renderer`. Differential suite: 18,718
  scenarios, 18,717 identical (17,006 on WebAssembly, 1,636 on the
  TypeScript fallback, 75 on TypeScript by eligibility), 1 known gap, 0
  different. Engine: 4.8 MiB (1.6 MiB gzipped).

- **Parity 10,174 / 11,177 (91.0%), 0 regressions.** Merged language wave
  2 so far: Crystal, C++; Swift, Objective-C, Dart; Ruby, Elixir, Python
  (each reviewed; 100% of render cases and every end-to-end case except
  GraphQL input). Remaining: C (cJSON), Go + JSON Schema output (review
  fixes), GraphQL input (in review).
- JS API (`feat/wasm-js-api`, in review): WASM engine behind quicktype's
  own TypeScript API; 0 differences over 18,717 differential scenarios
  against npm quicktype-core; all 416 `.d.ts` files byte-identical. In-process
  WASM speed is about equal to warm TypeScript (the big speedup is the
  native CLI, which skips Node startup); WASM performance is a Phase 7 item.

- **Parity 7,331 / 11,177 (65.6%), 0 regressions.** Merged
  `feat/run-and-cli` (Phase 3: Run, the public Rust API, the CLI generation
  path); every ported language now passes its golden cases end to end.
  Rough speed: ~18 ms per run vs ~750 ms for the TypeScript CLI.
- Language wave 1 merged (each reviewed, 100% of recorded render cases):
  JavaScript, TypeScript, Flow, Zod, Effect Schema, PropTypes, Elm; Java,
  Kotlin; C#, Pike; Haskell, Scala 3, Smithy4s, PHP. Merged
  `feat/core-json-schema-input` (190/190 schema cases).
- Started wave 2: C (cJSON); Crystal, C++; Ruby, Elixir, Python; Swift,
  Objective-C, Dart; Go, JSON Schema output; and GraphQL input (Phase 5).

- Merged `feat/core-rendering` (rendering framework + the Rust renderer:
  364/364 Rust golden cases render byte-identically from the reference's
  pre-naming graph) and `feat/core-json-input` (both JSON readers match the
  reference 100%; V8-exact `JSON.parse`, 5,017/5,017 vectors). Each
  reviewed; findings fixed (incl. 2 crash bugs in JSON input).
- Started Phase 3 (`feat/run-and-cli`: Run + CLI generation path, aiming
  for the first end-to-end golden passes) and language wave 1 in parallel:
  `feat/lang-js-family`, `feat/lang-java-kotlin`, `feat/lang-csharp-pike`,
  `feat/lang-haskell-scala-php`. `feat/core-json-schema-input` is in
  review fixes.

- Merged `feat/typescript-input`: TypeScript input without Node, via the
  TypeScript 7 native compiler's `tsc --api` protocol. 474/474 recorded
  cases produce the reference JSON Schema byte for byte (~10x faster per
  case than the reference CLI). Wiring into the CLI comes with Phase 3.
- Merged `feat/core-pipeline`: all rewrite passes, MakeTransformations and
  Transformers; 47 differential scenarios match byte for byte.

- **Phase 1 done.** Merged `feat/cli`, `feat/js-compat`,
  `feat/core-type-graph` (each reviewed; all findings fixed or documented
  under "Known gaps" in `docs/PARITY.md`). ~26k lines of Rust. Parity:
  113/11,177 (all help, version and argument-error cases), 0 regressions.
- Started Phase 2 (engine: JSON input, pipeline, rendering + Rust renderer,
  JSON Schema input) and `feat/typescript-input` in parallel.

- TypeScript-input spike (`docs/research/07-typescript-input.md`): feasible
  without Node via the TypeScript 7 native checker. 564/596 TS inputs give a
  byte-identical schema (94.6%); remaining diffs are union member order only
  (TS 5 creation order vs TS 7), and a creation-order emulation already fixes
  610/616 affected unions. End to end 99.2% of case × language pairs match.
- Phase 1 branches finished; reviews done or running, review fixes in
  progress. `feat/cli` adds 1,045 CLI-behavior cases (corpus now 11,177, all
  passing against the TypeScript CLI); the Rust CLI passes 113 of them.

- Merged `feat/xtask-diff`: `cargo xtask diff` compares the TypeScript CLI
  and ours live, side by side (reviewed: 9 findings, 7 fixed, 2 deferred).
- Phase 1 started in parallel: `feat/js-compat`, `feat/core-type-graph`,
  `feat/cli`. Feasibility spike for TypeScript input via TS 7 running.
- Research complete: `docs/research/01`–`06`; parity rules in
  `docs/PARITY.md`.
- Golden corpus: 10,132 recorded runs of the TypeScript CLI; 10,132/10,132
  pass against the TypeScript CLI itself. Rust parity: 0 (stub CLI).
