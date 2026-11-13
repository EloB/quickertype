//! Port of `packages/quicktype-core/src/DeclarationIR.ts`.
//!
//! The order in which renderers declare types
//! ([`declarations_for_graph`]), including forward declarations for
//! languages that must declare a type before using it, and the types that
//! break cycles in languages that need indirection for recursive types
//! ([`cycle_breaker_types_for_graph`]).

use std::collections::HashSet;

use indexmap::IndexSet;

use crate::graph::Graph;
use crate::messages::{ErrorKind, MessageValue, Result, message_error};
use crate::support::collection_utils::{set_intersect, set_subtract};
use crate::support::support::{assert, panic};
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `DeclarationKind`.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum DeclarationKind {
    /// `"forward"`: a forward declaration.
    Forward,
    /// `"define"`: the definition.
    Define,
}

/// `Declaration`.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct Declaration {
    /// Forward declaration or definition.
    pub kind: DeclarationKind,
    /// The declared type.
    pub type_ref: TypeRef,
}

/// `DeclarationIR`: the declarations in order, and the types that are
/// forward-declared.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct DeclarationIR {
    /// The declarations, in order.
    pub declarations: Vec<Declaration>,
    /// The types that get a forward declaration.
    pub forwarded_types: IndexSet<TypeRef>,
}

/// A predicate on types, e.g. a renderer hook.
pub type TypePredicate<'p> = &'p dyn Fn(TypeRef) -> Result<bool>;

/// `findBreaker(t, path, canBreak)`, with `path` given as the stack of
/// types being visited (innermost last; TypeScript keeps the reverse).
fn find_breaker(
    t: TypeRef,
    stack: &[TypeRef],
    can_break: TypePredicate<'_>,
) -> Result<Option<TypeRef>> {
    // `path.indexOf(t)` is the innermost occurrence.
    let Some(index) = stack.iter().rposition(|&x| x == t) else {
        return Ok(None);
    };
    // `path.slice(0, index + 1).reverse()`: from that occurrence inwards.
    for &candidate in &stack[index..] {
        if can_break(candidate)? {
            return Ok(Some(candidate));
        }
    }
    panic("Found a cycle that cannot be broken")
}

/// `cycleBreakerTypesForGraph(graph, isImplicitCycleBreaker,
/// canBreakCycles)`: the types at which the renderer must add indirection
/// (e.g. `Box` in Rust) so that recursive types have a finite size.
///
/// Starting from the top-levels (the last one first), each type is visited
/// depth-first. Implicit cycle breakers (e.g. arrays) end the path: their
/// children start new searches later. Reaching a type that is already on
/// the path closes a cycle, and the first type from that earlier
/// occurrence inwards that can break cycles becomes a cycle breaker.
pub fn cycle_breaker_types_for_graph(
    graph: &TypeGraph,
    is_implicit_cycle_breaker: TypePredicate<'_>,
    can_break_cycles: TypePredicate<'_>,
) -> Result<IndexSet<TypeRef>> {
    let mut visited: HashSet<TypeRef> = HashSet::new();
    let mut cycle_breaker_types: IndexSet<TypeRef> = IndexSet::new();
    let mut queue: Vec<TypeRef> = graph.top_levels().values().copied().collect();

    struct Frame {
        t: TypeRef,
        children: Vec<TypeRef>,
        next: usize,
    }

    while let Some(root) = queue.pop() {
        let mut frames: Vec<Frame> = Vec::new();
        let mut path: Vec<TypeRef> = Vec::new();
        // How often each type is on `path`, to skip the search when it isn't.
        let mut on_path: std::collections::HashMap<TypeRef, usize> =
            std::collections::HashMap::new();
        let mut to_visit = Some(root);
        loop {
            if let Some(t) = to_visit.take() {
                // `visit(t, path)`
                if !visited.contains(&t) {
                    if is_implicit_cycle_breaker(t)? {
                        queue.extend(graph.children(t)?);
                        visited.insert(t);
                    } else if let Some(breaker) = if on_path.contains_key(&t) {
                        find_breaker(t, &path, can_break_cycles)?
                    } else {
                        None
                    } {
                        cycle_breaker_types.insert(breaker);
                    } else {
                        frames.push(Frame {
                            t,
                            children: graph.children(t)?.into_iter().collect(),
                            next: 0,
                        });
                        path.push(t);
                        *on_path.entry(t).or_insert(0) += 1;
                    }
                }
            }
            let Some(frame) = frames.last_mut() else {
                break;
            };
            if let Some(&child) = frame.children.get(frame.next) {
                frame.next += 1;
                to_visit = Some(child);
            } else {
                visited.insert(frame.t);
                frames.pop();
                if let Some(t) = path.pop() {
                    if let Some(count) = on_path.get_mut(&t) {
                        *count -= 1;
                        if *count == 0 {
                            on_path.remove(&t);
                        }
                    }
                }
            }
        }
        assert(path.is_empty(), "Assertion failed")?;
    }

    Ok(cycle_breaker_types)
}

struct DeclarationBuilder<'p> {
    can_be_forward_declared: Option<TypePredicate<'p>>,
    children_of_type: &'p dyn Fn(TypeRef) -> Result<IndexSet<TypeRef>>,
    needs_declaration: TypePredicate<'p>,
    top_down: bool,
    declarations: Vec<Declaration>,
    forwarded_types: IndexSet<TypeRef>,
    visited_components: HashSet<Vec<TypeRef>>,
}

impl DeclarationBuilder<'_> {
    fn process_graph(&mut self, graph: &Graph<TypeRef>) -> Result<()> {
        let components_graph = graph.strongly_connected_components()?;
        let roots = components_graph.find_roots();
        let top_down = self.top_down;
        for component in &roots {
            components_graph.dfs_traversal(component, top_down, |c| self.visit_component(c))?;
        }
        Ok(())
    }

    fn visit_component(&mut self, component: &Vec<TypeRef>) -> Result<()> {
        if !self.visited_components.insert(component.clone()) {
            return Ok(());
        }

        let mut declaration_needed: Vec<TypeRef> = Vec::new();
        for &t in component {
            if (self.needs_declaration)(t)? {
                declaration_needed.push(t);
            }
        }

        let define = |type_ref| Declaration {
            kind: DeclarationKind::Define,
            type_ref,
        };

        // 1. Only one node in the cycle needs a declaration, in which case
        // it's the breaker, and no forward declaration is necessary.
        if declaration_needed.len() == 1 {
            self.declarations.push(define(declaration_needed[0]));
            return Ok(());
        }

        // 2. No node in the cycle needs a declaration, but it's also the
        // only node, so we don't actually need a declaration at all.
        if declaration_needed.is_empty() && component.len() == 1 {
            return Ok(());
        }

        // 3. No node in the cycle needs a declaration, but there's more
        // than one node total. We have to pick a node to make a
        // declaration, so we can pick any one. This is not a forward
        // declaration, either.
        if declaration_needed.is_empty() {
            match component.first() {
                Some(&first) => self.declarations.push(define(first)),
                None => return panic("Defined value expected, but got undefined"),
            }
            return Ok(());
        }

        // 4. More than one node needs a declaration, and we don't need
        // forward declarations. Just declare all of them and be done with
        // it.
        let Some(can_be_forward_declared) = self.can_be_forward_declared else {
            for t in declaration_needed {
                self.declarations.push(define(t));
            }
            return Ok(());
        };

        // 5. More than one node needs a declaration, and we have to make
        // forward declarations. We do the simple thing and first
        // forward-declare all forward-declarable types in the SCC. If there
        // are none, we're stuck. If there are, we take them out of the
        // component and try the whole thing again recursively. Then we
        // declare the types we previously forward-declared.
        let mut forward_declarable: IndexSet<TypeRef> = IndexSet::new();
        for &t in component {
            if can_be_forward_declared(t)? {
                forward_declarable.insert(t);
            }
        }
        if forward_declarable.is_empty() {
            return message_error(
                ErrorKind::IRNoForwardDeclarableTypeInCycle,
                Vec::<(&str, MessageValue)>::new(),
            );
        }

        for &t in &forward_declarable {
            self.declarations.push(Declaration {
                kind: DeclarationKind::Forward,
                type_ref: t,
            });
        }
        self.forwarded_types
            .extend(forward_declarable.iter().copied());
        let component_set: IndexSet<TypeRef> = component.iter().copied().collect();
        let rest = set_subtract(&component_set, &forward_declarable);
        let children_of_type = self.children_of_type;
        let rest_graph = Graph::new(rest.iter().copied(), true, |&t| {
            Ok(set_intersect(&children_of_type(t)?, &rest))
        })?;
        self.process_graph(&rest_graph)?;
        for &t in &forward_declarable {
            self.declarations.push(define(t));
        }
        Ok(())
    }
}

/// `declarationsForGraph(typeGraph, canBeForwardDeclared, childrenOfType,
/// needsDeclaration)`: the order in which to declare the types that need a
/// declaration.
///
/// The strongly connected components of the graph (edges from
/// `children_of_type`) are visited depth-first from the roots, in
/// pre-order (dependents first) without forward declarations and in
/// post-order (dependencies first) with them. A component with exactly one
/// type that needs a declaration defines it; several such types are all
/// defined, or, with forward declarations, the forward-declarable ones are
/// declared first and the rest of the component is processed recursively.
pub fn declarations_for_graph(
    type_graph: &TypeGraph,
    can_be_forward_declared: Option<TypePredicate<'_>>,
    children_of_type: &dyn Fn(TypeRef) -> Result<IndexSet<TypeRef>>,
    needs_declaration: TypePredicate<'_>,
) -> Result<DeclarationIR> {
    let mut builder = DeclarationBuilder {
        can_be_forward_declared,
        children_of_type,
        needs_declaration,
        top_down: can_be_forward_declared.is_none(),
        declarations: Vec::new(),
        forwarded_types: IndexSet::new(),
        visited_components: HashSet::new(),
    };
    let full_graph = type_graph.make_graph(false, children_of_type)?;
    builder.process_graph(&full_graph)?;
    Ok(DeclarationIR {
        declarations: builder.declarations,
        forwarded_types: builder.forwarded_types,
    })
}
