#!/usr/bin/env node
// Records differential test vectors for `quicktype_js_compat::json::parse`
// (the port of V8's `JSON.parse`) from the Node.js running this script.
//
// usage: node xtask/core-json-input/gen-json-parse-vectors.mjs [path/to/quicktype]
//
// Inputs are curated edge cases, seeded random JSON texts (random whitespace,
// number spellings, escapes, duplicate and integer-like keys, nesting),
// seeded random mutations of those texts and of the JSON files in
// tests/inputs/json (insertions, deletions, replacements, truncations), so
// re-running the script reproduces the same file. Every case records either
// the parsed value, serialized in own-property order with lone surrogates
// replaced by U+FFFD, or the SyntaxError message (with lone surrogates
// replaced the same way, as Node prints them). Inputs that are not
// well-formed UTF-16, or whose parsed strings contain a lone surrogate, are
// skipped: a Rust `String` cannot represent them (docs/PARITY.md).
//
// Output: crates/quicktype-js-compat/tests/vectors/json_parse.json, replayed
// by crates/quicktype-js-compat/tests/json_parse.rs.

import { readdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const output = join(repoRoot, "crates/quicktype-js-compat/tests/vectors/json_parse.json");

// mulberry32
function rng(seed) {
    let a = seed >>> 0;
    return () => {
        a = (a + 0x6d2b79f5) >>> 0;
        let t = a;
        t = Math.imul(t ^ (t >>> 15), t | 1);
        t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
        return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
}

const random = rng(20261113);
const pick = (xs) => xs[Math.floor(random() * xs.length)];
const int = (n) => Math.floor(random() * n);

let lone = false;
function wellFormed(s) {
    if (!s.isWellFormed()) lone = true;
    return s.toWellFormed();
}

function serialize(v) {
    if (v === null) return "null";
    switch (typeof v) {
        case "string":
            return JSON.stringify(wellFormed(v));
        case "number":
        case "boolean":
            return JSON.stringify(v);
    }
    if (Array.isArray(v)) return `[${v.map(serialize).join(",")}]`;
    return `{${Object.getOwnPropertyNames(v)
        .map((k) => `${JSON.stringify(wellFormed(k))}:${serialize(v[k])}`)
        .join(",")}}`;
}

const cases = new Map();
function record(input) {
    if (cases.has(input) || !input.isWellFormed()) return;
    lone = false;
    let value;
    try {
        value = JSON.parse(input);
    } catch (e) {
        cases.set(input, { error: e.message.toWellFormed() });
        return;
    }
    const result = { ok: serialize(value) };
    if (lone) return;
    cases.set(input, result);
}

// Curated edge cases.
const curated = [
    "", " ", " \t\n\r ", "\ufeff{}", "null", "true", "false", "tru", "nul", "fals", "truex", "true1",
    "nullx", "tr1", 'tr"', "tru}", "nux", "NaN", "Infinity", "-Infinity", "undefined", "[object Object]",
    "{}", "[]", "[ ]", "{ }", "0", "-0", "-0.0", "1.0", "1e2", "1E2", "1e+2", "1e-2", "-1.5e-3",
    "01", "-01", "00", "0x10", "-0x", "0-1", "1-2", ".5", "1.", "1.e5", "1e", "1e+", "1ex", "-", "-x",
    "+1", "123456789", "1234567890", "12345678901234567890", "9223372036854775807",
    "-9223372036854775809", "9007199254740993", "1e400", "-1e400", "1e-400", "4.9e-324",
    "2.2250738585072014e-308", "0.1e1", "1E400", "[1,2", "[1 2]", "[1,]", "[,1]", "[1}", "{\"a\":1]",
    "{1:2}", "{", "{\"a\"", "{\"a\" 1}", "{\"a\":", "{\"a\":1", "{\"a\":1,}", "{,}", "{\"a\":}",
    "{\"a\":1 \"b\":2}", "{'a':1}", "{a:1}", ":", ",", "]", "}", "[", "[[[[", "[[]]]", "{\"a\":{}}}",
    '"abc', '"\\', '"ab\\', '"\\x"', '"\\u"', '"\\u1"', '"\\u12x4"', '"\\u123', '"\\uZZZZ"', '"\\u00e9"',
    '"\\ud83d\\ude00"', '"\\uD83D\\uDE00"', '"\\/"', '"\\b\\f\\n\\r\\t"', '"\u0001"', '"\t"', '"\n"',
    '"\u007f"', '"\u2028\u2029"', '"é"', '"\\é"', '"\\€"', '"\\😀"', '"€\\x"', '"😀"', "😀", "é", "€",
    "[1, 2, 3, 4, 5, 6, 7, 8, 😀]", "[1, 2, 3, 4, 5, 6, 7, x]", "[1, 2, 3, 4, 5, x, 7, 8, 9, 10, 11]",
    "x23456789012345678901", "x234567890123456789012", "12345678901234567890x",
    "123456789012345678901x", "1234567890x", "123456789x0123456789012",
    "[1\r\n\r2]", "[\r\n1,\n\"\\x\"]", "[\n\n\n1 2]", "\r\r\n\nx", "[1\r]x",
    '{"b":1,"2":2,"a":3,"1":4}', '{"01":1,"1":2,"-1":3,"1.5":4,"4294967294":5,"4294967295":6}',
    '{"a":1,"a":2}', '{"a":1,"b":2,"a":3}', '{"__proto__":1}', '{"__proto__":1,"__proto__":{"x":2}}',
    '{"constructor":1,"toString":2,"hasOwnProperty":3}', '{"":1,"":2}', '[{"a":[{"b":[]}]}]',
    '"' + "a".repeat(100) + '\\q"', "[" + "1,".repeat(30) + "]",
];
for (const c of curated) record(c);

// Deep nesting (V8 parses 200,000 levels; the Rust parser is iterative).
record("[".repeat(1000) + "]".repeat(1000));
record("[".repeat(5000) + "]".repeat(4999));
record('{"a":'.repeat(1000) + "1" + "}".repeat(1000));
record(`${'{"a":'.repeat(5000)}1${"}".repeat(4999)}]`);

// Seeded random JSON texts.
const ws = () => (random() < 0.7 ? "" : pick([" ", "\t", "\n", "\r", "\r\n", "  "]));
function randomNumber() {
    const sign = random() < 0.3 ? "-" : "";
    let s = random() < 0.2 ? "0" : String(1 + int(9)) + String(int(10 ** int(12)) || "").slice(0, int(25));
    if (random() < 0.3) s += `.${int(1000000)}`;
    if (random() < 0.2) s += `${pick(["e", "E"])}${pick(["", "+", "-"])}${int(400)}`;
    return sign + s;
}
const keyPool = ["a", "b", "id", "0", "1", "10", "2", "01", "-1", "__proto__", "", "é", "😀", "4294967295", "x y"];
function randomString() {
    let s = "";
    const n = int(8);
    for (let i = 0; i < n; i++) {
        s += pick([
            "a", "Z", " ", "é", "€", "😀", "\\n", "\\t", "\\\\", '\\"', "\\/", "\\u00e9", "\\u20AC",
            "\\ud83d\\ude00", "1", "-", ":", ",", "{", "]",
        ]);
    }
    return s;
}
function randomValue(depth) {
    const r = random();
    if (depth > 4 || r < 0.35) {
        return pick([
            () => randomNumber(),
            () => `"${randomString()}"`,
            () => pick(["true", "false", "null"]),
        ])();
    }
    if (r < 0.65) {
        const n = int(5);
        const items = [];
        for (let i = 0; i < n; i++) items.push(ws() + randomValue(depth + 1) + ws());
        return `[${items.join(",")}${n === 0 ? ws() : ""}]`;
    }
    const n = int(5);
    const members = [];
    for (let i = 0; i < n; i++) {
        const key = random() < 0.6 ? pick(keyPool) : randomString();
        members.push(`${ws()}"${key}"${ws()}:${ws()}${randomValue(depth + 1)}${ws()}`);
    }
    return `{${members.join(",")}${n === 0 ? ws() : ""}}`;
}

const valid = [];
for (let i = 0; i < 1500; i++) {
    const text = ws() + randomValue(0) + ws();
    valid.push(text);
    record(text);
}

// Seeded mutations.
const alphabet = [
    "{", "}", "[", "]", ":", ",", '"', "\\", " ", "\n", "\r", "\t", "-", "+", ".", "e", "E", "0", "1",
    "9", "t", "f", "n", "u", "l", "x", "é", "€", "😀", "\u0001", "/", "b", "'",
];
function mutate(text) {
    let s = text;
    const n = 1 + int(3);
    for (let i = 0; i < n; i++) {
        const at = int(s.length + 1);
        switch (int(4)) {
            case 0:
                s = s.slice(0, at) + pick(alphabet) + s.slice(at);
                break;
            case 1:
                s = s.slice(0, at) + s.slice(at + 1);
                break;
            case 2:
                s = s.slice(0, at) + pick(alphabet) + s.slice(at + 1);
                break;
            default:
                s = s.slice(0, at);
        }
    }
    return s;
}
for (let i = 0; i < 4000; i++) record(mutate(pick(valid)));

// Truncations and mutations of real inputs (errors only, to keep the file small).
const inputs = join(repoRoot, "tests/inputs/json");
const files = [];
for (const dir of ["priority", "samples", "misc"]) {
    for (const f of readdirSync(join(inputs, dir)).sort()) {
        if (f.endsWith(".json")) files.push(join(inputs, dir, f));
    }
}
for (let i = 0; i < 300; i++) {
    const text = readFileSync(pick(files), "utf8");
    const at = int(Math.min(text.length, 1500));
    const head = text.slice(0, at);
    const candidate = random() < 0.5 ? head : mutate(head);
    try {
        JSON.parse(candidate);
    } catch {
        record(candidate);
    }
}

const vectors = Array.from(cases, ([input, result]) => ({ input, ...result }));
writeFileSync(output, `[\n${vectors.map((v) => JSON.stringify(v)).join(",\n")}\n]\n`);
console.log(`wrote ${vectors.length} cases to ${output}`);
