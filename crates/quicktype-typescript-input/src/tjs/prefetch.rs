//! Asks the checker, in a few pipelined batches, what the generator will
//! ask one question at a time.
//!
//! The generator walks the type graph depth first and needs an answer
//! before it knows its next question, so asked directly every answer costs
//! a round trip to the compiler: about ninety per interface. This walk visits
//! the same graph breadth first, starting at the declarations, and asks for
//! each newly reached type and symbol everything the generator may need
//! (its name, members, index signatures, properties and their types, JSDoc)
//! in one [`Session::prefetch`] per step. The answers fill the session's
//! caches; the generator then runs on them and asks the compiler only for
//! what this walk did not foresee. Asking more than the generator needs
//! costs a little time, never a different result: every query is a pure
//! function of the snapshot.

use std::collections::HashSet;
use std::rc::Rc;

use crate::error::Result;
use crate::tsc::api::{IndexInfo, Query, Session, Symbol, Type, type_at_is_declared_type};
use crate::tsc::ast::Node;
use crate::tsc::generated::{
    object_flags as of, symbol_flags as sf, syntax_kind as sk, type_flags as tf,
};

use super::{
    NO_TRUNCATION, NODE_BUILDER_IN_TYPE_ALIAS, NODE_BUILDER_NO_TRUNCATION, USE_FULLY_QUALIFIED_TYPE,
};

/// Steps after which the walk stops (each is one pipelined batch or two);
/// whatever it has not reached by then is asked for on demand.
const MAX_STEPS: usize = 256;

const LITERAL: u32 = tf::StringLiteral | tf::NumberLiteral | tf::BooleanLiteral | tf::EnumLiteral;

/// A type to visit, and whether it was reached as a union or intersection
/// member (the generator takes literal members as values, not types).
struct Reached {
    t: Rc<Type>,
    member: bool,
}

/// Fetches answers for the types and symbols reachable from `types` and
/// `symbols` (the declarations of the user files), and the constant values
/// of the enum members in `files`.
pub fn warm(s: &Session, files: &[Node], types: &[Rc<Type>], symbols: &[Rc<Symbol>]) -> Result<()> {
    // Enum members' values, and the symbols that JSDoc links name (the
    // generator renders `{@link X}` by them).
    let mut queries = Vec::new();
    fn in_files(n: &Node, out: &mut Vec<Query>) {
        match n.kind() {
            sk::EnumMember => out.push(Query::ConstantValue(n.handle())),
            sk::JSDocLink | sk::JSDocLinkCode | sk::JSDocLinkPlain => {
                if let Some(name) = n.named("name") {
                    out.push(Query::SymbolAt(name.handle()));
                }
            }
            _ => {}
        }
        for c in n.raw_children() {
            in_files(&c, out);
        }
    }
    for f in files {
        in_files(f, &mut queries);
    }
    s.prefetch(queries)?;

    let mut walk = Walk {
        s,
        seen_types: HashSet::new(),
        seen_symbols: HashSet::new(),
        asked_parents: HashSet::new(),
    };
    let mut reached: Vec<Reached> = types
        .iter()
        .map(|t| Reached {
            t: Rc::clone(t),
            member: false,
        })
        .collect();
    let mut found: Vec<Rc<Symbol>> = symbols.to_vec();
    for _ in 0..MAX_STEPS {
        if !s.pipelining() || reached.is_empty() && found.is_empty() {
            break;
        }
        (reached, found) = walk.step(reached, found)?;
    }
    s.finish_prefetch();
    Ok(())
}

/// The one index signature of a class or interface declaration, which the
/// generator asks about: its parameter's name and its type node.
struct IndexSignature {
    owner: Node,
    parameter: Option<Node>,
    ty: Option<Node>,
}

struct Walk<'s> {
    s: &'s Session,
    seen_types: HashSet<u64>,
    seen_symbols: HashSet<u64>,
    /// Parent handles already asked for (many symbols share a parent).
    asked_parents: HashSet<u64>,
}

impl Walk<'_> {
    /// Whether a declaration's file is a default library, if the session
    /// knows (it knows every file of the program from the start).
    fn in_default_library(&self, path: &str) -> Option<bool> {
        self.s
            .cached::<bool>(&Query::IsDefaultLibrary(path.to_owned()))
    }

    /// Whether the generator takes the properties of `t` (with symbol
    /// `sym`): a class, interface or object literal type of a user file, or
    /// one of a library that the generator does not take as a raw type (an
    /// array-like, `Date`) or a built-in it treats apart (`Map`, `Set`, …):
    /// `Partial<T>` and the other mapped types, `Window`, `RegExp`, ….
    fn has_walked_properties(&self, t: &Type, sym: &Symbol) -> bool {
        let Some(d) = sym.declarations.first() else {
            return false;
        };
        if t.flags & tf::TypeParameter != 0 {
            // A generic declaration's type parameter: the generator takes it
            // as a class with its constraint's properties.
            return self.in_default_library(&d.path) == Some(false);
        }
        let objects = sf::Class | sf::Interface | sf::TypeLiteral | sf::ObjectLiteral;
        if t.flags & tf::Object == 0 || sym.flags & (objects | sf::Function) == 0 {
            return false;
        }
        match self.in_default_library(&d.path) {
            Some(false) => true,
            Some(true) if sym.flags & objects == 0 => false,
            Some(true) => {
                let number_index = self
                    .s
                    .cached::<Vec<IndexInfo>>(&Query::IndexInfosOfType(t.id))
                    .map(|infos| infos.iter().any(|i| i.key_type.flags & tf::Number != 0));
                number_index == Some(false)
                    && !matches!(
                        sym.name.as_str(),
                        "Date" | "Map" | "ReadonlyMap" | "Set" | "WeakMap" | "WeakSet" | "Promise"
                    )
            }
            None => false,
        }
    }

    /// The index signature `get_class_definition` reads from the first
    /// declaration of `sym`, when it has exactly one.
    fn index_signature(&self, sym: &Symbol) -> Option<IndexSignature> {
        let owner = self.s.loaded(sym.declarations.first()?)?;
        let mut signatures = owner
            .named_list("members")
            .into_iter()
            .filter(|m| m.kind() == sk::IndexSignature);
        let (Some(sig), None) = (signatures.next(), signatures.next()) else {
            return None;
        };
        let parameter = match sig.named_list("parameters").as_slice() {
            [p] => p.named("name"),
            _ => None,
        };
        Some(IndexSignature {
            ty: sig.named("type"),
            parameter,
            owner,
        })
    }

    /// One step: everything about the newly reached types and symbols, then
    /// the properties of the classes and interfaces among them and their
    /// types. Returns what the answers reach next. It sends nothing but
    /// batches and reads answers only from the cache, so a question the
    /// compiler answered with an error leaves that part of the graph to the
    /// generator, which asks it as it would without the walk.
    fn step(
        &mut self,
        reached: Vec<Reached>,
        found: Vec<Rc<Symbol>>,
    ) -> Result<(Vec<Reached>, Vec<Rc<Symbol>>)> {
        let s = self.s;
        let mut queries = Vec::new();
        let mut visited = Vec::new();
        for r in reached {
            let t = &r.t;
            if r.member && t.flags & tf::Object != 0 {
                // `CreationOrder::reorder` names union members, also ones
                // first reached otherwise.
                queries.push(Query::TypeToString(t.id, None));
            }
            // A literal member is a value to the generator; the same type
            // reached otherwise is still visited.
            if r.member && t.flags & LITERAL != 0 || !self.seen_types.insert(t.id) {
                continue;
            }
            if let Some(h) = t.symbol {
                if s.known_symbol(h).is_none() {
                    queries.push(Query::SymbolOfType(t.id));
                }
            }
            if let Some(h) = t.alias_symbol {
                if s.known_symbol(h).is_none() {
                    queries.push(Query::AliasSymbolOfType(t.id));
                }
            }
            queries.push(Query::TypeToString(
                t.id,
                Some(NO_TRUNCATION | USE_FULLY_QUALIFIED_TYPE),
            ));
            queries.push(Query::TypeToString(t.id, Some(USE_FULLY_QUALIFIED_TYPE)));
            if t.flags & (tf::Union | tf::Intersection | tf::TemplateLiteral) != 0 {
                queries.push(Query::TypesOfType(t.id));
            }
            if t.flags & (tf::Union | tf::Intersection) == 0 || t.symbol.is_some() {
                // A union with a symbol is an enum, which the generator also
                // asks for a numeric index signature.
                queries.push(Query::IndexInfosOfType(t.id));
            }
            if t.flags & tf::Object != 0 {
                if t.object_flags & of::ClassOrInterface != 0 {
                    queries.push(Query::BaseTypes(t.id));
                }
                if t.object_flags & of::Reference != 0 && t.symbol.is_none()
                    || t.object_flags & of::Tuple != 0
                {
                    // Tuples, whose labels come from the type printed as a node.
                    queries.push(Query::TargetOfType(t.id));
                    queries.push(Query::TypeArguments(t.id));
                    queries.push(Query::TypeToTypeNode(
                        t.id,
                        NODE_BUILDER_NO_TRUNCATION | NODE_BUILDER_IN_TYPE_ALIAS,
                    ));
                }
            }
            visited.push(Rc::clone(t));
        }
        for sym in &found {
            self.symbol_queries(sym, &mut queries);
        }
        s.prefetch(queries)?;

        // What the answers reach, and the properties to fetch.
        let mut next: Vec<Reached> = Vec::new();
        let mut next_symbols: Vec<Rc<Symbol>> = Vec::new();
        let mut with_properties = Vec::new();
        let mut signatures = Vec::new();
        let mut arguments = Vec::new();
        let mut queries = Vec::new();
        let reach = |v: Option<Vec<Rc<Type>>>, member: bool, next: &mut Vec<Reached>| {
            next.extend(v.into_iter().flatten().map(|t| Reached { t, member }));
        };
        for t in &visited {
            if t.flags & (tf::Union | tf::Intersection | tf::TemplateLiteral) != 0 {
                reach(s.cached(&Query::TypesOfType(t.id)), true, &mut next);
            } else if let Some(infos) = s.cached::<Vec<IndexInfo>>(&Query::IndexInfosOfType(t.id)) {
                for i in infos {
                    reach(Some(vec![i.key_type, i.value_type]), false, &mut next);
                }
            }
            reach(s.cached(&Query::BaseTypes(t.id)), false, &mut next);
            reach(s.cached(&Query::TypeArguments(t.id)), false, &mut next);
            if let Some(alias) = t.alias_symbol.and_then(|h| s.known_symbol(h)) {
                if matches!(alias.escaped_name.as_str(), "Readonly" | "Mutable") {
                    // The generator unwraps them to their argument.
                    arguments.push(Query::AliasTypeArguments(t.id));
                }
                next_symbols.push(alias);
            }
            let Some(sym) = t.symbol.and_then(|h| s.known_symbol(h)) else {
                continue;
            };
            match sym.name.as_str() {
                // A map's value type, which the generator converts.
                "Map" | "ReadonlyMap" if t.object_flags & of::Reference != 0 => {
                    arguments.push(Query::TypeArguments(t.id));
                }
                // Built-ins the generator rejects, naming the type.
                "Set" | "WeakMap" | "WeakSet" | "Promise" => {
                    queries.push(Query::TypeToString(t.id, None));
                }
                _ => {}
            }
            next_symbols.push(Rc::clone(&sym));
            if self.has_walked_properties(t, &sym) {
                queries.push(Query::PropertiesOfType(t.id));
                if let Some(sig) = self.index_signature(&sym) {
                    if let Some(name) = &sig.parameter {
                        queries.push(Query::SymbolAt(name.handle()));
                    }
                    if let Some(ty) = &sig.ty {
                        queries.push(Query::TypeAt(ty.handle()));
                    }
                    signatures.push(sig);
                }
                if t.object_flags & of::Reference != 0 && t.object_flags & of::ClassOrInterface == 0
                {
                    // An instantiated generic: its properties are ordered by
                    // the generic's.
                    queries.push(Query::TargetOfType(t.id));
                }
                with_properties.push(Rc::clone(t));
            }
        }
        queries.extend(arguments.iter().cloned());
        s.prefetch(queries)?;
        for q in &arguments {
            reach(s.cached(q), false, &mut next);
        }

        let mut queries = Vec::new();
        let mut properties = Vec::new();
        let mut located = Vec::new();
        let mut index_symbols = Vec::new();
        for sig in &signatures {
            let ty = sig
                .ty
                .as_ref()
                .and_then(|n| s.cached(&Query::TypeAt(n.handle())));
            if let Some(Some(t)) = ty {
                next.push(Reached { t, member: false });
            }
            let sym = sig
                .parameter
                .as_ref()
                .and_then(|n| s.cached(&Query::SymbolAt(n.handle())));
            if let Some(Some(sym)) = sym {
                let sym: Rc<Symbol> = sym;
                queries.push(Query::TypeOfSymbolAt(sym.id, sig.owner.handle()));
                index_symbols.push((sym, sig.owner.clone()));
            }
        }
        for t in &with_properties {
            let target = t.target.and_then(|h| s.known_type(h)).or_else(|| {
                s.cached::<Option<Rc<Type>>>(&Query::TargetOfType(t.id))
                    .flatten()
            });
            if let Some(target) = target {
                next.push(Reached {
                    t: target,
                    member: false,
                });
            }
            let Some(props) = s.cached::<Vec<Rc<Symbol>>>(&Query::PropertiesOfType(t.id)) else {
                continue;
            };
            // `get_class_definition` asks for each property's type at the
            // first declaration of the type's symbol.
            let owner = t
                .symbol
                .and_then(|h| s.known_symbol(h))
                .and_then(|sym| sym.declarations.first().map(|d| d.to_handle()));
            for p in props {
                queries.push(Query::TypeOfSymbol(p.id));
                if let Some(owner) = &owner {
                    if !type_at_is_declared_type(&p, owner) {
                        queries.push(Query::TypeOfSymbolAt(p.id, owner.clone()));
                        located.push((Rc::clone(&p), owner.clone()));
                    }
                }
                self.symbol_queries(&p, &mut queries);
                properties.push(p);
            }
        }
        s.prefetch(queries)?;
        for p in properties {
            if let Some(Some(t)) = s.cached(&Query::TypeOfSymbol(p.id)) {
                next.push(Reached { t, member: false });
            }
        }
        for (sym, owner) in index_symbols {
            if let Some(Some(t)) = s.cached(&Query::TypeOfSymbolAt(sym.id, owner.handle())) {
                next.push(Reached { t, member: false });
            }
        }
        for (p, owner) in located {
            if let Some(Some(t)) = s.cached(&Query::TypeOfSymbolAt(p.id, owner)) {
                next.push(Reached { t, member: false });
            }
        }
        // Union members already seen still need their union-member name.
        next.retain(|r| {
            !self.seen_types.contains(&r.t.id) || r.member && r.t.flags & tf::Object != 0
        });
        next_symbols.retain(|sym| !self.seen_symbols.contains(&sym.id));
        Ok((next, next_symbols))
    }

    /// The questions about a newly found symbol: its JSDoc, members and
    /// parent.
    fn symbol_queries(&mut self, sym: &Rc<Symbol>, out: &mut Vec<Query>) {
        if !self.seen_symbols.insert(sym.id) {
            return;
        }
        out.push(Query::JsDocTags(sym.id));
        // The generator asks for the documentation comment of a symbol
        // outside the libraries when its declarations have none to read.
        let from_lib = sym
            .declarations
            .first()
            .and_then(|d| self.in_default_library(&d.path));
        if from_lib != Some(true) {
            let documented = sym.declarations.iter().any(|d| {
                self.s
                    .loaded(d)
                    .is_some_and(|decl| decl.js_doc().iter().any(Node::has_comment))
            });
            if !documented {
                out.push(Query::DocumentationComment(sym.id));
            }
        }
        if sym.flags & sf::TypeLiteral != 0 {
            out.push(Query::MembersOfSymbol(sym.id));
        }
        if sym.flags & sf::Alias != 0 {
            out.push(Query::AliasedSymbol(sym.id));
        }
        if let Some(p) = sym.parent {
            if self.s.known_symbol(p).is_none() && self.asked_parents.insert(p) {
                out.push(Query::ParentOfSymbol(sym.id));
            }
        }
    }
}
