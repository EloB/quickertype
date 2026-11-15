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
// does: `scanJSONLines` finds where each value is, and each is parsed with
// `JSON.parse` and handed to the `CompressedJSON`'s own `process` as soon
// as it is parsed, inside one array context (`pushArrayContext`, `process`
// of each value, `finishArray`, `finish`: what `process` of the array
// does), so that no more than one value is held as JavaScript objects at a
// time. Bytes that are not UTF-8 are read here too, the bytes of each value
// decoded by themselves (cut next to an ASCII character, which gives the
// text decoding them all would), so that bytes too long to be one
// JavaScript string can still be read, value by value, on both engines.
//
// A text that is not JSON Lines is read by nobody but this reader, which
// throws a `SyntaxError` whose message is `line N: ` and `JSON.parse`'s
// message for the value on line N (its positions count from the value's
// start, and V8's `(line L column C)` is left out), or, for a second value
// on a line, `line N: Unexpected non-whitespace character after JSON`
// (without a position, as the CLI's error has none): the same error
// whichever engine runs. `addSource` throws it as quicktype's `Syntax error
// in input JSON <name>: line N: …`. A failed sample leaves the tables as
// they were before it: what the values before the bad line added goes.
// When the engine has found that a sample is not JSON Lines (it read
// nothing), this reader only looks for the bad line, without touching the
// tables.

import { CompressedJSONFromString, type CompressedJSON, type Value } from "../input/CompressedJSON.js";

import { isBytes, readSampleNatively } from "./hook.js";

// biome-ignore-all lint/suspicious/noExplicitAny: the reader calls protected and private methods of CompressedJSONFromString

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

/** A sample's text, as code units (a string) or bytes (UTF-8). */
export type JSONLinesSource = string | Uint8Array;

// The scan below is written twice, once for code units (a string) and once
// for bytes, each specialized: with one accessor for both, picked once per
// sample, a process that reads both kinds of samples scans strings at a
// third of the speed (the accessor's calls are then polymorphic), and with
// a `typeof` per code unit, bytes scan a quarter slower and strings half
// again as slow (on a 40 MB file: 43 and 64 ms here). The structural
// characters and JSON whitespace are ASCII, so the two find the same
// ranges, in code units and in bytes (test/jsonl.test.mjs checks it).

/** `stringEnd` for code units: after the closing quote of the string whose opening quote is before `at`, or `length`. */
function stringEndInText(text: string, length: number, at: number): number {
    while (at < length) {
        const c = text.charCodeAt(at);
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
function valueEndInText(text: string, length: number, start: number): number {
    const first = text.charCodeAt(start);
    if (first === quote) return stringEndInText(text, length, start + 1);
    let at = start + 1;
    if (first === leftBrace || first === leftBracket) {
        let depth = 1;
        while (at < length) {
            const c = text.charCodeAt(at);
            if (c === quote) {
                at = stringEndInText(text, length, at + 1);
                continue;
            }

            at++;
            if (c === leftBrace || c === leftBracket) depth++;
            else if ((c === rightBrace || c === rightBracket) && --depth === 0) return at;
        }

        return length;
    }

    while (at < length) {
        const c = text.charCodeAt(at);
        if (c === space || c === lineFeed || c === carriageReturn || c === tab) break;
        at++;
    }

    return at;
}

/** `scanJSONLines` of a string. */
function scanText(text: string, visit: (start: number, end: number, ownLine: boolean) => void): void {
    const length = text.length;
    let at = text.charCodeAt(0) === 0xfeff ? 1 : 0;
    let ownLine = true;
    for (;;) {
        while (at < length) {
            const c = text.charCodeAt(at);
            if (c === lineFeed) ownLine = true;
            else if (c !== space && c !== tab && c !== carriageReturn) break;
            at++;
        }

        if (at >= length) return;
        const end = valueEndInText(text, length, at);
        visit(at, end, ownLine);
        ownLine = false;
        at = end;
    }
}

/** `stringEndInText` for bytes. */
function stringEndInBytes(bytes: Uint8Array, length: number, at: number): number {
    while (at < length) {
        const c = bytes[at];
        if (c === backslash) at += 2;
        else if (c === quote) return at + 1;
        else at++;
    }

    return length;
}

/** `valueEndInText` for bytes. */
function valueEndInBytes(bytes: Uint8Array, length: number, start: number): number {
    const first = bytes[start];
    if (first === quote) return stringEndInBytes(bytes, length, start + 1);
    let at = start + 1;
    if (first === leftBrace || first === leftBracket) {
        let depth = 1;
        while (at < length) {
            const c = bytes[at];
            if (c === quote) {
                at = stringEndInBytes(bytes, length, at + 1);
                continue;
            }

            at++;
            if (c === leftBrace || c === leftBracket) depth++;
            else if ((c === rightBrace || c === rightBracket) && --depth === 0) return at;
        }

        return length;
    }

    while (at < length) {
        const c = bytes[at];
        if (c === space || c === lineFeed || c === carriageReturn || c === tab) break;
        at++;
    }

    return at;
}

/**
 * `scanJSONLines` of bytes, whose text starts after a byte order mark, the
 * decoder's (`TextDecoder` drops one), and then after the text's own.
 */
function scanBytes(bytes: Uint8Array, visit: (start: number, end: number, ownLine: boolean) => void): void {
    const length = bytes.length;
    let at = 0;
    for (let marks = 0; marks < 2 && bytes[at] === 0xef && bytes[at + 1] === 0xbb && bytes[at + 2] === 0xbf; marks++) at += 3;
    let ownLine = true;
    for (;;) {
        while (at < length) {
            const c = bytes[at];
            if (c === lineFeed) ownLine = true;
            else if (c !== space && c !== tab && c !== carriageReturn) break;
            at++;
        }

        if (at >= length) return;
        const end = valueEndInBytes(bytes, length, at);
        visit(at, end, ownLine);
        ownLine = false;
        at = end;
    }
}

/**
 * Where the values of the JSON Lines `source` are, in order: `visit(start,
 * end, ownLine)` for each, `[start, end)` its code units (or bytes), and
 * `ownLine` whether whitespace that holds a line feed comes between it and
 * the value before (true for the first): if not, the two are on one line,
 * which JSON Lines do not allow. A byte order mark may come first (for
 * bytes, the decoder's and then the text's). The ranges are those of JSON
 * values for JSON Lines; for text that is not, they are what `JSON.parse`
 * of each fails on. Not public (the playground uses it to give quicktype
 * the JSON array of the values): the rules of JSON Lines in one place.
 */
export function scanJSONLines(source: JSONLinesSource, visit: (start: number, end: number, ownLine: boolean) => void): void {
    if (typeof source === "string") scanText(source, visit);
    else scanBytes(source, visit);
}

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

/** The line `at` is on: one more than the line feeds before it. */
function lineAt(source: JSONLinesSource, at: number): number {
    let line = 1;
    if (typeof source === "string") {
        for (let feed = source.indexOf("\n"); feed >= 0 && feed < at; feed = source.indexOf("\n", feed + 1)) line++;
    } else {
        for (let feed = source.indexOf(lineFeed); feed >= 0 && feed < at; feed = source.indexOf(lineFeed, feed + 1)) line++;
    }

    return line;
}

/**
 * The error of the value on the line `at` is on: `line N: ` and `message`
 * (V8's `(line L column C)` after a position left out: those would be the
 * lines of the value, not of the text).
 */
function lineError(source: JSONLinesSource, at: number, message: string): SyntaxError {
    return new SyntaxError(`line ${lineAt(source, at)}: ${message.replace(/ \(line \d+ column \d+\)$/, "")}`);
}

/**
 * Each value of the JSON Lines `source`, as `JSON.parse` gives it, handed
 * to `visit` as soon as it is parsed; throws the error of the first line
 * that is not JSON Lines (see the top).
 */
export function eachJSONLinesValue(source: JSONLinesSource, visit: (value: unknown) => void): void {
    scanJSONLines(source, (start, end, ownLine) => {
        if (!ownLine) throw lineError(source, start, "Unexpected non-whitespace character after JSON");
        // Decoded outside the syntax errors: what the decoder throws (a
        // value too long for one string) is not the data's syntax.
        let text: string;
        try {
            text = typeof source === "string" ? source.slice(start, end) : decodeValue(source.subarray(start, end));
        } catch (e) {
            if (!(e instanceof RangeError)) throw e;
            throw new RangeError(`line ${lineAt(source, start)}: the value is too long to be one JavaScript string (${end - start} bytes): ${e.message}`);
        }

        let value: unknown;
        try {
            value = JSON.parse(text);
        } catch (e) {
            throw lineError(source, start, e instanceof Error ? e.message : String(e));
        }

        visit(value);
    });
}

/**
 * The text (or bytes) of a JSON Lines sample: the bytes, a string, or (as
 * `JSON.parse` would take it) anything else as a string.
 */
function sourceOf(sample: unknown): JSONLinesSource {
    if (isBytes(sample)) return sample;
    return typeof sample === "string" ? sample : String(sample);
}

/** Whether `x` has an own property `name`. */
const hasOwn = (x: object, name: string): boolean => Object.prototype.hasOwnProperty.call(x, name);

/**
 * `source` into `cjson`'s tables, value by value, as `process` of the array
 * of its values would put them (see the top); its root `Value`. Should a
 * line fail, the tables and the context are put back as they were.
 */
function processLines(cjson: any, source: JSONLinesSource): Value {
    // First use of the tables: those the engine read, if it did, are filled.
    const strings = cjson._strings.length;
    const objects = cjson._objects.length;
    const arrays = cjson._arrays.length;
    const stack = cjson._contextStack.length;
    const hadContext = hasOwn(cjson, "_ctx");
    const context = cjson._ctx;
    cjson.pushArrayContext();
    try {
        eachJSONLinesValue(source, (value) => cjson.process(value));
    } catch (e) {
        const stringList: string[] = cjson._strings;
        const indexes: Record<string, number> = cjson._stringIndexes;
        for (let i = strings; i < stringList.length; i++) {
            if (hasOwn(indexes, stringList[i]) && indexes[stringList[i]] === i) delete indexes[stringList[i]];
        }

        stringList.length = strings;
        cjson._objects.length = objects;
        cjson._arrays.length = arrays;
        cjson._contextStack.length = stack;
        if (hadContext) cjson._ctx = context;
        else delete cjson._ctx;
        throw e;
    }

    cjson.finishArray();
    return cjson.finish();
}

/** `parseSync` of a JSON Lines sample: its root `Value`, the array of its values. */
function readJSONLines(cjson: CompressedJSONFromString, sample: unknown): Value {
    const read = readSampleNatively(cjson, sample, true);
    if (read !== undefined && read > 0) return read;
    const source = sourceOf(sample);
    // The engine found it is not JSON Lines, and read nothing: the error
    // of its line, found without touching the tables (or, should this
    // reader not find one, read as below).
    if (read === 0) eachJSONLinesValue(source, () => undefined);
    return processLines(cjson, source);
}

/** What reads the JSON Lines samples of a `JSONInput`: its `parse` and `parseSync` for them. */
export interface JSONLinesReader<T> {
    parse(sample: T): Promise<Value>;
    parseSync(sample: T): Value;
}

/**
 * The reader of `cjson`'s JSON Lines samples. Throws (before any sample is
 * read, outside quicktype's "Syntax error" around what reading a sample
 * throws) for a `CompressedJSON` that cannot read them: one that is not a
 * `CompressedJSONFromString`, or one whose `parse` or `parseSync` is not
 * `CompressedJSONFromString`'s (overridden by a subclass or on the
 * instance), which JSON Lines do not go through. Its other methods
 * (`process`, `pushArrayContext`, `finishArray`, `finish` and those they
 * call) are what reads JSON Lines, overridden or not.
 */
export function jsonLinesReader<T>(cjson: CompressedJSON<T>): JSONLinesReader<T> {
    const c = cjson as any;
    const own = CompressedJSONFromString.prototype as any;
    if (!(cjson instanceof CompressedJSONFromString) || c.parse !== own.parse || c.parseSync !== own.parseSync) {
        throw new Error(
            "quickertype-core: JSON Lines samples (jsonLines: true) are read by a CompressedJSONFromString whose parse and parseSync are not overridden; this input's CompressedJSON is not one",
        );
    }

    const parseSync = (sample: T): Value => readJSONLines(cjson, sample);
    return { parseSync, parse: async (sample: T): Promise<Value> => parseSync(sample) };
}
