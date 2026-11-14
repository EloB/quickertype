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

## Fuzzing

`fuzz/` holds [cargo-fuzz](https://github.com/rust-fuzz/cargo-fuzz) targets
that look for crashes (any panic: release builds abort on one), hangs and
runaway memory. It is a workspace of its own and needs a nightly toolchain,
which only it uses:

```sh
rustup toolchain install nightly
cargo install cargo-fuzz
node fuzz/seed-corpora.mjs            # seed corpora from tests/inputs and the vectors
cargo +nightly fuzz list
cargo +nightly fuzz run pipeline -s none -- -max_len=16384 -timeout=30 -dict=fuzz/dicts/json.dict
```

The targets: `json_stream` and `json_parse` (the two JSON readers),
`json_schema` (with `$ref`s between in-memory documents), `graphql_parse`,
`graphql_input`, `postman`, `yaml`, `uri`, `number`, `cli_args` (the
CLI's option parsing) and `pipeline` (JSON to every language with
arbitrary run and renderer options). Each file in `fuzz/fuzz_targets` describes its input
format, `fuzz/dicts` has token dictionaries for them (see
`.github/workflows/fuzz.yml` for which goes with which, and for the
lengths and timeouts). `-s none` turns off AddressSanitizer, which adds
little to code without `unsafe` and slows the runs down. The inputs are
at most 16 KB, so nesting a few thousand levels deep is out of the
fuzzers' reach: try such inputs by hand against the TypeScript CLI (see
"Stack depth" in `docs/PARITY.md`).

A finding is written to `fuzz/artifacts/<target>/`. Minimize it with
`cargo +nightly fuzz tmin -s none <target> <file>`. For `pipeline`,
`json_schema` and `graphql_input`, running the target on the file with
`QUICKTYPE_FUZZ_EXPLAIN=<dir>` writes the inputs to `<dir>` and prints the
equivalent `quickertype` command line, to compare with the TypeScript CLI
(`cargo xtask diff`). Fix the port to do what quicktype does, and add a
regression test. `.github/workflows/fuzz.yml` runs every target for a few
minutes each week.

## Releases

Releases are cut from `main` by pushing a version tag; the version, the
changelog and the steps are in [docs/RELEASING.md](docs/RELEASING.md).
Add user-visible changes under `## [Unreleased]` in
[CHANGELOG.md](CHANGELOG.md). `.github/workflows/release.yml` is generated
by dist from `dist-workspace.toml`: change the config and run
`dist generate`, never the workflow.
