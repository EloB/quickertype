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
// The languages and their options, and quicktype's general (run-level)
// options, are read from quicktype-core's API here, at build time, and
// embedded in main.js, so the page can show its controls before the worker
// has loaded. So is the quicktype commit the output matches, from
// tests/golden/REFERENCE, for the page's footer. File names carry a content
// hash, so a deploy never mixes old and new files; every URL is relative.

import { createHash } from "node:crypto";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { gzipSync } from "node:zlib";

import { quicktypeReference } from "./reference.mjs";
import { hashKeys } from "./src/hash.js";

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

/**
 * The page's defaults where they differ from quicktype's, by language (any
 * of its names) and option (CLI names). They mirror app.quicktype.io's
 * presets: the app starts each language from quicktype's own option
 * defaults and overrides exactly these. Every other option, `just-types`
 * included, keeps quicktype's default. The command under the output shows
 * them as flags.
 */
const presets = {
    objc: { "extra-comments": true },
    swift: { initializers: false },
    rust: { density: "dense" },
};

/**
 * A line under an option, by language and option: what leaving
 * `just-types` off adds, which is quicktype's default, for people who
 * expect types only (checked against the CLI on pokedex.json). Smithy4s
 * has none: its renderer does not read the option.
 */
const justTypesOff = (what) => ({ "just-types": `Off: ${what} (quicktype's default)` });
const hints = {
    typescript: justTypesOff("types plus runtime conversion code"),
    flow: justTypesOff("types plus runtime conversion code"),
    python: justTypesOff("classes plus from_dict/to_dict conversion code"),
    ruby: justTypesOff("types plus validating from_json!/to_json methods"),
    elixir: justTypesOff("types plus JSON decoding and encoding functions"),
    elm: justTypesOff("types plus JSON decoders and encoders"),
    dart: justTypesOff("classes plus fromJson/toJson methods"),
    go: justTypesOff("types plus a package clause and Unmarshal/Marshal functions"),
    haskell: justTypesOff("types plus a module header and aeson instances"),
    java: justTypesOff("classes plus Jackson annotations and a Converter class"),
    cplusplus: justTypesOff("classes plus nlohmann/json from_json/to_json functions"),
    objc: justTypesOff("classes plus JSON conversion methods"),
    swift: justTypesOff("types plus Codable conformance"),
    cs: justTypesOff("classes plus serialization code for the chosen framework"),
    kotlin: justTypesOff("classes plus serialization code for the chosen framework"),
    scala3: justTypesOff("types plus codecs for the chosen framework"),
};

const qt = require(path.join(packageRoot, "dist", "index.js"));

/** `table` (`{ language: { option: value } }`) by language, each named by one of its names. */
function byLanguage(table, what) {
    const result = new Map();
    for (const [name, options] of Object.entries(table)) {
        const language = qt.defaultTargetLanguages.find((l) => l.names.includes(name));
        if (language === undefined) throw new Error(`${what}: no language is named "${name}"`);
        if (result.has(language)) throw new Error(`${what}: ${language.displayName} is in it twice`);
        result.set(language, new Map(Object.entries(options)));
    }

    return result;
}

/** A preset `value` for `option`, if the option takes it and it is not quicktype's default. */
function checkedPreset(language, option, value) {
    const valid =
        option.type === "boolean"
            ? typeof value === "boolean"
            : option.type === "enum"
              ? option.values.includes(value)
              : typeof value === "string";
    const where = `presets: ${language.displayName} --${option.name}`;
    if (!valid) throw new Error(`${where} cannot be ${JSON.stringify(value)}`);
    if (value === option.defaultValue) throw new Error(`${where} is ${JSON.stringify(value)} by default already`);
    return value;
}

/** Every target language with its renderer options, from quicktype-core's API, and the page's presets and hints. */
function languages() {
    const presetsOf = byLanguage(presets, "presets");
    const hintsOf = byLanguage(hints, "hints");
    return qt.defaultTargetLanguages.map((language) => {
        const preset = presetsOf.get(language) ?? new Map();
        const hint = hintsOf.get(language) ?? new Map();
        const options = language.optionDefinitions.map((d) => {
            const option = {
                name: d.name,
                description: d.description,
                // "primary" options are shown, the others under "More options".
                kind: d.kind === "primary" ? "primary" : "secondary",
                type: d.optionType,
                defaultValue: d.defaultValue,
                ...(d.optionType === "enum" ? { values: Object.keys(d.values) } : {}),
                ...(d.optionType === "string" ? { typeLabel: d.typeLabel } : {}),
            };
            if (preset.has(d.name)) option.preset = checkedPreset(language, option, preset.get(d.name));
            if (hint.has(d.name)) option.hint = String(hint.get(d.name));
            preset.delete(d.name);
            hint.delete(d.name);
            return option;
        });
        for (const [what, left] of [["presets", preset], ["hints", hint]]) {
            if (left.size > 0) throw new Error(`${what}: ${language.displayName} has no option ${[...left.keys()].join(", ")}`);
        }

        return { displayName: language.displayName, names: [...language.names], extension: language.extension, options };
    });
}

/**
 * quicktype's general options, as the CLI has them: its flag (all off by
 * default), its label (the CLI's help text without the period), and the
 * `quicktype()` option it sets, to what. The `--no-*` switches are the
 * inference flags, named and described as quicktype's CLI does
 * (`negatedInferenceFlagName`, `negationDescription`).
 */
function generalOptions() {
    const dashed = (s) => s.replace(/[A-Z]/g, (c) => `-${c.toLowerCase()}`);
    return [
        { name: "all-properties-optional", label: "Make all class properties optional", option: "allPropertiesOptional", value: true },
        { name: "alphabetize-properties", label: "Alphabetize order of class properties", option: "alphabetizeProperties", value: true },
        ...qt.inferenceFlagNames.map((flag) => ({
            name: `no${dashed(flag.replace(/^infer/, "").replace(/^[a-z]/, (c) => c.toUpperCase()))}`,
            label: qt.inferenceFlags[flag].negationDescription,
            option: flag,
            value: !qt.defaultInferenceFlags[flag],
        })),
    ];
}

/**
 * Fails if two things would share a name: the URL hash's own keys, the
 * general options and a language's renderer options share the hash, and
 * the last two the command line, where a boolean `x` is also `--no-x`.
 */
function checkNames(languageList, general) {
    const taken = new Map(Object.values(hashKeys).map((key) => [key, `the URL hash's own "${key}"`]));
    const claim = (names, name, what) => {
        if (names.has(name)) throw new Error(`${what} has the name of ${names.get(name)}`);
        names.set(name, what);
    };
    for (const g of general) claim(taken, g.name, `the general option --${g.name}`);
    for (const language of languageList) {
        const names = new Map(taken);
        for (const o of language.options) {
            for (const name of o.type === "boolean" ? [o.name, `no-${o.name}`] : [o.name]) {
                claim(names, name, `${language.displayName}'s --${name}`);
            }
        }
    }
}

/** The quicktype commit the output matches (tests/golden/REFERENCE), with its date in words. */
function upstream() {
    const reference = quicktypeReference();
    const long = new Date(`${reference.date}T00:00:00Z`).toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric",
        timeZone: "UTC",
    });
    return { ...reference, long };
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

const languageList = languages();
const general = generalOptions();
checkNames(languageList, general);

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
        __LANGUAGES__: JSON.stringify(languageList),
        __GENERAL__: JSON.stringify(general),
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

const { commit, short, date, long } = upstream();
const html = fs
    .readFileSync(path.join(src, "index.html"), "utf8")
    .replace("%STYLE%", `./${styleFile}`)
    .replace("%MAIN%", `./${mainFile}`)
    .replaceAll("%QUICKTYPE_COMMIT%", commit)
    .replaceAll("%QUICKTYPE_SHORT%", short)
    .replaceAll("%QUICKTYPE_DATE%", date)
    .replaceAll("%QUICKTYPE_DATE_LONG%", long);
if (/%[A-Z_]+%/.test(html)) throw new Error(`a placeholder is left in index.html: ${/%[A-Z_]+%/.exec(html)[0]}`);
fs.writeFileSync(path.join(dist, "index.html"), html);

const kib = (n) => `${(n / 1024).toFixed(1)} KiB`;
console.log("site/dist:");
for (const file of [mainFile, styleFile, "index.html", workerFile, wasmFile]) {
    const content = fs.readFileSync(path.join(dist, file));
    console.log(`  ${file.padEnd(34)} ${kib(content.length).padStart(12)}  ${kib(gzipSync(content, { level: 9 }).length).padStart(11)} gzipped`);
}
