// Port of test/unit/parse-json.test.ts.

export const cases = [
    { name: "strict-json", run: (qt) => qt.parseJSON('{"name":"quicktype","count":2}', "test") },
    { name: "yaml-fallback", run: (qt) => qt.parseJSON("name: quicktype\ncount: 2\n", "test") },
    { name: "byte-order-mark", run: (qt) => qt.parseJSON('﻿{"name":"quicktype"}', "test") },
];
