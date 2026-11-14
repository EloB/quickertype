// Deciding whether a run can go to the WebAssembly engine, and encoding it
// (research 05, sections 2 and 4.2).
//
// A run is eligible when everything it involves is a built-in the Rust
// engine reproduces exactly: the target language is one of quicktype's
// own (not a subclass, not modified), every input is an exact `JSONInput`
// over a `CompressedJSONFromString` (or a class registered under
// `Symbol.for("quicktype-core.nativeInputs")`, such as the CLI's stream
// reader) with an unmodified built-in date/time recognizer, or an exact
// `JSONSchemaInput` without extra attribute producers, and every option
// value is one the engine models (renderer options are lowered here, by
// the rules of `Option.getValue`/`BooleanOption.getValue`/
// `EnumOption.getEnumValue`). Every other run uses the TypeScript engine,
// which gives the same result by construction.
//
// The request carries JSON samples as a lease on the compressed form the
// engine read them into as they were added (samples.ts), taken here, or
// else as the tables of their `CompressedJSON` (parsed with `JSON.parse`
// and V8's error messages), and JSON Schema inputs as their already
// normalized sources; the schemas themselves stay in JavaScript and are
// fetched through the input's own store while the engine runs.

import { DefaultDateTimeRecognizer } from "../DateTime.js";
import { CompressedJSONFromString } from "../input/CompressedJSON.js";
import { InputData, JSONInput } from "../input/Inputs.js";
import { JSONSchemaInput, Ref } from "../input/JSONSchemaInput.js";
import { all as defaultTargetLanguages } from "../language/All.js";
import { KotlinDateTimeRecognizer } from "../language/Kotlin/utils.js";
import { SwiftDateTimeRecognizer } from "../language/Swift/utils.js";
import type { TargetLanguage } from "../TargetLanguage.js";

import { currentEngine } from "./engine.js";
import { leaseSamples, releaseLeases } from "./samples.js";
import type { WasmGlue } from "./wasm/glue.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the bridge reads private fields of the facade's objects

/** What the engine receives (crates/quicktype-wasm/src/js.rs). */
export interface EncodedRun {
    request: Record<string, unknown>;
    /** The JSON Schema inputs, by `storeId`. */
    schemaInputs: JSONSchemaInput[];
    /**
     * The engine instance holding the samples of `jsonShared` inputs: the
     * run must go to that instance (or to the TypeScript engine).
     */
    sharedGlue?: WasmGlue;
    /**
     * The leases of `jsonShared` inputs on their samples in `sharedGlue`:
     * the run takes them over when it starts there; otherwise they must
     * be released (`releaseLeases`).
     */
    leases: number[];
    /**
     * The `CompressedJSON`s of those inputs, whose forms the run may
     * change (`afterRun`).
     */
    shared: object[];
}

const nativeInputsKey = Symbol.for("quicktype-core.nativeInputs");

/** `CompressedJSON` classes whose tables mean what the built-in's do. */
function isNativeCompressedJSON(cjson: unknown): boolean {
    if (cjson === null || typeof cjson !== "object") return false;
    const proto = Object.getPrototypeOf(cjson);
    if (proto === CompressedJSONFromString.prototype) return true;
    const registered = (globalThis as any)[nativeInputsKey];
    return (
        Array.isArray(registered) &&
        registered.some(
            (c: unknown) => typeof c === "function" && c.prototype === proto,
        )
    );
}

/** The methods of a date/time recognizer (`DateTimeRecognizer`). */
interface RecognizerMethods {
    isDate: unknown;
    isTime: unknown;
    isDateTime: unknown;
}

/** The methods of a recognizer whose prototype is `proto`. */
function recognizerMethodsOf(proto: any): RecognizerMethods {
    return { isDate: proto.isDate, isTime: proto.isTime, isDateTime: proto.isDateTime };
}

/** A built-in date/time recognizer class, as loaded. */
interface BuiltinRecognizer {
    /** Its name in the request (`DateTimeKind`, crates/quicktype-wasm/src/wire.rs). */
    kind: string;
    /** The prototype its prototype extends. */
    parent: unknown;
    /** Its methods, as an instance of it finds them. */
    methods: RecognizerMethods;
}

/**
 * The built-in date/time recognizers the engine has, by prototype, with
 * their methods captured when this module loads: those are the ones the
 * engine's recognizers reproduce.
 */
const builtinRecognizers = new Map<unknown, BuiltinRecognizer>(
    (
        [
            [DefaultDateTimeRecognizer, "default"],
            [KotlinDateTimeRecognizer, "kotlin"],
            [SwiftDateTimeRecognizer, "swift"],
        ] as const
    ).map(([c, kind]) => [
        c.prototype,
        { kind, parent: Object.getPrototypeOf(c.prototype), methods: recognizerMethodsOf(c.prototype) },
    ]),
);

/**
 * `DefaultDateTimeRecognizer`'s methods, which Kotlin's and Swift's
 * recognizers call too (`super.isDate`).
 */
const defaultRecognizerMethods = recognizerMethodsOf(DefaultDateTimeRecognizer.prototype);

/**
 * The name of the built-in date/time recognizer `recognizer` is, if it is
 * one exactly: an instance of a built-in class, without own properties (no
 * method replaced on the instance), whose methods are still the ones that
 * class had when this module loaded (none replaced on a prototype). For
 * anything else, the TypeScript engine reads samples and runs, calling the
 * recognizer's methods as they are. (Called for every sample: the methods
 * are compared by name, which is cheaper than by key in a loop.)
 */
export function dateTimeKind(recognizer: unknown): string | undefined {
    if (recognizer === null || typeof recognizer !== "object") {
        return undefined;
    }

    const proto = Object.getPrototypeOf(recognizer);
    const builtin = builtinRecognizers.get(proto);
    if (builtin === undefined || Object.getPrototypeOf(proto) !== builtin.parent) return undefined;
    const r = recognizer as any;
    const m = builtin.methods;
    const d = DefaultDateTimeRecognizer.prototype as any;
    const dm = defaultRecognizerMethods;
    if (
        r.isDate !== m.isDate ||
        r.isTime !== m.isTime ||
        r.isDateTime !== m.isDateTime ||
        d.isDate !== dm.isDate ||
        d.isTime !== dm.isTime ||
        d.isDateTime !== dm.isDateTime ||
        Object.getOwnPropertyNames(recognizer).length !== 0
    ) {
        return undefined;
    }

    return builtin.kind;
}

/** The own property names of `x`, but `except`, sorted. */
function ownNames(x: object, except: readonly string[] = []): string {
    return Object.getOwnPropertyNames(x)
        .filter((name) => !except.includes(name))
        .sort()
        .join(",");
}

let builtinLanguages: Map<unknown, TargetLanguage> | undefined;

/** The canonical name of a built-in, unmodified language instance. */
export function builtinLanguageName(lang: TargetLanguage): string | undefined {
    if (builtinLanguages === undefined) {
        builtinLanguages = new Map(
            defaultTargetLanguages.map((l) => [Object.getPrototypeOf(l), l]),
        );
    }

    const builtin = builtinLanguages.get(Object.getPrototypeOf(lang));
    if (builtin === undefined) return undefined;
    if (lang !== builtin) {
        if (
            lang.displayName !== builtin.displayName ||
            lang.extension !== builtin.extension ||
            !Array.isArray(lang.names) ||
            lang.names.join("\u0000") !== builtin.names.join("\u0000") ||
            ownNames(lang) !== ownNames(builtin)
        ) {
            return undefined;
        }
    }

    return builtin.name;
}

let expectedOwnNames: Map<unknown, string> | undefined;

/** The fields a read creates on a `CompressedJSON` (`process` and `finish`). */
const readingFields = ["_ctx", "_rootValue"];

/**
 * Whether `x` has the own properties a fresh instance of its class has, and
 * no others (no method replaced on the instance), for the built-in classes
 * the engine reads: `JSONInput`, `JSONSchemaInput` and
 * `CompressedJSONFromString` (which may also have the fields reading a
 * sample creates).
 */
export function hasOnlyBuiltinFields(x: object): boolean {
    if (expectedOwnNames === undefined) {
        const cjson = (): CompressedJSONFromString => new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false);
        expectedOwnNames = new Map<unknown, string>([
            [JSONInput.prototype, ownNames(new JSONInput(cjson()))],
            [JSONSchemaInput.prototype, ownNames(new JSONSchemaInput(undefined))],
            [CompressedJSONFromString.prototype, ownNames(cjson(), readingFields)],
        ]);
    }

    const proto = Object.getPrototypeOf(x);
    const except = proto === CompressedJSONFromString.prototype ? readingFields : [];
    return expectedOwnNames.get(proto) === ownNames(x, except);
}

/** JavaScript truthiness. */
function truthy(x: unknown): boolean {
    return !!x;
}

/**
 * Whether `s` is well-formed UTF-16 (no lone surrogates).
 * `String.prototype.isWellFormed` where the host has it.
 */
export function isWellFormed(s: string): boolean {
    const native = (s as any).isWellFormed;
    if (typeof native === "function") return native.call(s);
    for (let i = 0; i < s.length; i++) {
        const c = s.charCodeAt(i);
        if (c < 0xd800 || c > 0xdfff) continue;
        if (c > 0xdbff) return false;
        const next = s.charCodeAt(i + 1);
        if (!(next >= 0xdc00 && next <= 0xdfff)) return false;
        i++;
    }

    return true;
}

class Ineligible {}
const ineligible = new Ineligible();

/**
 * Every string of the request must be well-formed: the engine's strings
 * are UTF-8, so a lone surrogate (which `JSON.parse` accepts) would arrive
 * as U+FFFD and could merge distinct keys or names.
 */
function checkStrings(value: unknown, depth = 0): void {
    if (typeof value === "string") {
        if (!isWellFormed(value)) fail();
    } else if (Array.isArray(value)) {
        for (const item of value) checkStrings(item, depth + 1);
    } else if (value !== null && typeof value === "object" && !ArrayBuffer.isView(value) && depth < 64) {
        for (const key of Object.keys(value)) {
            checkStrings(key, depth + 1);
            checkStrings((value as any)[key], depth + 1);
        }
    }
}

function fail(): never {
    throw ineligible;
}

/**
 * The renderer options as the engine models them: only `null`, booleans
 * and strings, keyed by the option names the language reads.
 */
function lowerRendererOptions(
    lang: TargetLanguage,
    values: unknown,
): [string[], unknown[]] {
    const names: string[] = [];
    const lowered: unknown[] = [];
    if (values === undefined || values === null) return [names, lowered];
    if (typeof values !== "object") fail();
    const record = values as Record<string, unknown>;
    const push = (name: string, value: unknown): void => {
        names.push(name);
        lowered.push(value);
    };

    for (const definition of lang.optionDefinitions) {
        const name = definition.name;
        const value = record[name];
        switch (definition.optionType) {
            case "boolean": {
                // BooleanOption.getValue: "true"/"false" are parsed, the rest
                // only matters through its truthiness.
                for (const key of [name, `no-${name}`]) {
                    const v = record[key];
                    if (v === undefined) continue;
                    if (v === null || typeof v === "string" || typeof v === "boolean") {
                        push(key, v);
                    } else {
                        push(key, truthy(v));
                    }
                }

                break;
            }

            case "string": {
                // Option.getValue: `values[name] ?? default`, used as text.
                if (value === undefined || value === null) break;
                if (typeof value !== "string") fail();
                push(name, value);
                break;
            }

            case "enum": {
                // EnumOption.getEnumValue: falsy means the default, then
                // `name in values`, which also sees Object.prototype.
                if (value === undefined || value === null) break;
                if (!value) {
                    push(name, false);
                    break;
                }

                if (typeof value !== "string") fail();
                const enumValues = (definition as any).values;
                if (
                    enumValues !== null &&
                    typeof enumValues === "object" &&
                    value in enumValues &&
                    !Object.prototype.hasOwnProperty.call(enumValues, value)
                ) {
                    fail();
                }

                push(name, value);
                break;
            }

            default:
                fail();
        }
    }

    return [names, lowered];
}

/** A `Sourcelike` made of strings only. */
function encodeSourcelike(sl: unknown, depth = 0): unknown {
    if (typeof sl === "string") return sl;
    if (Array.isArray(sl) && depth < 32) {
        return sl.map((s) => encodeSourcelike(s, depth + 1));
    }

    return fail();
}

function encodeSourcelikes(lines: unknown): unknown[] {
    if (!Array.isArray(lines)) fail();
    return lines.map((l) => encodeSourcelike(l));
}

const commentOptionNames = [
    "afterComment",
    "beforeComment",
    "firstLineStart",
    "lineEnd",
    "lineStart",
] as const;

function encodeLeadingComments(comments: unknown): unknown {
    if (comments === undefined) return undefined;
    if (!Array.isArray(comments)) fail();
    return comments.map((comment: any) => {
        if (typeof comment === "string") return { kind: "string", text: comment };
        if (comment === null || typeof comment !== "object") fail();
        if ("lines" in comment) {
            return { kind: "lines", lines: encodeSourcelikes(comment.lines) };
        }

        if ("descriptionBlock" in comment) {
            return {
                kind: "descriptionBlock",
                lines: encodeSourcelikes(comment.descriptionBlock),
            };
        }

        const custom: Record<string, unknown> = {
            kind: "custom",
            lines: encodeSourcelikes(comment.customLines),
        };
        for (const option of commentOptionNames) {
            const v = comment[option];
            if (v === undefined) continue;
            if (typeof v !== "string") fail();
            custom[option] = v;
        }

        return custom;
    });
}

function encodeJSONInput(input: any, encoded: EncodedRun): Record<string, unknown> {
    const cjson = input._compressedJSON;
    if (!isNativeCompressedJSON(cjson)) fail();
    const dateTime = dateTimeKind(cjson.dateTimeRecognizer);
    if (dateTime === undefined) fail();

    const topLevelNames: string[] = [];
    const topLevelDescriptions: unknown[] = [];
    const counts: number[] = [];
    const samples: number[] = [];
    for (const [name, topLevel] of input._topLevels as Map<string, any>) {
        topLevelNames.push(name);
        const description = topLevel.description;
        if (description !== undefined && typeof description !== "string") fail();
        topLevelDescriptions.push(description);
        counts.push(topLevel.samples.length);
        for (const sample of topLevel.samples) samples.push(sample);
    }

    const topLevels = {
        topLevelNames,
        topLevelDescriptions,
        topLevelSampleCounts: new Uint32Array(counts),
        topLevelSamples: new Int32Array(samples),
    };
    const glue = currentEngine();
    const lease = leaseSamples(cjson, glue, samples);
    if (lease !== undefined) {
        encoded.sharedGlue = glue;
        encoded.leases.push(lease);
        encoded.shared.push(cjson);
        return { kind: "jsonShared", lease, ...topLevels };
    }

    const strings: string[] = cjson._strings;
    const stringLengths = new Uint32Array(strings.length);
    for (let i = 0; i < strings.length; i++) {
        // Each on its own: joined, the halves of neighbours could pair up.
        if (!isWellFormed(strings[i])) fail();
        stringLengths[i] = strings[i].length;
    }

    const flatten = (lists: number[][]): [Int32Array, Uint32Array] => {
        let total = 0;
        for (const list of lists) total += list.length;
        const flat = new Int32Array(total);
        const offsets = new Uint32Array(lists.length);
        let at = 0;
        for (let i = 0; i < lists.length; i++) {
            offsets[i] = at;
            flat.set(lists[i], at);
            at += lists[i].length;
        }

        return [flat, offsets];
    };

    const [objects, objectOffsets] = flatten(cjson._objects);
    const [arrays, arrayOffsets] = flatten(cjson._arrays);

    return {
        kind: "json",
        handleRefs: truthy(cjson.handleRefs),
        dateTime,
        strings: strings.join(""),
        stringLengths,
        objects,
        objectOffsets,
        arrays,
        arrayOffsets,
        ...topLevels,
    };
}

let builtinAttributeProducers: unknown[] | undefined;

/** Whether `producers` are exactly the ones every `JSONSchemaInput` starts with. */
function onlyBuiltinAttributeProducers(producers: unknown): boolean {
    if (builtinAttributeProducers === undefined) {
        builtinAttributeProducers = (new JSONSchemaInput(undefined) as any)._attributeProducers;
    }

    const builtin = builtinAttributeProducers as unknown[];
    return (
        Array.isArray(producers) &&
        producers.length === builtin.length &&
        producers.every((p, i) => p === builtin[i])
    );
}

function encodeSchemaInput(
    input: any,
    storeId: number,
): Record<string, unknown> {
    if (!onlyBuiltinAttributeProducers(input._attributeProducers)) fail();

    const sourceUris: string[] = [];
    const sourceNames: string[] = [];
    const sourceConverted: number[] = [];
    for (const [uri, source] of input._schemaSources as Array<[any, any]>) {
        if (typeof source.name !== "string") fail();
        sourceUris.push(uri.toString());
        sourceNames.push(source.name);
        sourceConverted.push(source.isConverted === true ? 1 : 0);
    }

    const topLevelNames: string[] = [];
    const topLevelRefs: string[] = [];
    for (const [name, ref] of input._topLevels as Map<string, Ref>) {
        const text = ref.toString();
        // The engine gets the ref as text; it must parse back to itself.
        if (!Ref.parse(text).equals(ref)) fail();
        topLevelNames.push(name);
        topLevelRefs.push(text);
    }

    const additional = input._additionalSchemaAddresses;
    if (!Array.isArray(additional) || !additional.every((a) => typeof a === "string")) {
        fail();
    }

    return {
        kind: "schema",
        storeId,
        sourceUris,
        sourceNames,
        sourceConverted: new Uint8Array(sourceConverted),
        topLevelNames,
        topLevelRefs,
        additional: Array.from(additional),
    };
}

const switchNames = [
    "inferMaps",
    "inferEnums",
    "inferUuids",
    "inferDateTimes",
    "inferIntegerStrings",
    "inferBooleanStrings",
    "combineClasses",
    "ignoreJsonRefs",
    "alphabetizeProperties",
    "allPropertiesOptional",
    "fixedTopLevels",
    "noRender",
    "checkProvenance",
    "debugPrintGraph",
    "debugPrintGatherNames",
    "debugPrintTransformations",
    "debugPrintSchemaResolving",
    "debugPrintTimes",
] as const;

/** An encoded input without its JSON string table (checked on its own). */
function withoutTables(input: any): unknown {
    return input.kind === "json" ? { ...input, strings: "" } : input;
}

/**
 * The request for a run with the (default-filled) `options` of a `Run`,
 * or `undefined` if the run must use the TypeScript engine.
 */
export function encodeRun(
    options: any,
    inputData: InputData,
    targetLanguage: TargetLanguage,
): EncodedRun | undefined {
    let encoded: EncodedRun | undefined;
    try {
        const lang = builtinLanguageName(targetLanguage);
        if (lang === undefined) fail();
        if (Object.getPrototypeOf(inputData) !== InputData.prototype) fail();

        const switches: Record<string, boolean> = {};
        for (const name of switchNames) {
            switches[name] = truthy(options[name]);
        }

        // Run reads `debugPrintReconstitution === true`.
        switches.debugPrintReconstitution = options.debugPrintReconstitution === true;
        const onTiming = options.onTiming;
        if (onTiming !== undefined && onTiming !== null && typeof onTiming !== "function") {
            fail();
        }

        switches.onTiming = typeof onTiming === "function";

        if (typeof options.outputFilename !== "string") fail();
        const indentation = options.indentation;
        if (indentation !== undefined && typeof indentation !== "string") fail();

        const [rendererOptionNames, rendererOptionValues] = lowerRendererOptions(
            targetLanguage,
            options.rendererOptions,
        );

        const schemaInputs: JSONSchemaInput[] = [];
        encoded = { request: {}, schemaInputs, leases: [], shared: [] };
        const inputs: unknown[] = [];
        for (const input of (inputData as any)._inputs as Set<any>) {
            if (input === null || typeof input !== "object") fail();
            if (!hasOnlyBuiltinFields(input)) fail();
            const proto = Object.getPrototypeOf(input);
            if (proto === JSONInput.prototype && input.kind === "json") {
                inputs.push(encodeJSONInput(input, encoded));
            } else if (proto === JSONSchemaInput.prototype && input.kind === "schema") {
                inputs.push(encodeSchemaInput(input, schemaInputs.length));
                schemaInputs.push(input);
            } else {
                fail();
            }
        }

        const request = {
            lang,
            rendererOptionNames,
            rendererOptionValues,
            switches,
            leadingComments: encodeLeadingComments(options.leadingComments),
            outputFilename: options.outputFilename,
            indentation,
            inputs,
        };
        // (The JSON inputs' string tables were checked while encoding.)
        checkStrings({ ...request, inputs: inputs.map(withoutTables) });
        encoded.request = request;
        return encoded;
    } catch (e) {
        if (encoded?.sharedGlue !== undefined) releaseLeases(encoded.sharedGlue, encoded.leases);
        if (e === ineligible) return undefined;
        throw e;
    }
}

/** Value tags of `encodeValue` (crates/quicktype-wasm/src/wire.rs). */
const enum Tag {
    Undefined = 0,
    Null = 1,
    False = 2,
    True = 3,
    Number = 4,
    String = 5,
    Array = 6,
    Object = 7,
}

/**
 * A store document the engine cannot read exactly: it has a string that is
 * not well-formed UTF-16 (which would arrive as U+FFFD), refers to itself
 * (TypeScript recurses until its stack overflows), or would take too much
 * memory to flatten. The run is then redone on the TypeScript engine.
 */
export class Unencodable {
    public constructor(public readonly feature: string) {}
}

/** More nodes than this (a huge document, or sharing that multiplies) is not flattened. */
const maximumNodes = 50_000_000;

/** Marks the end of an object or array during `encodeValue`'s walk. */
const leave = {};

/**
 * A schema document a store returned, flattened for the engine: tags in
 * pre-order, with numbers, collection sizes and strings (object keys
 * before their values) in separate streams. Objects are read with
 * `Object.keys`; values JSON has no notion of (functions, symbols, bigints)
 * become `undefined`, which the engine reads as absent (in objects) or
 * `null` (in arrays). Throws `Unencodable` (see there).
 */
export function encodeValue(value: unknown): Record<string, unknown> | undefined {
    if (value === undefined) return undefined;
    const tags: number[] = [];
    const numbers: number[] = [];
    const counts: number[] = [];
    const strings: string[] = [];
    // The objects and arrays being walked, to tell a cycle from sharing.
    const ancestors = new Set<object>();
    // Pending values (or `leave` markers), and the keys to emit before them.
    const values: unknown[] = [value];
    const keys: Array<string | undefined> = [undefined];
    const string = (s: string): void => {
        if (!isWellFormed(s)) throw new Unencodable("lone surrogates in schema documents");
        strings.push(s);
    };
    while (values.length > 0) {
        const v = values.pop();
        const key = keys.pop();
        if (v === leave) {
            ancestors.delete(key as unknown as object);
            continue;
        }

        if (tags.length >= maximumNodes) throw new Unencodable("schema documents this large");
        if (key !== undefined) string(key);
        if (v === null) {
            tags.push(Tag.Null);
            continue;
        }

        switch (typeof v) {
            case "boolean":
                tags.push(v ? Tag.True : Tag.False);
                break;
            case "number":
                tags.push(Tag.Number);
                numbers.push(v);
                break;
            case "string":
                tags.push(Tag.String);
                string(v);
                break;
            case "object": {
                if (ancestors.has(v)) throw new Unencodable("circular schema documents");
                ancestors.add(v);
                // Leave the object after its children (`keys` carries it).
                values.push(leave);
                keys.push(v as unknown as string);
                if (Array.isArray(v)) {
                    tags.push(Tag.Array);
                    counts.push(v.length);
                    for (let i = v.length - 1; i >= 0; i--) {
                        values.push(v[i]);
                        keys.push(undefined);
                    }
                } else {
                    const objectKeys = Object.keys(v);
                    tags.push(Tag.Object);
                    counts.push(objectKeys.length);
                    for (let i = objectKeys.length - 1; i >= 0; i--) {
                        values.push((v as any)[objectKeys[i]]);
                        keys.push(objectKeys[i]);
                    }
                }

                break;
            }

            default:
                tags.push(Tag.Undefined);
        }
    }

    const stringLengths = new Uint32Array(strings.length);
    for (let i = 0; i < strings.length; i++) {
        stringLengths[i] = strings[i].length;
    }

    return {
        tags: new Uint8Array(tags),
        numbers: new Float64Array(numbers),
        counts: new Uint32Array(counts),
        strings: strings.join(""),
        stringLengths,
    };
}
