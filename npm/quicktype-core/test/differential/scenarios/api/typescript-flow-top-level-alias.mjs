// Port of test/unit/typescript-flow-top-level-alias.test.ts.

import { schemaInputData } from "./_support.mjs";

async function renderSchema(qt, lang, name, schema) {
    const inputData = await schemaInputData(qt, { name, schema: JSON.stringify(schema) });
    return await qt.quicktype({
        inputData,
        lang,
        rendererOptions: { "just-types": true },
    });
}

const emptyObjectSchema = {
    $schema: "http://json-schema.org/draft-06/schema#",
    type: "object",
    properties: {},
};

export const cases = [
    ...["typescript", "flow"].map((lang) => ({
        name: `${lang}/empty-object-map-alias`,
        lang,
        run: (qt) => renderSchema(qt, lang, "EmptySchema", emptyObjectSchema),
    })),
    ...["typescript", "flow"].map((lang) => ({
        name: `${lang}/no-alias-when-value-type-claims-top-level-name`,
        lang,
        run: (qt) =>
            renderSchema(qt, lang, "TopLevel", {
                type: "object",
                additionalProperties: {
                    type: "object",
                    properties: {
                        one: { type: "integer" },
                        two: { type: "boolean" },
                    },
                    required: ["one", "two"],
                },
            }),
    })),
];
