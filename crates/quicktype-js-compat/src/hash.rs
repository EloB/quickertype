//! The hasher of quickertype's hash maps and sets, and the maps and sets
//! that use it.
//!
//! The keys of these maps come from the input: class properties, enum and
//! string cases, JSON object keys. So the seed has to be secret. Whoever
//! knows it can write JSON whose keys all land in one bucket, and reading
//! it then takes quadratic time. [`SeededState`] is foldhash with a secret
//! seed, and every `IndexMap`, `IndexSet`, `HashMap` and `HashSet` uses it:
//!
//! - [`IndexMap`] and [`IndexSet`] iterate in insertion order whatever the
//!   hasher, so their order is output (docs/PARITY.md, rule 1).
//! - [`HashMap`] and [`HashSet`] iterate in an order that depends on the
//!   seed, so it changes from run to run. That order must never reach
//!   output; use them only for lookups.
//!
//! Nothing else may make a map. Make them with `default()`,
//! [`index_map_with_capacity`], `collect()`, or a map's own hasher
//! (`with_capacity_and_hasher(n, map.hasher().clone())`) for a copy with
//! the same keys. clippy's `disallowed-types` and `disallowed-methods`
//! (clippy.toml) reject `std`'s maps, its `RandomState` and
//! `DefaultHasher`, indexmap's own types and their `RandomState`
//! constructors, and foldhash's own states, everywhere but here. indexmap
//! is built without `std` (nothing in the tree turns it on, tests
//! included), so its types have no `RandomState` default at all.
//!
//! Where the seed comes from:
//!
//! - **Natively:** `std`'s `RandomState`, which takes its keys from the
//!   operating system's random source, gives 16 bytes once per process.
//!   The hash is still foldhash, a fast hash with a secret seed, not a
//!   keyed pseudorandom function like SipHash. The `siphash` feature makes
//!   [`SeededState`] `std`'s `RandomState` (SipHash-1-3) natively, for an
//!   embedder that hashes untrusted input on a server and wants that.
//! - **In WebAssembly with the `js-host-random` feature** (the npm
//!   package's engine): 16 bytes of the JavaScript host's
//!   `crypto.getRandomValues`, per instance. A host must call [`init`] when
//!   it starts and handle its error (the bindings fail the module's start
//!   with it). Otherwise the first map takes the seed, and on a host
//!   without `crypto.getRandomValues` that panics in the middle of a run.
//! - **In WebAssembly without it:** the entropy an embedder gives [`seed`]
//!   before any other use of this crate or of quickertype-core. Failing
//!   that, `std`'s `RandomState`, which is random on WASI. On
//!   `wasm32-unknown-unknown` it is made of addresses that are the same in
//!   every instance.
//!
//! The 16 bytes become foldhash's shared seed and the start of a sequence
//! that gives each map a seed of its own.
//!
//! quickertype-core re-exports all of this as `support::fast_hash`.

// The one module that names the maps' own types and hashers (clippy.toml).
#![allow(clippy::disallowed_types, clippy::disallowed_methods)]

use std::hash::{BuildHasher, Hasher};

/// [`indexmap::IndexMap`] with [`SeededState`].
pub type IndexMap<K, V> = indexmap::IndexMap<K, V, SeededState>;

/// [`indexmap::IndexSet`] with [`SeededState`].
pub type IndexSet<T> = indexmap::IndexSet<T, SeededState>;

/// [`std::collections::HashMap`] with [`SeededState`]: for lookups only.
pub type HashMap<K, V> = std::collections::HashMap<K, V, SeededState>;

/// [`std::collections::HashSet`] with [`SeededState`]: for lookups only.
pub type HashSet<T> = std::collections::HashSet<T, SeededState>;

/// An empty [`IndexMap`] with room for `n` entries and a seed of its own.
pub fn index_map_with_capacity<K, V>(n: usize) -> IndexMap<K, V> {
    IndexMap::with_capacity_and_hasher(n, SeededState::default())
}

/// The hasher of every map and set, seeded as the module says.
/// `default()` gives each map a seed of its own; a clone keeps it.
#[derive(Clone, Debug, Default)]
pub struct SeededState(Inner);

#[cfg(seeded_foldhash)]
type Inner = seeded::RandomState;

/// With `siphash`, natively: `std`'s SipHash-1-3, keyed from the operating
/// system's random source.
#[cfg(not(seeded_foldhash))]
type Inner = std::hash::RandomState;

#[cfg(seeded_foldhash)]
type InnerHasher = foldhash::fast::FoldHasher<'static>;

#[cfg(not(seeded_foldhash))]
type InnerHasher = std::hash::DefaultHasher;

impl BuildHasher for SeededState {
    type Hasher = InnerHasher;

    #[inline]
    fn build_hasher(&self) -> Self::Hasher {
        self.0.build_hasher()
    }
}

/// The hasher of a table that hashes its strings itself (hashbrown's
/// `HashTable`: quickertype-core's JSON reader's string and key tables),
/// where each hash is of one whole string. It hashes strings in one way
/// only, so that a table cannot mix two kinds of hash (and then miss what
/// it holds).
#[derive(Clone, Debug, Default)]
pub struct StrHasher(SeededState);

impl StrHasher {
    /// The hash of `s`: what foldhash's own `write_str` does with its
    /// `nightly` feature (`write` mixes the length in; SipHash's `finish`
    /// does too).
    ///
    /// `Hash for str` also writes a marker after the bytes, to keep a
    /// string apart from what follows it in a longer key. foldhash adds the
    /// marker through a 128-bit buffer and one more multiply; in
    /// WebAssembly that is four multiplies and a call to shift the buffer.
    /// A lone string does not need it.
    #[inline]
    pub fn hash_str(&self, s: &str) -> u64 {
        hash_whole_str(&self.0, s)
    }
}

/// [`StrHasher::hash_str`] with any hasher, for its tests.
#[inline]
fn hash_whole_str(state: &impl BuildHasher, s: &str) -> u64 {
    let mut hasher = state.build_hasher();
    hasher.write(s.as_bytes());
    hasher.finish()
}

/// Takes the maps' seed now, rather than when the first map is made.
///
/// In WebAssembly with the `js-host-random` feature, a host must call this
/// when it starts and handle its error: a host without
/// `crypto.getRandomValues`, or one where it throws (the error names which,
/// with what it threw). The `quicktype-wasm` bindings fail the module's
/// start with it. Elsewhere it does not fail.
pub fn init() -> Result<(), String> {
    #[cfg(seeded_foldhash)]
    return seeded::try_seeds().map(|_| ());
    #[cfg(not(seeded_foldhash))]
    Ok(())
}

/// Seeds the maps with `entropy`, which must be random and secret, instead
/// of the host's randomness: for an embedder with a source of its own (a
/// `wasm32-unknown-unknown` host without `js-host-random`, whose fallback is
/// fixed). quickertype-core re-exports it as `support::fast_hash::seed`.
///
/// In WebAssembly, call it before any other use of this crate or of
/// quickertype-core, and before [`init`]. Every map and set takes its seed
/// when it is made, and nearly everything makes one: parsing JSON
/// ([`crate::json`]), YAML, building quickertype-core's `Options`. Called
/// after the first map, it panics, because the maps made so far were
/// seeded already. Natively the seed always comes from the operating
/// system, and this does nothing.
pub fn seed(entropy: [u64; 2]) {
    #[cfg(target_arch = "wasm32")]
    seeded::seed(entropy);
    #[cfg(not(target_arch = "wasm32"))]
    let _ = entropy;
}

/// foldhash with seeds from the host's randomness: [`SeededState`]'s
/// hasher, but natively with the `siphash` feature (built there too, for
/// its tests).
#[cfg_attr(not(seeded_foldhash), allow(dead_code))]
mod seeded {
    use std::sync::OnceLock;
    use std::sync::atomic::{AtomicU64, Ordering};

    use foldhash::SharedSeed;
    use foldhash::fast::{FoldHasher, SeedableRandomState};

    pub(super) struct Seeds {
        /// The seed every map shares.
        shared: SharedSeed,
        /// The state of the sequence the maps' own seeds come from.
        next: AtomicU64,
    }

    impl Seeds {
        pub(super) fn new([shared, next]: [u64; 2]) -> Seeds {
            Seeds {
                shared: SharedSeed::from_u64(shared),
                next: AtomicU64::new(next),
            }
        }
    }

    /// Set once: by [`seed`], [`init`](super::init) or the first map,
    /// whichever comes first.
    static SEEDS: OnceLock<Seeds> = OnceLock::new();

    /// The seeds, taken from the host the first time.
    pub(super) fn try_seeds() -> Result<&'static Seeds, String> {
        if let Some(seeds) = SEEDS.get() {
            return Ok(seeds);
        }
        let entropy = entropy()?;
        Ok(SEEDS.get_or_init(|| Seeds::new(entropy)))
    }

    /// [`super::seed`], which only WebAssembly takes.
    #[cfg(any(target_arch = "wasm32", test))]
    pub(super) fn seed(entropy: [u64; 2]) {
        if SEEDS.set(Seeds::new(entropy)).is_err() {
            panic!(
                "quicktype_js_compat::hash::seed (quicktype_core::support::fast_hash::seed) was \
                 called after the hash maps were seeded. Call it first, before anything else \
                 uses quickertype-js-compat or quickertype-core (parsing JSON or building \
                 Options makes maps too), and before init()"
            );
        }
    }

    /// 16 bytes of the JavaScript host's `crypto.getRandomValues`.
    #[cfg(all(target_arch = "wasm32", feature = "js-host-random"))]
    pub(super) fn entropy() -> Result<[u64; 2], String> {
        let mut bytes = [0; 16];
        if let Err(error) = host::get_random_values(&mut bytes) {
            return Err(if host::has_get_random_values() {
                format!(
                    "quickertype could not seed its hash maps: crypto.getRandomValues threw {}",
                    host::describe(&error)
                )
            } else {
                "quickertype needs crypto.getRandomValues (the Web Crypto API) to seed its hash \
                 maps, and this JavaScript host does not have it"
                    .to_owned()
            });
        }
        let entropy = u128::from_le_bytes(bytes);
        Ok([entropy as u64, (entropy >> 64) as u64])
    }

    /// Without a JavaScript host: two hashes of a fresh `std`
    /// `RandomState`, which is keyed from the operating system's random
    /// source natively and on WASI, and fixed on `wasm32-unknown-unknown`.
    #[cfg(not(all(target_arch = "wasm32", feature = "js-host-random")))]
    pub(super) fn entropy() -> Result<[u64; 2], String> {
        use std::hash::BuildHasher as _;
        let state = std::hash::RandomState::new();
        Ok([state.hash_one(0u8), state.hash_one(1u8)])
    }

    #[cfg(all(target_arch = "wasm32", feature = "js-host-random"))]
    mod host {
        use wasm_bindgen::prelude::{JsValue, wasm_bindgen};

        #[wasm_bindgen]
        extern "C" {
            /// `crypto.getRandomValues(array)`.
            #[wasm_bindgen(js_namespace = crypto, js_name = getRandomValues, catch)]
            pub(super) fn get_random_values(array: &mut [u8]) -> Result<(), JsValue>;

            #[wasm_bindgen(thread_local_v2, js_name = globalThis)]
            static GLOBAL_THIS: JsValue;

            #[wasm_bindgen(js_namespace = Reflect, js_name = get, catch)]
            fn reflect_get(target: &JsValue, key: &JsValue) -> Result<JsValue, JsValue>;
        }

        /// Whether the host has `crypto.getRandomValues` at all (rather
        /// than one that throws).
        pub(super) fn has_get_random_values() -> bool {
            let get = |target: &JsValue, key: &str| {
                reflect_get(target, &JsValue::from_str(key))
                    .ok()
                    .filter(|value| !value.is_undefined() && !value.is_null())
            };
            GLOBAL_THIS
                .with(|global| get(global, "crypto"))
                .and_then(|crypto| get(&crypto, "getRandomValues"))
                .is_some_and(|f| f.is_function())
        }

        /// The first line of what JavaScript says of `error` (`TypeError:
        /// …` for an exception).
        pub(super) fn describe(error: &JsValue) -> String {
            let text = format!("{error:?}");
            let text = text
                .strip_prefix("JsValue(")
                .and_then(|t| t.strip_suffix(')'))
                .unwrap_or(&text);
            text.lines().next().unwrap_or_default().to_owned()
        }
    }

    /// The hasher of maps with these seeds: each map's own seed is the next
    /// of a sequence that starts at a secret.
    #[derive(Clone, Debug)]
    pub(super) struct RandomState(SeedableRandomState);

    impl RandomState {
        pub(super) fn with_seeds(seeds: &'static Seeds) -> RandomState {
            // splitmix64: a Weyl sequence, each step mixed, so that one map's
            // seed does not tell another's.
            let mut z = seeds
                .next
                .fetch_add(0x9e37_79b9_7f4a_7c15, Ordering::Relaxed);
            z = (z ^ (z >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
            z = (z ^ (z >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
            z ^= z >> 31;
            RandomState(SeedableRandomState::with_seed(z, &seeds.shared))
        }
    }

    impl Default for RandomState {
        // Not inlined: maps are made in hundreds of places, and a call is
        // cheap next to making one.
        #[inline(never)]
        fn default() -> Self {
            match try_seeds() {
                Ok(seeds) => RandomState::with_seeds(seeds),
                Err(error) => panic!(
                    "{error}. With the `js-host-random` feature, a host must call \
                     quicktype_js_compat::hash::init() (quicktype_core::support::fast_hash::init()) \
                     when it starts, and handle its error, before anything makes a hash map"
                ),
            }
        }
    }

    impl std::hash::BuildHasher for RandomState {
        type Hasher = FoldHasher<'static>;

        #[inline]
        fn build_hasher(&self) -> FoldHasher<'static> {
            self.0.build_hasher()
        }
    }
}

#[cfg(test)]
mod tests {
    use std::hash::BuildHasher as _;

    use super::seeded::{RandomState, Seeds};
    use super::{HashMap, HashSet, IndexMap, IndexSet, SeededState, StrHasher};

    fn seeds(entropy: [u64; 2]) -> &'static Seeds {
        Box::leak(Box::new(Seeds::new(entropy)))
    }

    #[test]
    fn a_seeded_map_hashes_consistently() {
        let state = RandomState::with_seeds(seeds([1, 2]));
        assert_eq!(state.hash_one("key"), state.hash_one("key"));
        assert_ne!(state.hash_one("key"), state.hash_one("kez"));
        let mut map = std::collections::HashMap::with_hasher(state);
        for i in 0..1000 {
            map.insert(i.to_string(), i);
        }
        assert!((0..1000).all(|i| map[&i.to_string()] == i));
    }

    #[test]
    fn the_seed_reaches_the_hash() {
        let a = RandomState::with_seeds(seeds([1, 2]));
        let b = RandomState::with_seeds(seeds([3, 2]));
        let c = RandomState::with_seeds(seeds([1, 4]));
        assert_ne!(a.hash_one("key"), b.hash_one("key"));
        assert_ne!(a.hash_one("key"), c.hash_one("key"));
    }

    #[test]
    fn maps_of_one_seed_differ() {
        let shared = seeds([1, 2]);
        let a = RandomState::with_seeds(shared);
        let b = RandomState::with_seeds(shared);
        assert_ne!(a.hash_one("key"), b.hash_one("key"));
    }

    #[test]
    fn the_same_seeds_make_the_same_maps() {
        let a = RandomState::with_seeds(seeds([5, 6]));
        let b = RandomState::with_seeds(seeds([5, 6]));
        assert_eq!(a.hash_one("key"), b.hash_one("key"));
    }

    #[test]
    fn without_a_javascript_host_the_entropy_is_std_s() {
        // Natively, as on WASI, std's RandomState is random: two draws
        // differ.
        assert_ne!(super::seeded::entropy(), super::seeded::entropy());
    }

    #[test]
    fn seeding_after_the_maps_were_seeded_panics() {
        super::seeded::try_seeds().unwrap();
        let late = std::panic::catch_unwind(|| super::seeded::seed([1, 2]));
        assert!(late.is_err());
    }

    #[test]
    fn unseeded_maps_work() {
        let state = RandomState::default();
        assert_eq!(state.hash_one(17u32), state.hash_one(17u32));
        assert_eq!(super::init(), Ok(()));
    }

    /// The strings the reader's tables must tell apart: prefixes, zero
    /// bytes, lengths around foldhash's 8- and 16-byte steps, and two
    /// spellings of `é`.
    const TEXTS: [&str; 14] = [
        "",
        "\0",
        "\0\0",
        "a",
        "ab",
        "abb",
        "abcd",
        "abcdabcd",
        "abcdefgh",
        "abcdefghi",
        "abcdefghabcdefgh",
        "abcdefghabcdefghX",
        "\u{e9}",
        "e\u{301}",
    ];

    fn tells_texts_apart(hash: &dyn Fn(&str) -> u64) {
        let hashes: std::collections::HashSet<u64> = TEXTS.iter().map(|t| hash(t)).collect();
        assert_eq!(hashes.len(), TEXTS.len());
        assert!(TEXTS.iter().all(|t| hash(t) == hash(t)));
    }

    /// `hash_str` on what each target uses: this build's [`StrHasher`], and
    /// explicitly the seeded state (WebAssembly's, and natively without
    /// `siphash`), with two seeds, whose hashes differ.
    #[test]
    fn hash_str_tells_texts_apart() {
        let tables = StrHasher::default();
        tells_texts_apart(&|t| tables.hash_str(t));
        let seeded = RandomState::with_seeds(seeds([7, 8]));
        tells_texts_apart(&|t| super::hash_whole_str(&seeded, t));
        let other = RandomState::with_seeds(seeds([9, 8]));
        tells_texts_apart(&|t| super::hash_whole_str(&other, t));
        assert!(
            TEXTS
                .iter()
                .all(|t| super::hash_whole_str(&seeded, t) != super::hash_whole_str(&other, t))
        );
    }

    /// Every alias is seeded: its hasher is [`SeededState`] (the
    /// annotations fail to compile otherwise), and two maps of one type
    /// hash the same key differently, which `std`'s `RandomState` does too
    /// but a fixed hasher does not.
    #[test]
    fn the_aliases_are_seeded() {
        fn differs(make: impl Fn() -> SeededState) -> bool {
            // Each map's own seed differs, so 8 maps hashing alike would
            // mean a fixed seed (chance: 2^-448).
            let first = make().hash_one("key");
            (0..8).any(|_| make().hash_one("key") != first)
        }
        assert!(differs(|| {
            let map: IndexMap<String, u32> = IndexMap::default();
            let hasher: &SeededState = map.hasher();
            hasher.clone()
        }));
        assert!(differs(|| {
            let set: IndexSet<String> = IndexSet::default();
            set.hasher().clone()
        }));
        assert!(differs(|| {
            let map: HashMap<String, u32> = HashMap::default();
            map.hasher().clone()
        }));
        assert!(differs(|| {
            let set: HashSet<String> = HashSet::default();
            set.hasher().clone()
        }));
        assert!(differs(|| super::index_map_with_capacity::<String, u32>(4)
            .hasher()
            .clone()));
        // A clone keeps the seed, so a cloned map still finds its keys.
        let mut map: IndexMap<String, u32> = (0..100).map(|i| (i.to_string(), i)).collect();
        let copy = map.clone();
        map.insert("100".to_owned(), 100);
        assert!((0..100).all(|i| copy[&i.to_string()] == i && map[&i.to_string()] == i));
        assert_eq!(
            copy.hasher().hash_one("key"),
            copy.clone().hasher().hash_one("key")
        );
    }

    /// Insertion order, not the seed, orders an `IndexMap`: two maps with
    /// different seeds iterate alike.
    #[test]
    fn index_maps_iterate_in_insertion_order_whatever_the_seed() {
        let keys: Vec<String> = (0..500)
            .map(|i| format!("k{}", (i * 7919) % 1000))
            .collect();
        let a: IndexSet<&str> = keys.iter().map(String::as_str).collect();
        let b: IndexSet<&str> = keys.iter().map(String::as_str).collect();
        assert_ne!(a.hasher().hash_one("k1"), b.hasher().hash_one("k1"));
        assert!(a.iter().eq(b.iter()));
        assert!(a.iter().copied().eq(keys.iter().map(String::as_str)));
    }
}
