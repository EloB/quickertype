// A fuzz worker (forked by fuzz.mjs): asks for seeds, generates each case,
// runs it in the selected modes and reports every outcome. Divergences are
// written to the output directory as `<seed>-<mode>.json`.

import * as fs from "node:fs";
import * as path from "node:path";

import { makeChecker } from "./check.mjs";
import { optionDefinitions } from "./engines.mjs";
import { generateCase } from "./generate.mjs";
import { Rng } from "./rng.mjs";

const config = JSON.parse(process.argv[2]);
const checker = await makeChecker(config);
const definitions = optionDefinitions(checker.sides.ref.qt);

/** The modes a seed runs in (seeded, so a seed always runs the same way). */
export function modesFor(seed, kase, config) {
    const rng = new Rng(seed ^ 0x5eed);
    if (kase.src === "graphql") return config.modes.includes("cli") ? ["cli"] : [];
    const modes = [];
    if (config.modes.includes("api")) modes.push("api");
    if (config.modes.includes("stream") && (kase.src === "json" || kase.src === "postman") && rng.chance(config.streamRate)) modes.push("stream");
    if (config.modes.includes("cli") && rng.chance(config.cliRate)) modes.push("cli");
    // The reference's JSON Schema of the case, as input in its own right.
    if (config.modes.includes("chain") && (kase.src === "json" || kase.src === "postman") && rng.chance(config.chainRate)) modes.push("chain");
    return modes;
}

function truncate(value) {
    const text = JSON.stringify(value);
    return text !== undefined && text.length > 200_000 ? `${text.slice(0, 200_000)}…` : value;
}

async function runSeed(seed) {
    const kase = generateCase(seed, definitions, { languages: config.languages, src: config.src });
    const results = [];
    for (const mode of modesFor(seed, kase, config)) {
        let r;
        let checked = kase;
        let checkedMode = mode;
        try {
            if (mode === "chain") {
                checked = await checker.chain(kase);
                checkedMode = "api";
                r = checked === undefined ? { status: "skip" } : await checker.check(checked, "api");
            } else {
                r = await checker.check(kase, mode);
            }
        } catch (e) {
            r = { status: "diff", detail: `harness error: ${e?.stack ?? e}` };
        }

        results.push({ mode, status: r.status, engine: r.engine, detail: r.detail });
        if (r.status === "diff") {
            // A chained case is saved as the schema case it became (mode api).
            const file = path.join(config.outDir, `${seed}-${mode}.json`);
            fs.writeFileSync(
                file,
                `${JSON.stringify({ seed, mode: checkedMode, detail: r.detail, engine: r.engine, case: checked, expected: truncate(r.expected), actual: truncate(r.actual) }, undefined, 1)}\n`,
            );
        }
    }

    return { seed, lang: kase.lang, src: kase.src, results };
}

process.on("message", async (m) => {
    if (m.seed === undefined) {
        process.exit(0);
    }

    const result = await runSeed(m.seed);
    process.send({ result });
});
process.send({ ready: true });
