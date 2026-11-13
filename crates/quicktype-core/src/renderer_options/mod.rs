//! Port of `packages/quicktype-core/src/RendererOptions/index.ts`.
//!
//! Renderer options are declared as data: every language lists its options
//! as a static slice of [`RendererOption`]s (in the key order of the TS
//! options object, which is the order the CLI and `--help` use). Values
//! arrive untyped in a [`RendererOptions`] map, exactly like the TS
//! `Record<string, unknown>`, and are read back with the per-option getters,
//! which reproduce the TS coercion rules.

pub mod types;

use std::borrow::Cow;
use std::fmt;

use indexmap::IndexMap;

pub use self::types::{CliOptionDefinitions, OptionDefinition, OptionKind, OptionType};

/// A raw option value, as found in the untyped TS `rendererOptions` record.
///
/// The CLI only ever produces booleans and strings. An absent key is the TS
/// `undefined`.
// TODO(api): numbers and objects can reach the JS API's `rendererOptions`;
// add them when the WASM bindings forward raw JS values.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum OptionValue {
    /// JS `null`.
    Null,
    /// A JS boolean.
    Bool(bool),
    /// A JS string.
    String(String),
}

impl OptionValue {
    /// JS truthiness: `false`, `null` and `""` are falsy.
    pub fn is_truthy(&self) -> bool {
        match self {
            Self::Null => false,
            Self::Bool(b) => *b,
            Self::String(s) => !s.is_empty(),
        }
    }

    /// JS `String(value)`.
    pub fn to_js_string(&self) -> Cow<'_, str> {
        match self {
            Self::Null => Cow::Borrowed("null"),
            Self::Bool(true) => Cow::Borrowed("true"),
            Self::Bool(false) => Cow::Borrowed("false"),
            Self::String(s) => Cow::Borrowed(s),
        }
    }
}

impl From<bool> for OptionValue {
    fn from(b: bool) -> Self {
        Self::Bool(b)
    }
}

impl From<&str> for OptionValue {
    fn from(s: &str) -> Self {
        Self::String(s.to_owned())
    }
}

impl From<String> for OptionValue {
    fn from(s: String) -> Self {
        Self::String(s)
    }
}

/// Untyped renderer option values keyed by option name (TS
/// `RendererOptions` / `Record<string, unknown>`), in insertion order.
///
/// This is the canonical form: the CLI fills it (including every default, see
/// `quicktype-cli`), the JS API passes it through, and renderers read it with
/// the getters of their option declarations.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct RendererOptions(IndexMap<String, OptionValue>);

impl RendererOptions {
    /// An empty map.
    pub fn new() -> Self {
        Self::default()
    }

    /// Sets `name` to `value`, keeping the position of an existing key (like
    /// assigning to a JS object property).
    pub fn set(&mut self, name: impl Into<String>, value: impl Into<OptionValue>) -> &mut Self {
        self.0.insert(name.into(), value.into());
        self
    }

    /// The value stored under `name`, if any.
    pub fn get(&self, name: &str) -> Option<&OptionValue> {
        self.0.get(name)
    }

    /// The value stored under `name`, treating `null` like a missing key
    /// (the JS `values[name] ?? …` lookup).
    fn get_non_nullish(&self, name: &str) -> Option<&OptionValue> {
        self.get(name).filter(|v| **v != OptionValue::Null)
    }

    /// Number of entries.
    pub fn len(&self) -> usize {
        self.0.len()
    }

    /// Whether there are no entries.
    pub fn is_empty(&self) -> bool {
        self.0.is_empty()
    }

    /// Entries in insertion order.
    pub fn iter(&self) -> impl Iterator<Item = (&str, &OptionValue)> {
        self.0.iter().map(|(k, v)| (k.as_str(), v))
    }
}

impl<K: Into<String>, V: Into<OptionValue>> FromIterator<(K, V)> for RendererOptions {
    fn from_iter<I: IntoIterator<Item = (K, V)>>(iter: I) -> Self {
        Self(
            iter.into_iter()
                .map(|(k, v)| (k.into(), v.into()))
                .collect(),
        )
    }
}

/// An enum option was given a value it does not declare.
///
/// The message is quicktype's `RendererUnknownOptionValue`:
/// `Unknown value ${value} for option ${name}`.
// TODO(messages): return quicktype_core::messages' error kind once ported.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct UnknownOptionValue {
    /// The rejected value, as JS `String(value)`.
    pub value: String,
    /// The option's name.
    pub name: &'static str,
}

impl fmt::Display for UnknownOptionValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Unknown value {} for option {}", self.value, self.name)
    }
}

impl std::error::Error for UnknownOptionValue {}

/// A target language option that is a boolean flag (TS `BooleanOption`).
///
/// On the command line it is `--name` / `--no-name`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct BooleanOption {
    /// Option name.
    pub name: &'static str,
    /// Short-ish description.
    pub description: &'static str,
    /// Default value.
    pub default_value: bool,
    /// Primary or secondary.
    pub kind: OptionKind,
}

impl BooleanOption {
    /// Declares a boolean option.
    pub const fn new(
        name: &'static str,
        description: &'static str,
        default_value: bool,
        kind: OptionKind,
    ) -> Self {
        Self {
            name,
            description,
            default_value,
            kind,
        }
    }

    /// The option's definition.
    pub fn definition(&self) -> OptionDefinition {
        OptionDefinition {
            default_value: Some(OptionValue::Bool(self.default_value)),
            ..OptionDefinition::new(self.name, OptionType::Boolean, self.description, self.kind)
        }
    }

    /// `actual`: `name` and `no-name` (with the inverted default);
    /// `display`: a single `[no-]name` whose description says the default.
    pub fn cli_definitions(&self) -> CliOptionDefinitions {
        let definition = self.definition();
        let negated = OptionDefinition {
            name: Cow::Owned(format!("no-{}", self.name)),
            default_value: Some(OptionValue::Bool(!self.default_value)),
            ..definition.clone()
        };
        let display = OptionDefinition {
            name: Cow::Owned(format!("[no-]{}", self.name)),
            description: Cow::Owned(format!(
                "{} ({} by default)",
                self.description,
                if self.default_value { "on" } else { "off" }
            )),
            ..definition.clone()
        };
        CliOptionDefinitions {
            actual: vec![definition, negated],
            display: vec![display],
        }
    }

    /// The effective value (TS `BooleanOption.getValue`): combines `name` and
    /// `no-name`, accepts the strings `"true"`/`"false"` for `name`, and
    /// otherwise uses JS truthiness.
    pub fn get_value(&self, values: &RendererOptions) -> bool {
        let value = match values.get(self.name) {
            None => self.default_value,
            Some(OptionValue::String(s)) if s == "true" => true,
            Some(OptionValue::String(s)) if s == "false" => false,
            Some(v) => v.is_truthy(),
        };
        let negated = values
            .get(&format!("no-{}", self.name))
            .map_or(!self.default_value, OptionValue::is_truthy);
        if self.default_value {
            value && !negated
        } else {
            value || !negated
        }
    }
}

/// A target language option that takes a free-form string (TS `StringOption`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct StringOption {
    /// Option name.
    pub name: &'static str,
    /// Short-ish description.
    pub description: &'static str,
    /// Placeholder shown in help, e.g. `"NAME"`.
    pub type_label: &'static str,
    /// Default value.
    pub default_value: &'static str,
    /// Primary or secondary.
    pub kind: OptionKind,
}

impl StringOption {
    /// Declares a string option.
    pub const fn new(
        name: &'static str,
        description: &'static str,
        type_label: &'static str,
        default_value: &'static str,
        kind: OptionKind,
    ) -> Self {
        Self {
            name,
            description,
            type_label,
            default_value,
            kind,
        }
    }

    /// The option's definition.
    pub fn definition(&self) -> OptionDefinition {
        OptionDefinition {
            default_value: Some(OptionValue::String(self.default_value.to_owned())),
            ..OptionDefinition::new(self.name, OptionType::String, self.description, self.kind)
                .with_type_label(self.type_label)
        }
    }

    /// The effective value (TS `Option.getValue`: `values[name] ?? default`).
    pub fn get_value<'a>(&self, values: &'a RendererOptions) -> Cow<'a, str> {
        values
            .get_non_nullish(self.name)
            .map_or(Cow::Borrowed(self.default_value), OptionValue::to_js_string)
    }
}

/// A target language option that takes one of a fixed set of values (TS
/// `EnumOption`).
///
/// Only the value names are declared here. The TS declaration also maps each
/// name to a renderer-specific value (a boolean, a string or a feature
/// record); renderers map the name returned by
/// [`get_enum_value`](Self::get_enum_value) to their own typed value.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct EnumOption {
    /// Option name.
    pub name: &'static str,
    /// Short-ish description.
    pub description: &'static str,
    /// Legal values, in declaration order.
    pub values: &'static [&'static str],
    /// Default value (one of `values`).
    pub default_value: &'static str,
    /// Primary or secondary.
    pub kind: OptionKind,
}

impl EnumOption {
    /// Declares an enum option.
    pub const fn new(
        name: &'static str,
        description: &'static str,
        values: &'static [&'static str],
        default_value: &'static str,
        kind: OptionKind,
    ) -> Self {
        Self {
            name,
            description,
            values,
            default_value,
            kind,
        }
    }

    /// The help placeholder: the values joined with `|`.
    pub fn type_label(&self) -> String {
        self.values.join("|")
    }

    /// The option's definition.
    pub fn definition(&self) -> OptionDefinition {
        OptionDefinition {
            default_value: Some(OptionValue::String(self.default_value.to_owned())),
            values: Some(self.values),
            type_label: Some(Cow::Owned(self.type_label())),
            ..OptionDefinition::new(self.name, OptionType::Enum, self.description, self.kind)
        }
    }

    /// The selected value name (TS `getEnumValue(getValue(values))`): the
    /// default when the value is missing or falsy, an error when it is not
    /// one of the declared values.
    // TODO(renderer): TS checks `name in values`, which also accepts
    // `Object.prototype` members such as "toString" (yielding a function
    // value). Model that when renderers consume enum values.
    pub fn get_enum_value(
        &self,
        values: &RendererOptions,
    ) -> Result<&'static str, UnknownOptionValue> {
        let Some(value) = values.get_non_nullish(self.name) else {
            return Ok(self.default_value);
        };
        if !value.is_truthy() {
            return Ok(self.default_value);
        }
        let text = value.to_js_string();
        self.values
            .iter()
            .copied()
            .find(|v| *v == text)
            .ok_or_else(|| UnknownOptionValue {
                value: text.into_owned(),
                name: self.name,
            })
    }
}

/// One renderer option declaration (the TS `Option` subclasses).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum RendererOption {
    /// A `BooleanOption`.
    Boolean(BooleanOption),
    /// A `StringOption`.
    String(StringOption),
    /// An `EnumOption`.
    Enum(EnumOption),
}

impl RendererOption {
    /// The option's name.
    pub fn name(&self) -> &'static str {
        match self {
            Self::Boolean(o) => o.name,
            Self::String(o) => o.name,
            Self::Enum(o) => o.name,
        }
    }

    /// Primary or secondary.
    pub fn kind(&self) -> OptionKind {
        match self {
            Self::Boolean(o) => o.kind,
            Self::String(o) => o.kind,
            Self::Enum(o) => o.kind,
        }
    }

    /// The option's definition (TS `option.definition`).
    pub fn definition(&self) -> OptionDefinition {
        match self {
            Self::Boolean(o) => o.definition(),
            Self::String(o) => o.definition(),
            Self::Enum(o) => o.definition(),
        }
    }

    /// The command-line definitions (TS `option.cliDefinitions`).
    pub fn cli_definitions(&self) -> CliOptionDefinitions {
        match self {
            Self::Boolean(o) => o.cli_definitions(),
            Self::String(_) | Self::Enum(_) => {
                let definition = self.definition();
                CliOptionDefinitions {
                    actual: vec![definition.clone()],
                    display: vec![definition],
                }
            }
        }
    }
}

/// A renderer option's value after [`get_option_values`].
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum ResolvedOptionValue {
    /// A boolean option's effective value.
    Bool(bool),
    /// A string option's value.
    String(String),
    /// The selected value name of an enum option.
    Enum(&'static str),
}

/// Resolves every option in `options` against `values` (TS
/// `getOptionValues`), failing on the first enum value that is not declared.
pub fn get_option_values(
    options: &[RendererOption],
    values: &RendererOptions,
) -> Result<Vec<(&'static str, ResolvedOptionValue)>, UnknownOptionValue> {
    options
        .iter()
        .map(|option| {
            let value = match option {
                RendererOption::Boolean(o) => ResolvedOptionValue::Bool(o.get_value(values)),
                RendererOption::String(o) => {
                    ResolvedOptionValue::String(o.get_value(values).into_owned())
                }
                RendererOption::Enum(o) => ResolvedOptionValue::Enum(o.get_enum_value(values)?),
            };
            Ok((option.name(), value))
        })
        .collect()
}

/// TS `acronymOption(defaultOption)` from `support/Acronyms.ts`.
// TODO(support): move next to the acronym styles in `support::acronyms`.
pub const fn acronym_option(default_value: &'static str) -> EnumOption {
    EnumOption::new(
        "acronym-style",
        "Acronym naming style",
        &["original", "pascal", "camel", "lowerCase"],
        default_value,
        OptionKind::Secondary,
    )
}

/// TS `convertersOption()` from `support/Converters.ts`.
// TODO(support): move next to `ConvertersOptions` in `support::converters`.
pub const fn converters_option() -> EnumOption {
    EnumOption::new(
        "converters",
        "Which converters to generate (top-level by default)",
        &["top-level", "all-objects"],
        "top-level",
        OptionKind::Secondary,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    const FLAG_OFF: BooleanOption =
        BooleanOption::new("flag", "A flag", false, OptionKind::Primary);
    const FLAG_ON: BooleanOption = BooleanOption::new("flag", "A flag", true, OptionKind::Primary);
    const STYLE: EnumOption =
        EnumOption::new("style", "Style", &["a", "b"], "b", OptionKind::Secondary);

    fn opts(pairs: &[(&str, OptionValue)]) -> RendererOptions {
        pairs.iter().cloned().collect()
    }

    #[test]
    fn boolean_cli_definitions() {
        let defs = FLAG_ON.cli_definitions();
        let names: Vec<_> = defs.actual.iter().map(|d| d.name.as_ref()).collect();
        assert_eq!(names, ["flag", "no-flag"]);
        assert_eq!(defs.actual[1].default_value, Some(OptionValue::Bool(false)));
        assert_eq!(defs.display[0].name, "[no-]flag");
        assert_eq!(defs.display[0].description, "A flag (on by default)");
        assert_eq!(
            FLAG_OFF.cli_definitions().display[0].description,
            "A flag (off by default)"
        );
    }

    #[test]
    fn boolean_get_value_combines_negation() {
        assert!(!FLAG_OFF.get_value(&RendererOptions::new()));
        assert!(FLAG_ON.get_value(&RendererOptions::new()));
        // What the CLI produces: both keys, from defaults and flags.
        let cli = |x: bool, no_x: bool| opts(&[("flag", x.into()), ("no-flag", no_x.into())]);
        assert!(FLAG_OFF.get_value(&cli(true, true)));
        assert!(!FLAG_OFF.get_value(&cli(false, true)));
        assert!(FLAG_OFF.get_value(&cli(false, false)));
        assert!(!FLAG_ON.get_value(&cli(true, true)));
        assert!(FLAG_ON.get_value(&cli(true, false)));
        // Strings: "true"/"false" are parsed, anything else is truthiness.
        assert!(!FLAG_ON.get_value(&opts(&[("flag", "false".into())])));
        assert!(FLAG_OFF.get_value(&opts(&[("flag", "yes".into())])));
        assert!(!FLAG_ON.get_value(&opts(&[("flag", "".into())])));
        // The negation is not parsed: "false" is a truthy string.
        assert!(!FLAG_ON.get_value(&opts(&[("no-flag", "false".into())])));
    }

    #[test]
    fn enum_values() {
        assert_eq!(STYLE.type_label(), "a|b");
        assert_eq!(STYLE.get_enum_value(&RendererOptions::new()), Ok("b"));
        assert_eq!(
            STYLE.get_enum_value(&opts(&[("style", "a".into())])),
            Ok("a")
        );
        assert_eq!(
            STYLE.get_enum_value(&opts(&[("style", "".into())])),
            Ok("b")
        );
        assert_eq!(
            STYLE.get_enum_value(&opts(&[("style", OptionValue::Null)])),
            Ok("b")
        );
        let err = STYLE
            .get_enum_value(&opts(&[("style", "c".into())]))
            .unwrap_err();
        assert_eq!(err.to_string(), "Unknown value c for option style");
    }

    #[test]
    fn string_values() {
        let ns = StringOption::new(
            "namespace",
            "Namespace",
            "NAME",
            "QuickType",
            OptionKind::Primary,
        );
        assert_eq!(ns.get_value(&RendererOptions::new()), "QuickType");
        assert_eq!(ns.get_value(&opts(&[("namespace", "".into())])), "");
        assert_eq!(
            ns.get_value(&opts(&[("namespace", OptionValue::Null)])),
            "QuickType"
        );
        assert_eq!(ns.definition().type_label.as_deref(), Some("NAME"));
    }

    #[test]
    fn get_option_values_stops_at_bad_enum() {
        let options = [
            RendererOption::Boolean(FLAG_OFF),
            RendererOption::Enum(STYLE),
        ];
        let resolved = get_option_values(&options, &RendererOptions::new()).unwrap();
        assert_eq!(
            resolved,
            [
                ("flag", ResolvedOptionValue::Bool(false)),
                ("style", ResolvedOptionValue::Enum("b"))
            ]
        );
        assert!(get_option_values(&options, &opts(&[("style", "x".into())])).is_err());
    }
}
