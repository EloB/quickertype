# Type graph test generators

Node scripts that record the reference implementation's behavior for the
type graph port (`crates/quicktype-core/src/{ty,attributes}`,
`graph_rewriting.rs`, `union_builder.rs`, `unify_classes.rs`). They need a
built quicktype checkout (`npm ci && npm run build`); the Rust tests only read
the committed fixtures and never need Node.

| Script | Writes |
|---|---|
| `gen-chance-data.mjs <quicktype>` | `crates/quicktype-core/src/support/chance_data.rs` (the word lists of `Chance.ts`) |
| `gen-fixtures.mjs <quicktype>` | `tests/fixtures/core-type-graph/chance.txt` (random name sequence), `combined-names.txt` |
| `run-scenarios.mjs <quicktype>` | `tests/fixtures/core-type-graph/scenarios/*.expected` |

```sh
node xtask/core-type-graph/run-scenarios.mjs ../quicktype
cargo test -p quicktype-core --test type_graph_scenarios
```

## Scenarios

A scenario (`scenarios/*.txt`) is a short program that drives `TypeBuilder`,
rewrites, remaps, unification and the graph printer; the language is
documented at the top of `run-scenarios.mjs`. The script runs it against the
TypeScript classes and records everything printed (graphs, `# <title>`
headers, `--debug print-reconstitution` traces, errors).
`crates/quicktype-core/tests/type_graph_scenarios.rs` interprets the same
program with the Rust port and compares the output byte for byte. To cover a
new behavior, add a `.txt` scenario and regenerate the `.expected` files.

## Diffing a whole run against the reference

`TypeGraph::print_graph` reproduces `printGraph()` exactly, and
`set_print_on_rewrite` prints `# <title>` plus the new graph after every
rewrite, as `--debug print-graph` does in TypeScript. Once the pipeline runs
end to end, find the first diverging stage with:

```sh
node ../quicktype/dist/index.js --lang rust --debug print-graph,provenance input.json > ts.txt
target/release/quicktype --lang rust --debug print-graph,provenance input.json > rs.txt
diff ts.txt rs.txt | head
```

Each type prints as `index: kind[ combinedName] | children i,j | attributes`,
so the first differing line names the stage (the preceding `# title`) and the
type index where creation order, deduplication or attributes diverge. Add
`print-reconstitution` to see the order in which each rewrite reconstitutes
types.
