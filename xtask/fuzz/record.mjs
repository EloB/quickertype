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
import { unportablePaths } from "./file-names.mjs";

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
const record = { description, seed: saved.seed, foundIn: saved.mode ?? saved.foundIn, case: kase };
/** What goes into the case directory besides case.json: relative path → bytes. */
const files = new Map();
if (cliCompatible(kase)) {
    const invocation = cliInvocation(kase);
    const result = await runCli(cliCommands(reference).ref, invocation);
    if (typeof result.exit !== "number") throw new Error(`reference CLI: ${result.exit}`);
    for (const [f, text] of invocation.files) files.set(f, Buffer.from(text, "utf8"));
    record.cli = { args: invocation.args, dirs: invocation.dirs, exit: result.exit };
    if (result.stdout !== "") files.set("cli.stdout", Buffer.from(result.stdout, "latin1"));
    if (result.stderr !== "") files.set("cli.stderr", Buffer.from(result.stderr, "latin1"));
    const written = Object.entries(result.files).map(([f, content]) => [f.split(path.sep).join("/"), content]);
    for (const [f, content] of written) files.set(`expected/${f}`, Buffer.from(content, "latin1"));
    record.cli.files = written.map(([f]) => f).sort();
}

// The case is checked out on Windows, macOS and Linux: every name in it
// must be one all three can hold (cliCompatible saw to the inputs; the
// reference's output files are named after types), and Windows' 260
// characters must fit the whole path below a checkout.
const paths = [...files.keys()];
const unportable = unportablePaths(paths);
const tooLong = paths.filter((p) => `tests/fuzz-regressions/${name}/${p}`.length > 200);
if (unportable.length > 0 || tooLong.length > 0) {
    console.error(`cannot record ${name}: file names Windows, macOS or Linux cannot check out:`);
    for (const p of [...unportable, ...tooLong.map((p) => `${p} (path too long)`)]) console.error(`  ${JSON.stringify(p)}`);
    console.error("rename what they come from in the case (top-levels, --out) and minimize again");
    process.exit(1);
}

fs.rmSync(dir, { recursive: true, force: true });
fs.mkdirSync(dir, { recursive: true });
for (const [f, bytes] of files) {
    fs.mkdirSync(path.dirname(path.join(dir, f)), { recursive: true });
    fs.writeFileSync(path.join(dir, f), bytes);
}

fs.writeFileSync(path.join(dir, "case.json"), `${JSON.stringify(record, undefined, 2)}\n`);
console.log(`recorded ${path.relative(repoRoot, dir)}${record.cli ? ` (CLI exit ${record.cli.exit})` : " (API only)"}`);
