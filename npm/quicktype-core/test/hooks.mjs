// The package with the engine's test hooks (`__panicForTests`,
// `__hashForTests`, ...; script/test-hooks.mjs builds it, and `npm test`
// runs that first): the shipped facade, loading an engine built with
// quicktype-wasm's `test-hooks` feature exactly as it loads the shipped one.
// Tests that trap an instance, or read its counters, use it; the others
// use the shipped package.

import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const require = createRequire(import.meta.url);

/** The package's root, which `require` loads as the package itself. */
export const hooksPackageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..", "build", "test-hooks", "package");

/** The test-hooks package: its root and the facade's modules the tests use. */
export function hooksPackage() {
    const dist = path.join(hooksPackageRoot, "dist");
    if (!fs.existsSync(path.join(dist, "native", "wasm", "glue.js"))) {
        throw new Error("no test-hooks package: run `node script/test-hooks.mjs` (npm test does) after `npm run build`");
    }
    return {
        root: hooksPackageRoot,
        qt: require(hooksPackageRoot),
        engine: require(path.join(dist, "native", "engine.js")),
        engineStats: require(path.join(dist, "native", "bridge.js")).engineStats,
        nativeSamples: require(path.join(dist, "native", "samples.js")),
    };
}
