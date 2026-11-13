// Turning what an API call returned or threw into plain data that can be
// compared across two copies of quicktype-core (classes from different
// module instances are compared by name and fields).

/** Plain-data form of a result, an error or any value an API call gives. */
export function normalize(value, depth = 0) {
    if (depth > 200) return "[too deep]";
    const next = (v) => normalize(v, depth + 1);
    if (value instanceof Map) {
        return { $map: [...value].map(([k, v]) => [next(k), next(v)]) };
    }

    if (value instanceof Set) return { $set: [...value].map(next) };
    if (value instanceof Error) {
        return {
            $error: {
                class: value.constructor?.name,
                name: value.name,
                message: value.message,
                messageName: value.messageName,
                errorMessage: value.errorMessage,
                userMessage: value.userMessage,
                properties: next(value.properties),
            },
        };
    }

    if (Array.isArray(value)) return value.map(next);
    if (typeof value === "function") return "[function]";
    if (typeof value === "bigint") return { $bigint: value.toString() };
    if (typeof value === "number" && !Number.isFinite(value)) {
        return { $number: String(value) };
    }

    if (value !== null && typeof value === "object") {
        const proto = Object.getPrototypeOf(value);
        const plain = proto === Object.prototype || proto === null;
        const className = plain ? undefined : value.constructor?.name;
        if (className === "Ref") return { $ref: value.toString() };
        const out = {};
        if (className !== undefined) out.$class = className;
        for (const key of Object.keys(value)) out[key] = next(value[key]);
        return out;
    }

    return value;
}

/** The outcome of running `f`: its normalized result or error, and its console output. */
export async function capture(f) {
    const output = [];
    const saved = { log: console.log, error: console.error, warn: console.warn };
    const sink = (stream) => (...args) => output.push(`${stream}: ${args.map(String).join(" ")}`);
    console.log = sink("log");
    console.error = sink("error");
    console.warn = sink("warn");
    let outcome;
    try {
        outcome = { ok: normalize(await f()) };
    } catch (e) {
        outcome = { error: normalize(e) };
    } finally {
        Object.assign(console, saved);
    }

    // Timings differ from run to run.
    const console_ = output.map((line) => line.replace(/ took \d+(\.\d+)?ms$/, " took <ms>ms"));
    if (console_.length > 0) outcome.console = console_;
    return outcome;
}

/** The first difference between two JSON-able values, as a path and both sides. */
export function firstDifference(a, b, path = "$") {
    if (a === b) return undefined;
    if (typeof a !== typeof b || a === null || b === null || typeof a !== "object") {
        return { path, expected: a, actual: b };
    }

    if (Array.isArray(a) !== Array.isArray(b)) return { path, expected: a, actual: b };
    const keysA = Object.keys(a);
    const keysB = Object.keys(b);
    if (!Array.isArray(a) && keysA.join("\u0000") !== keysB.join("\u0000")) {
        return { path: `${path} (keys)`, expected: keysA, actual: keysB };
    }

    const length = Math.max(keysA.length, keysB.length);
    for (let i = 0; i < length; i++) {
        const key = Array.isArray(a) ? i : keysA[i];
        const d = firstDifference(a[key], b[key], `${path}.${key}`);
        if (d !== undefined) return d;
    }

    return undefined;
}

/** A short, readable rendering of a value for the report. */
export function brief(value, max = 300) {
    const text = typeof value === "string" ? JSON.stringify(value) : JSON.stringify(value);
    if (text === undefined) return String(value);
    return text.length > max ? `${text.slice(0, max)}…` : text;
}

const notPortedPattern = /^Internal error: The (.+) renderer is not ported yet$/;

/** The language whose renderer the Rust engine does not have yet, if that is why `outcome` failed. */
export function notPortedLanguage(outcome) {
    const message = outcome?.error?.$error?.message;
    const match = typeof message === "string" ? notPortedPattern.exec(message) : null;
    return match === null ? undefined : match[1];
}
