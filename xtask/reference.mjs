// Where the Node scripts in xtask/ find the reference quicktype checkout:
// the path given on the command line, else $QUICKTYPE_REFERENCE, else the
// deprecated $QUICKTYPE_REF or $QUICKTYPE_DIR (with a one-line warning on
// stderr), else the first of ../quicktype and ../../quicktype next to this
// repository that is built (has packages/quicktype-core/dist), as
// npm/quicktype-core's differential tests look. `cargo xtask diff`/`bench`
// (xtask/src/diff.rs) and `cargo xtask golden` (xtask/golden/record.sh) look
// in the same order, for a built CLI (dist/index.js).
//
// Unlike the npm differential suite, these scripts need a real checkout:
// QUICKTYPE_REFERENCE=self (that suite's comparison with the package's own
// TypeScript engine) is an error here, and so is finding no built checkout.

import { existsSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");

function fail(message) {
    console.error(message);
    process.exit(2);
}

/**
 * $QUICKTYPE_REFERENCE, or one of its deprecated names $QUICKTYPE_REF and
 * $QUICKTYPE_DIR; `undefined` if none is set.
 */
export function referenceFromEnvironment() {
    const current = process.env.QUICKTYPE_REFERENCE;
    if (current === "self") {
        fail(
            "QUICKTYPE_REFERENCE=self only applies to the npm differential suite; " +
                "set it to a quicktype checkout",
        );
    }
    if (current) return current;
    for (const name of ["QUICKTYPE_REF", "QUICKTYPE_DIR"]) {
        const old = process.env[name];
        if (old) {
            console.error(`warning: ${name} is deprecated; set QUICKTYPE_REFERENCE instead`);
            return old;
        }
    }
    return undefined;
}

/** The absolute path of the reference checkout; `given` is the script's argument, if any. */
export function referenceCheckout(given) {
    const chosen = given ?? referenceFromEnvironment();
    if (chosen !== undefined) return resolve(chosen);
    const candidates = [join(repoRoot, "..", "quicktype"), join(repoRoot, "..", "..", "quicktype")];
    const built = candidates.find((c) => existsSync(join(c, "packages", "quicktype-core", "dist")));
    if (built === undefined) {
        fail(
            `no built quicktype checkout (with packages/quicktype-core/dist) at ${candidates.join(" or ")}: ` +
                "build one, set QUICKTYPE_REFERENCE or pass its path",
        );
    }
    return built;
}
