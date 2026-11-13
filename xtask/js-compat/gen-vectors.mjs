#!/usr/bin/env node
// Records differential test vectors for the JavaScript-compatibility code:
// the crate quicktype-js-compat and the quicktype-core modules built on it
// (support/Strings, Acronyms, IntegerRange, MarkovChain).
//
// usage: node xtask/js-compat/gen-vectors.mjs [path/to/quicktype]
//
// The default reference checkout is $QUICKTYPE_REFERENCE, else ../quicktype
// next to this repository (xtask/reference.mjs); it must be built
// (packages/quicktype-core/dist) with its node_modules installed. The npm
// packages are loaded exactly as quicktype-core resolves them. Inputs are
// curated edge cases, property names from tests/inputs, and pseudo-random
// data from fixed seeds, so re-running the script reproduces the same files.
//
// Output: crates/quicktype-js-compat/tests/vectors/*.json and
// crates/quicktype-core/tests/vectors/*.json. Strings in vectors are always
// well-formed; anything that can contain a lone surrogate is recorded as an
// array of UTF-16 code units. Doubles are recorded as 16-digit hex bit
// patterns.

import { readdirSync, readFileSync, writeFileSync, mkdirSync, statSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve, relative } from "node:path";
import { fileURLToPath } from "node:url";

import { referenceCheckout } from "../reference.mjs";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktypeDir = referenceCheckout(process.argv[2]);
const coreDist = join(quicktypeDir, "packages/quicktype-core/dist");
const coreRequire = createRequire(join(coreDist, "index.js"));

function load(name, expectedVersion) {
    const path = coreRequire.resolve(name);
    let dir = dirname(path);
    while (!statSafe(join(dir, "package.json"))) dir = dirname(dir);
    const version = JSON.parse(readFileSync(join(dir, "package.json"), "utf8")).version;
    if (version !== expectedVersion) {
        throw new Error(`expected ${name} ${expectedVersion}, found ${version} at ${path}`);
    }
    return coreRequire(name);
}

function statSafe(path) {
    try {
        return statSync(path);
    } catch {
        return undefined;
    }
}

const pluralize = load("pluralize", "8.0.0");
const wordwrap = load("wordwrap", "1.0.0");
const unicode = load("unicode-properties", "1.4.1");
const Strings = coreRequire("./support/Strings.js");
const Acronyms = coreRequire("./support/Acronyms.js");
const { acronyms: ACRONYMS } = coreRequire("./support/Acronyms.const.js");
const IntegerRange = coreRequire("./support/IntegerRange.js");
const MarkovChain = coreRequire("./MarkovChain.js");

const META = {
    generator: "xtask/js-compat/gen-vectors.mjs",
    node: process.version,
    reference: relative(repoRoot, quicktypeDir),
};

const JS_COMPAT_DIR = join(repoRoot, "crates/quicktype-js-compat/tests/vectors");
const CORE_DIR = join(repoRoot, "crates/quicktype-core/tests/vectors");
mkdirSync(JS_COMPAT_DIR, { recursive: true });
mkdirSync(CORE_DIR, { recursive: true });

let totalBytes = 0;
function write(dir, name, data) {
    const text = JSON.stringify({ meta: META, ...data }) + "\n";
    for (const s of strings(data)) {
        if (!s.isWellFormed()) throw new Error(`${name}: lone surrogate in ${JSON.stringify(s)}`);
    }
    writeFileSync(join(dir, name), text);
    totalBytes += text.length;
    console.log(`${relative(repoRoot, join(dir, name))}: ${(text.length / 1024).toFixed(0)} KiB`);
}

function* strings(value) {
    if (typeof value === "string") yield value;
    else if (Array.isArray(value)) for (const v of value) yield* strings(v);
    else if (value !== null && typeof value === "object") {
        for (const [k, v] of Object.entries(value)) {
            yield k;
            yield* strings(v);
        }
    }
}

// ---------------------------------------------------------------------------
// Deterministic randomness

/** mulberry32: a 32-bit PRNG returning floats in [0, 1). */
function mulberry32(seed) {
    let a = seed >>> 0;
    return () => {
        a = (a + 0x6d2b79f5) >>> 0;
        let t = a;
        t = Math.imul(t ^ (t >>> 15), t | 1);
        t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
        return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
}

let random = mulberry32(0x5eed);
const randInt = (n) => Math.floor(random() * n);
const pick = (arr) => arr[randInt(arr.length)];

/** 64 random bits as a BigInt. */
function randomBits64() {
    return (BigInt(Math.floor(random() * 2 ** 32)) << 32n) | BigInt(Math.floor(random() * 2 ** 32));
}

const f64View = new DataView(new ArrayBuffer(8));
function f64ToHex(x) {
    f64View.setFloat64(0, x);
    return f64View.getBigUint64(0).toString(16).padStart(16, "0");
}
function bitsToF64(bits) {
    f64View.setBigUint64(0, bits);
    return f64View.getFloat64(0);
}

/** The hash both sides use to build reproducible comparators (u32 math). */
function mix(seed, a, b) {
    let h = Math.imul(seed ^ 0x9e3779b9, 0x85ebca6b) >>> 0;
    h = Math.imul(h ^ a, 0xc2b2ae35) >>> 0;
    h = (h ^ (h >>> 16)) >>> 0;
    h = Math.imul(h ^ b, 0x27d4eb2f) >>> 0;
    h = (h ^ (h >>> 15)) >>> 0;
    h = Math.imul(h, 0x165667b1) >>> 0;
    h = (h ^ (h >>> 13)) >>> 0;
    return h;
}

const units = (s) => Array.from({ length: s.length }, (_, i) => s.charCodeAt(i));

// ---------------------------------------------------------------------------
// Inputs

// Characters that exercise the JavaScript/Rust differences: case mappings that
// expand or depend on context, Unicode-12-vs-17 categories, JS-only and
// Rust-only whitespace, controls, astral letters and digits.
const PALETTE = [
    ..."abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
    ..."_-. $#'\"\\/:,;!?()[]{}<>@&*+=%^`|~",
    "é", "É", "ß", "ÿ", "µ", "ª", "×", "ſ", "K", "İ", "ı", "ǅ", "ǆ", "Ǆ", "ŉ", "ﬁ", "ΐ",
    "Σ", "σ", "ς", "Α", "α", "Д", "д", "中", "文", "ア", "ー", "́", "ʕ", "ࡰ",
    "㋿", "٣", "Ⅻ", "½", "", "｡", "͸",
    "\t", "\n", "\r", "\u000b", "\u000c", " ", "\u0085", " ", " ", " ",
    " ", " ", "　", "﻿", "​", "\u0000", "\u0001", "\u001f", "\u007f",
    "\u0080", "\u009f",
    "😀", "𝐀", "𝐚", "𐐀", "𐐨", "\u{1f971}", "\u{1fad0}", "𝟎", "\u{10ffff}", "\u{20000}",
];
const ASCII_LETTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

function randomString(maxLength, palette = PALETTE) {
    const n = randInt(maxLength + 1);
    let s = "";
    for (let i = 0; i < n; i++) {
        // Bias towards ASCII letters so that word structure appears.
        s += random() < 0.5 ? ASCII_LETTERS[randInt(ASCII_LETTERS.length)] : pick(palette);
    }
    return s;
}

const EDGE_STRINGS = [
    "", " ", "a", "A", "_", "0", "ß", "ßtraße", "İstanbul", "ı", "ǅemal", "ǆemal", "ŉabc", "ﬁle",
    "ΣΑΣ x", "ΑΣ", "𐐨x", "𐐀X", "a😀b", "😀", "𝐀𝐁c", "𝐚b", "__proto__", "constructor", "toString",
    "123 abc", "XMLHttpRequest", "iOS", "9lives", "ABC123def", "URLValue", "jsonID", "ß_test",
    "123abc", "the_answer", "HTTPServer", "getHTTPResponseCode", "user-id", "user.name",
    "foo bar baz", "  leading", "trailing  ", "\u0085x\u0085", "﻿x﻿", " x ",
    "a b", "\t\n", "MULTI_SPA_IN_GROUP_REJECTED", "FaqCoordinate", "contactInformation",
    "postingFrequency", "$ref", "$refs", "@type", "1", "10", "01", "-1", "x́", "ʕ",
    "ࡰx", "㋿", "٣٤", "ⅫⅠ", "½", "｡\u{1f600}", "ID", "Id", "id", "IDs", "APIs",
    "cookies", "Cookies", "COOKIES", "people", "statuses", "analyses", "axes", "iTems", "ITEMS",
    "Mice", "media", "leaves", "movies", "s", "Ies", "straßen", "Pokémons", "cooKieſ", "Kisses",
    "the", "empty", "THE", "_123", "__", "a_b_c", "A-B-C", "a..b", "-a-", "x.Y z",
];

/** Property names and file names from the golden corpus inputs. */
function corpusNames() {
    const names = new Set();
    const visit = (value) => {
        if (Array.isArray(value)) value.forEach(visit);
        else if (value !== null && typeof value === "object") {
            for (const [k, v] of Object.entries(value)) {
                names.add(k);
                visit(v);
            }
        }
    };
    const walk = (dir) => {
        for (const entry of readdirSync(dir).sort()) {
            const path = join(dir, entry);
            if (statSync(path).isDirectory()) walk(path);
            else if (/\.(json|schema)$/.test(entry)) {
                names.add(entry.replace(/\..*$/, ""));
                try {
                    visit(JSON.parse(readFileSync(path, "utf8")));
                } catch {
                    // Not JSON (YAML schemas, deliberately broken inputs).
                }
            }
        }
    };
    walk(join(repoRoot, "tests/inputs"));
    return [...names].filter((n) => n.isWellFormed()).sort();
}

function sample(arr, count) {
    if (arr.length <= count) return arr;
    const stride = arr.length / count;
    return Array.from({ length: count }, (_, i) => arr[Math.floor(i * stride)]);
}

const CORPUS = corpusNames();
console.log(`corpus: ${CORPUS.length} distinct names`);

// ---------------------------------------------------------------------------
// js-compat: number

function numberVectors() {
    random = mulberry32(1);
    const edge = [
        0, -0, NaN, Infinity, -Infinity, 1, -1, 0.1, 0.2, 0.1 + 0.2, 1e21, 1e-7, 1e-6, 1e20,
        999999999999999900000, 123e-20, 5e-324, -5e-324, Number.MAX_VALUE, Number.MIN_VALUE,
        2 ** 53, 2 ** 53 + 2, 12345678901234567890, 123456789012345678901, 1.5e300, 1e300 * 10,
        100, 0.000001, 0.0000001, 1.7976931348623157e308, 2.2250738585072014e-308, 4.35, 0.5,
        2877847019984.40625, 1e15, 1e16, 1e17, 123456.789, -1e-7, 1e100, 2 ** -1074, 2 ** 1023,
        9007199254740993, 4294967295, 4294967296, -2147483648, 0.30000000000000004,
    ];
    const values = [...edge];
    for (let i = 0; i < 5000; i++) values.push(bitsToF64(randomBits64()));
    for (let i = 0; i < 3000; i++) {
        values.push(randInt(100000000) / 10 ** randInt(25) * (random() < 0.2 ? -1 : 1));
    }
    for (let i = 0; i < 1000; i++) values.push(Math.floor(random() * 2 ** 53) * 2 ** randInt(30));
    for (let i = 0; i < 1000; i++) values.push(random() * 10 ** (randInt(60) - 30));
    const toString = values.map((x) => [f64ToHex(x), String(x)]);

    // `**` in the shapes quicktype uses (geometric means of probabilities)
    // plus special cases.
    const special = [NaN, Infinity, -Infinity, 0, -0, 1, -1, 2, 0.5, -0.5, 3, 1e-300, 1e300];
    const pow = [];
    for (const x of special) for (const y of special) pow.push([x, y]);
    for (let i = 0; i < 1500; i++) pow.push([random() ** (1 + randInt(20)), 1 / (1 + randInt(60))]);
    for (let i = 0; i < 500; i++) pow.push([random() * 100, (randInt(2000) - 1000) / 100]);
    for (let i = 0; i < 300; i++) pow.push([random(), 2]);
    for (let i = 0; i < 300; i++) pow.push([random() * 1e10, 0.5]);
    for (let i = 0; i < 200; i++) pow.push([randInt(30), randInt(8)]);
    const powVectors = pow.map(([x, y]) => [f64ToHex(x), f64ToHex(y), f64ToHex(x ** y)]);

    write(JS_COMPAT_DIR, "number.json", { to_string: toString, pow: powVectors });
}

// ---------------------------------------------------------------------------
// js-compat: utf16, whitespace

function utf16Vectors() {
    random = mulberry32(2);
    const inputs = [...EDGE_STRINGS];
    for (let i = 0; i < 250; i++) inputs.push(randomString(12));
    const cases = inputs.map((s) => {
        const len = s.length;
        const indexPairs = [[0, undefined], [1, undefined], [-1, undefined], [1, -1], [2, 1],
            [-3, -1], [0, len + 5], [randInt(len + 2), randInt(len + 2) - 2]];
        return {
            s,
            len,
            units: units(s),
            code_point_at: Array.from({ length: len + 1 }, (_, i) => s.codePointAt(i) ?? null),
            slices: indexPairs.map(([a, b]) => [a, b ?? null, units(s.slice(a, b)), units(s.substring(a, b))]),
            upper_first: s === "" ? s : s[0].toUpperCase() + s.slice(1),
            lower_first: s === "" ? s : s[0].toLowerCase() + s.slice(1),
        };
    });

    // Case mapping of unit sequences containing lone surrogates.
    const caseCases = [];
    for (let i = 0; i < 300; i++) {
        let u = units(randomString(8, [...PALETTE, "Σ", "Σ", "Σ"]));
        if (random() < 0.6) u.splice(randInt(u.length + 1), 0, 0xd800 + randInt(0x800));
        const s = String.fromCharCode(...u);
        caseCases.push([u, units(s.toLowerCase()), units(s.toUpperCase())]);
    }

    const compare = [];
    for (let i = 0; i < 500; i++) {
        const a = randomString(4);
        const b = random() < 0.3 ? a + randomString(2) : randomString(4);
        compare.push([a, b, a < b ? -1 : a > b ? 1 : 0]);
    }
    compare.push(["｡", "\u{1f600}", 1], ["\u{1f600}", "｡", -1], ["", "", 0]);

    write(JS_COMPAT_DIR, "utf16.json", { strings: cases, case_mapping: caseCases, compare });
}

function whitespaceVectors() {
    random = mulberry32(3);
    const whitespace = [];
    for (let cp = 0; cp <= 0x10ffff; cp++) {
        if (cp >= 0xd800 && cp <= 0xdfff) continue;
        if (/^\s$/u.test(String.fromCodePoint(cp))) whitespace.push(cp);
    }
    const ws = ["\t", "\n", " ", " ", "\u0085", "﻿", " ", "　", "\u000b", "᠎"];
    const trims = [];
    for (let i = 0; i < 300; i++) {
        const s = randomString(3, ws) + randomString(6) + randomString(3, ws);
        trims.push([s, s.trim(), s.trimStart(), s.trimEnd()]);
    }
    write(JS_COMPAT_DIR, "whitespace.json", { whitespace, trims });
}

// ---------------------------------------------------------------------------
// js-compat: unicode

function unicodeVectors() {
    const runs = [];
    const predicates = [];
    let previous;
    for (let cp = 0; cp <= 0x10ffff; cp++) {
        const category = unicode.getCategory(cp);
        if (category !== previous) {
            runs.push([cp, category]);
            const mask =
                (unicode.isAlphabetic(cp) ? 1 : 0) |
                (unicode.isDigit(cp) ? 2 : 0) |
                (unicode.isLowerCase(cp) ? 4 : 0) |
                (unicode.isUpperCase(cp) ? 8 : 0) |
                (unicode.isWhiteSpace(cp) ? 16 : 0);
            predicates.push([cp, mask]);
            previous = category;
        }
    }
    const outOfRange = [0x110000, 0x7fffffff, 0xffffffff].map((cp) => [cp, unicode.getCategory(cp)]);
    write(JS_COMPAT_DIR, "unicode.json", { runs, predicates, out_of_range: outOfRange });
}

// ---------------------------------------------------------------------------
// js-compat: sort

function sortVectors() {
    random = mulberry32(4);
    const sizes = [0, 1, 2, 3, 5, 10, 31, 32, 33, 63, 64, 65, 100, 127, 128, 129, 200, 256, 500, 1000, 2000];
    const comparators = {
        // Fully inconsistent: -1, 0 or 1 per ordered pair.
        random3: (seed) => (a, b) => (mix(seed, a, b) % 3) - 1,
        // Consistent with many ties: checks stability.
        keys: (seed) => (a, b) => (mix(seed, a, 7) % 13) - (mix(seed, b, 7) % 13),
        // Mostly consistent, occasionally random.
        noisy: (seed) => (a, b) =>
            mix(seed, a, b) % 17 === 0 ? (mix(seed, b, a) % 3) - 1 : (mix(seed, a, 7) % 50) - (mix(seed, b, 7) % 50),
        // Long ascending and descending natural runs (galloping), with noise.
        runs: (seed) => {
            const key = (i) => {
                const segment = Math.floor(i / (20 + (mix(seed, 0, 0) % 80)));
                const descending = mix(seed, segment, 1) % 2 === 0;
                const base = mix(seed, segment, 2) % 1000;
                return descending ? base - i : base + i;
            };
            return (a, b) => (mix(seed, a, b) % 101 === 0 ? -1 : key(a) - key(b));
        },
        // Fractional and NaN results (NaN counts as 0).
        nan: (seed) => (a, b) =>
            mix(seed, a, b) % 5 === 0 ? NaN : ((mix(seed, a, 3) % 9) - (mix(seed, b, 3) % 9)) / 3,
    };
    const cases = [];
    for (const [kind, make] of Object.entries(comparators)) {
        for (const n of sizes) {
            for (const seed of [n * 7 + 1, n * 13 + 5]) {
                const v = Array.from({ length: n }, (_, i) => i);
                v.sort(make(seed));
                cases.push({ kind, n, seed, expected: v });
            }
        }
    }

    // Explicit comparison tables, including collection-utils' compareKeys over
    // mixed number/string keys (JSONSchemaInput with quicktypePropertyOrder).
    const compareKeys = (sa, sb) => (sa < sb ? -1 : sa > sb ? 1 : 0);
    const tables = [];
    const addTable = (keys) => {
        const n = keys.length;
        const table = [];
        for (let a = 0; a < n; a++) for (let b = 0; b < n; b++) table.push(compareKeys(keys[a], keys[b]));
        const v = Array.from({ length: n }, (_, i) => i);
        v.sort((a, b) => compareKeys(keys[a], keys[b]));
        tables.push({ keys: keys.map(String), n, table, expected: v });
    };
    // Properties {z,b,m,a,10,9,Y} with quicktypePropertyOrder ["m","10"].
    const order = ["m", "10"];
    addTable(["z", "b", "m", "a", "10", "9", "Y"].map((k) => (order.includes(k) ? order.indexOf(k) : k.toLowerCase())));
    const keyPool = ["a", "b", "z", "10", "9", "2", "", "1e1", " 3 ", "0x10", "abc", "Infinity", "-1"];
    for (let i = 0; i < 40; i++) {
        const n = 2 + randInt(i < 30 ? 20 : 70);
        addTable(Array.from({ length: n }, () => (random() < 0.4 ? randInt(5) : pick(keyPool))));
    }

    // Default sort() on strings.
    const stringCases = [];
    for (let i = 0; i < 60; i++) {
        const v = Array.from({ length: randInt(80) }, () => randomString(3));
        stringCases.push({ input: v, expected: [...v].sort() });
    }

    write(JS_COMPAT_DIR, "sort.json", { comparators: cases, tables, strings: stringCases });
}

// ---------------------------------------------------------------------------
// js-compat: json

function jsonVectors() {
    random = mulberry32(5);
    const quote = [];
    const controlPalette = [...PALETTE, ...Array.from({ length: 32 }, (_, i) => String.fromCharCode(i))];
    for (const s of EDGE_STRINGS) quote.push([s, JSON.stringify(s)]);
    for (let i = 0; i < 300; i++) {
        const s = randomString(10, controlPalette);
        quote.push([s, JSON.stringify(s)]);
    }

    const keyPool = ["a", "b", "zeta", "alpha", "0", "1", "2", "10", "01", "-1", "1.5", "4294967294",
        "4294967295", "__proto__", "constructor", "", "é", "😀", "\n"];
    const tree = (depth) => {
        const r = random();
        if (depth > 3 || r < 0.35) {
            const leaf = randInt(5);
            if (leaf === 0) return [["null"], null];
            if (leaf === 1) {
                const b = random() < 0.5;
                return [["bool", b], b];
            }
            if (leaf === 2 || leaf === 3) {
                const x = pick([0, -0, 1.5, -2, 1e21, 1e-7, NaN, Infinity, 123456789, random() * 1e5]);
                return [["num", f64ToHex(x)], x];
            }
            const s = randomString(5, controlPalette);
            return [["str", s], s];
        }
        if (r < 0.6) {
            const items = Array.from({ length: randInt(4) }, () => tree(depth + 1));
            return [["arr", items.map((i) => i[0])], items.map((i) => i[1])];
        }
        const entries = Array.from({ length: randInt(5) }, () => [pick(keyPool), tree(depth + 1)]);
        const obj = {};
        for (const [k, [, v]] of entries) {
            // CreateDataProperty, as JSON.parse does: "__proto__" stays a key.
            Object.defineProperty(obj, k, { value: v, enumerable: true, writable: true, configurable: true });
        }
        return [["obj", entries.map(([k, [t]]) => [k, t])], obj];
    };
    const stringify = [];
    const gaps = [[null, null], [2, null], [4, null], [12, null], [0.5, null], [null, "\t"],
        [null, "abcdefghijklmnop"], [null, ""]];
    for (let i = 0; i < 250; i++) {
        const [t, v] = tree(0);
        const [spaces, str] = gaps[i % gaps.length];
        const space = spaces ?? str ?? undefined;
        stringify.push({ value: t, spaces, str, expected: JSON.stringify(v, undefined, space) });
    }
    write(JS_COMPAT_DIR, "json.json", { quote, stringify });
}

// ---------------------------------------------------------------------------
// js-compat: pluralize

function pluralizeVectors() {
    random = mulberry32(6);
    const stems = ["us", "cat", "bo", "qu", "child", "pe", "matr", "ind", "kni", "wi", "li", "ar", "wol",
        "zomb", "mon", "smil", "tit", "m", "l", "seraph", "alumn", "dat", "criteri", "analy", "test",
        "her", "gr", "e", "x", "ch", "sh", "z", "eau", "bus", "stat", "vir", "fung", "alias", "gas",
        "ad", "night", "after", "half", "deer", "fish", "pox", "sheep", "measl", "chin", "pokem"];
    const endings = ["", "s", "es", "ies", "ves", "ses", "xes", "ches", "men", "man", "ice", "ouse",
        "eaux", "eau", "ae", "a", "um", "on", "i", "us", "is", "ss", "ese", "y", "ey", "fe", "f", "o",
        "oes", "im", "ren", "ople", "rson", "ix", "ex", "ices", "es", "ions", "ys"];
    const recase = (w) => {
        const r = random();
        if (r < 0.5) return w;
        if (r < 0.65) return w.toUpperCase();
        if (r < 0.8) return w.charAt(0).toUpperCase() + w.slice(1);
        return [...w].map((c) => (random() < 0.5 ? c.toUpperCase() : c)).join("");
    };
    const special = ["é", "ſ", "K", "😀", "𝐀", "ß", "İ", "-", "_", " ", "1", "$"];
    const words = new Set(EDGE_STRINGS);
    const irregulars = ["I", "we", "me", "us", "he", "she", "they", "them", "themselves", "itself",
        "echoes", "genera", "schemata", "oxen", "axes", "dice", "yeses", "feet", "eaves", "geese",
        "teeth", "quizzes", "humans", "thieves", "passersby", "passerby", "pickaxes", "looies"];
    for (const w of irregulars) for (const v of [w, w.toUpperCase(), w[0].toUpperCase() + w.slice(1)]) words.add(v);
    for (const w of ["sheep", "Pokemon", "Pokémon", "Japanese", "news", "equipment", "you", "thou"]) words.add(w);
    for (let i = 0; i < 2500; i++) {
        let w = pick(stems) + pick(endings);
        if (random() < 0.15) w = pick(special) + w;
        if (random() < 0.1) {
            const cps = [...w];
            w = cps.slice(0, randInt(cps.length + 1)).join("") + pick(special) + cps.slice(randInt(cps.length + 1)).join("");
        }
        words.add(recase(w));
    }
    for (const name of sample(CORPUS, 2000)) words.add(name);
    for (let i = 0; i < 150; i++) words.add(randomString(6));
    const cases = [...words].map((w) => [w, pluralize.singular(w), pluralize.plural(w),
        pluralize.isSingular(w), pluralize.isPlural(w)]);
    const counted = [["apple", 1, true], ["apple", 0, true], ["apple", 2, false], ["Person", 1.5, true],
        ["box", -1, true], ["box", NaN, true]].map(([w, n, inc]) => [w, f64ToHex(n), inc, pluralize(w, n, inc)]);
    write(JS_COMPAT_DIR, "pluralize.json", { words: cases, counted });
}

// ---------------------------------------------------------------------------
// js-compat: wordwrap

function wordwrapVectors() {
    random = mulberry32(7);
    const palette = [..."abcdefghij", " ", " ", " ", "  ", "\t", "\n", "\n\n", " \n ", " ", "\u0085",
        "﻿", " ", "😀", "中文", "-", "."];
    const word = () => {
        const n = 1 + randInt(random() < 0.05 ? 120 : 12);
        let w = "";
        for (let i = 0; i < n; i++) w += random() < 0.8 ? "abcdefghijklmnopqrstuvwxyz"[randInt(26)] : pick(palette);
        return w;
    };
    const cases = [];
    const widths = [[90, undefined], [90, undefined], [20, undefined], [5, undefined], [2, 30], [4, 12], [0, 40]];
    for (let i = 0; i < 400; i++) {
        let text = "";
        const n = randInt(40);
        for (let j = 0; j < n; j++) text += word() + pick([" ", " ", "  ", "\n", "\t", " \n", "", " "]);
        if (random() < 0.2) text = pick(["  ", "\n", "\t"]) + text;
        const [start, stop] = widths[i % widths.length];
        cases.push([text, start, stop ?? null, wordwrap(start, stop)(text)]);
    }
    for (const s of ["", " ", "a", "\n", "a\n\nb", "x".repeat(95), "x ".repeat(60)]) {
        cases.push([s, 90, null, wordwrap(90)(s)]);
    }
    write(JS_COMPAT_DIR, "wordwrap.json", { cases });
}

// ---------------------------------------------------------------------------
// quicktype-core: support/Strings.ts and Acronyms.ts

function stringsVectors() {
    random = mulberry32(8);
    const S = Strings;
    const inputs = new Set(EDGE_STRINGS);
    for (const name of sample(CORPUS, 900)) inputs.add(name);
    for (let i = 0; i < 500; i++) inputs.add(randomString(10));

    const legalizers = {
        ascii: S.legalizeCharacters((cp) => S.isAscii(cp) && S.isLetterOrUnderscoreOrDigit(cp)),
        unicode: S.legalizeCharacters(S.isLetterOrUnderscoreOrDigit),
    };
    const styles = ["pascal", "camel", "underscore", "upper-underscore", "pascal-upper-acronyms",
        "camel-upper-acronyms", "original"];
    const namers = [];
    for (const [lname, legalize] of Object.entries(legalizers)) {
        for (const style of styles) namers.push([`${style}/${lname}`, S.makeNameStyle(style, legalize)]);
    }
    namers.push(["pascal/ascii/prefix", S.makeNameStyle("pascal", legalizers.ascii, "QT")]);
    // Golang's combineWords configuration with an ASCII-letter start predicate,
    // to exercise the "the" prefix path.
    const golang = (s) =>
        S.combineWords(S.splitIntoWords(s), legalizers.ascii, S.firstUpperWordStyle, S.firstUpperWordStyle,
            S.allUpperWordStyle, S.allUpperWordStyle, "", (cp) => S.isAscii(cp) && S.isLetter(cp));
    const phpEscape = S.utf16ConcatMap((codePoint) => {
        const character = String.fromCharCode(codePoint);
        if (codePoint === 0x0a) return `' . "\\n" . '`;
        if (codePoint === 0x0d) return `' . "\\r" . '`;
        return codePoint === 0x27 || codePoint === 0x5c ? `\\${character}` : character;
    });
    const javaEscape = S.utf16ConcatMap(S.escapeNonPrintableMapper(S.isAscii, S.standardUnicodeHexEscape));
    const utf16Legalize = S.utf16LegalizeCharacters(S.isLetterOrUnderscore);

    const cases = [...inputs].map((s) => ({
        s,
        words: S.splitIntoWords(s).map(({ word, isAcronym }) => [word, isAcronym]),
        names: namers.map(([, f]) => f(s)),
        golang: golang(s),
        capitalize: S.capitalize(s),
        decapitalize: S.decapitalize(s),
        pascal_case: S.pascalCase(s),
        camel_case: S.camelCase(s),
        snake_case: S.snakeCase(s),
        trim_end: S.trimEnd(s),
        utf16_string_escape: S.utf16StringEscape(s),
        string_escape: S.stringEscape(s),
        java_escape: javaEscape(s),
        php_escape: phpEscape(s),
        start_with_letter: [S.startWithLetter(S.isLetterOrUnderscore, true, s), S.startWithLetter(S.isLetterOrUnderscore, false, s)],
        legalize: S.legalizeCharacters(S.isLetterOrUnderscore)(s),
        utf16_legalize: units(utf16Legalize(s)),
        acronym_styles: Object.values(Acronyms.AcronymStyleOptions).map((o) =>
            s === "" ? "" : Acronyms.acronymStyle(o)(s)),
        word_styles: s === "" ? null : [S.firstUpperWordStyle(s), S.allUpperWordStyle(s), S.allLowerWordStyle(s)],
    }));

    // Code-point predicates at the start of every category run, plus astral
    // and boundary values.
    const points = new Set([0x5f, 0xffff, 0x10000, 0x1f600, 0x1d400, 0x10ffff]);
    let previous;
    for (let cp = 0; cp <= 0x10ffff; cp++) {
        const c = unicode.getCategory(cp);
        if (c !== previous) {
            points.add(cp);
            previous = c;
        }
    }
    const predicateFns = [S.isPrintable, S.isAscii, S.isLetter, S.isDigit, S.isNumeric, S.isLetterOrDigit,
        S.isLetterOrUnderscore, S.isLetterOrUnderscoreOrDigit, S.isWordCharacter, S.fastIsUpperCase];
    const predicates = [...points].sort((a, b) => a - b).map((cp) => [cp,
        predicateFns.reduce((mask, f, i) => mask | (f(cp) ? 1 << i : 0), 0)]);

    const misc = {
        repeat_string: [["ab", 0], ["ab", 1], ["ab", 5], ["", 3], ["😀", 3], [" ", 17]].map(([s, n]) => [s, n, S.repeatString(s, n)]),
        int_to_hex: [[0, 4], [255, 2], [255, 1], [0x1f600, 8], [0xffff, 4], [10, 0]].map(([i, w]) => [i, w, S.intToHex(i, w)]),
        unicode_hex_escape: [0, 0x41, 0xffff, 0x10000, 0x1f600, 0x10ffff].map((cp) => [cp, S.standardUnicodeHexEscape(cp)]),
        add_prefix: [["QT", "QTFoo"], ["QT", "Foo"], ["", "x"], ["Q", ""]].map(([p, n]) => [p, n, S.addPrefixIfNecessary(p, n)]),
    };

    write(CORE_DIR, "strings.json", { namers: namers.map(([n]) => n), cases, predicates, misc });

    write(CORE_DIR, "acronyms.json", {
        acronyms: ACRONYMS,
        options: Object.entries(Acronyms.AcronymStyleOptions),
    });
}

// ---------------------------------------------------------------------------
// quicktype-core: IntegerRange.ts

function integerRangeVectors() {
    random = mulberry32(9);
    const ranges = {
        INT64_RANGE: IntegerRange.INT64_RANGE,
        INT32_RANGE: IntegerRange.INT32_RANGE,
        INT16_RANGE: IntegerRange.INT16_RANGE,
        INT8_RANGE: IntegerRange.INT8_RANGE,
        JS_SAFE_INTEGER_RANGE: IntegerRange.JS_SAFE_INTEGER_RANGE,
    };
    const values = new Set(["", "-", "0", "-0", "00", "-00", "000", "1", "-1", "01", "-01", "0001"]);
    for (const range of Object.values(ranges)) {
        for (const bound of [range.min, range.max]) {
            const digits = bound.replace("-", "");
            const sign = bound.startsWith("-") ? "-" : "";
            values.add(bound);
            values.add(sign + "00" + digits);
            values.add(sign + (BigInt(digits) + 1n).toString());
            values.add(sign + (BigInt(digits) - 1n).toString());
            values.add(sign + digits + "0");
        }
    }
    for (let i = 0; i < 400; i++) {
        let s = random() < 0.4 ? "-" : "";
        s += "0".repeat(random() < 0.2 ? randInt(4) : 0);
        const n = 1 + randInt(25);
        for (let j = 0; j < n; j++) s += randInt(10);
        values.add(s);
    }
    const list = [...values];
    const inRange = [];
    for (const s of list) {
        inRange.push([s, Object.keys(ranges).map((r) => IntegerRange.integerStringInRange(s, ranges[r]))]);
    }
    const compare = [];
    for (let i = 0; i < 1500; i++) {
        const a = pick(list);
        const b = random() < 0.1 ? a : pick(list);
        compare.push([a, b, IntegerRange.compareIntegerStrings(a, b)]);
    }
    write(CORE_DIR, "integer_range.json", { ranges, range_names: Object.keys(ranges), in_range: inRange, compare });
}

// ---------------------------------------------------------------------------
// quicktype-core: MarkovChain.ts

function markovVectors() {
    random = mulberry32(10);
    const mc = MarkovChain.load();
    let fnv = 0x811c9dc5;
    for (const code of mc.probabilityCodes) fnv = Math.imul(fnv ^ code, 0x01000193) >>> 0;
    const histogram = new Array(mc.probabilities.length).fill(0);
    for (const code of mc.probabilityCodes) histogram[code]++;

    const words = new Set(EDGE_STRINGS);
    for (const name of sample(CORPUS, 2500)) words.add(name);
    for (let i = 0; i < 500; i++) words.add(randomString(10));
    for (let i = 0; i < 500; i++) {
        let w = "";
        const n = 3 + randInt(6);
        for (let j = 0; j < n; j++) w += " -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz"[randInt(65)];
        words.add(w);
    }
    // Every word records evaluate(); every tenth also evaluateFull()'s scores.
    const evaluate = [...words].map((w, i) => {
        const [p, scores] = MarkovChain.evaluateFull(mc, w);
        const full = i % 10 === 0 ? [f64ToHex(p), scores.map(f64ToHex)] : null;
        return [w, f64ToHex(MarkovChain.evaluate(mc, w)), full];
    });

    const trainLines = [
        ["name", "firstName", "id", "", "ab", "a😀bc", "naïve", "x"],
        sample(CORPUS, 40),
    ];
    const train = trainLines.map((lines) => [lines, JSON.stringify(MarkovChain.trainMarkovChain
        ? MarkovChain.trainMarkovChain(lines, 3) : MarkovChain.train(lines, 3))]);

    // generate() draws from Math.random; replace it with mulberry32.
    const generate = [];
    const realRandom = Math.random;
    try {
        for (const [state, seed, unseenWeight] of [["ab", 1, 0], ["ab", 2, 1000], ["Na", 3, 0],
            ["  ", 4, 10], ["é1", 5, 0], ["zz", 6, 1], ["_i", 7, 0.5]]) {
            Math.random = mulberry32(seed);
            const out = [];
            for (let i = 0; i < 20; i++) out.push(MarkovChain.generate(mc, state, unseenWeight));
            generate.push([state, seed, unseenWeight, out]);
        }
    } finally {
        Math.random = realRandom;
    }

    write(CORE_DIR, "markov_chain.json", {
        codes_fnv1a: fnv,
        codes_length: mc.probabilityCodes.length,
        codes_histogram: histogram,
        probabilities: [...mc.probabilities].map(f64ToHex),
        evaluate,
        train,
        generate,
    });
}

numberVectors();
utf16Vectors();
whitespaceVectors();
unicodeVectors();
sortVectors();
jsonVectors();
pluralizeVectors();
wordwrapVectors();
stringsVectors();
integerRangeVectors();
markovVectors();
console.log(`total: ${(totalBytes / 1024 / 1024).toFixed(2)} MiB`);
