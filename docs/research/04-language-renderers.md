# 04 — Target-language renderers: survey, dependencies, porting plan

Scope: `packages/quicktype-core/src/language/*` at commit c39af7d3 (26 directories, 27 CLI
languages: `TypeScriptFlow/` holds both TypeScript and Flow). Paths below are relative to
`packages/quicktype-core/src/language/` unless they say otherwise.

How the numbers were made:
- LOC: `find <Dir> -name '*.ts' | xargs wc -l` (includes `language.ts`, `utils.ts`, `constants.ts`).
- Names, options, capability flags: printed from the built `dist/language/All.js` (`all[]`).
- Golden counts: parsed every `rewrite/tests/golden/**/case.json`, grouped by `--lang` and `--src-lang`.
  Every case has exactly 1 step. Total = 10,132.

Totals: about 42.1k TS LOC in renderers. Of that, 2,591 LOC is `language.ts` (metadata and options).
The 4 largest directories (CJSON, C++, C#, Kotlin) make up 41% of the total.

---

## 1. Inventory

Base chain: `CR` = `ConvenienceRenderer` → `Renderer`. Golden column = total (json / schema /
graphql / comment-injection). Complexity: S < 700 LOC and few framework hooks; M; L; XL = more
than 3.5k LOC or deep coupling to core subsystems.

| Language (display) | Dir | LOC | Renderer class(es) | Base chain | CLI names (first is canonical) | Opts | Multi-file | Golden | Cx |
|---|---|---|---|---|---|---|---|---|---|
| C (cJSON) | CJSON | 6653 | `CJSONRenderer` | CR | `cjson`, `cJSON` | 9 | yes: `.h`+`.c` (`--no-header-only`); one file per type with `--source-style multi-source` | 314 (219/86/9/0) | XL |
| C++ | CPlusPlus | 4389 | `CPlusPlusRenderer` | CR | `c++`, `cpp`, `cplusplus` | 13 | yes: `--source-style multi-source` → `<Type>.hpp` + `helper.hpp` + `Generators.hpp` + `<out>.hpp` | 329 (231/89/9) | XL |
| C# | CSharp | 3756 | `NewtonsoftCSharpRenderer`, `SystemTextJsonCSharpRenderer` | → `CSharpRenderer` → CR | `cs`, `csharp` | 15 | no | 1005 (730/266/9) | XL |
| Crystal | Crystal | 481 | `CrystalRenderer` | CR | `crystal`, `cr`, `crystallang` | 0 | no | 302 (215/87) | S |
| Dart | Dart | 1335 | `DartRenderer` | CR | `dart` | 10 | no | 332 (236/87/9) | M |
| Elixir | Elixir | 1598 | `ElixirRenderer` | CR | `elixir` | 2 | no | 315 (218/88/9) | M |
| Elm | Elm | 1005 | `ElmRenderer` | CR | `elm` | 3 | no | 297 (218/79) | M |
| Flow | TypeScriptFlow | 821 (shared) | `FlowRenderer` | → `TypeScriptFlowBaseRenderer` → `JavaScriptRenderer` → CR | `flow` | 13 | no | 339 (241/89/9) | S (given TS) |
| Go | Golang | 950 | `GoRenderer` | CR | `go`, `golang` | 7 | `--multi-file-output` → `<Type>.go` (not in golden) | 314 (216/89/9) | M |
| Haskell | Haskell | 723 | `HaskellRenderer` | CR | `haskell` | 3 | no | 320 (223/88/9) | S |
| Java | Java | 2137 | `JacksonRenderer`; `JavaRenderer` (`--just-types`) | Jackson → `JavaRenderer` → CR; uses `DateTimeProvider` (Java8 / Legacy) | `java` | 7 | always: one `.java` file per class/enum/union, plus `Converter.java` | 790 (503/260/27) | L |
| JavaScript | JavaScript | 963 | `JavaScriptRenderer` | CR | `javascript`, `js`, `jsx` | 5 | no | 333 (236/88/9) | M |
| JavaScript PropTypes | JavaScriptPropTypes | 507 | `JavaScriptPropTypesRenderer` | CR (imports `JavaScript/utils`, `unicodeMaps`) | `javascript-prop-types` | 3 | no | 310 (223/87) | S |
| JSON Schema | JSONSchema | 289 | `JSONSchemaRenderer` | CR | `schema`, `json-schema` | 0 | no | 88 (0/88) | S* |
| Kotlin | Kotlin | 2302 | `KotlinJacksonRenderer`, `KotlinKlaxonRenderer`, `KotlinXRenderer`; `KotlinRenderer` (just-types) | → `KotlinRenderer` → CR | `kotlin` | 4 | no | 869 (623/246) | L |
| Objective-C | Objective-C | 1740 | `ObjectiveCRenderer` | CR | `objc`, `objective-c`, `objectivec` | 5 | always: `<Prefix><Top>.h` + `.m` (`--features`) | 318 (218/87/9/4) | L |
| PHP | Php | 2150 | `PhpRenderer` | CR (uses npm `lodash`) | `php` | 5 | no (overrides `finishFile`, but writes one file) | 305 (212/84/9) | M+ |
| Pike | Pike | 575 | `PikeRenderer` | CR | `pike`, `pikelang` | 0 | no | 312 (219/84/9) | S |
| Python | Python | 2172 | `JSONPythonRenderer`; `PythonRenderer` (just-types) | → `PythonRenderer` → CR | `python`, `py` | 4 | no | 331 (235/87/9) | L |
| Ruby | Ruby | 1538 | `RubyRenderer` | CR | `ruby` | 3 | no | 309 (220/89) | M |
| Rust | Rust | 852 | `RustRenderer` | CR | `rust`, `rs`, `rustlang` | 8 | no | 321 (231/90/0) | S |
| Scala3 | Scala3 | 1386 | `CirceRenderer`, `UpickleRenderer`; `Scala3Renderer` (just-types) | → `Scala3Renderer` → CR | `scala3` | 3 | no | 610 (438/172) | M |
| Smithy | Smithy4s | 639 | `Smithy4sRenderer` | CR | **`smithy4a`** (sic) | 2 | no | **0** | S |
| Swift | Swift | 1966 | `SwiftRenderer` | CR | `swift`, `swift4` | 18 | `--multi-file-output` → `<Type>.swift` (not in golden) | 375 (279/87/9) | L |
| TypeScript | TypeScriptFlow | 821 (shared) | `TypeScriptRenderer` | → `TypeScriptFlowBaseRenderer` → `JavaScriptRenderer` → CR | `typescript`, `ts`, `tsx` | 13 | no | 368 (266/89/9/4) | M |
| TS Effect Schema | TypeScriptEffectSchema | 488 | `TypeScriptEffectSchemaRenderer` | CR (imports `JavaScript/utils`) | `typescript-effect-schema` | 1 | no | 313 (223/88/0/2) | S |
| TS Zod | TypeScriptZod | 707 | `TypeScriptZodRenderer` | CR (imports `JavaScript/utils`) | `typescript-zod` | 1 | no | 313 (223/88/0/2) | S |

\* JSON Schema has the fewest lines of any renderer. Even so, it relies on core attribute
`addToSchema` code in `attributes/{Constraints,DefaultValue,TypeAttributes,URIAttributes,Description}.ts`,
and it must reproduce how JS `JSON.stringify` orders object keys (see section 5).

Language hooks that the **core pipeline reads before rendering**. These belong to `TargetLanguage`,
not the renderer, so they must exist before inference runs (`input/Inputs.ts:216-218`,
`Run.ts:180-190,233-251,464,479`):

| Lang | ext | indent | optProps | bothNum | fullObj | int range | stringTypeMapping (`a->b` means mapped) | special |
|---|---|---|---|---|---|---|---|---|
| cjson | h | 4sp | ✓ | ✓ | | **depends on option** `integer-size` (int8..int64) | — | |
| c++ | cpp | 4sp | ✓ | ✓ | | i64 | uuid, date-time | |
| crystal | cr | **2sp** | | | | i64 | — | |
| csharp | cs | 4sp | ✓ | ✓ | | i64 | date->date-time, time->date-time, date-time, uuid, uri, integer-string, bool-string | `needsTransformerForType` (CSharp/utils.ts `needTransformerForType`) |
| dart | dart | 4sp | | ✓ | | i64 | date, uuid, date-time | |
| elixir | ex | **2sp** | ✓ | | | **null** (arbitrary precision) | — | |
| elm | elm | 4sp | ✓ | ✓ | | ±2^53−1 | — | |
| flow / typescript / javascript | js/ts/js | 4sp | ✓ | | ✓ | ±2^53−1 | date->date-time, date-time, uuid | |
| javascript-prop-types | js | 4sp | | | | ±2^53−1 | uuid, date->date-time, date-time | |
| go | go | **`\t`** | ✓ | ✓ | | i64 | date-time | |
| haskell | `haskell` (sic) | 4sp | ✓ | ✓ | | i64 | — | |
| java | java | 4sp | | ✓ | | i64 | date, time, date-time, uuid | |
| schema | schema | 4sp | ✓ | | ✓ | null | date, time, date-time, uuid, uri, integer-string, bool-string | |
| kotlin | kt | 4sp | ✓ | ✓ | | i64 | date, time, date-time | **`KotlinDateTimeRecognizer`** (Kotlin/utils.ts:85) |
| objc | m | 4sp | | | | i64 | uuid, date-time | |
| php | php | 4sp | | ✓ | | i64 | uuid, date-time | |
| pike | pmod | 4sp | | | | null | — | |
| python | py | 4sp | | ✓ | | null | date, time, date-time, uuid, integer-string, bool-string | `needsTransformerForType` (Python/language.ts:132) |
| ruby | rb | **2sp** | ✓ | | | null | uuid, date-time | |
| rust | rs | 4sp | | | | i64 | — | |
| scala3 | scala | 4sp | ✓ | ✓ | | i64 | date-time, uuid | |
| smithy4a | smithy | 4sp | ✓ | ✓ | | i64 | — | |
| swift | swift | 4sp | ✓ | ✓ | | i64 | date-time, uuid | **`SwiftDateTimeRecognizer`** (Swift/utils.ts:38) |
| ts-effect-schema | ts | 4sp | ✓ | | | ±2^53−1 | uuid, bool-string, date, time, date-time, integer-string | |
| ts-zod | ts | 4sp | ✓ | | | ±2^53−1 | date-time, uuid, bool-string, integer-string | |

Only 2 languages turn on `makeTransformations` (`Run.ts:479`): C# and Python.

What the golden corpus covers, and what it does not:
- `--just-types` appears in **no** golden case. So `JavaRenderer`, `KotlinRenderer`, `PythonRenderer`
  and `Scala3Renderer` are only exercised as base classes of their framework subclasses.
- `--multi-file-output` (Go, Swift) and `--just-types-and-package` (Go) have no golden cases.
  Smithy4s has 0 cases, because the recorder never ran its fixture.
- Option variants that do appear, with case counts:
  - TypeScript: 12 option sets.
  - Swift: 15.
  - C#: 7 per framework, plus `--use-records`.
  - Rust: visibility, derive flags, density, integer-type.
  - Dart: from-map, copy-with, no-final-props, required-props, freezed, json-annotation.
  - C++: with-struct, east-const, boost, wstring.
  - Python: `--python-version` 3.5, 3.6, 3.7, 3.9.
  - JavaScript: converters, raw-type, ignore-unknown.
- The list above was collected by parsing the corpus's `case.json` files.
- JSON-input cases always pass `--alphabetize-properties`. Schema and GraphQL cases never do.
- Fixtures in `test/fixtures.ts` that are **not** in the golden corpus: `LeadingCommentsGoFixture`,
  `JSONSchemaJSONFixture(csharp)`, `JSONTypeScriptFixture(csharp)`, `CommentInjectionTreeSitterFixture`,
  and Smithy4s.

---

## 2. Dependency graph

```
                      Renderer (Renderer.ts)  ── EmitContext, emitTable, emitLineOnce, gatherSource,
                         │                       initializeEmitContextForFilename/finishFile
                 ConvenienceRenderer.ts ── naming (Naming.ts), DeclarationIR (all langs: decl order),
                         │                  CycleBreaker (isCycleBreakerType), comment escaping
   ┌───────────┬─────────┼─────────────┬──────────────┬───────────────┬────────────────┐
 JavaScriptRenderer   CSharpRenderer  JavaRenderer   KotlinRenderer  PythonRenderer   Scala3Renderer
   │                   ├Newtonsoft     └Jackson       ├Jackson        └JSONPython      ├Circe
 TypeScriptFlowBase    └SystemTextJson   (+DateTime-  ├Klaxon           (Transformers) └Upickle
   ├TypeScript           (Transformers)   Provider)   └KotlinX
   └Flow
 JavaScript/{utils.ts (legalizeName), unicodeMaps.ts} ◄── imported by TypeScriptFlow, PropTypes, Zod, EffectSchema
 JavaScript/language.ts (javaScriptOptions)          ◄── imported by TypeScriptFlow/language.ts
 everyone else: a standalone subclass of CR (CJSON, C++, Crystal, Dart, Elixir, Elm, Go, Haskell,
 JSONSchema, ObjC, PHP, Pike, Ruby, Rust, Smithy4s, Swift, Zod, Effect, PropTypes)
```

Cross-directory imports (complete list, from grepping `from "../X"`):
- `JavaScriptPropTypes` imports `JavaScript/{unicodeMaps,utils}`.
- `TypeScriptEffectSchema` imports `JavaScript/utils`.
- `TypeScriptZod` imports `JavaScript/utils`.
- `TypeScriptFlow` imports `JavaScript/{index,unicodeMaps,utils}`.
- No other language directory imports another.

Core modules each language depends on, beyond `CR`, `Naming`, `Source`, `Type/*`, `TypeUtils`,
`support/Strings`, `RendererOptions`, `TargetLanguage`:

| Core module | Used by |
|---|---|
| `Transformers.ts` and `MakeTransformations.ts` | C#, Python |
| `DeclarationIR` forward path (`needsTypeDeclarationBeforeUse=true`) | CJSON, C++, Elixir, Python, Ruby (C++ and Ruby also call `forEachDeclaration`; CJSON does too) |
| `CycleBreaker` (`isCycleBreakerType`) | C++ (also overrides `canBreakCycles`), Crystal, Rust, Swift, PropTypes |
| multi-file `EmitContext` (`finishFile` / `initializeEmitContextForFilename`) | CJSON, C++, Go, Java, ObjC, Swift (PHP overrides as a no-op) |
| `emitTable` / `emitPropertyTable` (column alignment) | C#, Elixir, Go, Kotlin (all 4), ObjC, Pike, Ruby, TS/Flow |
| `DependencyName` | C++, C#, Dart, Elm, Go, Haskell, Java, PHP, Python |
| `emitLineOnce` | Go, Swift |
| `gatherSource` (reordering) | Python, C++, PropTypes, Zod, Effect |
| `support/Acronyms` (`--acronym-style`) | Java, JS, PropTypes, Kotlin, PHP, Swift, Zod, Effect |
| `support/Converters` | JS, PropTypes |
| `DateTime` (custom recognizers) | Kotlin, Swift |
| attributes `Constraints` (min/max, pattern, minItems) | 18 languages (all except Crystal, Go, Haskell, Java, Scala3, Smithy, Swift, Schema) |
| `AccessorNames` / `EnumValues` | CJSON, C++ |
| `DefaultValue` | C++ |
| `Description` and attribute `addToSchema` | JSON Schema |
| npm `unicode-properties` | core Strings, C#, Elixir, ObjC, Python, Ruby |
| npm `lodash` | PHP (`_.pad`) |
| npm `collection-utils` | most languages (pure helpers) |

Porting precedence:
- **Core** comes first: Renderer, CR, Naming, Source serialization, Options, TypeUtils, Strings,
  Acronyms, DeclarationIR, CycleBreaker.
- **All 27 `language.ts` metadata** come next. They are needed for CLI parsing and inference.
- **JavaScript** must come before TypeScriptFlow, and its `utils`/`unicodeMaps` before
  PropTypes, Zod and Effect.
- **Transformers** must come before C# and Python.
- Nothing else depends on another language.

---

## 3. Framework features each language uses

Legend:
- XF = transformers
- CB = cycle breaker (`isImplicitCycleBreaker`)
- FD = forward declarations
- MF = multi-file
- TBL = table alignment
- DEP = `DependencyName`
- GNS = enum cases / union members in the global namespace
- ONCE = `emitLineOnce`
- `kw` = size of the forbidden-name arrays in `constants.ts`

| Lang | XF | CB | FD | MF | TBL | DEP | GNS | other hooks | Comment / description style | kw |
|---|---|---|---|---|---|---|---|---|---|---|
| CJSON | | | ✓ class | ✓ | | | | `proposeUnionMemberName`, `commentLinesSpliceOnBackslash`, `forEachDeclaration`, `unionNeedsName` | `/** * */` | 117 |
| C++ | | ✓ array/map without union child; `canBreakCycles` = class or union | ✓ class | ✓ | | ✓ getters/setters | | `forEachUniqueUnion`, `isForwardDeclaredType`, `directlyReachableTypes`, splice-on-backslash | `/** * */` | 100 |
| C# | ✓ | | | | ✓ | ✓ `_extensions` | | `makeNameForTransformation`, `typesWithNamedTransformations`, `unionNeedsName` | `/// <summary>` with XML escaping; dense: `"; "` join | 77 plus framework lists |
| Crystal | | ✓ array/map | | | | | | | `# ` | 137 |
| Dart | | | | | | ✓ | | `unionNeedsName`; unions not supported (emits nothing) | `///` | 75 |
| Elixir | | | ✓ class | | ✓ | | | `nameWithNamespace` | `# `; descriptions as `@moduledoc """` | 77+20 |
| Elm | | | | | | ✓ encoder/decoder | ✓ both | `proposeUnionMemberName` | `-- `; `{-\| -}` | 43 |
| Go | | | | ✓ opt | ✓ | ✓ `unmarshal_X` | ✓ enum | `makeNameForEnumCase` (suffix option), ONCE | `// ` | none |
| Haskell | | | | | | ✓ | ✓ both | `makeNameForEnumCase`, `proposeUnionMemberName` | `-- `; `{-\| -}` | 59 |
| Java | | | | ✓ | | ✓ | | `unionNeedsName`, DateTimeProvider | `/** * */` | 67 plus converter names |
| JS | | | | | | | | `makeNameForProperty` ignores assigned names; `namedTypeToNameForTopLevel` | `/** * */` | none |
| TS / Flow | | | | | ✓ property table | | | `emptyObjectType`, `quotePropertyName` | `/** * */` | 3 / 7 inline |
| PropTypes | | ✓ (none implicit) | | | | | | own topological order over gathered `Source` | `// ` | none |
| Zod / Effect | | | | | | | | own topological order (section 5) | `// ` | 7 inline |
| JSON Schema | | | | | | | | `unionNeedsName`; reads `this.names` directly | n/a (JSON) | none |
| Kotlin | | | | | ✓ | | | forbidden names depend on the graph (`haveTransformedStringType`) | `/** * */` | 49 plus framework lists |
| ObjC | | | | ✓ `.h`/`.m` | ✓ | | | class-prefix inference, splice-on-backslash | `/// ` | 43+9+17 |
| PHP | | | | (no-op) | | ✓ | | `unionNeedsName`, `getCombinedName` | `/** * */` | inline |
| Pike | | | | | ✓ | | ✓ enum | | `// ` | 52 |
| Python | ✓ | | ✓ class+enum | | | ✓ | | `sortClassProperties`, imports collected as a side effect | `# `; `"""` docstrings | 40+17 |
| Ruby | | | ✓ class | | ✓ | | | `forEachDeclaration` emits forward stubs | `# ` | 41+242+64 |
| Rust | | ✓ array/map → `Box<>` | | | | | | rename_all heuristic | `/// ` | 73 |
| Scala3 | | | | | | | | union `sortBy` | `/** * */` | 56+12+10+26 |
| Smithy4s | | | | | | | | union `sortBy`, `getCombinedName` | `/** * */` | 47+24 |
| Swift | | ✓ array/map → `indirect enum` | | ✓ opt | | | | ONCE, `propertyCount`, `proposedUnionMemberNameForTypeKind`, union `sortBy` | `/// ` | 118 |

`namedTypeToNameForTopLevel` is overridden in 19 languages. Most of them delegate to the core
helper `directlyReachableSingleNamedType`.

Most renderers print either the user's `leadingComments` or a generated "To parse this JSON…"
header. **CJSON, Haskell, Pike and JSON Schema never read `leadingComments`.** TS and Flow inherit
the behaviour from JS.

The `--out` filename (`givenOutputFilename`) affects output text in two ways:
- In the usage comment: JS, TS, Flow (`usageModuleName`, JavaScriptRenderer.ts:580;
  TypeScriptRenderer.ts:112-125).
- In output file names: PHP (`finishFile(givenFilename)`), ObjC (`.h`/`.m` base), C++ and CJSON
  (main or header name).

Python ignores it (`_givenOutputFilename`).

---

## 4. Porting order and work packages

### Phase 0 — core team, serial, before any work package starts

1. Framework: Renderer/EmitContext, Source serialization (tables, `modifySource`), Naming,
   ConvenienceRenderer, DeclarationIR, CycleBreaker, Options and the CLI option surface.
2. **Port all 27 `language.ts` files plus `all.rs`.** That means names, extension, display name,
   option definitions, and every capability hook from the table in section 1. Include the
   inference-time helpers that live in renderer directories:
   - `Kotlin/utils.ts` `KotlinDateTimeRecognizer`
   - `Swift/utils.ts` `SwiftDateTimeRecognizer`
   - `CSharp/utils.ts` `needTransformerForType`
   - `Python/language.ts` `needsTransformerForType`
   - `JavaScript/{unicodeMaps,utils}.ts` (shared by 5 directories)

   About 2.9k LOC. Each `makeRenderer` points at a stub constructor in that language's renderer
   file. **After Phase 0, each language directory belongs to exactly one work package.**
   Ownership passes from core to the package in sequence, so no two parties ever edit a file at
   the same time.
3. **Pilot 1: Rust** (first end-to-end proof). Reasons:
   - 852 LOC: renderer 428, utils 209.
   - 321 golden cases, 72% of them JSON input and **0 GraphQL**. It can go green with just the
     JSON input path.
   - It touches the core features almost every renderer needs: keyword-forbidden naming,
     class/enum/union emission, nullable unions, maps, `forEachTopLevel`/`forEachNamedType`
     ordering, descriptions (via schema), `emitMultiline`, and option plumbing (7 option variants
     in golden: visibility, derive flags, density, integer-type).
   - Its one advanced hook, the cycle breaker (`Box<>`), is itself a valuable core test.
   - No transformers, forward declarations, tables, `DependencyName`s or multi-file.
   - The team can read serde output fluently.

   Why not the other candidates:
   - **TypeScript** needs three classes (JS → TSFlowBase → TS, about 1.8k LOC), ES3 Unicode maps,
     a 260-line runtime-typecheck template, and property tables. It is the most valuable, but it
     is a poor first isolator.
   - **JSON Schema** has **no JSON-input cases**. All 88 cases need the schema-input pipeline,
     attribute `addToSchema`, and emulation of `JSON.stringify` key order.
   - **Go** is the best *second* pilot.
4. **Pilot 2: Go.** Adds `emitTable` width semantics, `DependencyName` (`unmarshal_*`), global
   enum namespace, `makeNameForEnumCase` override, `emitLineOnce`, `\t` indentation, `localeCompare`
   import sort, and the 9 GraphQL cases.
5. **Pilot 3: JSON Schema** (owned by core, because what it depends on is core attribute code).
   It validates the schema-input round trip, and it forces the JS-object-key-order and
   `JSON.stringify` emulation that core will need anyway.

Core must also deliver the following before particular work packages need them. They can be
scheduled while the work packages do their first languages.
- `Transformers.ts` and `MakeTransformations.ts`: needed by WP3 (C#) and WP6 (Python).
- The DeclarationIR forward path: needed by WP1, WP2 and WP6. Only those languages exercise it.
- Multi-file `finishFile` semantics: needed by WP1, WP2, WP4 and WP7.

### Phase 1 — eight parallel work packages

Each package owns whole `crates/quicktype-core/src/language/<dir>/` directories. No file is
shared between packages.

| WP | Languages (do them in this order) | TS LOC | Golden | Core prerequisites | Notes |
|---|---|---|---|---|---|
| WP1 C | CJSON | 6653 | 314 | forward declarations, multi-file | One huge but very repetitive file (`emitClassFunctions` alone is 2,600 LOC, lines 2212-4820). Port it mechanically. Golden includes the 3 multi-source/header fixtures. |
| WP2 C++ | Crystal → C++ | 4870 | 631 | forward declarations, `forEachDeclaration`, CycleBreaker + `canBreakCycles`, multi-file | Crystal (S) is a warm-up that already uses the cycle breaker. |
| WP3 .NET+ | Pike → C# (Newtonsoft → SystemTextJson → records) | 4331 | 1317 | Transformers | C# is the heaviest single target by case count. |
| WP4 JVM | Java (Jackson, then legacy DateTime, then lombok) → Kotlin (Jackson → KotlinX → Klaxon) | 4439 | 1659 | multi-file (Java), tables, Acronyms | KotlinDateTimeRecognizer is already in Phase 0. |
| WP5 Web | JavaScript → TypeScript → Flow → Zod → Effect Schema → PropTypes → Elm | 4491 | 2273 | property tables, Converters, Acronyms | Shared base classes reduce the effective work. Elm is here for balance; it shares no code with JS. |
| WP6 Dynamic | Ruby → Elixir → Python | 5308 | 955 | forward declarations, Transformers (Python) | All three set `needsTypeDeclarationBeforeUse`. |
| WP7 Apple+ | Swift → Objective-C → Dart | 5041 | 1025 | multi-file (ObjC), CycleBreaker, `emitLineOnce` | Swift has the largest set of options (18). |
| WP8 FP+ | Haskell → Scala3 (Circe → Upickle) → Smithy4s → PHP | 4898 | 1235 | `DependencyName` | Smithy4s has no golden cases. Create reference outputs with the Node build (`node dist/index.js --lang smithy4a`). |

Packages range from 4.3k to 6.7k LOC. WP1 is the largest, but its code is the most mechanical.
WP3 is the smallest, but C# needs transformers and has 1,005 cases.

Inside every package, verify JSON-input cases first, then schema, then GraphQL. For options and
paths that golden does not cover (just-types, multi-file-output, Smithy), build **differential
tests against `node dist/index.js`**.

---

## 5. Gotchas likely to break byte-exact parity

### 5.1 Cross-cutting (affects every package; core should provide helpers)

1. **UTF-16 semantics**
   - Table column widths use `.length` (Source.ts:156-171), so a non-BMP character counts as 2.
     This affects aligned output in TS/Flow interfaces, Go structs, Kotlin, C#, ObjC, Pike, Ruby
     and Elixir.
   - `utf16LegalizeCharacters` (C#, JS family) checks *each surrogate on its own*.
     `legalizeCharacters` checks code points. Pick the right one per language.
   - Escaping uses `utf16ConcatMap` in Dart, Java, Kotlin, PHP and `utf16StringEscape` (non-BMP
     becomes `😀`). It uses `utf32ConcatMap` in Rust, Swift, Ruby, Elm, Elixir, Crystal
     and core `stringEscape` (non-BMP becomes `\u{1F600}` or similar).
   - ObjC prefix inference uses `charCodeAt`.
2. **Unicode property tables.** `unicode-properties@1.4.1` supplies `isAlphabetic` and
   `getCategory` (C#, Elixir, ObjC, Python, Ruby) and `isPrintable`, letter and digit predicates
   in core Strings. Generate Rust tables from **that package's data**, not from Rust `char`
   methods, which follow a newer Unicode version.
3. **JS number → string** (`${n}`, `.toString()`, numbers inside a Sourcelike).
   - Shortest round-trip form; exponent notation at `>= 1e21` and `< 1e-6`; `-0` prints as `0`.
   - Hit by constraint literals (min/max, minLength, minItems) in JS/TS/Flow, Zod, Effect,
     PropTypes, C++, CJSON, C#, Python, Kotlin, PHP, Elixir, Dart, Elm, Pike, Ruby, Rust
     (`getIntegerType` range), and CJSON's `.toString()` of levels.
   - Needs one shared `js_number_to_string`.
4. **Regex flavour.** In Rust, `\d`, `\w`, `\s` and case-insensitive matching are Unicode-aware
   by default; in JS they are ASCII. Use `(?-u)` or explicit classes. Examples: Swift recognizer
   `\d+` (Swift/utils.ts:38), DateTime `TIME` with `/i`, Rust `namingStyles` regexes, Elixir
   `/^[0-9]+$/`, Kotlin-Jackson `/^[a-z][A-Z]/` (KotlinJacksonRenderer.ts:287). JS `.` matches a
   UTF-16 unit.
5. **Ordering primitives.**
   - `Array.prototype.sort()` with no comparator compares UTF-16 code units: Java imports
     (JavaRenderer.ts:485,498), JSON Schema `required` (JSONSchemaRenderer.ts:146).
   - Go imports use `localeCompare` (GolangRenderer.ts:543). Its inputs are ASCII, but do not
     swap in plain byte order without checking.
   - `mapSortBy`/`setSortBy` are stable sorts on string keys. Kotlin, Scala3, Swift and Smithy
     sort union members with `class` before `_kind` (KotlinRenderer.ts:438).
   - All `Map`/`Set` iteration is insertion-ordered, so use `IndexMap`/`IndexSet` everywhere.
6. **`emitLineOnce` uses identity** (Renderer.ts:120, 196). A single-string line is deduplicated
   *by value* against **every** item in the current emit target. That includes lines emitted
   earlier with plain `emitLine` (for example `"//"`). A multi-part line is a fresh array, so it is
   **never** deduplicated. A single `Name` object is deduplicated by object identity. This matters
   for Go and Swift headers.
7. **Rendering with side effects.** Several renderers record state while they produce type
   strings, even when the string is thrown away. Port the *call sequence*, not just the result:
   - Python imports (`withImport`, PythonRenderer.ts:123)
   - Effect's `emittedObjects`
   - C++ `_allTypeNames` (built via `sourcelikeToString(cppType(...))`, CPlusPlusRenderer.ts:3585-3620)
   - Kotlin forbidden names, which depend on graph contents
8. **`sourcelikeToString` evaluates names eagerly.** Names must already be assigned. It is used
   for file names (Java, Go, Swift, C++, ObjC), comment escaping (`escapeCommentLine`,
   ConvenienceRenderer.ts:1220-1278), and Rust rename checks.
9. **Comment escaping is driven by delimiters** (ConvenienceRenderer.ts:1205-1245).
   - Escapes are chosen from the delimiters that `emitCommentLines` receives: `/*` and `*/` →
     `/ *` and `* /`; `{-` and `-}`; `"""` (also doubles backslashes); a trailing-quote rule.
   - CJSON, C++ and ObjC append `.` to lines that end in `\`.
   - The 12 comment-injection golden cases (TS, ObjC, Zod, Effect) cover this.
10. **`emitMultiline`** asserts that indentation is a multiple of 4 and re-indents with the
    language's indent unit, so JSON Schema output follows `--indentation`.
    Elixir's description `firstLineStart: '@moduledoc """\n'` (ElixirRenderer.ts:837) puts a
    **raw newline inside a line item**: the next physical line gets no indentation.
11. **`finishFile` writes `[WARNING] … more than once` to stdout** through `console.log`
    (Renderer.ts:375-391). Zod and Effect write to stderr via `console.error`/`console.warn`.
    Decide on CLI parity: golden only records output files.
12. **Raw combined names.** `getCombinedName()` gives the *unstyled* type name. It appears in the
    Rust header comment (RustRenderer.ts:378), PHP, CJSON and Smithy.

### 5.2 Per language

**CJSON**
- 6.2k-line renderer. The bodies of `emitUnionFunctions` (729-2086), `emitClassFunctions`
  (2212-4820) and `emitTopLevelFunctions` (4932-5599) are deeply nested with per-level
  `child_level.toString()` variable naming.
- Include guards come from `new RegExp(/[^a-zA-Z0-9]+/,"g")` (5833, 5948).
- The `.c` file name comes from `.h` via `/\.h$/` (6259).
- `integer-size` changes *inference* through `getSupportedIntegerRange`.
- `hashtable-size` is a free string pasted verbatim.

**C++**
- `canBreakCycles` and `isImplicitCycleBreaker` (298-311) choose `std::shared_ptr` vs
  `std::optional`. Declaration order and forward declarations come from DeclarationIR.
- Multi-source include order follows `Set` insertion order (`_generatedFiles`, `_allTypeNames`).
- `boost` vs C++17 changes the optional/variant spelling.
- `wstring` changes string literals.
- The namespace is split on `::`.
- Constraint classes print numeric literals (gotcha 3).

**C#**
- `emitTransformer` and `emitDecodeTransformer` (NewtonSoft 539-1113, plus the matching
  SystemTextJson code) interpret every `Transformer` subclass. Their exact class hierarchy and
  `alwaysApplyTransformation` (utils.ts) must match.
- Two frameworks share `CSharpRenderer`. `csharp-version` 5 and 6 change syntax.
- `keep-property-name` uses a separate namer (`namingFunctionKeep`).
- Descriptions are XML-escaped (CSharpRenderer.ts:290-306). Dense mode joins lines with `"; "`.
- Identifier legality is checked on UTF-16 units with unicode-properties (CSharp/utils.ts:100-113).

**Crystal**
- 2-space indent.
- `T?` nullables.
- Arrays and maps are implicit cycle breakers.
- Top-level enums get a type alias (`t.kind === "enum"` predicate, CrystalRenderer.ts:208).

**Dart**
- UTF-16 escape.
- Six option-driven code paths: freezed, json_annotation, hive, copy-with, from-map, required/final.
- `_needEnumValues` appends an `EnumValues` class at the end.
- Unions emit nothing.

**Elixir**
- Forward declarations.
- `escapeDoubleQuotes` does not escape backslashes (utils.ts; used at 1045). `#` becomes
  `\u{23}` in some names (539).
- Purely numeric names get an `N` suffix (utils.ts `simpleNameStyle`).
- `@moduledoc` contains an embedded newline (gotcha 10).
- Integers are arbitrary precision.

**Elm**
- Union members and enum cases share the global namespace with types, so name collisions
  resolve differently.
- Encoder/decoder `DependencyName`s, with a fallback lookup between `_topLevelDependents` and
  `_namedTypeDependents` (ElmRenderer.ts:681+).
- The header has a mixed `emitCommentLines` + `--     import` line.

**Go**
- Column alignment of struct tags uses UTF-16 widths.
- `enum-type-name-suffix` builds a `DependencyName` `${proposed}_${enum}` (GolangRenderer.ts:79-100).
- `MarshalJSON`/`UnmarshalJSON` are forbidden union-member names only when not just-types.
- The default indent is a tab. Tables still pad with spaces.

**Haskell**
- Global namespaces as in Elm.
- A one-line description becomes `{-| … -}` on one line through `emitComments(customLines)`.
  Several lines become a block.
- `StrictData`/`OverloadedStrings` pragmas and the export list are built from `forEach*`
  ordering.

**Java**
- One file per type.
- `ensureBlankLine` at the start of each file (JavaRenderer.ts:246).
- Leading comments go only into the *first* file (`_haveEmittedLeadingComments`).
- Imports are sorted by UTF-16 order.
- java8 and legacy `DateTimeProvider` emit different helper blocks.
- Forbidden names include the converter class and its keywords (86-95).
- Paths are `src/main/java/io/quicktype/*` relative to the directory of `--out`.

**JavaScript**
- The runtime-typecheck helpers are template literals with conditional fragments
  (`hasArrayConstraints`, `hasUUID`, `runtimeTypecheckIgnoreUnknownProperties`;
  JavaScriptRenderer.ts:358-556). Whitespace inside them is load-bearing.
- `JSON.stringify(pattern)` is used for regex constraints.
- Property names ignore the assigned name (`makeNameForProperty`, line 102).
- ES3 identifier tables (`unicodeMaps.ts`) are applied per UTF-16 unit.
- The module name in the usage comment is derived from `--out` (580-586).

**TypeScript / Flow**
- Interfaces go through `emitPropertyTable`, so they are column-aligned.
- `quotePropertyName` (TypeScriptFlow/utils.ts) quotes a name when the first code point fails
  ES3-start, when escaping changes it, or when legalizing changes it.
- `--prefer-const-values` turns single-case enums into string literals.
- TypeScript only: `minItems` becomes tuple spelling (TypeScriptRenderer.ts:36+).
- `explicit-unions` (option `declareUnions`) decides between inline and named unions.

**PropTypes**
- Output order is computed by walking the *gathered* `Sourcelike` tree with `Object.values()`
  to find `Name` references (JavaScriptPropTypesRenderer.ts:337-364). The Rust `Source` tree must
  expose an equivalent "names referenced" traversal.
- The loop pick is "first ready, else last pending".

**Zod**
- Multi-pass topological sort keyed on `typeRef` *numbers* (TypeScriptZodRenderer.ts:460-610).
  Types in a cycle come first, wrapped in `z.lazy`.
- Gives up after 999 passes.
- `typeRef` numbering must match TS exactly. That is a core TypeGraph concern.

**Effect Schema**
- The order is bug-compatible: `ordinal = Math.max(ordinal, depIndex + 1)` uses the dependency's
  index in `mapKey`, not its position in `order` (TypeScriptEffectSchemaRenderer.ts:355-376).
- `S.suspend(() => X)` vs `X` depends on the mutable `emittedObjects` at the moment of rendering
  (lines 125-130, 278-282).

**JSON Schema**
- `JSON.stringify(obj, undefined, "    ")` (JSONSchemaRenderer.ts:205) follows JS rules:
  - Integer-like property keys (`"0"`, `"42"`) are hoisted and sorted numerically ahead of other keys.
  - Keys whose value is `undefined` are omitted.
  - JSON escaping covers only `"`, `\`, control characters and lone surrogates; other non-ASCII stays raw.
- `definitions` order: objects, then named unions, then enums.
- Schema keys come in attribute-insertion order, from core `addToSchema`.

**Kotlin**
- Four renderers.
- `KotlinDateTimeRecognizer` changes inference:
  - It rejects 29 February in non-leap years.
  - It rejects a time whose fraction ends in `0`.
  - It rejects `+00:00` offsets.
  - It rejects offsets over 18 hours.
- Forbidden names add `LocalDate`/`OffsetDateTime` only if the graph has those types.
- Klaxon and Jackson use tables heavily.

**Objective-C**
- The class prefix is inferred from the first top-level name: the leading uppercase run minus
  its last letter, falling back to `QT` (ObjectiveCRenderer.ts:88-108).
- The `.h` and `.m` file names come from `--out` via `splitExtension` (1277).
- Lines that end in a backslash are spliced.
- `forbiddenPropertyNames` and `booleanPrefixes` apply.

**PHP**
- `_.pad(String(1 + idx % 31), 2, "0")` pads on the *right* for one digit: `5` → `"50"`
  (PhpRenderer.ts:989, verified with node).
- `emitMultiline` templates for top-level map and primitive classes (1887-1915).
- `?>` becomes `? >`, and `~` is escaped inside `preg_match('~…~u')` (1106, 1483-1485).

**Pike**
- No options.
- Enum cases are in the global namespace.
- The extension is `pmod`.

**Python**
- `JSONPythonRenderer` (1323 LOC) emits converter code from transformers (integer-string, bool-string).
- Imports come out in **discovery order**, not sorted. Body declarations are gathered first,
  then closing code, then support code (PythonRenderer.ts:498-541).
- Forward references are quoted depending on `declaredTypes` *at the moment of rendering*
  (146-216). PEP 604 unions quote the whole expression.
- With dataclasses or pydantic, `sortClassProperties` moves `= None` fields last and **ignores
  `--alphabetize-properties`** (434-450).

**Ruby**
- `forEachDeclaration` emits forward stubs, `# (forward declaration)` followed by
  `class X < Dry::Struct; end` (RubyRenderer.ts:923-934).
- 242 Ruby globals are forbidden.
- `--namespace` is split on `::` into nested modules.
- `strictness` changes every `Types::` reference.

**Rust**
- The `rename_all` heuristic (RustRenderer.ts:243-258, utils.ts:170-209):
  - It counts regex-matched naming styles.
  - On a tie it prefers the default style, otherwise the *first in declaration order* of
    `namingStyles`.
  - `#[serde(rename)]` is emitted when the escaped JSON name differs from the restyled
    assigned name.
- `breakCycle` has a special case for nullable unions.

**Scala3**
- Three renderers.
- `invalidSymbols` contains a duplicate entry.
- Backtick quoting.
- Union members sorted with `class` first.

**Smithy4s**
- Zero golden coverage.
- `s.replace(" ", "")` removes only the *first* space (Smithy4sRenderer.ts:94).
- The CLI name is `smithy4a`.

**Swift**
- `SwiftDateTimeRecognizer` regex (needs an ASCII `\d`).
- `emitLineOnce` header semantics (gotcha 6).
- `indirect enum` comes from the cycle breaker.
- In dense mode, coding-key groups depend on `sourcelikeToString(name) === stringEscape(json)`
  (417-440).
- 18 options, including access-level, protocol, sendable and objc support (golden covers 15
  combinations).

---

## 6. Top risks, ranked

1. **Unicode and UTF-16 fidelity:** table widths, legalization, escaping, `unicode-properties`
   version. It touches every language and fails quietly on non-ASCII inputs in `test/inputs/json/misc`.
2. **Emulating JS semantics:** number formatting, `JSON.stringify` key order, default sort,
   `localeCompare`, regex flavour, lodash `pad`. A shared "jsrt" helper module in core is
   needed before Phase 1.
3. **Order and side effects inside renderers:** Python imports, Effect, Zod and PropTypes
   ordering, `emitLineOnce` identity, Set and Map insertion order. Ports that are "cleaner" than
   the original will break bytes.
4. **Core subsystems exercised by only a few languages** (Transformers for C#/Python, DeclarationIR
   forward declarations for C/C++/Python/Ruby/Elixir, multi-file EmitContext reuse). Bugs in them
   show up late, inside the largest packages (WP1-WP3, WP6).
5. **Metadata that affects inference lives in language directories**: date-time recognizers,
   integer ranges that depend on options, `stringTypeMapping`, `supports*` flags,
   `needsTransformerForType`. If this is not ported in Phase 0, mismatches show up far from their
   cause. Coverage gaps (just-types, multi-file-output, Smithy4s) need differential tests against
   Node.
