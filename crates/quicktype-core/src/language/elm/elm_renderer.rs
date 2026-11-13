//! Port of `packages/quicktype-core/src/language/Elm/ElmRenderer.ts`.
//!
//! Renders Elm type aliases and custom types with `Json.Decode.Pipeline`
//! decoders and encoders. Types, union members and enum cases share the
//! global namespace; every top-level and named type gets encoder and
//! decoder names that depend on its own name.

use std::rc::Rc;

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::renderer_options::RendererOptions;
use crate::source::{MultiWord, annotated, multi_word, paren_if_needed, single_word};
use crate::support::comments::{Comment, CommentOptions};
use crate::support::fast_hash::HashMap;
use crate::support::recursion::guard;
use crate::support::strings::decapitalize;
use crate::support::support::defined;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{is_nullable, nullable_from_union};
use quicktype_js_compat::number::to_string as js_number;

use super::constants::FORBIDDEN_NAMES;
use super::language::{JUST_TYPES, MODULE_NAME, USE_LIST};
use super::utils::{
    elm_string_escape, lower_naming_function, required_or_optional, upper_naming_function,
};

/// The option values of the Elm renderer (TS
/// `OptionValues<typeof elmOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct ElmOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `useList`: `true` for `--array-type list`.
    pub use_list: bool,
    /// `moduleName`.
    pub module_name: String,
}

impl ElmOptions {
    /// `getOptionValues(elmOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let just_types = JUST_TYPES.get_value(values);
        // TS truthiness: an `Object.prototype` member acts as `list`.
        let use_list = USE_LIST.get_flag(values, "list")?;
        Ok(ElmOptions {
            just_types,
            use_list,
            module_name: MODULE_NAME.get_value(values).into_owned(),
        })
    }
}

/// `TopLevelDependent`: the encoder and, unless a named type takes the
/// top-level's name, the decoder of a top-level.
#[derive(Clone, Copy, Debug)]
struct TopLevelDependent {
    decoder: Option<Name>,
    encoder: Name,
}

/// `NamedTypeDependent`: the decoder and encoder of a named type.
#[derive(Clone, Copy, Debug)]
struct NamedTypeDependent {
    decoder: Name,
    encoder: Name,
}

/// `ElmRenderer`.
pub struct ElmRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: ElmOptions,
    /// `upperNamingFunction` (a module-level singleton in TypeScript).
    upper_naming_function: Namer,
    /// `lowerNamingFunction` (a module-level singleton in TypeScript).
    lower_naming_function: Namer,
    /// `_topLevelDependents`.
    top_level_dependents: HashMap<Name, TopLevelDependent>,
    /// `_namedTypeDependents`.
    named_type_dependents: HashMap<Name, NamedTypeDependent>,
}

impl std::fmt::Debug for ElmRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("ElmRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// The `sortOrder` of `emitUnionFunctions`: arrays first, then strings,
/// and integers before doubles.
fn union_member_sort_order(r: &ElmRenderer<'_>, _name: Name, t: TypeRef) -> Result<String> {
    let ty = r.type_graph().type_at(t)?;
    Ok(match ty.kind() {
        TypeKind::Array => "  array".to_owned(),
        TypeKind::Double => " xdouble".to_owned(),
        kind if ty.is_primitive() => format!(" {kind}"),
        kind => kind.to_string(),
    })
}

impl<'a> ElmRenderer<'a> {
    /// `new ElmRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: ElmOptions,
    ) -> Self {
        ElmRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            upper_naming_function: upper_naming_function(),
            lower_naming_function: lower_naming_function(),
            top_level_dependents: HashMap::default(),
            named_type_dependents: HashMap::default(),
        }
    }

    /// `arrayType`.
    fn array_type(&self) -> &'static str {
        if self.options.use_list {
            "List"
        } else {
            "Array"
        }
    }

    /// `elmType(t, noOptional)`.
    fn elm_type(&self, t: TypeRef, no_optional: bool) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => {
                    single_word(vec![annotated(any_type_issue_annotation(), "Jdec.Value")])
                }
                TypeKind::Null => single_word(vec![annotated(null_type_issue_annotation(), "()")]),
                TypeKind::Bool => single_word(vec!["Bool".into()]),
                TypeKind::Integer => single_word(vec!["Int".into()]),
                TypeKind::Double => single_word(vec!["Float".into()]),
                TypeKind::String => single_word(vec!["String".into()]),
                TypeKind::Array => multi_word(
                    " ",
                    vec![
                        self.array_type().into(),
                        paren_if_needed(self.elm_type(ty.items()?, false)?),
                    ],
                )?,
                TypeKind::Class | TypeKind::Enum => {
                    single_word(vec![self.name_for_named_type(t)?.into()])
                }
                TypeKind::Map => multi_word(
                    " ",
                    vec![
                        "Dict String".into(),
                        paren_if_needed(self.elm_type(ty.map_values()?, false)?),
                    ],
                )?,
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        let nullable_type = self.elm_type(nullable, false)?;
                        if no_optional {
                            return Ok(nullable_type);
                        }
                        return multi_word(
                            " ",
                            vec!["Maybe".into(), paren_if_needed(nullable_type)],
                        );
                    }

                    single_word(vec![self.name_for_named_type(t)?.into()])
                }
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `elmProperty(p)`.
    fn elm_property(&self, p: &ClassProperty) -> Result<Source> {
        if p.is_optional {
            return Ok(multi_word(
                " ",
                vec![
                    "Maybe".into(),
                    paren_if_needed(self.elm_type(p.type_ref, true)?),
                ],
            )?
            .source);
        }

        Ok(self.elm_type(p.type_ref, false)?.source)
    }

    /// `decoderNameForNamedType(t)`.
    fn decoder_name_for_named_type(&self, t: TypeRef) -> Result<Name> {
        let name = self.name_for_named_type(t)?;
        Ok(defined(self.named_type_dependents.get(&name))?.decoder)
    }

    /// `decoderForNumber(t, decoder)`.
    fn decoder_for_number(&self, t: TypeRef, decoder: &str) -> Result<MultiWord> {
        let (min, max) = match min_max_value_for_type(self.type_graph(), t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        if min.is_none() && max.is_none() {
            return Ok(single_word(vec![decoder.into()]));
        }
        let min_check = min.map_or_else(
            || "True".to_owned(),
            |min| format!("x >= {}", js_number(min)),
        );
        let max_check = max.map_or_else(
            || "True".to_owned(),
            |max| format!("x <= {}", js_number(max)),
        );
        Ok(single_word(vec![
            format!(
                "(Jdec.andThen (\\x -> if {min_check} && {max_check} then Jdec.succeed x else Jdec.fail \"Number out of range\") {decoder})"
            )
            .into(),
        ]))
    }

    /// `arrayConstraint(t)`.
    fn array_constraint(&self, t: TypeRef) -> Result<String> {
        let (min, max) = match min_max_items_for_type(self.type_graph(), t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        if min.is_none() && max.is_none() {
            return Ok(String::new());
        }
        let length = format!("{}.length x", self.array_type());
        let min_check = min.map_or_else(
            || "True".to_owned(),
            |min| format!("{length} >= {}", js_number(min)),
        );
        let max_check = max.map_or_else(
            || "True".to_owned(),
            |max| format!("{length} <= {}", js_number(max)),
        );
        Ok(format!(
            "|> Jdec.andThen (\\x -> if {min_check} && {max_check} then Jdec.succeed x else Jdec.fail \"Array length out of range\")"
        ))
    }

    /// `decoderForString(t)`.
    fn decoder_for_string(&self, t: TypeRef) -> Result<MultiWord> {
        let (min, max) = match min_max_length_for_type(self.type_graph(), t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        if min.is_none() && max.is_none() {
            return Ok(single_word(vec!["Jdec.string".into()]));
        }
        let length = "List.length (String.toList x)";
        let min_check = min.map_or_else(
            || "True".to_owned(),
            |min| format!("{length} >= {}", js_number(min)),
        );
        let max_check = max.map_or_else(
            || "True".to_owned(),
            |max| format!("{length} <= {}", js_number(max)),
        );
        Ok(single_word(vec![
            format!(
                "(Jdec.andThen (\\x -> if {min_check} && {max_check} then Jdec.succeed x else Jdec.fail \"String length out of range\") Jdec.string)"
            )
            .into(),
        ]))
    }

    /// `decoderNameForType(t, noOptional)`.
    fn decoder_name_for_type(&self, t: TypeRef, no_optional: bool) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => single_word(vec!["Jdec.value".into()]),
                TypeKind::Null => multi_word(" ", vec!["Jdec.null".into(), "()".into()])?,
                TypeKind::Bool => single_word(vec!["Jdec.bool".into()]),
                TypeKind::Integer => self.decoder_for_number(t, "Jdec.int")?,
                TypeKind::Double => self.decoder_for_number(t, "Jdec.float")?,
                TypeKind::String => self.decoder_for_string(t)?,
                TypeKind::Array => multi_word(
                    " ",
                    vec![
                        sl!["Jdec.", decapitalize(self.array_type())],
                        paren_if_needed(self.decoder_name_for_type(ty.items()?, false)?),
                        self.array_constraint(t)?.into(),
                    ],
                )?,
                TypeKind::Class | TypeKind::Enum => {
                    single_word(vec![self.decoder_name_for_named_type(t)?.into()])
                }
                TypeKind::Map => multi_word(
                    " ",
                    vec![
                        "Jdec.dict".into(),
                        paren_if_needed(self.decoder_name_for_type(ty.map_values()?, false)?),
                    ],
                )?,
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        let nullable_decoder = self.decoder_name_for_type(nullable, false)?;
                        if no_optional {
                            return Ok(nullable_decoder);
                        }
                        return multi_word(
                            " ",
                            vec!["Jdec.nullable".into(), paren_if_needed(nullable_decoder)],
                        );
                    }

                    single_word(vec![self.decoder_name_for_named_type(t)?.into()])
                }
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `decoderNameForProperty(p)`.
    fn decoder_name_for_property(&self, p: &ClassProperty) -> Result<MultiWord> {
        if p.is_optional {
            return multi_word(
                " ",
                vec![
                    if is_nullable(self.type_graph(), p.type_ref)? {
                        "Jdec.nullable"
                    } else {
                        "Jdec.map Just"
                    }
                    .into(),
                    paren_if_needed(self.decoder_name_for_type(p.type_ref, true)?),
                ],
            );
        }

        self.decoder_name_for_type(p.type_ref, false)
    }

    /// `encoderNameForNamedType(t)`.
    fn encoder_name_for_named_type(&self, t: TypeRef) -> Result<Name> {
        let name = self.name_for_named_type(t)?;
        Ok(defined(self.named_type_dependents.get(&name))?.encoder)
    }

    /// `encoderNameForType(t, noOptional)`.
    fn encoder_name_for_type(&self, t: TypeRef, no_optional: bool) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => single_word(vec!["identity".into()]),
                TypeKind::Null => multi_word(" ", vec!["always".into(), "Jenc.null".into()])?,
                TypeKind::Bool => single_word(vec!["Jenc.bool".into()]),
                TypeKind::Integer => single_word(vec!["Jenc.int".into()]),
                TypeKind::Double => single_word(vec!["Jenc.float".into()]),
                TypeKind::String => single_word(vec!["Jenc.string".into()]),
                TypeKind::Array => multi_word(
                    " ",
                    vec![
                        sl!["Jenc.", decapitalize(self.array_type())],
                        paren_if_needed(self.encoder_name_for_type(ty.items()?, false)?),
                    ],
                )?,
                TypeKind::Class | TypeKind::Enum => {
                    single_word(vec![self.encoder_name_for_named_type(t)?.into()])
                }
                TypeKind::Map => multi_word(
                    " ",
                    vec![
                        "Jenc.dict".into(),
                        "identity".into(),
                        paren_if_needed(self.encoder_name_for_type(ty.map_values()?, false)?),
                    ],
                )?,
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        let nullable_encoder = self.encoder_name_for_type(nullable, false)?;
                        if no_optional {
                            return Ok(nullable_encoder);
                        }
                        return multi_word(
                            " ",
                            vec![
                                "makeNullableEncoder".into(),
                                paren_if_needed(nullable_encoder),
                            ],
                        );
                    }

                    single_word(vec![self.encoder_name_for_named_type(t)?.into()])
                }
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `encoderNameForProperty(p)`.
    fn encoder_name_for_property(&self, p: &ClassProperty) -> Result<MultiWord> {
        if p.is_optional {
            return multi_word(
                " ",
                vec![
                    "makeNullableEncoder".into(),
                    paren_if_needed(self.encoder_name_for_type(p.type_ref, true)?),
                ],
            );
        }

        self.encoder_name_for_type(p.type_ref, false)
    }

    /// The decoder of a top-level: its own, or that of the named type that
    /// took its name.
    fn top_level_decoder(&self, name: Name) -> Result<Name> {
        let dependent = defined(self.top_level_dependents.get(&name))?;
        match dependent.decoder {
            Some(decoder) => Ok(decoder),
            None => Ok(defined(self.named_type_dependents.get(&name))?.decoder),
        }
    }

    /// `emitTopLevelDefinition(t, topLevelName)`.
    fn emit_top_level_definition(&mut self, t: TypeRef, top_level_name: Name) -> Result<()> {
        let elm_type = self.elm_type(t, false)?.source;
        self.emit_line(sl!["type alias ", top_level_name, " = ", elm_type]);
        Ok(())
    }

    /// `emitClassDefinition(c, className)`: the property descriptions join
    /// the class description.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let mut description = self.description_for_type(c)?;
        self.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, _, _| {
            let Some(property_description) = r.description_for_class_property(c, json_name)? else {
                return Ok(());
            };

            let lines = match description.as_mut() {
                None => description.insert(Vec::new()),
                Some(lines) => {
                    lines.push(String::new());
                    lines
                }
            };

            lines.push(format!("{}:", r.sourcelike_to_string(&name.into())?));
            lines.extend(property_description);
            Ok(())
        })?;

        self.emit_description(description)?;
        self.emit_line(sl!["type alias ", class_name, " ="]);
        self.indent(|r| {
            let mut on_first = true;
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, _| {
                let property = r.elm_property(&p)?;
                r.emit_line(sl![
                    if on_first { "{" } else { "," },
                    " ",
                    name,
                    " : ",
                    property
                ]);
                on_first = false;
                Ok(())
            })?;
            if on_first {
                r.emit_line("{");
            }

            r.emit_line("}");
            Ok(())
        })
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl!["type ", enum_name]);
        self.indent(|r| {
            let mut on_first = true;
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                let equals_or_pipe = if on_first { "=" } else { "|" };
                r.emit_line(sl![equals_or_pipe, " ", name]);
                on_first = false;
                Ok(())
            })
        })
    }

    /// `emitUnionDefinition(u, unionName)`.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        self.emit_line(sl!["type ", union_name]);
        self.indent(|r| {
            let mut on_first = true;
            r.for_each_union_member(u, None, BlankLinePosition::None, None, |r, name, t, _| {
                let equals_or_pipe = if on_first { "=" } else { "|" };
                if r.type_graph().kind(t)? == TypeKind::Null {
                    r.emit_line(sl![equals_or_pipe, " ", name]);
                } else {
                    let elm_type = paren_if_needed(r.elm_type(t, false)?);
                    r.emit_line(sl![equals_or_pipe, " ", name, " ", elm_type]);
                }

                on_first = false;
                Ok(())
            })
        })
    }

    /// `emitTopLevelFunctions(t, topLevelName)`.
    fn emit_top_level_functions(&mut self, t: TypeRef, top_level_name: Name) -> Result<()> {
        let TopLevelDependent { encoder, decoder } =
            *defined(self.top_level_dependents.get(&top_level_name))?;
        if self.named_type_to_name_for_top_level(t)?.is_none() {
            let decoder = defined(decoder)?;
            self.emit_line(sl![decoder, " : Jdec.Decoder ", top_level_name]);
            let decoder_source = self.decoder_name_for_type(t, false)?.source;
            self.emit_line(sl![decoder, " = ", decoder_source]);
            self.ensure_blank_line();
        }

        self.emit_line(sl![encoder, " : ", top_level_name, " -> String"]);
        let encoder_source = self.encoder_name_for_type(t, false)?.source;
        self.emit_line(sl![encoder, " r = Jenc.encode 0 (", encoder_source, " r)"]);
        Ok(())
    }

    /// `emitClassFunctions(c, className)`.
    fn emit_class_functions(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let decoder_name = self.decoder_name_for_named_type(c)?;
        self.emit_line(sl![decoder_name, " : Jdec.Decoder ", class_name]);
        self.emit_line(sl![decoder_name, " ="]);
        self.indent(|r| {
            if r.type_graph().type_at(c)?.properties()?.is_empty() {
                r.emit_line(sl![
                    "Jdec.dict Jdec.value |> Jdec.map (\\_ -> ",
                    class_name,
                    ")"
                ]);
                return Ok(());
            }
            r.emit_line(sl!["Jdec.succeed ", class_name]);
            r.indent(|r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, _, json_name, p, _| {
                    let prop_decoder = paren_if_needed(r.decoder_name_for_property(&p)?);
                    let required = required_or_optional(&p);
                    if required.req_or_opt.ends_with("optional") {
                        r.emit_line(sl![
                            "|> Jpipe.custom (optionalField \"",
                            elm_string_escape(json_name),
                            "\" ",
                            prop_decoder,
                            required.fallback,
                            ")"
                        ]);
                        return Ok(());
                    }
                    r.emit_line(sl![
                        "|> ",
                        required.req_or_opt,
                        " \"",
                        elm_string_escape(json_name),
                        "\" ",
                        prop_decoder,
                        required.fallback
                    ]);
                    Ok(())
                })
            })
        })?;
        self.ensure_blank_line();

        let encoder_name = self.encoder_name_for_named_type(c)?;
        self.emit_line(sl![encoder_name, " : ", class_name, " -> Jenc.Value"]);
        self.emit_line(sl![encoder_name, " x ="]);
        self.indent(|r| {
            r.emit_line("Jenc.object");
            r.indent(|r| {
                let mut on_first = true;
                r.for_each_class_property(
                    c,
                    BlankLinePosition::None,
                    |r, name, json_name, p, _| {
                        let bracket_or_comma = if on_first { "[" } else { "," };
                        let prop_encoder = r.encoder_name_for_property(&p)?.source;
                        r.emit_line(sl![
                            bracket_or_comma,
                            " (\"",
                            elm_string_escape(json_name),
                            "\", ",
                            prop_encoder,
                            " x.",
                            name,
                            ")"
                        ]);
                        on_first = false;
                        Ok(())
                    },
                )?;
                if on_first {
                    r.emit_line("[");
                }

                r.emit_line("]");
                Ok(())
            })
        })
    }

    /// `emitEnumFunctions(e, enumName)`.
    fn emit_enum_functions(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let decoder_name = self.decoder_name_for_named_type(e)?;
        self.emit_line(sl![decoder_name, " : Jdec.Decoder ", enum_name]);
        self.emit_line(sl![decoder_name, " ="]);
        self.indent(|r| {
            r.emit_line("Jdec.string");
            r.indent(|r| {
                r.emit_line("|> Jdec.andThen (\\str ->");
                r.indent(|r| {
                    r.emit_line("case str of");
                    r.indent(|r| {
                        r.for_each_enum_case(
                            e,
                            BlankLinePosition::None,
                            |r, name, json_name, _| {
                                r.emit_line(sl![
                                    "\"",
                                    elm_string_escape(json_name),
                                    "\" -> Jdec.succeed ",
                                    name
                                ]);
                                Ok(())
                            },
                        )?;
                        r.emit_line(sl![
                            "somethingElse -> Jdec.fail <| \"Invalid ",
                            enum_name,
                            ": \" ++ somethingElse"
                        ]);
                        Ok(())
                    })
                })?;
                r.emit_line(")");
                Ok(())
            })
        })?;
        self.ensure_blank_line();

        let encoder_name = self.encoder_name_for_named_type(e)?;
        self.emit_line(sl![encoder_name, " : ", enum_name, " -> Jenc.Value"]);
        self.emit_line(sl![encoder_name, " x = case x of"]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                r.emit_line(sl![
                    name,
                    " -> Jenc.string \"",
                    elm_string_escape(json_name),
                    "\""
                ]);
                Ok(())
            })
        })
    }

    /// `emitUnionFunctions(u, unionName)`.
    fn emit_union_functions(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let decoder_name = self.decoder_name_for_named_type(u)?;
        self.emit_line(sl![decoder_name, " : Jdec.Decoder ", union_name]);
        self.emit_line(sl![decoder_name, " ="]);
        self.indent(|r| {
            r.emit_line("Jdec.oneOf");
            r.indent(|r| {
                let mut on_first = true;
                r.for_each_union_member(
                    u,
                    None,
                    BlankLinePosition::None,
                    Some(&union_member_sort_order),
                    |r, name, t, _| {
                        let bracket_or_comma = if on_first { "[" } else { "," };
                        if r.type_graph().kind(t)? == TypeKind::Null {
                            r.emit_line(sl![bracket_or_comma, " Jdec.null ", name]);
                        } else {
                            let decoder = paren_if_needed(r.decoder_name_for_type(t, false)?);
                            r.emit_line(sl![bracket_or_comma, " Jdec.map ", name, " ", decoder]);
                        }

                        on_first = false;
                        Ok(())
                    },
                )?;
                r.emit_line("]");
                Ok(())
            })
        })?;
        self.ensure_blank_line();

        let encoder_name = self.encoder_name_for_named_type(u)?;
        self.emit_line(sl![encoder_name, " : ", union_name, " -> Jenc.Value"]);
        self.emit_line(sl![encoder_name, " x = case x of"]);
        self.indent(|r| {
            r.for_each_union_member(
                u,
                None,
                BlankLinePosition::None,
                Some(&union_member_sort_order),
                |r, name, t, _| {
                    if r.type_graph().kind(t)? == TypeKind::Null {
                        r.emit_line(sl![name, " -> Jenc.null"]);
                    } else {
                        let encoder = r.encoder_name_for_type(t, false)?.source;
                        r.emit_line(sl![name, " y -> ", encoder, " y"]);
                    }
                    Ok(())
                },
            )
        })
    }
}

impl<'a> ConvenienceRenderer<'a> for ElmRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(FORBIDDEN_NAMES.iter().map(|&n| n.to_owned()).collect())
    }

    fn make_top_level_dependency_names(
        &mut self,
        t: TypeRef,
        top_level_name: Name,
    ) -> Result<Vec<Name>> {
        let lower = self.lower_naming_function.clone();
        let order = self.naming().order(top_level_name);
        let encoder = self
            .naming_mut()
            .dependency_name(Some(&lower), order, move |lookup| {
                format!("{}_to_string", lookup(top_level_name))
            });
        let mut decoder = None;
        if self.named_type_to_name_for_top_level(t)?.is_none() {
            decoder = Some(
                self.naming_mut()
                    .dependency_name(Some(&lower), order, move |lookup| lookup(top_level_name)),
            );
        }

        self.top_level_dependents
            .insert(top_level_name, TopLevelDependent { encoder, decoder });
        Ok(match decoder {
            Some(decoder) => vec![encoder, decoder],
            None => vec![encoder],
        })
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.upper_naming_function.clone()
    }

    fn make_named_type_dependency_names(
        &mut self,
        _t: TypeRef,
        type_name: Name,
    ) -> Result<Vec<Name>> {
        let lower = self.lower_naming_function.clone();
        let order = self.naming().order(type_name);
        let encoder = self
            .naming_mut()
            .dependency_name(Some(&lower), order, move |lookup| {
                format!("encode_{}", lookup(type_name))
            });
        let decoder = self
            .naming_mut()
            .dependency_name(Some(&lower), order, move |lookup| lookup(type_name));
        self.named_type_dependents
            .insert(type_name, NamedTypeDependent { decoder, encoder });
        Ok(vec![encoder, decoder])
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.lower_naming_function.clone()))
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

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.upper_naming_function.clone())
    }

    fn union_members_in_global_namespace(&self) -> bool {
        true
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.upper_naming_function.clone())
    }

    fn enum_cases_in_global_namespace(&self) -> bool {
        true
    }

    /// `proposeUnionMemberName(...)`: the default, then `_in_<union>`.
    fn propose_union_member_name(
        &mut self,
        u: TypeRef,
        union_name: Name,
        field_type: TypeRef,
    ) -> Result<Proposer> {
        let field_name = defaults::propose_union_member_name(self, u, union_name, field_type)?;
        Ok(Rc::new(move |lookup| {
            let field_name = field_name(lookup);
            format!("{field_name}_in_{}", lookup(union_name))
        }))
    }

    fn comment_line_start(&self) -> &'static str {
        "-- "
    }

    /// `emitDescriptionBlock(lines)`: `{-| ... -}`, on one line for a
    /// one-line description.
    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        if lines.len() == 1 {
            return self.emit_comments(&[Comment::Custom {
                options: CommentOptions {
                    line_start: Some("{-| ".to_owned()),
                    line_end: Some(" -}".to_owned()),
                    ..CommentOptions::default()
                },
                custom_lines: lines.to_vec(),
            }]);
        }

        self.emit_comment_lines(
            lines,
            &CommentOptions {
                first_line_start: Some("{-| ".to_owned()),
                line_start: Some(String::new()),
                after_comment: Some("-}".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        let mut exports: Vec<Source> = Vec::new();
        let mut top_level_decoders: Vec<Name> = Vec::new();
        self.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
            let encoder = defined(r.top_level_dependents.get(&name))?.encoder;
            let decoder = r.top_level_decoder(name)?;

            top_level_decoders.push(decoder);
            exports.extend([name.into(), encoder.into(), decoder.into()]);
            Ok(())
        })?;
        let top_levels = self.top_levels();
        let is_top_level = |t: TypeRef| top_levels.values().any(|&x| x == t);
        self.for_each_object(BlankLinePosition::None, |_, t, name, _| {
            if !is_top_level(t) {
                exports.push(name.into());
            }
            Ok(())
        })?;
        self.for_each_enum(BlankLinePosition::None, |_, t, name, _| {
            if !is_top_level(t) {
                exports.push(sl![name, "(..)"]);
            }
            Ok(())
        })?;
        self.for_each_union(BlankLinePosition::None, |_, t, name, _| {
            if !is_top_level(t) {
                exports.push(sl![name, "(..)"]);
            }
            Ok(())
        })?;

        let just_types = self.options.just_types;
        let module_name = self.options.module_name.clone();
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        } else if !just_types {
            let lines: Vec<Source> = [
                "To decode the JSON data, add this file to your project, run",
                "",
                "    elm install NoRedInk/elm-json-decode-pipeline",
                "",
                "add these imports",
                "",
                "    import Json.Decode exposing (decodeString)",
            ]
            .into_iter()
            .map(Source::from)
            .collect();
            self.emit_comment_lines(&lines, &CommentOptions::default())?;
            let mut decoders: Vec<Source> = Vec::new();
            for (i, decoder) in top_level_decoders.iter().enumerate() {
                if i > 0 {
                    decoders.push(", ".into());
                }
                decoders.push((*decoder).into());
            }
            self.emit_line(sl![
                "--     import ",
                module_name.clone(),
                " exposing (",
                Source::Sequence(decoders),
                ")"
            ]);
            self.emit_multiline("--\n-- and you're off to the races with\n--")?;
            self.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
                let decoder = r.top_level_decoder(name)?;
                r.emit_line(sl!["--     decodeString ", decoder, " myJsonString"]);
                Ok(())
            })?;
        }

        if !just_types {
            self.ensure_blank_line();
            self.emit_line(sl!["module ", module_name, " exposing"]);
            self.indent(|r| {
                for (i, export) in exports.into_iter().enumerate() {
                    r.emit_line(sl![if i == 0 { "(" } else { "," }, " ", export]);
                }

                r.emit_line(")");
                Ok(())
            })?;
            self.ensure_blank_line();

            self.emit_multiline(
                "import Json.Decode as Jdec\nimport Json.Decode.Pipeline as Jpipe\nimport Json.Encode as Jenc\nimport Dict exposing (Dict)",
            )?;
            if !self.options.use_list {
                self.emit_line("import Array exposing (Array)");
            }
        }

        self.for_each_top_level_where(
            BlankLinePosition::LeadingAndInterposing,
            |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, top_level_name, _| r.emit_top_level_definition(t, top_level_name),
        )?;
        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.emit_class_definition(c, class_name),
            |r, e, enum_name, _| r.emit_enum_definition(e, enum_name),
            |r, u, union_name, _| r.emit_union_definition(u, union_name),
        )?;

        if just_types {
            return Ok(());
        }

        self.ensure_blank_line();
        self.emit_line("-- decoders and encoders");
        self.emit_multiline(
            "optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail (\"Invalid \" ++ key)))",
        )?;
        self.for_each_top_level(
            BlankLinePosition::LeadingAndInterposing,
            |r, t, top_level_name, _| r.emit_top_level_functions(t, top_level_name),
        )?;
        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.emit_class_functions(c, class_name),
            |r, e, enum_name, _| r.emit_enum_functions(e, enum_name),
            |r, u, union_name, _| r.emit_union_functions(u, union_name),
        )?;
        self.ensure_blank_line();

        self.emit_line("--- encoder helpers");
        self.ensure_blank_line();
        self.emit_multiline(
            "makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
\tcase m of
\tJust x -> f x
\tNothing -> Jenc.null",
        )
    }
}
