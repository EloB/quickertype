//! Port of `packages/quicktype-core/src/ConvenienceRenderer.ts`.
//!
//! The base of every quicktype renderer: it names all types, properties,
//! enum cases and union members, orders the declarations, and offers the
//! iteration and comment helpers the languages build on.
//!
//! # How the TypeScript class hierarchy maps to Rust
//!
//! A renderer is a struct that owns a [`ConvenienceRendererCore`] (the
//! fields of TS `Renderer` and `ConvenienceRenderer`) plus its own state and
//! options, and implements two traits:
//!
//! - [`ConvenienceRenderer`]: the *hooks*, i.e. every method a TypeScript
//!   subclass may override. The abstract ones (`makeNamedTypeNamer`,
//!   `emitSourceStructure`, ...) are required; the others have default
//!   bodies that call the function of the same name in [`defaults`]. An
//!   override that calls `super.x(...)` in TypeScript calls
//!   `defaults::x(self, ...)` in Rust.
//! - [`ConvenienceRendererExt`]: the machinery (`emitLine`, `indent`,
//!   `forEachObject`, `nameForNamedType`, naming setup, `render`, ...),
//!   implemented once for every renderer. TypeScript never overrides these.
//!
//! Method names are the snake_case of the TypeScript names. Callbacks get
//! the renderer as their first argument (`|r, ...|`) instead of capturing
//! `this`, and return `Result`, because anything that can fail (a missing
//! name, an internal assertion) is an error instead of an exception.
//! `docs/RENDERERS.md` is the porting guide.

use std::cell::OnceCell;
use std::hash::Hash;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};
use quicktype_js_compat::{whitespace, wordwrap::WordWrap};

use crate::annotation::AnnotationData;
use crate::attributes::accessor_names::{
    enum_case_names, get_accessor_name, object_property_names, union_member_name,
};
use crate::attributes::description::{
    DescriptionTypeAttributeKind, PropertyDescriptionsTypeAttributeKind,
};
use crate::attributes::type_attributes::{
    AttributeKind, TransformationAttribute, follow_target_type, transformation_for_type,
};
use crate::declaration_ir::{
    Declaration, DeclarationIR, cycle_breaker_types_for_graph, declarations_for_graph,
};
use crate::messages::Result;
use crate::naming::{Name, Namer, Names, NamespaceId, Naming, Proposer, assign_names};
use crate::renderer::{
    BlankLineConfig, ForEachPosition, RenderContext, RenderResult, RendererCore,
};
use crate::source::{Source, serialize_render_result};
use crate::support::collection_utils::{
    SameValueZeroKey, first_by_same_value_zero, sort_by_cached_string_key,
};
use crate::support::comments::{Comment, CommentOptions};
use crate::support::fast_hash::HashMap;
use crate::support::strings::trim_end;
use crate::support::support::{assert, defined, non_null, panic};
use crate::target_language::TargetLanguage;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::ClassProperty;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{is_named_type, nullable_from_union, separate_named_types};

/// `topLevelNameOrder`.
pub const TOP_LEVEL_NAME_ORDER: u32 = 1;
const GIVEN_NAME_ORDER: u32 = 10;
/// `inferredNameOrder`.
pub const INFERRED_NAME_ORDER: u32 = 30;
const CLASS_PROPERTY_NAME_ORDER: u32 = 20;
const ASSIGNED_CLASS_PROPERTY_NAME_ORDER: u32 = 10;
const ENUM_CASE_NAME_ORDER: u32 = 20;
const ASSIGNED_ENUM_CASE_NAME_ORDER: u32 = 10;
const UNION_MEMBER_NAME_ORDER: u32 = 40;

/// `splitDescription(descriptions)`: the descriptions joined by blank lines,
/// with every line terminator turned into `"\n"`, trimmed, word-wrapped at
/// 90 columns, split into trimmed lines. `None` if there is no text.
pub fn split_description<'d>(
    descriptions: Option<impl IntoIterator<Item = &'d String>>,
) -> Option<Vec<String>> {
    let descriptions = descriptions?;
    let joined = descriptions
        .into_iter()
        .map(String::as_str)
        .collect::<Vec<_>>()
        .join("\n\n");
    // `.replace(/\r\n?|[\u0085  ]/g, "\n")`
    let mut normalized = String::with_capacity(joined.len());
    let mut chars = joined.chars().peekable();
    while let Some(c) = chars.next() {
        match c {
            '\r' => {
                if chars.peek() == Some(&'\n') {
                    chars.next();
                }
                normalized.push('\n');
            }
            '\u{85}' | '\u{2028}' | '\u{2029}' => normalized.push('\n'),
            c => normalized.push(c),
        }
    }
    let description = whitespace::trim(&normalized);
    if description.is_empty() {
        return None;
    }
    Some(
        WordWrap::new(90)
            .wrap(description)
            .split('\n')
            .map(|l| whitespace::trim(l).to_owned())
            .collect(),
    )
}

/// One entry of [`ForbiddenWordsInfo::names`]: a name whose assigned string
/// is forbidden, or a literal string.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum ForbiddenWord {
    /// A [`Name`]; its assigned string is forbidden.
    Name(Name),
    /// A literal string.
    String(String),
}

impl From<Name> for ForbiddenWord {
    fn from(n: Name) -> Self {
        ForbiddenWord::Name(n)
    }
}

impl From<&str> for ForbiddenWord {
    fn from(s: &str) -> Self {
        ForbiddenWord::String(s.to_owned())
    }
}

impl From<String> for ForbiddenWord {
    fn from(s: String) -> Self {
        ForbiddenWord::String(s)
    }
}

/// `ForbiddenWordsInfo`: names forbidden in a namespace of properties, enum
/// cases or union members.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct ForbiddenWordsInfo {
    /// Whether the names forbidden in the global namespace are forbidden,
    /// too.
    pub include_global_forbidden: bool,
    /// The forbidden names.
    pub names: Vec<ForbiddenWord>,
}

/// The sort key of
/// [`for_each_union_member`](ConvenienceRendererExt::for_each_union_member):
/// `sort_order(renderer, name, member)`.
pub type UnionMemberSortOrder<'f, R> = &'f dyn Fn(&R, Name, TypeRef) -> Result<String>;

/// A [`Proposer`] that proposes `name`.
pub fn constant_proposer(name: impl Into<String>) -> Proposer {
    let name = name.into();
    Rc::new(move |_| name.clone())
}

/// The state of a convenience renderer: the fields of TS `Renderer` and
/// `ConvenienceRenderer`.
pub struct ConvenienceRendererCore<'a> {
    /// The `Renderer` part: emit contexts, files, names.
    pub base: RendererCore<'a>,
    /// The names and namespaces of this render.
    pub naming: Naming,
    global_forbidden_namespace: Option<NamespaceId>,
    other_forbidden_namespaces: IndexMap<String, NamespaceId>,
    global_namespace: Option<NamespaceId>,
    name_store: HashMap<TypeRef, Name>,
    top_level_names: IndexMap<String, Name>,
    property_names: HashMap<TypeRef, IndexMap<String, Name>>,
    member_names: HashMap<TypeRef, IndexMap<TypeRef, Name>>,
    case_names: HashMap<TypeRef, IndexMap<String, Name>>,
    names_for_transformations: IndexMap<TypeRef, Name>,
    named_type_namer: Option<Namer>,
    union_member_namer: Option<Namer>,
    enum_case_namer: Option<Namer>,
    declaration_ir: Option<DeclarationIR>,
    named_types: Option<Vec<TypeRef>>,
    named_objects: Option<IndexSet<TypeRef>>,
    named_enums: Option<IndexSet<TypeRef>>,
    named_unions: Option<IndexSet<TypeRef>>,
    have_unions: Option<bool>,
    have_maps: Option<bool>,
    have_optional_properties: Option<bool>,
    cycle_breaker_types: OnceCell<IndexSet<TypeRef>>,
    alphabetize_properties: bool,
}

impl std::fmt::Debug for ConvenienceRendererCore<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("ConvenienceRendererCore")
            .field("base", &self.base)
            .field("naming", &self.naming)
            .finish_non_exhaustive()
    }
}

impl<'a> ConvenienceRendererCore<'a> {
    /// `new ConvenienceRenderer(targetLanguage, renderContext)`.
    pub fn new(target_language: &'a dyn TargetLanguage, render_context: RenderContext<'a>) -> Self {
        ConvenienceRendererCore {
            base: RendererCore::new(target_language, render_context),
            naming: Naming::new(),
            global_forbidden_namespace: None,
            other_forbidden_namespaces: IndexMap::new(),
            global_namespace: None,
            name_store: HashMap::default(),
            top_level_names: IndexMap::new(),
            property_names: HashMap::default(),
            member_names: HashMap::default(),
            case_names: HashMap::default(),
            names_for_transformations: IndexMap::new(),
            named_type_namer: None,
            union_member_namer: None,
            enum_case_namer: None,
            declaration_ir: None,
            named_types: None,
            named_objects: None,
            named_enums: None,
            named_unions: None,
            have_unions: None,
            have_maps: None,
            have_optional_properties: None,
            cycle_breaker_types: OnceCell::new(),
            alphabetize_properties: false,
        }
    }

    /// The namer for named types (`_namedTypeNamer`), once naming has
    /// started.
    pub fn named_type_namer(&self) -> Result<&Namer> {
        defined(self.named_type_namer.as_ref())
    }

    /// The namer for union members (`_unionMemberNamer`); `None` if the
    /// language doesn't name them.
    pub fn union_member_namer(&self) -> Option<&Namer> {
        self.union_member_namer.as_ref()
    }

    /// The namer for enum cases (`_enumCaseNamer`); `None` if the language
    /// doesn't name them.
    pub fn enum_case_namer(&self) -> Option<&Namer> {
        self.enum_case_namer.as_ref()
    }

    /// The global namespace, once naming has started.
    pub fn global_namespace(&self) -> Result<NamespaceId> {
        defined(self.global_namespace)
    }

    /// The namespace of the names forbidden in the global namespace, once
    /// naming has started.
    pub fn global_forbidden_namespace(&self) -> Result<NamespaceId> {
        defined(self.global_forbidden_namespace)
    }

    /// The name stored for a named type, if any (`nameStoreView.tryGet`).
    pub fn try_name_for_named_type(&self, t: TypeRef) -> Option<Name> {
        self.name_store.get(&t).copied()
    }

    /// The name of the top-level `name` (`nameStoreView.getForTopLevel`).
    pub fn top_level_name(&self, name: &str) -> Result<Name> {
        defined(self.top_level_names.get(name).copied())
    }

    /// The property names of a class, by JSON name, in sorted JSON name
    /// order (`_propertyNamesStoreView.get(o)`).
    pub fn property_names(&self, o: TypeRef) -> Result<&IndexMap<String, Name>> {
        defined(self.property_names.get(&o))
    }

    /// The names of a union's members, in member order
    /// (`_memberNamesStoreView.get(u)`).
    pub fn member_names(&self, u: TypeRef) -> Result<&IndexMap<TypeRef, Name>> {
        defined(self.member_names.get(&u))
    }

    /// The names of an enum's cases, in case order
    /// (`_caseNamesStoreView.get(e)`).
    pub fn case_names(&self, e: TypeRef) -> Result<&IndexMap<String, Name>> {
        defined(self.case_names.get(&e))
    }

    /// The declarations (`_declarationIR`), after `processGraph`.
    pub fn declaration_ir(&self) -> Result<&DeclarationIR> {
        defined(self.declaration_ir.as_ref())
    }
}

/// The list of [`ConvenienceRenderer`] hooks, the single source of truth
/// for the trait (`[declare]`) and for
/// [`forward_convenience_renderer_hooks!`](crate::forward_convenience_renderer_hooks) (`[forward module]`).
///
/// Each entry is `[required mut|ref]` (abstract in TypeScript) or
/// `[mut|ref]` (with a default in [`defaults`]), the hook's name, its
/// parameters after `self` and its return type.
#[doc(hidden)]
#[macro_export]
macro_rules! __convenience_renderer_hooks {
    ($mode:tt) => {
        $crate::__convenience_renderer_hook_items! {
            $mode

            // ---- Abstract ----------------------------------------------------

            /// `makeNamedTypeNamer()`: the namer for classes, enums and
            /// unions.
            [required mut] make_named_type_namer() -> $crate::naming::Namer;

            /// `namerForObjectProperty(o, p)`: the namer for a property, or
            /// `None` if the property gets no name. A namer created anew for
            /// each call is a separate naming group (see
            /// [`Namer`](crate::naming::Namer)).
            [required mut] namer_for_object_property(
                o: $crate::ty::type_ref::TypeRef,
                p: &$crate::ty::ty::ClassProperty
            ) -> $crate::messages::Result<Option<$crate::naming::Namer>>;

            /// `makeUnionMemberNamer()`: the namer for union members, or
            /// `None` if they get no names.
            [required mut] make_union_member_namer() -> Option<$crate::naming::Namer>;

            /// `makeEnumCaseNamer()`: the namer for enum cases, or `None` if
            /// they get no names.
            [required mut] make_enum_case_namer() -> Option<$crate::naming::Namer>;

            /// `emitSourceStructure(givenOutputFilename)`: emits the whole
            /// output.
            [required mut] emit_source_structure(
                given_output_filename: &str
            ) -> $crate::messages::Result<()>;

            // ---- Naming ------------------------------------------------------

            /// `forbiddenNamesForGlobalNamespace()`: names no type may have
            /// (and, via `include_global_forbidden`, no property, case or
            /// member).
            [mut] forbidden_names_for_global_namespace()
                -> $crate::messages::Result<Vec<String>>;

            /// `forbiddenForObjectProperties(o, className)`.
            [mut] forbidden_for_object_properties(
                o: $crate::ty::type_ref::TypeRef,
                class_name: $crate::naming::Name
            ) -> $crate::messages::Result<$crate::convenience_renderer::ForbiddenWordsInfo>;

            /// `forbiddenForUnionMembers(u, unionName)`.
            [mut] forbidden_for_union_members(
                u: $crate::ty::type_ref::TypeRef,
                union_name: $crate::naming::Name
            ) -> $crate::messages::Result<$crate::convenience_renderer::ForbiddenWordsInfo>;

            /// `forbiddenForEnumCases(e, enumName)`.
            [mut] forbidden_for_enum_cases(
                e: $crate::ty::type_ref::TypeRef,
                enum_name: $crate::naming::Name
            ) -> $crate::messages::Result<$crate::convenience_renderer::ForbiddenWordsInfo>;

            /// `makeTopLevelDependencyNames(t, topLevelName)`: extra global
            /// names derived from a top-level's name.
            [mut] make_top_level_dependency_names(
                t: $crate::ty::type_ref::TypeRef,
                top_level_name: $crate::naming::Name
            ) -> $crate::messages::Result<Vec<$crate::naming::Name>>;

            /// `makeNamedTypeDependencyNames(t, name)`: extra global names
            /// derived from a named type's name.
            [mut] make_named_type_dependency_names(
                t: $crate::ty::type_ref::TypeRef,
                name: $crate::naming::Name
            ) -> $crate::messages::Result<Vec<$crate::naming::Name>>;

            /// `makeNameForTransformation(xf, typeName)`.
            [mut] make_name_for_transformation(
                xf: &::std::rc::Rc<dyn $crate::attributes::type_attributes::TransformationAttribute>,
                type_name: Option<$crate::naming::Name>
            ) -> $crate::messages::Result<Option<$crate::naming::Name>>;

            /// `namedTypeToNameForTopLevel(type)`: the named type that takes
            /// a top-level's name, if any.
            [ref] named_type_to_name_for_top_level(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<Option<$crate::ty::type_ref::TypeRef>>;

            /// `unionMembersInGlobalNamespace`.
            [ref] union_members_in_global_namespace() -> bool;

            /// `enumCasesInGlobalNamespace`.
            [ref] enum_cases_in_global_namespace() -> bool;

            /// `makeNameForTopLevel(t, givenName, maybeNamedType)`.
            [mut] make_name_for_top_level(
                t: $crate::ty::type_ref::TypeRef,
                given_name: &str,
                maybe_named_type: Option<$crate::ty::type_ref::TypeRef>
            ) -> $crate::messages::Result<$crate::naming::Name>;

            /// `makeNameForNamedType(t)`.
            [mut] make_name_for_named_type(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<$crate::naming::Name>;

            /// `makeNameForProperty(o, className, p, jsonName,
            /// assignedName)`: `None` if the property gets no name.
            [mut] make_name_for_property(
                o: $crate::ty::type_ref::TypeRef,
                class_name: $crate::naming::Name,
                p: &$crate::ty::ty::ClassProperty,
                json_name: &str,
                assigned_name: Option<&str>
            ) -> $crate::messages::Result<Option<$crate::naming::Name>>;

            /// `makePropertyDependencyNames(o, className, p, jsonName,
            /// name)`.
            [mut] make_property_dependency_names(
                o: $crate::ty::type_ref::TypeRef,
                class_name: $crate::naming::Name,
                p: &$crate::ty::ty::ClassProperty,
                json_name: &str,
                name: $crate::naming::Name
            ) -> $crate::messages::Result<Vec<$crate::naming::Name>>;

            /// `makeNameForUnionMember(u, unionName, t)`.
            [mut] make_name_for_union_member(
                u: $crate::ty::type_ref::TypeRef,
                union_name: $crate::naming::Name,
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<$crate::naming::Name>;

            /// `makeNameForEnumCase(e, enumName, caseName, assignedName)`.
            [mut] make_name_for_enum_case(
                e: $crate::ty::type_ref::TypeRef,
                enum_name: $crate::naming::Name,
                case_name: &str,
                assigned_name: Option<&str>
            ) -> $crate::messages::Result<$crate::naming::Name>;

            /// `proposedUnionMemberNameForTypeKind(kind)`.
            [ref] proposed_union_member_name_for_type_kind(
                kind: $crate::ty::transformed_string_type::TypeKind
            ) -> Option<String>;

            /// `proposeUnionMemberName(u, unionName, fieldType, lookup)`.
            ///
            /// Returns the proposal function instead of calling it: the
            /// TypeScript closure reads renderer state, which the
            /// [`Proposer`](crate::naming::Proposer) captures when it is
            /// built.
            [mut] propose_union_member_name(
                u: $crate::ty::type_ref::TypeRef,
                union_name: $crate::naming::Name,
                field_type: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<$crate::naming::Proposer>;

            // ---- Graph -------------------------------------------------------

            /// `unionNeedsName(u)`: by default, every union except
            /// `T | null`.
            [ref] union_needs_name(
                u: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<bool>;

            /// `needsTypeDeclarationBeforeUse`: whether to compute forward
            /// declarations.
            [ref] needs_type_declaration_before_use() -> bool;

            /// `canBeForwardDeclared(t)`: must be implemented if
            /// `needs_type_declaration_before_use`.
            [ref] can_be_forward_declared(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<bool>;

            /// `isImplicitCycleBreaker(t)`: must be implemented by renderers
            /// that call `is_cycle_breaker_type`.
            [ref] is_implicit_cycle_breaker(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<bool>;

            /// `canBreakCycles(t)`.
            [ref] can_break_cycles(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<bool>;

            // ---- Output ------------------------------------------------------

            /// `descriptionForType(t)`.
            [ref] description_for_type(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<Option<Vec<String>>>;

            /// `descriptionForClassProperty(o, name)`.
            [ref] description_for_class_property(
                o: $crate::ty::type_ref::TypeRef,
                name: &str
            ) -> $crate::messages::Result<Option<Vec<String>>>;

            /// `sortClassProperties(properties, propertyNames)`: the order of
            /// `for_each_class_property`.
            [ref] sort_class_properties(
                properties: &::indexmap::IndexMap<String, $crate::ty::ty::ClassProperty>,
                property_names: &::indexmap::IndexMap<String, $crate::naming::Name>
            ) -> $crate::messages::Result<Vec<(String, $crate::ty::ty::ClassProperty)>>;

            /// `commentLineStart`.
            [ref] comment_line_start() -> &'static str;

            /// `commentLinesSpliceOnBackslash`: whether a comment line ending
            /// in a backslash gets a `.` appended (C-family lexers splice
            /// such lines).
            [ref] comment_lines_splice_on_backslash() -> bool;

            /// `emitDescriptionBlock(lines)`.
            [mut] emit_description_block(
                lines: &[$crate::source::Source]
            ) -> $crate::messages::Result<()>;

            /// `finishFile(filename)`: TypeScript renderers that write
            /// several files override it.
            [mut] finish_file(filename: &str) -> $crate::messages::Result<()>;
        }
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __convenience_renderer_hook_items {
    (
        $mode:tt
        $(
            $(#[$doc:meta])*
            [$($kind:ident)+] $name:ident ($($arg:ident : $ty:ty),* $(,)?) -> $ret:ty;
        )*
    ) => {
        $(
            $crate::__convenience_renderer_hook_fn! {
                $mode [$($kind)+] $(#[$doc])* $name ($($arg: $ty),*) -> $ret
            }
        )*
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __convenience_renderer_hook_fn {
    ([declare] [required mut] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        fn $name(&mut self $(, $arg: $ty)*) -> $ret;
    };
    ([declare] [required ref] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        fn $name(&self $(, $arg: $ty)*) -> $ret;
    };
    ([declare] [mut] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        ///
        /// Default: [`defaults`](crate::convenience_renderer::defaults) function of
        /// the same name.
        fn $name(&mut self $(, $arg: $ty)*) -> $ret {
            $crate::convenience_renderer::defaults::$name(self $(, $arg)*)
        }
    };
    ([declare] [ref] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        ///
        /// Default: [`defaults`](crate::convenience_renderer::defaults) function of
        /// the same name.
        fn $name(&self $(, $arg: $ty)*) -> $ret {
            $crate::convenience_renderer::defaults::$name(self $(, $arg)*)
        }
    };
    ([declare $defaults:ident] [required mut] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        fn $name(&mut self $(, $arg: $ty)*) -> $ret;
    };
    ([declare $defaults:ident] [required ref] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        fn $name(&self $(, $arg: $ty)*) -> $ret;
    };
    ([declare $defaults:ident] [mut] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        ///
        /// Default: the function of the same name in the family's methods
        /// module.
        fn $name(&mut self $(, $arg: $ty)*) -> $ret {
            $defaults::$name(self $(, $arg)*)
        }
    };
    ([declare $defaults:ident] [ref] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        $(#[$doc])*
        ///
        /// Default: the function of the same name in the family's methods
        /// module.
        fn $name(&self $(, $arg: $ty)*) -> $ret {
            $defaults::$name(self $(, $arg)*)
        }
    };
    ([forward $module:ident] [$(required)? mut] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        fn $name(&mut self $(, $arg: $ty)*) -> $ret {
            $module::$name(self $(, $arg)*)
        }
    };
    ([forward $module:ident] [$(required)? ref] $(#[$doc:meta])* $name:ident ($($arg:ident : $ty:ty),*) -> $ret:ty) => {
        fn $name(&self $(, $arg: $ty)*) -> $ret {
            $module::$name(self $(, $arg)*)
        }
    };
}

/// Implements **every** [`ConvenienceRenderer`] hook by calling the function
/// of the same name in `module`, for renderers that belong to a family of
/// TypeScript subclasses (see `docs/RENDERERS.md`).
///
/// `module` (a single identifier in scope: `use ... as hooks;`) holds one
/// function per hook: it glob-imports the hooks of the level above
/// (`pub use crate::convenience_renderer::defaults::*;` for a family,
/// the family's hooks module for a leaf) and defines the hooks this level
/// overrides, which shadow the glob. So a family cannot forget to forward a
/// hook, and a leaf overrides any hook by defining it. Required hooks must
/// be defined somewhere in the chain or the impl doesn't compile.
///
/// ```ignore
/// impl<'a> ConvenienceRenderer<'a> for TypeScriptRenderer<'a> {
///     fn core(&self) -> &ConvenienceRendererCore<'a> { &self.core }
///     fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> { &mut self.core }
///     forward_convenience_renderer_hooks!(typescript_hooks);
/// }
/// ```
#[macro_export]
macro_rules! forward_convenience_renderer_hooks {
    ($module:ident) => {
        $crate::__convenience_renderer_hooks!([forward $module]);
    };
}

/// Declares or forwards the methods of a renderer **family** (a TypeScript
/// mid-level base class such as `JavaScriptRenderer`) from one list, the
/// way [`forward_convenience_renderer_hooks!`](crate::forward_convenience_renderer_hooks)
/// does for the hooks (see `docs/RENDERERS.md`).
///
/// The entries use the syntax of the hook list: `[ref]`/`[mut]` (with a
/// default) or `[required ref]`/`[required mut]`, the method's name, its
/// parameters after `self` and its return type. A family keeps its list in
/// one macro of its own, which passes the mode through:
///
/// - `family_methods!([declare module] ...)` inside the family trait
///   declares every method; a default calls `module::<method>(self, ...)`,
///   the function with the base class's body.
/// - `family_methods!([forward module] ...)` inside a leaf's impl of the
///   family trait implements every method as `module::<method>(self, ...)`.
///   `module` glob-imports the methods module of the level above and
///   defines the methods its level overrides, so no level can forget to
///   forward one.
///
/// ```ignore
/// macro_rules! javascript_renderer_methods {
///     ($mode:tt) => {
///         $crate::family_methods! { $mode
///             /// `emitTypes()`.
///             [mut] emit_types() -> $crate::messages::Result<()>;
///         }
///     };
/// }
/// pub trait JavaScriptRenderer<'a>: ConvenienceRenderer<'a> {
///     javascript_renderer_methods!([declare javascript_methods]);
/// }
/// impl<'a> JavaScriptRenderer<'a> for TypeScriptRenderer<'a> {
///     javascript_renderer_methods!([forward typescript_methods]);
/// }
/// ```
#[macro_export]
macro_rules! family_methods {
    ($mode:tt $($entries:tt)*) => {
        $crate::__convenience_renderer_hook_items! { $mode $($entries)* }
    };
}

/// The hooks of a renderer: every method a TypeScript `ConvenienceRenderer`
/// subclass may override.
///
/// Required methods are TypeScript's abstract methods. Every other method
/// has the TypeScript default, implemented in the [`defaults`] function of
/// the same name, so an override can call the default where TypeScript
/// calls `super`. The hooks are generated from one list, which
/// [`forward_convenience_renderer_hooks!`](crate::forward_convenience_renderer_hooks) also uses.
pub trait ConvenienceRenderer<'a>: Sized {
    /// The renderer's [`ConvenienceRendererCore`].
    fn core(&self) -> &ConvenienceRendererCore<'a>;

    /// The renderer's [`ConvenienceRendererCore`], mutably.
    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a>;

    crate::__convenience_renderer_hooks!([declare]);
}

/// The default implementations of the [`ConvenienceRenderer`] hooks, one
/// function per non-abstract hook: what `super.x(...)` calls in
/// TypeScript.
pub mod defaults {
    use super::*;

    /// Default `forbiddenNamesForGlobalNamespace`: none.
    pub fn forbidden_names_for_global_namespace<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
    ) -> Result<Vec<String>> {
        let _ = r;
        Ok(Vec::new())
    }

    /// Default `forbiddenForObjectProperties`: nothing forbidden.
    pub fn forbidden_for_object_properties<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        o: TypeRef,
        class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let _ = (r, o, class_name);
        Ok(ForbiddenWordsInfo::default())
    }

    /// Default `forbiddenForUnionMembers`: nothing forbidden.
    pub fn forbidden_for_union_members<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        u: TypeRef,
        union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let _ = (r, u, union_name);
        Ok(ForbiddenWordsInfo::default())
    }

    /// Default `forbiddenForEnumCases`: nothing forbidden.
    pub fn forbidden_for_enum_cases<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        e: TypeRef,
        enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let _ = (r, e, enum_name);
        Ok(ForbiddenWordsInfo::default())
    }

    /// Default `makeTopLevelDependencyNames`: none.
    pub fn make_top_level_dependency_names<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        top_level_name: Name,
    ) -> Result<Vec<Name>> {
        let _ = (r, t, top_level_name);
        Ok(Vec::new())
    }

    /// Default `makeNamedTypeDependencyNames`: none.
    pub fn make_named_type_dependency_names<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        name: Name,
    ) -> Result<Vec<Name>> {
        let _ = (r, t, name);
        Ok(Vec::new())
    }

    /// Default `makeNameForTransformation`: no name.
    pub fn make_name_for_transformation<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        xf: &Rc<dyn TransformationAttribute>,
        type_name: Option<Name>,
    ) -> Result<Option<Name>> {
        let _ = (r, xf, type_name);
        Ok(None)
    }

    /// Default `unionMembersInGlobalNamespace`: `false`.
    pub fn union_members_in_global_namespace<'a, R: ConvenienceRenderer<'a>>(r: &R) -> bool {
        let _ = r;
        false
    }

    /// Default `enumCasesInGlobalNamespace`: `false`.
    pub fn enum_cases_in_global_namespace<'a, R: ConvenienceRenderer<'a>>(r: &R) -> bool {
        let _ = r;
        false
    }

    /// Default `makePropertyDependencyNames`: none.
    pub fn make_property_dependency_names<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        o: TypeRef,
        class_name: Name,
        p: &ClassProperty,
        json_name: &str,
        name: Name,
    ) -> Result<Vec<Name>> {
        let _ = (r, o, class_name, p, json_name, name);
        Ok(Vec::new())
    }

    /// Default `proposedUnionMemberNameForTypeKind`: none.
    pub fn proposed_union_member_name_for_type_kind<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        kind: TypeKind,
    ) -> Option<String> {
        let _ = (r, kind);
        None
    }

    /// Default `unionNeedsName`: every union except `T | null`.
    pub fn union_needs_name<'a, R: ConvenienceRenderer<'a>>(r: &R, u: TypeRef) -> Result<bool> {
        Ok(nullable_from_union(r.core().base.type_graph(), u)?.is_none())
    }

    /// Default `needsTypeDeclarationBeforeUse`: `false`.
    pub fn needs_type_declaration_before_use<'a, R: ConvenienceRenderer<'a>>(r: &R) -> bool {
        let _ = r;
        false
    }

    /// Default `canBeForwardDeclared`: an error, as in TypeScript.
    pub fn can_be_forward_declared<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<bool> {
        let _ = (r, t);
        panic(
            "If needsTypeDeclarationBeforeUse returns true, canBeForwardDeclared must be implemented",
        )
    }

    /// Default `isImplicitCycleBreaker`: an error, as in TypeScript.
    pub fn is_implicit_cycle_breaker<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<bool> {
        let _ = (r, t);
        panic("A renderer that invokes isCycleBreakerType must implement isImplicitCycleBreaker")
    }

    /// Default `canBreakCycles`: `true`.
    pub fn can_break_cycles<'a, R: ConvenienceRenderer<'a>>(r: &R, t: TypeRef) -> Result<bool> {
        let _ = (r, t);
        Ok(true)
    }

    /// Default `commentLineStart`: `"// "`.
    pub fn comment_line_start<'a, R: ConvenienceRenderer<'a>>(r: &R) -> &'static str {
        let _ = r;
        "// "
    }

    /// Default `commentLinesSpliceOnBackslash`: `false`.
    pub fn comment_lines_splice_on_backslash<'a, R: ConvenienceRenderer<'a>>(r: &R) -> bool {
        let _ = r;
        false
    }

    /// Default `namedTypeToNameForTopLevel`: the type itself if it is named.
    pub fn named_type_to_name_for_top_level<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Option<TypeRef>> {
        let graph = r.core().base.type_graph();
        Ok(is_named_type(graph.type_at(t)?).then_some(t))
    }

    /// Default `makeNameForTopLevel`: the given name, at top-level order.
    pub fn make_name_for_top_level<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        given_name: &str,
        maybe_named_type: Option<TypeRef>,
    ) -> Result<Name> {
        let _ = (t, maybe_named_type);
        let namer = r.core().named_type_namer()?.clone();
        Ok(r.core_mut()
            .naming
            .simple_name([given_name], &namer, TOP_LEVEL_NAME_ORDER))
    }

    /// `makeNameForType(t, namer, givenOrder, inferredOrder)`.
    pub fn make_name_for_type<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        namer: &Namer,
        given_order: u32,
        inferred_order: u32,
    ) -> Result<Name> {
        let graph = r.core().base.type_graph();
        let names = defined(
            crate::attributes::type_names::NamesTypeAttributeKind
                .try_get_in_attributes(graph.attributes(t)?),
        )?;
        let order = if names.are_inferred() {
            inferred_order
        } else {
            given_order
        };
        let proposed = names.proposed_names()?;
        Ok(r.core_mut().naming.simple_name(proposed, namer, order))
    }

    /// Default `makeNameForNamedType`.
    pub fn make_name_for_named_type<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
    ) -> Result<Name> {
        let namer = r.core().named_type_namer()?.clone();
        make_name_for_type(r, t, &namer, GIVEN_NAME_ORDER, INFERRED_NAME_ORDER)
    }

    /// Default `makeNameForProperty`: the JSON name, then
    /// `<class>_<json name>` (from the class's combined, unstyled name), or
    /// the assigned name at a higher priority.
    pub fn make_name_for_property<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        o: TypeRef,
        class_name: Name,
        p: &ClassProperty,
        json_name: &str,
        assigned_name: Option<&str>,
    ) -> Result<Option<Name>> {
        let _ = class_name;
        let Some(namer) = r.namer_for_object_property(o, p)? else {
            return Ok(None);
        };
        let alternative = format!(
            "{}_{json_name}",
            r.core().base.type_graph().combined_name(o)?
        );
        let name = match assigned_name {
            None => r.core_mut().naming.simple_name(
                [json_name.to_owned(), alternative],
                &namer,
                CLASS_PROPERTY_NAME_ORDER,
            ),
            Some(assigned) => r.core_mut().naming.simple_name(
                [assigned],
                &namer,
                ASSIGNED_CLASS_PROPERTY_NAME_ORDER,
            ),
        };
        Ok(Some(name))
    }

    /// Default `makeNameForUnionMember`: the accessor name if fixed,
    /// otherwise a dependency name proposing the assigned name or
    /// [`propose_union_member_name`](ConvenienceRenderer::propose_union_member_name).
    pub fn make_name_for_union_member<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        u: TypeRef,
        union_name: Name,
        t: TypeRef,
    ) -> Result<Name> {
        let graph = r.core().base.type_graph();
        let language = r.core().base.target_language().name();
        let (assigned_name, is_fixed) = union_member_name(graph, u, t, language)?;
        if is_fixed {
            let fixed = defined(assigned_name)?;
            return Ok(r.core_mut().naming.fixed_name(fixed));
        }
        let namer = non_null(r.core().union_member_namer.clone())?;
        let proposer = match assigned_name {
            Some(assigned) => constant_proposer(assigned),
            None => r.propose_union_member_name(u, union_name, t)?,
        };
        Ok(r.core_mut().naming.dependency_name_with_proposer(
            Some(&namer),
            UNION_MEMBER_NAME_ORDER,
            proposer,
        ))
    }

    /// Default `makeNameForEnumCase`: the case, then `<enum>_<case>`, or
    /// the assigned name at a higher priority.
    pub fn make_name_for_enum_case<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        e: TypeRef,
        enum_name: Name,
        case_name: &str,
        assigned_name: Option<&str>,
    ) -> Result<Name> {
        let _ = enum_name;
        let alternative = format!(
            "{}_{case_name}",
            r.core().base.type_graph().combined_name(e)?
        );
        let namer = non_null(r.core().enum_case_namer.clone())?;
        Ok(match assigned_name {
            None => r.core_mut().naming.simple_name(
                [case_name.to_owned(), alternative],
                &namer,
                ENUM_CASE_NAME_ORDER,
            ),
            Some(assigned) => {
                r.core_mut()
                    .naming
                    .simple_name([assigned], &namer, ASSIGNED_ENUM_CASE_NAME_ORDER)
            }
        })
    }

    enum Piece {
        Text(String),
        Lookup(Name),
    }

    fn type_name_for_union_member<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        t: TypeRef,
        pieces: &mut Vec<Piece>,
    ) -> Result<()> {
        let graph = r.core().base.type_graph();
        let ty = graph.type_at(t)?;
        let text = |s: &str| Piece::Text(s.to_owned());
        match ty.kind() {
            TypeKind::None => return panic("none type should have been replaced"),
            TypeKind::Any => pieces.push(text("anything")),
            TypeKind::Null => pieces.push(text("null")),
            TypeKind::Bool => pieces.push(text("bool")),
            TypeKind::Integer => pieces.push(text("integer")),
            TypeKind::Double => pieces.push(text("double")),
            TypeKind::String => pieces.push(text("string")),
            TypeKind::Array => {
                type_name_for_union_member(r, ty.items()?, pieces)?;
                pieces.push(text("_array"));
            }
            TypeKind::Class => pieces.push(Piece::Lookup(r.name_for_named_type(t)?)),
            TypeKind::Map => {
                type_name_for_union_member(r, ty.map_values()?, pieces)?;
                pieces.push(text("_map"));
            }
            TypeKind::Object => {
                assert(
                    r.core().base.target_language().supports_full_object_type(),
                    "Object type should have been replaced in `replaceObjectType`",
                )?;
                pieces.push(Piece::Lookup(r.name_for_named_type(t)?));
            }
            TypeKind::Enum => pieces.push(text("enum")),
            TypeKind::Union => pieces.push(text("union")),
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => pieces.push(Piece::Text(kind.as_str().replacen('-', "_", 1))),
        }
        Ok(())
    }

    /// Default `proposeUnionMemberName`: the kind's simple name if
    /// [`proposed_union_member_name_for_type_kind`](ConvenienceRenderer::proposed_union_member_name_for_type_kind)
    /// gives one, else a name built from the member's type: `anything`,
    /// `null`, `bool`, `integer`, `double`, `string`, `<items>_array`, the
    /// class's name, `<values>_map`, `enum`, `union`, or the transformed
    /// string kind with its first `-` replaced by `_`.
    pub fn propose_union_member_name<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        u: TypeRef,
        union_name: Name,
        field_type: TypeRef,
    ) -> Result<Proposer> {
        let _ = (u, union_name);
        let kind = r.core().base.type_graph().kind(field_type)?;
        if let Some(simple_name) = r.proposed_union_member_name_for_type_kind(kind) {
            return Ok(constant_proposer(simple_name));
        }
        let mut pieces = Vec::new();
        type_name_for_union_member(r, field_type, &mut pieces)?;
        Ok(Rc::new(move |lookup| {
            let mut result = String::new();
            for piece in &pieces {
                match piece {
                    Piece::Text(s) => result.push_str(s),
                    Piece::Lookup(n) => result.push_str(&lookup(*n)),
                }
            }
            result
        }))
    }

    /// Default `descriptionForType`.
    pub fn description_for_type<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        t: TypeRef,
    ) -> Result<Option<Vec<String>>> {
        let graph = r.core().base.type_graph();
        let description = DescriptionTypeAttributeKind.try_get_in_attributes(graph.attributes(t)?);
        Ok(split_description(description.map(|d| d.iter())))
    }

    /// Default `descriptionForClassProperty`.
    pub fn description_for_class_property<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        o: TypeRef,
        name: &str,
    ) -> Result<Option<Vec<String>>> {
        let graph = r.core().base.type_graph();
        let Some(descriptions) =
            PropertyDescriptionsTypeAttributeKind.try_get_in_attributes(graph.attributes(o)?)
        else {
            return Ok(None);
        };
        Ok(split_description(descriptions.get(name).map(|d| d.iter())))
    }

    /// Default `sortClassProperties`: alphabetical by assigned name with
    /// `alphabetizeProperties`, else in property order.
    pub fn sort_class_properties<'a, R: ConvenienceRenderer<'a>>(
        r: &R,
        properties: &IndexMap<String, ClassProperty>,
        property_names: &IndexMap<String, Name>,
    ) -> Result<Vec<(String, ClassProperty)>> {
        let entries: Vec<(String, ClassProperty)> =
            properties.iter().map(|(k, v)| (k.clone(), *v)).collect();
        if !r.core().alphabetize_properties {
            return Ok(entries);
        }
        let names = r.core().base.names()?;
        sort_by_cached_string_key(entries, |(json_name, _)| -> Result<String> {
            let name = defined(property_names.get(json_name))?;
            Ok(defined(names.get(*name))?.to_owned())
        })
    }

    /// Default `emitDescriptionBlock`: comment lines.
    pub fn emit_description_block<'a, R: ConvenienceRenderer<'a>>(
        r: &mut R,
        lines: &[Source],
    ) -> Result<()> {
        r.emit_comment_lines(lines, &CommentOptions::default())
    }

    /// `Renderer.finishFile(filename)`.
    pub fn finish_file<'a, R: ConvenienceRenderer<'a>>(r: &mut R, filename: &str) -> Result<()> {
        r.core_mut().base.finish_file(filename);
        Ok(())
    }
}

/// Renders with `renderer` (TS `setAlphabetizeProperties` followed by
/// `render`). Used by [`TargetLanguage::render`] implementations.
pub fn render_with<'a, R: ConvenienceRenderer<'a>>(
    mut renderer: R,
    given_output_filename: &str,
    alphabetize_properties: bool,
) -> Result<RenderResult> {
    renderer.set_alphabetize_properties(alphabetize_properties);
    renderer.render(given_output_filename)
}

/// The machinery of [`ConvenienceRenderer`] (and TS `Renderer`), shared by
/// all renderers.
pub trait ConvenienceRendererExt<'a>: ConvenienceRenderer<'a> {
    // ---- Accessors ------------------------------------------------------

    /// `typeGraph`.
    fn type_graph(&self) -> &'a TypeGraph {
        self.core().base.type_graph()
    }

    /// `targetLanguage`.
    fn target_language(&self) -> &'a dyn TargetLanguage {
        self.core().base.target_language()
    }

    /// `leadingComments`.
    fn leading_comments(&self) -> Option<&'a [Comment]> {
        self.core().base.leading_comments()
    }

    /// `topLevels`: the top-level types by name.
    fn top_levels(&self) -> &'a IndexMap<String, TypeRef> {
        self.core().base.type_graph().top_levels()
    }

    /// `names`: the assigned names (after naming).
    fn names<'s>(&'s self) -> Result<&'s Names>
    where
        'a: 's,
    {
        self.core().base.names()
    }

    /// The name arena, for creating names in hooks (`new SimpleName(...)`
    /// is `self.naming_mut().simple_name(...)`).
    fn naming<'s>(&'s self) -> &'s Naming
    where
        'a: 's,
    {
        &self.core().naming
    }

    /// The name arena, mutably.
    fn naming_mut<'s>(&'s mut self) -> &'s mut Naming
    where
        'a: 's,
    {
        &mut self.core_mut().naming
    }

    // ---- Emitting (TS Renderer) -----------------------------------------

    /// `ensureBlankLine()`.
    fn ensure_blank_line(&mut self) {
        self.core_mut().base.ensure_blank_line(1);
    }

    /// `ensureBlankLine(numBlankLines)`.
    fn ensure_blank_lines(&mut self, num_blank_lines: usize) {
        self.core_mut().base.ensure_blank_line(num_blank_lines);
    }

    /// `preventBlankLine()`.
    fn prevent_blank_line(&mut self) {
        self.core_mut().base.prevent_blank_line();
    }

    /// `emitItem(item)`.
    fn emit_item(&mut self, item: impl Into<Source>) {
        self.core_mut().base.emit_item(item);
    }

    /// `emitItemOnce(item)`.
    fn emit_item_once(&mut self, item: impl Into<Source>) -> bool {
        self.core_mut().base.emit_item_once(item)
    }

    /// `emitLineOnce(...lineParts)`.
    fn emit_line_once(&mut self, line_parts: Vec<Source>) {
        self.core_mut().base.emit_line_once(line_parts);
    }

    /// `emitLine(line)`: one sourcelike (use [`sl!`](crate::sl) for
    /// several parts), then a newline.
    fn emit_line(&mut self, line: impl Into<Source>) {
        self.core_mut().base.emit_line(line);
    }

    /// `emitLine(...lineParts)` with a list of parts (none: just a
    /// newline).
    fn emit_line_parts(&mut self, line_parts: Vec<Source>) {
        self.core_mut().base.emit_line_parts(line_parts);
    }

    /// `emitMultiline(linesString)`.
    fn emit_multiline(&mut self, lines_string: &str) -> Result<()> {
        self.core_mut().base.emit_multiline(lines_string)
    }

    /// `gatherSource(emitter)`: the items `emitter` emits, without emitting
    /// them.
    fn gather_source(
        &mut self,
        emitter: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<Vec<Source>> {
        let saved = self.core_mut().base.begin_gather();
        let result = emitter(self);
        let items = self.core_mut().base.end_gather(saved);
        result?;
        Ok(items)
    }

    /// `emitGatheredSource(items)`.
    fn emit_gathered_source(&mut self, items: Vec<Source>) {
        self.core_mut().base.emit_gathered_source(items);
    }

    /// `emitAnnotated(annotation, emitter)`.
    fn emit_annotated(
        &mut self,
        annotation: AnnotationData,
        emitter: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        let items = self.gather_source(emitter)?;
        self.core_mut().base.emit_annotated_items(annotation, items);
        Ok(())
    }

    /// `emitIssue(message, emitter)`.
    fn emit_issue(
        &mut self,
        message: &str,
        emitter: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_annotated(AnnotationData::issue(message), emitter)
    }

    /// `emitTable(tableArray)`.
    fn emit_table(&mut self, table_array: Vec<Vec<Source>>) {
        self.core_mut().base.emit_table(table_array);
    }

    /// `changeIndent(offset)`.
    fn change_indent(&mut self, offset: i32) -> Result<()> {
        self.core_mut().base.change_indent(offset)
    }

    /// `indent(fn)`: runs `f` one indentation level deeper.
    fn indent(&mut self, f: impl FnOnce(&mut Self) -> Result<()>) -> Result<()> {
        self.change_indent(1)?;
        f(self)?;
        self.change_indent(-1)
    }

    /// `initializeEmitContextForFilename(filename)`.
    fn initialize_emit_context_for_filename(&mut self, filename: &str) {
        self.core_mut()
            .base
            .initialize_emit_context_for_filename(filename);
    }

    /// `iterableForEach(iterable, emitter)`.
    fn iterable_for_each<T>(
        &mut self,
        items: impl IntoIterator<Item = T>,
        mut emitter: impl FnMut(&mut Self, T, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let items: Vec<T> = items.into_iter().collect();
        let len = items.len();
        for (i, v) in items.into_iter().enumerate() {
            emitter(self, v, ForEachPosition::of(i, len))?;
        }
        Ok(())
    }

    /// `forEach(iterable, interposedBlankLines, leadingBlankLines,
    /// emitter)`: calls `emitter(value, key, position)` for each entry,
    /// requesting blank lines before it. Returns whether there were any.
    fn for_each<K, V>(
        &mut self,
        items: impl IntoIterator<Item = (K, V)>,
        interposed_blank_lines: usize,
        leading_blank_lines: usize,
        mut emitter: impl FnMut(&mut Self, V, K, ForEachPosition) -> Result<()>,
    ) -> Result<bool> {
        let mut did_emit = false;
        self.iterable_for_each(items, |r, (k, v), position| {
            if matches!(position, ForEachPosition::Only | ForEachPosition::First) {
                r.ensure_blank_lines(leading_blank_lines);
            } else {
                r.ensure_blank_lines(interposed_blank_lines);
            }
            emitter(r, v, k, position)?;
            did_emit = true;
            Ok(())
        })?;
        Ok(did_emit)
    }

    /// `forEachWithBlankLines(iterable, blankLineConfig, emitter)`.
    fn for_each_with_blank_lines<K, V>(
        &mut self,
        items: impl IntoIterator<Item = (K, V)>,
        blank_line_config: impl Into<BlankLineConfig>,
        emitter: impl FnMut(&mut Self, V, K, ForEachPosition) -> Result<()>,
    ) -> Result<bool> {
        let (interposing, leading) = blank_line_config.into().counts();
        self.for_each(items, interposing, leading, emitter)
    }

    // ---- Naming setup ---------------------------------------------------

    /// `setUpNaming()`: creates every name and namespace; returns the root
    /// namespaces for [`assign_names`].
    fn set_up_naming(&mut self) -> Result<Vec<NamespaceId>> {
        let named_type_namer = self.make_named_type_namer();
        let union_member_namer = self.make_union_member_namer();
        let enum_case_namer = self.make_enum_case_namer();
        {
            let core = self.core_mut();
            core.named_type_namer = Some(named_type_namer);
            core.union_member_namer = union_member_namer;
            core.enum_case_namer = enum_case_namer;
        }

        let keywords = self.forbidden_names_for_global_namespace()?;
        let global_forbidden = self.naming_mut().keyword_namespace("forbidden", keywords);
        let global = self
            .naming_mut()
            .namespace("global", None, [global_forbidden], []);
        {
            let core = self.core_mut();
            core.global_forbidden_namespace = Some(global_forbidden);
            core.global_namespace = Some(global);
            core.other_forbidden_namespaces = IndexMap::new();
        }

        let graph = self.type_graph();
        let separated = graph.all_named_types_separated()?;
        let mut named_unions = Vec::new();
        for &u in &separated.unions {
            if self.union_needs_name(u)? {
                named_unions.push(u);
            }
        }
        for (name, &t) in graph.top_levels() {
            let n = self.add_name_for_top_level(t, name)?;
            self.core_mut().top_level_names.insert(name.clone(), n);
        }

        for &o in &separated.objects {
            let name = self.add_name_for_named_type(o)?;
            self.add_property_names(o, name)?;
        }

        for &e in &separated.enums {
            let name = self.add_name_for_named_type(e)?;
            self.add_enum_case_names(e, name)?;
        }

        for u in named_unions {
            let name = self.add_name_for_named_type(u)?;
            self.add_union_member_names(u, name)?;
        }

        for t in graph.all_types_unordered() {
            self.add_name_for_transformation(t)?;
        }

        let mut roots: IndexSet<NamespaceId> = [global_forbidden, global].into_iter().collect();
        roots.extend(self.core().other_forbidden_namespaces.values().copied());
        Ok(roots.into_iter().collect())
    }

    /// `addDependenciesForNamedType(type, named)`.
    fn add_dependencies_for_named_type(&mut self, t: TypeRef, named: Name) -> Result<()> {
        let dependency_names = self.make_named_type_dependency_names(t, named)?;
        let global = self.core().global_namespace()?;
        for dn in dependency_names {
            self.naming_mut().add(global, dn);
        }
        Ok(())
    }

    /// `addNameForTopLevel(type, givenName)`.
    fn add_name_for_top_level(&mut self, t: TypeRef, given_name: &str) -> Result<Name> {
        let maybe_named_type = self.named_type_to_name_for_top_level(t)?;
        let name = self.make_name_for_top_level(t, given_name, maybe_named_type)?;
        let global = self.core().global_namespace()?;
        self.naming_mut().add(global, name);
        let dependency_names = self.make_top_level_dependency_names(t, name)?;
        for dn in dependency_names {
            self.naming_mut().add(global, dn);
        }

        if let Some(named_type) = maybe_named_type {
            self.add_dependencies_for_named_type(named_type, name)?;
            self.core_mut().name_store.insert(named_type, name);
        }

        Ok(name)
    }

    /// `addNameForNamedType(type)`: reuses a top-level's name.
    fn add_name_for_named_type(&mut self, t: TypeRef) -> Result<Name> {
        if let Some(existing) = self.core().try_name_for_named_type(t) {
            return Ok(existing);
        }
        let made = self.make_name_for_named_type(t)?;
        let global = self.core().global_namespace()?;
        let name = self.naming_mut().add(global, made);
        self.add_dependencies_for_named_type(t, name)?;
        self.core_mut().name_store.insert(t, name);
        Ok(name)
    }

    /// `addNameForTransformation(t)`.
    fn add_name_for_transformation(&mut self, t: TypeRef) -> Result<()> {
        let Some(xf) = transformation_for_type(self.type_graph(), t)? else {
            return Ok(());
        };
        assert(
            !self.core().names_for_transformations.contains_key(&t),
            "Tried to give two names to the same transformation",
        )?;
        let target_name = self.core().try_name_for_named_type(xf.target_type());
        let Some(name) = self.make_name_for_transformation(&xf, target_name)? else {
            return Ok(());
        };
        let global = self.core().global_namespace()?;
        self.naming_mut().add(global, name);
        self.core_mut().names_for_transformations.insert(t, name);
        Ok(())
    }

    /// `processForbiddenWordsInfo(info, namespaceName)`: the forbidden
    /// names, and the forbidden namespaces. Literal strings go into one
    /// keyword namespace per `namespace_name`, created the first time a
    /// hook returns strings and reused (with its first strings) ever after.
    #[doc(hidden)]
    fn process_forbidden_words_info(
        &mut self,
        info: ForbiddenWordsInfo,
        namespace_name: &str,
    ) -> Result<(IndexSet<Name>, IndexSet<NamespaceId>)> {
        let mut forbidden_names: Vec<Name> = Vec::new();
        let mut forbidden_strings: Vec<String> = Vec::new();
        for name_or_string in info.names {
            match name_or_string {
                ForbiddenWord::String(s) => forbidden_strings.push(s),
                ForbiddenWord::Name(n) => forbidden_names.push(n),
            }
        }

        let mut namespace = self
            .core()
            .other_forbidden_namespaces
            .get(namespace_name)
            .copied();
        if !forbidden_strings.is_empty() && namespace.is_none() {
            let ns = self
                .naming_mut()
                .keyword_namespace(namespace_name, forbidden_strings);
            self.core_mut()
                .other_forbidden_namespaces
                .insert(namespace_name.to_owned(), ns);
            namespace = Some(ns);
        }

        let mut forbidden_namespaces = IndexSet::new();
        if info.include_global_forbidden {
            forbidden_namespaces.insert(self.core().global_forbidden_namespace()?);
        }
        if let Some(ns) = namespace {
            forbidden_namespaces.insert(ns);
        }
        Ok((forbidden_names.into_iter().collect(), forbidden_namespaces))
    }

    /// `addPropertyNames(o, className)`.
    fn add_property_names(&mut self, o: TypeRef, class_name: Name) -> Result<()> {
        let info = self.forbidden_for_object_properties(o, class_name)?;
        let (forbidden_names, forbidden_namespaces) =
            self.process_forbidden_words_info(info, "forbidden-for-properties")?;

        let mut ns: Option<NamespaceId> = None;
        let graph = self.type_graph();
        let accessor_names = object_property_names(graph, o, self.target_language().name())?;
        let mut names: IndexMap<String, Name> = IndexMap::new();
        for (json_name, p) in graph.type_at(o)?.sorted_property_refs()? {
            let (assigned_name, is_fixed) = get_accessor_name(&accessor_names, json_name);
            let name = if is_fixed {
                let fixed = defined(assigned_name)?;
                Some(self.naming_mut().fixed_name(fixed))
            } else {
                self.make_name_for_property(o, class_name, p, json_name, assigned_name.as_deref())?
            };
            let Some(name) = name else {
                continue;
            };
            let namespace = match ns {
                Some(ns) => ns,
                None => {
                    let combined = graph.combined_name(o)?;
                    let global = self.core().global_namespace()?;
                    let created = self.naming_mut().namespace(
                        combined,
                        Some(global),
                        forbidden_namespaces.iter().copied(),
                        forbidden_names.iter().copied(),
                    );
                    ns = Some(created);
                    created
                }
            };
            self.naming_mut().add(namespace, name);
            for dep_name in
                self.make_property_dependency_names(o, class_name, p, json_name, name)?
            {
                self.naming_mut().add(namespace, dep_name);
            }
            names.insert(json_name.clone(), name);
        }
        self.core_mut().property_names.insert(o, names);
        Ok(())
    }

    /// `addUnionMemberNames(u, unionName)`.
    fn add_union_member_names(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        if self.core().union_member_namer.is_none() {
            return Ok(());
        }
        let info = self.forbidden_for_union_members(u, union_name)?;
        let (forbidden_names, forbidden_namespaces) =
            self.process_forbidden_words_info(info, "forbidden-for-union-members")?;

        let graph = self.type_graph();
        let global = self.core().global_namespace()?;
        let ns = if self.union_members_in_global_namespace() {
            global
        } else {
            let combined = graph.combined_name(u)?;
            self.naming_mut().namespace(
                combined,
                Some(global),
                forbidden_namespaces,
                forbidden_names,
            )
        };

        let mut names: IndexMap<TypeRef, Name> = IndexMap::new();
        for &t in graph.type_at(u)?.members()? {
            let target = follow_target_type(graph, t)?;
            let name = self.make_name_for_union_member(u, union_name, target)?;
            names.insert(t, self.naming_mut().add(ns, name));
        }
        self.core_mut().member_names.insert(u, names);
        Ok(())
    }

    /// `addEnumCaseNames(e, enumName)`.
    fn add_enum_case_names(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        if self.core().enum_case_namer.is_none() {
            return Ok(());
        }
        let info = self.forbidden_for_enum_cases(e, enum_name)?;
        let (forbidden_names, forbidden_namespaces) =
            self.process_forbidden_words_info(info, "forbidden-for-enum-cases")?;

        let graph = self.type_graph();
        let global = self.core().global_namespace()?;
        let ns = if self.enum_cases_in_global_namespace() {
            global
        } else {
            let combined = graph.combined_name(e)?;
            self.naming_mut().namespace(
                combined,
                Some(global),
                forbidden_namespaces,
                forbidden_names,
            )
        };

        let mut names: IndexMap<String, Name> = IndexMap::new();
        let accessor_names = enum_case_names(graph, e, self.target_language().name())?;
        for case_name in graph.type_at(e)?.cases()? {
            let (assigned_name, is_fixed) = get_accessor_name(&accessor_names, case_name);
            let name = if is_fixed {
                let fixed = defined(assigned_name)?;
                self.naming_mut().fixed_name(fixed)
            } else {
                self.make_name_for_enum_case(e, enum_name, case_name, assigned_name.as_deref())?
            };
            names.insert(case_name.clone(), self.naming_mut().add(ns, name));
        }
        self.core_mut().case_names.insert(e, names);
        Ok(())
    }

    /// `assignNames()`: sets up naming and assigns all names.
    fn assign_names(&mut self) -> Result<Names> {
        let roots = self.set_up_naming()?;
        assign_names(&self.core().naming, &roots)
    }

    // ---- Graph processing -----------------------------------------------

    /// `childrenOfType(t)`: for classes, the types of the named properties
    /// sorted by assigned name; otherwise `getChildren()`.
    fn children_of_type(&self, t: TypeRef) -> Result<IndexSet<TypeRef>> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        if ty.kind() != TypeKind::Class {
            return graph.children(t);
        }
        let names = self.names()?;
        let property_nameds = self.core().property_names(t)?;
        let filtered: Vec<(Name, TypeRef)> = ty
            .properties()?
            .iter()
            .filter_map(|(n, p)| property_nameds.get(n).map(|&name| (name, p.type_ref)))
            .collect();
        let sorted = sort_by_cached_string_key(filtered, |&(name, _)| -> Result<String> {
            Ok(defined(names.get(name))?.to_owned())
        })?;
        Ok(sorted.into_iter().map(|(_, t)| t).collect())
    }

    /// `processGraph()`: computes the declarations and the named types.
    fn process_graph(&mut self) -> Result<()> {
        let graph = self.type_graph();
        let can_be_forward_declared = |t: TypeRef| self.can_be_forward_declared(t);
        let children_of_type = |t: TypeRef| self.children_of_type(t);
        let needs_declaration = |t: TypeRef| -> Result<bool> {
            let ty = graph.type_at(t)?;
            if ty.is_union() {
                return self.union_needs_name(t);
            }
            Ok(is_named_type(ty))
        };
        let declaration_ir = declarations_for_graph(
            graph,
            if self.needs_type_declaration_before_use() {
                Some(&can_be_forward_declared)
            } else {
                None
            },
            &children_of_type,
            &needs_declaration,
        )?;

        let types = graph.types();
        let have_unions = types.iter().any(|t| t.is_union());
        let have_maps = types.iter().any(|t| t.is_map());
        let mut have_optional_properties = false;
        for t in types.iter().filter(|t| t.is_class()) {
            if t.properties()?.values().any(|p| p.is_optional) {
                have_optional_properties = true;
                break;
            }
        }
        let named_types: Vec<TypeRef> = declaration_ir
            .declarations
            .iter()
            .filter(|d| d.kind == crate::declaration_ir::DeclarationKind::Define)
            .map(|d| d.type_ref)
            .collect();
        let named_set: IndexSet<TypeRef> = named_types.iter().copied().collect();
        let separated = separate_named_types(graph, &named_set)?;

        let core = self.core_mut();
        core.declaration_ir = Some(declaration_ir);
        core.have_unions = Some(have_unions);
        core.have_maps = Some(have_maps);
        core.have_optional_properties = Some(have_optional_properties);
        core.named_types = Some(named_types);
        core.named_objects = Some(separated.objects);
        core.named_enums = Some(separated.enums);
        core.named_unions = Some(separated.unions);
        Ok(())
    }

    /// `emitSource(givenOutputFilename)`.
    fn emit_source(&mut self, given_output_filename: &str) -> Result<()> {
        self.process_graph()?;
        self.emit_source_structure(given_output_filename)
    }

    /// `render(givenOutputFilename)`: names, emits, and returns the files.
    fn render(&mut self, given_output_filename: &str) -> Result<RenderResult> {
        let names = self.assign_names()?;
        self.core_mut().base.set_names(names);
        self.emit_source(given_output_filename)?;
        if !self.core().base.emit_context().is_empty() {
            self.finish_file(given_output_filename)?;
        }
        self.core_mut().base.take_render_result()
    }

    /// `setAlphabetizeProperties(value)`.
    fn set_alphabetize_properties(&mut self, value: bool) {
        self.core_mut().alphabetize_properties = value;
    }

    /// `getAlphabetizeProperties()`.
    fn get_alphabetize_properties(&self) -> bool {
        self.core().alphabetize_properties
    }

    // ---- Queries ----------------------------------------------------------

    /// `nameForNamedType(t)`.
    fn name_for_named_type(&self, t: TypeRef) -> Result<Name> {
        defined(self.core().try_name_for_named_type(t))
    }

    /// `nameForUnionMember(u, t)`.
    fn name_for_union_member(&self, u: TypeRef, t: TypeRef) -> Result<Name> {
        defined(self.core().member_names(u)?.get(&t).copied())
    }

    /// `nameForEnumCase(e, caseName)`.
    fn name_for_enum_case(&self, e: TypeRef, case_name: &str) -> Result<Name> {
        defined(self.core().case_names(e)?.get(case_name).copied())
    }

    /// `nameForTransformation(t)`: `None` if `t` has no transformation;
    /// errors if it has one without a name.
    fn name_for_transformation(&self, t: TypeRef) -> Result<Option<Name>> {
        if transformation_for_type(self.type_graph(), t)?.is_none() {
            return Ok(None);
        }
        match self.core().names_for_transformations.get(&t) {
            Some(&name) => Ok(Some(name)),
            None => panic("No name for transformation"),
        }
    }

    /// `typesWithNamedTransformations`.
    fn types_with_named_transformations<'s>(&'s self) -> &'s IndexMap<TypeRef, Name>
    where
        'a: 's,
    {
        &self.core().names_for_transformations
    }

    /// `namedUnions`.
    fn named_unions<'s>(&'s self) -> Result<&'s IndexSet<TypeRef>>
    where
        'a: 's,
    {
        defined(self.core().named_unions.as_ref())
    }

    /// `haveNamedUnions`.
    fn have_named_unions(&self) -> Result<bool> {
        Ok(!self.named_unions()?.is_empty())
    }

    /// `haveNamedTypes`.
    fn have_named_types(&self) -> Result<bool> {
        Ok(!defined(self.core().named_types.as_ref())?.is_empty())
    }

    /// `haveUnions`.
    fn have_unions(&self) -> Result<bool> {
        defined(self.core().have_unions)
    }

    /// `haveMaps`.
    fn have_maps(&self) -> Result<bool> {
        defined(self.core().have_maps)
    }

    /// `haveOptionalProperties`.
    fn have_optional_properties(&self) -> Result<bool> {
        defined(self.core().have_optional_properties)
    }

    /// `enums`: the named enums, in declaration order.
    fn enums<'s>(&'s self) -> Result<&'s IndexSet<TypeRef>>
    where
        'a: 's,
    {
        defined(self.core().named_enums.as_ref())
    }

    /// `haveEnums`.
    fn have_enums(&self) -> Result<bool> {
        Ok(!self.enums()?.is_empty())
    }

    /// `isForwardDeclaredType(t)`.
    fn is_forward_declared_type(&self, t: TypeRef) -> Result<bool> {
        Ok(self.core().declaration_ir()?.forwarded_types.contains(&t))
    }

    /// `isCycleBreakerType(t)`: computes the cycle breakers on first use
    /// with the [`is_implicit_cycle_breaker`](ConvenienceRenderer::is_implicit_cycle_breaker)
    /// and [`can_break_cycles`](ConvenienceRenderer::can_break_cycles)
    /// hooks.
    fn is_cycle_breaker_type(&self, t: TypeRef) -> Result<bool> {
        if self.core().cycle_breaker_types.get().is_none() {
            let types = cycle_breaker_types_for_graph(
                self.type_graph(),
                &|s| self.is_implicit_cycle_breaker(s),
                &|s| self.can_break_cycles(s),
            )?;
            let _ = self.core().cycle_breaker_types.set(types);
        }
        Ok(defined(self.core().cycle_breaker_types.get())?.contains(&t))
    }

    /// `propertyCount(o)`: the number of named properties.
    fn property_count(&self, o: TypeRef) -> Result<usize> {
        Ok(self.core().property_names(o)?.len())
    }

    /// `sourcelikeToString(src)`: the source serialized without
    /// indentation, lines joined by `"\n"`. Names must be assigned.
    fn sourcelike_to_string(&self, src: &Source) -> Result<String> {
        Ok(serialize_render_result(src, self.names()?, "")?
            .lines
            .join("\n"))
    }

    // ---- Iteration --------------------------------------------------------

    /// `forEachTopLevel(blankLocations, f)`: `f(t, name, position)` for
    /// every top-level.
    fn for_each_top_level(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        f: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<bool> {
        self.for_each_top_level_where(blank_locations, |_, _| Ok(true), f)
    }

    /// `forEachTopLevel(blankLocations, f, predicate)`: only the top-levels
    /// whose type satisfies `predicate`.
    fn for_each_top_level_where(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        mut predicate: impl FnMut(&Self, TypeRef) -> Result<bool>,
        mut f: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<bool> {
        let mut top_levels: Vec<(String, TypeRef)> = Vec::new();
        for (name, &t) in self.top_levels() {
            if predicate(self, t)? {
                top_levels.push((name.clone(), t));
            }
        }
        self.for_each_with_blank_lines(top_levels, blank_locations, |r, t, name, position| {
            let n = defined(r.core().top_level_names.get(&name).copied())?;
            f(r, t, n, position)
        })
    }

    /// `forEachDeclaration(blankLocations, f)`.
    fn for_each_declaration(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        mut f: impl FnMut(&mut Self, Declaration, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let declarations: Vec<(usize, Declaration)> = self
            .core()
            .declaration_ir()?
            .declarations
            .iter()
            .copied()
            .enumerate()
            .collect();
        self.for_each_with_blank_lines(declarations, blank_locations, |r, decl, _, position| {
            f(r, decl, position)
        })?;
        Ok(())
    }

    /// `forEachClassProperty(o, blankLocations, f)`: `f(name, jsonName, p,
    /// position)` in property order, or alphabetical by assigned name with
    /// `alphabetizeProperties` (see
    /// [`sort_class_properties`](ConvenienceRenderer::sort_class_properties)).
    fn for_each_class_property(
        &mut self,
        o: TypeRef,
        blank_locations: impl Into<BlankLineConfig>,
        mut f: impl FnMut(&mut Self, Name, &str, ClassProperty, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let properties = self.type_graph().type_at(o)?.properties()?;
        let property_names = self.core().property_names(o)?;
        let items: Vec<(String, (ClassProperty, Option<Name>))> = self
            .sort_class_properties(properties, property_names)?
            .into_iter()
            .map(|(json_name, p)| {
                let name = property_names.get(&json_name).copied();
                (json_name, (p, name))
            })
            .collect();
        self.for_each_with_blank_lines(
            items,
            blank_locations,
            |r, (p, name), json_name, position| f(r, defined(name)?, &json_name, p, position),
        )?;
        Ok(())
    }

    /// `forEachUnionMember(u, members, blankLocations, sortOrder, f)`:
    /// `f(name, t, position)` for the members in `members` (all if
    /// `None`), sorted by `sort_order(name, t)` (default: the assigned
    /// name).
    fn for_each_union_member(
        &mut self,
        u: TypeRef,
        members: Option<&IndexSet<TypeRef>>,
        blank_locations: impl Into<BlankLineConfig>,
        sort_order: Option<UnionMemberSortOrder<'_, Self>>,
        mut f: impl FnMut(&mut Self, Name, TypeRef, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let all_members;
        let iterate_members = match members {
            Some(m) => m,
            None => {
                all_members = self.type_graph().type_at(u)?.members()?;
                all_members
            }
        };
        let member_names: Vec<(TypeRef, Name)> = self
            .core()
            .member_names(u)?
            .iter()
            .filter(|(t, _)| iterate_members.contains(*t))
            .map(|(&t, &n)| (t, n))
            .collect();
        let sorted = sort_by_cached_string_key(member_names, |&(t, n)| match sort_order {
            Some(order) => order(self, n, t),
            None => Ok(defined(self.names()?.get(n))?.to_owned()),
        })?;
        self.for_each_with_blank_lines(sorted, blank_locations, |r, name, t, position| {
            f(r, name, t, position)
        })?;
        Ok(())
    }

    /// `forEachEnumCase(e, blankLocations, f)`: `f(name, jsonName,
    /// position)` in case order.
    fn for_each_enum_case(
        &mut self,
        e: TypeRef,
        blank_locations: impl Into<BlankLineConfig>,
        mut f: impl FnMut(&mut Self, Name, &str, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let case_names: Vec<(String, Name)> = self
            .core()
            .case_names(e)?
            .iter()
            .map(|(k, &v)| (k.clone(), v))
            .collect();
        self.for_each_with_blank_lines(
            case_names,
            blank_locations,
            |r, name, json_name, position| f(r, name, &json_name, position),
        )?;
        Ok(())
    }

    /// `forEachTransformation(blankLocations, f)`: `f(name, t, position)`.
    fn for_each_transformation(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        mut f: impl FnMut(&mut Self, Name, TypeRef, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let items: Vec<(TypeRef, Name)> = self
            .core()
            .names_for_transformations
            .iter()
            .map(|(&t, &n)| (t, n))
            .collect();
        self.for_each_with_blank_lines(items, blank_locations, |r, name, t, position| {
            f(r, name, t, position)
        })?;
        Ok(())
    }

    /// `forEachSpecificNamedType(blankLocations, types, f)`.
    fn for_each_specific_named_type(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        types: Vec<TypeRef>,
        mut f: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let items: Vec<(TypeRef, TypeRef)> = types.into_iter().map(|t| (t, t)).collect();
        self.for_each_with_blank_lines(items, blank_locations, |r, t, _, position| {
            let name = r.name_for_named_type(t)?;
            f(r, t, name, position)
        })?;
        Ok(())
    }

    /// `forEachObject(blankLocations, f)`: the named classes and objects in
    /// declaration order.
    fn for_each_object(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        f: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let types = defined(self.core().named_objects.as_ref())?
            .iter()
            .copied()
            .collect();
        self.for_each_specific_named_type(blank_locations, types, f)
    }

    /// `forEachEnum(blankLocations, f)`.
    fn for_each_enum(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        f: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let types = self.enums()?.iter().copied().collect();
        self.for_each_specific_named_type(blank_locations, types, f)
    }

    /// `forEachUnion(blankLocations, f)`.
    fn for_each_union(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        f: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let types = self.named_unions()?.iter().copied().collect();
        self.for_each_specific_named_type(blank_locations, types, f)
    }

    /// `forEachUniqueUnion(blankLocations, uniqueValue, f)`: `f(union,
    /// value, position)` for the first named union with each distinct
    /// `unique_value`. Values are JavaScript `Map` keys: strings, numbers
    /// and booleans are compared by value, a [`Name`] by identity, and a
    /// [`JsObject`](crate::support::collection_utils::JsObject) (a fresh
    /// array or object in TypeScript) equals nothing.
    fn for_each_unique_union<T: SameValueZeroKey>(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        mut unique_value: impl FnMut(&Self, TypeRef) -> Result<T>,
        f: impl FnMut(&mut Self, TypeRef, T, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let unions: Vec<TypeRef> = self.named_unions()?.iter().copied().collect();
        let mut values: Vec<(T, TypeRef)> = Vec::with_capacity(unions.len());
        for u in unions {
            values.push((unique_value(self, u)?, u));
        }
        let first_union_by_value = first_by_same_value_zero(values);
        self.for_each_with_blank_lines(first_union_by_value, blank_locations, f)?;
        Ok(())
    }

    /// `forEachNamedType(blankLocations, objectFunc, enumFunc, unionFunc)`:
    /// every declared type, in declaration order.
    fn for_each_named_type(
        &mut self,
        blank_locations: impl Into<BlankLineConfig>,
        mut object_func: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
        mut enum_func: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
        mut union_func: impl FnMut(&mut Self, TypeRef, Name, ForEachPosition) -> Result<()>,
    ) -> Result<()> {
        let types: Vec<(TypeRef, TypeRef)> = defined(self.core().named_types.as_ref())?
            .iter()
            .map(|&t| (t, t))
            .collect();
        self.for_each_with_blank_lines(types, blank_locations, |r, t, _, position| {
            let name = r.name_for_named_type(t)?;
            let ty = r.type_graph().type_at(t)?;
            if ty.is_object_type() {
                object_func(r, t, name, position)
            } else if ty.is_enum() {
                enum_func(r, t, name, position)
            } else if ty.is_union() {
                union_func(r, t, name, position)
            } else {
                panic("Named type that's neither a class nor union")
            }
        })?;
        Ok(())
    }

    /// `forEachType(process)`: `process` for every type reachable from the
    /// top-levels (depth-first, last child first); the set of results.
    fn for_each_type<T: Eq + Hash>(
        &mut self,
        mut process: impl FnMut(&mut Self, TypeRef) -> Result<T>,
    ) -> Result<IndexSet<T>> {
        let mut visited: crate::support::fast_hash::HashSet<TypeRef> =
            crate::support::fast_hash::HashSet::default();
        let mut processed: IndexSet<T> = IndexSet::new();
        let mut queue: Vec<TypeRef> = self.top_levels().values().copied().collect();
        while let Some(t) = queue.pop() {
            if visited.contains(&t) {
                continue;
            }
            queue.extend(self.type_graph().children(t)?);
            visited.insert(t);
            processed.insert(process(self, t)?);
        }
        Ok(processed)
    }

    // ---- Comments ---------------------------------------------------------

    /// `emitComments(comments)`.
    fn emit_comments(&mut self, comments: &[Comment]) -> Result<()> {
        let default_options = CommentOptions::default();
        for comment in comments {
            match comment {
                Comment::String(s) => {
                    self.emit_comment_lines(&[Source::from(s)], &default_options)?
                }
                Comment::Lines(lines) => self.emit_comment_lines(lines, &default_options)?,
                Comment::DescriptionBlock(lines) => self.emit_description_block(lines)?,
                Comment::Custom {
                    options,
                    custom_lines,
                } => self.emit_comment_lines(custom_lines, options)?,
            }
            self.ensure_blank_line();
        }
        Ok(())
    }

    /// `emitCommentLines(lines, options)`: each line prefixed with the line
    /// start (the renderer's [comment line
    /// start](ConvenienceRenderer::comment_line_start) by default),
    /// escaping anything in the line that would end the comment.
    fn emit_comment_lines(&mut self, lines: &[Source], options: &CommentOptions) -> Result<()> {
        let line_start = options
            .line_start
            .clone()
            .unwrap_or_else(|| self.comment_line_start().to_owned());
        let first_line_start = options
            .first_line_start
            .clone()
            .unwrap_or_else(|| line_start.clone());
        let line_end = options.line_end.as_deref();
        let replacements = comment_line_escapes(&[
            Some(&line_start),
            Some(&first_line_start),
            line_end,
            options.before_comment.as_deref(),
            options.after_comment.as_deref(),
        ]);

        if let Some(before) = &options.before_comment {
            self.emit_line(before.as_str());
        }

        let mut first = true;
        for line in lines {
            let mut start = if first {
                first_line_start.clone()
            } else {
                line_start.clone()
            };
            first = false;
            let escaped_line = self.escape_comment_line(line, &replacements, line_end)?;
            if self.sourcelike_to_string(&escaped_line)?.is_empty() {
                start = trim_end(&start).to_owned();
            }
            match line_end {
                Some(end) if !end.is_empty() => {
                    self.emit_line(crate::sl![start, escaped_line, end]);
                }
                _ => self.emit_line(crate::sl![start, escaped_line]),
            }
        }

        if let Some(after) = &options.after_comment {
            self.emit_line(after.as_str());
        }
        Ok(())
    }

    /// `emitDescription(description)`: the description block, if any.
    fn emit_description<S: Into<Source>>(&mut self, description: Option<Vec<S>>) -> Result<()> {
        let Some(description) = description else {
            return Ok(());
        };
        let lines: Vec<Source> = description.into_iter().map(Into::into).collect();
        self.emit_description_block(&lines)
    }

    /// `escapeCommentLine(line, replacements, lineEnd)`.
    #[doc(hidden)]
    fn escape_comment_line(
        &self,
        line: &Source,
        replacements: &[(&'static str, &'static str)],
        line_end: Option<&str>,
    ) -> Result<Source> {
        let splice = self.comment_lines_splice_on_backslash();
        if replacements.is_empty() && !splice {
            return Ok(line.clone());
        }
        let mut escaped = self.sourcelike_to_string(line)?;
        for (unsafe_text, safe) in replacements {
            escaped = escaped.replace(unsafe_text, safe);
        }
        // A quote at the end of the line would merge with a closing `"""`
        // emitted right after it. The quote needs escaping iff it's
        // preceded by an even number of backslashes.
        if line_end.is_some_and(|e| e.starts_with('"')) {
            if let Some(without_quote) = escaped.strip_suffix('"') {
                let backslashes = without_quote.len() - without_quote.trim_end_matches('\\').len();
                if backslashes % 2 == 0 {
                    escaped = format!("{without_quote}\\\"");
                }
            }
        }
        if splice && escaped.ends_with('\\') {
            escaped.push('.');
        }
        Ok(Source::Text(escaped))
    }

    /// `emitPropertyTable(c, makePropertyRow)`: the class's properties as
    /// table rows; a property with a description ends the current table and
    /// emits its description first.
    fn emit_property_table(
        &mut self,
        c: TypeRef,
        mut make_property_row: impl FnMut(&mut Self, Name, &str, ClassProperty) -> Result<Vec<Source>>,
    ) -> Result<()> {
        let mut table: Vec<Vec<Source>> = Vec::new();
        self.for_each_class_property(
            c,
            crate::renderer::BlankLinePosition::None,
            |r, name, json_name, p, _| {
                let description = r.description_for_class_property(c, json_name)?;
                if description.is_some() {
                    let rows = std::mem::take(&mut table);
                    r.emit_table(rows);
                    r.emit_description(description)?;
                }
                table.push(make_property_row(r, name, json_name, p)?);
                Ok(())
            },
        )?;
        self.emit_table(table);
        Ok(())
    }
}

impl<'a, T: ConvenienceRenderer<'a>> ConvenienceRendererExt<'a> for T {}

/// `commentLineEscapes(options)`: the replacements that keep a comment line
/// from ending the comment its delimiters open.
fn comment_line_escapes(delimiters: &[Option<&str>]) -> Vec<(&'static str, &'static str)> {
    let contains_delimiter = |delimiter: &str| {
        delimiters
            .iter()
            .any(|d| d.is_some_and(|d| d.contains(delimiter)))
    };
    let mut replacements = Vec::new();
    if contains_delimiter("/*") || contains_delimiter("*/") {
        // The opener must be escaped, too: some languages (Kotlin, Scala)
        // nest block comments.
        replacements.push(("/*", "/ *"));
        replacements.push(("*/", "* /"));
    }
    if contains_delimiter("{-") || contains_delimiter("-}") {
        replacements.push(("{-", "{ -"));
        replacements.push(("-}", "- }"));
    }
    if contains_delimiter("\"\"\"") {
        // Triple-quoted comments are string literals, so backslashes are
        // escape characters.
        replacements.push(("\\", "\\\\"));
        replacements.push(("\"\"\"", "\\\"\\\"\\\""));
    }
    replacements
}

/// Everything a renderer module needs: the two renderer traits, the
/// `Source` helpers and the [`sl!`](crate::sl) macro.
pub mod prelude {
    pub use super::{
        ConvenienceRenderer, ConvenienceRendererCore, ConvenienceRendererExt, ForbiddenWord,
        ForbiddenWordsInfo, constant_proposer, defaults, match_type_unsupported, render_with,
        type_not_supported,
    };
    pub use crate::forward_convenience_renderer_hooks;
    pub use crate::messages::Result;
    pub use crate::naming::{Name, Namer, Proposer, fun_prefix_namer};
    pub use crate::renderer::{
        BlankLineConfig, BlankLinePosition, ForEachPosition, RenderContext, RenderResult,
    };
    pub use crate::sl;
    pub use crate::source::{Source, annotated, maybe_annotated, modify_source};
    pub use crate::support::collection_utils::{JsObject, SameValueZeroKey};
    pub use crate::ty::transformed_string_type::TypeKind;
    pub use crate::ty::ty::ClassProperty;
    pub use crate::ty::type_ref::TypeRef;
}

/// `Unsupported type <kind> in non-exhaustive match`: the error of TS
/// `matchType` for a kind it has no case for.
pub fn type_not_supported<T>(kind: TypeKind) -> Result<T> {
    panic(format!("Unsupported type {kind} in non-exhaustive match"))
}

/// The error of TS `matchType` for any kind it has no case for: an
/// intersection reaches `matchTypeExhaustive`'s `Unknown type intersection`,
/// every other kind (`none`, `object`, a transformed string kind without a
/// case) is [`type_not_supported`].
pub fn match_type_unsupported<T>(kind: TypeKind) -> Result<T> {
    if kind == TypeKind::Intersection {
        return panic("Unknown type intersection");
    }
    type_not_supported(kind)
}

/// A two-level family of renderers built with
/// [`forward_convenience_renderer_hooks!`](crate::forward_convenience_renderer_hooks), as `docs/RENDERERS.md`
/// describes it.
#[cfg(test)]
mod family_tests {
    use crate::convenience_renderer::prelude::*;
    use crate::target_language::TargetLanguage;

    /// The family's own methods (a TS mid-level base class), with defaults.
    pub trait FamilyRenderer<'a>: ConvenienceRenderer<'a> {
        fn greeting(&self) -> String {
            "family greeting".to_owned()
        }
    }

    /// The hooks the family overrides; everything else comes from the
    /// framework defaults through the glob.
    pub mod family_hooks {
        pub use crate::convenience_renderer::defaults::*;

        use super::FamilyRenderer;
        use crate::convenience_renderer::prelude::*;

        pub fn make_named_type_namer<'a, R: FamilyRenderer<'a>>(_r: &mut R) -> Namer {
            fun_prefix_namer("types", str::to_owned)
        }

        pub fn namer_for_object_property<'a, R: FamilyRenderer<'a>>(
            _r: &mut R,
            _o: TypeRef,
            _p: &ClassProperty,
        ) -> Result<Option<Namer>> {
            Ok(None)
        }

        pub fn make_union_member_namer<'a, R: FamilyRenderer<'a>>(_r: &mut R) -> Option<Namer> {
            None
        }

        pub fn make_enum_case_namer<'a, R: FamilyRenderer<'a>>(_r: &mut R) -> Option<Namer> {
            None
        }

        pub fn comment_line_start<'a, R: FamilyRenderer<'a>>(_r: &R) -> &'static str {
            "# "
        }

        pub fn forbidden_names_for_global_namespace<'a, R: FamilyRenderer<'a>>(
            _r: &mut R,
        ) -> Result<Vec<String>> {
            Ok(vec!["TopLevel".to_owned()])
        }

        pub fn emit_source_structure<'a, R: FamilyRenderer<'a>>(
            r: &mut R,
            _given_output_filename: &str,
        ) -> Result<()> {
            let greeting = r.greeting();
            r.emit_line(greeting);
            let start = r.comment_line_start();
            r.emit_line(start);
            r.for_each_top_level(BlankLinePosition::None, |r, _, name, _| {
                r.emit_line(name);
                Ok(())
            })?;
            Ok(())
        }
    }

    /// A leaf that overrides one hook (with `super`) and one family method.
    mod leaf_hooks {
        pub use super::family_hooks::*;

        use super::FamilyRenderer;

        pub fn comment_line_start<'a, R: FamilyRenderer<'a>>(r: &R) -> &'static str {
            if super::family_hooks::comment_line_start(r) == "# " {
                "-- "
            } else {
                "?"
            }
        }
    }

    struct Leaf<'a> {
        core: ConvenienceRendererCore<'a>,
        override_greeting: bool,
    }

    impl<'a> ConvenienceRenderer<'a> for Leaf<'a> {
        fn core(&self) -> &ConvenienceRendererCore<'a> {
            &self.core
        }

        fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
            &mut self.core
        }

        forward_convenience_renderer_hooks!(leaf_hooks);
    }

    impl<'a> FamilyRenderer<'a> for Leaf<'a> {
        fn greeting(&self) -> String {
            if self.override_greeting {
                "leaf greeting".to_owned()
            } else {
                "family greeting".to_owned()
            }
        }
    }

    #[test]
    fn hooks_resolve_leaf_then_family_then_framework() {
        let mut builder = crate::ty::type_builder::TypeBuilder::new(
            crate::ty::type_builder_utils::get_no_string_type_mapping(),
            false,
            false,
            false,
            false,
        )
        .unwrap();
        let t = builder
            .get_primitive_type(
                TypeKind::Bool,
                crate::attributes::type_attributes::TypeAttributes::new(),
                None,
            )
            .unwrap();
        builder.add_top_level("TopLevel", t).unwrap();
        let graph = builder.finish().unwrap();
        let language = crate::language::rust::language::RustTargetLanguage;
        let ctx = RenderContext {
            type_graph: &graph,
            leading_comments: None,
        };
        let leaf = Leaf {
            core: ConvenienceRendererCore::new(&language as &dyn TargetLanguage, ctx),
            override_greeting: true,
        };
        // Framework default, reached through both globs.
        assert!(leaf.can_break_cycles(t).unwrap());
        let result = render_with(leaf, "out", false).unwrap();
        let source = &result.sources["out"];
        let lines = crate::source::serialize_render_result(source, &result.names, "  ")
            .unwrap()
            .lines;
        // The leaf's greeting and comment start, the family's forbidden
        // names (so the top-level is renamed).
        assert_eq!(lines, ["leaf greeting", "-- ", "Purple_TopLevel", ""]);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn match_type_errors_like_typescript() {
        let message = |kind| {
            match_type_unsupported::<()>(kind)
                .unwrap_err()
                .user_message()
                .to_owned()
        };
        assert_eq!(
            message(TypeKind::Intersection),
            "Internal error: Unknown type intersection"
        );
        assert_eq!(
            message(TypeKind::Object),
            "Internal error: Unsupported type object in non-exhaustive match"
        );
    }

    #[test]
    fn split_description_like_typescript() {
        let d = |s: &str| -> IndexSet<String> { [s.to_owned()].into_iter().collect() };
        assert_eq!(split_description(Some(&d("  "))), None);
        assert_eq!(split_description(None::<&IndexSet<String>>), None);
        assert_eq!(
            split_description(Some(&d("a\r\nb\u{2028}c\u{85}d"))),
            Some(vec!["a".to_owned(), "b".into(), "c".into(), "d".into()])
        );
        let long = "x".repeat(95);
        assert_eq!(
            split_description(Some(&d(&format!("{long} y")))),
            Some(vec![String::new(), long.clone(), "y".into()])
        );
        let two: IndexSet<String> = ["a".to_owned(), "b".to_owned()].into_iter().collect();
        assert_eq!(
            split_description(Some(&two)),
            Some(vec!["a".to_owned(), String::new(), "b".into()])
        );
    }

    #[test]
    fn comment_escapes_follow_the_delimiters() {
        assert!(comment_line_escapes(&[Some("// ")]).is_empty());
        assert_eq!(comment_line_escapes(&[Some(" * "), Some("/**")]).len(), 2);
        assert_eq!(
            comment_line_escapes(&[None, Some("-- "), Some("{-| ")]).len(),
            2
        );
        assert_eq!(comment_line_escapes(&[Some("\"\"\"")]).len(), 2);
    }
}

/// [`family_methods!`](crate::family_methods): a family trait declared from a
/// method list, and a leaf that forwards every method to a module that
/// overrides some of them.
#[cfg(test)]
mod family_methods_tests {
    macro_rules! shape_methods {
        ($mode:tt) => {
            crate::family_methods! { $mode
                /// `name()`.
                [ref] name() -> String;
                /// `area(scale)`.
                [ref] area(scale: f64) -> f64;
                /// `sides()`: abstract.
                [required ref] sides() -> u32;
                /// `grow(by)`.
                [mut] grow(by: f64) -> f64;
            }
        };
    }

    /// A family trait: state accessors plus the listed methods.
    trait Shape: Sized {
        fn size(&self) -> f64;
        fn set_size(&mut self, size: f64);
        shape_methods!([declare base_methods]);
    }

    /// The base class's bodies.
    mod base_methods {
        use super::Shape;

        pub fn name<S: Shape>(s: &S) -> String {
            format!("shape with {} sides", s.sides())
        }

        pub fn area<S: Shape>(s: &S, scale: f64) -> f64 {
            s.size() * scale
        }

        pub fn grow<S: Shape>(s: &mut S, by: f64) -> f64 {
            let size = s.size() + by;
            s.set_size(size);
            size
        }
    }

    /// A leaf level: overrides `sides` and `area` (calling `super`).
    mod square_methods {
        pub use super::base_methods::*;

        use super::Shape;

        pub fn sides<S: Shape>(_s: &S) -> u32 {
            4
        }

        pub fn area<S: Shape>(s: &S, scale: f64) -> f64 {
            super::base_methods::area(s, scale) * s.size()
        }
    }

    struct Square(f64);

    impl Shape for Square {
        fn size(&self) -> f64 {
            self.0
        }

        fn set_size(&mut self, size: f64) {
            self.0 = size;
        }

        shape_methods!([forward square_methods]);
    }

    /// A leaf that keeps the declared defaults.
    struct Triangle(f64);

    impl Shape for Triangle {
        fn size(&self) -> f64 {
            self.0
        }

        fn set_size(&mut self, size: f64) {
            self.0 = size;
        }

        fn sides(&self) -> u32 {
            3
        }
    }

    #[test]
    fn leaves_forward_or_use_the_declared_defaults() {
        let mut square = Square(2.0);
        assert_eq!(square.name(), "shape with 4 sides");
        assert_eq!(square.area(3.0), 12.0);
        assert_eq!(square.grow(1.0), 3.0);
        assert_eq!(square.size(), 3.0);
        let triangle = Triangle(2.0);
        assert_eq!(triangle.name(), "shape with 3 sides");
        assert_eq!(triangle.area(3.0), 6.0);
    }
}
