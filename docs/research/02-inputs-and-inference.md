# 02 — Inputs and inference

Reference: quicktype @ c39af7d3. Paths are relative to `packages/quicktype-core/src/` unless prefixed `src/` (root CLI). Experiments: Node v24.16.0 against the built `dist/`; results are quoted inline.

## 0. Key findings

- **CLI and JS API parse JSON differently and infer different types.** The CLI (`src/index.ts:904`) feeds every JSON sample, Postman bodies included, through `CompressedJSONFromStream` (stream-json 3.5.0). The API (`input/Inputs.ts:205`) uses `CompressedJSONFromString` (`JSON.parse`). They differ in integer/double classification, key order, duplicate keys and error text (§1.5). The golden corpus covers only the CLI path.
- **Number classification.** CLI: a number is a double iff its literal contains `.`/`e`/`E`, or it is a whole number outside the target's integer range (exact string compare). API: `1.0`, `1e2` and `-0.0` are integers; `9223372036854775807` is a double.
- **Schema errors are hidden.** JSON Schema fetch and parse errors are swallowed by `JSONSchemaStore.get` (`input/JSONSchemaStore.ts:32-36`); users only see `Could not fetch schema …`.
- **urijs 1.19.11** semantics drive every schema address, `$ref` and error message: relative URIs, `normalize`, `absoluteTo`, and a `decodeURIComponent` that can throw. The `url` crate cannot model this; port the urijs subset.
- **Markov chain.** A 65³ table quantized to 5 levels plus "unseen", evaluated with f64 products and one `**`. V8's `**` is the **platform `pow`** with special cases `y==2 → x*x` and `y==0.5 → sqrt`, not fdlibm (measured, §4).

## 1. JSON input end to end

### 1.1 Entry points; bytes → text

- **Entry points.**
  - CLI (all 7,096 golden JSON cases): `src/index.ts:904` builds `new CompressedJSONFromStream(lang.dateTimeRecognizer, handleJSONRefs, lang.getSupportedIntegerRange(rendererOptions))`. Unknown language names map to `"typescript"`.
  - CLI Postman (`src/index.ts:1078-1100`): each body goes through `stringToStream`, then the same class.
  - API: `jsonInputForTargetLanguage` (`input/Inputs.ts:205`) uses `CompressedJSONFromString`.
- **JSON `$ref` handling is off by default** (`handleJSONRefs = false`). The CLI sets every inference flag true unless `--no-X` is given (`src/index.ts:1168-1176`), so `ignoreJsonRefs = true`. Only `--no-ignore-json-refs` turns refs on (`:1182`).
- **Decoding.**
  - Files use `fs.createReadStream(path, "utf8")`; stdin `-` and URL bodies use `setEncoding("utf8")` (`input/io/NodeIO.ts:99-142`, `src/CompressedJSONFromStream.ts:46`).
  - Invalid UTF-8 becomes U+FFFD, the same as Rust `from_utf8_lossy` (maximal subpart).
  - **The BOM is not stripped**, so CLI JSON with a BOM fails. `parseJSON` (`support/ParseJSON.ts:13`), used for schema, Postman, GraphQL schema and URL grammar input, does strip one U+FEFF.
- **Missing files.** `resolveSymbolicLink` runs `fs.lstatSync` before anything else. A missing file therefore gives `Error: Cannot read from file or URL x.json: Error: ENOENT: no such file or directory, lstat 'x.json'.` (`MiscReadError`, with `exceptionToString(e) = e.toString()`). `DriverInputFileDoesNotExist` is unreachable for missing paths.
- **Unreadable files.** EACCES crashes Node with an unhandled stream `error`, a stack trace and exit 1; `pipe` does not forward errors.
- **URL detection** (is-url, `NodeIO.ts:106`): `^(?:\w+:)?\/\/(\S+)$`, then `^localhost[\:?\d]*(?:[^\:?\d]\S*)?$` or `^[^\s\.]+\.\S{2,}$`.
- **HTTP.** A non-2xx response throws `HTTP ${status} ${statusText}`, wrapped in `MiscReadError`.
- **Headers.** `--http-header` splits at the first `:` and trims both sides. A header with no `:` panics: `Could not parse HTTP header "…".`

### 1.2 CLI tokenizer: stream-json 3.5.0 (`node_modules/stream-json/src/core/parser.js`)

Options: `{packKeys:true, packStrings:true}`, all others at their defaults. Event mapping (`src/CompressedJSONFromStream.ts:6-19`):
- `start/endObject` and `start/endArray` push and finish contexts.
- `keyValue` → `setPropertyKey`; `stringValue` → `commitString`; `null/true/falseValue` → commit.
- `startNumber` pushes a context and clears the integer string.
- `numberChunk(s)`: ignored once the number is a double. Otherwise, if `/[.e]/i.test(s)` it marks the number double; if not, `s` is appended to `_currentIntegerString`.
- `endNumber`: the value is a double iff it was marked, or `!integerStringInRange(str, range)` (a `null` range always fits). The context is popped and `Integer` or `Double` committed.
- `numberValue`, `startString`, `stringChunk`, `startKey` and the like are ignored.

The grammar is strict RFC 8259:
- whitespace is only space, tab, LF and CR;
- numbers match `-?(0|[1-9]\d*)(\.\d+)?([eE][-+]?\d+)?`;
- code units < 0x20 are rejected inside strings;
- escapes are `\b \f \n \r \t \" \\ \/ \uXXXX`; each `\uXXXX` becomes one UTF-16 unit, so lone surrogates survive;
- literals need an ASCII `\b` (word boundary) after them;
- there is exactly one root value. Chunk boundaries are unobservable.

The CLI prints `Error: Syntax error in input JSON ${topLevel}: ${msg}.` (`Inputs.ts:64-74`, `Messages.ts:161`, `src/index.ts:1285`). Exact `msg` texts:

| Input | `msg` |
|---|---|
| empty file; `[` or `{"a":` at EOF | `Parser has expected a value` |
| BOM, `NaN`, `tru}`, `'x'` | `Parser cannot parse input: expected a value` |
| `{"a":1} {"b":2}` | `Parser cannot parse input: unexpected characters` |
| `{"a":1,}` / `[1,]` | `Parser cannot parse input: unexpected token '}'` / `']'` |
| `[1,2`, `{"a":01}`, `[1 2]` | `Parser cannot parse input: expected ','` |
| `[1}` / `{"a":1]` | `Parser cannot parse input: expected ']'` / `expected '}'` |
| `{1:2}`, `{` | `Parser cannot parse input: expected an object key` |
| `{"a" 1}` | `Parser cannot parse input: expected ':'` |
| control char or bad escape | `Parser cannot parse input: escaped characters` |
| unterminated string at EOF | `Parser has expected a string value` |
| `-x` / `1.x` / `1e+x` | `…: expected a starting digit` / `…a fractional part of a number` / `…an exponent part of a number` |
| `1e` at EOF | `Parser has expected an exponent value of a number` |

### 1.3 API path: `JSON.parse` (`input/CompressedJSON.ts:366-405`)

`process()` visits keys in `Object.getOwnPropertyNames` order:
1. **Array-index keys** first, ascending. These are canonical decimals ≤ 4294967294; `"01"`, `"-1"`, `"1.5"` and `"4294967295"` do not qualify.
2. Then all other keys in insertion order.

Duplicate keys keep the **last** value at the **first** key's position. `"__proto__"` becomes an ordinary own property.

Errors use V8's text, e.g. `Unexpected end of JSON input`, `Unexpected token 'x', "x" is not valid JSON`, or `Expected ',' or ']' after array element in JSON at position 4 (line 1 column 5)`. The quoted snippet follows V8's context rule: a source of fewer than 21 UTF-16 units is shown whole (measured; 21 units already get the excerpt); otherwise, with `p` the error position:

| Condition | Snippet |
|---|---|
| `p < 10` | `"src[0..p+10]"...` |
| `p + 10 ≥ len` | `..."src[p-10..]"` |
| otherwise | `..."src[p-10..p+10]"...` |

§7 lists every template I probed.

### 1.4 CompressedJSON model (`input/CompressedJSON.ts`)

- **Values.** `Value = tag | index<<4`, with tags `Null=1 False=2 True=3 Integer=4 Double=5 InternedString=6 UninternedString=7 Object=8 Array=9 StringFormat=10 TransformedString=11` (lines 17-50).
  - Objects are flat `Value[]` arrays `[k0,v0,k1,v1,…]`; keys are always `InternedString` (line 204). Arrays are `Value[]`.
  - Use a Rust enum: neither the bit packing nor `hashCode` (line 334) reaches output.
- **One shared string table.** There is one `CompressedJSON` per `JSONInput`, and `InputData.getOrAddInput` (`Inputs.ts:232`) creates one input per kind, so all samples and top-levels share it.
- **`internString`** (line 149) uses a plain object as its index. For `"__proto__"`, `hasOwnProperty` is false and the assignment sets the prototype, so each occurrence gets a fresh index. This is harmless because comparisons are by content.
- **`commitString(s)`** (lines 229-261):
  1. If `handleRefs` is on and the current key is `"$ref"`, intern `s` regardless of length or format.
  2. Otherwise compute `k = inferTransformedStringTypeKindForString` (§1.7). If `k` has an `attributesProducer` (only `uri`, `Type/TransformedStringType.ts:37-41`), emit `TransformedString(intern(s))`; for any other `k`, emit `StringFormat(intern(k))`.
  3. Otherwise emit `InternedString` if `s.length <= 64` in **UTF-16 units**, else `UninternedString` (never an enum case).
- **API number rule** `parsedNumberIsDouble(n)` (lines 111-116):
  - a non-whole `n` is a double;
  - with a `null` range it is an integer, so `1e400` (Infinity) is an *integer* for Python, Ruby, Pike, Elixir and JSON Schema;
  - `|n| ≥ 1e21` is a double;
  - otherwise compare `n.toFixed(0)` with the range. `toFixed(0)` is exact here: in Rust use `(n as i128).to_string()`, and `-0` gives `"0"`.
- **`integerStringInRange`** (`support/IntegerRange.ts:49-101`): strip the sign and leading zeros (`-0` counts as 0), then compare by length, then lexicographically.
- **Ranges** (`getSupportedIntegerRange`):
  - INT64 by default;
  - JS_SAFE (±2^53−1) for TypeScript, Flow, JavaScript, PropTypes, Zod, Effect and Elm;
  - `null` for Python, Pike, Elixir, Ruby and JSON Schema;
  - CJSON follows `type-integer-size` (8/16/32/64);
  - Rust uses INT32 under `--integer-type` force-i32.

### 1.5 CLI vs API (measured)

| Input | CLI (stream) | API (`JSON.parse`) |
|---|---|---|
| `1.0`, `1e2`, `-0.0` | double | **integer** |
| `-0`, `0`, `9007199254740993` | integer | integer |
| `9223372036854775807` | integer | **double** (parses to 2^63) |
| `-9223372036854775809` | double | **integer** (parses to −2^63) |
| `1E400` | double | double; **integer** if the range is `null` |
| keys `{"b","2","a","1"}` | source order | `"1","2",b,a` |
| `"b":1.0 … "b":"dup"` | both kept: `number \| string` | last wins: `string` |
| errors | §1.2 table | V8 text |

Duplicates also affect optionality, because `isOptional = values.length < objects.length` (`Inference.ts:422`). In the CLI, `[{"a":1,"a":2},{"b":1}]` therefore makes `a` **required**.

### 1.6 Sources, `JSONInput` and type inference (`input/Inputs.ts:76-203`, `input/Inference.ts`)

- **`addSource({name, samples, description})`.** Empty `samples` fails with `No JSON samples given for top-level ${name}`. Samples are parsed sequentially. Any exception becomes `MiscJSONParseError(description ?? "input", address = name, errorMessage(e))`.
- **Top-levels.** `_topLevels` is a `Map` in first-insertion order. A repeated name appends samples, and a later defined description wins. `addTypesSync` runs, per top-level: `inferTopLevelType(makeNamesTypeAttributes(name, false), samples, fixedTopLevels)`, then `addTopLevel` and the description.
- **CLI sources** (`src/index.ts:819-902`):
  - each `--src` file is one sample of `--top-level`;
  - `--src-urls` reads a URL grammar (`src/URLGrammar.ts`): strings, arrays as cartesian concatenation, `{oneOf}`;
  - in a directory, each `*.json`/`*.url` file is a top-level named by `typeNameFromFilename` (basename minus the last extension; `""` if it has no dot);
  - each subdirectory pools its JSON files under the directory's name, and mixing JSON with schema or GraphQL there is an error.
- **Value arrays.** A `NestedValueArray` is in practice `Value[]` or `Value[][]`. `forEachArrayInNestedValueArray` (line 38) recurses while `Array.isArray(va[0])` and skips empty arrays.
- **`addValuesToAccumulator`** (lines 125-224) feeds `UnionAccumulator(conflateNumbers=true)`:
  - Null, Bool, Integer and Double → `addPrimitive`;
  - `InternedString` → `addStringCase(s, 1)` when inferEnums is on (`canBeEnumCase` is always true), else `addStringType("string")`;
  - `UninternedString` → `addStringType("string")`;
  - `StringFormat(k)` → `addStringType("string", ∅, StringTypes(new Map(), {k}))`;
  - `TransformedString` recomputes `k`, then `addStringType("string", producer(s), StringTypes({}, {k}))`;
  - Object and Array push their raw `Value[]` into `objectData` / `arrayData`.
- **Union order** (`UnionBuilder.ts:285-343`):
  - non-string kinds come in first-seen order, then `"string"`, which carries `StringTypes(cases, ∅)`;
  - integer+double moves integer's attributes into double; double keeps its slot;
  - `any` absorbs everything, and an empty union is `none`;
  - `buildUnion` (line 559) returns a single kind directly (with `typeAttributes ∪ increaseDistance(member)`), else `getUnionType(attrs, set in kind order)`;
  - `makeArray` = `getArrayType(attrs, inferType(∅, all elements of all arrays))`.
- **`inferClassType`** (lines 352-443):
  1. Collect `propertyNames` (first-seen) and `propertyValues[key]` across objects. The store is a plain object, so a `"__proto__"` name is pushed **again at every occurrence** and only the *last* occurrence's values survive. Measured: `[{"__proto__":1,"a":2},{"__proto__":"x","a":3}]` → `__proto__?: string` on both paths.
  2. With `handleRefs`, if the only key is `$ref` and every value is `InternedString`, return `getUniqueIntersectionType(attrs)` and record `[tref, refs]`.
  3. With `inferMaps` and **> 500** distinct names, return a map whose value type is the union of all values in name order, built with the passed `fixed`.
  4. Otherwise each property's type is `inferType(∅, values, false)` and it is optional when `values.length < objects.length`. The class is `getUniqueClassType(attrs, true, …)` if `fixed` (top-level with `fixedTopLevels`, i.e. Postman with more than one request), else `getClassType`.
- **JSON `$ref` resolution** (lines 241-322), run after the top-level is inferred:
  - a ref not starting with `#/` → `InferenceJSONReferenceNotRooted`;
  - the rest is split on `/` with no unescaping;
  - a union must be nullable-of-one (`…ToUnion`);
  - a class resolves to a property (`…WrongProperty`), a map to its values, an array via a `/^[0-9]+$/` index (`…InvalidArrayIndex`);
  - the intersection's members become the resolved set.

### 1.7 String-type detection (`attributes/StringTypes.ts:208-275`, `DateTime.ts`)

If `s` is empty, or `s[0]` (a UTF-16 unit) is not in `"0123456789-abcdefth"`, the result is `undefined`; so `HTTP://x` is never a URI. Otherwise the first passing check wins:
1. **date** — `^(\d\d\d\d)-(\d\d)-(\d\d)$`, year ≠ 0, month 1..12, `day ≤ DAYS[m]` with `DAYS[2]=29` (no leap-year check).
2. **time** — `^(\d\d):(\d\d):(\d\d)(\.\d+)?(z|[+-]\d\d:\d\d)$` with `/i`; h ≤ 23, m ≤ 59, s ≤ 59. The offset is mandatory; there are no leap seconds.
3. **date-time** — `s.split(/t/i)` must give exactly 2 parts that pass date and then time. A space separator is rejected.
4. **integer-string** — `^(0|-?[1-9]\d*)$` and `parseInt` within [−2^31, 2^31−1]; `"-0"` and `"007"` fail. In Rust: ≤ 11 chars, parse as i64, range-check.
5. **bool-string** — exactly `"true"` or `"false"`.
6. **uuid** — `^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$`, lowercase only.
7. **uri** — `^(https?|ftp):\/\/[^{}]+$`. `[^{}]` also matches newlines, so `"http://x\n"` is a uri.

Measured:
- `2020-02-30` fails, `2021-02-29` is a date, `0000-01-01` fails;
- `…T23:59:60Z` fails, `2020-01-01t10:00:00z` is a date-time, `10:00:00+0100` fails;
- an uppercase UUID fails, `https://a/{b}` fails.

JS `\d` is ASCII, but the Rust `regex` crate's `\d` is Unicode: hand-write these checks.

**Target-specific recognizers:**

- **Kotlin** (`language/Kotlin/utils.ts:85-122`):
  - Feb 29 is accepted only in leap years;
  - time uses the case-sensitive `^(\d\d):(\d\d):(\d\d)(?:\.(\d{1,9}))?(Z|[+-]\d\d:\d\d)$`, and the fraction must not end in `0`;
  - the offset must be `Z` or a non-zero `±hh:mm` with mm ≤ 59 and at most 18:00;
  - date-time splits on `"T"` only.
- **Swift** (`language/Swift/utils.ts:35-42`): `isDateTime` is `^\d+-\d+-\d+T\d+:\d+:\d+(?:\.\d+)?([zZ]|[+-]\d+(:\d+)?)$` with no range checks.

**`uriInferenceAttributesProducer`** (`attributes/URIAttributes.ts:66-89`):
- protocols = `{URI(s).protocol().toLowerCase()}`;
- extensions = `/^.+(\.[^./\\]+)$/` matched on `uri.path()`, lowercased. Measured: `/b.JSON` → `.json`, `/x.tar.gz` → `.gz`, `/.htaccess` → `.htaccess`;
- if urijs throws (e.g. a port outside 1..65535 such as `:99999`), there are no attributes.

**`StringTypes`.**

- `cases` is a Map, or `undefined` for unrestricted.
- `union` sums counts and appends new keys; an unrestricted member makes the result unrestricted.
- `intersect` keeps the common keys (or this side's keys if none are common) with the minimum count; note `Math.min()` is +∞.
- `applyStringTypeMapping`: if **any** transformation maps to `"string"`, the result is `unrestricted` and the cases are dropped.
- `requiresUniqueIdentity` iff there are cases.

Flags like `--no-date-times` do not stop detection; `Run.ts:180-191` instead maps those kinds to `"string"` through `stringTypeMapping`.

### 1.8 Enum and map thresholds (rewrites, but they decide inference)

- **Enums** (`rewrites/ExpandStrings.ts:22-50`):
  - a type is its own enum if `numValues ≥ 10` and `cases.size < sqrt(numValues)`;
  - sets merge when the overlap is ≥ ¾ of the smaller set (of the new set when subordinate); late merges need `numValues ≥ 5`;
  - unless inference is `all`, `[""]` and all-numeric (`/^[-+]?[0-9]+(\.[0-9]+)?$/`) case sets are excluded.
- **Maps.** Inference turns any object with > 500 distinct names into a map. The `InferMaps` rewrite (`rewrites/InferMaps.ts:32-130`) then checks each non-fixed class:
  1. fewer than 2 properties: not a map;
  2. every name matches `/^[0-9]+$/`: a map;
  3. fewer than 50 properties, all string-kind or null: not a map;
  4. fewer than 20 properties: compute `p = (∏ nameProbability)` (a left fold from 1), then `p ** (1/n)`. With `limit = (n+2)**5/22**5 + (0.0025 − 3**5/22**5)`, it is not a map if `p > limit`;
  5. finally, all non-null case sets must be structurally equal.

## 2. JSON Schema input (`input/JSONSchemaInput.ts`)

### 2.1 Sources, addresses, top-levels

- **`addSourceSync({name, uris?, schema?, isConverted?})`** (lines 1677-1726):
  1. Set `needIR` unless `isConverted`.
  2. Build the URIs. With no `uris`, use `[new URI(name)]`, **not normalized**. Otherwise use `normalizeURI(u)`; if the URI without its hash is `""`, set `path(name)`.
  3. If `schema` text is given, store it under each hash-less URI, appending `-1`, `-2`, … to the path until the key is free, then re-attach the hash. The path setter *recodes*, so `My Type-1` is stored as `My%20Type-1` while lookups use the decoded form; a duplicate name containing a space never resolves.
- **CLI** (`src/index.ts:836-856`): each `--src` is its own source `{name: topLevel, uris: [path]}`. `--additional-schema` addresses are pre-added to the canonizer; a failure there raises `SchemaFetchErrorAdditional`.
- **`normalizeURI(u)`** (line 142) = `new URI(URI.decode(new URI(fixWindowsPath(u)).normalize().toString()))`.
  - `URI.decode` is `decodeURIComponent`, which throws; `--src '100%.schema'` gives `Error: URI malformed.`
  - `fixWindowsPath` (`support/WindowsPaths.ts:12-24`) rewrites `C:\…` to `file:///C:/…` and `\\srv\…` to `file://srv/…`; `filePathFromFileURI` reverses it.
- **`addTypes`** (lines 1593-1667):
  - schema strings wrap the store in `InputJSONSchemaStore` (with no delegate, an unknown address panics and the panic is swallowed);
  - each source then goes through `refsInSchemaForURI` (lines 1478-1515):
    - a fragment ending in `/` means "each key is a type": the slash is trimmed and each key of the resolved object (in `getOwnPropertyNames` order) becomes `ref.push(key)`. This is off for root refs; a boolean target raises `SchemaCannotGetTypesFromBoolean`;
    - otherwise the name is `schema.title`, else `nameFromURI` (last non-empty fragment component, else `filename()`; `.json`/`.schema` is stripped case-insensitively unless that empties it; else `DriverCannotInferNameForSchema`).
  - a single source keeps its given name, so with several `--src` the names come from titles or filenames;
  - `_topLevels` is a `Map`: a duplicate name keeps its first slot with the last ref.

### 2.2 Ref, Location, Canonizer, Resolver

`Ref = {addressURI?: URI (normalized, no fragment), path}`. Path elements are `Root`, `KeyOrIndex(key)`, `Type(i)` and `Object` (`input/PathElement.ts`).

- **`Ref.parse(s)`** = `parseURI(new URI(fixWindowsPath(s)))`.
  - The fragment becomes the path; an empty fragment with a host or filename becomes `"/"`.
  - `parsePath`: a leading `/` gives `Root`, the rest is split on `/`. There is **no `~0`/`~1` and no percent decoding**: `#/a/b%20c` looks up `b%20c`.
  - Parsed refs **always** have an `addressURI` (`URI("")` for `#…`); only `Ref.root(undefined)` has none. So `SchemaIDMustHaveAddress` (line 461) never fires.
- **`toString`** = `addr + "#" + path.join("/")`, rendering `Root` as `""`, `Type` as `type/i`, `Object` as `object`, keys verbatim. Example: `e1.schema#definitions/Nope` (no `Root`).
- **`name`** (lines 265-306): scan backwards for the first **all-digit** key. On reaching `Root` or the start, return `filename()` minus `.suffix()` (only if the filename is longer than suffix + 1), with `""` → `"Something"`. Non-numeric keys are skipped, so `foo.json#/definitions/Bar` → `"foo"`.
- **`definitionName`**: the last key, when the second-to-last is `definitions` or `$defs`.
- **`equals`**: urijs `equals` (normalized; permuted queries compare equal) plus path equality. `hashCode` uses `toString`.
- **`resolveAgainst(base)`**: if `base` has an address, `this.addr ? this.addr.absoluteTo(base.addr) : base.addr`.
- **Location** `(canonicalRef, virtualRef = canonical, haveID)`. `updateWithID(id)`, for a string `id`, sets `virtual = haveID ? Ref.parse(id).resolveAgainst(virtual) : Ref.parse(id)` and `haveID = true`. `push` extends both refs.
- **`Canonizer.addSchema(schema, address)`** runs once per address (lines 506-551):
  - it walks objects and arrays (indices as string keys), in `getOwnPropertyNames` order, from `Location(Ref.root(address)` *(empty path, no `Root`)*, `Ref.root(undefined))`;
  - it applies `updateWithID` wherever `$id` is a string, and when `haveID` it records `map[virtual] = locWithoutID`;
  - this is how `"$id": "#item"` anchors work (golden `id-no-address.schema`).
- **`canonize(base, ref)`**: `virtual = ref.resolveAgainst(base.virtualRef)`. Return the mapped location if any, else `Location(virtual.addr ? virtual : Ref(base.canonical.addr, virtual.path), Ref(undefined, virtual.path))`.
- **`resolveVirtualRef(base, vref)`** (lines 700-792):
  1. Try `tryResolve(base, base, vref)`.
  2. Then retry with `altBase = Location(base.canonical, Ref(base.canonical.addr, base.virtual.path))`.
  3. Otherwise raise `SchemaFetchError(address = vref.toString(), base = base.canonicalRef)`.

  `tryResolve` loops: canonize, then `store.get(address)` (`undefined` fails). If `addSchema` is true (first sight), loop again so new `$id`s apply. Otherwise return `lookupRef(schema)` at `canonize(lookupBase, vref)`, with the address taken from `loc`.
  - **Consequence:** a local `#/…` ref from a location with no virtual address first tries address `""`. `existsSync("")` is false and the error is swallowed, so the `altBase` attempt is the one that succeeds. `--debug print-schema-resolving` prints `trying to fetch ` / `couldn't fetch `.
- **`lookup`** (lines 337-394):
  - arrays need a `^\d+$` key (`SchemaCannotIndexArrayWithNonNumber`) within range (`SchemaIndexNotInArray`);
  - objects need an own key (`SchemaKeyNotInObject`);
  - the error's ref is `Ref(address, remainingPath)`.
- **`addTypesInSchema`** (lines 802-1437) memoizes `toType` by canonical ref (`EqualityMap<Ref,TypeRef>`):
  - a boolean schema becomes `any` or `none`;
  - otherwise it applies `updateWithID(schema.$id)` and calls `convertToType`, which registers its intersection before recursing (line 1213). That is what breaks cycles.

### 2.3 urijs 1.19.11 subset to port (`node_modules/urijs/src/URI.js`)

**`parse`** (line 493):
1. Strip leading `[\x00-\x20\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]+` and every TAB, CR and LF.
2. Split off `#frag` (empty → `null`), then `?query`.
3. Rewrite `^(https?|ftp|wss?)?:+[/\\]*` → `$1://` and `^[/\\]{2,}` → `//`.
4. A leading `//` starts an authority. Otherwise, at the first `:`, the prefix is the protocol if it matches `^[a-z][a-z0-9.+-]*$/i`; a following `//` starts an authority, and anything else is a URN.
5. In the authority, `\` becomes `/`. The userinfo ends at the last `@` before the first `/`. Then `[v6]:port` or `host:port`. A port that is not an integer in 1..65535 **throws** `TypeError`.

**`build`** = `proto:` + `//` (if not a URN and a protocol or hostname exists) + `user:pass@` + `host[:port]` + `/` (if `//` was added and the path lacks one) + path + `?q` + `#f`. An empty query or fragment is omitted.

**`normalize`**:
- lowercase the protocol and hostname (IDN → punycode, IPv6 → `best()`);
- drop default ports (http 80, https 443, ftp 21, ws 80, wss 443, gopher 70);
- normalize the path:
  1. `recodePath`: for each `/`-segment, `encodePathSegment(decodeURIComponent(seg))`. This **throws** on a bad `%`. Encoding is `encodeURIComponent` plus `!'()*` escaped, then `%24 %26 %2B %2C %3B %3D %3A %40` restored.
  2. Drop `/./`, collapse `//`, resolve `..` (leading `../` is kept for relative paths).
- reparse and rebuild the query (an empty query becomes `null`).

**`absoluteTo(base)`** (line 2172):
- a URI with a protocol is returned as is; one with a hostname takes only the base's protocol;
- otherwise the base's protocol, credentials, host and port are copied in;
- an empty path takes the base's path (and the base's query if the query is empty);
- a relative path gets `base.directory()` prepended and is path-normalized;
- a urijs bug: `path.substring(-2) === '..'` only matches exactly `".."`.

Measured:

| ref | base | result |
|---|---|---|
| `a/test2.json` | `test.json` | `a/test2.json` |
| `a/test2.json` | `dir/sub/t.json` | `dir/sub/a/test2.json` |
| `../../../c.json` | `a/x.json` | `c.json` |
| `c.json` | `http://h` | `http://h/c.json` |
| `?q` | `dir/x.json` | `dir/x.json?q` |

Normalizing `./a/../b/c.json` gives `b/c.json`, and `HTTP://Example.COM:80/a/./b/../c.json` gives `http://example.com/a/c.json`.

Accessors:
- `filename()` is the text after the last `/` (`""` for `""` or `/`);
- `suffix()` is the text after the filename's last `.` if it matches `^[a-z0-9%]+$/i` (ASCII only: Rust `(?i)` would also match `ſ` and U+212A), else `""`;
- `directory()` and the `fragment`/`hash`/`path` setters rebuild the URI.

### 2.4 Schema store (`input/JSONSchemaStore.ts`, `input/FetchingJSONSchemaStore.ts`)

`get(address)`:
1. Return the cached value if present.
2. Otherwise run `try { schema = await fetch(address) } catch {}`. **Every exception is swallowed**: parse, read, YAML and panic.
3. `undefined` → `undefined`. Anything else, `null` included, is cached and returned.

`FetchingJSONSchemaStore.fetch` = `parseJSON(readFromFileOrURL(address), "JSON Schema", address)`. Measured:
- invalid JSON/YAML → `Error: Could not fetch schema #, referred to from s3.schema#.`
- an empty file parses to `null` → `Error: null is not a valid JSON Schema at s4.schema#.`

The golden case `schema/ref-remote.schema` **fetches over HTTPS** (raw.githubusercontent.com).

### 2.5 Keywords → types and attributes (`convertToType`, lines 892-1404)

**Result shape.** The result is a unique **intersection** whose members are, in order:
1. a union built from the type keywords (if `needUnion`);
2. the `$ref` target;
3. each `allOf` case;
4. the `oneOf` union;
5. the `anyOf` union.

Rewrites resolve it later. An intersection with no members becomes `any`, so `{"format":"date-time"}` alone, or `patternProperties` alone, is `any`.

**`needUnion`** holds when any of `type`, `properties`, `additionalProperties`, `unevaluatedProperties`, `items`, `prefixItems`, `required` or `const` is defined, or `enum` is an array.

**`includedTypes`** filters `[null, boolean, string, integer, number, array, object]`:
- with `type` given, it must include the name (`checkTypeList`: a string or non-empty string array of valid names);
- with `enum`, some element must match the name:
  - `null` — `x===null`;
  - `integer` — `x===Math.floor(x)`, so `1.0` counts;
  - any other name — `typeof x===name`. So `null` matches `"object"`, nothing matches `"array"`, and integers match `"number"` too.
- with `const`: `name === (schema.type ?? typeof const)`. An *array* `type` never matches, so `{"type":["string","null"],"const":"x"}` includes nothing; `{"const":5}` gives `number` (double).

**Union members**, in order:
1. **Primitives:** `null`, `number`→double, `integer`, `boolean`→bool, with the `forNull`/`forNumber`/`forBoolean` attributes.
2. **String:**
   - if any enum or const value is a string, the type is an enum of the *string* values only (`StringTypes.fromCases`; non-strings are dropped, FIXME at line 1328);
   - otherwise `format` picks the first `TransformedStringType` whose `jsonSchema` equals it: `date`, `time`, `date-time`, `uuid`, `uri`; `integer` → integer-string; `boolean` → bool-string;
   - any other format is a plain string.
3. **Array** (only without enum/const):
   - `prefixItems`, or an array `items`, is a tuple, modelled as an array of the union of item types;
   - with `prefixItems`, an object `items` adds the rest type and a boolean `items` is ignored;
   - an object or boolean `items` gives the item type;
   - no `items` gives `any`;
   - anything else raises `SchemaArrayItemsMustBeStringOrArray`;
   - item names are singularized and inferred.
4. **Object** (only without enum/const) — `makeObjectType` (line 1115):
   - `required` must be an array; when undefined or a boolean it counts as `[]`;
   - draft-3 `properties[p].required === true` appends `p`, and crashes with a raw TypeError if `properties[p]` is `null`;
   - `additionalProperties` falls back to `patternProperties[".*"]`, then to `unevaluatedProperties`;
   - `makeObject` (line 822) **stable-sorts properties by `toLowerCase()`** as UTF-16 code units, starting from `getOwnPropertyNames` order. Measured: `"10"` sorts before `"2"`, and an `Alpha`/`alpha` tie keeps source order;
   - `quicktypePropertyOrder` replaces the key with an index (number) or the lowercase name (string); mixing the two makes the comparator inconsistent (§5);
   - `additionalProperties`: `undefined`/`true` gives `any`, `false` gives none, anything else gives a type with singularized names;
   - required but undeclared names are appended, in `required` order, as non-optional properties of the additional type (`SchemaAdditionalTypesForbidRequired` if additional properties are forbidden);
   - the result is `getUniqueObjectType`.

**Attribute producers**, in order (lines 1572-1582):

| Producer | Reads | Applies when | Produces |
|---|---|---|---|
| description | `description` | not a simple-typed property (parent ≠ `properties`), or object, or > 1 non-null type, or `enum` | `forType`; plus `forObject` property descriptions |
| accessorNames | `qt-accessors` | always | `forType`; under `oneOf`, `forUnion` + `forCases` (`SchemaWrongAccessorEntryArrayLength`) |
| defaultValue | `default` (null/bool/number/string) | the matching type is included | `forNull` / `forBoolean` / `forNumber` / `forString` |
| enumValues | `qt-enum-values` | always | `forType` |
| uriSchema | `qt-uri-protocols`, `qt-uri-extensions` | string | `forString` |
| minMax / minMaxLength / minMaxItems | `minimum`/`maximum`, `minLength`/`maxLength`, `minItems`/`maxItems` (numbers only) | number / string / array | `forNumber` / `forString` / `forArray` |
| pattern | `pattern` | string | `forString` |

**Naming** (`makeAttributes`, line 983):
- without `oneOf`, the producers' `forType` is unioned in;
- names that are inferred get replaced by `title`, else `definitionName`. The replacements are non-inferred unless the schema itself has a `$ref`;
- names that are not inferred are made inferred;
- properties get `makeNamesTypeAttributes(propName, true)`;
- a `$ref` replaces inferred names with `{target.canonicalRef.name}` (still inferred; line 1379);
- `oneOf`/`anyOf` cases get `makeTypeAttributesInferred`;
- `oneOf` also runs the producers with `cases`: `forType` goes to the intersection, `forUnion` to the union, `forCases[i]` to case i;
- `allOf` cases are plain intersection members.

**Unsupported:** draft-4 `id`, `not`, `if`/`then`/`else`, `dependencies`, `contains`, `propertyNames`, `multipleOf`, `exclusiveMin/Max`. `$schema` is ignored.

### 2.6 YAML

`parseJSON` falls back to `YAML.parse` (yaml 2.9.0, YAML 1.2 core schema). Measured:
- `yes`/`on` are strings; `~` is null;
- `0x1F` → 31, `0o17` → 15, `012` → 12, `.inf` → Infinity;
- `1_000` and `2001-12-14` are strings;
- `<<` is a plain key; anchors work;
- **duplicate keys and multiple documents throw**;
- key order is JS object order;
- a JSON-invalid but YAML-valid `.schema` (e.g. with a trailing comma) is accepted.

YAML errors are not `SyntaxError`s, so they surface as `Unknown exception YAMLParseError: <msg> at line L, column C:\n\n<src line>\n<caret>\n`. That text is visible only for Postman, GraphQL schema and URL grammar inputs; schema errors are swallowed (§2.4).

### 2.7 Error formatting (`Messages.ts:157-262`, `messageError` line 280)

Values are rendered as follows:
- objects with `toString` use it: a `Ref` gives `addr#path`, a plain object `[object Object]`, an array `1,2`;
- `null` gives `"null"`;
- other non-strings use `JSON.stringify` (`undefined` → `"undefined"`).

Each `${name}` is filled by `String.prototype.replace(string, string)` in `Object.entries` order. It replaces **only the first occurrence**, **interprets `$$ $& $' $\``** in the value, and can substitute into earlier values. The CLI prints `Error: ${msg}.` and exits 1. Measured:

```
Key definitions not in schema object at e1.schema#definitions/Nope
Could not fetch schema other.json#/x, referred to from e2.schema#
Invalid type strin in JSON Schema at e3.schema#
`type` must contain only strings, but it has 5            (template has no ref)
`type` must be string or array of strings, but is 5
`required` must be string or array of strings, but is a at e6.schema#
Array items must be an array or an object, but is 5
$ref must be a string, but is an number at e8.schema#
oneOf cases must be an array, but is [object Object], at e9.schema#/oneOf
Trying to index array in schema with key that is not a number, but is x at e11.schema#x
Index 3 out of range of schema array at e12.schema#3
Can't have non-specified required properties but forbidden additionalTypes at e13.schema#
An array is not a valid JSON Schema at e14.schema#
Value of type string is not valid JSON Schema at e15.schema#
JSON Schema must specify at least one type at e16.schema#
Cannot read properties of null (reading 'required')       (raw V8 TypeError; properties.a = null)
`required` must contain only strings, but it has 1, at e18.schema#
```

## 3. Postman, and combining inputs

`sourcesFromPostmanCollection(text, address)` (`input/PostmanCollection.ts`) starts with `parseJSON(text, "Postman collection", address)` and walks the result depth-first:
1. If `c.item` is an array, it recurses into each item **first**, then pushes `c.info.description` if it is a string (post-order).
2. If `c.name` is a string and `c.response` is an array, the samples are the `r.body` strings that `JSON.parse` accepts. If there are any, it emits `{name, samples, description}`, where the description joins with `"\n\n"`:
   - the request name;
   - `${method} ${url.raw}`, if `method !== undefined` and `url` is an object with `"raw" in url`;
   - `request.description`, if it is a string.

Edge cases:
- `url: null` throws a JS TypeError (`typeof null === "object"`), and so does a `null` root;
- the collection description is `descriptions.join("\n\n").trim()` (JS `trim` also strips U+FEFF), or undefined if empty.

CLI, per collection file (`src/index.ts:1078-1100`):
- each request becomes a stream source;
- more than one source sets `fixedTopLevels = true`;
- `leadingComments = wordWrap(desc).split("\n")`, and the last file wins;
- requests with the same name merge into one top-level, and the later description wins.

**`InputData`** (`input/Inputs.ts:223-322`):
- `_inputs` is a `Set` with one input per kind (`json`, `schema`, `graphql`), created by the first `addSource` of that kind;
- `addTypes` runs the inputs in creation order on one shared `TypeBuilder`, so top-level order is input order, then each input's map order;
- `needIR` and `needSchemaProcessing` are ORed across inputs;
- `singleStringSchemaSource` panics if more than one input has one.

## 4. Markov chain (`MarkovChain.ts`, `EncodedMarkovChain.ts`)

**Alphabet** (65): `" -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz"`. `characterIndexes` is an `Int8Array(128)` filled with −1; a code unit ≥ 128 reads `undefined`, which also fails `>= 0`.

**Decoding** (`decode`, lines 133-218) is integer-only:
1. **base91** (lines 41-69), alphabet ``!#$%&'()*+,-./0-9:;<=>?@A-Z[]^_`a-z{|}``. For each digit pair `v = d0 + 91*d1`; `bits |= v << bitCount`; `bitCount += (v & 8191) > 88 ? 13 : 14`; emit low bytes while `bitCount ≥ 8`. A trailing single digit emits `(bits | v << bitCount) & 0xff`.
2. **Header.** `levelCount = b[0]` (5), `modelCount = b[1]`, `scale = 1 << b[2]`. From offset 4: `levelCount` LE f32 probabilities (`[0] = 0.0001` as f32). Per model, `levelCount` LE u16 frequencies (the last is `scale − sum`). Then `modelCount−1` LE u16 model frequencies (likewise), then a u32 `modelStreamLength`.
3. **rANS** (`RansDecoder`, LE u32 state). `slot = state % scale`, `sym = symbols[model*scale+slot]`, `state = freq*floor(state/scale) + slot − cum`, then while `state < 2^23`: `state = state*256 + next`. Use u64; it never reads past the end (measured maximum position 38,259).
4. **Tables.** First the 65² column models, then `probabilityCodes[(first*65+second)*65+third]`, looping second, then third, then first.

**Test vectors.**

- `sha256(probabilityCodes)` = `baa3d3fbeb6331a33797ede1bcb9cd499c4e5f5f320dd4a05749c34ece70ce1e`
- `sha256(probabilities, f32 LE)` = `229d2f16807c6cfdc5603b5f76bcbc8112fece3bf6cb11f87400419a4250b41f`
- levels `[0.0001f32, 0.0008568746852688491, 0.00371924857608974, 0.013188526965677738, 0.043580953031778336, 0.1738850325345993]`

`include_bytes!` of the 274,625 decoded codes is fine if it is checked against the hash.

**`evaluate(word)`** (lines 301-325), lengths in **UTF-16 units**:
1. If `len < 3`, return 1.
2. `p = 1.0`. For each `i` from 2 to `len−1`: `score = 0.0001` (the **f64 literal**, not the f32 `probabilities[0]`); if all three indices are ≥ 0 and `code ≠ 0`, `score = probabilities[code] as f64`; `p *= score`; shift the window.
3. Return `p ** (1/(len−2))`.

An astral character counts as two unseen units. Measured: `abc` 0.00371924857608974, `name` 0.08705214205187382, `firstName` 0.038384182499689584, `user_id` 0.05747643443724488, `UUID` 0.1738850325345993, `xqzv` 0.0001, `émile` 0.009117021410717038.

**Floating point.** Products are sequential, left to right. A 4-unit word, or a class with n = 2, uses exponent **0.5**.

V8 (`--use-std-math-pow`, on by default) computes `**` and `Math.pow` with the platform libm `pow`, plus fdlibm-style special cases. Measured on macOS over 650k random pairs:
- V8 equals Apple's `pow`, except `y == 2` gives `x*x` and `y == 0.5` gives `sqrt(x)`. At those two exponents Apple's own `pow` differs in about 0.1–0.2% of inputs.
- The Rust `libm` crate (fdlibm `e_pow.c`) mismatches about 9% of inputs.

`js_pow(x, y)`:

| Condition | Result |
|---|---|
| `y` is NaN | NaN |
| `abs(x) == 1` and `y` is ±∞ | NaN |
| `y == 2` | `x*x` |
| `y == 0.5` and `x`'s sign bit is clear | `sqrt(x)` |
| otherwise | platform `pow` (Rust `f64::powf`, wrapped in `black_box` against constant folding) |

WASM has no platform libm. Ship a glibc `pow` port there, which matches Node on Linux. Apple and glibc differ in rare last bits, so the recording OS matters. The result only feeds `p > limit`, so the risk is a 1-ulp flip at a threshold; `22**5`, `3**5` and `(n+2)**5` are exact. `train` and `generate` (`--build-markov-chain`) are off the output path.

## 5. JS-semantics hazards (file:line)

1. **`JSON.parse`** (`CompressedJSON.ts:372`):
   - array-index keys come first;
   - a duplicate key keeps the last value in the first slot;
   - `__proto__` is an own property;
   - f64 precision: INT64_MAX becomes 2^63;
   - `(-0).toFixed(0)` is `"0"`;
   - `1e400` becomes ∞;
   - errors use V8's text.
2. **Stream path** (`src/CompressedJSONFromStream.ts:62`): `/[.e]/i` is tested per chunk; source order and duplicates are kept.
3. **UTF-16 lengths** (`CompressedJSON.ts:253`): `length <= 64` counts UTF-16 units.
4. **Plain-object dictionaries** (`CompressedJSON.ts:151`, `Inference.ts:359-375`): `"__proto__"` breaks them (§1.6). `Inference.ts:422` counts values, not objects, for optionality.
5. **Regex semantics** (`StringTypes.ts:208,223,232,249`; `DateTime.ts:35,38,47`):
   - `s[0]` is a UTF-16 unit;
   - in JS, `\d` is ASCII and `/i` without `u` folds ASCII only;
   - in Rust's `regex` crate, `\d`, `\s`, `\w` and `(?i)` are all Unicode.
6. **Markov lookups** (`MarkovChain.ts:277,305`): `charCodeAt` indexes an `Int8Array`, so codes ≥ 128 read `undefined`; lengths are UTF-16; `**` follows §4.
7. **Property sorting** (`JSONSchemaInput.ts:832-834`, via collection-utils `compareKeys`):
   - it is a stable sort using `<`, which compares UTF-16 units. Astral characters therefore sort after U+E000–U+FFFF in JS, but before them in Rust byte order;
   - `quicktypePropertyOrder` (line 1170) mixes numbers and strings: `3 < "abc"` is false both ways, while `3 < "10"` compares numerically. That makes the comparator inconsistent, so the result depends on V8's TimSort (binary insertion below 64 elements, galloping merges above). Port `array-sort.tq` if this case matters;
   - the TypeScript input always emits complete orders, so it is not affected.
8. **Case mapping** (`JSONSchemaInput.ts:829,1174`): `toLowerCase` uses full Unicode, including final sigma. Rust matches, modulo Unicode version (ICU 77 in Node 24).
9. **`decodeURIComponent`** (`JSONSchemaInput.ts:142-153`, urijs `recodePath`): throws `URIError: URI malformed`, outside any `try`.
10. **`typeof` and integer tests** (`JSONSchemaInput.ts:925`, `:912-914`): `schema.type ?? typeof schema.const` maps null to `"object"` and integers to `"number"`; `x === Math.floor(x)` treats `1.0` as an integer.
11. **`parsePath`** (`:161`): no JSON-pointer unescaping and no percent decoding.
12. **Message templates** (`Messages.ts:290-302`):
    - `replace` interprets `$` patterns and replaces only the first occurrence;
    - `JSON.stringify(undefined)` and `Array#toString` determine how values render.
13. **BOM and whitespace**:
    - `ParseJSON.ts:13` strips U+FEFF, but the CLI JSON path does not;
    - `NodeIO.ts:106` (is-url): JS `\s` includes U+FEFF and U+2028.
14. **Postman** (`PostmanCollection.ts:69`): `"raw" in null` throws, and `${method}` stringifies anything.
15. **Lone surrogates**: `\uD800` escapes produce them in both parsers, and Rust `String` cannot hold them.
    - None appear in the golden inputs.
    - Surrogate **pairs** do appear: `nst-test-suite.json`, `blns-object.json`, `6de06.json` (84 cases).

## 6. Proposed Rust design

**Strings.**

- Use `String`, combining `\u` surrogate pairs when decoding.
- Map lone surrogates to U+FFFD and document the gap (switch to WTF-8 only if needed). Node writes them as U+FFFD anyway, so only identity, length and sort can differ.
- Add `utf16_len`, `utf16_cmp` and `first_utf16_unit` to `support/`, and use them at every UTF-16 site in §5.

**CLI JSON** (`input/compressed_json_from_stream.rs`):
- Read everything and decode with `from_utf8_lossy`; do not strip a BOM.
- A single-pass tokenizer emits §1.2's events and copies stream-json's error strings **verbatim**, including whether each condition fires mid-input or at EOF.
- Numbers keep their lexeme; a number is a double iff the lexeme has `.`/`e`/`E` or fails `integer_string_in_range`.
- About 300 lines, with one test per error row.

**API JSON** (`support/js_json.rs`): a `JSON.parse` clone producing `JsValue {Null, Bool, Number(f64), String, Array, Object}`.

- `str::parse::<f64>` is correctly rounded like V8, and overflows to ∞.
- The object type is a `BTreeMap<u32, _>` of array-index keys (≤ 4294967294), iterated first, plus an `IndexMap` for the rest. Re-inserting a key overwrites in place.
- Port V8's error templates and context snippet (§1.3, §7).
- Reuse it for schemas, Postman, GraphQL schemas and the URL grammar.

Don't use `serde_json` here, except for test fixtures:
- it rejects lone surrogates;
- `preserve_order` doesn't reorder integer keys;
- `arbitrary_precision` changes the number model;
- its errors differ.

**Inference.**

- `CompressedJson { strings, index: HashMap<String,u32>, objects: Vec<Vec<Value>>, arrays }`.
- `UnionAccumulator` uses `IndexMap`s, mirroring `UnionBuilder.ts`.
- Emulate the `__proto__` quirk: push the name on every occurrence, reset its values each time, and dedupe at insert (first slot, last values).

**URIs** (`support/urijs.rs`): a `UriJs` with `Option<String>` fields (protocol, username, password, hostname, port, path, query, fragment) plus `urn`.

- Port `parse`, `build`, `normalize*`, `recodePath`, `absoluteTo`, `directory`, `filename`, `suffix`, `equals`, `parse/buildQuery` and the setters (§2.3).
- Port `encodeURIComponent` and `decodeURIComponent` exactly, including their `URIError`s.
- Defer punycode and IPv6 `best()`; they are reached only for non-ASCII or IPv6 hosts.

The `url` crate is wrong here:
- it requires absolute bases, but our addresses are relative (`test/x.schema`, `""`);
- WHATWG encoding and resolution differ (spaces, `file:`, drive letters);
- urijs quirks show up in `Ref.toString`, and therefore in messages and names.

**YAML.** Use `saphyr` (YAML 1.2; the successor of yaml-rust2) with a custom resolver that mirrors yaml 2.x core:
- `null`/`Null`/`NULL`/`~`/empty → null;
- `true`/`True`/`TRUE` and the false forms → booleans;
- decimal, `0o` and `0x` integers;
- floats, including `.inf`/`.nan`;
- everything else is a string, and `!!str` is honored;
- duplicate keys and multiple documents are errors;
- results are built as `JsValue`, which gives JS key order.

Avoid `serde_yaml`: it is deprecated and has YAML 1.1 leftovers. Clone YAML errors only up to the `Unknown exception YAMLParseError: ` prefix.

**HTTP.**

- Use blocking `ureq` with rustls; errors are `HTTP {status} {reason}`; bodies are decoded as lossy UTF-8.
- WASM needs a host fetch callback.
- Cache `ref-remote`'s URL so CI can replay offline.

**Other.**

- Hand-code the string recognizers.
- Use `js_pow` and keep the product order.
- Sort schema properties with a stable `sort_by(utf16_cmp)`. Port V8 TimSort only for mixed `quicktypePropertyOrder` keys.
- Never iterate a `HashMap` into output.

## 7. Edge cases to test

**Numbers**, on both paths and for each range kind (INT64, INT32, JS_SAFE, `null`):
- `1.0`, `1E2`, `-0`, `-0.0`;
- `9223372036854775807`/`8` and `-9223372036854775808`/`9`;
- `9007199254740993`, `1e20`, `1e21`, `1E400` (the API with Python infers `1e400` as an integer).

**Keys.**

- Order of `{"b","2","a","1","01","4294967295"}`.
- `{"a":1,"a":"x"}`: the CLI gives a union, the API gives a string.
- `[{"a":1,"a":2},{"b":1}]`: `a` is required in the CLI.
- A repeated `__proto__`.

**Strings.**

- 64 vs 65 UTF-16 units, with an emoji at the boundary.
- `"-0"`, `"007"`, `"2147483648"`, `"True"`; an uppercase UUID, `HTTP://x`, `https://a/{b}`, `"http://x\n"`.
- `2021-02-29` (a date, except in Kotlin), `T23:59:60Z`, lowercase `t`/`z`, `+0100`.
- Kotlin `.120`; Swift `2018-8-1T2:45:50+1`.

**Maps.** 500 vs 501 keys; 2-property classes (exponent 0.5); all-digit keys; 49/50 string-only properties; the 19/20 boundary.

**CLI errors.** Every row of §1.2, plus a BOM, an empty file, the missing-file `lstat` text, and empty stdin.

**API errors** (V8):
- `Unexpected end of JSON input`;
- `Unexpected token 'x', "x" is not valid JSON`, in each context form (`"…"...`, `..."…"`, `..."…"...`);
- `Unterminated string in JSON at position 4 (line 1 column 5)`;
- `Bad escaped character…`, `Bad Unicode escape…`, `Bad control character in string literal…`;
- `No number after minus sign…`, `Exponent part is missing a number…`;
- `Expected ':' after property name…`, `Expected ',' or '}' after property value…`, `Expected ',' or ']' after array element…`;
- `Expected property name or '}'…`, `Expected double-quoted property name…`;
- `Unexpected number…` (for `01`), `Unexpected non-whitespace character after JSON at position 8…`.

**Schema addresses.**

- Paths with spaces (they work, because addresses are decoded before reading); `100%.schema` (`URI malformed`).
- `a~1b.json`, `#/a/b%20c`, the `#item` anchor.
- `ref-id-files` (`a/test2.json` → `../b/test3.json#/foo`); a fragment ending in `/`; several `--src`; `--additional-schema`.

**Schema keywords.**

- `enum:[1.0]`; `{"const":5}` → double; a const with an array `type`; `["a",1,null]` → `number | enum | null`.
- `required:"a"` (error), `required:true` (ignored), draft-3 `required:true`; `properties.a:null` (TypeError).
- `patternProperties[".*"]`; `prefixItems` plus object `items`; boolean subschemas.
- Sort order: `Alpha`/`alpha`, and `"10"` vs `"2"`.

**YAML.** A YAML `.schema`; a trailing comma (accepted through YAML); duplicate YAML keys (a fetch error); `yes`, `0o17`, `1_000`, `.inf`.

**Postman.** Nested folders (post-order descriptions); invalid bodies are skipped; the same name twice; one request vs several (`fixedTopLevels`); `url` as a string or `null`.

**Markov.** The §4 vectors, and 4-character names near the threshold (`** 0.5` must be `sqrt`, not `libm::pow`).

