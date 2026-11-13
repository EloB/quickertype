// A lossless JSON syntax tree: number literals keep their spelling (`1.0`,
// `1E+2`, `-0`), strings their escapes, objects their key order and
// duplicate keys. Both readers quicktype has care about these (the CLI's
// stream parser classifies `1.0` as a double, keeps duplicates and source
// order; `JSON.parse` does not), so generated samples and the minimizer
// work on this tree, never on parsed values.
//
//   { t: "o", e: [[keyNode, valueNode], ...] }   object
//   { t: "a", e: [node, ...] }                   array
//   { t: "s", raw }                              string (raw: the text between the quotes)
//   { t: "n", raw }                              number literal
//   { t: "l", raw }                              true, false or null

/** A string node for `value`, escaped like JSON.stringify (or with every non-ASCII character as `\u`). */
export function str(value, asciiOnly = false) {
    let raw = JSON.stringify(value).slice(1, -1);
    if (asciiOnly) {
        raw = raw.replace(/[^\x20-\x7e]/g, (c) => `\\u${c.charCodeAt(0).toString(16).padStart(4, "0")}`);
    }

    return { t: "s", raw };
}

export const num = (raw) => ({ t: "n", raw: String(raw) });
export const lit = (raw) => ({ t: "l", raw });
export const arr = (e) => ({ t: "a", e });
export const obj = (entries) => ({ t: "o", e: entries });

export function stringValue(node) {
    return JSON.parse(`"${node.raw}"`);
}

/** Serializes a tree. `indent`: undefined for compact text, else the indentation unit. */
export function toText(node, indent) {
    const out = [];
    const write = (n, depth) => {
        switch (n.t) {
            case "s":
                out.push(`"${n.raw}"`);
                return;
            case "n":
            case "l":
                out.push(n.raw);
                return;
            case "a":
            case "o": {
                const [open, close] = n.t === "a" ? ["[", "]"] : ["{", "}"];
                if (n.e.length === 0) {
                    out.push(open + close);
                    return;
                }

                out.push(open);
                n.e.forEach((item, i) => {
                    if (i > 0) out.push(",");
                    if (indent !== undefined) out.push(`\n${indent.repeat(depth + 1)}`);
                    if (n.t === "o") {
                        out.push(`"${item[0].raw}"`, indent === undefined ? ":" : ": ");
                        write(item[1], depth + 1);
                    } else {
                        write(item, depth + 1);
                    }
                });
                if (indent !== undefined) out.push(`\n${indent.repeat(depth)}`);
                out.push(close);
                return;
            }
            default:
                throw new Error(`bad node ${JSON.stringify(n)}`);
        }
    };
    write(node, 0);
    return out.join("");
}

/** Parses JSON text into a lossless tree; undefined if it is not JSON. */
export function parse(text) {
    let i = 0;
    const ws = () => {
        while (i < text.length && " \t\n\r".includes(text[i])) i++;
    };
    const fail = () => {
        throw new SyntaxError(`bad JSON at ${i}`);
    };
    const value = () => {
        ws();
        const c = text[i];
        if (c === "{") {
            i++;
            const e = [];
            ws();
            if (text[i] === "}") {
                i++;
                return obj(e);
            }

            for (;;) {
                ws();
                if (text[i] !== '"') fail();
                const key = string();
                ws();
                if (text[i] !== ":") fail();
                i++;
                e.push([key, value()]);
                ws();
                if (text[i] === ",") {
                    i++;
                    continue;
                }

                if (text[i] === "}") {
                    i++;
                    return obj(e);
                }

                fail();
            }
        }

        if (c === "[") {
            i++;
            const e = [];
            ws();
            if (text[i] === "]") {
                i++;
                return arr(e);
            }

            for (;;) {
                e.push(value());
                ws();
                if (text[i] === ",") {
                    i++;
                    continue;
                }

                if (text[i] === "]") {
                    i++;
                    return arr(e);
                }

                fail();
            }
        }

        if (c === '"') return string();
        const m = /^-?(0|[1-9]\d*)(\.\d+)?([eE][+-]?\d+)?/.exec(text.slice(i, i + 400));
        if (m !== null && m[0].length > 0 && m[0] !== "-") {
            i += m[0].length;
            return num(m[0]);
        }

        for (const word of ["true", "false", "null"]) {
            if (text.startsWith(word, i)) {
                i += word.length;
                return lit(word);
            }
        }

        return fail();
    };
    const string = () => {
        const start = ++i;
        while (i < text.length && text[i] !== '"') {
            if (text[i] === "\\") i++;
            i++;
        }

        if (i >= text.length) fail();
        const raw = text.slice(start, i);
        i++;
        JSON.parse(`"${raw}"`);
        return { t: "s", raw };
    };
    try {
        const v = value();
        ws();
        return i === text.length ? v : undefined;
    } catch {
        return undefined;
    }
}

/** Number of nodes, a size measure for minimization. */
export function size(node) {
    if (node.t === "a") return 1 + node.e.reduce((s, n) => s + size(n), 0);
    if (node.t === "o") return 1 + node.e.reduce((s, [, n]) => s + 1 + size(n), 0);
    return 1;
}
