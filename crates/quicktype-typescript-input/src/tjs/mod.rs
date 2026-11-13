//! Port of `typescript-json-schema/dist/typescript-json-schema.js` (0.67.4),
//! restricted to the code paths quicktype's settings reach, and re-targeted
//! from the TypeScript 5.9 compiler API to the TypeScript 7 checker API.
//!
//! quicktype calls it with `required`, `titles`, `topRef`, `noExtraProps` and
//! `propOrder` set, everything else at its default (`ref: true`,
//! `aliasRef: false`, `uniqueNames: false`, `defaultNumberType: "number"`,
//! `constAsEnum: false`, no validation keywords, no schema overrides). Code
//! that only those defaults disable is not ported. Where TypeScript 7
//! answers differently from TypeScript 5.9 (union member order, inherited
//! property order, documentation text), [`order`] and [`comments`] emulate
//! the 5.9 behavior; `docs/research/07-typescript-input.md` lists them.
//!
//! JavaScript exceptions thrown by the original (`Unsupported type: …`) are
//! [`Error::Generator`]; `console.warn`/`console.error` lines are collected
//! in [`Generator::warnings`].

mod comments;
mod initializer;
pub mod order;
pub mod text;

use std::collections::HashMap;
use std::rc::Rc;

use crate::error::{Error, Result};
use crate::js::{self, Obj, Value};
use crate::tsc::api::{LiteralValue, Session, Symbol, Type};
use crate::tsc::ast::Node;
use crate::tsc::generated::{
    modifier_flags as mf, object_flags as of, symbol_flags as sf, syntax_kind as sk,
    type_flags as tf,
};

/// `TypeFormatFlags.NoTruncation` (same value in TypeScript 5 and 7).
pub const NO_TRUNCATION: u32 = 1;
/// `TypeFormatFlags.UseFullyQualifiedType`.
pub const USE_FULLY_QUALIFIED_TYPE: u32 = 64;
/// `NodeBuilderFlags.NoTruncation`.
const NODE_BUILDER_NO_TRUNCATION: u32 = 1;
/// `NodeBuilderFlags.InTypeAlias`: print the type itself, not its alias.
const NODE_BUILDER_IN_TYPE_ALIAS: u32 = 8_388_608;

const NUMERIC_INDEX_PATTERN: &str = "^[0-9]+$";
const VALIDATION_KEYWORDS: &[&str] = &[
    "multipleOf",
    "maximum",
    "exclusiveMaximum",
    "minimum",
    "exclusiveMinimum",
    "maxLength",
    "minLength",
    "pattern",
    "items",
    "maxItems",
    "minItems",
    "uniqueItems",
    "contains",
    "maxProperties",
    "minProperties",
    "additionalProperties",
    "enum",
    "type",
    "examples",
    "ignore",
    "description",
    "format",
    "default",
    "$ref",
    "id",
    "$id",
    "$comment",
    "title",
];
const ANNOTATION_KEYWORDS: &[&str] = &["description", "default", "examples", "title", "$ref"];
const SIMPLE_TYPES_ALLOWED_PROPERTIES: &[&str] = &["type", "description"];
const SUB_DEFINITIONS: &[&str] = &["items", "additionalProperties", "contains"];

/// quicktype's `unsupportedBuiltins`.
const UNSUPPORTED_BUILTINS: &[(&str, &str)] = &[
    ("Set", "use an array type instead"),
    ("WeakMap", "it cannot be represented in JSON"),
    ("WeakSet", "it cannot be represented in JSON"),
    ("Promise", "use the resolved type instead"),
];

/// A literal value as `extractLiteralValue` returns it.
#[derive(Clone, Debug)]
enum Literal {
    Str(String),
    Num(f64),
    Bool(bool),
}

impl Literal {
    fn to_value(&self) -> Value {
        match self {
            Literal::Str(s) => Value::String(s.clone()),
            Literal::Num(n) => Value::Number(*n),
            Literal::Bool(b) => Value::Bool(*b),
        }
    }
}

/// The optional parameters of `getTypeDefinition`.
#[derive(Clone, Default)]
struct DefArgs {
    as_ref: Option<bool>,
    union_modifier: Option<&'static str>,
    prop: Option<Rc<Symbol>>,
    reffed_type: Option<Rc<Symbol>>,
    paired_symbol: Option<Rc<Symbol>>,
    force_not_ref: bool,
    ignore_undefined: bool,
}

/// `JsonSchemaGenerator`, plus quicktype's `getTypeDefinition` patch.
pub struct Generator<'s> {
    s: &'s Session,
    /// `console.warn`/`console.error` output, in order.
    pub warnings: Vec<String>,
    all_symbols: HashMap<String, Rc<Type>>,
    user_symbols: Vec<(String, Rc<Symbol>)>,
    inheriting_types: HashMap<String, Vec<String>>,
    reffed_definitions: Obj,
    type_names_by_id: HashMap<u64, String>,
    type_ids_by_name: HashMap<String, u64>,
    recursive_type_ref: HashMap<String, Obj>,
    fqn_cache: HashMap<u64, String>,
    index_cache: HashMap<u64, Option<Rc<Type>>>,
    order: order::CreationOrder,
    main_files: Vec<String>,
}

/// `table[key]` on one of typescript-json-schema's keyword tables, which are
/// plain objects: `Object.prototype` names are found too.
fn in_table(table: &[&str], key: &str) -> bool {
    table.contains(&key) || js::is_object_prototype_key(key)
}

/// `expr.hasOwnProperty(key)`. A JSDoc tag named `hasOwnProperty` shadows
/// the method with a string, and the call throws.
fn has_own(o: &Obj, key: &str, expr: &str) -> Result<bool> {
    let o = o.borrow();
    if o.has("hasOwnProperty") {
        return Err(Error::Generator(format!(
            "{expr}.hasOwnProperty is not a function"
        )));
    }
    Ok(o.has(key))
}

fn get(o: &Obj, k: &str) -> Option<Value> {
    o.borrow().get(k)
}

fn is_undefined(o: &Obj, k: &str) -> bool {
    matches!(get(o, k), None | Some(Value::Undefined))
}

fn set(o: &Obj, k: &str, v: Value) {
    o.borrow_mut().set(k, v);
}

fn str_value(o: &Obj, k: &str) -> Option<String> {
    get(o, k).and_then(|v| v.as_str().map(str::to_owned))
}

/// `Object.keys(x)` for any value (strings and arrays have index keys).
fn keys_of(v: &Value) -> Vec<String> {
    match v {
        Value::Object(o) => o.borrow().keys(),
        Value::Array(a) => (0..a.borrow().len()).map(|i| i.to_string()).collect(),
        Value::String(s) => (0..s.encode_utf16().count())
            .map(|i| i.to_string())
            .collect(),
        _ => Vec::new(),
    }
}

/// `unique(arr).sort()` for string arrays. `unique` collects the items as
/// keys of a plain object, where `temp["__proto__"] = true` sets the
/// prototype instead of adding a key, so `"__proto__"` is dropped.
fn unique_sorted(items: Vec<String>) -> Value {
    let mut seen: Vec<String> = Vec::new();
    for i in items {
        if i != "__proto__" && !seen.contains(&i) {
            seen.push(i);
        }
    }
    quicktype_js_compat::sort::sort_strings(&mut seen);
    Value::array(seen.into_iter().map(Value::String).collect())
}

fn has(flags: u32, mask: u32) -> bool {
    flags & mask != 0
}

impl<'s> Generator<'s> {
    /// `buildGenerator(program, settings)`: collects the declarations of the
    /// program's non-library files. (The original also walks the library
    /// files; the names it collects there are overridden by user names or
    /// unreachable with quicktype's settings.)
    pub fn build(
        s: &'s Session,
        user_files: &[Node],
        order: order::CreationOrder,
    ) -> Result<Generator<'s>> {
        let mut g = Generator {
            s,
            warnings: Vec::new(),
            all_symbols: HashMap::new(),
            user_symbols: Vec::new(),
            inheriting_types: HashMap::new(),
            reffed_definitions: Value::object(),
            type_names_by_id: HashMap::new(),
            type_ids_by_name: HashMap::new(),
            recursive_type_ref: HashMap::new(),
            fqn_cache: HashMap::new(),
            index_cache: HashMap::new(),
            order,
            main_files: user_files
                .iter()
                .filter(|f| !f.is_declaration_file())
                .map(|f| f.source_file().path())
                .collect(),
        };
        let mut decls = Vec::new();
        fn inspect(node: &Node, out: &mut Vec<Node>) {
            match node.kind() {
                sk::ClassDeclaration
                | sk::InterfaceDeclaration
                | sk::EnumDeclaration
                | sk::TypeAliasDeclaration => {
                    out.push(node.clone());
                }
                _ => node.children().iter().for_each(|c| inspect(c, out)),
            }
        }
        for f in user_files {
            inspect(f, &mut decls);
        }
        let name_nodes: Vec<Node> = decls
            .iter()
            .map(|d| d.named("name").unwrap_or_else(|| d.clone()))
            .collect();
        let symbols = s.symbols_at(&name_nodes)?;
        let types = s.types_at(&decls)?;
        for ((decl, symbol), node_type) in decls.iter().zip(symbols).zip(types) {
            let Some(node_type) = node_type else { continue };
            // A nameless `export default class {}` has no name to ask about;
            // its symbol (`default`) is the one of its type.
            let symbol = match symbol {
                Some(symbol) => symbol,
                None => match s.symbol_of_type(&node_type)? {
                    Some(symbol) if decl.named("name").is_none() => symbol,
                    _ => continue,
                },
            };
            let name = text::strip_quoted_prefix(&g.fqn(&symbol)?);
            // `if (!userSymbols[name])` on a plain object: `Object.prototype`
            // names count as present.
            if !g.user_symbols.iter().any(|(n, _)| *n == name)
                && !js::is_object_prototype_key(&name)
            {
                g.all_symbols.insert(name.clone(), Rc::clone(&node_type));
            }
            if name != "__proto__" {
                match g.user_symbols.iter_mut().find(|(n, _)| *n == name) {
                    Some(entry) => entry.1 = Rc::clone(&symbol),
                    None => g.user_symbols.push((name.clone(), Rc::clone(&symbol))),
                }
            }
            if has(node_type.flags, tf::Object) && has(node_type.object_flags, of::ClassOrInterface)
            {
                for base in s.base_types(&node_type)? {
                    let base_name = s.type_to_string(&base, Some(USE_FULLY_QUALIFIED_TYPE))?;
                    g.inheriting_types
                        .entry(base_name)
                        .or_default()
                        .push(name.clone());
                }
            }
        }
        Ok(g)
    }

    /// `generateSchema(program, "*")` → `getSchemaForSymbols(getMainFileSymbols())`.
    pub fn schema_for_main_symbols(&mut self) -> Result<Obj> {
        let names = js_key_order(self.user_symbols.iter().map(|(n, _)| n.clone()).collect());
        let mut main = Vec::new();
        for name in names {
            let Some((_, sym)) = self.user_symbols.iter().find(|(n, _)| *n == name) else {
                continue;
            };
            if let Some(d) = sym.declarations.first() {
                if self.main_files.contains(&d.path) {
                    main.push((name, Rc::clone(sym)));
                }
            }
        }
        let root = Value::object();
        set(
            &root,
            "$schema",
            Value::str("http://json-schema.org/draft-07/schema#"),
        );
        let definitions = Value::object();
        set(&root, "definitions", Value::Object(Rc::clone(&definitions)));
        for (name, sym) in main {
            let Some(ty) = self.all_symbols.get(&name).cloned() else {
                // `allSymbols[name]` is then `Object.prototype[name]`, which the
                // patched `getTypeDefinition` calls `getSymbol()` on.
                if js::is_object_prototype_key(&name) {
                    return Err(Error::Generator("typ.getSymbol is not a function".into()));
                }
                continue;
            };
            let def = self.get_type_definition(
                &ty,
                DefArgs {
                    as_ref: Some(true),
                    paired_symbol: Some(sym),
                    ..DefArgs::default()
                },
            )?;
            set(&definitions, &name, def);
        }
        if !self.reffed_definitions.borrow().is_empty() {
            let merged = js::spread(&[Some(&definitions), Some(&self.reffed_definitions)]);
            set(&root, "definitions", Value::Object(merged));
        }
        Ok(root)
    }

    // ---- symbol helpers -----------------------------------------------------

    /// `checker.getFullyQualifiedName(symbol)`: the parent chain joined with
    /// dots. A default export prints as its declaration's name, as TS 5's
    /// `symbolToString` does.
    pub fn fqn(&mut self, sym: &Symbol) -> Result<String> {
        if let Some(n) = self.fqn_cache.get(&sym.id) {
            return Ok(n.clone());
        }
        let mut name = sym.name.clone();
        if sym.escaped_name == "default" {
            if let Some(d) = sym.declarations.first() {
                if let Some(id) = self.s.resolve(d)?.named("name").and_then(|n| n.text()) {
                    name = id;
                }
            }
        }
        let full = match self.s.parent_of_symbol(sym)? {
            Some(p) => format!("{}.{name}", self.fqn(&p)?),
            None => name,
        };
        self.fqn_cache.insert(sym.id, full.clone());
        Ok(full)
    }

    /// TJS `isFromDefaultLib`: the first declaration's file has
    /// `/// <reference no-default-lib="true"/>` (all library files do).
    fn is_from_default_lib(&self, sym: &Symbol) -> Result<bool> {
        match sym.declarations.first() {
            Some(d) if d.index != 1 => self.s.is_default_library(&d.path),
            _ => Ok(false),
        }
    }

    /// quicktype's `isDeclaredInDefaultLib`.
    fn is_declared_in_default_lib(&self, sym: &Symbol) -> Result<bool> {
        for d in &sym.declarations {
            if self.s.is_default_library(&d.path)? {
                return Ok(true);
            }
        }
        Ok(false)
    }

    fn number_index_type(&mut self, t: &Type) -> Result<Option<Rc<Type>>> {
        if let Some(v) = self.index_cache.get(&t.id) {
            return Ok(v.clone());
        }
        let v = self.s.number_index_type(t)?;
        self.index_cache.insert(t.id, v.clone());
        Ok(v)
    }

    /// `type.types`, with object members in TypeScript 5.9's order.
    fn types_of(&mut self, t: &Type) -> Result<Vec<Rc<Type>>> {
        let s = self.s;
        let types = s.types_of_type(t)?;
        if has(t.flags, tf::Union | tf::Intersection) {
            self.order.reorder(s, types)
        } else {
            Ok(types)
        }
    }

    /// `extractLiteralValue`.
    fn extract_literal_value(t: &Type) -> Option<Literal> {
        let value = t.value.as_ref();
        if has(t.flags, tf::StringLiteral) {
            match value? {
                LiteralValue::String(s) => Some(Literal::Str(s.clone())),
                LiteralValue::Number(n) => Some(Literal::Num(*n)),
                LiteralValue::Bool(b) => Some(Literal::Bool(*b)),
            }
        } else if has(t.flags, tf::BooleanLiteral) {
            Some(Literal::Bool(
                t.intrinsic_name.as_deref() == Some("true")
                    || value == Some(&LiteralValue::Bool(true)),
            ))
        } else if has(t.flags, tf::EnumLiteral) {
            match value? {
                LiteralValue::Number(n) => Some(Literal::Num(*n)),
                LiteralValue::String(s) => {
                    let n = js::parse_float(s);
                    Some(if n.is_nan() {
                        Literal::Str(s.clone())
                    } else {
                        Literal::Num(n)
                    })
                }
                LiteralValue::Bool(b) => Some(Literal::Bool(*b)),
            }
        } else if has(t.flags, tf::NumberLiteral) {
            match value? {
                LiteralValue::Number(n) => Some(Literal::Num(*n)),
                LiteralValue::String(s) => Some(Literal::Num(js::parse_float(s))),
                LiteralValue::Bool(_) => Some(Literal::Num(f64::NAN)),
            }
        } else {
            None
        }
    }

    // ---- getDefinitionForRootType -----------------------------------------------

    fn get_definition_for_root_type(
        &mut self,
        ty: &Rc<Type>,
        reffed_type: Option<&Rc<Symbol>>,
        definition: &Obj,
        ignore_undefined: bool,
    ) -> Result<()> {
        let s = self.s;
        // resolveTupleType
        let symbol = s.symbol_of_type(ty)?;
        let tuple_target =
            if symbol.is_none() && has(ty.flags, tf::Object) && has(ty.object_flags, of::Reference)
            {
                s.target_of_type(ty)?
            } else if has(ty.flags, tf::Object) && has(ty.object_flags, of::Tuple) {
                Some(Rc::clone(ty))
            } else {
                None
            };
        if let Some(target) = tuple_target {
            let flags = target.element_flags.clone();
            let elem_types = s.type_arguments(ty)?;
            // `labeledElementDeclarations` is not exposed by TS 7; the labels
            // come from the type printed as a node, without truncation or the
            // alias name, and with a `readonly` operator unwrapped.
            let mut node =
                s.type_to_type_node(ty, NODE_BUILDER_NO_TRUNCATION | NODE_BUILDER_IN_TYPE_ALIAS)?;
            while let Some(n) = node.clone().filter(|n| n.kind() == sk::TypeOperator) {
                node = n.named("type");
            }
            let labels: Vec<Option<String>> = match node {
                Some(n) if n.kind() == sk::TupleType => n
                    .named_list("elements")
                    .iter()
                    .map(|e| {
                        (e.kind() == sk::NamedTupleMember)
                            .then(|| e.named("name").and_then(|n| n.text()))
                            .flatten()
                    })
                    .collect(),
                _ => Vec::new(),
            };
            let mut fixed = Vec::new();
            let arity = if flags.is_empty() {
                elem_types.len()
            } else {
                flags.len()
            };
            for (i, el) in elem_types.iter().take(arity).enumerate() {
                let def = self.get_type_definition(el, DefArgs::default())?;
                if let (Some(Some(label)), Some(o)) = (labels.get(i), def.as_object()) {
                    if !label.is_empty() {
                        set(o, "title", Value::str(label.clone()));
                    }
                }
                fixed.push(def);
            }
            let fixed_arr = Rc::new(std::cell::RefCell::new(fixed));
            set(definition, "type", Value::str("array"));
            if !fixed_arr.borrow().is_empty() {
                set(definition, "items", Value::Array(Rc::clone(&fixed_arr)));
            }
            let min = flags.iter().filter(|f| *f & (1 | 8) != 0).count();
            set(definition, "minItems", Value::Number(min as f64));
            if flags.iter().any(|f| f & 12 != 0) {
                let last = fixed_arr
                    .borrow()
                    .last()
                    .cloned()
                    .unwrap_or(Value::Undefined);
                set(definition, "additionalItems", last);
                let mut f = fixed_arr.borrow_mut();
                if !f.is_empty() {
                    let n = f.len() - 1;
                    f.remove(n);
                }
            } else {
                let fixed_length = target
                    .fixed_length
                    .map_or(Value::Undefined, |n| Value::Number(n as f64));
                set(definition, "maxItems", fixed_length);
            }
            return Ok(());
        }

        let type_string = s.type_to_string(ty, Some(USE_FULLY_QUALIFIED_TYPE))?;
        let flags = ty.flags;
        let array_type = self.number_index_type(ty)?;
        if has(flags, tf::String) {
            set(definition, "type", Value::str("string"));
        } else if has(flags, tf::Number) {
            let is_integer = str_value(definition, "type").as_deref() == Some("integer")
                || reffed_type.is_some_and(|r| r.name == "integer");
            set(
                definition,
                "type",
                Value::str(if is_integer { "integer" } else { "number" }),
            );
        } else if has(flags, tf::Boolean) {
            set(definition, "type", Value::str("boolean"));
        } else if has(flags, tf::ESSymbol) {
            set(definition, "type", Value::str("object"));
        } else if has(flags, tf::Null) {
            set(definition, "type", Value::str("null"));
        } else if has(flags, tf::Undefined) || type_string == "void" {
            if !ignore_undefined {
                return Err(Error::Generator(
                    "Not supported: root type undefined".into(),
                ));
            }
            set(definition, "type", Value::str("undefined"));
        } else if has(flags, tf::Any) || has(flags, tf::Unknown) {
        } else if type_string == "Date" {
            set(definition, "type", Value::str("string"));
            let format = get(definition, "format")
                .filter(Value::truthy)
                .unwrap_or(Value::str("date-time"));
            set(definition, "format", format);
        } else if type_string == "object" {
            set(definition, "type", Value::str("object"));
            set(definition, "properties", Value::Object(Value::object()));
            set(definition, "additionalProperties", Value::Bool(true));
        } else if type_string == "bigint" {
            set(definition, "type", Value::str("number"));
            set(definition, "properties", Value::Object(Value::object()));
            set(definition, "additionalProperties", Value::Bool(false));
        } else if let Some(value) = Self::extract_literal_value(ty) {
            let t = match value {
                Literal::Str(_) => "string",
                Literal::Bool(_) => "boolean",
                Literal::Num(_) => "number",
            };
            set(definition, "type", Value::str(t));
            set(definition, "const", value.to_value());
        } else if let Some(array_type) = array_type {
            if has(flags, tf::Object)
                && has(ty.object_flags, of::Anonymous | of::Interface | of::Mapped)
            {
                set(definition, "type", Value::str("object"));
                set(definition, "additionalProperties", Value::Bool(false));
                let pattern = Value::object();
                let item = self.get_type_definition(&array_type, DefArgs::default())?;
                pattern.borrow_mut().define(NUMERIC_INDEX_PATTERN, item);
                set(definition, "patternProperties", Value::Object(pattern));
                let has_members = match &symbol {
                    Some(sym) => s
                        .members_of_symbol(sym)?
                        .iter()
                        .any(|m| m.escaped_name != "__index"),
                    None => false,
                };
                if has_members {
                    self.get_class_definition(ty, definition)?;
                }
            } else if has(flags, tf::TemplateLiteral) {
                set(definition, "type", Value::str("string"));
                let texts = ty.texts.clone().unwrap_or_default();
                let types = s.types_of_type(ty)?;
                let mut pattern = String::new();
                for (i, raw) in texts.iter().enumerate() {
                    let t = text::escape_regex(raw);
                    if i == 0 {
                        pattern.push('^');
                    }
                    if let Some(part) = types.get(i) {
                        if has(part.flags, tf::String) {
                            pattern.push_str(&format!("{t}.*"));
                        }
                        if has(part.flags, tf::Number) || has(part.flags, tf::BigInt) {
                            pattern.push_str(&format!("{t}[0-9]*"));
                        }
                        if has(part.flags, tf::Undefined) {
                            pattern.push_str(&format!("{t}undefined"));
                        }
                        if has(part.flags, tf::Null) {
                            pattern.push_str(&format!("{t}null"));
                        }
                    }
                    if i == texts.len() - 1 {
                        pattern.push_str(&format!("{t}$"));
                    }
                }
                set(definition, "pattern", Value::String(pattern));
            } else {
                set(definition, "type", Value::str("array"));
                if !get(definition, "items").is_some_and(|v| v.truthy()) {
                    let items = self.get_type_definition(&array_type, DefArgs::default())?;
                    set(definition, "items", items);
                }
            }
        } else {
            return Err(Error::Generator(format!("Unsupported type: {type_string}")));
        }
        Ok(())
    }

    // ---- properties -----------------------------------------------------------------

    fn get_referenced_type_symbol(&mut self, prop: &Symbol) -> Result<Option<Rc<Symbol>>> {
        let Some(d) = prop.declarations.first() else {
            return Ok(None);
        };
        let decl = self.s.resolve(d)?;
        let Some(type_node) = decl.named("type") else {
            return Ok(None);
        };
        // TJS tests `type.kind & ts.SyntaxKind.TypeReference && type.typeName`;
        // only type references have a `typeName`, and their kind passes the
        // (bitwise) test.
        let Some(type_name) = type_node.named("typeName") else {
            return Ok(None);
        };
        let Some(symbol) = self.s.symbol_at(&type_name)? else {
            return Ok(None);
        };
        if has(symbol.flags, sf::Alias) {
            return Ok(Some(self.s.aliased_symbol(&symbol)?));
        }
        Ok(Some(symbol))
    }

    fn get_definition_for_property(
        &mut self,
        prop: &Rc<Symbol>,
        node: &Node,
    ) -> Result<Option<Value>> {
        if has(prop.flags, sf::Method) {
            return Ok(None);
        }
        let name = prop.name.clone();
        let property_type = self.s.type_of_symbol_at(prop, node)?;
        let reffed_type = self.get_referenced_type_symbol(prop)?;
        let definition = self.get_type_definition(
            &property_type,
            DefArgs {
                prop: Some(Rc::clone(prop)),
                reffed_type,
                ..DefArgs::default()
            },
        )?;
        let Some(def) = definition.as_object().cloned() else {
            return Ok(Some(definition));
        };
        set(&def, "title", Value::String(name.clone()));
        if has_own(&def, "ignore", "definition")? {
            return Ok(None);
        }
        let initializer = match &prop.value_declaration {
            Some(h) => self.s.resolve(h)?.named("initializer"),
            None => None,
        };
        if let Some(mut initial) = initializer {
            while initial.kind() == sk::TypeAssertionExpression {
                match initial.named("expression") {
                    Some(e) => initial = e,
                    None => break,
                }
            }
            if initial.named("expression").is_some() {
                self.warnings
                    .push(format!("initializer is expression for property {name}"));
            } else if initial.kind() == sk::NoSubstitutionTemplateLiteral {
                set(&def, "default", Value::String(initial.get_text()));
            } else {
                match initializer::evaluate(&initial) {
                    Ok(val) => match &val {
                        Value::Null
                        | Value::String(_)
                        | Value::Number(_)
                        | Value::Bool(_)
                        | Value::Array(_) => {
                            set(&def, "default", val);
                        }
                        v if v.truthy() => self.warnings.push(format!(
                            "unknown initializer for property {name}: {}",
                            v.to_js_string()
                        )),
                        _ => {}
                    },
                    Err(()) => self.warnings.push(format!(
                        "exception evaluating initializer for property {name}"
                    )),
                }
            }
        }
        Ok(Some(Value::Object(def)))
    }

    // ---- enums, unions, intersections ---------------------------------------------

    fn get_enum_definition(&mut self, ty: &Rc<Type>, definition: &Obj) -> Result<()> {
        let s = self.s;
        let sym = s
            .symbol_of_type(ty)?
            .ok_or_else(|| read_error("getDeclarations"))?;
        let decl = sym.declarations.first().ok_or_else(|| read_error("kind"))?;
        let node = s.resolve(decl)?;
        let full_name = s.type_to_string(ty, Some(USE_FULLY_QUALIFIED_TYPE))?;
        let members = if node.kind() == sk::EnumDeclaration {
            node.named_list("members")
        } else {
            vec![node]
        };
        let mut values: Vec<Value> = Vec::new();
        let mut types: Vec<&'static str> = Vec::new();
        let add_type = |t: &'static str, types: &mut Vec<&'static str>| {
            if !types.contains(&t) {
                types.push(t);
            }
        };
        for member in members {
            let case_label = member
                .named("name")
                .and_then(|n| n.text())
                .unwrap_or_default();
            match s.constant_value(&member)? {
                Some(LiteralValue::String(v)) => {
                    values.push(Value::String(v));
                    add_type("string", &mut types);
                }
                Some(LiteralValue::Number(n)) => {
                    values.push(Value::Number(n));
                    add_type("number", &mut types);
                }
                Some(LiteralValue::Bool(b)) => {
                    values.push(Value::Bool(b));
                    add_type("boolean", &mut types);
                }
                None => {
                    let Some(initial) = member.named("initializer") else {
                        continue;
                    };
                    if let Some(exp) = initial.named("expression") {
                        if let Some(t) = exp.text().filter(|t| !t.is_empty()) {
                            values.push(Value::String(t));
                            add_type("string", &mut types);
                        } else if exp.kind() == sk::TrueKeyword || exp.kind() == sk::FalseKeyword {
                            values.push(Value::Bool(exp.kind() == sk::TrueKeyword));
                            add_type("boolean", &mut types);
                        } else {
                            self.warnings.push(format!(
                                "initializer is expression for enum: {full_name}.{case_label}"
                            ));
                        }
                    } else if initial.kind() == sk::NoSubstitutionTemplateLiteral {
                        values.push(Value::String(initial.get_text()));
                        add_type("string", &mut types);
                    } else if initial.kind() == sk::NullKeyword {
                        values.push(Value::Null);
                        add_type("null", &mut types);
                    }
                }
            }
        }
        if !types.is_empty() {
            let t = if types.len() == 1 {
                Value::str(types[0])
            } else {
                Value::array(types.iter().map(|t| Value::str(*t)).collect())
            };
            set(definition, "type", t);
        }
        if values.len() > 1 {
            set(definition, "enum", Value::array(values));
        } else if let Some(v) = values.pop() {
            set(definition, "const", v);
        }
        Ok(())
    }

    fn get_union_definition(
        &mut self,
        ty: &Rc<Type>,
        union_modifier: &str,
        definition: &Obj,
    ) -> Result<()> {
        let mut enum_values: Vec<Value> = Vec::new();
        let mut simple_types: Vec<String> = Vec::new();
        let mut schemas: Vec<Value> = Vec::new();
        for value_type in self.types_of(ty)? {
            if let Some(v) = Self::extract_literal_value(&value_type) {
                let v = v.to_value();
                if !enum_values.iter().any(|e| e.strict_equals(&v)) {
                    enum_values.push(v);
                }
                continue;
            }
            let symbol = self.s.alias_symbol_of_type(&value_type)?;
            let def = self.get_type_definition(
                &value_type,
                DefArgs {
                    prop: symbol.clone(),
                    reffed_type: symbol,
                    ignore_undefined: true,
                    ..DefArgs::default()
                },
            )?;
            let Some(d) = def.as_object() else { continue };
            if str_value(d, "type").as_deref() == Some("undefined") {
                continue;
            }
            let keys = d.borrow().keys();
            if keys.len() == 1 && keys[0] == "type" {
                match get(d, "type") {
                    Some(Value::String(t)) => {
                        if !simple_types.contains(&t) {
                            simple_types.push(t);
                        }
                    }
                    _ => self.warnings.push("Expected only a simple type.".into()),
                }
            } else {
                schemas.push(def);
            }
        }
        if !enum_values.is_empty() {
            let only_booleans = enum_values.len() == 2
                && matches!((&enum_values[0], &enum_values[1]), (Value::Bool(a), Value::Bool(b)) if a != b);
            if only_booleans {
                if !simple_types.iter().any(|t| t == "boolean") {
                    simple_types.push("boolean".into());
                }
            } else {
                let schema = Value::object();
                let all = |t: &str| enum_values.iter().all(|v| v.type_of() == t);
                let ty_name = if all("string") {
                    Some("string")
                } else if all("number") {
                    Some("number")
                } else if all("boolean") {
                    Some("boolean")
                } else {
                    None
                };
                if enum_values.len() > 1 {
                    let mut sorted = enum_values.clone();
                    js::default_sort(&mut sorted);
                    set(&schema, "enum", Value::array(sorted));
                } else {
                    set(&schema, "const", enum_values[0].clone());
                }
                if let Some(t) = ty_name {
                    set(&schema, "type", Value::str(t));
                }
                schemas.push(Value::Object(schema));
            }
        }
        if !simple_types.is_empty() {
            let schema = Value::object();
            let t = if simple_types.len() == 1 {
                Value::String(simple_types[0].clone())
            } else {
                Value::array(simple_types.into_iter().map(Value::String).collect())
            };
            set(&schema, "type", t);
            schemas.push(Value::Object(schema));
        }
        if schemas.len() == 1 {
            if let Some(only) = schemas[0].as_object() {
                let entries = only.borrow().entries();
                for (k, v) in entries {
                    has_own(only, &k, "schemas[0]")?;
                    if k == "description" && has_own(definition, &k, "definition")? {
                        continue;
                    }
                    set(definition, &k, v);
                }
            }
        } else {
            set(definition, union_modifier, Value::array(schemas));
        }
        Ok(())
    }

    fn get_intersection_definition_no_extra_props(
        &mut self,
        ty: &Rc<Type>,
        definition: &Obj,
    ) -> Result<()> {
        set(definition, "additionalProperties", Value::Bool(false));
        for member in self.types_of(ty)? {
            let other = self.get_type_definition(
                &member,
                DefArgs {
                    as_ref: Some(false),
                    force_not_ref: true,
                    ..DefArgs::default()
                },
            )?;
            let Some(other) = other.as_object().cloned() else {
                continue;
            };
            set(
                definition,
                "type",
                get(&other, "type").unwrap_or(Value::Undefined),
            );
            let props = js::spread(&[
                get(definition, "properties")
                    .as_ref()
                    .and_then(Value::as_object),
                get(&other, "properties")
                    .as_ref()
                    .and_then(Value::as_object),
            ]);
            set(definition, "properties", Value::Object(props));
            let other_default = get(&other, "default")
                .filter(Value::truthy)
                .unwrap_or(Value::Object(Value::object()));
            if !keys_of(&other_default).is_empty() {
                let target = match get(definition, "default").filter(Value::truthy) {
                    Some(Value::Object(o)) => o,
                    _ => Value::object(),
                };
                if let Value::Object(src) = &other_default {
                    let entries = src.borrow().entries();
                    for (k, v) in entries {
                        set(&target, &k, v);
                    }
                }
                set(definition, "default", Value::Object(target));
            }
            if let Some(req) = get(&other, "required").filter(Value::truthy) {
                let mut all: Vec<String> = Vec::new();
                for list in [get(definition, "required"), Some(req)]
                    .into_iter()
                    .flatten()
                {
                    if let Value::Array(a) = list {
                        all.extend(a.borrow().iter().map(Value::to_js_string));
                    }
                }
                set(definition, "required", unique_sorted(all));
            }
        }
        Ok(())
    }

    // ---- classes, interfaces, object literals ---------------------------------------

    fn get_class_definition(&mut self, ty: &Rc<Type>, definition: &Obj) -> Result<()> {
        let s = self.s;
        let sym = s
            .symbol_of_type(ty)?
            .ok_or_else(|| read_error("getDeclarations"))?;
        let Some(decl) = sym.declarations.first() else {
            set(definition, "type", Value::str("object"));
            return Ok(());
        };
        let node = s.resolve(decl)?;
        let mut props = Vec::new();
        for p in self.ts5_properties_of_type(ty)? {
            let f = s.type_of_symbol_at(&p, &node)?.flags;
            if f != tf::Never && f != tf::Undefined {
                props.push(p);
            }
        }
        let full_name = s.type_to_string(ty, Some(USE_FULLY_QUALIFIED_TYPE))?;
        let modifier_flags = node.modifier_flags();
        if has(modifier_flags, mf::Abstract) && self.inheriting_types.contains_key(&full_name) {
            let names = self.inheriting_types[&full_name].clone();
            let mut one_of = Vec::new();
            for n in names {
                match self.all_symbols.get(&n).cloned() {
                    Some(t) => one_of.push(self.get_type_definition(&t, DefArgs::default())?),
                    None => return Err(read_error("aliasSymbol")),
                }
            }
            set(definition, "oneOf", Value::array(one_of));
            return Ok(());
        }
        {
            let index_signatures: Vec<Node> = node
                .named_list("members")
                .into_iter()
                .filter(|m| m.kind() == sk::IndexSignature)
                .collect();
            if index_signatures.len() == 1 {
                let index_signature = &index_signatures[0];
                let params = index_signature.named_list("parameters");
                if params.len() != 1 {
                    return Err(Error::Generator(
                        "Not supported: IndexSignatureDeclaration parameters.length != 1".into(),
                    ));
                }
                let index_symbol = match params[0].named("name") {
                    Some(n) => s.symbol_at(&n)?,
                    None => None,
                };
                let index_type = match &index_symbol {
                    Some(sym) => s.type_of_symbol_at(sym, &node)?,
                    None => return Err(read_error("flags")),
                };
                let is_indexed_object =
                    index_type.flags == tf::String || index_type.flags == tf::Number;
                if index_type.flags != tf::Number && !is_indexed_object {
                    return Err(Error::Generator(
                        "Not supported: IndexSignatureDeclaration with index symbol other than a number or a string"
                            .into(),
                    ));
                }
                let typ = match index_signature.named("type") {
                    Some(t) => s.type_at(&t)?,
                    None => None,
                };
                let typ = typ.ok_or_else(|| read_error("flags"))?;
                // The `T[K]` branch reads checker internals (`mapper`) that TS 7 does
                // not expose; it falls back to the plain definition below.
                let def = self.get_type_definition(
                    &typ,
                    DefArgs {
                        union_modifier: Some("anyOf"),
                        ..DefArgs::default()
                    },
                )?;
                if is_indexed_object {
                    set(definition, "type", Value::str("object"));
                    let pattern_empty =
                        match get(definition, "patternProperties").filter(Value::truthy) {
                            Some(v) => keys_of(&v).is_empty(),
                            None => true,
                        };
                    if pattern_empty {
                        set(definition, "additionalProperties", def);
                    }
                } else {
                    set(definition, "type", Value::str("array"));
                    if !get(definition, "items").is_some_and(|v| v.truthy()) {
                        set(definition, "items", def);
                    }
                }
            }
        }
        let property_definitions = Value::object();
        for prop in &props {
            if let Some(d) = self.get_definition_for_property(prop, &node)? {
                set(&property_definitions, &prop.name, d);
            }
        }
        if is_undefined(definition, "type") {
            set(definition, "type", Value::str("object"));
        }
        if str_value(definition, "type").as_deref() == Some("object")
            && !property_definitions.borrow().keys().is_empty()
        {
            set(
                definition,
                "properties",
                Value::Object(property_definitions),
            );
        }
        if is_undefined(definition, "additionalProperties") {
            set(definition, "additionalProperties", Value::Bool(false));
        }
        set(
            definition,
            "propertyOrder",
            Value::array(
                props
                    .iter()
                    .map(|p| Value::String(p.name.clone()))
                    .collect(),
            ),
        );
        let mut required = Vec::new();
        for prop in &props {
            let def = Value::object();
            self.parse_comments_into_definition(Some(prop), &def, &Value::object())?;
            let mut union_flags = Vec::new();
            if has(prop.flags, sf::Transient) {
                let t = s.type_of_symbol(prop)?;
                if has(t.flags, tf::Union) {
                    union_flags = s.types_of_type(&t)?.iter().map(|m| m.flags).collect();
                }
            }
            if !has(prop.flags, sf::Optional)
                && !has(prop.flags, sf::Method)
                && !union_flags.contains(&tf::Undefined)
                && !union_flags.contains(&tf::Void)
                && !has_own(&def, "ignore", "def")?
            {
                required.push(prop.name.clone());
            }
        }
        if !required.is_empty() {
            set(definition, "required", unique_sorted(required));
        }
        Ok(())
    }

    // ---- getTypeDefinition --------------------------------------------------------------

    fn make_type_name_unique(&mut self, ty: &Type, base: &str) -> String {
        let mut name = base.to_owned();
        let mut i = 1;
        while self
            .type_ids_by_name
            .get(&name)
            .is_some_and(|id| *id != ty.id)
        {
            name = format!("{base}_{i}");
            i += 1;
        }
        self.type_names_by_id.insert(ty.id, name.clone());
        self.type_ids_by_name.insert(name.clone(), ty.id);
        name
    }

    fn get_type_name(&mut self, ty: &Type) -> Result<String> {
        if let Some(n) = self.type_names_by_id.get(&ty.id).filter(|n| !n.is_empty()) {
            return Ok(n.clone());
        }
        let s = self
            .s
            .type_to_string(ty, Some(NO_TRUNCATION | USE_FULLY_QUALIFIED_TYPE))?;
        Ok(self.make_type_name_unique(ty, &text::strip_file_names_and_spaces(&s)))
    }

    /// quicktype's patched `getTypeDefinition` (`patchGeneratorForBuiltinTypes`).
    fn get_type_definition(&mut self, ty: &Rc<Type>, args: DefArgs) -> Result<Value> {
        if let Some(symbol) = self.s.symbol_of_type(ty)? {
            if self.is_declared_in_default_lib(&symbol)? {
                let name = symbol.name.as_str();
                if (name == "Map" || name == "ReadonlyMap")
                    && has(ty.flags, tf::Object)
                    && has(ty.object_flags, of::Reference)
                {
                    let type_args = self.s.type_arguments(ty)?;
                    if type_args.len() == 2 {
                        let out = Value::object();
                        set(&out, "type", Value::str("object"));
                        let value = self.get_type_definition(&type_args[1], DefArgs::default())?;
                        set(&out, "additionalProperties", value);
                        return Ok(Value::Object(out));
                    }
                }
                if let Some((_, advice)) = UNSUPPORTED_BUILTINS.iter().find(|(n, _)| *n == name) {
                    let t = self.s.type_to_string(ty, None)?;
                    return Err(Error::TypeScript {
                        message: format!(
                            "quicktype's TypeScript input does not support '{t}' - {advice}"
                        ),
                    });
                }
            }
        }
        self.original_get_type_definition(ty, args)
    }

    fn original_get_type_definition(&mut self, ty: &Rc<Type>, args: DefArgs) -> Result<Value> {
        let s = self.s;
        let mut ty = Rc::clone(ty);
        let mut as_ref = args.as_ref.unwrap_or(true);
        let union_modifier = args.union_modifier.unwrap_or("anyOf");
        let mut reffed_type = args.reffed_type.clone();
        let definition = Value::object();
        while let Some(alias) = s.alias_symbol_of_type(&ty)? {
            if alias.escaped_name != "Readonly" && alias.escaped_name != "Mutable" {
                break;
            }
            let Some(first) = s.alias_type_arguments(&ty)?.into_iter().next() else {
                break;
            };
            ty = first;
            reffed_type = None;
        }
        let mut returned = Value::Object(Rc::clone(&definition));
        if let Some(prop) = &args.prop {
            let defs = Value::object();
            self.parse_comments_into_definition(Some(prop), &defs, &Value::object())?;
            if has_own(&defs, "ignore", "defs")? || has_own(&defs, "type", "defs")? {
                return Ok(Value::Object(defs));
            }
        }
        let symbol = s.symbol_of_type(&ty)?;
        let alias_symbol = s.alias_symbol_of_type(&ty)?;
        let mut is_raw_type = match &symbol {
            None => true,
            Some(sym) => {
                let name = self.fqn(sym)?;
                name != "Window"
                    && (name == "Date"
                        || sym.name == "integer"
                        || self.number_index_type(&ty)?.is_some())
            }
        };
        if is_raw_type
            && alias_symbol
                .as_ref()
                .is_some_and(|a| !a.escaped_name.is_empty())
            && has(ty.flags, tf::Union | tf::Intersection | tf::TemplateLiteral)
        {
            is_raw_type = false;
        }
        let is_string_enum = has(ty.flags, tf::Union)
            && s.types_of_type(&ty)?
                .iter()
                .all(|t| has(t.flags, tf::StringLiteral));
        let as_type_alias_ref = as_ref && reffed_type.is_some() && is_string_enum;
        if !as_type_alias_ref
            && (is_raw_type || (has(ty.flags, tf::Object) && has(ty.object_flags, of::Anonymous)))
        {
            as_ref = false;
        }
        let full_type_name = if as_type_alias_ref {
            let reffed = reffed_type.clone().ok_or_else(|| read_error("flags"))?;
            let target = if has(reffed.flags, sf::Alias) {
                s.aliased_symbol(&reffed)?
            } else {
                reffed
            };
            let name = text::strip_file_names_and_spaces(&self.fqn(&target)?);
            self.make_type_name_unique(&ty, &name)
        } else {
            self.get_type_name(&ty)?
        };
        if !is_raw_type || alias_symbol.is_some() {
            if self.recursive_type_ref.contains_key(&full_type_name) && !args.force_not_ref {
                as_ref = true;
            } else {
                self.recursive_type_ref
                    .insert(full_type_name.clone(), Rc::clone(&definition));
            }
        }
        let ref_uri = format!(
            "#/definitions/{}",
            js::encode_uri_component(&full_type_name)
        );
        if as_ref {
            let r = Value::object();
            set(&r, "$ref", Value::String(ref_uri.clone()));
            returned = Value::Object(r);
        }
        let other_annotations = Value::object();
        self.parse_comments_into_definition(reffed_type.as_ref(), &definition, &other_annotations)?;
        self.parse_comments_into_definition(symbol.as_ref(), &definition, &other_annotations)?;
        self.parse_comments_into_definition(
            alias_symbol.as_ref(),
            &definition,
            &other_annotations,
        )?;
        if let (Some(prop), Some(ret)) = (&args.prop, returned.as_object()) {
            let ret = Rc::clone(ret);
            self.parse_comments_into_definition(Some(prop), &ret, &other_annotations)?;
        }
        if let (Some(paired), Some(sym)) = (&args.paired_symbol, &symbol) {
            if self.is_from_default_lib(sym)? {
                self.parse_comments_into_definition(Some(paired), &definition, &other_annotations)?;
            }
        }
        let already_reffed = self
            .reffed_definitions
            .borrow()
            .get(&full_type_name)
            .is_some_and(|v| v.truthy());
        if !as_ref || !already_reffed {
            if as_ref {
                let reffed_definition = match (&symbol, &reffed_type) {
                    (Some(sym), Some(reffed))
                        if as_type_alias_ref && ty.symbol != Some(reffed.id) =>
                    {
                        self.get_type_definition(
                            &ty,
                            DefArgs {
                                as_ref: Some(true),
                                prop: Some(Rc::clone(sym)),
                                reffed_type: Some(Rc::clone(sym)),
                                ..DefArgs::default()
                            },
                        )?
                    }
                    _ => Value::Object(Rc::clone(&definition)),
                };
                self.reffed_definitions
                    .borrow_mut()
                    .set(&full_type_name, reffed_definition);
                if !full_type_name.is_empty() {
                    set(&definition, "title", Value::String(full_type_name.clone()));
                }
            }
            let node = match &symbol {
                Some(sym) => match sym.declarations.first() {
                    Some(d) => Some(s.resolve(d)?),
                    None => None,
                },
                None => None,
            };
            if is_undefined(&definition, "type") {
                if has(ty.flags, tf::Union)
                    && node
                        .as_ref()
                        .is_none_or(|n| n.kind() != sk::EnumDeclaration)
                {
                    self.get_union_definition(&ty, union_modifier, &definition)?;
                } else if has(ty.flags, tf::Intersection) {
                    self.get_intersection_definition_no_extra_props(&ty, &definition)?;
                } else if is_raw_type {
                    if let Some(paired) = &args.paired_symbol {
                        self.parse_comments_into_definition(
                            Some(paired),
                            &definition,
                            &Value::object(),
                        )?;
                    }
                    self.get_definition_for_root_type(
                        &ty,
                        reffed_type.as_ref(),
                        &definition,
                        args.ignore_undefined,
                    )?;
                } else if node
                    .as_ref()
                    .is_some_and(|n| n.kind() == sk::EnumDeclaration || n.kind() == sk::EnumMember)
                {
                    self.get_enum_definition(&ty, &definition)?;
                } else if let Some(sym) = symbol.as_ref().filter(|sym| {
                    has(sym.flags, sf::TypeLiteral)
                        && node.as_ref().is_none_or(|n| n.kind() != sk::MappedType)
                }) {
                    if s.members_of_symbol(sym)?.is_empty() {
                        set(&definition, "type", Value::str("object"));
                        set(&definition, "properties", Value::Object(Value::object()));
                    } else {
                        self.get_class_definition(&ty, &definition)?;
                    }
                } else {
                    self.get_class_definition(&ty, &definition)?;
                }
            }
        }
        if self
            .recursive_type_ref
            .get(&full_type_name)
            .is_some_and(|d| Rc::ptr_eq(d, &definition))
        {
            self.recursive_type_ref.remove(&full_type_name);
            if self
                .reffed_definitions
                .borrow()
                .get(&full_type_name)
                .is_some_and(|v| v.truthy())
            {
                let r = Value::object();
                set(&r, "$ref", Value::String(ref_uri));
                if let Some(ret) = returned.as_object() {
                    let entries = ret.borrow().entries();
                    for (k, v) in entries {
                        if in_table(ANNOTATION_KEYWORDS, &k) {
                            set(&r, &k, v);
                        }
                    }
                }
                returned = Value::Object(r);
            }
        }
        if other_annotations
            .borrow()
            .get("nullable")
            .is_some_and(|v| v.truthy())
        {
            if let Some(ret) = returned.as_object() {
                make_nullable(ret)?;
            }
        }
        Ok(returned)
    }
}

/// The `TypeError` JavaScript throws when reading `property` of `undefined`.
fn read_error(property: &str) -> Error {
    Error::Generator(format!(
        "Cannot read properties of undefined (reading '{property}')"
    ))
}

/// `addSimpleType`.
fn add_simple_type(def: &Obj, t: &str) -> bool {
    if def
        .borrow()
        .keys()
        .iter()
        .any(|k| !in_table(SIMPLE_TYPES_ALLOWED_PROPERTIES, k))
    {
        return false;
    }
    match get(def, "type") {
        Some(v) if v.truthy() => match v {
            Value::Array(a) => {
                if !a.borrow().iter().all(|v| matches!(v, Value::String(_))) {
                    return false;
                }
                if !a.borrow().iter().any(|v| v.as_str() == Some("null")) {
                    a.borrow_mut().push(Value::str("null"));
                }
                true
            }
            Value::String(s) => {
                if s != "null" {
                    set(
                        def,
                        "type",
                        Value::array(vec![Value::String(s), Value::str("null")]),
                    );
                }
                true
            }
            _ => false,
        },
        _ => {
            set(def, "type", Value::str(t));
            true
        }
    }
}

/// `makeNullable`.
fn make_nullable(def: &Obj) -> Result<()> {
    if add_simple_type(def, "null") {
        return Ok(());
    }
    let union = get(def, "oneOf")
        .filter(Value::truthy)
        .or_else(|| get(def, "anyOf").filter(Value::truthy));
    if let Some(Value::Array(a)) = union {
        let null = Value::object();
        set(&null, "type", Value::str("null"));
        a.borrow_mut().push(Value::Object(null));
        return Ok(());
    }
    let sub = Value::object();
    let entries = def.borrow().entries();
    for (k, v) in entries {
        has_own(def, &k, "def")?;
        sub.borrow_mut().define(&k, v);
        def.borrow_mut().remove(&k);
    }
    let null = Value::object();
    set(&null, "type", Value::str("null"));
    set(
        def,
        "anyOf",
        Value::array(vec![Value::Object(sub), Value::Object(null)]),
    );
    Ok(())
}

/// `Object.keys(obj)` order for a list of distinct keys.
fn js_key_order(keys: Vec<String>) -> Vec<String> {
    let o = Value::object();
    for k in &keys {
        o.borrow_mut().define(k, Value::Null);
    }
    o.borrow().keys()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn nullable_simple_and_complex() {
        let d = Value::object();
        set(&d, "type", Value::str("string"));
        make_nullable(&d).unwrap();
        assert_eq!(
            js::stringify(&Value::Object(d)),
            r#"{"type":["string","null"]}"#
        );
        let d = Value::object();
        set(&d, "$ref", Value::str("#/definitions/A"));
        make_nullable(&d).unwrap();
        assert_eq!(
            js::stringify(&Value::Object(d)),
            r##"{"anyOf":[{"$ref":"#/definitions/A"},{"type":"null"}]}"##
        );
    }

    #[test]
    fn unique_sorted_uses_utf16_order() {
        let v = unique_sorted(vec![
            "b".into(),
            "a".into(),
            "b".into(),
            "\u{ff61}".into(),
            "😀".into(),
        ]);
        assert_eq!(js::stringify(&v), "[\"a\",\"b\",\"😀\",\"｡\"]");
    }
}
