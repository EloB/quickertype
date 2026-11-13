//! Port of `packages/quicktype-core/src/language/Kotlin/KotlinJacksonRenderer.ts`.
//!
//! `KotlinJacksonRenderer`: data classes with Jackson annotations, a
//! configured `mapper`, and custom converters for enums, unions and
//! `java.time` types. It is the default Kotlin renderer.

use indexmap::IndexSet;

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::collection_utils::array_intercalate;
use crate::support::strings::camel_case;
use crate::support::support::must_not_happen;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{is_nullable, nullable_from_union};

use super::kotlin_renderer::{
    Delimiter, KotlinOptions, KotlinRenderer, KotlinState, Meta, base_emit_header, kotlin_hooks,
};
use super::utils::{js_number, string_escape, union_member_match_priority};

/// TS `KotlinJacksonRenderer`.
pub struct KotlinJacksonRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    kotlin: KotlinState,
}

impl std::fmt::Debug for KotlinJacksonRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("KotlinJacksonRenderer")
            .field("kotlin", &self.kotlin)
            .finish_non_exhaustive()
    }
}

/// `/^[a-z][A-Z]/.test(s)`.
fn starts_lower_then_upper(s: &str) -> bool {
    let mut units = s.encode_utf16();
    let is = |u: Option<u16>, range: std::ops::RangeInclusive<u8>| {
        u.is_some_and(|u| u < 128 && range.contains(&(u as u8)))
    };
    is(units.next(), b'a'..=b'z') && is(units.next(), b'A'..=b'Z')
}

impl<'a> KotlinJacksonRenderer<'a> {
    /// `new KotlinJacksonRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: KotlinOptions,
    ) -> Self {
        KotlinJacksonRenderer {
            kotlin: KotlinState::new(options, render_context.type_graph),
            core: ConvenienceRendererCore::new(target_language, render_context),
        }
    }

    /// `unionMemberJsonValueGuard(t, e)`.
    fn union_member_json_value_guard(&self, t: TypeRef) -> Result<Source> {
        Ok(match self.type_graph().kind(t)? {
            TypeKind::Any => "is Any".into(),
            TypeKind::Null => "is NullNode".into(),
            TypeKind::Bool => "is BooleanNode".into(),
            TypeKind::Integer => "is IntNode, is LongNode".into(),
            TypeKind::Double => "is IntNode, is LongNode, is DoubleNode".into(),
            TypeKind::String => "is TextNode".into(),
            TypeKind::Array => "is ArrayNode".into(),
            // These could be stricter, but for now we don't allow maps
            // and objects in the same union
            TypeKind::Class | TypeKind::Map => "is ObjectNode".into(),
            // This could be stricter, but for now we don't allow strings
            // and enums in the same union
            TypeKind::Enum => "is TextNode".into(),
            TypeKind::Union => return must_not_happen(),
            kind if kind.is_transformed_string_type_kind() => "is TextNode".into(),
            TypeKind::Intersection => {
                return crate::support::support::panic("Unknown type intersection");
            }
            kind => return type_not_supported(kind),
        })
    }

    /// `jacksonRenameAttribute(propName, jsonName, required, ignore)`.
    fn jackson_rename_attribute(
        &self,
        prop_name: Name,
        json_name: &str,
        required: bool,
        ignore: bool,
    ) -> Result<Option<Source>> {
        let escaped_name = string_escape(json_name);
        let names_differ = self.sourcelike_to_string(&prop_name.into())? != escaped_name;
        let mut properties: Vec<Source> = Vec::new();
        // https://github.com/FasterXML/jackson-module-kotlin/issues/80
        let is_prefix_bool = json_name.starts_with("is");
        let mut property_opts: Vec<Source> = Vec::new();

        if names_differ
            || is_prefix_bool
            || json_name == "empty"
            || starts_lower_then_upper(json_name)
        {
            property_opts.push(format!("\"{escaped_name}\"").into());
        }

        if required {
            property_opts.push("required=true".into());
        }

        if !property_opts.is_empty() {
            properties.push(sl![
                "@get:JsonProperty(",
                array_intercalate(", ".into(), property_opts.clone()),
                ")"
            ]);
            properties.push(sl![
                "@field:JsonProperty(",
                array_intercalate(", ".into(), property_opts),
                ")"
            ]);
        }

        if ignore {
            properties.push("@get:JsonIgnore".into());
            properties.push("@field:JsonIgnore".into());
        }

        Ok(if properties.is_empty() {
            None
        } else {
            Some(Source::Sequence(properties))
        })
    }

    /// `emitGenericConverter(hasNullableUnions)`.
    fn emit_generic_converter(&mut self, has_nullable_unions: bool) -> Result<()> {
        self.ensure_blank_line();
        let get_null_value = if has_nullable_unions {
            "\n\t\t\toverride fun getNullValue(ctxt: DeserializationContext) = if (isUnion) fromJson(NullNode.instance) else null"
        } else {
            ""
        };
        self.emit_multiline(&format!(
            "
@Suppress(\"UNCHECKED_CAST\")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {{
\taddSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {{
\t\t\toverride fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
\t}})
\taddDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {{
\t\t\toverride fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree()){get_null_value}
\t}})
}})"
        ))
    }
}

/// `forbiddenNamesForGlobalNamespace` additions of the Jackson renderer.
const JACKSON_FORBIDDEN: [&str; 18] = [
    "JsonGenerator",
    "JsonNode",
    "JsonParser",
    "ArrayNode",
    "BooleanNode",
    "DeserializationFeature",
    "DoubleNode",
    "IntNode",
    "LongNode",
    "NullNode",
    "ObjectNode",
    "TextNode",
    "ObjectMapper",
    "SerializerProvider",
    "SerializationFeature",
    "SimpleModule",
    "StdDeserializer",
    "StdSerializer",
];

impl<'a> KotlinRenderer<'a> for KotlinJacksonRenderer<'a> {
    fn kotlin(&self) -> &KotlinState {
        &self.kotlin
    }

    fn property_default(&self, p: &ClassProperty, _nullable_or_optional: bool) -> Result<Source> {
        let is_null = self.type_graph().kind(p.type_ref)? == TypeKind::Null;
        Ok((if p.is_optional || is_null {
            " = null"
        } else {
            ""
        })
        .into())
    }

    fn emit_usage_header(&mut self) -> Result<()> {
        self.emit_line("// To parse the JSON, install jackson-module-kotlin and do:");
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

        self.emit_multiline(
            "import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*",
        )?;

        // TS computes these in both KotlinJacksonRenderer.emitHeader and
        // KotlinKlaxonRenderer.emitHeader (not in KotlinRenderer); the port
        // keeps both copies, each mirroring its TypeScript.
        let graph = self.type_graph();
        let named_types = graph.all_named_types()?;
        let mut has_unions = false;
        let mut has_nullable_unions = false;
        let mut has_empty_objects = false;
        for &t in &named_types {
            let ty = graph.type_at(t)?;
            if ty.is_union() && nullable_from_union(graph, t)?.is_none() {
                has_unions = true;
                if is_nullable(graph, t)? {
                    has_nullable_unions = true;
                }
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
            self.emit_generic_converter(has_nullable_unions)?;
        }

        let mut converters: Vec<Vec<Source>> = Vec::new();
        // We don't use jackson-datatype-jsr310's JavaTimeModule because its
        // serializers don't round-trip faithfully (e.g. OffsetTime pads
        // "23:20:50.52Z" to "23:20:50.520Z"); the ISO formatters do.
        if uses_date_time {
            converters.push(vec![
                sl!["convert(OffsetDateTime::class,"],
                sl![" { OffsetDateTime.parse(it.asText()) },"],
                sl![
                    r#" { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })"#
                ],
            ]);
        }

        if uses_date {
            converters.push(vec![
                sl!["convert(LocalDate::class,"],
                sl![" { LocalDate.parse(it.asText()) },"],
                sl![
                    r#" { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })"#
                ],
            ]);
        }

        if uses_time {
            converters.push(vec![
                sl!["convert(OffsetTime::class,"],
                sl![" { OffsetTime.parse(it.asText()) },"],
                sl![
                    r#" { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_TIME.format(it)}\"" })"#
                ],
            ]);
        }

        self.for_each_enum(BlankLinePosition::None, |_, _, name, _| {
            converters.push(vec![
                sl!["convert(", name, "::class,"],
                sl![" { ", name, ".fromValue(it.asText()) },"],
                sl![" { ObjectMapper().writeValueAsString(it.value) })"],
            ]);
            Ok(())
        })?;
        self.for_each_union(BlankLinePosition::None, |_, _, name, _| {
            converters.push(vec![
                sl!["convert(", name, "::class,"],
                sl![" { ", name, ".fromJson(it) },"],
                sl![" { it.toJson() }, true)"],
            ]);
            Ok(())
        })?;

        self.ensure_blank_line();
        self.emit_line("val mapper = jacksonObjectMapper().apply {");
        let have_integers = graph.types().iter().any(|t| t.kind() == TypeKind::Integer);
        self.indent(|r| {
            r.emit_line(
                "propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == \"empty\") \"\" else name }",
            );
            r.emit_line("setSerializationInclusion(JsonInclude.Include.NON_NULL)");
            if have_integers {
                r.emit_line("disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)");
            }
            Ok(())
        })?;

        if !converters.is_empty() {
            self.indent(|r| {
                r.emit_table(converters);
                Ok(())
            })?;
        }

        self.emit_line("}");
        Ok(())
    }

    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let items = self.type_graph().type_at(t)?.items()?;
        let element_type = self.kotlin_type(items, false, false)?;
        self.emit_block(
            sl![
                "class ",
                name,
                "(elements: Collection<",
                element_type.clone(),
                "> = emptyList()) : ArrayList<",
                element_type,
                ">(elements)"
            ],
            |r| {
                r.emit_line("fun toJson() = mapper.writeValueAsString(this)");
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_line(sl![
                            "fun fromJson(json: String) = mapper.readValue<",
                            name,
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
                element_type,
                ">(elements)"
            ],
            |r| {
                r.emit_line("fun toJson() = mapper.writeValueAsString(this)");
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_line(sl![
                            "fun fromJson(json: String) = mapper.readValue<",
                            name,
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

    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;

        self.emit_line(sl!["typealias ", class_name, " = ObjectNode"]);
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
                let mut checks: Vec<String> = Vec::new();
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, _| {
                    let graph = r.type_graph();
                    let t = p.type_ref;
                    let n = r.sourcelike_to_string(&name.into())?;
                    let (min, max) = match min_max_items_for_type(graph, t)? {
                        Some(m) => (m.0, m.1),
                        None => (None, None),
                    };
                    let before = if p.is_optional {
                        format!("{n}?.let {{ require(it.size")
                    } else {
                        format!("require({n}.size")
                    };
                    let after = if p.is_optional { ") }" } else { ")" };
                    if let Some(min) = min {
                        checks.push(format!("{before} >= {}{after}", js_number(min)));
                    }
                    if let Some(max) = max {
                        checks.push(format!("{before} <= {}{after}", js_number(max)));
                    }
                    let (number_min, number_max) = match min_max_value_for_type(graph, t)? {
                        Some(m) => (m.0, m.1),
                        None => (None, None),
                    };
                    let number_before = if p.is_optional {
                        format!("{n}?.let {{ require(it")
                    } else {
                        format!("require({n}")
                    };
                    if let Some(min) = number_min {
                        checks.push(format!("{number_before} >= {}{after}", js_number(min)));
                    }
                    if let Some(max) = number_max {
                        checks.push(format!("{number_before} <= {}{after}", js_number(max)));
                    }
                    let (length_min, length_max) = match min_max_length_for_type(graph, t)? {
                        Some(m) => (m.0, m.1),
                        None => (None, None),
                    };
                    let length_before = if p.is_optional {
                        format!("{n}?.let {{ require(it.codePointCount(0, it.length)")
                    } else {
                        format!("require({n}.codePointCount(0, {n}.length)")
                    };
                    if let Some(min) = length_min {
                        checks.push(format!("{length_before} >= {}{after}", js_number(min)));
                    }
                    if let Some(max) = length_max {
                        checks.push(format!("{length_before} <= {}{after}", js_number(max)));
                    }
                    if let Some(pattern) = pattern_for_type(graph, t)? {
                        let regex =
                            format!("Regex(\"{}\").containsMatchIn", string_escape(&pattern));
                        checks.push(if p.is_optional {
                            format!("{n}?.let {{ require({regex}(it)) }}")
                        } else {
                            format!("require({regex}({n}))")
                        });
                    }
                    Ok(())
                })?;
                if !checks.is_empty() {
                    r.emit_block(
                        "init".into(),
                        |r| {
                            for check in checks {
                                r.emit_line(check);
                            }
                            Ok(())
                        },
                        Delimiter::Curly,
                    )?;
                }
                r.emit_line("fun toJson() = mapper.writeValueAsString(this)");
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_line(sl![
                            "fun fromJson(json: String) = mapper.readValue<",
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
        required: bool,
        meta: &mut Vec<Meta>,
        _p: &ClassProperty,
    ) -> Result<()> {
        if let Some(rename) = self.jackson_rename_attribute(name, json_name, required, false)? {
            meta.push(Meta::Line(rename));
        }
        Ok(())
    }

    fn emit_union_definition_methods(
        &mut self,
        u: TypeRef,
        non_nulls: &IndexSet<TypeRef>,
        maybe_null: Option<TypeRef>,
        union_name: Name,
    ) -> Result<()> {
        self.ensure_blank_line();
        self.emit_line("fun toJson(): String = mapper.writeValueAsString(when (this) {");
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
                to_json_table.push(vec![sl!["is ", name], sl![" -> null"]]);
            }

            r.emit_table(to_json_table);
            Ok(())
        })?;
        self.emit_line("})");
        self.ensure_blank_line();
        self.emit_block(
            "companion object".into(),
            |r| {
                r.emit_line(sl![
                    "fun fromJson(jn: JsonNode): ",
                    union_name,
                    " = when (jn) {"
                ]);
                r.indent(|r| {
                    // TS duplicates this grouping in KotlinKlaxonRenderer (it is not in
                    // KotlinRenderer), so the port keeps both copies, each
                    // mirroring its TypeScript.
                    //
                    // Members whose JSON representations share a node type
                    // (several transformed string types, or a transformed
                    // string type and an enum, are all TextNode) must share
                    // a single guard and be tried in sequence, most specific
                    // parse first.
                    let mut groups: Vec<(String, Vec<(Name, TypeRef)>)> = Vec::new();
                    r.for_each_union_member(
                        u,
                        Some(non_nulls),
                        BlankLinePosition::None,
                        None,
                        |r, name, t, _| {
                            let guard =
                                r.sourcelike_to_string(&r.union_member_json_value_guard(t)?)?;
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
                        let mut ordered: Vec<(u32, Name)> = Vec::with_capacity(members.len());
                        for (name, t) in members {
                            ordered.push((union_member_match_priority(graph.kind(t)?), name));
                        }
                        ordered.sort_by_key(|&(priority, _)| priority);
                        let mut names = ordered.into_iter().map(|(_, name)| name).rev();
                        let Some(last) = names.next() else {
                            continue;
                        };
                        let mut expr: Source = sl![last, "(mapper.convertValue(jn))"];
                        for name in names {
                            expr = sl![
                                "try { ",
                                name,
                                "(mapper.convertValue(jn)) } catch (e: Exception) { ",
                                expr,
                                " }"
                            ];
                        }

                        table.push(vec![sl![guard], sl![" -> ", expr]]);
                    }

                    if let Some(null) = maybe_null {
                        let name = r.name_for_union_member(u, null)?;
                        table.push(vec![
                            sl![r.union_member_json_value_guard(null)?],
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

/// The hooks `KotlinJacksonRenderer` overrides on top of [`kotlin_hooks`].
pub mod kotlin_jackson_hooks {
    pub use super::kotlin_hooks::*;

    use super::{JACKSON_FORBIDDEN, KotlinJacksonRenderer};
    use crate::convenience_renderer::prelude::*;

    /// `forbiddenNamesForGlobalNamespace()`: also the Jackson names the
    /// generated code uses.
    pub fn forbidden_names_for_global_namespace(
        r: &mut KotlinJacksonRenderer<'_>,
    ) -> Result<Vec<String>> {
        let mut forbidden = super::kotlin_hooks::forbidden_names_for_global_namespace(r)?;
        forbidden.extend(JACKSON_FORBIDDEN.iter().map(|&k| k.to_owned()));
        Ok(forbidden)
    }
}

impl<'a> ConvenienceRenderer<'a> for KotlinJacksonRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(kotlin_jackson_hooks);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn lower_then_upper_is_ascii_only() {
        assert!(starts_lower_then_upper("aB"));
        assert!(starts_lower_then_upper("xYz"));
        assert!(!starts_lower_then_upper("ab"));
        assert!(!starts_lower_then_upper("Ab"));
        assert!(!starts_lower_then_upper("éB"));
        assert!(!starts_lower_then_upper("a"));
    }
}
