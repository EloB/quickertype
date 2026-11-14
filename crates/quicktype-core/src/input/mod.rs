//! The modules of `packages/quicktype-core/src/input/`, one per TypeScript
//! file (the directory has no `index.ts`).

pub mod compressed_json;
/// Not in quicktype-core's `input/` but in the CLI (`src/`); here because the
/// Rust API offers both JSON reading semantics.
pub mod compressed_json_from_stream;
pub mod fetching_json_schema_store;
pub mod inference;
pub mod inputs;
pub mod io;
/// Not a quicktype file: the scan of string bodies both JSON readers share.
pub(crate) mod json_scan;
pub mod json_schema_input;
pub mod json_schema_store;
/// Not a quicktype file: where to split a large top-level array, to read
/// it on several threads.
#[cfg(not(target_family = "wasm"))]
pub(crate) mod json_split;
/// Not a quicktype file: reading a large top-level array on several
/// threads.
#[cfg(not(target_family = "wasm"))]
pub(crate) mod parallel_read;
pub mod path_element;
pub mod postman_collection;
pub(crate) mod tallies;
pub(crate) mod tally_inference;
