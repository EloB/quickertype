#!/usr/bin/env node
// Records the metadata of every built-in target language of the reference
// quicktype-core (`defaultTargetLanguages`, in order): its names, display
// name and extension, every renderer option's definition, and the CLI's
// expansion of the options (`cliOptionDefinitions`: `actual` is what the
// argument parser accepts, `display` what `--help` lists).
//
// usage: node xtask/core-rendering/record-target-languages.mjs [path/to/quicktype]
//
// The checkout (default $QUICKTYPE_REFERENCE, else ../quicktype next to this
// repository: xtask/reference.mjs) must be built (`npm run build`).
//
// Output: crates/quicktype-core/tests/data/target_languages.json, replayed by
// crates/quicktype-core/tests/target_languages.rs. Fields TypeScript leaves
// undefined are written as null, and an enum option's `values` (a map) as
// its keys.

import { writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { referenceCheckout } from "../reference.mjs";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktype = referenceCheckout(process.argv[2]);
const require = createRequire(join(quicktype, "package.json"));
const { defaultTargetLanguages } = require(join(quicktype, "packages/quicktype-core/dist/index.js"));

const orNull = (value) => (value === undefined ? null : value);

const languages = defaultTargetLanguages.map((language) => ({
    name: language.name,
    names: language.names,
    displayName: language.displayName,
    extension: language.extension,
    options: language.optionDefinitions.map((d) => ({
        name: d.name,
        kind: orNull(d.kind),
        optionType: d.optionType,
        description: d.description,
        typeLabel: orNull(d.typeLabel),
        defaultValue: orNull(d.defaultValue),
        values: d.values === undefined ? null : Object.keys(d.values),
    })),
    cliActual: language.cliOptionDefinitions.actual.map((d) => [d.name, orNull(d.defaultValue)]),
    cliDisplay: language.cliOptionDefinitions.display.map((d) => [d.name, d.description]),
}));

const output = join(repoRoot, "crates/quicktype-core/tests/data/target_languages.json");
writeFileSync(output, `${JSON.stringify(languages, null, 1)}\n`);
console.log(`wrote ${languages.length} languages to ${output}`);
