#!/usr/bin/env node
// Shrinks a divergence: removes options, top-levels and samples, then
// shrinks every JSON sample or schema as a lossless syntax tree (ddmin over
// the members of each object and array, then simpler values, then hoisting
// a child into its parent's place), keeping only changes after which the
// case still diverges in the same way (same mode, same kind of reference
// outcome: success, the same error, or the same exit code).
//
//   node xtask/fuzz/minimize.mjs <divergence.json> [--mode M] [--out FILE]
//
// Writes `<divergence>.min.json` (or FILE): the shrunk case, its mode and
// the difference it still shows.

import * as fs from "node:fs";

import { makeChecker, outcomeKind } from "./check.mjs";
import { findReference } from "./engines.mjs";
import { arr, lit, num, obj, parse, size, str, toText } from "./json-text.mjs";

const args = process.argv.slice(2);
const option = (name, fallback) => {
    const i = args.indexOf(name);
    return i < 0 ? fallback : args[i + 1];
};
const file = args[0];
const saved = JSON.parse(fs.readFileSync(file, "utf8"));
const mode = option("--mode", saved.mode ?? "api");
const out = option("--out", file.replace(/\.json$/, ".min.json"));
const reference = findReference(option("--reference"));
const { check } = await makeChecker({ reference, bin: option("--bin") });

const clone = (x) => JSON.parse(JSON.stringify(x));
let current = clone(saved.case ?? saved);
const first = await check(current, mode);
if (first.status !== "diff") {
    console.log(`${file}: no divergence in mode ${mode} (${first.status}); nothing to minimize`);
    process.exit(1);
}

const wantKind = outcomeKind(first.expected);
const wantEngine = first.engine === "rerun" ? "rerun" : undefined;
let checks = 0;
let last = first;

async function interesting(kase) {
    checks++;
    let r;
    try {
        r = await check(kase, mode);
    } catch {
        return false;
    }

    if (r.status !== "diff") return false;
    if (wantEngine !== undefined) {
        if (r.engine !== wantEngine) return false;
    } else if (outcomeKind(r.expected) !== wantKind) {
        return false;
    }

    last = r;
    return true;
}

/** Tries `candidate(current)`; keeps it if the divergence remains. */
async function attempt(make) {
    const candidate = make(clone(current));
    if (candidate === undefined) return false;
    if (await interesting(candidate)) {
        current = candidate;
        return true;
    }

    return false;
}

// ---- Options -------------------------------------------------------------------

async function shrinkOptions() {
    for (const key of Object.keys(current.rendererOptions)) {
        await attempt((c) => {
            delete c.rendererOptions[key];
            return c;
        });
    }

    for (const key of Object.keys(current.flags)) {
        await attempt((c) => {
            delete c.flags[key];
            return c;
        });
    }

    for (let i = (current.debug ?? []).length - 1; i >= 0; i--) {
        await attempt((c) => {
            c.debug.splice(i, 1);
            return c;
        });
    }

    for (const part of ["api", "cli"]) {
        for (const key of Object.keys(current[part] ?? {})) {
            await attempt((c) => {
                delete c[part][key];
                return c;
            });
        }
    }
}

// ---- Trees ---------------------------------------------------------------------

/** Every container node of a tree, parents before children, with a path. */
function containers(node, path = [], acc = []) {
    if (node.t === "o" || node.t === "a") {
        acc.push(path);
        node.e.forEach((item, i) => containers(node.t === "o" ? item[1] : item, [...path, i], acc));
    }

    return acc;
}

function at(node, path) {
    let n = node;
    for (const i of path) {
        if (n === undefined || (n.t !== "o" && n.t !== "a") || i >= n.e.length) return undefined;
        n = n.t === "o" ? n.e[i][1] : n.e[i];
    }

    return n;
}

function replaceAt(root, path, replacement) {
    if (path.length === 0) return replacement;
    const parent = at(root, path.slice(0, -1));
    const i = path[path.length - 1];
    if (parent === undefined || (parent.t !== "o" && parent.t !== "a") || i >= parent.e.length) return undefined;
    if (parent.t === "o") parent.e[i][1] = replacement;
    else parent.e[i] = replacement;
    return root;
}

const setIf = (set, c, tree) => (tree === undefined ? undefined : set(c, tree));

const SIMPLER = [() => lit("null"), () => num("1"), () => str("x"), () => obj([]), () => arr([]), () => lit("true")];

/**
 * Shrinks one tree held in the case; `get(c)` and `set(c, tree)` access it.
 * Returns when no single change helps any more.
 */
async function shrinkTree(get, set) {
    let progress = true;
    while (progress) {
        progress = false;
        const paths = containers(get(current));
        for (const path of paths) {
            // ddmin over the members of this container.
            let n = at(get(current), path)?.e?.length ?? 0;
            for (let chunk = Math.max(1, n >> 1); chunk >= 1 && n > 0; chunk = chunk === 1 ? 0 : Math.max(1, chunk >> 1)) {
                for (let startAt = 0; startAt < n; ) {
                    const ok = await attempt((c) => {
                        const root = get(c);
                        const node = at(root, path);
                        if (node === undefined || (node.t !== "o" && node.t !== "a") || startAt >= node.e.length) return undefined;
                        node.e.splice(startAt, chunk);
                        return set(c, root);
                    });
                    if (ok) {
                        progress = true;
                        n = at(get(current), path).e.length;
                    } else {
                        startAt += chunk;
                    }
                }
            }
        }

        // Simpler values, and hoisting children, deepest containers last.
        for (const path of containers(get(current))) {
            const node = at(get(current), path);
            if (node === undefined) continue;
            for (let i = 0; i < (node.e?.length ?? 0); i++) {
                const child = node.t === "o" ? node.e[i][1] : node.e[i];
                if (child === undefined || size(child) <= 1) continue;
                for (const simpler of SIMPLER) {
                    if (await attempt((c) => setIf(set, c, replaceAt(get(c), [...path, i], simpler())))) {
                        progress = true;
                        break;
                    }
                }
            }
        }

        for (const path of containers(get(current))) {
            const node = at(get(current), path);
            if (node === undefined || (node.t !== "o" && node.t !== "a")) continue;
            for (let i = 0; i < node.e.length; i++) {
                const child = node.t === "o" ? node.e[i][1] : node.e[i];
                if (child.t !== "o" && child.t !== "a") continue;
                if (await attempt((c) => setIf(set, c, replaceAt(get(c), path, clone(child))))) {
                    progress = true;
                    break;
                }
            }
        }

        // Shorter strings and keys.
        for (const path of containers(get(current))) {
            const node = at(get(current), path);
            if (node === undefined) continue;
            for (let i = 0; i < (node.e?.length ?? 0); i++) {
                const leaf = node.t === "o" ? node.e[i][1] : node.e[i];
                if (leaf.t === "s" && leaf.raw.length > 3) {
                    if (await attempt((c) => setIf(set, c, replaceAt(get(c), [...path, i], str(leaf.raw.length > 12 ? "x" : "ab"))))) progress = true;
                }

                if (node.t === "o" && node.e[i][0].raw.length > 4 && /^[\x20-\x7e]*$/.test(node.e[i][0].raw)) {
                    const shorter = node.e[i][0].raw.slice(0, Math.max(1, node.e[i][0].raw.length >> 1)).replace(/\\$/, "");
                    if (await attempt((c) => {
                        const root = get(c);
                        at(root, path).e[i][0] = { t: "s", raw: shorter };
                        return set(c, root);
                    })) progress = true;
                }
            }
        }
    }
}

// ---- The case --------------------------------------------------------------------

async function shrinkInputs() {
    if (current.src === "json") {
        for (let t = current.topLevels.length - 1; t >= 0 && current.topLevels.length > 1; t--) {
            await attempt((c) => {
                c.topLevels.splice(t, 1);
                return c;
            });
        }

        for (let t = 0; t < current.topLevels.length; t++) {
            for (let s = current.topLevels[t].samples.length - 1; s >= 0 && current.topLevels[t].samples.length > 1; s--) {
                await attempt((c) => {
                    c.topLevels[t].samples.splice(s, 1);
                    return c;
                });
            }

            if (current.topLevels[t].name !== "TopLevel" && current.topLevels.length === 1) {
                await attempt((c) => {
                    c.topLevels[t].name = "TopLevel";
                    return c;
                });
            }

            for (let s = 0; s < current.topLevels[t].samples.length; s++) {
                const tree = parse(current.topLevels[t].samples[s]);
                if (tree === undefined) continue;
                await attempt((c) => {
                    c.topLevels[t].samples[s] = toText(tree);
                    return c;
                });
                await shrinkTree(
                    (c) => parse(c.topLevels[t].samples[s]),
                    (c, tree) => {
                        c.topLevels[t].samples[s] = toText(tree);
                        return c;
                    },
                );
            }
        }
    } else {
        for (let i = current.schemas.length - 1; i >= 1; i--) {
            await attempt((c) => {
                c.schemas.splice(i, 1);
                return c;
            });
        }

        for (let i = 0; i < current.schemas.length; i++) {
            if (current.schemas[i].name !== "TopLevel") {
                await attempt((c) => {
                    c.schemas[i].name = "TopLevel";
                    return c;
                });
            }

            await shrinkTree(
                (c) => parse(c.schemas[i].text),
                (c, tree) => {
                    c.schemas[i].text = toText(tree);
                    return c;
                },
            );
        }
    }
}

const started = Date.now();
await shrinkOptions();
await shrinkInputs();
await shrinkOptions();

// Readable text at the end, if the divergence survives pretty-printing.
await attempt((c) => {
    if (c.src === "json") {
        for (const tl of c.topLevels) tl.samples = tl.samples.map((s) => (parse(s) === undefined ? s : toText(parse(s), "  ")));
    } else {
        for (const s of c.schemas) if (parse(s.text) !== undefined) s.text = toText(parse(s.text), "  ");
    }

    return c;
});

fs.writeFileSync(out, `${JSON.stringify({ seed: saved.seed, mode, detail: last.detail, case: current, expected: last.expected, actual: last.actual }, undefined, 1)}\n`);
console.log(`${checks} checks in ${((Date.now() - started) / 1000).toFixed(0)}s; ${out}\n  ${last.detail}`);
