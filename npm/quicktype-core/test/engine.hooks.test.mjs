// engine.test.mjs on the test-hooks package (test/hooks.mjs): its tests that
// call a test hook, and those that only check more with one.

process.env.QUICKTYPE_TEST_ENGINE = "test-hooks";
await import("./engine.test.mjs");
