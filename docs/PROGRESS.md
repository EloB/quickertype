# Progress log

Newest first. Parity numbers are `cargo xtask parity` on `main`.

## 2026-11-13

- Merged `feat/xtask-diff`: `cargo xtask diff` compares the TypeScript CLI
  and ours live, side by side (reviewed: 9 findings, 7 fixed, 2 deferred).
- Phase 1 started in parallel: `feat/js-compat`, `feat/core-type-graph`,
  `feat/cli`. Feasibility spike for TypeScript input via TS 7 running.
- Research complete: `docs/research/01`–`06`; parity rules in
  `docs/PARITY.md`.
- Golden corpus: 10,132 recorded runs of the TypeScript CLI; 10,132/10,132
  pass against the TypeScript CLI itself. Rust parity: 0 (stub CLI).
