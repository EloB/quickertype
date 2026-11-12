# 03 — Rendering framework and naming

Reference: quicktype `c39af7d3`, paths relative to `packages/quicktype-core/src/`. Everything below was read from
source and, where marked (verified), confirmed by running the built reference (`node dist/index.js`, or `dist/`
modules directly).

Pipeline inside one render (`TargetLanguage.renderGraphAndSerialize`, TargetLanguage.ts:74):

```
makeRenderer(ctx, rawOptions)          // getOptionValues: option parsing/validation happens HERE (render time)
renderer.setAlphabetizeProperties(b)   // only if ConvenienceRenderer (all 26 are)
renderer.render(givenOutputFilename)   // Renderer.ts:393
  names  = assignNames(setUpNaming())  // ConvenienceRenderer.ts:312, Naming.ts:457
  emitSource(filename)                 // ConvenienceRenderer.ts:1346: processGraph(); emitSourceStructure(filename)
  if current EmitContext non-empty: finishFile(givenOutputFilename)
for each (filename, Source) in finishedFiles (insertion order):
  serializeRenderResult(source, names, indentation ?? language.defaultIndentation)  // Source.ts:177
```

## 1. Source / Sourcelike model and serialization

### 1.1 Data model (Source.ts:8-66)

`Source` = `text{text}` | `newline{indentationChange}` | `sequence{sequence[]}` | `table{rows[][]}` |
`annotated{annotation, source}` | `name{named: Name}` | `modified{modifier: string->string, source}`. `Sourcelike` =
`Source | string | Name | Sourcelike[]`.

`sourcelikeToSource(sl)` (Source.ts:68): array → `sequence` of converted elements; string → split on `"\n"` **only**
(`\r` stays in the text); one piece → `text`, otherwise `sequence` of texts intercalated with **fresh** `newline(0)`
objects; `Name` → `name`; a Source passes through by reference. `newline()` always allocates a new object because
`indentationChange` is mutated later (Source.ts:59). Helpers: `annotated(a, sl)`, `maybeAnnotated(flag, a, sl)`
(returns `sl` untouched when false), `modifySource(f, sl)`, `singleWord(...sl)` = `{source: sl[],
needsParens:false}`, `multiWord(sep, ...words)` (asserts ≥1 word; 1 word → singleWord; else words joined by `sep`,
`needsParens:true`), `parenIfNeeded(mw)` → `["(", source, ")"]` or source.

### 1.2 EmitContext and the Renderer emit API (Renderer.ts:68-147, 175-355)

EmitContext state: `_emitted: Sourcelike[]` (the `_currentEmitTarget` is always the same array, so `isNested` is
always false), `_lastNewline`, `_numBlankLinesNeeded = 0`, `_preventBlankLine = true` ("no blank lines at start of
file").

- `pushItem(x)`: append, then `_preventBlankLine = false` (newlines count as items).
- `emitNewline()`: push a fresh `newline(0)`, remember it as `_lastNewline`.
- `emitItem(x)`: if `_emitted` non-empty, push `_numBlankLinesNeeded` newlines first (via emitNewline); then reset
  the counter to 0 and push `x`.
- `ensureBlankLine(n = 1)`: ignored while `_preventBlankLine`; else `needed = max(needed, n)`. Blank lines are only
  materialised by a *later* `emitItem`, so trailing `ensureBlankLine` calls never produce output.
- `preventBlankLine()`: `needed = 0; prevent = true` (until the next push).
- `changeIndent(d)`: `_lastNewline.indentationChange += d`; panics if no newline was ever emitted. It mutates the
  newline that **ended the previous line**, so the change applies from the next line on. Pending (not yet emitted)
  blank lines are not involved.
- `containsItem(x)`: `===` against every item of the current target: strings compare by value, `Name`s and arrays by
  identity (a fresh array never matches).

Renderer API:
- `emitLine(...parts)`: 0 parts → just a newline; 1 part → `emitItem(part)`; ≥2 → `emitItem(parts)` (one array
  item); then `emitNewline()`.
- `emitLineOnce(...parts)`: as emitLine, but skips both item and newline if `containsItem`. Only dedups single-part
  lines that are strings or the same Name object (Go uses it, GolangRenderer.ts:240-255; its `"//"` line is deduped
  against *every* earlier `"//"` item in the file).
- `emitMultiline(s)` (Renderer.ts:220): split on `"\n"`; first line via `emitLine` at current indent; for each later
  line compute `lineIndentation` (space = +1, tab = `(indent / 4 + 1) * 4` in **float** arithmetic, Renderer.ts:52)
  and assert `indent % 4 === 0`; whitespace-only/empty line → bare newline; else `changeIndent(indent/4 - current)`
  then `emitLine(text)`. Finally undo the indent.
- `gatherSource(fn)`: swap in a fresh EmitContext (so `prevent=true` at its start), run `fn`, return its item array,
  restore. `emitGatheredSource(items)`: `emitItem` each item (pending blank lines of the outer context apply before
  the first). `emitAnnotated(a, fn)`: gather, then one `emitItem(annotated(a, sequence))`. `emitIssue(msg, fn)` =
  annotated with `IssueAnnotationData(msg)`.
- `emitTable(rows)`: no-op on empty; else one `table` item (each cell `sourcelikeToSource`d) + newline.
- `indent(fn)` = `changeIndent(1); fn(); changeIndent(-1)`.
- `iterableForEach(it, f)`: position = `"only"` if length 1, else `"first"` (index 0), `"last"`, `"middle"`.
  `forEach(it, interposed, leading, f)`: before first/only item `ensureBlankLine(leading)`, before others
  `ensureBlankLine(interposed)`; returns whether anything was iterated. `forEachWithBlankLines(it, cfg, f)`: cfg is
  `"none"|"interposing"|"leading"|"leading-and-interposing"` or `[position, count]` (count defaults to 1); maps to
  (interposed, leading) counts.

### 1.3 serializeRenderResult (Source.ts:177-311)

State: `indent = 0`, `indentNeeded = 0`, `lines = []`, `currentLine = []`. `indentIfNeeded()` pushes `indentation ×
indentNeeded` and zeroes it. Per node:
- `text`: indentIfNeeded, append. `name`: assert assigned, indentIfNeeded, append the assigned string.
- `newline`: `finishLine()` (push joined line), `indent += change`, `indentNeeded = indent`.
- `sequence`: recurse in order.
- `modified`: indentIfNeeded; serialize the inner source **independently** (fresh indent 0, same indentation
  string), assert exactly one line, append `modifier(line)` (so names inside are resolved before the modifier sees
  them).
- `annotated`: record `{line: lines.length, column: utf16Len(currentLine)}` before/after; push `{annotation, span}`.
- `table` (Source.ts:227): `widths[y][x] = sourceLineLength(cell)` (UTF-16 `.length` of text / assigned name /
  `modified` result; newline or nested table inside a cell → panic); `numColumns = max row length`; `colWidth[x] =
  max over rows (missing cell = 0)`. For each row: indentIfNeeded; for each column `x < numColumns` serialize the
  cell (missing → empty text) and, if `x < numColumns-1 && w < colWidth`, append `colWidth - w` spaces; between rows
  `finishLine()` and `indentNeeded = indent` (the table's trailing newline comes from `emitTable`).
After the root: `finishLine()` once more.

Consequences (all verified with a test renderer and Go/C# output):
- Output = `lines.join("\n")` (CLI src/index.ts:1196 adds nothing). A file whose last emit was `emitLine` ends in
  exactly one `"\n"`; no trailing blank lines ever appear.
- Blank lines from `ensureBlankLine` are empty strings (indentation is only inserted when content follows). But
  `emitLine("")` inside an indent yields an **indentation-only line** (`"  "`).
- Tables produce **trailing spaces**: a row with fewer cells than `numColumns` is padded through every non-last
  column. Go puts description comments inside its property table, so Go comment lines carry long runs of trailing
  spaces (verified: `\t// x` + ~110 spaces).
- Strings containing `"\n"` that reach `text` via a `modified` result are not re-split.

### 1.4 Multi-file output (Renderer.ts:364-401)

- `finishFile(name)`: if `_finishedFiles` already has `name` (exact case) → `console.log("[WARNING] Tried to emit
  file ${name} more than once. If performing multi-file output this warning can be safely ignored.")` — **stdout**.
  Then `_finishedFiles.set(name, sourcelikeToSource(items))` (a JS `Map.set` on an existing key keeps its original
  position), store the context under `name.toLowerCase()` in `_finishedEmitContexts`, start a fresh context.
- `initializeEmitContextForFilename(name)` (Go, Swift `startFile`): if a finished context exists for
  `name.toLowerCase()`, make it current again — subsequent output *appends* to that file's items, including its
  pending blank-line/prevent state. If the new name differs in case, `_finishedFiles` ends up with two entries (old
  name: old content; new name: old+new content). Newline objects are shared between the old snapshot and the revived
  context (JS aliasing).
- Language wrappers: Java/C++/ObjC/PHP override `finishFile()` to pass their `_currentFilename`; CJSON calls
  `super.finishFile` per header/source; Go/Swift use `startFile`/`endFile`.
- Multi-file results are a `Map` in insertion order. CLI with `--out`: each file is written to
  `dirname(out)/filename`; without `--out` and >1 file it prints `// ${filename}\n\n` headers and a `"\n"` between
  files (src/index.ts:1190-1230). API `combineRenderResults` (Run.ts:649) concatenates `["// " + filename, ""] +
  lines` per file.

### 1.5 Annotations (Annotation.ts)

`AnnotationData` (empty base), `IssueAnnotationData(message)`, singletons `anyTypeIssueAnnotation` ("quicktype
cannot infer this type because there is no data about it in the input.") and `nullTypeIssueAnnotation` ("The only
value for this in the input is null, which means you probably need a more complete input sample."). Spans are
zero-based line/UTF-16 column. The CLI prints `\nIssue in line N: msg` + the line to stderr unless `--quiet` (the
whole golden corpus uses `--quiet`). Annotations never change file bytes.

## 2. Naming

### 2.1 Data model (Naming.ts)

- `Namespace(_name, parent, forbiddenNamespaces, additionalForbidden)` (Naming.ts:18): `_members` (Set<Name>,
  insertion order), `_children` (registered on the parent; used only for enumeration), `forbiddenNamespaces` (Set),
  `additionalForbidden` (Set<Name>). `forbiddenNameds` = lazily cached `additionalForbidden ∪ members of each
  forbidden namespace` (cached on first access, Naming.ts:55). The display `_name` is unused. Parenthood does
  **not** imply any forbidding.
- `Namer(name, nameStyle, prefixes, caseInsensitive=false)` (Naming.ts:88): prefixes deduped into a Set (insertion
  order). Namers are compared by **object identity** when grouping. `funPrefixNamer(name, style)` uses the prefixes
  `Purple, Fluffy, Tentacled, Sticky, Indigo, Indecent, Hilarious, Ambitious, Cunning, Magenta, Frisky, Mischievous,
  Braggadocious`.
- `Name(namingFunction | undefined, order)`; `namingFunction` getter panics when undefined.
  - `FixedName(str)`: order 0, no namer; `proposeUnstyledNames` panics.
  - `SimpleName(unstyled[], namer, order)`: proposals = `new Set(unstyled)` (dedup, order kept).
  - `DependencyName(namer, order, propose(lookup) => string)`: the constructor runs `propose` once with a lookup
    that records each requested Name and returns `"0xDEADBEEF"` → `dependencies` (Set). Proposals =
    `{propose(realLookup)}` (asserts only recorded deps are looked up).
  - `AssociatedName(sponsor, order, getName)`: no users outside Naming.ts; `nameAssignments` (Naming.ts:250) assigns
    associates together with their sponsor. Can be ported trivially or omitted.
- `keywordNamespace(name, kws)`: a parentless namespace of `FixedName(kw)` per keyword.

### 2.2 assignNames (Naming.ts:457) — global algorithm

1. `namespaces = allNamespacesRecursively(roots)` = `roots ∪ (for each root: recurse(children))` (roots first, then
   each root's subtree). ConvenienceRenderer passes `[globalForbidden, global,
   ...otherForbiddenNamespaces(values)]`.
2. Assign every FixedName in every namespace to its literal (asserting no exact-string conflict with
   members/forbiddens of that namespace — a duplicate keyword would be an InternalError).
3. `unfinished` = namespaces with an unnamed member (order of step 1).
4. Loop: pick the **first** namespace in `unfinished` whose `forbiddenNameds` are all named and which has ≥1 member
   that is *ready* (unnamed, all dependencies named). None → return the map (unnamed leftovers later fail
   `assert(names.has)` at serialization).
5. `forbiddenNames` (strings) = assigned strings of `members ∪ forbiddenNameds`, computed once per visit, then grown
   as names get assigned.
6. Inner loop until no ready member: `ready` = ready members (member order); `minOrder` = order of the first minimum
   (`iterableMinBy`, strict `<`); take all ready members with that order; group by namer identity (`setGroupBy`: Map
   in first-appearance order); within each, group by `namer.nameStyle(firstProposedName)` (first-appearance order);
   for each group call `namer.assignNames(ctx.names, forbiddenNames, group)` and add results to the context and to
   `forbiddenNames`. Readiness is recomputed each round, so DependencyNames join once their sponsors are named, even
   if their order is lower than names already processed.
7. Remove the namespace from `unfinished` only if all its members are named; otherwise it may be revisited later
   (with a recomputed `forbiddenNames`).

### 2.3 Namer.assignNames (Naming.ts:102-190) — conflict resolution and suffixes

```
forbidden = copy of forbiddenNames (Set<string>)
isForbidden(c) = ∃ f ∈ forbidden: f === c || (caseInsensitive && f === style(f) && c === style(c)
                                             && f.toLowerCase() === c.toLowerCase())
toPrefix = []
for name in group (insertion order):
  pick the first unstyled proposal p (proposal-set order) such that
     !isForbidden(style(p)) && no OTHER name in the group proposes exactly p (unstyled compare)
  if found and name.nameAssignments(forbidden, style(p)) !== null (exact-string check):
       assign; add to forbidden; continue
  toPrefix.push(name)
prefixIter = this._prefixes iterator  // ONE iterator for the whole call
suffix = 1                             // ONE counter for the whole call
for name in toPrefix:
  orig = first unstyled proposal
  loop:
    if prefixIter has next p: try = `${p}_${orig}`  else: try = `${orig}_${suffix}`; suffix++
    styled = style(try); if forbidden.has(styled) (exact only!) continue; assign; add; break
```

Consequences (verified with 18 colliding properties, Go and Python):
- Every prefix is consumed globally across the names of one call: the 1st prefixed name gets `Purple…`, the 2nd
  `Fluffy…` (or the next one if `Fluffy…` was taken), …; after 13 prefixes, `…1`, `…2`, … continue across names.
  Namers created with `[]` prefixes go straight to suffixes.
- A name loses its own first proposal if any other member of its group proposes the same unstyled string — e.g. two
  types both named `data` both skip `data` and take ancestor alternatives (`a_data` → `AData`, `b_data` → `BData`),
  verified.
- The case-insensitive check (Java/PHP type namers, JavaRenderer.ts:105, PhpRenderer.ts:92) applies only to the
  first pass; the prefix/suffix pass uses exact matching.
- **Namer identity matters.** Renderers that build a new Namer per call (Python, CJSON, Kotlin, TypeScriptZod,
  TypeScriptEffectSchema, Elixir, Ruby, ObjC per property, TypeScriptFlow with `nice-property-names`) put every
  property in its own group (fresh prefix iterator and suffix counter per name; no cross-name "proposed by another"
  exclusion). Module-level singletons (Go `namingFunction`, Rust `snakeNamingFunction`, …) are shared by types,
  properties, enum cases and union members.

### 2.4 Name creation in ConvenienceRenderer (ConvenienceRenderer.ts:312-743)

Orders: top-level 1 (`topLevelNameOrder`, exported); given type names 10; assigned property / enum case names 10;
property / enum case names 20; inferred type names 30 (`inferredNameOrder`, exported; C# uses +30 for converters);
union members 40; dependency names choose their own (often the sponsor's).

`setUpNaming` order — this is the member insertion order that breaks ties:
1. create store views; `_namedTypeNamer = makeNamedTypeNamer()`, `_unionMemberNamer`, `_enumCaseNamer`.
2. `globalForbidden = keywordNamespace("forbidden", forbiddenNamesForGlobalNamespace())`; `global =
   Namespace("global", undefined, [globalForbidden], [])`.
3. `{objects, enums, unions} = allNamedTypesSeparated()` — DFS pre-order from top-levels (map order) over
   `getChildren()` (class children = properties **sorted by JSON name**, then additional properties; union children
   sorted by kind), filtered by kind `class|object`, enum, union; `namedUnions = unions.filter(unionNeedsName)`
   (default: not `T | null`).
4. per top-level `(name, t)`: `maybeNamed = namedTypeToNameForTopLevel(t)` (default: `t` if named); `name =
   makeNameForTopLevel(t, name, maybeNamed)` (default `SimpleName([givenName], typeNamer, 1)`), add to global; add
   `makeTopLevelDependencyNames(t, name)` to global; if `maybeNamed`: add `makeNamedTypeDependencyNames(maybeNamed,
   name)` and store `name` as that type's name (a second top-level pointing at the same type overwrites the stored
   name). Store per top-level name.
5. objects: `addNameForNamedType` (reuse stored name if any; else `SimpleName(t.getNames().proposedNames, typeNamer,
   areInferred ? 30 : 10)` + its dependency names), then `addPropertyNames`.
6. enums: name + `addEnumCaseNames`. 7. named unions: name + `addUnionMemberNames`.
8. every type in `allTypesUnordered()` (type-index order) with a transformation: `makeNameForTransformation(xf,
   nameOf(xf.targetType))` (default none) → global.

`processForbiddenWordsInfo(info, nsName)` (:484): split `info.names` into Names (→ additionalForbidden) and strings.
The keyword namespace for strings is created **once per nsName per renderer** (first object/enum/union that returns
strings) and then attached to **every** later namespace of that kind, even ones that return no strings or different
strings. `includeGlobalForbidden` adds `globalForbidden`.

- Properties (:565): iterate `o.getSortedProperties()` (JSON names sorted by UTF-16 code units); per property
  consult accessor names (`getAccessorName`: fixed → `FixedName`); else `makeNameForProperty` (default: `namer =
  namerForObjectProperty(o,p)`; null → no name; `SimpleName(assigned ? [assigned] : [jsonName,
  `${o.getCombinedName()}_${jsonName}`], namer, assigned ? 10 : 20)` — the alternative uses the class's *combined
  unstyled* name, not its assigned name). The namespace (child of global) is created lazily at the first named
  property (so name-less classes have none), then `makePropertyDependencyNames` are added after each property.
  JavaScript/PropTypes ignore assigned names. Properties keep this sorted insertion order as member order
  (priority), while emission uses original order.
- Enum cases (:699): skipped if `_enumCaseNamer === null`; namespace = global if `enumCasesInGlobalNamespace` (Go,
  Haskell, Elm, Pike) else a new child; cases in `e.cases` order; `SimpleName([caseName,
  `${e.getCombinedName()}_${caseName}`], enumCaseNamer, 20)` or assigned (10).
- Union members (:643): skipped if `_unionMemberNamer === null`; global (Elm, Haskell) or child namespace; for each `t of
  u.members` (set order): accessor/fixed name, else `DependencyName(unionMemberNamer, 40, lookup => assigned ??
  proposeUnionMemberName(u, unionName, followTargetType(t), lookup))`. Default `proposeUnionMemberName` (:802):
  `proposedUnionMemberNameForTypeKind(kind)` (Swift) else any→`anything`, null→`null`, bool→`bool`,
  integer→`integer`, double→`double`, string→`string`, array→`${item}_array`, class/object→`lookup(nameOf(t))`,
  map→`${values}_map`, enum→`enum`, union→`union`, transformed string→`kind.replace("-", "_")` (first hyphen only).
  CJSON maps the final `bool`→`boolean`, `double`→`number`; Elm/Haskell append `_in_${lookup(unionName)}`.

Effective priority inside a namespace: lower `order` first → namer group (first appearance) → styled-proposal group
(first appearance) → member insertion order (top-levels, then DFS-ordered objects, enums, unions, transformations;
properties by sorted JSON name).

### 2.5 Proposals of a type (attributes/TypeNames.ts)

`proposedNames = Set([combinedName, ...alternativeNames])`. `combineNames(names)` (:49): 1 name → it; else map each
through `splitIntoWords(...).map(w => w.word.toLowerCase()).join("_")` (Set); if that collapses to 1 → it; else
longest common prefix and suffix (UTF-16 units, with the min-length clamping of :71-86) of all vs the first; keep
prefix/suffix only if length > 2; `prefix+suffix` if its length > 2, else the first. `TooManyTypeNames` (≥1000
names) carries a random `"${chance.city()} ${chance.animal()}"` name (support/Chance.ts: MT19937 seeded 31415, reset
per run by `initTypeNames()` in Run.ts:536; `city()` is drawn before `animal()`, which picks a category from
`[desert, forest, ocean, zoo, farm, pet, grassland]` and then an animal; retries until unused).
`TypeNames.singularize` uses `singularizeName` (`/cookies$/i` → drop the final `s`, else pluralize).

### 2.6 GatherNames (GatherNames.ts:93) — inferring names from paths

Called in Run.ts:515 with `destructive = !needSchemaProcessing` (JSON samples: true).

0. destructive: every type's names → `clearInferred()` (inferred name sets emptied).
1. **Propagation** (BFS with `UniqueQueue`: FIFO, a type already queued is not re-queued). `addNames(t,
   names|null)`: if `t` has *given* names, use those instead; if the stored set is `null` (too many) stop; `new =
   old ? old ∪ names : names`, `null` if size ≥ 1000; store; if `t` has a transformation, `addNames(target, names)`
   (the incoming names); re-queue `t` unless nothing changed (`old` and `new` both sets of equal size, or `old ===
   new`). Seed: each top-level gets `{topLevelName}`. Processing: object → each property (sorted by name) gets
   `{propertyName}`; additional-properties values get `names.map(pluralize.singular)`; array items get
   `names.map(pluralize.singular)`; union members (sorted by kind) get the same names. **GatherNames calls
   `pluralize.singular` directly** (no cookie fix): `cookies` → `Cooky` (verified).
2. **Alternatives** `processType(ancestor, t, suffix)`, DFS from every top-level with ancestor undefined, deduped
   per `(ancestor, t)` pair; transformation target first. If `t`'s names are null → both alternative sets null.
   Else, with an ancestor whose names are known, for each name: all `${an}_${name}`, then all
   `${an}_${name}_${t.kind}` (ancestor null → null); with a suffix: `${name}_${suffix}`. `addAlternatives` returns
   null once the set reaches 1000. Recursion: object properties (sorted) with ancestor `t`; additional properties
   with ancestor `properties.size === 0 ? ancestor : t` and suffix `"value"`; array items with `ancestor` and
   `"element"`; union members (sorted by kind) with ancestor `union` if the union has given names or is not
   nullable, else `ancestor`.
3. For each type (index order) with names: direct alternatives `∪= names.map(n => `${n}_${t.kind}`)`.
4. For each type: null names → `new TooManyTypeNames(1)` (consumes the RNG in type-index order); else alternatives =
   `undefined` if both sets null, else `direct ∪ ancestor` (missing/null → ∅); `TypeNames.makeWithDistance(names,
   alts, destructive ? 1 : 10)` (alts dropped if size > 1000 — note `>` here vs `>=` elsewhere); merged into
   existing names with `add` (lower distance wins, equal distances union, and alternatives are unioned in from
   **every** operand, even a farther one).
`debugPrint` (`--debug print-gather-names`) has a `return` (GatherNames.ts:208) that aborts the whole function at
the first unnamed type — changes output; not used by the corpus.

## 3. ConvenienceRenderer

### 3.1 Hooks subclasses override (defaults in parentheses)

- Abstract: `makeNamedTypeNamer()`, `namerForObjectProperty(o, p): Namer|null`, `makeUnionMemberNamer():
  Namer|null`, `makeEnumCaseNamer(): Namer|null`, `emitSourceStructure(givenOutputFilename)`.
- Naming: `forbiddenNamesForGlobalNamespace()` ([]), `forbiddenForObjectProperties(o, className)`,
  `forbiddenForUnionMembers(u, unionName)`, `forbiddenForEnumCases(e, enumName)` (all `{names: [],
  includeGlobalForbidden: false}`), `makeTopLevelDependencyNames(t, name)` ([]), `makeNamedTypeDependencyNames(t,
  name)` ([]), `makePropertyDependencyNames(o, cls, p, json, name)` ([]), `makeNameForTopLevel`,
  `makeNameForNamedType`, `makeNameForProperty`, `makeNameForUnionMember`, `makeNameForEnumCase`,
  `makeNameForTransformation` (undefined), `namedTypeToNameForTopLevel`, `proposedUnionMemberNameForTypeKind`
  (null), `proposeUnionMemberName`, getters `unionMembersInGlobalNamespace` / `enumCasesInGlobalNamespace` (false).
- Graph: `unionNeedsName(u)`, getter `needsTypeDeclarationBeforeUse` (false), `canBeForwardDeclared(t)` (panics),
  `isImplicitCycleBreaker(t)` (panics), `canBreakCycles(t)` (true).
- Output: `descriptionForType`, `descriptionForClassProperty`, `sortClassProperties` (Python), getter
  `commentLineStart` ("// "), getter `commentLinesSpliceOnBackslash` (false), `emitDescriptionBlock(lines)` (14
  renderers), `emitComments`, `emitCommentLines`, `emitDescription`.
- Renderer level: `finishFile`, `emitSource` (not overridden in practice).

### 3.2 processGraph (ConvenienceRenderer.ts:1311) and visiting order

`declarationsForGraph(graph, needsTypeDeclarationBeforeUse ? canBeForwardDeclared : undefined, childrenOfType, t =>
union ? unionNeedsName(t) : isNamedType(t))`. `childrenOfType` for a class: properties that have a Name, sorted by
their **assigned name** (UTF-16, stable), mapped to property types, deduped; otherwise `t.getChildren()`. (So
declaration order depends on naming.) `haveUnions/haveMaps/haveOptionalProperties` scan all types. `_namedTypes` =
types of `define` declarations in declaration order; `_namedObjects/_namedEnums/_namedUnions` keep that order.

Iteration helpers:
- `forEachTopLevel(cfg, f, pred?)`: top-level map order (filtered), name from the top-level store.
- `forEachDeclaration(cfg, f)`, `forEachNamedType(cfg, objF, enumF, unionF)` (panics for any other defined type),
  `forEachObject`, `forEachEnum`, `forEachUnion`: declaration order.
- `forEachUniqueUnion(cfg, key, f)`: first union per distinct key, in named-union order.
- `forEachClassProperty(o, cfg, f)`: original property order, or sorted by assigned name when
  `alphabetizeProperties`; `propertyCount(o)` = number of named properties.
- `forEachUnionMember(u, members|null, cfg, sortKey|null, f)`: member→name map filtered to `members ?? u.members`,
  **sorted** by `sortKey` (default: assigned name), stable.
- `forEachEnumCase(e, cfg, f)`: `e.cases` order (not sorted). `forEachTransformation`: type-index order.
- `forEachType(process)`: LIFO stack DFS from top-levels (pops last first), returns a Set of results.
Other: `nameForNamedType`, `nameForUnionMember`, `nameForEnumCase`, `nameForTransformation`,
`isForwardDeclaredType`, `isCycleBreakerType` (lazy `cycleBreakerTypesForGraph`), `haveNamedUnions`,
`haveNamedTypes`, `enums`, `haveEnums`, `sourcelikeToString(sl)` (serialize with indentation "" and join lines with
"\n").

### 3.3 Comments and descriptions (ConvenienceRenderer.ts:94, 1137-1309)

- `splitDescription(descs)`: join (Set order) with `"\n\n"`; replace `/\r\n?|[\u0085\u2028\u2029]/g` with `"\n"`; JS
  `trim()`; empty → undefined; `wordwrap(90)`; split on `"\n"`; JS `trim()` each. Verified: a first word longer than
  90 units yields a leading empty line (rendered as `//` / `///`); tabs become 4 spaces; U+2028 splits lines; a
  trailing U+FEFF is trimmed.
- `emitComments(comments)`: string → `emitCommentLines([c])`; `{lines}` → `emitCommentLines(lines)`;
  `{descriptionBlock}` → `emitDescriptionBlock`; else `emitCommentLines(customLines, c)`; then `ensureBlankLine()`
  after each.
- `emitCommentLines(lines, {lineStart = commentLineStart, firstLineStart = lineStart, lineEnd, beforeComment,
  afterComment})`: escapes chosen from the delimiters: if any of them contains `/*` or `*/` → replace `/*`→`/ *`,
  `*/`→`* /`; `{-`/`-}` → `{ -`/`- }`; `"""` → `\`→`\\` then `"""`→`\"\"\"` (applied in this order as replace-all on
  the stringified line). If `lineEnd` starts with `"`, a trailing `"` preceded by an even number of backslashes
  becomes `\"`. If `commentLinesSpliceOnBackslash` and the line ends in `\`, append `.`. With no escapes needed the
  Sourcelike passes through untouched. `beforeComment`/`afterComment` are own lines. For each line, if it
  stringifies to `""` the start is `trimEnd`ed (`"// "` → `"//"`); `lineEnd` is appended only if truthy.
- `emitDescription(d)` → `emitDescriptionBlock(d)` → `emitCommentLines(d)`. `emitPropertyTable(c, row)`: rows
  accumulate; a property with a description flushes the table, then emits the description.

## 4. support/Strings.ts (every helper)

Unicode predicates use `unicode-properties` 1.4.1 `getCategory(cp)` = **Unicode 12.0** data (U+1F971 assigned,
U+32FF not); unassigned code points, noncharacters and out-of-range values (including `NaN`, -1) return **`"Cc"`**
(no `Cn`). 836,606 code points differ from Node's own `\p{gc}`, e.g. U+0295 is `Ll` here. `isLowerCase` = `Ll`,
`isUpperCase` = `Lu`, `isWhiteSpace` = `Zs|Zl|Zp` (**not** TAB/LF/CR), `isAlphabetic` = L*|Nl (used by C#/ObjC).

- `isPrintable(cp)`: false above U+FFFF; true for categories Mc No Sk Me Nd Po Lt Pc Sm Zs Lu Pd So Pe Pf Ps Sc Ll
  Lm Pi Nl Mn Lo (so false for Cc, Cf, Co, Cs, Zl, Zp, unassigned).
- `isAscii` (<128), `isLetter` (Lu Ll Lt Lo — not Lm), `isDigit` (Nd), `isNumeric` (No Nd Nl), `isLetterOrDigit` =
  `isWordCharacter` (letter|Nd), `isLetterOrUnderscore`, `isLetterOrUnderscoreOrDigit`.
- `utf16ConcatMap(mapper)`: for each **UTF-16 unit** concatenates `mapper(unit)`; ASCII results are precomputed and
  units mapping to themselves are copied verbatim (same result).
- `utf32ConcatMap(mapper)`: same, but a high surrogate is combined with the next unit into a code point; if the next
  unit is not a low surrogate (or missing) → `QuickTypeError MiscUnicodeHighSurrogateWithoutLowSurrogate`
  ("Malformed unicode: High surrogate not followed by low surrogate"). A lone low surrogate is passed to the mapper
  as is.
- `utf16LegalizeCharacters(isLegal)`: keep units for which `isLegal(unit)`. `legalizeCharacters(isLegal)`: utf32
  walk; keep `cp` iff `cp <= 0xFFFF && isLegal(cp)` — **astral characters are always dropped** (verified `a😀b` →
  `ab`).
- `repeatString(s, n)` (asserts n ≥ 0); `intToHex(i, w)`: lowercase hex, left-padded with `0` to w, never truncated;
  `standardUnicodeHexEscape(cp)`: `\uXXXX` if ≤ 0xFFFF else `\UXXXXXXXX`.
- `escapeNonPrintableMapper(printable, escaper)`: `\`→`\\`, `"`→`\"`, LF→`\n`, TAB→`\t`, printable → itself, else
  `escaper(u)`. `utf16StringEscape` (unit-wise; astral → two `\udXXX`) and `stringEscape` (code-point-wise; astral →
  `\U0001f600`) both use `isPrintable` + `standardUnicodeHexEscape`.
- `trimEnd(s)`: strips trailing units with `unicode.isWhiteSpace(charCode)` (Zs/Zl/Zp only; verified `"ab \t\n\u00a0
  "` → `"ab \t\n"`).
- `capitalize`/`decapitalize`: `s[0].toUpperCase()/toLowerCase() + s.slice(1)` — first **UTF-16 unit**: astral first
  chars never change; full case mapping can expand (`ßa` → `SSa`, `İ` → `i̇`); title-case letters upper-case (`ǆ` →
  `Ǆ`).
- `pascalCase(s)`: split on `/[-_. ]+/`, `capitalize` each, join (no legalization); `camelCase` =
  `decapitalize(pascalCase(s))`; `snakeCase` = `splitIntoWords` words lowercased joined by `_`.
- `startWithLetter(isAllowedStart, upper, s)`: `""` → style(`"empty"`); tests `charCodeAt(0)` (unit); else
  style(`"the" + s`); style = capitalize/decapitalize.
- `splitIntoWords(s)` (:371) — operate on UTF-16 index `i`, reading `codePointAt(i)` but advancing by **one unit**
  (the low half of a pair is read as itself, category `Cs`). `lastLowerCaseIndex` is set whenever a skipped unit is
  `Ll`. ``` loop: skip non-word (not letter/Nd); if end break; start = i if Ll(cp): skip Ll; skip Nd; commit elif
  Lu(cp): skip Lu if end: commit elif i - start == 1: skip Ll; skip Nd; commit          // "Bar99" elif isDigit(cp):
  skip Nd; commit                       // "ABC123" else: if isWordChar(cp) then i -= 1; commit            //
  "XMLHttp" → "XML" | "Http" else: skip while !(Ll|Lu)  /* digits, Lt, Lo, spaces, punctuation… */ ; commit commit:
  if !end && unit at i is a low surrogate: i += 1 allUpper = lastLowerCaseIndex undefined || lastLowerCaseIndex <
  start; push [start, i, allUpper] word.isAcronym = (final lastLowerCaseIndex !== undefined && allUpper) ||
  knownAcronyms.has(word.toLowerCase())   // 1,095 entries, Acronyms.const.ts ``` Verified: `"123 abc"` → `["123 "*,
  "abc"]` (the space stays in the word), `"XMLHttpRequest"` → `XML* Http* Request`, `"iOS"` → `i OS*`, `"9lives"` →
  `9* lives`, `"ǅemal"` → `ǅ* emal`, `"a😀b"` → `a b`, `"𝐀𝐁c"` → `𝐀* 𝐁* c`, `"ABC123def"` → `ABC123* def`.
- Word styles: `firstUpperWordStyle` = `s[0].toUpperCase() + s.slice(1).toLowerCase()` (asserts non-empty),
  `allUpperWordStyle`, `allLowerWordStyle`, `originalWord`.
- `combineWords(words, legalize, firstStyle, restStyle, firstAcronymStyle, restAcronymStyle, sep, isStart)`:
  legalize each word, drop empties; none left → `[legalize("empty")]` (asserts non-empty); style the first word
  (acronym style if `isAcronym`); if `isStart(codePointAt(0))` of the styled first word fails, emit
  `firstStyle(legalize("the"))` and style **all** words (including the first) with the rest styles; join with `sep`.
  `styleWord` asserts input and output non-empty.
- `makeNameStyle(style, legalize, prefix?)`: pascal/camel/`*-upper-acronyms`/original use `""`, others `"_"`. Rest
  words: firstUpper (rest acronyms: allUpper for `*-upper-acronyms`, else firstUpper). First word: pascal* →
  firstUpper; camel* → allLower; underscore → all lower; upper-underscore → all upper; original → unchanged and
  **not split** (one word). Start predicate `isLetterOrUnderscore`; `prefix` added via `addPrefixIfNecessary` (only
  if the name doesn't already start with it). Verified table: `"123abc"` → `The123Abc | the123Abc | the_123_abc |
  THE_123_ABC`; `"URLValue"` → `UrlValue`, upper-acronyms `UrlValue`; `"jsonID"` → `JsonId`, upper-acronyms
  `JsonID`; `"ß_test"` (ASCII legalizer) → `Test`, original `_test`.
- Acronyms.ts: option `acronym-style` (original|pascal|camel|lowerCase, secondary); `acronymStyle`: pascal →
  **allUpper**, camel → firstUpper, original → unchanged, lowerCase → allLower. Converters.ts: option `converters`
  (top-level|all-objects, default top-level, secondary). Comments.ts: `Comment = string | {lines} |
  {descriptionBlock} | CommentOptions & {customLines}`. Support.ts:
  `defined`/`nonNull`/`assert`/`panic`/`assertNever` throw `InternalError` ("Internal error: …"),
  `indentationString(n)` = two spaces × n, `isStringMap` uses `getOwnPropertyNames`, `checkArray`/`checkStringMap`
  messages interpolate with JS `ToString`.

## 5. RendererOptions, TargetLanguage, registry

`Option(definition)` (RendererOptions/index.ts:13): `getValue(values) = values[name] ?? default`.
- `BooleanOption(name, desc, default, kind="primary")`: CLI defs `[def, {name: "no-"+name, default: !default}]`;
  help shows `[no-]name` with ` (on|off by default)`. `getValue` (:106): value = `values[name]` (undefined →
  default; note `===undefined`, so `null` survives), negated = `values["no-"+name]` (undefined → `!default`);
  strings `"true"/"false"` convert (value only, not negated); result `default ? (value && !negated) : (value ||
  !negated)` with JS truthiness. The CLI's command-line-args fills **both** keys with their default values, so they
  are always present.
- `StringOption(name, desc, typeLabel, default, kind)`.
- `EnumOption(name, desc, values: {key: value}, defaultKey, kind)`: `typeLabel = Object.keys(values).join("|")`
  (integer-like keys first). `getEnumValue(key)`: falsy (`""`, undefined, null) → `values[default]`; `!(key in
  values)` → `QuickTypeError RendererUnknownOptionValue` "Unknown value ${value} for option ${name}"; `in` also
  accepts prototype keys (`constructor`, `toString`, …). Mapped values may be booleans, numbers or objects (Python
  `python-version` → feature object, C# `csharp-version` → 5/6/8).
- `getOptionValues(options, raw)` (:40): for each entry of the language's options object (key order) compute the
  value; enums mapped. Called inside `makeRenderer`, i.e. errors surface only at render time, after inference.
  Unknown keys are ignored by core (the CLI rejects unknown flags).
- `OptionDefinition`: name, alias?, defaultOption?, description, optionType (string|boolean|enum), defaultValue,
  values?, kind (primary|secondary|cli), multiple?, typeLabel. `optionDefinitions` = definitions in key order;
  `cliOptionDefinitions` = concatenated actual/display.

`TargetLanguage({displayName, names, extension})`: `name = names[0]` (used for accessor-name lookups); defaults:
`defaultIndentation` 4 spaces, `stringTypeMapping` empty, `supportsOptionalClassProperties`,
`supportsUnionsWithBothNumberTypes`, `supportsFullObjectType`, `needsTransformerForType` → false,
`dateTimeRecognizer` default, `getSupportedIntegerRange` → INT64. `extension` is metadata only; the CLI infers the
language from the `--out` extension *as a language name* (src/index.ts:274).

Registry `all` (language/All.ts:38, this order) — display [names] ext, indentation 4 spaces unless noted: 1 C
(cJSON) [cjson, cJSON] h · 2 C++ [c++, cpp, cplusplus] cpp · 3 Crystal [crystal, cr, crystallang] cr, 2sp · 4 C#
[cs, csharp] cs · 5 Dart [dart] dart · 6 Elixir [elixir] ex, 2sp · 7 Elm [elm] elm · 8 Flow [flow] js · 9 Go [go,
golang] go, TAB · 10 Haskell [haskell] haskell · 11 Java [java] java · 12 JavaScript [javascript, js, jsx] js · 13
JavaScript PropTypes [javascript-prop-types] js · 14 JSON Schema [schema, json-schema] schema · 15 Kotlin [kotlin]
kt · 16 Objective-C [objc, objective-c, objectivec] m · 17 PHP [php] php · 18 Pike [pike, pikelang] pmod · 19 Python
[python, py] py · 20 Ruby [ruby] rb, 2sp · 21 Rust [rust, rs, rustlang] rs · 22 Scala3 [scala3] scala · 23 Smithy
[**smithy4a** (sic)] smithy · 24 Swift [swift, swift4] swift · 25 TypeScript [typescript, ts, tsx] ts · 26
TypeScript Effect Schema [typescript-effect-schema] ts · 27 TypeScript Zod [typescript-zod] ts. (27 languages, 26
renderer families; TypeScript and Flow share TypeScriptFlow.)

`languageNamed(name, list = all)` = first language whose `names` include `name`, else plain `Error("Unknown language
name: …")`; `isLanguageName`, `isLanguageDisplayName`. language/index.ts re-exports every language module plus
`defaultTargetLanguages`; options.types.ts / types.ts are type-level only (`RendererOptions<Lang>` = option-name →
accepted input type).

Messages.ts: `messageError(kind, props)` builds the message by `template.replace("${k}", str)` per property in key
order (first occurrence only; `$&`, `` $` ``, `$'`, `$$` in the value are interpreted by `String.replace`); objects
with `toString` → `toString()`, values with string `.message` → message, non-strings → `JSON.stringify` (undefined →
"undefined"). Throws `QuickTypeError(template, kind, userMessage, props)`. `messageAssert(cond, kind, props)`.

## 6. Proposed Rust design

Goal: each of the 26 renderers is a line-by-line port that touches only its own module, against a frozen framework
API whose names are the snake_case of the TypeScript ones.

**Source** (`source.rs`):
```rust
pub enum Source { Text(String), Newline(i32), Sequence(Vec<Source>), Table(Vec<Vec<Source>>),
  Annotated(AnnotationData, Box<Source>), Name(NameId), Modified(Rc<dyn Fn(&str) -> String>, Box<Source>) }
pub enum Item { Str(String), Name(NameId), Src(Source) }   // emitted items before conversion
```
`impl From<&str|String|NameId|Vec<Source>|Source> for Source` (strings split on `\n` exactly like
`sourcelikeToSource`), a `sl![a, b, c]` macro for sequences, `emit_line!(r, a, b, …)` for variadic emits (1 part →
item, ≥2 → one sequence item). `Item` keeps `emitLineOnce` equality exact: `Str` by value, `Name` by id, `Src` never
equal. Widths and columns use `utf16_len`.

**EmitContext**: `{ items: Vec<Item>, last_newline: Option<usize>, blank_needed: usize, prevent: bool }`. Newlines
pushed by `emit_newline` are always top-level items, so `change_indent` mutates `items[last_newline]` in place.
Finished contexts are moved into `IndexMap<String /*lowercase*/, EmitContext>`; a file snapshot is a clone.

**Naming** (`naming.rs`), arena-based:
```rust
pub struct NameId(u32); pub struct NamespaceId(u32);
pub struct Namer { id: u32, name: String, style: Rc<dyn Fn(&str) -> String>, prefixes: Vec<String>, case_insensitive: bool }
pub type NamerRef = Rc<Namer>;                       // identity = id (fresh per construction)
pub type Proposer = Rc<dyn Fn(&mut dyn FnMut(NameId) -> String) -> String>;
enum NameKind { Fixed(String), Simple(IndexSet<String>), Dependency { deps: IndexSet<NameId>, propose: Proposer } }
struct NameData { kind: NameKind, namer: Option<NamerRef>, order: u32 }
```
`DependencyName::new` runs the proposer once with a recording lookup returning `"0xDEADBEEF"`. Proposers must
capture only owned data: TS code that reads renderer state inside a `lookup` closure (e.g.
`nameForNamedType(classType)`) resolves those `NameId`s eagerly when building the proposer (the stores are fixed by
then, so this is equivalent). So the hook becomes `fn propose_union_member_name(&self, u, union_name, t) ->
Proposer`; CJSON/Elm/Haskell wrap the default proposer. TS module-level namers (Go `namingFunction`, …) become
per-renderer fields created once; TS code that calls `funPrefixNamer(...)` inside a hook must call `Namer::new`
there too (fresh id) — this is the identity rule from §2.3. All sets/maps are `IndexSet`/`IndexMap`.

**Renderer core + hook trait** (composition, no inheritance):
```rust
pub struct RendererCore<'a> { graph: &'a TypeGraph, leading_comments: Option<Vec<Comment>>, lang_name: &'static str,
  emit: EmitContext, finished_files: IndexMap<String, Source>, finished_ctx: IndexMap<String, EmitContext>,
  names: Option<NameMap> }
pub struct ConvenienceCore<'a> { base: RendererCore<'a>, arena: NamingArena,
  type_names: HashMap<TypeRef, NameId>, top_level_names: IndexMap<String, NameId>,
  property_names: HashMap<TypeRef, IndexMap<String, NameId>>, member_names: HashMap<TypeRef, IndexMap<TypeRef, NameId>>,
  case_names: HashMap<TypeRef, IndexMap<String, NameId>>, transformation_names: IndexMap<TypeRef, NameId>,
  namers…, namespaces…, other_forbidden: IndexMap<String, NamespaceId>, declaration_ir, named_types: Vec<TypeRef>,
  named_objects/enums/unions: IndexSet<TypeRef>, flags…, cycle_breakers: Option<HashSet<TypeRef>>, alphabetize: bool }

pub trait ConvenienceRenderer: Sized {
    fn core(&self) -> &ConvenienceCore<'_>;  fn core_mut(&mut self) -> &mut ConvenienceCore<'_>;
    // required (abstract in TS)
    fn make_named_type_namer(&mut self) -> NamerRef;
    fn namer_for_object_property(&mut self, o: TypeRef, p: &ClassProperty) -> Option<NamerRef>;
    fn make_union_member_namer(&mut self) -> Option<NamerRef>;
    fn make_enum_case_namer(&mut self) -> Option<NamerRef>;
    fn emit_source_structure(&mut self, given_output_filename: &str);
    // every overridable hook of §3.1, default body = call into `convenience::defaults::*`
    fn make_name_for_enum_case(&mut self, e: TypeRef, enum_name: NameId, case: &str, assigned: Option<&str>) -> NameId {
        defaults::make_name_for_enum_case(self, e, enum_name, case, assigned) }
    fn comment_line_start(&self) -> Cow<'static, str> { "// ".into() }
    …
}
```
- Every TS default body lives in a free generic fn (`defaults::x<R: ConvenienceRenderer>(r: &mut R, …)`), so
  `super.x(...)` becomes `defaults::x(self, ...)` (Go `makeNameForEnumCase`, CJSON/Elm/Haskell
  `proposeUnionMemberName`, JS `makeNameForProperty`).
- Non-overridable machinery (`set_up_naming`, `assign_names`, `process_graph`, `render`, blank-line logic,
  `for_each_*`, `emit_*`, `sourcelike_to_string`) is a blanket extension trait `impl<T: ConvenienceRenderer>
  ConvenienceRendererExt for T`. Closure helpers take the renderer explicitly: `self.indent(|r| …)`,
  `self.for_each_class_property(o, BlankLines::None, |r, name, json, p, pos| …)`; each helper first collects its
  (Copy) iteration list, then loops calling `f(self, …)`, so there are no borrow conflicts.
- Naming state lives in core maps instead of the TS attribute store (nothing else reads it).
- Mid-level TS base classes (JavaScriptRenderer → TypeScriptFlowBase → TypeScript/Flow; CSharp →
  NewtonSoft/SystemTextJson; Java → Jackson; Kotlin → Klaxon/Jackson/KotlinX; Scala3 → Circe/Upickle; Python →
  JSONPython) follow the same pattern one level down: a state struct (`JsState`), a trait `JavaScriptHooks:
  ConvenienceRenderer` with default methods delegating to `javascript::defaults::*`, and a `macro_rules!` that
  implements `ConvenienceRenderer` for each leaf by forwarding the hooks that the base overrides. Leaves hold `core
  + every ancestor state + own state + typed options`. Helper classes that call public emit methods
  (JavaDateTimeRenderer) take `&mut impl JavaHooks`.
- Typed options: one `options!` macro per language declares the TS option object in **key order** (name, kind,
  default, enum map → Rust enum/struct) and generates `OptionDef` metadata (for help and `optionDefinitions`) plus
  `fn parse(raw: &RawOptions) -> Result<Opts, QuickTypeError>` implementing §5 exactly. `RawOptions =
  IndexMap<String, RawValue>` (`Str | Bool | Json`).
- `TargetLanguage` trait (`config()`, `options()`, capability methods with the TS defaults, `default_indentation()`,
  `render(ctx, raw, filename, alphabetize, indentation) -> Result<MultiFileRenderResult>`); `static ALL: [&dyn
  TargetLanguage; 27]` in registry order. `dyn` only at this boundary; renderers are generic/concrete inside, so the
  closure helpers stay zero-cost.
- Parallel porting: land `source`, `renderer`, `naming`, `convenience_renderer`, `support::strings` and the hook
  trait with the full method list first (stubs allowed); then each language is a separate module with a fixed
  TS→Rust name mapping table and needs no framework edits. Unit-test the framework by porting the reference
  renderer-test cases above (blank lines, tables, emitMultiline, prefixes/suffixes) as golden strings.

## 7. JS-semantics hazards and npm dependencies

Hazards (file:line):
1. UTF-16 lengths/columns: Source.ts:156, 168, 202 (table padding), Renderer.ts:45; wordwrap widths;
   TypeNames.ts:69-91 prefix/suffix lengths.
2. `\n`-only splitting, `\r` survives: Source.ts:77, Renderer.ts:221.
3. Deferred/suppressed blank lines, indentation-only lines from `emitLine("")`, table trailing spaces:
   Renderer.ts:110-135, Source.ts:259 (§1.3).
4. `emitLineOnce` uses JS `===`: Renderer.ts:121. 5. Float tab arithmetic + assert: Renderer.ts:52, 229.
6. Duplicate-file warning printed to **stdout**: Renderer.ts:377. 7. Case-insensitive context reuse, `Map.set` keeps
   first position: Renderer.ts:364-390.
8. Shared prefix iterator/suffix counter, Set-deduped prefixes, case-insensitive check only in pass 1, identity
   grouping of namers, lazily cached `forbiddenNameds`, first-ready-namespace choice, dummy `"0xDEADBEEF"` lookups:
   Naming.ts:97, 107-117, 161-186, 520-528, 55-63, 480, 347-351.
9. collection-utils order: `iterableMinBy` (first strict minimum), `setGroupBy` (first appearance), `setUnion`
   (first operand first), `mapSortBy`/`setSortBy` (`Array.prototype.sort`: **stable**, `<`/`>` on strings = UTF-16
   code-unit order): ConvenienceRenderer.ts:753, 926, 988; GatherNames.ts:193, 350; Type/Type.ts:525, 540.
10. Keyword namespace cached per kind for all later objects: ConvenienceRenderer.ts:504-509.
11. Alternatives built from the combined *unstyled* name: ConvenienceRenderer.ts:543, 686.
12. `replace("-", "_")` replaces only the first hyphen: ConvenienceRenderer.ts:840.
13. JS `trim()` / regex `\s` (include U+FEFF, exclude U+0085) ≠ Rust `trim()` / `\s` (the reverse):
    ConvenienceRenderer.ts:104, 108; wordwrap. `trimEnd` instead uses Zs/Zl/Zp only: Strings.ts:301,
    ConvenienceRenderer.ts:1186. `if (lineEnd)` truthiness: :1189. Sequential replace-all: :1259.
14. `codePointAt` at a unit index, advancing one unit (low halves read as `Cs`): Strings.ts:383-391, 435.
15. Astral characters always dropped by `legalizeCharacters`: Strings.ts:157; unpaired high surrogate throws, lone
    low surrogate does not: Strings.ts:117.
16. First-unit case mapping, full mappings lengthen strings: Strings.ts:311, 503.
17. Unicode **12.0** categories with unassigned = `Cc` (never Rust's/Node's tables): Strings.ts:233, 266-278,
    361-368, plus language utils.
18. `startWithLetter` tests a unit, `combineWords` a code point: Strings.ts:345 vs 556; acronym lookup on
    `toLowerCase()`: Strings.ts:492.
19. `pluralize.singular` directly in GatherNames.ts:175, 186 vs cookie fix in TypeNames.ts:19; thresholds `>= 1000`
    (GatherNames.ts:135, 241; TypeNames.ts:108) vs `> 1000` (TypeNames.ts:113).
20. RNG draws in type-index order (GatherNames.ts:401, TypeNames.ts:34); MT19937 is the standard u32 generator
    (`random() = u32 / 2^32`, `pick = arr[floor(r * len)]`).
21. Option parsing truthiness, `in` with prototype keys, `Object.keys` order: RendererOptions/index.ts:106-127,
    181-186, 172. `String.replace` first occurrence and `$` patterns: Messages.ts:296.
22. JS strings can hold lone surrogates (JSON `"\ud800"`), Rust `String` cannot. The corpus inputs with surrogate
    escapes (`nst-test-suite.json`, `blns-object.json`, `6de06.json`) only use pairs, so `String` + UTF-16 helpers
    suffice for parity; a lone surrogate would need a WTF-16 type.
23. Case mapping: verified that Node 24.16 (ICU, Unicode 17) and Rust 1.99 (`char::UNICODE_VERSION` 17.0) agree on
    `str::to_uppercase`/`to_lowercase` for every code point; lowercase exactly the substrings the TS lowercases
    (final-sigma context).

npm dependencies to reproduce:
- **unicode-properties 1.4.1** (`node_modules/unicode-properties/dist/main.cjs`, trie from unicode-trie 2.0.0): only
  `getCategory` and the derived predicates above are used (Strings.ts, plus Python/Elixir/Ruby/C#/ObjC/Smithy4s
  utils). Port: dump `getCategory(cp)` for 0..=0x10FFFF with a node script in `xtask` into a generated range table
  (3,823 runs); include `Cs` for surrogates and `Cc` default.
- **pluralize 8.0.0** (`packages/quicktype-core/node_modules/pluralize/pluralize.js`): only `singular` is used.
  Algorithm: `token = word.toLowerCase()`; if token is an irregular singular (keep map) → `restoreCase(word,
  token)`; if token is an irregular plural → `restoreCase(word, single)`; if token is empty or uncountable (string
  list) → word; else scan singular rules **from last to first**, first regex that matches → `word.replace(re, fn)`
  (first match, `$n` from groups, missing group → ""), with `restoreCase(match, result)`. `restoreCase(w, t)`: w===t
  → t; w all lower → t lower; w all upper → t upper; `w[0]` upper → `t[0].toUpperCase() +
  t.substr(1).toLowerCase()`; else lower. Uncountable regexes (`/pok[eé]mon$/i`, `/[^aeiou]ese$/i`, `/deer$/i`,
  `/fish$/i`, `/measles$/i`, `/o[iu]s$/i`, `/pox$/i`, `/sheep$/i`) are appended as singular rules with `$0`, so they
  are tested first. Regexes use `/i` **without** the `u` flag: ASCII letters match case-insensitively but `ſ`/`K`
  (Kelvin) do not, `\b`/`\w` are ASCII (`[^\w]` in the `-ves` rule). Rust's `regex` with `(?i)` folds `ſ`→`s` and
  `K`→`k`, so hand-port each rule (or ASCII-lowercase the input before matching). Copy all 47 irregular pairs, 23
  singular rules, 94 uncountable words and 8 uncountable regexes verbatim. Verified samples: `data→datum`,
  `people→person`, `Statuses→Status`, `news→news`, `canvas→canva`, `axes→axe`, `QUERIES→QUERY`, `ids→id`,
  `URLs→URL`, `s→""`, `Ss→Ss`, `Pokémons→Pokémon`, `media→media`.
- **wordwrap 1.0.0** (`node_modules/wordwrap/index.js`), used as `wordwrap(90)` (start 0, stop 90, soft mode) by
  ConvenienceRenderer.ts:79 and the CLI help (src/index.ts:73). Algorithm: `chunks = text.split(/(\S+\s+)/)`
  (captured separators kept); `lines = [""]`; per non-empty chunk: replace `\t` with 4 spaces; if `utf16Len(last) +
  utf16Len(chunk) > 90`: strip `/\s+$/` from the last line, then push every `chunk.split("\n")` piece with `/^\s+/`
  stripped (so an oversized first chunk leaves an empty first line); elif the chunk contains `\n`: append its first
  piece to the last line and push the rest with leading whitespace stripped; else append. Join with `\n`. `\s`/`\S`
  are JS whitespace (same set as JS `trim`).
- **collection-utils 1.0.1**: semantics in hazard 13; also `arrayIntercalate`, `iterableMax` (`>`), `mapMap`,
  `mapFilter`, `mapFilterMap` (drops `undefined`), `mapMergeInto`, `setUnionInto`. Use `IndexMap`/`IndexSet` plus a
  stable sort with a UTF-16 comparator.
