//! Port of `packages/quicktype-core/src/Type/TypeUtils.ts`.
//!
//! Helpers over types in a frozen graph. The `matchType*` dispatchers are a
//! plain `match` on [`TypeKind`]
//! in Rust; their error behaviour for unexpected kinds is left to the
//! callers.

use indexmap::IndexSet;

use crate::attributes::string_types::{StringTypes, StringTypesTypeAttributeKind};
use crate::attributes::type_attributes::{
    AttributeKind, CombinationKind, TypeAttributes, combine_type_attributes,
    combine_type_attributes2,
};
use crate::messages::Result;
use crate::support::collection_utils::{EqualityMap, sort_by_string_key};
use crate::support::support::{assert, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::Type;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `assertIsObject(t)`.
pub fn assert_is_object(graph: &TypeGraph, t: TypeRef) -> Result<&Type> {
    let ty = graph.type_at(t);
    if ty.is_object_type() {
        Ok(ty)
    } else {
        panic("Supposed object type is not an object type")
    }
}

/// `assertIsClass(t)`.
pub fn assert_is_class(graph: &TypeGraph, t: TypeRef) -> Result<&Type> {
    let ty = graph.type_at(t);
    if ty.is_class() {
        Ok(ty)
    } else {
        panic("Supposed class type is not a class type")
    }
}

/// `setOperationMembersRecursively(setOperations, combinationKind)`: the
/// non-set-operation members of the set operations, following nested set
/// operations of the same kind, in first-seen order. For intersections,
/// `any` members are dropped. With a combination kind, the attributes of
/// the visited set operations (and dropped `any`s) are combined.
pub fn set_operation_members_recursively(
    graph: &TypeGraph,
    set_operations: &[TypeRef],
    combination_kind: Option<CombinationKind>,
) -> Result<(IndexSet<TypeRef>, TypeAttributes)> {
    let Some(&first) = set_operations.first() else {
        return panic("Defined value expected, but got undefined");
    };
    let kind = graph.kind(first);
    let include_any = kind != TypeKind::Intersection;
    let mut processed: IndexSet<TypeRef> = IndexSet::new();
    let mut members: IndexSet<TypeRef> = IndexSet::new();
    let mut attributes = TypeAttributes::new();

    // An explicit stack instead of recursion, visiting in the same order.
    let mut stack: Vec<TypeRef> = set_operations.iter().rev().copied().collect();
    while let Some(t) = stack.pop() {
        let t_kind = graph.kind(t);
        if t_kind == kind {
            if !processed.insert(t) {
                continue;
            }
            if let Some(ck) = combination_kind {
                attributes = combine_type_attributes2(ck, &attributes, graph.attributes(t))?;
            }
            for &m in graph.type_at(t).members()?.iter().rev() {
                stack.push(m);
            }
        } else if include_any || t_kind != TypeKind::Any {
            members.insert(t);
        } else if let Some(ck) = combination_kind {
            attributes = combine_type_attributes2(ck, &attributes, graph.attributes(t))?;
        }
    }

    Ok((members, attributes))
}

/// The `include` predicate of [`make_groups_to_flatten`].
pub type MemberSetFilter<'a> = &'a mut dyn FnMut(&IndexSet<TypeRef>) -> bool;

/// `makeGroupsToFlatten(setOperations, include)`: groups the set operations
/// by their recursive member sets (order-insensitively). A group whose
/// member set has a single member includes that member first. Groups are
/// returned in first-seen order.
pub fn make_groups_to_flatten(
    graph: &TypeGraph,
    set_operations: impl IntoIterator<Item = TypeRef>,
    mut include: Option<MemberSetFilter<'_>>,
) -> Result<Vec<Vec<TypeRef>>> {
    let mut type_groups: EqualityMap<IndexSet<TypeRef>, IndexSet<TypeRef>> = EqualityMap::new();
    for u in set_operations {
        let (members, _) = set_operation_members_recursively(graph, &[u], None)?;

        if let Some(include) = include.as_mut()
            && !include(&members)
        {
            continue;
        }

        let mut set = match type_groups.get(&members) {
            Some(set) => set.clone(),
            None => {
                let mut set = IndexSet::new();
                if members.len() == 1 {
                    set.insert(members[0]);
                }
                set
            }
        };
        set.insert(u);
        type_groups.set(members, set);
    }

    Ok(type_groups
        .values()
        .map(|ts| ts.iter().copied().collect())
        .collect())
}

/// `combineTypeAttributesOfTypes(combinationKind, types)`.
pub fn combine_type_attributes_of_types(
    graph: &TypeGraph,
    combination_kind: CombinationKind,
    types: impl IntoIterator<Item = TypeRef>,
) -> Result<TypeAttributes> {
    let attributes: Vec<&TypeAttributes> = types.into_iter().map(|t| graph.attributes(t)).collect();
    combine_type_attributes(combination_kind, &attributes)
}

/// `isAnyOrNull(t)`.
pub fn is_any_or_null(graph: &TypeGraph, t: TypeRef) -> bool {
    matches!(graph.kind(t), TypeKind::Any | TypeKind::Null)
}

/// How [`remove_null_from_union`] sorts the non-null members.
pub enum NullRemovalSort<'a> {
    /// `false`: keep member order.
    None,
    /// `true`: stable sort by kind name.
    ByKind,
    /// A function: stable sort by the returned string.
    By(&'a dyn Fn(TypeRef) -> String),
}

/// `removeNullFromUnion(t, sortBy)`: the union's `null` member, if any, and
/// its other members.
pub fn remove_null_from_union(
    graph: &TypeGraph,
    t: TypeRef,
    sort_by: NullRemovalSort<'_>,
) -> Result<(Option<TypeRef>, IndexSet<TypeRef>)> {
    let sort = |s: IndexSet<TypeRef>| -> IndexSet<TypeRef> {
        let mut v: Vec<TypeRef> = s.into_iter().collect();
        match &sort_by {
            NullRemovalSort::None => {}
            NullRemovalSort::ByKind => sort_by_string_key(&mut v, |m| graph.kind(*m).as_str()),
            NullRemovalSort::By(key) => sort_by_string_key(&mut v, |m| key(*m)),
        }
        v.into_iter().collect()
    };

    let members = graph.type_at(t).members()?;
    let null_type = find_member(graph, t, TypeKind::Null)?;
    match null_type {
        None => Ok((None, sort(members.clone()))),
        Some(null_type) => Ok((
            Some(null_type),
            sort(
                members
                    .iter()
                    .copied()
                    .filter(|&m| graph.kind(m) != TypeKind::Null)
                    .collect(),
            ),
        )),
    }
}

/// `removeNullFromType(t)`.
pub fn remove_null_from_type(
    graph: &TypeGraph,
    t: TypeRef,
) -> Result<(Option<TypeRef>, IndexSet<TypeRef>)> {
    match graph.kind(t) {
        TypeKind::Null => Ok((Some(t), IndexSet::new())),
        TypeKind::Union => remove_null_from_union(graph, t, NullRemovalSort::None),
        _ => Ok((None, [t].into_iter().collect())),
    }
}

/// `nullableFromUnion(t)`: the single non-null member of a nullable union.
pub fn nullable_from_union(graph: &TypeGraph, t: TypeRef) -> Result<Option<TypeRef>> {
    let (has_null, non_nulls) = remove_null_from_union(graph, t, NullRemovalSort::None)?;
    if has_null.is_none() || non_nulls.len() != 1 {
        return Ok(None);
    }
    Ok(non_nulls.first().copied())
}

/// `nonNullTypeCases(t)`.
pub fn non_null_type_cases(graph: &TypeGraph, t: TypeRef) -> Result<IndexSet<TypeRef>> {
    Ok(remove_null_from_type(graph, t)?.1)
}

/// `getNullAsOptional(cp)`: whether the property is optional or nullable,
/// and its non-null types.
pub fn get_null_as_optional(
    graph: &TypeGraph,
    property: &crate::ty::ty::ClassProperty,
) -> Result<(bool, IndexSet<TypeRef>)> {
    let (maybe_null, non_nulls) = remove_null_from_type(graph, property.type_ref)?;
    if property.is_optional {
        return Ok((true, non_nulls));
    }
    Ok((maybe_null.is_some(), non_nulls))
}

/// `isNamedType(t)`: classes, unions, enums and objects (not maps).
pub fn is_named_type(t: &Type) -> bool {
    matches!(
        t.kind(),
        TypeKind::Class | TypeKind::Union | TypeKind::Enum | TypeKind::Object
    )
}

/// `SeparatedNamedTypes`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct SeparatedNamedTypes {
    /// Objects and classes.
    pub objects: IndexSet<TypeRef>,
    /// Enums.
    pub enums: IndexSet<TypeRef>,
    /// Unions.
    pub unions: IndexSet<TypeRef>,
}

/// `separateNamedTypes(types)`, keeping the order.
pub fn separate_named_types(graph: &TypeGraph, types: &IndexSet<TypeRef>) -> SeparatedNamedTypes {
    let of_kind = |pred: &dyn Fn(TypeKind) -> bool| -> IndexSet<TypeRef> {
        types
            .iter()
            .copied()
            .filter(|&t| pred(graph.kind(t)))
            .collect()
    };
    SeparatedNamedTypes {
        objects: of_kind(&|k| k == TypeKind::Object || k == TypeKind::Class),
        enums: of_kind(&|k| k == TypeKind::Enum),
        unions: of_kind(&|k| k == TypeKind::Union),
    }
}

/// `directlyReachableTypes(t, setForType)`.
pub fn directly_reachable_types<T: Clone + std::hash::Hash + Eq>(
    graph: &TypeGraph,
    t: TypeRef,
    set_for_type: &mut dyn FnMut(TypeRef) -> Result<Option<IndexSet<T>>>,
) -> Result<IndexSet<T>> {
    if let Some(set) = set_for_type(t)? {
        return Ok(set);
    }
    let mut result = IndexSet::new();
    for c in graph.non_attribute_children(t)? {
        result.extend(directly_reachable_types(graph, c, set_for_type)?);
    }
    Ok(result)
}

/// `directlyReachableSingleNamedType(type)`.
pub fn directly_reachable_single_named_type(
    graph: &TypeGraph,
    t: TypeRef,
) -> Result<Option<TypeRef>> {
    let defined_types = directly_reachable_types(graph, t, &mut |t| {
        let ty = graph.type_at(t);
        let is_union = ty.is_union();
        if (!is_union && is_named_type(ty))
            || (is_union && nullable_from_union(graph, t)?.is_none())
        {
            return Ok(Some([t].into_iter().collect()));
        }
        Ok(None)
    })?;
    assert(
        defined_types.len() <= 1,
        "Cannot have more than one defined type per top-level",
    )?;
    Ok(defined_types.first().copied())
}

/// `stringTypesForType(t)`: the string types of a `string`.
pub fn string_types_for_type(graph: &TypeGraph, t: TypeRef) -> Result<&StringTypes> {
    assert(
        graph.kind(t) == TypeKind::String,
        "Only strings can have string types",
    )?;
    match StringTypesTypeAttributeKind.try_get_in_attributes(graph.attributes(t)) {
        Some(st) => Ok(st),
        None => panic("All strings must have a string type attribute"),
    }
}

/// `UnionType.findMember(kind)`: the first member of that kind.
pub fn find_member(graph: &TypeGraph, union: TypeRef, kind: TypeKind) -> Result<Option<TypeRef>> {
    Ok(graph
        .type_at(union)
        .members()?
        .iter()
        .copied()
        .find(|&m| graph.kind(m) == kind))
}

/// `UnionType.stringTypeMembers`: members that are primitive strings or
/// enums.
pub fn string_type_members(graph: &TypeGraph, union: TypeRef) -> Result<IndexSet<TypeRef>> {
    Ok(graph
        .type_at(union)
        .members()?
        .iter()
        .copied()
        .filter(|&m| {
            let k = graph.kind(m);
            k.is_primitive_string_type_kind() || k == TypeKind::Enum
        })
        .collect())
}

/// `UnionType.isCanonical`: more than one member, all of distinct kinds, no
/// nested set operations, no `none`/`any`, not both `string` and `enum`,
/// at most one object kind.
pub fn union_is_canonical(graph: &TypeGraph, union: TypeRef) -> Result<bool> {
    let members = graph.type_at(union).members()?;
    if members.len() <= 1 {
        return Ok(false);
    }
    let kinds: IndexSet<TypeKind> = members.iter().map(|&m| graph.kind(m)).collect();
    if kinds.len() < members.len() {
        return Ok(false);
    }
    if kinds.contains(&TypeKind::Union) || kinds.contains(&TypeKind::Intersection) {
        return Ok(false);
    }
    if kinds.contains(&TypeKind::None) || kinds.contains(&TypeKind::Any) {
        return Ok(false);
    }
    if kinds.contains(&TypeKind::String) && kinds.contains(&TypeKind::Enum) {
        return Ok(false);
    }
    let num_object_types = [TypeKind::Class, TypeKind::Map, TypeKind::Object]
        .iter()
        .filter(|k| kinds.contains(*k))
        .count();
    Ok(num_object_types <= 1)
}

/// `t.isNullable`: `null`, `any` and `none` are nullable, and unions with a
/// `null` member. Errors for intersections, like TypeScript.
pub fn is_nullable(graph: &TypeGraph, t: TypeRef) -> Result<bool> {
    let ty = graph.type_at(t);
    match ty.kind() {
        TypeKind::Null | TypeKind::Any | TypeKind::None => Ok(true),
        TypeKind::Union => Ok(find_member(graph, t, TypeKind::Null)?.is_some()),
        TypeKind::Intersection => panic("isNullable not implemented for IntersectionType"),
        _ => Ok(false),
    }
}
