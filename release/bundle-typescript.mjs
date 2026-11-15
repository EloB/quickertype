// Stages the TypeScript compiler that a release bundles next to quickertype:
// the npm platform package pinned in release/typescript/pins.json,
// downloaded from the npm registry, checked against its pinned
// `dist.integrity` and unpacked unmodified into release/typescript, beside
// pins.json. That directory is the archives' `typescript` directory
// (`include` in dist-workspace.toml); git ignores everything in it but
// pins.json.
//
//   node release/bundle-typescript.mjs [<target>...]
//
// <target> is a release target (a Rust target triple, as in
// dist-workspace.toml); release.yml passes its job's
// (.github/build-setup.yml). Without one, the package for this machine
// (Node's platform and architecture). Every target must take the same
// package. For a Windows target it also writes
// crates/quicktype-cli/wix/typescript.wxs, the WiX fragment that puts the
// directory into the MSI next to quickertype.exe (main.wxs references its
// `TypeScriptCompiler` component group).
//
// Fails, leaving what was staged before, when the download does not match
// its integrity, the package is not the pinned name and version, or (when
// it can run here) its `tsc --version` is not the pinned version. A
// verified tarball is kept in target/tsc-bundle and reused.

import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { gunzipSync } from "node:zlib";

const here = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(here, "..");
const bundleDir = path.join(here, "typescript");
const pinsName = "pins.json";
const stagingDir = path.join(repositoryRoot, "target", "tsc-bundle");
const wxsFile = path.join(repositoryRoot, "crates", "quicktype-cli", "wix", "typescript.wxs");
const registry = "https://registry.npmjs.org/";

function fail(message) {
    console.error(`bundle-typescript: ${message}`);
    process.exit(1);
}

/** The pinned package for `targets` (or for this machine): `[key, pin]`. */
function packageFor(pins, targets) {
    if (targets.length === 0) {
        const key = `${process.platform}-${process.arch}`;
        if (!pins.packages[key]) fail(`no TypeScript platform package is pinned for this machine (${key})`);
        return [key, pins.packages[key]];
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

/** Checks a pin's shape: an npm registry tarball of the pinned version. */
function checkPin(pins, key, pin) {
    const base = pin.name.split("/").pop();
    const expected = `${registry}${pin.name}/-/${base}-${pins.version}.tgz`;
    if (pin.name !== `@typescript/typescript-${key}`) fail(`${key}: the package is named ${pin.name}`);
    if (pin.tarball !== expected) fail(`${key}: the tarball must be ${expected}, not ${pin.tarball}`);
    if (!/^sha512-[A-Za-z0-9+/]{86}==$/.test(pin.integrity)) fail(`${key}: the integrity must be a sha512 one`);
}

function integrityOf(bytes) {
    return `sha512-${createHash("sha512").update(bytes).digest("base64")}`;
}

async function download(pin) {
    const cached = path.join(stagingDir, path.basename(new URL(pin.tarball).pathname));
    if (fs.existsSync(cached)) {
        const bytes = fs.readFileSync(cached);
        if (integrityOf(bytes) === pin.integrity) {
            console.error(`bundle-typescript: using ${path.relative(repositoryRoot, cached)}`);
            return bytes;
        }
        fs.rmSync(cached);
    }
    console.error(`bundle-typescript: downloading ${pin.tarball}`);
    let bytes;
    for (let attempt = 1; ; attempt++) {
        try {
            const response = await fetch(pin.tarball, { redirect: "error" });
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            bytes = Buffer.from(await response.arrayBuffer());
            break;
        } catch (error) {
            if (attempt === 3) fail(`downloading ${pin.tarball} failed: ${error.message}`);
            await new Promise((resolve) => setTimeout(resolve, 2000 * attempt));
        }
    }
    const actual = integrityOf(bytes);
    if (actual !== pin.integrity) {
        fail(`${pin.tarball} does not match its pinned integrity\n  pinned: ${pin.integrity}\n  actual: ${actual}`);
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
    const manifest = JSON.parse(fs.readFileSync(path.join(dir, "package.json"), "utf8"));
    if (manifest.name !== pin.name || manifest.version !== pins.version) {
        fail(`the tarball holds ${manifest.name}@${manifest.version}, not ${pin.name}@${pins.version}`);
    }
    for (const file of ["LICENSE", "NOTICE.txt"]) {
        if (!fs.existsSync(path.join(dir, file))) fail(`${pin.name} has no ${file}`);
    }
    const tsc = path.join(dir, "lib", key.startsWith("win32-") ? "tsc.exe" : "tsc");
    if (!fs.statSync(tsc, { throwIfNoEntry: false })?.isFile()) fail(`${pin.name} has no ${path.relative(dir, tsc)}`);
    if (key === `${process.platform}-${process.arch}`) {
        const version = execFileSync(tsc, ["--version"], { encoding: "utf8" }).trim();
        if (version !== `Version ${pins.version}`) fail(`${tsc} --version printed ${JSON.stringify(version)}`);
    }
}

const xml = (s) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&apos;");

/**
 * The WiX v3 fragment for the MSI: `dir` (the staged package) as
 * `bin\typescript` (the `Bin` directory of main.wxs), one component per
 * file, all in the component group `TypeScriptCompiler`.
 */
function wixFragment(dir) {
    const lines = [];
    const components = [];
    let directories = 0;
    const walk = (current, name, indent) => {
        lines.push(`${indent}<Directory Id='TypeScriptDir${directories++}' Name='${xml(name)}'>`);
        const children = fs.readdirSync(current, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
        for (const child of children.filter((c) => c.isFile())) {
            const n = components.length;
            components.push(`TypeScriptComponent${n}`);
            lines.push(
                `${indent}    <Component Id='TypeScriptComponent${n}' Guid='*'>`,
                `${indent}        <File Id='TypeScriptFile${n}' Name='${xml(child.name)}' DiskId='1' Source='${xml(path.resolve(current, child.name))}' KeyPath='yes'/>`,
                `${indent}    </Component>`,
            );
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
        "        <DirectoryRef Id='Bin'>",
        ...lines,
        "        </DirectoryRef>",
        "        <ComponentGroup Id='TypeScriptCompiler'>",
        ...components.map((id) => `            <ComponentRef Id='${id}'/>`),
        "        </ComponentGroup>",
        "    </Fragment>",
        "</Wix>",
        "",
    ].join("\n");
}

const targets = process.argv.slice(2);
const pins = JSON.parse(fs.readFileSync(path.join(bundleDir, pinsName), "utf8"));
const [key, pin] = packageFor(pins, targets);
checkPin(pins, key, pin);
const entries = untar(await download(pin));
if (entries.some((e) => e.path === pinsName)) fail(`${pin.name} has a ${pinsName} of its own`);
const temporary = path.join(here, ".typescript.tmp");
unpack(entries, temporary);
checkPackage(pins, pin, temporary, key);
// What an earlier run staged goes, pins.json stays.
for (const name of fs.readdirSync(bundleDir)) {
    if (name !== pinsName) fs.rmSync(path.join(bundleDir, name), { recursive: true, force: true });
}
for (const name of fs.readdirSync(temporary)) fs.renameSync(path.join(temporary, name), path.join(bundleDir, name));
fs.rmSync(temporary, { recursive: true });
console.error(`bundle-typescript: ${pin.name}@${pins.version} (${entries.filter((e) => !e.directory).length} files) in ${path.relative(repositoryRoot, bundleDir)}`);
if (targets.some((t) => t.includes("-windows-"))) {
    fs.writeFileSync(wxsFile, wixFragment(bundleDir));
    console.error(`bundle-typescript: wrote ${path.relative(repositoryRoot, wxsFile)}`);
} else {
    // A fragment for an earlier Windows target would list files no longer staged.
    fs.rmSync(wxsFile, { force: true });
}
