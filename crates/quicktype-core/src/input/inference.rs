//! Port of `packages/quicktype-core/src/input/Inference.ts`.
//!
//! Infers types from the [`Value`]s of a [`CompressedJson`]: all values that
//! end up at the same place (all samples of a top-level, all values of a
//! property across objects, all elements of all arrays at a place) are
//! accumulated in a [`UnionAccumulator`] and built into a union, whose
//! object members are inferred as classes (or maps) and whose array members
//! get the union of all their elements as items.
//!
//! JavaScript quirks kept on purpose:
//!
//! - a property is optional iff it has fewer *values* than there are
//!   objects, so a key that repeats within one object (the CLI keeps
//!   duplicate keys) can make a property required;
//! - the properties are collected in a plain object, where `"__proto__"`
//!   cannot be stored: every occurrence of that key is listed again and
//!   only the last occurrence's value survives.

use std::cell::RefCell;

use indexmap::{IndexMap, IndexSet};

use super::compressed_json::{CompressedJson, Value};
use crate::attributes::string_types::{StringTypes, infer_transformed_string_type_kind_for_string};
use crate::attributes::type_attributes::TypeAttributes;
use crate::messages::{ErrorKind, Result, message_error};
use crate::support::recursion::guard;
use crate::support::support::{defined, panic};
use crate::ty::transformed_string_type::{TypeKind, transformed_string_type_attributes_producer};
use crate::ty::ty::{ClassProperty, Type};
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_ref::TypeRef;
use crate::union_builder::{UnionAccumulator, UnionBuilder};

/// An object's key/value pairs (TS `Value[]` of an object).
type ObjectData<'c> = &'c [(Value, Value)];
/// An array's elements (TS `Value[]` of an array).
type ArrayData<'c> = &'c [Value];

/// TS `Accumulator`: `UnionAccumulator<NestedValueArray, NestedValueArray>`,
/// collecting arrays and objects by their contents.
pub type Accumulator<'c> = UnionAccumulator<ArrayData<'c>, ObjectData<'c>>;

/// A `$ref` placeholder intersection and the references it stands for.
type RefIntersection = (TypeRef, Vec<String>);

/// `canBeEnumCase(s)`: every interned string can.
fn can_be_enum_case(_s: &str) -> bool {
    true
}

/// `TypeInference`: infers the types of the values of one compressed JSON.
pub struct TypeInference<'c> {
    cjson: &'c CompressedJson,
    infer_maps: bool,
    infer_enums: bool,
    /// `_refIntersections`: the `$ref` placeholders of the top-level being
    /// inferred, resolved once it is complete.
    ref_intersections: RefCell<Option<Vec<RefIntersection>>>,
}

impl<'c> TypeInference<'c> {
    /// `new TypeInference(cjson, typeBuilder, inferMaps, inferEnums)`; the
    /// builder is passed to each call instead.
    pub fn new(cjson: &'c CompressedJson, infer_maps: bool, infer_enums: bool) -> Self {
        TypeInference {
            cjson,
            infer_maps,
            infer_enums,
            ref_intersections: RefCell::new(None),
        }
    }

    /// `addValuesToAccumulator(valueArray, accumulator)`.
    fn add_values_to_accumulator(
        &self,
        values: impl IntoIterator<Item = Value>,
        accumulator: &mut Accumulator<'c>,
    ) -> Result<()> {
        let empty = TypeAttributes::new;
        for value in values {
            match value {
                Value::Null => accumulator.add_primitive(TypeKind::Null, empty())?,
                Value::False | Value::True => accumulator.add_primitive(TypeKind::Bool, empty())?,
                Value::Integer => accumulator.add_primitive(TypeKind::Integer, empty())?,
                Value::Double => accumulator.add_primitive(TypeKind::Double, empty())?,
                Value::InternedString(_) => {
                    let s = self.cjson.get_string_for_value(value)?;
                    if self.infer_enums && can_be_enum_case(s) {
                        accumulator.add_string_case(s, 1, empty());
                    } else {
                        accumulator.add_string_type(TypeKind::String, empty(), None)?;
                    }
                }
                Value::UninternedString => {
                    accumulator.add_string_type(TypeKind::String, empty(), None)?;
                }
                Value::Object(_) => {
                    accumulator.add_object(self.cjson.get_object_for_value(value)?, empty());
                }
                Value::Array(_) => {
                    accumulator.add_array(self.cjson.get_array_for_value(value)?, empty());
                }
                Value::StringFormat(_) => {
                    let kind = self.cjson.get_string_format_type_kind(value)?;
                    accumulator.add_string_type(
                        TypeKind::String,
                        empty(),
                        Some(StringTypes::new(
                            Some(IndexMap::new()),
                            [kind].into_iter().collect(),
                        )?),
                    )?;
                }
                Value::TransformedString(_) => {
                    let s = self.cjson.get_string_for_value(value)?;
                    let Some(kind) = infer_transformed_string_type_kind_for_string(
                        s,
                        self.cjson.date_time_recognizer(),
                    ) else {
                        return panic("TransformedString does not have a kind");
                    };
                    let Some(producer) = transformed_string_type_attributes_producer(kind) else {
                        return panic("TransformedString does not have attribute producer");
                    };
                    accumulator.add_string_type(
                        TypeKind::String,
                        producer(s),
                        Some(StringTypes::new(
                            Some(IndexMap::new()),
                            [kind].into_iter().collect(),
                        )?),
                    )?;
                }
            }
        }
        Ok(())
    }

    /// `inferType(typeAttributes, valueArray, fixed, forwardingRef)`.
    ///
    /// Recurses once per nesting level of the input, as in TypeScript,
    /// where V8's stack overflows within about 1,000 levels: past
    /// [`MAX_DEPTH`](crate::support::recursion::MAX_DEPTH) levels this fails
    /// with the same `RangeError` instead of overflowing the native stack.
    pub fn infer_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        type_attributes: TypeAttributes,
        values: impl IntoIterator<Item = Value>,
        fixed: bool,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        guard(|| {
            let accumulator = self.accumulator_for_array(values)?;
            self.make_type_from_accumulator(
                builder,
                &accumulator,
                type_attributes,
                fixed,
                forwarding_ref,
            )
        })
    }

    /// `resolveRef(ref, topLevel)`: follows a `#/a/0/b` JSON reference
    /// through the types inferred for the top-level.
    fn resolve_ref(
        &self,
        builder: &TypeBuilder<'_>,
        reference: &str,
        top_level: TypeRef,
    ) -> Result<TypeRef> {
        let error = |kind| message_error(kind, vec![("reference", reference.into())]);
        if !reference.starts_with("#/") {
            return error(ErrorKind::InferenceJSONReferenceNotRooted);
        }
        let mut tref = top_level;
        for part in reference.split('/').skip(1) {
            let mut t: &Type = builder.type_at_index(tref.index())?;
            if t.is_union() {
                let Some(nullable) = nullable_from_union(builder, t)? else {
                    // FIXME in TypeScript: handle unions.
                    return error(ErrorKind::InferenceJSONReferenceToUnion);
                };
                t = builder.type_at_index(nullable.index())?;
            }

            if t.is_class() {
                let Some(cp) = t.properties()?.get(part) else {
                    return error(ErrorKind::InferenceJSONReferenceWrongProperty);
                };
                tref = cp.type_ref;
            } else if t.is_map() {
                tref = t.map_values()?;
            } else if t.is_array() {
                if part.is_empty() || !part.bytes().all(|b| b.is_ascii_digit()) {
                    return error(ErrorKind::InferenceJSONReferenceInvalidArrayIndex);
                }
                tref = t.items()?;
            } else {
                return error(ErrorKind::InferenceJSONReferenceWrongProperty);
            }
        }
        Ok(tref)
    }

    /// `inferTopLevelType(typeAttributes, valueArray, fixed)`: infers the
    /// type of a top-level's samples, then resolves the JSON references in
    /// them if `$ref`s are handled.
    pub fn infer_top_level_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        type_attributes: TypeAttributes,
        samples: &[Value],
        fixed: bool,
    ) -> Result<TypeRef> {
        if self.ref_intersections.borrow().is_some() {
            return panic("Didn't reset ref intersections - nested invocations?");
        }
        if self.cjson.handle_refs() {
            *self.ref_intersections.borrow_mut() = Some(Vec::new());
        }

        let top_level = self.infer_type(
            builder,
            type_attributes,
            samples.iter().copied(),
            fixed,
            None,
        )?;
        if self.cjson.handle_refs() {
            let intersections = defined(self.ref_intersections.borrow_mut().take())?;
            for (tref, refs) in intersections {
                let resolved = refs
                    .iter()
                    .map(|r| self.resolve_ref(builder, r, top_level))
                    .collect::<Result<IndexSet<TypeRef>>>()?;
                builder.set_set_operation_members(tref, resolved)?;
            }
        }
        Ok(top_level)
    }

    /// `accumulatorForArray(valueArray)`.
    fn accumulator_for_array(
        &self,
        values: impl IntoIterator<Item = Value>,
    ) -> Result<Accumulator<'c>> {
        let mut accumulator = UnionAccumulator::new(true);
        self.add_values_to_accumulator(values, &mut accumulator)?;
        Ok(accumulator)
    }

    /// `makeTypeFromAccumulator(accumulator, typeAttributes, fixed,
    /// forwardingRef)`.
    fn make_type_from_accumulator(
        &self,
        builder: &mut TypeBuilder<'_>,
        accumulator: &Accumulator<'c>,
        type_attributes: TypeAttributes,
        fixed: bool,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let union_builder = InferenceUnionBuilder {
            inference: self,
            fixed,
        };
        union_builder.build_union(builder, accumulator, false, type_attributes, forwarding_ref)
    }

    /// `inferClassType(typeAttributes, objects, fixed, forwardingRef)`: a
    /// class (or, with more than 500 properties, a map) for `objects`.
    pub fn infer_class_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        type_attributes: TypeAttributes,
        objects: &[ObjectData<'c>],
        fixed: bool,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        // `propertyNames` and the plain object `propertyValues`.
        let mut property_names: Vec<&'c str> = Vec::new();
        let mut property_values: IndexMap<&'c str, Vec<Value>> = IndexMap::new();
        let mut proto_values: Vec<Value> = Vec::new();
        for object in objects {
            for &(key, value) in *object {
                let key = self.cjson.get_string_for_value(key)?;
                if key == "__proto__" {
                    // Never an own property: listed again, values replaced.
                    property_names.push(key);
                    proto_values = vec![value];
                    continue;
                }
                let values = property_values.entry(key).or_insert_with(|| {
                    property_names.push(key);
                    Vec::new()
                });
                values.push(value);
            }
        }
        let values_of = |key: &str| -> &[Value] {
            if key == "__proto__" {
                &proto_values
            } else {
                property_values.get(key).map_or(&[], Vec::as_slice)
            }
        };

        if self.cjson.handle_refs() && property_names == ["$ref"] {
            let values = values_of("$ref");
            if values.iter().all(|v| matches!(v, Value::InternedString(_))) {
                let all_refs = values
                    .iter()
                    .map(|&v| self.cjson.get_string_for_value(v).map(str::to_owned))
                    .collect::<Result<Vec<String>>>()?;
                // FIXME in TypeScript: add an is-ref attribute.
                let tref = builder.get_unique_intersection_type(type_attributes, None, None)?;
                match self.ref_intersections.borrow_mut().as_mut() {
                    Some(intersections) => intersections.push((tref, all_refs)),
                    None => return panic("Defined value expected, but got undefined"),
                }
                return Ok(tref);
            }
        }

        if self.infer_maps && property_names.len() > 500 {
            let mut accumulator = UnionAccumulator::new(true);
            for key in &property_names {
                self.add_values_to_accumulator(values_of(key).iter().copied(), &mut accumulator)?;
            }
            let values = self.make_type_from_accumulator(
                builder,
                &accumulator,
                TypeAttributes::new(),
                fixed,
                None,
            )?;
            return builder.get_map_type(type_attributes, values, forwarding_ref);
        }

        let mut properties: IndexMap<String, ClassProperty> = IndexMap::new();
        for key in &property_names {
            let values = values_of(key);
            let t = self.infer_type(
                builder,
                TypeAttributes::new(),
                values.iter().copied(),
                false,
                None,
            )?;
            let is_optional = values.len() < objects.len();
            properties.insert(
                (*key).to_owned(),
                builder.make_class_property(t, is_optional),
            );
        }

        if fixed {
            return builder.get_unique_class_type(
                type_attributes,
                true,
                Some(properties),
                forwarding_ref,
            );
        }
        builder.get_class_type(type_attributes, properties, forwarding_ref)
    }
}

/// `nullableFromUnion(t)` for a union in the graph being built: its only
/// non-null member, if it has a `null` member.
fn nullable_from_union(builder: &TypeBuilder<'_>, union: &Type) -> Result<Option<TypeRef>> {
    let mut has_null = false;
    let mut non_nulls = Vec::new();
    for &member in union.members()? {
        if builder.type_at_index(member.index())?.kind() == TypeKind::Null {
            has_null = true;
        } else {
            non_nulls.push(member);
        }
    }
    Ok(match non_nulls.as_slice() {
        [single] if has_null => Some(*single),
        _ => None,
    })
}

/// `InferenceUnionBuilder`: objects are inferred as classes, arrays get the
/// union of all their elements.
struct InferenceUnionBuilder<'i, 'c> {
    inference: &'i TypeInference<'c>,
    fixed: bool,
}

impl<'g, 'c> UnionBuilder<'g> for InferenceUnionBuilder<'_, 'c> {
    type ArrayData = Vec<ArrayData<'c>>;
    type ObjectData = Vec<ObjectData<'c>>;

    fn make_object(
        &self,
        builder: &mut TypeBuilder<'g>,
        objects: &Self::ObjectData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.inference.infer_class_type(
            builder,
            type_attributes,
            objects,
            self.fixed,
            forwarding_ref,
        )
    }

    fn make_array(
        &self,
        builder: &mut TypeBuilder<'g>,
        arrays: &Self::ArrayData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        // As in TypeScript, the forwarding ref goes to the items.
        let items = self.inference.infer_type(
            builder,
            TypeAttributes::new(),
            arrays.iter().flat_map(|a| a.iter().copied()),
            self.fixed,
            forwarding_ref,
        )?;
        builder.get_array_type(type_attributes, items, None)
    }
}
