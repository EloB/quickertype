//! Port of the npm package `unicode-properties` 1.4.1, as far as quicktype
//! uses it.
//!
//! quicktype classifies characters with `unicode-properties`, not with the
//! JavaScript engine, so its answers come from that package's **Unicode 12.0**
//! data. Two things set it apart from Rust's `char` methods or any current
//! Unicode crate:
//!
//! - The data is Unicode 12.0. Characters assigned later (U+0870, U+1FAD0,
//!   U+32FF, ...) are unassigned here.
//! - There is no `Cn` category: unassigned code points, noncharacters and
//!   values above U+10FFFF all report **`Cc`**.
//!
//! The category table is generated from the installed npm package by
//! `xtask/js-compat/gen-unicode.mjs`. Functions take a `u32` because quicktype
//! passes both code points and single UTF-16 code units; a lone surrogate unit
//! has category [`GeneralCategory::Cs`].
//!
//! Out of scope (quicktype never calls them): `getCombiningClass`, `getScript`,
//! `getEastAsianWidth`, `getNumericValue`, `isPunctuation`, `isTitleCase`,
//! `isBaseForm` and `isMark`.

use crate::unicode_table::CATEGORY_RUNS;

/// A Unicode general category, as `unicode-properties` reports it.
///
/// The variants are the 29 strings `getCategory` can return. `Cn`
/// (unassigned) is deliberately missing: the package reports `Cc` instead.
#[allow(missing_docs)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum GeneralCategory {
    Cc,
    Zs,
    Po,
    Sc,
    Ps,
    Pe,
    Sm,
    Pd,
    Nd,
    Lu,
    Sk,
    Pc,
    Ll,
    So,
    Lo,
    Pi,
    Cf,
    No,
    Pf,
    Lt,
    Lm,
    Mn,
    Me,
    Mc,
    Nl,
    Zl,
    Zp,
    Cs,
    Co,
}

impl GeneralCategory {
    /// The two-letter name `getCategory` returns, e.g. `"Lu"`.
    pub fn as_str(self) -> &'static str {
        use GeneralCategory::*;
        match self {
            Cc => "Cc",
            Zs => "Zs",
            Po => "Po",
            Sc => "Sc",
            Ps => "Ps",
            Pe => "Pe",
            Sm => "Sm",
            Pd => "Pd",
            Nd => "Nd",
            Lu => "Lu",
            Sk => "Sk",
            Pc => "Pc",
            Ll => "Ll",
            So => "So",
            Lo => "Lo",
            Pi => "Pi",
            Cf => "Cf",
            No => "No",
            Pf => "Pf",
            Lt => "Lt",
            Lm => "Lm",
            Mn => "Mn",
            Me => "Me",
            Mc => "Mc",
            Nl => "Nl",
            Zl => "Zl",
            Zp => "Zp",
            Cs => "Cs",
            Co => "Co",
        }
    }
}

impl std::fmt::Display for GeneralCategory {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str(self.as_str())
    }
}

/// `unicode.getCategory(codePoint)`.
///
/// Values above U+10FFFF return [`GeneralCategory::Cc`], like the package's
/// trie error value.
pub fn get_category(code_point: u32) -> GeneralCategory {
    if let Some(&category) = LATIN1.get(code_point as usize) {
        return category;
    }
    if code_point > 0x10FFFF {
        return GeneralCategory::Cc;
    }
    // The first run starts at 0, so the partition point is at least 1.
    let run = CATEGORY_RUNS.partition_point(|&(start, _)| start <= code_point);
    CATEGORY_RUNS
        .get(run.wrapping_sub(1))
        .map_or(GeneralCategory::Cc, |&(_, category)| category)
}

/// The categories of U+0000 to U+00FF, where nearly all the characters of
/// names are: a table lookup instead of a binary search over the runs.
static LATIN1: [GeneralCategory; 256] = {
    let mut table = [GeneralCategory::Cc; 256];
    let mut run = 0;
    let mut code_point = 0;
    while code_point < 256 {
        while run + 1 < CATEGORY_RUNS.len() && CATEGORY_RUNS[run + 1].0 <= code_point as u32 {
            run += 1;
        }
        table[code_point] = CATEGORY_RUNS[run].1;
        code_point += 1;
    }
    table
};

/// `unicode.isAlphabetic(codePoint)`: category `Lu`, `Ll`, `Lt`, `Lm`, `Lo` or
/// `Nl`. This is category-based, not Unicode's `Alphabetic` property.
pub fn is_alphabetic(code_point: u32) -> bool {
    use GeneralCategory::*;
    matches!(get_category(code_point), Lu | Ll | Lt | Lm | Lo | Nl)
}

/// `unicode.isDigit(codePoint)`: category `Nd`.
pub fn is_digit(code_point: u32) -> bool {
    get_category(code_point) == GeneralCategory::Nd
}

/// `unicode.isLowerCase(codePoint)`: category `Ll`.
pub fn is_lower_case(code_point: u32) -> bool {
    get_category(code_point) == GeneralCategory::Ll
}

/// `unicode.isUpperCase(codePoint)`: category `Lu`.
pub fn is_upper_case(code_point: u32) -> bool {
    get_category(code_point) == GeneralCategory::Lu
}

/// `unicode.isWhiteSpace(codePoint)`: category `Zs`, `Zl` or `Zp`.
///
/// Unlike JavaScript's `\s`, this excludes TAB, LF, CR and U+FEFF.
pub fn is_white_space(code_point: u32) -> bool {
    use GeneralCategory::*;
    matches!(get_category(code_point), Zs | Zl | Zp)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_latin1_table_agrees_with_the_runs() {
        for code_point in 0..256u32 {
            let run = CATEGORY_RUNS.partition_point(|&(start, _)| start <= code_point);
            assert_eq!(
                get_category(code_point),
                CATEGORY_RUNS[run - 1].1,
                "U+{code_point:04X}"
            );
        }
    }

    #[test]
    fn table_is_sorted_and_starts_at_zero() {
        assert_eq!(CATEGORY_RUNS[0].0, 0);
        assert!(
            CATEGORY_RUNS
                .windows(2)
                .all(|w| w[0].0 < w[1].0 && w[0].1 != w[1].1)
        );
        assert!(
            CATEGORY_RUNS
                .last()
                .is_some_and(|&(start, _)| start <= 0x10FFFF)
        );
    }

    #[test]
    fn spot_checks() {
        use GeneralCategory::*;
        assert_eq!(get_category('A' as u32), Lu);
        assert_eq!(get_category('a' as u32), Ll);
        assert_eq!(get_category(0x0295), Ll); // Lo in current Unicode
        assert_eq!(get_category(0xD800), Cs);
        assert_eq!(get_category(0x0870), Cc); // assigned after Unicode 12.0
        assert_eq!(get_category(0x110000), Cc);
        assert_eq!(get_category(u32::MAX), Cc);
        assert!(!is_white_space('\t' as u32));
        assert!(is_white_space(0x00A0));
        assert!(is_alphabetic(0x16EE)); // Nl
    }
}
