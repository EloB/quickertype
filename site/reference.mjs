// The quicktype commit whose output this repository matches, as the
// playground names it: `quicktype_commit` in tests/golden/REFERENCE, and the
// commit's date (UTC), which is kept here. Used by site/build.mjs (the
// page's footer) and site/test/smoke.mjs.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const reference = path.join(path.dirname(fileURLToPath(import.meta.url)), "..", "tests", "golden", "REFERENCE");

/** The dates of the quicktype commits REFERENCE names. A new commit there needs its date here. */
const commitDates = {
    c39af7d303b025280e2668a1b2d29913093593c9: "2026-09-08",
};

/** The commit in tests/golden/REFERENCE: `{ commit, short, date }`. */
export function quicktypeReference() {
    const commit = /^quicktype_commit=([0-9a-f]{40})\r?$/m.exec(fs.readFileSync(reference, "utf8"))?.[1];
    if (commit === undefined) throw new Error(`${reference} has no quicktype_commit`);
    const date = commitDates[commit];
    if (date === undefined) {
        throw new Error(`the date of quicktype commit ${commit} (tests/golden/REFERENCE) is not in site/reference.mjs`);
    }

    return { commit, short: commit.slice(0, 7), date };
}
