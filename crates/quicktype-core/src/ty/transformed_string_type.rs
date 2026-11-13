//! Port of `packages/quicktype-core/src/Type/TransformedStringType.ts`.
//!
//! The type kinds, and the "transformed string" kinds: strings that encode a
//! higher-level type (dates, UUIDs, stringified integers, ...).
//!
//! `triviallyStructurallyCompatible` lives with the other structural
//! comparisons in [`ty`](super::ty) because it needs the types' kinds. The
//! `uri` kind's `attributesProducer` (`uriInferenceAttributesProducer`) needs
//! the `urijs` port and is provided by the inputs work package.

use std::fmt;

use crate::support::collection_utils::{JsEquals, JsHash};

/// `TypeKind`: every kind of type in the type graph.
#[derive(Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub enum TypeKind {
    /// `none`: the bottom type.
    None,
    /// `any`.
    Any,
    /// `null`.
    Null,
    /// `bool`.
    Bool,
    /// `integer`.
    Integer,
    /// `double`.
    Double,
    /// `string`.
    String,
    /// `date` (transformed string).
    Date,
    /// `time` (transformed string).
    Time,
    /// `date-time` (transformed string).
    DateTime,
    /// `uuid` (transformed string).
    Uuid,
    /// `uri` (transformed string).
    Uri,
    /// `integer-string` (transformed string).
    IntegerString,
    /// `bool-string` (transformed string).
    BoolString,
    /// `array`.
    Array,
    /// `class`.
    Class,
    /// `map`.
    Map,
    /// `object`.
    Object,
    /// `enum`.
    Enum,
    /// `union`.
    Union,
    /// `intersection`.
    Intersection,
}

/// `transformedStringTypeKinds`, in declaration order.
pub const TRANSFORMED_STRING_TYPE_KINDS: [TypeKind; 7] = [
    TypeKind::Date,
    TypeKind::Time,
    TypeKind::DateTime,
    TypeKind::Uuid,
    TypeKind::Uri,
    TypeKind::IntegerString,
    TypeKind::BoolString,
];

impl TypeKind {
    /// The kind's name in TypeScript, e.g. `"date-time"`.
    pub fn as_str(self) -> &'static str {
        match self {
            TypeKind::None => "none",
            TypeKind::Any => "any",
            TypeKind::Null => "null",
            TypeKind::Bool => "bool",
            TypeKind::Integer => "integer",
            TypeKind::Double => "double",
            TypeKind::String => "string",
            TypeKind::Date => "date",
            TypeKind::Time => "time",
            TypeKind::DateTime => "date-time",
            TypeKind::Uuid => "uuid",
            TypeKind::Uri => "uri",
            TypeKind::IntegerString => "integer-string",
            TypeKind::BoolString => "bool-string",
            TypeKind::Array => "array",
            TypeKind::Class => "class",
            TypeKind::Map => "map",
            TypeKind::Object => "object",
            TypeKind::Enum => "enum",
            TypeKind::Union => "union",
            TypeKind::Intersection => "intersection",
        }
    }

    /// Looks a kind up by its TypeScript name.
    #[allow(clippy::should_implement_trait)]
    pub fn from_str(name: &str) -> Option<TypeKind> {
        ALL_KINDS.iter().copied().find(|k| k.as_str() == name)
    }

    /// Whether this is one of the transformed string kinds.
    pub fn is_transformed_string_type_kind(self) -> bool {
        TRANSFORMED_STRING_TYPE_KINDS.contains(&self)
    }

    /// `isPrimitiveStringTypeKind`: `string` or a transformed string kind.
    pub fn is_primitive_string_type_kind(self) -> bool {
        self == TypeKind::String || self.is_transformed_string_type_kind()
    }

    /// `isNumberTypeKind`.
    pub fn is_number_type_kind(self) -> bool {
        matches!(self, TypeKind::Integer | TypeKind::Double)
    }

    /// `isPrimitiveTypeKind`.
    pub fn is_primitive_type_kind(self) -> bool {
        self.is_primitive_string_type_kind()
            || self.is_number_type_kind()
            || matches!(
                self,
                TypeKind::None | TypeKind::Any | TypeKind::Null | TypeKind::Bool
            )
    }

    /// Whether this is an object kind (`object`, `map` or `class`).
    pub fn is_object_type_kind(self) -> bool {
        matches!(self, TypeKind::Object | TypeKind::Map | TypeKind::Class)
    }

    /// Whether this is a set operation kind (`union` or `intersection`).
    pub fn is_set_operation_kind(self) -> bool {
        matches!(self, TypeKind::Union | TypeKind::Intersection)
    }
}

const ALL_KINDS: [TypeKind; 21] = [
    TypeKind::None,
    TypeKind::Any,
    TypeKind::Null,
    TypeKind::Bool,
    TypeKind::Integer,
    TypeKind::Double,
    TypeKind::String,
    TypeKind::Date,
    TypeKind::Time,
    TypeKind::DateTime,
    TypeKind::Uuid,
    TypeKind::Uri,
    TypeKind::IntegerString,
    TypeKind::BoolString,
    TypeKind::Array,
    TypeKind::Class,
    TypeKind::Map,
    TypeKind::Object,
    TypeKind::Enum,
    TypeKind::Union,
    TypeKind::Intersection,
];

impl fmt::Display for TypeKind {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.as_str())
    }
}

impl fmt::Debug for TypeKind {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.as_str())
    }
}

/// Kinds are strings in TypeScript and hash as such.
impl JsHash for TypeKind {
    fn hash_code(&self) -> i64 {
        self.as_str().hash_code()
    }
}

impl JsEquals for TypeKind {
    fn js_equals(&self, other: &Self) -> bool {
        self == other
    }
}

/// `TransformedStringTypeTargets`: how a transformed string kind is
/// represented in JSON Schema and which primitive kind it maps to, if any.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TransformedStringTypeTargets {
    /// The JSON Schema `format`.
    pub json_schema: &'static str,
    /// The primitive kind the string stands for (`integer-string` →
    /// `integer`, `bool-string` → `bool`).
    pub primitive: Option<TypeKind>,
}

/// `transformedStringTypeTargetTypeKindsMap.get(kind)`.
pub fn transformed_string_type_targets(kind: TypeKind) -> Option<TransformedStringTypeTargets> {
    let (json_schema, primitive) = match kind {
        TypeKind::Date => ("date", None),
        TypeKind::Time => ("time", None),
        TypeKind::DateTime => ("date-time", None),
        TypeKind::Uuid => ("uuid", None),
        TypeKind::Uri => ("uri", None),
        TypeKind::IntegerString => ("integer", Some(TypeKind::Integer)),
        TypeKind::BoolString => ("boolean", Some(TypeKind::Bool)),
        _ => return None,
    };
    Some(TransformedStringTypeTargets {
        json_schema,
        primitive,
    })
}

/// `targetTypeKindForTransformedStringTypeKind(kind)`.
pub fn target_type_kind_for_transformed_string_type_kind(kind: TypeKind) -> Option<TypeKind> {
    transformed_string_type_targets(kind).and_then(|t| t.primitive)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn kind_predicates() {
        for k in ALL_KINDS {
            assert_eq!(TypeKind::from_str(k.as_str()), Some(k));
        }
        assert!(TypeKind::DateTime.is_primitive_string_type_kind());
        assert!(TypeKind::Null.is_primitive_type_kind());
        assert!(!TypeKind::Enum.is_primitive_type_kind());
        assert_eq!(
            target_type_kind_for_transformed_string_type_kind(TypeKind::IntegerString),
            Some(TypeKind::Integer)
        );
        assert_eq!(
            target_type_kind_for_transformed_string_type_kind(TypeKind::Uuid),
            None
        );
        assert_eq!(
            target_type_kind_for_transformed_string_type_kind(TypeKind::String),
            None
        );
    }
}
