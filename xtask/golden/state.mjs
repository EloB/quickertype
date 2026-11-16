// The state of tests/golden, for the tools that read it.
//
// tests/golden/REFERENCE (in git) pins the quicktype commit (and the Node
// major version) the corpus is generated from. tests/golden/GENERATED
// (written by generate.mjs, with the cases) says what was generated: the
// commit and the number of cases. A corpus that is missing, of another
// commit, or mixed with another's leftovers is refused with what to run.

import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(here, "..", "..");

/** How to (re)generate tests/golden, for error messages. */
export const HOW_TO_GENERATE = "run `npm run golden` (docs/ARCHITECTURE.md, \"The golden corpus\")";

/**
 * A digest of what the corpus is generated from: tests/golden/REFERENCE,
 * the generator (xtask/golden) and tests/inputs, the files turbo.json
 * names as golden#generate's inputs (but Finder's .DS_Store). The same
 * inputs give the same corpus, byte for byte.
 */
export function inputsDigest(root = repositoryRoot) {
    const files = [path.join("tests", "golden", "REFERENCE")];
    const walk = (rel) => {
        const entries = fs.readdirSync(path.join(root, rel), { withFileTypes: true });
        for (const e of entries) {
            const child = path.join(rel, e.name);
            if (e.isDirectory()) walk(child);
            else if (e.isFile() && e.name !== ".DS_Store") files.push(child);
        }
    };
    walk(path.join("xtask", "golden"));
    walk(path.join("tests", "inputs"));
    const hash = createHash("sha256");
    for (const file of files.map((f) => f.split(path.sep).join("/")).sort()) {
        const bytes = fs.readFileSync(path.join(root, file));
        hash.update(`${file}\0${bytes.length}\0`).update(bytes);
    }
    return hash.digest("hex");
}

/** `key=value` lines. */
function readKeyValues(file) {
    const values = {};
    for (const line of fs.readFileSync(file, "utf8").split("\n")) {
        const at = line.indexOf("=");
        if (at > 0) values[line.slice(0, at).trim()] = line.slice(at + 1).trim();
    }
    return values;
}

/** tests/golden/REFERENCE: `{ commit, node }`. */
export function readReference(root = repositoryRoot) {
    const file = path.join(root, "tests", "golden", "REFERENCE");
    const { quicktype_commit: commit, node } = readKeyValues(file);
    if (!/^[0-9a-f]{40}$/.test(commit ?? "")) throw new Error(`${file}: no quicktype_commit=<40 hex digits>`);
    if (!/^v\d+\./.test(node ?? "")) throw new Error(`${file}: no node=v<version>`);
    return { commit, node };
}

/**
 * The generated corpus, checked against REFERENCE: `{ dir, commit, cases }`.
 * Throws, saying what to run, if tests/golden is not generated or was
 * generated from another quicktype commit.
 */
export function readGenerated(root = repositoryRoot) {
    const dir = path.join(root, "tests", "golden");
    const file = path.join(dir, "GENERATED");
    if (!fs.existsSync(file)) throw new Error(`tests/golden is not generated: ${HOW_TO_GENERATE}`);
    const { quicktype_commit: commit, cases } = readKeyValues(file);
    const reference = readReference(root);
    if (commit !== reference.commit) {
        throw new Error(
            `tests/golden was generated from quicktype ${commit}, but tests/golden/REFERENCE pins ${reference.commit}: ${HOW_TO_GENERATE}`,
        );
    }
    const count = Number(cases);
    if (!Number.isInteger(count) || count <= 0) throw new Error(`${file}: no cases=<number>`);
    return { dir, commit, cases: count, inputs: readKeyValues(file).inputs };
}

/**
 * The directories below `dir` that hold a case.json, relative to it, in
 * the order of a walk that visits each directory's entries by name (a
 * case's own directories are not searched further).
 */
export function caseDirs(dir) {
    const out = [];
    const byName = (a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0);
    const walk = (rel) => {
        const entries = fs.readdirSync(path.join(dir, rel), { withFileTypes: true }).sort(byName);
        if (rel !== "" && entries.some((e) => e.isFile() && e.name === "case.json")) {
            out.push(rel);
            return;
        }
        for (const e of entries) if (e.isDirectory() && e.name !== ".turbo") walk(rel ? path.join(rel, e.name) : e.name);
    };
    walk("");
    return out;
}

/**
 * The generated corpus's case directories (relative to tests/golden, in
 * caseDirs' order), after checking that they are exactly the ones
 * generated: no fewer (an interrupted restore) and no more (leftovers of
 * another commit).
 */
export function generatedCases(root = repositoryRoot) {
    const { dir, cases } = readGenerated(root);
    const found = caseDirs(dir);
    if (found.length !== cases) {
        throw new Error(`tests/golden has ${found.length} cases, but ${cases} were generated: ${HOW_TO_GENERATE}`);
    }
    return found;
}
