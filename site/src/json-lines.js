// JSON Lines for quicktype, which has none: the worker of quicktype's own
// engine runs a JSON Lines input as the JSON array of its values, which is
// what quickertype reads JSON Lines as (`addSource({ jsonLines: true })`),
// so that the two engines' outputs can be compared byte for byte. Where the
// values are is quickertype-core's own scan (`scanJSONLines`, not public),
// so that the rules of JSON Lines (line breaks, a byte order mark, values
// over several lines) are those quickertype reads them by: the array is the
// values' text, joined by commas, in brackets.
//
// Text that is not JSON Lines, which quickertype rejects, gives an array
// that is not JSON either, so that quicktype fails on it too. A value that
// is not JSON stays as it is, which no array makes JSON again, but for two
// cases the array would turn into elements: a second value on a line (`"a"
// ,1`) and a number or literal with a comma in it (`1,2`). There the
// array's first character for that value is `#`, which JSON has nowhere.

import { scanJSONLines } from "../../npm/quicktype-core/dist/esm/native/lines.js";

const comma = 0x2c;
const quote = 0x22;
const leftBracket = 0x5b;
const leftBrace = 0x7b;
const notJson = 0x23;

/**
 * Whether the value at `[start, end)` of `code` (an accessor) is not one
 * JSON value in a way the array would hide: not an object, an array or a
 * string, and with a comma in it.
 */
function hasHiddenComma(code, start, end) {
    const first = code(start);
    if (first === quote || first === leftBracket || first === leftBrace) return false;
    for (let at = start; at < end; at++) if (code(at) === comma) return true;
    return false;
}

/**
 * The JSON text `[V1,…,Vn]` of the JSON Lines `text` (typed in the editor,
 * or a sample): the text of its values, as `scanJSONLines` finds them.
 */
export function jsonLinesToArray(text) {
    const code = (at) => text.charCodeAt(at);
    const parts = ["["];
    let previous;
    scanJSONLines(text, (start, end, ownLine) => {
        const first = previous === undefined || ownLine;
        const from = first ? start : previous;
        if (previous !== undefined && ownLine) parts.push(",");
        // On the line of the one before: as it is there, the whitespace between them too.
        const value = text.slice(from, end);
        parts.push(!first || hasHiddenComma(code, start, end) ? `#${value.slice(1)}` : value);
        previous = end;
    });
    parts.push("]");
    return parts.join("");
}

/** How much of a file `readForArray` reads at a time: 8 MiB. */
const slice = 1 << 23;

/**
 * The bytes of `file` into one buffer with a byte to spare at each end
 * (`jsonLinesToArrayInPlace`), read a slice at a time: no copy of the
 * whole file besides the buffer is ever made (in Chrome, on a 101 MB
 * file, the buffer and the text decoded from it peak at about 217 MiB, as
 * with a reader that reads into the buffer; reading `file.stream()`'s own
 * chunks peaked at 280 MiB). Throws what reading it throws; a file whose
 * size changed while it was read is an error too.
 */
export async function readForArray(file) {
    const size = file.size;
    const buffer = new Uint8Array(size + 2);
    for (let at = 0; at < size; at += slice) {
        const bytes = new Uint8Array(await file.slice(at, Math.min(size, at + slice)).arrayBuffer());
        if (bytes.length !== Math.min(slice, size - at)) throw new Error("the file changed while it was read");
        buffer.set(bytes, 1 + at);
    }

    return buffer;
}

/**
 * `jsonLinesToArray` of the JSON Lines in `buffer` (from `readForArray`:
 * the bytes between its first and last byte), made in the same buffer: the
 * array's UTF-8 bytes from its start, whose length is returned. Never
 * longer than the buffer: the array is the values, a comma for each line
 * break before one, and the brackets. Each value is copied to where it goes
 * after it was found, and it never goes past where it was, so nothing is
 * overwritten before it is scanned.
 */
export function jsonLinesToArrayInPlace(buffer) {
    const bytes = buffer.subarray(1, buffer.length - 1);
    const code = (at) => bytes[at];
    buffer[0] = leftBracket;
    let written = 1;
    let previous;
    scanJSONLines(bytes, (start, end, ownLine) => {
        const first = previous === undefined || ownLine;
        const from = first ? start : previous;
        // Looked at before it is copied, which may overwrite it.
        const hidden = !first || hasHiddenComma(code, start, end);
        if (previous !== undefined && ownLine) buffer[written++] = comma;
        buffer.copyWithin(written, 1 + from, 1 + end);
        if (hidden) buffer[written] = notJson;
        written += end - from;
        previous = end;
    });
    buffer[written++] = 0x5d;
    return written;
}
