// One cold run in this fresh process (compare.mjs --cold):
//   node cold-node.mjs PACKAGE_DIR wasm|ts INPUT_NAME
// prints `{ read, generate, total, cpu }` (ms) as JSON.

import { createRequire } from "node:module";
import * as path from "node:path";

import { benchInputs } from "./inputs.mjs";
import { coldRun } from "./workload.mjs";

const [dir, mode, name] = process.argv.slice(2);
const text = benchInputs.find(([n]) => n === name)[1]();
const qt = createRequire(import.meta.url)(path.resolve(dir));
const before = process.cpuUsage();
const run = await coldRun(qt, text, mode === "ts");
const cpu = process.cpuUsage(before);
console.log(JSON.stringify({ ...run, cpu: (cpu.user + cpu.system) / 1000 }));
