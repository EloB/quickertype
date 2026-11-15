// Checks that a release archive's (or the MSI's) quickertype converts
// TypeScript with the compiler it bundles, and with nothing else.
//
//   node release/check-bundle.mjs <archive or MSI>
//
// The file is one `dist build` made for this machine's platform:
// target/distrib/quickertype-<target>.tar.xz, .zip, or .msi (Windows; it
// is unpacked with `msiexec /a`, an administrative install into a
// directory). It must pass release/check-release.mjs's checks of the
// bundled compiler (so the gate need not check it again), and its
// quickertype must convert
// release/check-bundle/person.ts to Rust, printing exactly
// release/check-bundle/person.expected.rs (what the TypeScript quicktype
// prints for it). Every run has an environment without another TypeScript
// compiler: PATH is one empty directory, QUICKTYPE_TSC is unset, and no
// directory above the working directory has a node_modules. It runs in the
// layouts the installers make:
//
// 1. as unpacked, quickertype next to typescript/ (the archive, which the
//    npm package unpacks too, or the MSI's bin directory);
// 2. Homebrew's (not on Windows): quickertype in <prefix>/bin, reached
//    through a symbolic link as Homebrew's bin links do, and typescript/
//    in <prefix>/share/quickertype, where the formula puts what is left of
//    the archive;
// 3. without the compiler: quickertype must fail with the error that names
//    the npm package to install for this platform, which also shows that
//    the runs before found no other compiler.

import { spawnSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { layoutFailures } from "./check-release.mjs";
import { packageOf, readPins, targetOf, unpackArchive } from "./package.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const fixture = path.join(here, "check-bundle");
const expected = fs.readFileSync(path.join(fixture, "person.expected.rs"), "utf8");
const { pins } = readPins();
const windows = process.platform === "win32";
const exe = (name) => (windows ? `${name}.exe` : name);

let failures = 0;
function check(condition, message) {
    console.log(`${condition ? "ok" : "FAILED"}: ${message}`);
    if (!condition) failures++;
}

/** The directory of quickertype.exe in an administrative install of `msi`. */
function unpackMsi(msi, into) {
    fs.mkdirSync(into, { recursive: true });
    const log = path.join(into, "..", "msiexec.log");
    const run = spawnSync("msiexec", ["/a", path.resolve(msi), "/qn", `TARGETDIR=${into}`, "/L*v", log], { stdio: "inherit" });
    if (run.status !== 0) throw new Error(`msiexec /a ${msi} exited with ${run.status} (log: ${log})`);
    const find = (dir) => {
        for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
            const full = path.join(dir, entry.name);
            if (entry.isFile() && entry.name.toLowerCase() === "quickertype.exe") return dir;
            if (entry.isDirectory()) {
                const found = find(full);
                if (found) return found;
            }
        }
        return undefined;
    };
    const bin = find(into);
    if (!bin) throw new Error(`no quickertype.exe in the administrative install of ${msi}`);
    return bin;
}

const file = process.argv[2];
if (!file || !fs.existsSync(file)) {
    console.error("usage: node release/check-bundle.mjs <archive or MSI made by dist build>");
    process.exit(2);
}

const scratch = fs.mkdtempSync(path.join(fs.realpathSync(os.tmpdir()), "quickertype-bundle-"));
try {
    const target = targetOf(file);
    const [key, pin] = packageOf(pins, target);
    if (key !== `${process.platform}-${process.arch}`) throw new Error(`${file} is for ${key}, not this machine`);
    const msi = file.endsWith(".msi");
    // The MSI installs quickertype.exe and typescript\ into bin, LICENSE and
    // NOTICE into the directory above it.
    const root = msi ? unpackMsi(file, path.join(scratch, "msi")) : unpackArchive(file, path.join(scratch, "archive"));
    const layout = layoutFailures(root, target, msi ? path.dirname(root) : root);
    if (layout.length === 0) check(true, `${path.basename(file)} bundles ${pin.name}@${pins.version}, as pinned`);
    for (const failure of layout) check(false, `${path.basename(file)}: ${failure}`);
    const bundled = path.join(root, "typescript");

    // Where quickertype runs: no compiler on PATH or in node_modules.
    const work = path.join(scratch, "work");
    const emptyPath = path.join(scratch, "empty-path");
    fs.mkdirSync(work);
    fs.mkdirSync(emptyPath);
    fs.copyFileSync(path.join(fixture, "person.ts"), path.join(work, "person.ts"));
    for (let dir = work; ; dir = path.dirname(dir)) {
        if (fs.existsSync(path.join(dir, "node_modules"))) throw new Error(`${dir} has a node_modules`);
        if (path.dirname(dir) === dir) break;
    }
    const env = { PATH: emptyPath };
    for (const name of ["SystemRoot", "SYSTEMROOT", "windir", "TEMP", "TMP"]) {
        if (windows && process.env[name]) env[name] = process.env[name];
    }
    const convert = (quickertype) =>
        spawnSync(quickertype, ["--lang", "rust", "person.ts"], { cwd: work, env, encoding: "utf8" });
    const converts = (quickertype, layout) => {
        const run = convert(quickertype);
        const ok = run.status === 0 && run.stdout === expected;
        check(ok, `${layout}: quickertype converts person.ts to person.expected.rs`);
        if (!ok) console.log(`exit ${run.status}\n--- stderr\n${run.stderr}--- stdout\n${run.stdout}`);
    };

    // 1. As unpacked.
    let quickertype = path.join(root, exe("quickertype"));
    converts(quickertype, msi ? "the MSI" : "the archive");

    // 2. Homebrew's layout, through a symbolic link.
    if (!windows) {
        const prefix = path.join(scratch, "Cellar", "quickertype", "0.0.0");
        const share = path.join(prefix, "share", "quickertype");
        fs.mkdirSync(path.join(prefix, "bin"), { recursive: true });
        fs.mkdirSync(share, { recursive: true });
        fs.renameSync(quickertype, path.join(prefix, "bin", "quickertype"));
        fs.renameSync(bundled, path.join(share, "typescript"));
        fs.mkdirSync(path.join(scratch, "bin"));
        quickertype = path.join(scratch, "bin", "quickertype");
        fs.symlinkSync(path.join("..", "Cellar", "quickertype", "0.0.0", "bin", "quickertype"), quickertype);
        converts(quickertype, "Homebrew's layout");
        fs.rmSync(path.join(share, "typescript"), { recursive: true });
    } else {
        fs.rmSync(bundled, { recursive: true });
    }

    // 3. Without the compiler.
    const run = convert(quickertype);
    const error =
        `Error: TypeScript input requires the TypeScript ${pins.version} compiler (tsc), but it was not found. ` +
        `Install it with "npm install -g typescript@${pins.version}" (for this platform, that installs ` +
        `@typescript/typescript-${key}@${pins.version}), or set QUICKTYPE_TSC to its path.`;
    const stderr = run.stderr?.replace(/\r?\n$/, "");
    check(run.status === 1 && stderr === error, "without the bundled compiler, quickertype names the package to install");
    if (stderr !== error) console.log(`exit ${run.status}\n--- stderr\n${run.stderr}`);
} catch (error) {
    check(false, error.message);
} finally {
    fs.rmSync(scratch, { recursive: true, force: true });
}
if (failures > 0) {
    console.error(`${failures} check(s) failed`);
    process.exit(1);
}
