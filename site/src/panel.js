// Where the options are as the page loads: open beside the output on a wide
// screen, unless the viewer closed them. Shared by main.js and the script
// the build inlines in index.html's head (head.js), which decides it before
// the first paint, so that the panes do not move when main.js opens them.

/** Whether the viewer last opened or closed the options ("open" | "closed"); a convenience, kept in localStorage. */
export const panelKey = "quickertype.options";
/** Room for the options beside the output; on a narrower screen they are a drawer over the page. */
export const roomBesideQuery = "(min-width: 1200px)";
/** Room enough for them to be open when the page loads, unless the viewer closed them. */
const roomToOpenQuery = "(min-width: 1280px)";

/** The viewer's last choice, if any (and if the browser lets the page keep it). */
export function savedPanel() {
    try {
        return localStorage.getItem(panelKey);
    } catch {
        return null;
    }
}

/** Whether the options are open as the page loads: beside the output, unless the viewer closed them (or opened them on a narrower screen). */
export function openAtLoad() {
    const saved = savedPanel();
    return matchMedia(roomBesideQuery).matches && (saved === "open" || (saved === null && matchMedia(roomToOpenQuery).matches));
}
