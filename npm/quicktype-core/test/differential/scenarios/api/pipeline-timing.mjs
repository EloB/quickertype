// Port of test/unit/pipeline-timing.test.ts. Timings differ from run to run,
// so only the names reported to `onTiming` (in order) are returned.

import { jsonInputData, schemaInputData } from "./_support.mjs";

export const cases = [
    {
        name: "reports-input-processing-and-rendering",
        async run(qt) {
            const inputData = await jsonInputData(qt, "typescript", "Example", ['{"id": 1, "name": "quicktype"}']);
            const timings = [];
            const result = await qt.quicktype({
                inputData,
                lang: "typescript",
                onTiming: (timing) => timings.push(timing),
            });
            return {
                names: timings.map(({ name }) => name),
                nonNegative: timings.every(({ milliseconds }) => milliseconds >= 0),
                result,
            };
        },
    },
    {
        name: "reports-json-schema-parsing-separately",
        async run(qt) {
            const inputData = await schemaInputData(qt, {
                name: "Example",
                schema: JSON.stringify({
                    properties: { id: { type: "integer" } },
                    type: "object",
                }),
            });
            const names = [];
            const result = await qt.quicktype({
                inputData,
                lang: "typescript",
                onTiming: ({ name }) => names.push(name),
            });
            return { names, result };
        },
    },
].map((c) => ({ ...c, lang: "typescript" }));
