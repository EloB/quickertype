//! Port of `packages/quicktype-core/src/language/CPlusPlus/CPlusPlusRenderer.ts`.
//!
//! Renders C++ structs or classes with getters and setters, `enum class`es,
//! `std::variant`/`boost::variant` unions and nlohmann::json converters,
//! into one header or (`--source-style multi-source`) one header per type.

use std::cell::RefCell;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};
use quicktype_js_compat::number;

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::attributes::accessor_names::get_accessor_name;
use crate::attributes::constraints::min_max_items_for_type;
use crate::attributes::default_value::{DefaultValue, default_value_for_type};
use crate::attributes::enum_values::enum_case_values;
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::declaration_ir::{Declaration, DeclarationKind};
use crate::renderer_options::RendererOptions;
use crate::support::collection_utils::{SameValueZero, array_intercalate};
use crate::support::comments::CommentOptions;
use crate::support::fast_hash::HashMap;
use crate::support::recursion::guard;
use crate::support::strings::{NamingStyle, make_name_style, string_escape};
use crate::support::support::{assert, defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, directly_reachable_types, find_member, is_named_type, is_nullable,
    nullable_from_union, remove_null_from_union,
};

use super::constants::KEYWORDS;
use super::language::{
    BOOST, CODE_FORMAT, ENUM_TYPE, ENUMERATOR_NAMING_STYLE, HIDE_NULL_OPTIONAL, INCLUDE_LOCATION,
    JUST_TYPES, MEMBER_NAMING_STYLE, NAMESPACE, TYPE_NAMING_STYLE, TYPE_SOURCE_STYLE, WEST_CONST,
    WSTRING, naming_style_for_option,
};
use super::utils::{
    BaseString, ConstraintMember, GlobalNames, IncludeKind, IncludeRecord, IncludeTypeKind,
    MemberNames, OPTIONAL_AS_SHARED_TYPE, OPTIONAL_FACTORY_AS_SHARED_TYPE, StringKind, TypeContext,
    TypeRecord, WrappingCode, add_qualifier, constraints_for_type, legalize_name,
};

/// A name style (TS `NameStyle`), shared by the namers made from it.
type NameStyle = Rc<dyn Fn(&str) -> String>;

/// The option values of the C++ renderer (TS
/// `OptionValues<typeof cPlusPlusOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct CPlusPlusOptions {
    /// `typeSourceStyle`: `true` for `single-source`.
    pub type_source_style: bool,
    /// `includeLocation`: `true` for `local-include`.
    pub include_location: bool,
    /// `codeFormat`: `true` for `with-getter-setter`.
    pub code_format: bool,
    /// `wstring`: `true` for `use-wstring`.
    pub wstring: bool,
    /// `westConst`: `true` for `west-const`.
    pub west_const: bool,
    /// `justTypes`.
    pub just_types: bool,
    /// `namespace`.
    pub namespace: String,
    /// `enumType`.
    pub enum_type: String,
    /// `typeNamingStyle`.
    pub type_naming_style: NamingStyle,
    /// `memberNamingStyle`.
    pub member_naming_style: NamingStyle,
    /// `enumeratorNamingStyle`.
    pub enumerator_naming_style: NamingStyle,
    /// `boost`.
    pub boost: bool,
    /// `hideNullOptional`.
    pub hide_null_optional: bool,
}

impl CPlusPlusOptions {
    /// `getOptionValues(cPlusPlusOptions, values)`: the options in
    /// declaration order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        // The boolean-valued options are TS truthiness: an
        // `Object.prototype` member acts as `true`.
        let type_source_style = TYPE_SOURCE_STYLE.get_flag(values, "single-source")?;
        let include_location = INCLUDE_LOCATION.get_flag(values, "local-include")?;
        let code_format = CODE_FORMAT.get_flag(values, "with-getter-setter")?;
        let wstring = WSTRING.get_flag(values, "use-wstring")?;
        let west_const = WEST_CONST.get_flag(values, "west-const")?;
        let just_types = JUST_TYPES.get_value(values);
        let namespace = NAMESPACE.get_value(values).into_owned();
        let enum_type = ENUM_TYPE.get_value(values).into_owned();
        let type_naming_style = TYPE_NAMING_STYLE.get_enum_value(values)?;
        let member_naming_style = MEMBER_NAMING_STYLE.get_enum_value(values)?;
        let enumerator_naming_style = ENUMERATOR_NAMING_STYLE.get_enum_value(values)?;
        // Every option is resolved before the constructor (type, member)
        // and `makeEnumCaseNamer` (enumerator) make name styles of these.
        let type_naming_style = naming_style_for_option(type_naming_style)?;
        let member_naming_style = naming_style_for_option(member_naming_style)?;
        let enumerator_naming_style = naming_style_for_option(enumerator_naming_style)?;
        Ok(CPlusPlusOptions {
            type_source_style,
            include_location,
            code_format,
            wstring,
            west_const,
            just_types,
            namespace,
            enum_type,
            type_naming_style,
            member_naming_style,
            enumerator_naming_style,
            boost: BOOST.get_value(values),
            hide_null_optional: HIDE_NULL_OPTIONAL.get_value(values),
        })
    }
}

/// The context of most type expressions: in our namespace, with both
/// indirections.
const MEMBER_CONTEXT: TypeContext = TypeContext {
    needs_forward_indirection: true,
    needs_optional_indirection: true,
    in_json_namespace: false,
};

/// The context of type expressions in `namespace nlohmann`.
const JSON_NAMESPACE_CONTEXT: TypeContext = TypeContext {
    needs_forward_indirection: true,
    needs_optional_indirection: true,
    in_json_namespace: true,
};

/// The context without indirections.
fn plain_context(in_json_namespace: bool) -> TypeContext {
    TypeContext {
        needs_forward_indirection: false,
        needs_optional_indirection: false,
        in_json_namespace,
    }
}

/// The variant of a union's non-null members in `namespace nlohmann`, the
/// key of `forEachUniqueUnion` in `emitAllUnionFunctions` and
/// `emitAllUnionHeaders`. As a key it is its text (a string); it carries the
/// variant so that it is built once per union.
struct UnionVariant {
    /// `sourcelikeToString(variant)`.
    text: String,
    /// The union's non-null members, sorted by kind.
    non_nulls: IndexSet<TypeRef>,
    /// The variant type.
    variant_type: Source,
}

impl SameValueZeroKey for UnionVariant {
    fn same_value_zero_key(&self) -> SameValueZero {
        SameValueZero::String(self.text.clone())
    }
}

/// `CPlusPlusRenderer`.
pub struct CPlusPlusRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: CPlusPlusOptions,
    /// `_enumType`.
    enum_type: String,
    /// `_generatedFiles`.
    generated_files: IndexSet<String>,
    /// `_currentFilename`.
    current_filename: Option<String>,
    /// `_allTypeNames`.
    all_type_names: IndexSet<String>,
    /// `_gettersAndSettersForPropertyName`.
    getters_and_setters_for_property_name: HashMap<Name, (Name, Name, Name)>,
    /// `_namespaceNames`.
    namespace_names: Vec<String>,
    /// `_memberNameStyle`.
    member_name_style: NameStyle,
    /// `_namedTypeNameStyle`.
    named_type_name_style: NameStyle,
    /// `_generatedGlobalNames`.
    generated_global_names: HashMap<GlobalNames, String>,
    /// `_generatedMemberNames`.
    generated_member_names: HashMap<MemberNames, String>,
    /// `_forbiddenGlobalNames`.
    forbidden_global_names: Vec<String>,
    /// `_memberNamingFunction`.
    member_naming_function: Namer,
    /// `_stringType`: `WideString` or `NarrowString`.
    string_type: BaseString,
    /// `NarrowString`.
    narrow_string: BaseString,
    /// `_optionalType`: the type to use as an optional (`std::optional` or
    /// `boost::optional`).
    optional_type: &'static str,
    /// `_optionalFactory`.
    optional_factory: &'static str,
    /// `_nulloptType`.
    nullopt_type: &'static str,
    /// `_variantType`.
    variant_type: &'static str,
    /// `_variantIndexMethodName`.
    variant_index_method_name: &'static str,
    /// `isRecursiveUnion(u)` of the unions asked about so far (the graph
    /// does not change while rendering).
    recursive_unions: RefCell<HashMap<TypeRef, bool>>,
}

impl std::fmt::Debug for CPlusPlusRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CPlusPlusRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> CPlusPlusRenderer<'a> {
    /// `new CPlusPlusRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: CPlusPlusOptions,
    ) -> Self {
        let named_type_name_style: NameStyle = Rc::new(make_name_style(
            options.type_naming_style,
            legalize_name,
            None,
        ));
        let member_name_style: NameStyle = Rc::new(make_name_style(
            options.member_naming_style,
            legalize_name,
            None,
        ));
        let member_style = member_name_style.clone();
        let member_naming_function = fun_prefix_namer("members", move |s| member_style(s));
        let (
            optional_type,
            optional_factory,
            nullopt_type,
            variant_type,
            variant_index_method_name,
        ) = if options.boost {
            (
                "boost::optional",
                "boost::optional",
                "boost::none",
                "boost::variant",
                "which",
            )
        } else {
            (
                "std::optional",
                "std::make_optional",
                "std::nullopt",
                "std::variant",
                "index",
            )
        };
        let mut renderer = CPlusPlusRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            enum_type: options.enum_type.clone(),
            namespace_names: options.namespace.split("::").map(str::to_owned).collect(),
            generated_files: IndexSet::new(),
            current_filename: None,
            all_type_names: IndexSet::new(),
            getters_and_setters_for_property_name: HashMap::default(),
            member_name_style,
            named_type_name_style,
            generated_global_names: HashMap::default(),
            generated_member_names: HashMap::default(),
            forbidden_global_names: Vec::new(),
            member_naming_function,
            string_type: if options.wstring {
                BaseString::wide()
            } else {
                BaseString::narrow()
            },
            narrow_string: BaseString::narrow(),
            optional_type,
            optional_factory,
            nullopt_type,
            variant_type,
            variant_index_method_name,
            recursive_unions: RefCell::new(HashMap::default()),
            options,
        };
        renderer.setup_global_names();
        renderer
    }

    // ---- Optionals and cycles ----------------------------------------------

    /// `isOptionalAsValuePossible(t)`: whether `t` can be stored in a stack
    /// based optional, which requires that it is not forward declared.
    fn is_optional_as_value_possible(&self, t: TypeRef) -> Result<bool> {
        if self.is_forward_declared_type(t)? {
            return Ok(false);
        }

        let graph = self.type_graph();
        if graph.kind(t)? == TypeKind::Union {
            // A union whose only non-null member is inlined: check that
            // member (see the TypeScript comment about collapsed variants).
            let (_, non_nulls) = remove_null_from_union(graph, t, NullRemovalSort::None)?;
            if non_nulls.len() == 1 {
                let tt = *defined(non_nulls.first())?;
                return Ok(!self.is_cycle_breaker_type(tt)?);
            }
        }

        Ok(!self.is_cycle_breaker_type(t)?)
    }

    /// `typeContainsUnion(t, visited)`.
    fn type_contains_union(&self, t: TypeRef, visited: &mut IndexSet<TypeRef>) -> Result<bool> {
        let graph = self.type_graph();
        if graph.kind(t)? == TypeKind::Union {
            return Ok(true);
        }
        if visited.contains(&t) {
            return Ok(false);
        }

        visited.insert(t);
        for child in graph.children(t)? {
            if self.type_contains_union(child, visited)? {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// `typeReaches(t, target, visited)`.
    fn type_reaches(
        &self,
        t: TypeRef,
        target: TypeRef,
        visited: &mut IndexSet<TypeRef>,
    ) -> Result<bool> {
        if t == target {
            return Ok(true);
        }
        if visited.contains(&t) {
            return Ok(false);
        }

        visited.insert(t);
        for child in self.type_graph().children(t)? {
            if self.type_reaches(child, target, visited)? {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// `isRecursiveUnion(u)`: whether one of the union's members reaches
    /// the union.
    fn is_recursive_union(&self, u: TypeRef) -> Result<bool> {
        if let Some(&is_recursive) = self.recursive_unions.borrow().get(&u) {
            return Ok(is_recursive);
        }
        let mut is_recursive = false;
        for child in self.type_graph().children(u)? {
            if self.type_reaches(child, u, &mut IndexSet::new())? {
                is_recursive = true;
                break;
            }
        }
        self.recursive_unions.borrow_mut().insert(u, is_recursive);
        Ok(is_recursive)
    }

    /// `recursiveUnionUsesStackOptional(u)`.
    fn recursive_union_uses_stack_optional(&self, u: TypeRef) -> Result<bool> {
        let (maybe_null, _) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::ByKind)?;
        Ok(self.is_recursive_union(u)?
            && maybe_null.is_some()
            && self.is_optional_as_value_possible(u)?)
    }

    /// `optionalTypeStack()`: `std::optional` or `boost::optional`.
    fn optional_type_stack(&self) -> &'static str {
        self.optional_type
    }

    /// `optionalFactoryStack()`.
    fn optional_factory_stack(&self) -> &'static str {
        self.optional_factory
    }

    /// `optionalTypeHeap()`: `std::shared_ptr`.
    fn optional_type_heap(&self) -> &'static str {
        OPTIONAL_AS_SHARED_TYPE
    }

    /// `optionalFactoryHeap()`: `std::make_shared`.
    fn optional_factory_heap(&self) -> &'static str {
        OPTIONAL_FACTORY_AS_SHARED_TYPE
    }

    /// `optionalType(t)`: the optional most suitable for `t`.
    fn optional_type_for(&self, t: TypeRef) -> Result<&'static str> {
        if self.is_optional_as_value_possible(t)? {
            return Ok(self.optional_type_stack());
        }
        Ok(self.optional_type_heap())
    }

    /// `optionalTypeLabel(t)`: `stack` or `heap`.
    fn optional_type_label(&self, t: TypeRef) -> Result<&'static str> {
        if self.is_optional_as_value_possible(t)? {
            return Ok("stack");
        }
        Ok("heap")
    }

    // ---- Generated names ----------------------------------------------------

    /// `getConstraintMembers()`.
    fn get_constraint_members(&self) -> Vec<ConstraintMember> {
        let member = |name, getter, setter, cpp_type: &str| ConstraintMember {
            name,
            getter,
            setter,
            cpp_type: cpp_type.to_owned(),
            cpp_const_type: None,
        };
        vec![
            member(
                MemberNames::MinIntValue,
                MemberNames::GetMinIntValue,
                MemberNames::SetMinIntValue,
                "int64_t",
            ),
            member(
                MemberNames::MaxIntValue,
                MemberNames::GetMaxIntValue,
                MemberNames::SetMaxIntValue,
                "int64_t",
            ),
            member(
                MemberNames::MinDoubleValue,
                MemberNames::GetMinDoubleValue,
                MemberNames::SetMinDoubleValue,
                "double",
            ),
            member(
                MemberNames::MaxDoubleValue,
                MemberNames::GetMaxDoubleValue,
                MemberNames::SetMaxDoubleValue,
                "double",
            ),
            member(
                MemberNames::MinLength,
                MemberNames::GetMinLength,
                MemberNames::SetMinLength,
                "size_t",
            ),
            member(
                MemberNames::MaxLength,
                MemberNames::GetMaxLength,
                MemberNames::SetMaxLength,
                "size_t",
            ),
            ConstraintMember {
                name: MemberNames::Pattern,
                getter: MemberNames::GetPattern,
                setter: MemberNames::SetPattern,
                cpp_type: self.string_type.get_type().to_owned(),
                cpp_const_type: Some(self.string_type.get_const_type().to_owned()),
            },
        ]
    }

    /// `lookupGlobalName(type)`.
    fn lookup_global_name(&self, ty: GlobalNames) -> Result<String> {
        defined(self.generated_global_names.get(&ty).cloned())
    }

    /// `lookupMemberName(type)`.
    fn lookup_member_name(&self, ty: MemberNames) -> Result<String> {
        defined(self.generated_member_names.get(&ty).cloned())
    }

    /// `addGlobalName(type)`.
    fn add_global_name(&mut self, ty: GlobalNames) {
        let gen_name = (self.named_type_name_style)(ty.as_str());
        self.generated_global_names.insert(ty, gen_name.clone());
        self.forbidden_global_names.push(gen_name);
    }

    /// `addMemberName(type)`.
    fn add_member_name(&mut self, ty: MemberNames) {
        let name = (self.member_name_style)(ty.as_str());
        self.generated_member_names.insert(ty, name);
    }

    /// `setupGlobalNames()`.
    fn setup_global_names(&mut self) {
        for v in GlobalNames::ALL {
            self.add_global_name(v);
        }
        for v in MemberNames::ALL {
            self.add_member_name(v);
        }
    }

    /// `makeNamesForPropertyGetterAndSetter(c, className, p, jsonName,
    /// name)`: the getter, mutable getter and setter names.
    fn make_names_for_property_getter_and_setter(&mut self, name: Name) -> (Name, Name, Name) {
        let order = self.naming().order(name);
        let namer = self.member_naming_function.clone();
        let getter_name = self
            .naming_mut()
            .dependency_name(Some(&namer), order, move |lookup| {
                format!("get_{}", lookup(name))
            });
        let mutable_getter_name =
            self.naming_mut()
                .dependency_name(Some(&namer), order, move |lookup| {
                    format!("getMutable_{}", lookup(name))
                });
        let setter_name = self
            .naming_mut()
            .dependency_name(Some(&namer), order, move |lookup| {
                format!("set_{}", lookup(name))
            });
        (getter_name, mutable_getter_name, setter_name)
    }

    /// The getter, mutable getter and setter names of a property.
    fn getters_and_setters(&self, name: Name) -> Result<(Name, Name, Name)> {
        defined(
            self.getters_and_setters_for_property_name
                .get(&name)
                .copied(),
        )
    }

    // ---- Small emitters -----------------------------------------------------

    /// `withConst(s)`: `const s` or `s const`.
    fn with_const(&self, s: impl Into<Source>) -> Source {
        let s: Source = s.into();
        if self.options.west_const {
            return sl!["const ", s];
        }
        sl![s, " const"]
    }

    /// `emitInclude(global, name)`.
    fn emit_include(&mut self, global: bool, name: impl Into<Source>) {
        let name: Source = name.into();
        self.emit_line(sl![
            "#include ",
            if global { "<" } else { "\"" },
            name,
            if global { ">" } else { "\"" }
        ]);
    }

    /// `startFile(basename, includeHelper)`: the leading comment, the
    /// include guard and the includes.
    fn start_file(&mut self, basename: impl Into<Source>, include_helper: bool) -> Result<()> {
        assert(
            self.current_filename.is_none(),
            "Previous file wasn't finished",
        )?;
        let basename = basename.into();
        self.current_filename = Some(self.sourcelike_to_string(&basename)?);

        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        } else if !self.options.just_types {
            let options = CommentOptions::default();
            self.emit_comment_lines(
                &[" To parse this JSON data, first install".into(), "".into()],
                &options,
            )?;
            if self.options.boost {
                self.emit_comment_lines(&["     Boost     http://www.boost.org".into()], &options)?;
            }

            self.emit_comment_lines(
                &[
                    "     json.hpp  https://github.com/nlohmann/json".into(),
                    "".into(),
                    " Then include this file, and then do".into(),
                    "".into(),
                ],
                &options,
            )?;

            self.for_each_top_level(BlankLinePosition::None, |r, _, top_level_name, _| {
                r.emit_line(sl![
                    "//     ",
                    top_level_name,
                    " data = nlohmann::json::parse(jsonString);"
                ]);
                Ok(())
            })?;

            if self.options.wstring {
                self.emit_line("//");
                self.emit_line("//  You can get std::wstring data back out using");
                self.emit_line("//");
                self.for_each_top_level(BlankLinePosition::None, |r, _, top_level_name, _| {
                    r.emit_line(sl![
                        "//     std::wcout << ",
                        "wdump((nlohmann::json) ",
                        top_level_name,
                        ");"
                    ]);
                    Ok(())
                })?;
            }
        }

        self.ensure_blank_line();

        self.emit_line("#pragma once");
        self.ensure_blank_line();

        let mut need_optional = self.have_optional_properties()?;
        if !need_optional && !self.options.code_format {
            let unions: Vec<TypeRef> = self.named_unions()?.iter().copied().collect();
            for u in unions {
                if self.recursive_union_uses_stack_optional(u)? {
                    need_optional = true;
                    break;
                }
            }
        }
        if need_optional {
            if self.options.boost {
                self.emit_include(true, "boost/optional.hpp");
            } else {
                self.emit_include(true, "optional");
            }
        }

        if self.have_named_unions()? {
            if self.options.boost {
                self.emit_include(true, "boost/variant.hpp");
            } else {
                self.emit_include(true, "variant");
            }
        }

        if !self.options.just_types {
            if !self.options.include_location {
                self.emit_include(true, "nlohmann/json.hpp");
            } else {
                self.emit_include(false, "json.hpp");
            }

            if include_helper && !self.options.type_source_style {
                self.emit_include(false, "helper.hpp");
            }
        }

        self.ensure_blank_line();
        Ok(())
    }

    /// `finishFile()`: finishes the current file.
    fn finish_current_file(&mut self) -> Result<()> {
        let filename = defined(self.current_filename.clone())?;
        defaults::finish_file(self, &filename)?;
        self.current_filename = None;
        Ok(())
    }

    /// `emitBlock(line, withSemicolon, f, withIndent)`.
    fn emit_block_with(
        &mut self,
        line: impl Into<Source>,
        with_semicolon: bool,
        with_indent: bool,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        let line: Source = line.into();
        self.emit_line(sl![line, " {"]);
        self.prevent_blank_line();
        if with_indent {
            self.indent(f)?;
        } else {
            f(self)?;
        }

        self.prevent_blank_line();
        if with_semicolon {
            self.emit_line("};");
        } else {
            self.emit_line("}");
        }
        Ok(())
    }

    /// `emitBlock(line, withSemicolon, f)`.
    fn emit_block(
        &mut self,
        line: impl Into<Source>,
        with_semicolon: bool,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_block_with(line, with_semicolon, true, f)
    }

    /// `emitNamespaces(namespaceNames, f)`: nested namespace blocks, of
    /// which only the innermost is indented.
    fn emit_namespaces(
        &mut self,
        namespace_names: &[String],
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        match namespace_names.split_first() {
            None => f(self),
            Some((first, rest)) => self.emit_block_with(
                sl!["namespace ", first.as_str()],
                false,
                namespace_names.len() == 1,
                |r| r.emit_namespaces(rest, f),
            ),
        }
    }

    /// `emitNamespaces(this._namespaceNames, f)`.
    fn emit_our_namespaces(&mut self, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        let names = self.namespace_names.clone();
        self.emit_namespaces(&names, f)
    }

    /// `emitNamespaces(["nlohmann"], f)`.
    fn emit_nlohmann_namespace(&mut self, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.emit_namespaces(&["nlohmann".to_owned()], f)
    }

    // ---- Strings ------------------------------------------------------------

    /// `_stringType.wrapEncodingChange(qualifier, fromType, toType, inner)`:
    /// `inner` itself for narrow strings, and for wide strings if the types
    /// are the same; else a `Utf16_Utf8` conversion.
    fn wrap_encoding_change(
        &self,
        qualifier: impl Into<Source>,
        from_type: impl Into<Source>,
        to_type: impl Into<Source>,
        inner: impl Into<Source>,
    ) -> Result<Source> {
        let inner = inner.into();
        if self.string_type.kind == StringKind::Narrow {
            return Ok(inner);
        }
        let from_type = from_type.into();
        let to_type = to_type.into();
        if self.sourcelike_to_string(&from_type)? == self.sourcelike_to_string(&to_type)? {
            return Ok(inner);
        }

        Ok(sl![
            add_qualifier(qualifier.into(), &[self.string_type.encoding_class.into()]),
            "<",
            from_type,
            ", ",
            to_type,
            ">::",
            self.string_type.encoding_function,
            "(",
            inner,
            ")"
        ])
    }

    /// `wrapEncodingChange([ourQualifier], stringType, "std::string",
    /// inner)`: the conversion of a string key.
    fn wrap_string_key(&self, our_qualifier: &Source, inner: impl Into<Source>) -> Result<Source> {
        self.wrap_encoding_change(
            sl![our_qualifier],
            self.string_type.get_type(),
            self.narrow_string.get_type(),
            inner,
        )
    }

    /// `_stringType.createStringLiteral([stringEscape(s)])`.
    fn string_literal(&self, s: &str) -> Source {
        self.string_type
            .create_string_literal(sl![string_escape(s)])
    }

    /// `NarrowString.createStringLiteral([stringEscape(s)])`.
    fn narrow_string_literal(&self, s: &str) -> Source {
        self.narrow_string
            .create_string_literal(sl![string_escape(s)])
    }

    // ---- Type expressions ---------------------------------------------------

    /// `cppTypeInOptional(nonNulls, ctx, withIssues, forceNarrowString)`:
    /// the single type, or a variant of the types.
    fn cpp_type_in_optional(
        &self,
        non_nulls: &IndexSet<TypeRef>,
        ctx: TypeContext,
        with_issues: bool,
        force_narrow_string: bool,
    ) -> Result<Source> {
        if non_nulls.len() == 1 {
            return self.cpp_type(
                *defined(non_nulls.first())?,
                ctx,
                with_issues,
                force_narrow_string,
                false,
            );
        }

        let mut types: Vec<Source> = Vec::with_capacity(non_nulls.len());
        for &t in non_nulls {
            types.push(self.cpp_type(
                t,
                TypeContext {
                    needs_forward_indirection: true,
                    needs_optional_indirection: false,
                    in_json_namespace: ctx.in_json_namespace,
                },
                with_issues,
                false,
                false,
            )?);
        }

        let type_list = array_intercalate(", ".into(), types);
        Ok(sl![
            self.variant_type,
            "<",
            Source::Sequence(type_list),
            ">"
        ])
    }

    /// `variantType(u, inJsonNamespace)`.
    fn variant_type_for(&self, u: TypeRef, in_json_namespace: bool) -> Result<Source> {
        let (maybe_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::ByKind)?;
        assert(
            non_nulls.len() >= 2,
            "Variant not needed for less than two types.",
        )?;
        let indirection = maybe_null.is_some();
        let variant = self.cpp_type_in_optional(
            &non_nulls,
            TypeContext {
                needs_forward_indirection: !indirection,
                needs_optional_indirection: !indirection,
                in_json_namespace,
            },
            true,
            false,
        )?;
        if !indirection {
            return Ok(variant);
        }
        Ok(sl![self.optional_type_for(u)?, "<", variant, ">"])
    }

    /// `ourQualifier(inJsonNamespace)`: `quicktype::` inside `namespace
    /// nlohmann`.
    fn our_qualifier(&self, in_json_namespace: bool) -> Source {
        if !in_json_namespace {
            return sl![];
        }
        let names = array_intercalate(
            "::".into(),
            self.namespace_names
                .iter()
                .map(|n| Source::from(n.as_str())),
        );
        sl![Source::Sequence(names), "::"]
    }

    /// `jsonQualifier(inJsonNamespace)`.
    fn json_qualifier(&self, in_json_namespace: bool) -> Source {
        if in_json_namespace {
            sl![]
        } else {
            "nlohmann::".into()
        }
    }

    /// `variantIndirection(type, needIndirection, typeSrc)`.
    fn variant_indirection(
        &self,
        ty: TypeRef,
        need_indirection: bool,
        type_src: Source,
    ) -> Result<Source> {
        if !need_indirection {
            return Ok(type_src);
        }
        Ok(sl![self.optional_type_for(ty)?, "<", type_src, ">"])
    }

    /// `cppType(t, ctx, withIssues, forceNarrowString, isOptional)`.
    fn cpp_type(
        &self,
        t: TypeRef,
        ctx: TypeContext,
        with_issues: bool,
        force_narrow_string: bool,
        is_optional: bool,
    ) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let in_json_namespace = ctx.in_json_namespace;
            let mut is_optional = is_optional;
            let ty = graph.type_at(t)?;
            if is_optional && ty.is_union() {
                // avoid have optionalType<optionalType<Type>>
                for t_child in graph.children(t)? {
                    if is_nullable(graph, t_child)? {
                        is_optional = false;
                        break;
                    }
                }
            }

            let type_source: Source = match ty.kind() {
                TypeKind::Any => {
                    is_optional = false;
                    maybe_annotated(
                        with_issues,
                        any_type_issue_annotation(),
                        sl![self.json_qualifier(in_json_namespace), "json"],
                    )
                }
                TypeKind::Null => {
                    is_optional = false;
                    maybe_annotated(
                        with_issues,
                        null_type_issue_annotation(),
                        sl![self.json_qualifier(in_json_namespace), "json"],
                    )
                }
                TypeKind::Bool => "bool".into(),
                TypeKind::Integer => "int64_t".into(),
                TypeKind::Double => "double".into(),
                TypeKind::String => {
                    if force_narrow_string {
                        "std::string".into()
                    } else {
                        self.string_type.get_type().into()
                    }
                }
                TypeKind::Array => sl![
                    "std::vector<",
                    self.cpp_type(
                        ty.items()?,
                        TypeContext {
                            needs_forward_indirection: false,
                            needs_optional_indirection: true,
                            in_json_namespace,
                        },
                        with_issues,
                        force_narrow_string,
                        false,
                    )?,
                    ">"
                ],
                TypeKind::Class => self.variant_indirection(
                    t,
                    ctx.needs_forward_indirection
                        && self.is_forward_declared_type(t)?
                        && !is_optional,
                    sl![
                        self.our_qualifier(in_json_namespace),
                        self.name_for_named_type(t)?
                    ],
                )?,
                TypeKind::Map => {
                    let key_type = if force_narrow_string {
                        "std::string"
                    } else {
                        self.string_type.get_type()
                    };
                    sl![
                        "std::map<",
                        key_type,
                        ", ",
                        self.cpp_type(
                            ty.map_values()?,
                            TypeContext {
                                needs_forward_indirection: false,
                                needs_optional_indirection: true,
                                in_json_namespace,
                            },
                            with_issues,
                            force_narrow_string,
                            false,
                        )?,
                        ">"
                    ]
                }
                TypeKind::Enum => sl![
                    self.our_qualifier(in_json_namespace),
                    self.name_for_named_type(t)?
                ],
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        is_optional = true;
                        self.cpp_type(
                            nullable,
                            plain_context(in_json_namespace),
                            with_issues,
                            force_narrow_string,
                            false,
                        )?
                    } else {
                        sl![
                            self.our_qualifier(in_json_namespace),
                            self.name_for_named_type(t)?
                        ]
                    }
                }
                kind if kind.is_transformed_string_type_kind() => {
                    self.string_type.get_type().into()
                }
                kind => return match_type_unsupported(kind),
            };
            if !is_optional {
                return Ok(type_source);
            }
            Ok(sl![self.optional_type_for(t)?, "<", type_source, ">"])
        })
    }

    /// `generatedTypes(isClassMember, theType)`: the generated types within
    /// `theType`, and whether each is part of a variant.
    fn generated_types(&self, is_class_member: bool, the_type: TypeRef) -> Result<Vec<TypeRecord>> {
        let mut result = Vec::new();
        self.generated_types_recur(is_class_member, &mut result, false, false, 0, the_type)?;
        Ok(result)
    }

    /// `recur(forceInclude, isVariant, l, t)` of `generatedTypes`.
    fn generated_types_recur(
        &self,
        is_class_member: bool,
        result: &mut Vec<TypeRecord>,
        force_include: bool,
        is_variant: bool,
        l: usize,
        t: TypeRef,
    ) -> Result<()> {
        // Endless on a union that contains itself (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            match ty.kind() {
                TypeKind::Array => self.generated_types_recur(
                    is_class_member,
                    result,
                    true,
                    is_variant,
                    l + 1,
                    ty.items()?,
                ),
                TypeKind::Class => {
                    result.push(TypeRecord {
                        name: self.name_for_named_type(t)?,
                        type_ref: t,
                        level: l,
                        variant: is_variant,
                        force_include,
                    });
                    Ok(())
                }
                TypeKind::Map => self.generated_types_recur(
                    is_class_member,
                    result,
                    true,
                    is_variant,
                    l + 1,
                    ty.map_values()?,
                ),
                TypeKind::Enum => {
                    result.push(TypeRecord {
                        name: self.name_for_named_type(t)?,
                        type_ref: t,
                        level: l,
                        variant: is_variant,
                        force_include: false,
                    });
                    Ok(())
                }
                TypeKind::Union => {
                    let mut force_include = force_include;
                    // A named union as a class member is included as is, but
                    // the compiler must know the sizes of all its members,
                    // so they are included (forced) as well.
                    if self.union_needs_name(t)? && is_class_member {
                        force_include = true;
                        result.push(TypeRecord {
                            name: self.name_for_named_type(t)?,
                            type_ref: t,
                            level: l,
                            variant: true,
                            force_include,
                        });
                    }

                    let (has_null, non_nulls) =
                        remove_null_from_union(graph, t, NullRemovalSort::None)?;
                    let is_variant = has_null.is_some();
                    for tt in non_nulls {
                        self.generated_types_recur(
                            is_class_member,
                            result,
                            force_include,
                            is_variant,
                            l + 1,
                            tt,
                        )?;
                    }
                    Ok(())
                }
                _ => Ok(()),
            }
        })
    }

    /// `constraintMember(jsonName)`.
    fn constraint_member(&self, json_name: &str) -> String {
        (self.member_name_style)(&format!("{json_name}Constraint"))
    }

    /// `emitMember(cppType, name, defaultValue)`.
    fn emit_member(
        &mut self,
        cpp_type: impl Into<Source>,
        name: impl Into<Source>,
        default_value: Option<Source>,
    ) {
        let (cpp_type, name): (Source, Source) = (cpp_type.into(), name.into());
        self.emit_line(sl![
            cpp_type,
            " ",
            name,
            match default_value {
                None => sl![],
                Some(v) => sl![" = ", v],
            },
            ";"
        ]);
    }

    /// `cppDefaultValue(t)`.
    fn cpp_default_value(&self, t: TypeRef) -> Result<Option<Source>> {
        let Some(default_value) = default_value_for_type(self.type_graph(), t)? else {
            return Ok(None);
        };

        Ok(Some(match default_value {
            DefaultValue::Null => "nullptr".into(),
            DefaultValue::Bool(b) => (if b { "true" } else { "false" }).into(),
            DefaultValue::Number(n) => number::to_string(n).into(),
            DefaultValue::String(s) => {
                let ty = self.type_graph().type_at(t)?;
                if ty.is_enum() && ty.cases()?.contains(&s) {
                    sl![
                        self.name_for_named_type(t)?,
                        "::",
                        self.name_for_enum_case(t, &s)?
                    ]
                } else {
                    self.string_literal(&s)
                }
            }
        }))
    }

    // ---- Classes ------------------------------------------------------------

    /// `emitClassMembers(c, constraints)`.
    fn emit_class_members(
        &mut self,
        c: TypeRef,
        constraints: Option<&IndexMap<String, Source>>,
    ) -> Result<()> {
        let has_constraint =
            |json_name: &str| constraints.is_some_and(|m| m.contains_key(json_name));
        if self.options.code_format {
            self.emit_line("private:");

            self.for_each_class_property(
                c,
                BlankLinePosition::None,
                |r, name, json_name, property, _| {
                    let cpp_type = r.cpp_type(
                        property.type_ref,
                        MEMBER_CONTEXT,
                        true,
                        false,
                        property.is_optional,
                    )?;
                    let default_value = r.cpp_default_value(property.type_ref)?;
                    r.emit_member(cpp_type, name, default_value);
                    if has_constraint(json_name) {
                        // FIXME!!! NameStyle will/can collide with other Names
                        let cnst = r.lookup_global_name(GlobalNames::ClassMemberConstraints)?;
                        let member = r.constraint_member(json_name);
                        r.emit_member(cnst, member, None);
                    }
                    Ok(())
                },
            )?;

            self.ensure_blank_line();
            self.emit_line("public:");
        }

        self.for_each_class_property(
            c,
            BlankLinePosition::None,
            |r, name, json_name, property, _| {
                let description = r.description_for_class_property(c, json_name)?;
                r.emit_description(description)?;
                if !r.options.code_format {
                    let cpp_type = r.cpp_type(
                        property.type_ref,
                        MEMBER_CONTEXT,
                        true,
                        false,
                        property.is_optional,
                    )?;
                    let default_value = r.cpp_default_value(property.type_ref)?;
                    r.emit_member(cpp_type, name, default_value);
                    return Ok(());
                }

                let (getter_name, mutable_getter_name, setter_name) =
                    r.getters_and_setters(name)?;
                let rendered = r.cpp_type(
                    property.type_ref,
                    MEMBER_CONTEXT,
                    true,
                    false,
                    property.is_optional,
                )?;

                // fix for optional type -> e.g. unique_ptrs can't be copied
                // One might as why the "this->xxx = value". Simple if we have
                // a member called 'value' value = value will screw up the compiler
                let check_const = r.lookup_global_name(GlobalNames::CheckConstraint)?;
                let graph = r.type_graph();
                let is_nullable_union = graph.kind(property.type_ref)? == TypeKind::Union
                    && find_member(graph, property.type_ref, TypeKind::Null)?.is_some();
                if is_nullable_union {
                    r.emit_line(sl![
                        rendered.clone(),
                        " ",
                        getter_name,
                        "() const { return ",
                        name,
                        "; }"
                    ]);
                    if has_constraint(json_name) {
                        let literal = r.string_type.create_string_literal(sl![name]);
                        let member = r.constraint_member(json_name);
                        r.emit_line(sl![
                            "void ",
                            setter_name,
                            "(",
                            rendered,
                            " value) { if (value) ",
                            check_const,
                            "(",
                            literal,
                            ", ",
                            member,
                            ", *value); this->",
                            name,
                            " = value; }"
                        ]);
                    } else {
                        r.emit_line(sl![
                            "void ",
                            setter_name,
                            "(",
                            rendered,
                            " value) { this->",
                            name,
                            " = value; }"
                        ]);
                    }
                } else {
                    let const_rendered = r.with_const(rendered.clone());
                    r.emit_line(sl![
                        const_rendered.clone(),
                        " & ",
                        getter_name,
                        "() const { return ",
                        name,
                        "; }"
                    ]);
                    r.emit_line(sl![
                        rendered,
                        " & ",
                        mutable_getter_name,
                        "() { return ",
                        name,
                        "; }"
                    ]);
                    if has_constraint(json_name) {
                        let literal = r.string_type.create_string_literal(sl![name]);
                        let member = r.constraint_member(json_name);
                        r.emit_line(sl![
                            "void ",
                            setter_name,
                            "(",
                            const_rendered,
                            " & value) { ",
                            check_const,
                            "(",
                            literal,
                            ", ",
                            member,
                            ", value); this->",
                            name,
                            " = value; }"
                        ]);
                    } else {
                        r.emit_line(sl![
                            "void ",
                            setter_name,
                            "(",
                            const_rendered,
                            " & value) { this->",
                            name,
                            " = value; }"
                        ]);
                    }
                }

                r.ensure_blank_line();
                Ok(())
            },
        )
    }

    /// `generateClassConstraints(c)`: the constraint member initializer of
    /// every constrained property, by JSON name.
    fn generate_class_constraints(
        &mut self,
        c: TypeRef,
    ) -> Result<Option<IndexMap<String, Source>>> {
        let mut res: IndexMap<String, Source> = IndexMap::new();
        self.for_each_class_property(
            c,
            BlankLinePosition::None,
            |r, _name, json_name, property, _| {
                let Some(constraints) = constraints_for_type(r.type_graph(), property.type_ref)?
                else {
                    return Ok(());
                };

                // We only generate this to classify the underlying type, so
                // `isOptional` is false: otherwise the type is wrapped in an
                // optional and the comparisons below never match.
                let cpp_type = r.cpp_type(property.type_ref, MEMBER_CONTEXT, true, false, false)?;
                let is_type = |name: &str| matches!(&cpp_type, Source::Text(s) if s == name);
                let nullopt = r.nullopt_type;
                let bound = |value: Option<f64>, applies: bool| -> Source {
                    match value {
                        Some(v) if applies => number::to_string(v).into(),
                        _ => nullopt.into(),
                    }
                };
                let (min, max) = constraints.min_max.map_or((None, None), |m| (m.0, m.1));
                let (min_length, max_length) = constraints
                    .min_max_length
                    .map_or((None, None), |m| (m.0, m.1));
                let pattern: Source = match &constraints.pattern {
                    None => nullopt.into(),
                    Some(pattern) => sl![
                        r.string_type.get_type(),
                        "(",
                        r.string_literal(pattern),
                        ")"
                    ],
                };

                // Bounds are compared against `undefined` explicitly, since 0
                // is a valid constraint value too.
                res.insert(
                    json_name.to_owned(),
                    sl![
                        r.constraint_member(json_name),
                        "(",
                        bound(min, is_type("int64_t")),
                        ", ",
                        bound(max, is_type("int64_t")),
                        ", ",
                        bound(min, is_type("double")),
                        ", ",
                        bound(max, is_type("double")),
                        ", ",
                        bound(min_length, true),
                        ", ",
                        bound(max_length, true),
                        ", ",
                        pattern,
                        ")"
                    ],
                );
                Ok(())
            },
        )?;

        Ok(if res.is_empty() { None } else { Some(res) })
    }

    /// `emitClass(c, className)`.
    fn emit_class(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        let keyword = if self.options.code_format {
            "class "
        } else {
            "struct "
        };
        self.emit_block(sl![keyword, class_name], true, |r| {
            let constraints = r.generate_class_constraints(c)?;
            if r.options.code_format {
                r.emit_line("public:");
                match &constraints {
                    None => r.emit_line(sl![class_name, "() = default;"]),
                    Some(constraints) => {
                        r.emit_line(sl![class_name, "() :"]);
                        let size = constraints.len();
                        for (num_emits, initializer) in constraints.values().enumerate() {
                            r.indent(|r| {
                                if num_emits + 1 == size {
                                    r.emit_line(initializer.clone());
                                } else {
                                    r.emit_line(sl![initializer.clone(), ","]);
                                }
                                Ok(())
                            })?;
                        }
                        r.emit_line("{}");
                    }
                }

                r.emit_line(sl!["virtual ~", class_name, "() = default;"]);
                r.ensure_blank_line();
            }

            r.emit_class_members(c, constraints.as_ref())
        })
    }

    /// `emitTopLevelHeaders(t, className)`: the `adl_serializer`
    /// declarations for a top-level `std::map<std::wstring, ...>`, which
    /// converts between UTF-16 and UTF-8.
    fn emit_top_level_headers(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        if self.type_graph().kind(t)? != TypeKind::Map || !self.options.wstring {
            return Ok(());
        }
        let our_qualifier = self.our_qualifier(true);

        self.emit_block(
            sl![
                "struct adl_serializer<",
                our_qualifier.clone(),
                class_name,
                ">"
            ],
            true,
            |r| {
                r.emit_line("template <>");
                let json = r.with_const("json");
                r.emit_line(sl![
                    "static void from_json(",
                    json,
                    " & j, ",
                    our_qualifier.clone(),
                    class_name,
                    " & x);"
                ]);
                let x = r.with_const(sl![our_qualifier, class_name]);
                r.emit_line(sl!["static void to_json(json & j, ", x, " & x);"]);
                Ok(())
            },
        )
    }

    /// `emitClassHeaders(className)`.
    fn emit_class_headers(&mut self, class_name: Name) {
        let our_qualifier = self.our_qualifier(false);
        let json = self.with_const("json");
        self.emit_line(sl![
            "void from_json(",
            json,
            " & j, ",
            our_qualifier.clone(),
            class_name,
            " & x);"
        ]);
        let x = self.with_const(sl![our_qualifier, class_name]);
        self.emit_line(sl!["void to_json(json & j, ", x, " & x);"]);
    }

    /// `emitTopLevelFunction(t, className)`: the `adl_serializer`
    /// definitions for a top-level `std::map<std::wstring, ...>`.
    fn emit_top_level_function(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        if self.type_graph().kind(t)? != TypeKind::Map || !self.options.wstring {
            return Ok(());
        }
        let our_qualifier = self.our_qualifier(true);

        let json = self.with_const("json");
        self.emit_block_with(
            sl![
                "inline void adl_serializer<",
                our_qualifier.clone(),
                class_name,
                ">::from_json(",
                json,
                " & j, ",
                our_qualifier.clone(),
                class_name,
                "& x)"
            ],
            false,
            true,
            |r| {
                let cpp_type = r.cpp_type(t, JSON_NAMESPACE_CONTEXT, false, true, false)?;
                let to_type = r.cpp_type(t, JSON_NAMESPACE_CONTEXT, false, false, false)?;
                let value = r.wrap_encoding_change(
                    sl![our_qualifier.clone()],
                    cpp_type.clone(),
                    to_type,
                    sl!["j.get<", cpp_type, ">()"],
                )?;
                r.emit_line(sl!["x = ", value, ";"]);
                Ok(())
            },
        )?;

        let x = self.with_const(sl![our_qualifier.clone(), class_name]);
        self.emit_block_with(
            sl![
                "inline void adl_serializer<",
                our_qualifier.clone(),
                class_name,
                ">::to_json(json & j, ",
                x,
                " & x)"
            ],
            false,
            true,
            |r| {
                let cpp_type = r.cpp_type(t, JSON_NAMESPACE_CONTEXT, false, false, false)?;
                let to_type = r.cpp_type(t, JSON_NAMESPACE_CONTEXT, false, true, false)?;
                let value = r.wrap_encoding_change(sl![our_qualifier], cpp_type, to_type, "x")?;
                r.emit_line(sl!["j = ", value, ";"]);
                Ok(())
            },
        )
    }

    /// `emitClassFunctions(c, className)`: `from_json` and `to_json`.
    fn emit_class_functions(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let our_qualifier = self.our_qualifier(false);

        let json = self.with_const("json");
        self.emit_block_with(
            sl![
                "inline void from_json(",
                json,
                " & j, ",
                our_qualifier.clone(),
                class_name,
                "& x)"
            ],
            false,
            true,
            |r| {
                r.emit_line("if (!j.is_object()) throw std::runtime_error(\"Expected object\");");
                if r.type_graph().type_at(c)?.properties()?.is_empty() {
                    r.emit_line("(void)j;");
                    r.emit_line("(void)x;");
                }

                r.for_each_class_property(c, BlankLinePosition::None, |r, name, json, p, _| {
                    r.emit_from_json_property(&our_qualifier, name, json, &p)
                })
            },
        )?;
        self.ensure_blank_line();

        let x = self.with_const(sl![our_qualifier.clone(), class_name]);
        self.emit_block_with(
            sl!["inline void to_json(json & j, ", x, " & x)"],
            false,
            true,
            |r| {
                r.emit_line("j = json::object();");
                if r.type_graph().type_at(c)?.properties()?.is_empty() {
                    r.emit_line("(void)x;");
                }

                r.for_each_class_property(c, BlankLinePosition::None, |r, name, json, p, _| {
                    r.emit_to_json_property(&our_qualifier, name, json, &p)
                })
            },
        )
    }

    /// One property of `from_json` in `emitClassFunctions`.
    fn emit_from_json_property(
        &mut self,
        our_qualifier: &Source,
        name: Name,
        json: &str,
        p: &ClassProperty,
    ) -> Result<()> {
        let (_, _, setter_name) = self.getters_and_setters(name)?;
        let prop_type = p.type_ref;
        let graph = self.type_graph();
        let prop_kind = graph.kind(prop_type)?;

        let assignment = if self.options.code_format {
            WrappingCode::new(
                vec!["x.".into(), setter_name.into(), "(".into()],
                vec![")".into()],
            )
        } else {
            WrappingCode::new(vec!["x.".into(), name.into(), " = ".into()], vec![])
        };

        if prop_kind == TypeKind::Null || prop_kind == TypeKind::Any {
            let key = self.wrap_string_key(our_qualifier, sl![self.string_literal(json)])?;
            self.emit_line(sl![
                assignment.wrap(
                    sl![],
                    sl![our_qualifier.clone(), "get_untyped(j, ", key, ")"]
                ),
                ";"
            ]);
            return Ok(());
        }

        if prop_kind == TypeKind::Integer {
            let key = self.narrow_string_literal(json);
            self.emit_line(sl![
                "if (j.find(",
                key.clone(),
                ") != j.end() && !j.at(",
                key,
                ").is_number_integer()) throw std::runtime_error(\"Expected integer\");"
            ]);
        }

        if prop_kind == TypeKind::Uuid {
            let key = self.narrow_string_literal(json);
            self.emit_line(sl![
                "if (j.find(",
                key.clone(),
                ") != j.end() && !std::regex_match(j.at(",
                key,
                ").get<std::string>(), std::regex(\"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$\"))) throw std::runtime_error(\"Expected UUID\");"
            ]);
        }

        if prop_kind == TypeKind::DateTime {
            let key = self.narrow_string_literal(json);
            self.emit_line(sl![
                "if (j.find(",
                key.clone(),
                ") != j.end() && !std::regex_match(j.at(",
                key,
                ").get<std::string>(), std::regex(\"^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$\"))) throw std::runtime_error(\"Expected date-time\");"
            ]);
        }

        if let Some(min_max_items) = min_max_items_for_type(graph, prop_type)? {
            let key = self.sourcelike_to_string(&self.narrow_string_literal(json))?;
            if let Some(min_items) = min_max_items.0 {
                self.emit_line(format!(
                    "if (j.at({key}).size() < {}) throw std::runtime_error(\"Too few items\");",
                    number::to_string(min_items)
                ));
            }
            if let Some(max_items) = min_max_items.1 {
                self.emit_line(format!(
                    "if (j.at({key}).size() > {}) throw std::runtime_error(\"Too many items\");",
                    number::to_string(max_items)
                ));
            }
        }

        let prop_is_nullable = is_nullable(graph, prop_type)?;
        if !p.is_optional && prop_is_nullable {
            let key = self.narrow_string_literal(json);
            self.emit_line(sl!["j.at(", key, ");"]);
        }

        if p.is_optional && !prop_is_nullable {
            let key = self.narrow_string_literal(json);
            self.emit_line(sl![
                "if (j.find(",
                key.clone(),
                ") != j.end() && j.at(",
                key,
                ").is_null()) throw std::runtime_error(\"Unexpected null\");"
            ]);
        }

        let prop_is_union = prop_kind == TypeKind::Union;
        if p.is_optional || prop_is_union {
            // `has_null`: the union's `removeNullFromUnion(propType, true)[0]
            // !== null`.
            let (has_null, null_or_optional, type_set) = if prop_is_union {
                let (maybe_null, non_nulls) =
                    remove_null_from_union(graph, prop_type, NullRemovalSort::ByKind)?;
                let has_null = maybe_null.is_some();
                (has_null, has_null || p.is_optional, non_nulls)
            } else {
                (
                    false,
                    true,
                    [prop_type].into_iter().collect::<IndexSet<_>>(),
                )
            };
            let is_recursive_named_union = prop_is_union
                && self.named_unions()?.contains(&prop_type)
                && self.is_recursive_union(prop_type)?;
            if is_recursive_named_union && p.is_optional && has_null {
                let cpp_type = self.cpp_type(prop_type, MEMBER_CONTEXT, false, true, true)?;
                let property_name =
                    self.wrap_string_key(our_qualifier, self.string_literal(json))?;
                self.emit_line(sl![
                    assignment.wrap(
                        sl![],
                        sl![
                            "j.find(",
                            property_name.clone(),
                            ") != j.end() ? j.at(",
                            property_name,
                            ").get<",
                            cpp_type.clone(),
                            ">() : ",
                            cpp_type,
                            "()"
                        ]
                    ),
                    ";"
                ]);
                return Ok(());
            }

            if null_or_optional {
                let optional_types: IndexSet<TypeRef> = if is_recursive_named_union {
                    [prop_type].into_iter().collect()
                } else {
                    type_set
                };
                let cpp_type =
                    self.cpp_type_in_optional(&optional_types, plain_context(false), false, true)?;
                let to_type =
                    self.cpp_type_in_optional(&optional_types, plain_context(false), false, false)?;
                let optional_type = self.optional_type_for(prop_type)?;
                let label = self.optional_type_label(prop_type)?;
                let key = self.wrap_string_key(our_qualifier, sl![self.string_literal(json)])?;
                let value = self.wrap_encoding_change(
                    sl![our_qualifier.clone()],
                    sl![optional_type, "<", cpp_type.clone(), ">"],
                    sl![optional_type, "<", to_type, ">"],
                    sl![
                        our_qualifier.clone(),
                        format!("get_{label}_optional<"),
                        cpp_type,
                        ">(j, ",
                        key,
                        ")"
                    ],
                )?;
                self.emit_line(sl![assignment.wrap(sl![], sl![value]), ";"]);
                return Ok(());
            }
        }

        let cpp_type = self.cpp_type(prop_type, MEMBER_CONTEXT, false, true, p.is_optional)?;
        let to_type = self.cpp_type(prop_type, MEMBER_CONTEXT, false, false, p.is_optional)?;
        let key = self.wrap_string_key(our_qualifier, self.string_literal(json))?;
        let value = self.wrap_encoding_change(
            sl![our_qualifier.clone()],
            cpp_type.clone(),
            to_type,
            sl!["j.at(", key, ").get<", cpp_type, ">()"],
        )?;
        self.emit_line(sl![assignment.wrap(sl![], value), ";"]);
        Ok(())
    }

    /// One property of `to_json` in `emitClassFunctions`.
    fn emit_to_json_property(
        &mut self,
        our_qualifier: &Source,
        name: Name,
        json: &str,
        p: &ClassProperty,
    ) -> Result<()> {
        let prop_type = p.type_ref;
        let cpp_type = self.cpp_type(prop_type, MEMBER_CONTEXT, false, false, p.is_optional)?;
        let to_type = self.cpp_type(prop_type, MEMBER_CONTEXT, false, true, p.is_optional)?;
        let (getter_name, _, _) = self.getters_and_setters(name)?;
        let getter: Source = if self.options.code_format {
            sl![getter_name, "()"]
        } else {
            sl![name]
        };

        let value = self.wrap_encoding_change(
            sl![our_qualifier.clone()],
            cpp_type,
            to_type,
            sl!["x.", getter],
        )?;
        let key = self.wrap_string_key(our_qualifier, self.string_literal(json))?;
        let assignment = sl!["j[", key, "] = ", value.clone(), ";"];
        if p.is_optional && self.options.hide_null_optional {
            let prop_kind = self.type_graph().kind(prop_type)?;
            let condition = if prop_kind == TypeKind::Null || prop_kind == TypeKind::Any {
                sl!["!", value, ".is_null()"]
            } else {
                value
            };
            self.emit_block_with(sl!["if (", condition, ")"], false, true, |r| {
                r.emit_line(assignment);
                Ok(())
            })
        } else {
            self.emit_line(assignment);
            Ok(())
        }
    }

    // ---- Enums and unions ---------------------------------------------------

    /// `emitEnum(e, enumName)`.
    fn emit_enum(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let mut case_names: Vec<Source> = Vec::new();
        let enum_values = enum_case_values(self.type_graph(), e, self.target_language().name())?;

        self.for_each_enum_case(e, BlankLinePosition::None, |_, name, json_name, _| {
            if !case_names.is_empty() {
                case_names.push(", ".into());
            }
            case_names.push(name.into());

            let (enum_value, _) = get_accessor_name(&enum_values, json_name);
            if let Some(enum_value) = enum_value {
                case_names.push(" = ".into());
                case_names.push(enum_value.into());
            }
            Ok(())
        })?;
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_line(sl![
            "enum class ",
            enum_name,
            " : ",
            self.enum_type.clone(),
            " { ",
            Source::Sequence(case_names),
            " };"
        ]);
        Ok(())
    }

    /// `emitUnionTypedefs(u, unionName)`: a `using` of the variant, or a
    /// struct deriving from it for a recursive union.
    fn emit_union_typedefs(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let variant_type = self.variant_type_for(u, false)?;
        if !self.is_recursive_union(u)? {
            self.emit_line(sl!["using ", union_name, " = ", variant_type, ";"]);
            return Ok(());
        }

        // A struct introduces its name before the base type is parsed,
        // allowing recursion through containers such as std::vector.
        self.emit_block(
            sl!["struct ", union_name, " : ", variant_type.clone()],
            true,
            |r| {
                r.emit_line(sl!["using base = ", variant_type, ";"]);
                r.emit_line("using base::base;");
                r.emit_line("using base::operator=;");
                Ok(())
            },
        )
    }

    /// `emitUnionWrapperHeaders(u, unionName)`.
    fn emit_union_wrapper_headers(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        if !self.is_recursive_union(u)? {
            return Ok(());
        }

        let json = self.with_const("json");
        self.emit_line(sl!["void from_json(", json, " & j, ", union_name, " & x);"]);
        let x = self.with_const(union_name);
        self.emit_line(sl!["void to_json(json & j, ", x, " & x);"]);
        Ok(())
    }

    /// `emitUnionWrapperFunctions(u, unionName)`.
    fn emit_union_wrapper_functions(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        if !self.is_recursive_union(u)? {
            return Ok(());
        }

        let json = self.with_const("json");
        self.emit_block_with(
            sl![
                "inline void from_json(",
                json,
                " & j, ",
                union_name,
                " & x)"
            ],
            false,
            true,
            |r| {
                r.emit_line(sl!["x = j.get<", union_name, "::base>();"]);
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        let x = self.with_const(union_name);
        self.emit_block_with(
            sl!["inline void to_json(json & j, ", x, " & x)"],
            false,
            true,
            |r| {
                let base = r.with_const(sl![union_name, "::base"]);
                r.emit_line(sl!["j = static_cast<", base, " &>(x);"]);
                Ok(())
            },
        )
    }

    /// The variant of a union's non-null members in `namespace nlohmann`.
    fn union_variant_in_json_namespace(&self, u: TypeRef) -> Result<UnionVariant> {
        let (_, non_nulls) = remove_null_from_union(self.type_graph(), u, NullRemovalSort::ByKind)?;
        let variant_type =
            self.cpp_type_in_optional(&non_nulls, plain_context(true), false, false)?;
        Ok(UnionVariant {
            text: self.sourcelike_to_string(&variant_type)?,
            non_nulls,
            variant_type,
        })
    }

    /// `emitUnionHeaders(u)`: the `adl_serializer` specialization for the
    /// union's variant (also for variants of types not defined by us).
    fn emit_union_headers(&mut self, variant: UnionVariant) -> Result<()> {
        let variant_type = variant.variant_type;

        self.emit_line("template <>");
        self.emit_block(
            sl!["struct adl_serializer<", variant_type.clone(), ">"],
            true,
            |r| {
                let json = r.with_const("json");
                r.emit_line(sl![
                    "static void from_json(",
                    json,
                    " & j, ",
                    variant_type.clone(),
                    " & x);"
                ]);
                let x = r.with_const(variant_type);
                r.emit_line(sl!["static void to_json(json & j, ", x, " & x);"]);
                Ok(())
            },
        )
    }

    /// `emitUnionFunctions(u)`: the `adl_serializer` definitions for the
    /// union's variant.
    fn emit_union_functions(&mut self, variant: UnionVariant) -> Result<()> {
        let our_qualifier = self.our_qualifier(true);

        const FUNCTION_FOR_KIND: [(TypeKind, &str); 10] = [
            (TypeKind::Bool, "is_boolean"),
            (TypeKind::Integer, "is_number_integer"),
            (TypeKind::Double, "is_number"),
            (TypeKind::String, "is_string"),
            (TypeKind::Uuid, "is_string"),
            (TypeKind::DateTime, "is_string"),
            (TypeKind::Class, "is_object"),
            (TypeKind::Map, "is_object"),
            (TypeKind::Array, "is_array"),
            (TypeKind::Enum, "is_string"),
        ];
        let UnionVariant {
            non_nulls,
            variant_type,
            ..
        } = variant;

        let json = self.with_const("json");
        self.emit_block_with(
            sl![
                "inline void adl_serializer<",
                variant_type.clone(),
                ">::from_json(",
                json,
                " & j, ",
                variant_type.clone(),
                " & x)"
            ],
            false,
            true,
            |r| {
                let mut on_first = true;
                for (kind, func) in FUNCTION_FOR_KIND {
                    let mut type_for_kind = None;
                    for &t in &non_nulls {
                        if r.type_graph().kind(t)? == kind {
                            type_for_kind = Some(t);
                            break;
                        }
                    }
                    let Some(type_for_kind) = type_for_kind else {
                        continue;
                    };
                    r.emit_line(sl![
                        if on_first { "if" } else { "else if" },
                        " (j.",
                        func,
                        "())"
                    ]);
                    r.indent(|r| {
                        let cpp_type =
                            r.cpp_type(type_for_kind, JSON_NAMESPACE_CONTEXT, false, true, false)?;
                        let to_type =
                            r.cpp_type(type_for_kind, JSON_NAMESPACE_CONTEXT, false, false, false)?;
                        let value = r.wrap_encoding_change(
                            sl![our_qualifier.clone()],
                            cpp_type.clone(),
                            to_type,
                            sl!["j.get<", cpp_type, ">()"],
                        )?;
                        r.emit_line(sl!["x = ", value, ";"]);
                        Ok(())
                    })?;
                    on_first = false;
                }

                r.emit_line("else throw std::runtime_error(\"Could not deserialise!\");");
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        let x = self.with_const(variant_type.clone());
        self.emit_block_with(
            sl![
                "inline void adl_serializer<",
                variant_type,
                ">::to_json(json & j, ",
                x,
                " & x)"
            ],
            false,
            true,
            |r| {
                let index_method = r.variant_index_method_name;
                r.emit_block_with(sl!["switch (x.", index_method, "())"], false, true, |r| {
                    for (i, &t) in non_nulls.iter().enumerate() {
                        r.emit_line(sl!["case ", i.to_string(), ":"]);
                        r.indent(|r| {
                            let cpp_type =
                                r.cpp_type(t, JSON_NAMESPACE_CONTEXT, false, false, false)?;
                            let to_type =
                                r.cpp_type(t, JSON_NAMESPACE_CONTEXT, false, true, false)?;
                            let get = if r.options.boost {
                                "boost::get<"
                            } else {
                                "std::get<"
                            };
                            let value = r.wrap_encoding_change(
                                sl![our_qualifier.clone()],
                                cpp_type.clone(),
                                to_type,
                                sl![get, cpp_type, ">(x)"],
                            )?;
                            r.emit_line(sl!["j = ", value, ";"]);
                            r.emit_line("break;");
                            Ok(())
                        })?;
                    }

                    r.emit_line(
                        "default: throw std::runtime_error(\"Input JSON does not conform to schema!\");",
                    );
                    Ok(())
                })
            },
        )
    }

    /// `emitEnumHeaders(enumName)`.
    fn emit_enum_headers(&mut self, enum_name: Name) {
        let our_qualifier = self.our_qualifier(false);
        let json = self.with_const("json");
        self.emit_line(sl![
            "void from_json(",
            json,
            " & j, ",
            our_qualifier.clone(),
            enum_name,
            " & x);"
        ]);
        let x = self.with_const(sl![our_qualifier, enum_name]);
        self.emit_line(sl!["void to_json(json & j, ", x, " & x);"]);
    }

    /// `isLargeEnum(e)`: an estimate of when a lookup table beats a chain
    /// of comparisons.
    fn is_large_enum(&self, e: TypeRef) -> Result<bool> {
        Ok(self.type_graph().type_at(e)?.cases()?.len() > 15)
    }

    /// `emitEnumFunctions(e, enumName)`.
    fn emit_enum_functions(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let our_qualifier = self.our_qualifier(false);

        let json = self.with_const("json");
        self.emit_block_with(
            sl![
                "inline void from_json(",
                json,
                " & j, ",
                our_qualifier.clone(),
                enum_name,
                " & x)"
            ],
            false,
            true,
            |r| {
                if r.is_large_enum(e)? {
                    let string_type = r.string_type.get_type();
                    r.emit_block(
                        sl![
                            "static std::unordered_map<",
                            string_type,
                            ", ",
                            our_qualifier.clone(),
                            enum_name,
                            "> enumValues"
                        ],
                        true,
                        |r| {
                            r.for_each_enum_case(
                                e,
                                BlankLinePosition::None,
                                |r, name, json_name, _| {
                                    let key = r.wrap_string_key(
                                        &our_qualifier,
                                        sl![r.string_literal(json_name)],
                                    )?;
                                    r.emit_line(sl![
                                        "{",
                                        key,
                                        ", ",
                                        our_qualifier.clone(),
                                        enum_name,
                                        "::",
                                        name,
                                        "},"
                                    ]);
                                    Ok(())
                                },
                            )
                        },
                    )?;

                    r.emit_line(format!(
                        "auto iter = enumValues.find(j.get<{string_type}>());"
                    ));
                    r.emit_block_with("if (iter != enumValues.end())", false, true, |r| {
                        r.emit_line("x = iter->second;");
                        Ok(())
                    })?;
                } else {
                    let mut on_first = true;
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        let maybe_else = if on_first { "" } else { "else " };
                        let key =
                            r.wrap_string_key(&our_qualifier, sl![r.string_literal(json_name)])?;
                        r.emit_line(sl![
                            maybe_else,
                            "if (j == ",
                            key,
                            ") x = ",
                            our_qualifier.clone(),
                            enum_name,
                            "::",
                            name,
                            ";"
                        ]);
                        on_first = false;
                        Ok(())
                    })?;
                }
                r.emit_line(sl![
                    "else { throw std::runtime_error(\"Cannot deserialize to enumeration \\\"",
                    enum_name,
                    "\\\"\"); }"
                ]);
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        let x = self.with_const(sl![our_qualifier.clone(), enum_name]);
        self.emit_block_with(
            sl!["inline void to_json(json & j, ", x, " & x)"],
            false,
            true,
            |r| {
                r.emit_block_with("switch (x)", false, true, |r| {
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        let value =
                            r.wrap_string_key(&our_qualifier, sl![r.string_literal(json_name)])?;
                        r.emit_line(sl![
                            "case ",
                            our_qualifier.clone(),
                            enum_name,
                            "::",
                            name,
                            ": j = ",
                            value,
                            "; break;"
                        ]);
                        Ok(())
                    })?;
                    r.emit_line(sl![
                        "default: throw std::runtime_error(\"Unexpected value in enumeration \\\"",
                        enum_name,
                        "\\\": \" + std::to_string(static_cast<int>(x)));"
                    ]);
                    Ok(())
                })
            },
        )
    }

    /// `emitTopLevelTypedef(t, name)`.
    fn emit_top_level_typedef(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let cpp_type = self.cpp_type(t, MEMBER_CONTEXT, true, false, false)?;
        self.emit_line(sl!["using ", name, " = ", cpp_type, ";"]);
        Ok(())
    }

    /// `emitAllUnionFunctions()`: once per distinct variant.
    fn emit_all_union_functions(&mut self) -> Result<()> {
        self.for_each_unique_union(
            BlankLinePosition::LeadingAndInterposing,
            |r, u| r.union_variant_in_json_namespace(u),
            |r, _, variant, _| r.emit_union_functions(variant),
        )
    }

    /// `emitAllUnionHeaders()`: once per distinct variant.
    fn emit_all_union_headers(&mut self) -> Result<()> {
        self.for_each_unique_union(
            BlankLinePosition::Interposing,
            |r, u| r.union_variant_in_json_namespace(u),
            |r, _, variant, _| r.emit_union_headers(variant),
        )
    }

    /// `emitOptionalHelpers()`: `adl_serializer`s for the optionals.
    fn emit_optional_helpers(&mut self) -> Result<()> {
        self.emit_line("#ifndef NLOHMANN_OPT_HELPER");
        self.emit_line("#define NLOHMANN_OPT_HELPER");

        self.emit_nlohmann_namespace(|r| {
            let heap = (r.optional_type_heap(), r.optional_factory_heap());
            let stack = (r.optional_type_stack(), r.optional_factory_stack());
            for (opt_type, factory) in [heap, stack] {
                r.emit_line("template <typename T>");
                r.emit_block(
                    sl!["struct adl_serializer<", opt_type, "<T>>"],
                    true,
                    |r| {
                        let opt = r.with_const(sl![opt_type, "<T>"]);
                        r.emit_block_with(
                            sl!["static void to_json(json & j, ", opt, " & opt)"],
                            false,
                            true,
                            |r| {
                                r.emit_line("if (!opt) j = nullptr; else j = *opt;");
                                Ok(())
                            },
                        )?;

                        r.ensure_blank_line();

                        let json = r.with_const("json");
                        r.emit_block_with(
                            sl!["static ", opt_type, "<T> from_json(", json, " & j)"],
                            false,
                            true,
                            |r| {
                                // A JSON null must become an *empty* optional.
                                // Only `optType<T>()` guarantees that: the
                                // factory would wrap a default-constructed T.
                                r.emit_line(format!(
                                    "if (j.is_null()) return {opt_type}<T>(); else return {factory}<T>(j.get<T>());"
                                ));
                                Ok(())
                            },
                        )
                    },
                )?;
            }
            Ok(())
        })?;

        self.emit_line("#endif");
        Ok(())
    }

    /// `emitDeclaration(decl)`.
    fn emit_declaration(&mut self, decl: Declaration) -> Result<()> {
        let t = decl.type_ref;
        match decl.kind {
            DeclarationKind::Forward => {
                let name = self.name_for_named_type(t)?;
                if self.options.code_format {
                    self.emit_line(sl!["class ", name, ";"]);
                } else {
                    self.emit_line(sl!["struct ", name, ";"]);
                }
                Ok(())
            }
            DeclarationKind::Define => {
                let name = self.name_for_named_type(t)?;
                match self.type_graph().kind(t)? {
                    TypeKind::Class => self.emit_class(t, name),
                    TypeKind::Enum => self.emit_enum(t, name),
                    TypeKind::Union => self.emit_union_typedefs(t, name),
                    kind => panic(format!("Cannot declare type {kind}")),
                }
            }
        }
    }

    // ---- Helpers ------------------------------------------------------------

    /// `emitGetterSetter(t, getterName, setterName, memberName)`.
    fn emit_getter_setter(
        &mut self,
        t: &str,
        getter_name: &str,
        setter_name: &str,
        member_name: &str,
    ) {
        self.emit_line(sl![
            "void ",
            setter_name,
            "(",
            t,
            " ",
            member_name,
            ") { this->",
            member_name,
            " = ",
            member_name,
            "; }"
        ]);
        self.emit_line(sl![
            "auto ",
            getter_name,
            "() const { return ",
            member_name,
            "; }"
        ]);
    }

    /// The `throw` of a failed constraint check: `throw Exception (L"msg" +
    /// name + L" (" + value + L"op" + bound + L")");`.
    fn emit_constraint_throw(
        &mut self,
        exception: GlobalNames,
        message: &str,
        value: Source,
        op: &str,
        bound: Source,
    ) -> Result<()> {
        let exception = self.lookup_global_name(exception)?;
        let st = &self.string_type;
        let line = sl![
            "throw ",
            exception,
            " (",
            st.create_string_literal(sl![message]),
            " + name + ",
            st.create_string_literal(sl![" ("]),
            " + ",
            st.wrap_to_string(value),
            " + ",
            st.create_string_literal(sl![op]),
            " + ",
            st.wrap_to_string(bound),
            " + ",
            st.create_string_literal(sl![")"]),
            ");"
        ];
        self.emit_line(line);
        Ok(())
    }

    /// `emitNumericCheckConstraints(checkConst, classConstraint,
    /// getterMinValue, getterMaxValue, cppType)`.
    fn emit_numeric_check_constraints(
        &mut self,
        check_const: &str,
        class_constraint: &str,
        getter_min_value: &str,
        getter_max_value: &str,
        cpp_type: &str,
    ) -> Result<()> {
        let constraint = self.with_const(class_constraint);
        self.emit_block_with(
            sl![
                "inline void ",
                check_const,
                "(",
                self.string_type.get_const_type(),
                " name, ",
                constraint.clone(),
                " & c, ",
                cpp_type,
                " value)"
            ],
            false,
            true,
            |r| {
                let nullopt = r.nullopt_type;
                r.emit_block_with(
                    sl![
                        "if (c.",
                        getter_min_value,
                        "() != ",
                        nullopt,
                        " && value < *c.",
                        getter_min_value,
                        "())"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_constraint_throw(
                            GlobalNames::ValueTooLowException,
                            "Value too low for ",
                            sl!["value"],
                            "<",
                            sl!["*c.", getter_min_value, "()"],
                        )
                    },
                )?;
                r.ensure_blank_line();

                r.emit_block_with(
                    sl![
                        "if (c.",
                        getter_max_value,
                        "() != ",
                        nullopt,
                        " && value > *c.",
                        getter_max_value,
                        "())"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_constraint_throw(
                            GlobalNames::ValueTooHighException,
                            "Value too high for ",
                            sl!["value"],
                            ">",
                            sl!["*c.", getter_max_value, "()"],
                        )
                    },
                )?;
                r.ensure_blank_line();
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        self.emit_block_with(
            sl![
                "inline void ",
                check_const,
                "(",
                self.string_type.get_const_type(),
                " name, ",
                constraint,
                " & c, const ",
                self.optional_type,
                "<",
                cpp_type,
                "> & value)"
            ],
            false,
            true,
            |r| {
                r.emit_block_with(sl!["if (value)"], false, true, |r| {
                    r.emit_line(sl![check_const, "(name, c, *value);"]);
                    Ok(())
                })
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitConstraintClasses()`: the constraint class, its exceptions and
    /// the check functions.
    fn emit_constraint_classes(&mut self) -> Result<()> {
        let our_qualifier = self.our_qualifier(false);

        let getter_min_int_value = self.lookup_member_name(MemberNames::GetMinIntValue)?;
        let getter_max_int_value = self.lookup_member_name(MemberNames::GetMaxIntValue)?;
        let getter_min_double_value = self.lookup_member_name(MemberNames::GetMinDoubleValue)?;
        let getter_max_double_value = self.lookup_member_name(MemberNames::GetMaxDoubleValue)?;
        let getter_min_length = self.lookup_member_name(MemberNames::GetMinLength)?;
        let getter_max_length = self.lookup_member_name(MemberNames::GetMaxLength)?;
        let getter_pattern = self.lookup_member_name(MemberNames::GetPattern)?;
        let class_constraint = self.lookup_global_name(GlobalNames::ClassMemberConstraints)?;

        self.emit_block(sl!["class ", class_constraint.as_str()], true, |r| {
            r.emit_line("private:");
            let constraint_members = r.get_constraint_members();
            for member in &constraint_members {
                let name = r.lookup_member_name(member.name)?;
                r.emit_member(
                    sl![r.optional_type, "<", member.cpp_type.as_str(), ">"],
                    name,
                    None,
                );
            }

            r.ensure_blank_line();
            r.emit_line("public:");
            r.emit_line(sl![class_constraint.as_str(), "("]);
            r.indent(|r| {
                r.iterable_for_each(&constraint_members, |r, member, pos| {
                    let comma: Source =
                        if matches!(pos, ForEachPosition::First | ForEachPosition::Middle) {
                            ",".into()
                        } else {
                            sl![]
                        };
                    let name = r.lookup_member_name(member.name)?;
                    r.emit_line(sl![
                        r.optional_type,
                        "<",
                        member.cpp_type.as_str(),
                        "> ",
                        name,
                        comma
                    ]);
                    Ok(())
                })
            })?;

            let mut args = Vec::with_capacity(constraint_members.len());
            for member in &constraint_members {
                let name = r.lookup_member_name(member.name)?;
                args.push(sl![name.as_str(), "(", name.as_str(), ")"]);
            }
            r.emit_line(sl![
                ") : ",
                Source::Sequence(array_intercalate(", ".into(), args)),
                " {}"
            ]);

            r.emit_line(sl![class_constraint.as_str(), "() = default;"]);
            r.emit_line(sl!["virtual ~", class_constraint.as_str(), "() = default;"]);
            for member in &constraint_members {
                r.ensure_blank_line();
                let t = member.cpp_const_type.as_ref().unwrap_or(&member.cpp_type);
                let getter = r.lookup_member_name(member.getter)?;
                let setter = r.lookup_member_name(member.setter)?;
                let name = r.lookup_member_name(member.name)?;
                r.emit_getter_setter(t, &getter, &setter, &name);
            }
            Ok(())
        })?;
        self.ensure_blank_line();

        let class_const_ex =
            self.lookup_global_name(GlobalNames::ClassMemberConstraintException)?;
        self.emit_block(
            sl![
                "class ",
                class_const_ex.as_str(),
                " : public std::runtime_error"
            ],
            true,
            |r| {
                r.emit_line("public:");
                let msg = r.wrap_string_key(&our_qualifier, sl!["msg"])?;
                r.emit_line(sl![
                    class_const_ex.as_str(),
                    "(",
                    r.string_type.get_const_type(),
                    " msg) : std::runtime_error(",
                    msg,
                    ") {}"
                ]);
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        let exceptions = [
            GlobalNames::ValueTooLowException,
            GlobalNames::ValueTooHighException,
            GlobalNames::ValueTooShortException,
            GlobalNames::ValueTooLongException,
            GlobalNames::InvalidPatternException,
        ];

        for ex in exceptions {
            let name = self.lookup_global_name(ex)?;
            self.emit_block(
                sl![
                    "class ",
                    name.as_str(),
                    " : public ",
                    class_const_ex.as_str()
                ],
                true,
                |r| {
                    r.emit_line("public:");
                    r.emit_line(sl![
                        name.as_str(),
                        "(",
                        r.string_type.get_const_type(),
                        " msg) : ",
                        class_const_ex.as_str(),
                        "(msg) {}"
                    ]);
                    Ok(())
                },
            )?;
            self.ensure_blank_line();
        }

        let check_const = self.lookup_global_name(GlobalNames::CheckConstraint)?;
        self.emit_numeric_check_constraints(
            &check_const,
            &class_constraint,
            &getter_min_int_value,
            &getter_max_int_value,
            "int64_t",
        )?;
        self.emit_numeric_check_constraints(
            &check_const,
            &class_constraint,
            &getter_min_double_value,
            &getter_max_double_value,
            "double",
        )?;

        let code_point_length = self.lookup_global_name(GlobalNames::CodePointLength)?;
        self.emit_block_with(
            sl![
                "inline size_t ",
                code_point_length.as_str(),
                "(",
                self.string_type.get_const_type(),
                " value)"
            ],
            false,
            true,
            |r| {
                let (ch_type, is_code_point_start) = if r.options.wstring {
                    ("wchar_t", "(ch & 0xFC00) != 0xDC00")
                } else {
                    ("char", "(static_cast<unsigned char>(ch) & 0xC0) != 0x80")
                };
                r.emit_line(format!(
                    "return std::count_if(value.begin(), value.end(), []({ch_type} ch) {{ return {is_code_point_start}; }});"
                ));
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        let constraint = self.with_const(class_constraint.as_str());
        let const_type = self.string_type.get_const_type();
        self.emit_block_with(
            sl![
                "inline void ",
                check_const.as_str(),
                "(",
                const_type,
                " name, ",
                constraint.clone(),
                " & c, ",
                const_type,
                " value)"
            ],
            false,
            true,
            |r| {
                let nullopt = r.nullopt_type;
                r.emit_block_with(
                    sl![
                        "if (c.",
                        getter_min_length.as_str(),
                        "() != ",
                        nullopt,
                        " && ",
                        code_point_length.as_str(),
                        "(value) < *c.",
                        getter_min_length.as_str(),
                        "())"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_constraint_throw(
                            GlobalNames::ValueTooShortException,
                            "Value too short for ",
                            sl![code_point_length.as_str(), "(value)"],
                            "<",
                            sl!["*c.", getter_min_length.as_str(), "()"],
                        )
                    },
                )?;
                r.ensure_blank_line();

                r.emit_block_with(
                    sl![
                        "if (c.",
                        getter_max_length.as_str(),
                        "() != ",
                        nullopt,
                        " && ",
                        code_point_length.as_str(),
                        "(value) > *c.",
                        getter_max_length.as_str(),
                        "())"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_constraint_throw(
                            GlobalNames::ValueTooLongException,
                            "Value too long for ",
                            sl![code_point_length.as_str(), "(value)"],
                            ">",
                            sl!["*c.", getter_max_length.as_str(), "()"],
                        )
                    },
                )?;
                r.ensure_blank_line();

                r.emit_block_with(
                    sl!["if (c.", getter_pattern.as_str(), "() != ", nullopt, ")"],
                    false,
                    true,
                    |r| {
                        r.emit_line(sl![r.string_type.get_smatch(), " result;"]);
                        r.emit_line(sl![
                            "std::regex_search(value, result, ",
                            r.string_type.get_regex(),
                            "( *c.",
                            getter_pattern.as_str(),
                            "() ));"
                        ]);
                        r.emit_block_with(sl!["if (result.empty())"], false, true, |r| {
                            let exception =
                                r.lookup_global_name(GlobalNames::InvalidPatternException)?;
                            let st = &r.string_type;
                            let line = sl![
                                "throw ",
                                exception,
                                " (",
                                st.create_string_literal(sl!["Value doesn't match pattern for "]),
                                " + name + ",
                                st.create_string_literal(sl![" ("]),
                                " + value +",
                                st.create_string_literal(sl![" != "]),
                                " + *c.",
                                getter_pattern.as_str(),
                                "() + ",
                                st.create_string_literal(sl![")"]),
                                ");"
                            ];
                            r.emit_line(line);
                            Ok(())
                        })
                    },
                )?;
                r.ensure_blank_line();
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        self.emit_block_with(
            sl![
                "inline void ",
                check_const.as_str(),
                "(",
                const_type,
                " name, ",
                constraint,
                " & c, const ",
                self.optional_type,
                "<",
                self.string_type.get_type(),
                "> & value)"
            ],
            false,
            true,
            |r| {
                r.emit_block_with(sl!["if (value)"], false, true, |r| {
                    r.emit_line(sl![check_const.as_str(), "(name, c, *value);"]);
                    Ok(())
                })
            },
        )
    }

    /// `haveConstraintClasses`: with getters and setters, whether any type
    /// has constraints.
    fn have_constraint_classes(&self) -> Result<bool> {
        if !self.options.code_format {
            return Ok(false);
        }
        let graph = self.type_graph();
        for t in graph.all_types_unordered() {
            if constraints_for_type(graph, t)?.is_some() {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// `emitHelperFunctions()`.
    fn emit_helper_functions(&mut self) -> Result<()> {
        if self.string_type.kind == StringKind::Wide {
            self.emit_wide_string_helper_functions()?;
        }

        if self.have_constraint_classes()? {
            self.emit_constraint_classes()?;
            self.ensure_blank_line();
        }

        self.ensure_blank_line();

        let mut untyped_macro_name = "NLOHMANN_UNTYPED_".to_owned();
        let mut optional_macro_name = "NLOHMANN_OPTIONAL_".to_owned();
        for value in &self.namespace_names {
            // We can't use upper name, because namespaces are case sensitive
            untyped_macro_name.push_str(value);
            untyped_macro_name.push('_');

            optional_macro_name.push_str(value);
            optional_macro_name.push('_');
        }

        untyped_macro_name.push_str("HELPER");
        optional_macro_name.push_str("HELPER");

        self.emit_line(format!("#ifndef {untyped_macro_name}"));
        self.emit_line(format!("#define {untyped_macro_name}"));

        let json = self.with_const("json");
        let char = self.with_const("char");
        self.emit_block_with(
            sl![
                "inline json get_untyped(",
                json.clone(),
                " & j, ",
                char.clone(),
                " * property)"
            ],
            false,
            true,
            |r| {
                r.emit_block_with(sl!["if (j.find(property) != j.end())"], false, true, |r| {
                    r.emit_line("return j.at(property).get<json>();");
                    Ok(())
                })?;
                r.emit_line("return json();");
                Ok(())
            },
        )?;

        self.ensure_blank_line();

        self.emit_block_with(
            sl![
                "inline json get_untyped(",
                json.clone(),
                " & j, std::string property)"
            ],
            false,
            true,
            |r| {
                r.emit_line("return get_untyped(j, property.data());");
                Ok(())
            },
        )?;

        self.emit_line("#endif");

        self.ensure_blank_line();

        if self.have_unions()? || self.have_optional_properties()? {
            self.ensure_blank_line();

            self.emit_line(format!("#ifndef {optional_macro_name}"));
            self.emit_line(format!("#define {optional_macro_name}"));

            let heap = (self.optional_type_heap(), "heap");
            let stack = (self.optional_type_stack(), "stack");
            for (optional_type, label) in [heap, stack] {
                self.emit_line("template <typename T>");
                self.emit_block_with(
                    sl![
                        "inline ",
                        optional_type,
                        format!("<T> get_{label}_optional("),
                        json.clone(),
                        " & j, ",
                        char.clone(),
                        " * property)"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_line(sl!["auto it = j.find(property);"]);
                        r.emit_block_with(
                            sl!["if (it != j.end() && !it->is_null())"],
                            false,
                            true,
                            |r| {
                                r.emit_line(sl![
                                    "return j.at(property).get<",
                                    optional_type,
                                    "<T>>();"
                                ]);
                                Ok(())
                            },
                        )?;
                        r.emit_line(sl!["return ", optional_type, "<T>();"]);
                        Ok(())
                    },
                )?;

                self.ensure_blank_line();

                self.emit_line("template <typename T>");
                self.emit_block_with(
                    sl![
                        "inline ",
                        optional_type,
                        format!("<T> get_{label}_optional("),
                        json.clone(),
                        " & j, std::string property)"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_line(format!(
                            "return get_{label}_optional<T>(j, property.data());"
                        ));
                        Ok(())
                    },
                )?;
            }

            self.emit_line("#endif");

            self.ensure_blank_line();
        }
        Ok(())
    }

    /// `WideString.emitHelperFunctions()`: the `Utf16_Utf8` converter and
    /// `wdump`.
    fn emit_wide_string_helper_functions(&mut self) -> Result<()> {
        self.emit_line("template<typename T>");
        self.emit_line("struct tag {};");
        self.ensure_blank_line();

        self.emit_line("template<typename fromType, typename toType>");
        self.emit_block(sl!["class Utf16_Utf8"], true, |r| {
            r.emit_line("private:");
            r.emit_line("template<typename TF, typename TT>");
            r.emit_block_with(
                sl!["static toType convert(tag<std::shared_ptr<TF> >, tag<std::shared_ptr<TT> >, fromType ptr)"],
                false,
                true,
                |r| {
                    r.emit_line("if (ptr == nullptr) return std::unique_ptr<TT>(); else return std::unique_ptr<TT>(new TT(Utf16_Utf8<TF,TT>::convert(*ptr)));");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            if r.have_optional_properties()? {
                r.emit_line("template<typename TF, typename TT>");
                let optional_type = r.optional_type;
                r.emit_block_with(
                    sl![
                        "static toType convert(tag<",
                        optional_type,
                        "<TF> >, tag<",
                        optional_type,
                        "<TT> >, fromType opt)"
                    ],
                    false,
                    true,
                    |r| {
                        r.emit_line("if (!opt) return toType(); else return toType(Utf16_Utf8<TF,TT>::convert(*opt));");
                        Ok(())
                    },
                )?;
                r.ensure_blank_line();
            }

            r.emit_line("template<typename TF, typename TT>");
            r.emit_block_with(
                sl!["static toType convert(tag<std::vector<TF> >, tag<std::vector<TT> >, fromType v)"],
                false,
                true,
                |r| {
                    r.emit_line("auto it = v.begin();");
                    r.emit_line("auto newVector = std::vector<TT>();");
                    r.emit_block_with(sl!["while (it != v.end())"], false, true, |r| {
                        r.emit_line("newVector.push_back(Utf16_Utf8<TF,TT>::convert(*it));");
                        r.emit_line("it++;");
                        Ok(())
                    })?;
                    r.emit_line("return newVector;");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            r.emit_line("template<typename KF, typename VF, typename KT, typename VT>");
            r.emit_block_with(
                sl!["static toType convert(tag<std::map<KF,VF> >, tag<std::map<KT,VT> >, fromType m)"],
                false,
                true,
                |r| {
                    r.emit_line("auto it = m.begin();");
                    r.emit_line("auto newMap = std::map<KT, VT>();");
                    r.emit_block_with(sl!["while (it != m.end())"], false, true, |r| {
                        r.emit_line("newMap.insert(std::pair<KT, VT>(Utf16_Utf8<KF, KT>::convert(it->first), Utf16_Utf8<VF, VT>::convert(it->second)));");
                        r.emit_line("it++;");
                        Ok(())
                    })?;
                    r.emit_line("return newMap;");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            r.emit_line("template<typename TF, typename TT>");
            r.emit_block_with(
                sl!["static fromType convert(tag<TF>, tag<TT>, fromType from)"],
                false,
                true,
                |r| {
                    r.emit_line("return from;");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            r.emit_block_with(
                sl!["static std::wstring convert(tag<std::string>, tag<std::wstring>, std::string str)"],
                false,
                true,
                |r| {
                    r.emit_line("return std::wstring_convert<std::codecvt_utf8_utf16<wchar_t, 0x10ffff, std::little_endian>, wchar_t>{}.from_bytes(str.data());");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            r.emit_block_with(
                sl!["static std::string convert(tag<std::wstring>, tag<std::string>, std::wstring str)"],
                false,
                true,
                |r| {
                    r.emit_line("return std::wstring_convert<std::codecvt_utf8_utf16<wchar_t, 0x10ffff, std::little_endian>, wchar_t>{}.to_bytes(str.data());");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            r.emit_line("public:");
            r.emit_block_with(sl!["static toType convert(fromType in)"], false, true, |r| {
                r.emit_line("return convert(tag<fromType>(), tag<toType>(), in);");
                Ok(())
            })
        })?;
        self.ensure_blank_line();

        self.emit_line("template<typename T>");
        self.emit_block_with(sl!["std::wstring wdump(const T& j)"], false, true, |r| {
            r.emit_line("std::ostringstream s;");
            r.emit_line("s << j;");
            let our_qualifier = r.our_qualifier(false);
            r.emit_line(sl![
                "return ",
                our_qualifier,
                "Utf16_Utf8<std::string, std::wstring>::convert(s.str()); "
            ]);
            Ok(())
        })?;
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitExtraIncludes()`.
    fn emit_extra_includes(&mut self) -> Result<()> {
        self.ensure_blank_line();

        if self.options.code_format {
            if self.options.boost {
                self.emit_include(true, "boost/optional.hpp");
            } else {
                self.emit_include(true, "optional");
            }

            self.emit_include(true, "stdexcept");
            self.emit_include(true, "regex");
        }

        if self.have_constraint_classes()? {
            self.emit_include(true, "algorithm");
        }

        if self.options.wstring {
            self.emit_include(true, "codecvt");
            self.emit_include(true, "locale");
        }

        // Include unordered_map if contains large enums
        let mut have_large_enum = false;
        for &e in self.enums()? {
            if self.is_large_enum(e)? {
                have_large_enum = true;
                break;
            }
        }
        if have_large_enum {
            self.emit_include(true, "unordered_map");
        }

        self.ensure_blank_line();
        Ok(())
    }

    /// `emitHelper()`: `helper.hpp` of the multi-source output.
    fn emit_helper(&mut self) -> Result<()> {
        self.start_file("helper.hpp", false)?;

        self.emit_extra_includes()?;

        self.emit_include(true, "sstream");
        self.ensure_blank_line();
        self.emit_our_namespaces(|r| {
            r.emit_line("using nlohmann::json;");
            r.ensure_blank_line();
            r.emit_helper_functions()
        })?;

        if self.have_unions()? || self.have_optional_properties()? {
            self.ensure_blank_line();
            self.emit_optional_helpers()?;
        }

        self.finish_current_file()
    }

    // ---- Structure ----------------------------------------------------------

    /// `emitTypes()`: the helpers, the declarations and the top-level
    /// aliases.
    fn emit_types(&mut self) -> Result<()> {
        if !self.options.just_types {
            self.emit_line("using nlohmann::json;");
            self.ensure_blank_line();
            self.emit_helper_functions()?;
        }

        let mut have_recursive_union = false;
        let unions: Vec<TypeRef> = self.named_unions()?.iter().copied().collect();
        for u in unions {
            if self.is_recursive_union(u)? {
                have_recursive_union = true;
                break;
            }
        }
        if have_recursive_union {
            self.for_each_union(BlankLinePosition::None, |r, u, union_name, _| {
                if r.is_recursive_union(u)? {
                    r.emit_line(sl!["struct ", union_name, ";"]);
                }
                Ok(())
            })?;
            self.ensure_blank_line();
        }

        self.for_each_declaration(BlankLinePosition::Interposing, |r, decl, _| {
            r.emit_declaration(decl)
        })?;
        if self.options.just_types {
            return Ok(());
        }
        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, name, _| r.emit_top_level_typedef(t, name),
        )?;
        Ok(())
    }

    /// `gatherUserNamespaceForwardDecls()`.
    fn gather_user_namespace_forward_decls(&mut self) -> Result<Vec<Source>> {
        self.gather_source(|r| {
            r.for_each_object(
                BlankLinePosition::LeadingAndInterposing,
                |r, _, class_name, _| {
                    r.emit_class_headers(class_name);
                    Ok(())
                },
            )?;

            r.for_each_enum(
                BlankLinePosition::LeadingAndInterposing,
                |r, _, enum_name, _| {
                    r.emit_enum_headers(enum_name);
                    Ok(())
                },
            )?;

            r.for_each_union(
                BlankLinePosition::LeadingAndInterposing,
                |r, u, union_name, _| r.emit_union_wrapper_headers(u, union_name),
            )
        })
    }

    /// `gatherNlohmannNamespaceForwardDecls()`.
    fn gather_nlohmann_namespace_forward_decls(&mut self) -> Result<Vec<Source>> {
        self.gather_source(|r| {
            r.for_each_top_level(
                BlankLinePosition::LeadingAndInterposing,
                |r, t, class_name, _| r.emit_top_level_headers(t, class_name),
            )?;

            r.ensure_blank_line();

            r.emit_all_union_headers()
        })
    }

    /// `emitUserNamespaceImpls()`.
    fn emit_user_namespace_impls(&mut self) -> Result<()> {
        self.for_each_object(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.emit_class_functions(c, class_name),
        )?;

        self.for_each_enum(
            BlankLinePosition::LeadingAndInterposing,
            |r, e, enum_name, _| r.emit_enum_functions(e, enum_name),
        )?;

        self.for_each_union(
            BlankLinePosition::LeadingAndInterposing,
            |r, u, union_name, _| r.emit_union_wrapper_functions(u, union_name),
        )
    }

    /// `emitNlohmannNamespaceImpls()`.
    fn emit_nlohmann_namespace_impls(&mut self) -> Result<()> {
        self.for_each_top_level_where(
            BlankLinePosition::LeadingAndInterposing,
            |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, name, _| r.emit_top_level_function(t, name),
        )?;

        self.ensure_blank_line();

        self.emit_all_union_functions()
    }

    /// `emitGenerators()`: the converters (or, with `--just-types`, the
    /// top-level aliases).
    fn emit_generators(&mut self) -> Result<()> {
        if self.options.just_types {
            let mut did_emit = false;
            let gathered = self.gather_source(|r| {
                r.emit_our_namespaces(|r| {
                    did_emit = r.for_each_top_level_where(
                        BlankLinePosition::None,
                        |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
                        |r, t, name, _| r.emit_top_level_typedef(t, name),
                    )?;
                    Ok(())
                })
            })?;
            if did_emit {
                self.emit_gathered_source(gathered);
                self.ensure_blank_line();
            }
            return Ok(());
        }

        let user_namespace_forward_decls = self.gather_user_namespace_forward_decls()?;
        let nlohmann_namespace_forward_decls = self.gather_nlohmann_namespace_forward_decls()?;

        match (
            user_namespace_forward_decls.is_empty(),
            nlohmann_namespace_forward_decls.is_empty(),
        ) {
            (true, false) => self.emit_nlohmann_namespace(|r| {
                r.emit_gathered_source(nlohmann_namespace_forward_decls);
                r.emit_nlohmann_namespace_impls()
            }),
            (false, true) => self.emit_our_namespaces(|r| {
                r.emit_gathered_source(user_namespace_forward_decls);
                r.emit_user_namespace_impls()
            }),
            (false, false) => {
                self.emit_our_namespaces(|r| {
                    r.emit_gathered_source(user_namespace_forward_decls);
                    Ok(())
                })?;
                self.emit_nlohmann_namespace(|r| {
                    r.emit_gathered_source(nlohmann_namespace_forward_decls);
                    Ok(())
                })?;
                self.emit_our_namespaces(|r| r.emit_user_namespace_impls())?;
                self.emit_nlohmann_namespace(|r| r.emit_nlohmann_namespace_impls())
            }
            (true, true) => Ok(()),
        }
    }

    /// `emitSingleSourceStructure(proposedFilename)`.
    fn emit_single_source_structure(&mut self, proposed_filename: &str) -> Result<()> {
        self.start_file(proposed_filename, true)?;
        self.generated_files.insert(proposed_filename.to_owned());

        self.emit_extra_includes()?;

        if self.options.just_types {
            self.emit_types()?;
        } else {
            if !self.options.just_types
                && self.have_named_types()?
                && (self.have_unions()? || self.have_optional_properties()?)
            {
                self.emit_optional_helpers()?;
                self.ensure_blank_line();
            }

            self.emit_our_namespaces(|r| r.emit_types())?;
        }

        self.ensure_blank_line();

        self.emit_generators()?;

        self.finish_current_file()
    }

    /// `updateIncludes(isClassMember, includes, propertyType, defName)`.
    fn update_includes(
        &self,
        is_class_member: bool,
        includes: &mut IndexMap<String, IncludeRecord>,
        property_type: TypeRef,
    ) -> Result<()> {
        let prop_types = self.generated_types(is_class_member, property_type)?;

        for t in prop_types {
            let type_name = self.sourcelike_to_string(&t.name.into())?;

            let mut prop_record = IncludeRecord {
                kind: None,
                type_kind: None,
            };

            match self.type_graph().kind(t.type_ref)? {
                TypeKind::Class => {
                    // A direct class member (level 0) can not be forward
                    // declared, but one inside a container can.
                    prop_record.type_kind = Some(IncludeTypeKind::Class);
                    prop_record.kind = Some(if t.level == 0 {
                        IncludeKind::Include
                    } else {
                        IncludeKind::ForwardDeclare
                    });
                    if t.force_include {
                        prop_record.kind = Some(IncludeKind::Include);
                    }
                }
                TypeKind::Enum => {
                    prop_record.type_kind = Some(IncludeTypeKind::Enum);
                    prop_record.kind = Some(IncludeKind::ForwardDeclare);
                }
                TypeKind::Union => {
                    prop_record.type_kind = Some(IncludeTypeKind::Union);
                    // TS compares `removeNullFromUnion(...)[0]` (`null` or
                    // a type) with `undefined`, which always holds: a union
                    // is always included.
                    prop_record.kind = Some(IncludeKind::Include);
                }
                _ => {}
            }

            match includes.get(&type_name) {
                // A type already included as a typed include is not
                // overwritten with a forward declaration.
                Some(inc_kind) => {
                    if inc_kind.kind == Some(IncludeKind::ForwardDeclare) {
                        includes.insert(type_name, prop_record);
                    }
                }
                None => {
                    includes.insert(type_name, prop_record);
                }
            }
        }
        Ok(())
    }

    /// `emitIncludes(c, defName)`: the includes and forward declarations
    /// of the types a definition uses.
    fn emit_includes(&mut self, c: TypeRef, def_name: &str) -> Result<()> {
        let mut includes: IndexMap<String, IncludeRecord> = IndexMap::new();

        match self.type_graph().kind(c)? {
            TypeKind::Union => self.update_includes(false, &mut includes, c)?,
            TypeKind::Class => {
                self.for_each_class_property(
                    c,
                    BlankLinePosition::None,
                    |r, _, _, property, _| {
                        r.update_includes(true, &mut includes, property.type_ref)
                    },
                )?;
            }
            _ => {}
        }

        if includes.is_empty() {
            return Ok(());
        }

        let mut num_forwards = 0;
        let mut num_includes = 0;
        for (name, rec) in &includes {
            // Don't bother including the one we are defining
            if name == def_name {
                continue;
            }

            if rec.kind != Some(IncludeKind::ForwardDeclare) {
                self.emit_include(false, sl![name.as_str(), ".hpp"]);
                num_includes += 1;
            } else {
                num_forwards += 1;
            }
        }

        if num_includes > 0 {
            self.ensure_blank_line();
        }

        if num_forwards > 0 {
            self.emit_our_namespaces(|r| {
                for (name, rec) in &includes {
                    if name == def_name || rec.kind != Some(IncludeKind::ForwardDeclare) {
                        continue;
                    }

                    match rec.type_kind {
                        Some(IncludeTypeKind::Class | IncludeTypeKind::Union) => {
                            if r.options.code_format {
                                r.emit_line(sl!["class ", name.as_str(), ";"]);
                            } else {
                                r.emit_line(sl!["struct ", name.as_str(), ";"]);
                            }
                        }
                        Some(IncludeTypeKind::Enum) => {
                            r.emit_line(sl![
                                "enum class ",
                                name.as_str(),
                                " : ",
                                r.enum_type.clone(),
                                ";"
                            ]);
                        }
                        None => {
                            return panic("Invalid type \"undefined\" to forward declare");
                        }
                    }
                }
                Ok(())
            })?;
        }

        self.ensure_blank_line();
        Ok(())
    }

    /// `emitDefinition(d, defName)`: the header of one named type.
    fn emit_definition(&mut self, d: TypeRef, def_name: Name) -> Result<()> {
        let def_name_string = self.sourcelike_to_string(&def_name.into())?;
        let name = format!("{def_name_string}.hpp");
        self.start_file(name.as_str(), true)?;
        self.generated_files.insert(name);

        self.emit_includes(d, &def_name_string)?;

        self.emit_our_namespaces(|r| {
            let description = r.description_for_type(d)?;
            r.emit_description(description)?;
            r.ensure_blank_line();
            r.emit_line("using nlohmann::json;");
            r.ensure_blank_line();
            match r.type_graph().kind(d)? {
                TypeKind::Class => r.emit_class(d, def_name),
                TypeKind::Enum => r.emit_enum(d, def_name),
                TypeKind::Union => r.emit_union_typedefs(d, def_name),
                _ => Ok(()),
            }
        })?;

        self.finish_current_file()
    }

    /// `emitMultiSourceStructure(proposedFilename)`: `helper.hpp`,
    /// `Generators.hpp`, one header per named type and the umbrella
    /// header.
    fn emit_multi_source_structure(&mut self, proposed_filename: &str) -> Result<()> {
        if !self.options.just_types && self.have_named_types()? {
            self.emit_helper()?;

            self.start_file("Generators.hpp", true)?;
            self.generated_files.insert("Generators.hpp".to_owned());

            let all_type_names: Vec<String> = self.all_type_names.iter().cloned().collect();
            for t in all_type_names {
                self.emit_include(false, sl![t, ".hpp"]);
            }

            self.ensure_blank_line();
            self.emit_generators()?;

            self.finish_current_file()?;
        }

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| r.emit_definition(c, n),
            |r, e, n, _| r.emit_definition(e, n),
            |r, u, n, _| r.emit_definition(u, n),
        )?;

        // If nothing has been generated for the proposed file, an unnamed
        // type has been generated - or nothing.
        if !self.generated_files.contains(proposed_filename) {
            if !self.have_named_types()? {
                self.emit_helper()?;
            }

            self.start_file(proposed_filename, true)?;

            let generated_files: Vec<String> = self.generated_files.iter().cloned().collect();
            for f in generated_files {
                self.emit_include(false, f);
            }

            self.emit_our_namespaces(|r| {
                r.for_each_top_level_where(
                    BlankLinePosition::Leading,
                    |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
                    |r, t, name, _| r.emit_top_level_typedef(t, name),
                )?;
                Ok(())
            })?;

            self.finish_current_file()?;
        }
        Ok(())
    }

    /// The name of a type declared by `decl`, for `_allTypeNames`: our
    /// classes, enums and unions directly reachable from it.
    fn defined_type_names(&self, decl: Declaration) -> Result<IndexSet<String>> {
        let graph = self.type_graph();
        directly_reachable_types(graph, decl.type_ref, &mut |t| {
            let ty = graph.type_at(t)?;
            if is_named_type(ty)
                && matches!(
                    ty.kind(),
                    TypeKind::Class | TypeKind::Enum | TypeKind::Union
                )
            {
                let cpp_type = self.cpp_type(t, plain_context(false), true, false, false)?;
                return Ok(Some(
                    [self.sourcelike_to_string(&cpp_type)?]
                        .into_iter()
                        .collect(),
                ));
            }
            Ok(None)
        })
    }
}

impl<'a> ConvenienceRenderer<'a> for CPlusPlusRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        let mut names: Vec<String> = KEYWORDS.iter().map(|&k| k.to_owned()).collect();
        names.extend(self.forbidden_global_names.iter().cloned());
        Ok(names)
    }

    fn forbidden_for_object_properties(
        &mut self,
        _c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn forbidden_for_enum_cases(
        &mut self,
        _e: TypeRef,
        _enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn make_named_type_namer(&mut self) -> Namer {
        let style = self.named_type_name_style.clone();
        fun_prefix_namer("types", move |s| style(s))
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.member_naming_function.clone()))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        None
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(fun_prefix_namer(
            "enumerators",
            make_name_style(self.options.enumerator_naming_style, legalize_name, None),
        ))
    }

    fn make_property_dependency_names(
        &mut self,
        _c: TypeRef,
        _class_name: Name,
        _p: &ClassProperty,
        _json_name: &str,
        name: Name,
    ) -> Result<Vec<Name>> {
        let getter_and_setter_names = self.make_names_for_property_getter_and_setter(name);
        self.getters_and_setters_for_property_name
            .insert(name, getter_and_setter_names);
        let (getter, mutable_getter, setter) = getter_and_setter_names;
        Ok(vec![getter, mutable_getter, setter])
    }

    fn needs_type_declaration_before_use(&self) -> bool {
        true
    }

    fn can_be_forward_declared(&self, t: TypeRef) -> Result<bool> {
        Ok(self.type_graph().kind(t)? == TypeKind::Class)
    }

    fn is_implicit_cycle_breaker(&self, t: TypeRef) -> Result<bool> {
        // Containers break completeness cycles for classes, but not for type
        // aliases: an alias name is not in scope on its own right-hand side.
        let kind = self.type_graph().kind(t)?;
        if kind != TypeKind::Array && kind != TypeKind::Map {
            return Ok(false);
        }

        for child in self.type_graph().children(t)? {
            if self.type_contains_union(child, &mut IndexSet::new())? {
                return Ok(false);
            }
        }
        Ok(true)
    }

    fn can_break_cycles(&self, t: TypeRef) -> Result<bool> {
        let kind = self.type_graph().kind(t)?;
        Ok(kind == TypeKind::Class || kind == TypeKind::Union)
    }

    fn comment_lines_splice_on_backslash(&self) -> bool {
        true
    }

    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        self.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some(" * ".to_owned()),
                before_comment: Some("/**".to_owned()),
                after_comment: Some(" */".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    /// `finishFile()`: TS `CPlusPlusRenderer` overrides `finishFile(filename)`
    /// without the parameter, so the file is always the current one.
    fn finish_file(&mut self, _filename: &str) -> Result<()> {
        self.finish_current_file()
    }

    fn emit_source_structure(&mut self, proposed_filename: &str) -> Result<()> {
        self.generated_files.clear();

        // Gather all the unique/custom types used by the schema
        self.all_type_names.clear();
        self.for_each_declaration(BlankLinePosition::None, |r, decl, _| {
            let defined_types = r.defined_type_names(decl)?;
            // `setUnion(definedTypes, this._allTypeNames)`
            let mut all_type_names = defined_types;
            all_type_names.extend(std::mem::take(&mut r.all_type_names));
            r.all_type_names = all_type_names;
            Ok(())
        })?;

        if self.options.type_source_style {
            self.emit_single_source_structure(proposed_filename)
        } else {
            self.emit_multi_source_structure(proposed_filename)
        }
    }
}
