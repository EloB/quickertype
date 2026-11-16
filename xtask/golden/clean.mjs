#!/usr/bin/env node
// Removes the generated files from tests/golden: everything but the files
// in git (REFERENCE, package.json, turbo.json, .gitignore) and Turborepo's
// logs.
//
//   node xtask/golden/clean.mjs          unless tests/golden is exactly the
//                                        corpus the current inputs give
//   node xtask/golden/clean.mjs --force  always
//
// Turborepo runs it before it replays a cached corpus (the `clean` task of
// tests/golden/turbo.json), so that a replay, which only writes files, never mixes
// with files of another corpus. A corpus generated from the same inputs
// (GENERATED's `inputs`, state.mjs's inputsDigest: the same REFERENCE,
// generator and tests/inputs), complete and nothing else, is kept: the
// replay writes the same files over it. generate.mjs empties tests/golden
// itself.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { generatedCases, inputsDigest, readGenerated } from "./state.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));

/** tests/golden. */
export const goldenDir = path.join(here, "..", "..", "tests", "golden");

/** What tests/golden keeps: the files in git, and Turborepo's logs. */
const KEPT = new Set([".gitignore", "package.json", "turbo.json", "REFERENCE", ".turbo"]);

/** Removes everything generated from `dir` (tests/golden). */
export function cleanGolden(dir = goldenDir) {
    for (const name of fs.readdirSync(dir)) {
        if (!KEPT.has(name)) fs.rmSync(path.join(dir, name), { recursive: true, force: true });
    }
}

// Run as a script (import.meta.url is the real path: compare real paths,
// for a checkout reached through a symbolic link).
if (process.argv[1] && fs.realpathSync(process.argv[1]) === fileURLToPath(import.meta.url)) {
    let keep = false;
    if (!process.argv.includes("--force")) {
        try {
            const cases = generatedCases();
            if (readGenerated().inputs !== inputsDigest()) throw new Error("tests/golden was generated from other inputs");
            console.log(`tests/golden: ${cases.length} cases, generated from the current inputs, complete; kept`);
            keep = true;
        } catch (error) {
            console.log(`tests/golden: ${error.message.replace(/: run .*$/, "")}; emptied`);
        }
    }
    if (!keep) cleanGolden();
}
