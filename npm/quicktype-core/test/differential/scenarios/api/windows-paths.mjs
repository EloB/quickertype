// Port of test/unit/windows-paths.test.ts, through the same deep `dist/`
// import the test uses (dist/support/WindowsPaths.js). One case per row.

const windowsPaths = (qt, ctx) => ctx.deepRequire(qt, "dist/support/WindowsPaths.js");
const j = (value) => JSON.stringify(value);

const converts = [
    ["C:\\Users\\me\\top.schema.json", "file:///C:/Users/me/top.schema.json"],
    ["C:/Users/me/top.schema.json", "file:///C:/Users/me/top.schema.json"],
    ["c:\\dir\\x.json", "file:///c:/dir/x.json"],
    ["Z:/x.json", "file:///Z:/x.json"],
    ["C:\\dir/sub\\x.json", "file:///C:/dir/sub/x.json"],
    ["C:\\My Dir\\x.json", "file:///C:/My Dir/x.json"],
    ["\\\\server\\share\\x.json", "file://server/share/x.json"],
    ["\\\\server\\share\\dir\\x.json", "file://server/share/dir/x.json"],
];

const passesThrough = [
    "/home/me/top.schema.json",
    "dir/top.schema.json",
    "./top.schema.json",
    "../top.schema.json",
    "top.schema.json",
    "",
    "http://example.com/x.schema.json",
    "https://example.com/x.schema.json",
    "file:///C:/dir/x.json",
    "file://server/share/x.json",
    "CC:\\x.json",
    "1:\\x.json",
    "C:",
    "C:x.json",
    "\\dir\\x.json",
];

const fromFileURI = [
    ["file:///C:/dir/x.json", "C:/dir/x.json"],
    ["file:///c:/dir/x.json", "c:/dir/x.json"],
    ["file:///C:/My Dir/x.json", "C:/My Dir/x.json"],
    ["file://server/share/x.json", "//server/share/x.json"],
    ["file:///home/me/x.json", "/home/me/x.json"],
    ["file:///x.json", "/x.json"],
];

const roundTrips = [
    ["C:\\Users\\me\\top.schema.json", "C:/Users/me/top.schema.json"],
    ["C:/Users/me/top.schema.json", "C:/Users/me/top.schema.json"],
    ["\\\\server\\share\\x.json", "//server/share/x.json"],
];

export const cases = [
    ...converts.map(([input, expected]) => ({
        name: `fixWindowsPath/converts ${j(input)} to ${j(expected)}`,
        run: (qt, ctx) => windowsPaths(qt, ctx).fixWindowsPath(input),
    })),
    ...passesThrough.map((input) => ({
        name: `fixWindowsPath/passes ${j(input)} through unchanged`,
        run: (qt, ctx) => windowsPaths(qt, ctx).fixWindowsPath(input),
    })),
    ...fromFileURI.map(([input, expected]) => ({
        name: `filePathFromFileURI/converts ${j(input)} to ${j(expected)}`,
        run: (qt, ctx) => windowsPaths(qt, ctx).filePathFromFileURI(input),
    })),
    ...roundTrips.map(([input, expected]) => ({
        name: `round-trip/${j(input)} reads back as ${j(expected)}`,
        run(qt, ctx) {
            const { filePathFromFileURI, fixWindowsPath } = windowsPaths(qt, ctx);
            const uri = fixWindowsPath(input);
            return { uri, path: filePathFromFileURI(uri) };
        },
    })),
];
