#!/usr/bin/env node
// Runs the reference JSONSchemaInput on JSON Schema cases and records what
// it does, for crates/quicktype-core/tests/json_schema_input.rs to replay
// byte for byte without Node.
//
// usage: node xtask/core-json-schema-input/run-schema-inputs.mjs <path/to/quicktype>
//
// Run from anywhere; paths in cases are relative to the repository root and
// the script runs with that as its working directory (the Rust test does
// the same), so addresses in traces and messages match.
//
// Each case adds its sources to a JSONSchemaInput (with a
// FetchingJSONSchemaStore unless `store` is false, and the case's
// additional schema addresses), runs addTypes with
// `--debug print-schema-resolving` on and a TypeBuilder like Run's
// (provenance on, as the golden corpus records), finishes the graph and
// prints it. Everything console.log prints is the expected output; an
// exception ends it with `error: <message>`.
//
// Cases:
// - every tests/inputs/schema/*.schema the way the CLI adds it
//   ({name: "TopLevel", uris: [path]}), with the identity string type
//   mapping, and again with everything mapped to "string" when the schema
//   uses `format`;
// - the schema-input error cases of the CLI golden corpus;
// - the hand-written edge cases in
//   crates/quicktype-core/tests/fixtures/core-json-schema-input/schemas
//   ($ref and $id resolution, errors, keywords, YAML, fragments) and the
//   source configurations listed below (several sources, schema text,
//   additional schemas, Windows paths, malformed URIs).
//
// Output: crates/quicktype-core/tests/fixtures/core-json-schema-input/
// cases.json (the manifest) and expected/<id>.txt.

import { mkdirSync, readdirSync, readFileSync, rmSync, statSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { referenceCheckout } from "../reference.mjs";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktypeDir = referenceCheckout(process.argv[2]);
const dist = join(quicktypeDir, "packages/quicktype-core/dist");
const require = createRequire(join(dist, "index.js"));
const load = (p) => require(join(dist, p));

const { JSONSchemaInput } = load("input/JSONSchemaInput.js");
const { FetchingJSONSchemaStore } = load("input/FetchingJSONSchemaStore.js");
const { TypeBuilder } = load("Type/TypeBuilder.js");
const { TypeGraph } = load("Type/TypeGraph.js");
const { getNoStringTypeMapping } = load("Type/TypeBuilderUtils.js");
const { initTypeNames } = load("attributes/TypeNames.js");
const { accessorNamesTypeAttributeKind, unionMemberNamesTypeAttributeKind } = load("attributes/AccessorNames.js");
const { enumValuesTypeAttributeKind } = load("attributes/EnumValues.js");
const { uriTypeAttributeKind } = load("attributes/URIAttributes.js");
const { patternTypeAttributeKind } = load("attributes/Constraints.js");

// The attributes the graph printer does not show, as JSON: accessor names
// and enum values ([name, entry] pairs, an entry being a name or
// [language, name] pairs), union member names (the entries only: union
// identifiers are a global counter), URI attributes and patterns.
function attributeLines(graph) {
    const entry = (e) => (typeof e === "string" ? e : Array.from(e));
    const kinds = [
        ["accessorNames", accessorNamesTypeAttributeKind, (v) => Array.from(v, ([k, e]) => [k, entry(e)])],
        ["enumValues", enumValuesTypeAttributeKind, (v) => Array.from(v, ([k, e]) => [k, entry(e)])],
        ["unionMemberNames", unionMemberNamesTypeAttributeKind, (v) => Array.from(v.values(), entry)],
        ["uriAttributes", uriTypeAttributeKind, ([p, e]) => [Array.from(p), Array.from(e)]],
        ["pattern", patternTypeAttributeKind, (v) => v],
    ];
    const lines = [];
    for (let i = 0; i < graph._types.length; i++) {
        const attributes = graph.atIndex(i)[1];
        for (const [name, kind, toJSON] of kinds) {
            const v = kind.tryGetInAttributes(attributes);
            if (v !== undefined) lines.push(`${i} ${name} ${JSON.stringify(toJSON(v))}`);
        }
    }
    return lines;
}

process.chdir(repoRoot);
const fixtureDir = "crates/quicktype-core/tests/fixtures/core-json-schema-input";
const schemaDir = `${fixtureDir}/schemas`;

const cases = [];
const cli = (path) => [{ name: "TopLevel", uris: [path] }];

for (const name of readdirSync("tests/inputs/schema").sort()) {
    if (!name.endsWith(".schema")) continue;
    const path = `tests/inputs/schema/${name}`;
    const base = name.slice(0, -".schema".length);
    const network = name === "ref-remote.schema";
    cases.push({ id: `inputs/${base}`, sources: cli(path), network });
    if (readFileSync(path, "utf8").includes('"format"')) {
        cases.push({ id: `inputs-stm-string/${base}`, sources: cli(path), stm: "string", network });
    }
}
cases.push({ id: "inputs-alpha/accessors", sources: cli("tests/inputs/schema/accessors.schema"), alphabetize: true });
cases.push({ id: "inputs-alpha/property-sort", sources: cli(`${"crates/quicktype-core/tests/fixtures/core-json-schema-input/schemas"}/keywords/property-sort.schema`), alphabetize: true });

// The schema cases of tests/golden/cli-errors.
cases.push({ id: "cli/nonexistent", sources: cli("nonexistent.schema") });
cases.push({ id: "cli/graphql-file", sources: cli("tests/inputs/graphql/github1.graphql") });
cases.push({ id: "cli/json-array", sources: cli("tests/inputs/json/misc/00c36.json") });

function walk(dir) {
    const files = [];
    for (const name of readdirSync(dir).sort()) {
        const p = `${dir}/${name}`;
        if (statSync(p).isDirectory()) files.push(...walk(p));
        else files.push(p);
    }
    return files;
}
for (const path of walk(schemaDir)) {
    const id = relative(schemaDir, path).replace(/\.schema$/, "");
    if (id.startsWith("refs/sub/") || id === "refs/c" || id === "ids/other") continue;
    cases.push({ id: `fixtures/${id}`, sources: cli(path) });
}

const s = (p) => `${schemaDir}/${p}`;
const schemaText = (o) => JSON.stringify(o);
cases.push(
    // Several sources: names come from titles and file names.
    {
        id: "sources/several",
        sources: [
            { name: "First", uris: [s("keywords/names.schema")] },
            { name: "Second", uris: [s("yaml/person.schema")] },
            { name: "Third", uris: [s("refs/main.schema#/definitions/Local")] },
        ],
    },
    { id: "sources/two-uris", sources: [{ name: "Both", uris: [s("keywords/arrays.schema"), s("fragments/defs.schema#/definitions/Foo")] }] },
    { id: "sources/fragment-types", sources: [{ name: "Ignored", uris: [s("fragments/defs.schema#/definitions/")] }] },
    { id: "sources/fragment-root", sources: [{ name: "Root", uris: [s("fragments/defs.schema#/")] }] },
    { id: "sources/fragment-boolean", sources: [{ name: "X", uris: [s("errors/e34-cannot-get-types.schema#/definitions/")] }] },
    { id: "sources/fragment-name", sources: [{ name: "A", uris: [s("fragments/defs.schema#/definitions/Bar")] }, { name: "B", uris: [s("fragments/defs.schema#/definitions/Foo")] }] },
    { id: "sources/same-name-twice", sources: [{ name: "Same", uris: [s("keywords/arrays.schema")] }, { name: "Same", uris: [s("yaml/person.schema")] }] },
    { id: "sources/no-name-inferable", store: false, sources: [{ name: "X", uris: ["http://localhost/"], schema: schemaText({ type: "string" }) }] },
    // Schema text.
    { id: "text/plain", store: false, sources: [{ name: "Text", schema: schemaText({ type: "object", properties: { a: { type: "string" } } }) }] },
    { id: "text/space-in-name", store: false, sources: [{ name: "My Type", schema: schemaText({ type: "string" }) }, { name: "My Type", schema: schemaText({ type: "integer" }) }] },
    { id: "text/duplicate-names", store: false, sources: [{ name: "Dup", schema: schemaText({ type: "string" }) }, { name: "Dup", schema: schemaText({ type: "integer" }) }, { name: "Dup", schema: schemaText({ type: "boolean" }) }] },
    { id: "text/with-uris", store: false, sources: [{ name: "WithUri", uris: ["#/definitions/A"], schema: schemaText({ definitions: { A: { type: "number" } } }) }] },
    { id: "text/ref-to-file-with-store", sources: [{ name: "Text", schema: schemaText({ type: "object", properties: { b: { $ref: `${s("refs/sub/b.schema")}#/definitions/B` } } }) }] },
    { id: "text/ref-to-file-no-store", store: false, sources: [{ name: "Text", schema: schemaText({ type: "object", properties: { b: { $ref: `${s("refs/sub/b.schema")}#/definitions/B` } } }) }] },
    { id: "text/invalid", sources: [{ name: "Bad", schema: "{ not json: [" }] },
    { id: "text/yaml", store: false, sources: [{ name: "Yaml", schema: "type: object\nproperties:\n  x: {type: integer}\n" }] },
    { id: "text/array", store: false, sources: [{ name: "Arr", schema: "[1, 2]" }] },
    { id: "text/converted", store: false, sources: [{ name: "Conv", schema: schemaText({ type: "string" }), isConverted: true }] },
    // Additional schemas.
    { id: "additional/with-id", additional: [s("ids/additional.schema")], sources: cli(s("ids/uses-additional.schema")) },
    { id: "additional/without", sources: cli(s("ids/uses-additional.schema")) },
    { id: "additional/missing", additional: [s("ids/missing.schema")], sources: cli(s("ids/uses-additional.schema")) },
    // Addresses.
    { id: "addresses/windows-drive", sources: cli("C:\\Users\\quicktype\\top.schema.json") },
    { id: "addresses/windows-unc", sources: cli("\\\\server\\share\\top.schema.json") },
    { id: "addresses/malformed", sources: cli("100%.schema") },
    { id: "addresses/escaped", sources: cli("100%25.schema") },
    { id: "addresses/bad-port", sources: cli("http://h:99999/x.schema") },
    { id: "addresses/space", sources: cli("dir with space/x.schema") },
    { id: "addresses/dot-segments", sources: cli(`./${s("refs")}/../refs/sub/../main.schema`) },
    { id: "addresses/query", sources: cli(`${s("keywords/arrays.schema")}?b=2&a=1`) },
);

function stringTypeMapping(kind) {
    return kind === "string" ? new Map() : getNoStringTypeMapping();
}

async function runCase(c) {
    const out = [];
    const originalLog = console.log;
    console.log = (...args) => out.push(args.join(" "));
    try {
        initTypeNames();
        const store = c.store === false ? undefined : new FetchingJSONSchemaStore();
        const input = new JSONSchemaInput(store, [], c.additional ?? []);
        for (const source of c.sources) {
            await input.addSource(source);
        }
        const stm = stringTypeMapping(c.stm);
        const builder = new TypeBuilder(stm, c.alphabetize === true, false, true, false);
        builder.typeGraph = new TypeGraph(builder, 0, true);
        const ctx = {
            debugPrintReconstitution: false,
            debugPrintSchemaResolving: true,
            debugPrintTransformations: false,
            stringTypeMapping: stm,
            time: (_name, f) => f(),
            timeSync: async (_name, f) => await f(),
        };
        await input.addTypes(ctx, builder);
        out.push(`# needIR ${input.needIR}; single string source ${JSON.stringify(input.singleStringSchemaSource() ?? null)}`);
        out.push("# graph");
        const graph = builder.finish();
        graph.printGraph();
        out.push("# attributes");
        out.push(...attributeLines(graph));
    } catch (e) {
        out.push(`error: ${e instanceof Error ? e.message : String(e)}`);
    } finally {
        console.log = originalLog;
    }
    return `${out.join("\n")}\n`;
}

const expectedDir = `${fixtureDir}/expected`;
rmSync(expectedDir, { recursive: true, force: true });
let lines = 0;
let errors = 0;
for (const c of cases) {
    const text = await runCase(c);
    const file = `${expectedDir}/${c.id}.txt`;
    mkdirSync(dirname(file), { recursive: true });
    writeFileSync(file, text);
    lines += text.split("\n").length - 1;
    if (/^error: /m.test(text)) errors++;
}
writeFileSync(`${fixtureDir}/cases.json`, `${JSON.stringify(cases, null, 1)}\n`);
console.log(`recorded ${cases.length} cases (${errors} ending in an error), ${lines} lines`);
