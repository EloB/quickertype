# 07 — TypeScript input without Node (TypeScript 7 native checker)

Feasibility spike for `quicktype types.ts --lang go` in the native CLI, with output identical to the reference. All
experiments, scripts and raw results are in the spike's scratch directory (Appendix B); nothing in the repo besides
this page was changed.

**Verdict.** Feasible without Node. The TypeScript 7 (`tsc` 7.0.2, Go) binary has a stdio API that exposes nearly
everything typescript-json-schema (TJS) needs. A Rust client was proven to work. A JS port of the TJS subset,
re-targeted at TS 7, reproduces the reference JSON Schema **byte for byte in 564 of 596 corpus cases (94.6%)**. The
remaining 32 cases differ only in the order of `anyOf` members. That is because TS 5 orders union constituents by
type-creation id, and TS 7 orders them by name. Output is still identical in 23 of 27 target languages; cjson, java,
python and schema show the difference (**99.2% of case × language pairs are identical**). A creation-order emulation
closes most of the rest: it matches TS 5 on 610 of 616 order-sensitive unions and leaves 6 cases (§5.4). Exact parity
for every input cannot be guaranteed: that would require replaying TS 5's checker. Parity on realistic inputs is very
likely.

**Implemented** in `crates/quicktype-typescript-input` (§10), following §7. The refined creation-order replay
closes the six remaining misses: the Rust port matches the reference on **all 596 spike cases** and on all 474 cases
of the committed differential corpus (`tests/corpus`, including 30 `order-*` probes of the union-order emulation and
22 `review-*` cases from the code review).
§10 lists what is still known to diverge.

## 1. The reference pipeline

* **CLI** (`src/index.ts`): if every `--src` ends in `.ts`, `srcLang` becomes `typescript`. This overrides
  `--src-lang`, so `--src-lang ts` also works. `makeTypeScriptSource(src)` then returns `{kind:"schema", schema, name,
  uris, isConverted:true}`. The schema is a JSON string that the ordinary JSON Schema input re-parses with
  `JSON.parse`.
* **Program** (`packages/quicktype-typescript-input/src/index.ts`). It uses TJS's re-exported `ts`, which is
  `node_modules/typescript-json-schema/node_modules/typescript` 5.9.3: `ts.createProgram(fileNames, compilerOptions)`
  (26-46). The options are `noEmit`, `emitDecoratorMetadata`, `experimentalDecorators`, `target ES2015`, `lib
  [lib.es2015.d.ts, lib.dom.d.ts, lib.webworker.importscripts.d.ts, lib.scripthost.d.ts]`, `module CommonJS`,
  `strictNullChecks` (no other strict flag), `typeRoots []` and `rootDir "."`. `rootDir` is relative to the process
  cwd, so a file outside the cwd fails with TS6059: `File '../x.ts' is not under 'rootDir' '.'. … The file is in the
  program because:\n    Root file specified for compilation.`
* **Diagnostics** (208): the first Error-category entry of `getPreEmitDiagnostics(program)` becomes
  `TypeScriptCompilerError` → `Error: TypeScript error: <flattenDiagnosticMessageText(…, "\n")>`.
  `getPreEmitDiagnostics` sorts and deduplicates: config, options, syntactic, global, then semantic diagnostics for
  every file, lib files included.
* **TJS settings** (18): `required, titles, topRef, noExtraProps, propOrder` are true. The defaults stay: `ref:true`,
  `aliasRef:false`, `uniqueNames:false`, `defaultNumberType:"number"`, `constAsEnum:false`. `buildGenerator` (TJS
  1217) re-runs `getPreEmitDiagnostics`. It walks **every** source file, lib files included, for Class, Interface,
  Enum and TypeAlias declarations. It does not descend into those declarations, but it does descend into namespaces
  and function bodies. For each one it records `name = getFullyQualifiedName(sym).replace(/".*"\./,"")`, `allSymbols`,
  `userSymbols` (files without `hasNoDefaultLib`), and `inheritingTypes` from `getBaseTypes` +
  `typeToString(UseFullyQualifiedType)`.
* **quicktype's patch** (89): it wraps `getTypeDefinition`. `Map`/`ReadonlyMap` from a default lib become
  `{type:"object", additionalProperties}`. `Set`, `WeakMap`, `WeakSet` and `Promise` raise `quicktype's TypeScript
  input does not support '<typeToString>' - <advice>`.
* **`generateSchema(program,"*")`** (TJS 1294): `getMainFileSymbols` takes the user symbols declared in non-`.d.ts`
  files, in `Object.keys` order. `getSchemaForSymbols` writes `definitions[name] = getTypeDefinition(type, topRef)`
  and then spreads in the reffed definitions.
* **Post-processing**:
  * `addEnumAccessorNames` (129) walks every file's AST for string enums. It looks up the definition by
    `getFullyQualifiedName` stripped with `/(\bimport\(".*?"\)|".*?")\.| /g` (line 160) and adds `qt-accessors`.
  * `sanitizeTypeAnnotations` turns `"{string}"` into `"string"`.
  * The `export default` ref swap (238).
  * `propertyOrder` is copied to `quicktypePropertyOrder` (275).
  * `#TopLevel` handling (284): the marker is stripped, its definition is added to `uris`, and the definition's
    `title` or name becomes `name`. The default for `uris` is `["#/definitions/"]`.
* **Side output:** TJS writes to stderr with `console.warn` (for example `initializer is expression for property x`)
  and with `console.error`.
* **Harness caveat:** repeated in-process calls leak TS 5 state. The multi-file case wrongly failed with `Cannot find
  module './b'` until the harness used one process per case. The CLI is one-shot, so it is not affected.

## 2. TJS / quicktype → compiler API inventory, mapped to TS 7

✔ = direct equivalent, ≈ = emulated in the client (verified by the experiment), ✗ = not available.

| TS 5 call (who) | TS 7 API | |
|---|---|---|
| `createProgram(files, opts)` | `updateSnapshot{openProjects:[tsconfig]}`; tsconfig served from memory | ≈ |
| `getPreEmitDiagnostics`, `flattenDiagnosticMessageText` | `getConfigFileParsingDiagnostics`/`getProgramDiagnostics`/`getSyntacticDiagnostics`/`getGlobalDiagnostics`/`getSemanticDiagnostics`; diagnostics carry `text` plus a nested `messageChain` | ≈ (sort and flatten in the client) |
| `program.getSourceFiles`, `sf.hasNoDefaultLib`, `isDeclarationFile`, `isSourceFileDefaultLibrary` | `getSourceFileNames`, `getSourceFile` (binary AST), `getSourceFileMetadata.isDefaultLibrary`, SourceFile `flags & Ambient` | ✔ |
| `node.symbol`, `getTypeAtLocation(decl)`, `getSymbolAtLocation(node)` (TJS, qt) | `getSymbolAtLocation(decl.name)`, `getTypeAtLocation` | ✔ |
| `getFullyQualifiedName(sym)` (TJS, qt) | — | ≈ walk the `getParentOfSymbol` chain and join names. Module symbols are named `"/abs/file"` exactly as in TS 5. For `export default interface X`, TS 5 prints the local name `X` and not `default`, so substitute the declaration's identifier |
| `typeToString(t, undefined, NoTruncation\|UseFullyQualifiedType)` | `typeToString{type, flags}` (same flag values; same `import("…")` prefix) | ✔ |
| `type.getBaseTypes()` | `getBaseTypes` | ✔ |
| `getPropertiesOfType` | same | ≈ order differs for inherited members; re-sort as in TS 5 `resolveObjectTypeMembers`: own declared members, then each base's order |
| `getTypeOfSymbolAtLocation`, `getTypeOfSymbol`, `getAliasedSymbol`, `getConstantValue`, `getTypeArguments` | same | ✔ |
| `getIndexTypeOfType`/`getIndexInfoOfType(t, IndexKind.Number)` | `getIndexInfosOfType` and pick `keyType == getNumberType()` | ✔ |
| `sym.getDocumentationComment(tc)` → display parts | `getDocumentationComment` → **plain string**, with `{@link X}` already rendered as `X` | ≈ rebuild TS 5's parts (`buildLinkParts`, including its `{@linkcode A.ab c}` quirk) from the JSDoc AST; use the TS 7 string only for inherited docs |
| `sym.getJsDocTags()` → `{name, text: parts}` | `getJsDocTags` → `{name, text: string}` | ✔ on the corpus (a `{@link}` inside a tag would need the same rebuild) |
| `sym.name/escapedName/flags/declarations/valueDeclaration/members.size` | SymbolResponse + `getMembersOfSymbol` | ✔ |
| `prop.links.type.types` (internal, in `required`) | — | ≈ if `flags & Transient`, use the union members of `getTypeOfSymbol` |
| `type.flags/objectFlags/id/aliasSymbol/aliasTypeArguments/types/value/intrinsicName/texts/target` | TypeResponse + `getTypesOfType`, `getAliasSymbolOfType`, `getTargetOfType`, … | ✔. The flag numbers differ from TS 5: use TS 7's enums. A `true` literal has `value:true` and no `intrinsicName`. TS 7 also gives enum types an `aliasSymbol` (harmless here) |
| union/intersection **constituent order** | `getTypesOfType` | **✗** TS 7 sorts object constituents by symbol name, TS 5 by creation id (§5.3) |
| tuple `target.labeledElementDeclarations/minLength/hasRestElement/fixedLength` | `elementFlags`, `fixedLength` | ≈ labels via `typeToTypeNode` (`NamedTupleMember`) |
| `type.members` (resolved members, numeric-index branch) | — | ≈ `getMembersOfSymbol` |
| `clazzType.mapper.target`, `IndexedAccess.objectType.members` (index-signature-of-`T[K]` branch) | — | ✗ internal and rare; needs `getObjectTypeOfType` + `getPropertyOfType` (untested) |
| `ts.getCombinedModifierFlags(node)` | AST modifiers | ✔ |
| AST: `kind, parent, members, parameters, type, typeName, name.text, initializer, expression, getText(), forEachChild, jsDoc` | binary AST (§3.6) | ✔ (TS 7 SyntaxKind numbers) |
| `vm2` `eval` of class-property initializers | — | ✗ needs a small evaluator for literal expressions in Rust |

## 3. The TS 7 API protocol

Source: `node_modules/typescript/dist/api/{sync/client.js, syncChannel.js, sync/api.js, proto.d.ts, node/*.js}`
(7.0.2). Upstream calls it `unstable` and says "the protocol is unversioned; both sides must be built from the same
tree".

### 3.1 Spawn
`<exe> --api --cwd <cwd> [--callbacks=readFile,fileExists,directoryExists,getAccessibleEntries,realpath] [--timing]`,
with stdin/stdout piped and stderr inherited. On Windows, add `--pipe \\.\pipe\<name>` and talk over the named pipe
(stdio ignored). The exe is `@typescript/typescript-<platform>-<arch>/lib/tsc` (see `lib/getExePath.js`). The
`lib.*.d.ts` files sit next to it, and TS 7 finds them relative to the exe.

### 3.2 Framing
Each message is a MessagePack `fixarray(3)`: `0x93, type, method, payload`. `type` is a positive fixint (or `0xcc
u8`). `method` and `payload` are `bin` (`0xc4` u8 len / `0xc5` u16 BE / `0xc6` u32 BE). Types:

* client → server: 1 Request, 2 CallResponse, 3 CallError;
* server → client: 4 Response, 5 Error (payload = UTF-8 message), 6 Call.

The channel is strictly serial: one outstanding request. While serving it, the server may send `Call` messages
(virtual-FS callbacks), and the client must answer each one. The final `Response` carries the request's method name.
Payloads are JSON text, except the responses of `getSourceFile`, `typeToTypeNode` and
`signatureToSignatureDeclaration`, which are binary ASTs. An empty payload means `undefined`. No msgpack crate is
needed: about 40 lines of Rust, see Appendix A.

### 3.3 Session
1. `initialize` (`null`) → `{useCaseSensitiveFileNames, currentDirectory}`.
2. `updateSnapshot` `{openProjects:[configPath]}` (also `openFiles`, `closeProjects`, `fileChanges`) → `{snapshot,
   projects:[{id, configFileName, compilerOptions, rootFiles}]}`. The project id is the config's canonical path,
   lowercased on case-insensitive file systems.
3. Every program or checker call takes `{snapshot, project, …}`.
4. `release{snapshot}`; closing stdin ends the process.

TS 7 has no "ad-hoc program" call. A tsconfig is required, but it does not have to exist on disk. With
`--callbacks=readFile,fileExists` the client serves it: `readFile` gets a JSON path string and returns `{"content":
"…"}`, or `""` to fall back to the real file system. The Rust prototype does exactly this.

### 3.4 Handles
* Symbols and types are numeric ids, stable for the snapshot. Responses carry eager data:
  * `SymbolResponse {id, project, name (escaped), flags, checkFlags, declarations: [nodeHandle], valueDeclaration,
    parent, exportSymbol}`.
  * `TypeResponse {id, flags, objectFlags, value, intrinsicName, symbol, aliasSymbol, aliasTypeArguments, target,
    typeParameters, elementFlags, fixedLength, readonly, texts, objectType, indexType, …}`, where related objects are
    ids.
* Related objects are fetched lazily with `{objectId}` requests: `getSymbolOfType`, `getAliasSymbolOfType`,
  `getTargetOfType`, `getTypesOfType`, `getAliasTypeArgumentsOfType`, `getObjectTypeOfType`, `getIndexTypeOfType` (the
  indexed-access part), `getParentOfSymbol`, `getMembersOfSymbol`, `getExportsOfSymbol`, `getExportSymbolOfSymbol`.
* Nodes are strings `"<index>.<kind>.<path>"` (node index in the file's binary AST, SyntaxKind, canonical path).
  Checker calls take them as `location`.

### 3.5 Checker and program methods needed
`getSourceFileNames, getSourceFile{file}, getSourceFileMetadata{file},
get{ConfigFileParsing,Program,Syntactic,Global,Semantic}Diagnostics, getSymbolAtLocation{location} (batch:
getSymbolsAtLocations), getTypeAtLocation (getTypeAtLocations), getDeclaredTypeOfSymbol{symbol}, getTypeOfSymbol
(getTypesOfSymbols), getTypeOfSymbolAtLocation{symbol,location}, getPropertiesOfType{type}, getIndexInfosOfType{type},
getBaseTypes{type}, getTypeArguments{type}, getAliasedSymbol{symbol}, getConstantValue{location},
typeToString{type,location?,flags}, typeToTypeNode{type,flags} (binary), getJsDocTags{symbol},
getDocumentationComment{symbol}, getNumberType`, plus the `{objectId}` getters. All of them are present in 7.0.2.
`getFullyQualifiedName` and `symbolToString` exist inside the binary but are not exposed.

### 3.6 Binary AST (protocol v5, `node/protocol.js`)
* Little-endian. The 44-byte header has offsets at 24 (string-offset table), 28 (string data), 32 (extended data), 36
  (structured msgpack data) and 40 (nodes).
* Nodes are 28-byte records `kind, pos, end, next, parent, data, flags`, in pre-order. Index 0 is nil and index 1 is
  the SourceFile.
* Children of node *i* start at *i+1* when `parent(i+1)==i` and continue via `next`. `kind 0xFFFFFFFF` is a NodeList.
* `data`: the top 2 bits give the type (children / string / extended). Children data holds an 8-bit child-presence
  mask. Named children are found with the generated `childProperties` table (`protocol.generated.js`) through mask
  popcount.
* Identifier and JSDoc text are inline string indices. Literals and the SourceFile point into extended data; the
  SourceFile has text, fileName and path at `ext+0/4/8`.
* JSDoc nodes (`JSDoc`, `JSDocText`, `JSDocLink*`, tags) are included as children, so docs can be rebuilt client-side.
* Strings are **WTF-8** (lone surrogates allowed), so decode to UTF-16 for JS semantics. Note: the JS client's
  `TextDecoder` drops a leading U+FEFF. That caused a false mismatch on `blns-object` until the experiment stopped
  relying on decoded names.

## 4. Gap analysis

| Gap | Effect | Remedy | Status |
|---|---|---|---|
| Union constituent order | `anyOf` order → output in cjson, java, python, schema | emulate TS 5 creation order (§5.4) | partial |
| TS 7 defaults changed: `strict` is now on, among others | spurious TS2564 errors | always pass `strict:false` and every quicktype option explicitly | fixed |
| `getDocumentationComment` loses `{@link}` | descriptions differ | rebuild display parts from the JSDoc AST (about 80 lines) | fixed |
| `getPropertiesOfType` order with ≥2-level `extends` | `propertyOrder` differs | TS 5 ordering emulation | fixed |
| `getFullyQualifiedName` not exposed | names | parent-chain emulation | fixed |
| FQN of a default-exported declaration | `default` swap/name | use the declaration's identifier | fixed |
| tuple labels | `title` on items | `typeToTypeNode` | fixed |
| `links.type`, `type.members` (internal) | `required`, numeric index | emulation | fixed |
| TS6059 rootDir text (absolute paths, chain "Part of 'files' list…") | error text | check containment in Rust and synthesize the TS 5 text | design |
| lib `.d.ts` are TS 7's, not 5.9.3's (DOM changes) | global-name collisions, lib-type diagnostics | optional: serve 5.9.3's four lib sets through the `readFile` callback | not needed on corpus |
| `vm2` initializer evaluation | `default` values | Rust literal-expression evaluator, with identical warning texts | design |
| `T[K]` index-signature branch (`mapper`) | rare | best effort | open |
| Protocol unversioned and "unstable" | breakage on upgrade | pin the exact tsc version; check `--version` | design |

## 5. Parity experiment

### 5.1 Method
* **Reference.** The real `schemaForTypeScriptSources` (TS 5.9.3 + TJS 0.67.4), one process per case, with cwd set to
  the case directory. It records `{schema, name, uris}` or the error text, plus TJS's stderr.
* **Candidate.** `exp/tjs7.mjs`, a ~600-line port of quicktype's `index.ts` and the TJS subset quicktype uses. It runs
  on `typescript/unstable/sync` (TS 7.0.2), with one `tsc --api` per case.
* **Comparison.** Exact equality of `[error, schema string, name, uris, stderr]`.
* **End to end.** A preload hook feeds each recorded result into the real reference CLI (`node dist/index.js <files>
  --lang L`). It was validated by checking that the reference side is byte-identical to the un-hooked CLI. stdout,
  stderr and the exit code were compared for all **27** target languages.

### 5.2 Corpus (596 cases)

| group | n | source |
|---|---|---|
| g | 368 | every TS output in `tests/golden`: typescript 266, schema-typescript 89, graphql-typescript 9, comment-injection-typescript 4 |
| j | 159 | JSON → `--lang ts --just-types`, the step 0 of quicktype's own `json-ts-csharp` fixture, for every input it does not skip |
| u | 14 | snippets from `test/unit/typescript-input.test.ts` and `just-types-option.test.ts` |
| f | 45 | hand-written features: generics, aliases, literal and boolean unions, numeric, string, mixed and const enums, JSDoc/TJS tags, `{@link}`, index signatures, intersections, `Partial/Pick/Omit/Record/Readonly`, tuples, template literals, classes with initializers, abstract classes, namespaces, default exports, `extends` chains, declaration merging, mapped and conditional types, Map/Date/Set/Promise/WeakMap, multi-file imports, a DOM-name collision, scripts (non-modules) |
| e | 10 | errors and edge cases: typo with suggestion, missing property, assignability, syntax, duplicate identifier, bigint literal, implicit any, global merge |

### 5.3 Results

| | schema identical |
|---|---|
| first run of the port (u+f only) | 38/57 |
| after the fixes in §4 | **564/596 (94.6%)** — g 340/368, j 156/159, u 14/14, f 44/45, e 10/10 |

* Error texts match in all 11 error cases (`Cannot find name 'strin'. Did you mean 'string'?`, `'}' expected.`,
  `Unsupported type: 10n`, the `Set<string>` advice, and others).
* The 32 differing cases differ **only** in `anyOf` order: 92 of 2,787 `anyOf` arrays. Membership is equal, and all
  1,387 simple `type: [...]` arrays are identical.
* Per field, everything else is identical across the corpus: property order, optionality and `required`, literal and
  enum values, `qt-accessors`, JSDoc descriptions and tags, index signatures, aliases, generics and names.
* End to end on the 32 cases: identical in 23 languages and different in 4 (cjson, java, python, schema), which print
  union members in graph order. Overall **15,964/16,092 = 99.2%** of case × language pairs are identical.
* The 564 identical schemas give identical output by construction: the same input goes to the same CLI.
* For the `json-ts-csharp` fixture (group j × csharp) it is **159/159**.

Why the order differs: TS 5 sorts constituents by type id, that is, by creation order during the full check. TS 7
sorts object types by symbol name. Probe (`Z` declared before `A`):

| union | TS 5 | TS 7 |
|---|---|---|
| `A \| Z` | `Z, A` | `A, Z` |
| `A \| Z[]` | `A, Z[]` | `A, Z[]` |
| `any[] \| A` / `string[] \| A` | `any[], A` / `string[], A` (created by lib) | `A, any[]` / `A, string[]` |

### 5.4 Emulating TS 5 order
`exp/ts5unions.cjs` assigns virtual creation ids from information that TS 7 also exposes (AST plus symbol resolution).
It walks declarations in source order and resolves type references depth-first: aliases are expanded on first use, and
array types come after their element types. Types it never reached, such as lib-created `any[]`, rank first. Members
are then sorted by virtual id. Results on the 571 compilable g/j/f cases:

* 3,422 union type nodes, 616 of them with ≥ 2 object-type members;
* TS 5 order equals source order in 568/616 (92.2%);
* the emulation matches TS 5 in **610/616 (99.0%)**, and all unions match in 565/571 cases. With TS 7's raw order, 32
  cases differ at schema level.

The six misses have two causes:
* `string[]`/`{[k:string]:number}` that lib checking had already created (fix: a table of instantiations pre-created
  by the 5.9.3 libs, measured once);
* `Array<…>` written as a generic reference, whose type arguments TS 5 resolves later (deferred type reference).

This is an emulation of checker internals, not a specification. It is the main residual parity risk. Validate it with
recorded cases (§6) and keep TS 7's order as the fallback only where the emulation has no information.

### 5.5 Performance (Apple Silicon)
The machine was shared and heavily loaded (load average above 100), so the absolute numbers are noisy. In both
measurement windows the Rust prototype was at least 4× faster than the reference, for a 1,013-line input:

| | window 1 | window 2 |
|---|---|---|
| reference CLI | 3.1–3.8 s | 7–9 s |
| Rust prototype (spawn, program, full semantic check incl. libs, 288 properties) | 0.4–0.7 s | 1.4–1.9 s |
| node port of TJS on TS 7 | 1.5 s | 6.8 s |

A round trip costs 50–220 µs and the full semantic check 240–600 ms. Use the batch endpoints (`getTypesOfSymbols`,
`getSymbolsAtLocations`, …) to keep the round-trip count down.

## 6. Recording TS-input cases into the golden corpus

* **Free coverage: `json-ts-csharp`.** quicktype's `JSONTypeScriptFixture` (fixtures.ts 805) is a real TS-input
  fixture that CI runs.
  * Step 0 is `--src-lang json --lang ts --just-types …`.
  * Step 1 is `--src-lang ts --lang csharp --src typescript.ts --out TopLevel.cs --top-level TopLevel --check-required
    --framework NewtonSoft --quiet --telemetry disable --debug provenance`.
  * It is not recorded today because `JSONToXToYFixture.runForName` matches only `json-ts-csharp` or `json-ts`, not
    `json`.
  * Adding `json-ts` to `FIXTURE=` in `xtask/golden/record.sh` records about 159 two-step cases with no other change.
    `record-hook.cjs` already handles every option it uses. Step 0 writes `typescript.ts` into the run directory, so
    the `rootDir "."` constraint is met on replay.
  * The recording machine needs dotnet, as it already does for `csharp`.
* **Broader coverage (new).** A `record-ts` script would run the reference CLI directly, not through the fixture
  harness. It would cover the corpus in §5.2, where hand-written inputs move to `tests/inputs/typescript/`, × a
  handful of order-sensitive languages (python, java, cjson, schema) and go/csharp.
  * TS inputs must sit under the run's cwd. `case.json` therefore needs a setup field, such as `"copy": {"input.ts":
    "{INPUTS}/typescript/x.ts"}`, which `cargo xtask parity` copies into the temp dir before step 0.
  * Error cases use `expect_failure`.
  * The TS6059 case needs a file outside the cwd. Copy it to a subdirectory and run with `dirs`.
* **API tests.** `test/unit/typescript-input.test.ts` goes to the JS-API differential suite. On npm, TS input stays
  the original JS (research 05 §3.2), so it is not affected.

## 7. Recommended design: crate `quicktype-typescript-input`

```
crates/quicktype-typescript-input/
  tsc/locate.rs   find + version-check tsc (§8)
  tsc/channel.rs  spawn, framing, callbacks (virtual tsconfig)
  tsc/api.rs      typed requests, id caches, batch endpoints
  tsc/ast.rs      v5 binary AST reader, WTF-8→UTF-16, generated SyntaxKind/flags/childProperties
  tjs/            port of TJS 0.67.4 (paths reachable with quicktype's settings): generator.rs, comments.rs (TS 5
                  display parts, tag parsing), order.rs (property and union order), initializer.rs (replaces vm2),
                  names.rs (FQN, typeToString post-processing, encodeURIComponent)
  lib.rs          schema_for_typescript_sources(files, cwd) -> Result<JsonSchemaSourceData, Error> (port of index.ts)
```

* **Boundary.** The crate returns the same `{schema: String, name, uris, is_converted}` as the reference. Build the
  schema in a JS-object-semantics map: integer-like keys come first, which matters for properties such as `"0"` (seen
  in blns). Serialize with `js_compat::json` and hand the string to the existing JSON Schema input, so downstream
  behavior is identical by construction.
* **Flow.**
  1. Check rootDir containment and synthesize TS6059.
  2. Spawn tsc and serve the virtual tsconfig.
  3. Collect diagnostics (sorted as TS 5 does, flattened with `messageChain`).
  4. AST walk of non-default-lib files (no lib ASTs are needed).
  5. TJS port.
  6. Post-processing.
* **Rules ported as data, not guesses.** All TS 7 enum values and the `childProperties` table are generated from the
  pinned package. A unit test fails if the installed tsc's `--version` or the generated tables drift.
* **Errors and stderr.** Return `Result` with the reference message texts. TJS's `Error`s (`Unsupported type: …`, `Not
  supported: root type undefined`) surface as the CLI prints them. Reproduce the `console.warn` lines on stderr.
* **CLI.** `--src-lang typescript` (or all-`.ts` sources) calls this crate behind a default-on cargo feature
  `typescript-input`. The WASM/npm build keeps the original JS package (research 05 §3.2).

## 8. Locating and provisioning tsc; behavior when it is absent

* **Lookup order** (no new CLI flags, so the help text stays identical):
  1. env `QUICKTYPE_TSC=<path to tsc>`;
  2. `node_modules/@typescript/typescript-<os>-<arch>/lib/tsc`, searched upward from the cwd and then next to the
     quicktype executable. This covers npm installs of quicktype, which can declare the platform package
     `@typescript/typescript-<os>-<arch>@7.0.2` as an optional dependency (a 24 MB binary plus 3.9 MB of
     `lib.*.d.ts`);
  3. `tsgo`/`tsc` on `PATH`, accepted only if `--version` prints exactly `Version 7.0.2`.
* **Pinning.** Accept only the exact pinned version. The protocol is unversioned, and enum values change between
  releases. Bumping the pin is a deliberate change: regenerate the tables and re-run parity.
* **Absent or wrong version.** Exit 1 with one line in the reference's error style, for example: `Error: TypeScript
  input requires the TypeScript 7.0.2 compiler (tsc); install it with "npm install -g typescript@7.0.2" or set
  QUICKTYPE_TSC.` This is the one deliberate divergence. The reference cannot hit it, so no golden case covers it. If
  tsc dies mid-session, the error should say so and quote its stderr.
* **Optional.** For full lib parity, embed TS 5.9.3's `lib.*.d.ts` files (2.1 MB for the files these options load, and
  they compress well) and serve them via `readFile` for paths under the tsc lib dir. Not needed on today's corpus, so
  defer.

## 9. Effort estimate (one engineer familiar with the codebase)

| item | days |
|---|---|
| channel, api, caches, locate/version, virtual FS, errors | 3 |
| binary AST reader + generated tables (SyntaxKind, flags, childProperties) | 2 |
| TJS port (about 1,000 lines of Rust, guided by `exp/tjs7.mjs`) + index.ts post-processing | 5 |
| JSDoc display parts, TS 5 property order, initializer evaluator, diagnostics sorting/flattening | 3 |
| union creation-order emulation and its validation | 3-5 |
| recording (`json-ts` in record.sh; `record-ts` + `copy` support in xtask parity) | 2 |
| packaging (npm optional dep, CI with pinned tsc) | 1-2 |
| **total** | **19-22** |

## 10. Implementation (`crates/quicktype-typescript-input`)

| module | port of |
|---|---|
| `tsc/locate` | `lib/getExePath.js`, plus `$QUICKTYPE_TSC` and `PATH` (§8); exact `Version 7.0.2` check |
| `tsc/channel` | `api/syncChannel.js`: framing, `readFile`/`fileExists` callbacks (in-memory tsconfig), stderr drain, kill on drop |
| `tsc/api` | `api/sync/api.js`: typed requests, symbol/type caches by handle, lazy `{objectId}` getters, batch endpoints |
| `tsc/ast` | `api/node/*.js`: binary AST v5, WTF-8 strings, UTF-16 positions, `getText`, `operator`, modifiers |
| `tsc/generated` | enums and `childProperties` of typescript@7.0.2 (`xtask/typescript-input/gen-tables.mjs`) |
| `tjs` | `JsonSchemaGenerator` of typescript-json-schema 0.67.4, quicktype's `getTypeDefinition` patch |
| `tjs/comments` | `parseCommentsIntoDefinition`; TS 5.9 `getDocumentationComment` display parts (`buildLinkParts`) |
| `tjs/order` | TS 5.9 union member order (creation replay) and inherited property order |
| `tjs/initializer` | the `vm2` evaluation of class initializers, as a constant-expression evaluator |
| `js` | JavaScript objects (shared references, own-property order, `__proto__`), `JSON.parse`, `parseFloat` |
| `lib` | `schemaForTypeScriptSources`: options, TS6053/TS6059 texts, diagnostics order and flattening, post-processing |

**Union order, refined.** The replay follows TS 5.9's eager pre-emit check (`checkSourceFileWithEagerDiagnostics`
runs lazy diagnostics immediately): an interface's declared type is created at its declaration, then its base types,
then, when it has an index signature, `checkIndexConstraints` resolves the index signature types and every property
type before the members are checked. `checkSourceElement` on a type reference checks its type arguments before
resolving it; on an array type it only checks the element; unions, tuples and type literals resolve after their
children. `getTypeFromTypeNode` resolves aliases on first use and defers the arguments of array, tuple and generic
references inside type aliases (`isDeferredTypeReferenceNode`). Types the library check creates first (non-generic
library types such as `Date`, and measured instantiations such as `string[]`) rank before user types.

**Testing.** `tests/differential.rs` runs every case of `tests/corpus` through the port and compares schema string,
name, uris and stderr lines with `expected.json`, recorded from the reference by `xtask/typescript-input/record.mjs`
(one Node process per case). It finds tsc like the CLI, or in a sibling `quicktype` checkout's `node_modules`, and is
skipped with a message otherwise. A whole case takes 0.2–0.4 s in a release build, including the compiler start and
the full semantic check, against about 3 s for the reference CLI.

**Known divergences** (none occurs in the corpus):

* Union order is a replay, not the checker: classes' eager checks (property initializers, implements clauses),
  property types resolved by base-type assignability checks for `extends`, types first created inside function or
  variable declarations, and library instantiations missing from the measured list can still order differently.
  Order-insensitive languages are unaffected.
* Names of generic instantiations with union arguments use TS 7's member order (`Box<A | B>`).
* A file outside the working directory that is *imported* (not a root file) gets TS 7's TS6059 text, with absolute
  paths.
* JSDoc tags: TS 7's `getJsDocTags` text is used as is (a `{@link}` inside a tag is not rebuilt), and tags may be
  inherited from base declarations where TS 5.9's checker-less `symbol.getJsDocTags()` did not inherit them.
* JSDoc values that `require()` a module, and the `T[K]` index-signature branch that reads checker internals, are not
  supported. Initializers are evaluated from their syntax tree with JavaScript semantics (literals, templates,
  unary/binary/logical/conditional operators, `typeof`/`void`); anything needing an environment is reported as
  `exception evaluating initializer`, as `vm2` would for an unknown binding.
* typescript-json-schema's plain-object lookups are reproduced where they surface (`Object.prototype` names as JSDoc
  tags or type names, `__proto__`), but not every consequence of assigning `__proto__` (an inherited prototype that
  later `for…in` loops would enumerate).
* The libraries are TS 7's `lib.*.d.ts`: a script (non-module) input that merges with a DOM global can see
  different members or diagnostics.
* Lone surrogates in TypeScript source text become U+FFFD.
* No TypeScript 7.0.2 compiler: `Error::TscNotFound` (the deliberate divergence of §8).
* Windows (`--pipe`) is untested; the client uses stdio on every platform.

## Appendix A — Rust prototype (`ts7-spike/rust/src/main.rs`)

It spawns `tsc --api` and serves the tsconfig from memory through the `readFile`/`fileExists` callbacks. It runs the
semantic diagnostics, decodes the binary AST to find each interface's name node, then calls `getSymbolAtLocation`,
`getDeclaredTypeOfSymbol`, `getPropertiesOfType`, `getTypeOfSymbol` and `typeToString`. The only dependency is
`serde_json`. Output for a sample file:

```
semantic diagnostics: []
interface Person (symbol 324, type 84)
  name: string (type flags 32)
  age?: number | undefined (type flags 134217728)
  tags: string[] (type flags 1048576)
  kind: "a" | "b" (type flags 134217728)
  e: Color (type flags 134250496)
  m: { [key: string]: number; } (type flags 1048576)
```

```rust
// Drives the TypeScript 7 native checker (`tsc --api`) over stdio, without Node.
// usage: ts7-spike <tsc> <file.ts>  -- lists every interface's properties.
use serde_json::{json, Value};
use std::io::{self, BufReader, BufWriter, Read, Write};
use std::process::{Child, ChildStdin, ChildStdout, Command, Stdio};

const REQUEST: u8 = 1; const CALL_RESPONSE: u8 = 2; const RESPONSE: u8 = 4; const ERROR: u8 = 5; const CALL: u8 = 6;
// TS 7.0.2 enum values (dist/enums/*.enum.js); pin and generate these in the real crate.
const SK_IDENTIFIER: u32 = 79; const SK_INTERFACE: u32 = 265;
const SYMBOL_OPTIONAL: u64 = 1 << 24;

struct Client { _child: Child, w: BufWriter<ChildStdin>, r: BufReader<ChildStdout>, tsconfig: (String, String) }

fn put_bin(w: &mut impl Write, b: &[u8]) -> io::Result<()> {
    match b.len() {
        n if n < 0x100 => w.write_all(&[0xc4, n as u8])?,
        n if n < 0x10000 => { w.write_all(&[0xc5])?; w.write_all(&(n as u16).to_be_bytes())? }
        n => { w.write_all(&[0xc6])?; w.write_all(&(n as u32).to_be_bytes())? }
    }
    w.write_all(b)
}
fn byte(r: &mut impl Read) -> io::Result<u8> { let mut b = [0]; r.read_exact(&mut b)?; Ok(b[0]) }
fn get_bin(r: &mut impl Read) -> io::Result<Vec<u8>> {
    let n = match byte(r)? {
        0xc4 => byte(r)? as usize,
        0xc5 => { let mut b = [0; 2]; r.read_exact(&mut b)?; u16::from_be_bytes(b) as usize }
        0xc6 => { let mut b = [0; 4]; r.read_exact(&mut b)?; u32::from_be_bytes(b) as usize }
        m => return Err(io::Error::other(format!("expected bin, got {m:#x}"))),
    };
    let mut v = vec![0; n]; r.read_exact(&mut v)?; Ok(v)
}

impl Client {
    /// `tsconfig` is served through the readFile callback, so nothing is written to disk.
    fn spawn(tsc: &str, cwd: &str, tsconfig: (String, String)) -> io::Result<Self> {
        let mut child = Command::new(tsc).args(["--api", "--cwd", cwd, "--callbacks=readFile,fileExists"])
            .stdin(Stdio::piped()).stdout(Stdio::piped()).stderr(Stdio::inherit()).spawn()?;
        let (w, r) = (BufWriter::new(child.stdin.take().unwrap()), BufReader::new(child.stdout.take().unwrap()));
        Ok(Client { _child: child, w, r, tsconfig })
    }
    fn frame(&mut self, ty: u8, name: &[u8], payload: &[u8]) -> io::Result<()> {
        self.w.write_all(&[0x93, ty])?; put_bin(&mut self.w, name)?; put_bin(&mut self.w, payload)?; self.w.flush()
    }
    fn raw(&mut self, method: &str, params: &Value) -> io::Result<Vec<u8>> {
        self.frame(REQUEST, method.as_bytes(), params.to_string().as_bytes())?;
        loop {
            if byte(&mut self.r)? != 0x93 { return Err(io::Error::other("expected fixarray(3)")); }
            let ty = match byte(&mut self.r)? { 0xcc => byte(&mut self.r)?, t => t };
            let (name, payload) = (get_bin(&mut self.r)?, get_bin(&mut self.r)?);
            match ty {
                RESPONSE => return Ok(payload),
                ERROR => return Err(io::Error::other(String::from_utf8_lossy(&payload).into_owned())),
                CALL => { let reply = self.callback(&name, &payload); self.frame(CALL_RESPONSE, &name, reply.as_bytes())? }
                t => return Err(io::Error::other(format!("unexpected message type {t}"))),
            }
        }
    }
    fn req(&mut self, method: &str, params: Value) -> io::Result<Value> {
        let p = self.raw(method, &params)?;
        Ok(if p.is_empty() { Value::Null } else { serde_json::from_slice(&p)? })
    }
    /// Virtual FS: answer for the in-memory tsconfig, "" means "fall back to the real FS".
    fn callback(&self, name: &[u8], arg: &[u8]) -> String {
        let path: String = serde_json::from_slice(arg).unwrap_or_default();
        let ours = path == self.tsconfig.0;
        match (name, ours) {
            (b"readFile", true) => json!({ "content": self.tsconfig.1 }).to_string(),
            (b"fileExists", true) => "true".into(),
            _ => String::new(),
        }
    }
}

/// Minimal reader for the binary AST that `getSourceFile` returns (protocol v5).
struct Ast<'a> { b: &'a [u8], str_offs: usize, strs: usize, nodes: usize, ext: usize }
impl<'a> Ast<'a> {
    fn u32(&self, off: usize) -> u32 { u32::from_le_bytes(self.b[off..off + 4].try_into().unwrap()) }
    fn new(b: &'a [u8]) -> Self {
        let mut a = Ast { b, str_offs: 0, strs: 0, nodes: 0, ext: 0 };
        (a.str_offs, a.strs, a.ext, a.nodes) = (a.u32(24) as usize, a.u32(28) as usize, a.u32(32) as usize, a.u32(40) as usize);
        a
    }
    fn len(&self) -> usize { (self.b.len() - self.nodes) / 28 }
    fn field(&self, i: usize, f: usize) -> u32 { self.u32(self.nodes + i * 28 + f * 4) } // kind,pos,end,next,parent,data,flags
    fn string(&self, idx: u32) -> &'a str {
        let (s, e) = (self.u32(self.str_offs + idx as usize * 4), self.u32(self.str_offs + idx as usize * 4 + 4));
        std::str::from_utf8(&self.b[self.strs + s as usize..self.strs + e as usize]).unwrap()
    }
    fn children(&self, i: usize) -> Vec<usize> {
        let mut out = vec![];
        if i + 1 < self.len() && self.field(i + 1, 4) as usize == i {
            let mut j = i + 1;
            loop { out.push(j); j = self.field(j, 3) as usize; if j == 0 { break } }
        }
        out
    }
    fn path(&self) -> &'a str { self.string(self.u32(self.ext + (self.field(1, 5) & 0xFF_FFFF) as usize + 8)) }
    fn ident(&self, i: usize) -> &'a str { self.string(self.field(i, 5) & 0xFF_FFFF) }
}

fn main() -> io::Result<()> {
    let args: Vec<String> = std::env::args().collect();
    let file = std::fs::canonicalize(&args[2])?.to_string_lossy().into_owned();
    let cwd = std::path::Path::new(&file).parent().unwrap().to_string_lossy().into_owned();
    let cfg_path = format!("{cwd}/__quicktype_tsconfig.json");
    let cfg = json!({ "compilerOptions": { "strict": false, "strictNullChecks": true, "noEmit": true, "target": "es2015",
        "module": "commonjs", "lib": ["es2015", "dom", "webworker.importscripts", "scripthost"], "typeRoots": [],
        "rootDir": cwd, "experimentalDecorators": true, "emitDecoratorMetadata": true }, "files": [file] });
    let mut c = Client::spawn(&args[1], &cwd, (cfg_path.clone(), cfg.to_string()))?;
    c.req("initialize", Value::Null)?;
    let snap = c.req("updateSnapshot", json!({ "openProjects": [cfg_path] }))?;
    let (s, p) = (snap["snapshot"].clone(), snap["projects"][0]["id"].clone());
    let diags = c.req("getSemanticDiagnostics", json!({ "snapshot": s, "project": p }))?;
    println!("semantic diagnostics: {diags}");
    let bytes = c.raw("getSourceFile", &json!({ "snapshot": s, "project": p, "file": file }))?;
    let ast = Ast::new(&bytes);
    for i in 2..ast.len() {
        if ast.field(i, 0) != SK_INTERFACE { continue }
        let name = ast.children(i).into_iter().find(|&j| ast.field(j, 0) == SK_IDENTIFIER).unwrap();
        let handle = format!("{name}.{SK_IDENTIFIER}.{}", ast.path());
        let sym = c.req("getSymbolAtLocation", json!({ "snapshot": s, "project": p, "location": handle }))?;
        let ty = c.req("getDeclaredTypeOfSymbol", json!({ "snapshot": s, "project": p, "symbol": sym["id"] }))?;
        println!("interface {} (symbol {}, type {})", ast.ident(name), sym["id"], ty["id"]);
        let props = c.req("getPropertiesOfType", json!({ "snapshot": s, "project": p, "type": ty["id"] }))?;
        for prop in props.as_array().unwrap() {
            let pt = c.req("getTypeOfSymbol", json!({ "snapshot": s, "project": p, "symbol": prop["id"] }))?;
            let text = c.req("typeToString", json!({ "snapshot": s, "project": p, "type": pt["id"] }))?;
            let opt = prop["flags"].as_u64().unwrap() & SYMBOL_OPTIONAL != 0;
            println!("  {}{}: {} (type flags {})", prop["name"].as_str().unwrap(), if opt { "?" } else { "" }, text.as_str().unwrap(), pt["flags"]);
        }
    }
    Ok(())
}
```

## Appendix B — spike artifacts

The spike's working directory (throwaway, not committed) held:

* `corpus/` (596 cases);
* `exp/ref.cjs` (reference harness), `exp/tjs7.mjs` (TJS port on TS 7), `exp/compare.mjs` and `exp/show.mjs`;
* `exp/hook.cjs`, `exp/e2e.sh` and `exp/e2e_all.sh` (end to end), `exp/ts5unions.cjs` (union-order emulation),
  `exp/uorder.mjs` (order probe);
* `out/{ref,ts7}/` (raw results), `rust/` (the prototype).
