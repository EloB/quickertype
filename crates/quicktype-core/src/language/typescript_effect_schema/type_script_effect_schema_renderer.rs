//! Port of `packages/quicktype-core/src/language/TypeScriptEffectSchema/TypeScriptEffectSchemaRenderer.ts`.
//!
//! Renders Effect `Schema` classes and literals. A reference to a class
//! that is not emitted yet is wrapped in `S.suspend`, so the output depends
//! on the order in which schemas are rendered (`emittedObjects`).

use std::collections::HashSet;

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::language::javascript::utils::legalize_name;
use crate::renderer_options::RendererOptions;
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::strings::{
    WordStyle, all_lower_word_style, capitalize, combine_words, first_upper_word_style,
    is_letter_or_underscore, split_into_words, string_escape, utf16_string_escape,
};
use crate::target_language::TargetLanguage;
use quicktype_js_compat::number::to_string as js_number;

use super::language::JUST_SCHEMA;

/// The option values of the Effect Schema renderer (TS
/// `OptionValues<typeof typeScriptEffectSchemaOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TypeScriptEffectSchemaOptions {
    /// `justSchema`.
    pub just_schema: bool,
}

impl TypeScriptEffectSchemaOptions {
    /// `getOptionValues(typeScriptEffectSchemaOptions, values)`.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        Ok(TypeScriptEffectSchemaOptions {
            just_schema: JUST_SCHEMA.get_value(values),
        })
    }
}

/// `nameStyle(original, upper)`: camel-case acronyms, and names start with
/// a letter or underscore.
fn name_style(original: &str, upper: bool) -> String {
    let acronyms = acronym_style(AcronymStyleOptions::Camel);
    let words = split_into_words(original);
    let first_acronym = move |s: &str| capitalize(&acronyms(s));
    let first_word_style: WordStyle<'_> = if upper {
        &first_upper_word_style
    } else {
        &all_lower_word_style
    };
    let first_word_acronym_style: WordStyle<'_> = if upper {
        &first_acronym
    } else {
        &all_lower_word_style
    };
    combine_words(
        &words,
        &legalize_name,
        first_word_style,
        &first_upper_word_style,
        first_word_acronym_style,
        &acronyms,
        "",
        &is_letter_or_underscore,
    )
}

/// `importStatement(lhs, moduleName)`.
fn import_statement(lhs: &str, module_name: &str) -> Source {
    sl!["import ", lhs, " from ", module_name, ";"]
}

/// `TypeScriptEffectSchemaRenderer`.
pub struct TypeScriptEffectSchemaRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: TypeScriptEffectSchemaOptions,
    /// `emittedObjects`: the classes and enums emitted so far.
    emitted_objects: HashSet<Name>,
}

impl std::fmt::Debug for TypeScriptEffectSchemaRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("TypeScriptEffectSchemaRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> TypeScriptEffectSchemaRenderer<'a> {
    /// `new TypeScriptEffectSchemaRenderer(targetLanguage, renderContext,
    /// options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: TypeScriptEffectSchemaOptions,
    ) -> Self {
        TypeScriptEffectSchemaRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            emitted_objects: HashSet::new(),
        }
    }

    /// `emitImports()`.
    fn emit_imports(&mut self) {
        self.ensure_blank_line();
        self.emit_line(import_statement("* as S", "\"effect/Schema\""));
    }

    /// `typeMapTypeForProperty(p)`.
    fn type_map_type_for_property(&self, p: &ClassProperty) -> Result<Source> {
        if !p.is_optional {
            return self.type_map_type_for(p.type_ref, true, false);
        }

        Ok(sl![
            "S.optional(",
            self.type_map_type_for(p.type_ref, true, false)?,
            ")"
        ])
    }

    /// `typeMapTypeFor(t, required, coerceStrings)`: the schema of `t`.
    fn type_map_type_for(
        &self,
        t: TypeRef,
        required: bool,
        coerce_strings: bool,
    ) -> Result<Source> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        let kind = ty.kind();
        if matches!(kind, TypeKind::Class | TypeKind::Object | TypeKind::Enum) {
            let name = self.name_for_named_type(t)?;
            if self.emitted_objects.contains(&name) {
                return Ok(sl![name]);
            }

            return Ok(sl!["S.suspend(() => ", name, ")"]);
        }

        let matched: Source = match kind {
            TypeKind::Any => "S.Any".into(),
            TypeKind::Null => "S.Null".into(),
            TypeKind::Bool => "S.Boolean".into(),
            TypeKind::Integer => self.number_schema(t, "S.Int")?,
            TypeKind::Double => self.number_schema(t, "S.Number")?,
            TypeKind::String => self.string_schema(t)?,
            TypeKind::Array => {
                let (min_items, max_items) = match min_max_items_for_type(graph, t)? {
                    Some(m) => (m.0, m.1),
                    None => (None, None),
                };
                let mut schema: Vec<Source> = vec![
                    "S.Array(".into(),
                    self.type_map_type_for(ty.items()?, false, false)?,
                    ")".into(),
                ];
                if let Some(min_items) = min_items.filter(|&m| m > 0.0) {
                    schema.extend([
                        ".pipe(S.minItems(".into(),
                        js_number(min_items).into(),
                        "))".into(),
                    ]);
                }
                if let Some(max_items) = max_items {
                    schema.extend([
                        ".pipe(S.maxItems(".into(),
                        js_number(max_items).into(),
                        "))".into(),
                    ]);
                }
                Source::Sequence(schema)
            }
            TypeKind::Map => sl![
                "S.Record({ key: S.String, value: ",
                self.type_map_type_for(ty.map_values()?, false, false)?,
                "})"
            ],
            TypeKind::Union => {
                let mut types: Vec<TypeRef> = graph.children(t)?.into_iter().collect();
                let mut coerce = false;
                for &member in &types {
                    coerce |= matches!(graph.kind(member)?, TypeKind::Bool | TypeKind::Integer);
                }
                let mut ranked: Vec<(u8, TypeRef)> = Vec::with_capacity(types.len());
                for member in types.drain(..) {
                    let rank = match graph.kind(member)? {
                        TypeKind::Class | TypeKind::Object => 1,
                        _ => 0,
                    };
                    ranked.push((rank, member));
                }
                ranked.sort_by_key(|&(rank, _)| rank);
                let mut children: Vec<Source> = Vec::new();
                let mut nullable = false;
                for (_, member) in ranked {
                    if graph.kind(member)? == TypeKind::Null {
                        nullable = true;
                    } else {
                        children.push(self.type_map_type_for(member, false, coerce)?);
                    }
                }

                if nullable && children.len() == 1 {
                    let child = children.remove(0);
                    sl!["S.NullOr(", child, ")"]
                } else {
                    let mut parts: Vec<Source> = vec!["S.Union(".into()];
                    for (i, child) in children.into_iter().enumerate() {
                        if i > 0 {
                            parts.push(", ".into());
                        }
                        parts.push(child);
                    }
                    parts.push(if nullable { ", S.Null)" } else { ")" }.into());
                    Source::Sequence(parts)
                }
            }
            TypeKind::Uuid => "S.UUID".into(),
            TypeKind::BoolString => {
                if coerce_strings {
                    "S.transform(S.Literal(\"true\", \"false\"), S.Boolean, { strict: true, decode: (value) => value === \"true\", encode: (value) => value ? \"true\" : \"false\" })".into()
                } else {
                    "S.Literal(\"true\", \"false\")".into()
                }
            }
            TypeKind::Date => r"S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/))".into(),
            TypeKind::Time => {
                r"S.String.pipe(S.pattern(/^\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))"
                    .into()
            }
            TypeKind::DateTime => {
                r"S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))"
                    .into()
            }
            TypeKind::IntegerString => {
                if coerce_strings {
                    "S.NumberFromString.pipe(S.int())".into()
                } else {
                    r"S.String.pipe(S.pattern(/^-?\d+$/))".into()
                }
            }
            k if k.is_transformed_string_type_kind() => "S.String".into(),
            kind => return type_not_supported(kind),
        };

        if required {
            return Ok(sl![matched]);
        }

        Ok(matched)
    }

    /// `stringSchema(t)`.
    fn string_schema(&self, t: TypeRef) -> Result<Source> {
        let graph = self.type_graph();
        let (min, max) = match min_max_length_for_type(graph, t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        let pattern = pattern_for_type(graph, t)?;
        let mut schema: Vec<Source> = vec!["S.String".into()];
        if let Some(min) = min {
            schema.push(
                format!(
                    ".pipe(S.filter(value => Array.from(value).length >= {}))",
                    js_number(min)
                )
                .into(),
            );
        }
        if let Some(max) = max {
            schema.push(
                format!(
                    ".pipe(S.filter(value => Array.from(value).length <= {}))",
                    js_number(max)
                )
                .into(),
            );
        }
        if let Some(pattern) = pattern {
            schema.push(
                format!(
                    ".pipe(S.pattern(new RegExp({})))",
                    quicktype_js_compat::json::quote(&pattern)
                )
                .into(),
            );
        }
        Ok(Source::Sequence(schema))
    }

    /// `numberSchema(t, base)`.
    fn number_schema(&self, t: TypeRef, base: &str) -> Result<Source> {
        let (min, max) = match min_max_value_for_type(self.type_graph(), t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        let mut schema: Vec<Source> = vec![base.into()];
        if let Some(min) = min {
            schema.extend([
                ".pipe(S.greaterThanOrEqualTo(".into(),
                js_number(min).into(),
                "))".into(),
            ]);
        }
        if let Some(max) = max {
            schema.extend([
                ".pipe(S.lessThanOrEqualTo(".into(),
                js_number(max).into(),
                "))".into(),
            ]);
        }
        Ok(Source::Sequence(schema))
    }

    /// `emitObject(name, t)`.
    fn emit_object(&mut self, name: Name, t: TypeRef) -> Result<()> {
        let properties = self.type_graph().type_at(t)?.properties()?;
        let no_properties = properties.is_empty();
        let has_to_string = properties.contains_key("toString");
        self.ensure_blank_line();
        self.emit_line(sl![
            "\nexport class ",
            name,
            " extends S.Class<",
            name,
            ">(\"",
            name,
            if no_properties {
                "\")(S.Struct({}).pipe(S.filter(value => typeof value === \"object\" && value !== null && !Array.isArray(value)))"
            } else {
                "\")({"
            }
        ]);
        self.indent(|r| {
            r.for_each_class_property(
                t,
                BlankLinePosition::None,
                |r, _, json_name, property, _| {
                    let type_map = r.type_map_type_for_property(&property)?;
                    r.emit_line(sl![
                        format!("\"{}\"", utf16_string_escape(json_name)),
                        ": ",
                        type_map,
                        ","
                    ]);
                    Ok(())
                },
            )
        })?;
        self.emit_line(if no_properties { ") {}" } else { "}) {}" });
        if has_to_string {
            self.emit_line(sl![
                "Object.defineProperty(",
                name,
                ".prototype, \"toString\", { writable: true });"
            ]);
        }
        self.emitted_objects.insert(name);
        Ok(())
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.emitted_objects.insert(enum_name);
        self.ensure_blank_line();
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl!["\nexport const ", enum_name, " = ", "S.Literal("]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, _, json_name, _| {
                r.emit_line(sl!["\"", string_escape(json_name), "\","]);
                Ok(())
            })
        })?;
        self.emit_line(");");
        if !self.options.just_schema {
            self.emit_line(sl![
                "export type ",
                enum_name,
                " = S.Schema.Type<typeof ",
                enum_name,
                ">;"
            ]);
        }
        Ok(())
    }

    /// The `recurse` of `walkObjectNames`.
    fn walk_object_names_recurse(
        &mut self,
        t: TypeRef,
        names: &mut Vec<Name>,
        visited: &mut HashSet<TypeRef>,
    ) -> Result<()> {
        if !visited.insert(t) {
            return Ok(());
        }
        let ty = self.type_graph().type_at(t)?;
        match ty.kind() {
            TypeKind::Object | TypeKind::Class => {
                names.push(self.name_for_named_type(t)?);
                self.for_each_class_property(t, BlankLinePosition::None, |r, _, _, prop, _| {
                    r.walk_object_names_recurse(prop.type_ref, names, visited)
                })?;
            }
            TypeKind::Array => self.walk_object_names_recurse(ty.items()?, names, visited)?,
            TypeKind::Map => self.walk_object_names_recurse(ty.map_values()?, names, visited)?,
            // An enum has no children.
            _ => {}
        }
        Ok(())
    }

    /// `walkObjectNames(objectType)`: the classes the properties of
    /// `object_type` reach through arrays, maps and other classes (but not
    /// through unions).
    fn walk_object_names(&mut self, object_type: TypeRef) -> Result<Vec<Name>> {
        let mut names = Vec::new();
        let mut visited = HashSet::new();

        self.for_each_class_property(object_type, BlankLinePosition::None, |r, _, _, prop, _| {
            r.walk_object_names_recurse(prop.type_ref, &mut names, &mut visited)
        })?;

        Ok(names)
    }

    /// `emitSchemas()`.
    fn emit_schemas(&mut self) -> Result<()> {
        self.ensure_blank_line();

        self.for_each_enum(
            BlankLinePosition::LeadingAndInterposing,
            |r, e, enum_name, _| r.emit_enum(e, enum_name),
        )?;

        let mut order: Vec<usize> = Vec::new();
        let mut map_key: Vec<Name> = Vec::new();
        let mut map_value: Vec<TypeRef> = Vec::new();
        self.for_each_object(BlankLinePosition::None, |_, t, name, _| {
            map_key.push(name);
            map_value.push(t);
            Ok(())
        })?;

        for (index, &source) in map_value.iter().enumerate() {
            // assume first
            let mut ordinal = 0;

            // pull out all names
            let names = self.walk_object_names(source)?;

            // must be behind all these names
            for dep_name in names {
                // find this name's ordinal, if it has already been added
                for &dep_index in &order {
                    if map_key[dep_index] == dep_name {
                        // this is the index of the dependency, so make sure
                        // we come after it
                        ordinal = ordinal.max(dep_index + 1);
                    }
                }
            }

            // insert index (`splice` clamps the position)
            order.insert(ordinal.min(order.len()), index);
        }

        // now emit ordered source
        for i in order {
            let (name, t) = (map_key[i], map_value[i]);
            let items = self.gather_source(|r| r.emit_object(name, t))?;
            self.emit_gathered_source(items);
        }

        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            if matches!(
                r.type_graph().kind(t)?,
                TypeKind::Class | TypeKind::Object | TypeKind::Enum
            ) {
                return Ok(());
            }

            r.ensure_blank_line();
            let schema = r.type_map_type_for(t, true, false)?;
            r.emit_line(sl!["export const ", name, " = ", schema, ";"]);
            if !r.options.just_schema {
                let type_of = " = S.Schema.Type<typeof ";
                r.emit_line(sl!["export type ", name, type_of, name, ">;"]);
            }
            Ok(())
        })?;
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for TypeScriptEffectSchemaRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok([
            "S", "Class", "Date", "Object", "String", "Array", "JSON", "Error", "RegExp",
        ]
        .into_iter()
        .map(str::to_owned)
        .collect())
    }

    fn make_named_type_namer(&mut self) -> Namer {
        fun_prefix_namer("types", |s| name_style(s, true))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer("properties", |s| name_style(s, true)))
    }

    /// `namerForObjectProperty()`: a new namer for every property.
    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(fun_prefix_namer("properties", |s| {
            name_style(s, true)
        })))
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer("enum-cases", |s| name_style(s, false)))
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        }

        self.emit_imports();
        self.emit_schemas()
    }
}
