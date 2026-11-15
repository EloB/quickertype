// The differential suite's stored diffs (test/differential/intended.mjs):
// a diff of lines that look like diff headers applies as written.

import assert from "node:assert/strict";
import { test } from "node:test";

import { applyHunks, parseDiff, unifiedDiff } from "./differential/intended.mjs";

test("a removed `-- comment` and an added `++ x` are hunk lines, not headers", () => {
    const before = ["module Main where", "", "-- foo", "x = 1", "y = 2", "z = 3", "w = 4", "end"];
    const after = ["module Main where", "", "x = 1", "y = 2", "++ x", "z = 3", "w = 4", "end"];
    const diff = `--- $.ok.lines\n+++ $.ok.lines\n${unifiedDiff(before, after)}`;
    assert.match(diff, /^--- foo$/m);
    assert.match(diff, /^\+\+\+ x$/m);
    const sections = parseDiff(diff, "test.diff");
    assert.deepEqual([...sections.keys()], ["$.ok.lines"]);
    assert.deepEqual(applyHunks(before, sections.get("$.ok.lines"), "test.diff"), after);
});

test("two sections, and a hunk cut short", () => {
    const a = unifiedDiff(["a", "b"], ["a", "c"]);
    const b = unifiedDiff(["x"], ["--- y"]);
    const sections = parseDiff(`--- $.a\n+++ $.a\n${a}--- $.b\n+++ $.b\n${b}`, "two.diff");
    assert.deepEqual(applyHunks(["a", "b"], sections.get("$.a"), "a"), ["a", "c"]);
    assert.deepEqual(applyHunks(["x"], sections.get("$.b"), "b"), ["--- y"]);
    assert.throws(() => parseDiff(`+++ $.a\n${a.split("\n").slice(0, -2).join("\n")}\n`, "cut.diff"), /cut short/);
});
