// Port of the API part of test/unit/url-input.test.ts: a local HTTP server
// serves a JSON sample and a JSON Schema with a relative remote $ref. The
// test runs the CLI's `main` on the URLs; here the same inputs go through
// the API (`readFromFileOrURL` for the JSON sample, FetchingJSONSchemaStore
// for the schema), rendering TypeScript to "out.ts" as the test does.

import * as path from "node:path";

import { withHTTPServer } from "./_support.mjs";

const files = {
    "sample.json": JSON.stringify({
        veryUniquePropertyName: "quicktype",
        count: 3,
    }),
    "main.schema": JSON.stringify({
        $schema: "http://json-schema.org/draft-07/schema#",
        type: "object",
        properties: {
            referenced: { $ref: "referenced.schema" },
        },
        required: ["referenced"],
    }),
    "referenced.schema": JSON.stringify({
        $schema: "http://json-schema.org/draft-07/schema#",
        type: "object",
        properties: {
            veryUniqueReferencedProperty: { type: "string" },
        },
        required: ["veryUniqueReferencedProperty"],
    }),
};

function handler(request, response) {
    if (path.basename(request.url ?? "") === "unauthorized.json") {
        response.writeHead(401, { "Content-Type": "application/json" });
        response.end('{"message":"Bad credentials"}');
        return;
    }

    const content = files[path.basename(request.url ?? "")];
    if (content === undefined) {
        response.writeHead(404);
        response.end();
        return;
    }

    response.writeHead(200, { "Content-Type": "application/json" });
    response.end(content);
}

export const cases = [
    {
        name: "json-url",
        lang: "typescript",
        run: (qt) =>
            withHTTPServer(handler, async (baseURL) => {
                const json = await qt.readFromFileOrURL(`${baseURL}/sample.json`);
                const jsonInput = qt.jsonInputForTargetLanguage("typescript");
                await jsonInput.addSource({ name: "TopLevel", samples: [json] });
                const inputData = new qt.InputData();
                inputData.addInput(jsonInput);
                const result = await qt.quicktype({ inputData, lang: "typescript", outputFilename: "out.ts" });
                return { json, result };
            }),
    },
    {
        name: "http-error-response",
        run: (qt) => withHTTPServer(handler, (baseURL) => qt.readFromFileOrURL(`${baseURL}/unauthorized.json`)),
    },
    {
        name: "relative-remote-schema-ref",
        lang: "typescript",
        run: (qt) =>
            withHTTPServer(handler, async (baseURL) => {
                const schemaInput = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore());
                await schemaInput.addSource({ name: "TopLevel", uris: [`${baseURL}/main.schema`] });
                const inputData = new qt.InputData();
                inputData.addInput(schemaInput);
                return await qt.quicktype({ inputData, lang: "typescript", outputFilename: "out.ts" });
            }),
    },
];
