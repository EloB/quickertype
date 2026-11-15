// The part of reading a sample in parts that runs where its bytes are: on
// an engine instance of its own (a Web Worker's, in a browser), the jobs a
// `PartWorker` does (see parallel.ts, which hands them out). Imports
// nothing of the facade, so that a worker's bundle needs only this and the
// glue.

import type { WasmGlue } from "./wasm/glue.js";

/** How the samples of an input are read (`partsCreate`'s arguments, samples.ts's `freshReading`). */
export interface Reading {
    dateTime: string;
    handleRefs: boolean;
    min: string | undefined;
    max: string | undefined;
}

/**
 * Summarize the ranges that start at `starts` (each but the last, which is
 * where the last range ends): a block of consecutive ranges of
 * `splitPlan`'s.
 */
export interface SummarizeJob {
    starts: Float64Array;
}

/** Find the first split of each range summarized, which start in `states` (4 numbers a range). */
export interface SplitJob {
    states: Float64Array;
    lines: boolean;
}

/** Read `parts` (3 numbers a part: from, to or -1, whether it is the first) of a sample of `size` bytes, read with `reading`. */
export interface TallyJob {
    parts: Float64Array;
    lines: boolean;
    size: number;
    reading: Reading;
    /** The most bytes the tallies may take. */
    limit: number;
}

/**
 * The tallies of the parts, as bytes for `partsAppend`; or why they were
 * not read, and whether that is so of the file whatever reads it
 * (`always`: it is not JSON there, say) or only of this reading.
 */
export type TallyResult = { bytes: Uint8Array } | { notRead: string; always: boolean };

/**
 * What reads parts of a sample on an engine instance of its own: a
 * `PartReader`, or a Web Worker that runs one. The jobs come in this order:
 * `summarize`, `split`, then `tally` or not; then `done`, whatever happened.
 */
export interface PartWorker {
    summarize(job: SummarizeJob): Promise<Float64Array>;
    split(job: SplitJob): Promise<Float64Array>;
    tally(job: TallyJob): Promise<TallyResult>;
    /** The reading is over: lets go of the bytes kept for it. */
    done(): void;
}

/**
 * Why `partsRead` (and `partsReadMeasured`) did not read a part, by its
 * code, and whether that is so of the file (its bytes there), or only of
 * this reading.
 */
export function notRead(code: number): { notRead: string; always: boolean } {
    switch (code) {
        case -1:
            return { notRead: "a part is not UTF-8", always: true };
        case -2:
            return { notRead: "a part is not a part of the array (empty, or a ] or a byte order mark first)", always: true };
        case -3:
            return { notRead: "a part did not read", always: true };
        case -4:
            return { notRead: "a part's tallies could not be appended", always: false };
        default:
            return { notRead: "no such tallies", always: false };
    }
}

/** The bytes a range may need before it: whether its first byte is escaped. */
const before = 64;

/**
 * The jobs of a `PartWorker`, on `glue` (an engine instance of its own),
 * on the bytes `read` gives (`read(from, to)`: the sample's bytes from
 * `from` to `to`). It keeps the bytes of the ranges it summarized until
 * `done`.
 */
export class PartReader implements PartWorker {
    /** The ranges summarized (where each starts, then where the last ends), `bytes` from `at` on (up to 64 bytes before the first one's start). */
    private region: { starts: Float64Array; at: number; bytes: Uint8Array } | undefined;

    public constructor(
        private readonly glue: WasmGlue,
        private readonly read: (from: number, to: number) => Promise<Uint8Array>,
    ) {}

    /** Range `k`'s bytes, and the bytes before it. */
    private range(k: number): [Uint8Array, Uint8Array, boolean] {
        const region = this.region as NonNullable<PartReader["region"]>;
        const { starts, at, bytes } = region;
        const from = starts[k] - at;
        const start = Math.max(0, starts[k] - before);
        return [bytes.subarray(start - at, from), bytes.subarray(from, starts[k + 1] - at), start === 0];
    }

    public async summarize({ starts }: SummarizeJob): Promise<Float64Array> {
        const ranges = starts.length - 1;
        const at = Math.max(0, starts[0] - before);
        const to = starts[ranges];
        const bytes = await this.read(at, to);
        if (bytes.length !== to - at) throw new Error("the sample changed while it was read");
        this.region = { starts, at, bytes };
        const summaries = new Float64Array(15 * ranges);
        for (let k = 0; k < ranges; k++) {
            const [ahead, range, atStart] = this.range(k);
            summaries.set(this.glue.splitSummarize(ahead, atStart, range), 15 * k);
        }

        return summaries;
    }

    public async split({ states, lines }: SplitJob): Promise<Float64Array> {
        const { starts } = this.region as NonNullable<PartReader["region"]>;
        const splits = new Float64Array(starts.length - 1);
        for (let k = 0; k < splits.length; k++) {
            const i = 4 * k;
            if (states[i + 3] !== 1) {
                splits[k] = -1;
                continue;
            }

            const [, range] = this.range(k);
            const found = this.glue.splitFind(range, states[i] === 1, states[i + 1] === 1, states[i + 2], lines);
            splits[k] = found < 0 ? -1 : starts[k] + found;
        }

        return splits;
    }

    public async tally({ parts, lines, size, reading, limit }: TallyJob): Promise<TallyResult> {
        const { glue } = this;
        const { starts } = this.region as NonNullable<PartReader["region"]>;
        const end = starts[starts.length - 1];
        const id = glue.partsCreate(reading.dateTime, reading.handleRefs, reading.min, reading.max);
        if (id === undefined) return { notRead: "as many tallies as the engine takes", always: false };
        let exported = false;
        try {
            for (let i = 0; i < parts.length; i += 3) {
                const from = parts[i];
                const to = parts[i + 1] < 0 ? size : parts[i + 1];
                const bytes = await this.partBytes(from, to, end);
                const read = glue.partsRead(id, bytes, lines, parts[i + 2] === 1, parts[i + 1] < 0);
                if (read !== 1) return notRead(read);
                if ((glue.partsBytes(id) ?? 0) > limit) return { notRead: "the parts' tallies would take too much memory", always: true };
            }

            const bytes = glue.partsExport(id);
            exported = true;
            return bytes === undefined ? { notRead: "no part was read", always: false } : { bytes };
        } finally {
            if (!exported) glue.partsDrop(id);
        }
    }

    /** The bytes from `from` to `to`, those up to `end` from the ranges kept. */
    private async partBytes(from: number, to: number, end: number): Promise<Uint8Array> {
        const { at, bytes } = this.region as NonNullable<PartReader["region"]>;
        if (to <= end) return bytes.subarray(from - at, to - at);
        const rest = await this.read(end, to);
        if (rest.length !== to - end) throw new Error("the sample changed while it was read");
        const part = new Uint8Array(to - from);
        part.set(bytes.subarray(from - at, end - at));
        part.set(rest, end - from);
        return part;
    }

    public done(): void {
        this.region = undefined;
    }
}

