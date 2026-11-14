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
//! - **Speed.** Compiling the 64 rule regexes up front cost several
//!   milliseconds per process, more than a whole small quicktype run. So each
//!   rule list (singular, plural) has one multi-pattern automaton that
//!   reports *which* rules match a word, and a rule's own regex is compiled
//!   only when it is the one that applies (its captures build the
//!   replacement). The automaton reports a pattern exactly when that
//!   pattern's regex matches, so the first matching rule from the end is the
//!   same. Translating the rules and building the automata took another
//!   0.7 ms per process (the singular rules) and 1 ms (the plural ones), so
//!   the build script does both: it writes each list's patterns and a DFA
//!   of them, and a process only checks the DFA's tables
//!   (`DFA::from_bytes`, about 40 µs). A hash of the rule tables the build
//!   script read must equal that of the tables the crate is compiled with,
//!   or the crate does not compile.
//!
//! The rules are JavaScript regular expressions with the `i` flag and without
//! `u`. They are translated to `regex`-crate syntax with JavaScript's meaning
//! (see `translate`): ASCII-only case folding (`/s$/i` matches `S` but not
//! `ſ` U+017F; `/k/i` does not match the Kelvin sign U+212A), ASCII `\w` and
//! `\b`, and matching on UTF-16 code units, so that a negated class like
//! `[^aeiou]` consumes half of a surrogate pair exactly as JavaScript does.

use std::sync::{LazyLock, OnceLock};

use indexmap::{IndexMap, IndexSet};
use regex::{Captures, Regex};
use regex_automata::dfa::{Automaton as _, dense};
use regex_automata::{Input, PatternSet};

use self::rules::{PLURAL_RULES, SINGULAR_RULES, UNCOUNTABLE_RULES, rules_hash};
use crate::{number, utf16};

mod rules;
#[cfg(test)]
mod translate;

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

/// A serialized automaton, aligned as [`dense::DFA::from_bytes`] reads it.
#[repr(C)]
struct Aligned<B: ?Sized> {
    _align: [u32; 0],
    bytes: B,
}

/// What the build script made of a rule list: the hash of the rule tables
/// it read ([`rules_hash`]), and the patterns it translated, in order.
type Built = (u64, &'static [&'static str]);

/// The plural rules as the build script translated them.
const PLURAL_BUILT: Built = include!(concat!(env!("OUT_DIR"), "/pluralize_plural.rs"));

/// The plural rules' automaton, which the build script made from
/// [`PLURAL_BUILT`]'s patterns.
static PLURAL_DFA: &Aligned<[u8]> = &Aligned {
    _align: [],
    bytes: *include_bytes!(concat!(env!("OUT_DIR"), "/pluralize_plural.dfa")),
};

/// The singular rules as the build script translated them.
const SINGULAR_BUILT: Built = include!(concat!(env!("OUT_DIR"), "/pluralize_singular.rs"));

/// The singular rules' automaton, from [`SINGULAR_BUILT`]'s patterns.
static SINGULAR_DFA: &Aligned<[u8]> = &Aligned {
    _align: [],
    bytes: *include_bytes!(concat!(env!("OUT_DIR"), "/pluralize_singular.dfa")),
};

// The build script's output is for these rule tables: output left from
// other tables fails the build here, rather than misnaming at run time.
const _: () = assert!(
    PLURAL_BUILT.0 == rules_hash(PLURAL_RULES, UNCOUNTABLE_RULES),
    "pluralize's plural patterns and automaton were built from other rules"
);
const _: () = assert!(
    SINGULAR_BUILT.0 == rules_hash(SINGULAR_RULES, UNCOUNTABLE_RULES),
    "pluralize's singular patterns and automaton were built from other rules"
);

/// A rule list (plural or singular rules, then the uncountable patterns),
/// in the order `pluralize.js` adds them.
struct Rules {
    /// Each rule's translated pattern.
    patterns: &'static [&'static str],
    /// Each rule's replacement template.
    replacements: Vec<&'static str>,
    /// Every pattern in one DFA, for `which rules match this word`: built
    /// with `MatchKind::All` and searched for overlapping matches, it
    /// reports each pattern that matches anywhere, exactly as its own
    /// `is_match` would.
    selector: dense::DFA<&'static [u32]>,
    /// Each rule's own regex, compiled when it first applies to a word.
    regexes: Vec<OnceLock<Regex>>,
}

impl Rules {
    /// The rules of `rules` (and the uncountable patterns), with the
    /// patterns and the DFA the build script made of them.
    fn new(
        rules: &[(&str, &'static str)],
        patterns: &'static [&'static str],
        dfa: &'static [u8],
    ) -> Self {
        let replacements = rule_replacements(rules);
        let (selector, _) = dense::DFA::from_bytes(dfa)
            .unwrap_or_else(|e| panic!("the pluralize automaton does not load: {e}"));
        assert_eq!(selector.pattern_len(), patterns.len());
        assert_eq!(replacements.len(), patterns.len());
        let regexes = patterns.iter().map(|_| OnceLock::new()).collect();
        Rules {
            patterns,
            replacements,
            selector,
            regexes,
        }
    }

    #[cfg(test)]
    fn len(&self) -> usize {
        self.patterns.len()
    }

    /// The rules whose pattern matches `encoded`; `sanitizeWord` tries
    /// them last added first (`.iter().rev()`).
    fn matching(&self, encoded: &str) -> PatternSet {
        let mut matches = PatternSet::new(self.selector.pattern_len());
        // The automaton has no quit bytes (its `\b`s are ASCII), so the
        // search cannot fail.
        self.selector
            .try_which_overlapping_matches(&Input::new(encoded), &mut matches)
            .unwrap_or_else(|e| panic!("pluralize rule search failed: {e}"));
        matches
    }

    /// Rule `index`'s regex (`rule[0]`).
    fn regex(&self, index: usize) -> &Regex {
        self.regexes[index].get_or_init(|| {
            Regex::new(self.patterns[index])
                .unwrap_or_else(|e| panic!("pluralize rule {index} does not translate: {e}"))
        })
    }
}

/// The word tables: irregular words and uncountable words.
struct Tables {
    uncountables: IndexSet<String>,
    /// Singular → plural.
    irregular_singles: IndexMap<String, String>,
    /// Plural → singular.
    irregular_plurals: IndexMap<String, String>,
}

static TABLES: LazyLock<Tables> = LazyLock::new(|| {
    let mut tables = Tables {
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
    for &rule in UNCOUNTABLE_RULES {
        if !rule.starts_with('/') {
            tables.uncountables.insert(rule.to_lowercase());
        }
    }
    tables
});

/// The pluralization rules.
static PLURAL: LazyLock<Rules> =
    LazyLock::new(|| Rules::new(PLURAL_RULES, PLURAL_BUILT.1, &PLURAL_DFA.bytes));

/// The singularization rules.
static SINGULAR: LazyLock<Rules> =
    LazyLock::new(|| Rules::new(SINGULAR_RULES, SINGULAR_BUILT.1, &SINGULAR_DFA.bytes));

/// The replacement templates of a rule list (`rule[1]`), then `$0` for each
/// uncountable pattern, in the order of the build script's patterns.
fn rule_replacements(rules: &[(&str, &'static str)]) -> Vec<&'static str> {
    let rules = rules.iter().map(|&(_, replacement)| replacement);
    let patterns = UNCOUNTABLE_RULES
        .iter()
        .filter(|rule| rule.starts_with('/'));
    rules.chain(patterns.map(|_| "$0")).collect()
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
/// case-restored `replacement` (`rule[1]`).
fn replace(word: &[u16], encoded: &str, replacement: &str, captures: &Captures<'_>) -> Vec<u16> {
    let Some(whole) = captures.get(0) else {
        return word.to_vec();
    };
    let index = encoded[..whole.start()].chars().count();
    let matched = decode_units(whole.as_str());
    let result = interpolate(replacement, captures, index, word);
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
fn sanitize_word(tables: &Tables, token: &str, word: &[u16], rules: &Rules) -> Vec<u16> {
    if token.is_empty() || tables.uncountables.contains(token) {
        return word.to_vec();
    }
    let encoded = encode_units(word);
    // `rule[0].test(word)` for each rule from the last, then
    // `word.replace(rule[0], ...)` on the same first match. The selector
    // finds the rules that pass the test in one search; only the one that
    // applies runs its own regex.
    for index in rules.matching(&encoded).iter().rev().map(|p| p.as_usize()) {
        if let Some(captures) = rules.regex(index).captures(&encoded) {
            return replace(word, &encoded, rules.replacements[index], &captures);
        }
    }
    word.to_vec()
}

/// `replaceWord(replaceMap, keepMap, rules)(word)`.
fn replace_word(
    word: &str,
    replace_map: &IndexMap<String, String>,
    keep_map: &IndexMap<String, String>,
    rules: &Rules,
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
    rules: &Rules,
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
        &SINGULAR,
    )
}

/// `pluralize.plural(word)`: `"user"` → `"users"`.
pub fn plural(word: &str) -> String {
    let tables = &*TABLES;
    replace_word(
        word,
        &tables.irregular_singles,
        &tables.irregular_plurals,
        &PLURAL,
    )
}

/// `pluralize.isSingular(word)`.
pub fn is_singular(word: &str) -> bool {
    let tables = &*TABLES;
    check_word(
        word,
        &tables.irregular_plurals,
        &tables.irregular_singles,
        &SINGULAR,
    )
}

/// `pluralize.isPlural(word)`.
pub fn is_plural(word: &str) -> bool {
    let tables = &*TABLES;
    check_word(
        word,
        &tables.irregular_singles,
        &tables.irregular_plurals,
        &PLURAL,
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
    use super::translate::{rule_patterns, translate};
    use super::*;

    #[test]
    fn tables_compile() {
        let tables = &*TABLES;
        assert_eq!(PLURAL.len(), 33);
        assert_eq!(SINGULAR.len(), 31);
        for rules in [&*PLURAL, &*SINGULAR] {
            for index in 0..rules.len() {
                rules.regex(index);
            }
        }
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

    /// The build script's patterns are the translation of the current rule
    /// tables, and its hash is theirs.
    #[test]
    fn the_build_script_translated_these_rules() {
        for (list, built) in [
            (PLURAL_RULES, PLURAL_BUILT),
            (SINGULAR_RULES, SINGULAR_BUILT),
        ] {
            assert_eq!(built.0, rules_hash(list, UNCOUNTABLE_RULES));
            assert_eq!(built.1, rule_patterns(list, UNCOUNTABLE_RULES));
            assert_eq!(built.1.len(), rule_replacements(list).len());
        }
        // The hash changes with any string of the tables, and with where
        // one string ends and the next starts.
        let mut changed = PLURAL_RULES.to_vec();
        changed[3].1 = "$1ez";
        assert_ne!(rules_hash(&changed, UNCOUNTABLE_RULES), PLURAL_BUILT.0);
        assert_ne!(
            rules_hash(PLURAL_RULES, &UNCOUNTABLE_RULES[1..]),
            PLURAL_BUILT.0
        );
        assert_ne!(
            rules_hash(&[("ab", "c")], &[]),
            rules_hash(&[("a", "bc")], &[])
        );
    }

    /// Words, as UTF-16 code units, to select rules for: every word of the
    /// tables, the endings the rules look for after random stems, and
    /// random units, with upper- and title-case variants, non-ASCII
    /// letters that fold to ASCII ones in Unicode but not in JavaScript,
    /// and unpaired surrogates.
    fn selector_words() -> Vec<Vec<u16>> {
        let mut words: Vec<String> = Vec::new();
        for &(single, plural) in IRREGULAR_RULES {
            words.extend([single.to_owned(), plural.to_owned()]);
        }
        words.extend(UNCOUNTABLE_RULES.iter().map(|w| (*w).to_owned()));
        let endings = [
            "s", "es", "ies", "ves", "ice", "ouse", "a", "ae", "i", "im", "x", "ren", "men", "man",
            "sis", "ses", "um", "on", "ices", "ex", "ix", "ese", "ias", "las", "eau", "eaux", "is",
            "us", "ey", "eys", "y", "fe", "f", "o", "oes", "fish", "deer", "pox", "ous", "mon",
            "mons", "pokémon", "person", "people", "child", "children", "thou",
        ];
        let stems = [
            "", "a", "b", "c", "l", "m", "t", "tit", "wi", "kni", "neck", "zomb", "x",
        ];
        for stem in stems {
            for ending in endings {
                for separator in ["", " ", "_", "-", "é", "1"] {
                    words.push(format!("{stem}{separator}{ending}"));
                }
            }
        }
        let mut units: Vec<Vec<u16>> = Vec::new();
        for word in words {
            for variant in [
                word.clone(),
                word.to_uppercase(),
                word.chars()
                    .take(1)
                    .flat_map(char::to_uppercase)
                    .chain(word.chars().skip(1))
                    .collect(),
            ] {
                units.push(variant.encode_utf16().collect());
            }
        }
        let alphabet: Vec<u16> =
            "aeiouyslmnrtxchfwkqzAESIOUY_ -$0é\u{c9}\u{17f}\u{212a}\u{130}\u{131}\u{3a3}日"
                .encode_utf16()
                .chain([0xD800, 0xDBFF, 0xDC00, 0xDFFF, 0xD83D, 0xDE00])
                .collect();
        let mut state: u64 = 0x853C_49E6_748F_EA9B;
        let mut next = move || {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            state
        };
        for _ in 0..20_000 {
            let len = (next() % 10) as usize;
            units.push(
                (0..len)
                    .map(|_| alphabet[(next() % alphabet.len() as u64) as usize])
                    .collect(),
            );
        }
        units
    }

    /// The automata the build script made select exactly the rules whose
    /// own regex matches the word, the rules `sanitizeWord` tests.
    #[test]
    fn the_prebuilt_automata_select_the_matching_rules() {
        let words = selector_words();
        for (rules, list) in [(&*PLURAL, PLURAL_RULES), (&*SINGULAR, SINGULAR_RULES)] {
            let patterns = rule_patterns(list, UNCOUNTABLE_RULES);
            let regexes: Vec<Regex> = patterns.iter().map(|p| Regex::new(p).unwrap()).collect();
            // Words for which some rule is selected, and for which several are.
            let (mut some, mut several) = (0, 0);
            for word in &words {
                let encoded = encode_units(word);
                let selected: Vec<usize> = rules
                    .matching(&encoded)
                    .iter()
                    .map(|p| p.as_usize())
                    .collect();
                let expected: Vec<usize> = (0..regexes.len())
                    .filter(|&i| regexes[i].is_match(&encoded))
                    .collect();
                assert_eq!(selected, expected, "{encoded:?}");
                some += usize::from(!selected.is_empty());
                several += usize::from(selected.len() > 1);
            }
            assert!(
                some > words.len() / 10 && several > words.len() / 100,
                "{some}, {several} of {}",
                words.len()
            );
        }
    }
}
