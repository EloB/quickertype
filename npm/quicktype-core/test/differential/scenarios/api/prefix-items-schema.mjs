// Port of test/unit/prefix-items-schema.test.ts.

import { schemaInputData } from "./_support.mjs";

const defs = () => ({
    Bar: {
        type: "object",
        properties: { barField: { type: "integer" } },
        required: ["barField"],
    },
    Baz: {
        type: "object",
        properties: { bazField: { type: "string" } },
        required: ["bazField"],
    },
});

async function generateTypeScript(qt, schema) {
    const inputData = await schemaInputData(
        qt,
        { name: "Foo", schema: JSON.stringify(schema) },
        new qt.FetchingJSONSchemaStore(),
    );
    return await qt.quicktype({ inputData, lang: "typescript" });
}

export const cases = [
    {
        name: "2020-12-prefixItems-keeps-member-types",
        run: (qt) =>
            generateTypeScript(qt, {
                $schema: "https://json-schema.org/draft/2020-12/schema",
                type: "array",
                prefixItems: [{ $ref: "#/$defs/Bar" }, { $ref: "#/$defs/Baz" }],
                $defs: defs(),
            }),
    },
    {
        name: "object-items-next-to-prefixItems-joins-union",
        run: (qt) =>
            generateTypeScript(qt, {
                $schema: "https://json-schema.org/draft/2020-12/schema",
                type: "array",
                prefixItems: [{ $ref: "#/$defs/Bar" }],
                items: { $ref: "#/$defs/Baz" },
                $defs: defs(),
            }),
    },
    {
        name: "draft-07-array-valued-items",
        run: (qt) =>
            generateTypeScript(qt, {
                $schema: "http://json-schema.org/draft-07/schema#",
                type: "array",
                items: [{ $ref: "#/definitions/Bar" }, { $ref: "#/definitions/Baz" }],
                definitions: defs(),
            }),
    },
].map((c) => ({ ...c, lang: "typescript" }));
