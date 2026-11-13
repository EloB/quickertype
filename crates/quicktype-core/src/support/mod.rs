//! Port of `packages/quicktype-core/src/support/index.ts`.

pub mod acronyms;
pub mod acronyms_const;
pub mod chance;
pub mod collection_utils;
pub mod comments;
pub mod converters;
pub mod integer_range;
pub(crate) mod js_shim;
pub mod parse_json;
pub mod strings;
#[allow(clippy::module_inception)]
pub mod support;
pub mod windows_paths;
