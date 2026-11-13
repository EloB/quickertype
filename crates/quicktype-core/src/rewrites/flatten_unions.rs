//! Port of `packages/quicktype-core/src/rewrites/FlattenUnions.ts`.
//!
//! Replaces every union that is not canonical (nested unions, several
//! members of one kind, `any`/`none` members, ...) by the unification of its
//! members: one member per kind, with classes, arrays and maps merged.
//! Unions that contain intersections are left for
//! [`resolve_intersections`](super::resolve_intersections) to handle first.

use std::cell::{Cell, RefCell};
use std::rc::Rc;

use indexmap::IndexSet;

use crate::attributes::type_attributes::TypeAttributes;
use crate::graph_rewriting::make_replacer;
use crate::messages::{ErrorKind, MessageValue, Result, message_assert};
use crate::support::fast_hash::{HashMap, HashSet};
use crate::support::support::assert;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{make_groups_to_flatten, union_is_canonical};
use crate::unify_classes::{UnifyUnionBuilder, unify_types};

/// The state the replacer and the unification callback share.
struct FlattenState {
    conflate_numbers: bool,
    make_object_types: bool,
    needs_repeat: Cell<bool>,
    /// The flattened unions in progress, by the key of their non-union
    /// leaves, so recursive occurrences reuse the forwarding ref.
    union_key_to_ref: RefCell<HashMap<String, TypeRef>>,
}

/// `unionKeyForTypes(types)`: the sorted, comma-separated indexes of the
/// non-union types reachable from `types` through unions.
fn union_key_for_types(
    graph: &TypeGraph,
    types: impl IntoIterator<Item = TypeRef>,
) -> Result<String> {
    let mut atoms: Vec<usize> = Vec::new();
    let mut seen: HashSet<usize> = HashSet::default();
    let mut stack: Vec<TypeRef> = types.into_iter().collect();
    // The set of atoms does not depend on the visiting order, so an
    // explicit stack replaces the recursion.
    while let Some(t) = stack.pop() {
        let index = t.index();
        if !seen.insert(index) {
            continue;
        }
        let ty = graph.type_at(t)?;
        if ty.is_union() {
            stack.extend(ty.members()?.iter().copied());
        } else {
            atoms.push(index);
        }
    }
    // `seen` already keeps the atoms unique.
    atoms.sort_unstable();
    Ok(atoms
        .iter()
        .map(usize::to_string)
        .collect::<Vec<_>>()
        .join(","))
}

/// `containsIntersection(t, new Set())`: whether an intersection is
/// reachable from `t` through unions.
fn contains_intersection(graph: &TypeGraph, t: TypeRef) -> Result<bool> {
    let mut seen: HashSet<usize> = HashSet::default();
    let mut stack = vec![t];
    while let Some(t) = stack.pop() {
        if !seen.insert(t.index()) {
            continue;
        }
        let ty = graph.type_at(t)?;
        if ty.is_intersection() {
            return Ok(true);
        }
        if ty.is_union() {
            stack.extend(ty.members()?.iter().copied());
        }
    }
    Ok(false)
}

/// `unifyTypeRefs(trefs)`: the callback the union builder unifies property
/// and item types with.
fn unify_type_refs<'g>(
    state: &FlattenState,
    union_builder: &UnifyUnionBuilder<'g>,
    builder: &mut TypeBuilder<'g>,
    trefs: &[TypeRef],
) -> Result<TypeRef> {
    assert(
        !trefs.is_empty(),
        "Must have at least one type to build union",
    )?;

    if let Some(r) = builder.lookup_type_refs(trefs, None, false)? {
        return Ok(r);
    }

    let graph = builder.original_graph()?;
    let types_to_unify: IndexSet<TypeRef> = trefs.iter().copied().collect();
    let mut any_intersection = false;
    for &t in &types_to_unify {
        if contains_intersection(graph, t)? {
            any_intersection = true;
            break;
        }
    }
    if any_intersection {
        let mut reconstituted = Vec::with_capacity(trefs.len());
        for &t in trefs {
            reconstituted.push(builder.reconstitute_type(t, TypeAttributes::new(), None)?);
        }
        if reconstituted.len() == 1 {
            return Ok(reconstituted[0]);
        }
        state.needs_repeat.set(true);
        return builder.get_union_type(
            TypeAttributes::new(),
            reconstituted.into_iter().collect(),
            None,
        );
    }

    let key = union_key_for_types(graph, types_to_unify.iter().copied())?;
    if let Some(&r) = state.union_key_to_ref.borrow().get(&key) {
        return Ok(r);
    }

    builder.with_forwarding_ref(None, |b, nested_forwarding_ref| {
        state
            .union_key_to_ref
            .borrow_mut()
            .insert(key, nested_forwarding_ref);
        unify_types(
            &types_to_unify,
            &TypeAttributes::new(),
            b,
            union_builder,
            state.conflate_numbers,
            Some(nested_forwarding_ref),
        )
    })
}

/// `replace(types, builder, forwardingRef)`.
fn replace<'g>(
    state: &Rc<FlattenState>,
    types: &IndexSet<TypeRef>,
    builder: &mut TypeBuilder<'g>,
    forwarding_ref: TypeRef,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let key = union_key_for_types(graph, types.iter().copied())?;
    state
        .union_key_to_ref
        .borrow_mut()
        .insert(key, forwarding_ref);

    let callback_state = Rc::clone(state);
    let union_builder = UnifyUnionBuilder::new(
        state.make_object_types,
        true,
        Rc::new(move |union_builder, builder, trefs| {
            unify_type_refs(&callback_state, union_builder, builder, trefs)
        }),
    );
    unify_types(
        types,
        &TypeAttributes::new(),
        builder,
        &union_builder,
        state.conflate_numbers,
        Some(forwarding_ref),
    )
}

/// `flattenUnions(graph, stringTypeMapping, conflateNumbers,
/// makeObjectTypes, debugPrintReconstitution)`.
///
/// Returns the new graph (`None` if nothing was flattened: TypeScript
/// returns the same graph) and whether flattening is done, i.e. no more
/// passes are needed: false if a union containing an intersection was
/// skipped or a new non-canonical union had to be made.
pub fn flatten_unions(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    conflate_numbers: bool,
    make_object_types: bool,
    debug_print_reconstitution: bool,
) -> Result<(Option<TypeGraph>, bool)> {
    let state = Rc::new(FlattenState {
        conflate_numbers,
        make_object_types,
        needs_repeat: Cell::new(false),
        union_key_to_ref: RefCell::new(HashMap::default()),
    });

    let mut non_canonical_unions: Vec<TypeRef> = Vec::new();
    for t in graph.all_types_unordered() {
        if graph.kind(t)? == TypeKind::Union && !union_is_canonical(graph, t)? {
            non_canonical_unions.push(t);
        }
    }

    let mut found_intersection = false;
    let groups = make_groups_to_flatten(
        graph,
        non_canonical_unions,
        Some(&mut |members| {
            message_assert(
                !members.is_empty(),
                ErrorKind::IRNoEmptyUnions,
                Vec::<(&str, MessageValue)>::new(),
            )?;
            let mut has_intersection = false;
            for &m in members {
                if graph.kind(m)? == TypeKind::Intersection {
                    has_intersection = true;
                    break;
                }
            }
            if !has_intersection {
                return Ok(true);
            }
            // FIXME (TypeScript): `resolveIntersections` can introduce unions
            // that need flattening, so the two passes have to know about each
            // other.
            found_intersection = true;
            Ok(false)
        }),
    )?;

    let replacer_state = Rc::clone(&state);
    let replacer = make_replacer(move |types, builder, forwarding_ref| {
        replace(&replacer_state, types, builder, forwarding_ref)
    });
    let new_graph = graph.rewrite(
        "flatten unions",
        string_type_mapping,
        false,
        groups,
        debug_print_reconstitution,
        replacer,
        false,
    )?;

    Ok((new_graph, !state.needs_repeat.get() && !found_intersection))
}
