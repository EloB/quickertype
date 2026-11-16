// Intended differences (tests/intended-differences.txt): scenarios whose
// result differs from the reference's on purpose, because quickertype
// fixes a bug in the code quicktype generates (docs/PARITY.md, "Bugs fixed
// in quickertype"). A listed scenario must differ from the reference, and
// exactly as stored:
//
// * `corpus/<case>` (the golden corpus through the API), for a golden case
//   the list names: the reference's files, each changed as the golden
//   case's `.intended` copy of it changes the recording (the diff between
//   the two, applied to the reference's file, which reads its sample with
//   JSON.parse and so can differ from the recording elsewhere).
// * any other scenario, listed as `npm/<scenario id>`: the reference's
//   result with the unified diff `intended/<scenario id>.diff` applied.
//   So is a corpus scenario listed this way, whose API result is not the
//   CLI's recording where the fix changes it (a sample that JSON.parse
//   reads differently).
//   The diff has a section per changed `lines` array of the result, named
//   by its path in the compared data (`--- $.ok.$map.0.1.lines`, as the
//   report shows differences). `run.mjs --record-intended` writes them.

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { goldenDir, goldenIntendedDir, repositoryRoot } from "./packages.mjs";

const listFile = path.join(repositoryRoot, "tests", "intended-differences.txt");
export const intendedDir = path.join(path.dirname(fileURLToPath(import.meta.url)), "intended");

/** The list's cases: id → the bugs that change it. */
function readList() {
    const cases = new Map();
    for (const line of fs.readFileSync(listFile, "utf8").split("\n")) {
        const words = line.trim().split(/\s+/);
        if (words[0] === "" || words[0].startsWith("#") || words[0] === "bug") continue;
        cases.set(words[0], words.slice(1));
    }

    return cases;
}

const list = readList();

/** The ids of the scenarios listed as `npm/<id>`. */
export const listedScenarios = [...list.keys()].filter((id) => id.startsWith("npm/")).map((id) => id.slice(4));

const diffPath = (id) => path.join(intendedDir, `${id}.diff`);

/** Every `.diff` file below intended/, as scenario ids. */
export function storedDiffs() {
    const found = [];
    const walk = (dir) => {
        if (!fs.existsSync(dir)) return;
        for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
            const full = path.join(dir, entry.name);
            if (entry.isDirectory()) walk(full);
            else if (entry.name.endsWith(".diff")) found.push(path.relative(intendedDir, full).slice(0, -5).split(path.sep).join("/"));
        }
    };
    walk(intendedDir);
    return found.sort();
}

/** The value at `jsonPath` (`$.a.0.b`) in `value`, and its parent and key. */
function locate(value, jsonPath) {
    const keys = jsonPath.split(".").slice(1);
    let parent;
    let key;
    let current = value;
    for (const k of keys) {
        parent = current;
        key = Array.isArray(current) ? Number(k) : k;
        current = current?.[key];
    }

    return { parent, key, current };
}

/** Every array of strings named `lines` in `value`, by path. */
function linesArrays(value, at = "$", out = new Map()) {
    if (Array.isArray(value)) value.forEach((v, i) => linesArrays(v, `${at}.${i}`, out));
    else if (value !== null && typeof value === "object") {
        for (const [k, v] of Object.entries(value)) {
            if (k === "lines" && Array.isArray(v) && v.every((l) => typeof l === "string")) out.set(`${at}.lines`, v);
            else linesArrays(v, `${at}.${k}`, out);
        }
    }

    return out;
}

/** `lines` with the hunks of a unified diff section applied. */
export function applyHunks(lines, hunks, where) {
    const out = [];
    let next = 0;
    for (const hunk of hunks) {
        const start = hunk.start - 1;
        out.push(...lines.slice(next, start));
        next = start;
        for (const line of hunk.lines) {
            const op = line[0];
            const text = line.slice(1);
            if (op === "+") {
                out.push(text);
                continue;
            }

            if (lines[next] !== text) {
                throw new Error(`${where}: the diff does not apply at line ${next + 1}`);
            }

            if (op === " ") out.push(text);
            next++;
        }
    }

    out.push(...lines.slice(next));
    return out;
}

/**
 * The sections of a unified diff: path → hunks. A hunk takes as many lines
 * as its `@@` ranges say, so a line inside it that starts with `--- ` or
 * `+++ ` (a removed `-- comment`, an added `++ x`) is part of it; the
 * headers are only recognized between hunks.
 */
export function parseDiff(text, file) {
    const sections = new Map();
    let hunks;
    let hunk;
    let oldLeft = 0;
    let newLeft = 0;
    const lines = text.split("\n");
    if (lines.at(-1) === "") lines.pop();
    for (const line of lines) {
        if (oldLeft > 0 || newLeft > 0) {
            const op = line[0];
            if (op === " " || op === "-") oldLeft--;
            if (op === " " || op === "+") newLeft--;
            if (!" -+".includes(op) || oldLeft < 0 || newLeft < 0) {
                throw new Error(`${file}: a hunk line that does not fit its ranges: ${line}`);
            }

            hunk.lines.push(line);
        } else if (line.startsWith("--- ")) {
            continue;
        } else if (line.startsWith("+++ ")) {
            hunks = [];
            sections.set(line.slice(4), hunks);
        } else {
            const m = /^@@ -(\d+)(?:,(\d+))? \+\d+(?:,(\d+))? @@/.exec(line);
            if (m === null || hunks === undefined) throw new Error(`${file}: expected a header or a hunk, not ${line}`);
            oldLeft = m[2] === undefined ? 1 : Number(m[2]);
            newLeft = m[3] === undefined ? 1 : Number(m[3]);
            // An empty range starts after its line.
            hunk = { start: Number(m[1]) + (oldLeft === 0 ? 1 : 0), lines: [] };
            hunks.push(hunk);
        }
    }

    if (oldLeft > 0 || newLeft > 0) throw new Error(`${file}: the last hunk is cut short`);
    return sections;
}

/** The hunks that turn `before` into `after` (arrays of lines), as `diff -U3` prints them. */
export function unifiedDiff(before, after) {
    const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "qt-intended-"));
    const a = path.join(tmp, "a");
    const b = path.join(tmp, "b");
    fs.writeFileSync(a, before.map((l) => `${l}\n`).join(""));
    fs.writeFileSync(b, after.map((l) => `${l}\n`).join(""));
    let diff = "";
    try {
        execFileSync("diff", ["-U3", a, b], { encoding: "utf8", maxBuffer: 1 << 28 });
    } catch (e) {
        if (e.status !== 1) throw e;
        diff = e.stdout;
    } finally {
        fs.rmSync(tmp, { recursive: true, force: true });
    }

    return diff.split("\n").slice(2).join("\n");
}

/** The corpus scenario's expected result: the golden case's `.intended` changes applied to the reference's files. */
function applyGolden(caseId, outcome) {
    const caseDir = path.join(goldenDir, caseId);
    // The CLI writes the files next to its `--out`, the API names them.
    const { args } = JSON.parse(fs.readFileSync(path.join(caseDir, "case.json"), "utf8")).steps[0];
    const out = args[args.indexOf("--out") + 1];
    const corrected = structuredClone(outcome);
    let changed = 0;
    for (const [name, file] of corrected.ok?.$map ?? []) {
        const recorded = path.join(caseDir, "step0", path.dirname(out), name);
        const intended = `${path.join(goldenIntendedDir, path.relative(goldenDir, recorded))}.intended`;
        if (!fs.existsSync(intended)) continue;
        const read = (f) => fs.readFileSync(f, "utf8").split("\n");
        const diff = unifiedDiff(read(recorded), read(intended));
        const [hunks] = parseDiff(`+++ ${name}\n${diff}`, name).values();
        file.lines = applyHunks(file.lines, hunks, `${name}.intended`);
        changed++;
    }

    if (changed === 0) throw new Error(`no file of the result has an .intended copy in tests/intended/${caseId}/step0`);
    return corrected;
}

/** The scenario's expected result: the reference's with intended/<id>.diff applied. */
function applyStoredDiff(id, outcome) {
    const file = diffPath(id);
    if (!fs.existsSync(file)) throw new Error(`no ${path.relative(repositoryRoot, file)} (run.mjs --record-intended writes it)`);
    const corrected = structuredClone(outcome);
    for (const [jsonPath, hunks] of parseDiff(fs.readFileSync(file, "utf8"), file)) {
        const { parent, key, current } = locate(corrected, jsonPath);
        if (!Array.isArray(current)) throw new Error(`${file}: the result has no ${jsonPath}`);
        parent[key] = applyHunks(current, hunks, `${file}: ${jsonPath}`);
    }

    return corrected;
}

/** Writes intended/<id>.diff: how `actual`'s `lines` arrays differ from `expected`'s. */
function recordDiff(id, expected, actual) {
    const before = linesArrays(expected);
    const sections = [];
    for (const [jsonPath, lines] of linesArrays(actual)) {
        const old = before.get(jsonPath);
        if (old === undefined || old.join("\n") === lines.join("\n")) continue;
        sections.push(`--- ${jsonPath}\n+++ ${jsonPath}\n${unifiedDiff(old, lines)}`);
    }

    const file = diffPath(id);
    fs.mkdirSync(path.dirname(file), { recursive: true });
    fs.writeFileSync(file, sections.join(""));
}

/**
 * The intended difference of scenario `id`, if it has one: the bugs, and
 * `expected(reference outcome)`, the outcome it must have.
 */
export function intendedDifference(id) {
    const bugs = list.get(`npm/${id}`);
    if (bugs === undefined && id.startsWith("corpus/")) {
        const caseId = id.slice("corpus/".length);
        const caseBugs = list.get(caseId);
        return caseBugs && { bugs: caseBugs, expected: (outcome) => applyGolden(caseId, outcome) };
    }

    return (
        bugs && {
            bugs,
            expected: (outcome) => applyStoredDiff(id, outcome),
            record: (outcome, actual) => recordDiff(id, outcome, actual),
        }
    );
}
