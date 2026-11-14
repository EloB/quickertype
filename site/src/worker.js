// The page's Web Worker: runs quicktype-core off the main thread. One copy
// runs on the WebAssembly engine (`worker.js?engine=wasm`, quickertype on
// the page), another on the TypeScript engine (`?engine=ts`, quicktype);
// each starts when the page first needs it.
//
// Request:  { id, kind: "json" | "schema", lang, name, text | file, rendererOptions,
//             options, warmup?, repeat?, heldLimit? }
// Replies:  { type: "ready", engine, compileMs, loadError, readyMs }
//           { type: "result", id, ok, files | error, ms, times, inputTimes, reused, evicted,
//             ran, reason, first, workerFailure (a failure that is not quicktype's) }
//
// `heldLimit` (for the smoke test) sets quickertype-core's limit on the
// bytes its engine's inputs hold together, past which it copies the
// tables of the least recently used out (`evicted`: how many it did during
// the request).
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

import { tooLarge, unreadable } from "./input-file.js";
import { boot } from "./worker-boot.js";

import {
    FetchingJSONSchemaStore,
    InputData,
    JSONSchemaInput,
    jsonInputForTargetLanguage,
    quicktypeMultiFile,
} from "../../npm/quicktype-core/dist/esm/index.js";
import { engineStats } from "../../npm/quicktype-core/dist/esm/native/bridge.js";
// Not quickertype-core's public API, but its internals the playground
// uses: should they move, the site's build fails (esbuild: no such file or
// export), and the smoke test's checks of eviction would too.
import { readingKey, releaseJSONInput, setHeldLimit } from "../../npm/quicktype-core/dist/esm/native/samples.js";

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
        // reads samples is the key, with the top-level name: the
        // configuration quickertype-core reads them with, from the input.
        const input = jsonInputForTargetLanguage(lang, undefined, options.ignoreJsonRefs === false, rendererOptions);
        const reading = readingKey(input);
        const key = reading === undefined ? undefined : JSON.stringify([name, reading]);
        const kept = settleLastRead(sample, key, reuse);
        if (kept !== undefined) {
            inputData.addInput(kept);
            phases.reused = true;
        } else {
            try {
                await input.addSource({ name, samples: [sample] });
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
    try {
        return await quicktypeMultiFile({ ...options, inputData, lang, rendererOptions });
    } finally {
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
 * on the WebAssembly worker for a JSON file, else its text). Throws
 * { title, message, link? } if it cannot be read.
 */
async function inputSample({ kind, text, file }) {
    const bytes = boot.engine === "wasm" && kind !== "schema";
    const key = file === undefined ? undefined : JSON.stringify([file.name, file.size, file.lastModified, file.type, bytes]);
    // Another input than the file kept: let it go (before reading the next file, if there is one).
    if (lastFile !== undefined && lastFile.key !== key) lastFile = undefined;
    if (file === undefined) return text;
    if (lastFile !== undefined) return lastFile.sample;
    const large = tooLarge(file.name, file.size);
    if (large !== undefined) throw large;
    // Another file: the input read from the one before goes before this
    // one is read, so that the two are never held at once.
    settleLastRead(undefined, undefined, false);
    let read;
    try {
        read = bytes ? new Uint8Array(await file.arrayBuffer()) : await file.text();
    } catch (e) {
        throw unreadable(file.name, e);
    }

    // Browsers have been seen to read what they cannot hold as "".
    if (read.length === 0 && file.size > 0) throw unreadable(file.name, new Error(`the browser returned no ${bytes ? "bytes" : "text"}`));
    lastFile = { key, sample: read };
    return read;
}

async function handle(request) {
    const first = runs === 0;
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
    for (let i = 0; i < warmup + repeat; i++) {
        const before = snapshot();
        const phases = {};
        const start = performance.now();
        try {
            const result = await generate({ ...request, sample }, phases, reuse);
            reused = phases.reused === true;
            const ms = performance.now() - start;
            if (i >= warmup) {
                times.push(ms);
                inputTimes.push(phases.input);
            }

            if (i === warmup + repeat - 1) reply = { ok: true, files: serialize(result), ...whoRan(before) };
        } catch (e) {
            const ms = performance.now() - start;
            times.push(ms);
            reply = {
                ok: false,
                error: { message: String(e?.message ?? e), messageName: e?.messageName, name: e?.constructor?.name },
                ...whoRan(before),
            };
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
