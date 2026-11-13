//! Port of `packages/quicktype-core/src/rewrites/CombineClasses.ts`.
//!
//! Merges similar classes: classes are grouped into cliques of classes that
//! are structurally compatible or share at least three quarters of their
//! properties with compatible types, and each clique of more than one class
//! is replaced by the unification of its members.

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::CombinationKind;
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::support::{assert, panic};
use crate::ty::ty::{ClassProperty, set_operation_cases_equal, structurally_compatible};
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{combine_type_attributes_of_types, non_null_type_cases};
use crate::unify_classes::{unify_types, union_builder_for_unification};

const REQUIRED_OVERLAP: f64 = 3.0 / 4.0;

/// `Clique`: the classes in it, and the prototypes new classes are compared
/// with.
struct Clique {
    members: Vec<TypeRef>,
    prototypes: Vec<TypeRef>,
}

/// `typeSetsCanBeCombined(s1, s2)`.
fn type_sets_can_be_combined(
    graph: &TypeGraph,
    s1: &IndexSet<TypeRef>,
    s2: &IndexSet<TypeRef>,
) -> Result<bool> {
    set_operation_cases_equal(graph, s1, s2, true, |a, b| {
        structurally_compatible(graph, a, b, true)
    })
}

/// `canBeCombined(c1, c2, onlyWithSameProperties)`.
fn can_be_combined(
    graph: &TypeGraph,
    c1: TypeRef,
    c2: TypeRef,
    only_with_same_properties: bool,
) -> Result<bool> {
    let p1 = graph.type_at(c1)?.properties()?;
    let p2 = graph.type_at(c2)?.properties()?;
    let (size1, size2) = (p1.len() as f64, p2.len() as f64);
    if only_with_same_properties {
        if p1.len() != p2.len() {
            return Ok(false);
        }
    } else if size1 < size2 * REQUIRED_OVERLAP || size2 < size1 * REQUIRED_OVERLAP {
        return Ok(false);
    }

    let (larger, smaller): (
        &IndexMap<String, ClassProperty>,
        &IndexMap<String, ClassProperty>,
    ) = if p1.len() > p2.len() {
        (p1, p2)
    } else {
        (p2, p1)
    };

    let max_faults: f64 = if only_with_same_properties {
        0.0
    } else {
        let min_overlap = (larger.len() as f64 * REQUIRED_OVERLAP).ceil();
        smaller.len() as f64 - min_overlap
    };

    assert(max_faults >= 0.0, "Max faults negative")?;
    let mut common_properties: Vec<&String> = Vec::new();
    let mut faults = 0.0;
    for name in smaller.keys() {
        if larger.contains_key(name) {
            common_properties.push(name);
        } else {
            faults += 1.0;
            if faults > max_faults {
                break;
            }
        }
    }

    if faults > max_faults {
        return Ok(false);
    }
    for name in common_properties {
        let (Some(ts), Some(tl)) = (smaller.get(name), larger.get(name)) else {
            return panic(format!("Both classes should have property {name}"));
        };

        let ts_cases = non_null_type_cases(graph, ts.type_ref)?;
        let tl_cases = non_null_type_cases(graph, tl.type_ref)?;
        if !ts_cases.is_empty()
            && !tl_cases.is_empty()
            && !type_sets_can_be_combined(graph, &ts_cases, &tl_cases)?
        {
            return Ok(false);
        }
    }

    Ok(true)
}

/// `tryAddToClique(c, clique, onlyWithSameProperties)`.
fn try_add_to_clique(
    graph: &TypeGraph,
    c: TypeRef,
    clique: &mut Clique,
    only_with_same_properties: bool,
) -> Result<bool> {
    for &prototype in &clique.prototypes {
        if structurally_compatible(graph, prototype, c, false)? {
            clique.members.push(c);
            return Ok(true);
        }
    }

    for i in 0..clique.prototypes.len() {
        if can_be_combined(graph, clique.prototypes[i], c, only_with_same_properties)? {
            clique.prototypes.push(c);
            clique.members.push(c);
            return Ok(true);
        }
    }

    Ok(false)
}

/// `findSimilarityCliques(graph, onlyWithSameProperties,
/// includeFixedClasses)`: the cliques with more than one class. The clique a
/// class was added to moves to the front, which changes the order later
/// classes try the cliques in.
fn find_similarity_cliques(
    graph: &TypeGraph,
    only_with_same_properties: bool,
    include_fixed_classes: bool,
) -> Result<Vec<Vec<TypeRef>>> {
    let mut class_candidates: Vec<TypeRef> = Vec::new();
    for o in graph.all_named_types_separated()?.objects {
        let t = graph.type_at(o)?;
        if t.is_class() && (include_fixed_classes || !t.is_fixed()) {
            class_candidates.push(o);
        }
    }
    let mut cliques: Vec<Clique> = Vec::new();

    for c in class_candidates {
        let mut clique_index: Option<usize> = None;
        for (i, clique) in cliques.iter_mut().enumerate() {
            if try_add_to_clique(graph, c, clique, only_with_same_properties)? {
                clique_index = Some(i);
                break;
            }
        }

        let clique_index = match clique_index {
            Some(i) => i,
            None => {
                cliques.push(Clique {
                    members: vec![c],
                    prototypes: vec![c],
                });
                cliques.len() - 1
            }
        };

        // Move the clique we just added to to the front.
        cliques.swap(0, clique_index);
    }

    Ok(cliques
        .into_iter()
        .map(|clique| clique.members)
        .filter(|members| members.len() > 1)
        .collect())
}

/// `combineClasses(ctx, graph, alphabetizeProperties, conflateNumbers,
/// onlyWithSameProperties, debugPrintReconstitution)`.
///
/// `string_type_mapping` is the run context's `stringTypeMapping` (the
/// context is otherwise only used for timing). Returns `None` (TypeScript:
/// the same graph) if no classes are combined.
pub fn combine_classes(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    alphabetize_properties: bool,
    conflate_numbers: bool,
    only_with_same_properties: bool,
    debug_print_reconstitution: bool,
) -> Result<Option<TypeGraph>> {
    let cliques = find_similarity_cliques(graph, only_with_same_properties, false)?;

    let replacer = make_replacer(move |clique, builder, forwarding_ref| {
        assert(!clique.is_empty(), "Clique can't be empty")?;
        let original = builder.original_graph()?;
        let attributes = combine_type_attributes_of_types(
            original,
            CombinationKind::Union,
            clique.iter().copied(),
        )?;
        unify_types(
            clique,
            &attributes,
            builder,
            &union_builder_for_unification(false, false, conflate_numbers),
            conflate_numbers,
            Some(forwarding_ref),
        )
    });

    graph.rewrite(
        "combine classes",
        string_type_mapping,
        alphabetize_properties,
        cliques,
        debug_print_reconstitution,
        replacer,
        false,
    )
}
