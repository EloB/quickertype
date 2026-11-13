#!/usr/bin/env node
// The TypeScript side of the in-process benchmark: the same workload as
// crates/quicktype-cli/benches/in_process.rs (every JSON file in
// tests/inputs/json/samples plus json/misc/1b409.json, through eight
// languages), on the reference quicktype-core in one warm Node process.
//
//   node xtask/bench/in-process.mjs <quicktype checkout> [--iterations N] [--json]

import { readdirSync, readFileSync } from "node:fs";
import { join, resolve } from "node:path";
import { performance } from "node:perf_hooks";
import { fileURLToPath, pathToFileURL } from "node:url";

const args = process.argv.slice(2);
const checkout = resolve(args[0] ?? "../quicktype");
let iterations = 10;
let json = false;
for (let i = 1; i < args.length; i++) {
    if (args[i] === "--iterations" || args[i] === "-n") iterations = Number(args[++i]);
    else if (args[i] === "--json") json = true;
}
if (!Number.isInteger(iterations) || iterations < 1) {
    console.error(`--iterations must be a whole number of at least 1, got ${iterations}`);
    process.exit(2);
}

const core = await import(
    pathToFileURL(join(checkout, "packages/quicktype-core/dist/index.js")).href
);
const { InputData, jsonInputForTargetLanguage, quicktypeMultiFile } = core;

const LANGUAGES = ["ts", "rust", "go", "cs", "java", "py", "swift", "c++"];
const inputsDir = fileURLToPath(new URL("../../tests/inputs/json", import.meta.url));
const files = readdirSync(join(inputsDir, "samples"))
    .filter((f) => f.endsWith(".json"))
    .sort()
    .map((f) => join(inputsDir, "samples", f));
files.push(join(inputsDir, "misc/1b409.json"));
const inputs = files.map((f) => readFileSync(f, "utf8"));

async function run(lang, text) {
    const start = performance.now();
    const input = jsonInputForTargetLanguage(lang);
    await input.addSource({ name: "TopLevel", samples: [text] });
    const inputData = new InputData();
    inputData.addInput(input);
    const parsed = performance.now();
    await quicktypeMultiFile({ inputData, lang });
    const done = performance.now();
    return [parsed - start, done - parsed];
}

async function iteration() {
    let parse = 0;
    let engine = 0;
    for (const text of inputs) {
        for (const lang of LANGUAGES) {
            const [p, e] = await run(lang, text);
            parse += p;
            engine += e;
        }
    }
    return [parse, engine];
}

// Warm-up: let V8 compile and optimize, as in a long-lived process.
for (let i = 0; i < 3; i++) await iteration();

const totals = [];
const parses = [];
const engines = [];
for (let i = 0; i < iterations; i++) {
    const [p, e] = await iteration();
    totals.push(p + e);
    parses.push(p);
    engines.push(e);
}
const median = (v) => {
    const s = v.toSorted((a, b) => a - b);
    const m = Math.floor(s.length / 2);
    return s.length % 2 ? s[m] : (s[m - 1] + s[m]) / 2;
};
const runs = inputs.length * LANGUAGES.length;
const result = {
    runs,
    iterations,
    total_ms: median(totals),
    total_min_ms: Math.min(...totals),
    parse_ms: median(parses),
    engine_ms: median(engines),
};
if (json) {
    console.log(JSON.stringify(result));
} else {
    console.log(`in-process (TypeScript): ${runs} runs per iteration, ${iterations} iterations`);
    console.log(`  total   median ${result.total_ms.toFixed(1)} ms  (min ${result.total_min_ms.toFixed(1)} ms)`);
    console.log(`  parse   median ${result.parse_ms.toFixed(1)} ms`);
    console.log(`  engine  median ${result.engine_ms.toFixed(1)} ms`);
}
