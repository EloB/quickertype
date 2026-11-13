// Port of test/unit/php-validation.test.ts.

import { schemaInputData } from "./_support.mjs";

export const cases = [
    {
        name: "does-not-recheck-scalar-parameter-types",
        lang: "php",
        async run(qt) {
            const schema = {
                type: "object",
                properties: {
                    boolean: { type: "boolean" },
                    integer: { type: "integer" },
                    number: { type: "number" },
                    nullableNumber: { type: ["number", "null"] },
                    string: { type: "string" },
                    integers: { type: "array", items: { type: "integer" } },
                    scalarUnion: {
                        oneOf: [{ type: "integer" }, { type: "string" }],
                    },
                },
                required: ["boolean", "integer", "number", "nullableNumber", "string", "integers", "scalarUnion"],
            };
            const inputData = await schemaInputData(qt, { name: "ScalarValidation", schema: JSON.stringify(schema) });
            return await qt.quicktype({ inputData, lang: "php" });
        },
    },
];
