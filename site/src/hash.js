// The URL hash's own keys. Everything else in the hash is an option, by its
// name on quicktype's command line; site/build.mjs fails if an option takes
// one of these names.

/**
 * The hash format, written as `v` by every link. Links without it are older
 * than the page's presets and are read with quicktype's own defaults.
 */
export const hashVersion = "2";

/**
 * `e` is the engine, `e=quicktype` (quicktype's TypeScript engine); links
 * without it, older ones included, get quickertype (WebAssembly). `c=1` is
 * only read, from links older than `e`: compare mode, which ran both
 * engines, as switching engine does now.
 */
export const hashKeys = { version: "v", language: "l", sample: "s", name: "n", engine: "e", compare: "c" };
