//! Port of `packages/quicktype-core/src/language/Kotlin/KotlinRenderer.ts`.
//!
//! The Kotlin renderer family. `KotlinRenderer` is both the `--just-types`
//! renderer ([`KotlinPlainRenderer`]) and the base class of the Jackson,
//! Klaxon and kotlinx.serialization renderers, so it is split as
//! `docs/RENDERERS.md` describes:
//!
//! - [`KotlinState`]: the base class's fields, owned by every leaf;
//! - [`KotlinRenderer`]: the base class's own methods, with the overridable
//!   ones as trait methods whose defaults are the `KotlinRenderer` versions
//!   (the `base_*` functions, which overrides call for `super`);
//! - [`kotlin_hooks`]: the `ConvenienceRenderer` hooks `KotlinRenderer`
//!   overrides.

use indexmap::IndexSet;

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::renderer_options::{EnumValue, RendererOptions};
use crate::support::acronyms::AcronymStyleOptions;
use crate::support::fast_hash::HashMap;
use crate::support::recursion::guard;
use crate::support::support::panic;
use crate::target_language::TargetLanguage;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::language::{ACRONYM_STYLE, FRAMEWORK, Framework, JUST_TYPES, PACKAGE_NAME};
use super::utils::string_escape;

/// The option values of the Kotlin renderers (TS
/// `OptionValues<typeof kotlinOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct KotlinOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `framework`.
    pub framework: Framework,
    /// `acronymStyle`.
    pub acronym_style: AcronymStyleOptions,
    /// `packageName`.
    pub package_name: String,
}

impl KotlinOptions {
    /// `getOptionValues(kotlinOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let just_types = JUST_TYPES.get_value(values);
        let framework = match FRAMEWORK.get_enum_value(values)? {
            EnumValue::Declared("klaxon") => Framework::Klaxon,
            EnumValue::Declared("kotlinx") => Framework::KotlinX,
            EnumValue::Declared(_) => Framework::Jackson,
            EnumValue::Prototype(member) => Framework::Other(member),
        };
        // An `Object.prototype` member selects no style (`undefined`), so
        // `kotlinNameStyle`'s default parameter, `allUpperWordStyle` (the
        // Pascal style), takes its place.
        let acronym_style =
            AcronymStyleOptions::from_enum_value(ACRONYM_STYLE.get_enum_value(values)?)
                .unwrap_or(AcronymStyleOptions::Pascal);
        Ok(KotlinOptions {
            just_types,
            framework,
            acronym_style,
            package_name: PACKAGE_NAME.get_value(values).into_owned(),
        })
    }
}

/// The fields of TS `KotlinRenderer`, and which `java.time` types the
/// graph has (`haveTransformedStringType`, computed once per render).
#[derive(Debug)]
pub struct KotlinState {
    /// `_kotlinOptions`.
    pub options: KotlinOptions,
    uses_date_time: bool,
    uses_date: bool,
    uses_time: bool,
}

impl KotlinState {
    /// The constructor of TS `KotlinRenderer`, for a render of `graph`.
    pub fn new(options: KotlinOptions, graph: &TypeGraph) -> Self {
        let has = |kind: TypeKind| graph.types().iter().any(|t| t.kind() == kind);
        KotlinState {
            options,
            uses_date_time: has(TypeKind::DateTime),
            uses_date: has(TypeKind::Date),
            uses_time: has(TypeKind::Time),
        }
    }

    /// `haveTransformedStringType(kind)` for `date-time`, `date` and
    /// `time`; false for any other kind.
    pub fn have_transformed_string_type(&self, kind: TypeKind) -> bool {
        match kind {
            TypeKind::DateTime => self.uses_date_time,
            TypeKind::Date => self.uses_date,
            TypeKind::Time => self.uses_time,
            _ => false,
        }
    }
}

/// The `delimiter` of `emitBlock`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Delimiter {
    /// `"curly"`: `{` ... `}`.
    Curly,
    /// `"paren"`: `(` ... `)`.
    Paren,
    /// `"lambda"`: `{` ... `})`.
    Lambda,
}

/// What a `meta` closure of `emitClassDefinition` emits before a property.
#[derive(Clone, Debug)]
pub enum Meta {
    /// `() => this.emitDescription(description)`.
    Description(Vec<String>),
    /// `() => this.emitLine(line)`.
    Line(Source),
}

/// The transformed string kinds `haveTransformedStringType` checks.
pub const DATE_TIME_KINDS: [TypeKind; 3] = [TypeKind::DateTime, TypeKind::Date, TypeKind::Time];

/// Base `arrayType(arrayType, withIssues, noOptional)`: `List<T>`.
pub fn base_array_type<'a, R: KotlinRenderer<'a>>(
    r: &R,
    array_type: TypeRef,
    with_issues: bool,
    _no_optional: bool,
) -> Result<Source> {
    let items = r.type_graph().type_at(array_type)?.items()?;
    Ok(sl!["List<", r.kotlin_type(items, with_issues, false)?, ">"])
}

/// Base `mapType(mapType, withIssues, noOptional)`: `Map<String, T>`.
pub fn base_map_type<'a, R: KotlinRenderer<'a>>(
    r: &R,
    map_type: TypeRef,
    with_issues: bool,
    _no_optional: bool,
) -> Result<Source> {
    let values = r.type_graph().type_at(map_type)?.map_values()?;
    Ok(sl![
        "Map<String, ",
        r.kotlin_type(values, with_issues, false)?,
        ">"
    ])
}

/// Base `kotlinType(t, withIssues, noOptional)`.
pub fn base_kotlin_type<'a, R: KotlinRenderer<'a>>(
    r: &R,
    t: TypeRef,
    with_issues: bool,
    no_optional: bool,
) -> Result<Source> {
    // Endless on a cycle through a nullable union (V8 overflows its stack).
    guard(|| {
        let optional = if no_optional { "" } else { "?" };
        let graph = r.type_graph();
        Ok(match graph.kind(t)? {
            TypeKind::Any => maybe_annotated(
                with_issues,
                any_type_issue_annotation(),
                r.any_source_type(optional),
            ),
            TypeKind::Null => maybe_annotated(
                with_issues,
                null_type_issue_annotation(),
                r.any_source_type(optional),
            ),
            TypeKind::Bool => "Boolean".into(),
            TypeKind::Integer => "Long".into(),
            TypeKind::Double => "Double".into(),
            TypeKind::String => "String".into(),
            TypeKind::Array => r.array_type(t, with_issues, false)?,
            TypeKind::Class | TypeKind::Enum => r.name_for_named_type(t)?.into(),
            TypeKind::Map => r.map_type(t, with_issues, false)?,
            TypeKind::Union => match nullable_from_union(graph, t)? {
                Some(nullable) => sl![r.kotlin_type(nullable, with_issues, false)?, optional],
                None => r.name_for_named_type(t)?.into(),
            },
            TypeKind::DateTime => "OffsetDateTime".into(),
            TypeKind::Date => "LocalDate".into(),
            TypeKind::Time => "OffsetTime".into(),
            kind if kind.is_transformed_string_type_kind() => "String".into(),
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => return type_not_supported(kind),
        })
    })
}

/// Base `emitHeader()`: the usage comment (or the leading comments), the
/// package and the `java.time` imports.
pub fn base_emit_header<'a, R: KotlinRenderer<'a>>(r: &mut R) -> Result<()> {
    if let Some(leading_comments) = r.leading_comments() {
        r.emit_comments(leading_comments)?;
    } else {
        r.emit_usage_header()?;
    }

    r.ensure_blank_line();
    r.emit_file_annotations()?;
    let package_name = r.kotlin().options.package_name.clone();
    r.emit_line(sl!["package ", package_name]);
    r.ensure_blank_line();

    // Check if we need to import java.time classes
    let uses_date_time = r.have_transformed_string_type(TypeKind::DateTime);
    let uses_date = r.have_transformed_string_type(TypeKind::Date);
    let uses_time = r.have_transformed_string_type(TypeKind::Time);

    if uses_date_time {
        r.emit_line("import java.time.OffsetDateTime");
    }

    if uses_date {
        r.emit_line("import java.time.LocalDate");
    }

    if uses_time {
        r.emit_line("import java.time.OffsetTime");
    }

    if uses_date_time || uses_date || uses_time {
        r.ensure_blank_line();
    }
    Ok(())
}

/// Base `emitTopLevelMap(t, name)`: a `HashMap` typealias.
pub fn base_emit_top_level_map<'a, R: KotlinRenderer<'a>>(
    r: &mut R,
    t: TypeRef,
    name: Name,
) -> Result<()> {
    let values = r.type_graph().type_at(t)?.map_values()?;
    let element_type = r.kotlin_type(values, false, false)?;
    r.emit_line(sl![
        "typealias ",
        name,
        " = HashMap<String, ",
        element_type,
        ">"
    ]);
    Ok(())
}

/// `sortBy` of `emitUnionDefinition`: classes first.
fn union_member_sort_key(kind: TypeKind) -> String {
    if kind == TypeKind::Class {
        return kind.as_str().to_owned();
    }
    format!("_{}", kind.as_str())
}

/// Base `emitUnionDefinition(u, unionName)`: a sealed class with one
/// subclass per member.
pub fn base_emit_union_definition<'a, R: KotlinRenderer<'a>>(
    r: &mut R,
    u: TypeRef,
    union_name: Name,
) -> Result<()> {
    let description = r.description_for_type(u)?;
    r.emit_description(description)?;

    let graph = r.type_graph();
    let mut sort_keys: HashMap<TypeRef, String> = HashMap::default();
    for &m in graph.type_at(u)?.members()? {
        sort_keys.insert(m, union_member_sort_key(graph.kind(m)?));
    }
    let sort_by = |m: TypeRef| sort_keys.get(&m).cloned().unwrap_or_default();
    let (maybe_null, non_nulls) = remove_null_from_union(graph, u, NullRemovalSort::By(&sort_by))?;
    r.emit_class_annotations(u, union_name)?;
    r.emit_block(
        sl!["sealed class ", union_name],
        |r| {
            let mut table: Vec<Vec<Source>> = Vec::new();
            r.for_each_union_member(
                u,
                Some(&non_nulls),
                BlankLinePosition::None,
                None,
                |r, name, t, _| {
                    table.push(vec![
                        sl![
                            "class ",
                            name,
                            "(val value: ",
                            r.kotlin_type(t, false, false)?,
                            ")"
                        ],
                        sl![" : ", union_name, "()"],
                    ]);
                    Ok(())
                },
            )?;
            if let Some(null) = maybe_null {
                table.push(vec![
                    sl!["class ", r.name_for_union_member(u, null)?, "()"],
                    sl![" : ", union_name, "()"],
                ]);
            }

            r.emit_table(table);

            r.emit_union_definition_methods(u, &non_nulls, maybe_null, union_name)
        },
        Delimiter::Curly,
    )
}

/// The methods of TS `KotlinRenderer` that are not `ConvenienceRenderer`
/// hooks. The overridable ones default to the `KotlinRenderer` version.
pub trait KotlinRenderer<'a>: ConvenienceRenderer<'a> {
    /// The base class's fields.
    fn kotlin(&self) -> &KotlinState;

    // ---- Types ----------------------------------------------------------------

    /// `anySourceType(optional)`: `Any?`.
    fn any_source_type(&self, optional: &str) -> Source {
        sl!["Any", optional]
    }

    /// `arrayType(arrayType, withIssues, noOptional)`: broken out because
    /// some renderers, such as kotlinx, can cope with `any`, while some get
    /// mad.
    fn array_type(
        &self,
        array_type: TypeRef,
        with_issues: bool,
        no_optional: bool,
    ) -> Result<Source> {
        base_array_type(self, array_type, with_issues, no_optional)
    }

    /// `mapType(mapType, withIssues, noOptional)`.
    fn map_type(&self, map_type: TypeRef, with_issues: bool, no_optional: bool) -> Result<Source> {
        base_map_type(self, map_type, with_issues, no_optional)
    }

    /// `kotlinType(t, withIssues, noOptional)`.
    fn kotlin_type(&self, t: TypeRef, with_issues: bool, no_optional: bool) -> Result<Source> {
        base_kotlin_type(self, t, with_issues, no_optional)
    }

    /// `haveTransformedStringType(kind)`: whether the graph has a `date`,
    /// `time` or `date-time` type.
    fn have_transformed_string_type(&self, kind: TypeKind) -> bool {
        self.kotlin().have_transformed_string_type(kind)
    }

    // ---- Header -----------------------------------------------------------------

    /// `emitUsageHeader()`: nothing.
    fn emit_usage_header(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitFileAnnotations()`: emitted between the usage header and the
    /// package declaration, the only place Kotlin allows `@file:`-targeted
    /// annotations. Nothing by default.
    fn emit_file_annotations(&mut self) -> Result<()> {
        Ok(())
    }

    /// `emitHeader()`.
    fn emit_header(&mut self) -> Result<()> {
        base_emit_header(self)
    }

    // ---- Emitting helpers ---------------------------------------------------------

    /// `emitBlock(line, f, delimiter)`.
    fn emit_block(
        &mut self,
        line: Source,
        f: impl FnOnce(&mut Self) -> Result<()>,
        delimiter: Delimiter,
    ) -> Result<()> {
        let (open, close) = match delimiter {
            Delimiter::Curly => ("{", "}"),
            Delimiter::Paren => ("(", ")"),
            Delimiter::Lambda => ("{", "})"),
        };
        self.emit_line(sl![line, " ", open]);
        self.indent(f)?;
        self.emit_line(close);
        Ok(())
    }

    /// Whether `t` is one of the top-levels
    /// (`iterableSome(this.topLevels, ([_, top]) => top === t)`).
    fn is_top_level(&self, t: TypeRef) -> bool {
        self.top_levels().values().any(|&top| top == t)
    }

    // ---- Top-levels ----------------------------------------------------------------

    /// `emitTopLevelPrimitive(t, name)`.
    fn emit_top_level_primitive(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let element_type = self.kotlin_type(t, false, false)?;
        self.emit_line(sl!["typealias ", name, " = ", element_type, ""]);
        Ok(())
    }

    /// `emitTopLevelArray(t, name)`.
    fn emit_top_level_array(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let items = self.type_graph().type_at(t)?.items()?;
        let element_type = self.kotlin_type(items, false, false)?;
        self.emit_line(sl!["typealias ", name, " = ArrayList<", element_type, ">"]);
        Ok(())
    }

    /// `emitTopLevelMap(t, name)`.
    fn emit_top_level_map(&mut self, t: TypeRef, name: Name) -> Result<()> {
        base_emit_top_level_map(self, t, name)
    }

    // ---- Classes ----------------------------------------------------------------------

    /// `emitEmptyClassDefinition(c, className)`.
    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_class_annotations(c, class_name)?;
        self.emit_line(sl!["class ", class_name, "()"]);
        Ok(())
    }

    /// `emitClassDefinition(c, className)`: a data class.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let property_count = self.type_graph().type_at(c)?.properties()?.len();
        if property_count == 0 {
            return self.emit_empty_class_definition(c, class_name);
        }

        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_class_annotations(c, class_name)?;
        self.emit_line(sl!["data class ", class_name, " ("]);
        self.indent(|r| {
            let mut count = property_count as i64;
            let mut first = true;
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
                let graph = r.type_graph();
                let kind = graph.kind(p.type_ref)?;
                let nullable =
                    kind == TypeKind::Union && nullable_from_union(graph, p.type_ref)?.is_some();
                let nullable_or_optional = p.is_optional || kind == TypeKind::Null || nullable;
                count -= 1;
                let last = count == 0;
                let mut meta: Vec<Meta> = Vec::new();

                if let Some(description) = r.description_for_class_property(c, json_name)? {
                    meta.push(Meta::Description(description));
                }

                r.rename_attribute(name, json_name, !p.is_optional, &mut meta, &p)?;

                if !meta.is_empty() && !first {
                    r.ensure_blank_line();
                }

                let has_meta = !meta.is_empty();
                for emit in meta {
                    match emit {
                        Meta::Description(description) => r.emit_description(Some(description))?,
                        Meta::Line(line) => r.emit_line(line),
                    }
                }

                let kotlin_type = if p.is_optional {
                    sl![r.kotlin_type(p.type_ref, true, true)?, "?"]
                } else {
                    r.kotlin_type(p.type_ref, true, false)?
                };
                let property_default = r.property_default(&p, nullable_or_optional)?;
                r.emit_line(sl![
                    "val ",
                    name,
                    ": ",
                    kotlin_type,
                    property_default,
                    if last { "" } else { "," }
                ]);

                if has_meta && !last {
                    r.ensure_blank_line();
                }

                first = false;
                Ok(())
            })
        })?;

        self.emit_class_definition_methods(c, class_name)
    }

    /// `emitClassDefinitionMethods(c, className)`: closes the data class.
    fn emit_class_definition_methods(&mut self, _c: TypeRef, _class_name: Name) -> Result<()> {
        self.emit_line(")");
        Ok(())
    }

    /// `emitClassAnnotations(c, className)`: nothing.
    fn emit_class_annotations(&mut self, _t: TypeRef, _class_name: Name) -> Result<()> {
        Ok(())
    }

    /// `propertyDefault(p, nullableOrOptional)`.
    fn property_default(&self, _p: &ClassProperty, nullable_or_optional: bool) -> Result<Source> {
        Ok((if nullable_or_optional { " = null" } else { "" }).into())
    }

    /// `renameAttribute(name, jsonName, required, meta, p)`: nothing.
    fn rename_attribute(
        &mut self,
        _name: Name,
        _json_name: &str,
        _required: bool,
        _meta: &mut Vec<Meta>,
        _p: &ClassProperty,
    ) -> Result<()> {
        Ok(())
    }

    // ---- Enums and unions -----------------------------------------------------------

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;

        self.emit_block(
            sl!["enum class ", enum_name, "(val value: String)"],
            |r| {
                r.emit_enum_cases(e)?;
                r.ensure_blank_line();
                r.emit_block(
                    "companion object".into(),
                    |r| {
                        r.emit_block(
                            sl![
                                "fun fromValue(value: String): ",
                                enum_name,
                                " = when (value)"
                            ],
                            |r| r.emit_from_value_table(e),
                            Delimiter::Curly,
                        )
                    },
                    Delimiter::Curly,
                )
            },
            Delimiter::Curly,
        )
    }

    /// The `NAME("value"),` lines of `emitEnumDefinition`.
    fn emit_enum_cases(&mut self, e: TypeRef) -> Result<()> {
        let mut count = self.type_graph().type_at(e)?.cases()?.len() as i64;
        self.for_each_enum_case(e, BlankLinePosition::None, |r, name, json, _| {
            count -= 1;
            r.emit_line(sl![
                name,
                format!("(\"{}\")", string_escape(json)),
                if count == 0 { ";" } else { "," }
            ]);
            Ok(())
        })
    }

    /// The `"value" -> NAME` table of `fromValue`.
    fn emit_from_value_table(&mut self, e: TypeRef) -> Result<()> {
        let mut table: Vec<Vec<Source>> = Vec::new();
        self.for_each_enum_case(e, BlankLinePosition::None, |_, name, json, _| {
            table.push(vec![
                sl![format!("\"{}\"", string_escape(json))],
                sl![" -> ", name],
            ]);
            Ok(())
        })?;
        table.push(vec![
            sl!["else"],
            sl![" -> throw IllegalArgumentException()"],
        ]);
        self.emit_table(table);
        Ok(())
    }

    /// `emitUnionDefinition(u, unionName)`.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        base_emit_union_definition(self, u, union_name)
    }

    /// `emitUnionDefinitionMethods(u, nonNulls, maybeNull, unionName)`:
    /// nothing.
    fn emit_union_definition_methods(
        &mut self,
        _u: TypeRef,
        _non_nulls: &IndexSet<TypeRef>,
        _maybe_null: Option<TypeRef>,
        _union_name: Name,
    ) -> Result<()> {
        Ok(())
    }
}

/// The `ConvenienceRenderer` hooks TS `KotlinRenderer` overrides; the rest
/// are the framework defaults.
pub mod kotlin_hooks {
    pub use crate::convenience_renderer::defaults::*;

    use super::KotlinRenderer;
    use crate::convenience_renderer::prelude::*;
    use crate::support::acronyms::acronym_style;
    use crate::support::comments::CommentOptions;
    use crate::support::strings::all_upper_word_style;

    use super::super::constants::KEYWORDS;
    use super::super::utils::kotlin_name_style;

    /// `forbiddenNamesForGlobalNamespace()`: the keywords, and the
    /// `java.time` types the graph uses.
    pub fn forbidden_names_for_global_namespace<'a, R: KotlinRenderer<'a>>(
        r: &mut R,
    ) -> Result<Vec<String>> {
        let mut forbidden: Vec<String> = KEYWORDS.iter().map(|&k| k.to_owned()).collect();
        if r.have_transformed_string_type(TypeKind::Date) {
            forbidden.push("LocalDate".to_owned());
        }
        if r.have_transformed_string_type(TypeKind::DateTime) {
            forbidden.push("OffsetDateTime".to_owned());
        }
        if r.have_transformed_string_type(TypeKind::Time) {
            forbidden.push("OffsetTime".to_owned());
        }
        Ok(forbidden)
    }

    /// `forbiddenForObjectProperties(o, className)`.
    pub fn forbidden_for_object_properties<'a, R: KotlinRenderer<'a>>(
        _r: &mut R,
        _o: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    /// `forbiddenForEnumCases(e, enumName)`: not the enum's own name.
    pub fn forbidden_for_enum_cases<'a, R: KotlinRenderer<'a>>(
        _r: &mut R,
        _e: TypeRef,
        enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: vec![enum_name.into()],
            include_global_forbidden: true,
        })
    }

    /// `forbiddenForUnionMembers(u, unionName)`.
    pub fn forbidden_for_union_members<'a, R: KotlinRenderer<'a>>(
        _r: &mut R,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: false,
        })
    }

    /// `makeNamedTypeNamer()`.
    pub fn make_named_type_namer<'a, R: KotlinRenderer<'a>>(r: &mut R) -> Namer {
        let acronyms = acronym_style(r.kotlin().options.acronym_style);
        fun_prefix_namer("upper", move |s| kotlin_name_style(true, s, acronyms))
    }

    /// `namerForObjectProperty()`: a **new** namer for every property, as
    /// in TypeScript.
    pub fn namer_for_object_property<'a, R: KotlinRenderer<'a>>(
        r: &mut R,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        let acronyms = acronym_style(r.kotlin().options.acronym_style);
        Ok(Some(fun_prefix_namer("lower", move |s| {
            kotlin_name_style(false, s, acronyms)
        })))
    }

    /// `makeUnionMemberNamer()`: `<Member>Value`, acronyms always upper
    /// case.
    pub fn make_union_member_namer<'a, R: KotlinRenderer<'a>>(_r: &mut R) -> Option<Namer> {
        Some(fun_prefix_namer("upper", |s| {
            format!("{}Value", kotlin_name_style(true, s, all_upper_word_style))
        }))
    }

    /// `makeEnumCaseNamer()`.
    pub fn make_enum_case_namer<'a, R: KotlinRenderer<'a>>(r: &mut R) -> Option<Namer> {
        let acronyms = acronym_style(r.kotlin().options.acronym_style);
        Some(fun_prefix_namer("upper", move |s| {
            kotlin_name_style(true, s, acronyms)
        }))
    }

    /// `emitDescriptionBlock(lines)`: a KDoc comment.
    pub fn emit_description_block<'a, R: KotlinRenderer<'a>>(
        r: &mut R,
        lines: &[Source],
    ) -> Result<()> {
        r.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some(" * ".to_owned()),
                before_comment: Some("/**".to_owned()),
                after_comment: Some(" */".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    /// `emitSourceStructure()`: the header, the top-level aliases, then
    /// every named type.
    pub fn emit_source_structure<'a, R: KotlinRenderer<'a>>(
        r: &mut R,
        _given_output_filename: &str,
    ) -> Result<()> {
        r.emit_header()?;

        // Top-level arrays, maps
        r.for_each_top_level(BlankLinePosition::Leading, |r, t, name, _| {
            let ty = r.type_graph().type_at(t)?;
            if ty.is_array() {
                r.emit_top_level_array(t, name)
            } else if ty.is_map() {
                r.emit_top_level_map(t, name)
            } else if ty.is_primitive() {
                r.emit_top_level_primitive(t, name)
            } else {
                Ok(())
            }
        })?;

        r.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| r.emit_class_definition(c, n),
            |r, e, n, _| r.emit_enum_definition(e, n),
            |r, u, n, _| r.emit_union_definition(u, n),
        )
    }
}

/// TS `KotlinRenderer` itself: plain data classes (`--just-types`).
pub struct KotlinPlainRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    kotlin: KotlinState,
}

impl std::fmt::Debug for KotlinPlainRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("KotlinPlainRenderer")
            .field("kotlin", &self.kotlin)
            .finish_non_exhaustive()
    }
}

impl<'a> KotlinPlainRenderer<'a> {
    /// `new KotlinRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: KotlinOptions,
    ) -> Self {
        KotlinPlainRenderer {
            kotlin: KotlinState::new(options, render_context.type_graph),
            core: ConvenienceRendererCore::new(target_language, render_context),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for KotlinPlainRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(kotlin_hooks);
}

impl<'a> KotlinRenderer<'a> for KotlinPlainRenderer<'a> {
    fn kotlin(&self) -> &KotlinState {
        &self.kotlin
    }
}
