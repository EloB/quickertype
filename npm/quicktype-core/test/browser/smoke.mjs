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
import * as fs from "node:fs";
import * as http from "node:http";
import { createRequire } from "node:module";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import * as esbuild from "esbuild";

import { evaluateInChrome, findBrowser } from "../bench/chrome.mjs";
import { smoke } from "./scenario.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const packageRoot = path.join(here, "..", "..");
const require = createRequire(import.meta.url);
const outDir = path.join(packageRoot, "build", "browser");
const wasmFile = path.join(packageRoot, "dist", "native", "wasm", "quicktype_wasm_bg.wasm");

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
    return JSON.parse(await evaluateInChrome(url, { browser }));
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

// The JSON samples the engine read: those added once it was compiled (with
// the asset, the first two are added while it is still compiling).
const expectedSamplesRead = { asset: 1, supplied: 3, cjs: 1, ts: 0 };

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
        assert.equal(result.samplesRead, expectedSamplesRead[variant]);
        if (variant === "ts") {
            assert.deepEqual(server.requests.filter((r) => r.endsWith(".wasm")), [], "the .wasm was fetched");
        }
        console.log(`${variant}: ok (engines per step: ${JSON.stringify(result.engines)}, samples read by the engine: ${result.samplesRead})`);
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
