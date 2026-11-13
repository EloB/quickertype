// Every JSON sample (tests/inputs/json) and every JSON Schema
// (tests/inputs/schema/*.schema) × every target language, with default
// options, through `quicktypeMultiFile`.

import * as fs from "node:fs";
import * as path from "node:path";

import { inputsDir } from "../packages.mjs";

/** quicktype's `defaultTargetLanguages`, by canonical name. */
export const allLanguages = [
    "cjson", "c++", "crystal", "cs", "dart", "elixir", "elm", "flow", "go", "haskell", "java",
    "javascript", "javascript-prop-types", "schema", "kotlin", "objc", "php", "pike", "python",
    "ruby", "rust", "scala3", "smithy4a", "swift", "typescript", "typescript-effect-schema",
    "typescript-zod",
];

function files(dir, extension) {
    const found = [];
    const walk = (d) => {
        for (const entry of fs.readdirSync(d, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
            const full = path.join(d, entry.name);
            if (entry.isDirectory()) walk(full);
            else if (entry.name.endsWith(extension)) found.push(full);
        }
    };
    walk(dir);
    return found;
}

export function scenarios() {
    const list = [];
    const jsonFiles = files(path.join(inputsDir, "json"), ".json");
    const schemaFiles = files(path.join(inputsDir, "schema"), ".schema");
    for (const lang of allLanguages) {
        for (const file of jsonFiles) {
            list.push({
                id: `inputs/${lang}/${path.relative(inputsDir, file)}`,
                category: "inputs",
                group: `json → ${lang}`,
                lang,
                async run(qt) {
                    const input = qt.jsonInputForTargetLanguage(lang);
                    await input.addSource({ name: "TopLevel", samples: [fs.readFileSync(file, "utf8")] });
                    const inputData = new qt.InputData();
                    inputData.addInput(input);
                    return await qt.quicktypeMultiFile({ lang, inputData });
                },
            });
        }

        for (const file of schemaFiles) {
            list.push({
                id: `inputs/${lang}/${path.relative(inputsDir, file)}`,
                category: "inputs",
                group: `schema → ${lang}`,
                lang,
                async run(qt) {
                    const input = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore());
                    await input.addSource({ name: "TopLevel", uris: [file] });
                    const inputData = new qt.InputData();
                    inputData.addInput(input);
                    return await qt.quicktypeMultiFile({ lang, inputData });
                },
            });
        }
    }

    return list;
}
