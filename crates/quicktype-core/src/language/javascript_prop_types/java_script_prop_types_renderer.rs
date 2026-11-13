//! Port of `packages/quicktype-core/src/language/JavaScriptPropTypes/JavaScriptPropTypesRenderer.ts`.
//!
//! Renders React `PropTypes` shapes. The shapes are ordered so that every
//! shape is declared before the shapes that use it, by looking for the
//! names each gathered shape references.

use std::collections::HashMap;

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::language::javascript::unicode_maps::is_es3_identifier_start;
use crate::language::javascript::utils::legalize_name;
use crate::renderer_options::RendererOptions;
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::comments::CommentOptions;
use crate::support::converters::ConvertersOptions;
use crate::support::recursion::guard;
use crate::support::strings::{
    WordStyle, all_lower_word_style, capitalize, combine_words, first_upper_word_style,
    split_into_words, utf16_string_escape,
};
use crate::support::support::defined;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{directly_reachable_single_named_type, find_member};
use quicktype_js_compat::number::to_string as js_number;

use super::language::{ACRONYM_STYLE, CONVERTERS, MODULE_SYSTEM};

/// The option values of the PropTypes renderer (TS
/// `OptionValues<typeof javaScriptPropTypesOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct JavaScriptPropTypesOptions {
    /// `acronymStyle`.
    pub acronym_style: AcronymStyleOptions,
    /// `converters` (unused by the renderer).
    pub converters: ConvertersOptions,
    /// `moduleSystem`: `true` for `es6`, `false` for `common-js`.
    pub module_system: bool,
}

impl JavaScriptPropTypesOptions {
    /// `getOptionValues(javaScriptPropTypesOptions, values)`: the options in
    /// declaration order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let acronym_style = defined(AcronymStyleOptions::from_value(
            ACRONYM_STYLE.get_enum_value(values)?,
        ))?;
        let converters = defined(ConvertersOptions::from_name(
            CONVERTERS.get_enum_value(values)?,
        ))?;
        let module_system = MODULE_SYSTEM.get_enum_value(values)? == "es6";
        Ok(JavaScriptPropTypesOptions {
            acronym_style,
            converters,
            module_system,
        })
    }
}

/// `nameStyle(original, upper)`: the TypeScript duplicates the JavaScript
/// renderer's `nameStyle` here instead of sharing it, and so does the port.
fn name_style(acronym_style_option: AcronymStyleOptions, original: &str, upper: bool) -> String {
    let acronyms = acronym_style(acronym_style_option);
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
        &is_es3_identifier_start,
    )
}

/// The own property names of `Object.prototype` (`jsonName in
/// Object.prototype`).
const OBJECT_PROTOTYPE_PROPERTIES: [&str; 12] = [
    "constructor",
    "__defineGetter__",
    "__defineSetter__",
    "hasOwnProperty",
    "__lookupGetter__",
    "__lookupSetter__",
    "isPrototypeOf",
    "propertyIsEnumerable",
    "toString",
    "valueOf",
    "__proto__",
    "toLocaleString",
];

/// `JavaScriptPropTypesRenderer`.
pub struct JavaScriptPropTypesRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: JavaScriptPropTypesOptions,
    /// The module's `identityNamingFunction` (a singleton in TypeScript).
    identity_naming_function: Namer,
}

impl std::fmt::Debug for JavaScriptPropTypesRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("JavaScriptPropTypesRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> JavaScriptPropTypesRenderer<'a> {
    /// `new JavaScriptPropTypesRenderer(targetLanguage, renderContext,
    /// options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: JavaScriptPropTypesOptions,
    ) -> Self {
        JavaScriptPropTypesRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            identity_naming_function: fun_prefix_namer("properties", str::to_owned),
        }
    }

    /// The `stringType` of `typeMapTypeFor`.
    fn string_type(&self, t: TypeRef) -> Result<Source> {
        let graph = self.type_graph();
        let (min, max) = match min_max_length_for_type(graph, t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        let pattern = pattern_for_type(graph, t)?;
        if min.is_none() && max.is_none() && pattern.is_none() {
            return Ok("PropTypes.string".into());
        }
        Ok(sl![
            "(props, name) => { const value = props[name]; return value == null || (typeof value === 'string'",
            match min {
                None => Source::from(""),
                Some(min) => sl![" && [...value].length >= ", js_number(min)],
            },
            match max {
                None => Source::from(""),
                Some(max) => sl![" && [...value].length <= ", js_number(max)],
            },
            match pattern {
                None => Source::from(""),
                Some(pattern) => sl![
                    " && new RegExp(\"",
                    utf16_string_escape(&pattern),
                    "\").test(value)"
                ],
            },
            ") ? null : new Error(\"Expected bounded string\"); }"
        ])
    }

    /// The `numberType` of `typeMapTypeFor`.
    fn number_type(&self, t: TypeRef, integer: bool) -> Result<Source> {
        let (min, max) = match min_max_value_for_type(self.type_graph(), t)? {
            Some(m) => (m.0, m.1),
            None => (None, None),
        };
        if min.is_none() && max.is_none() {
            return Ok(if integer {
                "Integer"
            } else {
                "PropTypes.number"
            }
            .into());
        }
        Ok(sl![
            "(props, name) => { const value = props[name]; return value == null || (",
            if integer {
                "Number.isInteger(value)"
            } else {
                "typeof value === 'number'"
            },
            match min {
                None => Source::from(""),
                Some(min) => sl![" && value >= ", js_number(min)],
            },
            match max {
                None => Source::from(""),
                Some(max) => sl![" && value <= ", js_number(max)],
            },
            ") ? null : new Error(\"Expected bounded number\"); }"
        ])
    }

    /// `typeMapTypeFor(t, required)`: the validator of `t`.
    fn type_map_type_for(&self, t: TypeRef, required: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let kind = ty.kind();
            if matches!(kind, TypeKind::Class | TypeKind::Object | TypeKind::Enum) {
                if self.is_cycle_breaker_type(t)? {
                    let name = self.name_for_named_type(t)?;
                    return Ok(sl![
                        "(...args) => ",
                        self.sourcelike_to_string(&sl!["_", name])?,
                        "(...args)"
                    ]);
                }
                return Ok(sl!["_", self.name_for_named_type(t)?]);
            }

            let matched: Source = match kind {
            TypeKind::Any => "PropTypes.any".into(),
            TypeKind::Null => "PropTypes.oneOf([null])".into(),
            TypeKind::Bool => "PropTypes.bool".into(),
            TypeKind::Integer => self.number_type(t, true)?,
            TypeKind::Double => self.number_type(t, false)?,
            TypeKind::String => self.string_type(t)?,
            TypeKind::Array => {
                let item = self.type_map_type_for(ty.items()?, false)?;
                let (min, max) = match min_max_items_for_type(graph, t)? {
                    Some(m) => (m.0, m.1),
                    None => (None, None),
                };
                if min.is_none() && max.is_none() {
                    sl!["PropTypes.arrayOf(", item, ")"]
                } else {
                    sl![
                        "(props, name, ...args) => { const value = props[name]; if (value != null && (",
                        match min {
                            None => Source::from("false"),
                            Some(min) => sl!["value.length < ", js_number(min)],
                        },
                        " || ",
                        match max {
                            None => Source::from("false"),
                            Some(max) => sl!["value.length > ", js_number(max)],
                        },
                        ")) return new Error(\"Expected bounded array\"); return PropTypes.arrayOf(",
                        item,
                        ")(props, name, ...args); }"
                    ]
                }
            }
            TypeKind::Map => sl![
                "PropTypes.objectOf(",
                self.type_map_type_for(ty.map_values()?, false)?,
                ")"
            ],
            TypeKind::Union => {
                let is_nullable_enum = find_member(graph, t, TypeKind::Enum)?.is_some()
                    && find_member(graph, t, TypeKind::Null)?.is_some();
                let mut parts: Vec<Source> = vec!["PropTypes.oneOfType([".into()];
                for (i, member) in graph.children(t)?.into_iter().enumerate() {
                    if i > 0 {
                        parts.push(", ".into());
                    }
                    parts.push(
                        if is_nullable_enum && graph.kind(member)? == TypeKind::Null {
                            "PropTypes.oneOf([null])".into()
                        } else {
                            self.type_map_type_for(member, false)?
                        },
                    );
                }
                parts.push("])".into());
                Source::Sequence(parts)
            }
            TypeKind::Uuid => "(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error(\"Expected UUID\")".into(),
            TypeKind::DateTime => "(props, name) => props[name] == null || typeof props[name] === \"string\" && !Number.isNaN(Date.parse(props[name])) ? null : new Error(\"Expected date-time\")".into(),
            k if k.is_transformed_string_type_kind() => "PropTypes.string".into(),
            kind => return type_not_supported(kind),
        };

            let allows_null = kind == TypeKind::Null
                || (kind == TypeKind::Union && find_member(graph, t, TypeKind::Null)?.is_some());
            if required && allows_null {
                return Ok(sl![
                    "(props, name, ...args) => props[name] === undefined ? new Error(\"Expected required property\") : PropTypes.oneOfType([",
                    matched,
                    "])(props, name, ...args)"
                ]);
            }
            if required {
                return Ok(sl!["PropTypes.oneOfType([", matched, "]).isRequired"]);
            }

            Ok(matched)
        })
    }

    /// `typeMapTypeForProperty(p)`.
    fn type_map_type_for_property(&self, p: &ClassProperty) -> Result<Source> {
        self.type_map_type_for(p.type_ref, !p.is_optional)
    }

    /// `importStatement(lhs, moduleName)`.
    fn import_statement(&self, lhs: &str, module_name: &str) -> Source {
        if self.options.module_system {
            return sl!["import ", lhs, " from ", module_name, ";"];
        }

        sl!["const ", lhs, " = require(", module_name, ");"]
    }

    /// `emitUsageComments()`.
    fn emit_usage_comments(&mut self) -> Result<()> {
        // FIXME: Use the correct type name
        let lines: Vec<Source> = vec![
            "Example usage:".into(),
            "".into(),
            self.import_statement("{ MyShape }", "./myShape.js"),
            "".into(),
            "class MyComponent extends React.Component {".into(),
            "  //".into(),
            "}".into(),
            "".into(),
            "MyComponent.propTypes = {".into(),
            "  input: MyShape".into(),
            "};".into(),
        ];
        self.emit_comment_lines(
            &lines,
            &CommentOptions {
                line_start: Some("// ".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    /// `emitImports()`.
    fn emit_imports(&mut self) -> Result<()> {
        self.ensure_blank_line();
        let import = self.import_statement("PropTypes", "\"prop-types\"");
        self.emit_line(import);
        let graph = self.type_graph();
        let mut has_integer = false;
        for t in graph.all_types_unordered() {
            has_integer |= graph.kind(t)? == TypeKind::Integer;
        }
        if has_integer {
            self.emit_line(
                "const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error(\"Expected integer\");",
            );
        }
        Ok(())
    }

    /// `emitExport(name, value)`.
    fn emit_export(&mut self, name: Name, value: Source) {
        if self.options.module_system {
            self.emit_line(sl!["export const ", name, " = ", value, ";"]);
        } else {
            self.emit_line(sl![
                "module.exports = exports = { ",
                name,
                ": ",
                value,
                " };"
            ]);
        }
    }

    /// `emitTypes()`.
    fn emit_types(&mut self) -> Result<()> {
        self.ensure_blank_line();

        self.for_each_object(BlankLinePosition::None, |r, _, name, _| {
            r.emit_line(sl!["let _", name, ";"]);
            Ok(())
        })?;

        self.for_each_enum(BlankLinePosition::None, |r, enum_type, enum_name, _| {
            let mut options: Vec<Source> = Vec::new();
            r.for_each_enum_case(enum_type, BlankLinePosition::None, |_, _, json_name, _| {
                options.push("'".into());
                options.push(utf16_string_escape(json_name).into());
                options.push("'".into());
                options.push(", ".into());
                Ok(())
            })?;
            options.pop();

            let mut line: Vec<Source> = vec![
                "const _".into(),
                enum_name.into(),
                " = PropTypes.oneOf([".into(),
            ];
            line.extend(options);
            line.push("]);".into());
            r.emit_line(Source::Sequence(line));
            Ok(())
        })?;

        let mut order: Vec<usize> = Vec::new();
        let mut map_key: Vec<Name> = Vec::new();
        let mut map_value: Vec<Vec<Source>> = Vec::new();
        self.for_each_object(BlankLinePosition::None, |r, t, name, _| {
            map_key.push(name);
            map_value.push(r.gather_source(|r| r.emit_object(name, t))?);
            Ok(())
        })?;
        // `find(value)` for every shape, once: the shapes (as indexes into
        // `map_key`, by `mapKey.indexOf(name)`) its gathered source refers
        // to, other than itself.
        let mut index_of_name: HashMap<Name, usize> = HashMap::new();
        for (index, &name) in map_key.iter().enumerate() {
            index_of_name.entry(name).or_insert(index);
        }
        let dependencies: Vec<Vec<usize>> = map_value
            .iter()
            .zip(&map_key)
            .map(|(items, &own_name)| {
                let mut found = Vec::new();
                for item in items {
                    item.for_each_name(&mut |name| {
                        if name != own_name {
                            if let Some(&dependency) = index_of_name.get(&name) {
                                found.push(dependency);
                            }
                        }
                    });
                }
                found
            })
            .collect();

        // Pick the first shape whose dependencies are all in `order`, or
        // else the last pending one.
        let mut placed = vec![false; map_key.len()];
        let mut pending: Vec<usize> = (0..map_key.len()).collect();
        while !pending.is_empty() {
            let ready = pending
                .iter()
                .position(|&index| dependencies[index].iter().all(|&d| placed[d]));
            let at = ready.unwrap_or(pending.len() - 1);
            let index = pending.remove(at);
            placed[index] = true;
            order.push(index);
        }

        // now emit ordered source
        for i in order {
            let items = std::mem::take(&mut map_value[i]);
            self.emit_gathered_source(items);
        }

        // now emit top levels
        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            let graph = r.type_graph();
            let ty = graph.type_at(t)?;
            let value = if ty.is_primitive() {
                r.type_map_type_for(t, true)?
            } else if ty.kind() == TypeKind::Array {
                sl![
                    "PropTypes.arrayOf(",
                    r.type_map_type_for(ty.items()?, true)?,
                    ")"
                ]
            } else if matches!(ty.kind(), TypeKind::Map | TypeKind::Union) {
                r.type_map_type_for(t, true)?
            } else {
                sl!["_", name]
            };
            r.ensure_blank_line();
            r.emit_export(name, value);
            Ok(())
        })?;
        Ok(())
    }

    /// `emitObject(name, t)`.
    fn emit_object(&mut self, name: Name, t: TypeRef) -> Result<()> {
        self.ensure_blank_line();
        self.emit_line(sl!["_", name, " = PropTypes.shape({"]);
        self.indent(|r| {
            r.for_each_class_property(t, BlankLinePosition::None, |r, _, json_name, property, _| {
                let ty = r.type_map_type_for_property(&property)?;
                let validator = if property.is_optional
                    && OBJECT_PROTOTYPE_PROPERTIES.contains(&json_name)
                {
                    sl![
                        "(props, name, ...args) => Object.prototype.hasOwnProperty.call(props, name) ? ",
                        ty,
                        "(props, name, ...args) : null"
                    ]
                } else {
                    ty
                };
                r.emit_line(sl![
                    format!("\"{}\"", utf16_string_escape(json_name)),
                    ": ",
                    validator,
                    ","
                ]);
                Ok(())
            })
        })?;
        self.emit_line("});");
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for JavaScriptPropTypesRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn make_named_type_namer(&mut self) -> Namer {
        let acronym_style = self.options.acronym_style;
        fun_prefix_namer("types", move |s| name_style(acronym_style, s, true))
    }

    /// `namerForObjectProperty()`: the module's `identityNamingFunction`.
    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.identity_naming_function.clone()))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        None
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        let acronym_style = self.options.acronym_style;
        Some(fun_prefix_namer("enum-cases", move |s| {
            name_style(acronym_style, s, false)
        }))
    }

    /// `isImplicitCycleBreaker(t)`: nothing breaks cycles implicitly.
    fn is_implicit_cycle_breaker(&self, _t: TypeRef) -> Result<bool> {
        Ok(false)
    }

    fn named_type_to_name_for_top_level(&self, t: TypeRef) -> Result<Option<TypeRef>> {
        directly_reachable_single_named_type(self.type_graph(), t)
    }

    /// `makeNameForProperty(...)`: ignores the assigned name.
    fn make_name_for_property(
        &mut self,
        o: TypeRef,
        class_name: Name,
        p: &ClassProperty,
        json_name: &str,
        _assigned_name: Option<&str>,
    ) -> Result<Option<Name>> {
        defaults::make_name_for_property(self, o, class_name, p, json_name, None)
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        match self.leading_comments() {
            Some(leading_comments) => self.emit_comments(leading_comments)?,
            None => self.emit_usage_comments()?,
        }

        self.emit_imports()?;

        self.emit_types()
    }
}
