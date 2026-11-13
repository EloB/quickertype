// Port of test/unit/cjson-enum-default.test.ts.

import { schemaInputData } from "./_support.mjs";

const schema = JSON.stringify({
    $schema: "http://json-schema.org/draft-07/schema#",
    type: "object",
    properties: {
        subscription: {
            type: "string",
            enum: ["state", "config", "heartbeat"],
        },
    },
    required: ["subscription"],
});

async function cJSONOutput(qt) {
    const inputData = await schemaInputData(qt, { name: "TopLevel", schema });
    return await qt.quicktype({ inputData, lang: "cjson" });
}

export const cases = [{ name: "invalid-value-does-not-collide", lang: "cjson", run: cJSONOutput }];
