#!/usr/bin/env node
// Summarizes and compares the results files the patched quicktype fixture
// harness writes (`QUICKTYPE_RESULTS`, one JSON object per line).
//
//   node compare.mjs summary <results.jsonl>...
//   node compare.mjs compare <ts-results.jsonl> <ours-results.jsonl>
//
// `compare` exits 1 when a test passes with the TypeScript CLI but not with
// ours, or ran with only one of them.

import { readFileSync } from "node:fs";

function load(file) {
    const results = new Map();
    for (const line of readFileSync(file, "utf8").split("\n")) {
        if (line.trim() === "") continue;
        const r = JSON.parse(line);
        results.set(key(r), r);
    }
    return results;
}

function key(r) {
    const options = Object.entries(r.options ?? {})
        .map(([k, v]) => `${k}=${v}`)
        .join(",");
    return `${r.fixture} ${r.sample}${options === "" ? "" : ` (${options})`}`;
}

function counts(results) {
    const byFixture = new Map();
    for (const r of results.values()) {
        const c = byFixture.get(r.fixture) ?? { pass: 0, fail: 0, skip: 0 };
        c[r.status] += 1;
        byFixture.set(r.fixture, c);
    }
    return byFixture;
}

function brief(error) {
    if (error === undefined) return "";
    const s = error.replace(/\s+/g, " ");
    return s.length > 300 ? `${s.slice(0, 300)}...` : s;
}

function summary(files) {
    for (const file of files) {
        const results = load(file);
        console.log(`${file}: ${results.size} tests`);
        for (const [fixture, c] of [...counts(results)].sort()) {
            console.log(
                `  ${fixture.padEnd(36)} pass ${String(c.pass).padStart(4)}  fail ${String(c.fail).padStart(4)}  skip ${String(c.skip).padStart(4)}`,
            );
        }
        for (const [k, r] of results) {
            if (r.status === "fail") console.log(`  FAIL ${k}`);
        }
    }
    return 0;
}

function compare(tsFile, oursFile) {
    const ts = load(tsFile);
    const ours = load(oursFile);
    const tsCounts = counts(ts);
    const oursCounts = counts(ours);
    const fixtures = [...new Set([...tsCounts.keys(), ...oursCounts.keys()])];

    console.log(
        `${"fixture".padEnd(36)} ${"TS pass/fail/skip".padEnd(20)} ours pass/fail/skip`,
    );
    for (const fixture of fixtures.sort()) {
        const t = tsCounts.get(fixture) ?? { pass: 0, fail: 0, skip: 0 };
        const o = oursCounts.get(fixture) ?? { pass: 0, fail: 0, skip: 0 };
        console.log(
            `${fixture.padEnd(36)} ${`${t.pass}/${t.fail}/${t.skip}`.padEnd(20)} ${o.pass}/${o.fail}/${o.skip}`,
        );
    }

    const oursOnly = [];
    const tsOnly = [];
    const both = [];
    const missing = [];
    for (const k of new Set([...ts.keys(), ...ours.keys()])) {
        const t = ts.get(k);
        const o = ours.get(k);
        if (t === undefined || o === undefined) {
            missing.push(`${k}: only ${t === undefined ? "ours" : "TS"} ran it`);
        } else if (t.status !== "fail" && o.status === "fail") {
            oursOnly.push(`${k}\n    ${brief(o.error)}`);
        } else if (t.status === "fail" && o.status !== "fail") {
            tsOnly.push(k);
        } else if (t.status === "fail" && o.status === "fail") {
            both.push(k);
        }
    }

    const section = (title, items) => {
        console.log(`\n${title}: ${items.length}`);
        for (const item of items.sort()) console.log(`  ${item}`);
    };
    section("Fail only with ours", oursOnly);
    section("Fail only with TS", tsOnly);
    section("Fail with both (quicktype's own)", both);
    if (missing.length > 0) section("Ran with only one", missing);

    return oursOnly.length > 0 || missing.length > 0 ? 1 : 0;
}

const [mode, ...files] = process.argv.slice(2);
if (mode === "summary" && files.length > 0) {
    process.exit(summary(files));
} else if (mode === "compare" && files.length === 2) {
    process.exit(compare(files[0], files[1]));
} else {
    console.error(
        "usage: compare.mjs summary <results.jsonl>... | compare <ts.jsonl> <ours.jsonl>",
    );
    process.exit(2);
}
