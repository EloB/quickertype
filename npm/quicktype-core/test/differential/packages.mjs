// The two copies of quicktype-core a differential run compares.
//
// * reference: the TypeScript quicktype-core, built, from a quicktype
//   checkout: $QUICKTYPE_REFERENCE (the checkout's root), or ../quicktype
//   or ../../quicktype next to this repository. With
//   QUICKTYPE_REFERENCE=self, or when no checkout is found, the reference
//   is this package's own TypeScript engine (the vendored, unmodified
//   quicktype-core sources), selected with the engine switch.
// * ours: this package (dist/), with every eligible run on WebAssembly.

import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const require = createRequire(import.meta.url);
export const packageRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "..");
export const repositoryRoot = path.resolve(packageRoot, "..", "..");
export const inputsDir = path.join(repositoryRoot, "tests", "inputs");
export const goldenDir = path.join(repositoryRoot, "tests", "golden");

const engineKey = Symbol.for("quicktype-core.engine");

function findReferenceCheckout() {
    const configured = process.env.QUICKTYPE_REFERENCE;
    if (configured === "self") return undefined;
    const candidates =
        configured !== undefined
            ? [configured]
            : [path.join(repositoryRoot, "..", "quicktype"), path.join(repositoryRoot, "..", "..", "quicktype")];
    for (const candidate of candidates) {
        const dist = path.join(candidate, "packages", "quicktype-core", "dist", "index.js");
        if (fs.existsSync(dist)) return path.resolve(candidate);
    }

    if (configured !== undefined) {
        throw new Error(`QUICKTYPE_REFERENCE=${configured} has no built packages/quicktype-core/dist`);
    }

    return undefined;
}

function withEngine(mode, f) {
    return async () => {
        const saved = globalThis[engineKey];
        globalThis[engineKey] = mode;
        try {
            return await f();
        } finally {
            globalThis[engineKey] = saved;
        }
    };
}

export function loadPackages() {
    const oursQt = require(packageRoot);
    const stats = require(path.join(packageRoot, "dist", "native", "bridge.js")).engineStats;
    // JSON samples are read on the engine once it is compiled (a small
    // sample does not compile it: src/native/samples.ts), so it is compiled
    // here, as in a process that has run before: every scenario's samples
    // are then the engine's to read.
    require(path.join(packageRoot, "dist", "native", "engine.js")).engineSync();
    const checkout = findReferenceCheckout();
    const reference =
        checkout === undefined
            ? {
                  label: "self (this package's TypeScript engine)",
                  root: packageRoot,
                  qt: oursQt,
                  wrap: (f) => withEngine("ts", f),
              }
            : {
                  label: path.join(checkout, "packages", "quicktype-core"),
                  root: path.join(checkout, "packages", "quicktype-core"),
                  qt: require(path.join(checkout, "packages", "quicktype-core")),
                  wrap: (f) => f,
              };
    const ours = { label: packageRoot, root: packageRoot, qt: oursQt, wrap: (f) => withEngine("wasm", f), stats };
    return { reference, ours, checkout };
}
