// Runs a shard of the differential scenarios against both packages and
// reports each outcome to the parent (run.mjs).

import * as fs from "node:fs";
import * as os from "node:os";
import { createRequire } from "node:module";
import * as path from "node:path";

import { brief, capture, firstDifference, notPortedLanguage } from "./compare.mjs";
import { inputsDir, loadPackages } from "./packages.mjs";
import { allScenarios } from "./scenarios.mjs";

const [shard, shards, only, categories] = process.argv.slice(2);
const timeoutMs = 120_000;

function withTimeout(promise) {
    let timer;
    const timeout = new Promise((resolve) => {
        timer = setTimeout(() => resolve({ timeout: true }), timeoutMs);
    });
    return Promise.race([promise, timeout]).finally(() => clearTimeout(timer));
}

const { reference, ours, checkout } = loadPackages();
const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "qt-diff-"));
const require = createRequire(import.meta.url);
const roots = new Map([
    [reference.qt, reference.root],
    [ours.qt, ours.root],
]);
/** What scenarios get besides the package: see scenarios.mjs. */
const ctx = {
    inputsDir,
    tmpDir,
    referenceCheckout: checkout,
    /** `require("<the package of qt>/<subpath>")`, for deep imports such as "dist/DateTime.js". */
    deepRequire: (qt, subpath) => require(path.join(roots.get(qt), subpath)),
};
const filter = only ? new RegExp(only) : undefined;
const list = allScenarios(categories ? categories.split(",") : undefined);

const results = [];
for (let i = Number(shard); i < list.length; i += Number(shards)) {
    const s = list[i];
    if (filter !== undefined && !filter.test(s.id)) continue;
    const expected = await withTimeout(capture(reference.wrap(() => s.run(reference.qt, ctx))));
    const before = { ...ours.stats };
    const actual = await withTimeout(capture(ours.wrap(() => s.run(ours.qt, ctx))));
    const wasmRuns = ours.stats.wasm - before.wasm;
    const tsRuns = ours.stats.ts - before.ts;
    const engine = wasmRuns > 0 ? (tsRuns > 0 ? "mixed" : "wasm") : tsRuns > 0 ? "ts" : "none";
    const result = { id: s.id, category: s.category, group: s.group, engine };
    if (JSON.stringify(expected) === JSON.stringify(actual)) {
        result.status = "pass";
    } else if (notPortedLanguage(actual) !== undefined) {
        result.status = "notPorted";
        result.language = notPortedLanguage(actual);
    } else {
        result.status = "fail";
        const d = firstDifference(expected, actual);
        result.detail = d === undefined ? "?" : `${d.path}: expected ${brief(d.expected)}, got ${brief(d.actual)}`;
    }

    results.push(result);
    if (results.length >= 200) {
        process.send({ results: results.splice(0) });
    }
}

process.send({ results, done: true }, () => process.exit(0));
