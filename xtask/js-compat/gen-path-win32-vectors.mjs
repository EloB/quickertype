#!/usr/bin/env node
// Records test vectors for quicktype_js_compat::path_win32 from Node's
// path.win32 (the `path` module Node uses on Windows; any OS can run it).
//
// usage: node xtask/js-compat/gen-path-win32-vectors.mjs
//
// Output: crates/quicktype-js-compat/tests/vectors/path_win32.json. The
// inputs are curated: drive, UNC, device and relative paths with both
// separators, dots, reserved device names and colons. Re-running the script
// reproduces the file for the same Node version.

import { writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { win32 } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");

const roots = ["", "C:", "C:\\", "c:/", "\\", "/", "\\\\server\\share", "//server/share/", "\\\\?\\C:\\", "\\\\.\\PHYSICALDRIVE0", "\\\\server", "//", "///x"];
const tails = [
    "", "a", "a\\b", "a/b", "a\\b\\", "a/b/", "a\\\\b", "..", "..\\a", "a\\..\\..\\b", ".\\a\\.\\b", "a.json", "a.b.json",
    "dir\\file.schema.json", ".hidden", "..\\..", "a\\.", "a\\..", "x.", "x..", "...", "a b\\c d.ts",
    "CON", "con:", "CON:x", "COM1:\\x", "LPT\u00b9:", "nul.txt", "a:b", "x\\y:", "x:\\y", "😀\\é.json", "CON😀",
];
const inputs = [];
for (const root of roots) for (const tail of tails) inputs.push(root + tail);
inputs.push("C:\\Users\\RUNNER~1\\AppData\\Local\\Temp\\x\\a.json", "D:\\a\\q\\crates\\quicktype-cli/../../tests/inputs\\json/samples\\simple-object.json", "file.json", ".", "..", "C", "C:x\\y", "\\\\.\\COM1:\\x", "\\\\?\\CON:");
const unique = [...new Set(inputs)];

const joins = [];
for (const a of ["", "C:\\dir", "C:\\dir\\", "c:/dir/sub", "\\\\server\\share", "//server", "\\", "\\\\", "dir", "..", "C:", "/x"]) {
    for (const b of ["", "a.json", "..\\b.json", "../../c", "\\abs", "C:\\other", "sub\\..\\d", "CON:", "share", "x:"]) {
        joins.push([a, b]);
    }
}

const vectors = {
    node: process.version,
    paths: unique.map((p) => ({
        path: p,
        isAbsolute: win32.isAbsolute(p),
        dirname: win32.dirname(p),
        basename: win32.basename(p),
        extname: win32.extname(p),
        normalize: win32.normalize(p),
    })),
    joins: joins.map(([a, b]) => ({ args: [a, b], join: win32.join(a, b) })),
};

const out = join(repoRoot, "crates/quicktype-js-compat/tests/vectors/path_win32.json");
writeFileSync(out, JSON.stringify(vectors, null, 1) + "\n");
console.log(`${out}: ${vectors.paths.length} paths, ${vectors.joins.length} joins (Node ${process.version})`);
