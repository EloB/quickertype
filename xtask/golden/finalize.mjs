#!/usr/bin/env node
// Turns raw recordings (from record-hook.cjs) into the golden corpus layout:
//
//   tests/golden/<fixture>/<input path under test/inputs>/<hash>/case.json
//   tests/golden/<fixture>/<input path under test/inputs>/<hash>/step<N>/<files>
//
// <hash> is derived from the argv of all steps, so the layout is
// deterministic across recordings.
//
// Usage: finalize.mjs <raw-dir> <golden-dir> [<reference-snapshot-dir>]
// If a reference snapshot (OUTPUT_SNAPSHOT_DIR of the reference harness) is
// given, every recorded output file is cross-checked against it.

import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";

const [rawDir, goldenDir, snapDir] = process.argv.slice(2);
if (!rawDir || !goldenDir) {
    console.error("usage: finalize.mjs <raw-dir> <golden-dir> [<snapshot-dir>]");
    process.exit(2);
}

const sha = (data) => createHash("sha256").update(data).digest("hex");

function filesBelow(root, rel = "") {
    const out = [];
    for (const e of fs.readdirSync(path.join(root, rel), { withFileTypes: true })) {
        const r = rel ? path.join(rel, e.name) : e.name;
        if (e.isDirectory()) out.push(...filesBelow(root, r));
        else if (e.isFile()) out.push(r);
    }
    return out;
}

fs.rmSync(goldenDir, { recursive: true, force: true });
fs.mkdirSync(goldenDir, { recursive: true });

let cases = 0;
let duplicates = 0;
const conflicts = [];
const recordedHashes = new Map(); // "<fixture>\0<input>" -> multiset of file hashes

for (const run of fs.readdirSync(rawDir).sort()) {
    const runDir = path.join(rawDir, run);
    const rec = JSON.parse(fs.readFileSync(path.join(runDir, "run.json"), "utf8"));
    const fixture = run.replace(/-[0-9a-f]{6}$/, "");

    // Inputs live in test/inputs in quicktype and tests/inputs here; cases
    // refer to them through the {INPUTS} placeholder.
    for (const step of rec.steps) {
        step.args = step.args.map((a) => a.replace(/^\{ROOT\}\/test\/inputs\//, "{INPUTS}/"));
        const leftover = step.args.find((a) => a.includes("{ROOT}"));
        if (leftover !== undefined) throw new Error(`${run}: path outside test/inputs: ${leftover}`);
    }

    const firstArgs = rec.steps[0].args;
    const srcIndex = firstArgs.indexOf("--src");
    const src = srcIndex >= 0 ? firstArgs[srcIndex + 1] : "_";
    const input = src.replace(/^\{INPUTS\}\//, "");

    const id = sha(JSON.stringify(rec.steps.map((s) => s.args))).slice(0, 10);
    const caseDir = path.join(goldenDir, fixture, input, id);

    // quicktype does not create output directories; record the ones the
    // reference run relied on (pre-existing ancestors of written files).
    const written = rec.steps.flatMap((s) => s.files);
    const dirs = (rec.preexistingDirs ?? []).filter((d) => written.some((f) => f.startsWith(`${d}/`)));

    const caseJson = {
        fixture,
        input,
        ...(dirs.length > 0 ? { dirs } : {}),
        steps: rec.steps.map((s) => ({
            args: s.args,
            files: s.files,
            ...(s.error === null ? {} : { expect_failure: true }),
        })),
    };
    const text = `${JSON.stringify(caseJson, null, 2)}\n`;

    const contents = new Map();
    rec.steps.forEach((s, i) => {
        for (const f of s.files) {
            contents.set(path.join(`step${i}`, f), fs.readFileSync(path.join(runDir, `step${i}`, f)));
        }
    });

    if (fs.existsSync(caseDir)) {
        duplicates++;
        const same =
            fs.readFileSync(path.join(caseDir, "case.json"), "utf8") === text &&
            [...contents].every(([p, buf]) => fs.readFileSync(path.join(caseDir, p)).equals(buf));
        if (!same) conflicts.push(`${fixture}/${input}/${id}`);
        continue;
    }

    fs.mkdirSync(caseDir, { recursive: true });
    fs.writeFileSync(path.join(caseDir, "case.json"), text);
    for (const [p, buf] of contents) {
        fs.mkdirSync(path.dirname(path.join(caseDir, p)), { recursive: true });
        fs.writeFileSync(path.join(caseDir, p), buf);
    }
    cases++;

    const key = `${fixture}\0${path.join("test/inputs", input)}`;
    const hashes = recordedHashes.get(key) ?? [];
    for (const buf of contents.values()) hashes.push(sha(buf));
    recordedHashes.set(key, hashes);
}

console.log(`cases: ${cases}  duplicate runs: ${duplicates}  conflicting duplicates: ${conflicts.length}`);
for (const c of conflicts.slice(0, 20)) console.log(`  CONFLICT ${c}`);

if (snapDir) {
    // Cross-check: for every (fixture, input) in the reference snapshot, the
    // multiset of output-file hashes must equal what we recorded via argv.
    let checked = 0;
    const mismatches = [];
    for (const fixture of fs.readdirSync(snapDir)) {
        const fixtureDir = path.join(snapDir, fixture);
        const byInput = new Map();
        for (const f of filesBelow(fixtureDir)) {
            // <input path...>/<optionsID>/<generated file...>
            const m = f.match(/^(test\/inputs\/.+?\.(?:json|schema|graphql))\/[^/]+\/(.+)$/);
            if (!m) continue;
            const list = byInput.get(m[1]) ?? [];
            list.push(sha(fs.readFileSync(path.join(fixtureDir, f))));
            byInput.set(m[1], list);
        }
        for (const [input, snapHashes] of byInput) {
            checked++;
            const rec = (recordedHashes.get(`${fixture}\0${input}`) ?? []).slice().sort();
            const ref = snapHashes.slice().sort();
            // Recorded runs include every step's outputs, so they are a superset.
            const missing = ref.filter((h) => !rec.includes(h));
            if (missing.length > 0) mismatches.push(`${fixture} ${input} (${missing.length} files)`);
        }
    }
    console.log(`snapshot cross-check: ${checked} fixture/input groups, ${mismatches.length} mismatches`);
    for (const m of mismatches.slice(0, 20)) console.log(`  MISMATCH ${m}`);
    if (mismatches.length > 0 || conflicts.length > 0) process.exit(1);
}
