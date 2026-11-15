// Which package a test runs on: the shipped one (dist/), or the one with
// the engine's test hooks (`__panicForTests`, `__hashForTests`, ...;
// script/test-hooks.mjs builds it, and `npm test` runs that first): the
// shipped facade, loading an engine built with quicktype-wasm's
// `test-hooks` feature exactly as it loads the shipped one.
//
// A test file that has tests of both kinds runs twice: as itself, on the
// shipped package, and from its `*.hooks.test.mjs` twin, which sets
// QUICKTYPE_TEST_ENGINE=test-hooks, on the test-hooks package. It
// registers each test with `shippedTest` (calls no hook: the shipped run
// only), `hookTest` (calls one: the test-hooks run only) or `test` (both:
// a hook only checks more, as `hasHooks` says).

import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const require = createRequire(import.meta.url);
const here = path.dirname(fileURLToPath(import.meta.url));

/** The shipped package's root. */
export const packageRoot = path.join(here, "..");

/** The test-hooks package's root, which `require` loads as the package itself. */
export const hooksPackageRoot = path.join(packageRoot, "build", "test-hooks", "package");

/** Whether this run is on the test-hooks package (a `*.hooks.test.mjs` twin). */
export const onHooks = process.env.QUICKTYPE_TEST_ENGINE === "test-hooks";

/** The package at `root`: the facade's modules the tests use. */
function load(root, hasHooks) {
    const dist = path.join(root, "dist");
    return {
        root,
        hasHooks,
        qt: require(root),
        engine: require(path.join(dist, "native", "engine.js")),
        engineStats: require(path.join(dist, "native", "bridge.js")).engineStats,
        nativeSamples: require(path.join(dist, "native", "samples.js")),
        dist,
    };
}

/** The shipped package. */
export function shippedPackage() {
    return load(packageRoot, false);
}

/** The test-hooks package. */
export function hooksPackage() {
    if (!fs.existsSync(path.join(hooksPackageRoot, "dist", "native", "wasm", "glue.js"))) {
        throw new Error("no test-hooks package: run `node script/test-hooks.mjs` (npm test does) after `npm run build`");
    }
    return load(hooksPackageRoot, true);
}

/** The package this run is on. */
export function runPackage() {
    return onHooks ? hooksPackage() : shippedPackage();
}

/** A test that calls a test hook: on the test-hooks run only. */
export function hookTest(...args) {
    if (onHooks) test(...args);
}

/** A test that calls no test hook: on the shipped run only. */
export function shippedTest(...args) {
    if (!onHooks) test(...args);
}
