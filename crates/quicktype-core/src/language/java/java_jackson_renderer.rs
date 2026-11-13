//! Port of `packages/quicktype-core/src/language/Java/JavaJacksonRenderer.ts`.
//!
//! `JacksonRenderer`: the Java renderer with Jackson annotations, custom
//! (de)serializers for unions and a `Converter` class with the
//! (de)serialization entry points. It is the default Java renderer.

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::support::panic;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, find_member, nullable_from_union, remove_null_from_union,
};

use super::java_renderer::{
    JavaOptions, JavaRenderer, JavaState, UnionField, base_emit_class_attributes,
    base_imports_for_type, java_hooks,
};
use super::language::DateTimeProviderOption;
use super::utils::string_escape;

/// TS `JacksonRenderer`.
pub struct JacksonRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    java: JavaState,
    /// Whether the graph has any `integer` type (computed once per
    /// render).
    have_integers: bool,
}

impl std::fmt::Debug for JacksonRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("JacksonRenderer")
            .field("java", &self.java)
            .finish_non_exhaustive()
    }
}

impl<'a> JacksonRenderer<'a> {
    /// `new JacksonRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: JavaOptions,
    ) -> Self {
        let have_integers = render_context
            .type_graph
            .types()
            .iter()
            .any(|t| t.kind() == TypeKind::Integer);
        JacksonRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            java: JavaState::new(options),
            have_integers,
        }
    }

    /// `mapperType(t)`: what `readerFor`/`writerFor` get.
    fn mapper_type(&self, t: TypeRef) -> Result<Source> {
        if self.java.options.use_list && self.type_graph().kind(t)? == TypeKind::Array {
            return Ok(sl![
                "new TypeReference<",
                self.java_type(false, t, false)?,
                ">() {}"
            ]);
        }
        Ok(sl![self.java_type_without_generics(false, t)?, ".class"])
    }

    /// One `module.addDeserializer(...)` block of
    /// `emitOffsetDateTimeConverterModule`.
    fn emit_deserializer_registration(
        &mut self,
        java_type: &'static str,
        parse: Source,
    ) -> Result<()> {
        self.emit_line(sl![
            "module.addDeserializer(",
            java_type,
            ".class, new JsonDeserializer<",
            java_type,
            ">() {"
        ]);
        self.indent(|r| {
            r.emit_line("@Override");
            r.emit_block(
                sl![
                    "public ",
                    java_type,
                    " deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) ",
                    "throws IOException, JsonProcessingException"
                ],
                |r| {
                    r.emit_line("String value = jsonParser.getText();");
                    r.emit_line(sl!["return ", parse, ";"]);
                    Ok(())
                },
            )
        })?;
        self.emit_line("});");
        Ok(())
    }

    /// `emitOffsetDateTimeConverterModule()`.
    fn emit_offset_date_time_converter_module(&mut self) -> Result<()> {
        self.emit_line("SimpleModule module = new SimpleModule();");
        let provider = self.java.date_time_provider.clone();

        if provider.should_emit_date_time_converter() {
            self.emit_deserializer_registration(
                provider.date_time_type(),
                provider.convert_string_to_date_time("value"),
            )?;
        }

        if !provider.should_emit_time_converter() {
            self.emit_deserializer_registration(
                provider.time_type(),
                provider.convert_string_to_time("value"),
            )?;
        }

        if !provider.should_emit_date_converter() {
            self.emit_deserializer_registration(
                provider.date_type(),
                provider.convert_string_to_date("value"),
            )?;
        }

        self.emit_line("mapper.registerModule(module);");
        Ok(())
    }

    /// `emitConverterClass()`: `Converter.java`.
    fn emit_converter_class(&mut self) -> Result<()> {
        let converter_classname = self.java.converter_classname;
        self.start_file(converter_classname.into())?;
        let lombok = self.java.options.lombok;
        let java8 = self.java.options.date_time_provider == DateTimeProviderOption::Java8;
        let lines: Vec<Source> = vec![
            "To use this code, add the following Maven dependency to your project:".into(),
            "".into(),
            (if lombok {
                "    org.projectlombok : lombok : 1.18.2"
            } else {
                ""
            })
            .into(),
            "    com.fasterxml.jackson.core     : jackson-databind          : 2.9.0".into(),
            (if java8 {
                "    com.fasterxml.jackson.datatype : jackson-datatype-jsr310   : 2.9.0"
            } else {
                ""
            })
            .into(),
            "".into(),
            "Import this package:".into(),
            "".into(),
        ];
        self.emit_comment_lines(&lines, &Default::default())?;
        let package_name = self.java.options.package_name.clone();
        self.emit_line(sl!["//     import ", package_name, ".Converter;"]);
        self.emit_multiline(
            "//
// Then you can deserialize a JSON string with
//",
        )?;
        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            let java_type = r.java_type(false, t, false)?;
            let decoder_name = r.decoder_name(name);
            r.emit_line(sl![
                "//     ",
                java_type,
                " data = Converter.",
                decoder_name,
                "(jsonString);"
            ]);
            Ok(())
        })?;
        self.ensure_blank_line();
        let mut imports: Vec<String> = [
            "java.io.IOException",
            "com.fasterxml.jackson.databind.*",
            "com.fasterxml.jackson.databind.module.SimpleModule",
            "com.fasterxml.jackson.core.JsonParser",
            "com.fasterxml.jackson.core.JsonProcessingException",
            "com.fasterxml.jackson.core.type.TypeReference",
            "java.util.*",
        ]
        .iter()
        .map(|&i| i.to_owned())
        .collect();
        imports.extend(
            self.java
                .date_time_provider
                .converter_imports()
                .iter()
                .map(|&i| i.to_owned()),
        );
        self.emit_package_and_imports(&imports);
        self.ensure_blank_line();
        self.emit_block(sl!["public class Converter"], |r| {
            r.emit_line("// Date-time helpers");
            let provider = r.java.date_time_provider.clone();
            provider.emit_date_time_converters(r)?;

            r.emit_line("// Serialize/deserialize helpers");
            r.for_each_top_level(
                BlankLinePosition::LeadingAndInterposing,
                |r, top_level_type, top_level_name, _| {
                    let top_level_type_rendered = r.java_type(false, top_level_type, false)?;
                    let decoder_name = r.decoder_name(top_level_name);
                    let reader_getter_name = r.reader_getter_name(top_level_name);
                    r.emit_block(
                        sl![
                            "public static ",
                            top_level_type_rendered.clone(),
                            " ",
                            decoder_name,
                            "(String json) throws IOException"
                        ],
                        |r| {
                            r.emit_line(sl![
                                "return ",
                                reader_getter_name,
                                "().readValue(json);"
                            ]);
                            Ok(())
                        },
                    )?;
                    r.ensure_blank_line();
                    let encoder_name = r.encoder_name(top_level_name);
                    let writer_getter_name = r.writer_getter_name(top_level_name);
                    r.emit_block(
                        sl![
                            "public static String ",
                            encoder_name,
                            "(",
                            top_level_type_rendered,
                            " obj) throws JsonProcessingException"
                        ],
                        |r| {
                            r.emit_line(sl![
                                "return ",
                                writer_getter_name,
                                "().writeValueAsString(obj);"
                            ]);
                            Ok(())
                        },
                    )
                },
            )?;
            r.for_each_top_level(
                BlankLinePosition::LeadingAndInterposing,
                |r, top_level_type, top_level_name, _| {
                    let reader_name = r.field_or_method_name("reader", top_level_name);
                    let writer_name = r.field_or_method_name("writer", top_level_name);
                    r.emit_line(sl![
                        "private static ObjectReader ",
                        reader_name.clone(),
                        ";"
                    ]);
                    r.emit_line(sl![
                        "private static ObjectWriter ",
                        writer_name.clone(),
                        ";"
                    ]);
                    r.ensure_blank_line();
                    let instantiate = r.method_name("instantiate", "Mapper", top_level_name);
                    r.emit_block(
                        sl!["private static void ", instantiate.clone(), "()"],
                        |r| {
                            let rendered_for_mapper = r.mapper_type(top_level_type)?;
                            r.emit_line("ObjectMapper mapper = new ObjectMapper();");
                            r.emit_line("mapper.findAndRegisterModules();");
                            r.emit_line(
                                "mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);",
                            );
                            if r.have_integers {
                                r.emit_line(
                                    "mapper.configure(DeserializationFeature.ACCEPT_FLOAT_AS_INT, false);",
                                );
                            }
                            r.emit_line(
                                "mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);",
                            );
                            r.emit_offset_date_time_converter_module()?;
                            r.emit_line(sl![
                                reader_name.clone(),
                                " = mapper.readerFor(",
                                rendered_for_mapper.clone(),
                                ");"
                            ]);
                            r.emit_line(sl![
                                writer_name.clone(),
                                " = mapper.writerFor(",
                                rendered_for_mapper,
                                ");"
                            ]);
                            Ok(())
                        },
                    )?;
                    r.ensure_blank_line();
                    let reader_getter_name = r.reader_getter_name(top_level_name);
                    r.emit_block(
                        sl!["private static ObjectReader ", reader_getter_name, "()"],
                        |r| {
                            r.emit_line(sl![
                                "if (",
                                reader_name.clone(),
                                " == null) ",
                                instantiate.clone(),
                                "();"
                            ]);
                            r.emit_line(sl!["return ", reader_name, ";"]);
                            Ok(())
                        },
                    )?;
                    r.ensure_blank_line();
                    let writer_getter_name = r.writer_getter_name(top_level_name);
                    r.emit_block(
                        sl!["private static ObjectWriter ", writer_getter_name, "()"],
                        |r| {
                            r.emit_line(sl![
                                "if (",
                                writer_name.clone(),
                                " == null) ",
                                instantiate,
                                "();"
                            ]);
                            r.emit_line(sl!["return ", writer_name, ";"]);
                            Ok(())
                        },
                    )
                },
            )?;
            Ok(())
        })?;
        self.finish_current_file()
    }

    // ---- emitUnionSerializer ----------------------------------------------

    /// `tokenCase(tokenType)`.
    fn token_case(&mut self, token_type: &str) {
        self.emit_line(sl!["case ", token_type, ":"]);
    }

    /// `emitDeserializerCodeForStringObjects(fieldName, kind, parseFrom)`.
    fn emit_deserializer_code_for_string_objects(
        &mut self,
        field_name: Source,
        kind: TypeKind,
        parse_from: &str,
    ) -> Result<()> {
        let provider = &self.java.date_time_provider;
        let parsed = match kind {
            TypeKind::Date => provider.convert_string_to_date(parse_from),
            TypeKind::Time => provider.convert_string_to_time(parse_from),
            TypeKind::DateTime => provider.convert_string_to_date_time(parse_from),
            TypeKind::Uuid => {
                self.emit_line(sl![
                    "value.",
                    field_name,
                    " = UUID.fromString(",
                    parse_from,
                    ");"
                ]);
                return Ok(());
            }
            _ => return panic("Requested type isnt an object!"),
        };
        self.emit_line(sl!["value.", field_name, " = ", parsed, ";"]);
        Ok(())
    }

    /// `emitDeserializeType(t, variableFieldName)`.
    fn emit_deserialize_type(
        &mut self,
        u: TypeRef,
        t: TypeRef,
        variable_field_name: &str,
    ) -> Result<()> {
        let UnionField { field_name, .. } = self.union_field(u, t, false)?;
        let rendered = self.java_type_without_generics(true, t)?;
        let kind = self.type_graph().kind(t)?;
        if self.java.options.use_list && kind == TypeKind::Array {
            // The TypeReference must carry the full generic type:
            // a raw `TypeReference<List>` would make Jackson accept
            // any element type, so schema-invalid inputs (which the
            // expected-failure fixtures rely on rejecting) would
            // deserialize successfully.
            let java_type = self.java_type(true, t, false)?;
            self.emit_line(sl![
                "value.",
                field_name,
                " = jsonParser.readValueAs(new TypeReference<",
                java_type,
                ">() {});"
            ]);
        } else if STRING_BASED_OBJECTS.contains(&kind) {
            self.emit_deserializer_code_for_string_objects(field_name, kind, variable_field_name)?;
        } else if kind == TypeKind::String {
            self.emit_line(sl!["value.", field_name, " = ", variable_field_name, ";"]);
        } else if kind == TypeKind::Enum {
            let UnionField { field_type, .. } = self.union_field(u, t, true)?;
            self.emit_line(sl![
                "value.",
                field_name,
                " = ",
                field_type,
                ".forValue(",
                variable_field_name,
                ");"
            ]);
        } else {
            self.emit_line(sl![
                "value.",
                field_name,
                " = jsonParser.readValueAs(",
                rendered,
                ".class);"
            ]);
        }
        Ok(())
    }

    /// `emitDeserializer(tokenTypes, kind)`.
    fn emit_deserializer(
        &mut self,
        u: TypeRef,
        token_types: &[&str],
        kind: TypeKind,
    ) -> Result<()> {
        let Some(t) = find_member(self.type_graph(), u, kind)? else {
            return Ok(());
        };
        self.indent(|r| {
            for token_type in token_types {
                r.token_case(token_type);
            }
            r.indent(|r| {
                r.emit_deserialize_type(u, t, "")?;
                r.emit_line("break;");
                Ok(())
            })
        })
    }

    /// `emitStringDeserializer()`.
    fn emit_string_deserializer(&mut self, u: TypeRef) -> Result<()> {
        let graph = self.type_graph();
        let enum_type = find_member(graph, u, TypeKind::Enum)?;
        let string_type = find_member(graph, u, TypeKind::String)?;

        let mut no_string_based = true;
        for kind in STRING_BASED_OBJECTS {
            if find_member(graph, u, kind)?.is_some() {
                no_string_based = false;
            }
        }
        if no_string_based && string_type.is_none() && enum_type.is_none() {
            return Ok(());
        }

        self.indent(|r| {
            r.token_case("VALUE_STRING");

            r.indent(|r| {
                let from_variable = "string";
                r.emit_line(format!(
                    "String {from_variable} = jsonParser.readValueAs(String.class);"
                ));

                for kind in STRING_BASED_OBJECTS {
                    if let Some(t) = find_member(r.type_graph(), u, kind)? {
                        r.emit_ignored_try_catch_block(|r| {
                            r.emit_deserialize_type(u, t, from_variable)
                        })?;
                    }
                }

                if let Some(enum_type) = enum_type {
                    r.emit_ignored_try_catch_block(|r| {
                        r.emit_deserialize_type(u, enum_type, from_variable)
                    })?;
                }

                // String should be the last one if exists, because it cannot
                // fail, unlike the parsers.
                if let Some(string_type) = string_type {
                    r.emit_deserialize_type(u, string_type, from_variable)?;
                }

                r.emit_line("break;");
                Ok(())
            })
        })
    }

    /// `emitNumberDeserializer()`.
    fn emit_number_deserializer(&mut self, u: TypeRef) -> Result<()> {
        let graph = self.type_graph();
        let integer_type = find_member(graph, u, TypeKind::Integer)?;
        let double_type = find_member(graph, u, TypeKind::Double)?;
        if double_type.is_none() && integer_type.is_none() {
            return Ok(());
        }

        self.indent(|r| {
            r.token_case("VALUE_NUMBER_INT");
            if let Some(integer_type) = integer_type {
                r.indent(|r| {
                    r.emit_deserialize_type(u, integer_type, "")?;
                    r.emit_line("break;");
                    Ok(())
                })?;
            }

            if let Some(double_type) = double_type {
                r.token_case("VALUE_NUMBER_FLOAT");
                r.indent(|r| {
                    r.emit_deserialize_type(u, double_type, "")?;
                    r.emit_line("break;");
                    Ok(())
                })?;
            }
            Ok(())
        })
    }

    /// `serializerCodeForType(type, fieldName)`.
    fn serializer_code_for_type(&self, t: TypeRef, field_name: Source) -> Result<Source> {
        let provider = &self.java.date_time_provider;
        match self.type_graph().kind(t)? {
            TypeKind::Date => Ok(provider.convert_date_to_string(field_name)),
            TypeKind::Time => Ok(provider.convert_time_to_string(field_name)),
            TypeKind::DateTime => Ok(provider.convert_date_time_to_string(field_name)),
            _ => panic("Requested type doesn't have custom serializer code!"),
        }
    }

    /// `emitSerializeType(t)`.
    fn emit_serialize_type(&mut self, u: TypeRef, t: TypeRef) -> Result<()> {
        let UnionField { field_name, .. } = self.union_field(u, t, true)?;
        let kind = self.type_graph().kind(t)?;

        self.emit_block(sl!["if (obj.", field_name.clone(), " != null)"], |r| {
            if CUSTOM_OBJECT_SERIALIZER.contains(&kind) {
                let code = r.serializer_code_for_type(t, sl!["obj.", field_name])?;
                r.emit_line(sl!["jsonGenerator.writeObject(", code, ");"]);
            } else {
                r.emit_line(sl!["jsonGenerator.writeObject(obj.", field_name, ");"]);
            }

            r.emit_line("return;");
            Ok(())
        })
    }
}

/// `stringBasedObjects`: kinds deserialized from a JSON string.
const STRING_BASED_OBJECTS: [TypeKind; 4] = [
    TypeKind::Uuid,
    TypeKind::Time,
    TypeKind::Date,
    TypeKind::DateTime,
];

/// `customObjectSerializer`: kinds serialized with a formatter.
const CUSTOM_OBJECT_SERIALIZER: [TypeKind; 3] =
    [TypeKind::Time, TypeKind::Date, TypeKind::DateTime];

/// `_converterKeywords`.
const CONVERTER_KEYWORDS: [&str; 17] = [
    "JsonProperty",
    "JsonSetter",
    "Nulls",
    "JsonDeserialize",
    "JsonDeserializer",
    "JsonSerialize",
    "JsonSerializer",
    "JsonParser",
    "JsonProcessingException",
    "ObjectMapper",
    "ObjectReader",
    "ObjectWriter",
    "DeserializationFeature",
    "SerializationFeature",
    "DeserializationContext",
    "SerializerProvider",
    "None",
];

impl<'a> JavaRenderer<'a> for JacksonRenderer<'a> {
    fn java(&self) -> &JavaState {
        &self.java
    }

    fn java_mut(&mut self) -> &mut JavaState {
        &mut self.java
    }

    fn converter_keywords(&self) -> &'static [&'static str] {
        &CONVERTER_KEYWORDS
    }

    fn emit_class_attributes(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        if self.type_graph().type_at(c)?.properties()?.is_empty() {
            self.emit_line("@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.NONE)");
        }

        base_emit_class_attributes(self, c, class_name)
    }

    fn annotations_for_accessor(
        &self,
        _c: TypeRef,
        _class_name: Name,
        _property_name: Name,
        json_name: &str,
        p: &ClassProperty,
        is_setter: bool,
    ) -> Result<Vec<String>> {
        // `super.annotationsForAccessor(...)` is empty.
        let mut annotations = vec![format!("@JsonProperty(\"{}\")", string_escape(json_name))];

        let graph = self.type_graph();
        if is_setter && graph.kind(p.type_ref)? == TypeKind::DateTime {
            annotations.push("@JsonSetter(nulls = Nulls.FAIL)".to_owned());
        }

        let property_type = if graph.kind(p.type_ref)? == TypeKind::Union {
            nullable_from_union(graph, p.type_ref)?.unwrap_or(p.type_ref)
        } else {
            p.type_ref
        };

        let provider = &self.java.date_time_provider;
        let extra: &[&str] = match graph.kind(property_type)? {
            TypeKind::DateTime => provider.date_time_jackson_annotations(),
            TypeKind::Date => provider.date_jackson_annotations(),
            TypeKind::Time => provider.time_jackson_annotations(),
            _ => &[],
        };
        annotations.extend(extra.iter().map(|&a| a.to_owned()));

        Ok(annotations)
    }

    fn imports_for_type(&self, t: TypeRef) -> Result<Vec<String>> {
        let mut imports = base_imports_for_type(self, t)?;
        match self.type_graph().kind(t)? {
            TypeKind::Class | TypeKind::Enum => {
                imports.push("com.fasterxml.jackson.annotation.*".to_owned());
            }
            TypeKind::Union => {
                imports.extend(
                    [
                        "java.io.IOException",
                        "com.fasterxml.jackson.core.*",
                        "com.fasterxml.jackson.databind.*",
                        "com.fasterxml.jackson.databind.annotation.*",
                    ]
                    .iter()
                    .map(|&i| i.to_owned()),
                );
                if self.java.options.use_list {
                    imports.push("com.fasterxml.jackson.core.type.*".to_owned());
                }
            }
            kind => return crate::support::support::assert_never(kind),
        }
        Ok(imports)
    }

    fn emit_union_attributes(&mut self, _u: TypeRef, union_name: Name) -> Result<()> {
        self.emit_line(sl![
            "@JsonDeserialize(using = ",
            union_name,
            ".Deserializer.class)"
        ]);
        self.emit_line(sl![
            "@JsonSerialize(using = ",
            union_name,
            ".Serializer.class)"
        ]);
        Ok(())
    }

    fn emit_union_serializer(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let (maybe_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;

        self.ensure_blank_line();
        self.emit_block(
            sl![
                "static class Deserializer extends JsonDeserializer<",
                union_name,
                ">"
            ],
            |r| {
                r.emit_line("@Override");
                r.emit_block(
                    sl![
                        "public ",
                        union_name,
                        " deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException"
                    ],
                    |r| {
                        r.emit_line(sl![union_name, " value = new ", union_name, "();"]);
                        r.emit_line("switch (jsonParser.currentToken()) {");
                        if maybe_null.is_some() {
                            // emitNullDeserializer()
                            r.indent(|r| {
                                r.token_case("VALUE_NULL");
                                r.indent(|r| {
                                    r.emit_line("break;");
                                    Ok(())
                                })
                            })?;
                        }
                        r.emit_number_deserializer(u)?;
                        r.emit_deserializer(u, &["VALUE_TRUE", "VALUE_FALSE"], TypeKind::Bool)?;
                        r.emit_string_deserializer(u)?;
                        r.emit_deserializer(u, &["START_ARRAY"], TypeKind::Array)?;
                        r.emit_deserializer(u, &["START_OBJECT"], TypeKind::Class)?;
                        r.emit_deserializer(u, &["START_OBJECT"], TypeKind::Map)?;
                        r.indent(|r| {
                            r.emit_line(sl![
                                "default: throw new IOException(\"Cannot deserialize ",
                                union_name,
                                "\");"
                            ]);
                            Ok(())
                        })?;
                        r.emit_line("}");
                        r.emit_line("return value;");
                        Ok(())
                    },
                )
            },
        )?;
        self.ensure_blank_line();
        self.emit_block(
            sl![
                "static class Serializer extends JsonSerializer<",
                union_name,
                ">"
            ],
            |r| {
                r.emit_line("@Override");
                r.emit_block(
                    sl![
                        "public void serialize(",
                        union_name,
                        " obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException"
                    ],
                    |r| {
                        for &t in &non_nulls {
                            r.emit_serialize_type(u, t)?;
                        }

                        if maybe_null.is_some() {
                            r.emit_line("jsonGenerator.writeNull();");
                        } else {
                            r.emit_line(sl![
                                "throw new IOException(\"",
                                union_name,
                                " must not be null\");"
                            ]);
                        }
                        Ok(())
                    },
                )
            },
        )
    }

    fn emit_enum_serialization_attributes(&mut self, _e: TypeRef) -> Result<()> {
        self.emit_line("@JsonValue");
        Ok(())
    }

    fn emit_enum_deserialization_attributes(&mut self, _e: TypeRef) -> Result<()> {
        self.emit_line("@JsonCreator");
        Ok(())
    }
}

/// The hooks `JacksonRenderer` overrides on top of [`java_hooks`].
pub mod jackson_hooks {
    pub use super::java_hooks::*;

    use super::JacksonRenderer;
    use crate::convenience_renderer::prelude::*;

    /// `emitSourceStructure()`: `Converter.java`, then the types.
    pub fn emit_source_structure(
        r: &mut JacksonRenderer<'_>,
        given_output_filename: &str,
    ) -> Result<()> {
        r.emit_converter_class()?;
        super::java_hooks::emit_source_structure(r, given_output_filename)
    }
}

impl<'a> ConvenienceRenderer<'a> for JacksonRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(jackson_hooks);
}
