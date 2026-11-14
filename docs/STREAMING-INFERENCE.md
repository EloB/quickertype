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
tested against. The WebAssembly engine keeps its inputs in that compressed
form, which quicktype's API can ask for at any time, and infers from
tallies made of it when a run starts ([Tallies of a compressed
form](#tallies-of-a-compressed-form)).

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
per string value a lookup instead of a set merge. Bits per tally
(`StringTally::absorbed`) then skip the lookup too: combining only ever
adds to the string types (their union is unrestricted if either is, and
unites the transformations), so once they absorb unrestricted strings or
a transformation, they always do, and the bit set when it was first
added says so for every later value. A merge keeps the bits of both
tallies, since what either combination absorbs, their union does.

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
`propertyValues[key]` of the concatenated objects. (The places of all
keys go into one list, each key's in a range of it; for the objects of a
single place, the usual case, the place's own tally is that collection
already and nothing is gathered.)

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

`TallyBuilder` reads each sample into a tree of its own, whose root
receives the sample's root value. A sample that fails part way is freed
whole (`reset_partial_sample`, or when the builder is dropped): the
tallies are as they were before it, but for the text of its keys and
strings in the shared string table, which nothing refers to.

`JsonInput::add_source` appends each sample's tree to the source's (the
first sample's) with `Tallies::merge`, and only when all samples have
been read appends the source's tree to the top-level's. Adding a source
is all or nothing, as in TypeScript, which discards the values of a
source that fails (`addSamples` is never reached): a sample that fails
frees the source's tree, and so does a merge that fails. `merge` first
plans, without changing anything, every pair of places it joins: it
looks every node up and combines the string attributes of the pairs that
both have strings, the only steps that can fail. Then it carries the plan
out, which cannot fail. So a failed merge leaves the tree merged into as
it was, and frees the tree it was given. (Unit tests inject a failure at
every step of a merge, cut a sample at every byte before a good one, and
make adding a source fail in each of these places.)

A merge skips combining two places' string attributes when the first
absorbs the second, by the shortcuts of the previous sections (the
second holds only string types and URI attributes, and adds no
transformation, protocol or extension, or the first is unrestricted), and
the emptied string and object tallies of merged trees are reused for the
next sample's places. Rolling back costs nothing for a source of one
sample, which is how the CLI adds every file, and a merge per further
sample otherwise: about 3.5 µs for a one-record sample, which is most of
its cost (60,000 one-record samples in one source take 419 ms of CPU
instead of 217 ms when read into one tree; samples of 10 records 249 ms
instead of 218, of 100 records 231 instead of 222).

`merge(a, b)` makes `a` the tally of `a`'s samples followed by `b`'s:
kinds appended in `b`'s first-seen order if new; cases added up,
appended if new; the attribute combinations combined (associativity, as
above); object counts and key counts added, `b`'s new keys appended in
`b`'s order with `b`'s `__proto__` runs interleaved where they occur in
`b`'s `propertyNames` (after the keys listed so far); `b`'s last
`__proto__` value replaces `a`'s if it has one; items and key values
merged recursively. Each rule is the corresponding operation applied to
the concatenation, so a merged tree equals the tree of reading on: the
unit test `merging_trees_is_reading_on` checks that the merged trees of a
sequence of samples, split anywhere, equal the items of one array of
those samples read in one go.

The CLI adds each file (or standard input) as its own source, with one
sample, so a directory of samples is merged into one tree per top-level.

### `JSON.parse` samples

Samples given as text (`JsonSample::String`, `JSON.parse` semantics) are
read by the one-pass `JSON.parse` reader either way
(`compressed_json/from_string.rs`): it checks V8's grammar in one pass
that records the sample on a tape, without building the value, then
emits the tape into a `JsonSink` in `Object.getOwnPropertyNames` order,
the events `process` would emit for the parsed value. The same function
(`parse_string_into`) fills a `CompressedJson` on the reference path and a
`TallyBuilder` here, so the tallies receive exactly the events the
compressed form is built from. Nothing of the sample is kept.

`JsonInput::to_compressed` exports samples in the compressed form, which
an input that infers from tallies does not have: there it is an error,
and an input that is to be exported is made with
`set_tally_inference(false)` before its sources are added.

## Tallies of a compressed form

The WebAssembly engine reads the samples of a JavaScript `JSONInput` into
a `CompressedJson` as they are added, and keeps that form for every run
that uses the input (`JsonInput::from_shared`); samples TypeScript read
arrive as the tables of a JavaScript `CompressedJSON`
(`JsonInput::from_compressed`). The form has to stay: quicktype's API can
ask for a `CompressedJSON`'s tables at any time, and the npm facade then
fills them from it (`npm/quicktype-core/README.md`, "JSON samples"). Such
an input infers from tallies made of the form when its types are
inferred (`tally_compressed` in `input/tallies.rs`): one walk over it,
then the inference from tallies of the sections above. The tallies of a
run are freed when its inference ends, so what the engine holds between
runs, and what its memory limit counts, are as before.

The walk starts at each sample's root, top-level by top-level and sample
by sample in the order the top-level lists them, and goes depth first,
each object's entries and each array's elements in order. For each value
it does what the `TallyBuilder` does for the reader's event that made
it: a kind for `null`, a boolean or a number; for an object, what
`pushObjectContext` adds where the object starts, then each entry's key
as `setPropertyKey` counts it (`__proto__` included) and its value; for
an array, what `pushArrayContext` adds, then its elements. A string was
classified by `commitString` when it was read, and its value records how:
an interned string (a candidate case, or any string under a `$ref` key
with references handled) is `add_case`, an uninterned one
`add_uninterned`, a string format `add_string_format` with its kind, and
a transformed string `add_transformed_string` with the kind and
attributes of its text, computed with the form's date/time recognizer as
`Inference.ts` computes them.

So each place's node sees the operations the builder performs while
reading, in the same order. By the induction of [Places](#places), the
values at a place are visited in document order: a top-level's samples
in order, then for each object at a place, in that order, its entries,
and for each array its elements. A container is tallied where it starts,
as the builder tallies it. Each top-level's samples go into one tree,
where reading gives each sample a tree and merges them, which is the
same tree (`merging_trees_is_reading_on`). The tallies are therefore the
ones reading the samples gives, and everything above applies.

One difference cannot be observed: a key or case is known by its index
in the form's string table, not in a table of the tallies' own; every
text is there once, as `internString` interns it, but `"__proto__"`,
which gets a new index each time and so is known by its text (the walk
takes the first such index for all).

The walk declines what no reader makes: an object or array reached a
second time (shared, or a cycle), an object key that is not an interned
string, a transformed string whose text has no kind or no attribute
producer, a string table that holds a text twice. Then the input infers
from the values one by one, which is the reference, so the types are
quicktype's either way (for a transformed string without a kind or
producer, that is `Inference.ts`'s error). Forms the engine read, and
tables of quicktype's own `CompressedJSON` (which the facade requires),
have none of these; checking costs a bit per container. Nothing else
declines: an error while tallying is the run's, raised as reading the
samples raises it. A value that is not there (which imported tables
cannot have: importing checks every value) fails the walk with the
error the values' inference fails with when it looks the value up, and
more places than a node id counts fails as reading fails.

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
readers, `process` for `JSON.parse` values, the `TallyBuilder` (a stack of
frames), `Tallies::merge` and freeing trees. So a document nested a
million levels deep is read into a million nodes and then fails with the
`RangeError`, on both paths, and never overflows the native stack.

## Errors

The readers are the same code for both paths: the stream-json tokenizer
(`compressed_json_from_stream.rs`) and `JSON.parse` with `process`
(`compressed_json.rs`) emit into a `JsonSink`, which is either
`CompressedJson` or `TallyBuilder`. So every syntax error is raised at the
same point with the same message, a failed read is reported as before, and
a second read of a `SampleReader` gives the same error. The tally builder
raises no errors of its own on valid structure (its checks mirror
`CompressedJSON`'s internal assertions).

## What is not tallied

Nothing in inference is left on the old path. The inputs that keep the
compressed form (the WebAssembly engine's, `JsonInput::from_shared` and
`JsonInput::from_compressed`) infer from tallies of it ([Tallies of a
compressed form](#tallies-of-a-compressed-form)), unless the walk
declines it. Text samples (`JSON.parse` semantics) are recorded whole on
the reader's tape, and then tallied like any other.

## Choosing the path

`JsonInput::new` (and so `json_input_for_target_language`, the CLI, the
benchmarks and every other Rust caller) infers from tallies, unless
`QUICKTYPE_INFERENCE=compressed-json` is set in the environment, which
`JsonInput::new` reads (once per process) to select the reference path,
for testing only: there is no CLI option, and `--help` is unchanged.
`JsonInput::set_tally_inference(bool)` chooses either path explicitly
before any source is added; the reference path keeps every sample in
memory, and is the one `to_compressed` needs. An input that keeps the
compressed form infers from its values one by one, or from tallies of it
with `JsonInput::set_tally_compressed(true)`, which `from_shared` and
`from_compressed` set (and `QUICKTYPE_INFERENCE=compressed-json` does
not).

## Memory

A tally grows with the number of places, distinct keys per place, and
distinct interned strings per place; the text of keys and cases is stored
once for all places. Nodes freed by `__proto__` and by merges are reused.
What still grows with the input: a single token is held whole while it is
read (a 1 GB string needs 1 GB), a text sample is recorded whole on the
`JSON.parse` reader's tape (12 bytes a value or key, freed after the
sample), each place keeps every distinct short string (enum
inference needs all of them with their counts), the text of the keys and
strings of a sample that failed stays in the string table, and a
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

- `cargo test` checks 3,000 seeds, each with five graphs and a whole
  run, every way (below), against the reference computed once per seed.

Results when this landed: `cargo xtask streaming-fuzz` over seeds 0 to
1,999,999 (two runs of a million, the second after merging main) found 0
differences in 4,000,000 graphs and 199,842 whole runs (15,871 of them
failed identically, mostly `$ref`s that do not resolve; 158 skipped for
a `$ref` cycle through a union, below), with 318,693 sources failing
identically (broken samples). `cargo xtask diff` found our CLI identical
to the TypeScript CLI on all 2,000 dumped documents (20 groups of 100:
Rust, TypeScript, Go, C#, Python, Java, Swift and Kotlin with the default
options, each option set above, `--no-ignore-json-refs`, Elm) and on 50
directories of three documents (one top-level, three samples).

After the review's fixes (atomic sources, each sample in a tree of its
own, `JSON.parse` samples emitted straight into the tallies, the flat
collection of class properties, cheaper merges): seeds 0 to 999,999
again, 0 differences in 2,000,000 graphs and 99,923 whole runs (8,007
failed identically, 77 skipped for a `$ref` cycle through a union),
159,647 sources failing identically; our CLI identical to the TypeScript
CLI on 500 new documents (seeds from 5,000,000) with each of `-l rust`,
`-l typescript --no-enums`, `-l go --no-maps --alphabetize-properties` and
`-l kotlin --all-properties-optional --no-date-times`, and on 30 groups
of three of them as one top-level (`-t Group a.json b.json c.json`, three
sources merged) and as directories, in Rust and TypeScript.

Two kinds of whole run are left out, both for problems after inference
that are the same on both paths. A case with a sample nested near the
depth limit runs with `--no-combine-classes` (combining classes compares
every pair of classes along a chain of a thousand: minutes). A case whose
graph has a cycle through unions and intersections alone (a `$ref` to a
place whose union contains the reference, `{"a": "x"}` then `{"a":
{"$ref": "#/a"}}`) gets no whole run: TypeScript fails with `RangeError:
Maximum call stack size exceeded` in `attributesForTypes`, and the port's
`attributes_for_types` recursion is not guarded yet, so it overflows the
native stack (a fix is on the fuzzing branches). The graphs of both kinds
of case are still compared.
- `cargo xtask streaming-fuzz --seeds 1_000_000` checks a million,
  optimized, with two graphs per seed (other inference flags for each)
  and a whole run on every tenth seed by default (`--graphs`, `--runs`,
  `--runs-every`, `--start`, `-j`; `--trace` prints each seed as it
  starts, to find one that crashes).
- `cargo xtask streaming-fuzz --dump <dir> --seeds 2000` writes generated
  documents for `cargo xtask diff --each <dir> -- <args>`, which compares
  our CLI with the TypeScript CLI, guarding against a bug both Rust paths
  share.

The [tallies of a compressed form](#tallies-of-a-compressed-form) are
checked the same way. Unit tests (`input/tallies.rs`) walk the forms both
readers made of samples with every kind of value, `__proto__` keys and
strings (repeated, which only the stream reader keeps), `$ref`s,
repeated and reordered keys, and compare the tallies with those of
reading the same samples, also split into top-levels; others hand the
walk tables no reader makes (an object reached twice, a cycle, a text
twice in the string table, a transformed string without a kind), which
it declines, and check that such an input infers what the reference
infers (`input/inputs.rs`). The harness's `Path::CompressedTallies`
compares two more ways with the reference, for every seed: the
compressed form the readers made, tallied (the engine's path for the
samples it read, `jsonShared`), and its tables exported and imported
again with `JsonInput::from_compressed` (its path for tables a
JavaScript `CompressedJSON` built, `json`). After every graph it also
checks where each way inferred from (`JsonInput::inferred_from`): forms
the readers made, and their tables, must be tallied, never declined, so
a walk that declined them fails the comparison instead of comparing the
reference with itself (forcing `tally_compressed` to decline fails it on
the first seeds and on every hand-written case). `cargo test`'s 3,000
seeds and the hand-written cases above run every way (`Path::All`).

- `cargo xtask streaming-fuzz --path compressed --seeds 1_000_000` checks
  the WebAssembly engine's path instead of the CLI's (`--path all` both).

Results when this landed: seeds 0 to 999,999 with `--path compressed`
found 0 differences in 4,000,000 graphs (two flag combinations per seed,
each for both ways) and 99,923 whole runs, each both ways (8,135 failed
identically, 77 skipped for a `$ref` cycle through a union), with
159,927 sources failing identically; 544 s on 12 threads. (The harness
then counted a whole run once per way, and reported 199,846 runs and
16,270 failures; it counts each run once now.)
