// Where the Node scripts in xtask/ find the reference quicktype checkout:
// the path given on the command line, else $QUICKTYPE_REFERENCE, else
// ../quicktype or ../../quicktype next to this repository (the first that
// exists), as in npm/quicktype-core's tests. `cargo xtask diff` and
// `cargo xtask golden` read $QUICKTYPE_REFERENCE too.
//
// $QUICKTYPE_DIR, the old name of $QUICKTYPE_REFERENCE, still works but
// prints a note on stderr.

import { existsSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");

/** $QUICKTYPE_REFERENCE, or the deprecated $QUICKTYPE_DIR; `undefined` if neither is set. */
export function referenceFromEnvironment() {
    const current = process.env.QUICKTYPE_REFERENCE;
    if (current) return current;
    const old = process.env.QUICKTYPE_DIR;
    if (old) {
        console.error("warning: QUICKTYPE_DIR is deprecated; set QUICKTYPE_REFERENCE instead");
        return old;
    }
    return undefined;
}

/** The absolute path of the reference checkout; `given` is the script's argument, if any. */
export function referenceCheckout(given) {
    const chosen = given ?? referenceFromEnvironment();
    if (chosen !== undefined) return resolve(chosen);
    const candidates = [join(repoRoot, "..", "quicktype"), join(repoRoot, "..", "..", "quicktype")];
    return candidates.find((c) => existsSync(join(c, "package.json"))) ?? candidates[0];
}
