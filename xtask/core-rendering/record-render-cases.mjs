// Records render cases for the differential renderer tests
// (crates/quicktype-core/tests/render_cases.rs).
//
// For every golden case that renders with one of the languages given on the
// command line (default: rust), this runs the reference CLI in-process with
// the case's arguments and intercepts two calls:
//
//   - gatherNames(graph, destructive): the type graph *before* name
//     gathering is dumped, with the `destructive` flag and the number of
//     random names drawn so far in the run (TooManyTypeNames consume
//     quicktype's seeded name generator);
//   - TargetLanguage.renderGraphAndSerialize(...): its arguments and result.
//
// The Rust test rebuilds the same graph (same type indexes and attributes),
// runs its gather_names and render_graph_and_serialize, and compares the
// output and the annotations. The rendered text is checked here against the
// golden file (or stdout) before anything is written, so a fixture always
// describes the golden output.
//
// A few cases come from quicktype's own unit tests (API calls, no golden
// recording); their expected output is stored inline.
//
// Usage: node xtask/core-rendering/record-render-cases.mjs ../quicktype [lang...]
import { mkdirSync, mkdtempSync, readFileSync, readdirSync, rmSync, writeFileSync, existsSync } from "node:fs";
import { createRequire } from "node:module";
import { tmpdir } from "node:os";
import { dirname, join, posix, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const quicktype = resolve(process.argv[2] ?? "../quicktype");
const languages = process.argv.length > 3 ? process.argv.slice(3) : ["rust"];
const require = createRequire(join(quicktype, "package.json"));
const dist = join(quicktype, "packages/quicktype-core/dist");
const load = (p) => require(join(dist, p));

const here = dirname(fileURLToPath(import.meta.url));
const root = resolve(here, "../..");
const goldenDir = join(root, "tests/golden");
const inputsDir = join(root, "tests/inputs");
const outDir = join(root, "crates/quicktype-core/tests/fixtures/core-rendering/cases");

const { TargetLanguage } = load("TargetLanguage.js");
const GatherNames = load("GatherNames.js");
const { Chance } = load("support/Chance.js");
const { RegularTypeNames, TooManyTypeNames } = load("attributes/TypeNames.js");
const { IssueAnnotationData } = load("Annotation.js");
const core = load("index.js");
const cli = require(join(quicktype, "dist/index.js"));

// ---- Random name draws ------------------------------------------------------

// Every makeRandomName() call draws city+animal until the name is unused;
// the number of distinct names drawn is the number of successful calls.
let drawnNames = new Set();
let lastCity;
const originalCity = Chance.prototype.city;
const originalAnimal = Chance.prototype.animal;
Chance.prototype.city = function (...args) {
    lastCity = originalCity.apply(this, args);
    return lastCity;
};
Chance.prototype.animal = function (...args) {
    const animal = originalAnimal.apply(this, args);
    drawnNames.add(`${lastCity} ${animal}`);
    return animal;
};

// ---- Graph dump -------------------------------------------------------------

function accessorEntry(entry) {
    if (typeof entry === "string") return entry;
    return Array.from(entry);
}

function dumpAttributes(attributes) {
    const result = {};
    for (const [kind, value] of attributes) {
        switch (kind.name) {
            case "provenance":
                break;
            case "names":
                if (value instanceof RegularTypeNames) {
                    result.names = {
                        t: "regular",
                        names: Array.from(value.names),
                        alts: value._alternativeNames === undefined ? null : Array.from(value._alternativeNames),
                        d: value.distance,
                    };
                } else if (value instanceof TooManyTypeNames) {
                    result.names = { t: "toomany", name: Array.from(value.names)[0], d: value.distance };
                } else {
                    throw new Error("unknown TypeNames");
                }
                break;
            case "description":
                result.description = Array.from(value);
                break;
            case "propertyDescriptions":
                result.propertyDescriptions = Array.from(value).map(([k, v]) => [k, Array.from(v)]);
                break;
            case "accessorNames":
            case "enumValues":
                result[kind.name] = Array.from(value).map(([k, v]) => [k, accessorEntry(v)]);
                break;
            case "unionIdentifier":
                result.unionIdentifier = Array.from(value);
                break;
            case "unionMemberNames":
                result.unionMemberNames = Array.from(value).map(([k, v]) => [k, accessorEntry(v)]);
                break;
            case "minMax":
            case "minMaxLength":
            case "minMaxItems":
                result[kind.name] = [value[0] ?? null, value[1] ?? null];
                break;
            case "pattern":
                result.pattern = value;
                break;
            case "defaultValue":
                if (value !== null && typeof value === "object") throw new Error("unsupported default value");
                result.defaultValue = value;
                break;
            case "stringTypes":
                result.stringTypes = {
                    cases: value.cases === undefined ? null : Array.from(value.cases),
                    tx: Array.from(value.transformations),
                };
                break;
            case "uriAttributes":
                result.uriAttributes = [Array.from(value[0]), Array.from(value[1])];
                break;
            default:
                throw new Error(`cannot dump attribute ${kind.name}`);
        }
    }
    return result;
}

function dumpGraph(graph) {
    const types = [];
    for (const t of graph.allTypesUnordered()) {
        const entry = { k: t.kind, a: dumpAttributes(graph.attributeStore.attributesForType(t)) };
        switch (t.kind) {
            case "array":
                entry.items = t.items.index;
                break;
            case "class":
            case "object":
            case "map":
                entry.fixed = t.isFixed;
                entry.props = Array.from(t.getProperties()).map(([n, p]) => [n, p.type.index, p.isOptional]);
                entry.add = t.getAdditionalProperties()?.index ?? null;
                break;
            case "enum":
                entry.cases = Array.from(t.cases);
                break;
            case "union":
            case "intersection":
                entry.members = Array.from(t.members).map((m) => m.index);
                break;
            default:
                break;
        }
        types.push(entry);
    }
    const topLevels = Array.from(graph.topLevels).map(([name, t]) => [name, t.index]);
    return { types, topLevels };
}

// ---- Interception -----------------------------------------------------------

let captured;
const originalGatherNames = GatherNames.gatherNames;
GatherNames.gatherNames = function (graph, destructive, debugPrint) {
    if (captured !== undefined) {
        captured.graph = dumpGraph(graph);
        captured.gather = { destructive, randomNames: drawnNames.size };
    }
    return originalGatherNames(graph, destructive, debugPrint);
};

const originalRender = TargetLanguage.prototype.renderGraphAndSerialize;
TargetLanguage.prototype.renderGraphAndSerialize = function (
    typeGraph,
    givenOutputFilename,
    alphabetizeProperties,
    leadingComments,
    rendererOptions,
    indentation,
) {
    const result = originalRender.call(
        this,
        typeGraph,
        givenOutputFilename,
        alphabetizeProperties,
        leadingComments,
        rendererOptions,
        indentation,
    );
    if (captured !== undefined) {
        if (leadingComments !== undefined) throw new Error("leading comments are not recorded");
        captured.render = {
            lang: this.name,
            filename: givenOutputFilename,
            alphabetize: alphabetizeProperties,
            rendererOptions: Object.fromEntries(Object.entries(rendererOptions)),
            indentation: indentation ?? null,
        };
        captured.files = Array.from(result).map(([name, srr]) => ({
            name,
            text: srr.lines.join("\n"),
            annotations: srr.annotations
                .filter((a) => a.annotation instanceof IssueAnnotationData)
                .map((a) => [a.annotation.message, a.span.start.line, a.span.start.column, a.span.end.line, a.span.end.column]),
        }));
    }
    return result;
};

// ---- Cases ------------------------------------------------------------------

function* goldenCases(dir, rel = "") {
    for (const e of readdirSync(join(dir, rel), { withFileTypes: true })) {
        if (!e.isDirectory()) continue;
        const r = rel ? join(rel, e.name) : e.name;
        if (existsSync(join(dir, r, "case.json"))) yield r;
        else yield* goldenCases(dir, r);
    }
}

function langOf(args) {
    const i = args.indexOf("--lang");
    return i < 0 ? undefined : args[i + 1];
}

async function runCli(args, cwd) {
    const originalStdout = process.stdout.write;
    const originalStderr = process.stderr.write;
    const originalCwd = process.cwd();
    let stdout = "";
    process.stdout.write = (chunk) => {
        stdout += chunk;
        return true;
    };
    process.stderr.write = () => true;
    try {
        process.chdir(cwd);
        await cli.main(args);
    } finally {
        process.chdir(originalCwd);
        process.stdout.write = originalStdout;
        process.stderr.write = originalStderr;
    }
    return stdout;
}

function caseFileName(id) {
    return `${id.replace(/[/\\]/g, "__")}.json`;
}

// What the CLI's writeOutput prints for a render without --out: the files
// separated by a blank line, each under a `// <name>` header when there are
// several (multi-file languages such as Java).
function joinStdout(files) {
    return files
        .map((f) => (files.length > 1 ? `// ${f.name}\n\n${f.text}` : f.text))
        .join("\n");
}

async function recordGolden(id) {
    const c = JSON.parse(readFileSync(join(goldenDir, id, "case.json"), "utf8"));
    if (c.steps.length !== 1) return "skip: several steps";
    const step = c.steps[0];
    if ((step.exit ?? 0) !== 0) return "skip: error case";
    if (step.stdin !== undefined || c.env !== undefined) return "skip: stdin/env";
    const lang = langOf(step.args);
    if (!languages.includes(lang)) return undefined;
    const args = step.args.map((a) => a.replaceAll("{INPUTS}", inputsDir));
    const work = mkdtempSync(join(tmpdir(), "qt-render-"));
    // Directories the case expects to exist (Java writes into src/main/java/...).
    for (const d of c.dirs ?? []) mkdirSync(join(work, d), { recursive: true });
    captured = {};
    drawnNames = new Set();
    let stdout;
    try {
        stdout = await runCli(args, work);
    } finally {
        rmSync(work, { recursive: true, force: true });
    }
    const rec = captured;
    captured = undefined;
    if (rec.graph === undefined || rec.render === undefined) return "skip: did not render";
    // The CLI writes every file next to --out (Java: src/main/java/io/quicktype/).
    const outIndex = step.args.indexOf("--out");
    const outDirRel = outIndex < 0 ? "." : posix.dirname(step.args[outIndex + 1]);
    const goldenFile = (f) => posix.join(outDirRel, f.name);
    // Check the intercepted render against the golden recording.
    if (step.files.length > 0) {
        for (const f of rec.files) {
            const golden = readFileSync(join(goldenDir, id, "step0", goldenFile(f)), "utf8");
            if (golden !== f.text) throw new Error(`${id}: ${f.name} differs from golden`);
        }
        if (step.files.length !== rec.files.length) throw new Error(`${id}: file count differs`);
    } else {
        const golden = readFileSync(join(goldenDir, id, "step0.stdout"), "utf8");
        if (rec.files.length === 0 || golden !== stdout || stdout !== joinStdout(rec.files)) {
            throw new Error(`${id}: stdout differs from golden`);
        }
    }
    const quiet = step.args.includes("--quiet");
    // Several files printed to stdout: the fixture names the stdout golden
    // once (`stdout`) and the test joins the rendered files like the CLI.
    const multiFileStdout = step.files.length === 0 && rec.files.length > 1;
    const fixture = {
        id,
        graph: rec.graph,
        gather: rec.gather,
        render: rec.render,
        stdout: multiFileStdout ? `${id}/step0.stdout` : undefined,
        files: rec.files.map((f) => ({
            name: f.name,
            golden: multiFileStdout
                ? undefined
                : step.files.length > 0
                  ? `${id}/step0/${goldenFile(f)}`
                  : `${id}/step0.stdout`,
            annotations: quiet ? undefined : f.annotations,
        })),
    };
    writeFileSync(join(outDir, caseFileName(id)), `${JSON.stringify(fixture)}\n`);
    return "recorded";
}

// quicktype's own unit tests that are testable at the render level
// (test/unit/rust-cycle-breaker-boxing.test.ts, rust-empty-top-levels.test.ts).
const apiCases = [
    {
        id: "unit/rust-cycle-breaker-boxing/nullable-union",
        schema: { name: "Node", next: { anyOf: [{ $ref: "#" }, { type: "string" }, { type: "null" }] }, required: ["value"] },
    },
    {
        id: "unit/rust-cycle-breaker-boxing/non-nullable-union",
        schema: { name: "Node", next: { anyOf: [{ $ref: "#" }, { type: "string" }] }, required: ["value", "next"] },
    },
    { id: "unit/rust-empty-top-levels/no-definitions", definitions: {} },
    {
        id: "unit/rust-empty-top-levels/person",
        definitions: {
            Person: { type: "object", properties: { age: { type: "integer" } }, required: ["age"] },
        },
    },
];

async function recordApi(spec) {
    const schemaInput = new core.JSONSchemaInput(undefined);
    if (spec.schema !== undefined) {
        await schemaInput.addSource({
            name: spec.schema.name,
            schema: JSON.stringify({
                $schema: "http://json-schema.org/draft-07/schema#",
                title: spec.schema.name,
                type: "object",
                properties: { value: { type: "string" }, next: spec.schema.next },
                required: spec.schema.required,
            }),
        });
    } else {
        await schemaInput.addSource({
            name: "",
            schema: JSON.stringify({ definitions: spec.definitions }),
            uris: ["#/definitions/"],
            isConverted: true,
        });
    }
    const inputData = new core.InputData();
    inputData.addInput(schemaInput);
    captured = {};
    drawnNames = new Set();
    await core.quicktypeMultiFile({ inputData, lang: "rust" });
    const rec = captured;
    captured = undefined;
    const fixture = {
        id: spec.id,
        graph: rec.graph,
        gather: rec.gather,
        render: rec.render,
        files: rec.files.map((f) => ({ name: f.name, text: f.text, annotations: f.annotations })),
    };
    writeFileSync(join(outDir, caseFileName(spec.id)), `${JSON.stringify(fixture)}\n`);
}

mkdirSync(outDir, { recursive: true });
const counts = {};
for (const id of goldenCases(goldenDir)) {
    if (id.startsWith("cli-") && !id.startsWith("cli-options/") && !id.startsWith("cli-stdout/")) continue;
    const outcome = await recordGolden(id);
    if (outcome === undefined) continue;
    counts[outcome] = (counts[outcome] ?? 0) + 1;
    if (outcome !== "recorded") console.log(`${id}: ${outcome}`);
}
if (languages.includes("rust")) {
    for (const spec of apiCases) {
        await recordApi(spec);
        counts["recorded (api)"] = (counts["recorded (api)"] ?? 0) + 1;
    }
}
console.log(counts);
