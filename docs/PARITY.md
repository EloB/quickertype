# Parity rules

The port must produce byte-identical output to the TypeScript quicktype. Most
ways to get that wrong come from JavaScript semantics that Rust does not share
by default. This page lists the rules; `docs/research/` has the detailed
findings per area, with file and line references.

## How parity is tested

- **CLI:** `tests/golden` holds 10,132 recorded runs of the TypeScript CLI:
  every fixture in quicktype's test suite (all target languages × JSON, JSON
  Schema and GraphQL inputs × renderer-option variants). A case is a list of
  steps; each step is an argv plus the exact files it must write.
  `cargo xtask parity` replays them in a temp dir and compares bytes.
- **Recording** (`xtask/golden/`): a preload hook intercepts the reference test
  harness's in-process CLI calls, converts each options object into the
  equivalent argv, runs the *real* CLI code path with that argv, and stores
  the args plus every written file. `finalize.mjs` cross-checks the result
  against quicktype's own output snapshot (`OUTPUT_SNAPSHOT_DIR`).
- **Self-check:** the corpus must pass 100% against the reference itself:
  `cargo xtask parity --strict --bin "node ../quicktype/dist/index.js"`.
- **JS API:** a differential suite (planned, `npm/`) runs the same API calls
  against npm `quicktype-core` and our WASM package and compares results.

Known gap: the `schema-golang-leading-comments` fixture drives the library API
rather than the CLI, so it has no CLI recording; it will be covered by the
JS API differential suite.

## Rules

1. **Iteration order is output.** JS `Map`, `Set` and object keys iterate in
   insertion order. Use `IndexMap` / `IndexSet`; never iterate a `HashMap` or
   `HashSet` where order can reach output.
2. **Objects with integer-like keys reorder.** For a JS object (not a `Map`),
   keys that are array indices (`"0"`, `"42"`) iterate first, ascending, then
   the rest in insertion order. Reproduce this wherever the TypeScript uses
   plain objects as maps (notably `JSON.parse` results).
3. **Strings are UTF-16 in JS.** `length`, `charCodeAt`, `slice` and indexing
   count UTF-16 code units. Use explicit helpers when porting such code; do
   not index Rust `str` bytes.
4. **Default `sort()` compares UTF-16 code units**, and is stable. Rust's
   `str` ordering compares UTF-8 bytes, which differs for characters above
   U+FFFF versus U+E000–U+FFFF. Use a JS-compatible comparator.
5. **Number formatting** must match JS `Number.prototype.toString`
   (e.g. `1e21`, `0.1`, `-0` → `"0"`). Use a JS-compatible formatter, not
   `format!("{}")`.
6. **`JSON.stringify`** escaping differs from `serde_json` in corner cases;
   use the shared helper.
7. **Case mapping** (`toUpperCase` / `toLowerCase`) follows full Unicode
   special casing in JS (`ß` → `SS`). Rust's `to_uppercase` does too, but
   char-by-char ports may not; test non-ASCII.
8. **Regexes:** most JS regexes in quicktype map onto the `regex` crate;
   lookaround or backreferences need care. Note each one you port.
9. **No hidden nondeterminism:** no hash-order iteration, no time or
   randomness in output paths.

## Dependency choices

Recorded here when a crate replaces a JavaScript library, with how its
semantics were verified. (Filled in as dependencies are added.)

| JS library | Rust replacement | Verified how |
|---|---|---|
| | | |
