// Generates the test fixtures under crates/quicktype-core/tests/fixtures/core-type-graph/
// from the built reference quicktype (needs `npm run build` there).
//
// Usage: node xtask/core-type-graph/gen-fixtures.mjs ../quicktype
import { writeFileSync, mkdirSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const quicktype = resolve(process.argv[2] ?? "../quicktype");
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

console.log(`wrote fixtures to ${outDir}`);
