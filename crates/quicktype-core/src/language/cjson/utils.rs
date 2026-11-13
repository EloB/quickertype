//! Port of `packages/quicktype-core/src/language/CJSON/utils.ts`.
//!
//! The name legalizer, the global names no type may take, the include
//! records of the multi-source mode and [`TypeCJSON`], the description of
//! a quicktype type in cJSON terms.

use crate::naming::Name;
use crate::source::Source;
use crate::support::strings::{is_ascii, is_letter_or_underscore_or_digit, legalize_characters};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_ref::TypeRef;

/// `legalizeName`: drops everything but ASCII letters, digits and
/// underscores.
pub fn legalize_name(s: &str) -> String {
    legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
}

/// `GlobalNames`: the names (in `numberEnumValues` order, by value 1 to 8)
/// that, styled as type names, no generated name may take.
pub const GLOBAL_NAMES: [&str; 8] = [
    "ClassMemberConstraints",
    "ClassMemberConstraintException",
    "ValueTooLowException",
    "ValueTooHighException",
    "ValueTooShortException",
    "ValueTooLongException",
    "InvalidPatternException",
    "CheckConstraint",
];

/// `IncludeKind`: how a type is made known to a file that uses it (to
/// support cycles across files, e.g. class A using class B using class A).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum IncludeKind {
    /// `ForwardDeclare`.
    ForwardDeclare,
    /// `Include`.
    Include,
}

/// `IncludeRecord`: how (and what) to include.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct IncludeRecord {
    /// How to include the type.
    pub kind: Option<IncludeKind>,
    /// What exactly to include.
    pub type_kind: Option<TypeKind>,
}

/// `TypeRecord`: a named type that a type uses, found by
/// `generatedTypes`.
#[derive(Clone, Copy, Debug)]
pub struct TypeRecord {
    /// Include the type even if it could be forward declared.
    pub force_include: bool,
    /// How many arrays, maps and unions lie between the user and the type.
    pub level: usize,
    /// The type's name.
    pub name: Name,
    /// The type.
    pub type_ref: TypeRef,
    /// Whether the type is a member of a nullable union.
    pub variant: bool,
}

/// `IncludeMap`: the include kind of every type a file uses, by type name,
/// in insertion order (a JavaScript `Map`).
pub type IncludeMap = indexmap::IndexMap<String, IncludeRecord>;

/// `TypeCJSON`: what the generated code needs to know about a type.
#[derive(Clone, Debug)]
pub struct TypeCJSON {
    /// `addToObject`: the cJSON function that adds the value to an object.
    pub add_to_object: Source,
    /// `cType`: the C type.
    pub c_type: Source,
    /// `cjsonType`: the cJSON type constant (`cJSON_String`, ...; this
    /// renderer adds `cJSON_Integer`, `cJSON_Map`, `cJSON_Enum` and
    /// `cJSON_Union`).
    pub cjson_type: &'static str,
    /// `createObject`: the function that creates the cJSON value.
    pub create_object: Source,
    /// `deleteType`: the function that frees the C value.
    pub delete_type: Source,
    /// `getValue`: the function that reads the C value from cJSON.
    pub get_value: Source,
    /// `isNullable`: whether the value can be null.
    pub is_nullable: bool,
    /// `isType`: the cJSON type check (empty for `any`).
    pub is_type: Source,
    /// `items`: the items of an array, the values of a map.
    pub items: Option<Box<TypeCJSON>>,
    /// `optionalQualifier`: `"*"` for pointers, else empty.
    pub optional_qualifier: &'static str,
}

impl TypeCJSON {
    /// `cjsonType === kind`.
    pub fn is(&self, kind: &str) -> bool {
        self.cjson_type == kind
    }

    /// `isType !== ""`: whether there is a type check (a union's is a
    /// sequence, which is never the empty string).
    pub fn has_is_type(&self) -> bool {
        !matches!(&self.is_type, Source::Text(t) if t.is_empty())
    }

    /// `deleteType === "cJSON_free"`: whether the value is freed with
    /// `cJSON_free` (only a string compares equal; a sequence never does).
    pub fn is_freed_with_cjson_free(&self) -> bool {
        matches!(&self.delete_type, Source::Text(t) if t == "cJSON_free")
    }
}
