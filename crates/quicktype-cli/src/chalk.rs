//! Port of the terminal-colour libraries behind quicktype's help and
//! telemetry message: `supports-color` 7.2.0 (colour detection), `chalk`
//! 4.1.2 (style application) and `chalk-template` (the `{bold text}` syntax
//! command-line-usage 7.0.1 runs every string through).
//!
//! Only the styles quicktype's output uses are supported (`bold`, `dim`,
//! `underline`, `red`); the detection logic is ported completely, because it
//! decides which of two different help layouts is printed.

use std::io::IsTerminal;

use crate::js;

/// A text style (an `ansi-styles` modifier or colour).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Style {
    /// `\x1b[1m … \x1b[22m`.
    Bold,
    /// `\x1b[2m … \x1b[22m`.
    Dim,
    /// `\x1b[4m … \x1b[24m`.
    Underline,
    /// `\x1b[31m … \x1b[39m`.
    Red,
}

impl Style {
    fn from_name(name: &str) -> Option<Self> {
        match name {
            "bold" => Some(Self::Bold),
            "dim" => Some(Self::Dim),
            "underline" => Some(Self::Underline),
            "red" => Some(Self::Red),
            _ => None,
        }
    }

    fn open(self) -> &'static str {
        match self {
            Self::Bold => "\u{1b}[1m",
            Self::Dim => "\u{1b}[2m",
            Self::Underline => "\u{1b}[4m",
            Self::Red => "\u{1b}[31m",
        }
    }

    fn close(self) -> &'static str {
        match self {
            Self::Bold | Self::Dim => "\u{1b}[22m",
            Self::Underline => "\u{1b}[24m",
            Self::Red => "\u{1b}[39m",
        }
    }
}

/// The environment `supports-color` inspects.
pub struct ColorEnv<'a> {
    /// The command-line arguments (`process.argv`, for `--color` and friends).
    pub args: &'a [String],
    /// Environment variable lookup.
    pub var: &'a dyn Fn(&str) -> Option<String>,
    /// Whether the stream is a TTY.
    pub is_tty: bool,
}

/// `parseInt(s, 10)`, `None` for `NaN`.
fn parse_int(s: &str) -> Option<i64> {
    let s = js::trim(s);
    let (negative, digits) = match s.as_bytes().first() {
        Some(b'-') => (true, &s[1..]),
        Some(b'+') => (false, &s[1..]),
        _ => (false, s),
    };
    let end = digits
        .find(|c: char| !c.is_ascii_digit())
        .unwrap_or(digits.len());
    if end == 0 {
        return None;
    }
    // Out-of-range values saturate (JS would produce a huge number).
    let value: i64 = digits[..end].parse().unwrap_or(i64::MAX);
    Some(if negative { -value } else { value })
}

/// `supportsColor(haveStream = true, streamIsTTY)` from supports-color 7.2.0:
/// the colour level (0–3; a negative `FORCE_COLOR` can make it negative,
/// which chalk treats like 0).
pub fn supports_color(env: &ColorEnv<'_>) -> i64 {
    let has_flag = |flag: &str| {
        let wanted = format!("--{flag}");
        let terminator = env.args.iter().position(|a| a == "--");
        env.args
            .iter()
            .position(|a| *a == wanted)
            .is_some_and(|p| terminator.is_none_or(|t| p < t))
    };
    // `forceColor`: None = undefined, Some(None) = NaN, Some(Some(n)) = n.
    let mut force_color: Option<Option<i64>> = None;
    if has_flag("no-color")
        || has_flag("no-colors")
        || has_flag("color=false")
        || has_flag("color=never")
    {
        force_color = Some(Some(0));
    } else if has_flag("color")
        || has_flag("colors")
        || has_flag("color=true")
        || has_flag("color=always")
    {
        force_color = Some(Some(1));
    }
    if let Some(value) = (env.var)("FORCE_COLOR") {
        force_color = Some(match value.as_str() {
            "true" | "" => Some(1),
            "false" => Some(0),
            _ => parse_int(&value).map(|n| n.min(3)),
        });
    }

    if force_color == Some(Some(0)) {
        return 0;
    }
    if has_flag("color=16m") || has_flag("color=full") || has_flag("color=truecolor") {
        return 3;
    }
    if has_flag("color=256") {
        return 2;
    }
    if !env.is_tty && force_color.is_none() {
        return 0;
    }
    // `forceColor || 0`
    let min = force_color.flatten().unwrap_or(0);
    let term = (env.var)("TERM");
    if term.as_deref() == Some("dumb") {
        return min;
    }
    if cfg!(windows) {
        // TODO(windows): supports-color inspects the Windows build number
        // (`os.release()`); any level above 0 renders quicktype's output the
        // same way.
        return 1;
    }
    if (env.var)("CI").is_some() {
        let ci = [
            "TRAVIS",
            "CIRCLECI",
            "APPVEYOR",
            "GITLAB_CI",
            "GITHUB_ACTIONS",
            "BUILDKITE",
        ];
        if ci.iter().any(|name| (env.var)(name).is_some())
            || (env.var)("CI_NAME").as_deref() == Some("codeship")
        {
            return 1;
        }
        return min;
    }
    if let Some(version) = (env.var)("TEAMCITY_VERSION") {
        return i64::from(teamcity_supports_color(&version));
    }
    if (env.var)("COLORTERM").as_deref() == Some("truecolor") {
        return 3;
    }
    if let Some(program) = (env.var)("TERM_PROGRAM") {
        let version = (env.var)("TERM_PROGRAM_VERSION").unwrap_or_default();
        let major = parse_int(version.split('.').next().unwrap_or(""));
        match program.as_str() {
            "iTerm.app" => return if major.is_some_and(|v| v >= 3) { 3 } else { 2 },
            "Apple_Terminal" => return 2,
            _ => {}
        }
    }
    // `regex.test(env.TERM)` tests the string "undefined" when TERM is unset.
    let term = term
        .unwrap_or_else(|| "undefined".to_owned())
        .to_ascii_lowercase();
    if term.ends_with("-256") || term.ends_with("-256color") {
        return 2;
    }
    if ["screen", "xterm", "vt100", "vt220", "rxvt"]
        .iter()
        .any(|p| term.starts_with(p))
        || ["color", "ansi", "cygwin", "linux"]
            .iter()
            .any(|p| term.contains(p))
    {
        return 1;
    }
    if (env.var)("COLORTERM").is_some() {
        return 1;
    }
    min
}

/// `/^(9\.(0*[1-9]\d*)\.|\d{2,}\.)/`
fn teamcity_supports_color(version: &str) -> bool {
    let digits = |s: &str| s.find(|c: char| !c.is_ascii_digit()).unwrap_or(s.len());
    if let Some(rest) = version.strip_prefix("9.") {
        let n = digits(rest);
        let minor = &rest[..n];
        if !minor.is_empty()
            && minor
                .trim_start_matches('0')
                .starts_with(|c: char| c != '0')
            && rest[n..].starts_with('.')
        {
            return true;
        }
    }
    let n = digits(version);
    n >= 2 && version[n..].starts_with('.')
}

/// A chalk instance: applies styles when the colour level is above 0.
#[derive(Clone, Copy, Debug)]
pub struct Chalk {
    level: i64,
}

impl Chalk {
    /// A chalk instance with the given colour level.
    pub fn new(level: i64) -> Self {
        Self { level }
    }

    /// The level supports-color assigns to this process's stdout (chalk's
    /// default, used for stdout and stderr output alike).
    pub fn for_stdout(args: &[String]) -> Self {
        let var = |name: &str| std::env::var_os(name).map(|v| v.to_string_lossy().into_owned());
        Self::new(supports_color(&ColorEnv {
            args,
            var: &var,
            is_tty: std::io::stdout().is_terminal(),
        }))
    }

    /// Whether styles produce escape codes.
    pub fn enabled(&self) -> bool {
        self.level > 0
    }

    /// `chalk.<styles…>(text)`: `styles` are outermost first.
    pub fn apply(&self, styles: &[Style], text: &str) -> String {
        if !self.enabled() || text.is_empty() || styles.is_empty() {
            return text.to_owned();
        }
        let open_all: String = styles.iter().map(|s| s.open()).collect();
        let close_all: String = styles.iter().rev().map(|s| s.close()).collect();
        let mut text = text.to_owned();
        if text.contains('\u{1b}') {
            // Re-open each style after any of its own close codes.
            for style in styles.iter().rev() {
                text = string_replace_all(&text, style.close(), style.open());
            }
        }
        if text.contains('\n') {
            text = encase_crlf(&text, &close_all, &open_all);
        }
        format!("{open_all}{text}{close_all}")
    }

    /// `chalk.bold(text)`.
    pub fn bold(&self, text: &str) -> String {
        self.apply(&[Style::Bold], text)
    }

    /// `chalk.dim(text)`.
    pub fn dim(&self, text: &str) -> String {
        self.apply(&[Style::Dim], text)
    }

    /// `chalk.red(text)`.
    pub fn red(&self, text: &str) -> String {
        self.apply(&[Style::Red], text)
    }
}

/// chalk's `stringReplaceAll`: every `substring` is followed by `replacer`.
fn string_replace_all(string: &str, substring: &str, replacer: &str) -> String {
    string.replace(substring, &format!("{substring}{replacer}"))
}

/// chalk's `stringEncaseCRLFWithFirstIndex`: closes the styles before each
/// line break (`\n` or `\r\n`) and reopens them after it.
fn encase_crlf(string: &str, prefix: &str, postfix: &str) -> String {
    let mut out = String::with_capacity(string.len());
    let mut rest = string;
    while let Some(index) = rest.find('\n') {
        let got_cr = rest[..index].ends_with('\r');
        let line = &rest[..if got_cr { index - 1 } else { index }];
        out.push_str(line);
        out.push_str(prefix);
        out.push_str(if got_cr { "\r\n" } else { "\n" });
        out.push_str(postfix);
        rest = &rest[index + 1..];
    }
    out.push_str(rest);
    out
}

/// chalk-template's `unescape` for the text after a backslash.
fn unescape(escape: &str) -> String {
    let hex = |s: &str| u32::from_str_radix(s, 16).ok();
    if let Some(digits) = escape.strip_prefix('u') {
        if let Some(inner) = digits.strip_prefix('{').and_then(|d| d.strip_suffix('}')) {
            return hex(inner)
                .and_then(char::from_u32)
                .map(String::from)
                .unwrap_or_default();
        }
        if digits.len() == 4 {
            return hex(digits)
                .map(|n| char::from_u32(n).unwrap_or('\u{FFFD}').to_string())
                .unwrap_or_default();
        }
    }
    if let Some(digits) = escape.strip_prefix('x') {
        if digits.len() == 2 {
            return hex(digits)
                .and_then(char::from_u32)
                .map(String::from)
                .unwrap_or_default();
        }
    }
    match escape {
        "n" => "\n".to_owned(),
        "r" => "\r".to_owned(),
        "t" => "\t".to_owned(),
        "b" => "\u{8}".to_owned(),
        "f" => "\u{c}".to_owned(),
        "v" => "\u{b}".to_owned(),
        "0" => "\0".to_owned(),
        "\\" => "\\".to_owned(),
        "e" => "\u{1b}".to_owned(),
        "a" => "\u{7}".to_owned(),
        other => other.to_owned(),
    }
}

/// Matches the escape alternative of chalk-template's `TEMPLATE_REGEX` at the
/// start of `s` (just after a backslash), returning the escape text.
fn match_escape(s: &str) -> Option<&str> {
    let is_hex = |c: char| c.is_ascii_hexdigit();
    let first = s.chars().next()?;
    if first.eq_ignore_ascii_case(&'u') {
        let rest = &s[1..];
        if rest.get(..4).is_some_and(|h| h.chars().all(is_hex)) {
            return Some(&s[..5]);
        }
        if let Some(inner) = rest.strip_prefix('{') {
            let n = inner.find(|c: char| !is_hex(c)).unwrap_or(inner.len());
            if (1..=6).contains(&n) && inner[n..].starts_with('}') {
                return Some(&s[..n + 3]);
            }
        }
    }
    if first.eq_ignore_ascii_case(&'x') && s.get(1..3).is_some_and(|h| h.chars().all(is_hex)) {
        return Some(&s[..3]);
    }
    (!js::is_line_terminator(first)).then(|| &s[..first.len_utf8()])
}

/// Matches the style-opening alternative of `TEMPLATE_REGEX` at the start of
/// `s` (just after `{`): returns the style names and the consumed length.
/// Only plain, dotted style names are supported (no arguments or hex colours).
fn match_style_open(s: &str) -> Option<(Vec<&str>, usize)> {
    let body = s.strip_prefix('~').unwrap_or(s);
    let offset = s.len() - body.len();
    let end = body
        .find(|c: char| !(js::is_word_char(c) || c == ':' || c == '.'))
        .unwrap_or(body.len());
    let names = &body[..end];
    if names.is_empty() || names.starts_with('.') || names.ends_with('.') || names.contains("..") {
        return None;
    }
    let after = &body[end..];
    let consumed = if after.starts_with([' ', '\t']) {
        offset + end + 1
    } else if after.starts_with('\n') || after.starts_with("\r\n") {
        offset + end
    } else {
        return None;
    };
    Some((names.split('.').collect(), consumed))
}

/// command-line-usage's `chalkFormat`: escapes backticks and runs the string
/// through chalk-template, which interprets `{style text}` blocks and
/// backslash escapes.
pub fn chalk_format(chalk: &Chalk, text: &str) -> String {
    if text.is_empty() {
        return String::new();
    }
    let text = text.replace('`', "\\`");
    let mut layers: Vec<Vec<Style>> = vec![];
    let mut chunks: Vec<String> = vec![];
    let mut chunk = String::new();
    let styled = |layers: &[Vec<Style>], text: &str| -> String {
        let mut enabled: Vec<Style> = vec![];
        for style in layers.iter().flatten() {
            if !enabled.contains(style) {
                enabled.push(*style);
            }
        }
        chalk.apply(&enabled, text)
    };
    let mut rest = text.as_str();
    while let Some(c) = rest.chars().next() {
        if c == '\\' {
            if let Some(escape) = match_escape(&rest[1..]) {
                chunk.push_str(&unescape(escape));
                rest = &rest[1 + escape.len()..];
                continue;
            }
        } else if c == '{' {
            if let Some((names, consumed)) = match_style_open(&rest[1..]) {
                let text = std::mem::take(&mut chunk);
                chunks.push(if layers.is_empty() {
                    text
                } else {
                    styled(&layers, &text)
                });
                // TODO(chalk): unknown style names throw in chalk-template;
                // quicktype only uses the supported ones.
                layers.push(names.into_iter().filter_map(Style::from_name).collect());
                rest = &rest[1 + consumed..];
                continue;
            }
        } else if c == '}' {
            // An unmatched `}` throws in chalk-template; quicktype never has one.
            let text = std::mem::take(&mut chunk);
            chunks.push(styled(&layers, &text));
            layers.pop();
            rest = &rest[1..];
            continue;
        }
        // `(?:.|[\r\n\f])` does not match U+2028/U+2029, which are dropped.
        if c != '\u{2028}' && c != '\u{2029}' {
            chunk.push(c);
        }
        rest = &rest[c.len_utf8()..];
    }
    chunks.push(chunk);
    chunks.concat()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn level(args: &[&str], vars: &[(&str, &str)], is_tty: bool) -> i64 {
        let args: Vec<String> = args.iter().map(|s| (*s).to_owned()).collect();
        let var = |name: &str| {
            vars.iter()
                .find(|(k, _)| *k == name)
                .map(|(_, v)| (*v).to_owned())
        };
        supports_color(&ColorEnv {
            args: &args,
            var: &var,
            is_tty,
        })
    }

    #[test]
    fn detection() {
        assert_eq!(level(&[], &[], false), 0);
        assert_eq!(level(&[], &[("FORCE_COLOR", "1")], false), 1);
        assert_eq!(level(&[], &[("FORCE_COLOR", "")], false), 1);
        assert_eq!(level(&[], &[("FORCE_COLOR", "0")], true), 0);
        assert_eq!(
            level(&[], &[("FORCE_COLOR", "7"), ("TERM", "dumb")], false),
            3
        );
        assert_eq!(
            level(&[], &[("FORCE_COLOR", "x"), ("TERM", "dumb")], false),
            0
        );
        assert_eq!(level(&["--color"], &[("TERM", "dumb")], false), 1);
        assert_eq!(level(&["--", "--color"], &[], false), 0);
        assert_eq!(level(&[], &[("TERM", "xterm-256color")], true), 2);
        assert_eq!(level(&[], &[], true), 0);
        assert!(teamcity_supports_color("9.1.2"));
        assert!(teamcity_supports_color("10.0"));
        assert!(!teamcity_supports_color("9.0.1"));
    }

    #[test]
    fn styles() {
        let on = Chalk::new(1);
        assert_eq!(on.bold("x"), "\u{1b}[1mx\u{1b}[22m");
        assert_eq!(on.dim("a\nb"), "\u{1b}[2ma\u{1b}[22m\n\u{1b}[2mb\u{1b}[22m");
        assert_eq!(on.bold(""), "");
        assert_eq!(Chalk::new(0).bold("x"), "x");
    }

    #[test]
    fn template() {
        let on = Chalk::new(1);
        let off = Chalk::new(0);
        assert_eq!(
            chalk_format(&off, "{bold -o}, {bold --out} FILE"),
            "-o, --out FILE"
        );
        assert_eq!(chalk_format(&on, "{bold x}"), "\u{1b}[1mx\u{1b}[22m");
        assert_eq!(chalk_format(&off, "Use `part`"), "Use `part`");
        assert_eq!(chalk_format(&off, "a\\tb {x"), "a\tb {x");
        assert_eq!(chalk_format(&off, "{underline string[]}"), "string[]");
        assert_eq!(chalk_format(&off, ""), "");
    }
}
