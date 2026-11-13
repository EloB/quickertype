//! Port of `packages/quicktype-core/src/language/Scala3/utils.ts`.
//!
//! Scala identifier styling, backtick quoting and the union member order of
//! the decoders.

use quicktype_js_compat::unicode::{self, GeneralCategory};
use quicktype_js_compat::whitespace;

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, first_upper_word_style, is_digit,
    is_letter_or_underscore, is_numeric, legalize_characters, split_into_words,
};
use crate::ty::transformed_string_type::TypeKind;

use super::constants::{FORBIDDEN_PROPERTY_NAMES, INVALID_SYMBOLS, KEYWORDS};

/// `!Number.isNaN(Number.parseFloat(s))`: whether `s` starts, after
/// leading whitespace, with a decimal number or `Infinity` (optionally
/// signed).
pub fn parse_float_is_number(s: &str) -> bool {
    let t = whitespace::trim_start(s);
    let t = t.strip_prefix(['+', '-']).unwrap_or(t);
    t.starts_with("Infinity")
        || t.starts_with(|c: char| c.is_ascii_digit())
        || t.strip_prefix('.')
            .is_some_and(|rest| rest.starts_with(|c: char| c.is_ascii_digit()))
}

/// `!Number.isNaN(Number.parseInt(s.charAt(0), 10))`: whether the first
/// UTF-16 unit of `s` is an ASCII digit.
pub fn first_char_is_digit(s: &str) -> bool {
    s.starts_with(|c: char| c.is_ascii_digit())
}

/// `shouldAddBacktick(paramName)`: whether a name is a keyword, contains an
/// invalid symbol or starts like a number.
pub fn should_add_backtick(param_name: &str) -> bool {
    KEYWORDS.contains(&param_name)
        || INVALID_SYMBOLS.iter().any(|s| param_name.contains(s))
        || parse_float_is_number(param_name)
        || first_char_is_digit(param_name)
}

/// `backtickedName(name)`: the name in backticks if it isn't usable as a
/// plain Scala identifier.
pub fn backticked_name(name: &str) -> String {
    if name.ends_with('_') || name.contains(' ') || should_add_backtick(name) {
        format!("`{name}`")
    } else {
        name.to_owned()
    }
}

fn is_letter_category(c: GeneralCategory) -> bool {
    use GeneralCategory::*;
    matches!(c, Lu | Ll | Lt | Lm | Lo)
}

fn is_mark_or_number_category(c: GeneralCategory) -> bool {
    use GeneralCategory::*;
    matches!(c, Mn | Mc | Me | Nd | Nl | No)
}

/// `/^[\p{L}_$][\p{L}\p{M}\p{N}_$]*$/u.test(s)`.
///
/// The categories come from `unicode-properties` (Unicode 12.0), where V8
/// uses its own, newer Unicode version; they differ only for characters
/// assigned since.
fn is_plain_identifier(s: &str) -> bool {
    let mut chars = s.chars();
    let Some(first) = chars.next() else {
        return false;
    };
    let category = |c: char| unicode::get_category(u32::from(c));
    let start_ok = first == '_' || first == '$' || is_letter_category(category(first));
    start_ok
        && chars.all(|c| {
            c == '_'
                || c == '$'
                || is_letter_category(category(c))
                || is_mark_or_number_category(category(c))
        })
}

/// `propertyNameNeedsMapping(jsonName)`: whether a property's JSON name
/// can't be the Scala field name itself (even in backticks), so the
/// renderer uses its styled name and maps it to the JSON name.
pub fn property_name_needs_mapping(json_name: &str) -> bool {
    let rendered = backticked_name(json_name);
    let can_be_backticked = rendered.starts_with('`')
        && rendered.ends_with('`')
        && !json_name.chars().any(|character| {
            let code_point = u32::from(character);
            character == '`'
                || character == '\\'
                || code_point <= 0x1f
                || (0x7f..=0x9f).contains(&code_point)
                || code_point == 0x2028
                || code_point == 0x2029
        });

    json_name == "_"
        || (!is_plain_identifier(json_name) && !can_be_backticked)
        || FORBIDDEN_PROPERTY_NAMES.contains(&json_name)
}

/// `wrapOption(s, optional)`.
pub fn wrap_option(s: &str, optional: bool) -> String {
    if optional {
        format!("Option[{s}]")
    } else {
        s.to_owned()
    }
}

/// `unionMemberSortOrder(_, t)`: the order in which the decoders of an
/// untagged union try its members, most discriminating first: enums, then
/// strings, then the other primitives, classes last.
pub fn union_member_sort_order(kind: TypeKind) -> String {
    let priority = match kind {
        TypeKind::Enum => "0",
        TypeKind::String => "2",
        TypeKind::Bool => "3",
        TypeKind::Integer => "4",
        TypeKind::Double => "5",
        TypeKind::Array => "6",
        TypeKind::Map => "7",
        TypeKind::Class => "9",
        _ => "8",
    };
    format!("{priority}{}", kind.as_str())
}

fn is_part_character(code_point: u32) -> bool {
    is_letter_or_underscore(code_point) || is_numeric(code_point)
}

fn is_start_character(code_point: u32) -> bool {
    is_part_character(code_point) && !is_digit(code_point)
}

fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_part_character)
}

/// `scalaNameStyle(isUpper, original)`: PascalCase or camelCase.
pub fn scala_name_style(is_upper: bool, original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        if is_upper {
            &first_upper_word_style
        } else {
            &all_lower_word_style
        },
        &first_upper_word_style,
        if is_upper {
            &all_upper_word_style
        } else {
            &all_lower_word_style
        },
        &all_upper_word_style,
        "",
        &is_start_character,
    )
}

/// `enumCaseNameStyle(original)`: a legal Scala identifier for an enum
/// case; `Empty` where [`scala_name_style`] gives the empty string.
pub fn enum_case_name_style(original: &str) -> String {
    let styled = scala_name_style(true, original);
    if styled.is_empty() {
        "Empty".to_owned()
    } else {
        styled
    }
}

/// `upperNamingFunction`: a new namer for type names.
///
/// In TypeScript this is a module-level object; the renderer creates it
/// once and clones it, so that every use shares one naming group.
pub fn upper_naming_function() -> Namer {
    fun_prefix_namer("upper", |s| scala_name_style(true, s))
}

/// `lowerNamingFunction`: a new namer for property names, avoiding names
/// uPickle's derivation or `java.lang.Object` would clash with. See
/// [`upper_naming_function`].
pub fn lower_naming_function() -> Namer {
    fun_prefix_namer("lower", |s| {
        let styled = scala_name_style(false, s);
        if styled.is_empty() {
            return "field".to_owned();
        }
        if let Some(digits) = styled.strip_prefix('_')
            && !digits.is_empty()
            && digits.bytes().all(|b| b.is_ascii_digit())
        {
            return format!("field{digits}");
        }
        if FORBIDDEN_PROPERTY_NAMES.contains(&styled.as_str()) {
            return format!("{styled}Value");
        }
        styled
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn backticks_like_typescript() {
        assert!(should_add_backtick("type"));
        assert!(should_add_backtick("a-b"));
        assert!(should_add_backtick("1a"));
        assert!(should_add_backtick(" -.5"));
        assert!(should_add_backtick("Infinityx"));
        assert!(!should_add_backtick("foo"));
        assert!(!should_add_backtick(" "));
        assert_eq!(backticked_name("a b"), "`a b`");
        assert_eq!(backticked_name("a_"), "`a_`");
        assert_eq!(backticked_name("ok"), "ok");
    }

    #[test]
    fn maps_property_names_like_typescript() {
        assert!(!property_name_needs_mapping("foo"));
        assert!(!property_name_needs_mapping("a b"));
        assert!(!property_name_needs_mapping("ünïcode"));
        assert!(property_name_needs_mapping("_"));
        assert!(property_name_needs_mapping("a`b"));
        assert!(property_name_needs_mapping("a\\b"));
        assert!(property_name_needs_mapping("a\nb"));
        assert!(property_name_needs_mapping("toString"));
        assert!(property_name_needs_mapping(""));
    }

    #[test]
    fn styles_names() {
        assert_eq!(enum_case_name_style("_"), "Empty");
        assert_eq!(enum_case_name_style(""), "Empty");
        assert_eq!(lower_naming_function().name_style("_1"), "the1");
        assert_eq!(lower_naming_function().name_style("_"), "empty");
        assert_eq!(
            lower_naming_function().name_style("toString"),
            "toStringValue"
        );
        assert_eq!(upper_naming_function().name_style("foo bar"), "FooBar");
    }
}
