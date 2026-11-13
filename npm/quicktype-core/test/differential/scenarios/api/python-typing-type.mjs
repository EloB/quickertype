// Port of test/unit/python-typing-type.test.ts.

import { jsonInputData, schemaInputData } from "./_support.mjs";

const schema = {
    type: "object",
    properties: {
        child: {
            type: "object",
            properties: { name: { type: "string" } },
            required: ["name"],
        },
        status: { type: "string", enum: ["ready", "done"] },
        value: { oneOf: [{ type: "integer" }, { type: "string" }] },
    },
    required: ["child", "status", "value"],
};

async function pythonFor(qt, version) {
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema: JSON.stringify(schema) });
    const schemaResult = await qt.quicktype({
        inputData,
        lang: "python",
        rendererOptions: { "python-version": version },
    });

    const jsonInputData_ = await jsonInputData(qt, "python", "MixedValues", ['{"mixed":[null,1,"1",{}]}']);
    const jsonResult = await qt.quicktype({
        inputData: jsonInputData_,
        lang: "python",
        rendererOptions: { "python-version": version },
    });

    return { schemaResult, jsonResult };
}

export const cases = [
    { name: "python-3.6-no-typing-Type", run: (qt) => pythonFor(qt, "3.6") },
    { name: "python-3.7-keeps-typing-Type", run: (qt) => pythonFor(qt, "3.7") },
].map((c) => ({ ...c, lang: "python" }));
