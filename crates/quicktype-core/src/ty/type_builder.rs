//! Port of `packages/quicktype-core/src/Type/TypeBuilder.ts`.
//!
//! [`TypeBuilder`] builds a type graph. Types are allocated in an arena in
//! creation order; a ref can be *reserved* first (a forwarding ref) and the
//! type committed to it later, which is how recursive types are built.
//!
//! Most `get*Type` methods deduplicate: they compute the requested type's
//! [`TypeIdentity`] and return an existing type with the same identity (a
//! JavaScript-exact [`EqualityMap`] lookup). The `getUnique*Type` methods
//! always create a new type. If a deduplicated type is found but the caller
//! passed a forwarding ref, the ref becomes a forwarding intersection with
//! the found type as its only member; those are removed by a remap after
//! the graph is finished.
//!
//! The same struct also serves as the TypeScript `GraphRewriteBuilder` and
//! `GraphRemapBuilder` (see [`graph_rewriting`](crate::graph_rewriting)),
//! which rebuild an existing graph; the rewrite-specific state lives in
//! `RewriteState`.

use indexmap::{IndexMap, IndexSet};

use crate::attributes::string_types::{StringTypes, StringTypesTypeAttributeKind};
use crate::attributes::type_attributes::{
    AttributeKind, CombinationKind, TypeAttributeKind, TypeAttributes, combine_type_attributes2,
};
use crate::graph_rewriting::RewriteState;
use crate::messages::Result;
use crate::support::collection_utils::{EqualityMap, JsEquals, map_sort_by_key};
use crate::support::support::{assert, assert_default, panic};
use crate::ty::provenance_type_attribute_kind::ProvenanceTypeAttributeKind;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::{
    ClassProperty, Type, TypeIdentity, array_type_identity, class_type_identity,
    enum_type_identity, intersection_type_identity, map_type_identify, primitive_type_identity,
    union_type_identity,
};
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::{TypeRef, assert_type_ref_graph};

/// `TypeBuilder` (and, with rewrite state, `GraphRewriteBuilder` /
/// `GraphRemapBuilder`).
pub struct TypeBuilder<'g> {
    serial: u32,
    graph_has_provenance_attributes: bool,
    string_type_mapping: StringTypeMapping,
    canonical_order: bool,
    all_properties_optional: bool,
    add_provenance_attributes: bool,
    top_levels: IndexMap<String, TypeRef>,
    types: Vec<Option<Type>>,
    type_attributes: Vec<TypeAttributes>,
    added_forwarding_intersection: bool,
    type_for_identity: EqualityMap<TypeIdentity, TypeRef>,
    pub(crate) rewrite: Option<RewriteState<'g>>,
}

impl TypeBuilder<'static> {
    /// `new TypeBuilder(stringTypeMapping, canonicalOrder,
    /// allPropertiesOptional, addProvenanceAttributes,
    /// inheritsProvenanceAttributes)` together with its graph
    /// `new TypeGraph(builder, 0, addProvenanceAttributes)`, as `Run` creates
    /// the builder for the input graph.
    ///
    /// * `canonical_order`: sort class properties by name.
    /// * `all_properties_optional`: make every class property optional.
    /// * `add_provenance_attributes`: give every type its index as
    ///   provenance, and check it is preserved by every rewrite.
    pub fn new(
        string_type_mapping: StringTypeMapping,
        canonical_order: bool,
        all_properties_optional: bool,
        add_provenance_attributes: bool,
        inherits_provenance_attributes: bool,
    ) -> Result<TypeBuilder<'static>> {
        TypeBuilder::with_graph(
            0,
            add_provenance_attributes,
            string_type_mapping,
            canonical_order,
            all_properties_optional,
            add_provenance_attributes,
            inherits_provenance_attributes,
        )
    }
}

impl<'g> TypeBuilder<'g> {
    /// A builder for a graph with serial `serial`.
    #[allow(clippy::too_many_arguments)]
    pub(crate) fn with_graph(
        serial: u32,
        graph_has_provenance_attributes: bool,
        string_type_mapping: StringTypeMapping,
        canonical_order: bool,
        all_properties_optional: bool,
        add_provenance_attributes: bool,
        inherits_provenance_attributes: bool,
    ) -> Result<TypeBuilder<'g>> {
        assert(
            !add_provenance_attributes || !inherits_provenance_attributes,
            "We can't both inherit as well as add provenance",
        )?;
        Ok(TypeBuilder {
            serial,
            graph_has_provenance_attributes,
            string_type_mapping,
            canonical_order,
            all_properties_optional,
            add_provenance_attributes,
            top_levels: IndexMap::new(),
            types: Vec::new(),
            type_attributes: Vec::new(),
            added_forwarding_intersection: false,
            type_for_identity: EqualityMap::new(),
            rewrite: None,
        })
    }

    /// The serial of the graph being built.
    pub fn serial(&self) -> u32 {
        self.serial
    }

    /// `canonicalOrder`: whether class properties are sorted by name.
    pub fn canonical_order(&self) -> bool {
        self.canonical_order
    }

    /// The string type mapping transformed string kinds are mapped through.
    pub fn string_type_mapping(&self) -> &StringTypeMapping {
        &self.string_type_mapping
    }

    /// The number of types (reserved or committed) so far.
    pub fn len(&self) -> usize {
        self.types.len()
    }

    /// Whether no types have been reserved yet.
    pub fn is_empty(&self) -> bool {
        self.types.is_empty()
    }

    /// `addTopLevel(name, tref)`.
    pub fn add_top_level(&mut self, name: &str, tref: TypeRef) -> Result<()> {
        assert(
            !self.top_levels.contains_key(name),
            "Trying to add top-level with existing name",
        )?;
        assert(
            self.types.get(tref.index()).is_some_and(Option::is_some),
            "Trying to add a top-level type that doesn't exist (yet?)",
        )?;
        self.top_levels.insert(name.to_owned(), tref);
        Ok(())
    }

    /// `reserveTypeRef()`: a ref for a type that is committed later.
    pub fn reserve_type_ref(&mut self) -> Result<TypeRef> {
        let index = self.types.len();
        let tref = TypeRef::new(self.serial, index)?;
        self.types.push(None);
        let attributes = if self.add_provenance_attributes {
            ProvenanceTypeAttributeKind.make_attributes([index as u32].into_iter().collect())
        } else {
            TypeAttributes::new()
        };
        self.type_attributes.push(attributes);
        Ok(tref)
    }

    pub(crate) fn assert_type_ref_graph(&self, tref: TypeRef) -> Result<()> {
        assert_type_ref_graph(tref, self.serial)
    }

    fn assert_type_ref_set_graph<'a>(
        &self,
        trefs: impl IntoIterator<Item = &'a TypeRef>,
    ) -> Result<()> {
        for &tref in trefs {
            self.assert_type_ref_graph(tref)?;
        }
        Ok(())
    }

    fn filter_type_attributes(
        &mut self,
        kind: TypeKind,
        attributes: &TypeAttributes,
    ) -> TypeAttributes {
        let filtered = attributes.filter(|v| v.kind().applies_to_type_kind(kind));
        if attributes.len() != filtered.len() {
            self.set_lost_type_attributes();
        }
        filtered
    }

    /// The arena index of a reserved or committed `tref` of this builder.
    fn index_of(&self, tref: TypeRef) -> Result<usize> {
        self.assert_type_ref_graph(tref)?;
        let index = tref.index();
        if index >= self.types.len() {
            return panic("Trying to deref an undefined type in a type builder");
        }
        Ok(index)
    }

    fn commit_type(&mut self, tref: TypeRef, t: Type) -> Result<()> {
        let index = self.index_of(tref)?;
        assert(
            self.types[index].is_none(),
            "A type index was committed twice",
        )?;
        let kind = t.kind();
        self.types[index] = Some(t);
        let attributes = std::mem::take(&mut self.type_attributes[index]);
        self.type_attributes[index] = self.filter_type_attributes(kind, &attributes);
        Ok(())
    }

    /// `addType(forwardingRef, creator, attributes)`: commits a new type,
    /// to the forwarding ref if one is given.
    fn add_type(
        &mut self,
        forwarding_ref: Option<TypeRef>,
        creator: impl FnOnce(TypeRef) -> Result<Type>,
        attributes: Option<&TypeAttributes>,
    ) -> Result<TypeRef> {
        if let Some(fwd) = forwarding_ref {
            self.assert_type_ref_graph(fwd)?;
            assert_default(self.types.get(fwd.index()).is_some_and(Option::is_none))?;
        }

        let tref = match forwarding_ref {
            Some(fwd) => fwd,
            None => self.reserve_type_ref()?,
        };
        if let Some(attributes) = attributes {
            let index = self.index_of(tref)?;
            self.type_attributes[index] = combine_type_attributes2(
                CombinationKind::Union,
                &self.type_attributes[index],
                attributes,
            )?;
        }

        let t = creator(tref)?;
        self.commit_type(tref, t)?;
        Ok(tref)
    }

    /// `typeAtIndex(index)`: a committed type.
    pub fn type_at_index(&self, index: usize) -> Result<&Type> {
        match self.types.get(index) {
            Some(Some(t)) => Ok(t),
            _ => panic("Trying to deref an undefined type in a type builder"),
        }
    }

    /// `atIndex(index)`: a committed type and its attributes.
    pub fn at_index(&self, index: usize) -> Result<(&Type, &TypeAttributes)> {
        let t = self.type_at_index(index)?;
        Ok((t, &self.type_attributes[index]))
    }

    /// The current attributes of a reserved or committed type.
    pub fn attributes_at(&self, tref: TypeRef) -> Result<&TypeAttributes> {
        self.assert_type_ref_graph(tref)?;
        match self.type_attributes.get(tref.index()) {
            Some(a) => Ok(a),
            None => panic("Trying to deref an undefined type in a type builder"),
        }
    }

    /// `addAttributes(tref, attributes)`: adds non-identity attributes to an
    /// existing type. Identity attributes must already be present and equal.
    pub fn add_attributes(&mut self, tref: TypeRef, attributes: &TypeAttributes) -> Result<()> {
        let index = self.index_of(tref)?;
        let existing_attributes = &self.type_attributes[index];
        assert(
            attributes.iter().all(|v| {
                if !v.kind().in_identity() {
                    return true;
                }
                match existing_attributes.get(v.kind()) {
                    None => false,
                    Some(existing) => existing.js_equals(v),
                }
            }),
            "Can't add different identity type attributes to an existing type",
        )?;
        let maybe_kind = self.types[index].as_ref().map(Type::kind);
        let attributes = match maybe_kind {
            Some(kind) => self.filter_type_attributes(kind, attributes),
            None => attributes.clone(),
        };
        let non_identity_attributes = attributes.non_identity_attributes();
        self.type_attributes[index] = combine_type_attributes2(
            CombinationKind::Union,
            &self.type_attributes[index],
            &non_identity_attributes,
        )?;
        Ok(())
    }

    /// `finish()` of a plain `TypeBuilder`: freezes the graph. Every
    /// reserved ref must have been committed.
    pub fn finish(self) -> Result<TypeGraph> {
        if self.rewrite.is_some() {
            return Ok(self.finish_rewrite()?.graph);
        }
        self.freeze()
    }

    pub(crate) fn freeze(self) -> Result<TypeGraph> {
        let mut types = Vec::with_capacity(self.types.len());
        for t in self.types {
            match t {
                Some(t) => types.push(t),
                None => return panic("Defined value expected, but got undefined"),
            }
        }
        TypeGraph::freeze(
            self.serial,
            self.graph_has_provenance_attributes,
            self.top_levels,
            types,
            self.type_attributes,
        )
    }

    /// `addForwardingIntersection(forwardingRef, tref)`.
    fn add_forwarding_intersection(
        &mut self,
        forwarding_ref: TypeRef,
        tref: TypeRef,
    ) -> Result<TypeRef> {
        if self.is_remap() {
            return panic(
                "We can't add forwarding intersections when we're removing forwarding intersections",
            );
        }
        self.assert_type_ref_graph(tref)?;
        self.added_forwarding_intersection = true;
        self.add_type(
            Some(forwarding_ref),
            |tr| Ok(Type::intersection(tr, Some([tref].into_iter().collect()))),
            None,
        )
    }

    /// `forwardIfNecessary(forwardingRef, tref)`: `tref`, or a forwarding
    /// intersection at `forwarding_ref` pointing to it.
    pub(crate) fn forward_if_necessary(
        &mut self,
        forwarding_ref: Option<TypeRef>,
        tref: TypeRef,
    ) -> Result<TypeRef> {
        match forwarding_ref {
            None => Ok(tref),
            Some(fwd) => self.add_forwarding_intersection(fwd, tref),
        }
    }

    /// `didAddForwardingIntersection`.
    pub fn did_add_forwarding_intersection(&self) -> bool {
        self.added_forwarding_intersection
    }

    fn register_type_for_identity(&mut self, identity: Option<TypeIdentity>, tref: TypeRef) {
        if let Some(identity) = identity {
            self.type_for_identity.set(identity, tref);
        }
    }

    /// Whether this builder deduplicates (the remap builder does not).
    fn makes_identities(&self) -> bool {
        !self.is_remap()
    }

    /// `makeIdentity(maker)`: the remap builder never deduplicates.
    fn make_identity(&self, maker: impl FnOnce() -> Option<TypeIdentity>) -> Option<TypeIdentity> {
        if self.makes_identities() {
            maker()
        } else {
            None
        }
    }

    fn get_or_add_type(
        &mut self,
        identity: Option<TypeIdentity>,
        creator: impl FnOnce(TypeRef) -> Result<Type>,
        attributes: &TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let maybe_type_ref = identity
            .as_ref()
            .and_then(|i| self.type_for_identity.get(i).copied());

        if let Some(found) = maybe_type_ref {
            let result = self.forward_if_necessary(forwarding_ref, found)?;
            // Only the attributes that are not in the identity are added; the
            // identity attributes are equal by definition.
            self.add_attributes(result, &attributes.non_identity_attributes())?;
            return Ok(result);
        }

        let tref = self.add_type(forwarding_ref, creator, Some(attributes))?;
        self.register_type_for_identity(identity, tref);
        Ok(tref)
    }

    /// `registerType(t)`: registers a type under its current identity after
    /// its children were set.
    fn register_type(&mut self, tref: TypeRef) -> Result<()> {
        if !self.makes_identities() {
            // The remap builder never looks identities up.
            return Ok(());
        }
        let index = self.index_of(tref)?;
        let t = self.type_at_index(index)?;
        let identity = t.identity(&self.type_attributes[index])?;
        self.register_type_for_identity(identity, tref);
        Ok(())
    }

    /// `getPrimitiveType(kind, attributes, forwardingRef)`. Transformed
    /// string kinds are mapped through the string type mapping first; a
    /// string gets an unrestricted `stringTypes` unless `kind` was `string`.
    pub fn get_primitive_type(
        &mut self,
        kind: TypeKind,
        attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let string_types = if kind == TypeKind::String {
            None
        } else {
            Some(StringTypes::unrestricted())
        };
        let mut kind = kind;
        if kind.is_primitive_string_type_kind() && kind != TypeKind::String {
            kind = self.string_type_mapping.get(kind);
        }

        if kind == TypeKind::String {
            return self.get_string_type(attributes, string_types, forwarding_ref);
        }

        let identity = self.make_identity(|| primitive_type_identity(kind, &attributes));
        self.get_or_add_type(
            identity,
            |tr| Ok(Type::primitive(tr, kind)),
            &attributes,
            forwarding_ref,
        )
    }

    /// `getStringType(attributes, stringTypes, forwardingRef)`: exactly one
    /// of `string_types` and a `stringTypes` attribute must be given.
    pub fn get_string_type(
        &mut self,
        attributes: TypeAttributes,
        string_types: Option<StringTypes>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let has_existing = attributes.contains(TypeAttributeKind::StringTypes);
        assert(
            string_types.is_none() != !has_existing,
            "Must instantiate string type with one enum case attribute",
        )?;
        let attributes = match string_types {
            Some(st) if !has_existing => combine_type_attributes2(
                CombinationKind::Union,
                &attributes,
                &StringTypesTypeAttributeKind.make_attributes(st),
            )?,
            _ => attributes,
        };

        let identity =
            self.make_identity(|| primitive_type_identity(TypeKind::String, &attributes));
        self.get_or_add_type(
            identity,
            |tr| Ok(Type::primitive(tr, TypeKind::String)),
            &attributes,
            forwarding_ref,
        )
    }

    /// `getEnumType(attributes, cases, forwardingRef)`.
    pub fn get_enum_type(
        &mut self,
        attributes: TypeAttributes,
        cases: IndexSet<String>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let identity = self.make_identity(|| enum_type_identity(&attributes, cases.clone()));
        self.get_or_add_type(
            identity,
            |tr| Ok(Type::enum_type(tr, cases)),
            &attributes,
            forwarding_ref,
        )
    }

    /// `makeClassProperty(tref, isOptional)`.
    pub fn make_class_property(&self, tref: TypeRef, is_optional: bool) -> ClassProperty {
        ClassProperty::new(tref, is_optional)
    }

    /// `getUniqueObjectType(attributes, properties, additionalProperties,
    /// forwardingRef)`: a new fixed `object`.
    pub fn get_unique_object_type(
        &mut self,
        attributes: TypeAttributes,
        properties: Option<IndexMap<String, ClassProperty>>,
        additional_properties: Option<TypeRef>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        if let Some(a) = additional_properties {
            self.assert_type_ref_graph(a)?;
        }
        let properties = match properties {
            Some(p) => Some(self.modify_properties_if_necessary(p)?),
            None => None,
        };
        self.add_type(
            forwarding_ref,
            |tr| {
                Type::object(
                    tr,
                    TypeKind::Object,
                    true,
                    properties,
                    additional_properties,
                )
            },
            Some(&attributes),
        )
    }

    /// `getUniqueMapType(forwardingRef)`: a new map whose values are set
    /// later with [`set_object_properties`](Self::set_object_properties).
    pub fn get_unique_map_type(&mut self, forwarding_ref: Option<TypeRef>) -> Result<TypeRef> {
        self.add_type(forwarding_ref, |tr| Type::map(tr, None), None)
    }

    /// `getMapType(attributes, values, forwardingRef)`.
    pub fn get_map_type(
        &mut self,
        attributes: TypeAttributes,
        values: TypeRef,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.assert_type_ref_graph(values)?;
        let identity = self.make_identity(|| map_type_identify(&attributes, Some(values)));
        self.get_or_add_type(
            identity,
            |tr| Type::map(tr, Some(values)),
            &attributes,
            forwarding_ref,
        )
    }

    /// `setObjectProperties(ref, properties, additionalProperties)`, then
    /// registers the type under its now complete identity.
    pub fn set_object_properties(
        &mut self,
        tref: TypeRef,
        properties: IndexMap<String, ClassProperty>,
        additional_properties: Option<TypeRef>,
    ) -> Result<()> {
        if let Some(a) = additional_properties {
            self.assert_type_ref_graph(a)?;
        }
        self.assert_type_ref_graph(tref)?;
        if !self.type_at_index(tref.index())?.is_object_type() {
            return panic("Tried to set properties of non-object type");
        }
        let properties = self.modify_properties_if_necessary(properties)?;
        self.type_mut(tref)?
            .set_properties(properties, additional_properties)?;
        self.register_type(tref)
    }

    /// `getUniqueArrayType(attributes, forwardingRef)`: a new array whose
    /// items are set later with [`set_array_items`](Self::set_array_items).
    pub fn get_unique_array_type(
        &mut self,
        attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.add_type(
            forwarding_ref,
            |tr| Ok(Type::array(tr, None)),
            Some(&attributes),
        )
    }

    /// `getArrayType(attributes, items, forwardingRef)`.
    pub fn get_array_type(
        &mut self,
        attributes: TypeAttributes,
        items: TypeRef,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.assert_type_ref_graph(items)?;
        let identity = self.make_identity(|| array_type_identity(&attributes, items));
        self.get_or_add_type(
            identity,
            |tr| Ok(Type::array(tr, Some(items))),
            &attributes,
            forwarding_ref,
        )
    }

    /// `setArrayItems(ref, items)`, then registers the type.
    pub fn set_array_items(&mut self, tref: TypeRef, items: TypeRef) -> Result<()> {
        self.assert_type_ref_graph(items)?;
        self.assert_type_ref_graph(tref)?;
        self.type_mut(tref)?.set_items(items)?;
        self.register_type(tref)
    }

    /// `modifyPropertiesIfNecessary(properties)`: sorts by name with
    /// `canonicalOrder`, makes everything optional with
    /// `allPropertiesOptional`.
    pub fn modify_properties_if_necessary(
        &self,
        properties: IndexMap<String, ClassProperty>,
    ) -> Result<IndexMap<String, ClassProperty>> {
        for p in properties.values() {
            self.assert_type_ref_graph(p.type_ref)?;
        }
        let mut properties = properties;
        if self.canonical_order {
            properties = map_sort_by_key(&properties);
        }
        if self.all_properties_optional {
            for p in properties.values_mut() {
                p.is_optional = true;
            }
        }
        Ok(properties)
    }

    /// `getClassType(attributes, properties, forwardingRef)`: a deduplicated,
    /// non-fixed class.
    pub fn get_class_type(
        &mut self,
        attributes: TypeAttributes,
        properties: IndexMap<String, ClassProperty>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let properties = self.modify_properties_if_necessary(properties)?;
        let identity = self.make_identity(|| class_type_identity(&attributes, properties.clone()));
        self.get_or_add_type(
            identity,
            |tr| Type::class(tr, false, Some(properties)),
            &attributes,
            forwarding_ref,
        )
    }

    /// `getUniqueClassType(attributes, isFixed, properties, forwardingRef)`.
    pub fn get_unique_class_type(
        &mut self,
        attributes: TypeAttributes,
        is_fixed: bool,
        properties: Option<IndexMap<String, ClassProperty>>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let properties = match properties {
            Some(p) => Some(self.modify_properties_if_necessary(p)?),
            None => None,
        };
        self.add_type(
            forwarding_ref,
            |tr| Type::class(tr, is_fixed, properties),
            Some(&attributes),
        )
    }

    /// `getUnionType(attributes, members, forwardingRef)`.
    pub fn get_union_type(
        &mut self,
        attributes: TypeAttributes,
        members: IndexSet<TypeRef>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.assert_type_ref_set_graph(&members)?;
        let identity = self.make_identity(|| union_type_identity(&attributes, members.clone()));
        self.get_or_add_type(
            identity,
            |tr| Type::union(tr, Some(members)),
            &attributes,
            forwarding_ref,
        )
    }

    /// `getUniqueUnionType(attributes, members, forwardingRef)`.
    pub fn get_unique_union_type(
        &mut self,
        attributes: TypeAttributes,
        members: Option<IndexSet<TypeRef>>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        if let Some(m) = &members {
            self.assert_type_ref_set_graph(m)?;
        }
        self.add_type(
            forwarding_ref,
            |tr| Type::union(tr, members),
            Some(&attributes),
        )
    }

    /// `getIntersectionType(attributes, members, forwardingRef)`.
    pub fn get_intersection_type(
        &mut self,
        attributes: TypeAttributes,
        members: IndexSet<TypeRef>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.assert_type_ref_set_graph(&members)?;
        let identity =
            self.make_identity(|| intersection_type_identity(&attributes, members.clone()));
        self.get_or_add_type(
            identity,
            |tr| Ok(Type::intersection(tr, Some(members))),
            &attributes,
            forwarding_ref,
        )
    }

    /// `getUniqueIntersectionType(attributes, members, forwardingRef)`.
    pub fn get_unique_intersection_type(
        &mut self,
        attributes: TypeAttributes,
        members: Option<IndexSet<TypeRef>>,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        if let Some(m) = &members {
            self.assert_type_ref_set_graph(m)?;
        }
        self.add_type(
            forwarding_ref,
            |tr| Ok(Type::intersection(tr, members)),
            Some(&attributes),
        )
    }

    /// `setSetOperationMembers(ref, members)`, then registers the type.
    pub fn set_set_operation_members(
        &mut self,
        tref: TypeRef,
        members: IndexSet<TypeRef>,
    ) -> Result<()> {
        self.assert_type_ref_set_graph(&members)?;
        self.assert_type_ref_graph(tref)?;
        if !self.type_at_index(tref.index())?.is_set_operation() {
            return panic("Tried to set members of non-set-operation type");
        }
        self.type_mut(tref)?.set_members(members)?;
        self.register_type(tref)
    }

    /// `setLostTypeAttributes()`: only rewrite builders track this.
    pub fn set_lost_type_attributes(&mut self) {
        if let Some(rewrite) = &mut self.rewrite {
            rewrite.lost_type_attributes = true;
        }
    }

    fn type_mut(&mut self, tref: TypeRef) -> Result<&mut Type> {
        match self.types.get_mut(tref.index()) {
            Some(Some(t)) => Ok(t),
            _ => panic("Trying to deref an undefined type in a type builder"),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::attributes::type_names::make_names_type_attributes;
    use crate::ty::type_builder_utils::get_no_string_type_mapping;

    fn builder(provenance: bool) -> TypeBuilder<'static> {
        TypeBuilder::new(
            get_no_string_type_mapping(),
            false,
            false,
            provenance,
            false,
        )
        .unwrap()
    }

    #[test]
    fn deduplicates_by_identity() {
        let mut b = builder(false);
        let i1 = b
            .get_primitive_type(TypeKind::Integer, TypeAttributes::new(), None)
            .unwrap();
        let i2 = b
            .get_primitive_type(
                TypeKind::Integer,
                make_names_type_attributes("x", true),
                None,
            )
            .unwrap();
        assert_eq!(i1, i2);
        // A plain `string` needs its string types (TypeScript asserts this).
        assert!(
            b.get_primitive_type(TypeKind::String, TypeAttributes::new(), None)
                .is_err()
        );
        let s = b
            .get_string_type(
                TypeAttributes::new(),
                Some(StringTypes::unrestricted()),
                None,
            )
            .unwrap();
        assert_ne!(s, i1);
        let a1 = b.get_array_type(TypeAttributes::new(), i1, None).unwrap();
        let a2 = b.get_array_type(TypeAttributes::new(), i1, None).unwrap();
        assert_eq!(a1, a2);
        let props: IndexMap<String, ClassProperty> =
            [("a".to_owned(), ClassProperty::new(i1, false))]
                .into_iter()
                .collect();
        let c1 = b
            .get_class_type(TypeAttributes::new(), props.clone(), None)
            .unwrap();
        let c2 = b
            .get_class_type(TypeAttributes::new(), props.clone(), None)
            .unwrap();
        assert_eq!(c1, c2);
        let c3 = b
            .get_unique_class_type(TypeAttributes::new(), false, Some(props), None)
            .unwrap();
        assert_ne!(c1, c3);
        b.add_top_level("top", c1).unwrap();
        let g = b.finish().unwrap();
        assert_eq!(g.len(), 5);
        assert_eq!(
            g.graph_text().unwrap(),
            vec![
                "0: integer x | distance 1 x ()",
                "1: string | unrestricted",
                "2: array | children 0",
                "3: class | children 0",
                "4: class | children 0",
            ]
        );
    }

    #[test]
    fn forwarding_ref_to_existing_type_makes_intersection() {
        let mut b = builder(false);
        let i = b
            .get_primitive_type(TypeKind::Integer, TypeAttributes::new(), None)
            .unwrap();
        let fwd = b.reserve_type_ref().unwrap();
        let r = b
            .get_primitive_type(TypeKind::Integer, TypeAttributes::new(), Some(fwd))
            .unwrap();
        assert_eq!(r, fwd);
        assert!(b.did_add_forwarding_intersection());
        assert_eq!(
            b.type_at_index(fwd.index()).unwrap().kind(),
            TypeKind::Intersection
        );
        assert_eq!(
            b.type_at_index(fwd.index()).unwrap().members().unwrap()[0],
            i
        );
    }

    #[test]
    fn provenance_and_any_filtering() {
        let mut b = builder(true);
        let any = b
            .get_primitive_type(TypeKind::Any, make_names_type_attributes("x", false), None)
            .unwrap();
        b.add_top_level("top", any).unwrap();
        let g = b.finish().unwrap();
        assert_eq!(g.graph_text().unwrap(), vec!["0: any | 0"]);
    }

    #[test]
    fn errors_instead_of_panicking() {
        let mut b = builder(false);
        let r = b.reserve_type_ref().unwrap();
        assert!(b.add_top_level("x", r).is_err());
        assert_eq!(
            b.finish().unwrap_err().user_message(),
            "Internal error: Defined value expected, but got undefined"
        );
        let mut b = builder(false);
        let e = b
            .get_union_type(TypeAttributes::new(), IndexSet::new(), None)
            .unwrap_err();
        assert_eq!(
            e.user_message(),
            "Trying to make an empty union - do you have an impossible type in your schema?"
        );
        let mut b = builder(false);
        let s = b
            .get_primitive_type(TypeKind::Bool, TypeAttributes::new(), None)
            .unwrap();
        assert!(b.set_array_items(s, s).is_err());
        assert!(
            b.get_string_type(TypeAttributes::new(), None, None)
                .is_err(),
            "a string needs string types"
        );
    }

    #[test]
    fn graph_accessors_check_the_graph() {
        let mut b = builder(false);
        let i = b
            .get_primitive_type(TypeKind::Integer, TypeAttributes::new(), None)
            .unwrap();
        b.add_top_level("top", i).unwrap();
        let mut g = b.finish().unwrap();
        assert_eq!(g.kind(i).unwrap(), TypeKind::Integer);
        let other_graph = TypeRef::new(1, 0).unwrap();
        for e in [
            g.type_at(other_graph).unwrap_err(),
            g.attributes(other_graph).unwrap_err(),
            g.children(other_graph).unwrap_err(),
        ] {
            assert_eq!(
                e.user_message(),
                "Internal error: Mixing the wrong type reference and graph"
            );
        }
        let out_of_range = TypeRef::new(0, 5).unwrap();
        assert!(g.type_at(out_of_range).is_err());
        assert!(
            g.set_attribute_value(ProvenanceTypeAttributeKind, out_of_range, IndexSet::new())
                .is_err()
        );
        let mut b = builder(false);
        assert_eq!(
            b.add_attributes(other_graph, &TypeAttributes::new())
                .unwrap_err()
                .user_message(),
            "Internal error: Mixing the wrong type reference and graph"
        );
        assert!(
            b.add_attributes(out_of_range, &TypeAttributes::new())
                .is_err()
        );
    }

    #[test]
    fn transformed_kinds_map_through_string_type_mapping() {
        let mut b = TypeBuilder::new(StringTypeMapping::new(), false, false, false, false).unwrap();
        let d = b
            .get_primitive_type(TypeKind::Date, TypeAttributes::new(), None)
            .unwrap();
        let s = b
            .get_string_type(
                TypeAttributes::new(),
                Some(StringTypes::unrestricted()),
                None,
            )
            .unwrap();
        assert_eq!(d, s);
        b.add_top_level("t", d).unwrap();
        assert_eq!(
            b.finish().unwrap().graph_text().unwrap(),
            vec!["0: string | unrestricted"]
        );
    }
}
