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
 * The largest JSON Lines file quickertype reads in one go (where it cannot
 * read it in parts), in bytes: 1.25 GiB. Its engine holds the file's bytes
 * and their compressed form in at most 4 GiB of WebAssembly memory: in
 * Chrome, distinct cards of 1.0, 1.26, 1.50 and 1.77 GB took 2,874, 3,326,
 * 3,659 and 3,968 MiB, and 2.0 GB ran out of it; the real cards take more
 * per byte (1,710 MiB at 656 MB), about 3.5 GiB at this size
 * (docs/BENCHMARKS.md, "Reading on several workers").
 */
export const linesInOneGo = 1.25 * 2 ** 30;

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
 * CLI; `link` is where to get it. Bytes past the longest text may still
 * decode to a text that fits (UTF-8 takes one to four bytes for a UTF-16
 * unit): `textTooLarge` is the error once its text is known not to.
 */
export function tooLarge(name, size, decoded = size, limit = maxTextBytes) {
    if (size <= limit && decoded <= limit) return undefined;
    return textTooLarge(name, size, decoded);
}

/** `tooLarge`'s error, for a file whose text does not fit, whatever its size says. */
export function textTooLarge(name, size, decoded = size) {
    const array = decoded === size ? "" : ` Made into the JSON array that quicktype reads, it is ${decoded.toLocaleString("en-US")} bytes.`;
    return {
        title: `${name} is too large for the browser`,
        message: `This file is ${formatBytes(size)}.${array} Browsers can't hold text this large in one piece; use the quickertype CLI, which handles multi-GB files.`,
        link: cliLink,
    };
}

/**
 * How many UTF-16 units the UTF-8 `bytes` decode to (as `TextDecoder`
 * decodes them: a leading byte order mark is not part of the text): every
 * byte that does not continue a sequence starts a unit, and one of four
 * bytes two. Exact for UTF-8; for bytes that are not, about what the
 * decoder's replacement characters take.
 */
export function utf16Length(bytes) {
    let units = 0;
    for (let i = 0; i < bytes.length; i++) {
        const b = bytes[i];
        if ((b & 0xc0) !== 0x80) units += b >= 0xf0 ? 2 : 1;
    }

    return bytes.length >= 3 && bytes[0] === 0xef && bytes[1] === 0xbb && bytes[2] === 0xbf ? units - 1 : units;
}

/**
 * Whether the text of a file of `size` bytes certainly fits `limit` units
 * (it has no more units than bytes), certainly does not (every unit takes
 * at most three bytes), or must be counted (`undefined`).
 */
export function textFits(size, limit) {
    if (size <= limit) return true;
    if (size > 3 * limit + 3) return false;
    return undefined;
}

/**
 * A text decoded from a file of `size` bytes, as browsers decode it: one
 * too long for a string comes back as "" (Chrome, without an error), which
 * only a file of a byte order mark or nothing decodes to.
 */
export function decodedTooLong(text, size) {
    return text.length === 0 && size > 3;
}

/**
 * The error for a file quickertype reads only in parts, which could not be
 * (`why`): read in one go, it is more than a browser holds. Its message
 * names the CLI.
 */
export function tooLargeInOneGo(name, size, why) {
    return {
        title: `${name} is too large to read in one go`,
        message: `This file is ${formatBytes(size)}. quickertype reads a file this large in the browser only in parts, on several workers, and this one could not be read so (${why}); use the quickertype CLI, which handles multi-GB files.`,
        link: cliLink,
    };
}

/** The error for a file that could not be read (`e`, what reading it threw). */
export function unreadable(name, e) {
    const reason = e?.message ? `${e.name && e.name !== "Error" ? `${e.name}: ` : ""}${e.message}` : String(e);
    return { title: `Could not read ${name}`, message: `Could not read ${name}: ${reason}` };
}
