// Builds the playground into site/dist (a static site for GitHub Pages).
//
//   node site/build.mjs [--dev]
//
// Needs npm/quicktype-core built first (`npm ci && npm run build` there);
// esbuild comes from that package's devDependencies.
//
// * worker.js: quicktype-core (its ES module build) in a Web Worker;
// * main.js and style.css: the page;
// * quicktype.wasm: the engine, compiled by the worker and handed to
//   quicktype-core (see src/worker-boot.js);
// * samples/: inputs from quicktype's test suite (tests/inputs).
//
// The languages and their options are read from quicktype-core's API here,
// at build time, and embedded in main.js, so the page can show its controls
// before the worker has loaded. File names carry a content hash, so a
// deploy never mixes old and new files; every URL is relative.

import { createHash } from "node:crypto";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { gzipSync } from "node:zlib";

const siteRoot = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(siteRoot, "..");
const packageRoot = path.join(repositoryRoot, "npm", "quicktype-core");
const src = path.join(siteRoot, "src");
const dist = path.join(siteRoot, "dist");
const wasmSource = path.join(packageRoot, "dist", "native", "wasm", "quicktype_wasm_bg.wasm");
const dev = process.argv.includes("--dev");

if (!fs.existsSync(wasmSource) || !fs.existsSync(path.join(packageRoot, "dist", "esm", "index.js"))) {
    throw new Error("npm/quicktype-core is not built: cd npm/quicktype-core && npm ci && npm run build");
}

const require = createRequire(path.join(packageRoot, "package.json"));
const esbuild = require("esbuild");

/** The samples the page offers: quicktype's own test inputs. */
const samples = [
    { id: "pokedex", file: "json/samples/pokedex.json", kind: "json", label: "Pokédex", name: "Pokedex" },
    { id: "kitchen-sink", file: "json/samples/kitchen-sink.json", kind: "json", label: "Kitchen sink", name: "KitchenSink" },
    { id: "spotify-album", file: "json/samples/spotify-album.json", kind: "json", label: "Spotify album", name: "SpotifyAlbum" },
    { id: "bitcoin-block", file: "json/samples/bitcoin-block.json", kind: "json", label: "Bitcoin block", name: "BitcoinBlock" },
    { id: "github-events", file: "json/samples/github-events.json", kind: "json", label: "GitHub events", name: "GithubEvents" },
    { id: "us-senators", file: "json/samples/us-senators.json", kind: "json", label: "US senators", name: "UsSenators" },
    { id: "reddit", file: "json/samples/reddit.json", kind: "json", label: "Reddit listing", name: "Reddit" },
    { id: "description", file: "schema/description.schema", kind: "schema", label: "Descriptions", name: "Description" },
    { id: "date-time", file: "schema/date-time.schema", kind: "schema", label: "Dates and times", name: "DateTime" },
    { id: "direct-union", file: "schema/direct-union.schema", kind: "schema", label: "Definitions", name: "DirectUnion" },
];

/** Every target language with its renderer options, from quicktype-core's API. */
function languages() {
    const qt = require(path.join(packageRoot, "dist", "index.js"));
    return qt.defaultTargetLanguages.map((language) => ({
        displayName: language.displayName,
        names: [...language.names],
        extension: language.extension,
        options: language.optionDefinitions.map((d) => ({
            name: d.name,
            description: d.description,
            // "primary" options are shown, the others under "More options".
            kind: d.kind === "primary" ? "primary" : "secondary",
            type: d.optionType,
            defaultValue: d.defaultValue,
            ...(d.optionType === "enum" ? { values: Object.keys(d.values) } : {}),
            ...(d.optionType === "string" ? { typeLabel: d.typeLabel } : {}),
        })),
    }));
}

function hash(content) {
    return createHash("sha256").update(content).digest("hex").slice(0, 10);
}

function writeHashed(name, extension, content) {
    const file = `${name}-${hash(content)}.${extension}`;
    fs.writeFileSync(path.join(dist, file), content);
    return file;
}

async function bundle(entry, define) {
    const result = await esbuild.build({
        entryPoints: [path.join(src, entry)],
        bundle: true,
        format: "esm",
        platform: "browser",
        target: ["es2022", "chrome100", "firefox115", "safari16"],
        minify: !dev,
        sourcemap: false,
        legalComments: "none",
        write: false,
        define,
        logLevel: "warning",
        // quicktype-core's Node-only paths (reading files, `fs` in engine.js)
        // import from "fs" and "path", which its package.json maps to
        // nothing in browsers; they are never reached there.
        logOverride: { "import-is-undefined": "silent" },
    });
    return result.outputFiles[0].contents;
}

fs.rmSync(dist, { recursive: true, force: true });
fs.mkdirSync(path.join(dist, "samples"), { recursive: true });

const wasmFile = writeHashed("quicktype", "wasm", fs.readFileSync(wasmSource));
const workerFile = writeHashed(
    "worker",
    "js",
    await bundle("worker.js", { __WASM_FILE__: JSON.stringify(`./${wasmFile}`) }),
);
const mainFile = writeHashed(
    "main",
    "js",
    await bundle("main.js", {
        __WORKER_FILE__: JSON.stringify(`./${workerFile}`),
        __LANGUAGES__: JSON.stringify(languages()),
        __SAMPLES__: JSON.stringify(
            samples.map(({ file, ...sample }) => ({ ...sample, path: `samples/${path.basename(file)}` })),
        ),
    }),
);
const styleFile = writeHashed(
    "style",
    "css",
    (
        await esbuild.build({
            entryPoints: [path.join(src, "style.css")],
            bundle: true,
            minify: !dev,
            write: false,
            logLevel: "warning",
        })
    ).outputFiles[0].contents,
);

for (const { file } of samples) {
    fs.copyFileSync(path.join(repositoryRoot, "tests", "inputs", file), path.join(dist, "samples", path.basename(file)));
}

const html = fs
    .readFileSync(path.join(src, "index.html"), "utf8")
    .replace("%STYLE%", `./${styleFile}`)
    .replace("%MAIN%", `./${mainFile}`);
fs.writeFileSync(path.join(dist, "index.html"), html);

const kib = (n) => `${(n / 1024).toFixed(1)} KiB`;
console.log("site/dist:");
for (const file of [mainFile, styleFile, "index.html", workerFile, wasmFile]) {
    const content = fs.readFileSync(path.join(dist, file));
    console.log(`  ${file.padEnd(34)} ${kib(content.length).padStart(12)}  ${kib(gzipSync(content, { level: 9 }).length).padStart(11)} gzipped`);
}
