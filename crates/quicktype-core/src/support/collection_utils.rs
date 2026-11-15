//! Port of npm collection-utils (subset)
//!
//! `collection-utils` 1.0.1 (`node_modules/collection-utils/dist/index.js`)
//! provides quicktype's structural equality (`areEqual`), hashing
//! (`hashCodeOf`, `hashString`, `addHashCode`) and the `EqualityMap` used to
//! deduplicate types by identity. Which duplicate wins depends on the exact
//! hash values and on the linear probing on collisions, so they are ported
//! bit for bit here:
//!
//! * [`JsHash::hash_code`] is `hashCodeOf`. It returns the JavaScript number
//!   `hashCodeOf` returns, as an `i64`: usually an int32, but the hash of a
//!   `Set` or `Map` is a plain (untruncated) sum of element hashes.
//! * [`JsEquals::js_equals`] is `areEqual`: `===`, then `equals`, then sets
//!   (order-insensitive), maps (order-insensitive keys) and arrays (ordered).
//! * [`EqualityMap`] probes linearly (`h + 1 | 0`) and iterates in
//!   first-insertion order. It finds the end of a probe run and the keys
//!   that may match without walking the run, through a seeded
//!   [`DeepHash`] of the keys, so that colliding hashes, which are easy to
//!   craft, do not make it quadratic; the results are the walk's.
//!
//! JavaScript `Set`/`Map` map to `IndexSet`/`IndexMap`, which iterate in
//! insertion order like their JavaScript counterparts. The order-sensitive
//! combinators that are not one-liners on `IndexSet`/`IndexMap` are ported
//! below.

use std::cell::Cell;
use std::cmp::Ordering;
use std::hash::{BuildHasher as _, Hash};
use std::sync::OnceLock;

use crate::support::fast_hash::{HashMap, IndexMap, IndexSet, SeededState};

use quicktype_js_compat::sort::{compare_utf16, sort_by};

/// `hashCodeInit`.
pub const HASH_CODE_INIT: i64 = 17;

/// JavaScript `ToInt32` (`x | 0`) of a number.
pub fn to_int32(x: f64) -> i32 {
    if !x.is_finite() {
        return 0;
    }
    let truncated = x.trunc();
    let modulo = truncated.rem_euclid(4_294_967_296.0);
    (modulo as u32) as i32
}

/// `x | 0` for a JavaScript number held as an integer.
pub fn int32(x: i64) -> i32 {
    x as i32
}

/// `hashString`: Java's string hash over UTF-16 code units, in int32.
pub fn hash_string(s: &str) -> i32 {
    let mut hash: i32 = 0;
    for unit in s.encode_utf16() {
        hash = (hash << 5).wrapping_sub(hash).wrapping_add(i32::from(unit));
    }
    hash
}

/// `addHashCode(acc, h)` = `(acc * 31 + (h | 0)) | 0`.
pub fn add_hash_code(acc: i64, h: i64) -> i64 {
    i64::from(int32(
        acc.wrapping_mul(31).wrapping_add(i64::from(int32(h))),
    ))
}

/// `hashCodeOf(x)`: quicktype's structural hash.
pub trait JsHash {
    /// The value `hashCodeOf` returns for `self`.
    fn hash_code(&self) -> i64;
}

/// `areEqual(a, b)`: quicktype's structural equality.
pub trait JsEquals {
    /// Whether `areEqual(self, other)` holds.
    fn js_equals(&self, other: &Self) -> bool;
}

impl JsHash for str {
    fn hash_code(&self) -> i64 {
        i64::from(hash_string(self))
    }
}

impl JsHash for String {
    fn hash_code(&self) -> i64 {
        self.as_str().hash_code()
    }
}

impl JsEquals for String {
    fn js_equals(&self, other: &Self) -> bool {
        self == other
    }
}

impl JsHash for bool {
    fn hash_code(&self) -> i64 {
        if *self {
            HASH_CODE_INIT + 1
        } else {
            HASH_CODE_INIT + 2
        }
    }
}

impl JsEquals for bool {
    fn js_equals(&self, other: &Self) -> bool {
        self == other
    }
}

impl JsHash for f64 {
    fn hash_code(&self) -> i64 {
        i64::from(to_int32(*self))
    }
}

impl JsEquals for f64 {
    /// `===` on numbers: `NaN` is unequal to itself, `0 === -0`.
    fn js_equals(&self, other: &Self) -> bool {
        self == other
    }
}

macro_rules! int_js_hash {
    ($($t:ty),*) => {$(
        impl JsHash for $t {
            fn hash_code(&self) -> i64 {
                i64::from(int32(*self as i64))
            }
        }

        impl JsEquals for $t {
            fn js_equals(&self, other: &Self) -> bool {
                self == other
            }
        }
    )*};
}

int_js_hash!(i32, u32, i64, u64, usize);

/// `undefined` hashes to `hashCodeInit` and is only equal to itself.
impl<T: JsHash> JsHash for Option<T> {
    fn hash_code(&self) -> i64 {
        match self {
            None => HASH_CODE_INIT,
            Some(v) => v.hash_code(),
        }
    }
}

impl<T: JsEquals> JsEquals for Option<T> {
    fn js_equals(&self, other: &Self) -> bool {
        match (self, other) {
            (None, None) => true,
            (Some(a), Some(b)) => a.js_equals(b),
            _ => false,
        }
    }
}

/// A `Set` hashes to `hashCodeInit` plus the (untruncated) sum of its
/// elements' hashes.
impl<T: JsHash> JsHash for IndexSet<T> {
    fn hash_code(&self) -> i64 {
        self.iter().fold(HASH_CODE_INIT, |h, x| h + x.hash_code())
    }
}

/// Sets are equal if they have the same size and every element of one is in
/// the other (`Set.prototype.has`, i.e. `Eq`), regardless of order.
impl<T: Hash + Eq> JsEquals for IndexSet<T> {
    fn js_equals(&self, other: &Self) -> bool {
        self.len() == other.len() && self.iter().all(|x| other.contains(x))
    }
}

/// A `Map` hashes to `addHashCode(17 + Σ hash(key), 17 + Σ hash(value))`.
impl<K: JsHash, V: JsHash> JsHash for IndexMap<K, V> {
    fn hash_code(&self) -> i64 {
        let mut g = HASH_CODE_INIT;
        let mut h = HASH_CODE_INIT;
        for (k, v) in self {
            g += k.hash_code();
            h += v.hash_code();
        }
        add_hash_code(g, h)
    }
}

/// Maps are equal if they have the same size and every value equals the other
/// map's value for the same key, regardless of order.
impl<K: Hash + Eq, V: JsEquals> JsEquals for IndexMap<K, V> {
    fn js_equals(&self, other: &Self) -> bool {
        self.len() == other.len()
            && self
                .iter()
                .all(|(k, v)| other.get(k).is_some_and(|w| v.js_equals(w)))
    }
}

/// An array hashes to `addHashCode` folded over its elements from
/// `hashCodeInit`.
impl<T: JsHash> JsHash for [T] {
    fn hash_code(&self) -> i64 {
        self.iter()
            .fold(HASH_CODE_INIT, |h, x| add_hash_code(h, x.hash_code()))
    }
}

impl<T: JsHash> JsHash for Vec<T> {
    fn hash_code(&self) -> i64 {
        self.as_slice().hash_code()
    }
}

impl<T: JsEquals> JsEquals for Vec<T> {
    fn js_equals(&self, other: &Self) -> bool {
        self.len() == other.len() && self.iter().zip(other).all(|(a, b)| a.js_equals(b))
    }
}

/// A pair is a two-element JavaScript array.
impl<A: JsHash, B: JsHash> JsHash for (A, B) {
    fn hash_code(&self) -> i64 {
        add_hash_code(
            add_hash_code(HASH_CODE_INIT, self.0.hash_code()),
            self.1.hash_code(),
        )
    }
}

impl<A: JsEquals, B: JsEquals> JsEquals for (A, B) {
    fn js_equals(&self, other: &Self) -> bool {
        self.0.js_equals(&other.0) && self.1.js_equals(&other.1)
    }
}

/// A seeded hash consistent with [`JsEquals`]: keys that are `areEqual`
/// hash alike (order-insensitively where equality is: sets, maps,
/// attributes). [`EqualityMap`] finds its candidates by it, so that keys
/// whose collection-utils hashes collide, which anyone can craft ("Aa" and
/// "BB" have the same `hashString`), cannot make it quadratic.
///
/// It may be coarser than equality (hashing a part as a constant is
/// consistent), never finer: two keys that are `areEqual` but hash
/// differently would make `EqualityMap` miss an entry.
pub trait DeepHash {
    /// The deep hash of `self`, with this process's (instance's) seed.
    fn deep_hash(&self) -> u64;
}

/// The seeded state of every deep hash: one per process, or per instance
/// in WebAssembly, so that a key's deep hash can be computed once, when the
/// key is made.
pub(crate) fn deep_state() -> &'static SeededState {
    static STATE: OnceLock<SeededState> = OnceLock::new();
    STATE.get_or_init(SeededState::default)
}

/// The deep hash of anything whose `Eq` is its `JsEquals`.
pub fn deep_hash_of<T: Hash + ?Sized>(x: &T) -> u64 {
    deep_state().hash_one(x)
}

/// Deep hashes combined in order.
pub fn deep_combine(parts: &[u64]) -> u64 {
    deep_state().hash_one(parts)
}

/// Deep hashes combined in any order, for what equality compares as a set:
/// their count and their (wrapping) sum, which is as hard to aim at as
/// each hash without the seed.
pub fn deep_unordered(hashes: impl Iterator<Item = u64>) -> u64 {
    let (count, sum) = hashes.fold((0u64, 0u64), |(n, s), h| (n + 1, s.wrapping_add(h)));
    deep_combine(&[count, sum])
}

impl DeepHash for str {
    fn deep_hash(&self) -> u64 {
        deep_hash_of(self)
    }
}

impl DeepHash for String {
    fn deep_hash(&self) -> u64 {
        deep_hash_of(self.as_str())
    }
}

impl DeepHash for bool {
    fn deep_hash(&self) -> u64 {
        deep_hash_of(self)
    }
}

impl DeepHash for f64 {
    /// By the bits, with `-0` as `0` (`0 === -0`); `NaN` equals nothing.
    fn deep_hash(&self) -> u64 {
        let x = if *self == 0.0 { 0.0f64 } else { *self };
        deep_hash_of(&x.to_bits())
    }
}

macro_rules! int_deep_hash {
    ($($t:ty),*) => {$(
        impl DeepHash for $t {
            fn deep_hash(&self) -> u64 {
                deep_hash_of(self)
            }
        }
    )*};
}

int_deep_hash!(i32, u32, i64, u64, usize);

impl<T: DeepHash + ?Sized> DeepHash for std::rc::Rc<T> {
    /// The content's: equality is `Rc::ptr_eq` or the content's.
    fn deep_hash(&self) -> u64 {
        (**self).deep_hash()
    }
}

impl<T: DeepHash> DeepHash for Option<T> {
    fn deep_hash(&self) -> u64 {
        match self {
            None => deep_combine(&[0]),
            Some(v) => deep_combine(&[1, v.deep_hash()]),
        }
    }
}

/// A set, in any order (its `JsEquals`).
impl<T: DeepHash> DeepHash for IndexSet<T> {
    fn deep_hash(&self) -> u64 {
        deep_unordered(self.iter().map(DeepHash::deep_hash))
    }
}

/// A map: its pairs, in any order (its `JsEquals`).
impl<K: DeepHash, V: DeepHash> DeepHash for IndexMap<K, V> {
    fn deep_hash(&self) -> u64 {
        deep_unordered(
            self.iter()
                .map(|(k, v)| deep_combine(&[k.deep_hash(), v.deep_hash()])),
        )
    }
}

impl<A: DeepHash, B: DeepHash> DeepHash for (A, B) {
    fn deep_hash(&self) -> u64 {
        deep_combine(&[self.0.deep_hash(), self.1.deep_hash()])
    }
}

/// `EqualityMap<K, V>`: a map keyed by structural equality.
///
/// The JavaScript original is a `Map` from a slot to an entry: `set` and
/// `get` start at the slot of `hashCodeOf(k) | 0` and step to the next
/// slot (`h + 1 | 0`) until they find an `areEqual` key or a free slot,
/// where `set` puts the entry. Which entry a lookup finds depends on the
/// exact hash values and on what was inserted before, and keys that are
/// equal but hash differently (`Ref`s whose addresses differ only in
/// their query's order) are found only where their probe runs meet. `set`
/// on an equal key overwrites the value in place; iteration is in
/// first-insertion order.
///
/// This keeps exactly those slots, and answers what the walk would, in
/// near-constant time whatever the hashes:
/// - A key's own slot is checked first: free, or holding an equal key,
///   settles it at once, as it does the walk.
/// - Otherwise the first free slot after it comes from "next free slot"
///   links with path compression, and the keys that may be equal from an
///   index by their [`DeepHash`], which equal keys share. Each deep hash
///   keeps its entries sorted by slot, so a lookup visits only those in its
///   own probe run, in the walk's order, and stops at the first equal one.
///
/// So colliding hashes cost no more than distinct ones, a coarse deep hash
/// costs only within a probe run, and the results, the slots and the order
/// are the original's.
#[derive(Clone, Debug)]
pub struct EqualityMap<K, V> {
    /// The entries, in first-insertion order.
    entries: Vec<(K, V)>,
    /// The taken slots: the entry there, and a slot after it from which the
    /// search for a free slot goes on (every slot in between is taken).
    taken: HashMap<i32, (u32, Cell<i32>)>,
    /// The entries by deep hash, by slot.
    by_deep: HashMap<u64, Bucket>,
    /// In builds with debug assertions: the original's slots, walked as it
    /// walks them, to check every answer against (none for the tests of
    /// many colliding keys, which would make it quadratic).
    #[cfg(debug_assertions)]
    shadow: Option<Box<IndexMap<i32, u32>>>,
}

/// The entries with one deep hash, by slot (as `u32`, so that the order
/// is the walk's, which wraps from `i32::MAX` to `i32::MIN`).
#[derive(Clone, Debug)]
enum Bucket {
    One(u32, u32),
    Many(std::collections::BTreeMap<u32, u32>),
}

impl Bucket {
    fn insert(&mut self, slot: u32, entry: u32) {
        match self {
            Bucket::One(s, e) => {
                let mut many = std::collections::BTreeMap::new();
                many.insert(*s, *e);
                many.insert(slot, entry);
                *self = Bucket::Many(many);
            }
            Bucket::Many(many) => {
                many.insert(slot, entry);
            }
        }
    }

    /// The first entry, in slot order from `from` (cyclically) and before
    /// `to`, that `is_equal` accepts.
    fn first(&self, from: u32, to: u32, mut is_equal: impl FnMut(u32) -> bool) -> Option<u32> {
        let within = |slot: u32| slot.wrapping_sub(from) < to.wrapping_sub(from);
        match self {
            Bucket::One(slot, e) => (within(*slot) && is_equal(*e)).then_some(*e),
            Bucket::Many(many) => {
                let mut run: Box<dyn Iterator<Item = (&u32, &u32)>> = if from <= to {
                    Box::new(many.range(from..to))
                } else {
                    Box::new(many.range(from..).chain(many.range(..to)))
                };
                run.find(|&(_, &e)| is_equal(e)).map(|(_, &e)| e)
            }
        }
    }
}

impl<K, V> Default for EqualityMap<K, V> {
    fn default() -> Self {
        EqualityMap {
            entries: Vec::new(),
            taken: HashMap::default(),
            by_deep: HashMap::default(),
            #[cfg(debug_assertions)]
            shadow: Some(Box::default()),
        }
    }
}

/// Where a key is: at an entry, or not there, with the free slot where
/// `set` puts it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Found {
    Entry(u32),
    Free(i32),
}

/// The first free slot at or after `slot`, compressing the links on the
/// way.
fn free_slot(taken: &HashMap<i32, (u32, Cell<i32>)>, slot: i32) -> i32 {
    let mut free = slot;
    while let Some((_, next)) = taken.get(&free) {
        free = next.get();
    }
    let mut s = slot;
    while s != free {
        let (_, next) = &taken[&s];
        s = next.replace(free);
    }
    free
}

impl<K: JsHash + JsEquals + DeepHash, V> EqualityMap<K, V> {
    /// An empty map.
    pub fn new() -> Self {
        Self::default()
    }

    /// An empty map that does not check itself against the original's walk
    /// (which is quadratic on colliding keys), for the tests of many.
    #[cfg(test)]
    fn without_check() -> Self {
        EqualityMap {
            #[cfg(debug_assertions)]
            shadow: None,
            ..Self::default()
        }
    }

    /// The original's walk from `h` (`hashCodeOf(k) | 0`), and `k`'s deep
    /// hash if it took it: only where `h`'s own slot holds another key.
    fn find(&self, k: &K, h: i32) -> (Found, Option<u64>) {
        let (found, deep) = match self.taken.get(&h) {
            None => (Found::Free(h), None),
            Some(&(e, _)) if k.js_equals(&self.entries[e as usize].0) => (Found::Entry(e), None),
            Some(_) => {
                let free = free_slot(&self.taken, h);
                let deep = k.deep_hash();
                let from = (h as u32).wrapping_add(1);
                let entry = self.by_deep.get(&deep).and_then(|bucket| {
                    bucket.first(from, free as u32, |e| {
                        k.js_equals(&self.entries[e as usize].0)
                    })
                });
                (entry.map_or(Found::Free(free), Found::Entry), Some(deep))
            }
        };
        #[cfg(debug_assertions)]
        if let Some(shadow) = &self.shadow {
            let mut slot = h;
            let walked = loop {
                match shadow.get(&slot) {
                    None => break Found::Free(slot),
                    Some(&e) if k.js_equals(&self.entries[e as usize].0) => break Found::Entry(e),
                    Some(_) => slot = slot.wrapping_add(1),
                }
            };
            assert_eq!(
                found, walked,
                "EqualityMap differs from collection-utils' walk"
            );
        }
        (found, deep)
    }

    /// `set(k, v)`.
    pub fn set(&mut self, k: K, v: V) {
        let (slot, deep) = match self.find(&k, int32(k.hash_code())) {
            (Found::Entry(e), _) => {
                self.entries[e as usize].1 = v;
                return;
            }
            (Found::Free(slot), deep) => (slot, deep.unwrap_or_else(|| k.deep_hash())),
        };
        let e = u32::try_from(self.entries.len()).expect("fewer than 2^32 entries");
        match self.by_deep.entry(deep) {
            std::collections::hash_map::Entry::Occupied(mut bucket) => {
                bucket.get_mut().insert(slot as u32, e)
            }
            std::collections::hash_map::Entry::Vacant(bucket) => {
                bucket.insert(Bucket::One(slot as u32, e));
            }
        }
        self.entries.push((k, v));
        self.taken
            .insert(slot, (e, Cell::new(slot.wrapping_add(1))));
        #[cfg(debug_assertions)]
        if let Some(shadow) = &mut self.shadow {
            shadow.insert(slot, e);
        }
    }

    /// `get(k)`.
    pub fn get(&self, k: &K) -> Option<&V> {
        match self.find(k, int32(k.hash_code())).0 {
            Found::Entry(e) => Some(&self.entries[e as usize].1),
            Found::Free(_) => None,
        }
    }

    /// The value for a key equal to `k`, mutably (the JavaScript code
    /// mutates the stored value object in place).
    pub fn get_mut(&mut self, k: &K) -> Option<&mut V> {
        match self.find(k, int32(k.hash_code())).0 {
            Found::Entry(e) => Some(&mut self.entries[e as usize].1),
            Found::Free(_) => None,
        }
    }

    /// `has(k)`.
    pub fn has(&self, k: &K) -> bool {
        self.get(k).is_some()
    }

    /// `values()`, in first-insertion order.
    pub fn values(&self) -> impl Iterator<Item = &V> {
        self.entries.iter().map(|(_, v)| v)
    }

    /// The number of entries.
    pub fn len(&self) -> usize {
        self.entries.len()
    }

    /// Whether the map is empty.
    pub fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }
}

/// `compareKeys` for strings: JavaScript `<`, i.e. UTF-16 code unit order.
pub fn compare_string_keys(a: &str, b: &str) -> Ordering {
    compare_utf16(a, b)
}

/// `mapSortByKey(m)` for string keys: a stable sort by UTF-16 code units.
pub fn map_sort_by_key<V: Clone>(m: &IndexMap<String, V>) -> IndexMap<String, V> {
    let mut entries: Vec<(&String, &V)> = m.iter().collect();
    sort_by(&mut entries, |a, b| compare_string_keys(a.0, b.0));
    entries
        .into_iter()
        .map(|(k, v)| (k.clone(), v.clone()))
        .collect()
}

/// `setSortBy(s, key)` / `arraySortByInto` with a string sort key: a stable
/// sort by UTF-16 code units.
pub fn sort_by_string_key<T, K: AsRef<str>>(items: &mut [T], mut key: impl FnMut(&T) -> K) {
    sort_by(items, |a, b| {
        compare_string_keys(key(a).as_ref(), key(b).as_ref())
    });
}

/// `setUnionInto(dest, src)`: appends `src`'s new elements in order.
pub fn set_union_into<T: Hash + Eq + Clone>(dest: &mut IndexSet<T>, src: &IndexSet<T>) {
    dest.extend(src.iter().cloned());
}

/// `setIntersect(a, b)`: the elements of `a` that are in `b`, in `a`'s order.
pub fn set_intersect<T: Hash + Eq + Clone>(a: &IndexSet<T>, b: &IndexSet<T>) -> IndexSet<T> {
    a.iter().filter(|x| b.contains(*x)).cloned().collect()
}

/// `setSubtract(src, diff)`: `src` without `diff`, in `src`'s order.
pub fn set_subtract<T: Hash + Eq + Clone>(src: &IndexSet<T>, diff: &IndexSet<T>) -> IndexSet<T> {
    src.iter().filter(|x| !diff.contains(*x)).cloned().collect()
}

/// `mapMergeInto(dest, src)`: existing keys keep their slot and take `src`'s
/// value, new keys are appended.
pub fn map_merge_into<K: Hash + Eq + Clone, V: Clone>(
    dest: &mut IndexMap<K, V>,
    src: &IndexMap<K, V>,
) {
    for (k, v) in src {
        dest.insert(k.clone(), v.clone());
    }
}

/// `mapMergeWithInto(dest, merger, src)`.
pub fn map_merge_with_into<K: Hash + Eq + Clone, V: Clone>(
    dest: &mut IndexMap<K, V>,
    mut merger: impl FnMut(&V, &V, &K) -> V,
    src: &IndexMap<K, V>,
) {
    for (k, vb) in src {
        let v = match dest.get(k) {
            None => vb.clone(),
            Some(va) => merger(va, vb, k),
        };
        dest.insert(k.clone(), v);
    }
}

/// `arrayIntercalate(separator, items)`: the items with `separator`
/// between each two of them.
pub fn array_intercalate<T: Clone>(separator: T, items: impl IntoIterator<Item = T>) -> Vec<T> {
    let mut acc = Vec::new();
    for x in items {
        if !acc.is_empty() {
            acc.push(separator.clone());
        }
        acc.push(x);
    }
    acc
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn to_int32_matches_javascript() {
        assert_eq!(to_int32(f64::NAN), 0);
        assert_eq!(to_int32(f64::INFINITY), 0);
        assert_eq!(to_int32(-1.9), -1);
        assert_eq!(to_int32(2_147_483_648.0), -2_147_483_648);
        assert_eq!(to_int32(4_294_967_297.5), 1);
        assert_eq!(to_int32(-4_294_967_297.0), -1);
    }

    #[test]
    fn hash_string_matches_javascript() {
        // Values from node: collection-utils hashString.
        assert_eq!(hash_string(""), 0);
        assert_eq!(hash_string("Aa"), 2112);
        assert_eq!(hash_string("BB"), 2112);
        assert_eq!(hash_string("class"), 94_742_904);
        assert_eq!(hash_string("stringTypes"), -1_520_342_296);
        assert_eq!(hash_string("\u{1F600}"), 1_772_899);
    }

    #[test]
    fn equality_map_probes_and_keeps_insertion_order() {
        let mut m: EqualityMap<String, u32> = EqualityMap::new();
        m.set("Aa".into(), 1);
        m.set("BB".into(), 2);
        m.set("x".into(), 3);
        m.set("Aa".into(), 4);
        assert_eq!(m.get(&"Aa".into()), Some(&4));
        assert_eq!(m.get(&"BB".into()), Some(&2));
        assert_eq!(m.get(&"C".into()), None);
        *m.get_mut(&"BB".into()).unwrap() += 10;
        assert_eq!(m.get(&"BB".into()), Some(&12));
        assert!(m.get_mut(&"C".into()).is_none());
        assert_eq!(m.values().copied().collect::<Vec<_>>(), vec![4, 12, 3]);
    }

    /// collection-utils' `EqualityMap` as it was ported first: a map from
    /// slot to entry, walked one slot at a time.
    struct WalkingEqualityMap<K, V> {
        map: IndexMap<i32, (K, V)>,
    }

    impl<K: JsHash + JsEquals, V> WalkingEqualityMap<K, V> {
        fn slot(&self, k: &K) -> (i32, bool) {
            let mut h = int32(k.hash_code());
            loop {
                match self.map.get(&h) {
                    None => return (h, false),
                    Some(kvp) if k.js_equals(&kvp.0) => return (h, true),
                    Some(_) => h = h.wrapping_add(1),
                }
            }
        }
        fn set(&mut self, k: K, v: V) {
            match self.slot(&k) {
                (h, true) => self.map.get_mut(&h).unwrap().1 = v,
                (h, false) => {
                    self.map.insert(h, (k, v));
                }
            }
        }
        fn get(&self, k: &K) -> Option<&V> {
            match self.slot(k) {
                (h, true) => Some(&self.map[&h].1),
                (_, false) => None,
            }
        }
        fn get_mut(&mut self, k: &K) -> Option<&mut V> {
            match self.slot(k) {
                (h, true) => self.map.get_mut(&h).map(|kvp| &mut kvp.1),
                (_, false) => None,
            }
        }
    }

    /// A key whose `hashCodeOf` is chosen: equal keys (one `class`) may
    /// hash differently, as `Ref`s with reordered queries do, and unequal
    /// ones alike.
    #[derive(Clone, Debug)]
    struct Key {
        class: u32,
        hash: i64,
        /// A deep hash as coarse as can be: the same for every key.
        coarse: bool,
    }

    std::thread_local! {
        /// How many times `Key::js_equals` ran.
        static COMPARISONS: Cell<u64> = const { Cell::new(0) };
    }

    impl JsHash for Key {
        fn hash_code(&self) -> i64 {
            self.hash
        }
    }

    impl JsEquals for Key {
        fn js_equals(&self, other: &Self) -> bool {
            COMPARISONS.set(COMPARISONS.get() + 1);
            self.class == other.class
        }
    }

    impl DeepHash for Key {
        fn deep_hash(&self) -> u64 {
            if self.coarse {
                0
            } else {
                deep_hash_of(&self.class)
            }
        }
    }

    /// SplitMix64, for reproducible operation sequences.
    fn rng(mut state: u64) -> impl FnMut(u64) -> u64 {
        move |below| {
            state = state.wrapping_add(0x9e37_79b9_7f4a_7c15);
            let mut z = state;
            z = (z ^ (z >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
            z = (z ^ (z >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
            (z ^ (z >> 31)) % below
        }
    }

    /// Random sets, gets and in-place updates on both maps give the same
    /// answers, lengths and order. The hashes come from a few clustered
    /// values, around `i32::MAX` too (the slots wrap), so probe runs are
    /// long and overlap, and a class's keys hash to one of two values. Half
    /// the sequences give every key the same deep hash.
    #[test]
    fn equality_map_answers_as_the_walk_does() {
        for seed in 0..600 {
            let coarse = seed % 2 == 1;
            let mut next = rng(seed);
            let bases = [0i64, 5, 9, i64::from(i32::MAX) - 3, i64::from(i32::MIN), -7];
            let classes = 1 + next(60) as u32;
            let hash_of = |class: u32, alt: bool| {
                let b = bases[(class as usize * 7 + usize::from(alt)) % bases.len()];
                b + i64::from(class % 4) + if alt { 1 << 32 } else { 0 }
            };
            let mut new: EqualityMap<Key, u64> = EqualityMap::new();
            let mut old: WalkingEqualityMap<Key, u64> = WalkingEqualityMap {
                map: IndexMap::default(),
            };
            for op in 0..400u64 {
                let class = next(u64::from(classes)) as u32;
                // A different hash for the same class now and then; the
                // `1 << 32` keeps `| 0` the same for some of them.
                let alt = next(4) == 0;
                let skew = if next(5) == 0 { next(3) as i64 } else { 0 };
                let k = Key {
                    class,
                    hash: hash_of(class, alt) + skew,
                    coarse,
                };
                match next(3) {
                    0 => {
                        new.set(k.clone(), op);
                        old.set(k, op);
                    }
                    1 => assert_eq!(new.get(&k), old.get(&k), "seed {seed}, op {op}"),
                    _ => {
                        if let Some(v) = new.get_mut(&k) {
                            *v += 1000;
                        }
                        if let Some(v) = old.get_mut(&k) {
                            *v += 1000;
                        }
                    }
                }
                assert_eq!(new.len(), old.map.len());
            }
            assert!(
                new.values().eq(old.map.values().map(|(_, v)| v)),
                "seed {seed}"
            );
        }
    }

    /// With one deep hash for all of them, keys in short probe runs (two
    /// per slot) cost a few comparisons each: a lookup visits only the
    /// candidates in its own run.
    #[test]
    fn a_coarse_deep_hash_costs_only_within_a_run() {
        let n = 20_000u32;
        let key = |class: u32| Key {
            class,
            hash: i64::from(class / 2 * 5),
            coarse: true,
        };
        let mut map: EqualityMap<Key, u32> = EqualityMap::without_check();
        COMPARISONS.set(0);
        for class in 0..n {
            map.set(key(class), class);
        }
        for class in 0..n {
            assert_eq!(map.get(&key(class)), Some(&class));
        }
        assert_eq!(map.get(&key(n + 1)), None);
        let per_operation = COMPARISONS.get() as f64 / f64::from(2 * n);
        assert!(
            per_operation < 2.0,
            "{per_operation} comparisons per operation"
        );
    }

    /// Strings whose `hashString`s all collide ("Aa" and "BB" hash alike,
    /// and so does every string of them): the same slots and order as the
    /// walk, and 2^14 of them without the quadratic walk.
    #[test]
    fn equality_map_with_colliding_strings() {
        let colliding = |n: usize, bits: u32| -> Vec<String> {
            (0..n)
                .map(|i| {
                    (0..bits)
                        .map(|b| if i >> b & 1 == 0 { "Aa" } else { "BB" })
                        .collect()
                })
                .collect()
        };
        let keys = colliding(1 << 10, 10);
        assert!(keys.iter().all(|k| hash_string(k) == hash_string(&keys[0])));
        let mut new: EqualityMap<String, usize> = EqualityMap::new();
        let mut old: WalkingEqualityMap<String, usize> = WalkingEqualityMap {
            map: IndexMap::default(),
        };
        for (i, k) in keys.iter().chain(keys.iter().step_by(3)).enumerate() {
            new.set(k.clone(), i);
            old.set(k.clone(), i);
        }
        assert!(new.values().eq(old.map.values().map(|(_, v)| v)));
        assert!(keys.iter().all(|k| new.get(k) == old.get(k)));

        let many = colliding(1 << 14, 14);
        let mut map: EqualityMap<String, usize> = EqualityMap::without_check();
        for (i, k) in many.iter().enumerate() {
            map.set(k.clone(), i);
        }
        for (i, k) in many.iter().enumerate() {
            assert_eq!(map.get(k), Some(&i));
        }
        assert_eq!(map.len(), many.len());
        assert!(map.values().copied().eq(0..many.len()));
    }

    #[test]
    fn sets_and_maps_compare_order_insensitively() {
        let a: IndexSet<u32> = [1, 2, 3].into_iter().collect();
        let b: IndexSet<u32> = [3, 1, 2].into_iter().collect();
        assert!(a.js_equals(&b));
        assert_eq!(a.hash_code(), b.hash_code());
        assert_eq!(a.hash_code(), 23);
        let m1: IndexMap<String, u32> = [("a".into(), 1), ("b".into(), 2)].into_iter().collect();
        let m2: IndexMap<String, u32> = [("b".into(), 2), ("a".into(), 1)].into_iter().collect();
        assert!(m1.js_equals(&m2));
        assert_eq!(m1.hash_code(), m2.hash_code());
        assert_eq!(
            vec![1u32, 2].hash_code(),
            add_hash_code(add_hash_code(17, 1), 2)
        );
    }

    #[test]
    fn map_sort_uses_utf16_order() {
        let m: IndexMap<String, u32> = [
            ("\u{FF5E}".to_owned(), 1),
            ("\u{1F600}".to_owned(), 2),
            ("a".to_owned(), 3),
        ]
        .into_iter()
        .collect();
        let sorted: Vec<String> = map_sort_by_key(&m).into_keys().collect();
        assert_eq!(sorted, vec!["a", "\u{1F600}", "\u{FF5E}"]);
    }

    #[test]
    fn merges_keep_slots() {
        let mut a: IndexMap<&str, u32> = [("b", 1), ("a", 2)].into_iter().collect();
        let b: IndexMap<&str, u32> = [("c", 3), ("b", 4)].into_iter().collect();
        map_merge_into(&mut a, &b);
        assert_eq!(
            a.into_iter().collect::<Vec<_>>(),
            vec![("b", 4), ("a", 2), ("c", 3)]
        );
    }
}

/// `mapSortBy`/`setSortBy`/`arraySortByInto` with a string sort key that
/// may fail: computes each key once, then sorts stably by the keys in
/// UTF-16 code unit order. For pure key functions this is exactly the
/// JavaScript result, which recomputes the key on every comparison; like
/// JavaScript, fewer than two items are returned without computing keys.
pub fn sort_by_cached_string_key<T, E>(
    items: Vec<T>,
    mut key: impl FnMut(&T) -> Result<String, E>,
) -> Result<Vec<T>, E> {
    if items.len() < 2 {
        return Ok(items);
    }
    let mut keyed: Vec<(String, T)> = Vec::with_capacity(items.len());
    for item in items {
        keyed.push((key(&item)?, item));
    }
    sort_by(&mut keyed, |a, b| compare_utf16(&a.0, &b.0));
    Ok(keyed.into_iter().map(|(_, item)| item).collect())
}

/// How a JavaScript `Map` or `Set` compares a key (SameValueZero): see
/// [`SameValueZeroKey`].
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub enum SameValueZero {
    /// A string, compared by value.
    String(String),
    /// A number, compared by value; all NaNs are one key and `-0` is `0`.
    Number(u64),
    /// A boolean.
    Bool(bool),
    /// An object identified by an id (e.g. a `Name`): equal to itself only.
    Identity(u64),
    /// A fresh object (an array, a sourcelike tree): equal to nothing.
    Unique,
}

/// A value usable as a JavaScript `Map` key, compared like JavaScript does
/// (SameValueZero): primitives by value, objects by identity. Wrap a value
/// that stands for a fresh JavaScript object or array in [`JsObject`].
pub trait SameValueZeroKey {
    /// The key this value is compared by.
    fn same_value_zero_key(&self) -> SameValueZero;
}

impl SameValueZeroKey for String {
    fn same_value_zero_key(&self) -> SameValueZero {
        SameValueZero::String(self.clone())
    }
}

impl SameValueZeroKey for &str {
    fn same_value_zero_key(&self) -> SameValueZero {
        SameValueZero::String((*self).to_owned())
    }
}

impl SameValueZeroKey for f64 {
    fn same_value_zero_key(&self) -> SameValueZero {
        if self.is_nan() {
            SameValueZero::Number(f64::NAN.to_bits())
        } else if *self == 0.0 {
            SameValueZero::Number(0f64.to_bits())
        } else {
            SameValueZero::Number(self.to_bits())
        }
    }
}

impl SameValueZeroKey for usize {
    fn same_value_zero_key(&self) -> SameValueZero {
        (*self as f64).same_value_zero_key()
    }
}

impl SameValueZeroKey for i64 {
    fn same_value_zero_key(&self) -> SameValueZero {
        (*self as f64).same_value_zero_key()
    }
}

impl SameValueZeroKey for bool {
    fn same_value_zero_key(&self) -> SameValueZero {
        SameValueZero::Bool(*self)
    }
}

/// A value that is a fresh JavaScript object or array: as a `Map` key it
/// equals nothing, not even an equal-looking value.
#[derive(Clone, Debug)]
pub struct JsObject<T>(pub T);

impl<T> SameValueZeroKey for JsObject<T> {
    fn same_value_zero_key(&self) -> SameValueZero {
        SameValueZero::Unique
    }
}

/// A JavaScript `Map` built with `if (!m.has(k)) m.set(k, v)`: the first
/// value for each key (SameValueZero), in insertion order.
pub fn first_by_same_value_zero<K: SameValueZeroKey, V>(
    entries: impl IntoIterator<Item = (K, V)>,
) -> Vec<(K, V)> {
    let mut seen: crate::support::fast_hash::HashSet<SameValueZero> =
        crate::support::fast_hash::HashSet::default();
    let mut result = Vec::new();
    for (k, v) in entries {
        let key = k.same_value_zero_key();
        if key == SameValueZero::Unique || seen.insert(key) {
            result.push((k, v));
        }
    }
    result
}

#[cfg(test)]
mod renderer_helper_tests {
    use super::*;

    #[test]
    fn sorts_by_cached_utf16_keys_stably() {
        let items = vec!["b1", "a", "b2", "\u{ff61}", "😀"];
        let sorted = sort_by_cached_string_key(items, |s| {
            Ok::<_, ()>(s.chars().next().unwrap().to_string())
        })
        .unwrap();
        assert_eq!(sorted, ["a", "b1", "b2", "😀", "\u{ff61}"]);
        let failed = sort_by_cached_string_key(vec![1, 2], |_| Err::<String, _>("no key"));
        assert_eq!(failed, Err("no key"));
    }

    #[test]
    fn intercalates_a_separator() {
        assert_eq!(array_intercalate(0, Vec::<i32>::new()), Vec::<i32>::new());
        assert_eq!(array_intercalate(0, [1]), [1]);
        assert_eq!(array_intercalate(0, [1, 2, 3]), [1, 0, 2, 0, 3]);
    }

    #[test]
    fn map_keys_compare_like_same_value_zero() {
        let firsts = first_by_same_value_zero(vec![
            ("a".to_owned(), 1),
            ("a".to_owned(), 2),
            ("b".to_owned(), 3),
        ]);
        assert_eq!(firsts, [("a".to_owned(), 1), ("b".to_owned(), 3)]);
        let numbers =
            first_by_same_value_zero(vec![(0.0, 1), (-0.0, 2), (f64::NAN, 3), (f64::NAN, 4)]);
        assert_eq!(numbers.iter().map(|(_, v)| *v).collect::<Vec<_>>(), [1, 3]);
        let objects = first_by_same_value_zero(vec![(JsObject("a"), 1), (JsObject("a"), 2)]);
        assert_eq!(objects.len(), 2);
    }
}
