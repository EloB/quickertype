// Port of test/unit/rust-empty-top-levels.test.ts (which feeds a converted
// schema directly, without quicktype-typescript-input).

import { schemaInputData } from "./_support.mjs";

async function renderTypeScriptSchema(qt, definitions) {
    const inputData = await schemaInputData(qt, {
        name: "",
        schema: JSON.stringify({ definitions }),
        uris: ["#/definitions/"],
        isConverted: true,
    });
    return await qt.quicktype({ inputData, lang: "rust" });
}

export const cases = [
    { name: "no-top-levels", run: (qt) => renderTypeScriptSchema(qt, {}) },
    {
        name: "named-definitions",
        run: (qt) =>
            renderTypeScriptSchema(qt, {
                Person: {
                    type: "object",
                    properties: { age: { type: "integer" } },
                    required: ["age"],
                },
            }),
    },
].map((c) => ({ ...c, lang: "rust" }));
