//! Port of `src/CompressedJSONFromStream.ts`.
//!
//! The reader is in quicktype-core, as `CompressedJson::parse_stream`
//! (`quicktype_core::input::compressed_json_from_stream`), because the Rust
//! API offers both JSON reading semantics (the CLI's stream-json one and the
//! JavaScript API's `JSON.parse` one). The CLI's generation path (Phase 3)
//! adds its samples as `JsonSample::Stream` to a
//! `JsonInput::new(CompressedJson::for_target_language(..))`, where
//! TypeScript's `jsonInputForTargetLanguage` in `src/index.ts` maps an
//! unknown language name to `typescript` first.
