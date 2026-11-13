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
//!   first-insertion order.
//!
//! JavaScript `Set`/`Map` map to `IndexSet`/`IndexMap`, which iterate in
//! insertion order like their JavaScript counterparts. The order-sensitive
//! combinators that are not one-liners on `IndexSet`/`IndexMap` are ported
//! below.

use std::cmp::Ordering;
use std::hash::Hash;

use indexmap::{IndexMap, IndexSet};

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

/// `EqualityMap<K, V>`: a map keyed by structural equality.
///
/// Like the JavaScript original it is a hash-indexed map with linear probing,
/// so which entry a lookup finds depends on the exact hash values and on
/// insertion order. `set` on an equal key overwrites the value in place;
/// iteration is in first-insertion order.
#[derive(Clone, Debug)]
pub struct EqualityMap<K, V> {
    map: IndexMap<i32, (K, V)>,
}

impl<K, V> Default for EqualityMap<K, V> {
    fn default() -> Self {
        EqualityMap {
            map: IndexMap::new(),
        }
    }
}

impl<K: JsHash + JsEquals, V> EqualityMap<K, V> {
    /// An empty map.
    pub fn new() -> Self {
        Self::default()
    }

    /// `set(k, v)`.
    pub fn set(&mut self, k: K, v: V) {
        let mut h = int32(k.hash_code());
        loop {
            match self.map.get_mut(&h) {
                None => {
                    self.map.insert(h, (k, v));
                    return;
                }
                Some(kvp) if k.js_equals(&kvp.0) => {
                    kvp.1 = v;
                    return;
                }
                Some(_) => h = h.wrapping_add(1),
            }
        }
    }

    /// `get(k)`.
    pub fn get(&self, k: &K) -> Option<&V> {
        let mut h = int32(k.hash_code());
        loop {
            match self.map.get(&h) {
                None => return None,
                Some(kvp) if k.js_equals(&kvp.0) => return Some(&kvp.1),
                Some(_) => h = h.wrapping_add(1),
            }
        }
    }

    /// The value for a key equal to `k`, mutably (the JavaScript code
    /// mutates the stored value object in place).
    pub fn get_mut(&mut self, k: &K) -> Option<&mut V> {
        let mut h = int32(k.hash_code());
        loop {
            match self.map.get(&h) {
                None => return None,
                Some(kvp) if k.js_equals(&kvp.0) => break,
                Some(_) => h = h.wrapping_add(1),
            }
        }
        self.map.get_mut(&h).map(|kvp| &mut kvp.1)
    }

    /// `has(k)`.
    pub fn has(&self, k: &K) -> bool {
        self.get(k).is_some()
    }

    /// `values()`, in first-insertion order.
    pub fn values(&self) -> impl Iterator<Item = &V> {
        self.map.values().map(|(_, v)| v)
    }

    /// The number of entries.
    pub fn len(&self) -> usize {
        self.map.len()
    }

    /// Whether the map is empty.
    pub fn is_empty(&self) -> bool {
        self.map.is_empty()
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
