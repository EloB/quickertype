// Deciding whether a run can go to the WebAssembly engine, and encoding it
// (research 05, sections 2 and 4.2).
//
// A run is eligible when everything it involves is a built-in the Rust
// engine reproduces exactly: the target language is one of quicktype's
// own (not a subclass, not modified), every input is an exact `JSONInput`
// over a `CompressedJSONFromString` (or a class registered under
// `Symbol.for("quicktype-core.nativeInputs")`, such as the CLI's stream
// reader) with a built-in date/time recognizer, or an exact
// `JSONSchemaInput` without extra attribute producers, and every option
// value is one the engine models (renderer options are lowered here, by
// the rules of `Option.getValue`/`BooleanOption.getValue`/
// `EnumOption.getEnumValue`). Every other run uses the TypeScript engine,
// which gives the same result by construction.
//
// The request carries JSON samples as the tables of their
// `CompressedJSON` (already parsed with `JSON.parse` semantics and V8's
// error messages), and JSON Schema inputs as their already normalized
// sources; the schemas themselves stay in JavaScript and are fetched
// through the input's own store while the engine runs.

import { DefaultDateTimeRecognizer } from "../DateTime.js";
import { CompressedJSONFromString } from "../input/CompressedJSON.js";
import { InputData, JSONInput } from "../input/Inputs.js";
import { JSONSchemaInput, Ref } from "../input/JSONSchemaInput.js";
import { all as defaultTargetLanguages } from "../language/All.js";
import { KotlinDateTimeRecognizer } from "../language/Kotlin/utils.js";
import { SwiftDateTimeRecognizer } from "../language/Swift/utils.js";
import type { TargetLanguage } from "../TargetLanguage.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the bridge reads private fields of the facade's objects

/** What the engine receives (crates/quicktype-wasm/src/js.rs). */
export interface EncodedRun {
    request: Record<string, unknown>;
    /** The JSON Schema inputs, by `storeId`. */
    schemaInputs: JSONSchemaInput[];
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

function dateTimeKind(recognizer: unknown): string | undefined {
    if (recognizer === null || typeof recognizer !== "object") {
        return undefined;
    }

    switch (Object.getPrototypeOf(recognizer)) {
        case DefaultDateTimeRecognizer.prototype:
            return "default";
        case KotlinDateTimeRecognizer.prototype:
            return "kotlin";
        case SwiftDateTimeRecognizer.prototype:
            return "swift";
        default:
            return undefined;
    }
}

function ownNames(x: object): string {
    return Object.getOwnPropertyNames(x).sort().join(",");
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

/** The own properties a fresh instance of each built-in input has. */
function hasOnlyBuiltinFields(input: object): boolean {
    if (expectedOwnNames === undefined) {
        expectedOwnNames = new Map<unknown, string>([
            [
                JSONInput.prototype,
                ownNames(new JSONInput(new CompressedJSONFromString(new DefaultDateTimeRecognizer(), false))),
            ],
            [JSONSchemaInput.prototype, ownNames(new JSONSchemaInput(undefined))],
        ]);
    }

    return expectedOwnNames.get(Object.getPrototypeOf(input)) === ownNames(input);
}

/** JavaScript truthiness. */
function truthy(x: unknown): boolean {
    return !!x;
}

class Ineligible {}
const ineligible = new Ineligible();

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

function encodeJSONInput(input: any): Record<string, unknown> {
    const cjson = input._compressedJSON;
    if (!isNativeCompressedJSON(cjson)) fail();
    const dateTime = dateTimeKind(cjson.dateTimeRecognizer);
    if (dateTime === undefined) fail();

    const strings: string[] = cjson._strings;
    const stringLengths = new Uint32Array(strings.length);
    for (let i = 0; i < strings.length; i++) {
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
        topLevelNames,
        topLevelDescriptions,
        topLevelSampleCounts: new Uint32Array(counts),
        topLevelSamples: new Int32Array(samples),
    };
}

/** The attribute producers every `JSONSchemaInput` starts with. */
const builtinAttributeProducerCount = 9;

function encodeSchemaInput(
    input: any,
    storeId: number,
): Record<string, unknown> {
    if (input._attributeProducers.length !== builtinAttributeProducerCount) {
        fail();
    }

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

/**
 * The request for a run with the (default-filled) `options` of a `Run`,
 * or `undefined` if the run must use the TypeScript engine.
 */
export function encodeRun(
    options: any,
    inputData: InputData,
    targetLanguage: TargetLanguage,
): EncodedRun | undefined {
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
        const inputs: unknown[] = [];
        for (const input of (inputData as any)._inputs as Set<any>) {
            if (input === null || typeof input !== "object") fail();
            if (!hasOnlyBuiltinFields(input)) fail();
            const proto = Object.getPrototypeOf(input);
            if (proto === JSONInput.prototype && input.kind === "json") {
                inputs.push(encodeJSONInput(input));
            } else if (proto === JSONSchemaInput.prototype && input.kind === "schema") {
                inputs.push(encodeSchemaInput(input, schemaInputs.length));
                schemaInputs.push(input);
            } else {
                fail();
            }
        }

        return {
            request: {
                lang,
                rendererOptionNames,
                rendererOptionValues,
                switches,
                leadingComments: encodeLeadingComments(options.leadingComments),
                outputFilename: options.outputFilename,
                indentation,
                inputs,
            },
            schemaInputs,
        };
    } catch (e) {
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
 * A schema document a store returned, flattened for the engine: tags in
 * pre-order, with numbers, collection sizes and strings (object keys
 * before their values) in separate streams. Objects are read with
 * `Object.keys`; values JSON has no notion of (functions, symbols, bigints)
 * become `undefined`, which the engine reads as absent (in objects) or
 * `null` (in arrays).
 */
export function encodeValue(value: unknown): unknown {
    if (value === undefined) return undefined;
    const tags: number[] = [];
    const numbers: number[] = [];
    const counts: number[] = [];
    const strings: string[] = [];
    // Pending values, and the keys to emit before them (`undefined` for none).
    const values: unknown[] = [value];
    const keys: Array<string | undefined> = [undefined];
    while (values.length > 0) {
        const v = values.pop();
        const key = keys.pop();
        if (key !== undefined) strings.push(key);
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
                strings.push(v);
                break;
            case "object":
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
