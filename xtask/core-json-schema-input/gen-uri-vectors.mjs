#!/usr/bin/env node
// Records differential test vectors for the urijs 1.19.11 port
// (crates/quicktype-js-compat/src/uri.rs) and for `Number(string)`
// (number::string_to_number).
//
// usage: node xtask/core-json-schema-input/gen-uri-vectors.mjs <path/to/quicktype>
//
// The reference checkout must have its node_modules installed; urijs is
// loaded exactly as quicktype-core resolves it. Inputs are curated edge
// cases, every `$ref`/`$id` string and every URL-like JSON string in
// tests/inputs, and pseudo-random URI-shaped strings from a fixed seed, so
// re-running the script reproduces the same file.
//
// Output: crates/quicktype-js-compat/tests/vectors/uri.json, replayed by
// crates/quicktype-js-compat/tests/uri_vectors.rs.

import { readdirSync, readFileSync, writeFileSync, statSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktypeDir = resolve(process.argv[2] ?? process.env.QUICKTYPE_DIR ?? join(repoRoot, "..", "quicktype"));
const coreDist = join(quicktypeDir, "packages/quicktype-core/dist");
const coreRequire = createRequire(join(coreDist, "index.js"));
const URI = coreRequire("urijs");
if (URI.version !== "1.19.11") throw new Error(`expected urijs 1.19.11, found ${URI.version}`);

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

function attempt(f) {
    try {
        return { ok: f() };
    } catch (e) {
        return { err: `${e.name}: ${e.message}` };
    }
}

const curated = [
    "", "#", "#/", "#/definitions/Foo", "#item", "?q", "?", "??x", "a??b", "/", "//", "///x", "\\\\x\\y",
    "a/test2.json", "../b/test3.json#/foo", "test.json", "./a/../b/c.json", "../../../c.json", "..", ".", "a/..",
    "a/.", "/..", "/../a", "a/b/../../..", "x/./././y", "x//y///z",
    "HTTP://Example.COM:80/a/./b/../c.json", "http://example.com", "https://h:443/p", "ftp://h:21",
    "ws://h:80", "wss://h:443/", "gopher://h:70", "http://x:99999/", "http://x:0/", "http://x:65535/",
    "http://x:080/", "http://x: 80/", "http://x:8e1/", "http://x:0x50/", "http://x:1.0/", "http://x:abc/",
    "http://[::1", "http://[::1]:8080/a", "http://[2001:DB8:0:0:0:0:0:1]/", "http://[::ffff:1.2.3.4]/",
    "http://[fe80::1%25eth0]/", "http://1.2.3.4/", "http://a:b:c/", "http://u:p@h/x", "http://u@h", "http://@h/",
    "http://u:p:q@h/", "http://a@b@c/d", "http://%zz@h/", "http://u:%zz@h/", "http:\\\\x\\a\\b.jpg",
    "http://x/a\\b.jpg", "http:x/y", "http:/x/y", "http:::///x", ":x", "::x", "://x", "HTTPS:x", "mailto:a@b",
    "urn:isbn:0451450523", "urn:a:%7Ex", "1a:b", "a1:b", "c:/x/y.json", "C:\\x\\y.json", "file:///C:/x/y.json",
    "file://server/share/x.json", "file:///tmp/a.json", "  \t http://h/a\tb\nc\r.json", "\ufeffx.json",
    "\u00a0y.json", "My Type", "My%20Type", "100%.schema", "100%25.schema", "a%zz.json", "%", "%2", "%C3%A9.json",
    "é.json", "%2F", "a%2Fb", "a%3Fb%23c", "a$b&c+d,e;f=g:h@i", "a!b'c(d)e*f", "~tilde", "a b?c d#e f",
    "http://bücher.example/", "http://BÜCHER.example/", "http://a\u3002b/", "http://例子.测试/x", "http://a_b.c/",
    "http://a~b/", "http://-x/", "http://a b/", "http://x?q=a.png", "http://x/a;p=1/b.json",
    "http://h/x?b=2&a=1", "http://h/x?a=1&b=2", "http://h/x?a&a&a=1", "http://h/x?2=b&1=a&x=y", "http://h/x?__proto__=1&a",
    "http://h/x?a+b=c%20d", "http://h/x?&&a=1&&", "http://h/x?%zz=1", "x.json?y#z", "x.tar.gz", "/.htaccess",
    "/b.JSON", "x.json/", "dir/", "dir/sub/t.json", "a/b.c/d", "a.b%c", "a.b-c", "a.ſ", "x#a/b/", "x#/a/b/",
    "#/definitions/", "e1.schema#definitions/Nope", "ref-remote.schema",
    "https://raw.githubusercontent.com/glideapps/quicktype/master/test/inputs/schema/simple-ref.1.ref",
    "http://example.net/root.json", "http://foo/root.json#item",
];

const fromInputs = new Set();
function walkInputs(dir) {
    for (const name of readdirSync(dir)) {
        const p = join(dir, name);
        if (statSync(p).isDirectory()) {
            walkInputs(p);
        } else if (/\.(schema|json|ref)$/.test(name)) {
            const text = readFileSync(p, "utf8");
            for (const m of text.matchAll(/"\$(?:ref|id)"\s*:\s*("(?:[^"\\]|\\.)*")/g)) {
                fromInputs.add(JSON.parse(m[1]));
            }
            for (const m of text.matchAll(/"((?:https?|ftp):\/\/[^"\\{}]*)"/g)) {
                fromInputs.add(m[1]);
            }
        }
    }
}
walkInputs(join(repoRoot, "tests/inputs"));

const random = rng(20261113);
const pieces = [
    "http", "https", "ftp", "urn", "file", "HTTP", ":", "//", "/", "\\", "?", "#", "@", ".", "..", "%", "%2", "%41",
    "%zz", "%C3%A9", "%2F", "a", "b", "x", "Z", "0", "1", "8080", "99999", "[", "]", "::1", "é", "中", "😀",
    " ", "\t", "\n", "&", "=", "+", "-", "_", "~", "!", "*", "(", ")", ";", ",", "$", "json", "schema",
];
const fuzz = [];
for (let i = 0; i < 2500; i++) {
    const n = 1 + Math.floor(random() * 9);
    let s = "";
    for (let j = 0; j < n; j++) s += pieces[Math.floor(random() * pieces.length)];
    fuzz.push(s);
}

// Every $ref/$id, but only a deterministic sample of the URL strings.
const sortedInputs = [...fromInputs].sort();
const sample = sortedInputs.filter((s, i) => !/^(https?|ftp):/.test(s) || i % 16 === 0);
const inputs = [...new Set([...curated, ...sample, ...fuzz.slice(0, 700)])];
const bases = ["", "test.json", "dir/sub/t.json", "/abs/x.json", "http://h", "http://ex.com/a/b/c.json", "urn:x:y", "a?q=1"];

function describe(u) {
    return {
        s: u.toString(),
        protocol: u.protocol(),
        host: u.host(),
        path: u.path(),
        query: u.query(),
        fragment: u.fragment(),
        hash: u.hash(),
        filename: u.filename(),
        suffix: u.suffix(),
        directory: u.directory(),
    };
}

const uris = [];
for (const input of inputs) {
    const parsed = attempt(() => new URI(input));
    const entry = { input };
    if (parsed.err !== undefined) {
        entry.parse = { err: parsed.err };
        uris.push(entry);
        continue;
    }
    const u = parsed.ok;
    entry.parse = { ok: describe(u) };
    entry.clone = u.clone().toString();
    entry.normalize = attempt(() => u.clone().normalize().toString());
    entry.decodeNormalized = attempt(() => URI.decode(u.clone().normalize().toString()));
    entry.absoluteTo = bases.map((b) => attempt(() => u.absoluteTo(new URI(b)).toString()));
    entry.setPath = attempt(() => u.clone().path("My Type-1").toString());
    entry.setFragment = u.clone().fragment("#/x").hash("").toString();
    entry.setQuery = u.clone().query("?a=b").toString();
    uris.push(entry);
}

// equals over pairs of the curated inputs (and their normalized forms).
const equalsCases = [];
const eqInputs = curated.filter((s) => attempt(() => new URI(s)).ok !== undefined);
for (let i = 0; i < eqInputs.length; i++) {
    for (const j of [i, (i * 7 + 3) % eqInputs.length, (i + 1) % eqInputs.length]) {
        const a = eqInputs[i];
        const b = eqInputs[j];
        equalsCases.push({ a, b, result: attempt(() => new URI(a).equals(new URI(b))) });
    }
}
equalsCases.push({ a: "http://h/x?a=1&b=2", b: "HTTP://h:80/x?b=2&a=1", result: attempt(() => new URI("http://h/x?a=1&b=2").equals(new URI("HTTP://h:80/x?b=2&a=1"))) });
equalsCases.push({ a: "http://h/x?a=1&a=2", b: "http://h/x?a=2&a=1", result: attempt(() => new URI("http://h/x?a=1&a=2").equals(new URI("http://h/x?a=2&a=1"))) });
equalsCases.push({ a: "http://h/x?a=1&a=2", b: "http://h/x?a=1&b=2", result: attempt(() => new URI("http://h/x?a=1&a=2").equals(new URI("http://h/x?a=1&b=2"))) });

const componentInputs = [
    "", "a b", "é", "😀", "!'()*~-_.", "%", "%zz", "%41%42", "%C3%A9", "%c3%a9", "%ED%A0%80", "%C0%80", "%F4%90%80%80",
    "%E2%82", "%E2%82%AC", "%F0%9F%98%80", "a%2Fb", "%FF", "%80", "+", "%2B", ...fuzz.slice(0, 300),
];
const components = componentInputs.map((s) => ({
    input: s,
    encode: encodeURIComponent(s),
    strictEncode: URI.encode(s),
    decode: attempt(() => decodeURIComponent(s)),
    recodePath: attempt(() => URI.recodePath(s)),
    decodePathSegment: URI.decodePathSegment(s),
}));

const numberInputs = [
    "", " ", "0", "-0", "+1", "1.", ".5", ".", "1e3", "1E+3", "1e", "e3", "0x1F", "0X1f", "-0x10", "0o17", "0b101",
    "0x", "Infinity", "-Infinity", "+Infinity", "infinity", "inf", "NaN", "1_000", " 80 ", "\u00a080\ufeff", "08",
    "1.5e-7", "123456789012345678901234567890", "0x123456789abcdef0123", "0b" + "1".repeat(70), "1e400", "12abc",
    "\n42\n", "0.0000001", "65535", "65536", "99999",
];
const numbers = numberInputs.map((s) => ({ input: s, value: Number(s).toString() }));

// Rust strings cannot hold lone surrogates (a known gap): drop the few
// fuzz cases where urijs cuts a surrogate pair in half.
const wellFormed = (x) => !/\\ud[89a-f][0-9a-f]{2}/i.test(JSON.stringify(x));
const dropped = uris.length - uris.filter(wellFormed).length;
uris.splice(0, uris.length, ...uris.filter(wellFormed));
const out = join(repoRoot, "crates/quicktype-js-compat/tests/vectors/uri.json");
writeFileSync(out, `${JSON.stringify({ uris, equals: equalsCases, components, numbers, bases })}\n`);
console.log(`dropped ${dropped} with lone surrogates; wrote ${uris.length} URIs, ${equalsCases.length} equals cases, ${components.length} components to ${out}`);
