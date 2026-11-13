// The WebAssembly engine behind the facade: `**` exactly as V8 computes it,
// which runs go where, concurrency, and recovery from a trap.
//
//   node --test test/engine.test.mjs   (after `npm run build`)

import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const require = createRequire(import.meta.url);
const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const repositoryRoot = path.join(packageRoot, "..", "..");
const qt = require(packageRoot);
const { engineStats } = require(path.join(packageRoot, "dist", "native", "bridge.js"));
const engine = require(path.join(packageRoot, "dist", "native", "engine.js"));

const view = new DataView(new ArrayBuffer(8));
const fromHex = (hex) => {
    view.setBigUint64(0, BigInt(`0x${hex}`));
    return view.getFloat64(0);
};
const toHex = (x) => {
    view.setFloat64(0, x);
    return view.getBigUint64(0).toString(16).padStart(16, "0");
};

async function json(lang, samples) {
    const input = qt.jsonInputForTargetLanguage(lang);
    await input.addSource({ name: "TopLevel", samples });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return inputData;
}

test("** matches the vectors recorded from Node (js-compat harness)", () => {
    const glue = engine.engineSync();
    const vectors = JSON.parse(
        fs.readFileSync(path.join(repositoryRoot, "crates", "quicktype-js-compat", "tests", "vectors", "number.json"), "utf8"),
    ).pow;
    assert.ok(vectors.length > 2000);
    const mismatches = vectors.filter(([x, y, want]) => toHex(glue.__pow(fromHex(x), fromHex(y))) !== want);
    assert.deepEqual(mismatches, []);
});

test("** matches this Node's Math.pow on InferMaps-shaped inputs", () => {
    const glue = engine.engineSync();
    // MarkovChain.evaluate: probability ** (1 / length); InferMaps: 22 ** exponent.
    let seed = 12345;
    const random = () => {
        seed = (seed * 1103515245 + 12345) % 2147483648;
        return seed / 2147483648;
    };
    let mismatches = 0;
    for (let i = 0; i < 200_000; i++) {
        const x = i % 4 === 0 ? random() * 100 : random() ** (1 + (i % 20));
        const y = i % 4 === 0 ? (random() * 2000 - 1000) / 100 : 1 / (1 + (i % 60));
        if (!Object.is(glue.__pow(x, y), x ** y)) mismatches++;
    }

    assert.equal(mismatches, 0);
});

test("eligible runs use the WebAssembly engine, others the TypeScript engine", async () => {
    const before = { ...engineStats };
    await qt.quicktype({ lang: "rust", inputData: await json("rust", ['{"a": 1}']) });
    assert.equal(engineStats.wasm, before.wasm + 1);

    class Custom extends qt.RustTargetLanguage {}
    await qt.quicktype({ lang: new Custom(), inputData: await json("rust", ['{"a": 1}']) });
    assert.equal(engineStats.ts, before.ts + 1);

    // A built-in instance is fine; one whose names were changed is not.
    await qt.quicktype({ lang: new qt.RustTargetLanguage(), inputData: await json("rust", ['{"a": 1}']) });
    assert.equal(engineStats.wasm, before.wasm + 2);
});

test("the synchronous API uses the engine from the first call", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const input = qt.jsonInputForTargetLanguage("kotlin");
        input.addSourceSync({ name: "A", samples: ['{"when": "2020-01-01"}'] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        const result = qt.quicktypeMultiFileSync({ lang: "kotlin", inputData });
        console.log(JSON.stringify([engineStats, result.size]));
    `;
    const out = execFileSync(process.execPath, ["-e", script], { encoding: "utf8" });
    assert.deepEqual(JSON.parse(out), [{ wasm: 1, ts: 0 }, 1]);
});

test("QUICKTYPE_ENGINE=ts selects the TypeScript engine", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const input = qt.jsonInputForTargetLanguage("rust");
        input.addSourceSync({ name: "A", samples: ["[1]"] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        qt.quicktypeMultiFileSync({ lang: "rust", inputData });
        console.log(JSON.stringify(engineStats));
    `;
    const out = execFileSync(process.execPath, ["-e", script], {
        encoding: "utf8",
        env: { ...process.env, QUICKTYPE_ENGINE: "ts" },
    });
    assert.deepEqual(JSON.parse(out), { wasm: 0, ts: 1 });
});

test("concurrent runs with pending fetches don't interfere", async () => {
    const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
    const languages = ["typescript", "rust", "cs", "java", "kotlin", "php"];
    const run = async (i, mode) => {
        class Store extends qt.JSONSchemaStore {
            async fetch(address) {
                await delay((i * 7) % 13);
                if (address === "root.json") {
                    return { type: "object", properties: { [`p${i}`]: { $ref: "leaf.json" } } };
                }

                await delay((i * 5) % 11);
                return { type: "object", properties: { [`leaf${i}`]: { type: i % 2 === 0 ? "integer" : "string" } } };
            }
        }

        const input = new qt.JSONSchemaInput(new Store());
        await input.addSource({ name: `Root${i}`, uris: ["root.json"] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        // The engine is chosen when the run starts.
        globalThis[Symbol.for("quicktype-core.engine")] = mode;
        const promise = qt.quicktype({ lang: languages[i % languages.length], inputData });
        delete globalThis[Symbol.for("quicktype-core.engine")];
        return (await promise).lines.join("\n");
    };

    const n = 40;
    const expected = [];
    for (let i = 0; i < n; i++) expected.push(await run(i, "ts"));
    const before = engineStats.wasm;
    const actual = await Promise.all(Array.from({ length: n }, (_, i) => run(i, "wasm")));
    assert.equal(engineStats.wasm, before + n);
    assert.deepEqual(actual, expected);
});

test("an instance that trapped is replaced by a fresh one", async () => {
    const glue = engine.engineSync();
    assert.throws(() => glue.__panicForTests(), WebAssembly.RuntimeError);
    engine.discardEngine(glue);
    const result = await qt.quicktype({ lang: "rust", inputData: await json("rust", ['{"b": [true]}']) });
    assert.ok(result.lines.some((l) => l.includes("pub b: Vec<bool>")));
    assert.notEqual(engine.engineSync(), glue);
});
