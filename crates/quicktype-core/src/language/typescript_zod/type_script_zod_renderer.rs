//! Port of `packages/quicktype-core/src/language/TypeScriptZod/TypeScriptZodRenderer.ts`.
//!
//! Renders zod schemas, ordered so that every schema is declared before
//! the schemas that use it; schemas in a reference cycle are declared first
//! and wrapped in `z.lazy()`.

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::language::javascript::utils::legalize_name;
use crate::renderer_options::RendererOptions;
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::collection_utils::array_intercalate;
use crate::support::fast_hash::{HashMap, HashSet};
use crate::support::recursion::guard;
use crate::support::strings::{
    WordStyle, all_lower_word_style, capitalize, combine_words, first_upper_word_style,
    is_letter_or_underscore, split_into_words, string_escape, utf16_string_escape,
};
use crate::support::support::{console_error, console_warn};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::find_member;
use quicktype_js_compat::number;

use super::language::JUST_SCHEMA;

/// The option values of the zod renderer (TS
/// `OptionValues<typeof typeScriptZodOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TypeScriptZodOptions {
    /// `justSchema`.
    pub just_schema: bool,
}

impl TypeScriptZodOptions {
    /// `getOptionValues(typeScriptZodOptions, values)`.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        Ok(TypeScriptZodOptions {
            just_schema: JUST_SCHEMA.get_value(values),
        })
    }
}

/// `nameStyle(original, upper)` of the zod and Effect Schema renderers:
/// camel-case acronyms, and names start with a letter or underscore.
pub fn zod_name_style(original: &str, upper: bool) -> String {
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

/// `TypeScriptZodRenderer`.
pub struct TypeScriptZodRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: TypeScriptZodOptions,
    /// `_recursiveTypeRefs`: the object types that participate in a
    /// reference cycle. These must be emitted as `z.lazy()` schemas with an
    /// explicit type annotation, since zod cannot infer recursive types.
    recursive_type_refs: HashSet<TypeRef>,
}

impl std::fmt::Debug for TypeScriptZodRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("TypeScriptZodRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// `importStatement(lhs, moduleName)`.
fn import_statement(lhs: &str, module_name: &str) -> Source {
    sl!["import ", lhs, " from ", module_name, ";"]
}

/// `"${utf16StringEscape(jsonName)}"`.
fn quoted_json_name(json_name: &str) -> String {
    format!("\"{}\"", utf16_string_escape(json_name))
}

/// `extractUnderlyingTyperefs(type)`: the classes that are part of the
/// definition of `t` and so must be declared before a schema that uses it.
/// Primitive types don't need defining and enums are output before other
/// types, hence these are ignored.
fn extract_underlying_typerefs(
    graph: &crate::ty::type_graph::TypeGraph,
    t: TypeRef,
) -> Result<Vec<TypeRef>> {
    // Endless on a cycle through a nullable union (V8 overflows its stack).
    guard(|| {
        let mut type_refs = Vec::new();
        let ty = graph.type_at(t)?;
        // Ignore enums and primitives
        if !ty.is_primitive() && ty.kind() != TypeKind::Enum {
            // need to extract constituent types for unions and intersections
            // and can ignore the union/intersection itself
            if ty.is_set_operation() {
                for &member in ty.members()? {
                    type_refs.extend(extract_underlying_typerefs(graph, member)?);
                }
            }

            // need to extract additional properties for object, class and map
            // types
            if ty.is_object_type() {
                if let Some(additional) = ty.additional_properties()? {
                    type_refs.extend(extract_underlying_typerefs(graph, additional)?);
                }
            }

            // need to extract items types for ArrayType
            if ty.is_array() {
                type_refs.extend(extract_underlying_typerefs(graph, ty.items()?)?);
            }

            // Finally return the reference to a class as that will need to be
            // defined (where objects, maps, unions, intersections and arrays
            // do not)
            if ty.is_class() {
                type_refs.push(t);
            }
        }

        Ok(type_refs)
    })
}

impl<'a> TypeScriptZodRenderer<'a> {
    /// `new TypeScriptZodRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: TypeScriptZodOptions,
    ) -> Self {
        TypeScriptZodRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            recursive_type_refs: HashSet::default(),
        }
    }

    /// `emitImports()`.
    fn emit_imports(&mut self) {
        self.ensure_blank_line();
        self.emit_line(import_statement("* as z", "\"zod\""));
    }

    /// `typeMapTypeForProperty(p)`.
    fn type_map_type_for_property(&self, p: &ClassProperty) -> Result<Source> {
        let type_map = self.type_map_type_for(p.type_ref, true)?;
        Ok(if p.is_optional {
            sl![type_map, ".optional()"]
        } else {
            type_map
        })
    }

    /// The `stringType` of `typeMapTypeFor`.
    fn string_type(&self, t: TypeRef) -> Result<Source> {
        let graph = self.type_graph();
        let (min, max) = match min_max_length_for_type(graph, t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        let pattern = pattern_for_type(graph, t)?;
        Ok(sl![
            "z.string()",
            match pattern {
                None => Source::from(""),
                Some(pattern) => sl![
                    ".regex(new RegExp(\"",
                    utf16_string_escape(&pattern),
                    "\"))"
                ],
            },
            match min {
                None => String::new(),
                Some(min) => format!(
                    ".refine(value => Array.from(value).length >= {})",
                    number::to_string(min)
                ),
            },
            match max {
                None => String::new(),
                Some(max) => format!(
                    ".refine(value => Array.from(value).length <= {})",
                    number::to_string(max)
                ),
            }
        ])
    }

    /// The `numberType` of `typeMapTypeFor`.
    fn number_type(&self, t: TypeRef, integer: bool) -> Result<Source> {
        let (min, max) = match min_max_value_for_type(self.type_graph(), t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        Ok(sl![
            "z.number()",
            if integer { ".int()" } else { "" },
            match min {
                None => Source::from(""),
                Some(min) => sl![".min(", number::to_string(min), ")"],
            },
            match max {
                None => Source::from(""),
                Some(max) => sl![".max(", number::to_string(max), ")"],
            }
        ])
    }

    /// `typeMapTypeFor(t, required)`: the zod schema of `t`.
    fn type_map_type_for(&self, t: TypeRef, required: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let kind = ty.kind();
            if matches!(kind, TypeKind::Class | TypeKind::Object | TypeKind::Enum) {
                return Ok(sl![self.name_for_named_type(t)?, "Schema"]);
            }

            let matched: Source = match kind {
                TypeKind::Any => "z.any()".into(),
                TypeKind::Null => "z.null()".into(),
                TypeKind::Bool => "z.boolean()".into(),
                TypeKind::Integer => self.number_type(t, true)?,
                TypeKind::Double => self.number_type(t, false)?,
                TypeKind::String => self.string_type(t)?,
                TypeKind::Array => {
                    let (min_items, max_items) = match min_max_items_for_type(graph, t)? {
                        Some(m) => (m.0, m.1),
                        None => (None, None),
                    };

                    let mut array_source: Vec<Source> = vec![
                        "z.array(".into(),
                        self.type_map_type_for(ty.items()?, false)?,
                        ")".into(),
                    ];
                    if let Some(min_items) = min_items.filter(|&m| m > 0.0) {
                        array_source.extend([
                            ".min(".into(),
                            number::to_string(min_items).into(),
                            ")".into(),
                        ]);
                    }

                    if let Some(max_items) = max_items {
                        array_source.extend([
                            ".max(".into(),
                            number::to_string(max_items).into(),
                            ")".into(),
                        ]);
                    }

                    Source::Sequence(array_source)
                }
                TypeKind::Map => sl![
                    "z.record(z.string(), ",
                    self.type_map_type_for(ty.map_values()?, false)?,
                    ")"
                ],
                TypeKind::Union => {
                    // Coercing schemas can accept null, so handle it first.
                    let rank = |x: TypeRef| -> Result<u8> {
                        Ok(match graph.kind(x)? {
                            TypeKind::Null => 0,
                            TypeKind::DateTime => 2,
                            _ => 1,
                        })
                    };
                    let mut children: Vec<(u8, TypeRef)> = Vec::new();
                    for c in graph.children(t)? {
                        children.push((rank(c)?, c));
                    }
                    children.sort_by_key(|&(r, _)| r);

                    let mut schemas: Vec<Source> = Vec::new();
                    for &(_, member) in &children {
                        let schema = self.type_map_type_for(member, false)?;
                        let member_kind = graph.kind(member)?;
                        schemas.push(
                            if member_kind == TypeKind::BoolString
                                && find_member(graph, t, TypeKind::Bool)?.is_some()
                            {
                                sl![schema, ".transform(x => x === \"true\")"]
                            } else if member_kind == TypeKind::IntegerString
                                && find_member(graph, t, TypeKind::Integer)?.is_some()
                            {
                                sl![schema, ".transform(Number)"]
                            } else {
                                schema
                            },
                        );
                    }
                    sl!["z.union([", array_intercalate(", ".into(), schemas), "])"]
                }
                TypeKind::DateTime => "z.string().pipe(z.coerce.date())".into(),
                TypeKind::Uuid => "z.string().uuid()".into(),
                TypeKind::BoolString => "z.enum([\"true\", \"false\"])".into(),
                TypeKind::IntegerString => "z.string().regex(/^-?\\d+$/)".into(),
                k if k.is_transformed_string_type_kind() => "z.string()".into(),
                kind => return match_type_unsupported(kind),
            };

            if required {
                return Ok(sl![matched]);
            }

            Ok(matched)
        })
    }

    /// `underlyingTypeFor(t)`: the TypeScript type of `t`, used to annotate
    /// recursive schemas for which zod cannot infer the type.
    ///
    /// This intentionally duplicates neither `typeMapTypeFor` above nor
    /// `sourceFor` in the plain TypeScript renderer: it must mirror exactly
    /// what `z.infer` would derive from the schemas emitted by
    /// `typeMapTypeFor` (e.g. `z.coerce.date()` implies `Date`), while
    /// `sourceFor` is shaped by ts/flow-specific options like
    /// `preferConstValues` and `declareUnions` that don't exist here.
    fn underlying_type_for(&self, t: TypeRef) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let kind = ty.kind();
            if matches!(kind, TypeKind::Class | TypeKind::Object | TypeKind::Enum) {
                return Ok(self.name_for_named_type(t)?.into());
            }

            Ok(match kind {
                TypeKind::Any => "any".into(),
                TypeKind::Null => "null".into(),
                TypeKind::Bool => "boolean".into(),
                TypeKind::Integer | TypeKind::Double => "number".into(),
                TypeKind::String => "string".into(),
                TypeKind::Array => sl!["Array<", self.underlying_type_for(ty.items()?)?, ">"],
                TypeKind::Map => sl![
                    "Record<string, ",
                    self.underlying_type_for(ty.map_values()?)?,
                    ">"
                ],
                TypeKind::Union => {
                    let mut children: Vec<Source> = Vec::new();
                    for c in graph.children(t)? {
                        children.push(self.underlying_type_for(c)?);
                    }
                    array_intercalate(" | ".into(), children).into()
                }
                TypeKind::DateTime => "Date".into(),
                k if k.is_transformed_string_type_kind() => "string".into(),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `emitObject(name, t)`.
    fn emit_object(&mut self, name: Name, t: TypeRef) -> Result<()> {
        if self.recursive_type_refs.contains(&t) {
            return self.emit_lazy_object(name, t);
        }

        self.ensure_blank_line();
        let has_optional_constructor = self
            .type_graph()
            .type_at(t)?
            .properties()?
            .get("constructor")
            .is_some_and(|p| p.is_optional);
        self.emit_line(sl![
            "\nexport const ",
            name,
            "Schema = ",
            if has_optional_constructor {
                "z.preprocess(value => typeof value === \"object\" && value !== null && !Array.isArray(value) ? Object.assign(Object.create(null), value) : value, z.object({"
            } else {
                "z.object({"
            }
        ]);
        self.indent(|r| {
            r.for_each_class_property(
                t,
                BlankLinePosition::None,
                |r, _, json_name, property, _| {
                    let type_map = r.type_map_type_for_property(&property)?;
                    r.emit_line(sl![quoted_json_name(json_name), ": ", type_map, ","]);
                    Ok(())
                },
            )
        })?;
        self.emit_line(if has_optional_constructor {
            "}));"
        } else {
            "});"
        });
        if !self.options.just_schema {
            self.emit_line(sl![
                "export type ",
                name,
                " = z.infer<typeof ",
                name,
                "Schema>;"
            ]);
        }
        Ok(())
    }

    /// `emitLazyObject(name, t)`: a recursive object type. zod cannot infer
    /// recursive types, so the type is declared explicitly and the schema
    /// is wrapped in `z.lazy()` with a `z.ZodType` annotation.
    fn emit_lazy_object(&mut self, name: Name, t: TypeRef) -> Result<()> {
        self.ensure_blank_line();
        if self.options.just_schema {
            self.emit_line(sl![
                "\nexport const ",
                name,
                "Schema: z.ZodType<any> = z.lazy(() =>"
            ]);
        } else {
            self.emit_line(sl!["\nexport type ", name, " = {"]);
            self.indent(|r| {
                r.for_each_class_property(
                    t,
                    BlankLinePosition::None,
                    |r, _, json_name, property, _| {
                        let underlying = r.underlying_type_for(property.type_ref)?;
                        r.emit_line(sl![
                            quoted_json_name(json_name),
                            if property.is_optional { "?" } else { "" },
                            ": ",
                            underlying,
                            ";"
                        ]);
                        Ok(())
                    },
                )
            })?;
            self.emit_line("};");
            self.emit_line(sl![
                "export const ",
                name,
                "Schema: z.ZodType<",
                name,
                "> = z.lazy(() =>"
            ]);
        }

        self.indent(|r| {
            r.emit_line("z.object({");
            r.indent(|r| {
                r.for_each_class_property(
                    t,
                    BlankLinePosition::None,
                    |r, _, json_name, property, _| {
                        let type_map = r.type_map_type_for_property(&property)?;
                        r.emit_line(sl![quoted_json_name(json_name), ": ", type_map, ","]);
                        Ok(())
                    },
                )
            })?;
            r.emit_line("})");
            Ok(())
        })?;
        self.emit_line(");");
        Ok(())
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.ensure_blank_line();
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl!["\nexport const ", enum_name, "Schema = ", "z.enum(["]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, _, json_name, _| {
                r.emit_line(sl!["\"", string_escape(json_name), "\","]);
                Ok(())
            })
        })?;
        self.emit_line("]);");
        if !self.options.just_schema {
            self.emit_line(sl![
                "export type ",
                enum_name,
                " = z.infer<typeof ",
                enum_name,
                "Schema>;"
            ]);
        }
        Ok(())
    }

    /// `emitSchemas()`.
    fn emit_schemas(&mut self) -> Result<()> {
        self.ensure_blank_line();

        self.for_each_enum(
            BlankLinePosition::LeadingAndInterposing,
            |r, e, enum_name, _| r.emit_enum(e, enum_name),
        )?;

        // All children must be defined before this type to avoid forward
        // references in generated code. Build a model that will tell us if
        // a referenced type has been defined then make multiple passes over
        // the defined objects to put them into the correct order for output
        // in the generated sourcecode

        let mut order: Vec<usize> = Vec::new();
        let mut map_type: Vec<TypeRef> = Vec::new();
        let mut map_name: Vec<Name> = Vec::new();
        let mut map_child_type_refs: Vec<Vec<TypeRef>> = Vec::new();

        self.for_each_object(BlankLinePosition::None, |r, t, name, _| {
            map_type.push(t);
            map_name.push(name);

            let graph = r.type_graph();
            let mut child_type_refs = Vec::new();
            for child in graph.children(t)? {
                child_type_refs.extend(extract_underlying_typerefs(graph, child)?);
            }
            map_child_type_refs.push(child_type_refs);
            Ok(())
        })?;
        // `mapTypeRef` is `map_type`: a type is its reference here.
        let map_type_ref = &map_type;

        // Find types that participate in a reference cycle: types from which
        // we can get back to the same type by following child type
        // references. Those can never be topologically ordered.
        let mut index_for_type_ref: HashMap<TypeRef, usize> = HashMap::default();
        for (index, &type_ref) in map_type_ref.iter().enumerate() {
            index_for_type_ref.insert(type_ref, index);
        }
        let mut recursive_type_refs: HashSet<TypeRef> = HashSet::default();
        for start_index in 0..map_type.len() {
            let mut visited: HashSet<usize> = HashSet::default();
            let mut stack: Vec<TypeRef> = map_child_type_refs[start_index].clone();
            while let Some(child_ref) = stack.pop() {
                let Some(&child_index) = index_for_type_ref.get(&child_ref) else {
                    continue;
                };
                if child_index == start_index {
                    recursive_type_refs.insert(map_type_ref[start_index]);
                    break;
                }

                if !visited.insert(child_index) {
                    continue;
                }
                stack.extend(map_child_type_refs[child_index].iter().copied());
            }
        }
        self.recursive_type_refs = recursive_type_refs;

        // Items to process on this pass
        let mut indices: Vec<usize> = Vec::new();
        for (index, type_ref) in map_type_ref.iter().enumerate() {
            if self.recursive_type_refs.contains(type_ref) {
                // Recursive types are emitted first: they are wrapped in
                // z.lazy(), so all their references to other schemas are
                // deferred until parse time and don't constrain the output
                // order, while other schemas can reference them directly.
                order.push(index);
            } else {
                indices.push(index);
            }
        }

        // Which indices are in `order` (TS searches `order` for the child).
        let mut placed = vec![false; map_type.len()];
        for &index in &order {
            placed[index] = true;
        }

        // defensive: make sure we don't loop forever, even complex sets
        // shouldn't require many passes
        const MAX_PASSES: u32 = 999;
        let mut pass_num = 0;
        loop {
            // items to process on the next pass
            let mut deferred_indices: Vec<usize> = Vec::new();
            for &index in &indices {
                // must be behind all these children
                let mut found_all_children = true;
                for child_ref in &map_child_type_refs[index] {
                    // defensive: first check if there is a definition for the
                    // referenced type (there should be)
                    match index_for_type_ref.get(child_ref) {
                        // whether this child has already been added
                        Some(&child_index) => {
                            found_all_children = found_all_children && placed[child_index];
                        }
                        None => console_error(&format!(
                            "A child type reference was not found amongst all Object definitions! TypeRef: {}",
                            child_ref.js_value()
                        )),
                    }
                }

                if found_all_children {
                    // insert index into order as we are safe to define this
                    // type
                    order.push(index);
                    placed[index] = true;
                } else {
                    // defer to a subsequent pass as we need to define other
                    // types
                    deferred_indices.push(index);
                }
            }
            indices = deferred_indices;
            pass_num += 1;

            if pass_num > MAX_PASSES {
                // giving up: emit the stuck items anyway rather than
                // silently dropping them
                order.extend(indices.iter().copied());
                console_warn(
                    "Exceeded maximum number of passes when determining output order, output may contain forward references",
                );
            }
            if indices.is_empty() || pass_num > MAX_PASSES {
                break;
            }
        }

        // now emit ordered source
        for i in order {
            let (name, t) = (map_name[i], map_type[i]);
            let items = self.gather_source(|r| r.emit_object(name, t))?;
            self.emit_gathered_source(items);
        }

        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            // Named top levels were already emitted above with this name.
            if matches!(
                r.type_graph().kind(t)?,
                TypeKind::Class | TypeKind::Object | TypeKind::Enum
            ) {
                return Ok(());
            }

            r.ensure_blank_line();
            let type_map = r.type_map_type_for(t, true)?;
            r.emit_line(sl!["export const ", name, "Schema = ", type_map, ";"]);
            if !r.options.just_schema {
                r.emit_line(sl![
                    "export type ",
                    name,
                    " = z.infer<typeof ",
                    name,
                    "Schema>;"
                ]);
            }
            Ok(())
        })?;
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for TypeScriptZodRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok([
            "Class", "Date", "Object", "String", "Array", "JSON", "Error",
        ]
        .into_iter()
        .map(str::to_owned)
        .collect())
    }

    fn make_named_type_namer(&mut self) -> Namer {
        fun_prefix_namer("types", |s| zod_name_style(s, true))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer("properties", |s| zod_name_style(s, true)))
    }

    /// `namerForObjectProperty()`: a new namer for every property.
    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(fun_prefix_namer("properties", |s| {
            zod_name_style(s, true)
        })))
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer("enum-cases", |s| zod_name_style(s, false)))
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        }

        self.emit_imports();
        self.emit_schemas()
    }
}
