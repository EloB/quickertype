// How a fuzz case runs in-process on one copy of quicktype-core: the quicktype
// options it maps to and the inputs it is given. The fuzzer (engines.mjs, for
// both sides of the "api" and "stream" modes) and the npm differential
// suite's replay of recorded cases (npm/quicktype-core/test/differential/
// scenarios/fuzz.mjs) both use this module, so a recorded case runs exactly
// as the fuzzer ran it. Only Node built-ins are imported here.

import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { Readable } from "node:stream";
import * as vm from "node:vm";

/** Inference flags (CLI `--no-*`), as quicktype options. */
export const INFERENCE_FLAGS = [
    ["inferMaps", "--no-maps"],
    ["inferEnums", "--no-enums"],
    ["inferUuids", "--no-uuids"],
    ["inferDateTimes", "--no-date-times"],
    ["inferIntegerStrings", "--no-integer-strings"],
    ["inferBooleanStrings", "--no-boolean-strings"],
    ["combineClasses", "--no-combine-classes"],
    ["ignoreJsonRefs", "--no-ignore-json-refs"],
];

/** The CLI's `--debug` components and the quicktype options they set. */
export const DEBUG_OPTIONS = [
    ["print-graph", "debugPrintGraph"],
    ["print-reconstitution", "debugPrintReconstitution"],
    ["print-gather-names", "debugPrintGatherNames"],
    ["print-transformations", "debugPrintTransformations"],
    ["print-schema-resolving", "debugPrintSchemaResolving"],
    ["provenance", "checkProvenance"],
];

/** quicktype options for a case (what the CLI's makeQuicktypeOptions would give, plus API extras). */
export function quicktypeOptions(kase, inputData, withApiExtras = true) {
    const options = {
        lang: kase.lang,
        inputData,
        // API runs may give the options as other values than the CLI would.
        rendererOptions: withApiExtras && kase.api?.rendererOptions !== undefined ? kase.api.rendererOptions : kase.rendererOptions,
        alphabetizeProperties: kase.flags.alphabetizeProperties === true,
        allPropertiesOptional: kase.flags.allPropertiesOptional === true,
    };
    for (const [name] of INFERENCE_FLAGS) options[name] = kase.flags[name] !== false;
    for (const [component, name] of DEBUG_OPTIONS) {
        if (kase.debug?.includes(component)) options[name] = true;
    }

    if (withApiExtras) {
        for (const key of ["indentation", "leadingComments", "outputFilename"]) {
            if (kase.api?.[key] !== undefined) options[key] = kase.api[key];
        }
    }

    return options;
}

/** The CLI's `wordWrap` (the `wordwrap` package at width 90), for a Postman collection's description. */
export function cliWordWrap(reference) {
    return createRequire(path.join(reference, "dist", "index.js"))("wordwrap")(90);
}

const nativeInputsKey = Symbol.for("quicktype-core.nativeInputs");
const streamClasses = new WeakMap();

/**
 * The reference CLI's CompressedJSONFromStream for `qt`: the CLI's own
 * class for the reference's quicktype-core, else its source compiled
 * against `qt` and registered as a native input (so that our package runs
 * it on its WebAssembly engine).
 */
export function streamClassFor(reference, qt) {
    let Stream = streamClasses.get(qt);
    if (Stream !== undefined) return Stream;
    const file = path.join(reference, "dist", "CompressedJSONFromStream.js");
    const refRequire = createRequire(file);
    if (refRequire("quicktype-core") === qt) {
        Stream = refRequire(file).CompressedJSONFromStream;
    } else {
        const source = fs.readFileSync(file, "utf8");
        const fn = vm.compileFunction(source, ["exports", "require", "module", "__filename", "__dirname"], { filename: file });
        const module = { exports: {} };
        fn(module.exports, (id) => (id === "quicktype-core" ? qt : refRequire(id)), module, file, path.dirname(file));
        Stream = module.exports.CompressedJSONFromStream;
        const registered = globalThis[nativeInputsKey];
        globalThis[nativeInputsKey] = [...(Array.isArray(registered) ? registered : []), Stream];
    }

    streamClasses.set(qt, Stream);
    return Stream;
}

/**
 * Runs a case in-process on one side, `{ qt, wordWrap, Stream? }` (the
 * quicktype-core, the CLI's word wrapping, and for "stream" mode the
 * stream reader class), in mode "api" (samples as strings, with the API
 * extras) or "stream" (samples read as the CLI reads them).
 */
export async function runInProcess(side, kase, mode) {
    const { qt } = side;
    const inputData = new qt.InputData();
    const options = quicktypeOptions(kase, inputData, mode === "api");
    // "mixed": JSON top-levels and a JSON Schema in one run.
    if (kase.src === "json" || kase.src === "postman" || kase.src === "mixed") {
        let topLevels = kase.topLevels;
        if (kase.src === "postman") {
            // What the CLI does with a collection (src/index.ts).
            const { sources, description } = qt.sourcesFromPostmanCollection(kase.postman, "in/collection.json");
            topLevels = sources;
            if (sources.length > 1) options.fixedTopLevels = true;
            if (description !== undefined) options.leadingComments = side.wordWrap(description).split("\n");
        }

        const handleRefs = kase.flags.ignoreJsonRefs === false;
        let input;
        if (mode === "stream") {
            const lang = qt.getTargetLanguage(kase.lang);
            input = new qt.JSONInput(
                new side.Stream(lang.dateTimeRecognizer, handleRefs, lang.getSupportedIntegerRange(options.rendererOptions)),
            );
        } else {
            input = qt.jsonInputForTargetLanguage(kase.lang, undefined, handleRefs, options.rendererOptions);
        }

        for (const tl of topLevels) {
            const samples = mode === "stream" ? tl.samples.map((s) => Readable.from([Buffer.from(s, "utf8")])) : tl.samples;
            await input.addSource(tl.description === undefined ? { name: tl.name, samples } : { name: tl.name, description: tl.description, samples });
        }

        inputData.addInput(input);
    }

    if (kase.src === "schema" || kase.src === "mixed") {
        const input = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore(), [], []);
        for (const s of kase.schemas) await input.addSource(s.uris === undefined ? { name: s.name, schema: s.text } : { name: s.name, schema: s.text, uris: s.uris });
        inputData.addInput(input);
    }

    return await qt.quicktypeMultiFile(options);
}
