//! Port of `packages/quicktype-core/src/language/Ruby/RubyRenderer.ts`.
//!
//! Renders `Dry::Struct` classes with `from_dynamic!`/`to_dynamic`
//! converters, enums as modules plus `Types` enum declarations, unions as
//! structs with one optional attribute per member, and a `from_json!`
//! class per top-level that is not a named type.

use quicktype_js_compat::number;

use crate::attributes::constraints::{
    MinMaxConstraint, min_max_items_for_type, min_max_length_for_type, min_max_value_for_type,
    pattern_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::declaration_ir::DeclarationKind;
use crate::renderer_options::{EnumValue, RendererOptions};
use crate::support::comments::CommentOptions;
use crate::support::recursion::guard;
use crate::support::strings::snake_case;
use crate::support::support::panic;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, is_nullable, nullable_from_union, remove_null_from_union,
};

use super::constants::GLOBALS;
use super::language::{JUST_TYPES, NAMESPACE, STRICTNESS};
use super::utils::{
    FORBIDDEN_FOR_OBJECT_PROPERTIES, Strictness, member_name_style, simple_name_style,
    string_escape,
};

/// The values of `rubyOptions`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct RubyOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `strictness`.
    pub strictness: Strictness,
    /// `namespace`.
    pub namespace: String,
}

impl RubyOptions {
    /// `getOptionValues(rubyOptions, values)`: the options in declaration
    /// order; an unknown `strictness` is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let just_types = JUST_TYPES.get_value(values);
        let strictness = match STRICTNESS.get_enum_value(values)? {
            EnumValue::Declared("strict") => Strictness::Strict,
            EnumValue::Declared("coercible") => Strictness::Coercible,
            EnumValue::Declared("none") => Strictness::None,
            EnumValue::Declared(other) => return panic(format!("Unknown strictness {other}")),
            EnumValue::Prototype(member) => Strictness::Other(member),
        };
        Ok(RubyOptions {
            just_types,
            strictness,
            namespace: NAMESPACE.get_value(values).into_owned(),
        })
    }
}

/// `RubyRenderer`.
pub struct RubyRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: RubyOptions,
}

impl std::fmt::Debug for RubyRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("RubyRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// `.constrained(a, b)` of the present bounds, or nothing.
fn constrained(constraint: Option<MinMaxConstraint>, min_key: &str, max_key: &str) -> String {
    let (min, max) = constraint.map_or((None, None), |c| (c.0, c.1));
    let constraints: Vec<String> = [
        min.map(|min| format!("{min_key}: {}", number::to_string(min))),
        max.map(|max| format!("{max_key}: {}", number::to_string(max))),
    ]
    .into_iter()
    .flatten()
    .collect();
    if constraints.is_empty() {
        String::new()
    } else {
        format!(".constrained({})", constraints.join(", "))
    }
}

/// Whether a type of this kind is a class, map or array
/// (`["class", "map", "array"].includes(kind)`).
fn is_compound_kind(kind: TypeKind) -> bool {
    matches!(kind, TypeKind::Class | TypeKind::Map | TypeKind::Array)
}

impl<'a> RubyRenderer<'a> {
    /// `new RubyRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: RubyOptions,
    ) -> Self {
        RubyRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
        }
    }

    /// `dryType(t, isOptional)`: the Dry type of `t`.
    fn dry_type(&self, t: TypeRef, is_optional: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let optional = if is_optional { ".optional" } else { "" };
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => sl!["Types::Any", optional],
                TypeKind::Null => sl!["Types::Nil", optional],
                TypeKind::Bool => sl!["Types::Bool", optional],
                TypeKind::Integer => sl![
                    "Types::Integer",
                    constrained(min_max_value_for_type(graph, t)?, "gteq", "lteq"),
                    optional
                ],
                TypeKind::Double => sl![
                    "Types::Double",
                    constrained(min_max_value_for_type(graph, t)?, "gteq", "lteq"),
                    optional
                ],
                TypeKind::String => {
                    let length =
                        constrained(min_max_length_for_type(graph, t)?, "min_size", "max_size");
                    let pattern = match pattern_for_type(graph, t)? {
                        None => String::new(),
                        Some(regex) => format!(
                            ".constrained(format: Regexp.new(\"{}\"))",
                            string_escape(&regex)
                        ),
                    };
                    sl!["Types::String", length, pattern, optional]
                }
                TypeKind::Array => sl![
                    "Types.Array(",
                    self.dry_type(ty.items()?, false)?,
                    ")",
                    constrained(min_max_items_for_type(graph, t)?, "min_size", "max_size"),
                    optional
                ],
                TypeKind::Class => sl![self.name_for_named_type(t)?, optional],
                TypeKind::Map => sl![
                    "Types::Hash.meta(of: ",
                    self.dry_type(ty.map_values()?, false)?,
                    ")",
                    optional
                ],
                TypeKind::Enum => sl!["Types::", self.name_for_named_type(t)?, optional],
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return Ok(sl![self.dry_type(nullable, false)?, ".optional"]);
                    }
                    sl![
                        "Types.Instance(",
                        self.name_for_named_type(t)?,
                        ")",
                        optional
                    ]
                }
                kind if kind.is_transformed_string_type_kind() => sl![
                    if kind == TypeKind::Uuid {
                        "Types::String.constrained(format: /\\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\\z/i)"
                    } else {
                        "Types::String.constrained(format: /\\A\\d{4}-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d(?:\\.\\d+)?(?:Z|[+-]\\d\\d:\\d\\d)\\z/i)"
                    },
                    optional
                ],
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `exampleUse(t, exp, depth, optional)`: an expression that uses a
    /// value of type `t`, for the usage comment. (Bounded by `depth`, so it
    /// needs no recursion guard.)
    fn example_use(
        &mut self,
        t: TypeRef,
        exp: Source,
        depth: i32,
        optional: bool,
    ) -> Result<Source> {
        if depth <= 0 {
            return Ok(exp);
        }
        let depth = depth - 1;

        let safe_nav = if optional { "&" } else { "" };
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        Ok(match ty.kind() {
            TypeKind::Any | TypeKind::Bool | TypeKind::Double | TypeKind::String => exp,
            TypeKind::Null => sl![exp, ".nil?"],
            TypeKind::Integer => sl![exp, ".even?"],
            TypeKind::Array => {
                return self.example_use(ty.items()?, sl![exp, safe_nav, ".first"], depth, false);
            }
            TypeKind::Class => {
                let mut info: Option<(Name, ClassProperty)> = None;
                self.for_each_class_property(t, BlankLinePosition::None, |r, name, _, prop, _| {
                    if is_compound_kind(r.type_graph().kind(prop.type_ref)?) || info.is_none() {
                        info = Some((name, prop));
                    }
                    Ok(())
                })?;
                if let Some((name, prop)) = info {
                    return self.example_use(
                        prop.type_ref,
                        sl![exp, safe_nav, ".", name],
                        depth,
                        prop.is_optional,
                    );
                }
                exp
            }
            TypeKind::Map => {
                return self.example_use(
                    ty.map_values()?,
                    sl![exp, safe_nav, "[\"…\"]"],
                    depth,
                    false,
                );
            }
            TypeKind::Enum => {
                let mut first: Option<Name> = None;
                // FIXME: This is a terrible way to get the first enum case name.
                self.for_each_enum_case(t, BlankLinePosition::None, |_, name, _, _| {
                    if first.is_none() {
                        first = Some(name);
                    }
                    Ok(())
                })?;
                match first {
                    Some(name) => sl![exp, " == ", self.name_for_named_type(t)?, "::", name],
                    None => exp,
                }
            }
            TypeKind::Union => match nullable_from_union(graph, t)? {
                Some(nullable) => {
                    if is_compound_kind(graph.kind(nullable)?) {
                        return self.example_use(nullable, exp, depth, true);
                    }
                    sl![exp, ".nil?"]
                }
                None => exp,
            },
            kind if kind.is_transformed_string_type_kind() => exp,
            kind => return match_type_unsupported(kind),
        })
    }

    /// `jsonSample(t)`: a placeholder for JSON of type `t`.
    fn json_sample(&self, t: TypeRef) -> Result<Source> {
        let inner = match self.type_graph().kind(t)? {
            TypeKind::Array => "[…]",
            TypeKind::Map | TypeKind::Class => "{…}",
            _ => "…",
        };
        Ok(Source::from(format!("\"{inner}\"")))
    }

    /// `fromDynamic(t, e, optional, castPrimitives)`: converts the dynamic
    /// value `e` to `t`.
    #[allow(clippy::wrong_self_convention)] // named after TypeScript's `fromDynamic`
    fn from_dynamic(
        &self,
        t: TypeRef,
        e: Source,
        optional: bool,
        cast_primitives: bool,
    ) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let primitive_cast = sl![self.dry_type(t, optional)?, "[", e.clone(), "]"];
            let primitive = if cast_primitives {
                primitive_cast
            } else {
                e.clone()
            };
            let safe_access = if optional { "&" } else { "" };
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any
                | TypeKind::Null
                | TypeKind::Bool
                | TypeKind::Integer
                | TypeKind::Double
                | TypeKind::String => primitive,
                TypeKind::Array => sl![
                    e,
                    safe_access,
                    ".map { |x| ",
                    self.from_dynamic(ty.items()?, Source::from("x"), false, true)?,
                    " }"
                ],
                TypeKind::Class | TypeKind::Union => {
                    if ty.is_union() {
                        if let Some(nullable) = nullable_from_union(graph, t)? {
                            return self.from_dynamic(nullable, e, true, false);
                        }
                    }
                    let expression = sl![
                        self.name_for_named_type(t)?,
                        ".from_dynamic!(",
                        e.clone(),
                        ")"
                    ];
                    if optional {
                        sl![e, " ? ", expression, " : nil"]
                    } else {
                        expression
                    }
                }
                TypeKind::Map => sl![
                    sl![
                        "Types::Hash",
                        if optional { ".optional" } else { "" },
                        "[",
                        e,
                        "]"
                    ],
                    safe_access,
                    ".map { |k, v| [k, ",
                    self.from_dynamic(ty.map_values()?, Source::from("v"), false, true)?,
                    "] }",
                    safe_access,
                    ".to_h"
                ],
                TypeKind::Enum => {
                    let expression =
                        sl!["Types::", self.name_for_named_type(t)?, "[", e.clone(), "]"];
                    if optional {
                        sl![e, ".nil? ? nil : ", expression]
                    } else {
                        expression
                    }
                }
                kind if kind.is_transformed_string_type_kind() => primitive,
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `toDynamic(t, e, optional)`: converts `e` of type `t` to a dynamic
    /// value.
    fn to_dynamic(&self, t: TypeRef, e: Source, optional: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            if self.marshals_implicitly_to_dynamic(t)? {
                return Ok(e);
            }

            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let safe_access = if optional { "&" } else { "" };
            Ok(match ty.kind() {
                TypeKind::Any
                | TypeKind::Null
                | TypeKind::Bool
                | TypeKind::Integer
                | TypeKind::Double
                | TypeKind::String
                | TypeKind::Enum => e,
                TypeKind::Array => sl![
                    e,
                    safe_access,
                    ".map { |x| ",
                    self.to_dynamic(ty.items()?, Source::from("x"), false)?,
                    " }"
                ],
                TypeKind::Class => sl![e, safe_access, ".to_dynamic"],
                TypeKind::Map => sl![
                    e,
                    safe_access,
                    ".map { |k, v| [k, ",
                    self.to_dynamic(ty.map_values()?, Source::from("v"), false)?,
                    "] }.to_h"
                ],
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.to_dynamic(nullable, e, true);
                    }
                    if self.marshals_implicitly_to_dynamic(t)? {
                        return Ok(e);
                    }
                    sl![e, safe_access, ".to_dynamic"]
                }
                kind if kind.is_transformed_string_type_kind() => e,
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `marshalsImplicitlyToDynamic(t)`.
    fn marshals_implicitly_to_dynamic(&self, t: TypeRef) -> Result<bool> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            match ty.kind() {
                TypeKind::Any
                | TypeKind::Null
                | TypeKind::Bool
                | TypeKind::Integer
                | TypeKind::Double
                | TypeKind::String
                | TypeKind::Enum => Ok(true),
                TypeKind::Array => self.marshals_implicitly_to_dynamic(ty.items()?),
                TypeKind::Class => Ok(false),
                TypeKind::Map => self.marshals_implicitly_to_dynamic(ty.map_values()?),
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.marshals_implicitly_to_dynamic(nullable),
                    None => Ok(false),
                },
                kind if kind.is_transformed_string_type_kind() => Ok(true),
                kind => match_type_unsupported(kind),
            }
        })
    }

    /// `propertyTypeMarshalsImplicitlyFromDynamic(t)`: class properties may
    /// marshal implicitly because `Dry::Struct.new` checks them.
    fn property_type_marshals_implicitly_from_dynamic(&self, t: TypeRef) -> Result<bool> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            match ty.kind() {
                TypeKind::Any
                | TypeKind::Null
                | TypeKind::Bool
                | TypeKind::Integer
                | TypeKind::Double
                | TypeKind::String
                | TypeKind::Enum => Ok(true),
                TypeKind::Array => self.property_type_marshals_implicitly_from_dynamic(ty.items()?),
                TypeKind::Class => Ok(false),
                // Map properties must be checked because Dry:Types doesn't have a generic Map
                TypeKind::Map => Ok(false),
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.property_type_marshals_implicitly_from_dynamic(nullable),
                    None => Ok(false),
                },
                kind if kind.is_transformed_string_type_kind() => Ok(true),
                kind => match_type_unsupported(kind),
            }
        })
    }

    /// `emitBlock(source, emit)`: `source`, the indented body and `end`.
    /// (`ElixirRenderer` has its own copy, as in TypeScript.)
    fn emit_block(
        &mut self,
        source: impl Into<Source>,
        emit: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_line(source);
        self.indent(emit)?;
        self.emit_line("end");
        Ok(())
    }

    /// `emitModule(emit)`: `emit` inside the `--namespace` modules, if any.
    fn emit_module(&mut self, emit: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        if self.options.namespace.is_empty() {
            return emit(self);
        }
        let namespace = self.options.namespace.clone();
        self.emit_module_inner(&namespace, emit)
    }

    /// `emitModuleInner(moduleName)`: one `module` per `::`-separated part.
    fn emit_module_inner(
        &mut self,
        module_name: &str,
        emit: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        match module_name.split_once("::") {
            Some((first_module, sub_modules)) => {
                let sub_modules = sub_modules.to_owned();
                self.emit_block(sl!["module ", first_module.to_owned()], |r| {
                    r.emit_module_inner(&sub_modules, emit)
                })
            }
            None => self.emit_block(sl!["module ", module_name.to_owned()], emit),
        }
    }

    /// `emitClass(c, className)`.
    fn emit_class(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_block(sl!["class ", class_name, " < Dry::Struct"], |r| {
            let mut table: Vec<Vec<Source>> = Vec::new();
            let mut count = r.type_graph().type_at(c)?.properties()?.len();
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
                count = count.wrapping_sub(1);
                let last = count == 0;
                let description = r.description_for_class_property(c, json_name)?;
                let dry_type = r.dry_type(p.type_ref, false)?;
                let attribute = vec![
                    sl!["attribute :", name, ","],
                    sl![" ", dry_type, if p.is_optional { ".optional" } else { "" }],
                ];
                match description {
                    Some(description) => {
                        if !table.is_empty() {
                            let rows = std::mem::take(&mut table);
                            r.emit_table(rows);
                        }

                        r.ensure_blank_line();
                        let lines: Vec<Source> =
                            description.into_iter().map(Source::from).collect();
                        r.emit_description_block(&lines)?;
                        r.emit_line(Source::Sequence(attribute));
                        if !last {
                            r.ensure_blank_line();
                        }
                    }
                    None => table.push(attribute),
                }
                Ok(())
            })?;
            if !table.is_empty() {
                r.emit_table(table);
            }

            if r.options.just_types {
                return Ok(());
            }

            r.ensure_blank_line();
            r.emit_block(sl!["def self.from_dynamic!(d)"], |r| {
                r.emit_line("d = Types::Hash[d]");
                r.emit_line("new(");
                r.indent(|r| {
                    let mut inits: Vec<Vec<Source>> = Vec::new();
                    r.for_each_class_property(
                        c,
                        BlankLinePosition::None,
                        |r, name, json_name, p, _| {
                            let escaped = string_escape(json_name);
                            let dynamic = if p.is_optional {
                                // If key is not found in hash, this will be nil
                                format!("d[\"{escaped}\"]")
                            } else {
                                // This will raise a runtime error if the key is not found in the hash
                                format!("d.fetch(\"{escaped}\")")
                            };

                            if p.is_optional && !is_nullable(r.type_graph(), p.type_ref)? {
                                let strict =
                                    r.from_dynamic(p.type_ref, Source::from(dynamic), false, true)?;
                                inits.push(vec![
                                    sl![name, ": "],
                                    sl![format!("d.key?(\"{escaped}\") ? "), strict, " : nil,"],
                                ]);
                                return Ok(());
                            }
                            if r.property_type_marshals_implicitly_from_dynamic(p.type_ref)? {
                                inits.push(vec![sl![name, ": "], sl![dynamic, ","]]);
                            } else {
                                let expression = r.from_dynamic(
                                    p.type_ref,
                                    Source::from(dynamic),
                                    p.is_optional,
                                    false,
                                )?;
                                inits.push(vec![sl![name, ": "], sl![expression, ","]]);
                            }
                            Ok(())
                        },
                    )?;
                    r.emit_table(inits);
                    Ok(())
                })?;
                r.emit_line(")");
                Ok(())
            })?;

            r.ensure_blank_line();
            r.emit_block("def self.from_json!(json)", |r| {
                r.emit_line("from_dynamic!(JSON.parse(json))");
                Ok(())
            })?;

            r.ensure_blank_line();
            r.emit_block(sl!["def to_dynamic"], |r| {
                r.emit_line("{");
                r.indent(|r| {
                    let mut inits: Vec<Vec<Source>> = Vec::new();
                    r.for_each_class_property(
                        c,
                        BlankLinePosition::None,
                        |r, name, json_name, p, _| {
                            let expression =
                                r.to_dynamic(p.type_ref, Source::from(name), p.is_optional)?;
                            inits.push(vec![
                                sl![format!("\"{}\"", string_escape(json_name))],
                                sl![" => ", expression, ","],
                            ]);
                            Ok(())
                        },
                    )?;
                    r.emit_table(inits);
                    Ok(())
                })?;
                r.emit_line("}");
                Ok(())
            })?;
            r.ensure_blank_line();
            r.emit_block("def to_json(options = nil)", |r| {
                r.emit_line("JSON.generate(to_dynamic, options)");
                Ok(())
            })
        })
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_block(sl!["module ", enum_name], |r| {
            let mut table: Vec<Vec<Source>> = Vec::new();
            r.for_each_enum_case(e, BlankLinePosition::None, |_, name, json, _| {
                table.push(vec![
                    sl![name],
                    sl![format!(" = \"{}\"", string_escape(json))],
                ]);
                Ok(())
            })?;
            r.emit_table(table);
            Ok(())
        })
    }

    /// `emitUnion(u, unionName)`.
    fn emit_union(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        self.emit_block(sl!["class ", union_name, " < Dry::Struct"], |r| {
            let children = r.type_graph().children(u)?;
            let mut table: Vec<Vec<Source>> = Vec::new();
            r.for_each_union_member(
                u,
                Some(&children),
                BlankLinePosition::None,
                None,
                |r, name, t, _| {
                    table.push(vec![
                        sl!["attribute :", name, ", "],
                        sl![r.dry_type(t, true)?],
                    ]);
                    Ok(())
                },
            )?;
            r.emit_table(table);

            if r.options.just_types {
                return Ok(());
            }

            r.ensure_blank_line();
            let (maybe_null, non_nulls) =
                remove_null_from_union(r.type_graph(), u, NullRemovalSort::None)?;
            r.emit_block("def self.from_dynamic!(d)", |r| {
                let mut member_names: Vec<Name> = Vec::with_capacity(children.len());
                for &member in &children {
                    member_names.push(r.name_for_union_member(u, member)?);
                }
                r.for_each_union_member(
                    u,
                    Some(&children),
                    BlankLinePosition::None,
                    None,
                    |r, name, t, _| {
                        let nil_members: Vec<Source> = member_names
                            .iter()
                            .filter(|&&n| n != name)
                            .map(|&member_name| sl![", ", member_name, ": nil"])
                            .collect();
                        if r.property_type_marshals_implicitly_from_dynamic(t)? {
                            r.emit_block(
                                sl!["if schema.key(:", name, ").type.right.valid? d"],
                                |r| {
                                    r.emit_line_parts(vec![
                                        "return new(".into(),
                                        name.into(),
                                        ": d".into(),
                                        Source::Sequence(nil_members),
                                        ")".into(),
                                    ]);
                                    Ok(())
                                },
                            )
                        } else {
                            r.emit_line("begin");
                            r.indent(|r| {
                                let value = r.from_dynamic(t, Source::from("d"), false, false)?;
                                r.emit_line_parts(vec!["value = ".into(), value]);
                                r.emit_block(
                                    sl!["if schema.key(:", name, ").type.right.valid? value"],
                                    |r| {
                                        r.emit_line_parts(vec![
                                            "return new(".into(),
                                            name.into(),
                                            ": value".into(),
                                            Source::Sequence(nil_members),
                                            ")".into(),
                                        ]);
                                        Ok(())
                                    },
                                )
                            })?;
                            r.emit_line("rescue");
                            r.emit_line("end");
                            Ok(())
                        }
                    },
                )?;
                r.emit_line("raise \"Invalid union\"");
                Ok(())
            })?;

            r.ensure_blank_line();
            r.emit_block("def self.from_json!(json)", |r| {
                r.emit_line("from_dynamic!(JSON.parse(json))");
                Ok(())
            })?;

            r.ensure_blank_line();
            r.emit_block("def to_dynamic", |r| {
                let mut first = true;
                r.for_each_union_member(
                    u,
                    Some(&non_nulls),
                    BlankLinePosition::None,
                    None,
                    |r, name, t, _| {
                        r.emit_line_parts(vec![
                            (if first { "if" } else { "elsif" }).into(),
                            " ".into(),
                            name.into(),
                            " != nil".into(),
                        ]);
                        let dynamic = r.to_dynamic(t, Source::from(name), false)?;
                        r.indent(|r| {
                            r.emit_line(dynamic);
                            Ok(())
                        })?;
                        first = false;
                        Ok(())
                    },
                )?;
                if maybe_null.is_some() {
                    r.emit_line("else");
                    r.indent(|r| {
                        r.emit_line("nil");
                        Ok(())
                    })?;
                }

                r.emit_line("end");
                Ok(())
            })?;

            r.ensure_blank_line();
            r.emit_block("def to_json(options = nil)", |r| {
                r.emit_line("JSON.generate(to_dynamic, options)");
                Ok(())
            })
        })
    }

    /// `emitTypesModule()`: the `Types` module with the primitive and enum
    /// declarations.
    fn emit_types_module(&mut self) -> Result<()> {
        self.emit_block(sl!["module Types"], |r| {
            r.emit_line("include Dry.Types(default: :nominal)");

            let mut declarations: Vec<Vec<Source>> = Vec::new();
            let strictness = r.options.strictness;
            let prefix = strictness.as_str();

            if strictness != Strictness::None {
                let (mut int, mut nil, mut bool, mut hash, mut string, mut double) =
                    (false, false, false, false, false, false);
                r.for_each_type(|r, t| {
                    let kind = r.type_graph().kind(t)?;
                    int |= kind == TypeKind::Integer;
                    nil |= kind == TypeKind::Null;
                    bool |= kind == TypeKind::Bool;
                    hash |= kind == TypeKind::Map || kind == TypeKind::Class;
                    string |= kind == TypeKind::String || kind == TypeKind::Enum;
                    double |= kind == TypeKind::Double;
                    Ok(())
                })?;
                if int {
                    declarations.push(vec![sl!["Integer"], sl![format!(" = {prefix}Integer")]]);
                }
                if strictness == Strictness::Strict && nil {
                    declarations.push(vec![sl!["Nil"], sl![format!(" = {prefix}Nil")]]);
                }

                if bool {
                    declarations.push(vec![sl!["Bool"], sl![format!(" = {prefix}Bool")]]);
                }
                if hash {
                    declarations.push(vec![sl!["Hash"], sl![format!(" = {prefix}Hash")]]);
                }
                if string {
                    declarations.push(vec![sl!["String"], sl![format!(" = {prefix}String")]]);
                }
                if double {
                    declarations.push(vec![
                        sl!["Double"],
                        sl![format!(" = {prefix}Float | {prefix}Integer")],
                    ]);
                }
            }

            r.for_each_enum(BlankLinePosition::None, |r, enum_type, enum_name, _| {
                let mut cases: Vec<Source> = Vec::new();
                r.for_each_enum_case(enum_type, BlankLinePosition::None, |_, _, json, _| {
                    cases.push(sl![
                        if cases.is_empty() { "" } else { ", " },
                        format!("\"{}\"", string_escape(json))
                    ]);
                    Ok(())
                })?;
                // The value itself, not a template literal.
                let mut value = vec![" = ".into(), strictness.to_source(), "String.enum(".into()];
                value.extend(cases);
                value.push(")".into());
                declarations.push(vec![sl![enum_name], Source::Sequence(value)]);
                Ok(())
            })?;

            if !declarations.is_empty() {
                r.ensure_blank_line();
                r.emit_table(declarations);
            }
            Ok(())
        })
    }

    /// The usage comment at the top of the file.
    fn emit_usage_comment(&mut self) -> Result<()> {
        self.emit_line("# This code may look unusually verbose for Ruby (and it is), but");
        self.emit_line("# it performs some subtle and complex validation of JSON data.");
        self.emit_line("#");
        self.emit_line("# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:");
        self.emit_line("#");
        self.for_each_top_level(BlankLinePosition::None, |r, top_level, name, _| {
            let variable = modify_source(snake_case, name);
            let sample = r.json_sample(top_level)?;
            r.emit_line_parts(vec![
                "#   ".into(),
                variable.clone(),
                " = ".into(),
                name.into(),
                ".from_json! ".into(),
                sample,
            ]);
            let example = r.example_use(top_level, variable, 6, false)?;
            r.emit_line_parts(vec!["#   puts ".into(), example]);
            r.emit_line("#");
            Ok(())
        })?;
        self.emit_line("# If from_json! succeeds, the value returned matches the schema.");
        Ok(())
    }

    /// The `from_json!` class of a top-level that is not a named type.
    fn emit_top_level_class(&mut self, top_level: TypeRef, name: Name) -> Result<()> {
        let self_name = modify_source(snake_case, name);

        // The json gem defines to_json on maps and primitives, so we only need to supply
        // it for arrays.
        let graph = self.type_graph();
        let ty = graph.type_at(top_level)?;
        let needs_to_json_defined = ty.is_array() && !graph.type_at(ty.items()?)?.is_primitive();

        self.emit_module(|r| {
            r.emit_block(sl!["class ", name], |r| {
                r.emit_block(sl!["def self.from_json!(json)"], |r| {
                    let parsed = Source::from("JSON.parse(json, quirks_mode: true)");
                    if needs_to_json_defined {
                        let from = r.from_dynamic(top_level, parsed, false, false)?;
                        r.emit_line_parts(vec![self_name.clone(), " = ".into(), from]);
                        r.emit_block(
                            sl![self_name.clone(), ".define_singleton_method(:to_json) do"],
                            |r| {
                                let to = r.to_dynamic(top_level, Source::from("self"), false)?;
                                r.emit_line_parts(vec!["JSON.generate(".into(), to, ")".into()]);
                                Ok(())
                            },
                        )?;
                        r.emit_line(self_name);
                    } else {
                        let from = r.from_dynamic(top_level, parsed, false, false)?;
                        r.emit_line(from);
                    }
                    Ok(())
                })
            })
        })
    }
}

impl<'a> ConvenienceRenderer<'a> for RubyRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn comment_line_start(&self) -> &'static str {
        "# "
    }

    fn needs_type_declaration_before_use(&self) -> bool {
        true
    }

    fn can_be_forward_declared(&self, t: TypeRef) -> Result<bool> {
        Ok(self.type_graph().kind(t)? == TypeKind::Class)
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        let mut names: Vec<String> = GLOBALS.iter().map(|&g| g.to_owned()).collect();
        names.extend(
            ["Types", "JSON", "Dry", "Constructor", "Self"]
                .into_iter()
                .map(str::to_owned),
        );
        Ok(names)
    }

    fn forbidden_for_object_properties(
        &mut self,
        _c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: FORBIDDEN_FOR_OBJECT_PROPERTIES
                .iter()
                .map(|n| n.as_str().into())
                .collect(),
            include_global_forbidden: true,
        })
    }

    fn forbidden_for_union_members(
        &mut self,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: FORBIDDEN_FOR_OBJECT_PROPERTIES
                .iter()
                .map(|n| n.as_str().into())
                .collect(),
            include_global_forbidden: true,
        })
    }

    fn make_named_type_namer(&mut self) -> Namer {
        Namer::new(
            "types",
            |n| simple_name_style(n, true),
            Vec::<String>::new(),
            false,
        )
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        // A new namer per call, as in TypeScript.
        Ok(Some(Namer::new(
            "properties",
            member_name_style,
            Vec::<String>::new(),
            false,
        )))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(Namer::new(
            "properties",
            member_name_style,
            Vec::<String>::new(),
            false,
        ))
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(Namer::new(
            "enum-cases",
            |n| simple_name_style(n, true),
            Vec::<String>::new(),
            false,
        ))
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        } else if !self.options.just_types {
            self.emit_usage_comment()?;
        }

        self.ensure_blank_line();

        self.emit_line("require 'json'");
        self.emit_line("require 'dry-types'");
        self.emit_line("require 'dry-struct'");

        self.ensure_blank_line();

        self.emit_module(|r| {
            r.emit_types_module()?;

            r.for_each_declaration(BlankLinePosition::LeadingAndInterposing, |r, decl, _| {
                if decl.kind == DeclarationKind::Forward {
                    r.emit_comment_lines(
                        &[Source::from("(forward declaration)")],
                        &CommentOptions::default(),
                    )?;
                    let name = r.name_for_named_type(decl.type_ref)?;
                    r.emit_module(|r| {
                        r.emit_line_parts(vec![
                            "class ".into(),
                            name.into(),
                            " < Dry::Struct; end".into(),
                        ]);
                        Ok(())
                    })?;
                }
                Ok(())
            })?;

            r.for_each_named_type(
                BlankLinePosition::LeadingAndInterposing,
                |r, c, n, _| r.emit_class(c, n),
                |r, e, n, _| r.emit_enum(e, n),
                |r, u, n, _| r.emit_union(u, n),
            )?;

            if !r.options.just_types {
                r.for_each_top_level_where(
                    BlankLinePosition::LeadingAndInterposing,
                    |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
                    |r, top_level, name, _| r.emit_top_level_class(top_level, name),
                )?;
            }
            Ok(())
        })
    }
}
