//! Port of `packages/quicktype-core/src/language/JavaScript/JavaScriptRenderer.ts`.
//!
//! Renders plain JavaScript converters with runtime type checks, and is the
//! base of the TypeScript and Flow renderers.
//!
//! The TS class hierarchy `JavaScriptRenderer` → `TypeScriptFlowBaseRenderer`
//! → `TypeScriptRenderer`/`FlowRenderer` is ported as described in
//! `docs/RENDERERS.md`: the class's own methods are the
//! [`JavaScriptRenderer`] family trait (with the default bodies in
//! [`javascript_methods`], so subclasses can call them as `super`), its hook
//! overrides are [`javascript_hooks`], and [`PlainJavaScriptRenderer`] is the
//! renderer of `--lang javascript`.

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::renderer_options::RendererOptions;
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::converters::ConvertersOptions;
use crate::support::strings::{
    WordStyle, all_lower_word_style, camel_case, capitalize, combine_words, first_upper_word_style,
    split_into_words, utf16_string_escape,
};
use crate::support::support::defined;
use crate::target_language::TargetLanguage;

use super::language::{
    ACRONYM_STYLE, CONVERTERS, RAW_TYPE, RUNTIME_TYPECHECK,
    RUNTIME_TYPECHECK_IGNORE_UNKNOWN_PROPERTIES, RawType,
};
use super::unicode_maps::is_es3_identifier_start;
use super::utils::legalize_name;

/// The option values of the JavaScript renderer (TS
/// `OptionValues<typeof javaScriptOptions>`), shared by the TypeScript and
/// Flow renderers.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct JavaScriptOptions {
    /// `acronymStyle`.
    pub acronym_style: AcronymStyleOptions,
    /// `runtimeTypecheck`.
    pub runtime_typecheck: bool,
    /// `runtimeTypecheckIgnoreUnknownProperties`.
    pub runtime_typecheck_ignore_unknown_properties: bool,
    /// `converters`.
    pub converters: ConvertersOptions,
    /// `rawType`.
    pub raw_type: RawType,
}

impl JavaScriptOptions {
    /// `getOptionValues(javaScriptOptions, values)`: the options in
    /// declaration order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let acronym_style = defined(AcronymStyleOptions::from_value(
            ACRONYM_STYLE.get_enum_value(values)?,
        ))?;
        let runtime_typecheck = RUNTIME_TYPECHECK.get_value(values);
        let runtime_typecheck_ignore_unknown_properties =
            RUNTIME_TYPECHECK_IGNORE_UNKNOWN_PROPERTIES.get_value(values);
        let converters = defined(ConvertersOptions::from_name(
            CONVERTERS.get_enum_value(values)?,
        ))?;
        let raw_type = match RAW_TYPE.get_enum_value(values)? {
            "any" => RawType::Any,
            _ => RawType::Json,
        };
        Ok(JavaScriptOptions {
            acronym_style,
            runtime_typecheck,
            runtime_typecheck_ignore_unknown_properties,
            converters,
            raw_type,
        })
    }
}

/// The fields of TS `JavaScriptRenderer`, owned by every renderer of the
/// family.
#[derive(Clone, Debug)]
pub struct JavaScriptState {
    /// `_jsOptions`.
    pub options: JavaScriptOptions,
    /// The module's `identityNamingFunction` (a singleton in TypeScript):
    /// the namer of every property.
    pub identity_naming_function: Namer,
}

impl JavaScriptState {
    /// The state of a new renderer with `options`.
    pub fn new(options: JavaScriptOptions) -> Self {
        JavaScriptState {
            options,
            identity_naming_function: fun_prefix_namer("properties", str::to_owned),
        }
    }
}

/// `JavaScriptTypeAnnotations`: the type annotations the runtime typecheck
/// helpers carry (all empty in JavaScript).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct JavaScriptTypeAnnotations {
    /// `any`.
    pub any: &'static str,
    /// `anyArray`.
    pub any_array: &'static str,
    /// `anyMap`.
    pub any_map: &'static str,
    /// `boolean`.
    pub boolean: &'static str,
    /// `never`.
    pub never: &'static str,
    /// `string`.
    pub string: &'static str,
    /// `stringArray`.
    pub string_array: &'static str,
}

/// `nameStyle(original, upper)`: a JavaScript identifier for `original`,
/// with acronyms in `acronym_style`.
pub fn name_style(
    acronym_style_option: AcronymStyleOptions,
    original: &str,
    upper: bool,
) -> String {
    let acronyms = acronym_style(acronym_style_option);
    let words = split_into_words(original);
    let first_acronym = move |s: &str| capitalize(&acronyms(s));
    let first_word_style: WordStyle<'_> = if upper {
        &first_upper_word_style
    } else {
        &all_lower_word_style
    };
    let first_word_acronym_style: WordStyle<'_> = if upper {
        &first_acronym
    } else {
        &all_lower_word_style
    };
    combine_words(
        &words,
        &legalize_name,
        first_word_style,
        &first_upper_word_style,
        first_word_acronym_style,
        &acronyms,
        "",
        &is_es3_identifier_start,
    )
}

/// The `${n}` of a constraint bound, or `"undefined"`.
pub(crate) fn bound_or_undefined(bound: Option<f64>) -> String {
    bound.map_or_else(
        || "undefined".to_owned(),
        quicktype_js_compat::number::to_string,
    )
}

/// `usageModuleName(givenOutputFilename)`: the file name without
/// directories and extension (`"file"` for stdout).
pub fn usage_module_name(given_output_filename: &str) -> String {
    if given_output_filename == "stdout" {
        return "file".to_owned();
    }
    // `.replace(/^.*[/\\]/, "")`: `.` stops at the first line terminator.
    let first_line_end = given_output_filename
        .find(['\n', '\r', '\u{2028}', '\u{2029}'])
        .unwrap_or(given_output_filename.len());
    let without_directories = match given_output_filename[..first_line_end].rfind(['/', '\\']) {
        Some(i) => &given_output_filename[i + 1..],
        None => given_output_filename,
    };
    // `.replace(/\.[^.]+$/, "")`
    match without_directories.rfind('.') {
        Some(i) if i + 1 < without_directories.len() => without_directories[..i].to_owned(),
        _ => without_directories.to_owned(),
    }
}

/// The methods of TS `JavaScriptRenderer` that are not
/// `ConvenienceRenderer` hooks; subclasses override them. Each default is
/// the function of the same name in [`javascript_methods`].
pub trait JavaScriptRenderer<'a>: ConvenienceRenderer<'a> {
    /// The fields of TS `JavaScriptRenderer`.
    fn js(&self) -> &JavaScriptState;

    /// `_jsOptions`.
    fn js_options(&self) -> &JavaScriptOptions {
        &self.js().options
    }

    /// `typeMapTypeFor(t)`: the runtime type map entry of `t`.
    fn type_map_type_for(&self, t: TypeRef) -> Result<Source> {
        javascript_methods::type_map_type_for(self, t)
    }

    /// `shouldEmitTypeMapEntry(t)`.
    fn should_emit_type_map_entry(&self, t: TypeRef) -> Result<bool> {
        let _ = t;
        Ok(true)
    }

    /// `deserializerFunctionName(name)`: `["to", name]`.
    fn deserializer_function_name(&self, name: Name) -> Source {
        sl!["to", name]
    }

    /// `deserializerFunctionLine(t, name)`.
    fn deserializer_function_line(&self, t: TypeRef, name: Name) -> Result<Source> {
        javascript_methods::deserializer_function_line(self, t, name)
    }

    /// `serializerFunctionName(name)`: `[camelCase(name), "ToJson"]`.
    fn serializer_function_name(&self, name: Name) -> Source {
        sl![modify_source(camel_case, name), "ToJson"]
    }

    /// `serializerFunctionLine(t, name)`.
    fn serializer_function_line(&self, t: TypeRef, name: Name) -> Result<Source> {
        javascript_methods::serializer_function_line(self, t, name)
    }

    /// `moduleLine`: the line opening the converter module, if any.
    fn module_line(&self) -> Option<&'static str> {
        None
    }

    /// `castFunctionLines`: the signatures of `cast` and `uncast`.
    fn cast_function_lines(&self) -> (&'static str, &'static str) {
        ("function cast(val, typ)", "function uncast(val, typ)")
    }

    /// `typeAnnotations`.
    fn type_annotations(&self) -> Result<JavaScriptTypeAnnotations> {
        Ok(JavaScriptTypeAnnotations {
            any: "",
            any_array: "",
            any_map: "",
            string: "",
            string_array: "",
            boolean: "",
            never: "",
        })
    }

    /// `uncheckedParsedJson(t, parsedJson)`: the expression a deserializer
    /// returns when runtime typechecks are disabled. Subclasses can wrap it
    /// in a cast to the target type if `parsedJson`'s type isn't assignable
    /// to it.
    fn unchecked_parsed_json(&self, t: TypeRef, parsed_json: Source) -> Result<Source> {
        let _ = t;
        Ok(parsed_json)
    }

    /// `emitConvertModuleBody()`.
    fn emit_convert_module_body(&mut self) -> Result<()> {
        javascript_methods::emit_convert_module_body(self)
    }

    /// `emitConvertModuleHelpers()`.
    fn emit_convert_module_helpers(&mut self) -> Result<()> {
        javascript_methods::emit_convert_module_helpers(self)
    }

    /// `emitConvertModule()`.
    fn emit_convert_module(&mut self) -> Result<()> {
        javascript_methods::emit_convert_module(self)
    }

    /// `emitTypes()`: nothing in JavaScript.
    fn emit_types(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitUsageImportComment(givenOutputFilename)`.
    fn emit_usage_import_comment(&mut self, given_output_filename: &str) -> Result<()> {
        javascript_methods::emit_usage_import_comment(self, given_output_filename)
    }

    /// `emitUsageComments(givenOutputFilename)`.
    fn emit_usage_comments(&mut self, given_output_filename: &str) -> Result<()> {
        javascript_methods::emit_usage_comments(self, given_output_filename)
    }

    /// `emitModuleExports()`.
    fn emit_module_exports(&mut self) -> Result<()> {
        javascript_methods::emit_module_exports(self)
    }
}

/// The bodies of TS `JavaScriptRenderer`'s methods: the defaults of
/// [`JavaScriptRenderer`] and what a subclass's `super.x(...)` calls. Calls
/// to overridable methods go through the trait, as `this.x(...)` does.
pub mod javascript_methods {
    use super::*;

    /// `typeMapTypeFor(t)`.
    pub fn type_map_type_for<'a, R: JavaScriptRenderer<'a>>(r: &R, t: TypeRef) -> Result<Source> {
        let graph = r.type_graph();
        let ty = graph.type_at(t)?;
        let kind = ty.kind();
        if matches!(kind, TypeKind::Class | TypeKind::Object | TypeKind::Enum) {
            return Ok(sl!["r(\"", r.name_for_named_type(t)?, "\")"]);
        }

        Ok(match kind {
            TypeKind::Any => "\"any\"".into(),
            TypeKind::Null => "null".into(),
            TypeKind::Bool => "true".into(),
            TypeKind::Integer => type_map_number(r, t, "i(0)")?,
            TypeKind::Double => type_map_number(r, t, "3.14")?,
            TypeKind::String => type_map_string(r, t)?,
            TypeKind::Array => {
                let (min, max) = match min_max_items_for_type(graph, t)? {
                    Some(m) => (m.0, m.1),
                    None => (None, None),
                };
                let suffix = if min.is_none() && max.is_none() {
                    ")".to_owned()
                } else {
                    format!(
                        ", {}, {})",
                        bound_or_undefined(min),
                        bound_or_undefined(max)
                    )
                };
                sl!["a(", r.type_map_type_for(ty.items()?)?, suffix]
            }
            TypeKind::Map => sl!["m(", r.type_map_type_for(ty.map_values()?)?, ")"],
            TypeKind::Union => {
                let mut parts: Vec<Source> = vec!["u(".into()];
                for (i, &member) in graph.children(t)?.iter().enumerate() {
                    if i > 0 {
                        parts.push(", ".into());
                    }
                    parts.push(r.type_map_type_for(member)?);
                }
                parts.push(")".into());
                Source::Sequence(parts)
            }
            TypeKind::DateTime => "Date".into(),
            TypeKind::Uuid => "{ uuid: \"\" }".into(),
            k if k.is_transformed_string_type_kind() => "\"\"".into(),
            kind => return type_not_supported(kind),
        })
    }

    /// `typeMapString(t)`.
    fn type_map_string<'a, R: JavaScriptRenderer<'a>>(r: &R, t: TypeRef) -> Result<Source> {
        let graph = r.type_graph();
        let pattern = pattern_for_type(graph, t)?;
        let ty = match pattern {
            None => "\"\"".to_owned(),
            Some(pattern) => format!("p({})", quicktype_js_compat::json::quote(&pattern)),
        };
        Ok(match min_max_length_for_type(graph, t)? {
            Some(m) if m.0.is_some() || m.1.is_some() => format!(
                "s({ty}, {}, {})",
                bound_or_undefined(m.0),
                bound_or_undefined(m.1)
            ),
            _ => ty,
        }
        .into())
    }

    /// `typeMapNumber(t, example)`.
    fn type_map_number<'a, R: JavaScriptRenderer<'a>>(
        r: &R,
        t: TypeRef,
        example: &str,
    ) -> Result<Source> {
        Ok(match min_max_value_for_type(r.type_graph(), t)? {
            Some(m) if m.0.is_some() || m.1.is_some() => format!(
                "n({example}, {}, {})",
                bound_or_undefined(m.0),
                bound_or_undefined(m.1)
            ),
            _ => example.to_owned(),
        }
        .into())
    }

    /// `typeMapTypeForProperty(p)`.
    fn type_map_type_for_property<'a, R: JavaScriptRenderer<'a>>(
        r: &R,
        p: &ClassProperty,
    ) -> Result<Source> {
        let type_map = r.type_map_type_for(p.type_ref)?;
        if !p.is_optional {
            return Ok(type_map);
        }
        Ok(sl!["u(undefined, ", type_map, ")"])
    }

    /// `emitBlock(source, end, emit)`.
    pub fn emit_block<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        source: Source,
        end: Source,
        emit: impl FnOnce(&mut R) -> Result<()>,
    ) -> Result<()> {
        r.emit_line(sl![source, "{"]);
        r.indent(emit)?;
        r.emit_line(sl!["}", end]);
        Ok(())
    }

    /// `emitTypeMap()`.
    fn emit_type_map<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Result<()> {
        let any_annotation = r.type_annotations()?.any;
        emit_block(
            r,
            format!("const typeMap{any_annotation} = ").into(),
            ";".into(),
            |r| {
                r.for_each_object(BlankLinePosition::None, |r, t, name, _| {
                    if !r.should_emit_type_map_entry(t)? {
                        return Ok(());
                    }

                    let additional = match r.type_graph().type_at(t)?.additional_properties()? {
                        Some(additional) => r.type_map_type_for(additional)?,
                        None => "false".into(),
                    };
                    r.emit_line(sl!["\"", name, "\": o(["]);
                    r.indent(|r| {
                        r.for_each_class_property(
                            t,
                            BlankLinePosition::None,
                            |r, prop_name, json_name, property, _| {
                                let typ = type_map_type_for_property(r, &property)?;
                                r.emit_line(sl![
                                    "{ json: \"",
                                    utf16_string_escape(json_name),
                                    "\", js: \"",
                                    modify_source(utf16_string_escape, prop_name),
                                    "\", typ: ",
                                    typ,
                                    " },"
                                ]);
                                Ok(())
                            },
                        )
                    })?;
                    r.emit_line(sl!["], ", additional, "),"]);
                    Ok(())
                })?;
                r.for_each_enum(BlankLinePosition::None, |r, e, name, _| {
                    r.emit_line(sl!["\"", name, "\": ["]);
                    r.indent(|r| {
                        r.for_each_enum_case(e, BlankLinePosition::None, |r, _, json_name, _| {
                            r.emit_line(format!("\"{}\",", utf16_string_escape(json_name)));
                            Ok(())
                        })
                    })?;
                    r.emit_line("],");
                    Ok(())
                })
            },
        )
    }

    /// `deserializerFunctionLine(t, name)`.
    pub fn deserializer_function_line<'a, R: JavaScriptRenderer<'a>>(
        r: &R,
        _t: TypeRef,
        name: Name,
    ) -> Result<Source> {
        Ok(sl![
            "function ",
            r.deserializer_function_name(name),
            "(json)"
        ])
    }

    /// `serializerFunctionLine(t, name)`.
    pub fn serializer_function_line<'a, R: JavaScriptRenderer<'a>>(
        r: &R,
        _t: TypeRef,
        name: Name,
    ) -> Result<Source> {
        Ok(sl![
            "function ",
            r.serializer_function_name(name),
            "(value)"
        ])
    }

    /// The converter pair of `emitConvertModuleBody`.
    fn emit_converter<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        name: Name,
    ) -> Result<()> {
        let options = *r.js_options();
        let type_map = r.type_map_type_for(t)?;
        let deserializer_line = r.deserializer_function_line(t, name)?;
        emit_block(r, sl![deserializer_line, " "], "".into(), |r| {
            let parsed_json = match options.raw_type {
                RawType::Json => "JSON.parse(json)",
                RawType::Any => "json",
            };
            if !options.runtime_typecheck {
                let unchecked = r.unchecked_parsed_json(t, parsed_json.into())?;
                r.emit_line(sl!["return ", unchecked, ";"]);
            } else {
                r.emit_line(sl![
                    "return cast(",
                    parsed_json,
                    ", ",
                    type_map.clone(),
                    ");"
                ]);
            }
            Ok(())
        })?;
        r.ensure_blank_line();

        let serializer_line = r.serializer_function_line(t, name)?;
        emit_block(r, sl![serializer_line, " "], "".into(), |r| {
            match (options.raw_type, options.runtime_typecheck) {
                (RawType::Json, false) => r.emit_line("return JSON.stringify(value);"),
                (RawType::Json, true) => r.emit_line(sl![
                    "return JSON.stringify(uncast(value, ",
                    type_map,
                    "), null, 2);"
                ]),
                (RawType::Any, false) => r.emit_line("return value;"),
                (RawType::Any, true) => r.emit_line(sl!["return uncast(value, ", type_map, ");"]),
            }
            Ok(())
        })
    }

    /// `emitConvertModuleBody()`.
    pub fn emit_convert_module_body<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Result<()> {
        match r.js_options().converters {
            ConvertersOptions::AllObjects => r
                .for_each_object(BlankLinePosition::Interposing, |r, t, name, _| {
                    emit_converter(r, t, name)
                }),
            ConvertersOptions::TopLevel => {
                r.for_each_top_level(BlankLinePosition::Interposing, |r, t, name, _| {
                    emit_converter(r, t, name)
                })?;
                Ok(())
            }
        }
    }

    /// `emitConvertModuleHelpers()`: the runtime typecheck helpers and the
    /// type map.
    pub fn emit_convert_module_helpers<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Result<()> {
        let options = *r.js_options();
        if !options.runtime_typecheck {
            return Ok(());
        }
        let annotations = r.type_annotations()?;
        let graph = r.type_graph();
        let mut has_uuid = false;
        let mut has_array_constraints = false;
        for t in graph.all_types_unordered() {
            has_uuid |= graph.kind(t)? == TypeKind::Uuid;
            has_array_constraints |= min_max_items_for_type(graph, t)?.is_some();
        }
        r.ensure_blank_line();
        let helpers = runtime_helpers(
            &annotations,
            has_uuid,
            has_array_constraints,
            options.runtime_typecheck_ignore_unknown_properties,
            r.cast_function_lines(),
        );
        r.emit_multiline(&helpers)?;
        emit_type_map(r)
    }

    /// `emitConvertModule()`.
    pub fn emit_convert_module<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Result<()> {
        let options = *r.js_options();
        r.ensure_blank_line();
        r.emit_multiline(&format!(
            "// Converts JSON {} to/from your types",
            match options.raw_type {
                RawType::Json => "strings",
                RawType::Any => "types",
            }
        ))?;
        if options.runtime_typecheck {
            r.emit_multiline(&format!(
                "// and asserts the results{} at runtime",
                match options.raw_type {
                    RawType::Json => " of JSON.parse",
                    RawType::Any => "",
                }
            ))?;
        }

        match r.module_line() {
            None => r.emit_convert_module_body(),
            Some(module_line) => emit_block(r, sl![module_line, " "], "".into(), |r| {
                r.emit_convert_module_body()
            }),
        }
    }

    /// `emitUsageImportComment(givenOutputFilename)`.
    pub fn emit_usage_import_comment<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        given_output_filename: &str,
    ) -> Result<()> {
        r.emit_line(sl![
            "//   const Convert = require(\"./",
            usage_module_name(given_output_filename),
            "\");"
        ]);
        Ok(())
    }

    /// `emitUsageComments(givenOutputFilename)`.
    pub fn emit_usage_comments<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        given_output_filename: &str,
    ) -> Result<()> {
        r.emit_multiline("// To parse this data:\n//")?;

        r.emit_usage_import_comment(given_output_filename)?;
        r.emit_line("//");
        r.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
            let camel_case_name = modify_source(camel_case, name);
            r.emit_line(sl![
                "//   const ",
                camel_case_name,
                " = Convert.to",
                name,
                "(json);"
            ]);
            Ok(())
        })?;
        if r.js_options().runtime_typecheck {
            r.emit_line("//");
            r.emit_line("// These functions will throw an error if the JSON doesn't");
            r.emit_line("// match the expected interface, even if the JSON is valid.");
        }
        Ok(())
    }

    /// `emitModuleExports()`.
    pub fn emit_module_exports<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Result<()> {
        r.ensure_blank_line();

        emit_block(r, "module.exports = ".into(), ";".into(), |r| {
            let exporter = |r: &mut R, _: TypeRef, name: Name, _: ForEachPosition| {
                let serializer = r.serializer_function_name(name);
                let deserializer = r.deserializer_function_name(name);
                r.emit_line(sl!["\"", serializer.clone(), "\": ", serializer, ","]);
                r.emit_line(sl!["\"", deserializer.clone(), "\": ", deserializer, ","]);
                Ok(())
            };

            match r.js_options().converters {
                ConvertersOptions::AllObjects => {
                    r.for_each_object(BlankLinePosition::None, exporter)
                }
                ConvertersOptions::TopLevel => {
                    r.for_each_top_level(BlankLinePosition::None, exporter)?;
                    Ok(())
                }
            }
        })
    }

    /// The runtime typecheck helpers: the template literal of
    /// `emitConvertModuleHelpers`, whose whitespace is load-bearing.
    fn runtime_helpers(
        a: &JavaScriptTypeAnnotations,
        has_uuid: bool,
        has_array_constraints: bool,
        ignore_unknown_properties: bool,
        cast_function_lines: (&str, &str),
    ) -> String {
        let array_bounds = if has_array_constraints {
            format!(", min{any} = undefined, max{any} = undefined", any = a.any)
        } else {
            String::new()
        };
        [
            r##"function invalidValue(typ"##,
            a.any,
            r##", val"##,
            a.any,
            r##", key"##,
            a.any,
            r##", parent"##,
            a.any,
            r##" = '')"##,
            a.never,
            r##" {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ"##,
            a.any,
            r##")"##,
            a.string,
            r##" {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
    if (typ.jsonToJS === undefined) {
        const map"##,
            a.any,
            r##" = {};
        typ.props.forEach((p"##,
            a.any,
            r##") => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
    if (typ.jsToJSON === undefined) {
        const map"##,
            a.any,
            r##" = {};
        typ.props.forEach((p"##,
            a.any,
            r##") => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val"##,
            a.any,
            r##", typ"##,
            a.any,
            r##", getProps"##,
            a.any,
            r##", key"##,
            a.any,
            r##" = '', parent"##,
            a.any,
            r##" = '')"##,
            a.any,
            r##" {
    function transformPrimitive(typ"##,
            a.string,
            r##", val"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs"##,
            a.any_array,
            r##", val"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases"##,
            a.string_array,
            r##", val"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ"##,
            a.any,
            r##", val"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);
"##,
            if has_array_constraints { r##"        if ((typ.min !== undefined && val.length < typ.min) || (typ.max !== undefined && val.length > typ.max)) return invalidValue(l("array"), val, key, parent);"## } else { "" },
            r##"
        return val.map(el => transform(el, typ"##,
            if has_array_constraints { ".arrayItems" } else { "" },
            r##", getProps));
    }

    function transformDate(val"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props"##,
            a.any_map,
            r##", additional"##,
            a.any,
            r##", val"##,
            a.any,
            r##")"##,
            a.any,
            r##" {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result"##,
            a.any,
            r##" = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = "##,
            if ignore_unknown_properties { "val[key]" } else { "transform(val[key], additional, getProps, key, ref)" },
            r##";
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref"##,
            a.any,
            r##" = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return "##,
            if has_uuid { r##"typ.hasOwnProperty("uuid")         ? typeof val === "string" && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(val) ? val : invalidValue(typ, val, key, parent)
            : "## } else { "" },
            r##"typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray("##,
            if has_array_constraints { "typ" } else { "typ.arrayItems" },
            r##", val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

"##,
            cast_function_lines.0,
            r##" {
    return transform(val, typ, jsonToJSProps);
}

"##,
            cast_function_lines.1,
            r##" {
    return transform(val, typ, jsToJSONProps);
}

function l(typ"##,
            a.any,
            r##") {
    return { literal: typ };
}

function a(typ"##,
            a.any,
            &array_bounds,
            r##") {
    return { arrayItems: typ"##,
            if has_array_constraints { ", min, max" } else { "" },
            r##" };
}

function i(typ"##,
            a.any,
            r##") {
    return { integer: typ };
}

function p(pattern"##,
            a.any,
            r##") {
    return { pattern };
}

function s(typ"##,
            a.any,
            r##", min"##,
            a.any,
            r##", max"##,
            a.any,
            r##") {
    return { string: typ, min, max };
}

function n(typ"##,
            a.any,
            r##", min"##,
            a.any,
            r##", max"##,
            a.any,
            r##") {
    return { number: typ, min, max };
}

function u(...typs"##,
            a.any_array,
            r##") {
    return { unionMembers: typs };
}

function o(props"##,
            a.any_array,
            r##", additional"##,
            a.any,
            r##") {
    return { props, additional };
}

function m(additional"##,
            a.any,
            r##") {
    const props"##,
            a.any_array,
            r##" = [];
    return { props, additional };
}

function r(name"##,
            a.string,
            r##") {
    return { ref: name };
}
"##,
        ]
        .concat()
    }
}

/// The `ConvenienceRenderer` hooks TS `JavaScriptRenderer` overrides; the
/// rest are the framework defaults (see `docs/RENDERERS.md`).
pub mod javascript_hooks {
    pub use crate::convenience_renderer::defaults::*;

    use super::*;
    use crate::support::comments::CommentOptions;
    use crate::ty::type_utils::directly_reachable_single_named_type;

    /// `makeNamedTypeNamer()`.
    pub fn make_named_type_namer<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Namer {
        let acronym_style = r.js_options().acronym_style;
        fun_prefix_namer("types", move |s| name_style(acronym_style, s, true))
    }

    /// `namerForObjectProperty()`: the module's `identityNamingFunction`.
    pub fn namer_for_object_property<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(r.js().identity_naming_function.clone()))
    }

    /// `makeUnionMemberNamer()`: none.
    pub fn make_union_member_namer<'a, R: JavaScriptRenderer<'a>>(_r: &mut R) -> Option<Namer> {
        None
    }

    /// `makeEnumCaseNamer()`.
    pub fn make_enum_case_namer<'a, R: JavaScriptRenderer<'a>>(r: &mut R) -> Option<Namer> {
        let acronym_style = r.js_options().acronym_style;
        Some(fun_prefix_namer("enum-cases", move |s| {
            name_style(acronym_style, s, true)
        }))
    }

    /// `namedTypeToNameForTopLevel(type)`: arrays never give their name
    /// away.
    pub fn named_type_to_name_for_top_level<'a, R: JavaScriptRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Option<TypeRef>> {
        let graph = r.type_graph();
        if graph.kind(t)? == TypeKind::Array {
            return Ok(None);
        }
        directly_reachable_single_named_type(graph, t)
    }

    /// `makeNameForProperty(...)`: ignores the assigned name.
    pub fn make_name_for_property<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        o: TypeRef,
        class_name: Name,
        p: &ClassProperty,
        json_name: &str,
        _assigned_name: Option<&str>,
    ) -> Result<Option<Name>> {
        crate::convenience_renderer::defaults::make_name_for_property(
            r, o, class_name, p, json_name, None,
        )
    }

    /// `emitDescriptionBlock(lines)`: a `/** ... */` block.
    pub fn emit_description_block<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        lines: &[Source],
    ) -> Result<()> {
        r.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some(" * ".to_owned()),
                before_comment: Some("/**".to_owned()),
                after_comment: Some(" */".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    /// `emitSourceStructure(givenOutputFilename)`.
    pub fn emit_source_structure<'a, R: JavaScriptRenderer<'a>>(
        r: &mut R,
        given_output_filename: &str,
    ) -> Result<()> {
        match r.leading_comments() {
            Some(leading_comments) => r.emit_comments(leading_comments)?,
            None => r.emit_usage_comments(given_output_filename)?,
        }

        r.emit_types()?;

        r.emit_convert_module()?;

        r.emit_convert_module_helpers()?;

        r.emit_module_exports()
    }
}

/// TS `new JavaScriptRenderer(...)`: the renderer of `--lang javascript`.
pub struct PlainJavaScriptRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    js: JavaScriptState,
}

impl std::fmt::Debug for PlainJavaScriptRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("PlainJavaScriptRenderer")
            .field("options", &self.js.options)
            .finish_non_exhaustive()
    }
}

impl<'a> PlainJavaScriptRenderer<'a> {
    /// `new JavaScriptRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: JavaScriptOptions,
    ) -> Self {
        PlainJavaScriptRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            js: JavaScriptState::new(options),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for PlainJavaScriptRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(javascript_hooks);
}

impl<'a> JavaScriptRenderer<'a> for PlainJavaScriptRenderer<'a> {
    fn js(&self) -> &JavaScriptState {
        &self.js
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn usage_module_names_strip_directories_and_extension() {
        assert_eq!(usage_module_name("stdout"), "file");
        assert_eq!(
            usage_module_name("src/cli/ExperimentCounts.ts"),
            "ExperimentCounts"
        );
        assert_eq!(usage_module_name("C:\\out\\dir.v2\\Counts"), "Counts");
        assert_eq!(usage_module_name("dir/file.tar.gz"), "file.tar");
        assert_eq!(usage_module_name("noext."), "noext.");
        assert_eq!(usage_module_name(".hidden"), "");
        assert_eq!(usage_module_name("out/"), "");
        // `.` in `/^.*[/\\]/` stops at the first line terminator.
        assert_eq!(usage_module_name("a/b\nc/d.ts"), "b\nc/d");
    }

    #[test]
    fn name_styles() {
        assert_eq!(
            name_style(AcronymStyleOptions::Pascal, "url value", true),
            "URLValue"
        );
        assert_eq!(
            name_style(AcronymStyleOptions::Camel, "url value", true),
            "UrlValue"
        );
        assert_eq!(
            name_style(AcronymStyleOptions::Pascal, "1st", false),
            "the1St"
        );
        assert_eq!(
            name_style(AcronymStyleOptions::Pascal, "my url", false),
            "myURL"
        );
    }
}
