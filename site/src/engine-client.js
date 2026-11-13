// A worker running quicktype-core on one engine, seen from the page.
//
// Runs are "latest wins": while one runs, only the newest request waits;
// requests it replaces resolve to `undefined`. The worker is created on
// first use and requests wait until it has loaded.

/* global __WORKER_FILE__ */

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
        this.worker = new Worker(`${__WORKER_FILE__}?engine=${this.engine}`, { type: "module" });
        this.ready = new Promise((resolve, reject) => {
            this.worker.onerror = (event) => {
                reject(new Error(event.message || "the worker failed to start"));
            };
            this.worker.onmessage = (event) => {
                const message = event.data;
                if (message.type === "ready") {
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

    async pump() {
        if (this.busy || this.pending === undefined) return;
        this.busy = true;
        try {
            await this.start();
        } catch (e) {
            const { resolve } = this.pending;
            this.pending = undefined;
            this.busy = false;
            resolve({ ok: false, error: { message: `The ${this.engine} worker did not start: ${e.message}` }, times: [] });
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
        this.inFlight = undefined;
        this.busy = false;
        if (inFlight !== undefined && inFlight.id === message.id) {
            // A newer request is waiting: this result is already stale.
            inFlight.resolve(this.pending === undefined ? message : undefined);
        }

        void this.pump();
    }
}
