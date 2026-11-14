//! Hash maps and sets for lookups only.
//!
//! `std`'s default hasher (SipHash-1-3) was 10% of the engine's time. These
//! aliases use foldhash instead, seeded per process (per instance in
//! WebAssembly). Iterating them visits the entries in an arbitrary order,
//! exactly like `std`'s maps, so the rule stands: their iteration order
//! must never reach output (docs/PARITY.md, rule 1); use
//! `IndexMap`/`IndexSet` for that.
//!
//! The seed has to be secret because the keys come from the input: whoever
//! knows it can write JSON whose keys all land in one bucket, and reading it
//! then takes quadratic time. Natively, foldhash seeds itself from address
//! space layout randomization and the clock. WebAssembly has neither, so
//! there foldhash's seed comes out the same in every instance (and so do the
//! keys of `std`'s `RandomState`). The WebAssembly build's [`BuildHasher`]
//! is foldhash with seeds from the JavaScript host's
//! `crypto.getRandomValues` (the `js-host-random` feature), taken when the
//! first map is made, or earlier by [`init`].

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

/// Takes the maps' seed now rather than when the first map is made; an
/// error, naming the API, if the host cannot give one. In WebAssembly with
/// the `js-host-random` feature that is a host without
/// `crypto.getRandomValues` (the bindings call this as the module starts,
/// and fail the start with it). Elsewhere it does nothing.
pub fn init() -> Result<(), String> {
    #[cfg(target_arch = "wasm32")]
    return seeded::init();
    #[cfg(not(target_arch = "wasm32"))]
    Ok(())
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

    /// Taken once, by the first map or by [`init`], whichever comes first.
    static SEEDS: OnceLock<Seeds> = OnceLock::new();

    fn seeds() -> &'static Seeds {
        SEEDS.get_or_init(|| Seeds::new(entropy().unwrap_or_else(|missing| panic!("{missing}"))))
    }

    /// [`super::init`].
    pub(super) fn init() -> Result<(), String> {
        if SEEDS.get().is_none() {
            let entropy = entropy()?;
            SEEDS.get_or_init(|| Seeds::new(entropy));
        }
        Ok(())
    }

    /// 16 bytes of the JavaScript host's `crypto.getRandomValues`.
    #[cfg(all(target_arch = "wasm32", feature = "js-host-random"))]
    fn entropy() -> Result<[u64; 2], String> {
        let mut bytes = [0; 16];
        host::get_random_values(&mut bytes).map_err(|_| {
            "quickertype-core needs crypto.getRandomValues (the Web Crypto API) to seed its \
             hash maps, and this JavaScript host does not have it"
                .to_owned()
        })?;
        let entropy = u128::from_le_bytes(bytes);
        Ok([entropy as u64, (entropy >> 64) as u64])
    }

    /// Without a host to ask: fixed, as foldhash's own seed is in
    /// WebAssembly (digits of e).
    #[cfg(not(all(target_arch = "wasm32", feature = "js-host-random")))]
    fn entropy() -> Result<[u64; 2], String> {
        Ok([0x2b7e_1516_28ae_d2a6, 0xabf7_1588_09cf_4f3c])
    }

    #[cfg(all(target_arch = "wasm32", feature = "js-host-random"))]
    mod host {
        use wasm_bindgen::prelude::{JsValue, wasm_bindgen};

        #[wasm_bindgen]
        extern "C" {
            /// `crypto.getRandomValues(array)`; throws where there is no
            /// `crypto`.
            #[wasm_bindgen(js_namespace = crypto, js_name = getRandomValues, catch)]
            pub(super) fn get_random_values(array: &mut [u8]) -> Result<(), JsValue>;
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
            RandomState::with_seeds(seeds())
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
    fn unseeded_maps_work() {
        let state = RandomState::default();
        assert_eq!(state.hash_one(17u32), state.hash_one(17u32));
        assert_eq!(super::init(), Ok(()));
    }
}
