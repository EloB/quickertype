// A worker running quicktype-core on one engine, seen from the page.
//
// Requests are handled one at a time, in order, and the two workers share
// a `Lane`: only one request runs at a time across both, so that a time is
// never taken while the other engine runs too. `drop()` withdraws the
// requests still waiting (they resolve to `undefined`); the page calls it
// when the input changes, so that what waits is only ever for the newest
// input. A result is never withheld: the page knows which request it asked
// for, and whether that is still the one it shows. The worker is created
// on first use (`start()` creates it early) and requests wait until it has
// loaded. If the worker fails (it does not load, or reports an error it did
// not catch, or a message from it cannot be read), the request in flight
// fails with a readable error, marked `workerFailure` (it is not
// quicktype's), and the next request gets a new worker. Every request
// settles.

/* global __WORKER_FILE__ */

/** The engines as what they are. */
export const engineKinds = { wasm: "WebAssembly", ts: "TypeScript" };

/**
 * One request at a time, across workers, in the order they asked. Keeps the
 * span of each request, from the page's side (sent, replied: `performance.now()`),
 * the latest `limit` of them.
 */
export class Lane {
    constructor(limit = 500) {
        this.tail = Promise.resolve();
        this.limit = limit;
        /** { engine, id, sent, received } for each request that was sent, in the order they settled. */
        this.history = [];
    }

    /** Resolves to a `release` function once every earlier holder has released. */
    acquire() {
        let release;
        const turn = new Promise((resolve) => {
            release = resolve;
        });
        const ready = this.tail.then(() => release);
        this.tail = this.tail.then(() => turn);
        return ready;
    }

    record(span) {
        this.history.push(span);
        if (this.history.length > this.limit) this.history.shift();
    }
}

export class EngineClient {
    /**
     * @param {"wasm" | "ts"} engine
     * @param {Lane} lane shared with the other engine's client
     */
    constructor(engine, lane) {
        this.engine = engine;
        this.lane = lane;
        this.worker = undefined;
        this.boot = undefined;
        this.ready = undefined;
        /** Requests waiting for the worker: { request, resolve }. */
        this.queue = [];
        /** The request sent to the worker: { id, worker, settle }. */
        this.inFlight = undefined;
        this.pumping = false;
        this.nextId = 1;
        this.onBoot = () => {};
    }

    /** Creates the worker if there is none; resolves once it has loaded. A failure is reported by the run that needs it. */
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
                if (loaded) this.crashed(worker, message);
                else reject(new Error(message));
            };
            worker.onerror = (event) => {
                event.preventDefault();
                failed(event.message || "it stopped with an error");
            };
            worker.onmessageerror = () => failed("a message from it could not be read");
            worker.onmessage = (event) => {
                if (this.worker !== worker) return;
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
        // Handled here once; `pump` reports it, as the failure of the request that needed the worker.
        this.ready.catch(() => {});
        return this.ready;
    }

    /** Resolves to the worker's reply, or to `undefined` if the request was dropped before it ran. */
    run(request) {
        return new Promise((resolve) => {
            this.queue.push({ request, resolve });
            void this.pump();
        });
    }

    /** Withdraws the requests that have not started; each resolves to `undefined`. */
    drop() {
        const dropped = this.queue;
        this.queue = [];
        for (const { resolve } of dropped) resolve(undefined);
    }

    get isBusy() {
        return this.inFlight !== undefined || this.queue.length > 0;
    }

    /** A result for a run the worker did not do, or did not finish: not quicktype's. */
    failure(message) {
        return { ok: false, error: { message }, times: [], inputTimes: [], workerFailure: true };
    }

    /** Sends the queue's requests one by one, each in its turn on the lane. One pump at a time. */
    async pump() {
        if (this.pumping) return;
        this.pumping = true;
        try {
            while (this.queue.length > 0) {
                const release = await this.lane.acquire();
                try {
                    // Dropped while waiting for its turn.
                    if (this.queue.length === 0) break;
                    let worker;
                    try {
                        await this.start();
                        worker = this.worker;
                    } catch (e) {
                        this.queue.shift()?.resolve(this.failure(`The ${engineKinds[this.engine]} worker did not start: ${e.message}`));
                        continue;
                    }

                    const next = this.queue.shift();
                    if (next === undefined) break;
                    if (worker === undefined) {
                        // It failed between loading and now.
                        next.resolve(this.failure(`The ${engineKinds[this.engine]} worker stopped before it ran this; the next run starts a new one.`));
                        continue;
                    }

                    next.resolve(await this.send(worker, next.request));
                } finally {
                    release();
                }
            }
        } finally {
            this.pumping = false;
        }
    }

    /** Sends `request` to `worker`; resolves to its reply, or to a failure if the worker stops first. */
    send(worker, request) {
        return new Promise((resolve) => {
            const id = this.nextId++;
            const sent = performance.now();
            this.inFlight = {
                id,
                worker,
                settle: (reply) => {
                    this.inFlight = undefined;
                    this.lane.record({ engine: this.engine, id, sent, received: performance.now() });
                    resolve(reply);
                },
            };
            worker.postMessage({ ...request, id });
        });
    }

    finish(message) {
        if (this.inFlight === undefined || this.inFlight.id !== message.id) return;
        this.inFlight.settle(message);
    }

    /** Stops the worker; the next request starts a new one. */
    discard() {
        this.worker?.terminate();
        this.worker = undefined;
        this.ready = undefined;
    }

    /** `worker` failed after it had loaded: the request it was running fails; the next one gets a new worker. */
    crashed(worker, message) {
        if (this.inFlight === undefined || this.inFlight.worker !== worker) return;
        this.inFlight.settle(
            this.failure(`The ${engineKinds[this.engine]} worker stopped (${message}); the next run starts a new one.`),
        );
    }
}
