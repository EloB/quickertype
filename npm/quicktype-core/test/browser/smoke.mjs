// Browser smoke test: quicktype-core bundled for the browser with esbuild,
// run in headless Chrome, two ways:
//
// * "asset": the .wasm file is served where the ES module glue looks for it
//   (`new URL(…, import.meta.url)`), as bundlers that emit assets arrange;
//   the first synchronous run happens before the engine is compiled, so it
//   uses the TypeScript engine, everything after it WebAssembly;
// * "supplied": no asset; the page compiles the .wasm itself and hands it
//   over as `globalThis[Symbol.for("quicktype-core.wasmModule")]`, so even
//   the first run uses WebAssembly;
// * "cjs": the CommonJS build bundled as an iife and loaded with a classic
//   script tag, the .wasm file served next to the bundle;
// * "ts": as "asset", with `Symbol.for("quicktype-core.engine")` set to
//   "ts" before the import: every run is on the TypeScript engine and the
//   .wasm file is never fetched.
//
// The outputs must equal what the same calls give in Node.
//
//   node test/browser/smoke.mjs        (after `npm run build`)
//
// The browser is $CHROME, else Google Chrome, Chromium or Playwright's
// Chromium, driven headless through the DevTools protocol. Without one the
// test prints how to run it by hand and exits 0.

import assert from "node:assert/strict";
import { execFileSync, spawn } from "node:child_process";
import * as fs from "node:fs";
import * as http from "node:http";
import { createRequire } from "node:module";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import * as esbuild from "esbuild";

import { smoke } from "./scenario.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const packageRoot = path.join(here, "..", "..");
const require = createRequire(import.meta.url);
const outDir = path.join(packageRoot, "build", "browser");
const wasmFile = path.join(packageRoot, "dist", "native", "wasm", "quicktype_wasm_bg.wasm");

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
    const playwright = path.join(os.homedir(), "Library", "Caches", "ms-playwright");
    if (fs.existsSync(playwright)) {
        for (const dir of fs.readdirSync(playwright).filter((d) => d.startsWith("chromium-")).sort().reverse()) {
            candidates.push(path.join(playwright, dir, "chrome-mac", "Chromium.app", "Contents", "MacOS", "Chromium"));
        }
    }

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

const pages = {
    asset: `<!doctype html><meta charset="utf-8"><pre id="result">pending</pre>
<script type="module" src="/app/js/bundle.js"></script>`,
    supplied: `<!doctype html><meta charset="utf-8"><pre id="result">pending</pre>
<script type="module">
    const response = await fetch("/engine.wasm");
    globalThis[Symbol.for("quicktype-core.wasmModule")] = await WebAssembly.compile(await response.arrayBuffer());
    await import("/app/js/bundle.js");
</script>`,
    cjs: `<!doctype html><meta charset="utf-8"><pre id="result">pending</pre>
<script src="/cjs/bundle.js"></script>`,
    ts: `<!doctype html><meta charset="utf-8"><pre id="result">pending</pre>
<script type="module">
    globalThis[Symbol.for("quicktype-core.engine")] = "ts";
    await import("/app/js/bundle.js");
</script>`,
};

async function serve(variant) {
    const files = {
        "/index.html": ["text/html", pages[variant]],
        "/app/js/bundle.js": ["text/javascript", fs.readFileSync(path.join(outDir, "bundle.js"))],
        "/cjs/bundle.js": ["text/javascript", fs.readFileSync(path.join(outDir, "bundle-cjs.js"))],
    };
    const wasm = fs.readFileSync(wasmFile);
    // Where the glue's `new URL("../../../native/wasm/…", import.meta.url)` points from /app/js/.
    if (variant === "asset" || variant === "ts") files["/native/wasm/quicktype_wasm_bg.wasm"] = ["application/wasm", wasm];
    else if (variant === "cjs") files["/cjs/quicktype_wasm_bg.wasm"] = ["application/wasm", wasm];
    else files["/engine.wasm"] = ["application/wasm", wasm];
    const requests = [];
    const server = http.createServer((request, response) => {
        requests.push(request.url);
        const file = files[request.url];
        if (file === undefined) {
            response.writeHead(404);
            response.end();
            return;
        }

        response.writeHead(200, { "content-type": file[0] });
        response.end(file[1]);
    });
    await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));
    server.requests = requests;
    return server;
}

/** Loads `url` in headless `browser` and returns the page's result (via the DevTools protocol). */
async function runBrowser(browser, url) {
    const profile = fs.mkdtempSync(path.join(os.tmpdir(), "qt-chrome-"));
    const child = spawn(
        browser,
        [
            "--headless=new",
            "--disable-gpu",
            "--no-first-run",
            "--no-default-browser-check",
            "--remote-debugging-port=0",
            `--user-data-dir=${profile}`,
            // CI containers often cannot use Chrome's sandbox.
            ...(process.env.CI ? ["--no-sandbox"] : []),
            url,
        ],
        { stdio: "ignore" },
    );
    const deadline = Date.now() + 60_000;
    const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
    try {
        const portFile = path.join(profile, "DevToolsActivePort");
        while (!fs.existsSync(portFile) || fs.readFileSync(portFile, "utf8").split("\n").length < 2) {
            if (Date.now() > deadline) throw new Error("the browser did not start");
            await wait(100);
        }

        const port = fs.readFileSync(portFile, "utf8").split("\n")[0];
        let page;
        while (page === undefined) {
            if (Date.now() > deadline) throw new Error("the page did not open");
            const targets = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json();
            page = targets.find((t) => t.type === "page" && t.url === url);
            if (page === undefined) await wait(100);
        }

        const socket = new WebSocket(page.webSocketDebuggerUrl);
        await new Promise((resolve, reject) => {
            socket.onopen = resolve;
            socket.onerror = reject;
        });
        let nextId = 0;
        const pending = new Map();
        socket.onmessage = (event) => {
            const message = JSON.parse(event.data);
            pending.get(message.id)?.(message);
            pending.delete(message.id);
        };
        const evaluate = (expression) =>
            new Promise((resolve) => {
                const id = ++nextId;
                pending.set(id, (m) => resolve(m.result?.result?.value));
                socket.send(JSON.stringify({ id, method: "Runtime.evaluate", params: { expression, returnByValue: true } }));
            });
        for (;;) {
            const text = await evaluate('document.getElementById("result")?.textContent ?? "pending"');
            if (text !== undefined && text !== "pending") {
                socket.close();
                return JSON.parse(text);
            }

            if (Date.now() > deadline) throw new Error("the page did not finish");
            await wait(100);
        }
    } finally {
        child.kill();
        await wait(200);
        fs.rmSync(profile, { recursive: true, force: true });
    }
}

const browser = findBrowser();
if (browser === undefined) {
    console.log(`No Chrome or Chromium found (set CHROME). To run the smoke test by hand:
  1. npm run build && node test/browser/smoke.mjs --serve
  2. open the printed URLs in a browser; each page shows a JSON result
     whose "outputs" must equal the Node outputs the script prints.`);
    process.exit(0);
}

fs.mkdirSync(outDir, { recursive: true });
const build = await esbuild.build({
    entryPoints: [path.join(here, "entry.mjs")],
    bundle: true,
    format: "esm",
    platform: "browser",
    outfile: path.join(outDir, "bundle.js"),
    logLevel: "silent",
});
assert.deepEqual(build.errors, []);
const buildCjs = await esbuild.build({
    entryPoints: [path.join(here, "entry-cjs.cjs")],
    bundle: true,
    format: "iife",
    platform: "browser",
    outfile: path.join(outDir, "bundle-cjs.js"),
    logLevel: "silent",
});
assert.deepEqual(buildCjs.errors, []);
console.log(`bundle: ${(fs.statSync(path.join(outDir, "bundle.js")).size / 1024).toFixed(0)} KiB (+ ${(fs.statSync(wasmFile).size / 1024 / 1024).toFixed(2)} MiB engine)`);

// Expected: the same calls in Node, on the TypeScript engine.
globalThis[Symbol.for("quicktype-core.engine")] = "ts";
const expected = await smoke(require(packageRoot), { wasm: 0, ts: 0 });
delete globalThis[Symbol.for("quicktype-core.engine")];

const expectedEngines = {
    asset: [{ wasm: 0, ts: 1 }, { wasm: 1, ts: 1 }, { wasm: 2, ts: 1 }, { wasm: 3, ts: 1 }],
    supplied: [{ wasm: 1, ts: 0 }, { wasm: 2, ts: 0 }, { wasm: 3, ts: 0 }, { wasm: 4, ts: 0 }],
    cjs: [{ wasm: 0, ts: 1 }, { wasm: 1, ts: 1 }, { wasm: 2, ts: 1 }, { wasm: 3, ts: 1 }],
    ts: [{ wasm: 0, ts: 1 }, { wasm: 0, ts: 2 }, { wasm: 0, ts: 3 }, { wasm: 0, ts: 4 }],
};

let failed = false;
for (const variant of ["asset", "supplied", "cjs", "ts"]) {
    const server = await serve(variant);
    const url = `http://127.0.0.1:${server.address().port}/index.html`;
    if (process.argv.includes("--serve")) {
        console.log(`${variant}: ${url}`);
        continue;
    }

    try {
        const result = await runBrowser(browser, url);
        if (result.error !== undefined) throw new Error(result.error);
        assert.deepEqual(result.outputs, expected.outputs);
        assert.deepEqual(result.engines, expectedEngines[variant]);
        if (variant === "ts") {
            assert.deepEqual(server.requests.filter((r) => r.endsWith(".wasm")), [], "the .wasm was fetched");
        }
        console.log(`${variant}: ok (engines per step: ${JSON.stringify(result.engines)})`);
    } catch (e) {
        failed = true;
        console.log(`${variant}: FAILED\n${e.message}`);
    } finally {
        server.close();
    }
}

if (process.argv.includes("--serve")) {
    console.log(`expected outputs:\n${JSON.stringify(expected.outputs)}\n(Ctrl-C to stop)`);
} else {
    process.exit(failed ? 1 : 0);
}
