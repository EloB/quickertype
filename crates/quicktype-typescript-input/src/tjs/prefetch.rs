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
use crate::tsc::api::{Query, Session, Symbol, Type};
use crate::tsc::ast::Node;
use crate::tsc::generated::{
    object_flags as of, symbol_flags as sf, syntax_kind as sk, type_flags as tf,
};

use super::{NO_TRUNCATION, USE_FULLY_QUALIFIED_TYPE};

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
    let mut members = Vec::new();
    fn enum_members(n: &Node, out: &mut Vec<Query>) {
        if n.kind() == sk::EnumMember {
            out.push(Query::ConstantValue(n.handle()));
        }
        for c in n.children() {
            enum_members(&c, out);
        }
    }
    for f in files {
        enum_members(f, &mut members);
    }
    s.prefetch(members)?;

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
        if reached.is_empty() && found.is_empty() {
            break;
        }
        (reached, found) = walk.step(reached, found)?;
    }
    Ok(())
}

struct Walk<'s> {
    s: &'s Session,
    seen_types: HashSet<u64>,
    seen_symbols: HashSet<u64>,
    /// Parent handles already asked for (many symbols share a parent).
    asked_parents: HashSet<u64>,
}

impl Walk<'_> {
    /// Whether the generator takes the properties of `t` (with symbol
    /// `sym`): a class, interface or object literal type of a user file.
    fn has_walked_properties(&self, t: &Type, sym: &Symbol) -> Result<bool> {
        if t.flags & tf::Object == 0
            || sym.flags & (sf::Class | sf::Interface | sf::TypeLiteral | sf::ObjectLiteral) == 0
        {
            return Ok(false);
        }
        match sym.declarations.first() {
            Some(d) => Ok(!self.s.is_default_library(&d.path)?),
            None => Ok(false),
        }
    }

    /// One step: everything about the newly reached types and symbols, then
    /// the properties of the classes and interfaces among them and their
    /// types. Returns what the answers reach next.
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
            if !self.seen_types.insert(t.id) {
                continue;
            }
            if r.member && t.flags & LITERAL != 0 {
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
            if r.member && t.flags & tf::Object != 0 {
                // `CreationOrder::reorder` names union members.
                queries.push(Query::TypeToString(t.id, None));
            }
            if t.flags & (tf::Union | tf::Intersection | tf::TemplateLiteral) != 0 {
                queries.push(Query::TypesOfType(t.id));
            }
            if t.flags & (tf::Union | tf::Intersection) == 0 {
                queries.push(Query::IndexInfosOfType(t.id));
            }
            if t.flags & tf::Object != 0 {
                if t.object_flags & of::ClassOrInterface != 0 {
                    queries.push(Query::BaseTypes(t.id));
                }
                if t.object_flags & of::Reference != 0 && t.symbol.is_none() {
                    // Tuples.
                    queries.push(Query::TargetOfType(t.id));
                    queries.push(Query::TypeArguments(t.id));
                }
            }
            visited.push(Rc::clone(t));
        }
        for sym in &found {
            self.symbol_queries(sym, &mut queries)?;
        }
        s.prefetch(queries)?;

        // What the answers reach, and the properties to fetch.
        let mut next: Vec<Reached> = Vec::new();
        let mut next_symbols: Vec<Rc<Symbol>> = Vec::new();
        let mut with_properties = Vec::new();
        let mut queries = Vec::new();
        for t in &visited {
            let reach = |v: Vec<Rc<Type>>, member: bool, next: &mut Vec<Reached>| {
                next.extend(v.into_iter().map(|t| Reached { t, member }));
            };
            if t.flags & (tf::Union | tf::Intersection | tf::TemplateLiteral) != 0 {
                reach(s.types_of_type(t)?, true, &mut next);
            } else if s.knows(&Query::IndexInfosOfType(t.id)) {
                for i in s.index_infos_of_type(t)? {
                    reach(vec![i.key_type, i.value_type], false, &mut next);
                }
            }
            if s.knows(&Query::BaseTypes(t.id)) {
                reach(s.base_types(t)?, false, &mut next);
            }
            if s.knows(&Query::TypeArguments(t.id)) {
                reach(s.type_arguments(t)?, false, &mut next);
            }
            if let Some(alias) = t.alias_symbol.and_then(|h| s.known_symbol(h)) {
                next_symbols.push(alias);
            }
            let Some(sym) = t.symbol.and_then(|h| s.known_symbol(h)) else {
                continue;
            };
            next_symbols.push(Rc::clone(&sym));
            if self.has_walked_properties(t, &sym)? {
                queries.push(Query::PropertiesOfType(t.id));
                if t.object_flags & of::Reference != 0 && t.object_flags & of::ClassOrInterface == 0
                {
                    // An instantiated generic: its properties are ordered by
                    // the generic's.
                    queries.push(Query::TargetOfType(t.id));
                }
                with_properties.push(Rc::clone(t));
            }
        }
        s.prefetch(queries)?;

        let mut queries = Vec::new();
        let mut properties = Vec::new();
        for t in &with_properties {
            if let Some(target) = s.target_of_type(t).ok().flatten() {
                next.push(Reached {
                    t: target,
                    member: false,
                });
            }
            if !s.knows(&Query::PropertiesOfType(t.id)) {
                continue;
            }
            for p in s.properties_of_type(t)? {
                queries.push(Query::TypeOfSymbol(p.id));
                self.symbol_queries(&p, &mut queries)?;
                properties.push(p);
            }
        }
        s.prefetch(queries)?;
        for p in properties {
            if s.knows(&Query::TypeOfSymbol(p.id)) {
                let t = s.type_of_symbol(&p)?;
                next.push(Reached { t, member: false });
            }
        }
        next.retain(|r| !self.seen_types.contains(&r.t.id));
        next_symbols.retain(|sym| !self.seen_symbols.contains(&sym.id));
        Ok((next, next_symbols))
    }

    /// The questions about a newly found symbol: its JSDoc, members and
    /// parent.
    fn symbol_queries(&mut self, sym: &Rc<Symbol>, out: &mut Vec<Query>) -> Result<()> {
        if !self.seen_symbols.insert(sym.id) {
            return Ok(());
        }
        out.push(Query::JsDocTags(sym.id));
        // The generator asks for the documentation comment of a symbol
        // outside the libraries when its declarations have none to read.
        let from_lib = match sym.declarations.first() {
            Some(d) => self.s.is_default_library(&d.path)?,
            None => false,
        };
        if !from_lib {
            let mut undocumented = true;
            for d in &sym.declarations {
                undocumented &= self.s.resolve(d)?.js_doc().is_empty();
            }
            if undocumented {
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
        Ok(())
    }
}
