// JSON samples read by the WebAssembly engine as they are added
// (src/native/samples.ts): whatever can be observed of the inputs, their
// `CompressedJSON`s and the runs must be what TypeScript gives, whether
// the samples were read by the engine or by TypeScript.
//
//   node --test test/samples.test.mjs   (after `npm run build`)

import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { createRequire } from "node:module";
import * as path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const require = createRequire(import.meta.url);
const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const qt = require(packageRoot);
const { engineStats } = require(path.join(packageRoot, "dist", "native", "bridge.js"));
const engine = require(path.join(packageRoot, "dist", "native", "engine.js"));
const nativeSamples = require(path.join(packageRoot, "dist", "native", "samples.js"));
const { CompressedJSONFromString } = require(path.join(packageRoot, "dist", "input", "CompressedJSON.js"));
const { DefaultDateTimeRecognizer } = require(path.join(packageRoot, "dist", "DateTime.js"));

const engineKey = Symbol.for("quicktype-core.engine");

// Samples are read on the engine once it is compiled (by the first run
// that uses it, or by a large sample: see "the engine is compiled for a
// sample only if it is large"); here it is from the start.
engine.engineSync();

/** No run holds samples it did not take over or let go of. */
function noLeases() {
    assert.equal(engine.engineSync().__jsonLeases(), 0);
}

/** `f()` with the engine mode `mode` ("ts": TypeScript reads everything). */
async function inMode(mode, f) {
    if (mode === undefined) return f();
    globalThis[engineKey] = mode;
    try {
        return await f();
    } finally {
        delete globalThis[engineKey];
    }
}

/** What can be seen of an input without reading its tables. */
function outside(input) {
    return {
        topLevels: [...input._topLevels].map(([name, t]) => [name, t.description, [...t.samples]]),
        inputFields: Object.getOwnPropertyNames(input),
        fields: Object.getOwnPropertyNames(input._compressedJSON),
    };
}

/** Everything of an input, its tables included (which fills them). */
function inside(input) {
    const c = input._compressedJSON;
    const out = {
        ...outside(input),
        strings: [...c._strings],
        indexes: Object.getOwnPropertyNames(c._stringIndexes).map((k) => [k, c._stringIndexes[k]]),
        objects: c._objects.map((o) => [...o]),
        arrays: c._arrays.map((a) => [...a]),
        hash: c.hashCode(),
        fieldsAfter: Object.getOwnPropertyNames(c),
    };
    // Once the tables were read, even the descriptors are TypeScript's.
    out.descriptors = {};
    for (const name of ["_strings", "_stringIndexes", "_objects", "_arrays", "_ctx", "_rootValue"]) {
        const d = Object.getOwnPropertyDescriptor(c, name);
        out.descriptors[name] = d === undefined ? undefined : { ...d, value: typeof d.value };
    }

    return out;
}

const samples = {
    plain: ['{"id": 1, "name": "Ann", "tags": ["a", "b"], "nested": {"ok": true, "n": null}}'],
    formats: [
        '{"d": "2020-01-01", "t": "12:30:00", "dt": "2020-01-01T00:00:00Z", "u": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',
        '{"uri": "https://example.com/a.png", "i": "123", "b": "true", "long": "' + "x".repeat(80) + '"}',
    ],
    "duplicate keys": ['{"a": {"x": 1}, "b": [1, 2], "a": {"y": [2, {"z": 3}]}, "b": "s"}', '[{"k": 1, "k": 2, "k": {"k": 3}}]'],
    "array-index keys": ['{"b": 1, "2": {"q": 2}, "a": 3, "1": [4], "01": 5, "4294967295": 6, "4294967294": 7}'],
    "__proto__ keys": ['{"__proto__": 1, "__proto__": {"a": 2}, "b": {"__proto__": [3]}}', '{"__proto__": "x"}'],
    "big numbers": ['[9223372036854775807, 9223372036854775808, -9223372036854775808, -9223372036854775809, 1e21, 1e400, 123456789012345678901234567890]'],
    "-0 and doubles": ['[-0, 0, -0.0, 1.0, 1.5, 1e2, -1e-7, 2147483648, 4294967296]'],
    unicode: ['{"é": "ü", "😀": ["\\ud83d\\ude00", "\\u00e9"], "k\\u0065y": "a\\nb\\t\\"c\\""}'],
    "$ref": ['{"$ref": "#/definitions/a", "x": {"$ref": "http://example.com/s.json"}}'],
    scalars: ["1", "null", "true", "2.5", '"' + "y".repeat(70) + '"', '"short"', "[3]"],
    mixed: ['[{"a": 1}, {"a": "x", "b": null}, {"a": 2.5}]', '{"a": [[], {}], "b": [[1], {"c": []}]}', "[]", "{}"],
};

const languages = ["typescript", "rust", "kotlin", "swift", "cs"];

async function addAll(lang, groups, { handleRefs = false, rendererOptions = {}, sync = false } = {}) {
    const input = qt.jsonInputForTargetLanguage(lang, undefined, handleRefs, rendererOptions);
    for (const [name, list] of groups) {
        if (sync) input.addSourceSync({ name, samples: list, description: `${name} samples` });
        else await input.addSource({ name, samples: list });
    }

    return input;
}

test("samples are read by the engine, and the tables are TypeScript's once read", async () => {
    for (const lang of languages) {
        for (const [handleRefs, rendererOptions] of [
            [false, {}],
            [true, lang === "rust" ? { "integer-type": "force-i32" } : {}],
        ]) {
            const groups = Object.entries(samples);
            const expected = await inMode("ts", async () => inside(await addAll(lang, groups, { handleRefs, rendererOptions })));
            const before = { ...engineStats };
            const input = await addAll(lang, groups, { handleRefs, rendererOptions });
            // String roots are left to TypeScript, which then reads the rest.
            assert.ok(engineStats.samplesRead > before.samplesRead);
            assert.equal(engineStats.tablesFilled, before.tablesFilled + 1);
            assert.deepEqual(inside(input), expected, `${lang} ${handleRefs}`);

            // Without the string roots, everything is the engine's until read.
            const nonString = groups.filter(([name]) => name !== "scalars" && name !== "formats");
            const expected2 = await inMode("ts", async () => inside(await addAll(lang, nonString, { handleRefs, rendererOptions, sync: true })));
            const before2 = { ...engineStats };
            const input2 = await addAll(lang, nonString, { handleRefs, rendererOptions, sync: true });
            assert.equal(engineStats.samplesRead, before2.samplesRead + nonString.flatMap(([, l]) => l).length);
            assert.equal(engineStats.tablesFilled, before2.tablesFilled);
            assert.deepEqual(outside(input2), { topLevels: expected2.topLevels, inputFields: expected2.inputFields, fields: expected2.fieldsAfter });
            assert.deepEqual(inside(input2), expected2);
            assert.equal(engineStats.tablesFilled, before2.tablesFilled + 1);
        }
    }
});

async function run(input, lang, extra = {}) {
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return qt.quicktypeMultiFile({ lang, inputData, ...extra });
}

const plainGroups = Object.entries(samples).filter(([name]) => name !== "scalars" && name !== "formats");

test("runs use the engine's samples, as often as the input is used", async () => {
    for (const lang of languages) {
        const expected = await inMode("ts", async () => run(await addAll(lang, plainGroups), lang));
        const input = await addAll(lang, plainGroups);
        const before = { ...engineStats };
        const first = await run(input, lang);
        const second = await run(input, lang, { alphabetizeProperties: false });
        assert.deepEqual([...first], [...expected]);
        assert.deepEqual([...second], [...expected]);
        assert.equal(engineStats.tablesFilled, before.tablesFilled);
        assert.equal(engineStats.wasm, before.wasm + 2);

        const inputData = new qt.InputData();
        inputData.addInput(input);
        assert.deepEqual([...qt.quicktypeMultiFileSync({ lang, inputData })], [...expected]);
        assert.equal(engineStats.wasm, before.wasm + 3);

        // A run on the TypeScript engine reads the tables, which are then
        // filled, and later runs send them.
        const Custom = class extends Object.getPrototypeOf(qt.languageNamed(lang)).constructor {};
        const custom = await run(input, new Custom());
        const builtin = await inMode("ts", async () => run(await addAll(lang, plainGroups), new Custom()));
        assert.deepEqual([...custom], [...builtin]);
        assert.equal(engineStats.tablesFilled, before.tablesFilled + 1);
        assert.deepEqual([...(await run(input, lang))], [...expected]);
        assert.equal(engineStats.wasm, before.wasm + 4);
    }

    noLeases();
});

// A run holds the samples it was encoded with from then on, not from when
// it starts on the engine (after `engineAsync()` resolves): in between, a
// run on the TypeScript engine can fill the input's tables, which drops
// the engine's copy, and another input can be read into the engine.
const Custom = class extends Object.getPrototypeOf(qt.languageNamed("typescript")).constructor {};

test("a run keeps its samples while a run on TypeScript fills the tables", async () => {
    const attempt = async () => {
        const input = qt.jsonInputForTargetLanguage("typescript");
        await input.addSource({ name: "A", samples: ['{"a": [1, {"b": true}]}'] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        const pending = qt.quicktypeMultiFile({ lang: "typescript", inputData });
        const fallback = qt.quicktypeMultiFileSync({ lang: new Custom(), inputData });
        return { first: [...(await pending)], fallback: [...fallback], inside: inside(input) };
    };
    const expected = await inMode("ts", attempt);
    const before = { ...engineStats };
    assert.deepEqual(await attempt(), expected);
    assert.equal(engineStats.samplesRead, before.samplesRead + 1);
    assert.equal(engineStats.wasm, before.wasm + 1);
    noLeases();
});

test("a run keeps its samples when another input is read into the engine meanwhile", () => {
    // In a fresh process, so that the second input would take the first's
    // place in the engine (its slot) if ids were reused.
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const Custom = class extends Object.getPrototypeOf(qt.languageNamed("typescript")).constructor {};
        const glue = engine.engineSync();
        const attempt = async () => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "A", samples: ['{"a": [1, {"b": true}]}'] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            const pending = qt.quicktypeMultiFile({ lang: "typescript", inputData });
            qt.quicktypeMultiFileSync({ lang: new Custom(), inputData });
            // The same shape, other names: read into the engine, where the
            // first input's samples were until the run above filled its tables.
            const other = qt.jsonInputForTargetLanguage("typescript");
            other.addSourceSync({ name: "Other", samples: ['{"x": ["s", {"y": 2.5}]}'] });
            return [...(await pending)];
        };
        (async () => {
            const actual = await attempt().catch((e) => "error: " + e.message);
            const stats = [engineStats.samplesRead, engineStats.wasm, glue.__jsonLeases()];
            globalThis[Symbol.for("quicktype-core.engine")] = "ts";
            const expected = await attempt();
            console.log(JSON.stringify([actual, expected, stats]));
        })();
    `;
    const [actual, expected, stats] = JSON.parse(execFileSync(process.execPath, ["-e", script], { encoding: "utf8" }));
    assert.deepEqual(actual, expected);
    assert.deepEqual(stats, [2, 1, 0]);
});

test("the tables are TypeScript's, string for string", async () => {
    // `JSON.parse` keeps one of two "__proto__" members, and TypeScript
    // interns its key once; a sample that is not JSON interns nothing.
    for (const groups of [
        [["Proto", ['{"__proto__":1,"__proto__":2}']]],
        [["Proto", ['{"__proto__": {"__proto__": 1}, "x": {"__proto__": [2], "__proto__": 3}}']]],
        [
            ["Truncated", ['{"key1": [1, {"key2": ']],
            ["Valid", ['{"k": "v"}']],
        ],
        [["Formats", ['{"b": 1, "2": {"q": "date"}, "a": "2020-01-01", "1": [4], "b": "x", "u": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}']]],
    ]) {
        const attempt = async () => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            const errors = [];
            for (const [name, list] of groups) errors.push((await outcome(() => input.addSource({ name, samples: list }))).error);
            return { errors, inside: inside(input) };
        };
        const expected = await inMode("ts", attempt);
        const before = { ...engineStats };
        assert.deepEqual(await attempt(), expected, JSON.stringify(groups));
        assert.equal(engineStats.samplesRead, before.samplesRead + 1, JSON.stringify(groups));
        assert.equal(engineStats.tablesFilled, before.tablesFilled + 1);
    }
});

test("the engine is compiled for a sample only if it is large", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const add = (text) => qt.jsonInputForTargetLanguage("rust").addSourceSync({ name: "A", samples: [text] });
        const out = [];
        const note = () => out.push([engine.compileAttempts(), engineStats.samplesRead]);
        add('{"a": [1]}');
        note();
        if (process.argv[1] === "large") {
            add(JSON.stringify(Array.from({ length: 60000 }, (_, i) => ({ id: i, name: "n" + i }))));
            note();
        } else {
            // A run compiles it; from then on, samples are read there.
            const input = qt.jsonInputForTargetLanguage("rust");
            input.addSourceSync({ name: "A", samples: ['{"a": [1]}'] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            qt.quicktypeMultiFileSync({ lang: "rust", inputData });
            note();
        }
        add('{"b": [2]}');
        note();
        console.log(JSON.stringify(out));
    `;
    const run = (arg) => JSON.parse(execFileSync(process.execPath, ["-e", script, arg], { encoding: "utf8" }));
    assert.deepEqual(run("small"), [[0, 0], [1, 0], [1, 1]]);
    assert.deepEqual(run("large"), [[0, 0], [1, 1], [1, 2]]);
});

/** The outcome of `f`, its error as plain data. */
async function outcome(f) {
    try {
        return { ok: await f() };
    } catch (e) {
        return {
            error: {
                class: e.constructor.name,
                message: e.message,
                messageName: e.messageName,
                properties: e.properties,
            },
        };
    }
}

const invalid = [
    "",
    "[1,",
    '{"a": 1,}',
    "{'a': 1}",
    "01",
    "1.",
    '"abc',
    '"\\x"',
    "\u{feff}{}",
    "[1] x",
    "NaN",
    '{"a": [1, 2}',
    "x".repeat(100),
];

test("a sample that is not JSON fails in addSource, with V8's error", async () => {
    for (const bad of invalid) {
        for (const sync of [false, true]) {
            const attempt = async () => {
                const input = qt.jsonInputForTargetLanguage("rust");
                await input.addSource({ name: "Good", samples: ['{"a": [1]}'] });
                const add = { name: "Bad", samples: ['{"b": {"c": 2}}', bad, "[3]"], description: "D" };
                const failed = await outcome(async () => (sync ? input.addSourceSync(add) : input.addSource(add)));
                await input.addSource({ name: "After", samples: ['{"d": [{}]}'] });
                return { failed, state: inside(input), result: [...(await run(input, "rust"))] };
            };
            const expected = await inMode("ts", attempt);
            assert.ok(expected.failed.error !== undefined, bad);
            assert.deepEqual(await attempt(), expected, `${JSON.stringify(bad)} ${sync}`);
        }
    }
});

test("addSource settles after as many ticks as in TypeScript", async () => {
    const ticks = async (samples) => {
        const input = qt.jsonInputForTargetLanguage("typescript");
        let done = false;
        const settled = input.addSource({ name: "T", samples }).then(
            () => (done = "ok"),
            () => (done = "error"),
        );
        let n = 0;
        while (done === false && n < 1000) {
            await null;
            n++;
        }

        await settled;
        return [done, n];
    };
    for (const list of [["[1]"], ["[1]", '{"a": 2}', "3"], ["[1]", "[1,"], ['"s"', "[1]"]]) {
        assert.deepEqual(await ticks(list), await inMode("ts", () => ticks(list)), JSON.stringify(list));
    }
});

test("concurrent addSource calls on one input interleave as in TypeScript", async () => {
    const attempt = async () => {
        const input = qt.jsonInputForTargetLanguage("cs");
        await Promise.all([
            input.addSource({ name: "A", samples: ['{"a": {"x": 1}}', '[{"b": 2}]', '{"c": []}'] }),
            input.addSource({ name: "B", samples: ['[{"d": {}}]', '{"e": [[1]]}'] }),
            input.addSource({ name: "A", samples: ['{"f": 1}'] }),
        ]);
        return { outside: outside(input), result: [...(await run(input, "cs"))], inside: inside(input) };
    };
    assert.deepEqual(await attempt(), await inMode("ts", attempt));
});

test("samples TypeScript reads itself, and the samples after them", async () => {
    const deep = (n) => "[".repeat(n) + "]".repeat(n);
    const cases = [
        ["deeper than the engine reads", [deep(10), deep(257), deep(3)]],
        ["a string root", ["[1]", '"s"', "[2]"]],
        ["a lone surrogate escape", ["[1]", '["\\ud800"]', "[2]"]],
        ["a lone surrogate in the text", ["[1]", '["\ud800"]', "[2]"]],
    ];
    for (const [name, list] of cases) {
        const attempt = async () => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "T", samples: list });
            return { outside: outside(input), result: [...(await run(input, "typescript"))], inside: inside(input) };
        };
        const expected = await inMode("ts", attempt);
        const before = { ...engineStats };
        assert.deepEqual(await attempt(), expected, name);
        assert.equal(engineStats.samplesRead, before.samplesRead + 1, name);
        assert.equal(engineStats.tablesFilled, before.tablesFilled + 1, name);
    }

    // 256 levels deep is the engine's.
    const before = { ...engineStats };
    const input = qt.jsonInputForTargetLanguage("typescript");
    await input.addSource({ name: "T", samples: [deep(256)] });
    assert.equal(engineStats.samplesRead, before.samplesRead + 1);

    // Deeper than TypeScript's `process` gets: its RangeError, from addSource.
    const tooDeep = async () => outcome(() => qt.jsonInputForTargetLanguage("typescript").addSource({ name: "T", samples: [deep(200_000)] }));
    const expected = await inMode("ts", tooDeep);
    assert.match(expected.error.message, /Maximum call stack size exceeded/);
    assert.deepEqual(await tooDeep(), expected);
});

test("CompressedJSONs that are not quicktype's own are read by TypeScript", async () => {
    class Mine extends CompressedJSONFromString {}
    const before = { ...engineStats };
    const input = new qt.JSONInput(new Mine(new DefaultDateTimeRecognizer(), false));
    await input.addSource({ name: "A", samples: ["[1]"] });
    const replaced = new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false);
    replaced.commitString = function (s) {
        return CompressedJSONFromString.prototype.commitString.call(this, s);
    };
    await new qt.JSONInput(replaced).addSource({ name: "B", samples: ['["x"]'] });
    assert.equal(engineStats.samplesRead, before.samplesRead);

    // Tables TypeScript filled first stay TypeScript's.
    const shared = new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false);
    await inMode("ts", () => new qt.JSONInput(shared).addSource({ name: "C", samples: ['{"a": 1}'] }));
    await new qt.JSONInput(shared).addSource({ name: "D", samples: ['{"b": 2}'] });
    assert.equal(engineStats.samplesRead, before.samplesRead);
    assert.deepEqual(shared._strings, ["a", "b"]);

    // A CompressedJSON of the user's, shared by two inputs: the tables are
    // the same as TypeScript's, through either input and directly.
    const attempt = async () => {
        const cjson = new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false);
        const one = new qt.JSONInput(cjson);
        const two = new qt.JSONInput(cjson);
        await one.addSource({ name: "One", samples: ['{"a": [1]}'] });
        two.addSourceSync({ name: "Two", samples: ['[{"a": "b"}]'] });
        const value = cjson.parseSync('{"c": {"d": 1}}');
        return { value, one: inside(one), two: inside(two), object: cjson.getObjectForValue(value) };
    };
    assert.deepEqual(await attempt(), await inMode("ts", attempt));
});

test("a configuration changed between samples reads each sample with its own", async () => {
    const attempt = async () => {
        const input = qt.jsonInputForTargetLanguage("typescript");
        const cjson = input._compressedJSON;
        await input.addSource({ name: "A", samples: ['[2147483648, {"$ref": "#/x"}]'] });
        cjson.supportedIntegerRange = { min: "-2147483648", max: "2147483647" };
        cjson.handleRefs = true;
        await input.addSource({ name: "B", samples: ['[2147483648, {"$ref": "#/x"}]'] });
        return { inside: inside(input), result: await outcome(async () => [...(await run(input, "typescript"))]) };
    };
    assert.deepEqual(await attempt(), await inMode("ts", attempt));
});

test("many small samples", async () => {
    const list = Array.from({ length: 3000 }, (_, i) => `{"id": ${i}, "v${i % 7}": [${i % 3 === 0 ? "1.5" : i}], "s": "${"ab".repeat(i % 5)}"}`);
    const attempt = async () => {
        const input = qt.jsonInputForTargetLanguage("go");
        await input.addSource({ name: "Many", samples: list });
        input.addSourceSync({ name: "More", samples: list.slice(0, 500) });
        return { outside: outside(input), result: [...(await run(input, "go"))], inside: inside(input) };
    };
    const before = { ...engineStats };
    assert.deepEqual(await attempt(), await inMode("ts", attempt));
    assert.equal(engineStats.samplesRead, before.samplesRead + 3500);
});

test("a sample added while a run uses the input is read by TypeScript", async () => {
    const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
    const attempt = async () => {
        class Store extends qt.JSONSchemaStore {
            async fetch() {
                await delay(20);
                return { type: "object", properties: { s: { type: "string" } } };
            }
        }

        const json = qt.jsonInputForTargetLanguage("rust");
        await json.addSource({ name: "J", samples: ['{"a": [1, 2]}'] });
        const schema = new qt.JSONSchemaInput(new Store());
        await schema.addSource({ name: "S", uris: ["s.json"] });
        const inputData = new qt.InputData();
        inputData.addInput(json);
        inputData.addInput(schema);
        const first = qt.quicktypeMultiFile({ lang: "rust", inputData });
        await delay(5);
        json.addSourceSync({ name: "J2", samples: ['{"b": {"c": true}}'] });
        const results = [[...(await first)]];
        results.push([...(await qt.quicktypeMultiFile({ lang: "rust", inputData }))]);
        return { results, inside: inside(json) };
    };
    const expected = await inMode("ts", attempt);
    const before = { ...engineStats };
    assert.deepEqual(await attempt(), expected);
    assert.equal(engineStats.wasm, before.wasm + 2);
    assert.equal(engineStats.tablesFilled, before.tablesFilled + 1);
});

test("samples read by an instance that failed are read again by TypeScript", async () => {
    const input = await addAll("rust", plainGroups);
    const expected = await inMode("ts", async () => run(await addAll("rust", plainGroups), "rust"));
    const glue = engine.engineSync();
    assert.throws(() => glue.__panicForTests(), WebAssembly.RuntimeError);
    engine.discardEngine(glue);
    const before = { ...engineStats };
    assert.deepEqual([...(await run(input, "rust"))], [...expected]);
    assert.equal(engineStats.tablesFilled, before.tablesFilled + 1);
    assert.equal(engineStats.wasm, before.wasm + 1);
});

test("the samples of a large input are taken from an instance that failed", async () => {
    // A large input's samples are not kept: here, every input is large.
    const old = nativeSamples.setKeptTexts(0);
    try {
        const expected = await inMode("ts", async () => inside(await addAll("rust", plainGroups)));
        const input = await addAll("rust", plainGroups);
        const glue = engine.engineSync();
        assert.throws(() => glue.__panicForTests(), WebAssembly.RuntimeError);
        engine.discardEngine(glue);
        assert.deepEqual(inside(input), expected);

        // Should even that fail, the tables cannot be had, and every use of
        // them says so.
        const lost = await addAll("rust", plainGroups);
        const failing = engine.engineSync();
        failing.jsonExport = () => {
            throw new Error("unreadable");
        };
        engine.discardEngine(failing);
        assert.throws(() => lost._compressedJSON._strings, /samples of this input were lost/);
        await assert.rejects(run(lost, "rust"), /samples of this input were lost/);
    } finally {
        nativeSamples.setKeptTexts(old);
    }
});

test("the engine drops the samples of inputs that are gone", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const keep = [];
        function add(n) {
            for (let i = 0; i < n; i++) {
                const input = qt.jsonInputForTargetLanguage("rust");
                input.addSourceSync({ name: "A", samples: ['{"a": [' + i + ']}'] });
                if (i % 10 === 0) keep.push(input);
            }
        }
        (async () => {
            const glue = engine.engineSync();
            add(30);
            const before = glue.__jsonCount();
            for (let i = 0; i < 100 && glue.__jsonCount() > keep.length; i++) {
                global.gc();
                await new Promise((resolve) => setTimeout(resolve, 10));
            }
            const collected = glue.__jsonCount();
            // Filling the tables drops the engine's copy at once.
            void keep[0]._compressedJSON._strings;
            console.log(JSON.stringify([before, collected, glue.__jsonCount()]));
        })();
    `;
    const out = execFileSync(process.execPath, ["--expose-gc", "-e", script], { encoding: "utf8" });
    assert.deepEqual(JSON.parse(out), [30, 3, 2]);
});
