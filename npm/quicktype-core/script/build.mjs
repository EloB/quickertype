// Builds the package: the WebAssembly engine (crates/quicktype-wasm) and
// the TypeScript facade, as CommonJS (dist/) and ES modules (dist/esm/).
//
//   node script/build.mjs [--skip-wasm] [--debug] [--heap-stats] [--trace]
//
// 1. `cargo build -p quicktype-wasm --target wasm32-unknown-unknown --release`
// 2. `wasm-bindgen --target web` (the CLI version must equal the
//    `wasm-bindgen` crate's; set WASM_BINDGEN to its path if it is not on
//    PATH or in ~/.cargo/bin; script/bindgen.mjs). The glue is wrapped in a factory
//    (`createGlue()`) so that an instance that trapped can be replaced by
//    a fresh one with fresh glue state, and written once as CommonJS and
//    once as an ES module, each with a `wasmLocation()` for its tree.
// 3. `wasm-opt -O3` (binaryen, the version pinned in devDependencies) on the
//    module wasm-bindgen wrote, for release builds.
// 4. `tsc` for both trees (as quicktype-core's own build does), plus the
//    {"type": "module"} marker in dist/esm.
//
// --skip-wasm reuses build/wasm-bindgen from an earlier build (optimized
// already, if it was a release build); --no-wasm-opt leaves out step 3;
// --heap-stats builds the engine with the `heap-stats` feature, whose
// allocator counts the bytes in use and their peak (`__heapBytes`,
// `__heapPeak`), for measurements (it costs about 2% of a run's time);
// --trace builds it with the `trace` feature, which records where a run's
// time goes (`__trace`; docs/BENCHMARKS.md).

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

import { findBindgen, packageRoot, repositoryRoot, writeGlue } from "./bindgen.mjs";

const bindgenDir = path.join(packageRoot, "build", "wasm-bindgen");
const dist = path.join(packageRoot, "dist");

const args = new Set(process.argv.slice(2));
const profile = args.has("--debug") ? "debug" : "release";
/** The engine's cargo features (measurements only; the tests' own engine is script/test-hooks.mjs). */
const features = ["heap-stats", "trace"].filter((f) => args.has(`--${f}`));

function run(command, commandArgs, options = {}) {
    console.log(`$ ${command} ${commandArgs.join(" ")}`);
    execFileSync(command, commandArgs, { stdio: "inherit", ...options });
}

function buildWasm() {
    const cargoArgs = ["build", "-p", "quicktype-wasm", "--target", "wasm32-unknown-unknown"];
    if (profile === "release") cargoArgs.push("--release");
    if (features.length > 0) cargoArgs.push("--features", features.join(","));
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
writeGlue(bindgenDir, dist, features);
const wasmSize = fs.statSync(path.join(dist, "native", "wasm", "quicktype_wasm_bg.wasm")).size;
console.log(`built dist/ (engine: ${(wasmSize / 1024 / 1024).toFixed(2)} MiB)`);
