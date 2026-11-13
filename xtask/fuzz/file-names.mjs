// File names a CLI case may write: a recorded case is checked out on
// Windows, macOS and Linux (`actions/checkout` in CI), so every name in it
// must be one all three can hold, and no two may collide on a file system
// that ignores case (Windows, macOS) or Unicode normalization (macOS, where
// git also precomposes names).

/** Windows' device names, reserved in any case and with any extension (`nul.json`, `Con .txt`). */
const DEVICE_NAMES = /^(con|prn|aux|nul|com[0-9¹²³]|lpt[0-9¹²³]|conin\$|conout\$)$/i;

/** Whether `name` (one path component) is a Windows device name. */
export function isDeviceName(name) {
    return DEVICE_NAMES.test(name.split(".")[0].replace(/ +$/, ""));
}

/**
 * Whether `name` (one path component) is a file name Windows, macOS and
 * Linux can all hold as given: well-formed and in NFC; not empty, `.` or
 * `..`; no control characters or `/ \ : * ? " < > |`; not ending in a space
 * or a dot; not a device name; at most 120 UTF-16 units and 240 bytes.
 */
export function isPortableFileName(name) {
    if (name === "" || name === "." || name === "..") return false;
    if (!name.isWellFormed() || name.normalize("NFC") !== name) return false;
    if (/[\u0000-\u001f\u007f/\\:*?"<>|]/.test(name)) return false;
    if (/[ .]$/.test(name)) return false;
    if (isDeviceName(name)) return false;
    return name.length <= 120 && Buffer.byteLength(name, "utf8") <= 240;
}

/**
 * The relative paths (`/`-separated) among `paths` that are not portable:
 * a component that is not a portable file name, or a file or directory
 * that collides with another one when case is ignored (names are NFC, so
 * normalization cannot make two of them equal).
 */
export function unportablePaths(paths) {
    const bad = [];
    const seen = new Map();
    for (const p of paths) {
        const components = p.split("/");
        if (!components.every(isPortableFileName)) {
            bad.push(p);
            continue;
        }

        for (let i = 1; i <= components.length; i++) {
            const prefix = components.slice(0, i).join("/");
            // Folded both ways: a file system may compare upper or lower case.
            for (const key of [prefix.toLowerCase(), prefix.toUpperCase()]) {
                const other = seen.get(key);
                if (other !== undefined && other !== prefix) bad.push(`${p} (${prefix} collides with ${other})`);
                seen.set(key, prefix);
            }
        }
    }

    return bad;
}

/**
 * `name` with what a portable file name cannot hold removed (control
 * characters, `/ \ : * ? " < > |`, and dots, which the CLI would take for
 * an extension), trailing spaces trimmed, in NFC, and a device name
 * suffixed with `_`; `fallback` if nothing is left or it is not well-formed.
 */
export function portableName(name, fallback) {
    let n = name
        .normalize("NFC")
        .replace(/[\u0000-\u001f\u007f/\\:*?"<>|.]/g, "")
        .replace(/ +$/, "");
    if (n === "" || !n.isWellFormed()) return fallback;
    if (isDeviceName(n)) n = `${n}_`;
    return n;
}
