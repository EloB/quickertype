// Port of test/unit/typescript-output-filename.test.ts.

import { jsonInputData } from "./_support.mjs";

async function generate(qt, lang, outputFilename) {
    const inputData = await jsonInputData(qt, lang, "ExperimentCounts", ['{"experiments": 3}']);
    return await qt.quicktype({ inputData, lang, outputFilename });
}

export const cases = [
    {
        name: "typescript-usage-imports",
        lang: "typescript",
        run: (qt) => generate(qt, "typescript", "src/cli/ExperimentCounts.ts"),
    },
    {
        name: "javascript-usage-require",
        lang: "javascript",
        run: (qt) => generate(qt, "javascript", "src/cli/ExperimentCounts.js"),
    },
    {
        name: "flow-usage-require",
        lang: "flow",
        run: (qt) => generate(qt, "flow", "ExperimentCounts.js"),
    },
    {
        name: "file-fallback-for-stdout",
        lang: "typescript",
        async run(qt) {
            const tsOutput = await generate(qt, "typescript");
            const jsOutput = await generate(qt, "javascript");
            return { tsOutput, jsOutput };
        },
    },
];
