//! Port of the terminal-colour libraries behind quicktype's help and
//! telemetry message: `supports-color` 7.2.0 (colour detection), `chalk`
//! 4.1.2 (style application) and `chalk-template` (the `{bold text}` syntax
//! command-line-usage 7.0.1 runs every string through).
//!
//! The detection logic is ported completely, because it decides which of
//! two different help layouts is printed. chalk-template supports every
//! `ansi-styles` 4 style name, `visible` and the `~` (inverse) prefix, and
//! throws chalk-template's errors; style arguments and hex colours
//! (`rgb(…)`, `#ff0000`) are reported as not implemented.

use std::fmt;
use std::io::IsTerminal;

use crate::js;

/// A text style: an `ansi-styles` modifier or colour, as its SGR open and
/// close codes.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Style {
    open: u8,
    close: u8,
}

impl Style {
    /// `bold`.
    pub const BOLD: Self = Self::new(1, 22);
    /// `dim`.
    pub const DIM: Self = Self::new(2, 22);
    /// `red`.
    pub const RED: Self = Self::new(31, 39);

    const fn new(open: u8, close: u8) -> Self {
        Self { open, close }
    }

    /// The `ansi-styles` 4 style called `name` (the style names chalk
    /// exposes, including the `gray`/`grey` aliases).
    pub fn named(name: &str) -> Option<Self> {
        let (open, close) = match name {
            "reset" => (0, 0),
            "bold" => (1, 22),
            "dim" => (2, 22),
            "italic" => (3, 23),
            "underline" => (4, 24),
            "inverse" => (7, 27),
            "hidden" => (8, 28),
            "strikethrough" => (9, 29),
            "black" => (30, 39),
            "red" => (31, 39),
            "green" => (32, 39),
            "yellow" => (33, 39),
            "blue" => (34, 39),
            "magenta" => (35, 39),
            "cyan" => (36, 39),
            "white" => (37, 39),
            "blackBright" | "gray" | "grey" => (90, 39),
            "redBright" => (91, 39),
            "greenBright" => (92, 39),
            "yellowBright" => (93, 39),
            "blueBright" => (94, 39),
            "magentaBright" => (95, 39),
            "cyanBright" => (96, 39),
            "whiteBright" => (97, 39),
            "bgBlack" => (40, 49),
            "bgRed" => (41, 49),
            "bgGreen" => (42, 49),
            "bgYellow" => (43, 49),
            "bgBlue" => (44, 49),
            "bgMagenta" => (45, 49),
            "bgCyan" => (46, 49),
            "bgWhite" => (47, 49),
            "bgBlackBright" | "bgGray" | "bgGrey" => (100, 49),
            "bgRedBright" => (101, 49),
            "bgGreenBright" => (102, 49),
            "bgYellowBright" => (103, 49),
            "bgBlueBright" => (104, 49),
            "bgMagentaBright" => (105, 49),
            "bgCyanBright" => (106, 49),
            "bgWhiteBright" => (107, 49),
            _ => return None,
        };
        Some(Self::new(open, close))
    }

    fn open(self) -> String {
        format!("\u{1b}[{}m", self.open)
    }

    fn close(self) -> String {
        format!("\u{1b}[{}m", self.close)
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
        self.apply_chain(styles, false, text)
    }

    /// chalk's `applyStyle` for a builder chain of `styles` (outermost
    /// first); `is_empty` marks a chain containing `visible`, which renders
    /// nothing when colours are off.
    fn apply_chain(&self, styles: &[Style], is_empty: bool, text: &str) -> String {
        if !self.enabled() || text.is_empty() {
            return if is_empty {
                String::new()
            } else {
                text.to_owned()
            };
        }
        if styles.is_empty() {
            return text.to_owned();
        }
        let open_all: String = styles.iter().map(|s| s.open()).collect();
        let close_all: String = styles.iter().rev().map(|s| s.close()).collect();
        let mut text = text.to_owned();
        if text.contains('\u{1b}') {
            // Re-open each style after any of its own close codes.
            for style in styles.iter().rev() {
                text = string_replace_all(&text, &style.close(), &style.open());
            }
        }
        if text.contains('\n') {
            text = encase_crlf(&text, &close_all, &open_all);
        }
        format!("{open_all}{text}{close_all}")
    }

    /// `chalk.bold(text)`.
    pub fn bold(&self, text: &str) -> String {
        self.apply(&[Style::BOLD], text)
    }

    /// `chalk.dim(text)`.
    pub fn dim(&self, text: &str) -> String {
        self.apply(&[Style::DIM], text)
    }

    /// `chalk.red(text)`.
    pub fn red(&self, text: &str) -> String {
        self.apply(&[Style::RED], text)
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

/// An error from chalk-template.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum TemplateError {
    /// A JS `Error` chalk-template throws, with its message.
    Thrown(String),
    /// A style with arguments, a hex colour or a colour-model style, which
    /// the port does not implement.
    Unsupported(String),
}

impl fmt::Display for TemplateError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Thrown(message) => f.write_str(message),
            Self::Unsupported(style) => write!(f, "chalk-template style `{style}`"),
        }
    }
}

impl std::error::Error for TemplateError {}

/// chalk's colour-model styles, which take arguments.
const MODEL_STYLES: [&str; 16] = [
    "rgb",
    "hex",
    "keyword",
    "hsl",
    "hsv",
    "hwb",
    "ansi",
    "ansi256",
    "bgRgb",
    "bgHex",
    "bgKeyword",
    "bgHsl",
    "bgHsv",
    "bgHwb",
    "bgAnsi",
    "bgAnsi256",
];

/// Length of one `#?[\w:]+(?:\([^)]*\))?` item at the start of `s`.
fn style_item_len(s: &str) -> Option<usize> {
    let hash = usize::from(s.starts_with('#'));
    let name = s[hash..]
        .find(|c: char| !(js::is_word_char(c) || c == ':'))
        .unwrap_or(s.len() - hash);
    if name == 0 {
        return None;
    }
    let mut len = hash + name;
    if s[len..].starts_with('(') {
        if let Some(close) = s[len..].find(')') {
            len += close + 1;
        }
    }
    Some(len)
}

/// Matches the style-opening alternative of `TEMPLATE_REGEX` at the start of
/// `s` (just after `{`): `(~)?(item(?:\.item)*)(?:[ \t]|(?=\r?\n))`. Returns
/// whether the block is inverse, the style group and the consumed length.
fn match_style_open(s: &str) -> Option<(bool, &str, usize)> {
    let inverse = s.starts_with('~');
    let start = usize::from(inverse);
    let mut end = start + style_item_len(&s[start..])?;
    while let Some(rest) = s[end..].strip_prefix('.') {
        match style_item_len(rest) {
            Some(len) => end += 1 + len,
            None => break,
        }
    }
    let after = &s[end..];
    let consumed = if after.starts_with([' ', '\t']) {
        end + 1
    } else if after.starts_with('\n') || after.starts_with("\r\n") {
        end
    } else {
        return None;
    };
    Some((inverse, &s[start..end], consumed))
}

/// chalk-template's `parseStyle` for groups without arguments or hex
/// colours: the leading `\w+` of each `.`-separated item.
fn parse_style(group: &str) -> Result<Vec<&str>, TemplateError> {
    if group.contains(['(', '#']) {
        return Err(TemplateError::Unsupported(group.to_owned()));
    }
    Ok(group
        .split('.')
        .filter_map(|item| {
            let end = item
                .find(|c: char| !js::is_word_char(c))
                .unwrap_or(item.len());
            (end > 0).then(|| &item[..end])
        })
        .collect())
}

/// One open `{style …}` block.
struct Layer<'a> {
    inverse: bool,
    names: Vec<&'a str>,
}

/// chalk-template's `buildStyle(styles)(text)`: the styles of all open
/// blocks, in order of first appearance, where an inverse block turns a
/// style off.
fn build_style(chalk: &Chalk, layers: &[Layer<'_>], text: &str) -> Result<String, TemplateError> {
    let mut enabled: Vec<(&str, bool)> = vec![];
    for layer in layers {
        for name in &layer.names {
            match enabled.iter_mut().find(|(n, _)| n == name) {
                Some(entry) => entry.1 = !layer.inverse,
                None => enabled.push((name, !layer.inverse)),
            }
        }
    }
    let mut styles = vec![];
    let mut is_empty = false;
    for (name, active) in enabled {
        if !active {
            continue;
        }
        if name == "visible" {
            is_empty = true;
        } else if let Some(style) = Style::named(name) {
            styles.push(style);
        } else if MODEL_STYLES.contains(&name) {
            return Err(TemplateError::Unsupported(name.to_owned()));
        } else {
            // TODO(chalk): names of other properties of the chalk object
            // (`level`, `toString`, …) fail in other ways in JS.
            return Err(TemplateError::Thrown(format!(
                "Unknown Chalk style: {name}"
            )));
        }
    }
    Ok(chalk.apply_chain(&styles, is_empty, text))
}

/// command-line-usage's `chalkFormat`: escapes backticks and runs the string
/// through chalk-template, which interprets `{style text}` blocks and
/// backslash escapes, and throws on unbalanced braces and unknown styles.
pub fn chalk_format(chalk: &Chalk, text: &str) -> Result<String, TemplateError> {
    if text.is_empty() {
        return Ok(String::new());
    }
    let text = text.replace('`', "\\`");
    let mut layers: Vec<Layer<'_>> = vec![];
    let mut chunks: Vec<String> = vec![];
    let mut chunk = String::new();
    let mut rest = text.as_str();
    while let Some(c) = rest.chars().next() {
        if c == '\\' {
            if let Some(escape) = match_escape(&rest[1..]) {
                chunk.push_str(&unescape(escape));
                rest = &rest[1 + escape.len()..];
                continue;
            }
        } else if c == '{' {
            if let Some((inverse, group, consumed)) = match_style_open(&rest[1..]) {
                let pending = std::mem::take(&mut chunk);
                chunks.push(if layers.is_empty() {
                    pending
                } else {
                    build_style(chalk, &layers, &pending)?
                });
                layers.push(Layer {
                    inverse,
                    names: parse_style(group)?,
                });
                rest = &rest[1 + consumed..];
                continue;
            }
        } else if c == '}' {
            if layers.is_empty() {
                return Err(TemplateError::Thrown(
                    "Found extraneous } in Chalk template literal".to_owned(),
                ));
            }
            let pending = std::mem::take(&mut chunk);
            chunks.push(build_style(chalk, &layers, &pending)?);
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
    if !layers.is_empty() {
        let n = layers.len();
        return Err(TemplateError::Thrown(format!(
            "Chalk template literal is missing {n} closing bracket{} (`}}`)",
            if n == 1 { "" } else { "s" }
        )));
    }
    Ok(chunks.concat())
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
        // On Windows, supports-color decides a terminal's level by the OS
        // build instead of TERM, CI and TERM_PROGRAM, and the port answers 1
        // there (see `supports_color`).
        let windows = |level: i64| if cfg!(windows) { 1 } else { level };
        assert_eq!(level(&[], &[("TERM", "xterm-256color")], true), windows(2));
        assert_eq!(level(&[], &[], true), windows(0));
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
        assert_eq!(Style::named("grey"), Style::named("blackBright"));
        assert_eq!(Style::named("bgGray"), Some(Style::new(100, 49)));
        assert_eq!(Style::named("visible"), None);
    }

    fn format(level: i64, text: &str) -> Result<String, String> {
        chalk_format(&Chalk::new(level), text).map_err(|e| e.to_string())
    }

    #[test]
    fn template() {
        assert_eq!(
            format(0, "{bold -o}, {bold --out} FILE").unwrap(),
            "-o, --out FILE"
        );
        assert_eq!(format(1, "{bold x}").unwrap(), "\u{1b}[1mx\u{1b}[22m");
        assert_eq!(format(0, "Use `part`").unwrap(), "Use `part`");
        assert_eq!(format(0, "a\\tb {x").unwrap(), "a\tb {x");
        assert_eq!(format(0, "{underline string[]}").unwrap(), "string[]");
        assert_eq!(format(0, "").unwrap(), "");
        assert_eq!(
            format(1, "{bold.red x}").unwrap(),
            "\u{1b}[1m\u{1b}[31mx\u{1b}[39m\u{1b}[22m"
        );
        assert_eq!(
            format(1, "{a:b.italic x}"),
            Err("Unknown Chalk style: a".to_owned())
        );
    }

    #[test]
    fn template_inverse_turns_styles_off() {
        assert_eq!(
            format(1, "{bold a {~bold b}}").unwrap(),
            "\u{1b}[1ma \u{1b}[22mb"
        );
        assert_eq!(
            format(1, "{~bold a {bold b}}").unwrap(),
            "a \u{1b}[1mb\u{1b}[22m"
        );
        assert_eq!(format(0, "{bold a {~bold b}}").unwrap(), "a b");
    }

    #[test]
    fn template_visible() {
        assert_eq!(format(0, "x{visible y}"), Ok("x".to_owned()));
        assert_eq!(format(1, "x{visible y}"), Ok("xy".to_owned()));
        assert_eq!(
            format(1, "{bold.visible y}"),
            Ok("\u{1b}[1my\u{1b}[22m".to_owned())
        );
    }

    #[test]
    fn template_errors() {
        assert_eq!(
            format(0, "a}"),
            Err("Found extraneous } in Chalk template literal".to_owned())
        );
        assert_eq!(
            format(0, "{bold a"),
            Err("Chalk template literal is missing 1 closing bracket (`}`)".to_owned())
        );
        assert_eq!(
            format(0, "{bold {dim a"),
            Err("Chalk template literal is missing 2 closing brackets (`}`)".to_owned())
        );
        assert_eq!(
            format(0, "{foo a}"),
            Err("Unknown Chalk style: foo".to_owned())
        );
        // The unknown style is only looked up when the block is used.
        assert_eq!(
            format(0, "{foo a"),
            Err("Chalk template literal is missing 1 closing bracket (`}`)".to_owned())
        );
        assert_eq!(format(0, "{~foo a}"), Ok("a".to_owned()));
        assert_eq!(
            format(0, "{bold. x}"),
            Err("Found extraneous } in Chalk template literal".to_owned())
        );
        assert_eq!(
            format(0, "{rgb(1,2,3) a}"),
            Err("chalk-template style `rgb(1,2,3)`".to_owned())
        );
    }
}
