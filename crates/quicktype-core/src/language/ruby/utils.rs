//! Port of `packages/quicktype-core/src/language/Ruby/utils.ts`.
//!
//! Ruby identifier styling (on code points, with the `unicode-properties`
//! categories), string escaping and the names properties may not take.
//!
//! `Elixir/utils.ts` has its own copies of the escaping and naming helpers,
//! so `elixir::utils` duplicates them as the TypeScript does.

use std::borrow::Cow;
use std::sync::LazyLock;

use indexmap::IndexSet;
use quicktype_js_compat::unicode::{self, GeneralCategory};

use super::constants::{KEYWORDS, RESERVED_PROPERTIES};
use crate::renderer_options::PrototypeMember;
use crate::source::Source;
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, int_to_hex, is_letter_or_underscore, is_printable, legalize_characters,
    split_into_words, utf32_concat_map,
};

/// `Strictness`: the prefix of every Dry type the generated code checks
/// against.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Strictness {
    /// `"Strict::"`.
    Strict,
    /// `"Coercible::"`.
    Coercible,
    /// `"Types::"`.
    None,
    /// An `Object.prototype` member given as `--strictness` (see
    /// [`PrototypeMember`]): it is none of the above.
    Other(PrototypeMember),
}

impl Strictness {
    /// The enum's string value, e.g. `"Strict::"`, as a template literal
    /// interpolates it: [`PrototypeMember::to_js_string`] for
    /// [`Other`](Self::Other).
    pub fn as_str(self) -> Cow<'static, str> {
        match self {
            Strictness::Strict => Cow::Borrowed("Strict::"),
            Strictness::Coercible => Cow::Borrowed("Coercible::"),
            Strictness::None => Cow::Borrowed("Types::"),
            Strictness::Other(member) => Cow::Owned(member.to_js_string()),
        }
    }

    /// The value as a `Sourcelike` part: [`Other`](Self::Other) is no
    /// sourcelike, so serializing it fails ([`Source::Unexpected`]).
    pub fn to_source(self) -> Source {
        match self {
            Strictness::Other(member) => Source::Unexpected(member),
            strictness => strictness.as_str().into(),
        }
    }
}

/// `forbiddenForObjectProperties`: the keywords, the reserved properties
/// and `_1` to `_9`, without duplicates (built once, like the module-level
/// TypeScript constant).
pub static FORBIDDEN_FOR_OBJECT_PROPERTIES: LazyLock<Vec<String>> = LazyLock::new(|| {
    let names: IndexSet<String> = KEYWORDS
        .iter()
        .chain(RESERVED_PROPERTIES.iter())
        .map(|&s| s.to_owned())
        .chain((1..=9).map(|i| format!("_{i}")))
        .collect();
    names.into_iter().collect()
});

/// `unicodeEscape(codePoint)`: `\u{X}` with as many hex digits as needed.
fn unicode_escape(code_point: u32) -> String {
    format!("\\u{{{}}}", int_to_hex(code_point, 0))
}

/// `stringEscape`: escapes per code point for a double-quoted Ruby string;
/// `#` (string interpolation) is escaped as well.
pub fn string_escape(s: &str) -> String {
    utf32_concat_map(
        s,
        escape_non_printable_mapper(
            |code_point| is_printable(code_point) && code_point != 0x23,
            unicode_escape,
        ),
    )
}

/// `isStartCharacter`.
fn is_start_character(code_point: u32) -> bool {
    is_letter_or_underscore(code_point)
}

/// `isPartCharacter(utf16Unit)`.
fn is_part_character(utf16_unit: u32) -> bool {
    let category = unicode::get_category(utf16_unit);
    matches!(
        category,
        GeneralCategory::Nd | GeneralCategory::Pc | GeneralCategory::Mn | GeneralCategory::Mc
    ) || is_start_character(utf16_unit)
}

/// `legalizeName`.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_part_character)
}

/// `simpleNameStyle(original, uppercase)`: a purely numeric name gets an
/// `N` suffix first.
pub fn simple_name_style(original: &str, uppercase: bool) -> String {
    let original = if !original.is_empty() && original.bytes().all(|b| b.is_ascii_digit()) {
        format!("{original}N")
    } else {
        original.to_owned()
    };

    let words = split_into_words(&original);
    let style: fn(&str) -> String = if uppercase {
        first_upper_word_style
    } else {
        all_lower_word_style
    };
    combine_words(
        &words,
        &legalize_name,
        &style,
        &style,
        &all_upper_word_style,
        &all_upper_word_style,
        "",
        &is_start_character,
    )
}

/// `memberNameStyle(original)`: `lower_underscore`.
pub fn member_name_style(original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        &all_lower_word_style,
        &all_lower_word_style,
        &all_lower_word_style,
        &all_lower_word_style,
        "_",
        &is_start_character,
    )
}
