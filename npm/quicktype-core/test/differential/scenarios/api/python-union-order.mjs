// Port of test/unit/python-union-order.test.ts.

import { schemaInputData } from "./_support.mjs";

const schema = JSON.stringify({
    type: ["integer", "number"],
});

export const cases = [
    {
        name: "integer-before-number",
        lang: "python",
        async run(qt) {
            const inputData = await schemaInputData(qt, { name: "TopLevel", schema });
            return await qt.quicktype({ inputData, lang: "python" });
        },
    },
];
