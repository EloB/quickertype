// Measures the playground reading large files in headless Chrome: in one go
// and in parts on several workers (docs/BENCHMARKS.md, "Reading on several
// workers"). For each file and way of reading, a fresh page opens the file
// as a user does (its file chooser), and the WebAssembly worker reads and
// runs it (TypeScript, the page's defaults): the time from the request to
// the result, as the page sees it, and the worker's own (reading the input,
// generating the code); then warm runs, each reading the file again; then
// the WebAssembly memory of the worker's engine and of each part worker's
// (it never shrinks: the most each held).
//
//   node site/test/parts-bench.mjs [--rounds 3] [--workers 8] [--parts-from <bytes>] [--modes one,parts] [--site site/dist] <file>...
//   node site/test/parts-bench.mjs --baseline --modes one --site <main's site/dist> <file>...
//   node site/test/parts-bench.mjs --generate <dir>    writes the generated inputs to <dir>
//
// (after `node site/build.mjs`). In one go is the page as it reads every
// file (`partsFrom` past the file's size; `textLimit` lifted, so that a JSON
// file past the longest string reads in one go too, as on main through the
// npm API); in parts is its default.

import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { generateCards, generateRulings } from "../../npm/quicktype-core/test/bench/generate.mjs";
import { serve } from "./serve.mjs";

const siteRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const args = process.argv.slice(2);
const option = (name, fallback) => {
    const i = args.indexOf(name);
    if (i < 0) return fallback;
    const [value] = args.splice(i, 2).slice(1);
    return value;
};
const generate = option("--generate");
const rounds = Number(option("--rounds", "3"));
const workers = option("--workers");
const partsFrom = option("--parts-from");
// A build from before reading in parts (main's): no test hooks, no stats.
const baseline = args.includes("--baseline") ? (args.splice(args.indexOf("--baseline"), 1), true) : false;
const site = path.resolve(option("--site", path.join(siteRoot, "dist")));
const modes = (option("--modes", "one,parts") ?? "").split(",");

if (generate !== undefined) {
    fs.mkdirSync(generate, { recursive: true });
    const write = (name, make) => {
        const file = path.join(generate, name);
        if (!fs.existsSync(file)) fs.writeFileSync(file, make());
        console.log(`${file}: ${(fs.statSync(file).size / 1e6).toFixed(1)} MB`);
    };
    // The 100k records (27 MB); cards of the real dump's shape, about 100 and 450 MB.
    write("rulings-100k.json", () => generateRulings(100_000));
    write("cards-100mb.json", () => generateCards(22_800));
    write("cards-450mb.json", () => generateCards(102_600));
    process.exit(0);
}

const files = args.map((f) => path.resolve(f));
if (files.length === 0) {
    console.log("usage: node site/test/parts-bench.mjs [--rounds 3] [--workers 8] [--modes one,parts] <file>...");
    process.exit(1);
}

const chrome = process.env.CHROME ?? "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

/** A headless Chrome page, driven over the DevTools protocol. */
async function launch() {
    const profile = fs.mkdtempSync(path.join(os.tmpdir(), "qt-parts-"));
    const child = spawn(chrome, ["--headless=new", "--disable-gpu", "--no-first-run", "--remote-debugging-port=0", `--user-data-dir=${profile}`, "about:blank"], { stdio: "ignore" });
    const portFile = path.join(profile, "DevToolsActivePort");
    while (!fs.existsSync(portFile) || fs.readFileSync(portFile, "utf8").split("\n").length < 2) await wait(100);
    const port = fs.readFileSync(portFile, "utf8").split("\n")[0];
    let target;
    while (target === undefined) {
        target = (await (await fetch(`http://127.0.0.1:${port}/json/list`)).json()).find((t) => t.type === "page");
        if (target === undefined) await wait(100);
    }

    const socket = new WebSocket(target.webSocketDebuggerUrl);
    await new Promise((resolve) => {
        socket.onopen = resolve;
    });
    let nextId = 0;
    const pending = new Map();
    socket.onmessage = (event) => {
        const message = JSON.parse(event.data);
        if (message.id !== undefined) {
            pending.get(message.id)?.(message);
            pending.delete(message.id);
        }
    };
    const send = (method, params = {}) =>
        new Promise((resolve, reject) => {
            const id = ++nextId;
            pending.set(id, (m) => (m.error ? reject(new Error(`${method}: ${m.error.message}`)) : resolve(m.result)));
            socket.send(JSON.stringify({ id, method, params }));
        });
    const evaluate = async (expression) => {
        const result = await send("Runtime.evaluate", { expression, returnByValue: true, awaitPromise: true });
        if (result.exceptionDetails) throw new Error(result.exceptionDetails.exception?.description ?? result.exceptionDetails.text);
        return result.result.value;
    };
    const waitFor = async (expression, timeout = 600_000) => {
        const until = Date.now() + timeout;
        while (!(await evaluate(`Boolean(${expression})`))) {
            if (Date.now() > until) throw new Error(`timed out waiting for ${expression}`);
            await wait(20);
        }
    };
    await send("Runtime.enable");
    await send("DOM.enable");
    return {
        send,
        evaluate,
        waitFor,
        close: async () => {
            socket.close();
            child.kill();
            await wait(300);
            fs.rmSync(profile, { recursive: true, force: true });
        },
    };
}

const { server, url } = await serve(site);
const app = new URL("app/", url).href;
const median = (xs) => [...xs].sort((a, b) => a - b)[xs.length >> 1];
const mib = (n) => `${(n / 1024 / 1024).toFixed(0)} MiB`;

for (const file of files) {
    const size = fs.statSync(file).size;
    console.log(`\n${path.basename(file)}: ${(size / 1e6).toFixed(1)} MB`);
    for (const mode of modes) {
        const page = await launch();
        try {
            await page.send("Page.navigate", { url: `${app}#v=2&l=typescript` });
            await page.waitFor("globalThis.playground && playground.view.status === 'done'");
            const hooks =
                mode === "one"
                    ? { partsFrom: 2 ** 53, textLimit: 2 ** 53 }
                    : { ...(workers === undefined ? {} : { partWorkers: Number(workers) }), ...(partsFrom === undefined ? {} : { partsFrom: Number(partsFrom) }) };
            if (!baseline) await page.evaluate(`playground.engines.wasm.run({ kind: "json", lang: "typescript", name: "X", text: "[1]", rendererOptions: {}, options: {}, ...${JSON.stringify(hooks)} }).then(() => true)`);
            const before = await page.evaluate("playground.generation");
            const { root } = await page.send("DOM.getDocument");
            const { nodeId } = await page.send("DOM.querySelector", { nodeId: root.nodeId, selector: "#file" });
            await page.send("DOM.setFileInputFiles", { files: [file], nodeId });
            await page.waitFor(`playground.generation > ${before} && playground.view.settled === playground.generation && playground.view.results.wasm?.result !== "running"`);
            const cold = await page.evaluate(`(async () => {
                const result = playground.view.results.wasm.result;
                const span = playground.engines.wasm.lane.history.at(-1);
                const text = result.files?.map((f) => f.text).join("\\n") ?? "";
                const digest = new Uint8Array(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text)));
                const sha = [...digest.slice(0, 6)].map((b) => b.toString(16).padStart(2, "0")).join("");
                return { ok: result.ok, error: result.error?.message, wall: span.received - span.sent, ms: result.ms, input: result.inputTimes[0], parts: result.parts, bytes: text.length, sha };
            })()`);
            const noStats = { memory: Number.NaN, partMemory: [] };
            const stats = () => (baseline ? noStats : page.evaluate(`playground.engines.wasm.run({ kind: "stats" }).then((r) => r.stats)`));
            const coldStats = await stats();
            const warm = await page.evaluate(`playground.engines.wasm.run({ ...playground.view.request, warmup: 1, repeat: ${rounds} }).then((r) => ({ ok: r.ok, error: r.error?.message, times: r.times, inputTimes: r.inputTimes, parts: r.parts }))`);
            const warmStats = await stats();
            const partMemory = (stats) => stats.partMemory.reduce((a, b) => a + b, 0);
            const how = cold.parts?.workers !== undefined ? `${cold.parts.workers} workers, ${cold.parts.parts} parts` : `in one go${cold.parts?.inOneGo ? ` (${cold.parts.inOneGo})` : ""}`;
            console.log(
                `  ${mode.padEnd(5)} ${how}: first ${cold.ok ? "" : `FAILED ${cold.error} `}${cold.wall.toFixed(0)} ms (worker ${cold.ms?.toFixed(0)}, reading ${cold.input?.toFixed(0)}); ` +
                    (warm.ok
                        ? `warm median ${median(warm.times).toFixed(0)} ms (reading ${median(warm.inputTimes).toFixed(0)}) of ${warm.times.map((t) => t.toFixed(0)).join(", ")}; `
                        : `warm runs FAILED ${warm.error}; `) +
                    `memory: engine ${mib(coldStats.memory)}${coldStats.partMemory.length > 0 ? `, part workers ${mib(partMemory(coldStats))} (${coldStats.partMemory.length})` : ""}, ` +
                    `after the warm runs ${mib(warmStats.memory + partMemory(warmStats))}; output ${cold.bytes} characters, sha-256 ${cold.sha}…`,
            );
        } finally {
            await page.close();
        }
    }
}

server.close();
