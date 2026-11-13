//! Port of `quicktype/src/CompressedJSONFromStream.ts`.
//!
//! The reader is in quicktype-core, as
//! `quicktype_core::input::compressed_json_from_stream::CompressedJsonFromStream`,
//! because the Rust API offers both JSON reading semantics (the CLI's
//! stream-json one and the JavaScript API's `JSON.parse` one). The CLI's
//! generation path (Phase 3) builds its JSON input with it:
//! `JsonInput::new(CompressedJsonFromStream::new(CompressedJson::for_target_language(..)))`,
//! where TypeScript's `jsonInputForTargetLanguage` in `src/index.ts` maps an
//! unknown language name to `typescript` first.
