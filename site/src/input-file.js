// Input files, for the page and its workers: their sizes in words, and
// whether a browser can read one as text at all.

/**
 * The largest file the playground reads as text, in bytes: V8's longest
 * string, 2^29 − 24 UTF-16 code units (Chrome, Edge, Node.js; Firefox and
 * Safari allow more). UTF-8 never decodes to more code units than it has
 * bytes, so a file this size or smaller fits. A larger one does not: Chrome
 * reads a 600 MB file as an empty string, and fails on a 3 GB one.
 */
export const maxTextBytes = 2 ** 29 - 24;

/**
 * The largest file the playground opens: quickertype reads a JSON array or
 * JSON Lines this large in parts, on several workers, without ever making
 * it one string (worker.js); quicktype, and quickertype where it reads a
 * file in one go, only up to `maxTextBytes` (but JSON Lines, read value by
 * value).
 */
export const maxFileBytes = 2 ** 31;

/**
 * The smallest file quickertype reads in parts, in bytes: below it, starting
 * the part workers costs a file's first read about what reading in parts
 * saves (docs/BENCHMARKS.md, "Reading on several workers").
 */
export const partsFrom = 16 << 20;

/** Where to get the CLI, which reads files of any size. */
export const cliLink = { href: "https://github.com/EloB/quickertype#install", text: "the quickertype CLI" };

export function formatBytes(n) {
    if (n < 1000) return `${n} bytes`;
    if (n < 1_000_000) return `${(n / 1000).toFixed(1)} kB`;
    if (n < 1_000_000_000) return `${(n / 1_000_000).toFixed(1)} MB`;
    return `${(n / 1_000_000_000).toFixed(1)} GB`;
}

/** Whether a file is JSON Lines by its name, as for the CLI: `*.jsonl` or `*.ndjson`, in any case. */
export const isJsonLinesName = (name) => /\.(jsonl|ndjson)$/i.test(name);

/**
 * The error for a file too large to read, or undefined if it is not: a file
 * of `size` bytes, whose text is decoded from `decoded` bytes (the file's
 * own, or, for quicktype's side of JSON Lines, the JSON array made of
 * them), past `limit` (by default the longest text). Its message names the
 * CLI; `link` is where to get it.
 */
export function tooLarge(name, size, decoded = size, limit = maxTextBytes) {
    if (size <= limit && decoded <= limit) return undefined;
    const array = decoded === size ? "" : ` Made into the JSON array that quicktype reads, it is ${decoded.toLocaleString("en-US")} bytes.`;
    return {
        title: `${name} is too large for the browser`,
        message: `This file is ${formatBytes(size)}.${array} Browsers can't hold text this large in one piece; use the quickertype CLI, which handles multi-GB files.`,
        link: cliLink,
    };
}

/** The error for a file that could not be read (`e`, what reading it threw). */
export function unreadable(name, e) {
    const reason = e?.message ? `${e.name && e.name !== "Error" ? `${e.name}: ` : ""}${e.message}` : String(e);
    return { title: `Could not read ${name}`, message: `Could not read ${name}: ${reason}` };
}
