//! Port of `packages/quicktype-core/src/language/Haskell/HaskellRenderer.ts`.
//!
//! Renders Haskell records, sum types and their Aeson instances.

use std::rc::Rc;

use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::naming::Names;
use crate::renderer_options::RendererOptions;
use crate::source::{MultiWord, multi_word, paren_if_needed, single_word};
use crate::support::comments::{Comment, CommentOptions};
use crate::support::recursion::guard;
use crate::support::strings::string_escape;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::nullable_from_union;

use super::constants::FORBIDDEN_NAMES;
use super::language::{JUST_TYPES, MODULE_NAME, USE_LIST};
use super::utils::{lower_naming_function, upper_naming_function};

/// `haskellStringEscape(s)`: [`string_escape`], with every `\uXXXX` and
/// `\UXXXXXXXX` in the result turned into Haskell's `\xXXXX\&`.
///
/// Like the TypeScript regular expression, this rewrites the escaped
/// text, so a backslash that `string_escape` doubled can start a match.
pub fn haskell_string_escape(s: &str) -> String {
    let escaped = string_escape(s);
    let mut out = String::with_capacity(escaped.len());
    let mut rest = escaped.as_str();
    while let Some(pos) = rest.find('\\') {
        out.push_str(&rest[..pos]);
        let after = &rest[pos + 1..];
        let width = match after.as_bytes().first() {
            Some(b'u') => 4,
            Some(b'U') => 8,
            _ => 0,
        };
        if width > 0
            && after.len() > width
            && after.as_bytes()[1..=width]
                .iter()
                .all(u8::is_ascii_hexdigit)
        {
            out.push_str("\\x");
            out.push_str(&after[1..=width]);
            out.push_str("\\&");
            rest = &after[width + 1..];
        } else {
            out.push('\\');
            rest = after;
        }
    }
    out.push_str(rest);
    out
}

/// The option values of the Haskell renderer (TS
/// `OptionValues<typeof haskellOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct HaskellOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `useList`: `list` (`[T]`) rather than `array` (`Vector T`).
    pub use_list: bool,
    /// `moduleName`.
    pub module_name: String,
}

impl HaskellOptions {
    /// `getOptionValues(haskellOptions, values)`: the options in
    /// declaration order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let just_types = JUST_TYPES.get_value(values);
        let use_list = USE_LIST.get_enum_value(values)? == "list";
        let module_name = MODULE_NAME.get_value(values).into_owned();
        Ok(HaskellOptions {
            just_types,
            use_list,
            module_name,
        })
    }
}

/// `HaskellRenderer`.
pub struct HaskellRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: HaskellOptions,
    /// `upperNamingFunction` (a module-level singleton in TypeScript).
    upper_naming_function: Namer,
    /// `lowerNamingFunction` (a module-level singleton in TypeScript).
    lower_naming_function: Namer,
}

impl std::fmt::Debug for HaskellRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("HaskellRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> HaskellRenderer<'a> {
    /// `new HaskellRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: HaskellOptions,
    ) -> Self {
        HaskellRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            upper_naming_function: upper_naming_function(),
            lower_naming_function: lower_naming_function(),
        }
    }

    /// `haskellType(t, noOptional)`.
    fn haskell_type(&self, t: TypeRef, no_optional: bool) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => single_word(vec!["Value".into()]),
                TypeKind::Null => multi_word(" ", vec!["Maybe".into(), "Text".into()])?,
                TypeKind::Bool => single_word(vec!["Bool".into()]),
                TypeKind::Integer => single_word(vec!["Int".into()]),
                TypeKind::Double => single_word(vec!["Double".into()]),
                TypeKind::String => single_word(vec!["Text".into()]),
                TypeKind::Array => {
                    let items = paren_if_needed(self.haskell_type(ty.items()?, false)?);
                    if self.options.use_list {
                        multi_word("", vec!["[".into(), items, "]".into()])?
                    } else {
                        multi_word(" ", vec!["Vector".into(), items])?
                    }
                }
                TypeKind::Class | TypeKind::Enum => {
                    single_word(vec![self.name_for_named_type(t)?.into()])
                }
                TypeKind::Map => multi_word(
                    " ",
                    vec![
                        "HashMap Text".into(),
                        paren_if_needed(self.haskell_type(ty.map_values()?, false)?),
                    ],
                )?,
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        let nullable_type = self.haskell_type(nullable, false)?;
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
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `haskellProperty(p)`.
    fn haskell_property(&self, p: &ClassProperty) -> Result<Source> {
        if p.is_optional {
            return Ok(multi_word(
                " ",
                vec![
                    "Maybe".into(),
                    paren_if_needed(self.haskell_type(p.type_ref, false)?),
                ],
            )?
            .source);
        }
        Ok(self.haskell_type(p.type_ref, false)?.source)
    }

    /// `encoderNameForType(t)`.
    fn encoder_name_for_type(&self, t: TypeRef) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let word = match self.type_graph().kind(t)? {
                TypeKind::Any => "String",
                TypeKind::Null => "Null",
                TypeKind::Bool => "Bool",
                TypeKind::Integer | TypeKind::Double => "Number",
                TypeKind::String => "String",
                TypeKind::Array => "Array",
                TypeKind::Class | TypeKind::Map => "Object",
                TypeKind::Enum => "String",
                TypeKind::Union => "Object",
                kind => return match_type_unsupported(kind),
            };
            Ok(single_word(vec![word.into()]))
        })
    }

    /// `emitTopLevelDefinition(t, topLevelName)`.
    fn emit_top_level_definition(&mut self, t: TypeRef, top_level_name: Name) -> Result<()> {
        let ty = self.haskell_type(t, false)?.source;
        self.emit_line(sl!["type ", top_level_name, " = ", ty]);
        Ok(())
    }

    /// `emitClassDefinition(c, className)`: the record, with the property
    /// descriptions appended to the type's description.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let mut description = self.description_for_type(c)?;
        self.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, _, _| {
            let Some(property_description) = r.description_for_class_property(c, json_name)? else {
                return Ok(());
            };
            let lines = match &mut description {
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
        self.emit_line(sl!["data ", class_name, " = ", class_name]);
        self.indent(|r| {
            let mut on_first = true;
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, _| {
                let property = r.haskell_property(&p)?;
                r.emit_line(sl![
                    if on_first { "{ " } else { ", " },
                    name,
                    class_name,
                    " :: ",
                    property
                ]);
                on_first = false;
                Ok(())
            })?;
            if on_first {
                r.emit_line("{");
            }
            r.emit_line("} deriving (Show)");
            Ok(())
        })
    }

    /// `enumCaseName(name, enumName)`: the name itself if it is a
    /// `DependencyName` (which already ends in the enum's name), else
    /// `[name, enumName]` (the fixed names of `qt-accessors`).
    fn enum_case_name(&self, name: Name, enum_name: Name) -> Source {
        if self.naming().is_dependency_name(name) {
            name.into()
        } else {
            sl![name, enum_name]
        }
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl!["data ", enum_name]);
        self.indent(|r| {
            let mut on_first = true;
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                let equals_or_pipe = if on_first { "=" } else { "|" };
                let case_name = r.enum_case_name(name, enum_name);
                r.emit_line(sl![equals_or_pipe, " ", case_name]);
                on_first = false;
                Ok(())
            })?;
            r.emit_line("deriving (Show)");
            Ok(())
        })
    }

    /// `emitUnionDefinition(u, unionName)`.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        self.emit_line(sl!["data ", union_name]);
        self.indent(|r| {
            let mut on_first = true;
            r.for_each_union_member(u, None, BlankLinePosition::None, None, |r, name, t, _| {
                let equals_or_pipe = if on_first { "=" } else { "|" };
                if r.type_graph().kind(t)? == TypeKind::Null {
                    r.emit_line(sl![equals_or_pipe, " ", name]);
                } else {
                    let ty = paren_if_needed(r.haskell_type(t, false)?);
                    r.emit_line(sl![equals_or_pipe, " ", name, " ", ty]);
                }
                on_first = false;
                Ok(())
            })?;
            r.emit_line("deriving (Show)");
            Ok(())
        })
    }

    /// `emitTopLevelFunctions(topLevelName)`.
    fn emit_top_level_functions(&mut self, top_level_name: Name) {
        self.emit_line(sl![
            "decodeTopLevel :: ByteString -> Maybe ",
            top_level_name
        ]);
        self.emit_line("decodeTopLevel = decode");
    }

    /// `classPropertyLength(c)`.
    fn class_property_length(&mut self, c: TypeRef) -> Result<usize> {
        let mut counter = 0;
        self.for_each_class_property(c, BlankLinePosition::None, |_, _, _, _, _| {
            counter += 1;
            Ok(())
        })?;
        Ok(counter)
    }

    /// `emitClassEncoderInstance(c, className)`.
    fn emit_class_encoder_instance(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let mut class_properties: Vec<Source> = Vec::new();
        self.for_each_class_property(c, BlankLinePosition::None, |_, name, _, _, _| {
            class_properties.push(" ".into());
            class_properties.push(name.into());
            class_properties.push(class_name.into());
            Ok(())
        })?;

        self.emit_line(sl!["instance ToJSON ", class_name, " where"]);
        self.indent(|r| {
            if class_properties.is_empty() {
                r.emit_line("toJSON = \\_ -> emptyObject");
                return Ok(());
            }
            let mut line = vec![Source::from("toJSON ("), class_name.into()];
            line.extend(class_properties);
            line.push(") =".into());
            r.emit_line_parts(line);
            r.indent(|r| {
                r.emit_line("object $ foldMap (maybe [] pure)");
                let mut on_first = true;
                let properties = r.type_graph().type_at(c)?.properties()?;
                r.for_each_class_property(
                    c,
                    BlankLinePosition::None,
                    |r, name, json_name, _, _| {
                        let optional = properties.get(json_name).is_some_and(|p| p.is_optional);
                        r.emit_line(sl![
                            if on_first { "[ " } else { ", " },
                            if optional { "(" } else { "Just $ " },
                            "\"",
                            haskell_string_escape(json_name),
                            if optional { "\" .=) <$> " } else { "\" .= " },
                            name,
                            class_name
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

    /// `emitClassDecoderInstance(c, className)`.
    fn emit_class_decoder_instance(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.emit_line(sl!["instance FromJSON ", class_name, " where"]);
        self.indent(|r| {
            if r.class_property_length(c)? == 0 {
                r.emit_line(sl!["parseJSON (Object _) = return ", class_name]);
                return Ok(());
            }
            r.emit_line(sl!["parseJSON (Object v) = ", class_name]);
            r.indent(|r| {
                let mut on_first = true;
                r.for_each_class_property(c, BlankLinePosition::None, |r, _, json_name, p, _| {
                    let operator = if p.is_optional { ".:!" } else { ".:" };
                    r.emit_line(sl![
                        if on_first { "<$> " } else { "<*> " },
                        "v ",
                        operator,
                        " \"",
                        haskell_string_escape(json_name),
                        "\""
                    ]);
                    on_first = false;
                    Ok(())
                })
            })
        })
    }

    /// `emitClassFunctions(c, className)`.
    fn emit_class_functions(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.emit_class_encoder_instance(c, class_name)?;
        self.ensure_blank_line();
        self.emit_class_decoder_instance(c, class_name)
    }

    /// `emitEnumEncoderInstance(e, enumName)`.
    fn emit_enum_encoder_instance(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.emit_line(sl!["instance ToJSON ", enum_name, " where"]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                let case_name = r.enum_case_name(name, enum_name);
                r.emit_line(sl![
                    "toJSON ",
                    case_name,
                    " = \"",
                    haskell_string_escape(json_name),
                    "\""
                ]);
                Ok(())
            })
        })
    }

    /// `emitEnumDecoderInstance(e, enumName)`.
    fn emit_enum_decoder_instance(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.emit_line(sl!["instance FromJSON ", enum_name, " where"]);
        self.indent(|r| {
            r.emit_line(sl!["parseJSON = withText \"", enum_name, "\" parseText"]);
            r.indent(|r| {
                r.emit_line("where");
                r.indent(|r| {
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        let case_name = r.enum_case_name(name, enum_name);
                        r.emit_line(sl![
                            "parseText \"",
                            haskell_string_escape(json_name),
                            "\" = return ",
                            case_name
                        ]);
                        Ok(())
                    })
                })
            })
        })
    }

    /// `emitEnumFunctions(e, enumName)`.
    fn emit_enum_functions(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.emit_enum_encoder_instance(e, enum_name)?;
        self.ensure_blank_line();
        self.emit_enum_decoder_instance(e, enum_name)
    }

    /// `emitUnionEncoderInstance(u, unionName)`.
    fn emit_union_encoder_instance(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        self.emit_line(sl!["instance ToJSON ", union_name, " where"]);
        self.indent(|r| {
            r.for_each_union_member(u, None, BlankLinePosition::None, None, |r, name, t, _| {
                if r.type_graph().kind(t)? == TypeKind::Null {
                    r.emit_line(sl!["toJSON ", name, " = Null"]);
                } else {
                    r.emit_line(sl!["toJSON (", name, " x) = toJSON x"]);
                }
                Ok(())
            })
        })
    }

    /// `emitUnionDecoderInstance(u, unionName)`.
    fn emit_union_decoder_instance(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        self.emit_line(sl!["instance FromJSON ", union_name, " where"]);
        self.indent(|r| {
            r.for_each_union_member(u, None, BlankLinePosition::None, None, |r, name, t, _| {
                if r.type_graph().kind(t)? == TypeKind::Null {
                    r.emit_line(sl!["parseJSON Null = return ", name]);
                } else {
                    let encoder = r.encoder_name_for_type(t)?.source;
                    r.emit_line(sl![
                        "parseJSON xs@(",
                        encoder,
                        " _) = (fmap ",
                        name,
                        " . parseJSON) xs"
                    ]);
                }
                Ok(())
            })
        })
    }

    /// `emitUnionFunctions(u, unionName)`.
    fn emit_union_functions(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        self.emit_union_encoder_instance(u, union_name)?;
        self.ensure_blank_line();
        self.emit_union_decoder_instance(u, union_name)
    }

    /// `emitLanguageExtensions(ext)`.
    fn emit_language_extensions(&mut self, ext: &str) {
        self.emit_line(format!("{{-# LANGUAGE {ext} #-}}"));
    }

    /// `mapContains(this.topLevels, t)`.
    fn is_top_level(&self, t: TypeRef) -> bool {
        self.top_levels().values().any(|&v| v == t)
    }
}

impl<'a> ConvenienceRenderer<'a> for HaskellRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(FORBIDDEN_NAMES.iter().map(|&n| n.to_owned()).collect())
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.upper_naming_function.clone()
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

    /// The default name, as a dependency name `<case>_<enum name>`.
    fn make_name_for_enum_case(
        &mut self,
        e: TypeRef,
        enum_name: Name,
        case_name: &str,
        assigned_name: Option<&str>,
    ) -> Result<Name> {
        let name = defaults::make_name_for_enum_case(self, e, enum_name, case_name, assigned_name)?;
        let proposed_name = self.naming().first_proposed_name(name, &Names::new())?;
        let namer = self.naming().naming_function(name)?.clone();
        let order = self.naming().order(name);
        Ok(self
            .naming_mut()
            .dependency_name(Some(&namer), order, move |lookup| {
                format!("{proposed_name}_{}", lookup(enum_name))
            }))
    }

    /// The default proposal, followed by `_in_<union name>`.
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

    /// One line becomes `{-| line -}`; several become a `{-| ... -}`
    /// block.
    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        if lines.len() == 1 {
            self.emit_comments(&[Comment::Custom {
                options: CommentOptions {
                    line_start: Some("{-| ".to_owned()),
                    line_end: Some(" -}".to_owned()),
                    ..CommentOptions::default()
                },
                custom_lines: lines.to_vec(),
            }])
        } else {
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
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        let mut exports: Vec<Source> = Vec::new();
        self.for_each_top_level(BlankLinePosition::None, |_, _, name, _| {
            exports.push(sl![name, " (..)"]);
            Ok(())
        })?;
        self.for_each_object(BlankLinePosition::None, |r, t, name, _| {
            if !r.is_top_level(t) {
                exports.push(sl![name, " (..)"]);
            }
            Ok(())
        })?;
        self.for_each_enum(BlankLinePosition::None, |r, t, name, _| {
            if !r.is_top_level(t) {
                exports.push(sl![name, " (..)"]);
            }
            Ok(())
        })?;
        self.for_each_union(BlankLinePosition::None, |r, t, name, _| {
            if !r.is_top_level(t) {
                exports.push(sl![name, " (..)"]);
            }
            Ok(())
        })?;

        self.emit_language_extensions("StrictData");
        self.emit_language_extensions("OverloadedStrings");

        if !self.options.just_types {
            self.ensure_blank_line();
            let module_name = self.options.module_name.clone();
            self.emit_line(sl!["module ", module_name]);
            self.indent(|r| {
                for (i, export) in exports.into_iter().enumerate() {
                    r.emit_line(sl![if i == 0 { "(" } else { "," }, " ", export]);
                }
                r.emit_line(", decodeTopLevel");
                r.emit_line(") where");
                Ok(())
            })?;
            self.ensure_blank_line();
            self.emit_multiline(
                "import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)",
            )?;
            if !self.options.use_list {
                self.emit_line("import Data.Vector (Vector)");
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

        self.for_each_top_level(
            BlankLinePosition::LeadingAndInterposing,
            |r, _, top_level_name, _| {
                r.emit_top_level_functions(top_level_name);
                Ok(())
            },
        )?;

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.emit_class_functions(c, class_name),
            |r, e, enum_name, _| r.emit_enum_functions(e, enum_name),
            |r, u, union_name, _| r.emit_union_functions(u, union_name),
        )?;

        if self.options.just_types {
            return Ok(());
        }

        self.ensure_blank_line();
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn escapes_like_typescript() {
        assert_eq!(haskell_string_escape("abc"), "abc");
        assert_eq!(haskell_string_escape("a\"b\\c"), "a\\\"b\\\\c");
        assert_eq!(haskell_string_escape("\u{7f}"), "\\x007f\\&");
        assert_eq!(haskell_string_escape("\u{1f600}x"), "\\x0001f600\\&x");
        assert_eq!(haskell_string_escape("\u{e0001}"), "\\x000e0001\\&");
        // The rewrite runs on the escaped text: a literal `ሴ` matches
        // after the doubled backslash.
        assert_eq!(haskell_string_escape("\\u1234"), "\\\\x1234\\&");
        assert_eq!(haskell_string_escape("\\u12"), "\\\\u12");
    }
}
