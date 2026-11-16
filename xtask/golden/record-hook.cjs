// Preloaded (via NODE_OPTIONS=--require) into the reference quicktype fixture
// harness. It intercepts every in-process call to the CLI `main(opts)` in
// `src/index.ts`, converts the options object into the equivalent argv, runs
// the *real* CLI code path with that argv, and records:
//
//   - the argv (with repo paths templated as {ROOT}/...)
//   - every file the step created or modified in its working directory
//
// The result is a set of replayable "run `quicktype <args>`, expect exactly
// these bytes" cases, independent of the TypeScript implementation.
//
// Env:
//   GOLDEN_RAW_DIR  where to write raw per-run recordings (required)

"use strict";

const Module = require("node:module");
const path = require("node:path");
const fs = require("node:fs");

const OUT = process.env.GOLDEN_RAW_DIR;
const ROOT = process.cwd();
const TARGET = path.join(ROOT, "src", "index.ts");

// The harness names each run's directory test/runs/<fixture>-<3 random
// bytes, in hex> (getRunDirectory in test/fixtures.ts). Over about 11,000
// runs, two runs of one fixture draw the same name in a few percent of
// recordings; the recordings, keyed by that name, would then merge into
// one case (and, with CI set, the harness deletes each directory after its
// run, so the second makes it afresh). Each run gets a name of its own
// instead: the cluster worker's id (8 bits) and a count of the worker's
// runs (16 bits; a recording is about 10,000 runs in all). The name is the
// harness's alone; nothing recorded contains it.

// The names given (their hex part), to check each recorded run's.
const givenNames = new Set();

function uniqueRunNames() {
    const crypto = require("node:crypto");
    const cluster = require("node:cluster");
    const randomBytes = crypto.randomBytes;
    let runs = 0;
    crypto.randomBytes = function (size, callback) {
        if (size !== 3 || callback !== undefined || !/\bgetRunDirectory\b/.test(new Error().stack ?? "")) {
            return randomBytes.apply(this, arguments);
        }
        const worker = cluster.worker?.id ?? 0;
        if (worker > 0xff || runs > 0xffff) {
            throw new Error(`recorder: no unique run directory name for worker ${worker}'s run ${runs}`);
        }
        const n = (worker << 16) | runs++;
        const bytes = Buffer.from([(n >> 16) & 0xff, (n >> 8) & 0xff, n & 0xff]);
        givenNames.add(bytes.toString("hex"));
        return bytes;
    };
    // For an ESM `import { randomBytes } from "node:crypto"` too.
    require("node:module").syncBuiltinESMExports();
}

if (OUT) {
    uniqueRunNames();
    const origLoad = Module._load;
    let wrapped;
    let core;

    function quicktypeCore() {
        if (!core) core = origLoad(path.join(ROOT, "node_modules", "quicktype-core"), null, false);
        return core;
    }

    function scan(dir, rel = "", acc = new Map()) {
        for (const e of fs.readdirSync(path.join(dir, rel), { withFileTypes: true })) {
            const r = rel ? path.join(rel, e.name) : e.name;
            if (e.isDirectory()) scan(dir, r, acc);
            else if (e.isFile()) {
                const st = fs.statSync(path.join(dir, r));
                acc.set(r, `${st.size}:${st.mtimeMs}`);
            }
        }
        return acc;
    }

    function dirsBelow(dir, rel = "", acc = []) {
        for (const e of fs.readdirSync(path.join(dir, rel), { withFileTypes: true })) {
            if (!e.isDirectory()) continue;
            const r = rel ? path.join(rel, e.name) : e.name;
            acc.push(r);
            dirsBelow(dir, r, acc);
        }
        return acc;
    }

    function toArgv(opts, cwd) {
        const real = [];
        const templ = [];
        const push = (...xs) => {
            real.push(...xs);
            templ.push(...xs);
        };
        const pushPath = (flag, p) => {
            const abs = path.resolve(cwd, p);
            let t;
            if (abs.startsWith(cwd + path.sep)) t = path.relative(cwd, abs);
            else if (abs.startsWith(ROOT + path.sep)) t = `{ROOT}/${path.relative(ROOT, abs)}`;
            else throw new Error(`recorder: path outside repo: ${abs}`);
            real.push(flag, abs.startsWith(cwd + path.sep) ? t : abs);
            templ.push(flag, t);
        };

        const known = new Set([
            "srcLang", "lang", "src", "out", "graphqlSchema", "topLevel",
            "alphabetizeProperties", "allPropertiesOptional", "rendererOptions",
            "quiet", "telemetry", "debug",
        ]);
        for (const [k, v] of Object.entries(opts)) {
            if (!known.has(k) && v !== undefined) throw new Error(`recorder: unhandled CLI option ${k}`);
        }

        if (opts.srcLang !== undefined) push("--src-lang", opts.srcLang);
        if (opts.lang !== undefined) push("--lang", opts.lang);
        for (const s of opts.src ?? []) pushPath("--src", s);
        if (opts.graphqlSchema !== undefined) pushPath("--graphql-schema", opts.graphqlSchema);
        if (opts.out !== undefined) push("--out", opts.out);
        if (opts.topLevel !== undefined) push("--top-level", opts.topLevel);
        if (opts.alphabetizeProperties) push("--alphabetize-properties");
        if (opts.allPropertiesOptional) push("--all-properties-optional");

        const defs = quicktypeCore().getTargetLanguage(opts.lang).cliOptionDefinitions.actual;
        const entries = Object.entries(opts.rendererOptions ?? {}).sort(([a], [b]) => (a < b ? -1 : a > b ? 1 : 0));
        for (const [k, v] of entries) {
            const def = defs.find((d) => d.name === k);
            if (def === undefined) throw new Error(`recorder: unknown renderer option ${k} for ${opts.lang}`);
            if (def.optionType === "boolean") {
                // Mirror BooleanOption.getValue: "true"/"false" are parsed,
                // anything else uses JS truthiness (e.g. "yes" is true).
                const on = v === "false" ? false : Boolean(v);
                push(on ? `--${k}` : `--no-${k}`);
            } else {
                push(`--${k}`, String(v));
            }
        }

        if (opts.quiet) push("--quiet");
        if (opts.telemetry !== undefined) push("--telemetry", opts.telemetry);
        if (opts.debug !== undefined) push("--debug", opts.debug);
        return { real, templ };
    }

    function makeWrapper(real) {
        async function main(opts) {
            if (Array.isArray(opts)) return real.main(opts);

            const cwd = process.cwd();
            // A run in a directory the harness named without us (if its
            // naming changed) could share it with another run.
            const name = path.basename(cwd);
            if (!givenNames.has(name.slice(-6))) {
                throw new Error(`recorder: the run directory ${name} was not named by uniqueRunNames (has getRunDirectory changed?)`);
            }
            const { real: argv, templ } = toArgv(opts, cwd);
            const before = scan(cwd);
            const firstStep = !fs.existsSync(path.join(OUT, path.basename(cwd), "run.json"));
            const preexistingDirs = firstStep ? dirsBelow(cwd).sort() : undefined;
            let error;
            try {
                await real.main(argv);
            } catch (e) {
                error = e;
            }
            const after = scan(cwd);
            const files = [...after]
                .filter(([p, s]) => before.get(p) !== s)
                .map(([p]) => p)
                .sort();

            const runDir = path.join(OUT, path.basename(cwd));
            fs.mkdirSync(runDir, { recursive: true });
            const casePath = path.join(runDir, "run.json");
            const rec = fs.existsSync(casePath)
                ? JSON.parse(fs.readFileSync(casePath, "utf8"))
                : { run: path.basename(cwd), preexistingDirs: preexistingDirs ?? [], steps: [] };
            const stepIndex = rec.steps.length;
            for (const f of files) {
                const dest = path.join(runDir, `step${stepIndex}`, f);
                fs.mkdirSync(path.dirname(dest), { recursive: true });
                fs.copyFileSync(path.join(cwd, f), dest);
            }
            rec.steps.push({
                args: templ,
                files,
                error: error === undefined ? null : String(error?.message ?? error),
            });
            fs.writeFileSync(casePath, JSON.stringify(rec, null, 2));

            if (error !== undefined) throw error;
        }
        return new Proxy(real, {
            get(t, k) {
                return k === "main" ? main : t[k];
            },
        });
    }

    Module._load = function (request, parent, isMain) {
        const loaded = origLoad.apply(this, arguments);
        if (typeof request !== "string" || !/(^|\/)src(\/index(\.ts)?)?$/.test(request)) return loaded;
        let resolved;
        try {
            resolved = Module._resolveFilename(request, parent, isMain);
        } catch {
            return loaded;
        }
        if (resolved !== TARGET) return loaded;
        if (!wrapped) wrapped = makeWrapper(loaded);
        return wrapped;
    };
}
