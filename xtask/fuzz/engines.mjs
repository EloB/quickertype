// The two sides of every comparison, and how a fuzz case runs on each:
//
// * "api": quicktypeMultiFile on the reference quicktype-core (a built
//   quicktype checkout) and on this repository's npm package with every run
//   on its WebAssembly engine; JSON samples are strings, read with
//   `JSON.parse` semantics (CompressedJSONFromString).
// * "stream": the same, but JSON samples are streams read by the CLI's
//   CompressedJSONFromStream (stream-json: `1.0` is a double, duplicate keys
//   are kept, keys stay in source order). The reference uses its CLI's class;
//   our package gets the same class compiled against it and registered as a
//   native input, so the run still goes to the WebAssembly engine.
// * "cli": `node <reference>/dist/index.js` and our native binary, each in a
//   fresh directory holding the same input files; exit code, stdout, stderr
//   and written files are compared (the directory is normalized to {CWD}).
//
// How a case runs in-process ("api", "stream") is in run-case.mjs, which the
// npm differential suite replays recorded cases with.

import { spawn } from "node:child_process";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { unportablePaths } from "./file-names.mjs";
import { cliWordWrap, INFERENCE_FLAGS, streamClassFor } from "./run-case.mjs";

export const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "..");
export const packageRoot = path.join(repoRoot, "npm", "quicktype-core");
const engineKey = Symbol.for("quicktype-core.engine");

export function findReference(given) {
    const candidates = given !== undefined ? [given] : process.env.QUICKTYPE_REFERENCE !== undefined
        ? [process.env.QUICKTYPE_REFERENCE]
        : [path.join(repoRoot, "..", "quicktype"), path.join(repoRoot, "..", "..", "quicktype")];
    for (const c of candidates) {
        if (fs.existsSync(path.join(c, "packages", "quicktype-core", "dist", "index.js")) && fs.existsSync(path.join(c, "dist", "index.js"))) {
            return path.resolve(c);
        }
    }

    throw new Error(`no built quicktype checkout found (tried ${candidates.join(", ")}); pass --reference`);
}

/** The npm differential suite's outcome capture (normalized result or error, plus console output). */
export async function loadCompare() {
    return await import(pathToFileURL(path.join(packageRoot, "test", "differential", "compare.mjs")).href);
}

/** Both sides, as run-case.mjs's `runInProcess` takes them, with a `wrap` for each run. */
export function loadSides(reference) {
    const requireHere = createRequire(import.meta.url);
    const refQt = requireHere(path.join(reference, "packages", "quicktype-core"));
    const oursQt = requireHere(packageRoot);
    const stats = requireHere(path.join(packageRoot, "dist", "native", "bridge.js")).engineStats;
    const wordWrap = cliWordWrap(reference);
    return {
        ref: { qt: refQt, Stream: streamClassFor(reference, refQt), wordWrap, wrap: (f) => f() },
        ours: {
            qt: oursQt,
            Stream: streamClassFor(reference, oursQt),
            wordWrap,
            stats,
            wrap: async (f) => {
                const saved = globalThis[engineKey];
                globalThis[engineKey] = "wasm";
                try {
                    return await f();
                } finally {
                    globalThis[engineKey] = saved;
                }
            },
        },
    };
}

// ---- CLI ---------------------------------------------------------------------

/** A file name for a top-level's sample (top-level names may be anything). */
function sampleFile(i, j) {
    return `in/s${i}-${j}.json`;
}

/**
 * The CLI arguments for a case, and the files they need (relative paths).
 * Undefined when the case cannot be given to a CLI (a NUL in an argument).
 */
export function cliInvocation(kase) {
    const files = new Map();
    const args = ["--lang", kase.lang];
    if (kase.src === "json") {
        args.push("--src-lang", "json");
        if (kase.topLevels.length === 1) {
            const [tl] = kase.topLevels;
            args.push("--top-level", tl.name);
            tl.samples.forEach((s, j) => {
                files.set(sampleFile(0, j), s);
                args.push(sampleFile(0, j));
            });
        } else {
            // One file per top-level in a directory, named after it; a
            // top-level with several samples is a subdirectory of them.
            for (const tl of kase.topLevels) {
                if (tl.samples.length === 1) files.set(`in/${tl.name}.json`, tl.samples[0]);
                else tl.samples.forEach((s, j) => files.set(`in/${tl.name}/s${j}.json`, s));
            }

            args.push("in");
        }
    } else if (kase.src === "mixed") {
        // A directory of JSON samples and schemas, each a top-level named after its file.
        args.push("--src-lang", "json");
        for (const tl of kase.topLevels) files.set(`in/${tl.name}.json`, tl.samples[0]);
        for (const s of kase.schemas) files.set(`in/${s.name}.schema`, s.text);
        args.push("in");
    } else if (kase.src === "postman") {
        args.push("--src-lang", "postman");
        files.set("in/collection.json", kase.postman);
        args.push("in/collection.json");
    } else if (kase.src === "graphql") {
        args.push("--src-lang", "graphql", "--graphql-schema", "in/schema.gqlschema", "--top-level", kase.graphql.name);
        files.set("in/schema.gqlschema", kase.graphql.schema);
        for (const q of kase.graphql.queries) {
            // Several query files are top-levels named after the file.
            const file = kase.graphql.queries.length === 1 ? "in/query.graphql" : `in/${q.name}.graphql`;
            files.set(file, q.query);
            args.push(file);
        }
    } else {
        args.push("--src-lang", "schema");
        const [s] = kase.schemas;
        // The file name matters: without --top-level it names the top-level.
        // (With a chosen file name, no --top-level: the file names it.)
        const file = `in/${kase.cli?.schemaFile ?? "schema.json"}`;
        if (kase.cli?.schemaFile === undefined) args.push("--top-level", s.name);
        files.set(file, s.text);
        args.push(file);
    }

    for (const [name, value] of Object.entries(kase.rendererOptions)) {
        if (value === true) args.push(`--${name}`);
        else args.push(`--${name}`, String(value));
    }

    for (const [name, cli] of INFERENCE_FLAGS) if (kase.flags[name] === false) args.push(cli);
    if (kase.flags.alphabetizeProperties) args.push("--alphabetize-properties");
    if (kase.flags.allPropertiesOptional) args.push("--all-properties-optional");
    if (kase.cli?.quiet) args.push("--quiet");
    if (kase.debug !== undefined && kase.debug.length > 0) args.push("--debug", kase.debug.join(","));
    if (kase.cli?.out !== undefined) args.push("--out", kase.cli.out);
    if (args.some((a) => a.includes("\0"))) return undefined;
    return { args, files, dirs: kase.cli?.out !== undefined ? [path.dirname(kase.cli.out)] : [] };
}

/**
 * Whether a CLI run can reproduce the case at all: one sample per
 * top-level for directories, top-levels named after their files, and
 * every file the run writes one that Windows, macOS and Linux can all hold
 * (file-names.mjs), so that it can be written here and recorded.
 */
export function cliCompatible(kase) {
    if (kase.src === "schema" && kase.schemas.length > 1) return false;
    let fileNamed = [];
    if (kase.src === "mixed") {
        fileNamed = [...kase.topLevels.map((tl) => tl.name), ...kase.schemas.map((s) => s.name)];
        if (kase.topLevels.some((tl) => tl.samples.length !== 1)) return false;
        if (kase.schemas.some((s) => s.uris !== undefined)) return false;
    }

    if (kase.src === "json" && kase.topLevels.length > 1) fileNamed = kase.topLevels.map((tl) => tl.name);
    // A top-level read from a directory is named after its file.
    if (fileNamed.some((n) => n === "" || n.startsWith(".") || n.includes("/"))) return false;
    if (new Set(fileNamed.map((n) => n.toLowerCase())).size !== fileNamed.length) return false;
    const invocation = cliInvocation(kase);
    if (invocation === undefined) return false;
    const written = [...invocation.files.keys(), ...invocation.dirs];
    if (kase.cli?.out !== undefined) written.push(kase.cli.out);
    return unportablePaths(written).length === 0;
}

function snapshot(dir) {
    const out = {};
    const walk = (d) => {
        for (const entry of fs.readdirSync(d, { withFileTypes: true })) {
            const full = path.join(d, entry.name);
            if (entry.isDirectory()) walk(full);
            else out[path.relative(dir, full)] = fs.readFileSync(full).toString("latin1");
        }
    };
    walk(dir);
    return out;
}

function runProcess(command, args, cwd, timeoutMs) {
    return new Promise((resolve) => {
        const child = spawn(command, args, {
            cwd,
            env: { ...cleanEnv(), TZ: "UTC", NODE_NO_WARNINGS: "1" },
            stdio: ["ignore", "pipe", "pipe"],
        });
        const stdout = [];
        const stderr = [];
        child.stdout.on("data", (d) => stdout.push(d));
        child.stderr.on("data", (d) => stderr.push(d));
        const timer = setTimeout(() => child.kill("SIGKILL"), timeoutMs);
        child.on("error", (e) => {
            clearTimeout(timer);
            resolve({ code: null, signal: String(e), stdout: "", stderr: "" });
        });
        child.on("close", (code, signal) => {
            clearTimeout(timer);
            resolve({ code, signal, stdout: Buffer.concat(stdout).toString("latin1"), stderr: Buffer.concat(stderr).toString("latin1") });
        });
    });
}

function cleanEnv() {
    const env = { ...process.env };
    for (const name of ["FORCE_COLOR", "NO_COLOR", "NODE_OPTIONS", "QUICKTYPE_ENGINE"]) delete env[name];
    return env;
}

/**
 * Runs the CLI invocation with `command` (argv prefix) in a fresh directory
 * and returns { exit, stdout, stderr, files } with the directory replaced by
 * {CWD}.
 */
export async function runCli(command, invocation, timeoutMs = 120_000) {
    const dir = fs.realpathSync(fs.mkdtempSync(path.join(os.tmpdir(), "qt-fuzz-cli-")));
    try {
        for (const d of ["in", ...invocation.dirs]) fs.mkdirSync(path.join(dir, d), { recursive: true });
        for (const [file, text] of invocation.files) {
            fs.mkdirSync(path.dirname(path.join(dir, file)), { recursive: true });
            fs.writeFileSync(path.join(dir, file), text);
        }
        const before = snapshot(dir);
        const r = await runProcess(command[0], [...command.slice(1), ...invocation.args], dir, timeoutMs);
        const after = snapshot(dir);
        const files = {};
        for (const [f, content] of Object.entries(after)) if (before[f] !== content) files[f] = content;
        const norm = (s) => s.split(dir).join("{CWD}");
        return {
            exit: r.code === null ? `killed (${r.signal})` : r.code,
            stdout: norm(r.stdout),
            stderr: norm(r.stderr),
            files: Object.fromEntries(Object.entries(files).map(([k, v]) => [k, norm(v)])),
        };
    } finally {
        fs.rmSync(dir, { recursive: true, force: true });
    }
}

export function cliCommands(reference, ourBinary) {
    return {
        ref: [process.execPath, path.join(reference, "dist", "index.js")],
        ours: [ourBinary ?? path.join(repoRoot, "target", "release", "quicktype")],
    };
}

/** Each language's CLI renderer option definitions, from the reference. */
export function optionDefinitions(refQt) {
    const table = {};
    for (const l of refQt.defaultTargetLanguages) {
        table[l.name] = l.cliOptionDefinitions.actual.map((d) => ({
            name: d.name,
            optionType: d.optionType,
            legalValues: d.values === undefined ? undefined : Object.keys(d.values),
        }));
    }

    return table;
}
