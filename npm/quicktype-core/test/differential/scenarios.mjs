// All differential scenarios, in a fixed order (workers pick theirs by
// index). A scenario is `{ id, category, group, lang?, run(qt, ctx) }`:
// `run` makes API calls on `qt`, one copy of quicktype-core, and returns
// whatever they give (or throws); see compare.mjs for how outcomes are
// compared. It runs once per package, sequentially, so it must not keep
// state between the two runs. `ctx` has:
//
// * `inputsDir`: tests/inputs;
// * `tmpDir`: a scratch directory of the worker;
// * `referenceCheckout`: the quicktype checkout the reference comes from
//   (undefined when the reference is this package's own TypeScript
//   engine), e.g. for its built quicktype-typescript-input;
// * `deepRequire(qt, subpath)`: a deep import from `qt`'s package, such as
//   `deepRequire(qt, "dist/language/Kotlin/utils.js")`.

import * as apiTests from "./scenarios/api-tests.mjs";
import * as corpus from "./scenarios/corpus.mjs";
import * as errors from "./scenarios/errors.mjs";
import * as fuzz from "./scenarios/fuzz.mjs";
import * as inputs from "./scenarios/inputs.mjs";
import * as robustness from "./scenarios/robustness.mjs";
import * as stores from "./scenarios/stores.mjs";

export const modules = { corpus, inputs, api: apiTests, stores, errors, robustness, fuzz };

export function allScenarios(categories) {
    const list = [];
    for (const [name, module] of Object.entries(modules)) {
        if (categories !== undefined && !categories.includes(name)) continue;
        for (const scenario of module.scenarios()) list.push(scenario);
    }

    const ids = new Set();
    for (const s of list) {
        if (ids.has(s.id)) throw new Error(`duplicate scenario id ${s.id}`);
        ids.add(s.id);
    }

    return list;
}
