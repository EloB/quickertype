// Running a quicktype run on the WebAssembly engine: the one call per run
// that `Run.run()`/`Run.runSync()` make after `preRun()` when the run is
// eligible (see encode.ts), the host callbacks the engine makes during the
// run, and turning its outcome back into what the TypeScript engine would
// have returned or thrown.

import URI from "urijs";

import {
    IssueAnnotationData,
    anyTypeIssueAnnotation,
    nullTypeIssueAnnotation,
} from "../Annotation.js";
import type { InputData } from "../input/Inputs.js";
import { JSONSchemaInput, Ref } from "../input/JSONSchemaInput.js";
import { type PathElement, PathElementKind } from "../input/PathElement.js";
import type { JSONSchemaStore } from "../input/JSONSchemaStore.js";
import { messageError } from "../Messages.js";
import type { RunContext } from "../Run.js";
import type { Annotation, SerializedRenderResult } from "../Source.js";
import { panic } from "../support/Support.js";
import type {
    MultiFileRenderResult,
    TargetLanguage,
} from "../TargetLanguage.js";

import { type EncodedRun, Unencodable, encodeRun, encodeValue } from "./encode.js";
import {
    discardEngine,
    engineAsync,
    engineLoadError,
    engineMode,
    engineSync,
    isDiscarded,
} from "./engine.js";
import type { WasmGlue } from "./wasm/glue.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the bridge reads private fields of the facade's objects

/**
 * Which engine ran what, for tests and debugging: `wasm` counts runs the
 * WebAssembly engine did, `ts` runs the TypeScript engine did (for any
 * reason), and `unsupported` those of the latter that were eligible but
 * that the engine declined because it lacks a feature (a renderer not
 * ported yet), by feature in `unsupportedBy`.
 */
export const engineStats = {
    wasm: 0,
    ts: 0,
    unsupported: 0,
    unsupportedBy: {} as Record<string, number>,
    /** Runs redone on the TypeScript engine because the engine failed. */
    rerun: 0,
    /** Store documents flattened for the engine (each object once per run). */
    documentsEncoded: 0,
    /** What the engine's last failure was (a panic message or an exception). */
    lastFailure: undefined as string | undefined,
};

/** The engine lacks `feature`: the run goes to the TypeScript engine. */
function declined(feature: string): undefined {
    engineStats.ts++;
    engineStats.unsupported++;
    engineStats.unsupportedBy[feature] = (engineStats.unsupportedBy[feature] ?? 0) + 1;
    return undefined;
}

const supportedLanguages = new WeakMap<WasmGlue, Map<string, boolean>>();

type InputSchemaStoreClass = new (
    inputs: Map<string, string>,
    ctx: RunContext,
    delegate?: JSONSchemaStore,
) => JSONSchemaStore;

let inputSchemaStoreClass: InputSchemaStoreClass | undefined;

/**
 * The module-private `InputJSONSchemaStore` of JSONSchemaInput.ts, which
 * `addTypes` wraps the user's store in when schemas are given as text.
 * It is taken from a probe input whose `addTypes` stops right after
 * creating one, so the facade uses the very same class.
 */
function getInputSchemaStoreClass(): InputSchemaStoreClass {
    if (inputSchemaStoreClass === undefined) {
        const probe = new JSONSchemaInput(undefined);
        probe.addSourceSync({ name: "probe", schema: "{}" });
        const stop = new Error("probe");
        const ctx = {
            debugPrintReconstitution: false,
            debugPrintSchemaResolving: false,
            debugPrintTransformations: false,
            stringTypeMapping: new Map(),
            time: () => {
                throw stop;
            },
            timeSync: () => {
                throw stop;
            },
        } as unknown as RunContext;
        probe.addTypes(ctx, undefined as any).catch(() => undefined);
        inputSchemaStoreClass = (probe as any)._schemaStore.constructor;
    }

    return inputSchemaStoreClass as InputSchemaStoreClass;
}

/**
 * The start of `JSONSchemaInput.addTypes`, on the facade's object: wraps
 * the store when schemas were given as text. Returns the store the rest of
 * `addTypes` uses.
 */
function prepareSchemaInput(input: any, ctx: RunContext): JSONSchemaStore {
    let maybeSchemaStore = input._schemaStore;
    if (input._schemaInputs.size === 0) {
        if (maybeSchemaStore === undefined) {
            return panic("Must have a schema store to process JSON Schema");
        }
    } else {
        const InputJSONSchemaStore = getInputSchemaStoreClass();
        input._schemaStore = new InputJSONSchemaStore(
            input._schemaInputs,
            ctx,
            maybeSchemaStore,
        );
        maybeSchemaStore = input._schemaStore;
    }

    return maybeSchemaStore;
}

/** How the engine sends a JSON Schema `Ref`: its address and path elements. */
type RefPlaceholder = {
    address?: string;
    path: Array<{ kind: PathElementKind; key?: string; index?: number }>;
};

/** The `Ref` the engine sent as `placeholder`, rebuilt exactly. */
function refFromPlaceholder(placeholder: RefPlaceholder): Ref {
    const path = placeholder.path.map((e): PathElement => {
        switch (e.kind) {
            case PathElementKind.KeyOrIndex:
                return { kind: PathElementKind.KeyOrIndex, key: e.key as string };
            case PathElementKind.Type:
                return { kind: PathElementKind.Type, index: e.index as number };
            case PathElementKind.Root:
                return { kind: PathElementKind.Root };
            default:
                return { kind: PathElementKind.Object };
        }
    });
    const ref = new Ref(undefined, path);
    // The address is already normalized; `new Ref` would normalize it once
    // more, which decodes percent escapes a second time.
    if (placeholder.address !== undefined) ref.addressURI = new URI(placeholder.address);
    return ref;
}

/** Turns the engine's `Ref` (and other `toString()`) placeholders back into objects. */
function rehydrateProperty(value: unknown): unknown {
    if (Array.isArray(value)) return value.map(rehydrateProperty);
    if (value === null || typeof value !== "object") return value;
    const ref = (value as any).__qtRef;
    if (ref !== undefined) return refFromPlaceholder(ref);
    const display = (value as any).__qtDisplay;
    if (display !== undefined) {
        const text: string = display.display;
        return { toString: () => text };
    }

    const result: Record<string, unknown> = {};
    for (const key of Object.keys(value)) {
        result[key] = rehydrateProperty((value as any)[key]);
    }

    return result;
}

const jsErrorConstructors: Record<string, new (message: string) => Error> = {
    Error,
    TypeError,
    SyntaxError,
    RangeError,
    ReferenceError,
    URIError,
};

function throwEngineError(error: any): never {
    if (error.qt !== undefined) {
        const properties: Record<string, unknown> = {};
        for (const [name, value] of error.qt.properties as Array<[string, unknown]>) {
            properties[name] = rehydrateProperty(value);
        }

        return messageError(error.qt.kind, properties as any);
    }

    const Constructor = jsErrorConstructors[error.js.name] ?? Error;
    throw new Constructor(error.js.message);
}

function decodeFiles(files: any[]): MultiFileRenderResult {
    const result = new Map<string, SerializedRenderResult>();
    for (const file of files) {
        const text: string = file.text;
        const lengths: Uint32Array = file.lengths;
        const lines: string[] = [];
        let at = 0;
        for (let i = 0; i < lengths.length; i++) {
            lines.push(text.slice(at, at + lengths[i]));
            at += lengths[i];
        }

        const spans: Float64Array = file.spans;
        const messages: string[] = file.messages;
        const annotations: Annotation[] = [];
        for (let i = 0; i < messages.length; i++) {
            const message = messages[i];
            const annotation =
                message === anyTypeIssueAnnotation.message
                    ? anyTypeIssueAnnotation
                    : message === nullTypeIssueAnnotation.message
                      ? nullTypeIssueAnnotation
                      : new IssueAnnotationData(message);
            annotations.push({
                annotation,
                span: {
                    start: { line: spans[4 * i], column: spans[4 * i + 1] },
                    end: { line: spans[4 * i + 2], column: spans[4 * i + 3] },
                },
            });
        }

        result.set(file.name, { lines, annotations });
    }

    return result;
}

/** The result an outcome stands for (or the error it throws). */
function decodeResult(outcome: any): MultiFileRenderResult {
    if (outcome.files !== undefined) return decodeFiles(outcome.files);
    if (outcome.error !== undefined) return throwEngineError(outcome.error);
    throw outcome.thrown;
}

/** Restores what a run on the engine changed on the inputs. */
type Restore = () => void;

/**
 * What a run on the engine may change on its JSON Schema inputs, as
 * TypeScript's `addTypes` would: the store (wrapped when schemas are given
 * as text), the top-levels, and the cache of the store the input had.
 * When a run is redone on the TypeScript engine, this is put back first,
 * so that the TypeScript run starts from the same state as it would have.
 */
function snapshotInputs(inputs: JSONSchemaInput[]): Restore {
    const saved = inputs.map((input: any) => {
        const store = input._schemaStore;
        const cache: unknown = store?._schemas;
        return {
            input,
            store,
            topLevels: [...input._topLevels],
            cache: cache instanceof Map ? [...cache] : undefined,
        };
    });
    return () => {
        for (const { input, store, topLevels, cache } of saved) {
            input._schemaStore = store;
            input._topLevels.clear();
            for (const [name, ref] of topLevels) input._topLevels.set(name, ref);
            if (cache !== undefined) {
                store._schemas.clear();
                for (const [address, schema] of cache) store._schemas.set(address, schema);
            }
        }
    };
}

/** A weak reference, or a strong one where the host has no `WeakRef`. */
interface Ref_<T> {
    deref(): T | undefined;
}

function weakRef<T extends object>(target: T): Ref_<T> {
    const WeakRefConstructor = (globalThis as any).WeakRef;
    return typeof WeakRefConstructor === "function" ? new WeakRefConstructor(target) : { deref: () => target };
}

/** The async runs in flight on each instance (weakly: see `Driver`). */
const inflight = new WeakMap<WasmGlue, Set<Ref_<Driver>>>();

/**
 * Runs whose `Driver` became unreachable (a store promise that will never
 * settle, and nothing else waiting): the engine can drop them too.
 */
const abandoned = (() => {
    const Registry = (globalThis as any).FinalizationRegistry;
    if (typeof Registry !== "function") return undefined;
    return new Registry(({ glue, id }: { glue: WasmGlue; id: number }) => {
        if (isDiscarded(glue)) return;
        try {
            glue.cancel(id);
        } catch (e) {
            engineFailed(glue, e);
        }
    });
})();

/**
 * An exception escaped the engine: a trap (a Rust panic, which aborts) or a
 * stack overflow. The instance's memory can no longer be trusted, so it is
 * discarded, and every run on it, this one included, is redone on the
 * TypeScript engine, which gives the result (or error) TypeScript gives.
 */
function engineFailed(glue: WasmGlue, e: unknown): void {
    engineStats.lastFailure = lastPanic ?? String(e);
    lastPanic = undefined;
    discardEngine(glue);
    const runs = inflight.get(glue);
    inflight.delete(glue);
    for (const run of runs ?? []) run.deref()?.redo();
}

/** A `store.get` the engine is waiting for. */
interface SchemaRequest {
    storeId: number;
    address: string;
    callId: number;
}

/**
 * Drives one async run on the engine: polls it, starts the store fetches it
 * asks for once each poll has returned, and settles them.
 *
 * Only the pending fetches' callbacks (and a poll in progress) reference a
 * driver; the engine's host object holds it weakly. So a run whose fetch
 * never settles, and that nobody can observe any more, is collected, and
 * the engine is told to drop it (`abandoned`).
 */
class Driver {
    public id = -1;

    /** Requested by the engine during the current poll, not yet started. */
    public readonly requests: SchemaRequest[] = [];

    /** The stores of the run's schema inputs, set by `schemaPrepare`. */
    public readonly stores: JSONSchemaStore[] = [];

    private done = false;

    /** Set when the run must be redone on TypeScript whatever it ends with. */
    private unsupported: string | undefined;

    /** Documents already sent to the engine in this run, with their ids. */
    private readonly sent = new Map<object, number>();

    /** The store fetches started and not settled yet. */
    private readonly fetching = new Set<Promise<unknown>>();

    private readonly self: Ref_<Driver>;

    public constructor(
        public readonly glue: WasmGlue,
        private readonly run: RunContext,
        private readonly restore: Restore,
        private readonly resolve: (result: MultiFileRenderResult | undefined) => void,
        private readonly reject: (e: unknown) => void,
    ) {
        this.self = weakRef(this);
        let runs = inflight.get(glue);
        if (runs === undefined) {
            runs = new Set();
            inflight.set(glue, runs);
        }

        runs.add(this.self);
    }

    public started(id: number): void {
        this.id = id;
        abandoned?.register(this, { glue: this.glue, id }, this);
    }

    private end(): boolean {
        if (this.done) return false;
        this.done = true;
        inflight.get(this.glue)?.delete(this.self);
        abandoned?.unregister(this);
        return true;
    }

    /** Redo the run on the TypeScript engine (the engine failed). */
    public redo(): void {
        if (!this.end()) return;
        engineStats.ts++;
        engineStats.rerun++;
        this.handOver(undefined);
    }

    /**
     * Resolves with `undefined` (the TypeScript engine does the run) once
     * the store fetches this attempt started have settled, so that none of
     * them completes during the TypeScript run (a store's `get` caches what
     * it fetches, and must not get one address twice), and after the
     * inputs are back as they were.
     */
    private handOver(result: undefined): void {
        const quiet = (): undefined => undefined;
        Promise.all([...this.fetching].map((f) => f.then(quiet, quiet))).then(() => {
            this.restore();
            this.resolve(result);
        });
    }

    private finish(outcome: any): void {
        if (!this.end()) return;
        const unsupported = this.unsupported ?? outcome.unsupported;
        if (unsupported !== undefined) {
            this.handOver(declined(unsupported));
            return;
        }

        engineStats.wasm++;
        try {
            this.resolve(decodeResult(outcome));
        } catch (e) {
            this.reject(e);
        }
    }

    public step(): void {
        for (;;) {
            if (this.done) return;
            if (isDiscarded(this.glue)) {
                this.redo();
                return;
            }

            let outcome: unknown;
            try {
                outcome = this.glue.poll(this.id);
            } catch (e) {
                engineFailed(this.glue, e);
                return;
            }

            if (outcome !== undefined) {
                this.finish(outcome);
                return;
            }

            let settledNow = false;
            for (const request of this.requests.splice(0)) {
                if (this.startFetch(request)) settledNow = true;
            }

            if (!settledNow) return;
        }
    }

    /** Settles a fetch in the engine; false if the engine failed. */
    private settle(callId: number, ok: boolean, value: unknown): boolean {
        if (this.done) return false;
        if (isDiscarded(this.glue)) {
            this.redo();
            return false;
        }

        try {
            this.glue.settle(this.id, callId, ok, value);
            return true;
        } catch (e) {
            engineFailed(this.glue, e);
            return false;
        }
    }

    /**
     * A document for the engine: its encoding, or the id of the same
     * object sent before (stores hand out one object per address).
     */
    private document(schema: unknown): unknown {
        if (schema !== null && typeof schema === "object") {
            const id = this.sent.get(schema);
            if (id !== undefined) return { cachedId: id };
        }

        const encoded = encodeValue(schema);
        engineStats.documentsEncoded++;
        if (encoded !== undefined && schema !== null && typeof schema === "object") {
            const id = this.sent.size;
            this.sent.set(schema, id);
            encoded.id = id;
        }

        return encoded;
    }

    /**
     * `await this._store.get(address, this._ctx.debugPrintSchemaResolving)`
     * for a request of the engine. It runs after the poll that made the
     * request has returned: the engine awaits right there, so nothing
     * happens in between, and the store's code (user code) runs on a
     * shallow stack instead of below every frame of a deeply nested
     * resolution. Returns whether the request settled synchronously (the
     * store threw).
     */
    private startFetch(request: SchemaRequest): boolean {
        let pending: unknown;
        try {
            pending = this.stores[request.storeId].get(
                request.address,
                this.run.debugPrintSchemaResolving,
            );
        } catch (e) {
            return this.settle(request.callId, false, e);
        }

        const fetched = Promise.resolve(pending);
        this.fetching.add(fetched);
        const settled = (): void => {
            this.fetching.delete(fetched);
        };
        fetched.then(settled, settled);
        fetched.then(
            (schema) => {
                if (this.done) return;
                let value: unknown;
                try {
                    value = this.document(schema);
                } catch (e) {
                    if (!(e instanceof Unencodable)) throw e;
                    // Let the engine stop; the run is redone on TypeScript.
                    this.unsupported = e.feature;
                    if (this.settle(request.callId, false, e)) this.step();
                    return;
                }

                if (this.settle(request.callId, true, value)) this.step();
            },
            (e) => {
                if (this.settle(request.callId, false, e)) this.step();
            },
        );
        return false;
    }
}

let lastPanic: string | undefined;

function makeHost(
    run: RunContext,
    options: any,
    encoded: EncodedRun,
    glue: WasmGlue,
    driver: Ref_<Driver> | undefined,
): Record<string, unknown> {
    const syncStores: JSONSchemaStore[] = [];
    const stores = (): JSONSchemaStore[] => driver?.deref()?.stores ?? syncStores;
    return {
        schemaPrepare(storeId: number): void {
            stores()[storeId] = prepareSchemaInput(encoded.schemaInputs[storeId], run);
        },
        schemaGet(storeId: number, address: string, callId: number): void {
            const d = driver?.deref();
            if (d === undefined) {
                return panic("The synchronous engine cannot fetch schemas");
            }

            // Started once the poll has returned (see `startFetch`).
            d.requests.push({ storeId, address, callId });
        },
        schemaTopLevels(storeId: number, names: string[], refs: string[]): void {
            // `this.addTopLevel(name, ref)` for each top-level `addTypes` found.
            const input = encoded.schemaInputs[storeId];
            for (let i = 0; i < names.length; i++) {
                input.addTopLevel(names[i], Ref.parse(refs[i]));
            }
        },
        // The callbacks that can run user code report whether that made
        // the instance unusable (a nested run trapped); the engine then
        // traps too rather than go on.
        timing(name: string, milliseconds: number): boolean {
            // `this._options.onTiming?.({ name, milliseconds })`
            options.onTiming?.({ name, milliseconds });
            return isDiscarded(glue);
        },
        log(line: string): boolean {
            console.log(line);
            return isDiscarded(glue);
        },
        error(line: string): boolean {
            console.error(line);
            return isDiscarded(glue);
        },
        now(): number {
            return performance.now();
        },
        panicked(message: string): void {
            lastPanic = message;
        },
    };
}

function runOnEngine(
    glue: WasmGlue,
    encoded: EncodedRun,
    run: RunContext,
    options: any,
): Promise<MultiFileRenderResult | undefined> {
    const restore = snapshotInputs(encoded.schemaInputs);
    return new Promise((resolve, reject) => {
        const driver = new Driver(glue, run, restore, resolve, reject);
        const host = makeHost(run, options, encoded, glue, weakRef(driver));
        let id: number;
        try {
            id = glue.start(encoded.request, host);
        } catch (e) {
            engineFailed(glue, e);
            return;
        }

        driver.started(id);
        driver.step();
    });
}

/**
 * Whether the engine has the language's renderer (asked once per
 * instance), so that runs it would decline go to the TypeScript engine
 * before they have any side effects; `undefined` if asking made the engine
 * fail.
 */
function engineSupports(glue: WasmGlue, lang: string): boolean | undefined {
    let known = supportedLanguages.get(glue);
    if (known === undefined) {
        known = new Map();
        supportedLanguages.set(glue, known);
    }

    let supported = known.get(lang);
    if (supported === undefined) {
        try {
            supported = glue.supportsLanguage(lang);
        } catch (e) {
            engineFailed(glue, e);
            return undefined;
        }

        known.set(lang, supported);
    }

    return supported;
}

/** The TypeScript engine does the run: the engine failed or declined it. */
function useTypeScript(glue: WasmGlue, encoded: EncodedRun, targetLanguage: TargetLanguage): boolean {
    const supported = engineSupports(glue, encoded.request.lang as string);
    if (supported === undefined) {
        engineStats.ts++;
        engineStats.rerun++;
        return true;
    }

    if (!supported) {
        declined(`${targetLanguage.displayName} renderer`);
        return true;
    }

    return false;
}

/**
 * `run()` on the WebAssembly engine: `undefined` if the run is not
 * eligible (the caller then uses the TypeScript engine), else a promise of
 * the result, or of `undefined` if the TypeScript engine has to do it
 * after all: the engine could not be loaded, does not support the run (a
 * language whose renderer is not ported yet), or failed.
 */
export function runNative(
    run: RunContext,
    options: any,
    inputData: InputData,
    targetLanguage: TargetLanguage,
): Promise<MultiFileRenderResult | undefined> | undefined {
    const mode = engineMode();
    if (mode === "ts") {
        engineStats.ts++;
        return undefined;
    }

    const encoded = encodeRun(options, inputData, targetLanguage);
    if (encoded === undefined) {
        engineStats.ts++;
        return undefined;
    }

    return engineAsync().then((glue) => {
        if (glue === undefined) {
            if (mode === "wasm") throw engineLoadError();
            engineStats.ts++;
            return undefined;
        }

        if (useTypeScript(glue, encoded, targetLanguage)) return undefined;
        return runOnEngine(glue, encoded, run, options);
    });
}

/** `runSync()` on the WebAssembly engine, or `undefined` (see `runNative`). */
export function runNativeSync(
    run: RunContext,
    options: any,
    inputData: InputData,
    targetLanguage: TargetLanguage,
): MultiFileRenderResult | undefined {
    const mode = engineMode();
    if (mode === "ts") {
        engineStats.ts++;
        return undefined;
    }

    const encoded = encodeRun(options, inputData, targetLanguage);
    if (encoded === undefined) {
        engineStats.ts++;
        return undefined;
    }

    const glue = engineSync();
    if (glue === undefined) {
        if (mode === "wasm" && engineLoadError() !== undefined) {
            throw engineLoadError();
        }

        engineStats.ts++;
        return undefined;
    }

    if (useTypeScript(glue, encoded, targetLanguage)) return undefined;
    const restore = snapshotInputs(encoded.schemaInputs);
    let outcome: any;
    try {
        outcome = glue.runSync(encoded.request, makeHost(run, options, encoded, glue, undefined));
    } catch (e) {
        engineFailed(glue, e);
        restore();
        engineStats.ts++;
        engineStats.rerun++;
        return undefined;
    }

    if (outcome.unsupported !== undefined) {
        restore();
        return declined(outcome.unsupported);
    }

    engineStats.wasm++;
    return decodeResult(outcome);
}
