// Port of test/unit/windows-schema-paths.test.ts. The schema tree is created
// under ctx.tmpDir (the same path for both runs), which is the working
// directory during the call, as in the test.

import * as fs from "node:fs";
import * as path from "node:path";

import { freshDirectory, inDirectory, schemaInputData } from "./_support.mjs";

const topLevelSchema = JSON.stringify({
    $schema: "http://json-schema.org/draft-07/schema#",
    type: "array",
    items: { $ref: "item.schema.json" },
});

const itemSchema = JSON.stringify({
    $schema: "http://json-schema.org/draft-07/schema#",
    type: "object",
    properties: { name: { type: "string" } },
    required: ["name"],
});

const isWindows = process.platform === "win32";

const pathCases = [
    {
        name: "windows-absolute-backslashes",
        schemaDir: isWindows ? "backslashes" : "C:/Users/quicktype",
        schemaArg: (tempDir) =>
            isWindows ? path.join(tempDir, "backslashes", "top.schema.json") : "C:\\Users\\quicktype\\top.schema.json",
    },
    {
        name: "windows-absolute-forward-slashes",
        schemaDir: isWindows ? "forward-slashes" : "C:/Users/quicktype",
        schemaArg: (tempDir) =>
            isWindows
                ? path.join(tempDir, "forward-slashes", "top.schema.json").replace(/\\/g, "/")
                : "C:/Users/quicktype/top.schema.json",
    },
    {
        name: "posix-absolute",
        schemaDir: "posix",
        schemaArg: (tempDir) => path.join(tempDir, "posix", "top.schema.json"),
    },
];

export const cases = pathCases.map((c) => ({
    name: c.name,
    lang: "typescript",
    async run(qt, ctx) {
        const tempDir = freshDirectory(ctx, "windows-schema-paths");
        try {
            const schemaDir = path.join(tempDir, c.schemaDir);
            fs.mkdirSync(schemaDir, { recursive: true });
            fs.writeFileSync(path.join(schemaDir, "top.schema.json"), topLevelSchema);
            fs.writeFileSync(path.join(schemaDir, "item.schema.json"), itemSchema);
            return await inDirectory(tempDir, async () => {
                const inputData = await schemaInputData(
                    qt,
                    { name: "TopLevel", uris: [c.schemaArg(tempDir)] },
                    new qt.FetchingJSONSchemaStore(),
                );
                return await qt.quicktype({ inputData, lang: "typescript" });
            });
        } finally {
            fs.rmSync(tempDir, { recursive: true, force: true });
        }
    },
}));
