// The browser bundle's entry point (bundled by smoke.mjs with esbuild).
import * as qt from "../../dist/esm/index.js";
import { engineStats } from "../../dist/esm/native/bridge.js";

import { smoke } from "./scenario.mjs";

const out = document.getElementById("result");
smoke(qt, engineStats).then(
    (result) => {
        out.textContent = JSON.stringify(result);
    },
    (e) => {
        out.textContent = JSON.stringify({ error: String(e?.stack ?? e) });
    },
);
