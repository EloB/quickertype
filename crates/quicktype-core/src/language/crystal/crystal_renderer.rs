//! Port of `packages/quicktype-core/src/language/Crystal/CrystalRenderer.ts`.
//!
//! Renders `JSON::Serializable` classes and `alias`es for unions and
//! top-levels.

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::support::recursion::guard;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::constants::KEYWORDS;
use super::utils::{camel_naming_function, crystal_string_escape, snake_naming_function};

/// `CrystalRenderer`.
pub struct CrystalRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    /// `camelNamingFunction` (a module-level singleton in TypeScript).
    camel_naming_function: Namer,
    /// `snakeNamingFunction` (a module-level singleton in TypeScript).
    snake_naming_function: Namer,
}

impl std::fmt::Debug for CrystalRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CrystalRenderer").finish_non_exhaustive()
    }
}

impl<'a> CrystalRenderer<'a> {
    /// `new CrystalRenderer(targetLanguage, renderContext)`.
    pub fn new(target_language: &'a dyn TargetLanguage, render_context: RenderContext<'a>) -> Self {
        CrystalRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            camel_naming_function: camel_naming_function(),
            snake_naming_function: snake_naming_function(),
        }
    }

    /// `nullableCrystalType(t, withIssues)`: `T?`.
    fn nullable_crystal_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        Ok(sl![self.crystal_type(t, with_issues)?, "?"])
    }

    /// `crystalType(t, withIssues)`: the Crystal type of `t`.
    fn crystal_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => {
                    maybe_annotated(with_issues, any_type_issue_annotation(), "JSON::Any?")
                }
                TypeKind::Null => maybe_annotated(with_issues, null_type_issue_annotation(), "Nil"),
                TypeKind::Bool => "Bool".into(),
                TypeKind::Integer => "Int64".into(),
                TypeKind::Double => "Float64".into(),
                TypeKind::String => "String".into(),
                TypeKind::Array => sl!["Array(", self.crystal_type(ty.items()?, with_issues)?, ")"],
                TypeKind::Class => self.name_for_named_type(t)?.into(),
                TypeKind::Map => sl![
                    "Hash(String, ",
                    self.crystal_type(ty.map_values()?, with_issues)?,
                    ")"
                ],
                TypeKind::Enum => "String".into(),
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.nullable_crystal_type(nullable, with_issues);
                    }
                    let (has_null, _) = remove_null_from_union(graph, t, NullRemovalSort::None)?;
                    let name = self.name_for_named_type(t)?;
                    if has_null.is_some() {
                        sl![name, "?"]
                    } else {
                        name.into()
                    }
                }
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `breakCycle(t, withIssues)`.
    fn break_cycle(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        self.crystal_type(t, with_issues)
    }

    /// `emitRenameAttribute(propName, jsonName)`: `@[JSON::Field(key: ...)]`
    /// unless the property name is the JSON name.
    fn emit_rename_attribute(&mut self, prop_name: Name, json_name: &str) -> Result<()> {
        let escaped_name = crystal_string_escape(json_name);
        let names_differ = self.sourcelike_to_string(&prop_name.into())? != escaped_name;
        if names_differ {
            self.emit_line(sl!["@[JSON::Field(key: \"", escaped_name, "\")]"]);
        }
        Ok(())
    }

    /// `emitStructDefinition(c, className)`.
    fn emit_struct_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;

        self.emit_block(sl!["class ", class_name], |r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, prop, _| {
                r.ensure_blank_line();
                let description = r.description_for_class_property(c, json_name)?;
                r.emit_description(description)?;
                r.emit_rename_attribute(name, json_name)?;
                let crystal_type = r.crystal_type(prop.type_ref, true)?;
                r.emit_line(sl!["property ", name, " : ", crystal_type]);
                Ok(())
            })
        })
    }

    /// `emitBlock(line, f)`: a class that includes `JSON::Serializable`.
    fn emit_block(&mut self, line: Source, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_line(line);
        self.indent(|r| {
            r.emit_line("include JSON::Serializable");
            Ok(())
        })?;
        self.ensure_blank_line();
        self.indent(f)?;
        self.emit_line("end");
        Ok(())
    }

    /// `emitUnion(u, unionName)`: nothing for `T | null`, which is `T?`.
    fn emit_union(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let graph = self.type_graph();
        if nullable_from_union(graph, u)?.is_some() {
            return Ok(());
        }

        let description = self.description_for_type(u)?;
        self.emit_description(description)?;

        let (_, non_nulls) = remove_null_from_union(graph, u, NullRemovalSort::None)?;

        let mut types: Vec<Source> = Vec::new();
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, _name, t, _| {
                types.push(r.break_cycle(t, true)?);
                Ok(())
            },
        )?;

        let mut strings = Vec::with_capacity(types.len());
        for t in &types {
            strings.push(self.sourcelike_to_string(t)?);
        }
        self.emit_line(sl!["alias ", union_name, " = ", strings.join(" | ")]);
        Ok(())
    }

    /// `emitTopLevelAlias(t, name)`.
    fn emit_top_level_alias(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let crystal_type = self.crystal_type(t, false)?;
        self.emit_line(sl!["alias ", name, " = ", crystal_type]);
        Ok(())
    }

    /// `emitLeadingComments()`.
    fn emit_leading_comments(&mut self) -> Result<()> {
        if let Some(comments) = self.leading_comments() {
            self.emit_comments(comments)?;
        }
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for CrystalRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.camel_naming_function.clone()
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.snake_naming_function.clone()))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.camel_naming_function.clone())
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.camel_naming_function.clone())
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(KEYWORDS.iter().map(|&k| k.to_owned()).collect())
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

    fn forbidden_for_union_members(
        &mut self,
        _u: TypeRef,
        _union_name: Name,
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

    fn comment_line_start(&self) -> &'static str {
        "# "
    }

    fn is_implicit_cycle_breaker(&self, t: TypeRef) -> Result<bool> {
        let kind = self.type_graph().kind(t)?;
        Ok(kind == TypeKind::Array || kind == TypeKind::Map)
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        self.emit_leading_comments()?;
        self.ensure_blank_line();
        self.emit_line("require \"json\"");

        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| {
                Ok(r.type_graph().kind(t)? == TypeKind::Enum
                    || r.named_type_to_name_for_top_level(t)?.is_none())
            },
            |r, t, name, _| r.emit_top_level_alias(t, name),
        )?;

        self.for_each_object(BlankLinePosition::LeadingAndInterposing, |r, c, name, _| {
            r.emit_struct_definition(c, name)
        })?;
        self.for_each_union(BlankLinePosition::LeadingAndInterposing, |r, u, name, _| {
            r.emit_union(u, name)
        })
    }
}
