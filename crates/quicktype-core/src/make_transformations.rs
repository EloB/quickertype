//! Port of `packages/quicktype-core/src/MakeTransformations.ts`.
//!
//! Replaces the types a target language cannot represent directly with a
//! simpler type plus a `transformation` attribute that says how to decode
//! the original from it: unions become `any` with a decoding choice, enums
//! and transformed strings (`integer-string`, dates, ...) become strings that
//! are parsed or matched, constrained numbers and strings get checks.
//! Which types need this is the target language's
//! `needsTransformerForType`.
//!
//! The order in which helper types are created decides the new graph's type
//! indexes, so each replacer follows the TypeScript statement by statement,
//! including the lazily created unrestricted string type of
//! `replaceUnion`.

use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::constraints::{min_max_length_for_type, min_max_value_for_type};
use crate::attributes::string_types::StringTypes;
use crate::attributes::type_attributes::{
    CombinationKind, TypeAttributes, combine_type_attributes2,
};
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::collection_utils::sort_by_string_key;
use crate::support::support::{assert, console_log, defined, panic};
use crate::transformers::{
    DecodingChoiceCases, Transformation, Transformer, make_transformation_attributes,
};
use crate::ty::transformed_string_type::{
    TypeKind, target_type_kind_for_transformed_string_type_kind,
};
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{find_member, string_type_members};

/// `transformationAttributes(graph, reconstitutedTargetType, transformer,
/// debugPrintTransformations)`.
fn transformation_attributes(
    builder: &TypeBuilder<'_>,
    reconstituted_target_type: TypeRef,
    transformer: Rc<Transformer>,
    debug_print_transformations: bool,
) -> Result<TypeAttributes> {
    let transformation = Transformation::new(reconstituted_target_type, transformer);
    if debug_print_transformations {
        console_log(&format!(
            "transformation for {}:",
            reconstituted_target_type.index()
        ));
        transformation.debug_print(builder)?;
        console_log("reverse:");
        transformation.reverse(builder)?.debug_print(builder)?;
    }
    Ok(make_transformation_attributes(transformation))
}

/// `makeEnumTransformer(graph, enumType, stringType, continuation)`: a
/// choice of one string match per case, each producing that case.
fn make_enum_transformer(
    cases: &IndexSet<String>,
    string_type: TypeRef,
    continuation: Option<Rc<Transformer>>,
) -> Result<Rc<Transformer>> {
    let case_transformers = cases
        .iter()
        .map(|c| {
            Transformer::string_match(
                string_type,
                Transformer::string_producer(string_type, continuation.clone(), c.clone()),
                c.clone(),
            )
        })
        .collect();
    Transformer::choice(string_type, case_transformers)
}

/// `getStringType()` in `replaceUnion`: the unrestricted string, created on
/// first use.
fn lazy_string_type(builder: &mut TypeBuilder<'_>, cache: &mut Option<TypeRef>) -> Result<TypeRef> {
    if let Some(t) = *cache {
        return Ok(t);
    }
    let t = builder.get_string_type(
        TypeAttributes::new(),
        Some(StringTypes::unrestricted()),
        None,
    )?;
    *cache = Some(t);
    Ok(t)
}

/// `replaceUnion(union, builder, forwardingRef, transformedTypes,
/// debugPrintTransformations)`: the union becomes `any`, decoded by kind of
/// JSON value into the reconstituted union.
fn replace_union(
    union: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    transformed_types: &IndexSet<TypeRef>,
    debug_print_transformations: bool,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let members = graph.type_at(union)?.members()?;
    assert(!members.is_empty(), "We can't have empty unions")?;

    // Type attributes that we lost during reconstitution.
    let mut additional_attributes = TypeAttributes::new();

    // Transformed string kinds with a target kind (`integer-string`,
    // `bool-string`) are represented by a member of that kind: an existing
    // one, or a new one.
    let mut reconstituted_members_by_kind: IndexMap<TypeKind, TypeRef> = IndexMap::new();
    for &m in members {
        let kind = graph.kind(m)?;
        let mut reconstituted = None;
        if kind.is_primitive_string_type_kind()
            && let Some(target_kind) = target_type_kind_for_transformed_string_type_kind(kind)
        {
            let target_member = find_member(graph, union, target_kind)?;
            additional_attributes = combine_type_attributes2(
                CombinationKind::Union,
                &additional_attributes,
                graph.attributes(m)?,
            )?;
            reconstituted = Some(match target_member {
                Some(t) => builder.reconstitute_type(t, TypeAttributes::new(), None)?,
                None => builder.get_primitive_type(target_kind, TypeAttributes::new(), None)?,
            });
        }
        let reconstituted = match reconstituted {
            Some(r) => r,
            None => builder.reconstitute_type(m, TypeAttributes::new(), None)?,
        };
        reconstituted_members_by_kind.insert(kind, reconstituted);
    }
    let reconstituted_member_set: IndexSet<TypeRef> =
        reconstituted_members_by_kind.values().copied().collect();
    let have_union = reconstituted_member_set.len() > 1;

    if !have_union {
        builder.set_lost_type_attributes();
    }

    let reconstituted_target_type = if have_union {
        builder.get_union_type(
            graph.attributes(union)?.clone(),
            reconstituted_member_set,
            None,
        )?
    } else {
        *defined(reconstituted_member_set.first())?
    };

    let member_for_kind = |kind: TypeKind| -> Result<TypeRef> {
        defined(reconstituted_members_by_kind.get(&kind).copied())
    };
    let consumer = |member_type_ref: TypeRef| -> Option<Rc<Transformer>> {
        have_union.then(|| Transformer::union_instantiation(member_type_ref))
    };
    let transformer_for_kind = |kind: TypeKind| -> Result<Option<Rc<Transformer>>> {
        if find_member(graph, union, kind)?.is_none() {
            return Ok(None);
        }
        let member_type_ref = member_for_kind(kind)?;
        Ok(Some(Transformer::decoding(
            member_type_ref,
            consumer(member_type_ref),
        )))
    };

    let mut maybe_string_type: Option<TypeRef> = None;

    let transformer_for_string_type = |builder: &mut TypeBuilder<'_>,
                                       t: TypeRef,
                                       maybe_string_type: &mut Option<TypeRef>|
     -> Result<Option<Rc<Transformer>>> {
        let kind = graph.kind(t)?;
        let member_ref = member_for_kind(kind)?;
        if kind == TypeKind::String {
            return Ok(match min_max_length_for_type(graph, t)? {
                None => consumer(member_ref),
                Some(min_max) => Some(Transformer::min_max_length_check(
                    lazy_string_type(builder, maybe_string_type)?,
                    consumer(member_ref),
                    min_max.0,
                    min_max.1,
                )),
            });
        }
        if kind == TypeKind::Enum && transformed_types.contains(&t) {
            let string_type = lazy_string_type(builder, maybe_string_type)?;
            return make_enum_transformer(
                graph.type_at(t)?.cases()?,
                string_type,
                consumer(member_ref),
            )
            .map(Some);
        }
        Ok(Some(Transformer::parse_string(
            lazy_string_type(builder, maybe_string_type)?,
            consumer(member_ref),
        )))
    };

    let mut string_types: Vec<(TypeRef, TypeKind)> = string_type_members(graph, union)?
        .into_iter()
        .map(|t| Ok((t, graph.kind(t)?)))
        .collect::<Result<_>>()?;
    sort_by_string_key(&mut string_types, |(_, k)| k.as_str());
    let transformer_for_string = match string_types.as_slice() {
        [] => None,
        [(t, _)] => {
            let string_type = lazy_string_type(builder, &mut maybe_string_type)?;
            let continuation = transformer_for_string_type(builder, *t, &mut maybe_string_type)?;
            Some(Transformer::decoding(string_type, continuation))
        }
        _ => {
            let decoding_source = lazy_string_type(builder, &mut maybe_string_type)?;
            let choice_source = lazy_string_type(builder, &mut maybe_string_type)?;
            let mut choices = Vec::with_capacity(string_types.len());
            for (t, _) in &string_types {
                choices.push(defined(transformer_for_string_type(
                    builder,
                    *t,
                    &mut maybe_string_type,
                )?)?);
            }
            Some(Transformer::decoding(
                decoding_source,
                Some(Transformer::choice(choice_source, choices)?),
            ))
        }
    };

    let transformer_for_class = transformer_for_kind(TypeKind::Class)?;
    let transformer_for_map = transformer_for_kind(TypeKind::Map)?;
    assert(
        transformer_for_class.is_none() || transformer_for_map.is_none(),
        "Can't have both class and map in a transformed union",
    )?;
    let transformer_for_object = transformer_for_class.or(transformer_for_map);

    let any_type = builder.get_primitive_type(TypeKind::Any, TypeAttributes::new(), None)?;
    let transformer = Transformer::decoding_choice(
        any_type,
        DecodingChoiceCases {
            null: transformer_for_kind(TypeKind::Null)?,
            integer: transformer_for_kind(TypeKind::Integer)?,
            double: transformer_for_kind(TypeKind::Double)?,
            bool: transformer_for_kind(TypeKind::Bool)?,
            string: transformer_for_string,
            array: transformer_for_kind(TypeKind::Array)?,
            object: transformer_for_object,
        },
    );
    let attributes = transformation_attributes(
        builder,
        reconstituted_target_type,
        transformer,
        debug_print_transformations,
    )?;
    builder.get_primitive_type(
        TypeKind::Any,
        combine_type_attributes2(CombinationKind::Union, &attributes, &additional_attributes)?,
        Some(forwarding_ref),
    )
}

/// `replaceArray(arrayType, builder, forwardingRef,
/// debugPrintTransformations)`: an array of `any`, decoded item by item.
fn replace_array(
    array_type: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    debug_print_transformations: bool,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let any_type = builder.get_primitive_type(TypeKind::Any, TypeAttributes::new(), None)?;
    let any_array_type = builder.get_array_type(TypeAttributes::new(), any_type, None)?;
    let reconstituted_items = builder.reconstitute_type(
        graph.type_at(array_type)?.items()?,
        TypeAttributes::new(),
        None,
    )?;
    let transformer = Transformer::array_decoding(
        any_array_type,
        None,
        reconstituted_items,
        Transformer::decoding(any_type, None),
    );

    let reconstituted_attributes =
        builder.reconstitute_type_attributes(graph.attributes(array_type)?)?;
    let reconstituted_array =
        builder.get_array_type(reconstituted_attributes, reconstituted_items, None)?;

    let attributes = transformation_attributes(
        builder,
        reconstituted_array,
        transformer,
        debug_print_transformations,
    )?;

    builder.get_array_type(attributes, any_type, Some(forwarding_ref))
}

/// `replaceEnum(enumType, builder, forwardingRef,
/// debugPrintTransformations)`: a string, matched against the cases.
fn replace_enum(
    enum_type: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    debug_print_transformations: bool,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let cases = graph.type_at(enum_type)?.cases()?;
    let string_type = builder.get_string_type(
        TypeAttributes::new(),
        Some(StringTypes::unrestricted()),
        None,
    )?;
    let transformer = Transformer::decoding(
        string_type,
        Some(make_enum_transformer(cases, string_type, None)?),
    );
    let reconstituted_enum =
        builder.get_enum_type(graph.attributes(enum_type)?.clone(), cases.clone(), None)?;
    let attributes = transformation_attributes(
        builder,
        reconstituted_enum,
        transformer,
        debug_print_transformations,
    )?;
    builder.get_string_type(
        attributes,
        Some(StringTypes::unrestricted()),
        Some(forwarding_ref),
    )
}

/// `replaceNumber(t, builder, forwardingRef, debugPrintTransformations)`:
/// a number checked against its minimum and maximum.
fn replace_number(
    t: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    debug_print_transformations: bool,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let kind = graph.kind(t)?;
    let number_type = builder.get_primitive_type(kind, TypeAttributes::new(), None)?;
    let min_max = defined(min_max_value_for_type(graph, t)?)?;
    let transformer = Transformer::decoding(
        number_type,
        Some(Transformer::min_max_value(
            number_type,
            None,
            min_max.0,
            min_max.1,
        )),
    );
    let reconstituted_attributes = builder.reconstitute_type_attributes(graph.attributes(t)?)?;
    let target = builder.get_primitive_type(kind, reconstituted_attributes, None)?;
    let attributes =
        transformation_attributes(builder, target, transformer, debug_print_transformations)?;
    builder.get_primitive_type(kind, attributes, Some(forwarding_ref))
}

/// `replaceString(t, builder, forwardingRef, debugPrintTransformations)`:
/// a string checked against its minimum and maximum length.
fn replace_string(
    t: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    debug_print_transformations: bool,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let min_max = defined(min_max_length_for_type(graph, t)?)?;
    let reconstituted_attributes = builder.reconstitute_type_attributes(graph.attributes(t)?)?;
    let string_type = builder.get_string_type(
        TypeAttributes::new(),
        Some(StringTypes::unrestricted()),
        None,
    )?;
    let transformer = Transformer::decoding(
        string_type,
        Some(Transformer::min_max_length_check(
            string_type,
            None,
            min_max.0,
            min_max.1,
        )),
    );
    let target = builder.get_string_type(reconstituted_attributes, None, None)?;
    let attributes =
        transformation_attributes(builder, target, transformer, debug_print_transformations)?;
    builder.get_string_type(
        attributes,
        Some(StringTypes::unrestricted()),
        Some(forwarding_ref),
    )
}

/// `replaceTransformedStringType(t, kind, builder, forwardingRef,
/// debugPrintTransformations)`: a string parsed into the transformed kind
/// (or its target kind, e.g. `integer` for `integer-string`).
fn replace_transformed_string_type(
    t: TypeRef,
    kind: TypeKind,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    debug_print_transformations: bool,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let reconstituted_attributes = builder.reconstitute_type_attributes(graph.attributes(t)?)?;
    let target_type_kind = target_type_kind_for_transformed_string_type_kind(kind).unwrap_or(kind);
    let string_type = builder.get_string_type(
        TypeAttributes::new(),
        Some(StringTypes::unrestricted()),
        None,
    )?;
    let transformer = Transformer::decoding(
        string_type,
        Some(Transformer::parse_string(string_type, None)),
    );
    let target = builder.get_primitive_type(target_type_kind, reconstituted_attributes, None)?;
    let attributes =
        transformation_attributes(builder, target, transformer, debug_print_transformations)?;
    builder.get_string_type(
        attributes,
        Some(StringTypes::unrestricted()),
        Some(forwarding_ref),
    )
}

/// `makeTransformations(ctx, graph, targetLanguage)`.
///
/// `needs_transformer_for_type` is the target language's
/// `needsTransformerForType`; `string_type_mapping`,
/// `debug_print_reconstitution` and `debug_print_transformations` are the
/// run context's `stringTypeMapping`, `debugPrintReconstitution` and
/// `debugPrintTransformations`. Returns `None` (TypeScript: the same graph)
/// if no type needs a transformation.
pub fn make_transformations(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    needs_transformer_for_type: &dyn Fn(&TypeGraph, TypeRef) -> Result<bool>,
    debug_print_reconstitution: bool,
    debug_print_transformations: bool,
) -> Result<Option<TypeGraph>> {
    let mut transformed_types: IndexSet<TypeRef> = IndexSet::new();
    for t in graph.all_types_unordered() {
        let needs = if needs_transformer_for_type(graph, t)? {
            true
        } else if graph.kind(t)? != TypeKind::Union {
            false
        } else {
            let string_members = string_type_members(graph, t)?;
            if string_members.len() <= 1 {
                false
            } else {
                let mut some = false;
                for &m in &string_members {
                    if needs_transformer_for_type(graph, m)? {
                        some = true;
                        break;
                    }
                }
                some
            }
        };
        if needs {
            transformed_types.insert(t);
        }
    }

    let groups: Vec<Vec<TypeRef>> = transformed_types.iter().map(|&t| vec![t]).collect();
    let replacer = make_replacer(move |set_of_one, builder, forwarding_ref| {
        let t = *defined(set_of_one.first())?;
        let graph = builder.original_graph()?;
        let ty = graph.type_at(t)?;
        let kind = ty.kind();
        if ty.is_union() {
            replace_union(
                t,
                builder,
                forwarding_ref,
                &transformed_types,
                debug_print_transformations,
            )
        } else if ty.is_array() {
            replace_array(t, builder, forwarding_ref, debug_print_transformations)
        } else if ty.is_enum() {
            replace_enum(t, builder, forwarding_ref, debug_print_transformations)
        } else if kind == TypeKind::String {
            replace_string(t, builder, forwarding_ref, debug_print_transformations)
        } else if kind.is_number_type_kind() {
            replace_number(t, builder, forwarding_ref, debug_print_transformations)
        } else if kind.is_primitive_string_type_kind() {
            replace_transformed_string_type(
                t,
                kind,
                builder,
                forwarding_ref,
                debug_print_transformations,
            )
        } else {
            panic(format!("Cannot make transformation for type {kind}"))
        }
    });
    graph.rewrite(
        "make-transformations",
        string_type_mapping,
        false,
        groups,
        debug_print_reconstitution,
        replacer,
        false,
    )
}
