//! Port of `packages/quicktype-core/src/language/CSharp/CSharpRenderer.ts`.
//!
//! The base of the two C# renderers (Newtonsoft and System.Text.Json): type
//! expressions, classes or records, enums, union structs, the namespace and
//! the usings. TypeScript's class hierarchy is ported as in
//! `docs/RENDERERS.md`: the base class's fields are [`CSharpState`], its
//! methods the [`CSharpRenderer`] family trait, and its hook overrides the
//! [`c_sharp_hooks`] module, which the leaves' hooks modules build on.

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::prelude::*;
use crate::renderer_options::{EnumValue, PrototypeMember, RendererOptions};
use crate::support::recursion::guard;
use crate::support::support::{assert, defined};
use crate::transformers::{
    Transformation, downcast_transformation, follow_target_type, transformation_for_type,
};
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_utils::{
    NullRemovalSort, find_member, nullable_from_union, remove_null_from_union,
};

use super::language::{
    BASECLASS, CHECK_REQUIRED, DENSE, FEATURES, FRAMEWORK, JUST_TYPES, KEEP_PROPERTY_NAME,
    NAMESPACE, TYPE_FOR_ANY, USE_DECIMAL, USE_LIST, USE_RECORDS, VERSION, VIRTUAL,
};
use super::utils::{AccessModifier, cs_type_for_transformed_string_type, is_value_type};

/// TS `cSharpOptions.framework` values.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Framework {
    /// `"NewtonSoft"`.
    NewtonSoft,
    /// `"SystemTextJson"`.
    SystemTextJson,
    /// An `Object.prototype` member: `makeRenderer`'s `switch` falls
    /// through to `assertNever`.
    Other(PrototypeMember),
}

/// TS `OutputFeatures` (plus `namespaces`): what `--features` turns on.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct OutputFeatures {
    /// Emit a namespace.
    pub namespaces: bool,
    /// Emit the `FromJson`/`ToJson` helpers and the converters.
    pub helpers: bool,
    /// Emit the JSON attributes on properties.
    pub attributes: bool,
}

/// The option values of the C# renderers (TS `OptionValues<typeof
/// cSharpOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct CSharpOptions {
    /// `framework`.
    pub framework: Framework,
    /// `useList`: `List<T>` instead of `T[]`.
    pub use_list: bool,
    /// `dense`.
    pub dense: bool,
    /// `namespace`.
    pub namespace: String,
    /// `version`: 5, 6 or 8; `None` for an `Object.prototype` member, which
    /// compares as `NaN` (neither `< 8` nor `>= 8`, and not `=== 5`).
    pub version: Option<u32>,
    /// `virtual`.
    pub virtual_: bool,
    /// `useRecords`.
    pub use_records: bool,
    /// `typeForAny`: `"object"` or `"dynamic"` (each value is its own
    /// name). An `Object.prototype` member is emitted as it is, so
    /// serializing it fails (see [`Source::Unexpected`]).
    pub type_for_any: EnumValue,
    /// `useDecimal`.
    pub use_decimal: bool,
    /// `features`.
    pub features: OutputFeatures,
    /// `justTypes`.
    pub just_types: bool,
    /// `baseclass`: `Some(Declared("EntityData"))`, `None` for `"Object"`
    /// (whose value is `undefined`), or an `Object.prototype` member, which
    /// is emitted as the base class (failing at serialization, see
    /// [`Source::Unexpected`]) and forbids no name.
    pub baseclass: Option<EnumValue>,
    /// `checkRequired`.
    pub check_required: bool,
    /// `keepPropertyName`.
    pub keep_property_name: bool,
}

impl CSharpOptions {
    /// `getOptionValues(cSharpOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        // The boolean-valued options are TS truthiness (an `Object.prototype`
        // member acts as `true`), the record-valued `features` has none of
        // the record's fields then, and the string-valued ones equal none of
        // their values.
        let framework = match FRAMEWORK.get_enum_value(values)? {
            EnumValue::Declared("NewtonSoft") => Framework::NewtonSoft,
            EnumValue::Declared(_) => Framework::SystemTextJson,
            EnumValue::Prototype(member) => Framework::Other(member),
        };
        let use_list = USE_LIST.get_enum_value(values)?.flag("list");
        let dense = DENSE.get_enum_value(values)?.flag("dense");
        let namespace = NAMESPACE.get_value(values).into_owned();
        let version = match VERSION.get_enum_value(values)? {
            EnumValue::Declared("5") => Some(5),
            EnumValue::Declared("6") => Some(6),
            EnumValue::Declared(_) => Some(8),
            EnumValue::Prototype(_) => None,
        };
        let virtual_ = VIRTUAL.get_value(values);
        let use_records = USE_RECORDS.get_value(values);
        let type_for_any = TYPE_FOR_ANY.get_enum_value(values)?;
        let use_decimal = USE_DECIMAL.get_enum_value(values)?.flag("decimal");
        let features = match FEATURES.get_enum_value(values)? {
            EnumValue::Declared("attributes-only") => OutputFeatures {
                namespaces: true,
                helpers: false,
                attributes: true,
            },
            EnumValue::Declared(_) => OutputFeatures {
                namespaces: true,
                helpers: true,
                attributes: true,
            },
            EnumValue::Prototype(_) => OutputFeatures {
                namespaces: false,
                helpers: false,
                attributes: false,
            },
        };
        let just_types = JUST_TYPES.get_value(values);
        let baseclass = match BASECLASS.get_enum_value(values)? {
            EnumValue::Declared("Object") => None,
            value => Some(value),
        };
        Ok(CSharpOptions {
            framework,
            use_list,
            dense,
            namespace,
            version,
            virtual_,
            use_records,
            type_for_any,
            use_decimal,
            features,
            just_types,
            baseclass,
            check_required: CHECK_REQUIRED.get_value(values),
            keep_property_name: KEEP_PROPERTY_NAME.get_value(values),
        })
    }
}

/// The `follow` argument of `csType`/`nullableCSType`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Follow {
    /// `followTargetType`: the type a transformation produces.
    Target,
    /// `noFollow`: the type itself.
    None,
}

/// The fields of TS `CSharpRenderer`.
pub struct CSharpState {
    /// `_csOptions`.
    pub options: CSharpOptions,
    /// `namingFunction` (a module-level singleton in TypeScript; the
    /// subclasses name converters and enum extensions with it too).
    pub naming_function: Namer,
    /// `namingFunctionKeep` (a module-level singleton in TypeScript).
    pub naming_function_keep: Namer,
}

impl std::fmt::Debug for CSharpState {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CSharpState")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl CSharpState {
    /// The state `new CSharpRenderer(..., csOptions)` sets up.
    pub fn new(options: CSharpOptions) -> Self {
        CSharpState {
            options,
            naming_function: super::utils::naming_function(),
            naming_function_keep: super::utils::naming_function_keep(),
        }
    }
}

/// `objectMemberNames`: members of `object` that properties must not
/// shadow.
const OBJECT_MEMBER_NAMES: [&str; 7] = [
    "ToString",
    "GetHashCode",
    "Finalize",
    "Equals",
    "GetType",
    "MemberwiseClone",
    "ReferenceEquals",
];

/// `CSharpRenderer.emitUsings()`: `System` and `System.Collections.Generic`
/// (what a subclass's `super.emitUsings()` calls).
pub fn emit_usings<'a, R: CSharpRenderer<'a>>(r: &mut R) -> Result<()> {
    for ns in ["System", "System.Collections.Generic"] {
        r.emit_using(ns);
    }
    Ok(())
}

/// `emitFinish` of the leaves' transformer interpreters: what to do with a
/// decoded or encoded value.
pub(crate) type Finish<'f, R> = &'f dyn Fn(&mut R, Source) -> Result<()>;

/// `defined(transformationForType(t))`: the transformation of `t`, which
/// must have one.
pub(crate) fn transformation_of(graph: &TypeGraph, t: TypeRef) -> Result<Transformation> {
    let xf = defined(transformation_for_type(graph, t)?)?;
    Ok(defined(downcast_transformation(xf.as_ref()))?.clone())
}

/// `arrayIntercalate([" && "], conditions)`.
pub(crate) fn intercalate_and(conditions: Vec<Source>) -> Source {
    let mut result = Vec::with_capacity(conditions.len() * 2);
    for (i, condition) in conditions.into_iter().enumerate() {
        if i > 0 {
            result.push(sl![" && "]);
        }
        result.push(condition);
    }
    Source::Sequence(result)
}

/// The methods of TS `CSharpRenderer` that are not `ConvenienceRenderer`
/// hooks. The subclasses override the first group.
pub trait CSharpRenderer<'a>: ConvenienceRenderer<'a> {
    /// The `CSharpRenderer` fields.
    fn cs(&self) -> &CSharpState;

    // ---- Overridden by the subclasses ----------------------------------------

    /// `baseclassForType(t)`.
    fn baseclass_for_type(&self, _t: TypeRef) -> Option<Source> {
        None
    }

    /// `attributesForProperty(property, name, c, jsonName)`.
    fn attributes_for_property(
        &self,
        _property: &ClassProperty,
        _name: Name,
        _c: TypeRef,
        _json_name: &str,
    ) -> Result<Option<Vec<Source>>> {
        Ok(None)
    }

    /// `blankLinesBetweenAttributes()`.
    fn blank_lines_between_attributes(&self) -> bool {
        false
    }

    /// `emitUsings()`.
    fn emit_usings(&mut self) -> Result<()> {
        emit_usings(self)
    }

    /// `emitRequiredHelpers()`.
    fn emit_required_helpers(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitDefaultLeadingComments()`.
    fn emit_default_leading_comments(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitDefaultFollowingComments()`.
    fn emit_default_following_comments(&mut self) -> Result<()> {
        Ok(())
    }

    /// `needNamespace()`.
    fn need_namespace(&self) -> bool {
        true
    }

    // ---- Shared ---------------------------------------------------------------

    /// `emitBlock(f, semicolon)`.
    fn emit_block(
        &mut self,
        f: impl FnOnce(&mut Self) -> Result<()>,
        semicolon: bool,
    ) -> Result<()> {
        self.emit_line("{");
        self.indent(f)?;
        self.emit_line_parts(vec!["}".into(), if semicolon { ";" } else { "" }.into()]);
        Ok(())
    }

    /// `doubleType`.
    fn double_type(&self) -> &'static str {
        if self.cs().options.use_decimal {
            "decimal"
        } else {
            "double"
        }
    }

    /// `csType(t, follow, withIssues)`.
    fn cs_type(&self, t: TypeRef, follow: Follow, with_issues: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let actual_type = match follow {
                Follow::Target => follow_target_type(graph, t)?,
                Follow::None => t,
            };
            let ty = graph.type_at(actual_type)?;
            let type_for_any = match self.cs().options.type_for_any {
                EnumValue::Declared(type_for_any) => Source::from(type_for_any),
                EnumValue::Prototype(member) => Source::from(member),
            };
            Ok(match ty.kind() {
                TypeKind::Any => {
                    maybe_annotated(with_issues, any_type_issue_annotation(), type_for_any)
                }
                TypeKind::Null => {
                    maybe_annotated(with_issues, null_type_issue_annotation(), type_for_any)
                }
                TypeKind::Bool => "bool".into(),
                TypeKind::Integer => "long".into(),
                TypeKind::Double => self.double_type().into(),
                TypeKind::String => "string".into(),
                TypeKind::Array => {
                    let items_type = self.cs_type(ty.items()?, follow, with_issues)?;
                    if self.cs().options.use_list {
                        sl!["List<", items_type, ">"]
                    } else {
                        sl![items_type, "[]"]
                    }
                }
                TypeKind::Class => self.name_for_named_type(actual_type)?.into(),
                TypeKind::Map => sl![
                    "Dictionary<string, ",
                    self.cs_type(ty.map_values()?, follow, with_issues)?,
                    ">"
                ],
                TypeKind::Enum => self.name_for_named_type(actual_type)?.into(),
                TypeKind::Union => match nullable_from_union(graph, actual_type)? {
                    Some(nullable) => self.nullable_cs_type(nullable, Follow::None, false)?,
                    None => self.name_for_named_type(actual_type)?.into(),
                },
                kind if kind.is_primitive_string_type_kind() => {
                    cs_type_for_transformed_string_type(kind)?
                }
                TypeKind::Intersection => {
                    return crate::support::support::panic("Unknown type intersection");
                }
                kind => return type_not_supported(kind),
            })
        })
    }

    /// `nullableCSType(t, follow, withIssues)`.
    fn nullable_cs_type(&self, t: TypeRef, follow: Follow, with_issues: bool) -> Result<Source> {
        let graph = self.type_graph();
        let mut t = follow_target_type(graph, t)?;
        // A nullable union already renders with its own "?" through
        // csType's union case; unwrap it so the annotation is applied
        // exactly once.  Without this, an optional property whose type
        // is e.g. `string | null` would render as `string??` at C# 8
        // (and a nullable value-type union as `long??` at any version).
        if graph.type_at(t)?.is_union() {
            if let Some(nullable) = nullable_from_union(graph, t)? {
                t = follow_target_type(graph, nullable)?;
            }
        }

        let cs_type = self.cs_type(t, follow, with_issues)?;
        if is_value_type(graph, t)? || self.cs().options.version.is_some_and(|v| v >= 8) {
            Ok(sl![cs_type, "?"])
        } else {
            Ok(cs_type)
        }
    }

    /// `objectTypeKind`: the keyword for named object types. Records need
    /// C# 9+; the option is independent of `--csharp-version`, which only
    /// gates older syntax.
    fn object_type_kind(&self) -> &'static str {
        if self.cs().options.use_records {
            "record"
        } else {
            "class"
        }
    }

    /// `emitType(description, accessModifier, declaration, name, baseclass,
    /// emitter)`.
    fn emit_type(
        &mut self,
        description: Option<Vec<String>>,
        access_modifier: AccessModifier,
        declaration: Source,
        name: Source,
        baseclass: Option<Source>,
        emitter: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        let declaration = match access_modifier {
            AccessModifier::Public => sl!["public ", declaration],
            AccessModifier::Internal => sl!["internal ", declaration],
            AccessModifier::None => declaration,
        };

        self.emit_description(description)?;
        match baseclass {
            None => self.emit_line_parts(vec![declaration, " ".into(), name]),
            Some(baseclass) => {
                self.emit_line_parts(vec![declaration, " ".into(), name, " : ".into(), baseclass]);
            }
        }

        self.emit_block(emitter, false)
    }

    /// `propertyDefinition(property, name, c, jsonName)`.
    fn property_definition(
        &self,
        property: &ClassProperty,
        name: Name,
        _c: TypeRef,
        _json_name: &str,
    ) -> Result<Source> {
        let t = property.type_ref;
        let cs_type = if property.is_optional {
            self.nullable_cs_type(t, Follow::Target, true)?
        } else {
            self.cs_type(t, Follow::Target, true)?
        };

        let mut property_array: Vec<Source> = vec!["public ".into()];

        if self.cs().options.virtual_ {
            property_array.push("virtual ".into());
        }

        property_array.extend([cs_type, " ".into(), name.into(), " { get; set; }".into()]);
        Ok(Source::Sequence(property_array))
    }

    /// `emitClassDefinition(c, className)`.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        let declaration = sl!["partial ", self.object_type_kind()];
        let baseclass = self.baseclass_for_type(c);
        self.emit_type(
            description,
            AccessModifier::Public,
            declaration,
            class_name.into(),
            baseclass,
            |r| {
                if r.type_graph().type_at(c)?.properties()?.is_empty() {
                    return Ok(());
                }
                let blank_lines = if r.blank_lines_between_attributes() {
                    BlankLinePosition::Interposing
                } else {
                    BlankLinePosition::None
                };
                let mut columns: Vec<Vec<Source>> = Vec::new();
                let mut is_first_property = true;
                let mut previous_description: Option<Vec<String>> = None;
                r.for_each_class_property(c, blank_lines, |r, name, json_name, p, _| {
                    let attributes = r.attributes_for_property(&p, name, c, json_name)?;
                    let description = r.description_for_class_property(c, json_name)?;
                    let property = r.property_definition(&p, name, c, json_name)?;
                    match attributes {
                        None => {
                            if
                            // Descriptions should be preceded by an empty line
                            (!is_first_property && description.is_some())
                                // If the previous property has a description, leave an empty line
                                || previous_description.is_some()
                            {
                                r.ensure_blank_line();
                            }

                            r.emit_description(description.clone())?;
                            r.emit_line(property);
                        }
                        Some(attributes) if r.cs().options.dense && !attributes.is_empty() => {
                            let comment = match &description {
                                None => String::new(),
                                Some(d) => format!(" // {}", d.join("; ")),
                            };
                            columns.push(vec![
                                Source::Sequence(attributes),
                                " ".into(),
                                property,
                                comment.into(),
                            ]);
                        }
                        Some(attributes) => {
                            r.emit_description(description.clone())?;
                            for attribute in attributes {
                                r.emit_line(attribute);
                            }

                            r.emit_line(property);
                        }
                    }

                    is_first_property = false;
                    previous_description = description;
                    Ok(())
                })?;
                if !columns.is_empty() {
                    r.emit_table(columns);
                }
                Ok(())
            },
        )
    }

    /// `emitUnionDefinition(u, unionName)`.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let graph = self.type_graph();
        let (_, non_nulls) = remove_null_from_union(graph, u, NullRemovalSort::ByKind)?;
        let description = self.description_for_type(u)?;
        let baseclass = self.baseclass_for_type(u);
        self.emit_type(
            description,
            AccessModifier::Public,
            "partial struct".into(),
            union_name.into(),
            baseclass,
            |r| {
                r.for_each_union_member(
                    u,
                    Some(&non_nulls),
                    BlankLinePosition::None,
                    None,
                    |r, field_name, t, _| {
                        let cs_type = r.nullable_cs_type(t, Follow::Target, false)?;
                        r.emit_line_parts(vec![
                            "public ".into(),
                            cs_type,
                            " ".into(),
                            field_name.into(),
                            ";".into(),
                        ]);
                        Ok(())
                    },
                )?;
                r.ensure_blank_line();
                let mut null_tests: Vec<Source> = Vec::new();
                for &t in &non_nulls {
                    null_tests.push(sl![r.name_for_union_member(u, t)?, " == null"]);
                }
                r.ensure_blank_line();
                r.for_each_union_member(
                    u,
                    Some(&non_nulls),
                    BlankLinePosition::None,
                    None,
                    |r, field_name, t, _| {
                        let cs_type = r.cs_type(t, Follow::Target, false)?;
                        r.emit_expression_member(
                            sl![
                                "public static implicit operator ",
                                union_name,
                                "(",
                                cs_type,
                                " ",
                                field_name,
                                ")"
                            ],
                            sl![
                                "new ", union_name, " { ", field_name, " = ", field_name, " }"
                            ],
                            false,
                        )
                    },
                )?;
                if find_member(r.type_graph(), u, TypeKind::Null)?.is_none() {
                    return Ok(());
                }
                // arrayIntercalate(" && ", nullTests)
                let mut intercalated: Vec<Source> = Vec::new();
                for (i, test) in null_tests.into_iter().enumerate() {
                    if i > 0 {
                        intercalated.push(" && ".into());
                    }
                    intercalated.push(test);
                }
                r.emit_expression_member(
                    "public bool IsNull".into(),
                    Source::Sequence(intercalated),
                    true,
                )
            },
        )
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let mut case_names: Vec<Source> = Vec::new();
        self.for_each_enum_case(e, BlankLinePosition::None, |_, name, _, _| {
            if !case_names.is_empty() {
                case_names.push(", ".into());
            }
            case_names.push(name.into());
            Ok(())
        })?;
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line_parts(vec![
            "public enum ".into(),
            enum_name.into(),
            " { ".into(),
            Source::Sequence(case_names),
            " };".into(),
        ]);
        Ok(())
    }

    /// `emitExpressionMember(declare, define, isProperty)`.
    fn emit_expression_member(
        &mut self,
        declare: Source,
        define: Source,
        is_property: bool,
    ) -> Result<()> {
        if self.cs().options.version == Some(5) {
            self.emit_line(declare);
            self.emit_block(
                |r| {
                    let stmt = sl!["return ", define, ";"];
                    if is_property {
                        r.emit_line("get");
                        r.emit_block(
                            |r| {
                                r.emit_line(stmt);
                                Ok(())
                            },
                            false,
                        )
                    } else {
                        r.emit_line(stmt);
                        Ok(())
                    }
                },
                false,
            )
        } else {
            self.emit_line_parts(vec![declare, " => ".into(), define, ";".into()]);
            Ok(())
        }
    }

    /// `emitTypeSwitch(types, condition, withBlock, withReturn, f)`.
    fn emit_type_switch<T>(
        &mut self,
        types: impl IntoIterator<Item = T>,
        mut condition: impl FnMut(&Self, &T) -> Result<Source>,
        with_block: bool,
        with_return: bool,
        mut f: impl FnMut(&mut Self, T) -> Result<()>,
    ) -> Result<()> {
        assert(
            !with_return || with_block,
            "Can only have return with block",
        )?;
        for t in types {
            let cond = condition(self, &t)?;
            self.emit_line_parts(vec!["if (".into(), cond, ")".into()]);
            if with_block {
                self.emit_block(
                    |r| {
                        f(r, t)?;
                        if with_return {
                            r.emit_line("return;");
                        }
                        Ok(())
                    },
                    false,
                )?;
            } else {
                self.indent(|r| f(r, t))?;
            }
        }
        Ok(())
    }

    /// `emitUsing(ns)`.
    fn emit_using(&mut self, ns: impl Into<Source>) {
        self.emit_line_parts(vec!["using ".into(), ns.into(), ";".into()]);
    }

    /// `emitTypesAndSupport()`.
    fn emit_types_and_support(&mut self) -> Result<()> {
        self.for_each_object(BlankLinePosition::LeadingAndInterposing, |r, c, name, _| {
            r.emit_class_definition(c, name)
        })?;
        self.for_each_enum(BlankLinePosition::LeadingAndInterposing, |r, e, name, _| {
            r.emit_enum_definition(e, name)
        })?;
        self.for_each_union(BlankLinePosition::LeadingAndInterposing, |r, u, name, _| {
            r.emit_union_definition(u, name)
        })?;
        self.emit_required_helpers()
    }

    /// `emitDependencyUsings()`: `System.Collections.Generic` if a list or
    /// dictionary is used.
    fn emit_dependency_usings(&mut self) -> Result<()> {
        let mut generic_emitted = false;
        let graph = self.type_graph();
        let use_list = self.cs().options.use_list;
        for t in graph.all_types_unordered() {
            let needs_generic = match graph.kind(t)? {
                TypeKind::Array => use_list,
                TypeKind::Map => true,
                TypeKind::Intersection => {
                    return crate::support::support::panic("Unknown type intersection");
                }
                _ => false,
            };
            if needs_generic && !generic_emitted {
                self.emit_using("System.Collections.Generic");
                generic_emitted = true;
            }
        }
        Ok(())
    }
}

/// The `ConvenienceRenderer` hooks `CSharpRenderer` overrides; the
/// subclasses' hooks modules glob-import this one.
pub mod c_sharp_hooks {
    pub use crate::convenience_renderer::defaults::*;

    use super::{CSharpRenderer, OBJECT_MEMBER_NAMES};
    use crate::convenience_renderer::ForbiddenWordsInfo;
    use crate::convenience_renderer::prelude::*;
    use crate::support::comments::CommentOptions;
    use crate::ty::type_utils::{directly_reachable_single_named_type, nullable_from_union};

    /// `forbiddenNamesForGlobalNamespace()`.
    pub fn forbidden_names_for_global_namespace<'a, R: CSharpRenderer<'a>>(
        r: &mut R,
    ) -> Result<Vec<String>> {
        let mut names: Vec<String> = [
            "QuickType",
            "Type",
            "System",
            "Console",
            "Exception",
            "DateTimeOffset",
            "DateTimeStyles",
            "Guid",
            "Uri",
        ]
        .into_iter()
        .map(str::to_owned)
        .collect();
        if r.cs().options.use_records {
            names.extend(
                ["Clone", "EqualityContract", "PrintMembers", "ToString"].map(str::to_owned),
            );
        }
        Ok(names)
    }

    /// `forbiddenForObjectProperties(c, className)`.
    pub fn forbidden_for_object_properties<'a, R: CSharpRenderer<'a>>(
        r: &mut R,
        _c: TypeRef,
        class_named: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let mut names = vec![class_named.into()];
        names.extend(OBJECT_MEMBER_NAMES.map(Into::into));
        if r.cs().options.use_records {
            names.extend(["Clone", "EqualityContract", "PrintMembers"].map(Into::into));
        }
        Ok(ForbiddenWordsInfo {
            names,
            include_global_forbidden: false,
        })
    }

    /// `forbiddenForUnionMembers(u, unionName)`.
    pub fn forbidden_for_union_members<'a, R: CSharpRenderer<'a>>(
        _r: &mut R,
        _u: TypeRef,
        union_named: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let mut names = vec![union_named.into()];
        names.extend(OBJECT_MEMBER_NAMES.map(Into::into));
        Ok(ForbiddenWordsInfo {
            names,
            include_global_forbidden: true,
        })
    }

    /// `makeNamedTypeNamer()`.
    pub fn make_named_type_namer<'a, R: CSharpRenderer<'a>>(r: &mut R) -> Namer {
        r.cs().naming_function.clone()
    }

    /// `namerForObjectProperty()`.
    pub fn namer_for_object_property<'a, R: CSharpRenderer<'a>>(
        r: &mut R,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        let cs = r.cs();
        Ok(Some(if cs.options.keep_property_name {
            cs.naming_function_keep.clone()
        } else {
            cs.naming_function.clone()
        }))
    }

    /// `makeUnionMemberNamer()`.
    pub fn make_union_member_namer<'a, R: CSharpRenderer<'a>>(r: &mut R) -> Option<Namer> {
        Some(r.cs().naming_function.clone())
    }

    /// `makeEnumCaseNamer()`.
    pub fn make_enum_case_namer<'a, R: CSharpRenderer<'a>>(r: &mut R) -> Option<Namer> {
        Some(r.cs().naming_function.clone())
    }

    /// `unionNeedsName(u)`.
    pub fn union_needs_name<'a, R: CSharpRenderer<'a>>(r: &R, u: TypeRef) -> Result<bool> {
        Ok(nullable_from_union(r.type_graph(), u)?.is_none())
    }

    /// `namedTypeToNameForTopLevel(type)`: if the top-level type doesn't
    /// contain any classes or unions we have to define a class just for the
    /// `FromJson` method, in `emitFromJsonForTopLevel`.
    pub fn named_type_to_name_for_top_level<'a, R: CSharpRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Option<TypeRef>> {
        directly_reachable_single_named_type(r.type_graph(), t)
    }

    /// `emitDescriptionBlock(lines)`: doc comments are XML, so anything
    /// that could be mistaken for markup must be escaped.
    pub fn emit_description_block<'a, R: CSharpRenderer<'a>>(
        r: &mut R,
        lines: &[Source],
    ) -> Result<()> {
        let mut escaped_lines: Vec<String> = Vec::with_capacity(lines.len());
        for line in lines {
            escaped_lines.push(
                r.sourcelike_to_string(line)?
                    .replace('&', "&amp;")
                    .replace('<', "&lt;")
                    .replace('>', "&gt;"),
            );
        }
        let start = "/// <summary>";
        if r.cs().options.dense {
            r.emit_line_parts(vec![
                start.into(),
                escaped_lines.join("; ").into(),
                "</summary>".into(),
            ]);
            Ok(())
        } else {
            let lines: Vec<Source> = escaped_lines.into_iter().map(Source::from).collect();
            r.emit_comment_lines(
                &lines,
                &CommentOptions {
                    line_start: Some("/// ".to_owned()),
                    before_comment: Some(start.to_owned()),
                    after_comment: Some("/// </summary>".to_owned()),
                    ..CommentOptions::default()
                },
            )
        }
    }

    /// `emitSourceStructure()`.
    pub fn emit_source_structure<'a, R: CSharpRenderer<'a>>(
        r: &mut R,
        _given_output_filename: &str,
    ) -> Result<()> {
        match r.leading_comments() {
            Some(leading_comments) => r.emit_comments(leading_comments)?,
            None => r.emit_default_leading_comments()?,
        }

        r.ensure_blank_line();
        if r.need_namespace() {
            let namespace = r.cs().options.namespace.clone();
            r.emit_line_parts(vec!["namespace ".into(), namespace.into()]);
            r.emit_block(
                |r| {
                    r.emit_usings()?;
                    r.emit_types_and_support()
                },
                false,
            )?;
        } else {
            r.emit_usings()?;
            r.emit_types_and_support()?;
        }

        r.emit_default_following_comments()
    }
}
