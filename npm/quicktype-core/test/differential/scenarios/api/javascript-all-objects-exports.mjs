// Port of test/unit/javascript-all-objects-exports.test.ts.

import { jsonInputData } from "./_support.mjs";

const sample = JSON.stringify({ data123: { name: "quicktype" } });

async function renderJavaScript(qt, converters) {
    const inputData = await jsonInputData(qt, "js", "TopLevel", [sample]);
    return await qt.quicktype({
        inputData,
        lang: "js",
        rendererOptions: { "acronym-style": "pascal", converters },
    });
}

export const cases = [
    { name: "all-objects-exports-every-converter", run: (qt) => renderJavaScript(qt, "all-objects") },
    { name: "top-level-exports-top-level-converters", run: (qt) => renderJavaScript(qt, "top-level") },
].map((c) => ({ ...c, lang: "js" }));
