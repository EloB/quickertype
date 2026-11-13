//! Port of `packages/quicktype-core/src/input/FetchingJSONSchemaStore.ts`.
//!
//! The store the CLI uses: every address is read with
//! [`read_from_file_or_url`] (files, `file://` URIs, URLs with optional
//! HTTP headers) and parsed with [`parse_json`] (JSON, else YAML).

use crate::input::io::LocalBoxFuture;
use crate::input::io::node_io::{Io, read_from_file_or_url};
use crate::input::json_schema_store::{JsonSchema, JsonSchemaStore, SchemaCache};
use crate::messages::Result;
use crate::support::parse_json::parse_json;

/// `FetchingJSONSchemaStore`: reads schemas from files and URLs through an
/// [`Io`].
#[derive(Debug)]
pub struct FetchingJsonSchemaStore<I: Io> {
    io: I,
    http_headers: Vec<String>,
    cache: SchemaCache,
}

impl<I: Io> FetchingJsonSchemaStore<I> {
    /// `new FetchingJSONSchemaStore(httpHeaders)` on the given I/O.
    pub fn with_io(io: I, http_headers: Vec<String>) -> Self {
        FetchingJsonSchemaStore {
            io,
            http_headers,
            cache: SchemaCache::new(),
        }
    }
}

#[cfg(feature = "fs")]
impl FetchingJsonSchemaStore<crate::input::io::node_io::StdIo> {
    /// `new FetchingJSONSchemaStore(httpHeaders)` on the standard library's
    /// file system (and network, with the `http` feature).
    pub fn new(http_headers: Vec<String>) -> Self {
        Self::with_io(crate::input::io::node_io::StdIo, http_headers)
    }
}

impl<I: Io> JsonSchemaStore for FetchingJsonSchemaStore<I> {
    fn fetch<'a>(&'a mut self, address: &'a str) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        Box::pin(async move {
            let text = read_from_file_or_url(&self.io, address, &self.http_headers).await?;
            let value = parse_json(&text, "JSON Schema", Some(address))?;
            Ok(Some(JsonSchema::from(value)))
        })
    }

    fn cache(&mut self) -> &mut SchemaCache {
        &mut self.cache
    }
}
