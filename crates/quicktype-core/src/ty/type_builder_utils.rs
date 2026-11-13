//! Port of `packages/quicktype-core/src/Type/TypeBuilderUtils.ts`.

use indexmap::IndexMap;

use super::transformed_string_type::{TRANSFORMED_STRING_TYPE_KINDS, TypeKind};

/// `StringTypeMapping`: which primitive string kind each transformed string
/// kind becomes in a target language. Kinds without an entry map to
/// `string`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct StringTypeMapping(IndexMap<TypeKind, TypeKind>);

impl StringTypeMapping {
    /// An empty mapping: every transformed kind maps to `string`.
    pub fn new() -> Self {
        Self::default()
    }

    /// Sets the kind `kind` maps to (`Map.prototype.set`).
    pub fn set(&mut self, kind: TypeKind, mapped: TypeKind) {
        self.0.insert(kind, mapped);
    }

    /// The raw entry for `kind`, if any (`Map.prototype.get`).
    pub fn get_entry(&self, kind: TypeKind) -> Option<TypeKind> {
        self.0.get(&kind).copied()
    }

    /// `stringTypeMappingGet(stm, kind)`: the mapped kind, `string` if absent.
    pub fn get(&self, kind: TypeKind) -> TypeKind {
        self.get_entry(kind).unwrap_or(TypeKind::String)
    }

    /// The entries, in insertion order.
    pub fn iter(&self) -> impl Iterator<Item = (TypeKind, TypeKind)> + '_ {
        self.0.iter().map(|(k, v)| (*k, *v))
    }
}

impl FromIterator<(TypeKind, TypeKind)> for StringTypeMapping {
    fn from_iter<I: IntoIterator<Item = (TypeKind, TypeKind)>>(iter: I) -> Self {
        StringTypeMapping(iter.into_iter().collect())
    }
}

/// `getNoStringTypeMapping()`: every transformed kind maps to itself.
pub fn get_no_string_type_mapping() -> StringTypeMapping {
    TRANSFORMED_STRING_TYPE_KINDS
        .iter()
        .map(|&k| (k, k))
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn missing_entries_map_to_string() {
        let mut m = StringTypeMapping::new();
        assert_eq!(m.get(TypeKind::Date), TypeKind::String);
        m.set(TypeKind::Date, TypeKind::Date);
        assert_eq!(m.get(TypeKind::Date), TypeKind::Date);
        let none = get_no_string_type_mapping();
        assert_eq!(none.get(TypeKind::Uuid), TypeKind::Uuid);
        assert_eq!(none.iter().count(), 7);
    }
}
