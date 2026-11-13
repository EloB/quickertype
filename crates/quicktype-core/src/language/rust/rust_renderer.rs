//! Port of `packages/quicktype-core/src/language/Rust/RustRenderer.ts`.
//!
//! Renders serde structs, enums and untagged unions.

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::attributes::constraints::min_max_value_for_type;
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::renderer_options::RendererOptions;
use crate::support::recursion::guard;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::constants::KEYWORDS;
use super::language::{
    DENSITY, DERIVE_CLONE, DERIVE_DEBUG, DERIVE_PARTIAL_EQ, INTEGER_TYPE, IntegerType,
    LEADING_COMMENTS, SKIP_SERIALIZING_NONE, VISIBILITY,
};
use super::utils::{
    Density, NamingStyleKey, Visibility, camel_naming_function, get_preferred_naming_style,
    list_matching_naming_styles, name_with_naming_style, rust_string_escape, snake_naming_function,
};

/// The option values of the Rust renderer (TS
/// `OptionValues<typeof rustOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct RustOptions {
    /// `density`.
    pub density: Density,
    /// `visibility`.
    pub visibility: Visibility,
    /// `integerType`.
    pub integer_type: IntegerType,
    /// `deriveDebug`.
    pub derive_debug: bool,
    /// `deriveClone`.
    pub derive_clone: bool,
    /// `derivePartialEq`.
    pub derive_partial_eq: bool,
    /// `skipSerializingNone`.
    pub skip_serializing_none: bool,
    /// `leadingComments`.
    pub leading_comments: bool,
}

impl RustOptions {
    /// `getOptionValues(rustOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let density = match DENSITY.get_enum_value(values)? {
            "dense" => Density::Dense,
            _ => Density::Normal,
        };
        let visibility = match VISIBILITY.get_enum_value(values)? {
            "private" => Visibility::Private,
            "crate" => Visibility::Crate,
            _ => Visibility::Public,
        };
        let integer_type = match INTEGER_TYPE.get_enum_value(values)? {
            "force-i32" => IntegerType::ForceI32,
            "force-i64" => IntegerType::ForceI64,
            _ => IntegerType::Conservative,
        };
        Ok(RustOptions {
            density,
            visibility,
            integer_type,
            derive_debug: DERIVE_DEBUG.get_value(values),
            derive_clone: DERIVE_CLONE.get_value(values),
            derive_partial_eq: DERIVE_PARTIAL_EQ.get_value(values),
            skip_serializing_none: SKIP_SERIALIZING_NONE.get_value(values),
            leading_comments: LEADING_COMMENTS.get_value(values),
        })
    }
}

/// `RustRenderer`.
pub struct RustRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: RustOptions,
    /// `snakeNamingFunction` (a module-level singleton in TypeScript).
    snake_naming_function: Namer,
    /// `camelNamingFunction` (a module-level singleton in TypeScript).
    camel_naming_function: Namer,
}

impl std::fmt::Debug for RustRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("RustRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> RustRenderer<'a> {
    /// `new RustRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: RustOptions,
    ) -> Self {
        RustRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            snake_naming_function: snake_naming_function(),
            camel_naming_function: camel_naming_function(),
        }
    }

    /// `getIntegerType(integerType)`.
    fn get_integer_type(&self, integer_type: TypeRef) -> Result<&'static str> {
        Ok(match self.options.integer_type {
            IntegerType::ForceI32 => "i32",
            IntegerType::ForceI64 => "i64",
            IntegerType::Conservative => {
                // Conservative: use i32 only when the schema bounds the
                // integer on *both* sides and both bounds fit in i32.
                let Some(min_max) = min_max_value_for_type(self.type_graph(), integer_type)? else {
                    return Ok("i64");
                };
                let (Some(min), Some(max)) = (min_max.0, min_max.1) else {
                    return Ok("i64");
                };
                let i32_min = -2147483648.0;
                let i32_max = 2147483647.0;
                if min >= i32_min && max <= i32_max {
                    "i32"
                } else {
                    "i64"
                }
            }
        })
    }

    /// `nullableRustType(t, withIssues)`.
    fn nullable_rust_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        Ok(sl!["Option<", self.break_cycle(t, with_issues)?, ">"])
    }

    /// `rustType(t, withIssues)`.
    fn rust_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => maybe_annotated(
                    with_issues,
                    any_type_issue_annotation(),
                    "Option<serde_json::Value>",
                ),
                TypeKind::Null => maybe_annotated(
                    with_issues,
                    null_type_issue_annotation(),
                    "Option<serde_json::Value>",
                ),
                TypeKind::Bool => "bool".into(),
                TypeKind::Integer => self.get_integer_type(t)?.into(),
                TypeKind::Double => "f64".into(),
                TypeKind::String => "String".into(),
                TypeKind::Array => sl!["Vec<", self.rust_type(ty.items()?, with_issues)?, ">"],
                TypeKind::Class => self.name_for_named_type(t)?.into(),
                TypeKind::Map => sl![
                    "HashMap<String, ",
                    self.rust_type(ty.map_values()?, with_issues)?,
                    ">"
                ],
                TypeKind::Enum => self.name_for_named_type(t)?.into(),
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.nullable_rust_type(nullable, with_issues);
                    }
                    let (has_null, _) = remove_null_from_union(graph, t, NullRemovalSort::None)?;
                    let is_cycle_breaker = self.is_cycle_breaker_type(t)?;
                    let name: Source = if is_cycle_breaker {
                        sl!["Box<", self.name_for_named_type(t)?, ">"]
                    } else {
                        self.name_for_named_type(t)?.into()
                    };
                    if has_null.is_some() {
                        sl!["Option<", name, ">"]
                    } else {
                        name
                    }
                }
                TypeKind::Intersection => {
                    return crate::support::support::panic("Unknown type intersection");
                }
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `breakCycle(t, withIssues)`: boxes cycle breakers, except a
    /// nullable union whose member is already boxed.
    fn break_cycle(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        let rust_type = self.rust_type(t, with_issues)?;
        let is_cycle_breaker = self.is_cycle_breaker_type(t)?;

        if is_cycle_breaker && self.type_graph().type_at(t)?.is_union() {
            match nullable_from_union(self.type_graph(), t)? {
                None => return Ok(rust_type),
                Some(nullable) if self.is_cycle_breaker_type(nullable)? => return Ok(rust_type),
                Some(_) => {}
            }
        }

        Ok(if is_cycle_breaker {
            sl!["Box<", rust_type, ">"]
        } else {
            rust_type
        })
    }

    /// `emitRenameAttribute(propName, jsonName, defaultNamingStyle,
    /// preferedNamingStyle)`: `#[serde(rename = ...)]` unless the struct's
    /// `rename_all` already produces the JSON name.
    fn emit_rename_attribute(
        &mut self,
        prop_name: Name,
        json_name: &str,
        default_naming_style: NamingStyleKey,
        prefered_naming_style: NamingStyleKey,
    ) -> Result<()> {
        let escaped_name = rust_string_escape(json_name);
        let prop_name_string = self.sourcelike_to_string(&prop_name.into())?;
        let parts: Vec<&str> = prop_name_string.split(' ').collect();
        let name = default_naming_style.from_parts(&parts);
        let styled_name = name_with_naming_style(&name, prefered_naming_style);
        let names_differ = escaped_name != styled_name;
        if names_differ {
            self.emit_line(sl!["#[serde(rename = \"", escaped_name, "\")]"]);
        }
        Ok(())
    }

    /// `emitSkipSerializeNone(t)`.
    fn emit_skip_serialize_none(&mut self, t: TypeRef) -> Result<()> {
        let graph = self.type_graph();
        if graph.type_at(t)?.is_union() && nullable_from_union(graph, t)?.is_some() {
            self.emit_line("#[serde(skip_serializing_if = \"Option::is_none\")]");
        }
        Ok(())
    }

    /// `visibility`.
    fn visibility(&self) -> &'static str {
        match self.options.visibility {
            Visibility::Crate => "pub(crate) ",
            Visibility::Public => "pub ",
            Visibility::Private => "",
        }
    }

    /// The `#[derive(...)]` line.
    fn emit_derive_line(&mut self) {
        let o = self.options;
        self.emit_line(sl![
            "#[derive(",
            if o.derive_debug { "Debug, " } else { "" },
            if o.derive_clone { "Clone, " } else { "" },
            if o.derive_partial_eq {
                "PartialEq, "
            } else {
                ""
            },
            "Serialize, Deserialize)]"
        ]);
    }

    fn blank_lines(&self) -> BlankLinePosition {
        match self.options.density {
            Density::Dense => BlankLinePosition::None,
            Density::Normal => BlankLinePosition::Interposing,
        }
    }

    /// `emitStructDefinition(c, className)`.
    fn emit_struct_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_derive_line();

        // List the possible naming styles for every class property
        let mut properties_naming_styles: Vec<NamingStyleKey> = Vec::new();
        self.for_each_class_property(c, BlankLinePosition::None, |_, _, json_name, _, _| {
            properties_naming_styles.extend(list_matching_naming_styles(json_name));
            Ok(())
        })?;

        // Set the default naming style on the struct
        let default_style = NamingStyleKey::SnakeCase;
        let prefered_naming_style =
            get_preferred_naming_style(&properties_naming_styles, default_style);
        if prefered_naming_style != default_style {
            self.emit_line(format!(
                "#[serde(rename_all = \"{}\")]",
                prefered_naming_style.as_str()
            ));
        }

        let blank_lines = self.blank_lines();
        self.emit_block(sl!["pub struct ", class_name], |r| {
            r.for_each_class_property(c, blank_lines, |r, name, json_name, prop, _| {
                let description = r.description_for_class_property(c, json_name)?;
                r.emit_description(description)?;
                r.emit_rename_attribute(name, json_name, default_style, prefered_naming_style)?;
                if r.options.skip_serializing_none {
                    r.emit_skip_serialize_none(prop.type_ref)?;
                }
                let rust_type = r.break_cycle(prop.type_ref, true)?;
                let visibility = r.visibility();
                r.emit_line(sl![visibility, name, ": ", rust_type, ","]);
                Ok(())
            })
        })
    }

    /// `emitBlock(line, f)`.
    fn emit_block(&mut self, line: Source, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_line(sl![line, " {"]);
        self.indent(f)?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitUnion(u, unionName)`: nothing for `T | null`, which is an
    /// `Option`.
    fn emit_union(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let graph = self.type_graph();
        if nullable_from_union(graph, u)?.is_some() {
            return Ok(());
        }

        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        self.emit_derive_line();
        self.emit_line("#[serde(untagged)]");

        let (_, non_nulls) = remove_null_from_union(graph, u, NullRemovalSort::None)?;

        let blank_lines = self.blank_lines();
        self.emit_block(sl!["pub enum ", union_name], |r| {
            r.for_each_union_member(
                u,
                Some(&non_nulls),
                blank_lines,
                None,
                |r, field_name, t, _| {
                    let rust_type = r.break_cycle(t, true)?;
                    r.emit_line(sl![field_name, "(", rust_type, "),"]);
                    Ok(())
                },
            )
        })
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_derive_line();

        // List the possible naming styles for every enum case
        let mut enum_cases_naming_styles: Vec<NamingStyleKey> = Vec::new();
        self.for_each_enum_case(e, BlankLinePosition::None, |_, _, json_name, _| {
            enum_cases_naming_styles.extend(list_matching_naming_styles(json_name));
            Ok(())
        })?;

        // Set the default naming style on the enum
        let default_style = NamingStyleKey::PascalCase;
        let prefered_naming_style =
            get_preferred_naming_style(&enum_cases_naming_styles, default_style);
        if prefered_naming_style != default_style {
            self.emit_line(format!(
                "#[serde(rename_all = \"{}\")]",
                prefered_naming_style.as_str()
            ));
        }

        let blank_lines = self.blank_lines();
        self.emit_block(sl!["pub enum ", enum_name], |r| {
            r.for_each_enum_case(e, blank_lines, |r, name, json_name, _| {
                r.emit_rename_attribute(name, json_name, default_style, prefered_naming_style)?;
                r.emit_line(sl![name, ","]);
                Ok(())
            })
        })
    }

    /// `emitTopLevelAlias(t, name)`.
    fn emit_top_level_alias(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let rust_type = self.rust_type(t, false)?;
        self.emit_line(sl!["pub type ", name, " = ", rust_type, ";"]);
        Ok(())
    }

    /// `emitLeadingComments()`.
    fn emit_leading_comments(&mut self) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            return self.emit_comments(leading_comments);
        }

        let Some((_, &top_level)) = self.top_levels().first() else {
            return Ok(());
        };

        let top_level_name = self.type_graph().combined_name(top_level)?;
        self.emit_multiline(&format!(
            "// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::{top_level_name};
//
// fn main() {{
//     let json = r#\"{{\"answer\": 42}}\"#;
//     let model: {top_level_name} = serde_json::from_str(&json).unwrap();
// }}"
        ))
    }
}

impl<'a> ConvenienceRenderer<'a> for RustRenderer<'a> {
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
        "/// "
    }

    fn is_implicit_cycle_breaker(&self, t: TypeRef) -> Result<bool> {
        let kind = self.type_graph().kind(t)?;
        Ok(kind == TypeKind::Array || kind == TypeKind::Map)
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        if self.options.leading_comments {
            self.emit_leading_comments()?;
        }

        self.ensure_blank_line();
        self.emit_line("use serde::{Serialize, Deserialize};");

        if self.have_maps()? {
            self.emit_line("use std::collections::HashMap;");
        }

        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, name, _| r.emit_top_level_alias(t, name),
        )?;

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, name, _| r.emit_struct_definition(c, name),
            |r, e, name, _| r.emit_enum_definition(e, name),
            |r, u, name, _| r.emit_union(u, name),
        )
    }
}
