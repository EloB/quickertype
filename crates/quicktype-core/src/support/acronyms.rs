//! Port of `packages/quicktype-core/src/support/Acronyms.ts`.
//!
//! The `acronymOption` factory builds an `EnumOption` and belongs with the
//! `RendererOptions` port; its name, description and choices are exported
//! here as constants.

use std::cell::Cell;

use super::strings::{
    all_lower_word_style, all_upper_word_style, first_upper_word_style, original_word,
};
use crate::messages::{JsErrorName, QuickTypeError, Result};
use crate::renderer_options::EnumValue;

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

    /// The style an `acronym-style` option value selects, as TS
    /// `acronymStyle(value)` looks it up: `None` (TS `undefined`) for an
    /// `Object.prototype` member, whose `String(value)` is no key of the
    /// style table.
    pub fn from_enum_value(value: EnumValue) -> Option<Self> {
        value.declared().and_then(Self::from_value)
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

/// The calls of an `acronymStyle(style)` result while one name is styled,
/// in the renderers that call it without a fallback (the JavaScript family).
///
/// For an `Object.prototype` member as `acronym-style`,
/// [`AcronymStyleOptions::from_enum_value`] is `None` (TS `undefined`), and
/// the first acronym word styled with it throws `TypeError: <variable> is
/// not a function`, `<variable>` being the name it is called through. The
/// word styles cannot fail, so they record that first call here, and
/// [`result`](Self::result) turns it into the error once the name is done
/// (its namer then records it in the renderer's
/// [`NameStyleErrors`](crate::convenience_renderer::NameStyleErrors)).
#[derive(Debug, Default)]
pub struct AcronymStyleCalls(Cell<Option<&'static str>>);

impl AcronymStyleCalls {
    /// `variable(word)`, `variable` holding `acronymStyle(style)`: the
    /// styled word; for `None` the word as it is, after recording the call
    /// (only the first one counts, TS stops there).
    pub fn call(
        &self,
        style: Option<AcronymStyleOptions>,
        variable: &'static str,
        word: &str,
    ) -> String {
        match style {
            Some(style) => acronym_style(style)(word),
            None => {
                if self.0.get().is_none() {
                    self.0.set(Some(variable));
                }
                word.to_owned()
            }
        }
    }

    /// `value`, or the `TypeError` of the first call of `undefined`.
    pub fn result<T>(self, value: T) -> Result<T> {
        match self.0.get() {
            None => Ok(value),
            Some(variable) => Err(QuickTypeError::js_exception(
                JsErrorName::TypeError,
                format!("{variable} is not a function"),
            )),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::renderer_options::PrototypeMember;

    #[test]
    fn prototype_members_select_no_style() {
        let declared = EnumValue::Declared("camel");
        assert_eq!(
            AcronymStyleOptions::from_enum_value(declared),
            Some(AcronymStyleOptions::Camel)
        );
        let member = EnumValue::Prototype(PrototypeMember::ToString);
        assert_eq!(AcronymStyleOptions::from_enum_value(member), None);

        let calls = AcronymStyleCalls::default();
        assert_eq!(
            calls.call(Some(AcronymStyleOptions::Pascal), "acronyms", "id"),
            "ID"
        );
        assert_eq!(calls.result("ok").unwrap(), "ok");
        let calls = AcronymStyleCalls::default();
        assert_eq!(calls.call(None, "style", "id"), "id");
        assert_eq!(calls.call(None, "acronyms", "url"), "url");
        let err = calls.result(()).unwrap_err();
        assert_eq!(err.to_string(), "style is not a function");
    }

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
