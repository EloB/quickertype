// JSON Lines samples (`addSource({ name, samples, jsonLines: true })`, not
// in quicktype; src/native/lines.ts): each sample is read as the JSON array
// of the values on its lines, so it gives what that array gives, in every
// language and with every option, as a string or as bytes, read by the
// WebAssembly engine or by TypeScript; errors name the line.
//
//   node --test test/jsonl.test.mjs   (after `npm run build`)

import assert from "node:assert/strict";
import { createRequire } from "node:module";
import * as path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

import { generateCards, generateRulings } from "./bench/generate.mjs";
import { hooksPackage } from "./hooks.mjs";

const require = createRequire(import.meta.url);
const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const qt = require(packageRoot);
const { engineStats } = require(path.join(packageRoot, "dist", "native", "bridge.js"));
const engine = require(path.join(packageRoot, "dist", "native", "engine.js"));
const nativeSamples = require(path.join(packageRoot, "dist", "native", "samples.js"));
const { CompressedJSON, CompressedJSONFromString } = require(path.join(packageRoot, "dist", "input", "CompressedJSON.js"));
const { DefaultDateTimeRecognizer } = require(path.join(packageRoot, "dist", "DateTime.js"));

const { scanJSONLines } = require(path.join(packageRoot, "dist", "native", "lines.js"));

const engineKey = Symbol.for("quicktype-core.engine");

// Samples are read on the engine once it is compiled; here it is from the start.
engine.engineSync();

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

/** Everything of an input: its top levels and its tables (which fills them). */
function inside(input) {
    const c = input._compressedJSON;
    return {
        topLevels: [...input._topLevels].map(([name, t]) => [name, t.description, [...t.samples]]),
        strings: [...c._strings],
        indexes: Object.getOwnPropertyNames(c._stringIndexes).map((k) => [k, c._stringIndexes[k]]),
        objects: c._objects.map((o) => [...o]),
        arrays: c._arrays.map((a) => [...a]),
        hash: c.hashCode(),
        fields: Object.getOwnPropertyNames(c),
    };
}

/** The outcome of `f`, its error as plain data. */
async function outcome(f) {
    try {
        return { ok: await f() };
    } catch (e) {
        return { error: { class: e.constructor.name, message: e.message, messageName: e.messageName, properties: e.properties } };
    }
}

const utf8 = (text) => new TextEncoder().encode(text);

/** The output of a run on `input`, every file (with `pkg`'s API, this package's by default). */
async function run(input, lang, options = {}, pkg = qt) {
    const inputData = new pkg.InputData();
    inputData.addInput(input);
    return [...(await pkg.quicktypeMultiFile({ lang, inputData, ...options }))];
}

/** A JSON input for `lang` with `sources` ({ name, samples, jsonLines? }) added. */
async function inputOf(lang, sources, { sync = false, rendererOptions = {}, handleRefs = false, pkg = qt } = {}) {
    const input = pkg.jsonInputForTargetLanguage(lang, undefined, handleRefs, rendererOptions);
    for (const source of sources) {
        if (sync) input.addSourceSync(source);
        else await input.addSource(source);
    }

    return input;
}

/** The JSON Lines of a generated array (generate.mjs writes one element per line). */
function linesOf(array) {
    assert.ok(array.startsWith("[\n") && array.endsWith("\n]\n"));
    return `${array.slice(2, -3).split(",\n").join("\n")}\n`;
}

/** Values of every kind, one per line, and the JSON array of them. */
const records = [
    '{"id": 1, "name": "Ann", "tags": ["a", "b"], "born": "2020-01-01", "home": "https://example.com/a.png", "score": 1.5}',
    '{"id": 2, "name": "Bo", "tags": [], "born": "2021-02-03", "nested": {"ok": true, "n": null}, "score": 2}',
    '{"id": 9223372036854775808, "name": null, "uuid": "6ba7b810-9dad-11d1-80b4-00c04fd430c8", "é": "ü", "😀": ["\\ud83d\\ude00"]}',
    '{"id": 4, "kind": "card", "map": {"x1": 1, "x2": 2, "x3": 3, "x4": 4, "x5": 5, "x6": 6, "x7": 7, "x8": 8, "x9": 9, "x10": 10, "x11": 11, "x12": 12, "x13": 13, "x14": 14, "x15": 15, "x16": 16, "x17": 17, "x18": 18, "x19": 19, "x20": 20}}',
    '{"id": 5, "kind": "token", "__proto__": {"a": 1}, "2": [4], "1": "x", "d": {"$ref": "#/0"}}',
    '[1, "two", {"three": 3}]',
    '"a string value"',
    "42",
    "null",
];
const lines = `${records.join("\n")}\n`;
const array = `[${records.join(",")}]`;

/**
 * Languages and options: renderer options, the run's options (inference
 * flags), and those that change how samples are read (`$ref`s, the integer
 * range).
 */
const configurations = [
    ["typescript", {}],
    ["typescript", { rendererOptions: { "just-types": true }, options: { inferEnums: false, inferDateTimes: false } }],
    ["go", { options: { inferMaps: false, allPropertiesOptional: true } }],
    ["rust", { rendererOptions: { "integer-type": "force-i32", density: "dense" } }],
    ["kotlin", { handleRefs: true }],
    ["swift", { rendererOptions: { "just-types": true } }],
    ["cs", { options: { inferIntegerStrings: false, combineClasses: false } }],
    ["python", { rendererOptions: { "python-version": "3.7" } }],
    ["java", { options: { alphabetizeProperties: true } }],
    ["schema", {}],
    ["elm", {}],
    ["cjson", {}],
];

test("JSON Lines give what the JSON array of their values gives, in every language and with options", async () => {
    for (const [lang, { rendererOptions = {}, options = {}, handleRefs = false }] of configurations) {
        const what = `${lang} ${JSON.stringify({ rendererOptions, options, handleRefs })}`;
        const settings = { rendererOptions, handleRefs };
        const asArray = async (sync) => {
            const input = await inputOf(lang, [{ name: "Cards", samples: [array] }], { ...settings, sync });
            return { result: await run(input, lang, { ...options, rendererOptions }), inside: inside(input) };
        };
        const asLines = async (sync) => {
            const input = await inputOf(lang, [{ name: "Cards", samples: [lines], jsonLines: true }], { ...settings, sync });
            return { result: await run(input, lang, { ...options, rendererOptions }), inside: inside(input) };
        };
        const expected = await inMode("ts", () => asArray(false));
        for (const sync of [false, true]) {
            const before = { ...engineStats };
            const actual = await asLines(sync);
            assert.equal(engineStats.samplesRead, before.samplesRead + 1, `${what}: read by the engine`);
            assert.equal(engineStats.wasm, before.wasm + 1, `${what}: run on the engine`);
            // The same code, and the same tables: those of the array.
            assert.deepEqual(actual, expected, `${what} ${sync}`);
            assert.deepEqual(await inMode("ts", () => asLines(sync)), expected, `${what} ${sync}, TypeScript`);
        }

        // And with the engine's samples as they are, before any table is read.
        const input = await inputOf(lang, [{ name: "Cards", samples: [lines], jsonLines: true }], settings);
        const filled = engineStats.tablesFilled;
        assert.deepEqual(await run(input, lang, { ...options, rendererOptions }), expected.result, what);
        assert.equal(engineStats.tablesFilled, filled, `${what}: the run used the engine's samples`);
    }
});

test("JSON Lines as bytes and as strings, a Uint8Array or a Buffer", async () => {
    const forms = {
        string: (text) => text,
        Uint8Array: (text) => utf8(text),
        Buffer: (text) => Buffer.from(text),
        "a view at a non-zero byteOffset": (text) => {
            const bytes = utf8(text);
            const buffer = new Uint8Array(bytes.length + 9).fill(0x5b);
            buffer.set(bytes, 4);
            return new Uint8Array(buffer.buffer, 4, bytes.length);
        },
    };
    const expected = await inMode("ts", async () => {
        const input = await inputOf("rust", [{ name: "Cards", samples: [array] }]);
        return { result: await run(input, "rust"), inside: inside(input) };
    });
    for (const [form, make] of Object.entries(forms)) {
        for (const mode of [undefined, "ts"]) {
            for (const sync of [false, true]) {
                const before = engineStats.samplesRead;
                const actual = await inMode(mode, async () => {
                    const input = await inputOf("rust", [{ name: "Cards", samples: [make(lines)], jsonLines: true }], { sync });
                    return { result: await run(input, "rust"), inside: inside(input) };
                });
                assert.deepEqual(actual, expected, `${form} ${mode ?? "the engine"} ${sync}`);
                assert.equal(engineStats.samplesRead, before + (mode === undefined ? 1 : 0), `${form} ${mode}: who read it`);
            }
        }
    }

    // Bytes that are not UTF-8 are the text the decoder gives (U+FFFD for
    // what is not UTF-8), on both engines.
    const notUtf8 = new Uint8Array([...utf8('{"a": "x'), 0xff, 0xc3, 0x28, ...utf8('"}\n{"k'), 0x80, ...utf8('": [1], "k\u{fffd}": 2}\n')]);
    const decoded = new TextDecoder().decode(notUtf8);
    const replaced = await inMode("ts", async () => {
        const input = await inputOf("rust", [{ name: "Cards", samples: [decoded], jsonLines: true }]);
        return { result: await run(input, "rust"), inside: inside(input) };
    });
    assert.ok(replaced.inside.strings.some((s) => s.includes("\u{fffd}")));
    for (const mode of [undefined, "ts"]) {
        const actual = await inMode(mode, async () => {
            const input = await inputOf("rust", [{ name: "Cards", samples: [notUtf8], jsonLines: true }]);
            return { result: await run(input, "rust"), inside: inside(input) };
        });
        assert.deepEqual(actual, replaced, `not UTF-8, ${mode ?? "the engine"}`);
    }

    // The bytes are read when addSource is called: changing them afterwards changes nothing.
    const bytes = utf8(lines);
    const input = await inputOf("rust", [{ name: "Cards", samples: [bytes], jsonLines: true }]);
    bytes.fill(0x20);
    assert.deepEqual({ result: await run(input, "rust"), inside: inside(input) }, expected);
});

// Bytes are never decoded whole for JSON Lines, on either engine: those
// that are not UTF-8 too (the engine leaves them to the JSON Lines reader,
// which decodes each value by itself), so a sample too large to be one
// string reads the same on both. A decoder that fails on a value (one too
// long to be a string) is that error, not a syntax error. The limit of a
// string is faked here: the decoder throws what V8's does past it.
test("JSON Lines bytes that are not UTF-8, or too large for one string, read alike on both engines", async () => {
    const decode = TextDecoder.prototype.decode;
    const lines = [];
    for (let i = 0; i < 20_000; i++) lines.push(JSON.stringify({ id: i, name: `n${i % 50}`, tags: ["a", "b"].slice(i % 3) }));
    // A stray byte that is not UTF-8, in a string.
    const bytes = utf8(`${lines.join("\n")}\n{"id": 1, "name": "x~y"}\n`);
    bytes[bytes.lastIndexOf(0x7e)] = 0xff;
    let whole = 0;
    TextDecoder.prototype.decode = function (input, ...rest) {
        // Past the longest string: as V8, for anything as long as the sample.
        if (input !== undefined && input.length >= bytes.length) {
            whole++;
            throw new RangeError("Invalid string length");
        }
        if (input !== undefined && Buffer.from(input.buffer, input.byteOffset, input.length).includes("TOO LONG")) {
            throw new RangeError("Invalid string length");
        }
        return decode.call(this, input, ...rest);
    };
    try {
        const outcomes = {};
        for (const mode of [undefined, "ts"]) {
            outcomes[mode ?? "wasm"] = await inMode(mode, async () => {
                const input = await inputOf("go", [{ name: "Cards", samples: [bytes], jsonLines: true }]);
                return { result: await run(input, "go"), inside: inside(input) };
            });
        }
        assert.equal(whole, 0, "the sample was decoded whole");
        assert.deepEqual(outcomes.wasm, outcomes.ts);
        assert.ok(outcomes.ts.inside.strings.includes("x\u{fffd}y"));

        // A value that the decoder cannot make a string of (with a stray
        // byte, so that the engine leaves the sample to the JSON Lines reader).
        const tooLong = utf8('{"a": 1}\n{"b": "TOO LONG ~"}\n');
        tooLong[tooLong.lastIndexOf(0x7e)] = 0xff;
        for (const mode of [undefined, "ts"]) {
            const failed = await inMode(mode, () =>
                outcome(() => qt.jsonInputForTargetLanguage("go").addSource({ name: "Cards", samples: [tooLong], jsonLines: true })),
            );
            assert.deepEqual(failed.error, {
                class: "QuickTypeError",
                message: "Syntax error in input JSON Cards: line 2: the value is too long to be one JavaScript string (19 bytes): Invalid string length",
                messageName: "MiscJSONParseError",
                properties: { description: "input", address: "Cards", message: "line 2: the value is too long to be one JavaScript string (19 bytes): Invalid string length" },
            }, mode ?? "the engine");
        }
    } finally {
        TextDecoder.prototype.decode = decode;
    }

    // Without the fake, the text the decoder gives, read as JSON Lines.
    const expected = await inMode("ts", async () => {
        const input = await inputOf("go", [{ name: "Cards", samples: [new TextDecoder().decode(bytes)], jsonLines: true }]);
        return { result: await run(input, "go"), inside: inside(input) };
    });
    const actual = await inputOf("go", [{ name: "Cards", samples: [bytes], jsonLines: true }]);
    assert.deepEqual({ result: await run(actual, "go"), inside: inside(actual) }, expected);
});

// The scanner is written twice, for strings and for bytes: the two find
// the same values, on the same lines, in text that is JSON Lines and in
// text that is not (the playground's quicktype side takes the ranges too).
test("the scanner finds the same values in a string and in its bytes", () => {
    let seed = 12345;
    const random = (n) => (seed = (seed * 1103515245 + 12345) % 2147483648) % n;
    const pieces = ["{", "}", "[", "]", '"', "\\", ",", ":", " ", "\t", "\r", "\n", "\n", "a", "1", "-2.5e3", "true", "null", "é", "😀", "\u{feff}", '"x"', '{"k": [1, "v"]}'];
    const texts = [lines, array, ...invalid.map(([text]) => text), "", "\u{feff}", "\u{feff}\u{feff}1\n2", '"a\\"b"\n"c"'];
    for (let i = 0; i < 2000; i++) texts.push(Array.from({ length: random(40) }, () => pieces[random(pieces.length)]).join(""));
    const ranges = (source, text) => {
        const found = [];
        scanJSONLines(source, (start, end, ownLine) => found.push([text(start, end), ownLine]));
        return found;
    };
    for (const text of texts) {
        const bytes = utf8(text);
        // The bytes are the text the decoder gives (without its byte order mark).
        const decoded = new TextDecoder().decode(bytes);
        const inBytes = ranges(bytes, (start, end) => new TextDecoder("utf-8", { ignoreBOM: true }).decode(bytes.subarray(start, end)));
        assert.deepEqual(inBytes, ranges(decoded, (start, end) => decoded.slice(start, end)), JSON.stringify(text));
    }
});

test("a byte order mark, CRLF, blank lines, values over several lines, no values", async () => {
    const pretty = records.map((r) => JSON.stringify(JSON.parse(r), undefined, 2)).join("\n");
    const same = {
        "no final line break": records.join("\n"),
        "CRLF": `${records.join("\r\n")}\r\n`,
        "blank lines and whitespace": `\n\n  \t\n${records.join("\n\n \r\n")}\n\n\t \n`,
        "CRLF blank lines": `\r\n\r\n${records.join("\r\n\r\n")}\r\n\r\n`,
        "a byte order mark": `\u{feff}${lines}`,
        "a byte order mark and CRLF": `\u{feff}${records.join("\r\n")}`,
        "values over several lines": pretty,
        "values over several lines, CRLF": pretty.replaceAll("\n", "\r\n"),
        "whitespace around values": records.map((r) => ` \t${r}\t `).join("\n"),
    };
    const expectedFor = (sample) =>
        inMode("ts", async () => {
            const input = await inputOf("typescript", [{ name: "T", samples: [sample] }]);
            return { result: await run(input, "typescript"), inside: inside(input) };
        });
    const linesRun = (mode, sample) =>
        inMode(mode, async () => {
            const input = await inputOf("typescript", [{ name: "T", samples: [sample], jsonLines: true }]);
            return { result: await run(input, "typescript"), inside: inside(input) };
        });
    const expected = await expectedFor(array);
    for (const [what, text] of Object.entries(same)) {
        for (const mode of [undefined, "ts"]) {
            assert.deepEqual(await linesRun(mode, text), expected, `${what} ${mode ?? "the engine"}`);
            assert.deepEqual(await linesRun(mode, utf8(text)), expected, `${what} ${mode ?? "the engine"}, bytes`);
        }
    }

    // As bytes, the decoder's byte order mark and then one of the text's.
    const twice = new Uint8Array([0xef, 0xbb, 0xbf, ...utf8(`\u{feff}${lines}`)]);
    for (const mode of [undefined, "ts"]) assert.deepEqual(await linesRun(mode, twice), expected, `two byte order marks ${mode}`);

    // No values: an empty array; one value: an array of one.
    const empty = await expectedFor("[]");
    for (const text of ["", "\n", " \r\n\t\n\n", "\u{feff}", "\u{feff}\r\n"]) {
        for (const mode of [undefined, "ts"]) {
            assert.deepEqual(await linesRun(mode, text), empty, `${JSON.stringify(text)} ${mode}`);
            assert.deepEqual(await linesRun(mode, utf8(text)), empty, `${JSON.stringify(text)} ${mode}, bytes`);
        }
    }

    const one = await expectedFor(`[${records[0]}]`);
    for (const mode of [undefined, "ts"]) assert.deepEqual(await linesRun(mode, `${records[0]}\n`), one, `one value ${mode}`);
});

/** JSON Lines that are not, the line named in their error, and the error's message after `line N: `. */
const invalid = [
    // A second value on a line: no position, as in the CLI's error.
    ['{"a": 1}\n{"a": 2} {"a": 3}\n', 2, "Unexpected non-whitespace character after JSON"],
    ['{\n  "a": 1\n} {}', 3, "Unexpected non-whitespace character after JSON"],
    ['{"a": 1}\n\n{"a": }\n', 3, `Unexpected token '}', "{"a": }" is not valid JSON`],
    ["[1,\n", 1, "Unexpected end of JSON input"],
    ['{"a": 1}\r\n{"a":\r\n', 2, "Unexpected end of JSON input"],
    ["1\r2\n", 1, "Unexpected non-whitespace character after JSON"],
    ["1\n2\n3 4\n5\n", 3, "Unexpected non-whitespace character after JSON"],
    ['\u{feff}{}\n{]\n', 2, "Expected property name or '}' in JSON at position 1"],
    // A byte order mark only once (as bytes, the decoder's and then the text's).
    ['\u{feff}\u{feff}\u{feff}{}\n', 1, /^Unexpected token/],
    ['{"a": 1}\n{\n  "b": [1,\n  2,,\n]}\n', 2, /^Unexpected token ','/],
    ['{"a": "x}\n{"b": 1}\n', 1, "Bad control character in string literal in JSON at position 9"],
    ['{"a": 1}\n{"a": 2}x\n', 2, "Unexpected non-whitespace character after JSON"],
    // But one token that is not JSON is JSON.parse's error for it.
    ["1\n2x\n", 2, "Unexpected non-whitespace character after JSON at position 1"],
    ["{}\n]\n", 2, /^Unexpected token '\]'/],
    ["true\nTrue\n", 2, /^Unexpected token 'T'/],
    ["1\n01\n", 2, /^Unexpected number in JSON at position 1|^Unexpected token/],
    ["{}{}\n", 1, "Unexpected non-whitespace character after JSON"],
    ["x".repeat(100), 1, /^Unexpected token 'x'/],
];

test("a sample that is not JSON Lines fails in addSource, naming its line", async () => {
    for (const [bad, line, message] of invalid) {
        for (const form of ["string", "bytes"]) {
            for (const sync of [false, true]) {
                const what = `${JSON.stringify(bad)} ${form} ${sync}`;
                const attempt = async () => {
                    const input = await inputOf("rust", [{ name: "Good", samples: ['{"a": [1]}\n{"a": [2]}'], jsonLines: true }]);
                    const sample = form === "bytes" ? utf8(bad) : bad;
                    const add = { name: "Bad", samples: ['{"b": {"c": 2}}\n', sample, "[3]"], jsonLines: true };
                    const failed = await outcome(async () => (sync ? input.addSourceSync(add) : input.addSource(add)));
                    await input.addSource({ name: "After", samples: ['{"d": [{}]}'] });
                    return { failed, result: await run(input, "rust"), state: inside(input) };
                };
                const expected = await inMode("ts", attempt);
                assert.equal(expected.failed.error?.messageName, "MiscJSONParseError", what);
                const prefix = `Syntax error in input JSON Bad: line ${line}: `;
                assert.ok(expected.failed.error.message.startsWith(prefix), `${what}: ${expected.failed.error.message}`);
                const rest = expected.failed.error.message.slice(prefix.length);
                if (message instanceof RegExp) assert.match(rest, message, what);
                else assert.equal(rest, message, what);
                assert.deepEqual(expected.failed.error.properties, { description: "input", address: "Bad", message: `line ${line}: ${rest}` }, what);
                // The engine gives the same error, and the input the same state.
                assert.deepEqual(await attempt(), expected, what);
            }
        }
    }

    // With a description, as for JSON.
    const described = await outcome(() =>
        qt.jsonInputForTargetLanguage("go").addSource({ name: "Cards", samples: ["{}\n{"], description: "The cards", jsonLines: true }),
    );
    assert.equal(described.error.message, "Syntax error in The cards JSON Cards: line 2: Expected property name or '}' in JSON at position 1");
});

test("without jsonLines, a sample is JSON, as in quicktype", async () => {
    const attempt = (jsonLines) => async () => {
        const input = qt.jsonInputForTargetLanguage("typescript");
        const add = jsonLines === undefined ? { name: "T", samples: [lines] } : { name: "T", samples: [lines], jsonLines };
        return outcome(() => input.addSource(add));
    };
    const expected = await inMode("ts", attempt(undefined));
    // V8's error for the text as one JSON value, without a line.
    assert.match(expected.error.message, /^Syntax error in input JSON T: Unexpected non-whitespace character after JSON at position \d+ \(line 2 column 1\)$/);
    for (const jsonLines of [undefined, false, 0, "true", 1]) {
        assert.deepEqual(await attempt(jsonLines)(), expected, String(jsonLines));
    }

    // One value, which quicktype reads as that value.
    const single = async (jsonLines) => {
        const input = await inputOf("go", [{ name: "T", samples: [records[0]], ...(jsonLines ? { jsonLines } : {}) }]);
        return run(input, "go");
    };
    assert.notDeepEqual(await single(true), await single(false));
    assert.deepEqual(await single(false), await inMode("ts", async () => run(await inputOf("go", [{ name: "T", samples: [records[0]] }]), "go")));
});

test("several JSON Lines samples, and JSON Lines beside JSON", async () => {
    const half = Math.ceil(records.length / 2);
    const first = records.slice(0, half);
    const second = records.slice(half);
    const expected = await inMode("ts", async () => {
        const input = await inputOf("cs", [
            { name: "Cards", samples: [`[${first.join(",")}]`, `[${second.join(",")}]`] },
            { name: "Single", samples: [records[0]] },
            { name: "Cards", samples: ["[]"] },
        ]);
        return { result: await run(input, "cs"), inside: inside(input) };
    });
    for (const mode of [undefined, "ts"]) {
        for (const sync of [false, true]) {
            const actual = await inMode(mode, async () => {
                const input = await inputOf(
                    "cs",
                    [
                        { name: "Cards", samples: [first.join("\n"), utf8(second.join("\r\n"))], jsonLines: true },
                        { name: "Single", samples: [records[0]] },
                        { name: "Cards", samples: [""], jsonLines: true },
                    ],
                    { sync },
                );
                return { result: await run(input, "cs"), inside: inside(input) };
            });
            assert.deepEqual(actual, expected, `${mode ?? "the engine"} ${sync}`);
        }
    }

    // Concurrent addSource calls on one input interleave as on TypeScript.
    const concurrent = async () => {
        const input = qt.jsonInputForTargetLanguage("cs");
        await Promise.all([
            input.addSource({ name: "A", samples: ['{"a": 1}\n{"a": 2}', "[1]\n[2]"], jsonLines: true }),
            input.addSource({ name: "B", samples: ['{"b": [1]}'] }),
            input.addSource({ name: "A", samples: ['{"c": {}}'], jsonLines: true }),
        ]);
        return { result: await run(input, "cs"), inside: inside(input) };
    };
    assert.deepEqual(await concurrent(), await inMode("ts", concurrent));
});

test("JSON Lines that TypeScript reads itself, and the samples after them", async () => {
    const deep = (n) => "[".repeat(n) + "]".repeat(n);
    const cases = [
        ["deeper than the engine reads", `${deep(3)}\n${deep(300)}\n${deep(2)}`],
        ["a lone surrogate escape", '[1]\n["\\ud800"]\n[2]'],
        ["a lone surrogate in the text", '[1]\n["\ud800"]\n[2]'],
    ];
    for (const [name, text] of cases) {
        const attempt = async () => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "T", samples: ['{"x": 1}'] });
            await input.addSource({ name: "T", samples: [text], jsonLines: true });
            await input.addSource({ name: "U", samples: ['{"y": [2]}\n{"y": []}'], jsonLines: true });
            return { result: await run(input, "typescript"), inside: inside(input) };
        };
        const expected = await inMode("ts", attempt);
        const before = { ...engineStats };
        assert.deepEqual(await attempt(), expected, name);
        assert.equal(engineStats.tablesFilled, before.tablesFilled + 1, name);
    }
});

test("JSON Lines read by an instance that failed are read again by TypeScript", async () => {
    // The package with the test-hooks engine (test/hooks.mjs), whose
    // `__panicForTests` traps the instance; the shipped engine has none.
    const hooks = hooksPackage();
    hooks.engine.engineSync();
    const add = async () =>
        inputOf("rust", [{ name: "Cards", samples: [lines, utf8(`\u{feff}${records.join("\r\n")}`)], jsonLines: true }, { name: "Json", samples: [array] }], {
            pkg: hooks.qt,
        });
    const expected = await inMode("ts", async () => {
        const input = await add();
        return { result: await run(input, "rust", {}, hooks.qt), inside: inside(input) };
    });
    for (const kept of [true, false]) {
        // Kept (small inputs), or taken from the failed instance's memory.
        const old = kept ? undefined : hooks.nativeSamples.setKeptTexts(0);
        try {
            const input = await add();
            const glue = hooks.engine.engineSync();
            assert.throws(() => glue.__panicForTests(), WebAssembly.RuntimeError);
            hooks.engine.discardEngine(glue);
            const before = { ...hooks.engineStats };
            assert.deepEqual({ result: await run(input, "rust", {}, hooks.qt), inside: inside(input) }, expected, kept ? "kept" : "not kept");
            assert.equal(hooks.engineStats.tablesFilled, before.tablesFilled + 1);
        } finally {
            if (old !== undefined) hooks.nativeSamples.setKeptTexts(old);
        }
    }
});

test("JSON Lines are read by a CompressedJSONFromString whose parse and parseSync are its own", async () => {
    // A subclass: read by TypeScript, with its own methods, which JSON
    // Lines go through: process once per value, inside the array's context.
    const calls = [];
    class Mine extends CompressedJSONFromString {
        process(json) {
            if (this._contextStack.length === 0) calls.push(json);
            return super.process(json);
        }
    }
    const mine = new qt.JSONInput(new Mine(new DefaultDateTimeRecognizer(), false));
    await mine.addSource({ name: "Cards", samples: [lines], jsonLines: true });
    assert.deepEqual(calls, records.map((r) => JSON.parse(r)));
    calls.length = 0;
    const theirs = new qt.JSONInput(new Mine(new DefaultDateTimeRecognizer(), false));
    await theirs.addSource({ name: "Cards", samples: [array] });
    assert.deepEqual(await run(mine, "typescript"), await run(theirs, "typescript"));
    assert.deepEqual(inside(mine), inside(theirs));

    // One whose parse or parseSync is overridden (by a subclass or on the
    // instance), which JSON Lines do not go through, and any other
    // CompressedJSON, cannot read them: addSource and addSourceSync throw
    // an Error that says so, not quicktype's "Syntax error" around what a
    // sample's text is, and before reading any sample.
    class Parsed extends CompressedJSONFromString {
        parseSync(input) {
            return super.parseSync(input);
        }
    }
    class Other extends CompressedJSON {
        async parse() {
            return this.parseSync();
        }
    }
    const replaced = new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false);
    replaced.parse = async (input) => replaced.parseSync(input);
    for (const cjson of [new Parsed(new DefaultDateTimeRecognizer(), false), new Other(new DefaultDateTimeRecognizer(), false), replaced]) {
        for (const sync of [false, true]) {
            const input = new qt.JSONInput(cjson);
            const add = { name: "Cards", samples: [lines, "not read"], jsonLines: true };
            const failed = await outcome(async () => (sync ? input.addSourceSync(add) : input.addSource(add)));
            assert.deepEqual(failed.error, {
                class: "Error",
                message:
                    "quickertype-core: JSON Lines samples (jsonLines: true) are read by a CompressedJSONFromString whose parse and parseSync are not overridden; this input's CompressedJSON is not one",
                messageName: undefined,
                properties: undefined,
            }, `${cjson.constructor.name} ${sync}`);
            assert.deepEqual(input._topLevels.size, 0);
        }
    }

    // Their JSON samples are read as before.
    const parsed = new qt.JSONInput(new Parsed(new DefaultDateTimeRecognizer(), false));
    await parsed.addSource({ name: "Cards", samples: [array] });
    assert.deepEqual(await run(parsed, "typescript"), await run(theirs, "typescript"));
});

// A line that fails leaves the tables as they were before the sample (what
// the values before it added goes), and the values are handed to process
// one by one as they are parsed, never all held at once.
test("JSON Lines read value by value, and a failed sample leaves the tables as they were", async () => {
    const good = '{"a": [1, {"b": "x"}]}\n{"c": "2020-01-01"}';
    const bad = '{"new": ["strings", {"deep": "here"}]}\n{"more": 1}\n{"bad": }\n';
    const after = '{"d": [true]}\n{"d": []}';
    // Without the failed sample.
    const reference = (withAfter) =>
        inMode("ts", async () => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "Good", samples: [good], jsonLines: true });
            if (withAfter) await input.addSource({ name: "After", samples: [after], jsonLines: true });
            return { result: await run(input, "typescript"), inside: inside(input) };
        });
    const [expectedBefore, expectedAfter] = [await reference(false), await reference(true)];
    // TypeScript reads the bad sample (and rolls back), the engine finds
    // it is not JSON Lines (and TypeScript only looks for its line), or
    // TypeScript reads it after the engine's tables were filled.
    for (const [mode, fill] of [["ts", false], [undefined, false], [undefined, true]]) {
        const what = `${mode ?? "the engine"}${fill ? ", the tables filled first" : ""}`;
        const before = { ...engineStats };
        const input = await inMode(mode, async () => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "Good", samples: [good], jsonLines: true });
            if (fill) void input._compressedJSON._strings;
            const failed = await outcome(() => input.addSource({ name: "Bad", samples: [bad], jsonLines: true }));
            assert.equal(failed.error?.message, `Syntax error in input JSON Bad: line 3: Unexpected token '}', "{"bad": }" is not valid JSON`, what);
            return input;
        });
        if (mode === undefined && !fill) assert.equal(engineStats.tablesFilled, before.tablesFilled, `${what}: the tables were not filled`);
        assert.deepEqual({ result: await run(input, "typescript"), inside: inside(input) }, expectedBefore, what);
        await inMode(mode, () => input.addSource({ name: "After", samples: [after], jsonLines: true }));
        assert.deepEqual({ result: await run(input, "typescript"), inside: inside(input) }, expectedAfter, what);
    }

    // Parsed and processed in turn: JSON.parse of the second value comes
    // after the first was processed.
    const events = [];
    class Watched extends CompressedJSONFromString {
        process(json) {
            if (this._contextStack.length === 0) events.push("process");
            return super.process(json);
        }
    }
    const parse = JSON.parse;
    JSON.parse = (text, ...rest) => {
        events.push("parse");
        return parse(text, ...rest);
    };
    try {
        new qt.JSONInput(new Watched(new DefaultDateTimeRecognizer(), false)).addSourceSync({ name: "T", samples: ["1\n[2]\n{}"], jsonLines: true });
    } finally {
        JSON.parse = parse;
    }
    assert.deepEqual(events, ["parse", "process", "parse", "process", "parse", "process"]);
});

test("addSource settles after as many ticks on both engines", async () => {
    const ticks = async (samples) => {
        const input = qt.jsonInputForTargetLanguage("typescript");
        let done = false;
        const settled = input.addSource({ name: "T", samples, jsonLines: true }).then(
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
    for (const list of [["[1]"], ["[1]\n[2]", '{"a": 2}', "3\n4"], ["[1]", "[1,"]]) {
        assert.deepEqual(await ticks(list), await inMode("ts", () => ticks(list)), JSON.stringify(list));
    }
});

// A large file read as bytes, as `fs.readFileSync(path)` gives it: the
// engine reads the bytes as they are, into the same code as the array,
// and an error on the last of its lines names that line.
test("large JSON Lines through bytes", { timeout: 300_000 }, async () => {
    for (const [name, arrayText] of [
        ["cards", generateCards(9_000)],
        ["rulings", generateRulings(160_000)],
    ]) {
        const linesText = linesOf(arrayText);
        const count = linesText.split("\n").length - 1;
        const bytes = Buffer.from(linesText);
        assert.ok(bytes.length > 35e6, `${name}: ${bytes.length} bytes`);
        const before = { ...engineStats };
        const start = performance.now();
        const input = await inputOf("typescript", [{ name: "Cards", samples: [bytes], jsonLines: true }]);
        const read = performance.now() - start;
        const result = await run(input, "typescript");
        const ms = performance.now() - start;
        assert.equal(engineStats.samplesRead, before.samplesRead + 1, `${name}: read by the engine`);
        nativeSamples.releaseJSONInput(input);
        const expected = await run(await inputOf("typescript", [{ name: "Cards", samples: [Buffer.from(arrayText)] }]), "typescript");
        assert.deepEqual(result, expected, name);
        console.log(`# ${name}: ${count} lines, ${(bytes.length / 1e6).toFixed(1)} MB: read in ${read.toFixed(0)} ms, generated in ${(ms - read).toFixed(0)} ms`);

        // An error on the last line, and one in the middle.
        const lastBad = Buffer.concat([bytes, Buffer.from('{"object": "card",}\n')]);
        const failed = await outcome(() => qt.jsonInputForTargetLanguage("typescript").addSource({ name: "Cards", samples: [lastBad], jsonLines: true }));
        assert.equal(failed.error?.message, `Syntax error in input JSON Cards: line ${count + 1}: Expected double-quoted property name in JSON at position 18`);
        const middle = Buffer.from(`${linesText.split("\n").slice(0, 1000).join("\n")}\n{"x": 1} {"y": 2}\n${linesText}`);
        const failedMiddle = await outcome(() => qt.jsonInputForTargetLanguage("typescript").addSource({ name: "Cards", samples: [middle], jsonLines: true }));
        assert.equal(failedMiddle.error?.message, "Syntax error in input JSON Cards: line 1001: Unexpected non-whitespace character after JSON");
    }
});
