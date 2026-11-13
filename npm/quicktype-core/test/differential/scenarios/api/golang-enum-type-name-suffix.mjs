// Port of test/unit/golang-enum-type-name-suffix.test.ts.

import { schemaInputData } from "./_support.mjs";

async function renderGo(qt, name, schema, enumTypeNameSuffix) {
    const inputData = await schemaInputData(qt, { name, schema: JSON.stringify(schema) });
    return await qt.quicktype({
        inputData,
        lang: "go",
        rendererOptions: enumTypeNameSuffix === undefined ? {} : { "enum-type-name-suffix": enumTypeNameSuffix },
    });
}

const dogNoiseSchema = () => ({
    type: "string",
    enum: ["BARK", "GROWL", "HOWL"],
});

export const cases = [
    {
        name: "off-by-default-qualifies-when-enabled",
        async run(qt) {
            const defaultOutput = await renderGo(qt, "DogNoise", dogNoiseSchema(), undefined);
            const qualifiedOutput = await renderGo(qt, "DogNoise", dogNoiseSchema(), true);
            const independentlyQualifiedOutput = await renderGo(
                qt,
                "TreePart",
                { type: "string", enum: ["BARK", "LEAF", "ROOT"] },
                true,
            );
            return { defaultOutput, qualifiedOutput, independentlyQualifiedOutput };
        },
    },
    {
        name: "collisions-use-complete-qualified-name",
        run: (qt) =>
            renderGo(
                qt,
                "TopLevel",
                {
                    type: "object",
                    properties: {
                        noise: { $ref: "#/$defs/DogNoise" },
                        collision: { $ref: "#/$defs/BarkDogNoise" },
                    },
                    $defs: {
                        DogNoise: dogNoiseSchema(),
                        BarkDogNoise: {
                            type: "object",
                            properties: { value: { type: "string" } },
                        },
                    },
                },
                true,
            ),
    },
].map((c) => ({ ...c, lang: "go" }));
