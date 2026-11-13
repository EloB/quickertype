// Keeps src/ a verbatim copy of quicktype's packages/quicktype-core/src,
// except for Run.ts (which hands eligible runs to the WebAssembly engine),
// input/CompressedJSON.ts (whose `CompressedJSONFromString.parseSync` lets
// the engine read JSON samples) and src/native/ (the bridge).
//
//   node script/sync-upstream.mjs [--check | --accept] [QUICKTYPE_CHECKOUT]
//
// The checkout defaults to $QUICKTYPE_REFERENCE, ../quicktype or
// ../../quicktype next to this repository. Without --check, upstream files
// are copied over (and files that no longer exist upstream are removed);
// with --check, differences are listed and the exit code is 1 if there
// are any. Either way, if upstream changed one of the files src/native
// depends on (their hashes are in src/native/UPSTREAM.json: Run.ts and
// input/CompressedJSON.ts, which are modified here, and the files whose
// internals the bridge reads), the script says so and exits 1: port the
// change to a modified file by hand, review the bridge, then record the
// new hashes with --accept.

import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const repositoryRoot = path.join(packageRoot, "..", "..");
const args = process.argv.slice(2);
const check = args.includes("--check");
const accept = args.includes("--accept");
const given = args.find((a) => !a.startsWith("--")) ?? process.env.QUICKTYPE_REFERENCE;
const candidates = given !== undefined ? [given] : [path.join(repositoryRoot, "..", "quicktype"), path.join(repositoryRoot, "..", "..", "quicktype")];
const checkout = candidates.find((c) => fs.existsSync(path.join(c, "packages", "quicktype-core", "src", "index.ts")));
if (checkout === undefined) {
    console.error(`no quicktype checkout found (tried ${candidates.join(", ")})`);
    process.exit(2);
}

const upstreamRoot = path.join(checkout, "packages", "quicktype-core");
const upstreamMeta = JSON.parse(fs.readFileSync(path.join(packageRoot, "src", "native", "UPSTREAM.json"), "utf8"));
const sha256 = (file) => createHash("sha256").update(fs.readFileSync(file)).digest("hex");

/** Paths relative to `root`, recursively. */
function listFiles(root, relative = "") {
    const files = [];
    for (const entry of fs.readdirSync(path.join(root, relative), { withFileTypes: true })) {
        const child = path.join(relative, entry.name);
        if (entry.isDirectory()) files.push(...listFiles(root, child));
        else files.push(child);
    }

    return files.sort();
}

// Files that are modified here.
const modified = [path.join("src", "Run.ts"), path.join("src", "input", "CompressedJSON.ts")];

// Files that are ours, not upstream's.
const local = (file) => modified.includes(file) || file.startsWith(path.join("src", "native") + path.sep);

const upstreamFiles = [
    ...listFiles(path.join(upstreamRoot, "src")).map((f) => path.join("src", f)),
    "tsconfig.json",
    "tsconfig.esm.json",
    path.join("script", "write-esm-package-json.mjs"),
];
const differences = [];
for (const file of upstreamFiles) {
    if (local(file)) continue;
    const from = path.join(upstreamRoot, file);
    const to = path.join(packageRoot, file);
    if (fs.existsSync(to) && fs.readFileSync(to).equals(fs.readFileSync(from))) continue;
    differences.push(`${fs.existsSync(to) ? "changed" : "missing"}: ${file}`);
    if (!check) {
        fs.mkdirSync(path.dirname(to), { recursive: true });
        fs.copyFileSync(from, to);
    }
}

const upstreamSet = new Set(upstreamFiles);
for (const file of listFiles(path.join(packageRoot, "src")).map((f) => path.join("src", f))) {
    if (local(file) || upstreamSet.has(file)) continue;
    differences.push(`not upstream: ${file}`);
    if (!check) fs.rmSync(path.join(packageRoot, file));
}

for (const d of differences) console.log(d);
let status = check && differences.length > 0 ? 1 : 0;
let changedGuarded = false;
for (const [file, recorded] of Object.entries(upstreamMeta.guarded)) {
    const now = sha256(path.join(upstreamRoot, file));
    if (now === recorded) continue;
    changedGuarded = true;
    if (accept) {
        upstreamMeta.guarded[file] = now;
        continue;
    }

    console.log(
        modified.includes(path.normalize(file))
            ? `${file} changed upstream since ${upstreamMeta.commit}: port the change into ${file} by hand`
            : `${file} changed upstream since ${upstreamMeta.commit}: src/native depends on it; review the bridge`,
    );
    status = 1;
}

if (accept && changedGuarded) {
    fs.writeFileSync(
        path.join(packageRoot, "src", "native", "UPSTREAM.json"),
        `${JSON.stringify(upstreamMeta, undefined, 4)}\n`,
    );
    console.log("recorded the new hashes in src/native/UPSTREAM.json (update its commit too)");
}

console.log(
    `${checkout}: ${upstreamFiles.length} upstream files, ${differences.length} ${check ? "differ" : "updated"}`,
);
process.exit(status);
