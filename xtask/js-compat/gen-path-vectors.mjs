#!/usr/bin/env node
// Records test vectors for quicktype_js_compat::path_win32 and ::path_posix
// from Node's path.win32 and path.posix (the `path` module Node uses on
// Windows and everywhere else; any OS can run both).
//
// usage: node xtask/js-compat/gen-path-vectors.mjs
//
// Output: crates/quicktype-js-compat/tests/vectors/path_win32.json and
// path_posix.json. The inputs are curated: drive, UNC, device and relative
// paths with both separators, dots, reserved device names and colons, and
// for POSIX also repeated slashes and `..` above the root. Re-running the
// script reproduces the files for the same Node version.

import { writeFileSync } from "node:fs";
import { dirname, join, posix, resolve, win32 } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");

function record(path, inputs, joins) {
    return {
        node: process.version,
        paths: inputs.map((p) => ({
            path: p,
            isAbsolute: path.isAbsolute(p),
            dirname: path.dirname(p),
            basename: path.basename(p),
            extname: path.extname(p),
            normalize: path.normalize(p),
        })),
        joins: joins.map(([a, b]) => ({ args: [a, b], join: path.join(a, b) })),
    };
}

function write(name, vectors) {
    const out = join(repoRoot, `crates/quicktype-js-compat/tests/vectors/${name}.json`);
    writeFileSync(out, JSON.stringify(vectors, null, 1) + "\n");
    console.log(`${out}: ${vectors.paths.length} paths, ${vectors.joins.length} joins (Node ${process.version})`);
}

function cross(as, bs) {
    const pairs = [];
    for (const a of as) for (const b of bs) pairs.push([a, b]);
    return pairs;
}

const tails = [
    "", "a", "a\\b", "a/b", "a\\b\\", "a/b/", "a\\\\b", "..", "..\\a", "a\\..\\..\\b", ".\\a\\.\\b", "a.json", "a.b.json",
    "dir\\file.schema.json", ".hidden", "..\\..", "a\\.", "a\\..", "x.", "x..", "...", "a b\\c d.ts",
    "CON", "con:", "CON:x", "COM1:\\x", "LPT\u00b9:", "nul.txt", "a:b", "x\\y:", "x:\\y", "😀\\é.json", "CON😀",
];

// path.win32
{
    const roots = ["", "C:", "C:\\", "c:/", "\\", "/", "\\\\server\\share", "//server/share/", "\\\\?\\C:\\", "\\\\.\\PHYSICALDRIVE0", "\\\\server", "//", "///x"];
    const inputs = [];
    for (const root of roots) for (const tail of tails) inputs.push(root + tail);
    inputs.push("C:\\Users\\RUNNER~1\\AppData\\Local\\Temp\\x\\a.json", "D:\\a\\q\\crates\\quicktype-cli/../../tests/inputs\\json/samples\\simple-object.json", "file.json", ".", "..", "C", "C:x\\y", "\\\\.\\COM1:\\x", "\\\\?\\CON:");
    const joins = cross(
        ["", "C:\\dir", "C:\\dir\\", "c:/dir/sub", "\\\\server\\share", "//server", "\\", "\\\\", "dir", "..", "C:", "/x"],
        ["", "a.json", "..\\b.json", "../../c", "\\abs", "C:\\other", "sub\\..\\d", "CON:", "share", "x:"],
    );
    write("path_win32", record(win32, [...new Set(inputs)], joins));
}

// path.posix
{
    const roots = ["", "/", "//", "///", ".", "./", "..", "../", "a/", "/a//b/", "C:\\", "\\\\server\\share\\"];
    const posixTails = [
        "a/b/c.ts", "a//b", "a/./b", "a/../b", "a/../../b", "../../a", "./", "../", "a/", "a//", ".b.c", "a/.b.c",
        "foo.", "dir.x/foo", "a.b/", "a/b.c/", "..a/..", "a../b", ".../x", "a/b/../..", "a/b/../../..",
    ];
    const inputs = [];
    for (const root of roots) for (const tail of [...tails, ...posixTails]) inputs.push(root + tail);
    inputs.push("/tmp/quicktype-node-io-1/a.json", "/Users/x/Library/a b/c.d.json", "file.json", ".", "..", "/", "//", "///", "/..", "/../a");
    const joins = cross(
        ["", "/", "//", "/a/b", "/a/b/", "a", "a/", "./dir//sub/", "..", "a/b/..", ".", "C:\\dir"],
        ["", "x.json", "../x", "../../../c", "/abs", "..", "a/b/", "./", "b\\c", "//x"],
    );
    write("path_posix", record(posix, [...new Set(inputs)], joins));
}
