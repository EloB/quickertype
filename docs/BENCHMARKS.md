# Benchmarks

How fast the Rust port is compared to the TypeScript quicktype it
replaces, how to measure it, and what Phase 7 changed. The numbers come
from `cargo xtask bench` (see [Reproducing](#reproducing)). Every
optimization keeps the output byte-identical: `cargo xtask parity` passes
the same 10,796 cases with 0 regressions, the render-case and scenario
tests pass, and the benchmark itself checks that every CLI writes the same
files.

## Summary

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

## Machine

- CPU: Apple M2 Max, 12 cores, 64 GiB
- OS: macOS 26.6.2
- rustc 1.99.1, Node.js v24.16.0, TypeScript reference at `c39af7d3`
  (`tests/golden/REFERENCE`)
- "Before" is `11091954f` (the merge of `feat/graphql-input`, where this
  branch starts); "after" is this branch.
- The machine was shared with other work while these numbers were taken
  (load average around 10). The in-process runs were interleaved in three
  rounds; the CLI numbers agree with quieter earlier runs within a few
  percent.

## CLI

10 timed runs per benchmark and command after one warm-up run; wall time in
ms, median (min). The rightmost column is the peak resident set size of one
more run.

| Benchmark | TypeScript | Rust (before) | Rust (after) | vs TS | vs before | Peak RSS MiB (TypeScript / Rust (before) / Rust (after)) |
|---|---:|---:|---:|---:|---:|---:|
| **startup** | | | | | | |
| --version | 217 (214) | 2.09 (1.97) | 2.26 (2.16) | 95.8× | 0.9× | 151.4 / 2.6 / 3.4 |
| tiny JSON (77 B) → TypeScript | 241 (231) | 4.16 (3.99) | 2.83 (2.53) | 85.2× | 1.5× | 150.3 / 4.8 / 5.5 |
| **json** | | | | | | |
| pokedex (82 KB) → TypeScript | 257 (253) | 11.7 (11.1) | 4.78 (4.58) | 53.8× | 2.5× | 157.7 / 9.2 / 8.1 |
| us-senators (155 KB) → TypeScript | 263 (259) | 13.1 (12.7) | 5.42 (5.19) | 48.5× | 2.4× | 163.0 / 9.3 / 8.2 |
| misc/1b409 (606 KB) → TypeScript | 292 (289) | 18.9 (18.2) | 7.94 (7.75) | 36.8× | 2.4× | 172.0 / 11.2 / 9.9 |
| all 13 samples as one top-level (multi-source) → TypeScript | 341 (334) | 27.6 (27.1) | 14.5 (14.1) | 23.5× | 1.9× | 181.6 / 12.2 / 10.8 |
| generated (4 MB) → TypeScript | 507 (500) | 71.3 (69.5) | 36.5 (35.3) | 13.9× | 2.0× | 237.8 / 37.8 / 27.8 |
| generated (40 MB) → TypeScript | 2621 (2588) | 595 (583) | 319 (314) | 8.2× | 1.9× | 624.7 / 221.0 / 177.5 |
| generated (40 MB) → Rust | 2600 (2551) | 590 (581) | 321 (319) | 8.1× | 1.8× | 681.8 / 223.0 / 177.4 |
| **languages** | | | | | | |
| github-events (82 KB) → ts | 271 (268) | 15.2 (14.7) | 6.42 (6.35) | 42.2× | 2.4× | 172.0 / 9.5 / 8.4 |
| github-events (82 KB) → rust | 273 (271) | 16.6 (16.1) | 6.64 (6.51) | 41.1× | 2.5× | 172.8 / 9.3 / 8.2 |
| github-events (82 KB) → go | 273 (269) | 15.0 (14.6) | 6.35 (6.17) | 43.0× | 2.4× | 172.4 / 9.4 / 8.2 |
| github-events (82 KB) → cs | 277 (274) | 15.8 (15.3) | 6.52 (6.33) | 42.5× | 2.4× | 174.3 / 9.7 / 8.5 |
| github-events (82 KB) → java | 289 (284) | 25.9 (25.6) | 9.02 (8.85) | 32.0× | 2.9× | 174.3 / 11.0 / 9.6 |
| github-events (82 KB) → py | 279 (276) | 16.7 (16.5) | 7.13 (6.97) | 39.1× | 2.3× | 173.1 / 10.3 / 9.1 |
| github-events (82 KB) → swift | 277 (272) | 18.3 (18.0) | 7.06 (6.94) | 39.2× | 2.6× | 172.3 / 10.4 / 9.1 |
| github-events (82 KB) → c++ | 289 (284) | 31.1 (30.6) | 9.03 (8.82) | 32.0× | 3.4× | 173.9 / 11.5 / 9.8 |
| **schema** | | | | | | |
| vega-lite.schema (306 KB) → TypeScript | 418 (414) | 61.3 (60.6) | 37.4 (36.9) | 11.2× | 1.6× | 224.2 / 18.7 / 17.0 |
| vega-lite.schema (306 KB) → C# | 431 (421) | 72.1 (71.1) | 41.2 (39.9) | 10.5× | 1.8× | 226.3 / 21.0 / 19.0 |
| **graphql** | | | | | | |
| github.gqlschema (1.2 MB) + query → TypeScript | 245 (242) | 17.1 (16.6) | 9.28 (9.12) | 26.4× | 1.8× | 153.2 / 15.4 / 13.4 |
| **multi-file** | | | | | | |
| vega-lite.schema → Java (one file per class) | 489 (479) | 106 (105) | 54.5 (52.6) | 9.0× | 1.9× | 236.3 / 26.0 / 21.8 |
| pokedex → C++ (multi-source) | 264 (258) | 13.3 (13.1) | 5.30 (5.05) | 49.8× | 2.5× | 160.4 / 9.2 / 8.3 |

## Golden corpus

Every step of every case in `tests/golden` (11,178 CLI runs: all target
languages, JSON, JSON Schema, GraphQL and TypeScript inputs, CLI behavior),
12 parallel jobs, outputs not checked (that is `cargo xtask parity`). "CLI
time" is the sum of every run's wall time under that load.

| Command | Steps | Wall time (s) | CLI time, summed (s) | Mean per step (ms) | Unexpected exits |
|---|---:|---:|---:|---:|---:|
| TypeScript | 11178 | 571.7 | 6846.5 | 612.5 | 0 |
| Rust (before) | 11178 | 18.4 | 209.8 | 18.8 | 381 |
| Rust (after) | 11178 | 12.5 | 133.7 | 12.0 | 381 |

The 381 unexpected exits of the Rust CLI are the 381 golden cases outside
the parity baseline (C/cJSON output, which is landing separately), the
same before and after.

## In process

The engine as a library, without process start or file I/O: every JSON
file in `tests/inputs/json/samples` plus `json/misc/1b409.json` (14 inputs)
through 8 languages (TypeScript, Rust, Go, C#, Java, Python, Swift, C++),
112 runs per iteration, with `JSON.parse` semantics as in the JavaScript
API. "Parse" builds the `JsonInput` (`JSON.parse` and `CompressedJSON`);
"engine" is `quicktype_multi_file_sync` (inference, rewrites, naming,
rendering). Median of three interleaved rounds of 10 iterations each, after
warm-up (V8 optimizes the TypeScript during three untimed iterations); ms.

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

## Memory on large inputs

Two changes target multi-GB inputs (measured separately from the tables
above, on the same machine):

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
/usr/bin/time -l target/release/quicktype target/bench/huge.json -l ts -o out.ts
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
for bin in target/before/quicktype target/release/quicktype; do
  /usr/bin/time -l $bin target/bench/huge.json -l ts -o /dev/null
done
QUICKTYPE_INFERENCE=compressed-json target/release/quicktype ...   # the reference path, same binary
cargo bench -p quickertype --bench in_process --no-run   # prints the benchmark binary
/usr/bin/time -l <benchmark binary> --parse-only -n 30   # the parse phase's CPU time
```

## Profiling

```sh
cargo build --profile profiling -p quickertype    # release + symbols
samply record target/profiling/quicktype big.json -l ts -o out.ts
target/release/quicktype big.json -l ts -o out.ts --debug print-times
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

# Before/after: build the older commit in its own worktree and pass it.
git worktree add ../qt-before 11091954f
(cd ../qt-before && cargo build --release --bin quicktype)
cargo xtask bench --baseline ../qt-before/target/release/quicktype --corpus

# WebAssembly against TypeScript (npm/quicktype-core, after npm run build).
node --expose-gc npm/quicktype-core/test/bench/compare.mjs             # Node, warm
node npm/quicktype-core/test/bench/compare.mjs --browser               # headless Chrome
node npm/quicktype-core/test/bench/compare.mjs --browser --cold 5      # first runs
node npm/quicktype-core/test/bench/compare.mjs --variant main=../main-pkg --variant new=npm/quicktype-core
(cd npm/quicktype-core && node script/build.mjs --heap-stats)        # + __heapBytes, __heapPeak

# The in-process benchmark alone.
cargo bench -p quickertype --bench in_process -- --per-input
cargo bench -p quickertype --bench in_process --no-default-features   # system allocator
node xtask/bench/in-process.mjs ../quicktype                            # warm TypeScript
```

The in-process "before" row was measured by copying
`crates/quicktype-cli/benches/in_process.rs` (and its `[[bench]]` entry)
onto `11091954f`; it only uses the public Rust API, which has not changed.

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
