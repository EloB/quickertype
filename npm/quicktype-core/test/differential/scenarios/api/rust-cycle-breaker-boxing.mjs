// Port of test/unit/rust-cycle-breaker-boxing.test.ts.

import { schemaInputData } from "./_support.mjs";

async function renderRust(qt, next, requireNext = false) {
    const inputData = await schemaInputData(qt, {
        name: "Node",
        schema: JSON.stringify({
            $schema: "http://json-schema.org/draft-07/schema#",
            title: "Node",
            type: "object",
            properties: {
                value: { type: "string" },
                next,
            },
            required: requireNext ? ["value", "next"] : ["value"],
        }),
    });
    return await qt.quicktype({ inputData, lang: "rust" });
}

const recursiveUnionMembers = () => [{ $ref: "#" }, { type: "string" }];

export const cases = [
    {
        name: "option-of-boxed-union-member-not-boxed-again",
        run: (qt) => renderRust(qt, { anyOf: [...recursiveUnionMembers(), { type: "null" }] }),
    },
    {
        name: "non-nullable-cycle-breaking-union-stays-boxed",
        run: (qt) => renderRust(qt, { anyOf: recursiveUnionMembers() }, true),
    },
].map((c) => ({ ...c, lang: "rust" }));
