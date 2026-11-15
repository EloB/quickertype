// The engine seeds every hash map and set from crypto.getRandomValues when
// an instance starts (quickertype-js-compat's `hash`, which quickertype-core
// re-exports as `support::fast_hash`): without it the engine does not load,
// and runs go to the TypeScript engine.
//
//   node --test test/seed.test.mjs   (after `npm run build`)
//
// Each case runs in a fresh Node process, so that the host's `crypto` can
// be changed before the engine loads.

import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import * as path from "node:path";
import { test } from "node:test";

import { hooksPackageRoot, packageRoot } from "./hooks.mjs";


/**
 * Runs `body` in a fresh Node process after `prelude` (which may replace
 * `crypto`), with the package at `root`'s `qt`, `engine` and `engineStats`
 * in scope and a `run()` that turns a small sample into Rust; returns what
 * `body` returns. `root` is this package, or the one with the test-hooks
 * engine (test/hooks.mjs) for a body that traps the instance or reads its
 * hashes.
 */
function inFreshNode(prelude, body, { env = {}, root = packageRoot } = {}) {
    const script = `
        ${prelude}
        const qt = require(${JSON.stringify(root)});
        const engine = require(${JSON.stringify(path.join(root, "dist", "native", "engine.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(root, "dist", "native", "bridge.js"))});
        const run = () => {
            const input = qt.jsonInputForTargetLanguage("rust");
            input.addSourceSync({ name: "A", samples: ['{"b": [true]}'] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            return qt.quicktypeMultiFileSync({ lang: "rust", inputData });
        };
        const result = (() => { ${body} })();
        console.log(JSON.stringify(result));
    `;
    return JSON.parse(execFileSync(process.execPath, ["-e", script], { encoding: "utf8", env: { ...process.env, ...env } }));
}

const noCrypto = 'Object.defineProperty(globalThis, "crypto", { configurable: true, value: undefined });';
const missing =
    "quickertype needs crypto.getRandomValues (the Web Crypto API) to seed its hash maps, and this JavaScript host does not have it";

test("without crypto.getRandomValues the engine does not load, and runs use TypeScript", () => {
    const [glue, error, files, stats] = inFreshNode(
        noCrypto,
        `const files = run().size;
         return [engine.engineSync() !== undefined, String(engine.engineLoadError()?.message), files, [engineStats.wasm, engineStats.ts]];`,
    );
    assert.equal(glue, false);
    assert.equal(error, missing);
    assert.equal(files, 1);
    assert.deepEqual(stats, [0, 1]);
});

test("without crypto.getRandomValues, QUICKTYPE_ENGINE=wasm makes runs throw", () => {
    const thrown = inFreshNode(
        noCrypto,
        `try { run(); return "no error"; } catch (e) { return String(e?.message); }`,
        { env: { QUICKTYPE_ENGINE: "wasm" } },
    );
    assert.equal(thrown, missing);
});

test("a crypto.getRandomValues that throws fails the load with what it threw", () => {
    const [error, stats] = inFreshNode(
        `Object.defineProperty(globalThis, "crypto", {
            configurable: true,
            value: { getRandomValues() { throw new TypeError("a broken polyfill"); } },
        });`,
        `run();
         return [String(engine.engineLoadError()?.message), [engineStats.wasm, engineStats.ts]];`,
    );
    assert.equal(error, "quickertype could not seed its hash maps: crypto.getRandomValues threw TypeError: a broken polyfill");
    assert.deepEqual(stats, [0, 1]);
});

/** A prelude that records how many bytes each `crypto.getRandomValues` call asks for. */
const recordCrypto = `const real = globalThis.crypto;
     globalThis.calls = [];
     Object.defineProperty(globalThis, "crypto", {
         configurable: true,
         value: { getRandomValues(array) { calls.push(array.length); return real.getRandomValues(array); } },
     });`;

test("each instance takes 16 bytes of crypto.getRandomValues as it starts, and only then", () => {
    // The shipped engine. What it asks for is recorded (and still random).
    // That the bytes become the maps' seeds is tested in Rust
    // (quicktype_js_compat::hash).
    const [afterLoad, afterRuns, stats] = inFreshNode(
        recordCrypto,
        `engine.engineSync();
         const afterLoad = [...calls];
         run();
         run();
         return [afterLoad, [...calls], [engineStats.wasm, engineStats.ts]];`,
    );
    assert.deepEqual(afterLoad, [16]);
    assert.deepEqual(afterRuns, [16]);
    assert.deepEqual(stats, [2, 0]);
});

test("the fresh instance after a trap takes 16 bytes of its own", () => {
    // The test-hooks package (test/hooks.mjs), whose `__panicForTests` traps
    // the instance; the facade's recovery makes a fresh one.
    const [afterTrap, stats] = inFreshNode(
        recordCrypto,
        `const glue = engine.engineSync();
         run();
         try { glue.__panicForTests(); } catch { engine.discardEngine(glue); }
         run();
         return [[...calls], [engineStats.wasm, engineStats.ts]];`,
        { root: hooksPackageRoot },
    );
    assert.deepEqual(afterTrap, [16, 16]);
    assert.deepEqual(stats, [2, 0]);
});

test("each instance hashes the keys of the maps inference fills differently", () => {
    // `__hashForTests` hashes a key in a new map of class properties (an
    // IndexMap whose keys are property names from the input). It is only
    // in the test-hooks engine (test/hooks.mjs), which the facade loads as
    // it loads the shipped one; package.test.mjs checks that the shipped
    // engine lacks it. Two instances that do the same make that map at the
    // same point of their maps' sequence, so with a fixed seed (as wasm32's
    // `std` RandomState was) they would give the same hash.
    const body = `const glue = engine.engineSync();
         run();
         const first = glue.__hashForTests("name");
         const second = glue.__hashForTests("name");
         // The facade's own recovery: the instance traps, the facade drops
         // it, and the next engineSync() makes a fresh one with createGlue.
         try { glue.__panicForTests(); } catch { engine.discardEngine(glue); }
         const fresh = engine.engineSync();
         run();
         return [first, second, fresh !== glue, fresh.__hashForTests("name"), [engineStats.wasm, engineStats.ts]];`;
    const [first, second, replaced, afterTrap, stats] = inFreshNode("", body, { root: hooksPackageRoot });
    const [other] = inFreshNode("", body, { root: hooksPackageRoot });
    assert.match(first, /^[0-9a-f]{16}$/);
    // A fresh instance through the facade's recovery path, and another
    // process, take seeds of their own.
    assert.equal(replaced, true);
    assert.deepEqual(stats, [2, 0]);
    assert.notEqual(first, afterTrap);
    assert.notEqual(first, other);
    // Each map has its own seed too.
    assert.notEqual(first, second);
});
