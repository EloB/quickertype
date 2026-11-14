// The package itself, after `npm run build`: a port of quicktype's
// test/unit/core-package.test.ts (no output at import, no `node:` imports
// in browser-compatible code, CommonJS and ES module entry points, the
// tarball, a browser bundle, declaration files), plus the declaration
// files being byte-identical to the reference build when one is around.

import assert from "node:assert/strict";
import { execFileSync, execSync } from "node:child_process";
import * as fs from "node:fs";
import { createRequire } from "node:module";
import * as path from "node:path";
import { test } from "node:test";
import { fileURLToPath, pathToFileURL } from "node:url";

import * as esbuild from "esbuild";

const require = createRequire(import.meta.url);
const packageRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const repositoryRoot = path.join(packageRoot, "..", "..");
const dist = path.join(packageRoot, "dist");

function walk(directory, keep) {
    const files = [];
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
        const full = path.join(directory, entry.name);
        if (entry.isDirectory()) files.push(...walk(full, keep));
        else if (keep(entry.name)) files.push(full);
    }

    return files.sort();
}

test("does not write to stdout when imported", () => {
    for (const args of [
        ["-e", `require(${JSON.stringify(packageRoot)});`],
        ["--input-type=module", "-e", `await import(${JSON.stringify(pathToFileURL(path.join(dist, "esm", "index.js")).href)});`],
    ]) {
        assert.equal(execFileSync(process.execPath, args, { encoding: "utf8" }), "");
    }
});

test("does not use node:-prefixed imports in browser-compatible source", () => {
    const pattern = /(?:from\s+|import\s*\(\s*|require\s*\(\s*)["']node:/;
    const offenders = walk(path.join(packageRoot, "src"), (n) => n.endsWith(".ts")).flatMap((file) =>
        fs
            .readFileSync(file, "utf8")
            .split("\n")
            .filter((line) => pattern.test(line))
            .map((line) => `${path.relative(packageRoot, file)}: ${line.trim()}`),
    );
    assert.deepEqual(offenders, []);
});

test("require() and import resolve to the CommonJS and ES module builds", () => {
    // A package resolves its own name through "exports".
    const resolved = execFileSync(process.execPath, ["-p", "require.resolve('quickertype-core')"], {
        cwd: packageRoot,
        encoding: "utf8",
    }).trim();
    assert.equal(resolved, path.join(dist, "index.js"));
    const imported = execFileSync(
        process.execPath,
        ["--input-type=module", "-e", "console.log(import.meta.resolve('quickertype-core'))"],
        { cwd: packageRoot, encoding: "utf8" },
    ).trim();
    assert.equal(imported, pathToFileURL(path.join(dist, "esm", "index.js")).href);
});

test("the ES module build loads as real ESM and generates code on WebAssembly", () => {
    const entry = pathToFileURL(path.join(dist, "esm", "index.js")).href;
    const bridge = pathToFileURL(path.join(dist, "esm", "native", "bridge.js")).href;
    const script = `
        const { quicktype, InputData, jsonInputForTargetLanguage } = await import(${JSON.stringify(entry)});
        const { engineStats } = await import(${JSON.stringify(bridge)});
        const input = jsonInputForTargetLanguage("typescript");
        await input.addSource({ name: "Person", samples: ['{"name":"Alice","age":30}'] });
        const inputData = new InputData();
        inputData.addInput(input);
        const result = await quicktype({ inputData, lang: "typescript" });
        if (result.lines.length === 0) throw new Error("no output");
        console.log(engineStats.wasm === 1 ? "ok" : "not on WebAssembly");
    `;
    const stdout = execFileSync(process.execPath, ["--input-type=module", "-e", script], { encoding: "utf8" });
    assert.equal(stdout.trim(), "ok");
});

test("npm pack includes both builds, the ESM marker, the engine and the licence files", () => {
    const [{ files, size, unpackedSize }] = JSON.parse(execSync("npm pack --dry-run --json", { cwd: packageRoot, encoding: "utf8" }));
    const paths = new Set(files.map((f) => f.path));
    for (const required of [
        "dist/index.js",
        "dist/index.d.ts",
        "dist/esm/index.js",
        "dist/esm/index.d.ts",
        "dist/esm/package.json",
        "dist/native/wasm/glue.js",
        "dist/esm/native/wasm/glue.js",
        "dist/native/wasm/quicktype_wasm_bg.wasm",
        "README.md",
        "LICENSE",
        "NOTICE",
    ]) {
        assert.ok(paths.has(required), `tarball must contain ${required}`);
    }

    assert.ok(!paths.has("dist/esm/native/wasm/quicktype_wasm_bg.wasm"), "the engine is shipped once");
    assert.deepEqual(JSON.parse(fs.readFileSync(path.join(dist, "esm", "package.json"), "utf8")), { type: "module" });
    console.log(`tarball: ${(size / 1024 / 1024).toFixed(2)} MiB packed, ${(unpackedSize / 1024 / 1024).toFixed(2)} MiB unpacked`);
});

test("the ES module build bundles for the browser", async () => {
    const result = await esbuild.build({
        entryPoints: [path.join(dist, "esm", "index.js")],
        bundle: true,
        write: false,
        platform: "browser",
        logLevel: "silent",
    });
    assert.deepEqual(result.errors, []);
    assert.ok(result.outputFiles[0].contents.length > 0);
});

test("declaration files only reference dependencies that resolve with types", () => {
    const pattern = /(?:from\s+|import\s*\(\s*)["']([^"']+)["']|\/\/\/\s*<reference\s+types\s*=\s*["']([^"']+)["']/g;
    const { dependencies } = JSON.parse(fs.readFileSync(path.join(packageRoot, "package.json"), "utf8"));
    const shipsTypes = (name) => {
        try {
            const manifestPath = require.resolve(`${name}/package.json`, { paths: [packageRoot] });
            const manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
            return (
                manifest.types !== undefined ||
                manifest.typings !== undefined ||
                JSON.stringify(manifest.exports ?? null).includes('"types"') ||
                fs.existsSync(path.join(path.dirname(manifestPath), "index.d.ts"))
            );
        } catch {
            return false;
        }
    };
    const offenders = [];
    for (const file of walk(dist, (n) => n.endsWith(".d.ts"))) {
        for (const match of fs.readFileSync(file, "utf8").matchAll(pattern)) {
            const specifier = match[1] ?? match[2];
            if (specifier.startsWith(".")) continue;
            const parts = specifier.split("/");
            const name = specifier.startsWith("@") ? parts.slice(0, 2).join("/") : parts[0];
            const typesName = name.startsWith("@") ? `@types/${name.slice(1).replace("/", "__")}` : `@types/${name}`;
            if (dependencies[name] === undefined) offenders.push(`${file}: ${specifier} is not a runtime dependency`);
            else if (dependencies[typesName] === undefined && !shipsTypes(name)) offenders.push(`${file}: ${specifier} has no types`);
        }
    }

    assert.deepEqual(offenders, []);
});

test("the vendored files the bridge depends on are unchanged", async () => {
    const { createHash } = await import("node:crypto");
    const { guarded } = JSON.parse(fs.readFileSync(path.join(packageRoot, "src", "native", "UPSTREAM.json"), "utf8"));
    assert.ok(Object.keys(guarded).length > 10);
    const changed = Object.entries(guarded)
        // The files modified here; their hashes are upstream's.
        .filter(([file]) => !["src/Run.ts", "src/input/CompressedJSON.ts", "src/input/Inputs.ts"].includes(file))
        .filter(([file, hash]) => createHash("sha256").update(fs.readFileSync(path.join(packageRoot, file))).digest("hex") !== hash)
        .map(([file]) => file);
    assert.deepEqual(changed, []);
});

/**
 * What src/ changes in two upstream files besides Run.ts, as [ours,
 * upstream] pairs: the hook of the JSON samples reader, and samples given as
 * bytes (README, "JSON samples as bytes"), typed and decoded.
 */
const modifiedParts = {
    "input/CompressedJSON.ts": [
        ['import { readSampleNatively, sampleText } from "../native/hook.js";\n', ""],
        [
            "        // quicktype-wasm: the WebAssembly engine reads the sample if it can,\n" +
                "        // and a sample may be the bytes of UTF-8 text.\n" +
                "        const value = readSampleNatively(this, input);\n" +
                "        if (value !== undefined) return value;\n\n",
            "",
        ],
        ["const json = JSON.parse(sampleText(input) as string);", "const json = JSON.parse(input);"],
        ["extends CompressedJSON<string | Uint8Array> {", "extends CompressedJSON<string> {"],
        ["public async parse(input: string | Uint8Array): Promise<Value> {", "public async parse(input: string): Promise<Value> {"],
        ["public parseSync(input: string | Uint8Array): Value {", "public parseSync(input: string): Value {"],
    ],
    "input/Inputs.ts": [["): JSONInput<string | Uint8Array> {", "): JSONInput<string> {"]],
};

/** `text` with each of `parts` replaced, once, by its upstream text. */
function upstreamOf(text, parts) {
    for (const [ours, upstream] of parts) {
        assert.ok(text.includes(ours), ours);
        text = text.replace(ours, upstream);
    }

    return text;
}

test("CompressedJSON.ts and Inputs.ts are upstream's but for the samples reader's hook and byte samples", (t) => {
    const configured = process.env.QUICKTYPE_REFERENCE;
    const candidates = configured ? [configured] : [path.join(repositoryRoot, "..", "quicktype"), path.join(repositoryRoot, "..", "..", "quicktype")];
    for (const [file, parts] of Object.entries(modifiedParts)) {
        const upstream = candidates.map((c) => path.join(c, "packages", "quicktype-core", "src", file)).find((f) => fs.existsSync(f));
        if (upstream === undefined) {
            t.skip("no reference checkout");
            return;
        }

        const ours = fs.readFileSync(path.join(packageRoot, "src", file), "utf8");
        assert.equal(upstreamOf(ours, parts), fs.readFileSync(upstream, "utf8"), file);
    }
});

test("declaration files are byte-identical to the reference build", (t) => {
    const configured = process.env.QUICKTYPE_REFERENCE;
    const candidates = configured ? [configured] : [path.join(repositoryRoot, "..", "quicktype"), path.join(repositoryRoot, "..", "..", "quicktype")];
    const referenceDist = candidates
        .map((c) => path.join(c, "packages", "quicktype-core", "dist"))
        .find((d) => fs.existsSync(path.join(d, "index.d.ts")));
    if (referenceDist === undefined) {
        t.skip("no built reference checkout");
        return;
    }

    const declarations = walk(referenceDist, (n) => n.endsWith(".d.ts")).map((f) => path.relative(referenceDist, f));
    assert.ok(declarations.length > 400);
    // But for JSON samples given as bytes, which the types of two
    // declarations take too.
    const widened = {
        [path.join("input", "CompressedJSON.d.ts")]: [
            ["extends CompressedJSON<string | Uint8Array> {", "extends CompressedJSON<string> {"],
            ["parse(input: string | Uint8Array): Promise<Value>;", "parse(input: string): Promise<Value>;"],
            ["parseSync(input: string | Uint8Array): Value;", "parseSync(input: string): Value;"],
        ],
        [path.join("input", "Inputs.d.ts")]: [["): JSONInput<string | Uint8Array>;", "): JSONInput<string>;"]],
    };
    const different = declarations.filter((f) => {
        const ours = path.join(dist, f);
        if (!fs.existsSync(ours)) return true;
        const reference = fs.readFileSync(path.join(referenceDist, f), "utf8");
        const text = fs.readFileSync(ours, "utf8");
        // The CommonJS and ES module trees alike.
        const parts = widened[f.replace(/^esm[\\/]/, "")];
        return (parts === undefined ? text : upstreamOf(text, parts)) !== reference;
    });
    assert.deepEqual(different, []);
});
