# Changelog

All notable changes to this project are documented in this file. The
format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The version is this port's own. `quicktype --version` reports the version
of the TypeScript quicktype that the CLI reproduces, which is 24.0.0 for
every release so far. [docs/RELEASING.md](docs/RELEASING.md) explains how a
release is cut. The GitHub Release notes are the version's section of this
file, so links in a section are absolute.

## [Unreleased]

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
  (`npm install -g quickertype`) and an MSI. Each of these installs a
  binary named `quicktype`, which conflicts with the TypeScript quicktype's,
  see [docs/RELEASING.md](https://github.com/EloB/quickertype/blob/main/docs/RELEASING.md#the-quicktype-name).

### Known issues

- Divergences from quicktype that no recorded case exercises are listed in
  [docs/PARITY.md](https://github.com/EloB/quickertype/blob/main/docs/PARITY.md#known-gaps).

[Unreleased]: https://github.com/EloB/quickertype/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/EloB/quickertype/releases/tag/v0.1.0
