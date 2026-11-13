# Differential fuzzing

Seeded random inputs and options, run through quicktype (the reference
checkout in `tests/golden/REFERENCE`) and through the port, compared byte for
byte. It finds parity bugs the recorded corpus does not cover; each one found
is minimized and kept as a regression case in `tests/fuzz-regressions/`.

Needs a built quicktype checkout (`npm ci && npm run build`; found as
`--reference`, `$QUICKTYPE_REFERENCE`, `../quicktype` or `../../quicktype`), the
built npm package (`cd npm/quicktype-core && npm ci && npm run build`) and the
release CLI (`cargo build --release -p quickertype`).

```sh
node xtask/fuzz/fuzz.mjs --seed 1 --count 5000 -j 3       # seeds 1..5000
node xtask/fuzz/fuzz.mjs --seed 100000 --minutes 120 -j 3 # as many as fit
node xtask/fuzz/fuzz.mjs --print 1234                     # the case of seed 1234
node xtask/fuzz/fuzz.mjs --replay target/fuzz/run-1/1234-api.json
node xtask/fuzz/minimize.mjs target/fuzz/run-1/1234-api.json
node xtask/fuzz/record.mjs target/fuzz/run-1/1234-api.min.json <name> "<what it checks>"
```

Each worker (`-j`, default 4) is one busy process at a time: it runs a case
on the reference, then on the port (in-process, or the two CLIs one after the
other). An in-process run that takes more than two minutes counts as a
timeout, but nothing can stop it: it may go on in the background, sharing
the engine switch, the engine's counters and both quicktype-cores with
later runs. So the worker skips the case's remaining in-process modes,
reports it and exits, and a fresh worker takes its place (the minimizer
stops with the smallest case so far, the replay skips the in-process modes
left). A run that never yields is killed after `--hang-minutes` (10).

## Cases

A case is a pure function of its seed (`generate.mjs`): a target language,
renderer options drawn from that language's option definitions (booleans,
legal enum values and the odd illegal one, string values from a list of
awkward names), general options (`--no-maps`, `--no-enums`, `--no-uuids`,
`--no-date-times`, `--no-integer-strings`, `--no-boolean-strings`,
`--no-combine-classes`, `--no-ignore-json-refs`, `--all-properties-optional`,
`--alphabetize-properties`, `--quiet`, `--out`) and API-only options
(`indentation`, `leadingComments`, `outputFilename`), and one of:

- **JSON samples**, from random shapes instantiated several times per
  sample (and 1–5 samples per top-level, 1–3 top-levels): classes with
  optional and nullable properties, arrays, unions of kinds, recursive
  trees, maps with 0–6, about 20, about 50, about 500 and more than 500
  keys, enums whose case count sits around the `cases < sqrt(values)`
  threshold (words, numeric strings, case variants, odd strings), date,
  time, date-time, UUID, integer, boolean and URI strings and near misses,
  number literals at the integer-range edges and in every spelling (`1.0`,
  `1E+2`, `-0`, `1e400`, 30-digit integers), nulls, empty containers,
  duplicate keys, `$ref` objects, and keys and names taken from target
  language keywords (`tests/keywords.txt`), acronyms (`tests/acronyms.txt`),
  integer-like strings, `__proto__` and other `Object.prototype` names,
  the empty string, whitespace, unicode and astral characters.
- **JSON and JSON Schema together** (`mixed`): JSON top-levels and a
  schema in one run (through the CLI: a directory of `.json` and `.schema`
  files).
- **A Postman collection** (`--src-lang postman`; in-process as the CLI
  does it: `sourcesFromPostmanCollection`, the request descriptions as
  top-level descriptions, the collection's description word-wrapped into
  `leadingComments`, `fixedTopLevels` for several requests): requests in
  nested folders whose responses hold JSON samples (and some that are not
  JSON), with methods, URLs and descriptions.
- **GraphQL** (CLI runs only; the WebAssembly engine has no GraphQL input):
  an introspection result with scalars, enums, objects, interfaces and
  unions, and one or more query documents with aliases, `@include`/`@skip`,
  named and inline fragments and several operations.
- **A JSON Schema**: objects (`properties`, `required` with the odd
  unknown name, `additionalProperties` as `false`, `true` or a schema,
  `patternProperties`, `quicktypePropertyOrder`), arrays (`items`, tuples,
  `prefixItems`, `minItems`/`maxItems`), `anyOf`/`oneOf`/`allOf`, `enum`
  and `const` of every JSON type, `$ref` to `definitions`/`$defs` (also
  recursive and to `#`), formats, patterns, `minimum`/`maximum`,
  `minLength`/`maxLength`, type lists with `null`, `nullable`, boolean
  schemas, titles, descriptions (comment terminators, line breaks, unicode),
  `default` and `examples`.

## Modes

Each case runs in up to three modes (`--modes`, chosen per seed):

- **api** (always): `quicktypeMultiFile` on the reference quicktype-core and
  on our npm package with the WebAssembly engine forced
  (`QUICKTYPE_ENGINE=wasm`); JSON samples are strings (`JSON.parse`
  semantics). Results, errors and console output are compared as the npm
  differential suite does (`npm/quicktype-core/test/differential/compare.mjs`).
- **stream** (JSON, `--stream-rate`, default 35%): the same, but samples are
  read by the CLI's `CompressedJSONFromStream` (stream-json: `1.0` is a double,
  duplicate keys kept, source key order), the CLI's reading path. Our package
  gets that class compiled against itself and registered as a native input,
  so these runs still go to the WebAssembly engine.
- **cli** (`--cli-rate`, default 8%): `node <reference>/dist/index.js` and
  `target/release/quicktype` with the same arguments, each in a fresh
  directory holding the same input files (one top-level: its samples as
  files; several: a directory of `<name>.json`); exit code, stdout, stderr
  and written files are compared. This covers the native-only code: argument
  parsing, the Rust stream-json reader, file output. A case runs here only
  if every file it writes has a name that Windows, macOS and Linux can all
  hold (`file-names.mjs`: no `: * ? " < > |` or control characters, no
  device names such as `CON` or `nul.json`, NFC, no two equal but for
  case), since a recorded case is checked out on all three; `record.mjs`
  refuses a case whose output files are not named so.

- **chain** (JSON and Postman cases, `--chain-rate`, default 15%): the
  reference turns the case into a JSON Schema (target language `schema`),
  and that schema, with the case's language and options, is compared in
  the api mode: realistic schemas with quicktype's own keywords. A
  divergence is saved as that schema case.

A run that our package does not run on WebAssembly is counted ("not on
wasm"). One where the WebAssembly engine failed and the facade redid it on
TypeScript is a divergence even if the result matches, with the engine's
panic message, unless the engine overflowed V8's stack (a deep or endless
recursion, which WebAssembly cannot grow the stack for; a documented
fallback): that run counts as `rerun-stack` among the "not on wasm" ones,
and the CLI mode checks the native port on such inputs.

## Output

`target/fuzz/run-<seed>/` (or `--out`) gets `<seed>-<mode>.json` for every
divergence (the case, the first difference, both outcomes) and
`summary.json` (seed range, counts per mode and language, divergences).
`minimize.mjs` shrinks a divergence while it keeps diverging the same way
(same mode, same kind of reference outcome): options, top-levels and
samples first, then each JSON sample or schema as a lossless syntax tree
(`json-text.mjs`). `record.mjs` writes the shrunk case to
`tests/fuzz-regressions/<name>/` with the reference CLI's output;
`crates/quicktype-cli/tests/fuzz_regressions.rs` replays it with our binary
and the npm differential suite (`fuzz` category) through the API.
