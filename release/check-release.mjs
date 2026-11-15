// The release gate for the bundled TypeScript compiler: every archive a
// release builds must have its target's compiler, as pinned.
//
//   node release/check-release.mjs <dir> [<target>...]
//
// <dir> holds the archives (`quickertype-<target>.tar.xz`, `.zip` on
// Windows), as dist builds them; the targets are every target of
// release/typescript/pins.json, or the given ones. Each archive is unpacked
// with tar (unzip for a .zip, where there is one) and must have, next to
// quickertype, `typescript/` with: the compiler, `lib/tsc` (`lib/tsc.exe` on
// Windows), whose SHA-256 is the pinned `tscSha256` and which is executable
// (but on Windows); the package.json of the pinned package and version; its
// LICENSE and NOTICE.txt; and pins.json, equal to the repository's. The
// archive's NOTICE must attribute TypeScript. Exits 1, after listing every
// failure, if one is missing or differs.
//
// release.yml runs it (.github/workflows/check-release.yml, a custom job of
// dist's `global-artifacts-jobs`) after every build-local-artifacts job and
// before `host`, which publishes nothing unless it passed.
// release/check-bundle.mjs uses its checks for the archive or MSI it runs.

import { spawnSync } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
export const pinsText = fs.readFileSync(path.join(here, "typescript", "pins.json"), "utf8");
export const pins = JSON.parse(pinsText);

/** The pinned package of a release target: `[key, pin]`. */
export function packageOf(target) {
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
 * Unpacks `archive` into the new directory `into` as the installers do and
 * returns the directory with quickertype in it (a .tar.xz has one
 * top-level directory, a .zip none).
 */
export function unpackArchive(archive, into) {
    fs.mkdirSync(into, { recursive: true });
    const zip = archive.endsWith(".zip");
    const unzip = zip && spawnSync("unzip", ["-v"], { stdio: "ignore" }).status === 0;
    const run = unzip
        ? spawnSync("unzip", ["-q", path.resolve(archive), "-d", into], { stdio: "inherit" })
        : spawnSync("tar", ["-xf", path.resolve(archive), "-C", into], { stdio: "inherit" });
    if (run.status !== 0) throw new Error(`unpacking ${archive} failed`);
    const top = fs.readdirSync(into);
    const single = top.length === 1 && fs.statSync(path.join(into, top[0])).isDirectory();
    return single ? path.join(into, top[0]) : into;
}

/**
 * The failures of the layout `root` for `target`: quickertype and
 * `typescript/` in `root`, NOTICE (and LICENSE) in `noticeDir`.
 */
export function layoutFailures(root, target, noticeDir = root) {
    const failures = [];
    const windows = target.includes("-windows-");
    const [key, pin] = packageOf(target);
    const bundled = path.join(root, "typescript");
    const read = (file) => fs.readFileSync(file);
    const exists = (file) => fs.statSync(file, { throwIfNoEntry: false })?.isFile() ?? false;
    if (!exists(path.join(root, windows ? "quickertype.exe" : "quickertype"))) failures.push("no quickertype");
    const tsc = path.join(bundled, "lib", key.startsWith("win32-") ? "tsc.exe" : "tsc");
    if (!exists(tsc)) {
        failures.push(`no typescript/lib/${path.basename(tsc)}`);
    } else {
        const hash = createHash("sha256").update(read(tsc)).digest("hex");
        if (hash !== pin.tscSha256) failures.push(`typescript/lib/${path.basename(tsc)} has the SHA-256 ${hash}, not the pinned ${pin.tscSha256}`);
        if (!windows && (fs.statSync(tsc).mode & 0o111) === 0) failures.push("typescript/lib/tsc is not executable");
    }
    try {
        const manifest = JSON.parse(read(path.join(bundled, "package.json")));
        if (manifest.name !== pin.name || manifest.version !== pins.version) {
            failures.push(`typescript/package.json is ${manifest.name}@${manifest.version}, not ${pin.name}@${pins.version}`);
        }
    } catch (error) {
        failures.push(`typescript/package.json: ${error.message}`);
    }
    if (!exists(path.join(bundled, "pins.json")) || read(path.join(bundled, "pins.json")).toString() !== pinsText) {
        failures.push("typescript/pins.json is not release/typescript/pins.json");
    }
    for (const file of ["LICENSE", "NOTICE.txt"]) {
        if (!exists(path.join(bundled, file))) failures.push(`no typescript/${file}`);
    }
    if (!exists(path.join(noticeDir, "LICENSE"))) failures.push("no LICENSE");
    if (!exists(path.join(noticeDir, "NOTICE")) || !/TypeScript/.test(read(path.join(noticeDir, "NOTICE")))) {
        failures.push("NOTICE does not attribute TypeScript");
    }
    return failures;
}

function main(args) {
    const [dir, ...only] = args;
    if (!dir || !fs.statSync(dir, { throwIfNoEntry: false })?.isDirectory()) {
        console.error("usage: node release/check-release.mjs <directory with the archives> [<target>...]");
        process.exit(2);
    }
    const targets = only.length > 0 ? only : Object.values(pins.packages).flatMap((pin) => pin.targets);
    const scratch = fs.mkdtempSync(path.join(fs.realpathSync(os.tmpdir()), "quickertype-release-"));
    let failed = 0;
    try {
        for (const target of targets) {
            const name = `quickertype-${target}${target.includes("-windows-") ? ".zip" : ".tar.xz"}`;
            const archive = path.join(dir, name);
            let failures;
            if (!fs.existsSync(archive)) {
                failures = ["the archive is missing"];
            } else {
                try {
                    failures = layoutFailures(unpackArchive(archive, path.join(scratch, target)), target);
                } catch (error) {
                    failures = [error.message];
                }
            }
            if (failures.length === 0) {
                console.log(`ok: ${name} bundles ${packageOf(target)[1].name}@${pins.version}, as pinned`);
            } else {
                failed++;
                for (const failure of failures) console.log(`FAILED: ${name}: ${failure}`);
            }
        }
    } finally {
        fs.rmSync(scratch, { recursive: true, force: true });
    }
    if (failed > 0) {
        console.error(`${failed} of ${targets.length} archives do not bundle the pinned TypeScript compiler`);
        process.exit(1);
    }
}

if (process.argv[1] && import.meta.url === pathToFileURL(path.resolve(process.argv[1])).href) main(process.argv.slice(2));
