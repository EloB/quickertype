// The one place where upstream code outside Run.ts calls into the bridge:
// `CompressedJSONFromString.parseSync` asks `readSampleNatively` before it
// parses a sample itself, and parses what `sampleText` makes of it;
// src/native/lines.ts asks it first for a JSON Lines sample. The reader is
// installed by src/native/samples.ts when the bridge loads, so that
// src/input/CompressedJSON.ts imports nothing that imports it back.

/**
 * Reads a JSON sample into `cjson` on the WebAssembly engine (with
 * `lines`, a JSON Lines sample, as the array of its values), returning the
 * sample's `Value`, or `undefined` if TypeScript is to read it; for JSON
 * Lines, 0 if the engine found they are not JSON Lines (it read nothing).
 */
export type SampleReader = (cjson: object, input: unknown, lines: boolean) => number | undefined;

let reader: SampleReader | undefined;

export function installSampleReader(read: SampleReader): void {
    reader = read;
}

export function readSampleNatively(cjson: object, input: unknown, lines = false): number | undefined {
    return reader === undefined ? undefined : reader(cjson, input, lines);
}

/**
 * Whether `x` is a `Uint8Array` (a Node.js `Buffer` too): one from another
 * realm as well (a `vm` context, an iframe), which `instanceof` would not
 * take for one.
 */
export function isBytes(x: unknown): x is Uint8Array {
    return ArrayBuffer.isView(x) && Object.prototype.toString.call(x) === "[object Uint8Array]";
}

/** A `TextDecoder` for UTF-8, as far as `decodeUtf8` uses it. */
interface Utf8Decoder {
    decode(input: Uint8Array): string;
}

let decoder: Utf8Decoder | undefined;

/**
 * The text of `bytes` as `new TextDecoder().decode(bytes)` gives it (UTF-8,
 * without a leading byte order mark, U+FFFD for what is not UTF-8). Throws
 * what the decoder throws: a `RangeError` for a text longer than the
 * longest string (Node.js). Chrome's decoder gives "" for such a text
 * instead, without an error, which only no bytes or a byte order mark alone
 * decode to: that is a `RangeError` here too, never a text `JSON.parse`
 * would call the end of the input.
 */
export function decodeUtf8(bytes: Uint8Array): string {
    // biome-ignore lint/suspicious/noExplicitAny: a host global the es lib does not declare
    if (decoder === undefined) decoder = new (globalThis as any).TextDecoder() as Utf8Decoder;
    // The decoder takes no view of shared memory (of any realm).
    const shared = Object.prototype.toString.call(bytes.buffer) === "[object SharedArrayBuffer]";
    const text = decoder.decode(shared ? new Uint8Array(bytes) : bytes);
    if (text.length === 0 && bytes.length > 3) throw new RangeError("Invalid string length");
    return text;
}

/**
 * The text the samples reader decoded a sample's bytes to, when it leaves
 * the sample to `parseSync` after all: `sampleText` takes it instead of
 * decoding the same bytes again.
 */
let decodedByReader: { bytes: Uint8Array; text: string } | undefined;

/** For the samples reader: `parseSync`'s `sampleText(bytes)` is `text`. */
export function passDecoded(bytes: Uint8Array | undefined, text?: string): void {
    decodedByReader = bytes === undefined || text === undefined ? undefined : { bytes, text };
}

/**
 * A JSON sample as `JSON.parse` takes it: the text of a `Uint8Array`
 * (`decodeUtf8`), and any other sample as it is.
 */
export function sampleText(input: unknown): unknown {
    if (!isBytes(input)) return input;
    const decoded = decodedByReader;
    if (decoded !== undefined && decoded.bytes === input) {
        decodedByReader = undefined;
        return decoded.text;
    }

    return decodeUtf8(input);
}
