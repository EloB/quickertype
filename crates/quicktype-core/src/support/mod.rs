//! The modules of `packages/quicktype-core/src/support/`, one per TypeScript
//! file (the directory has no `index.ts`).

pub mod acronyms;
pub mod acronyms_const;
pub mod chance;
pub mod collection_utils;
pub mod comments;
pub mod converters;
pub mod fast_hash;
pub mod integer_range;
pub mod parse_json;
pub mod recursion;
pub mod strings;
#[allow(clippy::module_inception)]
pub mod support;
pub mod windows_paths;
