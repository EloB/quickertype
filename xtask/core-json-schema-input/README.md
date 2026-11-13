# JSON Schema input test generators

Node scripts that record the reference implementation's behavior for the
JSON Schema input port (`crates/quicktype-core/src/input/json_schema_*`,
`input/io`, `support/parse_json.rs`) and for the JavaScript libraries it
depends on. They need a built quicktype checkout (`npm ci && npm run
build`); the Rust tests only read the committed fixtures and never need
Node.

| Script | Writes | Replayed by |
|---|---|---|
| `gen-uri-vectors.mjs <quicktype>` | `crates/quicktype-js-compat/tests/vectors/uri.json`: urijs 1.19.11 parse/accessors/normalize/absoluteTo/equals, the URI component coders, `Number(string)` | `quicktype-js-compat/tests/uri_vectors.rs` |
| `gen-yaml-vectors.mjs <quicktype>` | `crates/quicktype-js-compat/tests/vectors/yaml.json`: `YAML.parse` (yaml 2.9.0) values or errors | `quicktype-js-compat/tests/yaml_vectors.rs` |
| `measure-stack-depth.mjs <quicktype>` | nothing: prints the nesting depth at which Node's stack overflows per recursion path (fresh process per probe) | the constants in `input/json_schema_input.rs`, pinned by `quicktype-core/tests/deep_schemas.rs` |
| `run-schema-inputs.mjs <quicktype>` | `crates/quicktype-core/tests/fixtures/core-json-schema-input/{cases.json,expected/}`: per case, the `--debug print-schema-resolving` trace, the type graph after input (`printGraph`) and the attributes the printer does not show, or the error | `quicktype-core/tests/json_schema_input.rs` |

```sh
node xtask/core-json-schema-input/run-schema-inputs.mjs ../quicktype
cargo test -p quickertype-core --features http --test json_schema_input -- --nocapture
```

The schema cases are every `tests/inputs/schema/*.schema` as the CLI adds
it (`{name: "TopLevel", uris: [path]}`, also with every transformed string
kind mapped to `string` when the schema uses `format`), the schema error
cases of the CLI golden corpus, the hand-written edge cases in
`crates/quicktype-core/tests/fixtures/core-json-schema-input/schemas`
(`$ref`/`$id` resolution, errors, keywords, YAML, fragments) and the source
configurations listed in the script (several sources, schema text,
additional schemas, Windows and malformed addresses). Paths are relative to
the repository root, which both sides use as the working directory. To
cover a new behavior, add a schema or a case and re-run the script.

`inputs/ref-remote` fetches a schema from raw.githubusercontent.com; the
Rust test skips it, with a message, when the network or the `http`
feature is unavailable.
