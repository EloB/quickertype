// Port of test/unit/json-schema-definitions.test.ts.

import { schemaInputData } from "./_support.mjs";

const lightSchema = {
    $schema: "https://json-schema.org/draft/2020-12/schema",
    $defs: {
        LightParams: {
            type: "object",
            properties: {
                outlet_id: { type: "string" },
                app_id: { type: "string" },
                rgba: { type: "string" },
            },
            additionalProperties: false,
            required: ["outlet_id", "app_id", "rgba"],
        },
    },
    type: "object",
    properties: {
        LightParams: { $ref: "#/$defs/LightParams" },
    },
    additionalProperties: false,
    required: ["LightParams"],
};

export const cases = [
    {
        name: "defs-type-keeps-definition-name",
        lang: "typescript",
        async run(qt) {
            const inputData = await schemaInputData(
                qt,
                { name: "LightSchema", schema: JSON.stringify(lightSchema) },
                new qt.FetchingJSONSchemaStore(),
            );
            return await qt.quicktype({
                inputData,
                lang: "typescript",
                rendererOptions: { "just-types": "true" },
            });
        },
    },
];
