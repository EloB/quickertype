// Port of test/unit/empty-json-samples.test.ts.

import { jsonInputData } from "./_support.mjs";

export const cases = [
    {
        name: "add-source-throws",
        async run(qt) {
            const jsonInput = qt.jsonInputForTargetLanguage("typescript");
            return await jsonInput.addSource({ name: "X", samples: [] });
        },
    },
    {
        name: "add-source-sync-throws",
        run(qt) {
            const jsonInput = qt.jsonInputForTargetLanguage("typescript");
            return jsonInput.addSourceSync({ name: "X", samples: [] });
        },
    },
    {
        name: "non-empty-samples-generate-code",
        async run(qt) {
            const inputData = await jsonInputData(qt, "typescript", "Person", ['{"name":"Alice","age":30}']);
            return await qt.quicktype({ inputData, lang: "typescript" });
        },
    },
].map((c) => ({ ...c, lang: "typescript" }));
