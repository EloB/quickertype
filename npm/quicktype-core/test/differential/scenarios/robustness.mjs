// Inputs that the boundary between the facade and the engine must not
// change: strings that are not well-formed UTF-16 (lone surrogates, which
// JSON.parse accepts), circular or shared store documents, and the state a
// failed run leaves on its JSON Schema input.

function scenario(name, run, lang) {
    return { id: `robustness/${name}`, category: "robustness", group: "robustness", lang, run };
}

async function jsonRun(qt, lang, samples, extra = {}, name = "TopLevel", description) {
    const input = qt.jsonInputForTargetLanguage(lang);
    await input.addSource({ name, samples, description });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return qt.quicktypeMultiFile({ lang, inputData, ...extra });
}

function storeOf(qt, documents) {
    class Store extends qt.JSONSchemaStore {
        async fetch(address) {
            const document = documents[address];
            return typeof document === "function" ? document() : document;
        }
    }

    return new Store();
}

async function schemaRun(qt, store, sources, lang = "typescript") {
    const input = new qt.JSONSchemaInput(store);
    for (const source of sources) await input.addSource(source);
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return qt.quicktypeMultiFile({ lang, inputData });
}

export function scenarios() {
    const list = [];
    for (const lang of ["typescript", "rust", "cs", "python"]) {
        list.push(
            scenario(`${lang}: lone surrogates as keys`, (qt) => jsonRun(qt, lang, ['{"\\ud800": 1, "\\udbff": 2, "a\\udc00b": true}']), lang),
            scenario(`${lang}: lone surrogates as values`, (qt) => jsonRun(qt, lang, ['{"e": ["\\ud800", "\\udbff", "\\ud800", "x"]}']), lang),
        );
    }

    list.push(
        scenario("lone surrogate in a top-level name", (qt) => jsonRun(qt, "typescript", ['{"a": 1}'], {}, "Top\ud800")),
        scenario("lone surrogate in a description", (qt) =>
            jsonRun(qt, "typescript", ['{"a": 1}'], {}, "Top", "A \udfff description"),
        ),
        scenario("lone surrogate in a leading comment", (qt) =>
            jsonRun(qt, "rust", ['{"a": 1}'], { leadingComments: ["one \ud83d", { lines: ["two \ude00"] }] }),
        ),
        scenario("lone surrogate in a renderer option", (qt) =>
            jsonRun(qt, "cs", ['{"a": 1}'], { rendererOptions: { namespace: "N\ud800s" } }),
        ),
        scenario("lone surrogate in the output file name", (qt) =>
            jsonRun(qt, "java", ['{"a": 1}'], { outputFilename: "Out\udc00.java" }),
        ),
        scenario("lone surrogate in the indentation", (qt) => jsonRun(qt, "typescript", ['{"a": 1}'], { indentation: "\ud800" })),
        scenario("lone surrogates in a store's document", (qt) =>
            schemaRun(qt, storeOf(qt, {
                "s.json": {
                    type: "object",
                    properties: { "\ud800": { type: "string" }, "\udbff": { type: "integer" }, e: { enum: ["\udc00", "\udc01"] } },
                },
            }), [{ name: "S", uris: ["s.json"] }]),
        ),
        scenario("lone surrogates in schema text", (qt) =>
            schemaRun(qt, undefined, [
                { name: "S", schema: '{"type":"object","properties":{"\\ud800":{"type":"string"},"\\udbff":{"type":"number"}}}' },
            ]),
        ),
        scenario("lone surrogate in a schema source name", (qt) =>
            schemaRun(qt, undefined, [{ name: "S\ud800", schema: '{"type":"object","properties":{"a":{"type":"string"}}}' }]),
        ),
        scenario("well-formed astral characters still run on the engine", (qt) =>
            jsonRun(qt, "typescript", ['{"\\ud83d\\ude00": 1, "𝄞": ["\\ud83d\\ude00", "x"]}']),
        ),
        scenario("console.log that runs quicktype", async (qt) => {
            const original = console.log;
            let nested = 0;
            console.log = (...args) => {
                original(...args);
                if (nested >= 2) return;
                nested++;
                const input = qt.jsonInputForTargetLanguage("rust");
                input.addSourceSync({ name: "Nested", samples: ['{"n": [1, 2]}'] });
                const inputData = new qt.InputData();
                inputData.addInput(input);
                const result = qt.quicktypeMultiFileSync({ lang: "rust", inputData, debugPrintGatherNames: true });
                original(`nested: ${result.get("stdout").lines.length} lines`);
            };
            try {
                return await jsonRun(qt, "typescript", ['{"a": [1], "b": {"c": "x"}}'], { debugPrintGatherNames: true });
            } finally {
                console.log = original;
            }
        }),
        scenario("circular store document", async (qt) => {
            const document = { type: "object", properties: { name: { type: "string" } } };
            document.properties.self = document;
            return schemaRun(qt, storeOf(qt, { "c.json": document }), [{ name: "C", uris: ["c.json"] }]);
        }),
        scenario("circular array in a store document", async (qt) => {
            const items = [{ type: "string" }];
            items.push(items);
            return schemaRun(qt, storeOf(qt, { "c.json": { type: "array", items } }), [{ name: "C", uris: ["c.json"] }]);
        }),
        scenario("shared (not circular) parts of a store document", async (qt) => {
            const shared = { type: "object", properties: { n: { type: "integer" } } };
            const document = { type: "object", properties: { a: shared, b: shared, c: { type: "array", items: shared } } };
            return schemaRun(qt, storeOf(qt, { "d.json": document }), [{ name: "D", uris: ["d.json"] }]);
        }),
        scenario("top-levels left on the input by a failed run", async (qt) => {
            const input = new qt.JSONSchemaInput(
                storeOf(qt, {
                    "a.json": { title: "Alpha", type: "object", properties: { x: { type: "string" } } },
                    "b.json": { title: "Beta", type: "object", properties: { y: { type: 5 } } },
                }),
            );
            await input.addSource({ name: "A", uris: ["a.json"] });
            await input.addSource({ name: "B", uris: ["b.json"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            let error;
            try {
                await qt.quicktypeMultiFile({ lang: "typescript", inputData });
            } catch (e) {
                error = e;
            }

            return { error, topLevels: [...input._topLevels].map(([name, ref]) => [name, ref.toString()]) };
        }),
        scenario("top-levels left on the input when resolving fails", async (qt) => {
            const input = new qt.JSONSchemaInput(storeOf(qt, { "a.json": { title: "Alpha", type: "string" } }));
            input.addTopLevel("Kept", qt.Ref.parse("a.json#"));
            await input.addSource({ name: "A", uris: ["a.json"] });
            await input.addSource({ name: "Missing", uris: ["missing.json"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            let error;
            try {
                await qt.quicktypeMultiFile({ lang: "typescript", inputData });
            } catch (e) {
                error = e;
            }

            return { error, topLevels: [...input._topLevels].map(([name, ref]) => [name, ref.toString()]) };
        }),
    );
    return list;
}
