//! Port of `packages/quicktype-core/src/language/Objective-C/ObjectiveCRenderer.ts`.
//!
//! Renders an interface (`.h`) and an implementation (`.m`) file:
//! `NSObject` model classes with KVC-based JSON conversion, boxed enums,
//! and C functions that marshal the top-levels.

use std::collections::HashMap;

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::naming::Namer;
use crate::renderer_options::RendererOptions;
use crate::support::comments::CommentOptions;
use crate::support::recursion::{guard, stack_overflow};
use crate::support::strings::{camel_case, fast_is_upper_case, repeat_string, string_escape};
use crate::support::support::{assert, defined};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{is_any_or_null, is_nullable, nullable_from_union};

use super::constants::{FORBIDDEN_PROPERTY_NAMES, KEYWORDS};
use super::language::{
    CLASS_PREFIX, EXTRA_COMMENTS, FEATURES, Features, JUST_TYPES, MARSHALLING_FUNCTIONS,
};
use super::utils::{
    DEFAULT_CLASS_PREFIX, FORBIDDEN_FOR_ENUM_CASES, STATIC_ENUM_VALUES_IDENTIFIER,
    property_name_style, split_extension, type_name_style,
};

/// The option values of the Objective-C renderer (TS
/// `OptionValues<typeof objectiveCOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct ObjectiveCOptions {
    /// `features`.
    pub features: Features,
    /// `justTypes`.
    pub just_types: bool,
    /// `marshallingFunctions`.
    pub marshalling_functions: bool,
    /// `classPrefix`.
    pub class_prefix: String,
    /// `extraComments`.
    pub extra_comments: bool,
}

impl ObjectiveCOptions {
    /// `getOptionValues(objectiveCOptions, values)`: the options in
    /// declaration order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let features = match FEATURES.get_enum_value(values)? {
            "interface" => Features {
                interface: true,
                implementation: false,
            },
            "implementation" => Features {
                interface: false,
                implementation: true,
            },
            _ => Features {
                interface: true,
                implementation: true,
            },
        };
        Ok(ObjectiveCOptions {
            features,
            just_types: JUST_TYPES.get_value(values),
            marshalling_functions: MARSHALLING_FUNCTIONS.get_value(values),
            class_prefix: CLASS_PREFIX.get_value(values).into_owned(),
            extra_comments: EXTRA_COMMENTS.get_value(values),
        })
    }
}

/// `objectiveCStringEscape(s)`: `stringEscape`, with every `\u00XX` escape
/// (not preceded by an escaped backslash) turned into the octal escapes of
/// the character's UTF-8 bytes.
fn objective_c_string_escape(s: &str) -> String {
    let escaped = string_escape(s);
    let chars: Vec<char> = escaped.chars().collect();
    let mut result = String::with_capacity(escaped.len());
    let mut i = 0;
    while i < chars.len() {
        // /\\\\|\\u00([0-9a-f]{2})/g
        if chars[i] == '\\' && chars.get(i + 1) == Some(&'\\') {
            result.push_str("\\\\");
            i += 2;
            continue;
        }
        let is_hex = |c: Option<&char>| c.is_some_and(|c| matches!(c, '0'..='9' | 'a'..='f'));
        if chars[i] == '\\'
            && chars.get(i + 1) == Some(&'u')
            && chars.get(i + 2) == Some(&'0')
            && chars.get(i + 3) == Some(&'0')
            && is_hex(chars.get(i + 4))
            && is_hex(chars.get(i + 5))
        {
            let code: String = chars[i + 4..i + 6].iter().collect();
            let c = u32::from_str_radix(&code, 16)
                .ok()
                .and_then(char::from_u32)
                .unwrap_or('\u{FFFD}');
            let mut buf = [0u8; 4];
            for byte in c.encode_utf8(&mut buf).bytes() {
                result.push_str(&format!("\\{byte:03o}"));
            }
            i += 6;
            continue;
        }
        result.push(chars[i]);
        i += 1;
    }
    result
}

/// `ObjectiveCRenderer`.
pub struct ObjectiveCRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: ObjectiveCOptions,
    /// `_currentFilename`.
    current_filename: Option<String>,
    /// `_classPrefix`.
    class_prefix: String,
}

impl std::fmt::Debug for ObjectiveCRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("ObjectiveCRenderer")
            .field("options", &self.options)
            .field("class_prefix", &self.class_prefix)
            .finish_non_exhaustive()
    }
}

/// `inferClassPrefix(name)`: the leading upper-case UTF-16 units of `name`
/// but the last one (which starts the first word), or
/// [`DEFAULT_CLASS_PREFIX`] if there are fewer than two.
fn infer_class_prefix(name: &str) -> String {
    let units: Vec<u16> = name.encode_utf16().collect();
    let first_non_upper = units
        .iter()
        .take_while(|&&unit| fast_is_upper_case(u32::from(unit)))
        .count();

    if first_non_upper < 2 {
        return DEFAULT_CLASS_PREFIX.to_owned();
    }
    quicktype_js_compat::utf16::units_to_string(&units[..first_non_upper - 1])
}

impl<'a> ObjectiveCRenderer<'a> {
    /// `new ObjectiveCRenderer(targetLanguage, renderContext, options)`:
    /// infers the class prefix from the first top-level's name unless one is
    /// given.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: ObjectiveCOptions,
    ) -> Result<Self> {
        let core = ConvenienceRendererCore::new(target_language, render_context);
        // Infer the class prefix from a top-level name if it's not given
        let class_prefix = if options.class_prefix == DEFAULT_CLASS_PREFIX {
            let a_top_level = defined(core.base.type_graph().top_levels().keys().next())?;
            infer_class_prefix(a_top_level)
        } else {
            options.class_prefix.clone()
        };
        Ok(ObjectiveCRenderer {
            core,
            options,
            current_filename: None,
            class_prefix,
        })
    }

    /// `emitBlock(line, f)`.
    fn emit_block(
        &mut self,
        line: impl Into<Source>,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_line(sl![line.into(), " {"]);
        self.indent(f)?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitMethod(declaration, f)`.
    fn emit_method(
        &mut self,
        declaration: impl Into<Source>,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_line(declaration);
        self.emit_line("{");
        self.indent(f)?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitExtraComments(...comments)`.
    fn emit_extra_comments(&mut self, comments: &[&str]) {
        if !self.options.extra_comments {
            return;
        }
        for &comment in comments {
            self.emit_line(sl!["// ", comment]);
        }
    }

    /// `startFile(basename, extension)`.
    fn start_file(&mut self, basename: &str, extension: &str) -> Result<()> {
        assert(
            self.current_filename.is_none(),
            "Previous file wasn't finished",
        )?;
        // FIXME: The filenames should actually be Sourcelikes, too
        self.current_filename = Some(format!("{basename}.{extension}"));
        Ok(())
    }

    /// `finishFile()`: finishes the current file.
    fn finish_current_file(&mut self) -> Result<()> {
        let filename = defined(self.current_filename.take())?;
        defaults::finish_file(self, &filename)
    }

    /// `memoryAttribute(t, isNullable)`.
    fn memory_attribute(&self, t: TypeRef, is_nullable: bool) -> Result<&'static str> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            Ok(match graph.kind(t)? {
                TypeKind::Any | TypeKind::Null => "copy",
                TypeKind::Bool | TypeKind::Integer | TypeKind::Double => {
                    if is_nullable {
                        "strong"
                    } else {
                        "assign"
                    }
                }
                TypeKind::String | TypeKind::Array | TypeKind::Map => "copy",
                TypeKind::Class => "strong",
                TypeKind::Enum => "assign",
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.memory_attribute(nullable, true)?,
                    None => "copy",
                },
                kind if kind.is_transformed_string_type_kind() => "copy",
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `objcType(t, nullableOrBoxed)`: the type and its pointer suffix.
    fn objc_type(&self, t: TypeRef, nullable_or_boxed: bool) -> Result<(Source, &'static str)> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let boxed = |unboxed: &'static str| -> (Source, &'static str) {
                if nullable_or_boxed {
                    ("NSNumber".into(), " *")
                } else {
                    (unboxed.into(), "")
                }
            };
            Ok(match ty.kind() {
                TypeKind::Any => ("id".into(), ""),
                // For now, we're treating nulls just like any
                TypeKind::Null => ("id".into(), ""),
                TypeKind::Bool => boxed("BOOL"),
                TypeKind::Integer => boxed("NSInteger"),
                TypeKind::Double => boxed("double"),
                TypeKind::String => ("NSString".into(), " *"),
                TypeKind::Array => {
                    let item_type = ty.items()?;
                    let (item_name, item_pointer) = self.objc_type(item_type, true)?;
                    // NSArray<id>* === NSArray*
                    if is_any_or_null(graph, item_type)? {
                        return Ok(("NSArray".into(), " *"));
                    }

                    (sl!["NSArray<", sl![item_name, item_pointer], ">"], " *")
                }
                TypeKind::Class => (self.name_for_named_type(t)?.into(), " *"),
                TypeKind::Map => {
                    let (value_name, value_pointer) = self.objc_type(ty.map_values()?, true)?;
                    (
                        sl![
                            "NSDictionary<NSString *, ",
                            sl![value_name, value_pointer],
                            ">"
                        ],
                        " *",
                    )
                }
                TypeKind::Enum => (self.name_for_named_type(t)?.into(), " *"),
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.objc_type(nullable, true)?,
                    None => ("id".into(), ""),
                },
                kind if kind.is_transformed_string_type_kind() => ("NSString".into(), " *"),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `jsonType(t)`: the JSON (Foundation) type and its pointer suffix.
    fn json_type(&self, t: TypeRef) -> Result<(Source, &'static str)> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => ("id".into(), ""),
                // For now, we're treating nulls just like any
                TypeKind::Null => ("id".into(), ""),
                TypeKind::Bool | TypeKind::Integer | TypeKind::Double => ("NSNumber".into(), " *"),
                TypeKind::String => ("NSString".into(), " *"),
                TypeKind::Array => ("NSArray".into(), " *"),
                TypeKind::Class => ("NSDictionary<NSString *, id>".into(), " *"),
                TypeKind::Map => {
                    let (value_name, value_pointer) = self.json_type(ty.map_values()?)?;
                    (
                        sl![
                            "NSDictionary<NSString *, ",
                            sl![value_name, value_pointer],
                            ">"
                        ],
                        " *",
                    )
                }
                TypeKind::Enum => ("NSString".into(), " *"),
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.json_type(nullable)?,
                    None => ("id".into(), ""),
                },
                kind if kind.is_transformed_string_type_kind() => ("NSString".into(), " *"),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `fromDynamicExpression(t, ...dynamic)`.
    #[allow(clippy::wrong_self_convention)] // named after TypeScript's `fromDynamicExpression`
    fn from_dynamic_expression(&self, t: TypeRef, dynamic: Source) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any
                | TypeKind::Null
                | TypeKind::Bool
                | TypeKind::Integer
                | TypeKind::Double
                | TypeKind::String => dynamic,
                TypeKind::Array => sl![
                    "map(",
                    dynamic,
                    ", λ(id x, ",
                    self.from_dynamic_expression(ty.items()?, "x".into())?,
                    "))"
                ],
                TypeKind::Class => sl![
                    "[",
                    self.name_for_named_type(t)?,
                    " fromJSONDictionary:",
                    dynamic,
                    "]"
                ],
                TypeKind::Map => sl![
                    "map(",
                    dynamic,
                    ", λ(id x, ",
                    self.from_dynamic_expression(ty.map_values()?, "x".into())?,
                    "))"
                ],
                TypeKind::Enum => sl![
                    "[",
                    self.name_for_named_type(t)?,
                    " withValue:",
                    dynamic,
                    "]"
                ],
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.from_dynamic_expression(nullable, dynamic)?,
                    None => dynamic,
                },
                kind if kind.is_transformed_string_type_kind() => dynamic,
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `toDynamicExpression(t, typed)`.
    fn to_dynamic_expression(&self, t: TypeRef, typed: Source) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any | TypeKind::Null => sl!["NSNullify(", typed, ")"],
                // Sadly, KVC
                TypeKind::Bool => sl![typed, " ? @YES : @NO"],
                TypeKind::Integer | TypeKind::Double | TypeKind::String => typed,
                TypeKind::Array => {
                    if self.implicitly_converts_from_json(t)? {
                        // TODO check each value type
                        return Ok(typed);
                    }

                    sl![
                        "map(",
                        typed,
                        ", λ(id x, ",
                        self.to_dynamic_expression(ty.items()?, "x".into())?,
                        "))"
                    ]
                }
                TypeKind::Class => sl!["[", typed, " JSONDictionary]"],
                TypeKind::Map => {
                    if self.implicitly_converts_from_json(t)? {
                        // TODO check each value type
                        return Ok(typed);
                    }

                    sl![
                        "map(",
                        typed,
                        ", λ(id x, ",
                        self.to_dynamic_expression(ty.map_values()?, "x".into())?,
                        "))"
                    ]
                }
                TypeKind::Enum => sl!["[", typed, " value]"],
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => {
                        if graph.kind(nullable)? == TypeKind::Class {
                            sl![
                                "NSNullify([",
                                typed.clone(),
                                " isKindOfClass:NSNull.class] ? nil : [",
                                typed,
                                " JSONDictionary])"
                            ]
                        } else if self.implicitly_converts_from_json(nullable)? {
                            sl!["NSNullify(", typed, ")"]
                        } else {
                            sl![
                                "NSNullify(",
                                self.to_dynamic_expression(nullable, typed)?,
                                ")"
                            ]
                        }
                    }
                    // TODO support unions
                    None => typed,
                },
                kind if kind.is_transformed_string_type_kind() => typed,
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `implicitlyConvertsFromJSON(t)`.
    fn implicitly_converts_from_json(&self, t: TypeRef) -> Result<bool> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            match ty.kind() {
                TypeKind::Class | TypeKind::Enum => Ok(false),
                TypeKind::Array => self.implicitly_converts_from_json(ty.items()?),
                TypeKind::Map => self.implicitly_converts_from_json(ty.map_values()?),
                kind if kind.is_primitive_type_kind() => Ok(true),
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    Some(nullable) => self.implicitly_converts_from_json(nullable),
                    // We don't support unions yet, so this is just untyped
                    None => Ok(true),
                },
                _ => Ok(false),
            }
        })
    }

    /// `implicitlyConvertsToJSON(t)`.
    fn implicitly_converts_to_json(&self, t: TypeRef) -> Result<bool> {
        Ok(self.implicitly_converts_from_json(t)? && self.type_graph().kind(t)? != TypeKind::Bool)
    }

    /// `emitPropertyAssignment(propertyName, jsonName, propertyType)`.
    fn emit_property_assignment(
        &mut self,
        property_name: Name,
        json_name: &str,
        property_type: TypeRef,
    ) -> Result<()> {
        let name = sl!["_", property_name];
        let graph = self.type_graph();
        let ty = graph.type_at(property_type)?;
        match ty.kind() {
            TypeKind::Any
            | TypeKind::Null
            | TypeKind::Bool
            | TypeKind::Integer
            | TypeKind::Double
            | TypeKind::String
            | TypeKind::Array => {
                let expression = self.from_dynamic_expression(property_type, name.clone())?;
                self.emit_line(sl![name, " = ", expression, ";"]);
            }
            TypeKind::Class => {
                let expression =
                    self.from_dynamic_expression(property_type, sl!["(id)", name.clone()])?;
                self.emit_line(sl![name.clone(), " = ", expression, ";"]);
                let escaped = objective_c_string_escape(json_name);
                let name_string = self.sourcelike_to_string(&name)?;
                self.emit_line(format!(
                    "if (!{name_string} && dict[@\"{escaped}\"] && ![dict[@\"{escaped}\"] isKindOfClass:NSNull.class]) return nil;"
                ));
            }
            TypeKind::Map => {
                let item_type = ty.map_values()?;
                let expression = self.from_dynamic_expression(item_type, "x".into())?;
                self.emit_line(sl![
                    name.clone(),
                    " = map(",
                    name,
                    ", ",
                    sl!["λ(id x, ", expression, ")"],
                    ");"
                ]);
            }
            TypeKind::Enum => {
                let expression =
                    self.from_dynamic_expression(property_type, sl!["(id)", name.clone()])?;
                self.emit_line(sl![name, " = ", expression, ";"]);
            }
            TypeKind::Union => match nullable_from_union(graph, property_type)? {
                Some(nullable) => {
                    self.emit_property_assignment(property_name, json_name, nullable)?;
                    if graph.kind(nullable)? == TypeKind::Enum {
                        let escaped = objective_c_string_escape(json_name);
                        self.emit_line(sl![
                            "if (",
                            name,
                            format!(
                                " == nil && dict[@\"{escaped}\"] && ![dict[@\"{escaped}\"] isKindOfClass:NSNull.class]) return nil;"
                            )
                        ]);
                    }
                }
                None => {
                    // TODO This is a union, but for now we just leave it dynamic
                    let expression = self.from_dynamic_expression(property_type, name.clone())?;
                    self.emit_line(sl![name, " = ", expression, ";"]);
                }
            },
            kind => return match_type_unsupported(kind),
        }
        Ok(())
    }

    /// `emitPrivateClassInterface(_, name)`.
    fn emit_private_class_interface(&mut self, name: Name) {
        self.emit_line(sl!["@interface ", name, " (JSONConversion)"]);
        self.emit_line("+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;");
        self.emit_line("- (NSDictionary *)JSONDictionary;");
        self.emit_line("@end");
    }

    /// `pointerAwareTypeName(t)`: the type with its `" *"`, or followed by
    /// a space if it is not a pointer.
    fn pointer_aware_type_name(&self, t: TypeRef) -> Result<Source> {
        let (name, pointer) = self.objc_type(t, false)?;
        let is_pointer = !pointer.is_empty();
        Ok(if is_pointer {
            sl![name, pointer]
        } else {
            sl![sl![name, pointer], " "]
        })
    }

    /// `emitNonClassTopLevelTypedef(t, name)`.
    fn emit_non_class_top_level_typedef(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let non_pointer_type_name: Source = if self.type_graph().kind(t)? == TypeKind::Union {
            "NSObject".into()
        } else {
            self.objc_type(t, true)?.0
        };
        self.emit_line(sl!["typedef ", non_pointer_type_name, " ", name, ";"]);
        Ok(())
    }

    /// `topLevelFromDataPrototype(name)`.
    fn top_level_from_data_prototype(name: Name) -> Source {
        sl![
            name,
            " *_Nullable ",
            name,
            "FromData(NSData *data, NSError **error)"
        ]
    }

    /// `topLevelFromJSONPrototype(name)`.
    fn top_level_from_json_prototype(name: Name) -> Source {
        sl![
            name,
            " *_Nullable ",
            name,
            "FromJSON(NSString *json, NSStringEncoding encoding, NSError **error)"
        ]
    }

    /// The padding of `topLevelToDataPrototype` and
    /// `topLevelToJSONPrototype`: `repeatString(" ", nameLength - length)`,
    /// which fails for a name shorter than the return type.
    fn prototype_padding(&self, name: Name, pad: bool, return_type: &str) -> Result<String> {
        if !pad {
            return Ok(String::new());
        }
        let name_length =
            quicktype_js_compat::utf16::len(&self.sourcelike_to_string(&name.into())?);
        assert(
            name_length >= return_type.len(),
            "Cannot repeat a string a negative number of times",
        )?;
        Ok(repeat_string(" ", name_length - return_type.len()))
    }

    /// `topLevelToDataPrototype(name, pad)`.
    fn top_level_to_data_prototype(&self, name: Name, pad: bool) -> Result<Source> {
        let parameter = self.variable_name_for_top_level(name);
        let padding = self.prototype_padding(name, pad, "NSData")?;
        Ok(sl![
            "NSData",
            padding,
            " *_Nullable ",
            name,
            "ToData(",
            name,
            " *",
            parameter,
            ", NSError **error)"
        ])
    }

    /// `topLevelToJSONPrototype(name, pad)`.
    fn top_level_to_json_prototype(&self, name: Name, pad: bool) -> Result<Source> {
        let parameter = self.variable_name_for_top_level(name);
        let padding = self.prototype_padding(name, pad, "NSString")?;
        Ok(sl![
            "NSString",
            padding,
            " *_Nullable ",
            name,
            "ToJSON(",
            name,
            " *",
            parameter,
            ", NSStringEncoding encoding, NSError **error)"
        ])
    }

    /// `emitTopLevelFunctionDeclarations(_, name)`.
    fn emit_top_level_function_declarations(&mut self, name: Name) -> Result<()> {
        self.emit_line(sl![Self::top_level_from_data_prototype(name), ";"]);
        self.emit_line(sl![Self::top_level_from_json_prototype(name), ";"]);
        let to_data = self.top_level_to_data_prototype(name, true)?;
        self.emit_line(sl![to_data, ";"]);
        let to_json = self.top_level_to_json_prototype(name, true)?;
        self.emit_line(sl![to_json, ";"]);
        Ok(())
    }

    /// `emitTryCatchAsError(inTry, inCatch)`; `inCatch` is always
    /// `return nil;`.
    fn emit_try_catch_as_error(
        &mut self,
        in_try: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_line("@try {");
        self.indent(in_try)?;
        self.emit_line("} @catch (NSException *exception) {");
        self.indent(|r| {
            r.emit_line(
                "*error = [NSError errorWithDomain:@\"JSONSerialization\" code:-1 userInfo:@{ @\"exception\": exception }];",
            );
            r.emit_line("return nil;");
            Ok(())
        })?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitTopLevelFunctions(t, name)`.
    fn emit_top_level_functions(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let parameter = self.variable_name_for_top_level(name);

        self.ensure_blank_line();
        self.emit_method(Self::top_level_from_data_prototype(name), |r| {
            r.emit_try_catch_as_error(|r| {
                r.emit_line(
                    "id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];",
                );
                let graph = r.type_graph();
                let ty = graph.type_at(t)?;
                let is_array = ty.kind() == TypeKind::Array;
                let container = if is_array { "NSArray" } else { "NSDictionary" };
                if is_array || ty.kind() == TypeKind::Map {
                    r.emit_line(sl![
                        "if (![json isKindOfClass:",
                        container,
                        ".class]) [NSException raise:@\"Invalid JSON\" format:@\"Expected ",
                        container,
                        ".\"];"
                    ]);
                }
                if is_array && graph.kind(ty.items()?)?.is_primitive_type_kind() {
                    let item_type = r.json_type(ty.items()?)?.0;
                    r.emit_line(sl![
                        "for (id item in json) if (![item isKindOfClass:",
                        item_type,
                        ".class]) [NSException raise:@\"Invalid JSON\" format:@\"Invalid array item.\"];"
                    ]);
                }
                let expression = r.from_dynamic_expression(t, "json".into())?;
                r.emit_line(sl!["return *error ? nil : ", expression, ";"]);
                Ok(())
            })
        })?;

        self.ensure_blank_line();
        self.emit_method(Self::top_level_from_json_prototype(name), |r| {
            r.emit_line(sl![
                "return ",
                name,
                "FromData([json dataUsingEncoding:encoding], error);"
            ]);
            Ok(())
        })?;

        self.ensure_blank_line();
        let to_data = self.top_level_to_data_prototype(name, false)?;
        self.emit_method(to_data, |r| {
            r.emit_try_catch_as_error(|r| {
                let expression = r.to_dynamic_expression(t, parameter.clone())?;
                r.emit_line(sl!["id json = ", expression, ";"]);
                r.emit_line(
                    "NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingFragmentsAllowed error:error];",
                );
                r.emit_line("return *error ? nil : data;");
                Ok(())
            })
        })?;

        self.ensure_blank_line();
        let to_json = self.top_level_to_json_prototype(name, false)?;
        self.emit_method(to_json, |r| {
            r.emit_line(sl![
                "NSData *data = ",
                name,
                "ToData(",
                parameter,
                ", error);"
            ]);
            r.emit_line(
                "return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;",
            );
            Ok(())
        })
    }

    /// `mapContains(this.topLevels, t)`.
    fn is_top_level(&self, t: TypeRef) -> bool {
        self.top_levels().values().any(|&top_level| top_level == t)
    }

    /// `emitClassInterface(t, className)`.
    fn emit_class_interface(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        let is_top_level = self.is_top_level(t);

        let description = self.description_for_type(t)?;
        self.emit_description(description)?;

        self.emit_line(sl!["@interface ", class_name, " : NSObject"]);
        self.emit_property_table(t, |r, name, _json, property| {
            let mut attributes = vec!["nonatomic"];
            // TODO offer a 'readonly' option
            // TODO We must add "copy" if it's NSCopy, otherwise "strong"
            let nullable = is_nullable(r.type_graph(), property.type_ref)?;
            if nullable {
                attributes.push("nullable");
            }

            attributes.push(r.memory_attribute(property.type_ref, nullable)?);
            let type_name = r.pointer_aware_type_name(property.type_ref)?;
            Ok(vec![
                sl!["@property ", sl!["(", attributes.join(", "), ")"], " "],
                sl![type_name, name, ";"],
            ])
        })?;

        if !self.options.just_types && is_top_level {
            if !self.type_graph().type_at(t)?.properties()?.is_empty() {
                self.ensure_blank_line();
            }

            self.emit_line(
                "+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;",
            );
            self.emit_line(
                "+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;",
            );
            self.emit_line(
                "- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;",
            );
            self.emit_line("- (NSData *_Nullable)toData:(NSError *_Nullable *)error;");
        }

        self.emit_line("@end");
        Ok(())
    }

    /// `hasIrregularProperties(t)`: whether a property's name differs from
    /// its escaped JSON name.
    fn has_irregular_properties(&mut self, t: TypeRef) -> Result<bool> {
        let mut irregular = false;
        self.for_each_class_property(t, BlankLinePosition::None, |r, name, json_name, _, _| {
            irregular = irregular
                || objective_c_string_escape(json_name) != r.sourcelike_to_string(&name.into())?;
            Ok(())
        })?;
        Ok(irregular)
    }

    /// `hasUnsafeProperties(t)`: whether a property needs a conversion to
    /// JSON.
    fn has_unsafe_properties(&mut self, t: TypeRef) -> Result<bool> {
        let mut unsafe_ = false;
        self.for_each_class_property(t, BlankLinePosition::None, |r, _, _, property, _| {
            unsafe_ = unsafe_ || !r.implicitly_converts_to_json(property.type_ref)?;
            Ok(())
        })?;
        Ok(unsafe_)
    }

    /// The validation lines of `initWithJSONDictionary:` for one property.
    fn emit_property_checks(&mut self, json_name: &str, property: ClassProperty) -> Result<()> {
        let graph = self.type_graph();
        let t = property.type_ref;
        let ty = graph.type_at(t)?;
        let kind = ty.kind();
        let key = objective_c_string_escape(json_name);
        let number = quicktype_js_compat::number::to_string;
        let (min, max) = min_max_value_for_type(graph, t)?.map_or((None, None), |c| (c.0, c.1));
        if let Some(min) = min {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && [dict[@\"{key}\"] doubleValue] < {}) return nil;",
                number(min)
            ));
        }
        if let Some(max) = max {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && [dict[@\"{key}\"] doubleValue] > {}) return nil;",
                number(max)
            ));
        }
        let (min_items, max_items) =
            min_max_items_for_type(graph, t)?.map_or((None, None), |c| (c.0, c.1));
        if let Some(min_items) = min_items {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && [(NSArray *)dict[@\"{key}\"] count] < {}) return nil;",
                number(min_items)
            ));
        }
        if let Some(max_items) = max_items {
            self.emit_line(format!(
                "if ([(NSArray *)dict[@\"{key}\"] count] > {}) return nil;",
                number(max_items)
            ));
        }
        if let Some(pattern) = pattern_for_type(graph, t)? {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && [dict[@\"{key}\"] rangeOfString:@\"{}\" options:NSRegularExpressionSearch].location == NSNotFound) return nil;",
                objective_c_string_escape(&pattern)
            ));
        }
        let (min_length, max_length) =
            min_max_length_for_type(graph, t)?.map_or((None, None), |c| (c.0, c.1));
        if let Some(min_length) = min_length {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && [dict[@\"{key}\"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < {}) return nil;",
                number(min_length)
            ));
        }
        if let Some(max_length) = max_length {
            self.emit_line(format!(
                "if ([dict[@\"{key}\"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 > {}) return nil;",
                number(max_length)
            ));
        }
        if kind == TypeKind::Uuid {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && ![[NSUUID alloc] initWithUUIDString:dict[@\"{key}\"]]) return nil;"
            ));
        }
        if kind == TypeKind::DateTime {
            self.emit_line(format!(
                "if (dict[@\"{key}\"] && [dict[@\"{key}\"] rangeOfString:@\"^[0-9]{{4}}-[0-9]{{2}}-[0-9]{{2}}T\" options:NSRegularExpressionSearch].location == NSNotFound) return nil;"
            ));
        }
        if !property.is_optional && is_nullable(graph, t)? {
            self.emit_line(format!("if (!dict[@\"{key}\"]) return nil;"));
        }
        if !property.is_optional
            && !matches!(kind, TypeKind::Any | TypeKind::Null | TypeKind::Union)
        {
            let json_class: Source = if matches!(kind, TypeKind::Class | TypeKind::Map) {
                "NSDictionary".into()
            } else {
                self.json_type(t)?.0
            };
            self.emit_line(sl![
                format!("if (![dict[@\"{key}\"] isKindOfClass:"),
                json_class,
                ".class]) return nil;"
            ]);
        }
        if kind == TypeKind::Integer {
            self.emit_line(format!(
                "if ([dict[@\"{key}\"] doubleValue] != [dict[@\"{key}\"] longLongValue]) return nil;"
            ));
        }
        if kind == TypeKind::Map {
            let values = ty.map_values()?;
            if matches!(
                graph.kind(values)?,
                TypeKind::Bool | TypeKind::Integer | TypeKind::Double | TypeKind::String
            ) {
                let value_type = self.json_type(values)?.0;
                self.emit_line(sl![
                    format!(
                        "for (id value in [dict[@\"{key}\"] allValues]) if (![value isKindOfClass:"
                    ),
                    value_type,
                    ".class]) return nil;"
                ]);
            }
        }
        Ok(())
    }

    /// `- (NSDictionary *)JSONDictionary` of `emitClassImplementation`.
    fn emit_json_dictionary_method(
        &mut self,
        t: TypeRef,
        class_name: Name,
        has_irregular_properties: bool,
        has_unsafe_properties: bool,
    ) -> Result<()> {
        self.emit_method("- (NSDictionary *)JSONDictionary", |r| {
            if !has_irregular_properties && !has_unsafe_properties {
                r.emit_line(sl![
                    "return [self dictionaryWithValuesForKeys:",
                    class_name,
                    ".properties.allValues];"
                ]);
                return Ok(());
            }

            r.emit_line(sl![
                "id dict = [[self dictionaryWithValuesForKeys:",
                class_name,
                ".properties.allValues] mutableCopy];"
            ]);
            r.ensure_blank_line();

            if has_irregular_properties {
                r.emit_extra_comments(&["Rewrite property names that differ in JSON"]);
                r.emit_block(
                    sl!["for (id jsonName in ", class_name, ".properties)"],
                    |r| {
                        r.emit_line(sl![
                            "id propertyName = ",
                            class_name,
                            ".properties[jsonName];"
                        ]);
                        r.emit_block("if (![jsonName isEqualToString:propertyName])", |r| {
                            r.emit_line("dict[jsonName] = dict[propertyName];");
                            r.emit_line("[dict removeObjectForKey:propertyName];");
                            Ok(())
                        })
                    },
                )?;
            }

            if has_unsafe_properties {
                r.ensure_blank_line();
                r.emit_extra_comments(&["Map values that need translation"]);
                r.emit_line("[dict addEntriesFromDictionary:@{");
                r.indent(|r| {
                    r.for_each_class_property(
                        t,
                        BlankLinePosition::None,
                        |r, property_name, json_key, property, _| {
                            if !r.implicitly_converts_to_json(property.type_ref)? {
                                let key = objective_c_string_escape(json_key);
                                let name = sl!["_", property_name];
                                let expression =
                                    r.to_dynamic_expression(property.type_ref, name)?;
                                r.emit_line(sl!["@\"", key, "\": ", expression, ","]);
                            }
                            Ok(())
                        },
                    )
                })?;
                r.emit_line("}];");
            }

            r.ensure_blank_line();
            r.emit_line("return dict;");
            Ok(())
        })
    }

    // TODO Implement NSCopying
    /// `emitClassImplementation(t, className)`.
    fn emit_class_implementation(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        let is_top_level = self.is_top_level(t);

        let has_irregular_properties = self.has_irregular_properties(t)?;
        let has_unsafe_properties = self.has_unsafe_properties(t)?;

        self.emit_line(sl!["@implementation ", class_name]);
        if !self.options.just_types {
            self.emit_method(
                "+ (NSDictionary<NSString *, NSString *> *)properties",
                |r| {
                    r.emit_line("static NSDictionary<NSString *, NSString *> *properties;");
                    r.emit_line("return properties = properties ? properties : @{");
                    r.indent(|r| {
                        r.for_each_class_property(
                            t,
                            BlankLinePosition::None,
                            |r, name, json_name, _, _| {
                                r.emit_line(sl![
                                    format!("@\"{}\": @\"", objective_c_string_escape(json_name)),
                                    name,
                                    "\","
                                ]);
                                Ok(())
                            },
                        )
                    })?;
                    r.emit_line("};");
                    Ok(())
                },
            )?;
            self.ensure_blank_line();

            if is_top_level {
                self.emit_method(
                    "+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error",
                    |r| {
                        r.emit_line(sl!["return ", class_name, "FromData(data, error);"]);
                        Ok(())
                    },
                )?;
                self.ensure_blank_line();
                self.emit_method(
                    "+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error",
                    |r| {
                        r.emit_line(sl![
                            "return ",
                            class_name,
                            "FromJSON(json, encoding, error);"
                        ]);
                        Ok(())
                    },
                )?;
                self.ensure_blank_line();
            }

            self.emit_method(
                "+ (instancetype)fromJSONDictionary:(NSDictionary *)dict",
                |r| {
                    r.emit_line(sl![
                        "return [dict isKindOfClass:NSDictionary.class] ? [[",
                        class_name,
                        " alloc] initWithJSONDictionary:dict] : nil;"
                    ]);
                    Ok(())
                },
            )?;
            self.ensure_blank_line();
            self.emit_method(
                "- (instancetype)initWithJSONDictionary:(NSDictionary *)dict",
                |r| {
                    r.emit_block("if (self = [super init])", |r| {
                        r.for_each_class_property(
                            t,
                            BlankLinePosition::None,
                            |r, _name, json_name, property, _| {
                                r.emit_property_checks(json_name, property)
                            },
                        )?;

                        r.emit_line("[self setValuesForKeysWithDictionary:dict];");
                        r.for_each_class_property(
                            t,
                            BlankLinePosition::None,
                            |r, name, json_name, property, _| {
                                if !r.implicitly_converts_from_json(property.type_ref)? {
                                    r.emit_property_assignment(name, json_name, property.type_ref)?;
                                }
                                Ok(())
                            },
                        )
                    })?;
                    r.emit_line("return self;");
                    Ok(())
                },
            )?;

            self.ensure_blank_line();
            self.emit_method(
                "- (void)setValue:(nullable id)value forKey:(NSString *)key",
                |r| {
                    r.emit_line(sl!["id resolved = ", class_name, ".properties[key];"]);
                    r.emit_line("if (resolved) [super setValue:value forKey:resolved];");
                    Ok(())
                },
            )?;

            // setNilValueForKey: is automatically invoked by the NSObject setValue:forKey: when it is passed nil for a scalar (a.k.a. non-nullable) object
            // The approach below sets the scalar to 0 in this case, and therefore assumes an initializer with incomplete data shouldn't be grounds for raising an exception.
            // Put another way, if the initializer didn't have a key at all, there wouldn't be an exception raised, so sending nil for something probably shouldn't cause one.
            self.ensure_blank_line();
            self.emit_method("- (void)setNilValueForKey:(NSString *)key", |r| {
                r.emit_line(sl!["id resolved = ", class_name, ".properties[key];"]);
                r.emit_line("if (resolved) [super setValue:@(0) forKey:resolved];");
                Ok(())
            })?;

            self.ensure_blank_line();
            self.emit_json_dictionary_method(
                t,
                class_name,
                has_irregular_properties,
                has_unsafe_properties,
            )?;

            if is_top_level {
                self.ensure_blank_line();
                self.emit_method(
                    "- (NSData *_Nullable)toData:(NSError *_Nullable *)error",
                    |r| {
                        r.emit_line(sl!["return ", class_name, "ToData(self, error);"]);
                        Ok(())
                    },
                )?;
                self.ensure_blank_line();
                self.emit_method(
                    "- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error",
                    |r| {
                        r.emit_line(sl![
                            "return ",
                            class_name,
                            "ToJSON(self, encoding, error);"
                        ]);
                        Ok(())
                    },
                )?;
            }
        }

        self.emit_line("@end");
        Ok(())
    }

    /// `emitMark(label)`.
    fn emit_mark(&mut self, label: &str) {
        self.ensure_blank_line();
        self.emit_line(format!("#pragma mark - {label}"));
        self.ensure_blank_line();
    }

    /// `variableNameForTopLevel(name)`: the name without the class prefix,
    /// in camelCase.
    fn variable_name_for_top_level(&self, name: Name) -> Source {
        let prefix_length = quicktype_js_compat::utf16::len(&self.class_prefix) as i64;
        modify_source(
            move |serialized| {
                // 1. remove class prefix
                let serialized = quicktype_js_compat::utf16::slice(serialized, prefix_length, None);
                // 2. camel case
                camel_case(serialized)
            },
            name,
        )
    }

    /// `emitPseudoEnumInterface(enumType, enumName)`.
    fn emit_pseudo_enum_interface(&mut self, enum_type: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(enum_type)?;
        self.emit_description(description)?;

        self.emit_line(sl!["@interface ", enum_name, " : NSObject"]);
        self.emit_line("@property (nonatomic, readonly, copy) NSString *value;");
        self.emit_line("+ (instancetype _Nullable)withValue:(NSString *)value;");
        self.for_each_enum_case(enum_type, BlankLinePosition::None, |r, name, _, _| {
            r.emit_line(sl!["+ (", enum_name, " *)", name, ";"]);
            Ok(())
        })?;
        self.emit_line("@end");
        Ok(())
    }

    /// `emitPseudoEnumImplementation(enumType, enumName)`.
    fn emit_pseudo_enum_implementation(
        &mut self,
        enum_type: TypeRef,
        enum_name: Name,
    ) -> Result<()> {
        self.emit_line(sl!["@implementation ", enum_name]);

        let instances = sl![enum_name, ".", STATIC_ENUM_VALUES_IDENTIFIER];
        self.emit_method(
            sl![
                "+ (NSDictionary<NSString *, ",
                enum_name,
                " *> *)",
                STATIC_ENUM_VALUES_IDENTIFIER
            ],
            |r| {
                r.emit_line(sl![
                    "static NSDictionary<NSString *, ",
                    enum_name,
                    " *> *",
                    STATIC_ENUM_VALUES_IDENTIFIER,
                    ";"
                ]);
                r.emit_line(sl![
                    "return ",
                    STATIC_ENUM_VALUES_IDENTIFIER,
                    " = ",
                    STATIC_ENUM_VALUES_IDENTIFIER,
                    " ? ",
                    STATIC_ENUM_VALUES_IDENTIFIER,
                    " : @{"
                ]);
                r.indent(|r| {
                    r.for_each_enum_case(
                        enum_type,
                        BlankLinePosition::None,
                        |r, _, json_value, _| {
                            let value = sl!["@\"", objective_c_string_escape(json_value), "\""];
                            r.emit_line(sl![
                                value.clone(),
                                ": [[",
                                enum_name,
                                " alloc] initWithValue:",
                                value,
                                "],"
                            ]);
                            Ok(())
                        },
                    )
                })?;
                r.emit_line("};");
                Ok(())
            },
        )?;

        self.ensure_blank_line();
        self.for_each_enum_case(
            enum_type,
            BlankLinePosition::None,
            |r, name, json_value, _| {
                r.emit_line(sl![
                    "+ (",
                    enum_name,
                    " *)",
                    name,
                    " { return ",
                    instances.clone(),
                    "[@\"",
                    objective_c_string_escape(json_value),
                    "\"]; }"
                ]);
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        self.emit_method(
            "+ (instancetype _Nullable)withValue:(NSString *)value",
            |r| {
                r.emit_line(sl!["return ", instances, "[value];"]);
                Ok(())
            },
        )?;

        self.ensure_blank_line();
        self.emit_method("- (instancetype)initWithValue:(NSString *)value", |r| {
            r.emit_line("if (self = [super init]) _value = value;");
            r.emit_line("return self;");
            Ok(())
        })?;
        self.ensure_blank_line();

        self.emit_line("- (NSUInteger)hash { return _value.hash; }");
        self.emit_line("@end");
        Ok(())
    }

    /// The interface (`.h`) file of `emitSourceStructure`.
    fn emit_interface_file(&mut self, filename: &str) -> Result<()> {
        self.start_file(filename, "h")?;

        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        } else if !self.options.just_types {
            self.emit_comment_lines(
                &["To parse this JSON:".into(), "".into()],
                &CommentOptions::default(),
            )?;
            self.emit_line("//   NSError *error;");
            self.for_each_top_level(BlankLinePosition::None, |r, t, top_level_name, _| {
                let from_json_expression = if r.type_graph().kind(t)? == TypeKind::Class {
                    sl![
                        "[",
                        top_level_name,
                        " fromJSON:json encoding:NSUTF8Encoding error:&error];"
                    ]
                } else {
                    sl![top_level_name, "FromJSON(json, NSUTF8Encoding, &error);"]
                };
                let variable_name = r.variable_name_for_top_level(top_level_name);
                r.emit_line(sl![
                    "//   ",
                    top_level_name,
                    " *",
                    variable_name,
                    " = ",
                    from_json_expression
                ]);
                Ok(())
            })?;
        }

        self.ensure_blank_line();
        self.emit_line("#import <Foundation/Foundation.h>");
        self.ensure_blank_line();

        // Emit @class declarations for top-level array+maps and classes
        self.for_each_named_type(
            BlankLinePosition::None,
            |r, _, class_name, _| {
                r.emit_line(sl!["@class ", class_name, ";"]);
                Ok(())
            },
            |r, _, enum_name, _| {
                r.emit_line(sl!["@class ", enum_name, ";"]);
                Ok(())
            },
            |_, _, _, _| Ok(()),
        )?;
        self.ensure_blank_line();

        self.ensure_blank_line();
        self.emit_line("NS_ASSUME_NONNULL_BEGIN");
        self.ensure_blank_line();

        if self.have_enums()? {
            self.emit_mark("Boxed enums");
            self.for_each_enum(BlankLinePosition::LeadingAndInterposing, |r, t, n, _| {
                r.emit_pseudo_enum_interface(t, n)
            })?;
        }

        // Emit interfaces for top-level array+maps and classes
        self.for_each_top_level_where(
            BlankLinePosition::LeadingAndInterposing,
            |r, t| {
                let kind = r.type_graph().kind(t)?;
                Ok(!(kind == TypeKind::Class || kind == TypeKind::Enum))
            },
            |r, t, n, _| r.emit_non_class_top_level_typedef(t, n),
        )?;

        let mut has_top_level_non_class_types = false;
        for &t in self.top_levels().values() {
            if self.type_graph().kind(t)? != TypeKind::Class {
                has_top_level_non_class_types = true;
                break;
            }
        }
        if !self.options.just_types
            && (has_top_level_non_class_types || self.options.marshalling_functions)
        {
            self.ensure_blank_line();
            self.emit_mark("Top-level marshaling functions");
            self.for_each_top_level_where(
                BlankLinePosition::LeadingAndInterposing,
                // Objective-C developers get freaked out by C functions, so we don't
                // declare them for top-level object types (we always need them for non-object types)
                |r, t| {
                    Ok(r.options.marshalling_functions
                        || r.type_graph().kind(t)? != TypeKind::Class)
                },
                |r, _, n, _| r.emit_top_level_function_declarations(n),
            )?;
        }

        self.emit_mark("Object interfaces");
        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.emit_class_interface(c, class_name),
            |_, _, _, _| Ok(()),
            |_, _, _, _| Ok(()),
        )?;

        self.ensure_blank_line();
        self.emit_line("NS_ASSUME_NONNULL_END");
        self.finish_current_file()
    }

    /// The implementation (`.m`) file of `emitSourceStructure`.
    fn emit_implementation_file(&mut self, filename: &str, extension: &str) -> Result<()> {
        self.start_file(filename, extension)?;

        self.emit_line(format!("#import \"{filename}.h\""));
        self.ensure_blank_line();

        if !self.options.just_types {
            self.ensure_blank_line();
            self.emit_extra_comments(&["Shorthand for simple blocks"]);
            self.emit_line("#define λ(decl, expr) (^(decl) { return (expr); })");
            self.ensure_blank_line();
            self.emit_extra_comments(&["nil → NSNull conversion for JSON dictionaries"]);
            self.emit_block("static id NSNullify(id _Nullable x)", |r| {
                r.emit_line("return (x == nil || x == NSNull.null) ? NSNull.null : x;");
                Ok(())
            })?;
            self.ensure_blank_line();
            self.emit_line("NS_ASSUME_NONNULL_BEGIN");
            self.ensure_blank_line();

            // We wouldn't need to emit these private iterfaces if we emitted implementations in forward-order
            // but the code is more readable and explicit if we do this.
            if self.options.extra_comments {
                self.emit_mark("Private model interfaces");
            }

            self.for_each_named_type(
                BlankLinePosition::LeadingAndInterposing,
                |r, _, class_name, _| {
                    r.emit_private_class_interface(class_name);
                    Ok(())
                },
                |_, _, _, _| Ok(()),
                |_, _, _, _| Ok(()),
            )?;

            if self.have_enums()? {
                if self.options.extra_comments {
                    self.ensure_blank_line();
                    self.emit_extra_comments(&[
                        "These enum-like reference types are needed so that enum",
                        "values can be contained by NSArray and NSDictionary.",
                    ]);
                    self.ensure_blank_line();
                }

                self.for_each_enum(BlankLinePosition::LeadingAndInterposing, |r, t, n, _| {
                    r.emit_pseudo_enum_implementation(t, n)
                })?;
            }

            self.ensure_blank_line();
            self.emit_map_function()?;
            self.ensure_blank_line();

            self.emit_mark("JSON serialization");
            self.for_each_top_level(BlankLinePosition::LeadingAndInterposing, |r, t, n, _| {
                r.emit_top_level_functions(t, n)
            })?;
        }

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.emit_class_implementation(c, class_name),
            |_, _, _, _| Ok(()),
            |_, _, _, _| Ok(()),
        )?;

        if !self.options.just_types {
            self.ensure_blank_line();
            self.emit_line("NS_ASSUME_NONNULL_END");
        }

        self.finish_current_file()
    }

    /// The `needsMap(t)` function of the `needsMap` getter, memoized in
    /// `memo`: `Some(result)` once decided, `None` while `t`'s properties
    /// are being visited.
    ///
    /// TypeScript recomputes every type each time, which gives the same
    /// results (`needsMap` is deterministic), except that a type reached
    /// again from its own properties recurses through the same properties
    /// forever until V8 overflows its stack; that is reported here as soon
    /// as the type is re-entered.
    fn type_needs_map(
        &self,
        t: TypeRef,
        memo: &mut HashMap<TypeRef, Option<bool>>,
    ) -> Result<bool> {
        guard(|| {
            match memo.get(&t) {
                Some(Some(result)) => return Ok(*result),
                // Endless on a cycle of classes (V8 overflows its stack).
                Some(None) => return Err(stack_overflow()),
                None => {}
            }
            let ty = self.type_graph().type_at(t)?;
            let result = match ty.kind() {
                TypeKind::Map | TypeKind::Array => true,
                TypeKind::Class => {
                    memo.insert(t, None);
                    let mut result = false;
                    for p in ty.properties()?.values() {
                        if self.type_needs_map(p.type_ref, memo)? {
                            result = true;
                            break;
                        }
                    }
                    result
                }
                _ => false,
            };
            memo.insert(t, Some(result));
            Ok(result)
        })
    }

    /// `needsMap`: whether any type in the graph is (or has a property
    /// that needs) a map or an array.
    fn needs_map(&self) -> Result<bool> {
        // TODO this isn't complete (needs union support, for example)
        let mut memo = HashMap::new();
        for t in self.type_graph().all_types_unordered() {
            if self.type_needs_map(t, &mut memo)? {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// `emitMapFunction()`.
    fn emit_map_function(&mut self) -> Result<()> {
        if self.needs_map()? {
            self.emit_multiline(MAP_FUNCTION)?;
        }
        Ok(())
    }
}

impl<'a> ConvenienceRenderer<'a> for ObjectiveCRenderer<'a> {
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
        _c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: FORBIDDEN_PROPERTY_NAMES.iter().map(|&n| n.into()).collect(),
            include_global_forbidden: true,
        })
    }

    fn forbidden_for_enum_cases(
        &mut self,
        _e: TypeRef,
        _enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: FORBIDDEN_FOR_ENUM_CASES.iter().map(|&n| n.into()).collect(),
            include_global_forbidden: true,
        })
    }

    fn make_named_type_namer(&mut self) -> Namer {
        let class_prefix = self.class_prefix.clone();
        fun_prefix_namer("types", move |raw_name| {
            type_name_style(&class_prefix, raw_name)
        })
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        let is_bool = self.type_graph().kind(p.type_ref)? == TypeKind::Bool;
        // TODO why is underscore being removed?
        Ok(Some(Namer::new(
            "properties",
            move |s| property_name_style(s, is_bool),
            ["_", "the", "one", "some", "another"],
            false,
        )))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        None
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(Namer::new(
            "enum-cases",
            |s| property_name_style(s, false),
            Vec::<String>::new(),
            false,
        ))
    }

    fn named_type_to_name_for_top_level(&self, t: TypeRef) -> Result<Option<TypeRef>> {
        Ok(Some(t))
    }

    fn comment_lines_splice_on_backslash(&self) -> bool {
        true
    }

    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        self.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some("/// ".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    /// `finishFile()`: TS `ObjectiveCRenderer` overrides `finishFile` without
    /// the parameter, so the file is always the current one.
    fn finish_file(&mut self, _filename: &str) -> Result<()> {
        self.finish_current_file()
    }

    fn emit_source_structure(&mut self, given_output_filename: &str) -> Result<()> {
        let file_mode = given_output_filename != "stdout";
        let proposed_filename = if file_mode {
            given_output_filename.to_owned()
        } else {
            // We don't have a filename, so we use a top-level name
            let first_top_level = *defined(self.top_levels().values().next())?;
            let name = self.name_for_named_type(first_top_level)?;
            format!("{}.m", self.sourcelike_to_string(&name.into())?)
        };

        let (filename, extension) = split_extension(&proposed_filename);

        if self.options.features.interface {
            self.emit_interface_file(&filename)?;
        }

        if self.options.features.implementation {
            self.emit_implementation_file(&filename, &extension)?;
        }
        Ok(())
    }
}

/// The `map` helper of `emitMapFunction`.
const MAP_FUNCTION: &str = r#"static id map(id collection, id (^f)(id value)) {
	id result = nil;
	if ([collection isKindOfClass:NSArray.class]) {
			result = [NSMutableArray arrayWithCapacity:[(NSArray *)collection count]];
			for (id x in collection) [result addObject:NSNullify(f(x))];
	} else if ([collection isKindOfClass:NSDictionary.class]) {
			result = [NSMutableDictionary dictionaryWithCapacity:[(NSDictionary *)collection count]];
			for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
	}
	return result;
}"#;
