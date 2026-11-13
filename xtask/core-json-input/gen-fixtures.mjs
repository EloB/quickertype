#!/usr/bin/env node
// Records what the reference quicktype builds from JSON input, for the
// differential tests of the JSON input port (crates/quicktype-core/src/input,
// date_time.rs, the inference hooks of the target languages).
//
// usage: node xtask/core-json-input/gen-fixtures.mjs [path/to/quicktype]
//
// The reference checkout (default $QUICKTYPE_REFERENCE, else ../quicktype
// next to this repository: xtask/reference.mjs) must be built
// (`npm run build`), with node_modules.
//
// For every JSON file in tests/inputs/json and every edge case in
// cases.mjs, each configuration in CONFIGS runs an InputData with one
// JSONInput through one of the two readers:
//
//   stream  the CLI's reader, dist/CompressedJSONFromStream.js (stream-json),
//           fed from fs.createReadStream(path, "utf8") as the CLI does;
//   api     quicktype-core's jsonInputForTargetLanguage (JSON.parse);
//
// then `addTypes` into a fresh TypeBuilder configured like Run does, and
// records the graph print right after `typeBuilder.finish()` (the first
// print of `--debug print-graph`), followed by the properties of every
// class, which the print leaves out (`props <index>[ fixed]: "name"?:index,
// ...`), or `error: <message>` if adding the source or the types throws.
//
// Output, all under crates/quicktype-core/tests/fixtures/core-json-input/:
//
//   configs.json        the configurations
//   inputs/<dir>/<file>.expected   one section per configuration
//   edge.json           the edge cases with their expected output
//   recognizers.json    date/time recognizer answers (default, Kotlin, Swift)
//   uri-attributes.json uriInferenceAttributesProducer results
//   postman.json        sourcesFromPostmanCollection results
//   language-hooks.json the inference hooks of every target language
//
// crates/quicktype-core/tests/json_input.rs replays them without Node.

import { mkdirSync, mkdtempSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { edgeCases, postmanInputs, recognizerInputs, uriInputs } from "./cases.mjs";
import { referenceCheckout } from "../reference.mjs";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktype = referenceCheckout(process.argv[2]);
const require = createRequire(join(quicktype, "package.json"));
const core = (p) => require(join(quicktype, "packages/quicktype-core/dist", p));

const { TypeBuilder } = core("Type/TypeBuilder.js");
const { TypeGraph } = core("Type/TypeGraph.js");
const { initTypeNames } = core("attributes/TypeNames.js");
const { InputData, JSONInput, jsonInputForTargetLanguage } = core("input/Inputs.js");
const { languageNamed, all: allLanguages } = core("language/All.js");
const { DefaultDateTimeRecognizer } = core("DateTime.js");
const { KotlinDateTimeRecognizer } = core("language/Kotlin/utils.js");
const { SwiftDateTimeRecognizer } = core("language/Swift/utils.js");
const { uriInferenceAttributesProducer } = core("attributes/URIAttributes.js");
const { inferenceFlagNames, inferenceFlags } = core("Inference.js");
const { sourcesFromPostmanCollection } = core("input/PostmanCollection.js");
const { CompressedJSONFromStream } = require(join(quicktype, "dist/CompressedJSONFromStream.js"));
const fs = require("node:fs");

const out = join(repoRoot, "crates/quicktype-core/tests/fixtures/core-json-input");

// The configurations every input runs under. `flags` are inference flag
// overrides; `rendererOptions` go to getSupportedIntegerRange.
export const CONFIGS = [
    { name: "stream-typescript", reader: "stream", lang: "typescript", alphabetize: true, provenance: true },
    { name: "api-typescript", reader: "api", lang: "typescript", alphabetize: false, provenance: false },
    { name: "stream-schema", reader: "stream", lang: "schema", alphabetize: false, provenance: false },
    { name: "api-csharp", reader: "api", lang: "csharp", alphabetize: true, provenance: true },
    { name: "stream-kotlin", reader: "stream", lang: "kotlin", alphabetize: false, provenance: false },
    { name: "api-swift", reader: "api", lang: "swift", alphabetize: false, provenance: false },
    { name: "stream-python", reader: "stream", lang: "python", alphabetize: false, provenance: true },
];

const defaultFlags = Object.fromEntries(inferenceFlagNames.map((f) => [f, true]));

/** Run.stringTypeMapping */
function stringTypeMapping(lang, flags) {
    const mapping = new Map(lang.stringTypeMapping);
    for (const flag of inferenceFlagNames) {
        const stringType = inferenceFlags[flag].stringType;
        if (!flags[flag] && stringType !== undefined) mapping.set(stringType, "string");
    }
    return mapping;
}

let tempDir;
let sampleCount = 0;
function streamFor(text) {
    tempDir ??= mkdtempSync(join(tmpdir(), "qt-json-input-"));
    const path = join(tempDir, `sample-${sampleCount++}.json`);
    writeFileSync(path, text, "utf8");
    return fs.createReadStream(path, "utf8");
}

/**
 * Runs one configuration on `sources` ([{name, samples: [{text}|{path}],
 * description}]) and returns the printed lines.
 */
async function run(config, sources, options = {}) {
    initTypeNames();
    const flags = { ...defaultFlags, ...(options.flags ?? {}) };
    const lang = languageNamed(config.lang);
    const rendererOptions = options.rendererOptions ?? {};
    const handleRefs = !flags.ignoreJsonRefs;
    const lines = [];
    const log = console.log;
    try {
        let input;
        if (config.reader === "stream") {
            const cjson = new CompressedJSONFromStream(
                lang.dateTimeRecognizer,
                handleRefs,
                lang.getSupportedIntegerRange(rendererOptions),
            );
            input = new JSONInput(cjson);
        } else {
            input = jsonInputForTargetLanguage(lang, undefined, handleRefs, rendererOptions);
        }
        for (const source of sources) {
            const samples = source.samples.map((s) => {
                if (config.reader === "stream") {
                    return s.path !== undefined ? fs.createReadStream(s.path, "utf8") : streamFor(s.text);
                }
                return s.path !== undefined ? readFileSync(s.path, "utf8") : s.text;
            });
            await input.addSource({ name: source.name, samples, description: source.description });
        }
        const inputData = new InputData();
        inputData.addInput(input);
        const mapping = stringTypeMapping(lang, flags);
        const builder = new TypeBuilder(mapping, config.alphabetize, false, config.provenance, false);
        builder.typeGraph = new TypeGraph(builder, 0, config.provenance);
        const ctx = {
            stringTypeMapping: mapping,
            debugPrintReconstitution: false,
            debugPrintSchemaResolving: false,
            debugPrintTransformations: false,
            time: (_n, f) => f(),
            timeSync: async (_n, f) => await f(),
        };
        await inputData.addTypes(ctx, builder, flags.inferMaps, flags.inferEnums, options.fixedTopLevels ?? false);
        const graph = builder.finish();
        console.log = (line) => lines.push(String(line));
        graph.printGraph();
        console.log = log;
        lines.push(...propertyLines(graph));
    } catch (e) {
        lines.push(`error: ${e instanceof Error ? e.message : String(e)}`);
    } finally {
        console.log = log;
    }
    return lines.map((l) => l.toWellFormed());
}

/**
 * What printGraph leaves out: each class's (or object's) properties in
 * order, as `"name":index` with `?` for optional ones, and whether it is
 * fixed.
 */
function propertyLines(graph) {
    const lines = [];
    for (const t of graph.allTypesUnordered()) {
        if (t.kind !== "class" && t.kind !== "object") continue;
        const props = [...t.getProperties()].map(
            ([name, p]) => `${JSON.stringify(name)}${p.isOptional ? "?" : ""}:${p.type.index}`,
        );
        lines.push(`props ${t.index}${t.isFixed ? " fixed" : ""}: ${props.join(", ")}`);
    }
    return lines;
}

function section(name, lines) {
    return `### ${name}\n${lines.join("\n")}${lines.length > 0 ? "\n" : ""}`;
}

async function main() {
    rmSync(out, { recursive: true, force: true });
    mkdirSync(out, { recursive: true });
    writeFileSync(join(out, "configs.json"), `${JSON.stringify(CONFIGS, null, 2)}\n`);

    // tests/inputs/json
    const inputs = join(repoRoot, "tests/inputs/json");
    let count = 0;
    for (const dir of ["priority", "samples", "misc"]) {
        mkdirSync(join(out, "inputs", dir), { recursive: true });
        for (const file of readdirSync(join(inputs, dir)).sort()) {
            if (!file.endsWith(".json")) continue;
            const path = join(inputs, dir, file);
            const sources = [{ name: "TopLevel", samples: [{ path }] }];
            let text = "";
            for (const config of CONFIGS) {
                text += section(config.name, await run(config, sources));
            }
            writeFileSync(join(out, "inputs", dir, `${file}.expected`), text);
            count++;
        }
    }

    // Edge cases.
    const edge = [];
    for (const c of edgeCases) {
        const sources = c.sources.map((s) => ({
            ...s,
            samples: s.samples.map((text) => ({ text })),
        }));
        const expected = {};
        for (const config of CONFIGS) {
            if (c.configs !== undefined && !c.configs.includes(config.name)) continue;
            expected[config.name] = await run(config, sources, c);
        }
        edge.push({ ...c, expected });
    }
    writeFileSync(join(out, "edge.json"), `${JSON.stringify(edge, null, 1)}\n`);

    // Date/time recognizers.
    const recognizers = {
        default: new DefaultDateTimeRecognizer(),
        kotlin: new KotlinDateTimeRecognizer(),
        swift: new SwiftDateTimeRecognizer(),
    };
    const recognizerVectors = recognizerInputs.map((input) => {
        const v = { input };
        for (const [name, r] of Object.entries(recognizers)) {
            v[name] = [r.isDate(input), r.isTime(input), r.isDateTime(input)];
        }
        return v;
    });
    writeFileSync(join(out, "recognizers.json"), `${JSON.stringify(recognizerVectors, null, 1)}\n`);

    // URI attributes.
    const uriVectors = uriInputs.map((input) => {
        const attributes = uriInferenceAttributesProducer(input);
        const value = [...attributes.values()][0];
        return { input, attributes: value === undefined ? null : [[...value[0]], [...value[1]]] };
    });
    writeFileSync(join(out, "uri-attributes.json"), `${JSON.stringify(uriVectors, null, 1)}\n`);

    // Postman collections.
    const postman = postmanInputs.map((input) => {
        try {
            const { sources, description } = sourcesFromPostmanCollection(input, "collection.json");
            return { input, sources, description: description ?? null };
        } catch (e) {
            return { input, error: e.message };
        }
    });
    writeFileSync(join(out, "postman.json"), `${JSON.stringify(postman, null, 1)}\n`);

    // Inference hooks of every language.
    const optionSets = [
        {},
        { "integer-size": "int8_t" },
        { "integer-size": "int16_t" },
        { "integer-size": "int32_t" },
        { "integer-size": "bogus" },
        { "integer-type": "force-i32" },
        { "integer-type": "force-i64" },
    ];
    const hooks = allLanguages.map((lang) => ({
        name: lang.name,
        stringTypeMapping: [...lang.stringTypeMapping],
        supportsOptionalClassProperties: lang.supportsOptionalClassProperties,
        supportsUnionsWithBothNumberTypes: lang.supportsUnionsWithBothNumberTypes,
        dateTimeRecognizer: lang.dateTimeRecognizer.constructor.name,
        integerRanges: optionSets.map((o) => {
            const r = lang.getSupportedIntegerRange(o);
            return r === null ? null : [r.min, r.max];
        }),
        optionSets,
    }));
    writeFileSync(join(out, "language-hooks.json"), `${JSON.stringify(hooks, null, 1)}\n`);

    if (tempDir !== undefined) rmSync(tempDir, { recursive: true, force: true });
    console.log(`recorded ${count} input files and ${edge.length} edge cases under ${out}`);
}

await main();
