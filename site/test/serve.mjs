// A tiny static server for site/dist, under /quickertype/ as on GitHub Pages
// (so a URL that is not relative shows up as a 404). No dependencies.
//
//   node site/test/serve.mjs [port]      (after `node site/build.mjs`)

import * as fs from "node:fs";
import * as http from "node:http";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

export const base = "/quickertype/";

const types = {
    ".html": "text/html; charset=utf-8",
    ".js": "text/javascript; charset=utf-8",
    ".css": "text/css; charset=utf-8",
    ".wasm": "application/wasm",
    ".json": "application/json; charset=utf-8",
    ".schema": "application/json; charset=utf-8",
};

/** Serves `root` at `base`; `requests` records every request as [status, url]. */
export async function serve(root, port = 0) {
    const requests = [];
    const server = http.createServer((request, response) => {
        const url = new URL(request.url, "http://localhost");
        let status = 404;
        let file;
        if (url.pathname.startsWith(base)) {
            let relative;
            try {
                relative = decodeURIComponent(url.pathname.slice(base.length)) || "index.html";
            } catch {
                // A malformed escape (%zz).
                status = 400;
            }

            const candidate = relative === undefined ? undefined : path.join(root, relative);
            if (candidate?.startsWith(root + path.sep) && fs.existsSync(candidate) && fs.statSync(candidate).isFile()) {
                file = candidate;
                status = 200;
            }
        } else if (url.pathname === "/" || url.pathname === base.slice(0, -1)) {
            response.writeHead(302, { location: base });
            response.end();
            return;
        }

        requests.push([status, url.pathname]);
        if (file === undefined) {
            response.writeHead(status, { "content-type": "text/plain" });
            response.end(status === 400 ? "bad request" : "not found");
            return;
        }

        response.writeHead(200, {
            "content-type": types[path.extname(file)] ?? "application/octet-stream",
            "cache-control": "no-cache",
        });
        fs.createReadStream(file).pipe(response);
    });
    await new Promise((resolve) => server.listen(port, "127.0.0.1", resolve));
    return { server, requests, url: `http://127.0.0.1:${server.address().port}${base}` };
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
    const root = path.join(path.dirname(fileURLToPath(import.meta.url)), "..", "dist");
    const { url } = await serve(root, Number(process.argv[2] ?? 8080));
    console.log(`serving site/dist at ${url} (Ctrl-C to stop)`);
}
