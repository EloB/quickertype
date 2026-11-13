//! Port of `packages/quicktype-core/src/language/CJSON/CJSONRenderer.ts`.
//!
//! Renders C structures and the cJSON functions that parse, create, print
//! and delete them, as a single header (`--header-only`, the default), a
//! header/source pair, or one header (and source) per type with
//! `--source-style multi-source`.
//!
//! The TypeScript methods that emit functions (`emitUnionFunctions`,
//! `emitClassFunctions`, `emitTopLevelFunctions`) repeat the same few
//! statement shapes for lists, hashtables and their elements; here those
//! shapes are helpers ([`Container`], `emit_add_scalar`,
//! `emit_create_item`, `emit_delete_item`) that the methods call where the
//! TypeScript inlines them, with every branch in the TypeScript order.

use std::rc::Rc;

use crate::attributes::accessor_names::get_accessor_name;
use crate::attributes::constraints::{
    min_max_items_for_type, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::attributes::enum_values::enum_case_values;
use crate::convenience_renderer::prelude::*;
use crate::declaration_ir::DeclarationKind;
use crate::renderer_options::RendererOptions;
use crate::support::comments::CommentOptions;
use crate::support::recursion::guard;
use crate::support::strings::{NamingStyle, all_upper_word_style, make_name_style, string_escape};
use crate::support::support::{assert, defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, nullable_from_union, remove_null_from_union};

use super::constants::KEYWORDS;
use super::language::{
    ADD_TYPEDEF_ALIAS, ENUMERATOR_NAMING_STYLE, HASHTABLE_SIZE, HEADER_ONLY, MEMBER_NAMING_STYLE,
    PRINT_STYLE, TYPE_INTEGER_SIZE, TYPE_NAMING_STYLE, TYPE_SOURCE_STYLE,
};
use super::utils::{
    GLOBAL_NAMES, IncludeKind, IncludeMap, IncludeRecord, TypeCJSON, TypeRecord, legalize_name,
};

/// `cStringEscape(s)`: [`string_escape`], with each `\u00XX` escape of a C0
/// control, DEL or C1 control in the result turned into C octal escapes
/// (`\NNN`; a C1 control as its two UTF-8 bytes).
///
/// Like the TypeScript regular expression, this rewrites the escaped text,
/// so a backslash that `string_escape` doubled can start a match.
pub fn c_string_escape(s: &str) -> String {
    let escaped = string_escape(s);
    let mut out = String::with_capacity(escaped.len());
    let mut rest = escaped.as_str();
    while let Some(pos) = rest.find('\\') {
        out.push_str(&rest[..pos]);
        let after = &rest[pos + 1..];
        match control_escape(after) {
            Some(cp) => {
                let octal = |b: u32| format!("\\{b:03o}");
                if cp < 0x80 {
                    out.push_str(&octal(cp));
                } else {
                    out.push_str(&octal(0xc2));
                    out.push_str(&octal(cp));
                }
                rest = &after[5..];
            }
            None => {
                out.push('\\');
                rest = after;
            }
        }
    }
    out.push_str(rest);
    out
}

/// The code point of `u00(0[0-9a-f]|1[0-9a-f]|7f|8[0-9a-f]|9[0-9a-f])` at the
/// start of `s`, if it is there.
fn control_escape(s: &str) -> Option<u32> {
    let hex = s.strip_prefix("u00")?.get(..2)?;
    let &[high, low] = hex.as_bytes() else {
        return None;
    };
    let lower_hex = |b: u8| b.is_ascii_digit() || (b'a'..=b'f').contains(&b);
    let matches = match high {
        b'0' | b'1' | b'8' | b'9' => lower_hex(low),
        b'7' => low == b'f',
        _ => false,
    };
    if !matches {
        return None;
    }
    u32::from_str_radix(hex, 16).ok()
}

/// `level > 0 ? level.toString() : ""`: the suffix of a nesting level's
/// variables (`x`, `j`, `tmp`) at `level`.
fn lvl(level: usize) -> String {
    if level > 0 {
        level.to_string()
    } else {
        String::new()
    }
}

/// `withConst(s)`.
fn with_const(s: impl Into<Source>) -> Source {
    sl!["const ", s.into()]
}

/// The include guard of a header (`__TOP_LEVEL_H__`'s middle part):
/// `allUpperWordStyle(filename.replace(/[^a-zA-Z0-9]+/g, "_"))`.
fn include_guard(filename: &str) -> String {
    let mut replaced = String::with_capacity(filename.len());
    let mut in_run = false;
    for c in filename.chars() {
        if c.is_ascii_alphanumeric() {
            replaced.push(c);
            in_run = false;
        } else if !in_run {
            replaced.push('_');
            in_run = true;
        }
    }
    all_upper_word_style(&replaced)
}

/// The cJSON container a generated getter fills: a `list_t` (array) or a
/// `hashtable_t` (map) in the variable `x<child>`, iterating `e<child>`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Container {
    /// `list_add_tail(x<child>, ...)`.
    List,
    /// `hashtable_add(x<child>, e<child>->string, ...)`.
    Hashtable,
}

impl Container {
    /// The start of a call that adds an element, up to the element.
    fn add_prefix(self, child: &str) -> Source {
        match self {
            Container::List => sl!["list_add_tail(x", child, ", "],
            Container::Hashtable => sl!["hashtable_add(x", child, ", e", child, "->string, "],
        }
    }
}

/// A naming style function (TS `NameStyle`).
type NameStyle = Rc<dyn Fn(&str) -> String>;

/// The option values of the cJSON renderer (TS
/// `OptionValues<typeof cJSONOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct CJsonOptions {
    /// `typeSourceStyle`: `true` for `single-source`, `false` for
    /// `multi-source`.
    pub type_source_style: bool,
    /// `typeIntegerSize`: the C integer type.
    pub type_integer_size: String,
    /// `hashtableSize`: pasted verbatim into `hashtable_create` calls.
    pub hashtable_size: String,
    /// `addTypedefAlias`.
    pub add_typedef_alias: bool,
    /// `printStyle`: `true` for `print-unformatted`.
    pub print_style: bool,
    /// `typeNamingStyle`.
    pub type_naming_style: NamingStyle,
    /// `memberNamingStyle`.
    pub member_naming_style: NamingStyle,
    /// `enumeratorNamingStyle`.
    pub enumerator_naming_style: NamingStyle,
    /// `headerOnly`.
    pub header_only: bool,
}

/// The naming style of a `*-style` option value (TS `namingStyles`).
fn naming_style(value: &str) -> Result<NamingStyle> {
    Ok(match value {
        "pascal-case" => NamingStyle::Pascal,
        "underscore-case" => NamingStyle::Underscore,
        "camel-case" => NamingStyle::Camel,
        "upper-underscore-case" => NamingStyle::UpperUnderscore,
        "pascal-case-upper-acronyms" => NamingStyle::PascalUpperAcronyms,
        "camel-case-upper-acronyms" => NamingStyle::CamelUpperAcronyms,
        _ => return panic(format!("Unknown naming style {value}")),
    })
}

impl CJsonOptions {
    /// `getOptionValues(cJSONOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let type_source_style = TYPE_SOURCE_STYLE.get_enum_value(values)? == "single-source";
        let type_integer_size = TYPE_INTEGER_SIZE.get_enum_value(values)?.to_owned();
        let hashtable_size = HASHTABLE_SIZE.get_value(values).into_owned();
        let add_typedef_alias = ADD_TYPEDEF_ALIAS.get_enum_value(values)? == "add-typedef";
        let print_style = PRINT_STYLE.get_enum_value(values)? == "print-unformatted";
        let type_naming_style = naming_style(TYPE_NAMING_STYLE.get_enum_value(values)?)?;
        let member_naming_style = naming_style(MEMBER_NAMING_STYLE.get_enum_value(values)?)?;
        let enumerator_naming_style =
            naming_style(ENUMERATOR_NAMING_STYLE.get_enum_value(values)?)?;
        let header_only = HEADER_ONLY.get_value(values);
        Ok(CJsonOptions {
            type_source_style,
            type_integer_size,
            hashtable_size,
            add_typedef_alias,
            print_style,
            type_naming_style,
            member_naming_style,
            enumerator_naming_style,
            header_only,
        })
    }
}

/// `CJSONRenderer`.
pub struct CJsonRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: CJsonOptions,
    /// `currentHeaderFilename`.
    current_header_filename: Option<String>,
    /// `currentSourceFilename`.
    current_source_filename: Option<String>,
    /// `memberNameStyle`.
    member_name_style: NameStyle,
    /// `namedTypeNameStyle`.
    named_type_name_style: NameStyle,
    /// `forbiddenGlobalNames`: [`GLOBAL_NAMES`] in the type naming style.
    forbidden_global_names: Vec<String>,
    /// `includes`: the headers of the named types emitted so far in the
    /// multi-source mode.
    includes: Vec<String>,
}

impl std::fmt::Debug for CJsonRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CJsonRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

/// `makeNameStyle(style, legalizeName)`.
fn name_style(style: NamingStyle) -> NameStyle {
    Rc::new(make_name_style(style, legalize_name, None))
}

/// `funPrefixNamer(name, style)`: a new namer (a naming group of its own).
fn namer(name: &str, style: &NameStyle) -> Namer {
    let style = Rc::clone(style);
    fun_prefix_namer(name, move |s: &str| style(s))
}

impl<'a> CJsonRenderer<'a> {
    /// `new CJSONRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: CJsonOptions,
    ) -> Self {
        let named_type_name_style = name_style(options.type_naming_style);
        let member_name_style = name_style(options.member_naming_style);
        let forbidden_global_names = GLOBAL_NAMES
            .iter()
            .map(|name| named_type_name_style(name))
            .collect();
        CJsonRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            current_header_filename: None,
            current_source_filename: None,
            member_name_style,
            named_type_name_style,
            forbidden_global_names,
            includes: Vec::new(),
        }
    }

    /// `emitBlock(line, f, withName, withSemicolon)`: `line {`, the
    /// indented body and `}` (with the name and a semicolon if given).
    fn emit_block_with(
        &mut self,
        line: impl Into<Source>,
        f: impl FnOnce(&mut Self) -> Result<()>,
        with_name: &str,
        with_semicolon: bool,
    ) -> Result<()> {
        self.emit_line(sl![line.into(), " {"]);
        self.prevent_blank_line();
        self.indent(f)?;
        self.prevent_blank_line();
        if with_semicolon {
            if with_name.is_empty() {
                self.emit_line("};");
            } else {
                self.emit_line(sl!["} ", with_name, ";"]);
            }
        } else if with_name.is_empty() {
            self.emit_line("}");
        } else {
            self.emit_line(sl!["} ", with_name]);
        }
        Ok(())
    }

    /// `emitBlock(line, f)`.
    fn emit_block(
        &mut self,
        line: impl Into<Source>,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_block_with(line, f, "", false)
    }

    /// `emitTypedefAlias(fieldType, fieldName)`.
    fn emit_typedef_alias(&mut self, field_type: TypeRef, field_name: Name) -> Result<()> {
        if self.options.add_typedef_alias {
            let c_type = self
                .quicktype_type_to_cjson(field_type, false, false)?
                .c_type;
            self.emit_line(sl!["typedef ", c_type, " ", field_name, ";"]);
            self.ensure_blank_line();
        }
        Ok(())
    }

    /// The top-level filter of every `forEachTopLevel`: only top-levels
    /// that are not a named type get a structure of their own.
    fn is_unnamed_top_level(&self, t: TypeRef) -> Result<bool> {
        Ok(self.named_type_to_name_for_top_level(t)?.is_none())
    }

    /// `emitSingleSourceStructure(proposedFilename)`.
    fn emit_single_source_structure(&mut self, proposed_filename: &str) -> Result<()> {
        // Create header file.
        self.start_header_file(proposed_filename)?;

        // Create types.
        self.for_each_declaration(
            BlankLinePosition::LeadingAndInterposing,
            |r, decl, _| match decl.kind {
                DeclarationKind::Forward => {
                    let name = r.name_for_named_type(decl.type_ref)?;
                    r.emit_line(sl!["struct ", name, ";"]);
                    Ok(())
                }
                DeclarationKind::Define => {
                    let t = decl.type_ref;
                    let ty = r.type_graph().type_at(t)?;
                    if ty.is_class() {
                        r.emit_class_typedef(t)
                    } else if ty.is_enum() {
                        r.emit_enum_typedef(t)
                    } else if ty.is_union() {
                        r.emit_union_typedef(t)
                    } else {
                        panic("Cannot declare type")
                    }
                }
            },
        )?;

        // Create top level type.
        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| r.is_unnamed_top_level(t),
            |r, t, name, _| r.emit_top_level_typedef(t, name),
        )?;

        // Create enum prototypes.
        self.for_each_enum(BlankLinePosition::LeadingAndInterposing, |r, e, _, _| {
            r.emit_enum_prototypes(e)
        })?;

        // Create union prototypes.
        self.for_each_union(BlankLinePosition::LeadingAndInterposing, |r, u, _, _| {
            r.emit_union_prototypes(u)
        })?;

        // Create class prototypes.
        self.for_each_object(BlankLinePosition::LeadingAndInterposing, |r, c, _, _| {
            r.emit_class_prototypes(c)
        })?;

        // Create top level prototypes.
        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| r.is_unnamed_top_level(t),
            |r, t, name, _| r.emit_top_level_prototypes(t, name),
        )?;

        if !self.options.header_only {
            // Close header file.
            self.finish_header_file()?;

            // Create source file.
            self.start_source_file(proposed_filename)?;
        }

        // Create enum functions.
        self.for_each_enum(BlankLinePosition::LeadingAndInterposing, |r, e, _, _| {
            r.emit_enum_functions(e)
        })?;

        // Create union functions.
        self.for_each_union(BlankLinePosition::LeadingAndInterposing, |r, u, _, _| {
            r.emit_union_functions(u)
        })?;

        // Create class functions.
        self.for_each_object(BlankLinePosition::LeadingAndInterposing, |r, c, _, _| {
            r.emit_class_functions(c)
        })?;

        // Create top level functions.
        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| r.is_unnamed_top_level(t),
            |r, t, name, _| r.emit_top_level_functions(t, name),
        )?;

        self.finish_current_file()
    }

    /// `emitMultiSourceStructure()`.
    fn emit_multi_source_structure(&mut self) -> Result<()> {
        // Create each file.
        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, _, _| r.emit_class(c),
            |r, e, _, _| r.emit_enum(e),
            |r, u, _, _| r.emit_union(u),
        )?;

        // Create top level file.
        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| r.is_unnamed_top_level(t),
            |r, t, name, _| {
                // `emit_top_level` only reads the list (named types fill it).
                let includes = std::mem::take(&mut r.includes);
                let result = r.emit_top_level(t, name, &includes);
                r.includes = includes;
                result
            },
        )?;
        Ok(())
    }

    /// The header file of a named type in the multi-source mode:
    /// `<name>.h`, recorded in `includes`.
    fn named_type_header_filename(&mut self, t: TypeRef) -> Result<String> {
        let name = self.name_for_named_type(t)?;
        let header_filename = format!("{}.h", self.sourcelike_to_string(&name.into())?);
        self.includes.push(header_filename.clone());
        Ok(header_filename)
    }

    /// The part of `emitEnum`, `emitUnion` and `emitClass` after the
    /// prototypes: closes the header and opens the source file unless
    /// generating headers only.
    fn split_header_and_source(&mut self, header_filename: &str) -> Result<()> {
        if !self.options.header_only {
            // Close header file.
            self.finish_header_file()?;

            // Create source file.
            self.start_source_file(header_filename)?;
        }
        Ok(())
    }

    /// `emitEnum(enumType)`: the files of an enum.
    fn emit_enum(&mut self, e: TypeRef) -> Result<()> {
        let header_filename = self.named_type_header_filename(e)?;
        self.start_header_file(&header_filename)?;
        self.emit_includes(e, &header_filename)?;
        self.emit_enum_typedef(e)?;
        self.emit_enum_prototypes(e)?;
        self.split_header_and_source(&header_filename)?;
        self.emit_enum_functions(e)?;
        self.finish_current_file()
    }

    /// `emitEnumTypedef(enumType)`.
    fn emit_enum_typedef(&mut self, e: TypeRef) -> Result<()> {
        let enum_name = self.name_for_named_type(e)?;
        let enum_values = enum_case_values(self.type_graph(), e, self.target_language().name())?;

        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.emit_block_with(
            sl!["enum ", enum_name],
            |r| {
                let combined_name =
                    all_upper_word_style(&r.sourcelike_to_string(&enum_name.into())?);
                let mut is_first = true;
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                    // `enumCaseValues` always returns a map, so the
                    // TypeScript's `enumValues !== undefined` holds.
                    let (enum_value, _) = get_accessor_name(&enum_values, json_name);
                    match enum_value {
                        Some(value) => {
                            r.emit_line(sl![combined_name.as_str(), "_", name, " = ", value, ","]);
                        }
                        None => r.emit_line(sl![
                            combined_name.as_str(),
                            "_",
                            name,
                            if is_first { " = 1," } else { "," }
                        ]),
                    }
                    is_first = false;
                    Ok(())
                })
            },
            "",
            true,
        )?;
        self.ensure_blank_line();
        self.emit_typedef_alias(e, enum_name)
    }

    /// `emitEnumPrototypes(enumType)`.
    fn emit_enum_prototypes(&mut self, e: TypeRef) -> Result<()> {
        let enum_name = self.name_for_named_type(e)?;
        self.emit_line(sl![
            "enum ",
            enum_name,
            " cJSON_Get",
            enum_name,
            "Value(",
            with_const("cJSON"),
            " * j);"
        ]);
        self.emit_line(sl![
            "cJSON * cJSON_Create",
            enum_name,
            "(",
            with_const(sl!["enum ", enum_name]),
            " x);"
        ]);
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitEnumFunctions(enumType)`.
    fn emit_enum_functions(&mut self, e: TypeRef) -> Result<()> {
        let enum_name = self.name_for_named_type(e)?;

        // Create cJSON to enumName generator function.
        self.emit_block(
            sl![
                "enum ",
                enum_name,
                " cJSON_Get",
                enum_name,
                "Value(",
                with_const("cJSON"),
                " * j)"
            ],
            |r| {
                r.emit_line(sl!["enum ", enum_name, " x = 0;"]);
                r.emit_block(sl!["if (NULL != j)"], |r| {
                    let mut on_first = true;
                    let combined_name =
                        all_upper_word_style(&r.sourcelike_to_string(&enum_name.into())?);
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        let json_name = c_string_escape(json_name);
                        r.emit_line(sl![
                            if on_first { "" } else { "else " },
                            "if (!strcmp(cJSON_GetStringValue(j), \"",
                            json_name,
                            "\")) x = ",
                            combined_name.as_str(),
                            "_",
                            name,
                            ";"
                        ]);
                        on_first = false;
                        Ok(())
                    })
                })?;
                r.emit_line("return x;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        // Create enumName to cJSON generator function.
        self.emit_block(
            sl![
                "cJSON * cJSON_Create",
                enum_name,
                "(",
                with_const(sl!["enum ", enum_name]),
                " x)"
            ],
            |r| {
                r.emit_line("cJSON * j = NULL;");
                r.emit_block(sl!["switch (x)"], |r| {
                    let combined_name =
                        all_upper_word_style(&r.sourcelike_to_string(&enum_name.into())?);
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                        let json_name = c_string_escape(json_name);
                        r.emit_line(sl![
                            "case ",
                            combined_name.as_str(),
                            "_",
                            name,
                            ": j = cJSON_CreateString(\"",
                            json_name,
                            "\"); break;"
                        ]);
                        Ok(())
                    })
                })?;
                r.emit_line("return j;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitUnion(unionType)`: the files of a union.
    fn emit_union(&mut self, u: TypeRef) -> Result<()> {
        let header_filename = self.named_type_header_filename(u)?;
        self.start_header_file(&header_filename)?;
        self.emit_includes(u, &header_filename)?;
        self.emit_union_typedef(u)?;
        self.emit_union_prototypes(u)?;
        self.split_header_and_source(&header_filename)?;
        self.emit_union_functions(u)?;
        self.finish_current_file()
    }

    /// `emitUnionTypedef(unionType)`.
    fn emit_union_typedef(&mut self, u: TypeRef) -> Result<()> {
        let (_, non_nulls) = remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        let union_name = self.name_for_named_type(u)?;

        let description = self.description_for_type(u)?;
        self.emit_description(description)?;
        self.emit_block_with(
            sl!["struct ", union_name],
            |r| {
                r.emit_line("int type;");
                r.emit_block_with(
                    sl!["union"],
                    |r| {
                        for &t in &non_nulls {
                            let c = r.quicktype_type_to_cjson(t, false, false)?;
                            let member = r.name_for_union_member(u, t)?;
                            r.emit_line(sl![
                                c.c_type,
                                if c.optional_qualifier.is_empty() {
                                    ""
                                } else {
                                    " "
                                },
                                c.optional_qualifier,
                                " ",
                                member,
                                ";"
                            ]);
                        }
                        Ok(())
                    },
                    "value",
                    true,
                )
            },
            "",
            true,
        )?;
        self.ensure_blank_line();
        self.emit_typedef_alias(u, union_name)
    }

    /// `emitUnionPrototypes(unionType)`.
    fn emit_union_prototypes(&mut self, u: TypeRef) -> Result<()> {
        let union_name = self.name_for_named_type(u)?;
        let rendered = self.sourcelike_to_string(&union_name.into())?;
        let mut checks: Vec<Source> = Vec::new();
        for &t in self.type_graph().type_at(u)?.members()? {
            if !checks.is_empty() {
                checks.push(" || ".into());
            }
            let is_type = self.quicktype_type_to_cjson(t, false, false)?.is_type;
            checks.push(sl![is_type, "(j)"]);
        }

        self.emit_line(sl![
            "#define cJSON_Is",
            union_name,
            "(j) (",
            Source::Sequence(checks),
            ")"
        ]);
        self.emit_line(sl![
            "struct ",
            union_name,
            " * cJSON_Get",
            union_name,
            "Value(const cJSON * j);"
        ]);
        self.emit_line(sl![
            "cJSON * cJSON_Create",
            union_name,
            "(",
            with_const(sl!["struct ", union_name]),
            " * x);"
        ]);
        self.emit_line(sl![
            "void cJSON_Delete",
            union_name,
            "(struct ",
            union_name,
            " * x);"
        ]);
        self.emit_line(format!(
            "struct {rendered} * cJSON_Parse{rendered}(const char * s);"
        ));
        self.emit_line(format!(
            "char * cJSON_Print{rendered}(const struct {rendered} * x);"
        ));
        self.ensure_blank_line();
        Ok(())
    }

    /// The elements of a container that `emitUnionFunctions` and
    /// `emitClassFunctions` add the same way: `null` (and the never
    /// produced `cJSON_Invalid`) as a marker pointer, strings as copies,
    /// and scalars through a temporary (`tmp<level>`). The caller handles
    /// arrays, maps, objects and unions.
    fn emit_add_scalar(
        &mut self,
        container: Container,
        item: &TypeCJSON,
        level: usize,
        child: usize,
    ) -> Result<()> {
        let child = child.to_string();
        let prefix = container.add_prefix(&child);
        if item.is("cJSON_Invalid") || item.is("cJSON_NULL") {
            self.emit_line(sl![
                prefix,
                "(",
                &item.c_type,
                " *)0xDEADBEEF, sizeof(",
                &item.c_type,
                " *));"
            ]);
        } else if item.is("cJSON_String") {
            self.emit_line(sl![
                prefix,
                "strdup(",
                &item.get_value,
                "(e",
                child.as_str(),
                ")), sizeof(",
                &item.c_type,
                " *));"
            ]);
        } else {
            let tmp = lvl(level);
            self.emit_line(sl![
                &item.c_type,
                " * tmp",
                tmp.as_str(),
                " = cJSON_malloc(sizeof(",
                &item.c_type,
                "));"
            ]);
            self.emit_block(sl!["if (NULL != tmp", tmp.as_str(), ")"], |r| {
                r.emit_line(sl![
                    "* tmp",
                    tmp.as_str(),
                    " = ",
                    &item.get_value,
                    "(e",
                    child.as_str(),
                    ");"
                ]);
                r.emit_line(sl![
                    prefix,
                    "tmp",
                    tmp.as_str(),
                    ", sizeof(",
                    &item.c_type,
                    " *));"
                ]);
                Ok(())
            })?;
        }
        Ok(())
    }

    /// The `add` of `emitUnionFunctions`' getter: one element of a list or
    /// hashtable member (nested arrays and maps are not supported).
    fn emit_union_get_add(
        &mut self,
        container: Container,
        items: &TypeCJSON,
        level: usize,
        child: usize,
    ) -> Result<()> {
        if items.is("cJSON_Array") || items.is("cJSON_Map") {
            // Not supported.
            Ok(())
        } else if items.is("cJSON_Object") || items.is("cJSON_Union") {
            let child = child.to_string();
            self.emit_line(sl![
                container.add_prefix(&child),
                &items.get_value,
                "(e",
                child.as_str(),
                "), sizeof(",
                &items.c_type,
                " *));"
            ]);
            Ok(())
        } else {
            self.emit_add_scalar(container, items, level, child)
        }
    }

    /// The loop of `emitUnionFunctions`' getter over a list or hashtable
    /// member: `x1` filled from `j`.
    fn emit_union_get_container(
        &mut self,
        u: TypeRef,
        t: TypeRef,
        container: Container,
        c: &TypeCJSON,
        items: &TypeCJSON,
    ) -> Result<()> {
        let level = 0;
        let child = 1usize;
        let cs = child.to_string();
        let create = match container {
            Container::List => sl![" = list_create(false, NULL);"],
            Container::Hashtable => sl![
                " = hashtable_create(",
                self.options.hashtable_size.as_str(),
                ", false);"
            ],
        };
        self.emit_line(sl![&c.c_type, " * x", cs.as_str(), create]);
        self.emit_block(sl!["if (NULL != x", cs.as_str(), ")"], |r| {
            r.emit_line(sl!["cJSON * e", cs.as_str(), " = NULL;"]);
            r.emit_block(
                sl!["cJSON_ArrayForEach(e", cs.as_str(), ", j", lvl(level), ")"],
                |r| {
                    if items.is_nullable {
                        r.emit_block(sl!["if (!cJSON_IsNull(e", cs.as_str(), "))"], |r| {
                            r.emit_union_get_add(container, items, level, child)
                        })?;
                        r.emit_block(sl!["else"], |r| {
                            r.emit_line(sl![
                                container.add_prefix(&cs),
                                "(void *)0xDEADBEEF, sizeof(void *));"
                            ]);
                            Ok(())
                        })
                    } else {
                        r.emit_union_get_add(container, items, level, child)
                    }
                },
            )?;
            let member = r.name_for_union_member(u, t)?;
            r.emit_line(sl!["x->value.", member, " = x", cs.as_str(), ";"]);
            Ok(())
        })
    }

    /// The body of one member's branch in `emitUnionFunctions`' getter.
    fn emit_union_get_member(&mut self, u: TypeRef, t: TypeRef, c: &TypeCJSON) -> Result<()> {
        self.emit_line(sl!["x->type = ", c.cjson_type, ";"]);
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            self.emit_union_get_container(u, t, Container::List, c, items)
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            self.emit_union_get_container(u, t, Container::Hashtable, c, items)
        } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
            let member = self.name_for_union_member(u, t)?;
            self.emit_line(sl![
                "x->value.",
                member,
                " = (",
                &c.c_type,
                " *)0xDEADBEEF;"
            ]);
            Ok(())
        } else if c.is("cJSON_String") {
            let member = self.name_for_union_member(u, t)?;
            self.emit_line(sl![
                "x->value.",
                member,
                " = strdup(",
                &c.get_value,
                "(j));"
            ]);
            Ok(())
        } else {
            let member = self.name_for_union_member(u, t)?;
            self.emit_line(sl!["x->value.", member, " = ", &c.get_value, "(j);"]);
            if c.is("cJSON_Object") {
                let member = self.sourcelike_to_string(&member.into())?;
                self.emit_line(format!("if (NULL == x->value.{member}) x->type = 0;"));
            }
            Ok(())
        }
    }

    /// The element of a list (`cJSON_AddItemToArray(j...`) or of a map's
    /// object (`cJSON_AddItemToObject(j..., keys...`) in a `cJSON_Create`
    /// function: `null` as a new null, strings, objects and unions by
    /// pointer, everything else by value. `prefix` is the call up to the
    /// item, `var` the variable holding the element. The caller handles
    /// arrays, maps and `cJSON_Invalid` (nothing to do).
    fn emit_create_item(&mut self, prefix: Source, item: &TypeCJSON, var: &str) {
        if item.is("cJSON_Array") || item.is("cJSON_Map") || item.is("cJSON_Invalid") {
            // Not supported, or nothing to do.
        } else if item.is("cJSON_NULL") {
            self.emit_line(sl![prefix, &item.create_object, "());"]);
        } else if item.is("cJSON_String") || item.is("cJSON_Object") || item.is("cJSON_Union") {
            self.emit_line(sl![prefix, &item.create_object, "(", var, "));"]);
        } else {
            self.emit_line(sl![prefix, &item.create_object, "(*", var, "));"]);
        }
    }

    /// The `if ((void *)0xDEADBEEF != var)` / `else` pair around an element
    /// of a nullable item type in a `cJSON_Create` function, or just the
    /// element.
    fn emit_create_element(
        &mut self,
        items: &TypeCJSON,
        var: &str,
        null_line: Source,
        add: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        if items.is_nullable {
            self.emit_block(sl!["if ((void *)0xDEADBEEF != ", var, ")"], add)?;
            self.emit_block(sl!["else"], |r| {
                r.emit_line(null_line);
                Ok(())
            })
        } else {
            add(self)
        }
    }

    /// The deletion of an element of a list or hashtable (`var`), unless it
    /// is an array or map (the caller's business) or `null`.
    fn emit_delete_item(&mut self, items: &TypeCJSON, var: &str) -> Result<()> {
        if items.is("cJSON_Array")
            || items.is("cJSON_Map")
            || items.is("cJSON_Invalid")
            || items.is("cJSON_NULL")
        {
            // Not supported, or nothing to do.
            Ok(())
        } else if items.is_nullable {
            self.emit_block(sl!["if ((void *)0xDEADBEEF != ", var, ")"], |r| {
                r.emit_line(sl![&items.delete_type, "(", var, ");"]);
                Ok(())
            })
        } else {
            self.emit_line(sl![&items.delete_type, "(", var, ");"]);
            Ok(())
        }
    }

    /// `emitUnionFunctions(unionType)`.
    fn emit_union_functions(&mut self, u: TypeRef) -> Result<()> {
        let (has_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        let union_name = self.name_for_named_type(u)?;
        let rendered = self.sourcelike_to_string(&union_name.into())?;

        // Create cJSON to unionType generator function.
        self.emit_block(
            sl![
                "struct ",
                union_name,
                " * cJSON_Get",
                union_name,
                "Value(const cJSON * j)"
            ],
            |r| {
                let mut on_first = true;
                r.emit_line(sl![
                    "struct ",
                    union_name,
                    " * x = cJSON_malloc(sizeof(struct ",
                    union_name,
                    "));"
                ]);
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    r.emit_line(sl!["memset(x, 0, sizeof(struct ", union_name, "));"]);
                    if has_null.is_some() {
                        r.emit_block(sl!["if (cJSON_IsNull(j))"], |r| {
                            r.emit_line("x->type = cJSON_NULL;");
                            Ok(())
                        })?;
                        on_first = false;
                    }

                    for &t in &non_nulls {
                        let c = r.quicktype_type_to_cjson(t, false, false)?;
                        r.emit_block(
                            sl![
                                if on_first { "if (" } else { "else if (" },
                                &c.is_type,
                                "(j))"
                            ],
                            |r| r.emit_union_get_member(u, t, &c),
                        )?;
                        on_first = false;
                    }
                    r.emit_line("if (0 == x->type) { cJSON_free(x); return NULL; }");
                    Ok(())
                })?;
                r.emit_line("return x;");
                Ok(())
            },
        )?;
        self.emit_line(format!(
            "struct {rendered} * cJSON_Parse{rendered}(const char * s) {{ cJSON * j = cJSON_Parse(s); struct {rendered} * x = j ? cJSON_Get{rendered}Value(j) : NULL; cJSON_Delete(j); return x; }}"
        ));
        self.emit_line(format!(
            "char * cJSON_Print{rendered}(const struct {rendered} * x) {{ cJSON * j = cJSON_Create{rendered}(x); char * s = j ? cJSON_Print(j) : NULL; cJSON_Delete(j); return s; }}"
        ));
        self.ensure_blank_line();

        // Create unionName to cJSON generator function.
        self.emit_block(
            sl![
                "cJSON * cJSON_Create",
                union_name,
                "(",
                with_const(sl!["struct ", union_name]),
                " * x)"
            ],
            |r| {
                r.emit_line("cJSON * j = NULL;");
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    let mut on_first = true;
                    if has_null.is_some() {
                        r.emit_block(sl!["if (cJSON_NULL == x->type)"], |r| {
                            r.emit_line("j = cJSON_CreateNull();");
                            Ok(())
                        })?;
                        on_first = false;
                    }

                    for &t in &non_nulls {
                        let c = r.quicktype_type_to_cjson(t, false, false)?;
                        r.emit_block(
                            sl![
                                if on_first { "if (" } else { "else if (" },
                                c.cjson_type,
                                " == x->type)"
                            ],
                            |r| r.emit_union_create_member(u, t, &c),
                        )?;
                        on_first = false;
                    }
                    Ok(())
                })?;
                r.emit_line("return j;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        // Create unionName delete function.
        self.emit_block(
            sl![
                "void cJSON_Delete",
                union_name,
                "(struct ",
                union_name,
                " * x)"
            ],
            |r| {
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    let mut on_first = true;
                    for &t in &non_nulls {
                        let c = r.quicktype_type_to_cjson(t, false, false)?;
                        r.emit_block(
                            sl![
                                if on_first { "if (" } else { "else if (" },
                                c.cjson_type,
                                " == x->type)"
                            ],
                            |r| r.emit_union_delete_member(u, t, &c),
                        )?;
                        on_first = false;
                    }

                    r.emit_line("cJSON_free(x);");
                    Ok(())
                })
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// The body of one member's branch in `emitUnionFunctions`'
    /// `cJSON_Create` function.
    fn emit_union_create_member(&mut self, u: TypeRef, t: TypeRef, c: &TypeCJSON) -> Result<()> {
        let level = 0;
        let child = "1";
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            self.emit_line(sl!["cJSON * j", child, " = ", &c.create_object, "();"]);
            self.emit_block(sl!["if (NULL != j", child, ")"], |r| {
                let member = r.name_for_union_member(u, t)?;
                r.emit_line(sl![
                    &items.c_type,
                    " * x",
                    child,
                    " = list_get_head(x",
                    lvl(level),
                    "->value.",
                    member,
                    ");"
                ]);
                r.emit_block(sl!["while (NULL != x", child, ")"], |r| {
                    let var = format!("x{child}");
                    r.emit_create_element(
                        items,
                        &var,
                        sl!["cJSON_AddItemToArray(j", child, ", cJSON_CreateNull());"],
                        |r| {
                            r.emit_create_item(
                                sl!["cJSON_AddItemToArray(j", child, ", "],
                                items,
                                &var,
                            );
                            Ok(())
                        },
                    )?;

                    let member = r.name_for_union_member(u, t)?;
                    r.emit_line(sl![
                        "x",
                        child,
                        " = list_get_next(x",
                        lvl(level),
                        "->value.",
                        member,
                        ");"
                    ]);
                    Ok(())
                })?;
                r.emit_line(sl!["j = j", child, ";"]);
                Ok(())
            })
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            self.emit_line(sl!["cJSON * j", child, " = ", &c.create_object, "();"]);
            self.emit_block(sl!["if (NULL != j", child, ")"], |r| {
                r.emit_line(sl!["char **keys", child, " = NULL;"]);
                let member = r.name_for_union_member(u, t)?;
                r.emit_line(sl![
                    "size_t count",
                    child,
                    " = hashtable_get_keys(x",
                    lvl(level),
                    "->value.",
                    member,
                    ", &keys",
                    child,
                    ");"
                ]);
                r.emit_block(sl!["if (NULL != keys", child, ")"], |r| {
                    r.emit_block(
                        sl![
                            "for (size_t index",
                            child,
                            " = 0; index",
                            child,
                            " < count",
                            child,
                            "; index",
                            child,
                            "++)"
                        ],
                        |r| {
                            let member = r.name_for_union_member(u, t)?;
                            r.emit_line(sl![
                                &items.c_type,
                                " *x",
                                child,
                                " = hashtable_lookup(x",
                                lvl(level),
                                "->value.",
                                member,
                                ", keys",
                                child,
                                "[index",
                                child,
                                "]);"
                            ]);
                            let var = format!("x{child}");
                            let key = sl![
                                &c.add_to_object,
                                "(j",
                                child,
                                ", keys",
                                child,
                                "[index",
                                child,
                                "], "
                            ];
                            r.emit_create_element(
                                items,
                                &var,
                                sl![key.clone(), "cJSON_CreateNull());"],
                                |r| {
                                    r.emit_create_item(key, items, &var);
                                    Ok(())
                                },
                            )
                        },
                    )?;
                    r.emit_line(sl!["cJSON_free(keys", child, ");"]);
                    Ok(())
                })?;
                r.emit_line(sl!["j = j", child, ";"]);
                Ok(())
            })
        } else if c.is("cJSON_Invalid") {
            // Nothing to do.
            Ok(())
        } else if c.is("cJSON_NULL") {
            self.emit_line(sl!["j = ", &c.create_object, "();"]);
            Ok(())
        } else {
            let member = self.name_for_union_member(u, t)?;
            self.emit_line(sl!["j = ", &c.create_object, "(x->value.", member, ");"]);
            Ok(())
        }
    }

    /// The body of one member's branch in `emitUnionFunctions`'
    /// `cJSON_Delete` function.
    fn emit_union_delete_member(&mut self, u: TypeRef, t: TypeRef, c: &TypeCJSON) -> Result<()> {
        let level = 0;
        let child = "1";
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            let member = self.name_for_union_member(u, t)?;
            self.emit_block(
                sl!["if (NULL != x", lvl(level), "->value.", member, ")"],
                |r| {
                    let member = r.name_for_union_member(u, t)?;
                    r.emit_line(sl![
                        &items.c_type,
                        " * x",
                        child,
                        " = list_get_head(x",
                        lvl(level),
                        "->value.",
                        member,
                        ");"
                    ]);
                    r.emit_block(sl!["while (NULL != x", child, ")"], |r| {
                        r.emit_delete_item(items, &format!("x{child}"))?;
                        let member = r.name_for_union_member(u, t)?;
                        r.emit_line(sl![
                            "x",
                            child,
                            " = list_get_next(x",
                            lvl(level),
                            "->value.",
                            member,
                            ");"
                        ]);
                        Ok(())
                    })?;
                    let member = r.name_for_union_member(u, t)?;
                    r.emit_line(sl![
                        &c.delete_type,
                        "(x",
                        lvl(level),
                        "->value.",
                        member,
                        ");"
                    ]);
                    Ok(())
                },
            )
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            let member = self.name_for_union_member(u, t)?;
            self.emit_block(
                sl!["if (NULL != x", lvl(level), "->value.", member, ")"],
                |r| {
                    r.emit_line(sl!["char **keys", child, " = NULL;"]);
                    let member = r.name_for_union_member(u, t)?;
                    r.emit_line(sl![
                        "size_t count",
                        child,
                        " = hashtable_get_keys(x",
                        lvl(level),
                        "->value.",
                        member,
                        ", &keys",
                        child,
                        ");"
                    ]);
                    r.emit_block(sl!["if (NULL != keys", child, ")"], |r| {
                        r.emit_block(
                            sl![
                                "for (size_t index",
                                child,
                                " = 0; index",
                                child,
                                " < count",
                                child,
                                "; index",
                                child,
                                "++)"
                            ],
                            |r| {
                                let member = r.name_for_union_member(u, t)?;
                                r.emit_line(sl![
                                    &items.c_type,
                                    " *x",
                                    child,
                                    " = hashtable_lookup(x",
                                    lvl(level),
                                    "->value.",
                                    member,
                                    ", keys",
                                    child,
                                    "[index",
                                    child,
                                    "]);"
                                ]);
                                r.emit_block(sl!["if (NULL != x", child, ")"], |r| {
                                    r.emit_delete_item(items, &format!("x{child}"))
                                })
                            },
                        )?;
                        r.emit_line(sl!["cJSON_free(keys", child, ");"]);
                        Ok(())
                    })?;
                    let member = r.name_for_union_member(u, t)?;
                    r.emit_line(sl![
                        &c.delete_type,
                        "(x",
                        lvl(level),
                        "->value.",
                        member,
                        ");"
                    ]);
                    Ok(())
                },
            )
        } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
            // Nothing to do.
            Ok(())
        } else if c.is("cJSON_String") || c.is("cJSON_Object") || c.is("cJSON_Union") {
            let member = self.name_for_union_member(u, t)?;
            self.emit_line(sl![&c.delete_type, "(x->value.", member, ");"]);
            Ok(())
        } else {
            // Nothing to do.
            Ok(())
        }
    }

    /// `emitClass(classType)`: the files of a class.
    fn emit_class(&mut self, c: TypeRef) -> Result<()> {
        let header_filename = self.named_type_header_filename(c)?;
        self.start_header_file(&header_filename)?;
        self.emit_includes(c, &header_filename)?;
        self.emit_class_typedef(c)?;
        self.emit_class_prototypes(c)?;
        self.split_header_and_source(&header_filename)?;
        self.emit_class_functions(c)?;
        self.finish_current_file()
    }

    /// `emitClassTypedef(classType)`.
    fn emit_class_typedef(&mut self, c: TypeRef) -> Result<()> {
        let class_name = self.name_for_named_type(c)?;

        let description = self.description_for_type(c)?;
        self.emit_description(description)?;
        self.emit_block_with(
            sl!["struct ", class_name],
            |r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, p, _| {
                    let description = r.description_for_class_property(c, json_name)?;
                    r.emit_description(description)?;
                    let cjson = r.quicktype_type_to_cjson(p.type_ref, p.is_optional, false)?;
                    r.emit_line(sl![
                        cjson.c_type,
                        if cjson.optional_qualifier.is_empty() {
                            ""
                        } else {
                            " "
                        },
                        cjson.optional_qualifier,
                        " ",
                        name,
                        ";"
                    ]);
                    Ok(())
                })
            },
            "",
            true,
        )?;
        self.ensure_blank_line();
        self.emit_typedef_alias(c, class_name)
    }

    /// `emitClassPrototypes(classType)`, also `emitTopLevelPrototypes`.
    fn emit_struct_prototypes(&mut self, name: Name) {
        self.emit_line(sl![
            "struct ",
            name,
            " * cJSON_Parse",
            name,
            "(",
            with_const("char"),
            " * s);"
        ]);
        self.emit_line(sl![
            "struct ",
            name,
            " * cJSON_Get",
            name,
            "Value(",
            with_const("cJSON"),
            " * j);"
        ]);
        self.emit_line(sl![
            "cJSON * cJSON_Create",
            name,
            "(",
            with_const(sl!["struct ", name]),
            " * x);"
        ]);
        self.emit_line(sl![
            "char * cJSON_Print",
            name,
            "(",
            with_const(sl!["struct ", name]),
            " * x);"
        ]);
        self.emit_line(sl!["void cJSON_Delete", name, "(struct ", name, " * x);"]);
        self.ensure_blank_line();
    }

    /// `emitClassPrototypes(classType)`.
    fn emit_class_prototypes(&mut self, c: TypeRef) -> Result<()> {
        let class_name = self.name_for_named_type(c)?;
        self.emit_struct_prototypes(class_name);
        Ok(())
    }

    /// The `cJSON_Parse<name>` function of a class or top-level.
    fn emit_parse_function(&mut self, name: Name) -> Result<()> {
        self.emit_block(
            sl![
                "struct ",
                name,
                " * cJSON_Parse",
                name,
                "(",
                with_const("char"),
                " * s)"
            ],
            |r| {
                r.emit_line(sl!["struct ", name, " * x = NULL;"]);
                r.emit_block(sl!["if (NULL != s)"], |r| {
                    r.emit_line("cJSON * j = cJSON_Parse(s);");
                    r.emit_block(sl!["if (NULL != j)"], |r| {
                        r.emit_line(sl!["x = cJSON_Get", name, "Value(j);"]);
                        r.emit_line("cJSON_Delete(j);");
                        Ok(())
                    })
                })?;
                r.emit_line("return x;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// The `cJSON_Get<name>Value` function of a class or top-level, with
    /// `body` filling the allocated `x`.
    fn emit_get_value_function(
        &mut self,
        name: Name,
        body: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        self.emit_block(
            sl![
                "struct ",
                name,
                " * cJSON_Get",
                name,
                "Value(",
                with_const("cJSON"),
                " * j)"
            ],
            |r| {
                r.emit_line(sl!["struct ", name, " * x = NULL;"]);
                r.emit_block(sl!["if (NULL != j)"], |r| {
                    r.emit_block(
                        sl!["if (NULL != (x = cJSON_malloc(sizeof(struct ", name, "))))"],
                        |r| {
                            r.emit_line(sl!["memset(x, 0, sizeof(struct ", name, "));"]);
                            body(r)
                        },
                    )
                })?;
                r.emit_line("return x;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// The `cJSON_Print<name>` function of a class or top-level.
    fn emit_print_function(&mut self, name: Name, print: &'static str) -> Result<()> {
        self.emit_block(
            sl![
                "char * cJSON_Print",
                name,
                "(",
                with_const(sl!["struct ", name]),
                " * x)"
            ],
            |r| {
                r.emit_line("char * s = NULL;");
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    r.emit_line(sl!["cJSON * j = cJSON_Create", name, "(x);"]);
                    r.emit_block(sl!["if (NULL != j)"], |r| {
                        r.emit_line(print);
                        r.emit_line("cJSON_Delete(j);");
                        Ok(())
                    })
                })?;
                r.emit_line("return s;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// `emitClassFunctions(classType)`.
    fn emit_class_functions(&mut self, c: TypeRef) -> Result<()> {
        let class_name = self.name_for_named_type(c)?;

        // Create string to className generator function.
        self.emit_parse_function(class_name)?;

        // Create cJSON to className generator function.
        self.emit_get_value_function(class_name, |r| r.class_get_recur(class_name, c, 0))?;

        // Create className to cJSON generator function.
        self.emit_block(
            sl![
                "cJSON * cJSON_Create",
                class_name,
                "(",
                with_const(sl!["struct ", class_name]),
                " * x)"
            ],
            |r| {
                r.emit_line("cJSON * j = NULL;");
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    r.emit_block(sl!["if (NULL != (j = cJSON_CreateObject()))"], |r| {
                        r.class_create_recur(c, 0)
                    })
                })?;
                r.emit_line("return j;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        // Create className to string generator function.
        let print = if self.options.print_style {
            "s = cJSON_PrintUnformatted(j);"
        } else {
            "s = cJSON_Print(j);"
        };
        self.emit_print_function(class_name, print)?;

        // Create className delete function.
        self.emit_block(
            sl![
                "void cJSON_Delete",
                class_name,
                "(struct ",
                class_name,
                " * x)"
            ],
            |r| {
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    r.class_delete_recur(c, 0)?;
                    r.emit_line("cJSON_free(x);");
                    Ok(())
                })
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// The `recur(type, level)` of `emitClassFunctions`' getter: the
    /// statements reading `t` (an array or a class) at `level`.
    fn class_get_recur(&mut self, class_name: Name, t: TypeRef, level: usize) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let ty = self.type_graph().type_at(t)?;
            if ty.kind() == TypeKind::Array {
                let item_type = ty.items()?;
                let child = level + 1;
                let cs = child.to_string();
                let c = self.quicktype_type_to_cjson(item_type, false, false)?;
                self.emit_line(sl![
                    "list_t * x",
                    cs.as_str(),
                    " = list_create(false, NULL);"
                ]);
                self.emit_block(sl!["if (NULL != x", cs.as_str(), ")"], |r| {
                    r.emit_line(sl!["cJSON * e", cs.as_str(), " = NULL;"]);
                    r.emit_block(
                        sl![
                            "cJSON_ArrayForEach(e",
                            cs.as_str(),
                            ", e",
                            level.to_string(),
                            ")"
                        ],
                        |r| {
                            if c.is("cJSON_Array") {
                                let child2 = child + 1;
                                r.class_get_recur(class_name, item_type, child)?;
                                let items = defined(c.items.as_deref())?;
                                r.emit_line(sl![
                                    "list_add_tail(x",
                                    cs.as_str(),
                                    ", x",
                                    child2.to_string(),
                                    ", sizeof(",
                                    &items.c_type,
                                    " *));"
                                ]);
                                Ok(())
                            } else if c.is("cJSON_Map") {
                                // Not supported.
                                Ok(())
                            } else if c.is("cJSON_Object") || c.is("cJSON_Union") {
                                r.emit_line(sl![
                                    "list_add_tail(x",
                                    cs.as_str(),
                                    ", ",
                                    &c.get_value,
                                    "(e",
                                    cs.as_str(),
                                    "), sizeof(",
                                    &c.c_type,
                                    " *));"
                                ]);
                                Ok(())
                            } else {
                                r.emit_add_scalar(Container::List, &c, level, child)
                            }
                        },
                    )
                })
            } else if ty.kind() == TypeKind::Class {
                self.for_each_class_property(
                    t,
                    BlankLinePosition::None,
                    |r, name, json_name, p, _| {
                        r.class_get_property(class_name, level, name, json_name, p)
                    },
                )
            } else {
                Ok(())
            }
        })
    }

    /// One property in `emitClassFunctions`' getter.
    fn class_get_property(
        &mut self,
        class_name: Name,
        level: usize,
        name: Name,
        json_name: &str,
        p: ClassProperty,
    ) -> Result<()> {
        let json_name = c_string_escape(json_name);
        let c = self.quicktype_type_to_cjson(p.type_ref, p.is_optional, false)?;
        let l = lvl(level);
        let object = format!("j{l}");
        let value = format!("cJSON_GetObjectItemCaseSensitive({object}, \"{json_name}\")");
        let graph = self.type_graph();
        let min_max = min_max_value_for_type(graph, p.type_ref)?;
        let min_max_items = min_max_items_for_type(graph, p.type_ref)?;
        let pattern = pattern_for_type(graph, p.type_ref)?;
        let min_max_length = min_max_length_for_type(graph, p.type_ref)?;
        let (minimum, maximum) = min_max.map_or((None, None), |m| (m.0, m.1));
        let (min_items, max_items) = min_max_items.map_or((None, None), |m| (m.0, m.1));
        let (min_length, max_length) = min_max_length.map_or((None, None), |m| (m.0, m.1));
        let class = self.sourcelike_to_string(&class_name.into())?;
        let fail = format!("{{ cJSON_Delete{class}(x); return NULL; }}");
        let num = quicktype_js_compat::number::to_string;

        if !p.is_optional {
            self.emit_line(format!(
                "if (!cJSON_HasObjectItem({object}, \"{json_name}\")) {fail}"
            ));
        }
        let condition = if c.is_nullable {
            sl![
                "if ((cJSON_HasObjectItem(j",
                l.as_str(),
                ", \"",
                json_name.as_str(),
                "\")) && (!cJSON_IsNull(cJSON_GetObjectItemCaseSensitive(j",
                l.as_str(),
                ", \"",
                json_name.as_str(),
                "\"))))"
            ]
        } else {
            sl![
                "if (cJSON_HasObjectItem(j",
                l.as_str(),
                ", \"",
                json_name.as_str(),
                "\"))"
            ]
        };
        self.emit_block(condition, |r| {
            if c.has_is_type() {
                let is_type = r.sourcelike_to_string(&c.is_type)?;
                r.emit_line(format!("if (!{is_type}({value})) {fail}"));
            }
            if let Some(minimum) = minimum {
                r.emit_line(format!(
                    "if ({value}->valuedouble < {}) {fail}",
                    num(minimum)
                ));
            }
            if let Some(maximum) = maximum {
                r.emit_line(format!(
                    "if ({value}->valuedouble > {}) {fail}",
                    num(maximum)
                ));
            }
            if let Some(min_items) = min_items {
                r.emit_line(format!(
                    "if (cJSON_GetArraySize({value}) < {}) {fail}",
                    num(min_items)
                ));
            }
            if let Some(max_items) = max_items {
                r.emit_line(format!(
                    "if (cJSON_GetArraySize({value}) > {}) {fail}",
                    num(max_items)
                ));
            }
            if let Some(pattern) = &pattern {
                r.emit_line(format!(
                    "regex_t regex; regcomp(&regex, \"{}\", REG_EXTENDED); if (regexec(&regex, {value}->valuestring, 0, NULL, 0)) {{ regfree(&regex); cJSON_Delete{class}(x); return NULL; }} regfree(&regex);",
                    string_escape(pattern)
                ));
            }
            if let Some(min_length) = min_length {
                r.emit_line(format!(
                    "if (quicktype_strlen_codepoints({value}->valuestring) < {}) {fail}",
                    num(min_length)
                ));
            }
            if let Some(max_length) = max_length {
                r.emit_line(format!(
                    "if (quicktype_strlen_codepoints({value}->valuestring) > {}) {fail}",
                    num(max_length)
                ));
            }
            if c.is("cJSON_Enum") {
                // Enum getters return zero for unknown strings, so every
                // direct enum property needs this guard.
                let get_value = r.sourcelike_to_string(&c.get_value)?;
                r.emit_line(format!(
                    "if (!cJSON_IsString({value}) || 0 == {get_value}({value})) {fail}"
                ));
            }
            r.class_get_property_value(class_name, level, name, &json_name, p, &c)
        })?;
        if !p.is_optional && !c.is_nullable {
            if c.is("cJSON_Array") {
                self.emit_block(sl!["else"], |r| {
                    r.emit_line(sl![
                        "x",
                        l.as_str(),
                        "->",
                        name,
                        " = list_create(false, NULL);"
                    ]);
                    Ok(())
                })?;
            } else if c.is("cJSON_Map") {
                self.emit_block(sl!["else"], |r| {
                    let size = r.options.hashtable_size.clone();
                    r.emit_line(sl![
                        "x",
                        l.as_str(),
                        "->",
                        name,
                        " = hashtable_create(",
                        size,
                        ", false);"
                    ]);
                    Ok(())
                })?;
            } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
                self.emit_block(sl!["else"], |r| {
                    r.emit_line(sl![
                        "x",
                        l.as_str(),
                        "->",
                        name,
                        " = (",
                        &c.c_type,
                        " *)0xDEADBEEF;"
                    ]);
                    Ok(())
                })?;
            } else if c.is("cJSON_String") {
                self.emit_block(sl!["else"], |r| {
                    r.emit_block(
                        sl![
                            "if (NULL != (x",
                            l.as_str(),
                            "->",
                            name,
                            " = cJSON_malloc(sizeof(",
                            &c.c_type,
                            "))))"
                        ],
                        |r| {
                            r.emit_line(sl!["x", l.as_str(), "->", name, "[0] = '\\0';"]);
                            Ok(())
                        },
                    )
                })?;
            } else {
                // Nothing to do.
            }
        }
        Ok(())
    }

    /// The assignment of a property's value in `emitClassFunctions`'
    /// getter, inside the check that the property is present.
    fn class_get_property_value(
        &mut self,
        class_name: Name,
        level: usize,
        name: Name,
        json_name: &str,
        p: ClassProperty,
        c: &TypeCJSON,
    ) -> Result<()> {
        let l = lvl(level);
        let item = || {
            sl![
                "(cJSON_GetObjectItemCaseSensitive(j",
                l.as_str(),
                ", \"",
                json_name,
                "\")"
            ]
        };
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            let child = level + 1;
            let cs = child.to_string();
            self.emit_line(sl![
                &c.c_type,
                " * x",
                cs.as_str(),
                " = list_create(false, NULL);"
            ]);
            self.emit_block(sl!["if (NULL != x", cs.as_str(), ")"], |r| {
                r.emit_line(sl!["cJSON * e", cs.as_str(), " = NULL;"]);
                r.emit_line(sl![
                    "cJSON * j",
                    cs.as_str(),
                    " = cJSON_GetObjectItemCaseSensitive(j",
                    l.as_str(),
                    ", \"",
                    json_name,
                    "\");"
                ]);
                r.emit_block(
                    sl!["cJSON_ArrayForEach(e", cs.as_str(), ", j", cs.as_str(), ")"],
                    |r| {
                        if items.is_nullable {
                            r.emit_block(sl!["if (!cJSON_IsNull(e", cs.as_str(), "))"], |r| {
                                r.class_get_list_add(class_name, level, name, p.type_ref, items)
                            })?;
                            r.emit_block(sl!["else"], |r| {
                                r.emit_line(sl![
                                    "list_add_tail(x",
                                    cs.as_str(),
                                    ", (void *)0xDEADBEEF, sizeof(void *));"
                                ]);
                                Ok(())
                            })
                        } else {
                            r.class_get_list_add(class_name, level, name, p.type_ref, items)
                        }
                    },
                )?;
                r.emit_line(sl!["x", l.as_str(), "->", name, " = x", cs.as_str(), ";"]);
                Ok(())
            })
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            let child = level + 1;
            let cs = child.to_string();
            let element = format!("e{child}");
            let nullable = if items.is_nullable {
                format!("!cJSON_IsNull({element}) && ")
            } else {
                String::new()
            };
            let size = self.options.hashtable_size.clone();
            self.emit_line(sl![
                &c.c_type,
                " * x",
                cs.as_str(),
                " = hashtable_create(",
                size,
                ", false);"
            ]);
            self.emit_block(sl!["if (NULL != x", cs.as_str(), ")"], |r| {
                r.emit_line(sl!["cJSON * e", cs.as_str(), " = NULL;"]);
                r.emit_line(sl![
                    "cJSON * j",
                    cs.as_str(),
                    " = cJSON_GetObjectItemCaseSensitive(j",
                    l.as_str(),
                    ", \"",
                    json_name,
                    "\");"
                ]);
                r.emit_block(
                    sl!["cJSON_ArrayForEach(e", cs.as_str(), ", j", cs.as_str(), ")"],
                    |r| {
                        if items.has_is_type() {
                            let is_type = r.sourcelike_to_string(&items.is_type)?;
                            let class = r.sourcelike_to_string(&class_name.into())?;
                            r.emit_line(format!(
                                "if ({nullable}!{is_type}({element})) {{ cJSON_Delete{class}(x); return NULL; }}"
                            ));
                        }
                        if items.is_nullable {
                            r.emit_block(sl!["if (!cJSON_IsNull(e", cs.as_str(), "))"], |r| {
                                r.class_get_hashtable_add(class_name, level, name, p.type_ref, items)
                            })?;
                            r.emit_block(sl!["else"], |r| {
                                r.emit_line(sl![
                                    "hashtable_add(x",
                                    cs.as_str(),
                                    ", e",
                                    cs.as_str(),
                                    "->string, (void *)0xDEADBEEF, sizeof(void *));"
                                ]);
                                Ok(())
                            })
                        } else {
                            r.class_get_hashtable_add(class_name, level, name, p.type_ref, items)
                        }
                    },
                )?;
                r.emit_line(sl!["x", l.as_str(), "->", name, " = x", cs.as_str(), ";"]);
                Ok(())
            })
        } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
            self.emit_line(sl![
                "x",
                l.as_str(),
                "->",
                name,
                " = (",
                &c.c_type,
                " *)0xDEADBEEF;"
            ]);
            Ok(())
        } else if c.is("cJSON_String") {
            self.emit_line(sl![
                "x",
                l.as_str(),
                "->",
                name,
                " = strdup(",
                &c.get_value,
                item(),
                "));"
            ]);
            Ok(())
        } else if c.is("cJSON_Object") || c.is("cJSON_Union") {
            self.emit_line(sl![
                "x",
                l.as_str(),
                "->",
                name,
                " = ",
                &c.get_value,
                item(),
                ");"
            ]);
            let property = self.sourcelike_to_string(&name.into())?;
            let class = self.sourcelike_to_string(&class_name.into())?;
            self.emit_line(format!(
                "if (NULL == x{l}->{property}) {{ cJSON_Delete{class}(x); return NULL; }}"
            ));
            Ok(())
        } else if p.is_optional || c.is_nullable {
            self.emit_block(
                sl![
                    "if (NULL != (x",
                    l.as_str(),
                    "->",
                    name,
                    " = cJSON_malloc(sizeof(",
                    &c.c_type,
                    "))))"
                ],
                |r| {
                    r.emit_line(sl![
                        "*x",
                        l.as_str(),
                        "->",
                        name,
                        " = ",
                        &c.get_value,
                        item(),
                        ");"
                    ]);
                    Ok(())
                },
            )
        } else {
            self.emit_line(sl![
                "x",
                l.as_str(),
                "->",
                name,
                " = ",
                &c.get_value,
                item(),
                ");"
            ]);
            Ok(())
        }
    }

    /// The `add` of an array property in `emitClassFunctions`' getter: one
    /// element of the list `x<level + 1>`.
    fn class_get_list_add(
        &mut self,
        class_name: Name,
        level: usize,
        name: Name,
        property_type: TypeRef,
        items: &TypeCJSON,
    ) -> Result<()> {
        let child = level + 1;
        let cs = child.to_string();
        if items.is("cJSON_Array") {
            let ty = self.type_graph().type_at(property_type)?;
            if ty.kind() != TypeKind::Array {
                return panic("Invalid type");
            }
            let child2 = child + 1;
            self.class_get_recur(class_name, ty.items()?, child)?;
            self.emit_line(sl![
                "list_add_tail(x",
                cs.as_str(),
                ", x",
                child2.to_string(),
                ", sizeof(",
                &items.c_type,
                " *));"
            ]);
            Ok(())
        } else if items.is("cJSON_Map") {
            // Not supported.
            Ok(())
        } else if items.is("cJSON_Object") || items.is("cJSON_Union") {
            let item = format!("item{child}");
            let l = lvl(level);
            let property = self.sourcelike_to_string(&name.into())?;
            let class = self.sourcelike_to_string(&class_name.into())?;
            if items.is("cJSON_Object") {
                self.emit_line(format!(
                    "if (!cJSON_IsObject(e{child})) {{ x{l}->{property} = x{child}; cJSON_Delete{class}(x); return NULL; }}"
                ));
            }
            self.emit_line(sl![
                &items.c_type,
                " * ",
                item.as_str(),
                " = ",
                &items.get_value,
                "(e",
                cs.as_str(),
                ");"
            ]);
            self.emit_line(format!(
                "if (NULL == {item}) {{ x{l}->{property} = x{child}; cJSON_Delete{class}(x); return NULL; }}"
            ));
            self.emit_line(sl![
                "list_add_tail(x",
                cs.as_str(),
                ", ",
                item.as_str(),
                ", sizeof(",
                &items.c_type,
                " *));"
            ]);
            Ok(())
        } else {
            self.emit_add_scalar(Container::List, items, level, child)
        }
    }

    /// The `add` of a map property in `emitClassFunctions`' getter: one
    /// element of the hashtable `x<level + 1>`.
    fn class_get_hashtable_add(
        &mut self,
        class_name: Name,
        level: usize,
        name: Name,
        property_type: TypeRef,
        items: &TypeCJSON,
    ) -> Result<()> {
        let child = level + 1;
        let cs = child.to_string();
        if items.is("cJSON_Array") {
            let ty = self.type_graph().type_at(property_type)?;
            if ty.kind() != TypeKind::Map {
                return panic("Invalid type");
            }
            let child2 = child + 1;
            self.class_get_recur(class_name, ty.map_values()?, child)?;
            self.emit_line(sl![
                "hashtable_add(x",
                cs.as_str(),
                ", e",
                cs.as_str(),
                "->string, x",
                child2.to_string(),
                ", sizeof(",
                &items.c_type,
                " *));"
            ]);
            Ok(())
        } else if items.is("cJSON_Map") {
            // Not supported.
            Ok(())
        } else if items.is("cJSON_Object") || items.is("cJSON_Union") {
            let element = format!("e{child}");
            let c_type = self.sourcelike_to_string(&items.c_type)?;
            let get_value = self.sourcelike_to_string(&items.get_value)?;
            let property = self.sourcelike_to_string(&name.into())?;
            let class = self.sourcelike_to_string(&class_name.into())?;
            let delete_type = self.sourcelike_to_string(&items.delete_type)?;
            let l = lvl(level);
            self.emit_multiline(&format!(
                "{c_type} * validated = {get_value}({element});
if (NULL == validated) {{
    x{l}->{property} = x{child};
    cJSON_Delete{class}(x);
    return NULL;
}}
{delete_type}(validated);"
            ))?;
            self.emit_line(sl![
                "hashtable_add(x",
                cs.as_str(),
                ", e",
                cs.as_str(),
                "->string, ",
                &items.get_value,
                "(e",
                cs.as_str(),
                "), sizeof(",
                &items.c_type,
                " *));"
            ]);
            Ok(())
        } else {
            self.emit_add_scalar(Container::Hashtable, items, level, child)
        }
    }

    /// The `recur(type, level)` of `emitClassFunctions`' `cJSON_Create`
    /// function: the statements writing `t` (an array or a class) at
    /// `level`.
    fn class_create_recur(&mut self, t: TypeRef, level: usize) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let ty = self.type_graph().type_at(t)?;
            if ty.kind() == TypeKind::Array {
                let item_type = ty.items()?;
                let child = level + 1;
                let cs = child.to_string();
                let c = self.quicktype_type_to_cjson(item_type, false, false)?;
                self.emit_line(sl!["cJSON * j", cs.as_str(), " = cJSON_CreateArray();"]);
                self.emit_block(sl!["if (NULL != j", cs.as_str(), ")"], |r| {
                    r.emit_line(sl![
                        &c.c_type,
                        " * x",
                        cs.as_str(),
                        " = list_get_head(x",
                        level.to_string(),
                        ");"
                    ]);
                    r.emit_block(sl!["while (NULL != x", cs.as_str(), ")"], |r| {
                        if c.is("cJSON_Array") {
                            let child2 = child + 1;
                            r.class_create_recur(item_type, child)?;
                            r.emit_line(sl![
                                "cJSON_AddItemToArray(j",
                                cs.as_str(),
                                ", j",
                                child2.to_string(),
                                ");"
                            ]);
                        } else {
                            r.emit_create_item(
                                sl!["cJSON_AddItemToArray(j", cs.as_str(), ", "],
                                &c,
                                &format!("x{child}"),
                            );
                        }

                        r.emit_line(sl![
                            "x",
                            cs.as_str(),
                            " = list_get_next(x",
                            level.to_string(),
                            ");"
                        ]);
                        Ok(())
                    })
                })
            } else if ty.kind() == TypeKind::Class {
                self.for_each_class_property(
                    t,
                    BlankLinePosition::None,
                    |r, name, json_name, p, _| r.class_create_property(level, name, json_name, p),
                )
            } else {
                Ok(())
            }
        })
    }

    /// One property in `emitClassFunctions`' `cJSON_Create` function.
    fn class_create_property(
        &mut self,
        level: usize,
        name: Name,
        json_name: &str,
        p: ClassProperty,
    ) -> Result<()> {
        let json_name = c_string_escape(json_name);
        let json_name = json_name.as_str();
        let c = self.quicktype_type_to_cjson(p.type_ref, p.is_optional, false)?;
        let l = lvl(level);
        let l = l.as_str();
        let if_present = || sl!["if (NULL != x", l, "->", name, ")"];
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            let child = level + 1;
            let cs = child.to_string();
            let cs = cs.as_str();
            self.emit_block(if_present(), |r| {
                r.emit_line(sl![
                    "cJSON * j",
                    cs,
                    " = cJSON_AddArrayToObject(j",
                    l,
                    ", \"",
                    json_name,
                    "\");"
                ]);
                r.emit_block(sl!["if (NULL != j", cs, ")"], |r| {
                    r.emit_line(sl![
                        &items.c_type,
                        " * x",
                        cs,
                        " = list_get_head(x",
                        l,
                        "->",
                        name,
                        ");"
                    ]);
                    r.emit_block(sl!["while (NULL != x", cs, ")"], |r| {
                        let var = format!("x{child}");
                        r.emit_create_element(
                            items,
                            &var,
                            sl!["cJSON_AddItemToArray(j", cs, ", cJSON_CreateNull());"],
                            |r| {
                                if items.is("cJSON_Array") {
                                    let ty = r.type_graph().type_at(p.type_ref)?;
                                    if ty.kind() != TypeKind::Array {
                                        return panic("Invalid type");
                                    }
                                    let child2 = child + 1;
                                    r.class_create_recur(ty.items()?, child)?;
                                    r.emit_line(sl![
                                        "cJSON_AddItemToArray(j",
                                        cs,
                                        ", j",
                                        child2.to_string(),
                                        ");"
                                    ]);
                                } else {
                                    r.emit_create_item(
                                        sl!["cJSON_AddItemToArray(j", cs, ", "],
                                        items,
                                        &var,
                                    );
                                }
                                Ok(())
                            },
                        )?;

                        r.emit_line(sl!["x", cs, " = list_get_next(x", l, "->", name, ");"]);
                        Ok(())
                    })
                })
            })?;
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            let child = level + 1;
            let cs = child.to_string();
            let cs = cs.as_str();
            self.emit_block(if_present(), |r| {
                r.emit_line(sl!["cJSON * j", cs, " = ", &c.create_object, "();"]);
                r.emit_block(sl!["if (NULL != j", cs, ")"], |r| {
                    r.emit_line(sl!["char **keys", cs, " = NULL;"]);
                    r.emit_line(sl![
                        "size_t count",
                        cs,
                        " = hashtable_get_keys(x",
                        l,
                        "->",
                        name,
                        ", &keys",
                        cs,
                        ");"
                    ]);
                    r.emit_block(sl!["if (NULL != keys", cs, ")"], |r| {
                        r.emit_block(
                            sl![
                                "for (size_t index",
                                cs,
                                " = 0; index",
                                cs,
                                " < count",
                                cs,
                                "; index",
                                cs,
                                "++)"
                            ],
                            |r| {
                                r.emit_line(sl![
                                    &items.c_type,
                                    " *x",
                                    cs,
                                    " = hashtable_lookup(x",
                                    l,
                                    "->",
                                    name,
                                    ", keys",
                                    cs,
                                    "[index",
                                    cs,
                                    "]);"
                                ]);
                                let var = format!("x{child}");
                                let key = sl![
                                    &c.add_to_object,
                                    "(j",
                                    cs,
                                    ", keys",
                                    cs,
                                    "[index",
                                    cs,
                                    "], "
                                ];
                                r.emit_create_element(
                                    items,
                                    &var,
                                    sl![key.clone(), "cJSON_CreateNull());"],
                                    |r| {
                                        if items.is("cJSON_Array") {
                                            let ty = r.type_graph().type_at(p.type_ref)?;
                                            if ty.kind() != TypeKind::Map {
                                                return panic("Invalid type");
                                            }
                                            let child2 = child + 1;
                                            r.class_create_recur(ty.map_values()?, child)?;
                                            r.emit_line(sl![key, "j", child2.to_string(), ");"]);
                                        } else {
                                            r.emit_create_item(key, items, &var);
                                        }
                                        Ok(())
                                    },
                                )
                            },
                        )?;
                        r.emit_line(sl!["cJSON_free(keys", cs, ");"]);
                        Ok(())
                    })?;
                    r.emit_line(sl![
                        &c.add_to_object,
                        "(j",
                        l,
                        ", \"",
                        json_name,
                        "\", j",
                        cs,
                        ");"
                    ]);
                    Ok(())
                })
            })?;
        } else if c.is("cJSON_Invalid") {
            // Nothing to do.
        } else if c.is("cJSON_NULL") {
            let add = sl![&c.add_to_object, "(j", l, ", \"", json_name, "\");"];
            if p.is_optional {
                self.emit_block(if_present(), |r| {
                    r.emit_line(add);
                    Ok(())
                })?;
            } else {
                self.emit_line(add);
            }
        } else if c.is("cJSON_String") {
            self.emit_block(if_present(), |r| {
                r.emit_line(sl![
                    &c.add_to_object,
                    "(j",
                    l,
                    ", \"",
                    json_name,
                    "\", x",
                    l,
                    "->",
                    name,
                    ");"
                ]);
                Ok(())
            })?;
            if !p.is_optional && !c.is_nullable {
                self.emit_block(sl!["else"], |r| {
                    r.emit_line(sl![
                        &c.add_to_object,
                        "(j",
                        l,
                        ", \"",
                        json_name,
                        "\", \"\");"
                    ]);
                    Ok(())
                })?;
            }
        } else {
            // Objects and unions are passed by pointer, enums (when
            // optional or nullable) and everything else by value.
            let (create, deref) = if c.is("cJSON_Object") || c.is("cJSON_Union") {
                (Some(&c.create_object), false)
            } else if c.is("cJSON_Enum") {
                (Some(&c.create_object), p.is_optional || c.is_nullable)
            } else {
                (None, p.is_optional || c.is_nullable)
            };
            let value = sl![if deref { "*x" } else { "x" }, l, "->", name];
            let add = match create {
                Some(create) => sl![
                    &c.add_to_object,
                    "(j",
                    l,
                    ", \"",
                    json_name,
                    "\", ",
                    create,
                    "(",
                    value,
                    "));"
                ],
                None => sl![
                    &c.add_to_object,
                    "(j",
                    l,
                    ", \"",
                    json_name,
                    "\", ",
                    value,
                    ");"
                ],
            };
            if p.is_optional || c.is_nullable {
                self.emit_block(if_present(), |r| {
                    r.emit_line(add);
                    Ok(())
                })?;
            } else {
                self.emit_line(add);
            }
        }

        if c.is_nullable {
            self.emit_block(sl!["else"], |r| {
                r.emit_line(sl!["cJSON_AddNullToObject(j", l, ", \"", json_name, "\");"]);
                Ok(())
            })?;
        }
        Ok(())
    }

    /// The `recur(type, level)` of `emitClassFunctions`' `cJSON_Delete`
    /// function: the statements freeing `t` (an array or a class) at
    /// `level`.
    fn class_delete_recur(&mut self, t: TypeRef, level: usize) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let ty = self.type_graph().type_at(t)?;
            if ty.kind() == TypeKind::Array {
                let item_type = ty.items()?;
                let child = level + 1;
                let cs = child.to_string();
                let c = self.quicktype_type_to_cjson(item_type, false, false)?;
                self.emit_line(sl![
                    &c.c_type,
                    " * x",
                    cs.as_str(),
                    " = list_get_head(x",
                    level.to_string(),
                    ");"
                ]);
                self.emit_block(sl!["while (NULL != x", cs.as_str(), ")"], |r| {
                    if c.is("cJSON_Array") {
                        r.class_delete_recur(item_type, child)?;
                        r.emit_line(sl![&c.delete_type, "(x", cs.as_str(), ");"]);
                    } else if c.is("cJSON_Map") {
                        // Not supported.
                    } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
                        // Nothing to do.
                    } else {
                        r.emit_line(sl![&c.delete_type, "(x", cs.as_str(), ");"]);
                    }

                    r.emit_line(sl![
                        "x",
                        cs.as_str(),
                        " = list_get_next(x",
                        level.to_string(),
                        ");"
                    ]);
                    Ok(())
                })
            } else if ty.kind() == TypeKind::Class {
                self.for_each_class_property(
                    t,
                    BlankLinePosition::None,
                    |r, name, _json_name, p, _| r.class_delete_property(level, name, p),
                )
            } else {
                Ok(())
            }
        })
    }

    /// One property in `emitClassFunctions`' `cJSON_Delete` function.
    fn class_delete_property(&mut self, level: usize, name: Name, p: ClassProperty) -> Result<()> {
        let c = self.quicktype_type_to_cjson(p.type_ref, p.is_optional, false)?;
        let l = lvl(level);
        let l = l.as_str();
        let if_present = || sl!["if (NULL != x", l, "->", name, ")"];
        let delete_property = || sl![&c.delete_type, "(x", l, "->", name, ");"];
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            let child = level + 1;
            let cs = child.to_string();
            let cs = cs.as_str();
            self.emit_block(if_present(), |r| {
                r.emit_line(sl![
                    &items.c_type,
                    " * x",
                    cs,
                    " = list_get_head(x",
                    l,
                    "->",
                    name,
                    ");"
                ]);
                r.emit_block(sl!["while (NULL != x", cs, ")"], |r| {
                    if items.is("cJSON_Array") {
                        let ty = r.type_graph().type_at(p.type_ref)?;
                        if ty.kind() != TypeKind::Array {
                            return panic("Invalid type");
                        }
                        r.class_delete_recur(ty.items()?, child)?;
                        r.emit_line(sl![&items.delete_type, "(x", cs, ");"]);
                    } else {
                        r.emit_delete_item(items, &format!("x{child}"))?;
                    }

                    r.emit_line(sl!["x", cs, " = list_get_next(x", l, "->", name, ");"]);
                    Ok(())
                })?;
                r.emit_line(delete_property());
                Ok(())
            })
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            let child = level + 1;
            let cs = child.to_string();
            let cs = cs.as_str();
            self.emit_block(if_present(), |r| {
                r.emit_line(sl!["char **keys", cs, " = NULL;"]);
                r.emit_line(sl![
                    "size_t count",
                    cs,
                    " = hashtable_get_keys(x",
                    l,
                    "->",
                    name,
                    ", &keys",
                    cs,
                    ");"
                ]);
                r.emit_block(sl!["if (NULL != keys", cs, ")"], |r| {
                    r.emit_block(
                        sl![
                            "for (size_t index",
                            cs,
                            " = 0; index",
                            cs,
                            " < count",
                            cs,
                            "; index",
                            cs,
                            "++)"
                        ],
                        |r| {
                            r.emit_line(sl![
                                &items.c_type,
                                " *x",
                                cs,
                                " = hashtable_lookup(x",
                                l,
                                "->",
                                name,
                                ", keys",
                                cs,
                                "[index",
                                cs,
                                "]);"
                            ]);
                            r.emit_block(sl!["if (NULL != x", cs, ")"], |r| {
                                if items.is("cJSON_Array") {
                                    let ty = r.type_graph().type_at(p.type_ref)?;
                                    if ty.kind() != TypeKind::Map {
                                        return panic("Invalid type");
                                    }
                                    r.class_delete_recur(ty.map_values()?, child)?;
                                    r.emit_line(sl![&items.delete_type, "(x", cs, ");"]);
                                    Ok(())
                                } else {
                                    r.emit_delete_item(items, &format!("x{child}"))
                                }
                            })
                        },
                    )?;
                    r.emit_line(sl!["cJSON_free(keys", cs, ");"]);
                    Ok(())
                })?;
                r.emit_line(delete_property());
                Ok(())
            })
        } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
            // Nothing to do.
            Ok(())
        } else if c.is("cJSON_String")
            || c.is("cJSON_Object")
            || c.is("cJSON_Union")
            || p.is_optional
            || c.is_nullable
        {
            self.emit_block(if_present(), |r| {
                r.emit_line(delete_property());
                Ok(())
            })
        } else {
            Ok(())
        }
    }

    /// `emitTopLevel(type, className, includes)`: the files of a top-level
    /// that is not a named type.
    fn emit_top_level(&mut self, t: TypeRef, class_name: Name, includes: &[String]) -> Result<()> {
        // Create file.
        let header_filename = format!("{}.h", self.sourcelike_to_string(&class_name.into())?);
        self.start_header_file(&header_filename)?;

        // Create includes - This create too much includes but this is safer
        // because of specific corner cases.
        for name in includes {
            self.emit_include_line(name.as_str(), false);
        }
        self.ensure_blank_line();

        // Create types.
        self.emit_top_level_typedef(t, class_name)?;

        // Create prototypes.
        self.emit_top_level_prototypes(t, class_name)?;

        self.split_header_and_source(&header_filename)?;

        // Create functions.
        self.emit_top_level_functions(t, class_name)?;

        self.finish_current_file()
    }

    /// `emitTopLevelTypedef(type, className)`.
    fn emit_top_level_typedef(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        self.emit_block_with(
            sl!["struct ", class_name],
            |r| {
                let c = r.quicktype_type_to_cjson(t, false, false)?;
                r.emit_line(sl![
                    c.c_type,
                    if c.optional_qualifier.is_empty() {
                        ""
                    } else {
                        " "
                    },
                    c.optional_qualifier,
                    " value;"
                ]);
                Ok(())
            },
            "",
            true,
        )?;
        self.ensure_blank_line();
        self.emit_typedef_alias(t, class_name)
    }

    /// `emitTopLevelPrototypes(type, className)`.
    fn emit_top_level_prototypes(&mut self, _t: TypeRef, class_name: Name) -> Result<()> {
        self.emit_struct_prototypes(class_name);
        Ok(())
    }

    /// `emitTopLevelFunctions(type, className)`.
    fn emit_top_level_functions(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        // Create string to className generator function.
        self.emit_parse_function(class_name)?;

        // Create cJSON to className generator function.
        self.emit_get_value_function(class_name, |r| r.top_level_get_value(t, class_name))?;

        // Create className to cJSON generator function.
        self.emit_block(
            sl![
                "cJSON * cJSON_Create",
                class_name,
                "(",
                with_const(sl!["struct ", class_name]),
                " * x)"
            ],
            |r| {
                r.emit_line("cJSON * j = NULL;");
                r.emit_block(sl!["if (NULL != x)"], |r| r.top_level_create(t))?;
                r.emit_line("return j;");
                Ok(())
            },
        )?;
        self.ensure_blank_line();

        // Create className to string generator function.
        self.emit_print_function(class_name, "s = cJSON_Print(j);")?;

        // Create className delete function.
        self.emit_block(
            sl![
                "void cJSON_Delete",
                class_name,
                "(struct ",
                class_name,
                " * x)"
            ],
            |r| {
                r.emit_block(sl!["if (NULL != x)"], |r| {
                    r.top_level_delete(t)?;
                    r.emit_line("cJSON_free(x);");
                    Ok(())
                })
            },
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// The body of a top-level's `cJSON_Get<name>Value`.
    fn top_level_get_value(&mut self, t: TypeRef, class_name: Name) -> Result<()> {
        let c = self.quicktype_type_to_cjson(t, false, false)?;
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            self.emit_line("x->value = list_create(false, NULL);");
            self.emit_block(sl!["if (NULL != x->value)"], |r| {
                r.emit_line("cJSON * e = NULL;");
                r.emit_block(sl!["cJSON_ArrayForEach(e, j)"], |r| {
                    if !items.is_nullable && items.has_is_type() {
                        r.emit_line(sl![
                            "if (!",
                            &items.is_type,
                            "(e)) { cJSON_Delete",
                            class_name,
                            "(x); return NULL; }"
                        ]);
                    }

                    if items.is_nullable {
                        r.emit_block(sl!["if (!cJSON_IsNull(e))"], |r| {
                            r.top_level_list_add(items);
                            Ok(())
                        })?;
                        r.emit_block(sl!["else"], |r| {
                            r.emit_line(
                                "list_add_tail(x->value, (void *)0xDEADBEEF, sizeof(void *));",
                            );
                            Ok(())
                        })
                    } else {
                        r.top_level_list_add(items);
                        Ok(())
                    }
                })
            })
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            let size = self.options.hashtable_size.clone();
            self.emit_line(sl!["x->value = hashtable_create(", size, ", false);"]);
            self.emit_block(sl!["if (NULL != x->value)"], |r| {
                r.emit_line("cJSON * e = NULL;");
                r.emit_block(sl!["cJSON_ArrayForEach(e, j)"], |r| {
                    if items.is_nullable {
                        r.emit_block(sl!["if (!cJSON_IsNull(e))"], |r| {
                            r.top_level_hashtable_add(items);
                            Ok(())
                        })?;
                        r.emit_block(sl!["else"], |r| {
                            r.emit_line(
                                "hashtable_add(x->value, e->string, (void *)0xDEADBEEF, sizeof(void *));",
                            );
                            Ok(())
                        })
                    } else {
                        r.top_level_hashtable_add(items);
                        Ok(())
                    }
                })
            })
        } else if c.is("cJSON_Invalid") {
            // Nothing to do.
            Ok(())
        } else if c.is("cJSON_NULL") {
            self.emit_line(sl!["x->value = (", &c.c_type, " *)0xDEADBEEF;"]);
            Ok(())
        } else if c.is("cJSON_String") {
            self.emit_line(sl!["x->value = strdup(", &c.get_value, "(j));"]);
            Ok(())
        } else {
            self.emit_line(sl!["x->value = ", &c.get_value, "(j);"]);
            Ok(())
        }
    }

    /// The `add` of a top-level array's getter (note `0xDEADBEAF`, as in
    /// the TypeScript).
    fn top_level_list_add(&mut self, items: &TypeCJSON) {
        if items.is("cJSON_Array") || items.is("cJSON_Map") {
            // Not supported.
        } else if items.is("cJSON_Invalid") || items.is("cJSON_NULL") {
            self.emit_line(sl![
                "list_add_tail(x->value, (",
                &items.c_type,
                " *)0xDEADBEAF, sizeof(",
                &items.c_type,
                " *));"
            ]);
        } else if items.is("cJSON_String") {
            self.emit_line(sl![
                "list_add_tail(x->value, strdup(",
                &items.get_value,
                "(e)), sizeof(",
                &items.c_type,
                " *));"
            ]);
        } else if items.is_freed_with_cjson_free() {
            self.emit_line(sl![&items.c_type, " * item = cJSON_malloc(sizeof(*item));"]);
            self.emit_line(sl![
                "if (NULL != item) { *item = ",
                &items.get_value,
                "(e); list_add_tail(x->value, item, sizeof(*item)); }"
            ]);
        } else {
            self.emit_line(sl![
                "list_add_tail(x->value, ",
                &items.get_value,
                "(e), sizeof(",
                &items.c_type,
                " *));"
            ]);
        }
    }

    /// The `add` of a top-level map's getter.
    fn top_level_hashtable_add(&mut self, items: &TypeCJSON) {
        if items.is("cJSON_Array") || items.is("cJSON_Map") {
            // Not supported.
        } else if items.is("cJSON_Invalid") || items.is("cJSON_NULL") {
            self.emit_line(sl![
                "hashtable_add(x->value, e->string, (",
                &items.c_type,
                " *)0xDEADBEEF, sizeof(",
                &items.c_type,
                " *));"
            ]);
        } else if items.is("cJSON_String") {
            self.emit_line(sl![
                "hashtable_add(x->value, e->string, strdup(",
                &items.get_value,
                "(e)), sizeof(",
                &items.c_type,
                " *));"
            ]);
        } else {
            self.emit_line(sl![
                "hashtable_add(x->value, e->string, ",
                &items.get_value,
                "(e), sizeof(",
                &items.c_type,
                " *));"
            ]);
        }
    }

    /// The body of a top-level's `cJSON_Create<name>`, inside
    /// `if (NULL != x)`.
    fn top_level_create(&mut self, t: TypeRef) -> Result<()> {
        let c = self.quicktype_type_to_cjson(t, false, false)?;
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            self.emit_block(sl!["if (NULL != x->value)"], |r| {
                r.emit_line(sl!["j = ", &c.create_object, "();"]);
                r.emit_block(sl!["if (NULL != j)"], |r| {
                    r.emit_line(sl![&items.c_type, " * x1 = list_get_head(x->value);"]);
                    r.emit_block(sl!["while (NULL != x1)"], |r| {
                        r.emit_create_element(
                            items,
                            "x1",
                            sl!["cJSON_AddItemToArray(j, cJSON_CreateNull());"],
                            |r| {
                                r.emit_create_item(sl!["cJSON_AddItemToArray(j, "], items, "x1");
                                Ok(())
                            },
                        )?;

                        r.emit_line("x1 = list_get_next(x->value);");
                        Ok(())
                    })
                })
            })
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            self.emit_block(sl!["if (NULL != x->value)"], |r| {
                r.emit_line(sl!["j = ", &c.create_object, "();"]);
                r.emit_block(sl!["if (NULL != j)"], |r| {
                    r.emit_line("char **keys = NULL;");
                    r.emit_line("size_t count = hashtable_get_keys(x->value, &keys);");
                    r.emit_block(sl!["if (NULL != keys)"], |r| {
                        r.emit_block(sl!["for (size_t index = 0; index < count; index++)"], |r| {
                            r.emit_line(sl![
                                &items.c_type,
                                " *x2 = hashtable_lookup(x->value, keys[index]);"
                            ]);
                            let key = sl![&c.add_to_object, "(j, keys[index], "];
                            r.emit_create_element(
                                items,
                                "x2",
                                sl![key.clone(), "cJSON_CreateNull());"],
                                |r| {
                                    r.emit_create_item(key, items, "x2");
                                    Ok(())
                                },
                            )
                        })?;
                        r.emit_line("cJSON_free(keys);");
                        Ok(())
                    })
                })
            })
        } else if c.is("cJSON_Invalid") {
            // Nothing to do.
            Ok(())
        } else if c.is("cJSON_NULL") {
            self.emit_line(sl!["j = ", &c.create_object, "();"]);
            Ok(())
        } else {
            self.emit_line(sl!["j = ", &c.create_object, "(x->value);"]);
            Ok(())
        }
    }

    /// The body of a top-level's `cJSON_Delete<name>`, inside
    /// `if (NULL != x)` and before `cJSON_free(x)`.
    fn top_level_delete(&mut self, t: TypeRef) -> Result<()> {
        let c = self.quicktype_type_to_cjson(t, false, false)?;
        if c.is("cJSON_Array")
            && let Some(items) = &c.items
        {
            self.emit_block(sl!["if (NULL != x->value)"], |r| {
                r.emit_line(sl![&items.c_type, " * x1 = list_get_head(x->value);"]);
                r.emit_block(sl!["while (NULL != x1)"], |r| {
                    if items.is_nullable {
                        r.emit_block(sl!["if ((void *)0xDEADBEEF != x1)"], |r| {
                            r.emit_line(sl![&items.delete_type, "(x1);"]);
                            Ok(())
                        })?;
                    } else {
                        r.emit_line(sl![&items.delete_type, "(x1);"]);
                    }

                    r.emit_line("x1 = list_get_next(x->value);");
                    Ok(())
                })?;
                r.emit_line(sl![&c.delete_type, "(x->value);"]);
                Ok(())
            })
        } else if c.is("cJSON_Map")
            && let Some(items) = &c.items
        {
            self.emit_block(sl!["if (NULL != x->value)"], |r| {
                r.emit_line("char **keys = NULL;");
                r.emit_line("size_t count = hashtable_get_keys(x->value, &keys);");
                r.emit_block(sl!["if (NULL != keys)"], |r| {
                    r.emit_block(sl!["for (size_t index = 0; index < count; index++)"], |r| {
                        r.emit_line(sl![
                            &items.c_type,
                            " *x2 = hashtable_lookup(x->value, keys[index]);"
                        ]);
                        r.emit_block(sl!["if (NULL != x2)"], |r| {
                            if items.is_nullable {
                                r.emit_block(
                                    sl!["if ((", &items.c_type, " *)0xDEADBEEF != x2)"],
                                    |r| {
                                        r.emit_line(sl![&items.delete_type, "(x2);"]);
                                        Ok(())
                                    },
                                )
                            } else {
                                r.emit_line(sl![&items.delete_type, "(x2);"]);
                                Ok(())
                            }
                        })
                    })?;
                    r.emit_line("cJSON_free(keys);");
                    Ok(())
                })?;
                r.emit_line(sl![&c.delete_type, "(x->value);"]);
                Ok(())
            })
        } else if c.is("cJSON_Invalid") || c.is("cJSON_NULL") {
            // Nothing to do.
            Ok(())
        } else if c.is("cJSON_String") || c.is("cJSON_Object") || c.is("cJSON_Union") {
            self.emit_line(sl![&c.delete_type, "(x->value);"]);
            Ok(())
        } else {
            // Nothing to do.
            Ok(())
        }
    }

    /// `quicktypeTypeToCJSON(t, isOptional, isNullable)`: what the
    /// generated code needs to know about `t`.
    fn quicktype_type_to_cjson(
        &self,
        t: TypeRef,
        is_optional: bool,
        is_nullable: bool,
    ) -> Result<TypeCJSON> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let optional = if is_optional { "*" } else { "" };
            Ok(match graph.kind(t)? {
                TypeKind::Any => TypeCJSON {
                    c_type: "cJSON".into(),
                    optional_qualifier: "*",
                    cjson_type: "cJSON_Object",
                    is_type: "".into(),
                    get_value: "quicktype_cJSON_Duplicate".into(),
                    add_to_object: "cJSON_AddItemToObject".into(),
                    create_object: "quicktype_cJSON_Duplicate".into(),
                    delete_type: "cJSON_Delete".into(),
                    items: None,
                    is_nullable,
                },
                TypeKind::Null => TypeCJSON {
                    c_type: "void".into(),
                    optional_qualifier: "*",
                    cjson_type: "cJSON_NULL",
                    is_type: "cJSON_IsNull".into(),
                    get_value: "".into(),
                    add_to_object: "cJSON_AddNullToObject".into(),
                    create_object: "cJSON_CreateNull".into(),
                    delete_type: "cJSON_free".into(),
                    items: None,
                    is_nullable,
                },
                TypeKind::Bool => TypeCJSON {
                    c_type: "bool".into(),
                    optional_qualifier: optional,
                    cjson_type: "cJSON_Bool",
                    is_type: "cJSON_IsBool".into(),
                    get_value: "cJSON_IsTrue".into(),
                    add_to_object: "cJSON_AddBoolToObject".into(),
                    create_object: "cJSON_CreateBool".into(),
                    delete_type: "cJSON_free".into(),
                    items: None,
                    is_nullable,
                },
                TypeKind::Integer => TypeCJSON {
                    c_type: self.options.type_integer_size.as_str().into(),
                    optional_qualifier: optional,
                    cjson_type: "cJSON_Integer",
                    is_type: "quicktype_cJSON_IsInteger".into(),
                    get_value: "cJSON_GetNumberValue".into(),
                    add_to_object: "cJSON_AddNumberToObject".into(),
                    create_object: "cJSON_CreateNumber".into(),
                    delete_type: "cJSON_free".into(),
                    items: None,
                    is_nullable,
                },
                TypeKind::Double => TypeCJSON {
                    c_type: "double".into(),
                    optional_qualifier: optional,
                    cjson_type: "cJSON_Number",
                    is_type: "cJSON_IsNumber".into(),
                    get_value: "cJSON_GetNumberValue".into(),
                    add_to_object: "cJSON_AddNumberToObject".into(),
                    create_object: "cJSON_CreateNumber".into(),
                    delete_type: "cJSON_free".into(),
                    items: None,
                    is_nullable,
                },
                TypeKind::String => TypeCJSON {
                    c_type: "char".into(),
                    optional_qualifier: "*",
                    cjson_type: "cJSON_String",
                    is_type: "cJSON_IsString".into(),
                    get_value: "cJSON_GetStringValue".into(),
                    add_to_object: "cJSON_AddStringToObject".into(),
                    create_object: "cJSON_CreateString".into(),
                    delete_type: "cJSON_free".into(),
                    items: None,
                    is_nullable,
                },
                TypeKind::Array => {
                    let items =
                        self.quicktype_type_to_cjson(graph.type_at(t)?.items()?, false, false)?;
                    TypeCJSON {
                        c_type: "list_t".into(),
                        optional_qualifier: "*",
                        cjson_type: "cJSON_Array",
                        is_type: "cJSON_IsArray".into(),
                        get_value: "cJSON_GetArrayItem".into(),
                        add_to_object: "cJSON_AddItemToObject".into(),
                        create_object: "cJSON_CreateArray".into(),
                        delete_type: "list_release".into(),
                        items: Some(Box::new(items)),
                        is_nullable,
                    }
                }
                TypeKind::Class => {
                    let name = self.name_for_named_type(t)?;
                    TypeCJSON {
                        c_type: sl!["struct ", name],
                        optional_qualifier: "*",
                        cjson_type: "cJSON_Object",
                        is_type: "cJSON_IsObject".into(),
                        get_value: sl!["cJSON_Get", name, "Value"],
                        add_to_object: "cJSON_AddItemToObject".into(),
                        create_object: sl!["cJSON_Create", name],
                        delete_type: sl!["cJSON_Delete", name],
                        items: None,
                        is_nullable,
                    }
                }
                TypeKind::Map => {
                    let items = self.quicktype_type_to_cjson(
                        graph.type_at(t)?.map_values()?,
                        false,
                        false,
                    )?;
                    TypeCJSON {
                        c_type: "hashtable_t".into(),
                        optional_qualifier: "*",
                        cjson_type: "cJSON_Map",
                        is_type: "cJSON_IsObject".into(),
                        get_value: "".into(),
                        add_to_object: "cJSON_AddItemToObject".into(),
                        create_object: "cJSON_CreateObject".into(),
                        delete_type: "hashtable_release".into(),
                        items: Some(Box::new(items)),
                        is_nullable,
                    }
                }
                TypeKind::Enum => {
                    let name = self.name_for_named_type(t)?;
                    TypeCJSON {
                        c_type: sl!["enum ", name],
                        optional_qualifier: optional,
                        cjson_type: "cJSON_Enum",
                        is_type: "cJSON_IsString".into(),
                        get_value: sl!["cJSON_Get", name, "Value"],
                        add_to_object: "cJSON_AddItemToObject".into(),
                        create_object: sl!["cJSON_Create", name],
                        delete_type: "cJSON_free".into(),
                        items: None,
                        is_nullable,
                    }
                }
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return self.quicktype_type_to_cjson(nullable, true, true);
                    }
                    let name = self.name_for_named_type(t)?;
                    TypeCJSON {
                        c_type: sl!["struct ", name],
                        optional_qualifier: "*",
                        cjson_type: "cJSON_Union",
                        is_type: sl!["cJSON_Is", name],
                        get_value: sl!["cJSON_Get", name, "Value"],
                        add_to_object: "cJSON_AddItemToObject".into(),
                        create_object: sl!["cJSON_Create", name],
                        delete_type: sl!["cJSON_Delete", name],
                        items: None,
                        is_nullable,
                    }
                }
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `startHeaderFile(proposedFilename)`: the file comment, include
    /// guard, C++ guard, includes and helper macros of a header.
    fn start_header_file(&mut self, proposed_filename: &str) -> Result<()> {
        // Check if previous header file is closed, create a new file.
        assert(
            self.current_header_filename.is_none(),
            "Previous header file wasn't finished",
        )?;
        let header_filename = proposed_filename.to_owned();
        self.current_header_filename = Some(header_filename.clone());

        // Write header.
        self.emit_description_block(&[
            header_filename.as_str().into(),
            "This file has been autogenerated using quicktype https://github.com/quicktype/quicktype - DO NOT EDIT".into(),
            "This file depends of https://github.com/DaveGamble/cJSON, https://github.com/joelguittet/c-list and https://github.com/joelguittet/c-hashtable".into(),
            "To parse json data from json string use the following: struct <type> * data = cJSON_Parse<type>(<string>);".into(),
            "To get json data from cJSON object use the following: struct <type> * data = cJSON_Get<type>Value(<cjson>);".into(),
            "To get cJSON object from json data use the following: cJSON * cjson = cJSON_Create<type>(<data>);".into(),
            "To print json string from json data use the following: char * string = cJSON_Print<type>(<data>);".into(),
            "To delete json data use the following: cJSON_Delete<type>(<data>);".into(),
        ])?;
        self.ensure_blank_line();

        // Write include guard.
        let guard_name = include_guard(&header_filename);
        self.emit_line(sl!["#ifndef __", guard_name.as_str(), "__"]);
        self.emit_line(sl!["#define __", guard_name.as_str(), "__"]);
        self.ensure_blank_line();

        // Write C++ guard.
        self.emit_line("#ifdef __cplusplus");
        self.emit_line("extern \"C\" {");
        self.emit_line("#endif");
        self.ensure_blank_line();

        // Write includes.
        for include in [
            "stdint.h",
            "stdbool.h",
            "stdlib.h",
            "string.h",
            "regex.h",
            "cJSON.h",
            "hashtable.h",
            "list.h",
        ] {
            self.emit_include_line(include, true);
        }
        self.ensure_blank_line();

        // Additional cJSON types.
        self.emit_line("#define quicktype_cJSON_Duplicate(j) cJSON_Duplicate(j, true)");
        self.emit_line("#define cJSON_Integer (1 << 18)");
        self.emit_line(
            "#define quicktype_cJSON_IsInteger(j) (cJSON_IsNumber(j) && (j)->valuedouble == (int64_t)(j)->valuedouble)",
        );
        self.emit_line("#ifndef cJSON_Bool");
        self.emit_line("#define cJSON_Bool (cJSON_True | cJSON_False)");
        self.emit_line("#endif");
        self.emit_line("#ifndef cJSON_Map");
        self.emit_line("#define cJSON_Map (1 << 16)");
        self.emit_line("#endif");
        self.emit_line("#ifndef cJSON_Enum");
        self.emit_line("#define cJSON_Enum (1 << 17)");
        self.emit_line("#endif");
        self.ensure_blank_line();

        self.emit_multiline(
            r"#ifndef QUICKTYPE_STRLEN_CODEPOINTS
#define QUICKTYPE_STRLEN_CODEPOINTS
static inline size_t quicktype_strlen_codepoints(const char * s)
{
    size_t n = 0;
    for (; *s != '\0'; s++) { if ((*s & 0xC0) != 0x80) { n++; } }
    return n;
}
#endif",
        )?;
        self.ensure_blank_line();
        Ok(())
    }

    /// `startSourceFile(headerFilename)`: the file comment and the include
    /// of the header of a source file.
    fn start_source_file(&mut self, header_filename: &str) -> Result<()> {
        // Check if previous source file is closed, create a new file.
        assert(
            self.current_source_filename.is_none(),
            "Previous source file wasn't finished",
        )?;
        let source_filename = get_source_name_from_header_name(header_filename);
        self.current_source_filename = Some(source_filename.clone());

        // Write header.
        self.emit_description_block(&[
            source_filename.into(),
            "This file has been autogenerated using quicktype https://github.com/quicktype/quicktype - DO NOT EDIT".into(),
        ])?;
        self.ensure_blank_line();

        // Include corresponding header file.
        self.emit_include_line(header_filename, false);
        self.ensure_blank_line();
        Ok(())
    }

    /// `finishHeaderFile()`: closes the guards and finishes the header.
    fn finish_header_file(&mut self) -> Result<()> {
        // Check if header file has been created.
        if let Some(header_filename) = self.current_header_filename.clone() {
            // Write C++ guard.
            self.emit_line("#ifdef __cplusplus");
            self.emit_line("}");
            self.emit_line("#endif");
            self.ensure_blank_line();

            // Write include guard.
            self.emit_line(sl![
                "#endif /* __",
                include_guard(&header_filename),
                "__ */"
            ]);
            self.ensure_blank_line();

            // Close header file.
            defaults::finish_file(self, &header_filename)?;
            self.current_header_filename = None;
        }
        Ok(())
    }

    /// `finishSourceFile()`.
    fn finish_source_file(&mut self) -> Result<()> {
        // Check if source file has been created.
        if let Some(source_filename) = self.current_source_filename.clone() {
            self.ensure_blank_line();

            // Close source file.
            defaults::finish_file(self, &source_filename)?;
            self.current_source_filename = None;
        }
        Ok(())
    }

    /// `finishCurrentFile()`: the header when generating headers only, the
    /// source file otherwise.
    fn finish_current_file(&mut self) -> Result<()> {
        if self.options.header_only {
            // Close header file.
            self.finish_header_file()
        } else {
            // Close source file.
            self.finish_source_file()
        }
    }

    /// `emitIncludeLine(name, global)`.
    fn emit_include_line(&mut self, name: &str, global: bool) {
        self.emit_line(sl![
            "#include ",
            if global { "<" } else { "\"" },
            name,
            if global { ">" } else { "\"" }
        ]);
    }

    /// `emitIncludes(type, filename)`: the headers of the named types a
    /// class or union uses, except `filename` itself.
    fn emit_includes(&mut self, t: TypeRef, filename: &str) -> Result<()> {
        // List required includes.
        let mut includes = IncludeMap::new();
        let ty = self.type_graph().type_at(t)?;
        if ty.is_union() {
            self.update_includes(false, &mut includes, t)?;
        } else if ty.is_class() {
            self.for_each_class_property(t, BlankLinePosition::None, |r, _, _, p, _| {
                r.update_includes(true, &mut includes, p.type_ref)
            })?;
        }

        // Emit includes.
        for name in includes.keys() {
            let name = format!("{name}.h");
            if name != filename {
                self.emit_include_line(&name, false);
            }
        }

        self.ensure_blank_line();
        Ok(())
    }

    /// `updateIncludes(isClassMember, includes, propertyType)`.
    fn update_includes(
        &self,
        is_class_member: bool,
        includes: &mut IncludeMap,
        property_type: TypeRef,
    ) -> Result<()> {
        let prop_types = self.generated_types(is_class_member, property_type)?;
        let graph = self.type_graph();
        for t in prop_types {
            let type_name = self.sourcelike_to_string(&t.name.into())?;
            let mut prop_record = IncludeRecord {
                kind: None,
                type_kind: None,
            };
            let ty = graph.type_at(t.type_ref)?;
            if ty.is_class() {
                // We can NOT forward declare direct class members, e.g. a
                // class type is included at level#0. HOWEVER if it is not a
                // direct class member, then we can SURELY forward declare
                // it.
                prop_record.type_kind = Some(TypeKind::Class);
                prop_record.kind = Some(if t.level == 0 || t.force_include {
                    IncludeKind::Include
                } else {
                    IncludeKind::ForwardDeclare
                });
            } else if ty.is_enum() {
                prop_record.type_kind = Some(TypeKind::Enum);
                prop_record.kind = Some(IncludeKind::ForwardDeclare);
            } else if ty.is_union() {
                prop_record.type_kind = Some(TypeKind::Union);
                // TypeScript checks `removeNullFromUnion(t, true)[0] !==
                // undefined`, which always holds (the null member is
                // `null`, never `undefined`): unions are always included.
                prop_record.kind = Some(IncludeKind::Include);
            }

            match includes.get(&type_name) {
                // If we already include the type as typed include, do not
                // write it over with forward declare.
                Some(existing) => {
                    if existing.kind == Some(IncludeKind::ForwardDeclare) {
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

    /// `generatedTypes(isClassMember, type)`: the named types `t` uses,
    /// through arrays, maps and unions.
    fn generated_types(&self, is_class_member: bool, t: TypeRef) -> Result<Vec<TypeRecord>> {
        let mut result = Vec::new();
        self.generated_types_recur(is_class_member, &mut result, false, false, 0, t)?;
        Ok(result)
    }

    /// The `recur(forceInclude, isVariant, l, t)` of `generatedTypes`.
    fn generated_types_recur(
        &self,
        is_class_member: bool,
        result: &mut Vec<TypeRecord>,
        force_include: bool,
        is_variant: bool,
        l: usize,
        t: TypeRef,
    ) -> Result<()> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let mut force_include = force_include;
            let ty = self.type_graph().type_at(t)?;
            match ty.kind() {
                TypeKind::Array => self.generated_types_recur(
                    is_class_member,
                    result,
                    force_include,
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
                    force_include,
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
                    // If we have a union as a class member and we see it as
                    // a "named union", we can safely include it as-is.
                    // HOWEVER if we define a union on its own, we must
                    // recurse into the type definition and include all
                    // subtypes.
                    if self.union_needs_name(t)? && is_class_member {
                        // A variant member in a class must know the sizes of
                        // all its members, so all subtypes are included as
                        // well, forced.
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
                        remove_null_from_union(self.type_graph(), t, NullRemovalSort::None)?;
                    let is_variant = has_null.is_some();
                    // We need to collect all the subtypes of the union.
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
}

/// `getSourceNameFromHeaderName(headerName)`: `headerName` with a trailing
/// `.h` replaced by `.c`.
pub fn get_source_name_from_header_name(header_name: &str) -> String {
    match header_name.strip_suffix(".h") {
        Some(base) => format!("{base}.c"),
        None => header_name.to_owned(),
    }
}

impl<'a> ConvenienceRenderer<'a> for CJsonRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(KEYWORDS
            .iter()
            .map(|&k| k.to_owned())
            .chain(self.forbidden_global_names.iter().cloned())
            .collect())
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

    fn forbidden_for_union_members(
        &mut self,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn forbidden_for_object_properties(
        &mut self,
        _o: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: Vec::new(),
            include_global_forbidden: true,
        })
    }

    fn make_named_type_namer(&mut self) -> Namer {
        namer("types", &self.named_type_name_style)
    }

    /// A new namer for every property, as in TypeScript.
    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(namer("members", &self.member_name_style)))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(namer("members", &self.member_name_style))
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(namer(
            "enumerators",
            &name_style(self.options.enumerator_naming_style),
        ))
    }

    /// The default proposal, with `bool` as `boolean` and `double` as
    /// `number`.
    fn propose_union_member_name(
        &mut self,
        u: TypeRef,
        union_name: Name,
        field_type: TypeRef,
    ) -> Result<Proposer> {
        let base = defaults::propose_union_member_name(self, u, union_name, field_type)?;
        Ok(Rc::new(move |lookup| {
            let field_name = base(lookup);
            match field_name.as_str() {
                "bool" => "boolean".to_owned(),
                "double" => "number".to_owned(),
                _ => field_name,
            }
        }))
    }

    fn emit_source_structure(&mut self, given_output_filename: &str) -> Result<()> {
        // Depending of source style option, generate a unique header or
        // multiple header files.
        if self.options.type_source_style {
            self.emit_single_source_structure(given_output_filename)
        } else {
            self.emit_multi_source_structure()
        }
    }

    fn needs_type_declaration_before_use(&self) -> bool {
        true
    }

    /// Only classes.
    fn can_be_forward_declared(&self, t: TypeRef) -> Result<bool> {
        Ok(self.type_graph().kind(t)? == TypeKind::Class)
    }

    fn comment_lines_splice_on_backslash(&self) -> bool {
        true
    }

    /// `/** ... */` with ` * ` lines.
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
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn c_string_escape_uses_octal_for_controls() {
        assert_eq!(c_string_escape("a\u{1}b"), "a\\001b");
        assert_eq!(c_string_escape("\u{7f}"), "\\177");
        assert_eq!(c_string_escape("\u{85}"), "\\302\\205");
        assert_eq!(c_string_escape("\"\\"), "\\\"\\\\");
        // A doubled backslash followed by `u0001` starts a match, as with
        // the TypeScript regular expression on the escaped text.
        assert_eq!(c_string_escape("\\u0001"), "\\\\001");
        // Upper-case hex digits are not rewritten.
        assert_eq!(control_escape("u001F"), None);
        assert_eq!(control_escape("u00a0"), None);
    }

    #[test]
    fn include_guards_and_source_names() {
        assert_eq!(include_guard("TopLevel.h"), "TOPLEVEL_H");
        assert_eq!(include_guard("my..house-ä.h"), "MY_HOUSE_H");
        assert_eq!(get_source_name_from_header_name("my.house.h"), "my.house.c");
        assert_eq!(get_source_name_from_header_name("stdout"), "stdout");
        assert_eq!(get_source_name_from_header_name("a.h.hpp"), "a.h.hpp");
    }
}
