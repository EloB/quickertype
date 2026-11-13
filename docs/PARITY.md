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
- **Renderers in isolation:** `xtask/core-rendering/record-render-cases.mjs`
  runs the reference CLI on every golden case of a language, dumps the type
  graph that reaches `gatherNames` and checks the intercepted
  `renderGraphAndSerialize` result against the golden files;
  `tests/render_cases.rs` rebuilds the graph (same type indexes) and runs the
  Rust `gather_names` and renderer on it, comparing files and issue
  annotations. `run-render-scenarios.mjs` / `tests/render_scenarios.rs` do
  the same for hand-written scenarios, rendered with real languages or a
  configurable probe renderer that exercises the framework directly. See
  `docs/RENDERERS.md`.
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
   Rust `str` ordering differs above U+FFFF. Compare strings with
   `quicktype_js_compat::sort::compare_utf16`. Comparators that are
   inconsistent (e.g. `quicktypePropertyOrder` mixing numbers and strings)
   depend on V8's TimSort, so sort with `quicktype_js_compat::sort::sort_by`
   (a port of it), never `slice::sort_by` (which may panic or differ).

### Strings and Unicode

6. **Strings are UTF-16 in JS.** `length`, indexing, `slice`, `s[0]`,
   table-column widths, word wrapping and interning limits all count UTF-16
   code units. Use `quicktype_js_compat::utf16`; never index `str` bytes.
7. **Character categories come from `unicode-properties` 1.4.1** (Unicode
   12.0; unassigned code points are `Cc`, not `Cn`), via the table that
   `xtask/js-compat/gen-unicode.mjs` generates from the npm package
   (`quicktype_js_compat::unicode`). Rust's `char` methods give different
   answers.
8. **Case mapping:** Rust `to_uppercase`/`to_lowercase` match Node on every
   code point. Whitespace does not: JS `\s`/`trim()` and Rust differ at
   U+0085 and U+FEFF; use `quicktype_js_compat::whitespace`.
9. **Regexes:** the `regex` crate suffices (no lookaround/backreferences
   are used), but translate JS semantics explicitly: JS `\d` is ASCII-only,
   `.` excludes line terminators, `/i` without `/u` is ASCII-ish.

### Numbers and JSON

10. **Number formatting** must match JS `Number.prototype.toString`
    (`1e+21`, `1e-7`, `-0` → `"0"`). Use `quicktype_js_compat::number::to_string`
    (ryu digits + JS layout), never `format!("{}")`.
11. **Two JSON parsers.** The CLI reads JSON with stream-json (literal-text
    number classification: `1.0` is a double, duplicate keys are kept,
    source key order, its own error text). The JS API uses `JSON.parse`
    (`1.0` is an integer, last duplicate wins, integer-like keys first, V8
    error text). Port both; do not use `serde_json` for inputs.
12. **`Math.pow`/`**`:** V8 uses the platform `pow` with special cases
    `y == 2 → x*x` and `y == 0.5 → sqrt(x)`. Natively use `f64::powf` plus
    those cases (verified identical on 300k samples), as
    `quicktype_js_compat::number::pow` does; the `libm` crate is not (7–9%
    mismatches). WASM needs a correctly rounded `pow` port.
13. **`JSON.stringify`** escaping and number output differ from
    `serde_json`; use `quicktype_js_compat::json`.

### Libraries and errors

14. **Hand-port, don't substitute:** `pluralize` 8.0.0, `urijs` 1.19.11
    (not the `url` crate), `wordwrap`, `command-line-args`/`-usage`,
    `stream-json`. No Rust crate matches them exactly. (`pluralize` and
    `wordwrap` live in `quicktype_js_compat`.)
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
| V8 `Number.prototype.toString` | `ryu` 1.x digits + ECMAScript layout (`quicktype_js_compat::number`) | 0 mismatches over 2,000,000 random and decimal-like doubles against Node 24, plus 10k committed vectors. Rust's own `{:e}` digits differ on 1,141 of them (round-half-even ties). |
| `pluralize` 8.0.0 | hand port (`quicktype_js_compat::pluralize`) on `regex` 1.x | the rules are translated with JS non-`u` `/i` semantics (ASCII-only folding, ASCII `\b`/`\w`, UTF-16 unit matching); `singular`/`plural`/`isSingular`/`isPlural` agree with npm on 4,501 words (corpus names, rule-shaped random words, `ſ`, Kelvin sign, astral) |
| `unicode-properties` 1.4.1 | table generated by `xtask/js-compat/gen-unicode.mjs` (`quicktype_js_compat::unicode`) | `getCategory` of every code point 0..=U+10FFFF and the predicates compared to the npm package |
| `wordwrap` 1.0.0 | hand port (`quicktype_js_compat::wordwrap`) | 407 texts at several widths compared to npm |
| V8 `Array.prototype.sort` | port of `array-sort.tq` (`quicktype_js_compat::sort`) | 210 seeded comparator runs (consistent, fully inconsistent, noisy, run-shaped, NaN) up to 2,000 elements, 41 mixed number/string `<` tables and 60 default string sorts compared to Node 24 |
| `JSON.stringify` | `quicktype_js_compat::json` | 400 strings and 250 nested values with numeric and string `space` compared to Node 24 (including V8's line breaks for `0 < space < 1`) |
| V8 `JSON.parse` | port of `json-parser.cc` (`quicktype_js_compat::json::parse`) | 5,017 inputs compared to Node 24 (`xtask/core-json-input/gen-json-parse-vectors.mjs`): curated edge cases, seeded random JSON and seeded mutations of it and of `tests/inputs/json`; parsed values in own-property order and every `SyntaxError` message, position, `(line column)` and excerpt |

## Known gaps

Known divergences from the reference that no golden case exercises. Some are
deliberate (behavior of the JavaScript runtime rather than of quicktype);
the others name the fix they need.

- **`pow` on WASM (Phase 6 blocker).** `quicktype_js_compat::number::pow`
  matches V8 natively because both call the platform `pow`. On `wasm32`
  there is none: `f64::powf` is compiler-builtins' port of `libm`, which
  disagrees with Node in the last bit on about 7% of inputs. Through
  `markov_chain::evaluate` this can flip `InferMaps`' class-versus-map
  decision for names near the threshold. Fix: a correctly rounded `pow` for
  `wasm32` (marked `TODO(wasm)` in `number.rs`).
- **Lone surrogates.** JavaScript strings can hold unpaired UTF-16
  surrogates (JSON `"\ud800"`, or a slice that cuts a surrogate pair); Rust
  `String`s cannot. Wherever the TypeScript produces one, the port drops it:
  `utf16::units_to_string`, `utf16::slice`/`substring`,
  `json::gap_from_str`, and through them `strings::utf16_concat_map`,
  `utf16_legalize_characters`, `combine_words` (via legalizers),
  `pluralize` and `combineNames` (`attributes/type_names.rs`, whose common
  prefix/suffix of a type's names can cut an astral character in half).
  In input JSON, both readers decode a `\u` escape that leaves a surrogate
  unpaired to U+FFFD (so two such keys or enum cases can collide), and
  `JSON.parse` errors that quote half of a surrogate pair show U+FFFD, as
  Node prints them. No golden input contains one. Fix: a WTF-16 JavaScript-string type at the
  API boundary (input strings, names, emitted string literals), with `&str`
  only where text is known to be well-formed.
- **Very deeply nested JSON.** Both JSON readers are iterative, but
  inference recurses once per nesting level, as in TypeScript. There the
  JavaScript stack runs out somewhere between 500 and 1,000 levels
  (`Maximum call stack size exceeded`, depending on Node's stack size); the
  port goes much deeper but eventually overflows the native stack and
  aborts. Fix: an explicit depth limit reporting the `RangeError`, or
  iterative inference.
- **Stack exhaustion in Postman collections.** The TypeScript recurses
  through nested folders and through `String(array)` when it formats a
  request's `method` and `url.raw`; the port is iterative and reports
  Node's `RangeError` (`Maximum call stack size exceeded`) at the depths
  measured on the reference CLI (Node 24.16): more than 3,731 nested
  folders, or arrays nested more than 2,830 deep. Inside nested folders
  Node's array limit is lower (less stack is left); that is not modelled.
- **Postman collections that are not JSON** (temporary). `parseJSON` falls
  back to YAML, which the JSON Schema input ports; until then
  `sources_from_postman_collection` reports `JSON.parse`'s error for them
  (`TODO(parse-json)` in `input/postman_collection.rs`).
- **TypeScript input.** `quicktype-typescript-input` runs the TypeScript 7
  native compiler where the reference runs TypeScript 5.9 and
  typescript-json-schema, and emulates TS 5.9's union member order by
  replaying its type creation order. The differential corpus matches in
  full, but the replay is not the checker; `docs/research/07` §10 lists the
  cases that can still differ. Without a TypeScript 7.0.2 compiler the
  input fails with an install hint, which the reference cannot do.
- **Write errors other than EPIPE.** Node turns a failed write to stdout or
  stderr (e.g. `EIO`, `ENOSPC`) into an uncaught exception: a runtime stack
  trace on stderr and exit code 1. The Rust CLI prints
  `Error: cannot write to <stream>: <error>.` and exits 1. (EPIPE is exact:
  exit 0, no output.)
- **Rendering one graph twice.** A TypeScript `ConvenienceRenderer` stores
  the names it assigns in the graph's attribute store, so a second
  `renderGraphAndSerialize` on the same `TypeGraph` reuses stale names and
  fails with `Internal error: No name for Named` (or `Defined value
  expected`). Rust renderers keep their names to themselves, so a second
  render succeeds. Only reachable through the library API; the CLI and
  `quicktype()` build a new graph per run.
- **chalk-template features quicktype never uses.** Style arguments and hex
  colours (`{rgb(1,2,3) …}`, `{#ff0000 …}`) and the colour-model styles
  exit 2 as not implemented. Style names that are other properties of the
  chalk object (`level`, `toString`, …) fail with JS `TypeError`s in the
  original; the port reports them as `Unknown Chalk style`.
