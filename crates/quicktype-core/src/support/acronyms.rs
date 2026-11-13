//! Port of `packages/quicktype-core/src/support/Acronyms.ts`.
//!
//! The `acronymOption` factory builds an `EnumOption` and belongs with the
//! `RendererOptions` port; its name, description and choices are exported
//! here as constants.

use super::strings::{
    all_lower_word_style, all_upper_word_style, first_upper_word_style, original_word,
};

/// `AcronymStyleOptions`: how the `acronym-style` renderer option styles
/// acronyms.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum AcronymStyleOptions {
    /// `"camel"`: `Url`.
    Camel,
    /// `"lowerCase"`: `url`.
    Lower,
    /// `"original"`: unchanged.
    Original,
    /// `"pascal"`: `URL`.
    Pascal,
}

impl AcronymStyleOptions {
    /// The members in declaration order (`Object.values(AcronymStyleOptions)`).
    pub const ALL: [AcronymStyleOptions; 4] = [
        AcronymStyleOptions::Camel,
        AcronymStyleOptions::Lower,
        AcronymStyleOptions::Original,
        AcronymStyleOptions::Pascal,
    ];

    /// The option value, e.g. `"lowerCase"`.
    pub fn as_str(self) -> &'static str {
        match self {
            AcronymStyleOptions::Camel => "camel",
            AcronymStyleOptions::Lower => "lowerCase",
            AcronymStyleOptions::Original => "original",
            AcronymStyleOptions::Pascal => "pascal",
        }
    }

    /// The member whose value is `value`.
    pub fn from_value(value: &str) -> Option<Self> {
        Self::ALL.into_iter().find(|style| style.as_str() == value)
    }
}

/// The name of the option `acronymOption` creates.
pub const ACRONYM_OPTION_NAME: &str = "acronym-style";

/// The description of the option `acronymOption` creates.
pub const ACRONYM_OPTION_DESCRIPTION: &str = "Acronym naming style";

/// The choices of the option `acronymOption` creates, in their order there
/// (an option of kind `"secondary"`).
pub const ACRONYM_OPTION_CHOICES: [AcronymStyleOptions; 4] = [
    AcronymStyleOptions::Original,
    AcronymStyleOptions::Pascal,
    AcronymStyleOptions::Camel,
    AcronymStyleOptions::Lower,
];

/// `acronymStyle(style)`: the word style for acronyms. Note the naming:
/// `Pascal` upper-cases the whole acronym, `Camel` capitalizes it.
pub fn acronym_style(style: AcronymStyleOptions) -> fn(&str) -> String {
    match style {
        AcronymStyleOptions::Pascal => all_upper_word_style,
        AcronymStyleOptions::Camel => first_upper_word_style,
        AcronymStyleOptions::Original => original_word,
        AcronymStyleOptions::Lower => all_lower_word_style,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn styles() {
        assert_eq!(acronym_style(AcronymStyleOptions::Pascal)("url"), "URL");
        assert_eq!(acronym_style(AcronymStyleOptions::Camel)("URL"), "Url");
        assert_eq!(acronym_style(AcronymStyleOptions::Original)("uRl"), "uRl");
        assert_eq!(acronym_style(AcronymStyleOptions::Lower)("URL"), "url");
        assert_eq!(
            AcronymStyleOptions::from_value("lowerCase"),
            Some(AcronymStyleOptions::Lower)
        );
    }
}
