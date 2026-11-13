// Port of test/unit/php-unions.test.ts.

import { jsonInputData } from "./_support.mjs";

async function phpForJSONSamples(qt, samples) {
    const inputData = await jsonInputData(qt, "php", "TopLevel", samples);
    return await qt.quicktype({ inputData, lang: "php" });
}

export const cases = [
    {
        name: "heterogeneous-arrays-runtime-dispatch",
        run: (qt) => phpForJSONSamples(qt, ['{"mixed": [1, "two", true, null, {"nested": "object"}]}']),
    },
    {
        name: "union-property-php8-union-type",
        run: (qt) => phpForJSONSamples(qt, ['{"v": 1}', '{"v": "s"}', '{"v": {"x": 1}}']),
    },
    {
        name: "nullable-unions-keep-question-mark-hint",
        run: (qt) => phpForJSONSamples(qt, ['{"a": "x"}', '{"a": null}']),
    },
    {
        name: "double-member-accepts-integers",
        run: (qt) => phpForJSONSamples(qt, ['{"n": [1, 2.5, "s"]}']),
    },
    {
        name: "reserved-words-not-class-names",
        run: (qt) => phpForJSONSamples(qt, ['{"mixed": {"a": 1}}']),
    },
].map((c) => ({ ...c, lang: "php" }));
