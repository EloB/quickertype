// Builds the package: the WebAssembly engine (crates/quicktype-wasm) and
// the TypeScript facade, as CommonJS (dist/) and ES modules (dist/esm/).
//
//   node script/build.mjs [--skip-wasm] [--debug]
//
// 1. `cargo build -p quicktype-wasm --target wasm32-unknown-unknown --release`
// 2. `wasm-bindgen --target web` (the CLI version must equal the
//    `wasm-bindgen` crate's; set WASM_BINDGEN to its path if it is not on
//    PATH or in ~/.cargo/bin). The glue is wrapped in a factory
//    (`createGlue()`) so that an instance that trapped can be replaced by
//    a fresh one with fresh glue state, and written once as CommonJS and
//    once as an ES module, each with a `wasmLocation()` for its tree.
// 3. `wasm-opt -O3` (binaryen, the version pinned in devDependencies) on the
//    module wasm-bindgen wrote, for release builds.
// 4. `tsc` for both trees (as quicktype-core's own build does), plus the
//    {"type": "module"} marker in dist/esm.
//
// --skip-wasm reuses build/wasm-bindgen from an earlier build (optimized
// already, if it was a release build); --no-wasm-opt leaves out step 3.

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const repositoryRoot = path.join(packageRoot, "..", "..");
const bindgenDir = path.join(packageRoot, "build", "wasm-bindgen");
const dist = path.join(packageRoot, "dist");

const args = new Set(process.argv.slice(2));
const profile = args.has("--debug") ? "debug" : "release";

function run(command, commandArgs, options = {}) {
    console.log(`$ ${command} ${commandArgs.join(" ")}`);
    execFileSync(command, commandArgs, { stdio: "inherit", ...options });
}

/** The version of the `wasm-bindgen` crate in Cargo.lock. */
function lockedBindgenVersion() {
    const lock = fs.readFileSync(path.join(repositoryRoot, "Cargo.lock"), "utf8");
    const match = /\[\[package\]\]\nname = "wasm-bindgen"\nversion = "([^"]+)"/.exec(lock);
    if (match === null) throw new Error("wasm-bindgen is not in Cargo.lock");
    return match[1];
}

function findBindgen() {
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

function buildWasm() {
    const cargoArgs = ["build", "-p", "quicktype-wasm", "--target", "wasm32-unknown-unknown"];
    if (profile === "release") cargoArgs.push("--release");
    run("cargo", cargoArgs, { cwd: repositoryRoot });
    const wasm = path.join(
        repositoryRoot,
        "target",
        "wasm32-unknown-unknown",
        profile,
        "quicktype_wasm.wasm",
    );
    fs.rmSync(bindgenDir, { recursive: true, force: true });
    run(findBindgen(), ["--target", "web", "--out-dir", bindgenDir, wasm]);
    if (profile === "release" && !args.has("--no-wasm-opt")) optimizeWasm();
}

/**
 * The WebAssembly features the module uses: those rustc's
 * wasm32-unknown-unknown target enables by default (`rustc --print cfg
 * --target wasm32-unknown-unknown`), which wasm-opt must be told, since
 * the module carries no target_features section. Every engine this
 * package supports has them (see the README).
 */
const wasmFeatures = [
    "--enable-bulk-memory",
    "--enable-bulk-memory-opt",
    "--enable-multivalue",
    "--enable-mutable-globals",
    "--enable-nontrapping-float-to-int",
    "--enable-reference-types",
    "--enable-sign-ext",
    "--enable-call-indirect-overlong",
];

/** `wasm-opt -O3` on the module, in place. */
function optimizeWasm() {
    const wasmOpt = path.join(packageRoot, "node_modules", "binaryen", "bin", "wasm-opt");
    if (!fs.existsSync(wasmOpt)) throw new Error("binaryen is not installed: npm install");
    const file = path.join(bindgenDir, "quicktype_wasm_bg.wasm");
    const before = fs.statSync(file).size;
    run(process.execPath, [wasmOpt, "-O3", ...wasmFeatures, file, "-o", file]);
    console.log(`wasm-opt: ${(before / 1024 / 1024).toFixed(2)} MiB -> ${(fs.statSync(file).size / 1024 / 1024).toFixed(2)} MiB`);
}

/** Exports of the glue that the facade uses (src/native/wasm/glue.d.ts). */
const glueExports = [
    "initSync",
    "runSync",
    "start",
    "poll",
    "settle",
    "cancel",
    "supportsLanguage",
    "jsonCreate",
    "jsonRead",
    "jsonDrop",
    "jsonHeld",
    "jsonExport",
    "jsonAcquire",
    "jsonRelease",
    "engineVersion",
    "__pow",
    "__panicForTests",
    "__pendingRuns",
    "__jsonCount",
    "__jsonLeases",
    "__jsonReadTrapForTests",
    "__memoryGrowths",
    "__memoryPages",
    "__heapBytes",
    "__heapPeak",
];

/** The wasm-bindgen glue as the body of `function createGlue()`. */
function glueFactory() {
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

    for (const name of glueExports) {
        if (!new RegExp(`^function ${name}\\(`, "m").test(glue)) {
            throw new Error(`glue: ${name} missing`);
        }
    }

    const body = glue.replace(/^/gm, "    ").replace(/^ +$/gm, "");
    return `// Generated by script/build.mjs from the wasm-bindgen glue of crates/quicktype-wasm.

function createGlue() {
${body}
    return { ${glueExports.join(", ")} };
}
`;
}

function writeGlue() {
    const factory = glueFactory();
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

function buildTypeScript() {
    fs.rmSync(dist, { recursive: true, force: true });
    const tsc = path.join(packageRoot, "node_modules", "typescript", "bin", "tsc");
    run(process.execPath, [tsc, "-p", "tsconfig.json"], { cwd: packageRoot });
    run(process.execPath, [tsc, "-p", "tsconfig.esm.json"], { cwd: packageRoot });
    run(process.execPath, [path.join("script", "write-esm-package-json.mjs")], {
        cwd: packageRoot,
    });
}

if (!args.has("--skip-wasm")) {
    buildWasm();
} else if (!fs.existsSync(path.join(bindgenDir, "quicktype_wasm.js"))) {
    throw new Error("--skip-wasm: no earlier wasm build in build/wasm-bindgen");
}

buildTypeScript();
writeGlue();
const wasmSize = fs.statSync(path.join(dist, "native", "wasm", "quicktype_wasm_bg.wasm")).size;
console.log(`built dist/ (engine: ${(wasmSize / 1024 / 1024).toFixed(2)} MiB)`);
