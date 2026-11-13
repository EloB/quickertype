//! Port of `packages/quicktype-typescript-input/src/index.ts`.
//!
//! TypeScript type definitions as a quicktype input: the sources are
//! type-checked by the TypeScript 7 native compiler (`tsc --api`, driven by
//! [`tsc`]) and turned into a JSON Schema by a port of the
//! typescript-json-schema subset quicktype uses ([`tjs`]). The result is the
//! same `JSONSchemaSourceData` the reference produces with TypeScript 5.9 and
//! typescript-json-schema 0.67.4, schema string included byte for byte, so it
//! enters the ordinary JSON Schema input.
//!
//! No Node.js is involved. The compiler binary is found by
//! [`tsc::locate::locate`]; without it, [`Error::TscNotFound`] is this port's
//! one deliberate divergence from the reference. See
//! `docs/research/07-typescript-input.md` for the design and the parity
//! measurements.

pub mod error;
pub mod js;
pub mod tjs;
pub mod tsc;

use std::path::{Path, PathBuf};

pub use error::{Error, Result};
use js::{Obj, Value};
use tsc::api::{Diagnostic, Session};
use tsc::ast::Node;
use tsc::generated::{diagnostic_category, syntax_kind as sk};

/// quicktype's `JSONSchemaSourceData` for a TypeScript input.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct JsonSchemaSourceData {
    /// The schema, as `JSON.stringify` writes it.
    pub schema: String,
    /// The top-level name (`""` when none was found).
    pub name: String,
    /// The schema URIs of the top-level types.
    pub uris: Vec<String>,
    /// Always `true`: the schema was converted from another language.
    pub is_converted: bool,
}

/// The result of [`schema_for_typescript_sources`].
#[derive(Clone, Debug)]
pub struct Output {
    /// The schema source.
    pub source: JsonSchemaSourceData,
    /// Lines typescript-json-schema writes to stderr (`console.warn`/`error`).
    pub warnings: Vec<String>,
}

/// `schemaForTypeScriptSources(sourceFileNames)`, with the process's working
/// directory as the root directory and the compiler found by
/// [`tsc::locate::locate`].
pub fn schema_for_typescript_sources(file_names: &[String]) -> Result<Output> {
    let cwd = std::env::current_dir()
        .map_err(|e| Error::Tsc(format!("cannot read the working directory: {e}")))?;
    let exe = tsc::locate::locate(&cwd)?;
    schema_for_typescript_sources_in(file_names, &cwd, &exe)
}

/// [`schema_for_typescript_sources`] with an explicit working directory and
/// compiler binary.
pub fn schema_for_typescript_sources_in(
    file_names: &[String],
    cwd: &Path,
    tsc_exe: &Path,
) -> Result<Output> {
    let case_sensitive = !cfg!(any(target_os = "macos", target_os = "windows"));
    let cwd = normalize(&cwd.to_string_lossy());
    if let Some(message) = root_file_errors(file_names, &cwd, case_sensitive) {
        return Err(Error::TypeScript { message });
    }
    let files: Vec<String> = file_names.iter().map(|f| absolute(f, &cwd)).collect();
    let config_path = format!(
        "{}/__quicktype_typescript_input__.json",
        cwd.trim_end_matches('/')
    );
    let config = serde_json::json!({
        "compilerOptions": {
            // quicktype's compilerOptions; TS 7 changed some defaults (`strict`),
            // so everything is explicit.
            "strict": false,
            "noEmit": true,
            "emitDecoratorMetadata": true,
            "experimentalDecorators": true,
            "target": "es2015",
            "lib": ["es2015", "dom", "webworker.importscripts", "scripthost"],
            "module": "commonjs",
            "strictNullChecks": true,
            "typeRoots": [],
            "rootDir": cwd,
        },
        "files": files,
    });
    let session = Session::open(
        tsc_exe,
        Path::new(&cwd),
        &config_path,
        vec![(config_path.clone(), config.to_string())],
    )?;
    run(&session, file_names, &files)
}

fn run(s: &Session, given: &[String], files: &[String]) -> Result<Output> {
    let mut diagnostics = s.pre_emit_diagnostics()?;
    sort_diagnostics(&mut diagnostics, s.case_sensitive());
    if let Some(error) = diagnostics
        .iter()
        .find(|d| d.category == diagnostic_category::Error)
    {
        return Err(Error::TypeScript {
            message: flatten(error),
        });
    }
    let mut warnings = Vec::new();
    if !diagnostics.is_empty() {
        // buildGenerator prints the diagnostics and gives up.
        for d in &diagnostics {
            warnings.push(match &d.file_name {
                Some(f) if d.pos >= 0 => {
                    let shown = files
                        .iter()
                        .position(|x| x == f)
                        .map_or(f.as_str(), |i| given[i].as_str());
                    let (line, col) = line_and_character(s, f, d.pos as usize)?;
                    format!("{shown} ({},{}): {}", line + 1, col + 1, flatten(d))
                }
                _ => flatten(d),
            });
        }
        return Err(Error::TypeScript {
            message: "Failed to build the JSON Schema generator".into(),
        });
    }

    let mut user_files = Vec::new();
    for name in s.source_file_names()? {
        let path = if s.case_sensitive() {
            name.clone()
        } else {
            name.to_lowercase()
        };
        if !s.is_default_library(&path)? {
            user_files.push(s.source_file(&name)?.root());
        }
    }
    let order = tjs::order::CreationOrder::compute(s, &user_files)?;
    let mut generator = tjs::Generator::build(s, &user_files, order)?;
    let schema = generator.schema_for_main_symbols()?;
    add_enum_accessor_names(&mut generator, s, &user_files, &schema)?;
    sanitize_type_annotations(&Value::Object(schema.clone()));
    let (name, uris) = post_process(&schema);
    warnings.append(&mut generator.warnings);
    Ok(Output {
        source: JsonSchemaSourceData {
            schema: js::stringify(&Value::Object(schema)),
            name,
            uris,
            is_converted: true,
        },
        warnings,
    })
}

/// `addEnumAccessorNames`: string enums keep their member names as
/// `qt-accessors`.
fn add_enum_accessor_names(
    g: &mut tjs::Generator<'_>,
    s: &Session,
    files: &[Node],
    schema: &Obj,
) -> Result<()> {
    let Some(definitions) = schema
        .borrow()
        .get("definitions")
        .and_then(|d| d.as_object().cloned())
    else {
        return Ok(());
    };
    fn visit(
        g: &mut tjs::Generator<'_>,
        s: &Session,
        node: &Node,
        definitions: &Obj,
    ) -> Result<()> {
        if node.kind() == sk::EnumDeclaration {
            let symbol = match node.named("name") {
                Some(n) => s.symbol_at(&n)?,
                None => None,
            };
            if let Some(symbol) = symbol {
                let mut in_lib = false;
                for d in &symbol.declarations {
                    in_lib |= s.is_default_library(&d.path)?;
                }
                if !in_lib {
                    let accessors = Value::object();
                    for member in node.named_list("members") {
                        let value = s.constant_value(&member)?;
                        let name = member.named("name");
                        let ok_name = name.as_ref().filter(|n| {
                            matches!(
                                n.kind(),
                                sk::Identifier | sk::StringLiteral | sk::NumericLiteral
                            )
                        });
                        match (value, ok_name) {
                            (Some(tsc::api::LiteralValue::String(v)), Some(n)) => {
                                accessors
                                    .borrow_mut()
                                    .define(&v, Value::String(n.text().unwrap_or_default()));
                            }
                            _ => return Ok(()),
                        }
                    }
                    let name = tjs::text::strip_file_names_and_spaces(&g.fqn(&symbol)?);
                    let definition = definitions.borrow().get(&name);
                    if let Some(Value::Object(d)) = definition {
                        d.borrow_mut().set("qt-accessors", Value::Object(accessors));
                    }
                }
            }
        }
        for c in node.children() {
            visit(g, s, &c, definitions)?;
        }
        Ok(())
    }
    for f in files {
        visit(g, s, f, &definitions)?;
    }
    Ok(())
}

/// `sanitizeTypeAnnotations`: `"{string}"` (from JSDoc `@type {string}`)
/// becomes `"string"`.
fn sanitize_type_annotations(value: &Value) {
    match value {
        Value::Array(a) => {
            let items = a.borrow().clone();
            items.iter().for_each(sanitize_type_annotations);
        }
        Value::Object(o) => {
            let t = o.borrow().get("type");
            if let Some(Value::String(t)) = t {
                if let Some(inner) = tjs::text::braced_type(&t) {
                    o.borrow_mut().set("type", Value::str(inner));
                }
            }
            let values: Vec<Value> = o.borrow().entries().into_iter().map(|(_, v)| v).collect();
            values.iter().for_each(sanitize_type_annotations);
        }
        _ => {}
    }
}

/// The `export default` swap, `quicktypePropertyOrder` and `#TopLevel`
/// handling at the end of `schemaForTypeScriptSources`.
fn post_process(schema: &Obj) -> (String, Vec<String>) {
    let mut uris = Vec::new();
    let mut top_level_name = String::new();
    let Some(Value::Object(definitions)) = schema.borrow().get("definitions") else {
        return (top_level_name, vec!["#/definitions/".into()]);
    };
    let default = definitions.borrow().get("default").filter(Value::truthy);
    if let Some(default_definition) = default {
        let matching = definitions
            .borrow()
            .entries()
            .into_iter()
            .find_map(|(name, d)| {
                let r = d.as_object().and_then(|o| o.borrow().get("$ref"));
                matches!(r, Some(Value::String(r)) if r == "#/definitions/default").then_some(name)
            });
        if let Some(name) = matching.filter(|n| !n.is_empty()) {
            top_level_name = name.clone();
            if let Some(o) = default_definition.as_object() {
                o.borrow_mut().set("title", Value::String(name.clone()));
            }
            definitions.borrow_mut().set(&name, default_definition);
            let r = Value::object();
            r.borrow_mut()
                .set("$ref", Value::String(format!("#/definitions/{name}")));
            definitions.borrow_mut().set("default", Value::Object(r));
        }
    }
    let names = definitions.borrow().keys();
    for name in names {
        let Some(Value::Object(d)) = definitions.borrow().get(&name) else {
            continue;
        };
        let order = d.borrow().get("propertyOrder");
        if let Some(order @ Value::Array(_)) = order {
            d.borrow_mut().set("quicktypePropertyOrder", order);
        }
        let description = d.borrow().get("description");
        let Some(Value::String(description)) = description else {
            continue;
        };
        let Some(index) = description.find("#TopLevel") else {
            continue;
        };
        let stripped = format!(
            "{}{}",
            &description[..index],
            &description[index + "#TopLevel".len()..]
        );
        d.borrow_mut().set("description", Value::String(stripped));
        uris.push(format!("#/definitions/{name}"));
        if top_level_name.is_empty() {
            let title = d.borrow().get("title");
            top_level_name = match title {
                Some(Value::String(t)) => t,
                _ => name.clone(),
            };
        }
    }
    if uris.is_empty() {
        uris.push("#/definitions/".into());
    }
    (top_level_name, uris)
}

// ---- diagnostics ---------------------------------------------------------------------

/// `flattenDiagnosticMessageText(diagnostic.messageText, "\n")`.
fn flatten(d: &Diagnostic) -> String {
    fn chain(out: &mut String, items: &[Diagnostic], indent: usize) {
        for item in items {
            out.push('\n');
            out.push_str(&"  ".repeat(indent));
            out.push_str(&item.text);
            chain(out, &item.message_chain, indent + 1);
        }
    }
    let mut out = d.text.clone();
    chain(&mut out, &d.message_chain, 1);
    out
}

/// `sortAndDeduplicateDiagnostics` order (`compareDiagnostics`): file path,
/// start, length, code, message.
fn sort_diagnostics(diagnostics: &mut [Diagnostic], case_sensitive: bool) {
    let path = |d: &Diagnostic| {
        d.file_name.as_ref().map(|f| {
            if case_sensitive {
                f.clone()
            } else {
                f.to_lowercase()
            }
        })
    };
    let start = |d: &Diagnostic| (d.pos >= 0).then_some(d.pos);
    diagnostics.sort_by(|a, b| {
        path(a)
            .cmp(&path(b))
            .then_with(|| start(a).cmp(&start(b)))
            .then_with(|| (a.end - a.pos).cmp(&(b.end - b.pos)))
            .then_with(|| a.code.cmp(&b.code))
            .then_with(|| js::compare_utf16(&flatten(a), &flatten(b)))
    });
}

fn line_and_character(s: &Session, file: &str, pos: usize) -> Result<(usize, usize)> {
    let sf = s.source_file(file)?;
    let text = sf.text16();
    let mut line = 0;
    let mut line_start = 0;
    let mut i = 0;
    while i < pos.min(text.len()) {
        let c = text[i];
        if c == 0x0d && text.get(i + 1) == Some(&0x0a) {
            i += 1;
        }
        if matches!(c, 0x0a | 0x0d | 0x2028 | 0x2029) {
            line += 1;
            line_start = i + 1;
        }
        i += 1;
    }
    Ok((line, pos.saturating_sub(line_start)))
}

// ---- root files ----------------------------------------------------------------------

/// TypeScript's `normalizePath`: forward slashes, `.` and `name/..` removed.
fn normalize(path: &str) -> String {
    let path = path.replace('\\', "/");
    let absolute = path.starts_with('/');
    let mut parts: Vec<&str> = Vec::new();
    for seg in path.split('/') {
        match seg {
            "" | "." => {}
            ".." if parts.last().is_some_and(|p| *p != "..") => {
                parts.pop();
            }
            ".." if absolute => {}
            seg => parts.push(seg),
        }
    }
    let joined = parts.join("/");
    if absolute {
        format!("/{joined}")
    } else {
        joined
    }
}

fn absolute(file: &str, cwd: &str) -> String {
    if Path::new(file).is_absolute() {
        normalize(file)
    } else {
        normalize(&format!("{cwd}/{file}"))
    }
}

fn contains_path(root: &str, file: &str, case_sensitive: bool) -> bool {
    let (root, file) = if case_sensitive {
        (root.to_owned(), file.to_owned())
    } else {
        (root.to_lowercase(), file.to_lowercase())
    };
    let root = root.trim_end_matches('/');
    file.strip_prefix(root)
        .is_some_and(|rest| rest.starts_with('/'))
}

/// The diagnostics TypeScript reports for root files before checking: a
/// missing file (TS6053) or one outside `rootDir` (TS6059). They are
/// synthesized here with TypeScript 5.9's texts, which print the names as
/// given rather than TS 7's absolute paths.
fn root_file_errors(file_names: &[String], cwd: &str, case_sensitive: bool) -> Option<String> {
    const CHAIN: &str =
        "\n  The file is in the program because:\n    Root file specified for compilation";
    let mut errors: Vec<(u32, String)> = Vec::new();
    for name in file_names {
        let shown = normalize(name);
        let abs = absolute(name, cwd);
        if !PathBuf::from(&abs).is_file() {
            errors.push((6053, format!("File '{shown}' not found.{CHAIN}")));
        } else if !name.ends_with(".d.ts") && !contains_path(cwd, &abs, case_sensitive) {
            errors.push((
                6059,
                format!("File '{shown}' is not under 'rootDir' '.'. 'rootDir' is expected to contain all source files.{CHAIN}"),
            ));
        }
    }
    errors.sort_by(|a, b| a.0.cmp(&b.0).then_with(|| js::compare_utf16(&a.1, &b.1)));
    errors.into_iter().next().map(|(_, m)| m)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn normalizes_like_typescript() {
        assert_eq!(normalize("./x/../../out.ts"), "../out.ts");
        assert_eq!(normalize("/a/b/../c.ts"), "/a/c.ts");
        assert_eq!(normalize("a\\b.ts"), "a/b.ts");
        assert_eq!(normalize("../../x.ts"), "../../x.ts");
    }

    #[test]
    fn containment() {
        assert!(contains_path("/a/b", "/a/b/c.ts", true));
        assert!(!contains_path("/a/b", "/a/bc.ts", true));
        assert!(contains_path("/A/b", "/a/B/c.ts", false));
    }

    #[test]
    fn flattens_message_chains() {
        let d: Diagnostic = serde_json::from_value(serde_json::json!({
            "text": "a", "category": 1,
            "messageChain": [{ "text": "b", "messageChain": [{ "text": "c" }] }, { "text": "d" }]
        }))
        .unwrap();
        assert_eq!(flatten(&d), "a\n  b\n    c\n  d");
    }
}
