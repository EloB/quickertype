//! Port of `packages/quicktype-core/src/language/TypeScriptFlow/FlowRenderer.ts`.
//!
//! Renders Flow types and converter functions.

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::language::javascript::java_script_renderer::{
    JavaScriptTypeAnnotations, javascript_methods,
};
use crate::support::strings::utf16_string_escape;
use crate::support::support::defined;
use crate::target_language::TargetLanguage;

use super::type_script_flow_base_renderer::{
    TypeScriptFlowBaseRenderer, TypeScriptFlowOptions, TypeScriptFlowState,
    typescript_flow_base_methods,
};
use super::utils::ts_flow_type_annotations;

/// The hooks TS `FlowRenderer` overrides, on top of
/// [`typescript_flow_base_hooks`](super::type_script_flow_base_renderer::typescript_flow_base_hooks).
mod flow_hooks {
    pub use crate::language::typescript_flow::type_script_flow_base_renderer::typescript_flow_base_hooks::*;

    use crate::convenience_renderer::prelude::*;
    use crate::language::typescript_flow::type_script_flow_base_renderer::{
        TypeScriptFlowBaseRenderer, typescript_flow_base_hooks,
    };

    /// `forbiddenNamesForGlobalNamespace()`.
    pub fn forbidden_names_for_global_namespace<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        _r: &mut R,
    ) -> Result<Vec<String>> {
        Ok([
            "Class", "Date", "Object", "String", "Array", "JSON", "Error", "RegExp",
        ]
        .into_iter()
        .map(str::to_owned)
        .collect())
    }

    /// `emitSourceStructure(givenOutputFilename)`: `// @flow` first.
    pub fn emit_source_structure<'a, R: TypeScriptFlowBaseRenderer<'a>>(
        r: &mut R,
        given_output_filename: &str,
    ) -> Result<()> {
        r.emit_line("// @flow");
        r.ensure_blank_line();
        typescript_flow_base_hooks::emit_source_structure(r, given_output_filename)
    }
}

/// `FlowRenderer`.
pub struct FlowRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    ts_flow: TypeScriptFlowState,
}

impl std::fmt::Debug for FlowRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("FlowRenderer")
            .field("options", &self.ts_flow.options)
            .finish_non_exhaustive()
    }
}

impl<'a> FlowRenderer<'a> {
    /// `new FlowRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: TypeScriptFlowOptions,
    ) -> Self {
        FlowRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            ts_flow: TypeScriptFlowState::new(options),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for FlowRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(flow_hooks);
}

impl<'a> TypeScriptFlowBaseRenderer<'a> for FlowRenderer<'a> {
    fn ts_flow(&self) -> &TypeScriptFlowState {
        &self.ts_flow
    }

    /// `anyType()`.
    fn any_type(&self) -> &'static str {
        if self.ts_flow.options.prefer_unknown {
            "mixed"
        } else {
            "any"
        }
    }

    /// `undefinedType`: `void`.
    fn undefined_type(&self) -> &'static str {
        "void"
    }

    /// `uncheckedParsedJson(t, parsedJson)`: with `raw-type any` and
    /// `prefer-unknown` the deserializer's parameter is `mixed`, which
    /// can't be returned as the target type without a cast.
    fn unchecked_parsed_json(&self, t: TypeRef, parsed_json: Source) -> Result<Source> {
        if typescript_flow_base_methods::needs_unchecked_cast(self) {
            return Ok(sl![
                "((",
                parsed_json,
                ": any): ",
                typescript_flow_base_methods::source_for(self, t)?.source,
                ")"
            ]);
        }

        Ok(parsed_json)
    }

    /// `typeAnnotations`.
    fn type_annotations(&self) -> Result<JavaScriptTypeAnnotations> {
        Ok(ts_flow_type_annotations(""))
    }

    /// `emitEnum(e, enumName)`: a union of string literals.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        let mut lines: Vec<Vec<String>> = Vec::new();
        self.for_each_enum_case(e, BlankLinePosition::None, |_, _, json_name, _| {
            let maybe_or = if lines.is_empty() { "  " } else { "| " };
            lines.push(vec![
                maybe_or.to_owned(),
                "\"".to_owned(),
                utf16_string_escape(json_name),
                "\"".to_owned(),
            ]);
            Ok(())
        })?;
        defined(lines.last_mut())?.push(";".to_owned());

        self.emit_line(sl!["export type ", enum_name, " ="]);
        self.indent(|r| {
            for line in lines {
                r.emit_line(Source::Sequence(
                    line.into_iter().map(Source::from).collect(),
                ));
            }
            Ok(())
        })
    }

    /// `emitClassBlock(c, className)`.
    fn emit_class_block(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        javascript_methods::emit_block(
            self,
            sl!["export type ", class_name, " = "],
            ";".into(),
            |r| typescript_flow_base_methods::emit_class_block_body(r, c),
        )
    }
}
