// Port of test/unit/typescript-top-level-array.test.ts. Tests comparing the
// JSON path with the JSON-Schema round trip return both outputs.

import * as fs from "node:fs";
import * as path from "node:path";

import { jsonInputData, schemaInputData } from "./_support.mjs";

async function typesForSchema(qt, ctx, filename, name) {
    const inputData = await schemaInputData(qt, {
        name,
        schema: fs.readFileSync(path.join(ctx.inputsDir, "schema", filename), "utf8"),
    });
    return await qt.quicktype({
        inputData,
        lang: "typescript",
        rendererOptions: { "just-types": true },
    });
}

async function typesForJSON(qt, name, sample) {
    const inputData = await jsonInputData(qt, "typescript", name, [sample]);
    return await qt.quicktype({
        inputData,
        lang: "typescript",
        rendererOptions: { "just-types": true },
    });
}

async function typesForJSONViaSchema(qt, name, sample) {
    const inputData = await jsonInputData(qt, "schema", name, [sample]);
    const schema = await qt.quicktype({ inputData, lang: "schema" });

    const schemaInputData_ = await schemaInputData(qt, { name, schema: schema.lines.join("\n") });
    return await qt.quicktype({
        inputData: schemaInputData_,
        lang: "typescript",
        rendererOptions: { "just-types": true },
    });
}

async function jsonAndViaSchema(qt, sample) {
    const output = await typesForJSON(qt, "Sample", sample);
    return { output, viaSchema: await typesForJSONViaSchema(qt, "Sample", sample) };
}

export const cases = [
    {
        name: "schema-array-alias-keeps-item-title",
        lang: "typescript",
        run: (qt, ctx) => typesForSchema(qt, ctx, "top-level-array.schema", "TextClassificationOutput"),
    },
    {
        name: "schema-primitive-array-alias",
        lang: "typescript",
        run: (qt, ctx) => typesForSchema(qt, ctx, "top-level-primitive-array.schema", "SomeInput"),
    },
    {
        name: "json-array-alias",
        lang: "schema",
        run: (qt) => jsonAndViaSchema(qt, '[{"label":"a","score":1},{"label":"b","score":2}]'),
    },
    {
        name: "json-primitive-array-alias",
        lang: "schema",
        run: (qt) => jsonAndViaSchema(qt, '["one","two"]'),
    },
];
