#!/usr/bin/env node
// Groups the divergences of one or more fuzz runs by mode, kind of
// reference outcome and where the first difference is, to tell distinct
// bugs from repeats of one:
//
//   node xtask/fuzz/triage.mjs target/fuzz/run-1 [target/fuzz/run-2 ...]

import * as fs from "node:fs";
import * as path from "node:path";

import { outcomeKind } from "./check.mjs";

const groups = new Map();
for (const dir of process.argv.slice(2)) {
    for (const name of fs.readdirSync(dir)) {
        if (!/^\d+-(api|stream|cli|chain)\.json$/.test(name)) continue;
        const file = path.join(dir, name);
        const d = JSON.parse(fs.readFileSync(file, "utf8"));
        // The difference's location without indexes and its expected side, roughly.
        const where = String(d.detail)
            .replace(/\.\d+/g, ".N")
            .replace(/: expected .*/s, "");
        const key = `${d.mode} ${d.case.src} ${outcomeKind(d.expected)} ${d.engine === "rerun" ? "engine failure" : where}`;
        if (!groups.has(key)) groups.set(key, []);
        groups.get(key).push({ file, lang: d.case.lang, detail: d.detail });
    }
}

for (const [key, list] of [...groups].sort((a, b) => b[1].length - a[1].length)) {
    const langs = [...new Set(list.map((d) => d.lang))].join(",");
    console.log(`${list.length}× ${key}  [${langs}]`);
    for (const d of list.slice(0, 3)) console.log(`    ${d.file}: ${String(d.detail).slice(0, 220)}`);
}
