// The fixtures' later quicktype steps, which the golden corpus does not
// record, as a generation-only differential: the TypeScript CLI and ours run
// each step on the same input and every written file must be identical. It
// needs no language toolchains, so it also covers the languages whose
// fixtures cannot run here.
//
//   - JSONFixture with diffViaSchema/roundtripViaSchema: JSON -> JSON Schema
//     (`--lang schema`), then the schema -> the language, for every fixture
//     language, sample and quick-test renderer option set that does it;
//   - schema-json-csharp: JSON -> schema -> C#, and schema -> schema;
//   - json-ts-csharp: JSON -> TypeScript (just types) -> C#. Ours needs the
//     TypeScript 7.0.2 compiler for this (`QUICKTYPE_TSC`).
//
// Run with the copy's tsx, from roundtrip.sh:
//   tsx later-steps.mts <quicktype copy> <ours command> <work dir> <jobs>
import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

const [copy, oursCommand, work, jobsArg] = process.argv.slice(2);
const jobs = Number(jobsArg);
const ts = ["node", path.join(copy, "dist/index.js")];
const ours = oursCommand.trim().split(/\s+/);
process.chdir(copy);
const languages = await import(path.join(copy, "test/languages.ts"));
const { cliArgumentsFromOptions } = await import(path.join(copy, "test/utils.ts"));

type Input = { dir: string; path: string; base: string };
const inputs: Input[] = ["priority", "samples", "misc"].flatMap((dir) =>
    fs
        .readdirSync(path.join(copy, "test/inputs/json", dir))
        .filter((f) => f.endsWith(".json") && !/\.out\.[^.]+\.json$/.test(f))
        .sort()
        .map((base) => ({ dir, path: path.join(copy, "test/inputs/json", dir, base), base })),
);

function run(cmd: string[], args: string[], cwd: string): Promise<{ code: number; stderr: string }> {
    return new Promise((resolve) => {
        const p = spawn(cmd[0], [...cmd.slice(1), ...args], { cwd });
        let stderr = "";
        p.stderr.on("data", (d) => {
            stderr += d;
        });
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

let counter = 0;
let total = 0;
const mismatches: string[] = [];

// Runs one step with both CLIs, each in a fresh directory seeded with
// `seed` (name -> source file). Returns the TypeScript CLI's directory, whose
// output feeds the next step; ours is deleted unless it differs.
async function step(label: string, opts: object, seed: Record<string, string>): Promise<string> {
    const id = counter++;
    const args = cliArgumentsFromOptions(opts);
    const dirs = ["ts", "ours"].map((w) => path.join(work, `${id}-${w}`));
    for (const d of dirs) {
        fs.mkdirSync(d, { recursive: true });
        for (const [name, src] of Object.entries(seed)) fs.copyFileSync(src, path.join(d, name));
    }
    const [a, b] = await Promise.all([run(ts, args, dirs[0]), run(ours, args, dirs[1])]);
    total++;
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
        mismatches.push(`${label} (${dirs[0]}): ${problems.join("; ")}\n    args: ${args.join(" ")}`);
    } else {
        fs.rmSync(dirs[1], { recursive: true });
    }
    return dirs[0];
}

async function pool<T>(items: T[], f: (t: T) => Promise<void>): Promise<void> {
    let i = 0;
    await Promise.all(
        Array.from({ length: jobs }, async () => {
            while (i < items.length) await f(items[i++]);
        }),
    );
}

const cliDefaults = { quiet: true, telemetry: "disable", debug: "provenance" };

// The JSON fixtures that run JSON -> schema -> language (test/fixtures.ts).
const viaSchemaLanguages = [
    "CSharpLanguage", "CSharpLanguageRecords", "CSharpLanguageSystemTextJson", "GoLanguage",
    "CJSONLanguage", "CPlusPlusLanguage", "CPlusPlusMultiSourceLanguage", "RustLanguage",
    "RubyLanguage", "PythonLanguage", "ElmLanguage", "SwiftLanguage",
    "SwiftSendableObjectiveCSupportLanguage", "TypeScriptLanguage", "TypeScriptZodLanguage",
    "TypeScriptEffectSchemaLanguage", "JavaScriptLanguage", "KotlinLanguage", "Scala3Language",
    "Scala3UpickleLanguage", "KotlinJacksonLanguage", "KotlinXLanguage", "DartLanguage",
    "PikeLanguage", "HaskellLanguage", "ElixirLanguage", "CrystalLanguage",
].map((k) => languages[k]);

function runsViaSchema(lang: any, s: Input): boolean {
    const skipped =
        lang.includeJSON !== undefined
            ? !lang.includeJSON.includes(s.base)
            : (lang.skipJSON ?? []).includes(s.base);
    const diff = lang.diffViaSchema && !lang.skipDiffViaSchema.includes(s.base);
    return !skipped && (diff || lang.roundtripViaSchema === true);
}

const viaSchema: { lang: any; s: Input; ro: Record<string, string> }[] = [];
for (const lang of viaSchemaLanguages) {
    for (const s of inputs) {
        if (s.dir === "misc" && lang.skipMiscJSON) continue;
        if (runsViaSchema(lang, s)) viaSchema.push({ lang, s, ro: {} });
    }
    for (const qt of lang.quickTestRendererOptions) {
        const [file, ro] = Array.isArray(qt) ? qt : [undefined, qt];
        if (file?.endsWith(".schema")) continue;
        const targets = file !== undefined ? [file] : [1, 2, 3, 4].map((n) => `combinations${n}.json`);
        for (const s of inputs.filter((i) => targets.includes(i.base))) {
            if (runsViaSchema(lang, s)) viaSchema.push({ lang, s, ro });
        }
    }
}

// JSON -> schema, once per sample and top-level name.
const schemas = new Map<string, string>();
const pairs = [...new Set(viaSchema.map(({ lang, s }) => `${lang.topLevel}\t${s.path}`))];
await pool(pairs, async (pair) => {
    const [topLevel, src] = pair.split("\t");
    const dir = await step(`schema ${topLevel} ${path.basename(src)}`, {
        src: [src], lang: "schema", out: "schema.json", topLevel, rendererOptions: {},
    }, {});
    const out = path.join(dir, "schema.json");
    if (fs.existsSync(out)) schemas.set(pair, out);
});
console.error(`* JSON -> schema: ${total} steps, ${mismatches.length} mismatches`);

let before = total;
await pool(viaSchema, async ({ lang, s, ro }) => {
    const schema = schemas.get(`${lang.topLevel}\t${s.path}`);
    if (schema === undefined) return;
    await step(`${lang.name} via schema ${s.dir}/${s.base} ${JSON.stringify(ro)}`, {
        srcLang: "schema", lang: lang.name, src: ["schema.json"], out: lang.output,
        topLevel: lang.topLevel, alphabetizeProperties: true,
        rendererOptions: { ...lang.rendererOptions, ...ro }, ...cliDefaults,
    }, { "schema.json": schema });
});
console.error(`* schema -> language: ${total - before} steps, ${mismatches.length} mismatches in all`);

// schema-json-csharp and json-ts-csharp.
const cs = languages.CSharpLanguage;
before = total;
await pool(inputs.filter((s) => !(cs.skipJSON ?? []).includes(s.base)), async (s) => {
    const name = `${s.dir}/${s.base}`;
    const schemaDir = await step(`schema-json-csharp schema ${name}`, {
        srcLang: "json", lang: "schema", src: [s.path], out: "schema.json", topLevel: "TopLevel",
        alphabetizeProperties: true, rendererOptions: {}, ...cliDefaults,
    }, {});
    const schema = path.join(schemaDir, "schema.json");
    if (fs.existsSync(schema)) {
        await step(`schema-json-csharp csharp ${name}`, {
            srcLang: "schema", lang: "csharp", src: ["schema.json"], out: cs.output, topLevel: "TopLevel",
            rendererOptions: cs.rendererOptions, ...cliDefaults,
        }, { "schema.json": schema });
        await step(`schema-json-csharp schema-from-schema ${name}`, {
            src: ["schema.json"], srcLang: "schema", lang: "schema", topLevel: "TopLevel",
            out: "schema-from-schema.json", rendererOptions: {},
        }, { "schema.json": schema });
    }
    const tsDir = await step(`json-ts-csharp ts ${name}`, {
        srcLang: "json", lang: "ts", src: [s.path], out: "typescript.ts", topLevel: "TopLevel",
        alphabetizeProperties: true, rendererOptions: { "just-types": "true" }, ...cliDefaults,
    }, {});
    const tsFile = path.join(tsDir, "typescript.ts");
    if (fs.existsSync(tsFile)) {
        await step(`json-ts-csharp csharp ${name}`, {
            srcLang: "ts", lang: "csharp", src: ["typescript.ts"], out: cs.output, topLevel: "TopLevel",
            rendererOptions: cs.rendererOptions, ...cliDefaults,
        }, { "typescript.ts": tsFile });
    }
});
console.error(`* C# fixtures: ${total - before} steps, ${mismatches.length} mismatches in all`);

console.log(`${total} steps, ${mismatches.length} mismatches`);
for (const m of mismatches) console.log(m);
process.exit(mismatches.length > 0 ? 1 : 0);
