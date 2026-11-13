// The benchmark inputs, by name, made on demand.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { generateJson, generateRulings } from "./generate.mjs";

const repositoryRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..", "..", "..", "..");

export const benchInputs = [
    ["pokedex (82 KB)", () => fs.readFileSync(path.join(repositoryRoot, "tests", "inputs", "json", "samples", "pokedex.json"), "utf8")],
    ["generated (2 MB)", () => generateJson(2_750)],
    ["generated (20 MB)", () => generateJson(27_500)],
    ["rulings (27 MB, 100k records)", () => generateRulings(100_000)],
];
