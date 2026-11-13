// The playground page: input on the left, generated code on the right.
// quicktype-core runs in Web Workers (engine-client.js, worker.js); this
// file only handles the page and its state.
//
// State that can be shared lives in the URL hash, in the form of quicktype's
// README links (`#l=rust`), plus `v` (the hash format, see hash.js), `s` (an
// unmodified sample), `n` (a typed top-level name), `e=quicktype` (the
// engine, when it is not quickertype), the general options that are on
// (`no-enums=true`) and renderer options
// by their CLI names (`#v=2&l=cs&density=dense`). A renderer option is in
// the hash when it differs from the page's default: the language's preset
// (see site/build.mjs), else quicktype's default; so moving a preset back to
// quicktype's default is explicit (`#v=2&l=rust&density=normal`). A link
// without `v` is older than the presets, and is read with quicktype's
// defaults. The input text is kept in localStorage when the browser allows
// it.
//
// A file larger than the editor shows (LARGE) is never read here: the page
// posts the File itself to the workers, which read it (see worker.js), so
// that its text never passes through the main thread.

/* global __LANGUAGES__, __SAMPLES__, __GENERAL__, __SPEED__ */

import { EngineClient, Lane, engineKinds } from "./engine-client.js";
import { hashKeys, hashVersion } from "./hash.js";
import { highlight } from "./highlight.js";
import { escapeHtml } from "./html.js";
import { formatBytes, tooLarge, unreadable } from "./input-file.js";

const languages = __LANGUAGES__;
const samples = __SAMPLES__;
/** quicktype's general options: { name (the CLI flag), label, option (of `quicktype()`), value (when on) }. */
const general = __GENERAL__;
/** From the benchmarks (site/data/benchmarks.json): `upTo`, the largest CLI speed-up. */
const speed = __SPEED__;

const storageKey = "quickertype.input";
/** Inputs longer than this (in characters; files, in bytes) are not put in the editor or saved. */
const LARGE = 1_000_000;
const defaultLanguage = "typescript";
const defaultSample = "pokedex";
const defaultEngine = "wasm";
/** Timed runs per engine when warm runs are measured, after one warm-up run. */
const measureRuns = 5;

/** The engines by the names the page gives them (and the hash, as `e`). */
const engineNames = { wasm: "quickertype", ts: "quicktype" };
const otherEngine = (engine) => (engine === "wasm" ? "ts" : "wasm");
const engineNamed = (name) => Object.keys(engineNames).find((engine) => engineNames[engine] === name);

const $ = (id) => document.getElementById(id);
const els = {
    lang: $("lang"),
    name: $("name"),
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
    largeStatus: $("large-status"),
    largeNote: $("large-note"),
    largeEdit: $("large-edit"),
    inputInfo: $("input-info"),
    tabs: $("tabs"),
    copy: $("copy"),
    download: $("download"),
    meter: $("meter"),
    notes: $("notes"),
    output: $("output"),
    codeWrap: $("code-wrap"),
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
    /** The input's text; "" for a file too large for the editor, until it is shown there. */
    text: "",
    /** The file a large input is (a File), which the workers read; undefined for any other input. */
    file: undefined,
    /** { type: "sample", id } | { type: "file", fileName, size, lastModified } | { type: "typed" } */
    source: { type: "typed" },
    /** The name from the sample or file name; used unless the user typed one. */
    autoName: "TopLevel",
    /** What the top-level name field holds ("" or `autoName` unless the user typed a name). */
    name: "",
    lang: languageNamed(defaultLanguage),
    /** Renderer options that differ from the page's defaults (presets, else quicktype's), by CLI name. */
    options: {},
    /** The general options that are on, by CLI name (all are off by default). */
    general: {},
    /** The engine whose output the page shows: "wasm" (quickertype) or "ts" (quicktype). */
    engine: "wasm",
    /** Show a large input in the editor anyway. */
    largeInEditor: false,
};

const topLevelName = () => state.name.trim() || state.autoName;
const typedName = () => (state.name.trim() !== "" && state.name.trim() !== state.autoName ? state.name.trim() : "");

/** An option's default on this page: the language's preset, else quicktype's default. */
const pageDefault = (definition) => definition.preset ?? definition.defaultValue;

/** An option's value: as set, else the page's default. */
const optionValue = (definition) => state.options[definition.name] ?? pageDefault(definition);

/**
 * The renderer options as quicktype's API and CLI take them: every value
 * that differs from quicktype's default, presets included.
 */
function rendererOptions() {
    const options = {};
    for (const definition of state.lang.options) {
        const value = optionValue(definition);
        if (value !== definition.defaultValue) options[definition.name] = value;
    }

    return options;
}

function parseOption(definition, raw) {
    if (raw === null || raw === undefined) return undefined;
    if (definition.type === "boolean") return raw === "true" ? true : raw === "false" ? false : undefined;
    if (definition.type === "enum") return definition.values.includes(raw) ? raw : undefined;
    return raw;
}

function readHash() {
    const params = new URLSearchParams(location.hash.slice(1));
    // A link from before the presets: what it leaves out is quicktype's default.
    const old = [...params.keys()].length > 0 && !params.has(hashKeys.version);
    const lang = languageNamed(params.get(hashKeys.language)) ?? languageNamed(defaultLanguage);
    const options = {};
    for (const definition of lang.options) {
        const value =
            parseOption(definition, params.get(definition.name)) ?? (old ? definition.defaultValue : pageDefault(definition));
        if (value !== pageDefault(definition)) options[definition.name] = value;
    }

    const on = {};
    for (const g of general) if (params.get(g.name) === "true") on[g.name] = true;
    return {
        lang,
        options,
        general: on,
        name: params.get(hashKeys.name) ?? "",
        sample: sampleWithId(params.get(hashKeys.sample)),
        engine: engineNamed(params.get(hashKeys.engine)) ?? defaultEngine,
        // From a link older than `e`: compare mode, which ran both engines.
        compare: params.get(hashKeys.compare) === "1",
    };
}

function writeHash() {
    const params = new URLSearchParams();
    params.set(hashKeys.version, hashVersion);
    params.set(hashKeys.language, state.lang.names[0]);
    if (state.source.type === "sample") params.set(hashKeys.sample, state.source.id);
    if (typedName() !== "") params.set(hashKeys.name, typedName());
    if (state.engine !== defaultEngine) params.set(hashKeys.engine, engineNames[state.engine]);
    for (const g of general) if (state.general[g.name]) params.set(g.name, "true");
    for (const definition of state.lang.options) {
        if (definition.name in state.options) params.set(definition.name, String(state.options[definition.name]));
    }
    const hash = `#${params}`;
    if (location.hash !== hash) history.replaceState(null, "", hash);
}

function saveInput() {
    try {
        if (state.file !== undefined || state.text.length > LARGE) {
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

/** Whether "More options" is open; it is re-rendered with the language's options. */
let moreOpen = false;

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
    const value = optionValue(definition);
    const flag = `--${definition.name}`;
    const label = escapeHtml(definition.description) + presetMark(definition);
    const hint = definition.hint === undefined ? "" : `<small class="hint">${escapeHtml(definition.hint)}</small>`;
    if (definition.type === "boolean") {
        return `<label class="check${hint ? " hinted" : ""}" title="${flag}"><input type="checkbox" id="${id}" data-option="${definition.name}"${value ? " checked" : ""}><span>${label}${hint}</span></label>`;
    }

    if (definition.type === "enum") {
        const choices = definition.values
            .map((v) => `<option${v === value ? " selected" : ""}>${escapeHtml(v)}</option>`)
            .join("");
        return `<label class="field${hint ? " hinted" : ""}" title="${flag}"><span class="field-label">${label}</span><select id="${id}" data-option="${definition.name}">${choices}</select>${hint}</label>`;
    }

    return `<label class="field${hint ? " hinted" : ""}" title="${flag}"><span class="field-label">${label}</span><input type="text" id="${id}" data-option="${definition.name}" value="${escapeHtml(value)}" placeholder="${escapeHtml(definition.typeLabel ?? "")}" spellcheck="false" autocomplete="off">${hint}</label>`;
}

/** How many general options there are, or how many are on. */
function renderGeneralCount() {
    const on = general.filter((g) => state.general[g.name]).length;
    els.generalCount.textContent = on > 0 ? `${on} on` : String(general.length);
    els.generalCount.classList.toggle("on", on > 0);
}

/** The General section's options (it is opened or closed by the user, or by a link; see applyHash). */
function renderGeneral() {
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
    for (const radio of document.querySelectorAll('input[name="engine"]')) radio.checked = radio.value === state.engine;
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

/** The arguments of the quicktype CLI command that gives the same output, quoted for a shell. */
function cliArgs() {
    const args = ["quicktype"];
    if (state.kind === "schema") args.push("--src-lang", "schema");
    args.push("--lang", state.lang.names[0], "--top-level", topLevelName());
    for (const g of general) if (state.general[g.name]) args.push(`--${g.name}`);
    const options = rendererOptions();
    for (const definition of state.lang.options) {
        if (!(definition.name in options)) continue;
        const value = options[definition.name];
        if (definition.type === "boolean") args.push(value ? `--${definition.name}` : `--no-${definition.name}`);
        else args.push(`--${definition.name}`, value);
    }

    args.push(inputFileName());
    return args.map(shellQuote);
}

/** The quicktype CLI command that gives the same output. */
const cliCommand = () => cliArgs().join(" ");

/** The command, an argument per span: it wraps between arguments, never inside a flag (its text is the command). */
function renderCli() {
    els.cli.innerHTML = cliArgs()
        .map((arg) => `<span class="arg">${escapeHtml(arg)}</span>`)
        .join(" ");
}

function showInput() {
    const large = (state.file !== undefined || state.text.length > LARGE) && !state.largeInEditor;
    els.input.hidden = large;
    els.large.hidden = !large;
    if (large) {
        els.largeName.textContent = inputFileName();
        els.largeSize.textContent = formatBytes(state.source.size ?? utf8Length(state.text));
    } else if (els.input.value !== state.text) {
        els.input.value = state.text;
    }

    showInputInfo();
    renderInputStatus();
}

/**
 * What happens to a large input, under its name (the editor does not show
 * it): reading it, running it (with the time so far), how long its run took,
 * or that it failed; nothing while another input that could not be loaded
 * is what the output pane shows.
 */
function renderInputStatus() {
    if (els.large.hidden) return;
    const { status, shown } = view;
    const name = engineNames[state.engine];
    let text = "";
    if (view.reading !== undefined) text = "Reading…";
    else if (status === "running") text = `Running on ${name}… ${formatMs(performance.now() - view.runningSince)}`;
    // Not after another input failed to load (no request): the output is about that one.
    else if (shown.gen === generation && shown.result !== undefined && view.request !== undefined) {
        const result = shown.result;
        if (!result.ok) text = result.ms === undefined ? "Not run: see the output." : `${engineNames[shown.engine]} stopped with an error: see the output.`;
        else text = `${engineNames[shown.engine]} ran it in ${formatMs(result.ms)}.`;
    }

    if (els.largeStatus.textContent !== text) els.largeStatus.textContent = text;
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
//
// Each change to the input or options is a new request, run `generation`,
// run on the engine picked. Switching engine is not a new request: the
// engine picked runs the current one only if it has not yet, so switching
// back and forth leaves both results, which the page then compares.

// One request at a time across both workers: no time is taken while the other engine runs.
const workerLane = new Lane();
const engines = { wasm: new EngineClient("wasm", workerLane), ts: new EngineClient("ts", workerLane) };

/** What the output pane shows. */
const view = {
    status: "idle", // "idle" | "empty" | "running" | "done"
    /** The current request: the input and options of run `generation`. */
    request: undefined,
    /**
     * Each engine's latest run, { gen, result }, the result "running" while
     * it runs. One for the current request is that engine's result for it.
     * A worker failure is not kept: the next switch or run tries again.
     */
    results: { wasm: undefined, ts: undefined },
    /** What the output pane shows: `engine`'s result for the request of run `gen`, which had `lang` and `name`. */
    shown: { gen: 0, engine: defaultEngine, result: undefined, lang: undefined, name: "" },
    /**
     * A warm measurement of both engines on the request of run `gen`:
     * { gen, wasm, ts, failure }, each side a result, "running" or
     * undefined; `failure` says why it stopped, if a worker failed.
     */
    bench: undefined,
    /** A file being opened, { fileName, size }, until it is the input (or failed). */
    reading: undefined,
    files: [],
    tab: 0,
    runningSince: 0,
    /** The run whose result on the engine picked is shown; 0 while there is none. */
    get settled() {
        return view.shown.engine === state.engine ? view.shown.gen : 0;
    },
};

let generation = 0;
/** Counts the inputs given: a file whose reading finishes after another input was given is not the input. */
let opening = 0;
let runTimer;
let ticker;
/** The runs under way; a measurement waits for them, so that it measures what they show. */
const underway = new Set();

function track(promise) {
    underway.add(promise);
    void promise.then(() => underway.delete(promise));
    return promise;
}

/** `engine`'s result for the request of run `gen`: the result, "running", or undefined if it has not run it. */
function resultOf(engine, gen) {
    const latest = view.results[engine];
    return latest !== undefined && latest.gen === gen ? latest.result : undefined;
}

/** The `quicktype()` options the general options that are on set, as quicktype's CLI sets them. */
function runOptions() {
    const options = {};
    for (const g of general) if (state.general[g.name]) options[g.option] = g.value;
    return options;
}

/** The input and options as a worker takes them: a large file as the File, which the worker reads. */
function request() {
    return {
        kind: state.kind,
        lang: state.lang.names[0],
        name: topLevelName(),
        ...(state.file !== undefined ? { file: state.file } : { text: state.text }),
        rendererOptions: rendererOptions(),
        options: runOptions(),
    };
}

function schedule(delay) {
    clearTimeout(runTimer);
    runTimer = setTimeout(run, delay);
}

/** Debounce for typing: longer for longer inputs. */
const typingDelay = () => Math.min(1000, 200 + state.text.length / 5000);

/**
 * Runs the input as it is now, a new request, on the engine picked; with
 * `compare` (a link from compare mode), then on the other engine too (the
 * lane runs them one after the other). A newer run replaces it.
 */
function run({ compare = false } = {}) {
    clearTimeout(runTimer);
    const gen = ++generation;
    const req = request();
    view.request = req;
    view.bench = undefined;
    // Whatever still waits for a worker is for an older request.
    engines.wasm.drop();
    engines.ts.drop();
    if (req.file === undefined ? !/\S/.test(req.text) : req.file.size === 0) {
        setRunning(false);
        view.status = "empty";
        view.shown = { gen, engine: state.engine, result: undefined, lang: languageNamed(req.lang), name: req.name };
        render();
        return Promise.resolve();
    }

    setRunning(true);
    const first = runOn(state.engine);
    if (compare) void runOn(otherEngine(state.engine));
    return first;
}

/**
 * Runs the current request on `engine`, unless it has run it or is running
 * it; after whatever runs on the other engine, never beside it (the lane).
 * The result is shown if `engine` is the one picked, and kept for the
 * comparison either way, unless the worker failed.
 */
function runOn(engine) {
    const gen = generation;
    if (resultOf(engine, gen) !== undefined) return Promise.resolve();
    view.results[engine] = { gen, result: "running" };
    // Not the engine picked: its bar shows it running, next to the result shown.
    if (engine !== state.engine) render();
    return track(
        engines[engine].run(view.request).then((result) => {
            // A newer request is the current one, and runs by itself.
            if (gen !== generation) return;
            if (result === undefined) {
                // Dropped, which only a newer request does; but never leave
                // the page saying "Running" for good: run again.
                view.results[engine] = undefined;
                if (engine === state.engine) schedule(0);
                return;
            }

            // A worker that failed is not this engine's result for the request:
            // shown, but not kept, so that the next switch or run tries again.
            view.results[engine] = result.workerFailure ? undefined : { gen, result };
            if (engine === state.engine) show(engine, gen, result);
            render();
        }),
    );
}

/** Shows `engine`'s result for the current request (that of run `gen`). */
function show(engine, gen, result) {
    view.shown = { gen, engine, result, lang: languageNamed(view.request.lang), name: view.request.name };
    view.status = "done";
    if (result.ok) showFiles(result.files);
    setRunning(false);
}

/**
 * Picks the engine whose output the page shows. The input and options stay
 * as they are; the engine runs them only if it has not yet.
 */
function setEngine(engine) {
    if (engine === state.engine) return;
    state.engine = engine;
    writeHash();
    if (view.request === undefined || view.status === "empty") {
        // No input to run (none yet, or a sample that did not load): the next run is on this engine.
        view.shown = { ...view.shown, engine };
        render();
        return;
    }

    const result = resultOf(engine, generation);
    if (result === undefined) {
        setRunning(true);
        void runOn(engine);
    } else if (result === "running") {
        // Under way already; shown when it is done.
        setRunning(true);
    } else {
        show(engine, generation, result);
    }

    render();
}

/**
 * Measures warm runs of both engines on what the page shows: after the runs
 * under way, if any, so that the numbers belong to the result on screen. A
 * newer run cancels the measurement (it replaces `view.bench`).
 */
async function measure() {
    const bench = { gen: generation, wasm: undefined, ts: undefined };
    view.bench = bench;
    render();
    while (underway.size > 0) await Promise.all(underway);

    const current = () => view.bench === bench;
    const giveUp = () => {
        if (current()) {
            view.bench = undefined;
            render();
        }
    };
    if (!current()) return;
    if (view.status !== "done" || view.settled !== bench.gen || !view.shown.result?.ok) return giveUp();

    const req = view.request;
    const repeat = { warmup: 1, repeat: measureRuns };
    for (const engine of ["wasm", "ts"]) {
        bench[engine] = "running";
        render();
        const result = await engines[engine].run({ ...req, ...repeat });
        if (!current()) return;
        if (result === undefined) return giveUp();
        if (result.workerFailure || !timed(result)) {
            // Said under the result shown, which stays; measuring again starts a new worker
            // (or, for an input that could not be read, tries to read it again).
            bench[engine] = undefined;
            bench.failure = result.error.message;
            render();
            return;
        }

        bench[engine] = result;
        // It is the engine's result for this request too: switching to it needs no run.
        if (resultOf(engine, bench.gen) === undefined) view.results[engine] = { gen: bench.gen, result: { ...result, first: false } };
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
            renderInputStatus();
            renderStale();
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
    const files = view.status !== "empty" && view.shown.result?.ok ? view.files : [];
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
    const result = view.shown.result;
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
        const { title, message, link } = result.error;
        const name = result.error.messageName ?? result.error.name;
        const help = link === undefined ? "" : `<p class="error-help">Get <a href="${escapeHtml(link.href)}">${escapeHtml(link.text)}</a>.</p>`;
        els.error.innerHTML = `<p class="error-title">${escapeHtml(title ?? "quicktype stopped with an error")}</p><pre class="error-message">${escapeHtml(message)}</pre>${help}${name ? `<p class="error-kind">${escapeHtml(name)}</p>` : ""}`;
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

/** Whether quickertype's result `a` and quicktype's `b` are the same: the same files, byte for byte, or the same error. */
function verdict(a, b) {
    if (a.ok && b.ok) {
        const count = a.files.length;
        if (count !== b.files.length || a.files.some((f, i) => f.name !== b.files[i].name)) {
            return { same: false, text: "different files" };
        }

        for (let i = 0; i < count; i++) {
            if (a.files[i].text === b.files[i].text) continue;
            const left = a.files[i].text.split("\n");
            const right = b.files[i].text.split("\n");
            let line = 0;
            while (line < left.length && left[line] === right[line]) line++;
            const where = count > 1 ? ` in ${a.files[i].name}` : "";
            return { same: false, text: `outputs differ${where} from line ${line + 1}` };
        }

        const bytes = a.files.reduce((n, f) => n + utf8Length(f.text), 0);
        const detail = `The outputs are identical byte for byte: ${count} file${count === 1 ? "" : "s"}, ${bytes.toLocaleString("en-US")} bytes.`;
        return { same: true, text: "identical output", detail };
    }

    if (!a.ok && !b.ok) {
        return a.error.message === b.error.message
            ? { same: true, text: "the same error" }
            : { same: false, text: "different errors" };
    }

    return { same: false, text: `only ${engineNames[a.ok ? "ts" : "wasm"]} stopped with an error` };
}

/**
 * Which engine was faster, the faster one named as the subject: "quicktype
 * was 1.1× faster (152 ms vs 172 ms)", the subject's time first; within 5%,
 * "quickertype and quicktype were about as fast (172 ms and 168 ms)".
 * `ms` is each engine's time, { wasm, ts }; `qualifier` goes inside the
 * parentheses ("start-up included"). As HTML, and `key`, which is the same
 * for the same verdict (who, and how many times faster).
 */
function pace(ms, qualifier) {
    const ratio = ms.ts / ms.wasm;
    if (!Number.isFinite(ratio) || ratio <= 0) return undefined;
    const name = (engine) => `<b class="engine-name ${engine}">${engineNames[engine]}</b>`;
    const extra = qualifier === undefined ? "" : `, ${escapeHtml(qualifier)}`;
    if (ratio < 1.05 && ratio > 1 / 1.05) {
        return { key: "same", html: `${name("wasm")} and ${name("ts")} were about as fast (${formatMs(ms.wasm)} and ${formatMs(ms.ts)}${extra})` };
    }

    const faster = ratio >= 1.05 ? "wasm" : "ts";
    const r = faster === "wasm" ? ratio : 1 / ratio;
    const times = r >= 10 ? String(Math.round(r)) : r.toFixed(1);
    return {
        key: `${faster} ${times}`,
        html: `${name(faster)} was ${times}× faster (${formatMs(ms[faster])} vs ${formatMs(ms[otherEngine(faster)])}${extra})`,
    };
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
        return `ran on the ${engineKinds[result.ran]} engine${result.reason ? `: ${result.reason}` : ""}`;
    }

    return undefined;
}

/** One engine's bar: its time (`timeOf`) against `scale`, the part spent reading the input lighter. */
function lane(engine, result, { scale, timeOf, note, split, shown }) {
    const name = engineNames[engine];
    const head = `<div class="lane ${engine}${shown ? " shown" : ""}"><span class="engine">${name}</span>`;
    if (result === "running") {
        const what = engines[engine].boot === undefined ? "loading…" : "running…";
        return `${head}<span class="bar"><span class="fill pending"></span></span><span class="time muted">${what}</span></div>`;
    }

    const ms = timeOf(result);
    const width = scale > 0 ? Math.max(1.5, (ms / scale) * 100) : 0;
    const tag = engineTag(engine, result);
    const inputShare = split !== undefined && split.input !== undefined && ms > 0 ? Math.min(1, split.input / ms) : 0;
    const detail =
        split !== undefined && split.input !== undefined
            ? `reading the input ${formatMs(split.input)}, generating ${formatMs(split.generate)}`
            : undefined;
    const notes = [detail, note].filter(Boolean).join("; ");
    return `${head}<span class="bar"><span class="fill" style="width:${width.toFixed(2)}%"><span class="input-part" style="width:${(inputShare * 100).toFixed(2)}%"></span></span></span><span class="time">${formatMs(ms)}</span>${
        notes ? `<span class="lane-note">${escapeHtml(notes)}</span>` : ""
    }${tag ? `<span class="lane-note warn">${escapeHtml(tag)}</span>` : ""}</div>`;
}

/**
 * "quickertype was 1.4× faster (3.00 ms vs 4.20 ms) · identical output ✓",
 * from both engines' results ("Warm medians: …" once measured; first runs
 * are said to include start-up). If either stopped with an error, both
 * times: "quickertype: 2.90 ms · quicktype: 4.20 ms · different errors ≠".
 */
function summary({ wasm, ts }, timeOf, phases, measured) {
    const v = verdict(wasm, ts);
    const cold = measured ? [] : ["wasm", "ts"].filter((engine) => ({ wasm, ts })[engine].first);
    const startUp =
        cold.length === 2 ? "start-up included" : cold.length === 1 ? `${engineNames[cold[0]]}'s start-up included` : undefined;
    const faster = wasm.ok && ts.ok ? pace({ wasm: phases(wasm).total, ts: phases(ts).total }, startUp) : undefined;
    const parts =
        faster !== undefined
            ? [`<span class="pace">${faster.html}</span>`]
            : [
                  `<span class="who wasm">${engineNames.wasm}: <b>${formatMs(timeOf(wasm))}</b></span>`,
                  `<span class="who ts">${engineNames.ts}: <b>${formatMs(timeOf(ts))}</b></span>`,
              ];
    parts.push(
        `<span class="verdict ${v.same ? "same" : "differ"}">${escapeHtml(v.text)} <span class="verdict-mark" aria-hidden="true">${v.same ? "✓" : "≠"}</span></span>`,
    );
    const prefix = measured ? `<span class="muted">Warm medians:</span> ` : "";
    return {
        same: v.same,
        detail: v.detail,
        faster,
        html: `<p class="summary" role="status">${prefix}${parts.join('<span class="sep"> · </span>')}</p>`,
    };
}

/** What starting the engines cost, for those in `lanes`. */
function bootNote(lanes) {
    const parts = [];
    const wasm = engines.wasm.boot;
    if (lanes.includes("wasm") && wasm !== undefined) {
        if (wasm.loadError) parts.push(`The WebAssembly engine did not load (${wasm.loadError}); quickertype ran on the TypeScript engine.`);
        else if (wasm.compileMs !== undefined) parts.push(`quickertype's engine (.wasm) downloaded and compiled in ${formatMs(wasm.compileMs)}.`);
    }

    if (lanes.includes("ts") && engines.ts.boot !== undefined) {
        parts.push(`The quicktype worker loaded in ${formatMs(engines.ts.boot.startMs)}.`);
    }

    return parts.join(" ");
}

const isResult = (r) => typeof r === "object";
/** A result with a time: the run happened (a worker that did not start has none). */
const timed = (r) => isResult(r) && r.times.length > 0;

function renderMeter() {
    const { status, shown, bench } = view;
    const result = shown.result;
    const body = document.body.dataset;
    if (status === "empty") {
        els.meter.innerHTML = "";
        body.status = "empty";
        body.compare = "off";
        return;
    }

    if (view.reading !== undefined) {
        const { fileName, size } = view.reading;
        els.meter.innerHTML = `<div class="lane-line"><span class="engine-dot ${state.engine}"></span>Reading ${escapeHtml(fileName)} <span class="time muted">${formatBytes(size)}</span></div>`;
        body.status = "running";
        body.compare = "off";
        return;
    }

    // Nothing to show yet, or what is shown is for an older request.
    if (result === undefined || (status === "running" && shown.gen !== generation)) {
        const engine = state.engine;
        const name = engineNames[engine];
        const line =
            status === "running"
                ? `${engines[engine].boot === undefined ? `Loading ${name}…` : `Running on ${name}…`} <span class="time muted">${formatMs(performance.now() - view.runningSince)}</span>`
                : `<span class="muted">Loading ${name}…</span>`;
        els.meter.innerHTML = `<div class="lane-line"><span class="engine-dot ${engine}"></span>${line}</div>`;
        body.status = status === "running" ? "running" : "idle";
        body.compare = "off";
        return;
    }

    body.status = status === "running" ? "running" : result.ok ? "done" : "error";
    if (result.ms === undefined) {
        // Nothing ran (a sample that did not load, a worker that did not start).
        els.meter.innerHTML = "";
        body.compare = "off";
        return;
    }

    // Each engine's side: its result for the request shown (warm medians
    // once measured), "running", or undefined if it has not run it.
    const gen = shown.gen;
    const measured = bench !== undefined && bench.gen === gen && timed(bench.wasm) && timed(bench.ts);
    const sides = {};
    for (const engine of ["wasm", "ts"]) {
        const side = measured ? bench[engine] : engine === shown.engine ? result : resultOf(engine, gen);
        sides[engine] = isResult(side) && !timed(side) ? undefined : side;
    }

    const lanes = ["wasm", "ts"].filter((engine) => sides[engine] !== undefined);
    const solo = lanes.length === 1;
    const timeOf = measured ? (r) => median(r.times) : (r) => r.ms;
    const phases = (r) => phasesOf(r, measured);
    const scale = Math.max(0, ...lanes.filter((engine) => isResult(sides[engine])).map((engine) => timeOf(sides[engine])));
    let html = `<div class="race${solo ? " solo" : ""}">`;
    for (const engine of lanes) {
        const side = sides[engine];
        const done = isResult(side);
        html += lane(engine, side, {
            scale: solo ? timeOf(side) : scale,
            timeOf,
            note: !done ? undefined : measured ? `median of ${side.times.length} warm runs` : side.first ? "first run, includes start-up" : undefined,
            split: done && side.ok ? phases(side) : undefined,
            shown: engine === shown.engine,
        });
    }

    html += "</div>";

    /** The fine print, as HTML. */
    const fine = [];
    const say = (text) => fine.push(escapeHtml(text));
    let compare = "off";
    if (isResult(sides.wasm) && isResult(sides.ts)) {
        const line = summary(sides, timeOf, phases, measured);
        compare = line.same ? "identical" : "different";
        html += line.html;
        html += `<p class="cli-note">In the browser both engines run inside this page, so the gap is smaller; on the command line quickertype is up to ${speed.upTo}× faster. <a href="./benchmarks.html#browser">Why</a></p>`;
        if (line.detail !== undefined) say(line.detail);
        say("The lighter part of each bar is reading the input; the rest is generating the code.");
        if (sides.wasm.ok && sides.ts.ok) {
            const generating = pace({ wasm: phases(sides.wasm).generate, ts: phases(sides.ts).generate });
            if (generating !== undefined && generating.key !== line.faster?.key) {
                fine.push(`At generating the code alone, ${generating.html}.`);
            }
        }
    } else if (!solo) {
        compare = "running";
    } else {
        say(`Switch to ${engineNames[otherEngine(shown.engine)]} to compare the engines on this input, or measure warm runs of both.`);
    }

    body.compare = compare;
    // Said when the times are compared (one engine's first run is marked as such on its bar).
    if (!solo && !measured && lanes.some((engine) => isResult(sides[engine]) && sides[engine].first)) {
        say(
            "A worker's first run includes start-up: instantiating the WebAssembly engine, or compiling cold JavaScript. Measure warm runs to compare speed.",
        );
    }

    if (measured) {
        say(`Each engine ran once to warm up, then ${bench.wasm.times.length} timed runs on this input, one engine at a time, never both together.`);
    }
    const boot = bootNote(lanes);
    if (boot) say(boot);

    if (bench?.failure !== undefined) {
        html += `<p class="bench-failure" role="alert">Measuring warm runs stopped: ${escapeHtml(bench.failure)}</p>`;
    }

    const measuring = bench !== undefined && bench.failure === undefined && !(isResult(bench.wasm) && isResult(bench.ts));
    const label = !measuring
        ? `Measure warm runs (${measureRuns}×)`
        : bench.wasm === "running"
          ? `Measuring ${engineNames.wasm}…`
          : bench.ts === "running"
            ? `Measuring ${engineNames.ts}…`
            : "Measuring…";
    // aria-disabled rather than disabled, so that the button keeps the keyboard focus while it measures.
    const off = measuring || !result.ok;
    const focused = document.activeElement?.id === "measure";
    // The measurement: one warm-up run, then `measureRuns` timed runs, on
    // quickertype and then on quicktype (measure(): one request per engine,
    // in turn; the workers share one lane, so no two requests ever overlap).
    html += `<div class="fine"><p>${fine.join(" ")}</p><div class="measure-box"><button type="button" id="measure" class="measure" aria-describedby="measure-how"${
        off ? ' aria-disabled="true"' : ""
    }>${label}</button><small id="measure-how">1 warm-up, then ${measureRuns} timed runs per engine; one engine at a time, never both together</small></div></div>`;
    els.meter.innerHTML = html;
    if (focused) document.getElementById("measure").focus();
}

/** While a newer request runs, the output shown is an older one's: dimmed, as stale. */
function renderStale() {
    const stale = view.reading !== undefined || (view.status === "running" && view.shown.gen !== generation);
    els.codeWrap.classList.toggle("stale", stale);
}

function render() {
    renderMeter();
    renderTabs();
    renderCode();
    renderStale();
    renderInputStatus();
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

/**
 * Replaces the input (`file`: the File a large input is, which the workers
 * read); a new sample or file also brings its own top-level name, unless
 * `keepName`. A file still being opened is not the input any more.
 */
function setInput(text, source, kind, autoName, keepName = false, file = undefined) {
    opening++;
    view.reading = undefined;
    state.text = text;
    state.file = file;
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

/**
 * An input that could not be loaded (a sample, a file): `error` ({ title,
 * message, link? }) is shown in the output pane. The input before stays
 * the input: the input pane shows it, and it stays saved. There is no
 * current request then: what runs or waits is dropped, and switching
 * engine runs nothing until the next change (of the input or the options)
 * runs one.
 */
function inputFailed(error) {
    clearTimeout(runTimer);
    opening++;
    const gen = ++generation;
    view.request = undefined;
    view.bench = undefined;
    view.reading = undefined;
    engines.wasm.drop();
    engines.ts.drop();
    setRunning(false);
    view.status = "done";
    view.shown = { gen, engine: state.engine, result: { ok: false, error, times: [] }, lang: state.lang, name: topLevelName() };
    showInput();
    render();
}

/** Loads a sample and runs it (`compare`: on both engines, for a link from compare mode). */
async function loadSample(sample, keepName = false, compare = false) {
    try {
        setInput(await fetchSample(sample), { type: "sample", id: sample.id }, sample.kind, sample.name, keepName);
    } catch (e) {
        inputFailed({ title: "Could not load the sample", message: `Could not load the sample ${sample.path}: ${e.message}` });
        return;
    }

    void run({ compare });
}

/**
 * Opens a file (from the file picker or a drop) and runs it. A file small
 * enough for the editor is read here; a larger one is posted to the workers
 * as it is, after a look at its first kilobyte (a JSON Schema?). A file too
 * large to read as text, or one that cannot be read, is an error in the
 * output pane (see inputFailed): the input before stays the input, in the
 * editor and saved.
 */
async function loadFile(file) {
    const { name, size, lastModified } = file;
    const source = { type: "file", fileName: name, size, lastModified };
    const schemaName = /\.schema(\.json)?$/i.test(name);
    const large = tooLarge(name, size);
    if (large !== undefined) return inputFailed(large);

    const ticket = ++opening;
    view.reading = { fileName: name, size };
    render();
    let text;
    let head;
    try {
        if (size > LARGE) head = await file.slice(0, 1000).text();
        else text = await file.text();
    } catch (e) {
        if (ticket === opening) inputFailed(unreadable(name, e));
        return;
    }

    // Another input came first.
    if (ticket !== opening) return;
    if (text === "" && size > 0) return inputFailed(unreadable(name, new Error("the browser returned no text")));
    const schema = schemaName || /"\$schema"\s*:/.test((head ?? text).slice(0, 1000));
    setInput(text ?? "", source, schema ? "schema" : "json", nameFromFile(name), false, text === undefined ? file : undefined);
    void run();
}

/** Puts a large input in the editor, as asked: a file is read here then. */
async function showLargeInEditor() {
    if (state.file !== undefined && state.text === "") {
        const ticket = opening;
        const file = state.file;
        try {
            const text = await file.text();
            if (ticket !== opening || state.file !== file) return;
            state.text = text;
        } catch (e) {
            if (ticket === opening) inputFailed(unreadable(file.name, e));
            return;
        }
    }

    state.largeInEditor = true;
    showInput();
    els.input.focus();
}

let infoTimer;

function bind() {
    els.lang.addEventListener("change", () => {
        state.lang = languageNamed(els.lang.value);
        state.options = {};
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

    // Native radio buttons: the arrow keys move between them, and pick.
    for (const radio of document.querySelectorAll('input[name="engine"]')) {
        radio.addEventListener("change", () => {
            if (radio.checked) setEngine(radio.value);
        });
    }

    els.options.addEventListener("input", (event) => {
        const control = event.target.closest("[data-option]");
        if (control === null) return;
        const definition = state.lang.options.find((o) => o.name === control.dataset.option);
        const value = definition.type === "boolean" ? control.checked : control.value;
        if (value === pageDefault(definition)) delete state.options[definition.name];
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
        // Typed text is the input now, not a file being opened, nor the file shown.
        opening++;
        view.reading = undefined;
        state.text = els.input.value;
        state.file = undefined;
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

    els.largeEdit.addEventListener("click", () => void showLargeInEditor());

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
        const button = event.target.closest("#measure");
        if (button !== null && button.getAttribute("aria-disabled") !== "true") void measure();
    });

    window.addEventListener("hashchange", () => void applyHash(readHash()));
}

async function applyHash(hash) {
    state.lang = hash.lang;
    state.options = hash.options;
    state.general = hash.general;
    // A link opens the sections that hold what it sets; otherwise they stay as the user left them.
    if (hash.lang.options.some((o) => o.kind !== "primary" && o.name in hash.options)) moreOpen = true;
    if (general.some((g) => hash.general[g.name])) els.general.open = true;
    state.name = hash.name;
    state.engine = hash.engine;
    if (hash.sample !== undefined && (state.source.type !== "sample" || state.source.id !== hash.sample.id)) {
        renderControls();
        await loadSample(hash.sample, true, hash.compare);
        return;
    }

    renderControls();
    writeHash();
    void run({ compare: hash.compare });
}

async function start() {
    renderLanguages();
    renderSamples();
    bind();
    engines.wasm.onBoot = () => render();
    engines.ts.onBoot = () => render();

    const hash = readHash();
    // Only the engine picked loads now; quicktype alone never downloads the .wasm.
    state.engine = hash.engine;
    void engines[state.engine].start();
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
    get engine() {
        return state.engine;
    },
    cli: cliCommand,
    engines,
};

void start();
