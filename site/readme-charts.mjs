// The README's charts: docs/assets/charts/*.svg, static SVG drawn from the
// numbers in the README's "Speed and memory" tables, so a chart says
// exactly what the table beside it says.
//
//   node site/readme-charts.mjs           writes the charts
//   node site/readme-charts.mjs --check   fails if a chart is missing, stale
//                                         or unknown, or the README does not
//                                         show it (site/test/smoke.mjs runs this)
//
// The rows come from the README, which rounds and groups the numbers of
// site/data/benchmarks.json and browser.json (see docs/BENCHMARKS.md,
// "README charts"). Reading them is one step (`readmeRows`); the charts are
// drawn from the rows alone (`chartsFor`), so drawing them from the data
// files would mean writing rows from those instead.
//
// Every chart is drawn twice, for light and dark backgrounds, and the README
// shows them with <picture>: GitHub picks the one for its theme, crates.io
// and npm keep <picture> too, and anything that drops it shows the light
// one (the <img>). Each is a card with its own background, readable on
// either. The URLs are absolute (raw.githubusercontent.com, main): npm does
// not resolve relative image paths, nor crates.io a relative srcset.
//
// The look is the benchmarks page's (site/src/base.css, read here): its
// panel, ink and rule colours, its system font stack, quickertype the
// violet accent and quicktype the gray (the emphasis form). Values are
// printed at the bars' tips, so no axis is drawn. No script, no stylesheet,
// no web font: a system font, and presentation attributes only.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { escapeHtml } from "./src/html.js";

const siteRoot = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(siteRoot, "..");
export const readmeFile = path.join(repositoryRoot, "README.md");
export const chartsDir = path.join(repositoryRoot, "docs", "assets", "charts");
const baseCss = path.join(siteRoot, "src", "base.css");

/** Where the README loads a chart from: the file on main, as GitHub serves it raw. */
export const chartUrl = (file) => `https://raw.githubusercontent.com/EloB/quickertype/main/docs/assets/charts/${file}`;

const regenerate = "node site/readme-charts.mjs";

// ---------------------------------------------------------------------------
// The rows, from the README's tables

/**
 * A table row's first cell as text and code spans: "`pokedex.json` (82 KB)"
 * → [{ code: true, text: "pokedex.json" }, { code: false, text: " (82 KB)" }].
 */
function inline(markdown, where) {
    const parts = markdown.split("`");
    if (parts.length % 2 === 0) throw new Error(`${where}: an unclosed \` in "${markdown}"`);
    return parts.map((text, i) => ({ code: i % 2 === 1, text })).filter((part) => part.text !== "");
}

const plain = (label) => label.map((part) => part.text).join("");

/** A table's body, its cells row by row, from its lines: refused unless its header is `head`. */
function tableBody(lines, head, where) {
    const rows = lines.map((line) => {
        const cells = line.trim();
        if (!cells.startsWith("|") || !cells.endsWith("|") || cells.includes("\\|")) throw new Error(`${where}: a row that is not | a | b |: ${line.trim()}`);
        return cells
            .slice(1, -1)
            .split("|")
            .map((cell) => cell.trim());
    });
    const [header, separator, ...body] = rows;
    if (header.join("|") !== head.join("|")) throw new Error(`${where}: the header is | ${header.join(" | ")} |, not | ${head.join(" | ")} |`);
    if (separator === undefined || !separator.every((cell) => /^:?-+:?$/.test(cell))) throw new Error(`${where}: no separator line under the header`);
    if (body.length === 0) throw new Error(`${where}: no rows`);
    for (const row of body) {
        if (row.length !== head.length) throw new Error(`${where}: a row with ${row.length} cells, not ${head.length}: | ${row.join(" | ")} |`);
    }
    return body;
}

/** A ratio cell: "96×", "35–50×", "10× less". */
function ratio(cell, where) {
    const m = /^(\d+(?:\.\d+)?)(?:–(\d+(?:\.\d+)?))?×( less)?$/.exec(cell);
    if (m === null) throw new Error(`${where}: "${cell}" is not a ratio (96×, 35–50× or 10× less)`);
    const low = Number(m[1]);
    const high = m[2] === undefined ? low : Number(m[2]);
    if (m[2] !== undefined && !(high > low)) throw new Error(`${where}: "${cell}" is not a range from low to high`);
    return { low, high, text: cell.replace(/ less$/, ""), less: m[3] !== undefined };
}

/** An amount of memory: "625 MiB", "1.2 GiB", as MiB. */
function mebibytes(cell, where) {
    const m = /^(\d{1,3}(?:,\d{3})*(?:\.\d+)?) (KiB|MiB|GiB)$/.exec(cell);
    if (m === null) throw new Error(`${where}: "${cell}" is not an amount of memory (625 MiB)`);
    return Number(m[1].replaceAll(",", "")) * { KiB: 1 / 1024, MiB: 1, GiB: 1024 }[m[2]];
}

/** The tables the charts are drawn from, by their header: the first column's name, then the rest. */
const tables = [
    { id: "cli", head: ["Run", "quicktype", "quickertype", "Faster"] },
    { id: "browser", head: ["Input", "quicktype", "quickertype", "Faster"] },
];

/**
 * The rows of the README's two tables in "Speed and memory": the CLI's
 * (`cli`) and the WebAssembly engine's in the browser (`browser`). Each row
 * is `{ label, theirs, ours, ratio }`: the first cell as text and code
 * spans, quicktype's and quickertype's cells as written, and the last cell
 * read (see `ratio`). Refuses a section or a table it does not know.
 */
export function readmeRows(markdown) {
    const where = "README.md";
    const start = markdown.search(/^## Speed and memory$/m);
    if (start < 0) throw new Error(`${where}: no "## Speed and memory" section`);
    const rest = markdown.slice(start + 1);
    const end = rest.search(/^## /m);
    const section = end < 0 ? rest : rest.slice(0, end);

    // The tables: runs of lines starting with "|" (indented in a list item, or not).
    const found = [];
    let current;
    for (const line of section.split("\n")) {
        if (/^\s*\|/.test(line)) {
            if (current === undefined) found.push((current = []));
            current.push(line);
        } else {
            current = undefined;
        }
    }
    if (found.length !== tables.length) throw new Error(`${where}: "Speed and memory" has ${found.length} tables, not ${tables.length} (the CLI's and the browser's)`);

    const rows = {};
    tables.forEach(({ id, head }, i) => {
        const at = `${where}, the ${id === "cli" ? "CLI's" : "browser's"} table`;
        rows[id] = tableBody(found[i], head, at).map(([label, theirs, ours, last]) => {
            const row = `${at}, row "${label}"`;
            return { label: inline(label, row), theirs, ours, ratio: ratio(last, row) };
        });
    });
    return rows;
}

// ---------------------------------------------------------------------------
// The charts, from rows

/**
 * The charts the README shows, from rows (whatever their source): `{ file,
 * title, subtitle }` and either `ratios`, rows whose bars are how many times
 * faster quickertype is, or `pairs`, quicktype's and quickertype's amounts.
 * `cli` holds times (N× faster) and at most one peak memory row (N× less);
 * `browser`, times.
 */
export function chartsFor({ cli, browser }) {
    const times = cli.filter((row) => !row.ratio.less);
    const memory = cli.filter((row) => row.ratio.less);
    for (const row of browser) {
        if (row.ratio.less) throw new Error(`the browser's row "${plain(row.label)}" says "${row.ratio.text} less": the browser's chart shows how many times faster`);
    }
    for (const row of memory) {
        if (!/^Peak memory\b/.test(plain(row.label))) throw new Error(`the CLI's row "${plain(row.label)}" says "N× less" but is not peak memory`);
    }
    if (memory.length > 1) throw new Error("the CLI's rows have more than one peak memory row: the memory chart shows one");

    return [
        {
            file: "cli-speed",
            title: "How many times faster quickertype's CLI is",
            subtitle: "Against quicktype's CLI on the same inputs; wall time",
            ratios: times,
        },
        ...memory.map((row) => ({
            file: "cli-memory",
            title: plain(row.label),
            subtitle: `quickertype's CLI uses ${row.ratio.text} less than quicktype's`,
            pairs: [
                { who: "theirs", name: "quicktype", value: mebibytes(row.theirs, plain(row.label)), text: row.theirs },
                { who: "ours", name: "quickertype", value: mebibytes(row.ours, plain(row.label)), text: row.ours },
            ],
        })),
        {
            file: "browser-speed",
            title: "In the browser: how many times faster",
            subtitle: "quickertype's WebAssembly engine against quicktype's TypeScript engine, warm, in the same page",
            ratios: browser,
        },
    ];
}

/** What a chart says, in words: its <desc>. */
function description(chart) {
    if (chart.pairs) return `${chart.subtitle}. ${chart.pairs.map((p) => `${p.name}: ${p.text}`).join("; ")}.`;
    return `${chart.subtitle}. ${chart.ratios.map((row) => `${plain(row.label)}: ${row.ratio.text} faster (quicktype ${row.theirs}, quickertype ${row.ours})`).join("; ")}.`;
}

// ---------------------------------------------------------------------------
// Drawing

/** The site's colours and fonts (site/src/base.css), light and dark. */
export function siteTokens(css = fs.readFileSync(baseCss, "utf8")) {
    const block = (from) => {
        const open = css.indexOf(":root {", from);
        if (open < 0) throw new Error("site/src/base.css: no :root block");
        return css.slice(open, css.indexOf("}", open));
    };
    const tokens = (text) => Object.fromEntries([...text.matchAll(/--([\w-]+):\s*([^;]+);/g)].map((m) => [m[1], m[2].trim()]));
    const darkAt = css.indexOf("@media (prefers-color-scheme: dark)");
    if (darkAt < 0) throw new Error("site/src/base.css: no dark block");
    const light = tokens(block(0));
    const dark = { ...light, ...tokens(block(darkAt)) };
    const theme = (t) => {
        const pick = {};
        for (const name of ["panel", "ink", "muted", "rule", "viz-ours", "viz-theirs", "sans", "mono"]) {
            if (t[name] === undefined) throw new Error(`site/src/base.css: no --${name}`);
            pick[name] = t[name];
        }
        return pick;
    };
    return { light: theme(light), dark: theme(dark) };
}

/** `a` mixed with `b`, `share` of it `a`: two #rrggbb colours. */
function mix(a, b, share) {
    const rgb = (hex) => [1, 3, 5].map((i) => parseInt(hex.slice(i, i + 2), 16));
    const [x, y] = [rgb(a), rgb(b)];
    return `#${x.map((v, i) => Math.round(v * share + y[i] * (1 - share)).toString(16).padStart(2, "0")).join("")}`;
}

/** A coordinate as the SVG writes it: at most two decimals, the same bytes on every machine. */
const n = (x) => String(Math.round(x * 100) / 100);

/**
 * About how wide `text` is at `size` px: Arial's advance widths, 10% wider
 * (system fonts differ; DejaVu Sans, Linux's, is wider than Arial). Used to
 * wrap lines and to leave room for the values at the bars' tips, never to
 * place text after other text, so a narrower font only leaves more room.
 */
function textWidth(text, size, { bold = false, code = false } = {}) {
    if (code) return text.length * 0.62 * size;
    const widths = {
        " ": 278, "'": 191, "(": 333, ")": 333, ",": 278, ".": 278, ":": 278, ";": 278, "-": 333, "–": 556, "→": 1000, "×": 584, "/": 278, "%": 889,
        f: 278, i: 222, j: 222, l: 222, r: 333, t: 278, m: 833, w: 722, c: 500, k: 500, s: 500, v: 500, x: 500, y: 500, z: 500,
        I: 278, J: 500, M: 833, W: 944, F: 611, T: 611, Z: 611, L: 556,
    };
    let em = 0;
    for (const c of text) em += widths[c] ?? (/[A-Z]/.test(c) ? 722 : 556);
    return (em / 1000) * size * 1.1 * (bold ? 1.08 : 1);
}

/**
 * Text and code spans broken into lines no wider than `width`, at spaces
 * (text and code with no space between stay together: "(`--version`)").
 */
function wrap(parts, size, width) {
    const words = [[]];
    for (const part of parts) {
        part.text.split(" ").forEach((piece, i) => {
            if (i > 0 && words.at(-1).length > 0) words.push([]);
            if (piece !== "") words.at(-1).push({ code: part.code, text: piece });
        });
    }
    const space = textWidth(" ", size);
    const lines = [];
    let used = 0;
    for (const word of words.filter((w) => w.length > 0)) {
        const w = word.reduce((sum, s) => sum + textWidth(s.text, s.code ? size - 1 : size, { code: s.code }), 0);
        if (lines.length === 0 || used + space + w > width) {
            lines.push([...word]);
            used = w;
        } else {
            lines.at(-1).push({ code: false, text: " " }, ...word);
            used += space + w;
        }
    }
    // Neighbouring spans of one kind as one.
    return lines.map((line) =>
        line.reduce((spans, span) => {
            const last = spans.at(-1);
            if (last && last.code === span.code) last.text += span.text;
            else spans.push({ ...span });
            return spans;
        }, []),
    );
}

const e = escapeHtml;

/** A line of text and code spans as SVG <text>. */
function textLine(spans, x, y, { size, fill, weight, fonts }) {
    const content = spans.map((s) => (s.code ? `<tspan font-family="${fonts.mono}" font-size="${size - 1}">${e(s.text)}</tspan>` : e(s.text))).join("");
    return `<text x="${n(x)}" y="${n(y)}" font-size="${size}"${weight ? ` font-weight="${weight}"` : ""} fill="${fill}">${content}</text>`;
}

/** A bar from `x0` to `x1`: square at the baseline, its data end rounded (4 px), unless `square`. */
function barPath(x0, x1, y, height, fill, { square = false } = {}) {
    const r = square ? 0 : Math.min(4, (x1 - x0) / 2, height / 2);
    if (r === 0) return `<rect x="${n(x0)}" y="${n(y)}" width="${n(x1 - x0)}" height="${n(height)}" fill="${fill}"/>`;
    const d = `M${n(x0)} ${n(y)}H${n(x1 - r)}A${n(r)} ${n(r)} 0 0 1 ${n(x1)} ${n(y + r)}V${n(y + height - r)}A${n(r)} ${n(r)} 0 0 1 ${n(x1 - r)} ${n(y + height)}H${n(x0)}Z`;
    return `<path d="${d}" fill="${fill}"/>`;
}

/** The layout, in px of the SVG (shown 1:1 at its width, scaled down on narrower screens). */
const W = 520;
const PAD = 20;
const TITLE = { size: 15, line: 20 };
const SUBTITLE = { size: 12.5, line: 17 };
const LABEL = { size: 13.5, line: 18 };
const VALUE = { size: 13.5 };
const BAR = { height: 12, above: 7, below: 18 };

/** A chart as SVG, for the light or the dark theme. */
export function chartSvg(chart, themeName, tokens = siteTokens()) {
    const t = tokens[themeName];
    const fonts = { sans: t.sans.replaceAll('"', "'"), mono: t.mono.replaceAll('"', "'") };
    const inner = W - 2 * PAD;
    const out = [];
    let y = PAD;

    for (const line of wrap([{ code: false, text: chart.title }], TITLE.size, inner)) {
        out.push(textLine(line, PAD, y + TITLE.size, { size: TITLE.size, fill: t.ink, weight: 600, fonts }));
        y += TITLE.line;
    }
    y += 1;
    for (const line of wrap([{ code: false, text: chart.subtitle }], SUBTITLE.size, inner)) {
        out.push(textLine(line, PAD, y + SUBTITLE.size, { size: SUBTITLE.size, fill: t.muted, fonts }));
        y += SUBTITLE.line;
    }
    y += 14;

    // One scale for the chart: its largest value ends where the room for
    // the widest value label begins.
    const bars = chart.ratios
        ? chart.ratios.map((row) => ({ label: row.label, low: row.ratio.low, high: row.ratio.high, text: row.ratio.text, fill: t["viz-ours"] }))
        : chart.pairs.map((p) => ({ label: [{ code: false, text: p.name }], low: p.value, high: p.value, text: p.text, fill: t[`viz-${p.who}`] }));
    const room = Math.max(...bars.map((b) => textWidth(b.text, VALUE.size, { bold: true }))) + 8;
    const top = Math.max(...bars.map((b) => b.high));
    const x = (v) => PAD + (v / top) * (inner - room);

    for (const b of bars) {
        for (const line of wrap(b.label, LABEL.size, inner)) {
            out.push(textLine(line, PAD, y + LABEL.size, { size: LABEL.size, fill: t.ink, fonts }));
            y += LABEL.line;
        }
        const barTop = y - LABEL.line + LABEL.size + BAR.above;
        // At least 2 px, so a value too small to see still has a mark.
        const end = Math.max(x(b.high), PAD + 2);
        if (b.high > b.low) {
            // A range: solid to its low end, then a lighter extension to its high end, a 2 px gap between.
            const lowEnd = x(b.low);
            out.push(barPath(PAD, lowEnd - 1, barTop, BAR.height, b.fill, { square: true }));
            out.push(barPath(lowEnd + 1, end, barTop, BAR.height, mix(b.fill, t.panel, 0.5)));
        } else {
            out.push(barPath(PAD, end, barTop, BAR.height, b.fill));
        }
        out.push(`<text x="${n(end + 7)}" y="${n(barTop + BAR.height / 2 + VALUE.size * 0.35)}" font-size="${VALUE.size}" font-weight="600" fill="${t.ink}">${e(b.text)}</text>`);
        y = barTop + BAR.height + BAR.below;
    }

    const height = Math.round(y - BAR.below + PAD + 2);
    return [
        `<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${height}" viewBox="0 0 ${W} ${height}" role="img" aria-labelledby="title desc" font-family="${fonts.sans}">`,
        `<title id="title">${e(chart.title)}</title>`,
        `<desc id="desc">${e(description(chart))}</desc>`,
        `<rect x="0.5" y="0.5" width="${W - 1}" height="${height - 1}" rx="10" fill="${t.panel}" stroke="${t.rule}"/>`,
        ...out,
        "</svg>",
        "",
    ].join("\n");
}

/** Every chart file (name → SVG) for the README's text. */
export function chartFiles(markdown = fs.readFileSync(readmeFile, "utf8"), tokens = siteTokens()) {
    const rows = readmeRows(markdown);
    let charts;
    try {
        charts = chartsFor(rows);
    } catch (error) {
        throw new Error(`README.md: ${error.message}`);
    }
    const files = new Map();
    for (const chart of charts) {
        for (const theme of ["light", "dark"]) files.set(`${chart.file}-${theme}.svg`, chartSvg(chart, theme, tokens));
    }
    return files;
}

/**
 * What is wrong with the committed charts, as messages (none: all is well):
 * a chart missing, different from what the README's numbers draw, or not a
 * chart any more; or the README not showing one (its light file as the
 * <img>, its dark one as the <source>).
 */
export function chartProblems(markdown = fs.readFileSync(readmeFile, "utf8")) {
    const files = chartFiles(markdown);
    const problems = [];
    const committed = fs.existsSync(chartsDir) ? fs.readdirSync(chartsDir).filter((f) => f.endsWith(".svg")) : [];
    for (const [file, svg] of files) {
        const on = path.join(chartsDir, file);
        if (!fs.existsSync(on)) problems.push(`docs/assets/charts/${file} is missing`);
        else if (fs.readFileSync(on, "utf8") !== svg) problems.push(`docs/assets/charts/${file} does not show the README's numbers`);
    }
    for (const file of committed) if (!files.has(file)) problems.push(`docs/assets/charts/${file} is not a chart the README's tables draw`);
    for (const file of files.keys()) {
        const [, chart, theme] = /^(.*)-(light|dark)\.svg$/.exec(file);
        const shown = theme === "light" ? `src="${chartUrl(file)}"` : `srcset="${chartUrl(file)}"`;
        if (!markdown.includes(shown)) problems.push(`README.md does not show ${chart}'s ${theme} chart (${shown})`);
    }
    const prefix = chartUrl("");
    for (const [url] of markdown.matchAll(new RegExp(`${prefix.replace(/[.\/]/g, "\\$&")}[^"\\s)]*`, "g"))) {
        if (!files.has(url.slice(prefix.length))) problems.push(`README.md shows ${url}, which its tables do not draw`);
    }
    return problems;
}

// ---------------------------------------------------------------------------

function main() {
    if (process.argv.includes("--check")) {
        const problems = chartProblems();
        if (problems.length > 0) {
            console.error(`The README's charts are not what its tables say:\n${problems.map((p) => `  ${p}`).join("\n")}\nRegenerate them: ${regenerate}`);
            process.exit(1);
        }
        console.log(`ok: the README's ${chartFiles().size} charts show its tables' numbers`);
    } else {
        const files = chartFiles();
        fs.mkdirSync(chartsDir, { recursive: true });
        for (const file of fs.readdirSync(chartsDir)) if (file.endsWith(".svg") && !files.has(file)) fs.rmSync(path.join(chartsDir, file));
        for (const [file, svg] of files) fs.writeFileSync(path.join(chartsDir, file), svg);
        console.log(`wrote ${files.size} charts to docs/assets/charts`);
    }
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
    try {
        main();
    } catch (error) {
        // A table the charts cannot read: what is wrong with it, and where they read it.
        console.error(`${error.message}\nThe charts are drawn from the README's tables by site/readme-charts.mjs; a table in a new shape needs a change there.`);
        process.exit(1);
    }
}
