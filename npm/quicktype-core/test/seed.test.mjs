// The engine seeds its hash maps from crypto.getRandomValues when an
// instance starts (quickertype-core's `support::fast_hash`): without it the
// engine does not load, and runs go to the TypeScript engine.
//
//   node --test test/seed.test.mjs   (after `npm run build`)
//
// Each case runs in a fresh Node process, so that the host's `crypto` can
// be changed before the engine loads.

import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import * as path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");

/**
 * Runs `body` in a fresh Node process after `prelude` (which may replace
 * `crypto`), with `qt`, `engine` and `engineStats` in scope and a `run()`
 * that turns a small sample into Rust; returns what `body` returns.
 */
function inFreshNode(prelude, body, env = {}) {
    const script = `
        ${prelude}
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
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
    "quickertype-core needs crypto.getRandomValues (the Web Crypto API) to seed its hash maps, and this JavaScript host does not have it";

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
        { QUICKTYPE_ENGINE: "wasm" },
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
    assert.equal(error, "quickertype-core could not seed its hash maps: crypto.getRandomValues threw TypeError: a broken polyfill");
    assert.deepEqual(stats, [0, 1]);
});

test("each instance takes 16 bytes of crypto.getRandomValues as it starts, and only then", () => {
    // What the engine asks for is recorded (and still random). That the
    // bytes become the maps' seeds is tested in Rust (support::fast_hash).
    const [afterLoad, afterRuns, afterTrap, stats] = inFreshNode(
        `const real = globalThis.crypto;
         globalThis.calls = [];
         Object.defineProperty(globalThis, "crypto", {
             configurable: true,
             value: { getRandomValues(array) { calls.push(array.length); return real.getRandomValues(array); } },
         });`,
        `const glue = engine.engineSync();
         const afterLoad = [...calls];
         run();
         run();
         const afterRuns = [...calls];
         try { glue.__panicForTests(); } catch { engine.discardEngine(glue); }
         run();
         return [afterLoad, afterRuns, [...calls], [engineStats.wasm, engineStats.ts]];`,
    );
    assert.deepEqual(afterLoad, [16]);
    assert.deepEqual(afterRuns, [16]);
    assert.deepEqual(afterTrap, [16, 16]);
    assert.deepEqual(stats, [3, 0]);
});
