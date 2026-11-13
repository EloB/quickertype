// Light syntax highlighting for the generated code: comments, strings,
// numbers, keywords and capitalized names (types, mostly). One regular
// expression per comment style, no grammars; good enough for code that
// quicktype wrote, and small. Output above `limit` characters stays plain.

import { escapeHtml } from "./html.js";

const keywords = new Set(
    `abstract and as async await break case catch class const continue data def default defmodule defstruct
    deriving do else end enum export extends extension extern false final fn for from func function get guard
    if impl implements import in init interface internal is late let module mut namespace new nil null object
    of open or override package private protected protocol pub public readonly record required return self
    set static struct super switch then this throw throws true try type typealias typedef union use using val
    var void when where while with`.split(/\s+/),
);

/** Line comment, block comment and whether '…' is a string, by language. */
function syntax(lang) {
    if (["python", "ruby", "elixir", "crystal"].includes(lang)) return { line: "#", block: undefined, single: true };
    if (["haskell", "elm"].includes(lang)) return { line: "--", block: ["{-", "-}"], single: false };
    const single = ["typescript", "javascript", "flow", "javascript-prop-types", "typescript-zod", "typescript-effect-schema", "php", "dart"].includes(lang);
    return { line: "//", block: ["/*", "*/"], single };
}

const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
const cache = new Map();

function tokenizer(lang) {
    let re = cache.get(lang);
    if (re !== undefined) return re;
    const { line, block, single } = syntax(lang);
    const comment = [`${escapeRe(line)}[^\\n]*`];
    if (block !== undefined) comment.push(`${escapeRe(block[0])}[\\s\\S]*?${escapeRe(block[1])}`);
    const strings = ['"(?:[^"\\\\\\n]|\\\\.)*"'];
    if (single) strings.push("'(?:[^'\\\\\\n]|\\\\.)*'", "`(?:[^`\\\\]|\\\\.)*`");
    re = new RegExp(
        `(${comment.join("|")})|(${strings.join("|")})|(\\b\\d[\\d_]*(?:\\.\\d+)?(?:[eE][+-]?\\d+)?\\b)|([A-Za-z_][A-Za-z0-9_]*)`,
        "g",
    );
    cache.set(lang, re);
    return re;
}

/** `text` as HTML with highlighting spans, or `undefined` if it is too long to bother. */
export function highlight(text, lang, limit = 300_000) {
    if (text.length > limit) return undefined;
    const re = tokenizer(lang);
    re.lastIndex = 0;
    let html = "";
    let last = 0;
    for (let match = re.exec(text); match !== null; match = re.exec(text)) {
        let cls;
        if (match[1] !== undefined) cls = "c";
        else if (match[2] !== undefined) cls = "s";
        else if (match[3] !== undefined) cls = "n";
        else if (keywords.has(match[4])) cls = "k";
        else if (/^[A-Z]/.test(match[4])) cls = "t";
        else continue;
        html += `${escapeHtml(text.slice(last, match.index))}<span class="${cls}">${escapeHtml(match[0])}</span>`;
        last = re.lastIndex;
    }

    return html + escapeHtml(text.slice(last));
}
