//! Port of `packages/quicktype-core/src/language/CSharp/utils.ts`.
//!
//! C# identifier styling (checked on UTF-16 units with the
//! `unicode-properties` categories), which values need converters
//! ([`need_transformer_for_type`], also the target language's
//! `needsTransformerForType`), and small type helpers shared by the
//! renderers.

use quicktype_js_compat::unicode::{self, GeneralCategory};

use super::constants::KEYWORDS;
use crate::attributes::constraints::{min_max_length_for_type, min_max_value_for_type};
use crate::messages::Result;
use crate::naming::{Namer, fun_prefix_namer};
use crate::source::Source;
use crate::support::recursion::guard;
use crate::support::strings::{
    WordInName, combine_words, first_upper_word_style, split_into_words, utf16_legalize_characters,
};
use crate::support::support::panic;
use crate::transformers::Transformation;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::nullable_from_union;

/// `AccessModifier`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum AccessModifier {
    /// No modifier.
    None,
    /// `public`.
    Public,
    /// `internal`.
    Internal,
}

/// What `needTransformerForType` decides for a type.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum TransformerNeed {
    /// `"automatic"`.
    Automatic,
    /// `"manual"`.
    Manual,
    /// `"nullable"`.
    Nullable,
    /// `"none"`.
    None,
}

/// `needTransformerForType(t)`: whether (and how) the C# converters must
/// transform values of type `t`.
pub fn need_transformer_for_type(graph: &TypeGraph, t: TypeRef) -> Result<TransformerNeed> {
    // Endless on a cycle through a nullable union (V8 overflows its stack).
    guard(|| {
        let ty = graph.type_at(t)?;
        if ty.is_union() {
            let Some(nullable) = nullable_from_union(graph, t)? else {
                return Ok(TransformerNeed::Automatic);
            };
            if need_transformer_for_type(graph, nullable)? == TransformerNeed::Manual {
                return Ok(TransformerNeed::Nullable);
            }
            return Ok(TransformerNeed::None);
        }

        if ty.is_array() {
            let items_need = need_transformer_for_type(graph, ty.items()?)?;
            if matches!(
                items_need,
                TransformerNeed::Manual | TransformerNeed::Nullable
            ) {
                return Ok(TransformerNeed::Automatic);
            }
            return Ok(TransformerNeed::None);
        }

        if ty.is_enum() {
            return Ok(TransformerNeed::Automatic);
        }
        Ok(match ty.kind() {
            TypeKind::Double | TypeKind::Integer => {
                if min_max_value_for_type(graph, t)?.is_some() {
                    TransformerNeed::Manual
                } else {
                    TransformerNeed::None
                }
            }
            TypeKind::IntegerString | TypeKind::BoolString => TransformerNeed::Manual,
            TypeKind::String => {
                if min_max_length_for_type(graph, t)?.is_some() {
                    TransformerNeed::Manual
                } else {
                    TransformerNeed::None
                }
            }
            _ => TransformerNeed::None,
        })
    })
}

/// `alwaysApplyTransformation(xf)`: transformations to enums and to
/// non-nullable unions are registered with the serializer; the others are
/// applied per property with `[JsonConverter]`.
pub fn always_apply_transformation(graph: &TypeGraph, xf: &Transformation) -> Result<bool> {
    let t = xf.target_type_ref();
    let ty = graph.type_at(t)?;
    if ty.is_enum() {
        return Ok(true);
    }
    if ty.is_union() {
        return Ok(nullable_from_union(graph, t)?.is_none());
    }
    Ok(false)
}

/// `csTypeForTransformedStringType(t)`: the C# type for a transformed string
/// type.
pub fn cs_type_for_transformed_string_type(kind: TypeKind) -> Result<Source> {
    match kind {
        TypeKind::DateTime => Ok("DateTimeOffset".into()),
        TypeKind::Uuid => Ok("Guid".into()),
        TypeKind::Uri => Ok("Uri".into()),
        _ => panic(format!("Transformed string type {kind} not supported")),
    }
}

/// `namingFunction`: PascalCase names.
pub fn naming_function() -> Namer {
    fun_prefix_namer("namer", cs_name_style)
}

/// `namingFunctionKeep`: the property's JSON name, only legalized
/// (`--keep-property-name`).
pub fn naming_function_keep() -> Namer {
    fun_prefix_namer("namerKeep", cs_name_style_keep)
}

/// `denseJsonPropertyName`: the alias of the JSON property attribute with
/// `--density dense`.
pub const DENSE_JSON_PROPERTY_NAME: &str = "J";
/// `denseRequiredEnumName`.
pub const DENSE_REQUIRED_ENUM_NAME: &str = "R";
/// `denseNullValueHandlingEnumName`.
pub const DENSE_NULL_VALUE_HANDLING_ENUM_NAME: &str = "N";

/// `isStartCharacter(utf16Unit)`: alphabetic or `_`.
pub fn is_start_character(utf16_unit: u32) -> bool {
    if unicode::is_alphabetic(utf16_unit) {
        return true;
    }
    utf16_unit == 0x5f // underscore
}

/// `isPartCharacter(utf16Unit)`.
fn is_part_character(utf16_unit: u32) -> bool {
    let category = unicode::get_category(utf16_unit);
    if matches!(
        category,
        GeneralCategory::Nd | GeneralCategory::Pc | GeneralCategory::Mn | GeneralCategory::Mc
    ) {
        return true;
    }
    is_start_character(utf16_unit)
}

/// `legalizeName`: keeps the UTF-16 units that may be part of an
/// identifier.
fn legalize_name(s: &str) -> String {
    utf16_legalize_characters(s, is_part_character)
}

/// `csNameStyle(original)`: PascalCase.
pub fn cs_name_style(original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        &first_upper_word_style,
        &first_upper_word_style,
        &first_upper_word_style,
        &first_upper_word_style,
        "",
        &is_start_character,
    )
}

/// `csNameStyleKeep(original)`: the name as one word, legalized, with an `@`
/// before keywords.
fn cs_name_style_keep(original: &str) -> String {
    let words = [WordInName {
        word: original.to_owned(),
        is_acronym: false,
    }];
    let keep = |x: &str| x.to_owned();
    let result = combine_words(
        &words,
        &legalize_name,
        &keep,
        &keep,
        &keep,
        &keep,
        "",
        &is_start_character,
    );
    if KEYWORDS.contains(&result.as_str()) {
        format!("@{result}")
    } else {
        result
    }
}

/// `isValueType(t)`: a non-nullable union (a struct), or a value type kind.
pub fn is_value_type(graph: &TypeGraph, t: TypeRef) -> Result<bool> {
    let ty = graph.type_at(t)?;
    if ty.is_union() {
        return Ok(nullable_from_union(graph, t)?.is_none());
    }
    Ok(matches!(
        ty.kind(),
        TypeKind::Integer
            | TypeKind::Double
            | TypeKind::Bool
            | TypeKind::Enum
            | TypeKind::DateTime
            | TypeKind::Uuid
    ))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::attributes::type_attributes::TypeAttributes;
    use crate::messages::JsErrorName;
    use crate::ty::type_builder::TypeBuilder;
    use crate::ty::type_builder_utils::get_no_string_type_mapping;

    /// `T = (T[] | null)`: TypeScript's `needTransformerForType` recurses
    /// until V8's stack overflows.
    #[test]
    fn need_transformer_for_a_cyclic_nullable_union_is_a_range_error() {
        let mut b =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
        let null = b
            .get_primitive_type(TypeKind::Null, TypeAttributes::new(), None)
            .unwrap();
        let array = b
            .get_unique_array_type(TypeAttributes::new(), None)
            .unwrap();
        let union = b
            .get_unique_union_type(
                TypeAttributes::new(),
                Some([array, null].into_iter().collect()),
                None,
            )
            .unwrap();
        b.set_array_items(array, union).unwrap();
        b.add_top_level("TopLevel", union).unwrap();
        let graph = b.finish().unwrap();

        let e = need_transformer_for_type(&graph, union).unwrap_err();
        let js = e.as_js_exception().unwrap();
        assert_eq!(js.name(), JsErrorName::RangeError);
        assert_eq!(js.message(), "Maximum call stack size exceeded");
        assert_eq!(crate::support::recursion::depth(), 0);
    }
}
