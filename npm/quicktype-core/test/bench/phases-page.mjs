// The page side of phases.mjs: `addSource` then `quicktypeMultiFile` to
// TypeScript on the engine, warm, and where each run's time went. The
// engine's own phases come from its trace (`__trace()`, a `--trace` build),
// read once after each run; the boundary is timed around the glue's calls
// (`jsonRead`, `start`, `poll`), wrapped from outside, so the facade has no
// marks of its own.

const median = (values) => {
    const sorted = [...values].sort((a, b) => a - b);
    const middle = sorted.length >> 1;
    return sorted.length === 0 ? NaN : sorted.length % 2 === 1 ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2;
};
const now = () => performance.now();
const nextTask = () => new Promise((resolve) => setTimeout(resolve, 0));

/** The engine's spans, `{ name, start, end }`. */
function parseTrace(text) {
    const spans = [];
    for (const line of text.split("\n")) {
        if (line === "") continue;
        const [name, start, end] = line.split("\t");
        if (name === "dropped") throw new Error(`the trace dropped ${start} spans`);
        spans.push({ name, start: Number(start), end: Number(end) });
    }
    return spans;
}

/** The passes of a run that are rewrites of the type graph (run.rs). */
export const rewritePasses = [
    "remove indirection intersections",
    "resolve intersections",
    "replace object type",
    "flatten unions",
    "combine classes",
    "combine classes cleanup",
    "infer maps",
    "expand strings",
    "flatten strings",
    "none to any",
    "optional to nullable",
    "fixed point",
    "make transformations",
    "GC",
];

/**
 * Measures `inputs` (`{ name, text }`) on the engine `glue` of package
 * `qt`: the medians, in ms, of each phase over `rounds(length)` runs after
 * three warm-up runs.
 */
export async function measurePhases(qt, glue, inputs, rounds) {
    if (typeof glue.__trace !== "function") throw new Error("the engine is not a --trace build");
    const calls = [];
    for (const fn of ["jsonRead", "start", "poll"]) {
        const original = glue[fn];
        glue[fn] = function (...args) {
            const start = now();
            try {
                return original.apply(this, args);
            } finally {
                calls.push({ fn, start, end: now() });
            }
        };
    }

    const results = [];
    for (const { name, text } of inputs) {
        const n = rounds(text.length);
        const warmup = 3;
        const phases = {};
        let outputLength;
        for (let r = 0; r < warmup + n; r++) {
            globalThis.gc?.();
            await nextTask();
            calls.length = 0;
            glue.__trace();
            const s0 = now();
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "TopLevel", samples: [text] });
            const s1 = now();
            const inputData = new qt.InputData();
            inputData.addInput(input);
            const result = await qt.quicktypeMultiFile({ inputData, lang: "typescript" });
            const s2 = now();
            const spans = parseTrace(glue.__trace());
            if (r === 0) outputLength = [...result].map(([, { lines }]) => lines.join("\n").length).reduce((a, b) => a + b, 0);
            if (r < warmup) continue;
            const the = (fn) => {
                const c = calls.filter((x) => x.fn === fn);
                if (c.length !== 1) throw new Error(`${name}: ${c.length} calls of ${fn}`);
                return c[0];
            };
            const sum = (span) => spans.filter((s) => s.name === span).reduce((a, s) => a + s.end - s.start, 0);
            const read = the("jsonRead");
            const start = the("start");
            const polls = calls.filter((x) => x.fn === "poll");
            const inRust = spans.find((s) => s.name === "jsonRead");
            const passes = rewritePasses.reduce((a, p) => a + sum(p), 0);
            const v = {
                "read: copy in": inRust.start - read.start,
                "read: record": sum("read: record"),
                "read: commit": sum("read: commit"),
                "read: rest of jsonRead": read.end - inRust.start - sum("read: record") - sum("read: commit"),
                "read: facade": s1 - s0 - (read.end - read.start),
                "run: facade, encodeRun": start.start - s1,
                "run: decode request": sum("decode request"),
                "run: assemble": sum("assemble"),
                "run: tally the form": sum("read input: tally the form"),
                "run: infer": sum("read input: infer"),
                "run: rewrites": passes,
                "run: gather names": sum("gather names"),
                "run: render": sum("render"),
                "run: rest of the core run": sum("run") - sum("read input") - passes - sum("gather names") - sum("render"),
                "run: outcome to JavaScript": sum("outcome to JavaScript"),
                // The calls of the run (start, then polls) and between them,
                // but for the spans above.
                "run: rest of the calls":
                    polls[polls.length - 1].end - start.start - sum("decode request") - sum("assemble") - sum("run") - sum("outcome to JavaScript"),
                "run: decode result": s2 - polls[polls.length - 1].end,
                "read (addSource)": s1 - s0,
                "run (quicktypeMultiFile)": s2 - s1,
                total: s2 - s0,
            };
            for (const p of rewritePasses) if (spans.some((s) => s.name === p)) v[`pass: ${p}`] = sum(p);
            for (const [k, x] of Object.entries(v)) (phases[k] ??= []).push(x);
        }

        const medians = {};
        for (const [k, v] of Object.entries(phases)) medians[k] = median(v);
        results.push({ name, length: text.length, runs: n, outputLength, medians });
    }

    return results;
}
