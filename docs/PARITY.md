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
- **CLI behavior:** the `cli-*` fixtures (1,045 cases, recorded by
  `xtask/golden/record-cli.mjs`) spawn the reference CLI directly and also
  pin stdout, stderr and the exit code: `--help`/`--version`, default output
  to stdout for every language, every renderer option value, directories,
  stdin, multiple sources, `--out` inference and error paths. A step may
  pipe a `stdin` file and a case may set `env` (e.g. `FORCE_COLOR`); paths
  in the captured streams are normalized to `{INPUTS}` and `{CWD}`.
- **Recording** (`xtask/golden/`): a preload hook intercepts the reference test
  harness's in-process CLI calls, converts each options object into the
  equivalent argv, runs the *real* CLI code path with that argv, and stores
  the args plus every written file. `finalize.mjs` cross-checks the result
  against quicktype's own output snapshot (`OUTPUT_SNAPSHOT_DIR`).
- **Self-check:** the corpus must pass 100% against the reference itself:
  `cargo xtask parity --strict --bin "node ../quicktype/dist/index.js"`.
- **Live side by side:** `cargo xtask diff -- <quicktype args>` runs the
  TypeScript CLI and ours on the same arguments in separate temp dirs and
  compares exit code, stdout, stderr and files; `--each <dir>` repeats it
  over many inputs. Use it for anything outside the corpus.
- **JS API:** a differential suite (planned, `npm/`) runs the same API calls
  against npm `quicktype-core` and our WASM package and compares results.

Known gap: the `schema-golang-leading-comments` fixture drives the library API
rather than the CLI, so it has no CLI recording; it will be covered by the
JS API differential suite.

## Rules

Details and evidence for every rule are in `docs/research/` (01 type graph,
02 inputs, 03 rendering/naming, 04 languages, 05 CLI/API, 06 dependencies).

### Ordering

1. **Iteration order is output.** JS `Map`/`Set` (and `collection-utils`,
   which is insertion-ordered even under hash collisions) iterate in
   insertion order: use `IndexMap`/`IndexSet`. Never let `HashMap`/`HashSet`
   iteration reach output.
2. **Plain objects reorder integer-like keys** (`"0"`, `"42"` first,
   ascending, then insertion order). This applies to `JSON.parse` results
   (API path), YAML, and JSON Schema output; a `"__proto__"` key is also
   special. The CLI's streaming parser keeps source order instead.
3. **Type index order decides output.** Declaration order, duplicate
   resolution and name-suffix assignment follow the order in which types get
   created during graph rebuilding. Port `TypeBuilder`/`GraphRewriting`
   traversal order exactly, including quirks (research 01).
4. **Type identity uses quicktype's hashing.** `EqualityMap` and structural
   type hashing must reproduce the JS hash functions and probing; a derived
   `Eq` + `HashMap` changes which duplicate wins.
5. **Sorting:** default `sort()` compares UTF-16 code units and is stable;
   Rust `str` ordering differs above U+FFFF. Use `js_compat` comparators.
   Comparators that are inconsistent (e.g. `quicktypePropertyOrder` mixing
   numbers and strings) depend on V8's TimSort, so use the `js_compat`
   TimSort port, never `sort_by` (which may panic or differ).

### Strings and Unicode

6. **Strings are UTF-16 in JS.** `length`, indexing, `slice`, `s[0]`,
   table-column widths, word wrapping and interning limits all count UTF-16
   code units. Use the `js_compat` helpers; never index `str` bytes.
7. **Character categories come from `unicode-properties` 1.4.1** (Unicode
   12.0; unassigned code points are `Cc`, not `Cn`), via a table generated
   from the npm package. Rust's `char` methods give different answers.
8. **Case mapping:** Rust `to_uppercase`/`to_lowercase` match Node on every
   code point. Whitespace does not: JS `\s`/`trim()` and Rust differ at
   U+0085 and U+FEFF; use `js_compat`.
9. **Regexes:** the `regex` crate suffices (no lookaround/backreferences
   are used), but translate JS semantics explicitly: JS `\d` is ASCII-only,
   `.` excludes line terminators, `/i` without `/u` is ASCII-ish.

### Numbers and JSON

10. **Number formatting** must match JS `Number.prototype.toString`
    (`1e+21`, `1e-7`, `-0` → `"0"`). Use `js_compat::number` (ryu digits + JS
    layout), never `format!("{}")`.
11. **Two JSON parsers.** The CLI reads JSON with stream-json (literal-text
    number classification: `1.0` is a double, duplicate keys are kept,
    source key order, its own error text). The JS API uses `JSON.parse`
    (`1.0` is an integer, last duplicate wins, integer-like keys first, V8
    error text). Port both; do not use `serde_json` for inputs.
12. **`Math.pow`/`**`:** V8 uses the platform `pow` with special cases
    `y == 2 → x*x` and `y == 0.5 → sqrt(x)`. Natively use `f64::powf` plus
    those cases (verified identical on 300k samples); the `libm` crate is
    not (7–9% mismatches). WASM needs a correctly rounded `pow` port.
13. **`JSON.stringify`** escaping and number output differ from
    `serde_json`; use `js_compat::json`.

### Libraries and errors

14. **Hand-port, don't substitute:** `pluralize` 8.0.0, `urijs` 1.19.11
    (not the `url` crate), `wordwrap`, `command-line-args`/`-usage`,
    `stream-json`. No Rust crate matches them exactly.
15. **Errors are output.** quicktype's `messageError` texts (including
    `String.replace` `$`-pattern quirks), and the Node/V8 messages that leak
    through (ENOENT text, `JSON.parse` errors, `fetch failed`), must match.
    Return `Result` everywhere; never panic on user input (release builds
    abort on panic).
16. **No hidden nondeterminism:** no time or randomness in output paths.
    quicktype's own seeded random-name generator (`support/Chance.ts`) is
    deterministic and must be ported exactly, including when it is consumed.

## Dependency choices

Recorded here when a crate replaces a JavaScript library, with how its
semantics were verified.

| JS library | Rust replacement | Verified how |
|---|---|---|
| `collection-utils` (sets/maps) | `indexmap` | insertion-ordered, as is collection-utils (research 06) |
