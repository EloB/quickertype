//! Port of `packages/quicktype-core/src/language/CSharp/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `cSharpOptions.framework`.
pub const FRAMEWORK: EnumOption = EnumOption::new(
    "framework",
    "Serialization framework",
    &["NewtonSoft", "SystemTextJson"],
    "SystemTextJson",
    OptionKind::Primary,
);

/// TS `cSharpOptions.useList`.
pub const USE_LIST: EnumOption = EnumOption::new(
    "array-type",
    "Use T[] or List<T>",
    &["array", "list"],
    "array",
    OptionKind::Primary,
);

/// TS `cSharpOptions.dense`.
pub const DENSE: EnumOption = EnumOption::new(
    "density",
    "Property density",
    &["normal", "dense"],
    "normal",
    OptionKind::Secondary,
);

/// TS `cSharpOptions.namespace`.
pub const NAMESPACE: StringOption = StringOption::new(
    "namespace",
    "Generated namespace",
    "NAME",
    "QuickType",
    OptionKind::Primary,
);

/// TS `cSharpOptions.version`.
pub const VERSION: EnumOption = EnumOption::new(
    "csharp-version",
    "C# version",
    &["5", "6", "8"],
    "8",
    OptionKind::Secondary,
);

/// TS `cSharpOptions.virtual`.
pub const VIRTUAL: BooleanOption = BooleanOption::new(
    "virtual",
    "Generate virtual properties",
    false,
    OptionKind::Primary,
);

/// TS `cSharpOptions.useRecords`.
pub const USE_RECORDS: BooleanOption = BooleanOption::new(
    "use-records",
    "Generate records instead of classes (C# 9+)",
    false,
    OptionKind::Primary,
);

/// TS `cSharpOptions.typeForAny`.
pub const TYPE_FOR_ANY: EnumOption = EnumOption::new(
    "any-type",
    "Type to use for \"any\"",
    &["object", "dynamic"],
    "object",
    OptionKind::Secondary,
);

/// TS `cSharpOptions.useDecimal`.
pub const USE_DECIMAL: EnumOption = EnumOption::new(
    "number-type",
    "Type to use for numbers",
    &["double", "decimal"],
    "double",
    OptionKind::Secondary,
);

/// TS `cSharpOptions.features`.
pub const FEATURES: EnumOption = EnumOption::new(
    "features",
    "Output features",
    &["complete", "attributes-only"],
    "complete",
    OptionKind::Primary,
);

/// TS `cSharpOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `cSharpOptions.baseclass`.
pub const BASECLASS: EnumOption = EnumOption::new(
    "base-class",
    "Base class",
    &["EntityData", "Object"],
    "Object",
    OptionKind::Secondary,
);

/// TS `cSharpOptions.checkRequired`.
pub const CHECK_REQUIRED: BooleanOption = BooleanOption::new(
    "check-required",
    "Fail if required properties are missing",
    false,
    OptionKind::Primary,
);

/// TS `cSharpOptions.keepPropertyName`.
pub const KEEP_PROPERTY_NAME: BooleanOption = BooleanOption::new(
    "keep-property-name",
    "Keep original field name generate",
    false,
    OptionKind::Primary,
);

/// TS `systemTextJsonCSharpOptions.dateTimeOnlyConverters` (only in the
/// System.Text.Json option set).
pub const DATE_TIME_ONLY_CONVERTERS: BooleanOption = BooleanOption::new(
    "dateonly-timeonly-converters",
    "Emit DateOnly/TimeOnly converters (requires .NET 6 or later)",
    true,
    OptionKind::Secondary,
);

/// TS `cSharpOptions`, in declaration order.
pub static C_SHARP_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(FRAMEWORK),
    RendererOption::Enum(USE_LIST),
    RendererOption::Enum(DENSE),
    RendererOption::String(NAMESPACE),
    RendererOption::Enum(VERSION),
    RendererOption::Boolean(VIRTUAL),
    RendererOption::Boolean(USE_RECORDS),
    RendererOption::Enum(TYPE_FOR_ANY),
    RendererOption::Enum(USE_DECIMAL),
    RendererOption::Enum(FEATURES),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(BASECLASS),
    RendererOption::Boolean(CHECK_REQUIRED),
    RendererOption::Boolean(KEEP_PROPERTY_NAME),
];

/// TS `newtonsoftCSharpOptions` (the same options as `cSharpOptions`).
pub static NEWTONSOFT_C_SHARP_OPTIONS: &[RendererOption] = C_SHARP_OPTIONS;

/// TS `systemTextJsonCSharpOptions`: `cSharpOptions` plus
/// `dateTimeOnlyConverters`. This is what the language exposes.
pub static SYSTEM_TEXT_JSON_C_SHARP_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(FRAMEWORK),
    RendererOption::Enum(USE_LIST),
    RendererOption::Enum(DENSE),
    RendererOption::String(NAMESPACE),
    RendererOption::Enum(VERSION),
    RendererOption::Boolean(VIRTUAL),
    RendererOption::Boolean(USE_RECORDS),
    RendererOption::Enum(TYPE_FOR_ANY),
    RendererOption::Enum(USE_DECIMAL),
    RendererOption::Enum(FEATURES),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(BASECLASS),
    RendererOption::Boolean(CHECK_REQUIRED),
    RendererOption::Boolean(KEEP_PROPERTY_NAME),
    RendererOption::Boolean(DATE_TIME_ONLY_CONVERTERS),
];

/// TS `cSharpLanguageConfig`.
pub const C_SHARP_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "C#",
    names: &["cs", "csharp"],
    extension: "cs",
};

/// The C# target language (TS `CSharpTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct CSharpTargetLanguage;

// TODO(renderer): port the hooks CSharpTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date -> date-time, time -> date-time, date-time -> date-time, uuid -> uuid, uri -> uri, integer-string -> integer-string, bool-string -> bool-string
// - supportsOptionalClassProperties: true
// - supportsUnionsWithBothNumberTypes: true
// - needsTransformerForType
impl TargetLanguage for CSharpTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &C_SHARP_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        SYSTEM_TEXT_JSON_C_SHARP_OPTIONS
    }
}
