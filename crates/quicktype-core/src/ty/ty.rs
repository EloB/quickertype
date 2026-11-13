//! Port of `packages/quicktype-core/src/Type/Type.ts`.
//!
//! The TypeScript class hierarchy (`PrimitiveType`, `ArrayType`,
//! `ObjectType`/`ClassType`/`MapType`, `EnumType`, `UnionType`,
//! `IntersectionType`) is one [`Type`] struct: a [`TypeKind`] plus
//! [`TypeData`] for the kind. Types live in a graph's arena and refer to each
//! other by [`TypeRef`]; whatever needs to look at other types (children,
//! nullability, structural compatibility, reconstitution) takes the graph.
//!
//! [`TypeIdentity`] is what the type builder deduplicates on. Its hash and
//! equality follow `collection-utils` exactly (see
//! [`collection_utils`](crate::support::collection_utils)), so the same
//! duplicates are found as in TypeScript.

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::TypeAttributes;
use crate::graph_rewriting::TypeReconstituter;
use crate::messages::{ErrorKind, MessageValue, Result, message_assert};
use crate::support::collection_utils::{
    HASH_CODE_INIT, JsEquals, JsHash, add_hash_code, compare_string_keys, map_sort_by_key,
};
use crate::support::support::{assert, assert_default, defined, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `ClassProperty`: a property's type and whether it is optional.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct ClassProperty {
    /// The property's type.
    pub type_ref: TypeRef,
    /// Whether the property may be missing.
    pub is_optional: bool,
}

impl ClassProperty {
    /// A property of type `type_ref`.
    pub fn new(type_ref: TypeRef, is_optional: bool) -> Self {
        ClassProperty {
            type_ref,
            is_optional,
        }
    }
}

impl JsHash for ClassProperty {
    /// `hashCodeOf(typeRef) + (isOptional ? 17 : 23)`, not truncated.
    fn hash_code(&self) -> i64 {
        self.type_ref.hash_code() + if self.is_optional { 17 } else { 23 }
    }
}

impl JsEquals for ClassProperty {
    fn js_equals(&self, other: &Self) -> bool {
        self == other
    }
}

/// The kind-specific data of a [`Type`].
#[derive(Clone, Debug, PartialEq)]
pub enum TypeData {
    /// A primitive type (`none`, `any`, `null`, `bool`, `integer`, `double`,
    /// `string` and the transformed string kinds).
    Primitive,
    /// `ArrayType`; the items are set once.
    Array {
        /// The item type, `None` until set.
        items: Option<TypeRef>,
    },
    /// `ObjectType` (`object`), `ClassType` (`class`) or `MapType` (`map`).
    Object {
        /// Fixed objects are never deduplicated by identity.
        is_fixed: bool,
        /// The properties, `None` until set. Always empty for maps.
        properties: Option<IndexMap<String, ClassProperty>>,
        /// The type of additional properties (the values of a map). Always
        /// `None` for classes.
        additional_properties: Option<TypeRef>,
    },
    /// `EnumType`.
    Enum {
        /// The cases, in order.
        cases: IndexSet<String>,
    },
    /// `UnionType` or `IntersectionType`; the members are set once.
    SetOperation {
        /// The members, `None` until set.
        members: Option<IndexSet<TypeRef>>,
    },
}

/// A type in a type graph.
#[derive(Clone, Debug, PartialEq)]
pub struct Type {
    type_ref: TypeRef,
    kind: TypeKind,
    data: TypeData,
}

impl Type {
    /// `new PrimitiveType(ref, kind)`.
    pub fn primitive(type_ref: TypeRef, kind: TypeKind) -> Type {
        Type {
            type_ref,
            kind,
            data: TypeData::Primitive,
        }
    }

    /// `new ArrayType(ref, items)`.
    pub fn array(type_ref: TypeRef, items: Option<TypeRef>) -> Type {
        Type {
            type_ref,
            kind: TypeKind::Array,
            data: TypeData::Array { items },
        }
    }

    /// `new ObjectType(ref, kind, isFixed, properties, additionalProperties)`.
    pub fn object(
        type_ref: TypeRef,
        kind: TypeKind,
        is_fixed: bool,
        properties: Option<IndexMap<String, ClassProperty>>,
        additional_properties: Option<TypeRef>,
    ) -> Result<Type> {
        match kind {
            TypeKind::Map => {
                if let Some(p) = &properties {
                    assert_default(p.is_empty())?;
                }
                assert_default(!is_fixed)?;
            }
            TypeKind::Class => assert_default(additional_properties.is_none())?,
            TypeKind::Object => assert_default(is_fixed)?,
            _ => return panic(format!("Invalid object type kind {kind}")),
        }
        Ok(Type {
            type_ref,
            kind,
            data: TypeData::Object {
                is_fixed,
                properties,
                additional_properties,
            },
        })
    }

    /// `new ClassType(ref, isFixed, properties)`.
    pub fn class(
        type_ref: TypeRef,
        is_fixed: bool,
        properties: Option<IndexMap<String, ClassProperty>>,
    ) -> Result<Type> {
        Type::object(type_ref, TypeKind::Class, is_fixed, properties, None)
    }

    /// `new MapType(ref, values)`: properties are empty once the values are
    /// known.
    pub fn map(type_ref: TypeRef, values: Option<TypeRef>) -> Result<Type> {
        Type::object(
            type_ref,
            TypeKind::Map,
            false,
            values.map(|_| IndexMap::new()),
            values,
        )
    }

    /// `new EnumType(ref, cases)`.
    pub fn enum_type(type_ref: TypeRef, cases: IndexSet<String>) -> Type {
        Type {
            type_ref,
            kind: TypeKind::Enum,
            data: TypeData::Enum { cases },
        }
    }

    /// `new UnionType(ref, members)`: errors with `IRNoEmptyUnions` for an
    /// empty member set.
    pub fn union(type_ref: TypeRef, members: Option<IndexSet<TypeRef>>) -> Result<Type> {
        if let Some(m) = &members {
            message_assert(
                !m.is_empty(),
                ErrorKind::IRNoEmptyUnions,
                Vec::<(&str, MessageValue)>::new(),
            )?;
        }
        Ok(Type {
            type_ref,
            kind: TypeKind::Union,
            data: TypeData::SetOperation { members },
        })
    }

    /// `new IntersectionType(ref, members)`.
    pub fn intersection(type_ref: TypeRef, members: Option<IndexSet<TypeRef>>) -> Type {
        Type {
            type_ref,
            kind: TypeKind::Intersection,
            data: TypeData::SetOperation { members },
        }
    }

    /// `typeRef`.
    pub fn type_ref(&self) -> TypeRef {
        self.type_ref
    }

    /// `index`: the type's index in its graph.
    pub fn index(&self) -> usize {
        self.type_ref.index()
    }

    /// `kind`.
    pub fn kind(&self) -> TypeKind {
        self.kind
    }

    /// The kind-specific data.
    pub fn data(&self) -> &TypeData {
        &self.data
    }

    /// `debugPrintKind`.
    pub fn debug_print_kind(&self) -> &'static str {
        self.kind.as_str()
    }

    /// `isPrimitive()`.
    pub fn is_primitive(&self) -> bool {
        matches!(self.data, TypeData::Primitive)
    }

    /// `instanceof ArrayType`.
    pub fn is_array(&self) -> bool {
        matches!(self.data, TypeData::Array { .. })
    }

    /// `instanceof ObjectType` (`object`, `class` or `map`).
    pub fn is_object_type(&self) -> bool {
        matches!(self.data, TypeData::Object { .. })
    }

    /// `instanceof ClassType`.
    pub fn is_class(&self) -> bool {
        self.kind == TypeKind::Class
    }

    /// `instanceof MapType`.
    pub fn is_map(&self) -> bool {
        self.kind == TypeKind::Map
    }

    /// `instanceof EnumType`.
    pub fn is_enum(&self) -> bool {
        self.kind == TypeKind::Enum
    }

    /// `instanceof UnionType`.
    pub fn is_union(&self) -> bool {
        self.kind == TypeKind::Union
    }

    /// `instanceof IntersectionType`.
    pub fn is_intersection(&self) -> bool {
        self.kind == TypeKind::Intersection
    }

    /// `instanceof SetOperationType`.
    pub fn is_set_operation(&self) -> bool {
        matches!(self.data, TypeData::SetOperation { .. })
    }

    /// `ArrayType.items` (as a ref).
    pub fn items(&self) -> Result<TypeRef> {
        match &self.data {
            TypeData::Array { items: Some(items) } => Ok(*items),
            TypeData::Array { items: None } => panic("Array items accessed before they were set"),
            _ => panic(format!("Type {} is not an array", self.kind)),
        }
    }

    /// `ObjectType.isFixed`.
    pub fn is_fixed(&self) -> bool {
        matches!(self.data, TypeData::Object { is_fixed: true, .. })
    }

    /// `ObjectType.getProperties()`.
    pub fn properties(&self) -> Result<&IndexMap<String, ClassProperty>> {
        match &self.data {
            TypeData::Object { properties, .. } => defined(properties.as_ref()),
            _ => panic(format!("Type {} is not an object type", self.kind)),
        }
    }

    /// `ObjectType.getSortedProperties()`: sorted by name (UTF-16 order).
    pub fn sorted_properties(&self) -> Result<IndexMap<String, ClassProperty>> {
        Ok(map_sort_by_key(self.properties()?))
    }

    /// `ObjectType.getAdditionalProperties()` (as a ref).
    pub fn additional_properties(&self) -> Result<Option<TypeRef>> {
        match &self.data {
            TypeData::Object {
                properties,
                additional_properties,
                ..
            } => {
                assert(properties.is_some(), "Properties are not set yet")?;
                Ok(*additional_properties)
            }
            _ => panic(format!("Type {} is not an object type", self.kind)),
        }
    }

    /// `MapType.values` (as a ref).
    pub fn map_values(&self) -> Result<TypeRef> {
        defined(self.additional_properties()?)
    }

    /// `EnumType.cases`.
    pub fn cases(&self) -> Result<&IndexSet<String>> {
        match &self.data {
            TypeData::Enum { cases } => Ok(cases),
            _ => panic(format!("Type {} is not an enum", self.kind)),
        }
    }

    /// `SetOperationType.getMemberRefs()`.
    pub fn members(&self) -> Result<&IndexSet<TypeRef>> {
        match &self.data {
            TypeData::SetOperation { members: Some(m) } => Ok(m),
            TypeData::SetOperation { members: None } => {
                panic("Map members accessed before they were set")
            }
            _ => panic(format!("Type {} is not a set operation", self.kind)),
        }
    }

    /// `ArrayType.setItems(items)`.
    pub(crate) fn set_items(&mut self, new_items: TypeRef) -> Result<()> {
        match &mut self.data {
            TypeData::Array { items } => {
                if items.is_some() {
                    return panic("Can only set array items once");
                }
                *items = Some(new_items);
                Ok(())
            }
            _ => panic("Tried to set items of non-array type"),
        }
    }

    /// `ObjectType.setProperties(properties, additionalProperties)`.
    pub(crate) fn set_properties(
        &mut self,
        new_properties: IndexMap<String, ClassProperty>,
        new_additional_properties: Option<TypeRef>,
    ) -> Result<()> {
        let kind = self.kind;
        match &mut self.data {
            TypeData::Object {
                properties,
                additional_properties,
                ..
            } => {
                assert(properties.is_none(), "Tried to set object properties twice")?;
                if kind == TypeKind::Map {
                    assert(
                        new_properties.is_empty(),
                        "Cannot set properties on map type",
                    )?;
                }
                if kind == TypeKind::Class {
                    assert(
                        new_additional_properties.is_none(),
                        "Cannot set additional properties of class type",
                    )?;
                }
                *properties = Some(new_properties);
                *additional_properties = new_additional_properties;
                Ok(())
            }
            _ => panic("Tried to set properties of non-object type"),
        }
    }

    /// `SetOperationType.setMembers(members)` (with `UnionType`'s
    /// `IRNoEmptyUnions` check).
    pub(crate) fn set_members(&mut self, new_members: IndexSet<TypeRef>) -> Result<()> {
        if self.kind == TypeKind::Union {
            message_assert(
                !new_members.is_empty(),
                ErrorKind::IRNoEmptyUnions,
                Vec::<(&str, MessageValue)>::new(),
            )?;
        }
        match &mut self.data {
            TypeData::SetOperation { members } => {
                if members.is_some() {
                    return panic("Can only set map members once");
                }
                *members = Some(new_members);
                Ok(())
            }
            _ => panic("Tried to set members of non-set-operation type"),
        }
    }

    /// `identity`: what the builder deduplicates this type on, or `None` if
    /// the type is unique. `attributes` are the type's attributes.
    pub fn identity(&self, attributes: &TypeAttributes) -> Result<Option<TypeIdentity>> {
        Ok(match &self.data {
            TypeData::Primitive => primitive_type_identity(self.kind, attributes),
            TypeData::Array { .. } => array_type_identity(attributes, self.items()?),
            TypeData::Object { is_fixed, .. } => {
                if *is_fixed {
                    None
                } else {
                    object_type_identify(
                        self.kind,
                        attributes,
                        self.properties()?.clone(),
                        self.additional_properties()?,
                    )
                }
            }
            TypeData::Enum { cases } => enum_type_identity(attributes, cases.clone()),
            TypeData::SetOperation { .. } => {
                set_operation_type_identity(self.kind, attributes, self.members()?.clone())
            }
        })
    }
}

/// The components of a [`TypeIdentity`], which differ by kind.
#[derive(Clone, Debug)]
enum IdentityComponents {
    Primitive(TypeAttributes),
    Array(TypeAttributes, TypeRef),
    Object(
        TypeAttributes,
        IndexMap<String, ClassProperty>,
        Option<TypeRef>,
    ),
    Enum(TypeAttributes, IndexSet<String>),
    SetOperation(TypeAttributes, IndexSet<TypeRef>),
}

/// `TypeIdentity`: a type's kind, identity attributes and structure, hashed
/// and compared like `collection-utils` does.
#[derive(Clone, Debug)]
pub struct TypeIdentity {
    kind: TypeKind,
    components: IdentityComponents,
    hash_code: i64,
}

impl TypeIdentity {
    fn new(kind: TypeKind, components: IdentityComponents) -> TypeIdentity {
        let mut h = add_hash_code(HASH_CODE_INIT, kind.hash_code());
        match &components {
            IdentityComponents::Primitive(a) => h = add_hash_code(h, a.hash_code()),
            IdentityComponents::Array(a, items) => {
                h = add_hash_code(h, a.hash_code());
                h = add_hash_code(h, items.hash_code());
            }
            IdentityComponents::Object(a, properties, additional) => {
                h = add_hash_code(h, a.hash_code());
                h = add_hash_code(h, properties.hash_code());
                h = add_hash_code(h, additional.hash_code());
            }
            IdentityComponents::Enum(a, cases) => {
                h = add_hash_code(h, a.hash_code());
                h = add_hash_code(h, cases.hash_code());
            }
            IdentityComponents::SetOperation(a, members) => {
                h = add_hash_code(h, a.hash_code());
                h = add_hash_code(h, members.hash_code());
            }
        }
        TypeIdentity {
            kind,
            components,
            hash_code: h,
        }
    }
}

impl JsHash for TypeIdentity {
    fn hash_code(&self) -> i64 {
        self.hash_code
    }
}

impl JsEquals for TypeIdentity {
    fn js_equals(&self, other: &Self) -> bool {
        use IdentityComponents as C;
        if self.kind != other.kind {
            return false;
        }
        match (&self.components, &other.components) {
            (C::Primitive(a), C::Primitive(b)) => a.js_equals(b),
            (C::Array(a, ia), C::Array(b, ib)) => a.js_equals(b) && ia == ib,
            (C::Object(a, pa, xa), C::Object(b, pb, xb)) => {
                a.js_equals(b) && pa.js_equals(pb) && xa == xb
            }
            (C::Enum(a, ca), C::Enum(b, cb)) => a.js_equals(b) && ca.js_equals(cb),
            (C::SetOperation(a, ma), C::SetOperation(b, mb)) => a.js_equals(b) && ma.js_equals(mb),
            _ => false,
        }
    }
}

/// `primitiveTypeIdentity(kind, attributes)`.
pub fn primitive_type_identity(
    kind: TypeKind,
    attributes: &TypeAttributes,
) -> Option<TypeIdentity> {
    if attributes.has_unique_identity_attributes() {
        return None;
    }
    Some(TypeIdentity::new(
        kind,
        IdentityComponents::Primitive(attributes.identity_attributes()),
    ))
}

/// `arrayTypeIdentity(attributes, itemsRef)`.
pub fn array_type_identity(attributes: &TypeAttributes, items: TypeRef) -> Option<TypeIdentity> {
    if attributes.has_unique_identity_attributes() {
        return None;
    }
    Some(TypeIdentity::new(
        TypeKind::Array,
        IdentityComponents::Array(attributes.identity_attributes(), items),
    ))
}

/// `objectTypeIdentify(kind, attributes, properties, additionalPropertiesRef)`.
fn object_type_identify(
    kind: TypeKind,
    attributes: &TypeAttributes,
    properties: IndexMap<String, ClassProperty>,
    additional_properties: Option<TypeRef>,
) -> Option<TypeIdentity> {
    if attributes.has_unique_identity_attributes() {
        return None;
    }
    Some(TypeIdentity::new(
        kind,
        IdentityComponents::Object(
            attributes.identity_attributes(),
            properties,
            additional_properties,
        ),
    ))
}

/// `classTypeIdentity(attributes, properties)`.
pub fn class_type_identity(
    attributes: &TypeAttributes,
    properties: IndexMap<String, ClassProperty>,
) -> Option<TypeIdentity> {
    object_type_identify(TypeKind::Class, attributes, properties, None)
}

/// `mapTypeIdentify(attributes, additionalPropertiesRef)`.
pub fn map_type_identify(
    attributes: &TypeAttributes,
    additional_properties: Option<TypeRef>,
) -> Option<TypeIdentity> {
    object_type_identify(
        TypeKind::Map,
        attributes,
        IndexMap::new(),
        additional_properties,
    )
}

/// `enumTypeIdentity(attributes, cases)`.
pub fn enum_type_identity(
    attributes: &TypeAttributes,
    cases: IndexSet<String>,
) -> Option<TypeIdentity> {
    if attributes.has_unique_identity_attributes() {
        return None;
    }
    Some(TypeIdentity::new(
        TypeKind::Enum,
        IdentityComponents::Enum(attributes.identity_attributes(), cases),
    ))
}

/// `setOperationTypeIdentity(kind, attributes, memberRefs)`.
pub fn set_operation_type_identity(
    kind: TypeKind,
    attributes: &TypeAttributes,
    members: IndexSet<TypeRef>,
) -> Option<TypeIdentity> {
    if attributes.has_unique_identity_attributes() {
        return None;
    }
    Some(TypeIdentity::new(
        kind,
        IdentityComponents::SetOperation(attributes.identity_attributes(), members),
    ))
}

/// `unionTypeIdentity(attributes, memberRefs)`.
pub fn union_type_identity(
    attributes: &TypeAttributes,
    members: IndexSet<TypeRef>,
) -> Option<TypeIdentity> {
    set_operation_type_identity(TypeKind::Union, attributes, members)
}

/// `intersectionTypeIdentity(attributes, memberRefs)`.
pub fn intersection_type_identity(
    attributes: &TypeAttributes,
    members: IndexSet<TypeRef>,
) -> Option<TypeIdentity> {
    set_operation_type_identity(TypeKind::Intersection, attributes, members)
}

/// `triviallyStructurallyCompatible(x, y)`: the same type, or either is
/// `none`.
pub fn trivially_structurally_compatible(graph: &TypeGraph, x: TypeRef, y: TypeRef) -> bool {
    if x.index() == y.index() {
        return true;
    }
    graph.kind(x) == TypeKind::None || graph.kind(y) == TypeKind::None
}

/// `setOperationCasesEqual(typesA, typesB, conflateNumbers, membersEqual)`:
/// same size, and every member of `a` has an equal member of the same kind
/// in `b` (or, conflating numbers, `b` has the other number kind).
pub fn set_operation_cases_equal(
    graph: &TypeGraph,
    types_a: &IndexSet<TypeRef>,
    types_b: &IndexSet<TypeRef>,
    conflate_numbers: bool,
    mut members_equal: impl FnMut(TypeRef, TypeRef) -> bool,
) -> bool {
    if types_a.len() != types_b.len() {
        return false;
    }
    types_a.iter().all(|&ta| {
        let kind_a = graph.kind(ta);
        let tb = types_b.iter().copied().find(|&t| graph.kind(t) == kind_a);
        if let Some(tb) = tb
            && members_equal(ta, tb)
        {
            return true;
        }
        if conflate_numbers {
            if kind_a == TypeKind::Integer
                && types_b.iter().any(|&t| graph.kind(t) == TypeKind::Double)
            {
                return true;
            }
            if kind_a == TypeKind::Double
                && types_b.iter().any(|&t| graph.kind(t) == TypeKind::Integer)
            {
                return true;
            }
        }
        false
    })
}

/// `structurallyCompatible(this, other, conflateNumbers)`: whether two types
/// have the same structure, treating cycles coinductively.
pub fn structurally_compatible(
    graph: &TypeGraph,
    this: TypeRef,
    other: TypeRef,
    conflate_numbers: bool,
) -> Result<bool> {
    let kinds_compatible = |kind1: TypeKind, kind2: TypeKind| -> bool {
        if kind1 == kind2 {
            return true;
        }
        if !conflate_numbers {
            return false;
        }
        match kind1 {
            TypeKind::Integer => kind2 == TypeKind::Double,
            TypeKind::Double => kind2 == TypeKind::Integer,
            _ => false,
        }
    };

    if trivially_structurally_compatible(graph, this, other) {
        return Ok(true);
    }
    if !kinds_compatible(graph.kind(this), graph.kind(other)) {
        return Ok(false);
    }

    let mut work_list: Vec<(TypeRef, TypeRef)> = vec![(this, other)];
    // The type pairs already determined to be equal; types can be cyclic.
    let mut done: Vec<(usize, usize)> = Vec::new();

    while let Some((mut a, mut b)) = work_list.pop() {
        if a.index() > b.index() {
            std::mem::swap(&mut a, &mut b);
        }

        if !graph.type_at(a).is_primitive() {
            let ai = a.index();
            let bi = b.index();
            if done.iter().any(|&(dai, dbi)| dai == ai && dbi == bi) {
                continue;
            }
            done.push((ai, bi));
        }

        let mut failed = false;
        let mut queue = |x: TypeRef, y: TypeRef, work_list: &mut Vec<(TypeRef, TypeRef)>| -> bool {
            if trivially_structurally_compatible(graph, x, y) {
                return true;
            }
            if !kinds_compatible(graph.kind(x), graph.kind(y)) {
                failed = true;
                return false;
            }
            work_list.push((x, y));
            true
        };

        let ta = graph.type_at(a);
        let tb = graph.type_at(b);
        let step_ok = match ta.data() {
            TypeData::Primitive => true,
            TypeData::Array { .. } => queue(ta.items()?, tb.items()?, &mut work_list),
            TypeData::Object { .. } => {
                let pa = ta.properties()?;
                let pb = tb.properties()?;
                if pa.len() != pb.len() {
                    false
                } else {
                    let mut ok = true;
                    for (name, cpa) in pa {
                        let matched = match pb.get(name) {
                            None => false,
                            Some(cpb) => {
                                cpa.is_optional == cpb.is_optional
                                    && queue(cpa.type_ref, cpb.type_ref, &mut work_list)
                            }
                        };
                        if !matched {
                            ok = false;
                            break;
                        }
                    }
                    if !ok {
                        false
                    } else {
                        let this_additional = ta.additional_properties()?;
                        let other_additional = tb.additional_properties()?;
                        match (this_additional, other_additional) {
                            (None, None) => true,
                            (Some(x), Some(y)) => queue(x, y, &mut work_list),
                            _ => false,
                        }
                    }
                }
            }
            TypeData::Enum { cases } => cases.js_equals(tb.cases()?),
            TypeData::SetOperation { .. } => {
                let ma = ta.members()?.clone();
                let mb = tb.members()?.clone();
                set_operation_cases_equal(graph, &ma, &mb, conflate_numbers, |x, y| {
                    queue(x, y, &mut work_list)
                })
            }
        };
        if !step_ok {
            return Ok(false);
        }
        if failed {
            return Ok(false);
        }
    }

    Ok(true)
}

/// `Type.reconstitute(builder, canonicalOrder)`: rebuilds `t` (a type of the
/// graph being rewritten) through `r`, looking up or reconstituting its
/// children. The order of lookups and reconstitutions decides the new
/// graph's type order and must not change.
pub(crate) fn reconstitute(
    original: &TypeGraph,
    t: &Type,
    r: &mut TypeReconstituter<'_, '_>,
    canonical_order: bool,
) -> Result<()> {
    match t.data() {
        TypeData::Primitive => r.get_primitive_type(t.kind()),
        TypeData::Array { .. } => {
            let items = t.items()?;
            match r.lookup(items)? {
                None => {
                    r.get_unique_array_type()?;
                    let reconstituted = r.reconstitute(items)?;
                    r.set_array_items(reconstituted)
                }
                Some(maybe_items) => r.get_array_type(maybe_items),
            }
        }
        TypeData::Object {
            is_fixed,
            additional_properties,
            ..
        } => {
            let is_fixed = *is_fixed;
            let additional_properties = *additional_properties;
            let sorted_properties = t.sorted_properties()?;
            let properties_in_new_order = if canonical_order {
                sorted_properties.clone()
            } else {
                t.properties()?.clone()
            };
            let sorted_refs: IndexMap<String, TypeRef> = sorted_properties
                .iter()
                .map(|(n, cp)| (n.clone(), cp.type_ref))
                .collect();
            let maybe_property_types = r.lookup_map(&sorted_refs)?;
            let maybe_additional_properties = match additional_properties {
                None => None,
                Some(a) => r.lookup(a)?,
            };

            if let Some(property_types) = maybe_property_types
                && (maybe_additional_properties.is_some() || additional_properties.is_none())
            {
                let mut properties = IndexMap::new();
                for (n, cp) in &properties_in_new_order {
                    properties.insert(
                        n.clone(),
                        ClassProperty::new(*defined(property_types.get(n))?, cp.is_optional),
                    );
                }
                match t.kind() {
                    TypeKind::Object => {
                        assert_default(is_fixed)?;
                        r.get_object_type(properties, maybe_additional_properties)
                    }
                    TypeKind::Map => r.get_map_type(defined(maybe_additional_properties)?),
                    TypeKind::Class => {
                        if is_fixed {
                            r.get_unique_class_type(true, Some(properties))
                        } else {
                            r.get_class_type(properties)
                        }
                    }
                    kind => panic(format!("Invalid object type kind {kind}")),
                }
            } else {
                match t.kind() {
                    TypeKind::Object => {
                        assert_default(is_fixed)?;
                        r.get_unique_object_type(None, None)?;
                    }
                    TypeKind::Map => r.get_unique_map_type()?,
                    TypeKind::Class => r.get_unique_class_type(is_fixed, None)?,
                    kind => return panic(format!("Invalid object type kind {kind}")),
                }

                let mut reconstituted_types: IndexMap<String, TypeRef> = IndexMap::new();
                for (n, cp) in &sorted_properties {
                    let reconstituted = r.reconstitute(cp.type_ref)?;
                    reconstituted_types.insert(n.clone(), reconstituted);
                }
                let mut properties = IndexMap::new();
                for (n, cp) in &properties_in_new_order {
                    properties.insert(
                        n.clone(),
                        ClassProperty::new(*defined(reconstituted_types.get(n))?, cp.is_optional),
                    );
                }
                let additional = match additional_properties {
                    None => None,
                    Some(a) => Some(r.reconstitute(a)?),
                };
                r.set_object_properties(properties, additional)
            }
        }
        TypeData::Enum { cases } => r.get_enum_type(cases.clone()),
        TypeData::SetOperation { .. } => {
            let is_union = t.kind() == TypeKind::Union;
            let members = t.members()?;
            let sorted_members = sort_members_by_kind(original, members);
            let members_in_order: Vec<TypeRef> = if canonical_order {
                sorted_members.iter().copied().collect()
            } else {
                members.iter().copied().collect()
            };
            let sorted_member_refs: IndexMap<TypeRef, TypeRef> =
                sorted_members.iter().map(|&m| (m, m)).collect();
            match r.lookup_map(&sorted_member_refs)? {
                None => {
                    if is_union {
                        r.get_unique_union_type()?;
                    } else {
                        r.get_unique_intersection_type()?;
                    }
                    let reconstituted = r.reconstitute_map(&sorted_member_refs)?;
                    let mut new_members = IndexSet::new();
                    for m in &members_in_order {
                        new_members.insert(*defined(reconstituted.get(m))?);
                    }
                    r.set_set_operation_members(new_members)
                }
                Some(maybe_members) => {
                    let mut new_members = IndexSet::new();
                    for m in &members_in_order {
                        new_members.insert(*defined(maybe_members.get(m))?);
                    }
                    if is_union {
                        r.get_union_type(new_members)
                    } else {
                        r.get_intersection_type(new_members)
                    }
                }
            }
        }
    }
}

/// `setSortBy(members, t => t.kind)`: a stable sort by kind name.
pub(crate) fn sort_members_by_kind(
    graph: &TypeGraph,
    members: &IndexSet<TypeRef>,
) -> IndexSet<TypeRef> {
    let mut sorted: Vec<TypeRef> = members.iter().copied().collect();
    sorted.sort_by(|a, b| compare_string_keys(graph.kind(*a).as_str(), graph.kind(*b).as_str()));
    sorted.into_iter().collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn r(i: usize) -> TypeRef {
        TypeRef::new(0, i).unwrap()
    }

    #[test]
    fn class_property_hash_is_not_truncated() {
        let p = ClassProperty::new(TypeRef::new(31, (1 << 26) - 1).unwrap(), false);
        assert_eq!(p.hash_code(), ((31i64 << 26) | ((1 << 26) - 1)) + 23);
    }

    #[test]
    fn identities_compare_structurally() {
        let attrs = TypeAttributes::new();
        let p1: IndexMap<String, ClassProperty> = [
            ("a".into(), ClassProperty::new(r(1), false)),
            ("b".into(), ClassProperty::new(r(2), true)),
        ]
        .into_iter()
        .collect();
        let p2: IndexMap<String, ClassProperty> = [
            ("b".into(), ClassProperty::new(r(2), true)),
            ("a".into(), ClassProperty::new(r(1), false)),
        ]
        .into_iter()
        .collect();
        let i1 = class_type_identity(&attrs, p1).unwrap();
        let i2 = class_type_identity(&attrs, p2).unwrap();
        assert!(i1.js_equals(&i2));
        assert_eq!(i1.hash_code(), i2.hash_code());
        let m = map_type_identify(&attrs, Some(r(1))).unwrap();
        assert!(!m.js_equals(&i1));
        let u1 = union_type_identity(&attrs, [r(1), r(2)].into_iter().collect()).unwrap();
        let u2 = union_type_identity(&attrs, [r(2), r(1)].into_iter().collect()).unwrap();
        assert!(u1.js_equals(&u2));
        let x = intersection_type_identity(&attrs, [r(2), r(1)].into_iter().collect()).unwrap();
        assert!(!u1.js_equals(&x));
    }

    #[test]
    fn constructors_check_invariants() {
        assert!(Type::object(r(0), TypeKind::Object, false, None, None).is_err());
        assert!(Type::object(r(0), TypeKind::Class, false, None, Some(r(1))).is_err());
        let e = Type::union(r(0), Some(IndexSet::new())).unwrap_err();
        assert_eq!(e.kind(), ErrorKind::IRNoEmptyUnions);
        let mut a = Type::array(r(0), None);
        assert!(a.items().is_err());
        a.set_items(r(1)).unwrap();
        assert_eq!(a.items().unwrap(), r(1));
        assert!(a.set_items(r(2)).is_err());
        let mut u = Type::union(r(0), None).unwrap();
        assert_eq!(
            u.set_members(IndexSet::new()).unwrap_err().kind(),
            ErrorKind::IRNoEmptyUnions
        );
        let mut c = Type::class(r(0), false, None).unwrap();
        assert!(c.properties().is_err());
        c.set_properties(IndexMap::new(), None).unwrap();
        assert!(c.set_properties(IndexMap::new(), None).is_err());
    }
}
