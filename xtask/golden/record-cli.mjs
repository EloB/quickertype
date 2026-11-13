#!/usr/bin/env node
// Records the CLI-behavior golden cases (tests/golden/cli-*): runs of the
// reference quicktype CLI whose stdout, stderr and exit code are part of the
// expected result, not only the files it writes.
//
// Unlike record-hook.cjs, which piggybacks on quicktype's fixture harness,
// this script spawns `node dist/index.js` directly, with stdout and stderr
// piped (so not a TTY), stdin from a file or empty, TZ=UTC, and without
// FORCE_COLOR / NO_COLOR / NODE_OPTIONS from the caller's environment.
// `cargo xtask parity` replays the cases under the same conditions.
//
// Layout (same as finalize.mjs; the hash covers argv, stdin and env):
//
//   tests/golden/<fixture>/<input>/<hash>/case.json
//   tests/golden/<fixture>/<input>/<hash>/step<N>/<written files>
//   tests/golden/<fixture>/<input>/<hash>/step<N>.stdout   (absent if empty)
//   tests/golden/<fixture>/<input>/<hash>/step<N>.stderr   (absent if empty)
//
// Absolute paths in stdout/stderr are normalized: the inputs directory
// becomes {INPUTS} and the step's working directory becomes {CWD}.
//
// Usage: record-cli.mjs <quicktype-checkout> <golden-dir> <inputs-dir>
// Only tests/golden/cli-* is replaced; the other cases are left alone.

import { spawn } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as os from "node:os";
import * as path from "node:path";

const [refArg, goldenArg, inputsArg] = process.argv.slice(2);
if (!refArg || !goldenArg || !inputsArg) {
    console.error("usage: record-cli.mjs <quicktype-checkout> <golden-dir> <inputs-dir>");
    process.exit(2);
}
const refDir = path.resolve(refArg);
const goldenDir = path.resolve(goldenArg);
const inputsDir = path.resolve(inputsArg);
const cliPath = path.join(refDir, "dist", "index.js");
const require = createRequire(import.meta.url);
const core = require(path.join(refDir, "node_modules", "quicktype-core"));

const sha = (data) => createHash("sha256").update(data).digest("hex");

// ---------------------------------------------------------------------------
// Case definitions

const cases = [];

/**
 * @param {string} fixture  cli-* group name
 * @param {string} input    label for the layout (an input path, or "_")
 * @param {Array<string[] | {args: string[], stdin?: string}>} steps
 * @param {Record<string, string>} [env]
 */
function add(fixture, input, steps, env) {
    cases.push({
        fixture,
        input,
        env,
        steps: steps.map((s) => (Array.isArray(s) ? { args: s } : s)),
    });
}

const IN = (p) => `{INPUTS}/${p}`;
const languages = core.defaultTargetLanguages;
const langNames = languages.map((l) => l.name);

const JSON_SAMPLE = "json/samples/spotify-album.json";
const SCHEMA_SAMPLE = "schema/description.schema";
const GQL_SCHEMA = "graphql/github.gqlschema";
const GQL_QUERY = "graphql/github1.graphql";
const SWEEP_JSON = "json/samples/kitchen-sink.json";
const SWEEP_SCHEMA = "schema/date-time.schema";
const SMALL_JSON = "json/samples/getting-started.json";
const OTHER_JSON = "json/samples/simple-object.json";

// --- cli-version ------------------------------------------------------------
for (const args of [
    ["--version"],
    ["-v"],
    ["-v", "-l", "cs"],
    ["--version", "--quiet"],
    ["--version", "--lang", "foo"],
    ["--version", "--help"],
    ["-hv"],
    ["--version", "--telemetry", "disable"],
    ["--version", "--telemetry", "bad"],
    ["--version", IN(SMALL_JSON)],
]) {
    add("cli-version", "_", [args]);
}

// --- cli-help ---------------------------------------------------------------
for (const args of [
    [],
    ["--help"],
    ["-h"],
    ["-h", "-l", "csharp"],
    ["--help", "--lang", "cs", "--framework", "NewtonSoft"],
    ["--help", "--just-types"],
    ["--help", "--framework", "NewtonSoft"],
    ["--help", "--out", "Foo.kt"],
    ["--help", "--out", "Foo.swift"],
    ["--help", IN(SMALL_JSON)],
    ["--help", "--telemetry", "enable"],
]) {
    add("cli-help", "_", [args]);
}
for (const name of langNames) add("cli-help", "_", [["--help", "--lang", name]]);
for (const force of ["1", "0", "true", "false", "3", ""]) {
    add("cli-help", "_", [["--help"]], { FORCE_COLOR: force });
}
add("cli-help", "_", [[]], { FORCE_COLOR: "1" });

// --- cli-stdout: default output of every language ------------------------------
for (const name of langNames) {
    add("cli-stdout", JSON_SAMPLE, [["--lang", name, IN(JSON_SAMPLE)]]);
    add("cli-stdout", SCHEMA_SAMPLE, [["--lang", name, "--src-lang", "schema", IN(SCHEMA_SAMPLE)]]);
    add("cli-stdout", GQL_QUERY, [
        ["--lang", name, "--src-lang", "graphql", "--graphql-schema", IN(GQL_SCHEMA), IN(GQL_QUERY)],
    ]);
}

// --- cli-options: every renderer option and every legal value -----------------
function stringOptionValue(lang, option) {
    switch (option) {
        case "hashtable-size":
            return "128";
        case "namespace":
            return "MyNamespace";
        case "enum-type":
            return "uint8_t";
        case "part-name":
            return "model";
        case "module":
            return "MyModule";
        case "package":
            return lang === "go" ? "model" : "com.example";
        case "field-tags":
            return "json,yaml";
        case "class-prefix":
            return "XY";
        case "coding-keys-protocol":
            return "Equatable, Hashable";
        case "type-prefix":
            return "QT";
        default:
            return "Custom";
    }
}

function optionVariants(lang) {
    const variants = [];
    for (const def of lang.optionDefinitions) {
        switch (def.optionType) {
            case "boolean":
                variants.push([`--${def.name}`], [`--no-${def.name}`]);
                break;
            case "enum":
                for (const value of Object.keys(def.values)) variants.push([`--${def.name}`, value]);
                break;
            case "string":
                variants.push([`--${def.name}`, stringOptionValue(lang.name, def.name)]);
                break;
            default:
                throw new Error(`unknown option type ${def.optionType}`);
        }
    }
    return variants;
}

for (const lang of languages) {
    for (const variant of optionVariants(lang)) {
        add("cli-options", SWEEP_JSON, [["--lang", lang.name, ...variant, IN(SWEEP_JSON)]]);
        add("cli-options", SWEEP_SCHEMA, [
            ["--lang", lang.name, ...variant, "--src-lang", "schema", IN(SWEEP_SCHEMA)],
        ]);
    }
}

// --- cli-global-options: inference flags and other global switches -------------
const globalFlags = [
    "--no-maps",
    "--no-enums",
    "--no-uuids",
    "--no-date-times",
    "--no-integer-strings",
    "--no-boolean-strings",
    "--no-combine-classes",
    "--no-ignore-json-refs",
    "--alphabetize-properties",
    "--all-properties-optional",
    "--quiet",
    "--no-render",
];
for (const lang of ["typescript", "cs", "go", "python", "kotlin"]) {
    for (const flag of globalFlags) {
        add("cli-global-options", SWEEP_JSON, [["--lang", lang, flag, IN(SWEEP_JSON)]]);
    }
}
for (const flag of ["--alphabetize-properties", "--all-properties-optional", "--no-enums"]) {
    add("cli-global-options", SWEEP_SCHEMA, [["--lang", "typescript", flag, "--src-lang", "schema", IN(SWEEP_SCHEMA)]]);
}
for (const debug of [
    "provenance",
    "print-graph",
    "print-reconstitution",
    "print-gather-names",
    "print-transformations",
    "print-schema-resolving",
    "provenance, print-graph",
]) {
    add("cli-global-options", SMALL_JSON, [["--lang", "typescript", "--debug", debug, IN(SMALL_JSON)]]);
}
add("cli-global-options", SWEEP_SCHEMA, [
    ["--lang", "typescript", "--debug", "print-schema-resolving", "--src-lang", "schema", IN(SWEEP_SCHEMA)],
]);
add("cli-global-options", SWEEP_SCHEMA, [
    ["--lang", "typescript", "-S", IN("schema/simple-ref.schema"), "--src-lang", "schema", IN(SWEEP_SCHEMA)],
]);

// --- cli-sources: directories, stdin, multiple sources ------------------------
for (const args of [
    ["--lang", "typescript", IN("spotify-api")],
    ["--lang", "go", "--src", IN("spotify-api")],
    ["--lang", "cs", IN("spotify-api/Album")],
    ["--lang", "typescript", IN("spotify-api"), IN(SMALL_JSON)],
]) {
    add("cli-sources", "spotify-api", [args]);
}
for (const args of [
    ["--lang", "typescript"],
    ["--lang", "go", "--src", "-"],
    ["--lang", "typescript", "-"],
    ["--lang", "typescript", "--top-level", "Person"],
    ["--lang", "rust", "-t", "Person", "-"],
    ["-l", "swift"],
]) {
    add("cli-sources", SMALL_JSON, [{ args, stdin: IN(SMALL_JSON) }]);
}
add("cli-sources", SCHEMA_SAMPLE, [{ args: ["--lang", "typescript", "--src-lang", "schema"], stdin: IN(SCHEMA_SAMPLE) }]);
add("cli-sources", "_", [["--lang", "typescript"]]);
for (const args of [
    ["--lang", "typescript", IN(SMALL_JSON), IN(OTHER_JSON)],
    ["--lang", "typescript", "--src", IN(SMALL_JSON), "--src", IN(OTHER_JSON)],
    ["--lang", "typescript", "--src", IN(SMALL_JSON), IN(OTHER_JSON)],
    ["--lang", "cs", "-t", "Merged", IN(SMALL_JSON), IN(OTHER_JSON)],
]) {
    add("cli-sources", SMALL_JSON, [args]);
}
add("cli-sources", SWEEP_SCHEMA, [
    ["--lang", "typescript", "--src-lang", "schema", IN(SWEEP_SCHEMA), IN(SCHEMA_SAMPLE)],
]);
add("cli-sources", GQL_QUERY, [
    ["--lang", "typescript", "--src-lang", "graphql", "--graphql-schema", IN(GQL_SCHEMA), IN(GQL_QUERY), IN("graphql/github2.graphql")],
]);
add("cli-sources", GQL_QUERY, [
    ["--lang", "typescript", "--graphql-schema", IN(GQL_SCHEMA), IN(GQL_QUERY)],
]);

// --- cli-inference: top-level names and language from --out --------------------
for (const args of [
    [IN(SMALL_JSON)],
    ["--lang", "typescript", IN(SMALL_JSON)],
    ["--lang", "typescript", "--src", IN("json/priority/omit-empty.out.omit-empty.json")],
    ["--lang", "typescript", "--src-lang", "schema", IN(SWEEP_SCHEMA)],
    ["--lang", "typescript", "--top-level", "Custom", IN(SMALL_JSON)],
    ["--lang", "typescript", "--out", "Foo.bar.ts", IN(SMALL_JSON)],
    ["--out", "Foo.ts", "--lang", "go", IN(SMALL_JSON)],
    ["--out", "foo", IN(SMALL_JSON)],
    ["--out", "foo.d.ts", IN(SMALL_JSON)],
    ["--out", ".ts", IN(SMALL_JSON)],
]) {
    add("cli-inference", SMALL_JSON, [args]);
}
for (const ext of [
    "cs", "ts", "tsx", "go", "py", "rs", "java", "swift", "dart", "elm", "php", "js", "jsx",
    "cpp", "cr", "schema", "haskell", "kotlin", "kt", "hpp", "h", "m", "rb", "ex", "scala", "pmod", "smithy",
]) {
    add("cli-inference", SMALL_JSON, [["--out", `Generated.${ext}`, IN(SMALL_JSON)]]);
}

// --- cli-output: multi-file results with --out and on stdout --------------------
for (const args of [
    ["--lang", "go", "--multi-file-output", "--out", "TopLevel.go"],
    ["--lang", "swift", "--multi-file-output", "--out", "TopLevel.swift"],
    ["--lang", "cjson", "--source-style", "multi-source", "--out", "TopLevel.h"],
    ["--lang", "c++", "--source-style", "multi-source", "--out", "TopLevel.hpp"],
    ["--lang", "java", "--out", "TopLevel.java"],
    ["--lang", "objc", "--out", "TopLevel.m"],
    ["--lang", "java"],
    ["--lang", "typescript", "--out", "missing-dir/TopLevel.ts"],
]) {
    add("cli-output", SWEEP_JSON, [[...args, IN(SWEEP_JSON)]]);
}
add("cli-output", SWEEP_JSON, [
    ["--lang", "typescript", "--out", "First.ts", IN(SWEEP_JSON)],
    ["--lang", "go", "--out", "Second.go", IN(SWEEP_JSON)],
]);

// --- cli-errors: argument parsing and early failures --------------------------
const errorCases = [
    // unknown language / source language
    ["--lang", "foo", IN(SMALL_JSON)],
    ["--lang", "python3", IN(SMALL_JSON)],
    ["-l", "Go", IN(SMALL_JSON)],
    ["--lang=", IN(SMALL_JSON)],
    ["--lang=cs", IN(SMALL_JSON)],
    ["--lang", "$&", IN(SMALL_JSON)],
    ["--src-lang", "foo", IN(SMALL_JSON)],
    ["--src-lang", "graphql", IN(SMALL_JSON)],
    ["--src-lang", "json", "--graphql-schema", IN(GQL_SCHEMA), IN(GQL_QUERY)],
    ["--src-lang", "graphql", "--graphql-schema", IN(GQL_SCHEMA)],
    ["--help", "--lang", "foo"],
    // unknown options and values
    ["--foo"],
    ["--foo", IN(SMALL_JSON)],
    ["--foo", "bar", IN(SMALL_JSON)],
    ["-x"],
    ["-lts"],
    ["-o=x.ts", IN(SMALL_JSON)],
    ["-o=1", IN(SMALL_JSON)],
    ["--quiet=false", IN(SMALL_JSON)],
    ["--lang", "cs", "--just-types=false", IN(SMALL_JSON)],
    ["--lang", "cs", "--namespace=", IN(SMALL_JSON)],
    ["--lang", "cs", "--namespace=Foo=Bar", IN(SMALL_JSON)],
    ["--framework", "NewtonSoft", IN(SMALL_JSON)],
    ["--lang", "go", "--framework", "NewtonSoft", IN(SMALL_JSON)],
    ["--no-color", "--help"],
    ["--color", "--help"],
    ["---lang", "cs"],
    ["--=foo"],
    ["-é", IN(SMALL_JSON)],
    // missing values
    ["--lang"],
    ["-l"],
    ["--out"],
    ["--top-level"],
    ["--src-lang"],
    ["--lang", "--out", "x.ts"],
    ["--lang", "cs", "--namespace"],
    ["--lang", "cs", "--namespace", "--quiet", IN(SMALL_JSON)],
    ["--lang", "cs", "--framework"],
    ["--telemetry"],
    ["--debug"],
    // options set twice
    ["-o", "list.go", "-o", "list.ts", IN(SMALL_JSON)],
    ["--quiet", "--quiet", IN(SMALL_JSON)],
    ["--lang", "cs", "--lang", "go", IN(SMALL_JSON)],
    ["--lang", "cs", "--virtual", "--virtual", IN(SMALL_JSON)],
    ["--lang", "cs", "--namespace", "A", "--namespace", "B", IN(SMALL_JSON)],
    ["--lang", "cs", "--virtual", "--no-virtual", IN(SMALL_JSON)],
    // bad renderer option values
    ["--lang", "cs", "--framework", "foo", IN(SMALL_JSON)],
    ["--lang", "cs", "--array-type", "toString", IN(SMALL_JSON)],
    ["--lang", "cjson", "--integer-size", "int128_t", IN(SMALL_JSON)],
    ["--lang", "rust", "--density", "", IN(SMALL_JSON)],
    // inputs
    ["--lang", "typescript", "nonexistent.json"],
    ["--lang", "typescript", "--src-lang", "schema", "nonexistent.schema"],
    ["--lang", "typescript", IN(SMALL_JSON), "nonexistent.json"],
    ["--lang", "typescript", IN(GQL_QUERY)],
    ["--lang", "typescript", "--src-lang", "schema", IN(GQL_QUERY)],
    ["--lang", "typescript", "--src-lang", "schema", IN("json/misc/00c36.json")],
    ["--lang", "typescript", "--http-header", "X-Foo: bar", IN(SMALL_JSON)],
    ["--lang", "typescript", "--quiet", "nonexistent.json"],
    ["--lang", "typescript", "--"],
    ["--debug", "bad", IN(SMALL_JSON)],
    ["--debug", "provenance,bad", IN(SMALL_JSON)],
    ["--out", "foo", IN(SMALL_JSON)],
    // telemetry
    ["--telemetry", "bad"],
    ["--telemetry", "bad", IN(SMALL_JSON)],
    ["--telemetry", "enable"],
    ["--telemetry", "disable"],
    ["--telemetry", "enable", "--lang", "typescript", IN(SMALL_JSON)],
    ["--telemetry", "disable", IN(SMALL_JSON)],
    ["--telemetry=bad"],
];
for (const args of errorCases) add("cli-errors", "_", [args]);
add("cli-errors", "_", [["--telemetry", "bad"]], { FORCE_COLOR: "1" });

// ---------------------------------------------------------------------------
// Recording

const scrubbed = new Set(["FORCE_COLOR", "NO_COLOR", "NODE_OPTIONS"]);
const baseEnv = Object.fromEntries(Object.entries(process.env).filter(([k]) => !scrubbed.has(k)));
baseEnv.TZ = "UTC";
baseEnv.NODE_NO_WARNINGS = "1";

function filesBelow(root, rel = "", acc = new Map()) {
    for (const e of fs.readdirSync(path.join(root, rel), { withFileTypes: true })) {
        const r = rel ? path.join(rel, e.name) : e.name;
        if (e.isDirectory()) filesBelow(root, r, acc);
        else if (e.isFile()) acc.set(r, fs.readFileSync(path.join(root, r)));
    }
    return acc;
}

function replaceAll(buf, from, to) {
    return from === "" ? buf : Buffer.from(buf.toString("latin1").split(from).join(to), "latin1");
}

/** Replaces absolute paths with placeholders, longest first (works on raw bytes). */
function normalize(buf, pairs) {
    let out = buf;
    for (const [from, to] of [...pairs].sort((a, b) => b[0].length - a[0].length)) {
        out = replaceAll(out, Buffer.from(from).toString("latin1"), to);
    }
    return out;
}

function pathForms(dir, placeholder) {
    const forms = new Set([dir, fs.realpathSync(dir)]);
    return [...forms].map((f) => [f, placeholder]);
}

function runStep(argv, cwd, env, stdinPath) {
    return new Promise((resolve, reject) => {
        const stdin = stdinPath === undefined ? "ignore" : fs.openSync(stdinPath, "r");
        const child = spawn(process.execPath, [cliPath, ...argv], {
            cwd,
            env,
            stdio: [stdin, "pipe", "pipe"],
        });
        if (typeof stdin === "number") fs.closeSync(stdin);
        const stdout = [];
        const stderr = [];
        child.stdout.on("data", (d) => stdout.push(d));
        child.stderr.on("data", (d) => stderr.push(d));
        child.on("error", reject);
        child.on("close", (code, signal) => {
            if (code === null) reject(new Error(`killed by ${signal}: ${argv.join(" ")}`));
            else resolve({ code, stdout: Buffer.concat(stdout), stderr: Buffer.concat(stderr) });
        });
    });
}

function caseKey(c) {
    const steps = c.steps.map((s) => (s.stdin === undefined ? s.args : { args: s.args, stdin: s.stdin }));
    return JSON.stringify(c.env === undefined ? steps : { env: c.env, steps });
}

const tmpRoot = fs.realpathSync(fs.mkdtempSync(path.join(os.tmpdir(), "quicktype-record-cli-")));
const inputPairs = pathForms(inputsDir, "{INPUTS}");
const expand = (s) => s.split("{INPUTS}").join(inputsDir);

async function record(c, index) {
    const work = path.join(tmpRoot, `w${index}`);
    fs.mkdirSync(work);
    const pairs = [...inputPairs, ...pathForms(work, "{CWD}")];
    const env = { ...baseEnv, ...(c.env ?? {}) };
    const steps = [];
    const contents = new Map();
    for (const [i, step] of c.steps.entries()) {
        const before = filesBelow(work);
        const result = await runStep(
            step.args.map(expand),
            work,
            env,
            step.stdin === undefined ? undefined : expand(step.stdin),
        );
        const after = filesBelow(work);
        const files = [...after]
            .filter(([p, buf]) => !before.get(p)?.equals(buf))
            .map(([p]) => p)
            .sort();
        for (const f of files) contents.set(path.join(`step${i}`, f), after.get(f));
        const stdout = normalize(result.stdout, pairs);
        const stderr = normalize(result.stderr, pairs);
        if (stdout.length > 0) contents.set(`step${i}.stdout`, stdout);
        if (stderr.length > 0) contents.set(`step${i}.stderr`, stderr);
        steps.push({
            args: step.args,
            ...(step.stdin === undefined ? {} : { stdin: step.stdin }),
            files,
            exit: result.code,
        });
    }
    fs.rmSync(work, { recursive: true, force: true });
    return {
        caseJson: {
            fixture: c.fixture,
            input: c.input,
            ...(c.env === undefined ? {} : { env: c.env }),
            steps,
        },
        contents,
    };
}

// Drop duplicate definitions (same argv, stdin and env) before running.
const unique = new Map();
for (const c of cases) {
    const id = sha(caseKey(c)).slice(0, 10);
    const dir = path.join(c.fixture, c.input, id);
    if (unique.has(dir)) {
        if (caseKey(unique.get(dir)) !== caseKey(c)) throw new Error(`hash collision at ${dir}`);
        continue;
    }
    unique.set(dir, c);
}

for (const e of fs.readdirSync(goldenDir, { withFileTypes: true })) {
    if (e.isDirectory() && e.name.startsWith("cli-")) {
        fs.rmSync(path.join(goldenDir, e.name), { recursive: true, force: true });
    }
}

const work = [...unique.entries()];
const counts = new Map();
let next = 0;
let done = 0;
async function worker() {
    while (next < work.length) {
        const index = next++;
        const [dir, c] = work[index];
        const { caseJson, contents } = await record(c, index);
        const caseDir = path.join(goldenDir, dir);
        fs.mkdirSync(caseDir, { recursive: true });
        fs.writeFileSync(path.join(caseDir, "case.json"), `${JSON.stringify(caseJson, null, 2)}\n`);
        for (const [p, buf] of contents) {
            fs.mkdirSync(path.dirname(path.join(caseDir, p)), { recursive: true });
            fs.writeFileSync(path.join(caseDir, p), buf);
        }
        counts.set(c.fixture, (counts.get(c.fixture) ?? 0) + 1);
        if (++done % 200 === 0) console.log(`  ${done}/${work.length} ...`);
    }
}

const jobs = Math.max(1, os.availableParallelism?.() ?? os.cpus().length);
await Promise.all(Array.from({ length: jobs }, worker));
fs.rmSync(tmpRoot, { recursive: true, force: true });

for (const [fixture, n] of [...counts].sort()) console.log(`  ${fixture.padEnd(20)} ${n}`);
console.log(`cli cases: ${done}`);
