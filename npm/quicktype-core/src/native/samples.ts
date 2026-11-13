// JSON samples read by the WebAssembly engine as they are added.
//
// `JSONInput.addSource`/`addSourceSync` parse each sample right away with
// `CompressedJSONFromString.parseSync`, which asks `readSample` first (the
// one line changed in src/input/CompressedJSON.ts). For a built-in
// `CompressedJSONFromString` and a string sample, the engine reads the text
// (crates/quicktype-wasm/src/samples.rs: the port's `JSON.parse`-semantics
// reader) into a compressed form it keeps for every run that uses the
// input, and returns the sample's root `Value` exactly as TypeScript would
// have computed it. The TypeScript tables of the `CompressedJSON` stay
// empty until something reads them: its four table fields become accessors
// that, on first use, fill them with the engine's tables, which are the
// ones TypeScript builds from the same samples (`materialize`). A run on
// the engine holds the engine's copy from when it is encoded
// (`leaseSamples`, encode.ts), so the TypeScript parse and the conversion
// of the tables are both skipped.
//
// Everything else is read by TypeScript, as before, after the tables are
// filled: samples that are not strings or not well-formed UTF-16; samples
// the engine declines (a string root value, whose index depends on
// TypeScript's string table; nesting deeper than its limit, where
// TypeScript's recursive `process` could run out of stack; a `\u` escape
// that leaves a surrogate unpaired); a `CompressedJSON` that is not exactly
// a `CompressedJSONFromString` with a built-in date/time recognizer and a
// valid integer range, or that has tables already; a host without
// `FinalizationRegistry`; samples read while the TypeScript engine is
// forced; and samples read while the engine is not compiled yet (see
// `engineForSample`). A sample that is not JSON is not read by the engine
// either: TypeScript's `JSON.parse` then throws V8's own error, from
// `addSource`, as before.
//
// The README ("JSON samples") has the argument for why this cannot be told
// apart from TypeScript reading the samples.

import { CompressedJSONFromString } from "../input/CompressedJSON.js";

import { engineFailed, engineStats } from "./bridge.js";
import { dateTimeKind, hasOnlyBuiltinFields, isWellFormed } from "./encode.js";
import { engineIfCompiled, engineMode, engineSync, isDiscarded } from "./engine.js";
import { installSampleReader } from "./hook.js";
import type { ExportedTables, WasmGlue } from "./wasm/glue.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the samples reader reads private fields of the facade's objects

/** The integer range a `CompressedJSON` reads numbers with. */
interface Range {
    min: string;
    max: string;
}

/** What a `CompressedJSON` reads samples with. */
interface Config {
    /** The recognizer object and its built-in kind. */
    recognizer: object;
    dateTime: string;
    handleRefs: unknown;
    /** A copy of `supportedIntegerRange`, or `null`. */
    range: Range | null;
}

/** A `CompressedJSON` whose samples the engine reads. */
interface NativeSamples {
    readonly glue: WasmGlue;
    readonly id: number;
    readonly config: Config;
    /**
     * Every sample the engine read into these tables, in order, while they
     * add up to at most `keptTexts` code units; `undefined` after that.
     * Only for an engine instance that fails (see `materialize`).
     */
    texts: string[] | undefined;
    /** The code units of the samples read. */
    textLength: number;
    /** The table fields as they were (empty), restored by `materialize`. */
    readonly fields: Array<[string, PropertyDescriptor]>;
}

/**
 * The samples a `CompressedJSON` keeps (see `NativeSamples.texts`): up to
 * 4 Mi code units (8 MiB) of them, so that the tables of a small input
 * never depend on the memory of an instance that failed, while a large
 * input is not held twice.
 */
let keptTexts = 1 << 22;

/** For tests: the limit of `NativeSamples.texts`; returns the old one. */
export function setKeptTexts(codeUnits: number): number {
    const old = keptTexts;
    keptTexts = codeUnits;
    return old;
}

/**
 * The size from which a sample is worth compiling the engine for, in code
 * units (see `engineForSample`).
 */
const compileForSample = 1 << 20;

const states = new WeakMap<object, NativeSamples>();

/** The fields a sample changes when TypeScript reads it. */
const tableFields = ["_strings", "_stringIndexes", "_objects", "_arrays"];

/** Engine compressed forms whose `CompressedJSON` was collected. */
const registry: any = (() => {
    const Registry = (globalThis as any).FinalizationRegistry;
    if (typeof Registry !== "function") return undefined;
    return new Registry(({ glue, id }: { glue: WasmGlue; id: number }) => drop(glue, id));
})();

function drop(glue: WasmGlue, id: number): void {
    if (isDiscarded(glue)) return;
    try {
        glue.jsonDrop(id);
    } catch (e) {
        engineFailed(glue, e);
    }
}

/** What `cjson` reads its next sample with, if the engine can read with it. */
function configOf(cjson: any): Config | undefined {
    const recognizer = cjson.dateTimeRecognizer;
    const dateTime = dateTimeKind(recognizer);
    if (dateTime === undefined) return undefined;
    const range = cjson.supportedIntegerRange;
    let copy: Range | null = null;
    if (range !== null) {
        if (typeof range !== "object") return undefined;
        const { min, max } = range;
        if (typeof min !== "string" || typeof max !== "string") return undefined;
        if (!isWellFormed(min) || !isWellFormed(max)) return undefined;
        copy = { min, max };
    }

    return { recognizer, dateTime, handleRefs: cjson.handleRefs, range: copy };
}

/** Whether samples read with `b` are read as with `a`. */
function sameConfig(a: Config, b: Config): boolean {
    return (
        a.dateTime === b.dateTime &&
        !!a.handleRefs === !!b.handleRefs &&
        (a.range === null
            ? b.range === null
            : b.range !== null && a.range.min === b.range.min && a.range.max === b.range.max)
    );
}

/** Whether `name` is an own, writable, configurable data property of `x`. */
function isPlainField(x: object, name: string): boolean {
    const descriptor = Object.getOwnPropertyDescriptor(x, name);
    return (
        descriptor !== undefined &&
        "value" in descriptor &&
        descriptor.writable === true &&
        descriptor.configurable === true
    );
}

/**
 * Whether `cjson` is as a new one: no tables (and nothing is being read),
 * fields that can be replaced, and the configuration as plain fields.
 */
function isFresh(cjson: any): boolean {
    if (!Object.isExtensible(cjson)) return false;
    for (const name of [...tableFields, "_contextStack", "dateTimeRecognizer", "handleRefs", "supportedIntegerRange"]) {
        if (!isPlainField(cjson, name)) return false;
    }

    return (
        Array.isArray(cjson._strings) &&
        cjson._strings.length === 0 &&
        Array.isArray(cjson._objects) &&
        cjson._objects.length === 0 &&
        Array.isArray(cjson._arrays) &&
        cjson._arrays.length === 0 &&
        cjson._stringIndexes !== null &&
        typeof cjson._stringIndexes === "object" &&
        Object.getOwnPropertyNames(cjson._stringIndexes).length === 0 &&
        Array.isArray(cjson._contextStack) &&
        cjson._contextStack.length === 0 &&
        cjson._ctx === undefined &&
        cjson._rootValue === undefined
    );
}

/**
 * The engine instance to read a sample of `length` code units on, if
 * reading it there is worth it. Samples never wait for the engine to be
 * compiled where that is asynchronous (browsers), and in Node a sample
 * compiles it only if it is large: compiling takes some 20 ms of CPU, a
 * run that goes to the TypeScript engine (a custom language, say) gains
 * nothing from it, and a small sample reads about as fast in TypeScript.
 * Once the engine is compiled (by the first run that uses it, or a large
 * sample), every sample is read there; instantiating it is cheap, and a
 * run would do it anyway.
 */
function engineForSample(length: number): WasmGlue | undefined {
    return engineIfCompiled() ?? (length >= compileForSample ? engineSync() : undefined);
}

/**
 * Starts reading `cjson`'s samples on the engine: a compressed form in
 * the engine, and the table fields replaced by accessors that fill them
 * on first use.
 */
function start(cjson: any, config: Config, glue: WasmGlue): NativeSamples | undefined {
    if (!isFresh(cjson)) return undefined;
    let id: number;
    try {
        id = glue.jsonCreate(config.dateTime, !!config.handleRefs, config.range?.min, config.range?.max);
    } catch (e) {
        engineFailed(glue, e);
        return undefined;
    }

    const fields: Array<[string, PropertyDescriptor]> = [];
    const state: NativeSamples = { glue, id, config, texts: [], textLength: 0, fields };
    for (const name of tableFields) {
        const descriptor = Object.getOwnPropertyDescriptor(cjson, name) as PropertyDescriptor;
        fields.push([name, descriptor]);
        Object.defineProperty(cjson, name, {
            configurable: true,
            enumerable: descriptor.enumerable,
            get() {
                materialize(cjson);
                return cjson[name];
            },
            set(value: unknown) {
                materialize(cjson);
                cjson[name] = value;
            },
        });
    }

    states.set(cjson, state);
    registry.register(cjson, { glue, id }, state);
    return state;
}

/**
 * Fills `cjson`'s TypeScript tables, if the engine has read samples into
 * it: the fields become plain again and get the engine's tables, which
 * are the ones TypeScript builds from the same samples (one conversion,
 * no parsing). Afterwards `cjson` is an ordinary `CompressedJSON`: its
 * samples are read by TypeScript, and runs send its tables.
 *
 * Should the engine instance have failed, the samples are read again by
 * TypeScript if they were kept (`NativeSamples.texts`); a larger input's
 * tables are still taken from the failed instance's memory, which a
 * failure (a panic, running out of memory, a stack overflow) leaves
 * readable. Only if that fails too are the samples lost, and filling the
 * tables throws.
 */
export function materialize(cjson: any): void {
    const state = states.get(cjson);
    if (state === undefined) return;
    states.delete(cjson);
    registry.unregister(state);
    const { glue, texts } = state;
    try {
        const tables = isDiscarded(glue) && texts !== undefined ? undefined : exportTables(state);
        if (tables === undefined && texts === undefined) {
            // Every use of the tables fails from now on, as this one does.
            const lost = new Error(
                "quicktype-core: the JSON samples of this input were lost when the WebAssembly engine failed",
            );
            for (const [name, descriptor] of state.fields) {
                const fail = (): never => {
                    throw lost;
                };
                Object.defineProperty(cjson, name, { configurable: true, enumerable: descriptor.enumerable, get: fail, set: fail });
            }

            throw lost;
        }

        for (const [name, descriptor] of state.fields) {
            Object.defineProperty(cjson, name, descriptor);
        }

        if (tables !== undefined) fill(cjson, tables);
        else replay(cjson, state.config, texts as string[]);
    } finally {
        drop(glue, state.id);
        engineStats.tablesFilled++;
    }
}

/** The engine's tables of `state`, or `undefined` if they cannot be had. */
function exportTables(state: NativeSamples): ExportedTables | undefined {
    try {
        return state.glue.jsonExport(state.id);
    } catch (e) {
        if (!isDiscarded(state.glue)) engineFailed(state.glue, e);
        return undefined;
    }
}

/**
 * The engine's tables into `cjson`'s (empty) ones, as `internString`,
 * `internObject` and `internArray` would have added them.
 */
function fill(cjson: any, tables: ExportedTables): void {
    const { strings, stringLengths, objects, objectOffsets, arrays, arrayOffsets } = tables;
    const stringList: string[] = cjson._strings;
    const stringIndexes: Record<string, number> = cjson._stringIndexes;
    let at = 0;
    for (let i = 0; i < stringLengths.length; i++) {
        const s = strings.slice(at, at + stringLengths[i]);
        at += stringLengths[i];
        stringList.push(s);
        // As `internString` does (for "__proto__", the inherited setter
        // ignores it, which is why TypeScript interns it every time).
        stringIndexes[s] = i;
    }

    const runs = (target: number[][], flat: Int32Array, offsets: Uint32Array): void => {
        for (let i = 0; i < offsets.length; i++) {
            const end = i + 1 < offsets.length ? offsets[i + 1] : flat.length;
            const run: number[] = [];
            for (let j = offsets[i]; j < end; j++) run.push(flat[j]);
            target.push(run);
        }
    };
    runs(cjson._objects, objects, objectOffsets);
    runs(cjson._arrays, arrays, arrayOffsets);
}

/**
 * The samples read by TypeScript's own `process`, in order, with the
 * configuration they were read with. Whatever `cjson` is in the middle of
 * (a read that touched a table first) is set aside meanwhile.
 */
function replay(cjson: any, config: Config, texts: string[]): void {
    // `_ctx` and `_rootValue` exist (as own fields) only once a read has
    // created them, as the engine's reads did for the samples replayed.
    const own = (name: string): boolean => Object.prototype.hasOwnProperty.call(cjson, name);
    const reading = (["_ctx", "_rootValue"] as const).filter(own).map((name) => [name, cjson[name]] as const);
    const stack: unknown[] = cjson._contextStack.splice(0);
    const current = {
        dateTimeRecognizer: cjson.dateTimeRecognizer,
        handleRefs: cjson.handleRefs,
        supportedIntegerRange: cjson.supportedIntegerRange,
    };
    try {
        for (const [name] of reading) cjson[name] = undefined;
        cjson.dateTimeRecognizer = config.recognizer;
        cjson.handleRefs = config.handleRefs;
        cjson.supportedIntegerRange = config.range;
        for (const text of texts) {
            cjson.process(JSON.parse(text));
            cjson.finish();
        }
    } finally {
        cjson.dateTimeRecognizer = current.dateTimeRecognizer;
        cjson.handleRefs = current.handleRefs;
        cjson.supportedIntegerRange = current.supportedIntegerRange;
        for (const [name, value] of reading) cjson[name] = value;
        for (const item of stack) cjson._contextStack.push(item);
    }
}

/** The tags of `Value`s that do not refer to the string table. */
function isSharedRoot(value: number): boolean {
    switch (value & 15) {
        case 1: // Null
        case 2: // False
        case 3: // True
        case 4: // Integer
        case 5: // Double
        case 7: // UninternedString
        case 8: // Object
        case 9: // Array
            return value > 0;
        default:
            return false;
    }
}

/**
 * A hold on `cjson`'s compressed form in `glue` for a run whose JSON
 * input has these root values, taken now, when the run is encoded: the
 * lease the run's request carries, which keeps the samples the run is
 * encoded with until it starts, whatever happens to `cjson` meanwhile (a
 * run on the TypeScript engine may fill its tables, which drops the
 * compressed form). `undefined` (after filling the TypeScript tables, if
 * the engine has read samples into `cjson`) if the run must send the
 * tables: the engine instance is another one, the configuration changed
 * since, or a root value is not one the engine returned. A run that does
 * not start lets go of its leases (`releaseLeases`).
 */
export function leaseSamples(cjson: any, glue: WasmGlue | undefined, roots: number[]): number | undefined {
    const state = states.get(cjson);
    if (state === undefined) return undefined;
    const config = configOf(cjson);
    if (
        glue === undefined ||
        state.glue !== glue ||
        isDiscarded(glue) ||
        config === undefined ||
        !sameConfig(state.config, config) ||
        !hasOnlyBuiltinFields(cjson) ||
        !roots.every(isSharedRoot)
    ) {
        materialize(cjson);
        return undefined;
    }

    let lease: number | undefined;
    try {
        lease = glue.jsonAcquire(state.id);
    } catch (e) {
        engineFailed(glue, e);
    }

    if (lease === undefined) materialize(cjson);
    return lease;
}

/**
 * Lets go of the leases of a run that is not going to `glue` after all,
 * or that started there (a lease the run took over is gone already).
 */
export function releaseLeases(glue: WasmGlue, leases: number[]): void {
    for (const lease of leases.splice(0)) {
        if (isDiscarded(glue)) return;
        try {
            glue.jsonRelease(lease);
        } catch (e) {
            engineFailed(glue, e);
        }
    }
}

/** `materialize`, then TypeScript reads the sample. */
function declined(cjson: object): undefined {
    materialize(cjson);
    return undefined;
}

/** The reader `CompressedJSONFromString.parseSync` asks first (see the top). */
function readSample(cjson: any, text: unknown): number | undefined {
    let state = states.get(cjson);
    if (state === undefined && (typeof text !== "string" || registry === undefined)) return undefined;
    if (typeof text !== "string" || engineMode() === "ts") return declined(cjson);
    if (Object.getPrototypeOf(cjson) !== CompressedJSONFromString.prototype || !hasOnlyBuiltinFields(cjson)) {
        return declined(cjson);
    }

    const config = configOf(cjson);
    if (config === undefined || !isWellFormed(text)) return declined(cjson);
    if (state === undefined) {
        const glue = engineForSample(text.length);
        if (glue === undefined) return undefined;
        state = start(cjson, config, glue);
        if (state === undefined) return undefined;
    } else if (isDiscarded(state.glue) || !sameConfig(state.config, config)) {
        return declined(cjson);
    }

    let value: number;
    try {
        value = state.glue.jsonRead(state.id, text);
    } catch (e) {
        engineFailed(state.glue, e);
        return declined(cjson);
    }

    if (value > 0) {
        state.textLength += text.length;
        if (state.texts !== undefined) {
            if (state.textLength <= keptTexts) state.texts.push(text);
            else state.texts = undefined;
        }

        engineStats.samplesRead++;
        // The fields TypeScript's `process` would have created.
        if ((value & 15) >= 8 && !Object.prototype.hasOwnProperty.call(cjson, "_ctx")) {
            cjson._ctx = undefined;
        }

        if (!Object.prototype.hasOwnProperty.call(cjson, "_rootValue")) {
            cjson._rootValue = undefined;
        }

        return value;
    }

    // Not JSON (0): `JSON.parse` throws V8's error, before the tables are
    // touched. Declined (-1): TypeScript reads it, and every sample after.
    return value === 0 ? undefined : declined(cjson);
}

installSampleReader(readSample);
