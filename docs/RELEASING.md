# Releasing

Pushing a version tag such as `v0.1.0` runs
[`.github/workflows/release.yml`](../.github/workflows/release.yml), which
[dist](https://axodotdev.github.io/cargo-dist/book/) generates (version
pinned in [`dist-workspace.toml`](../dist-workspace.toml)). It builds the
`quickertype` CLI for every target and creates the GitHub Release. Then it
publishes the Homebrew formula, the `quickertype` npm installer, the crates
on crates.io ([`publish-crates.yml`](../.github/workflows/publish-crates.yml))
and the `quickertype-core` npm package
([`publish-npm-core.yml`](../.github/workflows/publish-npm-core.yml)).

## Names and versions

The project publishes under the name quickertype, so it does not collide
with quicktype's own packages:

| Directory | Package | Library (import) name |
|---|---|---|
| `crates/quicktype-cli` | `quickertype` (crates.io; binary `quicktype`) | |
| `crates/quicktype-core` | `quickertype-core` (crates.io) | `quicktype_core` |
| `crates/quicktype-js-compat` | `quickertype-js-compat` (crates.io) | `quicktype_js_compat` |
| `crates/quicktype-graphql-input` | `quickertype-graphql-input` (crates.io) | `quicktype_graphql_input` |
| `crates/quicktype-typescript-input` | `quickertype-typescript-input` (crates.io) | `quicktype_typescript_input` |
| `npm/quicktype-core` | `quickertype-core` (npm) | `require("quickertype-core")` |
| `crates/quicktype-wasm`, `xtask` | not published | |

`cargo -p` takes the package name: `cargo build -p quickertype`,
`cargo test -p quickertype-core`.

- **The project's version** is `version` in `[workspace.package]` of
  [`Cargo.toml`](../Cargo.toml), shared by every crate. It follows semver on
  its own, starting at 0.1.0, and the release tag is `v` plus it. The
  crates are released in lockstep, so two other places must match it, and
  the publish jobs fail (also on pull requests that change them) when they
  do not:
  - the four path dependencies in `[workspace.dependencies]` require
    exactly that version (`version = "=0.1.0"`). `publish-crates.yml`
    checks every member's requirement on a quickertype-\* crate, of every
    kind, and that each published crate is at the workspace version;
  - `version` in
    [`npm/quicktype-core/package.json`](../npm/quicktype-core/package.json)
    and in its `package-lock.json` (the top-level one and the root
    package's), which `publish-npm-core.yml` checks.
- **quicktype's version** is what `quicktype --version` prints
  (`quicktype version 24.0.0`): `QUICKTYPE_VERSION` in
  [`crates/quicktype-cli/src/main.rs`](../crates/quicktype-cli/src/main.rs).
  It is part of byte-for-byte parity (the `cli-version` golden cases), so it
  changes only when the corpus is re-recorded against a new quicktype
  ([ARCHITECTURE.md](ARCHITECTURE.md), section 6), never for a release.
- The WebAssembly engine's `engineVersion()` returns the project's version;
  the facade only uses it to check that a module is this engine.

## What a release publishes

| Where | What | Users install with |
|---|---|---|
| GitHub Release `vX.Y.Z` on EloB/quickertype | `quickertype-<target>.tar.xz` (`.zip` on Windows), each with a `.sha256`; `sha256.sum`; `source.tar.gz`; the installers below; `dist-manifest.json`. The notes are the version's section of [`CHANGELOG.md`](../CHANGELOG.md), the title its heading. | download and unpack |
| the same release | `quickertype-installer.sh` | `curl --proto '=https' --tlsv1.2 -LsSf https://github.com/EloB/quickertype/releases/latest/download/quickertype-installer.sh \| sh` |
| the same release | `quickertype-installer.ps1` | `powershell -ExecutionPolicy Bypass -c "irm https://github.com/EloB/quickertype/releases/latest/download/quickertype-installer.ps1 \| iex"` |
| the same release | `quickertype-x86_64-pc-windows-msvc.msi`: installs to `C:\Program Files\quickertype\bin` and adds it to `PATH` | run the MSI |
| [EloB/homebrew-tap](https://github.com/EloB/homebrew-tap) | `Formula/quickertype.rb` (macOS and Linux), committed by the release | `brew install EloB/tap/quickertype` |
| npm: [`quickertype`](https://www.npmjs.com/package/quickertype) | the CLI's installer package, which downloads the matching archive from the GitHub Release when it is installed | `npm install -g quickertype` or `npx quickertype` |
| npm: [`quickertype-core`](https://www.npmjs.com/package/quickertype-core) | quicktype's `quicktype-core` API on the WebAssembly engine, with provenance | `npm install quickertype-core` |
| crates.io: [`quickertype`](https://crates.io/crates/quickertype) and the four library crates | the sources, built by Cargo on install | `cargo install quickertype`, or `quickertype-core = "0.1"` as a dependency |

Every CLI install gives one binary, `quicktype`. The shell and PowerShell
installers and `cargo install` put it in `$CARGO_HOME/bin` (`~/.cargo/bin`
by default). Each archive holds the binary, `README.md`, `LICENSE`,
`CHANGELOG.md` and `NOTICE`; each crate and `quickertype-core` also ship
`LICENSE` and `NOTICE` (the copies in the crate directories and in
`npm/quicktype-core` must stay equal to the ones at the root).

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
prerelease and nothing else: release.yml skips every publish job for it
(dist's `publish-prereleases` is off), Homebrew, both npm packages and
crates.io alike. Turning `publish-prereleases` on would publish a
prerelease as `latest` on npm (dist's `publish-npm` job sets no dist-tag)
and as the Homebrew formula, so it stays off; `publish-npm-core.yml`
publishes as `latest` only.

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
  conflict. (`quickertype-core` is a library and has no bin.)
- **Shell, PowerShell, MSI and `cargo install`:** whichever `quicktype`
  comes first on `PATH` runs. `quicktype --version` prints the same text for
  both; `which -a quicktype` (or `where quicktype` on Windows) shows which
  is which.

## Secrets and one-time setup

Repository secrets (Settings → Secrets and variables → Actions), with
exactly these names:

- **`HOMEBREW_TAP_TOKEN`** (read by dist's `publish-homebrew-formula` job): a
  fine-grained personal access token, resource owner EloB, repository access
  only EloB/homebrew-tap, with the repository permission **Contents: Read
  and write** (Metadata: Read comes with it). A classic token with the
  `repo` scope works too. The job checks the tap out with it and pushes one
  commit per release.
- **`NPM_TOKEN`** (read by dist's `publish-npm` job for `quickertype` and by
  `publish-npm-core.yml` for `quickertype-core`): an npm granular access
  token (npm no longer issues classic "automation" tokens) with **Read and
  write** for packages (All packages until both packages exist; afterwards
  it can be narrowed to `quickertype` and `quickertype-core`) and **Bypass
  2FA**, which is off by default: without it `npm publish` fails with
  `EOTP`. A "stage only" token does not work, because the jobs run
  `npm publish`, not `npm stage publish`.
- **`CARGO_REGISTRY_TOKEN`** (read by `publish-crates.yml`): a crates.io API
  token for the first release. crates.io's trusted publishing can only be
  configured for crates that already exist, so the first publish needs a
  token:
  1. Sign in to [crates.io](https://crates.io) with the GitHub account that
     should own the crates (EloB), and verify the email address under
     Account Settings: crates.io refuses to publish without one.
  2. Account Settings → API Tokens → New Token: a name, an expiry, the
     scopes **publish-new** and **publish-update**, and the crate pattern
     **`quickertype*`**.
  3. `gh secret set CARGO_REGISTRY_TOKEN --repo EloB/quickertype` and paste
     it.

`GITHUB_TOKEN` needs nothing: release.yml asks for `contents: write` to
create the release, and the custom publish jobs for `id-token: write`.

**After the first release**, replace the long-lived tokens where the
registries allow it:

- **crates.io trusted publishing:** for each of the five crates, crates.io →
  the crate → Settings → Trusted Publishing → Add → GitHub: owner `EloB`,
  repository `quickertype`, workflow filename **`release.yml`** (crates.io
  checks the workflow that started the run, and `publish-crates.yml` runs
  as part of `release.yml`), no environment. Then delete the
  `CARGO_REGISTRY_TOKEN` secret and revoke the token: without the secret,
  `publish-crates.yml` authenticates with
  [`rust-lang/crates-io-auth-action`](https://github.com/rust-lang/crates-io-auth-action).
- **npm trusted publishing:** on npmjs.com, each package → Settings →
  Trusted Publisher → GitHub Actions: user `EloB`, repository
  `quickertype`, workflow filename **`release.yml`** (npm also checks the
  calling workflow). `publish-npm-core.yml` runs npm 11 with
  `id-token: write`, so `quickertype-core` then publishes without
  `NPM_TOKEN`. dist's generated `publish-npm` job (Node 20, no
  `id-token`) still needs the token for `quickertype`, until dist supports
  trusted publishing or that package moves to a custom publish job; only
  then can `NPM_TOKEN` be deleted.

Tokens expire: renew them before a release and run the preflight below.
npm has announced that publishing directly with a granular token ends in
January 2027 (see npm's
[About access tokens](https://docs.npmjs.com/about-access-tokens)); from
then on the npm packages need trusted publishing.

## Release preflight

Before the first tag, and whenever a token was renewed, run the
[Release preflight](../.github/workflows/release-preflight.yml) workflow. It
publishes and writes nothing:

```sh
gh workflow run release-preflight.yml        # on main; add --ref <branch> for a branch
gh run watch "$(gh run list --workflow release-preflight.yml --limit 1 --json databaseId --jq '.[0].databaseId')"
```

It checks that:

- `HOMEBREW_TAP_TOKEN` can read EloB/homebrew-tap and push to it
  (`git push --dry-run` after the same checkout the release does);
- `NPM_TOKEN` authenticates (`npm whoami`), that `quickertype` and
  `quickertype-core` are unclaimed or owned by that npm user, that packages
  with those names pass `npm publish --dry-run`, and, from npm's token
  list (found by its abbreviated form `npm_abcd...wxyz`), that it is not
  revoked, expired, read-only or stage-only, and that it bypasses 2FA (it
  warns two weeks before it expires);
- `CARGO_REGISTRY_TOKEN`, if set, authenticates with crates.io, and that
  the five crate names are unclaimed or owned by the repository owner.

Every missing permission fails with its own message. What it cannot see
without publishing: which scopes and crate pattern the crates.io token has
(check them on crates.io). It also runs on pull requests from this
repository that change it.

## Cutting a release

1. Start from a green `main`: CI, the Release workflow's plan and the
   publish dry runs (below) pass. If anything since the last release
   changed how the CLI is built or packaged (dist-workspace.toml, the
   targets, `[profile.release]`, the dist version), get a
   [full release build](#a-full-release-build-without-releasing) first.
2. On a branch, set the new version in `[workspace.package]` **and** in the
   four path dependencies of `[workspace.dependencies]` in `Cargo.toml`
   (`version = "=X.Y.Z"`), run `cargo build` to update `Cargo.lock`, and
   set it in `npm/quicktype-core` with
   `npm version X.Y.Z --no-git-tag-version` (package.json and
   package-lock.json). The branch's pull request runs the publish dry
   runs, which fail if one of them was missed.
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
   `build-global-artifacts` (installers, formula, npm installer package,
   checksums), `host` (uploads everything and creates the GitHub Release),
   then in parallel `publish-homebrew-formula`, `publish-npm`,
   `custom-publish-crates` and `custom-publish-npm-core`, then `announce`.
7. Try an install or two (`brew install EloB/tap/quickertype`,
   `npx quickertype --version`, `cargo install quickertype`).

For **0.1.0** the versions and the changelog section are already in place:
set up the secrets, run the preflight, set the date in the `## [0.1.0]`
heading to the release day if it differs, then tag `v0.1.0` (steps 4 to 7).

If a publish job fails after `host`, the GitHub Release already exists: fix
the cause (usually a token) and re-run the failed jobs
(`gh run rerun <run-id> --failed`). Every publish job skips what is already
published (a crate version on crates.io, a package version on npm), so a
re-run after a partial failure is safe. If a build fails, nothing was
published: delete the tag (`git push origin :refs/tags/vX.Y.Z` and
`git tag -d vX.Y.Z`), fix it on `main` and tag again.

## Dry runs

- **Pull requests** run:
  - the Release workflow in plan mode (`pr-run-mode = "plan"` in
    dist-workspace.toml): only `plan`, which checks the config and lists
    every artifact a release would build. The builds themselves (six
    targets and the MSI, about 13 minutes) run only for a tag, or on demand
    ([below](#a-full-release-build-without-releasing));
  - `publish-crates.yml`, when the pull request changes what the crates are
    built or packaged from (`Cargo.toml`, `Cargo.lock`, `crates/`,
    `README.md`, the toolchain, the workflow): the version checks, then
    `cargo publish --dry-run` of all five crates (each compiled from its
    `.crate`, as crates.io would);
  - `publish-npm-core.yml`, when it changes `npm/quicktype-core`, the
    engine's sources (`crates/`, `Cargo.toml`, `Cargo.lock`, the toolchain)
    or the workflow: the version checks, then everything up to
    `npm publish --dry-run` (build, tests, `npm pack --dry-run`).
- **Locally**, with dist installed (`cargo install cargo-dist --locked
  --version <cargo-dist-version>`):

  ```sh
  dist plan                     # the plan CI makes
  dist build                    # the archive for this machine, in target/distrib/
  dist generate --check         # release.yml and wix/main.wxs match the config
  cargo publish --dry-run -p quickertype-js-compat -p quickertype-core \
    -p quickertype-graphql-input -p quickertype-typescript-input -p quickertype
  (cd npm/quicktype-core && npm run build && npm test && npm pack --dry-run)
  ```

  The MSI needs Windows and the WiX v3 toolset, so only CI builds it.
- **Secrets:** the [Release preflight](#release-preflight).

### A full release build without releasing

dist 0.34 builds on pull requests only in upload mode (its
`dispatch-releases` would replace the tag trigger with a manual one, so it
is not used). To get every archive, installer and the MSI without
releasing, on a branch with an open pull request:

```sh
sed -i.bak 's/^pr-run-mode = "plan"/pr-run-mode = "upload"/' dist-workspace.toml && rm dist-workspace.toml.bak
dist generate        # upload mode also caches builds: release.yml gains a rust-cache step
git commit -am "ci: full release build (revert before merging)" && git push
```

The pull request's Release run then has `plan`, every
`build-local-artifacts` job and `build-global-artifacts`, without `host`,
the publish jobs or `announce`, and attaches the artifacts:

```sh
gh run list --workflow Release --branch <branch> --limit 1
gh run download <run-id> --name artifacts-build-local-aarch64-apple-darwin
gh run download <run-id> --name artifacts-build-global   # installers, formula, npm package
```

Revert that commit before merging (`git revert <commit>`), so that `main`
stays in plan mode; `dist generate --check` passes in both modes as long as
release.yml is regenerated with the config.

## Changing the pipeline

- `release.yml` and `crates/quicktype-cli/wix/main.wxs` are generated:
  never edit them. Change [`dist-workspace.toml`](../dist-workspace.toml)
  (workspace settings, publish jobs and their permissions) or
  `[package.metadata.dist]` in
  [`crates/quicktype-cli/Cargo.toml`](../crates/quicktype-cli/Cargo.toml)
  (formula and npm package names), then run `dist generate` and commit the
  result. CI's `dist` job fails when they are out of date
  (`dist generate --check`). `publish-crates.yml`, `publish-npm-core.yml`
  and `release-preflight.yml` are ordinary workflows; dist's release.yml
  calls the first two as custom publish jobs (with the plan as input and
  the repository's secrets).
- dist builds with `[profile.dist]`, which is exactly `release`, and with
  `precise-builds` (`cargo build --package quickertype`), so a released
  binary is the one `cargo build --release -p quickertype` makes.
- A new crate in the workspace: give it `dist = false`, the crates.io
  metadata the others have (description, keywords, categories, `include`,
  `LICENSE` and `NOTICE`), `version = "=X.Y.Z"` (the workspace version)
  on its path dependency, and add it to `CRATES` in `publish-crates.yml`
  and the preflight, after its dependencies.
- `[package.metadata.wix]`'s GUIDs identify the MSI product across
  versions: never change them.
- To upgrade dist: install the new version, run `dist init --yes` (it
  updates `cargo-dist-version` and regenerates the files), and review the
  diff and dist's release notes.
