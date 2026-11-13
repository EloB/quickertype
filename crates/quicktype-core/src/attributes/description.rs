//! Port of `packages/quicktype-core/src/attributes/Description.ts`.
//!
//! Descriptions of types and of class properties. The schema attribute
//! producer (`descriptionAttributeProducer`) and `addToSchema` are ported
//! with the JSON Schema input and output.

use indexmap::{IndexMap, IndexSet};

use quicktype_js_compat::utf16;

/// `descriptionTypeAttributeKind`: a type's descriptions.
#[derive(Clone, Copy, Debug, Default)]
pub struct DescriptionTypeAttributeKind;

/// `propertyDescriptionsTypeAttributeKind`: descriptions of a class's
/// properties, by property name.
#[derive(Clone, Copy, Debug, Default)]
pub struct PropertyDescriptionsTypeAttributeKind;

/// `DescriptionTypeAttributeKind.combine`: the union of all descriptions.
pub(crate) fn combine_descriptions(attrs: &[&IndexSet<String>]) -> IndexSet<String> {
    attrs.iter().flat_map(|s| s.iter().cloned()).collect()
}

/// `PropertyDescriptionsTypeAttributeKind.combine`: per property, the union
/// of the descriptions.
pub(crate) fn combine_property_descriptions(
    attrs: &[&IndexMap<String, IndexSet<String>>],
) -> IndexMap<String, IndexSet<String>> {
    let mut result: IndexMap<String, IndexSet<String>> = IndexMap::new();
    for attr in attrs {
        for (name, descriptions) in attr.iter() {
            result
                .entry(name.clone())
                .or_default()
                .extend(descriptions.iter().cloned());
        }
    }
    result
}

/// `DescriptionTypeAttributeKind.stringify`: the first description, cut to
/// five UTF-16 code units plus `...` if longer than eight, and `, ...` if
/// there are more.
pub(crate) fn stringify_description(descriptions: &IndexSet<String>) -> Option<String> {
    let first = descriptions.first()?;
    let mut result = if utf16::len(first) > 5 + 3 {
        // `result.slice(0, 5)`; a cut surrogate pair is dropped (see "Known
        // gaps" in docs/PARITY.md).
        format!("{}...", utf16::slice(first, 0, Some(5)))
    } else {
        first.clone()
    };
    if descriptions.len() > 1 {
        result.push_str(", ...");
    }
    Some(result)
}

/// `PropertyDescriptionsTypeAttributeKind.stringify`.
pub(crate) fn stringify_property_descriptions(
    property_descriptions: &IndexMap<String, IndexSet<String>>,
) -> Option<String> {
    if property_descriptions.is_empty() {
        return None;
    }
    Some(format!("prop descs: {}", property_descriptions.len()))
}

/// `addDescriptionToSchema`'s value: the descriptions joined by newlines.
pub fn description_for_schema<'a>(description: impl IntoIterator<Item = &'a String>) -> String {
    description
        .into_iter()
        .map(String::as_str)
        .collect::<Vec<_>>()
        .join("\n")
}

#[cfg(test)]
mod tests {
    use super::*;

    fn set(items: &[&str]) -> IndexSet<String> {
        items.iter().map(|s| (*s).to_owned()).collect()
    }

    #[test]
    fn stringify() {
        assert_eq!(stringify_description(&set(&["short"])).unwrap(), "short");
        assert_eq!(
            stringify_description(&set(&["12345678"])).unwrap(),
            "12345678"
        );
        assert_eq!(
            stringify_description(&set(&["123456789"])).unwrap(),
            "12345..."
        );
        assert_eq!(stringify_description(&set(&["a", "b"])).unwrap(), "a, ...");
        assert_eq!(stringify_description(&IndexSet::new()), None);
    }

    #[test]
    fn combine_property_descriptions_unions_per_property() {
        let a: IndexMap<String, IndexSet<String>> =
            [("x".to_owned(), set(&["1"])), ("y".to_owned(), set(&["2"]))]
                .into_iter()
                .collect();
        let b: IndexMap<String, IndexSet<String>> =
            [("y".to_owned(), set(&["3"])), ("z".to_owned(), set(&["4"]))]
                .into_iter()
                .collect();
        let c = combine_property_descriptions(&[&a, &b]);
        assert_eq!(c.keys().collect::<Vec<_>>(), vec!["x", "y", "z"]);
        assert_eq!(c["y"], set(&["2", "3"]));
        assert_eq!(
            stringify_property_descriptions(&c).unwrap(),
            "prop descs: 3"
        );
    }
}
