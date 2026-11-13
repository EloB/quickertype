//! Port of `packages/quicktype-core/src/language/Rust/utils.ts`.
//!
//! Rust identifier styling, string escaping and the serde naming-style
//! heuristics behind `#[serde(rename_all = ...)]`.
//!
//! The TypeScript naming styles are regular expressions over ASCII
//! character classes; they are matched by hand here (see
//! [`NamingStyleKey::matches`]), which gives the same answers without a
//! regex engine.

use quicktype_js_compat::utf16;
use quicktype_js_compat::whitespace::is_line_terminator;

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    MapperOutput, WordStyle, all_lower_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, int_to_hex, is_ascii, is_letter_or_underscore,
    is_letter_or_underscore_or_digit, is_printable, legalize_characters, split_into_words,
    utf32_concat_map,
};

/// `Density`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Density {
    /// `"normal"`: blank lines between fields.
    Normal,
    /// `"dense"`: no blank lines between fields.
    Dense,
}

/// `Visibility`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Visibility {
    /// `"private"`: no visibility modifier.
    Private,
    /// `"crate"`: `pub(crate)`.
    Crate,
    /// `"public"`: `pub`.
    Public,
}

/// `NamingStyleKey`: a serde naming style. The variant order is the key
/// order of TS `namingStyles`, which decides ties.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum NamingStyleKey {
    /// `snake_case`.
    SnakeCase,
    /// `SCREAMING_SNAKE_CASE`.
    ScreamingSnakeCase,
    /// `camelCase`.
    CamelCase,
    /// `PascalCase`.
    PascalCase,
    /// `kebab-case`.
    KebabCase,
    /// `SCREAMING-KEBAB-CASE`.
    ScreamingKebabCase,
    /// `lowercase`.
    Lowercase,
    /// `UPPERCASE`.
    Uppercase,
}

fn is_lower(c: char) -> bool {
    c.is_ascii_lowercase()
}

fn is_upper(c: char) -> bool {
    c.is_ascii_uppercase()
}

fn is_lower_or_digit(c: char) -> bool {
    c.is_ascii_lowercase() || c.is_ascii_digit()
}

fn is_upper_or_digit(c: char) -> bool {
    c.is_ascii_uppercase() || c.is_ascii_digit()
}

/// `^[first][part]*(<sep>[part]+)*$`.
fn matches_separated(
    name: &str,
    first: fn(char) -> bool,
    part: fn(char) -> bool,
    separator: char,
) -> bool {
    let mut chars = name.chars();
    if !chars.next().is_some_and(first) {
        return false;
    }
    let mut after_separator = false;
    for c in chars {
        if c == separator {
            if after_separator {
                return false;
            }
            after_separator = true;
        } else if part(c) {
            after_separator = false;
        } else {
            return false;
        }
    }
    !after_separator
}

/// `^[first]<rest>*$`.
fn matches_simple(name: &str, first: fn(char) -> bool, rest: fn(char) -> bool) -> bool {
    let mut chars = name.chars();
    chars.next().is_some_and(first) && chars.all(rest)
}

/// JavaScript `s.slice(0, 1).toUpperCase() + s.slice(1).toLowerCase()`.
fn first_upper_rest_lower(s: &str) -> String {
    utf16::map_first_unit(s, |c| c.to_uppercase().collect(), str::to_lowercase)
}

/// `name.replace(/(.)([A-Z])/g, "$1_$2")`: an underscore before every
/// upper-case ASCII letter that follows a character other than a line
/// terminator, without overlapping matches.
fn underscore_before_capitals(name: &str) -> String {
    let chars: Vec<char> = name.chars().collect();
    let mut out = String::with_capacity(name.len() + 4);
    let mut i = 0;
    while i < chars.len() {
        let c = chars[i];
        if !is_line_terminator(c) && i + 1 < chars.len() && is_upper(chars[i + 1]) {
            out.push(c);
            out.push('_');
            out.push(chars[i + 1]);
            i += 2;
        } else {
            out.push(c);
            i += 1;
        }
    }
    out
}

impl NamingStyleKey {
    /// All styles, in TS key order.
    pub const ALL: [NamingStyleKey; 8] = [
        NamingStyleKey::SnakeCase,
        NamingStyleKey::ScreamingSnakeCase,
        NamingStyleKey::CamelCase,
        NamingStyleKey::PascalCase,
        NamingStyleKey::KebabCase,
        NamingStyleKey::ScreamingKebabCase,
        NamingStyleKey::Lowercase,
        NamingStyleKey::Uppercase,
    ];

    /// The style's name, as serde spells it.
    pub fn as_str(self) -> &'static str {
        match self {
            NamingStyleKey::SnakeCase => "snake_case",
            NamingStyleKey::ScreamingSnakeCase => "SCREAMING_SNAKE_CASE",
            NamingStyleKey::CamelCase => "camelCase",
            NamingStyleKey::PascalCase => "PascalCase",
            NamingStyleKey::KebabCase => "kebab-case",
            NamingStyleKey::ScreamingKebabCase => "SCREAMING-KEBAB-CASE",
            NamingStyleKey::Lowercase => "lowercase",
            NamingStyleKey::Uppercase => "UPPERCASE",
        }
    }

    /// `regex.test(name)`:
    ///
    /// | style | TS regex |
    /// |---|---|
    /// | `snake_case` | `^[a-z][a-z0-9]*(_[a-z0-9]+)*$` |
    /// | `SCREAMING_SNAKE_CASE` | `^[A-Z][A-Z0-9]*(_[A-Z0-9]+)*$` |
    /// | `camelCase` | `^[a-z]+([A-Z0-9][a-z]*)*$` |
    /// | `PascalCase` | `^[A-Z][a-z]*([A-Z0-9][a-z]*)*$` |
    /// | `kebab-case` | `^[a-z][a-z0-9]*(-[a-z0-9]+)*$` |
    /// | `SCREAMING-KEBAB-CASE` | `^[A-Z][A-Z0-9]*(-[A-Z0-9]+)*$` |
    /// | `lowercase` | `^[a-z][a-z0-9]*$` |
    /// | `UPPERCASE` | `^[A-Z][A-Z0-9]*$` |
    ///
    /// The camel and Pascal patterns accept exactly the ASCII alphanumeric
    /// strings that start with a lower- or upper-case letter.
    pub fn matches(self, name: &str) -> bool {
        let alnum = |c: char| c.is_ascii_alphanumeric();
        match self {
            NamingStyleKey::SnakeCase => matches_separated(name, is_lower, is_lower_or_digit, '_'),
            NamingStyleKey::ScreamingSnakeCase => {
                matches_separated(name, is_upper, is_upper_or_digit, '_')
            }
            NamingStyleKey::CamelCase => matches_simple(name, is_lower, alnum),
            NamingStyleKey::PascalCase => matches_simple(name, is_upper, alnum),
            NamingStyleKey::KebabCase => matches_separated(name, is_lower, is_lower_or_digit, '-'),
            NamingStyleKey::ScreamingKebabCase => {
                matches_separated(name, is_upper, is_upper_or_digit, '-')
            }
            NamingStyleKey::Lowercase => matches_simple(name, is_lower, is_lower_or_digit),
            NamingStyleKey::Uppercase => matches_simple(name, is_upper, is_upper_or_digit),
        }
    }

    /// `toParts(name)`.
    pub fn to_parts(self, name: &str) -> Vec<String> {
        let split = |s: &str, sep: char| s.split(sep).map(str::to_owned).collect();
        match self {
            NamingStyleKey::SnakeCase | NamingStyleKey::ScreamingSnakeCase => split(name, '_'),
            NamingStyleKey::CamelCase | NamingStyleKey::PascalCase => {
                split(&underscore_before_capitals(name), '_')
            }
            NamingStyleKey::KebabCase | NamingStyleKey::ScreamingKebabCase => split(name, '-'),
            NamingStyleKey::Lowercase | NamingStyleKey::Uppercase => vec![name.to_owned()],
        }
    }

    /// `fromParts(parts)`.
    pub fn from_parts<S: AsRef<str>>(self, parts: &[S]) -> String {
        let lower = |p: &S| p.as_ref().to_lowercase();
        let upper = |p: &S| p.as_ref().to_uppercase();
        let join = |f: &dyn Fn(&S) -> String, sep: &str| -> String {
            parts.iter().map(f).collect::<Vec<_>>().join(sep)
        };
        match self {
            NamingStyleKey::SnakeCase => join(&lower, "_"),
            NamingStyleKey::ScreamingSnakeCase => join(&upper, "_"),
            NamingStyleKey::CamelCase => parts
                .iter()
                .enumerate()
                .map(|(i, p)| {
                    if i == 0 {
                        p.as_ref().to_lowercase()
                    } else {
                        first_upper_rest_lower(p.as_ref())
                    }
                })
                .collect(),
            NamingStyleKey::PascalCase => parts
                .iter()
                .map(|p| first_upper_rest_lower(p.as_ref()))
                .collect(),
            NamingStyleKey::KebabCase => join(&lower, "-"),
            NamingStyleKey::ScreamingKebabCase => join(&upper, "-"),
            NamingStyleKey::Lowercase => join(&lower, ""),
            NamingStyleKey::Uppercase => join(&upper, ""),
        }
    }
}

fn is_ascii_letter_or_underscore_or_digit(code_point: u32) -> bool {
    is_ascii(code_point) && is_letter_or_underscore_or_digit(code_point)
}

fn is_ascii_letter_or_underscore(code_point: u32) -> bool {
    is_ascii(code_point) && is_letter_or_underscore(code_point)
}

/// `legalizeName`: keeps ASCII letters, digits and underscores.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_ascii_letter_or_underscore_or_digit)
}

/// `rustStyle(original, isSnakeCase)`.
pub fn rust_style(original: &str, is_snake_case: bool) -> String {
    let words = split_into_words(original);
    let word_style: WordStyle<'_> = if is_snake_case {
        &all_lower_word_style
    } else {
        &first_upper_word_style
    };
    let combined = combine_words(
        &words,
        &legalize_name,
        word_style,
        word_style,
        word_style,
        word_style,
        if is_snake_case { "_" } else { "" },
        &is_ascii_letter_or_underscore,
    );
    if combined == "_" {
        "_underscore".to_owned()
    } else {
        combined
    }
}

/// `snakeNamingFunction`: a new namer for snake_case names (fields).
///
/// In TypeScript this is a module-level object; renderers create it once
/// and clone it, so that every use shares one naming group.
pub fn snake_naming_function() -> Namer {
    fun_prefix_namer("default", |original| rust_style(original, true))
}

/// `camelNamingFunction`: a new namer for PascalCase names (types, enum
/// cases, union members). See [`snake_naming_function`].
pub fn camel_naming_function() -> Namer {
    fun_prefix_namer("camel", |original| rust_style(original, false))
}

/// `standardUnicodeRustEscape(codePoint)`: `\u{XXXX}`, or six hex digits
/// above U+FFFF.
fn standard_unicode_rust_escape(code_point: u32) -> String {
    if code_point <= 0xFFFF {
        format!("\\u{{{}}}", int_to_hex(code_point, 4))
    } else {
        format!("\\u{{{}}}", int_to_hex(code_point, 6))
    }
}

/// `rustStringEscape`: escapes a string for a Rust string literal, per code
/// point.
pub fn rust_string_escape(s: &str) -> String {
    let mapper = escape_non_printable_mapper(is_printable, standard_unicode_rust_escape);
    utf32_concat_map(s, |cp| -> MapperOutput { mapper(cp) })
}

/// `getPreferredNamingStyle(namingStyleOccurences, defaultStyle)`: the most
/// frequent style; the default if it is among the most frequent, else the
/// first of those in key order.
pub fn get_preferred_naming_style(
    naming_style_occurrences: &[NamingStyleKey],
    default_style: NamingStyleKey,
) -> NamingStyleKey {
    let mut occurrences = [0usize; 8];
    for style in naming_style_occurrences {
        let index = NamingStyleKey::ALL
            .iter()
            .position(|s| s == style)
            .unwrap_or_default();
        occurrences[index] += 1;
    }
    let max = occurrences.iter().copied().max().unwrap_or_default();
    let preferred: Vec<NamingStyleKey> = NamingStyleKey::ALL
        .iter()
        .zip(occurrences)
        .filter(|&(_, n)| n == max)
        .map(|(&s, _)| s)
        .collect();
    if preferred.contains(&default_style) {
        return default_style;
    }
    preferred[0]
}

/// `listMatchingNamingStyles(name)`: the styles `name` matches, in key
/// order.
pub fn list_matching_naming_styles(name: &str) -> Vec<NamingStyleKey> {
    NamingStyleKey::ALL
        .into_iter()
        .filter(|s| s.matches(name))
        .collect()
}

/// `nameWithNamingStyle(name, style)`: `name` converted from the first
/// style it matches into `style` (unchanged if it matches `style` or no
/// style at all).
pub fn name_with_naming_style(name: &str, style: NamingStyleKey) -> String {
    if style.matches(name) {
        return name.to_owned();
    }
    let Some(&from_style) = list_matching_naming_styles(name).first() else {
        return name.to_owned();
    };
    style.from_parts(&from_style.to_parts(name))
}

#[cfg(test)]
mod tests {
    use super::*;
    use NamingStyleKey::*;

    #[test]
    fn naming_style_patterns() {
        assert_eq!(
            list_matching_naming_styles("foo"),
            [SnakeCase, CamelCase, KebabCase, Lowercase]
        );
        assert_eq!(list_matching_naming_styles("foo_bar2"), [SnakeCase]);
        assert_eq!(list_matching_naming_styles("foo__bar"), []);
        assert_eq!(list_matching_naming_styles("foo_"), []);
        assert_eq!(list_matching_naming_styles("fooBar"), [CamelCase]);
        assert_eq!(list_matching_naming_styles("FooBAR9"), [PascalCase]);
        assert_eq!(
            list_matching_naming_styles("FOO"),
            [
                ScreamingSnakeCase,
                PascalCase,
                ScreamingKebabCase,
                Uppercase
            ]
        );
        assert_eq!(list_matching_naming_styles("foo-bar"), [KebabCase]);
        assert_eq!(list_matching_naming_styles("1foo"), []);
        assert_eq!(list_matching_naming_styles(""), []);
    }

    #[test]
    fn converts_between_styles() {
        assert_eq!(
            name_with_naming_style("fooBarBaz", SnakeCase),
            "foo_bar_baz"
        );
        assert_eq!(name_with_naming_style("ABC", SnakeCase), "abc");
        assert_eq!(name_with_naming_style("fooBAR", SnakeCase), "foo_ba_r");
        assert_eq!(name_with_naming_style("foo_bar", PascalCase), "FooBar");
        assert_eq!(name_with_naming_style("foo_bar", CamelCase), "fooBar");
        assert_eq!(name_with_naming_style("$x", CamelCase), "$x");
        assert_eq!(PascalCase.from_parts(&["the", "THING"]), "TheThing");
    }

    #[test]
    fn preferred_style() {
        assert_eq!(get_preferred_naming_style(&[], SnakeCase), SnakeCase);
        assert_eq!(
            get_preferred_naming_style(&[CamelCase, CamelCase, SnakeCase], SnakeCase),
            CamelCase
        );
        assert_eq!(
            get_preferred_naming_style(&[CamelCase, KebabCase], SnakeCase),
            CamelCase
        );
    }

    #[test]
    fn styles_and_escapes() {
        assert_eq!(rust_style("fooBar", true), "foo_bar");
        assert_eq!(rust_style("fooBar", false), "FooBar");
        assert_eq!(rust_style("_", true), "empty");
        assert_eq!(rust_style("123", false), "The123");
        assert_eq!(
            rust_string_escape("a\"\u{1}😀"),
            "a\\\"\\u{0001}\\u{01f600}"
        );
        assert_eq!(rust_string_escape("\u{10FFFF}"), "\\u{10ffff}");
    }
}
