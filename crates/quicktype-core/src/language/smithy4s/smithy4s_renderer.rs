//! Port of `packages/quicktype-core/src/language/Smithy4s/Smithy4sRenderer.ts`.
//!
//! Renders a Smithy 2 model: structures, enums, untagged unions and the
//! lists and maps they use.
//!
//! The TypeScript class started as a copy of `Scala3Renderer` (`emitBlock`,
//! `scalaType`, the class-definition loop) and does not share code with
//! it; the port mirrors that.

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::renderer_options::RendererOptions;
use crate::support::comments::CommentOptions;
use crate::support::recursion::guard;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::constants::KEYWORDS;
use super::language::{JUST_TYPES, PACKAGE_NAME};
use super::utils::{
    lower_naming_function, scala_name_style, should_add_backtick, upper_naming_function,
};

/// The option values of the Smithy renderer (TS
/// `OptionValues<typeof smithyOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct SmithyOptions {
    /// `justTypes`: accepted for consistency; plain types are the only
    /// mode Smithy supports.
    pub just_types: bool,
    /// `packageName`: the Smithy namespace.
    pub package_name: String,
}

impl SmithyOptions {
    /// `getOptionValues(smithyOptions, values)`.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        Ok(SmithyOptions {
            just_types: JUST_TYPES.get_value(values),
            package_name: PACKAGE_NAME.get_value(values).into_owned(),
        })
    }
}

/// `Smithy4sRenderer`.
pub struct Smithy4sRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: SmithyOptions,
    /// `upperNamingFunction` (a module-level singleton in TypeScript).
    upper_naming_function: Namer,
    /// `lowerNamingFunction` (a module-level singleton in TypeScript).
    lower_naming_function: Namer,
}

impl std::fmt::Debug for Smithy4sRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("Smithy4sRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// `String.fromCharCode(code)`.
fn from_char_code(code: usize) -> String {
    quicktype_js_compat::utf16::units_to_string(&[(code & 0xFFFF) as u16])
}

impl<'a> Smithy4sRenderer<'a> {
    /// `new Smithy4sRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: SmithyOptions,
    ) -> Self {
        Smithy4sRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            upper_naming_function: upper_naming_function(),
            lower_naming_function: lower_naming_function(),
        }
    }

    /// `anySourceType(optional)`: `Document`.
    fn any_source_type(&self) -> Source {
        sl!["Document"]
    }

    /// `arrayType(arrayType)`: the list shape named after the array.
    fn array_type(&self, t: TypeRef) -> Result<Source> {
        Ok(format!("{}List", self.type_graph().combined_name(t)?).into())
    }

    /// `mapType(mapType)`: the map shape named after the map.
    fn map_type(&self, t: TypeRef) -> Result<Source> {
        Ok(format!("{}Map", self.type_graph().combined_name(t)?).into())
    }

    /// `scalaType(t, withIssues, noOptional)`.
    fn scala_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            Ok(match graph.kind(t)? {
                TypeKind::Any => maybe_annotated(
                    with_issues,
                    any_type_issue_annotation(),
                    self.any_source_type(),
                ),
                TypeKind::Null => maybe_annotated(
                    with_issues,
                    null_type_issue_annotation(),
                    self.any_source_type(),
                ),
                TypeKind::Bool => "Boolean".into(),
                TypeKind::Integer => "Long".into(),
                TypeKind::Double => "Double".into(),
                TypeKind::String => "String".into(),
                TypeKind::Array => self.array_type(t)?,
                TypeKind::Class | TypeKind::Enum => self.name_for_named_type(t)?.into(),
                TypeKind::Map => self.map_type(t)?,
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return Ok(sl![self.scala_type(nullable, with_issues)?]);
                    }
                    self.name_for_named_type(t)?.into()
                }
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `emitHeader()`.
    fn emit_header(&mut self) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        }

        self.ensure_blank_line();
        self.emit_line("$version: \"2\"");
        let package_name = self.options.package_name.clone();
        self.emit_line(sl!["namespace ", package_name]);
        self.ensure_blank_line();

        self.emit_line("document NullValue");
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitTopLevelArray(t, name)`.
    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let items = self.type_graph().type_at(t)?.items()?;
        let element_type = self.scala_type(items, false)?;
        self.emit_line(sl!["list ", name, " { member : ", element_type, "}"]);
        Ok(())
    }

    /// `emitTopLevelMap(t, name)`.
    fn emit_top_level_map(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let values = self.type_graph().type_at(t)?.map_values()?;
        let element_type = self.scala_type(values, false)?;
        self.emit_line(sl![
            "map ",
            name,
            " { map[ key : String , value : ",
            element_type,
            "}"
        ]);
        Ok(())
    }

    /// `emitEmptyClassDefinition(c, className)`.
    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_line(sl!["structure ", class_name, "{}"]);
        Ok(())
    }

    /// `emitClassDefinition(c, className)`: a structure, then the list and
    /// map shapes of its array and map properties.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let property_count = self.type_graph().type_at(c)?.properties()?.len();
        if property_count == 0 {
            return self.emit_empty_class_definition(c, class_name);
        }

        let mut emit_later: Vec<TypeRef> = Vec::new();

        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_line(sl!["structure ", class_name, " {"]);
        self.indent(|r| {
            let mut count = property_count;
            let mut first = true;

            r.for_each_class_property(c, BlankLinePosition::None, |r, _, json_name, p, _| {
                let graph = r.type_graph();
                let kind = graph.kind(p.type_ref)?;
                let nullable =
                    kind == TypeKind::Union && nullable_from_union(graph, p.type_ref)?.is_some();
                let nullable_or_optional = p.is_optional || kind == TypeKind::Null || nullable;
                count -= 1;
                let last = count == 0;

                if kind == TypeKind::Array || kind == TypeKind::Map {
                    emit_later.push(p.type_ref);
                }

                let description = r.description_for_class_property(c, json_name)?;
                let has_meta = description.is_some();
                if has_meta && !first {
                    r.ensure_blank_line();
                }
                if let Some(description) = description {
                    r.emit_description(Some(description))?;
                }

                let name_needs_backticks =
                    json_name.ends_with('_') || should_add_backtick(json_name);
                let name_with_backticks = if name_needs_backticks {
                    format!("`{json_name}`")
                } else {
                    json_name.to_owned()
                };
                let scala_type = sl![r.scala_type(p.type_ref, true)?];
                r.emit_line(sl![
                    if p.is_optional || nullable_or_optional {
                        ""
                    } else {
                        "@required "
                    },
                    name_with_backticks,
                    " : ",
                    scala_type,
                    if last { "" } else { "," }
                ]);

                if has_meta && !last {
                    r.ensure_blank_line();
                }

                first = false;
                Ok(())
            })
        })?;
        self.emit_class_definition_methods(&emit_later)
    }

    /// The `list` or `map` shape of an array or map type.
    fn emit_compound_shape(&mut self, t: TypeRef) -> Result<()> {
        let ty = self.type_graph().type_at(t)?;
        if ty.is_array() {
            let shape = self.scala_type(t, true)?;
            let member = self.scala_type(ty.items()?, true)?;
            self.emit_line(sl!["list ", shape, "{ member: ", member, "}"]);
        } else if ty.is_map() {
            let shape = self.scala_type(t, true)?;
            let value = self.scala_type(ty.map_values()?, true)?;
            self.emit_line(sl!["map ", shape, "{ key: String , value: ", value, "}"]);
        }
        Ok(())
    }

    /// `emitClassDefinitionMethods(arrayTypes)`: closes the structure and
    /// emits the shapes of its array and map properties.
    fn emit_class_definition_methods(&mut self, array_types: &[TypeRef]) -> Result<()> {
        self.emit_line("}");
        for &t in array_types {
            self.emit_compound_shape(t)?;
        }
        Ok(())
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;

        self.ensure_blank_line();
        self.emit_item(sl!["enum ", enum_name, " { "]);
        let mut count = self.type_graph().type_at(e)?.cases()?.len();

        self.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
            r.emit_line_parts(Vec::new());

            r.emit_item(sl![name, " = \"", json_name, "\""]);

            count = count.saturating_sub(1);
            if count > 0 {
                r.emit_item(sl![","]);
            }
            Ok(())
        })?;

        self.ensure_blank_line();
        self.emit_item(sl!["}"]);
        Ok(())
    }

    /// `emitUnionDefinition(u, unionName)`: an untagged union with members
    /// `A`, `B`, …, then the shapes of its array and map members.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let mut emit_later: Vec<TypeRef> = Vec::new();

        let description = self.description_for_type(u)?;
        self.emit_description(description)?;

        // TypeScript sorts the members by kind (`class` first) here, but
        // `forEachUnionMember` orders them by name anyway.
        let (maybe_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        let mut the_types: Vec<Source> = Vec::new();
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, _, t, _| {
                let kind = r.type_graph().kind(t)?;
                if kind == TypeKind::Array || kind == TypeKind::Map {
                    emit_later.push(t);
                }
                the_types.push(r.scala_type(t, false)?);
                Ok(())
            },
        )?;
        if let Some(null_type) = maybe_null {
            the_types.push(self.name_for_union_member(u, null_type)?.into());
        }

        self.emit_line(sl!["@untagged union ", union_name, " { "]);
        self.indent(|r| {
            for (i, t) in the_types.into_iter().enumerate() {
                r.emit_line(sl![from_char_code(i + 65), " : ", t]);
            }
            Ok(())
        })?;
        self.emit_line("}");
        self.ensure_blank_line();

        for t in emit_later {
            self.emit_compound_shape(t)?;
        }
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for Smithy4sRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(KEYWORDS.iter().map(|&k| k.to_owned()).collect())
    }

    fn forbidden_for_object_properties(
        &mut self,
        _o: TypeRef,
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
            include_global_forbidden: false,
        })
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

    /// A new namer: the PascalCase name followed by `Value`.
    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer("upper", |s| {
            format!("{}Value", scala_name_style(true, s))
        }))
    }

    /// A new namer that removes the first space (`s.replace(" ", "")`).
    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer("upper", |s| s.replacen(' ', "", 1)))
    }

    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        self.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some(" * ".to_owned()),
                before_comment: Some("/**".to_owned()),
                after_comment: Some(" */".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        self.emit_header()?;

        // Top-level arrays, maps
        self.for_each_top_level(BlankLinePosition::Leading, |r, t, name, _| {
            let ty = r.type_graph().type_at(t)?;
            if ty.is_array() {
                r.emit_top_level_array(t, name)?;
            } else if ty.is_map() {
                r.emit_top_level_map(t, name)?;
            }
            Ok(())
        })?;

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| r.emit_class_definition(c, n),
            |r, e, n, _| r.emit_enum_definition(e, n),
            |r, u, n, _| r.emit_union_definition(u, n),
        )
    }
}
