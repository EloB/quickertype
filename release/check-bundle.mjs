// Checks that a release archive's quickertype converts TypeScript with the
// compiler it bundles, and with nothing else.
//
//   node release/check-bundle.mjs <archive>
//
// <archive> is what `dist build` made for this machine
// (target/distrib/quickertype-<target>.tar.xz, or .zip on Windows). It is
// unpacked into a temporary directory, checked for the bundled package
// (the version release/typescript/pins.json pins, with its LICENSE and
// NOTICE.txt, and those pins) and TypeScript's attribution in NOTICE, and
// its quickertype converts
// release/check-bundle/person.ts to Rust, which must print exactly
// release/check-bundle/person.expected.rs (what the TypeScript quicktype
// prints for it). Every run has an environment without another TypeScript
// compiler: PATH is one empty directory, QUICKTYPE_TSC is unset, and no
// directory above the working directory has a node_modules. It runs in
// the layouts the installers make:
//
// 1. the unpacked archive, quickertype next to typescript/ (also the MSI's
//    bin directory, and the npm package, which unpacks the archive);
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

const here = path.dirname(fileURLToPath(import.meta.url));
const pinsText = fs.readFileSync(path.join(here, "typescript", "pins.json"), "utf8");
const pins = JSON.parse(pinsText);
const fixture = path.join(here, "check-bundle");
const expected = fs.readFileSync(path.join(fixture, "person.expected.rs"), "utf8");
const windows = process.platform === "win32";
const exe = (name) => (windows ? `${name}.exe` : name);
const platformPackage = `@typescript/typescript-${process.platform}-${process.arch}@${pins.version}`;

let failures = 0;
function check(condition, message) {
    console.log(`${condition ? "ok" : "FAILED"}: ${message}`);
    if (!condition) failures++;
}

const archive = process.argv[2];
if (!archive || !fs.existsSync(archive)) {
    console.error("usage: node release/check-bundle.mjs <archive made by dist build>");
    process.exit(2);
}

const scratch = fs.mkdtempSync(path.join(fs.realpathSync(os.tmpdir()), "quickertype-bundle-"));
try {
    // The archive, unpacked as the installers do (a .tar.xz has one
    // top-level directory, a .zip none).
    const unpacked = path.join(scratch, "archive");
    fs.mkdirSync(unpacked);
    const tar = spawnSync("tar", ["-xf", path.resolve(archive), "-C", unpacked], { stdio: "inherit" });
    if (tar.status !== 0) throw new Error(`tar -xf ${archive} failed`);
    const top = fs.readdirSync(unpacked);
    const single = top.length === 1 && fs.statSync(path.join(unpacked, top[0])).isDirectory();
    const root = single ? path.join(unpacked, top[0]) : unpacked;

    const bundled = path.join(root, "typescript");
    const manifest = JSON.parse(fs.readFileSync(path.join(bundled, "package.json"), "utf8"));
    check(
        manifest.name === `@typescript/typescript-${process.platform}-${process.arch}` && manifest.version === pins.version,
        `the archive bundles ${platformPackage} (it has ${manifest.name}@${manifest.version})`,
    );
    check(fs.readFileSync(path.join(bundled, "pins.json"), "utf8") === pinsText, "typescript/pins.json is release/typescript/pins.json");
    for (const file of ["LICENSE", "NOTICE.txt", path.join("lib", exe("tsc"))]) {
        check(fs.existsSync(path.join(bundled, file)), `typescript/${file.replaceAll(path.sep, "/")} is in the archive`);
    }
    check(/TypeScript/.test(fs.readFileSync(path.join(root, "NOTICE"), "utf8")), "NOTICE attributes TypeScript");

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

    // 1. The unpacked archive.
    let quickertype = path.join(root, exe("quickertype"));
    converts(quickertype, "the archive");

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
        `Install it with "npm install -g typescript@${pins.version}" (for this platform, that installs ${platformPackage}), ` +
        "or set QUICKTYPE_TSC to its path.\n";
    check(run.status === 1 && run.stderr === error, "without the bundled compiler, quickertype names the package to install");
    if (run.stderr !== error) console.log(`exit ${run.status}\n--- stderr\n${run.stderr}`);
} catch (error) {
    check(false, error.message);
} finally {
    fs.rmSync(scratch, { recursive: true, force: true });
}
if (failures > 0) {
    console.error(`${failures} check(s) failed`);
    process.exit(1);
}
