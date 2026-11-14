// Where the WebAssembly engine's time goes in headless Chrome, phase by
// phase (docs/BENCHMARKS.md, "Where the WebAssembly engine's time goes"):
// `addSource` plus `quicktypeMultiFile` to TypeScript, warm, on the
// benchmark inputs and a tiny one. Needs an engine built with `--trace`:
//
//   node script/build.mjs --trace
//   node test/bench/phases.mjs [--only REGEX] [--rounds N] [--bytes] [--json] [--package DIR]
//
// With --bytes, each sample is given as its UTF-8 bytes (a Uint8Array, made
// before the clock starts) instead of a string.
//
// The page is cross-origin isolated, so that `performance.now()` has 5 µs
// steps rather than 100 µs. The native counterpart, the same phases of the
// same entry points in process:
//
//   cargo run --release -p quicktype-wasm --features trace --example phases -- FILE
//
// (`--json` here also writes each input to build/bench/phases/, for that.)

import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as http from "node:http";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { benchInputs } from "./inputs.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const args = process.argv.slice(2);
const option = (name) => {
    const i = args.indexOf(name);
    return i < 0 ? undefined : args[i + 1];
};
const packageRoot = path.resolve(option("--package") ?? path.join(here, "..", ".."));
const only = option("--only") === undefined ? undefined : new RegExp(option("--only"));
const fixedRounds = option("--rounds") === undefined ? undefined : Number(option("--rounds"));
const bytes = args.includes("--bytes");
const inputs = [["tiny (7 B)", () => '{"a":1}'], ...benchInputs]
    .filter(([name]) => only === undefined || only.test(name))
    .map(([name, make]) => ({ name, text: make() }));

const outDir = path.join(packageRoot, "build", "bench", "phases");
fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, "force-ts.mjs"), 'globalThis[Symbol.for("quicktype-core.engine")] = "ts";\n');
fs.writeFileSync(
    path.join(outDir, "entry.mjs"),
    `import "./force-ts.mjs";
import * as qt from ${JSON.stringify(path.join(packageRoot, "dist", "esm", "index.js"))};
import { engineSync } from ${JSON.stringify(path.join(packageRoot, "dist", "esm", "native", "engine.js"))};
import { measurePhases } from ${JSON.stringify(path.join(here, "phases-page.mjs"))};
const out = document.getElementById("result");
try {
    delete globalThis[Symbol.for("quicktype-core.engine")];
    globalThis[Symbol.for("quicktype-core.wasmModule")] = await WebAssembly.compileStreaming(fetch("/engine.wasm"));
    const glue = engineSync();
    if (glue === undefined) throw new Error("the engine did not load");
    if (!crossOriginIsolated) throw new Error("the page is not cross-origin isolated");
    const encoder = new TextEncoder();
    const inputs = (await (await fetch("/inputs.json")).json()).map(({ name, text }) => ({ name, text: ${bytes} ? encoder.encode(text) : text }));
    const fixed = ${fixedRounds ?? "undefined"};
    const rounds = (length) => fixed ?? (length > 10_000_000 ? 11 : length > 1_000_000 ? 21 : 61);
    out.textContent = JSON.stringify({ results: await measurePhases(qt, glue, inputs, rounds) });
} catch (e) {
    out.textContent = JSON.stringify({ error: String(e?.stack ?? e) });
}
`,
);
const esbuild = await import("esbuild");
await esbuild.build({
    entryPoints: [path.join(outDir, "entry.mjs")],
    bundle: true,
    format: "esm",
    platform: "browser",
    outfile: path.join(outDir, "bundle.js"),
    logLevel: "silent",
});

const files = {
    "/index.html": ["text/html", '<!doctype html><meta charset="utf-8"><pre id="result">pending</pre><script type="module" src="/bundle.js"></script>'],
    "/bundle.js": ["text/javascript", fs.readFileSync(path.join(outDir, "bundle.js"))],
    "/inputs.json": ["application/json", JSON.stringify(inputs)],
    "/engine.wasm": ["application/wasm", fs.readFileSync(path.join(packageRoot, "dist", "native", "wasm", "quicktype_wasm_bg.wasm"))],
};
const server = http.createServer((request, response) => {
    const file = files[request.url];
    if (file === undefined) {
        response.writeHead(404);
        response.end();
        return;
    }

    // Cross-origin isolated: finer timers.
    response.writeHead(200, {
        "content-type": file[0],
        "cross-origin-opener-policy": "same-origin",
        "cross-origin-embedder-policy": "require-corp",
    });
    response.end(file[1]);
});
await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));

function findBrowser() {
    for (const candidate of [
        process.env.CHROME,
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
    ]) {
        if (candidate !== undefined && fs.existsSync(candidate)) return candidate;
    }

    throw new Error("no Chrome found (set CHROME)");
}

const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const url = `http://127.0.0.1:${server.address().port}/index.html`;
const profile = fs.mkdtempSync(path.join(os.tmpdir(), "qt-phases-chrome-"));
const child = spawn(
    findBrowser(),
    [
        "--headless=new",
        "--disable-gpu",
        "--no-first-run",
        "--no-default-browser-check",
        "--js-flags=--expose-gc",
        "--remote-debugging-port=0",
        `--user-data-dir=${profile}`,
        url,
    ],
    { stdio: "ignore" },
);
let result;
try {
    const portFile = path.join(profile, "DevToolsActivePort");
    while (!fs.existsSync(portFile) || fs.readFileSync(portFile, "utf8").split("\n").length < 2) await wait(100);
    const port = fs.readFileSync(portFile, "utf8").split("\n")[0];
    let page;
    while (page === undefined) {
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
    const evaluate = () =>
        new Promise((resolve) => {
            const id = ++nextId;
            pending.set(id, (m) => resolve(m.result?.result?.value));
            socket.send(JSON.stringify({ id, method: "Runtime.evaluate", params: { expression: 'document.getElementById("result")?.textContent ?? "pending"', returnByValue: true } }));
        });
    for (;;) {
        const text = await evaluate();
        if (text !== undefined && text !== "pending") {
            result = JSON.parse(text);
            break;
        }

        await wait(500);
    }

    socket.close();
} finally {
    child.kill();
    server.close();
    await wait(300);
    try {
        fs.rmSync(profile, { recursive: true, force: true, maxRetries: 5, retryDelay: 200 });
    } catch {
        // Chrome may still be writing its profile; it is a temporary directory.
    }
}

if (result.error !== undefined) throw new Error(result.error);
if (args.includes("--json")) {
    for (const [i, { text }] of inputs.entries()) fs.writeFileSync(path.join(outDir, `input${i}.json`), text);
    console.log(JSON.stringify({ host: "headless Chrome, warm", results: result.results }, undefined, 1));
} else {
    const ms = (x) => (x < 1 ? x.toFixed(3) : x < 100 ? x.toFixed(2) : x.toFixed(1));
    for (const r of result.results) {
        console.log(`${r.name}: ${r.outputLength} bytes of TypeScript; medians of ${r.runs} runs, ms`);
        for (const [phase, x] of Object.entries(r.medians)) console.log(`  ${phase.padEnd(40)} ${ms(x).padStart(9)}`);
    }
}
