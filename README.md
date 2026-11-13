# quicktype (Rust)

[![CI](https://github.com/EloB/quickertype/actions/workflows/ci.yml/badge.svg)](https://github.com/EloB/quickertype/actions/workflows/ci.yml)
[![Playground](https://img.shields.io/badge/playground-try%20it%20in%20the%20browser-6e56cf)](https://elob.github.io/quickertype/)

A Rust port of [quicktype](https://github.com/glideapps/quicktype) with a single goal:
**behave exactly like quicktype, only much faster.**

- The `quicktype` CLI: same flags, same help text, same output, byte for byte.
- The `quicktype-core` JavaScript API: same exports and types, backed by
  WebAssembly, in Node.js and browsers.
- A Rust API (`quicktype-core` crate) that the CLI and the WASM bindings are
  built on.

Playground: <https://elob.github.io/quickertype/>, quicktype's API on the
WebAssembly engine in your browser, with a side-by-side run on the TypeScript
engine. Its output matches quicktype at commit
[`c39af7d`](https://github.com/glideapps/quicktype/commit/c39af7d303b025280e2668a1b2d29913093593c9)
(September 8, 2026), which is newer than the v26.0.0 release behind
`npx quicktype` and app.quicktype.io, so some output differs from those.

Exactness isn't a slogan here; it's tested. Every one of the 11,177 cases in
`tests/golden` is a recorded run of the TypeScript quicktype CLI, and
`cargo xtask parity` replays them against this implementation and compares
every generated file (and, for the `cli-*` cases, stdout, stderr and the exit
code) byte for byte.

> Status: all 11,177 recorded cases match the TypeScript quicktype byte for
> byte: every output language, JSON, JSON Schema, GraphQL, Postman and
> TypeScript input, and the CLI's help, errors and exit codes. Known
> divergences that no case exercises are listed in
> [docs/PARITY.md](docs/PARITY.md#known-gaps); what is left to do is in
> [docs/ROADMAP.md](docs/ROADMAP.md).

## Layout

```
crates/
  quicktype-core/              the engine (port of packages/quicktype-core)
  quicktype-cli/               the `quicktype` binary (port of src/)
  quicktype-graphql-input/     GraphQL input (port of packages/quicktype-graphql-input)
  quicktype-typescript-input/  TypeScript input via the TypeScript 7 native checker
                               (port of packages/quicktype-typescript-input + typescript-json-schema)
  quicktype-js-compat/         JavaScript runtime semantics the output depends on (number
                               formatting, UTF-16 strings, sorting, JSON, pluralize, ...)
  quicktype-wasm/              WebAssembly bindings for the JS API
npm/                           JS packages wrapping quicktype-wasm (same API as npm quicktype-core)
site/                          the browser playground (GitHub Pages), built on npm/quicktype-core
xtask/                         dev tasks: parity runner, side-by-side diff, golden recorder
tests/
  inputs/                      quicktype's test inputs, copied verbatim
  golden/                      recorded reference runs (args + expected files)
  parity-baseline.txt          case ids known to pass (the parity ratchet)
docs/                          architecture, parity rules, roadmap, research notes
```

`crates/quicktype-core/src` mirrors `packages/quicktype-core/src` file for file
(snake_case; `Type/` becomes `ty/`), so every Rust module has one obvious
TypeScript counterpart.
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) maps the crates and one run end to end.

## Development

```sh
cargo build                     # build everything
cargo test                      # unit tests
cargo xtask parity              # byte-for-byte parity against the golden corpus
cargo xtask parity --filter rust/json/samples
cargo xtask golden ../quicktype # re-record the corpus from a built quicktype checkout

# run the TypeScript CLI and ours side by side on any arguments and compare
cargo xtask diff -- my.json --lang go
cargo xtask diff --each tests/inputs/json/samples -- --lang rust --just-types

# time ours against the TypeScript CLI (see docs/BENCHMARKS.md)
cargo xtask bench
cargo xtask bench --corpus --in-process
```

The tools that need the reference (`diff`, `bench`, `golden`, the recorders
in `xtask/*/` and the npm differential tests) find the built quicktype
checkout through `$QUICKTYPE_REFERENCE`, else as `../quicktype` or
`../../quicktype` (from a worktree) next to this repository.

Validate the corpus itself against the TypeScript implementation (every case
must pass):

```sh
cargo xtask parity --strict --bin "node ../quicktype/dist/index.js"
```

The npm package (`npm/quicktype-core`, see its README) needs Node 20+ and
`wasm-bindgen-cli` 0.2.114:

```sh
cd npm/quicktype-core && npm install
npm run build                   # the WebAssembly engine + quicktype's TypeScript API
npm test                        # package and engine tests
npm run test:differential       # API calls against the reference quicktype-core vs ours
```

The playground needs that build:

```sh
node site/build.mjs             # into site/dist
node site/test/serve.mjs        # http://127.0.0.1:8080/quickertype/
node site/test/smoke.mjs        # headless Chrome, output compared with target/release/quicktype
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for the workflow and
[docs/PARITY.md](docs/PARITY.md) for the rules that keep output identical.

## License

Apache-2.0, like quicktype. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
