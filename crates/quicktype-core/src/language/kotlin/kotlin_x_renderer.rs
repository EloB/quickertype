//! Port of `packages/quicktype-core/src/language/Kotlin/KotlinXRenderer.ts`.
//!
//! `KotlinXRenderer`: `@Serializable` classes for kotlinx.serialization.
//! It supports simple classes, enums and TS string unions (which are also
//! enums); other unions and `any` become `JsonElement`.

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::strings::camel_case;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::nullable_from_union;

use super::kotlin_renderer::{
    Delimiter, KotlinOptions, KotlinRenderer, KotlinState, Meta, base_array_type, base_emit_header,
    base_emit_top_level_map, base_emit_union_definition, base_kotlin_type, base_map_type,
    kotlin_hooks,
};
use super::utils::string_escape;

/// One of `dateTimeSerializers`: kotlinx.serialization has no built-in
/// serializers for `java.time`, so we emit our own and register them
/// file-wide with `@file:UseSerializers`. Like the Jackson converters, they
/// parse with `.parse` and format with the ISO formatters so values
/// round-trip faithfully.
#[derive(Clone, Copy, Debug)]
struct DateTimeSerializer {
    kind: TypeKind,
    name: &'static str,
    java_type: &'static str,
    formatter: &'static str,
}

/// `dateTimeSerializers`.
const DATE_TIME_SERIALIZERS: [DateTimeSerializer; 3] = [
    DateTimeSerializer {
        kind: TypeKind::DateTime,
        name: "OffsetDateTimeSerializer",
        java_type: "OffsetDateTime",
        formatter: "ISO_OFFSET_DATE_TIME",
    },
    DateTimeSerializer {
        kind: TypeKind::Date,
        name: "LocalDateSerializer",
        java_type: "LocalDate",
        formatter: "ISO_LOCAL_DATE",
    },
    DateTimeSerializer {
        kind: TypeKind::Time,
        name: "OffsetTimeSerializer",
        java_type: "OffsetTime",
        formatter: "ISO_OFFSET_TIME",
    },
];

/// TS `KotlinXRenderer`.
pub struct KotlinXRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    kotlin: KotlinState,
}

impl std::fmt::Debug for KotlinXRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("KotlinXRenderer")
            .field("kotlin", &self.kotlin)
            .finish_non_exhaustive()
    }
}

/// Whether a rendered type is `JsonObject` or `JsonElement`.
fn is_json_object_or_element(name: &str) -> bool {
    name == "JsonObject" || name == "JsonElement"
}

impl<'a> KotlinXRenderer<'a> {
    /// `new KotlinXRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: KotlinOptions,
    ) -> Self {
        KotlinXRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            kotlin: KotlinState::new(options),
        }
    }

    /// `usedDateTimeSerializers()`.
    fn used_date_time_serializers(&self) -> Vec<DateTimeSerializer> {
        DATE_TIME_SERIALIZERS
            .into_iter()
            .filter(|s| self.have_transformed_string_type(s.kind))
            .collect()
    }

    /// `_rename(propName, jsonName)`.
    fn rename(&self, prop_name: Name, json_name: &str) -> Result<Option<Source>> {
        let escaped_name = string_escape(json_name);
        let names_differ = self.sourcelike_to_string(&prop_name.into())? != escaped_name;
        if names_differ {
            return Ok(Some(sl!["@SerialName(\"", escaped_name, "\")"]));
        }

        Ok(None)
    }
}

impl<'a> KotlinRenderer<'a> for KotlinXRenderer<'a> {
    fn kotlin(&self) -> &KotlinState {
        &self.kotlin
    }

    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        if nullable_from_union(self.type_graph(), u)?.is_none() {
            self.emit_line(sl!["typealias ", union_name, " = JsonElement"]);
            return Ok(());
        }
        base_emit_union_definition(self, u, union_name)
    }

    fn kotlin_type(&self, t: TypeRef, with_issues: bool, no_optional: bool) -> Result<Source> {
        let graph = self.type_graph();
        if graph.type_at(t)?.is_union() && nullable_from_union(graph, t)?.is_none() {
            return Ok("JsonElement".into());
        }
        base_kotlin_type(self, t, with_issues, no_optional)
    }

    fn any_source_type(&self, optional: &str) -> Source {
        sl!["JsonElement", optional]
    }

    fn array_type(
        &self,
        array_type: TypeRef,
        with_issues: bool,
        no_optional: bool,
    ) -> Result<Source> {
        let items = self.type_graph().type_at(array_type)?.items()?;
        let val_type = self.kotlin_type(items, with_issues, true)?;
        let name = self.sourcelike_to_string(&val_type)?;
        if is_json_object_or_element(&name) {
            return Ok("JsonArray".into());
        }

        base_array_type(self, array_type, with_issues, no_optional)
    }

    fn map_type(&self, map_type: TypeRef, with_issues: bool, no_optional: bool) -> Result<Source> {
        let values = self.type_graph().type_at(map_type)?.map_values()?;
        let val_type = self.kotlin_type(values, with_issues, true)?;
        let name = self.sourcelike_to_string(&val_type)?;
        if is_json_object_or_element(&name) {
            return Ok("JsonObject".into());
        }

        base_map_type(self, map_type, with_issues, no_optional)
    }

    fn emit_top_level_map(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let values = self.type_graph().type_at(t)?.map_values()?;
        let element_type = self.kotlin_type(values, false, false)?;
        // TS `elementType === "JsonObject"`: only the string `mapType`
        // returns, never a name or an array.
        if matches!(&element_type, Source::Text(s) if s == "JsonObject") {
            self.emit_line(sl!["typealias ", name, " = JsonObject"]);
            Ok(())
        } else {
            base_emit_top_level_map(self, t, name)
        }
    }

    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let items = self.type_graph().type_at(t)?.items()?;
        let element_type = self.kotlin_type(items, false, false)?;
        self.emit_line(sl!["typealias ", name, " = List<", element_type, ">"]);
        Ok(())
    }

    fn emit_usage_header(&mut self) -> Result<()> {
        self.emit_line("// To parse the JSON, install kotlin's serialization plugin and do:");
        self.emit_line("//");
        let mut table: Vec<Vec<Source>> = vec![vec![
            "// val ".into(),
            "json".into(),
            " = Json { allowStructuredMapKeys = true }".into(),
        ]];
        self.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
            let name_string = r.sourcelike_to_string(&name.into())?;
            table.push(vec![
                "// val ".into(),
                modify_source(camel_case, name),
                format!(" = json.parse({name_string}.serializer(), jsonString)").into(),
            ]);
            Ok(())
        })?;
        self.emit_table(table);
        Ok(())
    }

    fn emit_file_annotations(&mut self) -> Result<()> {
        let serializers = self.used_date_time_serializers();
        if serializers.is_empty() {
            return Ok(());
        }

        let names: Vec<String> = serializers
            .iter()
            .map(|s| format!("{}::class", s.name))
            .collect();
        self.emit_line(sl!["@file:UseSerializers(", names.join(", "), ")"]);
        self.ensure_blank_line();
        Ok(())
    }

    fn emit_header(&mut self) -> Result<()> {
        base_emit_header(self)?;

        self.emit_line("import kotlinx.serialization.*");
        self.emit_line("import kotlinx.serialization.json.*");
        self.emit_line("import kotlinx.serialization.descriptors.*");
        self.emit_line("import kotlinx.serialization.encoding.*");
        Ok(())
    }

    fn emit_class_annotations(&mut self, _t: TypeRef, _class_name: Name) -> Result<()> {
        self.emit_line("@Serializable");
        Ok(())
    }

    fn rename_attribute(
        &mut self,
        name: Name,
        json_name: &str,
        _required: bool,
        meta: &mut Vec<Meta>,
        _p: &ClassProperty,
    ) -> Result<()> {
        if let Some(rename) = self.rename(name, json_name)? {
            meta.push(Meta::Line(rename));
        }
        Ok(())
    }

    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;

        self.emit_line(sl!["@Serializable"]);
        self.emit_block(
            sl!["enum class ", enum_name, "(val value: String)"],
            |r| {
                let mut count = r.type_graph().type_at(e)?.cases()?.len();
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json, _| {
                    let json_enum = string_escape(json);
                    count -= 1;
                    r.emit_line(sl![
                        format!("@SerialName(\"{json_enum}\") "),
                        name,
                        format!("(\"{json_enum}\")"),
                        if count == 0 { ";" } else { "," }
                    ]);
                    Ok(())
                })
            },
            Delimiter::Curly,
        )
    }
}

/// The hooks `KotlinXRenderer` overrides on top of [`kotlin_hooks`].
pub mod kotlin_x_hooks {
    pub use super::kotlin_hooks::*;

    use super::{DATE_TIME_SERIALIZERS, KotlinXRenderer};
    use crate::convenience_renderer::prelude::*;

    /// `forbiddenNamesForGlobalNamespace()`: also the serializers and the
    /// kotlinx.serialization names the generated code uses.
    pub fn forbidden_names_for_global_namespace(
        r: &mut KotlinXRenderer<'_>,
    ) -> Result<Vec<String>> {
        let mut forbidden = super::kotlin_hooks::forbidden_names_for_global_namespace(r)?;
        forbidden.extend(DATE_TIME_SERIALIZERS.iter().map(|s| s.name.to_owned()));
        forbidden.extend(
            [
                "Decoder",
                "Encoder",
                "KSerializer",
                "PrimitiveKind",
                "Serializable",
                "SerialDescriptor",
                "SerialName",
                "UseSerializers",
            ]
            .iter()
            .map(|&k| k.to_owned()),
        );
        Ok(forbidden)
    }

    /// `emitSourceStructure()`: then the date-time serializers it uses.
    pub fn emit_source_structure(
        r: &mut KotlinXRenderer<'_>,
        given_output_filename: &str,
    ) -> Result<()> {
        super::kotlin_hooks::emit_source_structure(r, given_output_filename)?;

        for serializer in r.used_date_time_serializers() {
            r.ensure_blank_line();
            let name = serializer.name;
            let java_type = serializer.java_type;
            let formatter = serializer.formatter;
            r.emit_multiline(&format!(
                "object {name} : KSerializer<{java_type}> {{
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor(\"{java_type}\", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): {java_type} = {java_type}.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: {java_type}) {{
        encoder.encodeString(java.time.format.DateTimeFormatter.{formatter}.format(value))
    }}
}}"
            ))?;
        }
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for KotlinXRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(kotlin_x_hooks);
}
