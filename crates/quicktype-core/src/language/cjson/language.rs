//! Port of `packages/quicktype-core/src/language/CJSON/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `cJSONOptions.typeSourceStyle`.
pub const TYPE_SOURCE_STYLE: EnumOption = EnumOption::new(
    "source-style",
    "Source code generation type, whether to generate single or multiple source files",
    &["single-source", "multi-source"],
    "single-source",
    OptionKind::Secondary,
);

/// TS `cJSONOptions.typeIntegerSize`.
pub const TYPE_INTEGER_SIZE: EnumOption = EnumOption::new(
    "integer-size",
    "Integer code generation type (int64_t by default)",
    &["int8_t", "int16_t", "int32_t", "int64_t"],
    "int64_t",
    OptionKind::Secondary,
);

/// TS `cJSONOptions.hashtableSize`.
pub const HASHTABLE_SIZE: StringOption = StringOption::new(
    "hashtable-size",
    "Hashtable size, used when maps are created (64 by default)",
    "SIZE",
    "64",
    OptionKind::Primary,
);

/// TS `cJSONOptions.addTypedefAlias`.
pub const ADD_TYPEDEF_ALIAS: EnumOption = EnumOption::new(
    "typedef-alias",
    "Add typedef alias to unions, structs, and enums (no typedef by default)",
    &["no-typedef", "add-typedef"],
    "no-typedef",
    OptionKind::Secondary,
);

/// TS `cJSONOptions.printStyle`.
pub const PRINT_STYLE: EnumOption = EnumOption::new(
    "print-style",
    "Which cJSON print should be used (formatted by default)",
    &["print-formatted", "print-unformatted"],
    "print-formatted",
    OptionKind::Secondary,
);

/// TS `cJSONOptions.typeNamingStyle`.
pub const TYPE_NAMING_STYLE: EnumOption = EnumOption::new(
    "type-style",
    "Naming style for types",
    &[
        "pascal-case",
        "underscore-case",
        "camel-case",
        "upper-underscore-case",
        "pascal-case-upper-acronyms",
        "camel-case-upper-acronyms",
    ],
    "pascal-case",
    OptionKind::Primary,
);

/// TS `cJSONOptions.memberNamingStyle`.
pub const MEMBER_NAMING_STYLE: EnumOption = EnumOption::new(
    "member-style",
    "Naming style for members",
    &[
        "pascal-case",
        "underscore-case",
        "camel-case",
        "upper-underscore-case",
        "pascal-case-upper-acronyms",
        "camel-case-upper-acronyms",
    ],
    "underscore-case",
    OptionKind::Primary,
);

/// TS `cJSONOptions.enumeratorNamingStyle`.
pub const ENUMERATOR_NAMING_STYLE: EnumOption = EnumOption::new(
    "enumerator-style",
    "Naming style for enumerators",
    &[
        "pascal-case",
        "underscore-case",
        "camel-case",
        "upper-underscore-case",
        "pascal-case-upper-acronyms",
        "camel-case-upper-acronyms",
    ],
    "upper-underscore-case",
    OptionKind::Primary,
);

/// TS `cJSONOptions.headerOnly`.
pub const HEADER_ONLY: BooleanOption = BooleanOption::new(
    "header-only",
    "Generate headers only",
    true,
    OptionKind::Secondary,
);

/// TS `cJSONOptions`, in declaration order.
pub static C_JSON_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(TYPE_SOURCE_STYLE),
    RendererOption::Enum(TYPE_INTEGER_SIZE),
    RendererOption::String(HASHTABLE_SIZE),
    RendererOption::Enum(ADD_TYPEDEF_ALIAS),
    RendererOption::Enum(PRINT_STYLE),
    RendererOption::Enum(TYPE_NAMING_STYLE),
    RendererOption::Enum(MEMBER_NAMING_STYLE),
    RendererOption::Enum(ENUMERATOR_NAMING_STYLE),
    RendererOption::Boolean(HEADER_ONLY),
];

/// TS `cJSONLanguageConfig`.
pub const C_JSON_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "C (cJSON)",
    names: &["cjson", "cJSON"],
    extension: "h",
};

/// The C (cJSON) target language (TS `CJSONTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct CJsonTargetLanguage;

// TODO(renderer): port the hooks CJSONTargetLanguage overrides:
// - makeRenderer
// - supportsOptionalClassProperties: true
// - supportsUnionsWithBothNumberTypes: true
// - getSupportedIntegerRange: by `integer-size` (INT8/16/32_RANGE, else INT64_RANGE)
impl TargetLanguage for CJsonTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &C_JSON_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        C_JSON_OPTIONS
    }
}
