// JSON Lines samples, an addition to quicktype-core's API (quicktype has
// no JSON Lines input): `JSONInput.addSource({ name, samples, jsonLines:
// true })` (and `addSourceSync`) reads each sample as JSON Lines text, one
// JSON value per line, as the JSON array of those values. A sample of the
// values V1…Vn is read exactly as the sample `[V1,…,Vn]` would be, into
// the same tables, with that array as its root, so it gives the same types
// and the same code, in every language and with every option.
//
// What a sample is: a string, or a `Uint8Array` of UTF-8 bytes (the text
// `new TextDecoder().decode(bytes)` gives, as for a JSON sample). The text
// may start with a byte order mark; its values are separated by JSON
// whitespace that holds a line feed (`\n`, so `\r\n` too; a carriage return
// alone does not end a line). Blank lines are skipped, the last line feed
// is optional, and a value may span lines (a pretty-printed one); two
// values on one line are an error. A text without values is `[]`. Each
// value is read with `JSON.parse`. These are the rules of the CLI's JSON
// Lines (README, "JSON Lines") and of quickertype-core's
// `JsonSample::StringLines`.
//
// For a `CompressedJSONFromString`, the WebAssembly engine reads the sample
// first (`readSampleNatively(cjson, sample, true)`: `jsonReadLines`, which
// reads the text as `[V1,…,Vn]`), as `parseSync` lets it read a JSON sample
// (src/native/samples.ts). What the engine does not read, this reader
// does: it finds where each value ends, parses it with `JSON.parse`, and
// hands the array of the values to the `CompressedJSON`'s own `process`, as
// `parseSync` hands it the value of `JSON.parse`. A text that is not JSON
// Lines is read by nobody but this reader, which throws a `SyntaxError`
// whose message is `line N: ` and `JSON.parse`'s message for the value on
// line N (for two values on one line, for the two of them; its positions
// count from the value's start, and V8's `(line L column C)` is left out):
// the same error whichever engine runs, as for a JSON sample, whose error
// is always `JSON.parse`'s. `addSource` throws it as quicktype's `Syntax
// error in input JSON <name>: line N: …`.
//
// The bytes of a sample are never decoded whole here: each value's bytes
// are decoded by themselves (cut next to an ASCII character, which gives
// the text decoding the whole would), so that bytes too long to be one
// JavaScript string can still be read, value by value.

import { CompressedJSONFromString, type CompressedJSON, type Value } from "../input/CompressedJSON.js";

import { isBytes, readSampleNatively, takeDecoded } from "./hook.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the reader calls private methods of CompressedJSONFromString

const lineFeed = 0x0a;
const carriageReturn = 0x0d;
const space = 0x20;
const tab = 0x09;
const quote = 0x22;
const backslash = 0x5c;
const leftBracket = 0x5b;
const rightBracket = 0x5d;
const leftBrace = 0x7b;
const rightBrace = 0x7d;

/** A `TextDecoder` for UTF-8 that keeps a leading U+FEFF (each value's text is decoded by itself). */
let valueDecoder: { decode(input: Uint8Array): string } | undefined;

/** The text of `bytes`, the bytes of a value, as decoding the whole sample gives it. */
function decodeValue(bytes: Uint8Array): string {
    if (valueDecoder === undefined) {
        valueDecoder = new (globalThis as any).TextDecoder("utf-8", { ignoreBOM: true });
    }

    // The decoder takes no view of shared memory (of any realm).
    const shared = Object.prototype.toString.call(bytes.buffer) === "[object SharedArrayBuffer]";
    return (valueDecoder as { decode(input: Uint8Array): string }).decode(shared ? new Uint8Array(bytes) : bytes);
}

/** A sample's text, as code units (a string) or bytes (UTF-8). */
type Source = string | Uint8Array;

/** The code unit or byte at `at`. */
function codeAt(source: Source, at: number): number {
    return typeof source === "string" ? source.charCodeAt(at) : source[at];
}

/** The text of `source` from `start` to `end`. */
function textOf(source: Source, start: number, end: number): string {
    return typeof source === "string" ? source.slice(start, end) : decodeValue(source.subarray(start, end));
}

const isWhitespace = (c: number): boolean => c === space || c === lineFeed || c === carriageReturn || c === tab;

/** Where the string whose opening quote is before `at` ends: after its closing quote, or at the end. */
function stringEnd(source: Source, at: number): number {
    const length = source.length;
    while (at < length) {
        const c = codeAt(source, at);
        if (c === backslash) at += 2;
        else if (c === quote) return at + 1;
        else at++;
    }

    return length;
}

/**
 * Where the value that starts at `start` (not whitespace) ends, if it is
 * JSON: after the bracket that closes an object or an array, after the
 * quote that closes a string, or at the whitespace after anything else
 * (a number or a literal). For a value that is not JSON, it is where
 * `JSON.parse` of the text from `start` up to it fails, or sooner.
 */
function valueEnd(source: Source, start: number): number {
    const length = source.length;
    const first = codeAt(source, start);
    if (first === quote) return stringEnd(source, start + 1);
    if (first === leftBrace || first === leftBracket) {
        let depth = 0;
        let at = start;
        while (at < length) {
            const c = codeAt(source, at);
            if (c === quote) {
                at = stringEnd(source, at + 1);
                continue;
            }

            if (c === leftBrace || c === leftBracket) depth++;
            else if (c === rightBrace || c === rightBracket) {
                depth--;
                if (depth === 0) return at + 1;
            }

            at++;
        }

        return length;
    }

    let at = start + 1;
    while (at < length && !isWhitespace(codeAt(source, at))) at++;
    return at;
}

/**
 * Where the text of `source` starts: after its byte order mark, if it has
 * one; for bytes, after the decoder's (`TextDecoder` drops one) and then
 * the text's own.
 */
function textStart(source: Source): number {
    if (typeof source === "string") return source.charCodeAt(0) === 0xfeff ? 1 : 0;
    let at = 0;
    for (let marks = 0; marks < 2; marks++) {
        if (source[at] !== 0xef || source[at + 1] !== 0xbb || source[at + 2] !== 0xbf) break;
        at += 3;
    }

    return at;
}

/**
 * The error of the value on line N (the line the value at `start` starts
 * on, one more than the line feeds before it): `line N: ` and `JSON.parse`'s
 * message for the value, whose positions count from the value's start.
 * Without the `(line L column C)` that V8 puts after a position: those
 * would be the lines of the value, not of the text.
 */
function lineError(source: Source, start: number, error: unknown): SyntaxError {
    let line = 1;
    for (let at = 0; at < start; at++) if (codeAt(source, at) === lineFeed) line++;
    const message = error instanceof Error ? error.message : String(error);
    return new SyntaxError(`line ${line}: ${message.replace(/ \(line \d+ column \d+\)$/, "")}`);
}

/** What `JSON.parse(text)` throws (it throws: `text` is not one JSON value). */
function parseError(text: string): unknown {
    try {
        JSON.parse(text);
    } catch (e) {
        return e;
    }

    return new SyntaxError("Unexpected non-whitespace character after JSON");
}

/**
 * The values of the JSON Lines `source`, each as `JSON.parse` gives it;
 * throws the error of the line that is not JSON (see the top).
 */
export function jsonLinesValues(source: Source): unknown[] {
    const length = source.length;
    const values: unknown[] = [];
    let at = textStart(source);
    /** Where the value before starts. */
    let previous = -1;
    for (;;) {
        let lineBreak = false;
        while (at < length) {
            const c = codeAt(source, at);
            if (c === lineFeed) lineBreak = true;
            else if (c !== space && c !== tab && c !== carriageReturn) break;
            at++;
        }

        if (at >= length) return values;
        const start = at;
        const end = valueEnd(source, start);
        if (previous >= 0 && !lineBreak) {
            // A second value on the line: what JSON.parse says of the two.
            throw lineError(source, start, parseError(textOf(source, previous, end)));
        }

        try {
            values.push(JSON.parse(textOf(source, start, end)));
        } catch (e) {
            throw lineError(source, start, e);
        }

        previous = start;
        at = end;
    }
}

/**
 * The text (or bytes) of a JSON Lines sample: the text the samples reader
 * decoded bytes to, if it did (`passDecoded`), the bytes, a string, or (as
 * `JSON.parse` would take it) anything else as a string.
 */
function sourceOf(sample: unknown): Source {
    if (isBytes(sample)) return takeDecoded(sample) ?? sample;
    return typeof sample === "string" ? sample : String(sample);
}

/**
 * `cjson.parseSync(sample)` for a JSON Lines sample: its root `Value`, the
 * array of its values. Only a `CompressedJSONFromString` reads JSON Lines.
 */
export function parseJSONLinesSync<T>(cjson: CompressedJSON<T>, sample: T): Value {
    if (!(cjson instanceof CompressedJSONFromString)) {
        throw new Error("quickertype-core: JSON Lines samples are read by a CompressedJSONFromString only");
    }

    const value = readSampleNatively(cjson, sample, true);
    if (value !== undefined) return value;
    const values = jsonLinesValues(sourceOf(sample));
    (cjson as any).process(values);
    return (cjson as any).finish();
}

/** `cjson.parse(sample)` for a JSON Lines sample (see `parseJSONLinesSync`). */
export async function parseJSONLines<T>(cjson: CompressedJSON<T>, sample: T): Promise<Value> {
    return parseJSONLinesSync(cjson, sample);
}
