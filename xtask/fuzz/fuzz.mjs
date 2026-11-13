#!/usr/bin/env node
// Differential fuzzing of the port against quicktype: seeded random JSON
// samples and JSON Schemas × every target language × random renderer and
// general options, compared in-process (reference quicktype-core against
// our npm package on WebAssembly) and through both CLIs. See README.md.
//
//   node xtask/fuzz/fuzz.mjs [--seed N] [--count N | --minutes M] [-j N]
//                            [--modes api,stream,cli] [--stream-rate R] [--cli-rate R]
//                            [--lang a,b] [--src json|schema] [--out DIR]
//                            [--reference DIR] [--bin PATH]
//   node xtask/fuzz/fuzz.mjs --print SEED      print the case a seed generates
//   node xtask/fuzz/fuzz.mjs --replay FILE [--mode M]
//                                              rerun a saved divergence or case file

import { execFileSync, fork } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { makeChecker } from "./check.mjs";
import { findReference, loadSides, optionDefinitions, repoRoot } from "./engines.mjs";
import { generateCase, LANGUAGES } from "./generate.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const args = process.argv.slice(2);
const option = (name, fallback) => {
    const i = args.indexOf(name);
    return i < 0 ? fallback : args[i + 1];
};

const reference = findReference(option("--reference"));
const bin = option("--bin");

if (args.includes("--print")) {
    const sides = loadSides(reference);
    const kase = generateCase(Number(option("--print")), optionDefinitions(sides.ref.qt), {
        languages: option("--lang")?.split(","),
        src: option("--src"),
    });
    console.log(JSON.stringify(kase, undefined, 1));
    process.exit(0);
}

if (args.includes("--replay")) {
    const saved = JSON.parse(fs.readFileSync(option("--replay"), "utf8"));
    const kase = saved.case ?? saved;
    const modes = option("--mode") !== undefined ? [option("--mode")] : saved.mode !== undefined ? [saved.mode] : ["api", "stream", "cli"];
    const { check } = await makeChecker({ reference, bin });
    let differs = false;
    for (const mode of modes) {
        const r = await check(kase, mode);
        console.log(`${mode}: ${r.status}${r.engine ? ` (${r.engine})` : ""}${r.detail ? `\n  ${r.detail}` : ""}`);
        if (r.status === "diff") differs = true;
    }

    process.exit(differs ? 1 : 0);
}

const start = Number(option("--seed", String(Date.now() % 1_000_000_000)));
const minutes = option("--minutes") !== undefined ? Number(option("--minutes")) : undefined;
const count = Number(option("--count", minutes === undefined ? "1000" : String(Number.MAX_SAFE_INTEGER)));
const jobs = Number(option("-j", "4"));
const config = {
    reference,
    bin,
    modes: option("--modes", "api,stream,cli").split(","),
    streamRate: Number(option("--stream-rate", "0.35")),
    cliRate: Number(option("--cli-rate", "0.08")),
    languages: option("--lang")?.split(",") ?? LANGUAGES,
    src: option("--src"),
    outDir: path.resolve(option("--out", path.join(repoRoot, "target", "fuzz", `run-${start}`))),
};
fs.mkdirSync(config.outDir, { recursive: true });
const deadline = minutes === undefined ? Infinity : Date.now() + minutes * 60_000;

console.log(`reference: ${reference}`);
console.log(`seeds ${start}.. (${minutes !== undefined ? `${minutes} minutes` : `${count} cases`}), ${jobs} workers, modes ${config.modes.join(",")}`);
console.log(`divergences: ${config.outDir}`);

let next = start;
const end = start + count;
const inFlight = new Map();
const counts = {};
const diffs = [];
let done = 0;
let crashed = 0;
const begun = Date.now();

function tally(lang, src, mode, status, engine) {
    const key = `${mode}`;
    counts[key] ??= { total: 0, same: 0, diff: 0, timeout: 0, skip: 0, notWasm: 0 };
    const c = counts[key];
    c.total++;
    c[status]++;
    if ((mode === "api" || mode === "stream") && engine !== "wasm" && status !== "skip" && status !== "timeout") c.notWasm++;
    counts.byLang ??= {};
    counts.byLang[lang] ??= 0;
    counts.byLang[lang]++;
    counts.bySrc ??= {};
    counts.bySrc[src] ??= 0;
    if (mode === "api") counts.bySrc[src]++;
}

function nextSeed() {
    if (next >= end || Date.now() >= deadline) return undefined;
    return next++;
}

function startWorker(id) {
    return new Promise((resolve) => {
        const child = fork(path.join(here, "worker.mjs"), [JSON.stringify(config)], {
            stdio: ["ignore", "ignore", "inherit", "ipc"],
            execArgv: ["--max-old-space-size=4096", "--stack-size=984"],
        });
        let current;
        let served = 0;
        const feed = () => {
            // Recycle workers now and then (both quicktype-cores hold caches).
            current = served++ < 400 ? nextSeed() : undefined;
            if (current === undefined) {
                child.send({});
                inFlight.delete(id);
            } else {
                inFlight.set(id, current);
                child.send({ seed: current });
            }
        };
        child.on("message", (m) => {
            if (m.ready) {
                feed();
                return;
            }

            const { result } = m;
            done++;
            for (const r of result.results) {
                tally(result.lang, result.src, r.mode, r.status, r.engine);
                if (r.status === "diff") {
                    diffs.push({ seed: result.seed, lang: result.lang, mode: r.mode, detail: r.detail });
                    console.log(`DIFF seed ${result.seed} ${result.lang} ${result.src} ${r.mode}${r.engine ? ` [${r.engine}]` : ""}: ${String(r.detail).slice(0, 300)}`);
                }
            }

            if (done % 250 === 0) progress();
            feed();
        });
        child.on("exit", (code, signal) => {
            const seed = inFlight.get(id);
            inFlight.delete(id);
            if (seed !== undefined) {
                crashed++;
                diffs.push({ seed, mode: "?", detail: `worker died (${code ?? signal})` });
                console.log(`CRASH seed ${seed}: worker died (${code ?? signal})`);
                fs.writeFileSync(path.join(config.outDir, `${seed}-crash.json`), `${JSON.stringify({ seed, detail: `worker died (${code ?? signal})` })}\n`);
            }

            resolve(seed !== undefined || served > 400);
        });
    }).then((again) => (again && (next < end && Date.now() < deadline) ? startWorker(id) : undefined));
}

function progress() {
    const secs = (Date.now() - begun) / 1000;
    const modes = Object.entries(counts)
        .filter(([k]) => k !== "byLang" && k !== "bySrc")
        .map(([k, c]) => `${k} ${c.same}/${c.total - c.skip} same, ${c.diff} diff, ${c.timeout} timeout, ${c.notWasm} not on wasm`)
        .join("; ");
    console.log(`[${secs.toFixed(0)}s] ${done} cases (seeds ${start}..${next - 1}): ${modes}`);
}

await Promise.all(Array.from({ length: jobs }, (_, i) => startWorker(i)));
progress();
const commit = (() => {
    try {
        return execFileSync("git", ["rev-parse", "--short", "HEAD"], { cwd: repoRoot, encoding: "utf8" }).trim();
    } catch {
        return undefined;
    }
})();
const summary = { reference, commit, start, last: next - 1, cases: done, crashed, counts, diffs, seconds: (Date.now() - begun) / 1000 };
fs.writeFileSync(path.join(config.outDir, "summary.json"), `${JSON.stringify(summary, undefined, 1)}\n`);
console.log(`\n${done} cases, seeds ${start}..${next - 1}, ${diffs.length} divergences (${crashed} worker crashes); summary: ${path.join(config.outDir, "summary.json")}`);
process.exit(diffs.length > 0 ? 1 : 0);
