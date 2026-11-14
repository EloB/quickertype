// JSON samples read by the WebAssembly engine as they are added.
//
// `JSONInput.addSource`/`addSourceSync` parse each sample right away with
// `CompressedJSONFromString.parseSync`, which asks `readSample` first (the
// lines changed in src/input/CompressedJSON.ts). For a built-in
// `CompressedJSONFromString` and a string sample, the engine reads the text
// (crates/quicktype-wasm/src/samples.rs: the port's `JSON.parse`-semantics
// reader; a sample given as a `Uint8Array` is its UTF-8 bytes, which the
// engine reads as they are, `jsonReadBytes`, as the text `TextDecoder`
// would give) into a compressed form it keeps for every run that uses the
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
// filled (a `Uint8Array` decoded first, `sampleText` in hook.ts): samples
// that are neither strings nor `Uint8Array`s, strings that are not
// well-formed UTF-16; samples
// the engine declines (a string root value, whose index depends on
// TypeScript's string table; nesting deeper than its limit, where
// TypeScript's recursive `process` could run out of stack; a `\u` escape
// that leaves a surrogate unpaired); a `CompressedJSON` that is not exactly
// a `CompressedJSONFromString` with the methods it had when this module
// loaded, an unmodified built-in date/time recognizer (`dateTimeKind`) and
// a valid integer range, or that has tables already; a host without
// `FinalizationRegistry`; samples read while the TypeScript engine is
// forced; and samples read while the engine is not compiled yet (see
// `engineForSample`). A sample that is not JSON is not read by the engine
// either: TypeScript's `JSON.parse` then throws V8's own error, from
// `addSource`, as before.
//
// The compressed forms of all inputs but the one just read into together
// hold at most `heldLimit` bytes of the engine's memory (`evict`): past
// that, the tables of those that do not fit, least recently used first,
// are copied to JavaScript, where the garbage collector sees them, and the
// forms are freed in the engine. The garbage collector does not see the
// engine's memory, which never shrinks, so a long-running process cannot
// rely on it to collect inputs before that memory runs out.
//
// The README ("JSON samples") has the argument for why this cannot be told
// apart from TypeScript reading the samples.

import { CompressedJSONFromString, Tag, valueTag } from "../input/CompressedJSON.js";

import { engineFailed, engineStats } from "./bridge.js";
import { dateTimeKind, hasOnlyBuiltinFields, isWellFormed } from "./encode.js";
import { engineIfCompiled, engineMode, engineSync, isDiscarded } from "./engine.js";
import { decodeUtf8, installSampleReader, isBytes, passDecoded, sampleText } from "./hook.js";
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
     * How many own properties it had when the engine started on it,
     * without the fields a read creates (see `readsAsStarted`).
     */
    readonly ownProperties: number;
    /**
     * Every sample the engine read into these tables, in order (a copy of
     * the bytes of one given as a `Uint8Array`), while they add up to at
     * most `keptTexts` code units or bytes; `undefined` after that. Only
     * for an engine instance that fails (see `materialize`).
     */
    texts: Array<string | Uint8Array> | undefined;
    /** The code units (or bytes) of the samples read. */
    textLength: number;
    /**
     * The bytes of its form, as `jsonHeld` counts them: what it added to
     * that count when it was created and with each read (`evict`), and
     * after each run (`afterRun`).
     */
    bytes: number;
    /** The table fields as they were (empty), restored by `materialize`. */
    readonly fields: Array<[string, PropertyDescriptor]>;
    /**
     * The tables, once the form was evicted (`evict`): the engine no
     * longer has it, and `materialize` fills the fields from these.
     */
    exported?: ExportedTables;
    /**
     * The `CompressedJSON`, weakly (where the host has `WeakRef`): once it
     * no longer dereferences, nothing can reach the form, which `evict`
     * then drops instead of exporting its tables.
     */
    readonly owner: { deref(): object | undefined } | undefined;
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
 * The most bytes the compressed forms in an engine instance may hold
 * together (`jsonHeld`, the capacities of their tables and the tallies
 * runs kept with them, see `afterRun`), but for the one
 * a sample was just read into, before the least recently used are evicted
 * (`evict`): 256 MiB. That is the form of about 190 MB of JSON samples (a
 * 104 MB sample takes 138 MiB), more than the inputs of nearly any
 * program are at once, so that eviction is a backstop for inputs the
 * garbage collector has not collected yet, not something runs normally
 * pay for (an evicted input's runs send its tables, which costs what the
 * engine reading its samples saved). It leaves most of the
 * instance's 4 GiB to reading samples and to runs, which need more than
 * the forms they make or use while they last (reading that sample peaks
 * at 461 MiB with its form; a run on it needs 114 MiB besides). The form
 * just read into is not counted (it is the one in use), so the forms hold
 * at most the limit plus that one; the engine's memory never shrinks, so
 * a long-running process keeps about the limit plus the largest of those.
 */
let heldLimit = 256 * 1024 * 1024;

/** For tests: the limit of the forms' bytes (`heldLimit`); returns the old one. */
export function setHeldLimit(bytes: number): number {
    const old = heldLimit;
    heldLimit = bytes;
    return old;
}

/**
 * For tests: the bytes of `cjson`'s form in the engine
 * (`NativeSamples.bytes`), or `undefined` if the engine has none for it.
 */
export function formBytes(cjson: object): number | undefined {
    const state = states.get(cjson);
    return state === undefined || state.exported !== undefined ? undefined : state.bytes;
}

/**
 * The size from which a sample is worth compiling the engine for, in code
 * units (see `engineForSample`).
 */
const compileForSample = 1 << 20;

const states = new WeakMap<object, NativeSamples>();

/**
 * The `internArray` of each `CompressedJSON` the engine started on, as it
 * was then (`readsAsStarted`). Not in its `NativeSamples`, which the
 * `FinalizationRegistry` holds: the arrow function holds the
 * `CompressedJSON`, which could then never be collected.
 */
const internArrays = new WeakMap<object, unknown>();

/**
 * Every `NativeSamples` whose form the engine keeps, least recently used
 * (read into, or leased by a run) first.
 */
const recent = new Set<NativeSamples>();

/** Marks `state` as used last. */
function touch(state: NativeSamples): void {
    recent.delete(state);
    recent.add(state);
}

/**
 * What `jsonReadBytes` returns for bytes that are not UTF-8 (nothing is
 * read; crates/quicktype-wasm/src/samples.rs, `NOT_UTF8`).
 */
const notUtf8 = -2;

/** The fields a sample changes when TypeScript reads it. */
const tableFields = ["_strings", "_stringIndexes", "_objects", "_arrays"];

/**
 * Not public (the playground's workers use it): frees the engine's
 * compressed form of `input`'s `CompressedJSON` now, instead of when the
 * garbage collector has finalized the input, so that it no longer counts
 * toward `heldLimit` (an input that is gone but not finalized yet would be
 * evicted, its tables exported, when the next one is read). The input must
 * not be used afterwards: its samples are gone, and reading its tables, or
 * a run on it, throws. A run that holds the form keeps it until it ends.
 */
export function releaseJSONInput(input: any): void {
    const cjson = input?._compressedJSON;
    const state = cjson === undefined || cjson === null ? undefined : states.get(cjson);
    if (state === undefined) return;
    states.delete(cjson);
    recent.delete(state);
    registry.unregister(state);
    const released = new Error("quicktype-core: the JSON samples of this input were released");
    for (const [name, descriptor] of state.fields) {
        const fail = (): never => {
            throw released;
        };
        Object.defineProperty(cjson, name, { configurable: true, enumerable: descriptor.enumerable, get: fail, set: fail });
    }

    if (state.exported === undefined) {
        drop(state.glue, state.id);
        engineStats.dropped++;
    }
}

/**
 * Not public (the playground's workers use it): how `input`'s samples are
 * read, as a string that two JSON inputs share exactly when their
 * `CompressedJSON`s read samples the same way (the configuration the
 * engine reads them with: the built-in date/time recognizer, whether `$ref`s
 * are references, and the integer range); `undefined` for an input that
 * is not one of `jsonInputForTargetLanguage`'s, or whose configuration
 * the engine does not model.
 */
export function readingKey(input: any): string | undefined {
    const cjson = input?._compressedJSON;
    if (cjson === undefined || cjson === null || Object.getPrototypeOf(cjson) !== CompressedJSONFromString.prototype) return undefined;
    const config = configOf(cjson);
    if (config === undefined) return undefined;
    return JSON.stringify([config.dateTime, !!config.handleRefs, config.range]);
}

/** `WeakRef`, where the host has it. */
const WeakRefClass: (new (target: object) => { deref(): object | undefined }) | undefined = (() => {
    const WeakRefConstructor = (globalThis as any).WeakRef;
    return typeof WeakRefConstructor === "function" ? WeakRefConstructor : undefined;
})();

/** Engine compressed forms whose `CompressedJSON` was collected. */
const registry: any = (() => {
    const Registry = (globalThis as any).FinalizationRegistry;
    if (typeof Registry !== "function") return undefined;
    return new Registry(forget);
})();

/** Frees `state`'s form in the engine: its `CompressedJSON` is gone. */
function forget(state: NativeSamples): void {
    recent.delete(state);
    drop(state.glue, state.id);
}

function drop(glue: WasmGlue, id: number): void {
    if (isDiscarded(glue)) return;
    try {
        glue.jsonDrop(id);
    } catch (e) {
        engineFailed(glue, e);
    }
}

/** `CompressedJSON.prototype`, which `CompressedJSONFromString` extends. */
const compressedJSONPrototype: object = Object.getPrototypeOf(CompressedJSONFromString.prototype);

/**
 * The methods TypeScript's read of a sample calls (`parseSync` calls
 * `process` and `finish`, which call the rest), as an instance of
 * `CompressedJSONFromString` finds them when this module loads: the
 * engine's read stands in for all of them, so it reads a sample only while
 * each is still the original (`prototypesAsLoaded`, for every sample).
 * Named one by one: in a loop over their names, each is a lookup by key,
 * which took a third of the time a small sample takes. (The others,
 * `parse`, `parseSync`, `getStringForValue`, `getStringFormatTypeKind`,
 * `equals` and `hashCode`, are not part of the read; the test "every
 * method TypeScript's read calls is the original" fails if upstream adds
 * one.)
 */
const readMethods = (() => {
    const p: any = CompressedJSONFromString.prototype;
    return {
        process: p.process,
        finish: p.finish,
        commitValue: p.commitValue,
        commitNull: p.commitNull,
        commitBoolean: p.commitBoolean,
        commitNumber: p.commitNumber,
        commitString: p.commitString,
        makeString: p.makeString,
        internString: p.internString,
        internObject: p.internObject,
        pushContext: p.pushContext,
        pushObjectContext: p.pushObjectContext,
        pushArrayContext: p.pushArrayContext,
        setPropertyKey: p.setPropertyKey,
        finishObject: p.finishObject,
        finishArray: p.finishArray,
        popContext: p.popContext,
        parsedNumberIsDouble: p.parsedNumberIsDouble,
        integerStringFits: p.integerStringFits,
    };
})();

/** The getter of `CompressedJSON`'s accessor `name`. */
function getterOf(name: string): unknown {
    return Object.getOwnPropertyDescriptor(compressedJSONPrototype, name)?.get;
}

/** The getters the read calls (`CompressedJSON`'s), as loaded. */
const readGetters = { context: getterOf("context"), isExpectingRef: getterOf("isExpectingRef") };

/**
 * The source of `internArray`, which `finishArray` calls: unlike the other
 * methods, a field each instance gets its own arrow function in (so `start`
 * compares its source, and `readsAsStarted` that it is the same function).
 */
const internArraySource = Function.prototype.toString.call(
    (new CompressedJSONFromString(undefined as any, false) as any).internArray,
);

/**
 * Whether `CompressedJSONFromString`'s prototypes still have the methods
 * the read calls that they had when this module loaded (`readMethods`,
 * `readGetters`), and are still linked as they were. Looked up on the
 * prototype, not on an instance: an instance the engine started on has
 * accessors for fields, which leaves its properties slow to look up. That
 * an instance has no method of its own is checked with its own properties
 * (`hasOnlyBuiltinFields` in `start`, and `readsAsStarted`), but for
 * `internArray`, which every instance has.
 */
function prototypesAsLoaded(): boolean {
    const p: any = CompressedJSONFromString.prototype;
    const m = readMethods;
    return (
        Object.getPrototypeOf(p) === compressedJSONPrototype &&
        p.process === m.process &&
        p.finish === m.finish &&
        p.commitValue === m.commitValue &&
        p.commitNull === m.commitNull &&
        p.commitBoolean === m.commitBoolean &&
        p.commitNumber === m.commitNumber &&
        p.commitString === m.commitString &&
        p.makeString === m.makeString &&
        p.internString === m.internString &&
        p.internObject === m.internObject &&
        p.pushContext === m.pushContext &&
        p.pushObjectContext === m.pushObjectContext &&
        p.pushArrayContext === m.pushArrayContext &&
        p.setPropertyKey === m.setPropertyKey &&
        p.finishObject === m.finishObject &&
        p.finishArray === m.finishArray &&
        p.popContext === m.popContext &&
        p.parsedNumberIsDouble === m.parsedNumberIsDouble &&
        p.integerStringFits === m.integerStringFits &&
        !Object.prototype.hasOwnProperty.call(p, "context") &&
        !Object.prototype.hasOwnProperty.call(p, "isExpectingRef") &&
        getterOf("context") === readGetters.context &&
        getterOf("isExpectingRef") === readGetters.isExpectingRef
    );
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

/**
 * Whether `cjson` reads its next sample as with `config`, which `configOf`
 * made: compared with it, without making another (strings equal to its
 * range's are well-formed, too).
 */
function sameConfig(config: Config, cjson: any): boolean {
    const range = cjson.supportedIntegerRange;
    return (
        dateTimeKind(cjson.dateTimeRecognizer) === config.dateTime &&
        !!cjson.handleRefs === !!config.handleRefs &&
        (range === null
            ? config.range === null
            : config.range !== null &&
              typeof range === "object" &&
              range.min === config.range.min &&
              range.max === config.range.max)
    );
}

/** The own properties of `cjson`, without the fields a read creates. */
function ownProperties(cjson: object): number {
    const own = (name: string): number => (Object.prototype.hasOwnProperty.call(cjson, name) ? 1 : 0);
    return Object.getOwnPropertyNames(cjson).length - own("_ctx") - own("_rootValue");
}

/**
 * Whether `cjson` still reads samples as when the engine started on it
 * (`start` checked it then): the same prototype, no own property added
 * since (a method replaced on the instance), the original methods (none
 * replaced on a prototype since), and the same configuration.
 */
function readsAsStarted(cjson: any, state: NativeSamples): boolean {
    return (
        Object.getPrototypeOf(cjson) === CompressedJSONFromString.prototype &&
        ownProperties(cjson) === state.ownProperties &&
        cjson.internArray === internArrays.get(cjson) &&
        prototypesAsLoaded() &&
        sameConfig(state.config, cjson)
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
 * The engine instance to read sample `text` on, if reading it there is
 * worth it. Samples never wait for the engine to be compiled where that
 * is asynchronous (browsers), and in Node a sample compiles it only if it
 * is large: compiling takes some 20 ms of CPU, a run that goes to the
 * TypeScript engine (a custom language, say) gains nothing from it, and a
 * small sample reads about as fast in TypeScript. Once the engine is
 * compiled (by the first run that uses it, or a large sample), every
 * sample is read there; instantiating it is cheap, and a run would do it
 * anyway. Only then is the text scanned for lone surrogates (the engine
 * reads it as UTF-8), and before a large sample compiles the engine.
 */
function engineForSample(sample: string | Uint8Array): WasmGlue | undefined {
    const compiled = engineIfCompiled();
    if (compiled === undefined && sample.length < compileForSample) return undefined;
    if (typeof sample === "string" && !isWellFormed(sample)) return undefined;
    return compiled ?? engineSync();
}

/**
 * Starts reading `cjson`'s samples on the engine, if it is exactly a
 * fresh `CompressedJSONFromString` (see the top) with its original
 * methods, for sample `text`: a compressed form in the engine, and the
 * table fields replaced by accessors that fill them on first use. What is
 * checked here holds for the later samples as long as `readsAsStarted`.
 */
function start(cjson: any, text: string | Uint8Array): NativeSamples | undefined {
    if (
        Object.getPrototypeOf(cjson) !== CompressedJSONFromString.prototype ||
        !hasOnlyBuiltinFields(cjson) ||
        !prototypesAsLoaded() ||
        typeof cjson.internArray !== "function" ||
        Function.prototype.toString.call(cjson.internArray) !== internArraySource
    ) {
        return undefined;
    }

    const config = configOf(cjson);
    if (config === undefined || !isFresh(cjson)) return undefined;
    const glue = engineForSample(text);
    if (glue === undefined) return undefined;
    let id: number | undefined;
    let bytes = 0;
    try {
        const held = glue.jsonHeld();
        id = glue.jsonCreate(config.dateTime, !!config.handleRefs, config.range?.min, config.range?.max);
        bytes = glue.jsonHeld() - held;
    } catch (e) {
        engineFailed(glue, e);
        return undefined;
    }

    // As many inputs at once as the engine takes: TypeScript reads this one.
    if (id === undefined) return undefined;
    const fields: Array<[string, PropertyDescriptor]> = [];
    const state: NativeSamples = {
        glue,
        id,
        config,
        ownProperties: ownProperties(cjson),
        texts: [],
        textLength: 0,
        bytes,
        fields,
        owner: WeakRefClass === undefined ? undefined : new WeakRefClass(cjson),
    };
    internArrays.set(cjson, cjson.internArray);
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
    registry.register(cjson, state, state);
    touch(state);
    return state;
}

/**
 * Keeps the forms in `current`'s engine instance within `heldLimit`
 * bytes after a sample was read into the one form of `current`, or a run
 * used the forms of `current` (when the instance holds `held` bytes in
 * all, and `current` their bytes up to date). `current` is exempt,
 * however large: the limit is on the others together. If they are past
 * it, they are kept
 * most recently used first, each one as long as it still fits beside
 * those kept before it, and the others are evicted. So a form past the
 * limit on its own (one large input read in many samples, say) evicts
 * nothing while it is read into, and is the one evicted once another
 * input is read, rather than every smaller form used before it.
 *
 * An evicted form's tables are exported to JavaScript
 * (`NativeSamples.exported`) and the form is freed in the engine; its
 * `CompressedJSON` gets those tables when anything first uses it
 * (`materialize`), and is an ordinary one from then on. A form whose
 * `CompressedJSON` was collected already (its `WeakRef` no longer
 * dereferences, though its finalizer has not run yet) is dropped first,
 * without exporting anything: nothing can reach it. One that is gone but
 * not collected yet cannot be told from one in use (a `WeakRef` keeps its
 * target alive until the job that made or read it ends, which in a loop of
 * `await`s is the whole loop), so its tables are exported, where the
 * garbage collector sees them, and collected with it.
 */
function evict(current: NativeSamples[], held: number): void {
    if (current.length === 0) return;
    const { glue } = current[0];
    // The bytes of the others not looked at yet, and of those kept.
    let rest = held - current.reduce((sum, state) => sum + state.bytes, 0);
    let kept = 0;
    if (rest <= heldLimit) return;
    try {
        // Forms nothing can reach any more (their `CompressedJSON` was
        // collected, and is not finalized yet) are dropped first: no use
        // of them is left to give their tables to.
        for (const state of [...recent]) {
            if (current.includes(state) || state.glue !== glue || state.owner === undefined || state.owner.deref() !== undefined) continue;
            rest -= state.bytes;
            recent.delete(state);
            registry.unregister(state);
            drop(glue, state.id);
            engineStats.dropped++;
        }

        for (const state of [...recent].reverse()) {
            if (current.includes(state) || state.glue !== glue) continue;
            if (kept + rest <= heldLimit) return;
            rest -= state.bytes;
            if (kept + state.bytes <= heldLimit) {
                kept += state.bytes;
                continue;
            }

            const tables = exportTables(state);
            // The instance failed: `materialize` takes it from there.
            if (tables === undefined) return;
            state.exported = tables;
            state.texts = undefined;
            recent.delete(state);
            registry.unregister(state);
            drop(glue, state.id);
            engineStats.evicted++;
        }
    } catch (e) {
        engineFailed(glue, e);
    }
}

/**
 * Fills `cjson`'s TypeScript tables, if the engine has read samples into
 * it: the fields become plain again and get the engine's tables (or those
 * exported when the form was evicted), which are the ones TypeScript
 * builds from the same samples (one conversion, no parsing). Afterwards
 * `cjson` is an ordinary `CompressedJSON`: its samples are read by
 * TypeScript, and runs send its tables.
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
    recent.delete(state);
    registry.unregister(state);
    const { glue, texts, exported } = state;
    try {
        const tables = exported ?? (isDiscarded(glue) && texts !== undefined ? undefined : exportTables(state));
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
        else replay(cjson, state.config, texts as Array<string | Uint8Array>);
        // Only tables that were filled.
        engineStats.tablesFilled++;
    } finally {
        if (exported === undefined) drop(glue, state.id);
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
function replay(cjson: any, config: Config, texts: Array<string | Uint8Array>): void {
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
            cjson.process(JSON.parse(sampleText(text) as string));
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

/** Whether `value` is one the engine returns: not a string's index. */
function isSharedRoot(value: number): boolean {
    if (value <= 0) return false;
    switch (valueTag(value)) {
        case Tag.Null:
        case Tag.False:
        case Tag.True:
        case Tag.Integer:
        case Tag.Double:
        case Tag.UninternedString:
        case Tag.Object:
        case Tag.Array:
            return true;
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
    if (
        glue === undefined ||
        state.glue !== glue ||
        isDiscarded(glue) ||
        state.exported !== undefined ||
        !readsAsStarted(cjson, state) ||
        !roots.every(isSharedRoot)
    ) {
        materialize(cjson);
        return undefined;
    }

    touch(state);
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
 * After a run on `glue` that used the forms of `cjsons` (`leaseSamples`):
 * their bytes as the engine counts them now, and then the other forms
 * kept within `heldLimit`, with all of these the ones in use. A run keeps
 * the tallies it inferred the types from with each form, for the next run
 * on the same samples (the next sample read into it drops them), and the
 * engine counts them in the form's bytes when the run ends (`jsonBytes`).
 * Every form's bytes are taken up before any eviction, which would
 * otherwise count one form's new tallies against the others.
 */
export function afterRun(glue: WasmGlue, cjsons: object[]): void {
    if (isDiscarded(glue)) return;
    const used: NativeSamples[] = [];
    try {
        for (const cjson of cjsons) {
            const state = states.get(cjson);
            if (state === undefined || state.glue !== glue || state.exported !== undefined || used.includes(state)) continue;
            const bytes = glue.jsonBytes(state.id);
            if (bytes === undefined) continue;
            state.bytes = bytes;
            used.push(state);
        }

        evict(used, glue.jsonHeld());
    } catch (e) {
        engineFailed(glue, e);
    }
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

/**
 * `jsonRead` (or `jsonReadBytes`) of `sample` into `state`'s form: what it
 * returned, and what the forms hold afterwards; `undefined` if the engine
 * failed (it is discarded).
 */
function readOnEngine(state: NativeSamples, sample: string | Uint8Array): { value: number; held: number } | undefined {
    const { glue, id } = state;
    try {
        const before = glue.jsonHeld();
        const value = typeof sample === "string" ? glue.jsonRead(id, sample) : glue.jsonReadBytes(id, sample);
        const held = glue.jsonHeld();
        state.bytes += held - before;
        return { value, held };
    } catch (e) {
        engineFailed(glue, e);
        return undefined;
    }
}

/** The reader `CompressedJSONFromString.parseSync` asks first (see the top). */
function readSample(cjson: any, sample: unknown): number | undefined {
    passDecoded(undefined);
    let state = states.get(cjson);
    const bytes = isBytes(sample);
    if ((typeof sample !== "string" && !bytes) || engineMode() === "ts") return declined(cjson);
    let text = sample as string | Uint8Array;
    // A string is scanned for lone surrogates only once the engine is to
    // read it (here, or in `start`); bytes are checked by the engine.
    if (state === undefined) {
        if (registry === undefined) return undefined;
        state = start(cjson, text);
        if (state === undefined) return undefined;
    } else if (
        state.exported !== undefined ||
        isDiscarded(state.glue) ||
        !readsAsStarted(cjson, state) ||
        (typeof text === "string" && !isWellFormed(text))
    ) {
        return declined(cjson);
    }

    let read = readOnEngine(state, text);
    if (read?.value === notUtf8) {
        // What the decoder replaces is read as it replaces it. Decoded here,
        // outside the engine's calls: what the decoder throws (a text
        // longer than the longest string) is the input's, thrown from
        // `addSource` as TypeScript's own decoding of it would be. Nothing
        // was read.
        text = decodeUtf8(text as Uint8Array);
        read = readOnEngine(state, text);
        if (read === undefined || read.value <= 0) {
            // `parseSync` then parses this text, without decoding it again.
            const result = read === undefined || read.value !== 0 ? declined(cjson) : undefined;
            passDecoded(sample as Uint8Array, text);
            return result;
        }
    }

    if (read === undefined) return declined(cjson);
    const { value, held } = read;

    if (value > 0) {
        state.textLength += text.length;
        if (state.texts !== undefined) {
            // A copy of the bytes: the caller may change them afterwards.
            if (state.textLength <= keptTexts) state.texts.push(typeof text === "string" ? text : new Uint8Array(text));
            else state.texts = undefined;
        }

        engineStats.samplesRead++;
        // The fields TypeScript's `process` would have created.
        const tag = valueTag(value);
        if ((tag === Tag.Object || tag === Tag.Array) && !Object.prototype.hasOwnProperty.call(cjson, "_ctx")) {
            cjson._ctx = undefined;
        }

        if (!Object.prototype.hasOwnProperty.call(cjson, "_rootValue")) {
            cjson._rootValue = undefined;
        }

        touch(state);
        evict([state], held);
        return value;
    }

    // Not JSON (0): `JSON.parse` throws V8's error, before the tables are
    // touched. Declined (-1): TypeScript reads it, and every sample after.
    return value === 0 ? undefined : declined(cjson);
}

installSampleReader(readSample);
