// Generates the test fixtures under crates/quicktype-core/tests/fixtures/core-type-graph/
// from the built reference quicktype (needs `npm run build` there).
//
// Usage: node xtask/core-type-graph/gen-fixtures.mjs ../quicktype
import { writeFileSync, mkdirSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { referenceCheckout } from "../reference.mjs";

const quicktype = referenceCheckout(process.argv[2]);
const require = createRequire(join(quicktype, "package.json"));
const core = join(quicktype, "packages/quicktype-core/dist");
const { Chance } = require(join(core, "support/Chance.js"));

const outDir = join(
    dirname(fileURLToPath(import.meta.url)),
    "../../crates/quicktype-core/tests/fixtures/core-type-graph",
);
mkdirSync(outDir, { recursive: true });

// 1. The random names TooManyTypeNames draws: `${city()} ${animal()}` from
//    Chance(31415), interleaved with raw integers to pin consumption order.
{
    const chance = new Chance(31415);
    const lines = [];
    for (let i = 0; i < 200; i++) {
        lines.push(`${chance.city()} ${chance.animal()}`);
    }
    const raw = new Chance(1);
    for (let i = 0; i < 50; i++) {
        lines.push(`random ${raw.random()}`);
    }
    writeFileSync(join(outDir, "chance.txt"), `${lines.join("\n")}\n`);
}

// 2. TypeNames.combinedName for sets of names (tab-separated, then the result).
{
    const { TypeNames } = require(join(core, "attributes/TypeNames.js"));
    const sets = [
        ["fooBar"],
        ["fooBar", "foo_bar"],
        ["userName", "userNames", "userNameList"],
        ["billingAddress", "shippingAddress"],
        ["ab", "cd"],
        ["aaa", "aaaa"],
        ["URLPath", "urlPath"],
        ["HTTPServer", "HttpServer", "httpServerConfig"],
        ["item", "items", "itemList"],
        ["created_at", "updated_at"],
        ["Pokemon", "PokemonEntry", "pokemons"],
        ["x1", "x2", "x3"],
        ["firstName", "lastName", "middleName"],
        ["value", "Value", "VALUE"],
        ["dataPoint", "data-point", "data point"],
        ["ABCDef", "ABCdef"],
        ["a1b2", "a1b3"],
        ["größeWert", "größeListe"],
        ["ÉtatCivil", "étatCivil", "étatCivilCode"],
        ["naïveData", "NaïveData"],
        ["ΑλφαΒήτα", "αλφαΓάμμα"],
        ["日本語名", "日本語"],
        ["🙂smile", "🙂frown"],
    ];
    const lines = sets.map(
        (names) => `${names.join("\t")}\t=\t${TypeNames.make(new Set(names), undefined, false).combinedName}`,
    );
    writeFileSync(join(outDir, "combined-names.txt"), `${lines.join("\n")}\n`);
}

console.log(`wrote fixtures to ${outDir}`);
