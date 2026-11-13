//! Port of `packages/quicktype-core/src/language/Swift/language.ts`.
//!
//! Language metadata and renderer option declarations.

use super::utils::SwiftDateTimeRecognizer;
use crate::date_time::DateTimeRecognizer;
use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption, acronym_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `swiftOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `swiftOptions.convenienceInitializers`.
pub const CONVENIENCE_INITIALIZERS: BooleanOption = BooleanOption::new(
    "initializers",
    "Generate initializers and mutators",
    true,
    OptionKind::Primary,
);

/// TS `swiftOptions.explicitCodingKeys`.
pub const EXPLICIT_CODING_KEYS: BooleanOption = BooleanOption::new(
    "coding-keys",
    "Explicit CodingKey values in Codable types",
    true,
    OptionKind::Primary,
);

/// TS `swiftOptions.codingKeysProtocol`.
pub const CODING_KEYS_PROTOCOL: StringOption = StringOption::new(
    "coding-keys-protocol",
    "CodingKeys implements protocols",
    "protocol1, protocol2...",
    "",
    OptionKind::Secondary,
);

/// TS `swiftOptions.alamofire`.
pub const ALAMOFIRE: BooleanOption = BooleanOption::new(
    "alamofire",
    "Alamofire extensions",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.namedTypePrefix`.
pub const NAMED_TYPE_PREFIX: StringOption = StringOption::new(
    "type-prefix",
    "Prefix for type names",
    "PREFIX",
    "",
    OptionKind::Secondary,
);

/// TS `swiftOptions.useClasses`.
pub const USE_CLASSES: EnumOption = EnumOption::new(
    "struct-or-class",
    "Structs or classes",
    &["struct", "class"],
    "struct",
    OptionKind::Primary,
);

/// TS `swiftOptions.finalClasses`.
pub const FINAL_CLASSES: BooleanOption = BooleanOption::new(
    "final-classes",
    "Mark classes as final",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.mutableProperties`.
pub const MUTABLE_PROPERTIES: BooleanOption = BooleanOption::new(
    "mutable-properties",
    "Use var instead of let for object properties",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `swiftOptions.dense`.
pub const DENSE: EnumOption = EnumOption::new(
    "density",
    "Code density",
    &["dense", "normal"],
    "normal",
    OptionKind::Secondary,
);

/// TS `swiftOptions.linux`.
pub const LINUX: BooleanOption = BooleanOption::new(
    "support-linux",
    "Support Linux",
    false,
    OptionKind::Secondary,
);

/// TS `swiftOptions.objcSupport`.
pub const OBJC_SUPPORT: BooleanOption = BooleanOption::new(
    "objective-c-support",
    "Objects inherit from NSObject and @objcMembers is added to classes",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.optionalEnums`.
pub const OPTIONAL_ENUMS: BooleanOption = BooleanOption::new(
    "optional-enums",
    "If no matching case is found enum value is set to null",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.sendable`.
pub const SENDABLE: BooleanOption = BooleanOption::new(
    "sendable",
    "Mark generated models as Sendable",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.multiFileOutput`.
pub const MULTI_FILE_OUTPUT: BooleanOption = BooleanOption::new(
    "multi-file-output",
    "Renders each top-level object in its own Swift file",
    false,
    OptionKind::Primary,
);

/// TS `swiftOptions.accessLevel`.
pub const ACCESS_LEVEL: EnumOption = EnumOption::new(
    "access-level",
    "Access level",
    &["internal", "public"],
    "internal",
    OptionKind::Secondary,
);

/// TS `swiftOptions.protocol`.
pub const PROTOCOL: EnumOption = EnumOption::new(
    "protocol",
    "Make types implement protocol",
    &["none", "equatable", "hashable"],
    "none",
    OptionKind::Secondary,
);

/// TS `swiftOptions`, in declaration order.
pub static SWIFT_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(CONVENIENCE_INITIALIZERS),
    RendererOption::Boolean(EXPLICIT_CODING_KEYS),
    RendererOption::String(CODING_KEYS_PROTOCOL),
    RendererOption::Boolean(ALAMOFIRE),
    RendererOption::String(NAMED_TYPE_PREFIX),
    RendererOption::Enum(USE_CLASSES),
    RendererOption::Boolean(FINAL_CLASSES),
    RendererOption::Boolean(MUTABLE_PROPERTIES),
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::Enum(DENSE),
    RendererOption::Boolean(LINUX),
    RendererOption::Boolean(OBJC_SUPPORT),
    RendererOption::Boolean(OPTIONAL_ENUMS),
    RendererOption::Boolean(SENDABLE),
    RendererOption::Boolean(MULTI_FILE_OUTPUT),
    RendererOption::Enum(ACCESS_LEVEL),
    RendererOption::Enum(PROTOCOL),
];

/// TS `swiftLanguageConfig`.
pub const SWIFT_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Swift",
    names: &["swift", "swift4"],
    extension: "swift",
};

/// The Swift target language (TS `SwiftTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct SwiftTargetLanguage;

impl TargetLanguage for SwiftTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &SWIFT_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        SWIFT_OPTIONS
    }

    // Inference hooks.

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [
            (TypeKind::DateTime, TypeKind::DateTime),
            (TypeKind::Uuid, TypeKind::Uuid),
        ]
        .into_iter()
        .collect()
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    /// TS `dateTimeRecognizer`: [`SwiftDateTimeRecognizer`].
    fn date_time_recognizer(&self) -> Box<dyn DateTimeRecognizer> {
        Box::new(SwiftDateTimeRecognizer)
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer` + `render`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::swift_renderer::SwiftOptions::parse(renderer_options)?;
        let renderer = super::swift_renderer::SwiftRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}

/// The values of the `access-level` option.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum AccessLevel {
    /// `"internal"`: Swift's default, emitted as nothing.
    Internal,
    /// `"public"`.
    Public,
}

/// The values of the `protocol` option: `none` (neither), `equatable` or
/// `hashable`.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct SwiftProtocol {
    /// `equatable`.
    pub equatable: bool,
    /// `hashable`.
    pub hashable: bool,
}
