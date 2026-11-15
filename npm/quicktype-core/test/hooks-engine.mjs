// The engine with test hooks (quicktype-wasm's `test-hooks` feature), for
// the tests that need an export the shipped engine must not have, such as
// `__hashForTests`. A debug build of crates/quicktype-wasm with the
// feature, and wasm-bindgen's Node.js glue for it, in build/test-hooks:
// it loads with `require`, and each fresh `require` (after deleting it from
// the cache) is a fresh instance, which takes its own seed when it starts.
// The shipped engine (script/build.mjs, dist/) is never built with it.
//
// Needs cargo with the wasm32-unknown-unknown target and the wasm-bindgen
// CLI of the version in Cargo.lock (WASM_BINDGEN, PATH or ~/.cargo/bin),
// as `npm run build` does. Cargo rebuilds only what changed; a first build
// takes about a minute.

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const repositoryRoot = path.join(packageRoot, "..", "..");
const outDir = path.join(packageRoot, "build", "test-hooks");

/** The version of the `wasm-bindgen` crate in Cargo.lock. */
function lockedBindgenVersion() {
    const lock = fs.readFileSync(path.join(repositoryRoot, "Cargo.lock"), "utf8");
    const match = /\[\[package\]\]\nname = "wasm-bindgen"\nversion = "([^"]+)"/.exec(lock);
    if (match === null) throw new Error("wasm-bindgen is not in Cargo.lock");
    return match[1];
}

function findBindgen() {
    const wanted = `wasm-bindgen ${lockedBindgenVersion()}`;
    const candidates = [process.env.WASM_BINDGEN, "wasm-bindgen", path.join(os.homedir(), ".cargo", "bin", "wasm-bindgen")];
    for (const candidate of candidates.filter((c) => c !== undefined)) {
        try {
            if (execFileSync(candidate, ["--version"], { encoding: "utf8" }).trim() === wanted) return candidate;
        } catch {
            // Not this one.
        }
    }
    throw new Error(`the test-hooks engine needs ${wanted} (set WASM_BINDGEN)`);
}

let built;

/** Builds the test-hooks engine if needed; returns the path of its glue, to `require`. */
export function hooksEngine() {
    if (built !== undefined) return built;
    const targetDir = JSON.parse(
        execFileSync("cargo", ["metadata", "--format-version", "1", "--no-deps"], { cwd: repositoryRoot, encoding: "utf8" }),
    ).target_directory;
    execFileSync(
        "cargo",
        ["build", "--package", "quicktype-wasm", "--target", "wasm32-unknown-unknown", "--features", "test-hooks"],
        { cwd: repositoryRoot, stdio: ["ignore", "ignore", "inherit"] },
    );
    const wasm = path.join(targetDir, "wasm32-unknown-unknown", "debug", "quicktype_wasm.wasm");
    execFileSync(findBindgen(), ["--target", "nodejs", "--out-dir", outDir, wasm], { stdio: ["ignore", "ignore", "inherit"] });
    built = path.join(outDir, "quicktype_wasm.js");
    return built;
}
