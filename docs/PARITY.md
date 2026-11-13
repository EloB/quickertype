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
- **JS API:** `npm/quicktype-core/test/differential` runs the same API
  calls against the reference `quicktype-core` (the built
  `packages/quicktype-core` of a quicktype checkout) and our package on
  WebAssembly, and compares results (every file, line and annotation),
  errors (class, `messageName`, message, properties) and console output:
  the golden corpus replayed through the API (samples as strings, so
  `JSON.parse` semantics), every input × every language with default
  options, ports of quicktype's API-level unit tests, JSON Schema store
  paths (lazy fetch order, failures, concurrency, re-entrancy), errors and
  options. Without a checkout (CI) the reference is the package's own,
  vendored TypeScript engine. Runs the engine declines as unsupported
  (`QuickTypeError::unsupported`, e.g. a renderer not ported yet) run on
  the TypeScript engine and are reported separately from those identical
  on WebAssembly.

Known gap: the `schema-golang-leading-comments` fixture drives the library API
rather than the CLI, so it has no CLI recording; the JS API differential
suite covers `leadingComments` for every ported language (Go itself is not
ported yet).

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
    mismatches). On `wasm32` (feature `js-host-math`, which the WebAssembly
    bindings enable) it calls the JavaScript host's own `Math.pow`.
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
    abort on panic). Where the TypeScript throws before its own
    `messageError` is reached, the thrown error wins: `getTargetLanguage`
    of an unknown name is `languageNamed`'s plain `Error: Unknown language
    name: x`, not `DriverUnknownOutputLanguage` as research 05 first
    specified.
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
| `urijs` 1.19.11 (with its bundled punycode.js `toASCII` and `IPv6.best`), `encodeURIComponent`/`decodeURIComponent` | hand port of the used subset (`quicktype_js_compat::uri`) | `xtask/core-json-schema-input/gen-uri-vectors.mjs`: 1,411 URIs (curated edge cases, every `$ref`/`$id` and a sample of the URL strings in `tests/inputs`, seeded fuzz) through parse, every accessor, `clone`, `normalize`, `URI.decode`, `absoluteTo` against 8 bases and the setters (33,703 checks), 381 `equals` pairs and 321 strings through the component coders, all identical to Node 24 |
| `yaml` 2.9.0 `YAML.parse` (default options) | `saphyr-parser` 0.3 (YAML 1.2 events) plus a port of `yaml`'s composer and `toJS` (`quicktype_js_compat::yaml`): core-schema tag resolution in `yaml`'s order, unique keys by `===`, key stringification, JS object key order, alias expansion with `maxAliasCount` 100, multiple documents rejected | `xtask/core-json-schema-input/gen-yaml-vectors.mjs`: 764 committed cases (218 curated, every `tests/inputs` file that `JSON.parse` rejects, seeded mutations of JSON inputs) identical to Node, including key order, `-0`, `NaN` and `Infinity`; a 6,182-case run differs only on 12 malformed inputs (see Known gaps) |
| Node's `fetch` (undici, Node 24), as `NodeIO` uses it | `input/io/fetch.rs` on `ureq` 2.12 (rustls, one shared agent), `url` 2.5 (WHATWG URL parsing, as `new Request` does), `flate2` 1.1 (rust backend) and `brotli-decompressor` 5, behind the `http` feature of `quicktype-core` | `tests/fetch_http.rs` against a local server, every expectation checked with Node 24: redirects followed by hand (20 at most, cross-origin hops drop `authorization`/`proxy-authorization`/`cookie`/`host`), undici's default headers and case-insensitive header combining (`3, 2`), `gzip`/`x-gzip`/`deflate` (zlib or raw)/`br` decoding in reverse coding order (unknown codings: none; corrupt or truncated data: what decoded), `null` bodies for 101/204/205/304, the `TypeError` texts for bad URLs, credentials, header names/values and `ByteString`s, the fetch bad-port list, and undici's timeouts (10 s connect, 300 s headers and body); the golden `schema/ref-remote.schema` case |
| Node's stack depth (`RangeError: Maximum call stack size exceeded`) | a model of the JavaScript stack in `JSONSchemaInput` (per-keyword costs, reset after every `await`) and a depth limit for `addIDs`, with `stacker` 0.1 growing the native stack on demand | `xtask/core-json-schema-input/measure-stack-depth.mjs` measures Node 24 per recursion path in fresh processes; `tests/deep_schemas.rs` pins the same last-good and first-failing depths (items 322, tuples 198, properties 161, `allOf` 200, `oneOf`/`anyOf` 170, properties plus items 107, `addIDs` 4,150) and runs on 2 MB test-thread stacks |
| `Number(string)` | `quicktype_js_compat::number::string_to_number` | 39 edge cases (whitespace, signs, `0x`/`0o`/`0b`, `Infinity`, exponents, >64-bit hex) compared to Node 24 |
| V8 `Math.pow` on `wasm32` | the host's `Math.pow`, imported with `wasm-bindgen` (feature `js-host-math` of `quicktype-js-compat`) | it *is* V8's `Math.pow` in Node (and the very `pow` the TypeScript quicktype uses in any other JavaScript host). `npm/quicktype-core/test/engine.test.mjs` runs the 2,969 `pow` vectors recorded from Node 24 (`xtask/js-compat/gen-vectors.mjs`) and 200,000 `MarkovChain`/`InferMaps`-shaped inputs through the WebAssembly engine's `**`: all bit-identical. (`libm`'s port, `f64::powf` on `wasm32`, differs on ~7%.) |
| V8 `JSON.parse` | port of `json-parser.cc` (`quicktype_js_compat::json::parse`) | 5,017 inputs compared to Node 24 (`xtask/core-json-input/gen-json-parse-vectors.mjs`): curated edge cases, seeded random JSON and seeded mutations of it and of `tests/inputs/json`; parsed values in own-property order and every `SyntaxError` message, position, `(line column)` and excerpt |

## Known gaps

Known divergences from the reference that no golden case exercises. Some are
deliberate (behavior of the JavaScript runtime rather than of quicktype);
the others name the fix they need.

- **`pow` on `wasm32` without a JavaScript host.** With the
  `js-host-math` feature (on in the WebAssembly bindings), `**` is the
  host's `Math.pow`, exact by construction. A `wasm32` build of the core
  without it (e.g. for a non-JavaScript WebAssembly runtime) falls back to
  `f64::powf`, compiler-builtins' port of `libm`, which disagrees with Node
  in the last bit on about 7% of inputs; through `markov_chain::evaluate`
  that can flip `InferMaps`' class-versus-map decision near its threshold.
- **The JavaScript facade (`npm/quicktype-core`).** Runs the engine does
  not model use the TypeScript engine (see its README), so only these
  differ:
  - a custom `JSONSchemaStore` can return documents holding `undefined`
    (or functions, symbols, bigints), which `JSON.parse` and YAML never
    produce; the engine reads such a property as absent and such an array
    item as `null`, where TypeScript fails (a `TypeError`, or `Value of
    type undefined is not valid JSON Schema`);
  - when a run fails inside `JSONSchemaInput.addTypes`, the top-levels it
    had found are not added to the input object (TypeScript adds them one
    by one, so a later run on the same `InputData` starts from them);
  - a run started from inside another run's callback (a store, `onTiming`)
    runs to its first schema fetch synchronously, where TypeScript runs
    only up to its first `await`; only the interleaving of the two runs'
    `--debug` output and `onTiming` calls can show it;
  - an `onTiming` (or a replaced `console.log`) that throws stops the
    TypeScript engine at once; the engine finishes the run silently
    (no more output or callbacks) and then rethrows the exception;
  - the engine prints the TypeScript Zod renderer's `console.warn` with
    `console.error` (the same stream in Node);
  - `console.log` replaced by a function that runs quicktype synchronously
    would re-enter the engine's console sink (a `RefCell`) and trap; the
    instance is then discarded and the run fails with an `InternalError`;
  - GraphQL input (`quicktype-graphql-input`) is not ported yet, so its
    runs use the TypeScript engine;
  - the engine declines languages whose renderer is not ported before a
    run starts (`has_renderer`); should a run hit another unsupported
    feature midway, it is redone on the TypeScript engine, and what the
    first attempt did (schema fetches through the store, `--debug`
    output, `onTiming` calls) happens twice. No such feature exists
    today;
  - Rust polls a run's future from its root, so a long chain of `$ref`ed
    documents nests WebAssembly frames on V8's own stack; at a few hundred
    documents (300 work, 500 do not, with Node's default stack) that
    overflows with `RangeError: Maximum call stack size exceeded`, as the
    TypeScript engine does at about the same length, though not
    necessarily the same one. The instance is then discarded, and other
    runs in flight on it fail with an `InternalError`. (The core's model
    of the JavaScript stack lets `$ref` chains go 10,000 deep, so the
    native CLI does not fail there; see "Stack depth".)
  - a JSON Schema nested deeper than Node's stack allows (see "Stack
    depth") makes the TypeScript quicktype-core overflow inside a promise
    callback, which takes the whole process down (`Exception in
    PromiseRejectCallback`); the engine rejects the run with the same
    `RangeError: Maximum call stack size exceeded`.
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
  port goes much deeper (the CLI generates on a thread with a 256 MB
  stack) but eventually overflows the native stack and aborts. Fix: an
  explicit depth limit reporting the `RangeError`, or iterative inference.
- **Endless recursion over the type graph.** On a graph that cycles
  through a nullable union (`T = T[] | null`), TypeScript's
  type-to-source functions (and C#'s `needTransformerForType`) recurse until
  V8 throws `RangeError: Maximum call stack size exceeded`. The port's
  recursive functions run under `support::recursion::guard`, which reports
  the same `RangeError` after 1,000 nested guarded calls instead of Node's
  stack size: Node 24 gets 971 levels deep in Pike's `sourceFor` and 8,903
  in `needTransformerForType`. Endless recursions fail identically. A
  finite graph nested deeper than either limit could differ, but in
  TypeScript graph rewriting already overflows at about 335 nested arrays,
  so no such graph reaches a TypeScript renderer.
- **Stack exhaustion in Postman collections.** The TypeScript recurses
  through nested folders and through `String(array)` when it formats a
  request's `method` and `url.raw`; the port is iterative and reports
  Node's `RangeError` (`Maximum call stack size exceeded`) at the depths
  measured on the reference CLI (Node 24.16): more than 3,731 nested
  folders, or arrays nested more than 2,830 deep. Inside nested folders
  Node's array limit is lower (less stack is left); that is not modelled.
- **TypeScript input.** `quicktype-typescript-input` runs the TypeScript 7
  native compiler where the reference runs TypeScript 5.9 and
  typescript-json-schema, and emulates TS 5.9's union member order by
  replaying its type creation order. The differential corpus matches in
  full, but the replay is not the checker; `docs/research/07` §10 lists the
  cases that can still differ. Without a TypeScript 7.0.2 compiler the
  input fails with an install hint, which the reference cannot do.
- **Sources that fail while being read.** The CLI opens its sources
  (`lstat`, `fetch`) when it collects them and reads them when the input
  parses them. A read that fails after a successful open (`EACCES`,
  `EISDIR` for a symbolic link to a directory) makes Node emit an `error`
  event on the file stream that nothing handles: a runtime stack trace on
  stderr and exit code 1. The Rust CLI prints `Error: <Node's message>.`
  and exits 1.
- **Write errors other than EPIPE.** Node turns a failed write to stdout or
  stderr (e.g. `EIO`, `ENOSPC`) into an uncaught exception: a runtime stack
  trace on stderr and exit code 1. The Rust CLI prints
  `Error: cannot write to <stream>: <error>.` and exits 1. (EPIPE is exact:
  exit 0, no output.)
- **YAML.** `quicktype_js_compat::yaml` reports `saphyr-parser`'s error
  messages, not `yaml`'s (they only surface through `parseJSON` for
  Postman, GraphQL-schema and URL-grammar files; JSON Schema fetch errors
  are swallowed), does not print `yaml`'s warnings (Node writes them to
  stderr with a process id), ignores `%YAML 1.1` (which switches `yaml` to
  its YAML 1.1 schema), treats the YAML 1.1 tags `!!binary`,
  `!!timestamp`, `!!set`, `!!omap` and `!!pairs` as unknown tags, rejects
  recursive aliases and nesting deeper than 1,000, and stringifies
  collection-valued keys approximately. On malformed input the lexers
  disagree in a few corner cases: a tag or anchor directly followed by a
  quoted scalar or collection (`!"x"`, `![…]`), `?`/`:` directly before a
  flow collection inside a flow sequence, and `{?}`.
- **urijs `equals` errors.** urijs's `equals` can throw only for
  addresses whose `Ref` could not have been constructed; the port counts
  that as unequal. (JavaScript exceptions themselves, such as urijs's
  `URIError: URI malformed`, are reported faithfully as
  `messages::JsException`s.)
- **Node I/O corner cases.** `StdIo` reads a directory as empty text (as
  Node does on macOS, where the corpus was recorded; Linux Node reports
  `EISDIR`), reports unreadable files (`EACCES`) as a `MiscReadError`
  where Node crashes with an unhandled stream error, and resolves symbolic
  links with POSIX path rules on every platform.
- **Stack depth.** Where Node's stack overflows, the JSON Schema input
  fails with the same `RangeError: Maximum call stack size exceeded` (the
  CLI prints `Error: Maximum call stack size exceeded.`). The thresholds are
  exact for the measured recursion paths (see the dependency table) and
  approximate where paths mix in other ways (the costs add up per level,
  as measured for properties plus items). Node's own threshold can differ by
  one between runs (V8 compiles the recursion concurrently): the `addIDs`
  walk over a 4,150-level document succeeds in most Node runs and in the
  port, fails in some Node runs. TypeScript recurses into `$ref` targets,
  `additionalProperties` and later array or property siblings after an
  `await`, on a fresh stack, so such chains never overflow there; the port
  stops them at 10,000 nested levels. YAML values nested deeper
  than 1,000 levels, also through aliases, cannot be read, where `yaml`
  itself overflows somewhere between about 750 and 1,200 levels. The
  generation stages (rewrites, rendering) will need the same care once
  ported; the native stack grows as needed, so the CLI needs no
  big-stack thread.
- **YAML flow nesting.** `saphyr-parser` counts flow nesting in a `u8`:
  more than 255 nested flow collections fail with `YAMLParseError:
  recursion limit exceeded at line 1, column 256` (for `[[[…`); `yaml`
  accepts them up to its stack limit (above).
- **HTTP.** `zstd` bodies are not decoded (Node 24 can, but fetch never
  asks for them); header values with characters U+0080..U+00FF are sent as
  UTF-8 rather than Latin-1; corrupt `gzip`/`deflate`/`br` data may decode
  to a different prefix than Node's zlib.
- **Accessor entries.** `qt-accessors`/`qt-enum-values` entries whose values
  are not strings are converted with `String(value)` (TypeScript passes
  the raw value on to naming).
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
- **Unicode version of `\p{...}` regexes.** The Scala 3 renderer's
  `propertyNameNeedsMapping` tests a JSON name with
  `/^[\p{L}_$][\p{L}\p{M}\p{N}_$]*$/u`, which V8 evaluates with Node's
  current Unicode data. The port uses the `regex` crate, whose tables follow
  its own (current) Unicode version; the two can still disagree for
  characters assigned in a Unicode version only one of them has. Naming
  (`unicode-properties`, Unicode 12.0) is unaffected.
