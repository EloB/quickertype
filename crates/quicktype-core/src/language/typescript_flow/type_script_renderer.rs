//! Port of `packages/quicktype-core/src/language/TypeScriptFlow/TypeScriptRenderer.ts`.
//!
//! Renders TypeScript interfaces and a `Convert` class.

use crate::attributes::constraints::min_max_items_for_type;
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::language::javascript::java_script_renderer::{
    JavaScriptTypeAnnotations, javascript_methods, usage_module_name,
};
use crate::source::{MultiWord, paren_if_needed, single_word};
use crate::support::strings::{camel_case, utf16_string_escape};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::is_named_type;

use super::type_script_flow_base_renderer::{
    TypeScriptFlowBaseRenderer, TypeScriptFlowOptions, TypeScriptFlowState,
    typescript_flow_base_methods,
};
use super::utils::ts_flow_type_annotations;

/// An array type with a huge `minItems` would otherwise expand into an
/// equally huge tuple type, so beyond this limit we fall back to a plain
/// array type.
const MAX_SPELLED_OUT_MIN_ITEMS: f64 = 16.0;

/// The hooks TS `TypeScriptRenderer` overrides, on top of
/// [`typescript_flow_base_hooks`](super::type_script_flow_base_renderer::typescript_flow_base_hooks).
mod typescript_hooks {
    pub use crate::language::typescript_flow::type_script_flow_base_renderer::typescript_flow_base_hooks::*;

    use crate::convenience_renderer::prelude::*;
    use crate::language::typescript_flow::type_script_flow_base_renderer::TypeScriptFlowBaseRenderer;

    /// `forbiddenNamesForGlobalNamespace()`.
    pub fn forbidden_names_for_global_namespace<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        _r: &mut R,
    ) -> Result<Vec<String>> {
        Ok(["Array", "Date", "Convert"]
            .into_iter()
            .map(str::to_owned)
            .collect())
    }
}

/// `TypeScriptRenderer`.
pub struct TypeScriptRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    ts_flow: TypeScriptFlowState,
}

impl std::fmt::Debug for TypeScriptRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("TypeScriptRenderer")
            .field("options", &self.ts_flow.options)
            .finish_non_exhaustive()
    }
}

impl<'a> TypeScriptRenderer<'a> {
    /// `new TypeScriptRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: TypeScriptFlowOptions,
    ) -> Self {
        TypeScriptRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            ts_flow: TypeScriptFlowState::new(options),
        }
    }

    /// `this.sourceFor(t).source`.
    fn source(&self, t: TypeRef) -> Result<Source> {
        Ok(typescript_flow_base_methods::source_for(self, t)?.source)
    }

    /// The `jsonType`/`returnType` of the converter signatures.
    fn raw_type(&self) -> &'static str {
        match self.ts_flow.options.js.raw_type {
            crate::language::javascript::language::RawType::Json => "string",
            crate::language::javascript::language::RawType::Any => self.any_type(),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for TypeScriptRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(typescript_hooks);
}

impl<'a> TypeScriptFlowBaseRenderer<'a> for TypeScriptRenderer<'a> {
    fn ts_flow(&self) -> &TypeScriptFlowState {
        &self.ts_flow
    }

    /// `emptyObjectType`: `object`.
    fn empty_object_type(&self) -> Option<&'static str> {
        Some("object")
    }

    /// `anyType()`.
    fn any_type(&self) -> &'static str {
        if self.ts_flow.options.prefer_unknown {
            "unknown"
        } else {
            "any"
        }
    }

    /// `sourceForArrayType(arrayType)`: an array with `minItems` >= 1
    /// becomes a tuple that spells out the guaranteed elements, followed by
    /// a rest element: `minItems: 2` renders as `[T, T, ...T[]]`. Only
    /// `minItems` shapes the type; `maxItems` is enforced by none of the
    /// generated code, and spelling it out would enumerate every allowed
    /// arity as its own tuple.
    fn source_for_array_type(&self, array_type: TypeRef) -> Result<MultiWord> {
        let min_items = min_max_items_for_type(self.type_graph(), array_type)?.and_then(|m| m.0);
        let Some(min_items) = min_items.filter(|&m| (1.0..=MAX_SPELLED_OUT_MIN_ITEMS).contains(&m))
        else {
            return typescript_flow_base_methods::source_for_array_type(self, array_type);
        };

        let items = self.type_graph().type_at(array_type)?.items()?;
        let item_type = typescript_flow_base_methods::source_for(self, items)?;
        let mut source: Vec<Source> = vec!["[".into()];
        let mut i = 0.0;
        while i < min_items {
            source.push(item_type.source.clone());
            source.push(", ".into());
            i += 1.0;
        }

        source.push("...".into());
        source.push(paren_if_needed(item_type));
        source.push("[]]".into());
        Ok(single_word(vec![Source::Sequence(source)]))
    }

    /// `uncheckedParsedJson(t, parsedJson)`: with `raw-type any` and
    /// `prefer-unknown` the deserializer's parameter is `unknown`, which
    /// can't be returned as the target type without a cast.
    fn unchecked_parsed_json(&self, t: TypeRef, parsed_json: Source) -> Result<Source> {
        if typescript_flow_base_methods::needs_unchecked_cast(self) {
            return Ok(sl![parsed_json, " as ", self.source(t)?]);
        }

        Ok(parsed_json)
    }

    /// `deserializerFunctionLine(t, name)`.
    fn deserializer_function_line(&self, t: TypeRef, name: Name) -> Result<Source> {
        let json_type = self.raw_type();
        Ok(sl![
            "public static to",
            name,
            "(json: ",
            json_type,
            "): ",
            self.source(t)?
        ])
    }

    /// `serializerFunctionLine(t, name)`.
    fn serializer_function_line(&self, t: TypeRef, name: Name) -> Result<Source> {
        let camel_case_name = modify_source(camel_case, name);
        let return_type = self.raw_type();
        Ok(sl![
            "public static ",
            camel_case_name,
            "ToJson(value: ",
            self.source(t)?,
            "): ",
            return_type
        ])
    }

    /// `moduleLine`.
    fn module_line(&self) -> Option<&'static str> {
        Some("export class Convert")
    }

    /// `typeAnnotations`.
    fn type_annotations(&self) -> Result<JavaScriptTypeAnnotations> {
        Ok(ts_flow_type_annotations(": never"))
    }

    /// `emitModuleExports()`: nothing; `Convert` is exported.
    fn emit_module_exports(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitUsageImportComment(givenOutputFilename)`.
    fn emit_usage_import_comment(&mut self, given_output_filename: &str) -> Result<()> {
        let mut top_level_names: Vec<Source> = Vec::new();
        self.for_each_top_level_where(
            BlankLinePosition::None,
            |r, t| Ok(is_named_type(r.type_graph().type_at(t)?)),
            |_, _, name, _| {
                top_level_names.push(", ".into());
                top_level_names.push(name.into());
                Ok(())
            },
        )?;
        self.emit_line(sl![
            "//   import { Convert",
            Source::Sequence(top_level_names),
            " } from \"./",
            usage_module_name(given_output_filename),
            "\";"
        ]);
        Ok(())
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;

        // enums with only one value are emitted as constants
        let cases = self.type_graph().type_at(e)?.cases()?;
        if self.ts_flow.options.prefer_const_values && cases.len() == 1 {
            return Ok(());
        }

        if self.ts_flow.options.prefer_unions {
            let mut items = String::new();
            for item in cases {
                if items.is_empty() {
                    items += &format!("\"{}\"", utf16_string_escape(item));
                    continue;
                }

                items += &format!(" | \"{}\"", utf16_string_escape(item));
            }
            self.emit_line(sl!["export type ", enum_name, " = ", items, ";"]);
        } else {
            javascript_methods::emit_block(
                self,
                sl!["export enum ", enum_name, " "],
                "".into(),
                |r| {
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        r.emit_line(sl![
                            name,
                            format!(" = \"{}\",", utf16_string_escape(json_name))
                        ]);
                        Ok(())
                    })
                },
            )?;
        }
        Ok(())
    }

    /// `emitClassBlock(c, className)`.
    fn emit_class_block(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let source = if self.ts_flow.options.prefer_types {
            sl!["export type ", class_name, " = "]
        } else {
            sl!["export interface ", class_name, " "]
        };
        javascript_methods::emit_block(self, source, "".into(), |r| {
            typescript_flow_base_methods::emit_class_block_body(r, c)
        })
    }
}
