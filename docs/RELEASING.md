# Releasing

Releases of the `quicktype` CLI are built and published by
[dist](https://axodotdev.github.io/cargo-dist/book/) (version pinned in
[`dist-workspace.toml`](../dist-workspace.toml)). Pushing a tag such as
`v0.1.0` runs [`.github/workflows/release.yml`](../.github/workflows/release.yml),
which builds every target, creates the GitHub Release and publishes the
Homebrew formula and the npm package. Only `quicktype-cli` is released; the
other crates and `npm/quicktype-core` are not.

## Versions

- **The port's version** is `version` in `[workspace.package]` of
  [`Cargo.toml`](../Cargo.toml), shared by every crate. It follows semver
  on its own, starting at 0.1.0, and the release tag is `v` plus it.
- **quicktype's version** is what `quicktype --version` prints
  (`quicktype version 24.0.0`): `QUICKTYPE_VERSION` in
  [`crates/quicktype-cli/src/main.rs`](../crates/quicktype-cli/src/main.rs).
  It is part of byte-for-byte parity (the `cli-version` golden cases), so it
  changes only when the corpus is re-recorded against a new quicktype
  ([ARCHITECTURE.md](ARCHITECTURE.md), section 6), never for a release.
- The WebAssembly engine's `engineVersion()` returns the port's version;
  [`npm/quicktype-core/package.json`](../npm/quicktype-core/package.json) is
  quicktype's own API package and keeps quicktype's version.

## What a release publishes

| Where | What | Users install with |
|---|---|---|
| GitHub Release `vX.Y.Z` on EloB/quickertype | `quicktype-cli-<target>.tar.xz` (`.zip` on Windows), each with a `.sha256`; `sha256.sum`; `source.tar.gz`; the installers below; `dist-manifest.json`. The notes are the version's section of [`CHANGELOG.md`](../CHANGELOG.md), the title its heading. | download and unpack |
| the same release | `quicktype-cli-installer.sh` | `curl --proto '=https' --tlsv1.2 -LsSf https://github.com/EloB/quickertype/releases/latest/download/quicktype-cli-installer.sh \| sh` |
| the same release | `quicktype-cli-installer.ps1` | `powershell -ExecutionPolicy Bypass -c "irm https://github.com/EloB/quickertype/releases/latest/download/quicktype-cli-installer.ps1 \| iex"` |
| the same release | `quicktype-cli-x86_64-pc-windows-msvc.msi`: installs to `C:\Program Files\quicktype-cli\bin` and adds it to `PATH` | run the MSI |
| [EloB/homebrew-tap](https://github.com/EloB/homebrew-tap) | `Formula/quickertype.rb` (macOS and Linux), committed by the release | `brew install EloB/tap/quickertype` |
| [npm](https://www.npmjs.com/package/quickertype) | the package `quickertype`, which downloads the matching archive from the GitHub Release when it is installed | `npm install -g quickertype` or `npx quickertype` |

Every one of them installs one binary, `quicktype`. The shell and
PowerShell installers put it in `$CARGO_HOME/bin` (`~/.cargo/bin` by
default). Each archive holds the binary, `README.md`, `LICENSE`,
`CHANGELOG.md` and `NOTICE`.

Targets (`targets` in `dist-workspace.toml`):

| Target | Runner | Notes |
|---|---|---|
| `aarch64-apple-darwin` | macOS, Apple Silicon | |
| `x86_64-apple-darwin` | macOS, Intel | |
| `x86_64-unknown-linux-gnu` | Ubuntu 22.04 | glibc 2.35 |
| `aarch64-unknown-linux-gnu` | Ubuntu 22.04 on Arm | glibc 2.35 |
| `x86_64-unknown-linux-musl` | Ubuntu 22.04 | static; the shell installer picks it on musl systems (Alpine) and where glibc is older than 2.35 |
| `x86_64-pc-windows-msvc` | Windows Server 2022 | also the MSI |

A version with a prerelease suffix (`v0.2.0-rc.1`) makes a GitHub
prerelease and skips Homebrew and npm.

## The `quicktype` name

The binary is called `quicktype`, like the TypeScript quicktype's, so that
this CLI is a drop-in replacement. Installed side by side, the two collide:

- **Homebrew:** homebrew-core's `quicktype` formula links the same
  `bin/quicktype`. dist's formula template (0.34.0) cannot declare
  `conflicts_with`, so Homebrew installs `quickertype` but refuses to link
  it ("Could not symlink bin/quicktype"). Use one at a time:
  `brew uninstall quicktype` (or `brew unlink quicktype`), then
  `brew link quickertype`.
- **npm:** the `quicktype` package's bin is also `quicktype`.
  `npm install -g quickertype` then fails with `EEXIST`; uninstall the other
  one first (`npm uninstall -g quicktype`). npm has no way to declare the
  conflict.
- **Shell, PowerShell and MSI installs:** whichever `quicktype` comes first
  on `PATH` runs. `quicktype --version` prints the same text for both;
  `which -a quicktype` (or `where quicktype` on Windows) shows which is
  which.

## Secrets

Set once, in the repository's Settings → Secrets and variables → Actions,
with exactly these names (release.yml reads `secrets.HOMEBREW_TAP_TOKEN` and
`secrets.NPM_TOKEN`):

- **`HOMEBREW_TAP_TOKEN`**: a fine-grained personal access token, resource
  owner EloB, repository access only EloB/homebrew-tap, with the repository
  permission **Contents: Read and write** (Metadata: Read comes with it). A
  classic token with the `repo` scope works too. The
  `publish-homebrew-formula` job checks the tap out with it and pushes one
  commit per release.
- **`NPM_TOKEN`**: an npm granular access token (npm no longer issues
  classic "automation" tokens) with **Read and write** for packages (All
  packages until `quickertype` exists; it can be narrowed to `quickertype`
  after the first publish) and **Bypass 2FA**, which is off by default:
  without it, the `publish-npm` job's `npm publish` fails with `EOTP`. A
  "stage only" token does not work: dist's job runs `npm publish`, not
  `npm stage publish`.

Tokens expire: renew them before a release and run the preflight below.
npm has announced that publishing directly with a granular token ends in
January 2027 (see npm's
[About access tokens](https://docs.npmjs.com/about-access-tokens)); by then
the npm job needs trusted publishing or staged publishing, which dist 0.34.0
does not generate, so check dist's changelog for support before that.

`GITHUB_TOKEN` needs nothing: release.yml asks for `contents: write` to
create the release.

## Release preflight

Before the first tag, and whenever a token was renewed, run the
[Release preflight](../.github/workflows/release-preflight.yml) workflow. It
publishes and writes nothing:

```sh
gh workflow run release-preflight.yml        # on main; add --ref <branch> for a branch
gh run watch "$(gh run list --workflow release-preflight.yml --limit 1 --json databaseId --jq '.[0].databaseId')"
```

It checks that `HOMEBREW_TAP_TOKEN` can read EloB/homebrew-tap and push to
it (`git push --dry-run` after the same checkout the release does), and
that `NPM_TOKEN` authenticates (`npm whoami`), that `quickertype` is
unclaimed or owned by that npm user, that a package of that name passes
`npm publish --dry-run`, and, where npm lists the token, that it is not
read-only. Every missing permission fails with its own message. What it
cannot see is whether the npm token bypasses 2FA: check that on npmjs.com.
It also runs on pull requests from this repository that change it.

## Cutting a release

1. Start from a green `main`: CI and the Release workflow's pull-request
   builds (below) pass.
2. On a branch, set the new `version` in `[workspace.package]` of
   `Cargo.toml` and run `cargo build` to update `Cargo.lock`.
3. In `CHANGELOG.md`, move what is under `## [Unreleased]` into a new
   `## [X.Y.Z] - YYYY-MM-DD` section (the release date) and update the link
   definitions at the bottom. The version in the heading must equal the
   Cargo version: dist looks the section up by it for the release notes.
   Links in a section must be absolute (they end up in the GitHub Release).
4. Check what dist will do:

   ```sh
   dist plan                                   # "announcing vX.Y.Z" and every artifact
   dist manifest --tag vX.Y.Z --artifacts=all --no-local-paths --output-format=json \
     | jq -r .announcement_title,.announcement_changelog   # the release title and notes
   ```

5. Merge the branch (CONTRIBUTING.md), then tag the merge on `main` and
   push the tag:

   ```sh
   git switch main && git pull
   git tag vX.Y.Z
   git push origin vX.Y.Z
   ```

6. Follow the Release workflow (`gh run watch`). Its jobs: `plan`,
   `build-local-artifacts` (one per target, the MSI on Windows),
   `build-global-artifacts` (installers, formula, npm package, checksums),
   `host` (uploads everything and creates the GitHub Release),
   `publish-homebrew-formula` and `publish-npm`, then `announce`.
7. Try an install or two (`brew install EloB/tap/quickertype`,
   `npx quickertype --version`).

For **0.1.0** the version and the changelog section are already in place:
set the date in the `## [0.1.0]` heading to the release day if it differs,
run the preflight, then tag `v0.1.0` (steps 4 to 7).

If a publish job fails after `host`, the GitHub Release already exists: fix
the cause (usually a token) and re-run the failed jobs
(`gh run rerun <run-id> --failed`). If a build fails, nothing was
published: delete the tag (`git push origin :refs/tags/vX.Y.Z` and
`git tag -d vX.Y.Z`), fix it on `main` and tag again.

## Dry runs

- **Every pull request** runs the Release workflow in upload mode
  (`pr-run-mode = "upload"`): `plan`, all `build-local-artifacts` jobs
  (the MSI included) and `build-global-artifacts`, without `host`, the
  publish jobs or `announce`. The artifacts are attached to the run:

  ```sh
  gh run list --workflow Release --branch <branch> --limit 1
  gh run download <run-id> --name artifacts-build-local-aarch64-apple-darwin
  gh run download <run-id> --name artifacts-build-global   # installers, formula, npm package
  ```

- **Locally**, with dist installed (`cargo install cargo-dist --locked
  --version <cargo-dist-version>`):

  ```sh
  dist plan                     # the plan CI makes
  dist build                    # the archive for this machine, in target/distrib/
  dist generate --check         # release.yml and wix/main.wxs match the config
  ```

  The MSI needs Windows and the WiX v3 toolset, so only CI builds it.
- **Secrets:** the [Release preflight](#release-preflight).

## Changing the pipeline

- `release.yml` and `crates/quicktype-cli/wix/main.wxs` are generated:
  never edit them. Change [`dist-workspace.toml`](../dist-workspace.toml)
  (workspace settings) or `[package.metadata.dist]` in
  [`crates/quicktype-cli/Cargo.toml`](../crates/quicktype-cli/Cargo.toml)
  (formula and npm package names), then run `dist generate` and commit the
  result. CI's `dist` job fails when they are out of date
  (`dist generate --check`).
- dist builds with `[profile.dist]`, which is exactly `release`, and with
  `precise-builds` (`cargo build --package quicktype-cli`), so a released
  binary is the one `cargo build --release -p quicktype-cli` makes.
- `[package.metadata.wix]`'s GUIDs identify the MSI product across
  versions: never change them.
- To upgrade dist: install the new version, run `dist init --yes` (it
  updates `cargo-dist-version` and regenerates the files), and review the
  diff and dist's release notes.
