# Releasing

Pushing a version tag such as `v0.1.0` runs
[`.github/workflows/release.yml`](../.github/workflows/release.yml), which
[dist](https://axodotdev.github.io/cargo-dist/book/) generates (version
pinned in [`dist-workspace.toml`](../dist-workspace.toml)). It builds the
`quickertype` CLI for every target, packs it with the TypeScript compiler
([below](#the-bundled-typescript-compiler)) and creates the GitHub Release.
Then it publishes the Homebrew formula, the `quickertype` npm installer, the
crates on crates.io
([`publish-crates.yml`](../.github/workflows/publish-crates.yml)) and the
`quickertype-core` npm package
([`publish-npm-core.yml`](../.github/workflows/publish-npm-core.yml)).

## Names and versions

The project publishes under the name quickertype, so it does not collide
with quicktype's own packages:

| Directory | Package | Library (import) name |
|---|---|---|
| `crates/quicktype-cli` | `quickertype` (crates.io; binary `quickertype`) | |
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
- **quicktype's version** is what `quickertype --version` prints
  (`quicktype version 24.0.0`): `QUICKTYPE_VERSION` in
  [`crates/quicktype-cli/src/main.rs`](../crates/quicktype-cli/src/main.rs).
  It is part of byte-for-byte parity (the `cli-version` golden cases), so it
  changes only when the corpus is re-recorded against a new quicktype
  ([ARCHITECTURE.md](ARCHITECTURE.md), section 6), never for a release.
  For the same reason the CLI has no option that prints its own version (an
  option quicktype does not know is an error, as in quicktype).
- **The installed quickertype version** is known to whatever installed it:

  | Installed with | Shows the version |
  |---|---|
  | Homebrew | `brew list --versions quickertype` (or `brew info quickertype`) |
  | npm | `npm ls -g quickertype` |
  | Cargo | `cargo install --list` (`quickertype v0.1.0:`) |
  | shell installer | `jq -r .version ~/.config/quickertype/quickertype-receipt.json` (`$XDG_CONFIG_HOME/quickertype/` if that is set) |
  | PowerShell installer | `version` in `%LOCALAPPDATA%\quickertype\quickertype-receipt.json` |
  | MSI | Settings → Apps → Installed apps, or `winget list quickertype` |
  | an archive | the GitHub Release it came from |

  dist's installers write that receipt (`version` is the release's) unless
  `QUICKERTYPE_DISABLE_UPDATE` or `QUICKERTYPE_UNMANAGED_INSTALL` is set;
  `install-updater = false` only leaves out the updater binary.
- The WebAssembly engine's `engineVersion()` returns the project's version;
  the facade only uses it to check that a module is this engine.

## What a release publishes

| Where | What | Users install with |
|---|---|---|
| GitHub Release `vX.Y.Z` on EloB/quickertype | `quickertype-<target>.tar.xz` (`.zip` on Windows) with the TypeScript compiler for the target, each with a `.sha256`; `sha256.sum`; `source.tar.gz`; the installers below; `dist-manifest.json`. The notes are the version's section of [`CHANGELOG.md`](../CHANGELOG.md), the title its heading. | download and unpack |
| the same release | `quickertype-installer.sh` | `curl --proto '=https' --tlsv1.2 -LsSf https://github.com/EloB/quickertype/releases/latest/download/quickertype-installer.sh \| sh` |
| the same release | `quickertype-installer.ps1` | `powershell -ExecutionPolicy Bypass -c "irm https://github.com/EloB/quickertype/releases/latest/download/quickertype-installer.ps1 \| iex"` |
| the same release | `quickertype-x86_64-pc-windows-msvc.msi`: installs to `C:\Program Files\quickertype\bin` (the compiler in `bin\typescript`) and adds it to `PATH` | run the MSI |
| [EloB/homebrew-tap](https://github.com/EloB/homebrew-tap) | `Formula/quickertype.rb` (macOS and Linux), committed by the release: installs an archive, the compiler into `share/quickertype` | `brew install EloB/tap/quickertype` |
| npm: [`quickertype`](https://www.npmjs.com/package/quickertype) | the CLI's installer package, which downloads the matching archive from the GitHub Release when it is installed and unpacks all of it, the compiler too | `npm install -g quickertype` or `npx quickertype` |
| npm: [`quickertype-core`](https://www.npmjs.com/package/quickertype-core) | quicktype's `quicktype-core` API on the WebAssembly engine, with provenance | `npm install quickertype-core` |
| crates.io: [`quickertype`](https://crates.io/crates/quickertype) and the four library crates | the sources, built by Cargo on install | `cargo install quickertype`, or `quickertype-core = "0.2"` as a dependency |

Every CLI install gives one binary, `quickertype`. The shell and PowerShell
installers and `cargo install` put it in `$CARGO_HOME/bin` (`~/.cargo/bin`
by default). Each archive holds the binary, `README.md`, `LICENSE`,
`CHANGELOG.md`, `NOTICE` and `typescript/`, the TypeScript compiler; each
crate and `quickertype-core` also ship `LICENSE` and `NOTICE` (the copies in
the crate directories must stay equal to the ones at the root, and so must
`npm/quicktype-core`'s `LICENSE`; its `NOTICE` is its own).

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

## The bundled TypeScript compiler

TypeScript input needs the TypeScript 7 native compiler of exactly the
version the `tsc --api` client was generated for (`TSC_VERSION` in
[`crates/quicktype-typescript-input/src/tsc/generated.rs`](../crates/quicktype-typescript-input/src/tsc/generated.rs)).
A release ships Microsoft's, unmodified: the npm platform package
`@typescript/typescript-<os>-<arch>` (the Go `tsc` binary, the `lib.*.d.ts`
files, `LICENSE`, `NOTICE.txt`, `README.md` and `package.json`) as the
`typescript` directory of every archive, next to `quickertype`, with
[`release/typescript/pins.json`](../release/typescript/pins.json) beside it.
The Linux packages' binaries are static, so the musl archive takes the same
package as the glibc one.

| Target | Package |
|---|---|
| `aarch64-apple-darwin` | `darwin-arm64` |
| `x86_64-apple-darwin` | `darwin-x64` |
| `aarch64-unknown-linux-gnu` | `linux-arm64` |
| `x86_64-unknown-linux-gnu`, `x86_64-unknown-linux-musl` | `linux-x64` |
| `x86_64-pc-windows-msvc` | `win32-x64` |

It adds about 7 MB to each `.tar.xz` (the `aarch64-apple-darwin` archive
of 0.2.0 grows from 2.8 to 9.6 MB) and about 9.5 MB to the Windows `.zip`.

How each install gets it, and where quickertype finds it
([`locate.rs`](../crates/quicktype-typescript-input/src/tsc/locate.rs):
`QUICKTYPE_TSC`, then the bundled compiler, then `node_modules` and `PATH`):

| Install | The compiler |
|---|---|
| an archive | `typescript/` next to `quickertype` |
| MSI | `C:\Program Files\quickertype\bin\typescript` |
| Homebrew | `share/quickertype/typescript` in the keg: the formula installs the binary into `bin` and what else the archive has into `pkgshare`; quickertype finds it from its real path, through Homebrew's `bin` link |
| npm | the archive, unpacked whole into `node_modules/quickertype/node_modules/.bin_real` |
| shell and PowerShell installers | not installed: they install only the archive's binaries (dist 0.34 has no setting to install more) |
| `cargo install` | not installed: a crate cannot carry it (crates.io's 10 MB limit) |

Without a compiler, TypeScript input fails with an error that names the
command and the platform package to install (`npm install -g
typescript@7.0.2`, which installs `@typescript/typescript-<os>-<arch>`).

How the release does it, with dist 0.34, whose `include` is the same for
every archive (and the npm installer package):

- `include` in [`dist-workspace.toml`](../dist-workspace.toml) has
  `release/typescript`, where git tracks only `pins.json`. So `dist build`
  packs whatever is staged there, and an archive built without staging has
  `typescript/pins.json` alone: the release gate (below) is what stops such
  a release.
- [`.github/build-setup.yml`](../.github/build-setup.yml) (dist's
  `github-build-setup`, which release.yml runs in every
  `build-local-artifacts` job before `dist build`) runs the action
  [`.github/actions/stage-typescript`](../.github/actions/stage-typescript/action.yml)
  with the job's target, which runs
  [`release/bundle-typescript.mjs --run`](../release/bundle-typescript.mjs).
  It downloads the target's package from registry.npmjs.org, checks it
  against its pinned `dist.integrity` (sha512), name, version and compiler
  hash (`tscSha256`, the SHA-256 of `lib/tsc`), runs `tsc --version`, and
  unpacks it into `release/typescript`. A mismatch, or a compiler that does
  not run, fails the job.
- Every build job runs its own target's compiler, natively: no target is
  cross-built.

  | Target | Runner | Runs |
  |---|---|---|
  | `aarch64-apple-darwin` | `macos-15` (Apple Silicon) | `darwin-arm64` |
  | `x86_64-apple-darwin` | `macos-15-intel` | `darwin-x64` |
  | `aarch64-unknown-linux-gnu` | `ubuntu-22.04-arm` | `linux-arm64` |
  | `x86_64-unknown-linux-gnu`, `x86_64-unknown-linux-musl` | `ubuntu-22.04` | `linux-x64` |
  | `x86_64-pc-windows-msvc` | `windows-2022` | `win32-x64` |

  Locally the script also runs another architecture of the machine's OS
  where the OS can (Rosetta runs `darwin-x64` on Apple Silicon); a package
  it cannot run (another OS) is checked against its hash only, unless
  `--run` is given.
- **The release gate,**
  [`.github/workflows/check-release.yml`](../.github/workflows/check-release.yml),
  is a custom job of dist's `global-artifacts-jobs`: it runs after every
  `build-local-artifacts` job, and `host`, which creates the GitHub Release
  before any publish job runs, waits for it and runs only if it passed. It
  downloads what the build jobs uploaded and checks each of the six
  archives and the MSI once. Each must have `typescript/lib/tsc`
  (`tsc.exe` for Windows) with the pinned SHA-256, executable (checked
  for the non-Windows archives, on its Ubuntu runner), the pinned
  package's `package.json`, its LICENSE and NOTICE.txt, and `pins.json`
  equal to the repository's, and a LICENSE and a NOTICE that attributes
  TypeScript (the checks of
  [`release/check-release.mjs`](../release/check-release.mjs), with the
  shared [`release/package.mjs`](../release/package.mjs), which also
  unpacks zips itself). The two Linux x86_64 archives (on Ubuntu) and the
  MSI and the zip (on Windows; the MSI unpacked with `msiexec /a`) are
  checked by [`release/check-bundle.mjs`](../release/check-bundle.mjs),
  which then converts a TypeScript file with each, with no other compiler
  around; `check-release.mjs` checks the other three archives.
- The `build-global-artifacts` job has no build setup, so the npm
  installer package that it builds gets `typescript/pins.json` alone (the
  installer unpacks the archive for the platform at install time).
- The MSI: when it stages a Windows package, the script also writes
  `crates/quicktype-cli/wix/bundled.wxs` (not committed), a WiX fragment
  with a component for each file of the staged directory under `bin`, and
  for quickertype's `LICENSE` and `NOTICE` in the install directory
  (`C:\Program Files\quickertype`; dist's MSI has neither otherwise).
  cargo-wix compiles every `.wxs` in `wix/`, and `main.wxs` references the
  fragment's `BundledFiles` component group. That one line is ours, so
  dist-workspace.toml has `allow-dirty = ["msi"]`, and CI's `dist` job
  checks that `main.wxs` without it is what dist renders.

quickertype does not run the bundled compiler to ask its version: it uses
it only if `typescript/package.json` names this platform's package at the
pinned version, `typescript/pins.json` is beside it and (but on Windows)
`lib/tsc` is executable, so a stray `typescript/lib/tsc` next to a binary
is not run, and one without its execute bits is passed over for
`node_modules` and `PATH`. Other compilers (`QUICKTYPE_TSC`,
`node_modules`, `PATH`) must print the pinned version. If the chosen
compiler cannot be started because the system refuses it, the error names
its path and the fix (`chmod +x`, the platform's package, or
`QUICKTYPE_TSC`).

CI's `release-bundle` job builds the archive for its runner the same way
(the same action, then `dist build`), runs the gate's check on it, and runs
`release/check-bundle.mjs`: the archive's quickertype must convert
`release/check-bundle/person.ts` to exactly `person.expected.rs` (what the
TypeScript quicktype prints) with no other compiler on `PATH` or in
`node_modules`, unpacked and in Homebrew's layout, and without the
compiler it must fail with the error above.

### Bumping the TypeScript version

1. Pin the new release's packages:

   ```sh
   npm view typescript@X.Y.Z optionalDependencies   # still a package for every target?
   node release/bundle-typescript.mjs --pin X.Y.Z
   ```

   This rewrites [`release/typescript/pins.json`](../release/typescript/pins.json):
   for each package, the registry's tarball URL and `dist.integrity`,
   checked against the tarball it downloads, and the SHA-256 of the
   compiler in it. The packages and their targets stay; edit those by hand
   if TypeScript adds or drops a platform.
2. Regenerate the protocol tables, which set `TSC_VERSION`:
   `node xtask/typescript-input/gen-tables.mjs <quicktype checkout>`, with
   `typescript@X.Y.Z` in the checkout's `node_modules`
   (`crates/quicktype-typescript-input/src/tsc/generated.rs`).
3. Update the other places that name the version: the `typescript-input`
   job in `.github/workflows/ci.yml` and both jobs in `roundtrip.yml`,
   `README.md`, and the tests that spell it out (`locate.rs`,
   `crates/quicktype-cli/tests/cli.rs`): `git grep -n 7\.0\.2`.
4. Rerun the TypeScript corpus with the new compiler and review what
   changed (`crates/quicktype-typescript-input/tests/known-differences.txt`):

   ```sh
   node release/bundle-typescript.mjs           # the new package for this machine
   QUICKTYPE_TSC=$PWD/release/typescript/lib/tsc \
     cargo test -p quickertype-typescript-input --lib --test differential
   cargo test -p quickertype-typescript-input --lib locate   # pins.json pins TSC_VERSION
   ```

5. Check an archive ([Dry runs](#dry-runs)), and on the pull request get a
   [full release build](#a-full-release-build-without-releasing), which
   builds the MSI and runs the release gate.

## The `quicktype` name

The command is `quickertype` (`[[bin]]` in
[`crates/quicktype-cli/Cargo.toml`](../crates/quicktype-cli/Cargo.toml)),
not `quicktype`, so that it installs beside the TypeScript quicktype:
homebrew-core's `quicktype` formula and the `quicktype` npm package both
install a `quicktype` command, which Homebrew refuses to link twice and npm
refuses with `EEXIST`. For a drop-in replacement,
`alias quicktype=quickertype` covers an interactive shell, and a
`quicktype` symlink to it on `PATH` covers scripts, Makefiles and CI too.
dist's `bin-aliases` could install that symlink, but it would bring the
conflicts back, so it is not set.

0.1.0 installed the command as `quicktype`. Upgrading with Homebrew, npm or
the MSI removes that binary; the shell and PowerShell installers and
`cargo install` leave it where 0.1.0 put it
([CHANGELOG.md](../CHANGELOG.md) says where). Cargo (1.99, checked with
installs from one source path into a scratch root) removes a binary that a
package no longer has only when the new version replaces one of the old
version's binaries, which `quickertype` does not: `cargo install` adds the
new version beside `quickertype v0.1.0` and lists both, and
`cargo uninstall quickertype@0.1.0` deletes `quicktype` alone. Reinstalling
the same version with the new name (from a checkout, say) lists both
binaries under that version instead, and uninstalling it deletes both.

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
   checksums), `custom-check-release` (the release gate for the bundled
   TypeScript compiler), `host` (uploads everything and creates the GitHub
   Release; it runs only if the gate passed),
   then in parallel `publish-homebrew-formula`, `publish-npm`,
   `custom-publish-crates` and `custom-publish-npm-core`, then `announce`.
7. Check that every registry has X.Y.Z, then install it once or twice and
   check the installed version with the installer's own tool
   ([above](#names-and-versions)), and that TypeScript input works without
   another compiler (`printf 'export interface A { b: string }\n' > a.ts
   && quickertype a.ts -l rust`). `quickertype --version` cannot tell: it
   prints quicktype's version, 24.0.0, for every release.

   ```sh
   gh release view vX.Y.Z                      # the notes and every asset
   npm view quickertype version                # X.Y.Z
   npm view quickertype-core version           # X.Y.Z
   cargo search quickertype --limit 5          # all five crates = "X.Y.Z"
   brew update && brew info EloB/tap/quickertype   # stable X.Y.Z
   brew install EloB/tap/quickertype && brew list --versions quickertype   # quickertype X.Y.Z
   npm install -g quickertype@X.Y.Z && npm ls -g quickertype               # quickertype@X.Y.Z
   cargo install quickertype --version X.Y.Z && cargo install --list       # quickertype vX.Y.Z:
   ```

For **0.1.0** the versions and the changelog section are already in place:
set up the secrets, run the preflight, set the date in the `## [0.1.0]`
heading to the release day if it differs, then tag `v0.1.0` (steps 4 to 7).

If a publish job fails after `host`, the GitHub Release already exists: fix
the cause (usually a token) and re-run the failed jobs
(`gh run rerun <run-id> --failed`). Every publish job skips what is already
published (a crate version on crates.io, a package version on npm), so a
re-run after a partial failure is safe. If a build or the release gate
fails, nothing was published: delete the tag (`git push origin :refs/tags/vX.Y.Z` and
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
  node release/bundle-typescript.mjs    # the TypeScript compiler for this machine
  dist build                    # the archive for this machine, in target/distrib/
  node release/check-release.mjs target/distrib <target>   # the release gate's check
  node release/check-bundle.mjs target/distrib/quickertype-<target>.tar.xz
  dist generate --check         # release.yml matches the config
  cargo publish --dry-run -p quickertype-js-compat -p quickertype-core \
    -p quickertype-graphql-input -p quickertype-typescript-input -p quickertype
  (cd npm/quicktype-core && npm run build && npm test && npm pack --dry-run)
  ```

  Without the staging step, `dist build` packs an archive with
  `typescript/pins.json` alone, which the gate's check rejects. The MSI
  needs Windows and the WiX v3 toolset (and `node
  release/bundle-typescript.mjs` there first, which writes the WiX
  fragment), so only CI builds it.
- **Secrets:** the [Release preflight](#release-preflight).

### A full release build without releasing

dist 0.34 builds on pull requests only in upload mode (its
`dispatch-releases` would replace the tag trigger with a manual one, so it
is not used). This is the only way to build the MSI and to run the release
gate (`custom-check-release`) before a tag. On a branch whose pull request
is open, from the repository root, with the pinned dist installed:

```sh
git switch <branch> && git pull
sed -i.bak 's/^pr-run-mode = "plan"/pr-run-mode = "upload"/' dist-workspace.toml && rm dist-workspace.toml.bak
dist generate                 # release.yml for upload mode (it gains a rust-cache step)
git diff --stat               # dist-workspace.toml and .github/workflows/release.yml only
git commit -am "ci: full release build (revert before merging)" && git push
```

The push starts the pull request's Release run: `plan`, every
`build-local-artifacts` job (the six targets and the MSI, about 15
minutes), `build-global-artifacts` and `custom-check-release` (the gate:
`archives` on Ubuntu, `windows` with the MSI), without `host`, the publish
jobs or `announce`. Follow it and fetch what it built:

```sh
run=$(gh run list --workflow Release --branch <branch> --limit 1 --json databaseId --jq '.[0].databaseId')
gh run watch "$run"
gh run view "$run"                       # every job, the gate's two included, must pass
gh run download "$run" --name artifacts-build-local-x86_64-pc-windows-msvc   # the MSI and the zip
gh run download "$run" --name artifacts-build-local-aarch64-apple-darwin
gh run download "$run" --name artifacts-build-global   # installers, formula, npm package
```

Then revert the commit and push, so that the branch, and `main` after the
merge, stays in plan mode (`git revert --no-edit <commit> && git push`);
`dist generate --check` passes in both modes as long as release.yml is
regenerated with the config.

## Changing the pipeline

- `release.yml` and `crates/quicktype-cli/wix/main.wxs` are generated:
  never edit them, except for the one line of `main.wxs` that references
  the bundled files (`BundledFiles`; `allow-dirty = ["msi"]` makes
  `dist generate` leave the file alone). To regenerate `main.wxs`, delete
  that line and the `allow-dirty` setting, run `dist generate`, and put
  both back. The build setup steps are in `.github/build-setup.yml`
  (`dist generate` copies them into release.yml) and call
  `.github/actions/stage-typescript`, which CI's `release-bundle` job calls
  too; the release gate is `.github/workflows/check-release.yml`, an
  ordinary reusable workflow that release.yml calls. Change [`dist-workspace.toml`](../dist-workspace.toml)
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
