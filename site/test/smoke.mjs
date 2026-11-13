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
// quicktype's defaults; that the general options are labelled as in the
// CLI's --help, and that a section the user closed stays closed; that the
// footer links the quicktype commit in tests/golden/REFERENCE; that compare mode reports identical output with each engine in its own
// worker; that invalid JSON shows quicktype's error; that the input survives
// a reload (localStorage); and that 360 px and 390 px widths do not scroll
// sideways. And three things that once went wrong: the code shown after a
// slow run during which compare mode was turned off; a measurement asked for
// while a run is under way; and a worker failing after it loaded.
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
            control.dispatchEvent(new Event("input", { bubbles: true }));
            control.dispatchEvent(new Event("change", { bubbles: true }));
        })()`,
        `a run after choosing ${value}`,
    );
}

/** The page shows the CLI's output for the command it shows, which is `expectedCommand`; returns the output. */
async function sameAsCli(label, expectedCommand) {
    const result = await shown();
    assert.equal(result.status, "done", `${label}: ${result.status}`);
    assert.equal(result.ran, "wasm", `${label} ran on ${result.ran}`);
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

/** Opens `file` with the file picker and waits for the run on it. */
async function upload(file) {
    const { result: picker } = await page.send("Runtime.evaluate", { expression: "document.getElementById('file')" });
    const before = await page.evaluate("playground.generation");
    await page.send("DOM.setFileInputFiles", { files: [file], objectId: picker.objectId });
    await page.waitFor(`playground.generation > ${before} && ${settled}`, `the run on ${path.basename(file)}`);
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
    }

    await page.navigate(`${url}#v=2&l=swift&s=pokedex`);
    await page.waitFor(settled, "the run for a new Swift link");
    await sameAsCli("new link #v=2&l=swift&s=pokedex", "quicktype --lang swift --top-level Pokedex --no-initializers pokedex.json");
    console.log("ok: links without v= get quicktype's defaults (and are rewritten with v=2); links with it get the presets");

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
    const reference = fs.readFileSync(path.join(repositoryRoot, "tests", "golden", "REFERENCE"), "utf8");
    const commit = /^quicktype_commit=([0-9a-f]{40})$/m.exec(reference)[1];
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
    await sameAsCli(
        "after the worker failed, a new one: big-senators.json → Rust",
        "quicktype --lang rust --top-level BigSenators --density dense big-senators.json",
    );
    console.log(`ok: a worker failing after it loaded: "${failure}"`);

    // Phones: stacked, no sideways scrolling.
    for (const width of [360, 390]) {
        await page.viewport(width, 844, { mobile: true });
        await page.navigate(`${url}#v=2&l=rust&s=pokedex`);
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
