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

[Unreleased]: https://github.com/EloB/quickertype/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/EloB/quickertype/releases/tag/v0.1.0
