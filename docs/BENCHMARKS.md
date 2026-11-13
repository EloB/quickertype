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
  the CLI and the WASM bindings. Worth doing as its own change.

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
text-heavy file. Next steps, not done here:

1. Keep one copy of repeated attribute sets in the union accumulators
   where combining them is idempotent (string types without cases, URI
   attributes): up to the 2–3 GB above.
2. Object entries of 12 bytes (the key is always an interned string): a
   further 0.5 GiB on the record file.
3. Streaming type inference (inferring while parsing), a separate
   decision.

To reproduce: build the 2.6 GB file from the benchmark's generated input
and measure with `/usr/bin/time -l` (delete the file afterwards):

```sh
cargo xtask bench --no-ref --filter "generated (40" -n 1   # writes target/bench/generated-large.json
python3 -c 'd = open("target/bench/generated-large.json", "rb").read().rstrip()
open("target/bench/huge.json", "wb").write(b"[" + b",\n".join([d] * 60) + b"]")'
/usr/bin/time -l target/release/quicktype target/bench/huge.json -l ts -o out.ts
rm target/bench/huge.json
```

## Profiling

```sh
cargo build --profile profiling -p quicktype-cli    # release + symbols
samply record target/profiling/quicktype big.json -l ts -o out.ts
target/release/quicktype big.json -l ts -o out.ts --debug print-times
cargo build --profile profiling -p quicktype-cli --bench in_process
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

The JS API's engine is `crates/quicktype-wasm` behind `npm/quicktype-core`:
the facade parses JSON samples and builds `CompressedJSON` **in
JavaScript**, encodes its tables, and hands one request per run to the
engine (inference, rewrites, naming, rendering). Before this phase it ran
about as fast as warm TypeScript in process (660 runs: 1.56 s vs 1.53 s).

Native measurements of the same split (in-process table above) say why:

- The **engine** was the cost, not the boundary. Natively, inference to
  rendering took 221 ms for the 112 runs where warm TypeScript takes
  298 ms (1.35×); WebAssembly typically runs 1.3–2× slower than native
  code, so the old engine could at best match TypeScript. The facade's own
  share (V8's `JSON.parse` plus `CompressedJSON`, 72 of TypeScript's
  369 ms here) is the same with either engine.
- Everything in quicktype-core and quicktype-js-compat above **ports to
  WebAssembly unchanged**: the naming fix, pluralize, foldhash, the JSON
  reader fixes (for `JsonSample::String`), the category table, name-style
  memoization, `gatherNames`, `expandStrings`. With the system allocator
  the native engine phase drops from 221 to 138 ms (1.6×), i.e. 2.2×
  faster than warm TypeScript; with the same WebAssembly overhead as
  before, the WASM engine should now be clearly ahead of TypeScript.
- **Not portable**: mimalloc (native only), and the precomputed Markov
  chain (deliberately: on `wasm32` the chain is decoded once per instance,
  which a long-lived instance amortizes, and the module stays 268 KB
  smaller).

What to try on the WebAssembly side (not changed here: the WASM crate and
the facade were on `feat/wasm-js-api` when this branch started):

1. **The allocator.** mimalloc made the native engine 1.35× faster in
   process (and the CLI 1.1–1.4×); `wasm32-unknown-unknown` uses Rust's
   built-in dlmalloc port. A faster WASM allocator (e.g. `talc`), or a
   bump arena reset after each run (a run's allocations all die with it),
   is likely the biggest single win.
2. **`wasm-opt -O3`** on the module: `npm/quicktype-core/script/build.mjs`
   runs `cargo build` and `wasm-bindgen` but not Binaryen; `wasm-opt -O3`
   usually gains 10–20% speed (and size).
3. **`bulk-memory`**: `memmove`/`memcpy` are ~9% of native time; make sure
   the build uses `memory.copy`/`memory.fill` (`-C
   target-feature=+bulk-memory` if the toolchain's default does not
   include it).
4. **Fewer copies at the boundary**: strings travel as one UTF-8 blob plus
   UTF-16 lengths and are split into `String`s; the CompressedJSON string
   table could be split lazily, and the result lines could be returned as
   one joined string instead of an array of strings.

## Reproducing

```sh
# The TypeScript CLI: a built quicktype checkout beside the workspace
# (or set QUICKTYPE_REF), as for `cargo xtask diff`.
cargo xtask bench                     # CLI benchmarks, 10 runs each
cargo xtask bench --corpus            # + the whole golden corpus
cargo xtask bench --in-process        # + the engine in process vs warm TypeScript
cargo xtask bench --filter json -n 20 # a subset, more runs
cargo xtask bench --no-ref            # without the TypeScript CLI
cargo xtask bench --out report.md     # also write the Markdown table

# Before/after: build the older commit in its own worktree and pass it.
git worktree add ../qt-before 11091954f
(cd ../qt-before && cargo build --release -p quicktype-cli)
cargo xtask bench --baseline ../qt-before/target/release/quicktype --corpus

# The in-process benchmark alone.
cargo bench -p quicktype-cli --bench in_process -- --per-input
cargo bench -p quicktype-cli --bench in_process --no-default-features   # system allocator
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
