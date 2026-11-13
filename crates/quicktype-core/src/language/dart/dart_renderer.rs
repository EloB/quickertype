//! Port of `packages/quicktype-core/src/language/Dart/DartRenderer.ts`.
//!
//! Renders Dart classes with `fromJson`/`toJson` (or `fromMap`/`toMap`)
//! coders, enums with an `EnumValues` map, and the json_serializable,
//! freezed and Hive annotation variants. Unions other than `T | null` are
//! `dynamic`.

use quicktype_js_compat::number;

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::messages::{JsErrorName, QuickTypeError};
use crate::renderer_options::RendererOptions;
use crate::support::comments::CommentOptions;
use crate::support::fast_hash::HashMap;
use crate::support::recursion::guard;
use crate::support::strings::{decapitalize, snake_case};
use crate::support::support::defined;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    directly_reachable_single_named_type, is_nullable, nullable_from_union,
};

use super::constants::KEYWORDS;
use super::language::{
    CODERS_IN_CLASS, FINAL_PROPERTIES, GENERATE_COPY_WITH, JUST_TYPES, METHOD_NAMES_WITH_MAP,
    PART_NAME, REQUIRED_PROPERTIES, USE_FREEZED, USE_HIVE, USE_JSON_ANNOTATION,
};
use super::utils::{
    enum_case_naming_function, property_naming_function, string_escape, type_naming_function,
};

/// The option values of the Dart renderer (TS
/// `OptionValues<typeof dartOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct DartOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `codersInClass`.
    pub coders_in_class: bool,
    /// `methodNamesWithMap`.
    pub method_names_with_map: bool,
    /// `requiredProperties`.
    pub required_properties: bool,
    /// `finalProperties`.
    pub final_properties: bool,
    /// `generateCopyWith`.
    pub generate_copy_with: bool,
    /// `useFreezed`.
    pub use_freezed: bool,
    /// `useHive`.
    pub use_hive: bool,
    /// `useJsonAnnotation`.
    pub use_json_annotation: bool,
    /// `partName`.
    pub part_name: String,
}

impl DartOptions {
    /// `getOptionValues(dartOptions, values)`: the options in declaration
    /// order (Dart has no enum options, so this cannot fail).
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        Ok(DartOptions {
            just_types: JUST_TYPES.get_value(values),
            coders_in_class: CODERS_IN_CLASS.get_value(values),
            method_names_with_map: METHOD_NAMES_WITH_MAP.get_value(values),
            required_properties: REQUIRED_PROPERTIES.get_value(values),
            final_properties: FINAL_PROPERTIES.get_value(values),
            generate_copy_with: GENERATE_COPY_WITH.get_value(values),
            use_freezed: USE_FREEZED.get_value(values),
            use_hive: USE_HIVE.get_value(values),
            use_json_annotation: USE_JSON_ANNOTATION.get_value(values),
            part_name: PART_NAME.get_value(values).into_owned(),
        })
    }
}

/// `TopLevelDependents`: the names of a top-level's coder functions.
#[derive(Clone, Copy, Debug)]
struct TopLevelDependents {
    /// `decoder`.
    decoder: Name,
    /// `encoder`.
    encoder: Name,
}

/// `DartRenderer`.
pub struct DartRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: DartOptions,
    /// `typeNamingFunction` (a module-level singleton in TypeScript).
    type_naming_function: Namer,
    /// `propertyNamingFunction` (a module-level singleton in TypeScript).
    property_naming_function: Namer,
    /// `enumCaseNamingFunction` (a module-level singleton in TypeScript).
    enum_case_naming_function: Namer,
    /// `_needEnumValues`.
    need_enum_values: bool,
    /// `classCounter`.
    class_counter: u32,
    /// `classPropertyCounter`.
    class_property_counter: u32,
    /// `_topLevelDependents`.
    top_level_dependents: HashMap<Name, TopLevelDependents>,
    /// `_enumValues`.
    enum_values: HashMap<TypeRef, Name>,
}

impl std::fmt::Debug for DartRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("DartRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> DartRenderer<'a> {
    /// `new DartRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: DartOptions,
    ) -> Self {
        DartRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            type_naming_function: type_naming_function(),
            property_naming_function: property_naming_function(),
            enum_case_naming_function: enum_case_naming_function(),
            need_enum_values: false,
            class_counter: 0,
            class_property_counter: 0,
            top_level_dependents: HashMap::default(),
            enum_values: HashMap::default(),
        }
    }

    /// `toJson`: `toMap` or `toJson`.
    fn to_json(&self) -> &'static str {
        if self.options.method_names_with_map {
            "toMap"
        } else {
            "toJson"
        }
    }

    /// `fromJson`: `fromMap` or `fromJson`.
    #[allow(clippy::wrong_self_convention)] // named after TypeScript's `fromJson`
    fn from_json(&self) -> &'static str {
        if self.options.method_names_with_map {
            "fromMap"
        } else {
            "fromJson"
        }
    }

    /// A dependency name of `name`, styled as a property:
    /// `new DependencyName(propertyNamingFunction, name.order, lookup =>
    /// format(lookup(name)))`.
    fn property_dependency_name(&mut self, name: Name, format: fn(&str) -> String) -> Name {
        let order = self.naming().order(name);
        let namer = self.property_naming_function.clone();
        self.naming_mut()
            .dependency_name(Some(&namer), order, move |lookup| format(&lookup(name)))
    }

    /// `makeNamesForPropertyGetterAndSetter(c, className, p, jsonName,
    /// name)`.
    fn make_names_for_property_getter_and_setter(&mut self, name: Name) -> (Name, Name) {
        let getter_name = self.property_dependency_name(name, |n| format!("get_{n}"));
        let setter_name = self.property_dependency_name(name, |n| format!("set_{n}"));
        (getter_name, setter_name)
    }

    /// The decoder and encoder names of a top-level.
    fn top_level_dependents(&self, name: Name) -> Result<TopLevelDependents> {
        defined(self.top_level_dependents.get(&name).copied())
    }

    /// `emitFileHeader()`.
    fn emit_file_header(&mut self) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        }

        if self.options.just_types {
            return Ok(());
        }

        if !self.options.coders_in_class {
            self.emit_line("// To parse this JSON data, do");
            self.emit_line("//");
            self.for_each_top_level(BlankLinePosition::None, |r, _t, name, _| {
                let decoder = r.top_level_dependents(name)?.decoder;
                r.emit_line(sl![
                    "//     final ",
                    modify_source(decapitalize, name),
                    " = ",
                    decoder,
                    "(jsonString);"
                ]);
                Ok(())
            })?;
        }

        self.ensure_blank_line();

        if self.options.use_freezed {
            self.emit_line("import 'package:freezed_annotation/freezed_annotation.dart';");
        }

        if self.options.use_hive {
            self.emit_line("import 'package:hive/hive.dart';");
        }

        if self.options.use_json_annotation && !self.options.use_freezed {
            // The freezed annotatation import already provides the import for json_annotation
            self.emit_line("import 'package:json_annotation/json_annotation.dart';");
        }

        self.emit_line("import 'dart:convert';");
        if self.options.use_freezed || self.options.use_hive || self.options.use_json_annotation {
            self.ensure_blank_line();
            let option_name_is_empty = self.options.part_name.is_empty();
            // FIXME: This should use a `Name`, not `modifySource`
            let part_name = if option_name_is_empty {
                match self.top_levels().keys().next() {
                    Some(name) => name.clone(),
                    // Without top-levels TypeScript modifies `undefined`, and
                    // serializing that source fails. Nothing else in the
                    // render can fail before.
                    None => {
                        return Err(QuickTypeError::js_exception(
                            JsErrorName::TypeError,
                            "Cannot read properties of undefined (reading 'kind')",
                        ));
                    }
                }
            } else {
                self.options.part_name.clone()
            };
            let name = modify_source(snake_case, part_name);
            if self.options.use_freezed {
                self.emit_line(sl!["part '", name.clone(), ".freezed.dart';"]);
            }

            if !self.options.just_types {
                self.emit_line(sl!["part '", name, ".g.dart';"]);
            }
        }
        Ok(())
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

    /// `dartType(t, withIssues, forceNullable)`.
    fn dart_type(&self, t: TypeRef, with_issues: bool, force_nullable: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let nullable =
                force_nullable || (is_nullable(graph, t)? && !self.options.required_properties);
            let with_nullable = |s: Source| -> Source { if nullable { sl![s, "?"] } else { s } };
            Ok(match ty.kind() {
                TypeKind::Any => {
                    maybe_annotated(with_issues, any_type_issue_annotation(), "dynamic")
                }
                TypeKind::Null => {
                    maybe_annotated(with_issues, null_type_issue_annotation(), "dynamic")
                }
                TypeKind::Bool => with_nullable("bool".into()),
                TypeKind::Integer => with_nullable("int".into()),
                TypeKind::Double => with_nullable("double".into()),
                TypeKind::String => with_nullable("String".into()),
                TypeKind::Array => with_nullable(sl![
                    "List<",
                    self.dart_type(ty.items()?, with_issues, false)?,
                    ">"
                ]),
                TypeKind::Class | TypeKind::Enum => {
                    with_nullable(self.name_for_named_type(t)?.into())
                }
                TypeKind::Map => with_nullable(sl![
                    "Map<String, ",
                    self.dart_type(ty.map_values()?, with_issues, false)?,
                    ">"
                ]),
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    None => "dynamic".into(),
                    Some(maybe_nullable) => {
                        with_nullable(self.dart_type(maybe_nullable, with_issues, false)?)
                    }
                },
                TypeKind::DateTime | TypeKind::Date => with_nullable("DateTime".into()),
                kind if kind.is_transformed_string_type_kind() => with_nullable("String".into()),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `mapList(isNullable, itemType, list, mapper, constrained)`.
    fn map_list(
        &self,
        is_nullable: bool,
        item_type: Source,
        list: Source,
        mapper: Source,
        constrained: Option<TypeRef>,
    ) -> Result<Source> {
        let (min, max) = match constrained {
            None => (None, None),
            Some(t) => {
                min_max_items_for_type(self.type_graph(), t)?.map_or((None, None), |c| (c.0, c.1))
            }
        };
        let checked = |value: Source| -> Source {
            if min.is_none() && max.is_none() {
                return value;
            }
            let conditions: Vec<String> = [
                min.map(|min| format!("x.length < {}", number::to_string(min))),
                max.map(|max| format!("x.length > {}", number::to_string(max))),
            ]
            .into_iter()
            .flatten()
            .collect();
            sl![
                "(() { final x = ",
                value,
                "; if (",
                conditions.join(" || "),
                ") throw FormatException('Invalid array length'); return x; })()"
            ]
        };
        if is_nullable && !self.options.required_properties {
            return Ok(sl![
                list.clone(),
                " == null ? null : ",
                checked(sl![
                    "List<",
                    item_type,
                    ">.from(",
                    list,
                    "!.map((x) => ",
                    mapper,
                    "))"
                ])
            ]);
        }

        Ok(checked(sl![
            "List<",
            item_type,
            ">.from(",
            list,
            ".map((x) => ",
            mapper,
            "))"
        ]))
    }

    /// `mapMap(isNullable, valueType, map, valueMapper)`.
    fn map_map(
        &self,
        is_nullable: bool,
        value_type: Source,
        map: Source,
        value_mapper: Source,
    ) -> Source {
        if is_nullable && !self.options.required_properties {
            return sl![
                map.clone(),
                " == null ? null : ",
                "Map.from(",
                map,
                "!).map((k, v) => MapEntry<String, ",
                value_type,
                ">(k, ",
                value_mapper,
                "))"
            ];
        }

        sl![
            "Map.from(",
            map,
            ").map((k, v) => MapEntry<String, ",
            value_type,
            ">(k, ",
            value_mapper,
            "))"
        ]
    }

    /// `mapClass(isNullable, classType, dynamic)`.
    fn map_class(&self, is_nullable: bool, class_type: TypeRef, dynamic: Source) -> Result<Source> {
        let class_name = self.name_for_named_type(class_type)?;
        if is_nullable && !self.options.required_properties {
            return Ok(sl![
                dynamic.clone(),
                " == null ? null : ",
                class_name,
                ".",
                self.from_json(),
                "(",
                dynamic,
                ")"
            ]);
        }

        Ok(sl![class_name, ".", self.from_json(), "(", dynamic, ")"])
    }

    /// The enum's `<name>_values` map.
    fn enum_values_name(&self, e: TypeRef) -> Result<Name> {
        defined(self.enum_values.get(&e).copied())
    }

    // FIXME: refactor this
    // If the first time is the unionType type, after nullableFromUnion conversion,
    // the isNullable property will become false, which is obviously wrong,
    // so add isNullable property
    /// `fromDynamicExpression(isNullable, t, ...dynamic)` (`nullable` is
    /// TS `isNullable`).
    #[allow(clippy::wrong_self_convention)] // named after TypeScript's `fromDynamicExpression`
    fn from_dynamic_expression(
        &self,
        nullable: bool,
        t: TypeRef,
        dynamic: Source,
    ) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let null_check = |value: &Source| -> Source {
                if nullable {
                    sl![value.clone(), " == null ? null : "]
                } else {
                    sl![]
                }
            };
            let validate_string = |value: Source| -> Result<Source> {
                let Some(c) = min_max_length_for_type(graph, t)? else {
                    return Ok(value);
                };
                if c.0.is_none() && c.1.is_none() {
                    return Ok(value);
                }
                Ok(sl![
                    null_check(&value),
                    "((x) => ",
                    c.0.map_or("true".to_owned(), |min| format!(
                        "x.runes.length >= {}",
                        number::to_string(min)
                    )),
                    " && ",
                    c.1.map_or("true".to_owned(), |max| format!(
                        "x.runes.length <= {}",
                        number::to_string(max)
                    )),
                    " ? x : throw FormatException(\"Expected bounded string\"))(",
                    value,
                    ")"
                ])
            };
            let validate_pattern = |value: Source| -> Result<Source> {
                let Some(pattern) = pattern_for_type(graph, t)? else {
                    return Ok(value);
                };
                let checked = sl![
                    "((x) => RegExp(\"",
                    string_escape(&pattern),
                    "\").hasMatch(x) ? x : throw FormatException(\"Expected matching string\"))(",
                    value.clone(),
                    ")"
                ];
                Ok(if nullable {
                    sl![value, " == null ? null : ", checked]
                } else {
                    checked
                })
            };
            let validate_number = |value: Source| -> Result<Source> {
                let Some(c) = min_max_value_for_type(graph, t)? else {
                    return Ok(value);
                };
                if c.0.is_none() && c.1.is_none() {
                    return Ok(value);
                }
                Ok(sl![
                    null_check(&value),
                    "((x) => ",
                    c.0.map_or("true".to_owned(), |min| format!(
                        "x >= {}",
                        number::to_string(min)
                    )),
                    " && ",
                    c.1.map_or("true".to_owned(), |max| format!(
                        "x <= {}",
                        number::to_string(max)
                    )),
                    " ? x : throw FormatException(\"Expected bounded number\"))(",
                    value,
                    ")"
                ])
            };
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any | TypeKind::Null | TypeKind::Bool => dynamic,
                TypeKind::Integer => validate_number(dynamic)?,
                TypeKind::Double => validate_number(sl![dynamic, "?.toDouble()"])?,
                TypeKind::String => validate_pattern(validate_string(dynamic)?)?,
                TypeKind::Array => {
                    let items = ty.items()?;
                    self.map_list(
                        nullable || is_nullable(graph, t)?,
                        self.dart_type(items, false, false)?,
                        dynamic,
                        self.from_dynamic_expression(
                            is_nullable(graph, items)?,
                            items,
                            "x".into(),
                        )?,
                        Some(t),
                    )?
                }
                TypeKind::Class => {
                    self.map_class(nullable || is_nullable(graph, t)?, t, dynamic)?
                }
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    self.map_map(
                        is_nullable(graph, t)? || nullable,
                        self.dart_type(values, false, false)?,
                        dynamic,
                        self.from_dynamic_expression(
                            is_nullable(graph, values)?,
                            values,
                            "v".into(),
                        )?,
                    )
                }
                TypeKind::Enum => {
                    let value = sl![self.enum_values_name(t)?, ".map[", dynamic.clone(), "]!"];
                    if nullable && !self.options.required_properties {
                        sl![dynamic, " == null ? null : ", value]
                    } else {
                        value
                    }
                }
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    None => dynamic,
                    Some(maybe_nullable) => self.from_dynamic_expression(
                        is_nullable(graph, t)?,
                        maybe_nullable,
                        dynamic,
                    )?,
                },
                TypeKind::Uuid => sl![
                    null_check(&dynamic),
                    "((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x)",
                    " ? x : throw FormatException('Invalid UUID'))(",
                    dynamic,
                    ")"
                ],
                TypeKind::DateTime | TypeKind::Date => {
                    if (is_nullable(graph, t)? || nullable) && !self.options.required_properties {
                        sl![
                            dynamic.clone(),
                            " == null ? null : ",
                            "DateTime.parse(",
                            dynamic,
                            ")"
                        ]
                    } else {
                        sl!["DateTime.parse(", dynamic, ")"]
                    }
                }
                kind if kind.is_transformed_string_type_kind() => dynamic,
                kind => return match_type_unsupported(kind),
            })
        })
    }

    // FIXME: refactor this
    // If the first time is the unionType type, after nullableFromUnion conversion,
    // the isNullable property will become false, which is obviously wrong,
    // so add isNullable property
    /// `toDynamicExpression(isNullable, t, ...dynamic)` (`nullable` is TS
    /// `isNullable`).
    fn to_dynamic_expression(&self, nullable: bool, t: TypeRef, dynamic: Source) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let nullable_unless_required = |t: TypeRef| -> Result<bool> {
                Ok(!self.options.required_properties && (is_nullable(graph, t)? || nullable))
            };
            Ok(match ty.kind() {
                TypeKind::Any
                | TypeKind::Null
                | TypeKind::Bool
                | TypeKind::Integer
                | TypeKind::Double
                | TypeKind::String => dynamic,
                TypeKind::Array => {
                    let items = ty.items()?;
                    self.map_list(
                        is_nullable(graph, t)? || nullable,
                        "dynamic".into(),
                        dynamic,
                        self.to_dynamic_expression(is_nullable(graph, items)?, items, "x".into())?,
                        None,
                    )?
                }
                TypeKind::Class => {
                    if nullable_unless_required(t)? {
                        sl![dynamic, "?.", self.to_json(), "()"]
                    } else {
                        sl![dynamic, ".", self.to_json(), "()"]
                    }
                }
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    self.map_map(
                        is_nullable(graph, t)? || nullable,
                        "dynamic".into(),
                        dynamic,
                        self.to_dynamic_expression(
                            is_nullable(graph, values)?,
                            values,
                            "v".into(),
                        )?,
                    )
                }
                TypeKind::Enum => sl![self.enum_values_name(t)?, ".reverse[", dynamic, "]"],
                TypeKind::Union => match nullable_from_union(graph, t)? {
                    None => dynamic,
                    Some(maybe_nullable) => {
                        self.to_dynamic_expression(is_nullable(graph, t)?, maybe_nullable, dynamic)?
                    }
                },
                TypeKind::DateTime => {
                    if nullable_unless_required(t)? {
                        sl![dynamic, "?.toIso8601String()"]
                    } else {
                        sl![dynamic, ".toIso8601String()"]
                    }
                }
                TypeKind::Date => {
                    if nullable_unless_required(t)? {
                        sl![
                            dynamic.clone(),
                            " == null ? null : \"${",
                            dynamic.clone(),
                            "!.year.toString().padLeft(4, '0')",
                            "}-${",
                            dynamic.clone(),
                            "!.month.toString().padLeft(2, '0')}-${",
                            dynamic,
                            "!.day.toString().padLeft(2, '0')}\""
                        ]
                    } else {
                        sl![
                            "\"${",
                            dynamic.clone(),
                            ".year.toString().padLeft(4, '0')",
                            "}-${",
                            dynamic.clone(),
                            ".month.toString().padLeft(2, '0')}-${",
                            dynamic,
                            ".day.toString().padLeft(2, '0')}\""
                        ]
                    }
                }
                kind if kind.is_transformed_string_type_kind() => dynamic,
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `_emitEmptyConstructor(className)`.
    fn emit_empty_constructor(&mut self, class_name: Name) {
        self.emit_line(sl![class_name, "();"]);
    }

    /// Whether a constructor or freezed factory parameter is `required`.
    fn is_required(&self, prop: &ClassProperty) -> Result<bool> {
        Ok(self.options.required_properties
            || !is_nullable(self.type_graph(), prop.type_ref)?
            || !prop.is_optional)
    }

    /// `_emitConstructor(c, className)`.
    fn emit_constructor(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.emit_line(sl![class_name, "({"]);
        self.indent(|r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, prop, _| {
                let required = r.is_required(&prop)?;
                r.emit_line(sl![
                    if required { "required " } else { "" },
                    "this.",
                    name,
                    ","
                ]);
                Ok(())
            })
        })?;
        self.emit_line("});");
        self.ensure_blank_line();
        Ok(())
    }

    /// `_emitVariables(c)`.
    fn emit_variables(&mut self, c: TypeRef) -> Result<()> {
        self.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
            let description = r.description_for_class_property(c, json_name)?;
            if description.is_some() {
                r.emit_description(description)?;
            }

            if r.options.use_hive {
                r.class_property_counter += 1;
                let counter = r.class_property_counter;
                r.emit_line(format!("@HiveField({counter})"));
            }

            if r.options.use_json_annotation {
                r.class_property_counter += 1;
                r.emit_line(format!("@JsonKey(name: \"{}\")", string_escape(json_name)));
            }

            let dart_type = r.dart_type(p.type_ref, true, false)?;
            r.emit_line(sl![
                if r.options.final_properties {
                    "final "
                } else {
                    ""
                },
                dart_type,
                " ",
                name,
                ";"
            ]);
            Ok(())
        })
    }

    /// `_emitCopyConstructor(c, className)`.
    fn emit_copy_constructor(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.ensure_blank_line();
        self.emit_line(sl![class_name, " copyWith({"]);
        self.indent(|r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, _| {
                let dart_type = r.dart_type(p.type_ref, true, true)?;
                r.emit_line(sl![dart_type, " ", name, ","]);
                Ok(())
            })
        })?;
        self.emit_line("}) => ");
        self.indent(|r| {
            r.emit_line(sl![class_name, "("]);
            r.indent(|r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, _, _| {
                    r.emit_line(sl![name, ": ", name, " ?? ", "this.", name, ","]);
                    Ok(())
                })
            })?;
            r.emit_line(");");
            Ok(())
        })
    }

    /// `_emitStringJsonEncoderDecoder(className)`.
    fn emit_string_json_encoder_decoder(&mut self, class_name: Name) {
        self.ensure_blank_line();
        self.emit_line(sl![
            "factory ",
            class_name,
            ".from",
            if self.options.method_names_with_map {
                "Json"
            } else {
                "RawJson"
            },
            "(String str) => ",
            class_name,
            ".",
            self.from_json(),
            "(json.decode(str));"
        ]);

        self.ensure_blank_line();
        self.emit_line(sl![
            "String ",
            if self.options.method_names_with_map {
                "toJson() => "
            } else {
                "toRawJson() => "
            },
            "json.encode(",
            self.to_json(),
            "());"
        ]);
    }

    /// `_emitMapEncoderDecoder(c, className)`.
    fn emit_map_encoder_decoder(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.ensure_blank_line();
        self.emit_line(sl![
            "factory ",
            class_name,
            ".",
            self.from_json(),
            "(Map<String, dynamic> json) => ",
            class_name,
            "("
        ]);
        self.indent(|r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, property, _| {
                let key = string_escape(json_name);
                let value = format!("json[\"{key}\"]");
                let nullable = is_nullable(r.type_graph(), property.type_ref)?;
                let input = if !property.is_optional && nullable {
                    format!(
                        "(json.containsKey(\"{key}\") ? {value} : throw FormatException('Missing required property'))"
                    )
                } else {
                    value
                };
                let expression = r.from_dynamic_expression(nullable, property.type_ref, input.into())?;
                r.emit_line(sl![name, ": ", expression, ","]);
                Ok(())
            })
        })?;
        self.emit_line(");");

        self.ensure_blank_line();

        self.emit_line(sl!["Map<String, dynamic> ", self.to_json(), "() => {"]);
        self.indent(|r| {
            r.for_each_class_property(
                c,
                BlankLinePosition::None,
                |r, name, json_name, property, _| {
                    let nullable = is_nullable(r.type_graph(), property.type_ref)?;
                    let expression =
                        r.to_dynamic_expression(nullable, property.type_ref, name.into())?;
                    r.emit_line(sl!["\"", string_escape(json_name), "\": ", expression, ","]);
                    Ok(())
                },
            )
        })?;
        self.emit_line("};");
        Ok(())
    }

    /// `emitClassDefinition(c, className)`.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        if self.options.use_hive {
            self.class_counter += 1;
            let counter = self.class_counter;
            self.emit_line(format!("@HiveType(typeId: {counter})"));
            self.class_property_counter = 0;
        }

        if self.options.use_json_annotation {
            self.emit_line("@JsonSerializable()");
        }

        self.emit_block(sl!["class ", class_name], |r| {
            if r.type_graph().type_at(c)?.properties()?.is_empty() {
                r.emit_empty_constructor(class_name);
            } else {
                r.emit_variables(c)?;
                r.ensure_blank_line();
                r.emit_constructor(c, class_name)?;
            }

            if r.options.generate_copy_with {
                r.emit_copy_constructor(c, class_name)?;
            }

            if r.options.use_json_annotation {
                r.ensure_blank_line();
                // factory PublicAnswer.fromJson(Map<String, dynamic> json) => _$PublicAnswerFromJson(json);
                r.emit_line(sl![
                    "factory ",
                    class_name,
                    ".fromJson(Map<String, dynamic> json) => ",
                    "_$",
                    class_name,
                    "FromJson(json);"
                ]);

                r.ensure_blank_line();
                // Map<String, dynamic> toJson() => _$PublicAnswerToJson(this);
                r.emit_line(sl![
                    "Map<String, dynamic> toJson() => ",
                    "_$",
                    class_name,
                    "ToJson(this);"
                ]);
            } else {
                if r.options.just_types {
                    return Ok(());
                }

                if r.options.coders_in_class {
                    r.emit_string_json_encoder_decoder(class_name);
                }

                r.emit_map_encoder_decoder(c, class_name)?;
            }
            Ok(())
        })
    }

    /// `emitFreezedClassDefinition(c, className)`.
    fn emit_freezed_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;

        self.emit_line("@freezed");
        self.emit_block(
            sl!["abstract class ", class_name, " with _$", class_name],
            |r| {
                if r.type_graph().type_at(c)?.properties()?.is_empty() {
                    r.emit_line(sl!["const factory ", class_name, "() = _", class_name, ";"]);
                } else {
                    r.emit_line(sl!["const factory ", class_name, "({"]);
                    r.indent(|r| {
                        r.for_each_class_property(
                            c,
                            BlankLinePosition::None,
                            |r, name, json_name, prop, _| {
                                let description = r.description_for_class_property(c, json_name)?;
                                if description.is_some() {
                                    r.emit_description(description)?;
                                }

                                let required = r.is_required(&prop)?;
                                r.class_property_counter += 1;
                                r.emit_line(format!(
                                    "@JsonKey(name: \"{}\")",
                                    string_escape(json_name)
                                ));

                                let dart_type = r.dart_type(prop.type_ref, true, false)?;
                                r.emit_line(sl![
                                    if required { "required " } else { "" },
                                    dart_type,
                                    " ",
                                    name,
                                    ","
                                ]);
                                Ok(())
                            },
                        )
                    })?;
                    r.emit_line(sl!["}) = _", class_name, ";"]);
                }

                if r.options.just_types {
                    return Ok(());
                }

                r.ensure_blank_line();
                // factory PublicAnswer.fromJson(Map<String, dynamic> json) => _$PublicAnswerFromJson(json);
                r.emit_line(sl![
                    "factory ",
                    class_name,
                    ".fromJson(Map<String, dynamic> json) => ",
                    "_$",
                    class_name,
                    "FromJson(json);"
                ]);
                Ok(())
            },
        )
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl!["enum ", enum_name, " {"]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, pos| {
                let comma = enum_case_comma(pos);
                if r.options.use_json_annotation {
                    r.emit_line(sl!["@JsonValue(\"", string_escape(json_name), "\")"]);
                }

                r.emit_line(sl![name, comma]);
                Ok(())
            })
        })?;
        self.emit_line("}");

        if self.options.just_types {
            return Ok(());
        }

        self.ensure_blank_line();
        let enum_values = self.enum_values_name(e)?;
        self.emit_line(sl!["final ", enum_values, " = EnumValues({"]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, pos| {
                let comma = enum_case_comma(pos);
                r.emit_line(sl![
                    "\"",
                    string_escape(json_name),
                    "\": ",
                    enum_name,
                    ".",
                    name,
                    comma
                ]);
                Ok(())
            })
        })?;
        self.emit_line("});");

        self.need_enum_values = true;
        Ok(())
    }

    /// `emitEnumValues()`.
    fn emit_enum_values(&mut self) -> Result<()> {
        self.ensure_blank_line();
        self.emit_multiline(ENUM_VALUES)
    }

    /// `_emitTopLvlEncoderDecoder()`.
    fn emit_top_level_encoder_decoder(&mut self) -> Result<()> {
        self.for_each_top_level(BlankLinePosition::LeadingAndInterposing, |r, t, name, _| {
            let TopLevelDependents { encoder, decoder } = r.top_level_dependents(name)?;
            let graph = r.type_graph();

            let dart_type = r.dart_type(t, false, false)?;
            let expression =
                r.from_dynamic_expression(is_nullable(graph, t)?, t, "json.decode(str)".into())?;
            r.emit_line(sl![
                dart_type,
                " ",
                decoder,
                "(String str) => ",
                expression,
                ";"
            ]);

            r.ensure_blank_line();

            let dart_type = r.dart_type(t, false, false)?;
            let expression = r.to_dynamic_expression(is_nullable(graph, t)?, t, "data".into())?;
            r.emit_line(sl![
                "String ",
                encoder,
                "(",
                dart_type,
                " data) => json.encode(",
                expression,
                ");"
            ]);

            // this.emitBlock(["String ", encoder, "(", this.dartType(t), " data)"], () => {
            //     this.emitJsonEncoderBlock(t);
            // });
            Ok(())
        })?;
        Ok(())
    }
}

/// The comma after an enum case: `","` for the first and middle cases,
/// TypeScript's `[]` (nothing) otherwise.
fn enum_case_comma(position: ForEachPosition) -> Source {
    match position {
        ForEachPosition::First | ForEachPosition::Middle => ",".into(),
        _ => sl![],
    }
}

impl<'a> ConvenienceRenderer<'a> for DartRenderer<'a> {
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
        let mut names = vec![
            "hashCode".into(),
            "runtimeType".into(),
            "toString".into(),
            "noSuchMethod".into(),
        ];
        if self.options.generate_copy_with {
            names.push("copyWith".into());
        }
        Ok(ForbiddenWordsInfo {
            names,
            include_global_forbidden: true,
        })
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.type_naming_function.clone()
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.property_naming_function.clone()))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.property_naming_function.clone())
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.enum_case_naming_function.clone())
    }

    fn union_needs_name(&self, u: TypeRef) -> Result<bool> {
        Ok(nullable_from_union(self.type_graph(), u)?.is_none())
    }

    fn named_type_to_name_for_top_level(&self, t: TypeRef) -> Result<Option<TypeRef>> {
        // If the top-level type doesn't contain any classes or unions
        // we have to define a class just for the `FromJson` method, in
        // emitFromJsonForTopLevel.
        directly_reachable_single_named_type(self.type_graph(), t)
    }

    fn make_top_level_dependency_names(&mut self, _t: TypeRef, name: Name) -> Result<Vec<Name>> {
        let encoder = self.property_dependency_name(name, |n| format!("{n}_toJson"));
        let decoder = self.property_dependency_name(name, |n| format!("{n}_fromJson"));
        self.top_level_dependents
            .insert(name, TopLevelDependents { decoder, encoder });
        Ok(vec![encoder, decoder])
    }

    fn make_property_dependency_names(
        &mut self,
        _c: TypeRef,
        _class_name: Name,
        _p: &ClassProperty,
        _json_name: &str,
        name: Name,
    ) -> Result<Vec<Name>> {
        // TS also stores the names in `_gettersAndSettersForPropertyName`,
        // which nothing reads.
        let (getter_name, setter_name) = self.make_names_for_property_getter_and_setter(name);
        Ok(vec![getter_name, setter_name])
    }

    fn make_named_type_dependency_names(&mut self, t: TypeRef, name: Name) -> Result<Vec<Name>> {
        if self.type_graph().kind(t)? != TypeKind::Enum {
            return Ok(Vec::new());
        }
        let enum_value = self.property_dependency_name(name, |n| format!("{n}_values"));
        self.enum_values.insert(t, enum_value);
        Ok(vec![enum_value])
    }

    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        self.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some("///".to_owned()),
                before_comment: Some(String::new()),
                ..CommentOptions::default()
            },
        )
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        self.emit_file_header()?;

        if !self.options.just_types && !self.options.coders_in_class {
            self.emit_top_level_encoder_decoder()?;
        }

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| {
                if r.options.use_freezed {
                    r.emit_freezed_class_definition(c, n)
                } else {
                    r.emit_class_definition(c, n)
                }
            },
            |r, e, n, _| r.emit_enum_definition(e, n),
            |_, _, _, _| {
                // We don't support this yet.
                Ok(())
            },
        )?;

        if self.need_enum_values {
            self.emit_enum_values()?;
        }
        Ok(())
    }
}

/// The `EnumValues` class of `emitEnumValues`.
const ENUM_VALUES: &str = r#"class EnumValues<T> {
	Map<String, T> map;
	late Map<T, String> reverseMap;

	EnumValues(this.map);

	Map<T, String> get reverse {
			reverseMap = map.map((k, v) => MapEntry(v, k));
			return reverseMap;
	}
}"#;
