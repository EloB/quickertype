// Runs before quicktype-core is evaluated (worker.js imports it first, and
// esbuild keeps ES module evaluation order, top-level await included).
//
// quicktype-core starts compiling its engine when it is imported in a
// browser, from a URL next to its own module, which does not exist in this
// bundle. Its README's answer for bundlers without asset support: hand it
// the compiled module as `globalThis[Symbol.for("quicktype-core.wasmModule")]`
// before the first run. Doing that here, before the import, means the
// package never looks for the file itself.
//
// The worker is started as `worker.js?engine=wasm` or `?engine=ts`. The
// TypeScript worker sets `Symbol.for("quicktype-core.engine")` to "ts" and
// hands over an empty module, so it does not download and compile an
// engine it will not use.

/* global __WASM_FILE__ */

const engineKey = Symbol.for("quicktype-core.engine");
const moduleKey = Symbol.for("quicktype-core.wasmModule");
// The smallest valid WebAssembly module: the magic number and version 1.
const emptyModule = new Uint8Array([0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00]);

export const engine = new URLSearchParams(self.location.search).get("engine") === "ts" ? "ts" : "wasm";

/** What the worker's start-up cost, for the page to show. */
export const boot = { engine, compileMs: undefined, loadError: undefined };

if (engine === "ts") {
    globalThis[engineKey] = "ts";
    globalThis[moduleKey] = emptyModule;
} else {
    const url = new URL(__WASM_FILE__, import.meta.url);
    const start = performance.now();
    try {
        let module;
        try {
            module = await WebAssembly.compileStreaming(fetch(url));
        } catch {
            // E.g. a server that does not send application/wasm.
            const response = await fetch(url);
            if (!response.ok) throw new Error(`${response.status} ${response.statusText} for ${url}`);
            module = await WebAssembly.compile(await response.arrayBuffer());
        }

        globalThis[moduleKey] = module;
        boot.compileMs = performance.now() - start;
    } catch (e) {
        // quicktype-core falls back to its TypeScript engine; the page says so.
        boot.loadError = String(e?.message ?? e);
        globalThis[moduleKey] = emptyModule;
    }
}
