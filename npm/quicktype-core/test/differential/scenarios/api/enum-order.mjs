// Port of test/unit/enum-order.test.ts.

import { schemaInputData } from "./_support.mjs";

export const cases = [
    {
        name: "csharp",
        lang: "csharp",
        async run(qt) {
            const inputData = await schemaInputData(qt, {
                name: "DaySchema",
                schema: JSON.stringify({
                    $schema: "http://json-schema.org/draft-07/schema#",
                    type: "string",
                    enum: ["Monday", "Tuesday", "Friday", "Sunday"],
                }),
            });
            return await qt.quicktype({ inputData, lang: "csharp" });
        },
    },
    {
        name: "c++",
        lang: "c++",
        async run(qt) {
            const schema = JSON.stringify({
                $schema: "http://json-schema.org/draft-04/schema#",
                title: "Test",
                type: "object",
                properties: {
                    errorCode: {
                        type: "string",
                        enum: ["B", "A", "E"],
                    },
                },
            });
            const inputData = await schemaInputData(qt, { name: "Test", schema });
            return await qt.quicktype({ inputData, lang: "c++" });
        },
    },
];
