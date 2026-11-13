// Errors (class, messageName, message, properties) and every run option
// beyond the inputs: renderer option values of every type, leading
// comments, indentation, output file names, inference flags, debug output,
// target languages given as objects (built-in or not), sync runs.

async function json(qt, lang, samples, name = "TopLevel") {
    const input = qt.jsonInputForTargetLanguage(lang);
    await input.addSource({ name, samples });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return inputData;
}

async function schema(qt, text, name = "TopLevel") {
    const input = new qt.JSONSchemaInput(undefined);
    await input.addSource({ name, schema: typeof text === "string" ? text : JSON.stringify(text) });
    const inputData = new qt.InputData();
    inputData.addInput(input);
    return inputData;
}

const sample = '{"id": 1, "name": "x", "when": "2020-01-01T00:00:00Z", "tags": ["a", "b"], "nested": {"ok": true, "n": null}, "uuid": "3fa85f64-5717-4562-b3fc-2c963f66afa6", "count": "12", "flag": "true", "dict": {"a1b2c3": 1, "d4e5f6": 2, "g7h8i9": 3, "j0k1l2": 4, "m3n4o5": 5, "p6q7r8": 6, "s9t0u1": 7}}';

function scenario(category, name, run, lang) {
    return { id: `${category}/${name}`, category, group: category, lang, run };
}

const schemaErrors = {
    "type is a number": { type: 5 },
    "type list with a number": { type: ["string", 1] },
    "unknown type": { type: "foo" },
    "empty type list": { type: [] },
    "$ref is a number": { $ref: 5 },
    "required is a number": { type: "object", required: 5 },
    "required with a number": { type: "object", properties: { a: { type: "string" } }, required: ["a", 7] },
    "array as schema": [1, 2],
    "null as schema": null,
    "missing definition": { $ref: "#/definitions/nope" },
    "index out of range": { $ref: "#/allOf/3", allOf: [{ type: "string" }] },
    "index into array with a key": { $ref: "#/allOf/x", allOf: [{ type: "string" }] },
    "items is a number": { type: "array", items: 5 },
    "oneOf is not an array": { oneOf: 5 },
    "impossible intersection": { allOf: [{ type: "string" }, { type: "number" }] },
    "malformed $ref uri": { $ref: "100%.schema" },
    "$id without address": { $id: "#foo", type: "string" },
    "false schema": false,
    "false property": { type: "object", properties: { a: false } },
    "invalid min-max": { type: "integer", minimum: 5, maximum: 1 },
    "accessor arity": { oneOf: [{ type: "string" }, { type: "number" }], "qt-accessors": ["one"] },
    "cannot get types from boolean": true,
};

export function scenarios() {
    const list = [];
    const err = (name, run, lang) => list.push(scenario("errors", name, run, lang));
    const opt = (name, run, lang) => list.push(scenario("options", name, run, lang));

    // ---- errors ---------------------------------------------------------
    err("unknown language name", async (qt) =>
        qt.quicktypeMultiFile({ lang: "cobol", inputData: await json(qt, "typescript", ["1"]) }),
    );
    err("unknown enum option value", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "cs",
            inputData: await json(qt, "cs", [sample]),
            rendererOptions: { framework: "Foo$&Bar" },
        }),
    );
    err("inherited enum option value", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "cs",
            inputData: await json(qt, "cs", [sample]),
            rendererOptions: { framework: "toString" },
        }),
    );
    err("numeric enum option value", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "java",
            inputData: await json(qt, "java", [sample]),
            rendererOptions: { "array-type": 7 },
        }),
    );
    err("no samples", async (qt) => {
        const input = qt.jsonInputForTargetLanguage("rust");
        await input.addSource({ name: "Empty", samples: [] });
        return input;
    });
    err("invalid JSON sample", async (qt) => json(qt, "rust", ['{"a": 1,}'], "Broken"));
    err("schema text that is not JSON or YAML", async (qt) =>
        qt.quicktypeMultiFile({ lang: "typescript", inputData: await schema(qt, "{ a: [ }") }),
    );
    for (const [name, value] of Object.entries(schemaErrors)) {
        err(`schema: ${name}`, async (qt) =>
            qt.quicktypeMultiFile({ lang: "typescript", inputData: await schema(qt, value) }),
        );
    }

    err("JSON $ref not rooted", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "typescript",
            inputData: await (async () => {
                const input = qt.jsonInputForTargetLanguage("typescript", undefined, true);
                await input.addSource({ name: "R", samples: ['{"a": {"$ref": "other.json#/x"}}'] });
                const d = new qt.InputData();
                d.addInput(input);
                return d;
            })(),
        }),
    );
    err("JSON $ref to a missing property", async (qt) => {
        const input = qt.jsonInputForTargetLanguage("typescript", undefined, true);
        await input.addSource({ name: "R", samples: ['{"a": {"b": 1}, "c": {"$ref": "#/a/zz"}}'] });
        const d = new qt.InputData();
        d.addInput(input);
        return qt.quicktypeMultiFile({ lang: "typescript", inputData: d });
    });
    err("JSON $ref into an array", async (qt) => {
        const input = qt.jsonInputForTargetLanguage("typescript", undefined, true);
        await input.addSource({ name: "R", samples: ['{"a": [{"b": 1}], "c": {"$ref": "#/a/5"}}'] });
        const d = new qt.InputData();
        d.addInput(input);
        return qt.quicktypeMultiFile({ lang: "typescript", inputData: d });
    });
    err("JSON $ref handled", async (qt) => {
        const input = qt.jsonInputForTargetLanguage("typescript", undefined, true);
        await input.addSource({ name: "R", samples: ['{"a": {"b": 1}, "c": {"$ref": "#/a"}, "d": [{"$ref": "#/a"}]}'] });
        const d = new qt.InputData();
        d.addInput(input);
        return qt.quicktypeMultiFile({ lang: "typescript", inputData: d });
    });
    err("two string schema sources", async (qt) => {
        const d = new qt.InputData();
        for (const text of ['{"type":"string"}', '{"type":"number"}']) {
            const input = new qt.JSONSchemaInput(undefined);
            await input.addSource({ name: "S", schema: text });
            d.addInput(input);
        }

        return qt.quicktypeMultiFile({ lang: "schema", inputData: d });
    });

    // ---- options --------------------------------------------------------
    const languages = ["typescript", "rust", "cs", "java", "kotlin", "php", "haskell", "elm", "flow", "javascript", "pike", "scala3", "smithy4a", "typescript-zod", "typescript-effect-schema", "javascript-prop-types"];
    for (const lang of languages) {
        opt(`${lang}: leading comments`, async (qt) =>
            qt.quicktypeMultiFile({
                lang,
                inputData: await json(qt, lang, [sample]),
                leadingComments: [
                    "a plain line */ with a terminator",
                    { lines: ["one", ["two", " and ", "a half"]] },
                    { descriptionBlock: ["described", "block"] },
                    { customLines: ["custom"], lineStart: "## ", beforeComment: "/*", afterComment: "*/" },
                ],
            }),
        lang);
        opt(`${lang}: empty leading comments`, async (qt) =>
            qt.quicktype({ lang, inputData: await json(qt, lang, [sample]), leadingComments: [] }),
        lang);
        opt(`${lang}: indentation and file name`, async (qt) =>
            qt.quicktypeMultiFile({
                lang,
                inputData: await json(qt, lang, [sample]),
                indentation: "\t",
                outputFilename: "Some File.out",
            }),
        lang);
        opt(`${lang}: everything off`, async (qt) =>
            qt.quicktypeMultiFile({
                lang,
                inputData: await json(qt, lang, [sample, '{"id": 2.5, "extra": [1, "x"]}']),
                inferMaps: false,
                inferEnums: false,
                inferUuids: false,
                inferDateTimes: false,
                inferIntegerStrings: false,
                inferBooleanStrings: false,
                combineClasses: false,
                ignoreJsonRefs: true,
                allPropertiesOptional: true,
                alphabetizeProperties: true,
                fixedTopLevels: true,
            }),
        lang);
        opt(`${lang}: quicktype() of two top-levels`, async (qt) => {
            const input = qt.jsonInputForTargetLanguage(lang);
            await input.addSource({ name: "First", samples: [sample] });
            await input.addSource({ name: "Second", samples: ['{"x": [{"y": 1}], "z": null}'], description: "The second one" });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            return qt.quicktype({ lang, inputData, fixedTopLevels: true });
        }, lang);
        opt(`${lang}: sync run`, async (qt) => {
            const input = qt.jsonInputForTargetLanguage(lang);
            input.addSourceSync({ name: "Sync", samples: [sample, "[1, 2]"] });
            const inputData = new qt.InputData();
            inputData.addInput(input);
            return qt.quicktypeMultiFileSync({ lang, inputData });
        }, lang);
        opt(`${lang}: every option at a non-default value`, async (qt) => {
            const definitions = qt.getTargetLanguage(lang).optionDefinitions;
            const rendererOptions = {};
            for (const d of definitions) {
                if (d.optionType === "boolean") rendererOptions[d.name] = !d.defaultValue;
                else if (d.optionType === "enum") {
                    const keys = Object.keys(d.values);
                    rendererOptions[d.name] = keys[keys.length - 1];
                } else rendererOptions[d.name] = "Custom.Value";
            }

            return {
                rendererOptions,
                result: await qt.quicktypeMultiFile({ lang, inputData: await json(qt, lang, [sample]), rendererOptions }),
            };
        }, lang);
        opt(`${lang}: language object`, async (qt) =>
            qt.quicktypeMultiFile({ lang: qt.getTargetLanguage(lang), inputData: await json(qt, lang, [sample]) }),
        lang);
        opt(`${lang}: schema with descriptions and constraints`, async (qt) =>
            qt.quicktypeMultiFile({
                lang,
                inputData: await schema(qt, {
                    title: "Thing",
                    description: "A thing.\nWith two lines.",
                    type: "object",
                    properties: {
                        id: { type: "integer", minimum: 1, maximum: 100, description: "The id" },
                        name: { type: "string", minLength: 1, maxLength: 5, pattern: "^[a-z]+$" },
                        kind: { enum: ["a", "b", "c d"], default: "a" },
                        items: { type: "array", items: { $ref: "#" }, minItems: 1 },
                        either: { oneOf: [{ type: "string", format: "date-time" }, { type: "integer" }] },
                        uri: { type: "string", format: "uri" },
                        extra: { type: "object", additionalProperties: { type: "number" } },
                    },
                    required: ["id"],
                    additionalProperties: false,
                }),
            }),
        lang);
    }

    opt("boolean options given odd values", async (qt) => {
        const results = [];
        for (const value of [1, 0, "", "yes", "false", "true", null, {}, []]) {
            results.push(
                await qt.quicktypeMultiFile({
                    lang: "typescript",
                    inputData: await json(qt, "typescript", [sample]),
                    rendererOptions: { "just-types": value, "no-runtime-typecheck": value },
                }),
            );
        }

        return results;
    });
    opt("string options given odd values", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "cs",
            inputData: await json(qt, "cs", [sample]),
            rendererOptions: { namespace: 42 },
        }),
    );
    opt("falsy enum option values", async (qt) => {
        const results = [];
        for (const value of [false, "", 0, null, undefined]) {
            results.push(
                await qt.quicktypeMultiFile({
                    lang: "cs",
                    inputData: await json(qt, "cs", [sample]),
                    rendererOptions: { framework: value },
                }),
            );
        }

        return results;
    });
    opt("options given as null", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "rust",
            inputData: await json(qt, "rust", [sample]),
            rendererOptions: null,
            indentation: null,
            outputFilename: null,
            leadingComments: null,
            alphabetizeProperties: null,
        }),
    );
    opt("custom target language subclass", async (qt) => {
        class Custom extends qt.TypeScriptTargetLanguage {
            get displayName() {
                return "Custom";
            }
        }

        return qt.quicktypeMultiFile({ lang: new Custom(), inputData: await json(qt, "typescript", [sample]) });
    });
    opt("no render", async (qt) =>
        qt.quicktypeMultiFile({ lang: "rust", inputData: await json(qt, "rust", [sample]), noRender: true }),
    );
    opt("no inputs", async (qt) => qt.quicktypeMultiFile({ lang: "rust", inputData: new qt.InputData() }));
    opt("default options", async (qt) => qt.quicktypeMultiFile({}));
    opt("lang alias", async (qt) => qt.quicktype({ lang: "csharp", inputData: await json(qt, "csharp", [sample]) }));
    opt("integer ranges at the edges", async (qt) => {
        const samples = ['{"a": 9007199254740991, "b": 9007199254740993, "c": 9223372036854775807, "d": -9223372036854775808, "e": 1e21, "f": 2147483648, "g": 1.0}'];
        const results = {};
        for (const lang of ["rust", "typescript", "cs", "java", "kotlin", "pike", "elm", "scala3", "haskell", "php"]) {
            results[lang] = await qt.quicktype({ lang, inputData: await json(qt, lang, samples) });
        }

        return results;
    });
    opt("date-time recognizers", async (qt) => {
        const samples = ['{"a": "2020-01-01", "b": "12:30:00", "c": "2020-01-01T12:30:00Z", "d": "2020-01-01T12:30:00.123+01:00", "e": "12:30", "f": "2020-1-1"}'];
        const results = {};
        for (const lang of ["kotlin", "swift", "typescript", "cs"]) {
            results[lang] = await qt.quicktypeMultiFile({ lang: "typescript", inputData: await json(qt, lang, samples) });
        }

        return results;
    });
    opt("unusual names and strings", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "typescript",
            inputData: await json(qt, "typescript", [
                JSON.stringify({ "": 1, "𝄞 clef": "x", "a b": true, "😀": [null], ["__proto__"]: 2, "1": 3, "0": 4, constructor: "c", ["x".repeat(70)]: "y".repeat(70) }),
            ]),
        }),
    );
    for (const flag of ["debugPrintGraph", "debugPrintReconstitution", "debugPrintGatherNames", "debugPrintTransformations", "checkProvenance"]) {
        opt(`debug: ${flag}`, async (qt) =>
            qt.quicktypeMultiFile({ lang: "cs", inputData: await json(qt, "cs", [sample]), [flag]: true }),
        );
    }

    opt("debug: print times", async (qt) =>
        qt.quicktypeMultiFile({ lang: "kotlin", inputData: await json(qt, "kotlin", [sample]), debugPrintTimes: true }),
    );
    opt("debug: graph of a schema", async (qt) =>
        qt.quicktypeMultiFile({
            lang: "java",
            inputData: await schema(qt, { type: "object", properties: { a: { oneOf: [{ type: "string" }, { type: "null" }] }, b: { allOf: [{ $ref: "#/definitions/B" }, { required: ["x"] }] } }, definitions: { B: { type: "object", properties: { x: { type: "integer" } } } } }),
            debugPrintGraph: true,
            debugPrintSchemaResolving: true,
        }),
    );

    return list;
}
