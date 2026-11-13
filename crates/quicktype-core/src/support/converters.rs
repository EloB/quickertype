//! Port of `packages/quicktype-core/src/support/Converters.ts`.
//!
//! The `converters` option of the JavaScript-family renderers. The option
//! declaration itself is
//! [`renderer_options::converters_option`](crate::renderer_options::converters_option),
//! re-exported here.

use crate::renderer_options::EnumValue;
pub use crate::renderer_options::converters_option;

/// `ConvertersOptions`: which converters to generate.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum ConvertersOptions {
    /// `"all-objects"`: a converter for every object type.
    AllObjects,
    /// `"top-level"`: converters for the top-level types only (the default).
    TopLevel,
}

impl ConvertersOptions {
    /// The option value as written on the command line.
    pub fn as_str(self) -> &'static str {
        match self {
            ConvertersOptions::AllObjects => "all-objects",
            ConvertersOptions::TopLevel => "top-level",
        }
    }

    /// The converters an option value selects, as the renderers'
    /// `switch (converters)` reads it: `AllObjects` for `all-objects`, the
    /// default branch (top-level converters) for anything else, an
    /// `Object.prototype` member included.
    pub fn from_enum_value(value: EnumValue) -> Self {
        match value {
            EnumValue::Declared("all-objects") => ConvertersOptions::AllObjects,
            _ => ConvertersOptions::TopLevel,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn round_trips_option_values() {
        for v in [ConvertersOptions::AllObjects, ConvertersOptions::TopLevel] {
            let value = EnumValue::Declared(v.as_str());
            assert_eq!(ConvertersOptions::from_enum_value(value), v);
        }
        assert_eq!(converters_option().default_value, "top-level");
        let member = EnumValue::Prototype(crate::renderer_options::PrototypeMember::ToString);
        assert_eq!(
            ConvertersOptions::from_enum_value(member),
            ConvertersOptions::TopLevel
        );
    }
}
