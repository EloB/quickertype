// What release/bundle-typescript.mjs, check-release.mjs and check-bundle.mjs
// share: the pins, the checks of a TypeScript platform package against
// them, and unpacking an archive the way the installers do.

import { spawnSync } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { crc32, inflateRawSync } from "node:zlib";

const here = path.dirname(fileURLToPath(import.meta.url));

/** release/typescript/pins.json, which git tracks in the bundle directory. */
export const pinsFile = path.join(here, "typescript", "pins.json");

/** The pins as text (what an archive's `typescript/pins.json` must equal) and parsed. */
export function readPins() {
    const text = fs.readFileSync(pinsFile, "utf8");
    return { text, pins: JSON.parse(text) };
}

export const sha256 = (bytes) => createHash("sha256").update(bytes).digest("hex");

/** The compiler in a platform package, relative to it: `lib/tsc` or `lib/tsc.exe`. */
export const compilerPath = (key) => `lib/${key.startsWith("win32-") ? "tsc.exe" : "tsc"}`;

/** The pinned package of a release target: `[key, pin]`. */
export function packageOf(pins, target) {
    const entry = Object.entries(pins.packages).find(([, pin]) => pin.targets.includes(target));
    if (!entry) throw new Error(`no TypeScript platform package is pinned for ${target}`);
    return entry;
}

/** The target of a file dist names `quickertype-<target>.<ext>`. */
export function targetOf(file) {
    const match = /^quickertype-(.+?)\.(tar\.xz|zip|msi)$/.exec(path.basename(file));
    if (!match) throw new Error(`${file} is not named quickertype-<target>.tar.xz, .zip or .msi`);
    return match[1];
}

/**
 * How the platform package in `dir` differs from the pinned `pin` (of
 * `key`, such as `darwin-arm64`): its package.json's name and version, its
 * LICENSE and NOTICE.txt, and its compiler's presence, SHA-256 and, where
 * the package is not a Windows one and this machine records file modes
 * (not on Windows), execute bits. Paths in the messages are relative to
 * `dir`; no failures means it is the pinned package.
 */
export function packageFailures(dir, pins, key, pin) {
    const failures = [];
    const isFile = (relative) => fs.statSync(path.join(dir, relative), { throwIfNoEntry: false })?.isFile() ?? false;
    try {
        const manifest = JSON.parse(fs.readFileSync(path.join(dir, "package.json"), "utf8"));
        if (manifest.name !== pin.name || manifest.version !== pins.version) {
            failures.push(`package.json is ${manifest.name}@${manifest.version}, not ${pin.name}@${pins.version}`);
        }
    } catch (error) {
        failures.push(`package.json: ${error.code === "ENOENT" ? "missing" : error.message}`);
    }
    for (const file of ["LICENSE", "NOTICE.txt"]) {
        if (!isFile(file)) failures.push(`${file} is missing`);
    }
    const compiler = compilerPath(key);
    if (!isFile(compiler)) {
        failures.push(`${compiler} is missing`);
        return failures;
    }
    const tsc = path.join(dir, ...compiler.split("/"));
    const hash = sha256(fs.readFileSync(tsc));
    if (hash !== pin.tscSha256) failures.push(`${compiler} has the SHA-256 ${hash}, not the pinned ${pin.tscSha256}`);
    if (!key.startsWith("win32-") && process.platform !== "win32" && (fs.statSync(tsc).mode & 0o111) === 0) {
        failures.push(`${compiler} is not executable`);
    }
    return failures;
}

/** `relative` (`/`-separated, from an archive) under `root`, refusing absolute paths and `..`. */
function inside(root, relative) {
    const parts = relative.replace(/\/+$/, "").split("/");
    if (relative.startsWith("/") || /^[A-Za-z]:/.test(relative) || parts.some((p) => p === ".." || p === "")) {
        throw new Error(`unexpected path in the archive: ${relative}`);
    }
    return path.join(root, ...parts);
}

/**
 * The entries of the zip archive `file`: `{ name, directory, data, mode }`,
 * `mode` being the Unix mode when the archive records one. A small reader
 * (stored and deflated entries, no ZIP64 or encryption, each checked
 * against its CRC-32), so unpacking a zip needs no tool that one machine
 * may lack.
 */
export function readZip(file) {
    const zip = fs.readFileSync(file);
    let end = -1;
    for (let i = zip.length - 22; i >= Math.max(0, zip.length - 22 - 0xffff); i--) {
        if (zip.readUInt32LE(i) === 0x06054b50) {
            end = i;
            break;
        }
    }
    if (end < 0) throw new Error(`${file} is not a zip archive`);
    const count = zip.readUInt16LE(end + 10);
    let offset = zip.readUInt32LE(end + 16);
    if (count === 0xffff || offset === 0xffffffff) throw new Error(`${file} is a ZIP64 archive, which this reader does not read`);
    const entries = [];
    for (let n = 0; n < count; n++) {
        if (zip.readUInt32LE(offset) !== 0x02014b50) throw new Error(`${file}: broken central directory`);
        const madeBy = zip.readUInt16LE(offset + 4) >> 8;
        const flags = zip.readUInt16LE(offset + 8);
        const method = zip.readUInt16LE(offset + 10);
        const crc = zip.readUInt32LE(offset + 16);
        const compressedSize = zip.readUInt32LE(offset + 20);
        const size = zip.readUInt32LE(offset + 24);
        const nameLength = zip.readUInt16LE(offset + 28);
        const extraLength = zip.readUInt16LE(offset + 30);
        const commentLength = zip.readUInt16LE(offset + 32);
        const external = zip.readUInt32LE(offset + 38);
        const local = zip.readUInt32LE(offset + 42);
        const name = zip.subarray(offset + 46, offset + 46 + nameLength).toString("utf8");
        offset += 46 + nameLength + extraLength + commentLength;
        if (flags & 1) throw new Error(`${file}: ${name} is encrypted`);
        if (zip.readUInt32LE(local) !== 0x04034b50) throw new Error(`${file}: broken local header of ${name}`);
        const start = local + 30 + zip.readUInt16LE(local + 26) + zip.readUInt16LE(local + 28);
        const raw = zip.subarray(start, start + compressedSize);
        const directory = name.endsWith("/");
        let data;
        if (method === 0) data = raw;
        else if (method === 8) data = inflateRawSync(raw);
        else throw new Error(`${file}: ${name} uses compression method ${method}`);
        if (data.length !== size || crc32(data) !== crc) throw new Error(`${file}: ${name} does not match its size and CRC-32`);
        const mode = madeBy === 3 ? (external >>> 16) & 0o7777 : undefined;
        entries.push({ name, directory, data, mode });
    }
    return entries;
}

/**
 * Unpacks `archive` into the new directory `into` as the installers do and
 * returns the directory with quickertype in it: a .tar.xz (with `tar`,
 * which reads xz wherever release archives are checked) has one top-level
 * directory, a .zip (with readZip) none.
 */
export function unpackArchive(archive, into) {
    fs.mkdirSync(into, { recursive: true });
    if (archive.endsWith(".zip")) {
        for (const entry of readZip(archive)) {
            const target = inside(into, entry.name);
            if (entry.directory) {
                fs.mkdirSync(target, { recursive: true });
                continue;
            }
            fs.mkdirSync(path.dirname(target), { recursive: true });
            fs.writeFileSync(target, entry.data);
            if (entry.mode !== undefined && process.platform !== "win32") fs.chmodSync(target, entry.mode & 0o777);
        }
    } else {
        const run = spawnSync("tar", ["-xf", path.resolve(archive), "-C", into], { stdio: "inherit" });
        if (run.status !== 0) throw new Error(`tar -xf ${archive} failed`);
    }
    const top = fs.readdirSync(into);
    const single = top.length === 1 && fs.statSync(path.join(into, top[0])).isDirectory();
    return single ? path.join(into, top[0]) : into;
}
