//! Collecting the sources of a JSON or JSON Schema run: port of
//! `getSources`, `getSourceURIs`, `typeSourcesForURIs`,
//! `sourceFromFileOrUrlArray`, `samplesFromDirectory` and
//! `typeNameFromFilename` in `src/index.ts`.
//!
//! Sources are opened here (missing files fail now) and read later, when
//! the input parses them.
//!
//! Not in TypeScript: JSON samples may be JSON Lines, as [`JsonLines`]
//! says: the inputs named on the command line by their names or all of
//! them, the files in directories by their names
//! ([`is_json_lines_name`]); or, with a `--src-lang` other than `jsonl`,
//! none, exactly as quicktype.

use quicktype_core::{
    ErrorKind, JsonSchemaSourceData, QuickTypeError, Readable, is_url, parse_json,
};
use quicktype_graphql_input::GraphQlSourceData;

use crate::cli_options::{CliOptions, JsonLines};
use crate::js;
use crate::messages::{CliError, message_error};
use crate::node_fs;
use crate::type_source::{JsonSampleSource, JsonTypeSource, TypeSource};
use crate::url_grammar::urls_from_url_grammar;

impl JsonLines {
    /// Whether the sample from `file_or_url`, named on the command line,
    /// is JSON Lines.
    fn sample(self, file_or_url: &str) -> bool {
        match self {
            JsonLines::ByName => is_json_lines_name(file_or_url),
            JsonLines::Never => false,
            JsonLines::Always => true,
        }
    }

    /// Whether the files in directories go by their names (otherwise a
    /// directory is read exactly as quicktype reads it).
    fn by_name_in_directories(self) -> bool {
        self != JsonLines::Never
    }
}

/// Whether `file_or_url` names JSON Lines: its extension is `.jsonl` or
/// `.ndjson`, in any case. A URL's is that of its path, without the query
/// or the fragment. The one test of names, for the inputs named on the
/// command line (without `--src-lang`) and for the files in directories.
pub fn is_json_lines_name(file_or_url: &str) -> bool {
    let name = if is_url(file_or_url) {
        let end = file_or_url.find(['?', '#']).unwrap_or(file_or_url.len());
        &file_or_url[..end]
    } else {
        file_or_url
    };
    let ends_with = |extension: &str| {
        name.len() >= extension.len()
            && name.as_bytes()[name.len() - extension.len()..]
                .eq_ignore_ascii_case(extension.as_bytes())
    };
    ends_with(".jsonl") || ends_with(".ndjson")
}

/// `sourceFromFileOrUrlArray(name, filesOrUrls, httpHeaders)`: one JSON
/// source whose samples are all the files.
async fn source_from_file_or_url_array(
    name: &str,
    files_or_urls: &[String],
    http_headers: &[String],
    json_lines: JsonLines,
) -> Result<JsonTypeSource, CliError> {
    let mut samples = Vec::with_capacity(files_or_urls.len());
    for file in files_or_urls {
        samples.push(JsonSampleSource {
            readable: node_fs::readable_from_file_or_url(file, http_headers).await?,
            json_lines: json_lines.sample(file),
        });
    }
    Ok(JsonTypeSource {
        name: name.to_owned(),
        samples,
        description: None,
    })
}

/// `typeNameFromFilename(filename)`: the base name up to its last `.`, or
/// `""` if it has none.
pub fn type_name_from_filename(filename: &str) -> String {
    let name = js::basename(filename);
    match name.rfind('.') {
        Some(index) => name[..index].to_owned(),
        None => String::new(),
    }
}

/// What `readFilesOrURLsInDirectory` collects for a GraphQL schema.
struct GraphQlSchemaFile {
    readable: Readable,
    file_name: String,
}

/// `readFilesOrURLsInDirectory(d)` of `samplesFromDirectory(dataDir)`: one
/// source per file in `d`. `data_dir` is the directory given on the
/// command line, which the errors name. Not in TypeScript, unless a
/// `--src-lang` other than `jsonl` was given ([`JsonLines::Never`]):
/// `*.jsonl` and `*.ndjson` files are JSON samples too, read as JSON
/// Lines, and so is a `.url` file's URL that is named so
/// ([`is_json_lines_name`]): a file's name says what it holds.
async fn read_files_or_urls_in_directory(
    d: &str,
    data_dir: &str,
    http_headers: &[String],
    json_lines: JsonLines,
) -> Result<Vec<TypeSource>, CliError> {
    let by_name = json_lines.by_name_in_directories();
    let mut files = Vec::new();
    for entry in node_fs::readdir_sync(d)? {
        let path = js::path_join(&[d, &entry]);
        if node_fs::is_file(&path)? {
            files.push(path);
        }
    }

    let mut sources_in_dir = Vec::new();
    let mut graphql_sources: Vec<(String, String)> = Vec::new();
    let mut graphql_schema: Option<GraphQlSchemaFile> = None;
    for file in files {
        let name = type_name_from_filename(&file);
        let mut file_or_url = file.clone();
        // TypeScript lower-cases the path itself, and reads `.url` files
        // under that name.
        let file = file.to_lowercase();

        // If the file holds a URL, that is the source.
        if file.ends_with(".url") {
            file_or_url = js::trim(&node_fs::read_file_sync_utf8(&file)?).to_owned();
        }

        if file.ends_with(".url")
            || file.ends_with(".json")
            || (by_name && is_json_lines_name(&file))
        {
            sources_in_dir.push(TypeSource::Json(JsonTypeSource {
                name,
                samples: vec![JsonSampleSource {
                    readable: node_fs::readable_from_file_or_url(&file_or_url, http_headers)
                        .await?,
                    json_lines: by_name && is_json_lines_name(&file_or_url),
                }],
                description: None,
            }));
        } else if file.ends_with(".schema") {
            sources_in_dir.push(TypeSource::Schema(JsonSchemaSourceData {
                name,
                uris: Some(vec![file_or_url]),
                schema: None,
                is_converted: false,
            }));
        } else if file.ends_with(".gqlschema") {
            if graphql_schema.is_some() {
                return Err(message_error(
                    ErrorKind::DriverMoreThanOneGraphQLSchemaInDir,
                    vec![("dir", data_dir.into())],
                ));
            }
            graphql_schema = Some(GraphQlSchemaFile {
                readable: node_fs::readable_from_file_or_url(&file_or_url, http_headers).await?,
                file_name: file_or_url,
            });
        } else if file.ends_with(".graphql") {
            let query = node_fs::read(
                node_fs::readable_from_file_or_url(&file_or_url, http_headers).await?,
            )
            .await?;
            graphql_sources.push((name, query));
        }
    }

    if !graphql_sources.is_empty() {
        let Some(schema) = graphql_schema else {
            return Err(message_error(
                ErrorKind::DriverNoGraphQLSchemaInDir,
                vec![("dir", data_dir.into())],
            ));
        };
        let schema = parse_json(
            &node_fs::read(schema.readable).await?,
            "GraphQL schema",
            Some(&schema.file_name),
        )?;
        for (name, query) in graphql_sources {
            sources_in_dir.push(TypeSource::GraphQl(GraphQlSourceData {
                name,
                schema: schema.clone(),
                query,
            }));
        }
    }

    Ok(sources_in_dir)
}

/// `samplesFromDirectory(dataDir, httpHeaders)`: the sources of the files
/// in `data_dir`, then one source per subdirectory, whose JSON samples all
/// go into one top-level named after it.
async fn samples_from_directory(
    data_dir: &str,
    http_headers: &[String],
    json_lines: JsonLines,
) -> Result<Vec<TypeSource>, CliError> {
    let mut directories = Vec::new();
    for entry in node_fs::readdir_sync(data_dir)? {
        let path = js::path_join(&[data_dir, &entry]);
        if node_fs::is_directory(&path)? {
            directories.push(path);
        }
    }

    let mut sources =
        read_files_or_urls_in_directory(data_dir, data_dir, http_headers, json_lines).await?;

    for dir in directories {
        let mut json_samples = Vec::new();
        let mut schema_sources = Vec::new();
        let mut graphql_sources = Vec::new();

        for source in
            read_files_or_urls_in_directory(&dir, data_dir, http_headers, json_lines).await?
        {
            match source {
                TypeSource::Json(json) => json_samples.extend(json.samples),
                TypeSource::Schema(schema) => schema_sources.push(TypeSource::Schema(schema)),
                TypeSource::GraphQl(graphql) => graphql_sources.push(TypeSource::GraphQl(graphql)),
            }
        }

        if !json_samples.is_empty() && schema_sources.len() + graphql_sources.len() > 0 {
            return Err(message_error(
                ErrorKind::DriverCannotMixJSONWithOtherSamples,
                vec![("dir", dir.as_str().into())],
            ));
        }

        if !schema_sources.is_empty() && !graphql_sources.is_empty() {
            return Err(message_error(
                ErrorKind::DriverCannotMixNonJSONInputs,
                vec![("dir", dir.as_str().into())],
            ));
        }

        if !json_samples.is_empty() {
            sources.push(TypeSource::Json(JsonTypeSource {
                name: js::basename(&dir).to_owned(),
                samples: json_samples,
                description: None,
            }));
        }

        sources.extend(schema_sources);
        sources.extend(graphql_sources);
    }

    Ok(sources)
}

/// `getSourceURIs(options)`: the `[name, uris]` pairs of `--src-urls`, or
/// standard input for the top-level if there are no sources at all.
async fn get_source_uris(options: &CliOptions) -> Result<Vec<(String, Vec<String>)>, CliError> {
    let http_headers = options.http_header.as_deref().unwrap_or_default();
    if let Some(src_urls) = &options.src_urls {
        let json = parse_json(
            &node_fs::read_from_file_or_url(src_urls, http_headers).await?,
            "URL grammar",
            Some(src_urls),
        )?;
        return Ok(urls_from_url_grammar(&json)?.into_iter().collect());
    }
    if options.src.is_empty() {
        return Ok(vec![(options.top_level.clone(), vec!["-".to_owned()])]);
    }
    Ok(Vec::new())
}

/// `typeSourcesForURIs(name, uris, options)`: one JSON source with all
/// `uris` as samples, or one schema source per URI.
async fn type_sources_for_uris(
    name: &str,
    uris: &[String],
    options: &CliOptions,
) -> Result<Vec<TypeSource>, CliError> {
    match options.src_lang.as_str() {
        "json" => Ok(vec![TypeSource::Json(
            source_from_file_or_url_array(
                name,
                uris,
                options.http_header.as_deref().unwrap_or_default(),
                options.json_lines,
            )
            .await?,
        )]),
        "schema" => Ok(uris
            .iter()
            .map(|uri| {
                TypeSource::Schema(JsonSchemaSourceData {
                    name: name.to_owned(),
                    uris: Some(vec![uri.clone()]),
                    schema: None,
                    is_converted: false,
                })
            })
            .collect()),
        other => Err(QuickTypeError::internal(format!(
            "typeSourceForURIs must not be called for source language {other}"
        ))
        .into()),
    }
}

/// `getSources(options)`: the sources of a JSON or JSON Schema run: the
/// `--src-urls` (or standard input), then every directory, then all other
/// sources as one top-level.
pub async fn get_sources(options: &CliOptions) -> Result<Vec<TypeSource>, CliError> {
    let http_headers = options.http_header.as_deref().unwrap_or_default();
    let mut sources = Vec::new();
    for (name, uris) in get_source_uris(options).await? {
        sources.extend(type_sources_for_uris(&name, &uris, options).await?);
    }

    let mut directories: Vec<&String> = Vec::new();
    for src in &options.src {
        if node_fs::exists_sync(src) && node_fs::is_directory(src)? {
            directories.push(src);
        }
    }

    for data_dir in &directories {
        sources.extend(samples_from_directory(data_dir, http_headers, options.json_lines).await?);
    }

    // Every source that is not a directory is a file or URL.
    let files_or_urls: Vec<String> = options
        .src
        .iter()
        .filter(|x| !directories.contains(x))
        .cloned()
        .collect();
    if !files_or_urls.is_empty() {
        sources.extend(type_sources_for_uris(&options.top_level, &files_or_urls, options).await?);
    }

    Ok(sources)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn type_names_from_file_names() {
        assert_eq!(type_name_from_filename("dir/Foo.bar.json"), "Foo.bar");
        assert_eq!(type_name_from_filename("dir/Foo"), "");
        assert_eq!(type_name_from_filename(".json"), "");
        assert_eq!(type_name_from_filename("dir/cards.jsonl"), "cards");
    }

    #[test]
    fn json_lines_names() {
        for name in [
            "a.jsonl",
            "dir/a.b.ndjson",
            "A.JSONL",
            ".jsonl",
            "https://example.com/cards.jsonl",
            "https://example.com/cards.ndjson?page=2&format=json",
            "http://localhost:8080/x.jsonl#top",
        ] {
            assert!(is_json_lines_name(name), "{name}");
        }
        for name in [
            "a.json",
            "a.jsonl.json",
            "jsonl",
            "-",
            "https://example.com/cards.json?format=jsonl",
            "https://example.com/cards#.jsonl",
            "a.jsonl?",
        ] {
            assert!(!is_json_lines_name(name), "{name}");
        }
    }
}
