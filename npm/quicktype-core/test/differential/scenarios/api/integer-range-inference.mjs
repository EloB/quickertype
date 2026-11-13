// Port of the API part of test/unit/integer-range-inference.test.ts. The
// "streaming inference" tests are not ported: they use the CLI's
// CompressedJSONFromStream (src/), which is not part of quicktype-core.

function inRange(qt, rangeName, values) {
    return values.map((value) => [value, rangeName, qt.integerStringInRange(value, qt[rangeName])]);
}

function rangeForLanguage(qt, lang) {
    const language = qt.languageNamed(lang);
    if (language === undefined) {
        throw new Error(`no such language: ${lang}`);
    }

    return language.getSupportedIntegerRange();
}

async function coreLinesForJSON(qt, lang, json, rendererOptions = {}) {
    const jsonInput = qt.jsonInputForTargetLanguage(lang, undefined, false, rendererOptions);
    await jsonInput.addSource({ name: "Edge", samples: [json] });
    const inputData = new qt.InputData();
    inputData.addInput(jsonInput);
    return await qt.quicktype({ inputData, lang, rendererOptions });
}

export const cases = [
    {
        name: "integerStringInRange/inside-int64",
        run: (qt) =>
            inRange(qt, "INT64_RANGE", [
                "0",
                "-0",
                "1",
                "-1",
                "123456789",
                "9223372036854775807",
                "-9223372036854775808",
            ]),
    },
    {
        name: "integerStringInRange/leading-zeros",
        run: (qt) =>
            inRange(qt, "INT64_RANGE", [
                "00000000000000000000042",
                "-00000000000000000000042",
                "009223372036854775807",
                "009223372036854775808",
            ]),
    },
    {
        name: "integerStringInRange/just-outside-int64",
        run: (qt) => inRange(qt, "INT64_RANGE", ["9223372036854775808", "-9223372036854775809"]),
    },
    {
        name: "integerStringInRange/far-outside-int64",
        run: (qt) =>
            inRange(qt, "INT64_RANGE", ["123456789012345678901234567890", "-123456789012345678901234567890"]),
    },
    {
        name: "integerStringInRange/js-safe-narrower-than-int64",
        run: (qt) =>
            inRange(qt, "JS_SAFE_INTEGER_RANGE", [
                "9007199254740991",
                "9007199254740992",
                "-9007199254740991",
                "-9007199254740992",
            ]),
    },
    {
        name: "language-ranges/crystal",
        lang: "crystal",
        run: (qt) => ({ range: rangeForLanguage(qt, "crystal"), INT64_RANGE: qt.INT64_RANGE }),
    },
    {
        name: "language-ranges/elm",
        lang: "elm",
        run: (qt) => ({ range: rangeForLanguage(qt, "elm"), JS_SAFE_INTEGER_RANGE: qt.JS_SAFE_INTEGER_RANGE }),
    },
    {
        name: "language-ranges/cjson-integer-size",
        lang: "cjson",
        run(qt) {
            const cjson = qt.languageNamed("cjson");
            if (cjson === undefined) throw new Error("no such language: cjson");
            return {
                default: cjson.getSupportedIntegerRange(),
                int16: cjson.getSupportedIntegerRange({ "integer-size": "int16_t" }),
                INT64_RANGE: qt.INT64_RANGE,
                INT16_RANGE: qt.INT16_RANGE,
            };
        },
    },
    {
        name: "core/go-between-2^53-and-int64-max",
        lang: "go",
        run: (qt) =>
            coreLinesForJSON(qt, "go", '{"big": 9223372036854774784, "bigger": 123456789012345678901234567890}'),
    },
    {
        name: "core/python-huge-stays-int",
        lang: "python",
        run: (qt) => coreLinesForJSON(qt, "python", '{"huge": 123456789012345678901234567890}'),
    },
    {
        name: "core/cjson-integer-size-narrows-range",
        lang: "cjson",
        async run(qt) {
            const json = '{"n": 32768}';
            const asDefault = await coreLinesForJSON(qt, "cjson", json);
            const asInt16 = await coreLinesForJSON(qt, "cjson", json, { "integer-size": "int16_t" });
            return { asDefault, asInt16 };
        },
    },
];
