// The regression cases differential fuzzing found (tests/fuzz-regressions,
// recorded by xtask/fuzz/record.mjs), through the JavaScript API, run as
// the fuzzer ran them: xtask/fuzz/run-case.mjs maps a case to its inputs
// and quicktype options (renderer options, inference flags, debug output,
// API options; a Postman collection as the CLI reads it). A case found in
// the "stream" mode reads its JSON samples with the reference CLI's
// CompressedJSONFromStream, when there is a reference checkout to take it
// from; every other case runs in the "api" mode (JSON samples as strings).

import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";

import { cliWordWrap, runInProcess, streamClassFor } from "../../../../../xtask/fuzz/run-case.mjs";
import { packageRoot, repositoryRoot } from "../packages.mjs";

const casesDir = path.join(repositoryRoot, "tests", "fuzz-regressions");

/** The CLI's `wordWrap`, for a Postman collection's description, without a reference checkout. */
const ownWordWrap = createRequire(path.join(packageRoot, "package.json"))("wordwrap")(90);

export function scenarios() {
    if (!fs.existsSync(casesDir)) return [];
    return fs
        .readdirSync(casesDir)
        .sort()
        .filter((name) => fs.existsSync(path.join(casesDir, name, "case.json")))
        .map((name) => [name, JSON.parse(fs.readFileSync(path.join(casesDir, name, "case.json"), "utf8"))])
        // GraphQL input needs quicktype-graphql-input; those cases run through the CLI only.
        .filter(([, record]) => record.case.src !== "graphql")
        .map(([name, record]) => {
            const kase = record.case;
            return {
                id: `fuzz/${name}`,
                category: "fuzz",
                group: kase.src,
                lang: kase.lang,
                async run(qt, ctx) {
                    const checkout = ctx.referenceCheckout;
                    const mode = record.foundIn === "stream" && checkout !== undefined ? "stream" : "api";
                    const side = {
                        qt,
                        wordWrap: checkout !== undefined ? cliWordWrap(checkout) : ownWordWrap,
                        Stream: mode === "stream" ? streamClassFor(checkout, qt) : undefined,
                    };
                    return await runInProcess(side, kase, mode);
                },
            };
        });
}
