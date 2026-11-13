# Contributing

## Workflow

1. **One work package, one branch.** Branch from `main` as
   `<type>/<scope>`, e.g. `feat/core-type-graph`, `feat/lang-golang`,
   `fix/naming-suffixes`, `chore/ci`.
2. **Small, focused commits** in
   [Conventional Commits](https://www.conventionalcommits.org) form:
   `feat(core): port TypeBuilder`, `fix(lang-rust): match enum rename order`.
   Each commit builds and passes `cargo fmt`, `cargo clippy` and `cargo test`.
3. **Parity ratchet.** Before opening a merge, run `cargo xtask parity`. It
   must report **0 regressions**. If cases newly pass, lock them in with
   `cargo xtask parity --update-baseline` and commit
   `tests/parity-baseline.txt` in the same branch.
4. **Code review before merge.** Every branch is reviewed for correctness
   against the TypeScript original (not just against the golden files), Rust
   idioms, and anything that could make output depend on hash order, platform
   or locale. Findings are fixed on the branch.
5. **Merge to `main`** with `--no-ff` so each work package stays one
   reviewable unit in history.

## Porting rules

- Port **behavior**, not syntax: idiomatic Rust (enums and traits, not class
  hierarchies), but the same algorithm, the same iteration order and the same
  strings. When in doubt, the TypeScript source in
  [glideapps/quicktype](https://github.com/glideapps/quicktype) at the commit
  in `tests/golden/REFERENCE` is the specification.
- Each Rust module starts with `//! Port of <TS path>` so the mapping stays
  traceable. Keep the file layout one-to-one.
- Read [docs/PARITY.md](docs/PARITY.md) before touching ordering, strings or
  numbers.
- No `unsafe`. No new dependency without a note in `docs/PARITY.md` on why its
  semantics match the JavaScript library it replaces.

## Tests

- `tests/golden` is generated: never edit it by hand. Re-record with
  `cargo xtask golden`.
- Unit tests for a module live next to it (`#[cfg(test)] mod tests`). When
  quicktype has a Vitest test for the behavior (`test/unit/*.test.ts`), port
  it and keep its name.

## Releases

Releases are cut from `main` by pushing a version tag; the version, the
changelog and the steps are in [docs/RELEASING.md](docs/RELEASING.md).
Add user-visible changes under `## [Unreleased]` in
[CHANGELOG.md](CHANGELOG.md). `.github/workflows/release.yml` is generated
by dist from `dist-workspace.toml`: change the config and run
`dist generate`, never the workflow.
