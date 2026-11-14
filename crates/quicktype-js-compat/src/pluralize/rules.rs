// The rules of `pluralize` 8.0.0 that are regular expressions, and their
// translation into `regex`-crate syntax.
//
// This is a module of `pluralize`, and the crate's build script
// `include!`s it to build the rule lists' automata ahead of time (see
// `pluralize::Rules`). So it uses only `std`, and its comments are not
// inner doc comments.

/// Pluralization rules: a JavaScript regex literal, or a plain word (which
/// `sanitizeRule` turns into `/^word$/i`), and its replacement.
pub const PLURAL_RULES: &[(&str, &str)] = &[
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
pub const SINGULAR_RULES: &[(&str, &str)] = &[
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
pub const UNCOUNTABLE_RULES: &[&str] = &[
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

/// `sanitizeRule`: the pattern of a `/source/i` literal, or of a plain word
/// as `/^word$/i`, in `regex`-crate syntax.
pub fn sanitize_rule(rule: &str) -> String {
    match rule.strip_prefix('/').and_then(|r| r.strip_suffix("/i")) {
        Some(source) => translate(source),
        None => translate(&format!("^{rule}$")),
    }
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
pub fn translate(source: &str) -> String {
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

/// The patterns of a rule list (`PLURAL_RULES` or `SINGULAR_RULES`), then
/// those of the uncountable patterns, in the order `pluralize.js` adds
/// them, with each one's replacement template.
pub fn rule_list(rules: &[(&str, &'static str)]) -> (Vec<String>, Vec<&'static str>) {
    let mut patterns = Vec::new();
    let mut replacements = Vec::new();
    for &(rule, replacement) in rules {
        patterns.push(sanitize_rule(rule));
        replacements.push(replacement);
    }
    for &rule in UNCOUNTABLE_RULES {
        if rule.starts_with('/') {
            patterns.push(sanitize_rule(rule));
            replacements.push("$0");
        }
    }
    (patterns, replacements)
}
