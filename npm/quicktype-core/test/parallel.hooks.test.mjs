// parallel.test.mjs on the test-hooks package (test/hooks.mjs): its tests,
// which there also check that no tallies or leases are left.

process.env.QUICKTYPE_TEST_ENGINE = "test-hooks";
await import("./parallel.test.mjs");
