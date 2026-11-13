// The playground page: input on the left, generated code on the right.
// quicktype-core runs in Web Workers (engine-client.js, worker.js); this
// file only handles the page and its state.
//
// State that can be shared lives in the URL hash, in the form of quicktype's
// README links (`#l=rust`), plus `s` (an unmodified sample), `n` (a typed
// top-level name), `c=1` (compare mode), the general options that are on
// (`no-enums=true`) and renderer options by their CLI names
// (`#l=cs&density=dense`). A renderer option is in the hash when it differs
// from the page's default: quicktype's, or the language's preset (see
// site/build.mjs), so moving a preset back to quicktype's default is
// explicit (`#l=rust&density=normal`). The input text is kept in
// localStorage when the browser allows it.

/* global __LANGUAGES__, __SAMPLES__, __GENERAL__ */

import { EngineClient } from "./engine-client.js";
import { highlight } from "./highlight.js";
import { escapeHtml } from "./html.js";

const languages = __LANGUAGES__;
const samples = __SAMPLES__;
/** quicktype's general options: { name (the CLI flag), label, option (of `quicktype()`), value (when on) }. */
const general = __GENERAL__;

const storageKey = "quickertype.input";
/** Inputs longer than this (in characters) are not put in the editor or saved. */
const LARGE = 1_000_000;
const defaultLanguage = "typescript";
const defaultSample = "pokedex";

const $ = (id) => document.getElementById(id);
const els = {
    lang: $("lang"),
    name: $("name"),
    compare: $("compare"),
    options: $("options"),
    general: $("general"),
    generalOptions: $("general-options"),
    generalCount: $("general-count"),
    sample: $("sample"),
    open: $("open"),
    file: $("file"),
    input: $("input"),
    inputPane: $("input-pane"),
    large: $("large"),
    largeName: $("large-name"),
    largeSize: $("large-size"),
    largeEdit: $("large-edit"),
    inputInfo: $("input-info"),
    tabs: $("tabs"),
    copy: $("copy"),
    download: $("download"),
    meter: $("meter"),
    notes: $("notes"),
    output: $("output"),
    code: $("code"),
    error: $("error"),
    cli: $("cli"),
    copyCli: $("copy-cli"),
};

function languageNamed(name) {
    const wanted = String(name ?? "").toLowerCase();
    return languages.find((l) => l.names.some((n) => n.toLowerCase() === wanted));
}

const sampleWithId = (id) => samples.find((s) => s.id === id);

/** A type name from a file name: `us-senators.json` → `UsSenators`. */
function nameFromFile(fileName) {
    const base = fileName.replace(/\.[^.]*$/, "").replace(/\.schema$/i, "");
    const name = base
        .split(/[^A-Za-z0-9]+/)
        .filter(Boolean)
        .map((w) => w[0].toUpperCase() + w.slice(1))
        .join("");
    if (name === "") return "TopLevel";
    return /^[0-9]/.test(name) ? `T${name}` : name;
}

function formatBytes(n) {
    if (n < 1000) return `${n} bytes`;
    if (n < 1_000_000) return `${(n / 1000).toFixed(1)} kB`;
    return `${(n / 1_000_000).toFixed(1)} MB`;
}

function formatMs(x) {
    if (x >= 10_000) return `${(x / 1000).toFixed(1)} s`;
    if (x >= 1000) return `${(x / 1000).toFixed(2)} s`;
    if (x >= 100) return `${Math.round(x)} ms`;
    if (x >= 10) return `${x.toFixed(1)} ms`;
    return `${x.toFixed(2)} ms`;
}

const encoder = new TextEncoder();
const utf8Length = (s) => encoder.encode(s).length;

function median(xs) {
    const sorted = [...xs].sort((a, b) => a - b);
    const mid = sorted.length >> 1;
    return sorted.length % 2 === 1 ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2;
}

// ---------------------------------------------------------------------------
// State

const state = {
    kind: "json",
    text: "",
    /** { type: "sample", id } | { type: "file", fileName, size } | { type: "typed" } */
    source: { type: "typed" },
    /** The name from the sample or file name; used unless the user typed one. */
    autoName: "TopLevel",
    /** What the top-level name field holds ("" or `autoName` unless the user typed a name). */
    name: "",
    lang: languageNamed(defaultLanguage),
    /** Renderer options that differ from quicktype's defaults (presets included), by CLI name. */
    options: {},
    /** The general options that are on, by CLI name (all are off by default). */
    general: {},
    compare: false,
    /** Show a large input in the editor anyway. */
    largeInEditor: false,
};

const topLevelName = () => state.name.trim() || state.autoName;
const typedName = () => (state.name.trim() !== "" && state.name.trim() !== state.autoName ? state.name.trim() : "");

/** An option's default on this page: the language's preset, else quicktype's default. */
const pageDefault = (definition) => definition.preset ?? definition.defaultValue;

/** The renderer options a language starts with: its presets. */
const presetOptions = (lang) =>
    Object.fromEntries(lang.options.filter((o) => o.preset !== undefined).map((o) => [o.name, o.preset]));

function parseOption(definition, raw) {
    if (raw === null || raw === undefined) return undefined;
    if (definition.type === "boolean") return raw === "true" ? true : raw === "false" ? false : undefined;
    if (definition.type === "enum") return definition.values.includes(raw) ? raw : undefined;
    return raw;
}

function readHash() {
    const params = new URLSearchParams(location.hash.slice(1));
    const lang = languageNamed(params.get("l")) ?? languageNamed(defaultLanguage);
    const options = {};
    for (const definition of lang.options) {
        const value = parseOption(definition, params.get(definition.name)) ?? pageDefault(definition);
        if (value !== definition.defaultValue) options[definition.name] = value;
    }

    const on = {};
    for (const g of general) if (params.get(g.name) === "true") on[g.name] = true;
    return {
        lang,
        options,
        general: on,
        name: params.get("n") ?? "",
        sample: sampleWithId(params.get("s")),
        compare: params.get("c") === "1",
    };
}

function writeHash() {
    const params = new URLSearchParams();
    params.set("l", state.lang.names[0]);
    if (state.source.type === "sample") params.set("s", state.source.id);
    if (typedName() !== "") params.set("n", typedName());
    if (state.compare) params.set("c", "1");
    for (const g of general) if (state.general[g.name]) params.set(g.name, "true");
    for (const definition of state.lang.options) {
        const value = state.options[definition.name] ?? definition.defaultValue;
        if (value !== pageDefault(definition)) params.set(definition.name, String(value));
    }
    const hash = `#${params}`;
    if (location.hash !== hash) history.replaceState(null, "", hash);
}

function saveInput() {
    try {
        if (state.text.length > LARGE) {
            localStorage.removeItem(storageKey);
        } else {
            const { kind, text, source, autoName } = state;
            localStorage.setItem(storageKey, JSON.stringify({ kind, text, source, autoName }));
        }
    } catch {
        // Storage is off or full: the page works without it.
    }
}

function loadSavedInput() {
    try {
        const saved = JSON.parse(localStorage.getItem(storageKey) ?? "null");
        if (saved === null || typeof saved.text !== "string") return undefined;
        if (saved.kind !== "json" && saved.kind !== "schema") return undefined;
        return saved;
    } catch {
        return undefined;
    }
}

const sampleCache = new Map();

async function fetchSample(sample) {
    let text = sampleCache.get(sample.id);
    if (text === undefined) {
        const response = await fetch(sample.path);
        if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);
        text = await response.text();
        sampleCache.set(sample.id, text);
    }

    return text;
}

// ---------------------------------------------------------------------------
// Controls

function renderLanguages() {
    els.lang.innerHTML = languages
        .map((l) => `<option value="${escapeHtml(l.names[0])}">${escapeHtml(l.displayName)}</option>`)
        .join("");
}

function renderSamples() {
    const group = (kind, label) =>
        `<optgroup label="${label}">${samples
            .filter((s) => s.kind === kind)
            .map((s) => `<option value="${s.id}">${escapeHtml(s.label)}</option>`)
            .join("")}</optgroup>`;
    els.sample.innerHTML = `<option value="">Load a sample…</option>${group("json", "JSON")}${group("schema", "JSON Schema")}`;
}

let moreOpen = false;
let generalOpen = false;

/** What leaving `just-types` off gives, next to it: quicktype's default is more than types. */
const justTypesHint = "Off: types plus runtime conversion code (quicktype's default)";

/** A small mark on an option whose page default is a preset, saying so and what quicktype's default is. */
function presetMark(definition) {
    if (definition.preset === undefined) return "";
    const quicktypeDefault =
        definition.type === "boolean" ? (definition.defaultValue ? "on" : "off") : String(definition.defaultValue);
    const title = `Preset as on app.quicktype.io; quicktype's default is ${quicktypeDefault}`;
    return ` <span class="preset" title="${escapeHtml(title)}">preset</span>`;
}

function optionControl(definition) {
    const id = `opt-${definition.name}`;
    const value = state.options[definition.name] ?? definition.defaultValue;
    const flag = `--${definition.name}`;
    const label = escapeHtml(definition.description) + presetMark(definition);
    if (definition.type === "boolean") {
        const hint = definition.name === "just-types" ? justTypesHint : undefined;
        return `<label class="check${hint ? " hinted" : ""}" title="${flag}"><input type="checkbox" id="${id}" data-option="${definition.name}"${value ? " checked" : ""}><span>${label}${
            hint ? `<small class="hint">${escapeHtml(hint)}</small>` : ""
        }</span></label>`;
    }

    if (definition.type === "enum") {
        const choices = definition.values
            .map((v) => `<option${v === value ? " selected" : ""}>${escapeHtml(v)}</option>`)
            .join("");
        return `<label class="field" title="${flag}"><span class="field-label">${label}</span><select id="${id}" data-option="${definition.name}">${choices}</select></label>`;
    }

    return `<label class="field" title="${flag}"><span class="field-label">${label}</span><input type="text" id="${id}" data-option="${definition.name}" value="${escapeHtml(value)}" placeholder="${escapeHtml(definition.typeLabel ?? "")}" spellcheck="false" autocomplete="off"></label>`;
}

/** How many general options there are, or how many are on. */
function renderGeneralCount() {
    const on = general.filter((g) => state.general[g.name]).length;
    els.generalCount.textContent = on > 0 ? `${on} on` : String(general.length);
    els.generalCount.classList.toggle("on", on > 0);
}

/** The General section: collapsed unless an option in it is on (from a link). */
function renderGeneral() {
    if (general.some((g) => state.general[g.name])) generalOpen = true;
    els.general.open = generalOpen;
    renderGeneralCount();
    els.generalOptions.innerHTML = general
        .map(
            (g) =>
                `<label class="check" title="--${g.name}"><input type="checkbox" id="general-${g.name}" data-general="${g.name}"${state.general[g.name] ? " checked" : ""}><span>${escapeHtml(g.label)}</span></label>`,
        )
        .join("");
}

function renderOptions() {
    const { options, displayName } = state.lang;
    const primary = options.filter((o) => o.kind === "primary");
    const secondary = options.filter((o) => o.kind !== "primary");
    if (secondary.some((o) => o.name in state.options)) moreOpen = true;
    let html = "";
    if (options.length === 0) {
        html = `<p class="no-options">${escapeHtml(displayName)} has no options.</p>`;
    } else {
        if (primary.length > 0) html += `<div class="option-grid">${primary.map(optionControl).join("")}</div>`;
        if (secondary.length > 0) {
            html += `<details class="more"${moreOpen ? " open" : ""}><summary>More options <span class="count">${secondary.length}</span></summary><div class="option-grid">${secondary.map(optionControl).join("")}</div></details>`;
        }
    }

    els.options.innerHTML = html;
    els.options.querySelector("details")?.addEventListener("toggle", (event) => {
        moreOpen = event.target.open;
    });
}

function renderControls() {
    els.lang.value = state.lang.names[0];
    if (document.activeElement !== els.name) els.name.value = topLevelName();
    els.name.placeholder = state.autoName;
    els.compare.checked = state.compare;
    for (const radio of document.querySelectorAll('input[name="kind"]')) radio.checked = radio.value === state.kind;
    els.sample.value = state.source.type === "sample" ? state.source.id : "";
    renderOptions();
    renderGeneral();
    renderCli();
}

function inputFileName() {
    if (state.source.type === "sample") return sampleWithId(state.source.id).path.split("/").pop();
    if (state.source.type === "file") return state.source.fileName;
    return state.kind === "schema" ? "input.schema" : "input.json";
}

const shellQuote = (s) => (/^[A-Za-z0-9_.,:/=+@%-]+$/.test(s) ? s : `'${s.replace(/'/g, "'\\''")}'`);

/** The quicktype CLI command that gives the same output. */
function cliCommand() {
    const args = ["quicktype"];
    if (state.kind === "schema") args.push("--src-lang", "schema");
    args.push("--lang", state.lang.names[0], "--top-level", topLevelName());
    for (const g of general) if (state.general[g.name]) args.push(`--${g.name}`);
    for (const definition of state.lang.options) {
        if (!(definition.name in state.options)) continue;
        const value = state.options[definition.name];
        if (definition.type === "boolean") args.push(value ? `--${definition.name}` : `--no-${definition.name}`);
        else args.push(`--${definition.name}`, value);
    }

    args.push(inputFileName());
    return args.map(shellQuote).join(" ");
}

function renderCli() {
    els.cli.textContent = cliCommand();
}

function showInput() {
    const large = state.text.length > LARGE && !state.largeInEditor;
    els.input.hidden = large;
    els.large.hidden = !large;
    if (large) {
        els.largeName.textContent = inputFileName();
        els.largeSize.textContent = formatBytes(state.source.size ?? utf8Length(state.text));
    } else if (els.input.value !== state.text) {
        els.input.value = state.text;
    }

    showInputInfo();
}

function showInputInfo() {
    const size = state.source.type === "file" && state.source.size !== undefined ? state.source.size : utf8Length(state.text);
    let from = "Your input";
    if (state.source.type === "sample") from = `Sample: ${sampleWithId(state.source.id).path.split("/").pop()}`;
    else if (state.source.type === "file") from = state.source.fileName;
    els.inputInfo.innerHTML = `<span>${escapeHtml(from)}</span><span>${formatBytes(size)}</span>`;
}

// ---------------------------------------------------------------------------
// Running

const engines = { wasm: new EngineClient("wasm"), ts: new EngineClient("ts") };
const engineNames = { wasm: "WebAssembly", ts: "TypeScript" };

/** What the output pane shows. */
const view = {
    status: "idle", // "empty" | "running" | "done"
    request: undefined,
    wasm: undefined, // the WebAssembly worker's result
    ts: undefined, // the TypeScript worker's result, "running", or undefined
    /** A warm measurement of the result shown: { wasm, ts }, each a result, "running" or undefined. */
    bench: undefined,
    files: [],
    tab: 0,
    runningSince: 0,
    /** The language and top-level name of the result shown. */
    shown: { lang: undefined, name: "" },
    /** The run whose WebAssembly (and, comparing, TypeScript) result is shown. */
    settled: 0,
    settledTs: 0,
    /** How many TypeScript results have been shown (for tests). */
    comparisons: 0,
};

let generation = 0;
let runTimer;
let ticker;
/**
 * The latest run (or comparison), settled once its results are shown.
 * A measurement waits for it, so that it never replaces a run's request.
 */
let currentRun = Promise.resolve();

/** The `quicktype()` options the general options that are on set, as quicktype's CLI sets them. */
function runOptions() {
    const options = {};
    for (const g of general) if (state.general[g.name]) options[g.option] = g.value;
    return options;
}

function request() {
    return {
        kind: state.kind,
        lang: state.lang.names[0],
        name: topLevelName(),
        text: state.text,
        rendererOptions: { ...state.options },
        options: runOptions(),
    };
}

function schedule(delay) {
    clearTimeout(runTimer);
    runTimer = setTimeout(run, delay);
}

/** Debounce for typing: longer for longer inputs. */
const typingDelay = () => Math.min(1000, 200 + state.text.length / 5000);

/** Runs the input on WebAssembly, and comparing, then on TypeScript. A newer run replaces it. */
function run() {
    clearTimeout(runTimer);
    currentRun = runGeneration(++generation);
    return currentRun;
}

async function runGeneration(gen) {
    const req = request();
    view.request = req;
    view.bench = undefined;
    if (!/\S/.test(req.text)) {
        setRunning(false);
        view.status = "empty";
        view.wasm = undefined;
        view.ts = undefined;
        view.settled = gen;
        view.settledTs = gen;
        render();
        return;
    }

    setRunning(true);
    const wasm = await engines.wasm.run(req);
    // A newer run is under way and shows its own result.
    if (gen !== generation) return;
    if (wasm === undefined) {
        // Replaced by a request that is not a newer run. Nothing should do
        // that (a measurement waits for runs), but never leave the page
        // saying "Running" for good: run again.
        schedule(0);
        return;
    }

    view.wasm = wasm;
    view.shown = { lang: languageNamed(req.lang), name: req.name };
    view.settled = gen;
    view.status = "done";
    view.ts = undefined;
    if (wasm.ok) showFiles(wasm.files);
    setRunning(false);
    if (state.compare) await compare(gen, req);
    else render();
}

/** Runs the request whose WebAssembly result is shown on the TypeScript engine too. */
async function compare(gen, req) {
    view.ts = "running";
    render();
    const ts = await engines.ts.run(req);
    if (ts === undefined || gen !== generation || !state.compare) return;
    view.ts = ts;
    view.settledTs = gen;
    view.comparisons++;
    render();
}

/**
 * Measures warm runs of what the page shows: after the run in progress, if
 * any, so that the numbers belong to the result on screen. A newer run
 * cancels the measurement (it replaces `view.bench`).
 */
async function measure() {
    const bench = { wasm: "running", ts: undefined };
    view.bench = bench;
    render();
    for (let pending = currentRun; ; pending = currentRun) {
        await pending;
        if (pending === currentRun) break;
    }

    const current = () => view.bench === bench;
    const giveUp = () => {
        if (current()) {
            view.bench = undefined;
            render();
        }
    };
    if (!current()) return;
    if (view.status !== "done" || !view.wasm?.ok) return giveUp();

    const req = view.request;
    const repeat = { warmup: 1, repeat: 5 };
    const wasm = await engines.wasm.run({ ...req, ...repeat });
    if (!current()) return;
    if (wasm === undefined || !wasm.ok) return giveUp();
    bench.wasm = wasm;
    if (state.compare) {
        bench.ts = "running";
        render();
        const ts = await engines.ts.run({ ...req, ...repeat });
        if (!current()) return;
        if (ts === undefined) return giveUp();
        bench.ts = ts;
    }

    render();
}

function setRunning(running) {
    clearInterval(ticker);
    if (running) {
        view.runningSince = performance.now();
        // Only say so if it takes a moment; most runs finish first.
        ticker = setInterval(() => {
            view.status = "running";
            renderMeter();
        }, 150);
    }
}

// ---------------------------------------------------------------------------
// Output

function fileLabel(file) {
    return file.name === "stdout" ? `${view.shown.name}.${view.shown.lang.extension}` : file.name;
}

function showFiles(files) {
    const previous = view.files[view.tab]?.name;
    view.files = files;
    const same = files.findIndex((f) => f.name === previous);
    view.tab = same >= 0 ? same : 0;
}

function renderTabs() {
    const files = view.status !== "empty" && view.wasm?.ok ? view.files : [];
    els.tabs.classList.toggle("multi", files.length > 1);
    if (files.length <= 1) {
        els.tabs.innerHTML = files.length === 1 ? `<span class="filename">${escapeHtml(fileLabel(files[0]))}</span>` : "";
        return;
    }

    els.tabs.innerHTML = files
        .map((file, i) => {
            const selected = i === view.tab;
            return `<button type="button" role="tab" id="tab-${i}" aria-controls="output" aria-selected="${selected}" tabindex="${selected ? 0 : -1}" data-tab="${i}">${escapeHtml(file.name)}</button>`;
        })
        .join("");
}

/** What the code pane holds: which result's files, and which of them. */
let drawn = { files: undefined, tab: -1 };

function renderCode() {
    const result = view.wasm;
    const showError = view.status !== "empty" && result !== undefined && !result.ok;
    const file = view.status !== "empty" && result?.ok ? view.files[view.tab] : undefined;
    els.error.hidden = !showError && view.status !== "empty";
    els.output.hidden = !els.error.hidden;
    els.error.setAttribute("role", showError ? "alert" : "note");
    if (view.status === "empty") {
        els.error.className = "empty";
        els.error.innerHTML = `<p>Paste JSON or a JSON Schema on the left, load a sample, or drop a file there.</p>`;
    } else if (showError) {
        els.error.className = "error";
        const name = result.error.messageName ?? result.error.name;
        els.error.innerHTML = `<p class="error-title">quicktype stopped with an error</p><pre class="error-message">${escapeHtml(result.error.message)}</pre>${name ? `<p class="error-kind">${escapeHtml(name)}</p>` : ""}`;
    }

    // Drawn again only for another result (a new files array) or another tab.
    if (file !== undefined && (drawn.files !== view.files || drawn.tab !== view.tab)) {
        drawn = { files: view.files, tab: view.tab };
        const html = highlight(file.text, view.shown.lang.names[0]);
        if (html === undefined) els.code.textContent = file.text;
        else els.code.innerHTML = html;
        els.output.scrollTop = 0;
    }

    els.output.setAttribute("aria-labelledby", view.files.length > 1 ? `tab-${view.tab}` : "output-heading");
    els.copy.disabled = file === undefined;
    els.download.disabled = file === undefined;
    els.download.title = file === undefined ? "" : `Download ${fileLabel(file)}`;

    const annotations = file?.annotations ?? [];
    els.notes.hidden = annotations.length === 0;
    els.notes.innerHTML = annotations
        .map((a) => `<p><span class="line">Line ${a.line + 1}</span> ${escapeHtml(a.message)}</p>`)
        .join("");
}

/** Whether two results show the same thing: the same files, byte for byte, or the same error. */
function verdict(a, b) {
    if (a.ok && b.ok) {
        const bytes = a.files.reduce((n, f) => n + utf8Length(f.text), 0);
        const count = a.files.length;
        const files = `${count} file${count === 1 ? "" : "s"}, ${bytes.toLocaleString("en-US")} bytes`;
        if (a.files.length !== b.files.length || a.files.some((f, i) => f.name !== b.files[i].name)) {
            return { same: false, text: "The engines generated different files." };
        }

        for (let i = 0; i < a.files.length; i++) {
            if (a.files[i].text === b.files[i].text) continue;
            const left = a.files[i].text.split("\n");
            const right = b.files[i].text.split("\n");
            let line = 0;
            while (line < left.length && left[line] === right[line]) line++;
            const where = count > 1 ? ` in ${a.files[i].name}` : "";
            return { same: false, text: `The outputs differ${where}, from line ${line + 1}.` };
        }

        return { same: true, text: `Byte-identical output: ${files}.` };
    }

    if (!a.ok && !b.ok) {
        return a.error.message === b.error.message
            ? { same: true, text: "Both engines stopped with the same error." }
            : { same: false, text: "The engines stopped with different errors." };
    }

    return { same: false, text: `Only the ${a.ok ? "TypeScript" : "WebAssembly"} engine stopped with an error.` };
}

/** WebAssembly's time against TypeScript's, in words. */
function relative(wasmMs, tsMs) {
    const ratio = tsMs / wasmMs;
    if (!Number.isFinite(ratio) || ratio <= 0) return undefined;
    const times = (r) => (r >= 10 ? Math.round(r) : r.toFixed(1));
    if (ratio >= 1.05) return `${times(ratio)}× faster`;
    if (ratio > 1 / 1.05) return "about as fast";
    return `${times(1 / ratio)}× slower`;
}

/** How the two runs compare, overall and generating alone, and which of them include start-up. */
function speed(wasm, ts, phases) {
    const overall = relative(phases(wasm).total, phases(ts).total);
    if (overall === undefined) return "";
    const generating = relative(phases(wasm).generate, phases(ts).generate);
    let text = `WebAssembly was ${overall} overall`;
    if (generating === overall) text += " and at generating the code";
    else if (generating !== undefined) text += ` and ${generating} at generating the code`;
    const cold = [wasm.first && "WebAssembly", ts.first && "TypeScript"].filter(Boolean);
    if (cold.length === 2) return `${text}, start-up included on both sides.`;
    if (cold.length === 1) return `${text}, start-up included in the ${cold[0]} time.`;
    return `${text}.`;
}

/** A result's time, split into reading the input and generating; medians for a measurement. */
function phasesOf(result, measured) {
    const generate = result.times.map((t, i) => t - (result.inputTimes?.[i] ?? 0));
    if (measured) {
        return { total: median(result.times), input: median(result.inputTimes ?? []), generate: median(generate) };
    }

    const last = result.times.length - 1;
    return { total: result.ms, input: result.inputTimes?.[last], generate: generate[last] };
}

/** A tag for a result that did not run the way its worker's name says. */
function engineTag(worker, result) {
    if (result.ran === undefined && !result.ok) return "stopped while reading the input";
    if (result.ran !== undefined && result.ran !== worker) {
        return `ran on ${engineNames[result.ran]}${result.reason ? `: ${result.reason}` : ""}`;
    }

    return undefined;
}

function lane(worker, result, scale, timeOf, note, split) {
    const name = engineNames[worker];
    if (result === undefined || result === "running") {
        const waiting = result === "running" ? "running…" : "";
        return `<div class="lane ${worker}"><span class="engine">${name}</span><span class="bar"><span class="fill pending"></span></span><span class="time muted">${waiting}</span></div>`;
    }

    const ms = timeOf(result);
    const width = scale > 0 ? Math.max(1.5, (ms / scale) * 100) : 0;
    const tag = engineTag(worker, result);
    // The bar: reading the input (the same TypeScript code on both sides), then generating.
    const inputShare = split !== undefined && split.input !== undefined && ms > 0 ? Math.min(1, split.input / ms) : 0;
    const detail =
        split !== undefined && split.input !== undefined
            ? `reading the input ${formatMs(split.input)}, generating ${formatMs(split.generate)}`
            : undefined;
    const notes = [detail, note].filter(Boolean).join("; ");
    return `<div class="lane ${worker}"><span class="engine">${name}</span><span class="bar"><span class="fill" style="width:${width.toFixed(2)}%"><span class="input-part" style="width:${(inputShare * 100).toFixed(2)}%"></span></span></span><span class="time">${formatMs(ms)}</span>${
        notes ? `<span class="lane-note">${escapeHtml(notes)}</span>` : ""
    }${tag ? `<span class="lane-note warn">${escapeHtml(tag)}</span>` : ""}</div>`;
}

function bootNote() {
    const parts = [];
    const wasm = engines.wasm.boot;
    if (wasm?.loadError) parts.push(`The WebAssembly engine did not load (${wasm.loadError}); runs use the TypeScript engine.`);
    else if (wasm?.compileMs !== undefined) parts.push(`The .wasm engine downloaded and compiled in ${formatMs(wasm.compileMs)}.`);
    if (state.compare && engines.ts.boot !== undefined) parts.push(`The TypeScript worker loaded in ${formatMs(engines.ts.boot.startMs)}.`);
    return parts.join(" ");
}

function renderMeter() {
    const { status, wasm, ts, bench } = view;
    if (status === "empty" || (status === "idle" && wasm === undefined)) {
        els.meter.innerHTML = status === "idle" ? `<div class="lane-line muted">Loading the engine…</div>` : "";
        document.body.dataset.status = status;
        return;
    }

    if (status === "running" || wasm === undefined) {
        const elapsed = performance.now() - view.runningSince;
        const what = engines.wasm.boot === undefined ? "Loading the WebAssembly engine…" : "Running on WebAssembly…";
        els.meter.innerHTML = `<div class="lane-line"><span class="engine-dot wasm"></span>${what} <span class="time muted">${formatMs(elapsed)}</span></div>`;
        document.body.dataset.status = "running";
        return;
    }

    document.body.dataset.status = wasm.ok ? "done" : "error";
    if (wasm.ms === undefined) {
        // Nothing ran (a sample that did not load, a worker that did not start).
        els.meter.innerHTML = "";
        return;
    }

    const measured = bench !== undefined && typeof bench.wasm === "object";
    const benchTs = measured && typeof bench.ts === "object" ? bench.ts : undefined;
    const showTs = state.compare;
    const timeOf = measured ? (r) => median(r.times) : (r) => r.ms;
    const phases = (r) => phasesOf(r, measured);
    const wasmShown = measured ? bench.wasm : wasm;
    const tsShown = measured ? bench.ts : ts;
    const times = [wasmShown, tsShown].filter((r) => r !== undefined && r !== "running").map(timeOf);
    const scale = Math.max(...times, 0);
    const noteFor = (r) => {
        if (measured) return `median of ${r.times.length} warm runs`;
        return r.first ? "first run, includes start-up" : undefined;
    };

    let html = `<div class="race${showTs ? "" : " solo"}">`;
    const splitOf = (r) => (r !== undefined && r !== "running" && r.ok ? phases(r) : undefined);
    html += lane("wasm", wasmShown, showTs ? scale : timeOf(wasmShown), timeOf, noteFor(wasmShown), splitOf(wasmShown));
    if (showTs) {
        const done = tsShown !== undefined && tsShown !== "running";
        html += lane("ts", tsShown, scale, timeOf, done ? noteFor(tsShown) : undefined, splitOf(tsShown));
    }

    html += "</div>";

    let compareState = "off";
    if (showTs) {
        const a = measured ? bench.wasm : wasm;
        const b = measured ? benchTs : ts;
        if (b !== undefined && b !== "running") {
            const v = verdict(a, b);
            compareState = v.same ? "identical" : "different";
            const pace = a.ok && b.ok ? ` ${speed(measured ? { ...a, first: false } : a, measured ? { ...b, first: false } : b, phases)}` : "";
            html += `<p class="verdict ${v.same ? "same" : "differ"}" role="status"><span class="verdict-mark" aria-hidden="true">${v.same ? "✓" : "≠"}</span>${escapeHtml(v.text + pace)}</p>`;
        } else {
            compareState = "running";
        }
    }

    document.body.dataset.compare = compareState;

    const busy = bench !== undefined && (bench.wasm === "running" || bench.ts === "running");
    const fine = [];
    if (showTs) fine.push("Reading the input is quicktype's TypeScript code on both sides (the lighter part of each bar).");
    if (!measured && (wasm.first || (ts !== undefined && ts !== "running" && ts.first))) {
        fine.push(
            "A worker's first run includes start-up: instantiating the WebAssembly engine, or compiling cold JavaScript. Measure warm runs to compare speed.",
        );
    }

    if (measured) fine.push(`Each engine ran ${bench.wasm.times.length + 1} times; the first is not counted.`);
    const boot = bootNote();
    if (boot) fine.push(boot);
    html += `<div class="fine"><p>${escapeHtml(fine.join(" "))}</p><button type="button" id="measure" class="quiet"${busy || !wasm.ok ? " disabled" : ""}>${
        busy ? "Measuring…" : showTs ? "Measure warm runs" : "Measure warm run"
    }</button></div>`;
    els.meter.innerHTML = html;
}

function render() {
    renderMeter();
    renderTabs();
    renderCode();
}

// ---------------------------------------------------------------------------
// Actions

async function copyText(text, button) {
    try {
        await navigator.clipboard.writeText(text);
    } catch {
        const scratch = document.createElement("textarea");
        scratch.value = text;
        document.body.append(scratch);
        scratch.select();
        document.execCommand("copy");
        scratch.remove();
    }

    const label = button.textContent;
    button.textContent = "Copied";
    setTimeout(() => {
        button.textContent = label;
    }, 1200);
}

function download() {
    const file = view.files[view.tab];
    if (file === undefined) return;
    const url = URL.createObjectURL(new Blob([file.text], { type: "text/plain;charset=utf-8" }));
    const link = document.createElement("a");
    link.href = url;
    link.download = fileLabel(file);
    document.body.append(link);
    link.click();
    link.remove();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
}

/** Replaces the input; a new sample or file also brings its own top-level name, unless `keepName`. */
function setInput(text, source, kind, autoName, keepName = false) {
    state.text = text;
    state.source = source;
    state.largeInEditor = false;
    state.kind = kind;
    if (!keepName) state.name = "";
    state.autoName = autoName;
    showInput();
    renderControls();
    writeHash();
    saveInput();
}

async function loadSample(sample, keepName = false) {
    try {
        setInput(await fetchSample(sample), { type: "sample", id: sample.id }, sample.kind, sample.name, keepName);
    } catch (e) {
        view.status = "done";
        view.wasm = { ok: false, error: { message: `Could not load the sample ${sample.path}: ${e.message}` } };
        render();
        return;
    }

    void run();
}

async function loadFile(file) {
    const text = await file.text();
    const schema = /\.schema(\.json)?$/i.test(file.name) || /"\$schema"\s*:/.test(text.slice(0, 1000));
    setInput(text, { type: "file", fileName: file.name, size: file.size }, schema ? "schema" : "json", nameFromFile(file.name));
    void run();
}

let infoTimer;

function bind() {
    els.lang.addEventListener("change", () => {
        state.lang = languageNamed(els.lang.value);
        state.options = presetOptions(state.lang);
        renderOptions();
        renderCli();
        writeHash();
        void run();
    });

    els.name.addEventListener("input", () => {
        state.name = els.name.value;
        renderCli();
        writeHash();
        schedule(300);
    });

    els.compare.addEventListener("change", () => {
        state.compare = els.compare.checked;
        writeHash();
        // A measurement was of the other setting.
        view.bench = undefined;
        if (!state.compare) {
            view.ts = undefined;
            render();
            return;
        }

        void engines.ts.start();
        if (view.settled === generation && view.status === "done") {
            // The WebAssembly result is current: only the TypeScript side runs.
            currentRun = compare(generation, view.request);
        } else {
            // A run is under way (it compares when it is done) or nothing is shown.
            render();
        }
    });

    els.options.addEventListener("input", (event) => {
        const control = event.target.closest("[data-option]");
        if (control === null) return;
        const definition = state.lang.options.find((o) => o.name === control.dataset.option);
        const value = definition.type === "boolean" ? control.checked : control.value;
        if (value === definition.defaultValue) delete state.options[definition.name];
        else state.options[definition.name] = value;
        renderCli();
        writeHash();
        schedule(definition.type === "string" ? 300 : 0);
    });

    els.generalOptions.addEventListener("input", (event) => {
        const control = event.target.closest("[data-general]");
        if (control === null) return;
        if (control.checked) state.general[control.dataset.general] = true;
        else delete state.general[control.dataset.general];
        renderGeneralCount();
        renderCli();
        writeHash();
        schedule(0);
    });
    els.general.addEventListener("toggle", () => {
        generalOpen = els.general.open;
    });

    for (const radio of document.querySelectorAll('input[name="kind"]')) {
        radio.addEventListener("change", () => {
            if (!radio.checked) return;
            state.kind = radio.value;
            if (state.source.type === "sample") state.source = { type: "typed" };
            renderControls();
            writeHash();
            saveInput();
            void run();
        });
    }

    els.sample.addEventListener("change", () => {
        const sample = sampleWithId(els.sample.value);
        if (sample !== undefined) void loadSample(sample);
    });

    els.input.addEventListener("input", () => {
        state.text = els.input.value;
        if (state.source.type !== "typed") {
            state.source = { type: "typed" };
            els.sample.value = "";
            renderCli();
            writeHash();
        }

        clearTimeout(infoTimer);
        infoTimer = setTimeout(() => {
            showInputInfo();
            saveInput();
        }, state.text.length > 100_000 ? 500 : 0);
        schedule(typingDelay());
    });

    els.largeEdit.addEventListener("click", () => {
        state.largeInEditor = true;
        showInput();
        els.input.focus();
    });

    els.open.addEventListener("click", () => els.file.click());
    els.file.addEventListener("change", () => {
        const file = els.file.files?.[0];
        if (file !== undefined) void loadFile(file);
        els.file.value = "";
    });

    // Drag and drop onto the input side; anywhere else, do not let the
    // browser navigate to the dropped file.
    let depth = 0;
    const hasFiles = (event) => [...(event.dataTransfer?.types ?? [])].includes("Files");
    window.addEventListener("dragover", (event) => event.preventDefault());
    window.addEventListener("drop", (event) => event.preventDefault());
    els.inputPane.addEventListener("dragenter", (event) => {
        if (!hasFiles(event)) return;
        depth++;
        els.inputPane.classList.add("dragging");
    });
    els.inputPane.addEventListener("dragleave", () => {
        depth = Math.max(0, depth - 1);
        if (depth === 0) els.inputPane.classList.remove("dragging");
    });
    els.inputPane.addEventListener("drop", (event) => {
        event.preventDefault();
        depth = 0;
        els.inputPane.classList.remove("dragging");
        const file = event.dataTransfer?.files?.[0];
        if (file !== undefined) void loadFile(file);
    });

    els.tabs.addEventListener("click", (event) => {
        const tab = event.target.closest("[data-tab]");
        if (tab === null) return;
        view.tab = Number(tab.dataset.tab);
        renderTabs();
        renderCode();
    });
    els.tabs.addEventListener("keydown", (event) => {
        const count = view.files.length;
        const moves = { ArrowRight: view.tab + 1, ArrowLeft: view.tab - 1, Home: 0, End: count - 1 };
        if (!(event.key in moves) || count <= 1) return;
        event.preventDefault();
        view.tab = (moves[event.key] + count) % count;
        renderTabs();
        renderCode();
        els.tabs.querySelector(`[data-tab="${view.tab}"]`)?.focus();
    });

    els.copy.addEventListener("click", () => {
        const file = view.files[view.tab];
        if (file !== undefined) void copyText(file.text, els.copy);
    });
    els.download.addEventListener("click", download);
    els.copyCli.addEventListener("click", () => void copyText(els.cli.textContent, els.copyCli));
    els.meter.addEventListener("click", (event) => {
        if (event.target.closest("#measure")) void measure();
    });

    window.addEventListener("hashchange", () => void applyHash(readHash()));
}

async function applyHash(hash) {
    state.lang = hash.lang;
    state.options = hash.options;
    state.general = hash.general;
    state.name = hash.name;
    state.compare = hash.compare;
    if (state.compare) void engines.ts.start();
    if (hash.sample !== undefined && (state.source.type !== "sample" || state.source.id !== hash.sample.id)) {
        renderControls();
        await loadSample(hash.sample, true);
        return;
    }

    renderControls();
    writeHash();
    void run();
}

async function start() {
    renderLanguages();
    renderSamples();
    bind();
    void engines.wasm.start();
    engines.wasm.onBoot = () => render();
    engines.ts.onBoot = () => render();

    const hash = readHash();
    if (hash.sample === undefined) {
        const saved = loadSavedInput();
        const sample = sampleWithId(defaultSample);
        if (saved !== undefined) {
            state.kind = saved.kind;
            state.text = saved.text;
            state.autoName = typeof saved.autoName === "string" && saved.autoName !== "" ? saved.autoName : "TopLevel";
            const source = saved.source ?? {};
            state.source =
                (source.type === "sample" && sampleWithId(source.id) !== undefined) || source.type === "file"
                    ? source
                    : { type: "typed" };
            showInput();
        } else {
            hash.sample = sample;
        }
    }

    render();
    await applyHash(hash);
}

/** For tests and the curious: what the page shows. */
globalThis.playground = {
    get state() {
        return structuredClone({ ...state, lang: state.lang.names[0] });
    },
    get view() {
        return view;
    },
    get generation() {
        return generation;
    },
    cli: cliCommand,
    engines,
};

void start();
