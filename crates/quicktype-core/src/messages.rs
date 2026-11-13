//! Port of `packages/quicktype-core/src/Messages.ts`.
//!
//! quicktype reports every error, internal or user-facing, as a
//! `QuickTypeError` carrying a message *kind* (its name, e.g.
//! `"SchemaFetchError"`), the kind's template and the *properties* used to
//! fill it in. This module is that error type for the whole engine: every
//! place where the TypeScript implementation throws returns
//! `Err(QuickTypeError)` instead.
//!
//! The user message is built exactly like `messageError` does it: the
//! properties are applied **in the order the call site lists them**, each one
//! replacing the *first* occurrence of `${name}` in the current message with
//! `String.prototype.replace` semantics, including the `$$`, `$&`, `` $` ``
//! and `$'` patterns in the replacement value.

use std::error::Error;
use std::fmt;

use quicktype_js_compat::{json, number};

/// The result type used throughout the engine.
pub type Result<T, E = QuickTypeError> = std::result::Result<T, E>;

macro_rules! error_kinds {
    ($($(#[$doc:meta])* $kind:ident => $template:expr,)*) => {
        /// The kind (the `messageName`) of a [`QuickTypeError`].
        #[allow(clippy::upper_case_acronyms)]
        #[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
        pub enum ErrorKind {
            $(
                $(#[$doc])*
                #[doc = concat!("Template: ", stringify!($template))]
                $kind,
            )*
        }

        impl ErrorKind {
            /// All kinds, in the order `Messages.ts` declares them.
            pub const ALL: &'static [ErrorKind] = &[$(ErrorKind::$kind,)*];

            /// The kind's name, e.g. `"InternalError"`.
            pub fn name(self) -> &'static str {
                match self {
                    $(ErrorKind::$kind => stringify!($kind),)*
                }
            }

            /// The message template, with `${property}` placeholders.
            pub fn template(self) -> &'static str {
                match self {
                    $(ErrorKind::$kind => $template,)*
                }
            }

            /// Looks a kind up by its name.
            pub fn from_name(name: &str) -> Option<ErrorKind> {
                match name {
                    $(stringify!($kind) => Some(ErrorKind::$kind),)*
                    _ => None,
                }
            }
        }
    };
}

error_kinds! {
    InternalError => "Internal error: ${message}",

    // Misc
    MiscJSONParseError => "Syntax error in ${description} JSON ${address}: ${message}",
    MiscReadError => "Cannot read from file or URL ${fileOrURL}: ${message}",
    MiscUnicodeHighSurrogateWithoutLowSurrogate =>
        "Malformed unicode: High surrogate not followed by low surrogate",
    MiscInvalidMinMaxConstraint => "Invalid min-max constraint: ${min}-${max}",

    // Inference
    InferenceJSONReferenceNotRooted => "JSON reference doesn't start with '#/': ${reference}",
    InferenceJSONReferenceToUnion => "JSON reference points to a union type: ${reference}",
    InferenceJSONReferenceWrongProperty =>
        "JSON reference points to a non-existant property: ${reference}",
    InferenceJSONReferenceInvalidArrayIndex =>
        "JSON reference uses invalid array index: ${reference}",

    // JSON Schema input
    SchemaArrayIsInvalidSchema => "An array is not a valid JSON Schema at ${ref}",
    SchemaNullIsInvalidSchema => "null is not a valid JSON Schema at ${ref}",
    SchemaRefMustBeString => "$ref must be a string, but is an ${actual} at ${ref}",
    SchemaAdditionalTypesForbidRequired =>
        "Can't have non-specified required properties but forbidden additionalTypes at ${ref}",
    SchemaNoTypeSpecified => "JSON Schema must specify at least one type at ${ref}",
    SchemaInvalidType => "Invalid type ${type} in JSON Schema at ${ref}",
    SchemaFalseNotSupported => "Schema \"false\" is not supported at ${ref}",
    SchemaInvalidJSONSchemaType => "Value of type ${type} is not valid JSON Schema at ${ref}",
    SchemaRequiredMustBeStringOrStringArray =>
        "`required` must be string or array of strings, but is ${actual} at ${ref}",
    SchemaRequiredElementMustBeString =>
        "`required` must contain only strings, but it has ${element}, at ${ref}",
    SchemaTypeMustBeStringOrStringArray =>
        "`type` must be string or array of strings, but is ${actual}",
    SchemaTypeElementMustBeString => "`type` must contain only strings, but it has ${element}",
    SchemaArrayItemsMustBeStringOrArray =>
        "Array items must be an array or an object, but is ${actual}",
    SchemaIDMustHaveAddress => "$id ${id} doesn't have an address at ${ref}",
    SchemaWrongAccessorEntryArrayLength =>
        "Accessor entry array must have the same number of entries as the ${operation} at ${ref}",
    SchemaSetOperationCasesIsNotArray =>
        "${operation} cases must be an array, but is ${cases}, at ${ref}",
    SchemaMoreThanOneUnionMemberName => "More than one name given for union member: ${names}",
    SchemaCannotGetTypesFromBoolean =>
        "Schema value to get top-level types from must be an object, but is boolean, at ${ref}",
    SchemaCannotIndexArrayWithNonNumber =>
        "Trying to index array in schema with key that is not a number, but is ${actual} at ${ref}",
    SchemaIndexNotInArray => "Index ${index} out of range of schema array at ${ref}",
    SchemaKeyNotInObject => "Key ${key} not in schema object at ${ref}",
    SchemaFetchError => "Could not fetch schema ${address}, referred to from ${base}",
    SchemaFetchErrorTopLevel => "Could not fetch top-level schema ${address}",
    SchemaFetchErrorAdditional => "Could not fetch additional schema ${address}",

    // GraphQL input
    GraphQLNoQueriesDefined => "GraphQL file doesn't have any queries defined.",

    // Driver
    DriverUnknownSourceLanguage => "Unknown source language ${lang}",
    DriverUnknownOutputLanguage => "Unknown output language ${lang}",
    DriverMoreThanOneInputGiven => "More than one input given for top-level ${topLevel}",
    DriverCannotInferNameForSchema => "Cannot infer name for schema ${uri}",
    DriverNoGraphQLQueryGiven => "Please specify at least one GraphQL query as input",
    DriverNoGraphQLSchemaInDir => "No GraphQL schema in ${dir}",
    DriverMoreThanOneGraphQLSchemaInDir => "More than one GraphQL schema in ${dir}",
    DriverSourceLangMustBeGraphQL =>
        "If a GraphQL schema is specified, the source language must be GraphQL",
    DriverGraphQLSchemaNeeded =>
        "Please specify a GraphQL schema with --graphql-schema or --graphql-introspect",
    DriverInputFileDoesNotExist => "Input file ${filename} does not exist",
    DriverCannotMixJSONWithOtherSamples =>
        "Cannot mix JSON samples with JSON Schems, GraphQL, or TypeScript in input subdirectory ${dir}",
    DriverCannotMixNonJSONInputs =>
        "Cannot mix JSON Schema, GraphQL, and TypeScript in an input subdirectory ${dir}",
    DriverNoSamplesForTopLevel => "No JSON samples given for top-level ${name}",
    DriverUnknownDebugOption => "Unknown debug option ${option}",
    DriverNoLanguageOrExtension => "Please specify a language (--lang) or an output file extension",
    DriverCLIOptionParsingFailed => "Option parsing failed: ${message}",

    // IR
    IRNoForwardDeclarableTypeInCycle =>
        "Cannot resolve cycle because it doesn't contain types that can be forward declared",
    IRTypeAttributesNotPropagated =>
        "Type attributes for ${count} types were not carried over to the new graph: ${indexes}",
    IRNoEmptyUnions =>
        "Trying to make an empty union - do you have an impossible type in your schema?",

    // Rendering
    RendererUnknownOptionValue => "Unknown value ${value} for option ${name}",

    // TypeScript input
    TypeScriptCompilerError => "TypeScript error: ${message}",
}

/// A property value of a [`QuickTypeError`], modelled on the JavaScript value
/// `messageError` received, because the stringification rules depend on it.
#[derive(Clone, Debug, PartialEq)]
pub enum MessageValue {
    /// `undefined`; stringifies as `"undefined"`.
    Undefined,
    /// `null`; stringifies as `"null"` (via `JSON.stringify`).
    Null,
    /// A boolean.
    Bool(bool),
    /// A number; stringifies via `JSON.stringify` (`NaN`/`Infinity` → `"null"`).
    Number(f64),
    /// A string; inserted as is.
    String(String),
    /// An array; stringifies via `Array.prototype.toString` (`join(",")`).
    Array(Vec<MessageValue>),
    /// A plain object; stringifies as `"[object Object]"`.
    Object(Vec<(String, MessageValue)>),
    /// An object with its own `toString()` (such as a JSON Schema `Ref`),
    /// carrying the result of that `toString()`.
    Display(String),
}

impl MessageValue {
    /// How `messageError` turns the value into text.
    fn message_string(&self) -> String {
        match self {
            // typeof "object" with a toString function
            MessageValue::Array(_) | MessageValue::Object(_) | MessageValue::Display(_) => {
                self.to_js_string()
            }
            MessageValue::String(s) => s.clone(),
            // `JSON.stringify(undefined)` is `undefined`, which `replace`
            // converts to the string "undefined".
            MessageValue::Undefined => "undefined".to_owned(),
            MessageValue::Null => "null".to_owned(),
            MessageValue::Bool(b) => b.to_string(),
            // `JSON.stringify(number)`.
            MessageValue::Number(n) => json::number(*n),
        }
    }

    /// JavaScript `String(value)`.
    fn to_js_string(&self) -> String {
        match self {
            MessageValue::Undefined => "undefined".to_owned(),
            MessageValue::Null => "null".to_owned(),
            MessageValue::Bool(b) => b.to_string(),
            MessageValue::Number(n) => number::to_string(*n),
            MessageValue::String(s) | MessageValue::Display(s) => s.clone(),
            MessageValue::Object(_) => "[object Object]".to_owned(),
            MessageValue::Array(items) => items
                .iter()
                .map(|item| match item {
                    MessageValue::Undefined | MessageValue::Null => String::new(),
                    other => other.to_js_string(),
                })
                .collect::<Vec<_>>()
                .join(","),
        }
    }
}

impl From<&str> for MessageValue {
    fn from(s: &str) -> Self {
        MessageValue::String(s.to_owned())
    }
}

impl From<String> for MessageValue {
    fn from(s: String) -> Self {
        MessageValue::String(s)
    }
}

impl From<f64> for MessageValue {
    fn from(n: f64) -> Self {
        MessageValue::Number(n)
    }
}

impl From<usize> for MessageValue {
    fn from(n: usize) -> Self {
        MessageValue::Number(n as f64)
    }
}

impl From<bool> for MessageValue {
    fn from(b: bool) -> Self {
        MessageValue::Bool(b)
    }
}

impl<T: Into<MessageValue>> From<Vec<T>> for MessageValue {
    fn from(v: Vec<T>) -> Self {
        MessageValue::Array(v.into_iter().map(Into::into).collect())
    }
}

impl<T: Into<MessageValue>> From<Option<T>> for MessageValue {
    fn from(v: Option<T>) -> Self {
        v.map_or(MessageValue::Undefined, Into::into)
    }
}

/// quicktype's error: a message kind, its properties and the filled-in user
/// message. The JS facade rebuilds a `QuickTypeError` from
/// [`kind`](Self::kind), [`error_message`](Self::error_message),
/// [`user_message`](Self::user_message) and [`properties`](Self::properties).
#[derive(Clone, PartialEq)]
pub struct QuickTypeError(Box<Inner>);

#[derive(Clone, Debug, PartialEq)]
struct Inner {
    kind: ErrorKind,
    user_message: String,
    properties: Vec<(String, MessageValue)>,
}

impl QuickTypeError {
    /// Builds the error like `messageError(kind, properties)`. `properties`
    /// must be in the order the TypeScript call site lists them.
    pub fn new<N: Into<String>>(kind: ErrorKind, properties: Vec<(N, MessageValue)>) -> Self {
        let properties: Vec<(String, MessageValue)> =
            properties.into_iter().map(|(n, v)| (n.into(), v)).collect();
        let mut user_message = kind.template().to_owned();
        for (name, value) in &properties {
            let pattern = format!("${{{name}}}");
            user_message = replace_first(&user_message, &pattern, &value.message_string());
        }
        QuickTypeError(Box::new(Inner {
            kind,
            user_message,
            properties,
        }))
    }

    /// An `InternalError`, as thrown by `assert`, `panic` and friends.
    pub fn internal(message: impl Into<String>) -> Self {
        QuickTypeError::new(
            ErrorKind::InternalError,
            vec![("message", message.into().into())],
        )
    }

    /// The message kind.
    pub fn kind(&self) -> ErrorKind {
        self.0.kind
    }

    /// The kind's name (`messageName` in TypeScript).
    pub fn message_name(&self) -> &'static str {
        self.0.kind.name()
    }

    /// The unfilled template (`errorMessage` in TypeScript).
    pub fn error_message(&self) -> &'static str {
        self.0.kind.template()
    }

    /// The filled-in message shown to the user.
    pub fn user_message(&self) -> &str {
        &self.0.user_message
    }

    /// Replaces the user message (`userMessage` is mutable in TypeScript).
    pub fn set_user_message(&mut self, message: String) {
        self.0.user_message = message;
    }

    /// The properties, in call-site order.
    pub fn properties(&self) -> &[(String, MessageValue)] {
        &self.0.properties
    }
}

impl fmt::Debug for QuickTypeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("QuickTypeError")
            .field("kind", &self.0.kind)
            .field("user_message", &self.0.user_message)
            .field("properties", &self.0.properties)
            .finish()
    }
}

impl fmt::Display for QuickTypeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.0.user_message)
    }
}

impl Error for QuickTypeError {}

/// `messageError(kind, properties)`: always returns `Err`.
pub fn message_error<T, N: Into<String>>(
    kind: ErrorKind,
    properties: Vec<(N, MessageValue)>,
) -> Result<T> {
    Err(QuickTypeError::new(kind, properties))
}

/// `messageAssert(assertion, kind, properties)`.
pub fn message_assert<N: Into<String>>(
    assertion: bool,
    kind: ErrorKind,
    properties: Vec<(N, MessageValue)>,
) -> Result<()> {
    if assertion {
        Ok(())
    } else {
        message_error(kind, properties)
    }
}

/// `haystack.replace(pattern, replacement)` for a string `pattern`: replaces
/// the first occurrence only, expanding `$$`, `$&`, `` $` `` and `$'` in
/// `replacement`. With a string pattern there are no capture groups, so `$1`,
/// `$<name>` and a lone `$` stay literal.
pub(crate) fn replace_first(haystack: &str, pattern: &str, replacement: &str) -> String {
    let Some(position) = haystack.find(pattern) else {
        return haystack.to_owned();
    };
    let before = &haystack[..position];
    let after = &haystack[position + pattern.len()..];

    let mut result = String::with_capacity(haystack.len() + replacement.len());
    result.push_str(before);
    let mut chars = replacement.chars().peekable();
    while let Some(c) = chars.next() {
        if c != '$' {
            result.push(c);
            continue;
        }
        match chars.peek() {
            Some('$') => {
                chars.next();
                result.push('$');
            }
            Some('&') => {
                chars.next();
                result.push_str(pattern);
            }
            Some('`') => {
                chars.next();
                result.push_str(before);
            }
            Some('\'') => {
                chars.next();
                result.push_str(after);
            }
            _ => result.push('$'),
        }
    }
    result.push_str(after);
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn fills_template_in_call_site_order() {
        let e = QuickTypeError::new(
            ErrorKind::MiscInvalidMinMaxConstraint,
            vec![("min", 3.0.into()), ("max", 1.5.into())],
        );
        assert_eq!(e.user_message(), "Invalid min-max constraint: 3-1.5");
        assert_eq!(e.message_name(), "MiscInvalidMinMaxConstraint");
        assert_eq!(
            e.error_message(),
            "Invalid min-max constraint: ${min}-${max}"
        );
        assert_eq!(e.to_string(), e.user_message());
    }

    #[test]
    fn stringifies_values_like_message_error() {
        let e = QuickTypeError::new(
            ErrorKind::IRTypeAttributesNotPropagated,
            vec![
                ("count", MessageValue::Number(2.0)),
                (
                    "indexes",
                    vec![MessageValue::Number(1.0), MessageValue::Number(12.0)].into(),
                ),
            ],
        );
        assert_eq!(
            e.user_message(),
            "Type attributes for 2 types were not carried over to the new graph: 1,12"
        );
        let e = QuickTypeError::new(
            ErrorKind::SchemaRequiredMustBeStringOrStringArray,
            vec![
                ("actual", MessageValue::Object(vec![])),
                ("ref", MessageValue::Display("#/definitions/x".into())),
            ],
        );
        assert_eq!(
            e.user_message(),
            "`required` must be string or array of strings, but is [object Object] at #/definitions/x"
        );
        let e = QuickTypeError::new(
            ErrorKind::SchemaTypeMustBeStringOrStringArray,
            vec![("actual", MessageValue::Null)],
        );
        assert_eq!(
            e.user_message(),
            "`type` must be string or array of strings, but is null"
        );
        let e = QuickTypeError::new(
            ErrorKind::SchemaTypeMustBeStringOrStringArray,
            vec![("actual", MessageValue::Undefined)],
        );
        assert_eq!(
            e.user_message(),
            "`type` must be string or array of strings, but is undefined"
        );
        let e = QuickTypeError::new(
            ErrorKind::SchemaTypeMustBeStringOrStringArray,
            vec![("actual", MessageValue::Number(f64::NAN))],
        );
        assert_eq!(
            e.user_message(),
            "`type` must be string or array of strings, but is null"
        );
        let e = QuickTypeError::new(
            ErrorKind::SchemaMoreThanOneUnionMemberName,
            vec![(
                "names",
                MessageValue::Array(vec![
                    "a".into(),
                    MessageValue::Null,
                    MessageValue::Array(vec!["b".into(), "c".into()]),
                ]),
            )],
        );
        assert_eq!(
            e.user_message(),
            "More than one name given for union member: a,,b,c"
        );
    }

    #[test]
    fn replace_uses_dollar_patterns() {
        assert_eq!(replace_first("a ${x} b", "${x}", "$$"), "a $ b");
        assert_eq!(replace_first("a ${x} b", "${x}", "[$&]"), "a [${x}] b");
        assert_eq!(replace_first("a ${x} b", "${x}", "[$`]"), "a [a ] b");
        assert_eq!(replace_first("a ${x} b", "${x}", "[$']"), "a [ b] b");
        assert_eq!(replace_first("a ${x} b", "${x}", "$1$<n>$"), "a $1$<n>$ b");
        assert_eq!(replace_first("${x}${x}", "${x}", "y"), "y${x}");
        assert_eq!(replace_first("none", "${x}", "y"), "none");
    }

    #[test]
    fn later_properties_see_earlier_substitutions() {
        // `messageError` replaces in the current message, so a value that
        // contains another placeholder gets that placeholder filled in too.
        let e = QuickTypeError::new(
            ErrorKind::SchemaKeyNotInObject,
            vec![("key", "${ref}".into()), ("ref", "R".into())],
        );
        assert_eq!(e.user_message(), "Key R not in schema object at ${ref}");
    }

    #[test]
    fn kinds_round_trip_by_name() {
        assert_eq!(ErrorKind::ALL.len(), 55);
        for &kind in ErrorKind::ALL {
            assert_eq!(ErrorKind::from_name(kind.name()), Some(kind));
        }
        assert_eq!(ErrorKind::from_name("Nope"), None);
    }
}
