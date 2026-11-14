// JSON samples as they are added (`JSONInput.addSource`/`addSourceSync`),
// which the WebAssembly engine reads itself: where errors surface (from
// addSource, with V8's message), what the input and its `CompressedJSON`
// look like afterwards (their private fields included, before and after a
// run), how many ticks addSource takes, and the runs: the same input used
// again, samples added between runs, many small samples, and samples the
// engine leaves to TypeScript (deep nesting, string roots, lone
// surrogates).

import { jsonSample } from "../packages.mjs";

function scenario(name, run, lang) {
    return { id: `samples/${name}`, category: "samples", group: "samples", lang, run };
}

/** Where `f` threw, if it did. */
async function attempt(phase, f) {
    try {
        await f();
        return undefined;
    } catch (e) {
        return { phase, error: e };
    }
}

/** What can be seen of a JSON input; `tables` reads its CompressedJSON's tables. */
function state(input, tables) {
    const c = input._compressedJSON;
    const out = {
        topLevels: [...input._topLevels].map(([name, t]) => [name, t.description, [...t.samples]]),
        inputFields: Object.getOwnPropertyNames(input),
        fields: Object.getOwnPropertyNames(c),
    };
    if (tables) {
        out.strings = [...c._strings];
        out.indexes = Object.getOwnPropertyNames(c._stringIndexes).map((k) => [k, c._stringIndexes[k]]);
        out.objects = c._objects.map((o) => [...o]);
        out.arrays = c._arrays.map((a) => [...a]);
        out.hash = c.hashCode();
        out.fieldsAfter = Object.getOwnPropertyNames(c);
    }

    return out;
}

function data(qt, ...inputs) {
    const inputData = new qt.InputData();
    for (const input of inputs) inputData.addInput(input);
    return inputData;
}

/** addSource of each group, then a run; the state before the run and after. */
async function addThenRun(qt, lang, groups, { sync = false, tablesFirst = false, extra = {} } = {}) {
    const input = qt.jsonInputForTargetLanguage(lang);
    const failures = [];
    for (const [name, samples, description] of groups) {
        const source = { name, samples, description };
        const failed = await attempt(`addSource ${name}`, () => (sync ? input.addSourceSync(source) : input.addSource(source)));
        if (failed !== undefined) failures.push(failed);
    }

    const before = state(input, tablesFirst);
    const run = await attempt("run", async () => {
        failures.push({ result: await qt.quicktypeMultiFile({ lang, inputData: data(qt, input), ...extra }) });
    });
    return { failures, run, before, after: state(input, true) };
}

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

const dateSamples = ['{"d": "2020-01-01", "t": "12:30:00Z", "dt": "2020-01-01T00:00:00Z"}', '[{"d": "2021-02-03", "e": "x"}]'];

/**
 * Two inputs, one with every sample added while `object[name]` is
 * `value`, one with only its second; their runs (after the patch) and
 * their tables.
 */
async function addPatched(qt, object, name, value) {
    const samples = ['{"a": "x", "n": 1, "list": [2, "y", [3, 4]]}', '[{"a": "z", "n": 5, "m": [6, "w"]}, 7]'];
    const before = qt.jsonInputForTargetLanguage("rust");
    const between = qt.jsonInputForTargetLanguage("rust");
    await between.addSource({ name: "A", samples: [samples[0]] });
    await patched(object, name, value, async () => {
        await before.addSource({ name: "A", samples });
        between.addSourceSync({ name: "B", samples: [samples[1]] });
    });
    const results = [];
    for (const input of [before, between]) {
        results.push(await qt.quicktypeMultiFile({ lang: "rust", inputData: data(qt, input) }));
    }

    return { results, before: state(before, true), between: state(between, true) };
}

const deep = (n, open = "[", close = "]", inner = "1") => open.repeat(n) + inner + close.repeat(n);

const groups = {
    "duplicate keys": [['{"a": {"x": 1}, "b": [1, 2], "a": {"y": [2, {"z": 3}]}, "b": "s"}', '[{"k": 1, "k": 2, "k": {"k": [3]}}]']],
    "__proto__ keys": [['{"__proto__": 1, "__proto__": {"a": 2}, "b": {"__proto__": [3]}}', '{"c": {"__proto__": "x"}}']],
    "array-index keys": [['{"b": 1, "2": {"q": 2}, "a": 3, "1": [4], "01": 5, "4294967295": 6, "4294967294": {"z": 7}}']],
    "map-like keys": [['{"10": {"v": 1}, "9": {"v": 2}, "100": {"v": 3}, "x": {"v": 4}}', '{"3": {"v": 5}, "1": {"v": 6}}']],
    "big numbers": [[
        "[9223372036854775807, 9223372036854775808, -9223372036854775808, -9223372036854775809]",
        "[1e21, 1e400, -1e400, 123456789012345678901234567890, 9007199254740993, 2147483648, 4294967296]",
        '{"a": 9223372036854775807, "b": 1.5, "c": 1e2}',
    ]],
    "-0": [["[-0, 0, -0.0, -0e5]", '{"a": -0}', "-0"]],
    "numbers and doubles": [['[1.0, 1.5, 1e2, 1E-2, -1e-7, 0.1e1, 123456789012345, 1234567890123456]']],
    "strings and formats": [[
        '{"d": "2020-01-01", "t": "12:30:00", "dt": "2020-01-01T00:00:00Z", "u": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',
        '{"uri": "https://example.com/a.png", "i": "123", "b": "true", "long": "' + "x".repeat(80) + '", "e": ""}',
    ]],
    escapes: [['{"k\\u0065y": "a\\nb\\t\\"c\\"\\\\\\/", "😀": ["\\ud83d\\ude00", "\\u00e9", "é"], "\\u0000": 1}']],
    "$ref values": [['{"$ref": "#/definitions/a", "x": {"$ref": "http://example.com/s.json"}, "y": {"$ref": 1}}']],
    scalars: [["1", "null", "true", "2.5", '"' + "y".repeat(70) + '"']],
    "string roots": [['"short"', '"2020-01-01"', '"https://example.com/x.png"', '[1]']],
    "empty containers": [["[]", "{}", "[[], {}]", '{"a": [], "b": {}}']],
    "deep within the engine's limit": [[deep(255), deep(128, '{"a":', "}")]],
    "deeper than the engine reads": [[deep(10), deep(300), deep(5)]],
    "lone surrogate escapes": [['["\\ud800"]', '{"\\udc00": 1}', '["\\ud83d\\ude00", "ok"]']],
    "lone surrogates in the text": [['["\ud800x"]', "[1]"]],
    "two top-levels": [['{"a": 1}'], ['{"a": "x", "b": [true]}']],
    "same top-level twice": [['{"a": 1}'], ['{"a": 2.5}']],
};

const invalid = [
    "",
    "   ",
    "[1,",
    '{"a": 1,}',
    "{'a': 1}",
    "{a: 1}",
    "01",
    "1.",
    "-",
    "+1",
    '"abc',
    '"\\x"',
    '"\\u12"',
    '"\t"',
    "\u{feff}{}",
    "[1] x",
    "NaN",
    "undefined",
    "[object Object]",
    '{"a": [1, 2}',
    "tru",
    "nul",
    '{"a" 1}',
    "x".repeat(40),
    '{"é": "' + "ü".repeat(30) + "'}",
];

export function scenarios() {
    const list = [];
    const langs = ["typescript", "rust", "kotlin", "swift", "cs", "python", "go", "java"];
    for (const [name, sources] of Object.entries(groups)) {
        const named = sources.map((samples, i) => [i === 0 ? "TopLevel" : `Other${i}`, samples, i === 1 ? "A description" : undefined]);
        if (name === "same top-level twice") named[1][0] = "TopLevel";
        for (const lang of langs) {
            list.push(scenario(`${name} → ${lang}`, (qt) => addThenRun(qt, lang, named), lang));
        }

        list.push(
            scenario(`${name}, sync`, (qt) => addThenRun(qt, "rust", named, { sync: true }), "rust"),
            scenario(`${name}, tables read before the run`, (qt) => addThenRun(qt, "typescript", named, { tablesFirst: true }), "typescript"),
        );
    }

    // The same samples as bytes for this package (in its several forms),
    // their text for the reference.
    const utf8 = (text) => new TextEncoder().encode(text);
    class Bytes extends Uint8Array {}
    const views = {
        Uint8Array: (b) => b,
        Buffer: (b) => Buffer.from(b),
        "a Uint8Array subclass": (b) => Bytes.from(b),
        "a view at an offset": (b) => {
            const buffer = new Uint8Array(b.length + 9).fill(0xff);
            buffer.set(b, 5);
            return buffer.subarray(5, 5 + b.length);
        },
    };
    for (const [name, sources] of Object.entries(groups)) {
        for (const [view, make] of Object.entries(views)) {
            for (const [lang, sync] of [["typescript", false], ["rust", true]]) {
                list.push(
                    scenario(
                        `${name}, as bytes (${view}) → ${lang}${sync ? ", sync" : ""}`,
                        (qt, ctx) =>
                            addThenRun(
                                qt,
                                lang,
                                sources.map((samples, i) => [i === 0 ? "TopLevel" : `Other${i}`, samples.map((t) => jsonSample(ctx, utf8(t), make))]),
                                { sync },
                            ),
                        lang,
                    ),
                );
            }
        }
    }

    // Bytes that are more than the UTF-8 of a string: a byte order mark,
    // which is not part of the text; bytes that are not UTF-8, which become
    // U+FFFD (as `TextDecoder` replaces them); nothing at all.
    const bom = [0xef, 0xbb, 0xbf];
    const byteCases = {
        "a byte order mark": [[...bom, ...utf8('{"a": [1, "é"]}')], [...bom, ...bom, ...utf8("[]")], [...bom]],
        "bytes that are not UTF-8": [
            [...utf8('{"a": "x'), 0xff, 0xc3, 0x28, 0xe2, 0x82, ...utf8('", "b": ["'), 0xed, 0xa0, 0x80, ...utf8('"]}')],
            [...utf8('{"k'), 0x80, ...utf8('": 1, "k\u{fffd}": 2}')],
            [...utf8('["'), 0xf4, 0x90, 0x80, 0x80, 0xc0, 0xaf, ...utf8('", 1]')],
        ],
        "not UTF-8 and not JSON": [[...utf8("[1, "), 0xff, ...utf8("]")]],
        "an empty buffer": [[]],
    };
    for (const [name, cases] of Object.entries(byteCases)) {
        for (const [i, bytes] of cases.entries()) {
            for (const sync of [false, true]) {
                list.push(
                    scenario(`${name} ${i}${sync ? ", sync" : ""}`, (qt, ctx) =>
                        addThenRun(qt, "typescript", [["Bytes", [jsonSample(ctx, new Uint8Array(bytes)), "[1]"]]], { sync }),
                    ),
                );
            }
        }
    }

    for (const [i, bad] of invalid.entries()) {
        for (const sync of [false, true]) {
            list.push(
                scenario(`not JSON ${i}${sync ? ", sync" : ""}: ${JSON.stringify(bad).slice(0, 30)}`, (qt) =>
                    addThenRun(qt, "typescript", [
                        ["Good", ['{"a": [1]}']],
                        ["Bad", ['{"b": {"c": 2}}', bad, "[3]"], "D"],
                        ["After", ['{"d": [{}]}']],
                    ], { sync }),
                ),
            );
        }
    }

    list.push(
        scenario("deeper than TypeScript's process gets", (qt) =>
            addThenRun(qt, "typescript", [
                ["Fine", ["[1]"]],
                ["Deep", [deep(200_000)]],
            ]),
        ),
        scenario("no samples", (qt) => addThenRun(qt, "typescript", [["None", []]])),
        scenario("a sample that is not a string", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            const failures = [];
            for (const samples of [[123], [null], [["[1]"]], [{ toString: () => "[2]" }]]) {
                failures.push(await attempt("addSource", () => input.addSource({ name: "T", samples })));
            }

            return { failures, state: state(input, true) };
        }),
    );

    // The same input in several runs, and samples added between runs.
    list.push(
        scenario("the same input in two runs", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("rust");
            await input.addSource({ name: "Person", samples: ['{"name": "Ann", "age": 7, "pets": [{"kind": "cat"}]}'] });
            const inputData = data(qt, input);
            const first = await qt.quicktypeMultiFile({ lang: "rust", inputData });
            const second = qt.quicktypeMultiFileSync({ lang: "rust", inputData });
            const third = await qt.quicktypeMultiFile({ lang: "rust", inputData, rendererOptions: { density: "dense" } });
            return { first, second, third, state: state(input, true) };
        }),
        scenario("samples added between runs", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            const inputData = data(qt, input);
            const results = [];
            for (const sample of ['{"a": 1}', '{"a": "x", "b": [1]}', '[{"a": null}]', '"s"', '{"c": {}}']) {
                await input.addSource({ name: "T", samples: [sample] });
                results.push(await qt.quicktypeMultiFile({ lang: "typescript", inputData }));
            }

            return { results, state: state(input, true) };
        }),
        scenario("two runs at once on one input", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("kotlin");
            await input.addSource({ name: "T", samples: ['{"a": [1, 2.5], "b": {"c": "2020-01-01"}}'] });
            const inputData = data(qt, input);
            const runs = await Promise.all([
                qt.quicktypeMultiFile({ lang: "kotlin", inputData }),
                qt.quicktypeMultiFile({ lang: "kotlin", inputData, inferDateTimes: false }),
                qt.quicktypeMultiFile({ lang: "kotlin", inputData, rendererOptions: { framework: "jackson" } }),
            ]);
            return { runs, state: state(input, true) };
        }),
        scenario("the same input with a TypeScript-only language, then the engine", async (qt, ctx) => {
            const input = qt.jsonInputForTargetLanguage("rust");
            await input.addSource({ name: "T", samples: ['{"a": [1, {"b": true}]}'] });
            const inputData = data(qt, input);
            const { RustTargetLanguage } = ctx.deepRequire(qt, "dist/language/Rust/index.js");
            class Custom extends RustTargetLanguage {}
            const custom = await qt.quicktypeMultiFile({ lang: new Custom(), inputData });
            const builtin = await qt.quicktypeMultiFile({ lang: "rust", inputData });
            return { custom, builtin, state: state(input, true) };
        }),
        scenario("a sample added while a run waits for a schema", async (qt) => {
            const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
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
            const inputData = data(qt, json, schema);
            const first = qt.quicktypeMultiFile({ lang: "rust", inputData });
            await delay(5);
            json.addSourceSync({ name: "J2", samples: ['{"b": {"c": true}}'] });
            const results = [await first, await qt.quicktypeMultiFile({ lang: "rust", inputData })];
            return { results, state: state(json, true) };
        }),
        scenario("concurrent addSource calls on one input", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("cs");
            await Promise.all([
                input.addSource({ name: "A", samples: ['{"a": {"x": 1}}', '[{"b": 2}]', '{"c": []}'] }),
                input.addSource({ name: "B", samples: ['[{"d": {}}]', '{"e": [[1]]}'] }),
                input.addSource({ name: "A", samples: ['{"f": 1}'] }),
            ]);
            const before = state(input, false);
            return { before, result: await qt.quicktypeMultiFile({ lang: "cs", inputData: data(qt, input) }), state: state(input, true) };
        }),
        scenario("addSource ticks", async (qt) => {
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
            const out = [];
            for (const list of [["[1]"], ["[1]", '{"a": 2}', "3"], ["[1]", "[1,"], ['"s"', "[1]"], []]) {
                out.push(await ticks(list));
            }

            return out;
        }),
        scenario("many small samples", async (qt) => {
            const samples = Array.from(
                { length: 2000 },
                (_, i) => `{"id": ${i}, "v${i % 7}": [${i % 3 === 0 ? "1.5" : i}], "s": "${"ab".repeat(i % 5)}", "d": ${i % 11 === 0 ? '"2020-01-01"' : "null"}}`,
            );
            const input = qt.jsonInputForTargetLanguage("go");
            await input.addSource({ name: "Many", samples });
            input.addSourceSync({ name: "More", samples: samples.slice(0, 300) });
            const before = state(input, false);
            return { before, result: await qt.quicktypeMultiFile({ lang: "go", inputData: data(qt, input) }), state: state(input, true) };
        }),
        scenario("many top-levels", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("swift");
            for (let i = 0; i < 300; i++) {
                input.addSourceSync({ name: `T${i % 120}`, samples: [`{"k${i % 9}": ${i}, "x": [${i}]}`], description: i % 2 ? `d${i}` : undefined });
            }

            return { result: qt.quicktypeMultiFileSync({ lang: "swift", inputData: data(qt, input) }), state: state(input, true) };
        }),
        scenario("a user's CompressedJSON shared by two inputs", async (qt, ctx) => {
            const { CompressedJSONFromString } = ctx.deepRequire(qt, "dist/input/CompressedJSON.js");
            const { DefaultDateTimeRecognizer } = ctx.deepRequire(qt, "dist/DateTime.js");
            const cjson = new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false);
            const one = new qt.JSONInput(cjson);
            const two = new qt.JSONInput(cjson);
            await one.addSource({ name: "One", samples: ['{"a": [1]}'] });
            two.addSourceSync({ name: "Two", samples: ['[{"a": "b"}]'] });
            const value = cjson.parseSync('{"c": {"d": 1}}');
            const results = [
                await qt.quicktypeMultiFile({ lang: "typescript", inputData: data(qt, one) }),
                await qt.quicktypeMultiFile({ lang: "typescript", inputData: data(qt, two) }),
            ];
            return { value, results, one: state(one, true), two: state(two, true), object: cjson.getObjectForValue(value) };
        }),
        scenario("a configuration changed between samples", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            const cjson = input._compressedJSON;
            await input.addSource({ name: "A", samples: ['[2147483648, {"$ref": "#/x"}]'] });
            cjson.supportedIntegerRange = { min: "-2147483648", max: "2147483647" };
            cjson.handleRefs = true;
            await input.addSource({ name: "B", samples: ['[2147483648, {"$ref": "#/x"}]'] });
            return { result: await qt.quicktypeMultiFile({ lang: "typescript", inputData: data(qt, input) }), state: state(input, true) };
        }),
        // Methods replaced on a date/time recognizer, or on the instance or
        // a prototype of a CompressedJSONFromString, are called as they are
        // (the engine's read stands in for the originals only).
        ...["kotlin", "typescript"].map((lang) =>
            scenario(`a date/time recognizer with isDate replaced on the instance → ${lang}`, async (qt) => {
                const input = qt.jsonInputForTargetLanguage(lang);
                input._compressedJSON.dateTimeRecognizer.isDate = () => false;
                await input.addSource({ name: "Dates", samples: dateSamples });
                return { result: await qt.quicktypeMultiFile({ lang, inputData: data(qt, input) }), state: state(input, true) };
            }, lang),
        ),
        scenario("a date/time recognizer with isDate replaced on its class's prototype", async (qt, ctx) => {
            const { DefaultDateTimeRecognizer } = ctx.deepRequire(qt, "dist/DateTime.js");
            return patched(DefaultDateTimeRecognizer.prototype, "isDate", () => false, async () => {
                const input = qt.jsonInputForTargetLanguage("kotlin");
                await input.addSource({ name: "Dates", samples: dateSamples });
                return { result: await qt.quicktypeMultiFile({ lang: "kotlin", inputData: data(qt, input) }), state: state(input, true) };
            });
        }),
        scenario("commitString replaced on CompressedJSONFromString's prototype, before and between samples", async (qt, ctx) => {
            const { CompressedJSONFromString } = ctx.deepRequire(qt, "dist/input/CompressedJSON.js");
            return addPatched(qt, CompressedJSONFromString.prototype, "commitString", function () {
                this.commitNumber(false);
            });
        }),
        scenario("parsedNumberIsDouble replaced on CompressedJSON's prototype, before and between samples", async (qt) =>
            addPatched(qt, qt.CompressedJSON.prototype, "parsedNumberIsDouble", () => true),
        ),
        // A run holds the samples it was encoded with until it starts,
        // even if a run on TypeScript fills the tables meanwhile (which
        // drops the engine's copy) and another input is read into the
        // engine; and the tables filled from the engine are TypeScript's.
        scenario("a run waiting to start while a run on TypeScript fills the tables", async (qt) => {
            const Custom = class extends Object.getPrototypeOf(qt.languageNamed("typescript")).constructor {};
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "A", samples: ['{"a": [1, {"b": true}], "c": "2020-01-01"}'] });
            const inputData = data(qt, input);
            const pending = qt.quicktypeMultiFile({ lang: "typescript", inputData });
            const fallback = qt.quicktypeMultiFileSync({ lang: new Custom(), inputData });
            const other = qt.jsonInputForTargetLanguage("typescript");
            other.addSourceSync({ name: "Other", samples: ['{"x": ["s", {"y": 2.5}], "z": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}'] });
            return {
                first: await pending,
                fallback,
                other: await qt.quicktypeMultiFile({ lang: "typescript", inputData: data(qt, other) }),
                state: state(input, true),
                otherState: state(other, true),
            };
        }),
        scenario("runs at once while samples are added and the tables filled", async (qt) => {
            const Custom = class extends Object.getPrototypeOf(qt.languageNamed("go")).constructor {};
            const input = qt.jsonInputForTargetLanguage("go");
            await input.addSource({ name: "T", samples: ['{"id": 1, "tags": ["a"]}', '[{"id": 2.5}]'] });
            const inputData = data(qt, input);
            const runs = [qt.quicktypeMultiFile({ lang: "go", inputData })];
            input.addSourceSync({ name: "U", samples: ['{"u": {"v": null}}'] });
            runs.push(qt.quicktypeMultiFile({ lang: "go", inputData }));
            runs.push(qt.quicktypeMultiFile({ lang: new Custom(), inputData }));
            input.addSourceSync({ name: "W", samples: ['{"w": [true]}'] });
            runs.push(qt.quicktypeMultiFile({ lang: "go", inputData }));
            return { runs: await Promise.all(runs), state: state(input, true) };
        }),
        scenario("tables of duplicate __proto__ keys and of a sample that is not JSON", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            const failures = [];
            for (const samples of [
                ['{"__proto__":1,"__proto__":2}'],
                ['{"key1": [1, {"key2": '],
                ['{"k": "v", "__proto__": {"__proto__": [1], "__proto__": "x"}}'],
                ['{"d": "2020-01-01", "u": "https://example.com/a.png", "d2": "2021-02-03", "i": "12"}'],
            ]) {
                failures.push(await attempt("addSource", () => input.addSource({ name: "T", samples })));
            }

            return { failures, state: state(input, true) };
        }),
        scenario("a sample large enough to compile the engine", async (qt) => {
            const records = Array.from({ length: 30_000 }, (_, i) => ({
                id: i,
                name: `name ${i % 97}`,
                kind: ["a", "b", "c"][i % 3],
                when: i % 5 === 0 ? "2020-01-01" : null,
                tags: i % 7 === 0 ? [] : [i % 4, `t${i % 11}`],
            }));
            const input = qt.jsonInputForTargetLanguage("csharp");
            await input.addSource({ name: "Records", samples: [JSON.stringify(records)] });
            const result = await qt.quicktypeMultiFile({ lang: "csharp", inputData: data(qt, input) });
            return { result, strings: state(input, true).strings.length };
        }),
        scenario("onTiming and debug output with samples the engine read", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("rust");
            await input.addSource({ name: "T", samples: ['{"a": [1, 2.5], "b": {"c": "x"}}'] });
            const timings = [];
            const result = await qt.quicktypeMultiFile({
                lang: "rust",
                inputData: data(qt, input),
                onTiming: (t) => timings.push(t.name),
                debugPrintGraph: true,
                debugPrintTimes: true,
            });
            return { result, timings };
        }),
    );
    return list;
}
