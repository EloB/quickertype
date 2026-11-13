// Port of test/unit/swift-json-null-hashable.test.ts.

import { schemaInputData } from "./_support.mjs";

const schema = JSON.stringify({
    type: "object",
    properties: {
        value: {},
    },
    required: ["value"],
});

export const cases = [
    {
        name: "modern-hashable-for-JSONNull",
        lang: "swift",
        async run(qt) {
            const inputData = await schemaInputData(qt, { name: "TopLevel", schema });
            return await qt.quicktype({ inputData, lang: "swift" });
        },
    },
];
