//! Port of `packages/quicktype-core/src/language/Java/JavaRenderer.ts`.
//!
//! The Java renderer family. `JavaRenderer` is both the `--just-types`
//! renderer ([`JavaPlainRenderer`]) and the base class of the Jackson
//! renderer, so it is split as `docs/RENDERERS.md` describes:
//!
//! - [`JavaState`]: the base class's fields, owned by every leaf;
//! - [`JavaRenderer`]: the base class's own methods, with the overridable
//!   ones as trait methods whose defaults are the `JavaRenderer` versions;
//! - [`java_hooks`]: the `ConvenienceRenderer` hooks `JavaRenderer`
//!   overrides.
//!
//! Every class, enum and union goes into its own `<Name>.java` file.

use std::collections::HashMap;

use quicktype_js_compat::sort::sort_strings;

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::renderer_options::RendererOptions;
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::strings::capitalize;
use crate::support::support::{assert, defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::date_time_provider::{DateTimeProviderKind, JavaDateTimeProvider};
use super::language::{
    ACRONYM_STYLE, DATE_TIME_PROVIDER, JUST_TYPES, LOMBOK, LOMBOK_COPY_ANNOTATIONS, PACKAGE_NAME,
    USE_LIST,
};
use super::utils::{java_name_style, string_escape};

/// The option values of the Java renderers (TS
/// `OptionValues<typeof javaOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct JavaOptions {
    /// `useList`: `List<T>` (`array-type list`) instead of `T[]`.
    pub use_list: bool,
    /// `justTypes`.
    pub just_types: bool,
    /// `dateTimeProvider`.
    pub date_time_provider: DateTimeProviderKind,
    /// `acronymStyle`.
    pub acronym_style: AcronymStyleOptions,
    /// `packageName`.
    pub package_name: String,
    /// `lombok`.
    pub lombok: bool,
    /// `lombokCopyAnnotations`.
    pub lombok_copy_annotations: bool,
}

impl JavaOptions {
    /// `getOptionValues(javaOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let use_list = USE_LIST.get_enum_value(values)? == "list";
        let just_types = JUST_TYPES.get_value(values);
        let date_time_provider = match DATE_TIME_PROVIDER.get_enum_value(values)? {
            "legacy" => DateTimeProviderKind::Legacy,
            _ => DateTimeProviderKind::Java8,
        };
        let acronym_style = AcronymStyleOptions::from_value(ACRONYM_STYLE.get_enum_value(values)?)
            .unwrap_or(AcronymStyleOptions::Pascal);
        Ok(JavaOptions {
            use_list,
            just_types,
            date_time_provider,
            acronym_style,
            package_name: PACKAGE_NAME.get_value(values).into_owned(),
            lombok: LOMBOK.get_value(values),
            lombok_copy_annotations: LOMBOK_COPY_ANNOTATIONS.get_value(values),
        })
    }
}

/// The fields of TS `JavaRenderer`.
#[derive(Debug)]
pub struct JavaState {
    /// `_options`.
    pub options: JavaOptions,
    /// `_currentFilename`: the file being emitted.
    current_filename: Option<String>,
    /// `_gettersAndSettersForPropertyName`.
    getters_and_setters_for_property_name: HashMap<Name, (Name, Name)>,
    /// `_haveEmittedLeadingComments`: leading comments go into the first
    /// file only.
    have_emitted_leading_comments: bool,
    /// `_dateTimeProvider`.
    pub date_time_provider: JavaDateTimeProvider,
    /// `_converterClassname`.
    pub converter_classname: &'static str,
}

impl JavaState {
    /// The constructor of TS `JavaRenderer`.
    pub fn new(options: JavaOptions) -> Self {
        let converter_classname = "Converter";
        JavaState {
            date_time_provider: JavaDateTimeProvider::new(
                options.date_time_provider,
                converter_classname,
            ),
            options,
            current_filename: None,
            getters_and_setters_for_property_name: HashMap::new(),
            have_emitted_leading_comments: false,
            converter_classname,
        }
    }
}

/// `{ fieldName, fieldType }` of `unionField`.
#[derive(Debug)]
pub struct UnionField {
    /// `fieldName`: the member's name followed by `Value`.
    pub field_name: Source,
    /// `fieldType`.
    pub field_type: Source,
}

/// A naming convention of `getNameStyling`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum NameStyling {
    /// `"typeNamingFunction"`: `PascalCase`.
    Type,
    /// `"propertyNamingFunction"`: `camelCase`.
    Property,
    /// `"enumCaseNamingFunction"`: `UPPER_UNDERSCORE`.
    EnumCase,
}

/// Base `emitClassAttributes(c, className)`: `@lombok.Data` with `lombok`.
pub fn base_emit_class_attributes<'a, R: JavaRenderer<'a>>(
    r: &mut R,
    _c: TypeRef,
    _class_name: Name,
) -> Result<()> {
    if r.java().options.lombok {
        r.emit_line("@lombok.Data");
    }
    Ok(())
}

/// Base `importsForType(t)`: classes import nothing, unions and enums
/// `java.io.IOException`.
pub fn base_imports_for_type<'a, R: JavaRenderer<'a>>(r: &R, t: TypeRef) -> Result<Vec<String>> {
    match r.type_graph().kind(t)? {
        TypeKind::Class => Ok(Vec::new()),
        TypeKind::Union | TypeKind::Enum => Ok(vec!["java.io.IOException".to_owned()]),
        kind => crate::support::support::assert_never(kind),
    }
}

/// `imports.sort(); [...new Set(imports)]`: UTF-16 order, first occurrence
/// of each import.
fn sorted_unique(mut imports: Vec<String>) -> Vec<String> {
    sort_strings(&mut imports);
    let mut unique: Vec<String> = Vec::with_capacity(imports.len());
    for import in imports {
        if !unique.contains(&import) {
            unique.push(import);
        }
    }
    unique
}

/// The methods of TS `JavaRenderer` that are not `ConvenienceRenderer`
/// hooks. The overridable ones default to the `JavaRenderer` version; the
/// others are shared by the whole family.
pub trait JavaRenderer<'a>: ConvenienceRenderer<'a> {
    /// The base class's fields.
    fn java(&self) -> &JavaState;

    /// The base class's fields, mutably.
    fn java_mut(&mut self) -> &mut JavaState;

    // ---- Overridable ------------------------------------------------------

    /// `_converterKeywords`: names the converter imports.
    fn converter_keywords(&self) -> &'static [&'static str] {
        &[]
    }

    /// `emitClassAttributes(c, className)`.
    fn emit_class_attributes(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        base_emit_class_attributes(self, c, class_name)
    }

    /// `annotationsForAccessor(c, className, propertyName, jsonName, p,
    /// isSetter)`: none.
    fn annotations_for_accessor(
        &self,
        _c: TypeRef,
        _class_name: Name,
        _property_name: Name,
        _json_name: &str,
        _p: &ClassProperty,
        _is_setter: bool,
    ) -> Result<Vec<String>> {
        Ok(Vec::new())
    }

    /// `importsForType(t)` for a class, union or enum.
    fn imports_for_type(&self, t: TypeRef) -> Result<Vec<String>> {
        base_imports_for_type(self, t)
    }

    /// `emitUnionAttributes(u, unionName)`: nothing.
    fn emit_union_attributes(&mut self, _u: TypeRef, _union_name: Name) -> Result<()> {
        Ok(())
    }

    /// `emitUnionSerializer(u, unionName)`: nothing.
    fn emit_union_serializer(&mut self, _u: TypeRef, _union_name: Name) -> Result<()> {
        Ok(())
    }

    /// `emitEnumSerializationAttributes(e)`: nothing.
    fn emit_enum_serialization_attributes(&mut self, _e: TypeRef) -> Result<()> {
        Ok(())
    }

    /// `emitEnumDeserializationAttributes(e)`: nothing.
    fn emit_enum_deserialization_attributes(&mut self, _e: TypeRef) -> Result<()> {
        Ok(())
    }

    // ---- Naming -------------------------------------------------------------

    /// `getNameStyling(convention)`: a **new** namer on every call, as in
    /// TypeScript (so each call is its own naming group).
    fn get_name_styling(&self, convention: NameStyling) -> Namer {
        let acronyms = acronym_style(self.java().options.acronym_style);
        match convention {
            NameStyling::Type => {
                fun_prefix_namer("types", move |n| java_name_style(true, false, n, acronyms))
            }
            NameStyling::Property => fun_prefix_namer("properties", move |n| {
                java_name_style(false, false, n, acronyms)
            }),
            NameStyling::EnumCase => fun_prefix_namer("enum-cases", move |n| {
                java_name_style(true, true, n, acronyms)
            }),
        }
    }

    /// `makeNamesForPropertyGetterAndSetter(c, className, p, jsonName,
    /// name)`: `get_<name>` and `set_<name>`, styled as properties.
    fn make_names_for_property_getter_and_setter(
        &mut self,
        _c: TypeRef,
        _class_name: Name,
        _p: &ClassProperty,
        _json_name: &str,
        name: Name,
    ) -> (Name, Name) {
        let order = self.naming().order(name);
        let getter_namer = self.get_name_styling(NameStyling::Property);
        let getter_name =
            self.naming_mut()
                .dependency_name(Some(&getter_namer), order, move |lookup| {
                    format!("get_{}", lookup(name))
                });
        let setter_namer = self.get_name_styling(NameStyling::Property);
        let setter_name =
            self.naming_mut()
                .dependency_name(Some(&setter_namer), order, move |lookup| {
                    format!("set_{}", lookup(name))
                });
        (getter_name, setter_name)
    }

    /// `fieldOrMethodName(methodName, topLevelName)`.
    fn field_or_method_name(&self, method_name: &str, top_level_name: Name) -> Source {
        if self.top_levels().len() == 1 {
            return method_name.into();
        }
        sl![top_level_name, capitalize(method_name)]
    }

    /// `methodName(prefix, suffix, topLevelName)`.
    fn method_name(&self, prefix: &str, suffix: &str, top_level_name: Name) -> Source {
        if self.top_levels().len() == 1 {
            return sl![prefix, suffix];
        }
        sl![prefix, top_level_name, suffix]
    }

    /// `decoderName(topLevelName)`.
    fn decoder_name(&self, top_level_name: Name) -> Source {
        self.field_or_method_name("fromJsonString", top_level_name)
    }

    /// `encoderName(topLevelName)`.
    fn encoder_name(&self, top_level_name: Name) -> Source {
        self.field_or_method_name("toJsonString", top_level_name)
    }

    /// `readerGetterName(topLevelName)`.
    fn reader_getter_name(&self, top_level_name: Name) -> Source {
        self.method_name("get", "ObjectReader", top_level_name)
    }

    /// `writerGetterName(topLevelName)`.
    fn writer_getter_name(&self, top_level_name: Name) -> Source {
        self.method_name("get", "ObjectWriter", top_level_name)
    }

    // ---- Files ----------------------------------------------------------------

    /// `startFile(basename)`: starts `<basename>.java`; the leading
    /// comments go into the first file.
    fn start_file(&mut self, basename: Source) -> Result<()> {
        assert(
            self.java().current_filename.is_none(),
            "Previous file wasn't finished",
        )?;
        // FIXME: The filenames should actually be Sourcelikes, too
        let basename = self.sourcelike_to_string(&basename)?;
        self.java_mut().current_filename = Some(format!("{basename}.java"));
        // FIXME: Why is this necessary?
        self.ensure_blank_line();
        if !self.java().have_emitted_leading_comments
            && let Some(leading_comments) = self.leading_comments()
        {
            self.emit_comments(leading_comments)?;
            self.ensure_blank_line();
            self.java_mut().have_emitted_leading_comments = true;
        }
        Ok(())
    }

    /// `finishFile()`: finishes the current file.
    fn finish_current_file(&mut self) -> Result<()> {
        let filename = defined(self.java().current_filename.clone())?;
        defaults::finish_file(self, &filename)?;
        self.java_mut().current_filename = None;
        Ok(())
    }

    /// `emitPackageAndImports(imports)`.
    fn emit_package_and_imports(&mut self, imports: &[String]) {
        let package_name = self.java().options.package_name.clone();
        self.emit_line(sl!["package ", package_name, ";"]);
        self.ensure_blank_line();
        for pkg in imports {
            self.emit_line(sl!["import ", pkg, ";"]);
        }
    }

    /// `emitFileHeader(fileName, imports)`.
    fn emit_file_header(&mut self, file_name: Source, imports: &[String]) -> Result<()> {
        self.start_file(file_name)?;
        self.emit_package_and_imports(imports);
        self.ensure_blank_line();
        Ok(())
    }

    // ---- Emitting helpers -----------------------------------------------------

    /// `emitBlock(line, f)`.
    fn emit_block(&mut self, line: Source, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_line(sl![line, " {"]);
        self.indent(f)?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitTryCatch(main, handler, exception)`.
    fn emit_try_catch(
        &mut self,
        main: impl FnOnce(&mut Self) -> Result<()>,
        handler: impl FnOnce(&mut Self) -> Result<()>,
        exception: &str,
    ) -> Result<()> {
        self.emit_line("try {");
        self.indent(main)?;
        self.emit_line(sl!["} catch (", exception, " ex) {"]);
        self.indent(handler)?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitIgnoredTryCatchBlock(f)`.
    fn emit_ignored_try_catch_block(
        &mut self,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_try_catch(
            f,
            |r| {
                r.emit_line("// Ignored");
                Ok(())
            },
            "Exception",
        )
    }

    // ---- Types ------------------------------------------------------------------

    /// `javaType(reference, t, withIssues)`: boxed types with `reference`.
    fn java_type(&self, reference: bool, t: TypeRef, with_issues: bool) -> Result<Source> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        Ok(match ty.kind() {
            TypeKind::Any => maybe_annotated(with_issues, any_type_issue_annotation(), "Object"),
            TypeKind::Null => maybe_annotated(with_issues, null_type_issue_annotation(), "Object"),
            TypeKind::Bool => (if reference { "Boolean" } else { "boolean" }).into(),
            TypeKind::Integer => (if reference { "Long" } else { "long" }).into(),
            TypeKind::Double => (if reference { "Double" } else { "double" }).into(),
            TypeKind::String => "String".into(),
            TypeKind::Array => {
                if self.java().options.use_list {
                    sl![
                        "List<",
                        self.java_type(true, ty.items()?, with_issues)?,
                        ">"
                    ]
                } else {
                    sl![self.java_type(false, ty.items()?, with_issues)?, "[]"]
                }
            }
            TypeKind::Class | TypeKind::Enum => self.name_for_named_type(t)?.into(),
            TypeKind::Map => sl![
                "Map<String, ",
                self.java_type(true, ty.map_values()?, with_issues)?,
                ">"
            ],
            TypeKind::Union => match nullable_from_union(graph, t)? {
                Some(nullable) => self.java_type(true, nullable, with_issues)?,
                None => self.name_for_named_type(t)?.into(),
            },
            kind if kind.is_transformed_string_type_kind() => {
                let provider = &self.java().date_time_provider;
                match kind {
                    TypeKind::Time => provider.time_type().into(),
                    TypeKind::Date => provider.date_type().into(),
                    TypeKind::DateTime => provider.date_time_type().into(),
                    TypeKind::Uuid => "UUID".into(),
                    _ => "String".into(),
                }
            }
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => return type_not_supported(kind),
        })
    }

    /// `javaImport(t)`: the imports `t` needs, in order, with duplicates.
    fn java_import(&self, t: TypeRef) -> Result<Vec<String>> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        let owned = |imports: &[&str]| imports.iter().map(|&i| i.to_owned()).collect();
        Ok(match ty.kind() {
            TypeKind::Any
            | TypeKind::Null
            | TypeKind::Bool
            | TypeKind::Integer
            | TypeKind::Double
            | TypeKind::String
            | TypeKind::Class
            | TypeKind::Enum => Vec::new(),
            TypeKind::Array => {
                let mut imports = self.java_import(ty.items()?)?;
                if self.java().options.use_list {
                    imports.push("java.util.List".to_owned());
                }
                imports
            }
            TypeKind::Map => {
                let mut imports = self.java_import(ty.map_values()?)?;
                imports.push("java.util.Map".to_owned());
                imports
            }
            TypeKind::Union => {
                let mut imports = Vec::new();
                for &member in ty.members()? {
                    imports.extend(self.java_import(member)?);
                }
                imports
            }
            kind if kind.is_transformed_string_type_kind() => {
                let provider = &self.java().date_time_provider;
                match kind {
                    TypeKind::Time => owned(provider.time_imports()),
                    TypeKind::Date => owned(provider.date_imports()),
                    TypeKind::DateTime => owned(provider.date_time_imports()),
                    TypeKind::Uuid => vec!["java.util.UUID".to_owned()],
                    _ => Vec::new(),
                }
            }
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => return type_not_supported(kind),
        })
    }

    /// `javaTypeWithoutGenerics(reference, t)`: the raw type for
    /// `.class` and `TypeReference`s.
    fn java_type_without_generics(&self, reference: bool, t: TypeRef) -> Result<Source> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        match ty.kind() {
            TypeKind::Array => {
                if self.java().options.use_list {
                    return Ok(sl!["List"]);
                }
                Ok(sl![
                    self.java_type_without_generics(false, ty.items()?)?,
                    "[]"
                ])
            }
            TypeKind::Map => Ok("Map".into()),
            TypeKind::Union => match nullable_from_union(graph, t)? {
                Some(nullable) => self.java_type_without_generics(true, nullable),
                None => Ok(self.name_for_named_type(t)?.into()),
            },
            _ => self.java_type(reference, t, false),
        }
    }

    /// `importsForClass(c)`: the property types' imports, sorted and
    /// deduplicated.
    fn imports_for_class(&mut self, c: TypeRef) -> Result<Vec<String>> {
        let mut imports: Vec<String> = Vec::new();
        self.for_each_class_property(c, BlankLinePosition::None, |r, _, _, p, _| {
            imports.extend(r.java_import(p.type_ref)?);
            Ok(())
        })?;
        Ok(sorted_unique(imports))
    }

    /// `importsForUnionMembers(u)`: the non-null members' imports, sorted
    /// and deduplicated.
    fn imports_for_union_members(&mut self, u: TypeRef) -> Result<Vec<String>> {
        let mut imports: Vec<String> = Vec::new();
        let (_, non_nulls) = remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, _, t, _| {
                imports.extend(r.java_import(t)?);
                Ok(())
            },
        )?;
        Ok(sorted_unique(imports))
    }

    // ---- Declarations -----------------------------------------------------------

    /// `emitClassDefinition(c, className)`.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let mut imports = self.imports_for_type(c)?;
        imports.extend(self.imports_for_class(c)?);

        self.emit_file_header(class_name.into(), &imports)?;
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_class_attributes(c, class_name)?;
        let lombok = self.java().options.lombok;
        let lombok_copy_annotations = self.java().options.lombok_copy_annotations;
        let has_empty_property = self.type_graph().type_at(c)?.properties()?.contains_key("");
        self.emit_block(sl!["public class ", class_name], |r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
                if lombok && lombok_copy_annotations {
                    let getter =
                        r.annotations_for_accessor(c, class_name, name, json_name, &p, false)?;
                    let setter =
                        r.annotations_for_accessor(c, class_name, name, json_name, &p, true)?;
                    if !getter.is_empty() {
                        r.emit_line(format!(
                            "@lombok.Getter(onMethod_ = {{{}}})",
                            getter.join(", ")
                        ));
                    }
                    if !setter.is_empty() {
                        r.emit_line(format!(
                            "@lombok.Setter(onMethod_ = {{{}}})",
                            setter.join(", ")
                        ));
                    }
                }
                let java_type = r.java_type(false, p.type_ref, true)?;
                r.emit_line(sl!["private ", java_type, " ", name, ";"]);
                Ok(())
            })?;
            if !lombok || has_empty_property {
                r.for_each_class_property(
                    c,
                    BlankLinePosition::LeadingAndInterposing,
                    |r, name, json_name, p, _| {
                        if lombok && !json_name.is_empty() {
                            return Ok(());
                        }
                        let description = r.description_for_class_property(c, json_name)?;
                        r.emit_description(description)?;
                        let (getter_name, setter_name) = defined(
                            r.java()
                                .getters_and_setters_for_property_name
                                .get(&name)
                                .copied(),
                        )?;
                        let rendered = r.java_type(false, p.type_ref, false)?;
                        if json_name.is_empty() {
                            r.emit_line("@JsonAnyGetter");
                            r.emit_line(sl![
                                "public java.util.Map<String, Object> ",
                                getter_name,
                                "() { return java.util.Collections.<String, Object>singletonMap(\"\", ",
                                name,
                                "); }"
                            ]);
                            r.emit_line("@JsonAnySetter");
                            r.emit_line(sl![
                                "public void setEmpty(String key, ",
                                rendered,
                                " value) { if (key.isEmpty()) this.",
                                name,
                                " = value; }"
                            ]);
                            return Ok(());
                        }
                        for annotation in
                            r.annotations_for_accessor(c, class_name, name, json_name, &p, false)?
                        {
                            r.emit_line(annotation);
                        }
                        r.emit_line(sl![
                            "public ",
                            rendered.clone(),
                            " ",
                            getter_name,
                            "() { return ",
                            name,
                            "; }"
                        ]);
                        for annotation in
                            r.annotations_for_accessor(c, class_name, name, json_name, &p, true)?
                        {
                            r.emit_line(annotation);
                        }
                        r.emit_line(sl![
                            "public void ",
                            setter_name,
                            "(",
                            rendered,
                            " value) { this.",
                            name,
                            " = value; }"
                        ]);
                        Ok(())
                    },
                )?;
            }
            Ok(())
        })?;
        self.finish_current_file()
    }

    /// `unionField(u, t, withIssues)`.
    fn union_field(&self, u: TypeRef, t: TypeRef, with_issues: bool) -> Result<UnionField> {
        let field_type = self.java_type(true, t, with_issues)?;
        // FIXME: "Value" should be part of the name.
        let field_name = sl![self.name_for_union_member(u, t)?, "Value"];
        Ok(UnionField {
            field_name,
            field_type,
        })
    }

    /// `emitUnionDefinition(u, unionName)`.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let mut imports = self.imports_for_type(u)?;
        imports.extend(self.imports_for_union_members(u)?);

        self.emit_file_header(union_name.into(), &imports)?;
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        let (_, non_nulls) = remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;

        self.emit_union_attributes(u, union_name)?;
        self.emit_block(sl!["public class ", union_name], |r| {
            for &t in &non_nulls {
                let UnionField {
                    field_name,
                    field_type,
                } = r.union_field(u, t, true)?;
                r.emit_line(sl!["public ", field_type, " ", field_name, ";"]);
            }
            r.emit_union_serializer(u, union_name)
        })?;
        self.finish_current_file()
    }

    /// `emitEnumDefinition(e, enumName)`.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let imports = self.imports_for_type(e)?;
        self.emit_file_header(enum_name.into(), &imports)?;
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        let mut case_names: Vec<Source> = Vec::new();
        self.for_each_enum_case(e, BlankLinePosition::None, |_, name, _, _| {
            if !case_names.is_empty() {
                case_names.push(", ".into());
            }
            case_names.push(name.into());
            Ok(())
        })?;
        case_names.push(";".into());
        self.emit_block(sl!["public enum ", enum_name], |r| {
            r.emit_line(case_names);
            r.ensure_blank_line();

            r.emit_enum_serialization_attributes(e)?;
            r.emit_block("public String toValue()".into(), |r| {
                r.emit_line("switch (this) {");
                r.indent(|r| {
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        r.emit_line(sl![
                            "case ",
                            name,
                            ": return \"",
                            string_escape(json_name),
                            "\";"
                        ]);
                        Ok(())
                    })
                })?;
                r.emit_line("}");
                r.emit_line("return null;");
                Ok(())
            })?;
            r.ensure_blank_line();

            r.emit_enum_deserialization_attributes(e)?;
            r.emit_block(
                sl![
                    "public static ",
                    enum_name,
                    " forValue(String value) throws IOException"
                ],
                |r| {
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        r.emit_line(sl![
                            "if (value.equals(\"",
                            string_escape(json_name),
                            "\")) return ",
                            name,
                            ";"
                        ]);
                        Ok(())
                    })?;
                    r.emit_line(sl![
                        "throw new IOException(\"Cannot deserialize ",
                        enum_name,
                        "\");"
                    ]);
                    Ok(())
                },
            )
        })?;
        self.finish_current_file()
    }
}

/// The `ConvenienceRenderer` hooks TS `JavaRenderer` overrides; the rest
/// are the framework defaults.
pub mod java_hooks {
    pub use crate::convenience_renderer::defaults::*;

    use super::{JavaRenderer, NameStyling};
    use crate::convenience_renderer::prelude::*;
    use crate::support::comments::CommentOptions;
    use crate::ty::type_utils::{directly_reachable_single_named_type, nullable_from_union};

    use super::super::constants::JAVA_KEYWORDS;

    /// `forbiddenNamesForGlobalNamespace()`: the keywords, the converter's
    /// names and the date-time provider's.
    pub fn forbidden_names_for_global_namespace<'a, R: JavaRenderer<'a>>(
        r: &mut R,
    ) -> Result<Vec<String>> {
        let mut keywords: Vec<String> = JAVA_KEYWORDS.iter().map(|&k| k.to_owned()).collect();
        keywords.extend(r.converter_keywords().iter().map(|&k| k.to_owned()));
        keywords.push(r.java().converter_classname.to_owned());
        keywords.extend(
            r.java()
                .date_time_provider
                .keywords()
                .iter()
                .map(|&k| k.to_owned()),
        );
        Ok(keywords)
    }

    /// `forbiddenForObjectProperties(c, className)`.
    pub fn forbidden_for_object_properties<'a, R: JavaRenderer<'a>>(
        _r: &mut R,
        _c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    /// `makeNamedTypeNamer()`: type names are also file names, so they
    /// must differ in more than case.
    pub fn make_named_type_namer<'a, R: JavaRenderer<'a>>(r: &mut R) -> Namer {
        let namer = r.get_name_styling(NameStyling::Type);
        Namer::new(
            namer.name(),
            {
                let style = namer.style_function();
                move |s: &str| style(s)
            },
            namer.prefixes().to_vec(),
            true,
        )
    }

    /// `namerForObjectProperty()`.
    pub fn namer_for_object_property<'a, R: JavaRenderer<'a>>(
        r: &mut R,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(r.get_name_styling(NameStyling::Property)))
    }

    /// `makeUnionMemberNamer()`.
    pub fn make_union_member_namer<'a, R: JavaRenderer<'a>>(r: &mut R) -> Option<Namer> {
        Some(r.get_name_styling(NameStyling::Property))
    }

    /// `makeEnumCaseNamer()`.
    pub fn make_enum_case_namer<'a, R: JavaRenderer<'a>>(r: &mut R) -> Option<Namer> {
        Some(r.get_name_styling(NameStyling::EnumCase))
    }

    /// `unionNeedsName(u)`: every union except `T | null`.
    pub fn union_needs_name<'a, R: JavaRenderer<'a>>(r: &R, u: TypeRef) -> Result<bool> {
        Ok(nullable_from_union(r.type_graph(), u)?.is_none())
    }

    /// `namedTypeToNameForTopLevel(type)`: if the top-level doesn't contain
    /// any classes or unions we have to define a class just for the
    /// `FromJson` method, in emitFromJsonForTopLevel.
    pub fn named_type_to_name_for_top_level<'a, R: JavaRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Option<TypeRef>> {
        directly_reachable_single_named_type(r.type_graph(), t)
    }

    /// `makePropertyDependencyNames(c, className, p, jsonName, name)`: the
    /// getter and setter names, remembered for emitting.
    pub fn make_property_dependency_names<'a, R: JavaRenderer<'a>>(
        r: &mut R,
        c: TypeRef,
        class_name: Name,
        p: &ClassProperty,
        json_name: &str,
        name: Name,
    ) -> Result<Vec<Name>> {
        let (getter, setter) =
            r.make_names_for_property_getter_and_setter(c, class_name, p, json_name, name);
        r.java_mut()
            .getters_and_setters_for_property_name
            .insert(name, (getter, setter));
        Ok(vec![getter, setter])
    }

    /// `emitDescriptionBlock(lines)`: a Javadoc comment.
    pub fn emit_description_block<'a, R: JavaRenderer<'a>>(
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

    /// `finishFile()`: TS `JavaRenderer` overrides `finishFile(filename)`
    /// without the parameter, so the file is always the current one (also
    /// when `render` finishes a non-empty context).
    pub fn finish_file<'a, R: JavaRenderer<'a>>(r: &mut R, _filename: &str) -> Result<()> {
        r.finish_current_file()
    }

    /// `emitSourceStructure()`: one file per named type.
    pub fn emit_source_structure<'a, R: JavaRenderer<'a>>(
        r: &mut R,
        _given_output_filename: &str,
    ) -> Result<()> {
        r.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| r.emit_class_definition(c, n),
            |r, e, n, _| r.emit_enum_definition(e, n),
            |r, u, n, _| r.emit_union_definition(u, n),
        )
    }
}

/// TS `JavaRenderer` itself: plain Java classes (`--just-types`).
pub struct JavaPlainRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    java: JavaState,
}

impl std::fmt::Debug for JavaPlainRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("JavaPlainRenderer")
            .field("java", &self.java)
            .finish_non_exhaustive()
    }
}

impl<'a> JavaPlainRenderer<'a> {
    /// `new JavaRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: JavaOptions,
    ) -> Self {
        JavaPlainRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            java: JavaState::new(options),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for JavaPlainRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(java_hooks);
}

impl<'a> JavaRenderer<'a> for JavaPlainRenderer<'a> {
    fn java(&self) -> &JavaState {
        &self.java
    }

    fn java_mut(&mut self) -> &mut JavaState {
        &mut self.java
    }
}
