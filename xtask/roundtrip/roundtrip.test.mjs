// Tests for the round-trip tool's own checks: that it fails, rather than
// passes, when the results do not show a real test.
//
//   node --test xtask/roundtrip/roundtrip.test.mjs

import { spawnSync } from "node:child_process";
import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { after, test } from "node:test";
import assert from "node:assert/strict";

const here = import.meta.dirname;
const dir = mkdtempSync(join(tmpdir(), "roundtrip-test-"));
after(() => rmSync(dir, { recursive: true }));
let files = 0;

function results(...rows) {
    const file = join(dir, `${files++}.jsonl`);
    writeFileSync(file, rows.map((r) => `${JSON.stringify(r)}\n`).join(""));
    return file;
}

function r(fixture, sample, status) {
    return { fixture, sample, options: {}, status, ms: 1 };
}

function run(command, ...args) {
    const p = spawnSync(command, args, { encoding: "utf8" });
    return { code: p.status, out: p.stdout + p.stderr };
}

const compare = (...args) => run("node", join(here, "compare.mjs"), "compare", ...args);
const summary = (...args) => run("node", join(here, "compare.mjs"), "summary", ...args);
const script = (...args) => run(join(here, "roundtrip.sh"), ...args);

const a = r("typescript", "a.json", "pass");
const b = r("typescript", "b.json", "pass");
const s = r("schema-typescript", "s.schema", "pass");

test("identical results compare green", () => {
    const { code, out } = compare("--fixtures", "typescript,schema-typescript", results(a, b, s), results(a, b, s));
    assert.equal(code, 0, out);
});

test("a failure with both is quicktype's own", () => {
    const f = r("typescript", "c.json", "fail");
    const { code, out } = compare(results(a, f), results(a, f));
    assert.equal(code, 0, out);
    assert.match(out, /Fail with both \(quicktype's own\): 1/);
});

test("a failure only with ours fails", () => {
    const { code, out } = compare(results(a, b), results(a, { ...b, status: "fail" }));
    assert.equal(code, 1, out);
    assert.match(out, /Fail only with ours: 1/);
});

test("a timeout only with ours fails", () => {
    const { code, out } = compare(results(a, b), results(a, { ...b, status: "timeout" }));
    assert.equal(code, 1, out);
    assert.match(out, /b\.json \(timed out\)/);
});

test("a test that ran with only one fails", () => {
    const { code, out } = compare(results(a, b), results(a));
    assert.equal(code, 1, out);
    assert.match(out, /only TS ran it/);
});

test("an empty results file fails", () => {
    for (const [ts, ours] of [
        [results(), results()],
        [results(a), results()],
        [results(), results(a)],
    ]) {
        const { code, out } = compare(ts, ours);
        assert.equal(code, 1, out);
        assert.match(out, /has no results/);
    }
});

test("a requested fixture without results fails", () => {
    // Missing on both sides: setup failed, or the name selects nothing.
    let { code, out } = compare("--fixtures", "typescript,typscript", results(a), results(a));
    assert.equal(code, 1, out);
    assert.match(out, /typscript has no results with TS/);
    assert.match(out, /typscript has no results with ours/);

    // Missing on one side.
    ({ code, out } = compare("--fixtures", "typescript,schema-typescript", results(a, s), results(a)));
    assert.equal(code, 1, out);
    assert.match(out, /schema-typescript has no results with ours/);
});

test("a fixture with no passing test with TS fails", () => {
    // What a missing compiler looks like: every test fails with both.
    const fails = [r("python", "a.json", "fail"), r("python", "b.json", "fail")];
    const { code, out } = compare(results(a, ...fails), results(a, ...fails));
    assert.equal(code, 1, out);
    assert.match(out, /python has no test that passes with TS/);

    const skips = [r("python", "a.json", "skip")];
    assert.equal(compare(results(a, ...skips), results(a, ...skips)).code, 1);
});

test("a fixture known to fail every test upstream is still compared", () => {
    // graphql-php fails every test with quicktype's own output: not a
    // broken toolchain, so the comparison passes when both CLIs agree.
    const fails = [r("graphql-php", "g1.graphql", "fail"), r("graphql-php", "g2.graphql", "fail")];
    let { code, out } = compare(results(a, ...fails), results(a, ...fails));
    assert.equal(code, 0, out);
    assert.match(out, /graphql-php: no test passes with TS, known broken upstream/);

    // ...but a test that passes with TS and fails with ours still fails.
    const tsPasses = [r("graphql-php", "g1.graphql", "pass"), r("graphql-php", "g2.graphql", "fail")];
    ({ code, out } = compare(results(a, ...tsPasses), results(a, ...fails)));
    assert.equal(code, 1, out);
});

test("a malformed or missing results file is an error", () => {
    assert.equal(compare(results({ nonsense: true }), results(a)).code, 2);
    assert.equal(compare(join(dir, "missing.jsonl"), results(a)).code, 2);
    assert.equal(compare("--fixtures", "", results(a), results(a)).code, 2);
});

test("summary fails on an empty results file", () => {
    assert.equal(summary(results(a)).code, 0);
    assert.equal(summary(results(a), results()).code, 1);
});

test("roundtrip.sh rejects --jobs and --cpus that run nothing", () => {
    for (const jobs of ["0", "-1", "four", "", "2x"]) {
        const { code, out } = script("steps", dir, "--jobs", jobs);
        assert.equal(code, 2, out);
        assert.match(out, /--jobs needs a positive integer/);
    }
    const { code, out } = script("run", dir, "--cpus", "0", "typescript");
    assert.equal(code, 2, out);
    assert.match(out, /--cpus needs a positive integer/);
});
