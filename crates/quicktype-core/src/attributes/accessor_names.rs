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
    let accessors = AccessorNamesTypeAttributeKind.try_get_in_attributes(graph.attributes(o)?);
    let properties = graph.type_at(o)?.properties()?;
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
    let accessors = AccessorNamesTypeAttributeKind.try_get_in_attributes(graph.attributes(e)?);
    let cases = graph.type_at(e)?.cases()?;
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
        UnionIdentifierTypeAttributeKind.try_get_in_attributes(graph.attributes(u)?)
    else {
        return Ok((None, false));
    };
    let Some(member_names) =
        UnionMemberNamesTypeAttributeKind.try_get_in_attributes(graph.attributes(member)?)
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

// ---------------------------------------------------------------------------
// JSON Schema input: `makeAccessorNames`, `accessorNamesAttributeProducer`

/// `isAccessorEntry(x)`: a string, or an object of strings.
fn is_accessor_entry(x: &crate::input::json_schema_store::JsonSchema) -> bool {
    use crate::input::json_schema_store::JsonSchema;
    match x {
        JsonSchema::String(_) => true,
        JsonSchema::Object(map) => map.values().all(|v| matches!(v, JsonSchema::String(_))),
        _ => false,
    }
}

/// `makeAccessorEntry(ae)`: a string is a name for every language,
/// anything else is read as an object of names by language
/// (`mapFromObject`). Values that are not strings (which TypeScript would
/// pass on as they are) are converted with `String(value)`.
fn make_accessor_entry(ae: &crate::input::json_schema_store::JsonSchema) -> Result<AccessorEntry> {
    use crate::input::json_schema_input::type_error;
    use crate::input::json_schema_store::JsonSchema;
    Ok(match ae {
        JsonSchema::String(s) => AccessorEntry::Name(s.clone()),
        JsonSchema::Object(map) => AccessorEntry::ByLanguage(
            map.iter()
                .map(|(k, v)| (k.clone(), v.to_js_string()))
                .collect(),
        ),
        JsonSchema::Array(items) => {
            let mut names: IndexMap<String, String> = items
                .iter()
                .enumerate()
                .map(|(i, v)| (i.to_string(), v.to_js_string()))
                .collect();
            names.insert("length".to_owned(), items.len().to_string());
            AccessorEntry::ByLanguage(names)
        }
        JsonSchema::Null => return Err(type_error("Cannot convert undefined or null to object")),
        JsonSchema::Bool(_) | JsonSchema::Number(_) => AccessorEntry::ByLanguage(IndexMap::new()),
    })
}

/// `makeAccessorNames(x)`: accessor entries by name from a `qt-accessors`
/// (or `qt-enum-values`) object.
pub fn make_accessor_names(
    x: &crate::input::json_schema_store::JsonSchema,
) -> Result<AccessorNames> {
    use crate::input::json_schema_store::JsonSchema;
    // FIXME (as in TypeScript): do proper error reporting.
    let JsonSchema::Object(map) = x else {
        return crate::support::support::panic(format!(
            "Value must be an object, but is {}",
            x.to_js_string()
        ));
    };
    map.iter()
        .map(|(k, v)| Ok((k.clone(), make_accessor_entry(v)?)))
        .collect()
}

/// `accessorNamesAttributeProducer(schema, canonicalRef, types, cases)`:
/// `qt-accessors` names the properties or enum cases of the type; under
/// `oneOf` it is an array naming each case.
pub fn accessor_names_attribute_producer(
    schema: &crate::input::json_schema_store::JsonSchema,
    canonical_ref: &crate::input::json_schema_input::Ref,
    _types: &IndexSet<crate::input::json_schema_input::JsonSchemaType>,
    cases: Option<&[crate::input::json_schema_store::JsonSchema]>,
) -> Result<Option<crate::input::json_schema_input::JsonSchemaAttributes>> {
    use crate::input::json_schema_input::JsonSchemaAttributes;
    use crate::input::json_schema_store::check_array;

    let Some(maybe_accessors) = schema.get("qt-accessors") else {
        return Ok(None);
    };
    let Some(cases) = cases else {
        return Ok(Some(JsonSchemaAttributes {
            for_type: Some(
                AccessorNamesTypeAttributeKind
                    .make_attributes(make_accessor_names(maybe_accessors)?),
            ),
            ..JsonSchemaAttributes::default()
        }));
    };
    let identifier_attribute = make_union_identifier_attribute();
    let accessors = check_array(maybe_accessors, is_accessor_entry)?;
    let properties = vec![
        ("operation", MessageValue::from("oneOf")),
        ("ref", canonical_ref.push(&["oneOf"])?.message_value()),
    ];
    message_assert(
        cases.len() == accessors.len(),
        ErrorKind::SchemaWrongAccessorEntryArrayLength,
        properties,
    )?;
    let case_attributes = accessors
        .iter()
        .map(|accessor| {
            make_union_member_names_attribute(&identifier_attribute, make_accessor_entry(accessor)?)
        })
        .collect::<Result<Vec<_>>>()?;
    Ok(Some(JsonSchemaAttributes {
        for_union: Some(identifier_attribute),
        for_cases: Some(case_attributes),
        ..JsonSchemaAttributes::default()
    }))
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
