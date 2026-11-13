// Loading the WebAssembly engine (crates/quicktype-wasm), in Node and in
// browsers, from one ES module or CommonJS build.
//
// * Node: nothing happens at import. The first run reads the .wasm file
//   next to the glue with `fs.readFileSync` and compiles it synchronously,
//   so `quicktypeMultiFileSync` works from the first call.
// * Browsers (and other hosts without Node's `fs`): compilation starts at
//   import with `fetch` + `WebAssembly.compileStreaming`; `quicktype()`
//   waits for it. `quicktypeMultiFileSync` uses the engine once it is
//   ready and the TypeScript engine until then, so the API stays
//   synchronous.
// * Either way, an embedder can supply the module itself (a
//   `WebAssembly.Module`, or the bytes of the .wasm file) as
//   `globalThis[Symbol.for("quicktype-core.wasmModule")]` before the first
//   run, e.g. for bundlers that cannot emit the .wasm file as an asset.
//
// If the engine cannot be loaded, runs fall back to the TypeScript engine,
// which produces the same output.

import * as fs from "fs";

import { isNode } from "browser-or-node";

import { type WasmGlue, createGlue, wasmLocation } from "./wasm/glue.js";

// biome-ignore lint/suspicious/noExplicitAny: host globals the es6 lib does not declare
const host: any = globalThis;

const suppliedModuleKey = Symbol.for("quicktype-core.wasmModule");

let compiledModule: unknown;
let loadError: unknown;
let compiling: Promise<void> | undefined;
let current: WasmGlue | undefined;
const discarded = new WeakSet<WasmGlue>();

function suppliedModule(): unknown {
    const supplied = host[suppliedModuleKey];
    if (supplied === undefined || supplied === null) return undefined;
    if (supplied instanceof host.WebAssembly.Module) return supplied;
    return new host.WebAssembly.Module(supplied);
}

function compileSync(): void {
    if (compiledModule !== undefined) return;
    try {
        compiledModule =
            suppliedModule() ??
            new host.WebAssembly.Module(fs.readFileSync(wasmLocation() as string));
        loadError = undefined;
    } catch (e) {
        loadError = e;
    }
}

async function compileAsync(): Promise<void> {
    try {
        const supplied = suppliedModule();
        if (supplied !== undefined) {
            compiledModule = supplied;
            return;
        }

        const location = wasmLocation();
        const WA = host.WebAssembly;
        let compiled: unknown;
        if (typeof WA.compileStreaming === "function") {
            try {
                compiled = await WA.compileStreaming(host.fetch(location));
            } catch {
                // E.g. a server that does not send application/wasm.
                compiled = undefined;
            }
        }

        if (compiled === undefined) {
            const response = await host.fetch(location);
            compiled = await WA.compile(await response.arrayBuffer());
        }

        compiledModule = compiled;
        loadError = undefined;
    } catch (e) {
        loadError = e;
    }
}

function startCompiling(): Promise<void> {
    if (compiling === undefined) {
        compiling = compileAsync();
    }

    return compiling;
}

function instantiate(): WasmGlue | undefined {
    if (current !== undefined) return current;
    if (compiledModule === undefined) return undefined;
    try {
        const glue = createGlue();
        glue.initSync({ module: compiledModule });
        current = glue;
        return glue;
    } catch (e) {
        loadError = e;
        return undefined;
    }
}

/** The engine, if it can be had synchronously. */
export function engineSync(): WasmGlue | undefined {
    if (current !== undefined) return current;
    if (isNode || host[suppliedModuleKey] !== undefined) {
        compileSync();
    }

    return instantiate();
}

/** The engine, once it is compiled; `undefined` if it cannot be loaded. */
export async function engineAsync(): Promise<WasmGlue | undefined> {
    if (current !== undefined) return current;
    if (isNode || host[suppliedModuleKey] !== undefined) {
        compileSync();
    } else {
        await startCompiling();
    }

    return instantiate();
}

/** Why the engine could not be loaded, if it could not. */
export function engineLoadError(): unknown {
    return loadError;
}

/**
 * Drops an instance that trapped (or overflowed its stack): its memory may
 * be inconsistent. The next run instantiates the compiled module afresh.
 */
export function discardEngine(glue: WasmGlue): void {
    discarded.add(glue);
    if (current === glue) {
        current = undefined;
    }
}

export function isDiscarded(glue: WasmGlue): boolean {
    return discarded.has(glue);
}

if (!isNode && typeof host.fetch === "function") {
    // Browsers: compile in the background from the start.
    void startCompiling();
}
