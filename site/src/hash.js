// The URL hash's own keys. Everything else in the hash is an option, by its
// name on quicktype's command line.

/**
 * The hash format, written as `v` by every link. Links without it are older
 * than the page's presets and are read with quicktype's own defaults.
 */
export const hashVersion = "2";

export const hashKeys = { version: "v", language: "l", sample: "s", name: "n", compare: "c" };
