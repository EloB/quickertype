//! Port of `packages/quicktype-core/src/rewrites/InferMaps.ts`.
//!
//! Turns classes that look like maps into maps: classes whose property names
//! are all numbers, or whose (fewer than 20) property names look random
//! according to the Markov chain of English-like names, provided all
//! property types are compatible.

use indexmap::{IndexMap, IndexSet};
use quicktype_js_compat::number;

use crate::graph_rewriting::make_replacer;
use crate::markov_chain::{self, evaluate};
use crate::messages::Result;
use crate::support::support::{defined, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::{ClassProperty, set_operation_cases_equal, structurally_compatible};
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::remove_null_from_type;
use crate::unify_classes::{unify_types, union_builder_for_unification};

const MAP_SIZE_THRESHOLD: usize = 20;
const STRING_MAP_SIZE_THRESHOLD: usize = 50;

/// `nameProbability(name)`: how English-like the name is.
fn name_probability(name: &str) -> f64 {
    evaluate(markov_chain::shared(), name)
}

/// `/^[0-9]+$/.test(n)`.
fn is_all_digits(name: &str) -> bool {
    !name.is_empty() && name.bytes().all(|b| b.is_ascii_digit())
}

/// The probability limit for `n` property names: around 0.0025 for one
/// property, up to around 1 for 20.
fn probability_limit(num_properties: usize) -> f64 {
    let exponent = 5.0;
    let scale = number::pow(22.0, exponent);
    number::pow(num_properties as f64 + 2.0, exponent) / scale
        + (0.0025 - number::pow(3.0, exponent) / scale)
}

/// `shouldBeMap(properties)`: the types of the map's values if the class
/// should be a map.
fn should_be_map(
    graph: &TypeGraph,
    properties: &IndexMap<String, ClassProperty>,
) -> Result<Option<IndexSet<TypeRef>>> {
    // Only classes with a certain number of properties are inferred as maps.
    let num_properties = properties.len();
    if num_properties < 2 {
        return Ok(None);
    }

    // If all property names are digit-only, we always make a map.
    if properties.keys().all(|n| is_all_digits(n)) {
        return Ok(Some(properties.values().map(|cp| cp.type_ref).collect()));
    }

    // If all properties are strings or null then an object must have at
    // least `STRING_MAP_SIZE_THRESHOLD` properties to qualify as a map.
    if num_properties < STRING_MAP_SIZE_THRESHOLD {
        let mut all_stringish = true;
        for cp in properties.values() {
            let kind = graph.kind(cp.type_ref)?;
            if !(kind.is_primitive_string_type_kind() || kind == TypeKind::Null) {
                all_stringish = false;
                break;
            }
        }
        if all_stringish {
            return Ok(None);
        }
    }

    if num_properties < MAP_SIZE_THRESHOLD {
        let product = properties
            .keys()
            .map(|n| name_probability(n))
            .fold(1.0, |a, b| a * b);
        let probability = number::pow(product, 1.0 / num_properties as f64);
        if probability > probability_limit(num_properties) {
            return Ok(None);
        }
    }

    // All property types must be the same, modulo nullability.
    let mut first_non_null_cases: Option<IndexSet<TypeRef>> = None;
    let mut all_cases: IndexSet<TypeRef> = IndexSet::new();
    for p in properties.values() {
        let nn = remove_null_from_type(graph, p.type_ref)?.1;
        if !nn.is_empty() {
            match &first_non_null_cases {
                Some(first) => {
                    if !set_operation_cases_equal(graph, &nn, first, true, |a, b| {
                        structurally_compatible(graph, a, b, true)
                    })? {
                        return Ok(None);
                    }
                }
                None => first_non_null_cases = Some(nn),
            }
        }
        all_cases.insert(p.type_ref);
    }

    Ok(Some(all_cases))
}

/// `inferMaps(graph, stringTypeMapping, conflateNumbers,
/// debugPrintReconstitution)`.
///
/// Returns `None` (TypeScript: the same graph) if no class should be a map.
/// `Run` repeats this until nothing changes.
pub fn infer_maps(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    conflate_numbers: bool,
    debug_print_reconstitution: bool,
) -> Result<Option<TypeGraph>> {
    // The classes to replace, with the types of their map values (what
    // `shouldBeMap` returns; TypeScript computes it again in the replacer).
    let mut map_values: IndexMap<TypeRef, IndexSet<TypeRef>> = IndexMap::new();
    for o in graph.all_named_types_separated()?.objects {
        let t = graph.type_at(o)?;
        if !t.is_class() || t.is_fixed() {
            continue;
        }
        if let Some(values) = should_be_map(graph, t.properties()?)? {
            map_values.insert(o, values);
        }
    }
    let classes_to_replace: Vec<Vec<TypeRef>> = map_values.keys().map(|&c| vec![c]).collect();

    let replacer = make_replacer(move |set_of_one_class, builder, forwarding_ref| {
        let c = *defined(set_of_one_class.first())?;
        let graph = builder.original_graph()?;

        let Some(should_be) = map_values.get(&c) else {
            return panic(format!(
                "We shouldn't be replacing class {} with a map",
                graph.combined_name(c)?
            ));
        };

        // The class's attributes go to the values as well as to the map.
        let attributes = graph.attributes(c)?;
        let values = unify_types(
            should_be,
            attributes,
            builder,
            &union_builder_for_unification(false, false, conflate_numbers),
            conflate_numbers,
            None,
        )?;
        builder.get_map_type(attributes.clone(), values, Some(forwarding_ref))
    });
    graph.rewrite(
        "infer maps",
        string_type_mapping,
        false,
        classes_to_replace,
        debug_print_reconstitution,
        replacer,
        false,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn digit_names_and_limits() {
        assert!(is_all_digits("0123"));
        assert!(!is_all_digits(""));
        assert!(!is_all_digits("12a"));
        assert!(!is_all_digits("１２"));
        // Values computed by Node with the TypeScript formula.
        assert_eq!(probability_limit(1), 0.0025);
        assert_eq!(probability_limit(2), 0.0026515436104091253);
        assert_eq!(probability_limit(5), 0.005714043998484952);
        assert_eq!(probability_limit(19), 0.7949232851705361);
        assert_eq!(probability_limit(20), 1.0024528487870301);
    }
}
