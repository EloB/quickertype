//! Port of `packages/quicktype-core/src/language/TypeScriptFlow/TypeScriptFlowBaseRenderer.ts`.
//!
//! The parts the TypeScript and Flow renderers share: type expressions,
//! interfaces and the TypeScript/Flow flavour of the JavaScript converters.
//!
//! TS `TypeScriptFlowBaseRenderer` extends `JavaScriptRenderer`. Its own
//! methods are the [`TypeScriptFlowBaseRenderer`] trait (a subtrait of
//! [`JavaScriptRenderer`]); its overrides of `JavaScriptRenderer` methods
//! are in [`typescript_flow_base_methods`], which a subclass's methods
//! module glob-imports and forwards with
//! `javascript_renderer_methods!([forward ...])`; its hook overrides are
//! [`typescript_flow_base_hooks`].

use crate::convenience_renderer::prelude::*;
use crate::language::javascript::java_script_renderer::{
    JavaScriptOptions, JavaScriptRenderer, JavaScriptState, JavaScriptTypeAnnotations,
    javascript_methods,
};
use crate::language::javascript::language::RawType;
use crate::renderer_options::RendererOptions;
use crate::source::{MultiWord, multi_word, paren_if_needed, single_word};
use crate::support::recursion::guard;
use crate::support::strings::{camel_case, utf16_string_escape};
use crate::ty::type_utils::nullable_from_union;

use super::language::{
    DECLARE_UNIONS, JUST_TYPES, NICE_PROPERTY_NAMES, PREFER_CONST_VALUES, PREFER_TYPES,
    PREFER_UNIONS, PREFER_UNKNOWN, READONLY,
};
use super::utils::quote_property_name;

/// The option values of the TypeScript and Flow renderers (TS
/// `OptionValues<typeof tsFlowOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TypeScriptFlowOptions {
    /// The `javaScriptOptions` part.
    pub js: JavaScriptOptions,
    /// `justTypes`.
    pub just_types: bool,
    /// `nicePropertyNames`.
    pub nice_property_names: bool,
    /// `declareUnions` (`--explicit-unions`).
    pub declare_unions: bool,
    /// `preferUnions`.
    pub prefer_unions: bool,
    /// `preferTypes`.
    pub prefer_types: bool,
    /// `preferConstValues`.
    pub prefer_const_values: bool,
    /// `readonly`.
    pub readonly: bool,
    /// `preferUnknown`.
    pub prefer_unknown: bool,
}

impl TypeScriptFlowOptions {
    /// `getOptionValues(tsFlowOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        Ok(TypeScriptFlowOptions {
            js: JavaScriptOptions::parse(values)?,
            just_types: JUST_TYPES.get_value(values),
            nice_property_names: NICE_PROPERTY_NAMES.get_value(values),
            declare_unions: DECLARE_UNIONS.get_value(values),
            prefer_unions: PREFER_UNIONS.get_value(values),
            prefer_types: PREFER_TYPES.get_value(values),
            prefer_const_values: PREFER_CONST_VALUES.get_value(values),
            readonly: READONLY.get_value(values),
            prefer_unknown: PREFER_UNKNOWN.get_value(values),
        })
    }
}

/// The fields of TS `TypeScriptFlowBaseRenderer` (and of the
/// `JavaScriptRenderer` it extends).
#[derive(Clone, Debug)]
pub struct TypeScriptFlowState {
    /// The `JavaScriptRenderer` fields.
    pub js: JavaScriptState,
    /// `_tsFlowOptions`.
    pub options: TypeScriptFlowOptions,
}

impl TypeScriptFlowState {
    /// The state of a new renderer with `options`.
    pub fn new(options: TypeScriptFlowOptions) -> Self {
        TypeScriptFlowState {
            js: JavaScriptState::new(options.js),
            options,
        }
    }
}

/// The methods of TS `TypeScriptFlowBaseRenderer` that `JavaScriptRenderer`
/// doesn't have. Defaults are the bodies in
/// [`typescript_flow_base_methods`].
pub trait TypeScriptFlowBaseRenderer<'a>: JavaScriptRenderer<'a> {
    /// The fields of TS `TypeScriptFlowBaseRenderer`.
    fn ts_flow(&self) -> &TypeScriptFlowState;

    /// `_tsFlowOptions`.
    fn ts_flow_options(&self) -> &TypeScriptFlowOptions {
        &self.ts_flow().options
    }

    /// `emptyObjectType`: how a class without properties is spelled, if
    /// it is collapsed.
    fn empty_object_type(&self) -> Option<&'static str> {
        None
    }

    /// `sourceForArrayType(arrayType)`. Flow (pinned at flow-bin 0.66 in
    /// CI) has no tuple-rest syntax, so the base implementation always
    /// renders plain array types; the TypeScript renderer overrides this to
    /// spell out `minItems` guarantees as a tuple.
    fn source_for_array_type(&self, array_type: TypeRef) -> Result<MultiWord> {
        typescript_flow_base_methods::source_for_array_type(self, array_type)
    }

    /// `anyType()`: the type emitted for `any`-typed values in type
    /// declarations and converter signatures: the language's type-safe top
    /// type (`unknown` for TypeScript, `mixed` for Flow) with the
    /// `prefer-unknown` option, plain `any` without it.
    fn any_type(&self) -> &'static str;

    /// `undefinedType`: the type spelling for a missing optional property.
    fn undefined_type(&self) -> &'static str {
        "undefined"
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()>;

    /// `emitClassBlock(c, className)`.
    fn emit_class_block(&mut self, c: TypeRef, class_name: Name) -> Result<()>;
}

/// The bodies of TS `TypeScriptFlowBaseRenderer`'s methods: the defaults
/// of [`TypeScriptFlowBaseRenderer`] and what a subclass's `super.x(...)`
/// calls.
pub mod typescript_flow_base_methods {
    pub use crate::language::javascript::java_script_renderer::javascript_methods::*;

    use super::*;

    /// `this.targetLanguage.name === "flow" ? "+" : "readonly "`.
    pub fn readonly_prefix<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &R) -> &'static str {
        if r.target_language().name() == "flow" {
            "+"
        } else {
            "readonly "
        }
    }

    /// `emptyObjectTypeFor(t)`: [`empty_object_type`] for an object type
    /// without properties and additional properties.
    ///
    /// [`empty_object_type`]: TypeScriptFlowBaseRenderer::empty_object_type
    pub fn empty_object_type_for<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Option<&'static str>> {
        let ty = r.type_graph().type_at(t)?;
        if ty.is_object_type()
            && ty.properties()?.is_empty()
            && ty.additional_properties()?.is_none()
        {
            return Ok(r.empty_object_type());
        }

        Ok(None)
    }

    /// `typeMapTypeFor(t)`: `m("any")` for a collapsed empty object.
    pub fn type_map_type_for<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Source> {
        if empty_object_type_for(r, t)?.is_some() {
            return Ok("m(\"any\")".into());
        }

        javascript_methods::type_map_type_for(r, t)
    }

    /// `sourceForArrayType(arrayType)`.
    pub fn source_for_array_type<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        array_type: TypeRef,
    ) -> Result<MultiWord> {
        let graph = r.type_graph();
        let items = graph.type_at(array_type)?.items()?;
        let item_type = source_for(r, items)?;
        let items_ty = graph.type_at(items)?;
        if (items_ty.is_union() && !r.ts_flow_options().declare_unions) || items_ty.is_array() {
            return Ok(single_word(vec![sl!["Array<", item_type.source, ">"]]));
        }

        Ok(single_word(vec![sl![paren_if_needed(item_type), "[]"]]))
    }

    /// `inlinesUnion(u)`: whether a union is spelled out as `a | b` instead
    /// of by name.
    pub fn inlines_union<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &R, u: TypeRef) -> Result<bool> {
        Ok(
            !r.ts_flow_options().declare_unions
                || nullable_from_union(r.type_graph(), u)?.is_some(),
        )
    }

    /// `sourceFor(t)`: the type expression of `t`.
    pub fn source_for<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<MultiWord> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            if let Some(empty_object_type) = empty_object_type_for(r, t)? {
                return Ok(single_word(vec![empty_object_type.into()]));
            }

            let graph = r.type_graph();
            let ty = graph.type_at(t)?;
            let kind = ty.kind();
            if r.ts_flow_options().prefer_const_values && kind == TypeKind::Enum {
                let cases = ty.cases()?;
                if cases.len() == 1 {
                    let item = cases.first().map_or("", String::as_str);
                    return Ok(single_word(vec![
                        format!("\"{}\"", utf16_string_escape(item)).into(),
                    ]));
                }
            }

            if matches!(kind, TypeKind::Class | TypeKind::Object | TypeKind::Enum) {
                return Ok(single_word(vec![r.name_for_named_type(t)?.into()]));
            }

            Ok(match kind {
                TypeKind::Any => single_word(vec![r.any_type().into()]),
                TypeKind::Null => single_word(vec!["null".into()]),
                TypeKind::Bool => single_word(vec!["boolean".into()]),
                TypeKind::Integer | TypeKind::Double => single_word(vec!["number".into()]),
                TypeKind::String => single_word(vec!["string".into()]),
                TypeKind::Array => r.source_for_array_type(t)?,
                TypeKind::Map => single_word(vec![sl![
                    "{ ",
                    if r.ts_flow_options().readonly {
                        readonly_prefix(r)
                    } else {
                        ""
                    },
                    "[key: string]: ",
                    source_for(r, ty.map_values()?)?.source,
                    " }"
                ]]),
                TypeKind::Union => {
                    if inlines_union(r, t)? {
                        let mut children = Vec::new();
                        for c in graph.children(t)? {
                            children.push(paren_if_needed(source_for(r, c)?));
                        }
                        return multi_word(" | ", children);
                    }

                    single_word(vec![r.name_for_named_type(t)?.into()])
                }
                TypeKind::DateTime => single_word(vec!["Date".into()]),
                k if k.is_transformed_string_type_kind() => single_word(vec!["string".into()]),
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `emitClassBlockBody(c)`: the property table and the index signature.
    pub fn emit_class_block_body<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
        c: TypeRef,
    ) -> Result<()> {
        let options = *r.ts_flow_options();
        r.emit_property_table(c, |r, name, _json_name, p| {
            let mut property_name = modify_source(quote_property_name, name);

            if options.readonly {
                let prefix = readonly_prefix(r);
                property_name = modify_source(
                    move |property_name| format!("{prefix}{property_name}"),
                    property_name,
                );
            }

            Ok(vec![
                sl![property_name, if p.is_optional { "?" } else { "" }, ": "],
                sl![source_for(r, p.type_ref)?.source, ";"],
            ])
        })?;

        let graph = r.type_graph();
        let ty = graph.type_at(c)?;
        if let Some(additional_properties) = ty.additional_properties()? {
            let properties: Vec<ClassProperty> = ty.properties()?.values().copied().collect();
            let index_types: Vec<Source> = if graph.kind(additional_properties)? == TypeKind::Any {
                vec![r.any_type().into()]
            } else {
                // Inlined unions render as their members, so collect
                // those members to avoid repeating them.
                let mut types: indexmap::IndexSet<TypeRef> = indexmap::IndexSet::new();
                add_index_type(r, &mut types, additional_properties)?;
                for p in &properties {
                    add_index_type(r, &mut types, p.type_ref)?;
                }

                let mut index_types = Vec::with_capacity(types.len() + 1);
                for t in types {
                    index_types.push(source_for(r, t)?.source);
                }
                if properties.iter().any(|p| p.is_optional) {
                    index_types.push(r.undefined_type().into());
                }
                index_types
            };

            let property = if options.readonly {
                format!("{}[property: string]", readonly_prefix(r))
            } else {
                "[property: string]".to_owned()
            };
            r.emit_table(vec![vec![
                property.into(),
                ": ".into(),
                multi_word(" | ", index_types)?.source,
                ";".into(),
            ]]);
        }
        Ok(())
    }

    /// The `addType` of `emitClassBlockBody`.
    fn add_index_type<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        types: &mut indexmap::IndexSet<TypeRef>,
        t: TypeRef,
    ) -> Result<()> {
        if r.type_graph().type_at(t)?.is_union() && inlines_union(r, t)? {
            for child in r.type_graph().children(t)? {
                add_index_type(r, types, child)?;
            }
        } else {
            types.insert(t);
        }
        Ok(())
    }

    /// `emitClass(c, className)`: a collapsed empty object only gets an
    /// alias if it is a top-level.
    fn emit_class<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
        c: TypeRef,
        class_name: Name,
    ) -> Result<()> {
        if let Some(empty_object_type) = empty_object_type_for(r, c)? {
            if r.top_levels().values().any(|&t| t == c) {
                let description = r.description_for_type(c)?;
                r.emit_description(description)?;
                r.emit_line(sl![
                    "export type ",
                    class_name,
                    " = ",
                    empty_object_type,
                    ";"
                ]);
            }

            return Ok(());
        }

        let description = r.description_for_type(c)?;
        r.emit_description(description)?;
        r.emit_class_block(c, class_name)
    }

    /// `emitUnion(u, unionName)`: only with `explicit-unions`.
    fn emit_union<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
        u: TypeRef,
        union_name: Name,
    ) -> Result<()> {
        if !r.ts_flow_options().declare_unions {
            return Ok(());
        }

        let description = r.description_for_type(u)?;
        r.emit_description(description)?;

        let mut children = Vec::new();
        for c in r.type_graph().children(u)? {
            children.push(paren_if_needed(source_for(r, c)?));
        }
        let children = multi_word(" | ", children)?;
        r.emit_line(sl!["export type ", union_name, " = ", children.source, ";"]);
        Ok(())
    }

    /// `emitTypes()`.
    pub fn emit_types<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &mut R) -> Result<()> {
        r.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            if r.named_type_to_name_for_top_level(t)?.is_some() {
                return Ok(());
            }

            r.ensure_blank_line();
            let description = r.description_for_type(t)?;
            r.emit_description(description)?;
            let is_primitive = r.type_graph().type_at(t)?.is_primitive();
            let source = source_for(r, t)?.source;
            r.emit_line(sl![
                if is_primitive {
                    "type "
                } else {
                    "export type "
                },
                name,
                " = ",
                source,
                ";"
            ]);
            Ok(())
        })?;

        r.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| emit_class(r, c, n),
            |r, e, n, _| r.emit_enum(e, n),
            |r, u, n, _| emit_union(r, u, n),
        )
    }

    /// The `jsonType`/`returnType` of the converter signatures.
    pub fn raw_type<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &R) -> &'static str {
        match r.ts_flow_options().js.raw_type {
            RawType::Json => "string",
            RawType::Any => r.any_type(),
        }
    }

    /// `deserializerFunctionLine(t, name)`.
    pub fn deserializer_function_line<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        t: TypeRef,
        name: Name,
    ) -> Result<Source> {
        let json_type = raw_type(r);
        Ok(sl![
            "function to",
            name,
            "(json: ",
            json_type,
            "): ",
            source_for(r, t)?.source
        ])
    }

    /// `serializerFunctionLine(t, name)`.
    pub fn serializer_function_line<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        t: TypeRef,
        name: Name,
    ) -> Result<Source> {
        let camel_case_name = modify_source(camel_case, name);
        let return_type = raw_type(r);
        Ok(sl![
            "function ",
            camel_case_name,
            "ToJson(value: ",
            source_for(r, t)?.source,
            "): ",
            return_type
        ])
    }

    /// `shouldEmitTypeMapEntry(t)`: not for a collapsed empty object.
    pub fn should_emit_type_map_entry<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<bool> {
        Ok(empty_object_type_for(r, t)?.is_none()
            && javascript_methods::should_emit_type_map_entry(r, t)?)
    }

    /// `moduleLine`: none.
    pub fn module_line<'a, R: TypeScriptFlowBaseRenderer<'a>>(_r: &R) -> Option<&'static str> {
        None
    }

    /// `castFunctionLines`. The runtime typecheck helpers are deliberately
    /// dynamic, so they stay on `any` even with `prefer-unknown`. Only the
    /// public API surface (type declarations and converter signatures)
    /// uses `anyType()`.
    pub fn cast_function_lines<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        _r: &R,
    ) -> (&'static str, &'static str) {
        (
            "function cast<T>(val: any, typ: any): T",
            "function uncast<T>(val: T, typ: any): any",
        )
    }

    /// `typeAnnotations`: not implemented in the base class.
    pub fn type_annotations<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        _r: &R,
    ) -> Result<JavaScriptTypeAnnotations> {
        crate::support::support::panic("not implemented")
    }

    /// `emitUsageComments(givenOutputFilename)`: none with `just-types`.
    pub fn emit_usage_comments<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
        given_output_filename: &str,
    ) -> Result<()> {
        if r.ts_flow_options().just_types {
            return Ok(());
        }
        javascript_methods::emit_usage_comments(r, given_output_filename)
    }

    /// `emitConvertModule()`: none with `just-types`.
    pub fn emit_convert_module<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &mut R) -> Result<()> {
        if r.ts_flow_options().just_types {
            return Ok(());
        }
        javascript_methods::emit_convert_module(r)
    }

    /// `emitConvertModuleHelpers()`: none with `just-types`.
    pub fn emit_convert_module_helpers<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
    ) -> Result<()> {
        if r.ts_flow_options().just_types {
            return Ok(());
        }
        javascript_methods::emit_convert_module_helpers(r)
    }

    /// `emitModuleExports()`: none with `just-types`.
    pub fn emit_module_exports<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &mut R) -> Result<()> {
        if r.ts_flow_options().just_types {
            return Ok(());
        }
        javascript_methods::emit_module_exports(r)
    }

    /// `this._tsFlowOptions.rawType !== "json" && this._tsFlowOptions.preferUnknown`:
    /// whether a deserializer without runtime checks must cast.
    pub fn needs_unchecked_cast<'a, R: TypeScriptFlowBaseRenderer<'a>>(r: &R) -> bool {
        let options = r.ts_flow_options();
        options.js.raw_type != RawType::Json && options.prefer_unknown
    }
}

/// The `ConvenienceRenderer` hooks TS `TypeScriptFlowBaseRenderer`
/// overrides, on top of [`javascript_hooks`](crate::language::javascript::java_script_renderer::javascript_hooks).
pub mod typescript_flow_base_hooks {
    pub use crate::language::javascript::java_script_renderer::javascript_hooks::*;

    use super::TypeScriptFlowBaseRenderer;
    use crate::convenience_renderer::prelude::*;
    use crate::language::javascript::java_script_renderer::{javascript_hooks, name_style};

    /// `namerForObjectProperty()`: with `nice-property-names`, a new namer
    /// per property.
    pub fn namer_for_object_property<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
        o: TypeRef,
        p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        if r.ts_flow_options().nice_property_names {
            let acronym_style = r.ts_flow_options().js.acronym_style;
            let calls = r.js().acronym_style_calls.clone();
            return Ok(Some(fun_prefix_namer("properties", move |s| {
                name_style(acronym_style, &calls, s, false)
            })));
        }

        javascript_hooks::namer_for_object_property(r, o, p)
    }
}
