//! Port of `packages/quicktype-core/src/language/Scala3/Scala3Renderer.ts`.
//!
//! The base of the Scala 3 renderers: case classes, enums and union type
//! aliases without codecs. It renders `--just-types` output itself and is
//! the family base of [`CirceRenderer`](super::circe_renderer::CirceRenderer)
//! and [`UpickleRenderer`](super::upickle_renderer::UpickleRenderer).
//!
//! The TypeScript class hierarchy becomes:
//!
//! - [`Scala3State`]: the fields of `Scala3Renderer`, owned by every
//!   renderer of the family;
//! - [`Scala3RendererFamily`]: the class's own (non-hook) methods, with the
//!   base implementations in [`scala3_methods`] for `super` calls;
//! - [`scala3_hooks`]: the `ConvenienceRenderer` hooks the class overrides.

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::renderer_options::RendererOptions;
use crate::support::recursion::guard;
use crate::target_language::TargetLanguage;
use indexmap::IndexMap;

use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::language::{FRAMEWORK, JUST_TYPES, PACKAGE_NAME};
use super::utils::{
    backticked_name, lower_naming_function, property_name_needs_mapping, upper_naming_function,
    wrap_option,
};

/// The values of the `framework` option (TS `"Circe" | "Upickle"`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Framework {
    /// `circe`.
    Circe,
    /// `upickle`.
    Upickle,
}

/// The option values of the Scala 3 renderers (TS
/// `OptionValues<typeof scala3Options>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Scala3Options {
    /// `justTypes`.
    pub just_types: bool,
    /// `framework`.
    pub framework: Framework,
    /// `packageName`.
    pub package_name: String,
}

impl Scala3Options {
    /// `getOptionValues(scala3Options, values)`: the options in
    /// declaration order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let just_types = JUST_TYPES.get_value(values);
        let framework = match FRAMEWORK.get_enum_value(values)? {
            "upickle" => Framework::Upickle,
            _ => Framework::Circe,
        };
        let package_name = PACKAGE_NAME.get_value(values).into_owned();
        Ok(Scala3Options {
            just_types,
            framework,
            package_name,
        })
    }
}

/// The fields of TS `Scala3Renderer`, shared by the family.
#[derive(Clone)]
pub struct Scala3State {
    /// `_scalaOptions`.
    pub options: Scala3Options,
    /// `upperNamingFunction` (a module-level singleton in TypeScript).
    upper_naming_function: Namer,
    /// `lowerNamingFunction` (a module-level singleton in TypeScript).
    lower_naming_function: Namer,
}

impl std::fmt::Debug for Scala3State {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("Scala3State")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl Scala3State {
    /// The state of a new renderer with `options`.
    pub fn new(options: Scala3Options) -> Self {
        Scala3State {
            options,
            upper_naming_function: upper_naming_function(),
            lower_naming_function: lower_naming_function(),
        }
    }
}

/// The delimiters of [`emit_block`] (TS `"curly" | "paren" | "lambda" |
/// "none"`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum BlockDelimiter {
    /// `{` … `}`.
    Curly,
    /// `(` … `)`.
    Paren,
    /// `{` … `})`.
    Lambda,
    /// Nothing (an empty closing line).
    None,
}

/// `emitBlock(line, f, delimiter)`.
pub fn emit_block<'a, R: ConvenienceRenderer<'a>>(
    r: &mut R,
    line: Source,
    delimiter: BlockDelimiter,
    f: impl FnOnce(&mut R) -> Result<()>,
) -> Result<()> {
    let (open, close) = match delimiter {
        BlockDelimiter::Curly => ("{", "}"),
        BlockDelimiter::Paren => ("(", ")"),
        BlockDelimiter::None => ("", ""),
        BlockDelimiter::Lambda => ("{", "})"),
    };
    r.emit_line(sl![line, " ", open]);
    r.indent(f)?;
    r.emit_line(close);
    Ok(())
}

/// The methods of TS `Scala3Renderer` that subclasses may override. The
/// defaults are the base implementations in [`scala3_methods`].
pub trait Scala3RendererFamily<'a>: ConvenienceRenderer<'a> {
    /// The family's state.
    fn scala3(&self) -> &Scala3State;

    /// `anySourceType(optional)`.
    fn any_source_type(&self, optional: bool) -> Source {
        scala3_methods::any_source_type(self, optional)
    }

    /// `arrayType(arrayType, withIssues)`.
    fn array_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        scala3_methods::array_type(self, t, with_issues)
    }

    /// `mapType(mapType, withIssues)`.
    fn map_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        scala3_methods::map_type(self, t, with_issues)
    }

    /// `scalaType(t, withIssues, noOptional)`.
    fn scala_type(&self, t: TypeRef, with_issues: bool, no_optional: bool) -> Result<Source> {
        scala3_methods::scala_type(self, t, with_issues, no_optional)
    }

    /// `emitUsageHeader()`.
    fn emit_usage_header(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitHeader()`.
    fn emit_header(&mut self) -> Result<()> {
        scala3_methods::emit_header(self)
    }

    /// `emitTopLevelArray(t, name)`.
    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        scala3_methods::emit_top_level_array(self, t, name)
    }

    /// `emitTopLevelMap(t, name)`.
    fn emit_top_level_map(&mut self, t: TypeRef, name: Name) -> Result<()> {
        scala3_methods::emit_top_level_map(self, t, name)
    }

    /// `emitEmptyClassDefinition(c, className)`.
    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        scala3_methods::emit_empty_class_definition(self, c, class_name)
    }

    /// `emitPropertyAnnotation(name, jsonName)`: nothing by default.
    fn emit_property_annotation(&mut self, _name: Name, _json_name: &str) -> Result<()> {
        Ok(())
    }

    /// `emitClassDefinitionPostamble(c, className)`: nothing by default.
    fn emit_class_definition_postamble(&mut self, _c: TypeRef, _class_name: Name) -> Result<()> {
        Ok(())
    }

    /// `emitClassDefinition(c, className)`.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        scala3_methods::emit_class_definition(self, c, class_name)
    }

    /// `emitClassDefinitionMethods(c, className)`.
    fn emit_class_definition_methods(&mut self, _c: TypeRef, _class_name: Name) -> Result<()> {
        self.emit_line(")");
        Ok(())
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        scala3_methods::emit_enum_definition(self, e, enum_name)
    }

    /// `emitUnionDefinition(u, unionName)`.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        scala3_methods::emit_union_definition(self, u, union_name)
    }
}

/// The base implementations of the [`Scala3RendererFamily`] methods (what
/// `super.x()` calls in a subclass).
pub mod scala3_methods {
    use super::*;

    /// `anySourceType(optional)`: `Any`.
    pub fn any_source_type<'a, R: Scala3RendererFamily<'a>>(_r: &R, optional: bool) -> Source {
        sl![wrap_option("Any", optional)]
    }

    /// `arrayType(arrayType, withIssues)`: `Seq[T]`.
    pub fn array_type<'a, R: Scala3RendererFamily<'a>>(
        r: &R,
        t: TypeRef,
        with_issues: bool,
    ) -> Result<Source> {
        let items = r.type_graph().type_at(t)?.items()?;
        Ok(sl!["Seq[", r.scala_type(items, with_issues, false)?, "]"])
    }

    /// `mapType(mapType, withIssues)`: `Map[String, T]`.
    pub fn map_type<'a, R: Scala3RendererFamily<'a>>(
        r: &R,
        t: TypeRef,
        with_issues: bool,
    ) -> Result<Source> {
        let values = r.type_graph().type_at(t)?.map_values()?;
        Ok(sl![
            "Map[String, ",
            r.scala_type(values, with_issues, false)?,
            "]"
        ])
    }

    /// `scalaType(t, withIssues, noOptional)`.
    pub fn scala_type<'a, R: Scala3RendererFamily<'a>>(
        r: &R,
        t: TypeRef,
        with_issues: bool,
        no_optional: bool,
    ) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = r.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => maybe_annotated(
                    with_issues,
                    any_type_issue_annotation(),
                    r.any_source_type(!no_optional),
                ),
                TypeKind::Null => maybe_annotated(
                    with_issues,
                    null_type_issue_annotation(),
                    r.any_source_type(!no_optional),
                ),
                TypeKind::Bool => "Boolean".into(),
                TypeKind::Integer => "Long".into(),
                TypeKind::Double => "Double".into(),
                TypeKind::String => "String".into(),
                TypeKind::Array => r.array_type(t, with_issues)?,
                TypeKind::Class | TypeKind::Enum => r.name_for_named_type(t)?.into(),
                TypeKind::Map => r.map_type(t, with_issues)?,
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        if no_optional {
                            return Ok(sl![r.scala_type(nullable, with_issues, false)?]);
                        }
                        return Ok(sl![
                            "Option[",
                            r.scala_type(nullable, with_issues, false)?,
                            "]"
                        ]);
                    }
                    r.name_for_named_type(t)?.into()
                }
                TypeKind::Uuid => "java.util.UUID".into(),
                kind if kind.is_transformed_string_type_kind() => "java.time.Instant".into(),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `emitHeader()`: the leading comments (or the usage header) and the
    /// package.
    pub fn emit_header<'a, R: Scala3RendererFamily<'a>>(r: &mut R) -> Result<()> {
        if let Some(leading_comments) = r.leading_comments() {
            r.emit_comments(leading_comments)?;
        } else {
            r.emit_usage_header()?;
        }

        r.ensure_blank_line();
        let package_name = r.scala3().options.package_name.clone();
        r.emit_line(sl!["package ", package_name]);
        r.ensure_blank_line();
        Ok(())
    }

    /// `emitTopLevelArray(t, name)`: `type Name = List[T]`.
    pub fn emit_top_level_array<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        t: TypeRef,
        name: Name,
    ) -> Result<()> {
        let items = r.type_graph().type_at(t)?.items()?;
        let element_type = r.scala_type(items, false, false)?;
        r.emit_line(sl!["type ", name, " = List[", element_type, "]"]);
        Ok(())
    }

    /// `emitTopLevelMap(t, name)`: `type Name = Map[String, T]`.
    pub fn emit_top_level_map<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        t: TypeRef,
        name: Name,
    ) -> Result<()> {
        let values = r.type_graph().type_at(t)?.map_values()?;
        let element_type = r.scala_type(values, false, false)?;
        r.emit_line(sl!["type ", name, " = Map[String, ", element_type, "]"]);
        Ok(())
    }

    /// `emitEmptyClassDefinition(c, className)`.
    pub fn emit_empty_class_definition<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        c: TypeRef,
        class_name: Name,
    ) -> Result<()> {
        let description = r.description_for_type(c)?;
        r.emit_description(description)?;
        r.emit_line(sl!["case class ", class_name, "()"]);
        Ok(())
    }

    /// `emitClassDefinition(c, className)`: a case class whose optional and
    /// nullable fields default to `None` (except with upickle).
    pub fn emit_class_definition<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        c: TypeRef,
        class_name: Name,
    ) -> Result<()> {
        let property_count = r.type_graph().type_at(c)?.properties()?.len();
        if property_count == 0 {
            return r.emit_empty_class_definition(c, class_name);
        }

        let description = r.description_for_type(c)?;
        r.emit_description(description)?;
        r.emit_line(sl!["case class ", class_name, " ("]);
        r.indent(|r| {
            let mut count = property_count;
            let mut first = true;
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
                let graph = r.type_graph();
                let kind = graph.kind(p.type_ref)?;
                let nullable =
                    kind == TypeKind::Union && nullable_from_union(graph, p.type_ref)?.is_some();
                let nullable_or_optional = p.is_optional || kind == TypeKind::Null || nullable;
                count -= 1;
                let last = count == 0;

                let description = r.description_for_class_property(c, json_name)?;
                let has_meta = description.is_some();
                if has_meta && !first {
                    r.ensure_blank_line();
                }
                if let Some(description) = description {
                    r.emit_description(Some(description))?;
                }

                r.emit_property_annotation(name, json_name)?;
                let field_name: Source = if property_name_needs_mapping(json_name)? {
                    name.into()
                } else {
                    backticked_name(json_name).into()
                };
                let scala_type = if p.is_optional {
                    sl!["Option[", r.scala_type(p.type_ref, true, true)?, "]"]
                } else {
                    r.scala_type(p.type_ref, true, false)?
                };
                let default = if p.is_optional
                    || (nullable_or_optional && r.scala3().options.framework != Framework::Upickle)
                {
                    " = None"
                } else {
                    ""
                };
                r.emit_line(sl![
                    "val ",
                    field_name,
                    " : ",
                    scala_type,
                    default,
                    if last { "" } else { "," }
                ]);

                if has_meta && !last {
                    r.ensure_blank_line();
                }

                first = false;
                Ok(())
            })
        })?;

        r.emit_class_definition_methods(c, class_name)?;
        r.emit_class_definition_postamble(c, class_name)
    }

    /// `emitEnumDefinition(e, enumName)`: a Scala 3 `enum`.
    pub fn emit_enum_definition<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        e: TypeRef,
        enum_name: Name,
    ) -> Result<()> {
        let description = r.description_for_type(e)?;
        r.emit_description(description)?;

        emit_block(
            r,
            sl!["enum ", enum_name, " : "],
            BlockDelimiter::None,
            |r| {
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                    r.emit_line(sl!["case ", name]);
                    Ok(())
                })
            },
        )
    }

    /// `emitUnionDefinition(u, unionName)`: a union type alias.
    ///
    /// The TypeScript repeats this method, with codecs added, in
    /// `CirceRenderer` and `UpickleRenderer`; so does the port.
    pub fn emit_union_definition<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        u: TypeRef,
        union_name: Name,
    ) -> Result<()> {
        let description = r.description_for_type(u)?;
        r.emit_description(description)?;

        // `sortBy(t)`: classes first, then the other kinds by name.
        let graph = r.type_graph();
        let mut sort_keys: IndexMap<TypeRef, String> = IndexMap::new();
        for &member in graph.type_at(u)?.members()? {
            let kind = graph.kind(member)?;
            let key = if kind == TypeKind::Class {
                kind.as_str().to_owned()
            } else {
                format!("_{}", kind.as_str())
            };
            sort_keys.insert(member, key);
        }
        let sort_by = |t: TypeRef| sort_keys.get(&t).cloned().unwrap_or_default();
        let (maybe_null, non_nulls) =
            remove_null_from_union(graph, u, NullRemovalSort::By(&sort_by))?;
        let mut the_types: Vec<Source> = Vec::new();
        r.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, _, t, _| {
                the_types.push(r.scala_type(t, false, false)?);
                Ok(())
            },
        )?;
        if let Some(null_type) = maybe_null {
            the_types.push(r.name_for_union_member(u, null_type)?.into());
        }

        r.emit_item(sl!["type ", union_name, " = "]);
        for (i, t) in the_types.into_iter().enumerate() {
            if i == 0 {
                r.emit_item(t);
            } else {
                r.emit_item(sl![" | ", t]);
            }
        }
        r.ensure_blank_line();
        Ok(())
    }
}

/// The `ConvenienceRenderer` hooks TS `Scala3Renderer` overrides; every
/// other hook is the framework default.
pub mod scala3_hooks {
    pub use crate::convenience_renderer::defaults::*;

    use super::super::constants::{FORBIDDEN_PROPERTY_NAMES, FORBIDDEN_TYPE_NAMES, KEYWORDS};
    use super::super::utils::{enum_case_name_style, scala_name_style};
    use super::Scala3RendererFamily;
    use crate::convenience_renderer::ForbiddenWordsInfo;
    use crate::convenience_renderer::prelude::*;
    use crate::support::comments::CommentOptions;
    use crate::ty::ty::ClassProperty;

    fn strings(words: &[&[&str]]) -> Vec<String> {
        words
            .iter()
            .flat_map(|w| w.iter())
            .map(|&w| w.to_owned())
            .collect()
    }

    /// Keywords and the type names the generated code uses.
    pub fn forbidden_names_for_global_namespace<'a, R: Scala3RendererFamily<'a>>(
        _r: &mut R,
    ) -> Result<Vec<String>> {
        Ok(strings(&[&KEYWORDS, &FORBIDDEN_TYPE_NAMES]))
    }

    /// Keywords and `java.lang.Object` methods, not the global names.
    pub fn forbidden_for_object_properties<'a, R: Scala3RendererFamily<'a>>(
        _r: &mut R,
        _o: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: strings(&[&KEYWORDS, &FORBIDDEN_PROPERTY_NAMES])
                .into_iter()
                .map(Into::into)
                .collect(),
            include_global_forbidden: false,
        })
    }

    /// `_` and the keywords.
    pub fn forbidden_for_enum_cases<'a, R: Scala3RendererFamily<'a>>(
        _r: &mut R,
        _e: TypeRef,
        _enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: strings(&[&["_"], &KEYWORDS])
                .into_iter()
                .map(Into::into)
                .collect(),
            include_global_forbidden: false,
        })
    }

    /// Nothing.
    pub fn forbidden_for_union_members<'a, R: Scala3RendererFamily<'a>>(
        _r: &mut R,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: false,
        })
    }

    /// `upperNamingFunction`.
    pub fn make_named_type_namer<'a, R: Scala3RendererFamily<'a>>(r: &mut R) -> Namer {
        r.scala3().upper_naming_function.clone()
    }

    /// `lowerNamingFunction`.
    pub fn namer_for_object_property<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(r.scala3().lower_naming_function.clone()))
    }

    /// A new namer: the PascalCase name followed by `Value`.
    pub fn make_union_member_namer<'a, R: Scala3RendererFamily<'a>>(_r: &mut R) -> Option<Namer> {
        Some(fun_prefix_namer("upper", |s| {
            format!("{}Value", scala_name_style(true, s))
        }))
    }

    /// A new namer with [`enum_case_name_style`].
    pub fn make_enum_case_namer<'a, R: Scala3RendererFamily<'a>>(_r: &mut R) -> Option<Namer> {
        Some(fun_prefix_namer("upper", enum_case_name_style))
    }

    /// A `/** ... */` block.
    pub fn emit_description_block<'a, R: Scala3RendererFamily<'a>>(
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

    /// The header, top-level aliases and the named types.
    pub fn emit_source_structure<'a, R: Scala3RendererFamily<'a>>(
        r: &mut R,
        _given_output_filename: &str,
    ) -> Result<()> {
        r.emit_header()?;

        // Top-level arrays, maps, and primitives
        r.for_each_top_level(BlankLinePosition::Leading, |r, t, name, _| {
            let ty = r.type_graph().type_at(t)?;
            if ty.is_array() {
                r.emit_top_level_array(t, name)?;
            } else if ty.is_map() {
                r.emit_top_level_map(t, name)?;
            } else if ty.is_primitive() {
                let scala_type = r.scala_type(t, false, false)?;
                r.emit_line(sl!["type ", name, " = ", scala_type]);
            }
            Ok(())
        })?;

        r.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| r.emit_class_definition(c, n),
            |r, e, n, _| r.emit_enum_definition(e, n),
            |r, u, n, _| r.emit_union_definition(u, n),
        )?;
        Ok(())
    }
}

/// `Scala3Renderer`: the `--just-types` renderer.
pub struct Scala3Renderer<'a> {
    core: ConvenienceRendererCore<'a>,
    scala3: Scala3State,
}

impl std::fmt::Debug for Scala3Renderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("Scala3Renderer")
            .field("scala3", &self.scala3)
            .finish_non_exhaustive()
    }
}

impl<'a> Scala3Renderer<'a> {
    /// `new Scala3Renderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: Scala3Options,
    ) -> Self {
        Scala3Renderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            scala3: Scala3State::new(options),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for Scala3Renderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(scala3_hooks);
}

impl<'a> Scala3RendererFamily<'a> for Scala3Renderer<'a> {
    fn scala3(&self) -> &Scala3State {
        &self.scala3
    }
}
