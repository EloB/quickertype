// The landing page, the site's root (index.html): what quickertype is, the
// thanks to quicktype, how the port is checked, how fast it is and how to get
// it. Rendered at build time (site/build.mjs) from the repository's own data,
// so that no number on it is typed by hand and none can drift:
//
// * quicktype's history, contributors and repository: site/data/quicktype.json
//   (written by site/quicktype-snapshot.mjs from a quicktype checkout and
//   GitHub's API; refused unless it is of the commit in tests/golden/REFERENCE);
// * the output languages: quicktype-core's API (the build's languages());
// * the test corpus: tests/golden (every case.json), tests/parity-baseline.txt
//   and tests/inputs; the JS API differential suite's scenarios
//   (npm/quicktype-core/test/differential/scenarios.mjs, counted, not run);
//   tests/fuzz-regressions, fuzz/fuzz_targets and the streaming fuzzer's
//   default (xtask/src/streaming.rs); the Rust tests (#[test] in crates/);
// * what runs where and when: .github/workflows (ci, fuzz, roundtrip, pages);
// * speed and memory: site/data/benchmarks.json, big-inputs.json and
//   browser.json (the WebAssembly engine in Chrome), read and checked as the
//   benchmarks page reads them (site/benchmarks.mjs); the sizes the page
//   gives are those in the benchmarks' names;
// * the example at the top: an excerpt of quicktype's pokedex.json sample,
//   generated when the page is built by both of quickertype-core's engines
//   (quicktype's TypeScript one and the WebAssembly one), which must agree
//   byte for byte.
//
// Every figure the page shows is also in a `data-stat` element with its raw
// value (`data-value`), which site/test/smoke.mjs checks against the same
// sources, counted again there.

import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { formatMiB, formatMs, named, seconds, sizeIn, speedFacts, times } from "./benchmarks.mjs";
import { columnChart, legend, pairChart, pairRows, startIds, tableView, valueRows } from "./charts.mjs";
import { quicktypeReference } from "./reference.mjs";
import { highlight } from "./src/highlight.js";
import { escapeHtml as e } from "./src/html.js";

const siteRoot = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(siteRoot, "..");
export const quicktypeFile = path.join(siteRoot, "data", "quicktype.json");

const repository = "https://github.com/EloB/quickertype";
/** Where the page links, besides itself. */
export const landingLinks = {
    repository,
    install: `${repository}#install`,
    parity: `${repository}/blob/main/docs/PARITY.md`,
    fuzz: `${repository}/blob/main/xtask/fuzz/README.md`,
    benchmarksDoc: `${repository}/blob/main/docs/BENCHMARKS.md`,
    notice: `${repository}/blob/main/NOTICE`,
    npmCore: "https://www.npmjs.com/package/quickertype-core",
    crate: "https://crates.io/crates/quickertype-core",
};

const isDate = (v) => typeof v === "string" && /^\d{4}-\d{2}-\d{2}$/.test(v) && !Number.isNaN(Date.parse(`${v}T00:00:00Z`));
const count = (v) => Number.isInteger(v) && v > 0;
const short = (file) => path.relative(repositoryRoot, file);

/** A whole number as the page writes it: 11177 → "11,177". */
export const number = (n) => n.toLocaleString("en-US");

/** A count of stars as the page writes it: 13913 → "13.9k". */
export const thousands = (n) => (n >= 1000 ? `${(n / 1000).toFixed(1).replace(/\.0$/, "")}k` : String(n));

/** "2017-07-13" → "July 2017". */
export const monthYear = (iso) => new Date(`${iso}T00:00:00Z`).toLocaleDateString("en-US", { year: "numeric", month: "long", timeZone: "UTC" });

/** "2026-09-08" → "September 8, 2026". */
export const longDate = (iso) => new Date(`${iso}T00:00:00Z`).toLocaleDateString("en-US", { year: "numeric", month: "long", day: "numeric", timeZone: "UTC" });

/** Whole years from one date to another (ISO dates). */
export function wholeYears(from, to) {
    const [a, b] = [new Date(`${from}T00:00:00Z`), new Date(`${to}T00:00:00Z`)];
    let years = b.getUTCFullYear() - a.getUTCFullYear();
    if (b.getUTCMonth() < a.getUTCMonth() || (b.getUTCMonth() === a.getUTCMonth() && b.getUTCDate() < a.getUTCDate())) years--;
    return years;
}

// ---------------------------------------------------------------------------
// The facts

/** site/data/quicktype.json, checked: of the commit in tests/golden/REFERENCE, and complete. */
export function readQuicktype(file = quicktypeFile) {
    const data = JSON.parse(fs.readFileSync(file, "utf8"));
    const ok = (condition, where, what) => {
        if (!condition) throw new Error(`${short(file)}: ${where} ${what}`);
    };
    ok(data.format === 1, "format", "must be 1");
    ok(isDate(data.retrieved), "retrieved", "must be YYYY-MM-DD");
    const { commit } = quicktypeReference();
    ok(
        data.history?.commit === commit,
        "history.commit",
        `is not ${commit}, the commit in tests/golden/REFERENCE: run node site/quicktype-snapshot.mjs with a checkout of it`,
    );
    const h = data.history;
    ok(isDate(h.first_commit_date) && isDate(h.commit_date) && h.first_commit_date < h.commit_date, "history", "needs first_commit_date and commit_date");
    ok(count(h.commits) && count(h.author_names), "history", "needs commits and author_names");
    const years = Object.entries(h.commits_by_year ?? {});
    ok(years.length > 0 && years.every(([y, n]) => /^\d{4}$/.test(y) && count(n)), "history.commits_by_year", "must be { year: commits }");
    ok(years.reduce((sum, [, n]) => sum + n, 0) === h.commits, "history.commits_by_year", `does not add up to ${h.commits}`);
    const r = data.repository;
    ok(r?.url === "https://github.com/glideapps/quicktype", "repository.url", "must be quicktype's");
    ok(count(r.stars) && count(r.forks) && typeof r.license === "string" && typeof r.default_branch === "string", "repository", "needs stars, forks, license and default_branch");
    ok(typeof r.homepage === "string" && r.homepage.startsWith("https://"), "repository.homepage", "must be a URL");
    ok(typeof r.owner?.name === "string" && typeof r.owner?.url === "string", "repository.owner", "needs a name and a URL");
    const people = data.contributors?.people;
    ok(Array.isArray(people) && people.length > 0, "contributors.people", "must be a non-empty array");
    people.forEach((p, i) => {
        ok(typeof p.login === "string" && /^[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?$/.test(p.login), `contributors.people[${i}]`, "needs a GitHub login");
        ok(count(p.id) && count(p.contributions), `contributors.people[${i}] (${p.login})`, "needs id and contributions");
        ok(i === 0 || people[i - 1].contributions >= p.contributions, `contributors.people[${i}] (${p.login})`, "is out of order (most commits first)");
    });
    ok(Array.isArray(data.contributors.bots_left_out), "contributors.bots_left_out", "must be an array");
    return data;
}

/** Every file under `dir`, relative to it, with `/` separators. */
function filesUnder(dir) {
    const out = [];
    const walk = (at) => {
        for (const entry of fs.readdirSync(at, { withFileTypes: true })) {
            const full = path.join(at, entry.name);
            if (entry.isDirectory()) walk(full);
            else if (entry.isFile()) out.push(path.relative(dir, full).split(path.sep).join("/"));
        }
    };
    walk(dir);
    return out.sort();
}

/**
 * tests/golden: its cases (each a recorded run of quicktype's CLI, one or
 * more steps), by what they cover, and how many of them
 * tests/parity-baseline.txt holds as passing.
 */
export function goldenFacts() {
    const golden = path.join(repositoryRoot, "tests", "golden");
    const kinds = { json: 0, schema: 0, graphql: 0, cli: 0 };
    const ids = [];
    let steps = 0;
    for (const file of filesUnder(golden).filter((f) => f.endsWith("/case.json"))) {
        const c = JSON.parse(fs.readFileSync(path.join(golden, file), "utf8"));
        const kind = c.fixture.startsWith("cli-") ? "cli" : c.input.split("/")[0];
        if (!(kind in kinds)) throw new Error(`tests/golden/${file}: a fixture's input of an unknown kind (${c.input})`);
        kinds[kind]++;
        steps += c.steps.length;
        ids.push(file.slice(0, -"/case.json".length));
    }
    const baseline = new Set(
        fs
            .readFileSync(path.join(repositoryRoot, "tests", "parity-baseline.txt"), "utf8")
            .split("\n")
            .map((l) => l.trim())
            .filter((l) => l !== "" && !l.startsWith("#")),
    );
    return { cases: ids.length, steps, kinds, passing: ids.filter((id) => baseline.has(id)).length };
}

/** tests/inputs: quicktype's test inputs, copied unmodified (NOTICE). */
export function inputFacts() {
    return { files: filesUnder(path.join(repositoryRoot, "tests", "inputs")).length };
}

/** The JS API differential suite's scenarios, counted (not run). Needs npm/quicktype-core installed. */
export async function differentialFacts() {
    const file = path.join(repositoryRoot, "npm", "quicktype-core", "test", "differential", "scenarios.mjs");
    const { allScenarios } = await import(pathToFileURL(file).href);
    return { scenarios: allScenarios().length };
}

/** "weekly", from a workflow's one cron schedule (a day of the week, every week). */
function cadence(workflow, file) {
    const crons = [...workflow.matchAll(/cron:\s*"([^"]+)"/g)].map((m) => m[1].split(/\s+/));
    if (crons.length !== 1 || crons[0].length !== 5) throw new Error(`.github/workflows/${file}: not one cron schedule`);
    const [, , day, month, weekday] = crons[0];
    if (day === "*" && month === "*" && /^[0-6]$/.test(weekday)) return "weekly";
    throw new Error(`.github/workflows/${file}: a schedule the page has no word for (${crons[0].join(" ")})`);
}

/** What .github/workflows runs, where and how often, as far as the page says it. */
export function workflowFacts() {
    const dir = path.join(repositoryRoot, ".github", "workflows");
    const read = (file) => fs.readFileSync(path.join(dir, file), "utf8");
    const need = (text, what, file) => {
        if (!text.includes(what)) throw new Error(`.github/workflows/${file} no longer runs \`${what}\`, which the landing page says it does`);
    };

    const ci = read("ci.yml");
    for (const what of ["cargo xtask parity", "cargo test --workspace", "npm run test:differential", "npm run test:browser"]) need(ci, what, "ci.yml");
    const runners = [...ci.matchAll(/runs-on:\s*([\w.-]+)/g)].map((m) => m[1]);
    for (const m of ci.matchAll(/\bos:\s*\[([^\]]*)\]/g)) runners.push(...m[1].split(",").map((s) => s.trim()));
    const systems = { ubuntu: "Linux", macos: "macOS", windows: "Windows" };
    const os = Object.entries(systems)
        .filter(([prefix]) => runners.some((r) => r.startsWith(`${prefix}-`)))
        .map(([, name]) => name);

    const fuzz = read("fuzz.yml");
    const targets = [...fuzz.matchAll(/-\s*\{\s*target:\s*(\w+)/g)].map((m) => m[1]).sort();
    const files = fs
        .readdirSync(path.join(repositoryRoot, "fuzz", "fuzz_targets"))
        .filter((f) => f.endsWith(".rs"))
        .map((f) => f.slice(0, -3))
        .sort();
    if (targets.join() !== files.join()) throw new Error(`.github/workflows/fuzz.yml runs ${targets.join(", ")}; fuzz/fuzz_targets has ${files.join(", ")}`);

    const roundtrip = read("roundtrip.yml");
    const matrix = roundtrip.slice(roundtrip.indexOf("\n  fixtures:"), roundtrip.indexOf("name: ${{ matrix.fixture }}"));
    const fixtures = new Set(
        [...matrix.matchAll(/^\s+-\s+(?:fixture:\s+)?([a-z][\w-]*(?:,[a-z][\w-]*)*)\s*$/gim)].flatMap((m) => m[1].split(",")),
    );
    if (fixtures.size < 10) throw new Error(".github/workflows/roundtrip.yml: its fixtures could not be read");

    need(read("pages.yml"), "node site/test/smoke.mjs", "pages.yml");
    return {
        ci: { os, jobs: [...ci.slice(ci.indexOf("\njobs:")).matchAll(/^ {2}([\w-]+):\s*$/gm)].length },
        fuzz: { targets: targets.length, cadence: cadence(fuzz, "fuzz.yml") },
        roundtrip: { fixtures: fixtures.size, cadence: cadence(roundtrip, "roundtrip.yml") },
    };
}

/** The differential fuzzer's kept regressions, and the streaming fuzzer's seeds per run (its default). */
export function fuzzFacts() {
    const regressions = fs.readdirSync(path.join(repositoryRoot, "tests", "fuzz-regressions"), { withFileTypes: true }).filter((d) => d.isDirectory()).length;
    const streaming = fs.readFileSync(path.join(repositoryRoot, "xtask", "src", "streaming.rs"), "utf8");
    const seeds = /--seeds <n>\s+how many seeds \(default (\d+)/.exec(streaming)?.[1];
    if (seeds === undefined) throw new Error("xtask/src/streaming.rs: no `--seeds <n> ... (default N)` in its usage");
    return { regressions, streamingSeeds: Number(seeds) };
}

/** The Rust test functions (`#[test]`) in crates/. */
export function rustTestFacts() {
    const crates = path.join(repositoryRoot, "crates");
    let tests = 0;
    for (const file of filesUnder(crates)) {
        if (!file.endsWith(".rs") || file.includes("/target/")) continue;
        tests += (fs.readFileSync(path.join(crates, file), "utf8").match(/#\[test\]/g) ?? []).length;
    }
    return { tests };
}

/**
 * The WebAssembly engine against quicktype's TypeScript engine, warm in
 * headless Chrome: site/data/browser.json (checked by readBenchmarks), the
 * totals of reading and generating, ms, and Chrome's major version.
 */
export function browserFacts(browser) {
    return {
        rows: browser.warm.map((r) => ({ input: r.input, ours: r.quickertype.total_ms, theirs: r.quicktype.total_ms })),
        chrome: /^Chrome (\d+)/.exec(browser.browser)[1],
    };
}

// ---------------------------------------------------------------------------
// The example: quicktype's sample, generated by both engines

/**
 * The languages the example shows: CLI name and options (as on the command
 * line; the build refuses one the language does not have). Types only where
 * the language has `just-types`; Rust has the playground's preset.
 */
export const specimenLanguages = [
    { lang: "typescript", options: { "just-types": "true" } },
    { lang: "python", options: { "just-types": "true" } },
    { lang: "go", options: { "just-types": "true" } },
    { lang: "kotlin", options: { "just-types": "true" } },
    { lang: "swift", options: { "just-types": "true" } },
    { lang: "rust", options: { density: "dense" } },
];

/** The example's input: the first Pokémon of quicktype's pokedex.json sample, some of its properties. */
export function specimenInput() {
    const pokedex = JSON.parse(fs.readFileSync(path.join(repositoryRoot, "tests", "inputs", "json", "samples", "pokedex.json"), "utf8"));
    const first = pokedex.pokemon[0];
    const keys = ["id", "num", "name", "type", "height", "weight", "next_evolution"];
    return compactJson(Object.fromEntries(keys.map((k) => [k, first[k]])));
}

/**
 * An object as JSON, one property a line and short: an array of scalars on
 * its line, an array of objects one object a line.
 */
function compactJson(object) {
    const inline = (v) =>
        Array.isArray(v)
            ? `[${v.map(inline).join(", ")}]`
            : typeof v === "object" && v !== null
              ? `{ ${Object.entries(v).map(([k, x]) => `${JSON.stringify(k)}: ${inline(x)}`).join(", ")} }`
              : JSON.stringify(v);
    const value = (v) =>
        Array.isArray(v) && v.some((x) => typeof x === "object" && x !== null) ? `[\n${v.map((x) => `    ${inline(x)}`).join(",\n")}\n  ]` : inline(v);
    return `{\n${Object.entries(object).map(([k, v]) => `  ${JSON.stringify(k)}: ${value(v)}`).join(",\n")}\n}\n`;
}

/** The file name the example's input has, on the command line too. */
export const specimenFile = "pokemon.json";

/** The command line the example's output for `language` comes from. */
export function specimenCommand({ lang, options }) {
    const flags = Object.entries(options).map(([name, value]) => (value === "true" ? `--${name}` : `--${name} ${value}`));
    return ["quickertype", specimenFile, "--lang", lang, ...flags].join(" ");
}

/**
 * The example, generated by both of quickertype-core's engines (`qt`, the
 * package's CommonJS build; `engineStats`, its count of the runs each engine
 * did): quicktype's TypeScript engine, then the WebAssembly one. Fails unless
 * each run was the engine's, and the two agree byte for byte.
 */
export async function specimen(qt, engineStats) {
    const json = specimenInput();
    const key = Symbol.for("quicktype-core.engine");
    const saved = globalThis[key];
    const run = async (engine, { lang, options }) => {
        globalThis[key] = engine;
        const before = engineStats[engine];
        const input = qt.jsonInputForTargetLanguage(lang);
        // The top level's name as the CLI takes it from the file name ("pokemon"):
        // Rust's comment shows it as it is.
        await input.addSource({ name: path.basename(specimenFile, ".json"), samples: [json] });
        const inputData = new qt.InputData();
        inputData.addInput(input);
        const result = await qt.quicktype({ inputData, lang, rendererOptions: options });
        if (engineStats[engine] !== before + 1) throw new Error(`the example (${lang}): the ${engine} engine did not run it`);
        return result.lines.join("\n");
    };
    try {
        const outputs = [];
        for (const language of specimenLanguages) {
            const target = qt.defaultTargetLanguages.find((l) => l.names.includes(language.lang));
            if (target === undefined) throw new Error(`the example: no language is named ${language.lang}`);
            for (const option of Object.keys(language.options)) {
                if (!target.optionDefinitions.some((d) => d.name === option)) throw new Error(`the example: ${target.displayName} has no --${option}`);
            }
            const theirs = await run("ts", language);
            const ours = await run("wasm", language);
            if (theirs !== ours) throw new Error(`the example (${language.lang}): quicktype's engine and quickertype's disagree`);
            outputs.push({
                ...language,
                name: target.displayName,
                command: specimenCommand(language),
                text: ours,
                bytes: Buffer.byteLength(ours),
                sha256: createHash("sha256").update(ours).digest("hex"),
            });
        }

        return { json, outputs };
    } finally {
        if (saved === undefined) delete globalThis[key];
        else globalThis[key] = saved;
    }
}

/** Everything the page says, from the sources above (`qt`, `engineStats`: see specimen; `languages`: the build's list; `bench`: readBenchmarks()). */
export async function landingFacts({ qt, engineStats, languages, bench }) {
    const quicktype = readQuicktype();
    const reference = quicktypeReference();
    return {
        quicktype,
        reference,
        languages: languages.length,
        golden: goldenFacts(),
        inputs: inputFacts(),
        differential: await differentialFacts(),
        workflows: workflowFacts(),
        fuzz: fuzzFacts(),
        rust: rustTestFacts(),
        browser: browserFacts(bench.browser),
        bench: bench.bench,
        big: bench.big,
        speed: speedFacts(bench.bench),
        specimen: await specimen(qt, engineStats),
    };
}

// ---------------------------------------------------------------------------
// The page

/** A figure the smoke test checks: its text (kept on one line), and its raw value. */
const stat = (name, value, text = number(value)) => `<span data-stat="${name}" data-value="${e(value)}">${e(String(text).replaceAll(" ", "\u00a0"))}</span>`;

const avatar = (person, size) =>
    `https://avatars.githubusercontent.com/u/${person.id}?v=4&s=${size * 2}`;

/** The contributors, most commits first, as linked avatars in three sizes by their number of commits. */
function contributorWall(people) {
    const tier = (n) => (n >= 500 ? "top" : n >= 10 ? "mid" : "rest");
    const sizes = { top: 88, mid: 56, rest: 40 };
    return `<ul class="wall" aria-label="quicktype's contributors on GitHub, most commits first">${people
        .map((p) => {
            const size = sizes[tier(p.contributions)];
            const commits = `${number(p.contributions)} commit${p.contributions === 1 ? "" : "s"}`;
            return `<li class="${tier(p.contributions)}"><a href="https://github.com/${e(p.login)}" title="${e(p.login)}: ${commits}"><img src="${avatar(p, size)}" alt="${e(p.login)}" width="${size}" height="${size}" loading="lazy" decoding="async" referrerpolicy="no-referrer"></a></li>`;
        })
        .join("")}</ul>`;
}

/** The image of a section: srcset of its two widths (files: the build's hashed names, by image). */
function picture(images, name, alt, { sizes, eager = false, className = "art" }) {
    const image = images[name];
    return `<img class="${className}" src="./${image.full}" srcset="./${image.small} 800w, ./${image.full} ${image.width}w" sizes="${sizes}" width="${image.width}" height="${image.height}" alt="${e(alt)}"${
        eager ? ' fetchpriority="high"' : ' loading="lazy"'
    } decoding="async">`;
}

/** The example: the input, the output per language (tabs that are radio buttons: no script), and that both engines wrote it. */
function specimenHtml(specimen) {
    const tabs = specimen.outputs
        .map((o, i) => `<label><input type="radio" name="specimen" value="${o.lang}"${i === 0 ? " checked" : ""}><span>${e(o.name)}</span></label>`)
        .join("");
    const panels = specimen.outputs
        .map(
            (o) => `<div class="panel" data-lang="${o.lang}">
<pre class="code" tabindex="0" aria-label="${e(o.name)}, generated from ${specimenFile}"><code>${highlight(o.text, o.lang)}</code></pre>
<p class="command"><code>${o.command.split(" ").map((arg) => `<span>${e(arg)}</span>`).join(" ")}</code></p>
<p class="proof"><svg class="tick" viewBox="0 0 16 16" aria-hidden="true"><path d="M3.5 8.5l3 3 6-7"/></svg><span>quicktype's and quickertype's engines wrote the same <span data-stat="specimen-bytes-${o.lang}" data-value="${o.bytes}">${number(o.bytes)}</span> bytes. sha256 <code data-stat="specimen-sha-${o.lang}" data-value="${o.sha256}">${o.sha256.slice(0, 12)}…</code></span></p>
</div>`,
        )
        .join("\n");
    return `<figure class="specimen" aria-labelledby="specimen-title">
<figcaption id="specimen-title"><b>${specimenFile}</b>, from quicktype's own test sample <code>pokedex.json</code>, and what it becomes. Generated by both engines when this page was built.</figcaption>
<pre class="code input" tabindex="0" aria-label="${specimenFile}"><code>${highlight(specimen.json.trimEnd(), "json")}</code></pre>
<div class="outputs">
<div class="tabs" role="radiogroup" aria-label="Output language">${tabs}</div>
${panels}
</div>
</figure>`;
}

/** The race at the top: one CLI run on pokedex.json, both bars on one scale. */
function raceHtml(bench) {
    const row = bench.cli.find((r) => r.name === named.pokedex).results;
    const lane = (kind, name, ms) =>
        `<div class="lane ${kind}"><span class="lane-name">${name}</span><span class="lane-track" aria-hidden="true"><span class="lane-bar"></span></span><span class="lane-time">${formatMs(ms)}</span></div>`;
    return `<figure class="race" aria-labelledby="race-title">
<figcaption id="race-title">One run of the CLI, <code>pokedex.json</code> (${e(sizeIn(named.pokedex))}) to TypeScript: <b>${stat("race-speedup", Number((row.typescript.median_ms / row.rust.median_ms).toFixed(1)), times(row.typescript.median_ms / row.rust.median_ms))} faster</b></figcaption>
${lane("theirs", "quicktype", row.typescript.median_ms)}
${lane("ours", "quickertype", row.rust.median_ms)}
</figure>`;
}

/** The parts of the race that come from the data: the bars' widths and how long they take to fill (both at one rate). */
export function raceCss(bench) {
    const row = bench.cli.find((r) => r.name === named.pokedex).results;
    const theirs = row.typescript.median_ms;
    const ours = row.rust.median_ms;
    // 4 ms of animation per ms of run: quicktype's bar fills in about a second.
    const duration = (ms) => `${Math.max(16, Math.round(ms * 4))}ms`;
    return `.race .theirs .lane-bar{width:100%;animation-duration:${duration(theirs)}}.race .ours .lane-bar{width:${((ours / theirs) * 100).toFixed(2)}%;animation-duration:${duration(ours)}}`;
}

/** The rules that show the panel of the language picked in the example. */
export function specimenCss(specimen) {
    return specimen.outputs.map((o) => `.specimen:has(input[value="${o.lang}"]:checked) .panel[data-lang="${o.lang}"]{display:block}`).join("");
}

/** The landing page's body (header, main and footer), from landingFacts(). `images`: the build's hashed image files. */
export function landingPageHtml(facts, images) {
    startIds("l");
    const { quicktype, golden, inputs, differential, workflows, fuzz, rust, browser, bench, big, speed, reference } = facts;
    const history = quicktype.history;
    const people = quicktype.contributors.people;
    const repo = quicktype.repository;
    const years = wholeYears(history.first_commit_date, history.commit_date);
    const since = monthYear(history.first_commit_date);
    const cli = (name) => bench.cli.find((r) => r.name === name).results;
    const version = cli(named.startup);
    const pokedex = cli(named.pokedex);
    const corpus = bench.corpus.results;
    const report = big.reports[0];
    // The largest input measured here, and the largest quicktype was timed on too.
    const largest = big.measured.inputs.reduce((a, b) => (b.bytes > a.bytes ? b : a));
    const against = big.measured.inputs.filter((i) => i.quicktype !== undefined).reduce((a, b) => (a === undefined || b.bytes > a.bytes ? b : a), undefined);
    const contributorsUrl = `${repo.url}/graphs/contributors`;
    const licenseUrl = `${repo.url}/blob/${repo.default_branch}/LICENSE`;

    const header = `<a class="skip" href="#main">Skip to the content</a>
<header class="site-head">
<a class="brand" href="./" aria-label="quickertype, home">
<svg class="mark" viewBox="0 0 32 32" aria-hidden="true"><rect x="2" y="7" width="12" height="7" rx="3.5" class="mark-wasm"/><rect x="2" y="18" width="28" height="7" rx="3.5" class="mark-ts"/></svg>
<span class="wordmark">quickertype</span>
</a>
<nav aria-label="Site"><a href="./app/">Playground</a><a href="./benchmarks.html">Benchmarks</a><a href="${repository}">GitHub</a></nav>
</header>`;

    const hero = `<section class="hero" aria-labelledby="hero-title">
${picture(images, "speed-trails", "", { sizes: "100vw", eager: true, className: "hero-art" })}
<div class="hero-grid">
<div class="hero-copy">
<h1 id="hero-title">quicktype, rewritten in&nbsp;Rust.</h1>
<p class="hero-lead">The same CLI, the same API and the same output, byte for byte. Up to ${stat("upto", Number(speed.upTo), `${speed.upTo}×`)} faster, in a fraction of the memory.</p>
${raceHtml(bench)}
<p class="actions"><a class="button primary" href="./app/">Try it in the playground</a><a class="button" href="#install">Install the CLI</a></p>
<p class="hero-credit">A port of <a href="${repo.url}">quicktype</a>, the work of ${stat("contributors-hero", people.length)} contributors since ${e(since)}. <a href="#thanks">Thank you</a>.</p>
</div>
${specimenHtml(facts.specimen)}
</div>
</section>`;

    const yearsChart = columnChart({
        name: `Commits to quicktype per year, ${Object.keys(history.commits_by_year)[0]} to ${longDate(history.commit_date)}`,
        columns: Object.entries(history.commits_by_year).map(([year, n]) => ({ label: year, value: n, title: `${year}: ${number(n)} commits` })),
        format: number,
    });
    const thanks = `<section id="thanks" class="thanks" aria-labelledby="thanks-title">
<div class="thanks-intro">
<div class="thanks-text">
<h2 id="thanks-title">Thank you, quicktype</h2>
<p class="lead">quickertype would not exist without quicktype. Its type inference, its naming, its ${stat("languages", facts.languages)} languages, its command line and its test suite are the work of the people below, built in the open since ${e(since)}.</p>
<p>quickertype translates that work to Rust, file by file, and checks every result against theirs. The design, the generated code and the test inputs are quicktype's. When the output should change, the change belongs in quicktype first; quickertype follows.</p>
<p class="thanks-links"><a class="button" href="${repo.url}">quicktype on GitHub</a><a class="button" href="${e(repo.homepage)}">Try quicktype</a><a class="button" href="${contributorsUrl}">All contributors</a><a class="button" href="${licenseUrl}">${e(repo.license)} license</a></p>
</div>
${picture(images, "thanks-threads", "Abstract art: hundreds of fine blue and violet threads twisting together into one cord", { sizes: "(min-width: 1000px) 560px, 100vw" })}
</div>
<ul class="ledger quicktype-facts">
<li><b class="figure">${stat("years", years)}</b> <span>years of work in the open, since the first commit in ${e(since)}</span></li>
<li><b class="figure">${stat("contributors", people.length)}</b> <span>people on GitHub's list of quicktype's contributors</span></li>
<li><b class="figure">${stat("commits", history.commits)}</b> <span>commits (merges aside), up to the one quickertype matches</span></li>
<li><b class="figure">${stat("languages-ledger", facts.languages)}</b> <span>output languages, every one of them ported</span></li>
<li><b class="figure">${stat("inputs", inputs.files)}</b> <span>test inputs from quicktype's suite, reused here unmodified</span></li>
<li><b class="figure">${stat("stars", repo.stars, thousands(repo.stars))}</b> <span>stars on GitHub (${e(longDate(quicktype.retrieved))})</span></li>
</ul>
<figure class="chart years" aria-labelledby="years-title">
<figcaption id="years-title">Commits to quicktype per year, ${e(since)} to ${e(longDate(history.commit_date))}</figcaption>
${yearsChart}
${tableView("Commits per year (merges left out)", ["Year", "Commits"], Object.entries(history.commits_by_year).map(([y, n]) => [y, number(n)]))}
</figure>
<div class="people">
<h3>quicktype's contributors</h3>
<p>All ${stat("contributors-wall", people.length)} people GitHub lists for <a href="${repo.url}">${e(repo.url.replace("https://github.com/", ""))}</a>, most commits first; bots are left out. Each links to their profile.</p>
${contributorWall(people)}
</div>
<p class="disclaimer">quickertype is an independent port, licensed ${e(repo.license)} like quicktype (see its <a href="${landingLinks.notice}">NOTICE</a>). It is not affiliated with or endorsed by quicktype or ${e(repo.owner.name)}.</p>
</section>`;

    const k = golden.kinds;
    const corpusChart = valueRows({
        kind: "ours",
        rows: [
            ["JSON to code", k.json],
            ["JSON Schema to code", k.schema],
            ["The command line itself: help, errors, output streams, exit codes", k.cli],
            ["GraphQL to code", k.graphql],
        ].map(([name, n]) => ({ name, value: n, text: `${Math.round((n / golden.cases) * 100) || "<1"}%`, tip: number(n), label: `${name}: ${number(n)} recorded cases` })),
    });
    const steps = [
        ["quicktype runs its own tests", `Every fixture in quicktype's test suite, in every language and option variant it uses, on ${stat("flow-inputs", inputs.files)} test inputs. <code>cargo xtask golden</code> records them.`],
        ["Each run is recorded", `${stat("golden-cases", golden.cases)} cases: each command line, with the exact files, output streams and exit code it produced.`],
        ["Every change replays them", `<code>cargo xtask parity</code> runs all ${stat("golden-steps", golden.steps)} commands with quickertype, on every push.`],
        ["Byte for byte", `${stat("golden-passing", golden.passing)} of ${number(golden.cases)} identical. The one allowed difference is the command's name in <code>--help</code>.`],
    ];
    const tested = `<section id="tested" class="tested" aria-labelledby="tested-title">
<div class="tested-intro">
<div>
<h2 id="tested-title">Checked against quicktype, byte for byte</h2>
<p class="lead">Close is not enough: quickertype's output has to be quicktype's, to the last byte. Every change is checked against runs recorded from quicktype's own command line, and fuzzers keep looking for an input on which the two disagree.</p>
</div>
${picture(images, "parity-mirror", "Abstract art: two identical glass lattices on either side of a thin line of light", { sizes: "(min-width: 1000px) 440px, 100vw" })}
</div>
<ol class="flow">${steps.map(([title, text]) => `<li><h3>${title}</h3><p>${text}</p></li>`).join("")}</ol>
<div class="fuzzing">
<div>
<h3>Fuzzing finds what the recordings miss</h3>
<p>Seeded random JSON, JSON Schemas, Postman collections and GraphQL queries, with random options in every language, run through quicktype and quickertype, in process and through both command lines. Every difference is minimized into a regression test that stays in the repository: ${stat("fuzz-regressions", fuzz.regressions)} so far. <a href="${landingLinks.fuzz}">How it works</a></p>
</div>
<ol class="loop" aria-label="One round of differential fuzzing">
<li>A seed picks an input, a language and options</li>
<li>quicktype and quickertype both run it</li>
<li>Their outputs are compared, byte for byte</li>
<li>A difference is minimized and kept as a test</li>
</ol>
</div>
<div class="tested-more">
<ul class="ledger checks">
<li><b class="figure">${stat("scenarios", differential.scenarios)}</b> <span>JavaScript API scenarios, called on quicktype-core and on quickertype-core and compared: every file, line, annotation, error and console message, in CI</span></li>
<li><b class="figure">${stat("roundtrip-fixtures", workflows.roundtrip.fixtures)}</b> <span>of quicktype's end-to-end fixtures, run ${workflows.roundtrip.cadence} with quickertype: the generated code is compiled by each language's own toolchain and must round-trip the samples</span></li>
<li><b class="figure">${stat("fuzz-targets", workflows.fuzz.targets)}</b> <span>crash-fuzzing targets, run ${workflows.fuzz.cadence}: the parsers, the command line and the whole pipeline</span></li>
<li><b class="figure">${stat("streaming-seeds", fuzz.streamingSeeds)}</b> <span>seeds in each run of the streaming fuzzer, which holds quickertype's faster JSON inference to the results of quicktype's own method</span></li>
<li><b class="figure">${stat("rust-tests", rust.tests)}</b> <span>Rust tests, including ports of quicktype's own unit tests</span></li>
<li><b class="figure">${stat("ci-os", workflows.ci.os.length)}</b> <span>operating systems in CI: ${e(new Intl.ListFormat("en-US").format(workflows.ci.os))}</span></li>
</ul>
<figure class="chart" aria-labelledby="corpus-kinds-title">
<figcaption id="corpus-kinds-title">The ${number(golden.cases)} recorded cases, by what they cover</figcaption>
${corpusChart}
${tableView("Recorded cases in tests/golden, by what they cover", ["Kind", "Cases"], [["JSON to code", number(k.json)], ["JSON Schema to code", number(k.schema)], ["The command line itself", number(k.cli)], ["GraphQL to code", number(k.graphql)]])}
</figure>
</div>
<p class="more">And on every deploy, headless Chrome runs this site's playground on both engines and compares its output with the CLI's. The rules that keep the output identical, and the known gaps: <a href="${landingLinks.parity}">docs/PARITY.md</a>.</p>
</section>`;

    // The runs the speed section shows, found in the data by what they run,
    // and how it words them, with the size their benchmark's name gives.
    const shown = (pattern) => {
        const found = bench.cli.filter((r) => pattern.test(r.name));
        if (found.length !== 1) throw new Error(`site/data/benchmarks.json: the landing page shows one benchmark matching ${pattern}, and it has ${found.length}`);
        return found[0].name;
    };
    const wording = [
        [named.startup, () => "Start-up (--version)"],
        [named.pokedex, (size) => `pokedex.json (${size}) to TypeScript`],
        [shown(/^github-events \([^)]*\) → ts$/), (size) => `github-events.json (${size}) to TypeScript`],
        [shown(/^github\.gqlschema \([^)]*\) \+ query → TypeScript$/), (size) => `GraphQL schema (${size}) and query to TypeScript`],
        [shown(/^vega-lite\.schema \([^)]*\) → TypeScript$/), (size) => `JSON Schema (vega-lite, ${size}) to TypeScript`],
    ];
    const small = wording.map(([name]) => name);
    const pretty = Object.fromEntries(wording.map(([name, say]) => [name, say(name === named.startup ? undefined : sizeIn(name))]));
    const runChart = pairRows({
        rows: small.map((name) => {
            const r = cli(name);
            return { name: pretty[name], theirs: r.typescript.median_ms, ours: r.rust.median_ms, value: `${times(r.typescript.median_ms / r.rust.median_ms)} faster` };
        }),
        format: formatMs,
        what: "wall time",
    });
    const memoryRows = [named.startup, named.pokedex, named.large];
    const memoryChart = pairRows({
        rows: memoryRows.map((name) => {
            const r = cli(name);
            return {
                name: pretty[name] ?? name.replace(" → ", " to "),
                theirs: r.typescript.peak_rss_mib,
                ours: r.rust.peak_rss_mib,
                value: `${times(r.typescript.peak_rss_mib / r.rust.peak_rss_mib)} less`,
            };
        }),
        format: formatMiB,
        what: "peak memory",
    });
    const corpusPair = pairRows({
        rows: [{ name: `All ${number(corpus.typescript.steps)} runs, ${bench.corpus.jobs} at a time`, theirs: corpus.typescript.wall_s, ours: corpus.rust.wall_s, value: `${times(speed.corpus)} faster` }],
        format: (s) => `${s} s`,
        what: "wall time",
    });
    const browserChart = valueRows({
        rows: browser.rows.map((r) => ({
            name: r.input,
            value: r.theirs / r.ours,
            text: `${formatMs(r.theirs)} → ${formatMs(r.ours)}`,
            tip: times(r.theirs / r.ours),
            label: `${r.input}: quickertype ${times(r.theirs / r.ours)} faster, ${formatMs(r.ours)} against quicktype's ${formatMs(r.theirs)}`,
        })),
    });
    const machine = bench.machine;
    // Big files: a user's report (quicktype's bar drawn as long as it was
    // known to run, and going on), and the largest input measured here.
    const bigFiles = `<figure class="chart" aria-labelledby="big-title">
<figcaption id="big-title">Big files${report === undefined ? "" : `: ${e(report.input)}, as a user reported it`}</figcaption>
${
    report === undefined
        ? ""
        : pairChart({
              theirs: { name: "quicktype", value: report.quicktype_seconds_at_least, text: report.quicktype, label: `quicktype: ${report.quicktype}` },
              ours: { name: "quickertype", value: report.quickertype_seconds, text: report.quickertype, label: `quickertype: ${report.quickertype}` },
              tips: false,
              more: true,
          })
}
<p class="fineprint">${report === undefined ? "" : `${e(report.source)} `}Measured here: ${stat("big-size", largest.size)} of JSON (${e(largest.description)}) in ${stat("big-seconds", largest.seconds, seconds(largest.seconds))}, at a peak of ${stat("big-memory", largest.peak_rss_mib, formatMiB(largest.peak_rss_mib))}.${
    against === undefined
        ? ""
        : ` On ${stat("against-size", against.size)} (${e(against.description)}), quicktype took ${stat("against-quicktype-seconds", against.quicktype.seconds, seconds(against.quicktype.seconds))} and ${stat("against-quicktype-memory", against.quicktype.peak_rss_mib, formatMiB(against.quicktype.peak_rss_mib))}; quickertype ${stat("against-seconds", against.seconds, seconds(against.seconds))} and ${stat("against-memory", against.peak_rss_mib, formatMiB(against.peak_rss_mib))}.`
}</p>
</figure>`;
    const speedSection = `<section id="speed" class="speed" aria-labelledby="speed-title">
<h2 id="speed-title">Up to ${speed.upTo}× faster, in a fraction of the memory</h2>
<p class="lead">On a small file, most of a quicktype run is starting Node.js and loading quicktype: ${stat("startup-quicktype", version.typescript.median_ms, formatMs(version.typescript.median_ms))} for <code>--version</code> alone. quickertype is a native program that answers it in ${stat("startup-quickertype", version.rust.median_ms, formatMs(version.rust.median_ms))}. Its engine is faster on large inputs too, where the work itself is the cost.</p>
<div class="charts">
<figure class="chart wide" aria-labelledby="runs-title">
<figcaption id="runs-title">One run of the CLI: wall time, median of ${bench.iterations} runs</figcaption>
${legend()}
${runChart}
${tableView(`CLI wall time per run, median of ${bench.iterations} runs after one warm-up`, ["Run", "quicktype", "quickertype", "Faster"], small.map((name) => {
    const r = cli(name);
    return [pretty[name], formatMs(r.typescript.median_ms), formatMs(r.rust.median_ms), times(r.typescript.median_ms / r.rust.median_ms)];
}))}
</figure>
<div class="column">
<figure class="chart" aria-labelledby="memory-title">
<figcaption id="memory-title">Peak memory of one CLI run</figcaption>
${legend()}
${memoryChart}
${tableView("Peak resident memory of one CLI run", ["Run", "quicktype", "quickertype", "Less"], memoryRows.map((name) => {
    const r = cli(name);
    return [pretty[name] ?? name.replace(" → ", " to "), formatMiB(r.typescript.peak_rss_mib), formatMiB(r.rust.peak_rss_mib), times(r.typescript.peak_rss_mib / r.rust.peak_rss_mib)];
}))}
</figure>
<figure class="chart" aria-labelledby="corpus-title">
<figcaption id="corpus-title">quicktype's whole test corpus, CLI against CLI</figcaption>
${legend()}
${corpusPair}
<p class="fineprint">Every step of every recorded case: ${stat("corpus-quicktype", corpus.typescript.wall_s, `${corpus.typescript.wall_s} s`)} against ${stat("corpus-quickertype", corpus.rust.wall_s, `${corpus.rust.wall_s} s`)}.</p>
</figure>
</div>
<div class="column">
<figure class="chart" aria-labelledby="browser-title">
<figcaption id="browser-title">In the browser: the WebAssembly engine, how many times faster than quicktype's, warm in Chrome ${e(browser.chrome)}</figcaption>
${browserChart}
${tableView("Warm runs in headless Chrome, reading plus generating, ms (site/data/browser.json)", ["Input", "quicktype", "quickertype", "Faster"], browser.rows.map((r) => [r.input, formatMs(r.theirs), formatMs(r.ours), times(r.theirs / r.ours)]))}
<p class="fineprint">Both engines run inside the page, so neither starts a process: the gap is the engines'. From <a href="${landingLinks.benchmarksDoc}">docs/BENCHMARKS.md</a>.</p>
</figure>
${bigFiles}
</div>
</div>
<p class="more">Measured with <code>cargo xtask bench</code> on ${e(machine.cpu)}, ${e(longDate(bench.date))}, against quicktype at the commit quickertype matches. <a href="./benchmarks.html">Every benchmark, and how they were run</a></p>
</section>`;

    const install = `<section id="install" class="install" aria-labelledby="install-title">
<h2 id="install-title">Use it</h2>
<div class="ways">
<div class="way">
<h3>In your browser</h3>
<p>The playground runs quicktype's API on quickertype's WebAssembly engine, right in the page. Switch to quicktype's own engine to compare the output and the time.</p>
<p><a class="button primary" href="./app/">Open the playground</a></p>
</div>
<div class="way">
<h3>On the command line</h3>
<p>The command is <code>quickertype</code>, with quicktype's flags and output.</p>
<pre class="commands"><code>brew install elob/tap/quickertype
npm install -g quickertype
cargo install quickertype</code></pre>
<p>Or an installer for macOS, Linux or Windows: <a href="${landingLinks.install}">see Install</a>.</p>
</div>
<div class="way">
<h3>From JavaScript or Rust</h3>
<p><a href="${landingLinks.npmCore}"><code>quickertype-core</code></a> on npm is quicktype-core's own API on the WebAssembly engine: change the import, nothing else.</p>
<pre class="commands"><code>npm install quickertype-core</code></pre>
<p>In Rust, the <a href="${landingLinks.crate}"><code>quickertype-core</code></a> crate is the engine the CLI is built on.</p>
</div>
</div>
</section>`;

    const footer = `<footer class="site-foot">
<p>quickertype is a port of <a href="${repo.url}">quicktype</a>, licensed ${e(repo.license)} like quicktype. Not affiliated with or endorsed by quicktype or ${e(repo.owner.name)}.</p>
<p>Its output matches quicktype at commit <a href="https://github.com/glideapps/quicktype/commit/${reference.commit}"><code>${reference.short}</code></a> (<time datetime="${reference.date}">${e(longDate(reference.date))}</time>). The section images were made with Google Flow.</p>
<p><a href="./app/">Playground</a> <a href="./benchmarks.html">Benchmarks</a> <a href="${repository}">github.com/EloB/quickertype</a></p>
</footer>`;

    return `${header}\n<main id="main">\n${hero}\n${thanks}\n${tested}\n${speedSection}\n${install}\n</main>\n${footer}`;
}

/** The page's meta description, from the same numbers. */
export function landingDescription(facts) {
    return `quickertype is quicktype rewritten in Rust: the same CLI, API and output, byte for byte, up to ${facts.speed.upTo}× faster. Checked against ${number(facts.golden.cases)} recorded quicktype runs. With thanks to quicktype and its ${facts.quicktype.contributors.people.length} contributors.`;
}

