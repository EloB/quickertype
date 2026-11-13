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
        if (mode === "stream" && kase.src !== "json") return { status: "skip" };
        if (mode === "cli") {
            if (!cliCompatible(kase)) return { status: "skip" };
            const invocation = cliInvocation(kase);
            const [expected, actual] = await Promise.all([runCli(commands.ref, invocation), runCli(commands.ours, invocation)]);
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
        if (engine === "rerun" && result.status === "same") {
            result.status = "diff";
            result.detail = "the WebAssembly engine failed (trap or stack overflow); TypeScript redid the run";
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

    return { check, sides };
}

/** A short signature of an outcome, to keep minimization on the same divergence. */
export function outcomeKind(outcome) {
    if (outcome === undefined || outcome === "timeout") return String(outcome);
    if ("exit" in outcome) return `exit ${outcome.exit}`;
    if (outcome.error !== undefined) return `error ${outcome.error.$error?.messageName ?? outcome.error.$error?.class ?? "?"}`;
    return "ok";
}
