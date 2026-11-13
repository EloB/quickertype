# Round-trip fixtures

quicktype's main test suite is end to end: for each sample input, a fixture
generates code for a language, compiles a driver program from
`test/fixtures/<language>/` with it, has the program deserialize the sample
and serialize it back, and compares the result with the input. JSON Schema
fixtures also have expected-failure samples (`*.N.fail*.json`) that the
generated code must reject. See quicktype's `CLAUDE.md`, `test/fixtures.ts`
and `test/languages.ts`.

The parity corpus (`cargo xtask parity`) checks that our output is
byte-identical to quicktype's. This suite checks that the output also
works, and covers inputs and option combinations the corpus does not.

The tool runs quicktype's harness with two additions (`harness.patch`): with
`QUICKTYPE_BIN` set, the fixtures run that executable with the options
rendered as command-line arguments instead of calling the CLI's `main`
in-process, and `QUICKTYPE_RESULTS` records every test instead of stopping at
the first failure. The same arguments go to the TypeScript CLI (`--ts`) for the
baseline, so a test that passes with TypeScript and fails with ours is a bug
in the port.

## Files

- `harness.patch`: the patch to quicktype's `test/utils.ts`,
  `test/test.ts` and `test/lib/multicore.ts`; it also exports the JSON
  fixture classes from `test/fixtures.ts` for `later-steps.mts`. It adds
  - `QUICKTYPE_BIN=<command>`: run `<command> [args]` instead of `main`.
    The command is split on whitespace (`node /x/dist/index.js` works).
    Boolean renderer options become `--name`/`--no-name`, others
    `--name value`; options the language lacks are dropped with a warning,
    as `main` ignores them.
  - `QUICKTYPE_RESULTS=<file>`: keep going after a failing test and append
    one JSON line per test (`fixture`, `sample`, `options`, `status` of
    `pass`/`fail`/`timeout`/`skip`, `ms`, `error`). A failed command's
    `error` carries its stdout and stderr (shortened), so a compile failure
    shows the compiler's errors. A test that hits the fixtures' 30-minute
    limit is recorded as `timeout`, and its worker kills the processes it
    started and exits; the harness forks a fresh one, so nothing of the
    test runs on beside the next. A `FIXTURE` name that selects no fixture
    is an error. Without `QUICKTYPE_RESULTS` the harness stops at the first
    failure, as upstream does.
- `roundtrip.sh`: prepares a patched copy of quicktype and runs fixtures.
- `compare.mjs`: summarizes results files and compares two of them.
- `later-steps.mts`: the fixtures' later quicktype steps as a
  generation-only differential (below).
- `roundtrip.test.mjs`: tests of the checks above
  (`node --test xtask/roundtrip/roundtrip.test.mjs`).

## Usage

```sh
# A patched copy of quicktype at the commit in tests/golden/REFERENCE.
# --from copies an installed, built checkout (it is not modified); without
# it, the script clones upstream, then runs npm ci and npm run build. On an
# existing copy it only brings the patch up to date.
xtask/roundtrip/roundtrip.sh prepare ../quicktype-roundtrip --from ../quicktype

# Fixtures (names from test/fixtures.ts, comma-separated) with our binary.
# Builds target/release/quicktype unless --bin is given.
xtask/roundtrip/roundtrip.sh run ../quicktype-roundtrip --quick --cpus 4 \
    --results /tmp/ours.jsonl python,schema-python

# The same with the TypeScript CLI of the copy.
xtask/roundtrip/roundtrip.sh run ../quicktype-roundtrip --ts --quick --cpus 4 \
    --results /tmp/ts.jsonl python,schema-python

# Per-fixture counts and every test that fails only with ours.
xtask/roundtrip/roundtrip.sh compare --fixtures python,schema-python \
    /tmp/ts.jsonl /tmp/ours.jsonl
```

`run` fails with the harness's exit status when the harness fails (a
fixture's setup, an unknown fixture name, a crashed worker; a failing test
does not count), and with 1 when no test ran. `compare` exits 1 when a test
passes with TypeScript and fails or times out with ours, or ran with only
one of them, and also when the results cannot show that: either file is
empty, a fixture has no test that passes with TypeScript (as when its
compiler is missing), or a fixture named with `--fixtures` has no results in
either file. `--fixtures` takes the names as the results have them, not
`run`'s groups such as `schema`.

The golden corpus records only each fixture's first quicktype run. The
later ones (JSON to JSON Schema and on to the language for
`diffViaSchema`/`roundtripViaSchema`, JSON to schema to C# and schema to
schema for `schema-json-csharp`, JSON to TypeScript to C# for
`json-ts-csharp`) are checked only when the fixture runs. `steps` runs them
all with both CLIs and compares every written file, for every language,
without its toolchain (about 7,000 steps; `QUICKTYPE_TSC` as below for the
TypeScript input):

```sh
xtask/roundtrip/roundtrip.sh steps ../quicktype-roundtrip --jobs 8
```

`--quick` sets `QUICKTEST=true`, which leaves out the 166 inputs in
`test/inputs/json/misc`. Samples after `--` restrict the run, as with
`npm run test:fixtures -- <sample>`; their paths are relative to the copy.
Two runs must not share a copy at the same time: each fixture's setup
clears `test/runs` and installs into `test/fixtures/<language>`. Prepare a
second copy to run the TypeScript and Rust passes side by side.

`.github/workflows/roundtrip.yml` runs this weekly and on demand
(`workflow_dispatch`, with an input for the full input set), one job per
fixture group, for the languages that the standard setup actions install on
ubuntu-latest, and Swift and Objective-C on macOS.

## Toolchains

Every fixture needs its language's compiler and libraries, the same as
quicktype's CI (`.github/workflows/test-pr.yaml` upstream). Notes for a Mac:

- cJSON's run command uses `valgrind`, which does not exist on macOS. A shim
  on `PATH` that drops the `--` flags and runs the program loses only the
  leak check. It must not `exec` the program: the harness's shell reports a
  program killed by a signal (a failed `assert` on an expected-failure
  sample) as exit status 0 when the signal reaches it directly.
- `python` runs `python3.12` and needs `mypy`, `python-dateutil` and
  `types-python-dateutil`; a venv (`uv venv --python 3.12`) with shims for
  `python3.12` and `mypy` on `PATH` does.
- `flow` needs `flow-bin@0.66.0` and `flow-remove-types@1.2.3`
  (`npm install --prefix <dir>`, then their `.bin` on `PATH`; flow 0.66 is
  x86-64 and runs under Rosetta).
- `ruby`: `BUNDLE_PATH=<dir>` keeps `bundle install` out of the system gems.
  Ruby 3.4 and newer no longer load `bigdecimal` (and Ruby 4 `logger`) by
  default, which dry-types 1.7 needs: point `BUNDLE_GEMFILE` at a Gemfile
  with the fixture's locked versions plus those two gems.
- `dart` with `use-freezed` or `use-json-annotation` runs `build_runner`
  2.1.7, which does not build on Dart 3; upstream CI uses Dart 2.14.
- `cplusplus` with `boost: true` needs Boost headers (`CPATH`).
- `json-ts-csharp` reads TypeScript; ours needs the TypeScript 7.0.2 native
  compiler for that (`npm install --prefix <dir> typescript@7.0.2`, then
  `QUICKTYPE_TSC` set to its `tsc`, as in `ci.yml`).
- `java` needs Maven and a JDK that accepts the fixture POM's
  `-source 1.6` (upstream CI uses 11). With JDK 12 or newer,
  `MAVEN_ARGS="-Dmaven.compiler.source=8 -Dmaven.compiler.target=8"`
  overrides it. The `java-lombok` fixtures use Lombok 1.18.2, which does not
  work on JDK 16 or newer: they need JDK 11.

## What is not covered

`schema-golang-leading-comments` calls quicktype-core's API in-process
(`leadingComments` has no CLI flag), so it always tests the TypeScript
code; it is left out of the workflow.
