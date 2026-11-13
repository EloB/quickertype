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

// With `js-host-math` the engine's `**` is the host's Math.pow, so it must
// equal this Node's result on every vector. The vectors were recorded with
// Node on macOS arm64; other Node builds differ on a few of them (the sign
// of NaN on x64, the last bit of some hard cases on Linux), so the recorded
// values are only checked on the platform they were recorded on.
test("** is this Node's Math.pow on the js-compat vectors", () => {
    const glue = engine.engineSync();
    const vectors = JSON.parse(
        fs.readFileSync(path.join(repositoryRoot, "crates", "quicktype-js-compat", "tests", "vectors", "number.json"), "utf8"),
    ).pow;
    assert.ok(vectors.length > 2000);
    const mismatches = vectors.filter(([x, y]) => {
        const [a, b] = [fromHex(x), fromHex(y)];
        return !Object.is(glue.__pow(a, b), Math.pow(a, b));
    });
    assert.deepEqual(mismatches, []);
    if (process.platform === "darwin" && process.arch === "arm64") {
        const unlikeRecording = vectors.filter(([x, y, want]) => toHex(glue.__pow(fromHex(x), fromHex(y))) !== want);
        assert.deepEqual(unlikeRecording, []);
    }
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
        console.log(JSON.stringify([engineStats.wasm, engineStats.ts, result.size]));
    `;
    const out = execFileSync(process.execPath, ["-e", script], { encoding: "utf8" });
    assert.deepEqual(JSON.parse(out), [1, 0, 1]);
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
        console.log(JSON.stringify([engineStats.wasm, engineStats.ts]));
    `;
    const out = execFileSync(process.execPath, ["-e", script], {
        encoding: "utf8",
        env: { ...process.env, QUICKTYPE_ENGINE: "ts" },
    });
    assert.deepEqual(JSON.parse(out), [0, 1]);
});

test("languages the engine lacks fall back to TypeScript, never to an error", async (t) => {
    const glue = engine.engineSync();
    const lacking = qt.defaultTargetLanguages.filter((l) => !glue.supportsLanguage(l.name));
    assert.ok(qt.defaultTargetLanguages.some((l) => glue.supportsLanguage(l.name)));
    assert.equal(glue.supportsLanguage("cobol"), false);
    if (lacking.length === 0) {
        t.skip("every renderer is ported");
        return;
    }

    for (const lang of lacking) {
        const run = async (mode) => {
            globalThis[Symbol.for("quicktype-core.engine")] = mode;
            try {
                const inputData = await json(lang.name, ['{"a": [1, 2.5], "b": "x"}']);
                return await qt.quicktypeMultiFile({ lang: lang.name, inputData });
            } finally {
                delete globalThis[Symbol.for("quicktype-core.engine")];
            }
        };
        const expected = await run("ts");
        const before = { ...engineStats, unsupportedBy: { ...engineStats.unsupportedBy } };
        // Even with QUICKTYPE_ENGINE=wasm, which only makes loading failures errors.
        const actual = await run("wasm");
        assert.deepEqual([...actual], [...expected]);
        assert.equal(engineStats.unsupported, before.unsupported + 1);
        assert.equal(engineStats.wasm, before.wasm);
        const feature = `${lang.displayName} renderer`;
        assert.equal(engineStats.unsupportedBy[feature], (before.unsupportedBy[feature] ?? 0) + 1);

        const input = qt.jsonInputForTargetLanguage(lang.name);
        input.addSourceSync({ name: "S", samples: ["[true]"] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        qt.quicktypeMultiFileSync({ lang: lang.name, inputData });
        assert.equal(engineStats.unsupported, before.unsupported + 2);
    }
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

// ---- Failures and resources (code review findings) --------------------------

const tsMode = async (f) => {
    globalThis[Symbol.for("quicktype-core.engine")] = "ts";
    try {
        return await f();
    } finally {
        delete globalThis[Symbol.for("quicktype-core.engine")];
    }
};

async function trappingRun(lang) {
    // onTiming makes the instance trap while the run is being polled, as a
    // nested run that panicked would.
    let trapped = false;
    const inputData = await json(lang, ['{"a": [1, 2.5], "b": {"c": "x"}}']);
    return qt.quicktypeMultiFile({
        lang,
        inputData,
        onTiming: (t) => {
            if (trapped || t.name !== "flatten unions") return;
            trapped = true;
            const glue = engine.engineSync();
            try {
                glue.__panicForTests();
            } catch {
                engine.discardEngine(glue);
            }
        },
    });
}

test("a run whose instance traps is redone on TypeScript, never continued", async () => {
    const expected = await tsMode(() => trappingRun("rust"));
    const before = { ...engineStats };
    const actual = await trappingRun("rust");
    assert.deepEqual([...actual], [...expected]);
    assert.equal(engineStats.rerun, before.rerun + 1);
    assert.equal(engineStats.wasm, before.wasm);
});

test("other runs in flight on a trapping instance are redone too", async () => {
    const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
    const schemaRun = async () => {
        class Store extends qt.JSONSchemaStore {
            async fetch(address) {
                await delay(30);
                return address === "a.json"
                    ? { type: "object", properties: { b: { $ref: "b.json" } } }
                    : { type: "object", properties: { n: { type: "integer" } } };
            }
        }

        const input = new qt.JSONSchemaInput(new Store());
        await input.addSource({ name: "A", uris: ["a.json"] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        return qt.quicktypeMultiFile({ lang: "kotlin", inputData });
    };
    const expected = await tsMode(schemaRun);
    const before = { ...engineStats };
    const pending = schemaRun();
    await delay(5);
    await trappingRun("typescript");
    assert.deepEqual([...(await pending)], [...expected]);
    assert.equal(engineStats.rerun, before.rerun + 2);
});

test("documents are flattened once per run, however often they are fetched", async () => {
    const definitions = {};
    for (let i = 0; i < 500; i++) definitions[`D${i}`] = { type: "object", properties: { v: { type: "integer" } } };
    const documents = { "big.json": { definitions } };
    const properties = {};
    for (let i = 0; i < 60; i++) {
        documents[`s${i}.json`] = { type: "object", properties: { x: { $ref: `big.json#/definitions/D${i}` } } };
        properties[`p${i}`] = { $ref: `s${i}.json` };
    }

    documents["root.json"] = { type: "object", properties };
    let gets = 0;
    class Store extends qt.JSONSchemaStore {
        async fetch(address) {
            return documents[address];
        }

        async get(address, debugPrint) {
            gets++;
            return super.get(address, debugPrint);
        }
    }

    const input = new qt.JSONSchemaInput(new Store());
    await input.addSource({ name: "Root", uris: ["root.json"] });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    const before = engineStats.documentsEncoded;
    await qt.quicktypeMultiFile({ lang: "typescript", inputData });
    assert.ok(gets > 100, `${gets} gets`);
    assert.equal(engineStats.documentsEncoded - before, Object.keys(documents).length);
});

test("a run nobody waits for any more is dropped by the engine", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        (async () => {
            const start = async () => {
                class Never extends qt.JSONSchemaStore {
                    fetch() { return new Promise(() => {}); }
                }
                const input = new qt.JSONSchemaInput(new Never());
                await input.addSource({ name: "N", uris: ["n.json"] });
                const inputData = new qt.InputData();
                inputData.addInput(input);
                qt.quicktypeMultiFile({ lang: "typescript", inputData });
            };
            for (let i = 0; i < 5; i++) await start();
            await new Promise((resolve) => setTimeout(resolve, 20));
            const glue = engine.engineSync();
            const before = glue.__pendingRuns();
            for (let i = 0; i < 20 && glue.__pendingRuns() > 0; i++) {
                global.gc();
                await new Promise((resolve) => setTimeout(resolve, 20));
            }
            console.log(JSON.stringify([before, glue.__pendingRuns()]));
        })();
    `;
    const out = execFileSync(process.execPath, ["--expose-gc", "-e", script], { encoding: "utf8" });
    assert.deepEqual(JSON.parse(out), [5, 0]);
});

test("a module that fails to compile is not compiled again on every run", () => {
    const script = `
        globalThis[Symbol.for("quicktype-core.wasmModule")] = new Uint8Array([0, 1, 2, 3]);
        const qt = require(${JSON.stringify(packageRoot)});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        for (let i = 0; i < 3; i++) {
            const input = qt.jsonInputForTargetLanguage("rust");
            input.addSourceSync({ name: "A", samples: ["[1]"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            qt.quicktypeMultiFileSync({ lang: "rust", inputData });
        }
        console.log(JSON.stringify([engine.compileAttempts(), engineStats.wasm, engineStats.ts]));
    `;
    const out = execFileSync(process.execPath, ["-e", script], { encoding: "utf8" });
    assert.deepEqual(JSON.parse(out), [1, 0, 3]);
});

test("a module that is not the engine is instantiated once, not on every run", () => {
    // The smallest valid module: it compiles and instantiates, but has none
    // of the engine's exports. That is a load failure (the TypeScript engine
    // runs), not an engine failure in each run (a rerun).
    const script = `
        globalThis[Symbol.for("quicktype-core.wasmModule")] = new Uint8Array([0, 0x61, 0x73, 0x6d, 1, 0, 0, 0]);
        const qt = require(${JSON.stringify(packageRoot)});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const outputs = [];
        for (let i = 0; i < 3; i++) {
            const input = qt.jsonInputForTargetLanguage("rust");
            input.addSourceSync({ name: "A", samples: ["[1]"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            outputs.push(qt.quicktypeMultiFileSync({ lang: "rust", inputData }).get("stdout").lines.length > 0);
        }
        console.log(JSON.stringify([
            engine.compileAttempts(),
            engine.instantiateAttempts(),
            engineStats.wasm,
            engineStats.ts,
            engineStats.rerun,
            engine.engineLoadError() !== undefined,
            outputs,
        ]));
    `;
    const out = execFileSync(process.execPath, ["-e", script], { encoding: "utf8" });
    assert.deepEqual(JSON.parse(out), [1, 1, 0, 3, 0, true, [true, true, true]]);
});


// ---- Large outputs ------------------------------------------------------------

/** A JSON sample of `n` distinct classes of eight properties each. */
function manyClasses(n) {
    const words = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliet"];
    const sample = {};
    for (let i = 0; i < n; i++) {
        const properties = {};
        for (let j = 0; j < 8; j++) {
            properties[`${words[j]}${words[(i + j) % 10]}${i}`] = j % 3 === 0 ? "text" : j % 3 === 1 ? i : [true];
        }

        sample[`record${words[i % 10]}${i}`] = properties;
    }

    return JSON.stringify(sample);
}

// Rust's wasm32 allocator grew the memory 64 KiB at a time, and each
// `memory.grow` costs V8 about half a millisecond (more past 2 GiB): runs
// with outputs of millions of lines spent most of their time growing the
// memory, more than linearly in the output's size (an 8-million-line PHP
// file took 726 s against TypeScript's 126 s). The engine's allocator now
// grows the memory geometrically (crates/quicktype-wasm/src/allocator.rs).
test("a run with a large output grows the engine's memory a few times", { timeout: 300_000 }, async () => {
    const options = { lang: "php", inferMaps: false, rendererOptions: { "with-get": true, "with-set": true } };
    const run = () => {
        const input = qt.jsonInputForTargetLanguage("php");
        input.addSourceSync({ name: "Big", samples: [manyClasses(800)] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        return qt.quicktypeMultiFileSync({ ...options, inputData });
    };
    const glue = engine.engineSync();
    const before = glue.__memoryGrowths();
    const pagesBefore = glue.__memoryPages();
    const runsBefore = engineStats.wasm;
    const actual = run();
    assert.equal(engineStats.wasm, runsBefore + 1);
    const lines = [...actual.values()].reduce((n, f) => n + f.lines.length, 0);
    assert.ok(lines > 500_000, `${lines} lines`);
    // Some 200 MB of memory, several times what the instance had. Each
    // time an allocation grows the memory, growing ahead adds a quarter of
    // it (at least a fifth, after what the top of the heap had free): at
    // most two `memory.grow` calls per step, and a step at least 1.2 times
    // the memory before. So a few dozen growths, where 64 KiB steps take
    // thousands (one per page).
    const growths = glue.__memoryGrowths() - before;
    const ratio = glue.__memoryPages() / pagesBefore;
    assert.ok(ratio > 4, `the memory grew ${ratio} times over`);
    const bound = 2 * Math.ceil(Math.log(ratio) / Math.log(1.2));
    assert.ok(growths <= bound, `the memory grew ${growths} times (at most ${bound})`);
    const expected = await tsMode(() => run());
    assert.deepEqual([...actual], [...expected]);
});
