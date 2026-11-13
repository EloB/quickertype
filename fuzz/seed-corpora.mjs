#!/usr/bin/env node
// Builds the seed corpora of the fuzz targets (fuzz/corpus/<target>/) from
// the test inputs (tests/inputs, tests/golden) and the recorded vectors
// (crates/*/tests/vectors and fixtures). Deterministic; run from anywhere:
//
//     node fuzz/seed-corpora.mjs
//
// Existing corpus files are kept (libFuzzer adds its own finds there), so
// it can run again after the inputs change.

import { createHash } from "node:crypto";
import { mkdirSync, readFileSync, readdirSync, statSync, writeFileSync } from "node:fs";
import { dirname, join, relative } from "node:path";
import { fileURLToPath } from "node:url";

const fuzz = dirname(fileURLToPath(import.meta.url));
const root = join(fuzz, "..");

/// Seeds larger than this are left out: big inputs slow the fuzzer down
/// without reaching more code.
const MAX_SEED = 16 * 1024;

/// The number of built-in target languages (`default_target_languages`).
const LANGUAGES = 27;

let random = 1;
/// A deterministic byte (xorshift32).
function byte() {
  random ^= random << 13;
  random ^= random >>> 17;
  random ^= random << 5;
  return (random >>> 0) & 0xff;
}

const counts = {};
function seed(target, data) {
  const bytes = typeof data === "string" ? Buffer.from(data, "utf8") : Buffer.from(data);
  if (bytes.length > MAX_SEED) return;
  const dir = join(fuzz, "corpus", target);
  mkdirSync(dir, { recursive: true });
  const name = createHash("sha1").update(bytes).digest("hex");
  writeFileSync(join(dir, name), bytes);
  counts[target] = (counts[target] ?? 0) + 1;
}

function files(dir, filter = () => true) {
  const out = [];
  for (const entry of readdirSync(dir).sort()) {
    const path = join(dir, entry);
    if (statSync(path).isDirectory()) out.push(...files(path, filter));
    else if (filter(path)) out.push(path);
  }
  return out;
}

const read = (path) => readFileSync(path);
const readJSON = (path) => JSON.parse(readFileSync(join(root, path), "utf8"));

/// A `RunConfig` header (see fuzz/src/lib.rs): language, flags, inference
/// flags off, and `n` random renderer options.
function header(lang, flags, n = 0) {
  const bytes = [lang % LANGUAGES, flags, 0, n];
  for (let i = 0; i < 2 * n; i++) bytes.push(byte());
  return Buffer.from(bytes);
}

const cat = (...parts) => Buffer.concat(parts.map((p) => (typeof p === "string" ? Buffer.from(p, "utf8") : p)));

// ---- JSON --------------------------------------------------------------

const jsonFiles = [
  ...files(join(root, "tests/inputs/json"), (p) => p.endsWith(".json")),
  ...files(join(root, "tests/inputs/spotify-api")),
  ...files(join(root, "tests/inputs/urls")),
];
const jsonParseVectors = readJSON("crates/quicktype-js-compat/tests/vectors/json_parse.json");

jsonFiles.forEach((path, i) => {
  const text = read(path);
  seed("json_stream", cat(Buffer.from([i & 1]), text));
  seed("json_parse", cat(Buffer.from([i & 1]), text));
  seed("yaml", text);
  // Stream and JSON.parse semantics, plain and with random options.
  seed("pipeline", cat(header(i, 0), text));
  seed("pipeline", cat(header(i + 13, 0x04 | (byte() & 0xf3), 2), text));
});
for (const { input } of jsonParseVectors) {
  seed("json_parse", cat(Buffer.from([0]), input));
  seed("json_stream", cat(Buffer.from([0]), input));
}
// Several samples of one top-level, and several top-levels.
seed("pipeline", cat(header(0, 0), '{"a": 1}\0{"a": "x", "b": [1.5]}\0[]'));
seed("pipeline", cat(header(5, 0x08), '{"a": 1}\0{"b": {"c": null}}\0"s"'));

// ---- JSON Schema ---------------------------------------------------------

const schemaDir = join(root, "tests/inputs/schema");
const schemaFiles = files(schemaDir, (p) => p.endsWith(".schema"));
// The documents schemas refer to: `a/test2.json`, `simple-ref.1.ref`, ...
const extraDocuments = files(schemaDir, (p) => /\/[ab]\//.test(p) || p.endsWith(".ref"));
schemaFiles.forEach((path, i) => {
  const text = read(path);
  // By their paths relative to the schema.
  const documents = extraDocuments.map((doc) => cat("\0", relative(schemaDir, doc), "\n", read(doc)));
  const withDocuments = /"\$ref"\s*:\s*"[^#]/.test(text.toString()) ? documents : [];
  seed("json_schema", cat(header(i, 0), text, ...withDocuments));
  seed("json_schema", cat(header(i + 7, byte() & 0xd3, 1), text, ...withDocuments));
  seed("yaml", text);
});
// Definitions as top-levels, a second source, an additional schema.
const twoSchemas = '{"definitions": {"a": {"$ref": "b.json#/definitions/b"}, "c": {"type": "string"}}}\0b.json\n{"$id": "b.json", "definitions": {"b": {"type": "object", "properties": {"x": {"type": "integer"}}}}}';
seed("json_schema", cat(header(0, 0x04), twoSchemas));
seed("json_schema", cat(header(1, 0x08), twoSchemas));
seed("json_schema", cat(header(2, 0x20), twoSchemas));

// ---- YAML ------------------------------------------------------------------

for (const { text, path } of readJSON("crates/quicktype-js-compat/tests/vectors/yaml.json")) {
  seed("yaml", text ?? read(join(root, path)));
}

// ---- GraphQL ---------------------------------------------------------------

const graphqlDir = "crates/quicktype-graphql-input/tests/fixtures/graphql-input";
const fixedSchemas = {
  [`${graphqlDir}/schemas/basic.gqlschema`]: 0x00,
  [`${graphqlDir}/schemas/query-only.gqlschema`]: 0x08,
  "tests/inputs/graphql/github.gqlschema": 0x20,
};
const { cases } = readJSON(`${graphqlDir}/cases.json`);
cases.forEach(({ sources }, i) => {
  for (const { schemaFile, query } of sources) {
    seed("graphql_parse", query);
    const flags = fixedSchemas[schemaFile];
    if (flags !== undefined) seed("graphql_input", cat(header(i, flags), query));
  }
});
for (const path of files(join(root, "tests/inputs/graphql"), (p) => p.endsWith(".graphql"))) {
  seed("graphql_parse", read(path));
  seed("graphql_input", cat(header(byte(), 0x20), read(path)));
}
for (const [text] of readJSON(`${graphqlDir}/parse-vectors.json`)) seed("graphql_parse", text);
// A schema in the input: the basic schema's types without descriptions.
const basic = readJSON(`${graphqlDir}/schemas/basic.gqlschema`);
const strip = (v) =>
  Array.isArray(v)
    ? v.map(strip)
    : v && typeof v === "object"
      ? Object.fromEntries(Object.entries(v).filter(([k]) => k !== "description").map(([k, x]) => [k, strip(x)]))
      : v;
const types = basic.data.__schema.types.filter((t) => !t.name.startsWith("__"));
const small = { data: { __schema: { ...strip(basic.data.__schema), types: strip(types), directives: [] } } };
seed("graphql_input", cat(header(3, 0x04), JSON.stringify(small), "\0", "{ viewer { name } }"));

// ---- URIs ------------------------------------------------------------------

const uriVectors = readJSON("crates/quicktype-js-compat/tests/vectors/uri.json");
uriVectors.uris.forEach(({ input }, i) => {
  seed("uri", input);
  const base = uriVectors.uris[(i * 7919) % uriVectors.uris.length].input;
  if (!input.includes("\n")) seed("uri", `${input}\n${base}`);
});

// ---- Numbers ---------------------------------------------------------------

const numberVectors = readJSON("crates/quicktype-js-compat/tests/vectors/number.json");
numberVectors.to_string.forEach(([hex], i) => {
  if (i % 10 !== 0) return;
  const other = numberVectors.to_string[(i * 31) % numberVectors.to_string.length][0];
  const bytes = Buffer.alloc(16);
  bytes.writeBigUInt64LE(BigInt(`0x${hex}`), 0);
  bytes.writeBigUInt64LE(BigInt(`0x${other}`), 8);
  seed("number", cat(bytes, numberVectors.to_string[(i * 17) % numberVectors.to_string.length][1]));
});
for (const s of [" 12 ", "0x1F", "-0b101", "0o7", "1e309", ".5e-3", "+Infinity", "Infinityx", "", "  \t\n"]) {
  seed("number", cat(Buffer.alloc(16), s));
}

// ---- CLI arguments ---------------------------------------------------------

const argvs = new Set();
for (const path of files(join(root, "tests/golden"), (p) => p.endsWith("case.json"))) {
  const { steps } = JSON.parse(readFileSync(path, "utf8"));
  for (const { args } of steps) {
    argvs.add(args.map((a) => a.replaceAll("{INPUTS}", "inputs")).join("\0"));
  }
}
for (const argv of [...argvs].sort()) seed("cli_args", argv);

for (const [target, n] of Object.entries(counts).sort()) console.log(`${target}: ${n} seeds`);
