// Port of test/unit/swift-acronym-names.test.ts.

import { jsonInputData } from "./_support.mjs";

export const cases = ["original", "pascal", "camel", "lowerCase"].map((acronymStyle) => ({
    name: `acronym-style=${acronymStyle}`,
    lang: "swift",
    async run(qt) {
        const inputData = await jsonInputData(qt, "swift", "FaqCoordinate", ['{"x":1,"y":2}']);
        return await qt.quicktype({
            inputData,
            lang: "swift",
            rendererOptions: { "acronym-style": acronymStyle },
        });
    },
}));
