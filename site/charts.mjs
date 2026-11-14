// The site's charts: static SVG in HTML, drawn at build time from the data
// (no script). Used by the benchmarks page (site/benchmarks.mjs) and the
// landing page (site/landing.mjs); the README's chart files could draw from
// the same pieces.
//
// A chart's labels are HTML text where they can be (they wrap, and stay
// legible at any width) and its marks SVG placed in percent of their row, so
// one drawing serves a phone and a wide screen. The colours are the pages'
// stylesheets' (classes, not attributes): quickertype `ours` (the violet
// accent), quicktype `theirs` (the gray it is compared with; checked with the
// dataviz palette validator against both themes). Every drawing is an image
// with an accessible name and a <title>, or hidden beside text that says
// what it shows, and every chart has its numbers in a table.

import { escapeHtml as e } from "./src/html.js";

/** A fraction as a percentage for SVG coordinates: 0.5 → "50.00%" (clamped to 0–1). */
export const pct = (x) => `${(Math.max(0, Math.min(1, x)) * 100).toFixed(2)}%`;

let idPrefix = "c";
let idCount = 0;

/** Restarts the ids that clip paths take (`c1`, `c2`, … by default): once per page, before its charts. */
export function startIds(prefix = "c") {
    idPrefix = prefix;
    idCount = 0;
}

/**
 * One bar, `fraction` of its row wide, rounded at its end and square at the
 * baseline: a nested <svg> clips the square cap to the bar, however narrow.
 * `parts` splits it ([fraction of the bar, class]).
 */
export function bar({ fraction, y = 2, height = 12, kind, parts }) {
    const segments = (parts ?? [[1, ""]])
        .reduce(
            (acc, [share, cls]) => {
                acc.list.push(`<rect x="${pct(acc.at)}" width="${pct(share)}" height="${height}" class="${cls}"/>`);
                acc.at += share;
                return acc;
            },
            { at: 0, list: [] },
        )
        .list.join("");
    const id = `${idPrefix}${++idCount}`;
    // The rounded end: the whole bar with rx, its baseline end squared by a cap.
    return `<svg x="0" y="${y}" width="${pct(fraction)}" height="${height}" class="bar-mark ${kind}" overflow="hidden"><clipPath id="${id}"><rect width="100%" height="${height}" rx="4"/><rect width="8" height="${height}"/></clipPath><g clip-path="url(#${id})">${segments}</g></svg>`;
}

/** A value at a bar's tip. */
export const tip = (fraction, y, label) => `<text x="${pct(fraction)}" dx="6" y="${y}" class="tip">${e(label)}</text>`;

/** An <svg> drawing a row's bars: an image, with its accessible name. */
export function rowSvg(label, height, content) {
    return `<svg class="bars-svg" width="100%" height="${height}" role="img" aria-label="${e(label)}"><title>${e(label)}</title>${content}</svg>`;
}

/** A table of a chart's numbers, closed by default. */
export function tableView(caption, head, rows) {
    return `<details class="table-view"><summary>The numbers as a table</summary><table><caption>${e(caption)}</caption><thead><tr>${head
        .map((h, i) => `<th scope="col"${i > 0 ? ' class="num"' : ""}>${e(h)}</th>`)
        .join("")}</tr></thead><tbody>${rows
        .map((r) => `<tr>${r.map((c, i) => (i === 0 ? `<th scope="row">${e(c)}</th>` : `<td class="num">${e(c)}</td>`)).join("")}</tr>`)
        .join("")}</tbody></table></details>`;
}

/** The legend: quicktype (gray) and quickertype (violet). */
export const legend = (theirs = "quicktype", ours = "quickertype") =>
    `<p class="legend"><span class="key theirs" aria-hidden="true"></span>${e(theirs)}<span class="key ours" aria-hidden="true"></span>${e(ours)}</p>`;

/**
 * The room a bar's tip label needs, as a fraction of the narrowest row (a
 * 328 px phone column): bars stop short of it, so the label never leaves
 * the row.
 */
export const roomFor = (label) => Math.min(0.5, (label.length * 7.4 + 10) / 328);

// ---------------------------------------------------------------------------
// Chart forms

/** Two bars on one scale, each named (quicktype, quickertype), values at the tips or beside the names. */
export function pairChart({ theirs, ours, tips = true, more = false }) {
    const room = tips ? Math.max(roomFor(theirs.tip), roomFor(ours.tip)) : 0.08;
    const top = Math.max(theirs.value, ours.value) / (1 - room);
    const row = (side, kind) =>
        `<li class="bar-row"><span class="bar-name"><span class="key ${kind}" aria-hidden="true"></span>${e(side.name)}</span>${
            tips ? "" : `<span class="bar-value">${e(side.text)}</span>`
        }${rowSvg(
            side.label,
            16,
            // A value too small to see still gets a mark (3 px).
            (side.value / top < 0.004
                ? `<rect x="0" y="2" width="3" height="12" rx="1.5" class="bar-mark ${kind}"/>`
                : bar({ fraction: side.value / top, kind })) +
                (more && kind === "theirs" ? `<rect x="${pct(side.value / top)}" y="2" width="${pct(room * 0.8)}" height="12" class="more"/>` : "") +
                (tips ? tip(side.value / top, 12.5, side.tip) : ""),
        )}</li>`;
    return `<ol class="bars pair">${row(theirs, "theirs")}${row(ours, "ours")}</ol>`;
}

/**
 * quicktype's bar over quickertype's, for each row, all on one scale: `rows`
 * is `[{ name, theirs, ours, value }]` (`value`: the text beside the bars,
 * e.g. "54× faster"), `format` writes a value for the tips and labels. The
 * rows' list, as HTML.
 */
export function pairRows({ rows, format, what }) {
    const values = rows.flatMap((r) => [r.theirs, r.ours]);
    const room = Math.max(...values.map((v) => roomFor(format(v))));
    const top = Math.max(...values) / (1 - room);
    return `<ol class="bars">${rows
        .map((row) => {
            const label = `${row.name}: ${what ? `${what}, ` : ""}quicktype ${format(row.theirs)}, quickertype ${format(row.ours)}`;
            return `<li class="bar-row"><span class="bar-name">${e(row.name)}</span><span class="bar-value">${e(row.value)}</span>${rowSvg(
                label,
                30,
                bar({ fraction: row.theirs / top, y: 2, kind: "theirs" }) +
                    tip(row.theirs / top, 12.5, format(row.theirs)) +
                    // A value too small to see still gets a mark (3 px).
                    (row.ours / top < 0.004 ? `<rect x="0" y="16" width="3" height="12" rx="1.5" class="bar-mark ours"/>` : bar({ fraction: row.ours / top, y: 16, kind: "ours" })) +
                    tip(row.ours / top, 26.5, format(row.ours)),
            )}</li>`;
        })
        .join("")}</ol>`;
}

/**
 * One bar per row on a common scale from zero, of one series (`kind`):
 * `rows` is `[{ name, value, text, tip, label }]` (`text` beside the bar,
 * `tip` at its end, `label` its accessible name). The rows' list, as HTML.
 */
export function valueRows({ rows, kind = "ours" }) {
    const room = Math.max(...rows.map((r) => roomFor(r.tip)));
    const top = Math.max(...rows.map((r) => r.value)) / (1 - room);
    return `<ol class="bars">${rows
        .map(
            (row) =>
                `<li class="bar-row"><span class="bar-name">${e(row.name)}</span><span class="bar-value">${e(row.text)}</span>${rowSvg(
                    row.label,
                    16,
                    bar({ fraction: row.value / top, kind }) + tip(row.value / top, 12.5, row.tip),
                )}</li>`,
        )
        .join("")}</ol>`;
}

/**
 * Columns over a baseline, one series (`kind`), as one <svg> `height` px
 * tall and as wide as its box: `columns` is `[{ label, value, title }]`
 * (`label` under the column, the value over it, `title` its accessible
 * name). `name` is the drawing's.
 */
export function columnChart({ columns, height = 168, kind = "theirs", name, format = String }) {
    const top = Math.max(...columns.map((c) => c.value));
    const plot = { top: 22, bottom: height - 24 };
    const band = 1 / columns.length;
    const width = band * 0.62;
    const marks = columns
        .map((c, i) => {
            const h = Math.max(2, ((plot.bottom - plot.top) * c.value) / top);
            const x = i * band + (band - width) / 2;
            const id = `${idPrefix}${++idCount}`;
            const middle = pct(i * band + band / 2);
            return `<g class="column"><title>${e(c.title)}</title><svg x="${pct(x)}" y="${plot.bottom - h}" width="${pct(width)}" height="${h}" class="bar-mark ${kind}" overflow="hidden"><clipPath id="${id}"><rect width="100%" height="${h}" rx="4"/><rect y="${Math.max(0, h - 8)}" width="100%" height="${Math.min(8, h)}"/></clipPath><rect width="100%" height="${h}" clip-path="url(#${id})"/></svg><text x="${middle}" y="${plot.bottom - h - 6}" class="tip" text-anchor="middle">${e(format(c.value))}</text><text x="${middle}" y="${height - 6}" class="axis" text-anchor="middle">${e(c.label)}</text></g>`;
        })
        .join("");
    return `<svg class="columns-svg" width="100%" height="${height}" role="img" aria-label="${e(name)}"><title>${e(name)}</title><line x1="0" x2="100%" y1="${plot.bottom + 0.5}" y2="${plot.bottom + 0.5}" class="baseline"/>${marks}</svg>`;
}
