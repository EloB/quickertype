//! TypeScript 5.9 orderings that TypeScript 7 does not reproduce.
//!
//! **Union and intersection members.** TypeScript 5.9 sorts constituents by
//! type id, i.e. by the order in which its checker created the types while
//! checking the program (library files first, then each source file
//! statement by statement). TypeScript 7 sorts object types by name instead.
//! typescript-json-schema emits `anyOf` in constituent order, so the order is
//! visible in the schema (and in languages that print union members in graph
//! order). [`CreationOrder`] replays the parts of TypeScript 5.9's check that
//! create types — `checkSourceElement` for declarations and type nodes, and
//! `getTypeFromTypeNode` with its deferred type references — over the TS 7
//! AST, and assigns each type a virtual creation index. Types the replay
//! never reaches, and the instantiations TypeScript 5.9's library check
//! creates first ([`LIB_CREATED`]), rank before all others.
//!
//! **Inherited properties.** TypeScript 5.9 lists a class's or interface's
//! own members first, then each base type's properties in that base's order
//! (`resolveObjectTypeMembers`/`addInheritedMembers`); TypeScript 7 differs
//! for chains of two or more `extends`.

use std::collections::{HashMap, HashSet};
use std::rc::Rc;

use super::Generator;
use crate::error::Result;
use crate::tsc::api::{Session, Symbol, Type};
use crate::tsc::ast::Node;
use crate::tsc::generated::{
    object_flags as of, symbol_flags as sf, syntax_kind as sk, type_flags as tf,
};

/// Object types TypeScript 5.9 has already created when it reaches user code
/// (measured with the libraries quicktype loads: es2015, dom,
/// webworker.importscripts, scripthost), by `typeToString`.
const LIB_CREATED: &[&str] = &[
    "string[]",
    "number[]",
    "boolean[]",
    "any[]",
    "unknown[]",
    "never[]",
    "symbol[]",
    "string[][]",
    "readonly string[]",
    "[string, string]",
    "[number, number]",
    "Promise<any>",
];

/// Virtual TypeScript 5.9 creation indices of the program's types.
#[derive(Default)]
pub struct CreationOrder {
    index: HashMap<u64, usize>,
    lib_created: HashSet<u64>,
}

fn key(n: &Node) -> (usize, usize) {
    (Rc::as_ptr(n.source_file()) as usize, n.index())
}

const TYPE_NODE_KINDS: &[u32] = &[
    sk::TypeReference,
    sk::ArrayType,
    sk::TupleType,
    sk::UnionType,
    sk::IntersectionType,
    sk::TypeLiteral,
    sk::ParenthesizedType,
    sk::TypeOperator,
    sk::IndexedAccessType,
    sk::MappedType,
    sk::ConditionalType,
    sk::NamedTupleMember,
    sk::OptionalType,
    sk::RestType,
    sk::TemplateLiteralType,
    sk::TypeQuery,
    sk::FunctionType,
    sk::ConstructorType,
    sk::ImportType,
    sk::LiteralType,
    sk::ExpressionWithTypeArguments,
];

struct Replay<'a> {
    types: HashMap<(usize, usize), u64>,
    alias_decls: HashMap<(usize, usize), Option<Node>>,
    may_alias: HashMap<(usize, usize), bool>,
    resolved: HashSet<(usize, usize)>,
    resolved_aliases: HashSet<(usize, usize)>,
    order: &'a mut CreationOrder,
    next: usize,
}

impl Replay<'_> {
    fn create(&mut self, n: &Node) {
        if let Some(id) = self.types.get(&key(n)) {
            if !self.order.index.contains_key(id) {
                self.order.index.insert(*id, self.next);
                self.next += 1;
            }
        }
    }

    fn check_statements(&mut self, statements: Vec<Node>) {
        for st in statements {
            match st.kind() {
                sk::InterfaceDeclaration | sk::ClassDeclaration => {
                    // checkInterfaceDeclaration's lazy block, which runs eagerly
                    // under getPreEmitDiagnostics: the declared type, its base
                    // types, then checkIndexConstraints (index signature types,
                    // then every property type), before the members are checked.
                    self.create(&st);
                    let members = st.named_list("members");
                    if st.kind() == sk::InterfaceDeclaration {
                        for clause in st.named_list("heritageClauses") {
                            for t in clause.named_list("types") {
                                self.resolve(&t);
                            }
                        }
                        if members.iter().any(|m| m.kind() == sk::IndexSignature) {
                            for m in members.iter().filter(|m| m.kind() == sk::IndexSignature) {
                                if let Some(t) = m.named("type") {
                                    self.resolve(&t);
                                }
                            }
                            for m in members.iter().filter(|m| m.kind() == sk::PropertySignature) {
                                if let Some(t) = m.named("type") {
                                    self.resolve(&t);
                                }
                            }
                        }
                    }
                    for clause in st.named_list("heritageClauses") {
                        for t in clause.named_list("types") {
                            for a in t.named_list("typeArguments") {
                                self.check_type(&a);
                            }
                        }
                    }
                    for m in members {
                        self.check_member(&m);
                    }
                }
                sk::TypeAliasDeclaration => {
                    if let Some(t) = st.named("type") {
                        self.check_type(&t);
                    }
                }
                sk::EnumDeclaration => self.create(&st),
                sk::ModuleDeclaration => {
                    let mut body = st.named("body");
                    while let Some(b) = body.clone().filter(|b| b.kind() == sk::ModuleDeclaration) {
                        body = b.named("body");
                    }
                    if let Some(b) = body {
                        self.check_statements(b.named_list("statements"));
                    }
                }
                _ => {}
            }
        }
    }

    fn check_member(&mut self, m: &Node) {
        for p in m.named_list("parameters") {
            if let Some(t) = p.named("type") {
                self.check_type(&t);
                self.resolve(&t);
            }
        }
        if let Some(t) = m.named("type") {
            self.check_type(&t);
            self.resolve(&t);
        }
    }

    /// `checkSourceElement` on a type node.
    fn check_type(&mut self, n: &Node) {
        match n.kind() {
            sk::TypeReference => {
                for a in n.named_list("typeArguments") {
                    self.check_type(&a);
                }
                self.resolve(n);
            }
            sk::ArrayType => {
                if let Some(e) = n.named("elementType") {
                    self.check_type(&e);
                }
            }
            sk::TupleType => {
                for e in n.named_list("elements") {
                    self.check_type(&e);
                }
                self.resolve(n);
            }
            sk::UnionType | sk::IntersectionType => {
                for t in n.named_list("types") {
                    self.check_type(&t);
                }
                self.resolve(n);
            }
            sk::TypeLiteral => {
                for m in n.named_list("members") {
                    self.check_member(&m);
                }
                self.resolve(n);
            }
            sk::ParenthesizedType
            | sk::TypeOperator
            | sk::OptionalType
            | sk::RestType
            | sk::NamedTupleMember => {
                if let Some(t) = n.named("type") {
                    self.check_type(&t);
                }
            }
            k if TYPE_NODE_KINDS.contains(&k) => {
                for c in n.children() {
                    self.check_type(&c);
                }
                self.resolve(n);
            }
            _ => {}
        }
    }

    /// `getTypeFromTypeNode`, which creates a node's type once.
    fn resolve(&mut self, n: &Node) {
        if !self.resolved.insert(key(n)) {
            return;
        }
        match n.kind() {
            sk::ExpressionWithTypeArguments => {
                for a in n.named_list("typeArguments") {
                    self.resolve(&a);
                }
                self.create(n);
            }
            sk::TypeReference => {
                if let Some(Some(decl)) = self.alias_decls.get(&key(n)).cloned() {
                    if self.resolved_aliases.insert(key(&decl)) {
                        if let Some(t) = decl.named("type") {
                            self.resolve(&t);
                        }
                    }
                    for a in n.named_list("typeArguments") {
                        self.resolve(&a);
                    }
                } else if !self.deferred(n) {
                    for a in n.named_list("typeArguments") {
                        self.resolve(&a);
                    }
                }
                self.create(n);
            }
            sk::ArrayType => {
                if !self.deferred(n) {
                    if let Some(e) = n.named("elementType") {
                        self.resolve(&e);
                    }
                }
                self.create(n);
            }
            sk::TupleType => {
                if !self.deferred(n) {
                    for e in n.named_list("elements") {
                        self.resolve(&e);
                    }
                }
                self.create(n);
            }
            sk::UnionType | sk::IntersectionType => {
                for t in n.named_list("types") {
                    self.resolve(&t);
                }
                self.create(n);
            }
            sk::TypeLiteral => self.create(n),
            sk::ParenthesizedType
            | sk::NamedTupleMember
            | sk::OptionalType
            | sk::RestType
            | sk::TypeOperator => {
                if let Some(t) = n.named("type") {
                    self.resolve(&t);
                }
                self.create(n);
            }
            k if TYPE_NODE_KINDS.contains(&k) => {
                for c in n.children() {
                    self.resolve(&c);
                }
                self.create(n);
            }
            _ => {}
        }
    }

    /// `isDeferredTypeReferenceNode` (without default type arguments).
    fn deferred(&self, n: &Node) -> bool {
        let mut host = n.parent();
        while let Some(h) = host.clone().filter(|h| {
            h.kind() == sk::ParenthesizedType
                || h.kind() == sk::TypeOperator && h.operator() == Some(sk::ReadonlyKeyword)
        }) {
            host = h.parent();
        }
        if host.is_some_and(|h| h.kind() == sk::TypeAliasDeclaration) {
            return true;
        }
        if !resolved_by_type_alias(n) {
            return false;
        }
        match n.kind() {
            sk::ArrayType => n
                .named("elementType")
                .is_some_and(|e| self.may_resolve_type_alias(&e)),
            sk::TupleType => n
                .named_list("elements")
                .iter()
                .any(|e| self.may_resolve_type_alias(e)),
            _ => n
                .named_list("typeArguments")
                .iter()
                .any(|a| self.may_resolve_type_alias(a)),
        }
    }

    /// `mayResolveTypeAlias`.
    fn may_resolve_type_alias(&self, n: &Node) -> bool {
        match n.kind() {
            sk::TypeReference => self.may_alias.get(&key(n)).copied().unwrap_or(false),
            sk::TypeQuery => true,
            sk::TypeOperator if n.operator() == Some(sk::UniqueKeyword) => false,
            sk::TypeOperator | sk::ParenthesizedType | sk::OptionalType | sk::NamedTupleMember => n
                .named("type")
                .is_some_and(|t| self.may_resolve_type_alias(&t)),
            sk::RestType => n.named("type").is_some_and(|t| {
                t.kind() != sk::ArrayType
                    || t.named("elementType")
                        .is_some_and(|e| self.may_resolve_type_alias(&e))
            }),
            sk::UnionType | sk::IntersectionType => n
                .named_list("types")
                .iter()
                .any(|t| self.may_resolve_type_alias(t)),
            sk::IndexedAccessType => ["objectType", "indexType"]
                .iter()
                .any(|p| n.named(p).is_some_and(|t| self.may_resolve_type_alias(&t))),
            sk::ConditionalType => ["checkType", "extendsType", "trueType", "falseType"]
                .iter()
                .any(|p| n.named(p).is_some_and(|t| self.may_resolve_type_alias(&t))),
            _ => false,
        }
    }
}

/// `isResolvedByTypeAlias`.
fn resolved_by_type_alias(n: &Node) -> bool {
    let mut cur = n.clone();
    while let Some(p) = cur.parent() {
        match p.kind() {
            sk::ParenthesizedType
            | sk::NamedTupleMember
            | sk::TypeReference
            | sk::UnionType
            | sk::IntersectionType
            | sk::IndexedAccessType
            | sk::ConditionalType
            | sk::TypeOperator
            | sk::ArrayType
            | sk::TupleType => cur = p,
            sk::TypeAliasDeclaration => return true,
            _ => return false,
        }
    }
    false
}

fn collect(n: &Node, decls: &mut Vec<Node>, type_nodes: &mut Vec<Node>, refs: &mut Vec<Node>) {
    let k = n.kind();
    if matches!(
        k,
        sk::InterfaceDeclaration | sk::ClassDeclaration | sk::EnumDeclaration
    ) {
        decls.push(n.clone());
    }
    if TYPE_NODE_KINDS.contains(&k) && k != sk::LiteralType {
        type_nodes.push(n.clone());
        if k == sk::TypeReference {
            refs.push(n.clone());
        }
    }
    for c in n.children() {
        collect(&c, decls, type_nodes, refs);
    }
}

impl CreationOrder {
    /// Replays TypeScript 5.9's type creation over the user files.
    pub fn compute(s: &Session, user_files: &[Node]) -> Result<CreationOrder> {
        let mut order = CreationOrder::default();
        let (mut decls, mut type_nodes, mut refs) = (Vec::new(), Vec::new(), Vec::new());
        for f in user_files {
            collect(f, &mut decls, &mut type_nodes, &mut refs);
        }
        let mut types = HashMap::new();
        let all: Vec<Node> = decls.iter().chain(type_nodes.iter()).cloned().collect();
        for (n, t) in all.iter().zip(s.types_at(&all)?) {
            if let Some(t) = t {
                types.insert(key(n), t.id);
            }
        }
        let names: Vec<Node> = refs
            .iter()
            .map(|r| r.named("typeName").unwrap_or_else(|| r.clone()))
            .collect();
        let mut alias_decls = HashMap::new();
        let mut may_alias = HashMap::new();
        for (r, sym) in refs.iter().zip(s.symbols_at(&names)?) {
            let mut sym = sym;
            if let Some(a) = sym.as_ref().filter(|a| a.flags & sf::Alias != 0) {
                sym = Some(s.aliased_symbol(a)?);
            }
            let Some(sym) = sym else { continue };
            may_alias.insert(key(r), sym.flags & sf::TypeAlias != 0);
            let mut decl = None;
            if let Some(h) = sym.declarations.first() {
                if !s.is_default_library(&h.path)? {
                    let d = s.resolve(h)?;
                    if d.kind() == sk::TypeAliasDeclaration {
                        decl = Some(d);
                    }
                }
            }
            alias_decls.insert(key(r), decl);
        }
        let mut replay = Replay {
            types,
            alias_decls,
            may_alias,
            resolved: HashSet::new(),
            resolved_aliases: HashSet::new(),
            order: &mut order,
            next: 0,
        };
        for f in user_files {
            replay.check_statements(f.named_list("statements"));
        }
        Ok(order)
    }

    /// Reorders the object-type members of a union or intersection by
    /// TypeScript 5.9 creation order; other members keep their positions.
    pub fn reorder(&mut self, s: &Session, types: Vec<Rc<Type>>) -> Result<Vec<Rc<Type>>> {
        let slots: Vec<usize> = (0..types.len())
            .filter(|i| types[*i].flags & tf::Object != 0)
            .collect();
        if slots.len() < 2 || self.index.is_empty() {
            return Ok(types);
        }
        let mut objects = Vec::new();
        for (pos, i) in slots.iter().enumerate() {
            let t = &types[*i];
            if !self.lib_created.contains(&t.id)
                && LIB_CREATED.contains(&s.type_to_string(t, None)?.as_str())
            {
                self.lib_created.insert(t.id);
            }
            let rank = if self.lib_created.contains(&t.id) {
                (0, 0)
            } else {
                match self.index.get(&t.id) {
                    Some(v) => (1, *v),
                    None => (0, 0),
                }
            };
            objects.push((rank, pos, Rc::clone(t)));
        }
        objects.sort_by(|a, b| a.0.cmp(&b.0).then(a.1.cmp(&b.1)));
        let mut out = types;
        for (slot, (_, _, t)) in slots.iter().zip(objects) {
            out[*slot] = t;
        }
        Ok(out)
    }
}

impl Generator<'_> {
    /// `getPropertiesOfType`, in TypeScript 5.9's order for classes and
    /// interfaces.
    pub(super) fn ts5_properties_of_type(&mut self, t: &Rc<Type>) -> Result<Vec<Rc<Symbol>>> {
        let props = self.s.properties_of_type(t)?;
        let Some(order) = self.ts5_names(t, 0)? else {
            return Ok(props);
        };
        let mut ranked: Vec<(usize, Rc<Symbol>)> = props
            .into_iter()
            .enumerate()
            .map(|(i, p)| {
                (
                    order
                        .iter()
                        .position(|n| *n == p.name)
                        .unwrap_or(order.len() + i),
                    p,
                )
            })
            .collect();
        ranked.sort_by_key(|(r, _)| *r);
        Ok(ranked.into_iter().map(|(_, p)| p).collect())
    }

    fn ts5_names(&mut self, t: &Rc<Type>, depth: usize) -> Result<Option<Vec<String>>> {
        let s = self.s;
        let mut t = Rc::clone(t);
        if t.flags & tf::Object != 0
            && t.object_flags & of::Reference != 0
            && t.object_flags & of::ClassOrInterface == 0
        {
            if let Some(target) = s.target_of_type(&t)? {
                t = target;
            }
        }
        if t.flags & tf::Object == 0 || t.object_flags & of::ClassOrInterface == 0 || depth > 32 {
            return Ok(None);
        }
        let Some(sym) = s.symbol_of_type(&t)? else {
            return Ok(None);
        };
        // Own members in declaration order: (declaration index, node index).
        let mut own = Vec::new();
        for p in s.properties_of_type(&t)? {
            let Some(d) = p.declarations.first() else {
                continue;
            };
            if p.parent != Some(sym.id) {
                continue;
            }
            let mut container = s.resolve(d)?.parent();
            if container
                .as_ref()
                .is_some_and(|c| c.kind() == sk::Constructor)
            {
                container = container.and_then(|c| c.parent());
            }
            let ci = sym
                .declarations
                .iter()
                .position(|h| {
                    container
                        .as_ref()
                        .is_some_and(|c| h.path == d.path && h.index == c.index())
                })
                .unwrap_or(usize::MAX);
            own.push(((ci, d.index), p.name.clone()));
        }
        own.sort_by_key(|(k, _)| *k);
        let mut names: Vec<String> = Vec::new();
        for (_, n) in own {
            if !names.contains(&n) {
                names.push(n);
            }
        }
        for base in s.base_types(&t)? {
            let base_names = match self.ts5_names(&base, depth + 1)? {
                Some(n) => n,
                None => s
                    .properties_of_type(&base)?
                    .iter()
                    .map(|p| p.name.clone())
                    .collect(),
            };
            for n in base_names {
                if !names.contains(&n) {
                    names.push(n);
                }
            }
        }
        Ok(Some(names))
    }
}
