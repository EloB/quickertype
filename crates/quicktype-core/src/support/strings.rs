//! Port of `packages/quicktype-core/src/support/Strings.ts`.
//!
//! String helpers for naming and escaping. Everything here follows
//! JavaScript semantics: lengths and indices count UTF-16 code units, and
//! character classes come from the npm package `unicode-properties`
//! (Unicode 12.0, unassigned code points are `Cc`) via
//! [`quicktype_js_compat::unicode`].
//!
//! Differences in shape from the TypeScript:
//!
//! - The higher-order helpers (`utf16ConcatMap(mapper)(s)`,
//!   `legalizeCharacters(isLegal)(s)`, ...) take the string and the function
//!   together: `utf16_concat_map(s, mapper)`.
//! - A mapper returns a [`MapperOutput`], so that it can emit a single UTF-16
//!   code unit (`String.fromCharCode(u)`), which may be half of a surrogate
//!   pair.
//! - A Rust `&str` cannot contain an unpaired surrogate. So
//!   `utf32ConcatMap`'s `MiscUnicodeHighSurrogateWithoutLowSurrogate` error
//!   cannot occur, and where a mapper or legalizer keeps only one half of a
//!   pair, that half is dropped from the result (JavaScript would keep it).
//! - The TypeScript `assert`s in [`split_into_words`] and [`combine_words`]
//!   guard invariants that hold for every input string given quicktype's
//!   legalizers and word styles; they are `debug_assert!`s here.

use std::borrow::Cow;

use quicktype_js_compat::{unicode, utf16};

use super::acronyms_const::is_known_acronym;

/// `NamingStyle`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum NamingStyle {
    /// `"pascal"`: `FooBarBaz`.
    Pascal,
    /// `"camel"`: `fooBarBaz`.
    Camel,
    /// `"underscore"`: `foo_bar_baz`.
    Underscore,
    /// `"upper-underscore"`: `FOO_BAR_BAZ`.
    UpperUnderscore,
    /// `"pascal-upper-acronyms"`: `FooBarURL`.
    PascalUpperAcronyms,
    /// `"camel-upper-acronyms"`: `fooBarURL`.
    CamelUpperAcronyms,
    /// `"original"`: the name as is, only legalized.
    Original,
}

impl NamingStyle {
    /// Every style, in the order of the TypeScript union.
    pub const ALL: [NamingStyle; 7] = [
        NamingStyle::Pascal,
        NamingStyle::Camel,
        NamingStyle::Underscore,
        NamingStyle::UpperUnderscore,
        NamingStyle::PascalUpperAcronyms,
        NamingStyle::CamelUpperAcronyms,
        NamingStyle::Original,
    ];

    /// The style's name in TypeScript, e.g. `"upper-underscore"`.
    pub fn as_str(self) -> &'static str {
        match self {
            NamingStyle::Pascal => "pascal",
            NamingStyle::Camel => "camel",
            NamingStyle::Underscore => "underscore",
            NamingStyle::UpperUnderscore => "upper-underscore",
            NamingStyle::PascalUpperAcronyms => "pascal-upper-acronyms",
            NamingStyle::CamelUpperAcronyms => "camel-upper-acronyms",
            NamingStyle::Original => "original",
        }
    }

    /// The style named `name` (see [`NamingStyle::as_str`]).
    pub fn from_name(name: &str) -> Option<Self> {
        Self::ALL.into_iter().find(|style| style.as_str() == name)
    }
}

/// What a [`utf16_concat_map`] or [`utf32_concat_map`] mapper produces for
/// one code unit or code point.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum MapperOutput {
    /// `String.fromCharCode(n)`: the single UTF-16 code unit `n & 0xFFFF`.
    /// For a surrogate unit, adjacent outputs can reunite the pair.
    CharCode(u32),
    /// Any other replacement text, possibly empty.
    Text(Cow<'static, str>),
}

impl From<String> for MapperOutput {
    fn from(text: String) -> Self {
        MapperOutput::Text(Cow::Owned(text))
    }
}

impl From<&'static str> for MapperOutput {
    fn from(text: &'static str) -> Self {
        MapperOutput::Text(Cow::Borrowed(text))
    }
}

fn push_output(units: &mut Vec<u16>, output: MapperOutput) {
    match output {
        // ToUint16, as String.fromCharCode does.
        MapperOutput::CharCode(code) => units.push((code & 0xFFFF) as u16),
        MapperOutput::Text(text) => units.extend(text.encode_utf16()),
    }
}

/// `utf16ConcatMap(mapper)(s)`: concatenates `mapper(unit)` for every UTF-16
/// code unit of `s`. An astral character reaches the mapper as two surrogate
/// units.
pub fn utf16_concat_map(s: &str, mapper: impl Fn(u32) -> MapperOutput) -> String {
    let mut units = Vec::with_capacity(s.len());
    for unit in s.encode_utf16() {
        push_output(&mut units, mapper(u32::from(unit)));
    }
    utf16::units_to_string(&units)
}

/// `utf32ConcatMap(mapper)(s)`: concatenates `mapper(codePoint)` for every
/// code point of `s`.
pub fn utf32_concat_map(s: &str, mapper: impl Fn(u32) -> MapperOutput) -> String {
    let mut units = Vec::with_capacity(s.len());
    for c in s.chars() {
        push_output(&mut units, mapper(u32::from(c)));
    }
    utf16::units_to_string(&units)
}

/// `utf16LegalizeCharacters(isLegal)(s)`: keeps the UTF-16 code units for
/// which `is_legal` holds.
pub fn utf16_legalize_characters(s: &str, is_legal: impl Fn(u32) -> bool) -> String {
    let units: Vec<u16> = s
        .encode_utf16()
        .filter(|&u| is_legal(u32::from(u)))
        .collect();
    utf16::units_to_string(&units)
}

/// `legalizeCharacters(isLegal)(s)`: keeps the code points for which
/// `is_legal` holds. Characters above U+FFFF are always dropped.
pub fn legalize_characters(s: &str, is_legal: impl Fn(u32) -> bool) -> String {
    s.chars()
        .filter(|&c| u32::from(c) <= 0xFFFF && is_legal(u32::from(c)))
        .collect()
}

/// `repeatString(s, n)`.
pub fn repeat_string(s: &str, n: usize) -> String {
    s.repeat(n)
}

/// `intToHex(i, width)`: lower-case hexadecimal, left-padded with zeros to
/// `width` digits (never truncated).
pub fn int_to_hex(i: u32, width: usize) -> String {
    format!("{i:0width$x}")
}

/// `standardUnicodeHexEscape(codePoint)`: `\uXXXX`, or `\UXXXXXXXX` above
/// U+FFFF.
pub fn standard_unicode_hex_escape(code_point: u32) -> String {
    if code_point <= 0xFFFF {
        format!("\\u{}", int_to_hex(code_point, 4))
    } else {
        format!("\\U{}", int_to_hex(code_point, 8))
    }
}

/// `escapeNonPrintableMapper(printablePredicate, escaper)`: escapes `\`,
/// `"`, LF and TAB with a backslash, keeps printable characters and passes
/// everything else to `escaper`.
pub fn escape_non_printable_mapper(
    printable_predicate: impl Fn(u32) -> bool,
    escaper: impl Fn(u32) -> String,
) -> impl Fn(u32) -> MapperOutput {
    move |u| match u {
        0x5C => "\\\\".into(),
        0x22 => "\\\"".into(),
        0x0A => "\\n".into(),
        0x09 => "\\t".into(),
        _ if printable_predicate(u) => MapperOutput::CharCode(u),
        _ => escaper(u).into(),
    }
}

/// `utf16StringEscape`: escapes per UTF-16 code unit, so an astral character
/// becomes two `\uDXXX` escapes.
pub fn utf16_string_escape(s: &str) -> String {
    utf16_concat_map(
        s,
        escape_non_printable_mapper(is_printable, standard_unicode_hex_escape),
    )
}

/// `stringEscape`: escapes per code point, so an astral character becomes
/// one `\UXXXXXXXX` escape.
pub fn string_escape(s: &str) -> String {
    utf32_concat_map(
        s,
        escape_non_printable_mapper(is_printable, standard_unicode_hex_escape),
    )
}

/// `isPrintable(codePoint)`: false above U+FFFF and for the categories `Cc`,
/// `Cf`, `Co`, `Cs`, `Zl` and `Zp`.
pub fn is_printable(code_point: u32) -> bool {
    use unicode::GeneralCategory::*;
    if code_point > 0xFFFF {
        return false;
    }
    matches!(
        unicode::get_category(code_point),
        Mc | No
            | Sk
            | Me
            | Nd
            | Po
            | Lt
            | Pc
            | Sm
            | Zs
            | Lu
            | Pd
            | So
            | Pe
            | Pf
            | Ps
            | Sc
            | Ll
            | Lm
            | Pi
            | Nl
            | Mn
            | Lo
    )
}

/// `isAscii(codePoint)`.
pub fn is_ascii(code_point: u32) -> bool {
    code_point < 128
}

/// `isLetter(codePoint)`: categories `Lu`, `Ll`, `Lt` and `Lo` (not `Lm`).
pub fn is_letter(code_point: u32) -> bool {
    use unicode::GeneralCategory::*;
    matches!(unicode::get_category(code_point), Lu | Ll | Lt | Lo)
}

/// `isDigit(codePoint)`: category `Nd`.
pub fn is_digit(code_point: u32) -> bool {
    unicode::is_digit(code_point)
}

/// `isNumeric(codePoint)`: categories `No`, `Nd` and `Nl`.
pub fn is_numeric(code_point: u32) -> bool {
    use unicode::GeneralCategory::*;
    matches!(unicode::get_category(code_point), No | Nd | Nl)
}

/// `isLetterOrDigit(codePoint)`.
pub fn is_letter_or_digit(code_point: u32) -> bool {
    is_letter(code_point) || is_digit(code_point)
}

/// `isLetterOrUnderscore(codePoint)`.
pub fn is_letter_or_underscore(code_point: u32) -> bool {
    is_letter(code_point) || code_point == 0x5F
}

/// `isLetterOrUnderscoreOrDigit(codePoint)`.
pub fn is_letter_or_underscore_or_digit(code_point: u32) -> bool {
    is_letter_or_underscore(code_point) || is_digit(code_point)
}

/// `isWordCharacter(codePoint)`: a letter or a decimal digit.
pub fn is_word_character(code_point: u32) -> bool {
    is_letter(code_point) || is_digit(code_point)
}

/// `trimEnd(str)`: strips trailing code units in the categories `Zs`, `Zl`
/// and `Zp`. Unlike JavaScript's `trimEnd()`, this keeps TAB, LF, CR and
/// U+FEFF.
pub fn trim_end(s: &str) -> &str {
    s.trim_end_matches(|c: char| c.len_utf16() == 1 && unicode::is_white_space(u32::from(c)))
}

/// `capitalize(str)`: `str[0].toUpperCase() + str.slice(1)`. Only the first
/// UTF-16 code unit changes, so an astral first character stays as is.
pub fn capitalize(s: &str) -> String {
    utf16::upper_first_unit(s)
}

/// `decapitalize(str)`: `str[0].toLowerCase() + str.slice(1)`.
pub fn decapitalize(s: &str) -> String {
    utf16::lower_first_unit(s)
}

/// `pascalCase(str)`: splits on runs of `-`, `_`, `.` and space, capitalizes
/// each part and joins them.
pub fn pascal_case(s: &str) -> String {
    // Splitting on single separators yields extra empty parts inside runs,
    // which capitalize to nothing, exactly like `split(/[-_. ]+/)`.
    s.split(['-', '_', '.', ' ']).map(capitalize).collect()
}

/// `camelCase(str)`: [`decapitalize`] of [`pascal_case`].
pub fn camel_case(s: &str) -> String {
    decapitalize(&pascal_case(s))
}

/// `snakeCase(str)`: the [`split_into_words`] words, lower-cased, joined
/// with `_`.
pub fn snake_case(s: &str) -> String {
    split_into_words(s)
        .iter()
        .map(|w| w.word.to_lowercase())
        .collect::<Vec<_>>()
        .join("_")
}

/// `startWithLetter(isAllowedStart, upper, str)`: `"empty"` for an empty
/// string, else `str`, prefixed with `"the"` unless its first UTF-16 code
/// unit satisfies `is_allowed_start`; then capitalized or decapitalized.
pub fn start_with_letter(is_allowed_start: impl Fn(u32) -> bool, upper: bool, s: &str) -> String {
    let modify = if upper { capitalize } else { decapitalize };
    match s.encode_utf16().next() {
        None => modify("empty"),
        Some(first) if is_allowed_start(u32::from(first)) => modify(s),
        Some(_) => modify(&format!("the{s}")),
    }
}

/// `WordInName`: one word of a name, as [`split_into_words`] finds it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct WordInName {
    /// The word's text.
    pub word: String,
    /// Whether the word is styled as an acronym.
    pub is_acronym: bool,
}

/// `fastIsUpperCase(codePoint)`: category `Lu`.
pub fn fast_is_upper_case(code_point: u32) -> bool {
    unicode::is_upper_case(code_point)
}

fn fast_is_lower_case(code_point: u32) -> bool {
    unicode::is_lower_case(code_point)
}

fn fast_non_letter(code_point: u32) -> bool {
    !unicode::is_lower_case(code_point) && !unicode::is_upper_case(code_point)
}

/// The state of `splitIntoWords`' closures.
struct WordSplitter {
    units: Vec<u16>,
    i: usize,
    last_lower_case_index: Option<usize>,
    interval_start: Option<usize>,
    /// `[start, end, allUpper]` in UTF-16 code units.
    intervals: Vec<(usize, usize, bool)>,
}

impl WordSplitter {
    fn at_end(&self) -> bool {
        self.i >= self.units.len()
    }

    /// `s.codePointAt(i)`: at the low half of a pair, the low surrogate.
    fn current_code_point(&self) -> u32 {
        utf16::code_point_at_units(&self.units, self.i).unwrap_or(0)
    }

    /// Advances one code unit at a time while `p` holds for the code point at
    /// the current unit, noting where lower-case letters were seen.
    fn skip_while(&mut self, p: fn(u32) -> bool) {
        while !self.at_end() {
            let cp = self.current_code_point();
            if !p(cp) {
                break;
            }
            if fast_is_lower_case(cp) {
                self.last_lower_case_index = Some(self.i);
            }
            self.i += 1;
        }
    }

    fn start_interval(&mut self) {
        debug_assert!(
            self.interval_start.is_none(),
            "Interval started before last one was committed"
        );
        self.interval_start = Some(self.i);
    }

    fn interval_length(&self) -> usize {
        self.interval_start.map_or(0, |start| self.i - start)
    }

    fn commit_interval(&mut self) {
        let Some(start) = self.interval_start.take() else {
            debug_assert!(false, "Tried to commit interval without starting one");
            return;
        };
        debug_assert!(self.i > start, "Interval must be non-empty");
        // Never end a word between the halves of a surrogate pair.
        if !self.at_end() && utf16::is_low_surrogate(self.units[self.i]) {
            self.i += 1;
        }
        let all_upper = self.last_lower_case_index.is_none_or(|last| last < start);
        self.intervals.push((start, self.i, all_upper));
    }
}

/// `splitIntoWords(s)`: splits a name into words at case changes, digits and
/// non-word characters (`"XMLHttpRequest"` → `XML`, `Http`, `Request`;
/// `"ABC123def"` → `ABC123`, `def`).
///
/// It walks UTF-16 code units, reading the code point at each unit (so the
/// low half of a pair is seen on its own, as category `Cs`). A word is an
/// acronym if it is all upper case in a name that has some lower case, or if
/// it is one of the [`ACRONYMS`](super::acronyms_const::ACRONYMS).
pub fn split_into_words(s: &str) -> Vec<WordInName> {
    let mut sp = WordSplitter {
        units: s.encode_utf16().collect(),
        i: 0,
        last_lower_case_index: None,
        interval_start: None,
        intervals: Vec::new(),
    };

    loop {
        sp.skip_while(|cp| !is_word_character(cp));
        if sp.at_end() {
            break;
        }

        sp.start_interval();
        if fast_is_lower_case(sp.current_code_point()) {
            sp.skip_while(fast_is_lower_case);
            sp.skip_while(is_digit);
            sp.commit_interval();
        } else if fast_is_upper_case(sp.current_code_point()) {
            sp.skip_while(fast_is_upper_case);
            if sp.at_end() {
                sp.commit_interval();
            } else if sp.interval_length() == 1 {
                sp.skip_while(fast_is_lower_case);
                sp.skip_while(is_digit);
                sp.commit_interval();
            } else if is_digit(sp.current_code_point()) {
                sp.skip_while(is_digit);
                sp.commit_interval();
            } else {
                if is_word_character(sp.current_code_point()) {
                    sp.i -= 1;
                }
                sp.commit_interval();
            }
        } else {
            sp.skip_while(fast_non_letter);
            sp.commit_interval();
        }
    }

    let has_lower_case = sp.last_lower_case_index.is_some();
    sp.intervals
        .iter()
        .map(|&(start, end, all_upper)| {
            let word = utf16::units_to_string(&sp.units[start..end]);
            let is_acronym =
                (has_lower_case && all_upper) || is_known_acronym(&word.to_lowercase());
            WordInName { word, is_acronym }
        })
        .collect()
}

/// `WordStyle`: how to case one word.
pub type WordStyle<'a> = &'a dyn Fn(&str) -> String;

/// `firstUpperWordStyle(s)`: `s[0].toUpperCase() + s.slice(1).toLowerCase()`.
pub fn first_upper_word_style(s: &str) -> String {
    debug_assert!(!s.is_empty(), "Cannot style an empty string");
    utf16::map_first_unit(s, |c| c.to_uppercase().collect(), str::to_lowercase)
}

/// `allUpperWordStyle(s)`: `s.toUpperCase()`.
pub fn all_upper_word_style(s: &str) -> String {
    s.to_uppercase()
}

/// `originalWord(s)`: `s` unchanged.
pub fn original_word(s: &str) -> String {
    s.to_owned()
}

/// `allLowerWordStyle(s)`: `s.toLowerCase()`.
pub fn all_lower_word_style(s: &str) -> String {
    s.to_lowercase()
}

fn style_word(style: WordStyle<'_>, word: &str) -> String {
    debug_assert!(!word.is_empty(), "Tried to style an empty word");
    let result = style(word);
    debug_assert!(!result.is_empty(), "Word style must not make word empty");
    result
}

/// `combineWords(...)`: legalizes the words (dropping those that become
/// empty, falling back to `"empty"`), styles them and joins them with
/// `separator`. If the styled first word does not begin with a start
/// character, `"the"` is prepended and every word, the first included, gets
/// the rest styles.
#[allow(clippy::too_many_arguments)]
pub fn combine_words(
    words: &[WordInName],
    remove_invalid_characters: &dyn Fn(&str) -> String,
    first_word_style: WordStyle<'_>,
    rest_word_style: WordStyle<'_>,
    first_word_acronym_style: WordStyle<'_>,
    rest_acronym_style: WordStyle<'_>,
    separator: &str,
    is_start_character: &dyn Fn(u32) -> bool,
) -> String {
    let mut legalized_words: Vec<WordInName> = words
        .iter()
        .filter_map(|w| {
            let word = remove_invalid_characters(&w.word);
            (!word.is_empty()).then_some(WordInName {
                word,
                is_acronym: w.is_acronym,
            })
        })
        .collect();

    if legalized_words.is_empty() {
        let valid_empty = remove_invalid_characters("empty");
        debug_assert!(
            !valid_empty.is_empty(),
            "Word \"empty\" is invalid in target language"
        );
        legalized_words.push(WordInName {
            word: valid_empty,
            is_acronym: false,
        });
    }

    let mut styled_words = Vec::with_capacity(legalized_words.len() + 1);
    let first = &legalized_words[0];
    let first_style = if first.is_acronym {
        first_word_acronym_style
    } else {
        first_word_style
    };
    let styled_first_word = style_word(first_style, &first.word);
    let starts_well = styled_first_word
        .chars()
        .next()
        .is_some_and(|c| is_start_character(u32::from(c)));
    let rest_words = if starts_well {
        styled_words.push(styled_first_word);
        &legalized_words[1..]
    } else {
        let valid_the = remove_invalid_characters("the");
        debug_assert!(
            !valid_the.is_empty(),
            "Word \"the\" is invalid in the target language"
        );
        let styled_the = style_word(first_word_style, &valid_the);
        debug_assert!(
            styled_the
                .chars()
                .next()
                .is_some_and(|c| is_start_character(u32::from(c))),
            "The first character of styling \"the\" is not a start character"
        );
        styled_words.push(styled_the);
        &legalized_words[..]
    };

    for w in rest_words {
        let style = if w.is_acronym {
            rest_acronym_style
        } else {
            rest_word_style
        };
        styled_words.push(style_word(style, &w.word));
    }

    styled_words.join(separator)
}

/// `addPrefixIfNecessary(prefix, name)`: `prefix + name`, unless `name`
/// already starts with `prefix`.
pub fn add_prefix_if_necessary(prefix: &str, name: &str) -> String {
    if name.starts_with(prefix) {
        name.to_owned()
    } else {
        format!("{prefix}{name}")
    }
}

/// `makeNameStyle(namingStyle, legalizeName, prefix)`: a function that turns
/// a raw name into a legal name in `naming_style`, optionally prefixed.
///
/// `"original"` does not split or restyle the name but still legalizes it
/// and fixes up empty names and invalid start characters.
pub fn make_name_style<L>(
    naming_style: NamingStyle,
    legalize_name: L,
    prefix: Option<&str>,
) -> impl Fn(&str) -> String + use<L>
where
    L: Fn(&str) -> String,
{
    type Style = fn(&str) -> String;
    let (
        separator,
        first_word_style,
        rest_word_style,
        first_word_acronym_style,
        rest_acronym_style,
    ): (&'static str, Style, Style, Style, Style) = match naming_style {
        NamingStyle::Pascal => (
            "",
            first_upper_word_style,
            first_upper_word_style,
            first_upper_word_style,
            first_upper_word_style,
        ),
        NamingStyle::Camel => (
            "",
            all_lower_word_style,
            first_upper_word_style,
            all_lower_word_style,
            first_upper_word_style,
        ),
        NamingStyle::PascalUpperAcronyms => (
            "",
            first_upper_word_style,
            first_upper_word_style,
            first_upper_word_style,
            all_upper_word_style,
        ),
        NamingStyle::CamelUpperAcronyms => (
            "",
            all_lower_word_style,
            first_upper_word_style,
            all_lower_word_style,
            all_upper_word_style,
        ),
        NamingStyle::Original => (
            "",
            original_word,
            original_word,
            original_word,
            original_word,
        ),
        NamingStyle::Underscore => (
            "_",
            all_lower_word_style,
            all_lower_word_style,
            all_lower_word_style,
            all_lower_word_style,
        ),
        NamingStyle::UpperUnderscore => (
            "_",
            all_upper_word_style,
            all_upper_word_style,
            all_upper_word_style,
            all_upper_word_style,
        ),
    };
    let prefix = prefix.map(str::to_owned);

    move |original: &str| {
        let words = if naming_style == NamingStyle::Original {
            vec![WordInName {
                word: original.to_owned(),
                is_acronym: false,
            }]
        } else {
            split_into_words(original)
        };
        let styled_name = combine_words(
            &words,
            &legalize_name,
            &first_word_style,
            &rest_word_style,
            &first_word_acronym_style,
            &rest_acronym_style,
            separator,
            &is_letter_or_underscore,
        );
        match &prefix {
            Some(prefix) => add_prefix_if_necessary(prefix, &styled_name),
            None => styled_name,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn words(s: &str) -> Vec<(String, bool)> {
        split_into_words(s)
            .into_iter()
            .map(|w| (w.word, w.is_acronym))
            .collect()
    }

    #[test]
    fn splits_like_typescript() {
        let w = |word: &str, acronym| (word.to_owned(), acronym);
        assert_eq!(
            words("XMLHttpRequest"),
            [w("XML", true), w("Http", true), w("Request", false)]
        );
        assert_eq!(words("iOS"), [w("i", false), w("OS", true)]);
        assert_eq!(words("123 abc"), [w("123 ", true), w("abc", false)]);
        assert_eq!(words("𝐀𝐁c"), [w("𝐀", true), w("𝐁", true), w("c", false)]);
        assert_eq!(words("a😀b"), [w("a", false), w("b", false)]);
    }

    #[test]
    fn name_styles() {
        let legalize = |s: &str| {
            legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
        };
        let style = |style, name| make_name_style(style, legalize, None)(name);
        assert_eq!(style(NamingStyle::Pascal, "123abc"), "The123Abc");
        assert_eq!(style(NamingStyle::Camel, "123abc"), "the123Abc");
        assert_eq!(style(NamingStyle::Underscore, "123abc"), "the_123_abc");
        assert_eq!(style(NamingStyle::UpperUnderscore, "123abc"), "THE_123_ABC");
        assert_eq!(style(NamingStyle::Pascal, "URLValue"), "UrlValue");
        assert_eq!(style(NamingStyle::PascalUpperAcronyms, "jsonID"), "JsonID");
        assert_eq!(style(NamingStyle::Original, "ß_test"), "_test");
        let prefixed = make_name_style(NamingStyle::Pascal, legalize, Some("Qt"));
        assert_eq!(prefixed("qt_foo"), "QtFoo");
        assert_eq!(prefixed("foo"), "QtFoo");
    }

    #[test]
    fn escapes() {
        assert_eq!(
            utf16_string_escape("a\"😀\u{1}"),
            "a\\\"\\ud83d\\ude00\\u0001"
        );
        assert_eq!(string_escape("a\"😀\u{1}"), "a\\\"\\U0001f600\\u0001");
        assert_eq!(legalize_characters("a😀b", |_| true), "ab");
        assert_eq!(trim_end("ab \t\n\u{a0} "), "ab \t\n");
    }
}
