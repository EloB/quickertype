# Changelog

All notable changes to this project are documented in this file. The
format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The version is this port's own. `quickertype --version` reports the version
of the TypeScript quicktype that the CLI reproduces, which is 24.0.0 for
every release so far; the installer shows which quickertype version is
installed (`brew list --versions quickertype`, `npm ls -g quickertype`,
`cargo install --list`, see [README.md](README.md#install)).
[docs/RELEASING.md](docs/RELEASING.md) explains how a release is cut. The
GitHub Release notes are the version's section of this file, so links in a
section are absolute.

## [Unreleased]

### Fixed

- **TypeScript input: descriptions inherited from base members as
  quicktype gives them.** A member whose own JSDoc has no text (none,
  only tags such as `@deprecated`, or an empty `/** */`) takes the
  description of the same member of the first base that has it, through
  `extends` and `implements`, along chains, for getters and setters, and
  for a constructor's parameter properties; `@inheritDoc` joins the
  base's description before the member's own. A declaration with several
  JSDoc comments takes only the last one's text. quicktype gets these
  from TypeScript 5.9; TypeScript 7 inherits only for members without any
  JSDoc and only through `extends`, so the descriptions were missing (or,
  with several comments, all of them were joined).

## [0.2.0] - 2026-11-14

Large JSON and JSON Lines files read on every core, JSON Lines input,
TypeScript input about three times as fast as quicktype's, a faster
WebAssembly engine for the JavaScript API, and the command renamed to
`quickertype` so that it installs beside quicktype.

### Added

- **JSON Lines input** (not in quicktype): one JSON value per line, read
  as the JSON array of those values, so a file of values `V1`…`Vn` gives
  exactly the code quicktype gives for `[V1,…,Vn]`, in every language and
  with every option.
  - The CLI reads files and URLs named `*.jsonl` or `*.ndjson` so (a
    URL by its path, without the query), and so does a directory: its
    `*.jsonl` and `*.ndjson` files as JSON Lines, its `.json` files as
    JSON, and a `.url` file by its URL's name. `--src-lang jsonl` reads
    every JSON input named on the command line so, standard input
    included, and directories by the names as without it. `--help`
    lists `jsonl` among the source languages.
  - With an explicit `--src-lang` other than `jsonl` (`json`, `schema`,
    ...), quickertype behaves exactly as quicktype: no input is JSON
    Lines, and directories ignore `.jsonl` and `.ndjson` files.
  - **This changes what `.jsonl` and `.ndjson` files give without
    `--src-lang`:** quicktype reads such a file as one JSON value, so a
    file with one line gave that value's type (say, an object) and now
    gives an array of it; a file with more lines was a syntax error and
    now works; and a directory, which ignored them, now reads them. Pass
    `--src-lang json` for quicktype's behavior.
  - Values are separated by line breaks (`\n` or `\r\n`); blank lines
    are skipped, the last line break is optional, a value may span lines
    (a pretty-printed one), a byte order mark may come first, and two
    values on one line are an error. A file without values is `[]`. A
    syntax error names the line its value starts on (`Syntax error in
    input JSON cards: line 3: …`).
  - quickertype-core: `JsonSample::StringLines`, `StreamLines` and
    `ReaderLines`, the JSON Lines forms of `String`, `Stream` and
    `Reader`.
  - Reading JSON Lines is as fast as reading the same values as an array,
    a large file on several threads too (below).
- quickertype-core (npm): the JSON inputs of `jsonInputForTargetLanguage`
  take a sample as its UTF-8 bytes too (a `Uint8Array` or a Node.js
  `Buffer`, e.g. `fs.readFileSync(path)`), read as the text
  `new TextDecoder().decode(bytes)` gives: without a leading byte order
  mark, with U+FFFD for what is not UTF-8. The WebAssembly engine reads
  the bytes as they are, without decoding them into a JavaScript string
  and encoding that again into its memory: in Chrome, a run on a 27 MB
  array of records takes 48 instead of 57 ms, and a 656 MB file, too large
  to be a JavaScript string, can be read.
- **The CLI reads a large JSON file on several threads:** a regular file
  of 8 MiB or more whose top-level value is an array (or standard input
  redirected from one, on Unix) is cut between its elements and read on
  every core, into the same tallies as reading it in one go, so the
  output is the same byte for byte. An array of 1 million records
  (267 MB) becomes TypeScript types about 4.6 times as fast on 12 cores
  (57 ms instead of 262 ms on an M2 Max).
  The memory the parts read beside each other take is bounded; pipes and
  smaller files are read in one go as before.
  - JSON Lines too: a JSON Lines file of 8 MiB or more (or standard
    input redirected from one with `--src-lang jsonl`) is cut between its
    lines and read so, with the output and the errors of reading it in
    one go, a bad line reported on the same line. 1 million records as
    JSON Lines (266 MB) take 54 instead of 283 ms on 12 cores, as long as
    their array takes.
  - quickertype-core: `ParallelOptions` (made from its `Default`) and
    `Readable::open_sample(options)`, which opens a file so that a large
    top-level array in it (as a `JsonSample::Reader`), or large JSON Lines
    (as a `JsonSample::ReaderLines`), is read on several threads.

### Changed

- **Breaking: the command is now `quickertype`,** not `quicktype`, so that
  it installs beside the TypeScript quicktype (homebrew-core's `quicktype`
  formula, npm's `quicktype` package). Its arguments, output files and
  messages are quicktype's as before; `--help` names the command
  `quickertype` in its synopsis and examples. To keep typing `quicktype`,
  add `alias quicktype=quickertype` to your shell's startup file; scripts,
  Makefiles and CI don't read aliases, so for them put a symlink named
  `quicktype` to `quickertype` in a directory on their `PATH`
  (`ln -s "$(command -v quickertype)" ~/.local/bin/quicktype`). The
  packages, archives and installers keep their names.

  0.1.0 installed the command as `quicktype`. Upgrading with Homebrew
  (`brew upgrade quickertype`), npm (`npm install -g quickertype`) or the
  MSI removes it. The others leave it where 0.1.0 put it:

  - the shell installer: delete `$CARGO_HOME/bin/quicktype`
    (`~/.cargo/bin/quicktype` by default);
  - the PowerShell installer: delete `%CARGO_HOME%\bin\quicktype.exe`
    (`%USERPROFILE%\.cargo\bin\quicktype.exe` by default);
  - `cargo install`: it installs the new version beside 0.1.0's
    `$CARGO_HOME/bin/quicktype` and lists both (`cargo install --list`);
    `cargo uninstall quickertype@0.1.0` deletes `quicktype` and keeps
    `quickertype`;
  - an archive from the GitHub Release: delete its `quicktype` wherever
    you put it.

  If you unlinked homebrew-core's `quicktype` for 0.1.0,
  `brew link quicktype` links it again.

- **Breaking for the Rust API:** `DateTimeRecognizer` is `Send + Sync`
  (the threads that read a large file share the recognizer). The
  built-in recognizers are; a recognizer that holds an `Rc` or a
  `RefCell` no longer compiles.

- JSON with many URIs infers faster, in the CLI and in the JavaScript
  API's WebAssembly engine: a plain URI's protocol and extension are read
  without parsing it whole, and its attributes are made only where they
  add something. On a 100 MB dump of trading cards, with 27 URIs per
  card, the CLI takes 0.20 instead of 0.40 s of CPU, and the engine in
  Chrome 0.48 instead of 0.81 s for `addSource` and a run. The engine
  also holds less while it reads a large sample: its peak on those cards
  goes from 286 to 225 MiB.
- The JavaScript API's WebAssembly engine keeps the tallies a run inferred
  an input's types from with the input's samples, so that the next run on
  the same input (another language, other options) does not walk them
  again: generating the 20 MB benchmark input a second time takes 13.9
  instead of 46.9 ms in Chrome. They count toward the engine's limit on
  the memory its inputs hold, and are dropped when a sample is added.
- quickertype-core: `JsonInput::inferred_from` (and `JsonInference`) tells
  where an input inferred its types from; `JsonInput::set_keep_tallies`
  keeps the tallies of a compressed form with it. An error while tallying
  a compressed form is reported instead of falling back to its values.
- The WebAssembly engine reads large JSON samples 7–11% faster (the 20 MB
  benchmark input: 96 instead of 103 ms in Chrome). The reader's string
  and key tables hash each string with foldhash's `write` alone, without
  the end marker that `Hash for str` adds, which costs a call and four
  multiplies in WebAssembly.
- **TypeScript input is 2.2 to 3.4 times as fast as quicktype's** (it
  was slower from about 2,000 interfaces on): 10,000 interfaces that
  refer to each other become Rust in 5.5 instead of 23 s (quicktype:
  17 s), and 10,000 interfaces shaped like an API's typings in 8.4
  instead of 25 s (quicktype: 28 s). The questions to the TypeScript 7
  compiler go out in a few pipelined batches instead of one round trip
  each (909,000 for those 10,000 interfaces; now 29 requests one at a
  time and 8 batches), answers are cached, and JSDoc that cannot exist is
  not asked for. Output is unchanged. See
  [docs/BENCHMARKS.md](https://github.com/EloB/quickertype/blob/main/docs/BENCHMARKS.md#typescript-input).
  - `QUICKTYPE_TSC_STATS=1` prints the requests to the compiler, by
    method, when a conversion ends.
- Inputs with thousands of types render faster in every language and
  input kind: four steps of the engine were quadratic in the number of
  types (expanding JSON Schema enums, checking name conflicts, taking
  named namespaces off the naming queue, and collecting declarations).
  For the schema of 10,000 TypeScript interfaces, expanding strings takes
  0.10 instead of 2.4 s, and rendering Rust 0.28 instead of 4.1 s.

### Fixed

- Partly fixed: the JavaScript API's WebAssembly engine seeded its hash
  maps the same in every instance, because WebAssembly has no randomness of
  its own, and whoever knows the seed can craft keys that collide. Now the
  JSON reader's string and key tables and the engine's other `fast_hash`
  maps take their seed from `crypto.getRandomValues`, per instance. An
  engine on a host without `crypto.getRandomValues` fails to load, with an
  error naming it. Not fixed yet: the `IndexMap`s and `IndexSet`s on
  `std`'s `RandomState` (class properties, enum and string cases,
  `JsonValue` objects) still have fixed keys in WebAssembly, so crafted
  property names can still slow inference there; a later release seeds
  them too (see
  [Hash seeds in WebAssembly](https://github.com/EloB/quickertype/blob/main/docs/BENCHMARKS.md#hash-seeds-in-webassembly)).

## [0.1.0] - 2026-11-13

The first release: the `quicktype` CLI, ported to Rust, as prebuilt binaries
and installers.

### Added

- **The `quicktype` command-line tool.** It is a port of the TypeScript
  [quicktype](https://github.com/glideapps/quicktype) 24.0.0 (commit
  `c39af7d3`) with the same flags, help text, output files, messages and
  exit codes, byte for byte. All 11,177 recorded runs of the TypeScript CLI
  in `tests/golden` match, and `cargo xtask parity` checks every change
  against them.
- **Every input:** JSON (including samples streamed from large files),
  JSON Schema, GraphQL (schema and queries, plus `--graphql-introspect`),
  Postman collections, URLs, and TypeScript. TypeScript input needs the
  TypeScript 7.0.2 native compiler, installed with
  `npm install -g typescript@7.0.2` or named by `QUICKTYPE_TSC`.
- **All 27 output languages** and their renderer options.
- **Speed:** 8 to 96 times faster than the TypeScript CLI per run, and
  46 times faster over the whole golden corpus, see
  [docs/BENCHMARKS.md](https://github.com/EloB/quickertype/blob/main/docs/BENCHMARKS.md).
  The binary uses the mimalloc allocator.
- **Releases** for macOS (Apple Silicon and Intel), Linux (x86_64 and
  aarch64 with glibc, x86_64 with musl) and Windows (x86_64), as archives
  with SHA-256 checksums, shell and PowerShell installers, a Homebrew
  formula (`brew install EloB/tap/quickertype`), an npm package
  (`npm install -g quickertype`), an MSI, and the `quickertype` crate
  (`cargo install quickertype`, with Rust 1.88 or newer). Each of these
  installs a binary named `quicktype`, which conflicts with the TypeScript
  quicktype's, see
  [docs/RELEASING.md](https://github.com/EloB/quickertype/blob/main/docs/RELEASING.md#the-quicktype-name).
- **The JavaScript API on npm** as
  [`quickertype-core`](https://www.npmjs.com/package/quickertype-core):
  quicktype's `quicktype-core` API with the engine compiled to WebAssembly,
  a drop-in replacement (change the import), for Node.js 20+ and browsers.
- **The Rust API on crates.io** as
  [`quickertype-core`](https://crates.io/crates/quickertype-core) (imported
  as `quicktype_core`), with `quickertype-js-compat`,
  `quickertype-graphql-input` and `quickertype-typescript-input`.
- **Windows** builds and tests in CI. File names on Windows follow Node's
  `path.win32`, as the TypeScript CLI's do there.

### Known issues

- Divergences from quicktype that no recorded case exercises are listed in
  [docs/PARITY.md](https://github.com/EloB/quickertype/blob/main/docs/PARITY.md#known-gaps).

[Unreleased]: https://github.com/EloB/quickertype/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/EloB/quickertype/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/EloB/quickertype/releases/tag/v0.1.0
