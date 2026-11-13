# Progress log

Newest first. Parity numbers are `cargo xtask parity` on `main`.

## 2026-11-13

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
