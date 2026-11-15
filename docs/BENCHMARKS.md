# Benchmarks

How fast the Rust port is compared to the TypeScript quicktype it
replaces, how to measure it, and what each phase changed. The summary and
the sections up to [WebAssembly in Chrome](#webassembly-in-chrome) are
main at `4cf135e28`, measured on November 14, 2026; the sections after
them record each change as it was measured at the time. The CLI numbers
come from `cargo xtask bench` (see [Reproducing](#reproducing)). Every
optimization keeps the output byte-identical (`cargo xtask parity`, the
render-case and scenario tests), and every benchmark here checks that the
commands it compares write the same files.

## Summary

| | TypeScript | Rust before | Rust now | vs TypeScript | vs before |
|---|---:|---:|---:|---:|---:|
| Startup, `--version` | 226 ms | 2.26 ms | 2.92 ms | 77× | 0.8× |
| Tiny JSON (77 B) | 244 ms | 2.83 ms | 2.85 ms | 86× | 1.0× |
| Small JSON (pokedex, 82 KB) | 266 ms | 4.34 ms | 3.95 ms | 67× | 1.1× |
| github-events (82 KB), 8 languages | 284–312 ms | 5.60–8.16 ms | 5.93–8.50 ms | 37–49× | 0.8–1.0× |
| Large JSON (generated, 40 MB) | 2,676 ms | 179 ms | 155 ms | 17× | 1.2× |
| JSON Schema (vega-lite, 306 KB) → TS | 439 ms | 36.4 ms | 38.7 ms | 11× | 0.9× |
| Golden corpus, 11,178 CLI runs (wall, 12 jobs) | 473.8 s | 12.5 s | 9.0 s | 52× | 1.4× |
| In process, 112 runs (engine as a library) | 342 ms (warm Node) | 98.2 ms | 92.8 ms | 3.7× | 1.1× |
| JS API in Chrome, 20 MB JSON (WebAssembly engine, warm) | 406 ms | 145 ms | 122 ms | 3.3× | 1.2× |
| 1M records (267 MB), on all cores | 5,445 ms | 49.9 ms | 56.7 ms | 96× | 0.9× |
| Scryfall cards (real data), 657 MB | 29.9 s | – | 0.284 s | 105× | – |
| Peak RSS, 40 MB input | 653 MiB | 62.1 MiB | 60.6 MiB | 11× less | 1.0× |
| Peak RSS, 2.6 GB input | – | 63.1 MiB | 64.2 MiB | – | 1.0× |
| Peak RSS, Scryfall cards (real data), 657 MB | 3.20 GiB | – | 50.1 MiB | 65× less | – |

Wall-time medians. "Before" is what this file and the README published
before this refresh, each measured at its own time and load (see
[Machine](#machine)), so differences of up to about 10% between the two
columns are within what separate runs give on this machine. The CLI's
lead over TypeScript on small inputs is mostly starting Node.js and
loading quicktype (226 ms for `--version` alone); on large inputs and in
process it is the engine.

What moved:

- **Startup** varies on this machine from hour to hour, for every build
  alike: `--version` took 2.92 ms in this run and 2.89 ms in a
  startup-only run of `cargo xtask bench` half an hour later; an hour
  later it took 2.43 to 2.52 ms, when Phase 7's build (`54611ae41`,
  2.26 ms in its day) took 2.45 to 2.66 ms interleaved with it, and
  v0.1.0's 2.43 ms. So the largest speed-up in this run is the tiny
  input's, 86×, and `--version`'s is 77× (96× before).
- **The corpus** has no unexpected exits any more (381 before: C/cJSON
  output was being ported) and takes 9.0 s instead of 12.5 s.
- **Large inputs**: the 40 MB input takes 155 ms (179 ms before). The
  1M records' 56.7 ms on 12 threads is against 49.9 ms measured at a load
  average of 4.1 to 4.5; reading on every core is the first thing to slow
  down when other work runs ([Reading on several
  threads](#reading-on-several-threads)).
- **New here:** quicktype on the 1M records and on real data (Scryfall
  cards, 657 MB), and the large inputs on all cores against one thread
  ([Large inputs](#large-inputs)).

## Machine

- CPU: Apple M2 Max, 12 cores (8 performance, 4 efficiency), 64 GiB
- OS: macOS 26.6.2
- rustc 1.99.1, Node.js v24.16.0, Chrome 157.0.8103.78 (headless),
  TypeScript reference at `c39af7d3` (`tests/golden/REFERENCE`)
- Now: main at `4cf135e28` (`cargo build --release -p quickertype`), on
  November 14, 2026.
- Before: the README's numbers where it had the row (its CLI rows came
  from the last full `cargo xtask bench` run, in [Reading after the CLI
  profile](#reading-after-the-cli-profile), at a load average of 4 to 5,
  without TypeScript; its browser row from [Inference from tallies in the
  engine](#inference-from-tallies-in-the-engine)), else the newest section
  that measured it: startup and the tiny input from Phase 7 (that last
  run calls its first two rows noise), the 1M records and the 2.6 GB input
  from [Reading on several threads](#reading-on-several-threads), in
  process from [The second phase](#the-second-phase-strings-that-change-nothing-and-keys-by-id)
  (a whole iteration), the corpus from Phase 7.
- The machine was shared with another agent that compiled and ran tests.
  Every block of measurements started once the 1-minute load average was
  under 6 (waiting up to 20 minutes); the load average during each:
  - `cargo xtask bench --corpus --in-process --json
    site/data/benchmarks.json`: 3.6 at the start and 3.6 to 8.1 during the
    CLI benchmarks; 10 to 67 during the corpus (its 12 TypeScript jobs and
    the other agent's builds) and 66 to 73 during the in-process benchmark.
    Three more interleaved rounds of the in-process benchmark at 4.4 to 5.5
    agreed within 5% (see [In process](#in-process)).
  - The second full run ([CLI](#cli)): 2.7 to 9 during the CLI
    benchmarks, 14 to 39 during the corpus, 29 to 36 in process.
  - The startup checks above: 5.0 to 5.1, then 5.8.
  - [Large inputs](#large-inputs): 4.1 to 5.9.
  - [WebAssembly in Chrome](#webassembly-in-chrome): 3.6 to 6.3.
  - The `hash_str` check ([Hashing strings in
    WebAssembly](#hashing-strings-in-webassembly)): 5.3 to 7.4.

## CLI

10 timed runs per benchmark and command after one warm-up run; wall time in
ms, median (min). The rightmost column is the peak resident set size of one
more run. "Before" as in [Machine](#machine) (the last full run had no
TypeScript column; Phase 7's TypeScript medians were 1 to 10% lower than
these).

| Benchmark | TypeScript | Rust (before) | Rust (now) | vs TS | vs before | Peak RSS MiB (TypeScript / Rust (before) / Rust (now)) |
|---|---:|---:|---:|---:|---:|---:|
| **startup** | | | | | | |
| --version | 226 (222) | 2.26 (2.16) | 2.92 (2.61) | 77× | 0.8× | 149.7 / 3.4 / 3.5 |
| tiny JSON (77 B) → TypeScript | 244 (243) | 2.83 (2.53) | 2.85 (2.75) | 86× | 1.0× | 150.7 / 5.5 / 5.3 |
| **json** | | | | | | |
| pokedex (82 KB) → TypeScript | 266 (261) | 4.34 (4.19) | 3.95 (3.77) | 67× | 1.1× | 157.1 / 6.9 / 6.9 |
| us-senators (155 KB) → TypeScript | 272 (268) | 4.65 (4.43) | 4.38 (4.17) | 62× | 1.1× | 160.8 / 6.7 / 6.7 |
| misc/1b409 (606 KB) → TypeScript | 302 (298) | 6.95 (6.66) | 6.27 (5.86) | 48× | 1.1× | 175.2 / 7.9 / 7.9 |
| all 13 samples as one top-level (multi-source) → TypeScript | 352 (349) | 13.2 (13.0) | 12.2 (11.7) | 29× | 1.1× | 184.6 / 10.3 / 10.5 |
| generated (4 MB) → TypeScript | 543 (525) | 23.4 (23.3) | 20.1 (19.4) | 27× | 1.2× | 232.3 / 15.6 / 15.8 |
| generated (40 MB) → TypeScript | 2676 (2644) | 179 (175) | 155 (154) | 17× | 1.2× | 653.1 / 62.1 / 60.6 |
| generated (40 MB) → Rust | 2733 (2682) | 178 (175) | 171 (161) | 16× | 1.0× | 638.3 / 60.6 / 60.8 |
| **languages** | | | | | | |
| github-events (82 KB) → ts | 288 (285) | 5.99 (5.87) | 5.93 (5.68) | 49× | 1.0× | 174.0 / 7.5 / 7.5 |
| github-events (82 KB) → rust | 293 (285) | 6.19 (6.08) | 6.44 (6.22) | 46× | 1.0× | 173.4 / 7.3 / 7.3 |
| github-events (82 KB) → go | 300 (292) | 5.62 (5.49) | 6.95 (5.62) | 43× | 0.8× | 176.6 / 7.3 / 7.3 |
| github-events (82 KB) → cs | 294 (288) | 5.60 (5.50) | 5.99 (5.77) | 49× | 0.9× | 177.3 / 7.4 / 7.5 |
| github-events (82 KB) → java | 312 (302) | 8.16 (8.04) | 8.50 (8.20) | 37× | 1.0× | 175.8 / 9.2 / 9.2 |
| github-events (82 KB) → py | 297 (292) | 6.54 (6.45) | 6.53 (6.34) | 45× | 1.0× | 175.3 / 8.3 / 8.4 |
| github-events (82 KB) → swift | 284 (279) | 6.36 (6.24) | 6.31 (6.17) | 45× | 1.0× | 175.1 / 8.5 / 8.5 |
| github-events (82 KB) → c++ | 303 (294) | 7.69 (7.38) | 7.81 (7.55) | 39× | 1.0× | 175.1 / 9.3 / 9.3 |
| **schema** | | | | | | |
| vega-lite.schema (306 KB) → TypeScript | 439 (431) | 36.4 (36.1) | 38.7 (38.1) | 11× | 0.9× | 223.7 / 16.1 / 16.0 |
| vega-lite.schema (306 KB) → C# | 463 (450) | 39.4 (39.2) | 43.0 (42.4) | 11× | 0.9× | 226.8 / 18.3 / 18.5 |
| **graphql** | | | | | | |
| github.gqlschema (1.2 MB) + query → TypeScript | 269 (255) | 8.87 (8.76) | 9.16 (8.90) | 29× | 1.0× | 152.6 / 12.5 / 12.5 |
| **multi-file** | | | | | | |
| vega-lite.schema → Java (one file per class) | 504 (498) | 56.2 (55.8) | 55.8 (54.7) | 9.0× | 1.0× | 236.0 / 20.8 / 21.1 |
| pokedex → C++ (multi-source) | 275 (264) | 4.75 (4.63) | 4.52 (4.37) | 61× | 1.1× | 159.6 / 7.2 / 7.2 |

A second full run an hour later (load average 2.7 to 9 during the CLI
benchmarks, 14 to 39 during the corpus, 29 to 36 in process) agreed within
10% on every row but three: `--version` 2.52 ms, tiny JSON 5.77 ms (min
3.23 ms: half its runs were disturbed) and github-events → go 5.63 ms
(this run's 6.95 ms is the outlier; its minimum is 5.62 ms). Its corpus
took 447.8 s against 8.0 s (56×), and in process 325, 116 and 91.9 ms.
This file and `site/data/benchmarks.json` keep the first run.

## Golden corpus

Every step of every case in `tests/golden` (11,178 CLI runs: all target
languages, JSON, JSON Schema, GraphQL and TypeScript inputs, CLI behavior),
12 parallel jobs, outputs not checked (that is `cargo xtask parity`). "CLI
time" is the sum of every run's wall time under that load.

| Command | Steps | Wall time (s) | CLI time, summed (s) | Mean per step (ms) | Unexpected exits |
|---|---:|---:|---:|---:|---:|
| TypeScript | 11178 | 473.8 | 5672.5 | 507.5 | 0 |
| Rust (before: Phase 7) | 11178 | 12.5 | 133.7 | 12.0 | 381 |
| Rust (now) | 11178 | 9.0 | 95.5 | 8.5 | 0 |

The 381 unexpected exits before were the golden cases then outside the
parity baseline (C/cJSON output, since ported). The load average rose from
10 to 67 while the corpus ran: TypeScript's 12 jobs are CPU-bound on 12
cores, and another agent was building at the same time (Phase 7's run, at
a load of about 10, took 571.7 s for TypeScript).

## In process

The engine as a library, without process start or file I/O: every JSON
file in `tests/inputs/json/samples` plus `json/misc/1b409.json` (14 inputs)
through 8 languages (TypeScript, Rust, Go, C#, Java, Python, Swift, C++),
112 runs per iteration, with `JSON.parse` semantics as in the JavaScript
API. "Parse" reads the samples (into running tallies, on the Rust side);
"engine" is `quicktype_multi_file_sync` (inference, rewrites, naming,
rendering). Median of 10 iterations after warm-up (V8 optimizes the
TypeScript during three untimed iterations); ms.

| Engine | Total (min) | Parse | Engine | Per run | vs TypeScript |
|---|---:|---:|---:|---:|---:|
| TypeScript, warm Node (`xtask/bench/in-process.mjs`) | 342 (331) | 69.2 | 274 | 3.05 | 1.0× |
| Rust, system allocator | 118 (117) | 22.9 | 95.6 | 1.06 | 2.9× |
| Rust, mimalloc (the CLI's) | 92.8 (91.7) | 22.5 | 70.3 | 0.83 | 3.7× |

All three write the same 1,206,163 bytes of output per iteration. These
ran at a load average of 66 to 73; three later interleaved rounds at 4.4
to 5.5 gave totals of 334 to 350 ms (TypeScript), 116 to 124 ms (system
allocator) and 92 to 98 ms (mimalloc), so a single-threaded benchmark kept
its core. Phase 7 left these at 369, 199 and 153 ms ([its own before and
after](#phase-7-before-and-after)); reading into running tallies (Phase
8a) and the readers' work since took the Rust side to 98 ms
([The second phase](#the-second-phase-strings-that-change-nothing-and-keys-by-id)).

## Large inputs

The CLI on inputs of 27 MB to 3 GB (`site/data/big-inputs.json`), on all
cores (the default) and on one thread (`QUICKTYPE_READ_THREADS=1`, which
reads every sample in one go), and quicktype's CLI where it finished in
seconds. `-l ts -o <file>` (the Scryfall cards with `--just-types -t
Cards`); the commands of each block run in turn, after one untimed run
each (none for quicktype on the cards); wall time / CPU time (user +
system) and peak RSS of each run from `wait4`; medians.

| Input | Runs | All cores | One thread | quicktype | Load average |
|---|---:|---:|---:|---:|---:|
| generated (40 MB), an object at the top | 15 (5) | 170 / 168 ms, 60.6 MiB | 171 / 169 ms, 60.6 MiB | 2.67 / 3.48 s, 614 MiB | 5.6 (4.1–4.5) |
| 100k records (26.8 MB) | 11 | 12.2 / 58.1 ms, 19.6 MiB | 30.9 / 29.4 ms, 6.0 MiB | – | 5.6 |
| 1M records (267 MB) | 11 (3) | 56.7 / 453 ms, 21.5 MiB | 262 / 260 ms, 5.9 MiB | 5.44 / 7.10 s, 1.44 GiB | 5.6 (5.0–5.2) |
| 60 × generated (40 MB) in one array, 2.62 GB | 3 | 8.38 / 8.37 s, 64.2 MiB | 8.36 / 8.33 s, 63.0 MiB | – | 5.7–5.9 |
| 10.5 M objects with ~210-character strings, 2.53 GB | 3 | 308 ms / 2.69 s, 21.0 MiB | 1.40 / 1.39 s, 6.0 MiB | – | 5.7 |
| Scryfall cards (real data), 657 MB | 5 (3) | 284 ms / 1.74 s, 50.1 MiB | 1.43 / 1.43 s, 20.2 MiB | 29.9 / 38.6 s, 3.20 GiB | 5.3–5.5 (4.7–5.3) |
| the same cards as JSON Lines, 657 MB | 5 | 292 ms / 1.78 s, 49.7 MiB | 1.42 / 1.41 s, 20.2 MiB | – | 5.5–6.1 |
| Scryfall cards (real data), every language, 3.01 GB | 3 | 1.35 / 8.15 s, 148 MiB | 6.65 / 6.64 s, 96.2 MiB | – | 5.7–5.8 |

The JSON Lines row was measured when JSON Lines came to be read on
several threads, in a block of its own against main before that
(`4cf135e28`, which read them in one go: 1.43 / 1.43 s, 20.3 MiB in
that block, 1.53 / 1.53 s in this table's) and the array (283 ms / 1.73
s, 49.5 MiB); see [JSON Lines on several
threads](#json-lines-on-several-threads).
Every command wrote the same output: all cores against one thread on
every input, quicktype against quickertype on the 40 MB input (`cargo
xtask bench`), the 100k and 1M records and the 657 MB cards, and the
cards as JSON Lines against the array. quicktype was not run on the
2.5 to 3.0 GB inputs.

- **Reading on several threads** pays on the arrays: 4.6× less wall time
  on the 1M records for 1.7× the CPU time, 4.5× on the text-heavy input,
  5.0× on the cards and 4.9× on the cards in every language. Peak RSS
  grows with the threads: each one's read buffers and the tallies of the
  part it reads (148 against 96 MiB on the 3.0 GB cards, whose places
  hold many distinct strings).
- **The 40 MB input** is an object, read in one go either way. The
  2.6 GB input is read in one go with the default budget: one element's
  tallies (a map of 209,519 distinct keys) would fill it ([Reading on
  several threads](#reading-on-several-threads)). It took 8.38 s here
  against 7.25 s in that section; in a later block (load average 4.6 to
  4.9), main took 7.80 s and main before the parallel read was merged
  (`e2e3f3fc9`, which took 7.25 s then) 8.01 s, so the difference is the
  machine's, not the code's.
- **Against quicktype**, on real data: the 657 MB of cards take 105× less
  wall time and 65× less memory (quicktype: 29.9 s and 3.20 GiB; on one
  thread quickertype still takes 21× less time). On the 1M records,
  quicktype takes 5.44 s and 1.44 GiB.
- **JSON Lines** are read on several threads as their array is: the cards
  as JSON Lines take 292 ms on all cores against the array's 283 ms in
  the same block, and on one thread what the array takes.

How each input is made (the scripts are in the repository, the card data
is not):

- generated (40 MB): `cargo xtask bench` writes
  `target/bench/generated-large.json`.
- 100k and 1M records: `generateRulings(100000)` and
  `generateRulings(1000000)` from
  `npm/quicktype-core/test/bench/generate.mjs`
  ([PROFILE-RECORDS.md](PROFILE-RECORDS.md#reproducing)).
- 2.6 GB: 60 copies of the 40 MB input in one array, as in [Memory on
  large inputs](#memory-on-large-inputs).
- text-heavy (2.5 GB, 2,528,770,412 bytes): the script below. The file of
  the same description in [Memory on large
  inputs](#memory-on-large-inputs) was made by a script that was not kept,
  so its numbers are not comparable with these.
- Scryfall cards (real data): Scryfall's bulk data, "Default Cards"
  (120,095 cards, 656,501,037 bytes, one card per line) and "All Cards"
  (551,910 cards in every language, 3,010,396,357 bytes), as of November
  2026; the JSON Lines copy has the same cards, one per line without the
  brackets and commas.

```sh
python3 -c 'import random, sys
r = random.Random(1)
w = "the quick brown fox jumps over a lazy dog while seven bright stars glow above quiet hills and rivers run to an open sea".split()
s = [" ".join(r.choice(w) for _ in range(60))[:208] for _ in range(4096)]
with open(sys.argv[1], "w") as f:
    f.write("[")
    for i in range(10_500_000):
        f.write(f"{\",\" if i else \"\"}\n{{\"id\":{i},\"text\":\"{s[i % 4096]} {i:x}\"}}")
    f.write("]\n")' target/bench/text.json
/usr/bin/time -l target/release/quickertype target/bench/text.json -l ts -o out.ts
QUICKTYPE_READ_THREADS=1 /usr/bin/time -l target/release/quickertype target/bench/text.json -l ts -o out.ts
```

## WebAssembly in Chrome

The JS API's WebAssembly engine against quicktype's TypeScript engine,
warm, in one headless Chrome page (`node --expose-gc
npm/quicktype-core/test/bench/compare.mjs --browser --again`):
`addSource`, then `quicktypeMultiFile` to TypeScript, the two engines
interleaved, medians of 41 runs (21 for 2 MB, 9 for the larger inputs),
and of those the median of three runs of the benchmark (`site/data/browser.json`).
Reading, generating and the whole run, then a second run's generating on
the same input ("again"), ms. Each is its own median, so reading and
generating need not add up to the total. Chrome's timer steps by 0.1 ms
here:

| Input | quickertype: read / generate / total; again | quicktype: read / generate / total; again | × quicktype | Generating only |
|---|---:|---:|---:|---:|
| pokedex (82 KB) | 0.50 / 1.10 / 1.60; again 0.80 | 1.20 / 3.50 / 4.70; again 2.20 | 2.9× | 3.2× |
| generated (2 MB) | 9.10 / 5.10 / 14.1; again 2.70 | 22.4 / 21.7 / 44.0; again 14.6 | 3.1× | 4.3× |
| generated (20 MB) | 89.1 / 33.0 / 122; again 11.9 | 247 / 159 / 406; again 150 | 3.3× | 4.8× |
| rulings: 100k records (27 MB) | 46.5 / 6.60 / 53.1; again 0.30 | 79.9 / 76.0 / 156; again 71.8 | 2.9× | 12× |
| cards: 5k generated cards (22 MB) | 89.7 / 23.5 / 113; again 6.10 | 137 / 235 / 371; again 229 | 3.3× | 10× |

The three runs were within 8% of each other (the first, at a load average
of 5.6 to 6.1, the slowest). Before, in [Inference from tallies in the
engine](#inference-from-tallies-in-the-engine) (load average 3 to 4):
pokedex 2.30 against 5.10, 20 MB 145 against 404, the records 65.8
against 179. The engine's totals are 16 to 30% lower, after the slab
allocator, the hashing and the cards' URIs and walk (the sections below).

First runs in a fresh Node.js process (`compare.mjs --cold 7`), which
compiles the engine first: reading, generating and the whole run, each
its own median of 7, ms, and the process's CPU time in parentheses:

| Input | quickertype: read / generate / total (CPU) | quicktype: read / generate / total (CPU) |
|---|---:|---:|
| pokedex (82 KB) | 3.90 / 47.3 / 51.1 (130) | 3.79 / 26.0 / 29.5 (46.6) |
| generated (2 MB) | 26.5 / 45.4 / 71.9 (165) | 38.1 / 54.8 / 93.6 (171) |
| generated (20 MB) | 148 / 90.7 / 239 (370) | 393 / 246 / 640 (890) |
| rulings: 100k records (27 MB) | 82.1 / 32.4 / 114 (191) | 125 / 120 / 245 (431) |
| cards: 5k generated cards (22 MB) | 131 / 72.2 / 202 (343) | 275 / 347 / 625 (821) |

On pokedex the engine's compilation dominates, as before (51.6 against
28.5 ms in [Inference from tallies in the
engine](#inference-from-tallies-in-the-engine)); the records' first run
went from 134 to 114 ms.

The module is 5.21 MiB after `wasm-opt` (`npm run build`).

## What Phase 7 changed

Profiles (samply on the `profiling` build, `--debug print-times`, the
in-process benchmark) showed the time going to a handful of places. In
order of impact:

| Commit | Hot spot | Fix | Effect |
|---|---|---|---|
| `perf(core): one forbidden-name set per namespace` | `Naming.assignNames` copies the namespace's forbidden names into a new `Set` for every group of names: quadratic, and C++/C#/Java/Swift forbid ~100 keywords per namespace (31% of in-process time) | the namer inserts into one set the caller keeps; the case-insensitive index is built lazily | in-process engine 212 → 144 ms; vega-lite → Java 100 → 80 ms |
| `perf(js-compat): compile pluralize's rules on demand` | compiling pluralize's 64 regexes up front, ~7 ms per process, more than a whole small run | one multi-pattern `regex-automata` searcher per rule list (0.6 ms) finds the rules that match; only the applied rule's regex is compiled, for its captures | pokedex 11.5 → 7.7 ms; corpus CLI time 135 → 96 s |
| `perf(core): decode the shipped Markov chain at build time` | rANS-decoding the 65³ trigram table on the first `InferMaps`, ~1.5 ms per process | `build.rs` decodes it with the same decoder; native builds embed the 268 KB table (WASM still decodes once per instance) | tiny input 4.6 → 3.1 ms |
| `perf(cli): mimalloc as the global allocator` | malloc/free were 25–30% of every profile | `mimalloc` behind the CLI's default `mimalloc` feature | 1.1–1.4× on everything but `--version`; lower peak RSS on large inputs |
| `perf(core): foldhash for lookup-only hash maps and sets` | SipHash ~10% of engine time (string interning, naming) | `support::fast_hash::{HashMap, HashSet}` with foldhash (still per-process seeded); `IndexMap`/`IndexSet` unchanged | in-process 164 → 152 ms |
| `perf(core): fewer allocations and string compares reading JSON samples` | the stream reader allocated a `String` per string and key, validated UTF-8 lossily, and compared every integer literal to the int64 bounds as UTF-16 strings | borrow escape-free strings, `str::from_utf8`, allocation-free UUID check; `compareIntegerStrings` compares ASCII digits as bytes and `integerStringInRange` splits the literal once | 40 MB input 434 → 340 ms |
| `perf(core): take valid UTF-8 input over without copying` | `from_utf8_lossy(..).into_owned()` copied the whole input | `String::from_utf8`, lossy only on invalid input | 40 MB input 338 → 327 ms |
| `perf(js-compat): table lookup for Latin-1 categories` | `getCategory` binary-searched 3,823 runs per code unit of every name | a 256-entry table built at compile time | github-events → C++ in process −7% |
| `perf(core): style each raw name once per namer` | every name styled 2–3 times while names are assigned | `Namer` memoizes its (pure) name style | C++/Java render −6–10% |
| `perf(core): build alternative type names without format!` | `format!` was 40% of `gatherNames` | concatenation into a sized `String` | not measured on its own |
| `perf(core): don't copy string cases in expandStrings` | every restricted string's case map copied twice per type, a set intersection built only to count it | borrowing `mapped_cases`/`mapped_transformations`, counting | 40 MB `expand strings` 13.5 → 7.6 ms |
| `perf(js-compat): slice the authority in Uri::parse` | the URI authority collected char by char for every URI string value | `&after[2..]` | small |
| `perf(cli): read JSON samples chunk by chunk` | each sample read whole into memory before parsing | 64 KiB chunks through a decoding window (see [Memory on large inputs](#memory-on-large-inputs)) | the raw input leaves the parsing phase; times unchanged |
| `perf(core): CompressedJSON keeps objects, arrays and strings in blocks` | one `Vec` per object and array, every string held twice | block tables with spans, strings once with an index table | 2.6 GB input: tables 3.06 → 2.37 GiB, peak 6.73 → 5.76 GiB |

Considered and left out:

- **`target-cpu=native`**: no measurable difference on Apple M2 (the
  `aarch64-apple-darwin` default is already `apple-m1`). It stays opt-in:
  `RUSTFLAGS="-C target-cpu=native" cargo build --release`.
- **foldhash for `IndexMap`/`IndexSet`**: safe for output (their order is
  insertion order, whatever the hasher), and SipHash on them is still
  5–10% of engine time, but they appear in quicktype-core's public types
  (`Type`, `StringTypes`, `JsonValue`, `MultiFileRenderResult`, ...), so
  switching their hasher changes the Rust API used by the GraphQL input,
  the CLI and the WASM bindings. Worth doing as its own change. (Since
  inference uses tallies on every path, SipHash is 2–8% of a WebAssembly
  run, most of it in public types: see [Inference from tallies in the
  engine](#inference-from-tallies-in-the-engine).)

### Phase 7: before and after

Measured on November 13, 2026, before Phase 8a: "before" is `11091954f`
(the merge of `feat/graphql-input`, where Phase 7 started), "after" is
`54611ae41`. The machine was shared with other work (load average around
10); the in-process runs were interleaved in three rounds. The whole CLI
table of that run is in this file's history
(`git show 54611ae41:docs/BENCHMARKS.md`).

| | TypeScript | Rust before Phase 7 | Rust after | vs TypeScript | vs before |
|---|---:|---:|---:|---:|---:|
| Startup, `--version` | 217 ms | 2.09 ms | 2.26 ms | 96× | 0.9× |
| Tiny JSON (77 B) | 241 ms | 4.16 ms | 2.83 ms | 85× | 1.5× |
| Small JSON (pokedex, 82 KB) | 257 ms | 11.7 ms | 4.78 ms | 54× | 2.5× |
| github-events (82 KB), 8 languages | 271–289 ms | 15.0–31.1 ms | 6.4–9.0 ms | 32–43× | 2.3–3.4× |
| Large JSON (generated, 40 MB) | 2,621 ms | 595 ms | 319 ms | 8.2× | 1.9× |
| JSON Schema (vega-lite, 306 KB) → TS | 418 ms | 61.3 ms | 37.4 ms | 11× | 1.6× |
| Golden corpus, 11,178 CLI runs (wall, 12 jobs) | 571.7 s | 18.4 s | 12.5 s | 46× | 1.5× |
| In process, 112 runs (engine as a library) | 369 ms (warm Node) | 288 ms | 153 ms | 2.4× | 1.9× |
| JS API in Chrome, 20 MB JSON (WebAssembly engine, warm; see [WebAssembly](#webassembly)) | 435 ms | 502 ms (main) | 230 ms | 1.9× | 2.2× |
| Peak RSS, 40 MB input | 625 MiB | 221 MiB | 154 MiB | 4.1× less | 1.4× less |
| Peak RSS, 2.6 GB input | — | 6.73 GiB | 5.76 GiB | — | 1.2× less |

Wall-time medians. The CLI's lead over TypeScript on small inputs is mostly
Node's startup (~215 ms); on large inputs and in process it is the engine
itself, which this phase made about twice as fast. The one regression,
`--version` (+0.17 ms), is mimalloc's set-up and tear-down; it pays for
itself as soon as there is any input to read (build with
`--no-default-features` for the system allocator).

In process, as in [In process](#in-process) (then, "parse" built the
`JsonInput`: `JSON.parse` and `CompressedJSON`):

| Engine | Total (min) | Parse | Engine | Per run | vs TypeScript |
|---|---:|---:|---:|---:|---:|
| TypeScript, warm Node (`xtask/bench/in-process.mjs`) | 369 (340) | 72.5 | 298 | 3.30 | 1.0× |
| Rust before, system allocator | 288 (283) | 66.7 | 221 | 2.57 | 1.3× |
| Rust after, system allocator | 199 (190) | 60.1 | 138 | 1.77 | 1.9× |
| Rust after, mimalloc (the CLI's) | 153 (145) | 51.4 | 102 | 1.37 | 2.4× |

All four write the same 1,206,163 bytes of output per iteration. Before
this phase, inference-to-rendering ran only 1.35× faster natively than
warm V8, which is why the WebAssembly engine was no faster than TypeScript
(see [WebAssembly](#webassembly)). Per input and language, the largest
gains are where naming dominated: github-events → C++ went from 20.2 ms to
4.6 ms per run, → Java from 14.5 ms to 4.5 ms (`--per-input`).

## Memory on large inputs

Two changes of Phase 7 target multi-GB inputs (measured separately from
its tables above, on the same machine). Since Phase 8a, the 2.6 GB input
peaks at 64 MiB instead (see [Large inputs](#large-inputs)).

- **Streaming.** The CLI used to read each JSON sample (a file or standard
  input) whole before parsing it. It now reads chunks (8 KiB at first,
  doubling up to 64 KiB) through a decoding window, as TypeScript's
  stream-json does: only the current token is kept (whitespace is dropped
  while it is skipped; a single huge token, such as a 1 GB string, is held
  whole), every look-ahead reads more first, and UTF-8 split between
  chunks decodes as Node's `StringDecoder` does
  (`quicktype_js_compat::utf8::Decoder`). A read that fails after the open
  is Node's stream error (`EISDIR: illegal operation on a directory,
  read`), as the reference reports it. Values and errors cannot depend on
  the chunking: unit tests read every sample input and every prefix of a
  tricky document in chunks of 1 to 16 bytes and of 8 KiB, and `cargo
  xtask diff` found 285 files identical to the TypeScript CLI, from files
  and from standard input: split, invalid and truncated sequences at the
  8, 16, 64, 128 and 192 KiB boundaries, 350,000 bytes of whitespace, a
  300,000-character string, BOM, empty and whitespace-only input. URL
  bodies are still fetched whole, then read the same way. A sample given
  as bytes (`JsonSample::Stream`, the Rust API) is decoded once and
  tokenized in memory, borrowing valid UTF-8.
- **Compact CompressedJSON.** Objects' entries and arrays' elements live in
  shared blocks of at least 64K items that are never reallocated (each
  object or array a 12-byte span) instead of one `Vec` per object or
  array, and interned strings are stored once (64 KiB text blocks, a
  `hashbrown::HashTable<u32>` of indexes) instead of as `Rc<str>`s held by
  both the table and the lookup map.

| Input | Before: time, peak RSS | After: time, peak RSS |
|---|---:|---:|
| generated (4 MB) | 42.8 ms, 27.7 MiB | 42.2 ms, 22.7 MiB |
| generated (40 MB) | 345 ms, 177.5 MiB | 350 ms, 154.2 MiB |
| 60 × generated (40 MB) in one array, 2.6 GB | 19.0 s, 6.73 GiB | 18.8 s, 5.76 GiB |
| 10.5 M objects with ~200-character strings, 2.6 GB | 6.5 s, 4.32 GiB | 6.0 s, 3.86 GiB |

After a second review (spare buffers capped and released after each
sample, strings hashed once, the tokenizer generic over its text instead
of a `Cow`, the in-memory path for byte samples), the numbers stay the
same: 40 MB in 357.9 ms (median of 30, against 357.5 ms before those
changes) and 150 MiB, the 2.6 GB record file in 19.6 s and 6.18 GB. 500
small files (2.4 MB, `--src` a directory of copies of the small sample
inputs) take 63.5 ms (64.3 ms before), and reading the same 500 samples
as bytes in process (`CompressedJson::parse_stream`, best of 30) takes
2.01 ms instead of 2.21 ms.

Output is byte-identical in every case. The streaming alone does not
lower these peaks: the whole-file buffer was already freed before type
inference, and inference is where the peak is. It takes the raw file out
of the parsing phase (on the 2.6 GB file, 2.4 GiB of input plus 3.1 GiB of
tables then, 2.4 GiB of tables now), which is what bounds memory when
inference is cheap.

Where the 5.76 GiB peak of the 2.6 GB record file goes (the RSS reaches
2.37 GiB when parsing ends, then grows during inference):

| Part | Size |
|---|---:|
| CompressedJSON: object entries, 129.9 M × 16 B | 1.94 GiB |
| CompressedJSON: object spans, 22.0 M × 12 B | 0.25 GiB |
| CompressedJSON: array elements, 16.2 M × 8 B, and spans, 7.2 M × 12 B | 0.20 GiB |
| CompressedJSON: string table, 0.6 M strings | 0.02 GiB |
| Inference: one attribute set per string value in the union accumulators (the string types of every date, UUID, URI, integer string and long string, as the TypeScript keeps them) | ~1.9 GiB |
| Inference: the values of each property and array, gathered per class | ~1.4 GiB |
| Type graph, naming, rendering | negligible (tens of types) |

The attribute-set share was measured by an experiment that kept only the
first set per kind (not a valid change: it alters output in general):
the peak dropped by 2.1 GB on the record file and by 3.0 GB on the
text-heavy file. Phase 8a then removed all three parts on the CLI's path
by inferring from running tallies; see
[Streaming inference](#streaming-inference-phase-8a).

To reproduce: build the 2.6 GB file from the benchmark's generated input
and measure with `/usr/bin/time -l` (delete the file afterwards):

```sh
cargo xtask bench --no-ref --filter "generated (40" -n 1   # writes target/bench/generated-large.json
python3 -c 'd = open("target/bench/generated-large.json", "rb").read().rstrip()
open("target/bench/huge.json", "wb").write(b"[" + b",\n".join([d] * 60) + b"]")'
/usr/bin/time -l target/release/quickertype target/bench/huge.json -l ts -o out.ts
rm target/bench/huge.json
```

## Streaming inference (Phase 8a)

JSON types are inferred from running tallies instead of from a
`CompressedJSON` copy of every sample (see
[STREAMING-INFERENCE.md](STREAMING-INFERENCE.md)): while the reader
streams, each place in the samples counts what inference reads (kinds in
first-seen order, string cases with counts, the other strings' combined
attributes, object and key counts), and nothing else is kept. Output is
byte-identical (`cargo xtask parity`, the differential harness, the
TypeScript CLI on 2,000 generated documents, and both inputs below).

"Before" is `e41fe731d` (main when the branch started), "after" this
branch, both `cargo build --release -p quickertype`, `--lang ts -o
/dev/null`, measured with `/usr/bin/time -l` in interleaved rounds. The
machine was heavily shared while these were taken (load average 130–180
on 12 cores, from other work), so wall times are several times the quiet
numbers above and vary a lot; CPU time (user + system) and peak RSS are
the stable figures.

| Input | Before: wall, CPU, peak RSS | After: wall, CPU, peak RSS |
|---|---:|---:|
| generated (40 MB): wall median of 16, CPU median of 9 | 2.93 s, 0.53 s, 150.1 MiB | 1.97 s, 0.39 s, 82.4 MiB |
| 60 × generated (40 MB) in one array, 2.6 GB: wall median of 3, CPU of 1 | 169 s, 31.4 s, 5.0–5.8 GiB | 111 s, 21.5 s, 73–82 MiB |

Peak memory on the 2.6 GB input drops from 5.0–5.8 GiB to 82 MiB, the
same as for the 40 MB input it repeats: the tallies grow with what is
distinct, not with the size.

The review of the branch then removed the largest transient part:
inferring the `preferences` map gathered its 209,519 keys' places into an
index map with a one-element list per key (~15–20 MiB); the objects of a
single place now use the place's tally as it is. Measured as above
(`/usr/bin/time -l`, the branch before and after the review's fixes, same
build settings, on the shared machine, at a load average between 13 and
about 40 on 12 cores; output identical):

| Input | Before the fixes: CPU, peak RSS | After: CPU, peak RSS |
|---|---:|---:|
| generated (40 MB), 10 interleaved runs each | 0.25 s, 82.4 MiB | 0.24 s, 62.0 MiB |
| 60 × generated (40 MB), 2.6 GB, one run each | 15.5 s, 82.0 MiB | 14.3 s, 59.7 MiB |

What is left at the peak, for both inputs (sizes estimated from the
structures):

| Part | Size |
|---|---:|
| `preferences`, a map of 209,519 distinct random keys: a node and a key count per key, the key text once | ~20 MiB |
| String cases of 11 places (141,000 distinct: e-mail addresses, streets, ZIP codes, SKUs, ...) with their counts, the text once | ~10 MiB |
| The process, the reading window, the type graph, rendering | the rest |

Before, the peak was the `CompressedJSON` tables (2.4 GiB), one
string-attribute set per string value in the union accumulators
(~1.9 GiB) and the per-property value lists (~1.4 GiB); none of them
exist on the new path. CPU time drops by a quarter to a third: tokenizing is
unchanged, but nothing is stored per value, and inference touches each
place once instead of each value.

Text samples (`JsonSample::String`, the JavaScript API's `JSON.parse`
semantics) are parsed whole, as `JSON.parse` does, and the parsed value
is emitted straight into the tallies, so parsing costs more and inference
less. Before the review's fixes they were also built into the compressed
form, kept, and walked into the tallies a second time. The in-process
benchmark (112 runs per iteration, `QUICKTYPE_INFERENCE=compressed-json`
for the reference path; built without LTO; medians of seven interleaved
rounds of 10 iterations, wall time per iteration and CPU time of the
whole process, at a load average of 13–25 on 12 cores, so these are far
below the first measurements, taken at 130–180):

| Inference from | Total | Parse | Engine | Process CPU |
|---|---:|---:|---:|---:|
| Running tallies | 150 ms | 64 ms | 86 ms | 1.64 s |
| Running tallies, before the review's fixes | 165 ms | 76 ms | 89 ms | 1.82 s |
| `CompressedJSON` (the reference) | 164 ms | 54 ms | 110 ms | 1.81 s |

The parse phase alone (`--parse-only`, 31 iterations, CPU time of the
process, median of five): 1.94 s from tallies, 2.30 s before the review's
fixes, 1.61 s on the reference path. (The first measurements, at a load
average of 130–180, had the parse phase at 419 ms from tallies and 320 ms
on the reference path, wall time per iteration.)

Since `feat/wasm-native-json` was merged, text samples are read by its
one-pass `JSON.parse` reader into the tallies too (the reader checks V8's
grammar on a tape and emits it without building the value; see
[WebAssembly](#webassembly)). The parse phase into the tallies
(`--parse-only -n 30`, CPU time of the process, median of five
interleaved, load average about 30) went from 2.07 s (main at `569e83ddd`)
to 1.10 s.

To reproduce, as in [Memory on large inputs](#memory-on-large-inputs),
with `target/before/quicktype` built from `e41fe731d`:

```sh
for bin in target/before/quicktype target/release/quickertype; do
  /usr/bin/time -l $bin target/bench/huge.json -l ts -o /dev/null
done
QUICKTYPE_INFERENCE=compressed-json target/release/quickertype ...   # the reference path, same binary
cargo bench -p quickertype --bench in_process --no-run   # prints the benchmark binary
/usr/bin/time -l <benchmark binary> --parse-only -n 30   # the parse phase's CPU time
```

## Reading after the CLI profile

[PROFILE-RECORDS.md](PROFILE-RECORDS.md) found that reading the sample
is 95% of a large run, and ranked what could be made faster without
changing the output. Four of its items are done (its
[Status](PROFILE-RECORDS.md#status) has each one's gain and how it was
checked):

- the stream tokenizer scans string bodies eight bytes at a time (item
  1);
- it checks whether to drop consumed text with one comparison per token
  (item 3a);
- under the default date/time recognizer, a 36-byte string is tested for
  a UUID first (item 3b);
- pluralize's rule automata are built at compile time (item 6).

Output is byte-identical: 20,484 CLI runs against main, `cargo xtask
parity` (11,177 of 11,177), the differential harness on a million seeds
and npm/quicktype-core's differential suite.

**Records and text, interleaved.** Main (`d459c3e26`) and this branch,
both `cargo build --release -p quickertype`, `-l ts -o <file>`, run in
turn: medians of 21 runs (9 for 1M records, 100 for the small inputs);
wall / CPU time in ms (user + system, from `wait4`) and peak RSS. Load
average 5 on 12 cores.

| Input | Main | This branch | Change |
|---|---:|---:|---:|
| 100k records (26.8 MB, the profile's) | 52.3 / 51.0 ms, 10.6 MiB | 35.9 / 34.8 ms, 9.7 MiB | −31% |
| 1M records (267 MB) | 478 / 477 ms, 43.5 MiB | 323 / 322 ms, 43.1 MiB | −32% |
| 100k records, pretty-printed (30.3 MB) | 54.1 / 52.9 ms, 10.7 MiB | 37.7 / 36.5 ms, 9.8 MiB | −30% |
| 20k generated articles: long text with escapes and non-ASCII (23.4 MB) | 81.0 / 79.7 ms, 19.7 MiB | 68.5 / 67.1 ms, 19.4 MiB | −15% |
| pokedex (82 KB) | 5.5 / 4.5 ms, 8.0 MiB | 4.7 / 3.8 ms, 6.9 MiB | −13% |
| github-events (82 KB) | 7.0 / 6.0 ms, 8.5 MiB | 6.4 / 5.4 ms, 7.5 MiB | −10% |
| `[{"a":1}]` (9 bytes) | 4.1 / 3.2 ms, 7.1 MiB | 3.5 / 2.6 ms, 5.5 MiB | −14% |

The records gain most from the word scan and the UUID check; the
articles, whose strings are long and have no UUIDs, from the word scan
alone. Small inputs gain the 0.7 ms and 1–1.6 MiB that building
pluralize's singular rules cost every process.

**`cargo xtask bench`**, with main as `--baseline`: 10 runs per
benchmark and command after a warm-up, not interleaved, wall time in ms,
median (min), and peak RSS. Load average 4 to 5. The first two rows ran
while the machine was still settling and are noise.

| Benchmark | Main | This branch | Peak RSS MiB (main / branch) |
|---|---:|---:|---:|
| --version | 7.63 (6.71) | 3.46 (3.03) | 3.5 / 3.5 |
| tiny JSON (77 B) → TypeScript | 8.31 (7.25) | 8.44 (6.32) | 5.3 / 5.3 |
| pokedex (82 KB) → TypeScript | 5.14 (5.04) | 4.34 (4.19) | 7.7 / 6.9 |
| us-senators (155 KB) → TypeScript | 5.48 (5.19) | 4.65 (4.43) | 7.8 / 6.7 |
| misc/1b409 (606 KB) → TypeScript | 8.14 (7.68) | 6.95 (6.66) | 8.6 / 7.9 |
| all 13 samples as one top-level (multi-source) → TypeScript | 16.3 (14.5) | 13.2 (13.0) | 10.5 / 10.3 |
| generated (4 MB) → TypeScript | 26.2 (25.9) | 23.4 (23.3) | 15.8 / 15.6 |
| generated (40 MB) → TypeScript | 206 (199) | 179 (175) | 62.2 / 62.1 |
| generated (40 MB) → Rust | 201 (198) | 178 (175) | 60.7 / 60.6 |
| github-events (82 KB) → ts | 6.79 (6.47) | 5.99 (5.87) | 8.5 / 7.5 |
| github-events (82 KB) → rust | 7.28 (6.95) | 6.19 (6.08) | 8.4 / 7.3 |
| github-events (82 KB) → go | 6.77 (6.36) | 5.62 (5.49) | 8.3 / 7.3 |
| github-events (82 KB) → cs | 6.36 (6.26) | 5.60 (5.50) | 8.5 / 7.4 |
| github-events (82 KB) → java | 9.00 (8.71) | 8.16 (8.04) | 9.4 / 9.2 |
| github-events (82 KB) → py | 7.40 (7.24) | 6.54 (6.45) | 9.2 / 8.3 |
| github-events (82 KB) → swift | 7.17 (6.94) | 6.36 (6.24) | 9.2 / 8.5 |
| github-events (82 KB) → c++ | 8.12 (7.77) | 7.69 (7.38) | 9.8 / 9.3 |
| vega-lite.schema (306 KB) → TypeScript | 37.3 (37.0) | 36.4 (36.1) | 16.1 / 16.1 |
| vega-lite.schema (306 KB) → C# | 41.5 (40.3) | 39.4 (39.2) | 17.8 / 18.3 |
| github.gqlschema (1.2 MB) + query → TypeScript | 9.27 (9.08) | 8.87 (8.76) | 13.0 / 12.5 |
| vega-lite.schema → Java (one file per class) | 56.5 (55.4) | 56.2 (55.8) | 20.8 / 20.8 |
| pokedex → C++ (multi-source) | 5.66 (5.33) | 4.75 (4.63) | 8.0 / 7.2 |

The TypeScript CLI ran in the same benchmark (pokedex 398 (284) ms,
github-events 274–291 ms, the 40 MB input 2,676 ms), so it is not
repeated here.

**Module and binary sizes.** The pluralize DFAs, minimized, are 223 KB
(plural rules) and 276 KB (singular), 15 KB gzipped, in the CLI and in
the WebAssembly engine alike; the build script's translated patterns
replace the code that translated them. Bytes; gzip with `-9`, brotli
with `-q 11`:

| Build | Main | This branch |
|---|---:|---:|
| CLI (`target/release/quicktype`) | 8,515,296 | 8,795,984 |
| `quicktype_wasm.wasm` (`cargo build -p quicktype-wasm --release`) | 6,463,986; gzip 1,980,187 | 6,760,572; gzip 1,994,881 |
| `quicktype_wasm_bg.wasm` as npm/quicktype-core ships it (wasm-bindgen, `wasm-opt -O3`) | 5,259,102; gzip 1,911,724; brotli 1,262,314 | 5,439,624; gzip 1,929,933; brotli 1,271,602 |

The module the package ships grows by 181 KB, 18 KB gzipped and 9 KB
with brotli. In exchange, a new engine instance loads the rules'
patterns and automata instead of translating and building them for its
first array (natively 30–37 µs per rule list instead of 75–89 µs to
translate and 0.7–1 ms to build; not measured in a browser). Minimizing
the DFAs saved 5.5 KB of the shipped module, 60 bytes gzipped, and
loads them as fast; unminimized, the module was 5,445,167 bytes, gzip
1,929,993.

### The second phase: strings that change nothing, and keys by id

After the tallies' follow-ups were merged, three more of the profile's
items were done (PROFILE-RECORDS.md's [Status](PROFILE-RECORDS.md#status)
has each one's gain and how it was checked):

- a place whose string types are unrestricted with and without enum
  inference counts no more cases, and the reader neither classifies nor
  interns a string there that cannot be a URI (item 2), in the CLI and
  in the walk over a compressed form alike;
- a string's UTF-16 length is measured only where its UTF-8 length
  leaves it open (item 3c);
- reading text samples into running tallies counts the `JSON.parse`
  reader's keys by their key-table id, not by their text (item 8; the
  Rust API's path).

Item 5 (comparing a string with its place's last case before hashing
it) was tried and dropped: the follow-ups' case slots already count a
recurring case without hashing it, and the comparison cost more on
inputs whose places vary than it saved on the records.

**The CLI**, interleaved with main (`397dbbbf2`, with the first phase
and the follow-ups), `-l ts -o <file>`, medians of 21 runs (9 at 1M, 25
for the generated input, 100 for pokedex), wall / CPU ms and peak RSS,
load average 5:

| Input | Main | This branch | Change |
|---|---:|---:|---:|
| 100k records (26.8 MB) | 33.7 / 32.5 ms, 9.7 MiB | 30.5 / 29.2 ms, 6.0 MiB | −10% |
| 1M records (267 MB) | 294 / 293 ms, 43.1 MiB | 262 / 260 ms, 6.0 MiB | −11% |
| 100k records, pretty-printed (30.3 MB) | 35.8 / 34.3 ms, 9.8 MiB | 32.7 / 31.3 ms, 6.0 MiB | −9% |
| 20k generated articles (23.4 MB) | 69.2 / 67.7 ms, 19.5 MiB | 61.5 / 60.2 ms, 19.5 MiB | −11% |
| generated (43.7 MB, `cargo xtask bench`'s) | 195 / 193 ms, 62.3 MiB | 191 / 189 ms, 62.2 MiB | −2% |
| pokedex (82 KB) | 5.5 / 4.4 ms, 6.9 MiB | 5.6 / 4.4 ms, 6.9 MiB | 0 |

The records' `comment` field and the articles' `body` are unrestricted
from their first long string on, and most of what is left of reading
them was counting and interning the short ones after it: at 1M records
the peak RSS falls from 43 to 6 MiB, which no longer grows with the
input. The generated input's places keep their cases, and gain only the
UTF-16 bound (item 3c).

**Text samples** (`JSON.parse` semantics) read into running tallies, as
the Rust API reads `JsonSample::String`: the in-process benchmark's
parse phase (112 runs of 14 inputs, `--parse-only -n 20`, medians of
three interleaved rounds) 29.3 → 28.2 ms; a whole iteration 99.4 → 98.2
ms. On the large inputs (a scratch benchmark of `add_source_sync`, fat
LTO, mimalloc, medians of 9 in four interleaved rounds), item 8 alone:
100k records 30.0 → 27.8 ms, generated 43.7 MB 177–181 → 170–176 ms,
the text-heavy input 19.9–21.1 → 19.2–19.7 ms.

**The WebAssembly engine.** Warm, headless Chrome (157), `compare.mjs
--browser --again`, medians of 41, ms; reading + generating, then the
second run's generating ("again", from the tallies kept with the form);
the ranges are of three runs of the benchmark, each with the variants
interleaved, load average 2 to 10 (the 2 MB input was in one of them):

| Input | Main | This branch | TypeScript |
|---|---:|---:|---:|
| generated (2 MB) | 9.90 + 7.20 = 17.1; again 3.30 | 9.90 + 7.20 = 17.1; again 3.30 | 22.4 + 21.0 = 43.3; again 14.8 |
| generated (20 MB) | 96.6–97.8 + 48.7–48.9 = 145–147; again 13.4–13.6 | 97.1–97.9 + 48.8–49.2 = 146–147; again 13.5 | 240–248 + 144–154 = 394–399; again 147–153 |
| 100k records (27 MB) | 50.9–51.6 + 7.90–8.00 = 58.9–59.5; again 1.60 | 51.0–51.6 + 6.50 = 57.5–58.1; again 0.40 | 77.7–81.5 + 81.8–88.7 = 163–166; again 72.3–72.9 |

Cold (a fresh browser after the page compiled the module, median of 7):
generated 20 MB 130 + 89.4 = 219 on main, 131 + 88.9 = 220 on this
branch (TypeScript 266 + 195 = 465); records 70.7 + 29.1 = 99.8 and
71.2 + 26.5 = 98.0 (TypeScript 87.0 + 101 = 188).

Reading is unchanged: the engine reads into compressed forms, which none
of these items touch. Generating the records gains 1.3–1.5 ms, and a
second run on them 1.2 ms: the `comment` field's 10,671 short comments
are no longer counted, and so no longer replayed into the union
accumulator. The tallies kept with the records' form shrink from 310,511
to 1,052 bytes (what the engine holds after a run: 12,190,139 →
11,880,680 bytes); the generated inputs' are unchanged. The generated 20
MB input's first run takes what it took on main: neither item recovers
the 1.4–2.6 ms the tallies' follow-ups added there. (Item 8's first
version slowed it by 2 ms more: `add_key` got a second caller and was no
longer inlined into the walk; it is now inlined always.) The module the
package ships is 5,448,343 bytes against main's 5,448,313 (gzip
1,934,872 against 1,934,855; brotli 1,271,716 against 1,271,948).

To reproduce: build main in a second work tree (or copy its
`target/release/quicktype`), then

```sh
cargo xtask bench --baseline ../main/target/release/quicktype
for bin in ../main/target/release/quicktype target/release/quickertype; do
  /usr/bin/time -l $bin rulings-100k.json -l ts -o out.ts
done
```

with `rulings-100k.json` made as in [PROFILE-RECORDS.md](PROFILE-RECORDS.md#reproducing).

## Reading on several threads

A regular file of 8 MiB or more whose top-level value is an array (and
standard input redirected from one) is read on several threads, into the
same tallies as reading it in one go (see
[STREAMING-INFERENCE.md](STREAMING-INFERENCE.md#reading-on-several-threads)).
Output is byte-identical: 260,928 CLI runs against main (2,416 files ×
9 option sets × 12 settings of threads and chunk size), 6,048 on arrays
whose places come to absorb every string partway, 3,024 on arrays full
of URIs (ports, user info, queries, IPv6 hosts), 252 on arrays with a
string of 50 million backslashes, 432 on arrays of elements with keys of
their own, 756 on the large inputs below (all
from a path and from standard input), the differential harness on
200,000 seeds and the `json_split` fuzz target.

**Scaling.** `cargo build --release -p quickertype`, `-l ts -o
/dev/null`; the threads set with `QUICKTYPE_READ_THREADS` (the default is
12, the machine's cores), interleaved with main; medians of 15 runs (11
for 1M records); wall / CPU time in ms (user + system, from `wait4`) and
peak RSS. Main is `e2e3f3fc9` (with JSON Lines and the walk's URI
tallying, which this branch is rebased on). Load average 4.1 to 4.5 on
12 cores.

| Input | Main | 1 thread | 2 | 4 | 8 | 12 (default) |
|---|---:|---:|---:|---:|---:|---:|
| 100k records (26.8 MB) | 30.9 / 29.7, 6.1 MiB | 30.5 / 29.3, 6.0 MiB | 21.1 / 38.5, 8.4 MiB | 14.3 / 40.3, 11.7 MiB | 10.8 / 44.5, 16.0 MiB | **10.5** / 55.7, 19.7 MiB |
| 1M records (267 MB) | 261 / 259, 6.0 MiB | 261 / 259, 6.0 MiB | 142 / 354, 9.8 MiB | 82.3 / 360, 13.4 MiB | 56.3 / 385, 17.8 MiB | **49.9** / 435, 21.2 MiB |
| 1M records, `< file` on standard input | 262 / 260, 6.1 MiB | 261 / 260, 6.0 MiB | | | 56.8 / 385, 17.7 MiB | **50.1** / 439, 21.1 MiB |
| 20k articles, long text (23.4 MB) | 62.5 / 61.1, 19.2 MiB | 62.1 / 60.7, 19.1 MiB | 40.1 / 73.2, 22.9 MiB | 27.2 / 76.6, 26.8 MiB | **21.3** / 85.9, 31.5 MiB | 21.7 / 101, 36.4 MiB |
| 100k records, pretty-printed (30.3 MB) | 33.0 / 31.8, 6.1 MiB | 33.1 / 31.9, 6.0 MiB | 22.7 / 42.3, 8.5 MiB | 14.8 / 44.0, 11.5 MiB | **11.2** / 49.1, 15.8 MiB | 11.3 / 60.8, 20.6 MiB |

The 1M records take 5.2× less wall time on 12 threads and 4.6× less on
8, for 1.5–1.7× the CPU time: the ranges are scanned once before their
parts are tallied (about 4 GB/s per thread, 65 ms of CPU for 267 MB),
each byte is read from the page cache twice, and the efficiency cores
are slower (on the text-heavy and pretty-printed records, 8 threads are
as fast as 12). Reading on every core is the first to slow down when
other work runs: at load average 5 to 8 the builds before the last
review took 57 to 63 ms on the 1M records. Peak RSS grows by 1.25–1.6 MiB per thread: read
buffers, the tallies of the part each thread reads, and the allocator's
per-thread heaps. A pipe (`cat file |`) is read in one go, as before;
JSON Lines are read on several threads too ([below](#json-lines-on-several-threads)).

**Where it starts to pay.** The same records, cut to 2–64 MB, read in one
go (`QUICKTYPE_READ_THREADS=1`) and on 12 threads with every sample split
(`QUICKTYPE_READ_CHUNK=4194304`, which also lifts the 8 MiB threshold;
the ranges are then 256 KiB, and the threads that read as many as get
four each: 2, 4, 8 and 9 up to 9 MB); medians of 15, load average 4.1:

| Size | In one go | Up to 12 threads |
|---|---:|---:|
| 2 MB | 5.8 / 4.9 ms, 6.0 MiB | 5.2 / 6.4 ms, 8.9 MiB |
| 4 MB | 8.8 / 7.6 ms, 6.0 MiB | 6.8 / 10.8 ms, 10.0 MiB |
| 8 MB | 11.8 / 10.9 ms, 6.0 MiB | 6.7 / 18.7 ms, 14.4 MiB |
| 9.4 MB | 13.3 / 12.3 ms, 6.0 MiB | 7.1 / 24.1 ms, 16.4 MiB |
| 16 MB | 20.0 / 18.9 ms, 6.0 MiB | 8.7 / 39.7 ms, 19.2 MiB |
| 32 MB | 35.8 / 34.8 ms, 6.0 MiB | 11.3 / 65.1 ms, 19.8 MiB |
| 64 MB | 67.5 / 66.2 ms, 6.0 MiB | 16.2 / 114.5 ms, 20.3 MiB |

Below 8 MB the threads save at most 2 ms, for 1.3–1.4 times the CPU
time and 3–4 MiB more memory; from 8 MB on they save 43% and more. So
samples under 8 MiB are read in one go.

**Elements with large tallies of their own.** The 2.6 GB input of
[Memory on large inputs](#memory-on-large-inputs) is an array of 60
copies of the 40 MB generated document, each with a map of 209,519
distinct keys: one element's tallies alone take about 45 MB, so tallying
elements beside each other multiplies them. With the default budget for
the parts' trees (the threads that read times the range size, or
32 MiB), the
first element shows that one part's tree would fill it, and the rest is
read in one go, as before. A larger budget (`QUICKTYPE_READ_BUDGET`,
internal) trades that memory for time. Medians of 3, load average 3.1 to
3.6:

| 2.6 GB generated input | Wall | CPU | Peak RSS |
|---|---:|---:|---:|
| Main | 7.25 s | 7.24 s | 63.1 MiB |
| 1 thread | 7.20 s | 7.19 s | 63.1 MiB |
| 2, 4, 8, 12 threads, default budget | 7.16–7.22 s | 7.16–7.22 s | 63.1–64.3 MiB |
| 4 threads, budget 512 MiB | 2.65 s | 11.9 s | 557 MiB |
| 8 threads, budget 1 GiB | 1.87 s | 13.1 s | 921 MiB |
| 12 threads, budget 1 GiB | 1.95 s | 14.7 s | 1,314 MiB |

The budget bounds what the parts given out and not appended yet hold:
their trees as estimated while they are read, and their trees' own
sizes once read, while they wait for the parts before them. A part's
tallies are moved to the reading thread, not copied. Above the 63 MiB
of reading in one go, the peak was 0.84 to 1.22 times the budget. The
first parts are read on the reading thread, as the others are elsewhere,
until they hold 64 KiB of text: their trees give the first ratio of tree
to text the parts given out are estimated by.

**Elements with keys of their own.** Where those first parts' trees are
more than 8 times their text, the rest is read in one go: appending such
trees on the reading thread costs about as much as reading them. 30 MB
arrays, 12 threads, medians of 7, load average 3.3 to 3.6 (the ratio as
the first parts measure it):

| Input | Ratio | Main | On several threads | Now |
|---|---:|---:|---:|---:|
| 1.5M elements, one distinct key each | 27 | 203 / 200 ms, 235 MiB | 226 / 381 ms, 457 MiB | 205 / 211 ms, 239 MiB |
| distinct keys with 35-byte strings | 9.5 | 168 / 166 ms, 359 MiB | 217 / 402 ms, 581 MiB | 170 / 176 ms, 361 MiB |
| records with one distinct key each among shared ones | 4.3 | 149 / 147 ms, 74 MiB | 60.7 / 250 ms, 175 MiB | 60.2 / 245 ms, 183 MiB |

**Arrays that do not split.** An array whose elements are longer than a
part the budget lets be read beside others is read in one go as soon as
the ranges scanned past the last split are that long, without scanning
the rest. The 1M records inside one object, in a one-element array
(267 MB), on 12 threads: 262 / 272 ms against main's 257 / 256 ms
(medians of 7, load average 3.7 to 3.9).

**Long runs of backslashes.** Whether a range's first byte is escaped
comes from the ranges before it where the 64 bytes before it are all
backslashes, so a long run is read once. The 20,000 records with one
string of 50 million backslashes (50.7 MB, an even run, and an odd run
that escapes a quote), on 12 threads, medians of 9, load average 4.1:
95.9 / 110.8 ms and 191 MiB against main's 92.1 / 89.8 ms and 192 MiB
(the string is one token, read on one thread). Looking back from each
range for where the run starts took 130 / 328 ms and 342 MiB (load
average 23).

### JSON Lines on several threads

A JSON Lines file of 8 MiB or more (and standard input redirected from
one) is read on several threads as an array is, split at the line feeds
between its values. The same records as JSON Lines (one compact value
per line) and as a compact array, `-l ts -o /dev/null`, 12 threads (the
default), interleaved with main at `4cf135e28` (which reads JSON Lines in
one go); medians of 11 runs (21 for the smaller inputs, 7 for the
cards); wall / CPU time in ms and peak RSS; load average 4.6 to
5.5, another build running:

| Input | Main, JSON Lines | JSON Lines | JSON Lines, `< file` | Array, wall (main / now) |
|---|---:|---:|---:|---:|
| 100k records (26.7 MB) | 33.0 / 31.7, 6.0 MiB | **11.9** / 59.3, 19.4 MiB | 11.7 / 58.6, 20.3 MiB | 11.3 / 11.1 |
| 1M records (266 MB) | 283 / 282, 6.0 MiB | **53.5** / 474, 21.0 MiB | 54.7 / 472, 21.1 MiB | 53.2 / 52.7 |
| 20k articles, long text (23.4 MB) | 64.3 / 62.8, 19.1 MiB | **23.0** / 104, 36.8 MiB | 23.7 / 105, 37.1 MiB | 22.8 / 22.8 |
| Scryfall cards (real data), 657 MB (`--just-types`) | 1,437 / 1,434, 20.3 MiB | **293** / 1,791, 49.6 MiB | 290 / 1,781, 49.1 MiB | – / 283 |

JSON Lines take what their array takes, within 1 ms on the records and
4% on the cards (whose 49 MiB are the tallies of their parts, read beside
each other). The output is the array's (the cards' is quicktype's for
their array, byte for byte, from the file, from standard input, from a
directory, with a byte order mark first), and a broken line, early or
deep in the cards, is reported on the line reading in one go reports.
Read in one go (one thread, or a pipe), JSON Lines retire the
instructions they did on main, 0.5% fewer (1M records from a pipe:
4.685–4.693 billion, main 4.708–4.712), and arrays the instructions they
did (4.437 billion, main 4.437–4.438).

A stray `{`, `[` or `[[` before the 1M records' lines, an error on line
1 that reading in one go reports at once: 5.4 / 5.3 ms against main's
3.9 / 2.9 (medians of 15, load average 5.3 to 5.6): only the ranges that
start in the first MiB are scanned (`FIRST_LINE_MAX`; 4.1 MiB here), and
the file is read in one go.
Without that bound they were scanned until half the budget (5.6 / 14.9
ms; with a 1 GiB budget, all 266 MB: 17.0 / 119 ms, now 5.8 / 5.6).

## TypeScript input

`quickertype -s typescript file.ts -l rust -o out.rs` against the
TypeScript reference (quicktype with TypeScript 5.9 in Node.js v24.16.0)
and against main at `972d0a9f9`, which this change starts from.
quickertype type-checks the sources with the TypeScript 7.0.2 native
compiler (`tsc --api`) and asks its checker about every declaration,
type and symbol over a pipe ([07-typescript-input.md](research/07-typescript-input.md)).
Every output below is byte-identical to quicktype's.

**Inputs.** Generated files of exported interfaces that refer to each
other:

- *Flat*: 6 to 15 properties each; 500 (0.16 MB), 2,000 (0.62 MB) and
  10,000 interfaces (3.1 MB). The generator meant to mix twelve kinds of
  property, but its random numbers (`seed % k` of a linear congruential
  generator) repeat in short cycles: of the 10,000 interfaces' 102,000
  properties, a third each are `string`, `string[]` and `"red" |
  "green" | "blue"`, and 304 refer to another interface (`TypeN | null`,
  `TypeN[]`).
- *Typings*: shaped like an API's typings. One interface in eleven is a
  base and a third of the others extend one, some bases extend others;
  string-literal type aliases; `X | null`, `X | string`, `X[] | null`,
  `Array<X | null>`, `ReadonlyArray<…>`, object literals, index
  signatures, tuples and `Date`; JSDoc comments, with and without tags
  (`@deprecated`, `@format`); each interface refers to some of the 40
  before it. 1,100 (0.42 MB), 3,300 (1.3 MB) and 11,000 interfaces
  (4.2 MB, 88,000 properties), named by their models: 1,000, 3,000 and
  10,000.

They leave out what quicktype itself fails on (and quickertype with it,
on purpose): generic instantiations (`Page<T>`, `Record<K, V>`,
`Partial<T>`: "Key Page%3CT%3E not in schema object"); unions of two
interfaces spread over the graph (quicktype merges the classes of a
union, and the merges cascade: more than five minutes at 1,000
interfaces, in both); references in no particular order among thousands
of interfaces (typescript-json-schema defines a type when it first meets
it, depth first, so the recursion grows with the graph and Node.js
overflows its stack); and a string `enum` in a union with `null`, two
optional properties of the same string enum in one interface, or two
string enums with the same values ("Internal error: Cannot combine type
attribute accessorNames").

**Requests to the compiler.** Main asks one question at a time and waits
for each answer: 91 round trips per flat interface, 113 per typings
interface. Now the requests go out in a few pipelined batches (the
compiler answers one message at a time, in order), and the generator
then runs on the answers; see the commits for how.

| Input | Main: requests (all round trips) | Now: requests | one at a time | pipelined batches | tsc's own processing, main → now |
|---|---:|---:|---:|---:|---:|
| Flat 500 | 45,480 | 2,645 | 29 | 8 | 272 → 182 ms |
| Flat 2,000 | 181,859 | 10,148 | 29 | 8 | 616 → 287 ms |
| Flat 10,000 | 909,165 | 50,166 | 29 | 8 | 2,558 → 858 ms |
| Typings 1,000 | 123,216 | 27,130 | 29 | 15 | 534 → 299 ms |
| Typings 3,000 | 370,574 | 80,237 | 29 | 15 | 1,346 → 648 ms |
| Typings 10,000 | 1,241,162 | 267,998 | 29 | 15 | 4,304 → 1,957 ms |

The 29 are the session (`initialize`, `updateSnapshot`), the
diagnostics, the file list and ASTs, and a few one-off questions; the
batches are the steps of the walk over the type graph, so neither grows
with the input (the `round_trips_do_not_grow_with_the_input` test keeps
it so). `QUICKTYPE_TSC_STATS=1` prints these counts per method. The
compiler's own processing time was measured with `tsc --api --timing`
and its `getServerTiming` request, which the statistics do not use,
before the walk took in the library types, accessors and type parameters
the generator also walks (3.5% more requests on the typings, 9 more on
the flat input).

**Time.** Best of 3 interleaved runs (quicktype, main, now, one after
the other per input); wall time and peak RSS. Load average 2.7 to 4.3 on
12 cores, with another agent's builds coming and going.

| Input | quicktype | main | now | vs quicktype | vs main |
|---|---:|---:|---:|---:|---:|
| Flat 500 | 1.26 s, 385 MiB | 0.87 s, 151 MiB | **0.40 s**, 120 MiB | 3.1× | 2.2× |
| Flat 2,000 | 2.72 s, 784 MiB | 3.22 s, 204 MiB | **1.22 s**, 177 MiB | 2.2× | 2.6× |
| Flat 10,000 | 16.9 s, 1,923 MiB | 23.0 s, 639 MiB | **5.54 s**, 629 MiB | 3.1× | 4.1× |
| Typings 1,000 | 2.50 s, 705 MiB | 2.30 s, 198 MiB | **1.11 s**, 179 MiB | 2.3× | 2.1× |
| Typings 3,000 | 6.26 s, 1,030 MiB | 6.55 s, 323 MiB | **2.73 s**, 292 MiB | 2.3× | 2.4× |
| Typings 10,000 | 28.4 s, 2,184 MiB | 25.5 s, 781 MiB | **8.41 s**, 778 MiB | 3.4× | 3.0× |

Main was slower than quicktype from 2,000 flat interfaces on, and grew
faster than linearly (×7.1 from 2,000 to 10,000). Two causes besides
the round trips were quadratic: the TypeScript input's JavaScript objects
looked their keys up one by one (the schema's `definitions` hold one per
type), and four steps of the engine, which every input with thousands of
types goes through, JSON Schema in particular. Their times on the
10,000-interface inputs, main → now:

| Phase (`--debug print-times`) | Flat 10,000 | Typings 10,000 |
|---|---:|---:|
| expand strings | 2,367 → 104 ms | 184 → 113 ms |
| render (naming, declarations) | 4,117 → 284 ms | 2,044 → 524 ms |

- *expand strings*: with JSON Schema enums, each restricted string's
  cases became an enum set and were taken out of an `IndexMap` with
  `shift_remove` (moving all later entries), and each string then
  searched every set for an equal one.
- *naming*: the check that an assigned name does not conflict went
  through every named already given the proposed string (`id` is given
  in thousands of classes), and finished namespaces left the queue with
  `shift_remove`.
- *declarations*: one depth-first traversal per root of the declaration
  graph, each with its own visited set, walked what the roots share again
  for each root.

**What is left.** On the flat input the compiler's part is now its
check and its answers (0.9 s at 10,000), and the rest is the engine's
linear phases (reading the schema, 1.2 s; making optional properties
nullable, 0.7 s; resolving intersections, 0.4 s). On the typings, the
compiler's processing (2.0 s at 10,000, about 100,000 of its 258,000
answers are `typeToString`) is most of the TypeScript input's time; the
check alone is 124 ms even for one interface, the libraries included,
as in the reference. A file of one interface converts in 0.16 s.

## Profiling

```sh
cargo build --profile profiling -p quickertype    # release + symbols
samply record target/profiling/quickertype big.json -l ts -o out.ts
target/release/quickertype big.json -l ts -o out.ts --debug print-times
cargo build --profile profiling -p quickertype --bench in_process
samply record target/profiling/deps/in_process-<hash> -n 50 --filter github-events --lang c++
```

`--debug print-times` prints each pass (`read input`, the rewrites, `gather
names`, `render`); reading the samples happens before `read input`, in the
CLI's `make_quicktype_options`.

Where the time goes now:

- **Process start** dominates small inputs: `--version` takes 2.3 ms, and
  starting `/usr/bin/true` the same way takes about 1.9 ms on this machine.
  The rest of a tiny run is mostly writing the output file and building the
  CLI's option tables.
- **Large JSON** (40 MB): reading and parsing the sample ~47%, inference
  ~46% (the union accumulators allocate attribute sets per value, as the
  TypeScript does), everything after that ~7%.
- **Medium JSON, in process**: parsing a third (51 of 153 ms: the
  `JSON.parse` port and `CompressedJSON`), inference ~20%, the rewrites
  ~10%, naming and rendering the rest. SipHash in `IndexMap`/`IndexSet`,
  allocation and `memmove` are the biggest flat costs left.

These were measured before Phase 8a. For a record array after it, with a
comparison of our JSON readers against `serde_json` and `simd-json`, see
[PROFILE-RECORDS.md](PROFILE-RECORDS.md).

### Phase by phase, WebAssembly against native (`trace`)

The `trace` feature of quickertype-core (forwarded by quicktype-wasm)
records how long each phase takes: the reader's two passes over a sample
(`read: record`, which scans, validates and writes the tape, and `read:
commit`, which classifies and interns into the compressed form), every
timed pass of a run (`read input` also split into `read input: tally the
form` and `read input: infer`), and in the engine decoding the request,
assembling the options and turning the outcome into JavaScript values.
Each span goes into a buffer that is allocated once and read out once,
after the work (`quicktype_core::trace::take`; the engine's `__trace()`),
so nothing crosses into JavaScript while a run is timed. The clock is
`performance.now()` in WebAssembly and `Instant` natively. Without the
feature the spans are empty and compile away: the engine the package
ships is the same size and has the same code and exports with or without
the spans in the source (only line numbers in panic messages move), and
has no `__trace` export.

```sh
# WebAssembly in headless Chrome (a cross-origin isolated page, for 5 µs
# timer steps instead of 100 µs): addSource + quicktypeMultiFile to
# TypeScript, warm, medians of each phase. The copy into WebAssembly memory
# and the facade's share are timed around the glue's calls.
(cd npm/quicktype-core && node script/build.mjs --trace)
node npm/quicktype-core/test/bench/phases.mjs [--only REGEX] [--rounds N] [--bytes] [--json]
# The same entry points natively, in process (jsonCreate and jsonRead, then
# a run over a lease on the form), with the same spans; mimalloc.
cargo run --release -p quicktype-wasm --features trace --example phases -- input.json [ROUNDS]
```

`phases.mjs --json` also writes its inputs to
`npm/quicktype-core/build/bench/phases/`, for the native side.

## WebAssembly

The JS API's engine is `crates/quicktype-wasm` behind `npm/quicktype-core`.
Until `feat/wasm-native-json`, the facade parsed every JSON sample in
JavaScript (`JSON.parse` and quicktype's `CompressedJSON`), and each run
converted those tables and copied them into the engine. On large inputs
that made the WebAssembly engine *slower* than TypeScript in the browser.
Since then the engine reads JSON samples itself as they are added (the
package README, "JSON samples"), and the build was tuned step by step.

`node --expose-gc npm/quicktype-core/test/bench/compare.mjs [--browser]
[--cold N] [--variant name=dir ...]` measures `addSource` plus
`quicktypeMultiFile` to TypeScript, every build in one process (or page),
interleaved, on four inputs:

- pokedex (82 KB);
- generated inputs of 2 MB and 20 MB (`test/bench/generate.mjs`, a port of
  this benchmark's generator);
- a 27 MB array of 100k small records, each a UUID, a two-value enum, a date
  and a comment of 8 to 37 words. This is a synthetic version of a public
  card-rulings dump that a user found slower on WebAssembly in the
  playground.

The machine (M2 Max) ran other agents throughout, with a load average
between 150 and 450. Headless Chrome kept getting enough CPU, and its
numbers look like those of an idle machine. Wall-clock times in Node did
not: they vary several-fold from run to run. So Chrome's medians are the
reference here, and the Node tables give CPU time
(`process.cpuUsage`, which also counts V8's GC threads and so overstates
the TypeScript side).

### Warm runs in Chrome, step by step

Medians in ms (×: TypeScript's time over the build's, TypeScript measured
in the same page):

| Build | pokedex | 2 MB | 20 MB | 27 MB records |
|---|---:|---:|---:|---:|
| main (TypeScript parses, tables copied in) | 3.10 (1.42×) | 46.5 (1.03×) | 502 (0.90×) | 195 (0.86×) |
| + the engine reads JSON samples | 2.60 (1.69×) | 25.5 (1.87×) | 244 (1.86×) | 154 (1.09×) |
| + `wasm-opt -O3` | 2.40 (1.83×) | 24.8 (1.92×) | 240 (1.89×) | 150 (1.12×) |
| + reader tweaks: UTF-16 length, date-time check | 2.40 (1.83×) | 24.5 (1.95×) | 237 (1.91×) | 144 (1.17×) |
| TypeScript (same page) | 4.40 | 47.7 | 454 | 169 |
| + reader tweaks: key cache, string kinds | 2.30 (1.91×) | 23.6 (1.99×) | 225 (1.94×) | 131 (1.26×) |
| + geometric memory growth | 2.40 (1.83×) | 24.1 (1.95×) | 230 (1.89×) | 133 (1.24×) |
| TypeScript (same page) | 4.40 | 47.0 | 435 | 165 |
| geometric memory growth, again | 2.30 (2.09×) | 23.6 (1.97×) | 218 (1.92×) | 129 (1.29×) |
| + the code review's fixes | 2.30 (2.09×) | 23.8 (1.96×) | 222 (1.88×) | 131 (1.27×) |
| TypeScript (same page) | 4.80 | 46.6 | 417 | 166 |
| the code review's fixes, again | 2.30 (2.26×) | 23.1 (2.08×) | 214 (1.99×) | 127 (1.31×) |
| + main, the second code review's fixes (the branch) | **2.40 (2.17×)** | **23.7 (2.03×)** | **217 (1.97×)** | **127 (1.31×)** |
| TypeScript (same page) | 5.20 | 48.1 | 426 | 166 |
| main after the merge, again (load 3–4) | 2.40 (2.13×) | 22.8 (1.99×) | 211 (1.91×) | 129 (1.39×) |
| + inference from tallies ([below](#inference-from-tallies-in-the-engine)) | **2.30 (2.22×)** | **16.9 (2.69×)** | **145 (2.78×)** | **65.8 (2.72×)** |
| TypeScript (same page) | 5.10 | 45.4 | 404 | 179 |

Where the branch's time goes: reading against generating, in ms:

| Input | WebAssembly read + generate | TypeScript read + generate |
|---|---:|---:|
| pokedex | 0.60 + 1.80 | 0.80 + 3.60 |
| 2 MB | 10.2 + 13.8 | 22.0 + 24.9 |
| 20 MB | 106 + 124 | 275 + 161 |
| 27 MB records | 57.4 + 75.6 | 85.3 + 79.3 |

In Node the same runs give the following CPU time per run, in ms. The
spread between repeated runs was large at this load (±50% on the big
inputs), so these show the direction, not the size:

| Build | pokedex | 2 MB | 20 MB | 27 MB records |
|---|---:|---:|---:|---:|
| main | 8.9 | 69.7 | 835 | 365 |
| the branch | 6.1 | 39.5 | 337 | 252 |
| TypeScript | 12.7 | 93.5 | 1,444 | 694 |

Build settings measured and **not** adopted. Each was compared with the
same engine with `wasm-opt` in one page; TypeScript was 5.10, 49.1, 476
and 173 ms there:

| Variant | pokedex | 2 MB | 20 MB | 27 MB records | .wasm (gzip -9) |
|---|---:|---:|---:|---:|---:|
| baseline (dlmalloc, opt-level 3) | 2.50 | 24.8 | 239 | 148 | 5.11 MB (1.88) |
| `talc` 5.1 as the global allocator | 2.40 | 24.9 | 239 | 148 | 5.10 MB (1.88) |
| `-C target-feature=+simd128` | 2.40 | 24.8 | 239 | 149 | 5.02 MB (1.86) |
| `opt-level = "s"` for quicktype-wasm | 2.40 | 24.8 | 242 | 148 | 5.11 MB (1.88); 6.51 MB before wasm-opt |

None of them is measurably faster, so none was adopted: no new
dependency, and no change to the browsers the engine supports (SIMD would
raise Safari's floor from 15 to 16.4). wasm32's default target features in
Rust 1.99 already include bulk memory (`memory.copy`/`fill`), sign
extension, non-trapping float-to-int, mutable globals, multi-value and
reference types (`rustc --print cfg --target wasm32-unknown-unknown`).

Module sizes (bytes of `quicktype_wasm_bg.wasm`, gzipped with `-9`):

| Build | Raw | gzip -9 |
|---|---:|---:|
| main | 5,504,199 | 1,820,220 |
| + the engine reads JSON samples | 5,540,170 | 1,836,379 |
| + `wasm-opt -O3` | 5,106,071 | 1,879,156 |
| + geometric memory growth | 5,122,579 | 1,886,059 |
| + the code review's fixes | 5,159,057 | 1,900,523 |
| the branch (main merged, the second code review's fixes) | 5,245,950 | 1,906,815 |

`wasm-opt` makes the module 8% smaller but 2% larger gzipped (inlining).
It is kept for the 2–8% of speed.

### Cold runs, 27 MB records

These are first runs: a fresh browser, or a fresh Node process, each time.
The medians are of 5 (Chrome) or 7 (Node) runs.
- **Chrome.** The page compiles the module first, as the playground's
  worker does when it starts. The run then includes instantiating it, the
  engine's one-time set-up (about 13 ms) and V8 tiering the hot functions
  up from its baseline compiler. main 223 ms (0.90×); the branch 182 ms
  (1.10×); TypeScript 201 ms.
- **Node.** The first run compiles the module, synchronously (so did
  the first JSON sample, until the code review: now only a sample of at
  least 1 Mi code units does; see below).
  - On pokedex this start-up dominates: main 177 ms of CPU, the branch 235,
    TypeScript 70.
  - On the 27 MB records: main 544 ms of CPU, the branch 452, TypeScript 574.

### The code review's fixes

A review of the branch found that a run took its hold on an input's
samples only once it started, which another run could pre-empt; that
every sample's text was kept for the input's lifetime, only to be parsed
again by TypeScript if anything read the input's tables; and that the
first sample compiled the engine in Node even for runs that then went to
the TypeScript engine. Now a run holds its samples from when it is
encoded, the tables are filled from the engine's (whose string table is
TypeScript's), and only a large sample compiles the engine (package
README, "JSON samples").

**Memory**, one 104 MB sample (`generateJson(150000)`: 525,512 distinct
keys, 5.4 M members), read with `addSource` in a Node process whose engine
is instantiated, the caller's copy of the text dropped afterwards;
V8's external memory (the text, the WebAssembly memory) after
`addSource` and the process's peak RSS (`/usr/bin/time -l`):

| | Before | After |
|---|---:|---:|
| After `addSource`: external memory | 611 MB (the text kept) | 562 MB |
| WebAssembly memory | 505 MiB | 560 MiB |
| A run on the engine: peak RSS | 806 MB | 765 MB |
| A run on the TypeScript engine (a custom language): peak RSS | 2,369 MB | 2,059 MB |
| the same: CPU time, wall time | 7.3 s, 5.7 s | 4.3 s, 2.9 s |

The text (104 MB) is no longer held. Filling the tables for the run on
TypeScript copies them from the engine instead of parsing the text
again. The WebAssembly memory is one step of geometric growth higher:
the reader's key table, which no longer shares the string table (keys
are interned when their values are committed, as in TypeScript), adds
about 40 bytes per distinct key while a sample is read (22.5 MiB here,
by a native measurement of the reader's peak: 334.1 MiB before, 356.6
MiB after),
which pushed the memory past a step; it is freed after the sample. On
the 27 MB records' generator at 400k records (107 MB, ten distinct
keys) the WebAssembly memory and the peak are the same before and after
(321 MiB), and 102 MB less is held after `addSource`.

**Runs that go to the TypeScript engine.** Cold, a custom language, in a
fresh Node process, median CPU time of 7 runs (machine load about 30):

| Input | Before | After | TypeScript alone |
|---|---:|---:|---:|
| pokedex | 95.9 ms | 45.5 ms | 47.7 ms |
| 2 MB | 296 ms | 234 ms | 194 ms |
| 27 MB records | 711 ms | 465 ms | 460 ms |

The 2 MB input still compiles the engine (at least 1 Mi code units):
for a run on the engine, which is the common case, reading it there
pays for compiling. Cold runs on the engine, CPU time with the policy
against a build where no sample compiles the engine: 2 MB 258 against
306 ms, 27 MB records 361 against 507 ms.

**Everything else is unchanged** within the noise, before against after
in one page or process (load about 25–30):

| | pokedex | 2 MB | 20 MB | 27 MB records |
|---|---:|---:|---:|---:|
| Chrome, warm (ms) | 2.30 / 2.30 | 23.6 / 23.8 | 218 / 222 | 129 / 131 |
| Node, warm (CPU ms) | 5.80 / 5.99 | 28.9 / 29.2 | 250 / 254 | 183 / 179 |
| Chrome, cold (ms) | 38.5 / 38.6 | 64.8 / 66.1 | 289 / 289 | 182 / 185 |
| Node, cold (CPU ms) | 157 / 155 | 213 / 219 | 559 / 556 | 325 / 333 |

(The Node warm figure for the 27 MB records is of 21 runs; a first run
of 9 gave 160 / 180, within this load's spread.)

### The second code review's fixes

A second review found that the engine's memory could grow without bound
in a long-running process; that a read that ran out of memory left the
engine's table of inputs borrowed, so that the tables of no input could
be taken from the failed instance; that the reader's fallback ignored
its limits; that a full table of runs or inputs counted as a crash; that
wide objects whose keys reappear in nested ones were read in quadratic
time; and that exporting the tables copied the string table twice. Main
(the robustness branch) was merged too: the one-pass reader now fails
past Node's depth for `CompressedJSONFromString.process`, as main's
`process` does. See the package README ("JSON samples", "Memory").

**Memory, input after input.** A Node process makes 200 inputs of a
1 MB sample (`generateJson(1400)`), keeps every one, and runs each once.
With the compressed forms limited to 16 MiB, the engine's memory is
54.6 MiB after the 50th input and still after the 200th (15.7 MiB in
use); without a limit it grew by 2.2 MiB per input, to 539 MiB (438 MiB
in use), and would have reached 4 GiB, where the instance traps, at
about the 1,800th. The default limit is 256 MiB. (In use: the
allocator's count, in a `--heap-stats` build.)

**Filling the tables of a 104 MB sample** (`materialize`, the 138 MiB
form of `generateJson(150000)`): exporting them took 115.0 MiB more of
the engine's memory at its peak, and 65.3 MiB now, by the allocator's
count; the CPU time (1.1 s) and the process's peak RSS (1.35 GB) are the
same.

**Wide objects whose keys reappear in nested ones**
(`{"k0": {"k1": 0, "k2": 1}, "k1": {"k2": 0, "k3": 1}, …}`), read with
`addSourceSync` on the engine, CPU ms (median of 3):

| Members | 2,500 | 5,000 | 10,000 | 20,000 | 40,000 |
|---|---:|---:|---:|---:|---:|
| Before | 11.4 | 40.5 | 150 | 587 | 2,317 |
| After | 3.8 | 2.6 | 3.3 | 8.1 | 13.8 |

Records whose nested objects reuse their keys (200k
`{"id": …, "child": {"id": …, "name": …}, "name": …}`, 18.8 MB) read in
73.5 ms before and 75 ms after (native, best of 15): objects of up to 16
members still compare their keys one by one; a set of keys, made once,
takes over only past that (made for every such record, it took 91 ms).

**Everything else is unchanged** within the noise. Warm, before (the
branch at `bddbf8a67`) against after, with a second copy of the before
build in the same page or process for the spread (load about 3–5):

| | pokedex | 2 MB | 20 MB | 27 MB records |
|---|---:|---:|---:|---:|
| Chrome (ms): before, its copy / after | 2.30, 2.30 / 2.40 | 23.1, 23.8 / 23.7 | 214, 216 / 217 | 127, 127 / 127 |
| Node (ms, CPU ms), 31 runs: before, its copy / after | 2.39, 2.32 / 2.51 | 24.8, 25.3 / 25.3 | 234, 234 / 236 | 140, 140 / 141 |

pokedex again, 151 runs: Chrome 2.20 for all four (before, after and a
copy of each); Node 2.32, 2.32 / 2.36, 2.32. Counting the allocator's
bytes made runs about 2% slower (2 MB 14.4 ms to generate, against 13.8
and 14.0 for two copies of the build without), so it is only in
`--heap-stats` builds. The warm benchmark now lets finalizers run
between runs (`test/bench/workload.mjs`): its loop of awaits never did,
so the engine kept every input the benchmark made (twelve 20 MB inputs,
324 MiB per build), and a build that keeps its forms within a limit paid
for evicting inputs that were already gone.

The module is 87 KB larger (6 KB gzipped), nearly all of it main's
robustness work (5,243,038 bytes after merging it, before these fixes).

### Phase breakdown, 27 MB records

The breakdown is one warm run, marked by timestamps: `encodeRun` is
wrapped, the engine's `onTiming` marks where compute starts and ends, and
the rest is output. Chrome wall time, the earlier native-JSON build, ms:

| Phase | main | branch | TypeScript | native Rust, CPU |
|---|---:|---:|---:|---:|
| (a) read the sample | 94 (`JSON.parse` + `process`) | 78 (copy in + Rust reader) | 83–94 | 39 |
| (b) into the engine (encode tables, copy, decode) | 22.5 | 0.4 | – | – |
| (c) engine compute (inference to rendering) | 73.6 | 73.2 | 75–80 | 75 |
| (d) output back to JavaScript | 0.1 | 0.1 | – | – |

On this input the engine's compute (c) runs as fast as native Rust with
the system allocator, and no faster than V8's JIT runs the TypeScript. A
profile of (c) on WebAssembly shows:
- about 18% in the allocator;
- about 10% in SipHash (std's `RandomState` under `IndexMap`);
- about 30% in the union accumulators' attribute sets: one set per string
  value, combined value by value.

The streaming-inference work replaces those sets with tallies, which
the engine now uses too ([Inference from tallies in the
engine](#inference-from-tallies-in-the-engine): (c) is down to 8.6 ms,
and SipHash is no longer hot). The reading (a) and the boundary (b) are
what this branch changed. In (a), what is left is the copy of the text
into WebAssembly memory (`TextEncoder.encodeInto`, about 12 ms for 27 MB)
and the reader itself.

### Inference from tallies in the engine

The engine keeps each input's samples in the compressed form, because
quicktype's API can ask for a `CompressedJSON`'s tables at any time, and
until this change it inferred types from that form value by value, with
one string-attribute set per value, as TypeScript does. Generating was
therefore only at parity with TypeScript. Now a run makes the tallies of
Phase 8a from the compressed form in one walk over it, then infers from
them ([STREAMING-INFERENCE.md](STREAMING-INFERENCE.md#tallies-of-a-compressed-form));
the tallies are freed when inference ends. Output is byte-identical:
the differential suite (19,078 scenarios, 0 different), `cargo xtask
parity`, the streaming harness on the engine's path (a million seeds, 0
differences; STREAMING-INFERENCE.md, "Testing"),
and every benchmark run below checks that the outputs are the same.

**Choosing the design.** Three were considered:

- (a) tallies made while a sample is read, kept beside the compressed
  form for the runs;
- (b) tallies made from the compressed form when a run starts, freed
  after it;
- (c) only tallies, regenerating the tables when JavaScript asks for them.

(c) cannot be exact. Tallies keep counts, not values, so the tables
could only be regenerated from the sample texts. Those would then have
to be kept for every input, at 1 to 2 bytes per character, where now
only an input's first 4 Mi code units are kept. Between (a) and (b),
measured natively in process (thin LTO, median of 15), reading a text
sample into running tallies costs more than reading it into the
compressed form. (a) needs both at once, so its reading would grow by
more than that difference, and so would its memory at rest. (b) keeps
reading and memory as they are, and its walk is a small part of a run:

| Input | Reading into the compressed form | Reading into running tallies | A run, value by value | A run, from tallies of the form |
|---|---:|---:|---:|---:|
| generated (2 MB) | 6.53 ms | 9.44 ms | 10.9 ms | 5.66 ms |
| 35k records (9.3 MB) | 11.7 ms | 13.9 ms | 22.5 ms | 2.27 ms |
| 100k records (27 MB) | 33.4 ms | 39.2 ms | 63.7 ms | 6.15 ms |
| generated (20 MB) | 67.4 ms | 97.6 ms | 99.5 ms | 43.2 ms |

(a) would only gain where an input is run many times, and would pay for
it in reading and memory on every input, so (b) was chosen. In the walk,
keys and string cases are known by their index in the form's string
table, and bits per tally skip the string-attribute combinations that
cannot change anything. The branch's second commit finds a key or case
in its place's tally through a remembered position instead of a hash
(generating on the 27 MB records: 9.9 → 8.2 ms in Chrome).

**Machine and method.** Apple M2 Max (12 cores, 64 GiB), macOS 26.6.2,
Chrome 157.0.8103.78 (headless), Node.js 24.16.0. `compare.mjs` with
`--variant before=<main at 250f1661f> --variant after=<this branch>`,
TypeScript being quicktype's own engine in the same page or process.
Load average 3 to 4, unlike the busy machine of the earlier
measurements. Medians, ms; reading
(`addSource`) + generating (`quicktypeMultiFile`) = total.

Warm, headless Chrome:

| Input | Before | After | TypeScript | After vs TypeScript, generating |
|---|---:|---:|---:|---:|
| pokedex (82 KB) | 0.60 + 1.80 = 2.40 | 0.50 + 1.70 = 2.30 | 1.40 + 3.80 = 5.10 | 2.2× |
| generated (2 MB) | 10.0 + 12.8 = 22.8 | 9.90 + 7.10 = 16.9 | 22.7 + 22.4 = 45.4 | 3.2× |
| generated (20 MB) | 97.8 + 113 = 211 | 98.7 + 46.9 = 145 | 248 + 155 = 404 | 3.3× |
| 100k records (27 MB) | 57.5 + 71.4 = 129 | 57.0 + 8.60 = 65.8 | 83.3 + 95.8 = 179 | 11× |
| 35k records (9.3 MB) | 19.8 + 25.0 = 44.8 | 19.8 + 3.60 = 23.4 | 27.2 + 28.4 = 55.6 | 7.9× |

The 35k records are the shape and size of the 9.3 MB input of a user's
report from the playground (there, warm in their Chrome: quickertype 18.6
+ 21.7 ms, quicktype 25.0 + 22.3 ms); it is not one of
`compare.mjs`'s inputs (a copy of the script with `generateRulings(35_000)`
as its only input).

Warm, Node, wall time (CPU time of the process in parentheses):

| Input | Before | After | TypeScript |
|---|---:|---:|---:|
| pokedex (82 KB) | 0.61 + 1.84 = 2.44 (3.06) | 0.62 + 1.74 = 2.34 (3.30) | 2.07 + 5.51 = 7.55 (10.0) |
| generated (2 MB) | 11.4 + 14.2 = 25.6 (26.3) | 11.3 + 7.53 = 18.9 (19.7) | 33.7 + 32.8 = 66.9 (96.5) |
| generated (20 MB) | 113 + 122 = 235 (244) | 113 + 52.5 = 166 (168) | 386 + 221 = 610 (809) |
| 100k records (27 MB) | 64.6 + 75.4 = 140 (140) | 64.4 + 9.60 = 74.2 (75.8) | 131 + 106 = 239 (379) |

Cold (the first run in a fresh browser after the page compiled the
module, median of 5; in a fresh Node process, which compiles it, median
of 7, CPU time in parentheses):

| Input | Chrome before | Chrome after | Chrome TypeScript | Node before | Node after | Node TypeScript |
|---|---:|---:|---:|---:|---:|---:|
| pokedex (82 KB) | 4.40 + 34.9 = 39.3 | 4.40 + 35.7 = 39.7 | 2.80 + 22.9 = 25.7 | 3.76 + 47.1 = 50.9 (154) | 3.79 + 47.7 = 51.6 (165) | 3.54 + 24.7 = 28.5 (44.5) |
| generated (2 MB) | 19.5 + 48.1 = 67.1 | 19.3 + 41.9 = 61.3 | 29.3 + 44.2 = 74.3 | 25.4 + 53.6 = 79.1 (216) | 25.5 + 46.8 = 72.3 (198) | 39.5 + 55.0 = 94.0 (169) |
| generated (20 MB) | 135 + 152 = 286 | 135 + 91.2 = 227 | 277 + 198 = 473 | 154 + 176 = 330 (493) | 154 + 107 = 261 (433) | 387 + 241 = 630 (864) |
| 100k records (27 MB) | 78.6 + 104 = 183 | 79.0 + 38.8 = 119 | 88.5 + 105 = 193 | 89.2 + 114 = 203 (330) | 89.4 + 43.8 = 134 (240) | 123 + 118 = 240 (415) |

A first run on pokedex in Node takes more CPU time after. With 21 runs
and a second copy of the before build: 149 and 151 ms before, 159 after,
for the same wall time (50.8 and 50.3 ms, 50.1). The extra is in V8's
background threads, which tier up the module's hot functions. Every
other first run is faster. The module is 13 KB larger: 5,259,102 bytes,
1,911,724 gzipped with `-9`, against 5,245,950 and 1,906,815.

**Memory.** Builds with `--heap-stats`, one input per fresh Node process.
The first column is what the engine holds for the input after
`addSource` (`jsonHeld`), the bytes the memory limit counts. The second
is the most the allocator had in use during a run, above what it had
before the run:

| Input | Held, before / after | A run's peak, before / after |
|---|---:|---:|
| pokedex (82 KB) | 1,676,012 / 1,676,020 bytes | 4.5 / 4.5 MiB |
| generated (2 MB) | 4,064,016 / 4,064,024 bytes | 6.1 / 5.6 MiB |
| generated (20 MB) | 29,165,120 / 29,165,128 bytes | 21.4 / 15.1 MiB |
| 100k records (27 MB) | 11,879,612 / 11,879,620 bytes | 31.6 / 6.2 MiB |

An input holds 8 bytes more: a flag of the string table, padded, which
says whether it holds a text twice (only imported tables can). The
memory limit, eviction and the tables JavaScript gets are unchanged, and
their tests pass. A run needs less: one tally per place instead of an
attribute set per string value and the values of every property. The
WebAssembly memory after the run is the same size (the sample's reading
is the peak).

**Where generating's time goes now.** A build that keeps the module's
function names (`--profile profiling`, `wasm-opt -O3 -g`), the runs of
one input under Node's sampling profiler (V8, as in Chrome), self time:

- 100k records (27 MB): the walk about 77% (`CompressedTally::visit` 41%,
  the walk's loop and keys, inlined into `JsonInput::add_types_sync`,
  30%), the allocator 2.5%, SipHash 1.6%. Before, the attribute sets
  were about 30%, the allocator 18% and SipHash 10% (above).
- generated (20 MB): the walk about 39%; the attributes of each URI value,
  which `Inference.ts` computes from its text as well (`Uri::parse` twice,
  for its kind and for its attributes), about 12%; the allocator 10.5%;
  `expand_strings`' enum overlap search 4.7%; SipHash 4.0%.

**Hashing.** SipHash (std's `RandomState`, under `IndexMap` and
`IndexSet`) is no longer hot. Counted with the string-keyed maps'
inserts, lookups and rehashing, by caller: 3.2% of generating on the
records (2.7% the union accumulators' string cases), 8.1% on the
generated input (4.0% the accumulators' string cases, 2.1%
`expand_strings`' case sets, 1.2% the URI attribute sets, 0.5% other).
The accumulators' cases end up in a `StringTypes`, and the URI
attributes are a public type too, so changing either hasher changes
quicktype-core's Rust API. A swap within private maps (`expand_strings`'
case sets) could save at most 2.1% on the generated input and nothing on
the records, less than the spread of these measurements, so the hasher
was left as it is.

### The tallies review's fixes

A review of inference from tallies in the engine found that errors in
the walk over a compressed form were taken for forms it declines (and
lost), that nothing showed the walk was taken at all, that the walk
repeated the `TallyBuilder`'s handlers and only it skipped absorbed string
attributes by bit, that every run walked the form again though it had not
changed, that the walk allocated arrays sized to the whole form, and that
it recognized the same URI again at every occurrence. All of that is
fixed (STREAMING-INFERENCE.md, "Tallies of a compressed form"); output is
byte-identical: `cargo xtask parity` (11,177 of 11,177), the streaming
harness on every path (300,000 seeds, 0 differences, the walk's tallies
checked to be used), the differential suite (19,078 scenarios, 0
different), and every benchmark below checks that the outputs are the
same. A second review then had every input over a form use the tallies
kept with it, a declined walk kept like tallies, the kept tallies shrunk
to what they hold and sharing the input's lists of samples, each
string's text compared with `"__proto__"` once per walk, and the facade
take up the bytes of all the forms a run used before it evicts; the
numbers below are with those.

**Machine and method.** As above (M2 Max, Chrome 157 headless, Node.js
24.16.0), "before" being main at `84e0f4e0a`, "after" this branch, in one
page or process, interleaved; the machine was shared with other work (load
average 4 to 30), so differences of a millisecond or two are within the
spread. `compare.mjs --again` also runs each input a second time.

**A second run on the same input** (another language, other options:
what the playground does on every change) uses the tallies the first run
kept with the form instead of walking it again. Warm, headless Chrome,
medians of 31, ms; reading + generating = total, then the second run's
generating:

| Input | Before | After | TypeScript |
|---|---:|---:|---:|
| generated (20 MB) | 97.3 + 46.5 = 144; again 45.9 | 97.1 + 49.1 = 146; again **13.6** | 248 + 144 = 393; again 136 |
| 100k records (27 MB) | 54.6 + 8.30 = 62.9; again 7.90 | 54.7 + 8.10 = 62.7; again **1.60** | 81.5 + 84.9 = 167; again 69.4 |

First runs are as before, but for the generated input's, which takes
1.4 to 2.6 ms more to generate (3 to 5%, from run to run of the
benchmark). Measured at each commit of the branch, it comes with the
handlers that reading and the walk now share; no layout of the case
slots tried (from 1,024 slots to a position per string) removed it, nor
did the later fixes (shrinking the kept tallies costs nothing measurable
here: 49.0 against 49.1 ms without it). The records' first run takes
about 0.2 to 0.5 ms less. Cold (a fresh browser after the page
compiled the module, median of 7): generated 133 + 89.4 = 222 before,
131 + 89.6 = 220 after (TypeScript 263 + 192 = 453); records 73.7 + 37.9
= 112 before, 73.4 + 36.4 = 110 after (TypeScript 85.2 + 101 = 188).

Natively (inference over the compressed form of one text sample,
`add_types_sync` repeated, thin LTO, median of 20), the second inference
from kept tallies against walking again: 27 MB records 5.16 -> 1.12 ms,
generated 20 MB 34.3 -> 5.1 ms. The walk is most of inference from a
compressed form.

**Memory.** What the engine holds for an input (`jsonHeld`), after
`addSource` and after a run, which keeps its tallies with the form (the
limit on what the forms hold counts them, and evicting a form frees
them):

| Input | After `addSource`, before / after | After a run, before / after |
|---|---:|---:|
| pokedex (82 KB) | 1,676,020 / 1,676,028 | 1,676,020 / 1,703,851 (+1.7%) |
| generated (2 MB) | 4,064,024 / 4,064,032 | 4,064,024 / 4,934,692 (+21%) |
| generated (20 MB) | 29,165,128 / 29,165,136 | 29,165,128 / 36,349,347 (+25%) |
| 100k records (27 MB) | 11,879,620 / 11,879,628 | 11,879,620 / 12,190,139 (+2.6%) |

A form is 8 bytes larger (the cell for the kept tallies). The generated
inputs keep the most: a place per key of a map of random keys, and many
distinct strings. Kept tallies are shrunk to what they hold (their
nodes, cases and keys had room for up to twice as many): before that,
the generated 20 MB input's took 9,158,205 bytes, 2 MB's 1,241,597, the
records' 416,969 and pokedex's 37,072. Under a 16 MiB limit, 96 inputs of a 1 MB sample, each
run once, leave the engine's memory where they left it before (874
pages), with fewer forms kept (2.63 MiB each with their tallies, 2.19
without).

The walk's own allocations no longer follow the size of the form: it
allocated a class (`__proto__` or not) and a case position per string
of the form and a bit per container on every run; now a flag of the
string table answers the first, 1,024 case slots in the tallies the
second, and the bits grow to the largest index reached. Generated 20 MB
(181,627 strings, 222,715 containers): 1.59 MiB -> 39 KiB; records
(10,681 strings): 108 KiB -> 24 KiB. The peak of a run is unchanged: it
is reached while the types are inferred, after the walk.

**URIs that recur** are recognized once while the walk keeps their kind
and attributes (256 slots by string index); natively, inference over
100k records with two URIs each, from 53 distinct (11.6 MB): 108.6 ->
6.8 ms. The generated inputs' URIs are all distinct, and gain nothing.

**The CLI** shares the handlers, and with them the bits that skip
absorbed string attributes and the case slots (it hashed every case).
`-l ts -o /dev/null`, CPU time (user + system) medians, interleaved,
output identical, at the commit that shares them (load average about
7): the 27 MB records 50.2 -> 46.6 ms (31 runs each), generated 40 MB
206.8 -> 200.8 ms (21 runs each); peak RSS the same (10.5 -> 10.6 MiB,
62.2 -> 61.0 MiB). The branch's last build, at a load of 20 to 30: 59.8
-> 55.9 ms and 214.0 -> 203.5 ms.

The module is 5,264,813 bytes (1,913,611 gzipped with `-9`), 5.7 KB
more.

### Large outputs

An 8-million-line PHP file from the differential fuzzer took 726 s on
WebAssembly, against TypeScript's 126 s and the native CLI's 14 s of CPU.

The time grew faster than linearly with the output, and almost all of it
was spent growing memory:
- Rust's wasm32 allocator (dlmalloc) grows the memory just enough for each
  allocation, 64 KiB at a time.
- Each `memory.grow` costs V8 about 0.5 ms, and 4–5 ms past 2 GiB, plus
  garbage collections for the "external" memory.
- A profile put 24% of the time in `memory.grow` and 22% in V8's GC.

The engine's allocator (`crates/quicktype-wasm/src/allocator.rs`) now
grows the memory by a quarter more whenever an allocation grew it, so it
grows a few dozen times instead of tens of thousands.

| Output | Before | After | TypeScript |
|---|---:|---:|---:|
| 8.0M lines of PHP (the fuzz case), wall | 726 s | 61 s (24 s CPU) | 126 s |
| 5.4M lines of PHP (8,000 classes), CPU | 110 s | 15 s | 83 s |
| 1.35M lines of PHP (2,000 classes), CPU | 6.0 s | 2.5 s | – |

`npm test` renders 540,000 lines of PHP and checks that the memory grew
fewer than 60 times (`__memoryGrowths`). Converting the output back to
JavaScript (`TextDecoder`, then slicing lines) stays under 1% of a run,
even for 490 KB of Java.

### Where the time goes in the browser, phase by phase

The engine already generated code more than ten times faster than
TypeScript in Chrome, so the question was why the whole run was only
about three times faster. Reading the sample is the answer: it races V8's
native `JSON.parse`. This section breaks a warm run down phase by phase,
against the same code run natively, and lists what changed.

**Method.** The `trace` feature ([Profiling](#phase-by-phase-webassembly-against-native-trace))
times the engine's phases. In WebAssembly it uses `performance.now()`
through one import, in a cross-origin isolated page (5 µs steps), and
the trace is read out once after each run. The boundary (copying the
sample in, the facade, decoding the outcome) is timed around the glue's
calls. Natively, the `phases` example calls the same entry points in
process (`jsonCreate`, `jsonRead`, then a run over a lease on the form),
on one thread, with mimalloc.

The tables give medians in ms. Chrome 157 ran headless on the M2 Max, at
a load average of 4 to 20 for the first table and 11 to 20 for the
second; the machine was shared. Native and WebAssembly outputs are
identical.

**Before any change** (`a07ef1cb4`, the trace added to main). Native ms,
WebAssembly ms and their ratio:

| Phase | pokedex (82 KB) | generated 2 MB | generated 20 MB | 100k records (27 MB) |
|---|---|---|---|---|
| copy the text in (`TextEncoder.encodeInto`) | – / 0.115 | – / 0.93 | – / 8.9 | – / **12.0** |
| read: record (scan, validate, tape) | 0.098 / 0.150 (1.5×) | 3.13 / 4.66 (1.5×) | 32.3 / 44.4 (1.4×) | 16.3 / 18.7 (1.15×) |
| read: commit (classify, intern) | 0.114 / 0.185 (1.6×) | 2.78 / 4.68 (1.7×) | 30.0 / 45.4 (1.5×) | 12.0 / **21.4 (1.8×)** |
| the facade around the read | – / 0.055 | – / 0.08 | – / 0.10 | – / 0.10 |
| run: tally the compressed form | 0.121 / 0.240 (2.0×) | 2.37 / 3.75 (1.6×) | 24.8 / 35.5 (1.4×) | 4.10 / 6.09 (1.5×) |
| run: infer from the tallies | 0.074 / 0.165 (2.2×) | 0.72 / 1.17 (1.6×) | 4.53 / 6.42 (1.4×) | 0.02 / 0.03 |
| run: the rewrite passes | 0.121 / 0.330 (2.7×) | 0.91 / 1.30 (1.4×) | 4.68 / 5.91 (1.3×) | 0.05 / 0.09 |
| run: gather names | 0.021 / 0.075 (3.5×) | 0.05 / 0.10 | 0.06 / 0.11 | 0.01 / 0.03 |
| run: render | 0.158 / 0.405 (2.6×) | 0.27 / 0.56 (2.0×) | 0.30 / 0.54 (1.8×) | 0.12 / 0.19 (1.6×) |
| run: the facade, encoding and decoding the request, assembling | – / 0.125 | – / 0.175 | – / 0.235 | – / 0.22 |
| the outcome back to JavaScript | – / 0.08 | – / 0.10 | – / 0.13 | – / 0.095 |
| **total** | 0.72 / 1.99 (2.8×) | 10.3 / 17.7 (1.7×) | 97.6 / 148 (1.5×) | 32.5 / 59.0 (1.8×) |

What this shows:

- **Copying the text in** has no native counterpart. On the records it is
  a fifth of the run. `TextEncoder.encodeInto` turns a Latin-1 string
  into UTF-8 at about 2.2 GB/s, and a two-byte string (any non-Latin-1
  character: pokedex has ♀ and ♂) at about 0.7 GB/s. The glue encodes
  into a buffer of the string's UTF-16 length, and only if the UTF-8 does
  not fit there does it reallocate, for the rest that did not fit, at 3
  bytes per unit: a few hundred kilobytes for 100 MB of mostly ASCII text,
  so the copy takes about the text's UTF-8 length in memory. Chrome offers
  no faster way to get a string into WebAssembly memory. A sample's bytes
  skip the encoding (below), which saves its time, not memory.
- **The engine's own phases run at 1.2–1.8× native** on 2 MB and up,
  which is ordinary for WebAssembly. `rustc --print cfg --target
  wasm32-unknown-unknown` (1.99) gives bulk memory, multi-value, mutable
  globals, non-trapping float-to-int, reference types and sign extension,
  but not simd128.
- **The commit on the records is the outlier, at 1.8×**, because of
  `is_uuid`: 9% of the read in Chrome's profile, about 50 ns per UUID. It
  checked each hex digit with a branch on whether the digit is a decimal
  one or a letter. V8 keeps that branch, and on random digits it is
  mispredicted about half the time.
- **64-bit hashing.** foldhash's folded multiply (64 × 64 → 128 bits) has
  no WebAssembly instruction: it becomes four `i64.mul`, shifts and a call
  to `__ashlti3`. `FoldHasher::write_str` is 7.1% of reading the
  generated 20 MB input in the profile. It is not changed here.
- **Small inputs are 2–3.5× native per phase**, for two reasons. First,
  V8 tiers code up from Liftoff to TurboFan only once it has run enough:
  with `--no-wasm-dynamic-tiering`, which compiles everything with
  TurboFan, a tiny input's warm run goes from 0.49 to 0.38 ms and
  pokedex's from 2.04 to 1.77 ms. Second, the allocator: dlmalloc is
  16% of a pokedex run's profile, and natively the system allocator alone
  makes pokedex take 0.96 instead of 0.72 ms. The boundary adds about
  0.25 ms per run: the facade around the read (0.05), the `Run`, the
  request encoded and decoded (0.12–0.16), and the outcome (0.06–0.08).

**Real data, large.** A JSON array of 120,095 card records from
Scryfall's bulk data (656 MB, two-byte text) and its first 18,300,
45,700 and 82,300 records (100, 250 and 450 MB). The samples are strings,
5 rounds each, interleaved over two cycles; the ranges are of the two
cycles:

| Phase | 100 MB native / WASM | 250 MB native / WASM | 450 MB native / WASM |
|---|---|---|---|
| copy the text in | – / 136–138 | – / 336–338 | – / 616–619 |
| read: record | 80–84 / 118 (1.4×) | 202 / 288 (1.4×) | 368–430 / 520–522 (1.3×) |
| read: commit | 141–149 / 206–217 (1.5×) | 448–457 / 741–760 (1.7×) | 679–913 / 1,124–1,142 (1.4×) |
| run: tally the compressed form | 293–306 / 473–474 (1.6×) | 704–716 / 1,188–1,194 (1.7×) | 1,321–1,673 / 2,117–2,139 (1.4×) |
| run: everything else (inference, rewrites, naming, rendering, the boundary) | 9.4–9.6 / 14.6–14.8 | 15.0–15.3 / 22.4–22.9 | 21.2–24.0 / 29.9 |
| **total** | 524–550 / 951–974 (1.8×) | 1,370–1,396 / 2,582–2,611 (1.9×) | 2,399–3,048 / 4,630–4,684 (1.7×) |
| WebAssembly memory afterwards (its high-water mark) | 505 MiB | 1,326 MiB | 2,422 MiB |

On this data, walking the compressed form into tallies is the largest
single phase, natively too: 56% of the native run at 100 MB, against 4 ms
on the synthetic records. Every card has about ten distinct URIs and a
lot of distinct text. That walk is in `input/tallies.rs`, which other
work is changing, so it is not touched here. At 450 MB, the facade around
the read took 240–249 ms. That was eviction: the previous round's input
was unreachable but not finalized yet, so its form still counted toward
the 256 MiB limit and its tables were copied out (see the last commit
below).

For reference, the parallel-read branch's CLI reads the same files with
its own reader (the stream reader into running tallies, a different
path), `-l ts`. On 12 threads: 90 ms at 100 MB, 180–270 ms at 250 MB,
300–730 ms at 450 MB and 1,010–1,070 ms at 656 MB of wall time, with a
peak RSS of 40–56 MiB. On one thread: 410–450, 1,010–1,870, 1,800–6,030
and 4,720–5,110 ms. The machine's load spiked during the larger runs.

**What changed**, each commit measured against the one before it in the
same page, interleaved:

| Commit | What | WebAssembly (Chrome) | Native |
|---|---|---|---|
| `5b92430ce` | `is_uuid` checks the 32 hex digits as four 64-bit words, without a branch per byte | records: commit 20.8–21.1 → 16.9–17.1, reading 53.6–60.3 → 48.9–49.5; generated 20 MB: reading 102–121 → 99–105; others within 0.2 | records: commit 11.6–12.0 → 10.9–11.4; others unchanged |
| `f4abcbeca` | JSON samples as bytes (`Uint8Array`, `Buffer`) for the npm API, which the engine reads as they are (`jsonReadBytes`) | records: copying in 12.4 → 0.6 ms plus a 1.8 ms UTF-8 check, the run 56.9–57.7 → 48.0–48.1; 20 MB: copying in 9.3 → 0.4 + 1.3; cards 934 → 811 (100 MB), 2,537 → 2,202 (250 MB), 4,622 → 4,087 (450 MB); 656 MB, too large for a string, reads in 6.4 s | – |
| `90528c5df` | the playground reads a file's bytes for quickertype (`arrayBuffer()` instead of `file.text()`) | getting the file: 169 → 56 ms (100 MB), 365 → 115, 556 → 275; then the bytes as above on every run | – |
| `1142b0416` | the playground reuses the input it read for the next run on it read the same way, on both engines | a change of language: records 56 → 0.5 ms (quicktype 177 → 79), 20 MB 157 → 14.3 (442 → 177), pokedex 2.2 → 1.1 (5.1 → 2.3) | – |
| `84726429e` | the playground lets go of an input it will not use again at once (`releaseJSONInput`, not public), so a large one is never evicted | no eviction when a reading option changes on a large file (230–340 ms at 450–656 MB before) | – |
| `83eecde16` | the run reads its clock only when a pass's time is reported (`onTiming`, `--debug print-times`): about 30 calls into JavaScript per run fewer | tiny input, 4,000 runs in a row: 148.1 → 143.9 µs (−3%); pokedex unchanged | nothing measurable |
| `4445a64ca` | a run's random type names are seeded when the first is drawn, not at the start of every run (624 steps of the Mersenne Twister) | tiny: 139.9 → 136.1 µs (−3%); pokedex 1,538 → 1,516 µs, within the noise | tiny 35.6–39.6 → 33.5–38.2 µs |
| `5f4b9b36c` | when the forms are past their limit, those whose `CompressedJSON` was collected already (a `WeakRef`) are dropped instead of exported | 450 MB cards, a loop whose rounds are functions of their own, `gc()` after a task boundary: 7 evicted → 7 dropped; the facade around the read 240.6 → 18.2 ms, reading 2,482 → 2,212 ms. In the phases tool's own loop nothing changes: the previous round's input is still reachable from the loop's frame | – |

Tried and not adopted:

- **simd128**, the flag alone (`-C target-feature=+simd128`, wasm-opt
  `--enable-simd`), against the branch in one page. Pokedex 2.20 → 2.20
  ms, 2 MB 17.5–17.7 → 17.4–17.6, 20 MB 151–153 → 149–152, records
  55.5–56.1 → 55.1–55.3: under 2%. The module is 79 KB smaller
  (5,449,071 → 5,369,935 bytes; 1,935,603 → 1,906,451 gzipped). It would
  raise the browsers the engine needs to Safari 16.4 (from 15), Chrome 91
  and Firefox 89. A hand-written SIMD string scan might save 3–5 ms on the
  records, where the string scan is about 17% of the read. It would need
  unsafe code or a 16-lane constructor in the reader, which is kept free
  of unsafe code.
- **Counting UTF-16 units eight bytes at a time** (`utf16::len`, 2.7% of
  the records' read): nothing measurable, natively or in Chrome.

**The full 656 MB file**, through bytes in Chrome: 6,371 ms. Reading
takes 3,189 ms: copying in 14, the UTF-8 check 50, record 771, commit
2,007. The run takes 3,185 ms, 3,156 of them walking the form. The
WebAssembly memory peaks at 2,468 MiB of its 4 GiB. Natively, in
process, under a load spike: 6.2 s (read 3,192, run 3,040).

**What is left, and why:**

- Copying a string sample in (12 ms of the records' 48–56): only bytes
  avoid it, and the npm API takes strings from most callers.
- The walk over the compressed form on real data (56% of a native run on
  the cards): `input/tallies.rs`, changing elsewhere. Since done: see
  [Cards: URIs, the walk and the read's memory](#cards-uris-the-walk-and-the-reads-memory).
- 64-bit hashing and the allocator, and the other fixed costs of small
  runs, are being worked on separately.
- V8's tiering: 13–22% of a small warm run is code still in Liftoff, and
  a page cannot ask for TurboFan.
- TypeScript's own `initTypeNames()`, which `Run.preRun()` calls before a
  run is handed to the engine, seeds TypeScript's Mersenne Twister on
  every run. It is about 8% of a tiny run in a profile of 20,000 of them.
  Making it lazy means changing `attributes/TypeNames.ts`, an upstream
  file the package otherwise keeps unchanged.
- The engine's phases at 1.2–1.8× native, which is what WebAssembly
  costs.

**Reading on several workers** (the parallel-read branch's approach in
the browser, not built). On the 100k records, reading (record + commit,
38 ms of the 48) would split across workers, each reading its part of
the bytes into tallies. Natively the branch reads them 3× faster on 12
threads (31 → 10 ms) and 2.3× on 4. In the browser each worker needs its
own engine instance: about 1 ms to instantiate from the shared module,
and a first run of some 30 ms while V8 compiles what it uses, paid once
per worker. Each worker also needs its part of the bytes (a transfer, or
a `SharedArrayBuffer` in a cross-origin isolated page), and the tallies
have to be merged. With 4 workers, the records' run would take about
20–25 ms instead of 48. On the 656 MB cards, the branch's CLI takes 1.0 s
on 12 threads against 5 s on one. Reading into tallies directly, without
the compressed form and its walk, would also keep each worker's memory
small, against 2.5 GiB in one instance now. But the JavaScript API must
still be able to give the `CompressedJSON`'s tables, which tallies alone
cannot. A browser run at about 1.5× native would then take 1.5–2 s
instead of 6.4 s.

To reproduce:

```sh
(cd npm/quicktype-core && node script/build.mjs --trace)
node npm/quicktype-core/test/bench/phases.mjs              # WebAssembly, string samples
node npm/quicktype-core/test/bench/phases.mjs --bytes      # the same samples as bytes
node npm/quicktype-core/test/bench/phases.mjs --json       # also writes the inputs to build/bench/phases/
cargo run --release -p quicktype-wasm --features trace --example phases -- npm/quicktype-core/build/bench/phases/input4.json
(cd npm/quicktype-core && node script/build.mjs)           # back to a normal build
node --expose-gc npm/quicktype-core/test/bench/compare.mjs --browser --again --variant main=<main's package> --variant branch=npm/quicktype-core
```

### Small blocks from slabs

On small inputs, the engine took 2–3.5 times as long as native code in
each phase (pokedex: 1.99 ms in Chrome against 0.72 ms natively). On large
inputs the ratio was the usual 1.2–1.6. A profile of pokedex put about a
sixth of the time in dlmalloc (`malloc`, `free`, `insert_large_chunk`,
`unlink_chunk`). The allocator matters natively too: with the system
allocator instead of mimalloc, pokedex takes 33% longer.

A run makes many small allocations. Pokedex makes 14,500 allocations and
1,300 reallocations; 98% of the allocations are 256 bytes or less, and 47%
are 8 bytes or less. The 2 MB input makes 82,000, and 89% of them are 32
bytes or less. dlmalloc merges each freed chunk with its free neighbours
and files the result in a bin (sorted trees from 256 bytes up), and the
next allocation takes it apart again.

The engine's allocator (`crates/quicktype-wasm/src/allocator.rs`) now
takes blocks of up to 256 bytes from slabs. A slab is 16 KiB from dlmalloc,
aligned to 16 KiB and cut into blocks of one size, a multiple of 8. A freed
block goes on its slab's free list, and the next allocation of that size
takes it from there. When a size's current slab fills up, the fullest of
the next 8 on its list takes over. New blocks then go where blocks are
already in use, and the emptier slabs can drain. A full slab goes back on
the list once an eighth of its blocks are free. An empty slab goes to a
pool that every size takes from, unless it is its size's last slab. When a
slab goes to the pool, a size whose last slab is empty and higher takes it
instead. The pool keeps the 32 lowest-addressed slabs and gives the rest
back to dlmalloc. Larger blocks still go to dlmalloc, and a reallocation
between two sizes above 256 bytes is dlmalloc's own, so it can grow in
place.

Warm runs in Chrome, two builds (`--trace`) interleaved in one
cross-origin isolated page. Each figure is a median of 61 runs (21 for 2
MB, 11 for 20 MB and the records), in ms, with the range over two pages:

| Input | dlmalloc | Slabs | Change |
|---|---:|---:|---:|
| tiny, `{"a":1}` | 0.55–0.73 | 0.53–0.71 | −3 to −4% |
| kitchen-sink (1 KB) | 1.29–1.47 | 1.12–1.31 | −11 to −13% |
| spotify-album (3.5 KB) | 1.45–1.65 | 1.29–1.47 | −11% |
| pokedex (82 KB) | 1.96–2.20 | 1.76–1.98 | −10% |
| github-events (82 KB) | 5.14–5.48 | 4.29–4.59 | −16 to −17% |
| reddit (133 KB) | 2.78–2.99 | 2.40–2.60 | −13 to −14% |
| us-senators (155 KB) | 3.14–3.32 | 2.76–2.95 | −11 to −12% |
| generated (2 MB) | 17.6–18.6 | 16.9–17.8 | −4% |
| generated (20 MB) | 157–168 | 153–164 | −2% |
| 27 MB records | 61.0–61.5 | 61.0–61.2 | −1 to 0% |

The second page ran on a busier machine (each build some 10% slower), so
the changes, measured within each page, say more than the ranges.

The gain is in the passes after reading. Reading allocates little. Pokedex,
phase by phase, in ms, against native code (mimalloc):

| Phase | dlmalloc | Slabs | Native |
|---|---:|---:|---:|
| read: record + commit | 0.335–0.355 | 0.340–0.345 | 0.216 |
| tally the form | 0.235–0.245 | 0.225–0.240 | 0.135 |
| infer | 0.155–0.165 | 0.125–0.140 | 0.073 |
| rewrites | 0.305–0.335 | 0.260–0.285 | 0.125 |
| gather names | 0.070–0.080 | 0.065–0.075 | 0.023 |
| render | 0.380–0.400 | 0.305–0.330 | 0.158 |
| rest of the run (mostly dropping the type graph) | 0.045 | 0.015–0.020 | – |

On github-events, the rewrites took 1.315–1.375 ms against 1.130–1.175 ms,
gather names 0.700–0.720 against 0.570–0.585, and render 1.465–1.505
against 1.155–1.185.

Whole runs, release builds, TypeScript in the same page (`compare.mjs
--browser`, whose timer has 100 µs steps; two pages):

| Input | dlmalloc | Slabs | TypeScript |
|---|---:|---:|---:|
| pokedex | 2.20–2.30 | 2.00 | 5.00–5.20 |
| generated (2 MB) | 17.6–17.8 | 16.7–16.8 | 47.0–47.9 |
| generated (20 MB) | 153–159 | 150–155 | 429–439 |
| 27 MB records | 59.7–60.3 | 59.6–60.1 | 173–179 |

**Memory.** The engine keeps forms and tallies between runs, and its
memory never shrinks. An allocator that holds on to memory, or scatters
what it keeps, makes the memory grow over a session. Each test made 200
consecutive runs over a seeded mix of the inputs above. Of every 32 runs,
about 28 were on the seven small samples, 2 on the 2 MB input and 1 each on
the 20 MB input and the records. The test either kept no input alive
between runs or kept the last four (their forms and tallies stay in the
engine). It recorded the pages after every run, and each build had its own
instance in the same page.

| Build | High-water against dlmalloc | Highest |
|---|---|---:|
| dlmalloc | 1 | 3,361 pages (210 MiB) |
| Slabs (16 pairs) | 0.90–1.00, median 1.00 | 3,341 pages (209 MiB) |
| The first slab allocator: 64 KiB slabs, no last slab kept, the next slab on the list (16 pairs) | 0.72–1.36, median 1.00 | 3,763 pages (235 MiB) |
| Free lists in front of dlmalloc (dropped, below; 8 pairs) | 1.00–1.69, median 1.5 | 4,041 pages (253 MiB) |

The 16 pairs are 4 seeds, with no inputs or 4 kept, for builds with and
without `--trace`.

The figures jump because the memory grows by a quarter at a time (see
[Large outputs](#large-outputs)), and a small change in layout decides
whether one more step is taken. With dlmalloc alone, a build with
`--heap-stats` ended 1.32 times as high as a build without it on one
sequence. Between runs, the slabs held 1.0–1.5 MiB (64–96 slabs). Blocks
of 8 bytes take 8 bytes in a slab, against 16 in dlmalloc.

After the first run, on `{"a":1}`, dlmalloc and the slabs both hold 509
pages (the first slab allocator, with 64 KiB slabs, held 512). The run uses
27 of the 32 sizes, and each size takes a slab the first time: 432 KiB of
slabs for 1.6 KB of blocks still in use, against 1.7 MiB with 64 KiB slabs.

The module grows by 15,181 bytes, from 5,448,495 to 5,463,676. Compressed,
it is about the same size: 1,935,299 to 1,935,279 bytes with `gzip -9`, and
1,272,256 to 1,273,774 with `brotli -q 11`.

**Three patterns, measured alone.** These are loops built into test
engines (not the shipped one), timed from JavaScript, medians of 9 rounds
over two pages, in ms. "Second" is the version before the last round of
review (8124780f9):

| Loop | dlmalloc | Second | Slabs |
|---|---:|---:|---:|
| allocate and free one 232-byte block, 1,000,000 times | 7.0 | 4.1–4.3 | 4.1–4.3 |
| the same, 248 bytes | 21.9–22.5 | 4.2 | 4.2 |
| the same, 40 bytes | 10.3 | 4.0–4.1 | 4.1 |
| grow a `String` to 4,096 bytes and a `Vec<u32>` to 1,024, 2,000 times | 7.5–7.6 | 7.1 | 7.1 |
| the same to 256 bytes, 20,000 times | 7.8 | 6.6 | 6.6 |
| the same to 32 bytes, 50,000 times | 4.6 | 3.9 | 3.9 |
| free every 255th of 102,000 boxes of 64 bytes and allocate as many again, 200 times | 2.5 | 3.6–3.7 | 2.5 |
| the same, every 16th, 20 times | 3.7 | 2.0 | 2.0 |

The first slab allocator (64 KiB slabs) gave a size's last slab to the
pool as soon as it was empty. Allocating and freeing one block over and
over then took both slow paths every time, 14.9–18.9 ms a million, and the
slab came back with a new header each time. A size now keeps its last
slab.

Growing a string reallocates it at every doubling. Up to 256 bytes, each
step is a new block and a copy, and the step past 256 bytes moves the
string to dlmalloc. At 4 KB that costs about what dlmalloc's own
reallocation does (7.1 ms against 6.8–7.6 over two rounds of builds), and
it is cheaper below.

In the second version, a full slab went back on its list as soon as one
block was freed, and the fullest slab went next. Dropping every 255th
element (one block a slab) then sent every allocation down the slow path:
the slab chosen had one block free and filled at once. A full slab now
waits until an eighth of it is free. Two other ways were measured and
dropped. Choosing the fullest slab with an eighth free (and so leaving
the full ones on the list) did not help (3.7 ms), since every slab had
one block free. And checking the threshold on the free path, rather than
in the function the free path calls for full slabs anyway, cost about 5%
on growing strings.

The slab logic also builds for the host, where its tests run over the
host's allocator (`cargo test -p quicktype-wasm`). The tests cover pool
overflow, reallocation across sizes and to and from dlmalloc, an empty
slab serving another size, a full slab coming back with an eighth free,
an empty last slab exchanged for a lower one going to the pool, and 30,000
random allocations, frees and reallocations checked against a model.

Tried and dropped:

- **Free lists in front of dlmalloc**, one per size up to 256 bytes,
  carved from 64 KiB blocks and never given back. This was as fast as the
  slabs, but a block freed at one size could serve no other, and over 200
  mixed runs the memory grew up to 1.69 times as far.
- **Taking another size's empty last slab** when the pool is empty, before
  asking dlmalloc. After a tiny run that held 22 slabs instead of 27 (80
  KiB less). But two sizes used in turn with the pool empty would take each
  other's slab on every allocation, each time through the slow path.
- **64 KiB slabs** with the second version's rules (a size keeps its last
  slab, the fullest of the next 8 goes next). They were as fast, but held
  1.7 MiB after a tiny run, and over 200 runs (8 pairs, builds with
  `--trace`) ended 0.84–1.37 times as high as dlmalloc. The first slab
  allocator, also with 64 KiB slabs, ranged 0.72–1.36 (the table above).
- **Other limits for small blocks**: 128, 512 and 1,024 bytes were within
  1–2% of 256.
- **Other pools**: no pool at all, or 16 empty slabs taken last in, first
  out. They were as fast, and no better on memory.
- **talc 5.1** (`WasmDynamicTalc`, under the same growing ahead). It was
  no faster on small inputs, as it had been no faster on large ones: pokedex
  2.21 ms against dlmalloc's 2.20, github-events 5.55 against 5.47.
- **rlsf 0.2** (TLSF, `GlobalTlsf`): 5–9% slower than dlmalloc (pokedex
  2.32 ms, github-events 5.94).

**What is left.** A profile of github-events (an unoptimized build with
names) shows where the rest of the time goes.

- **Render** takes a quarter of the run. Allocating, growing and dropping
  values take 23% of it, `String::clone` 5% and `Serializer::serialize` 8%. The UTF-16
  conversions (`units_to_string`, `utf16_string_escape`,
  `utf16_legalize_characters`) take 9%, and hashing 5%.
- **Gather names** takes 13% of the run. SipHash (std's `RandomState`)
  takes 17% of that, mostly for `IndexSet<String>` inserts. Rehashing
  sets as they grow takes 8%, and cloning sets and strings 10%.
- **The rewrites**: SipHash takes about 17%, `sorted_property_refs` 7%, and
  `compare_utf16` 4%.
- **Naming** (`assign_names`): `String::clone` takes 11%, cloning
  `IndexMap<String, ()>` 5%, and formatting 9%.
- **The facade** seeds a Mersenne Twister for every run (`initTypeNames`
  in `preRun`, through `Chance`), which takes 1% of a pokedex run.

**Stack segments.** On WebAssembly, every outermost call of
`support::recursion::guard` or `grow_stack` allocates a 4 MiB stack
segment from the heap and frees it afterwards. stacker cannot know where
the main stack ends on `wasm32-unknown-unknown`, so outside a segment it
always grows. A tiny run allocates 10 segments, pokedex 52 and the 2 MB
input 79. A build that skips the segment while the main 16 MiB stack has
room was no faster. It did start smaller: 342 pages after the first run,
against 509.

### Tiering and V8's code cache

A warm small run still spends part of its time in code that V8 has not
optimized. V8 compiles each function with its baseline compiler (Liftoff)
on the first call. It compiles the function again with its optimizing
compiler (TurboFan) once the function has used up a budget of executed
code (`--wasm-tiering-budget`, 13,000,000 in Node 24's V8). A function that
a run calls only a few times stays on Liftoff for many runs. With
`--no-wasm-dynamic-tiering`, which optimizes everything, tiny went from
0.49 to 0.38 ms and pokedex from 2.04 to 1.77 ms. That is 13–22% of a warm
small run.

The test used headless Chrome 157 and two launches of one browser
profile. Each launch loaded a page that compiled the engine with
`compileStreaming` from a cacheable response (`Cache-Control: immutable`
and an ETag). The page ran tiny and pokedex 30 times each, then stayed
idle for 5 s. V8's trace events (CDP tracing, categories `v8.wasm` and
`disabled-by-default-v8.wasm.detailed`) show what V8 compiled and cached.

- **The HTTP cache helps.** The second launch read the module from the
  HTTP cache, and compiling took 21–27 ms against 29–63 ms on the first.
  The site already compiles with `compileStreaming` from a content-hashed
  file name, so returning visitors get this.
- **V8's code cache was never written.** Chrome caches the TurboFan code of
  modules compiled with `compileStreaming` (128 KB or more), keyed by their
  URL. In these sessions V8 compiled 788 functions with Liftoff, ran about
  95 TurboFan jobs, and serialized nothing. V8 writes the cache in two
  cases: when a megabyte of TurboFan code has accumulated
  (`--wasm-caching-hard-threshold`), or when it compiles TurboFan code again
  after 2 s without any (`--wasm-caching-timeout-ms`). One burst of small
  runs meets neither condition. A later run meets the second only if it
  gets more functions optimized.
- **Forcing the cache does not help.** With `--wasm-caching-timeout-ms=0`,
  V8 serialized the module 52 times (32 MB on disk), and the second launch
  deserialized it (`wasm.Deserialize`). Even so, the second launch again
  compiled 788 functions with Liftoff and ran about 95 TurboFan jobs, and
  its runs took as long: in both launches, runs 2 to 12 took 0.4–1.0 ms on
  tiny and 2.0–2.7 ms on pokedex.
- **The page controls nothing else.** Eager optimization
  (`--no-wasm-dynamic-tiering`), the tiering budget and compilation hints
  (`--experimental-wasm-compilation-hints`, off by default) are V8 flags.
  What helps is what the site and the facade already do: keep one
  instance for the whole session. When an instance traps, the facade
  replaces it with a new instance of the same compiled module, which shares
  the code V8 has already optimized.

The first run on a fresh page (tiny) took 16–17 ms in either launch, and
the first pokedex run after it 22–24 ms. Most of that is the engine's
one-time set-up (about 13 ms; see [Cold runs](#cold-runs-27-mb-records))
and compiling, with Liftoff, the functions that a run calls for the first
time. Warm-up runs would hide this cost, but they are not used: the site
compares engines, and warming only one of them would not be fair.

### Hash seeds in WebAssembly

The keys of the engine's hash maps come from the input, so their seed has
to be secret. With a known seed, someone can write JSON whose keys all
land in one bucket, and reading it then takes quadratic time.

Natively, the seeds come from the operating system: foldhash uses address
space layout randomization and the clock, and SipHash uses the system's
random source. `wasm32-unknown-unknown` has neither. There, foldhash's
seed is computed from addresses that are the same in every instance; a
module that hashed `"abc"` gave the same value in every fresh Node
process. `std`'s `RandomState` (SipHash) has the same problem: it builds
its keys from the address of a stack byte and of a fresh `Box`.

Now the engine's maps take their seed from the JavaScript host, with
quickertype-core's `js-host-random` feature, which the bindings turn on:
- The entropy is 16 bytes from `crypto.getRandomValues`, taken once,
  when the first map is made. `fast_hash` turns it into foldhash's shared
  seed and the start of a sequence, which gives each map its own seed.
- The bindings take it earlier, when the module starts
  (`#[wasm_bindgen(start)]`, which calls `fast_hash::init()`). On a host
  without `crypto.getRandomValues` the start fails with an error that
  names it (or, if it throws, says what it threw), and the facade runs on
  TypeScript instead (or throws that error, with the WebAssembly engine
  forced). Every host the package supports has it: Node 20 and later,
  browsers and workers. Another host using the feature must call
  `fast_hash::init()` itself; otherwise the first map takes the seed, and
  panics, with a message that says so, where there is none.
- Without the feature (WASI, or a host without JavaScript), the seed is
  the entropy an embedder passes to `fast_hash::seed` before the first
  map, or else `std`'s `RandomState`: random on WASI, fixed on
  `wasm32-unknown-unknown`.
- Making a map's seed is a call (`RandomState::default` is not inlined),
  because maps are made in hundreds of places. Inlined, the seeding made
  the engine 9.8 KB larger. Out of line, the engine is 2.2 KB smaller
  than before (5,446,238 bytes against 5,448,495, with the error
  reporting above), and no phase moved by more than 0.5%.

Covered at first: the JSON reader's string and key tables, the
`fast_hash` `HashMap`s and `HashSet`s, and the tallies' `IndexMap`s. The
output did not depend on the seed: every scenario of the differential
suite (19,078, of which 18,957 run on WebAssembly) gave byte-identical
results with two different seeds.

#### Every map and set

The rest had `std`'s `RandomState`, with fixed keys in WebAssembly: the
`IndexMap`s and `IndexSet`s, many of them holding names from the input
(class properties, enum and string cases, `JsonValue` objects), and the
bindings' `std` `HashMap`s (natively, the GraphQL and TypeScript inputs'
too). Crafted property names could still slow inference. Now there is
one hasher for all of them, `SeededState`, in quickertype-js-compat's
`hash` module: the crate every other one depends on, and the one with
`JsonValue`. quickertype-core re-exports it as `support::fast_hash`. It is
the seeding above, moved, with aliases of `IndexMap`, `IndexSet`,
`HashMap` and `HashSet` and the reader's `StrHasher`:
- It is the same on every target: foldhash with a shared seed and a seed
  of its own for each map, from a sequence. The 16 bytes behind them are,
  natively, two hashes of a fresh `std` `RandomState`, which takes its
  keys from the operating system's random source, once per process; in
  WebAssembly, `crypto.getRandomValues` with `js-host-random`, per
  instance. (Natively the lookup maps and the reader's tables had
  foldhash's own seed, made from addresses and the clock, and the
  `IndexMap`s SipHash with keys from the system's random source.)
- foldhash with a secret seed is a fast hash, not a keyed pseudorandom
  function like SipHash: whoever learns some hashes may learn something
  of the seed. The CLI and the engine never show a hash. For an embedder
  that hashes untrusted input on a server, the `siphash` feature
  (quickertype-core's, which turns on quickertype-js-compat's) makes
  `SeededState` `std`'s `RandomState` natively, SipHash-1-3 with keys
  from the system's random source, for every map, set and the reader's
  tables; it is one `cfg` in the `hash` module. CI runs clippy and the
  core and js-compat tests with it. It has no effect on wasm32, where
  `std`'s keys are fixed.
- Nothing else can make a map. indexmap is built without `std`, and no
  crate in the tree turns it on (serde_json's `preserve_order` depends on
  indexmap without default features), so its types have no
  `RandomState` default and no `new()`. clippy's `disallowed-types`
  (`clippy.toml`) rejects `std`'s `HashMap`, `HashSet`, `RandomState`,
  `DefaultHasher`, `SipHasher` and `BuildHasherDefault`, indexmap's and
  hashbrown's map types, and foldhash's aliases, `SharedSeed` and every
  state and hasher of its `fast` and `quality`, everywhere but the `hash`
  module. `disallowed-methods` rejects `std`'s and indexmap's `new()` and
  `with_capacity()` (indexmap's in case a dependency ever turns `std`
  on). A scratch file that used each of the 32 entries got a warning for
  each.
- In WebAssembly, an embedder without `js-host-random` must call
  `fast_hash::seed` before any other use of the crates, since every map
  now takes its seed when it is made and parsing JSON makes maps; later,
  it panics and says so. pluralize's word tables hold the library's own
  words and are only looked up, so they are ordered (`BTreeMap`), not
  hashed. The bindings' start calls `init()` before anything makes a map.
- `npm/quicktype-core/test/seed.test.mjs` checks the property that
  matters: a key hashes differently in a new map of class properties in
  another process, in the fresh instance the facade makes after a trap
  (its own recovery path: `discardEngine`, then `createGlue`), and in
  another map of the same instance. With the entropy fixed, the test
  fails. The export it uses, `__hashForTests`, is a test hook: every
  export only the tests use (`__panicForTests`, `__pow`, the engine's
  counters) is behind quicktype-wasm's `test-hooks` feature, and
  `__heapBytes`/`__heapPeak` behind `heap-stats`. `script/test-hooks.mjs`,
  which `npm test` runs first, builds the tests' package: the shipped
  facade with an engine built with the feature and a `test-hooks` profile
  (release without fat LTO, written to `target/<triple>/test-hooks/`):
  29.7 s from cold at load 11 to 15, 0.67 s when nothing changed. The
  facade loads it as it loads the shipped one. Only the tests that call a
  hook use it: engine.test.mjs and samples.test.mjs run on the shipped
  engine and again, from their `*.hooks.test.mjs` twins, on the tests'
  engine, each test on the one it needs (and the samples tests that only
  also check the engine's leases on both). `package.test.mjs` checks that
  the shipped module and its glue have no test hook.

**`EqualityMap`** (`support::collection_utils`), which deduplicates types
by identity and resolves JSON Schema `$ref`s, reproduces collection-utils:
Java's `h * 31 + c` string hash with linear probing. Which entry a lookup
finds depends on the exact slots, and keys that are equal but hash apart
are found only where their probe runs meet: `Ref`s whose addresses differ
only in their query's order, since urijs `equals` normalizes them, and
string-match transformers, which quicktype finds equal exactly when their
cases differ while hashing the case. So its hash cannot be seeded. But
colliding Java hashes are easy to craft ("Aa" and "BB" hash alike, and so
does every string made of them), and each lookup walked the run of taken
slots: a JSON Schema with 4,000 definitions named so took 70.1 s to turn
into TypeScript (load 12). Now the map keeps exactly the original's
slots, and answers what the walk would without walking:
- a key's own slot is checked first: free, or holding an equal key,
  settles it, as it does the walk, without anything more;
- otherwise the first free slot after it comes from "next free slot"
  links with path compression, and the keys that may be equal from an
  index by a seeded `DeepHash`, which equal keys share. Each deep hash
  keeps its entries sorted by slot, so a lookup visits only those in its
  own probe run, in the walk's order, and stops at the first equal one;
- the deep hashes follow equality, as fine as it allows: sets and maps in
  any order; a `Ref` by its path and its address as urijs compares it
  (`Uri::equals_hash`: the normalized URI without its query, the query's
  length, its parameters in any order); a transformation field by field,
  without a string matcher's case; type names by their address, since
  they compare by identity; attribute kinds by discriminant. A
  `TypeIdentity` takes its deep hash only when asked for.

The same 4,000 definitions take 0.23 s, 16,000 take 1.24 s, with the same
output. Builds with debug assertions also walk the slots as the original
does and assert the same answer on every lookup (core's 497 tests pass
so). Unit tests compare the map with the original implementation on 600
random sequences of sets, gets and updates (clustered and wrapping
hashes, equal keys that hash apart, and in half of them one deep hash for
every key), and on 2^10 colliding strings; they fail with the run bound
removed. Another counts under two comparisons per operation with one deep
hash for 20,000 keys in runs of two. A property test of 4,000 generated
URI pairs that `equals` finds equal but are written differently (case,
default ports, dot segments, percent-encoding, reordered and repeated
parameters) checks that each pair hashes alike, and fails if the query
is hashed as written.

Against main (`73361a510`), interleaved, `-l cs` (minimum and median of
9 runs, outputs identical; another agent's builds and tests ran beside,
load average 5.3 to 18):

| Input | Main: min / median | Branch: min / median | Change |
|---|---:|---:|---:|
| 5,000 `$id` schemas, each referred to twice | 459.2 / 466.0 ms | 460.2 / 463.9 ms | +0.2% / −0.5% |
| 20,000 `$id` schemas | 1,952 / 2,002 ms | 1,950 / 2,058 ms | −0.1% / +2.8% |
| 2,000 classes with date-time and enum unions (transformations) | 562.4 / 583.9 ms | 553.9 / 565.6 ms | −1.5% / −3.1% |
| 8,000 such classes | 2,310 / 3,278 ms | 2,331 / 2,561 ms | +0.9% / −21.9% (load 7 to 18) |

`cargo xtask parity -j 6` with each CLI, in turn, three times: 13.3,
19.0 and 17.8 s of wall time for main against 14.0, 17.1 and 16.7 s (load
average 7 rising to 33), all 11,177 cases passing for both.

Not covered: in dependencies, regex-automata's maps. Their keys are
capture names of the engine's own patterns, and the lazy DFA's states,
which the input only selects among. saphyr-parser hashes nothing.

**The output does not depend on the seed.** An `IndexMap` iterates in
insertion order whatever its hasher. A `HashMap` or `HashSet` iterates in
an order that changes with the seed, so it must never reach output
(docs/PARITY.md, rule 1). An audit of every hashed map and set in the six
crates found none that does. The one iteration, naming's forbidden names
grouped by lowercase, feeds an `any` that gives the same answer in any
order. Every other is only looked up, sorted, or filled from an ordered
collection. `expand_strings` sums the seeded hashes of a set's cases to
bucket sets, but returns the first equal set among a bucket's candidates,
whatever the seed. `EqualityMap`'s results are the original's whatever
its index's seed. Every run takes new seeds, and all of these passed:
`cargo xtask parity -j 6` three times (11,177 of 11,177 cases each), the
workspace's tests (782) and core's and js-compat's with `siphash` (584),
`npm test` in npm/quicktype-core twice (90 tests on the shipped and the
test-hooks engines, one skipped because every renderer is ported), the differential suite (`npm run
test:differential`: 20,604 scenarios, 20,471 of them on WebAssembly,
none different; one known gap, as before), `npm run test:browser` and
the playground's smoke test, all after the last review's fixes (parity
once, there), and `npm test` on a `build.mjs --trace` dist. Before
them, these passed in each earlier round too, the differential suite
four times and parity nine.

**Speed.** Interleaved against main, on an Apple M2 Max with another
agent's builds and tests running beside:
- The CLI (`-l ts -o <file>`, 15 rounds, wall time; load average 3.9 to
  4.0), main (`73361a510`) against this branch after the first review's
  fixes (the seed from the operating system and the first rewrite of
  `EqualityMap`; the second's is timed above):

  | Input | Main: min / median | Branch: min / median | Change |
  |---|---:|---:|---:|
  | generated (40 MB) | 154.7 / 156.8 ms | 150.3 / 151.9 ms | −2.9% / −3.2% |
  | 1M records (267 MB), all cores | 47.6 / 49.2 ms | 48.2 / 49.4 ms | +1.3% / +0.3% (CPU time −0.6%) |
  | 100k records (26.8 MB), all cores | 9.6 / 10.0 ms | 9.6 / 10.2 ms | +0.7% / +2.1% (CPU time +0.9%) |

  Before the review's fixes (foldhash's own seed natively, the old
  `EqualityMap`), against `b65fa2212`, two blocks gave −2.6% and −3.0%,
  +1.4% and −1.7%, +0.5% and +0.1% at the minimum (load 6.6 and 7.5).
  The records are within noise; generating the 40 MB input, where the
  run hashes many class properties and string cases, is faster.
- The engine natively (the `phases` example, before the review's fixes,
  15 rounds of 21 runs, load average 2.7 to 2.9): the rulings' read and
  run within 1%. On the 40 MB input (9 rounds of 11, load 6.3 to 9.4),
  the run (inference and rendering) 6.0% faster (54.0 to 50.8 ms, faster
  in 8 of 9 rounds), the read within noise.
- WebAssembly in headless Chrome (`compare.mjs --browser --variant`, the
  two packages interleaved in one page), main (`73361a510`) against this
  branch after the first review's fixes (before the second's `EqualityMap`
  changes); load average 14.4 falling to 5.3. The
  median of three runs of the benchmark, each a median, in ms; Chrome's
  timer steps by 0.1 ms here:

  | Input | Main: read / generate / total | Branch: read / generate / total |
  |---|---:|---:|
  | pokedex (82 KB) | 0.50 / 1.20 / 1.70 | 0.50 / 1.20 / 1.70 |
  | generated (2 MB) | 9.00 / 5.20 / 14.2 | 8.90 / 5.00 / 13.8 |
  | generated (20 MB) | 89.4 / 32.8 / 122 | 89.7 / 31.8 / 121 |
  | rulings (27 MB) | 46.5 / 6.40 / 53.0 | 46.5 / 6.60 / 53.0 |
  | cards (22 MB) | 88.9 / 23.7 / 112 | 89.5 / 23.4 / 113 |

  Generating the 20 MB input is 4% faster in two runs (32.7 to 31.3,
  33.1 to 31.8) and 9% slower in the first, at load 14; the 2 MB input
  2–4% faster in each. Generating the rulings is two timer steps slower
  in two runs and equal in the third. Everything else is the same within
  the timer's step and the noise. Before the review's fixes, against
  `b65fa2212` (load 5.7 falling to 3.3), generating the 20 MB input was
  2–3% faster in each of three runs (32.6 to 31.9 ms, the medians).
- The engine is 5,478,565 bytes, 1,440 (0.03%) larger than main's
  (5,477,125), without its test hooks.

### Hashing strings in WebAssembly

A profile of the engine reading the 20 MB input in Chrome put 7.1% of
the time in foldhash's `write_str` and 5.2% in looking strings up in the
string table. Reading hashes every key and every short string value.

Hashing a `&str` through `Hash` writes the bytes and then a marker byte.
The marker keeps a string apart from what follows it in a longer key.
foldhash keeps the marker in a 128-bit buffer and spends one more
multiply on it when it finishes. In WebAssembly that is costly:
- WebAssembly has no instruction for the high half of a 64 by 64 bit
  multiply, so each of foldhash's multiplies becomes four `i64.mul`.
- Shifting the 128-bit buffer is a call (`__ashlti3`).
- `write_str` was not inlined, so the hasher's state went through memory.

The reader's string and key tables hash one whole string at a time, so
they do not need the marker. They now hash with
`fast_hash::StrHasher::hash_str`: foldhash's `write` and `finish` only.
This is exactly what foldhash's own `write_str` does with its `nightly`
feature; `write` mixes the length in. `StrHasher` hashes strings in this
one way only, so a table cannot mix its hashes with `hash_one`'s. The
seed and the quality are foldhash's (see the quality notes below).

Warm runs in headless Chrome, medians in ms, before and after this
change (both with the seeding above), interleaved in one page. There
were two runs, of 11 and 25 rounds per input. The table shows the
second run; the Change column gives both.

| Input | Phase | Before | After | Change |
|---|---|---:|---:|---:|
| generated, 2 MB | read: record | 4.61 | 4.25 | −8% / −9% |
| | read: commit | 4.51 | 4.15 | −8% / −8% |
| | addSource | 10.19 | 9.46 | −7% / −7% |
| | total | 17.73 | 17.08 | −4% / −4% |
| generated, 20 MB | read: record | 46.23 | 42.68 | −8% / −10% |
| | read: commit | 46.98 | 43.38 | −8% / −13% |
| | addSource | 102.8 | 95.56 | −7% / −11% |
| | total | 155.0 | 147.6 | −5% / −8% |
| rulings, 27 MB | read: commit | 20.82 | 19.74 | −5% / −4% |
| | addSource | 52.65 | 51.58 | −2% / −1% |
| | total | 59.44 | 58.44 | −2% / −1% |
| pokedex, 82 KB | addSource | 0.560 | 0.530 | −5% (one run) |

The run (`quicktypeMultiFile`) changed by −3% to +1%, within noise, and
so did everything with the seeding commit alone (−1.3% to +1.1% in
total). The rulings gain is small because most of their strings are
comments too long to intern. The engine is 0.5 KB larger.

Whole runs (`compare.mjs --browser`, the three commits together against
the commit before them, and TypeScript, in one page):

| Input | Before | After | TypeScript | × TypeScript, before → after |
|---|---:|---:|---:|---:|
| pokedex (82 KB) | 2.30 | 2.30 | 5.20 | 2.26× → 2.26× |
| generated (2 MB) | 18.0 | 17.4 | 49.0 | 2.72× → 2.82× |
| generated (20 MB) | 158 | 152 | 448 | 2.83× → 2.95× |
| rulings (27 MB) | 60.9 | 59.8 | 180 | 2.95× → 3.01× |

Natively (the `phases` example, mimalloc) the change is about neutral.
Hashing is a smaller share of reading there, and the machine was heavily
loaded (load average 30 to 75), so these are medians of 10 to 20
interleaved cycles, with the minimum where the medians were too noisy:
- 2 MB input, `read: commit`: −3% to −4% in three runs (2.96 to 2.84 ms).
- 20 MB input, `read: commit`: −0.4% to −3% at the minimum (31.6 to
  31.5, 32.8 to 31.8 ms); the medians were too noisy to tell.
- Rulings, `read: commit`: +4% in all three runs (11.7 to 12.2 ms). A
  microbenchmark of interning rulings' strings (all of them, or only the
  100,000 UUIDs) is 4–7% faster with `write` and `finish`. A build that
  hashed with `hash_one` through the same function did not show the
  slowdown, so the cause is not clear; it may be how the code is laid
  out. **To re-check** on a quiet machine at the next benchmark refresh:
  if the slowdown holds, `hash_str` should use `write` alone only in
  WebAssembly (one `cfg`).
- `read: record`, the run, and every phase of pokedex: within ±3%.

**Re-checked** at the benchmark refresh of November 14, 2026 (load
average 5.3 to 7.4): `fa1218d8c^` (`00078c130`) against `fa1218d8c`, the
`phases` example (mimalloc, `--features trace`), 15 interleaved rounds of
21 runs each; the medians of the rounds' medians, and the range of the
change over the rounds:

| Input | Phase | `fa1218d8c^` | `fa1218d8c` | Change |
|---|---|---:|---:|---:|
| rulings (27 MB) | read: commit | 10.87 ms | 11.40 ms | +4.9% (+3.7 to +5.7%) |
| | read: record | 15.91 ms | 15.99 ms | +0.5% (−0.9 to +1.7%) |
| | `jsonRead` (record + commit) | 26.80 ms | 27.36 ms | +2.1% (+1.0 to +3.1%) |
| | the run | 4.35 ms | 4.36 ms | +0.3% (−1.1 to +1.6%) |
| generated (20 MB) | read: commit | 31.11 ms | 30.36 ms | −2.4% (−6.7 to +1.5%) |
| | `jsonRead` | 64.02 ms | 63.18 ms | −1.3% (−4.8 to +1.9%) |
| generated (2 MB) | read: commit | 2.88 ms | 2.83 ms | −1.8% (−7.4 to −0.1%) |
| | `jsonRead` | 6.09 ms | 5.99 ms | −1.5% (−6.4 to +1.0%) |

The slowdown on the rulings' commit holds: +4.9%, and slower in every one
of the 15 rounds, which makes reading the rulings natively 2% slower; the
generated inputs are not slower. It is in the reader the WebAssembly
engine runs, which interns into the compressed form's string table and
keeps the `JSON.parse` reader's key table. The CLI's running tallies
intern into the same kind of string table, but the CLI is not measurably
affected: built at the same two commits, it took 29.9 and 30.0 ms on the 100k rulings and 86.7 and
85.4 ms on the 20 MB input (`-l ts`, 15 interleaved runs each).

**Re-checked again** with every map seeded (see "Every map and set"
above): the `cfg`, natively `hash_one` (`Hash for str`) and in
WebAssembly `write` and `finish`, against `write` and `finish` everywhere,
on the `phases` example and the CLI, interleaved:
- Rulings, `read: commit`: −1.4% (11.22 to 11.05 ms, 25 rounds of 21
  runs, faster in 21; load average 4.1 to 4.5) and −0.3% (15 rounds,
  load 2.7 to 2.9). The re-check above found `write` alone 4.9% slower
  here; now it is 0.3 to 1.4% slower.
- The 40 MB input, `read: commit`: +1.1%, within the noise (9 rounds,
  load 6.3 to 9.4).
- The CLI: the same within noise on the 100k and 1M records and the 40
  MB input (−0.5% to +2% at the minimum, 11 to 21 rounds).

About 1% in one phase and nothing in the CLI is not worth a second way
to hash strings, which the native tests would no longer cover, so the
`cfg` is not made: `hash_str` is `write` and `finish` on every target.

#### Tried and dropped: a 32-bit hasher for WebAssembly

foldhash's design with 32-bit halves ("fold32"). Each step multiplies the
two 32-bit halves of a word that was XORed with secrets, in one
`i64.mul`, and XORs the halves of the product. Strings of up to 8 bytes
take one step, numbers take one step, and the hash is 32 bits; on a
32-bit target hashbrown uses only 32 bits anyway. It was also the
`BuildHasher` of every map. In a microbenchmark it hashed the benchmark
inputs' strings 10–18% faster than foldhash's `write` and `finish`. In
the engine it was the same within noise: on the 20 MB input, 95.75 ms
against 95.56 to read and 147.9 against 147.6 in all, over 25
interleaved rounds (3–4% slower in the first run, of 11 rounds). It made
the engine 42 KB larger, so it was dropped. Its quality matched
foldhash's (see below).

#### Hash quality

Measured on the distinct strings of the benchmark inputs (292,182 from the
20 MB input, 52,274 from rulings), as a 32-bit target's hashbrown sees
them: the bucket from the low bits, the tag from bits 25 to 31.
- 32-bit collisions on the 20 MB input's strings, with two seeds: 10 and
  6 for `write` and `finish`, 6 and 13 for `hash_one`, 7 to 22 for
  fold32. Chance alone gives 9.9. On rulings' strings: 0 to 2, where
  chance gives 0.3.
- Bucket and tag counts against uniform: χ²/df between 0.73 and 1.24
  for every hash. That is what uniform counts give: one standard
  deviation is 0.13 for the 128 tags.
- Avalanche (one input bit flipped, how often each output bit flips): on
  average within 0.01 of one half for every length. The worst single
  pair of bits is 0.2 from one half for 4 to 12 bytes, for `write` and
  `finish` and for fold32. With the marker's extra multiply, foldhash
  stays within 0.03. A bias on some pairs of bits does not show in the
  bucket counts.
- Pairs built to collide whatever the seed (halves swapped, texts that
  read the same words at different lengths, a 64-byte prefix): none
  collided over 2^20 random seeds.

How they stand against crafted collisions: all of these are only as good
as their seed. If the seed is known, keys that zero one factor of a
multiply collide at once. With a secret seed, an attacker cannot compute
the hash, and nothing above collides independently of the seed. This
holds for foldhash's `hash_one` too, which is no stronger here.
WebAssembly's 32-bit hashbrown uses 32 bits of any hash. Natively, the
seed is per process (address space layout randomization and the clock).
In WebAssembly it is now per instance, from `crypto.getRandomValues`
(see "Hash seeds in WebAssembly").

### Cards: URIs, the walk and the read's memory

A user's data showed where the engine was still slow: a dump of
trading cards, a JSON array of 120,095 cards (656 MB), one per line, each
with about 27 URIs (the card's API link and web page, a dozen image links
by the card's id, search links), most of them found in no other card. On
slices of it (the first N lines, closed with `]`), the walk over the
compressed form into tallies took 56% of a run natively and half of it in
WebAssembly, where on small records it takes a few milliseconds. The
data is not in the repository; `generateCards` in
`npm/quicktype-core/test/bench/generate.mjs` makes cards of the same
shape (26.8 URIs per card, four in five distinct, 4.4 KB per card,
against 27.5, three in four, 5.5 KB), and the benchmarks run 5,000 of
them (22 MB).

**Where the walk's time went.** A profile of the walk over the 100 MB
slice (18,244 cards; `sample` on the `profiling` build of the `phases`
example) put 61% of it in `uriInferenceAttributesProducer` and 16% in
recognizing each URI's kind again: 77% on URIs, against 23% for the
tallies themselves. The slice has 502,269 URIs, 381,934 of them
distinct, so the 256 slots in which the walk kept recurring URIs' kinds
and attributes seldom held one. The producer parsed each URI with the
port of urijs, which copies the string and allocates every part of it
(about ten allocations, two through `format!`), to keep the protocol and
the path's extension; then it made two index sets and an attribute set,
which the tallies nearly always found known and dropped.

**What the walk repeated from the read.** The read's commit pass
classifies every string with the form's date/time recognizer and records
a `uri` as a transformed string; the walk recognized the kind from the
text again. Making the attributes is not a repeat: the CLI, which tallies
while it reads, makes them for every URI too, and so paid the same parse.
The engine's extra cost over the CLI is the compressed form itself: the
commit pass interns every distinct URI (the JavaScript tables must hold
them, as TypeScript's do) and writes 2.2 million object entries, and the
walk reads them back.

The changes, one commit each:

1. A plain URI (`http://`, `https://` or `ftp://`, a host without `@`
   or `[` and with at most a decimal port that urijs accepts, no
   backslash, tab or line break before the query) is read in one pass
   over a table of the bytes that matter, which finds the path's last
   dot on the way; every other URI goes to urijs' parser, as before. The
   walk keeps the parts of the last 256 URIs by string index, so a URI
   that recurs is read or parsed once. A test compares the two on 200,000 random strings of the
   characters that matter to urijs, and `cargo xtask diff` against
   TypeScript quicktype gave identical output for 600 documents of URIs
   of every shape and 30 of generated cards (JSON Schema, which shows the
   protocols and extensions, TypeScript and Rust, with three option sets;
   the cards in all 27 languages).
2. The tallies take a URI's protocol and extension, borrowed from its
   text, and make its attributes only when the place lacks one of them.
3. The walk takes every transformed string as a `uri` (the one kind with
   an attribute producer) instead of recognizing its kind again: a reader
   makes only those, and imported tables are checked once, as their
   values are decoded.
4. `is_uri` looks for braces byte by byte instead of decoding every
   character of the URI (the read's commit pass and the CLI).
5. The `JSON.parse` reader's tape: 8 bytes a node instead of 12 (a
   string longer than a node's 28 bits of length has it in a side
   table), and no large room left from its doubling while the tape is
   committed (see the memory below).

The differential suite has two new sample groups (URIs of every shape,
and generated cards) to 9 languages; `cargo xtask streaming-fuzz --path
all` found no difference in 1,000,000 seeds, and `cargo xtask parity`
passes its 11,177 cases. The measurements below were taken on the
branch's base, `a07ef1cb4`: before samples as bytes, the slab allocator
and the new hashing (the sections above).

**Time.** The machine (M2 Max, 12 cores) ran other agents throughout,
with load averages between 15 and 70, so every comparison below
interleaves the builds, and a range is that of their medians over the
rounds. Each step against the one before it, on the 100 MB slice, the
walk in ms (natively: the `phases` example, medians of 5 runs; in
WebAssembly: headless Chrome, medians of 3 runs, with the total of
`addSource` and `quicktypeMultiFile`):

| Step | Native walk | WebAssembly walk | WebAssembly total |
|---|---:|---:|---:|
| 1. plain URIs without urijs | 379–387 → 177–204 | 466–469 → 213 | 951 → 694–696 |
| 2. URIs tallied by their parts | 177–204 → 129–142 | 215–217 → 129 | 707–708 → 636–638 |
| 3. the reader's classification kept | 100–102 → 60 | 125–129 → 72–73 | 597–624 → 552–561 |
| 4. braces by bytes (the read's commit pass) | 60 | 72–74 (commit 194–210 → 186–192) | 539–554 → 531–541 |

Before against after, the slices of the dump and generated cards,
interleaved in one session (load average 10 to 37). Natively in process
(`phases`, mimalloc; medians of 5 runs, of 3 for 450 MB, two rounds), ms:

| Input | Record | Commit | Walk | Read + run |
|---|---:|---:|---:|---:|
| 100 MB of cards, before | 94–102 | 174–185 | 351–374 | 640–660 |
| after | 88–90 | 163–164 | 67–69 | 331–333 |
| 250 MB, before | 213–253 | 477–520 | 804–879 | 1,549–1,639 |
| after | 203–214 | 466–597 | 171–176 | 868–1,003 |
| 450 MB, before | 430–454 | 889–947 | 1,456–1,665 | 2,801–3,121 |
| after | 380–415 | 754–764 | 286–329 | 1,465–1,489 |
| `generateCards(5_000)` (22 MB), before | 18–19 | 35 | 73–74 | 132–136 |
| after | 19–20 | 33–35 | 15–17 | 74–78 |
| `generateCards(22_800)` (100 MB), before | 90–91 | 207–220 | 340–375 | 655–699 |
| after | 84–89 | 174–198 | 71–72 | 343–365 |

Counted by the processor, which other work changes little (`/usr/bin/time
-l` over four reads and runs in one process): a read and run of the 100
MB slice takes 3.69 billion instructions and 0.93–0.94 billion cycles,
against 7.17 and 1.73; of the 22 MB of generated cards 0.94 and 0.23,
against 1.82 and 0.43. Its peak RSS goes from 361 to 290 MiB.

In WebAssembly, headless Chrome (`phases.mjs`' page: warm, medians of 3
runs after 3 warm-up runs, two rounds), ms, and the memory after the six
runs:

| Input | Record | Commit | Walk | `addSource` + run | Memory |
|---|---:|---:|---:|---:|---:|
| 100 MB of cards, before | 118–119 | 198–210 | 466–467 | 947–948 | 504 MiB |
| after | 114–118 | 187–188 | 72–73 | 527–534 | 549 MiB |
| 250 MB, before | 285 | 699–723 | 1,165–1,166 | 2,522–2,558 | 1,327 MiB |
| after | 282–283 | 610–648 | 182–183 | 1,438–1,482 | 1,220 MiB |
| 450 MB, before | 513–522 | 1,089–1,146 | 2,137–2,139 | 4,627–4,732 | 2,424 MiB |
| after | 505–543 | 980–1,137 | 330–348 | 2,683–2,928 | 1,540 MiB |
| `generateCards(5_000)` (22 MB), before | 28–29 | 54 | 118 | 243 | 151 MiB |
| after | 28 | 49–53 | 18 | 136–141 | 135 MiB |

The CLI (`-l ts`, the release build, which reads on one thread) reads
the same samples into running tallies and gains from changes 1, 2 and 4.
Billions of instructions, billions of cycles and CPU time (three rounds;
the peak RSS does not change):

| Input | Before | After |
|---|---:|---:|
| 100 MB of cards | 6.24–6.26, 1.34–1.35, 0.40 s | 3.18–3.20, 0.70–0.72, 0.20–0.21 s |
| 250 MB | 15.47–15.48, 3.32–3.38, 0.99–1.00 s | 7.83–7.84, 1.75–1.77, 0.52–0.53 s |
| 450 MB | 27.77, 5.96–5.99, 1.79–1.85 s | 14.01, 3.13–3.53, 0.94–1.10 s |
| `generateCards(5_000)` (22 MB) | 1.61, 0.35–0.36, 0.10–0.11 s | 0.79, 0.19–0.20, 0.05–0.06 s |

On the whole dump (656 MB, more than a JavaScript string holds), the CLI
writes the same TypeScript as TypeScript quicktype; on the 450 MB slice,
so do the CLI and the engine (through the npm package in Node).

**Where the time goes now.** At 100 MB natively, the walk is about 65
ms, of which 37% is reading URIs' parts (a pass over 50 MB of URI text)
and the rest the tallies. The read is now the larger part: in a profile
of `jsonRead`, classifying strings is 19%, interning them into the
string table (hashing, looking up, appending) about a quarter
(`perf/wasm-hash` works on the hashing), and the record pass's keys 23%.

**Memory.** On a cold page, one `addSource` and one run of the 100 MB
slice, the most bytes the engine had allocated at once (a `--heap-stats`
build) was 286 MiB, reached at the end of the read's commit pass:

| Held at that moment | Before | After |
|---|---:|---:|
| The text, copied into WebAssembly memory | 95 MiB | 95 MiB |
| The tape: 4.66 million nodes | 96 MiB (12 B each, grown by doubling to 2^23) | 36 MiB (8 B each, trimmed) |
| The compressed form: strings | 47 MiB (37 MiB of it the text of 381,934 distinct URIs) | the same |
| The compressed form: 2.23 million object entries (16 B each), 0.2 million array elements | 43 MiB | the same |
| Other (key table, decoded strings) | about 5 MiB | the same |

The text, a string here, is copied with wasm-bindgen's `encodeInto` into
a buffer of the string's UTF-16 length; only what does not fit is
reallocated at 3 bytes per unit, which on these cards is a few hundred
kilobytes, so the copy costs about 1× the text in memory. After the read, the form alone is held (91 MiB),
and a run adds 7 MiB (the tallies are 1.2 MiB). The WebAssembly memory
also keeps what the allocator freed and the quarter it added when it grew
(`allocator.rs` at the time). The peak, and the memory at the end, of one
read and run on a cold page:

| Input | Peak, before | Peak, after | Memory, before | Memory, after |
|---|---:|---:|---:|---:|
| 100 MB of cards | 285.9 MiB | 225.4 MiB | 306.9 MiB | 279.4 MiB |
| the same, ASCII only (`\u` escapes) | 287.3 MiB | 226.8 MiB | 386.2 MiB | 278.8 MiB |
| `generateCards(22_800)` (100 MB) | 296.1 MiB | 237.5 MiB | 384.6 MiB | 264.2 MiB |
| 250 MB of cards | 651.0 MiB | 547.8 MiB | 822.4 MiB | 608.6 MiB |
| 450 MB of cards | 1,199.5 MiB | 975.2 MiB | 1,509.6 MiB | 1,109.6 MiB |

Per byte of input, the memory of a cold read and run goes from 3.2 to 2.9
bytes at 100 MB and from 3.5 to 2.6 at 450 MB, and the peak allocated
from 3.0 to 2.4 and 2.8 to 2.3.

Reading the same sample again in the same page (as the benchmarks do, a
new input each time) holds two forms at once, the last one being freed
only when JavaScript finalizes its input: the peak allocated is then
376.5 MiB at 100 MB (316 after), and the memory at the end depends on
where the allocator placed the large blocks (the text, the tape, the
tables' index vectors). It went from 504 to 549 MiB at 100 MB, but from
1,327 to 1,220 at 250 MB and from 2,424 to 1,540 at 450 MB (the table
above). A tape in fixed segments of 1 MiB was tried: 482 MiB at 100 MB
and 1,402 at 250 MB, as mixed, so the tape is not what decides it, and it
was left as a vector; how the allocator places large blocks is.

**After rebasing onto main** (`fa1218d8c`: samples as bytes, the slab
allocator, the new hashing), main against the branch, interleaved on a
quiet machine (load average 5 to 8), the samples as strings:

| | main | the branch |
|---|---:|---:|
| 100 MB of cards, native read + run (walk) | 486–513 (277–291) ms | 270–273 (58–60) ms |
| 450 MB, native | 2,285–2,341 (1,265–1,280) ms | 1,243–1,261 (269–270) ms |
| 100 MB, Chrome, `addSource` + run (walk) | 806–811 (387–388) ms | 476–485 (69) ms |
| 450 MB, Chrome | 3,988–4,209 (1,724–1,811) ms | 2,443–2,705 (331–341) ms |
| `generateCards(5_000)`, Chrome | 190–205 ms | 114–117 ms |
| 100 MB, the CLI's CPU time | 0.40–0.41 s | 0.20–0.21 s |
| 450 MB, the CLI | 1.80 s | 0.92–0.93 s |
| 100 MB, a cold read and run in Chrome: peak allocated, memory | 285.9, 306.9 MiB | 225.4, 278.3 MiB |
| 450 MB, the same | 1,199.5, 1,483.6 MiB | 975.2, 1,109.6 MiB |
| 100 MB, memory after six reads and runs in one page | 602 MiB | 547 MiB |
| 450 MB, the same | 2,392 MiB | 1,540 MiB |

What could still shrink: the form's values are 8 bytes (a tag and an
index); packed into 4, as TypeScript packs them, object entries would
take 8 bytes and the form about 68 MiB instead of 90 at 100 MB, but the
public `get_object_for_value` and `get_array_for_value` return slices of
values, which would have to become iterators. The URIs' text must stay:
the JavaScript tables hold it.

## Reproducing

```sh
# The TypeScript CLI: a built quicktype checkout beside the workspace
# (or set QUICKTYPE_REFERENCE), as for `cargo xtask diff`.
cargo xtask bench                     # CLI benchmarks, 10 runs each
cargo xtask bench --corpus            # + the whole golden corpus
cargo xtask bench --in-process        # + the engine in process vs warm TypeScript
cargo xtask bench --filter json -n 20 # a subset, more runs
cargo xtask bench --no-ref            # without the TypeScript CLI
cargo xtask bench --out report.md     # also write the Markdown table
cargo xtask bench --corpus --in-process --json site/data/benchmarks.json
                                      # the playground's numbers, as JSON
node site/readme-charts.mjs           # the README's charts, from its tables (see README charts)

# Large inputs (site/data/big-inputs.json): on all cores, then on one thread.
/usr/bin/time -l target/release/quickertype <input> -l ts -o out.ts
QUICKTYPE_READ_THREADS=1 /usr/bin/time -l target/release/quickertype <input> -l ts -o out.ts

# Before/after: build the older commit in its own worktree and pass it.
git worktree add ../qt-before 11091954f
(cd ../qt-before && cargo build --release --bin quicktype)
cargo xtask bench --baseline ../qt-before/target/release/quicktype --corpus

# WebAssembly against TypeScript (npm/quicktype-core, after npm run build).
node --expose-gc npm/quicktype-core/test/bench/compare.mjs             # Node, warm
node npm/quicktype-core/test/bench/compare.mjs --browser               # headless Chrome
node npm/quicktype-core/test/bench/compare.mjs --browser --cold 5      # first runs
node npm/quicktype-core/test/bench/compare.mjs --browser --again       # + a second run on each input
node --expose-gc npm/quicktype-core/test/bench/compare.mjs --browser --again --json   # site/data/browser.json's warm numbers
node npm/quicktype-core/test/bench/compare.mjs --cold 7 --json                       # and its cold_node numbers
node npm/quicktype-core/test/bench/compare.mjs --variant main=../main-pkg --variant new=npm/quicktype-core
(cd npm/quicktype-core && node script/build.mjs --heap-stats)        # + __heapBytes, __heapPeak

# The in-process benchmark alone.
cargo bench -p quickertype --bench in_process -- --per-input
cargo bench -p quickertype --bench in_process --no-default-features   # system allocator
node xtask/bench/in-process.mjs ../quicktype                            # warm TypeScript
```

Phase 7's in-process "before" row was measured by copying
`crates/quicktype-cli/benches/in_process.rs` (and its `[[bench]]` entry)
onto `11091954f`; it only uses the public Rust API, which had not changed.

Notes:

- Each benchmark runs once untimed (warming the file cache, and checking
  that every command writes the same files: a mismatch is flagged in the
  table), then `-n` times; the table shows the median and the minimum.
- Peak RSS is from one extra run under `/usr/bin/time -l` (macOS) or
  `-v` (GNU time).
- The generated inputs are written to `target/bench` by a seeded
  generator (`xtask/src/bench.rs`): records with nested classes, arrays of
  classes, a map with random keys, enums, dates, UUIDs, URIs, integer
  strings, nullable and optional properties and a number/string union.
- The corpus run replays every step of every case in `tests/golden` with
  as many jobs as cores and does not check outputs (`cargo xtask parity`
  does). TypeScript's wall time there is CPU-bound on 12 cores.
- `--json` writes what the playground's benchmarks page shows
  (`site/data/benchmarks.json`), which `site/build.mjs` checks first. The
  commit of a `--bin` or `--baseline` CLI is the HEAD of the work tree
  whose `target` directory holds it, if it was built after that commit,
  and null otherwise; `commits.<id>_source` says which. Why a CLI's corpus
  runs exited unexpectedly is added by hand when the snapshot is made, as
  `corpus.results.<id>.unexpected_exits_note` (a sentence); without one,
  the page shows the number as a warning.

## README charts

The charts in the README's "Speed and memory" (`docs/assets/charts`, a
light and a dark SVG each) are drawn from the README's two tables by
`site/readme-charts.mjs`, so they show exactly what the tables say. After
changing a number in either table, regenerate them:

```sh
node site/readme-charts.mjs
```

`node site/readme-charts.mjs --check`, which `site/test/smoke.mjs` runs
(in the Pages workflow), fails when a chart is missing or out of date, when
the README does not show one, or when a table is no longer in the shape the
charts are drawn from. The README loads them by absolute URL from
`raw.githubusercontent.com` on `main`, since npm does not resolve relative
image paths, nor crates.io a relative `srcset`; a README on a package page
therefore shows `main`'s charts.

They read the README rather than the data files: the README rounds the
numbers and groups some rows (the eight languages, quicktype's corpus).
Its CLI rows are those of `site/data/benchmarks.json`, its browser rows
those of `site/data/browser.json` (warm; the records' "generating the code
only" row is their `generate_ms`). After the data files are measured
again, copy the numbers into the README's tables, then regenerate the
charts.
