# quicktype (Rust)

A Rust port of [quicktype](https://github.com/glideapps/quicktype) with a single goal:
**behave exactly like quicktype, only much faster.**

- The `quicktype` CLI: same flags, same help text, same output, byte for byte.
- The `quicktype-core` JavaScript API: same exports and types, backed by
  WebAssembly, in Node.js and browsers.
- A Rust API (`quicktype-core` crate) that the CLI and the WASM bindings are
  built on.

Exactness isn't a slogan here; it's tested. Every one of the 11,177 cases in
`tests/golden` is a recorded run of the TypeScript quicktype CLI, and
`cargo xtask parity` replays them against this implementation and compares
every generated file (and, for the `cli-*` cases, stdout, stderr and the exit
code) byte for byte.

> Status: scaffolding. See [docs/ROADMAP.md](docs/ROADMAP.md) for the plan and
> `tests/parity-baseline.txt` for the cases that pass today.

## Layout

```
crates/
  quicktype-core/              the engine (port of packages/quicktype-core)
  quicktype-cli/               the `quicktype` binary (port of src/)
  quicktype-graphql-input/     GraphQL input (port of packages/quicktype-graphql-input)
  quicktype-typescript-input/  TypeScript input via the TypeScript 7 native checker
                               (port of packages/quicktype-typescript-input + typescript-json-schema)
  quicktype-wasm/              WebAssembly bindings for the JS API
npm/                           JS packages wrapping quicktype-wasm (same API as npm quicktype-core)
xtask/                         dev tasks: parity runner, golden recorder
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
```

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

See [CONTRIBUTING.md](CONTRIBUTING.md) for the workflow and
[docs/PARITY.md](docs/PARITY.md) for the rules that keep output identical.

## License

Apache-2.0, like quicktype. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
