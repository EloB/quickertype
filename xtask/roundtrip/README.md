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

The tool runs quicktype's harness unchanged except for one switch: with
`QUICKTYPE_BIN` set, the fixtures run that executable with the options
rendered as command-line arguments instead of calling the CLI's `main`
in-process. The same arguments go to the TypeScript CLI (`--ts`) for the
baseline, so a test that passes with TypeScript and fails with ours is a bug
in the port.

## Files

- `harness.patch`: the patch to quicktype's `test/utils.ts` and
  `test/test.ts`. It adds
  - `QUICKTYPE_BIN=<command>`: run `<command> [args]` instead of `main`.
    The command is split on whitespace (`node /x/dist/index.js` works).
    Boolean renderer options become `--name`/`--no-name`, others
    `--name value`; options the language lacks are dropped with a warning,
    as `main` ignores them.
  - `QUICKTYPE_RESULTS=<file>`: keep going after a failing test and append
    one JSON line per test (`fixture`, `sample`, `options`, `status` of
    `pass`/`fail`/`skip`, `ms`, `error`). Without it the harness stops at
    the first failure, as upstream does.
- `roundtrip.sh`: prepares a patched copy of quicktype and runs fixtures.
- `compare.mjs`: summarizes results files and compares two of them.

## Usage

```sh
# A patched copy of quicktype at the commit in tests/golden/REFERENCE.
# --from copies an installed, built checkout (it is not modified); without
# it, the script clones upstream, then runs npm ci and npm run build.
xtask/roundtrip/roundtrip.sh prepare ../quicktype-roundtrip --from ../quicktype

# Fixtures (names from test/fixtures.ts, comma-separated) with our binary.
# Builds target/release/quicktype unless --bin is given.
xtask/roundtrip/roundtrip.sh run ../quicktype-roundtrip --quick --cpus 4 \
    --results /tmp/ours.jsonl python,schema-python

# The same with the TypeScript CLI of the copy.
xtask/roundtrip/roundtrip.sh run ../quicktype-roundtrip --ts --quick --cpus 4 \
    --results /tmp/ts.jsonl python,schema-python

# Per-fixture counts and every test that fails only with ours. Exits 1 if
# there is one.
xtask/roundtrip/roundtrip.sh compare /tmp/ts.jsonl /tmp/ours.jsonl
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
  leak check.
- `python` runs `python3.12` and needs `mypy`, `python-dateutil` and
  `types-python-dateutil`; a venv (`uv venv --python 3.12`) with shims for
  `python3.12` and `mypy` on `PATH` does.
- `flow` needs `flow-bin@0.66.0` and `flow-remove-types@1.2.3`
  (`npm install --prefix <dir>`, then their `.bin` on `PATH`; flow 0.66 is
  x86-64 and runs under Rosetta).
- `ruby`: `BUNDLE_PATH=<dir>` keeps `bundle install` out of the system gems.
- `cplusplus` with `boost: true` needs Boost headers (`CPATH`).
- `java` needs Maven and a JDK that still accepts the fixture's
  `-source 1.6` (upstream CI uses 11).

## What is not covered

`schema-golang-leading-comments` calls quicktype-core's API in-process
(`leadingComments` has no CLI flag), so it always tests the TypeScript
code; it is left out of the workflow.
