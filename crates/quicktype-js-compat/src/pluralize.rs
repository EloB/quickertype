//! Port of the npm package `pluralize` 8.0.0.
//!
//! quicktype calls `pluralize.singular` to name the element type of an array
//! property (`users` → `User`). This reproduces the library exactly:
//!
//! - **Tables.** The 47 irregular pairs, 25 plural rules, 23 singular rules,
//!   94 uncountable words and 8 uncountable patterns are copied verbatim, in
//!   the library's order; later definitions overwrite earlier ones (`they`
//!   singularizes to `she`, not `he`).
//! - **Lookup.** `token = word.toLowerCase()`. A token that is already in the
//!   target form keeps it, an irregular is replaced, an uncountable (or empty)
//!   word is returned unchanged, and otherwise the rules are tried **from the
//!   last added to the first**; the first rule whose pattern matches rewrites
//!   its first match.
//! - **Case.** `restoreCase` copies the matched text's case onto the
//!   replacement: exact, all lower, all upper, or title case (`word[0]` equals
//!   its own upper case), else lower case. It works on UTF-16 code units, like
//!   everything in JavaScript.
//!
//! The rules are JavaScript regular expressions with the `i` flag and without
//! `u`. They are translated to `regex`-crate syntax with JavaScript's meaning
//! (see `translate`): ASCII-only case folding (`/s$/i` matches `S` but not
//! `ſ` U+017F; `/k/i` does not match the Kelvin sign U+212A), ASCII `\w` and
//! `\b`, and matching on UTF-16 code units, so that a negated class like
//! `[^aeiou]` consumes half of a surrogate pair exactly as JavaScript does.

use std::sync::LazyLock;

use indexmap::{IndexMap, IndexSet};
use regex::{Captures, Regex};

use crate::{number, utf16};

/// `[single, plural]` pairs, in the order `pluralize.js` adds them.
const IRREGULAR_RULES: &[(&str, &str)] = &[
    // Pronouns.
    ("I", "we"),
    ("me", "us"),
    ("he", "they"),
    ("she", "they"),
    ("them", "them"),
    ("myself", "ourselves"),
    ("yourself", "yourselves"),
    ("itself", "themselves"),
    ("herself", "themselves"),
    ("himself", "themselves"),
    ("themself", "themselves"),
    ("is", "are"),
    ("was", "were"),
    ("has", "have"),
    ("this", "these"),
    ("that", "those"),
    // Words ending in with a consonant and `o`.
    ("echo", "echoes"),
    ("dingo", "dingoes"),
    ("volcano", "volcanoes"),
    ("tornado", "tornadoes"),
    ("torpedo", "torpedoes"),
    // Ends with `us`.
    ("genus", "genera"),
    ("viscus", "viscera"),
    // Ends with `ma`.
    ("stigma", "stigmata"),
    ("stoma", "stomata"),
    ("dogma", "dogmata"),
    ("lemma", "lemmata"),
    ("schema", "schemata"),
    ("anathema", "anathemata"),
    // Other irregular rules.
    ("ox", "oxen"),
    ("axe", "axes"),
    ("die", "dice"),
    ("yes", "yeses"),
    ("foot", "feet"),
    ("eave", "eaves"),
    ("goose", "geese"),
    ("tooth", "teeth"),
    ("quiz", "quizzes"),
    ("human", "humans"),
    ("proof", "proofs"),
    ("carve", "carves"),
    ("valve", "valves"),
    ("looey", "looies"),
    ("thief", "thieves"),
    ("groove", "grooves"),
    ("pickaxe", "pickaxes"),
    ("passerby", "passersby"),
];

/// Pluralization rules: a JavaScript regex literal, or a plain word (which
/// `sanitizeRule` turns into `/^word$/i`), and its replacement.
const PLURAL_RULES: &[(&str, &str)] = &[
    (r"/s?$/i", "s"),
    (r"/[^\u0000-\u007F]$/i", "$0"),
    (r"/([^aeiou]ese)$/i", "$1"),
    (r"/(ax|test)is$/i", "$1es"),
    (r"/(alias|[^aou]us|t[lm]as|gas|ris)$/i", "$1es"),
    (r"/(e[mn]u)s?$/i", "$1s"),
    (r"/([^l]ias|[aeiou]las|[ejzr]as|[iu]am)$/i", "$1"),
    (
        r"/(alumn|syllab|vir|radi|nucle|fung|cact|stimul|termin|bacill|foc|uter|loc|strat)(?:us|i)$/i",
        "$1i",
    ),
    (r"/(alumn|alg|vertebr)(?:a|ae)$/i", "$1ae"),
    (r"/(seraph|cherub)(?:im)?$/i", "$1im"),
    (r"/(her|at|gr)o$/i", "$1oes"),
    (
        r"/(agend|addend|millenni|dat|extrem|bacteri|desiderat|strat|candelabr|errat|ov|symposi|curricul|automat|quor)(?:a|um)$/i",
        "$1a",
    ),
    (
        r"/(apheli|hyperbat|periheli|asyndet|noumen|phenomen|criteri|organ|prolegomen|hedr|automat)(?:a|on)$/i",
        "$1a",
    ),
    (r"/sis$/i", "ses"),
    (r"/(?:(kni|wi|li)fe|(ar|l|ea|eo|oa|hoo)f)$/i", "$1$2ves"),
    (r"/([^aeiouy]|qu)y$/i", "$1ies"),
    (r"/([^ch][ieo][ln])ey$/i", "$1ies"),
    (r"/(x|ch|ss|sh|zz)$/i", "$1es"),
    (r"/(matr|cod|mur|sil|vert|ind|append)(?:ix|ex)$/i", "$1ices"),
    (r"/\b((?:tit)?m|l)(?:ice|ouse)$/i", "$1ice"),
    (r"/(pe)(?:rson|ople)$/i", "$1ople"),
    (r"/(child)(?:ren)?$/i", "$1ren"),
    (r"/eaux$/i", "$0"),
    (r"/m[ae]n$/i", "men"),
    ("thou", "you"),
];

/// Singularization rules, as for [`PLURAL_RULES`].
const SINGULAR_RULES: &[(&str, &str)] = &[
    (r"/s$/i", ""),
    (r"/(ss)$/i", "$1"),
    (
        r"/(wi|kni|(?:after|half|high|low|mid|non|night|[^\w]|^)li)ves$/i",
        "$1fe",
    ),
    (r"/(ar|(?:wo|[ae])l|[eo][ao])ves$/i", "$1f"),
    (r"/ies$/i", "y"),
    (
        r"/\b([pl]|zomb|(?:neck|cross)?t|coll|faer|food|gen|goon|group|lass|talk|goal|cut)ies$/i",
        "$1ie",
    ),
    (r"/\b(mon|smil)ies$/i", "$1ey"),
    (r"/\b((?:tit)?m|l)ice$/i", "$1ouse"),
    (r"/(seraph|cherub)im$/i", "$1"),
    (
        r"/(x|ch|ss|sh|zz|tto|go|cho|alias|[^aou]us|t[lm]as|gas|(?:her|at|gr)o|[aeiou]ris)(?:es)?$/i",
        "$1",
    ),
    (
        r"/(analy|diagno|parenthe|progno|synop|the|empha|cri|ne)(?:sis|ses)$/i",
        "$1sis",
    ),
    (r"/(movie|twelve|abuse|e[mn]u)s$/i", "$1"),
    (r"/(test)(?:is|es)$/i", "$1is"),
    (
        r"/(alumn|syllab|vir|radi|nucle|fung|cact|stimul|termin|bacill|foc|uter|loc|strat)(?:us|i)$/i",
        "$1us",
    ),
    (
        r"/(agend|addend|millenni|dat|extrem|bacteri|desiderat|strat|candelabr|errat|ov|symposi|curricul|quor)a$/i",
        "$1um",
    ),
    (
        r"/(apheli|hyperbat|periheli|asyndet|noumen|phenomen|criteri|organ|prolegomen|hedr|automat)a$/i",
        "$1on",
    ),
    (r"/(alumn|alg|vertebr)ae$/i", "$1a"),
    (r"/(cod|mur|sil|vert|ind)ices$/i", "$1ex"),
    (r"/(matr|append)ices$/i", "$1ix"),
    (r"/(pe)(rson|ople)$/i", "$1rson"),
    (r"/(child)ren$/i", "$1"),
    (r"/(eau)x?$/i", "$1"),
    (r"/men$/i", "man"),
];

/// Uncountable words and patterns, in order. Words go into a lookup set;
/// patterns become both a plural and a singular rule with replacement `$0`.
const UNCOUNTABLE_RULES: &[&str] = &[
    // Singular words with no plurals.
    "adulthood",
    "advice",
    "agenda",
    "aid",
    "aircraft",
    "alcohol",
    "ammo",
    "analytics",
    "anime",
    "athletics",
    "audio",
    "bison",
    "blood",
    "bream",
    "buffalo",
    "butter",
    "carp",
    "cash",
    "chassis",
    "chess",
    "clothing",
    "cod",
    "commerce",
    "cooperation",
    "corps",
    "debris",
    "diabetes",
    "digestion",
    "elk",
    "energy",
    "equipment",
    "excretion",
    "expertise",
    "firmware",
    "flounder",
    "fun",
    "gallows",
    "garbage",
    "graffiti",
    "hardware",
    "headquarters",
    "health",
    "herpes",
    "highjinks",
    "homework",
    "housework",
    "information",
    "jeans",
    "justice",
    "kudos",
    "labour",
    "literature",
    "machinery",
    "mackerel",
    "mail",
    "media",
    "mews",
    "moose",
    "music",
    "mud",
    "manga",
    "news",
    "only",
    "personnel",
    "pike",
    "plankton",
    "pliers",
    "police",
    "pollution",
    "premises",
    "rain",
    "research",
    "rice",
    "salmon",
    "scissors",
    "series",
    "sewage",
    "shambles",
    "shrimp",
    "software",
    "species",
    "staff",
    "swine",
    "tennis",
    "traffic",
    "transportation",
    "trout",
    "tuna",
    "wealth",
    "welfare",
    "whiting",
    "wildebeest",
    "wildlife",
    "you",
    "/pok[eé]mon$/i",
    // Regexes.
    "/[^aeiou]ese$/i", // "chinese", "japanese"
    "/deer$/i",        // "deer", "reindeer"
    "/fish$/i",        // "fish", "blowfish", "angelfish"
    "/measles$/i",
    "/o[iu]s$/i", // "carnivorous"
    "/pox$/i",    // "chickpox", "smallpox"
    "/sheep$/i",
];

struct Rule {
    regex: Regex,
    replacement: &'static str,
}

struct Tables {
    plural_rules: Vec<Rule>,
    singular_rules: Vec<Rule>,
    uncountables: IndexSet<String>,
    /// Singular → plural.
    irregular_singles: IndexMap<String, String>,
    /// Plural → singular.
    irregular_plurals: IndexMap<String, String>,
}

static TABLES: LazyLock<Tables> = LazyLock::new(|| {
    let mut tables = Tables {
        plural_rules: Vec::new(),
        singular_rules: Vec::new(),
        uncountables: IndexSet::new(),
        irregular_singles: IndexMap::new(),
        irregular_plurals: IndexMap::new(),
    };
    for &(single, plural) in IRREGULAR_RULES {
        let (single, plural) = (single.to_lowercase(), plural.to_lowercase());
        tables
            .irregular_singles
            .insert(single.clone(), plural.clone());
        tables.irregular_plurals.insert(plural, single);
    }
    for &(rule, replacement) in PLURAL_RULES {
        tables.plural_rules.push(sanitize_rule(rule, replacement));
    }
    for &(rule, replacement) in SINGULAR_RULES {
        tables.singular_rules.push(sanitize_rule(rule, replacement));
    }
    for &rule in UNCOUNTABLE_RULES {
        if rule.starts_with('/') {
            tables.plural_rules.push(sanitize_rule(rule, "$0"));
            tables.singular_rules.push(sanitize_rule(rule, "$0"));
        } else {
            tables.uncountables.insert(rule.to_lowercase());
        }
    }
    tables
});

/// `sanitizeRule`: compiles a `/source/i` literal, or a plain word as
/// `/^word$/i`.
fn sanitize_rule(rule: &str, replacement: &'static str) -> Rule {
    let source = match rule.strip_prefix('/').and_then(|r| r.strip_suffix("/i")) {
        Some(source) => source.to_owned(),
        None => format!("^{rule}$"),
    };
    let regex = Regex::new(&translate(&source))
        .unwrap_or_else(|e| panic!("pluralize rule {rule} does not translate: {e}"));
    Rule { regex, replacement }
}

/// Translates the source of a JavaScript regex with flag `i` (and without
/// `u`) into an equivalent `regex`-crate pattern, for the syntax the rules
/// use: literals, groups, alternation, `?`, `^`, `$`, `\b`, `\w`, `\uXXXX`
/// and character classes.
///
/// Without `u`, JavaScript folds case only between characters whose simple
/// upper-case forms agree, and never maps a non-ASCII character to an ASCII
/// one, so `s` matches `s`/`S` only. Each letter therefore becomes an explicit
/// class of its two forms. `\w` and `\b` are ASCII-only.
fn translate(source: &str) -> String {
    let mut out = String::new();
    let mut chars = source.chars().peekable();
    while let Some(c) = chars.next() {
        match c {
            '\\' => match chars.next() {
                Some('b') => out.push_str(r"(?-u:\b)"),
                Some('w') => out.push_str("[0-9A-Za-z_]"),
                Some('u') => {
                    let code = read_hex4(&mut chars);
                    push_class(&mut out, false, &case_variants(code, code));
                }
                Some(other) => {
                    out.push('\\');
                    out.push(other);
                }
                None => out.push_str(r"\\"),
            },
            '[' => {
                let negated = chars.next_if_eq(&'^').is_some();
                let mut ranges = Vec::new();
                while let Some(item) = chars.next() {
                    let low = match item {
                        ']' => break,
                        '\\' => match chars.next() {
                            Some('w') => {
                                ranges.extend([
                                    (0x30, 0x39),
                                    (0x41, 0x5A),
                                    (0x61, 0x7A),
                                    (0x5F, 0x5F),
                                ]);
                                continue;
                            }
                            Some('u') => read_hex4(&mut chars),
                            Some(other) => u32::from(other),
                            None => break,
                        },
                        other => u32::from(other),
                    };
                    let high = if chars.peek() == Some(&'-') {
                        chars.next();
                        match chars.next() {
                            Some('\\') => match chars.next() {
                                Some('u') => read_hex4(&mut chars),
                                Some(other) => u32::from(other),
                                None => low,
                            },
                            Some(other) => u32::from(other),
                            None => low,
                        }
                    } else {
                        low
                    };
                    ranges.extend(case_variants(low, high));
                }
                push_class(&mut out, negated, &ranges);
            }
            c if c.is_alphabetic() => {
                push_class(&mut out, false, &case_variants(u32::from(c), u32::from(c)));
            }
            c => out.push(c),
        }
    }
    out
}

fn read_hex4(chars: &mut std::iter::Peekable<std::str::Chars<'_>>) -> u32 {
    let hex: String = chars.take(4).collect();
    u32::from_str_radix(&hex, 16).unwrap_or(0)
}

/// The range `low..=high` plus, for letters, the ranges of their other case
/// under JavaScript's non-Unicode `/i` (ASCII letters pair with ASCII
/// letters; a non-ASCII letter pairs with its single-character non-ASCII
/// upper/lower case).
fn case_variants(low: u32, high: u32) -> Vec<(u32, u32)> {
    let mut ranges = vec![(low, high)];
    let ascii_lower = u32::from(b'a')..=u32::from(b'z');
    let ascii_upper = u32::from(b'A')..=u32::from(b'Z');
    if ascii_lower.contains(&low) && ascii_lower.contains(&high) {
        ranges.push((low - 32, high - 32));
    } else if ascii_upper.contains(&low) && ascii_upper.contains(&high) {
        ranges.push((low + 32, high + 32));
    } else if low == high && low >= 0x80 {
        if let Some(c) = char::from_u32(low) {
            for other in [single_char(c.to_uppercase()), single_char(c.to_lowercase())] {
                if let Some(other) = other.filter(|o| !o.is_ascii() && *o != c) {
                    ranges.push((u32::from(other), u32::from(other)));
                }
            }
        }
    }
    ranges
}

fn single_char(mut mapping: impl Iterator<Item = char>) -> Option<char> {
    let first = mapping.next()?;
    mapping.next().is_none().then_some(first)
}

fn push_class(out: &mut String, negated: bool, ranges: &[(u32, u32)]) {
    out.push('[');
    if negated {
        out.push('^');
    }
    for &(low, high) in ranges {
        out.push_str(&format!(r"\x{{{low:X}}}"));
        if high != low {
            out.push_str(&format!(r"-\x{{{high:X}}}"));
        }
    }
    out.push(']');
}

/// Encodes UTF-16 code units as a string with one `char` per unit, so that
/// regexes see JavaScript's units: surrogates map to the private-use
/// characters U+F0000–U+F07FF (no case, not word characters), every other
/// unit to itself.
fn encode_units(units: &[u16]) -> String {
    units
        .iter()
        .map(|&unit| {
            let code = u32::from(unit);
            let mapped = if (0xD800..=0xDFFF).contains(&code) {
                0xF0000 + (code - 0xD800)
            } else {
                code
            };
            char::from_u32(mapped).unwrap_or(char::REPLACEMENT_CHARACTER)
        })
        .collect()
}

/// The inverse of [`encode_units`].
fn decode_units(encoded: &str) -> Vec<u16> {
    encoded
        .chars()
        .map(|c| {
            let code = u32::from(c);
            let unit = if code >= 0xF0000 {
                code - 0xF0000 + 0xD800
            } else {
                code
            };
            u16::try_from(unit).unwrap_or(0xFFFD)
        })
        .collect()
}

/// `restoreCase(word, token)`.
fn restore_case(word: &[u16], token: &[u16]) -> Vec<u16> {
    // Tokens are an exact match.
    if word == token {
        return token.to_vec();
    }
    // Lower cased words. E.g. "hello".
    if word == utf16::to_lowercase_units(word).as_slice() {
        return utf16::to_lowercase_units(token);
    }
    // Upper cased words. E.g. "WHISKY".
    if word == utf16::to_uppercase_units(word).as_slice() {
        return utf16::to_uppercase_units(token);
    }
    // Title cased words. E.g. "Title".
    if word
        .first()
        .is_some_and(|&first| utf16::unit_is_own_uppercase(first))
    {
        let split = token.len().min(1);
        let mut out = utf16::to_uppercase_units(&token[..split]);
        out.extend(utf16::to_lowercase_units(&token[split..]));
        return out;
    }
    // Lower cased words. E.g. "test".
    utf16::to_lowercase_units(token)
}

/// `interpolate(str, args)`: expands `$n` (one or two digits) with the
/// replace callback's arguments `[match, ...groups, offset, string]`; a
/// missing or falsy argument expands to nothing.
fn interpolate(template: &str, captures: &Captures<'_>, offset: usize, word: &[u16]) -> Vec<u16> {
    let group_count = captures.len() - 1;
    let mut out = Vec::new();
    let mut rest = template;
    while let Some(dollar) = rest.find('$') {
        out.extend(rest[..dollar].encode_utf16());
        let after = &rest[dollar + 1..];
        let digits = after.bytes().take(2).take_while(u8::is_ascii_digit).count();
        if digits == 0 {
            out.push(u16::from(b'$'));
            rest = after;
            continue;
        }
        let index: usize = after[..digits].parse().unwrap_or(usize::MAX);
        if index <= group_count {
            if let Some(group) = captures.get(index) {
                out.extend(decode_units(group.as_str()));
            }
        } else if index == group_count + 1 {
            if offset != 0 {
                out.extend(number::to_string(offset as f64).encode_utf16());
            }
        } else if index == group_count + 2 {
            out.extend_from_slice(word);
        }
        rest = &after[digits..];
    }
    out.extend(rest.encode_utf16());
    out
}

/// `replace(word, rule)`: `word.replace(rule[0], ...)`, rewriting the first
/// match (`captures`, found on `encoded`) with the interpolated,
/// case-restored replacement.
fn replace(word: &[u16], encoded: &str, rule: &Rule, captures: &Captures<'_>) -> Vec<u16> {
    let Some(whole) = captures.get(0) else {
        return word.to_vec();
    };
    let index = encoded[..whole.start()].chars().count();
    let matched = decode_units(whole.as_str());
    let result = interpolate(rule.replacement, captures, index, word);
    let restored = if matched.is_empty() {
        // An empty match takes its case from the preceding unit. (At index 0
        // JavaScript would throw; no rule matches empty there.)
        match index.checked_sub(1).and_then(|i| word.get(i)) {
            Some(&previous) => restore_case(&[previous], &result),
            None => result,
        }
    } else {
        restore_case(&matched, &result)
    };
    let end = (index + matched.len()).min(word.len());
    let mut out = word[..index.min(word.len())].to_vec();
    out.extend(restored);
    out.extend_from_slice(&word[end..]);
    out
}

/// `sanitizeWord(token, word, rules)`.
fn sanitize_word(tables: &Tables, token: &str, word: &[u16], rules: &[Rule]) -> Vec<u16> {
    if token.is_empty() || tables.uncountables.contains(token) {
        return word.to_vec();
    }
    let encoded = encode_units(word);
    // `rule[0].test(word)`, then `word.replace(rule[0], ...)` on the same
    // first match: one search per rule.
    for rule in rules.iter().rev() {
        if let Some(captures) = rule.regex.captures(&encoded) {
            return replace(word, &encoded, rule, &captures);
        }
    }
    word.to_vec()
}

/// `replaceWord(replaceMap, keepMap, rules)(word)`.
fn replace_word(
    word: &str,
    replace_map: &IndexMap<String, String>,
    keep_map: &IndexMap<String, String>,
    rules: &[Rule],
) -> String {
    let tables = &*TABLES;
    let token = word.to_lowercase();
    let word_units: Vec<u16> = word.encode_utf16().collect();
    let result = if keep_map.contains_key(&token) {
        restore_case(&word_units, &token.encode_utf16().collect::<Vec<_>>())
    } else if let Some(replacement) = replace_map.get(&token) {
        restore_case(&word_units, &replacement.encode_utf16().collect::<Vec<_>>())
    } else {
        sanitize_word(tables, &token, &word_units, rules)
    };
    utf16::units_to_string(&result)
}

/// `checkWord(replaceMap, keepMap, rules)(word)`.
fn check_word(
    word: &str,
    replace_map: &IndexMap<String, String>,
    keep_map: &IndexMap<String, String>,
    rules: &[Rule],
) -> bool {
    let tables = &*TABLES;
    let token = word.to_lowercase();
    if keep_map.contains_key(&token) {
        return true;
    }
    if replace_map.contains_key(&token) {
        return false;
    }
    let token_units: Vec<u16> = token.encode_utf16().collect();
    sanitize_word(tables, &token, &token_units, rules) == token_units
}

/// `pluralize.singular(word)`: `"users"` → `"user"`, `"People"` → `"Person"`.
pub fn singular(word: &str) -> String {
    let tables = &*TABLES;
    replace_word(
        word,
        &tables.irregular_plurals,
        &tables.irregular_singles,
        &tables.singular_rules,
    )
}

/// `pluralize.plural(word)`: `"user"` → `"users"`.
pub fn plural(word: &str) -> String {
    let tables = &*TABLES;
    replace_word(
        word,
        &tables.irregular_singles,
        &tables.irregular_plurals,
        &tables.plural_rules,
    )
}

/// `pluralize.isSingular(word)`.
pub fn is_singular(word: &str) -> bool {
    let tables = &*TABLES;
    check_word(
        word,
        &tables.irregular_plurals,
        &tables.irregular_singles,
        &tables.singular_rules,
    )
}

/// `pluralize.isPlural(word)`.
pub fn is_plural(word: &str) -> bool {
    let tables = &*TABLES;
    check_word(
        word,
        &tables.irregular_singles,
        &tables.irregular_plurals,
        &tables.plural_rules,
    )
}

/// `pluralize(word, count, inclusive)`: the singular for a count of exactly 1,
/// else the plural, prefixed with the count if `inclusive`.
pub fn pluralize(word: &str, count: f64, inclusive: bool) -> String {
    let pluralized = if count == 1.0 {
        singular(word)
    } else {
        plural(word)
    };
    if inclusive {
        format!("{} {pluralized}", number::to_string(count))
    } else {
        pluralized
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn tables_compile() {
        let tables = &*TABLES;
        assert_eq!(tables.plural_rules.len(), 33);
        assert_eq!(tables.singular_rules.len(), 31);
        assert_eq!(tables.uncountables.len(), 94);
        assert_eq!(tables.irregular_singles.len(), 47);
        assert_eq!(tables.irregular_plurals.len(), 43);
    }

    #[test]
    fn translation() {
        assert_eq!(translate("s$"), r"[\x{73}\x{53}]$");
        assert_eq!(
            translate("[^aeiou]"),
            r"[^\x{61}\x{41}\x{65}\x{45}\x{69}\x{49}\x{6F}\x{4F}\x{75}\x{55}]"
        );
        assert_eq!(translate("[^\\u0000-\\u007F]"), r"[^\x{0}-\x{7F}]");
        assert_eq!(translate("[eé]"), r"[\x{65}\x{45}\x{E9}\x{C9}]");
    }

    #[test]
    fn known_singulars() {
        for (plural, singular_form) in [
            ("cookies", "cooky"),
            ("People", "Person"),
            ("data", "datum"),
            ("statuses", "status"),
            ("ITEMS", "ITEM"),
            ("iTems", "iTem"),
            ("s", ""),
            ("Ies", "Y"),
            ("$refs", "$ref"),
            ("they", "she"),
            ("cooKieſ", "cooKieſ"),
            ("Pokémons", "Pokémon"),
        ] {
            assert_eq!(singular(plural), singular_form, "singular({plural})");
        }
    }
}
