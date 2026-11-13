// Port of test/unit/swift-final-classes.test.ts.

import { schemaInputData } from "./_support.mjs";

async function renderSwift(qt, schema, rendererOptions = {}) {
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema: JSON.stringify(schema) });
    return await qt.quicktype({ inputData, lang: "swift", rendererOptions });
}

const modelSchema = {
    type: "object",
    properties: {
        child: {
            type: "object",
            properties: { name: { type: "string" } },
            required: ["name"],
        },
    },
    required: ["child"],
};
const recursiveSchema = {
    $ref: "#/definitions/Node",
    definitions: {
        Node: {
            type: "object",
            properties: {
                next: { $ref: "#/definitions/Node" },
                value: {},
            },
            required: ["value"],
        },
    },
};

export const cases = [
    {
        name: "classes-open-by-default",
        async run(qt) {
            const modelOutput = await renderSwift(qt, modelSchema, { "struct-or-class": "class" });
            const recursiveOutput = await renderSwift(qt, recursiveSchema);
            return { modelOutput, recursiveOutput };
        },
    },
    {
        name: "final-model-classes-when-enabled",
        run: (qt) => renderSwift(qt, modelSchema, { "struct-or-class": "class", "final-classes": "true" }),
    },
    {
        name: "final-cycle-breakers-and-helpers",
        run: (qt) => renderSwift(qt, recursiveSchema, { "final-classes": "true" }),
    },
].map((c) => ({ ...c, lang: "swift" }));
