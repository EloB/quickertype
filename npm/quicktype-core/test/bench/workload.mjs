// The benchmark itself, the same in Node and in the browser: for each input,
// `addSource` and `quicktypeMultiFile` on each side (a copy of the package
// on its WebAssembly engine, or on the TypeScript engine with
// `Symbol.for("quicktype-core.engine")` = "ts"), in an order that rotates
// from round to round, after warm-up runs; the medians of the warm runs.
// With `again`, each round also runs the same input a second time (as a
// program that generates code for an input it has run already does).

const engineKey = Symbol.for("quicktype-core.engine");

export const median = (values) => {
    const sorted = [...values].sort((a, b) => a - b);
    const middle = sorted.length >> 1;
    return sorted.length % 2 === 1 ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2;
};

/** How many measured runs per side for an input of `length` characters. */
export function defaultRounds(length) {
    if (length > 10_000_000) return 9;
    if (length > 1_000_000) return 21;
    return 41;
}

/**
 * Runs the benchmark. `sides` are `{ name, qt, stats, ts }`: the package,
 * its `engineStats` (to check that a WebAssembly side read its samples and
 * ran on the engine), and whether it runs on the TypeScript engine;
 * `inputs` are `{ name, text }`; `gc` collects garbage between runs if the
 * host lets it (and every run starts in a task of its own, after the
 * finalizers of what was collected); `cpu`, if given, reads the process's
 * CPU time (ms), which is also reported; `again` also times a second run
 * on the same input.
 */
export async function measure(sides, inputs, { lang = "typescript", warmup = 3, rounds = defaultRounds, gc, cpu, onProgress, again = false } = {}) {
    const results = [];
    for (const { name, text } of inputs) {
        const n = rounds(text.length);
        const times = sides.map(() => ({ read: [], generate: [], total: [], cpu: [], again: [] }));
        const outputs = [];
        const before = sides.map((s) => ({ wasm: s.stats.wasm, samplesRead: s.stats.samplesRead }));
        for (let i = 0; i < warmup + n; i++) {
            for (let k = 0; k < sides.length; k++) {
                const index = (i + k) % sides.length;
                const side = sides[index];
                gc?.();
                // Let the finalizers of the inputs just collected run (they
                // free the engine's copies of their samples), as they do
                // between the tasks of a program; a loop of awaits alone
                // never lets them.
                await new Promise((resolve) => setTimeout(resolve, 0));
                if (side.ts) globalThis[engineKey] = "ts";
                try {
                    const cpuStart = cpu?.();
                    const start = performance.now();
                    const input = side.qt.jsonInputForTargetLanguage(lang);
                    await input.addSource({ name: "TopLevel", samples: [text] });
                    const read = performance.now();
                    const inputData = new side.qt.InputData();
                    inputData.addInput(input);
                    const result = await side.qt.quicktypeMultiFile({ inputData, lang });
                    const done = performance.now();
                    const cpuDone = cpu?.();
                    const t = times[index];
                    if (i >= warmup) {
                        t.read.push(read - start);
                        t.generate.push(done - read);
                        t.total.push(done - start);
                        if (cpu !== undefined) t.cpu.push(cpuDone - cpuStart);
                    }

                    if (i === 0) {
                        outputs[index] = [...result].map(([file, { lines }]) => `${file}\n${lines.join("\n")}`).join("\n");
                    }

                    if (again) {
                        const startAgain = performance.now();
                        const inputDataAgain = new side.qt.InputData();
                        inputDataAgain.addInput(input);
                        await side.qt.quicktypeMultiFile({ inputData: inputDataAgain, lang });
                        if (i >= warmup) t.again.push(performance.now() - startAgain);
                    }
                } finally {
                    delete globalThis[engineKey];
                }
            }

            onProgress?.(name, i + 1, warmup + n);
        }

        const runs = warmup + n;
        sides.forEach((side, k) => {
            if (side.ts) return;
            // (Builds from before the engine read JSON samples count none.)
            const samplesRead = side.stats.samplesRead === undefined ? runs : side.stats.samplesRead - before[k].samplesRead;
            if (side.stats.wasm - before[k].wasm !== runs * (again ? 2 : 1) || samplesRead !== runs) {
                throw new Error(`${name}: not every run of ${side.name} read its sample and ran on WebAssembly`);
            }
        });
        if (outputs.some((o) => o !== outputs[0])) throw new Error(`${name}: the outputs differ`);
        const summary = (t) => ({
            read: median(t.read),
            generate: median(t.generate),
            total: median(t.total),
            ...(t.cpu.length > 0 ? { cpu: median(t.cpu) } : {}),
            ...(t.again.length > 0 ? { again: median(t.again) } : {}),
        });
        results.push({
            name,
            length: text.length,
            runs: n,
            outputLength: outputs[0].length,
            sides: Object.fromEntries(sides.map((s, k) => [s.name, summary(times[k])])),
        });
    }

    return results;
}

/** One run, timed: `addSource`, then `quicktypeMultiFile` (the first in a fresh host, for --cold). */
export async function coldRun(qt, text, ts, lang = "typescript") {
    if (ts) globalThis[engineKey] = "ts";
    try {
        const start = performance.now();
        const input = qt.jsonInputForTargetLanguage(lang);
        await input.addSource({ name: "TopLevel", samples: [text] });
        const read = performance.now();
        const inputData = new qt.InputData();
        inputData.addInput(input);
        await qt.quicktypeMultiFile({ inputData, lang });
        const done = performance.now();
        return { read: read - start, generate: done - read, total: done - start };
    } finally {
        delete globalThis[engineKey];
    }
}

/** The medians of `runs` (`{ read, generate, total }` each). */
export function medians(runs) {
    const of = (key) => median(runs.map((r) => r[key]));
    return { read: of("read"), generate: of("generate"), total: of("total"), ...(runs[0].cpu === undefined ? {} : { cpu: of("cpu") }) };
}
