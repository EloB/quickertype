// Smoke test for the playground: site/dist served under /quickertype/ (as on
// GitHub Pages), loaded in headless Chrome driven over the DevTools protocol
// (as npm/quicktype-core/test/browser/smoke.mjs does).
//
//   node site/test/smoke.mjs [--screenshots <dir>]     (after `node site/build.mjs`)
//
// Checks that the page loads with every language and runs on the
// WebAssembly engine; that pokedex.json → Rust and → TypeScript, and a JSON
// Schema sample, give the same bytes as the quicktype CLI with the arguments
// the page shows under the output ("Same as quicktype …"), as do renderer
// options given in the URL hash and an uploaded file too large for the
// editor; that compare mode reports identical output with each engine in its
// own worker; that invalid JSON shows quicktype's error; that the input
// survives a reload (localStorage); and that 360 px and 390 px widths do not
// scroll sideways. And three things that once went wrong: the code shown
// after a slow run during which compare mode was turned off; a measurement
// asked for while a run is under way; and a worker failing after it loaded.
//
// The CLI is required: $QUICKTYPE_CLI, else target/release/quicktype
// (`cargo build --release -p quicktype-cli`). The browser is $CHROME, else
// Google Chrome or Chromium; without one the test says so and exits 0 (in
// CI it fails).

import assert from "node:assert/strict";
import { execFileSync, spawn, spawnSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

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
    console.log(`No quicktype CLI at ${cli}: build it with \`cargo build --release -p quicktype-cli\` or set QUICKTYPE_CLI.`);
    process.exit(1);
}

/** The input files the page names, by name: samples, and later the uploaded file. */
const sampleFiles = {
    "pokedex.json": "tests/inputs/json/samples/pokedex.json",
    "us-senators.json": "tests/inputs/json/samples/us-senators.json",
    "description.schema": "tests/inputs/schema/description.schema",
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
    socket.onmessage = (event) => {
        const message = JSON.parse(event.data);
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

    /** A full load of `url` (via about:blank: a change of hash alone would not reload the page). */
    async function navigate(url) {
        await send("Page.navigate", { url: "about:blank" });
        await waitFor("location.href === 'about:blank'", "about:blank");
        await send("Page.navigate", { url });
        await waitFor("document.readyState === 'complete' && globalThis.playground", "the page to load");
    }

    async function close() {
        socket.close();
        child.kill();
        await wait(200);
        fs.rmSync(profile, { recursive: true, force: true });
    }

    await send("Runtime.enable");
    await send("Page.enable");
    return { send, evaluate, waitFor, viewport, screenshot, navigate, close, problems };
}

// ---------------------------------------------------------------------------
// The checks

const browser = findBrowser();
if (browser === undefined) {
    if (process.env.CI) throw new Error("no Chrome or Chromium (set CHROME)");
    console.log("No Chrome or Chromium found (set CHROME); skipping. To look by hand: node site/test/serve.mjs");
    process.exit(0);
}

if (!fs.existsSync(path.join(dist, "index.html"))) throw new Error("site/dist is not built: node site/build.mjs");

const { server, requests, url } = await serve(dist);
const page = await launch(browser);
const settled = "playground.generation > 0 && playground.view.settled === playground.generation";
const shown = () =>
    page.evaluate(`({
        files: playground.view.files.map((f) => ({ name: f.name, text: f.text })),
        code: document.getElementById("code").textContent,
        ran: playground.view.wasm?.ran,
        ok: playground.view.wasm?.ok,
        cli: playground.cli(),
        status: document.body.dataset.status,
        notes: [...document.querySelectorAll("#notes p")].map((p) => p.textContent.replace(/^(Line \\d+) /, "$1: ")),
    })`);

/** Does `action` (an expression) in the page and waits for the run it starts to settle. */
async function andRun(action, what, until = settled) {
    const before = await page.evaluate("playground.generation");
    await page.evaluate(action);
    await page.waitFor(`playground.generation > ${before} && ${until}`, what);
}

/** Ticks or unticks compare mode; ticking it runs only the TypeScript side (no new run). */
async function toggleCompare(what) {
    const before = await page.evaluate(`({
        generation: playground.generation,
        comparisons: playground.view.comparisons,
        on: document.getElementById("compare").checked,
    })`);
    await page.evaluate("document.getElementById('compare').click()");
    if (before.on) return;
    await page.waitFor(
        `playground.view.comparisons > ${before.comparisons} && document.body.dataset.compare !== "running"`,
        what,
    );
    assert.equal(await page.evaluate("playground.generation"), before.generation, "ticking compare started a new run");
}

/** A warm measurement of what the page shows has finished (both engines' when comparing). */
const measuredDone = `(() => {
    const bench = playground.view.bench;
    return bench !== undefined && typeof bench.wasm === "object" &&
        (!document.getElementById("compare").checked || typeof bench.ts === "object");
})()`;

function select(id, value) {
    return andRun(
        `(() => {
            const control = document.getElementById(${JSON.stringify(id)});
            control.value = ${JSON.stringify(value)};
            control.dispatchEvent(new Event("change", { bubbles: true }));
        })()`,
        `a run after choosing ${value}`,
    );
}

async function sameAsCli(label, expectedCommand) {
    const result = await shown();
    assert.equal(result.status, "done", `${label}: ${result.status}`);
    assert.equal(result.ran, "wasm", `${label} ran on ${result.ran}`);
    assert.equal(result.cli, expectedCommand);
    assert.equal(result.files.length, 1);
    const expected = expectedFor(result.cli);
    assert.ok(result.files[0].text === expected.text, `${label}: output differs from the CLI`);
    assert.ok(result.code === expected.text, `${label}: the code shown differs from the output`);
    assert.deepEqual(result.notes, expected.issues, `${label}: issues`);
    const issues = expected.issues.length > 0 ? `, ${expected.issues.length} issue(s) shown as on the CLI` : "";
    console.log(`ok: ${label} = \`${result.cli}\` (${expected.text.length} characters${issues})`);
}

/** "median 3.2 ms (reading the input 1.1, generating 2.1)" for one engine's warm runs. */
function medians({ times, inputTimes }) {
    const median = (xs) => [...xs].sort((a, b) => a - b)[xs.length >> 1];
    const generate = times.map((t, i) => t - inputTimes[i]);
    const ms = (x) => x.toFixed(x < 10 ? 2 : 1);
    return `median ${ms(median(times))} ms (reading the input ${ms(median(inputTimes))}, generating ${ms(median(generate))})`;
}

let failed = false;
try {
    console.log(`page: ${url}  browser: ${browser}`);
    console.log(`reference: ${cli}`);

    await page.viewport(1440, 900);
    await page.navigate(`${url}#l=rust&s=pokedex`);
    await page.waitFor(settled, "the first run");
    const languages = await page.evaluate("document.querySelectorAll('#lang option').length");
    assert.equal(languages, 27);
    const title = await page.evaluate("document.title");
    assert.match(title, /quickertype/);
    const boot = await page.evaluate("playground.engines.wasm.boot");
    assert.equal(boot.loadError, undefined);
    console.log(`ok: loads, ${languages} languages, engine compiled in ${boot.compileMs.toFixed(0)} ms`);

    await sameAsCli("pokedex.json → Rust", "quicktype --lang rust --top-level Pokedex pokedex.json");
    await select("lang", "typescript");
    await sameAsCli("pokedex.json → TypeScript", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    await page.screenshot("desktop-light.png");

    // Compare mode: the same input on the TypeScript engine, in a second worker.
    await toggleCompare("the comparison");
    await page.waitFor("document.body.dataset.compare !== 'running'", "the verdict");
    let compare = await page.evaluate(
        "({ verdict: document.body.dataset.compare, wasm: playground.view.wasm.ran, ts: playground.view.ts.ran, text: document.querySelector('.verdict')?.textContent, hash: location.hash })",
    );
    assert.equal(compare.wasm, "wasm");
    assert.equal(compare.ts, "ts");
    assert.equal(compare.verdict, "identical", compare.text);
    assert.match(compare.hash, /(^#|&)c=1(&|$)/);
    console.log(`ok: compare mode: ${compare.text}`);
    await page.evaluate("document.getElementById('measure').click()");
    await page.waitFor(measuredDone, "the warm measurement", 180_000);
    compare = await page.evaluate(
        "({ verdict: document.body.dataset.compare, text: document.querySelector('.verdict')?.textContent, wasm: playground.view.bench.wasm, ts: playground.view.bench.ts })",
    );
    assert.equal(compare.verdict, "identical", compare.text);
    console.log(`ok: warm runs: ${compare.text}\n    WebAssembly ${medians(compare.wasm)}\n    TypeScript  ${medians(compare.ts)}`);
    await page.screenshot("compare.png");
    // Turning it off only hides the comparison; nothing runs.
    await page.evaluate("document.getElementById('compare').click()");

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
    const invalid = '{\n  "name": "Ann",\n  "age": 7,\n}';
    await andRun(
        `(() => {
            const input = document.getElementById("input");
            input.value = ${JSON.stringify(invalid)};
            input.dispatchEvent(new Event("input", { bubbles: true }));
        })()`,
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

    // The input survives a reload (localStorage); the hash keeps the rest.
    const hash = await page.evaluate("location.hash");
    await page.navigate(`${url}${hash}`);
    await page.waitFor(settled, "the run after reloading");
    const restored = await page.evaluate("document.getElementById('input').value");
    assert.equal(restored, invalid);
    console.log(`ok: reload restores the input (${hash})`);

    // Renderer options from the hash: an enum, a string and both booleans,
    // one of them a secondary option ("More options").
    await page.navigate(
        `${url}#l=cs&s=pokedex&namespace=Pokemon.Models&framework=NewtonSoft&density=dense&virtual=true&dateonly-timeonly-converters=false&bogus=1`,
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
        hash: "#l=cs&s=pokedex&framework=NewtonSoft&density=dense&namespace=Pokemon.Models&virtual=true&dateonly-timeonly-converters=false",
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
        "quicktype --lang rust --top-level BigSenators big-senators.json",
    );
    await toggleCompare("the comparison on the large file");
    await page.evaluate("document.getElementById('measure').click()");
    await page.waitFor(measuredDone, "the warm measurement on the large file", 300_000);
    const bigCompare = await page.evaluate(
        "({ verdict: document.body.dataset.compare, text: document.querySelector('.verdict')?.textContent, wasm: playground.view.bench.wasm, ts: playground.view.bench.ts })",
    );
    assert.equal(bigCompare.verdict, "identical", bigCompare.text);
    console.log(
        `ok: large file, warm runs: ${bigCompare.text}\n    WebAssembly ${medians(bigCompare.wasm)}\n    TypeScript  ${medians(bigCompare.ts)}`,
    );

    // A run under way (another language) while compare mode is turned off:
    // the page re-renders mid-run, and must still draw the new result.
    await andRun(
        `(() => {
            const lang = document.getElementById("lang");
            lang.value = "go";
            lang.dispatchEvent(new Event("change", { bubbles: true }));
            document.getElementById("compare").click();
        })()`,
        "the run during which compare mode was turned off",
        `${settled} && document.body.dataset.status === "done"`,
    );
    const drawn = await page.evaluate(`({
        lang: playground.view.shown.lang.names[0],
        same: document.getElementById("code").textContent === playground.view.files[playground.view.tab].text,
        go: playground.view.files[0].text.includes("package main"),
        compare: document.getElementById("compare").checked,
    })`);
    assert.deepEqual(drawn, { lang: "go", same: true, go: true, compare: false });
    console.log("ok: compare mode turned off during a run: the new result is drawn, and Copy/Download give what is shown");

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
    await page.waitFor(measuredDone, "the measurement asked for during a run", 120_000);
    await new Promise((resolve) => setTimeout(resolve, 400));
    const measuredRun = await page.evaluate(`({
        status: document.body.dataset.status,
        running: document.getElementById("meter").textContent.includes("Running"),
        lang: playground.view.shown.lang.names[0],
        same: playground.view.bench.wasm.files[0].text === playground.view.files[0].text,
        runs: playground.view.bench.wasm.times.length,
    })`);
    assert.deepEqual(measuredRun, { status: "done", running: false, lang: "rust", same: true, runs: 5 });
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
    await sameAsCli("after the worker failed, a new one: big-senators.json → Rust", "quicktype --lang rust --top-level BigSenators big-senators.json");
    console.log(`ok: a worker failing after it loaded: "${failure}"`);

    // Phones: stacked, no sideways scrolling.
    for (const width of [360, 390]) {
        await page.viewport(width, 844, { mobile: true });
        await page.navigate(`${url}#l=rust&s=pokedex`);
        await page.waitFor(`${settled} && document.body.dataset.status === "done"`, "the run on a phone");
        const scrollWidth = await page.evaluate("document.documentElement.scrollWidth");
        assert.ok(scrollWidth <= width, `${width} px: the page is ${scrollWidth} px wide`);
        if (width === 390) await page.screenshot("mobile-390.png", { full: true });
        console.log(`ok: ${width} px wide, no horizontal scrolling`);
    }

    const missing = requests.filter(([status]) => status !== 200);
    assert.deepEqual(missing, [], "requests that failed");
    const wasmRequests = requests.filter(([, p]) => p.endsWith(".wasm"));
    assert.ok(wasmRequests.length >= 1);
    assert.deepEqual(page.problems, [], "errors in the page");
    console.log(`ok: ${requests.length} requests, all under /quickertype/ and found; no errors in the page`);
} catch (e) {
    failed = true;
    console.log(`FAILED: ${e.stack ?? e}`);
} finally {
    if (sampleFiles["big-senators.json"] !== undefined) {
        fs.rmSync(path.dirname(sampleFiles["big-senators.json"]), { recursive: true, force: true });
    }

    await page.close();
    server.close();
}

process.exit(failed ? 1 : 0);
