# 01 — Type graph, attributes, rewrites and the core pipeline
Reference: `quicktype@c39af7d3`, paths relative to `packages/quicktype-core/src/` unless noted.
`cu:` = `node_modules/collection-utils/dist/index.js` (v1.0.1), whose semantics leak into output.

Corpus facts that shape priorities (from `tests/golden/*/case.json`): **9,970 / 10,132** runs pass
`--debug provenance` (so `checkProvenance = true`), **7,096** pass `--alphabetize-properties`
(every `--src-lang json` run), and **no** run changes an inference flag. So all of
`inferMaps, inferEnums, inferUuids, inferDateTimes, inferIntegerStrings, inferBooleanStrings,
combineClasses, ignoreJsonRefs` are `true` in the corpus (CLI maps `--no-X` to `X=false`,
`src/index.ts:393,1168`). Source languages: json 7,096, schema 2,874, graphql 162.
## 1. The pipeline (`Run.ts`)
- **Options** (`Run.ts:170-178`): for every key of `{...defaultOptions, ...defaultInferenceFlags}`
take `options[k] ?? default`. All inference flags default to `true` (`Inference.ts:88-97`).
Flag order (`Inference.ts:11-78`, `Object.getOwnPropertyNames`): inferMaps, inferEnums,
inferUuids(`uuid`), inferDateTimes(`date-time`), inferIntegerStrings(`integer-string`),
inferBooleanStrings(`bool-string`), combineClasses, ignoreJsonRefs.
- **stringTypeMapping** (`Run.ts:180-191`, a getter, rebuilt on each access): copy of
`targetLanguage.stringTypeMapping`; for each flag with a `stringType` whose flag is `false`,
`mapping.set(stringType, "string")`. Quirk: `inferDateTimes=false` only remaps `date-time`, not
`date`/`time`. Lookups default to `"string"` when absent (`Type/TypeBuilderUtils.ts:12-19`).
- **preRun** (`Run.ts:534-563`): `initTypeNames()` (reseeds the global `Chance(31415)` and clears
used random names). If `!inputData.needIR && lang is "schema"` and there is a single string schema
source → output `JSON.stringify(JSON.parse(s), undefined, 4).split("\n") + [""]` (passthrough;
reorders integer-like keys, reformats numbers). JSON Schema CLI sources set `needIR=true`
(`input/JSONSchemaInput.ts:1680`), so this is mostly for TS input.
- **makeGraphInputs** (`Run.ts:231-255`): `conflateNumbers = !lang.supportsUnionsWithBothNumberTypes`;
`new TypeBuilder(stringTypeMapping, canonicalOrder=alphabetizeProperties,
allPropertiesOptional, addProvenance=checkProvenance, inherits=false)`; graph serial **0**.
Then `inputData.addTypes(ctx, builder, inferMaps, inferEnums, fixedTopLevels)` (input area).
- **processGraph** (`Run.ts:291-526`), in order:

| # | Stage (timing name) | Gate | Call |
|---|---|---|---|
| 0 | `typeBuilder.finish()` | always | freeze initial graph |
| 1 | remove indirection intersections | `builder.didAddForwardingIntersection \|\| !ignoreJsonRefs` | remap (`TypeGraphUtils.ts:130`) |
| 2 | loop: resolve intersections / flatten unions | `needSchemaProcessing \|\| !ignoreJsonRefs` | see below |
| 3 | replace object type | always | `replaceObjectType(g, stm, conflate, lang.supportsFullObjectType)` |
| 4 | flatten unions (do-while until done) | always | `flattenUnions(g, stm, conflate, makeObjectTypes=false)` |
| 5 | combine classes (+ cleanup) | `combineClasses` | see below |
| 6 | infer maps (loop until graph unchanged) | `inferMaps` | `inferMaps(g, stm, conflateNumbers=true)` (literal `true`) |
| 7 | expand strings | always | `enumInference = needSchemaProcessing ? "all" : inferEnums ? "infer" : "none"` |
| 8 | flatten unions | always | asserts `done` (`Run.ts:442`) |
| 9 | flatten strings | `needSchemaProcessing` | |
| 10 | none to any | always (no-op if no `none`) | `TypeGraphUtils.ts:19` |
| 11 | optional to nullable | `!lang.supportsOptionalClassProperties` | `TypeGraphUtils.ts:51` |
| 12 | fixed point | always | `graph.rewriteFixedPoint(false, …)` |
| 13 | make transformations | always (no-op if nothing needs one) | `MakeTransformations.ts:449` |
| 14 | flatten unions | always | asserts `done` (`Run.ts:491`) |
| 15 | GC | always | `graph.garbageCollect(alphabetizeProperties)` = forced remap |
| 16 | gather names | always | `gatherNames(g, !needSchemaProcessing, …)` (other area) |

Stage 2 (`Run.ts:323-357`): `unionsDone=false; intersectionsDone=false; do { before=g;
if (!intersectionsDone) [g, intersectionsDone] = resolveIntersections(g);
if (!unionsDone) [g, unionsDone] = flattenUnions(g, conflate, makeObjectTypes=true);
if (g === before) assert(both done) } while (!intersectionsDone || !unionsDone)`. Once a flag is
`true` that pass is skipped in later iterations. `unionsDone` carries into stage 4.
Stage 5 (`Run.ts:380-405`): `c = combineClasses(ctx, g, alphabetize, conflateNumbers=true,
onlyWithSameProperties=false)`; if `c !== g` then `g = combineClasses(ctx, c, alphabetize,
false, true)` ("cleanup"); else `g = c`.
"Graph unchanged" in JS is reference identity: `graph.rewrite` returns `this` iff
`!force && replacementGroups.length === 0` (`Type/TypeGraph.ts:345`). Port as an explicit
`changed` flag = "groups non-empty".
- **How many graphs get built.** Each `rewrite` with non-empty groups builds one new graph
(serial = old+1) via `GraphRewriteBuilder`, **plus** an implicit `removeIndirectionIntersections`
remap (serial+1 again) whenever that builder created a forwarding intersection
(`TypeGraph.ts:372-380`). `remap` never adds forwarding intersections (asserted). GC is always one
forced remap. `rewriteFixedPoint` (`TypeGraph.ts:440-465`) has a bug: it rewrites **`this`** on every
iteration, so it builds `g1 = this.rewrite(force)`; if `|types(this)| == |types(g1)|` it returns
**`this`** (discarding g1), otherwise it builds `g2 = this.rewrite(force)` again, and returns `g1`.
`g2` is pure waste but can consume the global name RNG (see §3.2); replicate both rewrites.
A typical JSON run builds: [replace object type]? [flatten]? [combine ×≤2] [infer maps ×k]
[expand strings] [flatten]? [none→any]? [opt→nullable]? fixed-point ×1–2, [make transformations]?
[flatten]? GC. Every rewrite also runs the provenance check (§2.8) when `checkProvenance`.
## 2. The type model
### 2.1 Kinds (`Type/TransformedStringType.ts`)
`TypeKind` = primitive {`none any null bool integer double string`} ∪ transformed string kinds
{`date time date-time uuid uri integer-string bool-string`} (this exact order is
`transformedStringTypeKinds`, `:81`) ∪ {`array class map object enum union intersection`}.
`isPrimitiveStringTypeKind` = string or transformed; `isPrimitiveTypeKind` adds numbers,
none/any/null/bool. `targetTypeKindForTransformedStringTypeKind`: `integer-string→integer`,
`bool-string→bool`, others undefined. `uri` has `attributesProducer = uriInferenceAttributesProducer`.
`isNamedType` = kind ∈ {class, union, enum, object} (**not map**, `TypeUtils.ts:205`).
### 2.2 Type classes (`Type/Type.ts`) — every type holds `typeRef` + graph pointer
| class | kind | fields | `isNullable` | `getNonAttributeChildren()` order |
|---|---|---|---|---|
| PrimitiveType `:277` | any primitive | — | null/any/none | ∅ |
| ArrayType `:330` | array | `_itemsRef?` (set once) | false | {items} |
| ObjectType `:472` | object/map/class | `isFixed`, `_properties?: Map<string, ClassProperty>`, `_additionalPropertiesRef?` | false | property types **sorted by name** (`mapSortToArray`, `:540`), then additional; deduped as Set |
| ClassType `:691` | class | additional must be undefined | | |
| MapType `:702` | map | properties = empty Map iff values given; `isFixed=false` | | |
| EnumType `:732` | enum | `cases: ReadonlySet<string>` | false | ∅ |
| UnionType `:947` | union | `_memberRefs?: Set<TypeRef>` (non-empty, `IRNoEmptyUnions`) | has `null` member | members **stable-sorted by kind string** (`:865`) |
| IntersectionType `:920` | intersection | same | **panics** | same |

Constructor asserts: map ⇒ no properties & !fixed; class ⇒ no additional; object ⇒ fixed.
`getChildren()` (`:105`) = non-attribute children then, for each attribute in map order, `kind.children(v)`
(only `transformation` has children). `ClassProperty` = `{typeRef, isOptional}`; `equals` = same ref & flag,
`hashCode = (ref|0) + (isOptional ? 17 : 23)` (`:416`). `UnionType.isCanonical` (`:979`): >1 member,
distinct kinds, no union/intersection/none/any member, not both string+enum, ≤1 of {class,map,object}.
`stringTypeMembers` = members that are primitive-string kinds or enum. `findMember(kind)` = first by
member order. `setOperationCasesEqual(a, b, conflate, eq)` (`:774`): sizes equal and ∀ta∈a: `tb` = first
in b with same kind, `eq(ta,tb)` → ok; else if conflate and ta is integer/double and b has the other → ok.
### 2.3 TypeRef (`Type/TypeRef.ts`)
A JS number: `((graph.serial & 31) << 26) | index` (always a non-negative int32; serial wraps mod 32).
Max index 2^26−1. Equality compares the whole number; `assertTypeRefGraph` checks the serial.
Deref goes through `graph.typeAtIndex`, which during building delegates to the builder.
### 2.4 Identity, equality, hashing
`Type.equals` = same `typeRef`; `Type.hashCode = ref|0`. Dedup uses `identity`
(`TypeIdentity(kind, components)`, `:49`), `undefined` = unique (never deduped):
* identity attrs = `mapFilter(attrs, k.inIdentity)`; if any attr has `requiresUniqueIdentity(v)`
  (only `stringTypes` with `cases.size > 0`) → `undefined` (`:261-275`).
* primitive `[idAttrs]`; array `[idAttrs, itemsRef]`; class/map/object
  `[idAttrs, properties, additionalRef|undefined]` (fixed objects → `undefined`); map uses an
  empty properties Map; enum `[idAttrs, cases]`; union/intersection `[idAttrs, memberRefs]`.
* `TypeIdentity.equals`: same kind, then `areEqual` per component.
`cu:areEqual` (`cu:501`): `===`; else both have `.equals` → `a.equals(b)`; Set: same size and all
of a `has` in b (order-insensitive, SameValueZero); Map: same size and ∀[k,v]∈a `areEqual(v, b.get(k))`
(keys by identity — attribute kinds are singletons); Array: ordered element-wise. So **property
maps, member sets and case sets compare order-insensitively** → the first-registered type's order wins.
`cu:hashCodeOf` (`cu:544`): number → `x|0` (ToInt32: NaN/±Inf→0, truncation, mod 2^32);
string → `hashString` (Java-style over **UTF-16 code units**, wrapping i32: `h = h*31 + c`);
undefined 17, true 18, false 19, null 20; `.hashCode()` if present; Set → `17 + Σ hash(e)`
(**not** truncated); Map → `addHashCode(17+Σhash(k), 17+Σhash(v))`; Array → fold `addHashCode`
from 17. `addHashCode(acc,h) = (acc*31 + (h|0))|0` (acc*31 done in doubles; exact for realistic sizes,
so i64 arithmetic then `as i32` reproduces it). `TypeIdentity` hash = fold from 17 over
`hashString(kind)` then components. `TypeAttributeKind.hashCode = hashString(name)`.
`cu:EqualityMap` (`cu:459`): JS `Map<int32 hash, [k,v]>` with **linear probing** (`h+1`) on
collision, no delete; `set` on an equal key overwrites the value in place; `values()` = first-insertion
order. It is exact only when `equals` and `hashCode` agree — they disagree for
`StringMatchTransformer` (§8.7), so port `EqualityMap` and the hash functions **exactly** (cheap) rather
than using a Rust `HashMap` with derived `Eq` for type identities.
### 2.5 Structural compatibility (`Type.ts:166-228`, used only by CombineClasses/InferMaps)
`kindsCompatible`: equal, or (conflate and {integer,double}). `triviallyStructurallyCompatible`
(`TransformedStringType.ts:114`): same index, or either is `none`. Worklist is a LIFO array;
pairs are swapped so `a.index ≤ b.index`; for non-primitive `a`, a linear `done` list of `[ai,bi]`
makes cycles coinductively equal. `queue(x,y)` returns true if trivially compatible, sets
`failed=true` and returns false if kinds incompatible, else pushes. Per step: object = same property
count, each name present in other with same `isOptional`, queue property types, additional both
absent or queued; enum = `areEqual(cases)`; set ops = `setOperationCasesEqual(…, queue)`;
primitives true. After each step, `if (failed) return false` (even if the step returned true).
### 2.6 TypeBuilder (`Type/TypeBuilder.ts`)
State: `types: (Type|undefined)[]`, `typeAttributes: TypeAttributes[]`, `topLevels: Map`,
`_typeForIdentity: EqualityMap<TypeIdentity, TypeRef>`, `_addedForwardingIntersection`.
* `reserveTypeRef` (`:111`): push undefined; attributes = `{provenance: {index}}` if
  `_addProvenanceAttributes` (initial builder with `checkProvenance`) else empty.
* `addType(fwd, creator, attrs)` (`:167`): `tref = fwd ?? reserve()`; if attrs given,
  `typeAttributes[i] = combine("union", existing, attrs)` (existing keys first); create; `commitType`
  which filters attributes by `kind.appliesToTypeKind(t.kind)` (default: `kind !== "any"`, so an
  `any` type keeps only provenance/transformation) and calls `setLostTypeAttributes()` if anything
  was dropped.
* `getOrAddType(identityMaker, creator, attrs, fwd)` (`:298`): identity from **the passed attrs only**;
  if found: `result = forwardIfNecessary(fwd, found)` (creates an `IntersectionType{found}` at `fwd`
  and sets `_addedForwardingIntersection`), then `addAttributes(result, nonIdentity(attrs))` — note the
  attributes land on the forwarding intersection, later merged by the remap. Else `addType` and
  `registerTypeForIdentity` (EqualityMap `set`, overwriting).
* `addAttributes(tref, attrs)` (`:207`): asserts every identity attr is already present and `areEqual`;
  filters by kind if committed; merges only non-identity attrs with `combine("union", existing, new)`.
* Deduping getters (`getOrAddType`): `getPrimitiveType(kind, attrs?, fwd?)` (`:337`; transformed kinds
  first mapped through stringTypeMapping; if result is `string` → `getStringType(attrs, unrestricted)`;
  `stringTypes` arg is `undefined` only when the *requested* kind was `string`), `getStringType(attrs,
  st, fwd)` (`:363`; asserts exactly one of `st` / an existing stringTypes attr; appends
  `{stringTypes: st}`), `getEnumType`, `getMapType`, `getArrayType`, `getClassType`, `getUnionType`,
  `getIntersectionType`.
* Unique getters (`addType`, **never registered**): `getUniqueObjectType`, `getUniqueMapType(fwd)`
  (no attrs), `getUniqueArrayType`, `getUniqueClassType(attrs, isFixed, props?)`,
  `getUniqueUnionType`, `getUniqueIntersectionType`.
* Setters register the type's *current* identity afterwards (`registerType`): `setObjectProperties`,
  `setArrayItems`, `setSetOperationMembers`. So a unique class later completed with
  `setObjectProperties` **is** registered (overwriting any equal earlier entry); one created with
  properties up front is **not**.
* `modifyPropertiesIfNecessary` (`:520`): if `canonicalOrder` sort by key (`mapSortByKey`); if
  `_allPropertiesOptional` (initial builder only) make every property optional.
* `finish()` → `typeGraph.freeze(topLevels, types.map(defined), typeAttributes)`.
### 2.7 TypeGraph (`Type/TypeGraph.ts`)
`freeze` (`:188`) stores types/attributes; `topLevels: Map<string, Type>` in insertion order.
`TypeAttributeStore` (`:37`) is **mutable after freezing** (`set` = `new Map(a).set(k,v)`, used by
GatherNames `GatherNames.ts:99` and ConvenienceRenderer's assigned-name views).
`allTypesUnordered()` = `new Set(_types)` — i.e. **index order**, used by most passes to pick
replacement groups. `filterTypes(pred)` (`:233`): recursive pre-order DFS from top-levels (map
order) over `getChildren()`, collecting matches → `allNamedTypes`, `allNamedTypesSeparated()`
= `{objects: kind object|class, enums, unions}` preserving that DFS order (`TypeUtils.ts:215`).
`getParentsOfType` lazily builds parent sets by iterating types in index order. `makeGraph` builds
`Graph` over `_types` in index order (DeclarationIR uses this ⇒ **final indices are output-relevant**).
`printGraph` (debug only): `"${i}: ${kind}[ ${combinedName}] | children a,b | <stringify…>"`.
### 2.8 Provenance check (`TypeGraph.ts:274-314`)
When the graph has provenance (all corpus runs): after each `rewrite`/`remap`, unless the builder's
`lostTypeAttributes` is set, compare `|∪ provenance over all types|` old vs new; on mismatch
`messageError("IRTypeAttributesNotPropagated", {count, indexes})`. `lostTypeAttributes` is set by:
attribute filtering in `commitType`/`addAttributes`, `UnionAccumulator.addNone/addAny`,
`IntersectionAccumulator` (lost array/object attrs, additional-property conflicts),
`replaceObjectType` (`any` additional props), `makeTransformations` (single-member union),
`buildUnion` forwarding `typeProvider.lostTypeAttributes`. Provenance never reaches rendered output
(no `addToSchema`, not in identity); it only matters for this error, and for `attributes.size`
tests that only feed `lostTypeAttributes`.
### 2.9 Graph rewriting (`GraphRewriting.ts`)
`BaseGraphRewriteBuilder extends TypeBuilder` (`:340`) is constructed with
`canonicalOrder = alphabetizeProperties` of the *call* (only combineClasses and GC pass the user's
value; every other pass passes `false`), `allPropertiesOptional=false`, `addProvenance=false`.
`finish()` (`:454`) reconstitutes each original top-level **in top-level order**; new indices are
therefore allocated in reconstitution DFS order.
`reconstituteTypeRef(orig, attrs?, fwd?)` (`:402`): `lookupTypeRefs([orig], fwd)`; if found,
`addAttributes(found, attrs)`; else `forceReconstituteTypeRef`. `reconstituteTypeAttributes` maps
each attribute through `kind.reconstitute` (only `transformation` rebuilds refs).
- **TypeReconstituter** (`:40`): one-shot; `lookup(refs)` → `lookupTypeRefs([r], undefined,
replaceSet=false)` per ref (all-or-nothing); `reconstitute(r)` → full `reconstituteTypeRef`.
Holds `_makeClassUnique` = the builder's `canonicalOrder` (!): `getClassType` becomes
`getUniqueClassType(false, props)` — so with `--alphabetize-properties`, combineClasses and GC
never dedupe classes. `getUniqueMapType` is the only path that adds attributes *after* creation
(`registerAndAddAttributes`, which strips identity attrs and asserts none exist).
Per-kind `reconstitute(builder, canonicalOrder)`:
* Primitive → `getPrimitiveType(kind)` (re-mapped through the builder's string mapping).
* Array (`Type.ts:377`): if `lookup(items)` → `getArrayType(items)`, else `getUniqueArrayType()`
  then `setArrayItems(reconstitute(items))`.
* Object (`:569`): `sorted` = properties by name; order of the new map = sorted if `canonicalOrder`
  else original. If `lookupMap(sorted refs)` all found and (additional found or absent): object →
  `getObjectType` (unique), map → `getMapType(values)`, class → fixed ? `getUniqueClassType(true, p)`
  : `getClassType(p)`. Else create unique first (object/map/class(isFixed)), **then reconstitute
  property types in sorted-name order**, then additional, then `setObjectProperties`.
* Enum → `getEnumType(cases)`.
* Union/Intersection (`:880`): members stable-sorted by kind; if all found → `get*Type(members in
  canonical ? sorted : original order)`; else `getUnique*Type()` then reconstitute in sorted order and
  `setSetOperationMembers`.
- **GraphRewriteBuilder** (`:628`): `_setsToReplaceByMember: Map<index, Set<T>>` (built from groups in
order; asserts disjoint), `_reconstitutedUnions: EqualityMap<Set<TypeRef>, TypeRef>`,
`reconstitutedTypes: Map<origIndex, newRef>`.
`lookupTypeRefs(refs, fwd, replaceSet=true)` (`:802`): (1) if `reconstituted[refs[0]]` is defined,
`!== fwd`, and all refs map to it → `forwardIfNecessary(fwd, it)`; (2) if `_reconstitutedUnions`
has `Set(refs)` and `!== fwd` → forward; (3) if all refs belong to the same pending replacement set
and `replaceSet` → `replaceSet(set, fwd)`; else undefined.
`replaceSet` (`:680`): `withForwardingRef(fwd)` (reserves a ref **before** calling the replacer if
none given), maps every member index → that ref, removes them from the pending map, calls
`replacer(set, builder, ref)` (re-entrant!) and asserts it returns `ref`.
`forceReconstituteTypeRef` (`:724`): attributes = `attrs ? combine("union", attrs,
reconstituteAttrs(orig)) : reconstituteAttrs(orig)` — **computed before the type is created**, so
types referenced by a transformation get lower indices; then `orig.reconstitute(reconstituter)`;
the register callback records `reconstituted[origIndex] = ref` (asserts consistency).
`registerUnion(refs, ref)` (asserts not present).
- **GraphRemapBuilder** (`:471`, used by GC and removeIndirectionIntersections): `makeIdentity`
returns `undefined` (no dedupe at all); `_attributeSources: Map<target, [target, ...sources]>`
(built in map order); `getMapTarget(ref)` follows the map one step (asserts no chains).
`lookupTypeRefs` maps through `getMapTarget` and only checks `reconstitutedTypes`.
`forceReconstituteTypeRef` (`:550`): **reserves the new ref first** (`withForwardingRef(undefined)`),
records it, *then* computes attributes = `combine("union", attrs ?? ∅, reconstituteAttrs(orig attrs
or combine("union", attributeSources)))` and reconstitutes with that ref as forwarding ref. So in a
remap a type's index precedes its transformation's types (opposite of the rewrite builder).
Adding a forwarding intersection panics.
### 2.10 Helpers
`TypeUtils.ts`: `setOperationMembersRecursively(ops, combKind?)` (`:51`) — DFS through nested ops of
the *same kind*, collecting non-op leaves in first-seen order (for intersections `any` leaves are
dropped but their attrs combined); combines op attributes in visit order. `makeGroupsToFlatten(ops,
include?)` (`:100`) — key = recursive member set (EqualityMap, order-insensitive); new group seeds with
the single member if the member set has size 1; groups returned in first-key order, members in
insertion order. `removeNullFromUnion(t, sortBy=false)` (`:146`). `nullableFromUnion`,
`nonNullTypeCases`, `getNullAsOptional`, `directlyReachableSingleNamedType`, `matchTypeExhaustive`
(`:281`; order: primitive (string vs transformed), array, class, map, object, enum, union).
`TypeGraphUtils.ts`: `noneToAny` (asserts ≤1 `none`, replaces it by `getPrimitiveType("any",
combined attrs, fwd)`), `optionalToNullable` (per class with any optional property: rebuild
properties; optional & non-nullable `t` → `getUnionType(namesDefault(t.attrs, {name}, inferred),
members ∪ {null})` where members = reconstituted union members (in member order) then `null`
appended, else `{reconstitute(t), null}`; `null` primitive is created *before* the members;
class rebuilt with `getUniqueClassType(attrs, true, …)` if fixed else `getClassType`),
`removeIndirectionIntersections` (for each intersection in index order follow single-member
intersections to a non-intersection target; a cycle panics; then `remap`).
## 3. Type attributes
`TypeAttributes = ReadonlyMap<TypeAttributeKind, any>`; **insertion order is observable** (JSON Schema
renderer iterates it for `addToSchema`, `language/JSONSchema/JSONSchemaRenderer.ts:65`).
Base `TypeAttributeKind` defaults (`attributes/TypeAttributes.ts:12-116`): `appliesToTypeKind = kind
!== "any"`, `combine` **panics**, `intersect = combine`, `makeInferred` **panics**,
`increaseDistance = identity`, `addToSchema` no-op, `children = ∅`, `stringify = undefined`,
`inIdentity = false`, `requiresUniqueIdentity = false`, `reconstitute = identity`,
`setInAttributes = new Map(a).set(k,v)` (existing key keeps its slot), `modifyInAttributes` (undefined
→ delete), `setDefaultInAttributes`, `removeInAttributes`.
`combineTypeAttributes(kind, arr)` (`:135`): `mapTranspose` (kinds in first-seen order across the
array, values in array order); one value → used as-is (no combine call); else `combine`/`intersect`;
`undefined` results dropped. `makeTypeAttributesInferred` / `increaseTypeAttributesDistance` =
`mapFilterMap` with `makeInferred` / `increaseDistance`.

| kind (`name`) | file | applies | identity | combine (union) | intersect | makeInferred | other |
|---|---|---|---|---|---|---|---|
| names | TypeNames.ts:329 | ≠any | – | `arr[0].add(arr, 1)` | = | `tn.makeInferred()` | increaseDistance = makeInferred; stringify `toString` |
| description | Description.ts:30 | ≠any | – | set union | = | drop | addToSchema `description = join("\n")`; stringify first 5 UTF-16 units + "..." if >8, ", ..." if >1 |
| propertyDescriptions | Description.ts:72 | ≠any | – | `mapMergeWithInto(setUnion)` | = | drop | stringify `prop descs: N` |
| accessorNames | AccessorNames.ts:31 | ≠any | – | **panic** | panic | drop | `Map<string, string \| Map<lang,string>>` |
| enumValues | EnumValues.ts:18 | ≠any | – | **panic** | panic | drop | same shape |
| unionIdentifier | AccessorNames.ts:110 | ≠any | – | set union | = | `new Set()` | ids from global `nextUnionIdentifier` (never reset) |
| unionMemberNames | AccessorNames.ts:140 | ≠any | – | `mapMergeInto` (later wins) | = | **panic** | `Map<unionId, entry>` |
| minMax / minMaxLength / minMaxItems | Constraints.ts:33 | ≠any | **yes** | min of mins, max of maxes; any `undefined` side → `undefined` | max of mins / min of maxes; `undefined` adopts other | drop | `checkMinMaxConstraint`: min>max → `MiscInvalidMinMaxConstraint` error, both undef → drop; addToSchema only for integer,double / string / array; stringify `${min}-${max}` |
| pattern | Constraints.ts:216 | ≠any | **yes** | `arr.map(p => "(p)").join("\|")` | `undefined` (drop) | drop | addToSchema for string |
| defaultValue | DefaultValue.ts:13 | ≠any | **yes** | all `===` first ? first : drop | = | drop | addToSchema `default`; stringify `JSON.stringify` |
| stringTypes | StringTypes.ts:173 | ≠any | **yes** | `arr[0].union(arr,1)` | `arr[0].intersect(arr,1)` | drop | `requiresUniqueIdentity` iff `cases.size>0` |
| uriAttributes | URIAttributes.ts:25 | ≠any | **yes** | union both sets | = | drop | addToSchema for string/uri: `qt-uri-protocols`/`-extensions` = `Array.from(set).sort()` |
| provenance | Type/ProvenanceTypeAttributeKind.ts:9 | **all** | – | set union | = | identity | stringify numbers `.sort()` (lexicographic!) |
| transformation | Transformers.ts:1274 | **all** | **yes** | **panic** | panic | **panic** | `children`, `reconstitute`; stringify "transformation" |
| assignedName etc. | ConvenienceRenderer.ts:116-125 | ≠any | – | panic | panic | panic | renderer-only |

### 3.1 StringTypes (`attributes/StringTypes.ts`)
`{cases: Map<string, count> | undefined (unrestricted), transformations: Set<TransformedKind>}`
(unrestricted ⇒ no transformations). `union` (`:67`): unrestricted absorbs (returns that instance);
else merge counts by `+` (`mapMergeWithInto`, new keys appended) and union transformations.
`intersect` (`:85`): undefined cases adopt a copy of other's; else keys = `setIntersect(this, other)`
in **this** order, or, if empty, **all of this's keys**; value = `min(this, other ?? Infinity)`;
transformations intersected. `applyStringTypeMapping` (`:125`): unrestricted → itself; any
transformation mapping to `string` → `unrestricted`; else remapped set (cases kept).
`equals`: `areEqual(cases)` & `areEqual(transformations)`. `inferTransformedStringTypeKindForString`
(`:245`): empty or first UTF-16 unit ∉ `"0123456789-abcdefth"` → none; then date, time, date-time
(DateTime recognizer), integer-string (`/^(0|-?[1-9]\d*)$/` and `parseInt` within
[-2^31, 2^31−1]), bool-string, uuid (lowercase hex only), uri (`/^(https?|ftp):\/\/[^{}]+$/`).
### 3.2 TypeNames (`attributes/TypeNames.ts`)
`RegularTypeNames{names: Set, _alternativeNames?: Set, distance}`, `TooManyTypeNames{names={one},
distance}`. `makeWithDistance` (`:103`): `names.size >= 1000` → `new TooManyTypeNames(distance)` which
draws `makeRandomName()` = `"${chance.city()} ${chance.animal()}"` from the **global** Chance RNG,
retrying until unused; alternatives dropped if > 1000. `add(arr, start)` (`:163`): copy self; for each
other: first union its alternatives (even if farther); skip if farther; TooMany at ≤ distance →
delegate `other.add(arr, i+1)`; closer → replace names/distance/alts; equal → union names.
`TooMany.add`: given (distance 0) → self; else first strictly-closer other takes over.
`makeInferred` = distance+1 (TooMany keeps its name, no RNG); `singularize` maps names through
`pluralize.singular` (with a `/cookies$/i` special case) and distance+1; `clearInferred`.
`combinedName` = `combineNames(names)` (`:49`): 1 name → it; else map names to
`splitIntoWords(s).map(lower).join("_")` (set, dedups); 1 → it; else longest common prefix/suffix of
the first with all others **in UTF-16 units**, keep each only if length > 2, `prefix+suffix` if
length > 2 else first. `proposedNames` = {combinedName} ∪ alternatives.
## 4. Union building and unification
- **UnionAccumulator** (`UnionBuilder.ts:104`): two builders `Map<kind, attrs[]>` (non-string kinds,
string kinds); `addAttributesToBuilder` pushes on first sight even if empty, later only non-empty.
`addAny` / `addNone` set `lostTypeAttributes` (none adds nothing). `addFullStringType` adds a
`stringTypes` attribute (given, existing, or unrestricted). `addEnum` folds into `string` if a string
is present. `addStringCases`/`addStringCase` count into `_stringCases`.
`getMemberKinds` (`:285`): `strings = build(string builder)`; if cases counted, union a
`StringTypes(cases)` into `string`; `merged = mapMerge(build(nonString), strings)` (non-string kinds
first, in insertion order); empty → `{none: ∅}`; has `any` → `{any: combine(all values)}`;
conflate & integer & double → delete `integer`, union its attrs into `double` (keeps double's slot);
`map` → `class` (dead: nothing adds `map`).
- **attributesForTypes** (`:358`, used by `TypeRefUnionAccumulator.addTypes`): DFS through unions
from a `FauxUnion` root; for each leaf (first-seen order) attrs = combine(own, attrs of every ancestor
union whose leaf-set has size 1); returned union attrs = combine over every visited union of: `∅` if it
has exactly one leaf, own attrs if equivalent to the root (single root, chain of 1-member unions),
else `makeTypeAttributesInferred(own)`. Leaves are then added via `matchTypeExhaustive` (array → items
ref, class/map/object → `addObject(ref)`, enum → `addEnum(cases)`, union → panic).
- **UnionBuilder.buildUnion(provider, unique, attrs, fwd)** (`:559`): `kinds = getMemberKinds()`, then
propagate `lostTypeAttributes`. One kind → `makeTypeOfKind(kind, combine(attrs,
increaseDistance(memberAttrs)), fwd)`. Otherwise optionally `getUniqueUnionType(attrs, undefined, fwd)`
first, then build members in kind order with their attrs and no fwd, then `setSetOperationMembers`
or `getUnionType(attrs, members, fwd)`. `makeTypeOfKind`: string → `getStringType(attrs, undefined)`,
enum → `getEnumType(cases)`, object/array → abstract, other primitives → `getPrimitiveType`.
- **UnifyUnionBuilder** (`UnifyClasses.ts:119`, fields `makeObjectTypes`, `makeClassesFixed`,
`unifyTypes(refs)` callback). `makeObject(refs, attrs, fwd)`: `lookupTypeRefs(refs, fwd)` hit →
add attrs; one ref → `reconstituteTypeRef(ref, attrs, fwd)`; else if `!makeObjectTypes` and (some
non-`any` additional props, or no properties but some additional) → `getMapType(attrs,
unify(all property refs in order ∪ additional refs))`; else `getCliqueProperties` (`:25`): names =
union of property names in clique order; per member: missing ⇒ optional and add its non-`any`
additional type; present ⇒ add type, optional if optional; additional = unify(all additionals) **built
first**, then each property's type in name order; result `getUniqueObjectType(attrs, props, add, fwd)`
if `makeObjectTypes` else `getUniqueClassType(attrs, makeClassesFixed, props, fwd)`.
`makeArray(refs)` → `getArrayType(attrs, unify(item refs), fwd)`.
`unionBuilderForUnification(b, makeObj, fixed, conflate)` (`:242`): callback = `unifyTypes(set(refs),
∅, b, new unionBuilderForUnification(...), conflate)`.
- **unifyTypes(types, attrs, b, ub, conflate, fwd?)** (`:270`): `attrs = reconstituteTypeAttributes(attrs)`;
one non-union type → `reconstituteTypeRef(t, attrs, fwd)`; `lookupTypeRefs(refs, fwd)` hit → add attrs;
else accumulate (`TypeRefUnionAccumulator`), `attrs = combine(attrs, reconstitute(unionAttrs))`, then
`withForwardingRef(fwd, r => { registerUnion(refs, r); ub.buildUnion(acc, false, attrs, r) })`.
## 5. Rewrite passes
- **flattenUnions(g, stm, conflate, makeObjectTypes)** (`rewrites/FlattenUnions.ts`): candidates = unions
(index order) that are not `isCanonical`; groups = `makeGroupsToFlatten(…, include)` where `include`
rejects (and sets `foundIntersection`) member sets containing an intersection. Rewrite (canonical=false)
with `replace(types, b, fwd)`: record `unionKeyToRef[key(types)] = fwd` where key = sorted unique
indices of non-union leaves (numeric sort, joined by `,`); build a `UnifyUnionBuilder(b,
makeObjectTypes, makeClassesFixed=true, unifyTypeRefs)` and `unifyTypes(types, ∅, b, ub, conflate, fwd)`.
`unifyTypeRefs(refs)`: `lookupTypeRefs(refs, undefined, false)` hit → it; if any type contains an
intersection (through unions) → reconstitute each, 1 → it, else `needsRepeat=true` and
`getUnionType(∅, set)`; else key lookup in `unionKeyToRef` → reuse; else reserve a ref, store the key,
`unifyTypes(types, ∅, b, ub, conflate, ref)`. Returns `[g, !needsRepeat && !foundIntersection]`.
- **resolveIntersections** (`rewrites/ResolveIntersections.ts`): candidates = intersections (index order)
where `canResolve` (recursive members ≤1, or every union member canonical); groups via
`makeGroupsToFlatten(…, undefined)`. `replace`: members/attrs = `setOperationMembersRecursively(
intersections in group, "intersect")`; none → `getPrimitiveType("any", attrs, fwd)`; a `none` member →
reconstitute it; one member → reconstitute with attrs; else `IntersectionAccumulator.addType` per
member (returns `makeTypeAttributesInferred` of its attrs, intersected with the union's members'
attrs if a union), `attrs = combine("intersect", attrs, inferred(combine("intersect", those)))`,
`IntersectionUnionBuilder.buildUnion(acc, unique=true, attrs, fwd)`; `needsRepeat` if it made new
intersections. Accumulator per member set: primitive kinds = set intersection (if both had a number
kind and none survives, add `integer`); primitive attrs per kind merged with `intersect`
(`mapMapEntries` ⇒ last member of a kind wins within one set); arrays: **first array seen only creates
the empty item set, later arrays add their items** (so `allOf[int[], string[]]` → `string[]`, verified);
objects: properties merged as `GenericClassProperty<Set<Type>>` (both present → add type, optional =
both optional; existing + member's additional → add it; new → existing additional set + type),
additional types intersected or dropped (→ lost). `getMemberKinds`: primitive kinds in set order,
double attrs folded into integer if double vanished, then `array`, then `object`. `makeObject`/`makeArray`
build unique `IntersectionType`s of reconstituted members (or the single member) and
`getUniqueObjectType`/`getArrayType`. Returns `[g, !needsRepeat && all intersections resolvable]`.
- **replaceObjectType(g, …, leaveFullObjects)** (`rewrites/ReplaceObjectType.ts`): candidates = `object`
kinds in index order (if `leaveFullObjects`, only those with no properties or no additional).
No additional → `getUniqueClassType(attrs, true, reconstituted props, fwd)`; no properties →
`getMapType(attrs, reconstitute(additional), fwd)`; additional `any` → lost + fixed class; else
`union = lookupTypeRefs(property types ∪ {additional})` (replaceSet=**true**) or
`getUniqueUnionType(∅, reconstituted)`; `getMapType(attrs, union, fwd)`.
- **combineClasses(ctx, g, alphabetize, conflate, onlyWithSameProperties)** (`rewrites/CombineClasses.ts`):
candidates = `allNamedTypesSeparated().objects` (DFS order) filtered to non-fixed `ClassType`s.
Cliques: for each candidate, try cliques in current array order: `tryAddToClique` = any prototype
`structurallyCompatible(c)` (no conflate) → member; else any prototype `canBeCombined` → prototype +
member; new clique otherwise; **then swap that clique with `cliques[0]`** (move-to-front). Result:
cliques with >1 member, in final array order. `canBeCombined(p1, p2, same)`: sizes equal (same) or
each ≥ 3/4 of the other; larger = p1 if strictly larger else p2; `maxFaults = same ? 0 :
smaller.size − ceil(larger.size·3/4)`; count names of smaller missing in larger (break early);
common properties must have non-null cases (`nonNullTypeCases`) both empty or
`setOperationCasesEqual(…, conflate=true, structurallyCompatible(·,true))`. Rewrite with
canonicalOrder = alphabetize; replacer = `unifyTypes(clique, combine("union", clique attrs), b,
unionBuilderForUnification(b, false, false, conflate), conflate, fwd)`.
- **inferMaps(g, stm, conflate)** (`rewrites/InferMaps.ts`): candidates = non-fixed classes from
`allNamedTypesSeparated().objects` where `shouldBeMap(props)`: <2 props → no; all names
`/^[0-9]+$/` → yes (types = property types); <50 props all string-ish or null → no; <20 props →
`p = (Π markov(name))^(1/n)`, `limit = (n+2)^5/22^5 + (0.0025 − 3^5/22^5)`, `p > limit` → no; then all
non-null case sets must be pairwise `setOperationCasesEqual(…, conflate=true, structurallyCompatible(·,
true))` with the first; result = set of property types. Replacer: `getMapType(c.attrs,
unifyTypes(set, c.attrs, b, unionBuilderForUnification(b,false,false,conflate), conflate), fwd)` —
note the class attrs go to **both** the values type and the map.
- **expandStrings(ctx, g, inference)** (`rewrites/ExpandStrings.ts`): `allStrings` = `string` types
(index order) with restricted StringTypes. EnumInfo = mapped cases (skip unrestricted / empty; unless
"all": skip `[""]` and all-numeric `/^[-+]?[0-9]+(\.[0-9]+)?$/` case sets), `numValues` = Σ counts.
Phase 1 over infos in insertion order: "all" → push; else only `isOwnEnum` (numValues ≥ 10 and
`cases.size < sqrt(numValues)`): first `enumSets` index with overlap ≥ 3/4·min(sizes) → union into it,
else push; processed infos are deleted. Phase 2 (remaining, numValues ≥ 5): overlap ≥ 3/4·|new| →
union in. Replacer (group of one): attrs = original minus the stringTypes entry (`mapFilter` by
*value*); mapped unrestricted → `getStringType(attrs, unrestricted, fwd)`; cases non-empty → first enum
set that `areEqual` ("all") or is a superset → `getEnumType(∅, set)` else unrestricted string; no enum and
exactly one transformation → `getPrimitiveType(kind, attrs, fwd)`; else union(attrs, enum? +
`getPrimitiveType(k)` per transformation in set order).
- **flattenStrings** (`rewrites/FlattenStrings.ts`): unions from `allNamedTypesSeparated().unions` with
>1 string-ish member including `string` (asserted unrestricted): non-string members reconstituted in
member order; none left → `getStringType(combine(stringAttrs, u.attrs), undefined, fwd)`; else append
`getStringType(stringAttrs, undefined)` and `getUnionType(u.attrs, …, fwd)`.
- **makeTransformations(ctx, g, lang)** (`MakeTransformations.ts:449`): candidates (index order) =
`lang.needsTransformerForType(t)`, or unions with >1 string member where some member needs one.
Dispatch: union → `replaceUnion` (`:100`): reconstitute members in member order into
`Map<kind, ref>` (transformed kinds with a primitive target reuse the union's target-kind member or
`getPrimitiveType(target)`, accumulating their attrs as `additionalAttributes`); >1 distinct →
`getUnionType(u.attrs, set)` else lost + the single member; string transformer from string members
stable-sorted by kind (string with minMaxLength → `MinMaxLengthCheck`, enum in candidates →
enum `Choice` of `StringMatch(StringProducer)`, else `ParseString`; consumer =
`UnionInstantiation(memberRef)` only if a real union); `DecodingChoice(any, null, integer, double, bool,
string, array, class ?? map)`; result `getPrimitiveType("any", combine(transformationAttr,
additional), fwd)`. `replaceArray` → `array<any>` with `ArrayDecoding`; `replaceEnum` → string with
`Decoding(enum choice)` targeting `getEnumType(enum.attrs, cases)`; `replaceNumber` (minMax) /
`replaceString` (minMaxLength) / `replaceTransformedStringType` (`ParseString`, target =
`getPrimitiveType(target ?? kind, reconstitutedAttrs)`). The unrestricted string helper type is created
lazily, so creation order follows the code exactly — port line by line.
- **Transformers** (`Transformers.ts`): 14 classes, all `{kind, graph, sourceTypeRef}` plus: Producer
(`consumer?`): Decoding, ArrayDecoding(+itemTargetRef, itemTransformer), StringProducer(+result),
ParseString, Stringify, MinMaxLengthCheck(+min,max), MinMaxValue(+min,max); Match
(`transformer`): UnionMemberMatch(+memberRef), StringMatch(+stringCase); others: Encoding,
ArrayEncoding(+itemTargetRef, itemTransformer), Choice(transformers[]), DecodingChoice(7 optional
slots), UnionInstantiation. `reconstitute` evaluates arguments left→right (source first, then
consumer/children in constructor order) — this fixes new indices. `Transformation{targetRef,
transformer}`; `getChildren` = transformer children (source first, Set-union order) + target;
`reconstitute` = target first, then transformer (`:1244-1252`). `reverse`/`canFail`/
`getNumberOfNodes` matter to renderers; `DecodingChoice.reverse` groups by source kind (Map order)
then member-match by member type, keeps per group the smallest non-failing by a **stable** sort on
node count (`:641`).
## 6. Graph algorithms (`Graph.ts`, `DeclarationIR.ts`, `CycleBreaker.ts`)
`Graph(nodes, invert, edges)`: node order = given order; edges via child sets mapped to node indices.
Tarjan SCC (`:25`) iterates nodes 0..n and successors in order (recursive; deep graphs need an explicit
stack in Rust). `buildMetaSuccessors` dedups per component in first-seen order. `findRoots` = in-degree
0 in index order. `dfsTraversal` pre/post order. `declarationsForGraph` (`DeclarationIR.ts:97`): graph over
`typeGraph._types` (index order); per root component (`findRoots` order) DFS (`topDown` = no forward
declarations); per component: 1 needing decl → define it; 0 needing and size 1 → nothing; 0 → define
`iterableFirst(component)` (= Tarjan pop order, last-pushed first); no forward support → define all
needing; else forward all forward-declarable, recurse on the rest (`Graph(rest, invert=true, …)`), then
define the forwarded. `cycleBreakerTypesForGraph` (`:53`): queue = top-levels, **popped from the end**;
`path.unshift`. `breakCycles` (`CycleBreaker.ts`) is **dead code** (and buggy: `indexOf` vs `undefined`).
## 7. Proposed Rust design
- **Indices.** `#[derive(Copy, Clone, Eq, PartialEq, Hash)] struct TypeRef { serial: u8, index: u32 }`;
`js_value() = ((serial & 31) << 26 | index) as i32` (only for exact JS hashes). Keep the serial so
`debug_assert!` catches cross-graph mixing (the #1 porting bug). Serial: initial 0, rewrite/remap = src+1.
- **Types: a closed enum, not trait objects** (kinds are fixed; JS dispatches with `instanceof`):
```rust
enum TypeKind { None, Any, Null, Bool, Integer, Double, String, Date, Time, DateTime, Uuid, Uri,
  IntegerString, BoolString, Array, Class, Map, Object, Enum, Union, Intersection } // + as_str()
enum TypeData { Primitive(TypeKind), Array { items: Option<TypeRef> },
  Object { kind: ObjectKind /*Object|Map|Class*/, is_fixed: bool,
           properties: Option<IndexMap<JsString, ClassProperty>>, additional: Option<TypeRef> },
  Enum { cases: IndexSet<JsString> }, Union { members: Option<IndexSet<TypeRef>> },
  Intersection { members: Option<IndexSet<TypeRef>> } }
struct ClassProperty { type_ref: TypeRef, is_optional: bool }
```
`instanceof ObjectType` = any `Object{..}`; `ClassType`/`MapType` = that `ObjectKind`. Free functions
taking `&TypeGraph` replace the `t.graph` back-pointer (`children`, `identity`, `structurally_compatible`).
- **Graph.** `TypeGraph { serial, types: Vec<TypeData>, attrs: Vec<TypeAttributes>, top_levels:
IndexMap<String, TypeRef>, have_provenance, parents: OnceCell<Vec<IndexSet<TypeRef>>> }`. Post-freeze
mutation: give GatherNames `&mut TypeGraph` (runs before rendering) and keep renderer-assigned names
in renderer-owned `HashMap<TypeRef, Name>` side tables (those kinds never flow back and have no
`addToSchema`) — then the graph needs no `RefCell`.
- **Builder.** One struct with a mode enum instead of the 3-level class hierarchy:
```rust
struct TypeBuilder<'g> { stm, canonical_order: bool, all_optional: bool, add_provenance: bool,
  serial: u8, types: Vec<Option<TypeData>>, attrs: Vec<TypeAttributes>, top_levels: IndexMap<..>,
  identity: EqualityMap<TypeIdentity, TypeRef>, added_fwd_intersection: bool, lost_attrs: bool,
  rw: Option<RewriteCtx<'g>> }   // RewriteCtx { original: &'g TypeGraph, reconstituted, mode }
enum Mode { Rewrite { sets_by_member: HashMap<u32, Rc<[TypeRef]>>,
                      unions: EqualityMap<SetKey, TypeRef>, replacer: Rc<dyn Replacer> },
            Remap { map: IndexMap<TypeRef, TypeRef>, attribute_sources: IndexMap<TypeRef, Vec<TypeRef>> } }
trait Replacer { fn replace(&self, group: &[TypeRef], b: &mut TypeBuilder<'_>, fwd: TypeRef) -> Result<TypeRef>; }
```
The replacer is **re-entrant** (replace → unify → reconstitute → lookup → replaceSet → replace): store
`Rc<dyn Replacer>`, clone the `Rc` before calling, keep pass state (`needsRepeat`, `unionKeyToRef`,
`foundIntersection`) in `Cell`/`RefCell` inside it. `UnionBuilder` = trait whose methods take
`&mut TypeBuilder`; model the `unifyTypes` callback as an enum (`Unify{make_obj, fixed, conflate}` |
`Flatten(Rc<FlattenState>)`) instead of self-referential closures. `TypeReconstituter` = struct
borrowing `&mut TypeBuilder` + `{make_class_unique, attrs, fwd, original_index, result}`; registration
is a builder method branching on mode. Every `panic`/`assert`/`messageError` → `Result<_, QuickTypeError>`
(the workspace sets `panic = "abort"` in release, so Rust panics can't reproduce CLI error output).
- **Attributes.** `enum AttrKind { Names, Description, PropertyDescriptions, AccessorNames, EnumValues,
UnionIdentifier, UnionMemberNames, MinMax, MinMaxLength, MinMaxItems, Pattern, DefaultValue,
StringTypes, UriAttributes, Provenance, Transformation }` with per-kind `match`es for
combine/intersect/make_inferred/increase_distance/applies_to/in_identity; `enum AttrValue` per kind
(`Rc<Transformation>`, `Rc<TypeNames>`, JS numbers as `f64`, counts `u64`, `DefaultValue::{Bool,
Number(f64), String, Null}`). `TypeAttributes(IndexMap<AttrKind, AttrValue>)` with JS-Map semantics:
insert keeps an existing slot; delete = **`shift_remove`** (never `swap_remove`/deprecated `remove`).
- **Collections.** JS `Map`/`Set` → `IndexMap`/`IndexSet`; `Set<Type>`/`Map<Type,_>` keyed by `TypeRef`.
A `js` module with exact ports of the collection-utils functions (§8.2), `hash_code_of` (i64 sums,
`as i32`), `EqualityMap` (`IndexMap<i32, (K, V)>` + linear probing), `js_cmp_str` (UTF-16 units),
`to_int32`. `HashMap`/`HashSet` only for pure membership. Property names/cases need UTF-16-aware
compare/slice (`JsString` newtype or helpers).
## 8. JS-semantics hazards (file:line)
### 8.1 Insertion order (Map/Set) — reaches output through index allocation and attribute order
* Attribute map order: `TypeAttributes.ts:75` (`set` keeps slot), `:86` (delete), `:152` (`mapTranspose`
  first-seen kinds), `TypeBuilder.ts:180` (existing first), `:377` (stringTypes appended),
  `GraphRewriting.ts:743` (passed attrs before original), `:587-599` (remap). Visible in JSON Schema output.
* Union member order = kind order from `getMemberKinds` (`UnionBuilder.ts:304` non-string kinds then
  string kinds; `:335` `integer` deleted, `double` keeps slot) and leaf order from `attributesForTypes`.
* Identity dedupe keeps the **first** registered type's property/case/member order (order-insensitive
  `areEqual`, `cu:512-530`); re-registration overwrites (`TypeBuilder.ts:291`, `cu:463`).
* `allTypesUnordered` is index order (`TypeGraph.ts:472`) and drives group order in most passes;
  `filterTypes` DFS order (`TypeGraph.ts:239`) drives combineClasses/inferMaps/flattenStrings.
* Clique move-to-front swap (`CombineClasses.ts:160-162`) changes clique order and thus try order.
* Reconstitution order allocates indices: object children in sorted-name order (`Type.ts:635`),
  set members sorted by kind (`Type.ts:885`), transformation refs before (rewrite) or after (remap)
  the owning type (`GraphRewriting.ts:741` vs `:568`), argument evaluation order in
  `Transformers.ts` `reconstitute` methods and `MakeTransformations.ts` (e.g. `:258` `any` built before
  the transformation). Final GC indices feed `DeclarationIR` (C/C++/… declaration order).
* `optionalToNullable`: `setMap(...).add(null)` (`TypeGraphUtils.ts:70`) appends `null` last.
### 8.2 collection-utils semantics (port exactly)
`setUnion/setUnionInto/setUnionManyInto` (`cu:369-405`): result starts with dest's order, appends new
elements in source order. `setIntersect(a,b)` keeps **a**'s order; `setSubtract` keeps src order;
`setFilter/setMap/mapFilter/mapMap/mapFilterMap` preserve order (setMap dedups mapped values,
first wins). `mapMerge(a,b)`: a's order, b's new keys appended, b's values override in place;
`mapMergeWithInto(a, f, b)` same with `f(va, vb, k)`. `mapTranspose` first-seen keys. `mapSortByKey`/
`mapSortToArray`/`setSortBy`/`arraySortByInto` (`cu:177-187`): `Array.prototype.sort` (stable) with
comparator `<`/`>` → strings by UTF-16 units, numbers numerically. `iterableFirst` = first inserted;
`mapFirst` = first value. `iterableMinBy` (strict `<`, first wins). `areEqual`/`hashCodeOf`/
`EqualityMap` per §2.4. `mapFromObject` uses `Object.getOwnPropertyNames` (see 8.3).
### 8.3 Integer-like object keys
`mapFromObject` on parsed JSON objects reorders array-index keys first, ascending:
`Description.ts:139` (`schema.properties` → propertyDescriptions), `AccessorNames.ts:238,244`
(`qt-accessors`, also used by `EnumValues.ts:56`). These maps are lookups today, but their order is
visible if ever iterated. `Run.ts:547` schema passthrough `JSON.parse`/`stringify` reorders too.
Static objects (`TransformedStringType.ts:52,82`, `Inference.ts:80`) have no numeric keys.
### 8.4 Sorting
`Type.ts:525,540` and `TypeBuilder.ts:528` sort property names by UTF-16 units — **the 27
`blns-object.json` golden cases have astral and U+E000–U+FFFF keys**, so Rust `str` ordering breaks
them. `Type.ts:865`, `MakeTransformations.ts:222` sort by kind string (ASCII; stability matters for
equal kinds). `Transformers.ts:641` stable numeric sort. `URIAttributes.ts:56,60` default `sort()`
(UTF-16) → JSON Schema output. `ProvenanceTypeAttributeKind.ts:28` default `sort()` on numbers =
lexicographic (debug only). `FlattenUnions.ts:58` numeric (key only).
### 8.5 Strings (UTF-16)
`cu:13-21` `hashString` over UTF-16 units; `TypeNames.ts:69-91` common prefix/suffix by UTF-16
units — can split a surrogate pair into a lone surrogate (Node writes it as U+FFFD, so
`from_utf16_lossy` at the end matches unless later code inspects it); `Description.ts:56-57`
`slice(0,5)` (debug); `StringTypes.ts:249` `s[0]`; MarkovChain `word.length` (via InferMaps).
`TypeNames.ts:19` `/cookies$/i`.
### 8.6 Numbers
`InferMaps.ts:63-83`: `product ** (1/n)` and `MarkovChain.ts:324` — V8 `Math.pow` is the
fdlibm-derived `ieee754::pow`; use the `libm` crate's `pow` (FreeBSD `e_pow.c` port) and verify on a
sweep rather than `f64::powf` (platform libm). `ExpandStrings.ts:36` `Math.sqrt` (exact in both).
`CombineClasses.ts:49-70` `size * 0.75`, `Math.ceil` (exact). `Constraints.ts:54-84` `Math.min/max`
(note NaN/−0 propagate as in JS; use explicit JS-compatible min/max). `StringTypes.ts:111`
`Math.min()` = `Infinity` (never stored). `StringTypes.ts:211-220` 32-bit integer-string bounds via
`parseInt` (arbitrary length → float). `hashCodeOf` ToInt32 of floats. Number→string only in debug
stringifiers (`Constraints.ts:113`, `DefaultValue.ts:40`) and in renderers (JSON Schema `minimum`, …).
### 8.7 Hash/equality quirks that can change dedupe
`StringMatchTransformer.equals` is inverted (`Transformers.ts:860`, `!==`), while its hash includes the
case (`:865`): equal-by-`equals` transformers almost never share a hash, so `EqualityMap` lookups of
identities containing them fail except on probe collisions. `StringProducerTransformer.hashCode`
adds the consumer hash twice (`:981`). Identity hashes include the graph serial via TypeRef values.
Port EqualityMap + hashes bit-exactly; then collisions behave identically.
### 8.8 Global/hidden state and known bugs to preserve
* `rewriteFixedPoint` rewrites `this` (`TypeGraph.ts:447`) — two identical rewrites when the size changes.
* Chance RNG (`TypeNames.ts:24-41`) consumed whenever a TypeNames reaches ≥1000 names
  (`TypeNames.ts:108`), including in the discarded fixed-point rewrite.
* `nextUnionIdentifier` (`AccessorNames.ts:130`) is module-global and never reset (matters for the JS
  API running several conversions in one process; harmless for one CLI run).
* `markovChain` lazy singleton (`InferMaps.ts:22`); `noStringTypeMapping` cache.
* `IntersectionAccumulator.updateArrayItemTypes` drops the first array's items (`ResolveIntersections.ts:155-159`).
* `TypeReconstituter._makeClassUnique = canonicalOrder` (`GraphRewriting.ts:606,752`).
* `accessorNames`/`enumValues`/`transformation` combine panics; `unionMemberNames`/`transformation`
  makeInferred panics; `IntersectionType.isNullable` panics.
* Dead code: `breakCycles`, `Type.getAncestorsNotInSet` (console.log), `UnionAccumulator` `map→class`.
## 9. Suggested porting order (TS line counts; ≈11,400 total)
1. `js` helpers (collection-utils subset, hashes, `EqualityMap`, UTF-16 compare, ToInt32, JS min/max,
   `libm::pow`; ~250 Rust lines, unit-tested against node).
2. `ty/transformed_string_type` 118, `ty/type_builder_utils` 37, `ty/type_ref` 71, `inference` 97.
3. `attributes/type_attributes` 179, `type_names` 388 (needs `support/chance`, `splitIntoWords`),
   `string_types` 275, `constraints` 267, `description` 164, `accessor_names` 283, `enum_values` 59,
   `default_value` 87, `uri_attributes` 120, `ty/provenance_type_attribute_kind` 35.
4. `ty/ty` 1009 → 5. `ty/type_builder` 648, `ty/type_graph` 526, `ty/type_utils` 393 (milestone: JSON
   input builds a graph; diff `--debug print-graph` dumps against node — cheap, high-value oracle).
6. `graph_rewriting` 856 + `ty/type_graph_utils` 165 (milestone: GC/fixed-point dumps match).
7. `union_builder` 623, `unify_classes` 328. 8. Rewrites: `flatten_unions` 187, `replace_object_type`
   121, `combine_classes` 207, `infer_maps` 191 (+`markov_chain`), `expand_strings` 238,
   `flatten_strings` 81, `resolve_intersections` 540 (schema only).
9. `transformers` 1321 + `make_transformations` 538. 10. `run` 687 (+ provenance check), `graph` 301,
   `declaration_ir` 225; skip `cycle_breaker` 113 (dead).

