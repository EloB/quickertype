//! Port of `packages/quicktype-core/src/language/Kotlin/KotlinKlaxonRenderer.ts`.
//!
//! `KotlinKlaxonRenderer`: data classes for the Klaxon JSON library, with
//! converters for enums, unions, empty objects and `java.time` types.

use indexmap::IndexSet;

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::collection_utils::array_intercalate;
use crate::support::strings::camel_case;
use crate::support::support::{must_not_happen, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::nullable_from_union;

use super::kotlin_renderer::{
    Delimiter, KotlinOptions, KotlinRenderer, KotlinState, Meta, base_emit_header, kotlin_hooks,
};
use super::utils::{js_number, string_escape, union_member_match_priority};

/// TS `KotlinKlaxonRenderer`.
pub struct KotlinKlaxonRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    kotlin: KotlinState,
}

impl std::fmt::Debug for KotlinKlaxonRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("KotlinKlaxonRenderer")
            .field("kotlin", &self.kotlin)
            .finish_non_exhaustive()
    }
}

impl<'a> KotlinKlaxonRenderer<'a> {
    /// `new KotlinKlaxonRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: KotlinOptions,
    ) -> Self {
        KotlinKlaxonRenderer {
            kotlin: KotlinState::new(options, render_context.type_graph),
            core: ConvenienceRendererCore::new(target_language, render_context),
        }
    }

    /// `unionMemberFromJsonValue(t, e)`: the expression that reads `t` from
    /// the `JsonValue` `e`.
    fn union_member_from_json_value(&self, t: TypeRef, e: &str) -> Result<Source> {
        let graph = self.type_graph();
        Ok(match graph.kind(t)? {
            TypeKind::Any => sl![e, ".inside"],
            TypeKind::Null => "null".into(),
            TypeKind::Bool => sl![e, ".boolean"],
            TypeKind::Integer => sl!["(", e, ".int?.toLong() ?: ", e, ".longValue)"],
            TypeKind::Double => sl![
                e,
                ".double ?: ",
                e,
                ".int?.toDouble() ?: ",
                e,
                ".longValue?.toDouble()"
            ],
            TypeKind::String => sl![e, ".string"],
            TypeKind::Array => sl![
                e,
                ".array?.let { klaxon.parseFromJsonArray<",
                self.kotlin_type(graph.type_at(t)?.items()?, false, false)?,
                ">(it) }"
            ],
            TypeKind::Class | TypeKind::Map => sl![
                e,
                ".obj?.let { klaxon.parseFromJsonObject<",
                self.kotlin_type(t, false, false)?,
                ">(it) }"
            ],
            TypeKind::Enum => sl![
                e,
                ".string?.let { ",
                self.kotlin_type(t, false, false)?,
                ".fromValue(it) }"
            ],
            TypeKind::Union => return must_not_happen(),
            TypeKind::DateTime => sl![e, ".string?.let { OffsetDateTime.parse(it) }"],
            TypeKind::Date => sl![e, ".string?.let { LocalDate.parse(it) }"],
            TypeKind::Time => sl![e, ".string?.let { OffsetTime.parse(it) }"],
            kind if kind.is_transformed_string_type_kind() => sl![e, ".string"],
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => return type_not_supported(kind),
        })
    }

    /// `unionMemberJsonValueGuard(t, u)`.
    fn union_member_json_value_guard(&self, t: TypeRef, u: TypeRef) -> Result<Source> {
        let graph = self.type_graph();
        Ok(match graph.kind(t)? {
            TypeKind::Any => "is Any".into(),
            TypeKind::Null => "null".into(),
            TypeKind::Bool => "is Boolean".into(),
            TypeKind::Integer => "is Int, is Long".into(),
            TypeKind::Double => {
                let mut has_integer = false;
                for &m in graph.type_at(u)?.members()? {
                    if graph.kind(m)? == TypeKind::Integer {
                        has_integer = true;
                    }
                }
                (if has_integer {
                    "is Double"
                } else {
                    "is Double, is Int, is Long"
                })
                .into()
            }
            TypeKind::String => "is String".into(),
            TypeKind::Array => "is JsonArray<*>".into(),
            // These could be stricter, but for now we don't allow maps
            // and objects in the same union
            TypeKind::Class | TypeKind::Map => "is JsonObject".into(),
            // This could be stricter, but for now we don't allow strings
            // and enums in the same union
            TypeKind::Enum => "is String".into(),
            TypeKind::Union => return must_not_happen(),
            kind if kind.is_transformed_string_type_kind() => "is String".into(),
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => return type_not_supported(kind),
        })
    }

    /// `isEmptyObjectType(t)`: empty object types render as a typealias
    /// for `JsonObject`.
    fn is_empty_object_type(&self, t: TypeRef) -> Result<bool> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        if ty.is_union() {
            return match nullable_from_union(graph, t)? {
                Some(nullable) => self.is_empty_object_type(nullable),
                None => Ok(false),
            };
        }

        Ok(ty.is_class() && ty.properties()?.is_empty())
    }

    /// `needsJsonObjectMapAnnotation(t)`: Klaxon's reflective deserializer
    /// never consults custom converters for map values, so a
    /// `Map<String, JsonObject>` property fails to parse
    /// (https://github.com/glideapps/quicktype/issues/2881). Properties
    /// holding such maps (directly or nested inside other maps) are
    /// annotated so that a field-level converter, which Klaxon does
    /// consult, handles them instead.
    fn needs_json_object_map_annotation(&self, t: TypeRef) -> Result<bool> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        if ty.is_union() {
            return match nullable_from_union(graph, t)? {
                Some(nullable) => self.needs_json_object_map_annotation(nullable),
                None => Ok(false),
            };
        }

        if !ty.is_map() {
            return Ok(false);
        }

        let values = ty.map_values()?;
        Ok(self.is_empty_object_type(values)? || self.needs_json_object_map_annotation(values)?)
    }

    /// `hasJsonObjectMaps()`.
    fn has_json_object_maps(&self) -> Result<bool> {
        let graph = self.type_graph();
        for t in graph.all_named_types()? {
            let ty = graph.type_at(t)?;
            if !ty.is_class() {
                continue;
            }
            for p in ty.properties()?.values() {
                if self.needs_json_object_map_annotation(p.type_ref)? {
                    return Ok(true);
                }
            }
        }
        Ok(false)
    }

    /// `klaxonRenameAttribute(propName, jsonName, ignore)`.
    fn klaxon_rename_attribute(
        &self,
        prop_name: Name,
        json_name: &str,
        ignore: bool,
    ) -> Result<Option<Source>> {
        let escaped_name = string_escape(json_name);
        let names_differ = self.sourcelike_to_string(&prop_name.into())? != escaped_name;
        let mut properties: Vec<Source> = Vec::new();
        if names_differ {
            properties.push(sl!["name = \"", escaped_name, "\""]);
        }

        if ignore {
            properties.push("ignored = true".into());
        }

        Ok(if properties.is_empty() {
            None
        } else {
            Some(sl![
                "@Json(",
                array_intercalate(", ".into(), properties),
                ")"
            ])
        })
    }

    /// `emitGenericConverter()`.
    fn emit_generic_converter(&mut self) -> Result<()> {
        let graph = self.type_graph();
        let mut has_nested_union_arrays = false;
        for t in graph.types() {
            if !t.is_array() {
                continue;
            }
            let items = graph.type_at(t.items()?)?;
            if items.is_array() && graph.type_at(items.items()?)?.is_union() {
                has_nested_union_arrays = true;
            }
        }
        self.ensure_blank_line();
        self.emit_line(
            "private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =",
        );
        self.indent(|r| {
            r.emit_line("this.converter(object: Converter {");
            r.indent(|r| {
                r.emit_line("@Suppress(\"UNCHECKED_CAST\")");
                r.emit_table(vec![
                    vec![
                        "override fun toJson(value: Any)".into(),
                        " = toJson(value as T)".into(),
                    ],
                    vec![
                        "override fun fromJson(jv: JsonValue)".into(),
                        (if has_nested_union_arrays {
                            " = if (isUnion && jv.inside is JsonArray<*>) (jv.inside as JsonArray<*>).map { fromJson(JsonValue(it, null, null, this@convert)) } else fromJson(jv) as Any"
                        } else {
                            " = fromJson(jv) as Any"
                        })
                        .into(),
                    ],
                    vec![
                        "override fun canConvert(cls: Class<*>)".into(),
                        " = cls == k.java || (isUnion && cls.superclass == k.java)".into(),
                    ],
                ]);
                Ok(())
            })?;
            r.emit_line("})");
            Ok(())
        })
    }

    /// `emitJsonObjectMapConverter()`.
    fn emit_json_object_map_converter(&mut self) -> Result<()> {
        self.ensure_blank_line();
        self.emit_line("// Klaxon cannot deserialize map values typed as JsonObject, so fields");
        self.emit_line("// holding such maps are converted at the field level instead.");
        self.emit_line("@Target(AnnotationTarget.FIELD)");
        self.emit_line("private annotation class KlaxonJsonObjectMap");
        self.ensure_blank_line();
        self.emit_line("private val jsonObjectMapConverter: Converter = object : Converter {");
        self.indent(|r| {
            r.emit_table(vec![
                vec![
                    "override fun canConvert(cls: Class<*>)".into(),
                    " = true".into(),
                ],
                vec![
                    "override fun fromJson(jv: JsonValue)".into(),
                    " = jv.obj!!".into(),
                ],
                vec![
                    "override fun toJson(value: Any)".into(),
                    " = klaxon.toJsonString(value)".into(),
                ],
            ]);
            Ok(())
        })?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitValidation(condition)` of `emitClassDefinitionMethods`: one
    /// `init` block per check.
    fn emit_validation(&mut self, condition: String) -> Result<()> {
        self.emit_block(
            "init".into(),
            |r| {
                r.emit_line(condition);
                Ok(())
            },
            Delimiter::Curly,
        )
    }
}

impl<'a> KotlinRenderer<'a> for KotlinKlaxonRenderer<'a> {
    fn kotlin(&self) -> &KotlinState {
        &self.kotlin
    }

    fn emit_usage_header(&mut self) -> Result<()> {
        self.emit_line("// To parse the JSON, install Klaxon and do:");
        self.emit_line("//");
        self.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
            r.emit_line(sl![
                "//   val ",
                modify_source(camel_case, name),
                " = ",
                name,
                ".fromJson(jsonString)"
            ]);
            Ok(())
        })?;
        Ok(())
    }

    fn emit_header(&mut self) -> Result<()> {
        base_emit_header(self)?;

        self.emit_line("import com.beust.klaxon.*");

        // TS computes these in both KotlinJacksonRenderer.emitHeader and
        // KotlinKlaxonRenderer.emitHeader (not in KotlinRenderer); the port
        // keeps both copies, each mirroring its TypeScript.
        let graph = self.type_graph();
        let mut has_unions = false;
        let mut has_empty_objects = false;
        for t in graph.all_named_types()? {
            let ty = graph.type_at(t)?;
            if ty.is_union() && nullable_from_union(graph, t)?.is_none() {
                has_unions = true;
            }
            if ty.is_class() && ty.properties()?.is_empty() {
                has_empty_objects = true;
            }
        }
        let uses_date_time = self.have_transformed_string_type(TypeKind::DateTime);
        let uses_date = self.have_transformed_string_type(TypeKind::Date);
        let uses_time = self.have_transformed_string_type(TypeKind::Time);
        if has_unions
            || self.have_enums()?
            || has_empty_objects
            || uses_date_time
            || uses_date
            || uses_time
        {
            self.emit_generic_converter()?;
        }

        let has_json_object_maps = self.has_json_object_maps()?;
        if has_json_object_maps {
            self.emit_json_object_map_converter()?;
        }

        let mut converters: Vec<Vec<Source>> = Vec::new();
        if uses_date_time {
            converters.push(vec![
                sl![".convert(OffsetDateTime::class,"],
                sl![" { OffsetDateTime.parse(it.string!!) },"],
                sl![
                    r#" { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })"#
                ],
            ]);
        }

        if uses_date {
            converters.push(vec![
                sl![".convert(LocalDate::class,"],
                sl![" { LocalDate.parse(it.string!!) },"],
                sl![
                    r#" { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })"#
                ],
            ]);
        }

        if uses_time {
            converters.push(vec![
                sl![".convert(OffsetTime::class,"],
                sl![" { OffsetTime.parse(it.string!!) },"],
                sl![
                    r#" { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_TIME.format(it)}\"" })"#
                ],
            ]);
        }

        if has_empty_objects {
            converters.push(vec![
                sl![".convert(JsonObject::class,"],
                sl![" { it.obj!! },"],
                sl![" { it.toJsonString() })"],
            ]);
        }

        self.for_each_enum(BlankLinePosition::None, |_, _, name, _| {
            converters.push(vec![
                sl![".convert(", name, "::class,"],
                sl![" { ", name, ".fromValue(it.string!!) },"],
                sl![" { Klaxon().toJsonString(it.value) })"],
            ]);
            Ok(())
        })?;
        self.for_each_union(BlankLinePosition::None, |_, _, name, _| {
            converters.push(vec![
                sl![".convert(", name, "::class,"],
                sl![" { ", name, ".fromJson(it) },"],
                sl![" { it.toJson() }, true)"],
            ]);
            Ok(())
        })?;

        self.ensure_blank_line();
        self.emit_line("private val klaxon = Klaxon()");
        if !converters.is_empty() {
            self.indent(|r| {
                r.emit_table(converters);
                Ok(())
            })?;
        }

        if has_json_object_maps {
            self.indent(|r| {
                r.emit_line(".fieldConverter(KlaxonJsonObjectMap::class, jsonObjectMapConverter)");
                Ok(())
            })?;
        }
        Ok(())
    }

    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let items = self.type_graph().type_at(t)?.items()?;
        let element_type = self.kotlin_type(items, false, false)?;
        let items_are_integers = self.type_graph().kind(items)? == TypeKind::Integer;
        let parse_type: Source = if items_are_integers {
            "Any".into()
        } else {
            element_type.clone()
        };
        let validate: Source = if items_are_integers {
            ".map { when (it) { is Int -> it.toLong(); is Long -> it; else -> throw IllegalArgumentException() } }".into()
        } else {
            sl![]
        };
        self.emit_block(
            sl![
                "class ",
                name,
                "(elements: Collection<",
                element_type.clone(),
                ">) : ArrayList<",
                element_type,
                ">(elements)"
            ],
            |r| {
                r.emit_line("public fun toJson() = klaxon.toJsonString(this)");
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_line(sl![
                            "public fun fromJson(json: String) = ",
                            name,
                            "(klaxon.parseArray<",
                            parse_type,
                            ">(json)!!",
                            validate,
                            ")"
                        ]);
                        Ok(())
                    },
                    Delimiter::Curly,
                )
            },
            Delimiter::Curly,
        )
    }

    fn emit_top_level_primitive(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let type_name = self.sourcelike_to_string(&name.into())?;
        let value_type = self.sourcelike_to_string(&self.kotlin_type(t, false, false)?)?;
        let parse = match self.type_graph().kind(t)? {
            TypeKind::Integer => "json.toLong()".to_owned(),
            TypeKind::Double => "json.toDouble()".to_owned(),
            _ => format!("klaxon.parseArray<{value_type}>(\"[${{json}}]\")!![0]"),
        };
        self.emit_multiline(&format!(
            "data class {type_name}(val value: {value_type}) {{
    public fun toJson() = klaxon.toJsonString(value)

    companion object {{
        public fun fromJson(json: String) = {type_name}({parse})
    }}
}}"
        ))
    }

    fn emit_top_level_map(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let values = self.type_graph().type_at(t)?.map_values()?;
        let element_type = self.kotlin_type(values, false, false)?;
        self.emit_block(
            sl![
                "class ",
                name,
                "(elements: Map<String, ",
                element_type.clone(),
                ">) : HashMap<String, ",
                element_type.clone(),
                ">(elements)"
            ],
            |r| {
                r.emit_line("public fun toJson() = klaxon.toJsonString(this)");
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_block(
                            sl!["public fun fromJson(json: String) = ", name],
                            |r| {
                                r.emit_line(sl![
                                    "klaxon.parseJsonObject(java.io.StringReader(json)) as Map<String, ",
                                    element_type,
                                    ">"
                                ]);
                                Ok(())
                            },
                            Delimiter::Paren,
                        )
                    },
                    Delimiter::Curly,
                )
            },
            Delimiter::Curly,
        )
    }

    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;

        self.emit_line(sl!["typealias ", class_name, " = JsonObject"]);
        Ok(())
    }

    fn emit_class_definition_methods(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        if !self.is_top_level(c) {
            self.emit_line(")");
            return Ok(());
        }
        self.emit_block(
            ")".into(),
            |r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, _| {
                    let graph = r.type_graph();
                    let t = p.type_ref;
                    let value = r.sourcelike_to_string(&name.into())?;
                    let close = if p.is_optional { ") }" } else { ")" };
                    let validate = |operator: &str, bound: f64| {
                        if p.is_optional {
                            format!(
                                "{value}?.let {{ require(it {operator} {}) }}",
                                js_number(bound)
                            )
                        } else {
                            format!("require({value} {operator} {})", js_number(bound))
                        }
                    };
                    if let Some(m) = min_max_value_for_type(graph, t)? {
                        if let Some(min) = m.0 {
                            r.emit_validation(validate(">=", min))?;
                        }
                        if let Some(max) = m.1 {
                            r.emit_validation(validate("<=", max))?;
                        }
                    }
                    let length = if p.is_optional {
                        format!("{value}?.let {{ require(it.codePointCount(0, it.length)")
                    } else {
                        format!("require({value}.codePointCount(0, {value}.length)")
                    };
                    if let Some(m) = min_max_length_for_type(graph, t)? {
                        if let Some(min) = m.0 {
                            r.emit_validation(format!("{length} >= {}{close}", js_number(min)))?;
                        }
                        if let Some(max) = m.1 {
                            r.emit_validation(format!("{length} <= {}{close}", js_number(max)))?;
                        }
                    }
                    let array = if p.is_optional {
                        format!("{value}?.let {{ require(it.size")
                    } else {
                        format!("require({value}.size")
                    };
                    if let Some(m) = min_max_items_for_type(graph, t)? {
                        if let Some(min) = m.0 {
                            r.emit_validation(format!("{array} >= {}{close}", js_number(min)))?;
                        }
                        if let Some(max) = m.1 {
                            r.emit_validation(format!("{array} <= {}{close}", js_number(max)))?;
                        }
                    }
                    if let Some(pattern) = pattern_for_type(graph, t)? {
                        let target = if p.is_optional { "it" } else { value.as_str() };
                        let matches = format!(
                            "Regex(\"{}\").containsMatchIn({target})",
                            string_escape(&pattern)
                        );
                        let check = if p.is_optional {
                            format!("{value}?.let {{ require({matches}) }}")
                        } else {
                            format!("require({matches})")
                        };
                        r.emit_validation(check)?;
                    }
                    Ok(())
                })?;
                r.emit_line("public fun toJson() = klaxon.toJsonString(this)");
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_line(sl![
                            "public fun fromJson(json: String) = klaxon.parse<",
                            class_name,
                            ">(json)"
                        ]);
                        Ok(())
                    },
                    Delimiter::Curly,
                )
            },
            Delimiter::Curly,
        )
    }

    fn rename_attribute(
        &mut self,
        name: Name,
        json_name: &str,
        _required: bool,
        meta: &mut Vec<Meta>,
        p: &ClassProperty,
    ) -> Result<()> {
        if self.needs_json_object_map_annotation(p.type_ref)? {
            meta.push(Meta::Line("@KlaxonJsonObjectMap".into()));
        }

        if let Some(rename) = self.klaxon_rename_attribute(name, json_name, false)? {
            meta.push(Meta::Line(rename));
        }
        Ok(())
    }

    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        let is_top_level = self.is_top_level(e);

        self.emit_block(
            sl!["enum class ", enum_name, "(val value: String)"],
            |r| {
                r.emit_enum_cases(e)?;
                if is_top_level {
                    r.ensure_blank_line();
                    r.emit_line("public fun toJson() = klaxon.toJsonString(value)");
                }
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        if is_top_level {
                            r.emit_line(
                                "public fun fromJson(json: String) = fromValue(klaxon.parseArray<String>(\"[${json}]\")!![0])",
                            );
                            r.ensure_blank_line();
                        }
                        r.emit_block(
                            sl![
                                "public fun fromValue(value: String): ",
                                enum_name,
                                " = when (value)"
                            ],
                            |r| r.emit_from_value_table(e),
                            Delimiter::Curly,
                        )
                    },
                    Delimiter::Curly,
                )
            },
            Delimiter::Curly,
        )
    }

    fn emit_union_definition_methods(
        &mut self,
        u: TypeRef,
        non_nulls: &IndexSet<TypeRef>,
        maybe_null: Option<TypeRef>,
        union_name: Name,
    ) -> Result<()> {
        let is_top_level = self.is_top_level(u);
        self.ensure_blank_line();
        self.emit_line("public fun toJson(): String = klaxon.toJsonString(when (this) {");
        self.indent(|r| {
            let mut to_json_table: Vec<Vec<Source>> = Vec::new();
            r.for_each_union_member(
                u,
                Some(non_nulls),
                BlankLinePosition::None,
                None,
                |_, name, _, _| {
                    to_json_table.push(vec![sl!["is ", name], sl![" -> this.value"]]);
                    Ok(())
                },
            )?;
            if let Some(null) = maybe_null {
                let name = r.name_for_union_member(u, null)?;
                to_json_table.push(vec![sl!["is ", name], sl![" -> \"null\""]]);
            }

            r.emit_table(to_json_table);
            Ok(())
        })?;
        self.emit_line("})");
        self.ensure_blank_line();
        self.emit_block(
            "companion object".into(),
            |r| {
                if is_top_level {
                    r.emit_line(sl![
                        "public fun fromJson(json: String): ",
                        union_name,
                        " = fromJson(JsonValue(Parser().parse(StringBuilder(json)), null, null, klaxon))"
                    ]);
                    r.ensure_blank_line();
                }
                r.emit_line(sl![
                    "public fun fromJson(jv: JsonValue): ",
                    union_name,
                    " = when (jv.inside) {"
                ]);
                r.indent(|r| {
                    // TS duplicates this grouping in KotlinJacksonRenderer (it is not in
                    // KotlinRenderer), so the port keeps both copies, each
                    // mirroring its TypeScript.
                    //
                    // Members whose JSON representations share a value type
                    // (several transformed string types, or a transformed
                    // string type and an enum, are all strings) must share a
                    // single guard and be tried in sequence, most specific
                    // parse first.
                    let mut groups: Vec<(String, Vec<(Name, TypeRef)>)> = Vec::new();
                    r.for_each_union_member(
                        u,
                        Some(non_nulls),
                        BlankLinePosition::None,
                        None,
                        |r, name, t, _| {
                            let guard =
                                r.sourcelike_to_string(&r.union_member_json_value_guard(t, u)?)?;
                            match groups.iter_mut().find(|(g, _)| *g == guard) {
                                None => groups.push((guard, vec![(name, t)])),
                                Some((_, members)) => members.push((name, t)),
                            }
                            Ok(())
                        },
                    )?;
                    let graph = r.type_graph();
                    let mut table: Vec<Vec<Source>> = Vec::new();
                    for (guard, members) in groups {
                        let mut ordered: Vec<(u32, Name, TypeRef)> =
                            Vec::with_capacity(members.len());
                        for (name, t) in members {
                            ordered.push((union_member_match_priority(graph.kind(t)?), name, t));
                        }
                        ordered.sort_by_key(|&(priority, _, _)| priority);
                        let mut members = ordered.into_iter().rev();
                        let Some((_, last_name, last_t)) = members.next() else {
                            continue;
                        };
                        let mut expr: Source = sl![
                            last_name,
                            "(",
                            r.union_member_from_json_value(last_t, "jv")?,
                            "!!)"
                        ];
                        for (_, name, t) in members {
                            expr = sl![
                                "try { ",
                                name,
                                "(",
                                r.union_member_from_json_value(t, "jv")?,
                                "!!) } catch (e: Exception) { ",
                                expr,
                                " }"
                            ];
                        }

                        table.push(vec![sl![guard], sl![" -> ", expr]]);
                    }

                    if let Some(null) = maybe_null {
                        let name = r.name_for_union_member(u, null)?;
                        table.push(vec![
                            sl![r.union_member_json_value_guard(null, u)?],
                            sl![" -> ", name, "()"],
                        ]);
                    }

                    table.push(vec![
                        sl!["else"],
                        sl![" -> throw IllegalArgumentException()"],
                    ]);
                    r.emit_table(table);
                    Ok(())
                })?;
                r.emit_line("}");
                Ok(())
            },
            Delimiter::Curly,
        )
    }
}

/// The hooks of `KotlinKlaxonRenderer`: all from [`kotlin_hooks`].
pub mod kotlin_klaxon_hooks {
    pub use super::kotlin_hooks::*;
}

impl<'a> ConvenienceRenderer<'a> for KotlinKlaxonRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(kotlin_klaxon_hooks);
}
