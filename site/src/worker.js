// The page's Web Worker: runs quicktype-core off the main thread. One copy
// runs on the WebAssembly engine (`worker.js?engine=wasm`), and in compare
// mode a second copy on the TypeScript engine (`?engine=ts`).
//
// Request:  { id, kind: "json" | "schema", lang, name, text, rendererOptions,
//             warmup?, repeat? }
// Replies:  { type: "ready", engine, compileMs, loadError, readyMs }
//           { type: "result", id, ok, files | error, ms, times, inputTimes, ran, reason, first }
//
// `times` are whole runs; `inputTimes` the part spent reading the input
// (`addSource`: parsing the JSON or the schema), which is quicktype's
// TypeScript code on both engines. The rest is generating the code.

import { boot } from "./worker-boot.js";

import {
    FetchingJSONSchemaStore,
    InputData,
    JSONSchemaInput,
    jsonInputForTargetLanguage,
    quicktypeMultiFile,
} from "../../npm/quicktype-core/dist/esm/index.js";
import { engineStats } from "../../npm/quicktype-core/dist/esm/native/bridge.js";

/** One quicktype run, as quicktype's CLI would do it for a file of `kind`. */
async function generate({ kind, lang, name, text, rendererOptions }, phases) {
    const start = performance.now();
    const inputData = new InputData();
    if (kind === "schema") {
        const input = new JSONSchemaInput(new FetchingJSONSchemaStore());
        await input.addSource({ name, schema: text });
        inputData.addInput(input);
    } else {
        const input = jsonInputForTargetLanguage(lang);
        await input.addSource({ name, samples: [text] });
        inputData.addInput(input);
    }

    phases.input = performance.now() - start;
    return quicktypeMultiFile({ inputData, lang, rendererOptions });
}

function snapshot() {
    return { ...engineStats, unsupportedBy: { ...engineStats.unsupportedBy } };
}

/** Which engine did the run between `before` and now, and why not WebAssembly if it did not. */
function whoRan(before) {
    if (engineStats.wasm > before.wasm) return { ran: "wasm" };
    if (engineStats.ts === before.ts) {
        // It failed before the generation step (e.g. parsing the input,
        // which is TypeScript code on both engines).
        return { ran: undefined };
    }

    if (boot.engine === "ts") return { ran: "ts", reason: "forced" };
    if (engineStats.rerun > before.rerun) {
        return { ran: "ts", reason: `the engine failed and the run was redone (${engineStats.lastFailure})` };
    }

    const features = Object.keys(engineStats.unsupportedBy).filter(
        (f) => engineStats.unsupportedBy[f] !== before.unsupportedBy[f],
    );
    if (features.length > 0) return { ran: "ts", reason: `not supported by the engine yet: ${features.join(", ")}` };
    if (boot.loadError !== undefined) return { ran: "ts", reason: `the engine did not load: ${boot.loadError}` };
    return { ran: "ts", reason: "this run is not one the engine models" };
}

function serialize(result) {
    return [...result].map(([name, { lines, annotations }]) => ({
        name,
        text: lines.join("\n"),
        annotations: annotations.map((a) => ({ line: a.span.start.line, message: a.annotation.message })),
    }));
}

let runs = 0;

async function handle(request) {
    const warmup = request.warmup ?? 0;
    const repeat = Math.max(1, request.repeat ?? 1);
    const first = runs === 0;
    const times = [];
    const inputTimes = [];
    let reply;
    for (let i = 0; i < warmup + repeat; i++) {
        const before = snapshot();
        const phases = {};
        const start = performance.now();
        try {
            const result = await generate(request, phases);
            const ms = performance.now() - start;
            if (i >= warmup) {
                times.push(ms);
                inputTimes.push(phases.input);
            }

            if (i === warmup + repeat - 1) reply = { ok: true, files: serialize(result), ...whoRan(before) };
        } catch (e) {
            const ms = performance.now() - start;
            times.push(ms);
            reply = {
                ok: false,
                error: { message: String(e?.message ?? e), messageName: e?.messageName, name: e?.constructor?.name },
                ...whoRan(before),
            };
            break;
        } finally {
            runs++;
        }
    }

    return { type: "result", id: request.id, ms: times[times.length - 1], times, inputTimes, first, ...reply };
}

let queue = Promise.resolve();
self.onmessage = (event) => {
    queue = queue.then(async () => self.postMessage(await handle(event.data)));
};

self.postMessage({ type: "ready", ...boot, readyMs: performance.now() });
