#!/usr/bin/env node
// Removes the generated files from tests/golden: everything but the files
// in git (REFERENCE, package.json, .gitignore) and Turborepo's logs.
//
//   node xtask/golden/clean.mjs
//
// `npm run golden` runs this before Turborepo replays a cached result, so
// that tests/golden never mixes files of two quicktype commits.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

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
    cleanGolden();
}
