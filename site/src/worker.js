// The page's Web Worker: runs quicktype-core off the main thread. One copy
// runs on the WebAssembly engine (`worker.js?engine=wasm`, quickertype on
// the page), another on the TypeScript engine (`?engine=ts`, quicktype);
// each starts when the page first needs it.
//
// Request:  { id, kind: "json" | "schema", lang, name, text | file, rendererOptions,
//             options, warmup?, repeat? }
// Replies:  { type: "ready", engine, compileMs, loadError, readyMs }
//           { type: "result", id, ok, files | error, ms, times, inputTimes, ran, reason, first,
//             workerFailure (a failure that is not quicktype's) }
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
// The input is `text`, or a `file` (a File, which the page posts without
// reading it, so that a large file never passes through the page's main
// thread): read here once, before the timed runs, and kept for the next
// request on the same file (its name, size and modification time). A
// request that does not carry that file (typed text, a sample, another
// file) lets it go: its text can be most of a gigabyte.

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

/** One quicktype run, as quicktype's CLI would do it for a file of `kind`. */
async function generate({ kind, lang, name, text, rendererOptions, options = {} }, phases) {
    const start = performance.now();
    const inputData = new InputData();
    if (kind === "schema") {
        const input = new JSONSchemaInput(new FetchingJSONSchemaStore());
        await input.addSource({ name, schema: text });
        inputData.addInput(input);
    } else {
        // As the CLI's makeInputData: `$ref`s are references with
        // --no-ignore-json-refs, and the renderer options set the range of
        // integers (Rust's `integer-type`, cJSON's `integer-size`).
        const input = jsonInputForTargetLanguage(lang, undefined, options.ignoreJsonRefs === false, rendererOptions);
        await input.addSource({ name, samples: [text] });
        inputData.addInput(input);
    }

    phases.input = performance.now() - start;
    return quicktypeMultiFile({ ...options, inputData, lang, rendererOptions });
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

/** The file read last, while requests carry it: { key, text }. */
let lastFile;

/** The input's text: `text`, or the file's, read once per file. Throws { title, message, link? } if it cannot be read. */
async function inputText({ text, file }) {
    const key = file === undefined ? undefined : JSON.stringify([file.name, file.size, file.lastModified, file.type]);
    // Another input than the file kept: let its text go (before reading the next file, if there is one).
    if (lastFile !== undefined && lastFile.key !== key) lastFile = undefined;
    if (file === undefined) return text;
    if (lastFile !== undefined) return lastFile.text;
    const large = tooLarge(file.name, file.size);
    if (large !== undefined) throw large;
    let read;
    try {
        read = await file.text();
    } catch (e) {
        throw unreadable(file.name, e);
    }

    // Browsers have been seen to read what they cannot hold as "".
    if (read === "" && file.size > 0) throw unreadable(file.name, new Error("the browser returned no text"));
    lastFile = { key, text: read };
    return read;
}

async function handle(request) {
    const first = runs === 0;
    let text;
    try {
        text = await inputText(request);
    } catch (error) {
        // The input's error, not the engine's: no engine ran.
        return { type: "result", id: request.id, ok: false, error, times: [], inputTimes: [], first, ran: undefined };
    }

    return timedRuns(request, text, first);
}

/** `warmup` untimed runs, then `repeat` timed ones, on `text`; the reply has the last run's result. */
async function timedRuns(request, text, first) {
    const warmup = request.warmup ?? 0;
    const repeat = Math.max(1, request.repeat ?? 1);
    const times = [];
    const inputTimes = [];
    let reply;
    for (let i = 0; i < warmup + repeat; i++) {
        const before = snapshot();
        const phases = {};
        const start = performance.now();
        try {
            const result = await generate({ ...request, text }, phases);
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

    return { type: "result", id: request.id, ms: times[times.length - 1], times, inputTimes, first, ...reply };
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
