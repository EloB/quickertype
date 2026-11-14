// Headless Chrome, driven over the DevTools protocol, for the scripts that
// run the package in a browser: test/browser/smoke.mjs and the benchmarks
// (compare.mjs, phases.mjs).

import { execFileSync, spawn } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";

/**
 * The Chrome or Chromium to drive: $CHROME, the usual install locations,
 * or Playwright's Chromium; `undefined` if there is none.
 */
export function findBrowser() {
    const candidates = [
        process.env.CHROME,
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
        "google-chrome",
        "google-chrome-stable",
        "chromium",
        "chromium-browser",
    ];
    const playwright = path.join(os.homedir(), "Library", "Caches", "ms-playwright");
    if (fs.existsSync(playwright)) {
        for (const dir of fs.readdirSync(playwright).filter((d) => d.startsWith("chromium-")).sort().reverse()) {
            candidates.push(path.join(playwright, dir, "chrome-mac", "Chromium.app", "Contents", "MacOS", "Chromium"));
        }
    }

    for (const candidate of candidates) {
        if (candidate === undefined) continue;
        try {
            execFileSync(candidate, ["--version"], { stdio: "ignore" });
            return candidate;
        } catch {
            // Not this one.
        }
    }

    return undefined;
}

/** What a page of these scripts shows when it is done: the text of #result, or "pending". */
export const resultExpression = 'document.getElementById("result")?.textContent ?? "pending"';

/**
 * Opens `url` in a fresh headless `browser` (`findBrowser()` if not given)
 * and evaluates `expression` in the page until it gives something other
 * than `undefined` or "pending", which it returns. Throws if the browser
 * does not start, the page does not open or does not finish within
 * `timeoutMs`. The browser is killed and its profile removed whatever
 * happens. `args` are more command-line flags (e.g. `--js-flags=--expose-gc`).
 */
export async function evaluateInChrome(url, { browser = findBrowser(), expression = resultExpression, timeoutMs = 60_000, args = [], pollMs = 100 } = {}) {
    if (browser === undefined) throw new Error("no Chrome or Chromium found (set CHROME)");
    const profile = fs.mkdtempSync(path.join(os.tmpdir(), "qt-chrome-"));
    const child = spawn(
        browser,
        [
            "--headless=new",
            "--disable-gpu",
            "--no-first-run",
            "--no-default-browser-check",
            "--remote-debugging-port=0",
            `--user-data-dir=${profile}`,
            // CI containers often cannot use Chrome's sandbox.
            ...(process.env.CI ? ["--no-sandbox"] : []),
            ...args,
            url,
        ],
        { stdio: "ignore" },
    );
    const deadline = Date.now() + timeoutMs;
    const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
    let socket;
    try {
        const portFile = path.join(profile, "DevToolsActivePort");
        while (!fs.existsSync(portFile) || fs.readFileSync(portFile, "utf8").split("\n").length < 2) {
            if (Date.now() > deadline) throw new Error("the browser did not start");
            if (child.exitCode !== null) throw new Error(`the browser exited (${child.exitCode})`);
            await wait(100);
        }

        const port = fs.readFileSync(portFile, "utf8").split("\n")[0];
        let page;
        while (page === undefined) {
            if (Date.now() > deadline) throw new Error("the page did not open");
            const targets = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json();
            page = targets.find((t) => t.type === "page" && t.url === url);
            if (page === undefined) await wait(100);
        }

        socket = new WebSocket(page.webSocketDebuggerUrl);
        await new Promise((resolve, reject) => {
            socket.onopen = resolve;
            socket.onerror = reject;
        });
        let nextId = 0;
        const pending = new Map();
        socket.onmessage = (event) => {
            const message = JSON.parse(event.data);
            pending.get(message.id)?.(message);
            pending.delete(message.id);
        };
        const evaluate = () =>
            new Promise((resolve) => {
                const id = ++nextId;
                pending.set(id, (m) => resolve(m.result?.result?.value));
                socket.send(JSON.stringify({ id, method: "Runtime.evaluate", params: { expression, returnByValue: true } }));
            });
        const late = () => new Error(`the page did not finish within ${Math.round(timeoutMs / 1000)} s`);
        for (;;) {
            // A page busy in one long task answers only after it: the
            // deadline holds meanwhile too.
            let timer;
            const timeout = new Promise((_, reject) => {
                timer = setTimeout(() => reject(late()), Math.max(0, deadline - Date.now()));
            });
            let value;
            try {
                value = await Promise.race([evaluate(), timeout]);
            } finally {
                clearTimeout(timer);
            }

            if (value !== undefined && value !== "pending") return value;
            if (Date.now() > deadline) throw late();
            await wait(pollMs);
        }
    } finally {
        socket?.close();
        child.kill();
        await wait(300);
        try {
            fs.rmSync(profile, { recursive: true, force: true, maxRetries: 5, retryDelay: 200 });
        } catch {
            // Chrome may still be writing its profile; it is a temporary directory.
        }
    }
}
