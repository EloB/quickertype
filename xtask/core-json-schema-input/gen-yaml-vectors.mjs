#!/usr/bin/env node
// Records differential test vectors for the `YAML.parse` port
// (crates/quicktype-js-compat/src/yaml.rs): yaml 2.9.0 with default options,
// as quicktype's parseJSON falls back to it.
//
// usage: node xtask/core-json-schema-input/gen-yaml-vectors.mjs <path/to/quicktype>
//
// Cases: curated YAML (core-schema scalars, keys, aliases, flow and block
// collections, JSON-with-mistakes), every file in tests/inputs that
// JSON.parse rejects (recorded by path), and seeded mutations of the
// smaller schema and JSON inputs that JSON.parse rejects (the realistic
// "almost JSON" case). Each result is the JavaScript value, encoded so that
// key order, -0, NaN and Infinity survive, or the name of the error thrown.
//
// Output: crates/quicktype-js-compat/tests/vectors/yaml.json, replayed by
// crates/quicktype-js-compat/tests/yaml_vectors.rs.

import { readdirSync, readFileSync, writeFileSync, statSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve, relative } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktypeDir = resolve(process.argv[2] ?? process.env.QUICKTYPE_DIR ?? join(repoRoot, "..", "quicktype"));
const coreRequire = createRequire(join(quicktypeDir, "packages/quicktype-core/dist/index.js"));
const YAML = coreRequire("yaml");
const yamlVersion = JSON.parse(readFileSync(coreRequire.resolve("yaml/package.json"), "utf8")).version;
if (yamlVersion !== "2.9.0") throw new Error(`expected yaml 2.9.0, found ${yamlVersion}`);

// Silence yaml's warnings (process.emitWarning) while recording.
process.emitWarning = () => {};

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

function encode(v) {
    if (v === null || typeof v === "boolean" || typeof v === "string") return v;
    if (typeof v === "number") return { n: Object.is(v, -0) ? "-0" : String(v) };
    if (Array.isArray(v)) return { a: v.map(encode) };
    if (typeof v === "object") return { o: Object.keys(v).map((k) => [k, encode(v[k])]) };
    return { other: String(v) };
}

function run(text) {
    try {
        return { ok: encode(YAML.parse(text)) };
    } catch (e) {
        return { err: e.name, message: String(e.message).split("\n")[0] };
    }
}

function jsonFails(text) {
    try {
        JSON.parse(text);
        return false;
    } catch {
        return true;
    }
}

const curated = [
    "", " ", "\n", "# only a comment\n", "---", "---\n", "...", "--- a\n", "a\n...\n", "a\n---\nb\n", "---\n---\n",
    "null", "~", "Null", "NULL", "nUll", "true", "True", "TRUE", "tRue", "yes", "no", "on", "off", "y",
    "0", "-0", "+0", "007", "-007", "+12", "12345678901234567890", "1_000", "0x1F", "0X1F", "0xg", "0o17", "0o8",
    "0O17", "012", "0b101", ".inf", "-.inf", "+.inf", ".Inf", ".INF", ".iNf", ".nan", ".NaN", ".NAN", "-.nan",
    "1.", ".5", "-.5", "+.5", ".", "1.0", "1.50", "1e3", "1E3", "1e+3", "1e-3", "1.e3", ".5e3", "e3", "1e", "1.5.5",
    "2001-12-14", "2001-12-14t21:59:43.10-05:00", "12:30", "1:2:3", "a b c", "'single'", "\"double\"",
    "\"esc \\n \\t \\\\ \\\" \\/ \\u00e9 \\x41 \\U0001F600 \\0 \\a \\e \\_ \\N \\L \\P\"", "'it''s'",
    "\"\\q\"", "|\n  literal\n  text\n", "|-\n  stripped\n", "|+\n  kept\n\n", ">\n  folded\n  text\n\n  para\n",
    ">-\n  a\n  b\n", "|2\n   indented\n", "plain\n  continued\n  lines", "key: value", "key:value", "key:  value  ",
    "a: 1\nb: 2\n", "b: 1\na: 2\n1: x\n0: y\n", "a: 1\na: 2\n", "1: a\n1.0: b\n", "'1': a\n1: b\n", "~: a\nnull: b\n",
    "? a\n: b\n", "? [a, b]\n: c\n", "? {a: 1}\n: c\n", "[a, b]: c", "{a: 1}: c", ": a\n", "a:\n", "a: \n  b: c\n",
    "- a\n- b\n", "- a\n-\n- c\n", "- - a\n  - b\n- c\n", "- a: 1\n  b: 2\n", "-a\n", "[]", "{}", "[a, b, ]",
    "[a, b,, c]", "{a: 1, b: 2, }", "{a: 1,, b}", "[a: 1, b]", "{a, b: 1}", "{\"a\":1}", "{\"a\": 1, \"b\": [1, 2,],}",
    "{\"a\": 1,}", "[1,2,3,]", "{\"a\": tru}", "{\"a\": 01}", "{\"a\": .5}", "{\"a\": +1}", "{\"a\": 0x10}",
    "{\"a\": 'single'}", "{'a': 1}", "{a: b c}", "{\"a\": \"x\" \"y\"}", "{\"a\": 1 // comment\n}", "{\"a\": 1 # comment\n}",
    "{\"a\": 1} # trailing", "{\"a\": 1}\n{\"b\": 2}", "{\"a\": 1}}", "[[[]]]", "[{}, [], '', ~]", "{\"a\": [1, {\"b\": null}]}",
    "a: &x 1\nb: *x\n", "a: &x [1, 2]\nb: *x\nc: *x\n", "a: *x\n", "a: &x\n  b: 1\nc: *x\n", "&a [*a]", "&x a: b\n",
    "a: &x 1\nb: &x 2\nc: *x\n", "<<: {a: 1}\nb: 2\n", "a: !!str 1\n", "a: !!int '12'\n", "a: !!int abc\n",
    "a: !!float 1\n", "a: !!float 1.5\n", "a: !!bool yes\n", "a: !!bool true\n", "a: !!null ''\n", "a: !!null x\n",
    "a: !foo bar\n", "a: ! 12\n", "a: !<tag:yaml.org,2002:int> 12\n", "a: !!map {b: 1}\n", "a: !!seq [1]\n",
    "a: !!str {b: 1}\n", "a: !custom [1]\n", "%YAML 1.2\n---\na: 1\n", "%TAG !e! tag:example.com,2000:\n---\na: !e!foo 1\n",
    "a:\n\tb: 1\n", "a:\n  b: 1\n c: 2\n", "a: [1,\n2]\n", "a: [1,\n  2]\n", "  a: 1\n  b: 2\n", "a: b: c\n", "a: 'x\n  y'\n",
    "key with spaces: 1\n", "\"quoted key\": 1\n", "'k': 1\n", "? |\n  block key\n: v\n", "__proto__: 1\n", "{__proto__: 1, a: 2}",
    "constructor: 1\ntoString: 2\n", "4294967295: a\n4294967294: b\n01: c\n1: d\n", "-1: a\n1.5: b\n", "1e3: a\n1000: b\n",
    "true: a\nfalse: b\n", ".nan: a\n.nan: b\n", "0: a\n-0: b\n", "[a, b]: 1\n[a, b]: 2\n", "a: |\n  x\n b: 2\n",
    "\ufeffa: 1\n", "a: 1\r\nb: 2\r\n", "a: \"\\ud800\"\n", "a: x\u00a0y\n", "'a': |\n  x\n", "@a\n", "`a`\n", "a: @b\n",
    "a: %b\n", "% a\n", "- [\n", "{", "}", "[", "]", "{a: [}", "'unterminated", "\"unterminated", "a: \"x\" y\n", "*", "&",
    "a: *\n", "!!", "a: !!\n", "? \n", "?\n", "query {\n  viewer {\n    login\n  }\n}\n",
    "query {\n  viewer {\n    realName: name\n  }\n}\n", "type Query {\n  a: Int\n}\n", "a: 1\n...\nb: 2\n",
    "k: v # comment\n# other\n", "k: v#not comment\n", "- 1\n- 2\n# end", "a: >\n  x\n\n  y\n", "x: [a, b]\ny: {c: d}\n",
];

const fromInputs = [];
function walk(dir) {
    for (const name of readdirSync(dir).sort()) {
        const p = join(dir, name);
        if (statSync(p).isDirectory()) {
            walk(p);
            continue;
        }
        let text = readFileSync(p, "utf8");
        if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
        if (jsonFails(text)) fromInputs.push(relative(repoRoot, p));
    }
}
walk(join(repoRoot, "tests/inputs"));

const random = rng(4242);
const inserts = [",", ":", "#", "\n", " ", "'", "\"", "-", "[", "{", "}", "]", "&a ", "*a", "?", "!", "\t", "//", ",}", ": :"];
const mutated = [];
const sources = [];
for (const sub of ["schema", "json/priority", "json/samples"]) {
    const dir = join(repoRoot, "tests/inputs", sub);
    for (const name of readdirSync(dir).sort()) {
        const p = join(dir, name);
        if (!statSync(p).isFile()) continue;
        const text = readFileSync(p, "utf8");
        if (text.length > 3000 || jsonFails(text)) continue;
        sources.push(text);
    }
}
for (const text of sources) {
    for (let k = 0; k < 4; k++) {
        const pos = Math.floor(random() * text.length);
        const r = random();
        let m;
        if (r < 0.3) m = text.slice(0, pos) + text.slice(pos + 1);
        else if (r < 0.4) m = text.slice(0, pos) + text[pos] + text.slice(pos);
        else m = text.slice(0, pos) + inserts[Math.floor(random() * inserts.length)] + text.slice(pos);
        if (jsonFails(m)) mutated.push(m);
    }
}

const cases = [
    ...curated.map((text) => ({ text, ...run(text) })),
    ...fromInputs.map((path) => {
        let text = readFileSync(join(repoRoot, path), "utf8");
        if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
        return { path, ...run(text) };
    }),
    ...mutated.map((text) => ({ text, ...run(text) })),
];
// Rust strings cannot hold lone surrogates (a known gap).
const wellFormed = (x) => !/\\ud[89a-f][0-9a-f]{2}/i.test(JSON.stringify(x));
const kept = cases.filter(wellFormed);

const out = join(repoRoot, "crates/quicktype-js-compat/tests/vectors/yaml.json");
writeFileSync(out, `${JSON.stringify(kept)}\n`);
console.log(
    `wrote ${kept.length} cases (${curated.length} curated, ${fromInputs.length} files, ${mutated.length} mutations; ` +
        `${cases.length - kept.length} with lone surrogates dropped; ${kept.filter((c) => c.err).length} errors) to ${out}`,
);
