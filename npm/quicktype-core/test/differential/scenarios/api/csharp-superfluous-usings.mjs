// Port of test/unit/csharp-superfluous-usings.test.ts.

import { jsonInputData } from "./_support.mjs";

async function renderCSharp(qt, rendererOptions) {
    const inputData = await jsonInputData(qt, "csharp", "Sample", ['{"name":"Alice","age":30,"active":true}']);
    return await qt.quicktype({ inputData, lang: "csharp", rendererOptions });
}

export const cases = [
    {
        name: "NewtonSoft-attributes-only-omits-converter-usings",
        run: (qt) => renderCSharp(qt, { framework: "NewtonSoft", features: "attributes-only" }),
    },
    {
        name: "SystemTextJson-attributes-only-omits-globalization",
        run: (qt) => renderCSharp(qt, { framework: "SystemTextJson", features: "attributes-only" }),
    },
    ...["NewtonSoft", "SystemTextJson"].map((framework) => ({
        name: `${framework}-complete-keeps-converter-usings`,
        run: (qt) => renderCSharp(qt, { framework }),
    })),
].map((c) => ({ ...c, lang: "csharp" }));
