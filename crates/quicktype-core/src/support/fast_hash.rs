//! The engine's hash maps and sets, all with one seeded hasher.
//!
//! These are `quicktype_js_compat::hash`'s, re-exported: foldhash with a
//! secret seed, from the operating system's random source natively (once
//! per process) and per instance in WebAssembly (from
//! `crypto.getRandomValues` with the `js-host-random` feature), because
//! the keys come from the input. That module says where the seed comes
//! from, and what `seed` and `init` require.
//!
//! [`IndexMap`] and [`IndexSet`] iterate in insertion order, so their order
//! is output (docs/PARITY.md, rule 1). [`HashMap`] and [`HashSet`] iterate
//! in an order that depends on the seed: use them for lookups only.
//!
//! `std`'s SipHash was 10% of the engine's time; foldhash is what made the
//! lookup-only maps fast, hence this module's name.

pub(crate) use quicktype_js_compat::hash::StrHasher;
pub use quicktype_js_compat::hash::{
    HashMap, HashSet, IndexMap, IndexSet, SeededState, index_map_with_capacity, init, seed,
};

/// The hasher of every map and set ([`SeededState`]).
pub type BuildHasher = SeededState;

#[cfg(test)]
mod tests {
    #[test]
    fn init_without_a_javascript_host_succeeds() {
        assert_eq!(super::init(), Ok(()));
    }

    /// The reader's tables hash through quickertype-js-compat's
    /// `StrHasher` (tested there, on the seeded state WebAssembly uses).
    #[test]
    fn the_reader_s_hasher_tells_strings_apart() {
        let tables = super::StrHasher::default();
        assert_eq!(tables.hash_str("key"), tables.hash_str("key"));
        assert_ne!(tables.hash_str("key"), tables.hash_str("kez"));
    }
}
