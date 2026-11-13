// What the browser smoke test does with quicktype-core, in the browser and,
// for the expected output, in Node.

const sample = '{"name": "Ann", "age": 7, "tags": ["a", "b"], "when": "2020-01-01T00:00:00Z", "pet": null}';

function syncRun(qt) {
    const input = qt.jsonInputForTargetLanguage("typescript");
    input.addSourceSync({ name: "Person", samples: [sample] });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return qt.quicktypeMultiFileSync({ lang: "typescript", inputData }).get("stdout").lines;
}

export async function smoke(qt, stats) {
    const engines = [];
    // Before the engine has been compiled (browsers compile asynchronously).
    const firstSync = syncRun(qt);
    engines.push({ wasm: stats.wasm, ts: stats.ts });

    const input = qt.jsonInputForTargetLanguage("rust");
    await input.addSource({ name: "Person", samples: [sample] });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    const asyncRun = await qt.quicktype({ lang: "rust", inputData });
    engines.push({ wasm: stats.wasm, ts: stats.ts });

    const secondSync = syncRun(qt);
    engines.push({ wasm: stats.wasm, ts: stats.ts });

    class Store extends qt.JSONSchemaStore {
        async fetch(address) {
            await new Promise((resolve) => setTimeout(resolve, 5));
            return address === "root.json"
                ? { type: "object", properties: { child: { $ref: "child.json" } }, required: ["child"] }
                : { type: "object", properties: { n: { type: "integer", minimum: 0 } } };
        }
    }

    const schema = new qt.JSONSchemaInput(new Store());
    await schema.addSource({ name: "Root", uris: ["root.json"] });
    const schemaData = new qt.InputData();
    schemaData.addInput(schema);
    const schemaRun = await qt.quicktypeMultiFile({ lang: "kotlin", inputData: schemaData });
    engines.push({ wasm: stats.wasm, ts: stats.ts });

    return {
        outputs: {
            firstSync,
            asyncRun: asyncRun.lines,
            annotations: asyncRun.annotations.map((a) => [a.annotation.message, a.span.start.line]),
            secondSync,
            schemaRun: [...schemaRun].map(([name, r]) => [name, r.lines]),
        },
        engines,
        // JSON samples the engine read as they were added.
        samplesRead: stats.samplesRead,
    };
}
