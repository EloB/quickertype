// The regression cases differential fuzzing found (tests/fuzz-regressions,
// recorded by xtask/fuzz/record.mjs), through `quicktypeMultiFile`: JSON
// samples as strings (JSON.parse semantics), JSON Schemas as source text,
// the case's renderer options, inference flags and API options.

import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";

import { packageRoot, repositoryRoot } from "../packages.mjs";

const casesDir = path.join(repositoryRoot, "tests", "fuzz-regressions");

/** The CLI's `wordWrap`, for a Postman collection's description. */
const wordWrap = createRequire(path.join(packageRoot, "package.json"))("wordwrap")(90);

/** quicktype options named like the CLI's `--no-*` inference flags. */
const inferenceFlags = [
    "inferMaps", "inferEnums", "inferUuids", "inferDateTimes", "inferIntegerStrings",
    "inferBooleanStrings", "combineClasses", "ignoreJsonRefs",
];

/** The CLI's `--debug` components and the quicktype options they set. */
const debugOptions = [
    ["print-graph", "debugPrintGraph"],
    ["print-reconstitution", "debugPrintReconstitution"],
    ["print-gather-names", "debugPrintGatherNames"],
    ["print-transformations", "debugPrintTransformations"],
    ["print-schema-resolving", "debugPrintSchemaResolving"],
    ["provenance", "checkProvenance"],
];

export function scenarios() {
    if (!fs.existsSync(casesDir)) return [];
    return fs
        .readdirSync(casesDir)
        .sort()
        .filter((name) => fs.existsSync(path.join(casesDir, name, "case.json")))
        .map((name) => [name, JSON.parse(fs.readFileSync(path.join(casesDir, name, "case.json"), "utf8")).case])
        // GraphQL input needs quicktype-graphql-input; those cases run through the CLI only.
        .filter(([, kase]) => kase.src !== "graphql")
        .map(([name, kase]) => {
            return {
                id: `fuzz/${name}`,
                category: "fuzz",
                group: kase.src,
                lang: kase.lang,
                async run(qt) {
                    const inputData = new qt.InputData();
                    const extra = {};
                    if (kase.src === "json" || kase.src === "postman" || kase.src === "mixed") {
                        let topLevels = kase.topLevels;
                        if (kase.src === "postman") {
                            // What the CLI does with a collection (its src/index.ts).
                            const { sources, description } = qt.sourcesFromPostmanCollection(kase.postman, "in/collection.json");
                            topLevels = sources;
                            if (sources.length > 1) extra.fixedTopLevels = true;
                            if (description !== undefined) extra.leadingComments = wordWrap(description).split("\n");
                        }

                        const handleRefs = kase.flags.ignoreJsonRefs === false;
                        const input = qt.jsonInputForTargetLanguage(kase.lang, undefined, handleRefs, kase.api?.rendererOptions ?? kase.rendererOptions);
                        for (const tl of topLevels) await input.addSource(tl);
                        inputData.addInput(input);
                    }

                    if (kase.src === "schema" || kase.src === "mixed") {
                        const input = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore(), [], []);
                        for (const s of kase.schemas) await input.addSource(s.uris === undefined ? { name: s.name, schema: s.text } : { name: s.name, schema: s.text, uris: s.uris });
                        inputData.addInput(input);
                    }

                    const options = {
                        lang: kase.lang,
                        inputData,
                        rendererOptions: kase.rendererOptions,
                        alphabetizeProperties: kase.flags.alphabetizeProperties === true,
                        allPropertiesOptional: kase.flags.allPropertiesOptional === true,
                        ...kase.api,
                        ...extra,
                    };
                    for (const flag of inferenceFlags) options[flag] = kase.flags[flag] !== false;
                    for (const [component, name] of debugOptions) if (kase.debug?.includes(component)) options[name] = true;
                    return await qt.quicktypeMultiFile(options);
                },
            };
        });
}
