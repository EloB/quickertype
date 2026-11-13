// Loading the WebAssembly engine (crates/quicktype-wasm), in Node and in
// browsers, from one ES module or CommonJS build.
//
// * Node: nothing happens at import. The first run reads the .wasm file
//   next to the glue with `fs.readFileSync` and compiles it synchronously,
//   so `quicktypeMultiFileSync` works from the first call.
// * Browsers (and other hosts without Node's `fs`): compilation starts at
//   import with `fetch` + `WebAssembly.compileStreaming`, unless the
//   TypeScript engine is forced (`engineMode()` is "ts"); `quicktype()`
//   waits for it. `quicktypeMultiFileSync` uses the engine once it is
//   ready and the TypeScript engine until then, so the API stays
//   synchronous.
// * Either way, an embedder can supply the module itself (a
//   `WebAssembly.Module`, or the bytes of the .wasm file) as
//   `globalThis[Symbol.for("quicktype-core.wasmModule")]` before the first
//   run, e.g. for bundlers that cannot emit the .wasm file as an asset.
//
// If the engine cannot be loaded (the file cannot be read, the module does
// not compile, or it does not instantiate as this engine), runs fall back
// to the TypeScript engine, which produces the same output, and loading is
// not tried again on every run.

import * as fs from "fs";

import { isNode } from "browser-or-node";

import { type WasmGlue, createGlue, wasmLocation } from "./wasm/glue.js";

// biome-ignore lint/suspicious/noExplicitAny: host globals the es6 lib does not declare
const host: any = globalThis;

const suppliedModuleKey = Symbol.for("quicktype-core.wasmModule");
const engineKey = Symbol.for("quicktype-core.engine");

/**
 * `QUICKTYPE_ENGINE` (or `globalThis[Symbol.for("quicktype-core.engine")]`):
 * `ts` runs everything on the TypeScript engine; `wasm` uses the
 * WebAssembly engine for every eligible run and fails if it cannot be
 * loaded; anything else uses it when it can be loaded.
 */
export function engineMode(): "ts" | "wasm" | "auto" {
    let mode = host[engineKey];
    if (mode === undefined && typeof process !== "undefined") {
        mode = process.env?.QUICKTYPE_ENGINE;
    }

    return mode === "ts" || mode === "wasm" ? mode : "auto";
}

let compiledModule: unknown;
/** A compiled module that did not instantiate as this engine; it is not tried again. */
let failedModule: unknown;
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

let attempted = false;
let attemptedWith: unknown;
let attempts = 0;

let instantiations = 0;

/** How often the engine was compiled (or tried to be), for tests. */
export function compileAttempts(): number {
    return attempts;
}

/** How often a compiled engine was instantiated (or tried to be), for tests. */
export function instantiateAttempts(): number {
    return instantiations;
}

function compileSync(): void {
    if (compiledModule !== undefined && compiledModule !== failedModule) return;
    // A failure is final, unless the embedder supplies a module afterwards.
    const supplied = host[suppliedModuleKey];
    if (attempted && supplied === attemptedWith) return;
    attempted = true;
    attemptedWith = supplied;
    attempts++;
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
    attempts++;
    try {
        if (host[suppliedModuleKey] !== undefined && host[suppliedModuleKey] !== null) {
            // As compileSync would: this module is not compiled again.
            attempted = true;
            attemptedWith = host[suppliedModuleKey];
            compiledModule = suppliedModule();
            loadError = undefined;
            return;
        }

        const WA = host.WebAssembly;
        const response = await host.fetch(wasmLocation());
        if (!response.ok) throw new Error(`${response.status} ${response.statusText} for ${response.url}`);
        let compiled: unknown;
        if (typeof WA.compileStreaming === "function") {
            try {
                compiled = await WA.compileStreaming(response.clone());
            } catch {
                // E.g. a server that does not send application/wasm.
                compiled = undefined;
            }
        }

        if (compiled === undefined) {
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
    if (compiledModule === undefined || compiledModule === failedModule) return undefined;
    instantiations++;
    try {
        const glue = createGlue();
        glue.initSync({ module: compiledModule });
        // A module that instantiates but is not this engine (it lacks the
        // exports) fails here, once, rather than in every run.
        glue.engineVersion();
        current = glue;
        return glue;
    } catch (e) {
        loadError = e;
        failedModule = compiledModule;
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

if (!isNode && typeof host.fetch === "function" && engineMode() !== "ts") {
    // Browsers: compile in the background from the start, unless every run
    // is to use the TypeScript engine (then the first run that may use the
    // engine, should the mode change, compiles it).
    void startCompiling();
}
