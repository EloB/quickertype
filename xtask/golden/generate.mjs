#!/usr/bin/env node
// Generates tests/golden: quicktype's output for every test case, from
// quicktype at the commit in tests/golden/REFERENCE. quickertype must
// reproduce it byte for byte (`cargo xtask parity`).
//
//   npm run golden                  through Turborepo, which replays its
//                                   cached result instead when nothing the
//                                   corpus depends on changed (turbo.json)
//   node xtask/golden/generate.mjs [<quicktype checkout>]
//                                   generate it again (cargo xtask golden)
//
// quicktype is the checkout given, which must be at that commit, built
// (npm ci && npm run build) and without changes; else $QUICKTYPE_REFERENCE
// if it is such a checkout (the other tools take it to mean any quicktype,
// or `self`, so anything else is passed over, with a note); else a
// checkout this script makes once in the user's cache directory
// (<cache>/quickertype/quicktype-reference/<commit>: fetched from GitHub,
// installed and built). That is outside the repository, so that the
// checkout's module and type lookups never reach this repository's
// node_modules. Needs Node at the major version REFERENCE names, git and
// bash (macOS or Linux).
//
// What it records:
// 1. quicktype's own fixture harness (`script/test`) runs every JSON, JSON
//    Schema, GraphQL and comment-injection fixture without compiling the
//    generated code (OUTPUT_SNAPSHOT_DIR). record-hook.cjs turns each of
//    its in-process CLI calls into a real CLI run and records the argv and
//    the files written.
// 2. finalize.mjs lays the recordings out as cases
//    (<fixture>/<input>/<hash>/case.json and step<N>/<files>), checking
//    them against the harness's own snapshot: every file in it must be
//    one quicktype wrote in a recorded run. (The snapshot also holds the
//    Java fixtures' own TopLevel.java where quicktype writes none, which
//    this script removes from it first.)
// 3. record-cli.mjs records the CLI-behavior cases (cli-*): help, errors,
//    options, stdout.
// 4. GENERATED says what was generated (the commit, the number of cases);
//    the tools that read the corpus check it (state.mjs).
//
// Everything is written to a work directory first and moved into
// tests/golden at the end, so a failed run leaves no half corpus behind.

import { spawnSync } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { cleanGolden, goldenDir } from "./clean.mjs";
import { caseDirs, readReference } from "./state.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(here, "..", "..");
// The work directory: in the repository, so that moving the result into
// tests/golden is a rename.
const workParent = path.join(root, "node_modules", ".cache");
const UPSTREAM = "https://github.com/glideapps/quicktype.git";
const FIXTURES = "json,schema,graphql,comment-injection";
const started = Date.now();

function fail(message) {
    console.error(`golden: ${message}`);
    process.exit(1);
}

function step(message) {
    console.log(`* [${Math.round((Date.now() - started) / 1000)}s] ${message}`);
}

/**
 * The environment for quicktype's npm and harness runs: without the npm_*
 * variables of an `npm run` this runs under, which would make a nested npm
 * act on this repository instead.
 */
function quicktypeEnv(extra = {}) {
    const env = {};
    for (const [name, value] of Object.entries(process.env)) {
        if (!name.startsWith("npm_") && name !== "INIT_CWD" && !name.startsWith("TURBO_")) env[name] = value;
    }
    return { ...env, ...extra };
}

/** Runs a command; fails with `what` if it does not succeed. */
function run(what, command, args, options = {}) {
    const result = spawnSync(command, args, { stdio: "inherit", ...options });
    if (result.error) fail(`${what}: ${result.error.message}`);
    if (result.status !== 0) fail(`${what} failed (exit ${result.status ?? result.signal})`);
}

/** `git -C dir args...`'s output, or undefined if it fails. */
function git(dir, ...args) {
    const result = spawnSync("git", ["-C", dir, ...args], { encoding: "utf8" });
    return result.status === 0 ? result.stdout.trim() : undefined;
}

/**
 * Why `dir` cannot be used as quicktype at `commit` (not built, at another
 * commit, or with changes), or undefined if it can.
 */
function unusableCheckout(dir, commit) {
    if (!fs.existsSync(path.join(dir, "dist", "index.js"))) return `${dir} is not a built quicktype checkout (npm ci && npm run build)`;
    const head = git(dir, "rev-parse", "HEAD");
    if (head !== commit) return `${dir} is at ${head ?? "no commit"}, but tests/golden/REFERENCE pins ${commit}`;
    if (git(dir, "status", "--porcelain", "--untracked-files=no") !== "") {
        return `${dir} has changes to quicktype's files, so its output is not quicktype's at ${commit}`;
    }
    return undefined;
}

/** The user's cache directory: $XDG_CACHE_HOME, ~/Library/Caches on macOS, else ~/.cache. */
function userCacheDir() {
    if (process.env.XDG_CACHE_HOME) return process.env.XDG_CACHE_HOME;
    return process.platform === "darwin" ? path.join(os.homedir(), "Library", "Caches") : path.join(os.homedir(), ".cache");
}

/** quicktype at `commit` in the user's cache directory, fetched and built the first time. */
function cachedCheckout(commit) {
    const checkout = path.join(userCacheDir(), "quickertype", "quicktype-reference", commit);
    if (git(checkout, "rev-parse", "HEAD") === commit && fs.existsSync(path.join(checkout, "dist", "index.js"))) {
        return checkout;
    }
    // Made in a sibling directory and renamed when complete, so a failed
    // fetch or build never leaves a half-made checkout to be reused.
    const partial = `${checkout}.partial`;
    fs.rmSync(partial, { recursive: true, force: true });
    fs.rmSync(checkout, { recursive: true, force: true });
    fs.mkdirSync(partial, { recursive: true });
    const env = quicktypeEnv();
    step(`fetching quicktype ${commit.slice(0, 8)} into ${checkout}`);
    run("git init", "git", ["init", "--quiet", partial], { env });
    run("git fetch", "git", ["-C", partial, "fetch", "--quiet", "--depth", "1", UPSTREAM, commit], { env });
    run("git checkout", "git", ["-C", partial, "-c", "advice.detachedHead=false", "checkout", "--quiet", "FETCH_HEAD"], { env });
    step("installing and building it (npm ci && npm run build)");
    run("npm ci", "npm", ["ci", "--no-audit", "--no-fund"], { cwd: partial, env });
    run("npm run build", "npm", ["run", "build"], { cwd: partial, env });
    if (!fs.existsSync(path.join(partial, "dist", "index.js"))) fail(`building quicktype made no ${path.join(partial, "dist", "index.js")}`);
    fs.renameSync(partial, checkout);
    return checkout;
}

/** Moves `from` to `to`, copying if they are on different file systems. */
function move(from, to) {
    try {
        fs.renameSync(from, to);
    } catch (error) {
        if (error.code !== "EXDEV") throw error;
        fs.cpSync(from, to, { recursive: true });
        fs.rmSync(from, { recursive: true, force: true });
    }
}

if (process.platform === "win32") {
    fail("generating tests/golden needs macOS or Linux: quicktype's fixture harness is a bash script");
}
const { commit, node } = readReference(root);
const major = (version) => version.replace(/^v/, "").split(".")[0];
if (major(process.version) !== major(node)) {
    fail(`tests/golden/REFERENCE records quicktype's output with Node ${major(node)} (${node}); this is Node ${process.version}`);
}

/** The checkout to record from (see the header). */
function referenceCheckout(commit) {
    const given = process.argv[2];
    if (given !== undefined) {
        const problem = unusableCheckout(path.resolve(given), commit);
        if (problem !== undefined) fail(problem);
        return path.resolve(given);
    }
    const fromEnv = process.env.QUICKTYPE_REFERENCE;
    if (fromEnv && fromEnv !== "self") {
        const problem = unusableCheckout(path.resolve(fromEnv), commit);
        if (problem === undefined) return path.resolve(fromEnv);
        step(`QUICKTYPE_REFERENCE: ${problem}; using a checkout of ${commit.slice(0, 8)} instead`);
    }
    return cachedCheckout(commit);
}

/**
 * Removes from `snapshot` the Java fixtures' own TopLevel.java: each Java
 * fixture copies its base directory, whose src/main/java/io/quicktype/
 * TopLevel.java drives the test, into every run, and the snapshot keeps
 * it as the run's main output where quicktype writes no TopLevel.java of
 * its own (a top level that is not a class). Only exact copies of a
 * fixture's file are removed. Returns how many.
 */
function removeFixtureDrivers(snapshot, reference) {
    const sha = (file) => createHash("sha256").update(fs.readFileSync(file)).digest("hex");
    const fixtures = path.join(reference, "test", "fixtures");
    const drivers = new Set(
        fs
            .readdirSync(fixtures)
            .map((name) => path.join(fixtures, name, "src", "main", "java", "io", "quicktype", "TopLevel.java"))
            .filter((file) => fs.existsSync(file))
            .map(sha),
    );
    let removed = 0;
    const walk = (dir) => {
        for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
            const file = path.join(dir, entry.name);
            if (entry.isDirectory()) walk(file);
            else if (entry.name === "TopLevel.java" && drivers.has(sha(file))) {
                fs.rmSync(file);
                removed++;
            }
        }
    };
    if (fs.existsSync(snapshot)) walk(snapshot);
    return removed;
}

const reference = referenceCheckout(commit);
step(`recording from ${reference} (${commit.slice(0, 8)})`);

fs.mkdirSync(workParent, { recursive: true });
const work = fs.mkdtempSync(path.join(workParent, "golden-"));
const raw = path.join(work, "raw");
const snapshot = path.join(work, "snapshot");
const out = path.join(work, "golden");
const log = path.join(work, "record.log");

const runs = path.join(reference, "test", "runs");
fs.rmSync(runs, { recursive: true, force: true });
const logFd = fs.openSync(log, "w");
const harness = spawnSync("bash", ["script/test"], {
    cwd: reference,
    stdio: ["ignore", logFd, logFd],
    env: quicktypeEnv({
        NODE_OPTIONS: `--require "${path.join(here, "record-hook.cjs")}"`,
        GOLDEN_RAW_DIR: raw,
        OUTPUT_SNAPSHOT_DIR: snapshot,
        ALL_FIXTURES: "1",
        FIXTURE: FIXTURES,
    }),
});
fs.closeSync(logFd);
fs.rmSync(runs, { recursive: true, force: true });
if (harness.error || harness.status !== 0) {
    const lines = fs.readFileSync(log, "utf8").trimEnd().split("\n");
    console.error(lines.slice(-40).join("\n"));
    fail(`quicktype's fixture harness failed (${harness.error?.message ?? `exit ${harness.status ?? harness.signal}`}); its whole log: ${log}`);
}

step("laying out the cases");
// The leading-comments Go fixture drives the library API, not the CLI, so
// it has no CLI recording to cross-check.
fs.rmSync(path.join(snapshot, "schema-golang-leading-comments"), { recursive: true, force: true });
console.log(`  ${removeFixtureDrivers(snapshot, reference)} copies of the Java fixtures' own TopLevel.java left out of the cross-check`);
run("finalize.mjs", process.execPath, [path.join(here, "finalize.mjs"), raw, out, snapshot]);

step("recording the CLI-behavior cases (cli-*)");
run("record-cli.mjs", process.execPath, [path.join(here, "record-cli.mjs"), reference, out, path.join(root, "tests", "inputs")], {
    env: quicktypeEnv(),
});

const cases = caseDirs(out).length;
fs.writeFileSync(path.join(out, "GENERATED"), `quicktype_commit=${commit}\nnode=${process.version}\ncases=${cases}\n`);
cleanGolden(goldenDir);
for (const name of fs.readdirSync(out)) move(path.join(out, name), path.join(goldenDir, name));
fs.rmSync(work, { recursive: true, force: true });
step(`done: ${cases} cases in tests/golden`);
