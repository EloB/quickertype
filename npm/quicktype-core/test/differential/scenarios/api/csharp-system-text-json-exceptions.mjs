// Port of test/unit/csharp-system-text-json-exceptions.test.ts.

import { schemaInputData } from "./_support.mjs";

async function renderSystemTextJsonCSharp(qt, schema) {
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema: JSON.stringify(schema) });
    return await qt.quicktype({
        inputData,
        lang: "csharp",
        rendererOptions: { framework: "SystemTextJson" },
    });
}

export const cases = [
    {
        name: "union-converters-throw-serializer-exceptions",
        lang: "csharp",
        run: (qt) =>
            renderSystemTextJsonCSharp(qt, {
                type: "object",
                properties: {
                    mixed: { oneOf: [{ type: "integer" }, { type: "string" }] },
                },
                required: ["mixed"],
            }),
    },
];
