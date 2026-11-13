// Edge cases for gen-fixtures.mjs. Each case is one run of a JSON input:
//
//   id              unique name
//   sources         [{name, samples: [text], description?}], added in order
//   flags           inference flag overrides (e.g. {inferMaps: false,
//                   ignoreJsonRefs: false})
//   rendererOptions passed to getSupportedIntegerRange
//   fixedTopLevels  InputData.addTypes' fixedTopLevels
//   configs         only these configurations (default: all)
//
// Sample texts must be well-formed UTF-16 and must not produce lone
// surrogates (docs/PARITY.md, "Lone surrogates").

const one = (id, text, extra = {}) => ({ id, sources: [{ name: "TopLevel", samples: [text] }], ...extra });

const numbers = [
    "0", "1", "-0", "-0.0", "1.0", "1E2", "1e2", "1e-2", "1.5", "2147483648", "9007199254740991",
    "9007199254740992", "9007199254740993", "9223372036854774784", "9223372036854775807",
    "9223372036854775808", "-9223372036854775808", "-9223372036854775809", "1e20", "1e21", "1E400",
    "-1E400", "123456789012345678901234567890", "0.0e0", "1e0",
];
// Each number in its own single-property class, so the print shows how
// every one of them is classified.
const numberObject = `{${numbers
    .map((n, i) => {
        const key = `n${String(i).padStart(2, "0")}`;
        return `"${key}": {"${key}": ${n}}`;
    })
    .join(", ")}}`;

const strings = [
    "-0", "007", "0", "2147483647", "2147483648", "-2147483648", "-2147483649", "True", "true", "false",
    "123e4567-e89b-12d3-a456-426614174000", "123E4567-E89B-12D3-A456-426614174000", "HTTP://x",
    "http://x", "https://a/{b}", "http://x\n", "ftp://h/p.TXT", "2021-02-29", "2020-02-30", "0000-01-01",
    "2020-01-01T23:59:60Z", "2020-01-01t10:00:00z", "2020-01-01T10:00:00+0100", "10:00:00+01:00",
    "10:00:00.120Z", "10:00:00.12Z", "10:00:00+00:00", "2018-08-14T02:45:50+18:01", "2018-8-1T2:45:50+1",
    "2015-02-29", "2016-02-29T00:00:00Z", "", "a", "abc", "😀", "é".repeat(64), "é".repeat(65),
    `${"a".repeat(62)}😀`, `${"a".repeat(63)}😀`, "x".repeat(200),
];
const stringObject = `{${strings.map((s, i) => `"s${String(i).padStart(2, "0")}": ${JSON.stringify(s)}`).join(", ")}}`;

function manyKeys(n, valueFor = (i) => i) {
    return `{${Array.from({ length: n }, (_, i) => `"key${i}": ${JSON.stringify(valueFor(i))}`).join(",")}}`;
}

function nested(depth, open, close, leaf) {
    return open.repeat(depth) + leaf + close.repeat(depth);
}

const invalid = [
    "", " ", "[", "{", "{\"a\":", "{\"a\"", "\ufeff{}", "NaN", "tru}", "truex", "'x'", "{\"a\":1} {\"b\":2}",
    "{\"a\":1,}", "[1,]", "[1,2", "{\"a\":01}", "[1 2]", "[1}", "{\"a\":1]", "{1:2}", "{\"a\" 1}",
    "\"a\u0001\"", "\"\\x\"", "\"abc", "\"ab\\", "-x", "-", "1.x", "1.", "1e+x", "1e", "1e+", "01",
    "[\"\\u12\"]", "[1, 2, 3, 4, 5, 6, 7, x]", "x23456789012345678901", "[\n1,\n2\n3]", "\"\\€\"",
];

export const edgeCases = [
    one("numbers", numberObject),
    one("numbers-int8", numberObject, { rendererOptions: { "integer-size": "int8_t" }, configs: ["stream-typescript", "api-typescript"] }),
    one("numbers-top-level-mixed", `[${numbers.join(", ")}]`),
    one("strings", stringObject),
    one("string-enum-cases", '[{"c":"red"},{"c":"green"},{"c":"red"},{"c":"blue"},{"c":"red"}]'),
    one("keys-order", '{"b":1,"2":2,"a":3,"1":4,"01":5,"4294967295":6,"4294967294":7,"-1":8,"1.5":9}'),
    one("duplicate-key-union", '{"a":1,"a":"x"}'),
    one("duplicate-key-optionality", '[{"a":1,"a":2},{"b":1}]'),
    one("duplicate-key-values", '[{"b":1.0,"b":"dup"},{"b":true}]'),
    one("proto-keys", '[{"__proto__":1,"a":2},{"__proto__":"x","a":3}]'),
    one("proto-keys-within-object", '{"__proto__":{"x":1},"y":2,"__proto__":2}'),
    one("object-prototype-keys", '{"constructor":1,"toString":"a","hasOwnProperty":true,"valueOf":null}'),
    one("map-500-keys", manyKeys(500)),
    one("map-501-keys", manyKeys(501)),
    one("map-501-keys-no-maps", manyKeys(501), { flags: { inferMaps: false }, configs: ["stream-typescript", "api-typescript"] }),
    one("map-501-mixed-values", manyKeys(501, (i) => (i % 3 === 0 ? `s${i}` : i % 3 === 1 ? i : { x: i }))),
    one("no-enums", '[{"c":"red"},{"c":"green"},{"c":"red"}]', { flags: { inferEnums: false } }),
    one("no-date-times", '["2020-01-01", "10:00:00Z", "2020-01-01T10:00:00Z"]', { flags: { inferDateTimes: false } }),
    one("no-uuids-integer-boolean-strings", '["123e4567-e89b-12d3-a456-426614174000", "12", "true"]', {
        flags: { inferUuids: false, inferIntegerStrings: false, inferBooleanStrings: false },
    }),
    one("deep-arrays", nested(100, "[", "]", "1")),
    one("deep-objects", nested(100, '{"a":', "}", '"x"')),
    one("deep-mixed", nested(60, '[{"a":', "}]", "null")),
    one("empty-object", "{}"),
    one("empty-array", "[]"),
    one("nested-empties", '[[], {}, [[]], [{}], {"a":[]}, {"a":{}}]'),
    one("null", "null"),
    one("scalars", '[null, true, false, 1, 1.5, "s", "2020-01-01"]'),
    one("everything", '[1, "a", {"x": 1}, [2], null, true, 1.5, [], {}, "http://h/p.png"]'),
    one("classes-dedup", '[{"a":{"b":1}},{"a":{"b":2}},{"c":{"b":3}}]'),
    one("array-of-arrays", '[[1,2],[3.5],["x"],[[null]]]'),
    one("optional-and-null", '[{"a":1,"b":null},{"a":null},{"b":"x","c":[]}]'),
    one("whitespace", ' \t\r\n{ "a" : [ 1 , 2 ] , "b" : { } } \n'),
    one("escapes", '{"k\\u00e9y": "v\\n\\u00e9\\ud83d\\ude00", "\\"quoted\\"": "\\/"}'),
    one("uris", '[{"u":"http://a/b.JSON"},{"u":"https://c/d.png?x#y"},{"u":"ftp://x/y"},{"u":"http://a:99999/x"},{"u":"http://u%zz@a/b.gif"},{"v":"https://h/a.tar.gz"}]'),
    {
        id: "multiple-samples-and-top-levels",
        sources: [
            { name: "First", samples: ['{"a":1}', '{"a":2.5,"b":"x"}'] },
            { name: "Second", samples: ["[1,2]"], description: "the second" },
            { name: "First", samples: ['{"c":true}'], description: "first, described later" },
        ],
    },
    {
        id: "fixed-top-levels",
        sources: [
            { name: "A", samples: ['{"x":{"y":1}}'] },
            { name: "B", samples: ['{"x":{"y":1}}'] },
        ],
        fixedTopLevels: true,
    },
    {
        id: "same-top-levels-not-fixed",
        sources: [
            { name: "A", samples: ['{"x":{"y":1}}'] },
            { name: "B", samples: ['{"x":{"y":1}}'] },
        ],
    },
    {
        id: "empty-samples",
        sources: [{ name: "Empty", samples: [] }],
    },
    {
        id: "second-sample-invalid",
        sources: [{ name: "Broken", samples: ['{"a":1}', "{"], description: "described" }],
    },
    one("refs-ignored", '{"a":{"x":1},"b":{"$ref":"#/a"}}'),
    one("refs", '{"a":{"x":1},"b":{"$ref":"#/a"},"c":[{"$ref":"#/a/x"}],"d":[{"y":"s"}],"e":{"$ref":"#/d/0/y"}}', {
        flags: { ignoreJsonRefs: false },
    }),
    one("refs-map", `{"m":${manyKeys(501)},"r":{"$ref":"#/m/anything"}}`, { flags: { ignoreJsonRefs: false } }),
    one("refs-nullable", '{"a":[{"x":1},null],"b":{"$ref":"#/a/0/x"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-not-rooted", '{"a":1,"b":{"$ref":"a"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-wrong-property", '{"a":{"x":1},"b":{"$ref":"#/a/y"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-invalid-array-index", '{"a":[1],"b":{"$ref":"#/a/x"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-to-union", '{"a":[1,"s",{"x":1}],"b":{"$ref":"#/a/0/x"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-to-primitive", '{"a":1,"b":{"$ref":"#/a/x"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-not-strings", '{"a":{"$ref":1},"b":{"$ref":"#/a"}}', { flags: { ignoreJsonRefs: false } }),
    one("refs-long-string", `{"a":{"$ref":"#/${"x".repeat(80)}"}}`, { flags: { ignoreJsonRefs: false } }),
    ...invalid.map((text, i) => one(`invalid-${String(i).padStart(2, "0")}`, text)),
];

export const recognizerInputs = [
    ...strings,
    "2018-08-14T02:45:50Z", "2018-08-14T02:45:50+01:00", "2018-08-14t02:45:50z", "2015-04-24T01:46:50.342496Z",
    "2010-01-12T00:00:00.000Z", "2013-06-15 21:10:28", "2018-08-14T02:45:50", "0000-00-00T00:00:00Z",
    "2018-13-01T00:00:00Z", "2018-08-14T24:00:00Z", "2018-08-14X02:45:50Z", "2018-02-30", "2018-8-14",
    "02:45:50Z", "02:45:50z", "02:45:50.123+01:00", "23:59:59-11:30", "02:45:50", "24:00:00Z", "02:60:00Z",
    "02:45:60Z", "2018-08-14T02:45:50.5Z", "2018-08-14T02:45:50.123456789Z", "2018-08-14T02:45:50.1234567891Z",
    "2018-08-14T02:45:50-00:00", "2018-08-14T02:45:50+18:00", "2018-08-14T02:45:50-18:00",
    "2018-08-14T02:45:50+19:00", "2018-08-14T02:45:50+05:60", "1900-02-29", "2000-02-29", "23:20:50.52Z",
    "23:20:50.520Z", "2018-08-14T02:45:50+00", "2018-08-14T02:45:50+1111", "2018-08-14T02:45:50+1111:1:33",
    "2018-08-14T02:45:50-00", "2018-00008-1T002:45:3Z", "2018-08-14T02:45:50.Z", "2018-08-14TT02:45:50Z",
    "T", "t", "2020-01-01T", "T10:00:00Z", "２０２０-01-01", "2020-01-01T10:00:00Z ", " 2020-01-01",
    "10:00:00.Z", "10:00:00.5", "1:00:00Z", "10:00:00+1:00", "2020-01-01T10:00:00.000000000Z",
];

export const uriInputs = [
    "http://a/b.JSON", "https://a/x.tar.gz?q=1#f", "ftp://a/.htaccess", "http://a", "http://a/",
    "http://a:99999/x", "http://a:0/x", "http://a:8080/x.png", "http://a:0x50/x", "http://a: 80/x.y",
    "http://a:1e3/x.y", "http://a:80.0/x.y", "http://a:80.5/x.y", "http://a:+80/x.y", "http://a:-80/x.y",
    "http://a:/x.y", "http://u%zz@a/x", "http://u%C3%A9@a/x", "http://u%C3@a/x", "http://u:p%zz@a/x",
    "http://u:%zz@a/x", "http://:p@a/x.q", "http://u@a@b/c.d", "http:///\\a/b.c", "http://\\\\a\\b.c",
    "http://[::1]/a.b", "http://[::1]:8080/a.b", "http://[::1]:99999/a.b", "http://[::1/a.b",
    "http://a:b:c/d.e", "http://a/b/c.D/e", "http://a/b.c.d", "http://a/.", "http://a/b.", "http://a/b\\c.d",
    "http://a\n/b.png", "http://a/b.p\tng", "https://a?b.png", "https://a#b.png", "http://é/ü.ÄÖ",
    "http://a/b.ﬀ", "http://a/b%20c.png", "http://a/b?c=d.png", "http://a:65535/b.c", "http://a:65536/b.c",
    "ftp://user:pass@host:21/file.txt", "http://a/b\u2028c.d", "http://a/b.c\u2028",
];

// Postman collections for sourcesFromPostmanCollection. Only JSON texts:
// the YAML fallback of parseJSON is not ported yet (TODO(parse-json)).
const request = (name, extra = {}) => ({ name, response: [{ body: '{"a":1}' }], ...extra });
export const postmanInputs = [
    "null", "1", '"x"', "[]", "[1, {}]", "{}", '{"item": 1}', '{"item": []}', '{"item": [null]}',
    '{"item": [1, "x", [], {}]}', "﻿{}",
    JSON.stringify(request("plain")),
    JSON.stringify(request("invalid bodies", { response: [{ body: "nope" }, { body: 1 }, {}, [], 2, { body: "[1]" }] })),
    JSON.stringify(request("no valid bodies", { response: [{ body: "{" }] })),
    JSON.stringify({ name: "null response", response: [null] }),
    JSON.stringify({ name: 5, response: [{ body: "1" }] }),
    JSON.stringify({ name: "no array", response: { body: "1" } }),
    JSON.stringify(request("get", { request: { method: "GET", url: { raw: "http://h/p?q" }, description: "desc" } })),
    JSON.stringify(request("url string", { request: { method: "POST", url: "http://h" } })),
    JSON.stringify(request("url null", { request: { method: "POST", url: null } })),
    JSON.stringify(request("url null no method", { request: { url: null } })),
    JSON.stringify(request("url array", { request: { method: "GET", url: ["raw"] } })),
    JSON.stringify(request("raw types", { request: { method: 1.5e21, url: { raw: [1, null, [2, [3]], { x: 1 }, true] } } })),
    JSON.stringify(request("method null", { request: { method: null, url: { raw: null } } })),
    JSON.stringify(request("request array", { request: ["GET"] })),
    JSON.stringify(request("request falsy", { request: "" })),
    JSON.stringify(request("description not string", { request: { description: 5 } })),
    JSON.stringify({
        info: { description: "  top  \n" },
        item: [
            { info: { description: "folder" }, item: [request("a"), request("b", { response: [{ body: "2" }, { body: "true" }] })] },
            request("a", { request: { description: "later a" } }),
            { item: [], info: { description: 7 } },
            { item: [request("c")], info: ["description"] },
            { item: [request("d")], info: { description: "" } },
        ],
        name: "the collection",
        response: [{ body: "{}" }],
    }),
    JSON.stringify({ info: { description: " ﻿ " }, item: [request("x")] }),
    JSON.stringify({ item: [{ item: [{ item: [request("deep")] }], info: { description: "mid" } }], info: { description: "root" } }),
];
