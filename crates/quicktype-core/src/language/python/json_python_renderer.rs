//! Port of `packages/quicktype-core/src/language/Python/JSONPythonRenderer.ts`.
//!
//! The Python renderer with JSON converters: `from_dict`/`to_dict` methods
//! built from small converter functions (`from_int`, `from_list`, ...) that
//! are emitted on demand, interpreting the transformers of stringified
//! integers and booleans, and a `<top-level>_from_dict`/`_to_dict` pair per
//! top-level.

use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};
use quicktype_js_compat::number;

use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, TOP_LEVEL_NAME_ORDER};
use crate::source::{MultiWord, multi_word, paren_if_needed, single_word};
use crate::support::recursion::guard;
use crate::support::support::{defined, panic};
use crate::target_language::TargetLanguage;
use crate::transformers::{
    Transformation, Transformer, TransformerData, downcast_transformation, transformation_for_type,
};

use super::python_renderer::{
    PythonOptions, PythonRenderer, PythonState, intercalate, python_hooks, python_methods,
    python_renderer_methods,
};
use super::utils::snake_name_style;

/// TS `ConverterFunction`: the converter functions the generated code may
/// need, emitted in the order they are first used.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum ConverterFunction {
    /// `"none"`.
    None,
    /// `"bool"`.
    Bool,
    /// `"int"`.
    Int,
    /// `"from-float"`.
    FromFloat,
    /// `"to-float"`.
    ToFloat,
    /// `"str"`.
    Str,
    /// `"to-enum"`.
    ToEnum,
    /// `"list"`.
    List,
    /// `"to-class"`.
    ToClass,
    /// `"dict"`.
    Dict,
    /// `"union"`.
    Union,
    /// `"from-date"`.
    FromDate,
    /// `"from-time"`.
    FromTime,
    /// `"from-datetime"`.
    FromDatetime,
    /// `"from-stringified-bool"`.
    FromStringifiedBool,
    /// `"is-type"`.
    IsType,
}

impl ConverterFunction {
    /// The TypeScript string, e.g. `"from-float"`.
    pub fn as_str(self) -> &'static str {
        match self {
            ConverterFunction::None => "none",
            ConverterFunction::Bool => "bool",
            ConverterFunction::Int => "int",
            ConverterFunction::FromFloat => "from-float",
            ConverterFunction::ToFloat => "to-float",
            ConverterFunction::Str => "str",
            ConverterFunction::ToEnum => "to-enum",
            ConverterFunction::List => "list",
            ConverterFunction::ToClass => "to-class",
            ConverterFunction::Dict => "dict",
            ConverterFunction::Union => "union",
            ConverterFunction::FromDate => "from-date",
            ConverterFunction::FromTime => "from-time",
            ConverterFunction::FromDatetime => "from-datetime",
            ConverterFunction::FromStringifiedBool => "from-stringified-bool",
            ConverterFunction::IsType => "is-type",
        }
    }
}

/// TS `TopLevelConverterNames`.
#[derive(Clone, Copy, Debug)]
struct TopLevelConverterNames {
    /// `fromDict`.
    from_dict: Name,
    /// `toDict`.
    to_dict: Name,
}

/// TS `ValueOrLambda`: a value or a lambda. All four combinations are
/// valid:
///
/// * `value` and `lambda`: a value given by applying `value` to `lambda`,
///   i.e. `lambda(value)`
/// * `lambda` only: a lambda given by `lambda`
/// * `value` only: a value given by `value`
/// * neither: the identity function, i.e. `lambda x: x`
#[derive(Clone, Debug)]
pub struct ValueOrLambda {
    /// `lambda`.
    pub lambda: Option<MultiWord>,
    /// `value`.
    pub value: Option<Source>,
}

/// `identity`.
fn identity() -> ValueOrLambda {
    ValueOrLambda {
        lambda: None,
        value: None,
    }
}

/// `{ value }`.
fn value_of(value: Source) -> ValueOrLambda {
    ValueOrLambda {
        lambda: None,
        value: Some(value),
    }
}

/// `{ lambda, value: undefined }`.
fn lambda_of(lambda: MultiWord) -> ValueOrLambda {
    ValueOrLambda {
        lambda: Some(lambda),
        value: None,
    }
}

/// `compose(input, f)` with `f` a TypeScript function: the result of
/// composing `input` and `f`.
///
/// * If `input` is a value, the result is `f(input)`.
/// * If `input` is a lambda, the result is `lambda x: f(input(x))`.
fn compose_with(
    input: ValueOrLambda,
    f: impl FnOnce(Source) -> Result<Source>,
) -> Result<ValueOrLambda> {
    if input.value.is_some() {
        // `input` is a value, so just apply `f` to its source form.
        return Ok(value_of(f(make_value(input)?)?));
    }

    if let Some(lambda) = input.lambda {
        // `input` is a lambda, so build `lambda x: f(input(x))`.
        let applied = f(sl![paren_if_needed(lambda), "(x)"])?;
        return Ok(lambda_of(multi_word(
            " ",
            vec!["lambda x:".into(), applied],
        )?));
    }

    // `input` is the identify function, so the composition is `lambda x: f(x)`.
    let applied = f("x".into())?;
    Ok(lambda_of(multi_word(
        " ",
        vec!["lambda x:".into(), applied],
    )?))
}

/// `compose(input, f)` with `f` a lambda (it can't be a value).
fn compose(input: ValueOrLambda, f: ValueOrLambda) -> Result<ValueOrLambda> {
    if f.value.is_some() {
        return panic("Cannot compose into a value");
    }

    let Some(f_lambda) = f.lambda else {
        // `f` is the identity function, so the result is just `input`.
        return Ok(input);
    };

    if input.value.is_none() {
        // `input` is a lambda
        let Some(input_lambda) = input.lambda else {
            // `input` is the identity function, so the result is just `f`.
            return Ok(lambda_of(f_lambda));
        };

        // `input` is a lambda, so the result is `lambda x: f(input(x))`.
        return Ok(lambda_of(multi_word(
            "",
            vec![
                "lambda x: ".into(),
                paren_if_needed(f_lambda),
                "(".into(),
                paren_if_needed(input_lambda),
                "(x))".into(),
            ],
        )?));
    }

    // `input` is a value, so return `f(input)`.
    Ok(ValueOrLambda {
        lambda: Some(f_lambda),
        value: Some(make_value(input)?),
    })
}

/// `makeLambda(vol)`: `vol` as a lambda; a value becomes a lambda that
/// returns it.
fn make_lambda(vol: ValueOrLambda) -> Result<MultiWord> {
    if let Some(lambda) = vol.lambda {
        let Some(value) = vol.value else {
            return Ok(lambda);
        };

        return multi_word(
            "",
            vec![
                "lambda x: ".into(),
                paren_if_needed(lambda),
                "(".into(),
                value,
                ")".into(),
            ],
        );
    }
    if let Some(value) = vol.value {
        return multi_word(" ", vec!["lambda x:".into(), value]);
    }

    multi_word(" ", vec!["lambda x:".into(), "x".into()])
}

/// `makeValue(vol)`: `vol` as a value; a lambda without a value is not
/// allowed.
fn make_value(vol: ValueOrLambda) -> Result<Source> {
    let Some(value) = vol.value else {
        return panic("Cannot make value from lambda without value");
    };

    if let Some(lambda) = vol.lambda {
        return Ok(sl![paren_if_needed(lambda), "(", value, ")"]);
    }

    Ok(value)
}

/// The transformation of `t`, if any.
fn transformation_of(
    graph: &crate::ty::type_graph::TypeGraph,
    t: TypeRef,
) -> Result<Option<Transformation>> {
    match transformation_for_type(graph, t)? {
        None => Ok(None),
        Some(xf) => Ok(Some(defined(downcast_transformation(xf.as_ref()))?.clone())),
    }
}

/// The body of `from_union`.
const UNION_CONVERTER: &str = "def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False";

/// `JSONPythonRenderer`.
pub struct JsonPythonRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    py: PythonState,
    /// `_deserializerFunctions`: the converters used so far.
    deserializer_functions: IndexSet<ConverterFunction>,
    /// `_converterNamer`.
    converter_namer: Namer,
    /// `_topLevelConverterNames`.
    top_level_converter_names: IndexMap<Name, TopLevelConverterNames>,
    /// `_haveTypeVar`.
    have_type_var: bool,
    /// `_haveEnumTypeVar`.
    have_enum_type_var: bool,
    /// `_haveDateutil`.
    have_dateutil: bool,
}

impl std::fmt::Debug for JsonPythonRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("JsonPythonRenderer")
            .field("options", &self.py.options)
            .finish_non_exhaustive()
    }
}

impl<'a> JsonPythonRenderer<'a> {
    /// `new JSONPythonRenderer(targetLanguage, renderContext, pyOptions)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: PythonOptions,
    ) -> Self {
        let nice = options.nice_property_names;
        JsonPythonRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            py: PythonState::new(options),
            deserializer_functions: IndexSet::new(),
            converter_namer: fun_prefix_namer("converter", move |s| {
                snake_name_style(s, false, nice)
            }),
            top_level_converter_names: IndexMap::new(),
            have_type_var: false,
            have_enum_type_var: false,
            have_dateutil: false,
        }
    }

    /// `emitTypeVar(tvar, constraints)`.
    fn emit_type_var(&mut self, tvar: &str, constraints: Source) {
        if !self.py.options.features.type_hints {
            return;
        }

        let type_var = self.with_typing("TypeVar");
        let name = self.string(tvar);
        self.emit_line_parts(vec![
            tvar.into(),
            " = ".into(),
            type_var,
            "(".into(),
            name,
            constraints,
            ")".into(),
        ]);
    }

    /// `typeVar()`.
    fn type_var(&mut self) -> &'static str {
        self.have_type_var = true;
        // FIXME: This is ugly, but the code that requires the type variables, in
        // `emitImports` actually runs after imports have been imported.  The proper
        // solution would be to either allow more complex dependencies, or to
        // gather-emit the type variable declarations, too.  Unfortunately the
        // gather-emit is a bit buggy with blank lines, and I can't be bothered to
        // fix it now.
        self.with_typing("TypeVar");
        "T"
    }

    /// `enumTypeVar()`.
    fn enum_type_var(&mut self) -> &'static str {
        self.have_enum_type_var = true;
        // See the comment above.
        self.with_typing("TypeVar");
        self.with_import("enum", "Enum");
        "EnumT"
    }

    /// `cast(type, v)`.
    fn cast(&mut self, ty: Source, v: Source) -> Source {
        if !self.py.options.features.type_hints {
            return v;
        }

        sl![self.with_typing("cast"), "(", ty, ", ", v, ")"]
    }

    /// `def <name>(x: Any) -> <result>:` for the simple converters.
    fn converter_line(&mut self, name: &str, result: Source) -> Source {
        let decl = self.typing_decl("x".into(), "Any");
        sl![name, decl, ")", result, ":"]
    }

    /// The `def from_x(...)` block of a simple converter.
    fn emit_simple_converter(&mut self, line: Source, body: &[&str]) -> Result<()> {
        self.emit_block(line, |r| {
            for &l in body {
                r.emit_line(l);
            }
            Ok(())
        })
    }

    /// `emitNoneConverter()`.
    fn emit_none_converter(&mut self) -> Result<()> {
        // FIXME: We can't return the None type here because mypy thinks that means
        // We're not returning any value, when we're actually returning `None`.
        let decl = self.typing_decl("x".into(), "Any");
        let any = self.with_typing("Any");
        let returns = self.type_hint(vec![" -> ".into(), any]);
        self.emit_simple_converter(
            sl!["def from_none(", decl, ")", returns, ":"],
            &["assert x is None", "return x"],
        )
    }

    /// `emitBoolConverter()`.
    fn emit_bool_converter(&mut self) -> Result<()> {
        let returns = self.type_hint(vec![" -> bool".into()]);
        let line = self.converter_line("def from_bool(", returns);
        self.emit_simple_converter(line, &["assert isinstance(x, bool)", "return x"])
    }

    /// `emitIntConverter()`.
    fn emit_int_converter(&mut self) -> Result<()> {
        let returns = self.type_hint(vec![" -> int".into()]);
        let line = self.converter_line("def from_int(", returns);
        self.emit_simple_converter(
            line,
            &[
                "assert isinstance(x, int) and not isinstance(x, bool)",
                "return x",
            ],
        )
    }

    /// `emitFromFloatConverter()`.
    fn emit_from_float_converter(&mut self) -> Result<()> {
        let returns = self.type_hint(vec![" -> float".into()]);
        let line = self.converter_line("def from_float(", returns);
        self.emit_simple_converter(
            line,
            &[
                "assert isinstance(x, (float, int)) and not isinstance(x, bool)",
                "return float(x)",
            ],
        )
    }

    /// `emitToFloatConverter()`.
    fn emit_to_float_converter(&mut self) -> Result<()> {
        let returns = self.type_hint(vec![" -> float".into()]);
        let line = self.converter_line("def to_float(", returns);
        self.emit_simple_converter(line, &["assert isinstance(x, (int, float))", "return x"])
    }

    /// `emitStrConverter()`.
    fn emit_str_converter(&mut self) -> Result<()> {
        let returns = self.type_hint(vec![" -> str".into()]);
        let line = self.converter_line("def from_str(", returns);
        self.emit_block(line, |r| {
            let str_type = "str";
            r.emit_line_parts(vec![
                "assert isinstance(x, ".into(),
                str_type.into(),
                ")".into(),
            ]);
            r.emit_line("return x");
            Ok(())
        })
    }

    /// `typingTypeHint(tvar)`.
    fn typing_type_hint(&mut self, tvar: &str) -> Source {
        if !self.py.options.features.typing_type {
            return sl![];
        }

        let ty = self.with_typing("Type");
        self.type_hint(vec![": ".into(), ty, "[".into(), tvar.into(), "]".into()])
    }

    /// `emitToEnumConverter()`.
    fn emit_to_enum_converter(&mut self) -> Result<()> {
        let tvar = self.enum_type_var();
        let type_hint = self.typing_type_hint(tvar);
        let decl = self.typing_decl("x".into(), "Any");
        let returns = self.type_hint(vec![" -> ".into(), tvar.into()]);
        self.emit_simple_converter(
            sl!["def to_enum(c", type_hint, ", ", decl, ")", returns, ":"],
            &["assert isinstance(x, c)", "return x.value"],
        )
    }

    /// The `Callable[[Any], T]` hint of `from_list`'s and `from_dict`'s `f`.
    fn callable_hint(&mut self, tvar: &str) -> Source {
        let callable = self.with_typing("Callable");
        let any = self.with_typing("Any");
        self.type_hint(vec![
            ": ".into(),
            callable,
            "[[".into(),
            any,
            "], ".into(),
            tvar.into(),
            "]".into(),
        ])
    }

    /// `emitListConverter()`.
    fn emit_list_converter(&mut self) -> Result<()> {
        let tvar = self.type_var();
        let f_hint = self.callable_hint(tvar);
        let decl = self.typing_decl("x".into(), "Any");
        let list = if self.py.options.features.builtin_generics {
            Source::from("list")
        } else {
            self.with_typing("List")
        };
        let returns = self.type_hint(vec![
            " -> ".into(),
            list,
            "[".into(),
            tvar.into(),
            "]".into(),
        ]);
        self.emit_simple_converter(
            sl!["def from_list(f", f_hint, ", ", decl, ")", returns, ":"],
            &["assert isinstance(x, list)", "return [f(y) for y in x]"],
        )
    }

    /// `emitToClassConverter()`.
    fn emit_to_class_converter(&mut self) -> Result<()> {
        let tvar = self.type_var();
        let type_hint = self.typing_type_hint(tvar);
        let decl = self.typing_decl("x".into(), "Any");
        let returns = self.type_hint(vec![" -> dict".into()]);
        self.emit_block(
            sl!["def to_class(c", type_hint, ", ", decl, ")", returns, ":"],
            |r| {
                r.emit_line("assert isinstance(x, c)");
                let any = r.with_typing("Any");
                let cast = r.cast(any, "x".into());
                r.emit_line_parts(vec!["return ".into(), cast, ".to_dict()".into()]);
                Ok(())
            },
        )
    }

    /// `emitDictConverter()`.
    fn emit_dict_converter(&mut self) -> Result<()> {
        let tvar = self.type_var();
        let f_hint = self.callable_hint(tvar);
        let decl = self.typing_decl("x".into(), "Any");
        let dict = if self.py.options.features.builtin_generics {
            Source::from("dict")
        } else {
            self.with_typing("Dict")
        };
        let returns = self.type_hint(vec![
            " -> ".into(),
            dict,
            "[str, ".into(),
            tvar.into(),
            "]".into(),
        ]);
        self.emit_simple_converter(
            sl!["def from_dict(f", f_hint, ", ", decl, ")", returns, ":"],
            &[
                "assert isinstance(x, dict)",
                "return { k: f(v) for (k, v) in x.items() }",
            ],
        )
    }

    /// `emitUnionConverter()`: not easily idiomatically typeable in Python
    /// (see <https://stackoverflow.com/questions/51066468/computed-types-in-mypy/51084497>).
    fn emit_union_converter(&mut self) -> Result<()> {
        self.emit_multiline(UNION_CONVERTER)
    }

    /// `emitFromDateConverter()`, `emitFromTimeConverter()` and
    /// `emitFromDatetimeConverter()`: `name` returns `datetime.<kind>`,
    /// checking the string with `pattern` first (if any).
    fn emit_from_date_time_converter(
        &mut self,
        name: &str,
        kind: &str,
        pattern: Option<&str>,
        result: &str,
    ) -> Result<()> {
        let decl = self.typing_decl("x".into(), "Any");
        let datetime = self.with_module_import("datetime");
        let returns = self.type_hint(vec![" -> ".into(), sl![datetime, kind]]);
        self.emit_block(sl![name, decl, ")", returns, ":"], |r| {
            r.have_dateutil = true;
            if let Some(pattern) = pattern {
                let re = r.with_module_import("re");
                r.emit_line_parts(vec![
                    "assert isinstance(x, str) and ".into(),
                    re,
                    pattern.into(),
                ]);
            }
            r.emit_line(result);
            Ok(())
        })
    }

    /// `emitFromStringifiedBoolConverter()`.
    fn emit_from_stringified_bool_converter(&mut self) -> Result<()> {
        let arg = self.type_hint(vec![": str".into()]);
        let returns = self.type_hint(vec![" -> bool".into()]);
        self.emit_block(
            sl!["def from_stringified_bool(x", arg, ")", returns, ":"],
            |r| {
                r.emit_block("if x == \"true\":".into(), |r| {
                    r.emit_line("return True");
                    Ok(())
                })?;
                r.emit_block("if x == \"false\":".into(), |r| {
                    r.emit_line("return False");
                    Ok(())
                })?;
                r.emit_line("assert False");
                Ok(())
            },
        )
    }

    /// `emitIsTypeConverter()`.
    fn emit_is_type_converter(&mut self) -> Result<()> {
        let tvar = self.type_var();
        let type_hint = self.typing_type_hint(tvar);
        let decl = self.typing_decl("x".into(), "Any");
        let returns = self.type_hint(vec![" -> ".into(), tvar.into()]);
        self.emit_simple_converter(
            sl!["def is_type(t", type_hint, ", ", decl, ")", returns, ":"],
            &["assert isinstance(x, t)", "return x"],
        )
    }

    /// `emitConverter(cf)`.
    fn emit_converter(&mut self, cf: ConverterFunction) -> Result<()> {
        match cf {
            ConverterFunction::None => self.emit_none_converter(),
            ConverterFunction::Bool => self.emit_bool_converter(),
            ConverterFunction::Int => self.emit_int_converter(),
            ConverterFunction::FromFloat => self.emit_from_float_converter(),
            ConverterFunction::ToFloat => self.emit_to_float_converter(),
            ConverterFunction::Str => self.emit_str_converter(),
            ConverterFunction::ToEnum => self.emit_to_enum_converter(),
            ConverterFunction::List => self.emit_list_converter(),
            ConverterFunction::ToClass => self.emit_to_class_converter(),
            ConverterFunction::Dict => self.emit_dict_converter(),
            ConverterFunction::Union => self.emit_union_converter(),
            ConverterFunction::FromDate => self.emit_from_date_time_converter(
                "def from_date(",
                ".date",
                Some(".match(r\"^\\d{4}-\\d{2}-\\d{2}$\", x)"),
                "return dateutil.parser.parse(x).date()",
            ),
            ConverterFunction::FromTime => self.emit_from_date_time_converter(
                "def from_time(",
                ".time",
                Some(".match(r\"^\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?(?:Z|[+-]\\d{2}:\\d{2})?$\", x)"),
                "return dateutil.parser.parse(x).timetz()",
            ),
            ConverterFunction::FromDatetime => self.emit_from_date_time_converter(
                "def from_datetime(",
                ".datetime",
                None,
                "return dateutil.parser.parse(x)",
            ),
            ConverterFunction::FromStringifiedBool => self.emit_from_stringified_bool_converter(),
            ConverterFunction::IsType => self.emit_is_type_converter(),
        }
    }

    /// `conv(cf)`: the name of the Python converter function `cf`.
    fn conv(&mut self, cf: ConverterFunction) -> Source {
        self.deserializer_functions.insert(cf);
        let s = cf.as_str();
        let name = s.replace('-', "_");
        if s.starts_with("from-") || s.starts_with("to-") || s.starts_with("is-") {
            return name.into();
        }
        sl!["from_", name]
    }

    /// `convFn(cf, arg)`: applies the converter function to `arg`.
    fn conv_fn(&mut self, cf: ConverterFunction, arg: ValueOrLambda) -> Result<ValueOrLambda> {
        let conv = self.conv(cf);
        compose(arg, lambda_of(single_word(vec![conv])))
    }

    /// `typeObject(t)`: the Python type object of `t`, for `is_type`.
    fn type_object(&mut self, t: TypeRef) -> Result<Source> {
        let kind = self.type_graph().kind(t)?;
        let s: Option<Source> = match kind {
            TypeKind::Any | TypeKind::Union => None,
            TypeKind::Null => Some("type(None)".into()),
            TypeKind::Bool => Some("bool".into()),
            TypeKind::Integer => Some("int".into()),
            TypeKind::Double => Some("float".into()),
            TypeKind::String => Some("str".into()),
            TypeKind::Array => Some(if self.py.options.features.builtin_generics {
                "list".into()
            } else {
                "List".into()
            }),
            TypeKind::Class | TypeKind::Enum => Some(self.name_for_named_type(t)?.into()),
            TypeKind::Map => Some("dict".into()),
            TypeKind::Date => Some(sl![self.with_module_import("datetime"), ".date"]),
            TypeKind::Time => Some(sl![self.with_module_import("datetime"), ".time"]),
            TypeKind::DateTime => Some(sl![self.with_module_import("datetime"), ".datetime"]),
            TypeKind::Uuid => Some(self.with_import("uuid", "UUID")),
            k if k.is_transformed_string_type_kind() => None,
            k => return match_type_unsupported(k),
        };
        match s {
            Some(s) => Ok(s),
            None => panic(format!("No type object for {}", kind.as_str())),
        }
    }

    /// `transformer(inputTransformer, xfer, targetType)`: the code that
    /// runs `xfer` on `input`.
    fn transformer(
        &mut self,
        input: ValueOrLambda,
        xfer: &Rc<Transformer>,
        target_type: TypeRef,
    ) -> Result<ValueOrLambda> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            match xfer.data() {
                TransformerData::DecodingChoice(_) | TransformerData::Choice { .. } => {
                    let mut lambdas = Vec::new();
                    for x in xfer.transformers() {
                        let vol = self.transformer(identity(), &x, target_type)?;
                        lambdas.push(make_lambda(vol)?.source);
                    }
                    compose_with(input, |v| {
                        let conv = self.conv(ConverterFunction::Union);
                        Ok(sl![conv, "([", intercalate(", ", lambdas), "], ", v, ")"])
                    })
                }
                TransformerData::Decoding { consumer } => {
                    let vol = self.deserializer(input, xfer.source_type_ref())?;
                    self.consume(consumer.as_ref(), vol, target_type)
                }
                TransformerData::Encoding => self.serializer(input, xfer.source_type_ref()),
                TransformerData::UnionInstantiation => Ok(input),
                TransformerData::UnionMemberMatch {
                    transformer,
                    member_type_ref,
                } => {
                    let member_type = *member_type_ref;
                    let vol = compose_with(input, |v| {
                        let conv = self.conv(ConverterFunction::IsType);
                        let type_object = self.type_object(member_type)?;
                        Ok(sl![conv, "(", type_object, ", ", v, ")"])
                    })?;
                    self.consume(Some(transformer), vol, target_type)
                }
                TransformerData::ParseString { consumer } => {
                    let immediate_kind = match consumer {
                        None => graph.kind(target_type)?,
                        Some(consumer) => consumer.source_type_kind(graph)?,
                    };
                    let vol = match immediate_kind {
                        TypeKind::Integer => compose_with(input, |v| Ok(sl!["int(", v, ")"]))?,
                        TypeKind::Bool => {
                            self.conv_fn(ConverterFunction::FromStringifiedBool, input)?
                        }
                        TypeKind::Enum => {
                            let immediate_target_type = match consumer {
                                None => target_type,
                                Some(consumer) => consumer.source_type_ref(),
                            };
                            self.deserializer(input, immediate_target_type)?
                        }
                        TypeKind::Date => self.conv_fn(ConverterFunction::FromDate, input)?,
                        TypeKind::Time => self.conv_fn(ConverterFunction::FromTime, input)?,
                        TypeKind::DateTime => {
                            self.conv_fn(ConverterFunction::FromDatetime, input)?
                        }
                        TypeKind::Uuid => compose_with(input, |v| {
                            let uuid = self.with_import("uuid", "UUID");
                            Ok(sl![uuid, "(", v, ")"])
                        })?,
                        kind => {
                            return panic(format!(
                                "Parsing of {} in a transformer is not supported",
                                kind.as_str()
                            ));
                        }
                    };

                    self.consume(consumer.as_ref(), vol, target_type)
                }
                TransformerData::Stringify { consumer } => {
                    let vol = match xfer.source_type_kind(graph)? {
                        TypeKind::Integer => compose_with(input, |v| Ok(sl!["str(", v, ")"]))?,
                        TypeKind::Bool => compose_with(input, |v| Ok(sl!["str(", v, ").lower()"]))?,
                        TypeKind::Enum => self.serializer(input, xfer.source_type_ref())?,
                        TypeKind::Date | TypeKind::Time | TypeKind::DateTime => {
                            compose_with(input, |v| Ok(sl![v, ".isoformat()"]))?
                        }
                        TypeKind::Uuid => compose_with(input, |v| Ok(sl!["str(", v, ")"]))?,
                        kind => {
                            return panic(format!(
                                "Parsing of {} in a transformer is not supported",
                                kind.as_str()
                            ));
                        }
                    };

                    self.consume(consumer.as_ref(), vol, target_type)
                }
                _ => panic(format!("Transformer {} is not supported", xfer.kind())),
            }
        })
    }

    /// `consume(consumer, vol)` of `transformer`: `vol`, then `consumer`.
    fn consume(
        &mut self,
        consumer: Option<&Rc<Transformer>>,
        vol: ValueOrLambda,
        target_type: TypeRef,
    ) -> Result<ValueOrLambda> {
        match consumer {
            None => Ok(vol),
            Some(consumer) => self.transformer(vol, consumer, target_type),
        }
    }

    /// `unionMembers(unionType)`: the members, with an integer moved in
    /// front of a double (`from_float` also accepts integers, so `from_int`
    /// must be tried first).
    fn union_members(&self, union_type: TypeRef) -> Result<Vec<TypeRef>> {
        let graph = self.type_graph();
        let mut members: Vec<TypeRef> = graph
            .type_at(union_type)?
            .members()?
            .iter()
            .copied()
            .collect();
        let mut integer_index = None;
        let mut double_index = None;
        for (i, &m) in members.iter().enumerate() {
            let kind = graph.kind(m)?;
            if kind == TypeKind::Integer && integer_index.is_none() {
                integer_index = Some(i);
            }
            if kind == TypeKind::Double && double_index.is_none() {
                double_index = Some(i);
            }
        }

        if let (Some(double_index), Some(integer_index)) = (double_index, integer_index) {
            if integer_index > double_index {
                let integer_type = members.remove(integer_index);
                members.insert(double_index, integer_type);
            }
        }

        Ok(members)
    }

    /// `deserializer(value, t)`: the code to deserialize `value` as type
    /// `t`. If `t` has an associated transformer, the code for that
    /// transformer is returned.
    fn deserializer(&mut self, value: ValueOrLambda, t: TypeRef) -> Result<ValueOrLambda> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            if let Some(xf) = transformation_of(graph, t)? {
                return self.transformer(value, xf.transformer(), xf.target_type_ref());
            }

            let ty = graph.type_at(t)?;
            match ty.kind() {
                TypeKind::Any => Ok(value),
                TypeKind::Null => self.conv_fn(ConverterFunction::None, value),
                TypeKind::Bool => self.conv_fn(ConverterFunction::Bool, value),
                TypeKind::Integer => self.conv_fn(ConverterFunction::Int, value),
                TypeKind::Double => self.conv_fn(ConverterFunction::FromFloat, value),
                TypeKind::String => self.conv_fn(ConverterFunction::Str, value),
                TypeKind::Array => {
                    let items = ty.items()?;
                    compose_with(value, |v| {
                        let conv = self.conv(ConverterFunction::List);
                        let inner = make_lambda(self.deserializer(identity(), items)?)?.source;
                        Ok(sl![conv, "(", inner, ", ", v, ")"])
                    })
                }
                TypeKind::Class => {
                    let name = self.name_for_named_type(t)?;
                    compose(
                        value,
                        lambda_of(single_word(vec![name.into(), ".from_dict".into()])),
                    )
                }
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    compose_with(value, |v| {
                        let conv = self.conv(ConverterFunction::Dict);
                        let inner = make_lambda(self.deserializer(identity(), values)?)?.source;
                        Ok(sl![conv, "(", inner, ", ", v, ")"])
                    })
                }
                TypeKind::Enum => {
                    let name = self.name_for_named_type(t)?;
                    compose(value, lambda_of(single_word(vec![name.into()])))
                }
                TypeKind::Union => {
                    // FIXME: handle via transformers
                    let mut deserializers = Vec::new();
                    for m in self.union_members(t)? {
                        deserializers.push(make_lambda(self.deserializer(identity(), m)?)?.source);
                    }
                    compose_with(value, |v| {
                        let conv = self.conv(ConverterFunction::Union);
                        Ok(sl![
                            conv,
                            "([",
                            intercalate(", ", deserializers),
                            "], ",
                            v,
                            ")"
                        ])
                    })
                }
                // FIXME: handle via transformers
                TypeKind::Date => self.conv_fn(ConverterFunction::FromDate, value),
                TypeKind::Time => self.conv_fn(ConverterFunction::FromTime, value),
                TypeKind::DateTime => self.conv_fn(ConverterFunction::FromDatetime, value),
                TypeKind::Uuid => compose_with(value, |v| {
                    let uuid = self.with_import("uuid", "UUID");
                    Ok(sl![uuid, "(", v, ")"])
                }),
                kind if kind.is_transformed_string_type_kind() => {
                    panic(format!("Transformed type {} not supported", kind.as_str()))
                }
                kind => match_type_unsupported(kind),
            }
        })
    }

    /// `serializer(value, t)`: the code to serialize `value` of type `t`.
    fn serializer(&mut self, value: ValueOrLambda, t: TypeRef) -> Result<ValueOrLambda> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            if let Some(xf) = transformation_of(graph, t)? {
                let reverse = xf.reverse(graph)?;
                return self.transformer(value, reverse.transformer(), reverse.target_type_ref());
            }

            let ty = graph.type_at(t)?;
            match ty.kind() {
                TypeKind::Any => Ok(value),
                TypeKind::Null => self.conv_fn(ConverterFunction::None, value),
                TypeKind::Bool => self.conv_fn(ConverterFunction::Bool, value),
                TypeKind::Integer => self.conv_fn(ConverterFunction::Int, value),
                TypeKind::Double => self.conv_fn(ConverterFunction::ToFloat, value),
                TypeKind::String => self.conv_fn(ConverterFunction::Str, value),
                TypeKind::Array => {
                    let items = ty.items()?;
                    compose_with(value, |v| {
                        let conv = self.conv(ConverterFunction::List);
                        let inner = make_lambda(self.serializer(identity(), items)?)?.source;
                        Ok(sl![conv, "(", inner, ", ", v, ")"])
                    })
                }
                TypeKind::Class => compose_with(value, |v| {
                    let conv = self.conv(ConverterFunction::ToClass);
                    let name = self.name_for_named_type(t)?;
                    Ok(sl![conv, "(", name, ", ", v, ")"])
                }),
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    compose_with(value, |v| {
                        let conv = self.conv(ConverterFunction::Dict);
                        let inner = make_lambda(self.serializer(identity(), values)?)?.source;
                        Ok(sl![conv, "(", inner, ", ", v, ")"])
                    })
                }
                TypeKind::Enum => compose_with(value, |v| {
                    let conv = self.conv(ConverterFunction::ToEnum);
                    let name = self.name_for_named_type(t)?;
                    Ok(sl![conv, "(", name, ", ", v, ")"])
                }),
                TypeKind::Union => {
                    let mut serializers = Vec::new();
                    for m in self.union_members(t)? {
                        serializers.push(make_lambda(self.serializer(identity(), m)?)?.source);
                    }
                    compose_with(value, |v| {
                        let conv = self.conv(ConverterFunction::Union);
                        Ok(sl![
                            conv,
                            "([",
                            intercalate(", ", serializers),
                            "], ",
                            v,
                            ")"
                        ])
                    })
                }
                TypeKind::Date | TypeKind::Time | TypeKind::DateTime => {
                    compose_with(value, |v| Ok(sl![v, ".isoformat()"]))
                }
                TypeKind::Uuid => compose_with(value, |v| Ok(sl!["str(", v, ")"])),
                kind if kind.is_transformed_string_type_kind() => {
                    panic(format!("Transformed type {} not supported", kind.as_str()))
                }
                kind => match_type_unsupported(kind),
            }
        })
    }

    /// The `assert`s of `from_dict` for the constraints of a property.
    fn emit_constraint_checks(
        &mut self,
        name: Name,
        cp: &ClassProperty,
        property_value: &Source,
    ) -> Result<()> {
        let graph = self.type_graph();
        let t = cp.type_ref;
        let check = |r: &mut Self, condition: Source| {
            r.emit_line_parts(vec![
                "assert ".into(),
                name.into(),
                " is None or ".into(),
                condition,
            ]);
        };
        let (min, max) = min_max_items_for_type(graph, t)?.map_or((None, None), |c| (c.0, c.1));
        if let Some(min) = min {
            check(self, sl![number::to_string(min), " <= len(", name, ")"]);
        }
        if let Some(max) = max {
            check(self, sl!["len(", name, ") <= ", number::to_string(max)]);
        }
        let (min_value, max_value) =
            min_max_value_for_type(graph, t)?.map_or((None, None), |c| (c.0, c.1));
        if let Some(min_value) = min_value {
            check(self, sl![number::to_string(min_value), " <= ", name]);
        }
        if let Some(max_value) = max_value {
            check(self, sl![name, " <= ", number::to_string(max_value)]);
        }
        let (lo, hi) = min_max_length_for_type(graph, t)?.map_or((None, None), |c| (c.0, c.1));
        if lo.is_some() || hi.is_some() {
            let raw = self.cast("str".into(), property_value.clone());
            if let Some(lo) = lo {
                check(
                    self,
                    sl![number::to_string(lo), " <= len(", raw.clone(), ")"],
                );
            }
            if let Some(hi) = hi {
                check(self, sl!["len(", raw, ") <= ", number::to_string(hi)]);
            }
        }
        if let Some(pattern) = pattern_for_type(graph, t)? {
            let re = self.with_module_import("re");
            let pattern = self.string(&pattern);
            let cast = self.cast("str".into(), property_value.clone());
            check(self, sl![re, ".search(", pattern, ", ", cast, ")"]);
        }
        Ok(())
    }

    // `emitDefaultLeadingComments()` is not ported: TypeScript never calls it.
}

/// The methods TS `JSONPythonRenderer` overrides on top of
/// [`python_methods`].
pub mod json_python_methods {
    pub use super::python_methods::*;

    use super::*;

    /// `emitClassMembers(t)`: `__init__` (if any), `from_dict` and
    /// `to_dict`.
    pub fn emit_class_members(r: &mut JsonPythonRenderer<'_>, t: TypeRef) -> Result<()> {
        python_methods::emit_class_members(r, t)?;
        r.ensure_blank_line();

        let class_name = r.name_for_named_type(t)?;

        r.emit_line("@staticmethod");
        let decl = r.typing_decl("obj".into(), "Any");
        let named_type = r.named_type(t, false)?;
        let returns = r.type_hint(vec![" -> ".into(), named_type]);
        r.emit_block(sl!["def from_dict(", decl, ")", returns, ":"], |r| {
            let mut args: Vec<Source> = Vec::new();
            r.emit_line("assert isinstance(obj, dict)");
            r.for_each_class_property(t, BlankLinePosition::None, |r, name, json_name, cp, _| {
                let key = r.string(json_name);
                let property_value = if cp.is_optional {
                    sl!["obj.get(", key, ")"]
                } else {
                    sl!["obj[", key, "]"]
                };
                let deserialized = r.deserializer(value_of(property_value.clone()), cp.type_ref)?;
                let value = make_value(deserialized)?;
                r.emit_line_parts(vec![name.into(), " = ".into(), value]);
                args.push(name.into());
                r.emit_constraint_checks(name, &cp, &property_value)
            })?;
            r.emit_line_parts(vec![
                "return ".into(),
                class_name.into(),
                "(".into(),
                intercalate(", ", args),
                ")".into(),
            ]);
            Ok(())
        })?;
        r.ensure_blank_line();

        let returns = r.type_hint(vec![" -> dict".into()]);
        r.emit_block(sl!["def to_dict(self)", returns, ":"], |r| {
            let hint = r.type_hint(vec![": dict".into()]);
            r.emit_line_parts(vec!["result".into(), hint, " = {}".into()]);
            r.for_each_class_property(t, BlankLinePosition::None, |r, name, json_name, cp, _| {
                let property = value_of(sl!["self.", name]);
                if cp.is_optional {
                    r.emit_block(sl!["if self.", name, " is not None:"], |r| {
                        let key = r.string(json_name);
                        let value = make_value(r.serializer(property, cp.type_ref)?)?;
                        r.emit_line_parts(vec!["result[".into(), key, "] = ".into(), value]);
                        Ok(())
                    })
                } else {
                    let key = r.string(json_name);
                    let value = make_value(r.serializer(property, cp.type_ref)?)?;
                    r.emit_line_parts(vec!["result[".into(), key, "] = ".into(), value]);
                    Ok(())
                }
            })?;
            r.emit_line("return result");
            Ok(())
        })
    }

    /// `emitImports()`: also `dateutil` and the type variables.
    pub fn emit_imports(r: &mut JsonPythonRenderer<'_>) -> Result<()> {
        python_methods::emit_imports(r)?;
        if r.have_dateutil {
            r.emit_line("import dateutil.parser");
        }

        if !r.have_type_var && !r.have_enum_type_var {
            return Ok(());
        }

        r.ensure_blank_lines(2);
        if r.have_type_var {
            let tvar = r.type_var();
            r.emit_type_var(tvar, sl![]);
        }

        if r.have_enum_type_var {
            let tvar = r.enum_type_var();
            let bound = r.with_import("enum", "Enum");
            r.emit_type_var(tvar, sl![", bound=", bound]);
        }
        Ok(())
    }

    /// `emitSupportCode()`: the converter functions used, in the order of
    /// first use.
    pub fn emit_support_code(r: &mut JsonPythonRenderer<'_>) -> Result<()> {
        let map: Vec<(ConverterFunction, ConverterFunction)> =
            r.deserializer_functions.iter().map(|&f| (f, f)).collect();
        r.for_each_with_blank_lines(map, (BlankLinePosition::Interposing, 2), |r, cf, _, _| {
            r.emit_converter(cf)
        })?;
        Ok(())
    }

    /// `emitClosingCode()`: `<top-level>_from_dict` and `_to_dict` per
    /// top-level.
    pub fn emit_closing_code(r: &mut JsonPythonRenderer<'_>) -> Result<()> {
        r.for_each_top_level((BlankLinePosition::Interposing, 2), |r, t, name, _| {
            let names = *defined(r.top_level_converter_names.get(&name))?;
            let python_type = r.python_type(t, false, false)?;
            let decl = r.typing_decl("s".into(), "Any");
            let returns = r.type_hint(vec![" -> ".into(), python_type.clone()]);
            r.emit_block(
                sl!["def ", names.from_dict, "(", decl, ")", returns, ":"],
                |r| {
                    let value = make_value(r.deserializer(value_of("s".into()), t)?)?;
                    r.emit_line_parts(vec!["return ".into(), value]);
                    Ok(())
                },
            )?;
            r.ensure_blank_lines(2);
            let arg = r.type_hint(vec![": ".into(), python_type]);
            let returns = r.typing_return("Any");
            r.emit_block(
                sl!["def ", names.to_dict, "(x", arg, ")", returns, ":"],
                |r| {
                    let value = make_value(r.serializer(value_of("x".into()), t)?)?;
                    r.emit_line_parts(vec!["return ".into(), value]);
                    Ok(())
                },
            )
        })?;
        Ok(())
    }
}

/// The hooks TS `JSONPythonRenderer` overrides on top of [`python_hooks`].
pub mod json_python_hooks {
    pub use super::python_hooks::*;

    use super::*;

    /// `forbiddenForObjectProperties(c, className)`: also `from_dict` and
    /// `to_dict`.
    pub fn forbidden_for_object_properties(
        r: &mut JsonPythonRenderer<'_>,
        c: TypeRef,
        class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let mut result = python_hooks::forbidden_for_object_properties(r, c, class_name)?;
        result.names.push("from_dict".into());
        result.names.push("to_dict".into());
        Ok(result)
    }

    /// `makeTopLevelDependencyNames(t, topLevelName)`: the names of the
    /// top-level's `from_dict` and `to_dict` functions.
    pub fn make_top_level_dependency_names(
        r: &mut JsonPythonRenderer<'_>,
        _t: TypeRef,
        top_level_name: Name,
    ) -> Result<Vec<Name>> {
        let namer = r.converter_namer.clone();
        let from_dict =
            r.naming_mut()
                .dependency_name(Some(&namer), TOP_LEVEL_NAME_ORDER, move |l| {
                    format!("{}_from_dict", l(top_level_name))
                });
        let to_dict =
            r.naming_mut()
                .dependency_name(Some(&namer), TOP_LEVEL_NAME_ORDER, move |l| {
                    format!("{}_to_dict", l(top_level_name))
                });
        r.top_level_converter_names.insert(
            top_level_name,
            TopLevelConverterNames { from_dict, to_dict },
        );
        Ok(vec![from_dict, to_dict])
    }
}

impl<'a> ConvenienceRenderer<'a> for JsonPythonRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(json_python_hooks);
}

impl<'a> PythonRenderer<'a> for JsonPythonRenderer<'a> {
    fn py(&self) -> &PythonState {
        &self.py
    }

    fn py_mut(&mut self) -> &mut PythonState {
        &mut self.py
    }

    python_renderer_methods!([forward json_python_methods]);
}
