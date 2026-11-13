//! Port of `packages/quicktype-core/src/GatherNames.ts`.
//!
//! `gatherNames` infers names from given names and property names.
//!
//! 1. Propagate type and property names down to children. Let's say we
//!    start with JSON like this, and we name the top-level `TopLevel`:
//!
//!    ```json
//!    { "foos": [ [ { "bar": 123 } ] ] }
//!    ```
//!
//!    We use a work-list algorithm to first add the name `TopLevel` to the
//!    outermost class type. Then we propagate the property name `foos` to
//!    the outer array, which in turn propagates its singular `foo` to the
//!    inner array type. That tries to singularize `foo`, but it's already
//!    singular, so `foo` is added as a name for the inner class. We also
//!    then add `bar` to the name of the integer type.
//!
//! 2. Add "ancestor" alternatives and some "direct" alternatives. Direct
//!    alternatives are those that don't contain any ancestor names, whereas
//!    ancestor alternatives do. What we do here is add names of the form
//!    `TopLevel_foo` and `TopLevel_foo_class` as ancestor alternatives to
//!    the inner class, and `foo_element` as a direct alternative, the latter
//!    because it's an element in an array.
//!
//! 3. Add more direct alternatives to the type names. The reason we're
//!    doing this separately from step 2 is because step 2 only requires
//!    iterating over the types, whereas this step iterates over
//!    ancestor/descendant relationships. In this case we would add
//!    `TopLevel_class`, and `foo_class` to the outer and inner classes,
//!    respectively. We do similar stuff for all the other types.
//!
//! 4. For each type, set its inferred names to what we gathered in step 1,
//!    and its alternatives to a union of its direct and ancestor
//!    alternatives, gathered in steps 2 and 3.
//!
//! Singular names come from `pluralize.singular` directly (so `cookies`
//! becomes `cooky`, unlike `TypeNames.singularize`).

use std::collections::{HashMap, HashSet, VecDeque};

use indexmap::IndexSet;
use quicktype_js_compat::pluralize;

use crate::attributes::type_attributes::{AttributeKind, transformation_for_type};
use crate::attributes::type_names::{
    NamesTypeAttributeKind, TOO_MANY_NAMES_THRESHOLD, TooManyTypeNames, TypeNames,
};
use crate::messages::Result;
use crate::support::collection_utils::sort_by_string_key;
use crate::support::support::{console_log, defined, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::nullable_from_union;

/// `UniqueQueue`: a FIFO queue that holds each value at most once.
#[derive(Default)]
struct UniqueQueue {
    present: HashSet<TypeRef>,
    queue: VecDeque<TypeRef>,
}

impl UniqueQueue {
    fn push(&mut self, v: TypeRef) {
        if self.present.insert(v) {
            self.queue.push_back(v);
        }
    }

    fn unshift(&mut self) -> Option<TypeRef> {
        let v = self.queue.pop_front()?;
        self.present.remove(&v);
        Some(v)
    }
}

/// A set of names, or `None` for "too many" (TS `null`).
type NameSet = Option<IndexSet<String>>;

fn set_union(a: &IndexSet<String>, b: impl IntoIterator<Item = String>) -> IndexSet<String> {
    let mut result = a.clone();
    result.extend(b);
    result
}

fn singular_names(names: &NameSet) -> NameSet {
    names
        .as_ref()
        .map(|names| names.iter().map(|n| pluralize::singular(n)).collect())
}

/// The kind of `t` as a sort key (TS `member.kind`).
fn members_sorted_by_kind(graph: &TypeGraph, t: TypeRef) -> Result<Vec<TypeRef>> {
    let mut members: Vec<(TypeRef, TypeKind)> = graph
        .type_at(t)?
        .members()?
        .iter()
        .map(|&m| Ok((m, graph.kind(m)?)))
        .collect::<Result<_>>()?;
    sort_by_string_key(&mut members, |(_, k)| k.as_str());
    Ok(members.into_iter().map(|(m, _)| m).collect())
}

struct Gatherer<'g> {
    graph: &'g TypeGraph,
    queue: UniqueQueue,
    /// `namesForType`: absent is `undefined`, `None` is `null`.
    names_for_type: HashMap<TypeRef, NameSet>,
    direct_alternatives_for_type: HashMap<TypeRef, NameSet>,
    ancestor_alternatives_for_type: HashMap<TypeRef, NameSet>,
    pairs_processed: HashMap<Option<TypeRef>, HashSet<TypeRef>>,
}

impl Gatherer<'_> {
    /// `addNames(t, names)`.
    fn add_names(&mut self, t: TypeRef, names: NameSet) -> Result<()> {
        let mut names = names;
        // Always use the type's given names if it has some
        if let Some(original_names) =
            NamesTypeAttributeKind.try_get_in_attributes(self.graph.attributes(t)?)
        {
            if !original_names.are_inferred() {
                names = Some(original_names.names().clone());
            }
        }

        let old_names = self.names_for_type.get(&t).cloned();
        if let Some(None) = old_names {
            return Ok(());
        }

        let mut new_names: NameSet = match (&old_names, &names) {
            (None, _) => names.clone(),
            (Some(_), None) => None,
            (Some(Some(old)), Some(n)) => Some(set_union(old, n.iter().cloned())),
            (Some(None), Some(_)) => None,
        };

        if new_names
            .as_ref()
            .is_some_and(|n| n.len() >= TOO_MANY_NAMES_THRESHOLD)
        {
            new_names = None;
        }

        self.names_for_type.insert(t, new_names.clone());

        if let Some(transformation) = transformation_for_type(self.graph, t)? {
            self.add_names(transformation.target_type(), names)?;
        }

        if let (Some(Some(old)), Some(new)) = (&old_names, &new_names) {
            if old.len() == new.len() {
                return Ok(());
            }
        }

        self.queue.push(t);
        Ok(())
    }

    /// `addAlternatives(existing, alternatives)`: `None` (TS `null`) once
    /// there are too many.
    fn add_alternatives(existing: Option<NameSet>, alternatives: Vec<String>) -> Option<NameSet> {
        if alternatives.is_empty() {
            return existing;
        }
        let existing = match existing {
            Some(Some(set)) => set,
            _ => IndexSet::new(),
        };
        let existing = set_union(&existing, alternatives);
        if existing.len() < TOO_MANY_NAMES_THRESHOLD {
            return Some(Some(existing));
        }
        Some(None)
    }

    /// `processType(ancestor, t, alternativeSuffix)`.
    fn process_type(
        &mut self,
        ancestor: Option<TypeRef>,
        t: TypeRef,
        alternative_suffix: Option<&str>,
    ) -> Result<()> {
        let names = defined(self.names_for_type.get(&t).cloned())?;

        if !self.pairs_processed.entry(ancestor).or_default().insert(t) {
            return Ok(());
        }

        if let Some(transformation) = transformation_for_type(self.graph, t)? {
            self.process_type(ancestor, transformation.target_type(), alternative_suffix)?;
        }

        let kind = self.graph.kind(t)?;
        let mut ancestor_alternatives = self.ancestor_alternatives_for_type.get(&t).cloned();
        let mut direct_alternatives = self.direct_alternatives_for_type.get(&t).cloned();
        match &names {
            None => {
                ancestor_alternatives = Some(None);
                direct_alternatives = Some(None);
            }
            Some(names) => {
                if let Some(ancestor) = ancestor {
                    if ancestor_alternatives != Some(None) {
                        match self.names_for_type.get(&ancestor) {
                            Some(None) => ancestor_alternatives = Some(None),
                            Some(Some(ancestor_names)) => {
                                let mut alternatives = Vec::new();
                                for name in names {
                                    alternatives.extend(
                                        ancestor_names.iter().map(|an| format!("{an}_{name}")),
                                    );
                                    alternatives.extend(
                                        ancestor_names
                                            .iter()
                                            .map(|an| format!("{an}_{name}_{kind}")),
                                    );
                                }
                                ancestor_alternatives =
                                    Self::add_alternatives(ancestor_alternatives, alternatives);
                            }
                            None => {}
                        }
                    }
                }

                if let Some(suffix) = alternative_suffix {
                    if direct_alternatives != Some(None) {
                        let alternatives = names
                            .iter()
                            .map(|name| format!("{name}_{suffix}"))
                            .collect();
                        direct_alternatives =
                            Self::add_alternatives(direct_alternatives, alternatives);
                    }
                }
            }
        }

        if let Some(a) = ancestor_alternatives {
            self.ancestor_alternatives_for_type.insert(t, a);
        }
        if let Some(d) = direct_alternatives {
            self.direct_alternatives_for_type.insert(t, d);
        }

        let ty = self.graph.type_at(t)?;
        if ty.is_object_type() {
            let properties = ty.sorted_property_refs()?;
            for (_, property) in &properties {
                self.process_type(Some(t), property.type_ref, None)?;
            }
            if let Some(values) = ty.additional_properties()? {
                let ancestor_for_values = if properties.is_empty() {
                    ancestor
                } else {
                    Some(t)
                };
                self.process_type(ancestor_for_values, values, Some("value"))?;
            }
        } else {
            match kind {
                TypeKind::Array => self.process_type(ancestor, ty.items()?, Some("element"))?,
                TypeKind::Union => {
                    let members = members_sorted_by_kind(self.graph, t)?;
                    let union_has_given_name = NamesTypeAttributeKind
                        .try_get_in_attributes(self.graph.attributes(t)?)
                        .is_some_and(|n| !n.are_inferred());
                    let union_is_ancestor =
                        union_has_given_name || nullable_from_union(self.graph, t)?.is_none();
                    let ancestor_for_members = if union_is_ancestor { Some(t) } else { ancestor };
                    for member in members {
                        self.process_type(ancestor_for_members, member, None)?;
                    }
                }
                TypeKind::Intersection => return panic("Unknown type intersection"),
                _ => {}
            }
        }
        Ok(())
    }
}

/// `gatherNames(graph, destructive, debugPrint)`: infers the names of all
/// types and stores them in the graph's `names` attributes. `destructive`
/// first clears inferred names (JSON input, which has no schema).
///
/// With `debug_print` the gathered names are printed; like the TypeScript,
/// this stops the whole function at the first type without names.
pub fn gather_names(graph: &mut TypeGraph, destructive: bool, debug_print: bool) -> Result<()> {
    let all_types: Vec<TypeRef> = graph.all_types_unordered().collect();

    if destructive {
        for &t in &all_types {
            if let Some(names) = NamesTypeAttributeKind.try_get_in_attributes(graph.attributes(t)?)
            {
                let cleared = names.clear_inferred();
                graph.set_attribute_value(NamesTypeAttributeKind, t, cleared)?;
            }
        }
    }

    let mut gatherer = Gatherer {
        graph,
        queue: UniqueQueue::default(),
        names_for_type: HashMap::new(),
        direct_alternatives_for_type: HashMap::new(),
        ancestor_alternatives_for_type: HashMap::new(),
        pairs_processed: HashMap::new(),
    };

    let top_levels: Vec<(String, TypeRef)> = gatherer
        .graph
        .top_levels()
        .iter()
        .map(|(n, &t)| (n.clone(), t))
        .collect();
    for (name, t) in &top_levels {
        gatherer.add_names(*t, Some([name.clone()].into_iter().collect()))?;
    }

    while let Some(t) = gatherer.queue.unshift() {
        let names = defined(gatherer.names_for_type.get(&t).cloned())?;
        let ty = gatherer.graph.type_at(t)?;
        if ty.is_object_type() {
            for (property_name, property) in ty.sorted_property_refs()? {
                gatherer.add_names(
                    property.type_ref,
                    Some([property_name.clone()].into_iter().collect()),
                )?;
            }
            if let Some(values) = ty.additional_properties()? {
                gatherer.add_names(values, singular_names(&names))?;
            }
        } else {
            match ty.kind() {
                TypeKind::Array => gatherer.add_names(ty.items()?, singular_names(&names))?,
                TypeKind::Union => {
                    for member in members_sorted_by_kind(gatherer.graph, t)? {
                        gatherer.add_names(member, names.clone())?;
                    }
                }
                TypeKind::Intersection => return panic("Unknown type intersection"),
                _ => {}
            }
        }
    }

    if debug_print {
        for &t in &all_types {
            let Some(names) = gatherer.names_for_type.get(&t) else {
                return Ok(());
            };
            let text = match names {
                None => "*** too many ***".to_owned(),
                Some(names) => names.iter().cloned().collect::<Vec<_>>().join(" "),
            };
            console_log(&format!("{}: {text}", t.index()));
        }
    }

    for (_, t) in &top_levels {
        gatherer.process_type(None, *t, None)?;
    }

    for &t in &all_types {
        let Some(names) = gatherer.names_for_type.get(&t) else {
            continue;
        };
        let Some(names) = names else {
            gatherer.direct_alternatives_for_type.insert(t, None);
            continue;
        };
        let kind = gatherer.graph.kind(t)?;
        let alternatives = match gatherer.direct_alternatives_for_type.get(&t) {
            Some(None) => continue,
            Some(Some(a)) => a.clone(),
            None => IndexSet::new(),
        };
        let alternatives = set_union(
            &alternatives,
            names.iter().map(|name| format!("{name}_{kind}")),
        );
        gatherer
            .direct_alternatives_for_type
            .insert(t, Some(alternatives));
    }

    let Gatherer {
        names_for_type,
        direct_alternatives_for_type,
        ancestor_alternatives_for_type,
        ..
    } = gatherer;

    for &t in &all_types {
        let Some(names) = names_for_type.get(&t) else {
            continue;
        };

        let type_names = match names {
            None => TypeNames::TooMany(TooManyTypeNames::new(1, None)),
            Some(names) => {
                let ancestor_alternatives = ancestor_alternatives_for_type.get(&t);
                let direct_alternatives = direct_alternatives_for_type.get(&t);
                let alternatives =
                    if ancestor_alternatives == Some(&None) && direct_alternatives == Some(&None) {
                        None
                    } else {
                        let mut alternatives = match direct_alternatives {
                            Some(Some(d)) => d.clone(),
                            _ => IndexSet::new(),
                        };
                        if let Some(Some(a)) = ancestor_alternatives {
                            alternatives.extend(a.iter().cloned());
                        }
                        Some(alternatives)
                    };
                TypeNames::make_with_distance(
                    names.clone(),
                    alternatives,
                    if destructive { 1 } else { 10 },
                )
            }
        };

        let new_names = match NamesTypeAttributeKind.try_get_in_attributes(graph.attributes(t)?) {
            Some(existing) => existing.add(&[&type_names], 0),
            None => type_names,
        };
        graph.set_attribute_value(NamesTypeAttributeKind, t, new_names)?;
    }
    Ok(())
}
