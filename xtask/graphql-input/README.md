# GraphQL input test generators

Node scripts that record the reference implementation's behavior for the
GraphQL input port (`crates/quicktype-graphql-input`). They need a built
quicktype checkout (`npm ci && npm run build`); the Rust tests only read the
committed fixtures and never need Node.

| Script | Writes | Replayed by |
|---|---|---|
| `run-graphql-inputs.mjs <quicktype>` | `crates/quicktype-graphql-input/tests/fixtures/graphql-input/`: `cases.json` (the manifest and graphql-js's introspection query), `expected/<id>.txt` (per case, the type graph right after input or the error), `schemas/*.gqlschema` (introspection results of the SDL schemas in the script) and `parse-vectors.json` (graphql-js's `parse` on seeded mutations of valid documents) | `quicktype-graphql-input/tests/graphql_input.rs` |

```sh
node xtask/graphql-input/run-graphql-inputs.mjs ../quicktype
cargo test -p quicktype-graphql-input --test graphql_input
```

A case adds its sources (`{name, schema, query}`, the schema read with
`parseJSON` like `--graphql-schema`) to a `GraphQLInput`, runs `addTypes`
with a `TypeBuilder` like Run's and prints the graph (`printGraph`), then
what the printer leaves out: each class's properties (name, type index,
optionality), each enum's cases and the top-levels. An exception ends the
output with `error: <class> <message>` (`QuickTypeError`, `GraphQLError`,
`TypeError`, `RangeError`).

The cases are every query in `tests/inputs/graphql` against the GitHub
schema (one at a time, as the CLI adds them, and all at once), queries
against two small SDL schemas (aliases, fragments, inline fragments,
directives, interfaces, unions, enums, lists, mutations, naming, several
sources, and the errors: unknown fields, fragments and types, `__typename`,
`Object.prototype` names, recursive fragments), graphql-js syntax errors
and malformed introspection results. To cover a new behavior, add a case
to the script and re-run it.

Fragments that spread themselves without a field in between make the
TypeScript loop forever; they are listed as `nonTerminating` and the Rust
test checks the port's own error for them (see `docs/PARITY.md`, Known
gaps).
