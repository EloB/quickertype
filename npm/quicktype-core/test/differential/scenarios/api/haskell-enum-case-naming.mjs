// Port of test/unit/haskell-enum-case-naming.test.ts.

import { schemaInputData } from "./_support.mjs";

export const cases = [
    {
        name: "suffixes-enum-name-without-over-renaming",
        lang: "haskell",
        async run(qt) {
            const schema = {
                type: "object",
                properties: {
                    health: {
                        type: "string",
                        enum: ["ok", "error"],
                    },
                },
                required: ["health"],
            };
            const inputData = await schemaInputData(qt, { name: "TopLevel", schema: JSON.stringify(schema) });
            return await qt.quicktype({ inputData, lang: "haskell" });
        },
    },
];
