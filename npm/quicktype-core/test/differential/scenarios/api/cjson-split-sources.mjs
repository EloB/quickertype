// Port of test/unit/cjson-split-sources.test.ts: every test returns the
// MultiFileRenderResult its assertions inspect.

import { jsonInputData } from "./_support.mjs";

async function cJSONFiles(qt, rendererOptions, outputFilename = "TopLevel.h") {
    const inputData = await jsonInputData(qt, "cjson", "TopLevel", [
        '{"child": {"n": 1}, "color": "red", "value": 1}',
        '{"child": {"n": 2}, "color": "green", "value": "s"}',
    ]);
    return await qt.quicktypeMultiFile({
        inputData,
        lang: "cjson",
        outputFilename,
        rendererOptions,
    });
}

const pairs = () => ({ "source-style": "multi-source", "header-only": false });

export const cases = [
    { name: "pairs/every-header-gets-a-source-file", run: (qt) => cJSONFiles(qt, pairs()) },
    { name: "pairs/no-file-includes-itself", run: (qt) => cJSONFiles(qt, pairs()) },
    { name: "pairs/generated-files-included-with-quotes", run: (qt) => cJSONFiles(qt, pairs()) },
    { name: "pairs/source-includes-own-header-first", run: (qt) => cJSONFiles(qt, pairs()) },
    {
        name: "header-only/no-sources-no-self-includes",
        run: (qt) => cJSONFiles(qt, { "source-style": "multi-source" }),
    },
    {
        name: "filename/only-trailing-h-swapped",
        run: (qt) => cJSONFiles(qt, { "header-only": false }, "my.house.h"),
    },
].map((c) => ({ ...c, lang: "cjson" }));
