# quickertype-core

[quicktype](https://github.com/glideapps/quicktype)'s
[`quicktype-core`](https://www.npmjs.com/package/quicktype-core) API with its
engine compiled to WebAssembly from the Rust port
[quickertype](https://github.com/EloB/quickertype). The API, the `.d.ts`
files and the generated code are quicktype's own.

## Install

```sh
npm install quickertype-core
```

Node.js 20 or later, or a browser.

## Use

It is a drop-in replacement for `quicktype-core`: change the import.

```ts
import { quicktype, InputData, jsonInputForTargetLanguage } from "quickertype-core";

const input = jsonInputForTargetLanguage("typescript");
await input.addSource({ name: "Person", samples: ['{"name": "Ann", "age": 7}'] });
const inputData = new InputData();
inputData.addInput(input);
const { lines } = await quicktype({ inputData, lang: "typescript" });
```

`require("quickertype-core")` works too. The package matches `quicktype-core`
24.0.0 at quicktype commit
[`c39af7d3`](https://github.com/glideapps/quicktype/tree/c39af7d303b025280e2668a1b2d29913093593c9)
(`src/native/UPSTREAM.json`); its own version (0.1.0) is quickertype's, not
quicktype's. In a browser the engine is a separate `.wasm` file that your
bundler has to serve, or that you hand over yourself: see
[Loading](#loading). Try it in the
[playground](https://elob.github.io/quickertype/).

The rest of this file is about how the package works and how to build it.

## How it works

`src/` is quicktype's `packages/quicktype-core/src` at the commit in
`src/native/UPSTREAM.json`, byte for byte, except two files: `Run.ts`,
which after `preRun()` hands the run to the engine (`src/native/bridge.ts`)
when the engine can do it exactly, and `input/CompressedJSON.ts`, whose
`CompressedJSONFromString.parseSync` lets the engine read a JSON sample
before parsing it itself (see [JSON samples](#json-samples)). Everything
else before the run stays in TypeScript, so inputs are collected, schema
text parsed (JSON, then YAML) and files and URLs read exactly as before.
Each run is **one call** into `crates/quicktype-wasm`, carrying the JSON
inputs (the engine's own copy of their samples, or their `CompressedJSON`
tables) and normalized JSON Schema sources; the engine fetches `$ref`ed
schemas through the input's own `JSONSchemaStore` while it builds types,
at the points where TypeScript awaits them. Errors come back as
quicktype's message kinds and are rebuilt with the TypeScript
`messageError`, so `QuickTypeError`'s `messageName`, `message` and
`properties` are the same; JavaScript exceptions are rethrown as the same
class with the same message; whatever a store or `onTiming` throws is
rethrown as is.

Runs the engine does not model use the original TypeScript engine, with the
same results by construction:

- a custom `TargetLanguage` (any subclass or modified instance), or a
  `CompressedJSON`, `Input` or date/time recognizer that is not quicktype's;
- `JSONSchemaInput`s with extra attribute producers;
- option values outside what quicktype's options read (a number for a string
  option, `"toString"` for an enum option, a `Name` in `leadingComments`, …);
- GraphQL input (`quicktype-graphql-input`: the Rust port of it is not
  part of the engine yet);
- a language whose renderer the engine does not have (every built-in
  language has one): the engine says so (`supportsLanguage`, and an
  `{ unsupported }` outcome should a run hit a missing feature midway),
  never with an error;
- strings that are not well-formed UTF-16 (lone surrogates, which
  `JSON.parse` accepts), anywhere in the run, and store documents with
  them, circular ones or ones too large to flatten.

If the engine fails (traps, or overflows the stack), every run in flight on
that instance is redone on the TypeScript engine and the instance is
replaced. Before a run is redone, its JSON Schema inputs are put back as
they were. An engine that has as many runs in flight, or holds as many
inputs, as its tables take (2^21 each) has not failed: that run, or that
input's samples, go to the TypeScript engine, and the instance stays.

`QUICKTYPE_ENGINE=ts` (or `globalThis[Symbol.for("quicktype-core.engine")] =
"ts"`) runs everything on the TypeScript engine; `wasm` makes a failure to
load the engine an error instead of a fallback. `engineStats` in
`dist/native/bridge.js` counts the runs on each engine (`wasm`, `ts`) and
the runs the engine declined (`unsupported`, by feature in
`unsupportedBy`) or that were redone after it failed (`rerun`), the JSON
samples the engine read (`samplesRead`), the `CompressedJSON`s whose
TypeScript tables were filled after all (`tablesFilled`), and the
compressed forms the engine exported and let go of to stay within its
memory limit (`evicted`; see [JSON samples](#json-samples)).

### JSON samples

`JSONInput.addSource` and `addSourceSync` parse every sample on the spot
(`CompressedJSONFromString.parseSync`: `JSON.parse`, then `process` the
value into the `CompressedJSON`'s tables), and a run then reads those
tables. Here the engine reads the sample instead, when it can, and keeps
the result for the runs: parsing in TypeScript and converting the tables
for every run are both skipped.

**Design.** `parseSync` first asks `src/native/samples.ts`. For a
`CompressedJSONFromString` that is exactly quicktype's (its prototype and
own fields, a built-in date/time recognizer, a valid integer range: all
checked at its first sample; for the later ones, only that its prototype,
the number of its own properties and its configuration are unchanged) and
a string sample that is well-formed UTF-16, while the engine is compiled
(see below) and not forced off, that is **one engine call per sample**:
`jsonRead(id, text)` reads the text with the port's `JSON.parse`-semantics
reader (`CompressedJson::read_string_sample` in quicktype-core: V8's
grammar, own-property order, the last of duplicate keys) into a compressed
form held in WebAssembly memory, one per `CompressedJSON` (`id`, made by
`jsonCreate` with the first sample), and returns the sample's root
`Value`. `parseSync` returns it, and `JSONInput` stores it in `_topLevels`
as it would its own. The `CompressedJSON`'s four table fields (`_strings`,
`_stringIndexes`, `_objects`, `_arrays`) stay empty and become accessors:
the first read or write of any of them fills all four with the engine's
tables (`materialize`: `jsonExport`, one conversion, no parsing), which
are the ones TypeScript builds from the same samples, and from then on the
`CompressedJSON` is an ordinary one whose samples TypeScript reads. A run
on the engine sends a lease on the compressed form instead of the tables
(`kind: "jsonShared"`); a run on the TypeScript engine reads the tables,
which fills them.

**When the engine reads samples.** Only once it is compiled: in browsers
the module compiles in the background from the start, and samples added
before that are read by TypeScript; in Node, where compiling is
synchronous, the first run that uses the engine compiles it, and so does
a sample of at least 1 Mi code units (reading a sample that large on the
engine saves more than compiling costs, some 20 ms of CPU). A smaller
sample never compiles it: if the run goes to the TypeScript engine (a
custom language, say), compiling would be wasted.

The engine leaves a sample to TypeScript (after filling the tables, so
that TypeScript continues from the state it would have) when it cannot
return what TypeScript would: a root value that is a string (its `Value`
is an index into TypeScript's string table, which the engine's does not
mirror), nesting deeper than 256 levels (TypeScript's recursive `process`
runs out of stack at a few thousand levels, earlier on a smaller or
fuller stack; such a sample keeps whatever TypeScript does with it), a
`\u` escape that leaves a surrogate unpaired (a Rust string cannot hold
it), a configuration (`dateTimeRecognizer`, `handleRefs`,
`supportedIntegerRange`) that changed since the first sample, a compressed
form that a run holds, an engine instance that failed, and an engine that
holds as many inputs as it takes.
A sample that is not JSON is not read at all: the engine reports that it
is not JSON, without changing anything, and `parseSync` goes on to
`JSON.parse`, which throws.

**Lifetime.** The compressed form lives as long as its `CompressedJSON`
does, so that any number of runs can use it: a `FinalizationRegistry` on
the `CompressedJSON` frees it once the input is collected (a run that
never happens costs nothing beyond that), and filling the tables frees it
at once. A run takes its own reference (an `Rc`, the *lease*,
`jsonAcquire`) when it is encoded, synchronously, before it waits for the
engine, and keeps it until it ends: it keeps the samples it was encoded
with even if the `CompressedJSON` is collected or its tables filled
before it starts (a run on the TypeScript engine in between, say), or
evicted (see below). A run that does not start on that instance lets go
of its leases. Ids of runs, compressed forms and leases are never reused:
each carries its slot's generation, so an id that outlived its value
finds nothing, never another input's samples
(`crates/quicktype-wasm/src/slots.rs`). Runs at once on
the same input share the compressed form. A sample added while a run
holds it is left to TypeScript (the engine never changes a compressed
form a run is reading). The texts of the samples are not kept, except
while an input's add up to at most 4 Mi code units: if an instance fails,
those are read again by TypeScript the next time anything needs the
tables, and a larger input's tables are taken from the failed instance's
memory, which a panic, running out of memory or a stack overflow leaves
readable (should even that fail, every use of the tables throws). No read
holds the engine's table of inputs while it reads, so an instance that
runs out of memory in the middle of a sample still has every other
input's tables; the input it was reading has only its kept samples. A run
whose samples were read by another instance than the one it would run on
goes to the TypeScript engine. Hosts without `FinalizationRegistry` read
every sample with TypeScript.

**Memory.** The garbage collector does not see the engine's memory, and
WebAssembly memory never shrinks, so a long-running process cannot count
on its inputs being collected before the engine runs out of its 4 GiB. The
compressed forms in an instance are therefore kept within **256 MiB**
together, as the engine counts them (the capacities of their tables,
`jsonHeld`). After a sample is read past that limit, the forms least
recently used (read into, or leased by a run) are evicted, until the rest
fit; the one just read stays, however large. An evicted form's tables are
exported to JavaScript, where the garbage collector sees them, and the
form is freed in the engine: the input's `CompressedJSON` gets those
tables when anything first uses it, and from then on it is an ordinary
`CompressedJSON`, whose further samples TypeScript reads and whose runs
send its tables. Whether that `CompressedJSON` is still in use cannot be
told (a `WeakRef` would keep it alive until the current job ends, which in
a loop of `await`s is the whole loop), so the tables of one that is gone
but not finalized yet are exported too, and collected with it. A run that
holds an evicted form keeps it until it ends. The limit is the form of
about 190 MB of JSON (a 104 MB sample takes 138 MiB), more than nearly any
program has in its inputs at once, so that eviction is a backstop for
inputs the garbage collector has not got to, not something runs normally
pay for (an evicted input's runs send its tables, which costs what reading
its samples on the engine saved). It leaves most of the 4 GiB to reading
samples and to runs, which need more than the forms they make or use while
they last (reading that sample peaks at 461 MiB with its form; a run on it
needs 114 MiB besides); since the memory never shrinks, the engine of a
long-running process stays at about the limit plus the largest of those.
(With every input kept and a 16 MiB limit, 200 inputs of a 1 MB sample
leave the engine at 54.6 MiB of memory, as after the first 50; without a
limit it grew by 2.2 MiB per input, to 539 MiB.)

**Why this cannot be told apart from TypeScript reading the samples:**

- *Errors surface where they did.* `addSource`/`addSourceSync` still call
  `parseSync` for each sample at the same point; only the engine's answer
  differs. A sample that is not JSON reaches V8's `JSON.parse`, so the
  error is V8's own, thrown from `addSource` as before, after the same
  earlier samples were added to the tables. The engine's reader accepts
  exactly V8's grammar (a port of `json-parser.cc`; checked against the
  5,017 recorded `JSON.parse` vectors and seeded random documents and
  mutations); should it ever reject a text V8 accepts, V8 parses it and
  TypeScript continues (the tables are filled first). Samples that are
  not strings, and every sample of other `CompressedJSON`s, take
  TypeScript's path untouched.
- *The same `Value`s.* A root `Value` is `tag | index << 4`. The engine
  returns it only for roots whose index does not depend on the string
  table: `null`, booleans, numbers (classified as `parsedNumberIsDouble`
  does, from the same `f64` and range), strings over 64 code units, and
  objects and arrays, which it numbers in the order they end, as
  `process` interns them, counting every sample read into the same
  `CompressedJSON`. So `_topLevels` holds the very numbers TypeScript
  would put there.
- *The same tables, whenever they are looked at.* The tables only change
  when a sample is read, and only through these four fields, so any code
  that could observe them (TypeScript's inference, `hashCode`,
  `getStringForValue`, a user's `CompressedJSON` shared by inputs,
  `JSON.stringify`, reading the private fields) goes through the
  accessors first. The engine's tables are TypeScript's for the same
  samples: it interns strings where `process` does (a value's strings,
  then its key, as `commitValue` interns `currentKey`; only the members
  `JSON.parse` keeps, so one `"__proto__"` of two; a new index for every
  `"__proto__"`; a string format's kind name; nothing of a sample that is
  not JSON or that it declines), numbers objects and arrays in the order
  they end, and encodes values as `makeValue` does
  (`CompressedJson::encode_value`). The fill starts from the empty tables
  the `CompressedJSON` had (the engine only starts on a fresh one), adds
  the strings as `internString` does (the same `_stringIndexes`, in the
  same property order), and leaves out a sample the engine read and then
  declined (a string root); the arrays and the object are the originals.
  The other fields a read creates (`_ctx`, `_rootValue`) are created by
  the engine's reads as `process` would create them, in the same order.
  What remains observable is that `Object.getOwnPropertyDescriptor` shows
  the four fields as accessors until they are first used. (After an
  engine failure, a small input's samples are read again by TypeScript's
  own `process`, with the configuration each was read with and any read in
  progress set aside, which gives the same tables.)
- *The same timing.* `parseSync` stays synchronous and `parse` still
  awaits it once, so `addSource` settles after the same number of
  microtask ticks, and concurrent `addSource` calls on one input
  interleave their samples the same way.
- *The same runs.* A run on the engine builds the same compressed form
  from the shared samples that it would build from the tables (the
  tables are its encoding), with the `_topLevels` read when the run
  starts, as before. Reading samples prints nothing and reports no timing
  in TypeScript, nor here; a run's `read input` timing covers inference
  in both. `quicktypeMultiFileSync` uses the shared samples like
  `quicktype()`; where the engine is not compiled yet, samples are read
  by TypeScript in the first place.
- *Everything else is TypeScript.* Whenever the engine does not take a
  sample (see above), or the TypeScript engine runs, the tables are
  filled first and TypeScript's code runs on the state it would have.

## Loading

The engine is one `.wasm` file, `dist/native/wasm/quicktype_wasm_bg.wasm`
(4.9 MiB, 1.8 MiB gzipped), shared by the CommonJS (`dist/`) and ES module
(`dist/esm/`) builds.

- **Node**: nothing happens at import. The first run reads and compiles
  the file synchronously, so `quicktypeMultiFileSync` works from the
  start. A JSON sample added before that compiles it only if it has at
  least 1 Mi code units; smaller ones are read by TypeScript (see [JSON
  samples](#json-samples)).
- **Browsers**: the ES module build starts `WebAssembly.compileStreaming` at
  import, from `new URL("../../../native/wasm/quicktype_wasm_bg.wasm",
  import.meta.url)`, which bundlers with asset support (Vite, webpack 5,
  Parcel) emit as an asset. `quicktype()` waits for it;
  `quicktypeMultiFileSync` uses the engine once it is ready and the TypeScript
  engine until then, and JSON samples added before it is ready are read by
  TypeScript. With the TypeScript engine forced (`"ts"`, set before
  the import), nothing is fetched or compiled; should the mode change later,
  the first run that may use the engine loads it.
- **Bundlers without asset support** (esbuild, an iife bundle): set
  `globalThis[Symbol.for("quicktype-core.wasmModule")]` to a
  `WebAssembly.Module` (or the file's bytes) before the first run:

  ```js
  const response = await fetch("/quicktype_wasm_bg.wasm");
  globalThis[Symbol.for("quicktype-core.wasmModule")] =
      await WebAssembly.compileStreaming(response);
  ```

If the engine cannot be loaded (the file cannot be fetched, the module does
not compile, or it does not instantiate as this engine), every run uses the
TypeScript engine. Loading is not tried again on each run, unless a different
module is supplied.

The module uses the WebAssembly features Rust's `wasm32-unknown-unknown`
target enables by default (bulk memory, multi-value, mutable globals,
non-trapping float-to-int conversions, reference types and sign extension),
so the engine runs in Chrome and Edge 96, Firefox 79 and Safari 15 and
later, and in every Node this package supports (20 and later). Where the
module does not compile, everything runs on the TypeScript engine, as
above.

## Building and testing

Needs Rust (with the `wasm32-unknown-unknown` target), `wasm-bindgen-cli` in
the version of the `wasm-bindgen` crate (`cargo install wasm-bindgen-cli
--version 0.2.114 --locked`) and Node 20+.

```sh
npm install
npm run build                  # cargo build (release, wasm32) + wasm-bindgen + wasm-opt -O3 + tsc (CJS and ESM)
npm test                       # package checks, engine tests (pow vectors, concurrency, traps, samples)
node --expose-gc test/bench/compare.mjs [--browser] [--cold N]   # WebAssembly against TypeScript
npm run test:differential      # same API calls against the reference quicktype-core and this package
npm run test:browser           # headless Chrome: bundled with esbuild, run in a page
npm run check:upstream         # src/ is still upstream's (needs a quicktype checkout)
```

`wasm-opt` is binaryen's, pinned in devDependencies (`--no-wasm-opt` skips
it). The engine's global allocator is Rust's own (dlmalloc) growing the
WebAssembly memory geometrically (`crates/quicktype-wasm/src/allocator.rs`):
growing it a page at a time made runs with outputs of millions of lines
superlinear. Neither changes what a run computes.

The differential suite (`test/differential/`) compares results (every file,
line and annotation), errors and console output of: the golden corpus
replayed through the API, every input × every language with default
options, ports of quicktype's API-level unit tests, JSON Schema store paths
(lazy fetch order, failures, concurrency, re-entrancy), errors and options,
and JSON samples as the engine reads them (errors from `addSource`, the
inputs' private state, key order, numbers, deep nesting, repeated and
concurrent use; category `samples`). The reference is the built `packages/quicktype-core` of a quicktype checkout
(`$QUICKTYPE_REFERENCE`, or `../quicktype` / `../../quicktype` next to the
repository), else this package's own TypeScript engine. Identical results
are reported by where they ran: on WebAssembly, on the TypeScript fallback
(declined by the engine as unsupported), or on TypeScript because the run
was not eligible.
