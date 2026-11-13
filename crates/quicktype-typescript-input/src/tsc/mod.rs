//! Client for the TypeScript 7 native compiler's `tsc --api` protocol.
//!
//! See `docs/research/07-typescript-input.md` §3 for the protocol. The
//! layout follows `typescript/dist/api` of the pinned release:
//! [`locate`] (`lib/getExePath.js`), [`channel`] (`syncChannel.js`),
//! [`api`] (`sync/api.js`) and [`ast`] (`node/*.js`).

pub mod api;
pub mod ast;
pub mod channel;
pub mod generated;
pub mod locate;
