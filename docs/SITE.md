# The site

`site/` builds the GitHub Pages site at <https://elob.github.io/quickertype/>
into `site/dist` (`node site/build.mjs`, after `npm ci && npm run build` in
`npm/quicktype-core`), and `site/test/smoke.mjs` checks it in headless Chrome
(after `cargo build --release -p quickertype`). The Pages workflow does both
on every push to `main`.

| Path | Page | Made by |
|---|---|---|
| `/quickertype/` | The landing page | `site/landing.mjs`, `site/src/landing.html`, `landing.css`, `landing-head.js` |
| `/quickertype/app/` | The playground | `site/src/index.html`, `main.js`, `worker.js`, … |
| `/quickertype/benchmarks.html` | The benchmarks page | `site/benchmarks.mjs`, `site/src/benchmarks.html` |

The playground was the site's root until the landing page. Links shared from
it carry its state in the hash (`#v=2&l=typescript&s=pokedex`), so the
landing page's head has one inline script (`site/src/landing-head.js`) that
sends a link whose hash has a `=` on to `app/` with the same hash, before
anything paints. The landing page's own anchors never have a `=` (the build
checks). Like the playground's inline script, it is allowed by its hash
under a Content-Security-Policy (`script-src 'self' 'sha256-…'`); the build
prints both hashes, and the smoke test runs both pages under such a policy.
Apart from that script, the landing page has no JavaScript: the example's
language tabs are radio buttons styled with CSS.

## Large files in the playground

A file larger than the editor shows is posted to the workers as a `File`,
unread: the page's main thread never holds its text. quicktype's worker
reads it as text, as quicktype's API takes it; quickertype's reads its
bytes, and a JSON or JSON Lines file of 16 MiB or more (`partsFrom` in
`site/src/input-file.js`) in parts, on several workers at once:

- **Part workers.** quickertype's worker starts as many part workers as
  the machine runs at once, at most eight (`site/src/part-pool.js`), on the
  first such file, and keeps them a minute for the next one. Each
  (`site/src/part-worker.js`, a bundle of the engine's glue and
  quickertype-core's `src/native/parts.ts`, 22 KiB) instantiates the
  engine from the module quickertype's worker compiled, so it compiles
  nothing. GitHub Pages sends no COOP/COEP headers, so there is no
  `SharedArrayBuffer`: each part worker reads its ranges of the file itself
  (`file.slice`), and the workers exchange numbers and, at the end, each
  one's tallies as bytes, transferred.
- **The rules are the engine's** (quickertype-core's internal
  `src/native/parallel.ts`; [STREAMING-INFERENCE.md](STREAMING-INFERENCE.md#in-the-browser)
  has the argument): the output is what reading the file in one go gives,
  byte for byte, and wherever the parts do not read (the file is not
  JSON there) or the CLI would read in one go (not an array, no split,
  trees far larger than their text), the file is read in one go, with
  its errors. The worker remembers that for the file where the reason is
  the file's own, whatever the workers (no split, not JSON there, trees
  far larger than their text: the engine's rules say which are). Any
  other reason (part workers that did not start, which the pool
  replaces; a part too long for this many workers' memory) is tried again
  once: the next reading tries parts again, and if it fails again so, the
  file is read in one go for as long as the worker keeps it. Once it reads
  in parts, the bytes it was read in one go with are let go. The status
  under the file's name says "reading it on N workers" when it did.
- **Memory.** quickertype's engine then keeps the tallies, not a
  compressed form: for the 656 MB cards, 45 MiB instead of 1.7 GiB, and
  the part workers' instances about 35 MiB each
  ([BENCHMARKS.md](BENCHMARKS.md#reading-on-several-workers)). A run that
  goes to the TypeScript engine (the engine failed) reads the file again
  with `FileReaderSync` for the tables it needs, as far as one string holds
  it; past that, or if reading it again fails, the run fails saying the
  tables cannot be had, the input is left as it was (quickertype-core
  fills the tables only once reading them again succeeded), and the worker
  lets it go, so the next run reads the file again.
- **Sizes.** The page opens a file of up to 2 GiB (`maxFileBytes`).
  quicktype takes one whose text has up to 2^29 − 24 UTF-16 units
  (`maxTextBytes`, V8's longest string): a file with more bytes than that
  may still have that few units (UTF-8 takes one to three bytes a unit, or
  four for two), so one size check (`checkText`) refuses before reading
  only a file of more than three bytes a unit past the limit, and counts
  the rest once read: JSON's bytes in the units `TextDecoder` decodes them
  to, bytes that are not UTF-8 included (`utf16Length`), a text once
  decoded, and JSON Lines for quicktype once made their JSON array. Only a
  text that does not fit is refused: the file is too large for the
  browser, and the CLI is named; so is one larger than the browser can
  read at once (a `RangeError`), never "could not read". Chrome decodes a
  text too long for one string to "" without an error; the workers (and
  quickertype-core's own decoding) take that as too large too, so quicktype
  is never given an empty text. quickertype reads larger files in parts;
  where it must read one in one go, JSON only if its text fits one string,
  and JSON Lines (whose errors are read value by value) up to 1.25 GiB
  (`linesInOneGo`: its engine holds the bytes and their compressed form in
  4 GiB, measured in
  [BENCHMARKS.md](BENCHMARKS.md#reading-on-several-workers)); past those,
  it says the file is too large to read in one go, and why it could not be
  read in parts.

The smoke test checks all of this with test hooks the workers take in a
request (`partsFrom`, `partWorkers`, `textLimit`, `linesInOneGo`,
`partModule`, a WebAssembly module the test compiles that new part workers
start with instead of the engine, one that does not link, and
`typescript` for one run on the TypeScript engine, after which the
worker's engine is as it was), and the part worker and the pool in Node;
`{ kind: "stats" }` gives the engines' WebAssembly memory, for
`site/test/parts-bench.mjs`, which measures it, and, for the smoke test,
the engine the worker's runs are on and the bytes a file read in parts
keeps.

## Where the landing page's numbers come from

Nothing on the landing page is typed by hand. `site/landing.mjs` reads every
number at build time, and each one is in a `data-stat` element that the
smoke test checks against the same sources, counted again.

| On the page | Source |
|---|---|
| quicktype's years, commits, commits per year | `site/data/quicktype.json` (`history`), from quicktype's git history up to the commit in `tests/golden/REFERENCE` |
| quicktype's contributors and their avatars, stars | `site/data/quicktype.json` (`contributors`, `repository`), from GitHub's REST API |
| Output languages | quicktype-core's API (the build's list of languages) |
| Recorded cases, steps, and how many are identical or intended differences | `tests/golden/**/case.json`, `tests/parity-baseline.txt` and `tests/intended-differences.txt` |
| quicktype's test inputs | the files in `tests/inputs` |
| JavaScript API scenarios | `npm/quicktype-core/test/differential/scenarios.mjs` (counted, not run) |
| Round-trip fixtures, crash-fuzz targets, how often they run, CI's operating systems | `.github/workflows/roundtrip.yml`, `fuzz.yml` (checked against `fuzz/fuzz_targets`), `ci.yml` |
| Fuzz regressions, the streaming fuzzer's seeds | `tests/fuzz-regressions`, `cargo xtask streaming-fuzz`'s default (`xtask/src/streaming.rs`) |
| Rust tests | `#[test]` in `crates/` |
| CLI speed and memory, the corpus, big files (the largest input measured, and the largest quicktype was timed on too) | `site/data/benchmarks.json` and `big-inputs.json`, as the benchmarks page reads them; the input sizes in the speed section's labels are those in the benchmarks' names |
| The WebAssembly engine in Chrome | `site/data/browser.json` |
| Large files in the playground: quicktype against quickertype, the whole file quicktype cannot read, the part workers | `site/data/head-to-head.json` |
| The example at the top | generated by the build with both of quickertype-core's engines, which must agree byte for byte; the smoke test checks each output against the CLI |

The build fails rather than show a number it cannot read, and refuses
`site/data/quicktype.json` when it is not of the commit in
`tests/golden/REFERENCE`.

### The benchmark data

Every speed and memory figure on the landing page and the benchmarks page
comes from five files, which `site/benchmarks.mjs` checks before the build
writes anything, and which the build publishes beside the pages
(`data/`). Refreshing the numbers means remaking them (how each input is
made and measured: [BENCHMARKS.md](BENCHMARKS.md)):

- `site/data/benchmarks.json`: written by `cargo xtask bench --corpus
  --in-process --json site/data/benchmarks.json`; then `note` (the load
  while it ran) and, if the corpus had unexpected exits, why
  (`corpus.results.<id>.unexpected_exits_note`), by hand.
- `site/data/big-inputs.json`: large inputs, timed by hand (wall time, CPU
  time and peak RSS of each run): on all cores, the default; on one thread
  (`one_thread`, with `QUICKTYPE_READ_THREADS=1`); and quicktype's CLI where
  it was timed too (`quicktype`). `bytes` is the input's size: the pages
  show it to three significant figures, so an input has no size of its
  own to disagree with it. The landing page names the largest input and
  the largest that quicktype ran on. `reports` holds what users reported,
  which was not measured here.
- `site/data/browser.json`: the WebAssembly engine against quicktype's
  TypeScript engine, from `node --expose-gc
  npm/quicktype-core/test/bench/compare.mjs --browser --again --json`
  (warm, in headless Chrome) and `compare.mjs --cold 7 --json` (first runs
  in a fresh Node.js process), each median rounded from the raw output
  to three significant figures.
- `site/data/browser-workers.json`: the playground reading large files on
  quickertype's worker in one go and in parts on its part workers, from
  `node site/test/parts-bench.mjs --rounds 5 <files>`: the first run and
  the warm median (ms), and the WebAssembly memory (MiB). The build refuses
  an input that reads no faster in parts.
- `site/data/head-to-head.json`: quicktype against quickertype in the
  playground on large files (slices of Scryfall's card data, and the whole
  file, which quicktype refuses: `quicktype.refused` says why), each in a
  fresh headless Chrome: the first run, the median and the best of three
  warm runs (s), and the tab's peak memory (MiB); how it was measured is in
  [BENCHMARKS.md](BENCHMARKS.md#large-files-in-the-browser-quicktype-against-quickertype).
  The build refuses an input both ran where quickertype is not faster.

The README's tables are not read from these files: after a refresh, copy
the numbers into them and redraw their charts (`node
site/readme-charts.mjs`, [BENCHMARKS.md](BENCHMARKS.md#readme-charts)).

### `site/data/quicktype.json`

What the page says about quicktype comes only from primary sources, and the
file names them (`sources`):

- quicktype's git history, in a checkout at the commit the port matches:
  the first commit's date, the number of commits (merges left out), the
  commits per year;
- GitHub's REST API: `GET /repos/glideapps/quicktype` (stars, forks,
  licence, default branch, homepage), `GET /orgs/glideapps` (the owner's
  name) and `GET /repos/glideapps/quicktype/contributors` (the people GitHub
  links to commits on the default branch, with their commit counts; bots
  are left out and named).

The page states no roles (who created what): it says what the history and
the API say. To refresh the file, with a quicktype checkout and an
authenticated `gh`:

```sh
node site/quicktype-snapshot.mjs ../quicktype
```

Re-recording the golden corpus against a new quicktype commit means running
it again (the build says so).

## Charts

`site/charts.mjs` draws the site's charts, as static SVG in HTML at build
time: labels in HTML, bars in SVG placed in percent of their row, so one
drawing serves a phone and a wide screen; colours from the stylesheets, so
they follow light and dark; every drawing an image with an accessible name
and a `<title>`, every chart with its numbers in a table. The benchmarks
page and the landing page both use it.

## Type

The landing page uses Archivo (`site/src/fonts/archivo.woff2`), by the
Archivo Project Authors, under the SIL Open Font License 1.1
(`site/src/fonts/OFL.txt`). The file is the variable font from Google Fonts,
cut down with fontTools to the axes the page uses (weight 400–800, width
100–125) and to Latin-1 and common punctuation, 46 KB. The other pages use
the system's fonts.

## Images

The landing page's three section images were generated with Google Flow
(<https://flow.google.com/>, image mode, model Nano Banana Pro, 16:9), on
November 14, 2026. They are abstract: no text, logos or people. Each is in
`site/src/images` at full width and at 800 px, as WebP; the build gives
them hashed names.

| File | Size | Where | Prompt |
|---|---|---|---|
| `speed-trails.webp` (1376×768), `speed-trails-800.webp` | 19.8 KB, 7.7 KB | Along the bottom of the top of the page | Abstract long-exposure light trails in a dark indigo space: one short, bright violet streak racing ahead of a long, soft blue streak, smooth horizontal motion, subtle depth, minimal and elegant, high-end. No text, no letters, no logos, no people. |
| `thanks-threads.webp` (1200×670), `thanks-threads-800.webp` | 47.3 KB, 28.5 KB | Beside the thanks to quicktype | Abstract macro photograph of hundreds of fine luminous threads in soft blue and violet, arriving from every direction and twisting together into one strong braided cord in the center. Deep indigo background, shallow depth of field, soft studio light, elegant and minimal. No text, no letters, no logos, no people. |
| `parity-mirror.webp` (1200×670), `parity-mirror-800.webp` | 46.8 KB, 27.5 KB | Beside how parity is checked | Abstract still life of two identical translucent glass crystal lattices, mirrored exactly across a thin vertical line of light, precise geometric symmetry, cool violet and blue tones on a deep indigo background, soft studio lighting, minimal and refined. No text, no letters, no logos, no people. |

The originals were 1376×768 JPEGs, encoded with `cwebp` (quality 78, and 88
for the trails, which are mostly smooth gradient). The social preview (Open
Graph) is `docs/assets/social-preview.png`, copied into the site.
