// The golden corpus (tests/golden), replayed through the JavaScript API:
// every non-CLI case's arguments become the options of one
// `quicktypeMultiFile` call, with the sample passed as a string (so it is
// read with JSON.parse semantics, the API's path, where the CLI streams
// files). GraphQL cases need quicktype-graphql-input and are left out.

import * as fs from "node:fs";
import * as path from "node:path";

import { goldenDir, inputsDir } from "../packages.mjs";

const globalValueFlags = new Set(["--src-lang", "--lang", "--src", "--out", "--top-level", "--telemetry", "--debug"]);
const globalBooleanFlags = new Set(["--quiet", "--alphabetize-properties"]);

function findCases() {
    const cases = [];
    const walk = (dir) => {
        for (const entry of fs.readdirSync(dir, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
            const full = path.join(dir, entry.name);
            if (entry.isDirectory()) walk(full);
            else if (entry.name === "case.json") cases.push(full);
        }
    };
    for (const fixture of fs.readdirSync(goldenDir).sort()) {
        if (fixture.startsWith("cli-") || fixture.startsWith("graphql-")) continue;
        const dir = path.join(goldenDir, fixture);
        if (fs.statSync(dir).isDirectory()) walk(dir);
    }

    return cases;
}

/** The API options of a golden case's (single) CLI step. */
function parseArgs(args) {
    const parsed = { rendererArgs: [], alphabetizeProperties: false };
    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        if (globalValueFlags.has(arg)) {
            parsed[arg.slice(2)] = args[++i];
        } else if (globalBooleanFlags.has(arg)) {
            if (arg === "--alphabetize-properties") parsed.alphabetizeProperties = true;
        } else {
            parsed.rendererArgs.push(arg);
        }
    }

    parsed.src = parsed.src.replace("{INPUTS}", inputsDir);
    return parsed;
}

/** Renderer option flags as `command-line-args` would read them, minus the defaults. */
function rendererOptions(qt, lang, rendererArgs) {
    const definitions = qt.getTargetLanguage(lang).cliOptionDefinitions.actual;
    const options = {};
    for (let i = 0; i < rendererArgs.length; i++) {
        const name = rendererArgs[i].replace(/^--/, "");
        const definition = definitions.find((d) => d.name === name);
        if (definition === undefined) throw new Error(`unknown option ${name}`);
        options[name] = definition.optionType === "boolean" ? true : rendererArgs[++i];
    }

    return options;
}

export function scenarios() {
    return findCases().map((file) => {
        const relative = path.relative(goldenDir, path.dirname(file));
        const [fixture] = relative.split(path.sep);
        const { steps } = JSON.parse(fs.readFileSync(file, "utf8"));
        const options = parseArgs(steps[0].args);
        return {
            id: `corpus/${relative}`,
            category: "corpus",
            group: fixture,
            lang: options.lang,
            async run(qt) {
                const renderer = rendererOptions(qt, options.lang, options.rendererArgs);
                const inputData = new qt.InputData();
                if (options["src-lang"] === "json") {
                    const input = qt.jsonInputForTargetLanguage(options.lang, undefined, true, renderer);
                    await input.addSource({
                        name: options["top-level"],
                        samples: [fs.readFileSync(options.src, "utf8")],
                    });
                    inputData.addInput(input);
                } else {
                    const input = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore(), [], []);
                    await input.addSource({ name: options["top-level"], uris: [options.src] });
                    inputData.addInput(input);
                }

                return await qt.quicktypeMultiFile({
                    lang: options.lang,
                    inputData,
                    outputFilename: path.basename(options.out),
                    alphabetizeProperties: options.alphabetizeProperties,
                    rendererOptions: renderer,
                    checkProvenance: options.debug === "provenance",
                });
            },
        };
    });
}
