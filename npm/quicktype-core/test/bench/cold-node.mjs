// One cold run in this fresh process (compare.mjs --cold):
//   node cold-node.mjs PACKAGE_DIR wasm|ts INPUT_NAME
// prints `{ read, generate, total }` (ms) as JSON.

import { createRequire } from "node:module";
import * as path from "node:path";

import { benchInputs } from "./inputs.mjs";
import { coldRun } from "./workload.mjs";

const [dir, mode, name] = process.argv.slice(2);
const text = benchInputs.find(([n]) => n === name)[1]();
const qt = createRequire(import.meta.url)(path.resolve(dir));
console.log(JSON.stringify(await coldRun(qt, text, mode === "ts")));
