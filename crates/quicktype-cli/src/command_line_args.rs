//! Port of `command-line-args` 5.2.1 (`node_modules/command-line-args/dist/index.js`),
//! the argv parser the quicktype CLI uses.
//!
//! Only the features quicktype uses are ported (no `camelCase`,
//! `caseInsensitive`, `stopAtFirstUnknown`, groups or custom `type`
//! functions), but those are ported with all their quirks:
//!
//! - combined short options (`-lts` is `-l -t -s`; `-o=x.ts` too);
//! - `--name=value` for long options only (a boolean given a value is an
//!   `UNKNOWN_VALUE` and is still set);
//! - a value-taking option consumes the next value; a multiple option keeps
//!   consuming values; other values go to the `defaultOption`;
//! - options with a default value are pre-populated, in definition order,
//!   ahead of everything that is set on the command line;
//! - setting a singular option twice is `ALREADY_SET`;
//! - in partial mode unknown arguments are collected in `_unknown`.
//!
//! Regular expressions are evaluated with JS semantics: `\s` is JS
//! whitespace and strings are sequences of UTF-16 code units.

use std::fmt;

use quicktype_core::{OptionDefinition, OptionType, OptionValue};

use crate::js;

/// A parsed option value.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum ArgValue {
    /// An option that was given without its value (JS `null`).
    Null,
    /// A boolean flag.
    Bool(bool),
    /// A single string value.
    String(String),
    /// The values of a `multiple` option: strings (or booleans for a
    /// boolean option), plus whatever `arrayify(defaultValue)` produced.
    List(Vec<ArgValue>),
}

impl ArgValue {
    /// JS `String(value)`; arrays join their items with `,`, with `null`
    /// items as empty strings.
    pub(crate) fn to_js_string(&self) -> String {
        match self {
            Self::Null => "null".to_owned(),
            Self::Bool(b) => b.to_string(),
            Self::String(s) => s.clone(),
            Self::List(items) => items
                .iter()
                .map(|item| match item {
                    Self::Null => String::new(),
                    item => item.to_js_string(),
                })
                .collect::<Vec<_>>()
                .join(","),
        }
    }
}

/// An error thrown by command-line-args; displays like JS
/// `err.toString()`, i.e. `NAME: message`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct ArgsError {
    /// `UNKNOWN_OPTION`, `UNKNOWN_VALUE`, `ALREADY_SET` or `INVALID_DEFINITIONS`.
    pub name: &'static str,
    /// The error message.
    pub message: String,
}

impl fmt::Display for ArgsError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}: {}", self.name, self.message)
    }
}

impl std::error::Error for ArgsError {}

fn halt(name: &'static str, message: impl Into<String>) -> ArgsError {
    ArgsError {
        name,
        message: message.into(),
    }
}

/// The parse result: every option that has a value, in the order of the
/// JS output object (pre-populated defaults first, then options in the order
/// they first appeared), plus `_unknown` in partial mode.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct ParsedArgs {
    /// `(name, value)` pairs in output order.
    pub values: Vec<(String, ArgValue)>,
    /// Unknown arguments (partial mode only).
    pub unknown: Vec<String>,
}

impl ParsedArgs {
    /// The value of the option called `name`, if it has one.
    pub fn get(&self, name: &str) -> Option<&ArgValue> {
        self.values.iter().find(|(n, _)| n == name).map(|(_, v)| v)
    }
}

// ---------------------------------------------------------------------------
// argv-tools regular expressions

/// `re.short`: `/^-([^\d-])$/` (exactly one UTF-16 unit after the dash).
fn short_name(arg: &str) -> Option<char> {
    let rest = arg.strip_prefix('-')?;
    let mut chars = rest.chars();
    let c = chars.next()?;
    (chars.next().is_none() && c.len_utf16() == 1 && !c.is_ascii_digit() && c != '-').then_some(c)
}

/// `re.long`: `/^--(\S+)/`, returning the captured name.
fn long_name(arg: &str) -> Option<&str> {
    let rest = arg.strip_prefix("--")?;
    let end = rest.find(js::is_whitespace).unwrap_or(rest.len());
    (end > 0).then(|| &rest[..end])
}

/// `re.combinedShort`: `/^-[^\d-]{2,}$/`.
fn is_combined_short(arg: &str) -> bool {
    arg.strip_prefix('-').is_some_and(|rest| {
        js::len(rest) >= 2 && rest.chars().all(|c| !c.is_ascii_digit() && c != '-')
    })
}

/// `re.optEquals`: `/^(--\S+?)=(.*)/`, returning `("--name", value)`.
fn opt_equals(arg: &str) -> Option<(&str, &str)> {
    if !arg.starts_with("--") {
        return None;
    }
    // The first `=` after at least one non-whitespace character; any
    // whitespace before it means no match.
    for (i, c) in arg.char_indices().skip(2) {
        if i > 2 && c == '=' {
            let value = &arg[i + 1..];
            let value_end = value.find(js::is_line_terminator).unwrap_or(value.len());
            return Some((&arg[..i], &value[..value_end]));
        }
        if js::is_whitespace(c) {
            return None;
        }
    }
    None
}

/// `isOption`: a short or long option that is not `--name=value`.
fn is_option(arg: &str) -> bool {
    (short_name(arg).is_some() || long_name(arg).is_some()) && opt_equals(arg).is_none()
}

// ---------------------------------------------------------------------------
// Definitions

fn is_boolean(def: &OptionDefinition) -> bool {
    def.option_type == OptionType::Boolean
}

/// `Definitions.validate` (the checks that can fail for typed definitions).
fn validate(defs: &[OptionDefinition]) -> Result<(), ArgsError> {
    const INVALID: &str = "INVALID_DEFINITIONS";
    if defs.iter().any(|d| d.name.is_empty()) {
        return Err(halt(
            INVALID,
            "Invalid option definitions: the `name` property is required on each definition",
        ));
    }
    if let Some(def) = defs
        .iter()
        .find(|d| d.alias.is_some_and(|a| a.is_ascii_digit()))
    {
        return Err(halt(
            INVALID,
            format!(
                "Invalid option definition: to avoid ambiguity an alias cannot be numeric [--{} alias is -{}]",
                def.name,
                def.alias.unwrap_or_default()
            ),
        ));
    }
    if defs.iter().any(|d| d.alias == Some('-')) {
        return Err(halt(
            INVALID,
            "Invalid option definition: an alias cannot be \"-\"",
        ));
    }
    let has_duplicates =
        |keys: Vec<String>| keys.iter().enumerate().any(|(i, k)| keys[..i].contains(k));
    if has_duplicates(defs.iter().map(|d| d.name.to_string()).collect()) {
        return Err(halt(
            INVALID,
            "Two or more option definitions have the same name",
        ));
    }
    if has_duplicates(
        defs.iter()
            .filter_map(|d| d.alias)
            .map(String::from)
            .collect(),
    ) {
        return Err(halt(
            INVALID,
            "Two or more option definitions have the same alias",
        ));
    }
    if defs.iter().filter(|d| d.default_option).count() > 1 {
        return Err(halt(
            INVALID,
            "Only one option definition can be the defaultOption",
        ));
    }
    if let Some(def) = defs.iter().find(|d| is_boolean(d) && d.default_option) {
        return Err(halt(
            INVALID,
            format!(
                "A boolean option [\"{}\"] can not also be the defaultOption.",
                def.name
            ),
        ));
    }
    Ok(())
}

/// `Definitions.get(arg)` for an option argument (`-x` or `--name`).
fn find_definition(defs: &[OptionDefinition], arg: &str) -> Option<usize> {
    if let Some(alias) = short_name(arg) {
        defs.iter().position(|d| d.alias == Some(alias))
    } else {
        let name = long_name(arg)?;
        defs.iter().position(|d| d.name == name)
    }
}

// ---------------------------------------------------------------------------
// Output

#[derive(Clone, Copy, PartialEq, Eq)]
enum State {
    Default,
    Set,
}

struct OutputOption {
    name: String,
    /// Index into the definitions; `None` for `_unknown`.
    def: Option<usize>,
    value: ArgValue,
    state: State,
}

impl OutputOption {
    fn new(name: String, def: Option<usize>, definition: Option<&OptionDefinition>) -> Self {
        let multiple = definition.is_none_or(|d| d.multiple);
        let value = match definition.and_then(|d| d.default_value.as_ref()) {
            Some(default) => {
                let value = match default {
                    OptionValue::Null => ArgValue::Null,
                    OptionValue::Bool(b) => ArgValue::Bool(*b),
                    OptionValue::String(s) => ArgValue::String(s.clone()),
                };
                // `arrayify(defaultValue).slice()` keeps the raw value.
                if multiple {
                    ArgValue::List(vec![value])
                } else {
                    value
                }
            }
            None if multiple => ArgValue::List(vec![]),
            None => ArgValue::Null,
        };
        Self {
            name,
            def,
            value,
            state: State::Default,
        }
    }

    /// `Option.set` / `FlagOption.set`.
    fn set(&mut self, defs: &[OptionDefinition], value: ArgValue) -> Result<(), ArgsError> {
        let definition = self.def.map(|i| &defs[i]);
        let value = if definition.is_some_and(is_boolean) {
            ArgValue::Bool(true)
        } else {
            value
        };
        if definition.is_none_or(|d| d.multiple) {
            if value != ArgValue::Null {
                if self.state == State::Default {
                    self.value = ArgValue::List(vec![]);
                }
                // `arr.push(def.type(val))`: booleans stay booleans.
                let item = match value {
                    ArgValue::Bool(b) => ArgValue::Bool(b),
                    other => ArgValue::String(other.to_js_string()),
                };
                if let ArgValue::List(items) = &mut self.value {
                    items.push(item);
                }
                self.state = State::Set;
            }
        } else if self.state == State::Set {
            return Err(halt(
                "ALREADY_SET",
                format!(
                    "Singular option already set [{}={}]",
                    self.name,
                    self.value.to_js_string()
                ),
            ));
        } else if value == ArgValue::Null {
            self.value = ArgValue::Null;
        } else {
            self.value = value;
            self.state = State::Set;
        }
        Ok(())
    }
}

enum Event {
    Set,
    UnknownOption,
    UnknownValue,
}

/// Parses `argv` against `defs` (`commandLineArgs(defs, {argv, partial})`).
///
/// In strict mode (`partial == false`) unknown options and values are errors;
/// in partial mode they are collected in [`ParsedArgs::unknown`].
pub fn parse(
    defs: &[OptionDefinition],
    argv: &[String],
    partial: bool,
) -> Result<ParsedArgs, ArgsError> {
    validate(defs)?;

    // ArgvArray + combined short expansion. Errors and `_unknown` report the
    // expanded sub-argument (`subArg`), so the original is not kept.
    let mut args: Vec<String> = Vec::with_capacity(argv.len());
    for arg in argv {
        if is_combined_short(arg) {
            // `split('')` splits UTF-16 code units; a lone surrogate prints
            // as U+FFFD, so that is what an astral character becomes.
            for c in arg[1..].chars() {
                for _ in 0..c.len_utf16() {
                    let letter = if c.len_utf16() == 1 { c } else { '\u{FFFD}' };
                    args.push(format!("-{letter}"));
                }
            }
        } else {
            args.push(arg.clone());
        }
    }

    let mut output: Vec<OutputOption> = vec![OutputOption::new("_unknown".to_owned(), None, None)];
    for (i, def) in defs.iter().enumerate() {
        if def.default_value.is_some() {
            output.push(OutputOption::new(def.name.to_string(), Some(i), Some(def)));
        }
    }

    let default_option = defs.iter().position(|d| d.default_option);
    let mut pending: Option<usize> = None;
    let mut singular_default_set = false;

    for arg in &args {
        let mut events: Vec<(Event, Option<usize>, ArgValue, &str)> = Vec::with_capacity(2);
        let shown = arg.as_str();
        let (event, value) = if is_option(arg) {
            pending = find_definition(defs, arg);
            match pending {
                Some(d) if is_boolean(&defs[d]) => (Event::Set, ArgValue::Bool(true)),
                Some(_) => (Event::Set, ArgValue::Null),
                None => (Event::UnknownOption, ArgValue::Null),
            }
        } else if let Some((name, value)) = opt_equals(arg) {
            pending = find_definition(defs, name);
            match pending {
                Some(d) if is_boolean(&defs[d]) => {
                    events.push((Event::UnknownValue, None, ArgValue::Null, shown));
                    (Event::Set, ArgValue::Bool(true))
                }
                Some(_) => (Event::Set, ArgValue::String(value.to_owned())),
                None => (Event::UnknownOption, ArgValue::Null),
            }
        } else if pending.is_some() {
            (Event::Set, ArgValue::String(arg.clone()))
        } else {
            pending = default_option;
            if pending.is_some() && !singular_default_set {
                (Event::Set, ArgValue::String(arg.clone()))
            } else {
                pending = None;
                (Event::UnknownValue, ArgValue::Null)
            }
        };
        let is_set = matches!(event, Event::Set);
        let value_is_defined = value != ArgValue::Null;
        events.push((event, pending, value, shown));

        for (event, def, value, shown) in events {
            if !partial {
                match event {
                    Event::UnknownValue => {
                        return Err(halt("UNKNOWN_VALUE", format!("Unknown value: {shown}")));
                    }
                    Event::UnknownOption => {
                        return Err(halt("UNKNOWN_OPTION", format!("Unknown option: {shown}")));
                    }
                    Event::Set => {}
                }
            }
            let (name, def) = match (&event, def) {
                (Event::Set, Some(d)) => (defs[d].name.to_string(), Some(d)),
                _ => ("_unknown".to_owned(), None),
            };
            let index = match output.iter().position(|o| o.name == name) {
                Some(index) => index,
                None => {
                    output.push(OutputOption::new(name.clone(), def, def.map(|d| &defs[d])));
                    output.len() - 1
                }
            };
            let value = if def.is_none() {
                ArgValue::String(shown.to_owned())
            } else {
                value
            };
            output[index].set(defs, value)?;
        }
        if let Some(d) = pending {
            let def = &defs[d];
            if def.default_option && !def.multiple && is_set {
                singular_default_set = true;
            }
            if is_boolean(def) || (!def.multiple && value_is_defined) {
                pending = None;
            }
        }
    }

    let mut result = ParsedArgs::default();
    for option in output {
        if option.def.is_none() {
            if let ArgValue::List(items) = option.value {
                if partial {
                    result.unknown = items.iter().map(ArgValue::to_js_string).collect();
                }
            }
        } else {
            result.values.push((option.name, option.value));
        }
    }
    Ok(result)
}

#[cfg(test)]
mod tests {
    use super::*;
    use quicktype_core::OptionKind;

    fn defs() -> Vec<OptionDefinition> {
        vec![
            OptionDefinition::new("out", OptionType::String, "", OptionKind::Cli).with_alias('o'),
            OptionDefinition::new("lang", OptionType::String, "", OptionKind::Cli).with_alias('l'),
            OptionDefinition::new("src", OptionType::String, "", OptionKind::Cli)
                .multiple()
                .default_option(),
            OptionDefinition::new("quiet", OptionType::Boolean, "", OptionKind::Cli),
            OptionDefinition::new("header", OptionType::String, "", OptionKind::Cli).multiple(),
            OptionDefinition {
                default_value: Some(OptionValue::String("QuickType".into())),
                ..OptionDefinition::new("namespace", OptionType::String, "", OptionKind::Primary)
            },
        ]
    }

    fn list(xs: &[&str]) -> ArgValue {
        ArgValue::List(
            xs.iter()
                .map(|s| ArgValue::String((*s).to_owned()))
                .collect(),
        )
    }

    fn args(xs: &[&str]) -> Vec<String> {
        xs.iter().map(|s| (*s).to_owned()).collect()
    }

    fn strict(xs: &[&str]) -> Result<ParsedArgs, String> {
        parse(&defs(), &args(xs), false).map_err(|e| e.to_string())
    }

    #[test]
    fn regexes() {
        assert_eq!(short_name("-o"), Some('o'));
        assert_eq!(short_name("-1"), None);
        assert_eq!(short_name("--"), None);
        assert_eq!(short_name("-😀"), None);
        assert_eq!(long_name("--foo bar"), Some("foo"));
        assert_eq!(long_name("--"), None);
        assert_eq!(long_name("-- x"), None);
        assert!(is_combined_short("-lts"));
        assert!(is_combined_short("-o=x.ts"));
        assert!(is_combined_short("-😀"));
        assert!(!is_combined_short("-o=1"));
        assert_eq!(opt_equals("--a=b=c"), Some(("--a", "b=c")));
        assert_eq!(opt_equals("--=a=b"), Some(("--=a", "b")));
        assert_eq!(opt_equals("--=foo"), None);
        assert_eq!(opt_equals("--a b=c"), None);
        assert_eq!(opt_equals("--a=b\nc"), Some(("--a", "b")));
    }

    #[test]
    fn values_defaults_and_order() {
        let parsed = strict(&["a.json", "--quiet", "-o", "x.ts", "b.json"]).unwrap();
        assert_eq!(
            parsed.values,
            vec![
                ("namespace".to_owned(), ArgValue::String("QuickType".into())),
                ("src".to_owned(), list(&["a.json", "b.json"])),
                ("quiet".to_owned(), ArgValue::Bool(true)),
                ("out".to_owned(), ArgValue::String("x.ts".into())),
            ]
        );
    }

    #[test]
    fn multiple_options_are_greedy() {
        let parsed = strict(&["--header", "a", "b"]).unwrap();
        assert_eq!(parsed.get("header"), Some(&list(&["a", "b"])));
        assert_eq!(parsed.get("src"), None);
    }

    #[test]
    fn errors() {
        assert_eq!(
            strict(&["--foo"]).unwrap_err(),
            "UNKNOWN_OPTION: Unknown option: --foo"
        );
        assert_eq!(
            strict(&["--quiet=false"]).unwrap_err(),
            "UNKNOWN_VALUE: Unknown value: --quiet=false"
        );
        assert_eq!(
            strict(&["-o", "a", "-o", "b"]).unwrap_err(),
            "ALREADY_SET: Singular option already set [out=a]"
        );
        assert_eq!(
            strict(&["--quiet", "--quiet"]).unwrap_err(),
            "ALREADY_SET: Singular option already set [quiet=true]"
        );
        assert_eq!(
            strict(&["-lx"]).unwrap_err(),
            "UNKNOWN_OPTION: Unknown option: -x"
        );
    }

    #[test]
    fn missing_values_are_null() {
        let parsed = strict(&["-lo", "x"]).unwrap();
        assert_eq!(parsed.get("lang"), Some(&ArgValue::Null));
        assert_eq!(parsed.get("out"), Some(&ArgValue::String("x".into())));
        let parsed = strict(&["--namespace"]).unwrap();
        assert_eq!(parsed.get("namespace"), Some(&ArgValue::Null));
        let parsed = strict(&["--namespace="]).unwrap();
        assert_eq!(
            parsed.get("namespace"),
            Some(&ArgValue::String(String::new()))
        );
    }

    #[test]
    fn partial_mode_collects_unknowns() {
        let parsed = parse(&defs(), &args(&["--foo", "bar", "--x=1", "-é"]), true).unwrap();
        assert_eq!(parsed.unknown, ["--foo", "--x=1", "-é"]);
        assert_eq!(parsed.get("src"), Some(&list(&["bar"])));
    }

    #[test]
    fn multiple_defaults_keep_their_raw_value() {
        let with_default = |default: OptionValue| {
            vec![OptionDefinition {
                default_value: Some(default),
                ..OptionDefinition::new("tags", OptionType::String, "", OptionKind::Cli).multiple()
            }]
        };
        let parsed = parse(&with_default(OptionValue::Bool(true)), &[], false).unwrap();
        assert_eq!(
            parsed.get("tags"),
            Some(&ArgValue::List(vec![ArgValue::Bool(true)]))
        );
        let parsed = parse(&with_default(OptionValue::Null), &[], false).unwrap();
        assert_eq!(
            parsed.get("tags"),
            Some(&ArgValue::List(vec![ArgValue::Null]))
        );
        // Setting a value replaces the default.
        let parsed = parse(
            &with_default(OptionValue::Bool(true)),
            &args(&["--tags", "a"]),
            false,
        )
        .unwrap();
        assert_eq!(parsed.get("tags"), Some(&list(&["a"])));
        // `[null, "a"].toString()`
        let mixed = ArgValue::List(vec![ArgValue::Null, ArgValue::String("a".into())]);
        assert_eq!(mixed.to_js_string(), ",a");
    }

    #[test]
    fn invalid_definitions() {
        let mut d = defs();
        d.push(OptionDefinition::new(
            "out",
            OptionType::String,
            "",
            OptionKind::Cli,
        ));
        assert_eq!(
            parse(&d, &[], false).unwrap_err().to_string(),
            "INVALID_DEFINITIONS: Two or more option definitions have the same name"
        );
    }
}
