// The case generator: a fuzz case is a pure function of its seed (and of the
// language option definitions, read from the reference quicktype-core).
//
// A case:
//
//   {
//     seed, lang,
//     src: "json" | "schema",
//     topLevels: [{ name, samples: [text, ...] }],   // src json
//     schemas: [{ name, text }],                     // src schema
//     rendererOptions: { name: value },              // as command-line-args gives them
//     flags: { inferMaps: false, ..., alphabetizeProperties: true, allPropertiesOptional: true },
//     api: { indentation?, leadingComments?, outputFilename? },  // API runs only
//     cli: { out?, quiet? },                                      // CLI runs only
//   }
//
// JSON samples come from random *shapes* (classes, maps, enums, unions,
// arrays, formatted strings, recursive trees), instantiated several times so
// that inference sees repeated structure: classes to unify, enums near the
// `cases < sqrt(values)` threshold, maps near the 20 / 50 / 500 property
// thresholds. Keys and names are drawn from target-language keywords
// (tests/keywords.txt), acronyms (tests/acronyms.txt), integer-like and
// otherwise odd strings.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { genGraphQL } from "./graphql-gen.mjs";
import { arr, lit, num, obj, str, toText } from "./json-text.mjs";
import { Rng } from "./rng.mjs";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "..");
const lines = (file) =>
    fs
        .readFileSync(path.join(repoRoot, "tests", file), "utf8")
        .split("\n")
        .map((l) => l.split("\t")[0].trim())
        .filter((l) => l.length > 0);

const KEYWORDS = lines("keywords.txt");
const ACRONYMS = lines("acronyms.txt");

/** quicktype's languages by canonical name, in `defaultTargetLanguages` order. */
export const LANGUAGES = [
    "cjson", "c++", "crystal", "cs", "dart", "elixir", "elm", "flow", "go", "haskell", "java",
    "javascript", "javascript-prop-types", "schema", "kotlin", "objc", "php", "pike", "python",
    "ruby", "rust", "scala3", "smithy4a", "swift", "typescript", "typescript-effect-schema",
    "typescript-zod",
];

const COMMON_WORDS = [
    "id", "name", "value", "type", "kind", "data", "items", "item", "user", "users", "address",
    "street", "city", "count", "total", "price", "status", "created", "updated", "tags", "tag",
    "children", "child", "parent", "node", "nodes", "entry", "entries", "person", "people",
    "results", "result", "error", "errors", "message", "code", "url", "link", "links", "meta",
    "properties", "property", "list", "map", "key", "keys", "values", "index", "length",
    "description", "title", "date", "time", "version", "config", "settings", "option", "options",
    "point", "points", "x", "y", "z", "lat", "lng", "geometry", "feature", "features", "foo",
    "bar", "baz", "qux", "alpha", "beta", "gamma", "delta", "mouse", "mice", "goose", "geese",
    "datum", "criteria", "analysis", "series", "species", "news", "status", "bus", "quiz", "ox",
];

const ODD_KEYS = [
    "", " ", "  ", "_", "__", "___", "-", "$", "$ref", "$id", "$schema", "@type", "@id", "#", "#/x",
    "__proto__", "constructor", "toString", "valueOf", "hasOwnProperty", "prototype", "__defineGetter__",
    "0", "1", "2", "10", "42", "007", "-1", "1.5", "1e3", "4294967295", "4294967296", "9007199254740993",
    "a-b", "a_b", "a b", "a.b", "a/b", "a\\b", "a:b", "a+b", "a,b", "a;b", "a'b", 'a"b', "a`b",
    "aB", "AB", "Ab", "ab", "a_B", "A_B", "ABC", "aBC", "abC", "ABc",
    "1abc", "123abc", "abc123", "a1b2", "_1", "1_", "x1", "X1",
    "camelCase", "PascalCase", "snake_case", "kebab-case", "SCREAMING_CASE", "Mixed_Case-key here",
    "URL", "url", "Url", "userID", "UserID", "user_id", "userId", "HTTPServerURL", "httpServerUrl",
    "IOError", "iOS", "macOS", "JSONData", "jsonData", "XMLHttpRequest", "ID", "Id", "id",
    "ñandú", "über", "Ünïcödé", "straße", "İstanbul", "ǅungla", "日本語", "中文名称", "한국어", "Ελληνικά",
    "ὈΔΥΣΣΕΎΣ", "кириллица", "עברית", "العربية", "emoji😀", "😀", "👍🏽ok", "𝒳math", "á", "é",
    "tab\tkey", "new\nline", "cr\rkey", "nul\u0000key", "zero​width", "nbsp key", " sep",
    "null", "true", "false", "undefined", "NaN", "Infinity", "None", "nil", "Nil", "self", "Self",
    "this", "super", "object", "Object", "string", "String", "int", "Int", "number", "Number",
    "bool", "Boolean", "array", "Array", "list", "List", "map", "Map", "dict", "Dict", "any", "Any",
    "date", "Date", "DateTime", "uuid", "UUID", "JSON", "Json", "json", "Converter", "Convert",
    "TopLevel", "topLevel", "Coordinate", "Purple", "Fluffy", "Tentacled", "Sticky", "Indigo",
];

function capitalize(s) {
    return s.length === 0 ? s : s[0].toUpperCase() + s.slice(1);
}

/** An identifier-like name made of words in a random case style. */
function compoundName(rng) {
    const n = rng.weighted([[5, 1], [4, 2], [2, 3], [1, 4]]);
    const parts = [];
    for (let i = 0; i < n; i++) {
        parts.push(
            rng.weighted([
                [6, () => rng.pick(COMMON_WORDS)],
                [2, () => rng.pick(ACRONYMS)],
                [1, () => rng.pick(KEYWORDS)],
            ])(),
        );
    }

    switch (rng.int(6)) {
        case 0:
            return parts.join("_");
        case 1:
            return parts.map((p, i) => (i === 0 ? p : capitalize(p))).join("");
        case 2:
            return parts.map(capitalize).join("");
        case 3:
            return parts.join("-");
        case 4:
            return parts.join(" ");
        default:
            return parts.map((p) => p.toUpperCase()).join(rng.pick(["_", "", "-"]));
    }
}

/** A property key, type name or enum case. */
export function genKey(rng) {
    return rng.weighted([
        [8, () => rng.pick(COMMON_WORDS)],
        [6, () => compoundName(rng)],
        [3, () => rng.pick(KEYWORDS)],
        [1, () => capitalize(rng.pick(KEYWORDS))],
        [2, () => rng.pick(ACRONYMS)],
        [1, () => rng.pick(ACRONYMS).toUpperCase()],
        [4, () => rng.pick(ODD_KEYS)],
        [1, () => `${rng.pick(COMMON_WORDS)}${rng.range(0, 30)}`],
        [1, () => "x".repeat(rng.range(40, 140))],
    ])();
}

function hex(rng, n) {
    let s = "";
    for (let i = 0; i < n; i++) s += "0123456789abcdef"[rng.int(16)];
    return s;
}

const pad = (n, w = 2) => String(n).padStart(w, "0");

function genDate(rng) {
    if (rng.chance(0.15)) {
        return rng.pick(["2021-02-29", "2020-02-30", "2021-13-01", "2021-00-10", "0000-01-01", "9999-12-31",
            "2021-1-1", "21-01-01", "2020-02-29", "2021-04-31", "20210101", "2021-01-01 "]);
    }

    return `${pad(rng.range(1900, 2099), 4)}-${pad(rng.range(1, 12))}-${pad(rng.range(1, 28))}`;
}

function genTime(rng) {
    if (rng.chance(0.15)) {
        return rng.pick(["24:00:00Z", "23:59:60Z", "12:00", "12:00:00", "1:02:03Z", "12:00:00.Z",
            "12:00:00+25:00", "12:00:00+01", "12:60:00Z", "00:00:00z", "12:00:00.123456789-11:59"]);
    }

    const frac = rng.chance(0.3) ? `.${String(rng.range(0, 999999)).slice(0, rng.range(1, 6))}` : "";
    const tz = rng.weighted([[5, "Z"], [1, "z"], [3, `+${pad(rng.range(0, 14))}:${pad(rng.pick([0, 30, 45]))}`],
        [2, `-${pad(rng.range(0, 12))}:00`], [1, ""]]);
    return `${pad(rng.range(0, 23))}:${pad(rng.range(0, 59))}:${pad(rng.range(0, 59))}${frac}${tz}`;
}

function genDateTime(rng) {
    if (rng.chance(0.1)) {
        return rng.pick(["2021-01-01T00:00:00", "2021-01-01 12:00:00Z", "2021-01-01T25:00:00Z",
            "2021-01-01t12:00:00z", "2021-02-30T12:00:00Z", "2021-01-01T12:00:00.000000001+00:00",
            "1970-01-01T00:00:00.000Z", "2021-01-01T12:00Z"]);
    }

    return `${genDate(rng)}${rng.weighted([[9, "T"], [1, "t"]])}${genTime(rng)}`;
}

function genUuid(rng) {
    const u = `${hex(rng, 8)}-${hex(rng, 4)}-${hex(rng, 4)}-${hex(rng, 4)}-${hex(rng, 12)}`;
    return rng.weighted([[8, u], [1, u.toUpperCase()], [1, u.slice(1)]]);
}

function genIntegerString(rng) {
    return rng.weighted([
        [5, () => String(rng.range(-1000, 100000))],
        [3, () => rng.pick(["0", "-0", "007", "00", "2147483647", "2147483648", "-2147483648",
            "-2147483649", "1e3", "+1", "1.0", "9007199254740993", "12345678901234567890"])],
    ])();
}

function genUri(rng) {
    return rng.pick(["https://example.com", "http://example.com/a/b?c=d#e", "https://x.io/{id}",
        "ftp://files.example.org/x.txt", "HTTPS://EXAMPLE.COM", "mailto:a@b.c", "https://", "http://ü.de/ö",
        `https://api.example.com/${rng.pick(COMMON_WORDS)}/${rng.range(1, 999)}`]);
}

/** A plain string, mostly not a recognized format. */
function genPlainString(rng) {
    return rng.weighted([
        [6, () => rng.pick(COMMON_WORDS)],
        [3, () => compoundName(rng)],
        [2, () => rng.pick(ODD_KEYS)],
        [1, () => ""],
        [1, () => "long ".repeat(rng.range(13, 30))],
        [1, () => `${rng.pick(COMMON_WORDS)} ${rng.pick(COMMON_WORDS)} ${rng.range(0, 99)}`],
        [1, () => rng.pick(["true", "false", "True", "FALSE", "null", "1", "-5", "3.14", "a1b2c3"])],
    ])();
}

const INT_EDGES = ["0", "-0", "1", "-1", "127", "128", "-128", "-129", "255", "256", "32767", "32768",
    "-32768", "-32769", "65535", "65536", "2147483647", "2147483648", "-2147483648", "-2147483649",
    "4294967295", "4294967296", "9007199254740991", "9007199254740992", "9007199254740993",
    "-9007199254740993", "9223372036854775807", "9223372036854775808", "-9223372036854775808",
    "-9223372036854775809", "18446744073709551615", "18446744073709551616",
    "123456789012345678901234567890", "100000000000000000000", "1000000000000000000000"];
const DOUBLE_EDGES = ["0.0", "-0.0", "1.0", "-1.0", "0.1", "0.5", "1.5", "-2.75", "3.141592653589793",
    "1e2", "1E2", "1e+2", "1E-2", "1e-7", "1.5e300", "-1.5e-300", "5e-324", "1.7976931348623157e308",
    "1e21", "1e400", "-1e400", "2.0e0", "100.000", "9007199254740993.0", "0.30000000000000004",
    "123456789.123456789", "1e-0", "0e0", "-0e-0", "4.35"];

function genIntLiteral(rng) {
    return rng.weighted([
        [6, () => String(rng.range(-100, 1000))],
        [2, () => String(rng.range(-2147483648, 2147483647))],
        [2, () => rng.pick(INT_EDGES)],
    ])();
}

function genDoubleLiteral(rng) {
    return rng.weighted([
        [5, () => `${rng.range(-1000, 1000)}.${rng.range(0, 999)}`],
        [3, () => rng.pick(DOUBLE_EDGES)],
        [1, () => `${rng.range(1, 9)}e${rng.range(-10, 30)}`],
    ])();
}

// ---- Shapes ------------------------------------------------------------------

const STRING_FORMATS = ["date", "time", "date-time", "uuid", "integer-string", "bool-string", "uri", "plain"];

function genStringShape(rng) {
    const format = rng.weighted([[10, "plain"], [2, "date"], [2, "time"], [2, "date-time"], [2, "uuid"],
        [2, "integer-string"], [2, "bool-string"], [1, "uri"], [2, "mixed"]]);
    return { k: "string", format };
}

function genEnumShape(rng) {
    const n = rng.weighted([[3, 2], [3, 3], [2, 4], [1, 5], [1, rng.range(6, 12)], [1, 1]]);
    const style = rng.weighted([[6, "words"], [1, "numbers"], [1, "case"], [1, "odd"], [1, "empty"]]);
    const cases = new Set();
    for (let i = 0; cases.size < n && i < 50; i++) {
        switch (style) {
            case "numbers":
                cases.add(rng.chance(0.8) ? String(rng.range(0, 30)) : rng.pick(COMMON_WORDS));
                break;
            case "case": {
                const w = rng.pick(COMMON_WORDS);
                cases.add(rng.pick([w, w.toUpperCase(), capitalize(w), `${w}_`, `_${w}`, `${w}-x`, `${w} x`]));
                break;
            }
            case "odd":
                cases.add(rng.pick(ODD_KEYS));
                break;
            case "empty":
                cases.add(rng.pick(["", " ", rng.pick(COMMON_WORDS)]));
                break;
            default:
                cases.add(rng.chance(0.8) ? rng.pick(COMMON_WORDS) : genKey(rng));
        }
    }

    return { k: "enum", cases: [...cases] };
}

/**
 * A random shape. `depth` limits nesting; `pool` holds shapes that other
 * places may reuse (same class at several paths, mutual structure).
 */
function genShape(rng, depth, pool) {
    if (pool.length > 0 && rng.chance(0.08)) return rng.pick(pool);
    const leafWeight = depth <= 0 ? 100 : 5;
    const kind = rng.weighted([
        [leafWeight, "leaf"],
        [depth > 0 ? 6 : 0, "class"],
        [depth > 0 ? 3.5 : 0, "array"],
        [depth > 0 ? 1.5 : 0, "map"],
        [depth > 0 ? 1.5 : 0, "union"],
        [depth > 1 ? 0.7 : 0, "tree"],
        [depth > 0 ? 0.6 : 0, "collide"],
        [depth > 1 ? 0.2 : 0, "deep"],
        [2.5, "enum"],
    ]);
    let shape;
    switch (kind) {
        case "class": {
            const n = rng.weighted([[1, 0], [6, rng.range(1, 4)], [4, rng.range(4, 8)], [1, rng.range(8, 25)]]);
            const props = [];
            const used = new Set();
            for (let i = 0; i < n; i++) {
                const key = genKey(rng);
                if (used.has(key) && !rng.chance(0.05)) continue;
                used.add(key);
                props.push({
                    key,
                    shape: genShape(rng, depth - 1, pool),
                    presence: rng.weighted([[7, 1], [2, 0.6], [1, 0.2]]),
                    nullP: rng.weighted([[8, 0], [2, 0.3], [1, 0.9]]),
                });
            }

            shape = { k: "class", props };
            break;
        }
        case "array":
            shape = {
                k: "array",
                item: genShape(rng, depth - 1, pool),
                len: rng.weighted([[2, [0, 0]], [6, [1, 4]], [3, [4, 12]], [2, [10, 40]]]),
            };
            break;
        case "map": {
            const count = rng.weighted([
                [3, rng.range(0, 6)],
                [3, rng.range(18, 22)],
                [2, rng.range(48, 52)],
                [1, rng.range(495, 505)],
                [1, rng.range(501, 650)],
            ]);
            const keys = rng.weighted([[3, "ids"], [2, "words"], [1, "numbers"], [1, "uuids"], [1, "dates"], [1, "mixed"]]);
            // Values of big maps stay small, to keep runs fast.
            const value = genShape(rng, count > 60 ? 0 : depth - 1, count > 60 ? [] : pool);
            shape = { k: "map", count, keys, value };
            break;
        }
        case "union": {
            const n = rng.range(2, 4);
            const members = [];
            for (let i = 0; i < n; i++) members.push(genShape(rng, depth - 1, pool));
            shape = { k: "union", members };
            break;
        }
        case "tree":
            shape = {
                k: "tree",
                childKey: rng.pick(["children", "nodes", "items", "next", "parent", "sub", genKey(rng)]),
                asArray: rng.chance(0.7),
                props: [{ key: rng.pick(["name", "id", "value", genKey(rng)]), shape: genShape(rng, 0, pool), presence: 1, nullP: 0 }],
                depth: rng.range(1, 4),
            };
            break;
        case "collide": {
            // Keys that differ only in case and punctuation: the same name
            // once styled, so naming has to make them unique.
            const words = [rng.pick(COMMON_WORDS), rng.chance(0.6) ? rng.pick(COMMON_WORDS) : rng.pick(ACRONYMS)];
            const variants = [
                words.join("_"), words.join("-"), words.join(" "), words.join("."), words.join(""),
                words[0] + capitalize(words[1]), words.map(capitalize).join(""), words.join("_").toUpperCase(),
                `_${words.join("_")}`, `${words.join("_")}_`, words.map((w) => w.toUpperCase()).join(""),
                `${words[0]}${words[1].toUpperCase()}`, `${words.join("")}1`, ` ${words.join(" ")}`, `$${words.join("")}`,
            ];
            const props = rng.sample(variants, rng.range(2, 6)).map((key) => ({
                key,
                shape: genShape(rng, depth - 1, pool),
                presence: rng.weighted([[3, 1], [1, 0.5]]),
                nullP: 0,
            }));
            shape = { k: "class", props };
            break;
        }
        case "deep": {
            // Long chains of nested arrays or single-property objects.
            const levels = rng.range(5, 60);
            let inner = genShape(rng, 0, pool);
            const asArray = rng.chance(0.5);
            const key = genKey(rng);
            for (let i = 0; i < levels; i++) {
                inner = asArray || rng.chance(0.1)
                    ? { k: "array", item: inner, len: [1, 1] }
                    : { k: "class", props: [{ key, shape: inner, presence: 1, nullP: 0 }] };
            }

            shape = inner;
            break;
        }
        case "enum":
            shape = genEnumShape(rng);
            break;
        default:
            shape = rng.weighted([
                [3, () => genStringShape(rng)],
                [2, () => ({ k: "int" })],
                [2, () => ({ k: "double" })],
                [1, () => ({ k: "number" })],
                [1.5, () => ({ k: "bool" })],
                [1, () => ({ k: "null" })],
                [0.5, () => ({ k: "emptyObject" })],
                [0.5, () => ({ k: "emptyArray" })],
            ])();
    }

    if (shape.k === "class" || shape.k === "enum" || (shape.k === "string" && rng.chance(0.3))) pool.push(shape);
    return shape;
}

function mapKey(rng, keys, i) {
    switch (keys) {
        case "ids":
            return rng.pick([`id${i}`, `${rng.pick(COMMON_WORDS)}_${i}`, `k${hex(rng, 6)}`]);
        case "numbers":
            return String(i * rng.range(1, 3));
        case "uuids":
            return genUuid(rng);
        case "dates":
            return genDate(rng);
        case "words":
            return `${rng.pick(COMMON_WORDS)}${rng.chance(0.5) ? capitalize(rng.pick(COMMON_WORDS)) : ""}${i}`;
        default:
            return genKey(rng) + (rng.chance(0.7) ? String(i) : "");
    }
}

function instString(rng, format) {
    const f = format === "mixed" ? rng.pick(STRING_FORMATS) : format;
    switch (f) {
        case "date":
            return genDate(rng);
        case "time":
            return genTime(rng);
        case "date-time":
            return genDateTime(rng);
        case "uuid":
            return genUuid(rng);
        case "integer-string":
            return genIntegerString(rng);
        case "bool-string":
            return rng.weighted([[5, "true"], [5, "false"], [1, "True"]]);
        case "uri":
            return genUri(rng);
        default:
            return genPlainString(rng);
    }
}

/** Instantiates a shape as a JSON tree. `budget.nodes` bounds the total size. */
function inst(rng, shape, budget, escapes) {
    budget.nodes--;
    const tooBig = budget.nodes <= 0;
    switch (shape.k) {
        case "null":
            return lit("null");
        case "bool":
            return lit(rng.chance(0.5) ? "true" : "false");
        case "int":
            return num(genIntLiteral(rng));
        case "double":
            return num(genDoubleLiteral(rng));
        case "number":
            return num(rng.chance(0.5) ? genIntLiteral(rng) : genDoubleLiteral(rng));
        case "string":
            return str(instString(rng, shape.format), escapes);
        case "enum":
            return str(rng.chance(0.03) ? genPlainString(rng) : rng.pick(shape.cases), escapes);
        case "emptyObject":
            return obj([]);
        case "emptyArray":
            return arr([]);
        case "class": {
            if (tooBig) return lit("null");
            const entries = [];
            for (const p of shape.props) {
                if (!rng.chance(p.presence)) continue;
                const value = rng.chance(p.nullP) ? lit("null") : inst(rng, p.shape, budget, escapes);
                entries.push([str(p.key, escapes), value]);
                if (rng.chance(0.01)) entries.push([str(p.key, escapes), inst(rng, p.shape, budget, escapes)]);
            }

            return obj(rng.chance(0.15) ? rng.shuffle(entries) : entries);
        }
        case "array": {
            if (tooBig) return arr([]);
            const n = rng.range(shape.len[0], shape.len[1]);
            const e = [];
            for (let i = 0; i < n && budget.nodes > 0; i++) e.push(inst(rng, shape.item, budget, escapes));
            return arr(e);
        }
        case "map": {
            const entries = [];
            const seen = new Set();
            for (let i = 0; i < shape.count; i++) {
                const key = mapKey(rng, shape.keys, i);
                if (seen.has(key)) continue;
                seen.add(key);
                // Past the budget only leaves, so big maps stay big but cheap.
                const leaf = !["class", "array", "map", "union", "tree"].includes(shape.value.k);
                const value = budget.nodes > 0 || leaf ? inst(rng, shape.value, budget, escapes) : lit("null");
                entries.push([str(key, escapes), value]);
            }

            return obj(entries);
        }
        case "union":
            return inst(rng, rng.pick(shape.members), budget, escapes);
        case "tree": {
            const make = (d) => {
                budget.nodes--;
                const entries = shape.props.map((p) => [str(p.key, escapes), inst(rng, p.shape, budget, escapes)]);
                if (d > 0 && budget.nodes > 0) {
                    if (shape.asArray) {
                        const kids = [];
                        const n = rng.range(0, 3);
                        for (let i = 0; i < n; i++) kids.push(make(d - 1));
                        entries.push([str(shape.childKey, escapes), arr(kids)]);
                    } else {
                        entries.push([str(shape.childKey, escapes), rng.chance(0.3) ? lit("null") : make(d - 1)]);
                    }
                }

                return obj(entries);
            };
            return make(rng.range(0, shape.depth));
        }
        default:
            throw new Error(`unknown shape ${shape.k}`);
    }
}

/** Replaces a few values with `{"$ref": ...}` objects (for --no-ignore-json-refs). */
function sprinkleRefs(rng, node) {
    if (node.t === "o") {
        for (const entry of node.e) {
            if (rng.chance(0.05)) {
                entry[1] = obj([[str("$ref"), str(rng.pick(["#", "#/definitions/x", `#/${node.e[0][0].raw}`, "#/0", "other.json#/a", "#/a/b/0"]))]]);
            } else {
                sprinkleRefs(rng, entry[1]);
            }
        }
    } else if (node.t === "a") {
        for (const item of node.e) sprinkleRefs(rng, item);
    }
}

/** Valid text with unusual whitespace, or (mostly) text that is not JSON at all. */
function oddText(rng, text) {
    const cut = rng.int(text.length + 1);
    const junk = ["NaN", "Infinity", "-", "01", "1.", ".5", "+1", "'x'", "undefined", "\u0000", "tru", "nul", "[", "]",
        "{", "}", ":", ",", '"', "\\"];
    const broken = ['{"a":1,}', "[1,]", "{a:1}", '{"a" 1}', "[1 2]", '"unterminated', '{"a":"\t"}', '{"\\x":1}', "1e",
        "-01", "[-]", '{"a":01}'];
    return rng.weighted([
        [2, () => text.slice(0, cut)],
        [1, () => `${text},`],
        [1, () => `${text} ${text}`],
        [1, () => `${text}\n${text}\n`],
        [1, () => `﻿${text}`],
        [1, () => `\r\n ${text.replace(/\n/g, "\r\n")}\t\r\n`],
        [1, () => `${text.slice(0, cut)}/* comment */${text.slice(cut)}`],
        [1, () => `${text.slice(0, cut)}${rng.pick(junk)}${text.slice(cut)}`],
        [1, () => ""],
        [1, () => rng.pick(broken)],
    ])();
}

function genJsonTopLevels(rng, lang) {
    const pool = [];
    const n = rng.weighted([[7, 1], [2, 2], [1, 3]]);
    const topLevels = [];
    const names = new Set();
    const escapes = rng.chance(0.1);
    for (let t = 0; t < n; t++) {
        let name = n === 1 && rng.chance(0.6) ? "TopLevel" : rng.chance(0.7) ? capitalize(compoundName(rng)) : genKey(rng);
        if (n > 1) {
            // CLI runs pass several top-levels as files in a directory.
            name = name.replace(/[/\\\0\n\r\t.]/g, "") || `T${t}`;
            if (names.has(name.toLowerCase())) name = `${name}${t}`;
        }

        names.add(name.toLowerCase());
        const record = () => {
            // A class whose properties are mostly given, as in real-world records.
            let shape;
            do shape = genShape(rng, rng.range(2, 4), pool);
            while (shape.k !== "class" && shape.k !== "map" && shape.k !== "tree" && rng.chance(0.85));
            return shape;
        };
        const rootShape = rng.weighted([
            [6, record],
            [3, () => ({ k: "array", item: record(), len: [rng.range(0, 3), rng.range(3, 30)] })],
            [0.5, () => genShape(rng, rng.range(1, 3), pool)],
            [0.5, () => genShape(rng, 0, pool)],
        ])();
        const samples = [];
        const m = rng.weighted([[6, 1], [3, 2], [1, rng.range(3, 5)]]);
        for (let s = 0; s < m; s++) {
            const budget = { nodes: rng.weighted([[5, 300], [3, 1500], [1, 4000]]) };
            let tree = inst(rng, rootShape, budget, escapes);
            if (rng.chance(0.03)) tree = inst(rng, genShape(rng, 1, pool), budget, escapes);
            if (rng.chance(0.08)) sprinkleRefs(rng, tree);
            const indent = rng.weighted([[5, undefined], [4, "  "], [1, "\t"]]);
            let text = toText(tree, indent);
            if (rng.chance(0.03)) text = oddText(rng, text);
            samples.push(text);
        }

        topLevels.push({ name, samples });
    }

    return topLevels;
}

// ---- JSON Schema -----------------------------------------------------------

const SCHEMA_FORMATS = ["date", "time", "date-time", "uuid", "uri", "integer", "boolean", "email", "hostname",
    "ipv4", "regex", "int32", "int64", "float", "double", "byte", "binary", "password", "uri-reference", "", "DATE"];
const PATTERNS = ["^[a-z]+$", "\\d+", "^\\w{2,5}$", "[A-Z]", "^(foo|bar)$", ".*", "^\\S+@\\S+$", "a\\/b", "^\\p{L}+$", "\"quoted\""];
const DESCRIPTIONS = ["A description.", "Line one\nLine two", "Has */ comment end", "Has /* comment start",
    "Unicode: ñ 日本 😀", "Quotes \" and ' and `", "Backslash \\ here", "  padded  ", "",
    "A very long description that goes on and on, so that renderers have to wrap it across several lines when they emit doc comments for it.",
    "<html> & entities", "#hash // slashes -- dashes", "$dollar {braces} [brackets]", "@param x", "trailing newline\n",
    "\t tabbed", "{-# PRAGMA #-}", "--[[ lua ]]", "\"\"\"triple\"\"\"", "Line\r\nCRLF"];

function schemaEnumValue(rng, kind) {
    switch (kind) {
        case "number":
            return rng.chance(0.5) ? num(genIntLiteral(rng)) : num(genDoubleLiteral(rng));
        case "mixed":
            return rng.weighted([
                [4, () => str(genKey(rng))],
                [1, () => num(genIntLiteral(rng))],
                [1, () => lit("null")],
                [1, () => lit(rng.pick(["true", "false"]))],
            ])();
        default:
            return str(rng.chance(0.8) ? rng.pick(COMMON_WORDS) : genKey(rng));
    }
}

const genNumberLiteral = (rng) => (rng.chance(0.5) ? genIntLiteral(rng) : genDoubleLiteral(rng));

/** A pattern with characters that need escaping in generated code. */
function oddPattern(rng) {
    const parts = ["\\d", "\\\\", '"', "'", "`", "${x}", "*/", "/*", "\\u00e9", "ü", "😀", "$", "^", "\n", "\t", "#{x}", "%s", "{{", "}}", "[^\\]]", "(?:a|b)", "\\/"];
    let p = "";
    const n = rng.range(1, 5);
    for (let i = 0; i < n; i++) p += rng.pick(parts);
    return p;
}

class SchemaGen {
    constructor(rng) {
        this.rng = rng;
        this.definitions = [];
        this.defsKey = rng.weighted([[8, "definitions"], [2, "$defs"]]);
    }

    decorate(entries, depth) {
        const rng = this.rng;
        if (rng.chance(0.15)) entries.push([str("title"), str(rng.chance(0.7) ? capitalize(compoundName(rng)) : genKey(rng))]);
        if (rng.chance(0.25)) entries.push([str("description"), str(rng.pick(DESCRIPTIONS))]);
        if (rng.chance(0.03)) entries.push([str("default"), this.anyValue(depth)]);
        if (rng.chance(0.03)) entries.push([str("examples"), arr([this.anyValue(depth)])]);
        if (rng.chance(0.03)) entries.push([str("nullable"), lit("true")]);
        if (rng.chance(0.03)) {
            // Keywords quicktype ignores.
            const ignored = rng.pick([
                [str("not"), obj([[str("type"), str("null")]])],
                [str("if"), obj([])],
                [str("readOnly"), lit("true")],
                [str("deprecated"), lit("true")],
                [str("$comment"), str("a comment")],
                [str("uniqueItems"), lit("true")],
                [str("multipleOf"), num("2")],
                [str("propertyNames"), obj([[str("pattern"), str("^a")]])],
                [str("contentMediaType"), str("text/plain")],
            ]);
            entries.push(ignored);
        }

        return entries;
    }

    anyValue() {
        const rng = this.rng;
        return rng.pick([num("1"), str("x"), lit("null"), lit("true"), arr([]), obj([])]);
    }

    ref() {
        const rng = this.rng;
        if (this.definitions.length === 0 || rng.chance(0.08)) return str("#");
        const name = rng.pick(this.definitions);
        return str(`#/${this.defsKey}/${name.replace(/~/g, "~0").replace(/\//g, "~1")}`);
    }

    typeOf(kind) {
        const rng = this.rng;
        if (rng.chance(0.08)) return [str("type"), arr(rng.shuffle([str(kind), str("null")]))];
        return [str("type"), str(kind)];
    }

    schema(depth, only) {
        const rng = this.rng;
        const leaf = depth <= 0;
        const kind = only ?? rng.weighted([
            [5, "string"],
            [3, "number"],
            [1.5, "boolean"],
            [0.5, "null"],
            [leaf ? 0.5 : 6, "object"],
            [leaf ? 0.3 : 3, "array"],
            [leaf ? 0 : 2.5, "union"],
            [leaf ? 0 : 1.5, "allOf"],
            [2, "enum"],
            [1, "const"],
            [this.definitions.length > 0 ? 4 : 0.5, "ref"],
            [0.7, "any"],
            [0.2, "boolschema"],
            [leaf ? 0 : 0.7, "multi"],
        ]);
        const e = [];
        switch (kind) {
            case "string":
                e.push(this.typeOf("string"));
                if (rng.chance(0.4)) e.push([str("format"), str(rng.pick(SCHEMA_FORMATS))]);
                if (rng.chance(0.1)) e.push([str("pattern"), str(rng.chance(0.7) ? rng.pick(PATTERNS) : oddPattern(rng))]);
                if (rng.chance(0.1)) e.push([str("minLength"), num(rng.chance(0.8) ? rng.range(0, 5) : genIntLiteral(rng))]);
                if (rng.chance(0.1)) e.push([str("maxLength"), num(rng.chance(0.8) ? rng.range(5, 300) : genNumberLiteral(rng))]);
                break;
            case "number":
                e.push(this.typeOf(rng.pick(["number", "integer"])));
                if (rng.chance(0.15)) e.push([str("minimum"), num(rng.chance(0.6) ? rng.pick(["0", "-1", "1.5", "-2147483648", "1e3"]) : genNumberLiteral(rng))]);
                if (rng.chance(0.15)) e.push([str("maximum"), num(rng.chance(0.6) ? rng.pick(["100", "2147483647", "9007199254740991", "0.5", "1e20"]) : genNumberLiteral(rng))]);
                if (rng.chance(0.05)) e.push([str("exclusiveMinimum"), num("0")]);
                if (rng.chance(0.05)) e.push([str("format"), str(rng.pick(["int32", "int64", "double", "float"]))]);
                break;
            case "boolean":
            case "null":
                e.push(this.typeOf(kind));
                break;
            case "object": {
                if (rng.chance(0.9)) e.push(this.typeOf("object"));
                const n = rng.weighted([[1, 0], [6, rng.range(1, 5)], [2, rng.range(5, 12)]]);
                const props = [];
                const used = new Set();
                for (let i = 0; i < n; i++) {
                    const key = genKey(rng);
                    if (used.has(key)) continue;
                    used.add(key);
                    props.push([str(key), this.schema(depth - 1)]);
                }

                if (rng.chance(0.04) && props.length > 0) {
                    // Draft 3: `required: true` on the property itself.
                    const [, p] = rng.pick(props);
                    if (p.t === "o") p.e.push([str("required"), lit(rng.chance(0.8) ? "true" : "false")]);
                }

                if (rng.chance(0.03) && props.length > 0) {
                    e.push([str("qt-accessors"), obj(props.filter(() => rng.chance(0.5)).map(([k]) => [k, str(genKey(rng))]))]);
                }

                if (rng.chance(0.95)) e.push([str("properties"), obj(props)]);
                if (rng.chance(0.6)) {
                    const required = props.filter(() => rng.chance(0.6)).map(([k]) => k);
                    if (rng.chance(0.05)) required.push(str(genKey(rng)));
                    e.push([str("required"), arr(required)]);
                }

                const ap = rng.weighted([[5, undefined], [2, "false"], [1, "true"], [2, "schema"]]);
                if (ap === "schema") e.push([str("additionalProperties"), this.schema(depth - 1)]);
                else if (ap !== undefined) e.push([str("additionalProperties"), lit(ap)]);
                if (rng.chance(0.03)) e.push([str("patternProperties"), obj([[str(".*"), this.schema(depth - 1)]])]);
                if (rng.chance(0.02)) e.push([str("quicktypePropertyOrder"), arr(rng.shuffle(props.map(([k]) => k)))]);
                break;
            }
            case "array":
                if (rng.chance(0.9)) e.push(this.typeOf("array"));
                if (rng.chance(0.12)) {
                    const n = rng.range(1, 3);
                    const items = [];
                    for (let i = 0; i < n; i++) items.push(this.schema(depth - 1));
                    e.push([str(rng.chance(0.5) ? "items" : "prefixItems"), arr(items)]);
                } else if (rng.chance(0.95)) {
                    e.push([str("items"), this.schema(depth - 1)]);
                }

                if (rng.chance(0.1)) e.push([str("minItems"), num(rng.range(0, 3))]);
                if (rng.chance(0.1)) e.push([str("maxItems"), num(rng.range(3, 10))]);
                break;
            case "union":
            case "allOf": {
                const key = kind === "allOf" ? "allOf" : rng.pick(["anyOf", "oneOf"]);
                const n = rng.weighted([[1, 1], [5, 2], [2, 3], [1, 4]]);
                const cases = [];
                for (let i = 0; i < n; i++) {
                    // allOf of unrelated kinds is mostly an impossible type.
                    const only = kind === "allOf" && rng.chance(0.85) ? (this.definitions.length > 0 && rng.chance(0.4) ? "ref" : "object") : undefined;
                    cases.push(this.schema(depth - 1, only));
                }

                if (rng.chance(0.05)) e.push(this.typeOf(rng.pick(["object", "string", "number"])));
                e.push([str(key), arr(cases)]);
                if (key !== "allOf" && rng.chance(0.03)) e.push([str("qt-accessors"), arr(cases.map(() => str(genKey(rng))))]);
                if (rng.chance(0.1)) e.push([str(key === "anyOf" ? "oneOf" : "anyOf"), arr([this.schema(depth - 1), this.schema(depth - 1)])]);
                break;
            }
            case "enum": {
                const valueKind = rng.weighted([[6, "string"], [1, "number"], [1, "mixed"]]);
                if (valueKind !== "mixed" && rng.chance(0.6)) e.push(this.typeOf(valueKind === "string" ? "string" : "number"));
                const n = rng.weighted([[1, 1], [5, rng.range(2, 5)], [2, rng.range(5, 15)]]);
                const values = [];
                for (let i = 0; i < n; i++) values.push(schemaEnumValue(rng, valueKind));
                e.push([str("enum"), arr(rng.chance(0.02) ? [] : values)]);
                if (rng.chance(0.03)) e.push([str("qt-enum-values"), obj(values.filter((v) => v.t === "s").map((v) => [v, str(genKey(rng))]))]);
                break;
            }
            case "const": {
                const valueKind = rng.pick(["string", "string", "number", "mixed"]);
                const value = schemaEnumValue(rng, valueKind);
                if (rng.chance(0.4)) {
                    const type = value.t === "s" ? "string" : value.t === "n" ? (/[.eE]/.test(value.raw) ? "number" : "integer") : value.raw === "null" ? "null" : "boolean";
                    e.push(this.typeOf(rng.chance(0.9) ? type : rng.pick(["string", "number", "integer", "boolean"])));
                }

                e.push([str("const"), value]);
                break;
            }
            case "ref":
                e.push([str("$ref"), this.ref()]);
                if (rng.chance(0.1)) e.push([str("type"), str("object")]);
                break;
            case "any":
                break;
            case "boolschema":
                return lit(rng.chance(0.85) ? "true" : "false");
            case "multi":
                e.push([str("type"), arr(rng.sample(["string", "number", "integer", "boolean", "null", "object", "array"], rng.range(2, 4)).map((t) => str(t)))]);
                if (rng.chance(0.5)) e.push([str("properties"), obj([[str(genKey(rng)), this.schema(depth - 1)]])]);
                if (rng.chance(0.5)) e.push([str("items"), this.schema(depth - 1)]);
                break;
            default:
                throw new Error(kind);
        }

        return obj(rng.chance(0.1) ? rng.shuffle(this.decorate(e, depth)) : this.decorate(e, depth));
    }

    root() {
        const rng = this.rng;
        const nDefs = rng.weighted([[4, 0], [4, rng.range(1, 3)], [2, rng.range(3, 7)]]);
        for (let i = 0; i < nDefs; i++) {
            let name = rng.chance(0.7) ? capitalize(compoundName(rng)) : genKey(rng);
            if (this.definitions.includes(name)) name = `${name}${i}`;
            this.definitions.push(name);
        }

        const depth = rng.range(1, 4);
        const defs = this.definitions.map((name) => [str(name), this.schema(rng.range(0, 3))]);
        let root = this.schema(depth);
        if (root.t !== "o" || rng.chance(0.6)) {
            // Most schemas describe an object at the top.
            const g = this.schema.bind(this);
            const props = [];
            const n = rng.range(1, 6);
            for (let i = 0; i < n; i++) props.push([str(genKey(rng)), g(depth - 1)]);
            root = obj([[str("type"), str("object")], [str("properties"), obj(props)]]);
            if (rng.chance(0.5)) root.e.push([str("required"), arr(props.filter(() => rng.chance(0.5)).map(([k]) => k))]);
            if (rng.chance(0.3)) root.e.push([str("additionalProperties"), lit("false")]);
            if (rng.chance(0.08) && props.length > 0) {
                // A reference into the schema's own properties.
                const [target] = rng.pick(props);
                const pointer = JSON.parse(`"${target.raw}"`).replace(/~/g, "~0").replace(/\//g, "~1");
                props.push([str(`${genKey(rng)}Ref`), obj([[str("$ref"), str(`#/properties/${encodeURIComponent(pointer)}`)]])]);
            }

            this.decorate(root.e, depth);
        }

        if (rng.chance(0.15)) root.e.unshift([str("$schema"), str(rng.pick(["http://json-schema.org/draft-07/schema#", "https://json-schema.org/draft/2020-12/schema"]))]);
        if (defs.length > 0) root.e.push([str(this.defsKey), obj(defs)]);
        if (rng.chance(0.1) && defs.length > 0) {
            // The whole schema as a reference to one definition.
            root = obj([[str("$ref"), this.ref()], [str(this.defsKey), obj(defs)]]);
        }

        return root;
    }
}

function genSchemas(rng) {
    const name = rng.weighted([[6, "TopLevel"], [3, capitalize(compoundName(rng))], [1, genKey(rng)]]);
    const gen = new SchemaGen(rng);
    const tree = gen.root();
    const text = toText(tree, rng.weighted([[3, "  "], [1, undefined], [1, "    "]]));
    const schemas = [{ name, text }];
    if (gen.definitions.length > 0 && rng.chance(0.12)) {
        // More top-levels from the same document, by URI fragment (API runs only).
        for (const def of rng.sample(gen.definitions, rng.range(1, 2))) {
            const pointer = encodeURIComponent(def.replace(/~/g, "~0").replace(/\//g, "~1"));
            schemas.push({
                name: rng.chance(0.7) ? def : rng.pick([name, "TopLevel", genKey(rng)]),
                text,
                uris: [`#/${gen.defsKey}/${pointer}`],
            });
        }
    }

    return schemas;
}

// ---- Options -----------------------------------------------------------------

const STRING_OPTION_VALUES = ["", "Foo", "foo", "my.package", "my-package", "a.b.c", "123", "class", "ñ",
    "a b", "QT", "Foo_Bar", " x ", "default", "Main", "x", "io.example.app", "Some::Mod", "1abc", "_"];

function genRendererOptions(rng, definitions) {
    const options = {};
    const p = rng.weighted([[2, 0], [5, 0.15], [3, 0.35], [1, 0.7]]);
    for (const d of definitions) {
        if (!rng.chance(p)) continue;
        switch (d.optionType) {
            case "boolean":
                options[d.name] = true;
                break;
            case "enum":
                options[d.name] = rng.chance(0.03) ? rng.pick(["bogus", "", "Default"]) : rng.pick(d.legalValues);
                break;
            default:
                if (d.name === "hashtable-size") options[d.name] = rng.pick(["1", "64", "1000", "0", "x", "-3"]);
                else if (d.name === "coding-keys-protocol") options[d.name] = rng.pick(["Foo", "Foo, Bar", ""]);
                else options[d.name] = rng.chance(0.7) ? rng.pick(STRING_OPTION_VALUES) : compoundName(rng);
        }
    }

    return options;
}

/** Inference flags (CLI `--no-*`), as quicktype options. */
export const INFERENCE_FLAGS = [
    ["inferMaps", "--no-maps"],
    ["inferEnums", "--no-enums"],
    ["inferUuids", "--no-uuids"],
    ["inferDateTimes", "--no-date-times"],
    ["inferIntegerStrings", "--no-integer-strings"],
    ["inferBooleanStrings", "--no-boolean-strings"],
    ["combineClasses", "--no-combine-classes"],
    ["ignoreJsonRefs", "--no-ignore-json-refs"],
];

function genFlags(rng) {
    const flags = {};
    const p = rng.weighted([[3, 0], [4, 0.12], [2, 0.35]]);
    for (const [name] of INFERENCE_FLAGS) if (rng.chance(p)) flags[name] = false;
    if (rng.chance(0.15)) flags.alphabetizeProperties = true;
    if (rng.chance(0.15)) flags.allPropertiesOptional = true;
    return flags;
}

function genLeadingComments(rng) {
    return rng.weighted([
        [3, () => [rng.pick(DESCRIPTIONS)]],
        [2, () => ["first", "second line", ""]],
        [1, () => []],
        [1, () => [{ lines: ["structured", "comment"] }]],
        [1, () => [{ customLines: ["custom"], lineStart: "// ", beforeComment: "/*", afterComment: "*/" }]],
    ])();
}

/**
 * The case for `seed`. `optionDefinitions` maps each language to its CLI
 * renderer option definitions ({ name, optionType, legalValues }).
 */
export function generateCase(seed, optionDefinitions, { languages = LANGUAGES, src } = {}) {
    const rng = new Rng(seed);
    const lang = rng.pick(languages);
    const kind = src ?? rng.weighted([[57, "json"], [38, "schema"], [5, "graphql"]]);
    const kase = { seed, lang, src: kind };
    const inputRng = rng.fork();
    if (kind === "json") kase.topLevels = genJsonTopLevels(inputRng, lang);
    else if (kind === "schema") kase.schemas = genSchemas(inputRng);
    else kase.graphql = { name: inputRng.chance(0.6) ? "TopLevel" : capitalize(compoundName(inputRng)), ...genGraphQL(inputRng, genKey, DESCRIPTIONS) };
    const optionRng = rng.fork();
    kase.rendererOptions = genRendererOptions(optionRng, optionDefinitions[lang] ?? []);
    kase.flags = genFlags(optionRng);
    const extraRng = rng.fork();
    kase.api = {};
    if (extraRng.chance(0.1)) kase.api.indentation = extraRng.pick(["\t", " ", "    ", "", "   "]);
    if (extraRng.chance(0.08)) kase.api.leadingComments = genLeadingComments(extraRng);
    if (extraRng.chance(0.15)) kase.api.outputFilename = extraRng.pick(["Foo.x", "out.ts", "my-file.go", "Model.java", "a.b.c", "x", "Top Level.swift"]);
    kase.debug = [];
    if (extraRng.chance(0.06)) {
        const components = ["print-graph", "print-reconstitution", "print-gather-names", "print-transformations", "provenance"];
        if (kind === "schema") components.push("print-schema-resolving");
        kase.debug = extraRng.sample(components, extraRng.range(1, 2));
    }

    kase.cli = {};
    if (extraRng.chance(0.3)) kase.cli.out = extraRng.pick(["out/Output", "out/model", "out/My-Types", "out/x.y"]);
    if (extraRng.chance(0.2)) kase.cli.quiet = true;
    if (kind === "schema" && extraRng.chance(0.15)) {
        kase.cli.schemaFile = extraRng.pick(["schema", "Ünïcödé", "日本.schema", "x.y.z", "😀.json", "a b.json", "Top-Level", ".json", "ñ.ñ"]);
    }
    return kase;
}
