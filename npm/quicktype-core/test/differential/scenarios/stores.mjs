// JSON Schema stores and the asynchronous fetch path: documents are
// fetched lazily while types are built (in the engine, at the points where
// TypeScript awaits `store.get`), so the order of fetches, what a store's
// failures turn into, debug traces, timings, concurrency and re-entrancy
// must all match the TypeScript engine.

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

/** A store over a map of documents, logging every fetch; `delays` per address. */
function mapStore(qt, documents, { delays = {}, log = [], fail = {} } = {}) {
    class MapStore extends qt.JSONSchemaStore {
        async fetch(address) {
            log.push(`fetch ${address}`);
            await delay(delays[address] ?? 0);
            if (fail[address] !== undefined) throw fail[address];
            const document = documents[address];
            return typeof document === "function" ? document() : document;
        }
    }

    return new MapStore();
}

async function schemaRun(qt, store, sources, options = {}, additional = []) {
    const input = new qt.JSONSchemaInput(store, [], additional);
    for (const source of sources) await input.addSource(source);
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return await qt.quicktypeMultiFile({ lang: "typescript", inputData, ...options });
}

const person = {
    type: "object",
    properties: {
        name: { type: "string" },
        address: { $ref: "address.json#/definitions/Address" },
        friends: { type: "array", items: { $ref: "#" } },
        pet: { $ref: "pets.json" },
    },
    required: ["name"],
};
const address = {
    definitions: {
        Address: {
            type: "object",
            properties: { street: { type: "string" }, zip: { $ref: "codes.json#/Zip" } },
        },
    },
};
const pets = { oneOf: [{ $ref: "codes.json#/Cat" }, { type: "string", enum: ["dog", "fish"] }] };
const codes = {
    Zip: { type: "string", pattern: "^[0-9]{5}$" },
    Cat: { type: "object", properties: { lives: { type: "integer", minimum: 0, maximum: 9 } } },
};
const documents = { "person.json": person, "address.json": address, "pets.json": pets, "codes.json": codes };

function scenario(name, run) {
    return { id: `stores/${name}`, category: "stores", group: "stores", lang: "typescript", run };
}

export function scenarios() {
    return [
        scenario("lazy fetches in order", async (qt) => {
            const log = [];
            const result = await schemaRun(qt, mapStore(qt, documents, { log }), [
                { name: "Person", uris: ["person.json"] },
            ]);
            return { result, log };
        }),
        scenario("fetches resolving in reverse order", async (qt) => {
            const log = [];
            const delays = { "person.json": 30, "address.json": 20, "pets.json": 10, "codes.json": 0 };
            const result = await schemaRun(qt, mapStore(qt, documents, { log, delays }), [
                { name: "Person", uris: ["person.json"] },
            ]);
            return { result, log };
        }),
        scenario("several top-levels and fragments", async (qt) => {
            const log = [];
            const result = await schemaRun(qt, mapStore(qt, documents, { log }), [
                { name: "Person", uris: ["person.json"] },
                { name: "Codes", uris: ["codes.json#/"] },
                { name: "Address", uris: ["address.json#/definitions/Address"] },
            ]);
            return { result, log };
        }),
        scenario("fetch failure is swallowed into SchemaFetchError", async (qt) => {
            const log = [];
            const store = mapStore(qt, documents, { log, fail: { "pets.json": new Error("network down") } });
            try {
                await schemaRun(qt, store, [{ name: "Person", uris: ["person.json"] }]);
            } catch (e) {
                return { error: e, log };
            }

            return "no error";
        }),
        scenario("missing top-level schema", async (qt) =>
            schemaRun(qt, mapStore(qt, documents), [{ name: "X", uris: ["nowhere.json"] }]),
        ),
        scenario("store get that throws synchronously", async (qt) => {
            class Throwing extends qt.JSONSchemaStore {
                async fetch() {
                    return undefined;
                }

                get(address) {
                    throw new TypeError(`refusing ${address}`);
                }
            }

            return schemaRun(qt, new Throwing(), [{ name: "P", uris: ["person.json"] }]);
        }),
        scenario("store get that rejects with a custom error", async (qt) => {
            class StoreError extends Error {
                constructor(message) {
                    super(message);
                    this.name = "StoreError";
                    this.code = 42;
                }
            }

            class Rejecting extends qt.JSONSchemaStore {
                async fetch() {
                    return undefined;
                }

                async get(address) {
                    await delay(1);
                    if (address === "pets.json") throw new StoreError("no pets");
                    return documents[address];
                }
            }

            try {
                await schemaRun(qt, new Rejecting(), [{ name: "P", uris: ["person.json"] }]);
            } catch (e) {
                return { isStoreError: e instanceof StoreError, name: e.name, code: e.code, message: e.message };
            }

            return "no error";
        }),
        scenario("store get that throws a non-error", async (qt) => {
            class Odd extends qt.JSONSchemaStore {
                async fetch() {
                    return undefined;
                }

                async get() {
                    throw { reason: "plain object" };
                }
            }

            try {
                await schemaRun(qt, new Odd(), [{ name: "P", uris: ["person.json"] }]);
            } catch (e) {
                return { thrown: e };
            }

            return "no error";
        }),
        scenario("store get receives the raw debug option", async (qt) => {
            const seen = [];
            class Recording extends qt.JSONSchemaStore {
                async fetch() {
                    return undefined;
                }

                async get(address, debugPrint) {
                    seen.push([address, debugPrint]);
                    return documents[address];
                }
            }

            const result = await schemaRun(qt, new Recording(), [{ name: "P", uris: ["person.json"] }], {
                debugPrintSchemaResolving: 0,
            });
            return { result, seen };
        }),
        scenario("additional schemas register $ids", async (qt) => {
            const log = [];
            const store = mapStore(
                qt,
                {
                    "main.json": { type: "object", properties: { thing: { $ref: "https://example.com/thing" } } },
                    "extra.json": {
                        $id: "https://example.com/thing",
                        type: "object",
                        properties: { id: { type: "integer" } },
                    },
                },
                { log },
            );
            const result = await schemaRun(qt, store, [{ name: "Main", uris: ["main.json"] }], {}, ["extra.json"]);
            return { result, log };
        }),
        scenario("missing additional schema", async (qt) =>
            schemaRun(qt, mapStore(qt, documents), [{ name: "P", uris: ["person.json"] }], {}, ["gone.json"]),
        ),
        scenario("schema text with refs into the store", async (qt) => {
            const log = [];
            const timings = [];
            const result = await schemaRun(
                qt,
                mapStore(qt, documents, { log }),
                [{ name: "Wrapper", schema: JSON.stringify({ type: "object", properties: { p: { $ref: "person.json" } } }) }],
                { onTiming: (t) => timings.push(t.name) },
            );
            return { result, log, timings };
        }),
        scenario("schema text without a store", async (qt) =>
            schemaRun(qt, undefined, [
                { name: "A", schema: '{"type":"object","properties":{"b":{"$ref":"b.json"}}}' },
            ]),
        ),
        scenario("uris without any store", async (qt) => schemaRun(qt, undefined, [{ name: "A", uris: ["a.json"] }])),
        scenario("yaml schema text", async (qt) =>
            schemaRun(qt, undefined, [
                {
                    name: "Yaml",
                    schema: "type: object\nproperties:\n  n:\n    type: number\n    maximum: .inf\n    minimum: -.inf\n  z:\n    const: -0\n",
                },
            ]),
        ),
        scenario("schema values beyond JSON", async (qt) => {
            const store = mapStore(qt, {
                "odd.json": {
                    type: "object",
                    properties: {
                        big: { type: "number", maximum: Infinity, minimum: -0 },
                        "10": { type: "string" },
                        "2": { type: "boolean" },
                        tuple: { type: "array", items: [{ type: "string" }, { type: "integer" }] },
                        count: { type: "integer", minimum: 10n, maximum: 1e21 },
                    },
                    required: ["10"],
                    description: "keys 10 and 2 come first",
                },
            });
            return schemaRun(qt, store, [{ name: "Odd", uris: ["odd.json"] }]);
        }),
        scenario("undefined in a store's document (known gap)", async (qt) => {
            const store = mapStore(qt, {
                "u.json": { type: "object", properties: { absent: undefined, a: { type: "string" } } },
            });
            return schemaRun(qt, store, [{ name: "U", uris: ["u.json"] }]);
        }),
        // 161 is the deepest nesting Node 24 gets through (docs/PARITY.md);
        // one more overflows the reference's stack inside a promise callback,
        // which takes the whole process down, so it cannot be compared here.
        ...[100, 161].map((depth) =>
            scenario(`properties nested ${depth} deep`, async (qt) => {
                let schema = { type: "string" };
                for (let i = 0; i < depth; i++) schema = { type: "object", properties: { [`p${i % 7}`]: schema } };
                return schemaRun(qt, mapStore(qt, { "deep.json": schema }), [{ name: "Deep", uris: ["deep.json"] }]);
            }),
        ),
        // Longer chains can overflow the reference's stack in a promise callback,
        // depending on what ran before in the same process.
        ...[50, 1000].map((length) =>
            scenario(`$ref chain of ${length} documents`, async (qt) => {
                const documents = {};
                for (let i = 0; i < length; i++) {
                    documents[`d${i}.json`] =
                        i === length - 1
                            ? { type: "object", properties: { end: { type: "boolean" } } }
                            : { type: "object", properties: { [`next${i % 5}`]: { $ref: `d${i + 1}.json` } } };
                }

                const result = await schemaRun(qt, mapStore(qt, documents), [{ name: "Chain", uris: ["d0.json"] }]);
                return [...result].map(([name, r]) => [name, r.lines.length, r.lines.slice(0, 40)]);
            }),
        ),
        scenario("debug traces of schema resolving", async (qt) =>
            schemaRun(qt, mapStore(qt, documents), [{ name: "Person", uris: ["person.json"] }], {
                debugPrintSchemaResolving: true,
            }),
        ),
        scenario("debug times", async (qt) => {
            const result = await schemaRun(
                qt,
                mapStore(qt, documents),
                [{ name: "Inline", schema: '{"type":"object","properties":{"p":{"$ref":"person.json"}}}' }],
                { debugPrintTimes: true },
            );
            return result;
        }),
        scenario("concurrent runs interleave", async (qt) => {
            const log = [];
            const runs = [30, 10, 20].map((ms, i) =>
                schemaRun(
                    qt,
                    mapStore(qt, documents, { log, delays: { "person.json": ms, "codes.json": 30 - ms } }),
                    [{ name: `Person${i}`, uris: ["person.json"] }],
                    { lang: ["typescript", "rust", "csharp"][i] },
                ),
            );
            const results = await Promise.all(runs);
            return { results, fetches: log.length };
        }),
        scenario("sync run inside a store fetch", async (qt) => {
            const nested = [];
            const store = mapStore(qt, {
                ...documents,
                "codes.json": () => {
                    const input = qt.jsonInputForTargetLanguage("rust");
                    input.addSourceSync({ name: "Nested", samples: ['{"a": [1, 2.5]}'] });
                    const inputData = new qt.InputData();
                    inputData.addInput(input);
                    nested.push(qt.quicktypeMultiFileSync({ lang: "rust", inputData }));
                    return codes;
                },
            });
            const result = await schemaRun(qt, store, [{ name: "Person", uris: ["person.json"] }]);
            return { result, nested };
        }),
        scenario("async run started inside a store fetch", async (qt) => {
            let inner;
            const store = mapStore(qt, {
                ...documents,
                "pets.json": () => {
                    inner = schemaRun(qt, mapStore(qt, documents), [{ name: "Inner", uris: ["codes.json#/"] }], {
                        lang: "kotlin",
                    });
                    return pets;
                },
            });
            const outer = await schemaRun(qt, store, [{ name: "Outer", uris: ["person.json"] }]);
            return { outer, inner: await inner };
        }),
        scenario("onTiming that runs quicktype", async (qt) => {
            const nested = [];
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "Outer", samples: ['{"x": 1}'] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            const result = await qt.quicktypeMultiFile({
                lang: "typescript",
                inputData,
                onTiming: (t) => {
                    if (t.name !== "flatten unions" || nested.length > 0) return;
                    const inner = qt.jsonInputForTargetLanguage("kotlin");
                    inner.addSourceSync({ name: "Inner", samples: ['{"y": "2020-01-01"}'] });
                    const innerData = new qt.InputData();
                    innerData.addInput(inner);
                    nested.push(qt.quicktypeMultiFileSync({ lang: "kotlin", inputData: innerData }));
                },
            });
            return { result, nested };
        }),
        scenario("onTiming that throws", async (qt) => {
            const names = [];
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "T", samples: ['{"x": 1}'] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            try {
                await qt.quicktypeMultiFile({
                    lang: "typescript",
                    inputData,
                    debugPrintTimes: true,
                    onTiming: (t) => {
                        names.push(t.name);
                        if (t.name === "replace object type") throw new RangeError("stop here");
                    },
                });
            } catch (e) {
                return { error: e, names };
            }

            return "no error";
        }),
        scenario("onTiming's this", async (qt) => {
            const input = qt.jsonInputForTargetLanguage("typescript");
            await input.addSource({ name: "T", samples: ["[1]"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            const seen = [];
            await qt.quicktypeMultiFile({
                lang: "typescript",
                inputData,
                onTiming(t) {
                    seen.push([t.name, typeof this, this?.lang, typeof this?.inputData]);
                },
            });
            return seen;
        }),
        scenario("running the same input twice", async (qt) => {
            const log = [];
            const input = new qt.JSONSchemaInput(mapStore(qt, documents, { log }));
            await input.addSource({
                name: "W",
                schema: '{"type":"object","properties":{"p":{"$ref":"person.json"}}}',
            });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            const first = await qt.quicktypeMultiFile({ lang: "typescript", inputData });
            input.addTopLevel("Codes", qt.Ref.parse("codes.json#/Cat"));
            const second = await qt.quicktypeMultiFile({ lang: "csharp", inputData });
            return { first, second, log };
        }),
        scenario("top-level added before the run", async (qt) => {
            const input = new qt.JSONSchemaInput(mapStore(qt, documents));
            input.addTopLevel("Cat", qt.Ref.parse("codes.json#/Cat"));
            await input.addSource({ name: "Person", uris: ["person.json"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            return qt.quicktypeMultiFile({ lang: "typescript", inputData });
        }),
        scenario("the same schema text twice", async (qt) => {
            const text = '{"type":"object","properties":{"a":{"type":"string"}}}';
            return schemaRun(qt, undefined, [
                { name: "One", schema: text },
                { name: "Two", schema: text },
            ]);
        }),
        scenario("schema and json inputs together", async (qt) => {
            const inputData = new qt.InputData();
            const json = qt.jsonInputForTargetLanguage("typescript");
            await json.addSource({ name: "Sample", samples: ['{"a": 1, "b": [true]}'] });
            inputData.addInput(json);
            const schema = new qt.JSONSchemaInput(mapStore(qt, documents));
            await schema.addSource({ name: "Person", uris: ["person.json"] });
            inputData.addInput(schema);
            return qt.quicktypeMultiFile({ lang: "typescript", inputData });
        }),
        scenario("schema input in a sync run", async (qt) => {
            const input = new qt.JSONSchemaInput(undefined);
            input.addSourceSync({ name: "A", schema: '{"type":"string"}' });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            return qt.quicktypeMultiFileSync({ lang: "typescript", inputData });
        }),
        scenario("schema passthrough", async (qt) =>
            schemaRun(
                qt,
                undefined,
                [{ name: "S", schema: '{"b": 1e21, "a": [1.5, -0, "x"], "2": null}', isConverted: true }],
                { lang: "schema" },
            ),
        ),
        scenario("http schema refs through FetchingJSONSchemaStore", async (qt) => {
            const http = await import("node:http");
            const served = {
                "/root.json": { type: "object", properties: { child: { $ref: "child.json" } } },
                "/child.json": { type: "object", properties: { n: { type: "integer" } } },
            };
            const server = http.createServer((request, response) => {
                const body = served[request.url];
                response.writeHead(body === undefined ? 404 : 200, { "content-type": "application/json" });
                response.end(body === undefined ? "missing" : JSON.stringify(body));
            });
            await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));
            const base = `http://127.0.0.1:${server.address().port}`;
            try {
                const result = await schemaRun(qt, new qt.FetchingJSONSchemaStore(), [
                    { name: "Root", uris: [`${base}/root.json`] },
                ]);
                let missing;
                try {
                    await schemaRun(qt, new qt.FetchingJSONSchemaStore(), [{ name: "M", uris: [`${base}/nope.json`] }]);
                } catch (e) {
                    missing = e.messageName;
                }

                return { result: [...result].map(([k, v]) => [k, v.lines.join("\n").replaceAll(base, "<base>")]), missing };
            } finally {
                server.close();
            }
        }),
    ];
}
