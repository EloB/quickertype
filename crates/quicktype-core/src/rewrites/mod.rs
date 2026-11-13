//! The modules of `packages/quicktype-core/src/rewrites/`, one per TypeScript
//! file (the directory has no `index.ts`).

pub mod combine_classes;
pub mod expand_strings;
pub mod flatten_strings;
pub mod flatten_unions;
pub mod infer_maps;
pub mod replace_object_type;
pub mod resolve_intersections;
