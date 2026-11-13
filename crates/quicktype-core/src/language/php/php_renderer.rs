//! Port of `packages/quicktype-core/src/language/Php/PhpRenderer.ts`.
//!
//! Renders PHP classes with typed properties, converters from and to
//! `stdClass`, validators and sample values; enums as classes of static
//! instances; unions inline as PHP 8 union types with runtime dispatch.
//!
//! `phpDocConvertType` is never called in TypeScript and is not ported.

use indexmap::{IndexMap, IndexSet};

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::messages::{JsErrorName, QuickTypeError};
use crate::renderer_options::RendererOptions;
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::comments::CommentOptions;
use crate::support::recursion::guard;
use crate::support::support::defined;
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, directly_reachable_single_named_type, is_nullable, nullable_from_union,
    remove_null_from_union,
};

use super::language::{ACRONYM_STYLE, FAST_GET, WITH_CLOSING, WITH_GET, WITH_SET};
use super::utils::{PHP_FORBIDDEN_CLASS_NAMES, php_name_style, string_escape};

/// A JavaScript `Error` thrown by the TypeScript (`throw new Error(...)`).
fn js_error<T>(message: impl Into<String>) -> Result<T> {
    Err(QuickTypeError::js_exception(JsErrorName::Error, message))
}

/// The option values of the PHP renderer (TS
/// `OptionValues<typeof phpOptions>`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct PhpOptions {
    /// `withGet`: getters (and sample methods).
    pub with_get: bool,
    /// `fastGet`: getters without validation.
    pub fast_get: bool,
    /// `withSet`: setters.
    pub with_set: bool,
    /// `withClosing`: a closing `?>`.
    pub with_closing: bool,
    /// `acronymStyle`.
    pub acronym_style: AcronymStyleOptions,
}

impl PhpOptions {
    /// `getOptionValues(phpOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let with_get = WITH_GET.get_value(values);
        let fast_get = FAST_GET.get_value(values);
        let with_set = WITH_SET.get_value(values);
        let with_closing = WITH_CLOSING.get_value(values);
        // An `Object.prototype` member selects no style (`undefined`), so
        // `phpNameStyle`'s default parameter, `allUpperWordStyle` (the
        // Pascal style), takes its place.
        let acronym_style =
            AcronymStyleOptions::from_enum_value(ACRONYM_STYLE.get_enum_value(values)?)
                .unwrap_or(AcronymStyleOptions::Pascal);
        Ok(PhpOptions {
            with_get,
            fast_get,
            with_set,
            with_closing,
            acronym_style,
        })
    }
}

/// `FunctionNames`: the names of a property's accessor functions.
#[derive(Clone, Copy, Debug)]
pub struct FunctionNames {
    /// `from_<property>`.
    pub from: Name,
    /// `get_<property>`.
    pub getter: Name,
    /// `sample_<property>`.
    pub sample: Name,
    /// `set_<property>`.
    pub setter: Name,
    /// `to_<property>`.
    pub to: Name,
    /// `validate_<property>`.
    pub validate: Name,
}

/// The conventions of `getNameStyling`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum NameStyling {
    /// `typeNamingFunction`.
    Type,
    /// `propertyNamingFunction`.
    Property,
    /// `enumCaseNamingFunction`.
    EnumCase,
}

/// `PhpRenderer`.
pub struct PhpRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: PhpOptions,
    /// `_gettersAndSettersForPropertyName`.
    getters_and_setters_for_property_name: IndexMap<Name, FunctionNames>,
    /// `_haveEmittedLeadingComments`.
    have_emitted_leading_comments: bool,
}

impl std::fmt::Debug for PhpRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("PhpRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// The runtime-dispatch order of union members (`sortedUnionMembers`).
const UNION_MEMBER_ORDER: [TypeKind; 10] = [
    TypeKind::Class,
    TypeKind::Enum,
    TypeKind::DateTime,
    TypeKind::Uuid,
    TypeKind::Map,
    TypeKind::Array,
    TypeKind::Bool,
    TypeKind::Integer,
    TypeKind::Double,
    TypeKind::String,
];

/// `_.pad(s, 2, "0")`: pads to two characters, on the right first (lodash
/// puts the extra character of an odd padding on the right).
fn lodash_pad2(s: &str) -> String {
    let len = quicktype_js_compat::utf16::len(s);
    if len >= 2 {
        return s.to_owned();
    }
    let padding = 2 - len;
    let left = padding / 2;
    let right = padding - left;
    format!("{}{s}{}", "0".repeat(left), "0".repeat(right))
}

/// `${n}` for a JavaScript number.
fn js_number(n: f64) -> String {
    quicktype_js_compat::number::to_string(n)
}

/// Callbacks of [`PhpRenderer::emit_union_dispatch`].
type EmitMember<'f, 'a> = &'f mut dyn FnMut(&mut PhpRenderer<'a>, TypeRef) -> Result<()>;
type EmitNoMatch<'f, 'a> = &'f mut dyn FnMut(&mut PhpRenderer<'a>) -> Result<()>;

impl<'a> PhpRenderer<'a> {
    /// `new PhpRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: PhpOptions,
    ) -> Self {
        PhpRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            getters_and_setters_for_property_name: IndexMap::new(),
            have_emitted_leading_comments: false,
        }
    }

    /// `getNameStyling(convention)`: a new namer each call.
    fn get_name_styling(&self, convention: NameStyling) -> Namer {
        let acronyms = acronym_style(self.options.acronym_style);
        match convention {
            NameStyling::Type => {
                fun_prefix_namer("types", move |n| php_name_style(true, false, n, acronyms))
            }
            NameStyling::Property => fun_prefix_namer("properties", move |n| {
                php_name_style(false, false, n, acronyms)
            }),
            NameStyling::EnumCase => fun_prefix_namer("enum-cases", move |n| {
                php_name_style(true, true, n, acronyms)
            }),
        }
    }

    /// `makeNamesForPropertyGetterAndSetter(c, className, p, jsonName,
    /// name)`: dependency names `get_<name>`, `set_<name>`, … at the
    /// property's order, each with a new namer.
    fn make_names_for_property_getter_and_setter(&mut self, name: Name) -> FunctionNames {
        let order = self.naming().order(name);
        let dependency = |r: &mut Self, prefix: &'static str| {
            let namer = r.get_name_styling(NameStyling::Property);
            r.naming_mut()
                .dependency_name(Some(&namer), order, move |lookup| {
                    format!("{prefix}_{}", lookup(name))
                })
        };
        let getter = dependency(self, "get");
        let setter = dependency(self, "set");
        let validate = dependency(self, "validate");
        let from = dependency(self, "from");
        let to = dependency(self, "to");
        let sample = dependency(self, "sample");
        FunctionNames {
            from,
            getter,
            sample,
            setter,
            to,
            validate,
        }
    }

    /// The accessor names of a property.
    fn function_names(&self, name: Name) -> Result<FunctionNames> {
        defined(
            self.getters_and_setters_for_property_name
                .get(&name)
                .copied(),
        )
    }

    /// `startFile(basename)`: the leading comments, once.
    fn start_file(&mut self) -> Result<()> {
        self.ensure_blank_line();
        if !self.have_emitted_leading_comments
            && let Some(leading_comments) = self.leading_comments()
        {
            self.emit_comments(leading_comments)?;
            self.ensure_blank_line();
            self.have_emitted_leading_comments = true;
        }
        Ok(())
    }

    /// `emitFileHeader(fileName, imports)`.
    fn emit_file_header(&mut self, file_name: Name) -> Result<()> {
        self.start_file()?;
        self.emit_line(sl!["// This is an autogenerated file:", file_name]);
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitDocBlockDescription(desc)`: opens a doc block, with the
    /// description if there is one.
    fn emit_doc_block_description(&mut self, desc: Option<&[String]>) -> Result<()> {
        let Some(desc) = desc else {
            self.emit_line("/**");
            return Ok(());
        };

        let lines: Vec<Source> = desc.iter().map(Source::from).collect();
        self.emit_comment_lines(
            &lines,
            &CommentOptions {
                line_start: Some(" * ".to_owned()),
                before_comment: Some("/**".to_owned()),
                ..CommentOptions::default()
            },
        )?;
        self.emit_line(" *");
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

    /// `sortedUnionMembers(u)`: the non-null members in runtime-dispatch
    /// order (the most specific check first; `any` last), and the null
    /// member.
    fn sorted_union_members(&self, u: TypeRef) -> Result<(Vec<TypeRef>, Option<TypeRef>)> {
        let graph = self.type_graph();
        // The TypeScript key is the index in the order (a number); two
        // digits compare the same way as strings.
        let mut keys: IndexMap<TypeRef, String> = IndexMap::new();
        for &member in graph.type_at(u)?.members()? {
            let kind = graph.kind(member)?;
            let index = UNION_MEMBER_ORDER
                .iter()
                .position(|&k| k == kind)
                .unwrap_or(UNION_MEMBER_ORDER.len());
            keys.insert(member, format!("{index:02}"));
        }
        let key = |t: TypeRef| keys.get(&t).cloned().unwrap_or_default();
        let (null_type, non_nulls) = remove_null_from_union(graph, u, NullRemovalSort::By(&key))?;
        Ok((non_nulls.into_iter().collect(), null_type))
    }

    /// `phpUnionType(u, jsonSide)`: the PHP union type declaration of a
    /// non-nullable union, e.g. `MixedClass|int|string`. With `json_side`
    /// the types are those of the decoded JSON value.
    fn php_union_type(&self, u: TypeRef, json_side: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let label = |kind: TypeKind| -> Option<&'static str> {
                match kind {
                    TypeKind::Any => Some("mixed"),
                    TypeKind::Array => Some("array"),
                    TypeKind::Bool => Some("bool"),
                    TypeKind::Class if json_side => Some("stdClass"),
                    TypeKind::DateTime if json_side => Some("string"),
                    TypeKind::DateTime => Some("DateTime"),
                    TypeKind::Double => Some("float"),
                    TypeKind::Enum if json_side => Some("string"),
                    TypeKind::Integer => Some("int"),
                    TypeKind::Map => Some("stdClass"),
                    TypeKind::String => Some("string"),
                    TypeKind::Uuid => Some("string"),
                    _ => None,
                }
            };
            let (members, null_type) = self.sorted_union_members(u)?;
            let mut parts: Vec<Source> = Vec::new();
            let mut seen: IndexSet<&'static str> = IndexSet::new();
            for member in members {
                let kind = graph.kind(member)?;
                let hint: Source = if let Some(label) = label(kind) {
                    // Members can render to the same PHP type, like a string
                    // and a UUID member — mention it only once.
                    if !seen.insert(label) {
                        continue;
                    }
                    label.into()
                } else if kind == TypeKind::Class || kind == TypeKind::Enum {
                    self.name_for_named_type(member)?.into()
                } else {
                    return js_error(format!(
                        "PHP cannot represent union member type \"{}\"",
                        kind.as_str()
                    ));
                };

                if !parts.is_empty() {
                    parts.push("|".into());
                }
                parts.push(hint);
            }

            if null_type.is_some() {
                parts.push("|null".into());
            }
            Ok(Source::Sequence(parts))
        })
    }

    /// `unionMemberTypeCheck(t, expr, jsonSide)`: the runtime check whether
    /// a value is this union member; `None` for `any`, which matches
    /// everything.
    fn union_member_type_check(
        &self,
        t: TypeRef,
        expr: &[Source],
        json_side: bool,
    ) -> Result<Option<Vec<Source>>> {
        let call = |function: &str| {
            let mut check = vec![Source::from(function)];
            check.extend_from_slice(expr);
            check.push(")".into());
            check
        };
        let instance_of = |class: Source| {
            let mut check = expr.to_vec();
            check.push(" instanceof ".into());
            check.push(class);
            check
        };
        let kind = self.type_graph().kind(t)?;
        Ok(Some(match kind {
            TypeKind::Null => call("is_null("),
            TypeKind::Bool => call("is_bool("),
            TypeKind::Integer => call("is_int("),
            TypeKind::Double => {
                // PHP integers are acceptable wherever floats are.
                let mut check = call("is_float(");
                check.pop();
                check.push(") || is_int(".into());
                check.extend_from_slice(expr);
                check.push(")".into());
                check
            }
            TypeKind::String | TypeKind::Uuid => call("is_string("),
            TypeKind::DateTime => {
                if json_side {
                    call("is_string(")
                } else {
                    let mut check = expr.to_vec();
                    check.push(" instanceof DateTime".into());
                    check
                }
            }
            TypeKind::Enum => {
                if !json_side {
                    return Ok(Some(instance_of(self.name_for_named_type(t)?.into())));
                }

                // On the JSON side an enum value is a string, but a plain
                // string member may share the union, so check membership in
                // the enum's values rather than just `is_string`.
                let mut check = call("is_string(");
                check.pop();
                check.push(") && in_array(".into());
                check.extend_from_slice(expr);
                check.push(", [".into());
                let mut first = true;
                for json_name in self.type_graph().type_at(t)?.cases()? {
                    if !first {
                        check.push(", ".into());
                    }
                    check.push("'".into());
                    check.push(string_escape(json_name).into());
                    check.push("'".into());
                    first = false;
                }
                check.push("], true)".into());
                check
            }
            TypeKind::Class => {
                if json_side {
                    call("is_object(")
                } else {
                    instance_of(self.name_for_named_type(t)?.into())
                }
            }
            TypeKind::Map => {
                if json_side {
                    call("is_object(")
                } else {
                    let mut check = expr.to_vec();
                    check.push(" instanceof stdClass".into());
                    check
                }
            }
            TypeKind::Array => call("is_array("),
            TypeKind::Any => return Ok(None),
            kind => {
                return js_error(format!(
                    "PHP cannot check for union member type \"{}\"",
                    kind.as_str()
                ));
            }
        }))
    }

    /// `emitUnionDispatch(u, expr, jsonSide, emitMember, emitNoMatch)`: an
    /// `if`/`elseif` chain over the union's members, dispatching on the
    /// runtime type of `expr`, with `emit_no_match` as the `else` branch.
    fn emit_union_dispatch(
        &mut self,
        u: TypeRef,
        expr: &[Source],
        json_side: bool,
        emit_member: EmitMember<'_, 'a>,
        emit_no_match: EmitNoMatch<'_, 'a>,
    ) -> Result<()> {
        let (members, null_type) = self.sorted_union_members(u)?;
        let all: Vec<TypeRef> = null_type.into_iter().chain(members).collect();
        let mut first = true;
        let mut have_catch_all = false;
        for member in all {
            let Some(check) = self.union_member_type_check(member, expr, json_side)? else {
                if first {
                    return emit_member(self, member);
                }

                self.emit_line("} else {");
                self.indent(|r| emit_member(r, member))?;
                have_catch_all = true;
                break;
            };

            let mut line = vec![Source::from(if first { "if (" } else { "} elseif (" })];
            line.extend(check);
            line.push(") {".into());
            self.emit_line_parts(line);
            first = false;
            self.indent(|r| emit_member(r, member))?;
        }

        if !have_catch_all {
            self.emit_line("} else {");
            self.indent(|r| emit_no_match(r))?;
        }

        self.emit_line("}");
        Ok(())
    }

    /// `phpType(reference, t, isOptional, prefix, suffix)`: the PHP type
    /// declaration of `t`.
    fn php_type(
        &self,
        t: TypeRef,
        is_optional: bool,
        prefix: &str,
        suffix: &str,
    ) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let optionalize = |s: Source| {
                sl![
                    if is_optional { prefix } else { "" },
                    s,
                    if is_optional { suffix } else { "" }
                ]
            };
            let graph = self.type_graph();
            Ok(match graph.kind(t)? {
                TypeKind::Any => maybe_annotated(is_optional, any_type_issue_annotation(), "mixed"),
                TypeKind::Null => {
                    maybe_annotated(is_optional, null_type_issue_annotation(), "mixed")
                }
                TypeKind::Bool => optionalize("bool".into()),
                TypeKind::Integer => optionalize("int".into()),
                TypeKind::Double => optionalize("float".into()),
                TypeKind::String => optionalize("string".into()),
                TypeKind::Array => optionalize("array".into()),
                TypeKind::Class | TypeKind::Enum => {
                    optionalize(self.name_for_named_type(t)?.into())
                }
                TypeKind::Map => optionalize("stdClass".into()),
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.php_type(nullable, true, prefix, suffix);
                    }
                    self.php_union_type(t, false)?
                }
                TypeKind::Time => return js_error("transformedStringType.kind === \"time\""),
                TypeKind::Date => return js_error("transformedStringType.kind === \"date\""),
                TypeKind::DateTime => optionalize("DateTime".into()),
                kind if kind.is_transformed_string_type_kind() => optionalize("string".into()),
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `phpType(false, t)`.
    fn php_type_plain(&self, t: TypeRef) -> Result<Source> {
        self.php_type(t, false, "?", "")
    }

    /// `phpType(false, t, false, "", "|null")`: the type for a doc comment.
    fn php_type_doc(&self, t: TypeRef) -> Result<Source> {
        self.php_type(t, false, "", "|null")
    }

    /// `phpConvertType(className, t)`: the type of the decoded JSON value.
    fn php_convert_type(&self, t: TypeRef) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            Ok(match graph.kind(t)? {
                TypeKind::Any | TypeKind::Null => "mixed".into(),
                TypeKind::Bool => "bool".into(),
                TypeKind::Integer => "int".into(),
                TypeKind::Double => "float".into(),
                TypeKind::String => "string".into(),
                TypeKind::Array => "array".into(),
                TypeKind::Class | TypeKind::Map => "stdClass".into(),
                TypeKind::Enum => "string".into(), // TODO number this.nameForNamedType(enumType),
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return Ok(sl!["?", self.php_convert_type(nullable)?]);
                    }
                    self.php_union_type(t, true)?
                }
                TypeKind::DateTime | TypeKind::Uuid => "string".into(),
                kind if kind.is_transformed_string_type_kind() => {
                    return js_error("transformedStringType.kind === \"unknown\"");
                }
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `emitLine(...lhs, ...rest)`.
    fn emit_parts(&mut self, groups: &[&[Source]]) {
        let parts: Vec<Source> = groups.iter().flat_map(|g| g.iter().cloned()).collect();
        self.emit_line_parts(parts);
    }

    /// `phpToObjConvert(className, t, lhs, args)`: converts a PHP value to
    /// its JSON value.
    fn php_to_obj_convert(
        &mut self,
        class_name: Name,
        t: TypeRef,
        lhs: &[Source],
        args: &[Source],
    ) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let comment = |s: &str| [Source::from(s)];
            match ty.kind() {
                TypeKind::Any => self.emit_parts(&[lhs, args, &comment("; /*any*/")]),
                TypeKind::Null => self.emit_parts(&[lhs, args, &comment("; /*null*/")]),
                TypeKind::Bool => self.emit_parts(&[lhs, args, &comment("; /*bool*/")]),
                TypeKind::Integer => self.emit_parts(&[lhs, args, &comment("; /*int*/")]),
                TypeKind::Double => self.emit_parts(&[lhs, args, &comment("; /*float*/")]),
                TypeKind::String => self.emit_parts(&[lhs, args, &comment("; /*string*/")]),
                TypeKind::Array => {
                    let items = ty.items()?;
                    self.emit_parts(&[lhs, &comment("array_map(function ($value) {")]);
                    self.indent(|r| {
                        r.php_to_obj_convert(
                            class_name,
                            items,
                            &["return ".into()],
                            &["$value".into()],
                        )
                    })?;
                    self.emit_parts(&[&comment("}, "), args, &comment(");")]);
                }
                TypeKind::Class => {
                    self.emit_parts(&[lhs, args, &["->to(); ".into(), "/*class*/".into()]]);
                }
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    self.emit_line("$out = new stdClass();");
                    let mut line = vec![Source::from("foreach (")];
                    line.extend_from_slice(args);
                    line.push(" as $k => $v)".into());
                    self.emit_block(line, |r| {
                        r.php_to_obj_convert(
                            class_name,
                            values,
                            &["$out->$k = ".into()],
                            &["$v".into()],
                        )
                    })?;
                    self.emit_line("return $out;");
                }
                TypeKind::Enum => {
                    let name: Source = self.name_for_named_type(t)?.into();
                    self.emit_parts(&[
                        lhs,
                        &[name, "::to(".into()],
                        args,
                        &["); ".into(), "/*enum*/".into()],
                    ]);
                }
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        self.emit_parts(&[&comment("if (!is_null("), args, &comment(")) {")]);
                        self.indent(|r| r.php_to_obj_convert(class_name, nullable, lhs, args))?;
                        self.emit_line("} else {");
                        self.indent(|r| {
                            r.emit_parts(&[lhs, &comment(" null;")]);
                            Ok(())
                        })?;
                        self.emit_line("}");
                        return Ok(());
                    }

                    self.emit_union_dispatch(
                        t,
                        args,
                        false,
                        &mut |r, member| r.php_to_obj_convert(class_name, member, lhs, args),
                        &mut |r| {
                            r.emit_line(sl![
                                "throw new Exception('Union value has no matching member in ",
                                class_name,
                                "');"
                            ]);
                            Ok(())
                        },
                    )?;
                }
                TypeKind::DateTime => {
                    self.emit_parts(&[lhs, args, &comment("->format(\"Y-m-d\\\\TH:i:s.uP\");")]);
                }
                TypeKind::Uuid => self.emit_parts(&[lhs, args, &comment("; /*uuid*/")]),
                kind if kind.is_transformed_string_type_kind() => {
                    return js_error("transformedStringType.kind === \"unknown\"");
                }
                kind => return match_type_unsupported(kind),
            }
            Ok(())
        })
    }

    /// `transformDateTime(className, attrName, scopeAttrName)`.
    fn transform_date_time(
        &mut self,
        class_name: Name,
        attr_name: Source,
        scope_attr_name: Source,
    ) -> Result<()> {
        self.emit_block(sl!["if (!is_a(", scope_attr_name, ", 'DateTime'))"], |r| {
            r.emit_line(sl![
                "throw new Exception('Attribute Error:",
                class_name,
                "::",
                attr_name,
                "');"
            ]);
            Ok(())
        })
    }

    /// `phpFromObjConvert(className, t, lhs, args)`: converts a JSON value
    /// to its PHP value.
    fn php_from_obj_convert(
        &mut self,
        class_name: Name,
        t: TypeRef,
        lhs: &[Source],
        args: &[Source],
    ) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let comment = |s: &str| [Source::from(s)];
            match ty.kind() {
                TypeKind::Any => self.emit_parts(&[lhs, args, &comment("; /*any*/")]),
                TypeKind::Null => self.emit_parts(&[lhs, args, &comment("; /*null*/")]),
                TypeKind::Bool => self.emit_parts(&[lhs, args, &comment("; /*bool*/")]),
                TypeKind::Integer => self.emit_parts(&[lhs, args, &comment("; /*int*/")]),
                TypeKind::Double => self.emit_parts(&[lhs, args, &comment("; /*float*/")]),
                TypeKind::String => self.emit_parts(&[lhs, args, &comment("; /*string*/")]),
                TypeKind::Array => {
                    let items = ty.items()?;
                    self.emit_parts(&[lhs, &comment(" array_map(function ($value) {")]);
                    self.indent(|r| {
                        r.php_from_obj_convert(
                            class_name,
                            items,
                            &["return ".into()],
                            &["$value".into()],
                        )
                    })?;
                    self.emit_parts(&[&comment("}, "), args, &comment(");")]);
                }
                TypeKind::Class => {
                    let name: Source = self.name_for_named_type(t)?.into();
                    self.emit_parts(&[
                        lhs,
                        &[name, "::from(".into()],
                        args,
                        &["); ".into(), "/*class*/".into()],
                    ]);
                }
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    self.emit_line("$out = new stdClass();");
                    let mut line = vec![Source::from("foreach (")];
                    line.extend_from_slice(args);
                    line.push(" as $k => $v)".into());
                    self.emit_block(line, |r| {
                        r.php_from_obj_convert(
                            class_name,
                            values,
                            &["$out->$k = ".into()],
                            &["$v".into()],
                        )
                    })?;
                    self.emit_line("return $out;");
                }
                TypeKind::Enum => {
                    let name: Source = self.name_for_named_type(t)?.into();
                    self.emit_parts(&[
                        lhs,
                        &[name, "::from(".into()],
                        args,
                        &["); ".into(), "/*enum*/".into()],
                    ]);
                }
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        self.emit_parts(&[&comment("if (!is_null("), args, &comment(")) {")]);
                        self.indent(|r| r.php_from_obj_convert(class_name, nullable, lhs, args))?;
                        self.emit_line("} else {");
                        self.indent(|r| {
                            r.emit_parts(&[lhs, &comment(" null;")]);
                            Ok(())
                        })?;
                        self.emit_line("}");
                        return Ok(());
                    }

                    self.emit_union_dispatch(
                        t,
                        args,
                        true,
                        &mut |r, member| r.php_from_obj_convert(class_name, member, lhs, args),
                        &mut |r| {
                            r.emit_line(sl![
                                "throw new Exception('Cannot deserialize union value in ",
                                class_name,
                                "');"
                            ]);
                            Ok(())
                        },
                    )?;
                }
                TypeKind::DateTime => {
                    self.emit_line(sl!["$tmp = ", "new DateTime(", args.to_vec(), ");"]);
                    self.transform_date_time(class_name, "".into(), sl!["$tmp"])?;
                    self.emit_line("return $tmp;");
                }
                TypeKind::Uuid => self.emit_parts(&[lhs, args, &comment("; /*uuid*/")]),
                kind if kind.is_transformed_string_type_kind() => {
                    return js_error("transformedStringType.kind === \"unknown\"");
                }
                kind => return match_type_unsupported(kind),
            }
            Ok(())
        })
    }

    /// `phpSampleConvert(className, t, lhs, args, idx, suffix)`: a sample
    /// value.
    fn php_sample_convert(
        &mut self,
        class_name: Name,
        t: TypeRef,
        lhs: &[Source],
        args: &[Source],
        idx: u32,
        suffix: &str,
    ) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let args_part = Source::Sequence(args.to_vec());
            let idx_string = idx.to_string();
            // `" /*", `${idx}`, ":", args, "*/"`
            let trailer = |open: &str| -> [Source; 4] {
                [
                    open.into(),
                    idx_string.clone().into(),
                    ":".into(),
                    sl![args_part.clone(), "*/"],
                ]
            };
            match ty.kind() {
                TypeKind::Any => self.emit_parts(&[
                    lhs,
                    &[
                        "'AnyType::".into(),
                        class_name.into(),
                        "::".into(),
                        args_part.clone(),
                        format!("::{idx}").into(),
                        "'".into(),
                        suffix.into(),
                    ],
                    &trailer("/*"),
                ]),
                TypeKind::Null => {
                    self.emit_parts(&[lhs, &["null".into(), suffix.into()], &trailer(" /*")]);
                }
                TypeKind::Bool => {
                    self.emit_parts(&[lhs, &["true".into(), suffix.into()], &trailer(" /*")]);
                }
                TypeKind::Integer => self.emit_parts(&[
                    lhs,
                    &[idx_string.clone().into(), suffix.into()],
                    &trailer(" /*"),
                ]),
                TypeKind::Double => {
                    let value = f64::from(idx);
                    self.emit_parts(&[
                        lhs,
                        &[js_number(value + value / 1000.0).into(), suffix.into()],
                        &trailer(" /*"),
                    ]);
                }
                TypeKind::String => self.emit_parts(&[
                    lhs,
                    &[
                        "'".into(),
                        class_name.into(),
                        "::".into(),
                        args_part.clone(),
                        format!("::{idx}").into(),
                        "'".into(),
                        suffix.into(),
                    ],
                    &trailer(" /*"),
                ]),
                TypeKind::Array => {
                    let items = ty.items()?;
                    self.emit_parts(&[lhs, &[" array(".into()]]);
                    self.indent(|r| r.php_sample_convert(class_name, items, &[], &[], idx, ""))?;
                    self.emit_parts(&[&[")".into(), suffix.into()], &trailer(" /* ")]);
                }
                TypeKind::Class => {
                    let name: Source = self.name_for_named_type(t)?.into();
                    self.emit_parts(&[
                        lhs,
                        &[name, "::sample()".into(), suffix.into()],
                        &trailer(" /*"),
                    ]);
                }
                TypeKind::Map => {
                    // An immediately-invoked closure, so the sample is an
                    // expression and can nest inside arrays and other maps.
                    let values = ty.map_values()?;
                    self.emit_parts(&[lhs, &[" (function () {".into()]]);
                    self.indent(|r| {
                        r.emit_line("$out = new stdClass();");
                        r.php_sample_convert(
                            class_name,
                            values,
                            &["$out->{'".into(), class_name.into(), "'} = ".into()],
                            args,
                            idx,
                            ";",
                        )?;
                        r.emit_line("return $out;");
                        Ok(())
                    })?;
                    self.emit_parts(&[&["})()".into(), suffix.into()], &trailer(" /* ")]);
                }
                TypeKind::Enum => {
                    let name: Source = self.name_for_named_type(t)?.into();
                    self.emit_parts(&[
                        lhs,
                        &[name, "::sample()".into(), suffix.into(), " /*enum*/".into()],
                    ]);
                }
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self
                            .php_sample_convert(class_name, nullable, lhs, args, idx, suffix);
                    }

                    // Any member's sample is a valid sample for the union.
                    let (members, _) = self.sorted_union_members(t)?;
                    let first = defined(members.first().copied())?;
                    return self.php_sample_convert(class_name, first, lhs, args, idx, suffix);
                }
                TypeKind::DateTime => {
                    let x = lodash_pad2(&(1 + idx % 31).to_string());
                    self.emit_parts(&[
                        lhs,
                        &[
                            "DateTime::createFromFormat(DateTimeInterface::ISO8601, '".into(),
                            format!("2020-12-{x}T12:{x}:{x}+00:00").into(),
                            "')".into(),
                            suffix.into(),
                        ],
                    ]);
                }
                TypeKind::Uuid => self.emit_parts(&[
                    lhs,
                    &[
                        "'9277b8fb-2a65-4663-a36c-8d417e2d284b'".into(),
                        suffix.into(),
                    ],
                    &trailer(" /*"),
                ]),
                kind if kind.is_transformed_string_type_kind() => {
                    return js_error("transformedStringType.kind === \"unknown\"");
                }
                kind => return match_type_unsupported(kind),
            }
            Ok(())
        })
    }

    /// `throw new Exception("Attribute Error:<class>::<attr>");`.
    fn emit_attribute_error(&mut self, class_name: Name, attr_name: &Source) {
        self.emit_line(sl![
            "throw new Exception(\"Attribute Error:",
            class_name,
            "::",
            attr_name.clone(),
            "\");"
        ]);
    }

    /// `phpValidate(className, t, attrName, scopeAttrName,
    /// skipPrimitiveTypeCheck)`: checks a value of type `t`.
    fn php_validate(
        &mut self,
        class_name: Name,
        t: TypeRef,
        attr_name: &Source,
        scope_attr_name: &str,
        skip_primitive_type_check: bool,
    ) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;

            let validate_range = |r: &mut Self| -> Result<()> {
                let (min, max) = match min_max_value_for_type(r.type_graph(), t)? {
                    Some(m) => (m.0, m.1),
                    None => (None, None),
                };
                if let Some(min) = min {
                    r.emit_line(format!(
                        "if ({scope_attr_name} < {}) throw new Exception(\"Attribute Error\");",
                        js_number(min)
                    ));
                }
                if let Some(max) = max {
                    r.emit_line(format!(
                        "if ({scope_attr_name} > {}) throw new Exception(\"Attribute Error\");",
                        js_number(max)
                    ));
                }
                Ok(())
            };
            let is = |r: &mut Self, isfn: &str| -> Result<()> {
                r.emit_block(sl!["if (!", isfn, "(", scope_attr_name, "))"], |r| {
                    r.emit_attribute_error(class_name, attr_name);
                    Ok(())
                })
            };

            match ty.kind() {
                TypeKind::Any => {
                    // Every value is a valid `any`; there is nothing to check.
                }
                TypeKind::Null => is(self, "is_null")?,
                TypeKind::Bool => {
                    if !skip_primitive_type_check {
                        is(self, "is_bool")?;
                    }
                }
                TypeKind::Integer => {
                    if !skip_primitive_type_check {
                        is(self, "is_integer")?;
                    }
                    validate_range(self)?;
                }
                TypeKind::Double => {
                    if !skip_primitive_type_check {
                        // PHP integers are acceptable wherever floats are, and
                        // json_decode gives an int for a whole JSON number.
                        self.emit_block(
                            sl![
                                "if (!is_float(",
                                scope_attr_name,
                                ") && !is_int(",
                                scope_attr_name,
                                "))"
                            ],
                            |r| {
                                r.emit_attribute_error(class_name, attr_name);
                                Ok(())
                            },
                        )?;
                    }
                    validate_range(self)?;
                }
                TypeKind::String => {
                    if !skip_primitive_type_check {
                        is(self, "is_string")?;
                    }
                    let invalid = |r: &mut Self| {
                        r.emit_line("throw new Exception(\"Attribute Error\");");
                        Ok(())
                    };
                    let (min, max) = match min_max_length_for_type(graph, t)? {
                        Some(m) => (m.0, m.1),
                        None => (None, None),
                    };
                    for (operator, bound) in [("<", min), (">", max)] {
                        if let Some(bound) = bound {
                            self.emit_block(
                                format!(
                                    "if (preg_match_all('/./us', {scope_attr_name}) {operator} {})",
                                    js_number(bound)
                                ),
                                invalid,
                            )?;
                        }
                    }
                    if let Some(pattern) = pattern_for_type(graph, t)? {
                        self.emit_block(
                            format!(
                                "if (preg_match('~{}~u', {scope_attr_name}) !== 1)",
                                string_escape(&pattern).replace('~', "\\~")
                            ),
                            invalid,
                        )?;
                    }
                }
                TypeKind::Array => {
                    is(self, "is_array")?;
                    let (min, max) = match min_max_items_for_type(graph, t)? {
                        Some(m) => (m.0, m.1),
                        None => (None, None),
                    };
                    if let Some(min) = min {
                        self.emit_line(format!(
                        "if (count({scope_attr_name}) < {}) throw new Exception(\"Attribute Error\");",
                        js_number(min)
                    ));
                    }
                    if let Some(max) = max {
                        self.emit_line(format!(
                        "if (count({scope_attr_name}) > {}) throw new Exception(\"Attribute Error\");",
                        js_number(max)
                    ));
                    }
                    self.emit_line(sl![
                        "array_walk(",
                        scope_attr_name,
                        ", function(",
                        scope_attr_name,
                        "_v) {"
                    ]);
                    let items = ty.items()?;
                    self.indent(|r| {
                        r.php_validate(
                            class_name,
                            items,
                            attr_name,
                            &format!("{scope_attr_name}_v"),
                            false,
                        )
                    })?;
                    self.emit_line("});");
                }
                TypeKind::Class => {
                    self.emit_line(sl![scope_attr_name, "->validate();"]);
                }
                TypeKind::Map => {
                    let values = ty.map_values()?;
                    self.emit_line(sl!["foreach (", scope_attr_name, " as $k => $v) {"]);
                    self.indent(|r| r.php_validate(class_name, values, attr_name, "$v", false))?;
                    self.emit_line("}");
                }
                TypeKind::Enum => {
                    let php_type = self.php_type_plain(t)?;
                    self.emit_line(sl![php_type, "::to(", scope_attr_name, ");"]);
                }
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.emit_block(sl!["if (!is_null(", scope_attr_name, "))"], |r| {
                            r.php_validate(
                                class_name,
                                nullable,
                                attr_name,
                                scope_attr_name,
                                skip_primitive_type_check,
                            )
                        });
                    }

                    self.emit_union_dispatch(
                        t,
                        &[scope_attr_name.into()],
                        false,
                        &mut |r, member| {
                            r.php_validate(class_name, member, attr_name, scope_attr_name, false)
                        },
                        &mut |r| {
                            r.emit_attribute_error(class_name, attr_name);
                            Ok(())
                        },
                    )?;
                }
                TypeKind::DateTime => {
                    self.transform_date_time(class_name, attr_name.clone(), sl![scope_attr_name])?;
                }
                TypeKind::Uuid => {
                    if !skip_primitive_type_check {
                        is(self, "is_string")?;
                    }
                    self.emit_block(
                    sl![
                        "if (!preg_match('/^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$/', ",
                        scope_attr_name,
                        "))"
                    ],
                    |r| {
                        r.emit_attribute_error(class_name, attr_name);
                        Ok(())
                    },
                )?;
                }
                kind if kind.is_transformed_string_type_kind() => {
                    return js_error(format!("transformedStringType.kind === {}", kind.as_str()));
                }
                kind => return match_type_unsupported(kind),
            }
            Ok(())
        })
    }

    /// `emitFromMethod(names, p, className, name, desc)`.
    fn emit_from_method(
        &mut self,
        names: FunctionNames,
        p: &ClassProperty,
        class_name: Name,
        desc: Option<&[String]>,
    ) -> Result<()> {
        self.emit_doc_block_description(desc)?;

        let convert_type = self.php_convert_type(p.type_ref)?;
        let php_type = self.php_type_plain(p.type_ref)?;
        self.emit_line(sl![" * @param ", convert_type.clone(), " $value"]);
        self.emit_line(" * @throws Exception");
        self.emit_line(sl![" * @return ", php_type.clone()]);
        self.emit_line(" */");
        self.emit_block(
            sl![
                "public static function ",
                names.from,
                "(",
                convert_type,
                " $value): ",
                php_type
            ],
            |r| {
                r.php_from_obj_convert(
                    class_name,
                    p.type_ref,
                    &["return ".into()],
                    &["$value".into()],
                )
            },
        )
    }

    /// `emitToMethod(names, p, className, name, desc)`.
    fn emit_to_method(
        &mut self,
        names: FunctionNames,
        p: &ClassProperty,
        class_name: Name,
        name: Name,
        desc: Option<&[String]>,
    ) -> Result<()> {
        self.emit_doc_block_description(desc)?;

        let convert_type = self.php_convert_type(p.type_ref)?;
        self.emit_line(" * @throws Exception");
        self.emit_line(sl![" * @return ", convert_type.clone()]);
        self.emit_line(" */");
        self.emit_block(
            sl!["public function ", names.to, "(): ", convert_type],
            |r| {
                r.emit_block(
                    sl![
                        "if (",
                        class_name,
                        "::",
                        names.validate,
                        "($this->",
                        name,
                        ")) "
                    ],
                    |r| {
                        r.php_to_obj_convert(
                            class_name,
                            p.type_ref,
                            &["return ".into()],
                            &["$this->".into(), name.into()],
                        )
                    },
                )?;
                r.emit_line(sl![
                    "throw new Exception('never get to this ",
                    class_name,
                    "::",
                    name,
                    "');"
                ]);
                Ok(())
            },
        )
    }

    /// `emitValidateMethod(names, p, className, name, desc)`.
    fn emit_validate_method(
        &mut self,
        names: FunctionNames,
        p: &ClassProperty,
        class_name: Name,
        name: Name,
        desc: Option<&[String]>,
    ) -> Result<()> {
        self.emit_doc_block_description(desc)?;

        let doc_type = self.php_type_doc(p.type_ref)?;
        self.emit_line(sl![" * @param ", doc_type]);
        self.emit_line(" * @return bool");
        self.emit_line(" * @throws Exception");
        self.emit_line(" */");
        let php_type = self.php_type_plain(p.type_ref)?;
        self.emit_block(
            sl![
                "public static function ",
                names.validate,
                "(",
                php_type,
                " $value): bool"
            ],
            |r| {
                // PHP has already enforced scalar parameter type hints
                // before entering this method. Recursive collection and
                // union validation still performs its own runtime checks.
                r.php_validate(class_name, p.type_ref, &name.into(), "$value", true)?;
                r.emit_line("return true;");
                Ok(())
            },
        )
    }

    /// `emitGetMethod(names, p, className, name, desc)`.
    fn emit_get_method(
        &mut self,
        names: FunctionNames,
        p: &ClassProperty,
        class_name: Name,
        name: Name,
        desc: Option<&[String]>,
    ) -> Result<()> {
        if !self.options.with_get {
            return Ok(());
        }
        self.emit_doc_block_description(desc)?;

        if !self.options.fast_get {
            self.emit_line(" * @throws Exception");
        }

        let rendered = self.php_type_plain(p.type_ref)?;
        self.emit_line(sl![" * @return ", rendered.clone()]);
        self.emit_line(" */");
        self.emit_block(
            sl!["public function ", names.getter, "(): ", rendered],
            |r| {
                if !r.options.fast_get {
                    r.emit_block(
                        sl![
                            "if (",
                            class_name,
                            "::",
                            names.validate,
                            "($this->",
                            name,
                            ")) "
                        ],
                        |r| {
                            r.emit_line(sl!["return $this->", name, ";"]);
                            Ok(())
                        },
                    )?;
                    r.emit_line(sl![
                        "throw new Exception('never get to ",
                        names.getter,
                        " ",
                        class_name,
                        "::",
                        name,
                        "');"
                    ]);
                } else {
                    r.emit_line(sl!["return $this->", name, ";"]);
                }
                Ok(())
            },
        )
    }

    /// `emitSetMethod(names, p, className, name, desc)`.
    fn emit_set_method(
        &mut self,
        names: FunctionNames,
        p: &ClassProperty,
        class_name: Name,
        name: Name,
        desc: Option<&[String]>,
    ) -> Result<()> {
        if !self.options.with_set {
            return Ok(());
        }
        self.emit_doc_block_description(desc)?;

        let doc_type = self.php_type_doc(p.type_ref)?;
        self.emit_line(sl![" * @param ", doc_type]);
        self.emit_line(" * @throws Exception");
        self.emit_line(" */");
        let php_type = self.php_type_plain(p.type_ref)?;
        self.emit_block(
            sl!["public function ", names.setter, "(", php_type, " $value)"],
            |r| {
                r.emit_block(
                    sl!["if (", class_name, "::", names.validate, "($value)) "],
                    |r| {
                        r.emit_line(sl!["$this->", name, " = $value;"]);
                        Ok(())
                    },
                )
            },
        )
    }

    /// `emitSampleMethod(names, p, className, name, desc, idx)`.
    #[allow(clippy::too_many_arguments)]
    fn emit_sample_method(
        &mut self,
        names: FunctionNames,
        p: &ClassProperty,
        class_name: Name,
        name: Name,
        desc: Option<&[String]>,
        idx: u32,
    ) -> Result<()> {
        if !self.options.with_get {
            return Ok(());
        }
        self.emit_doc_block_description(desc)?;

        let rendered = self.php_type_plain(p.type_ref)?;
        self.emit_line(sl![" * @return ", rendered.clone()]);
        self.emit_line(" */");
        self.emit_block(
            sl!["public static function ", names.sample, "(): ", rendered],
            |r| {
                r.php_sample_convert(
                    class_name,
                    p.type_ref,
                    &["return ".into()],
                    &[name.into()],
                    idx,
                    ";",
                )
            },
        )
    }

    /// `emitClassDefinition(c, className)`.
    fn emit_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.emit_file_header(class_name)?;

        self.emit_block(sl!["class ", class_name], |r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
                let php_type = r.php_type_plain(p.type_ref)?;
                let json_comment = json_name
                    .replace('\n', "\\n")
                    .replace('\r', "\\r")
                    .replace("?>", "? >");
                let required = if is_nullable(r.type_graph(), p.type_ref)? {
                    "Optional"
                } else {
                    "Required"
                };
                r.emit_line(sl![
                    "private ",
                    php_type,
                    " $",
                    name,
                    "; // json:",
                    json_comment,
                    " ",
                    required
                ]);
                Ok(())
            })?;

            r.ensure_blank_line();
            let mut comments: Vec<Source> = Vec::new();
            let mut args: Vec<Source> = Vec::new();
            let mut prefix = "";
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, _| {
                args.push(sl![prefix, r.php_type_plain(p.type_ref)?, " $", name]);
                prefix = ", ";
                comments.push(sl![
                    " * @param ",
                    r.php_type_doc(p.type_ref)?,
                    " $",
                    name,
                    "\n"
                ]);
                Ok(())
            })?;
            let mut constructor = vec![Source::from("/**\n")];
            constructor.extend(comments);
            constructor.push(" */\n".into());
            constructor.push("public function __construct(".into());
            constructor.extend(args);
            constructor.push(")".into());
            r.emit_block(constructor, |r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, _, _| {
                    r.emit_line(sl!["$this->", name, " = $", name, ";"]);
                    Ok(())
                })
            })?;

            let mut idx = 31;
            r.for_each_class_property(
                c,
                BlankLinePosition::LeadingAndInterposing,
                |r, name, json_name, p, _| {
                    let desc = r.description_for_class_property(c, json_name)?;
                    let desc = desc.as_deref();
                    let names = r.function_names(name)?;

                    r.ensure_blank_line();
                    r.emit_from_method(names, &p, class_name, desc)?;
                    r.ensure_blank_line();
                    r.emit_to_method(names, &p, class_name, name, desc)?;
                    r.ensure_blank_line();
                    r.emit_validate_method(names, &p, class_name, name, desc)?;
                    r.ensure_blank_line();
                    r.emit_get_method(names, &p, class_name, name, desc)?;
                    r.ensure_blank_line();
                    r.emit_set_method(names, &p, class_name, name, desc)?;
                    r.ensure_blank_line();
                    r.emit_sample_method(names, &p, class_name, name, desc, idx)?;
                    idx += 1;
                    Ok(())
                },
            )?;

            r.ensure_blank_line();
            r.emit_block(
                sl![
                    "/**\n",
                    " * @throws Exception\n",
                    " * @return bool\n",
                    " */\n",
                    "public function validate(): bool"
                ],
                |r| {
                    let mut lines: Vec<Vec<Source>> = Vec::new();
                    let mut p = "return ";
                    r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, _, _| {
                        let names = r.function_names(name)?;
                        lines.push(vec![
                            p.into(),
                            class_name.into(),
                            "::".into(),
                            names.validate.into(),
                            "($this->".into(),
                            name.into(),
                            ")".into(),
                        ]);
                        p = "|| ";
                        Ok(())
                    })?;
                    if lines.is_empty() {
                        // A class without properties has nothing to check.
                        r.emit_line("return true;");
                        return Ok(());
                    }

                    let count = lines.len();
                    for (jdx, mut line) in lines.into_iter().enumerate() {
                        line.push(if count == jdx + 1 { ";" } else { "" }.into());
                        r.emit_line_parts(line);
                    }
                    Ok(())
                },
            )?;

            r.ensure_blank_line();
            r.emit_block(
                sl![
                    "/**\n",
                    " * @return stdClass\n",
                    " * @throws Exception\n",
                    " */\n",
                    "public function to(): stdClass "
                ],
                |r| {
                    r.emit_line("$out = new stdClass();");
                    r.for_each_class_property(
                        c,
                        BlankLinePosition::None,
                        |r, name, json_name, _, _| {
                            let names = r.function_names(name)?;
                            r.emit_line(sl![
                                "$out->{'",
                                string_escape(json_name),
                                "'} = $this->",
                                names.to,
                                "();"
                            ]);
                            Ok(())
                        },
                    )?;
                    r.emit_line("return $out;");
                    Ok(())
                },
            )?;

            r.ensure_blank_line();
            r.emit_block(
                sl![
                    "/**\n",
                    " * @param stdClass $obj\n",
                    " * @return ",
                    class_name,
                    "\n",
                    " * @throws Exception\n",
                    " */\n",
                    "public static function from(stdClass $obj): ",
                    class_name
                ],
                |r| {
                    r.for_each_class_property(
                        c,
                        BlankLinePosition::None,
                        |r, _, json_name, p, _| {
                            if !p.is_optional {
                                r.emit_block(
                                    format!(
                                        "if (!property_exists($obj, '{}'))",
                                        string_escape(json_name)
                                    ),
                                    |r| {
                                        r.emit_line(
                                            "throw new Exception(\"Missing required property\");",
                                        );
                                        Ok(())
                                    },
                                )?;
                            }
                            Ok(())
                        },
                    )?;
                    if r.options.fast_get {
                        r.for_each_class_property(
                            c,
                            BlankLinePosition::None,
                            |r, name, _, _, _| {
                                let names = r.function_names(name)?;
                                r.emit_line(sl![
                                    class_name,
                                    "::",
                                    names.validate,
                                    "($this->",
                                    name,
                                    ", true);"
                                ]);
                                Ok(())
                            },
                        )?;
                    }

                    r.emit_line(sl!["return new ", class_name, "("]);
                    let mut comma = " ";
                    r.for_each_class_property(
                        c,
                        BlankLinePosition::None,
                        |r, name, json_name, _, _| {
                            let names = r.function_names(name)?;
                            r.emit_line(sl![
                                comma,
                                class_name,
                                "::",
                                names.from,
                                "($obj->{'",
                                string_escape(json_name),
                                "'})"
                            ]);
                            comma = ",";
                            Ok(())
                        },
                    )?;
                    r.emit_line(");");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();
            r.emit_block(
                sl![
                    "/**\n",
                    " * @return ",
                    class_name,
                    "\n",
                    " */\n",
                    "public static function sample(): ",
                    class_name
                ],
                |r| {
                    r.emit_line(sl!["return new ", class_name, "("]);
                    let mut comma = " ";
                    r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, _, _| {
                        let names = r.function_names(name)?;
                        r.emit_line(sl![comma, class_name, "::", names.sample, "()"]);
                        comma = ",";
                        Ok(())
                    })?;
                    r.emit_line(");");
                    Ok(())
                },
            )
        })?;
        // `this.finishFile()`: PHP's override does nothing.
        self.finish_file("")
    }

    /// `emitUnionDefinition(u, unionName)`: unions are never named (see
    /// `unionNeedsName`).
    fn emit_union_definition(&mut self, _u: TypeRef, _union_name: Name) -> Result<()> {
        js_error("emitUnionDefinition not implemented")
    }

    /// `emitEnumDefinition(e, enumName)`: a class with one static instance
    /// per case.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.emit_file_header(enum_name)?;
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        let enum_serde_type = "string";
        self.emit_block(sl!["class ", enum_name], |r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                r.emit_line(sl!["public static ", enum_name, " $", name, ";"]);
                Ok(())
            })?;

            r.emit_block("public static function init()", |r| {
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                    r.emit_line(sl![
                        enum_name, "::$", name, " = new ", enum_name, "('", json_name, "');"
                    ]);
                    Ok(())
                })
            })?;

            r.emit_line(sl!["private ", enum_serde_type, " $enum;"]);
            r.emit_block(
                sl!["public function __construct(", enum_serde_type, " $enum)"],
                |r| {
                    r.emit_line("$this->enum = $enum;");
                    Ok(())
                },
            )?;

            r.ensure_blank_line();

            r.emit_block(
                sl![
                    "/**\n",
                    " * @param ",
                    enum_name,
                    "\n",
                    " * @return ",
                    enum_serde_type,
                    "\n",
                    " * @throws Exception\n",
                    " */\n",
                    "public static function to(",
                    enum_name,
                    " $obj): ",
                    enum_serde_type
                ],
                |r| {
                    r.emit_line("switch ($obj->enum) {");
                    r.indent(|r| {
                        r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                            // Todo String or Number
                            r.emit_line(sl![
                                "case ",
                                enum_name,
                                "::$",
                                name,
                                "->enum: return '",
                                string_escape(json_name),
                                "';"
                            ]);
                            Ok(())
                        })
                    })?;
                    r.emit_line("}");
                    r.emit_line("throw new Exception('the give value is not an enum-value.');");
                    Ok(())
                },
            )?;
            r.ensure_blank_line();

            r.emit_block(
                sl![
                    "/**\n",
                    " * @param mixed\n",
                    " * @return ",
                    enum_name,
                    "\n",
                    " * @throws Exception\n",
                    " */\n",
                    "public static function from($obj): ",
                    enum_name
                ],
                |r| {
                    r.emit_line("switch ($obj) {");
                    r.indent(|r| {
                        r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                            // Todo String or Enum
                            r.emit_line(sl![
                                "case '",
                                string_escape(json_name),
                                "': return ",
                                enum_name,
                                "::$",
                                name,
                                ";"
                            ]);
                            Ok(())
                        })
                    })?;
                    r.emit_line("}");
                    r.emit_line(sl![
                        "throw new Exception(\"Cannot deserialize ",
                        enum_name,
                        "\");"
                    ]);
                    Ok(())
                },
            )?;
            r.ensure_blank_line();
            r.emit_block(
                sl![
                    "/**\n",
                    " * @return ",
                    enum_name,
                    "\n",
                    " */\n",
                    "public static function sample(): ",
                    enum_name
                ],
                |r| {
                    let mut lines: Vec<Source> = Vec::new();
                    r.for_each_enum_case(e, BlankLinePosition::None, |_, name, _, _| {
                        lines.push(sl![enum_name, "::$", name]);
                        Ok(())
                    })?;
                    let first = defined(lines.into_iter().next())?;
                    r.emit_line(sl!["return ", first, ";"]);
                    Ok(())
                },
            )
        })?;
        self.emit_line(sl![enum_name, "::init();"]);
        // `this.finishFile()`: PHP's override does nothing.
        self.finish_file("")
    }
}

impl<'a> ConvenienceRenderer<'a> for PhpRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(PHP_FORBIDDEN_CLASS_NAMES
            .iter()
            .map(|&n| n.to_owned())
            .collect())
    }

    /// `$this` is the only variable name PHP reserves; a property named
    /// "this" would produce an illegal `$this` constructor parameter.
    fn forbidden_for_object_properties(
        &mut self,
        _o: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: vec!["this".into(), "_".into()],
            include_global_forbidden: true,
        })
    }

    /// The type namer, with case-insensitive styled names.
    fn make_named_type_namer(&mut self) -> Namer {
        let namer = self.get_name_styling(NameStyling::Type);
        let style = namer.style_function();
        Namer::new(
            namer.name(),
            move |s| style(s),
            namer.prefixes().to_vec(),
            true,
        )
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.get_name_styling(NameStyling::Property)))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.get_name_styling(NameStyling::Property))
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.get_name_styling(NameStyling::EnumCase))
    }

    /// Unions are represented inline as PHP union type declarations; no
    /// named type is ever emitted for them.
    fn union_needs_name(&self, _u: TypeRef) -> Result<bool> {
        Ok(false)
    }

    fn named_type_to_name_for_top_level(&self, t: TypeRef) -> Result<Option<TypeRef>> {
        let graph = self.type_graph();
        let ty = graph.type_at(t)?;
        if ty.is_map() && graph.kind(ty.map_values()?)? == TypeKind::Class {
            return Ok(None);
        }
        directly_reachable_single_named_type(graph, t)
    }

    fn make_property_dependency_names(
        &mut self,
        _o: TypeRef,
        _class_name: Name,
        _p: &ClassProperty,
        _json_name: &str,
        name: Name,
    ) -> Result<Vec<Name>> {
        let names = self.make_names_for_property_getter_and_setter(name);
        self.getters_and_setters_for_property_name
            .insert(name, names);
        Ok(vec![
            names.getter,
            names.setter,
            names.validate,
            names.to,
            names.from,
            names.sample,
        ])
    }

    /// Does nothing: PHP writes one file, finished at the end of
    /// [`emit_source_structure`](ConvenienceRenderer::emit_source_structure).
    fn finish_file(&mut self, _filename: &str) -> Result<()> {
        Ok(())
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

    fn emit_source_structure(&mut self, given_filename: &str) -> Result<()> {
        self.emit_line("<?php");
        self.emit_line("declare(strict_types=1);");
        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            let graph = r.type_graph();
            let ty = graph.type_at(t)?;
            if !ty.is_map() || graph.kind(ty.map_values()?)? != TypeKind::Class {
                return Ok(());
            }
            let top_level = r.sourcelike_to_string(&name.into())?;
            let value_type =
                r.sourcelike_to_string(&r.name_for_named_type(ty.map_values()?)?.into())?;
            r.emit_multiline(&format!(
                "class {top_level} {{ private array $value;
public function __construct(array $value) {{ $this->value = $value; }}
public static function from(stdClass $obj): {top_level} {{ return new {top_level}(array_map(fn($value) => {value_type}::from($value), (array)$obj)); }}
public function to(): stdClass {{ return (object)array_map(fn($value) => $value->to(), $this->value); }} }}"
            ))
        })?;
        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            let top_level = r.sourcelike_to_string(&name.into())?;
            let graph = r.type_graph();
            let ty = graph.type_at(t)?;
            let is_primitive_array = ty.is_array() && graph.type_at(ty.items()?)?.is_primitive();
            if ty.is_primitive() {
                r.emit_multiline(&format!(
                    "class {top_level} {{ public static function from($obj) {{ return $obj; }}
public static function to($obj) {{ return $obj; }} }}"
                ))?;
            } else if is_primitive_array {
                r.emit_multiline(&format!(
                    "class {top_level} {{ private $value;
public function __construct($value) {{ $this->value = $value; }}
public static function from($obj): {top_level} {{ return new {top_level}($obj); }}
public function to() {{ return $this->value; }} }}"
                ))?;
            }
            Ok(())
        })?;
        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, n, _| r.emit_class_definition(c, n),
            |r, e, n, _| r.emit_enum_definition(e, n),
            |r, u, n, _| r.emit_union_definition(u, n),
        )?;
        if self.options.with_closing {
            self.emit_line("?>");
        }

        // `super.finishFile(defined(givenFilename))`.
        defaults::finish_file(self, given_filename)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn pads_like_lodash() {
        assert_eq!(lodash_pad2("5"), "50");
        assert_eq!(lodash_pad2("12"), "12");
        assert_eq!(lodash_pad2(""), "00");
    }
}
