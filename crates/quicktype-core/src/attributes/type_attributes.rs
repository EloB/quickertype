//! Port of `packages/quicktype-core/src/attributes/TypeAttributes.ts`.
//!
//! Type attributes are extra information attached to types: names,
//! descriptions, string cases, constraints, provenance, transformations, ...
//! In TypeScript each kind is a `TypeAttributeKind<T>` singleton and a type's
//! attributes are a `ReadonlyMap<TypeAttributeKind, any>`. Here:
//!
//! * [`TypeAttributeKind`] enumerates the kinds; the per-kind behavior
//!   (`combine`, `intersect`, `makeInferred`, `appliesToTypeKind`, ...) is a
//!   `match` that delegates to each kind's module.
//! * [`TypeAttributeValue`] holds a value of any kind; the enum variant
//!   determines the kind.
//! * [`TypeAttributes`] is the map. It keeps JavaScript `Map` insertion order,
//!   which is observable (it is the order attributes are combined in and the
//!   order the JSON Schema renderer emits them): setting an existing kind
//!   keeps its slot, removing a kind keeps the others' order.
//! * The [`AttributeKind`] trait gives each kind a typed handle (a unit
//!   struct such as `NamesTypeAttributeKind`) with the TypeScript accessors
//!   `makeAttributes`, `tryGetInAttributes`, `modifyInAttributes`,
//!   `setDefaultInAttributes` and `removeInAttributes`.
//!
//! The renderer-only kinds of `ConvenienceRenderer.ts` (`assignedName`, ...)
//! are not attributes here: renderers keep those names in side tables.

use std::any::Any;
use std::fmt;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::accessor_names::{
    self, AccessorEntry, AccessorNames, AccessorNamesTypeAttributeKind,
    UnionIdentifierTypeAttributeKind, UnionMemberNamesTypeAttributeKind,
};
use crate::attributes::constraints::{
    self, MinMaxConstraint, MinMaxItemsTypeAttributeKind, MinMaxLengthTypeAttributeKind,
    MinMaxTypeAttributeKind, PatternTypeAttributeKind,
};
use crate::attributes::default_value::{self, DefaultValue, DefaultValueTypeAttributeKind};
use crate::attributes::description::{
    self, DescriptionTypeAttributeKind, PropertyDescriptionsTypeAttributeKind,
};
use crate::attributes::enum_values::EnumValuesTypeAttributeKind;
use crate::attributes::string_types::{StringTypes, StringTypesTypeAttributeKind};
use crate::attributes::type_names::{self, NamesTypeAttributeKind, TypeNames};
use crate::attributes::uri_attributes::{self, UriAttributes, UriTypeAttributeKind};
use crate::messages::Result;
use crate::support::collection_utils::{HASH_CODE_INIT, JsEquals, JsHash, add_hash_code};
use crate::support::support::panic;
use crate::ty::provenance_type_attribute_kind::{self, ProvenanceTypeAttributeKind};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_ref::TypeRef;

/// The kinds of type attributes (`TypeAttributeKind` instances in
/// TypeScript), identified by their `name`.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum TypeAttributeKind {
    /// `names` (`TypeNames.ts`).
    Names,
    /// `description` (`Description.ts`).
    Description,
    /// `propertyDescriptions` (`Description.ts`).
    PropertyDescriptions,
    /// `accessorNames` (`AccessorNames.ts`).
    AccessorNames,
    /// `enumValues` (`EnumValues.ts`).
    EnumValues,
    /// `unionIdentifier` (`AccessorNames.ts`).
    UnionIdentifier,
    /// `unionMemberNames` (`AccessorNames.ts`).
    UnionMemberNames,
    /// `minMax` (`Constraints.ts`).
    MinMax,
    /// `minMaxLength` (`Constraints.ts`).
    MinMaxLength,
    /// `minMaxItems` (`Constraints.ts`).
    MinMaxItems,
    /// `pattern` (`Constraints.ts`).
    Pattern,
    /// `defaultValue` (`DefaultValue.ts`).
    DefaultValue,
    /// `stringTypes` (`StringTypes.ts`).
    StringTypes,
    /// `uriAttributes` (`URIAttributes.ts`).
    UriAttributes,
    /// `provenance` (`ProvenanceTypeAttributeKind.ts`).
    Provenance,
    /// `transformation` (`Transformers.ts`).
    Transformation,
}

impl TypeAttributeKind {
    /// The kind's `name`.
    pub fn name(self) -> &'static str {
        match self {
            TypeAttributeKind::Names => "names",
            TypeAttributeKind::Description => "description",
            TypeAttributeKind::PropertyDescriptions => "propertyDescriptions",
            TypeAttributeKind::AccessorNames => "accessorNames",
            TypeAttributeKind::EnumValues => "enumValues",
            TypeAttributeKind::UnionIdentifier => "unionIdentifier",
            TypeAttributeKind::UnionMemberNames => "unionMemberNames",
            TypeAttributeKind::MinMax => "minMax",
            TypeAttributeKind::MinMaxLength => "minMaxLength",
            TypeAttributeKind::MinMaxItems => "minMaxItems",
            TypeAttributeKind::Pattern => "pattern",
            TypeAttributeKind::DefaultValue => "defaultValue",
            TypeAttributeKind::StringTypes => "stringTypes",
            TypeAttributeKind::UriAttributes => "uriAttributes",
            TypeAttributeKind::Provenance => "provenance",
            TypeAttributeKind::Transformation => "transformation",
        }
    }

    /// `appliesToTypeKind(kind)`: attributes of other kinds are dropped from
    /// types of that kind. Every kind except provenance and transformation
    /// is dropped from `any`.
    pub fn applies_to_type_kind(self, kind: TypeKind) -> bool {
        match self {
            TypeAttributeKind::Provenance | TypeAttributeKind::Transformation => true,
            _ => kind != TypeKind::Any,
        }
    }

    /// `inIdentity`: whether the attribute is part of a type's identity.
    pub fn in_identity(self) -> bool {
        matches!(
            self,
            TypeAttributeKind::MinMax
                | TypeAttributeKind::MinMaxLength
                | TypeAttributeKind::MinMaxItems
                | TypeAttributeKind::Pattern
                | TypeAttributeKind::DefaultValue
                | TypeAttributeKind::StringTypes
                | TypeAttributeKind::UriAttributes
                | TypeAttributeKind::Transformation
        )
    }
}

/// `TypeAttributeKind.hashCode()` = `hashString(name)`.
impl JsHash for TypeAttributeKind {
    fn hash_code(&self) -> i64 {
        self.name().hash_code()
    }
}

/// The value of a `transformation` attribute (a `Transformation` from
/// `Transformers.ts`). The transformers work package implements it; the type
/// graph only needs these operations.
pub trait TransformationAttribute: fmt::Debug {
    /// `Transformation.hashCode()`.
    fn hash_code(&self) -> i64;
    /// `Transformation.equals(other)`.
    fn js_equals(&self, other: &dyn TransformationAttribute) -> bool;
    /// `Transformation.getChildren()`, as refs in the same graph.
    fn children(&self) -> IndexSet<TypeRef>;
    /// `Transformation.reconstitute(builder)`: the same transformation in
    /// the graph `builder` is building.
    fn reconstitute(
        &self,
        builder: &mut TypeBuilder<'_>,
    ) -> Result<Rc<dyn TransformationAttribute>>;
    /// For downcasting to the concrete transformation type.
    fn as_any(&self) -> &dyn Any;
}

/// A type attribute value. The variant determines its
/// [`TypeAttributeKind`].
#[derive(Clone, Debug)]
pub enum TypeAttributeValue {
    /// `names`.
    Names(Rc<TypeNames>),
    /// `description`.
    Description(Rc<IndexSet<String>>),
    /// `propertyDescriptions`.
    PropertyDescriptions(Rc<IndexMap<String, IndexSet<String>>>),
    /// `accessorNames`.
    AccessorNames(Rc<AccessorNames>),
    /// `enumValues`.
    EnumValues(Rc<AccessorNames>),
    /// `unionIdentifier`.
    UnionIdentifier(Rc<IndexSet<u32>>),
    /// `unionMemberNames`.
    UnionMemberNames(Rc<IndexMap<u32, AccessorEntry>>),
    /// `minMax`.
    MinMax(MinMaxConstraint),
    /// `minMaxLength`.
    MinMaxLength(MinMaxConstraint),
    /// `minMaxItems`.
    MinMaxItems(MinMaxConstraint),
    /// `pattern`.
    Pattern(Rc<String>),
    /// `defaultValue`.
    DefaultValue(DefaultValue),
    /// `stringTypes`.
    StringTypes(Rc<StringTypes>),
    /// `uriAttributes`.
    UriAttributes(Rc<UriAttributes>),
    /// `provenance`.
    Provenance(Rc<IndexSet<u32>>),
    /// `transformation`.
    Transformation(Rc<dyn TransformationAttribute>),
}

impl TypeAttributeValue {
    /// The kind of this value.
    pub fn kind(&self) -> TypeAttributeKind {
        match self {
            TypeAttributeValue::Names(_) => TypeAttributeKind::Names,
            TypeAttributeValue::Description(_) => TypeAttributeKind::Description,
            TypeAttributeValue::PropertyDescriptions(_) => TypeAttributeKind::PropertyDescriptions,
            TypeAttributeValue::AccessorNames(_) => TypeAttributeKind::AccessorNames,
            TypeAttributeValue::EnumValues(_) => TypeAttributeKind::EnumValues,
            TypeAttributeValue::UnionIdentifier(_) => TypeAttributeKind::UnionIdentifier,
            TypeAttributeValue::UnionMemberNames(_) => TypeAttributeKind::UnionMemberNames,
            TypeAttributeValue::MinMax(_) => TypeAttributeKind::MinMax,
            TypeAttributeValue::MinMaxLength(_) => TypeAttributeKind::MinMaxLength,
            TypeAttributeValue::MinMaxItems(_) => TypeAttributeKind::MinMaxItems,
            TypeAttributeValue::Pattern(_) => TypeAttributeKind::Pattern,
            TypeAttributeValue::DefaultValue(_) => TypeAttributeKind::DefaultValue,
            TypeAttributeValue::StringTypes(_) => TypeAttributeKind::StringTypes,
            TypeAttributeValue::UriAttributes(_) => TypeAttributeKind::UriAttributes,
            TypeAttributeValue::Provenance(_) => TypeAttributeKind::Provenance,
            TypeAttributeValue::Transformation(_) => TypeAttributeKind::Transformation,
        }
    }

    /// `kind.stringify(value)`, used by the graph printer.
    pub fn stringify(&self) -> Result<Option<String>> {
        Ok(match self {
            TypeAttributeValue::Names(tn) => Some(tn.to_string()?),
            TypeAttributeValue::Description(d) => description::stringify_description(d),
            TypeAttributeValue::PropertyDescriptions(p) => {
                description::stringify_property_descriptions(p)
            }
            TypeAttributeValue::MinMax(c)
            | TypeAttributeValue::MinMaxLength(c)
            | TypeAttributeValue::MinMaxItems(c) => Some(constraints::stringify_min_max(c)),
            TypeAttributeValue::DefaultValue(v) => Some(default_value::stringify(v)),
            TypeAttributeValue::StringTypes(st) => Some(st.to_string()),
            TypeAttributeValue::Provenance(p) => Some(provenance_type_attribute_kind::stringify(p)),
            TypeAttributeValue::Transformation(_) => Some("transformation".to_owned()),
            TypeAttributeValue::AccessorNames(_)
            | TypeAttributeValue::EnumValues(_)
            | TypeAttributeValue::UnionIdentifier(_)
            | TypeAttributeValue::UnionMemberNames(_)
            | TypeAttributeValue::Pattern(_)
            | TypeAttributeValue::UriAttributes(_) => None,
        })
    }

    /// `kind.requiresUniqueIdentity(value)`: a type with such an attribute is
    /// never deduplicated.
    pub fn requires_unique_identity(&self) -> bool {
        match self {
            TypeAttributeValue::StringTypes(st) => {
                StringTypesTypeAttributeKind::requires_unique_identity(st)
            }
            _ => false,
        }
    }

    /// `kind.children(value)`: the types an attribute refers to.
    pub fn children(&self) -> IndexSet<TypeRef> {
        match self {
            TypeAttributeValue::Transformation(xf) => xf.children(),
            _ => IndexSet::new(),
        }
    }

    /// `kind.reconstitute(builder, value)`.
    pub fn reconstitute(&self, builder: &mut TypeBuilder<'_>) -> Result<TypeAttributeValue> {
        match self {
            TypeAttributeValue::Transformation(xf) => Ok(TypeAttributeValue::Transformation(
                xf.reconstitute(builder)?,
            )),
            other => Ok(other.clone()),
        }
    }
}

impl JsHash for TypeAttributeValue {
    /// `hashCodeOf(value)`. Only identity attributes are ever hashed;
    /// `names` (which `hashCodeOf` cannot hash) gets `hashCodeInit`.
    fn hash_code(&self) -> i64 {
        match self {
            TypeAttributeValue::Names(_) => HASH_CODE_INIT,
            TypeAttributeValue::Description(d) => d.hash_code(),
            TypeAttributeValue::PropertyDescriptions(p) => p.hash_code(),
            TypeAttributeValue::AccessorNames(a) | TypeAttributeValue::EnumValues(a) => {
                a.hash_code()
            }
            TypeAttributeValue::UnionIdentifier(s) | TypeAttributeValue::Provenance(s) => {
                s.hash_code()
            }
            TypeAttributeValue::UnionMemberNames(m) => m.hash_code(),
            TypeAttributeValue::MinMax(c)
            | TypeAttributeValue::MinMaxLength(c)
            | TypeAttributeValue::MinMaxItems(c) => c.hash_code(),
            TypeAttributeValue::Pattern(p) => p.hash_code(),
            TypeAttributeValue::DefaultValue(v) => v.hash_code(),
            TypeAttributeValue::StringTypes(st) => st.hash_code(),
            TypeAttributeValue::UriAttributes(u) => u.hash_code(),
            TypeAttributeValue::Transformation(xf) => xf.hash_code(),
        }
    }
}

impl JsEquals for TypeAttributeValue {
    /// `areEqual(a, b)` for two values of the same kind.
    fn js_equals(&self, other: &Self) -> bool {
        use TypeAttributeValue as V;
        match (self, other) {
            (V::Names(a), V::Names(b)) => Rc::ptr_eq(a, b),
            (V::Description(a), V::Description(b)) => Rc::ptr_eq(a, b) || a.js_equals(b),
            (V::PropertyDescriptions(a), V::PropertyDescriptions(b)) => {
                Rc::ptr_eq(a, b) || a.js_equals(b)
            }
            (V::AccessorNames(a), V::AccessorNames(b)) | (V::EnumValues(a), V::EnumValues(b)) => {
                Rc::ptr_eq(a, b) || a.js_equals(b)
            }
            (V::UnionIdentifier(a), V::UnionIdentifier(b))
            | (V::Provenance(a), V::Provenance(b)) => Rc::ptr_eq(a, b) || a.js_equals(b),
            (V::UnionMemberNames(a), V::UnionMemberNames(b)) => Rc::ptr_eq(a, b) || a.js_equals(b),
            (V::MinMax(a), V::MinMax(b))
            | (V::MinMaxLength(a), V::MinMaxLength(b))
            | (V::MinMaxItems(a), V::MinMaxItems(b)) => a.js_equals(b),
            (V::Pattern(a), V::Pattern(b)) => a == b,
            (V::DefaultValue(a), V::DefaultValue(b)) => a.js_equals(b),
            (V::StringTypes(a), V::StringTypes(b)) => Rc::ptr_eq(a, b) || a.js_equals(b),
            (V::UriAttributes(a), V::UriAttributes(b)) => Rc::ptr_eq(a, b) || a.js_equals(b),
            (V::Transformation(a), V::Transformation(b)) => {
                Rc::ptr_eq(a, b) || a.js_equals(b.as_ref())
            }
            _ => false,
        }
    }
}

/// `TypeAttributes`: a type's attributes, a map from kind to value in
/// JavaScript `Map` insertion order.
#[derive(Clone, Debug, Default)]
pub struct TypeAttributes(Vec<TypeAttributeValue>);

/// `emptyTypeAttributes`.
pub fn empty_type_attributes() -> TypeAttributes {
    TypeAttributes::default()
}

impl TypeAttributes {
    /// No attributes.
    pub fn new() -> Self {
        Self::default()
    }

    /// The number of attributes (`size`).
    pub fn len(&self) -> usize {
        self.0.len()
    }

    /// Whether there are no attributes.
    pub fn is_empty(&self) -> bool {
        self.0.is_empty()
    }

    /// The values, in map order.
    pub fn iter(&self) -> impl Iterator<Item = &TypeAttributeValue> {
        self.0.iter()
    }

    /// The kinds, in map order.
    pub fn kinds(&self) -> impl Iterator<Item = TypeAttributeKind> + '_ {
        self.0.iter().map(TypeAttributeValue::kind)
    }

    /// The value of kind `kind`, if present (`get`).
    pub fn get(&self, kind: TypeAttributeKind) -> Option<&TypeAttributeValue> {
        self.0.iter().find(|v| v.kind() == kind)
    }

    /// Whether a value of kind `kind` is present (`has`).
    pub fn contains(&self, kind: TypeAttributeKind) -> bool {
        self.get(kind).is_some()
    }

    /// `Map.prototype.set`: replaces the value of the same kind in its slot,
    /// or appends.
    pub fn insert(&mut self, value: TypeAttributeValue) {
        let kind = value.kind();
        match self.0.iter_mut().find(|v| v.kind() == kind) {
            Some(slot) => *slot = value,
            None => self.0.push(value),
        }
    }

    /// `new Map(a).set(k, v)`.
    pub fn with(&self, value: TypeAttributeValue) -> TypeAttributes {
        let mut result = self.clone();
        result.insert(value);
        result
    }

    /// `Map.prototype.delete`: removes the kind, keeping the others' order.
    pub fn remove(&mut self, kind: TypeAttributeKind) -> Option<TypeAttributeValue> {
        let position = self.0.iter().position(|v| v.kind() == kind)?;
        Some(self.0.remove(position))
    }

    /// `mapFilter(a, p)`.
    pub fn filter(&self, mut predicate: impl FnMut(&TypeAttributeValue) -> bool) -> TypeAttributes {
        TypeAttributes(self.0.iter().filter(|v| predicate(v)).cloned().collect())
    }

    /// The attributes that are part of the identity (`inIdentity`).
    pub fn identity_attributes(&self) -> TypeAttributes {
        self.filter(|v| v.kind().in_identity())
    }

    /// The attributes that are not part of the identity.
    pub fn non_identity_attributes(&self) -> TypeAttributes {
        self.filter(|v| !v.kind().in_identity())
    }

    /// Whether any attribute `requiresUniqueIdentity`.
    pub fn has_unique_identity_attributes(&self) -> bool {
        self.0
            .iter()
            .any(TypeAttributeValue::requires_unique_identity)
    }
}

impl FromIterator<TypeAttributeValue> for TypeAttributes {
    fn from_iter<I: IntoIterator<Item = TypeAttributeValue>>(iter: I) -> Self {
        let mut result = TypeAttributes::new();
        for v in iter {
            result.insert(v);
        }
        result
    }
}

impl JsHash for TypeAttributes {
    /// `hashCodeOf(map)`: `addHashCode(17 + Σ hashString(kind.name), 17 + Σ
    /// hashCodeOf(value))`.
    fn hash_code(&self) -> i64 {
        let mut g = HASH_CODE_INIT;
        let mut h = HASH_CODE_INIT;
        for v in &self.0 {
            g += v.kind().hash_code();
            h += v.hash_code();
        }
        add_hash_code(g, h)
    }
}

impl JsEquals for TypeAttributes {
    /// `areEqual(a, b)`: same size and equal values per kind, in any order.
    fn js_equals(&self, other: &Self) -> bool {
        self.len() == other.len()
            && self
                .0
                .iter()
                .all(|v| other.get(v.kind()).is_some_and(|w| v.js_equals(w)))
    }
}

/// A typed handle for one attribute kind, with the accessors of TypeScript's
/// `TypeAttributeKind<T>`.
pub trait AttributeKind: Copy {
    /// The attribute's value type.
    type Value: Clone;
    /// The kind this handle stands for.
    const KIND: TypeAttributeKind;
    /// Extracts this kind's value from a [`TypeAttributeValue`].
    fn value_of(value: &TypeAttributeValue) -> Option<&Self::Value>;
    /// Wraps a value of this kind.
    fn wrap(value: Self::Value) -> TypeAttributeValue;

    /// Wraps `value` as a [`TypeAttributeValue`] of this kind.
    fn wrap_value(self, value: Self::Value) -> TypeAttributeValue {
        Self::wrap(value)
    }

    /// `makeAttributes(value)`: attributes with just this value.
    fn make_attributes(self, value: Self::Value) -> TypeAttributes {
        TypeAttributes(vec![Self::wrap(value)])
    }

    /// `tryGetInAttributes(a)`.
    fn try_get_in_attributes(self, a: &TypeAttributes) -> Option<&Self::Value> {
        a.get(Self::KIND).and_then(Self::value_of)
    }

    /// `modifyInAttributes(a, modify)`: sets the value `modify` returns, or
    /// removes the kind if it returns `None`.
    fn modify_in_attributes(
        self,
        a: &TypeAttributes,
        modify: impl FnOnce(Option<&Self::Value>) -> Option<Self::Value>,
    ) -> TypeAttributes {
        match modify(self.try_get_in_attributes(a)) {
            None => {
                let mut result = a.clone();
                result.remove(Self::KIND);
                result
            }
            Some(v) => a.with(Self::wrap(v)),
        }
    }

    /// `setDefaultInAttributes(a, makeDefault)`.
    fn set_default_in_attributes(
        self,
        a: &TypeAttributes,
        make_default: impl FnOnce() -> Self::Value,
    ) -> TypeAttributes {
        if self.try_get_in_attributes(a).is_some() {
            return a.clone();
        }
        self.modify_in_attributes(a, |_| Some(make_default()))
    }

    /// `removeInAttributes(a)`.
    fn remove_in_attributes(self, a: &TypeAttributes) -> TypeAttributes {
        a.filter(|v| v.kind() != Self::KIND)
    }
}

macro_rules! rc_attribute_kind {
    ($handle:ty, $variant:ident, $value:ty) => {
        impl AttributeKind for $handle {
            type Value = $value;
            const KIND: TypeAttributeKind = TypeAttributeKind::$variant;
            fn value_of(value: &TypeAttributeValue) -> Option<&Self::Value> {
                match value {
                    TypeAttributeValue::$variant(v) => Some(v),
                    _ => None,
                }
            }
            fn wrap(value: Self::Value) -> TypeAttributeValue {
                TypeAttributeValue::$variant(Rc::new(value))
            }
        }
    };
}

macro_rules! plain_attribute_kind {
    ($handle:ty, $variant:ident, $value:ty) => {
        impl AttributeKind for $handle {
            type Value = $value;
            const KIND: TypeAttributeKind = TypeAttributeKind::$variant;
            fn value_of(value: &TypeAttributeValue) -> Option<&Self::Value> {
                match value {
                    TypeAttributeValue::$variant(v) => Some(v),
                    _ => None,
                }
            }
            fn wrap(value: Self::Value) -> TypeAttributeValue {
                TypeAttributeValue::$variant(value)
            }
        }
    };
}

rc_attribute_kind!(NamesTypeAttributeKind, Names, TypeNames);
rc_attribute_kind!(DescriptionTypeAttributeKind, Description, IndexSet<String>);
rc_attribute_kind!(
    PropertyDescriptionsTypeAttributeKind,
    PropertyDescriptions,
    IndexMap<String, IndexSet<String>>
);
rc_attribute_kind!(AccessorNamesTypeAttributeKind, AccessorNames, AccessorNames);
rc_attribute_kind!(EnumValuesTypeAttributeKind, EnumValues, AccessorNames);
rc_attribute_kind!(
    UnionIdentifierTypeAttributeKind,
    UnionIdentifier,
    IndexSet<u32>
);
rc_attribute_kind!(UnionMemberNamesTypeAttributeKind, UnionMemberNames, IndexMap<u32, AccessorEntry>);
plain_attribute_kind!(MinMaxTypeAttributeKind, MinMax, MinMaxConstraint);
plain_attribute_kind!(
    MinMaxLengthTypeAttributeKind,
    MinMaxLength,
    MinMaxConstraint
);
plain_attribute_kind!(MinMaxItemsTypeAttributeKind, MinMaxItems, MinMaxConstraint);
rc_attribute_kind!(PatternTypeAttributeKind, Pattern, String);
plain_attribute_kind!(DefaultValueTypeAttributeKind, DefaultValue, DefaultValue);
rc_attribute_kind!(StringTypesTypeAttributeKind, StringTypes, StringTypes);
rc_attribute_kind!(UriTypeAttributeKind, UriAttributes, UriAttributes);
rc_attribute_kind!(ProvenanceTypeAttributeKind, Provenance, IndexSet<u32>);

/// `transformationTypeAttributeKind` (defined in `Transformers.ts`).
#[derive(Clone, Copy, Debug, Default)]
pub struct TransformationTypeAttributeKind;

plain_attribute_kind!(
    TransformationTypeAttributeKind,
    Transformation,
    Rc<dyn TransformationAttribute>
);

/// `CombinationKind`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum CombinationKind {
    /// `"union"`: `kind.combine`.
    Union,
    /// `"intersect"`: `kind.intersect`.
    Intersect,
}

fn values_of<K: AttributeKind>(values: &[&TypeAttributeValue]) -> Vec<K::Value> {
    values
        .iter()
        .filter_map(|v| K::value_of(v))
        .cloned()
        .collect()
}

fn refs_of<'a, K: AttributeKind>(values: &[&'a TypeAttributeValue]) -> Vec<&'a K::Value> {
    values.iter().filter_map(|v| K::value_of(v)).collect()
}

/// `kind.combine(values)` or `kind.intersect(values)` for two or more values
/// of one kind. `None` drops the attribute.
fn combine_values(
    kind: TypeAttributeKind,
    combination: CombinationKind,
    values: &[&TypeAttributeValue],
) -> Result<Option<TypeAttributeValue>> {
    use TypeAttributeKind as K;
    use TypeAttributeValue as V;
    let union = combination == CombinationKind::Union;
    Ok(match kind {
        K::Names => Some(V::Names(Rc::new(type_names::combine(&refs_of::<
            NamesTypeAttributeKind,
        >(values))))),
        K::Description => Some(V::Description(Rc::new(description::combine_descriptions(
            &refs_of::<DescriptionTypeAttributeKind>(values),
        )))),
        K::PropertyDescriptions => Some(V::PropertyDescriptions(Rc::new(
            description::combine_property_descriptions(&refs_of::<
                PropertyDescriptionsTypeAttributeKind,
            >(values)),
        ))),
        K::AccessorNames | K::EnumValues | K::Transformation => {
            return panic(format!("Cannot combine type attribute {}", kind.name()));
        }
        K::UnionIdentifier => Some(V::UnionIdentifier(Rc::new(
            accessor_names::combine_union_identifiers(
                &refs_of::<UnionIdentifierTypeAttributeKind>(values),
            ),
        ))),
        K::UnionMemberNames => Some(V::UnionMemberNames(Rc::new(
            accessor_names::combine_union_member_names(
                &refs_of::<UnionMemberNamesTypeAttributeKind>(values),
            ),
        ))),
        K::MinMax | K::MinMaxLength | K::MinMaxItems => {
            let constraints: Vec<MinMaxConstraint> = values
                .iter()
                .filter_map(|v| match v {
                    V::MinMax(c) | V::MinMaxLength(c) | V::MinMaxItems(c) => Some(*c),
                    _ => None,
                })
                .collect();
            let combined = if union {
                constraints::combine_min_max(&constraints)?
            } else {
                constraints::intersect_min_max(&constraints)?
            };
            combined.map(|c| match kind {
                K::MinMax => V::MinMax(c),
                K::MinMaxLength => V::MinMaxLength(c),
                _ => V::MinMaxItems(c),
            })
        }
        K::Pattern => {
            if union {
                Some(V::Pattern(Rc::new(constraints::combine_patterns(
                    &refs_of::<PatternTypeAttributeKind>(values),
                ))))
            } else {
                None
            }
        }
        K::DefaultValue => {
            default_value::combine(&values_of::<DefaultValueTypeAttributeKind>(values))
                .map(V::DefaultValue)
        }
        K::StringTypes => {
            let arr = refs_of::<StringTypesTypeAttributeKind>(values);
            let (first, rest) = match arr.split_first() {
                Some(split) => split,
                None => return panic("Assertion failed"),
            };
            let combined = if union {
                first.union(rest)
            } else {
                first.intersect(rest)
            };
            Some(V::StringTypes(Rc::new(combined)))
        }
        K::UriAttributes => Some(V::UriAttributes(Rc::new(uri_attributes::combine(
            &refs_of::<UriTypeAttributeKind>(values),
        )))),
        K::Provenance => Some(V::Provenance(Rc::new(
            provenance_type_attribute_kind::combine(&refs_of::<ProvenanceTypeAttributeKind>(
                values,
            )),
        ))),
    })
}

/// `kind.makeInferred(value)`. `None` drops the attribute.
fn make_value_inferred(value: &TypeAttributeValue) -> Result<Option<TypeAttributeValue>> {
    use TypeAttributeValue as V;
    Ok(match value {
        V::Names(tn) => Some(V::Names(Rc::new(tn.make_inferred()))),
        V::UnionIdentifier(_) => Some(V::UnionIdentifier(Rc::new(IndexSet::new()))),
        V::Provenance(p) => Some(V::Provenance(Rc::clone(p))),
        V::UnionMemberNames(_) | V::Transformation(_) => {
            return panic(format!(
                "Cannot make type attribute {} inferred",
                value.kind().name()
            ));
        }
        V::Description(_)
        | V::PropertyDescriptions(_)
        | V::AccessorNames(_)
        | V::EnumValues(_)
        | V::MinMax(_)
        | V::MinMaxLength(_)
        | V::MinMaxItems(_)
        | V::Pattern(_)
        | V::DefaultValue(_)
        | V::StringTypes(_)
        | V::UriAttributes(_) => None,
    })
}

/// `combineTypeAttributes(kind, attributeArray)`: combines the attributes of
/// several types. Kinds appear in first-seen order; a kind with a single
/// value keeps it as is, otherwise `combine`/`intersect` merges the values
/// (in array order) and may drop the kind.
pub fn combine_type_attributes(
    combination: CombinationKind,
    attribute_array: &[&TypeAttributes],
) -> Result<TypeAttributes> {
    // mapTranspose
    let mut by_kind: Vec<(TypeAttributeKind, Vec<&TypeAttributeValue>)> = Vec::new();
    for attributes in attribute_array {
        for value in attributes.iter() {
            let kind = value.kind();
            match by_kind.iter_mut().find(|(k, _)| *k == kind) {
                Some((_, values)) => values.push(value),
                None => by_kind.push((kind, vec![value])),
            }
        }
    }

    let mut result = TypeAttributes::new();
    for (kind, values) in by_kind {
        let combined = match values.as_slice() {
            [] => return panic("Cannot combine zero type attributes"),
            [single] => Some((*single).clone()),
            _ => combine_values(kind, combination, &values)?,
        };
        if let Some(value) = combined {
            result.0.push(value);
        }
    }
    Ok(result)
}

/// `combineTypeAttributes(kind, a, b)`.
pub fn combine_type_attributes2(
    combination: CombinationKind,
    a: &TypeAttributes,
    b: &TypeAttributes,
) -> Result<TypeAttributes> {
    combine_type_attributes(combination, &[a, b])
}

/// `makeTypeAttributesInferred(attr)`.
pub fn make_type_attributes_inferred(attr: &TypeAttributes) -> Result<TypeAttributes> {
    let mut result = TypeAttributes::new();
    for value in attr.iter() {
        if let Some(inferred) = make_value_inferred(value)? {
            result.0.push(inferred);
        }
    }
    Ok(result)
}

/// `increaseTypeAttributesDistance(attr)`: only names change (they become
/// inferred, one step farther away).
pub fn increase_type_attributes_distance(attr: &TypeAttributes) -> TypeAttributes {
    TypeAttributes(
        attr.iter()
            .map(|value| match value {
                TypeAttributeValue::Names(tn) => {
                    TypeAttributeValue::Names(Rc::new(tn.make_inferred()))
                }
                other => other.clone(),
            })
            .collect(),
    )
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::attributes::type_names::make_names_type_attributes;

    fn names(attrs: &TypeAttributes) -> String {
        NamesTypeAttributeKind
            .try_get_in_attributes(attrs)
            .unwrap()
            .to_string()
            .unwrap()
    }

    #[test]
    fn set_keeps_slot_and_delete_keeps_order() {
        let mut a = make_names_type_attributes("a", false);
        a.insert(DescriptionTypeAttributeKind.wrap_value(["d".to_owned()].into_iter().collect()));
        a.insert(ProvenanceTypeAttributeKind.wrap_value([1].into_iter().collect()));
        let b = a.with(TypeAttributeValue::Description(Rc::new(
            ["e".to_owned()].into_iter().collect(),
        )));
        assert_eq!(
            b.kinds().collect::<Vec<_>>(),
            vec![
                TypeAttributeKind::Names,
                TypeAttributeKind::Description,
                TypeAttributeKind::Provenance
            ]
        );
        let c = DescriptionTypeAttributeKind.remove_in_attributes(&b);
        assert_eq!(
            c.kinds().collect::<Vec<_>>(),
            vec![TypeAttributeKind::Names, TypeAttributeKind::Provenance]
        );
        let d = DescriptionTypeAttributeKind.modify_in_attributes(&b, |_| None);
        assert_eq!(d.len(), 2);
    }

    #[test]
    fn combine_transposes_in_first_seen_order() {
        let a = ProvenanceTypeAttributeKind.make_attributes([1].into_iter().collect());
        let b = make_names_type_attributes("x", false)
            .with(ProvenanceTypeAttributeKind.wrap_value([2].into_iter().collect()));
        let c = combine_type_attributes(CombinationKind::Union, &[&a, &b]).unwrap();
        assert_eq!(
            c.kinds().collect::<Vec<_>>(),
            vec![TypeAttributeKind::Provenance, TypeAttributeKind::Names]
        );
        let p = ProvenanceTypeAttributeKind
            .try_get_in_attributes(&c)
            .unwrap();
        assert_eq!(p.iter().copied().collect::<Vec<_>>(), vec![1, 2]);
        assert_eq!(names(&c), "given x ()");
    }

    #[test]
    fn panicking_kinds_return_errors() {
        let a = AccessorNamesTypeAttributeKind.make_attributes(AccessorNames::new());
        assert_eq!(
            combine_type_attributes(CombinationKind::Union, &[&a, &a])
                .unwrap_err()
                .user_message(),
            "Internal error: Cannot combine type attribute accessorNames"
        );
        // A single value is used as is, without calling combine.
        assert!(combine_type_attributes(CombinationKind::Union, &[&a]).is_ok());
        let m = UnionMemberNamesTypeAttributeKind.make_attributes(IndexMap::new());
        assert_eq!(
            make_type_attributes_inferred(&m)
                .unwrap_err()
                .user_message(),
            "Internal error: Cannot make type attribute unionMemberNames inferred"
        );
    }

    #[test]
    fn make_inferred_drops_or_transforms() {
        let a = make_names_type_attributes("a", false)
            .with(DescriptionTypeAttributeKind.wrap_value(IndexSet::new()))
            .with(UnionIdentifierTypeAttributeKind.wrap_value([3].into_iter().collect()));
        let inferred = make_type_attributes_inferred(&a).unwrap();
        assert_eq!(
            inferred.kinds().collect::<Vec<_>>(),
            vec![TypeAttributeKind::Names, TypeAttributeKind::UnionIdentifier]
        );
        assert_eq!(names(&inferred), "distance 1 a ()");
        assert!(
            UnionIdentifierTypeAttributeKind
                .try_get_in_attributes(&inferred)
                .unwrap()
                .is_empty()
        );
        let farther = increase_type_attributes_distance(&a);
        assert_eq!(farther.len(), 3);
        assert_eq!(names(&farther), "distance 1 a ()");
    }

    #[test]
    fn applies_to_and_identity() {
        assert!(!TypeAttributeKind::Names.applies_to_type_kind(TypeKind::Any));
        assert!(TypeAttributeKind::Provenance.applies_to_type_kind(TypeKind::Any));
        assert!(TypeAttributeKind::StringTypes.in_identity());
        assert!(!TypeAttributeKind::Names.in_identity());
    }
}
