// JSON Lines for quicktype, which has none: the worker of quicktype's own
// engine runs a JSON Lines input as the JSON array of its values, which is
// what quickertype reads JSON Lines as (`addSource({ jsonLines: true })`),
// so that the two engines' outputs can be compared byte for byte.

/** Whether a file is JSON Lines by its name, as for the CLI: `*.jsonl` or `*.ndjson`, in any case. */
export const isJsonLinesName = (name) => /\.(jsonl|ndjson)$/i.test(name);

const lineFeed = 0x0a;
const carriageReturn = 0x0d;
const space = 0x20;
const tab = 0x09;
const quote = 0x22;
const backslash = 0x5c;
const comma = 0x2c;

/**
 * The JSON text `[V1,…,Vn]` of the JSON Lines `source` (a string, or its
 * UTF-8 bytes; the same form back): its lines joined by commas inside
 * brackets, without blank lines and a leading byte order mark (as bytes,
 * the decoder's and then the text's, as quickertype-core drops them). A
 * value that spans lines (a line break inside an object or an array) keeps
 * its line breaks, and gets no comma. Never longer than `source` and the
 * two brackets: each comma or line break kept stands for a line feed left
 * out. For text that is not JSON Lines, the array is not JSON either, and
 * quicktype says so.
 */
export function jsonLinesToArray(source) {
    const bytes = typeof source !== "string";
    const length = source.length;
    const code = bytes ? (i) => source[i] : (i) => source.charCodeAt(i);
    let at = 0;
    if (bytes) {
        for (let marks = 0; marks < 2 && source[at] === 0xef && source[at + 1] === 0xbb && source[at + 2] === 0xbf; marks++) at += 3;
    } else if (source.charCodeAt(0) === 0xfeff) {
        at = 1;
    }

    const out = bytes ? new Uint8Array(length - at + 2) : undefined;
    let written = 0;
    const parts = [];
    const put = (byte, text) => {
        if (bytes) out[written++] = byte;
        else parts.push(text);
    };
    const copy = (start, end) => {
        if (bytes) {
            out.set(source.subarray(start, end), written);
            written += end - start;
        } else {
            parts.push(source.slice(start, end));
        }
    };

    put(0x5b, "[");
    let depth = 0;
    let values = 0;
    while (at < length) {
        let end = bytes ? source.indexOf(lineFeed, at) : source.indexOf("\n", at);
        if (end < 0) end = length;
        // What the line holds, and the nesting after it (a string ends with its line).
        let content = false;
        let nesting = depth;
        let inString = false;
        for (let i = at; i < end; i++) {
            const c = code(i);
            if (inString) {
                if (c === backslash) i++;
                else if (c === quote) inString = false;
                continue;
            }

            if (c === quote) inString = true;
            else if (c === 0x7b || c === 0x5b) nesting++;
            else if ((c === 0x7d || c === 0x5d) && nesting > 0) nesting--;
            else if (c === space || c === tab || c === carriageReturn) continue;
            content = true;
        }

        if (depth > 0) {
            // The value of the lines before goes on.
            put(lineFeed, "\n");
            copy(at, end);
        } else if (content) {
            if (values++ > 0) put(comma, ",");
            copy(at, end);
        }

        depth = nesting;
        at = end + 1;
    }

    put(0x5d, "]");
    return bytes ? out.subarray(0, written) : parts.join("");
}
