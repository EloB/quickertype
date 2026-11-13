// Port of test/unit/missing-schema-path.test.ts. The missing path lies under
// ctx.tmpDir, the same for both runs, so the error quoting it compares.

import * as fs from "node:fs";
import * as path from "node:path";

import { freshDirectory } from "./_support.mjs";

export const cases = [
    {
        name: "missing-path-reports-fetch-error",
        lang: "typescript",
        async run(qt, ctx) {
            const tempDir = freshDirectory(ctx, "missing-schema-path");
            const missingPath = path.join(tempDir, "*.json");
            try {
                const schemaInput = new qt.JSONSchemaInput(new qt.FetchingJSONSchemaStore());
                await schemaInput.addSource({ name: "TopLevel", uris: [missingPath] });
                const inputData = new qt.InputData();
                inputData.addInput(schemaInput);
                return await qt.quicktype({ inputData, lang: "typescript" });
            } finally {
                fs.rmSync(tempDir, { recursive: true, force: true });
            }
        },
    },
];
