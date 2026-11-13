# Rendering test generators

Node scripts that record the reference implementation's rendering for the
differential renderer tests. They need a built quicktype checkout
(`npm ci && npm run build`); the Rust tests only read the committed fixtures.

| Script | Writes | Replayed by |
|---|---|---|
| `record-render-cases.mjs <quicktype> [lang...]` | `crates/quicktype-core/tests/fixtures/core-rendering/cases/*.json` | `tests/render_cases.rs` |
| `run-render-scenarios.mjs <quicktype>` | `crates/quicktype-core/tests/fixtures/core-rendering/scenarios/*.json` from the `*.txt` next to them | `tests/render_scenarios.rs` |

```sh
node xtask/core-rendering/record-render-cases.mjs ../quicktype rust
node xtask/core-rendering/run-render-scenarios.mjs ../quicktype
cargo test -p quicktype-core --test render_cases --test render_scenarios
```

## Render cases

For every golden case of the given languages (default `rust`: `rust/`,
`schema-rust/`, and the Rust `cli-options`/`cli-stdout` cases), the reference
CLI runs in-process with the case's arguments. Two calls are intercepted:
`gatherNames`, where the graph is dumped (types in index order with their
attributes, top-levels, the `destructive` flag and how many random names the
run has drawn so far), and `renderGraphAndSerialize`, whose arguments are
recorded and whose result must equal the golden files (or stdout) before the
fixture is written. The Rust test rebuilds the graph at the same type
indexes, runs `gather_names` and the language's `render_graph_and_serialize`,
and compares every file and, for cases without `--quiet`, the issue
annotations the CLI prints to stderr. Lines the render prints with
`console.log` (`finishFile`'s `[WARNING] Tried to emit file ... more than
once`, e.g. Go's `--multi-file-output`) are recorded as `console`; the test
captures `console_log`, compares the lines and puts them ahead of the files
when it checks stdout. A few cases from quicktype's unit tests (API calls)
carry their expected output inline.

A `transformation` attribute (C# and Python make transformations) is dumped
as `{ target, xfer }`: the index of the target type and the transformer tree.
Both scripts use `dump-transformation.mjs`, which documents the JSON shape;
`tests/render_support` rebuilds it with `quicktype_core::transformers`.

Multi-file languages (Java) write every file next to `--out`, into the
case's `dirs`, which the recorder creates first. When such a render goes to
stdout, the CLI prints the files under `// <name>` headers; the fixture then
names the stdout golden once (`stdout`, with `quiet` for `--quiet`, which
drops the separators) and the test joins the rendered files exactly like
`writeOutput`. `cliCases` are CLI runs the corpus lacks (`cli-extra/*`, e.g.
quiet multi-file stdout), recorded through the real CLI with their stdout
inline (`stdoutText`). A case whose render differs from its golden, or that
throws, is reported and skipped (the exit code is 1); the others are still
recorded.

## Scenarios

A scenario (`scenarios/*.txt`) lists inputs (`input json|jsonsamples|schema NAME <json>`),
optional pipeline options, and renders (`render <lang> <json args>`); the
language is documented at the top of `run-render-scenarios.mjs`. `probe` is a
test language whose `ConvenienceRenderer` is configured per render and runs
an emit script, so blank lines, tables, annotations, multi-file output,
naming, comments and declarations can be tested without a real renderer. The
Rust twin of the probe is in `tests/render_scenarios.rs`; change both
together. A renderer stores its names in the TypeScript graph, so the script
rebuilds the graph for every render.
