//! The regular expressions of typescript-json-schema and
//! quicktype-typescript-input, as plain string functions.
//!
//! Each function names the JavaScript expression it implements. JavaScript
//! `.` excludes line terminators and `\s` is [`crate::js::is_js_whitespace`].

use crate::js::{is_js_whitespace, is_line_terminator};

fn is_word(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// `s.replace(/(\bimport\(".*?"\)|".*?")\.| /g, "")`: strips module
/// prefixes (`import("/a/b").`, `"/a/b".`) and spaces from type names.
pub fn strip_file_names_and_spaces(s: &str) -> String {
    let chars: Vec<char> = s.chars().collect();
    let mut out = String::with_capacity(s.len());
    let mut i = 0;
    // The lazy `.*?` followed by `close`: the first `close` reachable
    // without crossing a line terminator.
    let lazy_until = |from: usize, close: &[char]| -> Option<usize> {
        let mut k = from;
        while k < chars.len() {
            if chars[k..].starts_with(close) {
                return Some(k + close.len());
            }
            if is_line_terminator(chars[k]) {
                return None;
            }
            k += 1;
        }
        None
    };
    while i < chars.len() {
        let boundary = i == 0 || !is_word(chars[i - 1]);
        let import: Vec<char> = "import(\"".chars().collect();
        let matched = if boundary && chars[i..].starts_with(&import) {
            lazy_until(i + import.len(), &['"', ')', '.'])
        } else {
            None
        }
        .or_else(|| {
            if chars[i] == '"' {
                lazy_until(i + 1, &['"', '.'])
            } else {
                None
            }
        })
        .or_else(|| (chars[i] == ' ').then_some(i + 1));
        match matched {
            Some(end) => i = end,
            None => {
                out.push(chars[i]);
                i += 1;
            }
        }
    }
    out
}

/// `s.replace(/".*"\./, "")` (greedy, first match only).
pub fn strip_quoted_prefix(s: &str) -> String {
    let chars: Vec<char> = s.chars().collect();
    for i in 0..chars.len() {
        if chars[i] != '"' {
            continue;
        }
        let mut last = None;
        let mut k = i + 1;
        while k < chars.len() && !is_line_terminator(chars[k]) {
            if chars[k] == '"' && chars.get(k + 1) == Some(&'.') {
                last = Some(k + 2);
            }
            k += 1;
        }
        if let Some(end) = last {
            return chars[..i].iter().chain(chars[end..].iter()).collect();
        }
    }
    s.to_owned()
}

/// `/^\{([^{}]+)\}$/.exec(s)?.[1]`.
pub fn braced_type(s: &str) -> Option<&str> {
    let inner = s.strip_prefix('{')?.strip_suffix('}')?;
    (!inner.is_empty() && !inner.contains(['{', '}'])).then_some(inner)
}

/// The `(\S|\S[\s\S]*\S)\s*$` tail shared by the two JSDoc expressions:
/// the rest after a maximal whitespace run, with trailing whitespace removed.
fn rest_after_space(s: &str) -> Option<&str> {
    let first = s.chars().next()?;
    if !is_js_whitespace(first) {
        return None;
    }
    let rest = s
        .trim_start_matches(is_js_whitespace)
        .trim_end_matches(is_js_whitespace);
    (!rest.is_empty()).then_some(rest)
}

/// `REGEX_TJS_JSDOC` = `/^-([\w]+)\s+(\S|\S[\s\S]*\S)\s*$/`.
pub fn tjs_jsdoc(s: &str) -> Option<(&str, &str)> {
    let body = s.strip_prefix('-')?;
    let end = body.find(|c: char| !is_word(c)).unwrap_or(body.len());
    if end == 0 {
        return None;
    }
    Some((&body[..end], rest_after_space(&body[end..])?))
}

/// `REGEX_GROUP_JSDOC` = `/^[.]?([\w]+)\s+(\S|\S[\s\S]*\S)\s*$/`.
pub fn group_jsdoc(s: &str) -> Option<(&str, &str)> {
    let body = s.strip_prefix('.').unwrap_or(s);
    let end = body.find(|c: char| !is_word(c)).unwrap_or(body.len());
    if end == 0 {
        return None;
    }
    Some((&body[..end], rest_after_space(&body[end..])?))
}

/// `s.replace(/^[\s\-]+/, "")`.
pub fn strip_leading_space_and_dashes(s: &str) -> &str {
    s.trim_start_matches(|c: char| c == '-' || is_js_whitespace(c))
}

/// `REGEX_REQUIRE`: whether a JSDoc value is a `require("…")` expression.
pub fn is_require(s: &str) -> bool {
    let t = s.trim_start_matches(is_js_whitespace);
    let Some(rest) = t.strip_prefix("require(") else {
        return false;
    };
    let Some(q) = rest.chars().next().filter(|c| *c == '\'' || *c == '"') else {
        return false;
    };
    let path_ok = |c: char| c.is_ascii_alphanumeric() || "./_-@".contains(c);
    let body = &rest[1..];
    let Some(close) = body.find(q) else {
        return false;
    };
    !body[..close].is_empty()
        && body[..close].chars().all(path_ok)
        && body[close + 1..].starts_with(')')
}

/// `text.replace(/[\\^$.*+?()[\]{}|]/g, "\\$&")`.
pub fn escape_regex(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    for c in s.chars() {
        if "\\^$.*+?()[]{}|".contains(c) {
            out.push('\\');
        }
        out.push(c);
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn file_names_and_spaces() {
        assert_eq!(
            strip_file_names_and_spaces(r#"import("/a/b").Person"#),
            "Person"
        );
        assert_eq!(
            strip_file_names_and_spaces(r#""/a/b".NS.Inner"#),
            "NS.Inner"
        );
        assert_eq!(
            strip_file_names_and_spaces(r#"Box<import("/x").A | B>"#),
            "Box<A|B>"
        );
        assert_eq!(strip_file_names_and_spaces("{ a: string; }"), "{a:string;}");
        assert_eq!(
            strip_file_names_and_spaces(r#"Map<"a", 1>"#),
            r#"Map<"a",1>"#
        );
    }

    #[test]
    fn quoted_prefix_is_greedy() {
        assert_eq!(strip_quoted_prefix(r#""/a/b".X"#), "X");
        assert_eq!(strip_quoted_prefix(r#""/a".B."c".D"#), "D");
        assert_eq!(strip_quoted_prefix("Plain"), "Plain");
    }

    #[test]
    fn jsdoc_expressions() {
        assert_eq!(tjs_jsdoc("-format email "), Some(("format", "email")));
        assert_eq!(tjs_jsdoc("-format"), None);
        assert_eq!(group_jsdoc(".minimum 3"), Some(("minimum", "3")));
        assert_eq!(group_jsdoc("type string\nx  "), Some(("type", "string\nx")));
        assert_eq!(braced_type("{string}"), Some("string"));
        assert_eq!(braced_type("{}"), None);
        assert_eq!(strip_leading_space_and_dashes(" - x"), "x");
        assert!(is_require(r#"require("./x.json")"#));
        assert!(!is_require("required"));
        assert_eq!(escape_regex("a.b(c)"), r"a\.b\(c\)");
    }
}
