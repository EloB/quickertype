//! Hash maps and sets for lookups only.
//!
//! `std`'s default hasher (SipHash-1-3) was 10% of the engine's time. These
//! aliases use foldhash instead, still seeded per process. Iterating them
//! visits the entries in an arbitrary order, exactly like `std`'s maps, so
//! the rule stands: their iteration order must never reach output
//! (docs/PARITY.md, rule 1); use `IndexMap`/`IndexSet` for that.

/// The hasher of [`HashMap`] and [`HashSet`].
pub type BuildHasher = foldhash::fast::RandomState;

/// [`std::collections::HashMap`] with [`BuildHasher`].
pub type HashMap<K, V> = std::collections::HashMap<K, V, BuildHasher>;

/// [`std::collections::HashSet`] with [`BuildHasher`].
pub type HashSet<T> = std::collections::HashSet<T, BuildHasher>;
