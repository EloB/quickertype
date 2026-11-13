//! Port of `packages/quicktype-core/src/attributes/AccessorNames.ts`.
//!
//! User-specified names for class properties and enum cases (`qt-accessors`)
//! and for union members. Union members can be recombined and reordered, so
//! each union in the input graph gets a union identifier, and each member a
//! map from union identifiers to accessor entries.
//!
//! Turning a JSON Schema value into accessor names (`makeAccessorNames`,
//! `accessorNamesAttributeProducer`) is ported with the JSON Schema input.

use std::cell::Cell;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::{AttributeKind, TypeAttributes};
use crate::messages::{ErrorKind, MessageValue, Result, message_assert};
use crate::support::collection_utils::{JsEquals, JsHash};
use crate::support::support::defined;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `AccessorEntry`: a name for all languages, or names per language (with
/// `"*"` as the wildcard).
#[derive(Clone, Debug, PartialEq)]
pub enum AccessorEntry {
    /// A name for every language.
    Name(String),
    /// Names by language.
    ByLanguage(IndexMap<String, String>),
}

impl JsHash for AccessorEntry {
    fn hash_code(&self) -> i64 {
        match self {
            AccessorEntry::Name(s) => s.hash_code(),
            AccessorEntry::ByLanguage(m) => m.hash_code(),
        }
    }
}

impl JsEquals for AccessorEntry {
    fn js_equals(&self, other: &Self) -> bool {
        match (self, other) {
            (AccessorEntry::Name(a), AccessorEntry::Name(b)) => a == b,
            (AccessorEntry::ByLanguage(a), AccessorEntry::ByLanguage(b)) => a.js_equals(b),
            _ => false,
        }
    }
}

/// `AccessorNames`: accessor entries by property name or enum case.
pub type AccessorNames = IndexMap<String, AccessorEntry>;

/// `accessorNamesTypeAttributeKind`: `accessorNames`. Cannot be combined.
#[derive(Clone, Copy, Debug, Default)]
pub struct AccessorNamesTypeAttributeKind;

/// `unionIdentifierTypeAttributeKind`: `unionIdentifier`.
#[derive(Clone, Copy, Debug, Default)]
pub struct UnionIdentifierTypeAttributeKind;

/// `unionMemberNamesTypeAttributeKind`: `unionMemberNames`.
#[derive(Clone, Copy, Debug, Default)]
pub struct UnionMemberNamesTypeAttributeKind;

/// `getFromEntry(entry, language)`: `[name, isFixed]`.
fn get_from_entry(entry: &AccessorEntry, language: &str) -> Option<(String, bool)> {
    match entry {
        AccessorEntry::Name(s) => Some((s.clone(), false)),
        AccessorEntry::ByLanguage(m) => {
            if let Some(name) = m.get(language) {
                return Some((name.clone(), true));
            }
            m.get("*").map(|name| (name.clone(), false))
        }
    }
}

/// `lookupKey(accessors, key, language)`.
pub fn lookup_key(accessors: &AccessorNames, key: &str, language: &str) -> Option<(String, bool)> {
    accessors
        .get(key)
        .and_then(|entry| get_from_entry(entry, language))
}

/// `objectPropertyNames(o, language)`: the accessor name of each property.
pub fn object_property_names(
    graph: &TypeGraph,
    o: TypeRef,
    language: &str,
) -> Result<IndexMap<String, Option<(String, bool)>>> {
    let accessors = AccessorNamesTypeAttributeKind.try_get_in_attributes(graph.attributes(o));
    let properties = graph.type_at(o).properties()?;
    Ok(properties
        .keys()
        .map(|n| {
            (
                n.clone(),
                accessors.and_then(|a| lookup_key(a, n, language)),
            )
        })
        .collect())
}

/// `enumCaseNames(e, language)`: the accessor name of each enum case.
pub fn enum_case_names(
    graph: &TypeGraph,
    e: TypeRef,
    language: &str,
) -> Result<IndexMap<String, Option<(String, bool)>>> {
    let accessors = AccessorNamesTypeAttributeKind.try_get_in_attributes(graph.attributes(e));
    let cases = graph.type_at(e).cases()?;
    Ok(cases
        .iter()
        .map(|c| {
            (
                c.clone(),
                accessors.and_then(|a| lookup_key(a, c, language)),
            )
        })
        .collect())
}

/// `getAccessorName(names, original)`: `[name, isFixed]`.
pub fn get_accessor_name(
    names: &IndexMap<String, Option<(String, bool)>>,
    original: &str,
) -> (Option<String>, bool) {
    match names.get(original) {
        Some(Some((name, fixed))) => (Some(name.clone()), *fixed),
        _ => (None, false),
    }
}

/// `UnionIdentifierTypeAttributeKind.combine`.
pub(crate) fn combine_union_identifiers(arr: &[&IndexSet<u32>]) -> IndexSet<u32> {
    arr.iter().flat_map(|s| s.iter().copied()).collect()
}

/// `UnionMemberNamesTypeAttributeKind.combine`: later entries win.
pub(crate) fn combine_union_member_names(
    arr: &[&IndexMap<u32, AccessorEntry>],
) -> IndexMap<u32, AccessorEntry> {
    let mut result = IndexMap::new();
    for m in arr {
        for (k, v) in m.iter() {
            result.insert(*k, v.clone());
        }
    }
    result
}

thread_local! {
    static NEXT_UNION_IDENTIFIER: Cell<u32> = const { Cell::new(0) };
}

/// `makeUnionIdentifierAttribute()`: a fresh union identifier. Like the
/// module-global counter in TypeScript, it is never reset.
pub fn make_union_identifier_attribute() -> TypeAttributes {
    let id = NEXT_UNION_IDENTIFIER.with(|n| {
        let id = n.get();
        n.set(id + 1);
        id
    });
    UnionIdentifierTypeAttributeKind.make_attributes([id].into_iter().collect())
}

/// `makeUnionMemberNamesAttribute(unionAttributes, entry)`.
pub fn make_union_member_names_attribute(
    union_attributes: &TypeAttributes,
    entry: AccessorEntry,
) -> Result<TypeAttributes> {
    let identifiers =
        defined(UnionIdentifierTypeAttributeKind.try_get_in_attributes(union_attributes))?;
    let map: IndexMap<u32, AccessorEntry> =
        identifiers.iter().map(|&i| (i, entry.clone())).collect();
    Ok(UnionMemberNamesTypeAttributeKind.make_attributes(map))
}

/// `unionMemberName(u, member, language)`: `[name, isFixed]`. Errors if a
/// member has more than one name.
pub fn union_member_name(
    graph: &TypeGraph,
    u: TypeRef,
    member: TypeRef,
    language: &str,
) -> Result<(Option<String>, bool)> {
    let Some(identifiers) =
        UnionIdentifierTypeAttributeKind.try_get_in_attributes(graph.attributes(u))
    else {
        return Ok((None, false));
    };
    let Some(member_names) =
        UnionMemberNamesTypeAttributeKind.try_get_in_attributes(graph.attributes(member))
    else {
        return Ok((None, false));
    };

    let mut names: IndexSet<String> = IndexSet::new();
    let mut fixed_names: IndexSet<String> = IndexSet::new();
    for i in identifiers {
        let Some(entry) = member_names.get(i) else {
            continue;
        };
        let Some((name, is_name_fixed)) = get_from_entry(entry, language) else {
            continue;
        };
        if is_name_fixed {
            fixed_names.insert(name);
        } else {
            names.insert(name);
        }
    }

    let (first, size, is_fixed) = if let Some(first) = fixed_names.first() {
        (first.clone(), fixed_names.len(), true)
    } else if let Some(first) = names.first() {
        (first.clone(), names.len(), false)
    } else {
        return Ok((None, false));
    };

    message_assert(
        size == 1,
        ErrorKind::SchemaMoreThanOneUnionMemberName,
        vec![(
            "names",
            MessageValue::Array(names.iter().map(|n| n.as_str().into()).collect()),
        )],
    )?;
    Ok((Some(first), is_fixed))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn entries_resolve_per_language() {
        let mut accessors = AccessorNames::new();
        accessors.insert("a".into(), AccessorEntry::Name("A".into()));
        accessors.insert(
            "b".into(),
            AccessorEntry::ByLanguage(
                [
                    ("go".to_owned(), "BGo".to_owned()),
                    ("*".to_owned(), "B".to_owned()),
                ]
                .into_iter()
                .collect(),
            ),
        );
        assert_eq!(lookup_key(&accessors, "a", "go"), Some(("A".into(), false)));
        assert_eq!(
            lookup_key(&accessors, "b", "go"),
            Some(("BGo".into(), true))
        );
        assert_eq!(
            lookup_key(&accessors, "b", "rust"),
            Some(("B".into(), false))
        );
        assert_eq!(lookup_key(&accessors, "c", "rust"), None);
    }

    #[test]
    fn union_identifiers_count_up() {
        let a = make_union_identifier_attribute();
        let b = make_union_identifier_attribute();
        let ia = UnionIdentifierTypeAttributeKind
            .try_get_in_attributes(&a)
            .unwrap()[0];
        let ib = UnionIdentifierTypeAttributeKind
            .try_get_in_attributes(&b)
            .unwrap()[0];
        assert_eq!(ib, ia + 1);
        let m = make_union_member_names_attribute(&a, AccessorEntry::Name("x".into())).unwrap();
        let names = UnionMemberNamesTypeAttributeKind
            .try_get_in_attributes(&m)
            .unwrap();
        assert_eq!(names.get(&ia), Some(&AccessorEntry::Name("x".into())));
    }
}
