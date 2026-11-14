// Smoke test for the playground: site/dist served under /quickertype/ (as on
// GitHub Pages), loaded in headless Chrome driven over the DevTools protocol
// (as npm/quicktype-core/test/browser/smoke.mjs does).
//
//   node site/test/smoke.mjs [--screenshots <dir>]     (after `node site/build.mjs`)
//
// Checks that the page loads with every language and runs on the
// WebAssembly engine; that its default view (pokedex.json → TypeScript,
// quicktype's defaults: types plus converters), pokedex.json → Rust, and a
// JSON Schema sample give the same bytes as the quicktype CLI with the
// arguments the page shows under the output ("Same as quicktype …"), as do
// `just-types` turned on, the presets the page shares with app.quicktype.io
// (Rust, Swift, Objective-C) and one moved back to quicktype's default,
// quicktype's general options one by one and combined, `--no-ignore-json-refs`
// on an uploaded file with `$ref`s, Rust's `--integer-type force-i32` on one
// with integers beyond 32 bits, renderer options given in the URL hash,
// a run on the same input read the same way reusing the input both
// engines read before (and a language, option or text that changes the
// reading reading it again),
// and an uploaded file too large for the editor; that the URL hash brings all
// of those back, while a link from before the presets (no `v`) gets
// quicktype's defaults; that the just-types hints are there, and not where
// the option does nothing; that the general options are labelled as in the
// CLI's --help, and that a section the user closed stays closed; that the
// command is shown whole, wrapped, and copied as one line; that the footer
// links the quicktype commit in tests/golden/REFERENCE; that the engine
// switch (a radio group: quicktype, quickertype) is quickertype unless the
// hash says `e=quicktype`, old links included, gives the CLI's output on
// quicktype's TypeScript engine too, never downloads the .wasm when only
// quicktype runs, runs an engine only for an input it has not run, works
// with the arrow keys, and, once both engines have run the input, reports
// identical output with both times, warm medians when measured (a link from
// the old compare mode, `c=1`, runs both); that the two workers never run
// at the same time (on every page, from the page's log of requests),
// including a switch during a run and during a measurement; that a worker
// failure is shown but not kept, so a switch back tries again, and stops a
// measurement with a message; that after a sample fails to load, switching
// engine runs nothing; that no input says where to put one (on phones, a
// switch away, which its "Input" makes); that invalid JSON shows
// quicktype's error; that the input survives a reload (localStorage); and
// that 360 px and 390 px widths do not scroll sideways.
//
// The layout: at 1440×900 the generated code has at least 55% of the
// window's height, the masthead and the footer one line each (the footer
// with the samples' license), the options
// open beside the output and the comparison one line (its details closed).
// The options open and close from the keyboard (Enter, Escape, their close
// button): opened, the focus moves to their first control; closed, back to
// the Options button; the viewer's choice is kept for the next visit. In a
// narrower window they are a modal drawer (the page behind inert, closed by
// Escape or a click on its backdrop, not by a drag from or to it); closed by
// the browser itself, the choice is kept too, while the window's width
// moving them saves nothing. Their column is there from the first paint,
// before main.js runs (the script in the head decides it: nothing moves when
// main.js opens them), and the page runs under a Content-Security-Policy
// that allows that script by its hash. The comparison's details open with Enter, and stay
// open, with the focus, as the comparison is drawn again; the page's one
// live region, outside all that is drawn again, says each finished result
// once, in a few words (a run, the comparison, warm runs); the notes behind
// an "i" open with Enter and close with Escape. Phones show one pane at a
// time, the output first, its code in the first screen, the input a tap
// away, and nothing scrolls sideways with the details, the options or the
// input shown; a file too large for the editor keeps one pane at a time
// there, as wide as the page. And three things that once went wrong: the code
// shown after a slow run during which the engine was switched; a
// measurement asked for while a run is under way; and a worker failing
// after it loaded.
//
// Files are opened as a user opens them too: a click on "Open file", the
// browser's file chooser, a file picked: JSON, the same file twice, JSON
// Schema, an extension outside the chooser's filter, and a 26 MB file,
// which the page posts to the workers unread (no main-thread task over
// 200 ms, by a PerformanceObserver for long tasks). A file larger than a
// browser's longest string (its size faked), one that cannot be read, and a
// dropped one each show why in the output pane and leave nothing running;
// the input before stays the input, in the input pane, the command and
// what is saved (typed text survives a 3 GB file dropped on it, the next
// change runs it, and a reload brings it back). One deleted before a
// worker read it says so for that engine.
// A worker keeps a large file's text only while requests carry that file: it
// lets it go once a sample is loaded. "Show in the editor" reads a large file
// once, however often it is clicked ("Reading…" until then), and is not
// offered for an input over 50 MB (its size faked), which says why.
//
// The speed story: the build refuses benchmark data that is incomplete or
// inconsistent, or that would make a summary claim false; test data derived
// from the real file is shown truthfully (a benchmark below 1× as slower, in
// the heading, its bar and the table, and pointed out by the build; the
// largest speed-up's benchmark for what it is; the number of runs; unexpected
// exits with their note, or as a warning; a Linux machine without its
// memory; a commit bench could not tell); the playground's headline, the
// note under its comparison and the benchmarks page (benchmarks.html) say
// what site/data/benchmarks.json
// and big-inputs.json hold; every chart and bar there has an accessible
// label and a table; the charts take their colours from the theme; every
// link resolves (pages and data here, anchors, files in this repository,
// commits); and neither page scrolls sideways at 360 or 390 px. "Measure
// warm runs" says what it does, and does it: one warm-up and 5 timed runs
// per engine, one engine after the other.
//
// The CLI is required: $QUICKTYPE_CLI, else target/release/quicktype
// (`cargo build --release -p quickertype`). The browser is $CHROME, else
// Google Chrome or Chromium; without one the test says so and exits 0 (in
// CI it fails).

import assert from "node:assert/strict";
import { execFileSync, spawn, spawnSync } from "node:child_process";
import { createHash } from "node:crypto";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import {
    benchmarkWarnings,
    benchmarksFile,
    benchmarksPageHtml,
    bigInputsFile,
    checkBenchmarks,
    formatMiB,
    formatMs as formatBenchMs,
    isTypical,
    links as benchLinks,
    named as benchNamed,
    readBenchmarks,
    speedFacts,
    speedupText,
    times as speedup,
} from "../benchmarks.mjs";
import { quicktypeReference } from "../reference.mjs";
import { serve } from "./serve.mjs";

const siteRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const repositoryRoot = path.join(siteRoot, "..");
const dist = path.join(siteRoot, "dist");
const screenshotArg = process.argv.indexOf("--screenshots");
const screenshots = screenshotArg >= 0 ? path.resolve(process.argv[screenshotArg + 1]) : undefined;

function findBrowser() {
    const candidates = [
        process.env.CHROME,
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
        "google-chrome",
        "google-chrome-stable",
        "chromium",
        "chromium-browser",
    ];
    for (const candidate of candidates) {
        if (candidate === undefined) continue;
        try {
            execFileSync(candidate, ["--version"], { stdio: "ignore" });
            return candidate;
        } catch {
            // Not this one.
        }
    }

    return undefined;
}

// ---------------------------------------------------------------------------
// Expected output

const cli = process.env.QUICKTYPE_CLI ?? path.join(repositoryRoot, "target", "release", "quicktype");
if (!fs.existsSync(cli)) {
    console.log(`No quicktype CLI at ${cli}: build it with \`cargo build --release -p quickertype\` or set QUICKTYPE_CLI.`);
    process.exit(1);
}

/** The input files the page names, by name: samples, and later the uploaded file. */
const sampleFiles = {
    "pokedex.json": "tests/inputs/json/samples/pokedex.json",
    "us-senators.json": "tests/inputs/json/samples/us-senators.json",
    "github-events.json": "tests/inputs/json/samples/github-events.json",
    "kitchen-sink.json": "tests/inputs/json/samples/kitchen-sink.json",
    "description.schema": "tests/inputs/schema/description.schema",
    // JSON with `$ref`s (uploaded), for --no-ignore-json-refs.
    "2465e.json": "tests/inputs/json/misc/2465e.json",
    // JSON with integers beyond 32 bits (uploaded), for Rust's --integer-type.
    "32431.json": "tests/inputs/json/misc/32431.json",
};

/**
 * Runs the command the page shows ("quicktype --lang rust … pokedex.json"):
 * the output, and the issues quicktype reports as `Line n: message`.
 */
function expectedFor(command) {
    const args = command.split(" ");
    assert.equal(args.shift(), "quicktype");
    const input = args.pop();
    assert.ok(input in sampleFiles, `unexpected input file ${input}`);
    const run = spawnSync(cli, [...args, path.resolve(repositoryRoot, sampleFiles[input])], {
        encoding: "utf8",
        maxBuffer: 1 << 28,
    });
    assert.equal(run.status, 0, run.stderr);
    const issues = [...run.stderr.matchAll(/^Issue in line (\d+): (.*)$/gm)].map((m) => `Line ${m[1]}: ${m[2]}`);
    return { text: run.stdout, issues };
}

// ---------------------------------------------------------------------------
// The browser

async function launch(browser) {
    const profile = fs.mkdtempSync(path.join(os.tmpdir(), "qt-site-"));
    const child = spawn(
        browser,
        [
            "--headless=new",
            "--disable-gpu",
            "--no-first-run",
            "--no-default-browser-check",
            "--hide-scrollbars",
            "--remote-debugging-port=0",
            `--user-data-dir=${profile}`,
            ...(process.env.CI ? ["--no-sandbox"] : []),
            "about:blank",
        ],
        { stdio: "ignore" },
    );
    const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
    const deadline = Date.now() + 30_000;
    const portFile = path.join(profile, "DevToolsActivePort");
    while (!fs.existsSync(portFile) || fs.readFileSync(portFile, "utf8").split("\n").length < 2) {
        if (Date.now() > deadline) throw new Error("the browser did not start");
        await wait(100);
    }

    const port = fs.readFileSync(portFile, "utf8").split("\n")[0];
    let target;
    while (target === undefined) {
        if (Date.now() > deadline) throw new Error("no page to drive");
        const targets = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json();
        target = targets.find((t) => t.type === "page");
        if (target === undefined) await wait(100);
    }

    const socket = new WebSocket(target.webSocketDebuggerUrl);
    await new Promise((resolve, reject) => {
        socket.onopen = resolve;
        socket.onerror = reject;
    });

    let nextId = 0;
    const pending = new Map();
    const problems = [];
    /** Waiting for an event: { method, resolve }. */
    const waiting = [];
    socket.onmessage = (event) => {
        const message = JSON.parse(event.data);
        if (message.id === undefined) {
            for (const w of waiting.filter((w) => w.method === message.method)) {
                waiting.splice(waiting.indexOf(w), 1);
                w.resolve(message.params);
            }
        }

        if (message.id !== undefined) {
            pending.get(message.id)?.(message);
            pending.delete(message.id);
        } else if (message.method === "Runtime.exceptionThrown") {
            problems.push(message.params.exceptionDetails.exception?.description ?? message.params.exceptionDetails.text);
        } else if (message.method === "Runtime.consoleAPICalled" && message.params.type === "error") {
            problems.push(message.params.args.map((a) => a.value ?? a.description).join(" "));
        }
    };
    const send = (method, params = {}) =>
        new Promise((resolve, reject) => {
            const id = ++nextId;
            pending.set(id, (m) => (m.error ? reject(new Error(`${method}: ${m.error.message}`)) : resolve(m.result)));
            socket.send(JSON.stringify({ id, method, params }));
        });

    /** The next event `method` (its params), or a timeout. */
    const next = (method, timeout = 30_000) =>
        new Promise((resolve, reject) => {
            const w = { method, resolve };
            waiting.push(w);
            setTimeout(() => {
                if (!waiting.includes(w)) return;
                waiting.splice(waiting.indexOf(w), 1);
                reject(new Error(`no ${method} within ${timeout / 1000} s`));
            }, timeout);
        });

    async function evaluate(expression) {
        const result = await send("Runtime.evaluate", { expression, returnByValue: true, awaitPromise: true });
        if (result.exceptionDetails) {
            throw new Error(`${expression}: ${result.exceptionDetails.exception?.description ?? result.exceptionDetails.text}`);
        }

        return result.result.value;
    }

    async function waitFor(expression, what, timeout = 60_000) {
        const until = Date.now() + timeout;
        for (;;) {
            if (await evaluate(`Boolean(${expression})`)) return;
            if (Date.now() > until) {
                const status = await evaluate(
                    "JSON.stringify({ ...document.body.dataset, meter: document.getElementById('meter')?.textContent, error: document.getElementById('error')?.textContent })",
                );
                throw new Error(`timed out waiting for ${what}: ${status}`);
            }

            await wait(50);
        }
    }

    async function viewport(width, height, { mobile = false, dark = false } = {}) {
        await send("Emulation.setDeviceMetricsOverride", { width, height, deviceScaleFactor: 2, mobile });
        await send("Emulation.setEmulatedMedia", {
            features: [{ name: "prefers-color-scheme", value: dark ? "dark" : "light" }],
        });
    }

    /** Saves a screenshot of the viewport, or with `full`, of the whole page. */
    async function screenshot(name, { full = false } = {}) {
        if (screenshots === undefined) return;
        fs.mkdirSync(screenshots, { recursive: true });
        const params = { format: "png" };
        if (full) {
            const { cssContentSize } = await send("Page.getLayoutMetrics");
            params.captureBeyondViewport = true;
            params.clip = { x: 0, y: 0, width: cssContentSize.width, height: cssContentSize.height, scale: 1 };
        }

        const { data } = await send("Page.captureScreenshot", params);
        const file = path.join(screenshots, name);
        fs.writeFileSync(file, Buffer.from(data, "base64"));
        console.log(`  screenshot: ${file}`);
    }

    /**
     * A full load of `url` (via about:blank: a change of hash alone would not
     * reload the page); the playground's, unless `playground` is false.
     */
    async function navigate(url, { playground = true } = {}) {
        await send("Page.navigate", { url: "about:blank" });
        await waitFor("location.href === 'about:blank'", "about:blank");
        await send("Page.navigate", { url });
        await waitFor(`document.readyState === 'complete' && ${playground ? "globalThis.playground" : "true"}`, "the page to load");
    }

    async function close() {
        socket.close();
        child.kill();
        await wait(200);
        fs.rmSync(profile, { recursive: true, force: true });
    }

    await send("Runtime.enable");
    await send("Page.enable");
    return { send, next, evaluate, waitFor, viewport, screenshot, navigate, close, problems };
}

// ---------------------------------------------------------------------------
// The checks

// The build refuses benchmark data the pages could not honestly show.
const benchmarkData = readBenchmarks();
const speedNow = speedFacts(benchmarkData.bench);
{
    /** `change` makes the data something the build must refuse (with a message matching `why`, if given). */
    const broken = (what, change, why = /./) => {
        const data = structuredClone(benchmarkData.bench);
        change(data);
        assert.throws(
            () => checkBenchmarks(data),
            (e) => e.message.startsWith("site/data/benchmarks.json: ") && why.test(e.message),
            `the build accepted ${what}`,
        );
    };
    broken("CLIs that wrote different files", (d) => (d.cli[0].identical = false));
    broken("a row without quicktype's time", (d) => delete d.cli[1].results.typescript);
    broken("a median below the minimum", (d) => (d.cli[2].results.rust.median_ms = d.cli[2].results.rust.min_ms / 2));
    broken("no corpus run", (d) => (d.corpus = null));
    broken("a short commit", (d) => (d.commits.quicktype = "c39af7d"));
    broken("a benchmark the page names, missing", (d) => (d.cli = d.cli.filter((r) => r.name !== benchNamed.pokedex)));
    broken("no CPU (the page names it)", (d) => delete d.machine.cpu, /machine\.cpu/);
    broken(
        "an unknown quickertype commit without a reason",
        (d) => {
            d.commits.quickertype = null;
            delete d.commits.quickertype_source;
        },
        /commits\.quickertype must be a commit .*, or null with quickertype_source/,
    );
    broken("an unexpected_exits_note that is not a sentence", (d) => (d.corpus.results.rust.unexpected_exits_note = ""), /unexpected_exits_note/);
    // A summary claim made false: the headline (typical files, memory), the corpus, the native engine.
    const slowerBy = (row, factor) => {
        row.results.rust.median_ms = row.results.typescript.median_ms * factor;
        row.results.rust.min_ms = row.results.rust.median_ms;
    };
    broken("quickertype slower on typical files", (d) => d.cli.filter(isTypical).forEach((r) => slowerBy(r, 1.2)), /slower on the median typical file/);
    broken(
        "quickertype using more memory",
        (d) => {
            const r = d.cli.find((row) => row.name === benchNamed.pokedex).results;
            r.rust.peak_rss_mib = r.typescript.peak_rss_mib * 2;
        },
        /uses a fraction/,
    );
    broken("quickertype slower on the corpus", (d) => (d.corpus.results.rust.wall_s = d.corpus.results.typescript.wall_s * 1.1), /whole corpus/);
    broken("quickertype's engine slower natively", (d) => (d.in_process.results.rust.total_ms = d.in_process.results.typescript.total_ms * 1.1), /natively/);
    console.log(`ok: benchmark data checked (${benchmarkData.bench.cli.length} CLI benchmarks, ${benchmarkData.bench.date}); broken data, and data that makes a summary claim false, is refused`);

    // Test data the page must show truthfully, derived from the real file:
    // the page's text for it (rendered as the build does), and what the
    // build points out.
    const pageFor = (change) => {
        const data = structuredClone(benchmarkData.bench);
        change(data);
        const html = benchmarksPageHtml({ bench: checkBenchmarks(data), big: benchmarkData.big });
        const plain = (s) => s.replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim();
        const all = (re) => [...html.matchAll(re)].map((m) => plain(m[1]));
        const facts = Object.fromEntries([...html.matchAll(/<div><dt>(.*?)<\/dt><dd>(.*?)<\/dd><\/div>/g)].map((m) => [m[1], plain(m[2])]));
        return {
            html,
            data,
            warnings: benchmarkWarnings(data),
            h2: all(/<h2[^>]*>(.*?)<\/h2>/g)[0],
            tile: all(/<div class="tile"><dt>(.*?)<\/dt>/g)[0],
            cli: all(/<section id="cli"[^>]*>\s*<h2[^>]*>.*?<\/h2>\s*<p>(.*?)<\/p>/gs)[0],
            caption: all(/<caption>(.*?)<\/caption>/g)[0],
            slower: [...html.matchAll(/<li class="bar-row slower"><span class="bar-name">(.*?)<\/span>.*?aria-label="([^"]*)".*?class="tip">([^<]*)</g)].map((m) => m.slice(1)),
            table: Object.fromEntries([...html.matchAll(/<tr><th scope="row">(.*?)<\/th>(?:<td class="num">[^<]*<\/td>){2}<td class="num">([^<]*)<\/td><\/tr>/g)].map((m) => [m[1], m[2]])),
            exits: all(/<p class="fineprint[^"]*">((?:Warning: )?[\d,]+ of [^<]*)<\/p>/g),
            warn: all(/<p class="fineprint warn">(.*?)<\/p>/g),
            machine: facts.Machine,
            quickertype: facts.quickertype,
        };
    };
    const real = pageFor(() => {});
    assert.equal(real.h2, `Every CLI run, ${speedNow.upTo}× to ${speedup(speedNow.lowest)} faster`);
    assert.deepEqual([real.slower, real.warnings], [[], []], "the real data: slower benchmarks, warnings");
    assert.match(real.tile, /^faster per CLI run at most \(--version, start-up alone\); about \d+× on typical files$/);
    assert.equal(real.caption, `CLI wall time per run, median of ${benchmarkData.bench.iterations} runs after one warm-up`);
    const rustCorpus = benchmarkData.bench.corpus.results.rust;
    assert.deepEqual(real.exits, [`${rustCorpus.unexpected_exits.toLocaleString("en-US")} of quickertype's ${rustCorpus.steps.toLocaleString("en-US")} runs exited unexpectedly. ${rustCorpus.unexpected_exits_note}`]);
    assert.deepEqual(real.warn, []);

    // A benchmark below 1×: shown as slower (heading, bar, label, table), and pointed out.
    const senators = "us-senators (155 KB) → TypeScript";
    const oneSlower = pageFor((d) => slowerBy(d.cli.find((r) => r.name === senators), 1.3));
    assert.equal(oneSlower.h2, `Every CLI run: up to ${speedNow.upTo}× faster, but one of ${benchmarkData.bench.cli.length} is 1.3× slower`);
    assert.equal(oneSlower.slower.length, 1);
    const [slowName, slowLabel, slowTip] = oneSlower.slower[0];
    assert.deepEqual([slowName, slowTip, oneSlower.table[senators]], [senators, "1.3× slower", "1.3× slower"]);
    assert.match(slowLabel, /^us-senators \(155 KB\) → TypeScript: quickertype 1\.3× slower, /);
    assert.match(oneSlower.cli, /^One run of the CLI per benchmark: how many times faster \(or slower\) quickertype's is/);
    assert.doesNotMatch(oneSlower.html, /\b0\.\d+×|1\.0× faster|times faster than quicktype's</, "a speed-up below 1 said as faster");
    assert.equal(oneSlower.warnings.length, 1);
    assert.match(oneSlower.warnings[0], /^site\/data\/benchmarks\.json: cli\[\d+\] \(us-senators \(155 KB\) → TypeScript\): quickertype is 1\.3× slower \(/);
    const twoSlower = pageFor((d) => {
        slowerBy(d.cli.find((r) => r.name === senators), 1.3);
        slowerBy(d.cli.find((r) => r.name.startsWith("github-events (82 KB) → go")), 1.1);
    });
    assert.equal(twoSlower.h2, `Every CLI run: up to ${speedNow.upTo}× faster, but 2 of ${benchmarkData.bench.cli.length} are slower, by up to 1.3×`);
    assert.equal(twoSlower.warnings.length, 2);
    console.log(`ok: test data with a benchmark below 1×: "${oneSlower.h2}"; its bar, label and table say "1.3× slower"; the build points it out`);

    // The largest speed-up on a benchmark that is not start-up: the tile says what that one measures.
    const big40 = pageFor((d) => {
        const r = d.cli.find((row) => row.name === "generated (40 MB) → TypeScript").results;
        r.rust.median_ms = r.rust.min_ms = r.typescript.median_ms / 500;
    });
    assert.match(big40.tile, /^faster per CLI run at most \(generated \(40 MB\) → TypeScript, a JSON input\); /);
    // Another number of runs: the caption and the text say it.
    const sevenRuns = pageFor((d) => (d.iterations = 7));
    assert.equal(sevenRuns.caption, "CLI wall time per run, median of 7 runs after one warm-up");
    assert.match(sevenRuns.cli, /medians of 7 runs\)/);
    // Unexpected exits without a note: the number, plainly, as a warning; none: nothing.
    const unexplained = pageFor((d) => delete d.corpus.results.rust.unexpected_exits_note);
    assert.deepEqual(unexplained.warn, [`Warning: ${rustCorpus.unexpected_exits.toLocaleString("en-US")} of quickertype's ${rustCorpus.steps.toLocaleString("en-US")} runs exited unexpectedly.`]);
    assert.deepEqual(unexplained.warnings, [`site/data/benchmarks.json: corpus.results.rust: ${rustCorpus.unexpected_exits} unexpected exits, and no unexpected_exits_note saying why`]);
    assert.deepEqual(pageFor((d) => (d.corpus.results.rust.unexpected_exits = 0)).exits, []);
    // A Linux machine as `cargo xtask bench --json` describes one, without its memory.
    const linux = pageFor((d) => (d.machine = { cpu: "aarch64, CPU part 0xd0c", cores: "64", os: "Linux 6.1.0-18-arm64" }));
    assert.equal(linux.machine, "aarch64, CPU part 0xd0c, 64 cores, Linux 6.1.0-18-arm64 (the memory not recorded)");
    // A CLI whose commit bench could not tell: said, not linked.
    const why = "--bin runs /usr/local/bin/quicktype, which is not in the target directory of a git work tree";
    const unknownCommit = pageFor((d) => Object.assign(d.commits, { quickertype: null, quickertype_modified: null, quickertype_source: why }));
    assert.equal(unknownCommit.quickertype, `not known: ${why}`);
    assert.ok(!unknownCommit.html.includes(benchmarkData.bench.commits.quickertype), "the unknown commit is linked");
    console.log("ok: the page says what the data holds: the tile's benchmark, the number of runs, unexpected exits (with the note, or as a warning), a machine as far as it was recorded, an unknown commit");
}

const browser = findBrowser();
if (browser === undefined) {
    if (process.env.CI) throw new Error("no Chrome or Chromium (set CHROME)");
    console.log("No Chrome or Chromium found (set CHROME); skipping. To look by hand: node site/test/serve.mjs");
    process.exit(0);
}

if (!fs.existsSync(path.join(dist, "index.html"))) throw new Error("site/dist is not built: node site/build.mjs");

const { server, requests, url } = await serve(dist);
const page = await launch(browser);

/**
 * The page's requests to its two workers never overlapped: each was sent
 * after the one before had replied (no time is taken while the other engine
 * runs). Returns how many there were.
 */
async function oneAtATime(what) {
    const log = await page.evaluate("globalThis.playground?.engines.wasm.lane.history ?? []");
    const sorted = [...log].sort((a, b) => a.sent - b.sent);
    for (let i = 1; i < sorted.length; i++) {
        const [before, after] = [sorted[i - 1], sorted[i]];
        assert.ok(
            after.sent >= before.received,
            `${what}: ${after.engine} request ${after.id} was sent while ${before.engine} request ${before.id} ran`,
        );
    }

    return log.length;
}

/** Checked on every page before leaving it. */
let requestsChecked = 0;
const navigateTo = page.navigate;
page.navigate = async (target, options) => {
    requestsChecked += await oneAtATime(`the requests on ${await page.evaluate("location.href")}`);
    await navigateTo(target, options);
};

/**
 * In the page: `start` (code) starts a request to `engine`'s worker; then
 * `then` (code) runs while it is in flight. False if it was over before the
 * page could see it.
 */
const whileInFlight = (engine, start, then) =>
    page.evaluate(`(async () => {
        const client = playground.engines.${engine};
        const id = client.nextId;
        ${start};
        while (client.inFlight?.id !== id) {
            if (client.nextId > id) return false;
            await new Promise((resolve) => setTimeout(resolve, 0));
        }
        ${then};
        return true;
    })()`);

/** The span of the request `id` to `engine`'s worker, from the page's log. */
async function spanOf(engine, id) {
    const span = await page.evaluate(`playground.engines.wasm.lane.history.find((s) => s.engine === "${engine}" && s.id === ${id})`);
    assert.ok(span !== undefined, `no request ${id} to the ${engine} worker`);
    return span;
}
const settled = "playground.generation > 0 && playground.view.settled === playground.generation";
const shown = () =>
    page.evaluate(`({
        files: playground.view.files.map((f) => ({ name: f.name, text: f.text })),
        code: document.getElementById("code").textContent,
        engine: playground.view.shown.engine,
        ran: playground.view.shown.result?.ran,
        ok: playground.view.shown.result?.ok,
        cli: playground.cli(),
        status: document.body.dataset.status,
        notes: [...document.querySelectorAll("#notes p")].map((p) => p.textContent.replace(/^(Line \\d+) /, "$1: ")),
    })`);

/** What the CLI prints for `files`: each file, with a `// name` header when there are several. */
function cliOutput(files) {
    return files.map((f, i) => `${i > 0 ? "\n" : ""}${files.length > 1 ? `// ${f.name}\n\n` : ""}${f.text}`).join("");
}

/** Does `action` (an expression) in the page and waits for the run it starts to settle. */
async function andRun(action, what, until = settled) {
    const before = await page.evaluate("playground.generation");
    await page.evaluate(action);
    await page.waitFor(`playground.generation > ${before} && ${until}`, what);
}

/** The engine picked, with what the switch shows. */
const engineSwitch = () =>
    page.evaluate(`({
        engine: playground.engine,
        checked: document.querySelector("input[name=engine]:checked").value,
        focused: document.activeElement.name === "engine" ? document.activeElement.value : null,
    })`);

/** How many requests there were, and how many runs each worker was sent. */
const runCounts = () =>
    page.evaluate("({ generation: playground.generation, wasm: playground.engines.wasm.nextId, ts: playground.engines.ts.nextId })");

/**
 * Picks `engine` (by clicking its radio button, or with `action`); waits for
 * its result on the input shown. Returns how many runs each worker did for it.
 */
async function switchEngine(engine, what, action) {
    const before = await runCounts();
    if (action !== undefined) await action();
    else await page.evaluate(`document.querySelector("input[name=engine][value=${engine}]").click()`);
    await page.waitFor(`playground.engine === "${engine}" && ${settled} && document.body.dataset.status !== "running"`, what);
    const after = await runCounts();
    assert.equal(after.generation, before.generation, `${what}: switching engine made a new request`);
    return { wasm: after.wasm - before.wasm, ts: after.ts - before.ts };
}

/**
 * Presses a key in the page (as the keyboard does: trusted events, default
 * actions); `text` for a key that types (Enter: "\r", which activates a button).
 */
async function press(key, keyCode, text) {
    for (const type of ["keyDown", "keyUp"]) {
        await page.send("Input.dispatchKeyEvent", { type, key, code: key, windowsVirtualKeyCode: keyCode, ...(type === "keyDown" && text ? { text } : {}) });
    }
}

const pressEnter = () => press("Enter", 13, "\r");
const pressEscape = () => press("Escape", 27);

/**
 * The options panel as the page shows it: open or not, modal (a drawer) or
 * not, the column it takes, the Options button's aria-expanded, where the
 * keyboard focus is ("toggle", "first" (the panel's first control), another
 * control in the panel, or elsewhere), and the code's width.
 */
const panelNow = () =>
    page.evaluate(`(() => {
        const panel = document.getElementById("options-panel");
        const active = document.activeElement;
        const first = panel.querySelector(".inspector-body :is(input, select, summary)");
        const name = (e) => e.id || e.tagName.toLowerCase();
        return {
            open: panel.open,
            modal: panel.matches(":modal"),
            layout: document.documentElement.dataset.panel,
            expanded: document.getElementById("options-toggle").getAttribute("aria-expanded"),
            focus: active.id === "options-toggle" ? "toggle" : active === first ? "first" : panel.contains(active) ? "panel " + name(active) : name(active),
            codeWidth: Math.round(document.getElementById("output").getBoundingClientRect().width),
        };
    })()`);

/** Waits for what slides or fades in (not what loops, as a running engine's bar) to be in place. */
const settledMotion = () =>
    page.evaluate("Promise.all(document.getAnimations().filter((a) => a.effect?.getComputedTiming().iterations !== Infinity).map((a) => a.finished))");

/**
 * Watches the page's live region (#announce) from now on: what it says, and
 * how often the comparison is drawn meanwhile. See liveSaid.
 */
const watchLive = () =>
    page.evaluate(`(() => {
        globalThis.announcer = document.getElementById("announce");
        globalThis.said = [];
        globalThis.meterDrawn = 0;
        new MutationObserver(() => announcer.textContent !== "" && said.push(announcer.textContent.trim())).observe(announcer, { childList: true, characterData: true, subtree: true });
        new MutationObserver(() => meterDrawn++).observe(document.getElementById("meter"), { childList: true });
    })()`);

/**
 * Since watchLive: the page has one live region, outside the comparison and
 * the panes (drawn again and again meanwhile), the same element all along,
 * and it said `expected` (each "generated", "compared" or "warm") once each,
 * in a few words, and nothing else: never what was running.
 */
async function liveSaid(expected, what) {
    const live = await page.evaluate(`({
        regions: [...document.querySelectorAll("[role=status], [aria-live]")].map((e) => e.id),
        same: document.getElementById("announce") === announcer,
        outside: announcer.closest("#meter, .pane") === null,
        said,
        drawn: meterDrawn,
    })`);
    assert.deepEqual(
        { ...live, said: live.said.length, drawn: live.drawn > live.said.length },
        { regions: ["announce"], same: true, outside: true, said: expected.length, drawn: true },
        `${what}: ${JSON.stringify(live)}`,
    );
    const pace = String.raw`(?:(?:quickertype|quicktype) \d+(?:\.\d)?× faster|quickertype and quicktype about as fast)`;
    const patterns = {
        generated: /^Generated by quickertype in \d[\d.]* m?s\.$/,
        compared: new RegExp(`^${pace}; identical output\\.$`),
        warm: new RegExp(`^Warm runs: ${pace}; identical output\\.$`),
    };
    expected.forEach((kind, i) => assert.match(live.said[i], patterns[kind], `${what}: ${kind}`));
    return live;
}

/**
 * Loads the playground with main.js held back until the page has painted:
 * the options' column (html[data-panel]) and the panes' widths at the first
 * paint, with only the HTML, the stylesheet and the script in the head, and
 * again once main.js has run and the first run settled (`screenshot`: of the first paint).
 */
async function firstPaint(what, screenshot) {
    const panes = `({
        panel: document.documentElement.dataset.panel,
        input: Math.round(document.getElementById("input-pane").getBoundingClientRect().width),
        output: Math.round(document.getElementById("output-pane").getBoundingClientRect().width),
    })`;
    await page.navigate("about:blank", { playground: false });
    await page.send("Fetch.enable", { patterns: [{ urlPattern: "*/main-*.js" }] });
    const paused = page.next("Fetch.requestPaused");
    await page.send("Page.navigate", { url });
    const { requestId } = await paused;
    let before;
    try {
        await page.waitFor("document.readyState === 'interactive' && performance.getEntriesByName('first-paint').length > 0", `${what}: the first paint`);
        before = await page.evaluate(`({ ...${panes}, main: "playground" in globalThis })`);
        if (screenshot !== undefined) await page.screenshot(screenshot);
    } finally {
        await page.send("Fetch.continueRequest", { requestId });
        await page.send("Fetch.disable");
    }
    const { main, ...painted } = before;
    assert.equal(main, false, `${what}: main.js ran before the first paint`);
    await page.waitFor(`document.readyState === 'complete' && globalThis.playground && ${settled}`, `${what}: the page`);
    return { before: painted, after: await page.evaluate(panes) };
}

/** The page is no wider than the window (`what` says where), nothing past its right edge. */
async function noSidewaysScroll(width, what) {
    await settledMotion();
    const sizes = await page.evaluate(`({
        scroll: document.documentElement.scrollWidth,
        overflowing: [...document.querySelectorAll("body *")]
            .filter((n) => n.getClientRects().length > 0 && n.closest("pre, textarea, .tabs, .inspector-body, .meter-details, [hidden]") === null)
            .filter((n) => n.getBoundingClientRect().right > ${width} + 0.5)
            .map((n) => n.tagName + "." + n.getAttribute("class") + "#" + n.id)
            .slice(0, 5),
    })`);
    assert.ok(sizes.scroll <= width, `${what}: the page is ${sizes.scroll} px wide`);
    assert.deepEqual(sizes.overflowing, [], `${what}: past the right edge`);
}

/**
 * Both engines' results for the input shown, as the page compares them:
 * byte-identical, with both times (warm medians if `measured`).
 */
async function comparedIdentical(what, measured = false) {
    await page.waitFor("['identical', 'different'].includes(document.body.dataset.compare)", `${what}: the comparison`);
    const shownNow = await page.evaluate(`({
        verdict: document.body.dataset.compare,
        text: document.querySelector("#meter .summary")?.textContent,
        fine: document.querySelector("#meter .fine p")?.textContent,
        lanes: [...document.querySelectorAll("#meter .lane")].map((l) => [l.querySelector(".engine").textContent, l.querySelector(".time").textContent]),
        wasm: playground.view.results.wasm?.result.files?.map((f) => f.text),
        ts: playground.view.results.ts?.result.files?.map((f) => f.text),
    })`);
    assert.equal(shownNow.verdict, "identical", `${what}: ${shownNow.text}`);
    assert.deepEqual(shownNow.wasm, shownNow.ts, `${what}: the results differ`);
    const time = String.raw`\d[\d.]* m?s`;
    assert.match(shownNow.fine, /^The outputs are identical byte for byte: \d+ files?, [\d,]+ bytes\. /, what);
    assert.deepEqual(
        shownNow.lanes.map(([name, t]) => [name, new RegExp(`^${time}$`).test(t)]),
        [["quickertype", true], ["quicktype", true]],
        `${what}: both bars with their times`,
    );
    // Which engine was faster, named as the subject, with the bars' times
    // (the subject's first); or both about as fast.
    const startUp = String.raw`(?:, (?:(?:quickertype|quicktype)'s )?start-up included)?`;
    const pace = (prefix) =>
        new RegExp(
            `^${prefix}(?:(quickertype|quicktype) was \\d[\\d.]*× faster \\((${time}) vs (${time})${startUp}\\)|quickertype and quicktype were about as fast \\((${time}) and (${time})${startUp}\\))`,
        );
    const lane = Object.fromEntries(shownNow.lanes);
    const named = (match, where) => {
        assert.ok(match !== null, `${what}: ${where}`);
        if (match[1] === undefined) {
            assert.deepEqual([match[4], match[5]], [lane.quickertype, lane.quicktype], `${what}: ${where}: the times`);
            return;
        }

        const slower = match[1] === "quickertype" ? "quicktype" : "quickertype";
        assert.deepEqual([match[2], match[3]], [lane[match[1]], lane[slower]], `${what}: ${where}: the times`);
        assert.ok(seconds(match[2]) <= seconds(match[3]), `${what}: ${where}: ${match[1]} is named the faster`);
    };
    assert.match(shownNow.text, new RegExp(`${pace(measured ? "Warm medians: " : "").source} · identical output ✓$`), what);
    named(pace(measured ? "Warm medians: " : "").exec(shownNow.text), `"${shownNow.text}"`);
    // The line at a glance (the button that opens those details): each
    // engine's time as on its bar, the verdict, whether the runs were warm,
    // and which engine was faster as the sentence says it.
    const glance = await page.evaluate(`(() => {
        const line = document.getElementById("meter-toggle");
        return {
            chips: [...line.querySelectorAll(".chip")].map((c) => [c.querySelector(".engine").textContent, c.querySelector(".time").textContent]),
            verdict: line.querySelector(".verdict")?.textContent,
            qualifiers: [...line.querySelectorAll(".qualifier")].map((q) => q.textContent),
            pace: line.querySelector(".pace")?.textContent,
            name: line.textContent.startsWith("Details: "),
            controls: line.getAttribute("aria-controls"),
        };
    })()`);
    assert.deepEqual(glance.chips, shownNow.lanes, `${what}: the times at a glance`);
    assert.equal(glance.verdict, "identical output ✓", `${what}: the verdict at a glance`);
    assert.deepEqual([glance.name, glance.controls], [true, "meter-details"], `${what}: the line at a glance opens the details`);
    if (measured) assert.deepEqual(glance.qualifiers, ["warm runs"], `${what}: warm runs, at a glance`);
    else assert.ok(!glance.qualifiers.includes("warm runs"), `${what}: first runs said to be warm`);
    const sentence = pace(measured ? "Warm medians: " : "").exec(shownNow.text);
    assert.equal(glance.pace, sentence[1] === undefined ? "about as fast" : `${sentence[1]} ${/was (\d[\d.]*×) faster/.exec(shownNow.text)[1]} faster`, `${what}: the pace at a glance`);
    // The fine print may say which was faster at generating the code alone, as plainly.
    const generating = /At generating the code alone, (.*?\))\./.exec(shownNow.fine);
    if (generating !== null) assert.match(generating[1], pace(""), `${what}: "${generating[0]}"`);
    return shownNow.text;
}

/** "3.00 ms" or "1.20 s" in seconds. */
const seconds = (t) => Number.parseFloat(t) / (t.endsWith(" ms") ? 1000 : 1);

/** A warm measurement of both engines on what the page shows has finished. */
const measuredDone = `(() => {
    const bench = playground.view.bench;
    return bench !== undefined && typeof bench.wasm === "object" && typeof bench.ts === "object" &&
        document.body.dataset.compare !== "running";
})()`;

function select(id, value) {
    return andRun(
        `(() => {
            const control = document.getElementById(${JSON.stringify(id)});
            control.value = ${JSON.stringify(value)};
            control.dispatchEvent(new Event("input", { bubbles: true }));
            control.dispatchEvent(new Event("change", { bubbles: true }));
        })()`,
        `a run after choosing ${value}`,
    );
}

/**
 * The page shows the CLI's output for the command it shows, which is
 * `expectedCommand`, from `engine` ("wasm": quickertype, "ts": quicktype);
 * returns the output.
 */
async function sameAsCli(label, expectedCommand, engine = "wasm") {
    const result = await shown();
    assert.equal(result.status, "done", `${label}: ${result.status}`);
    assert.equal(result.engine, engine, `${label} is the output of ${result.engine}`);
    assert.equal(result.ran, engine, `${label} ran on ${result.ran}`);
    assert.equal(result.cli, expectedCommand);
    assert.ok(result.files.length >= 1);
    const expected = expectedFor(result.cli);
    const output = cliOutput(result.files);
    assert.ok(output === expected.text, `${label}: output differs from the CLI`);
    const tab = await page.evaluate("playground.view.tab");
    assert.ok(result.code === result.files[tab].text, `${label}: the code shown differs from the output`);
    if (result.files.length === 1) assert.deepEqual(result.notes, expected.issues, `${label}: issues`);
    const issues = expected.issues.length > 0 ? `, ${expected.issues.length} issue(s) shown as on the CLI` : "";
    console.log(`ok: ${label} = \`${result.cli}\` (${expected.text.length} characters${issues})`);
    return output;
}

/** Ticks or unticks the control `id` (a checkbox) and waits for the run. */
const click = (id) => andRun(`document.getElementById(${JSON.stringify(id)}).click()`, `a run after clicking ${id}`);

const hashNow = () => page.evaluate("location.hash");

/** The command under the output: shown whole (wrapped, never cut off), and what Copy copies. */
async function commandShown(label) {
    const command = await page.evaluate(`(async () => {
        const cli = document.getElementById("cli");
        let copied;
        Object.defineProperty(navigator.clipboard, "writeText", { configurable: true, value: async (text) => { copied = text; } });
        document.getElementById("copy-cli").click();
        await new Promise((resolve) => setTimeout(resolve, 0));
        const line = parseFloat(getComputedStyle(cli).lineHeight);
        return {
            command: playground.cli(),
            copied,
            text: cli.textContent,
            hidden: cli.scrollWidth - cli.clientWidth,
            lines: Math.round(cli.getBoundingClientRect().height / line),
            split: [...cli.querySelectorAll(".arg")].filter((a) => a.getBoundingClientRect().height > line * 1.5).map((a) => a.textContent),
        };
    })()`);
    assert.equal(command.text, command.command, `${label}: the command shown`);
    assert.equal(command.copied, command.command, `${label}: Copy`);
    assert.ok(command.hidden <= 0, `${label}: ${command.hidden} px of the command are cut off`);
    assert.deepEqual(command.split, [], `${label}: arguments broken across lines`);
    return command;
}

/** Opens `file` with the file picker and waits for the run on it. */
async function upload(file) {
    const { result: picker } = await page.send("Runtime.evaluate", { expression: "document.getElementById('file')" });
    const before = await page.evaluate("playground.generation");
    await page.send("DOM.setFileInputFiles", { files: [file], objectId: picker.objectId });
    await page.waitFor(`playground.generation > ${before} && ${settled}`, `the run on ${path.basename(file)}`);
}

/**
 * Opens `file` as a user does: a (trusted) click on "Open file", which opens
 * the browser's file chooser, intercepted here, and the file picked in it.
 */
async function chooseFile(file) {
    await page.send("Page.setInterceptFileChooserDialog", { enabled: true });
    const box = await page.evaluate(
        `(() => { const r = document.getElementById("open").getBoundingClientRect(); return { x: r.x + r.width / 2, y: r.y + r.height / 2 }; })()`,
    );
    const opened = page.next("Page.fileChooserOpened");
    for (const type of ["mousePressed", "mouseReleased"]) {
        await page.send("Input.dispatchMouseEvent", { type, x: box.x, y: box.y, button: "left", clickCount: 1 });
    }

    const chooser = await opened;
    assert.equal(chooser.mode, "selectSingle");
    await page.send("DOM.setFileInputFiles", { files: [file], backendNodeId: chooser.backendNodeId });
}

/** Opens `file` with "Open file" and waits for its run, or with `failing`, for the error it shows. */
async function openFile(file, { failing = false, timeout = 60_000 } = {}) {
    const before = await page.evaluate("playground.generation");
    await chooseFile(file);
    const until = failing ? `document.body.dataset.status === "error"` : `${settled} && document.body.dataset.status !== "running"`;
    await page.waitFor(`playground.generation > ${before} && ${until}`, `opening ${path.basename(file)}`, timeout);
}

/**
 * What the input pane shows, and what is saved: the editor's text (null if
 * it is hidden), the large input's name, size and status (null if there is
 * none), the input's source, the command under the output, and the input
 * kept in localStorage.
 */
const inputPane = () =>
    page.evaluate(`({
        editor: document.getElementById("input").hidden ? null : document.getElementById("input").value,
        text: playground.state.text,
        large: document.getElementById("large").hidden
            ? null
            : {
                  name: document.getElementById("large-name").textContent,
                  size: document.getElementById("large-size").textContent,
                  status: document.getElementById("large-status").textContent,
              },
        source: playground.state.source,
        command: playground.cli(),
        saved: localStorage.getItem("quickertype.input"),
    })`);

/**
 * A file could not be opened: the output pane says so (its title, its
 * message, and where to get the CLI, if `cli`); the input before stays the
 * input (`before`, from inputPane: in the editor or as the large file it
 * was, the command for it, and what is saved), a large one without a status
 * while the output is the error; there is no request, nothing runs or
 * waits, the output is not shown as stale, and switching engine runs
 * nothing.
 */
async function openFailed(what, { title, message, before, cli: withCli = false }) {
    await new Promise((resolve) => setTimeout(resolve, 300));
    const shownNow = await page.evaluate(`({
        status: document.body.dataset.status,
        title: document.querySelector("#error .error-title")?.textContent,
        message: document.querySelector("#error .error-message")?.textContent,
        link: document.querySelector("#error .error-help a")?.href ?? null,
        request: playground.view.request === undefined,
        busy: playground.engines.wasm.isBusy || playground.engines.ts.isBusy,
        stale: document.getElementById("code-wrap").classList.contains("stale"),
        running: document.getElementById("meter").textContent.includes("Running") || document.getElementById("meter").textContent.includes("Reading"),
    })`);
    assert.equal(shownNow.title, title, `${what}: the title`);
    if (message instanceof RegExp) assert.match(shownNow.message, message, `${what}: the message`);
    else assert.equal(shownNow.message, message, `${what}: the message`);
    assert.deepEqual(
        { ...shownNow, title: undefined, message: undefined },
        { status: "error", title: undefined, message: undefined, link: withCli ? "https://github.com/EloB/quickertype#install" : null, request: true, busy: false, stale: false, running: false },
        `${what}: the page after it`,
    );
    const expected = before.large === null ? before : { ...before, large: { ...before.large, status: "" } };
    assert.deepEqual(await inputPane(), expected, `${what}: the input before, in the input pane, the command and what is saved`);
    const engine = await page.evaluate("playground.engine");
    for (const other of [engine === "wasm" ? "ts" : "wasm", engine]) {
        const ran = await switchEngine(other, `${what}: a switch to ${other}`);
        assert.deepEqual(ran, { wasm: 0, ts: 0 }, `${what}: a switch to ${other} ran`);
    }

    assert.equal(await page.evaluate(`document.querySelector("#error .error-message")?.textContent`), shownNow.message, `${what}: after the switches`);
    return shownNow;
}

/**
 * A synthetic rulings.json: `bytes` of an array of small records, each with
 * a long text string (seeded, so every run checks the same file).
 */
function rulingsJson(bytes) {
    let seed = 42;
    const random = () => (seed = (seed * 1103515245 + 12345) % 2147483648) / 2147483648;
    const pick = (items) => items[Math.floor(random() * items.length)];
    const words = "the a creature spell ability card player target controller graveyard battlefield if when this that you its until end of turn may be can't damage counter mana cost token copy library hand exile".split(" ");
    const hex = (n) => Array.from({ length: n }, () => pick("0123456789abcdef")).join("");
    const records = [];
    for (let size = 2; size < bytes; ) {
        const record = JSON.stringify({
            object: "ruling",
            oracle_id: `${hex(8)}-${hex(4)}-${hex(4)}-${hex(4)}-${hex(12)}`,
            source: random() < 0.7 ? "wotc" : "scryfall",
            published_at: `20${String(4 + Math.floor(random() * 20)).padStart(2, "0")}-${String(1 + Math.floor(random() * 12)).padStart(2, "0")}-${String(1 + Math.floor(random() * 28)).padStart(2, "0")}`,
            comment: `${Array.from({ length: 15 + Math.floor(random() * 20) }, () => pick(words)).join(" ")}.`,
        });
        records.push(record);
        size += record.length + 1;
    }

    return { text: `[${records.join(",")}]`, records: records.length };
}

/** "median 3.2 ms (reading the input 1.1, generating 2.1)" for one engine's warm runs. */
function medians({ times, inputTimes }) {
    const median = (xs) => [...xs].sort((a, b) => a - b)[xs.length >> 1];
    const generate = times.map((t, i) => t - inputTimes[i]);
    const ms = (x) => x.toFixed(x < 10 ? 2 : 1);
    return `median ${ms(median(times))} ms (reading the input ${ms(median(inputTimes))}, generating ${ms(median(generate))})`;
}

let failed = false;
/** Temporary directories to remove at the end. */
const cleanUp = [];
try {
    console.log(`page: ${url}  browser: ${browser}`);
    console.log(`reference: ${cli}`);

    await page.viewport(1440, 900);
    // The default view: no hash, nothing saved.
    await page.navigate(url);
    await page.waitFor(settled, "the first run");
    const languages = await page.evaluate("document.querySelectorAll('#lang option').length");
    assert.equal(languages, 27);
    const title = await page.evaluate("document.title");
    assert.match(title, /quickertype/);
    const boot = await page.evaluate("playground.engines.wasm.boot");
    assert.equal(boot.loadError, undefined);
    console.log(`ok: loads, ${languages} languages, engine compiled in ${boot.compileMs.toFixed(0)} ms`);

    // TypeScript with quicktype's defaults: types plus converters, as
    // `quicktype` gives them; `just-types` is off, with a hint saying what
    // that means; the general options are off and collapsed.
    const defaultTs = await sameAsCli("default: pokedex.json → TypeScript", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    const defaults = await page.evaluate(`({
        hash: location.hash,
        justTypes: document.getElementById("opt-just-types").checked,
        hint: document.getElementById("opt-just-types").closest("label").querySelector(".hint")?.textContent,
        general: document.getElementById("general").open,
        count: document.getElementById("general-count").textContent,
        on: [...document.querySelectorAll("#general-options input")].filter((i) => i.checked).length,
    })`);
    assert.deepEqual(defaults, {
        hash: "#v=2&l=typescript&s=pokedex",
        justTypes: false,
        hint: "Off: types plus runtime conversion code (quicktype's default)",
        general: false,
        count: "10",
        on: 0,
    });
    assert.match(defaultTs, /export class Convert/);
    console.log(`ok: the default view: quicktype's defaults, just-types off with its hint, General collapsed (${defaults.hash})`);
    // The engine switch: a labelled radio group, quickertype picked, a note under it.
    const group = await page.evaluate(`(() => {
        const group = document.getElementById("engine");
        return {
            role: group.getAttribute("role"),
            label: document.getElementById(group.getAttribute("aria-labelledby")).textContent,
            radios: [...group.querySelectorAll("input")].map((i) => [i.type, i.name, i.closest("label").textContent, i.checked]),
            note: document.getElementById(group.getAttribute("aria-describedby")).textContent,
            compare: document.body.dataset.compare,
            hint: document.querySelector("#meter .fine p").textContent,
        };
    })()`);
    assert.deepEqual(
        { role: group.role, label: group.label, radios: group.radios, compare: group.compare },
        {
            role: "radiogroup",
            label: "Engine",
            radios: [
                ["radio", "engine", "quicktype", false],
                ["radio", "engine", "quickertype", true],
            ],
            compare: "off",
        },
    );
    assert.match(group.note, /^Both run in your browser: .*warm runs are /);
    assert.match(group.hint, /^Switch to quicktype to compare the engines on this input, or measure warm runs of both\./);
    console.log(`ok: the engine switch: quicktype, (quickertype), with the note "${group.note}"`);
    await page.screenshot("default.png");

    // The speed headline, from site/data/benchmarks.json: one sentence and two links.
    const headline = await page.evaluate(`(() => {
        const p = document.getElementById("speed");
        return { text: p.textContent, links: [...p.querySelectorAll("a")].map((a) => [a.textContent, a.getAttribute("href")]), bottom: p.getBoundingClientRect().bottom };
    })()`);
    assert.equal(
        headline.text,
        `quicktype rewritten in Rust: the same output, byte for byte. The CLI is up to ${speedNow.upTo}× faster (about ${speedNow.typical}× on typical files) and uses a fraction of the memory. Benchmarks · Install the CLI`,
    );
    assert.deepEqual(headline.links, [["Benchmarks", "./benchmarks.html"], ["Install the CLI", benchLinks.install]]);
    // It leaves the playground in view: the panes start in the first screen.
    const panesTop = await page.evaluate("document.querySelector('.panes').getBoundingClientRect().top");
    assert.ok(panesTop < 900 * 0.6, `the panes start at ${panesTop} px`);
    console.log(`ok: the speed headline: "${headline.text}" (the panes start at ${Math.round(panesTop)} px)`);

    // The layout at 1440×900: the generated code has most of the window's
    // height; the masthead and the footer are one line each; the options
    // are open beside the output (a dialog, not modal: the page stays
    // usable), and opening them took no focus; the comparison is one line,
    // its details closed; the page does not scroll.
    const layout = await page.evaluate(`(() => {
        const box = (selector) => document.querySelector(selector).getBoundingClientRect();
        const lines = (selector) => Math.round(box(selector).height / parseFloat(getComputedStyle(document.querySelector(selector)).lineHeight));
        return {
            code: box("#output").height / innerHeight,
            headline: lines("#speed"),
            footer: box(".credits").height,
            license: document.getElementById("license").textContent,
            line: box("#meter .meter-line").height,
            details: document.getElementById("meter-details").hidden,
            panel: document.documentElement.dataset.panel,
            panelBeside: box("#options-panel").left >= box("#output-pane").right - 1,
            scrolls: document.documentElement.scrollHeight > innerHeight || document.documentElement.scrollWidth > innerWidth,
        };
    })()`);
    assert.ok(layout.code >= 0.55, `the code takes ${(layout.code * 100).toFixed(0)}% of the window's height`);
    assert.deepEqual(
        { ...layout, code: undefined, footer: layout.footer <= 40, line: layout.line <= 44 },
        {
            code: undefined,
            headline: 1,
            footer: true,
            // The samples' credit, in the footer, always visible.
            license: "A Rust/WebAssembly port of quicktype, with samples from its test suite; all Apache-2.0. Not affiliated with quicktype or Glide.",
            line: true,
            details: true,
            panel: "inline",
            panelBeside: true,
            scrolls: false,
        },
        "the layout at 1440×900",
    );
    const panelAtLoad = await panelNow();
    assert.deepEqual(
        { ...panelAtLoad, codeWidth: undefined },
        { open: true, modal: false, layout: "inline", expanded: "true", focus: "body", codeWidth: undefined },
        "the options at load",
    );
    console.log(`ok: at 1440×900 the code has ${(layout.code * 100).toFixed(0)}% of the window's height; the options are open beside it, the comparison one line`);

    // The options open and close from the keyboard: Enter on the Options
    // button, Escape in them, or their close button. Opened, the focus moves
    // to their first control; closed, it is back on the Options button, and
    // the code takes their room. The viewer's choice is kept for the next visit.
    await page.evaluate("document.getElementById('options-toggle').focus()");
    await pressEnter();
    const closedPanel = await panelNow();
    assert.deepEqual(
        { ...closedPanel, codeWidth: undefined },
        { open: false, modal: false, layout: "closed", expanded: "false", focus: "toggle", codeWidth: undefined },
        "Enter on Options, to close them",
    );
    assert.ok(closedPanel.codeWidth > panelAtLoad.codeWidth + 120, `the code is ${closedPanel.codeWidth} px wide without the options (${panelAtLoad.codeWidth} px with them)`);
    await page.screenshot("layout-options-closed.png");
    await pressEnter();
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined },
        { open: true, modal: false, layout: "inline", expanded: "true", focus: "first", codeWidth: undefined },
        "Enter on Options, to open them",
    );
    await pressEscape();
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined },
        { open: false, modal: false, layout: "closed", expanded: "false", focus: "toggle", codeWidth: undefined },
        "Escape in the options",
    );
    await page.navigate(url);
    await page.waitFor(settled, "the first run, after closing the options");
    assert.equal((await panelNow()).layout, "closed", "closed options, after a reload");
    await page.evaluate("document.getElementById('options-toggle').focus()");
    await pressEnter();
    await page.evaluate("document.getElementById('options-close').focus()");
    await pressEnter();
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined },
        { open: false, modal: false, layout: "closed", expanded: "false", focus: "toggle", codeWidth: undefined },
        "Enter on the options' close button",
    );
    await page.evaluate("document.getElementById('options-toggle').click()");
    await page.navigate(url);
    await page.waitFor(settled, "the first run, after opening the options");
    assert.deepEqual(await panelNow(), panelAtLoad, "opened options, after a reload");
    console.log("ok: the options open (focus on their first control) and close (focus back on Options) with Enter and Escape, and stay as the viewer left them");

    // A narrower window: the options are a modal drawer over the page. Opened,
    // the focus is in it and the page behind is inert; Escape closes it, as
    // does a click on its backdrop, and the focus goes back to Options. Open
    // beside the output as the window narrows, they close.
    await page.viewport(1024, 768);
    await page.waitFor("document.documentElement.dataset.panel === 'closed'", "the options closing as the window narrows");
    await page.evaluate("document.getElementById('options-toggle').focus()");
    await pressEnter();
    // Measured once it has slid in.
    await settledMotion();
    const drawer = await page.evaluate(`(() => {
        const panel = document.getElementById("options-panel");
        const before = document.activeElement;
        document.getElementById("copy").focus();
        const inert = document.activeElement === before;
        const box = panel.getBoundingClientRect();
        return { inert, right: Math.round(box.right), height: Math.round(box.height) };
    })()`);
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined, ...drawer },
        { open: true, modal: true, layout: "drawer", expanded: "true", focus: "first", codeWidth: undefined, inert: true, right: 1024, height: 768 },
        "the drawer at 1024 px",
    );
    await page.screenshot("layout-options-drawer-1024.png");
    await pressEscape();
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined },
        { open: false, modal: false, layout: "closed", expanded: "false", focus: "toggle", codeWidth: undefined },
        "Escape in the drawer",
    );
    // A drag from the drawer to its backdrop, or the other way, is no click
    // on the backdrop: the drawer stays open. A click on the backdrop closes it.
    await page.evaluate("document.getElementById('options-toggle').click()");
    await settledMotion();
    const inDrawer = await page.evaluate(
        `(() => { const r = document.getElementById("options-heading").getBoundingClientRect(); return { x: r.x + r.width / 2, y: r.y + r.height / 2 }; })()`,
    );
    const onBackdrop = { x: 40, y: 400 };
    for (const [from, to, what] of [[inDrawer, onBackdrop, "from the drawer to its backdrop"], [onBackdrop, inDrawer, "from the backdrop into the drawer"]]) {
        await page.send("Input.dispatchMouseEvent", { type: "mousePressed", ...from, button: "left", buttons: 1, clickCount: 1 });
        await page.send("Input.dispatchMouseEvent", { type: "mouseMoved", ...to, button: "left", buttons: 1 });
        await page.send("Input.dispatchMouseEvent", { type: "mouseReleased", ...to, button: "left", buttons: 0, clickCount: 1 });
        assert.equal((await panelNow()).layout, "drawer", `a drag ${what}`);
    }
    for (const type of ["mousePressed", "mouseReleased"]) {
        await page.send("Input.dispatchMouseEvent", { type, ...onBackdrop, button: "left", clickCount: 1 });
    }
    assert.equal((await panelNow()).layout, "closed", "a click on the drawer's backdrop");
    const savedPanel = () => page.evaluate("localStorage.getItem('quickertype.options')");
    assert.equal(await savedPanel(), "closed", "closed by a click on the backdrop: kept");

    // Closed by the browser itself (a drawer's Escape without user
    // activation, which the page cannot cancel; or close() from outside the
    // page's code): the choice is kept all the same, the focus back on Options.
    await page.navigate(url);
    await page.waitFor(settled, "the first run at 1024 px");
    for (const how of ["Escape", "close()"]) {
        // Opened by a script (no user activation).
        await page.evaluate("document.getElementById('options-toggle').click()");
        await settledMotion();
        assert.equal(await savedPanel(), "open", `opened, before ${how}`);
        if (how === "Escape") await pressEscape();
        else await page.evaluate("document.getElementById('options-panel').close()");
        await page.waitFor("document.documentElement.dataset.panel === 'closed'", `the drawer closed by ${how}`);
        assert.deepEqual(
            { saved: await savedPanel(), focus: (await panelNow()).focus },
            { saved: "closed", focus: "toggle" },
            `the drawer closed by the browser (${how})`,
        );
    }

    // Open as the window widens past where the options fit beside the
    // output, or narrows below it: not the viewer's choice, so nothing is
    // saved. Widened, they move beside the output with the focus; narrowed,
    // they close, the focus back on Options.
    await page.evaluate("document.getElementById('options-toggle').focus()");
    await pressEnter();
    await page.viewport(1440, 900);
    await page.waitFor("document.documentElement.dataset.panel === 'inline'", "the drawer moving beside the output as the window widens");
    await settledMotion();
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined, saved: await savedPanel() },
        { open: true, modal: false, layout: "inline", expanded: "true", focus: "first", codeWidth: undefined, saved: "open" },
        "the drawer, as the window widens",
    );
    await page.viewport(1024, 768);
    await page.waitFor("document.documentElement.dataset.panel === 'closed'", "the options closing as the window narrows");
    await settledMotion();
    assert.deepEqual(
        { ...(await panelNow()), codeWidth: undefined, saved: await savedPanel() },
        { open: false, modal: false, layout: "closed", expanded: "false", focus: "toggle", codeWidth: undefined, saved: "open" },
        "the options beside the output, as the window narrows",
    );
    await page.viewport(1440, 900);
    await page.waitFor("document.documentElement.dataset.panel === 'closed'", "the options staying closed as the window widens");
    await page.evaluate("document.getElementById('options-toggle').click()");
    assert.equal((await panelNow()).layout, "inline", "the options opened again beside the output");
    console.log("ok: at 1024 px the options are a modal drawer: focus in it, the page behind inert; Escape or the backdrop closes it, not a drag from or to it, the focus back on Options; closed by the browser, the choice is kept; the window's width saves nothing");

    // The options' column is decided before the first paint, by the script
    // in the head, so nothing moves when main.js opens them: the same column
    // and the same widths at the first paint and after the first run.
    const setSaved = (value) =>
        page.evaluate(value === null ? "localStorage.removeItem('quickertype.options')" : `localStorage.setItem('quickertype.options', '${value}')`);
    const painted = [];
    for (const [width, height, saved, panel] of [
        [1440, 900, null, "inline"],
        [1440, 900, "closed", "closed"],
        [1240, 800, null, "closed"],
        [1240, 800, "open", "inline"],
        [1024, 768, "open", "closed"],
    ]) {
        await page.viewport(width, height);
        await setSaved(saved);
        const what = `at ${width} px, ${saved === null ? "nothing saved" : `saved ${saved}`}`;
        const { before, after } = await firstPaint(what, width === 1440 && saved === null ? "layout-first-paint.png" : undefined);
        assert.deepEqual(before, after, `${what}: the panes at the first paint, and after the first run`);
        assert.equal(after.panel, panel, `${what}: the options`);
        painted.push(`${width} px, ${saved ?? "nothing"} saved: ${panel}`);
    }
    await page.viewport(1440, 900);
    await setSaved("open");
    console.log(`ok: the options' column is there from the first paint, before main.js runs, and nothing moves when it does (${painted.join("; ")})`);

    // The script in the head keeps the page CSP-friendly: under a policy
    // that allows the site's scripts and that one by its hash (no
    // 'unsafe-inline'), the page runs as it does without one.
    const inline = [...(await (await fetch(url)).text()).matchAll(/<script>([^<]*)<\/script>/g)].map((m) => m[1]);
    assert.equal(inline.length, 1, "inline scripts in index.html");
    const policy = `script-src 'self' 'sha256-${createHash("sha256").update(inline[0]).digest("base64")}'`;
    const { identifier: watch } = await page.send("Page.addScriptToEvaluateOnNewDocument", {
        source: "globalThis.violations = []; addEventListener('securitypolicyviolation', (e) => violations.push(e.violatedDirective + ' ' + e.blockedURI));",
    });
    await page.navigate("about:blank", { playground: false });
    await page.send("Fetch.enable", { patterns: [{ urlPattern: url, requestStage: "Response" }] });
    const pausedPage = page.next("Fetch.requestPaused");
    const navigated = page.send("Page.navigate", { url });
    const { requestId, responseHeaders } = await pausedPage;
    const { body, base64Encoded } = await page.send("Fetch.getResponseBody", { requestId });
    await page.send("Fetch.fulfillRequest", {
        requestId,
        responseCode: 200,
        responseHeaders: [...responseHeaders, { name: "Content-Security-Policy", value: policy }],
        body: base64Encoded ? body : Buffer.from(body).toString("base64"),
    });
    await navigated;
    await page.send("Fetch.disable");
    await page.waitFor(`document.readyState === 'complete' && globalThis.playground && ${settled}`, "the page under a Content-Security-Policy");
    const underPolicy = await page.evaluate(
        "({ violations, panel: document.documentElement.dataset.panel, status: document.body.dataset.status, wasm: playground.engines.wasm.boot.loadError ?? null })",
    );
    await page.send("Page.removeScriptToEvaluateOnNewDocument", { identifier: watch });
    assert.deepEqual(underPolicy, { violations: [], panel: "inline", status: "done", wasm: null }, `the page under "${policy}"`);
    console.log(`ok: under "${policy}" (the script in the head by its hash) the page runs, nothing blocked`);
    await page.navigate(url);
    await page.waitFor(settled, "the first run, the options open again");

    // The notes behind an "i": Enter opens one, inside the window; Escape
    // closes it, the focus back on its button.
    for (const [note, text] of [["engine-note", /^Both run in your browser: /], ["version-note", /^This is newer than the v26\.0\.0 release/], ["input-note", /^Paste JSON or a JSON Schema, /], ["install-note", /^Get the CLI\. .*brew install elob\/tap\/quickertype.*npm install -g quickertype.*cargo install quickertype/]]) {
        const button = `document.querySelector('[aria-controls=${note}]')`;
        await page.evaluate(`${button}.focus()`);
        await pressEnter();
        const tip = await page.evaluate(`(() => {
            const tip = document.getElementById("${note}");
            const box = tip.getBoundingClientRect();
            return { shown: !tip.hidden, expanded: ${button}.getAttribute("aria-expanded"), inside: box.left >= 0 && box.top >= 0 && box.right <= innerWidth && box.bottom <= innerHeight, text: tip.textContent };
        })()`);
        assert.deepEqual({ ...tip, text: text.test(tip.text) }, { shown: true, expanded: "true", inside: true, text: true }, `the note ${note}`);
        await pressEscape();
        assert.deepEqual(
            await page.evaluate(`({ shown: !document.getElementById("${note}").hidden, focused: document.activeElement === ${button} })`),
            { shown: false, focused: true },
            `Escape on the note ${note}`,
        );
    }
    console.log("ok: the notes behind an \"i\" open with Enter, inside the window, and close with Escape");

    // just-types on: types only, as `quicktype --just-types`; the hash says
    // so and brings it back; off again, the converters are back.
    await click("opt-just-types");
    const justTypes = await sameAsCli(
        "pokedex.json → TypeScript, just-types",
        "quicktype --lang typescript --top-level Pokedex --just-types pokedex.json",
    );
    assert.doesNotMatch(justTypes, /Convert/);
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex&just-types=true");
    await page.navigate(`${url}#v=2&l=typescript&s=pokedex&just-types=true`);
    await page.waitFor(settled, "the run with just-types from the hash");
    assert.equal(await page.evaluate("document.getElementById('opt-just-types').checked"), true);
    await sameAsCli("just-types from the hash", "quicktype --lang typescript --top-level Pokedex --just-types pokedex.json");
    await click("opt-just-types");
    assert.equal(await sameAsCli("just-types off again", "quicktype --lang typescript --top-level Pokedex pokedex.json"), defaultTs);
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex");

    // A language without a boolean just-types option: quicktype's defaults,
    // no just-types control or hint, no preset.
    await select("lang", "typescript-zod");
    await sameAsCli("pokedex.json → TypeScript Zod", "quicktype --lang typescript-zod --top-level Pokedex pokedex.json");
    const zod = await page.evaluate(`({
        hash: location.hash,
        justTypes: document.getElementById("opt-just-types") !== null,
        hints: document.querySelectorAll("#options .hint").length,
        presets: document.querySelectorAll("#options .preset").length,
    })`);
    assert.deepEqual(zod, { hash: "#v=2&l=typescript-zod&s=pokedex", justTypes: false, hints: 0, presets: 0 });
    console.log("ok: TypeScript Zod (no just-types option) keeps quicktype's defaults");
    await select("lang", "go");
    const goHint = await page.evaluate("document.getElementById('opt-just-types').closest('label').querySelector('.hint')?.textContent");
    assert.equal(goHint, "Off: types plus a package clause and Unmarshal/Marshal functions (quicktype's default)");
    await select("lang", "smithy4a");
    const smithy = await page.evaluate(
        "({ option: document.getElementById('opt-just-types') !== null, hints: document.querySelectorAll('#options .hint').length })",
    );
    assert.deepEqual(smithy, { option: true, hints: 0 }, "Smithy4s: its renderer ignores just-types; no hint");
    console.log(`ok: just-types hints per language (Go: "${goHint}"), none for Smithy4s`);

    // The presets the page shares with app.quicktype.io, as flags in the
    // command; moving one back to quicktype's default is explicit in the
    // hash, and a link without the key gets the preset.
    await page.navigate(`${url}#v=2&l=rust&s=pokedex`);
    await page.waitFor(settled, "the run on Rust");
    await sameAsCli("pokedex.json → Rust (preset)", "quicktype --lang rust --top-level Pokedex --density dense pokedex.json");
    assert.equal(await hashNow(), "#v=2&l=rust&s=pokedex");
    assert.equal(await page.evaluate("document.getElementById('opt-density').closest('label').querySelectorAll('.preset').length"), 1);
    await page.screenshot("preset-rust.png");
    await select("opt-density", "normal");
    await sameAsCli("pokedex.json → Rust, density back to normal", "quicktype --lang rust --top-level Pokedex pokedex.json");
    assert.equal(await hashNow(), "#v=2&l=rust&s=pokedex&density=normal");
    await page.navigate(`${url}#v=2&l=rust&s=pokedex&density=normal`);
    await page.waitFor(settled, "the run with density=normal from the hash");
    assert.equal(await page.evaluate("document.getElementById('opt-density').value"), "normal");
    await sameAsCli("density=normal from the hash", "quicktype --lang rust --top-level Pokedex pokedex.json");
    await select("lang", "swift");
    await sameAsCli("pokedex.json → Swift (preset)", "quicktype --lang swift --top-level Pokedex --no-initializers pokedex.json");
    assert.equal(await page.evaluate("document.getElementById('opt-initializers').checked"), false);
    await click("opt-initializers");
    await sameAsCli("pokedex.json → Swift, initializers back on", "quicktype --lang swift --top-level Pokedex pokedex.json");
    assert.equal(await hashNow(), "#v=2&l=swift&s=pokedex&initializers=true");
    await select("lang", "objc");
    await sameAsCli("pokedex.json → Objective-C (preset)", "quicktype --lang objc --top-level Pokedex --extra-comments pokedex.json");
    assert.equal(await hashNow(), "#v=2&l=objc&s=pokedex");
    assert.equal(await page.evaluate("document.querySelector('#options .more')?.open ?? false"), false, "More options opened");
    console.log("ok: presets as on app.quicktype.io (Rust, Swift, Objective-C); one moved back is explicit in the hash");

    // A link from before the presets (no `v`) means quicktype's defaults,
    // and is rewritten as a link that says so; a new link gets the presets.
    for (const [old, command, rewritten] of [
        ["#l=rust&s=pokedex", "quicktype --lang rust --top-level Pokedex pokedex.json", "#v=2&l=rust&s=pokedex&density=normal"],
        ["#l=swift&s=pokedex", "quicktype --lang swift --top-level Pokedex pokedex.json", "#v=2&l=swift&s=pokedex&initializers=true"],
        ["#l=objc&s=pokedex&extra-comments=true", "quicktype --lang objc --top-level Pokedex --extra-comments pokedex.json", "#v=2&l=objc&s=pokedex"],
    ]) {
        await page.navigate(`${url}${old}`);
        await page.waitFor(settled, `the run for the old link ${old}`);
        await sameAsCli(`old link ${old}`, command);
        assert.equal(await hashNow(), rewritten);
        assert.deepEqual(await engineSwitch(), { engine: "wasm", checked: "wasm", focused: null }, `old link ${old}: the engine`);
    }

    await page.navigate(`${url}#v=2&l=swift&s=pokedex`);
    await page.waitFor(settled, "the run for a new Swift link");
    await sameAsCli("new link #v=2&l=swift&s=pokedex", "quicktype --lang swift --top-level Pokedex --no-initializers pokedex.json");
    console.log("ok: links without v= get quicktype's defaults (and are rewritten with v=2); links with it get the presets");
    console.log("ok: links without e= (old ones too) run on quickertype");

    // The general options: labelled as in the CLI's --help, all off there
    // too; each one alone, and combined, gives the CLI's output with the
    // same flags, and comes back from the hash.
    const help = execFileSync(cli, ["--help"], { encoding: "utf8" });
    const generalControls = await page.evaluate(
        `[...document.querySelectorAll("#general-options label")].map((l) => ({ flag: l.title, label: l.textContent }))`,
    );
    assert.equal(generalControls.length, 10);
    const escape = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    for (const { flag, label } of generalControls) {
        assert.match(help, new RegExp(`^ ${escape(flag)} +${escape(label)}\\.`, "m"), `${flag} in --help`);
    }
    console.log(`ok: general options labelled as in --help: ${generalControls.map((c) => c.flag).join(" ")}`);

    await page.navigate(`${url}#v=2&l=typescript&s=pokedex`);
    await page.waitFor(settled, "the run on TypeScript");
    await page.evaluate("document.querySelector('#general summary').click()");
    const generalCases = [
        ["pokedex", "Pokedex", "all-properties-optional"],
        ["pokedex", "Pokedex", "alphabetize-properties"],
        ["pokedex", "Pokedex", "no-enums"],
        ["github-events", "GithubEvents", "no-date-times"],
        ["github-events", "GithubEvents", "no-combine-classes"],
        ["kitchen-sink", "KitchenSink", "no-maps"],
    ];
    let current = "pokedex";
    let without = defaultTs;
    for (const [sample, name, flag] of generalCases) {
        if (sample !== current) {
            await select("sample", sample);
            without = await sameAsCli(`${sample}.json → TypeScript`, `quicktype --lang typescript --top-level ${name} ${sample}.json`);
            current = sample;
        }

        await click(`general-${flag}`);
        const withFlag = await sameAsCli(
            `${sample}.json → TypeScript, --${flag}`,
            `quicktype --lang typescript --top-level ${name} --${flag} ${sample}.json`,
        );
        assert.notEqual(withFlag, without, `--${flag} changed nothing`);
        assert.equal(await hashNow(), `#v=2&l=typescript&s=${sample}&${flag}=true`);
        assert.equal(await page.evaluate("document.getElementById('general-count').textContent"), "1 on");
        await click(`general-${flag}`);
    }

    // Two at once, with the hash round trip; and with a preset.
    await select("sample", "pokedex");
    await andRun(
        "document.getElementById('general-all-properties-optional').click(); document.getElementById('general-no-enums').click()",
        "a run with two general options",
    );
    await sameAsCli(
        "pokedex.json → TypeScript, --all-properties-optional --no-enums",
        "quicktype --lang typescript --top-level Pokedex --all-properties-optional --no-enums pokedex.json",
    );
    const twoHash = await hashNow();
    assert.equal(twoHash, "#v=2&l=typescript&s=pokedex&all-properties-optional=true&no-enums=true");
    await page.navigate(`${url}${twoHash}`);
    await page.waitFor(settled, "the run with two general options from the hash");
    const restoredGeneral = await page.evaluate(`({
        open: document.getElementById("general").open,
        count: document.getElementById("general-count").textContent,
        on: [...document.querySelectorAll("#general-options input")].filter((i) => i.checked).map((i) => i.dataset.general),
    })`);
    assert.deepEqual(restoredGeneral, { open: true, count: "2 on", on: ["all-properties-optional", "no-enums"] });
    await sameAsCli(
        "two general options from the hash",
        "quicktype --lang typescript --top-level Pokedex --all-properties-optional --no-enums pokedex.json",
    );
    await page.screenshot("general-open.png");
    const wide = await commandShown("the command with two general options");
    console.log(`ok: the command is shown whole on ${wide.lines} line(s) at 1440 px, and copied as one line`);
    // Closed by the user, General stays closed through re-renders (another
    // sample, another kind of input) and while its options change.
    await page.evaluate("document.querySelector('#general summary').click()");
    await select("sample", "kitchen-sink");
    await andRun("document.getElementById('general-no-maps').click()", "a run with a third general option");
    const closed = await page.evaluate(`({
        open: document.getElementById("general").open,
        count: document.getElementById("general-count").textContent,
    })`);
    assert.deepEqual(closed, { open: false, count: "3 on" });
    await sameAsCli(
        "kitchen-sink.json → TypeScript, three general options, General closed",
        "quicktype --lang typescript --top-level KitchenSink --all-properties-optional --no-maps --no-enums kitchen-sink.json",
    );
    console.log("ok: a link with general options opens General; closed by the user, it stays closed");
    // The Options button counts the options changed, general and the
    // language's, however they change: a general option, a renderer
    // option, another language (whose options start from its defaults).
    const badge = () =>
        page.evaluate("(() => { const c = document.getElementById('options-count'); return c.hidden ? 0 : Number(/\\d+/.exec(c.textContent)[0]); })()");
    const badges = [await badge()];
    await click("opt-just-types");
    badges.push(await badge());
    await select("lang", "rust");
    badges.push(await badge());
    for (const flag of ["all-properties-optional", "no-maps", "no-enums"]) {
        await click(`general-${flag}`);
        badges.push(await badge());
    }
    assert.deepEqual(badges, [3, 4, 3, 2, 1, 0], "the Options button's count");
    console.log(`ok: the Options button counts the options changed: ${badges.join(", ")}`);
    await page.navigate(`${url}#v=2&l=rust&s=github-events&alphabetize-properties=true&no-date-times=true`);
    await page.waitFor(settled, "the run on Rust with two general options");
    await sameAsCli(
        "github-events.json → Rust, --alphabetize-properties --no-date-times and the preset",
        "quicktype --lang rust --top-level GithubEvents --alphabetize-properties --no-date-times --density dense github-events.json",
    );

    // --no-ignore-json-refs: `$ref`s in an uploaded JSON file are references.
    await page.navigate(`${url}#v=2&l=typescript`);
    await page.waitFor(settled, "the run before the upload");
    await upload(path.join(repositoryRoot, sampleFiles["2465e.json"]));
    const refsIgnored = await sameAsCli("uploaded 2465e.json → TypeScript", "quicktype --lang typescript --top-level T2465e 2465e.json");
    await click("general-no-ignore-json-refs");
    const refsFollowed = await sameAsCli(
        "uploaded 2465e.json → TypeScript, --no-ignore-json-refs",
        "quicktype --lang typescript --top-level T2465e --no-ignore-json-refs 2465e.json",
    );
    assert.notEqual(refsFollowed, refsIgnored, "--no-ignore-json-refs changed nothing");

    // The renderer options set the range of integers read from JSON, as on
    // the CLI: with Rust's `integer-type: force-i32`, whole numbers beyond
    // 32 bits are read as doubles.
    await page.navigate(`${url}#v=2&l=rust&integer-type=force-i32`);
    await page.waitFor(settled, "the run before the upload");
    await upload(path.join(repositoryRoot, sampleFiles["32431.json"]));
    const forceI32 = await sameAsCli(
        "uploaded 32431.json → Rust, --integer-type force-i32",
        "quicktype --lang rust --top-level T32431 --density dense --integer-type force-i32 32431.json",
    );
    assert.match(forceI32, /pub time: f64,/);

    // A run on the same input, read the same way, reuses the input both
    // engines read before (the worker's `reused`): a change of language that
    // keeps the date/time recognizer and the range of integers (Go, C#,
    // Java) only generates the code, on quickertype and on quicktype; a
    // language that reads dates differently (Kotlin), an option that changes
    // how the input is read (--no-ignore-json-refs) and another text read it
    // again. The output is the CLI's either way.
    const reading = (engine = "wasm") =>
        page.evaluate(`(() => {
            const result = playground.view.results["${engine}"]?.result;
            return { reused: result?.reused, read: result?.inputTimes?.[0] > 0 };
        })()`);
    await page.navigate(`${url}#v=2&l=go&s=pokedex`);
    await page.waitFor(settled, "the run on Go");
    assert.deepEqual(await reading(), { reused: false, read: true }, "a first run reads its input");
    await select("lang", "cs");
    await sameAsCli("pokedex.json → C#, on the input read for Go", "quicktype --lang cs --top-level Pokedex pokedex.json");
    assert.deepEqual(await reading(), { reused: true, read: false }, "Go → C# reuses the input read");
    let switched = await switchEngine("ts", "the switch to quicktype, on C#");
    assert.deepEqual(switched, { wasm: 0, ts: 1 });
    assert.deepEqual(await reading("ts"), { reused: false, read: true }, "quicktype's first run reads its input");
    await select("lang", "java");
    await sameAsCli("pokedex.json → Java on quicktype, on the input read for C#", "quicktype --lang java --top-level Pokedex pokedex.json", "ts");
    assert.deepEqual(await reading("ts"), { reused: true, read: false }, "quicktype: C# → Java reuses the input read");
    switched = await switchEngine("wasm", "the switch back to quickertype, on Java");
    assert.deepEqual(switched, { wasm: 1, ts: 0 });
    assert.deepEqual(await reading(), { reused: true, read: false }, "quickertype: C# → Java reuses the input read");
    assert.match(
        await page.evaluate("[...document.querySelectorAll('#meter-details .fine p')].map((p) => p.textContent).join(' ')"),
        /reuses the input both engines read before, so it only generates the code/,
    );
    await select("lang", "kotlin");
    await sameAsCli("pokedex.json → Kotlin, which reads dates its own way", "quicktype --lang kotlin --top-level Pokedex pokedex.json");
    assert.deepEqual(await reading(), { reused: false, read: true }, "Kotlin reads the input again");
    await select("lang", "go");
    assert.deepEqual(await reading(), { reused: false, read: true }, "Go after Kotlin reads the input again");
    await click("general-no-ignore-json-refs");
    assert.deepEqual(await reading(), { reused: false, read: true }, "--no-ignore-json-refs reads the input again");
    await click("general-no-ignore-json-refs");
    assert.deepEqual(await reading(), { reused: false, read: true }, "--ignore-json-refs again reads the input again");
    await click("general-all-properties-optional");
    assert.deepEqual(await reading(), { reused: true, read: false }, "--all-properties-optional reuses the input read");
    await click("general-all-properties-optional");
    await andRun(
        `(() => {
            const input = document.getElementById("input");
            input.value = '{"pokemon": [{"id": 1, "name": "Bulbasaur"}]}';
            input.dispatchEvent(new Event("input", { bubbles: true }));
        })()`,
        "a run on another text",
    );
    assert.deepEqual(await reading(), { reused: false, read: true }, "another text is read");
    console.log("ok: a change of language or of an option that does not change reading reuses the input read, on both engines (the page says so); Kotlin, --no-ignore-json-refs and another text read it again");

    // The footer: the quicktype commit the output matches, linked.
    const { commit } = quicktypeReference();
    const version = await page.evaluate(`({
        href: document.querySelector("#version a").href,
        text: document.getElementById("version").textContent,
        date: document.querySelector("#version time").dateTime,
    })`);
    assert.equal(version.href, `https://github.com/glideapps/quicktype/commit/${commit}`);
    assert.ok(version.text.startsWith(`Output matches quicktype at commit ${commit.slice(0, 7)} (`), version.text);
    assert.match(version.text, /newer than the v26\.0\.0 release behind npx quicktype and app\.quicktype\.io/);
    const checkout = [process.env.QUICKTYPE_REFERENCE, path.join(repositoryRoot, "..", "quicktype"), path.join(repositoryRoot, "..", "..", "quicktype")]
        .filter((d) => d !== undefined && d !== "self")
        .find((d) => fs.existsSync(path.join(d, ".git")));
    const commitDate =
        checkout === undefined
            ? undefined
            : spawnSync("git", ["-C", checkout, "log", "-1", "--date=format-local:%Y-%m-%d", "--format=%cd", commit], {
                  encoding: "utf8",
                  env: { ...process.env, TZ: "UTC" },
              }).stdout.trim() || undefined;
    if (commitDate !== undefined) assert.equal(version.date, commitDate, `the date of ${commit}`);
    console.log(
        `ok: footer: ${version.text}${commitDate === undefined ? " (no quicktype checkout to check the date against)" : ` (date checked in ${checkout})`}`,
    );

    await page.navigate(`${url}#v=2&l=rust&s=pokedex`);
    await page.waitFor(settled, "the run on Rust");
    // What the live region says from here on (checked after the warm runs).
    await watchLive();
    await select("lang", "typescript");
    await sameAsCli("pokedex.json → TypeScript", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    await page.screenshot("desktop-light.png");

    // Switching to quicktype: the same input and options on quicktype's
    // TypeScript engine, in a worker of its own; only it runs, and the page
    // then compares both engines' results. Back on quickertype, nothing runs.
    let ran = await switchEngine("ts", "the switch to quicktype");
    assert.deepEqual(ran, { wasm: 0, ts: 1 }, "the switch to quicktype ran");
    await sameAsCli("pokedex.json → TypeScript on quicktype", "quicktype --lang typescript --top-level Pokedex pokedex.json", "ts");
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex&e=quicktype");
    let compare = await comparedIdentical("quicktype after quickertype");
    console.log(`ok: switched to quicktype: only quicktype ran; ${compare}`);
    const note = await page.evaluate(`(() => {
        const p = document.querySelector("#meter .cli-note");
        return p && { text: p.textContent, href: p.querySelector("a")?.getAttribute("href") };
    })()`);
    assert.deepEqual(note, {
        text: `In the browser both engines run inside this page, so the gap is smaller; on the command line quickertype is up to ${speedNow.upTo}× faster. Why`,
        href: "./benchmarks.html#browser",
    });
    console.log(`ok: the note at the comparison: "${note.text}"`);
    // Its details open and close from the keyboard (Enter on the line at a
    // glance); the focus stays there while the page draws the comparison
    // again (here, for a switch of engine), and so do the details.
    const details = () =>
        page.evaluate(`({
            expanded: document.getElementById("meter-toggle").getAttribute("aria-expanded"),
            shown: !document.getElementById("meter-details").hidden && document.getElementById("meter-details").getBoundingClientRect().height > 100,
            focused: document.activeElement.id,
        })`);
    const atFirst = await details();
    assert.deepEqual([atFirst.expanded, atFirst.shown], ["false", false], "the comparison's details, closed at first");
    await page.evaluate("document.getElementById('meter-toggle').focus()");
    await pressEnter();
    assert.deepEqual(await details(), { expanded: "true", shown: true, focused: "meter-toggle" }, "Enter on the comparison");
    await page.screenshot("layout-comparison-expanded.png");
    ran = await switchEngine("wasm", "the switch back to quickertype");
    assert.deepEqual(ran, { wasm: 0, ts: 0 }, "the switch back to quickertype ran");
    assert.deepEqual(await details(), { expanded: "true", shown: true, focused: "meter-toggle" }, "the comparison drawn again");
    await pressEnter();
    assert.deepEqual(await details(), { expanded: "false", shown: false, focused: "meter-toggle" }, "Enter on the comparison, to close it");
    console.log("ok: the comparison's details open and close with Enter, and keep the focus and stay open while it is drawn again");
    await sameAsCli("pokedex.json → TypeScript on quickertype again", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex");
    await comparedIdentical("quickertype after quicktype");
    console.log("ok: back on quickertype: nothing ran, the comparison stays");

    // Warm runs: both engines, medians. The control says what it does: one
    // warm-up, then 5 timed runs per engine, one engine at a time; and it
    // does that (the requests it sends, one after the other).
    const measureControl = await page.evaluate(`(() => {
        const button = document.getElementById("measure");
        return { label: button.textContent, how: document.getElementById(button.getAttribute("aria-describedby"))?.textContent };
    })()`);
    assert.deepEqual(measureControl, {
        label: "Measure warm runs (5×)",
        how: "1 warm-up, then 5 timed runs per engine; one engine at a time, never both together",
    });
    await page.evaluate(`(() => {
        globalThis.measureRequests = [];
        for (const [engine, client] of Object.entries(playground.engines)) {
            const send = client.send.bind(client);
            client.send = (worker, request) => {
                measureRequests.push({ engine, id: client.nextId, warmup: request.warmup, repeat: request.repeat });
                return send(worker, request);
            };
        }
    })()`);
    await page.evaluate("document.getElementById('measure').click()");
    await page.waitFor(measuredDone, "the warm measurement", 300_000);
    compare = await comparedIdentical("warm runs", true);
    const bench = await page.evaluate("({ wasm: playground.view.bench.wasm, ts: playground.view.bench.ts })");
    const measureRequests = await page.evaluate("measureRequests");
    assert.deepEqual(
        measureRequests.map(({ engine, warmup, repeat }) => ({ engine, warmup, repeat })),
        [{ engine: "wasm", warmup: 1, repeat: 5 }, { engine: "ts", warmup: 1, repeat: 5 }],
        "the measurement's requests",
    );
    assert.deepEqual([bench.wasm.times.length, bench.ts.times.length], [5, 5]);
    assert.ok((await spanOf("ts", measureRequests[1].id)).sent >= (await spanOf("wasm", measureRequests[0].id)).received, "the engines were measured at the same time");
    assert.match(
        await page.evaluate("document.querySelector('#meter .fine p').textContent"),
        / Each engine ran once to warm up, then 5 timed runs on this input, one engine at a time, never both together\./,
    );
    console.log(`ok: "${measureControl.label}": ${measureControl.how}; it sent one request per engine, { warmup: 1, repeat: 5 }, one after the other`);
    console.log(`ok: warm runs: ${compare}\n    quickertype ${medians(bench.wasm)}\n    quicktype   ${medians(bench.ts)}`);

    // The live region: one, outside the comparison (which was drawn again
    // and again meanwhile) and the panes, the same element all along; it
    // said each finished result once, in a few words: the run on TypeScript,
    // the comparison once quicktype had run too (not again on the switch
    // back), and the warm runs; never what was running.
    const live = await liveSaid(["generated", "compared", "warm"], "the live region");
    console.log(`ok: one live region, outside what is drawn again (the comparison, ${live.drawn} times): ${live.said.map((s) => `"${s}"`).join(", ")}`);
    await page.screenshot("compare.png");
    await page.screenshot("speed-playground-light.png");
    await page.screenshot("layout-desktop-light.png");
    await page.viewport(1440, 900, { dark: true });
    await page.screenshot("speed-playground-dark.png");
    await page.screenshot("layout-desktop-dark.png");
    await page.viewport(1440, 900);

    // A switch while warm runs are measured: its run waits its turn, after
    // the measurement's run on the other engine, never beside it; then the
    // measurement goes on, and both finish.
    await page.navigate(`${url}#v=2&l=typescript&s=pokedex`);
    await page.waitFor(`${settled} && document.body.dataset.status === "done"`, "the run before measuring");
    let counts = await runCounts();
    assert.ok(
        await whileInFlight("wasm", `document.getElementById("measure").click()`, `document.querySelector("input[name=engine][value=ts]").click()`),
        "quickertype's warm runs were over before the switch",
    );
    await page.waitFor(
        `${measuredDone} && playground.engine === "ts" && ${settled} && document.body.dataset.status === "done"`,
        "the measurement and the switch made during it",
        300_000,
    );
    await sameAsCli("a switch to quicktype during a measurement", "quicktype --lang typescript --top-level Pokedex pokedex.json", "ts");
    compare = await comparedIdentical("a switch to quicktype during a measurement", true);
    {
        const after = await runCounts();
        assert.deepEqual([after.generation, after.wasm - counts.wasm, after.ts - counts.ts], [counts.generation, 1, 2]);
        const measuredWasm = await spanOf("wasm", counts.wasm);
        const switched = await spanOf("ts", counts.ts);
        const measuredTs = await spanOf("ts", counts.ts + 1);
        assert.ok(switched.sent >= measuredWasm.received, "the switch's run started before quickertype's warm runs ended");
        assert.ok(measuredTs.sent >= switched.received, "quicktype's warm runs started before the switch's run ended");
    }
    await oneAtATime("a switch during a measurement");
    console.log(`ok: a switch during a measurement runs after quickertype's warm runs, never beside them: ${compare}`);
    ran = await switchEngine("wasm", "back to quickertype after a switch during a measurement");
    assert.deepEqual(ran, { wasm: 0, ts: 0 }, "back to quickertype after a switch during a measurement: it ran");

    // A JSON Schema sample.
    await select("sample", "description");
    await sameAsCli(
        "description.schema → TypeScript",
        "quicktype --src-lang schema --lang typescript --top-level Description description.schema",
    );

    // Several files: tabs.
    await select("lang", "java");
    const tabs = await page.evaluate("[...document.querySelectorAll('#tabs [role=tab]')].map((t) => t.textContent)");
    const files = await page.evaluate("playground.view.files.map((f) => f.name)");
    assert.ok(files.length > 1);
    assert.deepEqual(tabs, files);
    console.log(`ok: Java gives ${files.length} files as tabs: ${files.join(", ")}`);
    // The tabs work from the keyboard (arrow keys move between them).
    await page.evaluate("document.querySelector('#tabs [aria-selected=true]').focus()");
    for (const type of ["keyDown", "keyUp"]) {
        await page.send("Input.dispatchKeyEvent", { type, key: "ArrowRight", code: "ArrowRight", windowsVirtualKeyCode: 39 });
    }
    const tab = await page.evaluate(
        "({ selected: document.querySelector('#tabs [aria-selected=true]').textContent, focused: document.activeElement.textContent, code: document.getElementById('code').textContent === playground.view.files[1].text })",
    );
    assert.deepEqual(tab, { selected: files[1], focused: files[1], code: true });
    console.log(`ok: ArrowRight moves to the ${files[1]} tab`);
    await page.viewport(1440, 900, { dark: true });
    await page.screenshot("desktop-dark.png");
    await page.viewport(1440, 900);

    // Invalid JSON: quicktype's error, in the output pane.
    await select("lang", "rust");
    await andRun("document.querySelector('input[name=kind][value=json]').click()", "a run as JSON");
    // Before it, no input: the output pane says where to put one (not "on
    // the left": phones show one pane at a time, and say so; see below).
    const typeInput = (text) => `(() => {
        const input = document.getElementById("input");
        input.value = ${JSON.stringify(text)};
        input.dispatchEvent(new Event("input", { bubbles: true }));
    })()`;
    await andRun(typeInput(""), "no input", `${settled} && document.body.dataset.status === "empty"`);
    const emptyWide = await page.evaluate("document.getElementById('error').innerText.trim()");
    assert.equal(emptyWide, "Paste JSON or a JSON Schema in the Input pane, load a sample, or drop a file there.", "no input, at 1440 px");
    console.log(`ok: no input: "${emptyWide}"`);
    const invalid = '{\n  "name": "Ann",\n  "age": 7,\n}';
    await andRun(
        typeInput(invalid),
        "the error",
        `${settled} && document.body.dataset.status === "error"`,
    );
    const error = await page.evaluate(
        "({ visible: !document.getElementById('error').hidden, text: document.querySelector('.error-message')?.textContent, kind: document.querySelector('.error-kind')?.textContent })",
    );
    assert.ok(error.visible);
    assert.match(error.text, /^Syntax error in input JSON Description: Expected double-quoted property name/);
    assert.equal(error.kind, "MiscJSONParseError");
    console.log(`ok: invalid JSON shows: ${error.text}`);
    // The error is an alert, drawn (and said) once per result: not again
    // while quicktype runs the same input, once for quicktype's own.
    await page.evaluate(`(() => {
        globalThis.errorDrawn = 0;
        new MutationObserver(() => errorDrawn++).observe(document.getElementById("error"), { childList: true });
    })()`);
    await switchEngine("ts", "quicktype on invalid JSON");
    const tsError = await page.evaluate("({ drawn: errorDrawn, role: document.getElementById('error').getAttribute('role'), engine: playground.view.shown.engine })");
    assert.deepEqual(tsError, { drawn: 1, role: "alert", engine: "ts" }, "quicktype's error on invalid JSON");
    await switchEngine("wasm", "back to quickertype on invalid JSON");
    console.log("ok: an error is drawn, as an alert, once per result");

    // The input survives a reload (localStorage); the hash keeps the rest.
    const hash = await page.evaluate("location.hash");
    await page.navigate(`${url}${hash}`);
    await page.waitFor(settled, "the run after reloading");
    const restored = await page.evaluate("document.getElementById('input').value");
    assert.equal(restored, invalid);
    console.log(`ok: reload restores the input (${hash})`);

    // A link to quicktype: the switch comes back from the hash, and only
    // quicktype's worker loads; nothing downloads the .wasm.
    const firstRequest = requests.length;
    await page.navigate(`${url}#v=2&l=typescript&s=pokedex&e=quicktype`);
    await page.waitFor(`${settled} && document.body.dataset.status === "done"`, "the run on quicktype alone");
    await sameAsCli("a link to quicktype: pokedex.json → TypeScript", "quicktype --lang typescript --top-level Pokedex pokedex.json", "ts");
    const alone = await page.evaluate(`({
        hash: location.hash,
        wasmWorker: playground.engines.wasm.worker !== undefined,
        compare: document.body.dataset.compare,
        hint: document.querySelector("#meter .fine p").textContent,
    })`);
    assert.deepEqual(
        { ...alone, hint: /^Switch to quickertype to compare the engines on this input, or measure warm runs of both\./.test(alone.hint) },
        { hash: "#v=2&l=typescript&s=pokedex&e=quicktype", wasmWorker: false, compare: "off", hint: true },
    );
    assert.deepEqual(await engineSwitch(), { engine: "ts", checked: "ts", focused: null });
    const loaded = requests.slice(firstRequest).map(([, p]) => p);
    assert.ok(loaded.some((p) => /\/worker-[0-9a-f]+\.js$/.test(p)), `quicktype's worker was not loaded: ${loaded.join(" ")}`);
    assert.deepEqual(loaded.filter((p) => p.endsWith(".wasm")), [], "the .wasm was downloaded with only quicktype running");
    console.log(`ok: a link to quicktype: its output, and no .wasm downloaded (${loaded.length} requests: ${loaded.join(" ")})`);
    await page.screenshot("quicktype.png");

    // The arrow keys move between the engines (native radio buttons): to
    // quickertype, which runs the input it has not run yet; and back to
    // quicktype, which has, so nothing runs.
    await page.evaluate("document.querySelector('input[name=engine]:checked').focus()");
    ran = await switchEngine("wasm", "ArrowRight to quickertype", () => press("ArrowRight", 39));
    assert.deepEqual(ran, { wasm: 1, ts: 0 }, "ArrowRight to quickertype ran");
    assert.deepEqual(await engineSwitch(), { engine: "wasm", checked: "wasm", focused: "wasm" });
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex");
    await sameAsCli("ArrowRight: pokedex.json → TypeScript on quickertype", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    await comparedIdentical("quickertype after a link to quicktype");
    ran = await switchEngine("ts", "ArrowLeft to quicktype", () => press("ArrowLeft", 37));
    assert.deepEqual(ran, { wasm: 0, ts: 0 }, "ArrowLeft back to quicktype ran");
    assert.deepEqual(await engineSwitch(), { engine: "ts", checked: "ts", focused: "ts" });
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex&e=quicktype");
    await sameAsCli("ArrowLeft: pokedex.json → TypeScript on quicktype", "quicktype --lang typescript --top-level Pokedex pokedex.json", "ts");
    console.log("ok: the arrow keys move between the engines; each runs the input only once");

    // A link from the old compare mode (`c=1`): quickertype, and both engines run.
    await page.navigate(`${url}#v=2&l=typescript&s=pokedex&c=1`);
    await page.waitFor(`${settled} && document.body.dataset.status === "done"`, "the run for a compare-mode link");
    await sameAsCli("a compare-mode link: pokedex.json → TypeScript", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    compare = await comparedIdentical("a compare-mode link");
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex");
    console.log(`ok: a link from compare mode (c=1) runs both engines: ${compare}`);

    // Renderer options from the hash: an enum, a string and both booleans,
    // one of them a secondary option ("More options").
    await page.navigate(
        `${url}#v=2&l=cs&s=pokedex&namespace=Pokemon.Models&framework=NewtonSoft&density=dense&virtual=true&dateonly-timeonly-converters=false&bogus=1`,
    );
    await page.waitFor(settled, "the run with options");
    await sameAsCli(
        "pokedex.json → C# with options",
        "quicktype --lang cs --top-level Pokedex --framework NewtonSoft --density dense --namespace Pokemon.Models --virtual --no-dateonly-timeonly-converters pokedex.json",
    );
    const controls = await page.evaluate(`({
        namespace: document.getElementById("opt-namespace").value,
        density: document.getElementById("opt-density").value,
        virtual: document.getElementById("opt-virtual").checked,
        more: document.querySelector(".more").open,
        hash: location.hash,
    })`);
    assert.deepEqual(controls, {
        namespace: "Pokemon.Models",
        density: "dense",
        virtual: true,
        more: true,
        hash: "#v=2&l=cs&s=pokedex&framework=NewtonSoft&density=dense&namespace=Pokemon.Models&virtual=true&dateonly-timeonly-converters=false",
    });

    // A file too large for the editor, opened with the file picker.
    const senators = JSON.parse(fs.readFileSync(path.join(repositoryRoot, sampleFiles["us-senators.json"]), "utf8"));
    const big = path.join(fs.mkdtempSync(path.join(os.tmpdir(), "qt-site-input-")), "big-senators.json");
    fs.writeFileSync(big, JSON.stringify(Array.from({ length: 12 }, () => senators), undefined, 2));
    sampleFiles["big-senators.json"] = big;
    await select("lang", "rust");
    const { result: picker } = await page.send("Runtime.evaluate", { expression: "document.getElementById('file')" });
    const before = await page.evaluate("playground.generation");
    await page.send("DOM.setFileInputFiles", { files: [big], objectId: picker.objectId });
    await page.waitFor(`playground.generation > ${before} && ${settled}`, "the run on the uploaded file");
    const large = await page.evaluate(
        "({ panel: !document.getElementById('large').hidden, editor: !document.getElementById('input').hidden, info: document.getElementById('input-info').textContent })",
    );
    assert.deepEqual([large.panel, large.editor], [true, false], "a large file is shown as a panel, not in the editor");
    await sameAsCli(
        `uploaded big-senators.json (${(fs.statSync(big).size / 1e6).toFixed(1)} MB) → Rust`,
        "quicktype --lang rust --top-level BigSenators --density dense big-senators.json",
    );
    ran = await switchEngine("ts", "quicktype on the large file");
    assert.deepEqual(ran, { wasm: 0, ts: 1 }, "the switch to quicktype on the large file ran");
    await sameAsCli(
        "uploaded big-senators.json → Rust on quicktype",
        "quicktype --lang rust --top-level BigSenators --density dense big-senators.json",
        "ts",
    );
    await comparedIdentical("the large file");
    await page.evaluate("document.getElementById('measure').click()");
    await page.waitFor(measuredDone, "the warm measurement on the large file", 600_000);
    const bigCompare = await comparedIdentical("the large file, warm runs", true);
    const bigBench = await page.evaluate("({ wasm: playground.view.bench.wasm, ts: playground.view.bench.ts })");
    console.log(`ok: large file, warm runs: ${bigCompare}\n    quickertype ${medians(bigBench.wasm)}\n    quicktype   ${medians(bigBench.ts)}`);
    ran = await switchEngine("wasm", "back to quickertype on the large file");
    assert.deepEqual(ran, { wasm: 0, ts: 0 }, "the switch back to quickertype on the large file ran");

    // A run under way (another language) while the engine is switched: the
    // page re-renders mid-run, and must draw the new request's result, from
    // the engine picked, which runs after the run under way, not beside it.
    counts = await runCounts();
    await andRun(
        `(() => {
            const lang = document.getElementById("lang");
            lang.value = "go";
            lang.dispatchEvent(new Event("change", { bubbles: true }));
            document.querySelector("input[name=engine][value=ts]").click();
        })()`,
        "the run during which the engine was switched",
        `${settled} && playground.engine === "ts" && document.body.dataset.status === "done"`,
    );
    const drawn = await page.evaluate(`({
        lang: playground.view.shown.lang.names[0],
        same: document.getElementById("code").textContent === playground.view.files[playground.view.tab].text,
        go: playground.view.files[0].text.includes("package main"),
        engine: playground.view.shown.engine,
    })`);
    assert.deepEqual(drawn, { lang: "go", same: true, go: true, engine: "ts" });
    {
        const first = await spanOf("wasm", counts.wasm);
        const second = await spanOf("ts", counts.ts);
        assert.ok(second.sent >= first.received, "quicktype started before quickertype's run of the same input ended");
    }
    await sameAsCli("big-senators.json → Go on quicktype", "quicktype --lang go --top-level BigSenators big-senators.json", "ts");
    ran = await switchEngine("wasm", "back to quickertype after a switch during a run");
    assert.deepEqual(ran, { wasm: 0, ts: 0 }, "the switch back to quickertype after a switch during a run ran");
    await sameAsCli("big-senators.json → Go on quickertype", "quicktype --lang go --top-level BigSenators big-senators.json");
    await comparedIdentical("Go after a switch during a run");
    console.log("ok: the engine switched during a run: the new result is drawn, and Copy/Download give what is shown");

    // A measurement asked for while a run is under way waits for it, measures
    // what it shows, and the page does not stay "Running".
    await andRun(
        `(() => {
            const lang = document.getElementById("lang");
            lang.value = "rust";
            lang.dispatchEvent(new Event("change", { bubbles: true }));
            document.getElementById("measure").click();
        })()`,
        "the run during which a measurement was asked for",
        `${settled} && document.body.dataset.status === "done"`,
    );
    await page.waitFor(measuredDone, "the measurement asked for during a run", 600_000);
    await new Promise((resolve) => setTimeout(resolve, 400));
    const measuredRun = await page.evaluate(`({
        status: document.body.dataset.status,
        running: document.getElementById("meter").textContent.includes("Running"),
        lang: playground.view.shown.lang.names[0],
        same: playground.view.bench.wasm.files[0].text === playground.view.files[0].text,
        runs: [playground.view.bench.wasm.times.length, playground.view.bench.ts.times.length],
    })`);
    assert.deepEqual(measuredRun, { status: "done", running: false, lang: "rust", same: true, runs: [5, 5] });
    await comparedIdentical("a measurement asked for during a run", true);
    console.log("ok: a measurement asked for during a run measures the result shown; nothing stays running");

    // The worker fails after it loaded, during a run: that run shows a
    // readable error, and the next run gets a new worker.
    await andRun(
        `(async () => {
            const lang = document.getElementById("lang");
            lang.value = "go";
            lang.dispatchEvent(new Event("change", { bubbles: true }));
            const client = playground.engines.wasm;
            while (client.inFlight === undefined) await new Promise((resolve) => setTimeout(resolve, 0));
            globalThis.failedWorker = client.worker;
            client.worker.dispatchEvent(new ErrorEvent("error", { message: "simulated failure" }));
        })()`,
        "the run whose worker failed",
        `${settled} && document.body.dataset.status === "error"`,
    );
    const failure = await page.evaluate("document.querySelector('.error-message')?.textContent");
    assert.equal(failure, "The WebAssembly worker stopped (simulated failure); the next run starts a new one.");
    await select("lang", "rust");
    assert.ok(await page.evaluate("playground.engines.wasm.worker !== globalThis.failedWorker"), "the worker was not replaced");
    await sameAsCli(
        "after the worker failed, a new one: big-senators.json → Rust",
        "quicktype --lang rust --top-level BigSenators --density dense big-senators.json",
    );
    console.log(`ok: a worker failing after it loaded: "${failure}"`);

    // A worker failing is not that engine's result: shown, not kept. A
    // switch away and back runs the input again, on a new worker.
    let caught;
    ran = await switchEngine("ts", "a switch to quicktype whose worker fails", async () => {
        caught = await whileInFlight(
            "ts",
            `document.querySelector("input[name=engine][value=ts]").click()`,
            `globalThis.failedTs = client.worker; client.worker.dispatchEvent(new ErrorEvent("error", { message: "simulated failure" }))`,
        );
    });
    assert.ok(caught, "quicktype's run was over before its worker could fail");
    assert.deepEqual(ran, { wasm: 0, ts: 1 });
    const tsFailure = await page.evaluate(`({
        status: document.body.dataset.status,
        message: document.querySelector(".error-message")?.textContent,
        kept: playground.view.results.ts !== undefined,
    })`);
    assert.deepEqual(tsFailure, {
        status: "error",
        message: "The TypeScript worker stopped (simulated failure); the next run starts a new one.",
        kept: false,
    });
    ran = await switchEngine("wasm", "back to quickertype after quicktype's worker failed");
    assert.deepEqual(ran, { wasm: 0, ts: 0 });
    await sameAsCli("back on quickertype after quicktype's worker failed: big-senators.json → Rust", "quicktype --lang rust --top-level BigSenators --density dense big-senators.json");
    ran = await switchEngine("ts", "quicktype again after its worker failed");
    assert.deepEqual(ran, { wasm: 0, ts: 1 }, "quicktype again after its worker failed: it ran");
    assert.ok(await page.evaluate("playground.engines.ts.worker !== globalThis.failedTs"), "quicktype's worker was not replaced");
    await sameAsCli("quicktype again after its worker failed: big-senators.json → Rust", "quicktype --lang rust --top-level BigSenators --density dense big-senators.json", "ts");
    await comparedIdentical("quicktype again after its worker failed");
    console.log(`ok: a worker failure is shown, not kept ("${tsFailure.message}"); switching back runs again, on a new worker`);

    // A worker failing during a measurement stops it, with a message; the
    // results shown and kept stay; measuring again works.
    assert.ok(
        await whileInFlight(
            "wasm",
            `document.getElementById("measure").click()`,
            `client.worker.dispatchEvent(new ErrorEvent("error", { message: "simulated failure" }))`,
        ),
        "quickertype's warm runs were over before its worker could fail",
    );
    await page.waitFor("document.querySelector('#meter .bench-failure') !== null", "the measurement's failure");
    const benchFailure = await page.evaluate(`({
        text: document.querySelector("#meter .bench-failure").textContent,
        button: document.getElementById("measure").getAttribute("aria-disabled"),
        status: document.body.dataset.status,
        engine: playground.view.shown.engine,
        kept: [playground.view.results.wasm?.result.ok, playground.view.results.ts?.result.ok],
        compare: document.body.dataset.compare,
    })`);
    assert.deepEqual(benchFailure, {
        text: "Measuring warm runs stopped: The WebAssembly worker stopped (simulated failure); the next run starts a new one.",
        button: null,
        status: "done",
        engine: "ts",
        kept: [true, true],
        compare: "identical",
    });
    await page.evaluate("document.getElementById('measure').click()");
    await page.waitFor(measuredDone, "measuring again after a worker failed", 600_000);
    await comparedIdentical("measuring again after a worker failed", true);
    console.log(`ok: a worker failing during a measurement: "${benchFailure.text}"; the results stay, and measuring again works`);

    // A sample that does not load: no current input, so switching engine
    // runs nothing, and the error stays.
    await page.evaluate(`(() => {
        const fetchFile = globalThis.fetch;
        globalThis.fetch = (resource, ...rest) =>
            String(resource).includes("samples/reddit") ? Promise.reject(new TypeError("simulated network failure")) : fetchFile(resource, ...rest);
    })()`);
    await select("sample", "reddit");
    const sampleError = "Could not load the sample samples/reddit.json: simulated network failure";
    const notLoaded = () =>
        page.evaluate(`({
            status: document.body.dataset.status,
            message: document.querySelector(".error-message")?.textContent,
            request: playground.view.request === undefined,
        })`);
    assert.deepEqual(await notLoaded(), { status: "error", message: sampleError, request: true });
    for (const engine of ["wasm", "ts"]) {
        ran = await switchEngine(engine, `a switch to ${engine} after a sample did not load`);
        assert.deepEqual(ran, { wasm: 0, ts: 0 }, `a switch to ${engine} after a sample did not load ran`);
        assert.deepEqual(await notLoaded(), { status: "error", message: sampleError, request: true });
    }
    console.log("ok: after a sample does not load, switching engine runs nothing and the error stays");

    // Opening files as a user does: "Open file", the browser's file chooser,
    // a file picked. The file input is reset each time, so picking the same
    // file again runs it again; a file the chooser's filter (accept) leaves
    // out still opens, as JSON.
    const chosenDir = fs.mkdtempSync(path.join(os.tmpdir(), "qt-site-chosen-"));
    cleanUp.push(chosenDir);
    const chosen = (name, content) => {
        const file = path.join(chosenDir, name);
        fs.writeFileSync(file, content);
        sampleFiles[name] = file;
        return file;
    };
    const readInput = (name) => fs.readFileSync(path.join(repositoryRoot, sampleFiles[name]));
    await page.viewport(1440, 900);
    await page.navigate(`${url}#v=2&l=typescript`);
    await page.waitFor(settled, "the run before opening files");
    const senatorsFile = chosen("senators.json", readInput("us-senators.json"));
    for (const again of ["", " again"]) {
        await openFile(senatorsFile);
        await sameAsCli(`Open file: senators.json${again}`, "quicktype --lang typescript --top-level Senators senators.json");
    }
    await openFile(chosen("description.schema", readInput("description.schema")));
    await sameAsCli("Open file: description.schema", "quicktype --src-lang schema --lang typescript --top-level Description description.schema");
    await openFile(chosen("pokedex.backup", readInput("pokedex.json")));
    await sameAsCli("Open file: pokedex.backup (outside the chooser's filter)", "quicktype --lang typescript --top-level Pokedex pokedex.backup");
    console.log("ok: Open file through the browser's file chooser: JSON, the same file twice, JSON Schema, an extension outside the filter");

    // A large file (26 MB, ~100k small records with long strings) never
    // passes through the page's main thread: the page posts the File to the
    // workers, which read it. No main-thread task takes over 200 ms from
    // opening it to both engines' results, which are the CLI's.
    const rulings = rulingsJson(26.5e6);
    const rulingsFile = chosen("rulings.json", rulings.text);
    await page.evaluate(`(() => {
        globalThis.longTasks = [];
        new PerformanceObserver((list) => {
            for (const entry of list.getEntries()) longTasks.push(Math.round(entry.duration));
        }).observe({ type: "longtask" });
    })()`);
    await watchLive();
    await openFile(rulingsFile, { timeout: 300_000 });
    const largeOpened = await page.evaluate(`({
        posted: playground.view.request.file instanceof File && playground.view.request.file.name,
        text: "text" in playground.view.request,
        kept: playground.state.text.length,
        panel: !document.getElementById("large").hidden && !document.getElementById("large-name").hidden,
        name: document.getElementById("large-name").textContent,
        size: document.getElementById("large-size").textContent,
        status: document.getElementById("large-status").textContent,
    })`);
    assert.deepEqual(
        { ...largeOpened, status: undefined },
        { posted: "rulings.json", text: false, kept: 0, panel: true, name: "rulings.json", size: "26.5 MB", status: undefined },
        "the large file: posted as a File, not read on the page",
    );
    assert.match(largeOpened.status, /^quickertype ran it in \d[\d.]* m?s\.$/, "the large file's status");
    // Nothing to edit: the output takes more of the room.
    const largeLayout = await page.evaluate(
        `({ input: document.body.dataset.input, ratio: document.getElementById("output-pane").offsetWidth / document.getElementById("input-pane").offsetWidth })`,
    );
    assert.deepEqual({ ...largeLayout, ratio: largeLayout.ratio >= 1.9 }, { input: "large", ratio: true }, `the large file: the output is ${largeLayout.ratio.toFixed(2)}× as wide as the input`);
    await sameAsCli(`Open file: rulings.json (${(rulings.text.length / 1e6).toFixed(1)} MB, ${rulings.records} records) → TypeScript`, "quicktype --lang typescript --top-level Rulings rulings.json");
    await page.screenshot("speed-large-file.png");
    ran = await switchEngine("ts", "quicktype on the 26 MB file", undefined);
    assert.deepEqual(ran, { wasm: 0, ts: 1 }, "the switch to quicktype on the 26 MB file ran");
    await sameAsCli("Open file: rulings.json → TypeScript on quicktype", "quicktype --lang typescript --top-level Rulings rulings.json", "ts");
    await comparedIdentical("the 26 MB file");
    // Read, run (the comparison's time ticking), and run on quicktype: the live region said the two results only.
    const liveLarge = await liveSaid(["generated", "compared"], "the live region, with the 26 MB file");
    console.log(`ok: the live region, with the 26 MB file (the comparison drawn ${liveLarge.drawn} times): ${liveLarge.said.map((s) => `"${s}"`).join(", ")}`);
    await page.screenshot("layout-large-file.png");
    const longTasks = await page.evaluate("longTasks");
    const longest = Math.max(0, ...longTasks);
    assert.ok(longest <= 200, `a main-thread task took ${longest} ms with the 26 MB file (long tasks: ${longTasks.join(", ")} ms)`);
    console.log(`ok: the 26 MB file is posted as a File and read in the workers; the longest main-thread task: ${longTasks.length === 0 ? "none over 50 ms" : `${longest} ms`}`);
    ran = await switchEngine("wasm", "back to quickertype on the 26 MB file");
    assert.deepEqual(ran, { wasm: 0, ts: 0 });
    // A change of a reading option on the large file reads it again, and
    // the input read before is let go first (its samples freed in the
    // engine), so nothing is evicted, even with the engine's limit on what
    // its inputs hold together (256 MiB) set far below the file's form
    // (12 MB) here: an input that is gone but not finalized yet would
    // otherwise have its tables copied out first.
    const limited = await page.evaluate(`playground.engines.wasm.run({ ...playground.view.request, heldLimit: 1 << 20 }).then((r) => ({ ok: r.ok, reused: r.reused, evicted: r.evicted }))`);
    assert.deepEqual(limited, { ok: true, reused: true, evicted: 0 }, "a run on the input read before, with a 1 MiB limit");
    const largeReading = () =>
        page.evaluate(`(() => {
            const result = playground.view.results.wasm?.result;
            return { ok: result?.ok, reused: result?.reused, evicted: result?.evicted };
        })()`);
    for (const state of ["on", "off"]) {
        await click("general-no-ignore-json-refs");
        assert.deepEqual(await largeReading(), { ok: true, reused: false, evicted: 0 }, `--no-ignore-json-refs ${state} on the 26 MB file`);
    }
    await page.evaluate(`playground.engines.wasm.run({ ...playground.view.request, heldLimit: 256 * 1024 * 1024 })`);
    console.log("ok: a reading option changed on the 26 MB file reads it again and evicts nothing (the input before is let go)");

    // Files that cannot be read as text: one larger than a browser's
    // longest string (its size faked: no multi-GB file is written), and one
    // whose reading fails; through the file chooser and dropped. Each says
    // why in the output pane and leaves nothing running.
    await page.evaluate(`(() => {
        const size = Object.getOwnPropertyDescriptor(Blob.prototype, "size").get;
        Object.defineProperty(File.prototype, "size", { configurable: true, get() { return this.name.endsWith("huge.json") ? 3e9 : size.call(this); } });
        const text = Blob.prototype.text;
        File.prototype.text = function () {
            return this.name === "unreadable.json" ? Promise.reject(new RangeError("Invalid string length")) : text.call(this);
        };
    })()`);
    const tooLargeMessage = "This file is 3.0 GB. Browsers can't hold text this large in one piece; use the quickertype CLI, which handles multi-GB files.";
    // The input before: rulings.json, a large file.
    const largeBefore = await inputPane();
    assert.equal(largeBefore.large?.name, "rulings.json");
    await openFile(chosen("huge.json", readInput("pokedex.json")), { failing: true });
    await openFailed("a 3 GB file", { title: "huge.json is too large for the browser", message: tooLargeMessage, before: largeBefore, cli: true });
    await page.screenshot("speed-file-too-large.png");
    await openFile(chosen("unreadable.json", readInput("pokedex.json")), { failing: true });
    await openFailed("a file that cannot be read", {
        title: "Could not read unreadable.json",
        message: "Could not read unreadable.json: RangeError: Invalid string length",
        before: largeBefore,
    });
    /** Drops a file `name` with `content` on the input side (as an expression for andRun). */
    const drop = (name, content) =>
        `(() => {
            const data = new DataTransfer();
            data.items.add(new File([${JSON.stringify(content)}], ${JSON.stringify(name)}, { type: "application/json" }));
            document.getElementById("input-pane").dispatchEvent(new DragEvent("drop", { dataTransfer: data, bubbles: true, cancelable: true }));
        })()`;
    await andRun(drop("dropped-huge.json", "[1]"), "a dropped 3 GB file", `document.body.dataset.status === "error"`);
    await openFailed("a dropped 3 GB file", { title: "dropped-huge.json is too large for the browser", message: tooLargeMessage, before: largeBefore, cli: true });
    chosen("dropped.json", readInput("pokedex.json"));
    await andRun(drop("dropped.json", readInput("pokedex.json").toString("utf8")), "a dropped file");
    await sameAsCli("a dropped file: dropped.json → TypeScript", "quicktype --lang typescript --top-level Dropped dropped.json");
    console.log(`ok: a file too large for a browser, one that cannot be read, and one dropped: "${tooLargeMessage}"; the input before (rulings.json) stays the input`);

    // Typed input survives a file that cannot be opened: it stays the input,
    // in the editor and saved; the next change runs it, and a reload brings
    // it back.
    const typed = '{"typed": [1, 2, 3], "name": "Ann"}';
    await andRun(
        `(() => {
            const input = document.getElementById("input");
            input.value = ${JSON.stringify(typed)};
            input.dispatchEvent(new Event("input", { bubbles: true }));
        })()`,
        "a run on typed input",
        `${settled} && document.body.dataset.status === "done"`,
    );
    chosen("input.json", typed);
    const typedCommand = await page.evaluate("playground.cli()");
    assert.match(typedCommand, /^quicktype --lang typescript .* input\.json$/);
    await sameAsCli("typed input", typedCommand);
    const savedTyped = `JSON.parse(localStorage.getItem("quickertype.input") ?? "null")?.text === ${JSON.stringify(typed)}`;
    await page.waitFor(savedTyped, "the typed input, saved");
    const typedBefore = await inputPane();
    assert.equal(typedBefore.editor, typed);
    await andRun(drop("dropped-huge.json", "[1]"), "a 3 GB file dropped on typed input", `document.body.dataset.status === "error"`);
    await openFailed("a 3 GB file dropped on typed input", {
        title: "dropped-huge.json is too large for the browser",
        message: tooLargeMessage,
        before: typedBefore,
        cli: true,
    });
    await select("lang", "go");
    await sameAsCli("the typed input in Go, after a file that could not be opened", typedCommand.replace("--lang typescript", "--lang go"));
    await select("lang", "typescript");
    await page.navigate(`${url}${await hashNow()}`);
    await page.waitFor(`${settled} && document.body.dataset.status === "done"`, "the run after reloading");
    assert.equal(await page.evaluate("document.getElementById('input').value"), typed, "the typed input after a reload");
    await sameAsCli("the typed input after a reload", typedCommand);
    console.log("ok: typed input survives a 3 GB file dropped on it: still in the editor and saved; the next change runs it, a reload brings it back");

    // A large file that is gone by the time a worker reads it: that engine
    // says it could not read it; the other, which read it before, keeps its
    // result.
    const goneFile = chosen("gone.json", JSON.stringify(Array.from({ length: 12 }, () => JSON.parse(readInput("us-senators.json"))), undefined, 2));
    await openFile(goneFile);
    await sameAsCli("Open file: gone.json → TypeScript", "quicktype --lang typescript --top-level Gone gone.json");
    await page.evaluate("globalThis.goneFile = playground.view.request.file");
    fs.rmSync(goneFile);
    ran = await switchEngine("ts", "quicktype on a file deleted after it was opened");
    assert.deepEqual(ran, { wasm: 0, ts: 1 });
    const gone = await page.evaluate(`({
        status: document.body.dataset.status,
        title: document.querySelector("#error .error-title")?.textContent,
        message: document.querySelector("#error .error-message")?.textContent,
        large: document.getElementById("large-status").textContent,
    })`);
    assert.equal(gone.status, "error");
    assert.equal(gone.title, "Could not read gone.json");
    assert.match(gone.message, /^Could not read gone\.json: (NotReadableError|NotFoundError): ./);
    assert.equal(gone.large, "Not run: see the output.");
    ran = await switchEngine("wasm", "back to quickertype, which read the file before");
    assert.deepEqual(ran, { wasm: 0, ts: 0 });
    assert.equal(await page.evaluate("document.body.dataset.status"), "done");
    console.log(`ok: a file deleted after it was opened: "${gone.message}"; quickertype's result, read before, stays`);

    // A worker keeps a large file's text only while requests carry that
    // file. gone.json is gone from the disk, so only the text kept can
    // answer for it: quickertype's worker does, until a sample is loaded;
    // then it has let the text go, and must read the file again, which it
    // cannot.
    const fromKeptText = () =>
        page.evaluate(`(async () => {
            const { text, ...request } = playground.view.request;
            const reply = await playground.engines.wasm.run({ ...request, file: globalThis.goneFile });
            return { ok: reply.ok, title: reply.error?.title ?? null };
        })()`);
    assert.deepEqual(await fromKeptText(), { ok: true, title: null }, "quickertype's worker did not keep the text of the file it read");
    await select("sample", "pokedex");
    await sameAsCli("a sample after gone.json", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    assert.deepEqual(await fromKeptText(), { ok: false, title: "Could not read gone.json" }, "quickertype's worker kept the large file after a sample");
    console.log("ok: a worker lets a large file's text go once a request does not carry that file (a sample)");

    // "Show in the editor" reads a large file once, however often it is
    // clicked: "Reading…" (aria-disabled) until the text is in the editor.
    // An input over 50 MB (its size faked) is not offered: the note says
    // why, and a click anyway reads nothing.
    const editorFile = chosen("editor.json", JSON.stringify(Array.from({ length: 12 }, () => JSON.parse(readInput("us-senators.json"))), undefined, 2));
    await page.evaluate(`(() => {
        globalThis.editorReads = 0;
        const size = Object.getOwnPropertyDescriptor(Blob.prototype, "size").get;
        Object.defineProperty(File.prototype, "size", { configurable: true, get() { return this.name === "editor-60mb.json" ? 60e6 : size.call(this); } });
        const text = Blob.prototype.text;
        File.prototype.text = function () {
            if (!this.name.startsWith("editor")) return text.call(this);
            editorReads++;
            return new Promise((resolve) => setTimeout(resolve, 500)).then(() => text.call(this));
        };
    })()`);
    await openFile(editorFile);
    await sameAsCli("Open file: editor.json → TypeScript", "quicktype --lang typescript --top-level Editor editor.json");
    const editButton = `(() => { const b = document.getElementById("large-edit"); return { label: b.textContent, disabled: b.getAttribute("aria-disabled"), shown: !b.hidden }; })()`;
    assert.deepEqual(await page.evaluate(editButton), { label: "Show in the editor", disabled: null, shown: true });
    const whileReading = await page.evaluate(`(() => {
        const button = document.getElementById("large-edit");
        button.click();
        const busy = ${editButton};
        button.click();
        button.click();
        return busy;
    })()`);
    assert.deepEqual(whileReading, { label: "Reading…", disabled: "true", shown: true }, "the button while the file is read");
    await page.waitFor("!document.getElementById('input').hidden", "the large file in the editor");
    const inEditor = await page.evaluate(`({
        reads: editorReads,
        length: document.getElementById("input").value.length,
        focused: document.activeElement.id,
        button: ${editButton},
        layout: document.body.dataset.input,
    })`);
    assert.deepEqual(inEditor, {
        reads: 1,
        length: fs.readFileSync(editorFile, "utf8").length,
        focused: "input",
        button: { label: "Show in the editor", disabled: null, shown: true },
        layout: "editor",
    });
    const tooBigForEditor = chosen("editor-60mb.json", readInput("pokedex.json"));
    await openFile(tooBigForEditor);
    await sameAsCli("Open file: editor-60mb.json (60 MB, faked) → TypeScript", "quicktype --lang typescript --top-level Editor60mb editor-60mb.json");
    const refused = await page.evaluate(`(async () => {
        const reads = editorReads;
        document.getElementById("large-edit").click();
        await new Promise((resolve) => setTimeout(resolve, 800));
        return {
            size: document.getElementById("large-size").textContent,
            note: document.getElementById("large-note").textContent,
            button: !document.getElementById("large-edit").hidden,
            editor: !document.getElementById("input").hidden,
            reads: editorReads - reads,
        };
    })()`);
    assert.deepEqual(refused, {
        size: "60.0 MB",
        note: "Too large to show in the editor (over 50.0 MB), which would freeze the page; it runs all the same.",
        button: false,
        editor: false,
        reads: 0,
    });
    console.log(`ok: "Show in the editor" reads a large file once, however often it is clicked ("Reading…" until then); over 50 MB it is not offered: "${refused.note}"`);

    // The benchmarks page: rendered from site/data/*.json at build time.
    {
        const { bench: data, big } = benchmarkData;
        const benchUrl = `${url}benchmarks.html`;
        await page.viewport(1440, 900);
        await page.navigate(benchUrl, { playground: false });
        const pageNow = await page.evaluate(`(() => {
            const text = (selector) => [...document.querySelectorAll(selector)].map((n) => n.textContent.replace(/\\s+/g, " ").trim());
            return {
                title: document.title,
                h1: text("h1"),
                lead: text(".lead")[0],
                tiles: [...document.querySelectorAll(".tile")].map((t) => t.querySelector("dd").textContent),
                cli: [...document.querySelectorAll("#cli .bar-row")].map((r) => [r.querySelector(".bar-name").textContent, r.querySelector(".bar-value").textContent, r.querySelector("text.tip").textContent]),
                memory: [...document.querySelectorAll("#memory .bar-row")].map((r) => [r.querySelector(".bar-name").textContent, ...[...r.querySelectorAll("text.tip")].map((t) => t.textContent)]),
                corpus: [...document.querySelectorAll("#corpus text.tip")].map((t) => t.textContent),
                big: [...document.querySelectorAll("#big-files table.plain tbody tr")].map((r) => [...r.children].map((c) => c.textContent)),
                report: [...document.querySelectorAll("#big-files .bars .bar-value")].map((v) => v.textContent),
                browser: [...document.querySelectorAll("#browser .bar-row")].map((r) => [r.querySelector(".bar-value").textContent, r.querySelector(".bar-note").textContent]),
                method: Object.fromEntries([...document.querySelectorAll("#method .facts div")].map((d) => [d.querySelector("dt").textContent, d.querySelector("dd").textContent])),
                h2: text("h2"),
            };
        })()`);
        assert.equal(pageNow.title, "Benchmarks — quickertype");
        assert.deepEqual(pageNow.h1, ["Benchmarks"]);
        assert.equal(pageNow.lead, `quicktype rewritten in Rust: the same output, byte for byte. The CLI is up to ${speedNow.upTo}× faster (about ${speedNow.typical}× on typical files) and uses a fraction of the memory.`);
        const pokedex = data.cli.find((r) => r.name === benchNamed.pokedex).results;
        assert.deepEqual(pageNow.tiles, [
            `${speedNow.upTo}×`,
            speedup(speedNow.corpus),
            speedup(pokedex.typescript.peak_rss_mib / pokedex.rust.peak_rss_mib),
            big.reports[0].quickertype.replace(/^about /, "~"),
        ]);
        assert.deepEqual(
            pageNow.cli,
            data.cli.map((r) => [
                r.name,
                `${formatBenchMs(r.results.typescript.median_ms)} → ${formatBenchMs(r.results.rust.median_ms)}`,
                speedupText(r.results.typescript.median_ms / r.results.rust.median_ms),
            ]),
            "the CLI chart",
        );
        assert.deepEqual(
            pageNow.memory,
            benchNamed.memory.map((name) => {
                const r = data.cli.find((row) => row.name === name).results;
                return [name, formatMiB(r.typescript.peak_rss_mib), formatMiB(r.rust.peak_rss_mib)];
            }),
            "the memory chart",
        );
        assert.deepEqual(pageNow.corpus, [`${data.corpus.results.typescript.wall_s} s`, `${data.corpus.results.rust.wall_s} s`], "the corpus chart");
        assert.deepEqual(
            pageNow.big.map((cells) => cells.slice(1)),
            big.measured.inputs.map((i) => [i.seconds >= 1 ? `${i.seconds} s` : formatBenchMs(i.seconds * 1000), formatMiB(i.peak_rss_mib)]),
            "the big inputs",
        );
        assert.deepEqual(pageNow.report, [big.reports[0].quicktype, big.reports[0].quickertype], "the user's report");
        const version = data.cli.find((r) => r.name === benchNamed.startup).results;
        assert.deepEqual(
            pageNow.browser.map(([total]) => total),
            [formatBenchMs(pokedex.typescript.median_ms), formatBenchMs(pokedex.rust.median_ms)],
            "the start-up chart",
        );
        assert.match(pageNow.browser[0][1], new RegExp(`^${formatBenchMs(version.typescript.median_ms)} start-up \\+ `));
        assert.equal(pageNow.method.Date, new Date(`${data.date}T00:00:00Z`).toLocaleDateString("en-US", { year: "numeric", month: "long", day: "numeric", timeZone: "UTC" }));
        assert.ok(pageNow.method.Machine.startsWith(data.machine.cpu), pageNow.method.Machine);
        assert.equal(pageNow.method.Command, data.command);
        assert.ok(pageNow.method.quicktype.startsWith(data.commits.quicktype.slice(0, 7)), pageNow.method.quicktype);
        assert.ok(pageNow.method.quickertype.startsWith(data.commits.quickertype.slice(0, 7)), pageNow.method.quickertype);
        assert.deepEqual(pageNow.h2, ["Every CLI run, 96× to 8.1× faster".replace("96×", `${speedNow.upTo}×`).replace("8.1×", speedup(speedNow.lowest)), "Memory", `The whole test corpus, ${speedup(speedNow.corpus)} faster`, "Big files", "In the browser", "Method", "Get the CLI"]);
        console.log(`ok: the benchmarks page says what the data holds: ${pageNow.cli.length} CLI benchmarks, ${pageNow.memory.length} memory rows, the corpus, ${pageNow.big.length} big inputs and a user's report, the method (${pageNow.method.Date})`);

        // Accessible: every chart a figure with a caption; every bar an image
        // with a name; every other drawing hidden; every chart's numbers in a table.
        const a11y = await page.evaluate(`(() => {
            const svgs = [...document.querySelectorAll("svg")].filter((s) => s.ownerSVGElement === null);
            return {
                figures: [...document.querySelectorAll("figure")].map((f) => f.querySelector("figcaption")?.textContent.trim() ?? ""),
                unnamed: svgs.filter((s) => s.getAttribute("aria-hidden") !== "true" && !(s.getAttribute("role") === "img" && (s.getAttribute("aria-label") ?? "").trim() !== "")).length,
                bars: svgs.filter((s) => s.getAttribute("role") === "img").map((s) => s.getAttribute("aria-label")),
                charts: document.querySelectorAll("figure.chart .bars").length,
                tables: [...document.querySelectorAll("figure.chart")].filter((f) => f.querySelector(".bars") !== null && f.querySelector("table") === null).map((f) => f.querySelector("figcaption").textContent),
            };
        })()`);
        assert.ok(a11y.figures.length >= 6 && a11y.figures.every((c) => c !== ""), `figures without a caption: ${JSON.stringify(a11y.figures)}`);
        assert.equal(a11y.unnamed, 0, "drawings neither named nor hidden");
        for (const name of data.cli.map((r) => r.name)) {
            assert.ok(a11y.bars.some((label) => label.startsWith(`${name}: quickertype `)), `no accessible label for ${name}`);
        }
        const reportTables = big.reports.length; // the user's report lists its two values beside the bars
        assert.equal(a11y.tables.length, reportTables, `charts without a table: ${a11y.tables.join(", ")}`);
        console.log(`ok: the charts are labelled: ${a11y.figures.length} figures with captions, ${a11y.bars.length} bars named (e.g. "${a11y.bars[2]}"), a table for each chart`);

        // The charts' colours come from the theme: violet and gray, light and dark.
        const fills = () =>
            page.evaluate(`(() => {
                const fill = (selector) => getComputedStyle(document.querySelector(selector)).fill;
                return { ours: fill("#cli .bar-mark.ours rect"), theirs: fill("#memory .bar-mark.theirs rect"), panel: getComputedStyle(document.querySelector(".chart")).backgroundColor };
            })()`);
        const light = await fills();
        assert.deepEqual(light, { ours: "rgb(98, 80, 214)", theirs: "rgb(138, 140, 153)", panel: "rgb(255, 255, 255)" });
        await page.screenshot("speed-benchmarks-light.png", { full: true });
        await page.viewport(1440, 900, { dark: true });
        const dark = await fills();
        assert.deepEqual(dark, { ours: "rgb(144, 133, 233)", theirs: "rgb(105, 108, 121)", panel: "rgb(26, 28, 35)" });
        await page.screenshot("speed-benchmarks-dark.png", { full: true });
        await page.viewport(1440, 900);
        console.log("ok: the charts' colours follow the theme (light and dark)");

        // Every link resolves: pages, data and anchors here; files in this
        // repository; commits; the README.
        const hrefs = await page.evaluate("[...new Set([...document.querySelectorAll('a[href]')].map((a) => a.getAttribute('href')))]");
        const repository = "https://github.com/EloB/quickertype";
        const checked = [];
        for (const href of hrefs) {
            if (href.startsWith("#")) {
                assert.ok(await page.evaluate(`document.getElementById(${JSON.stringify(href.slice(1))}) !== null`), `no ${href} on the page`);
            } else if (href.startsWith("./")) {
                const target = new URL(href, benchUrl);
                const response = await fetch(target);
                assert.equal(response.status, 200, `${href}: ${response.status}`);
                if (href.startsWith("./data/")) {
                    const source = href.endsWith("benchmarks.json") ? benchmarksFile : bigInputsFile;
                    assert.deepEqual(await response.json(), JSON.parse(fs.readFileSync(source, "utf8")), `${href} is not ${path.basename(source)}`);
                }
                // An anchor (a playground link's hash is its state, as tested above).
                if (target.hash !== "" && !target.hash.includes("=")) {
                    const html = await (await fetch(new URL(target.pathname, benchUrl))).text();
                    assert.ok(html.includes(`id="${target.hash.slice(1)}"`), `${href}: no such anchor`);
                }
            } else if (href.startsWith(`${repository}/blob/main/`)) {
                const file = href.slice(`${repository}/blob/main/`.length);
                assert.ok(fs.existsSync(path.join(repositoryRoot, file)), `${href}: ${file} is not in this repository`);
            } else if (href.startsWith(`${repository}/commit/`) || href.startsWith("https://github.com/glideapps/quicktype/commit/")) {
                const commit = href.split("/").pop();
                assert.match(commit, /^[0-9a-f]{40}$/, href);
                assert.ok([data.commits.quickertype, data.commits.quicktype, big.measured.commit].includes(commit), `${href}: not a commit the data names`);
                if (href.startsWith(repository)) {
                    const known = spawnSync("git", ["-C", repositoryRoot, "cat-file", "-e", `${commit}^{commit}`]);
                    assert.equal(known.status, 0, `${href}: not a commit of this repository`);
                }
            } else {
                assert.ok(
                    [benchLinks.readme, benchLinks.install, benchLinks.releases, benchLinks.npmCore, repository, "https://github.com/glideapps/quicktype"].includes(href),
                    `an unexpected link: ${href}`,
                );
            }
            checked.push(href);
        }
        // The playground's links to this page resolve too.
        assert.equal((await fetch(new URL("./benchmarks.html", url))).status, 200);
        console.log(`ok: ${checked.length} links on the benchmarks page resolve (pages, data, anchors, repository files, commits)`);

        // Phones: no sideways scrolling, at 360 and 390 px.
        for (const width of [360, 390]) {
            await page.viewport(width, 844, { mobile: true });
            await page.navigate(benchUrl, { playground: false });
            const sizes = await page.evaluate(`({
                scroll: document.documentElement.scrollWidth,
                overflowing: [...document.querySelectorAll("main *")].filter((n) => n.getBoundingClientRect().right > ${width} + 0.5 && n.closest("table") === null).map((n) => n.tagName + "." + n.getAttribute("class")).slice(0, 5),
            })`);
            assert.ok(sizes.scroll <= width, `the benchmarks page is ${sizes.scroll} px wide at ${width} px`);
            assert.deepEqual(sizes.overflowing, [], `${width} px: past the right edge`);
            if (width === 390) await page.screenshot("speed-benchmarks-390.png", { full: true });
            console.log(`ok: the benchmarks page at ${width} px: no horizontal scrolling`);
        }
        await page.viewport(1440, 900);
    }

    // Phones: stacked, no sideways scrolling, and a long command wrapped.
    for (const width of [360, 390]) {
        await page.viewport(width, 844, { mobile: true });
        await page.navigate(`${url}#v=2&l=rust&s=pokedex&all-properties-optional=true&no-enums=true`);
        await page.waitFor(`${settled} && document.body.dataset.status === "done"`, "the run on a phone");
        // Both engines' results: the meter at its widest.
        await switchEngine("ts", `${width} px: the switch to quicktype`);
        await comparedIdentical(`${width} px`);
        const scrollWidth = await page.evaluate("document.documentElement.scrollWidth");
        assert.ok(scrollWidth <= width, `${width} px: the page is ${scrollWidth} px wide`);
        if (width === 390) {
            await page.screenshot("mobile-390.png", { full: true });
            await page.screenshot("speed-playground-390.png");
        }
        const { lines } = await commandShown(`${width} px`);
        assert.ok(lines > 1, `${width} px: the command is on ${lines} line(s)`);
        console.log(`ok: ${width} px wide, both engines compared, no horizontal scrolling; the command wraps onto ${lines} lines and copies whole`);

        // One pane at a time, the output first: the code starts in the first
        // screen, with the options closed (a drawer, out of the way); so does
        // the input, shown instead. Nothing scrolls sideways: the comparison's
        // details open, the options open, the input shown.
        await page.evaluate("scrollTo(0, 0)");
        const phone = await page.evaluate(`({
            panel: document.documentElement.dataset.panel,
            view: document.body.dataset.view,
            code: Math.round(document.getElementById("output").getBoundingClientRect().top),
            input: document.getElementById("input-pane").getClientRects().length,
        })`);
        assert.deepEqual({ ...phone, code: phone.code < 844 * 0.55 }, { panel: "closed", view: "output", code: true, input: 0 }, `${width} px: the output first`);
        await noSidewaysScroll(width, `${width} px`);
        await page.evaluate("document.getElementById('meter-toggle').click()");
        await noSidewaysScroll(width, `${width} px, the comparison's details open`);
        await page.evaluate("document.getElementById('meter-toggle').click()");
        await page.evaluate("document.getElementById('options-toggle').focus()");
        await pressEnter();
        assert.deepEqual(
            { ...(await panelNow()), codeWidth: undefined },
            { open: true, modal: true, layout: "drawer", expanded: "true", focus: "first", codeWidth: undefined },
            `${width} px: the options`,
        );
        await noSidewaysScroll(width, `${width} px, the options open`);
        if (width === 390) await page.screenshot("layout-options-drawer-390.png");
        await pressEscape();
        assert.deepEqual((await panelNow()).focus, "toggle", `${width} px: Escape in the options`);
        if (width === 390) await page.screenshot("layout-390.png");
        await page.evaluate("document.querySelector('input[name=view][value=input]').click()");
        const inputView = await page.evaluate(`({
            view: document.body.dataset.view,
            input: Math.round(document.getElementById("input").getBoundingClientRect().top),
            output: document.getElementById("output-pane").getClientRects().length,
        })`);
        assert.deepEqual({ ...inputView, input: inputView.input < 844 * 0.55 }, { view: "input", input: true, output: 0 }, `${width} px: the input`);
        await noSidewaysScroll(width, `${width} px, the input shown`);
        if (width === 390) await page.screenshot("layout-390-input.png");
        console.log(`ok: ${width} px: the output first (its code from ${phone.code} px down), the input a tap away (from ${inputView.input} px); the options a modal drawer; nothing scrolls sideways`);
    }

    // No input on a phone: the output says where the input is, a switch
    // away, and its "Input" switches to it, the focus on the switch.
    await andRun(typeInput(""), "no input at 390 px", `${settled} && document.body.dataset.status === "empty"`);
    await page.evaluate("document.querySelector('input[name=view][value=output]').click()");
    const emptyPhone = await page.evaluate("document.getElementById('error').innerText.trim()");
    assert.equal(emptyPhone, "Switch to Input to paste JSON or a JSON Schema, load a sample, or open a file.", "no input, at 390 px");
    await noSidewaysScroll(390, "390 px, no input");
    await page.screenshot("layout-390-empty.png");
    await page.evaluate("document.querySelector('#error .show-input').click()");
    assert.deepEqual(
        await page.evaluate(
            "({ view: document.body.dataset.view, checked: document.querySelector('input[name=view]:checked').value, focus: document.activeElement === document.querySelector('input[name=view][value=input]') })",
        ),
        { view: "input", checked: "input", focus: true },
        "390 px: Input, where the output says there is no input",
    );
    console.log(`ok: no input at 390 px: "${emptyPhone}", its Input shows the input`);

    // A file too large for the editor on a phone: still one pane at a time,
    // as wide as the page, the output's and the input's; nothing scrolls sideways.
    await upload(sampleFiles["big-senators.json"]);
    for (const view of ["output", "input"]) {
        await page.evaluate(`document.querySelector('input[name=view][value=${view}]').click()`);
        const large = await page.evaluate(`(() => {
            const panes = document.querySelector(".panes");
            return {
                input: document.body.dataset.input,
                columns: getComputedStyle(panes).gridTemplateColumns.split(" ").length,
                shown: Math.round(document.getElementById("${view}-pane").getBoundingClientRect().width),
                panes: Math.round(panes.getBoundingClientRect().width),
                other: document.getElementById("${view === "input" ? "output" : "input"}-pane").getClientRects().length,
            };
        })()`);
        assert.deepEqual(
            { ...large, shown: large.shown === large.panes },
            { input: "large", columns: 1, shown: true, panes: 390, other: 0 },
            `390 px, a large file: the ${view} (${large.shown} px wide)`,
        );
        await noSidewaysScroll(390, `390 px, a large file, the ${view}`);
        await page.screenshot(`layout-390-large-${view}.png`);
    }
    console.log("ok: 390 px, a file too large for the editor: one pane at a time, the output's and the input's as wide as the page; nothing scrolls sideways");

    const missing = requests.filter(([status]) => status !== 200);
    assert.deepEqual(missing, [], "requests that failed");
    const wasmRequests = requests.filter(([, p]) => p.endsWith(".wasm"));
    assert.ok(wasmRequests.length >= 1);
    assert.deepEqual(page.problems, [], "errors in the page");
    console.log(`ok: ${requests.length} requests, all under /quickertype/ and found; no errors in the page`);
    requestsChecked += await oneAtATime("the requests on the last page");
    console.log(`ok: ${requestsChecked} requests to the workers, on every page, never two at a time`);
} catch (e) {
    failed = true;
    console.log(`FAILED: ${e.stack ?? e}`);
} finally {
    if (sampleFiles["big-senators.json"] !== undefined) {
        fs.rmSync(path.dirname(sampleFiles["big-senators.json"]), { recursive: true, force: true });
    }

    for (const dir of cleanUp) fs.rmSync(dir, { recursive: true, force: true });
    await page.close();
    server.close();
}

process.exit(failed ? 1 : 0);
