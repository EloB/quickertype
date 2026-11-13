// Running a quicktype run on the WebAssembly engine: the one call per run
// that `Run.run()`/`Run.runSync()` make after `preRun()` when the run is
// eligible (see encode.ts), the host callbacks the engine makes during the
// run, and turning its outcome back into what the TypeScript engine would
// have returned or thrown.

import {
    IssueAnnotationData,
    anyTypeIssueAnnotation,
    nullTypeIssueAnnotation,
} from "../Annotation.js";
import type { InputData } from "../input/Inputs.js";
import { JSONSchemaInput, Ref } from "../input/JSONSchemaInput.js";
import type { JSONSchemaStore } from "../input/JSONSchemaStore.js";
import { messageError } from "../Messages.js";
import type { RunContext } from "../Run.js";
import type { Annotation, SerializedRenderResult } from "../Source.js";
import { panic } from "../support/Support.js";
import type {
    MultiFileRenderResult,
    TargetLanguage,
} from "../TargetLanguage.js";

import { type EncodedRun, encodeRun, encodeValue } from "./encode.js";
import {
    discardEngine,
    engineAsync,
    engineLoadError,
    engineSync,
    isDiscarded,
} from "./engine.js";
import type { WasmGlue } from "./wasm/glue.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the bridge reads private fields of the facade's objects

/** How many runs each engine did, for tests (`QUICKTYPE_ENGINE`). */
export const engineStats = { wasm: 0, ts: 0 };

const engineKey = Symbol.for("quicktype-core.engine");

/**
 * `QUICKTYPE_ENGINE` (or `globalThis[Symbol.for("quicktype-core.engine")]`):
 * `ts` runs everything on the TypeScript engine; `wasm` uses the
 * WebAssembly engine for every eligible run and fails if it cannot be
 * loaded; anything else uses it when it can be loaded.
 */
function engineMode(): "ts" | "wasm" | "auto" {
    let mode = (globalThis as any)[engineKey];
    if (mode === undefined && typeof process !== "undefined") {
        mode = process.env?.QUICKTYPE_ENGINE;
    }

    return mode === "ts" || mode === "wasm" ? mode : "auto";
}

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

/** Turns the engine's `Ref` placeholders back into `Ref`s. */
function rehydrateProperty(value: unknown): unknown {
    if (Array.isArray(value)) return value.map(rehydrateProperty);
    if (value === null || typeof value !== "object") return value;
    const display = (value as any).__qtDisplay;
    if (display !== undefined) {
        const text: string = display.display;
        try {
            const ref = Ref.parse(text);
            if (ref.toString() === text) return ref;
        } catch {
            // Not a ref.
        }

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

function decodeOutcome(outcome: any): MultiFileRenderResult {
    if (outcome.files !== undefined) return decodeFiles(outcome.files);
    if (outcome.error !== undefined) return throwEngineError(outcome.error);
    throw outcome.thrown;
}

let lastPanic: string | undefined;

/**
 * An exception that escaped the engine: a trap (a Rust panic, which
 * aborts) or a stack overflow. The instance is discarded either way.
 */
function engineFailure(glue: WasmGlue, e: unknown): unknown {
    discardEngine(glue);
    const panicMessage = lastPanic;
    lastPanic = undefined;
    if (e instanceof RangeError) {
        // The JavaScript engine's stack overflowed, as it would have in
        // the TypeScript engine.
        return e;
    }

    try {
        return messageError("InternalError", {
            message: panicMessage ?? `WebAssembly engine failed: ${String(e)}`,
        });
    } catch (error) {
        return error;
    }
}

interface Driver {
    glue: WasmGlue;
    id: number;
    step: () => void;
    fail: (e: unknown) => void;
}

function makeHost(
    run: RunContext,
    options: any,
    encoded: EncodedRun,
    driver: Driver | undefined,
): Record<string, unknown> {
    const stores: JSONSchemaStore[] = [];
    return {
        schemaPrepare(storeId: number): void {
            stores[storeId] = prepareSchemaInput(
                encoded.schemaInputs[storeId],
                run,
            );
        },
        schemaGet(storeId: number, address: string, callId: number): void {
            if (driver === undefined) {
                return panic("The synchronous engine cannot fetch schemas");
            }

            // `await this._store.get(address, this._ctx.debugPrintSchemaResolving)`
            const pending = stores[storeId].get(
                address,
                run.debugPrintSchemaResolving,
            );
            const { glue } = driver;
            const settle = (ok: boolean, value: unknown): void => {
                if (isDiscarded(glue)) {
                    driver.fail(
                        engineFailure(glue, new Error("discarded")),
                    );
                    return;
                }

                try {
                    glue.settle(driver.id, callId, ok, value);
                } catch (e) {
                    driver.fail(engineFailure(glue, e));
                    return;
                }

                driver.step();
            };
            Promise.resolve(pending).then(
                (schema) => {
                    let encodedSchema: unknown;
                    try {
                        encodedSchema = encodeValue(schema);
                    } catch (e) {
                        settle(false, e);
                        return;
                    }

                    settle(true, encodedSchema);
                },
                (e) => settle(false, e),
            );
        },
        schemaTopLevels(storeId: number, names: string[], refs: string[]): void {
            // `this.addTopLevel(name, ref)` for each top-level `addTypes` found.
            const input = encoded.schemaInputs[storeId];
            for (let i = 0; i < names.length; i++) {
                input.addTopLevel(names[i], Ref.parse(refs[i]));
            }
        },
        timing(name: string, milliseconds: number): void {
            // `this._options.onTiming?.({ name, milliseconds })`
            options.onTiming?.({ name, milliseconds });
        },
        log(line: string): void {
            console.log(line);
        },
        error(line: string): void {
            console.error(line);
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
): Promise<MultiFileRenderResult> {
    return new Promise((resolve, reject) => {
        let settled = false;
        const driver: Driver = {
            glue,
            id: -1,
            fail(e) {
                if (settled) return;
                settled = true;
                reject(e);
            },
            step() {
                if (settled) return;
                let outcome: unknown;
                try {
                    outcome = glue.poll(driver.id);
                } catch (e) {
                    driver.fail(engineFailure(glue, e));
                    return;
                }

                if (outcome === undefined) return;
                settled = true;
                try {
                    resolve(decodeOutcome(outcome));
                } catch (e) {
                    reject(e);
                }
            },
        };
        const host = makeHost(run, options, encoded, driver);
        try {
            driver.id = glue.start(encoded.request, host);
        } catch (e) {
            driver.fail(engineFailure(glue, e));
            return;
        }

        driver.step();
    });
}

/**
 * `run()` on the WebAssembly engine: `undefined` if the run is not
 * eligible (the caller then uses the TypeScript engine), else a promise of
 * the result, or of `undefined` if the engine could not be loaded.
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

        engineStats.wasm++;
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

    engineStats.wasm++;
    let outcome: unknown;
    try {
        outcome = glue.runSync(
            encoded.request,
            makeHost(run, options, encoded, undefined),
        );
    } catch (e) {
        throw engineFailure(glue, e);
    }

    return decodeOutcome(outcome);
}
