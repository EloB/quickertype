#!/usr/bin/env node
// Records the reference output for the TypeScript-input differential corpus.
//
// For every case directory in crates/quicktype-typescript-input/tests/corpus,
// runs quicktype-typescript-input's `schemaForTypeScriptSources` (TypeScript
// 5.9.3 + typescript-json-schema 0.67.4) on the case's `.ts` files (or the
// names listed in its `files.json`), with the case directory as the working
// directory (quicktype compiles with `rootDir: "."`), and writes
// `expected.json`:
//
//   { "schema": "<JSON.stringify output>", "name": "...", "uris": [...],
//     "warnings": [...] }                     on success
//   { "error": "<error.message>", "warnings": [...] }   on failure
//
// `warnings` are the console.warn/console.error lines typescript-json-schema
// prints. Each case runs in its own Node process: the TypeScript 5 compiler
// keeps module-resolution state between in-process calls, which the
// one-shot CLI never sees.
//
// Usage: node xtask/typescript-input/record.mjs <quicktype checkout> [regex]
// The checkout must be built (npm ci && npm run build). TS_INPUT_CORPUS=<dir>
// records a different corpus directory.

import { execFileSync, spawn } from "node:child_process";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as os from "node:os";
import * as path from "node:path";

const here = path.dirname(new URL(import.meta.url).pathname);
const corpus = path.resolve(process.env.TS_INPUT_CORPUS ?? path.join(here, "../../crates/quicktype-typescript-input/tests/corpus"));

if (process.argv[2] === "--case") {
    // Child mode: record one case.
    const [, , , checkout, dir] = process.argv;
    const require = createRequire(path.join(checkout, "package.json"));
    const { schemaForTypeScriptSources } = require("quicktype-typescript-input");
    // `files.json` (a list of names) overrides the default: the case's
    // `.ts` files in sorted order.
    const list = path.join(dir, "files.json");
    const files = fs.existsSync(list)
        ? JSON.parse(fs.readFileSync(list, "utf8"))
        : fs.readdirSync(dir).filter((f) => f.endsWith(".ts")).sort();
    const warnings = [];
    console.warn = (...a) => warnings.push(a.join(" "));
    console.error = (...a) => warnings.push(a.join(" "));
    process.chdir(dir);
    let result;
    try {
        const r = schemaForTypeScriptSources(files);
        result = { schema: r.schema, name: r.name, uris: r.uris };
    } catch (e) {
        result = { error: String(e?.message ?? e) };
    }
    if (warnings.length > 0) result.warnings = warnings;
    fs.writeFileSync(path.join(dir, "expected.json"), `${JSON.stringify(result, null, 2)}\n`);
    process.exit(0);
}

const checkout = path.resolve(process.argv[2] ?? path.join(here, "../../../quicktype"));
const filter = process.argv[3] ? new RegExp(process.argv[3]) : null;
const req = createRequire(path.join(checkout, "package.json"));
const tjsPkg = req.resolve("typescript-json-schema/package.json");
const tsVersion = createRequire(tjsPkg)("typescript/package.json").version;
const tjsVersion = JSON.parse(fs.readFileSync(tjsPkg, "utf8")).version;

const cases = fs
    .readdirSync(corpus)
    .filter((d) => fs.statSync(path.join(corpus, d)).isDirectory())
    .filter((d) => !filter || filter.test(d))
    .sort();

let next = 0;
let failed = 0;
async function worker() {
    while (next < cases.length) {
        const dir = path.join(corpus, cases[next++]);
        await new Promise((resolve) => {
            const child = spawn(process.execPath, [new URL(import.meta.url).pathname, "--case", checkout, dir], {
                stdio: ["ignore", "inherit", "inherit"],
            });
            child.on("exit", (code) => {
                if (code !== 0) {
                    failed++;
                    console.error(`failed: ${dir}`);
                }
                resolve();
            });
        });
    }
}
await Promise.all(Array.from({ length: os.cpus().length }, worker));

const commit = execFileSync("git", ["-C", checkout, "rev-parse", "HEAD"], { encoding: "utf8" }).trim();
fs.writeFileSync(
    path.join(corpus, "REFERENCE"),
    `quicktype_commit=${commit}\ntypescript=${tsVersion}\ntypescript_json_schema=${tjsVersion}\nnode=${process.version}\n`,
);
console.log(`recorded ${cases.length - failed}/${cases.length} cases (typescript ${tsVersion}, typescript-json-schema ${tjsVersion})`);
process.exit(failed ? 1 : 0);
