//! Port of `packages/quicktype-core/src/language/Swift/SwiftRenderer.ts`.
//!
//! Renders `Codable` structs (or classes), string enums and enums with
//! associated values for unions, plus the `JSONSchemaSupport` helpers
//! (`JSONNull`, `JSONAny`, encoder/decoder factories, Alamofire handlers).
//! With `--multi-file-output` every named type gets its own file.

use std::borrow::Cow;
use std::cell::Cell;

use crate::annotation::{any_type_issue_annotation, null_type_issue_annotation};
use crate::convenience_renderer::prelude::*;
use crate::convenience_renderer::{ConvenienceRendererCore, ForbiddenWordsInfo};
use crate::renderer_options::{EnumValue, RendererOptions};
use crate::support::acronyms::{AcronymStyleOptions, acronym_style};
use crate::support::comments::CommentOptions;
use crate::support::recursion::guard;
use crate::support::strings::camel_case;
use crate::support::support::{assert, defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{
    NullRemovalSort, find_member, nullable_from_union, remove_null_from_union,
};

use super::constants::KEYWORDS;
use super::language::{
    ACCESS_LEVEL, ACRONYM_STYLE, ALAMOFIRE, AccessLevel, CODING_KEYS_PROTOCOL,
    CONVENIENCE_INITIALIZERS, DENSE, EXPLICIT_CODING_KEYS, FINAL_CLASSES, JUST_TYPES, LINUX,
    MULTI_FILE_OUTPUT, MUTABLE_PROPERTIES, NAMED_TYPE_PREFIX, OBJC_SUPPORT, OPTIONAL_ENUMS,
    PROTOCOL, SENDABLE, SwiftProtocol, USE_CLASSES,
};
use super::utils::{MAX_SAMELINE_PROPERTIES, SwiftProperty, string_escape, swift_name_style};

/// The option values of the Swift renderer (TS
/// `OptionValues<typeof swiftOptions>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct SwiftOptions {
    /// `justTypes`.
    pub just_types: bool,
    /// `convenienceInitializers`.
    pub convenience_initializers: bool,
    /// `explicitCodingKeys` (declared, but the renderer never reads it).
    pub explicit_coding_keys: bool,
    /// `codingKeysProtocol`.
    pub coding_keys_protocol: String,
    /// `alamofire`.
    pub alamofire: bool,
    /// `namedTypePrefix`.
    pub named_type_prefix: String,
    /// `useClasses` (`struct-or-class` is `class`).
    pub use_classes: bool,
    /// `finalClasses`.
    pub final_classes: bool,
    /// `mutableProperties`.
    pub mutable_properties: bool,
    /// `acronymStyle`.
    pub acronym_style: AcronymStyleOptions,
    /// `dense` (`density` is `dense`).
    pub dense: bool,
    /// `linux`.
    pub linux: bool,
    /// `objcSupport`.
    pub objc_support: bool,
    /// `optionalEnums`.
    pub optional_enums: bool,
    /// `sendable`.
    pub sendable: bool,
    /// `multiFileOutput`.
    pub multi_file_output: bool,
    /// `accessLevel`.
    pub access_level: AccessLevel,
    /// `protocol`.
    pub protocol: SwiftProtocol,
}

impl SwiftOptions {
    /// `getOptionValues(swiftOptions, values)`: the options in declaration
    /// order; the first unknown enum value is an error.
    pub fn parse(values: &RendererOptions) -> Result<Self> {
        let just_types = JUST_TYPES.get_value(values);
        let convenience_initializers = CONVENIENCE_INITIALIZERS.get_value(values);
        let explicit_coding_keys = EXPLICIT_CODING_KEYS.get_value(values);
        let coding_keys_protocol = CODING_KEYS_PROTOCOL.get_value(values).into_owned();
        let alamofire = ALAMOFIRE.get_value(values);
        let named_type_prefix = NAMED_TYPE_PREFIX.get_value(values).into_owned();
        // The boolean-valued options are TS truthiness (an `Object.prototype`
        // member acts as `true`), the record-valued `protocol` has none of
        // the record's fields then.
        let use_classes = USE_CLASSES.get_flag(values, "class")?;
        let final_classes = FINAL_CLASSES.get_value(values);
        let mutable_properties = MUTABLE_PROPERTIES.get_value(values);
        // An `Object.prototype` member selects no style (`undefined`), so
        // `swiftNameStyle`'s default parameter, `allUpperWordStyle` (the
        // Pascal style), takes its place.
        let acronym_style =
            AcronymStyleOptions::from_enum_value(ACRONYM_STYLE.get_enum_value(values)?)
                .unwrap_or(AcronymStyleOptions::Pascal);
        let dense = DENSE.get_flag(values, "dense")?;
        let linux = LINUX.get_value(values);
        let objc_support = OBJC_SUPPORT.get_value(values);
        let optional_enums = OPTIONAL_ENUMS.get_value(values);
        let sendable = SENDABLE.get_value(values);
        let multi_file_output = MULTI_FILE_OUTPUT.get_value(values);
        let access_level = match ACCESS_LEVEL.get_enum_value(values)? {
            EnumValue::Declared("public") => AccessLevel::Public,
            EnumValue::Declared(_) => AccessLevel::Internal,
            EnumValue::Prototype(member) => AccessLevel::Other(member),
        };
        let protocol = match PROTOCOL.get_enum_value(values)? {
            EnumValue::Declared("equatable") => SwiftProtocol {
                equatable: true,
                hashable: false,
            },
            EnumValue::Declared("hashable") => SwiftProtocol {
                equatable: false,
                hashable: true,
            },
            _ => SwiftProtocol::default(),
        };
        Ok(SwiftOptions {
            just_types,
            convenience_initializers,
            explicit_coding_keys,
            coding_keys_protocol,
            alamofire,
            named_type_prefix,
            use_classes,
            final_classes,
            mutable_properties,
            acronym_style,
            dense,
            linux,
            objc_support,
            optional_enums,
            sendable,
            multi_file_output,
            access_level,
            protocol,
        })
    }
}

/// The `kind` argument of `getProtocolsArray`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum DeclarationKind {
    /// `"struct"`.
    Struct,
    /// `"class"`.
    Class,
    /// `"enum"`.
    Enum,
}

/// One entry of a property group of `getEnumPropertyGroups`: the name and,
/// unless the name already is the JSON name, the escaped JSON name.
type PropertyGroup = Vec<(Name, Option<String>)>;

/// `SwiftRenderer`.
pub struct SwiftRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    options: SwiftOptions,
    /// `_currentFilename`.
    current_filename: Option<String>,
    /// `_needAny`: set by `swiftType`, which only reads otherwise.
    need_any: Cell<bool>,
    /// `_needNull`: set by `swiftType`, which only reads otherwise.
    need_null: Cell<bool>,
}

impl std::fmt::Debug for SwiftRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("SwiftRenderer")
            .field("options", &self.options)
            .finish_non_exhaustive()
    }
}

impl<'a> SwiftRenderer<'a> {
    /// `new SwiftRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: SwiftOptions,
    ) -> Self {
        SwiftRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            options,
            current_filename: None,
            need_any: Cell::new(false),
            need_null: Cell::new(false),
        }
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

    /// `emitBlockWithAccess(line, f)`.
    fn emit_block_with_access(
        &mut self,
        line: impl Into<Source>,
        f: impl FnOnce(&mut Self) -> Result<()>,
    ) -> Result<()> {
        let access_level = self.access_level();
        self.emit_block(sl![access_level, line.into()], f)
    }

    /// `justTypesCase(justTypes, notJustTypes)`.
    fn just_types_case(&self, just_types: Source, not_just_types: Source) -> Source {
        if self.options.just_types {
            just_types
        } else {
            not_just_types
        }
    }

    /// `lowerNamingFunction`: a getter that makes a new namer on every
    /// access, so every property (and the member and case namers) gets
    /// its own naming group.
    fn lower_naming_function(&self) -> Namer {
        let style = acronym_style(self.options.acronym_style);
        fun_prefix_namer("lower", move |s| swift_name_style("", false, s, style))
    }

    /// `swiftPropertyType(p)`.
    fn swift_property_type(&self, p: &ClassProperty) -> Result<Source> {
        if p.is_optional
            || (self.options.optional_enums
                && self.type_graph().kind(p.type_ref)? == TypeKind::Enum)
        {
            return Ok(sl![self.swift_type(p.type_ref, true, true)?, "?"]);
        }
        self.swift_type(p.type_ref, true, false)
    }

    /// `swiftType(t, withIssues, noOptional)`.
    fn swift_type(&self, t: TypeRef, with_issues: bool, no_optional: bool) -> Result<Source> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let optional = if no_optional { "" } else { "?" };
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            Ok(match ty.kind() {
                TypeKind::Any => {
                    self.need_any.set(true);
                    maybe_annotated(
                        with_issues,
                        any_type_issue_annotation(),
                        self.just_types_case(sl!["Any", optional], "JSONAny".into()),
                    )
                }
                TypeKind::Null => {
                    self.need_null.set(true);
                    maybe_annotated(
                        with_issues,
                        null_type_issue_annotation(),
                        self.just_types_case("NSNull".into(), sl!["JSONNull", optional]),
                    )
                }
                TypeKind::Bool => "Bool".into(),
                TypeKind::Integer => "Int".into(),
                TypeKind::Double => "Double".into(),
                TypeKind::String => "String".into(),
                TypeKind::Array => sl!["[", self.swift_type(ty.items()?, with_issues, false)?, "]"],
                TypeKind::Class => self.name_for_named_type(t)?.into(),
                TypeKind::Map => sl![
                    "[String: ",
                    self.swift_type(ty.map_values()?, with_issues, false)?,
                    "]"
                ],
                TypeKind::Enum => self.name_for_named_type(t)?.into(),
                TypeKind::Union => {
                    if let Some(nullable) = nullable_from_union(graph, t)? {
                        return Ok(sl![
                            self.swift_type(nullable, with_issues, false)?,
                            optional
                        ]);
                    }
                    self.name_for_named_type(t)?.into()
                }
                TypeKind::DateTime => "Date".into(),
                TypeKind::Uuid => "UUID".into(),
                kind if kind.is_transformed_string_type_kind() => {
                    return panic(format!("Transformed string type {kind} not supported"));
                }
                kind => return match_type_unsupported(kind),
            })
        })
    }

    /// `renderSingleFileHeaderComments()`.
    fn render_single_file_header_comments(&mut self) -> Result<()> {
        self.emit_line_once(vec![
            "// This file was generated from JSON Schema using quicktype, do not modify it directly."
                .into(),
        ]);
        self.emit_line_once(vec![
            "// To parse the JSON, add this file to your project and do:".into(),
        ]);
        self.emit_line_once(vec!["//".into()]);
        self.for_each_top_level(BlankLinePosition::None, |r, t, top_level_name, _| {
            if r.options.convenience_initializers && r.type_graph().kind(t)? != TypeKind::Enum {
                r.emit_line_once(vec![
                    "//   let ".into(),
                    modify_source(camel_case, top_level_name),
                    " = try ".into(),
                    top_level_name.into(),
                    "(json)".into(),
                ]);
            } else {
                r.emit_line_once(vec![
                    "//   let ".into(),
                    modify_source(camel_case, top_level_name),
                    " = ".into(),
                    "try? JSONDecoder().decode(".into(),
                    top_level_name.into(),
                    ".self, from: jsonData)".into(),
                ]);
            }
            Ok(())
        })?;
        Ok(())
    }

    /// `renderHeader(type, name)`.
    fn render_header(&mut self, t: TypeRef, name: Name) -> Result<()> {
        if let Some(leading_comments) = self.leading_comments() {
            self.emit_comments(leading_comments)?;
        } else if !self.options.just_types {
            if self.options.multi_file_output {
                self.emit_line_once(vec![
                    "// This file was generated from JSON Schema using quicktype, do not modify it directly."
                        .into(),
                ]);
                self.emit_line_once(vec![
                    "// To parse the JSON, add this file to your project and do:".into(),
                ]);
                self.emit_line_once(vec!["//".into()]);
                if self.options.convenience_initializers
                    && self.type_graph().kind(t)? != TypeKind::Enum
                {
                    self.emit_line(sl![
                        "//   let ",
                        modify_source(camel_case, name),
                        " = try ",
                        name,
                        "(json)"
                    ]);
                } else {
                    self.emit_line(sl![
                        "//   let ",
                        modify_source(camel_case, name),
                        " = ",
                        "try? newJSONDecoder().decode(",
                        name,
                        ".self, from: jsonData)"
                    ]);
                }
            }

            if self.options.alamofire {
                self.emit_line("//");
                self.emit_line("// To parse values from Alamofire responses:");
                self.emit_line("//");
                self.emit_line(sl![
                    "//   Alamofire.request(url).response",
                    name,
                    " { response in"
                ]);
                self.emit_line(sl![
                    "//     if let ",
                    modify_source(camel_case, name),
                    " = response.result.value {"
                ]);
                self.emit_line("//       ...");
                self.emit_line("//     }");
                self.emit_line("//   }");
            }

            if self.options.protocol.hashable || self.options.protocol.equatable {
                self.emit_line("//");
                self.emit_line("// Hashable or Equatable:");
                self.emit_line(
                    "// The compiler will not be able to synthesize the implementation of Hashable or Equatable",
                );
                self.emit_line(
                    "// for types that require the use of JSONAny, nor will the implementation of Hashable be",
                );
                self.emit_line(
                    "// synthesized for types that have collections (such as arrays or dictionaries).",
                );
            }
        }

        self.ensure_blank_line();
        self.emit_line_once(vec!["import Foundation".into()]);
        if !self.options.just_types && self.options.alamofire {
            self.emit_line_once(vec!["import Alamofire".into()]);
        }

        if self.options.optional_enums {
            self.emit_line_once(vec![
                "import OptionallyDecodable // https://github.com/idrougge/OptionallyDecodable"
                    .into(),
            ]);
        }

        self.ensure_blank_line();
        Ok(())
    }

    /// `renderTopLevelAlias(t, name)`.
    fn render_top_level_alias(&mut self, t: TypeRef, name: Name) -> Result<()> {
        let access_level = self.access_level();
        let swift_type = self.swift_type(t, true, false)?;
        self.emit_line(sl![access_level, "typealias ", name, " = ", swift_type]);
        Ok(())
    }

    /// `getProtocolsArray(kind)`.
    fn get_protocols_array(&self, kind: DeclarationKind) -> Vec<&'static str> {
        let mut protocols: Vec<&'static str> = Vec::new();

        // [Michael Fey (@MrRooni), 2019-4-24] Technically NSObject isn't a "protocol" in this instance, but this felt like the best place to slot in this superclass declaration.
        let is_class = kind == DeclarationKind::Class;

        if is_class && self.options.objc_support {
            protocols.push("NSObject");
        }

        if !self.options.just_types {
            protocols.push("Codable");
        }

        if self.options.protocol.hashable {
            protocols.push("Hashable");
        }

        if self.options.protocol.equatable {
            protocols.push("Equatable");
        }

        if self.options.sendable && (!self.options.mutable_properties || !is_class) {
            protocols.push("Sendable");
        }

        protocols
    }

    /// `getProtocolString(kind, baseClass)`.
    fn get_protocol_string(
        &self,
        kind: DeclarationKind,
        base_class: Option<&'static str>,
    ) -> String {
        let mut protocols = self.get_protocols_array(kind);
        if let Some(base_class) = base_class.filter(|b| !b.is_empty()) {
            protocols.insert(0, base_class);
        }

        if protocols.is_empty() {
            String::new()
        } else {
            format!(": {}", protocols.join(", "))
        }
    }

    /// `getEnumPropertyGroups(c)`.
    fn get_enum_property_groups(&mut self, c: TypeRef) -> Result<Vec<PropertyGroup>> {
        let mut groups: Vec<PropertyGroup> = Vec::new();
        let mut group: PropertyGroup = Vec::new();

        self.for_each_class_property(c, BlankLinePosition::None, |r, name, json_name, _, _| {
            let label = string_escape(json_name);
            let redundant = r.sourcelike_to_string(&name.into())? == label;

            if r.options.dense && redundant {
                group.push((name, None));
            } else {
                if !group.is_empty() {
                    groups.push(std::mem::take(&mut group));
                }

                groups.push(vec![(name, Some(label))]);
            }
            Ok(())
        })?;

        if !group.is_empty() {
            groups.push(group);
        }

        Ok(groups)
    }

    /// `accessLevel`: the access level with a trailing space (e.g.
    /// `"public "`), or the empty string.
    fn access_level(&self) -> Cow<'static, str> {
        match self.options.access_level {
            // internal is default, so we don't have to emit it
            AccessLevel::Internal => Cow::Borrowed(""),
            AccessLevel::Public => Cow::Borrowed("public "),
            AccessLevel::Other(member) => Cow::Owned(format!("{member} ")),
        }
    }

    /// `objcMembersDeclaration`.
    fn objc_members_declaration(&self) -> &'static str {
        if self.options.objc_support {
            "@objcMembers "
        } else {
            ""
        }
    }

    /// `startFile(basename)`: appends `.swift` to the name and makes it the
    /// current file (with `--multi-file-output` only).
    fn start_file(&mut self, basename: impl Into<Source>) -> Result<()> {
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
        // FIXME: The filenames should actually be Sourcelikes, too
        let filename = format!("{}.swift", self.sourcelike_to_string(&basename.into())?);
        self.initialize_emit_context_for_filename(&filename);
        self.current_filename = Some(filename);
        Ok(())
    }

    /// `endFile()`: finishes the current file (with `--multi-file-output`
    /// only).
    fn end_file(&mut self) -> Result<()> {
        if !self.options.multi_file_output {
            return Ok(());
        }

        let filename = defined(self.current_filename.take())?;
        self.finish_file(&filename)
    }

    /// `propertyLinesDefinition(name, parameter)`.
    fn property_lines_definition(&self, name: Name, parameter: &ClassProperty) -> Result<Source> {
        let use_mutable_properties = self.options.mutable_properties;
        Ok(sl![
            self.access_level(),
            if use_mutable_properties {
                "var "
            } else {
                "let "
            },
            name,
            ": ",
            self.swift_property_type(parameter)?
        ])
    }

    /// The `emitLastProperty` closure of `renderClassDefinition` (dense
    /// output): the pending names, of one property type, on one line.
    fn emit_last_property(
        &mut self,
        last_property: &mut Option<ClassProperty>,
        last_names: &mut Vec<Name>,
    ) -> Result<()> {
        let Some(property) = last_property.take() else {
            return Ok(());
        };

        let use_mutable_properties = self.options.mutable_properties;
        let optional_enum = self.options.optional_enums
            && self.type_graph().kind(property.type_ref)? == TypeKind::Enum;

        let mut sources: Vec<Source> = vec![sl![
            if optional_enum {
                "@OptionallyDecodable "
            } else {
                ""
            },
            self.access_level(),
            if use_mutable_properties || optional_enum {
                "var "
            } else {
                "let "
            }
        ]];
        for (i, &n) in last_names.iter().enumerate() {
            if i > 0 {
                sources.push(", ".into());
            }
            sources.push(n.into());
        }
        sources.push(": ".into());
        sources.push(self.swift_property_type(&property)?);
        self.emit_line(Source::Sequence(sources));

        last_names.clear();
        Ok(())
    }

    /// The body of the class or struct in `renderClassDefinition`.
    fn render_class_body(&mut self, c: TypeRef, is_class: bool) -> Result<()> {
        if self.options.dense {
            let mut last_property: Option<ClassProperty> = None;
            let mut last_names: Vec<Name> = Vec::new();

            self.for_each_class_property(
                c,
                BlankLinePosition::None,
                |r, name, json_name, p, _| {
                    let description = r.description_for_class_property(c, json_name)?;
                    if last_property.is_some_and(|last| p != last)
                        || last_names.len() >= MAX_SAMELINE_PROPERTIES
                        || description.is_some()
                    {
                        r.emit_last_property(&mut last_property, &mut last_names)?;
                    }

                    if last_property.is_none() {
                        last_property = Some(p);
                    }

                    last_names.push(name);
                    if description.is_some() {
                        r.emit_description(description)?;
                        r.emit_last_property(&mut last_property, &mut last_names)?;
                    }
                    Ok(())
                },
            )?;
            self.emit_last_property(&mut last_property, &mut last_names)?;
        } else {
            self.for_each_class_property(
                c,
                BlankLinePosition::None,
                |r, name, json_name, p, _| {
                    let description = r.description_for_class_property(c, json_name)?;
                    let property_lines = r.property_lines_definition(name, &p)?;
                    r.emit_description(description)?;
                    r.emit_line(property_lines);
                    Ok(())
                },
            )?;
        }

        if !self.options.just_types && self.property_count(c)? == 0 {
            self.emit_line("private enum K: String, CodingKey { case unused }");
            self.emit_block_with_access("init(from decoder: Decoder) throws", |r| {
                r.emit_line("_ = try decoder.container(keyedBy: K.self)");
                Ok(())
            })?;
            if !is_class {
                self.emit_block_with_access("init()", |_| Ok(()))?;
            }
        }

        if !self.options.just_types {
            let groups = self.get_enum_property_groups(c)?;
            let all_properties_redundant = groups
                .iter()
                .all(|group| group.iter().all(|(_, label)| label.is_none()));
            if (!all_properties_redundant || !self.options.coding_keys_protocol.is_empty())
                && !self.type_graph().type_at(c)?.properties()?.is_empty()
            {
                self.ensure_blank_line();
                let mut enum_declaration = self.access_level().into_owned();
                enum_declaration.push_str("enum CodingKeys: String, CodingKey");
                if !self.options.coding_keys_protocol.is_empty() {
                    enum_declaration.push_str(", ");
                    enum_declaration.push_str(&self.options.coding_keys_protocol);
                }

                self.emit_block(enum_declaration, |r| {
                    for group in &groups {
                        let (name, label) = defined(group.first().cloned())?;
                        if let Some(label) = label {
                            r.emit_line(sl!["case ", name, " = \"", label, "\""]);
                        } else {
                            let mut names: Vec<Source> = Vec::new();
                            for (i, (n, _)) in group.iter().enumerate() {
                                if i > 0 {
                                    names.push(", ".into());
                                }
                                names.push(n.into());
                            }
                            r.emit_line(sl!["case ", Source::Sequence(names)]);
                        }
                    }
                    Ok(())
                })?;
            }
        }

        // this main initializer must be defined within the class
        // declaration since it assigns let constants
        if is_class
            // Public structs need explicit initializers
            // https://github.com/quicktype/quicktype/issues/899
            || self.options.access_level == AccessLevel::Public
        {
            // Make an initializer that initalizes all fields
            self.ensure_blank_line();
            let init_properties = self.initializable_properties(c)?;
            let mut properties_lines: Vec<Source> = vec!["init(".into()];
            for (i, property) in init_properties.iter().enumerate() {
                if i > 0 {
                    properties_lines.push(", ".into());
                }
                properties_lines.push(property.name.into());
                properties_lines.push(": ".into());
                properties_lines.push(self.swift_property_type(&property.parameter)?);
            }
            properties_lines.push(")".into());

            if self.property_count(c)? == 0 && self.options.objc_support {
                self.emit_block_with_access(sl!["override init()"], |_| Ok(()))?;
            } else {
                self.emit_block_with_access(Source::Sequence(properties_lines), |r| {
                    for property in &init_properties {
                        r.emit_line(sl!["self.", property.name, " = ", property.name]);
                    }
                    Ok(())
                })?;
            }
        }
        Ok(())
    }

    /// `renderClassDefinition(c, className)`.
    fn render_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        self.start_file(class_name)?;

        self.render_header(c, class_name)?;
        let description = self.description_for_type(c)?;
        self.emit_description(description)?;

        let class_name_string = self.sourcelike_to_string(&class_name.into())?;
        self.emit_mark(class_name_string.clone(), true);

        let is_class = self.options.use_classes || self.is_cycle_breaker_type(c)?;
        let struct_or_class = if is_class {
            DeclarationKind::Class
        } else {
            DeclarationKind::Struct
        };
        let final_prefix = if is_class
            && (self.options.final_classes
                || (self.options.sendable && !self.options.mutable_properties))
        {
            "final "
        } else {
            ""
        };

        if is_class && self.options.objc_support {
            // [Michael Fey (@MrRooni), 2019-4-24] Swift 5 or greater, must come before the access declaration for the class.
            let objc_members = self.objc_members_declaration();
            self.emit_item(objc_members);
        }

        let protocol_string = self.get_protocol_string(struct_or_class, None);
        self.emit_block_with_access(
            sl![
                final_prefix,
                if is_class { "class" } else { "struct" },
                " ",
                class_name,
                protocol_string
            ],
            |r| r.render_class_body(c, is_class),
        )?;

        // FIXME: We emit only the MARK line for top-level-enum.schema
        if !self.options.just_types && self.options.convenience_initializers {
            self.ensure_blank_line();
            self.emit_mark(
                format!("{class_name_string} convenience initializers and mutators"),
                false,
            );
            self.ensure_blank_line();
            self.emit_convenience_initializers_extension(c, class_name)?;
            self.ensure_blank_line();
        }

        self.end_file()
    }

    /// `initializableProperties(c)`.
    fn initializable_properties(&mut self, c: TypeRef) -> Result<Vec<SwiftProperty>> {
        let mut properties: Vec<SwiftProperty> = Vec::new();
        self.for_each_class_property(
            c,
            BlankLinePosition::None,
            |_, name, json_name, parameter, position| {
                properties.push(SwiftProperty {
                    json_name: json_name.to_owned(),
                    name,
                    parameter,
                    position,
                });
                Ok(())
            },
        )?;
        Ok(properties)
    }

    /// `emitNewEncoderDecoder()`.
    fn emit_new_encoder_decoder(&mut self) -> Result<()> {
        self.emit_block("func newJSONDecoder() -> JSONDecoder", |r| {
            r.emit_line("let decoder = JSONDecoder()");
            if !r.options.linux {
                r.emit_block(
                    "if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *)",
                    |r| {
                        r.emit_line("decoder.dateDecodingStrategy = .iso8601");
                        Ok(())
                    },
                )?;
            } else {
                r.emit_multiline(LINUX_DATE_DECODING)?;
            }

            r.emit_line("return decoder");
            Ok(())
        })?;
        self.ensure_blank_line();
        self.emit_block("func newJSONEncoder() -> JSONEncoder", |r| {
            r.emit_line("let encoder = JSONEncoder()");
            if !r.options.linux {
                r.emit_block(
                    "if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *)",
                    |r| {
                        r.emit_line("encoder.dateEncodingStrategy = .iso8601");
                        Ok(())
                    },
                )?;
            } else {
                r.emit_multiline(LINUX_DATE_ENCODING)?;
            }

            r.emit_line("return encoder");
            Ok(())
        })
    }

    /// The `init(_ json: String, ...)`, `init(fromURL:)`, `jsonData()` and
    /// `jsonString()` members shared by the convenience extensions;
    /// `convenience` prefixes the initializers.
    fn emit_json_string_and_url_initializers(&mut self, convenience: &'static str) -> Result<()> {
        self.ensure_blank_line();
        self.emit_block(
            sl![
                convenience,
                "init(_ json: String, using encoding: String.Encoding = .utf8) throws"
            ],
            |r| {
                r.emit_block("guard let data = json.data(using: encoding) else", |r| {
                    r.emit_line("throw NSError(domain: \"JSONDecoding\", code: 0, userInfo: nil)");
                    Ok(())
                })?;
                r.emit_line("try self.init(data: data)");
                Ok(())
            },
        )?;
        self.ensure_blank_line();
        self.emit_block(sl![convenience, "init(fromURL url: URL) throws"], |r| {
            r.emit_line("try self.init(data: try Data(contentsOf: url))");
            Ok(())
        })
    }

    /// The `jsonData()` and `jsonString(encoding:)` serializers.
    fn emit_json_serializers(&mut self) -> Result<()> {
        self.ensure_blank_line();
        self.emit_block("func jsonData() throws -> Data", |r| {
            r.emit_line("return try newJSONEncoder().encode(self)");
            Ok(())
        })?;
        self.ensure_blank_line();
        self.emit_block(
            "func jsonString(encoding: String.Encoding = .utf8) throws -> String?",
            |r| {
                r.emit_line("return String(data: try self.jsonData(), encoding: encoding)");
                Ok(())
            },
        )
    }

    /// `emitConvenienceInitializersExtension(c, className)`.
    fn emit_convenience_initializers_extension(
        &mut self,
        c: TypeRef,
        class_name: Name,
    ) -> Result<()> {
        let is_class = self.options.use_classes || self.is_cycle_breaker_type(c)?;
        let convenience = if is_class { "convenience " } else { "" };

        self.emit_block_with_access(sl!["extension ", class_name], |r| {
            if is_class {
                r.emit_block("convenience init(data: Data) throws", |r| {
                    let swift_type = r.swift_type(c, false, false)?;
                    if r.property_count(c)? > 0 {
                        r.emit_line(sl![
                            "let me = try newJSONDecoder().decode(",
                            swift_type,
                            ".self, from: data)"
                        ]);
                    } else {
                        r.emit_line(sl![
                            "let _ = try newJSONDecoder().decode(",
                            swift_type,
                            ".self, from: data)"
                        ]);
                    }

                    let mut args: Vec<Source> = vec!["self.init(".into()];
                    let mut first = true;
                    r.for_each_class_property(c, BlankLinePosition::None, |_, name, _, _, _| {
                        if !first {
                            args.push(", ".into());
                        }
                        first = false;
                        args.push(name.into());
                        args.push(": ".into());
                        args.push("me.".into());
                        args.push(name.into());
                        Ok(())
                    })?;
                    args.push(")".into());
                    r.emit_line_parts(args);
                    Ok(())
                })?;
            } else {
                r.emit_block("init(data: Data) throws", |r| {
                    let swift_type = r.swift_type(c, false, false)?;
                    r.emit_line(sl![
                        "self = try newJSONDecoder().decode(",
                        swift_type,
                        ".self, from: data)"
                    ]);
                    Ok(())
                })?;
            }

            r.emit_json_string_and_url_initializers(convenience)?;

            r.ensure_blank_line();
            r.emit_convenience_mutator(c, class_name)?;

            // Convenience serializers
            r.emit_json_serializers()
        })
    }

    /// `renderEnumDefinition(e, enumName)`.
    fn render_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        self.start_file(enum_name)?;

        self.emit_line_once(vec!["import Foundation".into()]);
        self.ensure_blank_line();

        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        let protocol_string = self.get_protocol_string(DeclarationKind::Enum, Some("String"));

        if self.options.just_types {
            self.emit_block_with_access(sl!["enum ", enum_name, protocol_string], |r| {
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                    r.emit_line(sl!["case ", name]);
                    Ok(())
                })
            })?;
        } else {
            self.emit_block_with_access(sl!["enum ", enum_name, protocol_string], |r| {
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                    r.emit_line(sl!["case ", name, " = \"", string_escape(json_name), "\""]);
                    Ok(())
                })
            })?;
        }

        self.end_file()
    }

    /// The `renderUnionCase` closure of `renderUnionDefinition`.
    fn render_union_case(&mut self, u: TypeRef, t: TypeRef) -> Result<()> {
        let swift_type = self.swift_type(t, false, false)?;
        self.emit_block(
            sl!["if let x = try? container.decode(", swift_type, ".self)"],
            |r| {
                let member_name = r.name_for_union_member(u, t)?;
                r.emit_line(sl!["self = .", member_name, "(x)"]);
                r.emit_line("return");
                Ok(())
            },
        )
    }

    /// `renderUnionDefinition(u, unionName)`.
    fn render_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        self.start_file(union_name)?;

        self.emit_line_once(vec!["import Foundation".into()]);
        self.ensure_blank_line();

        let description = self.description_for_type(u)?;
        self.emit_description(description)?;

        let indirect = if self.is_cycle_breaker_type(u)? {
            "indirect "
        } else {
            ""
        };
        let graph = self.type_graph();
        // `sortBy(t)`: classes first, then the other kinds by name.
        let mut sort_keys: std::collections::HashMap<TypeRef, String> =
            std::collections::HashMap::new();
        for &m in graph.type_at(u)?.members()? {
            let kind = graph.kind(m)?;
            let key = if kind == TypeKind::Class {
                kind.as_str().to_owned()
            } else {
                format!("_{kind}")
            };
            sort_keys.insert(m, key);
        }
        let sort_by = |t: TypeRef| sort_keys.get(&t).cloned().unwrap_or_default();
        let (maybe_null, non_nulls) =
            remove_null_from_union(graph, u, NullRemovalSort::By(&sort_by))?;
        let protocol_string = self.get_protocol_string(DeclarationKind::Enum, None);
        self.emit_block_with_access(sl![indirect, "enum ", union_name, protocol_string], |r| {
            r.for_each_union_member(
                u,
                Some(&non_nulls),
                BlankLinePosition::None,
                None,
                |r, name, t, _| {
                    let swift_type = r.swift_type(t, false, false)?;
                    r.emit_line(sl!["case ", name, "(", swift_type, ")"]);
                    Ok(())
                },
            )?;
            if let Some(null) = maybe_null {
                let null_name = r.name_for_union_member(u, null)?;
                r.emit_line(sl!["case ", null_name]);
            }

            if !r.options.just_types {
                r.ensure_blank_line();
                r.emit_block_with_access("init(from decoder: Decoder) throws", |r| {
                    r.emit_line("let container = try decoder.singleValueContainer()");
                    let graph = r.type_graph();
                    if let Some(bool_member) = find_member(graph, u, TypeKind::Bool)? {
                        r.render_union_case(u, bool_member)?;
                    }
                    if let Some(integer_member) = find_member(graph, u, TypeKind::Integer)? {
                        r.render_union_case(u, integer_member)?;
                    }
                    for &t in &non_nulls {
                        let kind = graph.kind(t)?;
                        if kind == TypeKind::Bool || kind == TypeKind::Integer {
                            continue;
                        }
                        r.render_union_case(u, t)?;
                    }

                    if let Some(null) = maybe_null {
                        r.emit_block("if container.decodeNil()", |r| {
                            let null_name = r.name_for_union_member(u, null)?;
                            r.emit_line(sl!["self = .", null_name]);
                            r.emit_line("return");
                            Ok(())
                        })?;
                    }

                    r.emit_decoding_error(union_name);
                    Ok(())
                })?;
                r.ensure_blank_line();
                r.emit_block_with_access("func encode(to encoder: Encoder) throws", |r| {
                    r.emit_line("var container = encoder.singleValueContainer()");
                    r.emit_line("switch self {");
                    r.for_each_union_member(
                        u,
                        Some(&non_nulls),
                        BlankLinePosition::None,
                        None,
                        |r, name, _, _| {
                            r.emit_line(sl!["case .", name, "(let x):"]);
                            r.indent(|r| {
                                r.emit_line("try container.encode(x)");
                                Ok(())
                            })
                        },
                    )?;
                    if let Some(null) = maybe_null {
                        let null_name = r.name_for_union_member(u, null)?;
                        r.emit_line(sl!["case .", null_name, ":"]);
                        r.indent(|r| {
                            r.emit_line("try container.encodeNil()");
                            Ok(())
                        })?;
                    }

                    r.emit_line("}");
                    Ok(())
                })?;
            }
            Ok(())
        })?;
        self.end_file()
    }

    /// `emitTopLevelMapAndArrayConvenienceInitializerExtensions(t, name)`.
    fn emit_top_level_map_and_array_convenience_initializer_extensions(
        &mut self,
        t: TypeRef,
        name: Name,
    ) -> Result<()> {
        let ty = self.type_graph().type_at(t)?;
        let extension_source = match ty.kind() {
            TypeKind::Array => sl!["Array where Element == ", name, ".Element"],
            TypeKind::Map => sl![
                "Dictionary where Key == String, Value == ",
                self.swift_type(ty.map_values()?, false, false)?
            ],
            _ => return Ok(()),
        };

        self.emit_block_with_access(sl!["extension ", extension_source], |r| {
            r.emit_block(sl!["init(data: Data) throws"], |r| {
                r.emit_line(sl![
                    "self = try newJSONDecoder().decode(",
                    name,
                    ".self, from: data)"
                ]);
                Ok(())
            })?;
            r.emit_json_string_and_url_initializers("")?;
            r.emit_json_serializers()
        })
    }

    /// `emitDecodingError(name)`.
    fn emit_decoding_error(&mut self, name: Name) {
        self.emit_line(sl![
            "throw DecodingError.typeMismatch(",
            name,
            ".self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: \"Wrong type for ",
            name,
            "\"))"
        ]);
    }

    /// `emitSupportFunctions4()`.
    fn emit_support_functions4(&mut self) -> Result<()> {
        self.start_file("JSONSchemaSupport")?;

        self.emit_line_once(vec!["import Foundation".into()]);

        self.for_each_top_level_where(
            BlankLinePosition::Leading,
            |r, t| Ok(r.named_type_to_name_for_top_level(t)?.is_none()),
            |r, t, name, _| r.render_top_level_alias(t, name),
        )?;

        if self.options.convenience_initializers {
            self.ensure_blank_line();
            self.for_each_top_level(BlankLinePosition::LeadingAndInterposing, |r, t, name, _| {
                r.emit_top_level_map_and_array_convenience_initializer_extensions(t, name)
            })?;
        }

        if (!self.options.just_types && self.options.convenience_initializers)
            || self.options.alamofire
        {
            self.ensure_blank_line();
            self.emit_mark("Helper functions for creating encoders and decoders", true);
            self.ensure_blank_line();
            self.emit_new_encoder_decoder()?;
        }

        if self.options.alamofire {
            self.ensure_blank_line();
            self.emit_mark("Alamofire response handlers", true);
            self.ensure_blank_line();
            self.emit_alamofire_extension()?;
        }

        // This assumes that this method is called after declarations
        // are emitted.
        if self.need_any.get() || self.need_null.get() {
            self.ensure_blank_line();
            self.emit_mark("Encode/decode helpers", true);
            self.ensure_blank_line();
            let is_final = self.options.final_classes || self.options.sendable;
            let final_prefix = if is_final { "final " } else { "" };
            let sendable = if self.options.sendable {
                ", Sendable"
            } else {
                ""
            };
            if self.options.objc_support {
                self.emit_line(sl![
                    self.objc_members_declaration(),
                    self.access_level(),
                    final_prefix,
                    "class JSONNull: NSObject, Codable",
                    sendable,
                    " {"
                ]);
            } else {
                self.emit_line(sl![
                    self.access_level(),
                    final_prefix,
                    "class JSONNull: Codable, Hashable",
                    sendable,
                    " {"
                ]);
            }

            self.ensure_blank_line();
            self.emit_multiline(JSON_NULL_EQUALS)?;

            if !self.options.objc_support {
                self.ensure_blank_line();
                self.emit_multiline(JSON_NULL_HASH)?;
            }

            self.ensure_blank_line();
            if self.options.objc_support {
                self.emit_item("    override ");
            } else {
                self.emit_item("    ");
            }

            self.emit_multiline(JSON_NULL_INIT)?;
        }

        if self.need_any.get() {
            self.ensure_blank_line();
            let final_prefix = if self.options.final_classes {
                "final "
            } else {
                ""
            };
            self.emit_multiline(&format!("{final_prefix}{JSON_CODING_KEY}"))?;

            self.ensure_blank_line();
            if self.options.objc_support {
                self.emit_line(sl![
                    self.objc_members_declaration(),
                    self.access_level(),
                    final_prefix,
                    "class JSONAny: NSObject, Codable {"
                ]);
            } else {
                self.emit_line(sl![
                    self.access_level(),
                    final_prefix,
                    "class JSONAny: Codable {"
                ]);
            }

            self.ensure_blank_line();
            let access_level = self.access_level();
            self.emit_multiline(&format!("    {access_level}{JSON_ANY}"))?;
        }

        self.end_file()
    }

    /// `emitConvenienceMutator(c, className)`.
    fn emit_convenience_mutator(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        let has_comma = |position: ForEachPosition| {
            position != ForEachPosition::Only && position != ForEachPosition::Last
        };
        self.emit_line("func with(");
        self.indent(|r| {
            r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, p, position| {
                let property_type = r.swift_property_type(&p)?;
                r.emit_line(sl![
                    name,
                    ": ",
                    property_type,
                    "? = nil",
                    if has_comma(position) { "," } else { "" }
                ]);
                Ok(())
            })
        })?;
        self.emit_block(sl![") -> ", class_name], |r| {
            r.emit_line(sl!["return ", class_name, "("]);
            r.indent(|r| {
                r.for_each_class_property(c, BlankLinePosition::None, |r, name, _, _, position| {
                    r.emit_line(sl![
                        name,
                        ": ",
                        name,
                        " ?? self.",
                        name,
                        if has_comma(position) { "," } else { "" }
                    ]);
                    Ok(())
                })
            })?;
            r.emit_line(")");
            Ok(())
        })
    }

    /// `emitMark(line, horizontalLine)`.
    fn emit_mark(&mut self, line: impl Into<Source>, horizontal_line: bool) {
        self.emit_line(sl![
            "// MARK:",
            if horizontal_line { " - " } else { " " },
            line.into()
        ]);
    }

    /// `emitAlamofireExtension()`.
    fn emit_alamofire_extension(&mut self) -> Result<()> {
        self.ensure_blank_line();
        self.emit_block_with_access("extension DataRequest", |r| {
            r.emit_multiline(ALAMOFIRE_SERIALIZERS)?;
            r.ensure_blank_line();
            r.for_each_top_level(BlankLinePosition::LeadingAndInterposing, |r, _, name, _| {
                r.emit_line("@discardableResult");
                r.emit_block(
                    sl![
                        "func response",
                        name,
                        "(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<",
                        name,
                        ">) -> Void) -> Self"
                    ],
                    |r| {
                        r.emit_line(
                            "return responseDecodable(queue: queue, completionHandler: completionHandler)",
                        );
                        Ok(())
                    },
                )
            })?;
            Ok(())
        })
    }
}

impl<'a> ConvenienceRenderer<'a> for SwiftRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        let mut names: Vec<String> = KEYWORDS.iter().map(|&k| k.to_owned()).collect();
        if self.options.alamofire {
            names.push("DataRequest".to_owned());
        }
        if self.options.protocol.equatable {
            names.push("Equatable".to_owned());
        }
        if self.options.sendable {
            names.push("Sendable".to_owned());
        }
        if self.options.objc_support {
            names.push("NSObject".to_owned());
        }
        Ok(names)
    }

    fn forbidden_for_object_properties(
        &mut self,
        c: TypeRef,
        _class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let mut names = vec!["fromURL".into(), "json".into()];
        if self.options.objc_support
            && (self.options.use_classes || self.is_cycle_breaker_type(c)?)
        {
            names.push("retain".into());
        }
        Ok(ForbiddenWordsInfo {
            names,
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

    fn make_named_type_namer(&mut self) -> Namer {
        let prefix = self.options.named_type_prefix.clone();
        let style = acronym_style(self.options.acronym_style);
        fun_prefix_namer("upper", move |s| swift_name_style(&prefix, true, s, style))
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(Some(self.lower_naming_function()))
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        Some(self.lower_naming_function())
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        Some(self.lower_naming_function())
    }

    fn is_implicit_cycle_breaker(&self, t: TypeRef) -> Result<bool> {
        let kind = self.type_graph().kind(t)?;
        Ok(kind == TypeKind::Array || kind == TypeKind::Map)
    }

    fn emit_description_block(&mut self, lines: &[Source]) -> Result<()> {
        self.emit_comment_lines(
            lines,
            &CommentOptions {
                line_start: Some("/// ".to_owned()),
                ..CommentOptions::default()
            },
        )
    }

    fn proposed_union_member_name_for_type_kind(&self, kind: TypeKind) -> Option<String> {
        match kind {
            TypeKind::Enum => Some("enumeration".to_owned()),
            TypeKind::Union => Some("one_of".to_owned()),
            _ => None,
        }
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        if !self.options.multi_file_output {
            self.render_single_file_header_comments()?;
        }

        self.for_each_named_type(
            BlankLinePosition::LeadingAndInterposing,
            |r, c, class_name, _| r.render_class_definition(c, class_name),
            |r, e, enum_name, _| r.render_enum_definition(e, enum_name),
            |r, u, union_name, _| r.render_union_definition(u, union_name),
        )?;

        if !self.options.just_types {
            self.emit_support_functions4()?;
        }
        Ok(())
    }
}

/// The Linux `decoder.dateDecodingStrategy` of `emitNewEncoderDecoder`.
const LINUX_DATE_DECODING: &str = r#"decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
	let container = try decoder.singleValueContainer()
	let dateStr = try container.decode(String.self)

	let formatter = DateFormatter()
	formatter.calendar = Calendar(identifier: .iso8601)
	formatter.locale = Locale(identifier: "en_US_POSIX")
	formatter.timeZone = TimeZone(secondsFromGMT: 0)
	formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
	if let date = formatter.date(from: dateStr) {
		return date
	}
	formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
	if let date = formatter.date(from: dateStr) {
		return date
	}
	throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
})"#;

/// The Linux `encoder.dateEncodingStrategy` of `emitNewEncoderDecoder`.
const LINUX_DATE_ENCODING: &str = r#"let formatter = DateFormatter()
formatter.calendar = Calendar(identifier: .iso8601)
formatter.locale = Locale(identifier: "en_US_POSIX")
formatter.timeZone = TimeZone(secondsFromGMT: 0)
formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
encoder.dateEncodingStrategy = .formatted(formatter)"#;

/// `JSONNull`'s `==`.
const JSON_NULL_EQUALS: &str = r#"    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}"#;

/// `JSONNull`'s `hash(into:)`.
const JSON_NULL_HASH: &str = r#"    public func hash(into hasher: inout Hasher) {
		hasher.combine(0)
	}"#;

/// `JSONNull`'s initializers and `encode(to:)`, after `"    "` or
/// `"    override "`.
const JSON_NULL_INIT: &str = r#"public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}"#;

/// `JSONCodingKey`, after the optional `"final "`.
const JSON_CODING_KEY: &str = r#"class JSONCodingKey: CodingKey {
	let key: String
	
	required init?(intValue: Int) {
		return nil
	}
	
	required init?(stringValue: String) {
		key = stringValue
	}
	
	var intValue: Int? {
		return nil
	}
	
	var stringValue: String {
		return key
	}
}"#;

/// The body of `JSONAny`, after `"    "` and the access level.
const JSON_ANY: &str = r#"let value: Any
	
	static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
		let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
		return DecodingError.typeMismatch(JSONAny.self, context)
	}
	
	static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
		let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
		return EncodingError.invalidValue(value, context)
	}

	static func decode(from container: SingleValueDecodingContainer) throws -> Any {
		if let value = try? container.decode(Bool.self) {
			return value
		}
		if let value = try? container.decode(Int64.self) {
			return value
		}
		if let value = try? container.decode(Double.self) {
			return value
		}
		if let value = try? container.decode(String.self) {
			return value
		}
		if container.decodeNil() {
			return JSONNull()
		}
		throw decodingError(forCodingPath: container.codingPath)
	}
	
	static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
		if let value = try? container.decode(Bool.self) {
			return value
		}
		if let value = try? container.decode(Int64.self) {
			return value
		}
		if let value = try? container.decode(Double.self) {
			return value
		}
		if let value = try? container.decode(String.self) {
			return value
		}
		if let value = try? container.decodeNil() {
			if value {
				return JSONNull()
			}
		}
		if var container = try? container.nestedUnkeyedContainer() {
			return try decodeArray(from: &container)
		}
		if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
			return try decodeDictionary(from: &container)
		}
		throw decodingError(forCodingPath: container.codingPath)
	}
	
	static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
		if let value = try? container.decode(Bool.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(Int64.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(Double.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(String.self, forKey: key) {
			return value
		}
		if let value = try? container.decodeNil(forKey: key) {
			if value {
				return JSONNull()
			}
		}
		if var container = try? container.nestedUnkeyedContainer(forKey: key) {
			return try decodeArray(from: &container)
		}
		if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
			return try decodeDictionary(from: &container)
		}
		throw decodingError(forCodingPath: container.codingPath)
	}
	
	static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
		var arr: [Any] = []
		while !container.isAtEnd {
			let value = try decode(from: &container)
			arr.append(value)
		}
		return arr
	}

	static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
		var dict = [String: Any]()
		for key in container.allKeys {
			let value = try decode(from: &container, forKey: key)
			dict[key.stringValue] = value
		}
		return dict
	}
	
	static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
		for value in array {
			if let value = value as? Bool {
				try container.encode(value)
			} else if let value = value as? Int64 {
				try container.encode(value)
			} else if let value = value as? Double {
				try container.encode(value)
			} else if let value = value as? String {
				try container.encode(value)
			} else if value is JSONNull {
				try container.encodeNil()
			} else if let value = value as? [Any] {
				var container = container.nestedUnkeyedContainer()
				try encode(to: &container, array: value)
			} else if let value = value as? [String: Any] {
				var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
				try encode(to: &container, dictionary: value)
			} else {
				throw encodingError(forValue: value, codingPath: container.codingPath)
			}
		}
	}
	
	static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
		for (key, value) in dictionary {
			let key = JSONCodingKey(stringValue: key)!
			if let value = value as? Bool {
				try container.encode(value, forKey: key)
			} else if let value = value as? Int64 {
				try container.encode(value, forKey: key)
			} else if let value = value as? Double {
				try container.encode(value, forKey: key)
			} else if let value = value as? String {
				try container.encode(value, forKey: key)
			} else if value is JSONNull {
				try container.encodeNil(forKey: key)
			} else if let value = value as? [Any] {
				var container = container.nestedUnkeyedContainer(forKey: key)
				try encode(to: &container, array: value)
			} else if let value = value as? [String: Any] {
				var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
				try encode(to: &container, dictionary: value)
			} else {
				throw encodingError(forValue: value, codingPath: container.codingPath)
			}
		}
	}

	static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
		if let value = value as? Bool {
			try container.encode(value)
		} else if let value = value as? Int64 {
			try container.encode(value)
		} else if let value = value as? Double {
			try container.encode(value)
		} else if let value = value as? String {
			try container.encode(value)
		} else if value is JSONNull {
			try container.encodeNil()
		} else {
			throw encodingError(forValue: value, codingPath: container.codingPath)
		}
	}
	
	public required init(from decoder: Decoder) throws {
		if var arrayContainer = try? decoder.unkeyedContainer() {
			self.value = try JSONAny.decodeArray(from: &arrayContainer)
		} else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
			self.value = try JSONAny.decodeDictionary(from: &container)
		} else {
			let container = try decoder.singleValueContainer()
			self.value = try JSONAny.decode(from: container)
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		if let arr = self.value as? [Any] {
			var container = encoder.unkeyedContainer()
			try JSONAny.encode(to: &container, array: arr)
		} else if let dict = self.value as? [String: Any] {
			var container = encoder.container(keyedBy: JSONCodingKey.self)
			try JSONAny.encode(to: &container, dictionary: dict)
		} else {
			var container = encoder.singleValueContainer()
			try JSONAny.encode(to: &container, value: self.value)
		}
	}
}"#;

/// The decodable response serializers of the Alamofire `DataRequest`
/// extension.
const ALAMOFIRE_SERIALIZERS: &str = r#"fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
	return DataResponseSerializer { _, response, data, error in
		guard error == nil else { return .failure(error!) }
		
		guard let data = data else {
			return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
		}
		
		return Result { try newJSONDecoder().decode(T.self, from: data) }
	}
}

@discardableResult
fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
	return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
}"#;
