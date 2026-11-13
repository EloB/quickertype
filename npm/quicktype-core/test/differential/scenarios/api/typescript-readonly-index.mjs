// Port of test/unit/typescript-readonly-index.test.ts.

import { schemaInputData } from "./_support.mjs";

async function render(qt, schema) {
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema: JSON.stringify(schema) });
    return await qt.quicktype({
        inputData,
        lang: "typescript",
        rendererOptions: { readonly: "true" },
    });
}

export const cases = [
    {
        name: "index-signatures",
        run: (qt) =>
            render(qt, {
                type: "object",
                properties: { fixed: { type: "string" } },
                required: ["fixed"],
                additionalProperties: { type: "string" },
            }),
    },
    {
        name: "map-types",
        run: (qt) => render(qt, { type: "object", additionalProperties: { type: "string" } }),
    },
].map((c) => ({ ...c, lang: "typescript" }));
