#!/usr/bin/env node
// Summarizes and compares the results files the patched quicktype fixture
// harness writes (`QUICKTYPE_RESULTS`, one JSON object per line).
//
//   node compare.mjs summary <results.jsonl>...
//   node compare.mjs compare [--fixtures <fixture>[,<fixture>...]]
//                            <ts-results.jsonl> <ours-results.jsonl>
//
// `compare` exits 1 when a test passes with the TypeScript CLI but not with
// ours, or ran with only one of them, and when the files do not show a real
// test: either file has no results, a fixture has no passing test with the
// TypeScript CLI (a broken toolchain fails them all), or a fixture named
// with `--fixtures` (exact names, as in the results) has no results in
// either file. `summary` exits 1 when a file has no results. Fixtures known
// to fail every test upstream (`knownBrokenUpstream`) are exempt from the
// "no test passes with TS" check only.

import { readFileSync } from "node:fs";

// `timeout`: the test hit the harness's time limit, and its worker was
// replaced. It counts as a failure.
const statuses = ["pass", "fail", "timeout", "skip"];

// Fixtures whose every test fails with quicktype's own CLI at the
// reference commit, so "no test passes with TS" says nothing about the
// toolchain. They are still compared test by test: a test that passes with
// TS and fails with ours, or ran with one CLI only, still fails `compare`.
const knownBrokenUpstream = new Map([
    [
        "graphql-php",
        "every GraphQL input fails with quicktype's own PHP output; quicktype's CI (test-pr.yaml) does not run this fixture",
    ],
]);

function load(file) {
    const results = new Map();
    const lines = readFileSync(file, "utf8").split("\n");
    for (const [i, line] of lines.entries()) {
        if (line.trim() === "") continue;
        const r = JSON.parse(line);
        if (typeof r.fixture !== "string" || !statuses.includes(r.status)) {
            throw new Error(`${file}:${i + 1}: not a test result: ${line.slice(0, 200)}`);
        }
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

function failed(r) {
    return r.status === "fail" || r.status === "timeout";
}

function counts(results) {
    const byFixture = new Map();
    for (const r of results.values()) {
        const c = byFixture.get(r.fixture) ?? { pass: 0, fail: 0, timeout: 0, skip: 0 };
        c[r.status] += 1;
        byFixture.set(r.fixture, c);
    }
    return byFixture;
}

const zero = { pass: 0, fail: 0, timeout: 0, skip: 0 };

// pass/fail/skip, with the timeouts among the failures.
function brief(c) {
    const timeouts = c.timeout > 0 ? ` (${c.timeout} timed out)` : "";
    return `${c.pass}/${c.fail + c.timeout}/${c.skip}${timeouts}`;
}

function briefError(error) {
    if (error === undefined) return "";
    const s = error.replace(/\s+/g, " ");
    return s.length > 300 ? `${s.slice(0, 300)}...` : s;
}

function summary(files) {
    let status = 0;
    for (const file of files) {
        const results = load(file);
        console.log(`${file}: ${results.size} tests`);
        if (results.size === 0) {
            console.log("  no results: nothing ran");
            status = 1;
        }
        for (const [fixture, c] of [...counts(results)].sort()) {
            console.log(
                `  ${fixture.padEnd(36)} pass ${String(c.pass).padStart(4)}  fail ${String(c.fail + c.timeout).padStart(4)}  skip ${String(c.skip).padStart(4)}`,
            );
        }
        for (const [k, r] of results) {
            if (failed(r)) console.log(`  ${r.status === "timeout" ? "TIMEOUT" : "FAIL"} ${k}`);
        }
    }
    return status;
}

function compare(tsFile, oursFile, requested) {
    const ts = load(tsFile);
    const ours = load(oursFile);
    const tsCounts = counts(ts);
    const oursCounts = counts(ours);
    const fixtures = [...new Set([...tsCounts.keys(), ...oursCounts.keys(), ...requested])];

    console.log(
        `${"fixture".padEnd(36)} ${"TS pass/fail/skip".padEnd(20)} ours pass/fail/skip`,
    );
    for (const fixture of fixtures.sort()) {
        const t = tsCounts.get(fixture) ?? zero;
        const o = oursCounts.get(fixture) ?? zero;
        console.log(`${fixture.padEnd(36)} ${brief(t).padEnd(20)} ${brief(o)}`);
    }

    // What makes the comparison meaningless.
    const untested = [];
    for (const [file, results] of [
        [tsFile, ts],
        [oursFile, ours],
    ]) {
        if (results.size === 0) untested.push(`${file} has no results`);
    }
    for (const fixture of requested) {
        if (!tsCounts.has(fixture)) untested.push(`${fixture} has no results with TS`);
        if (!oursCounts.has(fixture)) untested.push(`${fixture} has no results with ours`);
    }
    for (const [fixture, c] of tsCounts) {
        if (c.pass > 0) continue;
        const reason = knownBrokenUpstream.get(fixture);
        if (reason === undefined) untested.push(`${fixture} has no test that passes with TS`);
        else console.log(`\n${fixture}: no test passes with TS, known broken upstream (${reason})`);
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
        } else if (!failed(t) && failed(o)) {
            oursOnly.push(`${k}${o.status === "timeout" ? " (timed out)" : ""}\n    ${briefError(o.error)}`);
        } else if (failed(t) && !failed(o)) {
            tsOnly.push(k);
        } else if (failed(t) && failed(o)) {
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
    if (untested.length > 0) section("Not tested", untested);

    return oursOnly.length > 0 || missing.length > 0 || untested.length > 0 ? 1 : 0;
}

function usage() {
    console.error(
        "usage: compare.mjs summary <results.jsonl>... | compare [--fixtures <a,b,...>] <ts.jsonl> <ours.jsonl>",
    );
    return 2;
}

function main(args) {
    const [mode, ...rest] = args;
    if (mode === "summary" && rest.length > 0) return summary(rest);
    if (mode !== "compare") return usage();
    let requested = [];
    if (rest[0] === "--fixtures") {
        requested = (rest[1] ?? "").split(",");
        if (requested.some((f) => f === "")) return usage();
        rest.splice(0, 2);
    }
    if (rest.length !== 2) return usage();
    return compare(rest[0], rest[1], requested);
}

try {
    process.exit(main(process.argv.slice(2)));
} catch (e) {
    console.error(`compare.mjs: ${e.message}`);
    process.exit(2);
}
