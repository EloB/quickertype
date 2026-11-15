// Reading a large JSON sample in parts, on several engine instances at
// once. Not quickertype-core's public API: the playground's workers use it
// (site/src/worker.js, part-worker.js), and its tests. The rules are the
// engine's (crates/quicktype-core/src/input/parts.rs: those of the CLI's
// reader on several threads); this module moves bytes and numbers between
// instances.
//
// A sample of `size` bytes, a top-level array or JSON Lines, is cut into
// ranges (`splitPlan`). Each `PartWorker` (an engine instance of its own,
// on a Web Worker of its own in a browser) gets a block of consecutive
// ranges, reads their bytes once and keeps them while the sample is read:
//
// 1. Each worker summarizes each of its ranges (`splitSummarize`). This
//    instance resolves every range's state at its start from all the
//    summaries, in order (`splitResolve`).
// 2. Each worker finds the first split in each of its ranges that may hold
//    one (`splitFind`). This instance forms the parts between consecutive
//    splits (`splitParts`), reads the first ones itself, measuring their
//    trees (`partsReadMeasured`), and decides whether the rest is read in
//    parts (`splitDecide`), as the CLI does.
// 3. Each worker reads the parts that start in its ranges into tallies of
//    its own, one after the other (`partsRead`), and hands them over as
//    bytes (`partsExport`). This instance appends them in order
//    (`partsAppend`).
//
// What crosses instances: the ranges' bounds, the summaries (15 numbers a
// range), the states (4), the splits (1 each), the parts (3 each), and each
// worker's tallies as bytes: its tree, with its keys and cases as text, so
// that nothing depends on how an instance hashes (each has a seed of its
// own).
//
// Where the CLI's reader would read the sample in one go (no split, JSON
// Lines without one in their first MiB, a part too long, trees far larger
// than their text), or a part does not read (it is not JSON there, the
// engine declines one of its values, its bytes are not UTF-8), or a worker
// fails, or anything else goes wrong: `readJSONInputInParts` resolves (it
// never rejects) to `{ inOneGo: reason, always }`, and the caller reads the
// sample in one go, which reports what it always reports, errors and their
// messages included. `always` says whether the reason is the sample's own
// (the first ones, above), which a caller may remember for the sample, or
// this reading's (a worker that failed, an input or engine that cannot),
// which the next reading may not meet.
//
// A sample read in parts is the input's one sample, as `addSource` would
// have added it (`addTalliedSample`, samples.ts), but what the engine keeps
// of it is tallies, not a compressed form: runs on the engine use them, and
// should anything read the `CompressedJSON`'s tables (a run that goes to
// the TypeScript engine), they are filled by reading the sample again
// (`reread`), with TypeScript, as `addSource` would have filled them.

import { engineFailed } from "./bridge.js";
import { engineAsync, isDiscarded } from "./engine.js";
import { type PartWorker, notRead } from "./parts.js";
import { addTalliedSample, freshReading } from "./samples.js";
import type { WasmGlue } from "./wasm/glue.js";

export { PartReader, type PartWorker, type SummarizeJob, type SplitJob, type TallyJob, type TallyResult } from "./parts.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the input is the facade's own object

/** A sample to read in parts. */
export interface PartsSource {
    /** The top-level's name, and its description. */
    name: string;
    description?: string;
    /** Whether it is JSON Lines. */
    lines: boolean;
    /** Its length in bytes. */
    size: number;
    /** Its bytes from `from` to `to`. */
    read(from: number, to: number): Promise<Uint8Array>;
    /**
     * The sample again (its bytes, or its text), for the `CompressedJSON`'s
     * tables, should anything read them (see the top); without it, reading
     * them throws.
     */
    reread?: () => string | Uint8Array;
}

/** Options of `readJSONInputInParts`, for tests (the CLI's internal `QUICKTYPE_READ_CHUNK` and its 8 MiB). */
export interface PartsOptions {
    /** Samples shorter than this are read in one go (default 8 MiB). */
    minLength?: number;
    /** Ranges of at most this many bytes, down to one. */
    range?: number;
}

/**
 * Why a sample is to be read in one go after all, and whether that is so of
 * the sample, whatever reads it and however often (`always`: it is not an
 * array, has no split, is not JSON in a part, has trees far larger than its
 * text), so that a caller may remember it for the sample; or only of this
 * reading (the input, the engine, a worker, a limit of the moment), so that
 * the next reading tries again.
 */
export interface InOneGo {
    inOneGo: string;
    always: boolean;
}

/** Of the sample: see `InOneGo`. */
const always = (inOneGo: string): InOneGo => ({ inOneGo, always: true });

/** Of this reading only: see `InOneGo`. */
const forNow = (inOneGo: string): InOneGo => ({ inOneGo, always: false });

/** What the engine's rules (`splitParts`, `splitDecide`) say of the sample itself. */
const ofTheSample = new Set([
    "no split",
    "no line feed between values in the first MiB",
    "a part too long to read beside others",
    "trees far larger than their text",
]);

/** The engine's reason `why` for reading in one go, as an `InOneGo`. */
const rule = (why: string): InOneGo => (ofTheSample.has(why) ? always(why) : forNow(why));

/** How a sample was read in parts. */
export interface ReadInParts {
    read: true;
    /** The workers that read, the parts, and those of them read here to measure their trees. */
    workers: number;
    parts: number;
    probed: number;
}

const defaultMinLength = 8 << 20;

/**
 * Reads `source`, the one sample of `input` (a fresh JSON input of
 * `jsonInputForTargetLanguage`), in parts on `workers` and this engine
 * instance (see the top): `{ read: true }` once `input` holds it, as
 * `input.addSource({ name, samples: [sample], description, jsonLines })`
 * would, or `{ inOneGo: reason, always }` (see `InOneGo`), and `input` is as
 * it was. It never rejects: whatever goes wrong (a worker that fails, an
 * input that throws) is a reason to read in one go. Every worker is `done`
 * when it resolves.
 */
export async function readJSONInputInParts(
    input: any,
    source: PartsSource,
    workers: PartWorker[],
    options: PartsOptions = {},
): Promise<ReadInParts | InOneGo> {
    try {
        return await readInParts(input, source, workers, options);
    } catch (e) {
        return forNow(`reading in parts failed: ${String((e as any)?.message ?? e)}`);
    } finally {
        for (const worker of workers) {
            try {
                worker.done();
            } catch {
                // A worker that cannot be told has nothing more to do here.
            }
        }
    }
}

async function readInParts(
    input: any,
    source: PartsSource,
    workers: PartWorker[],
    options: PartsOptions,
): Promise<ReadInParts | InOneGo> {
    const { lines, size } = source;
    const reading = freshReading(input);
    if (reading === undefined) return forNow("not an input the engine reads in parts");
    const engine = await engineAsync();
    if (engine === undefined) return forNow("no engine");
    // This instance's calls: should one trap, the instance is discarded (as
    // for any call of the facade), and the sample read in one go.
    const glue = onEngine(engine);
    let id: number | undefined;
    try {
        const plan = glue.splitPlan(size, workers.length, options.minLength ?? defaultMinLength, options.range ?? 0);
        if (plan === undefined) return forNow("too small for parts");
        let first = 0;
        if (!lines) {
            const head = await source.read(0, Math.min(size, 1 << 16));
            first = glue.splitArrayStart(head);
            if (first < 0) return always("not an array");
        }

        // Each worker's ranges: blocks of consecutive ranges, as even as can
        // be. Each is given its own share (copies, not views: a view would
        // post the whole buffer to every worker).
        const { starts, threads } = plan;
        const ranges = starts.length - 1;
        const used = workers.slice(0, threads);
        const block = (w: number): [number, number] => [Math.floor((w * ranges) / threads), Math.floor(((w + 1) * ranges) / threads)];
        const summaries = await Promise.all(used.map((worker, w) => worker.summarize({ starts: starts.slice(block(w)[0], block(w)[1] + 1) })));
        const all = new Float64Array(15 * ranges);
        summaries.forEach((s, w) => all.set(s, 15 * block(w)[0]));
        const states = glue.splitResolve(all, lines);
        if (states === undefined) return forNow("the summaries did not resolve");
        const found = await Promise.all(used.map((worker, w) => worker.split({ states: states.slice(4 * block(w)[0], 4 * block(w)[1]), lines })));
        const splits = new Float64Array(ranges);
        found.forEach((s, w) => splits.set(s, block(w)[0]));
        const formed = glue.splitParts(plan.plan, first, splits, lines);
        if (formed.parts === undefined) return rule(formed.inOneGo ?? "no parts");
        const parts = formed.parts;
        const count = parts.length / 3;
        const isLast = (i: number): boolean => parts[3 * i + 1] < 0;
        const end = (i: number): number => (isLast(i) ? size : parts[3 * i + 1]);

        // The first parts, here, measured, until they hold `probe` bytes.
        id = glue.partsCreate(reading.dateTime, reading.handleRefs, reading.min, reading.max);
        if (id === undefined) return forNow("as many tallies as the engine takes");
        let probed = 0;
        const probe = { text: 0, trees: 0, smallest: 0 };
        while (probed < count && probe.text < plan.probe) {
            const from = parts[3 * probed];
            const bytes = await source.read(from, end(probed));
            const tree = glue.partsReadMeasured(id, bytes, lines, parts[3 * probed + 2] === 1, isLast(probed));
            if (tree < 0) {
                const why = notRead(tree);
                return { inOneGo: why.notRead, always: why.always };
            }
            probe.text += end(probed) - from;
            probe.trees += tree;
            probe.smallest = probe.smallest === 0 ? tree : Math.min(probe.smallest, tree);
            probed++;
        }

        const why = glue.splitDecide(plan.plan, parts, probed, probe.text, probe.trees, probe.smallest);
        if (why !== undefined) return rule(why);

        // The others, each by the worker whose ranges it starts in.
        const jobs = used.map((_, w) => {
            const [k0, k1] = block(w);
            const mine: number[] = [];
            for (let i = probed; i < count; i++) {
                const from = parts[3 * i];
                if (from >= starts[k0] && (from < starts[k1] || (k1 === ranges && from <= size))) mine.push(...parts.subarray(3 * i, 3 * i + 3));
            }

            return mine;
        });
        const assigned = jobs.reduce((n, job) => n + job.length / 3, 0);
        if (assigned !== count - probed) return forNow("a part no worker reads");
        const tallied = await Promise.all(
            used.map((worker, w) =>
                jobs[w].length === 0
                    ? undefined
                    : worker.tally({ parts: new Float64Array(jobs[w]), lines, size, reading, limit: plan.budget }),
            ),
        );
        for (const result of tallied) {
            if (result === undefined) continue;
            if ("notRead" in result) return { inOneGo: result.notRead, always: result.always };
            if (!glue.partsAppend(id, result.bytes)) return forNow("a worker's tallies could not be appended");
        }

        const rootIndex = glue.partsRootIndex(id);
        if (rootIndex === undefined || !glue.partsFinish(id)) return forNow("no tallies");
        if (!addTalliedSample(input, source.name, source.description, lines, engine, id, rootIndex, source.reread)) {
            return forNow("the input changed, or its root does not fit");
        }

        id = undefined;
        return { read: true, workers: used.length, parts: count, probed };
    } catch (e) {
        // A worker that failed, a sample that changed, or this instance.
        return forNow(`${isDiscarded(engine) ? "the engine" : "a worker"} failed: ${String((e as any)?.message ?? e)}`);
    } finally {
        if (id !== undefined && !isDiscarded(engine)) {
            try {
                engine.partsDrop(id);
            } catch (e) {
                engineFailed(engine, e);
            }
        }
    }
}

/**
 * `glue`, whose calls discard it if they throw (it trapped: its memory can
 * no longer be trusted), and then throw what it threw.
 */
function onEngine(glue: WasmGlue): WasmGlue {
    return new Proxy(glue, {
        get(target, name) {
            const value = (target as any)[name];
            if (typeof value !== "function") return value;
            return (...args: unknown[]) => {
                try {
                    return value.apply(target, args);
                } catch (e) {
                    engineFailed(target, e);
                    throw e;
                }
            };
        },
    });
}
