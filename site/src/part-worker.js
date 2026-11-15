// A part worker: reads parts of a large file on an engine instance of its
// own, for the WebAssembly worker (worker.js), which reads the file on
// several of them at once (part-pool.js; quickertype-core's
// src/native/parallel.ts has the steps, and src/native/parts.ts the jobs
// this worker does). It loads only the engine's glue and those jobs, not
// quickertype-core: the WebAssembly worker hands it the compiled module.
//
// Messages: { id, job: "start", args: { module } }, then for each reading
// "summarize" (with the File), "split", "tally" (or not), "done"; and
// "memory", for measurements. Replies:
// { id, ok: true, value } (a summary's, split's or tallies' bytes
// transferred, not copied) or { id, ok: false, error, fatal } (`fatal`:
// the engine instance trapped, and this worker takes no more jobs).

import { createGlue } from "../../npm/quicktype-core/dist/esm/native/wasm/glue.js";
import { PartReader } from "../../npm/quicktype-core/dist/esm/native/parts.js";

let glue;
/** Its instance's WebAssembly memory (the module's own export). */
let memory;
/** The reading under way: its File and the jobs' state. */
let file;
let reader;

const read = async (from, to) => new Uint8Array(await file.slice(from, to).arrayBuffer());

async function handle(job, args) {
    switch (job) {
        case "start": {
            // The engine only once it has started: a module that does not
            // compile, link or instantiate, or is not this engine (no
            // engineVersion), leaves none, and the pool replaces this worker.
            const started = createGlue();
            const exports = started.initSync({ module: args.module });
            started.engineVersion();
            glue = started;
            memory = exports.memory;
            return [true, []];
        }
        case "summarize": {
            if (glue === undefined) throw new Error("the part worker's engine did not start, or stopped");
            file = args.file;
            reader = new PartReader(glue, read);
            const summaries = await reader.summarize(args);
            return [summaries, [summaries.buffer]];
        }
        case "split": {
            const splits = await reader.split(args);
            return [splits, [splits.buffer]];
        }
        case "tally": {
            const result = await reader.tally(args);
            return [result, result.bytes === undefined ? [] : [result.bytes.buffer]];
        }
        case "done":
            reader?.done();
            reader = undefined;
            file = undefined;
            return [true, []];
        case "memory":
            // The instance's memory, which never shrinks: the most it held (for measurements).
            return [glue === undefined ? 0 : memory.buffer.byteLength, []];
        default:
            throw new Error(`no job ${job}`);
    }
}

// One job at a time, in order: a reading's jobs depend on each other.
let queue = Promise.resolve();
self.onmessage = (event) => {
    const { id, job, args } = event.data;
    queue = queue.then(async () => {
        try {
            const [value, transfer] = await handle(job, args);
            self.postMessage({ id, ok: true, value }, transfer);
        } catch (e) {
            // An instance that trapped cannot be trusted: this worker is
            // done, and the pool replaces it.
            const fatal = e instanceof WebAssembly.RuntimeError;
            if (fatal) glue = undefined;
            // Its class, unless a plain Error: a CompileError, a LinkError, a TypeError.
            const error = e instanceof Error ? `${e.name === "Error" ? "" : `${e.name}: `}${e.message}` : String(e);
            self.postMessage({ id, ok: false, error, fatal });
        }
    });
};
