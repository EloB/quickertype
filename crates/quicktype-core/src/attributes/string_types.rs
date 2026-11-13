//! Port of `packages/quicktype-core/src/attributes/StringTypes.ts`.
//!
//! The `stringTypes` attribute of a `string` type: either unrestricted, or a
//! set of string cases with their occurrence counts plus the transformed
//! string kinds (dates, UUIDs, ...) the strings may be.

use indexmap::{IndexMap, IndexSet};

use crate::messages::Result;
use crate::support::collection_utils::{JsEquals, JsHash, add_hash_code, set_intersect};
use crate::support::support::assert;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// `stringTypesTypeAttributeKind`: the `stringTypes` attribute.
#[derive(Clone, Copy, Debug, Default)]
pub struct StringTypesTypeAttributeKind;

impl StringTypesTypeAttributeKind {
    /// `requiresUniqueIdentity(st)`: string types with cases make their type
    /// unique.
    pub fn requires_unique_identity(st: &StringTypes) -> bool {
        st.cases.as_ref().is_some_and(|c| !c.is_empty())
    }
}

/// `StringTypes`.
#[derive(Clone, Debug, PartialEq)]
pub struct StringTypes {
    /// The cases and their counts; `None` means unrestricted.
    pub cases: Option<IndexMap<String, u64>>,
    /// The transformed string kinds the strings may be.
    pub transformations: IndexSet<TypeKind>,
}

impl StringTypes {
    /// `StringTypes.unrestricted`.
    pub fn unrestricted() -> StringTypes {
        StringTypes {
            cases: None,
            transformations: IndexSet::new(),
        }
    }

    /// `new StringTypes(cases, transformations)`. An unrestricted string
    /// cannot have transformations.
    pub fn new(
        cases: Option<IndexMap<String, u64>>,
        transformations: IndexSet<TypeKind>,
    ) -> Result<StringTypes> {
        if cases.is_none() {
            assert(
                transformations.is_empty(),
                "We can't have an unrestricted string that also allows transformations",
            )?;
        }
        Ok(StringTypes {
            cases,
            transformations,
        })
    }

    /// `StringTypes.fromCase(s, count)`.
    pub fn from_case(s: &str, count: u64) -> StringTypes {
        StringTypes {
            cases: Some([(s.to_owned(), count)].into_iter().collect()),
            transformations: IndexSet::new(),
        }
    }

    /// `StringTypes.fromCases(cases)`: each case counted once.
    pub fn from_cases(cases: &[String]) -> StringTypes {
        StringTypes {
            cases: Some(cases.iter().map(|s| (s.clone(), 1)).collect()),
            transformations: IndexSet::new(),
        }
    }

    /// `isRestricted`.
    pub fn is_restricted(&self) -> bool {
        self.cases.is_some()
    }

    /// `union(othersArray, startIndex)` with `others = othersArray[startIndex..]`:
    /// counts are added, transformations united. Unrestricted absorbs.
    pub fn union(&self, others: &[&StringTypes]) -> StringTypes {
        let Some(own_cases) = &self.cases else {
            return self.clone();
        };
        let mut cases = own_cases.clone();
        let mut transformations = self.transformations.clone();
        for other in others {
            let Some(other_cases) = &other.cases else {
                return (*other).clone();
            };
            for (k, v) in other_cases {
                *cases.entry(k.clone()).or_insert(0) += v;
            }
            transformations.extend(other.transformations.iter().copied());
        }
        StringTypes {
            cases: Some(cases),
            transformations,
        }
    }

    /// `intersect(othersArray, startIndex)` with
    /// `others = othersArray[startIndex..]`. Cases are the common ones (in
    /// this order), or all of this one's if there are none in common; counts
    /// are the minimum.
    pub fn intersect(&self, others: &[&StringTypes]) -> StringTypes {
        let mut cases = self.cases.clone();
        let mut transformations = self.transformations.clone();
        for other in others {
            match (&cases, &other.cases) {
                (None, other_cases) => cases = other_cases.clone(),
                (Some(this_cases), Some(other_cases)) => {
                    let intersects: Vec<&String> = this_cases
                        .keys()
                        .filter(|k| other_cases.contains_key(*k))
                        .collect();
                    let keys: Vec<&String> = if intersects.is_empty() {
                        this_cases.keys().collect()
                    } else {
                        intersects
                    };
                    let new_cases: IndexMap<String, u64> = keys
                        .into_iter()
                        .map(|k| {
                            let this_value = this_cases[k];
                            let value = match other_cases.get(k) {
                                Some(&other_value) => this_value.min(other_value),
                                None => this_value,
                            };
                            (k.clone(), value)
                        })
                        .collect();
                    cases = Some(new_cases);
                }
                (Some(_), None) => {}
            }
            transformations = set_intersect(&transformations, &other.transformations);
        }
        StringTypes {
            cases,
            transformations,
        }
    }

    /// `applyStringTypeMapping(mapping)`: unrestricted if any transformation
    /// maps to `string`.
    pub fn apply_string_type_mapping(&self, mapping: &StringTypeMapping) -> StringTypes {
        if !self.is_restricted() {
            return self.clone();
        }
        let mut kinds = IndexSet::new();
        for &kind in &self.transformations {
            let mapped = mapping.get(kind);
            if mapped == TypeKind::String {
                return StringTypes::unrestricted();
            }
            kinds.insert(mapped);
        }
        StringTypes {
            cases: self.cases.clone(),
            transformations: kinds,
        }
    }
}

impl std::fmt::Display for StringTypes {
    /// `toString()`, as printed by the graph printer.
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let mut parts: Vec<String> = Vec::new();
        match &self.cases {
            None => parts.push("unrestricted".to_owned()),
            Some(cases) => match cases.first() {
                None => parts.push("enum with no cases".to_owned()),
                Some((first_key, count)) => {
                    parts.push(format!("{} enums: {first_key} ({count}), ...", cases.len()))
                }
            },
        }
        parts.extend(self.transformations.iter().map(|k| k.as_str().to_owned()));
        f.write_str(&parts.join(","))
    }
}

impl JsHash for StringTypes {
    fn hash_code(&self) -> i64 {
        let h = self.cases.hash_code();
        add_hash_code(h, self.transformations.hash_code())
    }
}

impl JsEquals for StringTypes {
    fn js_equals(&self, other: &Self) -> bool {
        self.cases.js_equals(&other.cases) && self.transformations.js_equals(&other.transformations)
    }
}

/// The `DateTimeRecognizer` interface of `DateTime.ts`, which
/// [`infer_transformed_string_type_kind_for_string`] takes.
pub trait DateTimeRecognizer {
    /// Whether `s` is a date.
    fn is_date(&self, s: &str) -> bool;
    /// Whether `s` is a time.
    fn is_time(&self, s: &str) -> bool;
    /// Whether `s` is a date-time.
    fn is_date_time(&self, s: &str) -> bool;
}

/// `INTEGER_STRING` (`/^(0|-?[1-9]\d*)$/`) within the 32-bit signed range.
fn is_integer_string(s: &str) -> bool {
    let digits = s.strip_prefix('-').unwrap_or(s);
    let matches = s == "0"
        || (!digits.is_empty()
            && digits.as_bytes()[0] != b'0'
            && digits.bytes().all(|b| b.is_ascii_digit()));
    if !matches {
        return false;
    }
    if digits.len() > 11 {
        return false;
    }
    match s.parse::<i64>() {
        Ok(i) => (i64::from(i32::MIN)..=i64::from(i32::MAX)).contains(&i),
        Err(_) => false,
    }
}

/// `UUID` (`/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/`).
fn is_uuid(s: &str) -> bool {
    let groups: Vec<&str> = s.split('-').collect();
    let lengths = [8, 4, 4, 4, 12];
    groups.len() == 5
        && groups.iter().zip(lengths).all(|(g, len)| {
            g.len() == len
                && g.bytes()
                    .all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b))
        })
}

/// `URI` (`/^(https?|ftp):\/\/[^{}]+$/`).
fn is_uri(s: &str) -> bool {
    let rest = ["http://", "https://", "ftp://"]
        .iter()
        .find_map(|p| s.strip_prefix(p));
    rest.is_some_and(|r| !r.is_empty() && !r.contains(['{', '}']))
}

/// `inferTransformedStringTypeKindForString(s, recognizer)`: the
/// transformed string kind JSON inference infers for a string, if any.
pub fn infer_transformed_string_type_kind_for_string(
    s: &str,
    recognizer: &dyn DateTimeRecognizer,
) -> Option<TypeKind> {
    let first = s.chars().next()?;
    if !"0123456789-abcdefth".contains(first) {
        return None;
    }
    if recognizer.is_date(s) {
        Some(TypeKind::Date)
    } else if recognizer.is_time(s) {
        Some(TypeKind::Time)
    } else if recognizer.is_date_time(s) {
        Some(TypeKind::DateTime)
    } else if is_integer_string(s) {
        Some(TypeKind::IntegerString)
    } else if s == "false" || s == "true" {
        Some(TypeKind::BoolString)
    } else if is_uuid(s) {
        Some(TypeKind::Uuid)
    } else if is_uri(s) {
        Some(TypeKind::Uri)
    } else {
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn cases(st: &StringTypes) -> Vec<(String, u64)> {
        st.cases
            .as_ref()
            .unwrap()
            .iter()
            .map(|(k, v)| (k.clone(), *v))
            .collect()
    }

    #[test]
    fn union_adds_counts_and_unrestricted_absorbs() {
        let a = StringTypes::from_case("red", 2);
        let b = StringTypes::from_cases(&["blue".into(), "red".into()]);
        let u = a.union(&[&b]);
        assert_eq!(cases(&u), vec![("red".into(), 3), ("blue".into(), 1)]);
        assert!(!a.union(&[&StringTypes::unrestricted()]).is_restricted());
        assert!(!StringTypes::unrestricted().union(&[&a]).is_restricted());
    }

    #[test]
    fn intersect_keeps_common_cases_or_all() {
        let a = StringTypes::from_cases(&["x".into(), "y".into(), "z".into()]);
        let b = StringTypes::from_case("y", 5);
        assert_eq!(cases(&a.intersect(&[&b])), vec![("y".into(), 1)]);
        let c = StringTypes::from_case("q", 5);
        assert_eq!(
            cases(&a.intersect(&[&c])),
            vec![("x".into(), 1), ("y".into(), 1), ("z".into(), 1)]
        );
        assert_eq!(
            cases(&StringTypes::unrestricted().intersect(&[&b])),
            vec![("y".into(), 5)]
        );
    }

    #[test]
    fn prints_like_to_string() {
        let mut st = StringTypes::from_case("hello", 1);
        st.transformations.insert(TypeKind::Date);
        assert_eq!(st.to_string(), "1 enums: hello (1), ...,date");
        assert_eq!(StringTypes::unrestricted().to_string(), "unrestricted");
        let empty = StringTypes::new(Some(IndexMap::new()), IndexSet::new()).unwrap();
        let e = StringTypes::new(None, [TypeKind::Date].into_iter().collect()).unwrap_err();
        assert_eq!(
            e.user_message(),
            "Internal error: We can't have an unrestricted string that also allows transformations"
        );
        assert_eq!(empty.to_string(), "enum with no cases");
    }

    #[test]
    fn mapping_to_string_makes_unrestricted() {
        let mut st = StringTypes::from_case("2020-01-01", 1);
        st.transformations.insert(TypeKind::Date);
        let mut m = StringTypeMapping::new();
        assert!(!st.apply_string_type_mapping(&m).is_restricted());
        m.set(TypeKind::Date, TypeKind::Date);
        assert!(st.apply_string_type_mapping(&m).is_restricted());
    }

    struct NoDates;
    impl DateTimeRecognizer for NoDates {
        fn is_date(&self, _: &str) -> bool {
            false
        }
        fn is_time(&self, _: &str) -> bool {
            false
        }
        fn is_date_time(&self, _: &str) -> bool {
            false
        }
    }

    #[test]
    fn infers_transformed_kinds() {
        let r = NoDates;
        let infer = |s| infer_transformed_string_type_kind_for_string(s, &r);
        assert_eq!(infer("123"), Some(TypeKind::IntegerString));
        assert_eq!(infer("-2147483648"), Some(TypeKind::IntegerString));
        assert_eq!(infer("2147483648"), None);
        assert_eq!(infer("0"), Some(TypeKind::IntegerString));
        assert_eq!(infer("-0"), None);
        assert_eq!(infer("007"), None);
        assert_eq!(infer("true"), Some(TypeKind::BoolString));
        assert_eq!(infer("False"), None);
        assert_eq!(
            infer("123e4567-e89b-12d3-a456-426614174000"),
            Some(TypeKind::Uuid)
        );
        assert_eq!(infer("123E4567-e89b-12d3-a456-426614174000"), None);
        assert_eq!(infer("https://x.org/a"), Some(TypeKind::Uri));
        assert_eq!(infer("http://"), None);
        assert_eq!(infer("ftp://x"), Some(TypeKind::Uri));
        assert_eq!(infer("http://{x}"), None);
        assert_eq!(infer(""), None);
        assert_eq!(infer("zebra"), None);
    }
}
