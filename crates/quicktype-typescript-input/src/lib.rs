//! Port of `packages/quicktype-typescript-input/src/index.ts`.
//!
//! TypeScript type definitions as a quicktype input, type-checked by the
//! TypeScript 7 native compiler (`tsc --api`) instead of Node.js. See
//! `docs/research/07-typescript-input.md` for the design.

pub mod error;
pub mod tsc;

pub use error::{Error, Result};
