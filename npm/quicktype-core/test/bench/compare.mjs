// WebAssembly against TypeScript, warm, in process: pokedex and generated
// inputs of about 2 MB and 20 MB (generate.mjs), each read with
// `addSource` and turned into TypeScript with `quicktypeMultiFile`
// (workload.mjs). In Node by default; with --browser in headless Chrome
// (the ES module build bundled with esbuild, as test/browser/smoke.mjs
// does).
//
//   node --expose-gc test/bench/compare.mjs [--browser] [--only REGEX] [--rounds N] [--json]
//        [--variant NAME=PACKAGE_DIR ...] [--cold N] [--again]
//
// The sides are this package on WebAssembly and on TypeScript; with
// --variant, each named copy of the package (a directory with its
// package.json and built dist/, e.g. an older build) on WebAssembly, and
// the first one on TypeScript, all interleaved in one process, so that
// they can be compared on a busy machine. Prints the medians (ms) of
// reading the input (addSource), generating the code (the run) and the
// total, and in Node the CPU time of a run.
//
// With --cold N, each side instead does its first run only, in a fresh
// Node process or a fresh headless Chrome, N times (the medians). In Node
// that includes compiling the engine, which happens on first use; in
// Chrome the page compiles it first, as the playground does when it
// starts, so the first run includes instantiating it.
//
// With --again (warm only), each round also runs the same input a second
// time, and its median is printed after the total ("again").

import * as fs from "node:fs";
import * as http from "node:http";
import { createRequire } from "node:module";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { evaluateInChrome } from "./chrome.mjs";
import { benchInputs } from "./inputs.mjs";
import { measure, medians } from "./workload.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const packageRoot = path.join(here, "..", "..");
const require = createRequire(import.meta.url);

const args = process.argv.slice(2);
const option = (name) => {
    const i = args.indexOf(name);
    return i < 0 ? undefined : args[i + 1];
};
const only = option("--only") === undefined ? undefined : new RegExp(option("--only"));
const fixedRounds = option("--rounds") === undefined ? undefined : Number(option("--rounds"));
const variants = args.flatMap((a, i) => (args[i - 1] === "--variant" ? [a.split("=")] : []));
if (variants.length === 0) variants.push(["WebAssembly", packageRoot]);
const tsSide = "TypeScript";

const cold = option("--cold") === undefined ? undefined : Number(option("--cold"));
const again = args.includes("--again");
const inputs = benchInputs
    .filter(([name]) => only === undefined || only.test(name))
    .map(([name, make]) => ({ name, text: make() }));

async function inNode() {
    const sides = variants.map(([name, dir]) => {
        // Warm: the engine is loaded, as the page below loads it (a small
        // JSON sample does not compile it).
        require(path.join(path.resolve(dir), "dist", "native", "engine.js")).engineSync();
        return {
            name,
            qt: require(path.resolve(dir)),
            stats: require(path.join(path.resolve(dir), "dist", "native", "bridge.js")).engineStats,
            ts: false,
        };
    });
    sides.push({ ...sides[0], name: tsSide, ts: true });
    return measure(sides, inputs, {
        again,
        ...(fixedRounds === undefined ? {} : { rounds: () => fixedRounds }),
        gc: typeof globalThis.gc === "function" ? globalThis.gc : undefined,
        cpu: () => {
            const { user, system } = process.cpuUsage();
            return (user + system) / 1000;
        },
        onProgress: (name, i, n) => process.stderr.write(`\r${name}: ${i}/${n}   `),
    });
}

/** How long a page of the benchmark may take: every round of every input. */
const pageTimeoutMs = 60 * 60_000;

/** Evaluates `expression` in the page at `url` of a headless Chrome until it gives a result. */
function inChrome(url, expression) {
    return evaluateInChrome(url, { expression, timeoutMs: pageTimeoutMs, args: ["--js-flags=--expose-gc"], pollMs: 500 });
}

async function inBrowser() {
    const esbuild = await import("esbuild");
    const outDir = path.join(packageRoot, "build", "bench");
    fs.mkdirSync(outDir, { recursive: true });
    // Every copy is imported with the TypeScript engine forced, so that
    // none starts compiling an engine of its own; then each is handed its
    // module and loads it, one after the other.
    const imports = variants
        .map(
            ([, dir], i) => `import * as qt${i} from ${JSON.stringify(path.join(path.resolve(dir), "dist", "esm", "index.js"))};
import { engineStats as stats${i} } from ${JSON.stringify(path.join(path.resolve(dir), "dist", "esm", "native", "bridge.js"))};
import { engineSync as engine${i} } from ${JSON.stringify(path.join(path.resolve(dir), "dist", "esm", "native", "engine.js"))};`,
        )
        .join("\n");
    fs.writeFileSync(
        path.join(outDir, "force-ts.mjs"),
        'globalThis[Symbol.for("quicktype-core.engine")] = "ts";\n',
    );
    fs.writeFileSync(
        path.join(outDir, "entry.mjs"),
        `import "./force-ts.mjs";
${imports}
import { measure } from ${JSON.stringify(path.join(here, "workload.mjs"))};
const out = document.getElementById("result");
const moduleKey = Symbol.for("quicktype-core.wasmModule");
try {
    delete globalThis[Symbol.for("quicktype-core.engine")];
    const sides = [];
${variants
    .map(
        ([name], i) => `    globalThis[moduleKey] = await WebAssembly.compileStreaming(fetch("/engine${i}.wasm"));
    if (engine${i}() === undefined) throw new Error("${name}: the engine did not load");
    sides.push({ name: ${JSON.stringify(name)}, qt: qt${i}, stats: stats${i}, ts: false });`,
    )
    .join("\n")}
    sides.push({ ...sides[0], name: ${JSON.stringify(tsSide)}, ts: true });
    const inputs = await (await fetch("/inputs.json")).json();
    const results = await measure(sides, inputs, {
        again: ${again},
        ${fixedRounds === undefined ? "" : `rounds: () => ${fixedRounds},`}
        gc: typeof gc === "function" ? gc : undefined,
    });
    out.textContent = JSON.stringify({ results });
} catch (e) {
    out.textContent = JSON.stringify({ error: String(e?.stack ?? e) });
}
`,
    );
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
    };
    variants.forEach(([, dir], i) => {
        files[`/engine${i}.wasm`] = ["application/wasm", fs.readFileSync(path.join(path.resolve(dir), "dist", "native", "wasm", "quicktype_wasm_bg.wasm"))];
    });
    const server = http.createServer((request, response) => {
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
    try {
        const url = `http://127.0.0.1:${server.address().port}/index.html`;
        const result = JSON.parse(await inChrome(url, 'document.getElementById("result")?.textContent ?? "pending"'));
        if (result.error !== undefined) throw new Error(result.error);
        return result.results;
    } finally {
        server.close();
    }
}

/** The sides of a cold measurement: each variant on WebAssembly, the first on TypeScript. */
const coldSides = () => [...variants.map(([name, dir]) => ({ name, dir, ts: false })), { name: tsSide, dir: variants[0][1], ts: true }];

/** --cold in Node: each run in a fresh process. */
async function coldNode() {
    const { execFileSync } = await import("node:child_process");
    const results = [];
    for (const { name } of inputs) {
        const runs = coldSides().map(() => []);
        for (let i = 0; i < cold; i++) {
            coldSides().forEach((side, k) => {
                const out = execFileSync(process.execPath, [path.join(here, "cold-node.mjs"), side.dir, side.ts ? "ts" : "wasm", name], {
                    encoding: "utf8",
                    maxBuffer: 1 << 20,
                });
                runs[k].push(JSON.parse(out));
                process.stderr.write(`\r${name}: ${i + 1}/${cold}   `);
            });
        }

        results.push({ name, runs: cold, sides: Object.fromEntries(coldSides().map((s, k) => [s.name, medians(runs[k])])) });
    }

    return results;
}

/** --cold in Chrome: each run in a fresh browser, after the page compiled the engine. */
async function coldBrowser() {
    const esbuild = await import("esbuild");
    const outDir = path.join(packageRoot, "build", "bench");
    fs.mkdirSync(outDir, { recursive: true });
    const files = {};
    variants.forEach(([, dir], i) => {
        const entry = path.join(outDir, `cold${i}.mjs`);
        fs.writeFileSync(
            entry,
            `import * as qt from ${JSON.stringify(path.join(path.resolve(dir), "dist", "esm", "index.js"))};
import { coldRun } from ${JSON.stringify(path.join(here, "workload.mjs"))};
export { qt, coldRun };
`,
        );
        files[`/engine${i}.wasm`] = ["application/wasm", fs.readFileSync(path.join(path.resolve(dir), "dist", "native", "wasm", "quicktype_wasm_bg.wasm"))];
    });
    await esbuild.build({
        entryPoints: variants.map((_, i) => path.join(outDir, `cold${i}.mjs`)),
        bundle: true,
        format: "esm",
        platform: "browser",
        outdir: outDir,
        logLevel: "silent",
    });
    variants.forEach((_, i) => {
        files[`/cold${i}.js`] = ["text/javascript", fs.readFileSync(path.join(outDir, `cold${i}.js`))];
    });
    const page = (i, ts, inputIndex) => `<!doctype html><meta charset="utf-8"><pre id="result">pending</pre>
<script type="module">
    const out = document.getElementById("result");
    try {
        const text = await (await fetch("/input${inputIndex}.json")).text();
        ${
            ts
                ? 'globalThis[Symbol.for("quicktype-core.engine")] = "ts";'
                : `globalThis[Symbol.for("quicktype-core.wasmModule")] = await WebAssembly.compileStreaming(fetch("/engine${i}.wasm"));`
        }
        const { qt, coldRun } = await import("/cold${i}.js");
        await new Promise((resolve) => setTimeout(resolve, 100));
        out.textContent = JSON.stringify(await coldRun(qt, text, ${ts}));
    } catch (e) {
        out.textContent = JSON.stringify({ error: String(e?.stack ?? e) });
    }
</script>`;
    inputs.forEach(({ text }, j) => {
        files[`/input${j}.json`] = ["application/json", text];
    });
    const sides = [...variants.map(([name], i) => ({ name, i, ts: false })), { name: tsSide, i: 0, ts: true }];
    sides.forEach((side, k) => {
        inputs.forEach((_, j) => {
            files[`/page${k}-${j}.html`] = ["text/html", page(side.i, side.ts, j)];
        });
    });
    const server = http.createServer((request, response) => {
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
    try {
        const results = [];
        for (const [j, { name }] of inputs.entries()) {
            const runs = sides.map(() => []);
            for (let r = 0; r < cold; r++) {
                for (let k = 0; k < sides.length; k++) {
                    const url = `http://127.0.0.1:${server.address().port}/page${k}-${j}.html`;
                    const result = JSON.parse(await inChrome(url, 'document.getElementById("result")?.textContent ?? "pending"'));
                    if (result.error !== undefined) throw new Error(result.error);
                    runs[k].push(result);
                    process.stderr.write(`\r${name}: ${r + 1}/${cold}   `);
                }
            }

            results.push({ name, runs: cold, sides: Object.fromEntries(sides.map((s, k) => [s.name, medians(runs[k])])) });
        }

        return results;
    } finally {
        server.close();
    }
}

const browser = args.includes("--browser");
const results =
    cold !== undefined ? (browser ? await coldBrowser() : await coldNode()) : browser ? await inBrowser() : await inNode();
process.stderr.write("\n");
const host = `${browser ? "headless Chrome" : `Node ${process.version}`}${cold === undefined ? ", warm" : ", cold (first run)"}`;
if (args.includes("--json")) {
    console.log(JSON.stringify({ host, results }, undefined, 1));
} else {
    const ms = (x) => (x < 10 ? x.toFixed(2) : x < 100 ? x.toFixed(1) : x.toFixed(0));
    console.log(`${host}: medians in ms, read input + generate = total${browser || cold !== undefined ? "" : " (CPU time)"}; × is TypeScript's total over the side's`);
    for (const r of results) {
        console.log(`${r.name}, ${r.runs} runs each:`);
        const ts = r.sides[tsSide];
        for (const [name, t] of Object.entries(r.sides)) {
            const cpu = t.cpu === undefined ? "" : ` (${ms(t.cpu)})`;
            const ratio = name === tsSide ? "" : `  ${(ts.total / t.total).toFixed(2)}×`;
            const second = t.again === undefined ? "" : `; again ${ms(t.again).padStart(7)}`;
            console.log(`  ${name.padEnd(14)} ${ms(t.read).padStart(7)} + ${ms(t.generate).padStart(7)} = ${ms(t.total).padStart(7)}${cpu}${second}${ratio}`);
        }
    }
}
