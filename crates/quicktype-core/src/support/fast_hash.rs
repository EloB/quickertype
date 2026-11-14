//! Hash maps and sets for lookups only.
//!
//! `std`'s default hasher (SipHash-1-3) was 10% of the engine's time. These
//! aliases use foldhash instead, seeded per process (per instance in
//! WebAssembly, see [`seed`]). Iterating them visits the entries in an
//! arbitrary order, exactly like `std`'s maps, so the rule stands: their
//! iteration order must never reach output (docs/PARITY.md, rule 1); use
//! `IndexMap`/`IndexSet` for that.
//!
//! The seed has to be secret because the keys come from the input: whoever
//! knows it can write JSON whose keys all land in one bucket, and reading it
//! then takes quadratic time. Natively, foldhash seeds itself from address
//! space layout randomization and the clock. WebAssembly has neither, so
//! there foldhash's seed comes out the same in every instance (and so do the
//! keys of `std`'s `RandomState`). The WebAssembly build's [`BuildHasher`]
//! is foldhash with seeds the bindings take from the host's randomness when
//! the module starts ([`seed`]).

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

/// The hash of `s` for a table that hashes its strings itself (hashbrown's
/// `HashTable`: the JSON reader's string and key tables), where each hash
/// is of one whole string. It is what foldhash's own `write_str` does with
/// its `nightly` feature: `write` mixes the length in.
///
/// `state.hash_one(s)` also writes a marker after the bytes, to keep a
/// string apart from what follows it in a longer key. foldhash adds the
/// marker through a 128-bit buffer and one more multiply; in WebAssembly
/// that is four multiplies and a call to shift the buffer. A lone string
/// does not need it. Every hash of one table has to be made this way.
#[inline]
pub fn hash_str(state: &BuildHasher, s: &str) -> u64 {
    use std::hash::{BuildHasher as _, Hasher as _};
    let mut hasher = state.build_hasher();
    hasher.write(s.as_bytes());
    hasher.finish()
}

/// Seeds every [`BuildHasher`] made from now on with `entropy`, which must
/// be random and secret (`crypto.getRandomValues`). In WebAssembly, call it
/// once, before anything makes a map: a map made earlier was seeded without
/// it, and so are all the maps after it (a debug build panics). Natively
/// the seed is the operating system's, and this does nothing.
pub fn seed(entropy: [u64; 2]) {
    #[cfg(target_arch = "wasm32")]
    {
        let first = seeded::seed(entropy);
        debug_assert!(first, "fast_hash::seed after a map was made");
    }
    #[cfg(not(target_arch = "wasm32"))]
    let _ = entropy;
}

/// foldhash with the seeds [`seed`] sets: the WebAssembly build's
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

    static SEEDS: OnceLock<Seeds> = OnceLock::new();

    /// The seeds without [`seed`](super::seed): as fixed as foldhash's own
    /// are in WebAssembly (digits of e).
    const UNSEEDED: [u64; 2] = [0x2b7e_1516_28ae_d2a6, 0xabf7_1588_09cf_4f3c];

    /// Takes `entropy` as the seeds; false if a map was made already.
    pub(super) fn seed(entropy: [u64; 2]) -> bool {
        SEEDS.set(Seeds::new(entropy)).is_ok()
    }

    /// The hasher of maps seeded by [`seed`](super::seed): each map's own
    /// seed is the next of a sequence that starts at the secret.
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
            RandomState::with_seeds(SEEDS.get_or_init(|| Seeds::new(UNSEEDED)))
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
        let native = super::BuildHasher::default();
        check(&|t| super::hash_str(&native, t));
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
    }
}
