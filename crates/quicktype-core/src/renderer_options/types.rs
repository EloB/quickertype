//! Port of `packages/quicktype-core/src/RendererOptions/types.ts`.
//!
//! The TS file also declares the type-level helpers `OptionName`,
//! `OptionValue`, `OptionKey`, `OptionMap` and `OptionValues`, which only
//! exist for the TypeScript type checker. In Rust the per-option getters on
//! [`BooleanOption`](super::BooleanOption), [`StringOption`](super::StringOption)
//! and [`EnumOption`](super::EnumOption) play that role.

use std::borrow::Cow;

use super::OptionValue;

/// Where an option shows up: primary options appear in the web UI's
/// "Language" tab, secondary ones under "Other", and `Cli` options exist only
/// on the command line.
#[non_exhaustive]
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum OptionKind {
    /// `"primary"`.
    Primary,
    /// `"secondary"`.
    Secondary,
    /// `"cli"`: a global command-line option, not a renderer option.
    Cli,
}

impl OptionKind {
    /// The TS spelling (`"primary"`, `"secondary"` or `"cli"`).
    pub fn as_str(self) -> &'static str {
        match self {
            Self::Primary => "primary",
            Self::Secondary => "secondary",
            Self::Cli => "cli",
        }
    }
}

/// The value type of an option.
#[non_exhaustive]
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum OptionType {
    /// `"string"`: takes a free-form value.
    String,
    /// `"boolean"`: a flag that takes no value.
    Boolean,
    /// `"enum"`: takes one of a fixed set of values.
    Enum,
}

impl OptionType {
    /// The TS spelling (`"string"`, `"boolean"` or `"enum"`).
    pub fn as_str(self) -> &'static str {
        match self {
            Self::String => "string",
            Self::Boolean => "boolean",
            Self::Enum => "enum",
        }
    }
}

/// A command-line or API option definition (TS `OptionDefinition`).
///
/// The same type describes renderer options (produced by
/// [`RendererOption::definition`](super::RendererOption::definition) and its
/// CLI variants) and the CLI's own global options, so the CLI can feed both
/// to its `command-line-args` port and to the help printer.
#[derive(Clone, Debug, PartialEq)]
pub struct OptionDefinition {
    /// Option name, e.g. `"just-types"` (`--just-types` on the command line).
    pub name: Cow<'static, str>,
    /// Single-character alias, e.g. `'o'` for `--out`.
    pub alias: Option<char>,
    /// Whether bare command-line values are collected into this option.
    pub default_option: bool,
    /// Help text.
    pub description: Cow<'static, str>,
    /// Value type.
    pub option_type: OptionType,
    /// Default value, if any (`undefined` in TS when `None`).
    pub default_value: Option<OptionValue>,
    /// Enum options only: the legal values, in declaration order (the keys of
    /// the TS `values` map).
    pub values: Option<&'static [&'static str]>,
    /// Primary, secondary or CLI.
    pub kind: OptionKind,
    /// Whether the option may be given several times (collects a list).
    pub multiple: bool,
    /// Placeholder for the value in help output, e.g. `"NAME"`.
    pub type_label: Option<Cow<'static, str>>,
}

impl OptionDefinition {
    /// A definition with the given name, type, description and kind and no
    /// alias, default, values, label or multiplicity.
    pub const fn new(
        name: &'static str,
        option_type: OptionType,
        description: &'static str,
        kind: OptionKind,
    ) -> Self {
        Self {
            name: Cow::Borrowed(name),
            alias: None,
            default_option: false,
            description: Cow::Borrowed(description),
            option_type,
            default_value: None,
            values: None,
            kind,
            multiple: false,
            type_label: None,
        }
    }

    /// Sets the alias.
    pub const fn with_alias(mut self, alias: char) -> Self {
        self.alias = Some(alias);
        self
    }

    /// Sets the help placeholder for the value.
    pub fn with_type_label(mut self, type_label: &'static str) -> Self {
        self.type_label = Some(Cow::Borrowed(type_label));
        self
    }

    /// Marks the option as taking several values.
    pub const fn multiple(mut self) -> Self {
        self.multiple = true;
        self
    }

    /// Marks the option as the one that collects bare values.
    pub const fn default_option(mut self) -> Self {
        self.default_option = true;
        self
    }
}

/// The two lists of command-line definitions of a renderer option or a
/// language (TS `cliDefinitions` / `cliOptionDefinitions`).
#[derive(Clone, Debug, Default, PartialEq)]
pub struct CliOptionDefinitions {
    /// What the parser accepts: booleans contribute `x` and `no-x`.
    pub actual: Vec<OptionDefinition>,
    /// What `--help` shows: booleans contribute a single `[no-]x`.
    pub display: Vec<OptionDefinition>,
}
