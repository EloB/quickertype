//! Port of `packages/quicktype-core/src/language/Golang/utils.ts`.
//!
//! Go's one namer (exported `PascalCase` identifiers for types, fields,
//! union members and enum constants) and the type predicates the renderer
//! uses.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    all_upper_word_style, combine_words, first_upper_word_style, is_letter_or_underscore,
    is_letter_or_underscore_or_digit, legalize_characters, split_into_words,
};
use crate::ty::transformed_string_type::TypeKind;

/// `namingFunction`: `funPrefixNamer("namer", goNameStyle)`. TypeScript
/// shares one instance for every kind of name; a renderer creates it once
/// and clones it, which keeps its identity.
pub fn naming_function() -> Namer {
    fun_prefix_namer("namer", go_name_style)
}

/// `legalizeName`: keeps letters, digits and underscores.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_letter_or_underscore_or_digit)
}

/// `goNameStyle(original)`: `FirstUpper` words, acronyms all upper case,
/// no separator.
pub fn go_name_style(original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        &first_upper_word_style,
        &first_upper_word_style,
        &all_upper_word_style,
        &all_upper_word_style,
        "",
        &is_letter_or_underscore,
    )
}

/// `primitiveValueTypeKinds`.
pub const PRIMITIVE_VALUE_TYPE_KINDS: [TypeKind; 4] = [
    TypeKind::Integer,
    TypeKind::Double,
    TypeKind::Bool,
    TypeKind::String,
];

/// `compoundTypeKinds`.
pub const COMPOUND_TYPE_KINDS: [TypeKind; 4] = [
    TypeKind::Array,
    TypeKind::Class,
    TypeKind::Map,
    TypeKind::Enum,
];

/// `isValueType(t)`, on the type's kind: the kinds Go stores by value, so
/// that an optional one needs a pointer.
pub fn is_value_type(kind: TypeKind) -> bool {
    PRIMITIVE_VALUE_TYPE_KINDS.contains(&kind)
        || kind == TypeKind::Class
        || kind == TypeKind::Enum
        || kind == TypeKind::DateTime
}

/// `canOmitEmpty(cp, omitEmptyOption)`, on the property's optionality and
/// its type's kind. Both branches of the TypeScript compute the same
/// answer.
pub fn can_omit_empty(is_optional: bool, kind: TypeKind, omit_empty_option: bool) -> bool {
    if !is_optional {
        return false;
    }
    let excluded = [TypeKind::Union, TypeKind::Null, TypeKind::Any];
    if omit_empty_option {
        return !excluded.contains(&kind);
    }
    !excluded.contains(&kind)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn go_names_are_pascal_case_with_upper_acronyms() {
        assert_eq!(go_name_style("top_level"), "TopLevel");
        assert_eq!(go_name_style("url"), "URL");
        assert_eq!(go_name_style("1st"), "The1St");
        assert_eq!(go_name_style("_private"), "Private");
    }

    #[test]
    fn value_types_and_omit_empty() {
        assert!(is_value_type(TypeKind::DateTime));
        assert!(!is_value_type(TypeKind::Array));
        assert!(!can_omit_empty(false, TypeKind::String, true));
        assert!(can_omit_empty(true, TypeKind::String, false));
        assert!(!can_omit_empty(true, TypeKind::Union, true));
    }
}
