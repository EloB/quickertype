//! Port of `packages/quicktype-core/src/input/PathElement.ts`.
//!
//! The elements of a JSON Schema reference path (the part after `#`).

use std::fmt;

/// `PathElement`: one step of a [`Ref`](crate::input::json_schema_input::Ref)
/// path.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub enum PathElement {
    /// `Root`: the document root, from a leading `/` (`#/definitions/x`).
    Root,
    /// `KeyOrIndex`: an object key or array index, verbatim (no JSON
    /// Pointer `~0`/`~1` or percent decoding).
    KeyOrIndex(String),
    /// `Type`: the `index`th type (only in generated refs).
    Type(usize),
    /// `Object`: the object part (only in generated refs).
    Object,
}

impl PathElement {
    /// `PathElementKind`: `Root = 1`, `KeyOrIndex = 2`, `Type = 3`,
    /// `Object = 4` (part of `Ref.hashCode`).
    pub fn kind(&self) -> i64 {
        match self {
            PathElement::Root => 1,
            PathElement::KeyOrIndex(_) => 2,
            PathElement::Type(_) => 3,
            PathElement::Object => 4,
        }
    }

    /// `keyOrIndex(pe)`: the key of a `KeyOrIndex` element.
    pub fn key_or_index(&self) -> Option<&str> {
        match self {
            PathElement::KeyOrIndex(key) => Some(key),
            _ => None,
        }
    }
}

/// How `Ref.toString` writes the element: `Root` as `""`, `Type` as
/// `type/i`, `Object` as `object`, keys verbatim.
impl fmt::Display for PathElement {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            PathElement::Root => Ok(()),
            PathElement::KeyOrIndex(key) => f.write_str(key),
            PathElement::Type(index) => write!(f, "type/{index}"),
            PathElement::Object => f.write_str("object"),
        }
    }
}
