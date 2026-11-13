// Port of test/unit/dart-method-names.test.ts.

import { jsonInputData } from "./_support.mjs";

async function renderDart(qt, rendererOptions = {}) {
    const inputData = await jsonInputData(qt, "dart", "Sensordata", ['{"sensor":"temp","data":[1,2,3]}']);
    return await qt.quicktype({ inputData, lang: "dart", rendererOptions });
}

export const cases = [
    { name: "from-map-renames-class-level-methods-only", run: (qt) => renderDart(qt, { "from-map": "true" }) },
    { name: "json-names-by-default", run: (qt) => renderDart(qt) },
].map((c) => ({ ...c, lang: "dart" }));
