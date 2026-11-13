// Port of test/unit/ie-suffix-singularization.test.ts.

import { schemaInputData } from "./_support.mjs";

const schema = JSON.stringify({
    $schema: "http://json-schema.org/draft-07/schema#",
    type: "object",
    properties: {
        cookies: {
            type: "array",
            items: {
                type: "object",
                properties: {
                    name: { type: "string" },
                    value: { type: "string" },
                },
                required: ["name", "value"],
            },
        },
    },
    required: ["cookies"],
});

export const cases = [
    {
        name: "cookies-to-Cookie",
        lang: "typescript",
        async run(qt) {
            const inputData = await schemaInputData(qt, { name: "TopLevel", schema });
            return await qt.quicktype({ inputData, lang: "typescript" });
        },
    },
];
