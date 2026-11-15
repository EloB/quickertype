// Stages the TypeScript compiler that a release bundles next to quickertype:
// the npm platform package pinned in release/typescript/pins.json,
// downloaded from the npm registry, checked against its pinned
// `dist.integrity` and compiler hash, and unpacked unmodified into
// release/typescript, beside pins.json. That directory is the archives'
// `typescript` directory (`include` in dist-workspace.toml); git ignores
// everything in it but pins.json.
//
//   node release/bundle-typescript.mjs [--run] [<target>...]
//   node release/bundle-typescript.mjs --pin <version>
//
// <target> is a release target (a Rust target triple, as in
// dist-workspace.toml); release.yml passes its job's, through
// .github/actions/stage-typescript. Without one, the package for this
// machine (Node's platform and architecture). Every target must take the
// same package.
//
// The staged compiler is run (`tsc --version` must print the pinned
// version) where this machine can run it: always for its own platform,
// and for another architecture of its OS when the OS can (Rosetta runs
// darwin-x64 on Apple Silicon). With --run it must run, as it does on
// every release runner; without, a compiler this machine cannot run is
// only checked against its hash.
//
// When the staged package is a Windows one, it also writes
// crates/quicktype-cli/wix/bundled.wxs, the WiX fragment that puts it into
// the MSI next to quickertype.exe, with the repository's LICENSE and NOTICE
// in the install directory (main.wxs references its `BundledFiles`
// component group); for any other package it removes that fragment.
//
// Fails, leaving what was staged before, when the download does not match
// its integrity, the package is not the pinned name and version, its
// compiler not the pinned hash, or `tsc --version` not the pinned
// version. A verified tarball is kept in target/tsc-bundle and reused.
//
// --pin <version> rewrites pins.json for another TypeScript release (see
// docs/RELEASING.md): for each pinned package, the registry's tarball URL
// and integrity, checked against the tarball it downloads, and the hash of
// the compiler in it. The packages and their targets stay.

import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { gunzipSync } from "node:zlib";

import { compilerPath, packageFailures, sha256 } from "./package.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(here, "..");
const bundleDir = path.join(here, "typescript");
const pinsName = "pins.json";
const pinsFile = path.join(bundleDir, pinsName);
const stagingDir = path.join(repositoryRoot, "target", "tsc-bundle");
const wxsFile = path.join(repositoryRoot, "crates", "quicktype-cli", "wix", "bundled.wxs");
const registry = "https://registry.npmjs.org/";
const host = `${process.platform}-${process.arch}`;

function fail(message) {
    console.error(`bundle-typescript: ${message}`);
    process.exit(1);
}

function log(message) {
    console.error(`bundle-typescript: ${message}`);
}

/** The pinned package for `targets` (or for this machine): `[key, pin]`. */
function packageFor(pins, targets) {
    if (targets.length === 0) {
        if (!pins.packages[host]) fail(`no TypeScript platform package is pinned for this machine (${host})`);
        return [host, pins.packages[host]];
    }
    const keys = new Set();
    for (const target of targets) {
        const key = Object.keys(pins.packages).find((k) => pins.packages[k].targets.includes(target));
        if (!key) fail(`no TypeScript platform package is pinned for the target ${target} (release/typescript/pins.json)`);
        keys.add(key);
    }
    if (keys.size > 1) fail(`the targets ${targets.join(", ")} need different packages (${[...keys].join(", ")})`);
    const [key] = keys;
    return [key, pins.packages[key]];
}

const tarballUrl = (name, version) => `${registry}${name}/-/${name.split("/").pop()}-${version}.tgz`;

/** Checks a pin's shape: an npm registry tarball of the pinned version. */
function checkPin(pins, key, pin) {
    if (pin.name !== `@typescript/typescript-${key}`) fail(`${key}: the package is named ${pin.name}`);
    if (!Array.isArray(pin.targets) || pin.targets.length === 0) fail(`${key}: targets must list its release targets`);
    const expected = tarballUrl(pin.name, pins.version);
    if (pin.tarball !== expected) fail(`${key}: the tarball must be ${expected}, not ${pin.tarball}`);
    if (!/^sha512-[A-Za-z0-9+/]{86}==$/.test(pin.integrity)) fail(`${key}: the integrity must be a sha512 one`);
    if (!/^[0-9a-f]{64}$/.test(pin.tscSha256 ?? "")) fail(`${key}: tscSha256 must be the compiler's SHA-256, in hex`);
}

const integrityOf = (bytes) => `sha512-${createHash("sha512").update(bytes).digest("base64")}`;

async function fetchWithRetries(url, as) {
    for (let attempt = 1; ; attempt++) {
        try {
            const response = await fetch(url, { redirect: "error" });
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            return as === "json" ? await response.json() : Buffer.from(await response.arrayBuffer());
        } catch (error) {
            if (attempt === 3) fail(`downloading ${url} failed: ${error.message}`);
            await new Promise((resolve) => setTimeout(resolve, 2000 * attempt));
        }
    }
}

/** The tarball `url`, which must have the integrity `integrity`. */
async function download(url, integrity) {
    const cached = path.join(stagingDir, path.basename(new URL(url).pathname));
    if (fs.existsSync(cached)) {
        const bytes = fs.readFileSync(cached);
        if (integrityOf(bytes) === integrity) {
            log(`using ${path.relative(repositoryRoot, cached)}`);
            return bytes;
        }
        fs.rmSync(cached);
    }
    log(`downloading ${url}`);
    const bytes = await fetchWithRetries(url, "bytes");
    const actual = integrityOf(bytes);
    if (actual !== integrity) {
        fail(`${url} does not match its integrity\n  expected: ${integrity}\n  actual:   ${actual}`);
    }
    fs.mkdirSync(stagingDir, { recursive: true });
    fs.writeFileSync(cached, bytes);
    return bytes;
}

/**
 * The regular files and directories of an npm tarball (ustar, with pax
 * headers), below its `package/` directory: `{ path, mode, data }` and
 * `{ path, directory: true }`, `path` relative and `/`-separated.
 */
function untar(tgz) {
    const tar = gunzipSync(tgz);
    const entries = [];
    const text = (offset, length) => {
        const field = tar.subarray(offset, offset + length);
        const end = field.indexOf(0);
        return field.subarray(0, end === -1 ? length : end).toString("utf8");
    };
    const octal = (offset, length) => parseInt(text(offset, length).trim() || "0", 8);
    let paxPath;
    for (let offset = 0; offset + 512 <= tar.length; ) {
        const header = offset;
        if (tar.subarray(header, header + 512).every((b) => b === 0)) break;
        const size = octal(header + 124, 12);
        const mode = octal(header + 100, 8);
        const type = String.fromCharCode(tar[header + 156] || 0x30);
        const prefix = text(header + 345, 155);
        const name = paxPath ?? (prefix ? `${prefix}/${text(header, 100)}` : text(header, 100));
        const data = tar.subarray(header + 512, header + 512 + size);
        offset = header + 512 + Math.ceil(size / 512) * 512;
        if (type === "x") {
            const record = data.toString("utf8").match(/(?:^|\n)\d+ path=([^\n]*)\n/);
            paxPath = record ? record[1] : undefined;
            continue;
        }
        paxPath = undefined;
        if (type === "g") continue;
        const parts = name.replace(/\/+$/, "").split("/");
        if (parts[0] !== "package" || parts.some((p) => p === ".." || p === "") || name.startsWith("/")) {
            fail(`unexpected path in the tarball: ${name}`);
        }
        const relative = parts.slice(1).join("/");
        if (relative === "") continue;
        if (type === "5") entries.push({ path: relative, directory: true });
        else if (type === "0") entries.push({ path: relative, mode, data });
        else fail(`unexpected entry type ${JSON.stringify(type)} in the tarball: ${name}`);
    }
    return entries;
}

function unpack(entries, destination) {
    fs.rmSync(destination, { recursive: true, force: true });
    fs.mkdirSync(destination, { recursive: true });
    for (const entry of entries) {
        const target = path.join(destination, ...entry.path.split("/"));
        if (entry.directory) {
            fs.mkdirSync(target, { recursive: true });
            continue;
        }
        fs.mkdirSync(path.dirname(target), { recursive: true });
        fs.writeFileSync(target, entry.data);
        // npm's tarballs record the modes npm installs with: 0755 for the
        // compiler, 0644 for the rest.
        if (process.platform !== "win32") fs.chmodSync(target, entry.mode & 0o777);
    }
}

function checkPackage(pins, pin, dir, key) {
    const failures = packageFailures(dir, pins, key, pin);
    if (failures.length > 0) fail(`${pin.name}@${pins.version} is not as pinned:\n  ${failures.join("\n  ")}`);
    return path.join(dir, ...compilerPath(key).split("/"));
}

/**
 * Whether spawning failed because this OS cannot execute the file's format:
 * ENOEXEC (Linux, an ELF of another architecture without emulation) or
 * EBADARCH (macOS, "Bad CPU type" without Rosetta; libuv reports it as
 * errno -86). Anything else, a crash included, is a compiler that does not
 * work.
 */
const cannotExecute = (error) =>
    error.code === "ENOEXEC" || error.code === "EBADARCH" || (process.platform === "darwin" && error.errno === -86);

/**
 * Runs the staged `tsc --version` where this machine can: true if it ran
 * (and printed the pinned version), false if this OS cannot run it (another
 * OS, or an architecture it neither runs nor emulates). Fails if it starts
 * and does not print the pinned version: an exit code, a signal, or other
 * output.
 */
function runCompiler(pins, key, tsc) {
    const [os] = key.split("-");
    if (os !== process.platform) return false;
    let version;
    try {
        version = execFileSync(tsc, ["--version"], { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] }).trim();
    } catch (error) {
        if (key !== host && cannotExecute(error)) return false;
        const how = error.signal ? `was killed by ${error.signal}` : error.status !== null && error.status !== undefined ? `exited with ${error.status}` : `failed (${error.code ?? error.message})`;
        fail(`${tsc} --version ${how}${error.stderr ? `: ${String(error.stderr).trim()}` : ""}`);
    }
    if (version !== `Version ${pins.version}`) fail(`${tsc} --version printed ${JSON.stringify(version)}`);
    return true;
}

const xml = (s) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&apos;");

/**
 * The WiX v3 fragment for the MSI: `dir` (the staged package) as
 * `bin\typescript` (the `Bin` directory of main.wxs) and the repository's
 * LICENSE and NOTICE in the install directory (`APPLICATIONFOLDER`), one
 * component per file, all in the component group `BundledFiles`.
 */
function wixFragment(dir) {
    const components = [];
    const component = (source, name, indent) => {
        const n = components.length;
        components.push(`BundledComponent${n}`);
        return [
            `${indent}<Component Id='BundledComponent${n}' Guid='*'>`,
            `${indent}    <File Id='BundledFile${n}' Name='${xml(name)}' DiskId='1' Source='${xml(source)}' KeyPath='yes'/>`,
            `${indent}</Component>`,
        ];
    };
    const notices = ["LICENSE", "NOTICE"].flatMap((name) => component(path.join(repositoryRoot, name), name, "            "));
    const lines = [];
    let directories = 0;
    const walk = (current, name, indent) => {
        lines.push(`${indent}<Directory Id='BundledDir${directories++}' Name='${xml(name)}'>`);
        const children = fs.readdirSync(current, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
        for (const child of children.filter((c) => c.isFile())) {
            lines.push(...component(path.resolve(current, child.name), child.name, `${indent}    `));
        }
        for (const child of children.filter((c) => c.isDirectory())) walk(path.join(current, child.name), child.name, `${indent}    `);
        lines.push(`${indent}</Directory>`);
    };
    walk(dir, "typescript", "            ");
    return [
        "<?xml version='1.0' encoding='utf-8'?>",
        "<!-- Generated by release/bundle-typescript.mjs for this build: do not edit or commit. -->",
        "<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>",
        "    <Fragment>",
        "        <DirectoryRef Id='APPLICATIONFOLDER'>",
        ...notices,
        "        </DirectoryRef>",
        "        <DirectoryRef Id='Bin'>",
        ...lines,
        "        </DirectoryRef>",
        "        <ComponentGroup Id='BundledFiles'>",
        ...components.map((id) => `            <ComponentRef Id='${id}'/>`),
        "        </ComponentGroup>",
        "    </Fragment>",
        "</Wix>",
        "",
    ].join("\n");
}

async function stage(targets, mustRun) {
    const pins = JSON.parse(fs.readFileSync(pinsFile, "utf8"));
    const [key, pin] = packageFor(pins, targets);
    checkPin(pins, key, pin);
    const entries = untar(await download(pin.tarball, pin.integrity));
    if (entries.some((e) => e.path === pinsName)) fail(`${pin.name} has a ${pinsName} of its own`);
    const temporary = path.join(here, ".typescript.tmp");
    unpack(entries, temporary);
    const tsc = checkPackage(pins, pin, temporary, key);
    if (runCompiler(pins, key, tsc)) {
        log(`ran ${pin.name}'s ${compilerPath(key)} --version on ${host}: Version ${pins.version}`);
    } else if (mustRun) {
        fail(`${pin.name} cannot run on ${host}, and --run requires it`);
    } else {
        log(`${pin.name} cannot run on ${host}: checked against its hash only`);
    }
    // What an earlier run staged goes, pins.json stays.
    for (const name of fs.readdirSync(bundleDir)) {
        if (name !== pinsName) fs.rmSync(path.join(bundleDir, name), { recursive: true, force: true });
    }
    for (const name of fs.readdirSync(temporary)) fs.renameSync(path.join(temporary, name), path.join(bundleDir, name));
    fs.rmSync(temporary, { recursive: true });
    log(`${pin.name}@${pins.version} (${entries.filter((e) => !e.directory).length} files) in ${path.relative(repositoryRoot, bundleDir)}`);
    if (key.startsWith("win32-")) {
        fs.writeFileSync(wxsFile, wixFragment(bundleDir));
        log(`wrote ${path.relative(repositoryRoot, wxsFile)}`);
    } else if (fs.existsSync(wxsFile)) {
        // It would list the files of a Windows package no longer staged.
        fs.rmSync(wxsFile);
        log(`removed ${path.relative(repositoryRoot, wxsFile)}`);
    }
}

async function pin(version) {
    if (!/^\d+\.\d+\.\d+$/.test(version ?? "")) fail("--pin takes a version, such as 7.0.2");
    const pins = JSON.parse(fs.readFileSync(pinsFile, "utf8"));
    const packages = {};
    for (const [key, old] of Object.entries(pins.packages)) {
        const name = `@typescript/typescript-${key}`;
        const metadata = await fetchWithRetries(`${registry}${name.replace("/", "%2f")}/${version}`, "json");
        const tarball = metadata.dist.tarball;
        if (metadata.name !== name || metadata.version !== version || tarball !== tarballUrl(name, version)) {
            fail(`the registry's ${name}@${version} is ${metadata.name}@${metadata.version} at ${tarball}`);
        }
        const entries = untar(await download(tarball, metadata.dist.integrity));
        const tsc = entries.find((e) => e.path === compilerPath(key));
        if (!tsc) fail(`${name}@${version} has no ${compilerPath(key)}`);
        packages[key] = { ...old, name, targets: old.targets, tarball, integrity: metadata.dist.integrity, tscSha256: sha256(tsc.data) };
        log(`${name}@${version}: ${metadata.dist.integrity}`);
    }
    // Every other key stays, in its place.
    const updated = { ...pins, version, packages };
    for (const [key, entry] of Object.entries(updated.packages)) checkPin(updated, key, entry);
    fs.writeFileSync(pinsFile, `${JSON.stringify(updated, null, 4)}\n`);
    log(`wrote ${path.relative(repositoryRoot, pinsFile)}`);
}

const args = process.argv.slice(2);
if (args[0] === "--pin") {
    await pin(args[1]);
} else {
    const mustRun = args.includes("--run");
    await stage(
        args.filter((a) => a !== "--run"),
        mustRun,
    );
}
