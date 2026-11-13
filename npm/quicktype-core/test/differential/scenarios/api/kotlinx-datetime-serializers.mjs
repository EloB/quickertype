// Port of test/unit/kotlinx-datetime-serializers.test.ts.

import { schemaInputData } from "./_support.mjs";

async function kotlinxOutput(qt, properties) {
    const schema = JSON.stringify({
        $schema: "http://json-schema.org/draft-06/schema#",
        type: "object",
        properties,
        required: Object.keys(properties),
    });
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema });
    return await qt.quicktype({
        inputData,
        lang: "kotlin",
        rendererOptions: { framework: "kotlinx" },
    });
}

export const cases = [
    {
        name: "emits-serializers-for-date-time-types",
        run: (qt) =>
            kotlinxOutput(qt, {
                date: { type: "string", format: "date" },
                time: { type: "string", format: "time" },
                dateTime: { type: "string", format: "date-time" },
            }),
    },
    {
        name: "emits-only-used-serializers",
        run: (qt) => kotlinxOutput(qt, { date: { type: "string", format: "date" } }),
    },
    {
        name: "no-serializer-machinery-without-date-time",
        run: (qt) => kotlinxOutput(qt, { name: { type: "string" } }),
    },
].map((c) => ({ ...c, lang: "kotlin" }));
