// The part workers of the WebAssembly worker (worker.js): Web Workers of
// its own (part-worker.js), each with an engine instance of its own made
// from the module the worker compiled, which read a large file's parts
// (quickertype-core's src/native/parallel.ts). They start on the first
// large file, and stay for the next one until a minute without one: a
// worker's instance keeps the memory it grew to (about the tallies of the
// parts it read last, and a part's text), which a page that reads no more
// large files should not keep.
//
// GitHub Pages sends no COOP/COEP headers, so there is no
// SharedArrayBuffer: each part worker reads its ranges of the File itself
// (`file.slice`), and hands back numbers and, at the end, its tallies as
// bytes (transferred).

/* global __PART_WORKER_FILE__ */

/** The most part workers: past this many, more save little (docs/BENCHMARKS.md, "Reading on several workers"). */
export const maxPartWorkers = 8;

/** How long the part workers stay without a large file, in ms. */
const idleMs = 60_000;

/** A part worker, seen from here: its jobs as promises (a `PartWorker` of parallel.ts). */
class PartWorkerClient {
    constructor(module) {
        this.worker = new Worker(new URL(__PART_WORKER_FILE__, import.meta.url), { type: "module" });
        this.pending = new Map();
        this.nextId = 1;
        this.failed = undefined;
        const fail = (message) => {
            this.failed = message;
            for (const { reject } of this.pending.values()) reject(new Error(message));
            this.pending.clear();
        };
        this.worker.onerror = (event) => {
            event.preventDefault();
            fail(`a part worker stopped: ${event.message || "an error"}`);
        };
        this.worker.onmessageerror = () => fail("a message from a part worker could not be read");
        this.worker.onmessage = (event) => {
            const { id, ok, value, error, fatal } = event.data;
            const call = this.pending.get(id);
            if (call === undefined) return;
            this.pending.delete(id);
            if (ok) call.resolve(value);
            else call.reject(new Error(error));
            // Its engine trapped: replaced on the next reading.
            if (fatal) fail(`a part worker's engine stopped: ${error}`);
        };
        this.started = this.call("start", { module });
        // Reported by the reading that needs it.
        this.started.catch(() => {});
    }

    call(job, args) {
        if (this.failed !== undefined) return Promise.reject(new Error(this.failed));
        return new Promise((resolve, reject) => {
            const id = this.nextId++;
            this.pending.set(id, { resolve, reject });
            this.worker.postMessage({ id, job, args });
        });
    }

    /** The jobs of one reading of `file`. */
    reading(file) {
        return {
            summarize: (job) => this.call("summarize", { ...job, file }),
            split: (job) => this.call("split", job),
            tally: (job) => this.call("tally", job),
            done: () => {
                this.call("done").catch(() => {});
            },
        };
    }

    terminate() {
        this.worker.terminate();
        this.failed = "the part worker was stopped";
    }
}

export class PartPool {
    constructor() {
        this.clients = [];
        this.timer = undefined;
    }

    /**
     * `count` part workers for reading `file`, started with `module` (the
     * engine, compiled) if there are fewer; those that failed are replaced.
     * Resolves once they have started.
     */
    async readers(file, module, count) {
        clearTimeout(this.timer);
        this.clients = this.clients.filter((client) => {
            if (client.failed === undefined) return true;
            client.terminate();
            return false;
        });
        while (this.clients.length < count) this.clients.push(new PartWorkerClient(module));
        const clients = this.clients.slice(0, count);
        await Promise.all(clients.map((client) => client.started));
        return clients.map((client) => client.reading(file));
    }

    /** Each part worker's WebAssembly memory, in bytes (for measurements). */
    memory() {
        return Promise.all(this.clients.map((client) => client.call("memory")));
    }

    /** The reading is over: the workers stay a while for the next one. */
    idle() {
        clearTimeout(this.timer);
        this.timer = setTimeout(() => this.stop(), idleMs);
    }

    stop() {
        clearTimeout(this.timer);
        for (const client of this.clients) client.terminate();
        this.clients = [];
    }
}
