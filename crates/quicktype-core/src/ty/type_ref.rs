//! Port of `packages/quicktype-core/src/Type/TypeRef.ts`.
//!
//! A [`TypeRef`] is the JavaScript number `((serial & 31) << 26) | index`:
//! the index of a type in its graph's arena plus the low five bits of the
//! graph's serial number. Keeping the exact value matters because type
//! identities hash type refs (`hashCodeOf(ref) = ref | 0`), and the serial
//! lets debug builds catch refs used with the wrong graph.

use std::fmt;

use crate::messages::Result;
use crate::support::collection_utils::{JsEquals, JsHash};
use crate::support::support::assert;

const INDEX_BITS: u32 = 26;
const INDEX_MASK: u32 = (1 << INDEX_BITS) - 1;
const SERIAL_BITS: u32 = 31 - INDEX_BITS;
const SERIAL_MASK: u32 = (1 << SERIAL_BITS) - 1;

/// A reference to a type in a [`TypeGraph`](super::type_graph::TypeGraph) or
/// in a graph under construction.
#[derive(Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub struct TypeRef(u32);

impl TypeRef {
    /// `makeTypeRef(graph, index)`.
    pub fn new(graph_serial: u32, index: usize) -> Result<TypeRef> {
        assert(index <= INDEX_MASK as usize, "Too many types in graph")?;
        Ok(TypeRef(
            ((graph_serial & SERIAL_MASK) << INDEX_BITS) | index as u32,
        ))
    }

    /// `typeRefIndex(tref)`: the index in the graph's type arena.
    pub fn index(self) -> usize {
        (self.0 & INDEX_MASK) as usize
    }

    /// The (masked) serial number of the graph this ref belongs to.
    pub fn serial(self) -> u32 {
        (self.0 >> INDEX_BITS) & SERIAL_MASK
    }

    /// The JavaScript number this ref is in TypeScript.
    pub fn js_value(self) -> i64 {
        i64::from(self.0)
    }

    /// Whether this ref belongs to the graph with serial `graph_serial`.
    pub fn belongs_to(self, graph_serial: u32) -> bool {
        self.serial() == (graph_serial & SERIAL_MASK)
    }
}

/// `assertTypeRefGraph(tref, graph)`.
pub fn assert_type_ref_graph(tref: TypeRef, graph_serial: u32) -> Result<()> {
    assert(
        tref.belongs_to(graph_serial),
        "Mixing the wrong type reference and graph",
    )
}

impl JsHash for TypeRef {
    fn hash_code(&self) -> i64 {
        self.js_value()
    }
}

impl JsEquals for TypeRef {
    fn js_equals(&self, other: &Self) -> bool {
        self == other
    }
}

impl fmt::Debug for TypeRef {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "TypeRef({}@{})", self.index(), self.serial())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn encodes_serial_and_index_like_javascript() {
        let r = TypeRef::new(3, 42).unwrap();
        assert_eq!(r.js_value(), (3 << 26) | 42);
        assert_eq!(r.index(), 42);
        assert_eq!(r.serial(), 3);
        // The serial wraps modulo 32.
        let r = TypeRef::new(33, 7).unwrap();
        assert_eq!(r.serial(), 1);
        assert!(r.belongs_to(1));
        assert!(assert_type_ref_graph(r, 2).is_err());
        assert!(TypeRef::new(0, 1 << 26).is_err());
    }
}
