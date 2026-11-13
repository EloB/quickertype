// Port of test/unit/csharp-partial-helpers.test.ts.

import { jsonInputData } from "./_support.mjs";

async function cSharpFor(qt, framework) {
    const inputData = await jsonInputData(qt, "csharp", "Something", ['{"some_property":"hello"}']);
    return await qt.quicktype({ inputData, lang: "csharp", rendererOptions: { framework } });
}

export const cases = ["NewtonSoft", "SystemTextJson"].map((framework) => ({
    name: `${framework}-helpers-are-partial`,
    lang: "csharp",
    run: (qt) => cSharpFor(qt, framework),
}));
