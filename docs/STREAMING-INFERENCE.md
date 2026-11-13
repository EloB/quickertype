# Inference from running tallies

JSON type inference no longer needs a copy of the whole input. The CLI
and the Rust API count what inference needs while the reader streams
through a sample (`input/tallies.rs`), and infer the types from those
counts (`input/tally_inference.rs`). Memory then grows with the number of
distinct places, keys and strings in the samples, not with their size;
see [BENCHMARKS.md](BENCHMARKS.md#streaming-inference-phase-8a) for the numbers.

quicktype's decision logic is unchanged: the same `UnionAccumulator`,
`UnionBuilder`, class/map/`$ref` decisions, `TypeBuilder` calls and every
rewrite after inference (`ExpandStrings`, `InferMaps`, ...). Only the lists
of values those decisions read are replaced by tallies, and this page
argues, one tally operation at a time, that every decision sees exactly
what it sees in TypeScript. The argument is backed by a differential
harness (last section) that runs both paths on generated inputs.

The path that infers from `CompressedJSON` (`input/compressed_json.rs`,
`input/inference.rs`) stays as it was. It is the reference the tallies are
tested against, and the path of `JsonInput::from_compressed`, the tables
the WebAssembly engine receives from the npm facade.

## What TypeScript computes

`Inference.ts` reads values from a `CompressedJSON` and builds lists of
them:

- `inferTopLevelType` adds a top-level's samples, in the order they were
  added, to one `UnionAccumulator` (`accumulatorForArray`).
- `addValuesToAccumulator` adds each value: `addPrimitive` for `null`,
  booleans, integers and doubles; `addStringCase(s, 1)` for an interned
  string with enum inference, `addStringType("string")` without;
  `addStringType("string", producer(s), {uri})` for a URI,
  `addStringType("string", ∅, {kind})` for another transformed string,
  `addStringType("string")` for a string too long to intern; `addObject`
  and `addArray` with the object's or array's values.
- `buildUnion` reads the accumulator's `getMemberKinds()` and, for the
  `object` and `array` members, its `objectData` and `arrayData`.
- `inferClassType(objects)` walks the objects' entries in order and
  collects `propertyNames` (each key at its first occurrence) and
  `propertyValues[key]` (every value of the key). Then: the `$ref` case
  (exactly one property name, `$ref`, all values interned strings); the map
  case (`inferMaps` and more than 500 property names: all values, grouped
  by key in key order, into one accumulator); otherwise a class whose
  property `key` has the type of `propertyValues[key]` and is optional iff
  `propertyValues[key].length < objects.length`.
- `makeArray(arrays)` infers the items from all elements of all arrays, in
  order.

Everything the TypeBuilder receives is a function of these lists. So it
suffices to show that, for each list, the accumulator ends in the same
state and `inferClassType` collects the same names, counts and value
lists.

## Places

A *place* is a path from a top-level: keys, and "element of an array".
Every value of a sample is at exactly one place. A tally keeps one
[`Node`](../crates/quicktype-core/src/input/tallies.rs) per place, holding
what the operations below record about all the values at that place.

**Every list TypeScript builds, except the map case's, is the list of all
values at one place, in document order** (with "document order" across
samples meaning the order the samples were added). By induction on the
path: a top-level's samples are the values at the root, in the order
added. If the values at place `p` are in document order, so are their
objects, and `propertyValues[k]` concatenates, object by object and entry
by entry, the values of key `k`, which are exactly the values at `p.k` in
document order; likewise the elements of `p`'s arrays are the values at
`p[]` in document order. (Values at one place never overlap in the text,
so it does not matter whether a value is recorded where it starts or
where it ends; the tallies record a container where it starts.)

The map case concatenates the lists of several places (`p.k1`, `p.k2`,
... in key order), and lists in the union builder can concatenate places
too (below). A tally therefore answers "what does the accumulator hold
after this list" for a list that is a *sequence of places*, each place's
values in document order.

## The tally operations

Each section names a field of the tallies, the operation that maintains
it, and why it equals what TypeScript computes from the full list.

### Non-string kinds: first-seen order

`Node::kinds` (`KindOrder`) records `null`, `bool`, `integer`, `double`,
`object` and `array` in the order they first occur at the place.

The accumulator keeps the non-string kinds in `_nonStringTypeAttributes`,
a `Map` from kind to attribute list. Inference always adds empty
attributes, and `addAttributesToBuilder` stores a kind's first attributes
and skips later empty ones, so the map is exactly: each kind that occurs,
in first-occurrence order, with `[∅]`. Adding a place's kinds once each,
in its first-seen order, produces the same map; for a sequence of places,
adding each place's kinds in turn gives the first-seen order of the
concatenation, because a kind already present keeps its slot.

`getMemberKinds` merges these with the string kinds (which always come
after them, whatever the order of occurrence), conflates `integer` into
`double` if both occur, and turns no members into `none`; all of that
depends only on this map. The kinds' attributes stay empty, and
`lostTypeAttributes` and `enumCases` are untouched by inference.

### Interned strings: cases and counts

`StringTally::cases` maps each interned string (`Tag.InternedString`: at
most 64 UTF-16 code units and no transformed kind, or any string under a
`$ref` key when references are handled) to its number of occurrences, in
first-seen order. The strings are classified by the same code as
`CompressedJSON.commitString`.

With enum inference, each such value is `addStringCase(s, 1, ∅)`:
`_stringCases.set(s, (get(s) ?? 0) + 1)`, a map in first-seen order with
counts. Replaying a place as `addStringCase(s, count, ∅)` for each case in
order yields the same map: same keys, same order, same sums. For a
sequence of places the counts add up and new cases are appended, as in
the concatenated list. The `∅` attributes these calls add to `string` are
skipped after the first (see the next section). Without enum inference
the cases are not replayed at all; those values are counted in the
second attribute combination below.

The cases are kept even without enum inference, because the flag is
only known when the types are added, after the samples were read; the
`$ref` case needs them too.

### Other strings: combined attributes

Every other string value adds attributes to the accumulator's `string`
kind: `addFullStringType` appends the value's own attributes (∅, or the
URI attributes of `uriInferenceAttributesProducer(s)`), then the
`stringTypes` attribute: `unrestricted` for an uninterned string,
`{cases: ∅, transformations: {kind}}` for a transformed one.
`getMemberKinds` combines the list with `combineTypeAttributes("union",
list)` and then, if there are cases, combines the result with
`StringTypes(cases)`.

`StringTally::with_enums` is that combination, maintained while reading:
`combine_into` combines each new non-empty attribute set into the running
result with the same `combine_type_attributes2`. This equals combining
the whole list at once:

- Empty attribute sets contribute nothing to `combineTypeAttributes`
  (`mapTranspose` sees no entries), so dropping them changes nothing.
- `combineTypeAttributes` groups the values by attribute kind, kinds in
  first-occurrence order, and combines each group with the kind's
  `combine`. Combining incrementally keeps the kinds in first-occurrence
  order (an existing kind keeps its slot, a new one is appended).
- `StringTypes.union` is associative: the result is unrestricted iff any
  element is, and otherwise has the cases added up (always ∅ here) and
  the transformations united in first-occurrence order.
  `URIAttributes.combine` unites protocols and extensions in
  first-occurrence order, also associative.
- `combineTypeAttributes` returns a group of one value as it is, and a
  group of several as a new combined value; incrementally, a value
  combined with nothing new is equal to the combination. The results are
  equal values (identity is never observed: types are compared by
  value).

Two shortcuts skip a combination that cannot change the result
(`add_unrestricted`, `add_transformation`, `add_produced`): adding
`unrestricted` to string types that are unrestricted already, adding a
transformation the string types already allow (or that unrestricted
types absorb), and adding URI attributes whose protocol and extension are
already in the combined sets. In each case the union returns the same
value with the same key order, so skipping it is exact; it makes the work
per string value a lookup instead of a set merge.

`StringTally::without_enums` is the same combination as it is without
enum inference, where every interned string also adds `unrestricted`.
Both are kept because the flag is only known later.

On replay, `add_values_to_accumulator` calls
`addStringType("string", combined, undefined)`: `addFullStringType` finds
the `stringTypes` in the combined attributes and appends just them, so
the accumulator's `string` list is `[∅?, combined₁, combined₂, ...]` for
a sequence of places, whose combination is the combination of the
concatenated lists by the same associativity. Cases are replayed with
`addStringCase`, so `getMemberKinds` adds `StringTypes(cases)` exactly as
before. (`combined` always contains `stringTypes`: every value that adds
URI attributes adds string types after them.)

### Objects: count, keys, occurrences

`ObjectTally` has `count` (the number of objects at the place), `keys`
(each key other than `__proto__` in first-seen order, with its number of
occurrences and the node of its values) and the `__proto__` fields of the
next section.

`inferClassType` reads, from the list of objects: `objects.length`
(`count`), `propertyNames` (the keys in first-occurrence order: `keys`'
order), and `propertyValues[key]` (the values at the place `p.key`, by
the induction above; its length is the number of occurrences, `count` of
the key). A key repeated within one object (the CLI's stream-json reader
keeps duplicates) occurs, and is counted, each time, so
`values.length < objects.length` is decided on the same numbers, quirk
included.

For a sequence of object places (objects added by several places to one
accumulator), `infer_class_type` walks the places in order: the counts
add up, a key is listed when it first occurs in any of them, and its
values are the sequence of its nodes in those places, which is
`propertyValues[key]` of the concatenated objects.

### `__proto__`

TypeScript collects `propertyValues` in a plain object, where
`"__proto__"` is never an own property: `hasOwnProperty` is false at every
occurrence, so the key is pushed to `propertyNames` again each time, and
`propertyValues["__proto__"] = []` replaces the object's prototype, so
the list holds only the last value. (`CompressedJSON`'s string index has
the same quirk, which only makes the key's string index differ.)

`ObjectTally::proto_runs` records each occurrence's position in
`propertyNames` as "after this many keys", run-length encoded, and
`proto` is the node of the last value only: a new occurrence starts a
fresh node and frees the old one. `property_names()` interleaves the runs
with the keys, which is `propertyNames` exactly. The class case calls
`inferType` once per occurrence on the last value, and is optional iff
`1 < objects.length`, as in TypeScript; the map case adds the last value
once per occurrence; both `propertyNames.length > 500` and the `$ref`
check count every occurrence.

### Arrays

`Node::items` is the node of the place `p[]`: all elements of all arrays
at `p`, in document order, which is what `makeArray` infers the items
from. Empty arrays add the `array` kind and nothing to the items, so an
items node without values infers `none`, as an empty list does. A
sequence of array places is a sequence of items nodes.

### `$ref` objects

With references handled, `inferClassType` makes a reference placeholder
when `propertyNames` is exactly `["$ref"]` and every value is an interned
string, and later resolves the list of references (`refs.map(resolveRef)`
into a `Set`).

`propertyNames` is `["$ref"]` iff the objects' only key is `$ref` and
`__proto__` never occurs (it would be listed). The values are all
interned strings iff each node of `$ref`'s values has no non-string kind
and no string that is not interned (`StringTally::not_interned`); under a
`$ref` key with references handled, every string is interned. The
references are the case strings of those nodes, deduplicated in
first-seen order. TypeScript's list also holds the repeats, but resolving
is a pure function of the reference and the graph: the resulting `Set` is
the same, and the first reference that fails to resolve (which decides
the error) is the same first occurrence.

### The map case

With `inferMaps` and more than 500 property names, TypeScript adds
`propertyValues[k]` for each `k` of `propertyNames`, in that order, to one
accumulator: not document order. The tally inference replays the same
sequence: for each name, the nodes of its values (the `__proto__` node
once per occurrence). By the previous sections the accumulator then holds
what it holds after the concatenated lists. The object and array members
of that accumulator are sequences of places, handled as above.

### Samples, sources and top-levels

`JsonInput::add_source` reads a source's samples into a fresh tree (a
root node that receives each sample's root value in turn). Only when all
samples have been read is the tree appended to the top-level's tree with
`Tallies::merge`; a sample that fails discards the tree, as TypeScript
discards the source's values (`addSamples` is never reached).

`merge(a, b)` makes `a` the tally of `a`'s samples followed by `b`'s:
kinds appended in `b`'s first-seen order if new; cases added up,
appended if new; the attribute combinations combined (associativity, as
above); object counts and key counts added, `b`'s new keys appended in
`b`'s order with `b`'s `__proto__` runs interleaved where they occur in
`b`'s `propertyNames` (after the keys listed so far); `b`'s last
`__proto__` value replaces `a`'s if it has one; items and key values
merged recursively. Each rule is the corresponding operation applied to
the concatenation, so a merged tree equals the tree of reading on (the
unit test `merging_trees_is_reading_on` checks every split of a sequence
of samples).

The CLI adds each file (or standard input) as its own source, so a
directory of samples is merged into one tree per top-level.

### `JSON.parse` samples

Samples given as text (`JsonSample::String`, `JSON.parse` semantics) are
read whole by the port of `JSON.parse` either way. They are kept in the
compressed form, so that `JsonInput::to_compressed` still exports them,
and their values are walked into the source's tree
(`TallyBuilder::add_compressed_value`): every value adds what reading it
adds, its strings already classified by its tag. Stream samples
(`JsonSample::Stream` and `JsonSample::Reader`, the CLI's) are never kept;
`to_compressed` exports only the text samples of an input that infers from
tallies.

## TypeBuilder calls

`TallyInference` mirrors `TypeInference` function by function: the same
recursion (`inferType` → `buildUnion` → `makeObject`/`makeArray` →
`inferClassType` → `inferType`), with the same arguments for `fixed`,
`forwardingRef` (including the quirk of passing it to the items of an
array) and the attributes, and the same `UnionBuilder::build_union`. Its
inputs at each call are equal by the sections above, so it calls the
`TypeBuilder` in the same order with the same arguments, and the type
indexes are identical. The reference intersections are collected and
resolved per top-level, as in TypeScript.

## Depth

Inference recurses once per nesting level, as `Inference.ts` does, where
V8's stack runs out within about 1,000 levels (`RangeError: Maximum call
stack size exceeded`). Both paths run `inferType` under
`support::recursion::guard`, which fails with that `RangeError` once
`MAX_DEPTH` (1,000) calls are nested and grows the native stack until
then. `TallyInference::infer_type` is called exactly where
`TypeInference::infer_type` is (a top-level, each property, the items of
arrays; the map case calls neither), so both fail at the same depth: a
value nested 999 levels below a top-level is inferred, one nested 1,000
levels fails. Everything else on the tally path is iterative: the
readers, the `TallyBuilder` (a stack of frames), walking `CompressedJSON`
values, `Tallies::merge` and freeing trees. So a document nested a
million levels deep is read into a million nodes and then fails with the
`RangeError`, on both paths, and never overflows the native stack.

## Errors

The readers are the same code for both paths: the stream-json tokenizer
(`compressed_json_from_stream.rs`) emits into a `JsonSink`, which is either
`CompressedJson` or `TallyBuilder`, and `JSON.parse` samples are parsed
before they are walked. So every syntax error is raised at the same point
with the same message, a failed read is reported as before, and a second
read of a `SampleReader` gives the same error. The tally builder raises no
errors of its own on valid structure (its checks mirror `CompressedJSON`'s
internal assertions).

## What is not tallied

Nothing in inference is left on the old path. Two inputs keep the
compressed form for other reasons:

- `JsonInput::from_compressed`: the tables come from the TypeScript
  `CompressedJSON` of the npm facade, so that input infers from them, as
  before.
- Text samples (`JSON.parse` semantics) are parsed whole, as `JSON.parse`
  does, and kept for `to_compressed`; their inference uses tallies.

## Choosing the path

`JsonInput::new` (and so `json_input_for_target_language` and the CLI)
infers from tallies. The hidden `JsonInput::set_tally_inference(false)`
selects the reference path before any source is added, and the CLI does
the same when `QUICKTYPE_INFERENCE=compressed-json` is set (for testing
only; there is no CLI option, and `--help` is unchanged).

## Memory

A tally grows with the number of places, distinct keys per place, and
distinct interned strings per place; the text of keys and cases is stored
once for all places. Nodes freed by `__proto__` and by merges are reused.
What still grows with the input: a single token is held whole while it is
read (a 1 GB string needs 1 GB), each place keeps every distinct short
string (enum inference needs all of them with their counts), and a
`__proto__` key costs an entry only when a new key was listed since its
previous occurrence.

## Testing

`crates/quicktype-core/tests/streaming_inference.rs` runs generated inputs
through both paths (`tests/streaming_support/`). The seeded generator
writes JSON text with: enum pools sized around `MIN_LENGTH_FOR_ENUM` and
the `sqrt` boundary (array lengths 9, 10, 11, 16, 17, 25, 26, ...);
dates, times, date-times, UUIDs, integer and boolean strings, URIs (with
and without extensions, invalid ports) and near misses; strings around
the 64-unit interning limit, also with astral characters; integer and
double literals at the int32/int64/safe-integer edges and beyond, `-0`,
`1.0`, exponents; maps of 250, 499–502, 520 and 700 keys; duplicate keys;
`__proto__`, `$ref` and other special keys; unicode keys and escapes
(also lone surrogates); nesting from shallow to around the depth limit
(997–1,002 levels of arrays, objects or both) and far beyond it (5,000
and 100,000); empty containers; mixed types; one
to three top-levels with one to three sources of one or two samples each,
some broken, read as bytes, through readers returning 1 to 4,096 bytes at
a time, or as text (`JSON.parse`).

For each seed it compares every `add_source` result, the type graph right
after inference (`{:?}` of the whole graph: every type in index order with
every attribute, including all string cases and counts) for five
combinations of `inferMaps`, `inferEnums`, fixed top-levels, alphabetized
and optional properties and date-time inference, and a whole run (all
files, lines and annotations, or the error) for a language and option set
picked by the seed: Rust, TypeScript, Go, C#, Python, Java, Swift and
Kotlin most often, any language sometimes; default options, `--no-enums`,
`--no-maps`, `--all-properties-optional`, `--alphabetize-properties`,
`--no-date-times`, `--no-uuids`, `--no-integer-strings`,
`--no-boolean-strings`, `--no-combine-classes`; references handled in a
fifth of the cases. Hand-written cases (`__proto__` runs, maps around 500
keys with `__proto__`, reference lists, duplicate keys across samples and
sources, enum thresholds) run through every language and option set, and
`deep_nesting` checks documents nested 998 to 1,001 levels (arrays,
objects, alternating) and 20,000 and a million levels (as bytes, through
a reader and as text): the same results on both paths, the `RangeError`
from exactly 1,000 levels on.

- `cargo test` checks 3,000 seeds.
- `cargo xtask streaming-fuzz --seeds 1_000_000` checks a million in
  release mode (`--start`, `-j`, `--runs` for more).
- `cargo xtask streaming-fuzz --dump <dir> --seeds 2000` writes generated
  documents for `cargo xtask diff --each <dir> -- <args>`, which compares
  our CLI with the TypeScript CLI, guarding against a bug both Rust paths
  share.
