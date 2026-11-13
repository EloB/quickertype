// The playground's benchmark numbers: site/data/benchmarks.json (written by
// `cargo xtask bench --json`) and site/data/big-inputs.json (multi-GB
// inputs, measured by hand, and a user's report). Checked here, summed up
// for the playground's headline, and rendered as the benchmarks page, at
// build time: the page needs no script. Used by site/build.mjs and
// site/test/smoke.mjs.
//
// The charts are inline SVG in HTML rows: the labels are HTML text (it
// wraps, and stays legible at any width), the bars SVG, placed in percent
// of their row. quickertype is the violet accent, quicktype the gray it is
// compared with (the emphasis form; checked with the dataviz palette
// validator against both themes' surfaces). Every chart has a table with
// its numbers, every bar an accessible label.

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { escapeHtml } from "./src/html.js";

const siteRoot = path.dirname(fileURLToPath(import.meta.url));
export const benchmarksFile = path.join(siteRoot, "data", "benchmarks.json");
export const bigInputsFile = path.join(siteRoot, "data", "big-inputs.json");

const repository = "https://github.com/EloB/quickertype";
export const links = {
    benchmarksDoc: `${repository}/blob/main/docs/BENCHMARKS.md`,
    readme: `${repository}#readme`,
    commit: (sha) => `${repository}/commit/${sha}`,
    quicktypeCommit: (sha) => `https://github.com/glideapps/quicktype/commit/${sha}`,
};

/** The benchmarks the page names on its own (the build fails if one is missing). */
export const named = {
    startup: "--version",
    pokedex: "pokedex (82 KB) → TypeScript",
    memory: [
        "--version",
        "pokedex (82 KB) → TypeScript",
        "vega-lite.schema (306 KB) → TypeScript",
        "generated (4 MB) → TypeScript",
        "generated (40 MB) → TypeScript",
    ],
};

/** "Typical files": the real-world JSON samples (82–606 KB), to TypeScript and to each of 8 languages. */
export const isTypical = (row) => (row.group === "json" || row.group === "languages") && !/generated|multi-source/.test(row.name);

const groupNames = {
    startup: "Start-up",
    json: "JSON",
    languages: "Eight languages",
    schema: "JSON Schema",
    graphql: "GraphQL",
    "multi-file": "Several output files",
};

// ---------------------------------------------------------------------------
// Checking

class Problem extends Error {}

function check(condition, file, where, what) {
    if (!condition) throw new Problem(`${path.relative(path.join(siteRoot, ".."), file)}: ${where} ${what}`);
}

const isObject = (v) => typeof v === "object" && v !== null && !Array.isArray(v);
const positive = (v) => typeof v === "number" && Number.isFinite(v) && v > 0;
const count = (v) => Number.isInteger(v) && v >= 0;
const sha = (v) => typeof v === "string" && /^[0-9a-f]{40}$/.test(v);
const text = (v) => typeof v === "string" && v.trim() !== "";
const isDate = (v) => typeof v === "string" && /^\d{4}-\d{2}-\d{2}$/.test(v) && !Number.isNaN(Date.parse(`${v}T00:00:00Z`));

/** site/data/benchmarks.json, checked: everything the page shows is there and makes sense. */
export function checkBenchmarks(data, file = benchmarksFile) {
    const ok = (condition, where, what) => check(condition, file, where, what);
    ok(isObject(data) && data.format === 1, "format", "must be 1");
    ok(isDate(data.date), "date", "must be YYYY-MM-DD");
    ok(text(data.command) && data.command.startsWith("cargo xtask bench"), "command", "must be the `cargo xtask bench` command");
    ok(isObject(data.machine), "machine", "must be an object");
    for (const key of ["cpu", "cores", "memory", "os"]) ok(text(data.machine[key]), `machine.${key}`, "must be a string");
    ok(isObject(data.commits), "commits", "must be an object");
    ok(sha(data.commits.quicktype), "commits.quicktype", "must be a commit (40 hex digits)");
    ok(sha(data.commits.quickertype), "commits.quickertype", "must be a commit (40 hex digits)");
    ok(typeof data.commits.quickertype_modified === "boolean", "commits.quickertype_modified", "must be true or false");
    ok(Number.isInteger(data.iterations) && data.iterations > 0, "iterations", "must be a positive integer");
    ok(data.note === undefined || text(data.note), "note", "must be a string if given");
    for (const id of ["typescript", "rust"]) ok(text(data.tools?.[id]?.label), `tools.${id}`, "must be there (run with the TypeScript CLI)");

    ok(Array.isArray(data.cli) && data.cli.length > 0, "cli", "must be a non-empty array");
    const names = new Set();
    data.cli.forEach((row, i) => {
        const where = `cli[${i}]`;
        ok(text(row.group) && text(row.name), where, "needs a group and a name");
        ok(!names.has(row.name), where, `repeats "${row.name}"`);
        names.add(row.name);
        ok(row.identical === true, `${where} (${row.name})`, "has CLIs that wrote different files: not publishable");
        for (const id of ["typescript", "rust"]) {
            const r = row.results?.[id];
            const at = `${where}.results.${id} (${row.name})`;
            ok(isObject(r), at, "is missing");
            ok(positive(r.median_ms) && positive(r.min_ms) && r.min_ms <= r.median_ms, at, "needs median_ms ≥ min_ms > 0");
            ok(r.peak_rss_mib === null || positive(r.peak_rss_mib), at, "peak_rss_mib must be positive or null");
        }
    });
    for (const name of new Set([named.startup, named.pokedex, ...named.memory])) {
        ok(names.has(name), "cli", `has no "${name}", which the page shows`);
    }
    for (const name of named.memory) {
        const row = data.cli.find((r) => r.name === name);
        ok(row.results.typescript.peak_rss_mib !== null && row.results.rust.peak_rss_mib !== null, `cli (${name})`, "needs peak_rss_mib for the memory chart");
    }
    ok(data.cli.filter(isTypical).length >= 3, "cli", "needs at least 3 typical-file benchmarks");

    ok(isObject(data.corpus) && count(data.corpus.jobs) && data.corpus.jobs > 0, "corpus", "is missing (run with --corpus)");
    for (const id of ["typescript", "rust"]) {
        const c = data.corpus.results?.[id];
        const at = `corpus.results.${id}`;
        ok(isObject(c) && count(c.steps) && c.steps > 0, at, "needs steps");
        ok(positive(c.wall_s) && positive(c.cli_time_s), at, "needs wall_s and cli_time_s");
        ok(count(c.unexpected_exits) && c.unexpected_exits <= c.steps, at, "needs unexpected_exits ≤ steps");
    }
    ok(data.corpus.results.typescript.steps === data.corpus.results.rust.steps, "corpus.results", "ran different numbers of steps");

    ok(isObject(data.in_process) && count(data.in_process.runs) && data.in_process.runs > 0, "in_process", "is missing (run with --in-process)");
    for (const id of ["typescript", "rust"]) {
        const p = data.in_process.results?.[id];
        ok(isObject(p) && text(p.label) && positive(p.total_ms), `in_process.results.${id}`, "needs a label and total_ms");
    }
    return data;
}

/** site/data/big-inputs.json, checked. */
export function checkBigInputs(data, file = bigInputsFile) {
    const ok = (condition, where, what) => check(condition, file, where, what);
    ok(isObject(data) && data.format === 1, "format", "must be 1");
    const m = data.measured;
    ok(isObject(m) && isDate(m.date) && text(m.machine) && sha(m.commit) && text(m.how), "measured", "needs date, machine, commit and how");
    ok(Array.isArray(m.inputs) && m.inputs.length > 0, "measured.inputs", "must be a non-empty array");
    m.inputs.forEach((input, i) => {
        const at = `measured.inputs[${i}]`;
        ok(text(input.name) && text(input.description) && text(input.size), at, "needs name, description and size");
        ok(positive(input.seconds) && positive(input.peak_rss_mib), at, "needs seconds and peak_rss_mib");
    });
    ok(Array.isArray(data.reports), "reports", "must be an array");
    data.reports.forEach((report, i) => {
        const at = `reports[${i}]`;
        for (const key of ["input", "size", "quicktype", "quickertype", "source"]) ok(text(report[key]), at, `needs ${key}`);
        ok(positive(report.quicktype_seconds_at_least) && positive(report.quickertype_seconds), at, "needs quicktype_seconds_at_least and quickertype_seconds");
    });
    return data;
}

/** Both files, read and checked. */
export function readBenchmarks() {
    const read = (file) => {
        try {
            return JSON.parse(fs.readFileSync(file, "utf8"));
        } catch (e) {
            throw new Problem(`${path.relative(path.join(siteRoot, ".."), file)}: ${e.message}`);
        }
    };
    return { bench: checkBenchmarks(read(benchmarksFile)), big: checkBigInputs(read(bigInputsFile)) };
}

// ---------------------------------------------------------------------------
// The numbers the pages say

const median = (xs) => {
    const s = [...xs].sort((a, b) => a - b);
    const mid = s.length >> 1;
    return s.length % 2 ? s[mid] : (s[mid - 1] + s[mid]) / 2;
};

const speedup = (row) => row.results.typescript.median_ms / row.results.rust.median_ms;

/** A ratio as the page writes it: "96×", "8.2×". */
export const times = (r) => `${r >= 10 ? Math.round(r) : r.toFixed(1)}×`;

/** A round figure to say "about" with: 41.1 → 40, 13.6 → 15, 8.2 → 8. */
export function roundFigure(x) {
    if (x >= 20) return Math.round(x / 10) * 10;
    if (x >= 10) return Math.round(x / 5) * 5;
    return Math.round(x);
}

/**
 * What the headline and the comparison note say: `upTo` (the largest CLI
 * speed-up, rounded), `typical` (about how much faster on typical files: a
 * round figure near the median speed-up over them), and what they come from.
 */
export function speedFacts(bench) {
    const rows = bench.cli.map((row) => ({ row, speedup: speedup(row) }));
    const top = rows.reduce((a, b) => (b.speedup > a.speedup ? b : a));
    const typicalRows = rows.filter(({ row }) => isTypical(row));
    const typicalMedian = median(typicalRows.map((r) => r.speedup));
    const corpus = bench.corpus.results;
    return {
        upTo: Math.round(top.speedup),
        upToName: top.row.name,
        typical: roundFigure(typicalMedian),
        typicalMedian,
        typicalCount: typicalRows.length,
        lowest: Math.min(...rows.map((r) => r.speedup)),
        corpus: corpus.typescript.wall_s / corpus.rust.wall_s,
    };
}

/** The playground's headline, as HTML (one sentence, the numbers from the JSON, and two links). */
export function headlineHtml(facts) {
    return (
        `quicktype rewritten in Rust: the same output, byte for byte. ` +
        `The CLI is up to <b>${facts.upTo}×</b> faster (about ${facts.typical}× on typical files) and uses a fraction of the memory. ` +
        `<a href="./benchmarks.html">Benchmarks</a><span class="sep" aria-hidden="true"> · </span><a href="${links.readme}">Install the CLI</a>`
    );
}

// ---------------------------------------------------------------------------
// Formatting

export function formatMs(x) {
    if (x >= 10_000) return `${(x / 1000).toFixed(1)} s`;
    if (x >= 1000) return `${(x / 1000).toFixed(2)} s`;
    if (x >= 100) return `${Math.round(x)} ms`;
    if (x >= 10) return `${x.toFixed(1)} ms`;
    return `${x.toFixed(2)} ms`;
}

export function formatMiB(x) {
    if (x >= 1024) return `${(x / 1024).toFixed(2)} GiB`;
    if (x >= 100) return `${Math.round(x)} MiB`;
    return `${x.toFixed(1)} MiB`;
}

/** 18000 → "5 hours". */
function hours(seconds) {
    const h = seconds / 3600;
    return `${Number.isInteger(h) ? h : h.toFixed(1)} hour${h === 1 ? "" : "s"}`;
}

/** 571.7 → "9 min 32 s". */
function minutes(seconds) {
    const m = Math.floor(seconds / 60);
    const s = Math.round(seconds - m * 60);
    return `${m} min ${s} s`;
}

function longDate(iso) {
    return new Date(`${iso}T00:00:00Z`).toLocaleDateString("en-US", { year: "numeric", month: "long", day: "numeric", timeZone: "UTC" });
}

const e = escapeHtml;
const pct = (x) => `${(Math.max(0, Math.min(1, x)) * 100).toFixed(2)}%`;

// ---------------------------------------------------------------------------
// Charts

/**
 * One bar, `fraction` of its row wide, rounded at its end and square at the
 * baseline: a nested <svg> clips the square cap to the bar, however narrow.
 * `parts` splits it ([fraction of the bar, class]).
 */
function bar({ fraction, y = 2, height = 12, kind, parts }) {
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
    // The rounded end: the whole bar with rx, its baseline end squared by a cap.
    return `<svg x="0" y="${y}" width="${pct(fraction)}" height="${height}" class="bar-mark ${kind}" overflow="hidden"><clipPath id="c${++clipIds}"><rect width="100%" height="${height}" rx="4"/><rect width="8" height="${height}"/></clipPath><g clip-path="url(#c${clipIds})">${segments}</g></svg>`;
}

let clipIds = 0;

/** A value at a bar's tip. */
const tip = (fraction, y, label) => `<text x="${pct(fraction)}" dx="6" y="${y}" class="tip">${e(label)}</text>`;

/** An <svg> drawing a row's bars: an image, with its accessible name. */
function rowSvg(label, height, content) {
    return `<svg class="bars-svg" width="100%" height="${height}" role="img" aria-label="${e(label)}"><title>${e(label)}</title>${content}</svg>`;
}

/** A table of a chart's numbers, closed by default. */
function tableView(caption, head, rows) {
    return `<details class="table-view"><summary>The numbers as a table</summary><table><caption>${e(caption)}</caption><thead><tr>${head
        .map((h, i) => `<th scope="col"${i > 0 ? ' class="num"' : ""}>${e(h)}</th>`)
        .join("")}</tr></thead><tbody>${rows
        .map((r) => `<tr>${r.map((c, i) => (i === 0 ? `<th scope="row">${e(c)}</th>` : `<td class="num">${e(c)}</td>`)).join("")}</tr>`)
        .join("")}</tbody></table></details>`;
}

/** The legend: quicktype (gray) and quickertype (violet). */
const legend = (theirs = "quicktype", ours = "quickertype") =>
    `<p class="legend"><span class="key theirs" aria-hidden="true"></span>${e(theirs)}<span class="key ours" aria-hidden="true"></span>${e(ours)}</p>`;

/**
 * The room a bar's tip label needs, as a fraction of the narrowest row (a
 * 328 px phone column): bars stop short of it, so the label never leaves
 * the row.
 */
const roomFor = (label) => Math.min(0.5, (label.length * 7.4 + 10) / 328);

/** CLI speed-ups, one bar per benchmark, grouped; quicktype's and quickertype's times beside each. */
function cliChart(bench) {
    const rows = bench.cli.map((row) => ({ row, s: speedup(row) }));
    const room = Math.max(...rows.map(({ s }) => roomFor(times(s))));
    const top = Math.max(...rows.map(({ s }) => s)) / (1 - room);
    let group;
    let html = "";
    for (const { row, s } of rows) {
        if (row.group !== group) {
            if (group !== undefined) html += "</ol>";
            group = row.group;
            html += `<h4 class="bars-group">${e(groupNames[group] ?? group)}</h4><ol class="bars">`;
        }

        const ts = row.results.typescript.median_ms;
        const rust = row.results.rust.median_ms;
        const label = `${row.name}: quickertype ${times(s)} faster, ${formatMs(rust)} against quicktype's ${formatMs(ts)}`;
        html += `<li class="bar-row"><span class="bar-name">${e(row.name)}</span><span class="bar-value">${formatMs(ts)} → <b>${formatMs(rust)}</b></span>${rowSvg(
            label,
            16,
            bar({ fraction: s / top, kind: "ours" }) + tip(s / top, 12.5, times(s)),
        )}</li>`;
    }

    html += "</ol>";
    const table = tableView(
        "CLI wall time per run, median of 10 runs after one warm-up",
        ["Benchmark", "quicktype", "quickertype", "Faster"],
        rows.map(({ row, s }) => [row.name, formatMs(row.results.typescript.median_ms), formatMs(row.results.rust.median_ms), times(s)]),
    );
    return { html, table };
}

/** Peak memory of a few runs: quicktype's bar over quickertype's. */
function memoryChart(bench) {
    const rows = named.memory.map((name) => bench.cli.find((r) => r.name === name));
    const values = rows.flatMap((r) => [r.results.typescript.peak_rss_mib, r.results.rust.peak_rss_mib]);
    const room = Math.max(...values.map((v) => roomFor(formatMiB(v))));
    const top = Math.max(...values) / (1 - room);
    const html = `<ol class="bars">${rows
        .map((row) => {
            const ts = row.results.typescript.peak_rss_mib;
            const rust = row.results.rust.peak_rss_mib;
            const label = `${row.name}: quicktype ${formatMiB(ts)}, quickertype ${formatMiB(rust)}, ${times(ts / rust)} less`;
            return `<li class="bar-row"><span class="bar-name">${e(row.name)}</span><span class="bar-value">${times(ts / rust)} less</span>${rowSvg(
                label,
                30,
                bar({ fraction: ts / top, y: 2, kind: "theirs" }) +
                    tip(ts / top, 12.5, formatMiB(ts)) +
                    bar({ fraction: rust / top, y: 16, kind: "ours" }) +
                    tip(rust / top, 26.5, formatMiB(rust)),
            )}</li>`;
        })
        .join("")}</ol>`;
    const table = tableView(
        "Peak resident memory of one CLI run",
        ["Benchmark", "quicktype", "quickertype", "Less"],
        rows.map((r) => [r.name, formatMiB(r.results.typescript.peak_rss_mib), formatMiB(r.results.rust.peak_rss_mib), times(r.results.typescript.peak_rss_mib / r.results.rust.peak_rss_mib)]),
    );
    return { html, table };
}

/** Two bars on one scale, each named (quicktype, quickertype), values at the tips or beside the names. */
function pairChart({ theirs, ours, tips = true, more = false }) {
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

/** The pokedex CLI run of each engine: start-up (what --version takes), then the rest. */
function startupChart(bench) {
    const find = (name) => bench.cli.find((r) => r.name === name).results;
    const startup = find(named.startup);
    const run = find(named.pokedex);
    const side = (id) => {
        const total = run[id].median_ms;
        const start = Math.min(startup[id].median_ms, total);
        return { total, start, rest: total - start };
    };
    const ts = side("typescript");
    const rust = side("rust");
    const top = ts.total / 0.92;
    const row = (name, kind, s, what) =>
        `<li class="bar-row noted"><span class="bar-name"><span class="key ${kind}" aria-hidden="true"></span>${e(name)}</span><span class="bar-value"><b>${formatMs(s.total)}</b></span>${rowSvg(
            `${name}: ${formatMs(s.total)} for pokedex.json, of which ${formatMs(s.start)} ${what}`,
            16,
            bar({ fraction: s.total / top, kind, parts: [[s.start / s.total, "startup"], [s.rest / s.total, ""]] }),
        )}<span class="bar-note">${formatMs(s.start)} ${e(what)} + ${formatMs(s.rest)}</span></li>`;
    return {
        ts,
        rust,
        html: `<p class="legend"><span class="key part startup" aria-hidden="true"></span>start-up (as long as <code>--version</code> takes)<span class="key part" aria-hidden="true"></span>the rest of the run</p><ol class="bars pair">${row(
            "quicktype",
            "theirs",
            ts,
            "start-up",
        )}${row("quickertype", "ours", rust, "start-up")}</ol>${tableView(
            "One CLI run on pokedex.json: start-up (as long as --version takes) and the rest",
            ["Engine", "Run", "Start-up", "The rest"],
            [
                ["quicktype", formatMs(ts.total), formatMs(ts.start), formatMs(ts.rest)],
                ["quickertype", formatMs(rust.total), formatMs(rust.start), formatMs(rust.rest)],
            ],
        )}`,
    };
}

// ---------------------------------------------------------------------------
// The page

/** The benchmarks page's content (inside <main>), from the checked data. */
export function benchmarksPageHtml({ bench, big }) {
    clipIds = 0;
    const facts = speedFacts(bench);
    const cli = (name) => bench.cli.find((r) => r.name === name);
    const pokedex = cli(named.pokedex);
    const version = cli(named.startup);
    const large = cli("generated (40 MB) → TypeScript");
    const corpus = bench.corpus.results;
    const inProcess = bench.in_process.results;
    const machine = bench.machine;
    const date = longDate(bench.date);
    const report = big.reports[0];
    const measuredLarge = big.measured.inputs.find((i) => i.name === "generated (40 MB)");

    const cliCharts = cliChart(bench);
    const memory = memoryChart(bench);
    const startup = startupChart(bench);
    const pokedexMemory = pokedex.results.typescript.peak_rss_mib / pokedex.results.rust.peak_rss_mib;

    const tiles = [
        [`${facts.upTo}×`, `faster per CLI run at most (<code>${e(facts.upToName)}</code>, start-up alone); about ${facts.typical}× on typical files`],
        [`${times(facts.corpus)}`, `faster on quicktype's whole test corpus, ${corpus.typescript.steps.toLocaleString("en-US")} CLI runs`],
        [`${times(pokedexMemory)}`, `less memory on pokedex.json: ${formatMiB(pokedex.results.rust.peak_rss_mib)} against ${formatMiB(pokedex.results.typescript.peak_rss_mib)}`],
        ...(report === undefined
            ? []
            : [[e(report.quickertype.replace(/^about /, "~")), `for a user's ${e(report.size)} JSON file, where quicktype ran for ${e(report.quicktype)}`]]),
    ];

    const typicalList = bench.cli.filter(isTypical);
    const sections = [];

    sections.push(`<section class="intro" aria-labelledby="title">
<h1 id="title">Benchmarks</h1>
<p class="lead">quicktype rewritten in Rust: the same output, byte for byte. The CLI is up to ${facts.upTo}× faster (about ${facts.typical}× on typical files) and uses a fraction of the memory.</p>
<dl class="tiles">${tiles.map(([value, what]) => `<div class="tile"><dt>${what}</dt><dd>${value}</dd></div>`).join("")}</dl>
<p class="measured-on">Measured on an ${e(machine.cpu)} on ${e(date)}, against quicktype at <a href="${links.quicktypeCommit(bench.commits.quicktype)}"><code>${bench.commits.quicktype.slice(0, 7)}</code></a>. <a href="#method">How</a> · <a href="#get-the-cli">Get the CLI</a></p>
</section>`);

    sections.push(`<section id="cli" aria-labelledby="cli-title">
<h2 id="cli-title">Every CLI run, ${facts.upTo}× to ${times(facts.lowest)} faster</h2>
<p>One run of the CLI per benchmark: how many times faster quickertype's is, and both times (quicktype → quickertype; medians of ${bench.iterations} runs). On small inputs most of quicktype's time is starting Node.js and loading quicktype (<code>--version</code> alone takes ${formatMs(version.results.typescript.median_ms)}); on large ones it is the work itself, which quickertype does several times faster. "Typical files" are the ${typicalList.length} real-world JSON samples here (82 to 606 KB, to TypeScript and to 8 languages): quickertype is ${times(facts.typicalMedian)} faster on the median one.</p>
<figure class="chart" aria-labelledby="cli-chart-title">
<figcaption id="cli-chart-title">quickertype's CLI, how many times faster than quicktype's</figcaption>
${cliCharts.html}
${cliCharts.table}
</figure>
</section>`);

    sections.push(`<section id="memory" aria-labelledby="memory-title">
<h2 id="memory-title">Memory</h2>
<p>The most memory one run took (peak resident set size). quicktype needs ${formatMiB(version.results.typescript.peak_rss_mib)} before it reads any input (<code>--version</code>), so on small files it takes ${Math.round(pokedexMemory)} times what quickertype does. On the 40 MB input it took ${formatMiB(large.results.typescript.peak_rss_mib)} against quickertype's ${formatMiB(large.results.rust.peak_rss_mib)} in this run${
        measuredLarge === undefined
            ? ""
            : `; a later change brought quickertype down to ${formatMiB(measuredLarge.peak_rss_mib)} there (${times(large.results.typescript.peak_rss_mib / measuredLarge.peak_rss_mib)} less, see <a href="#big-files">big files</a>)`
    }.</p>
<figure class="chart" aria-labelledby="memory-chart-title">
<figcaption id="memory-chart-title">Peak memory of one CLI run</figcaption>
${legend()}
${memory.html}
${memory.table}
</figure>
</section>`);

    const exits = corpus.rust.unexpected_exits;
    sections.push(`<section id="corpus" aria-labelledby="corpus-title">
<h2 id="corpus-title">The whole test corpus, ${times(facts.corpus)} faster</h2>
<p>Every step of every case in quicktype's test corpus as this repository records it (<code>tests/golden</code>): ${corpus.typescript.steps.toLocaleString("en-US")} CLI runs in every output language, from JSON, JSON Schema, GraphQL and TypeScript, ${bench.corpus.jobs} at a time.</p>
<figure class="chart" aria-labelledby="corpus-chart-title">
<figcaption id="corpus-chart-title">Wall time for all ${corpus.typescript.steps.toLocaleString("en-US")} runs</figcaption>
${pairChart({
    theirs: { name: "quicktype", value: corpus.typescript.wall_s, tip: `${corpus.typescript.wall_s} s`, label: `quicktype: ${corpus.typescript.wall_s} s (${minutes(corpus.typescript.wall_s)})` },
    ours: { name: "quickertype", value: corpus.rust.wall_s, tip: `${corpus.rust.wall_s} s`, label: `quickertype: ${corpus.rust.wall_s} s` },
})}
${tableView("The golden corpus, every step once", ["Engine", "Wall time", "CLI time, summed", "Unexpected exits"], [
    ["quicktype", `${corpus.typescript.wall_s} s (${minutes(corpus.typescript.wall_s)})`, `${corpus.typescript.cli_time_s} s`, String(corpus.typescript.unexpected_exits)],
    ["quickertype", `${corpus.rust.wall_s} s`, `${corpus.rust.cli_time_s} s`, String(exits)],
])}
</figure>
${exits > 0 ? `<p class="fineprint">${exits.toLocaleString("en-US")} of quickertype's runs exited early: the cases outside its parity baseline when this was measured (C with cJSON, which was being ported).</p>` : ""}
</section>`);

    const reportChart =
        report === undefined
            ? ""
            : `<figure class="chart" aria-labelledby="report-title">
<figcaption id="report-title">${e(report.input.replace(/^a /, "A "))}, as a user reported it</figcaption>
${pairChart({
    theirs: { name: "quicktype", value: report.quicktype_seconds_at_least, text: report.quicktype, label: `quicktype: ${report.quicktype}` },
    ours: { name: "quickertype", value: report.quickertype_seconds, text: report.quickertype, label: `quickertype: ${report.quickertype}` },
    tips: false,
    more: true,
})}
<p class="fineprint">${e(report.source)} quicktype's bar is drawn at ${hours(report.quicktype_seconds_at_least)}; it ran longer.</p>
</figure>`;
    sections.push(`<section id="big-files" aria-labelledby="big-title">
<h2 id="big-title">Big files</h2>
<p>quickertype reads JSON as a stream and keeps its tables compact, so files of several gigabytes run in seconds.</p>
${reportChart}
<figure class="chart" aria-labelledby="big-table-title">
<figcaption id="big-table-title">quickertype on large inputs, measured here</figcaption>
<table class="plain"><thead><tr><th scope="col">Input</th><th scope="col" class="num">Time</th><th scope="col" class="num">Peak memory</th></tr></thead><tbody>${big.measured.inputs
        .map((i) => `<tr><th scope="row">${e(i.size)}: ${e(i.description)}</th><td class="num">${i.seconds >= 1 ? `${i.seconds} s` : formatMs(i.seconds * 1000)}</td><td class="num">${formatMiB(i.peak_rss_mib)}</td></tr>`)
        .join("")}</tbody></table>
<p class="fineprint">${e(big.measured.machine)}, ${e(longDate(big.measured.date))}, commit <a href="${links.commit(big.measured.commit)}"><code>${big.measured.commit.slice(0, 7)}</code></a>: ${e(big.measured.how)} quicktype was not timed on the 2.6 GB inputs.</p>
</figure>
</section>`);

    const engineSpeedup = inProcess.typescript.total_ms / inProcess.rust.total_ms;
    sections.push(`<section id="browser" aria-labelledby="browser-title">
<h2 id="browser-title">In the browser</h2>
<p>The playground runs both engines inside the page, so the gap there is smaller. Neither starts a process, and starting Node.js and loading quicktype is most of what a quicktype CLI run on a small file costs (below). What is left is the engine itself, and quickertype's WebAssembly build is still being optimized: natively its engine is ${times(engineSpeedup)} faster than quicktype's in a warm Node.js process (${formatMs(inProcess.rust.total_ms)} against ${formatMs(inProcess.typescript.total_ms)} for ${bench.in_process.runs} runs), and the WebAssembly build does not get all of that yet.</p>
<figure class="chart" aria-labelledby="startup-title">
<figcaption id="startup-title">One CLI run on pokedex.json (82 KB) → TypeScript</figcaption>
${startup.html}
</figure>
<p><a href="./#v=2&amp;l=typescript&amp;s=pokedex">Compare both engines in your browser</a>: switch engines in the playground, then <i>Measure warm runs</i>.</p>
</section>`);

    const facts2 = [
        ["Machine", [machine.cpu, machine.cores && `${machine.cores} cores`, machine.memory, machine.os].filter(Boolean).join(", ")],
        ["Toolchain", [machine.rustc, machine.node && `Node.js ${machine.node}`].filter(Boolean).join(", ")],
        ["Date", date],
        ["quicktype", `<a href="${links.quicktypeCommit(bench.commits.quicktype)}"><code>${bench.commits.quicktype.slice(0, 7)}</code></a>, the commit whose output quickertype matches (<code>tests/golden/REFERENCE</code>)`],
        ["quickertype", `<a href="${links.commit(bench.commits.quickertype)}"><code>${bench.commits.quickertype.slice(0, 7)}</code></a>${bench.commits.quickertype_modified ? " (with local changes)" : ""}`],
        ["Command", `<code>${e(bench.command)}</code>`],
        ["Runs", `${bench.iterations} timed runs of each CLI per benchmark after one warm-up run (which also checks that both write the same files); medians of wall time. Peak memory is one more run under <code>/usr/bin/time</code>.`],
        ...(machine.load_average ? [["Load", `load average ${e(machine.load_average)} when the run started`]] : []),
    ];
    sections.push(`<section id="method" aria-labelledby="method-title">
<h2 id="method-title">Method</h2>
<dl class="facts">${facts2.map(([k, v]) => `<div><dt>${e(k)}</dt><dd>${k === "Machine" || k === "Toolchain" || k === "Date" ? e(v) : v}</dd></div>`).join("")}</dl>
${bench.note ? `<p class="fineprint">${e(bench.note)}</p>` : ""}
<p>The details, the profile behind each optimization and how to reproduce every number: <a href="${links.benchmarksDoc}">docs/BENCHMARKS.md</a>. The numbers on this page: <a href="./data/benchmarks.json">benchmarks.json</a> and <a href="./data/big-inputs.json">big-inputs.json</a>.</p>
</section>`);

    sections.push(`<section id="get-the-cli" aria-labelledby="get-title">
<h2 id="get-title">Get the CLI</h2>
<p>There are no releases yet. Build it from a clone of the repository with <code>cargo build --release -p quicktype-cli</code>; the binary is <code>target/release/quicktype</code>, with quicktype's flags and quicktype's output. See the <a href="${links.readme}">README</a>.</p>
</section>`);

    return sections.join("\n");
}
