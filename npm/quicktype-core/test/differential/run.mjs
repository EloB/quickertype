// The differential API test suite: runs every scenario (scenarios.mjs)
// against the reference quicktype-core and this package, and compares
// results (files, lines, annotations), errors (class, messageName,
// message, properties) and console output.
//
//   node test/differential/run.mjs [--only REGEX] [--category corpus,inputs,api,stores,errors,robustness,fuzz]
//                                  [--shards N] [--report FILE] [--show N]
//
// Each identical scenario is counted by the engine that produced it: on
// WebAssembly, on the TypeScript fallback (the engine reported the run as
// unsupported, e.g. for a language without a renderer, which no built-in
// language is), or on the TypeScript engine because the facade did not
// consider it eligible (or no run happened).
// Exits 1 if anything differs, apart from documented known gaps.

import { fork } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { loadPackages, packageRoot } from "./packages.mjs";

/**
 * Differences that are known and documented (docs/PARITY.md, "Known gaps"):
 * reported, but not counted as failures.
 */
const knownGaps = new Map([
    [
        "stores/undefined in a store's document (known gap)",
        "the engine reads an undefined property of a store's document as absent; TypeScript fails on it",
    ],
]);

const here = path.dirname(fileURLToPath(import.meta.url));
const args = process.argv.slice(2);
const option = (name, fallback) => {
    const i = args.indexOf(name);
    return i < 0 ? fallback : args[i + 1];
};
const shards = Number(option("--shards", Math.max(1, os.cpus().length - 2)));
const only = option("--only", "");
const categories = option("--category", "");
const reportFile = option("--report", path.join(packageRoot, "build", "differential-report.json"));
const show = Number(option("--show", 25));

const { reference } = loadPackages();
console.log(`reference: ${reference.label}`);
console.log(`ours:      ${packageRoot} (WebAssembly engine)`);

const started = Date.now();
const results = [];
await Promise.all(
    Array.from({ length: shards }, (_, shard) =>
        new Promise((resolve, reject) => {
            const child = fork(path.join(here, "worker.mjs"), [String(shard), String(shards), only, categories], {
                stdio: ["ignore", "inherit", "inherit", "ipc"],
            });
            child.on("message", (m) => results.push(...m.results));
            child.on("exit", (code) => (code === 0 ? resolve() : reject(new Error(`worker ${shard} exited with ${code}`))));
        }),
    ),
);

const byCategory = new Map();
for (const r of results) {
    if (!byCategory.has(r.category)) byCategory.set(r.category, []);
    byCategory.get(r.category).push(r);
}

let failures = 0;
const summary = {};
for (const [category, list] of byCategory) {
    const count = (f) => list.filter(f).length;
    const pass = count((r) => r.status === "pass");
    const passWasm = count((r) => r.status === "pass" && r.engine === "wasm");
    const fallback = list.filter((r) => r.status === "pass" && r.engine === "fallback");
    const rerun = count((r) => r.status === "pass" && r.engine === "rerun");
    const passOther = pass - passWasm - fallback.length - rerun;
    const known = list.filter((r) => r.status === "fail" && knownGaps.has(r.id));
    const failed = list.filter((r) => r.status === "fail" && !knownGaps.has(r.id));
    failures += failed.length;
    summary[category] = {
        total: list.length,
        identical: pass,
        identicalOnWasm: passWasm,
        identicalOnFallback: fallback.length,
        identicalAfterEngineFailure: rerun,
        identicalOnTypeScript: passOther,
        knownGaps: known.length,
        different: failed.length,
    };
    console.log(
        `\n${category}: ${list.length} scenarios: ${pass} identical (${passWasm} on WebAssembly, ` +
            `${fallback.length} on the TypeScript fallback, ${rerun} redone on TypeScript after an engine failure, ` +
            `${passOther} on TypeScript by eligibility or without a run), ` +
            `${known.length} known gaps, ${failed.length} different`,
    );
    for (const r of known) console.log(`  known gap: ${r.id}: ${knownGaps.get(r.id)}`);
    if (fallback.length > 0) {
        const features = new Map();
        for (const r of fallback) for (const f of r.unsupported ?? []) features.set(f, (features.get(f) ?? 0) + 1);
        console.log(`  fallback (unsupported by the engine): ${[...features].map(([f, n]) => `${f} ${n}`).join(", ")}`);
    }

    for (const r of failed.slice(0, show)) {
        console.log(`  DIFF ${r.id}\n       ${r.detail}`);
    }

    if (failed.length > show) console.log(`  … and ${failed.length - show} more`);
}

fs.mkdirSync(path.dirname(reportFile), { recursive: true });
fs.writeFileSync(
    reportFile,
    `${JSON.stringify({ reference: reference.label, summary, results: results.sort((a, b) => (a.id < b.id ? -1 : 1)) }, undefined, 1)}\n`,
);
console.log(`\n${results.length} scenarios in ${((Date.now() - started) / 1000).toFixed(1)}s; report: ${path.relative(process.cwd(), reportFile)}`);
process.exit(failures > 0 ? 1 : 0);
