//! Differential tests of the type graph against the TypeScript reference.
//!
//! Each `tests/fixtures/core-type-graph/scenarios/*.txt` is a small program
//! in the scenario language documented in
//! `xtask/core-type-graph/run-scenarios.mjs`, which ran it against the
//! reference implementation and recorded its output (graph prints, debug
//! reconstitution logs, errors) in the matching `*.expected` file. This test
//! interprets the same programs with the Rust port and compares the output
//! byte for byte. Node is not needed to run it.

use std::cell::RefCell;
use std::collections::HashMap;
use std::fs;
use std::path::Path;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};
use quicktype_core::attributes::constraints::{
    MinMaxConstraint, MinMaxLengthTypeAttributeKind, MinMaxTypeAttributeKind,
    PatternTypeAttributeKind,
};
use quicktype_core::attributes::default_value::{DefaultValue, DefaultValueTypeAttributeKind};
use quicktype_core::attributes::description::DescriptionTypeAttributeKind;
use quicktype_core::attributes::string_types::StringTypes;
use quicktype_core::attributes::type_attributes::{
    AttributeKind, CombinationKind, TypeAttributes, combine_type_attributes,
};
use quicktype_core::attributes::type_names::{
    NamesTypeAttributeKind, TypeNames, init_type_names, make_names_type_attributes,
};
use quicktype_core::graph_rewriting::make_replacer;
use quicktype_core::messages::{QuickTypeError, Result};
use quicktype_core::support::support::set_console_sink;
use quicktype_core::ty::transformed_string_type::TypeKind;
use quicktype_core::ty::ty::ClassProperty;
use quicktype_core::ty::ty::structurally_compatible;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::{StringTypeMapping, get_no_string_type_mapping};
use quicktype_core::ty::type_graph::TypeGraph;
use quicktype_core::ty::type_graph_utils::{
    none_to_any, optional_to_nullable, remove_indirection_intersections,
};
use quicktype_core::ty::type_ref::TypeRef;
use quicktype_core::ty::type_utils::{
    NullRemovalSort, combine_type_attributes_of_types, directly_reachable_single_named_type,
    is_nullable, make_groups_to_flatten, remove_null_from_union, set_operation_members_recursively,
    union_is_canonical,
};
use quicktype_core::unify_classes::{unify_types, union_builder_for_unification};

fn err(message: impl Into<String>) -> QuickTypeError {
    QuickTypeError::internal(message)
}

fn parse_number(s: &str) -> Option<f64> {
    if s.is_empty() { None } else { s.parse().ok() }
}

fn parse_min_max(v: &str) -> MinMaxConstraint {
    let (lo, hi) = v.split_once(':').unwrap_or((v, ""));
    MinMaxConstraint(parse_number(lo), parse_number(hi))
}

struct Interpreter {
    vars: HashMap<String, TypeRef>,
    builder: Option<TypeBuilder<'static>>,
    graph: Option<TypeGraph>,
    out: Rc<RefCell<Vec<String>>>,
}

impl Interpreter {
    fn var(&self, name: &str) -> Result<TypeRef> {
        self.vars
            .get(name)
            .copied()
            .ok_or_else(|| err(format!("unknown variable {name}")))
    }

    fn builder(&mut self) -> Result<&mut TypeBuilder<'static>> {
        self.builder.as_mut().ok_or_else(|| err("no builder"))
    }

    fn graph(&self) -> Result<&TypeGraph> {
        self.graph.as_ref().ok_or_else(|| err("no graph"))
    }

    fn attributes(&self, tokens: &[&str]) -> Result<(TypeAttributes, Option<TypeRef>)> {
        let mut parts: Vec<TypeAttributes> = Vec::new();
        let mut fwd = None;
        for tok in tokens {
            let (key, v) = tok
                .split_once('=')
                .ok_or_else(|| err(format!("bad attribute {tok}")))?;
            match key {
                "n" => parts.push(make_names_type_attributes(v, false)),
                "in" => parts.push(make_names_type_attributes(v, true)),
                "many" => {
                    let (prefix, count) = v.split_once(':').unwrap_or((v, "0"));
                    let count: usize = count.parse().map_err(|_| err("bad count"))?;
                    let names: IndexSet<String> =
                        (0..count).map(|i| format!("{prefix}{i}")).collect();
                    parts.push(
                        NamesTypeAttributeKind.make_attributes(TypeNames::make(names, None, true)),
                    );
                }
                "desc" => parts.push(
                    DescriptionTypeAttributeKind
                        .make_attributes([v.to_owned()].into_iter().collect()),
                ),
                "mm" => parts.push(MinMaxTypeAttributeKind.make_attributes(parse_min_max(v))),
                "ml" => parts.push(MinMaxLengthTypeAttributeKind.make_attributes(parse_min_max(v))),
                "pat" => parts.push(PatternTypeAttributeKind.make_attributes(v.to_owned())),
                "def" => {
                    let value = if v == "null" {
                        DefaultValue::Null
                    } else if let Some(s) = v.strip_prefix("s:") {
                        DefaultValue::String(s.to_owned())
                    } else if let Some(n) = v.strip_prefix("n:") {
                        DefaultValue::Number(n.parse().map_err(|_| err("bad number"))?)
                    } else if let Some(b) = v.strip_prefix("b:") {
                        DefaultValue::Bool(b == "true")
                    } else {
                        return Err(err(format!("bad default {v}")));
                    };
                    parts.push(DefaultValueTypeAttributeKind.make_attributes(value));
                }
                "fwd" => fwd = Some(self.var(v)?),
                _ => return Err(err(format!("unknown attribute {tok}"))),
            }
        }
        let refs: Vec<&TypeAttributes> = parts.iter().collect();
        Ok((combine_type_attributes(CombinationKind::Union, &refs)?, fwd))
    }

    fn props(&self, spec: &str) -> Result<IndexMap<String, ClassProperty>> {
        let mut props = IndexMap::new();
        if spec == "-" || spec == "{}" {
            return Ok(props);
        }
        for p in spec.split(',') {
            let (name, v) = p
                .split_once(':')
                .ok_or_else(|| err(format!("bad property {p}")))?;
            let (name, optional) = match name.strip_suffix('?') {
                Some(n) => (n, true),
                None => (name, false),
            };
            props.insert(name.to_owned(), ClassProperty::new(self.var(v)?, optional));
        }
        Ok(props)
    }

    fn members(&self, spec: &str) -> Result<IndexSet<TypeRef>> {
        if spec == "-" {
            return Ok(IndexSet::new());
        }
        spec.split(',').map(|v| self.var(v)).collect()
    }

    fn set_graph(&mut self, result: Option<TypeGraph>, label: &str) {
        match result {
            Some(g) => self.graph = Some(g),
            None => self.out.borrow_mut().push(format!("({label}: unchanged)")),
        }
    }

    fn command(&mut self, cmd: &str, args: &[&str]) -> Result<()> {
        let flag = |f: &str| args.contains(&f);
        let debug = flag("debug");
        let arg = |i: usize| -> Result<&str> {
            args.get(i)
                .copied()
                .ok_or_else(|| err(format!("missing argument {i} of {cmd}")))
        };
        match cmd {
            "builder" => {
                let stm = if flag("stm=string") {
                    StringTypeMapping::new()
                } else {
                    get_no_string_type_mapping()
                };
                self.builder = Some(TypeBuilder::new(
                    stm,
                    flag("alpha"),
                    flag("allopt"),
                    flag("prov"),
                    false,
                )?);
            }
            "reserve" => {
                let r = self.builder()?.reserve_type_ref()?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "prim" => {
                let kind = TypeKind::from_str(arg(1)?).ok_or_else(|| err("bad kind"))?;
                let (a, fwd) = self.attributes(&args[2..])?;
                let r = self.builder()?.get_primitive_type(kind, a, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "str" => {
                let (a, fwd) = self.attributes(&args[2..])?;
                let spec = arg(1)?;
                let st = if spec == "unrestricted" {
                    StringTypes::unrestricted()
                } else {
                    let cases: IndexMap<String, u64> = spec
                        .trim_start_matches("cases=")
                        .split(',')
                        .map(|c| {
                            let (k, n) = c.split_once(':').unwrap_or((c, "1"));
                            (k.to_owned(), n.parse().unwrap_or(1))
                        })
                        .collect();
                    StringTypes::new(Some(cases), IndexSet::new())?
                };
                let r = self.builder()?.get_string_type(a, Some(st), fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "enum" => {
                let (a, fwd) = self.attributes(&args[2..])?;
                let cases = arg(1)?.split(',').map(str::to_owned).collect();
                let r = self.builder()?.get_enum_type(a, cases, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "arr" => {
                let (a, fwd) = self.attributes(&args[2..])?;
                let items = self.var(arg(1)?)?;
                let r = self.builder()?.get_array_type(a, items, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "uarr" => {
                let (a, fwd) = self.attributes(&args[1..])?;
                let r = self.builder()?.get_unique_array_type(a, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "items" => {
                let (a, items) = (self.var(arg(0)?)?, self.var(arg(1)?)?);
                self.builder()?.set_array_items(a, items)?;
            }
            "cls" => {
                let (a, fwd) = self.attributes(&args[2..])?;
                let props = self.props(arg(1)?)?;
                let r = self.builder()?.get_class_type(a, props, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "ucls" => {
                let (a, fwd) = self.attributes(&args[3..])?;
                let props = if arg(2)? == "-" {
                    None
                } else {
                    Some(self.props(arg(2)?)?)
                };
                let fixed = arg(1)? == "fixed";
                let r = self
                    .builder()?
                    .get_unique_class_type(a, fixed, props, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "props" => {
                let t = self.var(arg(0)?)?;
                let props = self.props(arg(1)?)?;
                let additional = match args.get(2) {
                    None => None,
                    Some(v) => Some(self.var(v)?),
                };
                self.builder()?
                    .set_object_properties(t, props, additional)?;
            }
            "map" => {
                let (a, fwd) = self.attributes(&args[2..])?;
                let values = self.var(arg(1)?)?;
                let r = self.builder()?.get_map_type(a, values, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "umap" => {
                let (_, fwd) = self.attributes(&args[1..])?;
                let r = self.builder()?.get_unique_map_type(fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "obj" => {
                let (a, fwd) = self.attributes(&args[3..])?;
                let props = if arg(1)? == "-" {
                    None
                } else {
                    Some(self.props(arg(1)?)?)
                };
                let additional = if arg(2)? == "-" {
                    None
                } else {
                    Some(self.var(arg(2)?)?)
                };
                let r = self
                    .builder()?
                    .get_unique_object_type(a, props, additional, fwd)?;
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "union" | "inter" => {
                let (a, fwd) = self.attributes(&args[2..])?;
                let members = self.members(arg(1)?)?;
                let b = self.builder()?;
                let r = if cmd == "union" {
                    b.get_union_type(a, members, fwd)?
                } else {
                    b.get_intersection_type(a, members, fwd)?
                };
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "uunion" | "uinter" => {
                let (a, fwd) = self.attributes(&args[1..])?;
                let b = self.builder()?;
                let r = if cmd == "uunion" {
                    b.get_unique_union_type(a, None, fwd)?
                } else {
                    b.get_unique_intersection_type(a, None, fwd)?
                };
                self.vars.insert(arg(0)?.to_owned(), r);
            }
            "members" => {
                let t = self.var(arg(0)?)?;
                let members = self.members(arg(1)?)?;
                self.builder()?.set_set_operation_members(t, members)?;
            }
            "top" => {
                let t = self.var(arg(1)?)?;
                self.builder()?.add_top_level(arg(0)?, t)?;
            }
            "finish" => {
                let builder = self.builder.take().ok_or_else(|| err("no builder"))?;
                let added = builder.did_add_forwarding_intersection();
                let mut graph = builder.finish()?;
                if flag("printonrewrite") {
                    graph.set_print_on_rewrite();
                }
                self.graph = Some(graph);
                self.out
                    .borrow_mut()
                    .push(format!("(forwarding intersections: {added})"));
            }
            "print" => self.graph()?.print_graph()?,
            "gc" => {
                let g = self.graph()?.garbage_collect(flag("alpha"), debug)?;
                self.graph = Some(g);
            }
            "fixedpoint" => {
                let g = self.graph()?.rewrite_fixed_point(false, debug)?;
                self.set_graph(g, "fixedpoint");
            }
            "nonetoany" => {
                let g = none_to_any(self.graph()?, &get_no_string_type_mapping(), debug)?;
                self.set_graph(g, "nonetoany");
            }
            "opt2null" => {
                let g = optional_to_nullable(self.graph()?, &get_no_string_type_mapping(), debug)?;
                self.set_graph(g, "opt2null");
            }
            "rmind" => {
                let g = remove_indirection_intersections(
                    self.graph()?,
                    &get_no_string_type_mapping(),
                    debug,
                )?;
                self.set_graph(g, "rmind");
            }
            "unify" => {
                let graph = self.graph()?;
                let types: Vec<TypeRef> = graph.all_types_unordered().collect();
                let mut groups = Vec::new();
                for g in arg(0)?.split(';') {
                    let mut group = Vec::new();
                    for i in g.split(',') {
                        let i: usize = i.parse().map_err(|_| err("bad index"))?;
                        group.push(types[i]);
                    }
                    groups.push(group);
                }
                let conflate = flag("conflate");
                let make_objects = flag("objects");
                let replacer = make_replacer(move |ts, b, fwd| {
                    let original = b.original_graph()?;
                    let attributes = combine_type_attributes_of_types(
                        original,
                        CombinationKind::Union,
                        ts.iter().copied(),
                    )?;
                    let union_builder =
                        union_builder_for_unification(make_objects, false, conflate);
                    unify_types(ts, &attributes, b, &union_builder, conflate, Some(fwd))
                });
                let g = graph.rewrite(
                    "unify",
                    &get_no_string_type_mapping(),
                    flag("alpha"),
                    groups,
                    debug,
                    replacer,
                    false,
                )?;
                self.set_graph(g, "unify");
            }
            "remap" => {
                let graph = self.graph()?;
                let types: Vec<TypeRef> = graph.all_types_unordered().collect();
                let mut map = IndexMap::new();
                for p in arg(0)?.split(',') {
                    let (from, to) = p.split_once('>').ok_or_else(|| err("bad remap"))?;
                    let from: usize = from.parse().map_err(|_| err("bad index"))?;
                    let to: usize = to.parse().map_err(|_| err("bad index"))?;
                    map.insert(types[from], types[to]);
                }
                let g = graph.remap(
                    "remap",
                    &get_no_string_type_mapping(),
                    false,
                    map,
                    debug,
                    false,
                )?;
                self.set_graph(g, "remap");
            }
            "query" => {
                let result = self.query(args)?;
                self.out
                    .borrow_mut()
                    .push(format!("{}: {result}", args.join(" ")));
            }
            _ => return Err(err(format!("unknown command {cmd}"))),
        }
        Ok(())
    }

    fn query(&self, args: &[&str]) -> Result<String> {
        let graph = self.graph()?;
        let types: Vec<TypeRef> = graph.all_types_unordered().collect();
        let at = |i: &str| -> Result<TypeRef> {
            let i: usize = i.parse().map_err(|_| err("bad index"))?;
            types
                .get(i)
                .copied()
                .ok_or_else(|| err("index out of range"))
        };
        let list = |spec: &str| -> Result<Vec<TypeRef>> { spec.split(',').map(at).collect() };
        let indexes = |ts: &mut dyn Iterator<Item = TypeRef>| -> String {
            ts.map(|t| t.index().to_string())
                .collect::<Vec<_>>()
                .join(",")
        };
        let arg = |i: usize| -> Result<&str> {
            args.get(i).copied().ok_or_else(|| err("missing argument"))
        };
        Ok(match arg(0)? {
            "recmembers" => {
                let kind = match args.get(2).copied() {
                    None => None,
                    Some("union") => Some(CombinationKind::Union),
                    Some(_) => Some(CombinationKind::Intersect),
                };
                let (members, attributes) =
                    set_operation_members_recursively(graph, &list(arg(1)?)?, kind)?;
                let mut parts = Vec::new();
                for value in attributes.iter() {
                    if let Some(s) = value.stringify()? {
                        parts.push(s);
                    }
                }
                format!(
                    "{} | {}",
                    indexes(&mut members.into_iter()),
                    parts.join(" | ")
                )
            }
            "groups" => make_groups_to_flatten(graph, list(arg(1)?)?, None)?
                .into_iter()
                .map(|g| indexes(&mut g.into_iter()))
                .collect::<Vec<_>>()
                .join(";"),
            "compatible" => structurally_compatible(
                graph,
                at(arg(1)?)?,
                at(arg(2)?)?,
                args.get(3) == Some(&"conflate"),
            )?
            .to_string(),
            "canonical" => union_is_canonical(graph, at(arg(1)?)?)?.to_string(),
            "nullable" => is_nullable(graph, at(arg(1)?)?)?.to_string(),
            "named" => {
                let named = graph.all_named_types_separated()?;
                format!(
                    "objects {} enums {} unions {}",
                    indexes(&mut named.objects.into_iter()),
                    indexes(&mut named.enums.into_iter()),
                    indexes(&mut named.unions.into_iter())
                )
            }
            "parents" => indexes(&mut graph.parents_of_type(at(arg(1)?)?)?.iter().copied()),
            "nonnull" => {
                let (null_type, rest) =
                    remove_null_from_union(graph, at(arg(1)?)?, NullRemovalSort::ByKind)?;
                let null_text = null_type.map_or_else(|| "-".to_owned(), |t| t.index().to_string());
                format!("{null_text} | {}", indexes(&mut rest.into_iter()))
            }
            "reachable" => directly_reachable_single_named_type(graph, at(arg(1)?)?)?
                .map_or_else(|| "-".to_owned(), |t| t.index().to_string()),
            other => return Err(err(format!("unknown query {other}"))),
        })
    }
}

fn run_scenario(text: &str) -> String {
    init_type_names();
    let out = Rc::new(RefCell::new(Vec::<String>::new()));
    let sink = Rc::clone(&out);
    set_console_sink(Some(Box::new(move |line| {
        sink.borrow_mut().push(line.to_owned())
    })));
    let mut interpreter = Interpreter {
        vars: HashMap::new(),
        builder: None,
        graph: None,
        out: Rc::clone(&out),
    };
    for raw_line in text.lines() {
        let line = raw_line.split('#').next().unwrap_or("").trim();
        if line.is_empty() {
            continue;
        }
        let tokens: Vec<&str> = line.split_whitespace().collect();
        if let Err(e) = interpreter.command(tokens[0], &tokens[1..]) {
            out.borrow_mut()
                .push(format!("error: {}", e.user_message()));
            break;
        }
    }
    set_console_sink(None);
    let mut result = out.borrow().join("\n");
    result.push('\n');
    result
}

#[test]
fn scenarios_match_reference() {
    let dir =
        Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/core-type-graph/scenarios");
    let mut entries: Vec<_> = fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .collect();
    entries.sort();
    let mut failures = Vec::new();
    let mut count = 0;
    for path in entries {
        if path.extension().and_then(|e| e.to_str()) != Some("txt") {
            continue;
        }
        count += 1;
        let text = fs::read_to_string(&path).unwrap();
        let expected = fs::read_to_string(path.with_extension("expected")).unwrap();
        let actual = run_scenario(&text);
        if actual != expected {
            failures.push(format!(
                "{}:\n--- expected\n{expected}--- actual\n{actual}",
                path.file_name().unwrap().to_string_lossy()
            ));
        }
    }
    assert!(count > 0, "no scenarios found");
    assert!(
        failures.is_empty(),
        "{} scenario(s) differ:\n{}",
        failures.len(),
        failures.join("\n")
    );
}
