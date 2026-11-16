#!/usr/bin/env node
// Removes the generated files from tests/golden: everything but the files
// in git (REFERENCE, package.json, .gitignore) and Turborepo's logs.
//
//   node xtask/golden/clean.mjs          unless tests/golden is exactly a
//                                        generated corpus of the commit
//                                        REFERENCE pins
//   node xtask/golden/clean.mjs --force  always
//
// Turborepo runs it before it replays a cached corpus (turbo.json's
// golden#clean), so that a replay never mixes with files of another
// quicktype commit or with leftovers. A corpus that is already the pinned
// commit's, complete and nothing else, is kept: the replay writes the same
// files over it. generate.mjs empties tests/golden itself.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { generatedCases } from "./state.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));

/** tests/golden. */
export const goldenDir = path.join(here, "..", "..", "tests", "golden");

/** What tests/golden keeps: the files in git, and Turborepo's logs. */
const KEPT = new Set([".gitignore", "package.json", "REFERENCE", ".turbo"]);

/** Removes everything generated from `dir` (tests/golden). */
export function cleanGolden(dir = goldenDir) {
    for (const name of fs.readdirSync(dir)) {
        if (!KEPT.has(name)) fs.rmSync(path.join(dir, name), { recursive: true, force: true });
    }
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
    let keep = false;
    if (!process.argv.includes("--force")) {
        try {
            const cases = generatedCases();
            console.log(`tests/golden: ${cases.length} cases of the pinned quicktype commit, complete; kept`);
            keep = true;
        } catch (error) {
            console.log(`tests/golden: ${error.message.replace(/: run .*$/, "")}; emptied`);
        }
    }
    if (!keep) cleanGolden();
}
