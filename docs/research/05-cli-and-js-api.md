# 05 — CLI and public JavaScript/Rust API

Reference: `quicktype` @ c39af7d3 (Node v24.16.0 used for every observation below). All paths are relative to
`quicktype/` unless they start with `rewrite/`. "TS" = the reference implementation.

Summary of findings:

* The CLI is one 1294-line file (`src/index.ts`). It is a **two-pass `command-line-args@5.2.1` parse** wrapped around
  `quicktypeMultiFile`. Help output comes from `command-line-usage@7.0.1`, which bundles table-layout 3.0.2,
  wordwrapjs 5.1.0, chalk-template and supports-color. The help text is the same for every argv, and colour changes
  the layout as well as adding escape codes.
* The golden corpus (10,132 cases) uses only one CLI shape: `--src-lang {json|schema|graphql} --lang L --src FILE
  --out FILE --top-level T --quiet --telemetry disable [--debug provenance] [renderer opts]`. It never covers stdout
  output, stdin, directories, URLs, `--help`, `--version` or any error path, so section 1 has to serve as the spec
  for those.
* Many CLI messages are written by the host runtime rather than by quicktype: V8 `JSON.parse`, libuv errno strings,
  undici, stream-json, yaml@2.9, graphql-js and the tsc diagnostics. A native Rust CLI has to reproduce each one.
  The WASM facade design in §4 gets them for free, because it leaves parsing and I/O in JS.
* Per the coordinator's decision, the npm packages keep the TS API as a facade. Each run makes **one async WASM call**,
  and Rust calls back into JS for JSON Schema fetches. A custom `TargetLanguage`, `Renderer`, `Input`,
  `CompressedJSON` or attribute producer falls back to the original TS engine.

---

## 1. The CLI

### 1.1 Control flow (`src/index.ts`)

```
entry (1273-1294): stdout/stderr 'error' handler → EPIPE ⇒ exit(0); main(argv.slice(2)).catch → "Error: <msg>." exit 1
main (1234-1271): parseCLIOptions(argv) | inferCLIOptions(obj)  → telemetry check → makeQuicktypeOptions → quicktypeMultiFile → writeOutput
parseCLIOptions (693-734): argv=[] ⇒ inferCLIOptions({help:true});
    pass 1: parseOptions(global defs, argv, partial=true) → inferCLIOptions → pick targetLanguage
    pass 2: parseOptions(global ++ lang.cliOptionDefinitions.actual, argv, partial=false) → inferCLIOptions
makeQuicktypeOptions (986-1188): help → usage(); version; build-markov-chain; sources by srcLang; --debug; Options
writeOutput (1190-1232)
```

* `main` also accepts a `Partial<CLIOptions>` object, which skips argv parsing (1238-1242). `test/unit/url-input.test.ts`
  relies on this.
* `inferCLIOptions` (310-381) runs in **both** passes, so its errors fire before help or version are handled:
  `quicktype --help --lang foo` gives `Error: Unknown output language foo.` with exit 1. The same happens for
  `--version --lang foo`.
* `--help` always prints the usage for **all** languages, because `usage(targetLanguages ?? defaultTargetLanguages)`
  is called without a list (991). `--help --lang cs` therefore prints exactly the same bytes as `--help`.
  `--help --version` prints the help only.

### 1.2 Global options (`makeOptionDefinitions`, 408-582), in definition order

| name | alias | type | typeLabel | default | description (help text) |
|---|---|---|---|---|---|
| out | o | string | FILE | – | The output file. Determines --lang and --top-level. |
| top-level | t | string | NAME | inferred | The name for the top level type. |
| lang | l | string | LANG | inferred / `go` | The target language. (only defined if >1 target languages) |
| src-lang | s | string | SRC_LANG | `json` (inferred) | The source language (default is json). |
| src | – | string, multiple, **defaultOption** | FILE\|URL\|DIRECTORY | `[]` | The file, url, or data directory to type. |
| src-urls | – | string | FILE | – | Tracery grammar describing URLs to crawl. |
| no-maps, no-enums, no-uuids, no-date-times, no-integer-strings, no-boolean-strings, no-combine-classes, no-ignore-json-refs | – | boolean | – | false | `${inferenceFlags[f].negationDescription}.` (469-478). Name = dashed(`no`+Capitalize(name minus `infer`)) |
| graphql-schema | – | string | FILE | – | GraphQL introspection file. |
| graphql-introspect | – | string | URL | – | Introspect GraphQL schema from a server. |
| http-method | – | string | METHOD | `POST` (1019) | HTTP method to use for the GraphQL introspection query. |
| http-header | – | string, multiple | HEADER | – | Header(s) to attach to all HTTP requests, including the GraphQL introspection query. |
| additional-schema | S | string, multiple | FILE | `[]` | Register the $id's of additional JSON Schema files. |
| no-render | – | boolean | – | false | Don't render output. (hidden in help) |
| alphabetize-properties | – | boolean | – | false | Alphabetize order of class properties. |
| all-properties-optional | – | boolean | – | false | Make all class properties optional. |
| build-markov-chain | – | string | FILE | – | Markov chain corpus filename. (hidden) |
| quiet | – | boolean | – | false | Don't show issues in the generated code. |
| debug | – | string | OPTIONS or all | – | Comma separated debug options: print-graph, print-reconstitution, print-gather-names, print-transformations, print-schema-resolving, print-times, provenance |
| telemetry | – | string | enable\|disable | – | Enable anonymous telemetry to help improve quicktype |
| help | h | boolean | – | false | Get some help. |
| version | v | boolean | – | false | Display the version of quicktype |

`dashedFromCamelCase` (402) uses core's `splitIntoWords`. For the 8 inference flags in `Inference.ts`, the flag names
above are the complete output, so they can be hard-coded.

### 1.3 Renderer options per language

* `TargetLanguage.cliOptionDefinitions` (`packages/quicktype-core/src/TargetLanguage.ts:51-63`) concatenates each
  option's `cliDefinitions`, in the language's `getOptions()` key order.
* For `BooleanOption` (`RendererOptions/index.ts:86-104`):
  * `actual` holds `[def, {…def, name:"no-"+name, defaultValue: !default}]`.
  * `display` holds a single entry `{name:"[no-]"+name, description: desc+" (on|off by default)"}`.
* `EnumOption` sets `typeLabel` to `Object.keys(values).join("|")` (172). `StringOption` has an explicit typeLabel.
* **Every renderer definition carries `defaultValue`.** command-line-args pre-populates any option that has a default
  (`Output` constructor). As a result, `rendererOptions` contains **every** option of the selected language, including
  both `x` and `no-x` for booleans. Observed for `-l cs x.json`:
  `{"framework":"SystemTextJson","array-type":"array",…,"virtual":false,"no-virtual":true,…}`.
* `parseOptions` (739-793) iterates over the *definitions*, so key order is definition order:
  * Options with `kind !== "cli"` are stored under their dashed name in `rendererOptions`.
  * CLI options are camel-cased with `lowerFirst(split("-").map(upperFirst).join(""))`.
  * Any `null` value (a string option given without a value) raises
    `DriverCLIOptionParsingFailed` with `Missing value for command line option "<name>"`.
* `BooleanOption.getValue` (106-128) combines `x` and `no-x`. Booleans arrive as JS booleans; the strings
  "true"/"false" are also accepted.
* There are no name or alias collisions between global and renderer options (checked for all 27 languages). A
  collision would raise `INVALID_DEFINITIONS`.

### 1.4 command-line-args 5.2.1 semantics to replicate (`node_modules/command-line-args/dist/index.js`)

* Long `--name` and short `-x`. Combined shorts are split, so `-lts` becomes `-l -t -s`; this produces
  `Missing value for command line option "lang"`.
* `--name=value` sets the value, but only for long options (`re.optEquals`).
  * `--bool=…` emits `UNKNOWN_VALUE` and then sets true. Strict mode fails with
    `Option parsing failed: UNKNOWN_VALUE: Unknown value: --just-types=false.`
  * `--namespace=` sets the empty string.
  * `-o=x.ts` is treated as a combined short and fails with `Missing value … "out"`.
* A value-taking option consumes the next value. `-` and negative numbers count as values (`re.short` excludes digits).
  A bare value with no pending option goes to the `defaultOption` (`src`, multiple).
* `type: Boolean` options take no value: `--quiet foo` sets quiet and sends `foo` to src.
* A singular option set twice throws `ALREADY_SET`: `Singular option already set [out=list.go]`. This is pinned by
  `test/unit/cli-options.test.ts`.
* Unknown options:
  * In the partial first pass they go to `_unknown`. The value after an unknown option is **assigned to `src`** in
    pass 1, which can change pass-1 inference (`srcLang`, `topLevel`), but only `lang` survives from pass 1.
  * In strict pass 2 they fail with `UNKNOWN_OPTION: Unknown option: --foo`.
* Error text is `exceptionToString(e)` = `e.toString()` = `${name}: ${message}`
  (`@glideapps/ts-necessities/dist/index.js:159`), wrapped as `Option parsing failed: ${…}` (Messages.ts:247).
* `supports-color` also scans `process.argv` for `--color`, `--no-color` and similar. Those flags are then rejected by
  the parser as unknown options anyway.

### 1.5 Inference of srcLang, lang and topLevel (`inferCLIOptions` 310-381)

* **srcLang**:
  * If `graphqlSchema` or `graphqlIntrospect` is set, srcLang must be unset or `graphql`; otherwise
    `DriverSourceLangMustBeGraphQL`.
  * Otherwise, if `src` is non-empty and **every** src ends with `.ts`, srcLang becomes `typescript`.
  * Otherwise `srcLang==="graphql"` raises `DriverGraphQLSchemaNeeded`, and the default is `json`.
* **lang**:
  * Taken from `opts.lang` if set.
  * Otherwise, if `--out` is set, it is the extension of `out` without the dot (`path.extname`). An empty extension
    raises `DriverNoLanguageOrExtension`. The extension is used **as a language name**, so it works only when it equals
    one of the language's `names`: `.cs`, `.ts`, `.go`, `.py`, `.rs`, `.java`, `.swift`, `.dart`, `.elm`, `.php` and
    `.js` work. `.kt`, `.hpp`, `.m`, `.rb`, `.ex` and `.h` give `Unknown output language kt` and so on. Verified for
    `.kt` and `.py`.
  * Otherwise the default is `"go"` (106).
  * An unknown name raises `DriverUnknownOutputLanguage`. The `"typescript"` fallback at 716-718 is unreachable.
  * The resolved `lang` is `language.name`, i.e. `names[0]`; `-l csharp` becomes `cs`.
* **topLevel** (291-308):
  * With `--out`: `basename(out).replace(extname(out), "")`, using the first occurrence.
  * Else with exactly one src: the same rule applied to that src. `-` therefore gives `-`, which the renderer turns
    into the type name `Empty`.
  * Otherwise `TopLevel`.
  * GraphQL with more than one query file uses `typeNameFromFilename` (121): basename up to the last `.`, or `""` if
    there is none.

Language names, in `defaultTargetLanguages` order (`language/All.ts:38-66`; `name`=first, synopsis label=first
shortest): cjson[cjson,cJSON] c++[c++,cpp,cplusplus] crystal[crystal,cr,crystallang] cs[cs,csharp] dart elixir elm
flow go[go,golang] haskell java javascript[javascript,js,jsx] javascript-prop-types schema[schema,json-schema] kotlin
objc[objc,objective-c,objectivec] php pike[pike,pikelang] python[python,py] ruby rust[rust,rs,rustlang] scala3
smithy4a swift[swift,swift4] typescript[typescript,ts,tsx] typescript-effect-schema typescript-zod.

### 1.6 Sources (`makeQuicktypeOptions` 1009-1107, `getSources` 863-895, `samplesFromDirectory` 127-272)

* **json/schema** (`getSources`), in this order:
  1. `getSourceURIs` (819-839).
     * With `--src-urls F`: `parseJSON(readFromFileOrURL(F))` (JSON, falling back to YAML), expanded by
       `urlsFromURLGrammar` (`src/URLGrammar.ts`). A string expands to `[s]`; an array to the cartesian concatenation;
       `{oneOf:[…]}` to the union. Anything else gives
       `panic("Value is not a valid URL grammar: ${json}")`. Each top-level key becomes one type.
     * Else, with an empty `src`: `[[topLevel, ["-"]]]`, i.e. **stdin**.
  2. Every src that exists and `lstat().isDirectory()` goes through `samplesFromDirectory`.
     * Files in the directory, matched on the lowercased name:
       * `*.url`: the contents (trimmed) are a URL.
       * `*.json` / `*.url`: a JSON source named by `typeNameFromFilename`.
       * `*.schema`: a schema source.
       * `*.gqlschema`: at most one per directory, otherwise `DriverMoreThanOneGraphQLSchemaInDir`.
       * `*.graphql`: a query. A query without a schema gives `DriverNoGraphQLSchemaInDir`.
     * One level of subdirectories: all JSON samples are merged under the subdirectory's basename. Mixing JSON with
       schema or GraphQL gives `DriverCannotMixJSONWithOtherSamples`; mixing schema with GraphQL gives
       `DriverCannotMixNonJSONInputs`.
     * **Order**: Node `fs.readdirSync` goes through libuv `scandir`, which **sorts entries by `strcmp`** (verified:
       `10 9 Alpha C _x a b zeta é`). Rust's `read_dir` returns raw OS order, so it must sort by bytes.
  3. All remaining srcs (non-directories) are combined into **one** source named `topLevel`:
     * json: one source whose samples are all the files, so `a.json b.json` merges into a single `TopLevel`.
     * schema: one `{kind:"schema", name: topLevel, uris:[u]}` per uri.
* **Reading** goes through `readableFromFileOrURL` (`packages/quicktype-core/src/input/io/NodeIO.ts:99-142`):
  * `file://` paths are converted with `filePathFromFileURI`.
  * `is-url@1.2.4` decides what is a URL (`^(?:\w+:)?\/\/(\S+)$`, then a localhost rule or `^[^\s.]+\.\S{2,}$`). URLs
    are fetched with global `fetch` plus the `--http-header` headers, parsed by splitting at the first `:` and
    trimming. A non-ok response throws `HTTP ${status} ${statusText}`.
  * `-` reads stdin.
  * Paths go through `resolveSymbolicLink` (`lstatSync`, **which throws ENOENT for a missing file**) and are read as a
    utf8 stream.
  * Any throw becomes `MiscReadError`. `DriverInputFileDoesNotExist` is effectively unreachable for missing paths.
* JSON samples in the CLI are parsed by `CompressedJSONFromStream` (`src/CompressedJSONFromStream.ts`, stream-json
  3.5.0). This is **not** the core's `JSON.parse` path:
  * keys stay in source order and duplicates are kept;
  * numbers are classified from the literal text (`[.e]` means double, otherwise an integer-range check on the digit
    string);
  * errors are stream-json's, e.g. `Parser has expected a value`. The full list is in
    `stream-json/src/core/parser.js:151-590`.
  * The CLI defines its own `jsonInputForTargetLanguage` (904-923). Unknown names map to `typescript`.
* **graphql** (1013-1069):
  * `--graphql-introspect URL` calls `introspectServer` (`src/GraphQLIntrospection.ts`): `fetch` with `method`
    (default POST), headers `Accept`/`Content-Type: application/json` plus user headers (regex
    `^([^:]+):\s*(.*)$`, otherwise panic), and body `JSON.stringify({query: getIntrospectionQuery()})` (graphql@16.14.2,
    1927 chars; embed it verbatim).
    * Result: `JSON.stringify(result, null, 2)`.
    * Failures become `Internal error: Error while fetching introspection query result: TypeError: fetch failed`.
    * GET with a body fails inside fetch.
  * With `--graphql-schema F` the schema is also written to F. If `src.length !== 1`, the run then stops.
  * With no src and no file, the schema goes to **stdout** via `console.log`. Otherwise
    `DriverNoGraphQLQueryGiven`.
  * Each query file becomes `{name, schema: parseJSON(schema), query: getStream(file)}`.
* **typescript**: `schemaForTypeScriptSources(src)` → schema source (§3.2).
* **postman**: `sourcesFromPostmanCollection(readFileSync(f))`. With more than one source, `fixedTopLevels=true`. The
  collection description becomes `leadingComments = wordwrap(90)(desc).split("\n")`, using **substack `wordwrap@1.0.0`**,
  a different algorithm from wordwrapjs.
* `--additional-schema` goes into `new JSONSchemaInput(new FetchingJSONSchemaStore(httpHeaders), [], additional)`
  (954-963).
* Unknown srcLang gives `DriverUnknownSourceLanguage`.
* `handleJSONRefs` is `ignoreJsonRefs !== true` (1182).
* Inference flags: `quicktypeOptions[flag] = !cliOptions[noFlag]` (1168-1176).
* `--debug` (1109-1141): comma-split and trimmed. `all` enables everything; anything unknown gives
  `DriverUnknownDebugOption`.
  * Debug output goes to **stdout** through `console.log`, interleaved with the generated code.
  * `print-times` prints `${name} took ${ms.toFixed(3)}ms`.
  * `provenance` sets `checkProvenance`, which the golden corpus uses in 9970 cases.
* `--build-markov-chain F`: `console.log(JSON.stringify(trainMarkovChain(lines, 3)))`.
* `--no-render` makes the output `Done.\n`.

### 1.7 Output (`writeOutput` 1190-1232)

* `outputFilename = basename(out)`, or `"stdout"` (Run.ts:140). The renderer may add files (Java, ObjC, cJSON/C++
  multi-source and others).
* **With `--out`**: each file is written with `fs.writeFileSync(join(dirname(out), filename), lines.join("\n"))`.
  * There is no mkdir. A missing directory gives `Error: ENOENT: no such file or directory, open '<path>'.` with exit 1.
  * There is no trailing newline beyond what `lines` contains; renderers end with `""`.
* **Without `--out`** (stdout):
  * Files after the first are preceded by `"\n"`.
  * When there is more than one file, each is preceded by `// ${filename}\n\n`.
  * Each file is followed by `lines.join("\n")`.
  * For example, Java prints `// Converter.java⏎⏎…}⏎⏎// N.java⏎⏎…`.
* **Issues** (unless `--quiet`): for each annotation that is `instanceof IssueAnnotationData`,
  `console.error("\nIssue in line ${l+1}: ${message}")` and then `console.error("${l+1}: ${lines[l]}")`.
  Line numbers are per file.

### 1.8 `--help`, `--version`

`--version`: two lines on stdout, `quicktype version 24.0.0` and `Visit quicktype.io for more info.`
(`packageJSON.version` at runtime, 996-997).

`--help` is `console.log(commandLineUsage(sections))` (795-816). The sections are:
* Synopsis and Description (content);
* `Options`, an optionList that hides `no-render` and `build-markov-chain` (653-660);
* one `Options for ${displayName}` per language, built from `cliOptionDefinitions.display` and skipping languages with
  none (Crystal, JSON Schema and Pike: **24 sections**);
* Examples and a footer.

Layout rules (`node_modules/command-line-usage/dist/index.cjs`):
* Output: `"\n" + sections.join("\n")`, plus console.log's `"\n"`.
  * A section is: `[bold(header), ""]` (if there is a header), then the table lines, then `""`.
  * Lines are joined with **`os.EOL`** (CRLF on Windows), while the joins between sections use `"\n"`.
* **Content** (string or string[]) is rendered as a table with one column and padding `"  "`/`" "`; `maxWidth` 80
  (3920-3980).
  * `contentWidth` is the longest ANSI-stripped row. width = `contentWidth+3`. If that exceeds 80 and the cell is
    wrappable (more than one chunk), width = `floor(80/1)` = 80.
  * Wrap width = width-3. Each line is `"  " + cell.padEnd(width-3+ansiLen) + " "`. Content lines are therefore 80
    chars (the footer is 29).
* **Option lists** use `tableOptions` `{columns:[{name:"option",width:60},{name:"description",width:60}]}` (616-627)
  with default padding `" "`/`" "`. Both columns are fixed, so the wrap width is 58 and every row is exactly
  **120 chars**: `" "+opt.padEnd(58)+"  "+desc.padEnd(58)+" "`. A multi-line row pads the shorter cell with `""`.
  * Option cell: `{bold -a}, {bold --name} LABEL`, or `{bold --name} LABEL`.
  * LABEL = `typeLabel`, or `""` for boolean (the CLI sets `type` to `Boolean`/`String`, 589-596). That leaves a
    trailing space, which wrapping trims.
* **wordwrapjs**:
  * Split on `/\r\n|\n/` and trim each line. An empty line becomes `~~empty~~`.
  * Chunk with `/[^\s-]+?-\b|\S+|\s+|\r\n?|\n/g`; words therefore break *after hyphens*.
  * Greedy packing: if `len(chunk)+len(cur) > width`, start a new line with the chunk, even if the chunk is
    whitespace. Lengths are measured with ANSI (`/\u001b.*?m/g`) stripped and use **UTF-16 `.length`**.
  * Trim, drop empty lines, and turn `~~empty~~` back into `""`. An over-long single chunk overflows without being
    broken.
* Every description, content string and label passes through **chalk-template**: backticks are escaped first, then
  `{style …}` blocks and `\` escapes are interpreted. No current description contains braces, and Dart's
  ``Use this name in `part` directive`` comes out unchanged.
* **Colour**: chalk 4 (root, used for `chalk.bold`/`chalk.dim`/`chalk.red`) and the chalk bundled in
  command-line-usage both use the supports-color 7 rules for **stdout**:
  * `FORCE_COLOR` (`0`/`false` off, `""`/`true`/`1-3` on) and `--color`/`--no-color` in argv take precedence.
  * Otherwise a non-TTY stdout is **uncoloured**.
  * `TERM=dumb`, the `CI` variables and `COLORTERM` are also considered.
  * Escape codes: bold `\e[1m…\e[22m`, dim `\e[2m…\e[22m`, red `\e[31m…\e[39m`.
  * The TTY output (verified through a pty) is identical to the `FORCE_COLOR=1` output.
* **The coloured layout differs from the plain one.** chalk 4 re-opens styles after each `\n`, so the dim
  directory-tree example keeps its indentation when coloured (`  \e[2m    - bar-sample-1.json\e[22m`). In plain text,
  wordwrap trims the same lines to `  - bar-sample-1.json`.
* The red telemetry error is written to **stderr**, but its colour follows **stdout's** TTY state.

Plain output (non-TTY). Each line is right-padded with spaces to the width shown:
```
⏎Synopsis⏎⏎
  $ quicktype [--lang LANG] [--src-lang SRC_LANG] [--out FILE] FILE|URL ...      (80)
                                                                                 (80 spaces)
  LANG ... cjson|c++|cr|cs|dart|elixir|elm|flow|go|haskell|java|js|javascript-   (80)
  prop-                                                                          (80)
  types|schema|kotlin|objc|php|pike|py|ruby|rs|scala3|smithy4a|swift|ts|typescript-  (84: overflow chunk)
  effect-schema|typescript-zod                                                   (80)
                                                                                 (80)
  SRC_LANG ... json|schema|graphql|postman|typescript                            (80)
⏎Description⏎⏎  Given JSON sample data, quicktype outputs code for working with that data in  (80) … TypeScript Zod.
⏎Options⏎⏎
 -o, --out FILE                                              The output file. Determines --lang and --top-level.         (120)
 --http-header HEADER                                        Header(s) to attach to all HTTP requests, including the     (120)
                                                             GraphQL introspection query.                                (120)
 --type-style pascal-case|underscore-case|camel-case|upper-  Naming style for types                                      (cJSON, 120)
 underscore-case|pascal-case-upper-acronyms|camel-case-                                                                  (120)
 --[no-]header-only                                          Generate headers only (on by default)                       (120)
…
Examples: "  Generate C# to parse a Bitcoin API" / "  $ quicktype -o LatestBlock.cs https://…" / "" (80 spaces) /
          "  - Foo.json", "  + Bar", "  - bar-sample-1.json" (indent lost) … 
"  Learn more at quicktype.io " (29) ⏎ ⏎(console.log)
```
The full plain help is 339 lines and 30,027 bytes; the FORCE_COLOR version is 32,097 bytes. **Recommendation:** port
the four libraries (about 300 LoC of Rust: wordwrap, table autosize, chalk-template subset, supports-color). Snapshot
both variants as new CLI golden cases, captured with
`node dist/index.js --help > help.txt` and `FORCE_COLOR=1 node dist/index.js --help > help-color.txt`. Do not embed
static strings: the help is derived from the language option tables, so it is a good consistency check for them.

### 1.9 Errors, exit codes, EPIPE, telemetry

* Any rejection from `main` is printed as `console.error("Error: ${e.message}.")` with exit **1**. The period is always
  appended, so messages already ending in `.` end in `..`. Non-Error values are printed with `console.error(e)`.
* `QuickTypeError.message` is the substituted template (§4.3). `panic`, `assert`, `defined` and `assertNever` all
  produce `Internal error: …` (`support/Support.ts:81-103`).
* Exit **0** cases:
  * normal completion, help and version;
  * an invalid `--telemetry` value: it prints `telemetry must be 'enable' or 'disable'` (red, per stdout's colour) to
    stderr and **returns without generating code**;
  * `--telemetry enable|disable` when it is the *only* argument pair (`args.length===2`, 1257);
  * `EPIPE` on stdout or stderr (1274-1283; pinned by `cli-epipe.test.ts`). Rust ignores SIGPIPE, so every write error
    with `BrokenPipe` must lead to `exit(0)`.
* Telemetry: **there is no telemetry implementation left**, only validation. Nothing is sent and nothing is stored.

Observed outputs (stderr unless noted; exit 1 unless noted):
```
--foo                     Error: Option parsing failed: UNKNOWN_OPTION: Unknown option: --foo.
--lang                    Error: Option parsing failed: Missing value for command line option "lang".
-o list.go -o list.ts     Option parsing failed: ALREADY_SET: Singular option already set [out=list.go]
-l cs --framework foo a.json   Error: Unknown value foo for option framework.
nonexistent.json          Error: Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'.
-o foo a.json             Error: Please specify a language (--lang) or an output file extension.
--debug bad a.json        Error: Unknown debug option bad.
--src-lang graphql a.json Error: Please specify a GraphQL schema with --graphql-schema or --graphql-introspect.
--src-lang foo a.json     Error: Unknown source language foo.
bad.json ('{"a":')        Error: Syntax error in input JSON bad: Parser has expected a value.
-l python3 a.json         Error: Unknown output language python3.
bad.graphql               Error: Syntax Error: Expected Name, found <EOF>..            (graphql-js message)
unknown gql field         Error: Internal error: Required field nosuchfield not defined on type User..
foo.ts outside cwd        Error: TypeScript error: File '/abs/foo.ts' is not under 'rootDir' '.'. … (multi-line)
TS type error             Error: TypeScript error: Cannot find name 'strin'. Did you mean 'string'?.
Set<string> in TS         Error: TypeScript error: quicktype's TypeScript input does not support 'Set<string>' - use an array type instead.
--graphql-introspect http://127.0.0.1:1/   Error: Internal error: Error while fetching introspection query result: TypeError: fetch failed.
--telemetry xyz a.json    telemetry must be 'enable' or 'disable'   (exit 0, no output)
```
The native CLI has to reproduce these host-produced fragments verbatim:
* libuv `ENOENT: no such file or directory, lstat '…'` / `open '…'` (format `${code}: ${uv_strerror}, ${syscall} '${path}'`);
* undici `TypeError: fetch failed`;
* stream-json parser messages;
* yaml@2.9 errors (`parseJSON` falls back to YAML; a YAMLParseError is not a SyntaxError, so the message is
  `Unknown exception YAMLParseError: …` with a code frame);
* graphql-js syntax errors;
* tsc diagnostics.

---

## 2. Public JS API of quicktype-core (`packages/quicktype-core/src/index.ts`, 131 lines)

There are 169 runtime exports (enumerated from `dist/index.js`) plus types. The package is dual CJS
(`dist/index.js`) and ESM (`dist/esm/index.js` + `{"type":"module"}`). The `exports` map also exposes `./dist/*`, and
the tests deep-import `dist/DateTime.js`, `dist/language/Kotlin/utils.js` and `dist/support/WindowsPaths.js`. The
`"browser": {fs:false, path:false}` field must keep working.

Classes: **(a)** data in/data out, straightforward through WASM; **(b)** needs JS callbacks or host I/O across the
boundary; **(c)** class inheritance or an object-graph extension point that cannot be replicated literally through
WASM.

| group (index.ts lines) | exports | class |
|---|---|---|
| Run (1-10) | `quicktype`, `quicktypeMultiFile` | b (`onTiming` callback, schema store) |
| | `quicktypeMultiFileSync`, `combineRenderResults`, `getTargetLanguage`; types `Options`, `QuicktypeTiming`, `RunContext` | a (RunContext: c) |
| Inference (11-18) | `inferenceFlags`, `inferenceFlagNames`, `defaultInferenceFlags`, `inferenceFlagsObject`, types | a (constants) |
| Compressed JSON (19) | `CompressedJSON` (abstract; the CLI subclasses it), `Value` | c |
| Integer ranges (20-28) | `INT8/16/32/64_RANGE`, `JS_SAFE_INTEGER_RANGE`, `integerStringInRange`, `IntegerRange` | a |
| Inputs (29-44) | `InputData` (`addSource(kind, src, makeInput)` takes a factory callback), `JSONInput`, `jsonInputForTargetLanguage` | b |
| | `Input` interface (user-implementable; GraphQLInput is one) | c |
| | `JSONSchemaInput` (optional `JSONSchemaAttributeProducer[]` callbacks, store), `Ref`, `JSONSchemaType`, `JSONSchemaAttributes` | b/c |
| Rendering (45-56) | `RenderContext`, `Option`, `OptionDefinition`, `getOptionValues`, `OptionValues`, `TargetLanguage`, `MultiFileRenderResult` | Option/getOptionValues a; TargetLanguage c |
| Source (57-67) | `modifySource`, `singleWord`, `parenIfNeeded`, `MultiWord`, `Sourcelike`, `SerializedRenderResult`, `Annotation`, `Name`, `funPrefixNamer`, `Namer`, `IssueAnnotationData` | c (renderer authoring), except SerializedRenderResult/IssueAnnotationData: a |
| Support (68-87) | `panic`, `assert`, `defined`, `assertNever`, `checkStringMap`, `checkArray`, `parseJSON`, `splitIntoWords`, `capitalize`, `combineWords`, `firstUpperWordStyle`, `allUpperWordStyle`, `legalizeCharacters`, `isLetterOrDigit`, `trainMarkovChain`, `QuickTypeError`, `messageError`, `messageAssert` | a |
| Type graph (88-101, 109-129) | `Type`, `PrimitiveType`, `ArrayType`, `ClassType`, `ClassProperty`, `EnumType`, `MapType`, `UnionType`, `ObjectType`, `TypeKind`…, `TypeBuilder`, `StringTypeMapping`, `TypeRef`, `derefTypeRef`, `TypeAttributeKind`, `TypeAttributes`, `emptyTypeAttributes`, `TypeNames`, `makeNamesTypeAttributes`, `namesTypeAttributeKind`, `StringTypes`, `removeNullFromUnion`, `matchType`, `nullableFromUnion`, `ConvenienceRenderer`, `uriTypeAttributeKind` | c |
| I/O (102-108) | `getStream`, `readableFromFileOrURL`, `readFromFileOrURL` (Node streams, fetch) | b (stay JS) |
| | `FetchingJSONSchemaStore` | b |
| | `JSONSchemaStore` (abstract `fetch`) | b/c: subclassed in practice, but only one async method |
| | `JSONSchema`, `sourcesFromPostmanCollection` | a |
| Languages (131, `language/index.ts`) | 27 `*TargetLanguage` classes, 36 `*Renderer` classes, 26 option objects (`cSharpOptions`…`typeScriptZodOptions`) | c (classes); option objects a |
| | `defaultTargetLanguages`, `languageNamed`, `isLanguageName`, `LanguageName`, `LanguageDisplayName`, `RendererOptions` | a, but return TargetLanguage instances |

API consumers:
* `packages/quicktype-vscode/src/extension.ts:95-160` uses `defaultTargetLanguages`, `languageNamed`,
  `isLanguageName`, `lang.displayName`, `.name`, `.optionDefinitions`, `InputData.addSource` with factories,
  `jsonInputForTargetLanguage(lang)`, `new JSONSchemaInput(undefined)`, `schemaForTypeScriptSources`, `quicktype()`,
  and **passes TargetLanguage instances** as `lang`.
* The CLI uses `IssueAnnotationData` through `instanceof`, subclasses `CompressedJSON`, and drives `GraphQLInput`
  through `TypeBuilder`.

**Proposal for (c).** Under the coordinator's design, the npm package keeps the original TS implementation of every
export, so subclassing works literally: `class X extends TypeScriptRenderer` is the real class. A run is
**WASM-eligible** only when all of the following hold:
1. `lang` is a name, or an instance whose **exact** prototype is one of the 27 built-in classes;
2. every `Input` is an exact built-in (`JSONInput` over `CompressedJSONFromString`/`CompressedJSONFromStream`,
   `JSONSchemaInput` with no extra attribute producers, `GraphQLInput`);
3. the JSON inputs' `dateTimeRecognizer` is an exact Default, Kotlin or Swift recognizer;
4. `leadingComments` contain only string Sourcelikes.

Every other run goes through the TS engine, with identical output by construction. This removes (c) from the WASM
contract entirely; the Rust core never has to model JS subclasses.

---

## 3. quicktype-graphql-input and quicktype-typescript-input

### 3.1 `quicktype-graphql-input` (709 + 666 lines)
* Exports `GraphQLInput implements Input<GraphQLSourceData>` (`src/index.ts:662-709`) and
  `GraphQLSourceData {name, query: string, schema: any}` (649-654).
* `addSource`/`addSourceSync` only store the data.
* `addTypes` → `makeGraphQLQueryTypes` → `graphql.parse(query)` (208, graphql-js 16) plus an introspection-JSON walker
  that uses the public `TypeBuilder` (`getPrimitiveType`, `getClassType`, `getArrayType`, `getUnionType`,
  `getEnumType`, `getStringType`, `makeClassProperty`, `addTopLevel`). Top-level naming: when there is exactly one
  top-level, its name is used; otherwise the operation names.
* **Rust:** port 1:1 as crate `quicktype-graphql-input`, implementing core's public `Input` trait (§5).
  * The query parser should be a port of graphql-js's lexer and parser (executable definitions only; about 1.5k LoC),
    so that `Syntax Error: Expected Name, found <EOF>.`-style messages and AST shapes match. Do not use apollo-parser.
  * `GraphQLSchema.ts` holds generated enums only.
  * The golden corpus has 162 graphql cases, all with valid queries.
  * In the WASM path the query text is sent to Rust, so there is a single parser implementation.

### 3.2 `quicktype-typescript-input` (316 lines)
* `schemaForTypeScriptSources(fileNames): JSONSchemaSourceData` (`src/index.ts:204-316`).
* Pipeline:
  1. `ts.createProgram` with ES2015 plus the dom, webworker.importscripts and scripthost libs, strictNullChecks and
     `rootDir:"."`. Files outside the cwd therefore fail.
  2. The first pre-emit Error diagnostic becomes `TypeScriptCompilerError` (`flattenDiagnosticMessageText`).
  3. `typescript-json-schema@0.67.4` `generateSchema(program, "*", {required, titles, topRef, noExtraProps, propOrder})`,
     with `getTypeDefinition` monkey-patched for Map/ReadonlyMap → `additionalProperties`. Set, WeakMap, WeakSet and
     Promise are errors.
  4. Enum `qt-accessors`, JSDoc `{type}` brace stripping, `export default` ref swap, `propertyOrder` →
     `quicktypePropertyOrder`, and the `#TopLevel` marker.
  5. Result: `{schema: JSON.stringify(schema), name, uris, isConverted: true}`.
* The output is a **JSON string**, which makes it an ideal boundary.
* Options for Rust:

| option | parity | cost | notes |
|---|---|---|---|
| Port onto oxc/swc | low | very high | oxc and swc have parsers and scopes but **no type checker**. typescript-json-schema depends on `checker.getTypeAtLocation`, `typeToString`, generic instantiation, mapped, conditional and utility types (`Partial`, `Pick`, `Record`), lib.d.ts (`Date`, `Map`), literal widening, and declaration merging across imports. Diagnostics such as "Did you mean 'string'?" cannot be reproduced. No usable Rust TS checker exists (stc is abandoned, ezno is experimental). |
| Keep the JS shim (npm) | exact | none | npm `quicktype-typescript-input` stays unchanged. It emits a schema string that the facade feeds to WASM like any schema source. |
| Native CLI runs a bundled JS shim via `node` | exact | low | esbuild-bundle typescript 5.9.3, tjs 0.67.4 and the 4 lib files (about 9 MB). Spawn `node`, pass file names, read back JSON or `{error}`. Requires Node at runtime and gives a clear error if it is missing. |
| Native CLI embeds a JS engine | exact | medium | deno_core/V8 adds about 30-40 MB to the binary. QuickJS (rquickjs) is small, but the tsc checker would take seconds. Boa has compatibility risk. |

**Recommendation:** use the JS shim on npm. For the native CLI, put `--src-lang typescript` behind a cargo feature
`typescript-node` (spawn node) and optionally `typescript-v8` later. There are **0 TypeScript cases in the golden
corpus**, so this does not block the parity gate.

---

## 4. npm packages: TS facade + WASM engine (coordinator decision)

### 4.1 What is reused verbatim, what changes

Because the TS engine must remain as the fallback, **all of `packages/quicktype-core/src/**` ships unchanged except
`Run.ts`**. The WASM path is a dispatch inside `Run.run()`/`runSync()`. All other bridge code lives in new files that
read the existing objects. Private fields are accessible at runtime, and not adding members keeps every `.d.ts`
byte-identical.

* **Verbatim (facade role):**
  * `index.ts` (export list unchanged).
  * `input/Inputs.ts` (`InputData`, `JSONInput`, `jsonInputForTargetLanguage`).
  * `input/CompressedJSON.ts`: JSON.parse plus string-format tagging. The tables it builds become the wire format.
  * `input/JSONSchemaInput.ts`:
    * `addSourceSync`, i.e. URI normalisation with urijs and the `-N` suffixing;
    * `Ref`;
    * `InputJSONSchemaStore`, which serves inline schema strings, parses them with `parseJSON` (JSON then YAML) and
      times `parse JSON Schema`.
  * `input/JSONSchemaStore.ts` and `FetchingJSONSchemaStore.ts`: cache, error swallowing and debug prints stay in JS.
  * `input/io/**`, `support/ParseJSON.ts`, `input/PostmanCollection.ts`.
  * `Messages.ts`: `messageError` is called **in JS** to build the error.
  * `Annotation.ts`, `RendererOptions/**`, `TargetLanguage.ts` and `language/**`. These provide metadata, the
    instances users hold, and the fallback engine.
  * Everything else is the fallback engine (Type/**, rewrites/**, Renderer/ConvenienceRenderer, Naming and so on).
* **Modified:**
  * `Run.ts`: keep `preRun()` in JS, including the JSON Schema passthrough
    `JSON.stringify(JSON.parse(s), undefined, 4)` (534-563). Then
    `if (nativeEligible(options)) return native.run(...)`.
  * `InputJSONSchemaStore` must be reachable by the bridge. Exporting it from the module, not from index, changes only
    `JSONSchemaInput.d.ts`, so it is better to have the bridge construct it through a module-internal accessor.
* **New:** `src/native/{eligibility.ts, bridge.ts, encode.ts, load-node.ts, load-browser.ts}` plus the wasm-bindgen
  glue and `quicktype_wasm_bg.wasm`.
  * `quicktype-graphql-input` registers its class in `globalThis[Symbol.for("quicktype-core.nativeInputs")]` at load.
    Core cannot import that package.
  * The root CLI registers `CompressedJSONFromStream` the same way.
  * Neither registration changes any `.d.ts`.
* **Root `quicktype` npm package:** `src/*.ts` are verbatim. It keeps working as a JS CLI on top of the accelerated
  core, and exports `main`, `parseCLIOptions`, `jsonInputForTargetLanguage`, `makeQuicktypeOptions` and `writeOutput`.
  The native Rust binary ships separately (GitHub releases or brew). Optionally, later, it can be distributed as
  esbuild-style per-platform optionalDependencies.
* `.d.ts` parity check in CI: `diff -r` all `dist/**/*.d.ts` files (416 including esm) against the reference build.

### 4.2 The boundary (one call per run)

```ts
// facade → WASM (built by encode.ts from the live objects; InputData insertion order preserved)
interface NativeRunRequest {
  v: 1; lang: LanguageName /* lang.name */; rendererOptions: Record<string, unknown> /* raw JS values */;
  flags: Record<InferenceFlagName, boolean>; alphabetizeProperties: boolean; allPropertiesOptional: boolean;
  fixedTopLevels: boolean; noRender: boolean; checkProvenance: boolean; debug: {printGraph,printReconstitution,
  printGatherNames,printTransformations,printSchemaResolving,printTimes: boolean};
  leadingComments?: (string | CommentConfig)[]; outputFilename: string; indentation?: string;
  inputs: Array<
   | { kind: "json"; handleRefs: boolean; dateTime: "default"|"kotlin"|"swift";
       strings: string[]; objects: Int32Array; objectOffsets: Uint32Array; arrays: Int32Array; arrayOffsets: Uint32Array;
       topLevels: { name: string; description?: string; samples: number[] /* Value = tag | index<<4 */ }[] }
   | { kind: "schema"; storeId: number; sources: { uri: string /* normalized, with #hash */; name: string }[];
       topLevels: [string, string /* Ref.toString() */][]; additional: string[]; needIR: boolean }
   | { kind: "graphql"; topLevels: { name: string; schema: unknown; query: string }[] }>;
}
interface NativeHost {               // JS callbacks invoked synchronously or awaited by Rust
  schemaGet(storeId: number, address: string, debugPrint: boolean): Promise<JSONSchema | undefined>; // → JSONSchemaStore.get
  time(name: string, ms: number): void;  // → debugPrintTimes console.log + options.onTiming
  log(text: string): void;               // → console.log (debug prints keep their interleaving with JS-side prints)
  now(): number;                         // performance.now()
}
// WASM → facade
type NativeRunResult = { files: [string, { lines: string[];
  annotations: { k: 0 /*anyType singleton*/|1 /*nullType singleton*/|2 /*new IssueAnnotationData(m)*/; m?: string;
                 s: [number, number, number, number] }[] }][] };
```

* **JSON inputs ship the CompressedJSON tables, not text.** This keeps everything as it is today:
  * `JSON.parse` semantics: V8 key order (integer-index keys first) and duplicate handling;
  * `parsedNumberIsDouble` classification;
  * stream-json semantics for the CLI;
  * the exact host error messages at `addSource` time (`empty-json-samples.test.ts`);
  * and it avoids parsing twice.

  Rust consumes the tables (`input/Inference.ts` port). `dateTimeRecognizer` is needed again there (Inference.ts:197),
  so its kind is sent.
* **JSON Schema uses a callback loop rather than prefetching.** `Resolver.tryResolveVirtualRef`
  (JSONSchemaInput.ts:700-750) fetches lazily, *while* types are built, and calls `canonizer.addSchema` on each new
  document. Whether a later `$ref` or `$id` resolves therefore depends on fetch order. A prefetch of the `$ref` closure
  would register `$id`s earlier and could turn TS failures into successes. It would also reorder `trying to fetch …`
  prints and `parse JSON Schema` timings, and change which error is reported first.
  * Instead, Rust awaits `host.schemaGet()` at exactly the TS call sites. `wasm-bindgen-futures` turns the JS Promise
    into a Rust future.
  * The facade builds the same store chain as TS: an `InputJSONSchemaStore(inputs, ctxShim, userStore)` when inline
    schemas exist (1599-1610). Inline schema text is therefore parsed by JS `parseJSON`, with exact JSON/YAML
    semantics and messages.
  * Documents come back as JS values. They are converted with key order = `Object.keys` order, numbers as f64
    (Infinity is allowed) and `undefined` mapped to None. Do not round-trip them through `JSON.stringify`: Infinity
    would become `null`.
* `rendererOptions` are passed raw. Rust must reproduce `getOptionValues`, `BooleanOption.getValue` (JS truthiness of
  arbitrary values, `"true"`/`"false"`) and `EnumOption.getEnumValue`, which raises `RendererUnknownOptionValue`.

### 4.3 Errors

* Rust returns `Err(JsValue)` in one of two forms:
  * `{__qt: {kind, properties}}`. The properties are JSON, with `Ref` values encoded as `{__ref: "<Ref.toString()>"}`.
    The facade rehydrates them (`Ref.parse`) and calls the **JS** `messageError(kind, properties)`. That function
    throws a real `QuickTypeError` (`Messages.ts:269-311`) with an identical `errorMessage`, `messageName`,
    `userMessage` and `properties`, and `instanceof` works. JS also does the template substitution, including the
    quirks below, so they are exact by construction:
    * `String.prototype.replace` treats `$&`/`$'` in values specially;
    * only the first occurrence is replaced;
    * arrays become `a,b`, objects use `.toString()`, and `undefined` becomes `"undefined"`.
  * The **original JsValue** thrown by a host callback (a store `get`, `onTiming`). Rust carries it opaquely, and the
    facade rethrows it unchanged.
* Rust must never panic: `panic`, `assert` and `defined` become `Err(InternalError{message})`. Build with
  `panic = "abort"` and treat a `RuntimeError: unreachable` as a broken instance: drop it, re-instantiate lazily, and
  rethrow it as `messageError("InternalError", {message})`.
* Errors from facade code are thrown before the call, exactly as today. Examples are `DriverNoSamplesForTopLevel` and
  `MiscJSONParseError` at addSource, and `addTypesSync not supported in JSONSchemaInput` in the sync path.

### 4.4 Sync vs async, loading, Node + browser

* Must stay **sync**: `quicktypeMultiFileSync`, and `addSourceSync` on `InputData`, `JSONInput`, `JSONSchemaInput` and
  `GraphQLInput`. None of the following touch WASM: `CompressedJSON.parseSync`, `jsonInputForTargetLanguage`,
  `languageNamed`, `isLanguageName`, `getTargetLanguage`, `combineRenderResults`, `parseJSON`,
  `sourcesFromPostmanCollection`, `trainMarkovChain`, `messageError`, `schemaForTypeScriptSources`, and the root
  `parseCLIOptions`. Only `quicktypeMultiFileSync` needs a **synchronous WASM run**: export `run_sync`, which has no
  awaits. In TS, schema inputs already panic in the sync path.
* **Async:** `quicktype` and `quicktypeMultiFile` call the async `run` export, which returns a Promise.
* One `.wasm` artifact uses the wasm-bindgen `--target web` glue, which has no Node imports:
  * **Node (CJS and ESM):** lazy `initSync({module: new WebAssembly.Module(readFileSync(url))})` on first use. Nothing
    happens at import (`core-package.test.ts` "does not write to stdout when imported").
  * **Browser:** on the `browser` export condition, start `WebAssembly.compileStreaming(fetch(new URL(…,
    import.meta.url)))` at import, and await it in `quicktype()`. If `quicktypeMultiFileSync` is called before the
    instance is ready (browsers restrict synchronous compilation of large modules on the main thread), or if loading
    fails, **fall back to the TS engine**. The output is the same, so the API stays unchanged.
  * Provide a base64-inlined variant for bundlers without asset support. esbuild iife bundling, as in
    core-package.test.ts, must still succeed.
* **Re-entrancy:** while `run` awaits `schemaGet`, another `quicktype()` call can enter the same instance. All Rust run
  state must be owned by the future, with no `static mut`; TS's global `initTypeNames()` (Run.ts:536) becomes per-run
  in Rust. No wasm-bindgen `&mut self` objects may be held across awaits.
* For testing, add an `QUICKTYPE_ENGINE=ts|wasm` environment switch (not part of the public d.ts). It enables in-process
  differential runs (§6).

---

## 5. Public Rust API (crate `quicktype-core`), the only API used by `quicktype-cli` and `quicktype-wasm`

```rust
// ---- languages & options ---------------------------------------------------------------
pub struct TargetLanguage { /* static descriptor; one per built-in language */ }
impl TargetLanguage {
    pub fn name(&self) -> &'static str;                 // names[0]
    pub fn names(&self) -> &'static [&'static str];
    pub fn display_name(&self) -> &'static str;
    pub fn extension(&self) -> &'static str;
    pub fn option_definitions(&self) -> &'static [OptionDefinition];   // getOptions() order
    pub fn cli_option_definitions(&self) -> CliOptionDefinitions;      // {actual, display} incl. "no-"/"[no-]" forms
    pub fn supported_integer_range(&self, opts: &RendererOptions) -> Option<IntegerRange>;
    pub fn date_time_recognizer(&self) -> DateTimeRecognizer;          // Default | Kotlin | Swift
}
pub fn default_target_languages() -> &'static [&'static TargetLanguage];   // All.ts order
pub fn language_named(name: &str) -> Option<&'static TargetLanguage>;
pub fn get_target_language(name: &str) -> Result<&'static TargetLanguage, Error>; // DriverUnknownOutputLanguage

pub struct OptionDefinition { pub name: &'static str, pub kind: OptionKind, pub option_type: OptionType,
    pub description: &'static str, pub type_label: Option<&'static str>, pub default_value: OptionValue,
    pub values: Option<&'static [(&'static str, ...)]>, pub alias: Option<char>, pub multiple: bool, pub default_option: bool }

/// Canonical, JS-faithful renderer options: insertion-ordered, dynamically typed like the TS `Record<string, unknown>`.
#[derive(Clone, Default)] pub struct RendererOptions(IndexMap<String, OptionValue>);
pub enum OptionValue { Undefined, Null, Bool(bool), Number(f64), String(String), Json(json::Value) }
impl RendererOptions { pub fn set(&mut self, k: impl Into<String>, v: impl Into<OptionValue>) -> &mut Self; pub fn get(&self, k: &str) -> Option<&OptionValue>; }
// Typed per-language builders (generated from the same option tables), lowering to the canonical map:
pub mod options { pub struct CSharpOptions { pub framework: Option<CSharpFramework>, pub just_types: Option<bool>, /*…*/ }
                  impl From<CSharpOptions> for RendererOptions { … } /* one struct per language, 26 total */ }

#[derive(Clone, Copy)] pub struct InferenceFlags { pub infer_maps: bool, pub infer_enums: bool, pub infer_uuids: bool,
    pub infer_date_times: bool, pub infer_integer_strings: bool, pub infer_boolean_strings: bool,
    pub combine_classes: bool, pub ignore_json_refs: bool }          // Default: all true
pub fn inference_flag_metadata() -> &'static [InferenceFlagInfo];     // descriptions for CLI/help

// ---- inputs ------------------------------------------------------------------------------
pub trait Input {                                  // = TS `Input<T>` minus addSource (sources are typed per input)
    fn kind(&self) -> &str; fn need_ir(&self) -> bool; fn need_schema_processing(&self) -> bool;
    fn single_string_schema_source(&self) -> Option<&str>;
    fn add_types<'a>(&'a mut self, ctx: &'a RunContext, tb: &'a mut ir::TypeBuilder, f: AddTypesFlags)
        -> LocalBoxFuture<'a, Result<(), Error>>;
    fn add_types_sync(&mut self, ctx: &RunContext, tb: &mut ir::TypeBuilder, f: AddTypesFlags) -> Result<(), Error>;
}
#[derive(Default)] pub struct InputData { /* Vec<Box<dyn Input>>, insertion order */ }
impl InputData { pub fn new() -> Self; pub fn add_input(&mut self, i: impl Input + 'static);
                 pub fn input_mut<I: Input + 'static>(&mut self, kind: &str, make: impl FnOnce() -> I) -> &mut I; } // = getOrAddInput

pub enum JsonParser { JsParse /* core API semantics */, StreamJson /* CLI semantics */ }
pub struct JsonInput { /* CompressedJson + top levels */ }
impl JsonInput {
    pub fn for_target_language(lang: &TargetLanguage, handle_json_refs: bool, ro: &RendererOptions, parser: JsonParser) -> Self;
    pub fn add_source(&mut self, src: JsonSourceData<'_>) -> Result<(), Error>;   // DriverNoSamplesForTopLevel, MiscJSONParseError
    pub fn from_compressed(c: compressed_json::Tables, handle_refs: bool, dt: DateTimeRecognizer,
                           top_levels: Vec<compressed_json::TopLevel>) -> Result<Self, Error>; // WASM import path
}
pub struct JsonSourceData<'a> { pub name: String, pub description: Option<String>, pub samples: Vec<Cow<'a, str>> }

pub struct JsonSchemaInput { /* … */ }
impl JsonSchemaInput {
    pub fn new(store: Option<Box<dyn JsonSchemaStore>>, additional_schema_addresses: Vec<String>) -> Self;
    pub fn add_source(&mut self, src: JsonSchemaSourceData) -> Result<(), Error>;   // URI normalisation (urijs port)
    pub fn add_top_level(&mut self, name: String, r: Ref);
    pub fn from_normalized_sources(sources: Vec<(String, JsonSchemaSourceData)>, need_ir: bool,
        store: Box<dyn JsonSchemaStore>, additional: Vec<String>) -> Self;          // WASM path: JS already ran addSource
}
pub struct JsonSchemaSourceData { pub name: String, pub uris: Option<Vec<String>>, pub schema: Option<String>, pub is_converted: bool }
pub struct Ref { /* address + path */ } impl Ref { pub fn parse(s: &str) -> Result<Ref, Error>; } impl Display for Ref {}

// ---- I/O ---------------------------------------------------------------------------------
/// = TS JSONSchemaStore.get(): cache + swallow fetch errors + debug prints. Async because WASM fetch is async.
pub trait JsonSchemaStore { fn get<'a>(&'a mut self, address: &'a str, debug_print: bool, log: &'a dyn Logger)
                              -> LocalBoxFuture<'a, Result<Option<json::Value>, Error>>; }
pub trait JsonSchemaFetcher { fn fetch<'a>(&'a self, address: &'a str) -> LocalBoxFuture<'a, Result<Option<json::Value>, Error>>; }
pub struct CachingSchemaStore<F: JsonSchemaFetcher>(F);        // implements JsonSchemaStore exactly like JSONSchemaStore.ts:19-52
pub trait Io {                                                  // NodeIO semantics, incl. Node-formatted error strings
    fn read_file_or_url<'a>(&'a self, file_or_url: &'a str, headers: &'a [String]) -> LocalBoxFuture<'a, Result<String, Error>>;
    fn http_request<'a>(&'a self, req: HttpRequest<'a>) -> LocalBoxFuture<'a, Result<HttpResponse, Error>>; // introspection
}
#[cfg(feature = "fs")]   pub struct StdIo;                     // std::fs, stdin "-", file:// , symlink handling
#[cfg(feature = "http")] /* StdIo also does HTTP via ureq (blocking inside the future; fine under block_on) */
pub struct FetchingJsonSchemaStore<I: Io> { io: I, headers: Vec<String> } // fetcher: read_file_or_url + parse_json(JSON→YAML)
pub fn parse_json(text: &str, description: &str, address: Option<&str>) -> Result<json::Value, Error>;
pub trait Logger { fn log(&self, line: &str); }                // console.log target (stdout in CLI, console in WASM)

// ---- running -----------------------------------------------------------------------------
pub struct Options<'a> {
    pub lang: &'static TargetLanguage, pub input_data: InputData, pub renderer_options: RendererOptions,
    pub inference: InferenceFlags, pub alphabetize_properties: bool, pub all_properties_optional: bool,
    pub fixed_top_levels: bool, pub no_render: bool, pub leading_comments: Option<Vec<Comment>>,
    pub output_filename: String /* "stdout" */, pub indentation: Option<String>, pub debug: DebugOptions,
    pub check_provenance: bool, pub on_timing: Option<&'a mut dyn FnMut(&Timing)>, pub logger: &'a dyn Logger,
    pub clock: &'a dyn Clock,                                     // performance.now() in WASM, Instant natively
}
pub async fn quicktype_multi_file(o: Options<'_>) -> Result<MultiFileRenderResult, Error>;
pub fn quicktype_multi_file_sync(o: Options<'_>) -> Result<MultiFileRenderResult, Error>; // schema input ⇒ InternalError
pub async fn quicktype(o: Options<'_>) -> Result<SerializedRenderResult, Error>;
pub fn combine_render_results(r: &MultiFileRenderResult) -> SerializedRenderResult;
#[cfg(feature = "blocking")] pub fn quicktype_multi_file_blocking(o: Options<'_>) -> Result<MultiFileRenderResult, Error>; // pollster

pub type MultiFileRenderResult = IndexMap<String, SerializedRenderResult>;
pub struct SerializedRenderResult { pub lines: Vec<String>, pub annotations: Vec<Annotation> }
pub struct Annotation { pub annotation: AnnotationData, pub span: Span }
pub enum AnnotationData { AnyType, NullType, Issue(String) }      // .message()

// ---- errors ------------------------------------------------------------------------------
pub enum Error {
    Message(QuicktypeError),                       // = QuickTypeError
    Host(HostError),                               // opaque payload thrown by a callback (JsValue in WASM); rethrown verbatim
}
pub struct QuicktypeError { pub kind: ErrorKind }
pub enum ErrorKind {                               // one variant per Messages.ts ErrorProperties member (52), typed fields
    InternalError { message: String }, MiscJSONParseError { address: String, description: String, message: String },
    SchemaFetchError { address: String, base: Ref }, DriverUnknownOutputLanguage { lang: String }, /* … */
}
impl QuicktypeError { pub fn message_name(&self) -> &'static str; pub fn error_message(&self) -> &'static str; // template
    pub fn user_message(&self) -> String;          // JS-faithful substitution (first occurrence, `$`-patterns, value.toString rules)
    pub fn properties(&self) -> Vec<(&'static str, PropertyValue)>; }
```

Design notes:
* **Renderer options:** both forms exist. The **canonical form is the dynamic `RendererOptions` map**, because the CLI
  produces it (with all defaults injected, §1.3) and the WASM layer forwards the raw JS object. One port of
  `getOptionValues` turns it into each language's private typed `ResolvedOptions`. The public typed structs are only
  builders that lower into the map, so they cannot diverge.
* **Async:** only `Input::add_types` (JSON Schema resolution) and the I/O traits are async. Futures are `?Send`
  (`LocalBoxFuture`), since JsValue is not Send. Everything else is sync code called from inside the future.
  * Native: `StdIo` does blocking I/O inside the futures, and the CLI runs `pollster::block_on`. No tokio.
  * WASM: `JsSchemaStore` implements `JsonSchemaStore` by awaiting `host.schemaGet` via `JsFuture`. In WASM the JS
    store already does caching and debug prints, so the Rust caching layer is not stacked on top.
  * **Alternative if async in the core proves painful:** restart-on-miss. Run resolution synchronously; on an unknown
    address return `NeedSchema(addr)`, fetch it, and rerun from scratch with a memoising store, suppressing repeated
    debug prints. This is exact, because resolution is deterministic given the store's answers, but it costs
    O(#docs²). A static *prefetch* is **not** exact (§4.2).
* **`quicktype-cli`** (mirrors `src/`):
  * `cli_options.rs`: definitions plus a command-line-args port.
  * `usage.rs`: the help port.
  * `sources.rs`, `url_grammar.rs`, `graphql_introspection.rs` (`Io::http_request`).
  * `main.rs` builds `Options` with `JsonInput::for_target_language(…, JsonParser::StreamJson)`,
    `JsonSchemaInput::new(Some(Box::new(CachingSchemaStore(FetchingJsonSchemaStore{io: StdIo,…}))), additional)` and
    `quicktype_graphql_input::GraphQlInput`, then calls `quicktype_multi_file_blocking`. `writeOutput` and the EPIPE
    handling (§1.7, §1.9) live here as well.
* **`quicktype-wasm`:** `#[wasm_bindgen] async fn run(req: JsValue, host: JsValue) -> Result<JsValue, JsValue>` and
  `fn run_sync(...)`. It decodes `NativeRunRequest` into
  * `JsonInput::from_compressed`,
  * `JsonSchemaInput::from_normalized_sources(.., Box::new(JsSchemaStore{host, store_id}), ..)`,
  * `GraphQlInput`,
  * and the `Options` fields;

  calls `quicktype_multi_file`; encodes the result. It maps `Error::Message` to `{__qt}` and `Error::Host` to the
  original JsValue.

---

## 6. `test/unit/*`: candidates for a differential suite

Legend:
* **API**: uses only public quicktype-core or input-package calls. Run it against the reference npm build and against
  our package with `QUICKTYPE_ENGINE=wasm` and `=ts`, and compare the **full** output (lines and annotations) or the
  exact error (`messageName`, `message`, `properties`), not just the test's assertions.
* **CLI**: run against `node dist/index.js` and the Rust binary.
* **PKG**: packaging.
* **INT**: internal module; port it as a Rust unit test instead.

| file | kind | what it pins |
|---|---|---|
| cjson-enum-default | API | cJSON enum "invalid value" sentinel does not collide with a real enumerator (schema) |
| cjson-split-sources | API | cJSON multi-source: .h/.c pairs, quoting of includes, header-only, `.h`→`.c` naming (quicktypeMultiFile) |
| cli-epipe | CLI | closed stdout → exit 0, no EPIPE message |
| cli-options | CLI | `parseCLIOptions`: duplicate `-o` → `Option parsing failed: …Singular option already set`; `--just-schema` for zod/effect |
| core-package | PKG | no stdout on import; no `node:` imports; CJS/ESM resolution; ESM generates code; pack contents; esbuild browser bundle; `.d.ts` deps |
| cplusplus-multi-source | API | C++ multi-source umbrella header and usage comments |
| csharp-dateonly-timeonly-converters | API | `dateonly-timeonly-converters` on/off (schema) |
| csharp-partial-helpers | API | NewtonSoft/SystemTextJson helper classes are `partial` |
| csharp-records | API | `use-records` variants, member-name avoidance, with just-types |
| csharp-superfluous-usings | API | attributes-only omits unused usings |
| csharp-system-text-json-exceptions | API | STJ union converters throw serializer exceptions |
| dart-method-names | API | `from-map` renames only class-level methods |
| date-time-recognizer | INT | `DefaultDateTimeRecognizer`/Kotlin recognizer via deep `dist/` imports (keep deep paths working) |
| empty-json-samples | API | `addSource`/`addSourceSync` with `samples: []` → "No JSON samples given for top-level X" |
| enum-order | API | schema enum case order preserved (C#, C++) |
| golang-enum-type-name-suffix | API | `enum-type-name-suffix` off by default; collision handling |
| graphql-introspection | CLI | `introspectServer` POSTs the query with custom headers (local HTTP server) |
| haskell-enum-case-naming | API | Haskell enum suffixing |
| ie-suffix-singularization | API | `cookies` → `Cookie` |
| integer-range-inference | API+CLI | `integerStringInRange`, language ranges, cJSON `integer-size`, **stream** (CLI `CompressedJSONFromStream`) vs **JSON.parse** classification at int64/2^53 boundaries |
| java-acronym-names | API | Java enum acronym casing |
| javascript-all-objects-exports | API | JS converters exported for every object type vs top-level only |
| json-schema-definitions | API | `$defs` type keeps its name (FetchingJSONSchemaStore) |
| just-types-option | API | just-types for C#, Kotlin, Scala 3, Smithy; uses TS input; removed enum spellings → errors |
| kotlin-klaxon-empty-object-map | API | Klaxon converters for maps of empty objects |
| kotlinx-datetime-serializers | API | kotlinx date/time KSerializers emitted only when used |
| markov-chain | INT | Markov table decoding and scores |
| missing-schema-path | API | missing schema path → `Could not fetch schema #, referred to from <addr>#` |
| naming | INT | `assignNames` namespace revisiting |
| output-diff | INT (repo tooling) | `script/output-diff` snapshot tooling; not product behaviour |
| parse-json | API | `parseJSON`: strict JSON, YAML fallback, BOM |
| php-unions | API | PHP union dispatch, hints, reserved words |
| php-validation | API | PHP does not recheck scalar params |
| pipeline-timing | API | `onTiming` reports `read input`, `render`, `parse JSON Schema` (names are API surface) |
| prefix-items-schema | API | 2020-12 `prefixItems` tuples |
| python-typing-type | API | Python 3.6 vs 3.7 `typing.Type` |
| python-union-order | API | int before number in unions |
| renderer-options.test-d | PKG (types) | `RendererOptions<Lang>` typing on `quicktype`/`quicktypeMultiFile`: `.d.ts` parity |
| rust-cycle-breaker-boxing | API | Rust Box/Option on cycle breakers |
| rust-empty-top-levels | API | Rust with TS schemas without top levels |
| swift-acronym-names | API | Swift leading-acronym casing |
| swift-coding-keys-protocol | API | coding-keys protocol option |
| swift-final-classes | API | `final` classes option |
| swift-json-null-hashable | API | modern Hashable for JSONNull |
| typescript-empty-object | API | empty interface → `object`; runtime round-trip of generated TS (esbuild + eval) |
| typescript-flow-top-level-alias | API | unnamed top-level aliases (TS/Flow) |
| typescript-input | API | `schemaForTypeScriptSources` schema shape plus end-to-end output (property order, #TopLevel, default export, JSDoc, enums, bigint, Date, Map) |
| typescript-output-filename | API | `outputFilename` in usage comments; `"file"` fallback for stdout |
| typescript-readonly-index | API | `readonly` on index signatures and maps |
| typescript-top-level-array | API | top-level array aliases (schema and JSON) |
| union-accumulator | INT | `UnionAccumulator` string cases |
| url-input | CLI+API | `main({...})` with URL json/schema sources and relative remote `$ref`; `readFromFileOrURL` → `HTTP 401 Unauthorized` |
| windows-paths | INT (deep import) | `fixWindowsPath`/`filePathFromFileURI` |
| windows-schema-paths | API | absolute schema paths (incl. Windows forms) through FetchingJSONSchemaStore |

Beyond these, the differential harness should:
* replay **every golden input** through the API path (string samples, i.e. JSON.parse semantics), which the CLI
  corpus does not exercise;
* add CLI goldens for help (plain and colour), version, stdout multi-file output, stdin, directories, `--src-urls`,
  and every error in §1.9.

---

## 7. Risks (ordered)

1. **Host-produced messages in the native CLI.** These come from:
   * libuv/Node errno strings (`ENOENT …, lstat '…'`);
   * undici (`TypeError: fetch failed`, `HTTP 401 Unauthorized` reason phrases);
   * stream-json parser errors (some depend on chunk boundaries: "escaped characters" when fewer than 6 bytes are
     buffered);
   * yaml@2.9 fallback parsing and error frames in `parseJSON`, which accepts many non-JSON schema files;
   * graphql-js syntax errors;
   * tsc diagnostics.

   The WASM path avoids all of these by keeping I/O and parsing in JS. The CLI has to emulate them.
2. **JS semantics inside Rust:**
   * V8 property order (integer keys first) for JSON.parse-derived data;
   * `JSON.stringify` number and indent formatting (schema passthrough in `Run.ts:547-551` runs for the 88
     `schema-schema` goldens; introspection output; Markov chain);
   * `messageError` substitution quirks in the native CLI;
   * JS truthiness in `BooleanOption.getValue`;
   * UTF-16 `.length` in help layout;
   * `readdirSync` strcmp order.
3. **Help/colour port** (§1.8). The coloured layout differs from the plain one, the Windows CRLF/LF mix matters, and
   there is zero golden coverage today.
4. **TypeScript input** has no Rust implementation path that reaches parity. The native CLI needs Node or an embedded
   JS engine (§3.2).
5. **Facade/WASM integration:**
   * exact-prototype eligibility checks, and silent divergence if the WASM and TS engines disagree (mitigated by the
     `QUICKTYPE_ENGINE` differential CI);
   * re-entrancy across `schemaGet` awaits;
   * the browser sync API falling back to TS before init;
   * a Rust panic poisoning the instance;
   * `.d.ts` identity, which requires `Run.ts` changes to stay internal;
   * package size (TS engine plus WASM).
