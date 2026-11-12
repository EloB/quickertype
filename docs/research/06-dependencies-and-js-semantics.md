# 06 — Third-party dependencies and JavaScript-semantics hazards

Scope: every npm runtime dependency of `quicktype-core`, the CLI (`src/`) and the input packages, plus a codebase-wide
inventory of places where JavaScript semantics leak into output. Reference: quicktype @ `c39af7d3`. All claims marked
**[exp]** were confirmed by running node / Rust experiments (scripts in the session scratchpad; the results are quoted
here).

## 0. Summary

* Only **seven** dependencies affect generated output: `collection-utils`, `pluralize`, `unicode-properties`, `urijs`,
  `wordwrap`, `lodash` (one call), `yaml` (schema fallback). `stream-json` affects how CLI JSON is tokenised
  (duplicate keys, number classification). The rest are CLI/IO plumbing.
* `collection-utils` is **not** hash-ordered. `setUnion`/`mapMerge` & co. are plain JS `Set`/`Map` (insertion order).
  Hashes (`hashCodeOf`) only feed `EqualityMap`, whose iteration order is also first-insertion order regardless of
  collisions **[exp]**. `IndexMap`/`IndexSet` plus `Hash`/`Eq` consistent with `areEqual` reproduce it. Do not port
  the hash function for ordering reasons.
* The output-relevant JS hazards, by size:
  1. **Object-as-map key order + `__proto__`.** It happens in `JSON.parse` / `YAML.parse` results (schema input,
     JS-API JSON input) and in objects built for JSON Schema output. 306 test input files have integer-like keys.
  2. **UTF-16 string semantics.** Covers `.length`, alignment widths, `s[0].toUpperCase()`, code-unit prefix/suffix
     slicing, `\uXXXX` escaping of astral characters, and lone surrogates, which Rust `String` cannot hold.
  3. **Number formatting and parsing.** `1e+21`, `1e-7`, `-0`→`0`, `1e400`→`Infinity`→`null`,
     `12345678901234567890`→`12345678901234567000`, and `1.0` is an integer on the API path but a double on the CLI
     path.
  4. **Sorting.** UTF-16 order, stability, and one inconsistent comparator (mixed number/string keys) whose result
     depends on V8's TimSort. Rust ≥1.81 `sort_by` may panic on such comparators.
  5. **Mixed Unicode versions.** `unicode-properties` is **Unicode 12.0** (with unassigned → `"Cc"`), while JS case
     mapping, `normalize`, `/u` regexes and `\s` use ICU (Node 24.16 = **Unicode 17.0**).
* Environment facts **[exp]**: Node v24.16.0 (ICU 78.3, Unicode 17.0, CLDR 48); `.nvmrc` says v24.6.0. Rust 1.99.1 has
  `char::UNICODE_VERSION = 17.0.0`. `regex-syntax` 0.8.10 uses UCD 16.0.0; `unicode-normalization` 0.1.25 uses 17.0.0.
  **Action:** record the Node version used for the golden corpus in `tests/golden/REFERENCE`. Today it holds only the
  commit hash.

## 1. Dependency inventory

Installed versions (root `node_modules`, `pluralize` nested under `packages/quicktype-core/node_modules`):

| package | ver | license | used by | output-relevant? | Rust recommendation |
|---|---|---|---|---|---|
| collection-utils | 1.0.1 | Apache-2.0 | core (37 files), gql | yes (order) | `indexmap` + small hand-written helpers |
| pluralize | 8.0.0 | MIT | core (2 files) | yes (names) | **hand port** (rule tables) |
| unicode-properties | 1.4.1 (+unicode-trie 2.0.0) | MIT | core (7 files) | yes (legal chars, word split) | **generated table** from the npm package |
| urijs | 1.19.11 (bundled punycode 1.3.2) | MIT | core (2 files) | yes (schema refs, `qt-uri-*`) | **hand port** of the used subset |
| wordwrap | 1.0.0 | MIT | core + CLI | yes (comments) | hand port (40 lines) |
| lodash | 4.18.1 | MIT | CLI + PhpRenderer | yes (`_.pad`) | trivial inline ports |
| yaml | 2.9.0 | ISC | core `parseJSON` fallback | yes (YAML/sloppy-JSON schemas) | `saphyr-parser` events + own core-schema resolver |
| is-url | 1.2.4 | MIT | core NodeIO | no (URL vs file) | 3 regexes, hand port |
| stream-json | 3.5.0 | BSD-3-Clause | CLI JSON input | yes (dups, number class) | own iterative tokenizer |
| readable-stream | 4.5.2 | MIT | core IO, CLI | no | `std::io` |
| string-to-stream | 3.0.1 | MIT | CLI | no | n/a |
| browser-or-node | 3.0.0 | MIT | core NodeIO (`isNode`) | no | `cfg(target_arch="wasm32")` |
| command-line-args | 5.2.1 | MIT | CLI | CLI parsing/errors | **hand port** (not `clap`) |
| command-line-usage | 7.0.1 (table-layout 3.0.2, wordwrapjs 5.1.0, chalk-template 0.4.0) | MIT | CLI `--help` | help text | hand port + snapshot |
| chalk | 4.1.2 (supports-color 7) | MIT | CLI | only on TTY | port supports-color decision + `anstyle` |
| graphql | 16.14.2 | MIT | gql input, CLI | yes (query AST) | `graphql-parser` (or `apollo-parser`) |
| @glideapps/ts-necessities | 2.2.3 | MIT | CLI, NodeIO | no | inline |
| moment | 2.30.1 | MIT | root `package.json` only | **unused**: no import anywhere | drop |
| typescript 5.9.3, typescript-json-schema 0.67.4 | | Apache-2.0/BSD | typescript-input | not in corpus (0 cases) | separate decision (needs a TS front end) |

Golden corpus src-lang mix **[exp]**: json 7096, schema 2874, graphql 162, typescript 0. 9,970 of 10,132 cases pass `--debug
provenance`, which only *checks* provenance; `ProvenanceTypeAttributeKind.stringify`'s numeric default sort is
debug-only.

### 1.1 collection-utils 1.0.1 (`node_modules/collection-utils/dist/index.js`, 583 lines)

Call counts (identifier uses excluding imports, `funcName:uses/files`): `iterableSome 43/15, iterableFirst 35/22,
addHashCode 29/5, arrayIntercalate 27/16, mapMap 26/14, setFilter 24/11, setUnionInto 22/10, hashCodeOf 22/4,
definedMap 21/7, setMap 20/10, areEqual 18/5, iterableFind 14/6, setUnion 13/7, withDefault 10/6, mapFromObject 9/6,
mapFilter 8/5, mapContains 8/3, iterableEvery 7/5, EqualityMap 7/4, mapFilterMap 6/3, setUnionManyInto 6/5,
setIntersect 5/4, setSortBy 5/3, hashString 5/4, mapSortBy 5/3, mapUpdateInto 4/3, setSubtract 4/4, mapMergeInto 4/3,
mapFirst 4/4, mapSome 4/4, mapMergeWithInto 3/3, arrayMapSync 3/2`, then 1–2 uses each of `mapMapEntries iterableMax
setFilterMap mapFromIterable hashCodeInit iterableEnumerate mapSortByKey toReadonlySet setGroupBy arraySortByInto
iterableReduce setIsSuperset arrayGetFromEnd arrayLast mapMapSync toReadonlyArray mapTranspose iterableSkip mapMerge
mapFind mapSortToArray iterableMinBy definedMapWithDefault hasOwnProperty`.

Semantics that matter:
* **All set/map ops are insertion-ordered native `Set`/`Map`.** `setUnion(a,b)` = a's order, then b's new elements.
  `mapMerge(ma,mb)`: an existing key keeps its position and takes mb's value; new keys are appended **[exp]**
  (`mapMerge([[b,1],[a,2]],[[c,3],[b,4]])` → `b:4,a:2,c:3`). `setSubtract` uses `delete`. In Rust use
  `IndexSet::shift_remove`, never `swap_remove` (and not `IndexMap::remove`, which is the deprecated alias of
  `swap_remove`).
* `arraySortByInto` / `mapSortBy` / `mapSortByKey` / `setSortBy` / `mapSortToArray` = `arr.sort((a,b)=> sa<sb?-1:
  sa>sb?1:0)`. Stable (V8 TimSort). Uses JS `<` on keys: strings compare as UTF-16 code units, numbers numerically,
  and **mixed string/number goes through `ToNumber(string)`**, where NaN makes both comparisons false and the result
  0. See §2.3.
* `iterableMinBy` (Naming.ts:510) and `_.minBy` return the **first** minimum (strict `<`). `iterableMax`
  (Source.ts:234) returns the first maximum.
* `mapFromObject(obj)` = `Object.getOwnPropertyNames` order, so integer-like keys come first (§2.6). Callers:
  JSONSchemaInput.ts:832 (properties), :1503 (definitions as top levels), AccessorNames.ts:238/244,
  Description.ts:139, TransformedStringType.ts:52, quicktype-graphql-input index.ts:616/638.
* `EqualityMap`: `Map<int32 hash, [k,v]>` with linear probing (`h+1|0`). `values()` yields in first-insertion order,
  and `set` on an existing key updates in place. Colliding keys (`hashString("Aa")===hashString("BB")===2112`) still
  iterate in insertion order **[exp]**. Users: TypeBuilder.ts:283 (`_typeForIdentity`), TypeUtils.ts:104
  (`makeGroupsToFlatten`, iterated), GraphRewriting.ts:633, JSONSchemaInput.ts:500/808. `has(k)` is
  `get(k)!==undefined`. Rust: `IndexMap<K,V>` with `Hash`/`Eq` consistent with `areEqual`.
* `areEqual`: `===`, then `.equals()`, then Set (order-insensitive, element `has`), Map (order-insensitive keys,
  `areEqual` values), Array (ordered). `hashCodeOf`: number→`x|0`; string→Java hash over UTF-16 units (`(h<<5)-h+c
  |0`); Set = **sum** (order-insensitive); Map = `addHashCode(sumKeys, sumValues)`; Array = ordered `acc*31+h |0`.
  Hash values never reach output. Port them only if you want identical perf characteristics. Their sole correctness
  role is "equal ⇒ same hash".
* `arrayIntercalate`, `definedMap`, `withDefault` and friends are trivial combinators.

**Recommendation:** no crate. Add a `support/collections.rs` with the ~25 used combinators over `IndexMap`/`IndexSet`,
plus `sort_by_key_js` from `js_compat`. Apache-2.0, same as the port.

### 1.2 pluralize 8.0.0 (MIT): **hand port**

Calls: `pluralize.singular` only, at 3 sites: TypeNames.ts:21 (inside `singularizeName`, which first special-cases
`/cookies$/i` → `slice(0,-1)`), GatherNames.ts:175 and :186 (`setMap(names, pluralize.singular)`, **without** the
cookies workaround, so `cookies`→`cooky` there). Runtime tables **[exp]**: 33 plural rules, **31 singular rules** (21
regexes plus the 10 regex uncountables, `[re,'$0']`), 94 uncountable words, 43 irregular plurals.

Algorithm to reproduce exactly (pluralize.js lines 1–200):
1. `token = word.toLowerCase()` (JS full lowercase).
2. If `irregularSingles` has own `token` (a singular word), return `restoreCase(word, token)`. If `irregularPlurals`
   has own `token`, return `restoreCase(word, irregularPlurals[token])`.
3. `sanitizeWord`: if `token` is empty or an uncountable word, return `word`. Otherwise iterate rules **from last
   added to first**. The first rule whose regex `test(word)` matches wins: `word.replace(re, fn)`. The regex is
   non-global, so only the first match is replaced. `$n` in the replacement is interpolated from the replacer
   `arguments` (missing → `''`). For an empty match the case source is `word[index-1]`.
4. `restoreCase(word, token)`: exact → token; all-lower → lower; all-upper → upper; `word[0]===word[0].toUpperCase()`
   → `token.charAt(0).toUpperCase() + token.substr(1).toLowerCase()`; else lower. Digits count as "upper"
   (`"1items"`→`"1item"`). UTF-16 indexing throughout.

Observed **[exp]**: `cookies→cooky, Cookies→Cooky, People→Person, data→datum, statuses→status, analyses→analysis,
axes→axe, iTems→iTem, ITEMS→ITEM, Mice→Mouse, media→media, leaves→leaf, movies→movie, s→"", Ies→Y, $refs→$ref,
straßen→straßen`.

Regex translation: the rules use `/i` without `u`, `\b`, `[^\w]` and `/pok[eé]mon$/i`.
* Use `(?i-u:...)` for ASCII parts. Plain `(?i)` also matches `ſ`(U+017F) for `s` and `K`(U+212A) for `k` **[exp]:
  `(?i)cookies$` matches "cooKieſ", `(?i-u)` does not**. JS non-`u` `/i` never folds non-ASCII to ASCII.
* `\b` → `(?-u:\b)` (compiles on `&str` regexes **[exp]**).
* `[^\w]` → `[^0-9A-Za-z_]`. `(?-u:[^\w])` is rejected ("can match invalid UTF-8") **[exp]**.
* `[eé]` under `/i` → `[eEéÉ]`.

Avoid the `pluralizer` crate. Its rule order and case restoration are not verified against 8.0.0. Parity test: run
node `pluralize.singular` over every property name and type name in the corpus inputs and diff.

### 1.3 unicode-properties 1.4.1 (MIT; data = **Unicode 12.0.0**)

Direct calls (18): `getCategory` ×10, `isAlphabetic` ×2, `isLowerCase` ×2, `isUpperCase` ×2, `isWhiteSpace` ×1,
`isDigit` ×1.
* support/Strings.ts:233 (`isPrintable`, BMP only), :266 `isLetter` (Lu/Ll/Lt/Lo; **not Lm**), :272 `isDigit` (Nd),
  :277 `isNumeric`, :301 `trimEnd` (`isWhiteSpace` on **charCodeAt**: only Zs/Zl/Zp, so tab and newline are *not*
  trimmed), :361–367 (`fastIsLowerCase`/`fastIsUpperCase`/`fastNonLetter` for word splitting).
* language utils that pass **UTF-16 code units** (surrogate halves → `"Cs"`): Python/utils.ts:15/22,
  Elixir/utils.ts:43, CSharp/utils.ts:101 (`isAlphabetic`) /:109, Objective-C/utils.ts:73/77, Ruby/utils.ts:46.
* Smithy4s/utils.ts:1/35 imports `isDigit` straight from `unicode-properties`.

Semantics **[exp]**:
* `getCategory` returns one of 29 strings. **`"Cn"` does not exist.** Unassigned code points, anything new after 12.0
  (U+0870, U+1FAD0, U+32FF Reiwa = 12.1), negative values and values ≥0x110000 all return `"Cc"`.
* `isAlphabetic` is category-based (L* ∪ Nl), not the Unicode `Alphabetic` property.
* `isWhiteSpace` = Zs|Zl|Zp.

The whole table is 3,823 category runs. **Recommendation:** an `xtask` that dumps `getCategory(cp)` for 0..0x10FFFF
from the npm package into a static run table (`&[(u32 start, Gc)]` with binary search), plus a test that re-dumps and
diffs. Do **not** use `unicode-general-category` or std, which are Unicode 16/17 and use `Cn`. Data is MIT (Unicode
data license applies to the UCD).

Python additionally does `String.fromCharCode(unit).normalize("NFKC")` (Python/utils.ts:27/38), so the predicate
combines NFKC (Unicode 17 via ICU) with categories (Unicode 12). Precompute the two Python predicates
`isStartCharacter3`/`isPartCharacter3` for all 65,536 code units from node into bitsets (8 KB each).
`unicode-normalization` 0.1.25 is Unicode 17 and would also do, but the bitset is exact by construction.

### 1.4 urijs 1.19.11 (MIT): **hand port of the used subset**

Used in JSONSchemaInput.ts (`new URI`, `URI.decode`, `.clone .normalize .toString .fragment(get/set) .host .filename
.suffix .path(get/set) .hash(set) .absoluteTo .equals`, 22 `toString` calls) and URIAttributes.ts (`URI(s).path()`,
`.protocol()`).

Output-relevant behaviour:
* **URI inference** (URIAttributes.ts:76) runs on every JSON string matching `/^(https?|ftp):\/\/[^{}]+$/`
  (StringTypes.ts:232). It parses with urijs, takes `protocol().toLowerCase()` and the extension of `path()` via
  `/^.+(\.[^./\\]+)$/` (lowercased). The results go into `qt-uri-protocols` / `qt-uri-extensions`, sorted (UTF-16), in
  schema output. Parse quirks **[exp]**:
  * `http://example.com` has path `/`.
  * `\` is converted to `/` (`http://x/a\b.jpg` → `/a/b.jpg`), and tabs are stripped (`a.jp\tg` → `/a.jpg`).
  * Query and fragment are excluded (`http://x?q=a.png` → `/`).
  * The `;params` suffix is kept in the path.
  * Invalid hostnames are accepted (`a b`, `ex_ample.com`, `-x`).
  * **Invalid ports throw** `TypeError: Port "99999" is not a valid port`, as does `[::1` (`Port "::1"`). quicktype
    catches the error and drops the URI attributes for that value.
* **`normalizeURI`** = `new URI(URI.decode(uri.clone().normalize().toString()))`.
  * `normalize` lowercases scheme and host, IDN-encodes the host via punycode 1.3.2 `toASCII` (`bücher.example` →
    `xn--bcher-kva.example`), drops the default port, and resolves `.`/`..`.
  * `URI.decode` is **`decodeURIComponent`**, which throws `URIError: URI malformed` on `100%.json` or `a%zz.json`
    **[exp]**. `percent-encoding`'s lenient decode would differ, so port strict UTF-8 percent-decoding with an error.
  * `C:/x/y.json` is parsed as scheme `c:`. `fixWindowsPath` runs first.
* `absoluteTo` follows RFC 3986-ish urijs rules **[exp]**: `../d.json` against `http://ex.com/a/b/c.json` →
  `http://ex.com/a/d.json`; `#/x` against it → `…/c.json#/x`; `d.json` against `a/b.json` → `a/d.json`.
* `filename("x/y.schema.json")`=`y.schema.json`, `suffix`=`json`, and `filename()` of a bare host is `""`.

The `url` crate (WHATWG) differs (e.g. it percent-encodes spaces and rejects relative references), and
`fluent-uri`/`iri-string` are strict RFC 3986. Port `URI.parse`, `build`, `normalize*`, `absoluteTo`, `filename`,
`suffix`, `equals` and `ensureValidPort` (~600 lines). For punycode use `idna::punycode::encode_str` per non-ASCII
label: urijs uses plain punycode.js `toASCII`, which does no UTS-46 mapping, so do **not** use
`idna::domain_to_ascii`.

### 1.5 wordwrap 1.0.0 (MIT): hand port

`_wordwrap(90)` is used at ConvenienceRenderer.ts:79/106 (all description comments) and src/index.ts:73/1098 (Postman
description). Soft mode:
1. `text.split(/(\S+\s+)/)`: JS split **keeps capture groups**.
2. Reduce: skip `''`. Replace `\t` with 4 spaces. If `line.length + chunk.length > 90` (UTF-16 lengths), first strip
   `/\s+$/` from the current line, then push each `\n`-piece of the chunk with `/^\s+/` stripped. Else, if the chunk
   has `\n`, append the first piece and push the rest stripped. Else append.

`\s`/`\S` are **JS whitespace**: they include U+FEFF and NBSP but not U+0085. `\u00a0` therefore creates break
opportunities **[exp]**. Before wrapping, ConvenienceRenderer replaces `/\r\n?|[\u0085\u2028\u2029]/g` with `\n` and
applies `.trim()` (JS trim). Afterwards it splits on `\n` and applies `.trim()` per line.

### 1.6 lodash 4.18.1 (MIT)

8 calls. Output-relevant: **`_.pad(\`${1 + (idx % 31)}\`, 2, "0")`** (PhpRenderer.ts:989). lodash pads `floor(gap/2)`
on the left and `ceil(gap/2)` on the right, so `"5"` → **`"50"`** **[exp]**. The golden PHP output contains
`2020-12-20T12:20:20` (25×) and `2020-12-10T12:10:10` (8×). The other calls are CLI only: `_.endsWith` (index.ts:328),
`_.minBy` (:389, first minimum), `_.concat` (:725, :809), `_.lowerFirst`/`_.upperFirst` (:785/786, ASCII option
names), `_.includes`/`_.isEmpty` (:883/884).

### 1.7 yaml 2.9.0 (ISC)

Single call: support/ParseJSON.ts:20. `parseJSON` strips one leading U+FEFF, tries `JSON.parse`, then falls back to
`YAML.parse(text)` with default options (YAML 1.2, core schema, `uniqueKeys:true`, `intAsBigInt:false`). It applies to
every schema, URL-grammar and Postman file. Observed **[exp]**:
* `{"a":1,}` (trailing comma) **succeeds** via YAML.
* `0x1F`→31, `0o17`→15, `010`→10, `.inf`→Infinity (→`null` if re-stringified), `~`→null, `yes`→"yes".
* Integer-like keys reorder because the result is a JS object.
* Duplicate keys throw `YAMLParseError: Map keys must be unique`. Note that `JSON.parse` accepts duplicates and is
  tried first.
* Collection keys are stringified with a stderr warning.
* A malformed schema surfaces as `Could not fetch schema #, referred to from bad.schema#.` (the parse error is
  swallowed upstream).

**Recommendation:** use the `saphyr-parser` (or `yaml-rust2`) event stream, which reports scalar style, and implement
eemeli/yaml's core-schema resolution yourself:
* null: `null|Null|NULL|~|empty`
* bool: `true|True|TRUE|false|…`
* int: `[-+]?[0-9]+`, `0o[0-7]+`, `0x[0-9a-fA-F]+`
* float: `.inf/.nan` variants and decimal floats
* quoted scalars are strings

Build into the same `JsValue` as JSON (§3). Error text is not corpus-relevant: the corpus has no YAML inputs.

### 1.8 stream-json 3.5.0 (BSD-3-Clause), readable-stream, string-to-stream

The CLI's JSON path (src/CompressedJSONFromStream.ts) uses `parser.asStream({packKeys:true, packStrings:true})`
events. Semantics **[exp]**:
* **Document order. Duplicate keys are emitted twice**, and quicktype merges them: `{"zeta":1,…,"zeta":"dup"}` →
  `zeta: number | string` at the first position.
* Number literal text arrives as `numberChunk`s. A number is a **double iff its text contains `.`/`e`/`E`**
  (CompressedJSONFromStream.ts:62) or its integer text does not fit the target language's integer range (`-0` is an
  integer).
* Strings: `\ud800` (lone surrogate) passes through unchanged. Raw control characters are rejected ("escaped
  characters").
* Strict grammar: **a BOM is rejected** (`expected a value`), as are `01`, `.5`, `[1,]`, `{}{}` (`unexpected
  characters`) and comments.
* No depth limit.
* Errors surface as `Error: Syntax error in input JSON <name>: Parser cannot parse input: <reason>`. Reasons seen:
  `expected a value`, `unexpected characters`, `unexpected token ']'`, `escaped characters`, `expected a starting
  digit`; for a bad exponent the message is `Parser has expected an exponent value of a number`.
* Input is decoded with `setEncoding("utf8")`: invalid bytes become U+FFFD per maximal subpart, the same policy as
  `String::from_utf8_lossy`.

The **JS API path** (`CompressedJSONFromString`, CompressedJSON.ts:366) instead uses `JSON.parse` +
`Object.getOwnPropertyNames`. That means integer-like keys come first and **duplicates collapse to last value at first
position** **[exp]**. It classifies numbers with `parsedNumberIsDouble`: `n !== Math.floor(n)`, `|n| >= 1e21`, or
`n.toFixed(0)` out of range. So **`1.0` is an integer on the API path and a double on the CLI path.** Rust needs both
front ends behind one `CompressedJson` builder.

**Recommendation:** a hand-written iterative tokenizer (~400 lines) that emits the same events, keeps number text,
allows lone-surrogate escapes, and copies the error strings. serde_json is unsuitable here (§2.7). `readable-stream`,
`string-to-stream` and `browser-or-node` map to `std::io::Read` and `cfg`.

### 1.9 command-line-args 5.2.1, command-line-usage 7.0.1, chalk 4.1.2 (all MIT)

* `commandLineArgs(defs, {argv, partial})` (src/index.ts:746). Definitions use `alias`(7), `multiple`(3),
  `defaultOption`(1), `defaultValue`, `type` Boolean|String. Errors are wrapped as `Option parsing failed:
  <e.toString()>`. **[exp]** `UNKNOWN_OPTION: Unknown option: --foo.` and `Missing value for command line option
  "lang".` (sic). `clap` cannot reproduce its argv grammar (`--x=v`, `-abc` groups, default option, `partial` →
  `_unknown`) or its messages, so hand-port its parser (~300 lines).
* `getUsage(sections)` (index.ts:815): table-layout with `maxWidth: 80`, option/description columns of width 60
  (index.ts:616), and wordwrapjs. It does not read the terminal width, so `--help` is deterministic (339 lines, no
  ANSI when piped) **[exp]**. Hand-port the layout and snapshot-test the full `--help`.
* chalk (index.ts:640–689, :1252) colours only when supports-color says so: TTY, `FORCE_COLOR`, `TERM=dumb`, CI
  variables, and **`--color`/`--no-color` in `process.argv`**. command-line-usage bundles its own copy
  (index.cjs:1430). Port the decision and emit SGR codes with `anstyle`.

### 1.10 graphql 16.14.2 (MIT)

Used for `graphql.parse(queryString)` (quicktype-graphql-input index.ts:208), `Kind.*` constants (15 uses) and
`getIntrospectionQuery()` (src/GraphQLIntrospection.ts:44, the body of the network request). Only the AST matters:
definitions, selections, aliases, fragments, inline fragments, type conditions, list and non-null wrappers.
`graphql-parser` 0.4 (MIT/Apache) provides it. `apollo-parser` is lossless and better at errors. Error messages differ
from graphql-js (`Syntax Error: Expected Name, found <EOF>.`); the corpus has none. Embed the exact
`getIntrospectionQuery()` string from 16.14.2.

The schema JSON is a JS object map: `this.types[t.name]` (index.ts:482) and `_fragments[def.name.value]`
(index.ts:216). A type named `__proto__` would be dropped (§2.6).

### 1.11 @glideapps/ts-necessities 2.2.3, is-url 1.2.4, moment

* `defined`, `exceptionToString` (`e.toString()` with fallbacks): inline.
* is-url: `^(?:\w+:)?\/\/(\S+)$`, then `^localhost[\:?\d]*(?:[^\:?\d]\S*)?$` or `^[^\s\.]+\.\S{2,}$`. Translate
  `\w`→`[0-9A-Za-z_]`, `\d`→`[0-9]`, and `\s`/`\S`→the JS whitespace class (§2.5).
* moment: listed in the root `package.json` but **never imported**. Do not port.

## 2. JS-semantics hazard inventory (`packages/quicktype-core/src` + `src/`)

Raw counts (core / cli+gql):
* strings: `.length` 292/23, `.charCodeAt` 22/0, `.codePointAt` 5/0, `String.fromCharCode` 11/0, `.slice` 43/4,
  `.toUpperCase` 10/0, `.toLowerCase` 21/2, `.trim` 5/2, `.padStart` 2/0
* matching: `.split` 21/4, `.replace` 30/2, `.test` 20/1, `.exec` 10/1, regex literals 67 total
* ordering: `.sort` 14/0, `localeCompare` 1/0
* JSON: `JSON.stringify` 12/5 (6 output-relevant), `JSON.parse` 14/0
* numbers: `toFixed` 4, `parseInt` 7, `parseFloat` 2
* other: `Math.random` 2, `Object.getOwnPropertyNames` 10/3, `Object.keys/entries/values` 14/1
* not used anywhere: `substring`, `substr`, `localeUpper/Lower`, `Intl`, `BigInt`, `for…in`, `replaceAll`, `matchAll`

### 2.1 Number → string

Output reaches the renderers through:
* `String(n)` (17 sites; e.g. TypeScriptZodRenderer.ts:138/139, CPlusPlusRenderer.ts:1001/1215–1235,
  JavaScriptPropTypesRenderer.ts:128–178)
* `.toString()` (e.g. JSONPythonRenderer.ts:1126–1134, NewtonSoftCSharpRenderer.ts:1038–1066,
  SystemTextJsonCSharpRenderer.ts:1164–1192, TypeScriptEffectSchema:241/243)
* template literals (Elm 242–264, Pike 337, CJSON 2487–2514, C++ 1559/1563, Elixir)
* `JSON.stringify` (schema output)

The values are JSON Schema `minimum`/`maximum`/lengths/items: arbitrary doubles. Confirmed outputs **[exp]**:
`z.number().min(1e+21).max(1.5e+300)`, `.max(1e-7)`, `-0`→`.min(0)`, `123456789012345678901`→`123456789012345680000`,
`0.30000000000000004`, `-5e-324`. Rust `{}` gives `1000000000000000000000`, `0.0000001` and `-0` **[exp]**.

* **Rule:** every f64 printed must go through `js_compat::number_to_string`. It is ECMAScript `Number::toString(10)`:
  shortest round-trip digits; `k≤n≤21` → integer with zeros; `0<n≤21` → fixed; `-6<n≤0` → `0.000ddd`; else `d.ddde±x`;
  `-0`→`"0"`; `NaN`; `Infinity`.
* Implementation: the **`ryu-js`** crate (Boa's, spec-conformant), or ~30 lines over `ryu` 1.0 digits. The latter
  version was differential-tested: **0 mismatches on 349,878 doubles** (random bit patterns + decimal fractions + edge
  cases) **[exp]**.
* Radix: `intToHex` (Strings.ts:184, `i.toString(16)`, lowercase) and octal escapes `b.toString(8).padStart(3,"0")`
  (CJSONRenderer.ts:73, ObjectiveCRenderer.ts:70). These are always non-negative integers, so use `format!("{:x}")` /
  `{:o}`.
* Integer counters (`level.toString()` ×346 in CJSON, `suffixNumber`, indices) are safe integers; `{}` is fine.

### 2.2 Number parsing and arithmetic

* JSON numbers must become **f64 at parse time, correctly rounded**.
  * serde_json without `float_roundtrip` is not always correctly rounded.
  * It keeps `12345678901234567890` as u64 (JS gives `…67000`).
  * It errors on `1e400` (JS gives `Infinity`, stringified as `null`).
  * It prints `1.0` as `1.0`.
  * It has a recursion limit of 128 **[exp]**.

  Use our own parser with `str::parse::<f64>` (correctly rounded).
* `n.toFixed(0)` (CompressedJSON.ts:115) runs on integral |n|<1e21. Rust `format!("{:.0}")` is exact for these but
  gives `"-0"` for `-0.0`, so normalise. General `toFixed` rounds half **up** on the exact decimal
  (`(2.5).toFixed(0)="3"`), while Rust rounds half to even (`"2"`). Only Run.ts:210/223 (debug timings) use other
  digit counts.
* `Number.parseInt(s,10)` (StringTypes.ts:219, after `/^(0|-?[1-9]\d*)$/`) is compared against `1<<31` (= -2147483648
  in JS) and `2147483647`. JSONSchemaInput.ts:362 does the same for array indices.
* **`Number.parseFloat` prefix semantics** (Scala3/utils.ts:29, Smithy4s/utils.ts:25/Smithy4sRenderer.ts:346): leading
  JS whitespace is skipped, the longest numeric prefix is taken, and **`"Infinity…"` parses as Infinity**. So property
  `InfinityWar` gets back-ticked in Scala 3 while `Infinit` does not **[exp]**. `.5x`→0.5. `parseInt(charAt(0))` is
  the digit test.
* **`**` / pow**: MarkovChain.ts:298/324 (`probability ** (1/len)`) and InferMaps.ts:64 (`product ** (1/n)`) decide
  map vs class inference. Differential test on 300k inputs **[exp]**: Rust `f64::powf` (system libm) **0 mismatches**
  vs V8 on macOS. The `libm` crate (FreeBSD e_pow.c) **22,136 mismatches (7.4%)**. So use `powf` and never `libm`.
  Caveat: wasm32 `powf` lowers to compiler-builtins libm, so the WASM build can differ from Node in borderline
  map/class decisions. `Math.sqrt` (ExpandStrings.ts:36) is IEEE-exact. Keep left-to-right float reduction order
  (`reduce((a,b)=>a*b,1)`).
* MarkovChain `evaluate` indexes an `Int8Array(128)` with `charCodeAt(i)`. Codes ≥128 read `undefined`, which acts
  like -1 (unseen). Iterate UTF-16 units, not chars.
* Float division where integers are expected: Renderer.ts:49 `indent = (indent/4 + 1)*4`, so 2 spaces + tab → 6.
  `Math.min()` with no arguments = `Infinity` (StringTypes.ts:111). `x|0` (int32 wrap) appears in hashes only.

### 2.3 Sorting: every call site

V8 `Array.prototype.sort` is **stable TimSort**. Default (no comparator) = `ToString` then UTF-16 code-unit order
(`[10,9,1,100].sort()` → `1,10,100,9`; `["\uff61","\u{1f600}"]` → astral first) **[exp]**. Rust `str` `Ord` is UTF-8
byte order and puts U+FF61 first **[exp]**.

| site | keys | comparator / notes |
|---|---|---|
| JSONSchemaInput.ts:832 (`mapSortBy`) | `k.toLowerCase()` (string) **or** index in `quicktypePropertyOrder` (number), :1170–1174 | `compareKeys` with JS `<` across mixed types; **inconsistent** (see below) |
| ConvenienceRenderer.ts:753 | assigned property names | UTF-16 |
| ConvenienceRenderer.ts:926 | names, when `alphabetizeProperties` | UTF-16 |
| ConvenienceRenderer.ts:988 | union member names (or custom `sortOrder`) | UTF-16 |
| PythonRenderer.ts:444 | 0/1 (has `= None` default) | numeric, stable |
| Transformers.ts:641 | `getNumberOfNodes()` | numeric, stable, take `[0]` |
| MakeTransformations.ts:222, GatherNames.ts:193/350, TypeUtils.ts:152, Type.ts:865 | `t.kind` (ASCII) | UTF-16 = byte order |
| TypeUtils.ts:153 | caller-supplied key | UTF-16 |
| Type.ts:525/540, TypeBuilder.ts:528 (`mapSortByKey`) | property names | UTF-16 |
| FlattenUnions.ts:58 | numbers | `(a,b)=>a-b` |
| TypeScriptEffectSchema:170, TypeScriptZod:179, Kotlin Klaxon:662 / Jackson:514 | small integer ranks | `a-b`, stable |
| ElixirRenderer.ts:387 | class < bool < enum < primitive < other | consistent rank, stable |
| JSONSchemaRenderer.ts:146 `req.sort()`, URIAttributes.ts:56/60 | strings | default (UTF-16) |
| CompressedJSON.ts:342 | keys, hash only | irrelevant |
| ProvenanceTypeAttributeKind.ts:28 | numbers, **default sort** (`10<9`) | debug print only |
| GolangRenderer.ts:542 | imports | `localeCompare` (§2.4) |

**Inconsistent comparator (JSONSchemaInput):** with `quicktypePropertyOrder` present, keys mix numbers and lower-cased
names. `0 < "a"` and `0 > "a"` are both false, which makes the comparator non-transitive. Note `""`→`ToNumber`→`0` and
`"10"`→`10`. The result depends on V8's exact algorithm **[exp]**. For properties `{z,b,m,a,10,9,Y}` with order
`["m","10"]` the output is `10, 9, a, b, z, m, Y`. Rust 1.81+ `sort_by` *may panic* on a non-total order, so
`js_compat::js_sort_by` must be a faithful port of V8 `third_party/v8/builtins/array-sort.tq` (BSD-3-Clause). Details:
`ComputeMinRunLength` (n<64 → one binary-insertion pass), `CountAndMakeRun` (strictly-descending runs reversed),
`BinaryInsertionSort` (`order < 0` goes left), galloping merges with `min_gallop=7`. For consistent comparators any
stable sort gives identical results, but routing every sort through one function removes the risk.

### 2.4 localeCompare

There is one site: GolangRenderer.ts:543, sorting imports. The possible values are the fixed set `bytes`, `errors`,
`encoding/json`, `time` (lines 326/529–534/748–786). ICU root collation and code-unit order agree on it, so use a
plain sort and add a `debug_assert` that only these strings occur.

### 2.5 Strings (UTF-16, case, whitespace, replace)

* **Length/indexing is UTF-16.**
  * Column alignment uses `.length`: Source.ts:156/168 (`sourceLineLength`) and Renderer.ts:45. Emoji count as 2: Go
    output `Empty·int64` vs `中文····int64` **[exp]**.
  * Other UTF-16 code: TypeNames.ts:69–93 (common prefix/suffix by code unit, can **split a surrogate pair**);
    Strings.ts:62–142 (`utf16ConcatMap`, `utf32ConcatMap`), :345 (`charCodeAt(0)`), :375–384 (`codePointAt`),
    :556/564; Python utils (per unit); MarkovChain; wordwrap; the `[...value].length` emitted in code is text only.
* **`s[0].toUpperCase() + s.slice(1)`**: Strings.ts:311 (`capitalize`, `decapitalize`), :503 (`firstUpperWordStyle`),
  Elixir/utils.ts:22, and Rust/utils.ts:60/75 (`slice(0,1)`). Only the first *code unit* is mapped, so an astral first
  letter stays unchanged (`"𐐨x"`→`"𐐨x"`), while `"ßtraße"`→`"SStraße"`, `"ŉabc"`→`"ʼNabc"`, `"ﬁle"`→`"FIle"`,
  `"ǆemal"`→`"Ǆemal"` **[exp]**.
* **Case mapping:** Rust `str::to_uppercase`/`to_lowercase` equal V8/ICU on *every* code point (0 diffs over 1,112,064
  single-char strings, Unicode 17 both) **[exp]**. Both apply Final_Sigma (`"ΣΑΣ x"`→`"σας x"`) and `"İ"`→`"i̇"`.
  Always map whole strings, never char by char. Pin the Node version: on Node 24.6 (ICU 77, Unicode 16) characters new
  in 17 would differ.
* **Whitespace:** JS `\s`/`trim()` = TAB LF VT FF CR SP U+00A0 U+1680 U+2000–200A U+2028 U+2029 U+202F U+205F U+3000
  **U+FEFF**. Rust `char::is_whitespace`/`str::trim`/regex `\s` differ exactly at **U+0085 (Rust only) and U+FEFF (JS
  only)** **[exp]**. Sites: ConvenienceRenderer.ts:104/108 (descriptions, output), PostmanCollection.ts:98,
  NodeIO.ts:32/33, src/index.ts:151/1120, GraphQLIntrospection.ts:12 (`\s*`), and wordwrap/is-url. Strings.ts:298
  `trimEnd` is different again (Zs/Zl/Zp only).
* **`String.prototype.replace` with a string pattern replaces the first occurrence only** and interprets `$&`, `` $`
  ``, `$'` and `$$` in the replacement. Sites:
  * ConvenienceRenderer.ts:840 `kind.replace("-","_")` (one hyphen per kind)
  * **Smithy4sRenderer.ts:94 `s.replace(" ","")`** (first space only)
  * src/index.ts:295/303 `.replace(extension,"")`
  * Messages.ts:302 (`${name}` placeholder): user values containing `$&`/`$'` get expanded (stderr only)

  `split(x).join(y)` (ConvenienceRenderer.ts:1260) is replace-all.
* **`split` with a regex keeps capture groups** (wordwrap). Rust `Regex::split` drops them.
* `String.fromCharCode(unit)`: 11 sites building escape tables (Strings.ts:27, 151, 158, 214; Php/utils.ts:15;
  Smithy4s:391; ObjC:67). These are BMP code units.
* `.normalize("NFKC")` appears only in Python/utils.ts:27/38 (§1.3).
* **Lone surrogates**: JSON input `"\ud800"` survives stream-json and `JSON.parse`. It is printed as `"a\ud800b"` in
  TypeScript, legalised to `a_b` in Python, and crashes Go with `Malformed unicode: High surrogate not followed by low
  surrogate.` **[exp]**. Rust `String` cannot hold one. The corpus has **0 lone surrogates** **[exp]** (scanned
  blns-object, nst-test-suite, 6de06), but it has 20 astral property names (blns). Decision needed:
  * (a) a `JsString` (WTF-8 or `Vec<u16>`) end-to-end. Exact, but costly.
  * (b) `String` everywhere, with lone surrogates documented as a JS-API divergence. TypeNames' prefix/suffix cut must
    then drop a split half.

  Recommend (b) for now, but keep JSON string values behind a newtype so (a) stays possible.

### 2.6 Objects as maps (integer-like keys, `__proto__`, duplicates)

JS own-property order: **array-index keys** (canonical `"0"`…`"4294967294"`, no leading zeros or sign) ascending
first, then other strings in insertion order. `"4294967295"`, `"01"`, `"-1"` and `"1.5"` are ordinary strings
**[exp]**.

Where it reaches output:
* **JSON.parse/YAML results walked by key**: CompressedJSON.ts:395 (API JSON input), JSONSchemaInput.ts:534 (`addIDs`
  walk), :832 (properties; then sorted by lowercase name, with **ties resolved by object order**), :1137, :1503
  (`#/definitions/` → **top-level type order**), AccessorNames.ts:238/244, Description.ts:139, src/index.ts:829
  (URL-grammar top levels), URLGrammar.ts:46, and graphql-input `types`.
* **Objects built then serialised**:
  * JSONSchemaRenderer.ts:137 (`props[name]`) and :189 (`definitions[title]`): JSON input `{"zeta","10","2","alpha"}`
    produces schema `properties` in order `2, 10, zeta, alpha` while `required` is `["10","2","alpha","zeta"]`
    **[exp]**. 88 schema→schema golden cases.
  * Run.ts:547: `JSON.stringify(JSON.parse(src),undefined,4)` for converted sources. **[exp]** reorders keys,
    collapses duplicates (last value, first position), `1.0`→`1`, `1e2`→`100`, `1e400`→`null`, `-0`→`0`,
    `123e-20`→`1.23e-18`.
* **`__proto__`** is quirky in three places:
  * Object assignment `o["__proto__"]=v` sets the prototype, so the key silently disappears. JSON Schema output drops
    a `__proto__` property from `properties` but keeps it in `required` **[exp]**.
  * Inference.ts:359–373 (`propertyValues`): each object re-runs `propertyValues.__proto__ = []`. Earlier objects'
    values are lost and the property becomes optional: `[{"__proto__":1},{"__proto__":"x"}]` → `__proto__?: string`
    **[exp]**.
  * CompressedJSON.ts:157 `_stringIndexes["__proto__"]=n` is ignored, so every occurrence is re-interned. Output is
    unaffected **[exp]**.

  Keys like `constructor` and `toString` are safe because every lookup is guarded by `hasOwnProperty`.
* Use `Map` for internal maps: JS `Map`s keep plain insertion order, so `IndexMap` is correct. JS `Map`/`Set`
  iterators are live, but no iterate-while-mutating pattern was found.

### 2.7 JSON.stringify / JSON.parse

Output-relevant `JSON.stringify`:
* JSONSchemaRenderer.ts:205 (4-space indent)
* Run.ts:547 (4-space indent)
* DefaultValue.ts:40
* JavaScriptRenderer.ts:166 (`p(${JSON.stringify(pattern)})`)
* TypeScriptEffectSchemaRenderer.ts:232 (`new RegExp(${JSON.stringify(pattern)})`)
* src/GraphQLIntrospection.ts:67 (2-space indent; written to file)

String escaping is identical between serde_json and JS for valid Unicode: `\"`, `\\`, `\b\f\n\r\t`, other <0x20 as
lowercase `\u00XX`. Neither escapes `/`, U+007F, U+2028/2029 or non-ASCII. Pretty layout is identical, with `[]`/`{}`
for empty containers **[exp]**. The differences are elsewhere:
* numbers (`number_to_string`, non-finite → `null`)
* key order (§2.6)
* lone surrogates (`\udXXX`, lowercase)
* serde_json's parse-side limits (§2.2)

Write a ~100-line serializer over our own `JsValue` rather than configuring serde_json.

### 2.8 Regexes: all 67 literals

**0 lookahead, 0 lookbehind, 0 backreferences**, so every pattern fits the `regex` crate and `fancy-regex` is never
needed. Flags: `g` ×21, `i` ×4, `u` ×1, `y/s/m` ×0. Only 3 are dynamic, all `new RegExp(/[^a-zA-Z0-9]+/,"g")` at
CJSONRenderer.ts:5833/5843/5948, and no user-supplied pattern is ever executed (schema `pattern` is only emitted as
text). Translation rules:

| JS (non-`u`) | Rust `regex` | sites |
|---|---|---|
| `\d` (ASCII) | `[0-9]` (Rust `\d` matches `٣` **[exp]**) | DateTime.ts:35/38, JSONSchemaInput.ts:355, StringTypes.ts:208, Scala3/utils.ts:145, Kotlin/utils.ts:79, Swift/utils.ts:36 |
| `.` (not `\n\r\u2028\u2029`) | `[^\n\r\u{2028}\u{2029}]` (Rust `.` matches U+2028 **[exp]**) | Rust/utils.ts:53/69 `(.)([A-Z])`, URIAttributes.ts:68, JavaScriptRenderer.ts:584 |
| `\s` | JS whitespace class (§2.5) | GraphQLIntrospection.ts:12 |
| `/i` on ASCII pattern | `(?i-u:…)` | DateTime.ts:38/47 (`/t/i` split), TypeNames.ts:19, CompressedJSONFromStream.ts:62 |
| `/u` `\p{L}\p{M}\p{N}` | `\p{L}` etc. (regex-syntax = Unicode **16**, JS = 17) or generated set | Scala3/utils.ts:44 |
| replace with callback | `replace_all` with closure | CJSON:70, Haskell:34, ObjC:61 |
| `split(re)` | `Regex::split` (no captures there) | Strings.ts:322 `[-_. ]+`, DateTime.ts:73 |

Everything else is ASCII literals and classes, used as-is. `^`/`$` without `m` mean the same in both. Negated classes
match one UTF-16 unit in JS and one scalar in Rust; all uses are `+`-quantified or anchored, so the results are equal.
Third-party patterns (pluralize, wordwrap, is-url, urijs) follow the same table.

### 2.9 Nondeterminism

* `Math.random`:
  * MarkovChain.ts:328 is used only by `generate()`. That function is not called in the pipeline (`trainMarkovChain`
    export only).
  * Chance.ts:55 runs only if no seed is given. TypeNames.ts:28 always seeds `new Chance(31415)` (MT19937; port with
    `u32` wrapping arithmetic) and re-initialises per run (Run.ts:536).
* `performance.now` appears in Run.ts:206–223, debug timing only.
* `Date` is never evaluated: `new Date`/`Date.parse` occur only inside emitted code strings
  (JavaScriptRenderer.ts:448, PropTypes:212).
* No hash-order iteration exists anywhere, because JS has none.

## 3. Recommended `js_compat` module (`crates/quicktype-core/src/support/js_compat/`)

Pure Rust, `no_std`-friendly where possible, and wasm32-clean (no ICU).

```rust
// ---- numbers (number.rs) ----
pub fn number_to_string(x: f64) -> String;            // Number#toString(10); ryu digits + JS layout; -0→"0"
pub fn number_to_radix_string(x: u64, radix: u32) -> String; // toString(8|16), lowercase
pub fn to_fixed(x: f64, digits: u32) -> String;       // half-up on exact decimal; |x|>=1e21 → number_to_string; -0→"0"
pub fn parse_int(s: &str, radix: u32) -> f64;         // Number.parseInt: JS-ws skip, sign, longest digit prefix, NaN
pub fn parse_float(s: &str) -> f64;                   // Number.parseFloat incl. "Infinity" prefix
pub fn string_to_number(s: &str) -> f64;              // ToNumber(string): trim JS ws, ""→0, 0x/0o/0b, Infinity, else NaN
pub fn js_pow(x: f64, y: f64) -> f64;                 // `**`: f64::powf (NOT libm crate) + spec NaN/±0 cases
pub fn to_int32(x: f64) -> i32;                       // `x | 0`

// ---- UTF-16 views of &str (string.rs) ----
pub fn utf16_len(s: &str) -> usize;
pub fn char_code_at(s: &str, i: usize) -> Option<u16>;
pub fn code_point_at(s: &str, i: usize) -> Option<u32>;    // lone-surrogate aware on WTF input
pub fn utf16_slice(s: &str, start: usize, end: usize) -> String; // split pairs: drop half (documented)
pub fn utf16_cmp(a: &str, b: &str) -> std::cmp::Ordering;  // JS `<` / default sort on strings
pub fn upper_first_unit(s: &str) -> String;           // s[0].toUpperCase()+s.slice(1)
pub fn lower_first_unit(s: &str) -> String;
pub fn to_upper(s: &str) -> String;                   // = str::to_uppercase (verified identical, Unicode 17)
pub fn to_lower(s: &str) -> String;                   // = str::to_lowercase (Final_Sigma ok)
pub fn is_js_whitespace(c: char) -> bool;             // ECMAScript WhiteSpace ∪ LineTerminator
pub fn js_trim(s: &str) -> &str;  pub fn js_trim_start(s: &str) -> &str;  pub fn js_trim_end(s: &str) -> &str;
pub fn replace_first(s: &str, pat: &str, rep: &str) -> String;  // incl. $$ $& $` $' expansion
pub fn split_keep_captures<'a>(re: &regex::Regex, s: &'a str) -> Vec<&'a str>; // JS split w/ groups
pub fn decode_uri_component(s: &str) -> Result<String, UriError>; // strict, throws like JS
pub fn lodash_pad(s: &str, len: usize, ch: &str) -> String;      // floor-left/ceil-right ("5"→"50")

// ---- regex helpers (regex.rs) ----
pub const JS_WS: &str;      // "[\t\n\x0B\x0C\r \u{a0}\u{1680}\u{2000}-\u{200a}\u{2028}\u{2029}\u{202f}\u{205f}\u{3000}\u{feff}]"
pub const JS_NOT_WS: &str;  pub const JS_DOT: &str;  pub const JS_DIGIT: &str = "[0-9]";
pub const JS_WORD: &str = "[0-9A-Za-z_]";
pub fn js_regex(src: &str, flags: &str) -> regex::Regex;  // rewrites \d \w \s \S . \b, i→(?i-u); panics on lookaround

// ---- ordering (sort.rs) ----
pub fn js_sort_by<T>(v: &mut Vec<T>, cmp: impl FnMut(&T, &T) -> f64); // V8 TimSort port; never panics
pub fn js_sort_strings(v: &mut [String]);                 // default sort() on strings
pub enum SortKey { Num(f64), Str(String) }
pub fn compare_keys(a: &SortKey, b: &SortKey) -> f64;     // collection-utils compareKeys with JS `<`

// ---- JS values / objects (value.rs, json.rs) ----
pub fn is_array_index(k: &str) -> bool;                   // canonical uint32 < 2^32-1
pub struct JsObject<V> { /* IndexMap; insert() places array-index keys ascending before others;
                             set_assign() ignores "__proto__" (assignment semantics);
                             define() keeps it (JSON.parse/CreateDataProperty semantics) */ }
pub enum JsValue { Null, Bool(bool), Number(f64), String(String), Array(Vec<JsValue>), Object(JsObject<JsValue>) }
pub fn json_parse(s: &str) -> Result<JsValue, JsonError>; // JSON.parse: f64 correctly rounded, ±Inf on
                                                          // overflow, dup keys last-wins-first-pos, no depth limit
pub fn json_stringify(v: &JsValue, indent: Option<&str>) -> String; // JS escaping, number_to_string, non-finite→null
pub fn json_quote(s: &str) -> String;

// ---- Unicode 12 property table (unicode12.rs, generated by xtask from unicode-properties) ----
pub enum Gc { Cc, Zs, Po, Sc, Ps, Pe, Sm, Pd, Nd, Lu, Sk, Pc, Ll, So, Lo, Pi, Cf, No, Pf, Lt, Lm, Mn, Me, Mc, Nl, Zl, Zp, Cs, Co }
pub fn get_category(cp: i64) -> Gc;                       // unassigned / out of range → Cc
pub fn is_alphabetic(cp: i64) -> bool; pub fn is_lower(cp: i64) -> bool; pub fn is_upper(cp: i64) -> bool;
pub fn is_digit(cp: i64) -> bool;      pub fn is_unicode_props_whitespace(cp: i64) -> bool; // Zs|Zl|Zp
pub fn python3_is_start_unit(u: u16) -> bool; pub fn python3_is_part_unit(u: u16) -> bool; // NFKC bitsets
```

Crates to add to `[workspace.dependencies]`, each with a PARITY.md row: `indexmap` (present), `regex` 1.x, `ryu` (or
`ryu-js`), `saphyr-parser`, `graphql-parser`, `idna` (punycode only), `anstyle`. Avoid `libm`, `serde_json` for user
JSON, `clap`, `url` and `pluralizer`.

Verification harnesses to keep in `xtask`. Each dumps from node and diffs against Rust:
* `number_to_string` (random bits)
* `js_pow` (random + MarkovChain-shaped inputs)
* case mapping (all code points)
* `get_category` (all code points)
* Python bitsets (all units)
* pluralize over corpus names
* urijs over corpus `$ref`s and URL strings
* V8 sort over random inconsistent comparators
