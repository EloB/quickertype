// Port of test/unit/java-acronym-names.test.ts.

import { schemaInputData } from "./_support.mjs";

const enumValue = "MULTI_SPA_IN_GROUP_REJECTED";
const schema = JSON.stringify({
    $schema: "http://json-schema.org/draft-06/schema#",
    type: "object",
    properties: {
        messageCode: {
            type: "string",
            enum: [enumValue],
        },
    },
    required: ["messageCode"],
});

export const cases = ["original", "pascal", "camel", "lowerCase"].map((acronymStyle) => ({
    name: `acronym-style=${acronymStyle}`,
    lang: "java",
    async run(qt) {
        const inputData = await schemaInputData(qt, { name: "TopLevel", schema });
        return await qt.quicktype({
            inputData,
            lang: "java",
            rendererOptions: { "acronym-style": acronymStyle },
        });
    },
}));
