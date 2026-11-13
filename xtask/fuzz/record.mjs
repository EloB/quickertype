#!/usr/bin/env node
// Records a (minimized) divergence as a regression case in
// tests/fuzz-regressions/<name>/, from the reference:
//
//   node xtask/fuzz/record.mjs <case.min.json> <name> "<what it checks>" [--reference DIR]
//   node xtask/fuzz/record.mjs tests/fuzz-regressions/<name>/case.json
//
// The case directory holds
//
// * case.json: the fuzz case (inputs inline; `src`, `lang`, options), a
//   description, and the CLI step derived from it: `args` (relative to the
//   case directory) and the reference CLI's `exit` code;
// * in/: the input files the CLI step reads;
// * cli.stdout, cli.stderr, and expected/<file> for each file the step
//   wrote, as the reference CLI produced them (the work directory replaced
//   by {CWD}).
//
// crates/quicktype-cli/tests/fuzz_regressions.rs replays the CLI step with
// our binary; the npm differential suite's `fuzz` scenarios run the case
// through the JavaScript API against the reference quicktype-core.
// Re-running this script re-records a case; given a recorded case.json,
// it re-records that case under its own name and description (run it on
// every case and check that git sees no change, to verify that the
// committed bytes are still what the reference produces).

import * as fs from "node:fs";
import * as path from "node:path";

import { cliCommands, cliCompatible, cliInvocation, findReference, repoRoot, runCli } from "./engines.mjs";

const args = process.argv.slice(2);
const option = (name) => {
    const i = args.indexOf(name);
    return i < 0 ? undefined : args.splice(i, 2)[1];
};
const reference = findReference(option("--reference"));
const casesDir = path.join(repoRoot, "tests", "fuzz-regressions");
const [file, nameArg, descriptionArg] = args;
const saved = file === undefined ? undefined : JSON.parse(fs.readFileSync(file, "utf8"));
// A recorded case.json re-records itself.
const recorded = file !== undefined && path.basename(file) === "case.json" && path.dirname(path.dirname(path.resolve(file))) === casesDir;
const name = nameArg ?? (recorded ? path.basename(path.dirname(path.resolve(file))) : undefined);
const description = descriptionArg ?? (recorded ? saved.description : undefined);
if (saved === undefined || name === undefined || description === undefined || !/^[a-z0-9][a-z0-9-]*$/.test(name)) {
    console.error('usage: node xtask/fuzz/record.mjs <case.json> <name: [a-z0-9-]+> "<description>"');
    console.error("       node xtask/fuzz/record.mjs tests/fuzz-regressions/<name>/case.json");
    process.exit(2);
}

const kase = saved.case ?? saved;
const dir = path.join(casesDir, name);
fs.rmSync(dir, { recursive: true, force: true });
fs.mkdirSync(dir, { recursive: true });

const record = { description, seed: saved.seed, foundIn: saved.mode ?? saved.foundIn, case: kase };
if (cliCompatible(kase)) {
    const invocation = cliInvocation(kase);
    const result = await runCli(cliCommands(reference).ref, invocation);
    if (typeof result.exit !== "number") throw new Error(`reference CLI: ${result.exit}`);
    for (const [f, text] of invocation.files) {
        fs.mkdirSync(path.join(dir, path.dirname(f)), { recursive: true });
        fs.writeFileSync(path.join(dir, f), text);
    }

    record.cli = { args: invocation.args, dirs: invocation.dirs, exit: result.exit };
    if (result.stdout !== "") fs.writeFileSync(path.join(dir, "cli.stdout"), Buffer.from(result.stdout, "latin1"));
    if (result.stderr !== "") fs.writeFileSync(path.join(dir, "cli.stderr"), Buffer.from(result.stderr, "latin1"));
    for (const [f, content] of Object.entries(result.files)) {
        const target = path.join(dir, "expected", f);
        fs.mkdirSync(path.dirname(target), { recursive: true });
        fs.writeFileSync(target, Buffer.from(content, "latin1"));
    }

    record.cli.files = Object.keys(result.files).sort();
}

fs.writeFileSync(path.join(dir, "case.json"), `${JSON.stringify(record, undefined, 2)}\n`);
console.log(`recorded ${path.relative(repoRoot, dir)}${record.cli ? ` (CLI exit ${record.cli.exit})` : " (API only)"}`);
