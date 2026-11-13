// The browser bundle's entry point for the CommonJS build (bundled by
// smoke.mjs with esbuild as an iife, loaded with a classic script tag).
const qt = require("../../dist/index.js");
const { engineStats } = require("../../dist/native/bridge.js");

const out = document.getElementById("result");
import("./scenario.mjs").then(({ smoke }) =>
    smoke(qt, engineStats).then(
        (result) => {
            out.textContent = JSON.stringify(result);
        },
        (e) => {
            out.textContent = JSON.stringify({ error: String(e?.stack ?? e) });
        },
    ),
);
