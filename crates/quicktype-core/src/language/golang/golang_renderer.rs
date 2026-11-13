//! Port of `packages/quicktype-core/src/language/Golang/GolangRenderer.ts`.
//!
//! Renders Go structs with aligned field tags, string enums with an
//! `UnmarshalJSON` check, and unions as structs of pointers with the
//! `unmarshalUnion`/`marshalUnion` helpers; optionally one file per type
//! (`--multi-file-output`).

use std::cell::OnceCell;

use indexmap::{IndexMap, IndexSet};

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::prelude::*;
use crate::naming::Names;
use crate::renderer_options::RendererOptions;
use crate::support::recursion::guard;
use crate::support::strings::{camel_case, string_escape};
use crate::support::support::{assert, defined};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, find_member, nullable_from_union, remove_null_from_union,
};

use super::language::{
    ENUM_TYPE_NAME_SUFFIX, FIELD_TAGS, JUST_TYPES, JUST_TYPES_AND_PACKAGE, MULTI_FILE_OUTPUT,
    OMIT_EMPTY, PACKAGE_NAME,
};
use super::utils::{
    COMPOUND_TYPE_KINDS, PRIMITIVE_VALUE_TYPE_KINDS, can_omit_empty, is_value_type, naming_function,
};

/// The option values of the Go renderer (TS
/// `OptionValues<typeof goOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct GoOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `justTypesAndPackage`.
    pub just_types_and_package: bool,
    /// `packageName`.
    pub package_name: String,
    /// `multiFileOutput`.
    pub multi_file_output: bool,
    /// `fieldTags`.
    pub field_tags: String,
    /// `omitEmpty`.
    pub omit_empty: bool,
    /// `enumTypeNameSuffix`.
    pub enum_type_name_suffix: bool,
}

impl GoOptions {
    /// `getOptionValues(goOptions, values)`, in declaration order.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        Ok(GoOptions {
            just_types: JUST_TYPES.get_value(values),
            just_types_and_package: JUST_TYPES_AND_PACKAGE.get_value(values),
            package_name: PACKAGE_NAME.get_value(values).into_owned(),
            multi_file_output: MULTI_FILE_OUTPUT.get_value(values),
            field_tags: FIELD_TAGS.get_value(values).into_owned(),
            omit_empty: OMIT_EMPTY.get_value(values),
            enum_type_name_suffix: ENUM_TYPE_NAME_SUFFIX.get_value(values),
        })
    }
}

/// A union member found by kind (TS `ifMember`'s callback arguments): the
/// member and its field name. TypeScript also passes the member's Go type,
/// which only `var c` uses; it is computed there, from the same type.
struct UnionMember {
    t: TypeRef,
    field_name: Name,
}

/// `GoRenderer`.
pub struct GoRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: GoOptions,
    /// `namingFunction` (a module-level singleton in TypeScript, shared by
    /// every kind of name).
    naming_function: Namer,
    /// `_topLevelUnmarshalNames`.
    top_level_unmarshal_names: IndexMap<Name, Name>,
    /// `_currentFilename`.
    current_filename: Option<String>,
    /// The children of every non-nullable union (`emitEnum` asks whether an
    /// enum is one), computed once.
    non_nullable_union_children: OnceCell<IndexSet<TypeRef>>,
}

impl std::fmt::Debug for GoRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("GoRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// JavaScript's `String(sourcelike)` (`Array.prototype.toString`): strings
/// as they are, arrays as their elements joined with `,`, every other
/// source object (a `Name`, an annotation, ...) as `[object Object]`.
/// The import detection compares these strings.
fn js_to_string(source: &Source) -> String {
    match source {
        Source::Text(s) => s.clone(),
        Source::Sequence(parts) => parts.iter().map(js_to_string).collect::<Vec<_>>().join(","),
        _ => "[object Object]".to_owned(),
    }
}

/// The imports for the JavaScript strings of the Go types in `used_types`
/// (see [`js_to_string`]): `time` if one of them is in `time_types`.
fn imports_for(used_types: &IndexSet<String>, time_types: &[&str]) -> IndexSet<String> {
    let mut imports = IndexSet::new();
    if used_types.iter().any(|k| time_types.contains(&k.as_str())) {
        imports.insert("time".to_owned());
    }
    imports
}

/// The imports of a class (`collectClassImports`' mapping, which `emitClass`
/// repeats): `time` for a `time.Time` property, a pointer to one or a slice
/// of them. An optional slice (`"*,[],time.Time"`) or a map of them is
/// missed, as in TypeScript.
fn class_imports(used_types: &IndexSet<String>) -> IndexSet<String> {
    imports_for(used_types, &["time.Time", "*,time.Time", "[],time.Time"])
}

impl<'a> GoRenderer<'a> {
    /// `new GoRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: GoOptions,
    ) -> Self {
        GoRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            naming_function: naming_function(),
            top_level_unmarshal_names: IndexMap::new(),
            current_filename: None,
            non_nullable_union_children: OnceCell::new(),
        }
    }

    /// `justTypes || justTypesAndPackage`.
    fn just_types_any(&self) -> bool {
        self.options.just_types || self.options.just_types_and_package
    }

    /// `_topLevelUnmarshalNames.get(name)`, which must exist.
    fn unmarshal_name(&self, name: Name) -> Result<Name> {
        defined(self.top_level_unmarshal_names.get(&name).copied())
    }

    /// `startFile(basename)`: starts `<basename>.go` with
    /// `--multi-file-output`.
    fn start_file(&mut self, basename: Source) -> Result<()> {
        if !self.options.multi_file_output {
            return Ok(());
        }

        assert(
            self.current_filename.is_none(),
            &format!(
                "Previous file wasn't finished: {}",
                self.current_filename.as_deref().unwrap_or("undefined")
            ),
        )?;
        let filename = format!("{}.go", self.sourcelike_to_string(&basename)?);
        self.initialize_emit_context_for_filename(&filename);
        self.current_filename = Some(filename);
        Ok(())
    }

    /// `endFile()`: finishes the current file with `--multi-file-output`.
    fn end_file(&mut self) -> Result<()> {
        if !self.options.multi_file_output {
            return Ok(());
        }

        let filename = defined(self.current_filename.clone())?;
        self.finish_file(&filename)?;
        self.current_filename = None;
        Ok(())
    }

    /// `emitBlock(line, f)`.
    fn emit_block(&mut self, line: Source, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_line(sl![line, " {"]);
        self.indent(f)?;
        self.emit_line("}");
        Ok(())
    }

    /// `emitFunc(decl, f)`.
    fn emit_func(&mut self, decl: Source, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_block(sl!["func ", decl], f)
    }

    /// `emitStruct(name, table)`.
    fn emit_struct(&mut self, name: Name, table: Vec<Vec<Source>>) -> Result<()> {
        self.emit_block(sl!["type ", name, " struct"], |r| {
            r.emit_table(table);
            Ok(())
        })
    }

    /// `nullableGoType(t, withIssues)`: a pointer to value types.
    fn nullable_go_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        let go_type = self.go_type(t, with_issues)?;
        if is_value_type(self.type_graph().kind(t)?) {
            return Ok(sl!["*", go_type]);
        }

        Ok(go_type)
    }

    /// `propertyGoType(cp)`.
    fn property_go_type(&self, cp: &ClassProperty) -> Result<Source> {
        let graph = self.type_graph();
        let t = cp.type_ref;
        let kind = graph.kind(t)?;
        if cp.is_optional && (kind == TypeKind::Array || kind == TypeKind::Map) {
            return Ok(sl!["*", self.go_type(t, true)?]);
        }

        if kind == TypeKind::Union && nullable_from_union(graph, t)?.is_none() {
            return Ok(sl!["*", self.go_type(t, true)?]);
        }

        if cp.is_optional {
            return self.nullable_go_type(t, true);
        }

        self.go_type(t, true)
    }

    /// `goType(t, withIssues)`.
    fn go_type(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => {
                    maybe_annotated(with_issues, any_type_issue_annotation(), "interface{}")
                }
                TypeKind::Null => {
                    maybe_annotated(with_issues, null_type_issue_annotation(), "interface{}")
                }
                TypeKind::Bool => "bool".into(),
                TypeKind::Integer => "int64".into(),
                TypeKind::Double => "float64".into(),
                TypeKind::String => "string".into(),
                TypeKind::Array => sl!["[]", self.go_type(ty.items()?, with_issues)?],
                TypeKind::Class | TypeKind::Enum => self.name_for_named_type(t)?.into(),
                TypeKind::Map => {
                    let v = ty.map_values()?;
                    let value_source = if graph.kind(v)? == TypeKind::Union
                        && nullable_from_union(graph, v)?.is_none()
                    {
                        sl!["*", self.name_for_named_type(v)?]
                    } else {
                        self.go_type(v, with_issues)?
                    };
                    sl!["map[string]", value_source]
                }
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.nullable_go_type(nullable, with_issues);
                    }
                    self.name_for_named_type(t)?.into()
                }
                TypeKind::DateTime => "time.Time".into(),
                kind if kind.is_transformed_string_type_kind() => "string".into(),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `ifMember(kind, ...)`: the member of `u` of kind `kind`, with its
    /// field name and Go type, if there is one.
    fn union_member(&self, u: TypeRef, kind: TypeKind) -> Result<Option<UnionMember>> {
        let Some(t) = find_member(self.type_graph(), u, kind)? else {
            return Ok(None);
        };
        Ok(Some(UnionMember {
            t,
            field_name: self.name_for_union_member(u, t)?,
        }))
    }

    /// `makeArgs(primitiveArg, compoundArg)`: the arguments of
    /// `unmarshalUnion`/`marshalUnion` for the union `u`.
    fn make_args(
        &self,
        u: TypeRef,
        is_nullable_arg: &str,
        primitive_arg: impl Fn(Name) -> Source,
        compound_arg: impl Fn(bool, Name) -> Source,
    ) -> Result<Source> {
        let mut args: Vec<Source> = Vec::new();
        for kind in PRIMITIVE_VALUE_TYPE_KINDS {
            args.push(match self.union_member(u, kind)? {
                None => "nil".into(),
                Some(m) => primitive_arg(m.field_name),
            });
            args.push(", ".into());
        }

        for kind in COMPOUND_TYPE_KINDS {
            args.push(match self.union_member(u, kind)? {
                None => "false, nil".into(),
                Some(m) => {
                    let is_class = self.type_graph().kind(m.t)? == TypeKind::Class;
                    compound_arg(is_class, m.field_name)
                }
            });
            args.push(", ".into());
        }

        args.push(is_nullable_arg.into());
        Ok(Source::Sequence(args))
    }

    /// `emitTopLevel(t, name)`.
    fn emit_top_level(&mut self, t: TypeRef, name: Name) -> Result<()> {
        self.start_file(name.into())?;

        if self.options.multi_file_output && !self.just_types_any() {
            if let Some(leading_comments) = self.leading_comments() {
                self.emit_comments(leading_comments)?;
            } else {
                self.emit_line_once(vec![
                    "// Code generated from JSON Schema using quicktype. DO NOT EDIT.".into(),
                ]);
                self.emit_line_once(vec![
                    "// To parse and unparse this JSON data, add this code to your project and do:"
                        .into(),
                ]);
                self.emit_line_once(vec!["//".into()]);
                let reference = modify_source(camel_case, name);
                let unmarshal_name = self.unmarshal_name(name)?;
                self.emit_line_once(vec![
                    "//    ".into(),
                    reference.clone(),
                    ", err := ".into(),
                    unmarshal_name.into(),
                    "(bytes)".into(),
                ]);
                self.emit_line_once(vec![
                    "//    bytes, err = ".into(),
                    reference,
                    ".Marshal()".into(),
                ]);
            }
        }

        let imports = match self.type_graph().kind(t)? {
            TypeKind::Class => Some(self.collect_class_imports(t)?),
            TypeKind::Union => Some(self.collect_union_imports(t)?),
            _ => None,
        };
        self.emit_package_definitions(true, imports)?;

        let unmarshal_name = self.unmarshal_name(name)?;
        if self.named_type_to_name_for_top_level(t)?.is_none() {
            let go_type = self.go_type(t, false)?;
            self.emit_line(sl!["type ", name, " ", go_type]);
        }

        if self.just_types_any() {
            return Ok(());
        }

        self.ensure_blank_line();
        self.emit_func(
            sl![unmarshal_name, "(data []byte) (", name, ", error)"],
            |r| {
                r.emit_line(sl!["var r ", name]);
                r.emit_line("err := json.Unmarshal(data, &r)");
                r.emit_line("return r, err");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        self.emit_func(sl!["(r *", name, ") Marshal() ([]byte, error)"], |r| {
            r.emit_line("return json.Marshal(r)");
            Ok(())
        })?;
        self.end_file()
    }

    /// `emitClass(c, className)`.
    fn emit_class(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.start_file(class_name.into())?;
        let mut columns: Vec<Vec<Source>> = Vec::new();
        let mut used_types: IndexSet<String> = IndexSet::new();
        self.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
            let description = r.description_for_class_property(c, json_name)?;
            let doc_strings: Vec<String> = match description {
                Some(lines) if !lines.is_empty() => {
                    lines.iter().map(|d| format!("// {d}")).collect()
                }
                _ => Vec::new(),
            };
            let go_type = r.property_go_type(&p)?;
            let kind = r.type_graph().kind(p.type_ref)?;
            // `${omitEmpty}` of `[]` is the empty string.
            let omit_empty = if can_omit_empty(p.is_optional, kind, r.options.omit_empty) {
                ",omitempty"
            } else {
                ""
            };

            for doc in doc_strings {
                columns.push(vec![doc.into()]);
            }
            let escaped = string_escape(json_name);
            let tags = r
                .options
                .field_tags
                .split(',')
                .map(|tag| format!("{tag}:\"{escaped}{omit_empty}\""))
                .collect::<Vec<_>>()
                .join(" ");
            used_types.insert(js_to_string(&go_type));
            columns.push(vec![sl![name, " "], sl![go_type, " "], sl!["`", tags, "`"]]);
            Ok(())
        })?;

        // TS: `new Set(["time"])` or the default empty set.
        self.emit_package_definitions(false, Some(class_imports(&used_types)))?;
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_struct(class_name, columns)?;
        self.end_file()
    }

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.start_file(enum_name.into())?;
        self.emit_package_definitions(true, None)?;
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl!["type ", enum_name, " string"]);
        self.ensure_blank_line();
        self.emit_line("const (");
        let mut columns: Vec<Vec<Source>> = Vec::new();
        let mut cases: Vec<String> = Vec::new();
        self.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
            cases.push(r.sourcelike_to_string(&name.into())?);
            columns.push(vec![
                sl![name, " "],
                sl![enum_name, " = \"", string_escape(json_name), "\""],
            ]);
            Ok(())
        })?;
        self.indent(|r| {
            r.emit_table(columns);
            Ok(())
        })?;
        self.emit_line(")");
        let type_name = self.sourcelike_to_string(&enum_name.into())?;
        if self.non_nullable_union_children()?.contains(&e) {
            return self.end_file();
        }
        self.ensure_blank_line();
        let cases = cases.join(", ");
        self.emit_multiline(&format!(
            r#"type invalid{type_name} string
func (x invalid{type_name}) Error() string {{ return "invalid {type_name}: " + string(x) }}

func (x *{type_name}) UnmarshalJSON(data []byte) error {{
    var value string
    if err := json.Unmarshal(data, &value); err != nil {{ return err }}
    switch {type_name}(value) {{
    case {cases}: *x = {type_name}(value); return nil
    }}
    return invalid{type_name}(value)
}}"#
        ))?;
        self.end_file()
    }

    /// The children of every non-nullable union in the graph: TypeScript's
    /// `allTypes.some((t) => t instanceof UnionType &&
    /// nullableFromUnion(t) === null && t.getChildren().has(e))` for every
    /// enum `e` at once.
    fn non_nullable_union_children(&self) -> Result<&IndexSet<TypeRef>> {
        if let Some(children) = self.non_nullable_union_children.get() {
            return Ok(children);
        }
        let graph = self.type_graph();
        let mut children = IndexSet::new();
        for t in graph.all_types_unordered() {
            if graph.kind(t)? == TypeKind::Union && nullable_from_union(graph, t)?.is_none() {
                children.extend(graph.children(t)?);
            }
        }
        Ok(self.non_nullable_union_children.get_or_init(|| children))
    }

    /// `emitUnion(u, unionName)`.
    fn emit_union(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        self.start_file(union_name.into())?;
        let imports = self.collect_union_imports(u)?;
        self.emit_package_definitions(false, Some(imports))?;
        let (has_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        let is_nullable_arg = if has_null.is_some() { "true" } else { "false" };

        let mut columns: Vec<Vec<Source>> = Vec::new();
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, field_name, t, _| {
                let go_type = r.nullable_go_type(t, true)?;
                columns.push(vec![sl![field_name, " "], go_type]);
                Ok(())
            },
        )?;
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        self.emit_struct(union_name, columns)?;

        if self.just_types_any() {
            return Ok(());
        }

        self.ensure_blank_line();
        self.emit_func(
            sl!["(x *", union_name, ") UnmarshalJSON(data []byte) error"],
            |r| {
                for kind in COMPOUND_TYPE_KINDS {
                    // `maybeAssignNil(kind)`.
                    if let Some(m) = r.union_member(u, kind)? {
                        r.emit_line(sl!["x.", m.field_name, " = nil"]);
                    }
                }

                if let Some(m) = r.union_member(u, TypeKind::Class)? {
                    let go_type = r.go_type(m.t, false)?;
                    r.emit_line(sl!["var c ", go_type]);
                }
                let args = r.make_args(
                    u,
                    is_nullable_arg,
                    |field_name| sl!["&x.", field_name],
                    |is_class, field_name| {
                        if is_class {
                            "true, &c".into()
                        } else {
                            sl!["true, &x.", field_name]
                        }
                    },
                )?;
                r.emit_line(sl!["object, err := unmarshalUnion(data, ", args, ")"]);
                r.emit_block("if err != nil".into(), |r| {
                    r.emit_line("return err");
                    Ok(())
                })?;
                r.emit_block("if object".into(), |r| {
                    if let Some(m) = r.union_member(u, TypeKind::Class)? {
                        r.emit_line(sl!["x.", m.field_name, " = &c"]);
                    }
                    Ok(())
                })?;
                r.emit_line("return nil");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        self.emit_func(
            sl!["(x *", union_name, ") MarshalJSON() ([]byte, error)"],
            |r| {
                let args = r.make_args(
                    u,
                    is_nullable_arg,
                    |field_name| sl!["x.", field_name],
                    |_, field_name| sl!["x.", field_name, " != nil, x.", field_name],
                )?;
                r.emit_line(sl!["return marshalUnion(", args, ")"]);
                Ok(())
            },
        )?;
        self.end_file()
    }

    /// `emitSingleFileHeaderComments()`.
    fn emit_single_file_header_comments(&mut self) -> Result<()> {
        self.emit_line_once(vec![
            "// Code generated from JSON Schema using quicktype. DO NOT EDIT.".into(),
        ]);
        self.emit_line_once(vec![
            "// To parse and unparse this JSON data, add this code to your project and do:".into(),
        ]);
        self.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
            r.emit_line("//");
            let reference = modify_source(camel_case, name);
            let unmarshal_name = r.unmarshal_name(name)?;
            r.emit_line(sl![
                "//    ",
                reference.clone(),
                ", err := ",
                unmarshal_name,
                "(bytes)"
            ]);
            r.emit_line(sl!["//    bytes, err = ", reference, ".Marshal()"]);
            Ok(())
        })?;
        Ok(())
    }

    /// `emitPackageDefinitons(includeJSONEncodingImport, imports)` (sic);
    /// `None` is the default `new Set()`.
    fn emit_package_definitions(
        &mut self,
        include_json_encoding_import: bool,
        imports: Option<IndexSet<String>>,
    ) -> Result<()> {
        let mut imports = imports.unwrap_or_default();
        if !self.options.just_types || self.options.just_types_and_package {
            self.ensure_blank_line();
            let package_declaration = format!("package {}", self.options.package_name);
            self.emit_line_once(vec![package_declaration.into()]);
            self.ensure_blank_line();
        }

        if !self.options.just_types && !self.options.just_types_and_package {
            if self.have_named_unions()? && !self.options.multi_file_output {
                imports.insert("bytes".to_owned());
                imports.insert("errors".to_owned());
            }

            if include_json_encoding_import {
                imports.insert("encoding/json".to_owned());
            }
        }

        self.emit_imports(imports);
        Ok(())
    }

    /// `emitImports(imports)`. TypeScript sorts with `localeCompare`; the
    /// only imports are `bytes`, `encoding/json`, `errors` and `time`, made
    /// of lower-case ASCII letters and `/`, which ICU's root collation orders
    /// like their code points (punctuation before letters), so a plain sort
    /// gives the same order. The codebase has no general `localeCompare`.
    fn emit_imports(&mut self, imports: IndexSet<String>) {
        let mut sorted_imports: Vec<String> = imports.into_iter().collect();
        debug_assert!(
            sorted_imports
                .iter()
                .all(|i| i.bytes().all(|b| b.is_ascii_lowercase() || b == b'/')),
            "Go imports outside the localeCompare-compatible alphabet: {sorted_imports:?}"
        );
        sorted_imports.sort();

        if sorted_imports.is_empty() {
            return;
        }

        for package_name in sorted_imports {
            self.emit_line_once(vec![format!("import \"{package_name}\"").into()]);
        }
        self.ensure_blank_line();
    }

    /// `emitHelperFunctions()`: `unmarshalUnion` and `marshalUnion`, if
    /// there are named unions.
    fn emit_helper_functions(&mut self) -> Result<()> {
        if self.have_named_unions()? {
            self.start_file("JSONSchemaSupport".into())?;
            let mut imports = IndexSet::new();
            if self.options.multi_file_output {
                imports.insert("bytes".to_owned());
                imports.insert("errors".to_owned());
            }

            self.emit_package_definitions(true, Some(imports))?;
            self.ensure_blank_line();
            self.emit_multiline(UNION_HELPERS)?;
            self.end_file()?;
        }
        Ok(())
    }

    /// `collectAllImports()`: the imports of every class and union.
    fn collect_all_imports(&mut self) -> Result<IndexSet<String>> {
        let mut imports: IndexSet<String> = IndexSet::new();
        self.for_each_object(BlankLinePosition::LeadingAndInterposing, |r, c, _, _| {
            imports.extend(r.collect_class_imports(c)?);
            Ok(())
        })?;

        self.for_each_union(BlankLinePosition::LeadingAndInterposing, |r, u, _, _| {
            imports.extend(r.collect_union_imports(u)?);
            Ok(())
        })?;
        Ok(imports)
    }

    /// `collectClassImports(c)`: `time` if a property is `time.Time`, a
    /// pointer to it or a slice of it (judged by the JavaScript string of
    /// its Go type).
    fn collect_class_imports(&mut self, c: TypeRef) -> Result<IndexSet<String>> {
        let mut used_types: IndexSet<String> = IndexSet::new();
        self.for_each_class_property(c, BlankLinePosition::None, |r, _, _, p, _| {
            let go_type = r.property_go_type(&p)?;
            used_types.insert(js_to_string(&go_type));
            Ok(())
        })?;

        Ok(class_imports(&used_types))
    }

    /// `collectUnionImports(u)`: `time` if a member is `time.Time` or a
    /// pointer to it.
    fn collect_union_imports(&mut self, u: TypeRef) -> Result<IndexSet<String>> {
        let mut used_types: IndexSet<String> = IndexSet::new();
        self.for_each_union_member(u, None, BlankLinePosition::None, None, |r, _, t, _| {
            let go_type = r.nullable_go_type(t, true)?;
            used_types.insert(js_to_string(&go_type));
            Ok(())
        })?;

        Ok(imports_for(&used_types, &["time.Time", "*,time.Time"]))
    }
}

impl<'a> ConvenienceRenderer<'a> for GoRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.naming_function.clone()
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.naming_function.clone()))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.naming_function.clone())
    }

    /// `MarshalJSON` and `UnmarshalJSON` are the union's methods, unless
    /// only types are rendered.
    fn forbidden_for_union_members(
        &mut self,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: if self.just_types_any() {
                Vec::new()
            } else {
                vec!["MarshalJSON".into(), "UnmarshalJSON".into()]
            },
            include_global_forbidden: false,
        })
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.naming_function.clone())
    }

    fn enum_cases_in_global_namespace(&self) -> bool {
        true
    }

    /// With `enum-type-name-suffix`, the default name's first proposal,
    /// styled, followed by `_<enum name>` (a dependency name).
    fn make_name_for_enum_case(
        &mut self,
        e: TypeRef,
        enum_name: Name,
        case_name: &str,
        assigned_name: Option<&str>,
    ) -> Result<Name> {
        let name = defaults::make_name_for_enum_case(self, e, enum_name, case_name, assigned_name)?;
        if !self.options.enum_type_name_suffix {
            return Ok(name);
        }

        let namer = self.naming().naming_function(name)?.clone();
        let first_proposed = self.naming().first_proposed_name(name, &Names::new())?;
        let proposed_name = namer.name_style(&first_proposed);
        let order = self.naming().order(name);
        Ok(self
            .naming_mut()
            .dependency_name(Some(&namer), order, move |lookup| {
                format!("{proposed_name}_{}", lookup(enum_name))
            }))
    }

    /// `unmarshal_<top-level name>`.
    fn make_top_level_dependency_names(
        &mut self,
        _t: TypeRef,
        top_level_name: Name,
    ) -> Result<Vec<Name>> {
        let namer = self.naming_function.clone();
        let order = self.naming().order(top_level_name);
        let unmarshal_name =
            self.naming_mut()
                .dependency_name(Some(&namer), order, move |lookup| {
                    format!("unmarshal_{}", lookup(top_level_name))
                });
        self.top_level_unmarshal_names
            .insert(top_level_name, unmarshal_name);
        Ok(vec![unmarshal_name])
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        if !self.options.multi_file_output && !self.just_types_any() {
            if let Some(leading_comments) = self.leading_comments() {
                self.emit_comments(leading_comments)?;
            } else {
                self.emit_single_file_header_comments()?;
            }
            let imports = self.collect_all_imports()?;
            self.emit_package_definitions(false, Some(imports))?;
        }

        let just_types = self.just_types_any();
        self.for_each_top_level_where(
            BlankLinePosition::LeadingAndInterposing,
            |r, t| Ok(!just_types || r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, name, _| r.emit_top_level(t, name),
        )?;
        self.for_each_object(BlankLinePosition::LeadingAndInterposing, |r, c, name, _| {
            r.emit_class(c, name)
        })?;
        self.for_each_enum(BlankLinePosition::LeadingAndInterposing, |r, e, name, _| {
            r.emit_enum(e, name)
        })?;
        self.for_each_union(BlankLinePosition::LeadingAndInterposing, |r, u, name, _| {
            r.emit_union(u, name)
        })?;

        if self.just_types_any() {
            return Ok(());
        }

        self.emit_helper_functions()
    }
}

/// The `unmarshalUnion` and `marshalUnion` helpers (the template in
/// `emitHelperFunctions`, tabs and all).
const UNION_HELPERS: &str = r#"func unmarshalUnion(data []byte, pi **int64, pf **float64, pb **bool, ps **string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) (bool, error) {
	if pi != nil {
			*pi = nil
	}
	if pf != nil {
			*pf = nil
	}
	if pb != nil {
			*pb = nil
	}
	if ps != nil {
			*ps = nil
	}

	dec := json.NewDecoder(bytes.NewReader(data))
	dec.UseNumber()
	tok, err := dec.Token()
	if err != nil {
			return false, err
	}

	switch v := tok.(type) {
	case json.Number:
			if pi != nil {
					i, err := v.Int64()
					if err == nil {
							*pi = &i
							return false, nil
					}
			}
			if pf != nil {
					f, err := v.Float64()
					if err == nil {
							*pf = &f
							return false, nil
					}
					return false, errors.New("Unparsable number")
			}
			return false, errors.New("Union does not contain number")
	case float64:
			return false, errors.New("Decoder should not return float64")
	case bool:
			if pb != nil {
					*pb = &v
					return false, nil
			}
			return false, errors.New("Union does not contain bool")
	case string:
			if haveEnum {
					return false, json.Unmarshal(data, pe)
			}
			if ps != nil {
					*ps = &v
					return false, nil
			}
			return false, errors.New("Union does not contain string")
	case nil:
			if nullable {
					return false, nil
			}
			return false, errors.New("Union does not contain null")
	case json.Delim:
			if v == '{' {
					if haveObject {
							return true, json.Unmarshal(data, pc)
					}
					if haveMap {
							return false, json.Unmarshal(data, pm)
					}
					return false, errors.New("Union does not contain object")
			}
			if v == '[' {
					if haveArray {
							return false, json.Unmarshal(data, pa)
					}
					return false, errors.New("Union does not contain array")
			}
			return false, errors.New("Cannot handle delimiter")
	}
	return false, errors.New("Cannot unmarshal union")
}

func marshalUnion(pi *int64, pf *float64, pb *bool, ps *string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) ([]byte, error) {
	if pi != nil {
			return json.Marshal(*pi)
	}
	if pf != nil {
			return json.Marshal(*pf)
	}
	if pb != nil {
			return json.Marshal(*pb)
	}
	if ps != nil {
			return json.Marshal(*ps)
	}
	if haveArray {
			return json.Marshal(pa)
	}
	if haveObject {
			return json.Marshal(pc)
	}
	if haveMap {
			return json.Marshal(pm)
	}
	if haveEnum {
			return json.Marshal(pe)
	}
	if nullable {
			return json.Marshal(nil)
	}
	return nil, errors.New("Union must not be null")
}"#;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn js_to_string_is_javascripts_string_of_a_sourcelike() {
        assert_eq!(js_to_string(&"time.Time".into()), "time.Time");
        assert_eq!(js_to_string(&sl!["*", "time.Time"]), "*,time.Time");
        // Nested arrays flatten, so an optional slice is not "[],time.Time".
        assert_eq!(
            js_to_string(&sl!["*", sl!["[]", "time.Time"]]),
            "*,[],time.Time"
        );
        assert_eq!(js_to_string(&sl![]), "");
        let annotated = maybe_annotated(true, any_type_issue_annotation(), "interface{}");
        assert_eq!(js_to_string(&sl!["*", annotated]), "*,[object Object]");
    }
}
