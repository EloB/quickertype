// Builds the package the tests that need the engine's test hooks use: this
// package's dist/ (the facade, as `npm run build` built it), with an engine
// built with quicktype-wasm's `test-hooks` feature, whose glue (from
// script/bindgen.mjs, as the shipped one) also returns `testHookExports`
// (`__panicForTests`, `__hashForTests`, ...). The shipped engine has none of
// them (test/package.test.mjs checks).
//
//   node script/test-hooks.mjs   (npm test runs it first, after npm run build)
//
// The package is build/test-hooks/package; test/hooks.mjs loads it as the
// facade loads the shipped one. The engine is built in its own target
// directory, build/test-hooks/target, so that it never overwrites the
// package's own build, with the `test-hooks` profile: release code without
// fat LTO, which builds in about a minute from scratch and in seconds when
// little changed. No wasm-opt.

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

import { findBindgen, packageRoot, repositoryRoot, writeGlue } from "./bindgen.mjs";

const outDir = path.join(packageRoot, "build", "test-hooks");
const hooksPackage = path.join(outDir, "package");

function run(command, commandArgs, options = {}) {
    console.log(`$ ${command} ${commandArgs.join(" ")}`);
    execFileSync(command, commandArgs, { stdio: "inherit", ...options });
}

const dist = path.join(packageRoot, "dist");
if (!fs.existsSync(path.join(dist, "index.js"))) {
    throw new Error("test-hooks: no dist/ to take the facade from; run `npm run build` first");
}

const targetDir = path.join(outDir, "target");
run(
    "cargo",
    ["build", "-p", "quicktype-wasm", "--target", "wasm32-unknown-unknown", "--profile", "test-hooks", "--features", "test-hooks"],
    { cwd: repositoryRoot, env: { ...process.env, CARGO_TARGET_DIR: targetDir } },
);
const bindgenDir = path.join(outDir, "wasm-bindgen");
fs.rmSync(bindgenDir, { recursive: true, force: true });
run(findBindgen(), [
    "--target",
    "web",
    "--out-dir",
    bindgenDir,
    path.join(targetDir, "wasm32-unknown-unknown", "test-hooks", "quicktype_wasm.wasm"),
]);

fs.rmSync(hooksPackage, { recursive: true, force: true });
fs.mkdirSync(hooksPackage, { recursive: true });
fs.copyFileSync(path.join(packageRoot, "package.json"), path.join(hooksPackage, "package.json"));
fs.cpSync(dist, path.join(hooksPackage, "dist"), { recursive: true });
writeGlue(bindgenDir, path.join(hooksPackage, "dist"), ["test-hooks"]);
console.log(`built ${path.relative(packageRoot, hooksPackage)}/ (the engine with test hooks)`);
