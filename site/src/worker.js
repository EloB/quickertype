// The page's Web Worker: runs quicktype-core off the main thread. One copy
// runs on the WebAssembly engine (`worker.js?engine=wasm`, quickertype on
// the page), another on the TypeScript engine (`?engine=ts`, quicktype);
// each starts when the page first needs it.
//
// Request:  { id, kind: "json" | "jsonl" | "schema", lang, name, text | file, rendererOptions,
//             options, warmup?, repeat?, heldLimit?, partsFrom?, partWorkers?, textLimit?,
//             linesInOneGo?, partModule?, typescript? }
// Replies:  { type: "ready", engine, compileMs, loadError, readyMs }
//           { type: "result", id, ok, files | error, ms, times, inputTimes, reused, evicted,
//             parts, ran, reason, first, workerFailure (a failure that is not quicktype's) }
//
// `{ kind: "stats" }` replies `{ stats }`: the engines' memory, for
// measurements; the engine runs are on, and the bytes a file read in parts
// keeps, for the smoke test.
//
// `heldLimit` (for the smoke test) sets quickertype-core's limit on the
// bytes its engine's inputs hold together, past which it copies the
// tables of the least recently used out (`evicted`: how many it did during
// the request). `partsFrom`, `partWorkers`, `textLimit` and `linesInOneGo`
// (for the smoke test too) set the smallest file read in parts, the part
// workers, the largest text and the largest JSON Lines read in one go (see
// below), from that request on; `partModule` (null for none) gives new part
// workers that module instead of the engine (the smoke test's, which they
// cannot start with); `typescript` runs that one request on the TypeScript
// engine.
//
// `options` are `quicktype()` options from the page's general options
// (`allPropertiesOptional`, the inference flags, …), as quicktype's CLI sets
// them for its flags.
//
// `times` are whole runs; `inputTimes` the part spent reading the input
// (`addSource`: parsing the JSON or the schema). The WebAssembly engine
// reads JSON samples itself as they are added; a JSON Schema is parsed by
// quicktype's TypeScript code on both engines. The rest is generating the
// code.
//
// A JSON input, once read, is kept for the next run on the same input read
// the same way (`reused` in the reply, and no time spent reading it): the
// same text or file, top-level name, and everything that decides how its
// samples are read (the target language's date/time recognizer and integer
// range, and whether `$ref`s are references). Changing the language,
// renderer or inference options then only generates the code again, as a
// program that runs quicktype on an input it has read already does. Both
// engines' workers do this, so the times stay comparable. A measurement
// (`repeat`, `warmup`) lets go of the input kept, and reads the input for
// every run, letting go of each when its run ends.
//
// The input is `text`, or a `file` (a File, which the page posts without
// reading it, so that a large file never passes through the page's main
// thread): read here once, before the timed runs, and kept for the next
// request on the same file (its name, size and modification time). A
// request that does not carry that file (typed text, a sample, another
// file) lets it go: its text can be most of a gigabyte. The TypeScript
// worker reads a file as text, as quicktype's API takes it; the
// WebAssembly worker reads its bytes, which quickertype-core takes as
// UTF-8 (`addSource` decodes them as `TextDecoder` does, as `file.text()`
// would), and its engine reads them without a JavaScript string in
// between.
//
// JSON Lines (`kind: "jsonl"`, a `.jsonl` or `.ndjson` file, or the
// input kind picked) are quickertype's, not quicktype's: the WebAssembly
// worker reads them as quickertype-core does, `addSource({ jsonLines:
// true })`, the array of their values; the TypeScript worker, which is
// quicktype, gets that array as JSON (json-lines.js), so that the outputs
// compare. A file's array is made in the buffer its bytes are read into,
// and decoded once: the worker holds the bytes and the text, never a copy
// of either. Making the array is part of reading the input, not of the
// timed runs.
//
// A large JSON or JSON Lines file (`partsFrom` bytes or more) is read in
// parts on the WebAssembly worker: on several part workers at once
// (part-pool.js, part-worker.js; quickertype-core's src/native/parallel.ts),
// each with an engine instance of its own, which read the file's ranges
// themselves and hand back their tallies, which this worker's engine
// appends in order, for every run on the input. That gives what reading
// the file in one go gives (the engine's argument), and where the parts do
// not read, or the engine would read the file in one go anyway (not an
// array, no split, a part that is not JSON: see parallel.ts), it is read in
// one go, as before, with its errors; that is remembered for the file
// (`parts` in the reply: { workers, parts } or { inOneGo: why }). The input
// keeps no compressed form, only the tallies; should a run go to the
// TypeScript engine, quickertype-core reads the file again
// (`FileReaderSync`) for the tables it needs, as far as one string holds
// the file; past that, the run fails, saying why, and the input is let go.
// So a file of up to `maxFileBytes` can be read, past the longest string a
// browser holds (`maxTextBytes`); read in one go, JSON only that large, and
// JSON Lines (their errors are read value by value) only as large as the
// engine holds with its compressed form (`linesInOneGo`): past those, it is
// too large to read in one go. Why a file is read in one go is remembered
// for it only where it is the file's own (no split, not JSON there; see
// parallel.ts's `InOneGo`): after a worker that failed, say, the next run
// tries parts again (`parts.cached` in the reply says which).

import { jsonLinesToArray, jsonLinesToArrayInPlace, readForArray } from "./json-lines.js";
import {
    checkText,
    decodedTooLong,
    formatBytes,
    linesInOneGo,
    maxFileBytes,
    maxTextBytes,
    partsFrom,
    textTooLarge,
    tooLarge,
    tooLargeInOneGo,
    unreadable,
} from "./input-file.js";
import { PartPool, maxPartWorkers } from "./part-pool.js";
import { boot } from "./worker-boot.js";

import {
    FetchingJSONSchemaStore,
    InputData,
    JSONSchemaInput,
    jsonInputForTargetLanguage,
    quicktypeMultiFile,
} from "../../npm/quicktype-core/dist/esm/index.js";
import { engineStats } from "../../npm/quicktype-core/dist/esm/native/bridge.js";
import { engineMemoryBytes } from "../../npm/quicktype-core/dist/esm/native/engine.js";
// Not quickertype-core's public API, but its internals the playground
// uses: should they move, the site's build fails (esbuild: no such file or
// export), and the smoke test's checks of eviction would too.
import { readingKey, releaseJSONInput, setHeldLimit, tablesFailed } from "../../npm/quicktype-core/dist/esm/native/samples.js";
import { readJSONInputInParts } from "../../npm/quicktype-core/dist/esm/native/parallel.js";

/** The part workers, started on the first file read in parts. */
const pool = new PartPool();

/** The test hooks' settings (see the top). */
const hooks = { partsFrom, partWorkers: undefined, textLimit: maxTextBytes, linesInOneGo, partModule: undefined, typescript: false };

/** How many part workers read a file: as many as the machine runs at once, at most `maxPartWorkers`; none without nested workers. */
function partWorkers() {
    if (boot.engine !== "wasm" || boot.loadError !== undefined || typeof Worker !== "function" || typeof FileReaderSync !== "function") return 0;
    return hooks.partWorkers ?? Math.min(navigator.hardwareConcurrency ?? 1, maxPartWorkers);
}

/**
 * A file read in parts, kept while requests carry it: its bytes, while it is
 * read in one go; why it is (once that is for good); and how often reading
 * it in parts failed for a reason of the reading's own.
 */
class PartsFile {
    constructor(file) {
        this.file = file;
        this.bytes = undefined;
        this.inOneGo = undefined;
        this.failures = 0;
    }
}

/**
 * Reads `sample`'s file into `input`, in parts if it can be (see the top),
 * else in one go: how (`phases.parts`). Throws what `addSource` throws.
 */
async function addPartsFile(input, sample, name, lines, phases) {
    const { file } = sample;
    if (sample.inOneGo === undefined) {
        const read = await readInParts(input, file, name, lines);
        if (read.read === true) {
            // Read in parts: the bytes read in one go before, if any, go.
            sample.bytes = undefined;
            phases.parts = { workers: read.workers, parts: read.parts };
            return;
        }

        // Remembered for the file if it is the file's own (no split, not
        // JSON there, ...). A reason of this reading (part workers that
        // failed, say) is tried again once more, then the file is read in
        // one go for as long as it is kept here.
        if (read.always || ++sample.failures >= 2) sample.inOneGo = read.inOneGo;
        phases.parts = { inOneGo: read.inOneGo, cached: false };
    } else {
        phases.parts = { inOneGo: sample.inOneGo, cached: true };
    }

    // In one go, as any file, as far as the engine holds JSON Lines, and
    // one string JSON's text (for its errors).
    const tooLarge = () => tooLargeInOneGo(file.name, file.size, phases.parts.inOneGo);
    if (lines && file.size > hooks.linesInOneGo) throw tooLarge();
    if (!lines) checkText(undefined, file.size, hooks.textLimit, tooLarge);
    if (sample.bytes === undefined) {
        let bytes;
        try {
            bytes = new Uint8Array(await file.arrayBuffer());
        } catch (e) {
            throw e instanceof RangeError ? tooLarge() : unreadable(file.name, e);
        }

        if (bytes.length !== file.size) throw unreadable(file.name, new Error("the browser returned no bytes"));
        if (!lines) checkText(bytes, file.size, hooks.textLimit, tooLarge);
        sample.bytes = bytes;
    }

    await input.addSource(lines ? { name, samples: [sample.bytes], jsonLines: true } : { name, samples: [sample.bytes] });
}

/**
 * `file` read into `input` in parts, on the part workers: `{ read: true, … }`,
 * or why it is to be read in one go (`{ inOneGo, always }`). Never throws:
 * whatever goes wrong (part workers that do not start, an input that
 * cannot) is a reason to read in one go. The part workers are left idle
 * however it ends (they stop after a minute without a large file).
 */
async function readInParts(input, file, name, lines) {
    try {
        const count = partWorkers();
        if (count < 2) return { inOneGo: "no part workers", always: false };
        const readers = await pool.readers(file, hooks.partModule ?? globalThis[Symbol.for("quicktype-core.wasmModule")], count);
        return await readJSONInputInParts(
            input,
            {
                name,
                lines,
                size: file.size,
                read: async (from, to) => new Uint8Array(await file.slice(from, to).arrayBuffer()),
                // The tables, should a run go to the TypeScript engine: read
                // again, with TypeScript, as far as a string holds the file
                // (JSON Lines too: their tables would take more than the
                // text).
                reread: () => {
                    const tooLong = () => new RangeError(`${file.name} is too large to read again with TypeScript (${formatBytes(file.size)})`);
                    checkText(undefined, file.size, hooks.textLimit, tooLong);
                    let bytes;
                    try {
                        bytes = new Uint8Array(new FileReaderSync().readAsArrayBuffer(file));
                    } catch (e) {
                        throw e instanceof RangeError ? tooLong() : e;
                    }

                    checkText(bytes, file.size, hooks.textLimit, tooLong);
                    return bytes;
                },
            },
            readers,
            { minLength: hooks.partsFrom },
        );
    } catch (e) {
        return { inOneGo: String(e?.message ?? e), always: false };
    } finally {
        pool.idle();
    }
}

/**
 * The JSON input read last, kept for the next run that reads the same
 * sample the same way: { sample, key, input }. Only `settleLastRead`
 * decides what becomes of it.
 */
let lastRead;

/**
 * Decides what becomes of the input read last before a run, or before
 * another file is read (`sample` undefined): a run that may reuse it
 * (`reuse`) on the same sample read the same way (`key`, which is
 * undefined for an input that cannot be reused) gets it; otherwise it is
 * let go, and its samples in the engine are freed right away, not when
 * the garbage collector gets to it. A form kept meanwhile would count
 * toward the engine's limit on what inputs hold together, and reading the
 * next input past that limit copies the tables of the others out: a
 * quarter of a second for a 450 MB file, and as much memory again.
 */
function settleLastRead(sample, key, reuse) {
    if (lastRead === undefined) return undefined;
    if (reuse && key !== undefined && lastRead.key === key && lastRead.sample === sample) return lastRead.input;
    releaseJSONInput(lastRead.input);
    lastRead = undefined;
    return undefined;
}

/**
 * One quicktype run, as quicktype's CLI would do it for a file of `kind`;
 * with `reuse`, on the JSON input read last if it reads the same sample
 * the same way, and keeping the input it reads for the next run.
 */
async function generate({ kind, lang, name, sample, rendererOptions, options = {} }, phases, reuse) {
    const start = performance.now();
    const inputData = new InputData();
    let release;
    if (kind === "schema") {
        settleLastRead(undefined, undefined, false);
        const input = new JSONSchemaInput(new FetchingJSONSchemaStore());
        await input.addSource({ name, schema: sample });
        inputData.addInput(input);
    } else {
        // As the CLI's makeInputData: `$ref`s are references with
        // --no-ignore-json-refs, and the renderer options set the range of
        // integers (Rust's `integer-type`, cJSON's `integer-size`). How it
        // reads samples is the key, with the top-level name and whether
        // the sample is JSON Lines: the configuration quickertype-core
        // reads them with, from the input.
        const lines = kind === "jsonl" && boot.engine === "wasm";
        const input = jsonInputForTargetLanguage(lang, undefined, options.ignoreJsonRefs === false, rendererOptions);
        const reading = readingKey(input);
        const key = reading === undefined ? undefined : JSON.stringify([name, lines, reading]);
        const kept = settleLastRead(sample, key, reuse);
        if (kept !== undefined) {
            inputData.addInput(kept);
            phases.reused = true;
        } else {
            try {
                if (sample instanceof PartsFile) await addPartsFile(input, sample, name, lines, phases);
                else await input.addSource(lines ? { name, samples: [sample], jsonLines: true } : { name, samples: [sample] });
            } catch (e) {
                // A failed read keeps nothing.
                releaseJSONInput(input);
                throw e;
            }

            inputData.addInput(input);
            // An input not kept for the next run is let go when this one ends.
            if (reuse && key !== undefined) lastRead = { sample, key, input };
            else release = input;
        }
    }

    phases.input = phases.reused ? 0 : performance.now() - start;
    // (A test hook: this run on the TypeScript engine, which reads the
    // input's tables.)
    const engineKey = Symbol.for("quicktype-core.engine");
    // (What it was, which the TypeScript worker's start set for good.)
    const engineWas = Object.prototype.hasOwnProperty.call(globalThis, engineKey) ? { value: globalThis[engineKey] } : undefined;
    if (hooks.typescript) globalThis[engineKey] = "ts";
    try {
        return await quicktypeMultiFile({ ...options, inputData, lang, rendererOptions });
    } catch (e) {
        // An input read in parts whose tables were asked for and could not
        // be had (the file could not be read again) is not kept: the next
        // run reads the file again.
        if (lastRead !== undefined && tablesFailed(lastRead.input)) settleLastRead(undefined, undefined, false);
        throw e;
    } finally {
        if (hooks.typescript) {
            if (engineWas === undefined) delete globalThis[engineKey];
            else globalThis[engineKey] = engineWas.value;
        }
        if (release !== undefined) releaseJSONInput(release);
    }
}

function snapshot() {
    return { ...engineStats, unsupportedBy: { ...engineStats.unsupportedBy } };
}

/** Which engine did the run between `before` and now, and why not WebAssembly if it did not. */
function whoRan(before) {
    if (engineStats.wasm > before.wasm) return { ran: "wasm" };
    if (engineStats.ts === before.ts) {
        // It failed before the generation step (e.g. reading the input:
        // a sample that is not JSON fails in addSource on both engines).
        return { ran: undefined };
    }

    if (boot.engine === "ts") return { ran: "ts", reason: "forced" };
    if (engineStats.rerun > before.rerun) {
        return { ran: "ts", reason: `the engine failed and the run was redone (${engineStats.lastFailure})` };
    }

    const features = Object.keys(engineStats.unsupportedBy).filter(
        (f) => engineStats.unsupportedBy[f] !== before.unsupportedBy[f],
    );
    if (features.length > 0) return { ran: "ts", reason: `not supported by the engine yet: ${features.join(", ")}` };
    if (boot.loadError !== undefined) return { ran: "ts", reason: `the engine did not load: ${boot.loadError}` };
    return { ran: "ts", reason: "this run is not one the engine models" };
}

function serialize(result) {
    return [...result].map(([name, { lines, annotations }]) => ({
        name,
        text: lines.join("\n"),
        annotations: annotations.map((a) => ({ line: a.span.start.line, message: a.annotation.message })),
    }));
}

let runs = 0;

/** The file read last, while requests carry it: { key, sample }. */
let lastFile;

/**
 * The input's sample: `text`, or the file's, read once per file (its bytes
 * on the WebAssembly worker for a JSON or JSON Lines file, else its text);
 * for JSON Lines on the TypeScript worker, the JSON array of their values
 * (see the top). Throws { title, message, link? } if it cannot be read.
 */
async function inputSample({ kind, text, file }) {
    // What the sample is made of: the file's bytes, its text, or (JSON
    // Lines for quicktype) the array made from its bytes; or, for a large
    // file on the WebAssembly worker, the file, read in parts.
    const bytes = boot.engine === "wasm" && kind !== "schema";
    const parts = bytes && file !== undefined && file.size >= hooks.partsFrom && partWorkers() >= 2;
    const form = parts ? "parts" : bytes ? "bytes" : kind === "jsonl" ? "array" : "text";
    const key = file === undefined ? undefined : JSON.stringify([file.name, file.size, file.lastModified, file.type, form]);
    // Another input than the file kept: let it go (before reading the next file, if there is one).
    if (lastFile !== undefined && lastFile.key !== key) lastFile = undefined;
    if (file === undefined) return form === "array" ? jsonLinesToArray(text) : text;
    if (lastFile !== undefined) return lastFile.sample;
    if (parts) {
        const large = tooLarge(file.name, file.size, file.size, maxFileBytes);
        if (large !== undefined) throw large;
        // Another file: the input read from the one before goes first.
        settleLastRead(undefined, undefined, false);
        lastFile = { key, sample: new PartsFile(file) };
        return lastFile.sample;
    }

    // What is read must fit: a text one string (quicktype's text, the JSON
    // array of JSON Lines for quicktype, JSON's bytes for their errors),
    // JSON Lines' bytes what the engine holds in one go (they are read value
    // by value). Past the longest text in bytes, the text may still fit
    // (UTF-8 takes up to three bytes a unit): JSON's bytes are counted once
    // read, and a text checked once decoded. A file read at once larger
    // than a buffer can be is too large too.
    const linesBytes = form === "bytes" && kind === "jsonl";
    // (A file of JSON Lines this large is read in parts where there are part workers.)
    const tooLargeHere = () => (linesBytes ? tooLargeInOneGo(file.name, file.size, "no part workers") : textTooLarge(file.name, file.size));
    if (linesBytes && file.size > hooks.linesInOneGo) throw tooLargeHere();
    if (!linesBytes) checkText(undefined, file.size, hooks.textLimit, tooLargeHere);
    // Another file: the input read from the one before goes before this
    // one is read, so that the two are never held at once.
    settleLastRead(undefined, undefined, false);
    let read;
    try {
        if (form === "text") read = await file.text();
        else if (form === "bytes") read = new Uint8Array(await file.arrayBuffer());
        else read = await readForArray(file);
    } catch (e) {
        throw e instanceof RangeError ? tooLargeHere() : unreadable(file.name, e);
    }

    if (form === "bytes") {
        if (read.length !== file.size) throw unreadable(file.name, new Error("the browser returned no bytes"));
        if (!linesBytes) checkText(read, file.size, hooks.textLimit, tooLargeHere);
    } else if (form === "text") {
        // A text too long for one string reads as "" (Chrome): never quicktype's input.
        if (decodedTooLong(read, file.size) || read.length > hooks.textLimit) throw tooLargeHere();
    } else {
        // The array, in the bytes' buffer; then its text, which is what
        // quicktype's API takes. The text is decoded from the array, at most
        // two bytes longer than the file, if it fits one string.
        const length = jsonLinesToArrayInPlace(read);
        const array = read.subarray(0, length);
        const tooLong = () => textTooLarge(file.name, file.size, length);
        checkText(undefined, length, hooks.textLimit, tooLong);
        read = undefined;
        try {
            read = new TextDecoder().decode(array);
        } catch (e) {
            throw e instanceof RangeError ? tooLong() : e;
        }

        if (decodedTooLong(read, length) || read.length > hooks.textLimit) throw tooLong();
    }

    lastFile = { key, sample: read };
    return read;
}

async function handle(request) {
    if (request.kind === "stats") {
        // For measurements: the WebAssembly memory of this worker's engine
        // and of each part worker's (it never shrinks: the most each held).
        const memory = engineMemoryBytes() ?? 0;
        // For the smoke test too: the engine runs are on (`ts` for the
        // TypeScript worker, for good), and the bytes the file read in parts
        // keeps (those it was read in one go with, if it was).
        const engineMode = globalThis[Symbol.for("quicktype-core.engine")] ?? null;
        const keptBytes = lastFile?.sample instanceof PartsFile ? (lastFile.sample.bytes?.length ?? 0) : null;
        return {
            type: "result",
            id: request.id,
            ok: true,
            stats: { memory, partMemory: await pool.memory(), engineStats: { ...engineStats }, engineMode, keptBytes },
        };
    }

    const first = runs === 0;
    if (request.partsFrom !== undefined) hooks.partsFrom = request.partsFrom;
    if ("partWorkers" in request) hooks.partWorkers = request.partWorkers ?? undefined;
    if (request.textLimit !== undefined) hooks.textLimit = request.textLimit;
    if (request.linesInOneGo !== undefined) hooks.linesInOneGo = request.linesInOneGo;
    if ("partModule" in request) hooks.partModule = request.partModule ?? undefined;
    hooks.typescript = request.typescript === true;
    let sample;
    try {
        sample = await inputSample(request);
    } catch (error) {
        // The input's error, not the engine's: no engine ran.
        return { type: "result", id: request.id, ok: false, error, times: [], inputTimes: [], first, ran: undefined };
    }

    return timedRuns(request, sample, first);
}

/**
 * `warmup` untimed runs, then `repeat` timed ones, on `sample`; the reply
 * has the last run's result. A single run reuses the input read last if it
 * can (`generate`); a measurement reads it every time.
 */
async function timedRuns(request, sample, first) {
    const warmup = request.warmup ?? 0;
    const repeat = Math.max(1, request.repeat ?? 1);
    const reuse = warmup === 0 && repeat === 1;
    if (request.heldLimit !== undefined) setHeldLimit(request.heldLimit);
    const evicted = engineStats.evicted;
    const times = [];
    const inputTimes = [];
    let reply;
    let reused = false;
    let parts;
    for (let i = 0; i < warmup + repeat; i++) {
        const before = snapshot();
        const phases = {};
        const start = performance.now();
        try {
            const result = await generate({ ...request, sample }, phases, reuse);
            reused = phases.reused === true;
            parts = phases.parts;
            const ms = performance.now() - start;
            if (i >= warmup) {
                times.push(ms);
                inputTimes.push(phases.input);
            }

            if (i === warmup + repeat - 1) reply = { ok: true, files: serialize(result), ...whoRan(before) };
        } catch (e) {
            const ms = performance.now() - start;
            times.push(ms);
            parts = phases.parts;
            // A file too large to read in one go is the input's error, as a too large file is.
            const error = e?.title !== undefined ? e : { message: String(e?.message ?? e), messageName: e?.messageName, name: e?.constructor?.name };
            reply = { ok: false, error, ...whoRan(before) };
            break;
        } finally {
            runs++;
        }
    }

    return {
        type: "result",
        id: request.id,
        ms: times[times.length - 1],
        times,
        inputTimes,
        reused,
        evicted: engineStats.evicted - evicted,
        parts,
        first,
        ...reply,
    };
}

/** A result for a request the worker could not handle at all: not quicktype's (the page does not keep it). */
function failure(request, e) {
    const message = `The worker could not handle this run: ${String(e?.message ?? e)}`;
    return { type: "result", id: request?.id, ok: false, error: { message }, times: [], inputTimes: [], workerFailure: true };
}

// One request at a time, in order. Whatever goes wrong with one (outside
// quicktype's own errors, which handle() reports) is that request's result,
// and the next request is still handled.
let queue = Promise.resolve();
self.onmessage = (event) => {
    const request = event.data;
    queue = queue.then(async () => {
        let reply;
        try {
            reply = await handle(request);
        } catch (e) {
            reply = failure(request, e);
        }

        try {
            self.postMessage(reply);
        } catch (e) {
            // E.g. a DataCloneError.
            self.postMessage(failure(request, e));
        }
    }).catch(() => {
        // Not even the failure could be posted; keep the queue going.
    });
};

self.postMessage({ type: "ready", ...boot, readyMs: performance.now() });
