// The one place where upstream code outside Run.ts calls into the bridge:
// `CompressedJSONFromString.parseSync` asks `readSampleNatively` before it
// parses a sample itself. The reader is installed by src/native/samples.ts
// when the bridge loads, so that src/input/CompressedJSON.ts imports nothing
// that imports it back.

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
