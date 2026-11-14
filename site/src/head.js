// Inlined in index.html's head by the build, so that it runs before the
// first paint: the column the options take (html[data-panel]), which the
// stylesheet lays the panes out by. main.js opens them there when it runs.

import { openAtLoad } from "./panel.js";

try {
    document.documentElement.dataset.panel = openAtLoad() ? "inline" : "closed";
} catch {
    // Left closed: main.js decides when it runs.
}
