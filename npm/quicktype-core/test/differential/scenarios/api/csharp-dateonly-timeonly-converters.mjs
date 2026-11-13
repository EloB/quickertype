// Port of test/unit/csharp-dateonly-timeonly-converters.test.ts.

import { schemaInputData } from "./_support.mjs";

async function renderCSharp(qt, rendererOptions = {}) {
    const schema = {
        type: "object",
        properties: {
            name: { type: "string" },
            count: { type: "integer" },
        },
        required: ["name", "count"],
    };
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema: JSON.stringify(schema) });
    return await qt.quicktype({
        inputData,
        lang: "csharp",
        rendererOptions: { framework: "SystemTextJson", ...rendererOptions },
    });
}

export const cases = [
    { name: "emits-converters-by-default", lang: "csharp", run: (qt) => renderCSharp(qt) },
    {
        name: "omits-converters-when-disabled",
        lang: "csharp",
        run: (qt) => renderCSharp(qt, { "dateonly-timeonly-converters": "false" }),
    },
];
