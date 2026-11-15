// What script/build.mjs (the package) and script/test-hooks.mjs (the
// tests' engine) share: finding the wasm-bindgen CLI, and wrapping its glue
// in a factory (`createGlue()`), written once as CommonJS and once as an ES
// module, each with a `wasmLocation()` for its tree.

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

export const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
export const repositoryRoot = path.join(packageRoot, "..", "..");

/** The version of the `wasm-bindgen` crate in Cargo.lock. */
export function lockedBindgenVersion() {
    const lock = fs.readFileSync(path.join(repositoryRoot, "Cargo.lock"), "utf8");
    const match = /\[\[package\]\]\nname = "wasm-bindgen"\nversion = "([^"]+)"/.exec(lock);
    if (match === null) throw new Error("wasm-bindgen is not in Cargo.lock");
    return match[1];
}

/** The wasm-bindgen CLI of that version: $WASM_BINDGEN, on PATH, or in ~/.cargo/bin. */
export function findBindgen() {
    const candidates = [
        process.env.WASM_BINDGEN,
        "wasm-bindgen",
        path.join(os.homedir(), ".cargo", "bin", "wasm-bindgen"),
    ].filter((c) => c !== undefined);
    const wanted = lockedBindgenVersion();
    for (const candidate of candidates) {
        let version;
        try {
            version = execFileSync(candidate, ["--version"], { encoding: "utf8" }).trim();
        } catch {
            continue;
        }

        if (version === `wasm-bindgen ${wanted}`) return candidate;
        console.warn(`${candidate} is ${version}, need ${wanted}`);
    }

    throw new Error(
        `wasm-bindgen ${wanted} not found: cargo install wasm-bindgen-cli --version ${wanted} --locked`,
    );
}

/** Exports of the glue that the facade uses (src/native/wasm/glue.d.ts). */
export const glueExports = [
    "initSync",
    "runSync",
    "start",
    "poll",
    "settle",
    "cancel",
    "supportsLanguage",
    "jsonCreate",
    "jsonRead",
    "jsonReadBytes",
    "jsonReadLines",
    "jsonReadLinesBytes",
    "jsonDrop",
    "jsonHeld",
    "jsonBytes",
    "jsonExport",
    "jsonAcquire",
    "jsonRelease",
    "engineVersion",
];

/**
 * Exports for the tests only, which an engine has with quicktype-wasm's
 * `test-hooks` feature (script/test-hooks.mjs builds one); the shipped
 * engine has none of them (test/package.test.mjs checks).
 */
export const testHookExports = [
    "__pow",
    "__panicForTests",
    "__pendingRuns",
    "__jsonCount",
    "__jsonLeases",
    "__jsonReadTrapForTests",
    "__memoryGrowths",
    "__memoryPages",
    "__hashForTests",
];

/** Exports that only builds with a cargo feature have, by feature. */
export const featureExports = {
    "test-hooks": testHookExports,
    // Measurements (`--heap-stats`, `--trace`; docs/BENCHMARKS.md).
    "heap-stats": ["__heapBytes", "__heapPeak"],
    trace: ["__trace"],
};

/**
 * The wasm-bindgen glue in `bindgenDir` as the body of `function
 * createGlue()`, returning the facade's exports and those of `features`
 * (each must be there), plus any other feature's exports the module has
 * (one reused with --skip-wasm).
 */
function glueFactory(bindgenDir, features) {
    let glue = fs.readFileSync(path.join(bindgenDir, "quicktype_wasm.js"), "utf8");
    const replace = (pattern, replacement) => {
        const next = glue.replace(pattern, replacement);
        if (next === glue) throw new Error(`glue: no match for ${pattern}`);
        glue = next;
    };

    replace(/^\/\* @ts-self-types=.*\*\/\n/m, "");
    // Strings go into the engine with one `encodeInto` (native, and much
    // faster than the glue's loop over the ASCII prefix, which JSON samples
    // of many megabytes go through), then as the glue does for the rest.
    replace(
        `    const mem = getUint8ArrayMemory0();

    let offset = 0;

    for (; offset < len; offset++) {
        const code = arg.charCodeAt(offset);
        if (code > 0x7F) break;
        mem[ptr + offset] = code;
    }
    if (offset !== len) {
        if (offset !== 0) {
            arg = arg.slice(offset);
        }
`,
        `    const prefix = cachedTextEncoder.encodeInto(arg, getUint8ArrayMemory0().subarray(ptr, ptr + len));
    let offset = prefix.written;
    if (prefix.read !== arg.length) {
        arg = arg.slice(prefix.read);
`,
    );
    replace(/^export function /gm, "function ");
    replace(/^export \{ initSync, __wbg_init as default \};\n?/m, "");
    // The default module location uses import.meta, which CommonJS cannot
    // parse; the facade always passes the module.
    replace(
        /new URL\('quicktype_wasm_bg\.wasm', import\.meta\.url\)/,
        "(() => { throw new Error('quicktype-core: no WebAssembly module given'); })()",
    );
    if (/\bexport\b|import\.meta/.test(glue)) {
        throw new Error("glue: unexpected export or import.meta left");
    }

    const has = (name) => new RegExp(`^function ${name}\\(`, "m").test(glue);
    for (const feature of features) {
        for (const name of featureExports[feature]) {
            if (!has(name)) throw new Error(`glue: built with ${feature}, but the module has no ${name}`);
        }
    }

    const optional = Object.values(featureExports).flat().filter(has);
    const exported = [...glueExports, ...optional];
    for (const name of glueExports) {
        if (!has(name)) throw new Error(`glue: ${name} missing`);
    }

    const body = glue.replace(/^/gm, "    ").replace(/^ +$/gm, "");
    return `// Generated by script/build.mjs from the wasm-bindgen glue of crates/quicktype-wasm.

function createGlue() {
${body}
    return { ${exported.join(", ")} };
}
`;
}

/**
 * Writes the module and the glue from `bindgenDir` into `dist` (its
 * native/wasm and esm/native/wasm), with the declarations of
 * src/native/wasm/glue.d.ts. `features` are the cargo features the module
 * was built with.
 */
export function writeGlue(bindgenDir, dist, features = []) {
    const factory = glueFactory(bindgenDir, features);
    const cjsDir = path.join(dist, "native", "wasm");
    const esmDir = path.join(dist, "esm", "native", "wasm");
    fs.mkdirSync(cjsDir, { recursive: true });
    fs.mkdirSync(esmDir, { recursive: true });
    fs.copyFileSync(
        path.join(bindgenDir, "quicktype_wasm_bg.wasm"),
        path.join(cjsDir, "quicktype_wasm_bg.wasm"),
    );
    fs.writeFileSync(
        path.join(cjsDir, "glue.js"),
        `"use strict";\n${factory}
function wasmLocation() {
    // Node: next to this file. A browser bundle of the CommonJS build has no
    // __dirname or "path" (package.json maps "path" to false), so there the
    // file is expected next to the bundle's script.
    if (typeof process === "object" && process !== null && process.versions != null && process.versions.node != null) {
        return __dirname + "/quicktype_wasm_bg.wasm";
    }

    var script = typeof document === "object" && document !== null ? document.currentScript : null;
    var base = script && script.src ? script.src : typeof location === "object" && location !== null ? location.href : undefined;
    return new URL("quicktype_wasm_bg.wasm", base);
}

exports.createGlue = createGlue;
exports.wasmLocation = wasmLocation;
`,
    );
    // One copy of the .wasm file, in the CommonJS tree.
    fs.writeFileSync(
        path.join(esmDir, "glue.js"),
        `${factory}
function wasmLocation() {
    return new URL("../../../native/wasm/quicktype_wasm_bg.wasm", import.meta.url);
}

export { createGlue, wasmLocation };
`,
    );
    const declarations = path.join(packageRoot, "src", "native", "wasm", "glue.d.ts");
    fs.copyFileSync(declarations, path.join(cjsDir, "glue.d.ts"));
    fs.copyFileSync(declarations, path.join(esmDir, "glue.d.ts"));
}
