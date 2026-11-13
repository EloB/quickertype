// Port of test/unit/date-time-recognizer.test.ts, through the same deep
// `dist/` imports the test uses (DefaultDateTimeRecognizer and
// KotlinDateTimeRecognizer). Each case returns [method, value, result] for
// every call the test makes.

function defaultRecognizer(qt, ctx) {
    return new (ctx.deepRequire(qt, "dist/DateTime.js").DefaultDateTimeRecognizer)();
}

function kotlinRecognizer(qt, ctx) {
    return new (ctx.deepRequire(qt, "dist/language/Kotlin/utils.js").KotlinDateTimeRecognizer)();
}

function check(name, make, calls) {
    return {
        name,
        run(qt, ctx) {
            const recognizer = make(qt, ctx);
            return calls.map(([method, value]) => [method, value, recognizer[method](value)]);
        },
    };
}

const each = (method, values) => values.map((value) => [method, value]);

export const cases = [
    check(
        "isDateTime/accepts-rfc3339-with-offset",
        defaultRecognizer,
        each("isDateTime", ["2018-08-14T02:45:50Z", "2018-08-14T02:45:50+01:00", "2018-08-14T02:45:50-11:30"]),
    ),
    check("isDateTime/accepts-lowercase-t-and-z", defaultRecognizer, each("isDateTime", ["2018-08-14t02:45:50z"])),
    check(
        "isDateTime/accepts-fractional-seconds",
        defaultRecognizer,
        each("isDateTime", ["2015-04-24T01:46:50.342496Z", "2010-01-12T00:00:00.000Z", "2015-07-15T23:25:21.541+02:00"]),
    ),
    check(
        "isDateTime/rejects-space-separator",
        defaultRecognizer,
        each("isDateTime", ["2013-06-15 21:10:28", "1970-01-01 00:00:00", "2015-04-24 01:46:50.342496Z"]),
    ),
    check(
        "isDateTime/rejects-missing-offset",
        defaultRecognizer,
        each("isDateTime", ["2018-08-14T02:45:50", "2018-08-14T02:45:50.123"]),
    ),
    check(
        "isDateTime/rejects-invalid",
        defaultRecognizer,
        each("isDateTime", [
            "0000-00-00T00:00:00Z",
            "2018-13-01T00:00:00Z",
            "2018-08-14T24:00:00Z",
            "2018-08-14X02:45:50Z",
        ]),
    ),
    check("isDate/accepts-full-date", defaultRecognizer, each("isDate", ["2018-08-14", "1970-01-01"])),
    check(
        "isDate/rejects-invalid",
        defaultRecognizer,
        each("isDate", ["0000-00-00", "2018-13-01", "2018-02-30", "2018-8-14"]),
    ),
    check(
        "isTime/accepts-full-time",
        defaultRecognizer,
        each("isTime", ["02:45:50Z", "02:45:50z", "02:45:50.123+01:00", "23:59:59-11:30"]),
    ),
    check("isTime/rejects-missing-offset", defaultRecognizer, each("isTime", ["02:45:50", "02:45:50.123"])),
    check("isTime/rejects-invalid", defaultRecognizer, each("isTime", ["24:00:00Z", "02:60:00Z", "02:45:60Z"])),
    check(
        "kotlin/accepts-round-tripping-date-times",
        kotlinRecognizer,
        each("isDateTime", [
            "2018-08-14T02:45:50Z",
            "2010-12-01T00:00:00Z",
            "2018-08-14T02:45:50+05:30",
            "2015-04-24T01:46:50.342496Z",
            "2018-08-14T02:45:50.5Z",
            "2018-08-14T02:45:50.123456789Z",
            "2016-02-29T00:00:00Z",
        ]),
    ),
    check(
        "kotlin/rejects-trailing-zero-fractions",
        kotlinRecognizer,
        each("isDateTime", [
            "2010-01-12T00:00:00.000Z",
            "2018-08-14T02:45:50.50Z",
            "2008-09-10T13:21:30.828000Z",
            "2015-04-24T02:04:02.997570Z",
        ]),
    ),
    check(
        "kotlin/rejects-beyond-nanoseconds",
        kotlinRecognizer,
        each("isDateTime", ["2018-08-14T02:45:50.1234567891Z"]),
    ),
    check("kotlin/rejects-zero-offsets", kotlinRecognizer, [
        ...each("isDateTime", ["2018-08-14T02:45:50+00:00", "2018-08-14T02:45:50-00:00"]),
        ["isTime", "10:30:00+00:00"],
    ]),
    check(
        "kotlin/offsets-within-18-hours",
        kotlinRecognizer,
        each("isDateTime", [
            "2018-08-14T02:45:50+18:00",
            "2018-08-14T02:45:50-18:00",
            "2018-08-14T02:45:50+18:01",
            "2018-08-14T02:45:50+19:00",
        ]),
    ),
    check("kotlin/rejects-lowercase-t-and-z", kotlinRecognizer, [
        ...each("isDateTime", ["2018-08-14t02:45:50Z", "2018-08-14T02:45:50z"]),
        ["isTime", "02:45:50z"],
    ]),
    check("kotlin/feb-29-only-in-leap-years", kotlinRecognizer, [
        ...each("isDate", ["2016-02-29", "2000-02-29", "2015-02-29", "1900-02-29"]),
        ["isDateTime", "2015-02-29T00:00:00Z"],
    ]),
    check(
        "kotlin/accepts-round-tripping-times",
        kotlinRecognizer,
        each("isTime", ["02:45:50Z", "23:20:50.52Z", "23:20:50.520Z"]),
    ),
];
