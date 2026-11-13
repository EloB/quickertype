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

import { spawn } from "node:child_process";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as os from "node:os";
import * as path from "node:path";
import { Readable } from "node:stream";
import { fileURLToPath, pathToFileURL } from "node:url";
import * as vm from "node:vm";

import { INFERENCE_FLAGS } from "./generate.mjs";

export const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "..");
export const packageRoot = path.join(repoRoot, "npm", "quicktype-core");
const engineKey = Symbol.for("quicktype-core.engine");
const nativeInputsKey = Symbol.for("quicktype-core.nativeInputs");

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

/**
 * The reference CLI's CompressedJSONFromStream, compiled against `qt` (a
 * quicktype-core) instead of the reference's own.
 */
function streamClassFor(reference, qt) {
    const file = path.join(reference, "dist", "CompressedJSONFromStream.js");
    const refRequire = createRequire(file);
    const source = fs.readFileSync(file, "utf8");
    const fn = vm.compileFunction(source, ["exports", "require", "module", "__filename", "__dirname"], { filename: file });
    const module = { exports: {} };
    fn(module.exports, (id) => (id === "quicktype-core" ? qt : refRequire(id)), module, file, path.dirname(file));
    return module.exports.CompressedJSONFromStream;
}

export function loadSides(reference) {
    const requireHere = createRequire(import.meta.url);
    const refQt = requireHere(path.join(reference, "packages", "quicktype-core"));
    const refStream = requireHere(path.join(reference, "dist", "CompressedJSONFromStream.js")).CompressedJSONFromStream;
    const oursQt = requireHere(packageRoot);
    const stats = requireHere(path.join(packageRoot, "dist", "native", "bridge.js")).engineStats;
    const oursStream = streamClassFor(reference, oursQt);
    const registered = globalThis[nativeInputsKey];
    globalThis[nativeInputsKey] = [...(Array.isArray(registered) ? registered : []), oursStream];
    return {
        ref: { qt: refQt, Stream: refStream, wrap: (f) => f() },
        ours: {
            qt: oursQt,
            Stream: oursStream,
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

/** quicktype options for a case (what the CLI's makeQuicktypeOptions would give, plus API extras). */
export function quicktypeOptions(kase, inputData, withApiExtras = true) {
    const options = {
        lang: kase.lang,
        inputData,
        rendererOptions: kase.rendererOptions,
        alphabetizeProperties: kase.flags.alphabetizeProperties === true,
        allPropertiesOptional: kase.flags.allPropertiesOptional === true,
    };
    for (const [name] of INFERENCE_FLAGS) options[name] = kase.flags[name] !== false;
    if (withApiExtras) {
        for (const key of ["indentation", "leadingComments", "outputFilename"]) {
            if (kase.api?.[key] !== undefined) options[key] = kase.api[key];
        }
    }

    return options;
}

/** Runs a case in-process on one side ("api" or "stream" mode). */
export async function runInProcess(side, kase, mode) {
    const { qt } = side;
    const inputData = new qt.InputData();
    if (kase.src === "json") {
        const handleRefs = kase.flags.ignoreJsonRefs === false;
        let input;
        if (mode === "stream") {
            const lang = qt.getTargetLanguage(kase.lang);
            input = new qt.JSONInput(
                new side.Stream(lang.dateTimeRecognizer, handleRefs, lang.getSupportedIntegerRange(kase.rendererOptions)),
            );
        } else {
            input = qt.jsonInputForTargetLanguage(kase.lang, undefined, handleRefs, kase.rendererOptions);
        }

        for (const tl of kase.topLevels) {
            const samples = mode === "stream" ? tl.samples.map((s) => Readable.from([Buffer.from(s, "utf8")])) : tl.samples;
            await input.addSource({ name: tl.name, samples });
        }

        inputData.addInput(input);
    } else {
        const input = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore(), [], []);
        for (const s of kase.schemas) await input.addSource({ name: s.name, schema: s.text });
        inputData.addInput(input);
    }

    return await qt.quicktypeMultiFile(quicktypeOptions(kase, inputData, mode === "api"));
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
            // One file per top-level in a directory; the file name is the top-level name.
            for (const tl of kase.topLevels) {
                files.set(`in/${tl.name}.json`, tl.samples[0]);
            }

            args.push("in");
        }
    } else {
        args.push("--src-lang", "schema");
        const [s] = kase.schemas;
        args.push("--top-level", s.name);
        files.set("in/schema.json", s.text);
        args.push("in/schema.json");
    }

    for (const [name, value] of Object.entries(kase.rendererOptions)) {
        if (value === true) args.push(`--${name}`);
        else args.push(`--${name}`, String(value));
    }

    for (const [name, cli] of INFERENCE_FLAGS) if (kase.flags[name] === false) args.push(cli);
    if (kase.flags.alphabetizeProperties) args.push("--alphabetize-properties");
    if (kase.flags.allPropertiesOptional) args.push("--all-properties-optional");
    if (kase.cli?.quiet) args.push("--quiet");
    if (kase.cli?.out !== undefined) args.push("--out", kase.cli.out);
    if (args.some((a) => a.includes("\0"))) return undefined;
    return { args, files, dirs: kase.cli?.out !== undefined ? [path.dirname(kase.cli.out)] : [] };
}

/** Whether a CLI run can reproduce the case at all (one sample per top-level for directories). */
export function cliCompatible(kase) {
    if (kase.src === "json" && kase.topLevels.length > 1) {
        if (kase.topLevels.some((tl) => tl.samples.length !== 1)) return false;
        const names = kase.topLevels.map((tl) => tl.name);
        if (names.some((n) => n === "" || n.includes("/") || n.startsWith(".") || n.length > 100)) return false;
        if (new Set(names.map((n) => n.toLowerCase())).size !== names.length) return false;
    }

    return cliInvocation(kase) !== undefined;
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
        for (const [file, text] of invocation.files) fs.writeFileSync(path.join(dir, file), text);
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
