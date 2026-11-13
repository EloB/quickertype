//! Port of `packages/quicktype-core/src/language/Scala3/CirceRenderer.ts`.
//!
//! Scala 3 types with circe codecs: derived codecs for case classes,
//! string codecs for enums and decoder chains for untagged unions.

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::strings::{string_escape, utf16_string_escape};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::scala3_renderer::{
    Scala3Options, Scala3RendererFamily, Scala3State, scala3_hooks, scala3_methods, unsupported,
};
use super::utils::{property_name_needs_mapping, union_member_sort_order, wrap_option};

/// `CirceRenderer`.
pub struct CirceRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    scala3: Scala3State,
    /// `seenUnionTypes`: the unions whose codecs were already emitted, as
    /// their `A | B` strings.
    seen_union_types: Vec<String>,
}

impl std::fmt::Debug for CirceRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CirceRenderer")
            .field("scala3", &self.scala3)
            .finish_non_exhaustive()
    }
}

impl<'a> CirceRenderer<'a> {
    /// `new CirceRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: Scala3Options,
    ) -> Self {
        CirceRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            scala3: Scala3State::new(options),
            seen_union_types: Vec::new(),
        }
    }

    /// `circeEncoderForType(t, _, noOptional, paramName)`.
    fn circe_encoder_for_type(
        &self,
        t: TypeRef,
        no_optional: bool,
        param_name: &str,
    ) -> Result<Source> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        let call = |encoder: &str| sl![encoder, "(", param_name, ")"];
        Ok(match ty.kind() {
            TypeKind::Any => call("Encoder.encodeJson"),
            TypeKind::Null => call("Encoder.encodeNone"),
            TypeKind::Bool => call("Encoder.encodeBoolean"),
            TypeKind::Integer => call("Encoder.encodeLong"),
            TypeKind::Double => call("Encoder.encodeDouble"),
            TypeKind::String => call("Encoder.encodeString"),
            TypeKind::Array => sl![
                "Encoder.encodeSeq[",
                self.scala_type(ty.items()?, false, false)?,
                "].apply(",
                param_name,
                ")"
            ],
            TypeKind::Class => sl![
                "Encoder.AsObject[",
                self.scala_type(t, false, false)?,
                "].apply(",
                param_name,
                ")"
            ],
            TypeKind::Map => sl![
                "Encoder.encodeMap[String,",
                self.scala_type(ty.map_values()?, false, false)?,
                "].apply(",
                param_name,
                ")"
            ],
            TypeKind::Enum => sl![
                "summon[Encoder[",
                self.scala_type(t, false, false)?,
                "]].apply(",
                param_name,
                ")"
            ],
            TypeKind::Union => {
                if let Some(nullable) = nullable_from_union(graph, t)? {
                    if no_optional {
                        return Ok(sl![
                            "Encoder.AsObject[",
                            self.name_for_named_type(nullable)?,
                            "]"
                        ]);
                    }
                    return Ok(sl![
                        "Encoder.AsObject[Option[",
                        self.name_for_named_type(nullable)?,
                        "]]"
                    ]);
                }
                sl!["Encoder.AsObject[", self.name_for_named_type(t)?, "]"]
            }
            kind if kind.is_transformed_string_type_kind() => sl![
                "summon[Encoder[",
                self.scala_type(t, false, false)?,
                "]].apply(",
                param_name,
                ")"
            ],
            kind => return unsupported(kind),
        })
    }

    /// `renamedProperties(c)`: the properties whose JSON names need a
    /// mapping.
    fn renamed_properties(&mut self, c: TypeRef) -> Result<Vec<(Name, String)>> {
        let mut renamed = Vec::new();
        self.for_each_class_property(c, BlankLinePosition::None, |_, name, json_name, _, _| {
            if property_name_needs_mapping(json_name)? {
                renamed.push((name, json_name.to_owned()));
            }
            Ok(())
        })?;
        Ok(renamed)
    }
}

impl<'a> ConvenienceRenderer<'a> for CirceRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(scala3_hooks);
}

impl<'a> Scala3RendererFamily<'a> for CirceRenderer<'a> {
    fn scala3(&self) -> &Scala3State {
        &self.scala3
    }

    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.ensure_blank_line();
        self.emit_line(sl![
            "case class ",
            class_name,
            "()  derives Encoder.AsObject, Decoder"
        ]);
        Ok(())
    }

    fn any_source_type(&self, optional: bool) -> Source {
        sl![wrap_option("Json", optional)]
    }

    fn emit_class_definition_methods(&mut self, c: TypeRef, _class_name: Name) -> Result<()> {
        let line = if self.renamed_properties(c)?.is_empty() {
            ") derives Encoder.AsObject, Decoder"
        } else {
            ")"
        };
        self.emit_line(line);
        Ok(())
    }

    /// A configured codec that maps the renamed properties.
    fn emit_class_definition_postamble(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let renamed = self.renamed_properties(c)?;
        if renamed.is_empty() {
            return Ok(());
        }

        self.ensure_blank_line();
        self.emit_line(sl!["object ", class_name, ":"]);
        self.indent(|r| {
            r.emit_line("given io.circe.derivation.Configuration =");
            r.indent(|r| {
                r.emit_line("io.circe.derivation.Configuration.default.withTransformMemberNames(");
                r.indent(|r| {
                    r.emit_line("io.circe.derivation.renaming.replaceWith(");
                    r.indent(|r| {
                        let len = renamed.len();
                        for (index, (name, json_name)) in renamed.iter().enumerate() {
                            r.emit_line(sl![
                                "\"",
                                *name,
                                format!("\" -> \"{}\"", utf16_string_escape(json_name)),
                                if index == len - 1 { "" } else { "," }
                            ]);
                        }
                        Ok(())
                    })?;
                    r.emit_line(")");
                    Ok(())
                })?;
                r.emit_line(")");
                Ok(())
            })?;
            r.emit_line(sl![
                "given io.circe.Codec.AsObject[",
                class_name,
                "] = io.circe.derivation.ConfiguredCodec.derived"
            ]);
            Ok(())
        })?;
        self.ensure_blank_line();
        Ok(())
    }

    /// An `enum` of styled cases with string codecs mapping them to the
    /// JSON strings.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.ensure_blank_line();

        self.emit_line(sl!["enum ", enum_name, " : "]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                r.emit_line(sl!["case ", name]);
                Ok(())
            })
        })?;
        self.ensure_blank_line();

        self.emit_line(sl![
            "given Decoder[",
            enum_name,
            "] = Decoder.decodeString.emap {"
        ]);
        self.indent(|r| {
            // `scala.` in case a generated type is named Right/Left.
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                r.emit_line(sl![
                    format!("case \"{}\" => scala.Right(", string_escape(json_name)),
                    enum_name,
                    ".",
                    name,
                    ")"
                ]);
                Ok(())
            })?;
            r.emit_line(sl![
                "case other => scala.Left(\"invalid ",
                enum_name,
                ": \" + other)"
            ]);
            Ok(())
        })?;
        self.emit_line("}");
        self.emit_line(sl![
            "given Encoder[",
            enum_name,
            "] = Encoder.encodeString.contramap {"
        ]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                r.emit_line(sl![
                    "case ",
                    enum_name,
                    ".",
                    name,
                    format!(" => \"{}\"", string_escape(json_name))
                ]);
                Ok(())
            })
        })?;
        self.emit_line("}");
        self.ensure_blank_line();
        Ok(())
    }

    fn emit_header(&mut self) -> Result<()> {
        scala3_methods::emit_header(self)?;

        self.emit_line("import io.circe.syntax._");
        self.emit_line("import io.circe._");
        self.emit_line("import cats.syntax.functor._");
        self.ensure_blank_line();

        self.emit_line("// If a union has a null in, then we'll need this too... ");
        self.emit_line("type NullValue = None.type");
        Ok(())
    }

    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        scala3_methods::emit_top_level_array(self, t, name)?;
        let items = self.type_graph().type_at(t)?.items()?;
        let element_type = self.scala_type(items, false, false)?;
        self.emit_line(sl![
            "given (using ev : ",
            element_type.clone(),
            "): Encoder[Seq[",
            element_type.clone(),
            "]] = Encoder.encodeSeq[",
            element_type,
            "]"
        ]);
        Ok(())
    }

    fn emit_top_level_map(&mut self, t: TypeRef, name: Name) -> Result<()> {
        scala3_methods::emit_top_level_map(self, t, name)?;
        let values = self.type_graph().type_at(t)?.map_values()?;
        let element_type = self.scala_type(values, false, false)?;
        self.ensure_blank_line();
        self.emit_line(sl![
            "given (using ev : ",
            element_type.clone(),
            "): Encoder[Map[String, ",
            element_type.clone(),
            "]] = Encoder.encodeMap[String, ",
            element_type,
            "]"
        ]);
        Ok(())
    }

    /// The type alias, and, for the first union with these members, a
    /// decoder trying each member and an encoder matching on them.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;

        let (maybe_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        let the_types = scala3_methods::union_member_types(self, u, maybe_null, &non_nulls)?;
        scala3_methods::emit_union_type_alias(self, union_name, &the_types);
        let this_union_type = the_types
            .iter()
            .map(|x| self.sourcelike_to_string(x))
            .collect::<Result<Vec<_>>>()?
            .join(" | ");

        self.ensure_blank_line();
        if self.seen_union_types.contains(&this_union_type) {
            return Ok(());
        }
        self.seen_union_types.push(this_union_type);

        // The decoders are tried in order, most discriminating first (see
        // `unionMemberSortOrder`): circe's numeric decoders accept strings
        // like "5", so the string decoder has to get a shot before them.
        let mut source_like_types: Vec<(Source, TypeRef)> = Vec::new();
        let sort_order = |r: &Self, _: Name, t: TypeRef| -> Result<String> {
            Ok(union_member_sort_order(r.type_graph().kind(t)?))
        };
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            Some(&sort_order),
            |r, _, t, _| {
                source_like_types.push((r.scala_type(t, false, false)?, t));
                Ok(())
            },
        )?;
        if let Some(null_type) = maybe_null {
            source_like_types.push((self.name_for_union_member(u, null_type)?.into(), null_type));
        }

        self.emit_line(sl!["given Decoder[", union_name, "] = {"]);
        self.indent(|r| {
            r.emit_line(sl!["List[Decoder[", union_name, "]]("]);
            r.indent(|r| {
                for (source, _) in &source_like_types {
                    r.emit_line(sl!["Decoder[", source.clone(), "].widen,"]);
                }
                Ok(())
            })?;
            r.emit_line(").reduceLeft(_ or _)");
            Ok(())
        })?;
        self.emit_line(sl!["}"]);

        self.ensure_blank_line();

        self.emit_line(sl!["given Encoder[", union_name, "] = Encoder.instance {"]);
        self.indent(|r| {
            for (i, (source, t)) in source_like_types.iter().enumerate() {
                let param_temp = format!("enc{i}");
                let encoder = r.circe_encoder_for_type(*t, false, &param_temp)?;
                r.emit_line(sl![
                    "case ",
                    param_temp,
                    " : ",
                    source.clone(),
                    " => ",
                    encoder
                ]);
            }
            Ok(())
        })?;
        self.emit_line("}");
        Ok(())
    }
}
