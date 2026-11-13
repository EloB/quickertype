// The fixtures' later quicktype steps, which the golden corpus does not
// record, as a generation-only differential: the TypeScript CLI and ours run
// each step on the same input and every written file must be identical. It
// needs no language toolchains, so it also covers the languages whose
// fixtures cannot run here.
//
// The steps are upstream's, taken from the copy's test/fixtures.ts: every
// JSONFixture in `allFixtures`, each sample of its `getSamples([])` that its
// `shouldSkipTest` keeps, and
//   - for a language's JSONFixture (JSONFixture.test): if the language has a
//     runCommand, and diffViaSchema (the sample not in skipDiffViaSchema) or
//     roundtripViaSchema, JSON -> JSON Schema, then the schema -> the
//     language;
//   - for a JSON -> X -> Y fixture (JSONToXToYFixture.test: schema-json-csharp,
//     json-ts-csharp): JSON -> X and X -> Y, and for schema-json-csharp
//     (JSONSchemaJSONFixture.test) the schema -> schema. Ours needs the
//     TypeScript 7.0.2 compiler (`QUICKTYPE_TSC`) to read the TypeScript.
// A step's input is the TypeScript CLI's output of the step before it, so a
// difference shows up in the step that makes it.
//
// Run with the copy's tsx, from roundtrip.sh:
//   tsx later-steps.mts <quicktype copy> <ours command> <work dir> <jobs>
import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

const [copy, oursCommand, work, jobsArg] = process.argv.slice(2);
if (work === undefined || !/^[1-9][0-9]*$/.test(jobsArg ?? "")) {
    console.error("usage: later-steps.mts <quicktype copy> <ours command> <work dir> <jobs, at least 1>");
    process.exit(2);
}
const jobs = Number(jobsArg);
const ts = ["node", path.join(copy, "dist/index.js")];
const ours = oursCommand.trim().split(/\s+/);
// The fixtures find their samples relative to the checkout.
process.chdir(copy);
const { allFixtures, JSONFixture, JSONToXToYFixture, JSONSchemaJSONFixture } = await import(
    path.join(copy, "test/fixtures.ts")
);
const { cliArgumentsFromOptions } = await import(path.join(copy, "test/utils.ts"));

type Options = Record<string, unknown>;
type Language = {
    name: string;
    output: string;
    topLevel: string;
    rendererOptions: Options;
    runCommand?: unknown;
    diffViaSchema: boolean;
    roundtripViaSchema?: boolean;
    skipDiffViaSchema: string[];
};
type Sample = { path: string; additionalRendererOptions: Options };

// A quicktype run, and the earlier step whose output file is its input.
type Step = {
    id: number;
    label: string;
    opts: Options;
    input?: { step: Step; file: string };
    level: number;
    dir?: string;
};

// The options quicktypeForLanguage (test/utils.ts) passes.
function forLanguage(
    language: Language,
    src: string,
    srcLang: string,
    alphabetizeProperties: boolean,
    ro: Options,
): Options {
    return {
        srcLang,
        lang: language.name,
        src: [src],
        out: language.output,
        topLevel: language.topLevel,
        alphabetizeProperties,
        rendererOptions: { ...language.rendererOptions, ...ro },
        quiet: true,
        telemetry: "disable",
        debug: "provenance",
    };
}

// Steps with the same options and input run once.
const steps = new Map<string, Step>();
function step(label: string, opts: Options, input?: { step: Step; file: string }): Step {
    const key = JSON.stringify([opts, input === undefined ? null : [input.step.id, input.file]]);
    let s = steps.get(key);
    if (s === undefined) {
        s = { id: steps.size, label, opts, input, level: input === undefined ? 0 : input.step.level + 1 };
        steps.set(key, s);
    }
    return s;
}

let fixtureCount = 0;
let sampleCount = 0;
for (const fixture of allFixtures) {
    if (!(fixture instanceof JSONFixture)) continue;
    fixtureCount++;
    const language: Language = fixture.language;
    const { priority, others } = fixture.getSamples([]);
    for (const sample of [...priority, ...others] as Sample[]) {
        if (fixture.shouldSkipTest(sample)) continue;
        sampleCount++;
        const file = path.resolve(sample.path);
        const ro = sample.additionalRendererOptions;
        const label = `${fixture.name} ${sample.path}${Object.keys(ro).length === 0 ? "" : ` ${JSON.stringify(ro)}`}`;
        if (fixture instanceof JSONToXToYFixture) {
            const y: Language = (fixture as { runLanguage: Language }).runLanguage;
            const x = step(`${label}: json -> ${language.name}`, forLanguage(language, file, "json", true, ro));
            const xOutput = { step: x, file: language.output };
            step(
                `${label}: ${language.name} -> ${y.name}`,
                forLanguage(y, language.output, language.name, false, ro),
                xOutput,
            );
            if (fixture instanceof JSONSchemaJSONFixture) {
                step(
                    `${label}: schema -> schema`,
                    {
                        src: [language.output],
                        srcLang: language.name,
                        lang: language.name,
                        topLevel: language.topLevel,
                        out: "schema-from-schema.json",
                        rendererOptions: {},
                    },
                    xOutput,
                );
            }
        } else {
            const diffViaSchema =
                language.diffViaSchema && !language.skipDiffViaSchema.includes(path.basename(file));
            if (language.runCommand === undefined || !(diffViaSchema || language.roundtripViaSchema)) {
                continue;
            }
            const schema = step(`${sample.path} (top level ${language.topLevel}): json -> schema`, {
                src: [file],
                lang: "schema",
                out: "schema.json",
                topLevel: language.topLevel,
                rendererOptions: {},
            });
            step(
                `${label}: schema -> ${language.name}`,
                forLanguage(language, "schema.json", "schema", true, ro),
                { step: schema, file: "schema.json" },
            );
        }
    }
}

console.error(`* ${fixtureCount} JSON fixtures, ${sampleCount} samples they test: ${steps.size} steps`);
if (steps.size === 0) {
    console.error("later-steps: no steps; nothing would be tested");
    process.exit(1);
}

function run(cmd: string[], args: string[], cwd: string): Promise<{ code: number; stderr: string }> {
    return new Promise((resolve) => {
        const p = spawn(cmd[0], [...cmd.slice(1), ...args], { cwd });
        let stderr = "";
        p.stderr.on("data", (d) => {
            stderr += d;
        });
        p.on("error", (e) => resolve({ code: -1, stderr: String(e) }));
        p.on("close", (code) => resolve({ code: code ?? -1, stderr }));
    });
}

function files(dir: string, rel = ""): Map<string, Buffer> {
    const m = new Map<string, Buffer>();
    for (const e of fs.readdirSync(path.join(dir, rel), { withFileTypes: true })) {
        const r = path.join(rel, e.name);
        if (e.isDirectory()) for (const [k, v] of files(dir, r)) m.set(k, v);
        else m.set(r, fs.readFileSync(path.join(dir, r)));
    }
    return m;
}

let ran = 0;
let bothFailed = 0;
const notRun: string[] = [];
const mismatches: string[] = [];
const keep = new Set<string>();

// Runs a step with both CLIs, each in a fresh directory with its input.
async function runStep(s: Step): Promise<void> {
    let seed: string | undefined;
    if (s.input !== undefined) {
        seed = path.join(s.input.step.dir ?? "", s.input.file);
        if (s.input.step.dir === undefined || !fs.existsSync(seed)) {
            // Both CLIs failed the step before alike.
            notRun.push(s.label);
            return;
        }
    }
    const dirs = ["ts", "ours"].map((w) => path.join(work, `${s.id}-${w}`));
    for (const d of dirs) {
        fs.mkdirSync(d, { recursive: true });
        if (s.input !== undefined && seed !== undefined) {
            const to = path.join(d, s.input.file);
            fs.mkdirSync(path.dirname(to), { recursive: true });
            fs.copyFileSync(seed, to);
        }
    }
    const args = cliArgumentsFromOptions(s.opts);
    const [a, b] = await Promise.all([run(ts, args, dirs[0]), run(ours, args, dirs[1])]);
    ran++;
    s.dir = dirs[0];
    if (a.code !== 0 && b.code !== 0) bothFailed++;
    const fa = files(dirs[0]);
    const fb = files(dirs[1]);
    const problems: string[] = [];
    if (a.code !== b.code) {
        problems.push(`exit ${a.code} vs ${b.code}: ${a.stderr.slice(0, 300)} | ${b.stderr.slice(0, 300)}`);
    }
    for (const k of new Set([...fa.keys(), ...fb.keys()])) {
        const x = fa.get(k);
        const y = fb.get(k);
        if (x === undefined || y === undefined) problems.push(`${k} only in ${x === undefined ? "ours" : "TS"}`);
        else if (!x.equals(y)) problems.push(`${k} differs`);
    }
    if (problems.length > 0) {
        mismatches.push(`${s.label} (${dirs[0]}): ${problems.join("; ")}\n    args: ${args.join(" ")}`);
        for (const d of dirs) keep.add(path.basename(d));
    } else {
        // The TypeScript CLI's output may be a later step's input.
        fs.rmSync(dirs[1], { recursive: true });
    }
}

async function pool<T>(items: T[], f: (t: T) => Promise<void>): Promise<void> {
    let i = 0;
    await Promise.all(
        Array.from({ length: Math.min(jobs, items.length) }, async () => {
            while (i < items.length) await f(items[i++]);
        }),
    );
}

const all = [...steps.values()];
const levels = Math.max(...all.map((s) => s.level)) + 1;
for (let level = 0; level < levels; level++) {
    const these = all.filter((s) => s.level === level);
    await pool(these, runStep);
    console.error(`* step ${level + 1}: ${these.length} steps, ${mismatches.length} mismatches in all`);
}

// Only the mismatching steps' outputs stay.
for (const entry of fs.readdirSync(work)) {
    if (!keep.has(entry)) fs.rmSync(path.join(work, entry), { recursive: true });
}

const report = [
    `${ran} steps, ${mismatches.length} mismatches`,
    `${bothFailed} steps failed with both CLIs alike`,
    `${notRun.length} steps not run: the step before failed with both CLIs alike`,
    ...notRun.sort().map((l) => `  ${l}`),
    ...mismatches.sort(),
].join("\n");
console.log(report);
if (mismatches.length > 0) fs.writeFileSync(path.join(work, "mismatches.txt"), `${report}\n`);
process.exit(mismatches.length > 0 ? 1 : 0);
