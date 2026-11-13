//! Port of `packages/quicktype-core/src/language/Python/PythonRenderer.ts`.
//!
//! Renders Python classes (plain, dataclasses or pydantic models) and
//! enums with type hints for the selected Python version, and is the base
//! of [`JsonPythonRenderer`](super::json_python_renderer::JsonPythonRenderer).
//!
//! The TS class hierarchy `PythonRenderer` → `JSONPythonRenderer` is ported
//! as described in `docs/RENDERERS.md`: the class's fields are
//! [`PythonState`], its own methods the [`PythonRenderer`] family trait
//! (with the default bodies in [`python_methods`], so the subclass can call
//! them as `super`), its hook overrides [`python_hooks`], and
//! [`PythonPlainRenderer`] is the renderer of `--just-types`.
//!
//! Imports are collected as a side effect of rendering type expressions
//! (`withImport`), and forward references are quoted depending on which
//! types are declared at that moment, so the call sequence matters, not
//! just the results.

use indexmap::{IndexMap, IndexSet};

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::renderer_options::RendererOptions;
use crate::support::comments::{Comment, CommentOptions};
use crate::support::recursion::guard;
use crate::support::strings::string_escape;
use crate::support::support::{defined, panic};
use crate::target_language::TargetLanguage;
use crate::transformers::follow_target_type;
use crate::ty::type_utils::{NullRemovalSort, remove_null_from_union};

use super::language::{FEATURES, JUST_TYPES, NICE_PROPERTY_NAMES, PYDANTIC_BASE_MODEL};

/// TS `PythonFeatures`: what the `python-version` option turns on.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct PythonFeatures {
    /// `builtinGenerics`: PEP 585 builtin generics (`list[str]`,
    /// `dict[str, int]`), Python 3.9+.
    pub builtin_generics: bool,
    /// `dataClasses`.
    pub data_classes: bool,
    /// `typeHints`.
    pub type_hints: bool,
    /// `typingType`: `typing.Type`, unavailable in Python 3.6.0.
    pub typing_type: bool,
    /// `unionOperators`: PEP 604 union operators (`str | None`), Python
    /// 3.10+.
    pub union_operators: bool,
}

/// The option values of the Python renderers (TS `OptionValues<typeof
/// pythonOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct PythonOptions {
    /// `features` (the `python-version` option).
    pub features: PythonFeatures,
    /// `justTypes`.
    pub just_types: bool,
    /// `nicePropertyNames`.
    pub nice_property_names: bool,
    /// `pydanticBaseModel`.
    pub pydantic_base_model: bool,
}

impl PythonOptions {
    /// `getOptionValues(pythonOptions, values)`: the options in declaration
    /// order; an unknown `python-version` is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let features = match FEATURES.get_enum_value(values)? {
            "3.5" => PythonFeatures {
                type_hints: false,
                typing_type: false,
                data_classes: false,
                builtin_generics: false,
                union_operators: false,
            },
            "3.6" => PythonFeatures {
                type_hints: true,
                typing_type: false,
                data_classes: false,
                builtin_generics: false,
                union_operators: false,
            },
            "3.7" => PythonFeatures {
                type_hints: true,
                typing_type: true,
                data_classes: true,
                builtin_generics: false,
                union_operators: false,
            },
            "3.9" => PythonFeatures {
                type_hints: true,
                typing_type: true,
                data_classes: true,
                builtin_generics: true,
                union_operators: false,
            },
            "3.10" => PythonFeatures {
                type_hints: true,
                typing_type: true,
                data_classes: true,
                builtin_generics: true,
                union_operators: true,
            },
            other => return panic(format!("Unknown python-version {other}")),
        };
        Ok(PythonOptions {
            features,
            just_types: JUST_TYPES.get_value(values),
            nice_property_names: NICE_PROPERTY_NAMES.get_value(values),
            pydantic_base_model: PYDANTIC_BASE_MODEL.get_value(values),
        })
    }
}

/// The fields of TS `PythonRenderer`.
#[derive(Clone, Debug)]
pub struct PythonState {
    /// `pyOptions`.
    pub options: PythonOptions,
    /// `imports`: `from <module> import <names>`, in discovery order.
    pub imports: IndexMap<String, IndexSet<String>>,
    /// `moduleImports`: `import <module>`, in discovery order.
    pub module_imports: IndexSet<String>,
    /// `declaredTypes`: the types emitted so far.
    pub declared_types: IndexSet<TypeRef>,
}

impl PythonState {
    /// The state `new PythonRenderer(..., pyOptions)` sets up.
    pub fn new(options: PythonOptions) -> Self {
        PythonState {
            options,
            imports: IndexMap::new(),
            module_imports: IndexSet::new(),
            declared_types: IndexSet::new(),
        }
    }
}

/// The list of the methods of TS `PythonRenderer` that are not
/// `ConvenienceRenderer` hooks, for [`family_methods!`](crate::family_methods):
/// `[declare module]` declares them in [`PythonRenderer`], `[forward
/// module]` implements them all in a subclass by calling `module`. (The
/// private methods are functions in [`python_methods`].)
macro_rules! python_renderer_methods {
    ($mode:tt) => {
        $crate::family_methods! { $mode
            /// `emitBlock(line, f)`: `line`, then `f` indented.
            [mut] emit_block(
                line: $crate::source::Source,
                f: impl FnOnce(&mut Self) -> $crate::messages::Result<()>
            ) -> $crate::messages::Result<()>;

            /// `string(s)`: a double-quoted string literal.
            [ref] string(s: &str) -> $crate::source::Source;

            /// `withImport(module, name)`: `name`, recording `from module
            /// import name` (`typing` only with type hints).
            [mut] with_import(module: &str, name: &str) -> $crate::source::Source;

            /// `withModuleImport(module)`: `module`, recording `import module`.
            [mut] with_module_import(module: &str) -> $crate::source::Source;

            /// `withTyping(name)`: `name` from `typing`.
            [mut] with_typing(name: &str) -> $crate::source::Source;

            /// `namedType(t, suppressQuotes)`: the name, quoted if `t` is not
            /// declared yet.
            [ref] named_type(
                t: $crate::ty::type_ref::TypeRef,
                suppress_quotes: bool
            ) -> $crate::messages::Result<$crate::source::Source>;

            /// `pythonType(t, isRootTypeDef, suppressQuotes)`: the type
            /// annotation of `t`.
            [mut] python_type(
                t: $crate::ty::type_ref::TypeRef,
                is_root_type_def: bool,
                suppress_quotes: bool
            ) -> $crate::messages::Result<$crate::source::Source>;

            /// `declarationLine(t)`: the `class` line of a class or enum.
            [mut] declaration_line(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<$crate::source::Source>;

            /// `declareType(t, emitter)`.
            [mut] declare_type(
                t: $crate::ty::type_ref::TypeRef,
                emitter: impl FnOnce(&mut Self) -> $crate::messages::Result<()>
            ) -> $crate::messages::Result<()>;

            /// `emitClassMembers(t)`: the `__init__` of a plain class.
            [mut] emit_class_members(
                t: $crate::ty::type_ref::TypeRef
            ) -> $crate::messages::Result<()>;

            /// `typeHint(...sl)`: `sl` with type hints, nothing without.
            [ref] type_hint(sl: Vec<$crate::source::Source>) -> $crate::source::Source;

            /// `typingDecl(name, type)`: `name: type` with `type` from
            /// `typing`.
            [mut] typing_decl(name: $crate::source::Source, ty: &str) -> $crate::source::Source;

            /// `typingReturn(type)`: ` -> type` with `type` from `typing`.
            [mut] typing_return(ty: &str) -> $crate::source::Source;

            /// `emitClass(t)`.
            [mut] emit_class(t: $crate::ty::type_ref::TypeRef) -> $crate::messages::Result<()>;

            /// `emitEnum(t)`.
            [mut] emit_enum(t: $crate::ty::type_ref::TypeRef) -> $crate::messages::Result<()>;

            /// `emitImports()`.
            [mut] emit_imports() -> $crate::messages::Result<()>;

            /// `emitSupportCode()`: nothing for plain types.
            [mut] emit_support_code() -> $crate::messages::Result<()>;

            /// `emitClosingCode()`: nothing for plain types.
            [mut] emit_closing_code() -> $crate::messages::Result<()>;
        }
    };
}
pub(crate) use python_renderer_methods;

/// The methods of TS `PythonRenderer` that are not `ConvenienceRenderer`
/// hooks; the subclass overrides some of them. Each default is the
/// function of the same name in [`python_methods`]. A subclass implements
/// all of them with `python_renderer_methods!([forward its_methods_module])`.
pub trait PythonRenderer<'a>: ConvenienceRenderer<'a> {
    /// The fields of TS `PythonRenderer`.
    fn py(&self) -> &PythonState;

    /// The fields of TS `PythonRenderer`, mutably.
    fn py_mut(&mut self) -> &mut PythonState;

    /// `pyOptions`.
    fn py_options(&self) -> &PythonOptions {
        &self.py().options
    }

    python_renderer_methods!([declare python_methods]);
}

/// `arrayIntercalate(separator, items)` as a source sequence.
pub(crate) fn intercalate(separator: &str, items: Vec<Source>) -> Source {
    Source::Sequence(crate::support::collection_utils::array_intercalate(
        Source::from(separator),
        items,
    ))
}

/// The bodies of TS `PythonRenderer`'s methods: the defaults of
/// [`PythonRenderer`] and what the subclass's `super.x(...)` calls. Calls
/// to overridable methods go through the trait, as `this.x(...)` does.
pub mod python_methods {
    use super::*;

    /// `emitBlock(line, f)`.
    pub fn emit_block<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        line: Source,
        f: impl FnOnce(&mut R) -> Result<()>,
    ) -> Result<()> {
        r.emit_line(line);
        r.indent(f)
    }

    /// `string(s)`.
    pub fn string<'a, R: PythonRenderer<'a>>(_r: &R, s: &str) -> Source {
        sl!["\"", string_escape(s), "\""]
    }

    /// `withImport(module, name)`.
    pub fn with_import<'a, R: PythonRenderer<'a>>(r: &mut R, module: &str, name: &str) -> Source {
        if r.py_options().features.type_hints || module != "typing" {
            // FIXME: This is ugly.  We should rather not generate that import in the first
            // place, but right now we just make the type source and then throw it away.  It's
            // not a performance issue, so it's fine, I just bemoan this special case, and
            // potential others down the road.
            r.py_mut()
                .imports
                .entry(module.to_owned())
                .or_default()
                .insert(name.to_owned());
        }

        Source::from(name)
    }

    /// `withModuleImport(module)`.
    pub fn with_module_import<'a, R: PythonRenderer<'a>>(r: &mut R, module: &str) -> Source {
        r.py_mut().module_imports.insert(module.to_owned());
        Source::from(module)
    }

    /// `withTyping(name)`.
    pub fn with_typing<'a, R: PythonRenderer<'a>>(r: &mut R, name: &str) -> Source {
        r.with_import("typing", name)
    }

    /// `namedType(t, suppressQuotes)`.
    pub fn named_type<'a, R: PythonRenderer<'a>>(
        r: &R,
        t: TypeRef,
        suppress_quotes: bool,
    ) -> Result<Source> {
        let name = r.name_for_named_type(t)?;
        if suppress_quotes || r.py().declared_types.contains(&t) {
            return Ok(Source::from(name));
        }
        Ok(sl!["'", name, "'"])
    }

    /// `typeContainsForwardRef(t)`: would rendering `t` as a type
    /// annotation right now require a forward reference, i.e. does it
    /// mention a named type that hasn't been declared yet?
    pub fn type_contains_forward_ref<'a, R: PythonRenderer<'a>>(r: &R, t: TypeRef) -> Result<bool> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = r.type_graph();
            let actual_type = follow_target_type(graph, t)?;
            let ty = graph.type_at(actual_type)?;
            match ty.kind() {
                TypeKind::Class | TypeKind::Enum => {
                    Ok(!r.py().declared_types.contains(&actual_type))
                }
                TypeKind::Array => type_contains_forward_ref(r, ty.items()?),
                TypeKind::Map => type_contains_forward_ref(r, ty.map_values()?),
                TypeKind::Union => {
                    for &m in ty.members()? {
                        if type_contains_forward_ref(r, m)? {
                            return Ok(true);
                        }
                    }
                    Ok(false)
                }
                _ => Ok(false),
            }
        })
    }

    /// `pep604UnionType(unionType, isRootTypeDef, suppressQuotes)`: a union
    /// with PEP 604 syntax, `A | B | None`. A quoted forward reference is
    /// not allowed as an operand of `|` (`'A' | None` is a runtime
    /// `TypeError`), so if any member needs a forward reference the whole
    /// union expression is quoted instead, suppressing the quotes on the
    /// individual names. A `" = None"` default, if required, must go
    /// outside the closing quote: `foo: 'Foo | None' = None`.
    pub fn pep604_union_type<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        union_type: TypeRef,
        is_root_type_def: bool,
        suppress_quotes: bool,
    ) -> Result<Source> {
        let (has_null, non_nulls) =
            remove_null_from_union(r.type_graph(), union_type, NullRemovalSort::None)?;
        let mut needs_quotes = false;
        if !suppress_quotes {
            for &m in &non_nulls {
                if type_contains_forward_ref(r, m)? {
                    needs_quotes = true;
                    break;
                }
            }
        }
        let quote = if needs_quotes { "'" } else { "" };
        let mut member_types = Vec::with_capacity(non_nulls.len());
        for &m in &non_nulls {
            member_types.push(r.python_type(m, false, true)?);
        }

        let mut union: Vec<Source> = vec![quote.into(), intercalate(" | ", member_types)];
        if has_null.is_some() {
            union.push(" | None".into());
        }

        union.push(quote.into());

        if has_null.is_some() {
            union.extend(none_default(r, is_root_type_def));
        }

        Ok(Source::Sequence(union))
    }

    /// `noneDefault(isRootTypeDef)`: a `" = None"` default for a class
    /// property whose value can be `None`. Only emitted for root level type
    /// defs, otherwise we may get type defs like `List[Optional[int] =
    /// None]`, which are invalid. Every property that gets a default must
    /// sort after all properties that don't (see `sortClassProperties`).
    pub fn none_default<'a, R: PythonRenderer<'a>>(r: &R, is_root_type_def: bool) -> Vec<Source> {
        let options = r.py_options();
        if is_root_type_def
            && !r.get_alphabetize_properties()
            && (options.features.data_classes || options.pydantic_base_model)
        {
            return vec![" = None".into()];
        }

        Vec::new()
    }

    /// `classPropertyHasNoneDefault(p)`: does `pythonType(p.type, true)`
    /// end in a `" = None"` default? This mirrors the `noneDefault` calls
    /// in `pythonType`: nullable unions, plus `Any` and `None` typed
    /// properties.
    pub fn class_property_has_none_default<'a, R: PythonRenderer<'a>>(
        r: &R,
        p: &ClassProperty,
    ) -> Result<bool> {
        let graph = r.type_graph();
        let actual_type = follow_target_type(graph, p.type_ref)?;
        let kind = graph.kind(actual_type)?;
        if kind == TypeKind::Union {
            let (has_null, _) = remove_null_from_union(graph, actual_type, NullRemovalSort::None)?;
            return Ok(has_null.is_some());
        }

        Ok(kind == TypeKind::Any || kind == TypeKind::Null)
    }

    /// `pythonType(t, isRootTypeDef, suppressQuotes)`.
    pub fn python_type<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        is_root_type_def: bool,
        suppress_quotes: bool,
    ) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = r.type_graph();
            let actual_type = follow_target_type(graph, t)?;
            let ty = graph.type_at(actual_type)?;
            let builtin_generics = r.py_options().features.builtin_generics;

            Ok(match ty.kind() {
                TypeKind::Any => {
                    let mut parts = vec![r.with_typing("Any")];
                    parts.extend(none_default(r, is_root_type_def));
                    Source::Sequence(parts)
                }
                TypeKind::Null => {
                    let mut parts = vec![Source::from("None")];
                    parts.extend(none_default(r, is_root_type_def));
                    Source::Sequence(parts)
                }
                TypeKind::Bool => "bool".into(),
                TypeKind::Integer => "int".into(),
                TypeKind::Double => "float".into(),
                TypeKind::String => "str".into(),
                TypeKind::Array => {
                    let list = if builtin_generics {
                        Source::from("list")
                    } else {
                        r.with_typing("List")
                    };
                    let items = r.python_type(ty.items()?, false, suppress_quotes)?;
                    sl![list, "[", items, "]"]
                }
                TypeKind::Class | TypeKind::Enum => r.named_type(actual_type, suppress_quotes)?,
                TypeKind::Map => {
                    let dict = if builtin_generics {
                        Source::from("dict")
                    } else {
                        r.with_typing("Dict")
                    };
                    let values = r.python_type(ty.map_values()?, false, suppress_quotes)?;
                    sl![dict, "[str, ", values, "]"]
                }
                TypeKind::Union => {
                    if r.py_options().features.union_operators {
                        return pep604_union_type(
                            r,
                            actual_type,
                            is_root_type_def,
                            suppress_quotes,
                        );
                    }

                    let (has_null, non_nulls) =
                        remove_null_from_union(graph, actual_type, NullRemovalSort::None)?;
                    let mut member_types = Vec::with_capacity(non_nulls.len());
                    for &m in &non_nulls {
                        member_types.push(r.python_type(m, false, suppress_quotes)?);
                    }

                    if has_null.is_some() {
                        let rest = none_default(r, is_root_type_def);

                        if non_nulls.len() > 1 {
                            r.with_import("typing", "Union");
                            let mut parts = vec![
                                r.with_typing("Optional"),
                                "[Union[".into(),
                                intercalate(", ", member_types),
                                "]]".into(),
                            ];
                            parts.extend(rest);
                            return Ok(Source::Sequence(parts));
                        }

                        let first = defined(member_types.into_iter().next())?;
                        let mut parts =
                            vec![r.with_typing("Optional"), "[".into(), first, "]".into()];
                        parts.extend(rest);
                        return Ok(Source::Sequence(parts));
                    }

                    sl![
                        r.with_typing("Union"),
                        "[",
                        intercalate(", ", member_types),
                        "]"
                    ]
                }
                TypeKind::Date => sl![r.with_module_import("datetime"), ".date"],
                TypeKind::Time => sl![r.with_module_import("datetime"), ".time"],
                TypeKind::DateTime => sl![r.with_module_import("datetime"), ".datetime"],
                TypeKind::Uuid => r.with_import("uuid", "UUID"),
                kind if kind.is_transformed_string_type_kind() => {
                    return panic(format!("Transformed type {} not supported", kind.as_str()));
                }
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `declarationLine(t)`.
    pub fn declaration_line<'a, R: PythonRenderer<'a>>(r: &mut R, t: TypeRef) -> Result<Source> {
        match r.type_graph().kind(t)? {
            TypeKind::Class => {
                let name = r.name_for_named_type(t)?;
                if r.py_options().pydantic_base_model {
                    let base = r.with_import("pydantic", "BaseModel");
                    return Ok(sl!["class ", name, "(", base, "):"]);
                }
                Ok(sl!["class ", name, ":"])
            }
            TypeKind::Enum => {
                let name = r.name_for_named_type(t)?;
                let base = r.with_import("enum", "Enum");
                Ok(sl!["class ", name, "(", base, "):"])
            }
            kind => panic(format!("Can't declare type {}", kind.as_str())),
        }
    }

    /// `declareType(t, emitter)`.
    pub fn declare_type<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        t: TypeRef,
        emitter: impl FnOnce(&mut R) -> Result<()>,
    ) -> Result<()> {
        let line = r.declaration_line(t)?;
        r.emit_block(line, |r| {
            let description = r.description_for_type(t)?;
            r.emit_description(description)?;
            emitter(r)
        })?;
        r.py_mut().declared_types.insert(t);
        Ok(())
    }

    /// `emitClassMembers(t)`: `__init__`, unless dataclasses or pydantic
    /// generate it.
    pub fn emit_class_members<'a, R: PythonRenderer<'a>>(r: &mut R, t: TypeRef) -> Result<()> {
        let options = *r.py_options();
        if options.features.data_classes || options.pydantic_base_model {
            return Ok(());
        }

        let mut args: Vec<Source> = Vec::new();
        r.for_each_class_property(t, BlankLinePosition::None, |r, name, _, cp, _| {
            let python_type = r.python_type(cp.type_ref, false, false)?;
            let hint = r.type_hint(vec![": ".into(), python_type]);
            args.push(sl![name, hint]);
            Ok(())
        })?;
        let no_args = args.is_empty();
        let returns = r.type_hint(vec![" -> None".into()]);
        r.emit_block(
            sl![
                "def __init__(self, ",
                intercalate(", ", args),
                ")",
                returns,
                ":"
            ],
            |r| {
                if no_args {
                    r.emit_line("pass");
                    Ok(())
                } else {
                    r.for_each_class_property(t, BlankLinePosition::None, |r, name, _, _, _| {
                        r.emit_line_parts(vec![
                            "self.".into(),
                            name.into(),
                            " = ".into(),
                            name.into(),
                        ]);
                        Ok(())
                    })
                }
            },
        )
    }

    /// `typeHint(...sl)`.
    pub fn type_hint<'a, R: PythonRenderer<'a>>(r: &R, sl: Vec<Source>) -> Source {
        if r.py_options().features.type_hints {
            return Source::Sequence(sl);
        }

        sl![]
    }

    /// `typingDecl(name, type)`.
    pub fn typing_decl<'a, R: PythonRenderer<'a>>(r: &mut R, name: Source, ty: &str) -> Source {
        let typing = r.with_typing(ty);
        let hint = r.type_hint(vec![": ".into(), typing]);
        sl![name, hint]
    }

    /// `typingReturn(type)`.
    pub fn typing_return<'a, R: PythonRenderer<'a>>(r: &mut R, ty: &str) -> Source {
        let typing = r.with_typing(ty);
        r.type_hint(vec![" -> ".into(), typing])
    }

    /// `emitClass(t)`.
    pub fn emit_class<'a, R: PythonRenderer<'a>>(r: &mut R, t: TypeRef) -> Result<()> {
        let options = *r.py_options();
        if options.features.data_classes && !options.pydantic_base_model {
            let dataclass = r.with_import("dataclasses", "dataclass");
            r.emit_line_parts(vec!["@".into(), dataclass]);
        }

        r.declare_type(t, |r| {
            if options.features.type_hints {
                if r.type_graph().type_at(t)?.properties()?.is_empty() {
                    r.emit_line("pass");
                } else {
                    r.for_each_class_property(
                        t,
                        BlankLinePosition::None,
                        |r, name, json_name, cp, _| {
                            let python_type = r.python_type(cp.type_ref, true, false)?;
                            let hint = r.type_hint(vec![": ".into(), python_type]);
                            r.emit_line_parts(vec![name.into(), hint]);
                            let description = r.description_for_class_property(t, json_name)?;
                            r.emit_description(description)
                        },
                    )?;
                }

                r.ensure_blank_line();
            }

            r.emit_class_members(t)
        })
    }

    /// `emitEnum(t)`.
    pub fn emit_enum<'a, R: PythonRenderer<'a>>(r: &mut R, t: TypeRef) -> Result<()> {
        r.declare_type(t, |r| {
            r.for_each_enum_case(t, BlankLinePosition::None, |r, name, json_name, _| {
                let value = r.string(json_name);
                r.emit_line(sl![name, " = ", value]);
                Ok(())
            })
        })
    }

    /// `emitImports()`: the module imports, then the `from` imports, in
    /// discovery order.
    pub fn emit_imports<'a, R: PythonRenderer<'a>>(r: &mut R) -> Result<()> {
        let module_imports: Vec<String> = r.py().module_imports.iter().cloned().collect();
        for module in module_imports {
            r.emit_line_parts(vec!["import ".into(), module.into()]);
        }
        let imports: Vec<(String, String)> = r
            .py()
            .imports
            .iter()
            .map(|(module, names)| {
                (
                    module.clone(),
                    names.iter().cloned().collect::<Vec<_>>().join(", "),
                )
            })
            .collect();
        for (module, names) in imports {
            r.emit_line_parts(vec![
                "from ".into(),
                module.into(),
                " import ".into(),
                names.into(),
            ]);
        }
        Ok(())
    }

    /// `emitSupportCode()`: nothing.
    pub fn emit_support_code<'a, R: PythonRenderer<'a>>(_r: &mut R) -> Result<()> {
        Ok(())
    }

    /// `emitClosingCode()`: nothing.
    pub fn emit_closing_code<'a, R: PythonRenderer<'a>>(_r: &mut R) -> Result<()> {
        Ok(())
    }
}

/// The hooks TS `PythonRenderer` overrides, for both Python renderers.
pub mod python_hooks {
    pub use crate::convenience_renderer::defaults::*;

    use super::super::constants::{FORBIDDEN_PROPERTY_NAMES, FORBIDDEN_TYPE_NAMES};
    use super::super::utils::{class_name_style, snake_name_style};
    use super::*;

    /// `forbiddenNamesForGlobalNamespace()`.
    pub fn forbidden_names_for_global_namespace<'a, R: PythonRenderer<'a>>(
        _r: &mut R,
    ) -> Result<Vec<String>> {
        Ok(FORBIDDEN_TYPE_NAMES.iter().map(|&n| n.to_owned()).collect())
    }

    /// `forbiddenForObjectProperties(c, className)`: the keywords and
    /// builtins, without the global names.
    pub fn forbidden_for_object_properties<'a, R: PythonRenderer<'a>>(
        _r: &mut R,
        _c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: FORBIDDEN_PROPERTY_NAMES.iter().map(|&n| n.into()).collect(),
            include_global_forbidden: false,
        })
    }

    /// `makeNamedTypeNamer()`.
    pub fn make_named_type_namer<'a, R: PythonRenderer<'a>>(_r: &mut R) -> Namer {
        fun_prefix_namer("type", class_name_style)
    }

    /// `namerForObjectProperty()`: a new namer per call, as in TypeScript.
    pub fn namer_for_object_property<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        let nice = r.py_options().nice_property_names;
        Ok(Some(fun_prefix_namer("property", move |s| {
            snake_name_style(s, false, nice)
        })))
    }

    /// `makeUnionMemberNamer()`: none.
    pub fn make_union_member_namer<'a, R: PythonRenderer<'a>>(_r: &mut R) -> Option<Namer> {
        None
    }

    /// `makeEnumCaseNamer()`.
    pub fn make_enum_case_namer<'a, R: PythonRenderer<'a>>(r: &mut R) -> Option<Namer> {
        let nice = r.py_options().nice_property_names;
        Some(fun_prefix_namer("enum-case", move |s| {
            snake_name_style(s, true, nice)
        }))
    }

    /// `commentLineStart`.
    pub fn comment_line_start<'a, R: PythonRenderer<'a>>(_r: &R) -> &'static str {
        "# "
    }

    /// `emitDescriptionBlock(lines)`: a docstring.
    pub fn emit_description_block<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        lines: &[Source],
    ) -> Result<()> {
        if lines.len() == 1 {
            r.emit_comments(&[Comment::Custom {
                options: CommentOptions {
                    line_start: Some("\"\"\"".to_owned()),
                    line_end: Some("\"\"\"".to_owned()),
                    ..CommentOptions::default()
                },
                custom_lines: lines.to_vec(),
            }])
        } else {
            r.emit_comment_lines(
                lines,
                &CommentOptions {
                    first_line_start: Some("\"\"\"".to_owned()),
                    line_start: Some(String::new()),
                    after_comment: Some("\"\"\"".to_owned()),
                    ..CommentOptions::default()
                },
            )
        }
    }

    /// `needsTypeDeclarationBeforeUse`.
    pub fn needs_type_declaration_before_use<'a, R: PythonRenderer<'a>>(_r: &R) -> bool {
        true
    }

    /// `canBeForwardDeclared(t)`: classes and enums.
    pub fn can_be_forward_declared<'a, R: PythonRenderer<'a>>(r: &R, t: TypeRef) -> Result<bool> {
        let kind = r.type_graph().kind(t)?;
        Ok(kind == TypeKind::Class || kind == TypeKind::Enum)
    }

    /// `sortClassProperties(properties, propertyNames)`: with dataclasses or
    /// pydantic, properties that get a `" = None"` default must come after
    /// all properties that don't, or the generated class is invalid (this
    /// ignores `--alphabetize-properties`).
    pub fn sort_class_properties<'a, R: PythonRenderer<'a>>(
        r: &R,
        properties: &IndexMap<String, ClassProperty>,
        property_names: &IndexMap<String, Name>,
    ) -> Result<Vec<(String, ClassProperty)>> {
        let options = r.py_options();
        if options.features.data_classes || options.pydantic_base_model {
            let mut keyed: Vec<(u8, String, ClassProperty)> = Vec::with_capacity(properties.len());
            for (json_name, p) in properties {
                let key = u8::from(python_methods::class_property_has_none_default(r, p)?);
                keyed.push((key, json_name.clone(), *p));
            }
            // `mapSortBy`: a stable sort.
            keyed.sort_by_key(|&(key, _, _)| key);
            return Ok(keyed.into_iter().map(|(_, k, p)| (k, p)).collect());
        }

        crate::convenience_renderer::defaults::sort_class_properties(r, properties, property_names)
    }

    /// `emitSourceStructure()`: the imports, the support code, the
    /// declarations and the closing code. The declarations are gathered
    /// first, since rendering them discovers the imports.
    pub fn emit_source_structure<'a, R: PythonRenderer<'a>>(
        r: &mut R,
        _given_output_filename: &str,
    ) -> Result<()> {
        let declaration_lines = r.gather_source(|r| {
            r.for_each_named_type(
                (BlankLinePosition::Interposing, 2),
                |r, c, _, _| r.emit_class(c),
                |r, e, _, _| r.emit_enum(e),
                |_, _, _, _| Ok(()),
            )
        })?;

        let closing_lines = r.gather_source(|r| r.emit_closing_code())?;
        let support_lines = r.gather_source(|r| r.emit_support_code())?;

        if let Some(leading_comments) = r.leading_comments() {
            r.emit_comments(leading_comments)?;
        }

        r.ensure_blank_line();
        r.emit_imports()?;
        r.ensure_blank_lines(2);
        r.emit_gathered_source(support_lines);
        r.ensure_blank_lines(2);
        r.emit_gathered_source(declaration_lines);
        r.ensure_blank_lines(2);
        r.emit_gathered_source(closing_lines);
        Ok(())
    }
}

/// TS `PythonRenderer` itself: the renderer of `--just-types`.
pub struct PythonPlainRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    py: PythonState,
}

impl std::fmt::Debug for PythonPlainRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("PythonPlainRenderer")
            .field("options", &self.py.options)
            .finish_non_exhaustive()
    }
}

impl<'a> PythonPlainRenderer<'a> {
    /// `new PythonRenderer(targetLanguage, renderContext, pyOptions)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: PythonOptions,
    ) -> Self {
        PythonPlainRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            py: PythonState::new(options),
        }
    }
}

impl<'a> ConvenienceRenderer<'a> for PythonPlainRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(python_hooks);
}

impl<'a> PythonRenderer<'a> for PythonPlainRenderer<'a> {
    fn py(&self) -> &PythonState {
        &self.py
    }

    fn py_mut(&mut self) -> &mut PythonState {
        &mut self.py
    }
}
