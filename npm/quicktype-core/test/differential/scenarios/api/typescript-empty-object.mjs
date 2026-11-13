// Port of test/unit/typescript-empty-object.test.ts. The runtime tests load
// the generated module with Node's own type stripping (instead of esbuild)
// and return the converted values next to the generated code.

import { importTypeScript, jsonInputData } from "./_support.mjs";

async function render(qt, sample, justTypes) {
    const inputData = await jsonInputData(qt, "typescript", "Welcome", [JSON.stringify(sample)]);
    return await qt.quicktype({
        inputData,
        lang: "typescript",
        rendererOptions: { "just-types": justTypes },
    });
}

async function roundTrip(qt, sample, input) {
    const output = await render(qt, sample, false);
    const { Convert } = await importTypeScript(output.lines.join("\n"));
    if (Convert === undefined) throw new Error("Generated Convert was not exported");
    const value = Convert.toWelcome(JSON.stringify(input));
    return { output, value, roundTripped: JSON.parse(Convert.welcomeToJson(value)) };
}

const collapsedSample = () => ({
    labels: { accountNumber: "Accountnumber" },
    hints: {},
});

export const cases = [
    ...[true, false].map((justTypes) => ({
        name: `just-types=${justTypes}/object-instead-of-empty-interface`,
        run: (qt) => render(qt, collapsedSample(), justTypes),
    })),
    { name: "top-level-empty-object-type-export", run: (qt) => render(qt, {}, true) },
    {
        name: "runtime/round-trips-nested-collapsed-object",
        run: (qt) =>
            roundTrip(qt, collapsedSample(), {
                labels: { accountNumber: "Accountnumber" },
                hints: { foo: "bar", count: 2 },
            }),
    },
    {
        name: "runtime/round-trips-top-level-collapsed-object",
        run: (qt) => roundTrip(qt, {}, { foo: "bar", count: 2 }),
    },
].map((c) => ({ ...c, lang: "typescript" }));
