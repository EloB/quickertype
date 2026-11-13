#!/usr/bin/env node
// Measures how deeply nested a JSON Schema the reference JSONSchemaInput can
// handle before Node's stack overflows ("Maximum call stack size
// exceeded"), per recursion path. The Rust port models these limits
// (`Edge` and `ADD_IDS_DEPTH_LIMIT` in input/json_schema_input.rs, pinned
// by crates/quicktype-core/tests/deep_schemas.rs).
//
// usage: node xtask/core-json-schema-input/measure-stack-depth.mjs <path/to/quicktype>
//
// Every probe runs in a fresh Node process, like a CLI run: within one
// process the threshold drifts as V8 optimizes the recursion and its frames
// shrink. Near the threshold a run can still go either way (concurrent
// compilation), so the script reports the last depth that succeeded in
// three runs out of three.

import { spawnSync } from "node:child_process";
import { createRequire } from "node:module";
import { join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { referenceCheckout } from "../reference.mjs";

const shapes = {
    items: ['{"type":"array","items":', "}"],
    tuple: ['{"type":"array","items":[', "]}"],
    properties: ['{"type":"object","properties":{"a":', "}}"],
    allOf: ['{"allOf":[', "]}"],
    oneOf: ['{"oneOf":[', "]}"],
    anyOf: ['{"anyOf":[', "]}"],
    "properties+items": ['{"type":"object","properties":{"a":{"type":"array","items":', "}}}"],
    "plain JSON (addIDs)": ['{"x":', "}"],
};

const [mode, quicktypeArg, shape, depth] = process.argv.slice(2);

if (mode === "--child") {
    const dist = join(resolve(quicktypeArg), "packages/quicktype-core/dist");
    const require = createRequire(join(dist, "index.js"));
    const { JSONSchemaInput } = require(join(dist, "input/JSONSchemaInput.js"));
    const { TypeBuilder } = require(join(dist, "Type/TypeBuilder.js"));
    const { TypeGraph } = require(join(dist, "Type/TypeGraph.js"));
    const { getNoStringTypeMapping } = require(join(dist, "Type/TypeBuilderUtils.js"));
    const [open, close] = shapes[shape];
    const n = Number(depth);
    const text = open.repeat(n) + '{"type":"string"}' + close.repeat(n);
    const report = (s) => {
        console.log(s);
        process.exit(0);
    };
    process.on("uncaughtException", (e) => report(`error ${e.message}`));
    process.on("unhandledRejection", (e) => report(`error ${e.message}`));
    const input = new JSONSchemaInput(undefined);
    await input.addSource({ name: "T", schema: text });
    const builder = new TypeBuilder(getNoStringTypeMapping(), false, false, true, false);
    builder.typeGraph = new TypeGraph(builder, 0, true);
    try {
        await input.addTypes({ debugPrintSchemaResolving: false, time: (_n, f) => f() }, builder);
        report("ok");
    } catch (e) {
        report(`error ${e.message}`);
    }
} else {
    const self = fileURLToPath(import.meta.url);
    const quicktype = referenceCheckout(mode);
    const ok = (s, n) =>
        spawnSync(process.execPath, [self, "--child", quicktype, s, String(n)], { encoding: "utf8" }).stdout.trim() === "ok";
    for (const s of Object.keys(shapes)) {
        let lo = 1;
        let hi = 20000;
        while (lo < hi) {
            const mid = (lo + hi) >> 1;
            if (ok(s, mid)) lo = mid + 1;
            else hi = mid;
        }
        // Step down until three runs in a row succeed.
        let last = lo - 1;
        while (last > 0 && ![0, 1, 2].every(() => ok(s, last))) last--;
        console.log(`${s}: last depth that succeeds ${last}, first that overflows ${last + 1}`);
    }
}
