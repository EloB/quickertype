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

use std::collections::VecDeque;
use std::collections::hash_map::Entry;

use std::rc::Rc;

use indexmap::IndexSet;
use quicktype_js_compat::pluralize;

use crate::attributes::type_attributes::{AttributeKind, transformation_for_type};
use crate::attributes::type_names::{
    NamesTypeAttributeKind, TOO_MANY_NAMES_THRESHOLD, TooManyTypeNames, TypeNames,
};
use crate::messages::Result;
use crate::support::collection_utils::sort_by_string_key;
use crate::support::fast_hash::{HashMap, HashSet};
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

/// A set of names, or `None` for "too many" (TS `null`). Shared, because
/// TypeScript passes the same set object to several types.
type NameSet = Option<Rc<IndexSet<String>>>;

/// A set of alternative names, or `None` for "too many" (TS `null`).
type Alternatives = Option<IndexSet<String>>;

fn singular_names(names: &NameSet) -> NameSet {
    names
        .as_ref()
        .map(|names| Rc::new(names.iter().map(|n| pluralize::singular(n)).collect()))
}

fn single_name(name: &str) -> NameSet {
    Some(Rc::new([name.to_owned()].into_iter().collect()))
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

/// `addAlternatives(existing, alternatives)` on a stored value (`None`:
/// TS `undefined`): extends the set in place; it becomes `null` (TS) once
/// it reaches the threshold.
/// `parts.join("_")`, without the formatting machinery (alternative names
/// are built for every name of every type).
fn underscored(parts: &[&str]) -> String {
    let mut s = String::with_capacity(parts.iter().map(|p| p.len() + 1).sum());
    for (i, part) in parts.iter().enumerate() {
        if i > 0 {
            s.push('_');
        }
        s.push_str(part);
    }
    s
}

fn add_alternatives(
    existing: Option<Alternatives>,
    alternatives: Vec<String>,
) -> Option<Alternatives> {
    if alternatives.is_empty() {
        return existing;
    }
    let mut set = existing.flatten().unwrap_or_default();
    set.extend(alternatives);
    if set.len() < TOO_MANY_NAMES_THRESHOLD {
        return Some(Some(set));
    }
    Some(None)
}

struct Gatherer<'g> {
    graph: &'g TypeGraph,
    queue: UniqueQueue,
    /// `namesForType`: absent is `undefined`, `None` is `null`.
    names_for_type: HashMap<TypeRef, NameSet>,
    direct_alternatives_for_type: HashMap<TypeRef, Alternatives>,
    ancestor_alternatives_for_type: HashMap<TypeRef, Alternatives>,
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
                names = Some(Rc::new(original_names.names().clone()));
            }
        }

        let old_names = self.names_for_type.get(&t).cloned();
        if let Some(None) = old_names {
            return Ok(());
        }

        let mut new_names: NameSet = match (&old_names, &names) {
            (None, _) => names.clone(),
            (Some(Some(old)), Some(n)) => {
                let mut union = IndexSet::clone(old);
                union.extend(n.iter().cloned());
                Some(Rc::new(union))
            }
            (Some(_), None) | (Some(None), Some(_)) => None,
        };

        if new_names
            .as_ref()
            .is_some_and(|n| n.len() >= TOO_MANY_NAMES_THRESHOLD)
        {
            new_names = None;
        }

        let unchanged = matches!(
            (&old_names, &new_names),
            (Some(Some(old)), Some(new)) if old.len() == new.len()
        );
        self.names_for_type.insert(t, new_names);

        if let Some(transformation) = transformation_for_type(self.graph, t)? {
            self.add_names(transformation.target_type(), names)?;
        }

        if !unchanged {
            self.queue.push(t);
        }
        Ok(())
    }

    /// `processType(ancestor, t, alternativeSuffix)`.
    ///
    /// The TypeScript recursion is run with an explicit stack, so deeply
    /// nested inputs cannot overflow the native stack: `Enter` is the start
    /// of a call, `Visit` the rest of it, after the call for the
    /// transformation target returned. Children are pushed in reverse, so
    /// they are processed in order, each with its whole subtree.
    fn process_type(
        &mut self,
        ancestor: Option<TypeRef>,
        t: TypeRef,
        alternative_suffix: Option<&'static str>,
    ) -> Result<()> {
        enum Step {
            Enter(Option<TypeRef>, TypeRef, Option<&'static str>),
            Visit(Option<TypeRef>, TypeRef, Option<&'static str>),
        }
        let mut stack = vec![Step::Enter(ancestor, t, alternative_suffix)];
        while let Some(step) = stack.pop() {
            match step {
                Step::Enter(ancestor, t, suffix) => {
                    // `defined(namesForType.get(t))`
                    if !self.names_for_type.contains_key(&t) {
                        return panic("Defined value expected, but got undefined");
                    }
                    if !self.pairs_processed.entry(ancestor).or_default().insert(t) {
                        continue;
                    }
                    stack.push(Step::Visit(ancestor, t, suffix));
                    if let Some(transformation) = transformation_for_type(self.graph, t)? {
                        stack.push(Step::Enter(ancestor, transformation.target_type(), suffix));
                    }
                }
                Step::Visit(ancestor, t, suffix) => {
                    self.add_type_alternatives(ancestor, t, suffix)?;
                    let children = self.children_to_process(ancestor, t)?;
                    for (a, c, s) in children.into_iter().rev() {
                        stack.push(Step::Enter(a, c, s));
                    }
                }
            }
        }
        Ok(())
    }

    /// The part of `processType` that adds `t`'s ancestor and direct
    /// alternatives.
    fn add_type_alternatives(
        &mut self,
        ancestor: Option<TypeRef>,
        t: TypeRef,
        alternative_suffix: Option<&str>,
    ) -> Result<()> {
        let kind = self.graph.kind(t)?;
        // Taken out of the maps and put back below, so that they can be
        // extended in place.
        let mut ancestor_alternatives = self.ancestor_alternatives_for_type.remove(&t);
        let mut direct_alternatives = self.direct_alternatives_for_type.remove(&t);
        match self.names_for_type.get(&t).and_then(Option::as_ref) {
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
                                for name in names.iter() {
                                    alternatives.extend(
                                        ancestor_names.iter().map(|an| underscored(&[an, name])),
                                    );
                                    alternatives.extend(
                                        ancestor_names
                                            .iter()
                                            .map(|an| underscored(&[an, name, kind.as_str()])),
                                    );
                                }
                                ancestor_alternatives =
                                    add_alternatives(ancestor_alternatives, alternatives);
                            }
                            None => {}
                        }
                    }
                }

                if let Some(suffix) = alternative_suffix {
                    if direct_alternatives != Some(None) {
                        let alternatives = names
                            .iter()
                            .map(|name| underscored(&[name, suffix]))
                            .collect();
                        direct_alternatives = add_alternatives(direct_alternatives, alternatives);
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
        Ok(())
    }

    /// The recursive calls of `processType` for `t`'s children, in order:
    /// `(ancestor, child, alternativeSuffix)`.
    #[allow(clippy::type_complexity)]
    fn children_to_process(
        &self,
        ancestor: Option<TypeRef>,
        t: TypeRef,
    ) -> Result<Vec<(Option<TypeRef>, TypeRef, Option<&'static str>)>> {
        let mut children = Vec::new();
        let ty = self.graph.type_at(t)?;
        if ty.is_object_type() {
            let properties = ty.sorted_property_refs()?;
            for (_, property) in &properties {
                children.push((Some(t), property.type_ref, None));
            }
            if let Some(values) = ty.additional_properties()? {
                let ancestor_for_values = if properties.is_empty() {
                    ancestor
                } else {
                    Some(t)
                };
                children.push((ancestor_for_values, values, Some("value")));
            }
        } else {
            match ty.kind() {
                TypeKind::Array => children.push((ancestor, ty.items()?, Some("element"))),
                TypeKind::Union => {
                    let union_has_given_name = NamesTypeAttributeKind
                        .try_get_in_attributes(self.graph.attributes(t)?)
                        .is_some_and(|n| !n.are_inferred());
                    let union_is_ancestor =
                        union_has_given_name || nullable_from_union(self.graph, t)?.is_none();
                    let ancestor_for_members = if union_is_ancestor { Some(t) } else { ancestor };
                    for member in members_sorted_by_kind(self.graph, t)? {
                        children.push((ancestor_for_members, member, None));
                    }
                }
                TypeKind::Intersection => return panic("Unknown type intersection"),
                _ => {}
            }
        }
        Ok(children)
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
        names_for_type: HashMap::default(),
        direct_alternatives_for_type: HashMap::default(),
        ancestor_alternatives_for_type: HashMap::default(),
        pairs_processed: HashMap::default(),
    };

    let top_levels: Vec<(String, TypeRef)> = gatherer
        .graph
        .top_levels()
        .iter()
        .map(|(n, &t)| (n.clone(), t))
        .collect();
    for (name, t) in &top_levels {
        gatherer.add_names(*t, single_name(name))?;
    }

    while let Some(t) = gatherer.queue.unshift() {
        let names = defined(gatherer.names_for_type.get(&t).cloned())?;
        let ty = gatherer.graph.type_at(t)?;
        if ty.is_object_type() {
            for (property_name, property) in ty.sorted_property_refs()? {
                gatherer.add_names(property.type_ref, single_name(property_name))?;
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

    let Gatherer {
        names_for_type,
        mut direct_alternatives_for_type,
        mut ancestor_alternatives_for_type,
        ..
    } = gatherer;

    for &t in &all_types {
        let Some(names) = names_for_type.get(&t) else {
            continue;
        };
        let Some(names) = names else {
            direct_alternatives_for_type.insert(t, None);
            continue;
        };
        let kind = graph.kind(t)?;
        let alternatives = names.iter().map(|name| underscored(&[name, kind.as_str()]));
        match direct_alternatives_for_type.entry(t) {
            Entry::Occupied(mut e) => match e.get_mut() {
                None => continue,
                Some(set) => set.extend(alternatives),
            },
            Entry::Vacant(e) => {
                e.insert(Some(alternatives.collect()));
            }
        }
    }

    for &t in &all_types {
        let Some(names) = names_for_type.get(&t) else {
            continue;
        };

        let type_names = match names {
            None => TypeNames::TooMany(TooManyTypeNames::new(1, None)),
            Some(names) => {
                let ancestor_alternatives = ancestor_alternatives_for_type.remove(&t);
                let direct_alternatives = direct_alternatives_for_type.remove(&t);
                let alternatives =
                    if ancestor_alternatives == Some(None) && direct_alternatives == Some(None) {
                        None
                    } else {
                        let mut alternatives = direct_alternatives.flatten().unwrap_or_default();
                        if let Some(Some(a)) = ancestor_alternatives {
                            alternatives.extend(a);
                        }
                        Some(alternatives)
                    };
                TypeNames::make_with_distance(
                    IndexSet::clone(names),
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

#[cfg(test)]
mod tests {
    use indexmap::IndexMap;

    use super::*;
    use crate::attributes::string_types::StringTypes;
    use crate::attributes::type_attributes::TypeAttributes;
    use crate::attributes::type_names::make_names_type_attributes;
    use crate::ty::ty::ClassProperty;
    use crate::ty::type_builder::TypeBuilder;
    use crate::ty::type_builder_utils::get_no_string_type_mapping;

    fn names_of(graph: &TypeGraph, t: TypeRef) -> Vec<String> {
        NamesTypeAttributeKind
            .try_get_in_attributes(graph.attributes(t).unwrap())
            .unwrap()
            .proposed_names()
            .unwrap()
            .into_iter()
            .collect()
    }

    #[test]
    fn singularizes_with_pluralize_directly() {
        let mut b =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
        let s = b
            .get_string_type(
                TypeAttributes::new(),
                Some(StringTypes::unrestricted()),
                None,
            )
            .unwrap();
        let inner = b
            .get_class_type(
                TypeAttributes::new(),
                [("flavor".to_owned(), ClassProperty::new(s, false))]
                    .into_iter()
                    .collect(),
                None,
            )
            .unwrap();
        let array = b
            .get_array_type(TypeAttributes::new(), inner, None)
            .unwrap();
        let top: IndexMap<String, ClassProperty> =
            [("cookies".to_owned(), ClassProperty::new(array, false))]
                .into_iter()
                .collect();
        let top = b
            .get_class_type(make_names_type_attributes("TopLevel", false), top, None)
            .unwrap();
        b.add_top_level("TopLevel", top).unwrap();
        let mut graph = b.finish().unwrap();
        gather_names(&mut graph, true, false).unwrap();
        assert_eq!(
            names_of(&graph, inner),
            [
                "cooky",
                "cooky_element",
                "cooky_class",
                "TopLevel_cooky",
                "TopLevel_cooky_class"
            ]
        );
        assert_eq!(names_of(&graph, top), ["TopLevel", "TopLevel_class"]);
    }

    #[test]
    fn deep_nesting_does_not_overflow_the_stack() {
        let mut b =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
        let mut t = b
            .get_primitive_type(TypeKind::Integer, TypeAttributes::new(), None)
            .unwrap();
        for _ in 0..20_000 {
            t = b.get_array_type(TypeAttributes::new(), t, None).unwrap();
        }
        b.add_top_level("TopLevel", t).unwrap();
        let mut graph = b.finish().unwrap();
        // Runs on the 2 MiB stack of a test thread.
        gather_names(&mut graph, true, false).unwrap();
        assert_eq!(names_of(&graph, t)[0], "TopLevel");
        let breakers =
            crate::declaration_ir::cycle_breaker_types_for_graph(&graph, &|_| Ok(false), &|_| {
                Ok(true)
            })
            .unwrap();
        assert!(breakers.is_empty());
    }
}
