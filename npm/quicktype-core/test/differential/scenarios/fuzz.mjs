// The regression cases differential fuzzing found (tests/fuzz-regressions,
// recorded by xtask/fuzz/record.mjs), through `quicktypeMultiFile`: JSON
// samples as strings (JSON.parse semantics), JSON Schemas as source text,
// the case's renderer options, inference flags and API options.

import * as fs from "node:fs";
import * as path from "node:path";

import { repositoryRoot } from "../packages.mjs";

const casesDir = path.join(repositoryRoot, "tests", "fuzz-regressions");

/** quicktype options named like the CLI's `--no-*` inference flags. */
const inferenceFlags = [
    "inferMaps", "inferEnums", "inferUuids", "inferDateTimes", "inferIntegerStrings",
    "inferBooleanStrings", "combineClasses", "ignoreJsonRefs",
];

export function scenarios() {
    if (!fs.existsSync(casesDir)) return [];
    return fs
        .readdirSync(casesDir)
        .sort()
        .filter((name) => fs.existsSync(path.join(casesDir, name, "case.json")))
        .map((name) => {
            const { case: kase } = JSON.parse(fs.readFileSync(path.join(casesDir, name, "case.json"), "utf8"));
            return {
                id: `fuzz/${name}`,
                category: "fuzz",
                group: kase.src,
                lang: kase.lang,
                async run(qt) {
                    const inputData = new qt.InputData();
                    if (kase.src === "json") {
                        const handleRefs = kase.flags.ignoreJsonRefs === false;
                        const input = qt.jsonInputForTargetLanguage(kase.lang, undefined, handleRefs, kase.rendererOptions);
                        for (const tl of kase.topLevels) await input.addSource({ name: tl.name, samples: tl.samples });
                        inputData.addInput(input);
                    } else {
                        const input = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore(), [], []);
                        for (const s of kase.schemas) await input.addSource({ name: s.name, schema: s.text });
                        inputData.addInput(input);
                    }

                    const options = {
                        lang: kase.lang,
                        inputData,
                        rendererOptions: kase.rendererOptions,
                        alphabetizeProperties: kase.flags.alphabetizeProperties === true,
                        allPropertiesOptional: kase.flags.allPropertiesOptional === true,
                        ...kase.api,
                    };
                    for (const flag of inferenceFlags) options[flag] = kase.flags[flag] !== false;
                    return await qt.quicktypeMultiFile(options);
                },
            };
        });
}
