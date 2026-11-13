// Port of test/unit/kotlin-klaxon-empty-object-map.test.ts.

import { jsonInputData } from "./_support.mjs";

async function kotlinKlaxonForSamples(qt, samples) {
    const inputData = await jsonInputData(qt, "kotlin", "TopLevel", samples);
    return await qt.quicktype({
        inputData,
        lang: "kotlin",
        rendererOptions: { framework: "klaxon" },
    });
}

const bug2881 = JSON.stringify({
    mission_specs: {
        "1": { objectives: { "2": { rewards: { "3": {}, "5": {} } } } },
        "4": { objectives: { "6": { rewards: {} } } },
    },
});

export const cases = [
    {
        name: "map-of-empty-object-fields-get-field-converter",
        run: (qt) => kotlinKlaxonForSamples(qt, [bug2881]),
    },
    {
        name: "nested-maps-of-empty-objects-annotated",
        run: (qt) =>
            kotlinKlaxonForSamples(qt, [JSON.stringify({ outer: { "1": { "2": {}, "3": {} }, "4": { "5": {} } } })]),
    },
    {
        name: "plain-classes-and-non-empty-maps-not-annotated",
        run: (qt) =>
            kotlinKlaxonForSamples(qt, [
                JSON.stringify({
                    plain: { x: 1 },
                    widgets: { "1": { x: 1 }, "4": { x: 2 } },
                }),
            ]),
    },
].map((c) => ({ ...c, lang: "kotlin" }));
