//! Port of `packages/quicktype-core/src/rewrites/ExpandStrings.ts`.
//!
//! Turns restricted strings (strings with known cases and transformed
//! kinds, as inference and JSON Schema produce them) into what they stand
//! for: an enum if the cases make one, the transformed kinds (dates, UUIDs,
//! ...), a union of those, or a plain string.
//!
//! With enum inference, a case set becomes an enum if it has at least 10
//! values and fewer distinct cases than the square root of that; case sets
//! that overlap by at least three quarters are merged first, and smaller
//! sets with at least 5 values join a merged set they overlap with.

use indexmap::{IndexMap, IndexSet};

use crate::attributes::string_types::StringTypes;
use crate::attributes::type_attributes::{TypeAttributeKind, TypeAttributes};
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::fast_hash::{HashMap, HashSet};
use crate::support::support::{assert, assert_default, defined};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::string_types_for_type;

const MIN_LENGTH_FOR_ENUM: f64 = 10.0;

const MIN_LENGTH_FOR_OVERLAP: f64 = 5.0;
const REQUIRED_OVERLAP: f64 = 3.0 / 4.0;

/// `EnumInference`: which restricted strings become enums.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum EnumInference {
    /// `"none"`: never make enums.
    None,
    /// `"all"`: every set of cases is an enum (JSON Schema input).
    All,
    /// `"infer"`: make enums where the cases look like one.
    Infer,
}

/// `EnumInfo`: the distinct cases of a string type and how many values
/// they had in total.
#[derive(Clone, Debug)]
struct EnumInfo {
    cases: IndexSet<String>,
    num_values: f64,
}

/// `isOwnEnum(info)`.
fn is_own_enum(info: &EnumInfo) -> bool {
    info.num_values >= MIN_LENGTH_FOR_ENUM && (info.cases.len() as f64) < info.num_values.sqrt()
}

/// `enumCasesOverlap(newCases, existingCases, newAreSubordinate)`.
fn enum_cases_overlap(
    new_cases: &IndexSet<String>,
    existing_cases: &IndexSet<String>,
    new_are_subordinate: bool,
) -> bool {
    let smaller = if new_are_subordinate {
        new_cases.len()
    } else {
        new_cases.len().min(existing_cases.len())
    };
    // `setIntersect(newCases, existingCases).size`, without building it.
    let overlap = new_cases
        .iter()
        .filter(|case| existing_cases.contains(*case))
        .count();
    overlap as f64 >= smaller as f64 * REQUIRED_OVERLAP
}

/// `isAlwaysEmptyString(cases)`.
fn is_always_empty_string<'a>(cases: impl ExactSizeIterator<Item = &'a String>) -> bool {
    let mut cases = cases;
    cases.len() == 1 && cases.next().is_some_and(|c| c.is_empty())
}

/// `/^[-+]?[0-9]+(\.[0-9]+)?$/.test(key)`.
fn is_number_string(key: &str) -> bool {
    let rest = key.strip_prefix(['-', '+']).unwrap_or(key);
    let (integer, fraction) = match rest.split_once('.') {
        Some((i, f)) => (i, Some(f)),
        None => (rest, None),
    };
    let digits = |s: &str| !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit());
    digits(integer) && fraction.is_none_or(digits)
}

/// `makeEnumInfo(t)`.
fn make_enum_info(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    inference: EnumInference,
    t: TypeRef,
) -> Result<Option<EnumInfo>> {
    let string_types = string_types_for_type(graph, t)?;
    let (Some(cases), _) = string_types.apply_string_type_mapping(string_type_mapping) else {
        return Ok(None);
    };
    if cases.is_empty() {
        return Ok(None);
    }

    let num_values = cases.values().fold(0.0, |a, &b| a + b as f64);

    if inference != EnumInference::All {
        if is_always_empty_string(cases.keys()) {
            return Ok(None);
        }
        if !cases.keys().any(|key| !is_number_string(key)) {
            return Ok(None);
        }
    }

    Ok(Some(EnumInfo {
        cases: cases.keys().cloned().collect(),
        num_values,
    }))
}

/// The enum case sets found in the graph's restricted strings.
fn find_enum_sets(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    inference: EnumInference,
    all_strings: &[TypeRef],
) -> Result<Vec<IndexSet<String>>> {
    let mut enum_sets: Vec<IndexSet<String>> = Vec::new();
    if inference == EnumInference::None {
        return Ok(enum_sets);
    }

    let mut enum_infos: IndexMap<TypeRef, EnumInfo> = IndexMap::new();
    for &t in all_strings {
        if let Some(info) = make_enum_info(graph, string_type_mapping, inference, t)? {
            enum_infos.insert(t, info);
        }
    }

    fn find_overlap(
        enum_sets: &[IndexSet<String>],
        new_cases: &IndexSet<String>,
        new_are_subordinate: bool,
    ) -> Option<usize> {
        enum_sets
            .iter()
            .position(|s| enum_cases_overlap(new_cases, s, new_are_subordinate))
    }

    // First, make case sets for all the enums that stand on their own. If we
    // find some overlap (searching eagerly), make unions.
    let keys: Vec<TypeRef> = enum_infos.keys().copied().collect();
    // The ones we're done with, removed together below: removing each one
    // as it is done (`shift_remove`) moves all later entries every time.
    let mut done: HashSet<TypeRef> = HashSet::default();
    for t in keys {
        let info = defined(enum_infos.get(&t))?;
        if inference == EnumInference::All {
            enum_sets.push(info.cases.clone());
        } else {
            if !is_own_enum(info) {
                continue;
            }
            match find_overlap(&enum_sets, &info.cases, false) {
                Some(index) => {
                    let set = &mut enum_sets[index];
                    set.extend(info.cases.iter().cloned());
                }
                None => enum_sets.push(info.cases.clone()),
            }
        }
        done.insert(t);
    }
    enum_infos.retain(|t, _| !done.contains(t));

    if inference == EnumInference::All {
        assert_default(enum_infos.is_empty())?;
    }

    // Now see if we can unify the rest with some set we found in the
    // previous step.
    for info in enum_infos.values() {
        if info.num_values < MIN_LENGTH_FOR_OVERLAP {
            continue;
        }
        if let Some(index) = find_overlap(&enum_sets, &info.cases, true) {
            enum_sets[index].extend(info.cases.iter().cloned());
        }
    }

    Ok(enum_sets)
}

/// The enum case sets, and for `EnumInference::All` (where a string type's
/// enum is the first set equal to its cases) the first set of each distinct
/// case set, keyed by its sorted cases.
struct EnumSets {
    sets: Vec<IndexSet<String>>,
    first_equal: HashMap<Vec<String>, usize>,
}

impl EnumSets {
    fn new(sets: Vec<IndexSet<String>>, inference: EnumInference) -> EnumSets {
        let mut first_equal = HashMap::default();
        if inference == EnumInference::All {
            for (i, s) in sets.iter().enumerate() {
                first_equal.entry(sorted_cases(s.iter())).or_insert(i);
            }
        }
        EnumSets { sets, first_equal }
    }

    /// `enumSets.find(s => setEquals(s, set))` for `EnumInference::All`, else
    /// the first set that contains all of `cases`.
    fn find(
        &self,
        cases: &IndexMap<String, u64>,
        inference: EnumInference,
    ) -> Option<&IndexSet<String>> {
        if inference == EnumInference::All {
            let i = *self.first_equal.get(&sorted_cases(cases.keys()))?;
            return self.sets.get(i);
        }
        self.sets
            .iter()
            .find(|s| cases.keys().all(|k| s.contains(k)))
    }
}

fn sorted_cases<'a>(cases: impl Iterator<Item = &'a String>) -> Vec<String> {
    let mut v: Vec<String> = cases.cloned().collect();
    v.sort_unstable();
    v
}

/// `replaceString(group, builder, forwardingRef)`.
fn replace_string(
    t: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    string_type_mapping: &StringTypeMapping,
    inference: EnumInference,
    enum_sets: &EnumSets,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let string_types = string_types_for_type(graph, t)?;
    // `mapFilter(attributes, a => a !== stringTypes)`: everything but the
    // string types.
    let attributes = graph
        .attributes(t)?
        .filter(|a| a.kind() != TypeAttributeKind::StringTypes);
    let (cases, transformations) = string_types.apply_string_type_mapping(string_type_mapping);
    let Some(cases) = cases else {
        return builder.get_string_type(
            attributes,
            Some(StringTypes::unrestricted()),
            Some(forwarding_ref),
        );
    };

    let mut types: Vec<TypeRef> = Vec::new();
    if !cases.is_empty() {
        let full_cases = enum_sets.find(cases, inference);
        match full_cases {
            Some(full_cases)
                if inference != EnumInference::None && !is_always_empty_string(cases.keys()) =>
            {
                types.push(builder.get_enum_type(
                    TypeAttributes::new(),
                    full_cases.clone(),
                    None,
                )?);
            }
            _ => {
                return builder.get_string_type(
                    attributes,
                    Some(StringTypes::unrestricted()),
                    Some(forwarding_ref),
                );
            }
        }
    }

    // FIXME (TypeScript): probably wrong, or at least overly conservative;
    // this is for identity attributes (like URI attributes) that would keep
    // two string types apart.
    if types.is_empty() && transformations.len() == 1 {
        let kind = *defined(transformations.first())?;
        return builder.get_primitive_type(kind, attributes, Some(forwarding_ref));
    }

    for &k in &transformations {
        types.push(builder.get_primitive_type(k, TypeAttributes::new(), None)?);
    }
    assert(!types.is_empty(), "We got an empty string type")?;
    builder.get_union_type(
        attributes,
        types.into_iter().collect(),
        Some(forwarding_ref),
    )
}

/// `expandStrings(ctx, graph, inference)`.
///
/// `string_type_mapping` and `debug_print_reconstitution` are the run
/// context's `stringTypeMapping` and `debugPrintReconstitution`. Returns
/// `None` (TypeScript: the same graph) if there are no restricted strings.
pub fn expand_strings(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    debug_print_reconstitution: bool,
    inference: EnumInference,
) -> Result<Option<TypeGraph>> {
    let mut all_strings: Vec<TypeRef> = Vec::new();
    for t in graph.all_types_unordered() {
        if graph.kind(t)? == TypeKind::String && string_types_for_type(graph, t)?.is_restricted() {
            all_strings.push(t);
        }
    }

    let enum_sets = EnumSets::new(
        find_enum_sets(graph, string_type_mapping, inference, &all_strings)?,
        inference,
    );

    let mapping = string_type_mapping.clone();
    let replacer = make_replacer(move |group, builder, forwarding_ref| {
        assert_default(group.len() == 1)?;
        let t = *defined(group.first())?;
        replace_string(t, builder, forwarding_ref, &mapping, inference, &enum_sets)
    });
    graph.rewrite(
        "expand strings",
        string_type_mapping,
        false,
        all_strings.into_iter().map(|t| vec![t]).collect(),
        debug_print_reconstitution,
        replacer,
        false,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn number_strings() {
        for s in ["0", "-1", "+12", "3.25", "007"] {
            assert!(is_number_string(s), "{s}");
        }
        for s in ["", "-", "1.", ".5", "1e5", "1.2.3", "٣", "+-1", "1 "] {
            assert!(!is_number_string(s), "{s}");
        }
    }

    #[test]
    fn finds_the_first_equal_or_containing_set() {
        let set = |cases: &[&str]| -> IndexSet<String> {
            cases.iter().map(|s| (*s).to_owned()).collect()
        };
        let cases = |cases: &[&str]| -> IndexMap<String, u64> {
            cases.iter().map(|s| ((*s).to_owned(), 1)).collect()
        };
        let sets = vec![
            set(&["a", "b"]),
            set(&["b", "a", "c"]),
            set(&["c", "b", "a"]),
            set(&["a", "b", "c", "d"]),
        ];
        let all = EnumSets::new(sets.clone(), EnumInference::All);
        let found = all.find(&cases(&["c", "a", "b"]), EnumInference::All);
        assert_eq!(
            found.map(|s| s.iter().cloned().collect::<Vec<_>>()),
            Some(vec!["b".to_owned(), "a".to_owned(), "c".to_owned()])
        );
        assert!(all.find(&cases(&["a"]), EnumInference::All).is_none());
        let infer = EnumSets::new(sets, EnumInference::Infer);
        let len = |c: &[&str]| {
            infer
                .find(&cases(c), EnumInference::Infer)
                .map(IndexSet::len)
        };
        assert_eq!(len(&["a"]), Some(2));
        assert_eq!(len(&["c", "a"]), Some(3));
        assert_eq!(len(&["d"]), Some(4));
        assert_eq!(len(&["e"]), None);
    }

    #[test]
    fn own_enums_and_overlap() {
        let set = |cases: &[&str]| -> IndexSet<String> {
            cases.iter().map(|s| (*s).to_owned()).collect()
        };
        // 3 cases need more than 9 values.
        assert!(!is_own_enum(&EnumInfo {
            cases: set(&["a", "b", "c"]),
            num_values: 9.0
        }));
        assert!(is_own_enum(&EnumInfo {
            cases: set(&["a", "b", "c"]),
            num_values: 10.0
        }));
        assert!(!is_own_enum(&EnumInfo {
            cases: set(&["a", "b", "c", "d"]),
            num_values: 16.0
        }));
        assert!(enum_cases_overlap(
            &set(&["a", "b", "c", "x"]),
            &set(&["a", "b", "c", "d"]),
            false
        ));
        assert!(!enum_cases_overlap(
            &set(&["a", "b", "x", "y"]),
            &set(&["a", "b"]),
            true
        ));
        assert!(enum_cases_overlap(
            &set(&["a", "b", "x", "y"]),
            &set(&["a", "b"]),
            false
        ));
    }
}
