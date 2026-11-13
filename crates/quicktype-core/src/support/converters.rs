//! Port of `packages/quicktype-core/src/support/Converters.ts`.
//!
//! The `converters` option of the JavaScript-family renderers. The option
//! declaration itself is
//! [`renderer_options::converters_option`](crate::renderer_options::converters_option),
//! re-exported here.

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

    /// The value for an option value name returned by
    /// [`EnumOption::get_enum_value`](crate::renderer_options::EnumOption::get_enum_value).
    pub fn from_name(name: &str) -> Option<Self> {
        match name {
            "all-objects" => Some(ConvertersOptions::AllObjects),
            "top-level" => Some(ConvertersOptions::TopLevel),
            _ => None,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn round_trips_option_values() {
        for v in [ConvertersOptions::AllObjects, ConvertersOptions::TopLevel] {
            assert_eq!(ConvertersOptions::from_name(v.as_str()), Some(v));
        }
        assert_eq!(converters_option().default_value, "top-level");
        assert_eq!(ConvertersOptions::from_name("toString"), None);
    }
}
