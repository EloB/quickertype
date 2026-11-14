//! Hash maps and sets for lookups only.
//!
//! `std`'s default hasher (SipHash-1-3) was 10% of the engine's time. These
//! aliases use foldhash instead. Iterating them visits the entries in an
//! arbitrary order, exactly like `std`'s maps, so the rule stands: their
//! iteration order must never reach output (docs/PARITY.md, rule 1); use
//! `IndexMap`/`IndexSet` for that.
//!
//! The seed has to be secret because the keys come from the input: whoever
//! knows it can write JSON whose keys all land in one bucket, and reading it
//! then takes quadratic time. Where the seed comes from:
//!
//! - **Natively:** foldhash's own, from address space layout randomization
//!   and the clock, per process.
//! - **In WebAssembly with the `js-host-random` feature** (the npm
//!   package's engine): 16 bytes of the JavaScript host's
//!   `crypto.getRandomValues`, per instance. A host must call [`init`] when
//!   it starts and handle its error (the bindings fail the module's start
//!   with it). Otherwise the first map takes the seed, and on a host without
//!   `crypto.getRandomValues` that panics in the middle of a run.
//! - **In WebAssembly without it:** the entropy an embedder gives [`seed`]
//!   before the first map; failing that, `std`'s `RandomState`, which is
//!   random on WASI but on `wasm32-unknown-unknown` is made of addresses
//!   that are the same in every instance (as foldhash's own seed is there).
//!
//! In WebAssembly the maps are foldhash with these seeds: a shared seed,
//! and a sequence that gives each map its own.

/// The hasher of [`HashMap`] and [`HashSet`].
#[cfg(not(target_arch = "wasm32"))]
pub type BuildHasher = foldhash::fast::RandomState;

/// The hasher of [`HashMap`] and [`HashSet`].
#[cfg(target_arch = "wasm32")]
pub type BuildHasher = seeded::RandomState;

/// [`std::collections::HashMap`] with [`BuildHasher`].
pub type HashMap<K, V> = std::collections::HashMap<K, V, BuildHasher>;

/// [`std::collections::HashSet`] with [`BuildHasher`].
pub type HashSet<T> = std::collections::HashSet<T, BuildHasher>;

/// The hasher of a table that hashes its strings itself (hashbrown's
/// `HashTable`: the JSON reader's string and key tables), where each hash
/// is of one whole string. It hashes strings in one way only, so that a
/// table cannot mix two kinds of hash (and then miss what it holds).
#[derive(Clone, Debug, Default)]
pub(crate) struct StrHasher(BuildHasher);

impl StrHasher {
    /// The hash of `s`: what foldhash's own `write_str` does with its
    /// `nightly` feature (`write` mixes the length in).
    ///
    /// `Hash for str` also writes a marker after the bytes, to keep a
    /// string apart from what follows it in a longer key. foldhash adds the
    /// marker through a 128-bit buffer and one more multiply; in
    /// WebAssembly that is four multiplies and a call to shift the buffer.
    /// A lone string does not need it.
    #[inline]
    pub(crate) fn hash_str(&self, s: &str) -> u64 {
        use std::hash::{BuildHasher as _, Hasher as _};
        let mut hasher = self.0.build_hasher();
        hasher.write(s.as_bytes());
        hasher.finish()
    }
}

/// Takes the maps' seed now, rather than when the first map is made.
///
/// In WebAssembly with the `js-host-random` feature, a host must call this
/// when it starts and handle its error: a host without
/// `crypto.getRandomValues`, or one where it throws (the error names which,
/// with what it threw). The `quicktype-wasm` bindings fail the module's
/// start with it. Elsewhere it does not fail, and natively it does nothing.
pub fn init() -> Result<(), String> {
    #[cfg(target_arch = "wasm32")]
    return seeded::try_seeds().map(|_| ());
    #[cfg(not(target_arch = "wasm32"))]
    Ok(())
}

/// Seeds the maps with `entropy`, which must be random and secret, instead
/// of the host's randomness: for an embedder with a source of its own (a
/// `wasm32-unknown-unknown` host without `js-host-random`, whose fallback is
/// fixed). In WebAssembly it must come before the first map and before
/// [`init`]; called later, it panics, because the maps made so far were
/// seeded already. Natively the seed is foldhash's own, and this does
/// nothing.
pub fn seed(entropy: [u64; 2]) {
    #[cfg(target_arch = "wasm32")]
    seeded::seed(entropy);
    #[cfg(not(target_arch = "wasm32"))]
    let _ = entropy;
}

/// foldhash with seeds from the host's randomness: the WebAssembly build's
/// [`BuildHasher`]. (Built everywhere, for its tests.)
#[cfg_attr(not(target_arch = "wasm32"), allow(dead_code))]
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

    /// [`super::seed`].
    pub(super) fn seed(entropy: [u64; 2]) {
        if SEEDS.set(Seeds::new(entropy)).is_err() {
            panic!(
                "quicktype_core::support::fast_hash::seed was called after the hash maps were \
                 seeded: call it before anything makes a map, and before fast_hash::init()"
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
                    "quickertype-core could not seed its hash maps: crypto.getRandomValues threw {}",
                    host::describe(&error)
                )
            } else {
                "quickertype-core needs crypto.getRandomValues (the Web Crypto API) to seed its \
                 hash maps, and this JavaScript host does not have it"
                    .to_owned()
            });
        }
        let entropy = u128::from_le_bytes(bytes);
        Ok([entropy as u64, (entropy >> 64) as u64])
    }

    /// Without a JavaScript host: `std`'s `RandomState`, random where the
    /// platform has a random source (natively, WASI), fixed on
    /// `wasm32-unknown-unknown`.
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
    pub struct RandomState(SeedableRandomState);

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
                    "{error}. A host with quickertype-core's `js-host-random` feature must \
                     call quicktype_core::support::fast_hash::init() when it starts, and \
                     handle its error, before anything makes a hash map"
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

    use super::StrHasher;
    use super::seeded::{RandomState, Seeds};

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
    fn hash_str_tells_texts_apart() {
        let texts = [
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
        let check = |hash: &dyn Fn(&str) -> u64| {
            let hashes: std::collections::HashSet<u64> = texts.iter().map(|t| hash(t)).collect();
            assert_eq!(hashes.len(), texts.len());
            assert!(texts.iter().all(|t| hash(t) == hash(t)));
        };
        let tables = StrHasher::default();
        check(&|t| tables.hash_str(t));
        let seeded = RandomState::with_seeds(seeds([7, 8]));
        check(&|t| {
            use std::hash::Hasher as _;
            let mut hasher = seeded.build_hasher();
            hasher.write(t.as_bytes());
            hasher.finish()
        });
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
}
