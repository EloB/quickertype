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

import { generateJson } from "./bench/generate.mjs";

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

// The engine's read stands in for the methods TypeScript's read calls, and
// its date/time recognizers for the built-in ones. A method replaced on the
// instance or on a prototype (before the first sample, or between samples)
// leaves the samples from then on to TypeScript, which calls it.

/** `f()` with `object[name]` set to `value`, and as it was again after. */
async function patched(object, name, value, f) {
    const own = Object.getOwnPropertyDescriptor(object, name);
    object[name] = value;
    try {
        return await f();
    } finally {
        if (own === undefined) delete object[name];
        else Object.defineProperty(object, name, own);
    }
}

test("a date/time recognizer with a method replaced is TypeScript's", async () => {
    const dates = ['{"d": "2020-01-01", "t": "12:30:00Z", "dt": "2020-01-01T00:00:00Z"}', '[{"d": "2021-02-03", "e": "x"}]'];
    const notDate = () => false;
    for (const lang of ["typescript", "kotlin"]) {
        const attempt = async (onInstance) => {
            const input = qt.jsonInputForTargetLanguage(lang);
            if (onInstance) input._compressedJSON.dateTimeRecognizer.isDate = notDate;
            await input.addSource({ name: "Dates", samples: dates });
            return { result: [...(await run(input, lang))], inside: inside(input) };
        };
        const unpatched = await inMode("ts", () => attempt(false));
        const proto = Object.getPrototypeOf(qt.languageNamed(lang).dateTimeRecognizer);
        const cases = [
            ["on the instance", (f) => f(true)],
            ["on its class's prototype", (f) => patched(proto, "isDate", notDate, () => f(false))],
            // Kotlin's `isDate` calls DefaultDateTimeRecognizer's (`super`).
            ["on DefaultDateTimeRecognizer's prototype", (f) => patched(DefaultDateTimeRecognizer.prototype, "isDate", notDate, () => f(false))],
        ];
        for (const [name, withPatch] of cases) {
            const expected = await withPatch((onInstance) => inMode("ts", () => attempt(onInstance)));
            assert.notDeepEqual(expected, unpatched, `${lang}, ${name}: the patch changes the tables`);
            const before = { ...engineStats };
            assert.deepEqual(await withPatch(attempt), expected, `${lang}, ${name}`);
            assert.equal(engineStats.samplesRead, before.samplesRead, `${lang}, ${name}`);
        }
    }

    // Unpatched again, the engine reads them.
    const before = { ...engineStats };
    await addAll("kotlin", [["Dates", dates]]);
    assert.equal(engineStats.samplesRead, before.samplesRead + dates.length);
});

test("CompressedJSONFromString methods replaced on a prototype or the instance are TypeScript's", async () => {
    const CompressedJSONPrototype = Object.getPrototypeOf(CompressedJSONFromString.prototype);
    const samples = ['{"a": "x", "n": 1, "list": [2, "y", [3, 4]]}', '[{"a": "z", "n": 5, "m": [6, "w"]}, 7]'];
    const cases = [
        // Shadows CompressedJSON's.
        [
            "commitString on CompressedJSONFromString's prototype",
            (_, f) =>
                patched(CompressedJSONFromString.prototype, "commitString", function () {
                    this.commitNumber(false);
                }, f),
        ],
        ["parsedNumberIsDouble on CompressedJSON's prototype", (_, f) => patched(CompressedJSONPrototype, "parsedNumberIsDouble", () => true, f)],
        [
            "internArray on the instance",
            (cjson, f) => {
                const original = cjson.internArray;
                cjson.internArray = (arr) => original([...arr].reverse());
                return f();
            },
        ],
    ];
    // The samples from `from` on are added with the patch.
    const attempt = async (patch, from) => {
        const input = qt.jsonInputForTargetLanguage("rust");
        for (const [i, sample] of samples.entries()) {
            const add = () => input.addSource({ name: `S${i}`, samples: [sample] });
            await (i >= from ? patch(input._compressedJSON, add) : add());
        }

        return { result: [...(await run(input, "rust"))], inside: inside(input) };
    };
    const unpatched = await inMode("ts", () => attempt(undefined, samples.length));
    for (const [name, patch] of cases) {
        for (const from of [0, 1]) {
            const expected = await inMode("ts", () => attempt(patch, from));
            assert.notDeepEqual(expected, unpatched, `${name}, from ${from}: the patch changes the tables`);
            const before = { ...engineStats };
            assert.deepEqual(await attempt(patch, from), expected, `${name}, from ${from}`);
            // The samples before the patch are the engine's, the others TypeScript's.
            assert.equal(engineStats.samplesRead, before.samplesRead + from, `${name}, from ${from}`);
        }
    }

    // Unpatched again, the engine reads them.
    const before = { ...engineStats };
    await addAll("rust", [["S", samples]]);
    assert.equal(engineStats.samplesRead, before.samplesRead + samples.length);
});

// The engine checks the methods and accessors TypeScript's read calls by
// name (src/native/samples.ts, `readMethods`): each one, wrapped, leaves
// the sample to TypeScript, and the others are not part of the read. A
// method upstream adds fails this until it is in one list or the other.
test("every method TypeScript's read calls is the original", async () => {
    const notRead = ["equals", "getStringForValue", "getStringFormatTypeKind", "hashCode", "parse", "parseSync"];
    const readByEngine = new Set();
    let wrapped = 0;
    for (const proto of [CompressedJSONFromString.prototype, Object.getPrototypeOf(CompressedJSONFromString.prototype)]) {
        for (const name of Object.getOwnPropertyNames(proto)) {
            if (name === "constructor") continue;
            const original = Object.getOwnPropertyDescriptor(proto, name);
            const wrapper =
                "value" in original
                    ? {
                          ...original,
                          value: function (...args) {
                              return original.value.apply(this, args);
                          },
                      }
                    : {
                          ...original,
                          get() {
                              return original.get.call(this);
                          },
                      };
            Object.defineProperty(proto, name, wrapper);
            wrapped++;
            try {
                const before = engineStats.samplesRead;
                await addAll("rust", [["S", ['{"a": [1, "x"], "$ref": "#/y"}']]], { handleRefs: true });
                if (engineStats.samplesRead > before) readByEngine.add(name);
            } finally {
                Object.defineProperty(proto, name, original);
            }
        }
    }

    assert.ok(wrapped > 25, `${wrapped} methods`);
    assert.deepEqual([...readByEngine].sort(), notRead);
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
        const filled = engineStats.tablesFilled;
        assert.throws(() => lost._compressedJSON._strings, /samples of this input were lost/);
        await assert.rejects(run(lost, "rust"), /samples of this input were lost/);
        // Tables that could not be filled are not counted as filled.
        assert.equal(engineStats.tablesFilled, filled);
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

// A run keeps the tallies it made of an input's form with the form, for the
// next run over the same samples; the engine counts them in the form's
// bytes, which the facade takes up after the run, and the next sample read
// into the form drops them. Every run gives what TypeScript gives.
test("a run's tallies are kept with the form, counted, and dropped by the next sample", async () => {
    const glue = engine.engineSync();
    const text = generateJson(300, 4_242);
    const more = generateJson(30, 4_243);
    const runSync = (input, lang) => {
        const inputData = new qt.InputData();
        inputData.addInput(input);
        return [...qt.quicktypeMultiFileSync({ lang, inputData })];
    };
    const expected = await inMode("ts", async () => {
        const input = await addAll("go", [["Big", [text]]]);
        const first = [...(await run(input, "go"))];
        const rust = [...(await run(input, "rust"))];
        await input.addSource({ name: "Big", samples: [more] });
        return { first, rust, after: runSync(input, "go"), again: runSync(input, "swift") };
    });
    const input = await addAll("go", [["Big", [text]]]);
    const cjson = input._compressedJSON;
    const read = nativeSamples.formBytes(cjson);
    assert.deepEqual([...(await run(input, "go"))], expected.first);
    const kept = nativeSamples.formBytes(cjson);
    assert.ok(kept > read, `${kept} against ${read}`);
    // Another language, from the kept tallies: nothing more is held.
    assert.deepEqual([...(await run(input, "rust"))], expected.rust);
    assert.equal(nativeSamples.formBytes(cjson), kept);
    // A sample read into the form drops them.
    await input.addSource({ name: "Big", samples: [more] });
    const after = nativeSamples.formBytes(cjson);
    assert.ok(after < kept, `${after} against ${kept}`);
    // What the engine holds grows by the tallies a run keeps, as the facade
    // counts them (synchronous, so no finalizer drops another form between).
    let held = glue.jsonHeld();
    assert.deepEqual(runSync(input, "go"), expected.after);
    const keptAfter = nativeSamples.formBytes(cjson);
    assert.ok(keptAfter > after, `${keptAfter} against ${after}`);
    assert.equal(glue.jsonHeld() - held, keptAfter - after);
    held = glue.jsonHeld();
    assert.deepEqual(runSync(input, "swift"), expected.again);
    assert.equal(glue.jsonHeld(), held);
    assert.equal(nativeSamples.formBytes(cjson), keptAfter);
    // Filling the tables drops the form in the engine, tallies and all.
    assert.equal(cjson._strings.length > 0, true);
    assert.equal(nativeSamples.formBytes(cjson), undefined);
    assert.equal(held - glue.jsonHeld(), keptAfter);
    noLeases();
});

// A run over two inputs (two forms) takes up both forms' new bytes before
// it keeps the others within the limit, with both forms the ones in use:
// one form's new tallies must not be counted against the other, nor
// either be evicted for the other's.
test("a run over two forms counts both before it evicts, and keeps both", async () => {
    const glue = engine.engineSync();
    const texts = [generateJson(200, 4_250), generateJson(200, 4_251)];
    const both = (inputs) => {
        const inputData = new qt.InputData();
        for (const input of inputs) inputData.addInput(input);
        return inputData;
    };
    const expected = await inMode("ts", async () => {
        const inputs = [await addAll("go", [["A", [texts[0]]]]), await addAll("go", [["B", [texts[1]]]])];
        return [...(await qt.quicktypeMultiFile({ lang: "go", inputData: both(inputs) }))];
    });
    const inputs = [await addAll("go", [["A", [texts[0]]]]), await addAll("go", [["B", [texts[1]]]])];
    const read = inputs.map((input) => nativeSamples.formBytes(input._compressedJSON));
    assert.ok(read.every((bytes) => bytes !== undefined));
    // A limit past which any form but the run's two is evicted.
    const old = nativeSamples.setHeldLimit(1);
    try {
        const before = { ...engineStats };
        assert.deepEqual([...(await qt.quicktypeMultiFile({ lang: "go", inputData: both(inputs) }))], expected);
        assert.equal(engineStats.wasm, before.wasm + 1);
        const after = inputs.map((input) => nativeSamples.formBytes(input._compressedJSON));
        assert.ok(after[0] > read[0] && after[1] > read[1], `${after} against ${read}`);
        // Nothing else is held, and the counts agree with the engine's.
        assert.equal(glue.jsonHeld(), after[0] + after[1]);
        // From the kept tallies, the same again.
        assert.deepEqual([...(await qt.quicktypeMultiFileSync({ lang: "go", inputData: both(inputs) }))], expected);
        assert.deepEqual(
            inputs.map((input) => nativeSamples.formBytes(input._compressedJSON)),
            after,
        );
        assert.equal(engineStats.tablesFilled, before.tablesFilled);
    } finally {
        nativeSamples.setHeldLimit(old);
    }

    for (const input of inputs) assert.ok(input._compressedJSON._strings.length > 0);
    noLeases();
});

// ---- Memory and limits (the second code review) ------------------------------

// The garbage collector does not see the engine's memory, which never
// shrinks: a long-running process that keeps its inputs, or whose inputs
// are not collected yet, must not make the engine grow without bound. Past
// the limit, the least recently used compressed forms are evicted: their
// tables are exported to JavaScript, and the inputs are TypeScript's from
// then on.
test("the engine holds at most its limit of compressed forms, however many inputs are kept", { timeout: 300_000 }, async () => {
    const limit = 16 << 20;
    const old = nativeSamples.setHeldLimit(limit);
    try {
        const glue = engine.engineSync();
        // About 1 MB each; their forms take some 2 MiB.
        const texts = [0, 1, 2].map((k) => generateJson(1_400, 7_000 + k));
        const expected = [];
        for (const text of texts) {
            expected.push(await inMode("ts", async () => [...(await run(await addAll("go", [["Big", [text]]]), "go"))]));
        }

        const before = { ...engineStats };
        const kept = [];
        let pagesAfterWarmUp;
        for (let i = 0; i < 48; i++) {
            const input = await addAll("go", [["Big", [texts[i % 3]]]]);
            kept.push(input);
            // The form just read into is not counted.
            const others = glue.jsonHeld() - nativeSamples.formBytes(input._compressedJSON);
            assert.ok(others <= limit, `${others} bytes held by the others after ${i + 1} inputs`);
            assert.deepEqual([...(await run(input, "go"))], expected[i % 3]);
            if (i === 15) pagesAfterWarmUp = glue.__memoryPages();
        }

        // The engine's memory did not grow with the inputs (without the
        // limit, each adds some 2 MiB).
        assert.ok(glue.__memoryPages() <= pagesAfterWarmUp * 1.25, `${glue.__memoryPages()} against ${pagesAfterWarmUp} pages`);
        assert.equal(engineStats.samplesRead, before.samplesRead + 48);
        assert.equal(engineStats.wasm, before.wasm + 48);
        const evicted = engineStats.evicted - before.evicted;
        assert.ok(evicted >= 30, `${evicted} evicted`);
        assert.equal(engineStats.tablesFilled, before.tablesFilled);
        // Every input still gives what TypeScript gives: the evicted ones
        // from their tables, filled now, the others from the engine.
        for (const [i, input] of kept.entries()) {
            assert.deepEqual([...(await run(input, "go"))], expected[i % 3], `input ${i}`);
        }

        assert.equal(engineStats.tablesFilled, before.tablesFilled + evicted);
        assert.equal(engineStats.wasm, before.wasm + 96);
        noLeases();
    } finally {
        nativeSamples.setHeldLimit(old);
    }
});

test("inputs that are gone but not finalized are evicted too, and nothing is filled for them", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const nativeSamples = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "samples.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        // Less than one input's form (some 2.4 MB): the forms but the one
        // just read into hold none of the others.
        nativeSamples.setHeldLimit(2 << 20);
        const glue = engine.engineSync();
        const text = JSON.stringify(Array.from({ length: 20000 }, (_, i) => ({ id: i, name: "n" + (i % 50), tags: ["a", "b"] })));
        // What the forms but the one just read into hold.
        const read = () => {
            const input = qt.jsonInputForTargetLanguage("rust");
            input.addSourceSync({ name: "A", samples: [text] });
            return glue.jsonHeld() - nativeSamples.formBytes(input._compressedJSON);
        };
        (async () => {
            const held = [];
            for (let i = 0; i < 40; i++) {
                held.push(read());
                // Collected (its weak reference cleared) after this job.
                await new Promise((resolve) => setImmediate(resolve));
                global.gc();
            }
            console.log(JSON.stringify({ max: Math.max(...held), count: glue.__jsonCount(), evicted: engineStats.evicted, dropped: engineStats.dropped, filled: engineStats.tablesFilled }));
        })();
    `;
    const out = JSON.parse(execFileSync(process.execPath, ["--expose-gc", "-e", script], { encoding: "utf8" }));
    assert.ok(out.max <= 2 << 20, JSON.stringify(out));
    // Each read came before the finalizers of the inputs collected just
    // before it had run: those were dropped (their owners no longer
    // dereference: nothing can reach them), not exported, and the others
    // freed by their finalizers. None was evicted or filled.
    assert.ok(out.dropped > 0, JSON.stringify(out));
    assert.equal(out.evicted, 0, JSON.stringify(out));
    assert.equal(out.filled, 0, JSON.stringify(out));
});

// An input still in use when the forms are past their limit is evicted:
// its tables are exported, and it works as before. One that is gone but
// kept alive for the rest of the job its weak reference was made or read
// in (KeepDuringJob: a `WeakRef` keeps its target until the job ends) is
// evicted too, as one in use, and collected with its tables afterwards.
test("a live input past the limit is exported, also one kept alive by its weak reference", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const nativeSamples = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "samples.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        nativeSamples.setHeldLimit(1);
        const glue = engine.engineSync();
        const text = JSON.stringify(Array.from({ length: 2000 }, (_, i) => ({ id: i, name: "n" + (i % 50), when: "2020-01-0" + (1 + (i % 9)) })));
        const read = () => {
            const input = qt.jsonInputForTargetLanguage("rust");
            input.addSourceSync({ name: "A", samples: [text] });
            return input;
        };
        const generate = (input) => {
            const inputData = new qt.InputData();
            inputData.addInput(input);
            return qt.quicktypeMultiFileSync({ lang: "rust", inputData }).get("stdout").lines.join("\\n");
        };
        const stats = () => ({ evicted: engineStats.evicted, dropped: engineStats.dropped, filled: engineStats.tablesFilled });
        (async () => {
            const out = {};
            // A live input: exported, and it works afterwards.
            const live = read();
            const expected = generate(live);
            await new Promise((resolve) => setImmediate(resolve));
            global.gc();
            let before = stats();
            read();
            out.live = { evicted: engineStats.evicted - before.evicted, dropped: engineStats.dropped - before.dropped };
            out.same = generate(live) === expected;
            out.filled = engineStats.tablesFilled - before.filled;
            // Every input gone by now finalized and freed.
            for (let i = 0, last = -1; i < 50 && glue.__jsonCount() !== last; i++) {
                last = glue.__jsonCount();
                await new Promise((resolve) => setTimeout(resolve, 10));
                global.gc();
                await new Promise((resolve) => setTimeout(resolve, 10));
            }
            // Gone, but its weak reference was made in this very job: still
            // alive after a collection, so exported, not dropped.
            before = stats();
            (() => read())();
            global.gc();
            read();
            out.keptForTheJob = { evicted: engineStats.evicted - before.evicted, dropped: engineStats.dropped - before.dropped };
            // In a later job it is collected, with the tables exported for it.
            const count = glue.__jsonCount();
            for (let i = 0; i < 50 && glue.__jsonCount() >= count; i++) {
                await new Promise((resolve) => setTimeout(resolve, 10));
                global.gc();
            }
            out.collected = glue.__jsonCount() < count;
            out.filledAfter = engineStats.tablesFilled - before.filled;
            console.log(JSON.stringify(out));
        })();
    `;
    const out = JSON.parse(execFileSync(process.execPath, ["--expose-gc", "-e", script], { encoding: "utf8" }));
    assert.deepEqual(out.live, { evicted: 1, dropped: 0 }, JSON.stringify(out));
    assert.equal(out.same, true);
    assert.equal(out.filled, 1, "the live input's tables were filled from what was exported");
    assert.deepEqual(out.keptForTheJob, { evicted: 1, dropped: 0 }, JSON.stringify(out));
    assert.equal(out.collected, true, JSON.stringify(out));
    assert.equal(out.filledAfter, 0, JSON.stringify(out));
});

// The limit is on the forms other than the one just read into, and those
// are kept most recently used first while they fit: a form past the limit
// on its own evicts nothing while it is read into (the small inputs used
// before it stay), and is the one evicted once another input is read.
test("a form past the limit on its own evicts nothing while it is read into, and goes first after", () => {
    const script = `
        const qt = require(${JSON.stringify(packageRoot)});
        const engine = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "engine.js"))});
        const nativeSamples = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "samples.js"))});
        const { engineStats } = require(${JSON.stringify(path.join(packageRoot, "dist", "native", "bridge.js"))});
        const glue = engine.engineSync();
        const big = (k, n) => JSON.stringify(Array.from({ length: n }, (_, i) => ({ id: i, ["k" + (i % 40)]: "v" + k + "-" + (i % 300), tags: [k, "b"] })));
        const small = (i) => '{"s' + i + '": [' + i + ', "x"], "o": {"p": ' + i + '}}';
        const attempt = (onRead) => {
            const smalls = [0, 1].map((i) => {
                const input = qt.jsonInputForTargetLanguage("rust");
                input.addSourceSync({ name: "S", samples: [small(i)] });
                return input;
            });
            onRead("smalls");
            const large = qt.jsonInputForTargetLanguage("rust");
            const add = (input, name, text) => {
                input.addSourceSync({ name, samples: [text] });
                onRead(name, input);
            };
            add(large, "L0", big(0, 40000));
            add(large, "L1", big(1, 2000));
            add(smalls[0], "S0", small(2));
            add(large, "L2", big(2, 2000));
            add(smalls[1], "S1", small(3));
            return [...smalls, large].map((input) => {
                const inputData = new qt.InputData();
                inputData.addInput(input);
                const result = [...qt.quicktypeMultiFileSync({ lang: "rust", inputData })].map(([file, r]) => [file, r.lines]);
                const c = input._compressedJSON;
                return { result, strings: [...c._strings], objects: c._objects.map((o) => [...o]), arrays: c._arrays.map((a) => [...a]) };
            });
        };
        let limit;
        const steps = [];
        const actual = attempt((name, input) => {
            // The limit: just what the two small inputs hold.
            if (input === undefined) {
                limit = glue.jsonHeld() + 65536;
                nativeSamples.setHeldLimit(limit);
                return;
            }
            const current = nativeSamples.formBytes(input._compressedJSON) ?? 0;
            steps.push({ name, current: current > limit, others: glue.jsonHeld() - current <= limit, read: engineStats.samplesRead, evicted: engineStats.evicted, filled: engineStats.tablesFilled });
        });
        globalThis[Symbol.for("quicktype-core.engine")] = "ts";
        const expected = attempt(() => {});
        console.log(JSON.stringify({ steps, same: JSON.stringify(actual) === JSON.stringify(expected) }));
    `;
    const out = JSON.parse(execFileSync(process.execPath, ["-e", script], { encoding: "utf8", maxBuffer: 1 << 26 }));
    const step = (name, current, read, evicted, filled) => ({ name, current, others: true, read, evicted, filled });
    assert.deepEqual(out.steps, [
        // Past the limit on its own: the small inputs stay.
        step("L0", true, 3, 0, 0),
        step("L1", true, 4, 0, 0),
        // Another input is read: the large one does not fit, and goes.
        step("S0", false, 5, 1, 0),
        // Its tables are filled, and TypeScript reads it from then on.
        step("L2", false, 5, 1, 1),
        // The other small input is still the engine's.
        step("S1", false, 6, 1, 1),
    ]);
    assert.ok(out.same, "the tables and runs are TypeScript's");
});

// Running out of memory in the middle of a read traps the instance. The
// other inputs' tables are then taken from its memory, which only works
// if the read held no borrow of the engine's table of inputs (a borrow
// that a trap never releases).
test("an instance that traps while it reads a sample still gives the other inputs' tables", async () => {
    const old = nativeSamples.setKeptTexts(0);
    try {
        const bSamples = ['{"b": [1, {"c": "x"}]}', "[2]"];
        const expectedA = await inMode("ts", async () => inside(await addAll("rust", plainGroups)));
        const expectedB = await inMode("ts", async () => inside(await addAll("rust", [["B", bSamples]])));
        const a = await addAll("rust", plainGroups);
        const glue = engine.engineSync();
        glue.jsonRead = (id, text) => glue.__jsonReadTrapForTests(id, text);
        const before = { ...engineStats };
        const b = await addAll("rust", [["B", bSamples]]);
        assert.ok(engine.isDiscarded(glue));
        assert.match(engineStats.lastFailure, /RuntimeError|unreachable/);
        assert.equal(engineStats.samplesRead, before.samplesRead);
        // A's samples were not kept: its tables come from the failed
        // instance's memory.
        assert.deepEqual(inside(a), expectedA);
        assert.deepEqual(inside(b), expectedB);
    } finally {
        nativeSamples.setKeptTexts(old);
    }
});

// A full table of inputs or runs (2^21 at once) is a limit, not a failure:
// that input or run goes to TypeScript, and the instance stays.
test("an engine that takes no more inputs or runs declines them and stays", async () => {
    const glue = engine.engineSync();
    const expected = await inMode("ts", async () => [...(await run(await addAll("rust", plainGroups), "rust"))]);
    const shared = await addAll("rust", plainGroups);
    const { jsonCreate, start } = glue;
    const declinedBy = "more runs at once than the engine takes";
    const before = { ...engineStats, declinedBy: engineStats.unsupportedBy[declinedBy] ?? 0 };
    let own;
    glue.jsonCreate = () => undefined;
    try {
        own = await addAll("rust", plainGroups);
    } finally {
        glue.jsonCreate = jsonCreate;
    }

    assert.equal(engineStats.samplesRead, before.samplesRead);
    glue.start = () => undefined;
    try {
        assert.deepEqual([...(await run(own, "rust"))], expected);
        assert.deepEqual([...(await run(shared, "rust"))], expected);
    } finally {
        glue.start = start;
    }

    assert.equal(engineStats.unsupported, before.unsupported + 2);
    assert.equal(engineStats.unsupportedBy[declinedBy], before.declinedBy + 2);
    assert.equal(engineStats.rerun, before.rerun);
    assert.equal(engine.currentEngine(), glue);
    assert.ok(!engine.isDiscarded(glue));
    noLeases();
    // The run on TypeScript read the tables of the input the engine read.
    assert.equal(engineStats.tablesFilled, before.tablesFilled + 1);
    // And the engine does the next run.
    assert.deepEqual([...(await run(shared, "rust"))], expected);
    assert.equal(engineStats.wasm, before.wasm + 1);
});


// Samples given as bytes (a `Uint8Array`, a Node.js `Buffer`): the UTF-8
// text `new TextDecoder().decode(bytes)` gives, without a leading byte order
// mark and with U+FFFD for what is not UTF-8, read by the engine straight
// from the bytes (or by TypeScript after decoding them).
const utf8 = (text) => new TextEncoder().encode(text);
class Bytes extends Uint8Array {}

/** `bytes` at a non-zero offset of a larger buffer, between other bytes. */
function offsetView(bytes) {
    const buffer = new Uint8Array(bytes.length + 13);
    buffer.fill(0xff);
    buffer.set(bytes, 7);
    return new Uint8Array(buffer.buffer, 7, bytes.length);
}

const byteForms = {
    Uint8Array: (b) => b,
    Buffer: (b) => Buffer.from(b),
    "a Uint8Array subclass": (b) => Bytes.from(b),
    "a view at a non-zero byteOffset": offsetView,
};

test("samples given as bytes are read as their UTF-8 text, by the engine", async () => {
    for (const lang of ["typescript", "kotlin", "rust"]) {
        const groups = Object.entries(samples);
        const expected = await inMode("ts", async () => inside(await addAll(lang, groups)));
        const expectedRun = await inMode("ts", async () => [...(await run(await addAll(lang, plainGroups, { sync: true }), lang))]);
        for (const [form, make] of Object.entries(byteForms)) {
            const asBytes = (list) => list.map((text) => make(utf8(text)));
            const before = { ...engineStats };
            const input = await addAll(lang, groups.map(([name, list]) => [name, asBytes(list)]));
            assert.ok(engineStats.samplesRead > before.samplesRead, form);
            assert.deepEqual(inside(input), expected, `${lang}, ${form}`);
            // On TypeScript too.
            const ts = await inMode("ts", async () => inside(await addAll(lang, groups.map(([name, list]) => [name, asBytes(list)]))));
            assert.deepEqual(ts, expected, `${lang}, ${form}, TypeScript`);

            const plain = plainGroups.map(([name, list]) => [name, asBytes(list)]);
            const before2 = { ...engineStats };
            const sync = await addAll(lang, plain, { sync: true });
            assert.equal(engineStats.samplesRead, before2.samplesRead + plain.flatMap(([, l]) => l).length);
            assert.deepEqual([...(await run(sync, lang))], expectedRun, `${lang}, ${form}, run`);
            assert.equal(engineStats.tablesFilled, before2.tablesFilled);
        }
    }

    noLeases();
});

test("bytes: a byte order mark, bytes that are not UTF-8, an empty buffer", async () => {
    const decoded = (bytes) => new TextDecoder().decode(bytes);
    const cases = [
        // A byte order mark is not part of the text (as a string, it is not
        // JSON: `JSON.parse` rejects U+FEFF).
        new Uint8Array([0xef, 0xbb, 0xbf, ...utf8('{"bom": [1, "é"]}')]),
        // Only one is.
        new Uint8Array([0xef, 0xbb, 0xbf, 0xef, 0xbb, 0xbf, ...utf8("{}")]),
        // Not UTF-8: each maximal invalid subpart becomes U+FFFD.
        new Uint8Array([...utf8('{"a": "x'), 0xff, 0xc3, 0x28, 0xe2, 0x82, ...utf8('", "b": ["'), 0xed, 0xa0, 0x80, ...utf8('"]}')]),
        // A key that is not UTF-8, and one that is the same after decoding.
        new Uint8Array([...utf8('{"k'), 0x80, ...utf8('": 1, "k\u{fffd}": 2}')]),
        // Not UTF-8 outside a string: not JSON either way.
        new Uint8Array([...utf8("[1, "), 0xff, ...utf8("]")]),
        // Empty, and only a byte order mark.
        new Uint8Array([]),
        new Uint8Array([0xef, 0xbb, 0xbf]),
    ];
    for (const bytes of cases) {
        const text = decoded(bytes);
        for (const sync of [false, true]) {
            const attempt = (sample) => async () => {
                const input = qt.jsonInputForTargetLanguage("rust");
                const add = { name: "Bytes", samples: [sample, "[1]"] };
                const failed = await outcome(async () => (sync ? input.addSourceSync(add) : input.addSource(add)));
                const state = inside(input);
                return { failed, state, result: failed.error === undefined ? [...(await run(input, "rust"))] : undefined };
            };
            const expected = await inMode("ts", attempt(text));
            assert.deepEqual(await attempt(bytes)(), expected, `${[...bytes]} ${sync}`);
            assert.deepEqual(await inMode("ts", attempt(bytes)), expected, `${[...bytes]} ${sync}, TypeScript`);
        }
    }

    noLeases();
});

test("bytes changed after addSource change nothing", async () => {
    const bytes = utf8('{"a": [1, {"b": "c"}]}');
    const input = qt.jsonInputForTargetLanguage("typescript");
    await input.addSource({ name: "T", samples: [bytes] });
    const expected = await inMode("ts", async () => [...(await run(await addAll("typescript", [["T", ['{"a": [1, {"b": "c"}]}']]]), "typescript"))]);
    bytes.fill(0x20);
    assert.deepEqual([...(await run(input, "typescript"))], expected);
    // Nor do they when the instance fails: the samples TypeScript reads
    // again then are a copy.
    const kept = utf8('{"x": true, "y": "\u00e9"}');
    const input2 = qt.jsonInputForTargetLanguage("typescript");
    await input2.addSource({ name: "T", samples: [kept] });
    kept.fill(0x20);
    const glue = engine.engineSync();
    assert.throws(() => glue.__panicForTests(), WebAssembly.RuntimeError);
    engine.discardEngine(glue);
    const before = engineStats.tablesFilled;
    assert.deepEqual(inside(input2), await inMode("ts", async () => inside(await addAll("typescript", [["T", ['{"x": true, "y": "\u00e9"}']]]))));
    assert.equal(engineStats.tablesFilled, before + 1);
});

// The playground's workers let go of an input they will not use again
// (`releaseJSONInput`, not public): its form is freed in the engine at once,
// so that reading the next input does not find the engine past its limit
// and evict it, as it would an input that is gone but not finalized yet.
test("an input released is freed in the engine at once, and is not evicted", async () => {
    const glue = engine.engineSync();
    const count = glue.__jsonCount();
    const held = glue.jsonHeld();
    const make = () => addAll("rust", plainGroups);
    const first = await make();
    assert.equal(glue.__jsonCount(), count + 1);
    assert.ok(glue.jsonHeld() > held);
    // What the inputs of earlier tests hold fits, and no more: another
    // input kept would be evicted.
    const old = nativeSamples.setHeldLimit(held + 1);
    try {
        const before = { ...engineStats };
        nativeSamples.releaseJSONInput(first);
        assert.equal(glue.__jsonCount(), count);
        assert.equal(glue.jsonHeld(), held);
        const second = await make();
        assert.equal(engineStats.evicted, before.evicted);
        assert.equal(engineStats.tablesFilled, before.tablesFilled);
        // The input released can no longer be used.
        assert.throws(() => first._compressedJSON._strings, /samples of this input were released/);
        await assert.rejects(run(first, "rust"), /samples of this input were released/);
        // Without releasing it, the next input read evicts one.
        await make();
        assert.ok(engineStats.evicted > before.evicted);
        assert.deepEqual([...(await run(second, "rust"))], await inMode("ts", async () => [...(await run(await make(), "rust"))]));
        // Releasing an input the engine does not hold does nothing.
        nativeSamples.releaseJSONInput(await inMode("ts", make));
        nativeSamples.releaseJSONInput(first);
    } finally {
        nativeSamples.setHeldLimit(old);
    }

    noLeases();
});

// What the decoder throws for bytes that are not UTF-8 (a `RangeError` for
// a text longer than the longest string) is the input's error, thrown from
// `addSource` as on TypeScript: the engine has not failed, and keeps every
// other input's samples. Such bytes are decoded once, also when the engine
// then leaves the text to TypeScript (not JSON, or a string root).
test("bytes that are not UTF-8: the decoder's error is the input's, and they are decoded once", async () => {
    const decoderClass = globalThis.TextDecoder;
    const decode = decoderClass.prototype.decode;
    const notUtf8 = (json) => {
        const bytes = utf8(json);
        const at = bytes.indexOf(0x7e); // "~": a byte that becomes U+FFFD
        bytes[at] = 0xff;
        return bytes;
    };
    // How often the sample's own bytes were decoded (the glue decodes the
    // engine's strings with a TextDecoder too).
    let decoded = 0;
    let watched;
    let failing = false;
    decoderClass.prototype.decode = function (input) {
        if (input !== undefined && input === watched) {
            decoded++;
            if (failing) throw new RangeError("Invalid string length");
        }
        return decode.call(this, input);
    };
    try {
        const glue = engine.engineSync();
        const other = await addAll("rust", plainGroups);
        const expected = await inMode("ts", async () => [...(await run(await addAll("rust", plainGroups), "rust"))]);
        const before = { ...engineStats };
        failing = true;
        for (const sync of [false, true]) {
            const input = qt.jsonInputForTargetLanguage("rust");
            watched = notUtf8('{"a": "~"}');
            const add = { name: "T", samples: [watched] };
            const failed = await outcome(async () => (sync ? input.addSourceSync(add) : input.addSource(add)));
            // quicktype's "Syntax error in input JSON" around it, as on TypeScript.
            assert.match(failed.error?.message ?? "", /Invalid string length/);
            const ts = await inMode("ts", async () => outcome(async () => qt.jsonInputForTargetLanguage("rust").addSource(add)));
            assert.deepEqual(failed, ts);
        }

        failing = false;
        // The engine did not fail: the other input's samples are still there.
        assert.equal(engine.currentEngine(), glue);
        assert.ok(!engine.isDiscarded(glue));
        assert.equal(engineStats.rerun, before.rerun);
        assert.deepEqual([...(await run(other, "rust"))], expected);
        assert.equal(engineStats.tablesFilled, before.tablesFilled);

        // Read on the engine: one decode.
        for (const [json, form] of [
            ['{"a": "~", "b": [1]}', "read by the engine"],
            ['[1, "~", ', "not JSON"],
            ['"~ a string root"', "a string root, left to TypeScript"],
        ]) {
            const bytes = notUtf8(json);
            const text = new TextDecoder().decode(bytes);
            watched = bytes;
            decoded = 0;
            const ours = await outcome(async () => {
                const input = qt.jsonInputForTargetLanguage("rust");
                await input.addSource({ name: "T", samples: [bytes] });
                return inside(input);
            });
            assert.equal(decoded, 1, form);
            const theirs = await inMode("ts", async () =>
                outcome(async () => {
                    const input = qt.jsonInputForTargetLanguage("rust");
                    await input.addSource({ name: "T", samples: [text] });
                    return inside(input);
                }),
            );
            assert.deepEqual(ours, theirs, form);
        }
    } finally {
        decoderClass.prototype.decode = decode;
    }

    noLeases();
});

// A `Uint8Array` (or `Buffer`) from another realm, such as a `vm` context
// or an iframe, is bytes too, though `instanceof Uint8Array` says no.
test("bytes from another realm are bytes", async () => {
    const vm = await import("node:vm");
    const groups = Object.entries(samples);
    const expected = await inMode("ts", async () => inside(await addAll("typescript", groups)));
    const foreign = (text) => vm.runInNewContext("new Uint8Array(bytes)", { bytes: [...utf8(text)] });
    assert.ok(!(foreign("1") instanceof Uint8Array));
    for (const mode of [undefined, "ts"]) {
        const before = engineStats.samplesRead;
        const input = await inMode(mode, async () => addAll("typescript", groups.map(([name, list]) => [name, list.map(foreign)])));
        assert.deepEqual(inside(input), expected, mode ?? "the engine");
        if (mode === undefined) assert.ok(engineStats.samplesRead > before);
    }

    // Not the comma-joined byte values (`[49]` is "1", not 49).
    const one = qt.jsonInputForTargetLanguage("typescript");
    await one.addSource({ name: "One", samples: [foreign('"x"')] });
    assert.deepEqual([...(await run(one, "typescript"))], await inMode("ts", async () => [...(await run(await addAll("typescript", [["One", ['"x"']]]), "typescript"))]));
    noLeases();
});

// How an input's samples are read, for the playground's reuse of an input
// (`readingKey`, not public): from the configuration the engine reads them
// with, so that two inputs share it exactly when they read alike.
test("the reading key follows the CompressedJSON's configuration", () => {
    const key = (lang, handleRefs = false, rendererOptions = {}) =>
        nativeSamples.readingKey(qt.jsonInputForTargetLanguage(lang, undefined, handleRefs, rendererOptions));
    assert.equal(key("go"), key("cs"));
    assert.notEqual(key("go"), key("kotlin"));
    assert.notEqual(key("kotlin"), key("swift"));
    assert.notEqual(key("go"), key("go", true));
    assert.notEqual(key("rust"), key("rust", false, { "integer-type": "force-i32" }));
    assert.equal(nativeSamples.readingKey(new qt.JSONInput(new (class extends CompressedJSONFromString {})(new DefaultDateTimeRecognizer(), false))), undefined);
    assert.equal(nativeSamples.readingKey({}), undefined);
});
