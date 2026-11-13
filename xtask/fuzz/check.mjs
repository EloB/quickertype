// Running one case in one mode on both sides and comparing the outcomes;
// shared by the fuzzer, the minimizer and the replayer.

import { cliCommands, cliCompatible, cliInvocation, loadCompare, loadSides, runCli, runInProcess } from "./engines.mjs";

const timeoutMs = 120_000;

function withTimeout(promise) {
    let timer;
    const timeout = new Promise((resolve) => {
        timer = setTimeout(() => resolve({ timeout: true }), timeoutMs);
    });
    return Promise.race([promise, timeout]).finally(() => clearTimeout(timer));
}

export async function makeChecker({ reference, bin }) {
    const sides = loadSides(reference);
    const { capture, firstDifference, brief } = await loadCompare();
    const commands = cliCommands(reference, bin);

    /**
     * Runs `kase` in `mode` ("api", "stream" or "cli") on both sides:
     * { status, engine?, detail?, expected?, actual? }, where status is
     * "same", "diff", "skip" (the mode does not apply) or "timeout".
     * `engine` says where our in-process run went: "wasm", "fallback" (the
     * engine declined it), "rerun" (the engine failed and TypeScript redid
     * it: a trap or panic, reported as a divergence), "ts" or "mixed".
     */
    async function check(kase, mode) {
        if (mode === "stream" && kase.src !== "json" && kase.src !== "postman" && kase.src !== "mixed") return { status: "skip" };
        // The WebAssembly engine has no GraphQL input: GraphQL runs only through the CLIs.
        if (kase.src === "graphql" && mode !== "cli") return { status: "skip" };
        if (mode === "cli") {
            if (!cliCompatible(kase)) return { status: "skip" };
            const invocation = cliInvocation(kase);
            // One after the other: a worker is one busy process at a time.
            const expected = await runCli(commands.ref, invocation);
            const actual = await runCli(commands.ours, invocation);
            if (typeof expected.exit === "string") return { status: "timeout", detail: `reference ${expected.exit}` };
            return compareOutcomes(expected, actual);
        }

        const expected = await withTimeout(capture(() => sides.ref.wrap(() => runInProcess(sides.ref, kase, mode))));
        if (expected.timeout) return { status: "timeout", detail: "reference timed out" };
        const stats = sides.ours.stats;
        const before = { ...stats };
        const actual = await withTimeout(capture(() => sides.ours.wrap(() => runInProcess(sides.ours, kase, mode))));
        if (actual.timeout) return { status: "diff", engine: "?", detail: "ours timed out", expected, actual: "timeout" };
        const wasm = stats.wasm - before.wasm;
        const ts = stats.ts - before.ts;
        const engine =
            stats.rerun > before.rerun ? "rerun"
                : stats.unsupported > before.unsupported ? "fallback"
                    : wasm > 0 ? (ts > 0 ? "mixed" : "wasm") : ts > 0 ? "ts" : "none";
        const result = compareOutcomes(expected, actual);
        result.engine = engine;
        if (engine === "rerun" && result.status === "same" && /^RangeError: Maximum call stack size exceeded/.test(String(stats.lastFailure))) {
            // The engine overflowed V8's stack (WebAssembly cannot grow it,
            // so a deep or endless recursion can run out before the port's
            // own limit) and the facade redid the run on TypeScript, as
            // documented (PARITY.md, Known gaps). The result matched.
            result.engine = "rerun-stack";
        } else if (engine === "rerun" && result.status === "same") {
            result.status = "diff";
            result.detail = `the WebAssembly engine failed (trap or stack overflow); TypeScript redid the run: ${String(stats.lastFailure).slice(0, 2000)}`;
        }

        return result;
    }

    function compareOutcomes(expected, actual) {
        if (JSON.stringify(expected) === JSON.stringify(actual)) return { status: "same" };
        const d = firstDifference(expected, actual);
        return {
            status: "diff",
            detail: d === undefined ? "?" : `${d.path}: expected ${brief(d.expected, 200)}, got ${brief(d.actual, 200)}`,
            expected,
            actual,
        };
    }

    /**
     * The JSON Schema the reference makes of a JSON or Postman case (target
     * language "schema"), as a schema case with the same language and
     * options: realistic schemas with quicktype's own keywords. Undefined if
     * the reference fails.
     */
    async function chain(kase) {
        if (kase.src !== "json" && kase.src !== "postman") return undefined;
        const toSchema = { ...kase, lang: "schema", rendererOptions: {}, api: {}, debug: [] };
        const out = await withTimeout(capture(() => runInProcess(sides.ref, toSchema, "api")));
        if (out.ok === undefined || out.ok.$map.length !== 1) return undefined;
        const text = out.ok.$map[0][1].lines.join("\n");
        const derived = { ...kase, src: "schema", schemas: [{ name: "TopLevel", text }], chainedFrom: kase.src };
        delete derived.topLevels;
        delete derived.postman;
        return derived;
    }

    return { check, chain, sides };
}

/** A short signature of an outcome, to keep minimization on the same divergence. */
export function outcomeKind(outcome) {
    if (outcome === undefined || outcome === "timeout") return String(outcome);
    if ("exit" in outcome) return `exit ${outcome.exit}`;
    if (outcome.error !== undefined) return `error ${outcome.error.$error?.messageName ?? outcome.error.$error?.class ?? "?"}`;
    return "ok";
}
