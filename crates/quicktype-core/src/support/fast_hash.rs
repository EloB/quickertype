//! The engine's hash maps and sets, all with one seeded hasher.
//!
//! These are `quicktype_js_compat::hash`'s, re-exported: foldhash with a
//! secret seed, per process natively and per instance in WebAssembly (from
//! `crypto.getRandomValues` with the `js-host-random` feature), because the
//! keys come from the input. That module says where the seed comes from.
//!
//! [`IndexMap`] and [`IndexSet`] iterate in insertion order, so their order
//! is output (docs/PARITY.md, rule 1). [`HashMap`] and [`HashSet`] iterate
//! in an order that depends on the seed: use them for lookups only.
//!
//! `std`'s SipHash was 10% of the engine's time; foldhash is what made the
//! lookup-only maps fast, hence this module's name.

pub use quicktype_js_compat::hash::{
    HashMap, HashSet, IndexMap, IndexSet, SeededState, init, seed,
};

/// The hasher of every map and set ([`SeededState`]).
pub type BuildHasher = SeededState;

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

#[cfg(test)]
mod tests {
    use std::hash::BuildHasher as _;

    use super::{BuildHasher, StrHasher};

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
            let hashes: super::HashSet<u64> = texts.iter().map(|t| hash(t)).collect();
            assert_eq!(hashes.len(), texts.len());
            assert!(texts.iter().all(|t| hash(t) == hash(t)));
        };
        let tables = StrHasher::default();
        check(&|t| tables.hash_str(t));
        let seeded = BuildHasher::default();
        check(&|t| {
            use std::hash::Hasher as _;
            let mut hasher = seeded.build_hasher();
            hasher.write(t.as_bytes());
            hasher.finish()
        });
    }

    #[test]
    fn init_without_a_javascript_host_succeeds() {
        assert_eq!(super::init(), Ok(()));
    }
}
