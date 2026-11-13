// Port of test/unit/just-types-option.test.ts. Tests comparing two outputs
// return both.

import { jsonInputData, noCheckout, schemaForTypeScriptSource } from "./_support.mjs";

async function linesFor(qt, lang, rendererOptions = {}) {
    const inputData = await jsonInputData(qt, lang, "Person", ['{"name": "Alice", "age": 37}']);
    return await qt.quicktype({ inputData, lang, rendererOptions });
}

async function kotlinLinesForTypeScript(qt, ctx, source) {
    if (ctx.referenceCheckout === undefined) return noCheckout;
    const schemaInput = new qt.JSONSchemaInput(undefined);
    await schemaInput.addSource(schemaForTypeScriptSource(ctx, source));
    const inputData = new qt.InputData();
    inputData.addInput(schemaInput);
    return await qt.quicktype({
        inputData,
        lang: "kotlin",
        rendererOptions: { "just-types": true },
    });
}

async function both(qt, lang, rendererOptions, plainOptions) {
    return { output: await linesFor(qt, lang, rendererOptions), plain: await linesFor(qt, lang, plainOptions) };
}

export const cases = [
    {
        name: "every-language/csharp",
        lang: "csharp",
        run: (qt) => linesFor(qt, "csharp", { "just-types": true }),
    },
    {
        name: "every-language/csharp-use-records",
        lang: "csharp",
        run: (qt) => linesFor(qt, "csharp", { "just-types": true, "use-records": true }),
    },
    {
        name: "every-language/kotlin",
        lang: "kotlin",
        run: (qt) => linesFor(qt, "kotlin", { "just-types": true }),
    },
    {
        name: "every-language/kotlin-typescript-enum-values",
        lang: "kotlin",
        run: (qt, ctx) =>
            kotlinLinesForTypeScript(
                qt,
                ctx,
                `
            export enum CanvasAction {
                ADD = "add",
                BRING_TO_FRONT = "bringtofront",
                DELETE = "delete",
                FLIP = "flip",
                INVERT = "invert",
                UNDO = "undo",
                REDO = "redo",
            }

            export interface Canvas {
                action: CanvasAction;
            }
        `,
            ),
    },
    {
        name: "every-language/scala3",
        lang: "scala3",
        run: (qt) => linesFor(qt, "scala3", { "just-types": true }),
    },
    {
        name: "every-language/smithy",
        lang: "smithy4a",
        async run(qt) {
            const viaBoolean = await linesFor(qt, "smithy4a", { "just-types": true });
            return { viaBoolean, plain: await linesFor(qt, "smithy4a") };
        },
    },
    ...[
        ["SystemTextJson attributes-only", () => ({ features: "attributes-only" })],
        ["NewtonSoft attributes-only", () => ({ framework: "NewtonSoft", features: "attributes-only" })],
        ["just-types", () => ({ "just-types": true })],
        ["complete", () => ({ features: "complete" })],
    ].map(([name, options]) => ({
        name: `generated-file-marker/${name}`,
        lang: "csharp",
        run: (qt) => linesFor(qt, "csharp", options()),
    })),
    {
        name: "removed-enum-spellings/csharp-features=just-types",
        lang: "csharp",
        run: (qt) => linesFor(qt, "csharp", { features: "just-types" }),
    },
    {
        name: "removed-enum-spellings/csharp-features=just-types-and-namespace",
        lang: "csharp",
        run: (qt) => linesFor(qt, "csharp", { features: "just-types-and-namespace" }),
    },
    {
        name: "removed-enum-spellings/kotlin-framework=just-types",
        lang: "kotlin",
        run: (qt) => linesFor(qt, "kotlin", { framework: "just-types" }),
    },
    {
        name: "removed-enum-spellings/scala3-framework=just-types",
        lang: "scala3",
        run: (qt) => linesFor(qt, "scala3", { framework: "just-types" }),
    },
    {
        name: "just-types-wins/csharp-over-attributes-only",
        lang: "csharp",
        run: (qt) =>
            both(qt, "csharp", { "just-types": true, features: "attributes-only" }, { "just-types": true }),
    },
    {
        name: "just-types-wins/kotlin-over-jackson",
        lang: "kotlin",
        run: (qt) => both(qt, "kotlin", { "just-types": true, framework: "jackson" }, { "just-types": true }),
    },
    {
        name: "just-types-wins/scala3-over-upickle",
        lang: "scala3",
        run: (qt) => both(qt, "scala3", { "just-types": true, framework: "upickle" }, { "just-types": true }),
    },
    { name: "framework-defaults/scala3-circe", lang: "scala3", run: (qt) => linesFor(qt, "scala3") },
    { name: "framework-defaults/kotlin-jackson", lang: "kotlin", run: (qt) => linesFor(qt, "kotlin") },
];
