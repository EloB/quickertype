// Port of test/unit/csharp-records.test.ts.

import { jsonInputData } from "./_support.mjs";

async function renderCSharp(qt, rendererOptions, sample = '{"name":"Alice","age":37}') {
    const inputData = await jsonInputData(qt, "csharp", "Person", [sample]);
    return await qt.quicktype({ inputData, lang: "csharp", rendererOptions });
}

export const cases = [
    ...["NewtonSoft", "SystemTextJson"].map((framework) => ({
        name: `${framework}-use-records-emits-partial-record`,
        run: (qt) => renderCSharp(qt, { framework, "use-records": true }),
    })),
    { name: "default-remains-partial-class", run: (qt) => renderCSharp(qt, { framework: "SystemTextJson" }) },
    {
        name: "avoids-compiler-generated-record-member-names",
        run: (qt) =>
            renderCSharp(
                qt,
                { "use-records": true },
                '{"clone":"copy","equalityContract":"contract","printMembers":"members"}',
            ),
    },
    {
        name: "just-types-with-use-records-emits-records",
        run: (qt) => renderCSharp(qt, { "use-records": true, "just-types": true }),
    },
].map((c) => ({ ...c, lang: "csharp" }));
