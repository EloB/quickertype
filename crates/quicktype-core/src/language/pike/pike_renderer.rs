//! Port of `packages/quicktype-core/src/language/Pike/PikeRenderer.ts`.
//!
//! Renders Pike classes with `encode_json` methods and `<Type>_from_JSON`
//! decoding functions, enums, and `typedef`s for unions and top-levels.

use quicktype_js_compat::number;

use crate::attributes::constraints::{
    MinMaxConstraint, min_max_items_for_type, min_max_length_for_type, min_max_value_for_type,
    pattern_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::source::{MultiWord, multi_word, paren_if_needed, single_word};
use crate::support::comments::CommentOptions;
use crate::support::recursion::guard;
use crate::support::strings::string_escape;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, is_nullable, nullable_from_union, remove_null_from_union,
};

use super::constants::KEYWORDS;
use super::utils::{enum_naming_function, named_type_naming_function, naming_function};

/// `PikeRenderer`.
pub struct PikeRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    /// `enumNamingFunction` (a module-level singleton in TypeScript).
    enum_naming_function: Namer,
    /// `namedTypeNamingFunction` (a module-level singleton in TypeScript).
    named_type_naming_function: Namer,
    /// `namingFunction` (a module-level singleton in TypeScript).
    naming_function: Namer,
}

impl std::fmt::Debug for PikeRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("PikeRenderer").finish_non_exhaustive()
    }
}

/// `${n}` of a JavaScript number.
fn js_number(n: f64) -> String {
    number::to_string(n)
}

/// The two bounds of an optional constraint (`constraint ?? []`).
fn bounds(constraint: Option<MinMaxConstraint>) -> (Option<f64>, Option<f64>) {
    constraint.map_or((None, None), |c| (c.0, c.1))
}

impl<'a> PikeRenderer<'a> {
    /// `new PikeRenderer(targetLanguage, renderContext)`.
    pub fn new(target_language: &'a dyn TargetLanguage, render_context: RenderContext<'a>) -> Self {
        PikeRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            enum_naming_function: enum_naming_function(),
            named_type_naming_function: named_type_naming_function(),
            naming_function: naming_function(),
        }
    }

    /// `sourceFor(t)`: the Pike type of `t`.
    fn source_for(&self, t: TypeRef) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            if matches!(
                ty.kind(),
                TypeKind::Class | TypeKind::Object | TypeKind::Enum
            ) {
                return Ok(single_word(vec![self.name_for_named_type(t)?.into()]));
            }

            Ok(match ty.kind() {
                TypeKind::Any | TypeKind::Null => single_word(vec!["mixed".into()]),
                TypeKind::Bool => single_word(vec!["bool".into()]),
                TypeKind::Integer => single_word(vec!["int".into()]),
                TypeKind::Double => single_word(vec!["float".into()]),
                TypeKind::String => single_word(vec!["string".into()]),
                TypeKind::Array => single_word(vec![sl![
                    "array(",
                    self.source_for(ty.items()?)?.source,
                    ")"
                ]]),
                TypeKind::Map => {
                    let value_source = self.source_for(ty.map_values()?)?.source;
                    single_word(vec![sl!["mapping(string:", value_source, ")"]])
                }
                TypeKind::Union => {
                    if nullable_from_union(graph, t)?.is_some() {
                        // `unionType.getChildren()`: the members sorted by kind.
                        let mut children = Vec::new();
                        for c in graph.children(t)? {
                            children.push(paren_if_needed(self.source_for(c)?));
                        }
                        return multi_word("|", children);
                    }
                    single_word(vec![self.name_for_named_type(t)?.into()])
                }
                TypeKind::Intersection => {
                    return crate::support::support::panic("Unknown type intersection");
                }
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `emitClassDefinition(c, className)`.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_block(sl!["class ", class_name], |r| {
            r.emit_class_members(c)?;
            r.ensure_blank_line();
            r.emit_encoding_function(c)
        })?;
        self.ensure_blank_line();
        self.emit_decoding_function(class_name, c)
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let mut checks: Vec<String> = Vec::new();
        let kind = self.type_graph().kind(e)?;
        self.emit_block(sl![kind.as_str(), " ", enum_name], |r| {
            let mut table: Vec<Vec<Source>> = Vec::new();
            r.for_each_enum_case(e, BlankLinePosition::None, |_, name, json_name, _| {
                let escaped = string_escape(json_name);
                checks.push(format!("json != \"{escaped}\""));
                table.push(vec![
                    sl![name, " = \"", escaped.clone(), "\", "],
                    sl!["// json: \"", escaped, "\""],
                ]);
                Ok(())
            })?;
            r.emit_table(table);
            Ok(())
        })?;
        self.ensure_blank_line();
        let check = format!(
            "if(!zero_type(json)&&{})error(\"enum\");",
            checks.join("&&")
        );
        self.emit_block(
            sl![enum_name, " ", enum_name, "_from_JSON(mixed json)"],
            |r| {
                r.emit_line(sl![check, "return json;"]);
                Ok(())
            },
        )
    }

    /// `emitUnion(u, unionName)`: nothing for `T | null`.
    fn emit_union(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let graph = self.type_graph();
        if nullable_from_union(graph, u)?.is_some() {
            return Ok(());
        }

        let description = self.description_for_type(u)?;
        self.emit_description(description)?;

        let (_, non_nulls) = remove_null_from_union(graph, u, NullRemovalSort::None)?;

        let mut types: Vec<Source> = Vec::new();
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, _name, t, _| {
                types.push(r.source_for(t)?.source);
                Ok(())
            },
        )?;

        let mut strings = Vec::with_capacity(types.len());
        for t in &types {
            strings.push(self.sourcelike_to_string(t)?);
        }
        self.emit_line(sl!["typedef ", strings.join("|"), " ", union_name, ";"]);
        self.ensure_blank_line();
        self.emit_block(
            sl![union_name, " ", union_name, "_from_JSON(mixed json)"],
            |r| {
                r.emit_line(sl!["return json;"]);
                Ok(())
            },
        )
    }

    /// `emitBlock(line, f)` with the default delimiters.
    fn emit_block(&mut self, line: Source, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_block_with(line, f, " {", "}")
    }

    /// `emitBlock(line, f, opening, closing)`.
    fn emit_block_with(
        &mut self,
        line: Source,
        f: impl FnOnce(&mut Self) -> Result<()>,
        opening: &str,
        closing: &str,
    ) -> Result<()> {
        self.emit_line_parts(vec![line, opening.into()]);
        self.indent(f)?;
        self.emit_line(closing);
        Ok(())
    }

    /// `emitMappingBlock(line, f)`.
    fn emit_mapping_block(
        &mut self,
        line: Source,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_block_with(line, f, "([", "]);")
    }

    /// `emitClassMembers(c)`.
    fn emit_class_members(&mut self, c: TypeRef) -> Result<()> {
        let mut table: Vec<Vec<Source>> = Vec::new();
        self.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
            let pike_type = r.source_for(p.type_ref)?.source;
            table.push(vec![
                sl![pike_type, " "],
                sl![name, "; "],
                sl!["// json: \"", string_escape(json_name), "\""],
            ]);
            Ok(())
        })?;
        self.emit_table(table);
        Ok(())
    }

    /// `emitInformationComment()`.
    fn emit_information_comment(&mut self) -> Result<()> {
        let lines: Vec<Source> = [
            "This source has been automatically generated by quicktype.",
            "( https://github.com/quicktype/quicktype )",
            "",
            "To use this code, simply import it into your project as a Pike module.",
            "To JSON-encode your object, you can pass it to `Standards.JSON.encode`",
            "or call `encode_json` on it.",
            "",
            "To decode a JSON string, first pass it to `Standards.JSON.decode`,",
            "and then pass the result to `<YourClass>_from_JSON`.",
            "It will return an instance of <YourClass>.",
            "Bear in mind that these functions have unexpected behavior,",
            "and will likely throw an error, if the JSON string does not",
            "match the expected interface, even if the JSON itself is valid.",
        ]
        .into_iter()
        .map(Source::from)
        .collect();
        self.emit_comment_lines(
            &lines,
            &CommentOptions {
                line_start: Some("// ".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    /// `emitTopLevelTypedef(t, name)`.
    fn emit_top_level_typedef(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let source = self.source_for(t)?.source;
        self.emit_line_parts(vec![
            "typedef ".into(),
            source,
            " ".into(),
            name.into(),
            ";".into(),
        ]);
        Ok(())
    }

    /// `emitTopLevelConverter(t, name)`.
    fn emit_top_level_converter(&mut self, t: TypeRef, name: Name) -> Result<()> {
        self.emit_block(sl![name, " ", name, "_from_JSON(mixed json)"], |r| {
            let graph = r.type_graph();
            let ty = graph.type_at(t)?;
            if ty.is_primitive() {
                r.emit_line(sl!["return json;"]);
            } else if ty.is_array() {
                let items = ty.items()?;
                let items_ty = graph.type_at(items)?;
                if items_ty.kind() == TypeKind::Integer {
                    r.emit_multiline(
                        "return map(json, lambda(mixed value) {
    if (!intp(value)) error(\"Expected integer\");
    return (int)value;
});",
                    )?;
                } else if items_ty.is_primitive() {
                    r.emit_line(sl!["return json;"]);
                } else {
                    let items_source = r.source_for(items)?.source;
                    r.emit_line(sl!["return map(json, ", items_source, "_from_JSON);"]);
                }
            } else if ty.is_map() {
                let values = ty.map_values()?;
                let type_source = r.source_for(values)?.source;
                r.emit_line(sl![
                    "mapping(string:",
                    type_source.clone(),
                    ") retval = ([]);"
                ]);
                let assignment_rval = if graph.type_at(values)?.is_primitive() {
                    sl!["(", type_source, ") v"]
                } else {
                    sl![type_source, "_from_JSON(v)"]
                };
                r.emit_block(sl!["foreach (json; string k; mixed v)"], |r| {
                    r.emit_line(sl!["retval[k] = ", assignment_rval, ";"]);
                    Ok(())
                })?;
                r.emit_line(sl!["return retval;"]);
            }
            Ok(())
        })
    }

    /// `emitEncodingFunction(c)`.
    fn emit_encoding_function(&mut self, c: TypeRef) -> Result<()> {
        self.emit_block(sl!["string encode_json()"], |r| {
            r.emit_mapping_block(sl!["mapping(string:mixed) json = "], |r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, _, _| {
                    r.emit_line(sl!["\"", string_escape(json_name), "\" : ", name, ","]);
                    Ok(())
                })
            })?;
            r.ensure_blank_line();
            r.emit_line(sl!["return Standards.JSON.encode(json);"]);
            Ok(())
        })
    }

    /// `emitDecodingFunction(className, c)`.
    fn emit_decoding_function(&mut self, class_name: Name, c: TypeRef) -> Result<()> {
        self.emit_block(
            sl![class_name, " ", class_name, "_from_JSON(mixed json)"],
            |r| {
                r.emit_line(sl![class_name, " retval = ", class_name, "();"]);
                r.ensure_blank_line();
                r.for_each_class_property(
                    c,
                    BlankLinePosition::None,
                    |r, name, json_name, p, _| r.emit_property_decoder(name, json_name, p),
                )?;
                r.ensure_blank_line();
                r.emit_line(sl!["return retval;"]);
                Ok(())
            },
        )
    }

    /// The body of `emitDecodingFunction`'s per-property callback.
    fn emit_property_decoder(
        &mut self,
        name: Name,
        json_name: &str,
        p: ClassProperty,
    ) -> Result<()> {
        let graph = self.type_graph();
        let t = p.type_ref;
        let ty = graph.type_at(t)?;
        let escaped = string_escape(json_name);
        let json_value = format!("json[\"{escaped}\"]");
        let optional_guard = if p.is_optional {
            format!("has_index(json, \"{escaped}\") && ")
        } else {
            String::new()
        };

        let (min, max) = bounds(min_max_value_for_type(graph, t)?);
        if let Some(min) = min {
            self.emit_line(format!(
                "if ({optional_guard}{json_value} < {}) error(\"Value below minimum\");",
                js_number(min)
            ));
        }
        if let Some(max) = max {
            self.emit_line(format!(
                "if ({optional_guard}{json_value} > {}) error(\"Value above maximum\");",
                js_number(max)
            ));
        }
        let (min_length, max_length) = bounds(min_max_length_for_type(graph, t)?);
        if let Some(min_length) = min_length {
            self.emit_line(format!(
                "if ({optional_guard}sizeof({json_value}) < {}) error(\"String too short\");",
                js_number(min_length)
            ));
        }
        if let Some(max_length) = max_length {
            self.emit_line(format!(
                "if ({optional_guard}sizeof({json_value}) > {}) error(\"String too long\");",
                js_number(max_length)
            ));
        }
        let (min_items, max_items) = bounds(min_max_items_for_type(graph, t)?);
        if let Some(min_items) = min_items {
            self.emit_line(format!(
                "if ({optional_guard}sizeof({json_value}) < {}) error(\"Array too short\");",
                js_number(min_items)
            ));
        }
        if let Some(max_items) = max_items {
            self.emit_line(format!(
                "if ({optional_guard}sizeof({json_value}) > {}) error(\"Array too long\");",
                js_number(max_items)
            ));
        }
        if let Some(pattern) = pattern_for_type(graph, t)? {
            self.emit_line(format!(
                "if ({optional_guard}!Regexp(string_to_utf8(\"{}\"))->match(string_to_utf8({json_value}))) error(\"String does not match pattern\");",
                string_escape(&pattern)
            ));
        }

        // `p.type instanceof UnionType ? nullableFromUnion(p.type) : p.type`
        let required_type = if ty.is_union() {
            nullable_from_union(graph, t)?
        } else {
            Some(t)
        };
        let required_kind = match required_type {
            Some(r) => Some(graph.kind(r)?),
            None => None,
        };
        if !p.is_optional && ty.kind() == TypeKind::Class {
            self.emit_line(format!(
                "if (!mappingp({json_value})) error(\"Expected object\");"
            ));
        }
        if !p.is_optional && required_kind == Some(TypeKind::Integer) {
            self.emit_line(format!(
                "if (!intp({json_value})) error(\"Expected integer\");"
            ));
        }
        let rejects_array = ty.is_union()
            && nullable_from_union(graph, t)?.is_none()
            && !ty
                .members()?
                .iter()
                .map(|&m| Ok(graph.type_at(m)?.is_array()))
                .collect::<Result<Vec<bool>>>()?
                .contains(&true);
        if rejects_array {
            self.emit_line(format!(
                "if (arrayp(json[\"{escaped}\"])) error(\"Unexpected array\");"
            ));
        }
        if !p.is_optional && ty.is_map() && graph.kind(ty.map_values()?)? == TypeKind::Integer {
            self.emit_line(format!(
                "foreach (json[\"{escaped}\"]; mixed _; mixed value) if (!intp(value)) error(\"Expected integer\");"
            ));
        }
        if !p.is_optional && ty.kind() == TypeKind::Bool {
            self.emit_line(format!(
                "if (json[\"{escaped}\"] != Standards.JSON.true && json[\"{escaped}\"] != Standards.JSON.false) error(\"Expected bool\");"
            ));
        }
        // `mapType` is computed like `requiredType`.
        let rejects_string_map = match required_type {
            Some(map_type) if graph.type_at(map_type)?.is_map() => {
                let values = graph.type_at(map_type)?.map_values()?;
                let values_ty = graph.type_at(values)?;
                values_ty.is_union()
                    && !values_ty
                        .members()?
                        .iter()
                        .map(|&m| graph.kind(m))
                        .collect::<Result<Vec<TypeKind>>>()?
                        .contains(&TypeKind::String)
            }
            _ => false,
        };
        if rejects_string_map {
            self.emit_line(format!(
                "foreach (json[\"{escaped}\"]; mixed _; mixed value) if (stringp(value)) error(\"Unexpected string\");"
            ));
        }
        if !p.is_optional
            && ty.kind() == TypeKind::Union
            && nullable_from_union(graph, t)?.is_some()
        {
            self.emit_line_parts(vec![
                "if (!has_index(json, \"".into(),
                escaped.clone().into(),
                "\")) error(\"Missing required property\");".into(),
            ]);
        }

        // `enumType` is computed like `requiredType`.
        let enum_type = match required_type {
            Some(e) if graph.type_at(e)?.is_enum() => Some(e),
            _ => None,
        };
        let null_check: Source = if enum_type.is_some() && is_nullable(graph, t)? {
            format!("{json_value} == Standards.JSON.null ? {json_value} : ").into()
        } else {
            "".into()
        };
        let accessor = match enum_type {
            Some(e) => sl![self.name_for_named_type(e)?, "_from_JSON(json[\""],
            None => sl![
                if ty.kind() == TypeKind::Double {
                    "(float)"
                } else {
                    ""
                },
                "json[\""
            ],
        };
        let close = if enum_type.is_some() { "\"])" } else { "\"]" };
        self.emit_line(sl![
            "retval.", name, " = ", null_check, accessor, escaped, close, ";"
        ]);
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for PikeRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn enum_cases_in_global_namespace(&self) -> bool {
        true
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.enum_naming_function.clone())
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.named_type_naming_function.clone()
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.naming_function.clone())
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.naming_function.clone()))
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        let mut names: Vec<String> = KEYWORDS.iter().map(|&k| k.to_owned()).collect();
        names.push("Standards".to_owned());
        Ok(names)
    }

    fn forbidden_for_object_properties(
        &mut self,
        _c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn forbidden_for_enum_cases(
        &mut self,
        _e: TypeRef,
        _enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn forbidden_for_union_members(
        &mut self,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        self.emit_information_comment()?;
        self.ensure_blank_line();
        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, name, _| {
                r.emit_top_level_typedef(t, name)?;
                r.ensure_blank_line();
                r.emit_top_level_converter(t, name)?;
                r.ensure_blank_line();
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, name, _| r.emit_class_definition(c, name),
            |r, e, name, _| r.emit_enum(e, name),
            |r, u, name, _| r.emit_union(u, name),
        )
    }
}
