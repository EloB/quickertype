#!/usr/bin/env node
// Runs the reference CLI with --graphql-introspect against a local server
// with scripted responses and records what it does, for
// crates/quicktype-cli/tests/graphql_introspect.rs to replay against the
// Rust CLI (with an equivalent server) without Node.
//
// usage: node xtask/graphql-input/record-introspection.mjs <path/to/quicktype>
//
// Each case runs `node dist/index.js <args>` in a fresh directory (holding
// the case's `files`), with `{URL}` in the arguments standing for the
// server's address. Recorded: the exit code, stdout, stderr, the files the
// run wrote, and the requests the server received (method, path, the
// headers listed in `HEADERS` and the body, `<introspection query>` when it
// is exactly JSON.stringify({query: getIntrospectionQuery()})). The server's
// address in the output is written as `{URL}` again.
//
// Output: crates/quicktype-cli/tests/fixtures/graphql-introspect.json

import { spawn } from "node:child_process";
import { mkdirSync, mkdtempSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import http from "node:http";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktypeDir = resolve(process.argv[2] ?? process.env.QUICKTYPE_DIR ?? join(repoRoot, "..", "quicktype"));
const require = createRequire(join(quicktypeDir, "packages/quicktype-graphql-input/dist/index.js"));
const { getIntrospectionQuery } = require("graphql");
const cli = join(quicktypeDir, "dist/index.js");

const HEADERS = ["accept", "content-type", "content-length", "authorization", "x-custom", "1"];
const introspectionBody = JSON.stringify({ query: getIntrospectionQuery() });

const schema = readFileSync(join(repoRoot, "crates/quicktype-graphql-input/tests/fixtures/graphql-input/schemas/basic.gqlschema"), "utf8");
const json = { "content-type": "application/json" };
// The server's routes: status, headers and body (a string).
const routes = {
    "/schema": { status: 200, headers: json, body: schema },
    "/compact": { status: 200, headers: json, body: JSON.stringify(JSON.parse(schema)) },
    "/bom": { status: 200, headers: json, body: `﻿{"data": {"2": 2, "b": [1.0, 1e400, -0], "a": "\\u00e9"}}` },
    "/errors": { status: 200, headers: json, body: '{"errors": [{"message": "nope", "locations": [{"line": 1}]}], "data": {"x": 1}}' },
    "/empty-errors": { status: 200, headers: json, body: '{"errors": [], "data": {"x": 1}}' },
    "/no-data": { status: 200, headers: json, body: '{"data": null, "extensions": {"cost": 1}}' },
    "/zero-data": { status: 200, headers: json, body: '{"data": 0}' },
    "/null": { status: 200, headers: json, body: "null" },
    "/array": { status: 200, headers: json, body: "[1, 2]" },
    "/string": { status: 200, headers: json, body: '"x"' },
    "/html": { status: 500, headers: { "content-type": "text/html" }, body: "<html>oops</html>" },
    "/truncated": { status: 200, headers: json, body: '{"data": {' },
    "/no-content": { status: 204, headers: {}, body: "" },
    "/redirect": { status: 301, headers: { location: "/schema" }, body: "" },
    "/redirect-307": { status: 307, headers: { location: "/schema" }, body: "" },
};

const query = (q) => ({ "query.graphql": q });
const cases = [
    { id: "print-schema", args: ["--graphql-introspect", "{URL}/schema"] },
    { id: "print-schema-src-lang", args: ["--src-lang", "graphql", "--graphql-introspect", "{URL}/compact"] },
    { id: "write-schema", args: ["--graphql-introspect", "{URL}/schema", "--graphql-schema", "out.gqlschema"] },
    {
        id: "write-schema-and-generate",
        args: ["--graphql-introspect", "{URL}/schema", "--graphql-schema", "out.gqlschema", "--lang", "typescript", "query.graphql"],
        files: query("{ viewer { name age colors } }"),
    },
    {
        id: "generate",
        args: ["--graphql-introspect", "{URL}/schema", "--lang", "typescript", "--just-types", "query.graphql"],
        files: query("query Q { viewer { name friends { age } } pet { ... on Dog { barks } } }"),
    },
    {
        id: "generate-two-queries",
        args: ["--graphql-introspect", "{URL}/schema", "--lang", "typescript", "--just-types", "a.graphql", "b.graphql"],
        files: { "a.graphql": "{ count }", "b.graphql": "query B { hello }" },
    },
    {
        id: "two-queries-with-schema-file",
        args: ["--graphql-introspect", "{URL}/schema", "--graphql-schema", "out.gqlschema", "a.graphql", "b.graphql"],
        files: { "a.graphql": "{ count }", "b.graphql": "{ hello }" },
    },
    { id: "headers", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "Authorization: Bearer t0k", "--http-header", "X-Custom:   spaced value "] },
    { id: "header-combined", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "accept: text/plain", "--http-header", "Accept: application/graphql-response+json"] },
    { id: "header-numeric-name", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "X-Custom: a", "--http-header", "1: one"] },
    { id: "header-proto", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "__proto__: x"] },
    { id: "header-no-colon", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "nocolon"] },
    { id: "header-bad-name", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "Bad Name: x"] },
    { id: "header-non-latin1", args: ["--graphql-introspect", "{URL}/compact", "--http-header", "X-Custom: €"] },
    { id: "method-put", args: ["--graphql-introspect", "{URL}/compact", "--http-method", "PUT"] },
    { id: "method-lowercase-post", args: ["--graphql-introspect", "{URL}/compact", "--http-method", "post"] },
    { id: "method-get", args: ["--graphql-introspect", "{URL}/compact", "--http-method", "GET"] },
    { id: "method-trace", args: ["--graphql-introspect", "{URL}/compact", "--http-method", "TRACE"] },
    { id: "method-invalid", args: ["--graphql-introspect", "{URL}/compact", "--http-method", "NOT A METHOD"] },
    { id: "bom-and-number-formats", args: ["--graphql-introspect", "{URL}/bom"] },
    { id: "errors", args: ["--graphql-introspect", "{URL}/errors"] },
    { id: "empty-errors", args: ["--graphql-introspect", "{URL}/empty-errors"] },
    { id: "no-data", args: ["--graphql-introspect", "{URL}/no-data"] },
    { id: "zero-data", args: ["--graphql-introspect", "{URL}/zero-data"] },
    { id: "null-result", args: ["--graphql-introspect", "{URL}/null"] },
    { id: "array-result", args: ["--graphql-introspect", "{URL}/array"] },
    { id: "string-result", args: ["--graphql-introspect", "{URL}/string"] },
    { id: "html", args: ["--graphql-introspect", "{URL}/html"] },
    { id: "truncated", args: ["--graphql-introspect", "{URL}/truncated"] },
    { id: "no-content", args: ["--graphql-introspect", "{URL}/no-content"] },
    { id: "redirect-301-becomes-get", args: ["--graphql-introspect", "{URL}/redirect"] },
    { id: "redirect-307-keeps-post", args: ["--graphql-introspect", "{URL}/redirect-307"] },
    { id: "bad-port", args: ["--graphql-introspect", "http://127.0.0.1:1/"] },
    { id: "invalid-url", args: ["--graphql-introspect", "not a url"] },
    { id: "credentials", args: ["--graphql-introspect", "http://user:pw@127.0.0.1:1/"] },
    { id: "src-lang-json", args: ["--src-lang", "json", "--graphql-introspect", "{URL}/schema"] },
    { id: "schema-file-unwritable", args: ["--graphql-introspect", "{URL}/compact", "--graphql-schema", "missing-dir/out.gqlschema"] },
    {
        id: "query-error",
        args: ["--graphql-introspect", "{URL}/schema", "--lang", "typescript", "query.graphql"],
        files: query("{ viewer { nope } }"),
    },
];

// ---- The server --------------------------------------------------------------

let requests = [];
const server = http.createServer((req, res) => {
    const chunks = [];
    req.on("data", (c) => chunks.push(c));
    req.on("end", () => {
        const body = Buffer.concat(chunks).toString("utf8");
        const headers = {};
        for (const name of HEADERS) {
            if (req.headers[name] !== undefined) headers[name] = req.headers[name];
        }
        requests.push({
            method: req.method,
            path: req.url,
            headers,
            body: body === introspectionBody ? "<introspection query>" : body,
        });
        const route = routes[req.url] ?? { status: 404, headers: {}, body: "" };
        res.writeHead(route.status, route.headers);
        res.end(route.body);
    });
});
await new Promise((r) => server.listen(0, "127.0.0.1", r));
const url = `http://127.0.0.1:${server.address().port}`;

// ---- Running -----------------------------------------------------------------

// Asynchronously, so the server in this process can answer.
const run = (args, cwd) =>
    new Promise((resolveRun) => {
        const child = spawn(process.execPath, [cli, ...args], { cwd });
        const out = [];
        const err = [];
        child.stdout.on("data", (d) => out.push(d));
        child.stderr.on("data", (d) => err.push(d));
        child.on("close", (code) =>
            resolveRun({ code, stdout: Buffer.concat(out).toString(), stderr: Buffer.concat(err).toString() }),
        );
    });

const unport = (s) => s.split(url).join("{URL}");
const results = [];
for (const c of cases) {
    const dir = mkdtempSync(join(tmpdir(), "qt-introspect-"));
    for (const [name, content] of Object.entries(c.files ?? {})) writeFileSync(join(dir, name), content);
    requests = [];
    const { code, stdout, stderr } = await run(c.args.map((a) => a.replace("{URL}", url)), dir);
    const written = {};
    for (const name of readdirSync(dir).sort()) {
        if (!(name in (c.files ?? {}))) written[name] = readFileSync(join(dir, name), "utf8");
    }
    rmSync(dir, { recursive: true, force: true });
    results.push({ ...c, exit: code, stdout: unport(stdout), stderr: unport(stderr), written, requests });
}
server.close();

const out = join(repoRoot, "crates/quicktype-cli/tests/fixtures/graphql-introspect.json");
mkdirSync(dirname(out), { recursive: true });
writeFileSync(out, `${JSON.stringify({ headers: HEADERS, routes, cases: results }, null, 1)}\n`);
console.log(`recorded ${results.length} cases`);
