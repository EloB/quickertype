//! Port of `packages/quicktype-core/src/language/Rust/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, EnumOption, OptionKind, RendererOption};
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
// - getSupportedIntegerRange: INT32_RANGE with `integer-type force-i32`, else INT64_RANGE
impl TargetLanguage for RustTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &RUST_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        RUST_OPTIONS
    }

    // Renderer hooks.

    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::rust_renderer::RustOptions::parse(renderer_options)?;
        let renderer = super::rust_renderer::RustRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}

/// TS `IntegerType`: the values of the `integer-type` option.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum IntegerType {
    /// `"conservative"`: `i32` only if schema bounds prove it fits.
    Conservative,
    /// `"force-i32"`.
    ForceI32,
    /// `"force-i64"`.
    ForceI64,
}
