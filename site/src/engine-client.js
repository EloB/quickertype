// A worker running quicktype-core on one engine, seen from the page.
//
// Runs are "latest wins": while one runs, only the newest request waits;
// requests it replaces resolve to `undefined`. The worker is created on
// first use and requests wait until it has loaded. If the worker fails
// (it does not load, or reports an error it did not catch, or a message
// from it cannot be read), the request in flight fails with a readable
// error and the next request gets a new worker.

/* global __WORKER_FILE__ */

const names = { wasm: "WebAssembly", ts: "TypeScript" };

export class EngineClient {
    /** @param {"wasm" | "ts"} engine */
    constructor(engine) {
        this.engine = engine;
        this.worker = undefined;
        this.boot = undefined;
        this.ready = undefined;
        this.busy = false;
        this.pending = undefined;
        this.inFlight = undefined;
        this.nextId = 1;
        this.onBoot = () => {};
    }

    start() {
        if (this.ready !== undefined) return this.ready;
        const createdAt = performance.now();
        const worker = new Worker(`${__WORKER_FILE__}?engine=${this.engine}`, { type: "module" });
        this.worker = worker;
        this.ready = new Promise((resolve, reject) => {
            let loaded = false;
            const failed = (message) => {
                // A worker already replaced may still report.
                if (this.worker !== worker) return;
                this.discard();
                if (loaded) this.crashed(message);
                else reject(new Error(message));
            };
            worker.onerror = (event) => {
                event.preventDefault();
                failed(event.message || "it stopped with an error");
            };
            worker.onmessageerror = () => failed("a message from it could not be read");
            worker.onmessage = (event) => {
                const message = event.data;
                if (message.type === "ready") {
                    loaded = true;
                    this.boot = { ...message, startMs: performance.now() - createdAt };
                    this.onBoot(this.boot);
                    resolve();
                } else if (message.type === "result") {
                    this.finish(message);
                }
            };
        });
        return this.ready;
    }

    /** Resolves to the worker's reply, or to `undefined` if a newer request replaced this one. */
    run(request) {
        return new Promise((resolve) => {
            if (this.pending !== undefined) this.pending.resolve(undefined);
            this.pending = { request, resolve };
            void this.pump();
        });
    }

    get isBusy() {
        return this.busy || this.pending !== undefined;
    }

    /** A result for a run the worker did not do. */
    failure(message) {
        return { ok: false, error: { message }, times: [], inputTimes: [] };
    }

    async pump() {
        if (this.busy || this.pending === undefined) return;
        this.busy = true;
        try {
            await this.start();
        } catch (e) {
            const { resolve } = this.pending;
            this.pending = undefined;
            this.busy = false;
            resolve(this.failure(`The ${names[this.engine]} worker did not start: ${e.message}`));
            return;
        }

        const { request, resolve } = this.pending;
        this.pending = undefined;
        const id = this.nextId++;
        this.inFlight = { id, resolve };
        this.worker.postMessage({ ...request, id });
    }

    finish(message) {
        const inFlight = this.inFlight;
        if (inFlight === undefined || inFlight.id !== message.id) return;
        this.inFlight = undefined;
        this.busy = false;
        // A newer request is waiting: this result is already stale.
        inFlight.resolve(this.pending === undefined ? message : undefined);
        void this.pump();
    }

    /** Stops the worker; the next request starts a new one. */
    discard() {
        this.worker?.terminate();
        this.worker = undefined;
        this.ready = undefined;
    }

    /** The worker failed after it had loaded: the run in flight fails, the next one gets a new worker. */
    crashed(message) {
        const inFlight = this.inFlight;
        this.inFlight = undefined;
        this.busy = false;
        inFlight?.resolve(
            this.pending === undefined
                ? this.failure(`The ${names[this.engine]} worker stopped (${message}); the next run starts a new one.`)
                : undefined,
        );
        void this.pump();
    }
}
