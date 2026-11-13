// Port of test/unit/swift-coding-keys-protocol.test.ts.

import { jsonInputData } from "./_support.mjs";

export const cases = [
    {
        name: "redundant-coding-keys-with-protocol",
        lang: "swift",
        async run(qt) {
            const inputData = await jsonInputData(qt, "swift", "TopLevel", ['{"value": 1}']);
            return await qt.quicktype({
                inputData,
                lang: "swift",
                rendererOptions: { "coding-keys-protocol": "CaseIterable" },
            });
        },
    },
];
