// Helpers shared by the ported unit tests (see ../api-tests.mjs). Every
// helper takes the quicktype-core copy `qt` the scenario runs against.

import * as fs from "node:fs";
import * as http from "node:http";
import { createRequire, stripTypeScriptTypes } from "node:module";
import * as path from "node:path";

const require = createRequire(import.meta.url);

/** What a scenario needing quicktype-typescript-input returns without a quicktype checkout. */
export const noCheckout = "skipped: no reference checkout";

/** InputData with a single JSONSchemaInput (`store`: its JSONSchemaStore) holding `source`. */
export async function schemaInputData(qt, source, store = undefined) {
    const schemaInput = new qt.JSONSchemaInput(store);
    await schemaInput.addSource(source);
    const inputData = new qt.InputData();
    inputData.addInput(schemaInput);
    return inputData;
}

/** InputData with a single `jsonInputForTargetLanguage(lang)` holding the samples. */
export async function jsonInputData(qt, lang, name, samples) {
    const jsonInput = qt.jsonInputForTargetLanguage(lang);
    await jsonInput.addSource({ name, samples });
    const inputData = new qt.InputData();
    inputData.addInput(jsonInput);
    return inputData;
}

/** An empty directory `ctx.tmpDir/<segments>` (the same path for both runs of a scenario). */
export function freshDirectory(ctx, ...segments) {
    const dir = path.join(ctx.tmpDir, ...segments);
    fs.rmSync(dir, { recursive: true, force: true });
    fs.mkdirSync(dir, { recursive: true });
    return dir;
}

/** Runs `f` with `dir` as the working directory. */
export async function inDirectory(dir, f) {
    const previous = process.cwd();
    process.chdir(dir);
    try {
        return await f();
    } finally {
        process.chdir(previous);
    }
}

/**
 * `schemaForTypeScriptSources` of the reference checkout's
 * quicktype-typescript-input for one TypeScript source. It compiles with
 * `rootDir: "."`, so the file is written to a scratch directory that is the
 * working directory during the call, and passed by its relative name.
 */
export function schemaForTypeScriptSource(ctx, source) {
    const { schemaForTypeScriptSources } = require(
        path.join(ctx.referenceCheckout, "packages", "quicktype-typescript-input"),
    );
    const dir = freshDirectory(ctx, "typescript-input");
    const previous = process.cwd();
    process.chdir(dir);
    try {
        fs.writeFileSync("input.ts", source);
        return schemaForTypeScriptSources(["input.ts"]);
    } finally {
        process.chdir(previous);
    }
}

/**
 * Loads generated TypeScript as an ES module (types stripped by Node; the
 * experimental-feature warning is suppressed so it cannot end up in the
 * captured console output of one run only).
 */
export async function importTypeScript(source) {
    const saved = process.emitWarning;
    process.emitWarning = () => {};
    let javascript;
    try {
        javascript = stripTypeScriptTypes(source, { mode: "transform" });
    } finally {
        process.emitWarning = saved;
    }

    return await import(`data:text/javascript;base64,${Buffer.from(javascript).toString("base64")}`);
}

const portPlaceholder = "http://127.0.0.1:<port>";

/** Replaces `needle` in every string reachable from `value` (in place where it can). */
function scrub(value, needle, seen = new Set()) {
    if (typeof value === "string") return value.split(needle).join(portPlaceholder);
    if (value === null || typeof value !== "object" || seen.has(value)) return value;
    seen.add(value);
    if (value instanceof Map) {
        const entries = [...value].map(([k, v]) => [scrub(k, needle, seen), scrub(v, needle, seen)]);
        value.clear();
        for (const [k, v] of entries) value.set(k, v);
        return value;
    }

    if (value instanceof Error) value.message = scrub(value.message, needle, seen);
    for (const key of Object.keys(value)) {
        try {
            value[key] = scrub(value[key], needle, seen);
        } catch {
            // read-only property: leave it
        }
    }

    return value;
}

/**
 * Runs `f(baseURL)` with a local HTTP server (port 0) serving `handler`,
 * closed afterwards. The server's address differs from run to run, so it
 * is replaced by a placeholder in the result or error.
 */
export async function withHTTPServer(handler, f) {
    const server = http.createServer(handler);
    await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));
    const baseURL = `http://127.0.0.1:${server.address().port}`;
    try {
        return scrub(await f(baseURL), baseURL);
    } catch (e) {
        throw scrub(e, baseURL);
    } finally {
        server.closeAllConnections();
        await new Promise((resolve, reject) =>
            server.close((error) => (error === undefined ? resolve() : reject(error))),
        );
    }
}
