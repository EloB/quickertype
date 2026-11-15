// Samples read in parts on several engine instances (src/native/parallel.ts,
// crates/quicktype-wasm/src/parts.rs; not public API, the playground's
// workers use it): the parts are summarized, split and tallied on
// instances of their own (here in this process, each a glue of its own,
// with its own memory and hash seed), appended in order on the engine
// instance runs use, and every run gives exactly what reading the sample
// in one go gives. Where the parts do not read, or the CLI's reader would
// read in one go, they are not read in parts at all, and the caller reads
// the sample in one go, with its errors.
//
//   node --test test/parallel.test.mjs test/parallel.hooks.test.mjs   (after `npm run build`
//   and `node script/test-hooks.mjs`; npm test runs both)
//
// Every test runs on both packages (test/hooks.mjs): on the shipped one, and
// from parallel.hooks.test.mjs on the test-hooks one, where they also check
// that no tallies or leases are left (`__partsCount`, which the shipped
// engine does not export).

import assert from "node:assert/strict";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { test } from "node:test";

import { generateCards, generateRulings } from "./bench/generate.mjs";
import { runPackage } from "./hooks.mjs";

const require = createRequire(import.meta.url);
const { qt, engineStats, engine, nativeSamples, hasHooks, dist } = runPackage();
const { releaseJSONInput, tablesFailed } = nativeSamples;
const { CompressedJSONFromString } = require(path.join(dist, "input", "CompressedJSON.js"));
const { PartReader, readJSONInputInParts } = require(path.join(dist, "native", "parallel.js"));
const { createGlue } = require(path.join(dist, "native", "wasm", "glue.js"));

const engineKey = Symbol.for("quicktype-core.engine");
const main = engine.engineSync();
const wasmModule = new WebAssembly.Module(fs.readFileSync(path.join(dist, "native", "wasm", "quicktype_wasm_bg.wasm")));

/**
 * That `glue` keeps `expected` [parts' tallies, leases on them]: checked on
 * the test-hooks engine, which counts them (`__partsCount`).
 */
function partsCount(glue, expected, message) {
    if (hasHooks) assert.deepEqual([...glue.__partsCount()], expected, message);
}

/** An engine instance of its own, as a worker has. */
function instance() {
    const glue = createGlue();
    glue.initSync({ module: wasmModule });
    return glue;
}

/** Instances for the workers, made once. */
const instances = Array.from({ length: 5 }, instance);

/** `n` workers on instances of their own, reading `bytes`. */
function workersFor(bytes, n) {
    const read = async (from, to) => bytes.slice(from, to);
    return instances.slice(0, n).map((glue) => new PartReader(glue, read));
}

const utf8 = (text) => new TextEncoder().encode(text);

/** The outcome of `f`, its error as plain data. */
async function outcome(f) {
    try {
        return { ok: await f() };
    } catch (e) {
        return { error: { class: e.constructor.name, message: e.message, messageName: e.messageName } };
    }
}

/** Every file of a run on `input`. */
async function run(input, lang, options = {}) {
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return [...(await qt.quicktypeMultiFile({ lang, inputData, ...options }))].map(([name, r]) => [name, r.lines.join("\n")]);
}

/** Everything of an input: its top levels and its tables (which fills them). */
function inside(input) {
    const c = input._compressedJSON;
    return {
        topLevels: [...input._topLevels].map(([name, t]) => [name, t.description, [...t.samples]]),
        strings: [...c._strings],
        objects: c._objects.map((o) => [...o]),
        arrays: c._arrays.map((a) => [...a]),
    };
}

/** `bytes` read in one go, as the playground reads a file: `addSource`. */
async function inOneGo(lang, bytes, lines, { handleRefs = false, rendererOptions = {} } = {}) {
    const input = qt.jsonInputForTargetLanguage(lang, undefined, handleRefs, rendererOptions);
    const added = await outcome(() => input.addSource(lines ? { name: "Things", samples: [bytes], jsonLines: true } : { name: "Things", samples: [bytes] }));
    return { input, added };
}

/**
 * `bytes` read in parts on `workers` workers with ranges of at most
 * `range` bytes, and in one go where they are not: the input, and how it
 * was read.
 */
async function inParts(lang, bytes, lines, { workers = 3, range, handleRefs = false, rendererOptions = {}, reread = true } = {}) {
    const input = qt.jsonInputForTargetLanguage(lang, undefined, handleRefs, rendererOptions);
    const source = {
        name: "Things",
        lines,
        size: bytes.length,
        read: async (from, to) => bytes.slice(from, to),
        reread: reread ? () => bytes : undefined,
    };
    const read = await readJSONInputInParts(input, source, workersFor(bytes, workers), { minLength: 0, range });
    if (read.read === true) return { input, read, added: { ok: undefined } };
    // As the playground does: then in one go.
    const added = await outcome(() => input.addSource(lines ? { name: "Things", samples: [bytes], jsonLines: true } : { name: "Things", samples: [bytes] }));
    return { input, read, added };
}

/** The JSON Lines of a generated array (one element per line). */
function linesOf(array) {
    assert.ok(array.startsWith("[") && array.trimEnd().endsWith("]"));
    return `${JSON.parse(array).map((v) => JSON.stringify(v)).join("\n")}\n`;
}

/** No parts' tallies or leases are left on the workers' instances. */
function workersClean(what) {
    for (const glue of instances) partsCount(glue, [0, 0], `${what}: a worker kept tallies`);
}

const rulings = generateRulings(3_000);
const cards = generateCards(400);
/** Text-heavy: long strings, many of them alike (rulings' comments, longer). */
const articles = JSON.stringify(
    Array.from({ length: 800 }, (_, i) => ({
        id: i,
        title: `Article ${i % 37}`,
        body: `${"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ".repeat(3 + (i % 9))}${i}`,
        tags: ["a", "b", "c", "d"].slice(0, i % 5),
        published: `2020-0${1 + (i % 9)}-1${i % 9}T10:00:00Z`,
    })),
);
/** URI-heavy: every kind of URI (ports, user info, queries, IPv6, no extension). */
const uris = JSON.stringify(
    Array.from({ length: 1500 }, (_, i) => ({
        api: `https://api.example.com/cards/${i}`,
        image: `https://img.example.com/${i % 13}/${i}.${["png", "jpg", "JPG", "webp"][i % 4]}?v=${i}`,
        odd: [`http://user:pw@h.example:8080/a/b${i}.png#f`, `ftp://files.example/pub/x${i}.tar.gz`, `http://[::1]:80/i${i}.gif`][i % 3],
        maybe: i % 7 === 0 ? null : `https://h${i % 5}.example/p`,
    })),
);

const inputs = [
    ["records (rulings)", rulings],
    ["text-heavy", articles],
    ["URI-heavy", uris],
    ["cards", cards],
];

test("parts read on several instances give what reading in one go gives: every file of every run, and the tables", { timeout: 600_000 }, async () => {
    const configurations = [
        ["typescript", {}],
        ["go", { options: { inferMaps: false, allPropertiesOptional: true } }],
        ["rust", { rendererOptions: { "integer-type": "force-i32" } }],
        ["kotlin", { handleRefs: true }],
        ["cs", { options: { inferEnums: false, inferDateTimes: false } }],
        ["schema", {}],
    ];
    const before = engineStats.readInParts;
    let readInParts = 0;
    for (const [name, text] of inputs) {
        for (const lines of [false, true]) {
            const bytes = utf8(lines ? linesOf(text) : text);
            for (const [lang, { options = {}, rendererOptions = {}, handleRefs = false }] of configurations) {
                const what = `${name}${lines ? " as JSON Lines" : ""}, ${lang} ${JSON.stringify(options)}`;
                const settings = { handleRefs, rendererOptions };
                const one = await inOneGo(lang, bytes, lines, settings);
                const expected = await outcome(() => run(one.input, lang, { ...options, rendererOptions }));
                for (const [workers, range] of [[2, 1 << 14], [3, 4099], [5, 997]]) {
                    const parts = await inParts(lang, bytes, lines, { ...settings, workers, range });
                    assert.equal(parts.read.read, true, `${what}: not read in parts (${parts.read.inOneGo})`);
                    readInParts++;
                    assert.ok(parts.read.parts > 4, `${what}: ${parts.read.parts} parts`);
                    const got = await outcome(() => run(parts.input, lang, { ...options, rendererOptions }));
                    assert.deepEqual(got, expected, `${what}, ${workers} workers, ranges of ${range}`);
                    // A second run on the same input, as the playground's next one.
                    assert.deepEqual(await outcome(() => run(parts.input, lang, { ...options, rendererOptions })), expected, `${what}: again`);
                    releaseJSONInput(parts.input);
                }
            }
            // The tables, should anything read them, are TypeScript's for the sample (read again).
            const one = await inOneGo("typescript", bytes, lines);
            const parts = await inParts("typescript", bytes, lines, { range: 2048 });
            assert.equal(parts.read.read, true);
            const expectedInside = inside(one.input);
            const filled = engineStats.tablesFilled;
            assert.deepEqual(inside(parts.input), expectedInside, `${name}: the tables`);
            assert.equal(engineStats.tablesFilled, filled + 1);
            workersClean(name);
        }
    }

    assert.equal(engineStats.readInParts - before, readInParts + inputs.length * 2);
    partsCount(main, [0, 0], "the tallies of every input released");
});

test("a run on the TypeScript engine fills the tables by reading the sample again, and gives what it gives", async () => {
    const bytes = utf8(rulings);
    const one = await inOneGo("go", bytes, false);
    const expected = await run(one.input, "go");
    const parts = await inParts("go", bytes, false, { range: 4096 });
    assert.equal(parts.read.read, true);
    globalThis[engineKey] = "ts";
    let onTypeScript;
    try {
        const ts = engineStats.ts;
        onTypeScript = await run(parts.input, "go");
        assert.equal(engineStats.ts, ts + 1);
    } finally {
        delete globalThis[engineKey];
    }

    assert.deepEqual(onTypeScript, expected);
    // The tables are TypeScript's now: runs on the engine send them.
    assert.deepEqual(await run(parts.input, "go"), expected);
    partsCount(main, [0, 0]);
    // Without a way to read the sample again, the tables cannot be had;
    // the tallies stay, for runs on the engine.
    const lost = await inParts("go", bytes, false, { range: 4096, reread: false });
    assert.equal(lost.read.read, true);
    assert.throws(() => lost.input._compressedJSON._strings, /^Error: quicktype-core: the tables cannot be had for this input: the sample was read in parts, and cannot be read again$/);
    assert.throws(() => lost.input._compressedJSON._objects, /the tables cannot be had for this input/);
    assert.equal(tablesFailed(lost.input), true);
    assert.deepEqual(await run(lost.input, "go"), expected);
    releaseJSONInput(lost.input);
    partsCount(main, [0, 0]);
});

test("tables that cannot be had leave the input as it was: a failed run on TypeScript, then runs on the engine; later uses fail at once", async () => {
    for (const lines of [false, true]) {
        const bytes = utf8(lines ? linesOf(rulings) : rulings);
        const one = await inOneGo("go", bytes, lines);
        const expected = await run(one.input, "go");
        // The sample read again fails in every way it can: reading it
        // throws (a RangeError, as decoding a text too long for one string
        // does), or it is not what was read (cut short, not JSON).
        const failures = [
            () => {
                throw new RangeError("Invalid string length");
            },
            () => bytes.slice(0, bytes.length >> 1),
            () => utf8("[1, "),
        ];
        for (const failing of failures) {
            let rereads = 0;
            const input = qt.jsonInputForTargetLanguage("go");
            const source = {
                name: "Things",
                lines,
                size: bytes.length,
                read: async (f, t) => bytes.slice(f, t),
                reread: () => {
                    rereads++;
                    return failing();
                },
            };
            assert.equal((await readJSONInputInParts(input, source, workersFor(bytes, 3), { minLength: 0, range: 4096 })).read, true);
            globalThis[engineKey] = "ts";
            let failed;
            try {
                failed = await outcome(() => run(input, "go"));
            } finally {
                delete globalThis[engineKey];
            }

            assert.match(failed.error?.message ?? "", /^quicktype-core: the tables cannot be had for this input: /, `lines ${lines}: ${JSON.stringify(failed)}`);
            assert.equal(tablesFailed(input), true);
            assert.equal(rereads, 1);
            // As it was: its tallies, for runs on the engine; and the tables
            // fail at once, with the same error, without reading again.
            partsCount(main, [1, 0]);
            let again;
            try {
                void input._compressedJSON._strings;
            } catch (e) {
                again = e;
            }

            assert.equal(again?.message, failed.error.message);
            assert.equal(rereads, 1, "the sample read again after the tables failed");
            assert.deepEqual(await run(input, "go"), expected, `lines ${lines}: a run on the engine after the tables failed`);
            assert.equal(rereads, 1);
            releaseJSONInput(input);
            assert.equal(tablesFailed(input), false);
        }

        partsCount(main, [0, 0]);
        releaseJSONInput(one.input);
    }
});

test("JSON Lines read again for the tables are read value by value, not as one array", async () => {
    const bytes = utf8(linesOf(rulings));
    const values = JSON.parse(rulings).length;
    const one = await inOneGo("typescript", bytes, true);
    const parts = await inParts("typescript", bytes, true, { range: 4096 });
    assert.equal(parts.read.read, true);
    const process = CompressedJSONFromString.prototype.process;
    let largest = 0;
    CompressedJSONFromString.prototype.process = function (json) {
        if (Array.isArray(json)) largest = Math.max(largest, json.length);
        return process.call(this, json);
    };
    let filled;
    try {
        filled = inside(parts.input);
    } finally {
        CompressedJSONFromString.prototype.process = process;
    }

    assert.ok(largest < values, `an array of ${largest} values was processed (the sample has ${values})`);
    assert.deepEqual(filled, inside(one.input));
});

test("another sample added after one read in parts: TypeScript reads both, as addSource would", async () => {
    const bytes = utf8(cards);
    const one = await inOneGo("typescript", bytes, false);
    await one.input.addSource({ name: "Things", samples: ['{"extra": 1}'] });
    const parts = await inParts("typescript", bytes, false, { range: 4096 });
    assert.equal(parts.read.read, true);
    await parts.input.addSource({ name: "Things", samples: ['{"extra": 1}'] });
    assert.deepEqual(await run(parts.input, "typescript"), await run(one.input, "typescript"));
    assert.deepEqual(inside(parts.input), inside(one.input));
    partsCount(main, [0, 0]);
});

/**
 * `text` cut where an element (a line) ends, `at` of the way through it,
 * and `edit` applied: `edit(before, after)`, where `before` ends with the
 * comma (the line feed) after the element.
 */
function broken(text, at, edit) {
    const lines = !text.startsWith("[");
    const i = text.indexOf(lines ? "\n" : "},", Math.floor(text.length * at)) + (lines ? 1 : 2);
    return edit(text.slice(0, i), text.slice(i));
}

test("what does not read in parts is read in one go, and fails or declines as it does there", async () => {
    const array = rulings;
    const lines = linesOf(rulings);
    const cases = [
        // A broken element early, in the middle, late; a trailing comma; garbage after.
        ["a bad element early", false, broken(array, 0.02, (a, b) => `${a}}${b}`)],
        ["a bad element in the middle", false, broken(array, 0.5, (a, b) => `${a}"${b}`)],
        ["a bad element late", false, broken(array, 0.97, (a, b) => `${a}:${b}`)],
        ["a trailing comma", false, `${array.trimEnd().slice(0, -1)},]`],
        ["an empty element", false, broken(array, 0.5, (a, b) => `${a},${b}`)],
        ["an empty element first", false, `[,${array.slice(1)}`],
        ["garbage after the array", false, `${array} x`],
        ["two arrays", false, `${array}${array}`],
        ["a top-level object", false, `{"a": ${array}}`],
        ["nested deeper than the engine reads", false, broken(array, 0.5, (a, b) => `${a}${"[".repeat(300)}${"]".repeat(300)},${b}`)],
        ["a lone surrogate", false, `${array.trimEnd().slice(0, -1)},"\\ud800"]`],
        ["a byte order mark", false, `\ufeff${array}`],
        ["two byte order marks", false, `\ufeff\ufeff${array}`],
        ["a bad line early", true, broken(lines, 0.02, (a, b) => `${a}}${b}`)],
        ["a bad line late", true, broken(lines, 0.95, (a, b) => `${a}[${b}`)],
        ["two values on a line", true, broken(lines, 0.5, (a, b) => `${a.slice(0, -1)} 1\n${b}`)],
        ["a byte order mark on a later line", true, broken(lines, 0.5, (a, b) => `${a}\ufeff${b}`)],
        ["a byte order mark first", true, `\ufeff${lines}`],
        ["two byte order marks first", true, `\ufeff\ufeff${lines}`],
        ["CRLF and blank lines", true, lines.replaceAll("\n", "\r\n\r\n \t\n")],
        ["a stray bracket first", true, `[${lines}`],
    ];
    for (const [what, lines, text] of cases) {
        for (const lang of ["typescript", "rust"]) {
            const bytes = utf8(text);
            const one = await inOneGo(lang, bytes, lines);
            const expected = one.added.error ?? (await outcome(() => run(one.input, lang)));
            for (const range of [997, 1 << 14]) {
                const parts = await inParts(lang, bytes, lines, { range });
                const got = parts.added.error ?? (await outcome(() => run(parts.input, lang)));
                assert.deepEqual(got, expected, `${what}, ${lang}, ranges of ${range} (${parts.read.inOneGo ?? "in parts"})`);
                workersClean(`${what}, ${lang}, ranges of ${range} (${parts.read.inOneGo ?? "in parts"})`);
                if (one.added.error !== undefined) assert.ok(parts.read.inOneGo !== undefined, `${what}: read in parts, yet one go fails`);
                releaseJSONInput(parts.input);
                releaseJSONInput(one.input);
            }
        }
    }

    // Bytes that are not UTF-8: in one go, as TextDecoder decodes them.
    const bad = new Uint8Array([...utf8(array.slice(0, 5000)), 0xff, ...utf8(array.slice(5000))]);
    for (const lines of [false]) {
        const one = await inOneGo("typescript", bad, lines);
        const parts = await inParts("typescript", bad, lines, { range: 997 });
        assert.match(parts.read.inOneGo ?? "", /UTF-8|did not read/);
        assert.deepEqual(parts.added, one.added);
        if (one.added.ok !== undefined || one.added.error === undefined) {
            assert.deepEqual(await outcome(() => run(parts.input, "typescript")), await outcome(() => run(one.input, "typescript")));
        }

        releaseJSONInput(parts.input);
    }

    workersClean("the broken inputs");
    partsCount(main, [0, 0]);
});

test("the CLI's rules: small samples, one element, trees far larger than their text, JSON Lines without an early split", async () => {
    const input = () => qt.jsonInputForTargetLanguage("typescript");
    const reading = async (text, lines, options) => {
        const bytes = utf8(text);
        const source = { name: "X", lines, size: bytes.length, read: async (f, t) => bytes.slice(f, t) };
        return readJSONInputInParts(input(), source, workersFor(bytes, 3), options);
    };
    // Under 8 MiB by default, and without two workers: this reading's.
    assert.deepEqual(await reading(rulings, false, {}), { inOneGo: "too small for parts", always: false });
    const bytes = utf8(rulings);
    const one = workersFor(bytes, 1);
    assert.equal((await readJSONInputInParts(input(), { name: "X", lines: false, size: bytes.length, read: async (f, t) => bytes.slice(f, t) }, one, { minLength: 0, range: 997 })).inOneGo, "too small for parts");
    // The sample's own: one element, not an array, trees many times their
    // text, JSON Lines whose first value is longer than a MiB, a part that
    // is not JSON.
    assert.deepEqual(await reading(`[${JSON.stringify({ big: rulings })}]`, false, { minLength: 0, range: 997 }), { inOneGo: "no split", always: true });
    assert.deepEqual(await reading(`{"a": ${rulings}}`, false, { minLength: 0, range: 997 }), { inOneGo: "not an array", always: true });
    const distinct = JSON.stringify(Array.from({ length: 400_000 }, (_, i) => ({ [`k${i}`]: i })));
    assert.deepEqual(await reading(distinct, false, { minLength: 0, range: 1 << 14 }), { inOneGo: "trees far larger than their text", always: true });
    const long = `${JSON.stringify({ text: "x".repeat(1_200_000) })}\n${linesOf(rulings)}`;
    // (Which ranges start in the first MiB is the plan's: another may find the line feed.)
    assert.deepEqual(await reading(long, true, { minLength: 0, range: 1 << 16 }), { inOneGo: "no line feed between values in the first MiB", always: false });
    assert.deepEqual(await reading(broken(rulings, 0.5, (a, b) => `${a}}${b}`), false, { minLength: 0, range: 997 }), { inOneGo: "a part did not read", always: true });
    // This reading's: an input that is not fresh, or not the engine's; one
    // that throws when it is looked at (nothing is rejected, every worker is done).
    const used = input();
    used.addSourceSync({ name: "X", samples: ["[1]"] });
    assert.deepEqual(await readJSONInputInParts(used, { name: "X", lines: false, size: bytes.length, read: async (f, t) => bytes.slice(f, t) }, workersFor(bytes, 3), { minLength: 0 }), { inOneGo: "not an input the engine reads in parts", always: false });
    const throwing = Object.create(input(), { _compressedJSON: { get: () => { throw new TypeError("no samples here"); } } });
    let done = 0;
    const counted = workersFor(bytes, 3).map((w) => Object.assign(w, { done: () => done++ }));
    assert.deepEqual(await readJSONInputInParts(throwing, { name: "X", lines: false, size: bytes.length, read: async (f, t) => bytes.slice(f, t) }, counted, { minLength: 0 }), { inOneGo: "reading in parts failed: no samples here", always: false });
    assert.equal(done, 3);
    workersClean("the rules");
});

test("a worker that fails, or a sample that changes, makes it read in one go", async () => {
    const bytes = utf8(rulings);
    const source = { name: "X", lines: false, size: bytes.length, read: async (f, t) => bytes.slice(f, t) };
    for (const job of ["summarize", "split", "tally"]) {
        const workers = workersFor(bytes, 3);
        workers[1][job] = async () => {
            throw new Error(`the worker stopped in ${job}`);
        };
        const read = await readJSONInputInParts(qt.jsonInputForTargetLanguage("typescript"), source, workers, { minLength: 0, range: 4096 });
        assert.deepEqual(read, { inOneGo: `a worker failed: the worker stopped in ${job}`, always: false });
    }

    // Each worker is given its own share of the ranges, not a view of all of them.
    const shares = [];
    const sharing = workersFor(bytes, 3).map((worker) => {
        const { summarize, split } = worker;
        worker.summarize = (job) => {
            shares.push(["starts", job.starts.length, job.starts.buffer.byteLength / 8]);
            return summarize.call(worker, job);
        };
        worker.split = (job) => {
            shares.push(["states", job.states.length, job.states.buffer.byteLength / 8]);
            return split.call(worker, job);
        };
        return worker;
    });
    const parts = qt.jsonInputForTargetLanguage("typescript");
    assert.equal((await readJSONInputInParts(parts, source, sharing, { minLength: 0, range: 4096 })).read, true);
    releaseJSONInput(parts);
    assert.equal(shares.length, 6);
    for (const [what, length, buffer] of shares) assert.equal(buffer, length, `${what}: a view of a larger buffer`);
    const ranges = shares.filter(([what]) => what === "states").reduce((n, [, length]) => n + length / 4, 0);
    assert.equal(shares.filter(([what]) => what === "starts").reduce((n, [, length]) => n + length, 0), ranges + 3);

    const shorter = { ...source, read: async (f, t) => bytes.slice(f, Math.min(t, bytes.length - 10)) };
    const readers = instances.slice(0, 3).map((glue) => new PartReader(glue, shorter.read));
    const read = await readJSONInputInParts(qt.jsonInputForTargetLanguage("typescript"), shorter, readers, { minLength: 0, range: 4096 });
    assert.match(read.inOneGo, /changed while it was read/);
    assert.equal(read.always, false);
    // Bytes that are not a worker's tallies.
    const workers = workersFor(bytes, 2);
    workers[1].tally = async () => ({ bytes: new Uint8Array([1, 2, 3]) });
    assert.deepEqual(await readJSONInputInParts(qt.jsonInputForTargetLanguage("typescript"), source, workers, { minLength: 0, range: 4096 }), { inOneGo: "a worker's tallies could not be appended", always: false });
    workersClean("the failures");
    partsCount(main, [0, 0]);
});

test("bytes whose text a browser decodes to nothing (too long for one string, in Chrome) are an error, never an empty text", async () => {
    // Bytes that are not UTF-8 are decoded before TypeScript reads them.
    const bytes = new Uint8Array([...utf8('{"a": "'), 0xff, ...utf8('"}')]);
    const decode = TextDecoder.prototype.decode;
    TextDecoder.prototype.decode = function () {
        return "";
    };
    let added;
    try {
        added = await outcome(() => qt.jsonInputForTargetLanguage("typescript").addSource({ name: "X", samples: [bytes] }));
    } finally {
        TextDecoder.prototype.decode = decode;
    }

    assert.match(added.error?.message ?? "", /Invalid string length/);
    assert.doesNotMatch(added.error.message, /end of JSON input/);
    // A byte order mark alone, or nothing, decodes to "" as it should.
    for (const empty of [new Uint8Array([0xef, 0xbb, 0xbf]), new Uint8Array(0)]) {
        const read = await outcome(() => qt.jsonInputForTargetLanguage("typescript").addSource({ name: "X", samples: [empty] }));
        assert.match(read.error?.message ?? "", /end of JSON input/);
    }
});

test("the engine's WebAssembly memory, for the playground's measurements, from the module's own export (no test hook)", () => {
    const bytes = engine.engineMemoryBytes();
    assert.ok(bytes >= 1 << 20 && bytes % 65536 === 0, String(bytes));
    if (hasHooks) assert.equal(bytes, main.__memoryPages() * 65536);
});

test("the split search's bindings: a plan, summaries, states, splits, parts", async () => {
    const text = '[{"a": "x,]\\"", "b": [1, 2]}, 3, "\\\\", {"c": {}}]';
    const bytes = utf8(text);
    const plan = main.splitPlan(bytes.length, 3, 0, 4);
    assert.equal(plan.threads, 3);
    assert.equal(plan.starts[0], 0);
    assert.equal(plan.starts[plan.starts.length - 1], bytes.length);
    const ranges = plan.starts.length - 1;
    const summaries = new Float64Array(15 * ranges);
    for (let k = 0; k < ranges; k++) {
        const from = plan.starts[k];
        const start = Math.max(0, from - 64);
        summaries.set(main.splitSummarize(bytes.subarray(start, from), start === 0, bytes.subarray(from, plan.starts[k + 1])), 15 * k);
    }

    const states = main.splitResolve(summaries, false);
    assert.equal(states.length, 4 * ranges);
    const splits = new Float64Array(ranges);
    for (let k = 0; k < ranges; k++) {
        const found = states[4 * k + 3] === 1 ? main.splitFind(bytes.subarray(plan.starts[k], plan.starts[k + 1]), states[4 * k] === 1, states[4 * k + 1] === 1, states[4 * k + 2], false) : -1;
        splits[k] = found < 0 ? -1 : plan.starts[k] + found;
    }

    // The commas between the array's elements, and only those.
    const commas = [...splits].filter((s) => s >= 0);
    assert.deepEqual(commas, [28, 31, 37]);
    const { parts } = main.splitParts(plan.plan, main.splitArrayStart(bytes), splits, false);
    assert.deepEqual([...parts], [1, 28, 1, 29, 31, 0, 32, 37, 0, 38, -1, 0]);
    assert.equal(main.splitArrayStart(utf8("\ufeff \n[1]")), 6);
    assert.equal(main.splitArrayStart(utf8('{"a": 1}')), -1);
    assert.equal(main.splitPlan(10, 3, 0, 0), undefined);
    assert.equal(main.splitResolve(new Float64Array(14), false), undefined);
    assert.deepEqual(main.splitParts(new Float64Array(3), 0, splits, false), { inOneGo: "numbers that are not the engine's", always: false });
    assert.equal(main.splitDecide(plan.plan, parts, 4, 100, 100, 100), undefined);
    assert.deepEqual(main.splitDecide(plan.plan, parts, 0, 70_000, 700_000, 1), { inOneGo: "trees far larger than their text", always: true });
    // Tallies past the budget (the plan's) are this reading's.
    const reader = new PartReader(instances[0], async (f, t) => bytes.slice(f, t));
    await reader.summarize({ starts: plan.starts.slice() });
    const tallied = await reader.tally({ parts, lines: false, size: bytes.length, reading: { dateTime: "default", handleRefs: false, min: undefined, max: undefined }, limit: 1 });
    reader.done();
    assert.deepEqual(tallied, { notRead: "the parts' tallies would take too much memory", always: false });
});
