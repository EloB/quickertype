//! Differential tests of the rendering framework on scenarios.
//!
//! Each `tests/fixtures/core-rendering/scenarios/*.txt` describes inputs and
//! renders in the language documented in
//! `xtask/core-rendering/run-render-scenarios.mjs`. That script ran them
//! against the reference implementation and recorded, in the matching
//! `*.json`, the type graph that reached name gathering and the result of
//! every render (files, issue annotations, console output, or the error).
//!
//! Renders use either a real language or `probe`, a test language whose
//! renderer is configured by the scenario (namers, forbidden names,
//! namespaces, dependency names, forward declarations, cycle breakers,
//! comment style) and runs the scenario's emit script. The TypeScript
//! `ProbeRenderer` in the script and [`ProbeRenderer`] here are twins: the
//! same hooks, the same script interpreter.

mod render_support;

use std::fs;
use std::path::Path;

use indexmap::IndexSet;
use quicktype_core::annotation::AnnotationData;
use quicktype_core::convenience_renderer::prelude::*;
use quicktype_core::convenience_renderer::{ConvenienceRendererCore, INFERRED_NAME_ORDER};
use quicktype_core::language::all::{ALL, language_named};
use quicktype_core::naming::NameStyle;
use quicktype_core::renderer_options::{RendererOption, RendererOptions};
use quicktype_core::support::comments::{Comment, CommentOptions};
use quicktype_core::support::strings::{
    NamingStyle, is_letter_or_underscore_or_digit, legalize_characters, make_name_style,
};
use quicktype_core::support::support::{capture_console, defined};
use quicktype_core::target_language::{LanguageConfig, MultiFileRenderResult, TargetLanguage};
use quicktype_core::ty::type_utils::directly_reachable_single_named_type;
use quicktype_js_compat::json::quote;
use render_support::{build_graph, err, first_difference, renderer_options};
use serde_json::Value;

// ---- Probe configuration -----------------------------------------------------

#[derive(Clone, Debug)]
struct NamerSpec {
    style: NamingStyle,
    /// `None`: the fun prefixes.
    prefixes: Option<Vec<String>>,
    ci: bool,
    fresh: bool,
}

#[derive(Clone, Debug)]
enum NamerChoice {
    Nothing,
    Types,
    Own(NamerSpec),
}

#[derive(Clone, Debug, Default)]
struct ProbeConfig {
    types: Option<NamerSpec>,
    props: Option<NamerSpec>,
    cases: Option<NamerChoice>,
    members: Option<NamerChoice>,
    keywords: Vec<String>,
    prop_forbid: Vec<String>,
    prop_forbid_class: bool,
    prop_global: bool,
    case_forbid: Vec<String>,
    case_global: bool,
    member_forbid: Vec<String>,
    member_global: bool,
    global_cases: bool,
    global_members: bool,
    fwd: bool,
    forward_kinds: Vec<String>,
    breakers: Vec<String>,
    can_break: Option<Vec<String>>,
    comment: Option<String>,
    splice: bool,
    all_unions_named: bool,
    top_level_reach: bool,
    top_level_dep: bool,
    type_dep: bool,
    case_dep: bool,
    member_kind: bool,
}

fn string_list(v: &Value) -> Vec<String> {
    v.as_array()
        .map(|a| {
            a.iter()
                .filter_map(|s| s.as_str().map(str::to_owned))
                .collect()
        })
        .unwrap_or_default()
}

fn namer_spec(v: &Value, default_style: &str) -> NamerSpec {
    let style = v["style"].as_str().unwrap_or(default_style);
    NamerSpec {
        style: NamingStyle::from_name(style).expect("naming style"),
        prefixes: match &v["prefixes"] {
            Value::Array(_) => Some(string_list(&v["prefixes"])),
            _ => None,
        },
        ci: v["ci"].as_bool().unwrap_or(false),
        fresh: v["fresh"].as_bool().unwrap_or(false),
    }
}

fn namer_choice(v: &Value, default_style: &str) -> NamerChoice {
    match v {
        Value::Null => NamerChoice::Nothing,
        Value::String(s) if s == "types" => NamerChoice::Types,
        _ => NamerChoice::Own(namer_spec(v, default_style)),
    }
}

impl ProbeConfig {
    fn parse(v: &Value) -> ProbeConfig {
        let flag = |k: &str| v[k].as_bool().unwrap_or(false);
        let get = |k: &str| v.get(k);
        ProbeConfig {
            types: Some(namer_spec(get("types").unwrap_or(&Value::Null), "pascal")),
            props: match get("props") {
                Some(Value::Null) => None,
                Some(p) => Some(namer_spec(p, "camel")),
                None => Some(namer_spec(&Value::Null, "camel")),
            },
            cases: Some(match get("cases") {
                Some(c) => namer_choice(c, "upper-underscore"),
                None => NamerChoice::Own(namer_spec(&Value::Null, "upper-underscore")),
            }),
            members: Some(match get("members") {
                Some(m) => namer_choice(m, "pascal"),
                None => NamerChoice::Own(namer_spec(&Value::Null, "pascal")),
            }),
            keywords: string_list(&v["keywords"]),
            prop_forbid: string_list(&v["propForbid"]),
            prop_forbid_class: flag("propForbidClass"),
            prop_global: flag("propGlobal"),
            case_forbid: string_list(&v["caseForbid"]),
            case_global: flag("caseGlobal"),
            member_forbid: string_list(&v["memberForbid"]),
            member_global: flag("memberGlobal"),
            global_cases: flag("globalCases"),
            global_members: flag("globalMembers"),
            fwd: flag("fwd"),
            forward_kinds: if v["forwardKinds"].is_array() {
                string_list(&v["forwardKinds"])
            } else {
                vec!["class".to_owned()]
            },
            breakers: string_list(&v["breakers"]),
            can_break: v["canBreak"]
                .is_array()
                .then(|| string_list(&v["canBreak"])),
            comment: v["comment"].as_str().map(str::to_owned),
            splice: flag("splice"),
            all_unions_named: flag("allUnionsNamed"),
            top_level_reach: flag("topLevelReach"),
            top_level_dep: flag("topLevelDep"),
            type_dep: flag("typeDep"),
            case_dep: flag("caseDep"),
            member_kind: flag("memberKind"),
        }
    }
}

fn make_namer(name: &str, spec: &NamerSpec) -> Namer {
    let style = make_name_style(
        spec.style,
        |s: &str| legalize_characters(s, is_letter_or_underscore_or_digit),
        None,
    );
    let style: NameStyle = std::rc::Rc::new(style);
    let prefixes: Vec<String> = match &spec.prefixes {
        Some(p) => p.clone(),
        None => quicktype_core::naming::FUN_PREFIXES
            .iter()
            .map(|s| s.to_string())
            .collect(),
    };
    Namer::new(name, move |s| style(s), prefixes, spec.ci)
}

// ---- The probe language --------------------------------------------------------

const PROBE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Probe",
    names: &["probe"],
    extension: "probe",
};

struct ProbeLanguage {
    config: ProbeConfig,
    script: Vec<String>,
}

impl TargetLanguage for ProbeLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &PROBE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        &[]
    }

    fn render(
        &self,
        render_context: RenderContext<'_>,
        _renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> Result<RenderResult> {
        let renderer = ProbeRenderer::new(self, render_context, &self.config, &self.script);
        render_with(renderer, given_output_filename, alphabetize_properties)
    }
}

struct ProbeRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    cfg: &'a ProbeConfig,
    script: &'a [String],
    deps: Vec<Name>,
    types_namer: Namer,
    props_namer: Option<Namer>,
    cases_namer: Option<Namer>,
    members_namer: Option<Namer>,
}

impl<'a> ProbeRenderer<'a> {
    fn new(
        language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        cfg: &'a ProbeConfig,
        script: &'a [String],
    ) -> Self {
        let types_namer = make_namer("types", cfg.types.as_ref().expect("types namer"));
        let props_namer = cfg.props.as_ref().map(|p| make_namer("props", p));
        let other = |name: &str, choice: &Option<NamerChoice>| match choice {
            Some(NamerChoice::Own(spec)) => Some(make_namer(name, spec)),
            Some(NamerChoice::Types) => Some(types_namer.clone()),
            _ => None,
        };
        let cases_namer = other("cases", &cfg.cases);
        let members_namer = other("members", &cfg.members);
        ProbeRenderer {
            core: ConvenienceRendererCore::new(language, render_context),
            cfg,
            script,
            deps: Vec::new(),
            types_namer,
            props_namer,
            cases_namer,
            members_namer,
        }
    }

    fn type_at(&self, index: &Value) -> Result<TypeRef> {
        let i = index.as_u64().ok_or_else(|| err("bad type index"))? as usize;
        defined(self.type_graph().all_types_unordered().nth(i))
    }

    fn sl(&self, v: &Value) -> Result<Source> {
        Ok(match v {
            Value::String(s) => Source::from(s.as_str()),
            Value::Array(items) => {
                Source::Sequence(items.iter().map(|x| self.sl(x)).collect::<Result<_>>()?)
            }
            Value::Object(o) => {
                if let Some(top) = o.get("top") {
                    self.core
                        .top_level_name(top.as_str().unwrap_or_default())?
                        .into()
                } else if let Some(t) = o.get("type") {
                    self.name_for_named_type(self.type_at(t)?)?.into()
                } else if let Some(p) = o.get("prop") {
                    let t = self.type_at(&p[0])?;
                    let json = p[1].as_str().unwrap_or_default();
                    defined(self.core.property_names(t)?.get(json).copied())?.into()
                } else if let Some(c) = o.get("case") {
                    let e = self.type_at(&c[0])?;
                    self.name_for_enum_case(e, c[1].as_str().unwrap_or_default())?
                        .into()
                } else if let Some(m) = o.get("member") {
                    let u = self.type_at(&m[0])?;
                    let t = self.type_at(&m[1])?;
                    self.name_for_union_member(u, t)?.into()
                } else if let Some(modifier) = o.get("mod") {
                    let inner = self.sl(&o["s"])?;
                    match modifier.as_str().unwrap_or_default() {
                        "upper" => modify_source(|s| s.to_uppercase(), inner),
                        "lower" => modify_source(|s| s.to_lowercase(), inner),
                        _ => modify_source(|s| format!("<{s}>"), inner),
                    }
                } else if let Some(message) = o.get("ann") {
                    annotated(
                        AnnotationData::issue(message.as_str().unwrap_or_default()),
                        self.sl(&o["s"])?,
                    )
                } else if let Some(n) = o.get("nl") {
                    Source::Newline(n.as_i64().unwrap_or(0) as i32)
                } else {
                    return Err(err(format!("bad sourcelike {v}")));
                }
            }
            _ => return Err(err(format!("bad sourcelike {v}"))),
        })
    }

    fn parts(&self, v: &Value) -> Result<Vec<Source>> {
        v.as_array()
            .ok_or_else(|| err("expected parts"))?
            .iter()
            .map(|x| self.sl(x))
            .collect()
    }

    fn comment(&self, c: &Value) -> Result<Comment> {
        if let Some(s) = c.as_str() {
            return Ok(Comment::String(s.to_owned()));
        }
        if let Some(lines) = c.get("lines") {
            return Ok(Comment::Lines(self.parts(lines)?));
        }
        if let Some(lines) = c.get("descriptionBlock") {
            return Ok(Comment::DescriptionBlock(self.parts(lines)?));
        }
        Ok(Comment::Custom {
            options: comment_options(c),
            custom_lines: self.parts(&c["customLines"])?,
        })
    }

    fn name_or_index(&self, t: TypeRef) -> Source {
        match self.core.try_name_for_named_type(t) {
            Some(name) => name.into(),
            None => format!("#{}", t.index()).into(),
        }
    }

    fn emit_default(&mut self) -> Result<()> {
        self.for_each_top_level(BlankLinePosition::None, |r, t, name, _| {
            let kind = r.type_graph().kind(t)?;
            r.emit_line(sl![
                "top ",
                name,
                " -> ",
                kind.as_str(),
                " #",
                t.index().to_string()
            ]);
            Ok(())
        })?;
        self.for_each_named_type(
            BlankLinePosition::Leading,
            |r, c, name, _| {
                let combined = r.type_graph().combined_name(c)?;
                r.emit_line(sl!["class ", name, " (", combined, ")"]);
                if r.cfg.props.is_none() {
                    return Ok(());
                }
                r.indent(|r| {
                    r.for_each_class_property(c, BlankLinePosition::None, |r, n, json, p, _| {
                        let optional = if p.is_optional { "?" } else { "" };
                        r.emit_line(sl![n, " <- ", quote(json), optional]);
                        Ok(())
                    })
                })
            },
            |r, e, name, _| {
                r.emit_line(sl!["enum ", name]);
                if r.cases_namer.is_none() {
                    return Ok(());
                }
                r.indent(|r| {
                    r.for_each_enum_case(e, BlankLinePosition::None, |r, n, json, _| {
                        r.emit_line(sl![n, " <- ", quote(json)]);
                        Ok(())
                    })
                })
            },
            |r, u, name, _| {
                r.emit_line(sl!["union ", name]);
                if r.members_namer.is_none() {
                    return Ok(());
                }
                r.indent(|r| {
                    r.for_each_union_member(u, None, BlankLinePosition::None, None, |r, n, t, _| {
                        let kind = r.type_graph().kind(t)?;
                        r.emit_line(sl![n, " <- ", kind.as_str()]);
                        Ok(())
                    })
                })
            },
        )?;
        for d in self.deps.clone() {
            self.emit_line(sl!["dependency ", d]);
        }
        Ok(())
    }

    fn run_script(&mut self, script: &[String]) -> Result<()> {
        let mut i = 0;
        let block = |i: &mut usize| -> Vec<String> {
            let start = *i;
            let mut depth = 0;
            while *i < script.len() {
                let op = script[*i].split(' ').next().unwrap_or_default();
                if ["indented", "annotate", "gathertwice"].contains(&op) {
                    depth += 1;
                }
                if op == "end" {
                    if depth == 0 {
                        break;
                    }
                    depth -= 1;
                }
                *i += 1;
            }
            let body = script[start..*i].to_vec();
            *i += 1;
            body
        };
        while i < script.len() {
            let line = &script[i];
            i += 1;
            let (op, arg) = match line.split_once(' ') {
                Some((op, rest)) => (
                    op,
                    serde_json::from_str::<Value>(rest).map_err(|e| err(e.to_string()))?,
                ),
                None => (line.as_str(), Value::Null),
            };
            match op {
                "default" => self.emit_default()?,
                "line" => {
                    let parts = self.parts(&arg)?;
                    self.emit_line_parts(parts);
                }
                "lineonce" => {
                    let parts = self.parts(&arg)?;
                    self.emit_line_once(parts);
                }
                "item" => {
                    let item = self.sl(&arg)?;
                    self.emit_item(item);
                }
                "blank" => self.ensure_blank_lines(arg.as_u64().unwrap_or(1) as usize),
                "prevent" => self.prevent_blank_line(),
                "indent" => self.change_indent(arg.as_i64().unwrap_or(0) as i32)?,
                "table" => {
                    let rows = arg
                        .as_array()
                        .ok_or_else(|| err("expected rows"))?
                        .iter()
                        .map(|row| self.parts(row))
                        .collect::<Result<_>>()?;
                    self.emit_table(rows);
                }
                "multiline" => self.emit_multiline(arg.as_str().unwrap_or_default())?,
                "finish" => self.finish_file(arg.as_str().unwrap_or_default())?,
                "reopen" => {
                    self.initialize_emit_context_for_filename(arg.as_str().unwrap_or_default())
                }
                "comments" => {
                    let comments = arg
                        .as_array()
                        .ok_or_else(|| err("expected comments"))?
                        .iter()
                        .map(|c| self.comment(c))
                        .collect::<Result<Vec<_>>>()?;
                    self.emit_comments(&comments)?;
                }
                "commentlines" => {
                    let lines = self.parts(&arg[0])?;
                    self.emit_comment_lines(&lines, &comment_options(&arg[1]))?;
                }
                "description" => {
                    let lines = self.parts(&arg)?;
                    self.emit_description(Some(lines))?;
                }
                "description-of" => {
                    let description = self.description_for_type(self.type_at(&arg)?)?;
                    self.emit_description(description)?;
                }
                "property-table" => {
                    let c = self.type_at(&arg)?;
                    self.emit_property_table(c, |_, name, json, p| {
                        let optional = if p.is_optional { "?" } else { "" };
                        Ok(vec![
                            name.into(),
                            ": ".into(),
                            quote(json).into(),
                            optional.into(),
                            ";".into(),
                        ])
                    })?;
                }
                "declarations" => {
                    self.for_each_declaration(BlankLinePosition::None, |r, decl, _| {
                        let kind = match decl.kind {
                            quicktype_core::declaration_ir::DeclarationKind::Forward => "forward",
                            quicktype_core::declaration_ir::DeclarationKind::Define => "define",
                        };
                        let name = r.name_or_index(decl.type_ref);
                        r.emit_line(sl![kind, " ", name]);
                        Ok(())
                    })?;
                }
                "cyclebreakers" => {
                    let types: Vec<TypeRef> = self.type_graph().all_types_unordered().collect();
                    for t in types {
                        if self.is_cycle_breaker_type(t)? {
                            let kind = self.type_graph().kind(t)?;
                            self.emit_line(sl![
                                "breaker #",
                                t.index().to_string(),
                                " ",
                                kind.as_str()
                            ]);
                        }
                    }
                }
                "foreach" => {
                    let what = arg[0].as_str().unwrap_or_default().to_owned();
                    let cfg = blank_line_config(&arg[1])?;
                    let emit = |label: &'static str| {
                        move |r: &mut Self, t: TypeRef, name: Name, pos: ForEachPosition| {
                            r.emit_line(sl![
                                label,
                                " ",
                                name,
                                " #",
                                t.index().to_string(),
                                " ",
                                position(pos)
                            ]);
                            Ok(())
                        }
                    };
                    match what.as_str() {
                        "toplevel" => {
                            self.for_each_top_level(cfg, emit("top"))?;
                        }
                        "object" => self.for_each_object(cfg, emit("object"))?,
                        "enum" => self.for_each_enum(cfg, emit("enum"))?,
                        "union" => self.for_each_union(cfg, emit("union"))?,
                        "named" => self.for_each_named_type(
                            cfg,
                            emit("object"),
                            emit("enum"),
                            emit("union"),
                        )?,
                        other => return Err(err(format!("bad foreach {other}"))),
                    }
                }
                "uniqueunions" => {
                    self.for_each_unique_union(
                        BlankLinePosition::Interposing,
                        |r, u| Ok(r.type_graph().type_at(u)?.members()?.len().to_string()),
                        |r, u, v, pos| {
                            let name = r.name_for_named_type(u)?;
                            r.emit_line(sl!["unique ", name, " ", v, " ", position(pos)]);
                            Ok(())
                        },
                    )?;
                }
                "foreachtype" => {
                    let order: IndexSet<usize> = self.for_each_type(|_, t| Ok(t.index()))?;
                    let text = order
                        .iter()
                        .map(|i| i.to_string())
                        .collect::<Vec<_>>()
                        .join(",");
                    self.emit_line(sl!["types ", text]);
                }
                "have" => {
                    let first = format!(
                        "unions={} maps={} optional={}",
                        self.have_unions()?,
                        self.have_maps()?,
                        self.have_optional_properties()?
                    );
                    let second = format!(
                        " namedUnions={} namedTypes={} enums={}",
                        self.have_named_unions()?,
                        self.have_named_types()?,
                        self.have_enums()?
                    );
                    self.emit_line(sl![first, second]);
                }
                "tostring" => {
                    let source = self.sl(&arg)?;
                    let text = self.sourcelike_to_string(&source)?;
                    self.emit_line(quote(&text));
                }
                "indented" => {
                    let body = block(&mut i);
                    self.indent(|r| r.run_script(&body))?;
                }
                "annotate" => {
                    let body = block(&mut i);
                    let message = arg.as_str().unwrap_or_default().to_owned();
                    self.emit_annotated(AnnotationData::issue(message), |r| r.run_script(&body))?;
                }
                "gathertwice" => {
                    let body = block(&mut i);
                    let items = self.gather_source(|r| r.run_script(&body))?;
                    self.emit_gathered_source(items.clone());
                    self.emit_gathered_source(items);
                }
                other => return Err(err(format!("unknown script command {other}"))),
            }
        }
        Ok(())
    }
}

fn position(pos: ForEachPosition) -> &'static str {
    match pos {
        ForEachPosition::First => "first",
        ForEachPosition::Last => "last",
        ForEachPosition::Middle => "middle",
        ForEachPosition::Only => "only",
    }
}

fn blank_line_position(s: &str) -> Result<BlankLinePosition> {
    Ok(match s {
        "none" => BlankLinePosition::None,
        "interposing" => BlankLinePosition::Interposing,
        "leading" => BlankLinePosition::Leading,
        "leading-and-interposing" => BlankLinePosition::LeadingAndInterposing,
        other => return Err(err(format!("bad blank line position {other}"))),
    })
}

fn blank_line_config(v: &Value) -> Result<BlankLineConfig> {
    match v {
        Value::String(s) => Ok(blank_line_position(s)?.into()),
        Value::Array(a) => Ok((
            blank_line_position(a[0].as_str().unwrap_or_default())?,
            a[1].as_u64().unwrap_or(1) as usize,
        )
            .into()),
        _ => Err(err("bad blank line config")),
    }
}

fn comment_options(v: &Value) -> CommentOptions {
    let get = |k: &str| v.get(k).and_then(Value::as_str).map(str::to_owned);
    CommentOptions {
        after_comment: get("afterComment"),
        before_comment: get("beforeComment"),
        first_line_start: get("firstLineStart"),
        line_end: get("lineEnd"),
        line_start: get("lineStart"),
    }
}

fn has_kind(kinds: &[String], kind: TypeKind) -> bool {
    kinds.iter().any(|k| k == kind.as_str())
}

impl<'a> ConvenienceRenderer<'a> for ProbeRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.types_namer.clone()
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(match &self.cfg.props {
            None => None,
            Some(spec) if spec.fresh => Some(make_namer("props", spec)),
            Some(_) => self.props_namer.clone(),
        })
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        self.members_namer.clone()
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        self.cases_namer.clone()
    }

    fn forbidden_names_for_global_namespace(&mut self) -> Result<Vec<String>> {
        Ok(self.cfg.keywords.clone())
    }

    fn forbidden_for_object_properties(
        &mut self,
        _o: TypeRef,
        class_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        let mut names: Vec<ForbiddenWord> = self
            .cfg
            .prop_forbid
            .iter()
            .map(|s| s.as_str().into())
            .collect();
        if self.cfg.prop_forbid_class {
            names.push(class_name.into());
        }
        Ok(ForbiddenWordsInfo {
            names,
            include_global_forbidden: self.cfg.prop_global,
        })
    }

    fn forbidden_for_union_members(
        &mut self,
        _u: TypeRef,
        _union_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: self
                .cfg
                .member_forbid
                .iter()
                .map(|s| s.as_str().into())
                .collect(),
            include_global_forbidden: self.cfg.member_global,
        })
    }

    fn forbidden_for_enum_cases(
        &mut self,
        _e: TypeRef,
        _enum_name: Name,
    ) -> Result<ForbiddenWordsInfo> {
        Ok(ForbiddenWordsInfo {
            names: self
                .cfg
                .case_forbid
                .iter()
                .map(|s| s.as_str().into())
                .collect(),
            include_global_forbidden: self.cfg.case_global,
        })
    }

    fn union_members_in_global_namespace(&self) -> bool {
        self.cfg.global_members
    }

    fn enum_cases_in_global_namespace(&self) -> bool {
        self.cfg.global_cases
    }

    fn needs_type_declaration_before_use(&self) -> bool {
        self.cfg.fwd
    }

    fn can_be_forward_declared(&self, t: TypeRef) -> Result<bool> {
        Ok(has_kind(
            &self.cfg.forward_kinds,
            self.type_graph().kind(t)?,
        ))
    }

    fn is_implicit_cycle_breaker(&self, t: TypeRef) -> Result<bool> {
        Ok(has_kind(&self.cfg.breakers, self.type_graph().kind(t)?))
    }

    fn can_break_cycles(&self, t: TypeRef) -> Result<bool> {
        Ok(match &self.cfg.can_break {
            None => true,
            Some(kinds) => has_kind(kinds, self.type_graph().kind(t)?),
        })
    }

    fn comment_line_start(&self) -> &'static str {
        match self.cfg.comment.as_deref() {
            Some("/// ") => "/// ",
            Some("# ") => "# ",
            Some("-- ") => "-- ",
            _ => "// ",
        }
    }

    fn comment_lines_splice_on_backslash(&self) -> bool {
        self.cfg.splice
    }

    fn union_needs_name(&self, u: TypeRef) -> Result<bool> {
        if self.cfg.all_unions_named {
            return Ok(true);
        }
        Ok(quicktype_core::ty::type_utils::nullable_from_union(self.type_graph(), u)?.is_none())
    }

    fn named_type_to_name_for_top_level(&self, t: TypeRef) -> Result<Option<TypeRef>> {
        if self.cfg.top_level_reach {
            return directly_reachable_single_named_type(self.type_graph(), t);
        }
        defaults::named_type_to_name_for_top_level(self, t)
    }

    fn make_top_level_dependency_names(&mut self, _t: TypeRef, name: Name) -> Result<Vec<Name>> {
        if !self.cfg.top_level_dep {
            return Ok(Vec::new());
        }
        let namer = self.types_namer.clone();
        let d = self.naming_mut().dependency_name(
            Some(&namer),
            quicktype_core::convenience_renderer::TOP_LEVEL_NAME_ORDER,
            move |lookup| format!("unmarshal_{}", lookup(name)),
        );
        self.deps.push(d);
        Ok(vec![d])
    }

    fn make_named_type_dependency_names(&mut self, _t: TypeRef, name: Name) -> Result<Vec<Name>> {
        if !self.cfg.type_dep {
            return Ok(Vec::new());
        }
        let namer = self.types_namer.clone();
        let d = self.naming_mut().dependency_name(
            Some(&namer),
            INFERRED_NAME_ORDER * 2,
            move |lookup| format!("{}_extensions", lookup(name)),
        );
        self.deps.push(d);
        Ok(vec![d])
    }

    fn make_name_for_enum_case(
        &mut self,
        e: TypeRef,
        enum_name: Name,
        case_name: &str,
        assigned_name: Option<&str>,
    ) -> Result<Name> {
        if !self.cfg.case_dep {
            return defaults::make_name_for_enum_case(self, e, enum_name, case_name, assigned_name);
        }
        let namer = self.cases_namer.clone();
        let order = if assigned_name.is_none() { 20 } else { 10 };
        let proposed = assigned_name.unwrap_or(case_name).to_owned();
        Ok(self
            .naming_mut()
            .dependency_name(namer.as_ref(), order, move |lookup| {
                format!("{proposed}_{}", lookup(enum_name))
            }))
    }

    fn proposed_union_member_name_for_type_kind(&self, kind: TypeKind) -> Option<String> {
        (self.cfg.member_kind && kind != TypeKind::Class)
            .then(|| format!("{}_value", kind.as_str()))
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        let script = self.script;
        self.run_script(script)
    }
}

// ---- Running the scenarios -------------------------------------------------------

fn leading_comments(v: &Value) -> Option<Vec<Comment>> {
    let comments = v.as_array()?;
    Some(
        comments
            .iter()
            .map(|c| {
                if let Some(s) = c.as_str() {
                    return Comment::String(s.to_owned());
                }
                let lines = |k: &str| -> Vec<Source> {
                    c[k].as_array()
                        .map(|a| {
                            a.iter()
                                .filter_map(|l| l.as_str().map(Source::from))
                                .collect()
                        })
                        .unwrap_or_default()
                };
                if c.get("lines").is_some() {
                    Comment::Lines(lines("lines"))
                } else if c.get("descriptionBlock").is_some() {
                    Comment::DescriptionBlock(lines("descriptionBlock"))
                } else {
                    Comment::Custom {
                        options: comment_options(c),
                        custom_lines: lines("customLines"),
                    }
                }
            })
            .collect(),
    )
}

fn render(fixture: &Value, render: &Value) -> Result<MultiFileRenderResult> {
    let mut graph = build_graph(&fixture["graph"])?;
    let gather = &fixture["gather"];
    quicktype_core::attributes::type_names::init_type_names();
    for _ in 0..gather["randomNames"].as_u64().unwrap_or(0) {
        let _ = quicktype_core::attributes::type_names::TooManyTypeNames::new(0, None);
    }
    quicktype_core::gather_names::gather_names(
        &mut graph,
        gather["destructive"].as_bool().unwrap_or(false),
        false,
    )?;

    let lang = render["lang"].as_str().unwrap_or_default();
    let probe;
    let language: &dyn TargetLanguage = if lang == "probe" {
        probe = ProbeLanguage {
            config: ProbeConfig::parse(&render["probe"]),
            script: render["script"]
                .as_array()
                .map(|a| {
                    a.iter()
                        .filter_map(|s| s.as_str().map(str::to_owned))
                        .collect()
                })
                .unwrap_or_default(),
        };
        &probe
    } else {
        language_named(lang, &ALL).ok_or_else(|| err(format!("unknown language {lang}")))?
    };
    let comments = leading_comments(&render["leadingComments"]);
    language.render_graph_and_serialize(
        &graph,
        render["filename"].as_str().unwrap_or_default(),
        render["alphabetize"].as_bool().unwrap_or(false),
        comments.as_deref(),
        &renderer_options(&render["rendererOptions"])?,
        render["indentation"].as_str(),
    )
}

fn check_render(fixture: &Value, r: &Value) -> std::result::Result<(), String> {
    let (result, console) = capture_console(|| render(fixture, r));
    let expected_console: Vec<String> = string_list(&r["console"]);
    if console != expected_console {
        return Err(format!(
            "console {console:?}, expected {expected_console:?}"
        ));
    }
    let result = match (result, r["error"].as_str()) {
        (Err(e), Some(expected)) if e.user_message() == expected => return Ok(()),
        (Err(e), Some(expected)) => {
            return Err(format!(
                "error {:?}, expected {expected:?}",
                e.user_message()
            ));
        }
        (Err(e), None) => return Err(format!("unexpected error {:?}", e.user_message())),
        (Ok(_), Some(expected)) => return Err(format!("no error, expected {expected:?}")),
        (Ok(result), None) => result,
    };
    let files = r["files"].as_array().ok_or("no files")?;
    let names: Vec<&str> = result.keys().map(String::as_str).collect();
    let expected_names: Vec<&str> = files.iter().filter_map(|f| f["name"].as_str()).collect();
    if names != expected_names {
        return Err(format!("files {names:?}, expected {expected_names:?}"));
    }
    for file in files {
        let name = file["name"].as_str().unwrap_or_default();
        let expected = file["text"].as_str().unwrap_or_default();
        let actual = result[name].lines.join("\n");
        if actual != expected {
            return Err(format!(
                "{name} differs at {}",
                first_difference(expected, &actual)
            ));
        }
        let annotations: Vec<Value> = result[name]
            .annotations
            .iter()
            .map(|a| {
                serde_json::json!([
                    a.annotation.message(),
                    a.span.start.line,
                    a.span.start.column,
                    a.span.end.line,
                    a.span.end.column
                ])
            })
            .collect();
        if Some(&annotations) != file["annotations"].as_array() {
            return Err(format!(
                "{name}: annotations {annotations:?}, expected {:?}",
                file["annotations"]
            ));
        }
    }
    Ok(())
}

#[test]
fn render_scenarios_match_reference() {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/core-rendering/scenarios");
    let mut entries: Vec<_> = fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().and_then(|e| e.to_str()) == Some("json"))
        .collect();
    entries.sort();
    let mut total = 0;
    let mut failures = Vec::new();
    for path in entries {
        let fixture: Value = serde_json::from_str(&fs::read_to_string(&path).unwrap()).unwrap();
        let id = fixture["id"].as_str().unwrap_or_default().to_owned();
        for (i, r) in fixture["renders"].as_array().unwrap().iter().enumerate() {
            total += 1;
            if let Err(message) = check_render(&fixture, r) {
                failures.push(format!("{id} render #{i} ({}): {message}", r["lang"]));
            }
        }
    }
    println!(
        "render scenarios: {} of {total} renders match the reference",
        total - failures.len()
    );
    assert!(total > 0, "no scenarios found");
    assert!(
        failures.is_empty(),
        "{} of {total} render(s) differ:\n{}",
        failures.len(),
        failures.join("\n")
    );
}
