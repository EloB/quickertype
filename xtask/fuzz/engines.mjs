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
// * "jsonl": the same, but our binary reads JSON Lines files (not in
//   quicktype) where the reference reads the JSON arrays of their values
//   (`jsonlInvocations`): the outcomes must be identical.
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
import { Rng } from "./rng.mjs";
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

    args.push(...optionArgs(kase));
    if (args.some((a) => a.includes("\0"))) return undefined;
    return { args, files, dirs: kase.cli?.out !== undefined ? [path.dirname(kase.cli.out)] : [] };
}

/** The CLI arguments for a case's options (after its inputs). */
function optionArgs(kase) {
    const args = [];
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
    return args;
}

/** Whether `text` is one JSON value (with whitespace around it). */
function isOneValue(text) {
    try {
        JSON.parse(text);
        return true;
    } catch {
        return false;
    }
}

/**
 * The "jsonl" mode's two CLI invocations of a JSON case, `{ ours, ref }`
 * (each as `cliInvocation` returns one), or undefined if the mode cannot
 * run the case (see `cliCompatible`). Each top-level's samples (those
 * that are one JSON value) are grouped, in order, into files: our binary
 * reads a group as a JSON Lines file (values on lines of their own, with
 * LF or CRLF, blank lines, whitespace before and after, now and then a
 * byte order mark first), the reference as a `.json` file of the JSON
 * array of the group's values (`[V1,…,Vn]`, `[]` for none). A group of one
 * may also stay a plain `.json` sample on both sides, so that one
 * top-level mixes the two. One top-level's files are the arguments,
 * named `.jsonl`, `.ndjson` or `.JSONL`, or anything with `--src-lang
 * jsonl` (then all are JSON Lines); one file is sometimes named after the
 * top-level, without `--top-level`. Several top-levels are a directory,
 * where each file's name says what it holds whatever `--src-lang` says,
 * which is none, `json` or `jsonl`. Half the time our binary reads its
 * files on several threads, with ranges small enough to split them (the
 * internal variables `QUICKTYPE_READ_THREADS` and `QUICKTYPE_READ_CHUNK`,
 * which change nothing in the output). The choices are a function of the
 * case and its seed, so a saved case replays them.
 */
export function jsonlInvocations(kase) {
    if (!cliCompatible(kase)) return undefined;
    if (kase.src !== "json") return strayInvocation(kase);
    const rng = new Rng((kase.seed ?? 0) ^ 0x75e1);
    const separators = ["\n", "\r\n", "\n\n", "\n \t\n", " \r\n", "\r\n\r\n"];
    const arounds = ["", "\n", "\r\n", " \n", "\n\n"];
    const several = kase.topLevels.length > 1;
    // For arguments: `--src-lang jsonl` makes every file JSON Lines,
    // otherwise their names do. A directory goes by the names either way
    // (with another `--src-lang`, it would be quicktype's and ignore them).
    const srcLang = several ? rng.pick([undefined, "jsonl"]) : rng.chance(0.3) ? "jsonl" : undefined;
    const byName = several || srcLang === undefined;
    const lineFiles = (values) => {
        const between = rng.sample(separators, rng.range(1, 3));
        const text = values.map((v, i) => (i === 0 ? "" : between[i % between.length]) + v).join("");
        const bom = rng.chance(0.1) ? "﻿" : "";
        return { ours: bom + rng.pick(arounds) + text + rng.pick(arounds), ref: `[${values.join(",")}]` };
    };
    // Per top-level: its files, each { ours, ref, lines }.
    const groups = kase.topLevels.map((tl) => {
        const values = tl.samples.filter(isOneValue);
        const files = [];
        let i = 0;
        do {
            const n = Math.min(values.length - i, rng.weighted([[3, 1], [3, 2], [2, values.length], [1, 0]]));
            const group = values.slice(i, i + Math.max(n, 0));
            i += group.length;
            if (byName && group.length === 1 && rng.chance(0.25)) files.push({ ours: group[0], ref: group[0], lines: false });
            else files.push({ ...lineFiles(group), lines: true });
        } while (i < values.length);
        return files;
    });
    const extension = (f) =>
        !f.lines ? "json" : byName ? rng.pick(["jsonl", "jsonl", "ndjson", "JSONL"]) : rng.pick(["json", "jsonl", "txt", "ndjson"]);
    const ours = new Map();
    const ref = new Map();
    const oursArgs = ["--lang", kase.lang];
    const refArgs = ["--lang", kase.lang, "--src-lang", "json"];
    if (srcLang !== undefined) oursArgs.push("--src-lang", srcLang);
    if (!several) {
        const [tl] = kase.topLevels;
        const [files] = groups;
        // One file named after the top-level, which names it.
        const named = files.length === 1 && files[0].lines && /^[A-Za-z][A-Za-z0-9_-]{0,30}$/.test(tl.name) && rng.chance(0.3);
        if (!named) {
            oursArgs.push("--top-level", tl.name);
            refArgs.push("--top-level", tl.name);
        }

        files.forEach((f, j) => {
            const base = named ? `in/${tl.name}` : `in/s0-${j}`;
            const oursFile = `${base}.${extension(f)}`;
            ours.set(oursFile, f.ours);
            ref.set(`${base}.json`, f.ref);
            oursArgs.push(oursFile);
            refArgs.push(`${base}.json`);
        });
    } else {
        // A directory, read in the order of its (sorted) names: our names
        // must sort as the reference's do.
        const placed = [];
        kase.topLevels.forEach((tl, t) => {
            const files = groups[t];
            const bases = files.length === 1 ? [`in/${tl.name}`] : files.map((_, j) => `in/${tl.name}/s${j}`);
            files.forEach((f, j) => placed.push([`${bases[j]}.${extension(f)}`, `${bases[j]}.json`, f]));
        });
        const order = (names) => names.map((n, i) => [Buffer.from(n), i]).sort(([a], [b]) => Buffer.compare(a, b)).map(([, i]) => i).join();
        if (order(placed.map(([o]) => o)) !== order(placed.map(([, r]) => r))) return undefined;
        for (const [o, r, f] of placed) {
            ours.set(o, f.ours);
            ref.set(r, f.ref);
        }

        oursArgs.push("in");
        refArgs.push("in");
    }

    const options = optionArgs(kase);
    oursArgs.push(...options);
    refArgs.push(...options);
    if ([...oursArgs, ...refArgs].some((a) => a.includes("\0"))) return undefined;
    const written = [...ours.keys(), ...ref.keys()];
    if (kase.cli?.out !== undefined) written.push(kase.cli.out);
    if (unportablePaths(written).length > 0) return undefined;
    // Two names that differ only in case would collide on Windows and macOS.
    if (new Set(written.map((f) => f.toLowerCase())).size !== new Set(written).size) return undefined;
    const dirs = kase.cli?.out !== undefined ? [path.dirname(kase.cli.out)] : [];
    const env = rng.chance(0.5)
        ? { QUICKTYPE_READ_THREADS: String(rng.range(2, 4)), QUICKTYPE_READ_CHUNK: String(rng.pick([1, 7, 64, 4096])) }
        : undefined;
    return { ours: { args: oursArgs, files: ours, dirs, env }, ref: { args: refArgs, files: ref, dirs } };
}

/**
 * The "jsonl" mode's invocations of a JSON Schema, GraphQL or mixed case:
 * a directory read with an explicit `--src-lang` other than `jsonl`
 * (`schema` for a schema, `json` otherwise), which holds stray JSON Lines
 * files besides the case's own, the same on both sides. With such a
 * `--src-lang` quickertype is quicktype, whose directories ignore
 * `.jsonl` and `.ndjson` files: the outcomes must be identical. The schema
 * sits in a subdirectory beside a stray file, where reading it would mix
 * JSON with JSON Schema.
 */
function strayInvocation(kase) {
    const files = new Map();
    let args;
    if (kase.src === "mixed") {
        const invocation = cliInvocation(kase);
        if (invocation === undefined) return undefined;
        for (const [f, text] of invocation.files) files.set(f, text);
        args = invocation.args;
    } else if (kase.src === "schema") {
        if (kase.schemas[0].uris !== undefined) return undefined;
        files.set("in/sub/TopLevel.schema", kase.schemas[0].text);
        args = ["--lang", kase.lang, "--src-lang", "schema", "in", ...optionArgs(kase)];
    } else if (kase.src === "graphql") {
        files.set("in/schema.gqlschema", kase.graphql.schema);
        for (const q of kase.graphql.queries) files.set(kase.graphql.queries.length === 1 ? "in/query.graphql" : `in/${q.name}.graphql`, q.query);
        args = ["--lang", kase.lang, "--src-lang", "json", "in", ...optionArgs(kase)];
    } else {
        return undefined;
    }

    const lines = '{"a": 1, "b": "x"}\n{"a": 2.5}\n';
    files.set(kase.src === "schema" ? "in/sub/data.jsonl" : "in/stray.jsonl", lines);
    files.set("in/zz/more.NDJSON", lines);
    if (args.some((a) => a.includes("\0"))) return undefined;
    const written = [...files.keys()];
    if (kase.cli?.out !== undefined) written.push(kase.cli.out);
    if (unportablePaths(written).length > 0) return undefined;
    if (new Set(written.map((f) => f.toLowerCase())).size !== new Set(written).size) return undefined;
    const dirs = kase.cli?.out !== undefined ? [path.dirname(kase.cli.out)] : [];
    const invocation = { args, files, dirs };
    return { ours: invocation, ref: invocation };
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

function runProcess(command, args, cwd, timeoutMs, env = {}) {
    return new Promise((resolve) => {
        const child = spawn(command, args, {
            cwd,
            env: { ...cleanEnv(), TZ: "UTC", NODE_NO_WARNINGS: "1", ...env },
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
 * (with the invocation's `env`, if any, added to the environment) and
 * returns { exit, stdout, stderr, files } with the directory replaced by
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
        const r = await runProcess(command[0], [...command.slice(1), ...invocation.args], dir, timeoutMs, invocation.env);
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
        ours: [ourBinary ?? path.join(repoRoot, "target", "release", "quickertype")],
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
