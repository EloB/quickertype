# quicktype-core (WebAssembly)

A drop-in replacement for the npm package
[`quicktype-core`](https://www.npmjs.com/package/quicktype-core) whose runs
execute on the Rust port of quicktype, compiled to WebAssembly. The API, the
`.d.ts` files and the results are quicktype's own:

```ts
import { quicktype, InputData, jsonInputForTargetLanguage } from "quicktype-core";

const input = jsonInputForTargetLanguage("typescript");
await input.addSource({ name: "Person", samples: ['{"name": "Ann", "age": 7}'] });
const inputData = new InputData();
inputData.addInput(input);
const { lines } = await quicktype({ inputData, lang: "typescript" });
```

## How it works

`src/` is quicktype's `packages/quicktype-core/src` at the commit in
`src/native/UPSTREAM.json`, byte for byte, except `Run.ts`: after `preRun()`
it hands the run to the engine (`src/native/bridge.ts`) when the engine can
do it exactly. Everything before that stays in TypeScript, so inputs are
collected, JSON samples parsed (`JSON.parse`, V8's errors), schema text
parsed (JSON, then YAML) and files and URLs read exactly as before. Each run
is **one call** into `crates/quicktype-wasm`, carrying the inputs'
`CompressedJSON` tables and normalized JSON Schema sources; the engine fetches
`$ref`ed schemas through the input's own `JSONSchemaStore` while it builds
types, at the points where TypeScript awaits them. Errors come back as
quicktype's message kinds and are rebuilt with the TypeScript `messageError`,
so `QuickTypeError`'s `messageName`, `message` and `properties` are the same;
JavaScript exceptions are rethrown as the same class with the same message;
whatever a store or `onTiming` throws is rethrown as is.

Runs the engine does not model use the original TypeScript engine, with the
same results by construction:

- a custom `TargetLanguage` (any subclass or modified instance), or a
  `CompressedJSON`, `Input` or date/time recognizer that is not quicktype's;
- `JSONSchemaInput`s with extra attribute producers;
- option values outside what quicktype's options read (a number for a string
  option, `"toString"` for an enum option, a `Name` in `leadingComments`, …);
- GraphQL input (`quicktype-graphql-input`, not ported yet);
- languages whose renderer the engine does not have yet: the engine says
  so (`supportsLanguage`, and an `{ unsupported }` outcome should a run
  hit a missing feature midway), never with an error.

`QUICKTYPE_ENGINE=ts` (or `globalThis[Symbol.for("quicktype-core.engine")] =
"ts"`) runs everything on the TypeScript engine; `wasm` makes a failure to
load the engine an error instead of a fallback. `engineStats` in
`dist/native/bridge.js` counts the runs on each engine (`wasm`, `ts`) and
the runs the engine declined (`unsupported`, by feature in
`unsupportedBy`).

## Loading

The engine is one `.wasm` file, `dist/native/wasm/quicktype_wasm_bg.wasm`
(4.8 MiB, 1.6 MiB gzipped), shared by the CommonJS (`dist/`) and ES module
(`dist/esm/`) builds.

- **Node**: nothing happens at import. The first run reads and compiles the
  file synchronously, so `quicktypeMultiFileSync` works from the start.
- **Browsers**: the ES module build starts `WebAssembly.compileStreaming` at
  import, from `new URL("../../../native/wasm/quicktype_wasm_bg.wasm",
  import.meta.url)`, which bundlers with asset support (Vite, webpack 5,
  Parcel) emit as an asset. `quicktype()` waits for it;
  `quicktypeMultiFileSync` uses the engine once it is ready and the TypeScript
  engine until then.
- **Bundlers without asset support** (esbuild, an iife bundle): set
  `globalThis[Symbol.for("quicktype-core.wasmModule")]` to a
  `WebAssembly.Module` (or the file's bytes) before the first run:

  ```js
  const response = await fetch("/quicktype_wasm_bg.wasm");
  globalThis[Symbol.for("quicktype-core.wasmModule")] =
      await WebAssembly.compileStreaming(response);
  ```

If the engine cannot be loaded, every run uses the TypeScript engine.

## Building and testing

Needs Rust (with the `wasm32-unknown-unknown` target), `wasm-bindgen-cli` in
the version of the `wasm-bindgen` crate (`cargo install wasm-bindgen-cli
--version 0.2.114 --locked`) and Node 20+.

```sh
npm install
npm run build                  # cargo build (release, wasm32) + wasm-bindgen + tsc (CJS and ESM)
npm test                       # package checks, engine tests (pow vectors, concurrency, traps)
npm run test:differential      # same API calls against the reference quicktype-core and this package
npm run test:browser           # headless Chrome: bundled with esbuild, run in a page
npm run check:upstream         # src/ is still upstream's (needs a quicktype checkout)
```

The differential suite (`test/differential/`) compares results (every file,
line and annotation), errors and console output of: the golden corpus
replayed through the API, every input × every language with default
options, ports of quicktype's API-level unit tests, JSON Schema store paths
(lazy fetch order, failures, concurrency, re-entrancy), errors and options.
The reference is the built `packages/quicktype-core` of a quicktype checkout
(`$QUICKTYPE_REFERENCE`, or `../quicktype` / `../../quicktype` next to the
repository), else this package's own TypeScript engine. Identical results
are reported by where they ran: on WebAssembly, on the TypeScript fallback
(declined by the engine as unsupported), or on TypeScript because the run
was not eligible.
