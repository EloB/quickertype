// The one place where upstream code outside Run.ts calls into the bridge:
// `CompressedJSONFromString.parseSync` asks `readSampleNatively` before it
// parses a sample itself, and parses what `sampleText` makes of it. The
// reader is installed by src/native/samples.ts when the bridge loads, so
// that src/input/CompressedJSON.ts imports nothing that imports it back.

/**
 * Reads a JSON sample into `cjson` on the WebAssembly engine, returning
 * the sample's `Value`, or `undefined` if TypeScript is to read it.
 */
export type SampleReader = (cjson: object, input: unknown) => number | undefined;

let reader: SampleReader | undefined;

export function installSampleReader(read: SampleReader): void {
    reader = read;
}

export function readSampleNatively(cjson: object, input: unknown): number | undefined {
    return reader === undefined ? undefined : reader(cjson, input);
}

/** A `TextDecoder` for UTF-8, as far as `sampleText` uses it. */
interface Utf8Decoder {
    decode(input: Uint8Array): string;
}

let decoder: Utf8Decoder | undefined;

/**
 * A JSON sample as `JSON.parse` takes it: the text of a `Uint8Array` (a
 * Node.js `Buffer` too), decoded as `new TextDecoder().decode(bytes)`
 * decodes it (UTF-8, without a leading byte order mark, U+FFFD for what is
 * not UTF-8), and any other sample as it is.
 */
export function sampleText(input: unknown): unknown {
    if (!(input instanceof Uint8Array)) return input;
    // biome-ignore lint/suspicious/noExplicitAny: a host global the es lib does not declare
    if (decoder === undefined) decoder = new (globalThis as any).TextDecoder() as Utf8Decoder;
    // The decoder takes no view of shared memory.
    const shared = typeof SharedArrayBuffer === "function" && input.buffer instanceof SharedArrayBuffer;
    return decoder.decode(shared ? new Uint8Array(input) : input);
}
