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
// engine runs nothing; that invalid JSON shows quicktype's error; that the
// input survives a reload (localStorage); and that 360 px and 390 px widths
// do not scroll sideways. And three things that once went wrong: the code
// shown after a slow run during which the engine was switched; a
// measurement asked for while a run is under way; and a worker failing
// after it loaded.
//
// Files are opened as a user opens them too: a click on "Open file", the
// browser's file chooser, a file picked: JSON, the same file twice, JSON
// Schema, an extension outside the chooser's filter, and a 26 MB file,
// which the page posts to the workers unread (no main-thread task over
// 200 ms, by a PerformanceObserver for long tasks). A file larger than a
// browser's longest string (its size faked), one that cannot be read, a
// dropped one, and one deleted before a worker read it each show why in the
// output pane, name the file and its CLI command, and leave nothing running.
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
    console.log(`No quicktype CLI at ${cli}: build it with \`cargo build --release -p quicktype-cli\` or set QUICKTYPE_CLI.`);
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
    return { send, next, evaluate, waitFor, viewport, screenshot, navigate, close, problems };
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
page.navigate = async (target) => {
    requestsChecked += await oneAtATime(`the requests on ${await page.evaluate("location.href")}`);
    await navigateTo(target);
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

/** Presses a key in the page (as the keyboard does: trusted events, default actions). */
async function press(key, keyCode) {
    for (const type of ["keyDown", "keyUp"]) {
        await page.send("Input.dispatchKeyEvent", { type, key, code: key, windowsVirtualKeyCode: keyCode });
    }
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
 * The input, a file, could not be opened: the output pane says so (its
 * title, its message, and where to get the CLI, if `cli`); the input pane
 * names the file and the command under the output is the CLI's for it
 * (`command`); there is no request, nothing runs or waits, the output is not
 * shown as stale, and neither switching engine nor another language runs
 * anything (it says so again).
 */
async function openFailed(what, { title, message, command, size, cli: withCli = false }) {
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
        { status: "error", title: undefined, message: undefined, link: withCli ? "https://github.com/EloB/quickertype#readme" : null, request: true, busy: false, stale: false, running: false },
        `${what}: the page after it`,
    );
    const input = () =>
        page.evaluate(`({
            name: document.getElementById("large").hidden ? null : document.getElementById("large-name").textContent,
            size: document.getElementById("large-size").textContent,
            status: document.getElementById("large-status").textContent,
            edit: !document.getElementById("large-edit").hidden,
            command: playground.cli(),
        })`);
    const expected = { name: command.split(" ").pop(), size, status: "Can't be opened in the browser: see the output.", edit: false, command };
    assert.deepEqual(await input(), expected, `${what}: the input pane`);
    const engine = await page.evaluate("playground.engine");
    for (const other of [engine === "wasm" ? "ts" : "wasm", engine]) {
        const ran = await switchEngine(other, `${what}: a switch to ${other}`);
        assert.deepEqual(ran, { wasm: 0, ts: 0 }, `${what}: a switch to ${other} ran`);
    }

    const before = await runCounts();
    await select("lang", "go");
    const after = await runCounts();
    assert.deepEqual([after.wasm - before.wasm, after.ts - before.ts], [0, 0], `${what}: another language ran`);
    assert.equal(await page.evaluate(`document.querySelector("#error .error-message")?.textContent`), shownNow.message, `${what}: another language`);
    assert.deepEqual(await input(), { ...expected, command: command.replace("--lang typescript", "--lang go") }, `${what}: the input pane, in Go`);
    await select("lang", "typescript");
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
    ran = await switchEngine("wasm", "the switch back to quickertype");
    assert.deepEqual(ran, { wasm: 0, ts: 0 }, "the switch back to quickertype ran");
    await sameAsCli("pokedex.json → TypeScript on quickertype again", "quicktype --lang typescript --top-level Pokedex pokedex.json");
    assert.equal(await hashNow(), "#v=2&l=typescript&s=pokedex");
    await comparedIdentical("quickertype after quicktype");
    console.log("ok: back on quickertype: nothing ran, the comparison stays");

    // Warm runs: both engines, medians.
    await page.evaluate("document.getElementById('measure').click()");
    await page.waitFor(measuredDone, "the warm measurement", 300_000);
    compare = await comparedIdentical("warm runs", true);
    const bench = await page.evaluate("({ wasm: playground.view.bench.wasm, ts: playground.view.bench.ts })");
    console.log(`ok: warm runs: ${compare}\n    quickertype ${medians(bench.wasm)}\n    quicktype   ${medians(bench.ts)}`);
    await page.screenshot("compare.png");

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
    await sameAsCli(`Open file: rulings.json (${(rulings.text.length / 1e6).toFixed(1)} MB, ${rulings.records} records) → TypeScript`, "quicktype --lang typescript --top-level Rulings rulings.json");
    await page.screenshot("large-file.png");
    ran = await switchEngine("ts", "quicktype on the 26 MB file", undefined);
    assert.deepEqual(ran, { wasm: 0, ts: 1 }, "the switch to quicktype on the 26 MB file ran");
    await sameAsCli("Open file: rulings.json → TypeScript on quicktype", "quicktype --lang typescript --top-level Rulings rulings.json", "ts");
    await comparedIdentical("the 26 MB file");
    const longTasks = await page.evaluate("longTasks");
    const longest = Math.max(0, ...longTasks);
    assert.ok(longest <= 200, `a main-thread task took ${longest} ms with the 26 MB file (long tasks: ${longTasks.join(", ")} ms)`);
    console.log(`ok: the 26 MB file is posted as a File and read in the workers; the longest main-thread task: ${longTasks.length === 0 ? "none over 50 ms" : `${longest} ms`}`);
    ran = await switchEngine("wasm", "back to quickertype on the 26 MB file");
    assert.deepEqual(ran, { wasm: 0, ts: 0 });

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
    await openFile(chosen("huge.json", readInput("pokedex.json")), { failing: true });
    await openFailed("a 3 GB file", {
        title: "huge.json is too large for the browser",
        message: tooLargeMessage,
        command: "quicktype --lang typescript --top-level Huge huge.json",
        size: "3.0 GB",
        cli: true,
    });
    await page.screenshot("file-too-large.png");
    await openFile(chosen("unreadable.json", readInput("pokedex.json")), { failing: true });
    await openFailed("a file that cannot be read", {
        title: "Could not read unreadable.json",
        message: "Could not read unreadable.json: RangeError: Invalid string length",
        command: "quicktype --lang typescript --top-level Unreadable unreadable.json",
        size: `${(readInput("pokedex.json").length / 1000).toFixed(1)} kB`,
    });
    /** Drops a file `name` with `content` on the input side (as an expression for andRun). */
    const drop = (name, content) =>
        `(() => {
            const data = new DataTransfer();
            data.items.add(new File([${JSON.stringify(content)}], ${JSON.stringify(name)}, { type: "application/json" }));
            document.getElementById("input-pane").dispatchEvent(new DragEvent("drop", { dataTransfer: data, bubbles: true, cancelable: true }));
        })()`;
    await andRun(drop("dropped-huge.json", "[1]"), "a dropped 3 GB file", `document.body.dataset.status === "error"`);
    await openFailed("a dropped 3 GB file", {
        title: "dropped-huge.json is too large for the browser",
        message: tooLargeMessage,
        command: "quicktype --lang typescript --top-level DroppedHuge dropped-huge.json",
        size: "3.0 GB",
        cli: true,
    });
    chosen("dropped.json", readInput("pokedex.json"));
    await andRun(drop("dropped.json", readInput("pokedex.json").toString("utf8")), "a dropped file");
    await sameAsCli("a dropped file: dropped.json → TypeScript", "quicktype --lang typescript --top-level Dropped dropped.json");
    console.log(`ok: a file too large for a browser, one that cannot be read, and one dropped: "${tooLargeMessage}"`);

    // A large file that is gone by the time a worker reads it: that engine
    // says it could not read it; the other, which read it before, keeps its
    // result.
    const goneFile = chosen("gone.json", JSON.stringify(Array.from({ length: 12 }, () => JSON.parse(readInput("us-senators.json"))), undefined, 2));
    await openFile(goneFile);
    await sameAsCli("Open file: gone.json → TypeScript", "quicktype --lang typescript --top-level Gone gone.json");
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
        if (width === 390) await page.screenshot("mobile-390.png", { full: true });
        const { lines } = await commandShown(`${width} px`);
        assert.ok(lines > 1, `${width} px: the command is on ${lines} line(s)`);
        console.log(`ok: ${width} px wide, both engines compared, no horizontal scrolling; the command wraps onto ${lines} lines and copies whole`);
    }

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
