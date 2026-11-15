// The release gate for the bundled TypeScript compiler: every archive a
// release builds must have its target's compiler, as pinned.
//
//   node release/check-release.mjs <dir> [<target>...] [--except <target>...]
//
// <dir> holds the archives (`quickertype-<target>.tar.xz`, `.zip` on
// Windows), as dist builds them. The targets are the given ones, or every
// target of release/typescript/pins.json but those after --except. Each
// archive is unpacked (release/package.mjs) and must have, next to
// quickertype, `typescript/` with the pinned package (its compiler,
// `lib/tsc` or `lib/tsc.exe`, with the pinned SHA-256 and executable but on
// Windows; its package.json, LICENSE and NOTICE.txt) and pins.json, equal
// to the repository's; and a LICENSE and a NOTICE that attributes
// TypeScript. Exits 1, after listing every failure, if one is missing or
// differs.
//
// release.yml runs it (.github/workflows/check-release.yml, a custom job of
// dist's `global-artifacts-jobs`) after every build-local-artifacts job and
// before `host`, which publishes nothing unless it passed, on the archives
// that release/check-bundle.mjs does not convert TypeScript with (that
// script makes the same checks first).

import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { pathToFileURL } from "node:url";

import { packageFailures, packageOf, readPins, unpackArchive } from "./package.mjs";

/**
 * How the layout `root` differs from a release's for `target`: quickertype
 * and `typescript/` in `root`, LICENSE and NOTICE in `noticeDir`.
 */
export function layoutFailures(root, target, noticeDir = root) {
    const { text, pins } = readPins();
    const [key, pin] = packageOf(pins, target);
    const failures = [];
    const isFile = (file) => fs.statSync(file, { throwIfNoEntry: false })?.isFile() ?? false;
    const quickertype = target.includes("-windows-") ? "quickertype.exe" : "quickertype";
    if (!isFile(path.join(root, quickertype))) failures.push(`${quickertype} is missing`);
    const bundled = path.join(root, "typescript");
    failures.push(...packageFailures(bundled, pins, key, pin).map((failure) => `typescript/${failure}`));
    const bundledPins = path.join(bundled, "pins.json");
    if (!isFile(bundledPins) || fs.readFileSync(bundledPins, "utf8") !== text) {
        failures.push("typescript/pins.json is not release/typescript/pins.json");
    }
    if (!isFile(path.join(noticeDir, "LICENSE"))) failures.push("LICENSE is missing");
    const notice = path.join(noticeDir, "NOTICE");
    if (!isFile(notice) || !fs.readFileSync(notice, "utf8").includes("TypeScript")) {
        failures.push("NOTICE does not attribute TypeScript");
    }
    return failures;
}

function main(args) {
    const split = args.indexOf("--except");
    const [dir, ...only] = split === -1 ? args : args.slice(0, split);
    const except = split === -1 ? [] : args.slice(split + 1);
    if (!dir || !fs.statSync(dir, { throwIfNoEntry: false })?.isDirectory()) {
        console.error("usage: node release/check-release.mjs <directory with the archives> [<target>...] [--except <target>...]");
        process.exit(2);
    }
    const { pins } = readPins();
    const pinned = Object.values(pins.packages).flatMap((pin) => pin.targets);
    for (const target of [...only, ...except]) packageOf(pins, target);
    const targets = (only.length > 0 ? only : pinned).filter((target) => !except.includes(target));
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
                console.log(`ok: ${name} bundles ${packageOf(pins, target)[1].name}@${pins.version}, as pinned`);
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
