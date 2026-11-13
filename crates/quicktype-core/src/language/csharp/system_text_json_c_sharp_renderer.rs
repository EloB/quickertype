//! Port of `packages/quicktype-core/src/language/CSharp/SystemTextJsonCSharpRenderer.ts`.
//!
//! C# for System.Text.Json: `[JsonPropertyName]` attributes, the
//! `FromJson`/`ToJson` helpers, the `Converter` options, one
//! `JsonConverter<T>` per named transformation, generated from its
//! transformer tree, and the DateOnly/TimeOnly and `DateTimeOffset`
//! converters.
//!
//! The transformer interpreter (`emitDecodeTransformer`, `emitTransformer`
//! and the converter classes) is a separate copy from the Newtonsoft
//! renderer's on purpose: TypeScript has two near-identical copies that
//! differ in details, and mirroring each keeps upstream changes portable
//! one to one.

use std::cell::Cell;
use std::rc::Rc;

use quicktype_js_compat::number;

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::collection_utils::array_intercalate;
use crate::support::strings::{camel_case, utf16_string_escape};
use crate::support::support::{defined, panic};
use crate::target_language::TargetLanguage;
use crate::transformers::{
    Transformer, TransformerData, downcast_transformation, follow_target_type,
    transformation_for_type,
};
use crate::ty::type_utils::{is_nullable, nullable_from_union};

use super::c_sharp_renderer::{
    BaseClass, CSharpOptions, CSharpRenderer, CSharpState, Finish, Follow, emit_usings,
    transformation_of,
};
use super::utils::{
    AccessModifier, DENSE_JSON_PROPERTY_NAME, DENSE_NULL_VALUE_HANDLING_ENUM_NAME,
    always_apply_transformation, is_value_type,
};

/// `SystemTextJsonCSharpRenderer`.
pub struct SystemTextJsonCSharpRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    cs: CSharpState,
    /// `_options.dateTimeOnlyConverters` (the one option beyond
    /// `cSharpOptions`).
    date_time_only_converters: bool,
    /// `_needHelpers`.
    need_helpers: bool,
    /// `_needAttributes`.
    need_attributes: bool,
    /// `_needNamespaces`.
    need_namespaces: bool,
}

impl std::fmt::Debug for SystemTextJsonCSharpRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("SystemTextJsonCSharpRenderer")
            .field("cs", &self.cs)
            .finish_non_exhaustive()
    }
}

impl<'a> SystemTextJsonCSharpRenderer<'a> {
    /// `new SystemTextJsonCSharpRenderer(targetLanguage, renderContext,
    /// options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: CSharpOptions,
        date_time_only_converters: bool,
    ) -> Self {
        // `--just-types` wins over whatever `--features` says.
        let need_helpers = options.features.helpers && !options.just_types;
        let need_attributes = options.features.attributes && !options.just_types;
        let need_namespaces = options.features.namespaces;
        SystemTextJsonCSharpRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            cs: CSharpState::new(options),
            date_time_only_converters,
            need_helpers,
            need_attributes,
            need_namespaces,
        }
    }

    fn options(&self) -> &CSharpOptions {
        &self.cs.options
    }

    /// `needConverterClass`.
    fn need_converter_class(&self) -> Result<bool> {
        Ok(self.need_helpers
            || (self.need_attributes && (self.have_named_unions()? || self.have_enums()?)))
    }

    /// `converterForType(t)`: the converter a property of type `t` needs in
    /// its `[JsonConverter]` attribute, if any.
    fn converter_for_type(&self, t: TypeRef) -> Result<Option<Name>> {
        let graph = self.type_graph();
        let mut t = t;
        let mut xf = transformation_for_type(graph, t)?;

        if xf.is_none() && graph.type_at(t)?.is_union() {
            if let Some(maybe_nullable) = nullable_from_union(graph, t)? {
                t = maybe_nullable;
                xf = transformation_for_type(graph, t)?;
            }
        }

        let Some(xf) = xf else {
            return Ok(None);
        };

        if always_apply_transformation(graph, defined(downcast_transformation(xf.as_ref()))?)? {
            return Ok(None);
        }

        Ok(Some(defined(self.name_for_transformation(t)?)?))
    }

    /// `topLevelResultType(t)`: the "this" type can't be `dynamic`, so we
    /// have to force it to `object`.
    fn top_level_result_type(&self, t: TypeRef) -> Result<Source> {
        let graph = self.type_graph();
        let target_type = follow_target_type(graph, t)?;
        if graph.type_at(target_type)?.is_union() {
            return self.cs_type(target_type, Follow::Target, false);
        }
        if matches!(graph.kind(t)?, TypeKind::Any | TypeKind::None) {
            return Ok("object".into());
        }
        self.cs_type(t, Follow::Target, false)
    }

    /// `emitFromJsonForTopLevel(t, name)`.
    fn emit_from_json_for_top_level(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let graph = self.type_graph();
        if graph.type_at(t)?.is_enum() {
            return Ok(());
        }

        let (partial, type_kind) = match self.named_type_to_name_for_top_level(t)? {
            Some(defined_type) => (
                "partial ",
                if graph.type_at(defined_type)?.is_class() {
                    self.object_type_kind()
                } else {
                    "struct"
                },
            ),
            // Synthetic top-level wrapper (e.g. array/map roots); not a
            // user-facing data type, so always a class even with records.
            None => ("", "class"),
        };

        let cs_type = self.top_level_result_type(t)?;
        let baseclass = self.baseclass_for_type(t);
        let namespace = self.options().namespace.clone();
        self.emit_type(
            None,
            AccessModifier::Public,
            sl![partial, type_kind],
            name.into(),
            baseclass,
            |r| {
                // FIXME: Make FromJson a Named
                r.emit_expression_member(
                    sl!["public static ", cs_type.clone(), " FromJson(string json)"],
                    sl![
                        "global::System.Text.Json.JsonSerializer.Deserialize<",
                        cs_type,
                        ">(json, ",
                        namespace,
                        ".Converter.Settings)"
                    ],
                    false,
                )
            },
        )
    }

    /// `emitDecoderSwitch(emitBody)`.
    fn emit_decoder_switch(
        &mut self,
        emit_body: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_line("switch (reader.TokenType)");
        self.emit_block(emit_body, false)
    }

    /// `emitTokenCase(tokenType)`.
    fn emit_token_case(&mut self, token_type: &str) {
        self.emit_line_parts(vec![
            "case JsonTokenType.".into(),
            token_type.into(),
            ":".into(),
        ]);
    }

    /// `emitThrow(exceptionType, message)`.
    fn emit_throw(&mut self, exception_type: &str, message: Source) {
        self.emit_line_parts(vec![
            "throw new ".into(),
            exception_type.into(),
            "(".into(),
            message,
            ");".into(),
        ]);
    }

    /// `deserializeTypeCode(typeName)`: the reader's own getter for a C#
    /// type spelled as a plain string (`switch (typeName)` compares with
    /// `===`), else `JsonSerializer.Deserialize`.
    fn deserialize_type_code(type_name: Source) -> Source {
        if let Source::Text(text) = &type_name {
            match text.as_str() {
                "bool" => return sl!["reader.GetBoolean()"],
                "long" => return sl!["reader.GetInt64()"],
                "decimal" => return sl!["reader.GetDecimal()"],
                "double" => return sl!["reader.GetDouble()"],
                "string" => return sl!["reader.GetString()"],
                _ => {}
            }
        }
        sl![
            "JsonSerializer.Deserialize<",
            type_name,
            ">(ref reader, options)"
        ]
    }

    /// `serializeValueCode(value)`: `value !== "null"` compares with `===`.
    fn serialize_value_code(value: Source) -> Source {
        if !matches!(&value, Source::Text(text) if text == "null") {
            return sl!["JsonSerializer.Serialize(writer, ", value, ", options)"];
        }

        sl!["writer.WriteNullValue()"]
    }

    /// `emitSerializeClass()`.
    fn emit_serialize_class(&mut self) -> Result<()> {
        // FIXME: Make Serialize a Named
        self.emit_type(
            None,
            AccessModifier::Public,
            "static partial class".into(),
            "Serialize".into(),
            None,
            |r| {
                // Sometimes multiple top-levels will resolve to the same type, so we have to take care
                // not to emit more than one extension method for the same type.
                let mut seen_types: crate::support::fast_hash::HashSet<TypeRef> =
                    crate::support::fast_hash::HashSet::default();
                r.for_each_top_level(BlankLinePosition::None, |r, t, _, _| {
                    // FIXME: Make ToJson a Named
                    if seen_types.insert(t) {
                        let result_type = r.top_level_result_type(t)?;
                        let namespace = r.options().namespace.clone();
                        r.emit_expression_member(
                            sl!["public static string ToJson(this ", result_type, " self)"],
                            sl![
                                "JsonSerializer.Serialize(self, ",
                                namespace,
                                ".Converter.Settings)"
                            ],
                            false,
                        )?;
                    }
                    Ok(())
                })?;
                Ok(())
            },
        )
    }

    /// `emitCanConvert(expr)`.
    fn emit_can_convert(&mut self, expr: Source) -> Result<()> {
        self.emit_expression_member(
            "public override bool CanConvert(Type t)".into(),
            expr,
            false,
        )
    }

    /// `emitReadJson(emitBody, csType)`.
    fn emit_read_json(
        &mut self,
        emit_body: impl FnOnce(&mut Self) -> Result<()>,
        cs_type: Source,
    ) -> Result<()> {
        self.emit_line_parts(vec![
            "public override ".into(),
            cs_type,
            " Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)"
                .into(),
        ]);
        self.emit_block(emit_body, false)
    }

    /// `emitWriteJson(variable, emitBody, csType)`.
    fn emit_write_json(
        &mut self,
        variable: &str,
        emit_body: impl FnOnce(&mut Self) -> Result<()>,
        cs_type: Source,
    ) -> Result<()> {
        self.emit_line_parts(vec![
            "public override void Write(Utf8JsonWriter writer, ".into(),
            cs_type,
            " ".into(),
            variable.into(),
            ", JsonSerializerOptions options)".into(),
        ]);
        self.emit_block(emit_body, false)
    }

    /// `converterObject(converterName)`.
    fn converter_object(converter_name: Name) -> Source {
        // FIXME: Get a singleton
        sl![converter_name, ".Singleton"]
    }

    /// `emitConverterClass()`.
    fn emit_converter_class(&mut self) -> Result<()> {
        // FIXME: Make Converter a Named
        let converter_name = sl!["Converter"];
        self.emit_type(
            None,
            AccessModifier::Internal,
            "static partial class".into(),
            converter_name,
            None,
            |r| {
                // Do not use .Web as defaults. That turns on caseInsensitive property names and will fail the keywords test.
                r.emit_line(
                    "public static readonly JsonSerializerOptions Settings = new(JsonSerializerDefaults.General)",
                );
                r.emit_block(
                    |r| {
                        r.emit_line("Converters =");
                        r.emit_line("{");
                        r.indent(|r| {
                            let graph = r.type_graph();
                            let named: Vec<(TypeRef, Name)> = r
                                .types_with_named_transformations()
                                .iter()
                                .map(|(&t, &n)| (t, n))
                                .collect();
                            for (t, converter) in named {
                                if always_apply_transformation(graph, &transformation_of(graph, t)?)?
                                {
                                    r.emit_line_parts(vec![
                                        Self::converter_object(converter),
                                        ",".into(),
                                    ]);
                                }
                            }

                            if r.date_time_only_converters {
                                r.emit_line("new DateOnlyConverter(),");
                                r.emit_line("new TimeOnlyConverter(),");
                            }

                            r.emit_line("IsoDateTimeOffsetConverter.Singleton");
                            Ok(())
                        })?;
                        r.emit_line("},");
                        Ok(())
                    },
                    true,
                )
            },
        )
    }

    /// `emitDecoderTransformerCase(tokenCases, variableName, xfer,
    /// targetType, emitFinish, varGen)`.
    fn emit_decoder_transformer_case(
        &mut self,
        token_cases: &[&str],
        variable_name: &str,
        xfer: Option<&Rc<Transformer>>,
        target_type: TypeRef,
        emit_finish: Finish<'_, Self>,
        var_gen: &Cell<u32>,
    ) -> Result<()> {
        let Some(xfer) = xfer else {
            return Ok(());
        };

        for token_case in token_cases {
            self.emit_token_case(token_case);
        }

        self.indent(|r| {
            let all_handled =
                r.emit_decode_transformer(xfer, target_type, emit_finish, variable_name, var_gen)?;
            if !all_handled {
                r.emit_line("break;");
            }
            Ok(())
        })
    }

    /// `emitConsume(value, consumer, targetType, emitFinish)`.
    fn emit_consume(
        &mut self,
        value: Source,
        consumer: Option<&Rc<Transformer>>,
        target_type: TypeRef,
        emit_finish: Finish<'_, Self>,
    ) -> Result<bool> {
        let Some(consumer) = consumer else {
            emit_finish(self, value)?;
            return Ok(true);
        };

        self.emit_transformer(value, consumer, target_type, emit_finish)
    }

    /// `emitDecodeTransformer(xfer, targetType, emitFinish, variableName,
    /// varGen)`: `var_gen` numbers the variables of number cases.
    fn emit_decode_transformer(
        &mut self,
        xfer: &Transformer,
        target_type: TypeRef,
        emit_finish: Finish<'_, Self>,
        variable_name: &str,
        var_gen: &Cell<u32>,
    ) -> Result<bool> {
        let graph = self.type_graph();
        match xfer.data() {
            TransformerData::Decoding { consumer } => {
                let source = xfer.source_type_ref();
                if let Some(converter) = self.converter_for_type(target_type)? {
                    let type_source = self.cs_type(target_type, Follow::Target, false)?;
                    self.emit_line_parts(vec![
                        "var converter = ".into(),
                        Self::converter_object(converter),
                        ";".into(),
                    ]);
                    // The converter is for the non-null type, so if the target
                    // type is nullable we have to handle null ourselves.
                    let is_nullable = graph.type_at(target_type)?.is_union()
                        && nullable_from_union(graph, target_type)?.is_some();
                    self.emit_line_parts(vec![
                        "var ".into(),
                        variable_name.into(),
                        " = ".into(),
                        if is_nullable {
                            "reader.TokenType == JsonTokenType.Null ? null : "
                        } else {
                            ""
                        }
                        .into(),
                        "(".into(),
                        type_source.clone(),
                        ")converter.Read(ref reader, typeof(".into(),
                        type_source,
                        "), options);".into(),
                    ]);
                } else if graph.kind(source)? != TypeKind::Null {
                    let output = if graph.kind(target_type)? == TypeKind::Double {
                        target_type
                    } else {
                        source
                    };
                    let output_type = self.cs_type(output, Follow::Target, false)?;
                    self.emit_line_parts(vec![
                        "var ".into(),
                        variable_name.into(),
                        " = ".into(),
                        Self::deserialize_type_code(output_type),
                        ";".into(),
                    ]);
                }

                self.emit_consume(
                    variable_name.into(),
                    consumer.as_ref(),
                    target_type,
                    emit_finish,
                )
            }
            TransformerData::ArrayDecoding {
                item_target_type_ref,
                item_transformer,
                ..
            } => {
                // FIXME: Consume StartArray
                let target = graph.type_at(target_type)?;
                if !target.is_array() {
                    return panic("Array decoding must produce an array type");
                }

                // FIXME: handle EOF
                self.emit_line("reader.Read();");
                let items_type = self.cs_type(target.items()?, Follow::Target, false)?;
                self.emit_line_parts(vec![
                    "var ".into(),
                    variable_name.into(),
                    " = new List<".into(),
                    items_type,
                    ">();".into(),
                ]);
                self.emit_line("while (reader.TokenType != JsonTokenType.EndArray)");
                self.emit_block(
                    |r| {
                        r.emit_decode_transformer(
                            item_transformer,
                            *item_target_type_ref,
                            &|r: &mut Self, v: Source| {
                                r.emit_line_parts(vec![
                                    variable_name.into(),
                                    ".Add(".into(),
                                    v,
                                    ");".into(),
                                ]);
                                Ok(())
                            },
                            "arrayItem",
                            var_gen,
                        )?;
                        // FIXME: handle EOF
                        r.emit_line("reader.Read();");
                        Ok(())
                    },
                    false,
                )?;
                let mut result: Source = variable_name.into();
                if !self.options().use_list {
                    result = sl![result, ".ToArray()"];
                }

                emit_finish(self, result)?;
                Ok(true)
            }
            TransformerData::DecodingChoice(cases) => {
                self.emit_decoder_switch(|r| {
                    if let Some(null_transformer) = &cases.null {
                        r.emit_token_case("Null");
                        r.indent(|r| {
                            let all_handled = r.emit_decode_transformer(
                                null_transformer,
                                target_type,
                                emit_finish,
                                "null",
                                var_gen,
                            )?;
                            if !all_handled {
                                // No `;`: faithful to quicktype, which emits
                                // `break` without one here.
                                r.emit_line("break");
                            }
                            Ok(())
                        })?;
                    }

                    // Handle number (integer/double) union properly
                    match (&cases.integer, &cases.double) {
                        (Some(integer_transformer), Some(double_transformer)) => {
                            var_gen.set(var_gen.get() + 1);
                            let int_try_var = format!("intTryValue{}", var_gen.get());
                            var_gen.set(var_gen.get() + 1);
                            let int_var = format!("intValue{}", var_gen.get());
                            var_gen.set(var_gen.get() + 1);
                            let double_var = format!("doubleValue{}", var_gen.get());
                            r.emit_token_case("Number");
                            r.indent(|r| {
                                r.emit_line(format!(
                                    "if (reader.TryGetInt64(out long {int_try_var}))"
                                ));
                                r.emit_block(
                                    |r| {
                                        let all_handled = r.emit_decode_transformer(
                                            integer_transformer,
                                            target_type,
                                            emit_finish,
                                            &int_var,
                                            var_gen,
                                        )?;
                                        if !all_handled {
                                            r.emit_line("break;");
                                        }
                                        Ok(())
                                    },
                                    false,
                                )?;
                                r.emit_line("else");
                                r.emit_block(
                                    |r| {
                                        let all_handled = r.emit_decode_transformer(
                                            double_transformer,
                                            target_type,
                                            emit_finish,
                                            &double_var,
                                            var_gen,
                                        )?;
                                        if !all_handled {
                                            r.emit_line("break;");
                                        }
                                        Ok(())
                                    },
                                    false,
                                )
                            })?;
                        }
                        (Some(integer_transformer), None) => {
                            // Only one present, emit as before
                            var_gen.set(var_gen.get() + 1);
                            let int_var = format!("intValue{}", var_gen.get());
                            r.emit_decoder_transformer_case(
                                &["Number"],
                                &int_var,
                                Some(integer_transformer),
                                target_type,
                                emit_finish,
                                var_gen,
                            )?;
                        }
                        (None, Some(double_transformer)) => {
                            var_gen.set(var_gen.get() + 1);
                            let double_var = format!("doubleValue{}", var_gen.get());
                            r.emit_decoder_transformer_case(
                                &["Number"],
                                &double_var,
                                Some(double_transformer),
                                target_type,
                                emit_finish,
                                var_gen,
                            )?;
                        }
                        (None, None) => {}
                    }

                    r.emit_decoder_transformer_case(
                        &["True", "False"],
                        "boolValue",
                        cases.bool.as_ref(),
                        target_type,
                        emit_finish,
                        var_gen,
                    )?;
                    r.emit_decoder_transformer_case(
                        &["String"],
                        "stringValue",
                        cases.string.as_ref(),
                        target_type,
                        emit_finish,
                        var_gen,
                    )?;
                    r.emit_decoder_transformer_case(
                        &["StartObject"],
                        "objectValue",
                        cases.object.as_ref(),
                        target_type,
                        emit_finish,
                        var_gen,
                    )?;
                    r.emit_decoder_transformer_case(
                        &["StartArray"],
                        "arrayValue",
                        cases.array.as_ref(),
                        target_type,
                        emit_finish,
                        var_gen,
                    )
                })?;
                Ok(false)
            }
            _ => panic("Unknown transformer"),
        }
    }

    /// `stringCaseValue(t, stringCase)`.
    fn string_case_value(&self, t: TypeRef, string_case: &str) -> Result<Source> {
        let graph = self.type_graph();
        let kind = graph.kind(t)?;
        if kind == TypeKind::String {
            return Ok(sl!["\"", utf16_string_escape(string_case), "\""]);
        }
        if kind == TypeKind::Enum {
            return Ok(sl![
                self.name_for_named_type(t)?,
                ".",
                self.name_for_enum_case(t, string_case)?
            ]);
        }

        panic(format!("Type {kind} does not have string cases"))
    }

    /// `emitTransformer(variable, xfer, targetType, emitFinish)`: whether
    /// every path ends in `emitFinish`.
    fn emit_transformer(
        &mut self,
        variable: Source,
        xfer: &Transformer,
        target_type: TypeRef,
        emit_finish: Finish<'_, Self>,
    ) -> Result<bool> {
        let graph = self.type_graph();
        let direct_target_type = |continuation: Option<&Rc<Transformer>>| -> Result<TypeRef> {
            match continuation {
                None => Ok(target_type),
                Some(c) => follow_target_type(graph, c.source_type_ref()),
            }
        };

        match xfer.data() {
            TransformerData::Choice { transformers } => {
                let case_xfers = transformers;
                if case_xfers.len() > 1
                    && case_xfers
                        .iter()
                        .all(|x| matches!(x.data(), TransformerData::StringMatch { .. }))
                {
                    self.emit_line_parts(vec!["switch (".into(), variable.clone(), ")".into()]);
                    self.emit_block(
                        |r| {
                            for case_xfer in case_xfers {
                                let TransformerData::StringMatch {
                                    transformer,
                                    string_case,
                                } = case_xfer.data()
                                else {
                                    return panic("Expected a string match transformer");
                                };
                                let value = r.string_case_value(
                                    follow_target_type(graph, case_xfer.source_type_ref())?,
                                    string_case,
                                )?;
                                r.emit_line_parts(vec!["case ".into(), value, ":".into()]);
                                r.indent(|r| {
                                    let all_done = r.emit_transformer(
                                        variable.clone(),
                                        transformer,
                                        target_type,
                                        emit_finish,
                                    )?;
                                    if !all_done {
                                        r.emit_line("break;");
                                    }
                                    Ok(())
                                })?;
                            }
                            Ok(())
                        },
                        false,
                    )?;
                    // FIXME: Can we check for exhaustiveness?  For enums it should be easy.
                    return Ok(false);
                }

                for case_xfer in case_xfers {
                    self.emit_transformer(variable.clone(), case_xfer, target_type, emit_finish)?;
                }
            }
            TransformerData::UnionMemberMatch {
                transformer,
                member_type_ref,
            } => {
                let member_type = *member_type_ref;
                let source = xfer.source_type_ref();
                let member_kind = graph.kind(member_type)?;
                let maybe_nullable = nullable_from_union(graph, source)?;
                let test: Source;
                let mut member: Source;
                if maybe_nullable.is_some() {
                    if member_kind == TypeKind::Null {
                        test = sl![variable, " == null"];
                        member = "null".into();
                    } else {
                        test = sl![variable.clone(), " != null"];
                        member = variable;
                    }
                } else if member_kind == TypeKind::Null {
                    test = sl![variable, ".IsNull"];
                    member = "null".into();
                } else {
                    let member_name = self.name_for_union_member(source, member_type)?;
                    member = sl![variable, ".", member_name];
                    test = sl![member.clone(), " != null"];
                }

                if member_kind != TypeKind::Null && is_value_type(graph, member_type)? {
                    member = sl![member, ".Value"];
                }

                self.emit_line_parts(vec!["if (".into(), test, ")".into()]);
                self.emit_block(
                    |r| {
                        r.emit_transformer(member, transformer, target_type, emit_finish)?;
                        Ok(())
                    },
                    false,
                )?;
            }
            TransformerData::StringMatch {
                transformer,
                string_case,
            } => {
                let value = self.string_case_value(
                    follow_target_type(graph, xfer.source_type_ref())?,
                    string_case,
                )?;
                self.emit_line_parts(vec![
                    "if (".into(),
                    variable.clone(),
                    " == ".into(),
                    value,
                    ")".into(),
                ]);
                self.emit_block(
                    |r| {
                        r.emit_transformer(variable, transformer, target_type, emit_finish)?;
                        Ok(())
                    },
                    false,
                )?;
            }
            TransformerData::Encoding => {
                let source = xfer.source_type_ref();
                if let Some(converter) = self.converter_for_type(source)? {
                    self.emit_line_parts(vec![
                        "var converter = ".into(),
                        Self::converter_object(converter),
                        ";".into(),
                    ]);
                    // The converter is for the non-null type, so if the source
                    // type is nullable we have to handle null ourselves.
                    let maybe_nullable = if graph.type_at(source)?.is_union() {
                        nullable_from_union(graph, source)?
                    } else {
                        None
                    };
                    if let Some(maybe_nullable) = maybe_nullable {
                        let mut member = variable.clone();
                        if is_value_type(graph, follow_target_type(graph, maybe_nullable)?)? {
                            member = sl![member, ".Value"];
                        }

                        self.emit_line_parts(vec!["if (".into(), variable, " == null)".into()]);
                        self.emit_block(
                            |r| {
                                r.emit_line("writer.WriteNullValue();");
                                Ok(())
                            },
                            false,
                        )?;
                        self.emit_line("else");
                        self.emit_block(
                            |r| {
                                r.emit_line_parts(vec![
                                    "converter.Write(writer, ".into(),
                                    member,
                                    ", options);".into(),
                                ]);
                                Ok(())
                            },
                            false,
                        )?;
                    } else {
                        self.emit_line_parts(vec![
                            "converter.Write(writer, ".into(),
                            variable,
                            ", options);".into(),
                        ]);
                    }
                } else {
                    self.emit_line_parts(vec![Self::serialize_value_code(variable), ";".into()]);
                }

                emit_finish(self, sl![])?;
                return Ok(true);
            }
            TransformerData::ArrayEncoding {
                item_target_type_ref,
                item_transformer,
            } => {
                self.emit_line("writer.WriteStartArray();");
                let item_variable = "arrayItem";
                self.emit_line_parts(vec![
                    "foreach (var ".into(),
                    item_variable.into(),
                    " in ".into(),
                    variable,
                    ")".into(),
                ]);
                self.emit_block(
                    |r| {
                        r.emit_transformer(
                            item_variable.into(),
                            item_transformer,
                            *item_target_type_ref,
                            &|_: &mut Self, _: Source| Ok(()),
                        )?;
                        Ok(())
                    },
                    false,
                )?;
                self.emit_line("writer.WriteEndArray();");
                emit_finish(self, sl![])?;
                return Ok(true);
            }
            TransformerData::ParseString { consumer } => {
                let immediate_target_type = match consumer {
                    None => target_type,
                    Some(c) => c.source_type_ref(),
                };
                let consumer = consumer.as_ref();
                match graph.kind(immediate_target_type)? {
                    TypeKind::DateTime => {
                        self.emit_line("DateTimeOffset dt;");
                        self.emit_line_parts(vec![
                            "if (DateTimeOffset.TryParse(".into(),
                            variable,
                            ", out dt))".into(),
                        ]);
                        self.emit_block(
                            |r| {
                                r.emit_consume("dt".into(), consumer, target_type, emit_finish)?;
                                Ok(())
                            },
                            false,
                        )?;
                    }
                    TypeKind::Uuid => {
                        self.emit_line("Guid guid;");
                        self.emit_line_parts(vec![
                            "if (Guid.TryParse(".into(),
                            variable,
                            ", out guid))".into(),
                        ]);
                        self.emit_block(
                            |r| {
                                r.emit_consume("guid".into(), consumer, target_type, emit_finish)?;
                                Ok(())
                            },
                            false,
                        )?;
                    }
                    TypeKind::Uri => {
                        self.emit_line("try");
                        self.emit_block(
                            |r| {
                                // r.emit_line(sl!["var uri = new Uri(", variable, ");"]);
                                // The default value about:blank should never happen, but this way we avoid a null reference warning.
                                r.emit_line("var uri = new Uri(\"about:blank\");");
                                r.emit_line("if (!string.IsNullOrEmpty(stringValue))");
                                r.emit_block(
                                    |r| {
                                        r.emit_line_parts(vec![
                                            "uri = new Uri(".into(),
                                            variable,
                                            ");".into(),
                                        ]);
                                        Ok(())
                                    },
                                    false,
                                )?;
                                r.emit_consume("uri".into(), consumer, target_type, emit_finish)?;
                                Ok(())
                            },
                            false,
                        )?;
                        self.emit_line("catch (UriFormatException) {}");
                    }
                    TypeKind::Integer => {
                        self.emit_line("long l;");
                        self.emit_line_parts(vec![
                            "if (Int64.TryParse(".into(),
                            variable,
                            ", out l))".into(),
                        ]);
                        self.emit_block(
                            |r| {
                                r.emit_consume("l".into(), consumer, target_type, emit_finish)?;
                                Ok(())
                            },
                            false,
                        )?;
                    }
                    TypeKind::Bool => {
                        self.emit_line("bool b;");
                        self.emit_line_parts(vec![
                            "if (Boolean.TryParse(".into(),
                            variable,
                            ", out b))".into(),
                        ]);
                        self.emit_block(
                            |r| {
                                r.emit_consume("b".into(), consumer, target_type, emit_finish)?;
                                Ok(())
                            },
                            false,
                        )?;
                    }
                    kind => {
                        return panic(format!("Parsing string to {kind} not supported"));
                    }
                }
            }
            TransformerData::Stringify { consumer } => {
                let consumer = consumer.as_ref();
                return match graph.kind(xfer.source_type_ref())? {
                    TypeKind::DateTime => self.emit_consume(
                        sl![
                            variable,
                            ".ToString(\"o\", System.Globalization.CultureInfo.InvariantCulture)"
                        ],
                        consumer,
                        target_type,
                        emit_finish,
                    ),
                    TypeKind::Uuid => self.emit_consume(
                        sl![
                            variable,
                            ".ToString(\"D\", System.Globalization.CultureInfo.InvariantCulture)"
                        ],
                        consumer,
                        target_type,
                        emit_finish,
                    ),
                    TypeKind::Integer | TypeKind::Uri => self.emit_consume(
                        sl![variable, ".ToString()"],
                        consumer,
                        target_type,
                        emit_finish,
                    ),
                    TypeKind::Bool => {
                        self.emit_line_parts(vec![
                            "var boolString = ".into(),
                            variable,
                            " ? \"true\" : \"false\";".into(),
                        ]);
                        self.emit_consume("boolString".into(), consumer, target_type, emit_finish)
                    }
                    kind => panic(format!("Stringifying {kind} not supported")),
                };
            }
            TransformerData::StringProducer { consumer, result } => {
                let value =
                    self.string_case_value(direct_target_type(consumer.as_ref())?, result)?;
                return self.emit_consume(value, consumer.as_ref(), target_type, emit_finish);
            }
            TransformerData::MinMaxLengthCheck {
                consumer,
                min_length,
                max_length,
            } => {
                let length = sl![
                    "System.Linq.Enumerable.Count(",
                    variable.clone(),
                    "!, c => !char.IsLowSurrogate(c))"
                ];
                let mut conditions: Vec<Source> = Vec::new();

                if let Some(min) = min_length {
                    conditions.push(sl![length.clone(), " >= ", number::to_string(*min)]);
                }

                if let Some(max) = max_length {
                    conditions.push(sl![length, " <= ", number::to_string(*max)]);
                }

                self.emit_line_parts(vec![
                    "if (".into(),
                    array_intercalate(" && ".into(), conditions).into(),
                    ")".into(),
                ]);
                self.emit_block(
                    |r| {
                        r.emit_consume(variable, consumer.as_ref(), target_type, emit_finish)?;
                        Ok(())
                    },
                    false,
                )?;
                return Ok(false);
            }
            TransformerData::MinMaxValue {
                consumer,
                minimum,
                maximum,
            } => {
                let suffix = if self.options().use_decimal { "m" } else { "" };
                let mut conditions: Vec<Source> = Vec::new();

                if let Some(min) = minimum {
                    conditions.push(sl![
                        variable.clone(),
                        " >= ",
                        format!("{}{suffix}", number::to_string(*min))
                    ]);
                }

                if let Some(max) = maximum {
                    conditions.push(sl![
                        variable.clone(),
                        " <= ",
                        format!("{}{suffix}", number::to_string(*max))
                    ]);
                }

                self.emit_line_parts(vec![
                    "if (".into(),
                    array_intercalate(" && ".into(), conditions).into(),
                    ")".into(),
                ]);
                self.emit_block(
                    |r| {
                        r.emit_consume(variable, consumer.as_ref(), target_type, emit_finish)?;
                        Ok(())
                    },
                    false,
                )?;
                return Ok(false);
            }
            TransformerData::UnionInstantiation => {
                if !graph.type_at(target_type)?.is_union() {
                    return panic("Union instantiation transformer must produce a union type");
                }

                if nullable_from_union(graph, target_type)?.is_some() {
                    emit_finish(self, variable)?;
                } else {
                    let union_name = self.name_for_named_type(target_type)?;
                    let source = xfer.source_type_ref();
                    let initializer: Source = if graph.kind(source)? == TypeKind::Null {
                        " ".into()
                    } else {
                        let member_name = self.name_for_union_member(target_type, source)?;
                        sl![" ", member_name, " = ", variable, " "]
                    };

                    emit_finish(self, sl!["new ", union_name, " {", initializer, "}"])?;
                }

                return Ok(true);
            }
            TransformerData::Decoding { .. }
            | TransformerData::ArrayDecoding { .. }
            | TransformerData::DecodingChoice(_) => {
                return panic("Unknown transformer");
            }
        }

        Ok(false)
    }

    /// `emitTransformation(converterName, t)`.
    fn emit_transformation(&mut self, converter_name: Name, t: TypeRef) -> Result<()> {
        let graph = self.type_graph();
        let xf = transformation_of(graph, t)?;
        let reverse = xf.reverse(graph)?;
        let target_type = xf.target_type_ref();
        let xfer = Rc::clone(xf.transformer());
        let cs_type = self.cs_type(target_type, Follow::Target, false)?;
        self.emit_type(
            None,
            AccessModifier::Internal,
            "class".into(),
            converter_name.into(),
            Some(sl!["JsonConverter<", cs_type.clone(), ">"]),
            |r| {
                let can_convert_expr = sl!["t == typeof(", cs_type.clone(), ")"];
                r.emit_can_convert(can_convert_expr)?;
                r.ensure_blank_line();
                r.emit_read_json(
                    |r| {
                        // FIXME: It's unsatisfying that we need this.  The reason is that we not
                        // only match T, but also T?.  If we didn't, then the T in T? would not be
                        // deserialized with our converter but with the default one.  Can we check
                        // whether the type is a nullable?
                        // FIXME: This could duplicate one of the cases handled below in
                        // `emitDecodeTransformer`.
                        let all_handled = r.emit_decode_transformer(
                            &xfer,
                            target_type,
                            &|r: &mut Self, v: Source| {
                                r.emit_line_parts(vec!["return ".into(), v, ";".into()]);
                                Ok(())
                            },
                            "value",
                            &Cell::new(0),
                        )?;
                        if !all_handled {
                            r.emit_throw(
                                "JsonException",
                                sl!["\"Cannot unmarshal type ", cs_type.clone(), "\""],
                            );
                        }
                        Ok(())
                    },
                    cs_type.clone(),
                )?;
                r.ensure_blank_line();
                r.emit_write_json(
                    "value",
                    |r| {
                        // FIXME: See above.
                        let all_handled = r.emit_transformer(
                            "value".into(),
                            reverse.transformer(),
                            reverse.target_type_ref(),
                            &|r: &mut Self, _: Source| {
                                r.emit_line("return;");
                                Ok(())
                            },
                        )?;
                        if !all_handled {
                            r.emit_throw(
                                "NotSupportedException",
                                sl!["\"Cannot marshal type ", cs_type.clone(), "\""],
                            );
                        }
                        Ok(())
                    },
                    cs_type.clone(),
                )?;
                r.ensure_blank_line();
                r.emit_line_parts(vec![
                    "public static readonly ".into(),
                    converter_name.into(),
                    " Singleton = new ".into(),
                    converter_name.into(),
                    "();".into(),
                ]);
                Ok(())
            },
        )
    }

    /// `emitDateTimeOnlyConverters()`.
    fn emit_date_time_only_converters(&mut self) -> Result<()> {
        self.emit_multiline(DATE_TIME_ONLY_CONVERTERS)
    }

    /// `emitIsoDateTimeOffsetConverter()`.
    fn emit_iso_date_time_offset_converter(&mut self) -> Result<()> {
        self.ensure_blank_line();
        self.emit_multiline(ISO_DATE_TIME_OFFSET_CONVERTER)
    }
}

/// The hooks `SystemTextJsonCSharpRenderer` overrides, on top of
/// [`c_sharp_hooks`](super::c_sharp_renderer::c_sharp_hooks).
mod system_text_json_hooks {
    pub use crate::language::csharp::c_sharp_renderer::c_sharp_hooks::*;

    use super::SystemTextJsonCSharpRenderer;
    use crate::attributes::type_attributes::TransformationAttribute;
    use crate::convenience_renderer::prelude::*;
    use crate::convenience_renderer::{ForbiddenWordsInfo, INFERRED_NAME_ORDER};
    use crate::language::csharp::c_sharp_renderer::{BaseClass, c_sharp_hooks};
    use crate::support::support::defined;
    use crate::transformers::{TransformerData, downcast_transformation};
    use std::rc::Rc;

    /// `forbiddenNamesForGlobalNamespace()`.
    pub fn forbidden_names_for_global_namespace(
        r: &mut SystemTextJsonCSharpRenderer<'_>,
    ) -> Result<Vec<String>> {
        let mut forbidden: Vec<String> = [
            "Converter",
            "JsonConverter",
            "JsonSerializer",
            "JsonWriter",
            "JsonToken",
            "Serialize",
            "JsonSerializerOptions",
            "JsonException",
            "JsonTokenType",
            "Utf8JsonReader",
            "Utf8JsonWriter",
            "CultureInfo",
            "DateOnly",
            "TimeOnly",
            "DateOnlyConverter",
            "TimeOnlyConverter",
            "IsoDateTimeOffsetConverter",
            // "Newtonsoft",
            // "MetadataPropertyHandling",
            // "DateParseHandling",
            "FromJson",
            "Required",
        ]
        .map(str::to_owned)
        .to_vec();
        if r.cs.options.dense {
            forbidden.extend(["J", "R", "N"].map(str::to_owned));
        }

        if let Some(baseclass) = r.cs.options.baseclass.and_then(BaseClass::forbidden_name) {
            forbidden.push(baseclass.to_owned());
        }

        let mut names = c_sharp_hooks::forbidden_names_for_global_namespace(r)?;
        names.extend(forbidden);
        Ok(names)
    }

    /// `forbiddenForObjectProperties(c, className)`.
    pub fn forbidden_for_object_properties(
        r: &mut SystemTextJsonCSharpRenderer<'_>,
        c: TypeRef,
        class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let mut result = c_sharp_hooks::forbidden_for_object_properties(r, c, class_name)?;
        result
            .names
            .extend(["ToJson", "FromJson", "Required"].map(Into::into));
        Ok(result)
    }

    /// `makeNameForTransformation(xf, typeName)`.
    pub fn make_name_for_transformation(
        r: &mut SystemTextJsonCSharpRenderer<'_>,
        xf: &Rc<dyn TransformationAttribute>,
        type_name: Option<Name>,
    ) -> Result<Option<Name>> {
        let naming_function = r.cs.naming_function.clone();
        let Some(type_name) = type_name else {
            let xf = defined(downcast_transformation(xf.as_ref()))?;
            let mut xfer = xf.transformer();
            if let TransformerData::Decoding {
                consumer: Some(consumer),
            } = xfer.data()
            {
                xfer = consumer;
            }

            let kind = xfer.kind();
            return Ok(Some(r.naming_mut().simple_name(
                [format!("{kind}_converter")],
                &naming_function,
                INFERRED_NAME_ORDER + 30,
            )));
        };

        let order = r.naming().order(type_name) + 30;
        Ok(Some(r.naming_mut().dependency_name(
            Some(&naming_function),
            order,
            move |lookup| format!("{}_converter", lookup(type_name)),
        )))
    }

    /// `makeNamedTypeDependencyNames(t, name)`.
    pub fn make_named_type_dependency_names(
        r: &mut SystemTextJsonCSharpRenderer<'_>,
        t: TypeRef,
        name: Name,
    ) -> Result<Vec<Name>> {
        if !r.type_graph().type_at(t)?.is_enum() {
            return Ok(Vec::new());
        }

        let naming_function = r.cs.naming_function.clone();
        let order = r.naming().order(name) + 30;
        let extensions_name =
            r.naming_mut()
                .dependency_name(Some(&naming_function), order, move |lookup| {
                    format!("{}_extensions", lookup(name))
                });
        // TypeScript also records it in `_enumExtensionsNames`, which
        // nothing reads.
        Ok(vec![extensions_name])
    }
}

impl<'a> ConvenienceRenderer<'a> for SystemTextJsonCSharpRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(system_text_json_hooks);
}

impl<'a> CSharpRenderer<'a> for SystemTextJsonCSharpRenderer<'a> {
    fn cs(&self) -> &CSharpState {
        &self.cs
    }

    fn emit_usings(&mut self) -> Result<()> {
        if !self.need_attributes && !self.need_helpers {
            return self.emit_dependency_usings();
        }

        emit_usings(self)?;
        self.ensure_blank_line();

        for ns in ["System.Text.Json", "System.Text.Json.Serialization"] {
            self.emit_using(ns);
        }

        if self.need_converter_class()? {
            self.emit_using("System.Globalization");
        }

        if self.options().dense {
            self.emit_using(sl![
                DENSE_JSON_PROPERTY_NAME,
                " = System.Text.Json.Serialization.JsonPropertyNameAttribute"
            ]);
            // this.emitUsing([denseRequiredEnumName, " = Newtonsoft.Json.Required"]);
            self.emit_using(sl![
                DENSE_NULL_VALUE_HANDLING_ENUM_NAME,
                " = System.Text.Json.Serialization.JsonIgnoreCondition"
            ]);
        }

        if self.options().baseclass == Some(BaseClass::EntityData) {
            self.emit_using("Microsoft.Azure.Mobile.Server");
        }
        Ok(())
    }

    fn baseclass_for_type(&self, _t: TypeRef) -> Option<Source> {
        self.options().baseclass.map(Source::from)
    }

    fn emit_default_following_comments(&mut self) -> Result<()> {
        if !self.need_helpers {
            return Ok(());
        }

        self.emit_line("#pragma warning restore CS8618");
        self.emit_line("#pragma warning restore CS8601");
        self.emit_line("#pragma warning restore CS8602");
        self.emit_line("#pragma warning restore CS8603");
        Ok(())
    }

    fn emit_default_leading_comments(&mut self) -> Result<()> {
        self.emit_line("// <auto-generated />");
        self.emit_line("//");

        if !self.need_helpers {
            return Ok(());
        }
        let one_top_level = self.top_levels().len() == 1;
        self.emit_line_parts(vec![
            "// To parse this JSON data, add NuGet 'System.Text.Json' then do".into(),
            if one_top_level { "" } else { " one of these" }.into(),
            ":".into(),
        ]);
        self.emit_line("//");
        let namespace = self.options().namespace.clone();
        self.emit_line_parts(vec!["//    using ".into(), namespace.into(), ";".into()]);
        self.emit_line("//");
        self.for_each_top_level(BlankLinePosition::None, |r, t, top_level_name, _| {
            let rhs = if r.type_graph().type_at(t)?.is_enum() {
                sl![
                    "JsonSerializer.Deserialize<",
                    top_level_name,
                    ">(jsonString)"
                ]
            } else {
                sl![top_level_name, ".FromJson(jsonString)"]
            };

            r.emit_line_parts(vec![
                "//    var ".into(),
                modify_source(camel_case, top_level_name),
                " = ".into(),
                rhs,
                ";".into(),
            ]);
            Ok(())
        })?;

        // fix: should this be an option? Or respond to an existing option?
        self.emit_line("#nullable enable");
        self.emit_line("#pragma warning disable CS8618");
        self.emit_line("#pragma warning disable CS8601");
        // CS8602: the emitted constraint-check converters dereference
        // Deserialize<T>() results, which are nullable under NRT.
        self.emit_line("#pragma warning disable CS8602");
        self.emit_line("#pragma warning disable CS8603");
        Ok(())
    }

    fn attributes_for_property(
        &self,
        property: &ClassProperty,
        _name: Name,
        _c: TypeRef,
        json_name: &str,
    ) -> Result<Option<Vec<Source>>> {
        if !self.need_attributes {
            return Ok(None);
        }

        let graph = self.type_graph();
        let options = self.options();
        let mut attributes: Vec<Source> = Vec::new();

        let json_property_name = if options.dense {
            DENSE_JSON_PROPERTY_NAME
        } else {
            "JsonPropertyName"
        };
        let escaped_name = utf16_string_escape(json_name);
        let is_nullable = is_nullable(graph, follow_target_type(graph, property.type_ref)?)?;
        let is_optional = property.is_optional;

        // [JsonRequired] makes deserialization fail if the property is
        // missing from the JSON.  It requires System.Text.Json 7.0 or
        // later (.NET 7+).
        if options.check_required && !is_optional {
            attributes.push(sl!["[JsonRequired]"]);
        }

        if is_optional && !is_nullable {
            attributes.push(sl![
                "[",
                "JsonIgnore",
                "(Condition = JsonIgnoreCondition.WhenWritingNull)]"
            ]);
        }

        attributes.push(sl!["[", json_property_name, "(\"", escaped_name, "\")]"]);

        if let Some(converter) = self.converter_for_type(property.type_ref)? {
            attributes.push(sl!["[JsonConverter(typeof(", converter, "))]"]);
        }

        Ok(Some(attributes))
    }

    fn blank_lines_between_attributes(&self) -> bool {
        self.need_attributes && !self.options().dense
    }

    fn emit_required_helpers(&mut self) -> Result<()> {
        if self.need_helpers {
            self.for_each_top_level(BlankLinePosition::LeadingAndInterposing, |r, t, n, _| {
                r.emit_from_json_for_top_level(t, n)
            })?;
            self.ensure_blank_line();
            self.emit_serialize_class()?;
        }

        if self.need_converter_class()? {
            self.ensure_blank_line();
            self.emit_converter_class()?;
            self.for_each_transformation(
                BlankLinePosition::LeadingAndInterposing,
                |r, n, t, _| r.emit_transformation(n, t),
            )?;
            if self.date_time_only_converters {
                self.emit_date_time_only_converters()?;
            }

            self.emit_iso_date_time_offset_converter()?;
        }
        Ok(())
    }

    fn need_namespace(&self) -> bool {
        self.need_namespaces
    }
}

/// `emitDateTimeOnlyConverters()`'s template.
pub const DATE_TIME_ONLY_CONVERTERS: &str = r#"
public class DateOnlyConverter : JsonConverter<DateOnly>
{
	private readonly string serializationFormat;
	public DateOnlyConverter() : this(null) { }

	public DateOnlyConverter(string? serializationFormat)
	{
			this.serializationFormat = serializationFormat ?? "yyyy-MM-dd";
	}

	public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
	{
			var value = reader.GetString();
			return DateOnly.Parse(value!);
	}

	public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
			=> writer.WriteStringValue(value.ToString(serializationFormat));
}

public class TimeOnlyConverter : JsonConverter<TimeOnly>
{
	private readonly string serializationFormat;

	public TimeOnlyConverter() : this(null) { }

	public TimeOnlyConverter(string? serializationFormat)
	{
			this.serializationFormat = serializationFormat ?? "HH:mm:ss.fff";
	}

	public override TimeOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
	{
			var value = reader.GetString();
			return TimeOnly.Parse(value!);
	}

	public override void Write(Utf8JsonWriter writer, TimeOnly value, JsonSerializerOptions options)
			=> writer.WriteStringValue(value.ToString(serializationFormat));
}"#;

/// `emitIsoDateTimeOffsetConverter()`'s template.
pub const ISO_DATE_TIME_OFFSET_CONVERTER: &str = r#"internal class IsoDateTimeOffsetConverter : JsonConverter<DateTimeOffset>
{
	public override bool CanConvert(Type t) => t == typeof(DateTimeOffset);

	private const string DefaultDateTimeFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.FFFFFFFK";

	private DateTimeStyles _dateTimeStyles = DateTimeStyles.RoundtripKind;
	private string? _dateTimeFormat;
	private CultureInfo? _culture;

	public DateTimeStyles DateTimeStyles
	{
			get => _dateTimeStyles;
			set => _dateTimeStyles = value;
	}

	public string? DateTimeFormat
	{
			get => _dateTimeFormat ?? string.Empty;
			set => _dateTimeFormat = (string.IsNullOrEmpty(value)) ? null : value;
	}

	public CultureInfo Culture
	{
			get => _culture ?? CultureInfo.CurrentCulture;
			set => _culture = value;
	}

	public override void Write(Utf8JsonWriter writer, DateTimeOffset value, JsonSerializerOptions options)
	{
			string text;


			if ((_dateTimeStyles & DateTimeStyles.AdjustToUniversal) == DateTimeStyles.AdjustToUniversal
					|| (_dateTimeStyles & DateTimeStyles.AssumeUniversal) == DateTimeStyles.AssumeUniversal)
			{
					value = value.ToUniversalTime();
			}

			text = value.ToString(_dateTimeFormat ?? DefaultDateTimeFormat, Culture);

			writer.WriteStringValue(text);
	}

	public override DateTimeOffset Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
	{
			string? dateText = reader.GetString();
			
			if (string.IsNullOrEmpty(dateText) == false)
			{
					if (!string.IsNullOrEmpty(_dateTimeFormat))
					{
							return DateTimeOffset.ParseExact(dateText, _dateTimeFormat, Culture, _dateTimeStyles);
					}
					else
					{
							return DateTimeOffset.Parse(dateText, Culture, _dateTimeStyles);
					}
			}
			else
			{
					throw new JsonException("Cannot unmarshal date-time");
			}
	}


	public static readonly IsoDateTimeOffsetConverter Singleton = new IsoDateTimeOffsetConverter();
}"#;
