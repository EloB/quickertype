//! Port of `packages/quicktype-core/src/language/Rust/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, OptionValue, RendererOption, RendererOptions,
};
use crate::support::integer_range::{INT32_RANGE, INT64_RANGE, IntegerRange};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `rustOptions.density`.
pub const DENSITY: EnumOption = EnumOption::new(
    "density",
    "Density",
    &["normal", "dense"],
    "normal",
    OptionKind::Primary,
);

/// TS `rustOptions.visibility`.
pub const VISIBILITY: EnumOption = EnumOption::new(
    "visibility",
    "Field visibility",
    &["private", "crate", "public"],
    "public",
    OptionKind::Primary,
);

/// TS `rustOptions.integerType`.
pub const INTEGER_TYPE: EnumOption = EnumOption::new(
    "integer-type",
    "Integer type inference",
    &["conservative", "force-i32", "force-i64"],
    "conservative",
    OptionKind::Primary,
);

/// TS `rustOptions.deriveDebug`.
pub const DERIVE_DEBUG: BooleanOption = BooleanOption::new(
    "derive-debug",
    "Derive Debug impl",
    true,
    OptionKind::Primary,
);

/// TS `rustOptions.deriveClone`.
pub const DERIVE_CLONE: BooleanOption = BooleanOption::new(
    "derive-clone",
    "Derive Clone impl",
    true,
    OptionKind::Primary,
);

/// TS `rustOptions.derivePartialEq`.
pub const DERIVE_PARTIAL_EQ: BooleanOption = BooleanOption::new(
    "derive-partial-eq",
    "Derive PartialEq impl",
    false,
    OptionKind::Primary,
);

/// TS `rustOptions.skipSerializingNone`.
pub const SKIP_SERIALIZING_NONE: BooleanOption = BooleanOption::new(
    "skip-serializing-none",
    "Skip serializing empty Option fields",
    false,
    OptionKind::Primary,
);

/// TS `rustOptions.leadingComments`.
pub const LEADING_COMMENTS: BooleanOption = BooleanOption::new(
    "leading-comments",
    "Leading Comments",
    true,
    OptionKind::Primary,
);

/// TS `rustOptions`, in declaration order.
pub static RUST_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(DENSITY),
    RendererOption::Enum(VISIBILITY),
    RendererOption::Enum(INTEGER_TYPE),
    RendererOption::Boolean(DERIVE_DEBUG),
    RendererOption::Boolean(DERIVE_CLONE),
    RendererOption::Boolean(DERIVE_PARTIAL_EQ),
    RendererOption::Boolean(SKIP_SERIALIZING_NONE),
    RendererOption::Boolean(LEADING_COMMENTS),
];

/// TS `rustLanguageConfig`.
pub const RUST_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Rust",
    names: &["rust", "rs", "rustlang"],
    extension: "rs",
};

/// The Rust target language (TS `RustTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct RustTargetLanguage;

// TODO(renderer): port the hooks RustTargetLanguage overrides:
// - makeRenderer
impl TargetLanguage for RustTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &RUST_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        RUST_OPTIONS
    }

    // Inference hooks.

    /// TS `getSupportedIntegerRange`: with `integer-type force-i32` every
    /// integer renders as `i32`; `conservative` keeps the i64 range.
    fn get_supported_integer_range(
        &self,
        renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        let force_i32 = matches!(
            renderer_options.get(INTEGER_TYPE.name),
            Some(OptionValue::String(t)) if t == "force-i32"
        );
        Some(if force_i32 {
            INT32_RANGE.clone()
        } else {
            INT64_RANGE.clone()
        })
    }

    // End of inference hooks.
}
