//! Shared code of the differential renderer tests: rebuilding a type graph
//! from the JSON dumps written by `xtask/core-rendering/*.mjs`, and running
//! name gathering and rendering on it.
//!
//! A dump lists the types in index order (`k`ind, `a`ttributes and the
//! kind's structure) and the top-levels. Every type is created at its
//! reserved index, so the rebuilt graph has the same type indexes, which
//! decide naming priorities and declaration order.
//!
//! A `transformation` attribute (C#, Python) is dumped as its target type's
//! index and its transformer tree; the format is documented at
//! `dumpTransformer` in `xtask/core-rendering/dump-transformation.mjs`.

#![allow(dead_code)]

use indexmap::{IndexMap, IndexSet};
use quicktype_core::attributes::accessor_names::AccessorEntry;
use quicktype_core::attributes::constraints::MinMaxConstraint;
use quicktype_core::attributes::default_value::DefaultValue;
use quicktype_core::attributes::string_types::StringTypes;
use quicktype_core::attributes::type_attributes::{TypeAttributeValue, TypeAttributes};
use quicktype_core::attributes::type_names::{TooManyTypeNames, TypeNames, init_type_names};
use quicktype_core::gather_names::gather_names;
use quicktype_core::language::all::{ALL, language_named};
use quicktype_core::messages::{QuickTypeError, Result};
use quicktype_core::renderer_options::{OptionValue, RendererOptions};
use quicktype_core::target_language::MultiFileRenderResult;
use quicktype_core::transformers::{DecodingChoiceCases, Transformation, Transformer};
use quicktype_core::ty::transformed_string_type::TypeKind;
use quicktype_core::ty::ty::ClassProperty;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::get_no_string_type_mapping;
use quicktype_core::ty::type_graph::TypeGraph;
use quicktype_core::ty::type_ref::TypeRef;
use serde_json::Value;
use std::rc::Rc;

pub fn err(message: impl Into<String>) -> QuickTypeError {
    QuickTypeError::internal(message)
}

fn str_of(v: &Value) -> Result<&str> {
    v.as_str()
        .ok_or_else(|| err(format!("expected a string, got {v}")))
}

fn array_of(v: &Value) -> Result<&Vec<Value>> {
    v.as_array()
        .ok_or_else(|| err(format!("expected an array, got {v}")))
}

fn strings(v: &Value) -> Result<IndexSet<String>> {
    array_of(v)?
        .iter()
        .map(|s| Ok(str_of(s)?.to_owned()))
        .collect()
}

fn number(v: &Value) -> Result<f64> {
    v.as_f64()
        .ok_or_else(|| err(format!("expected a number, got {v}")))
}

fn index(v: &Value) -> Result<usize> {
    v.as_u64()
        .map(|n| n as usize)
        .ok_or_else(|| err(format!("expected an index, got {v}")))
}

fn accessor_entry(v: &Value) -> Result<AccessorEntry> {
    if let Some(s) = v.as_str() {
        return Ok(AccessorEntry::Name(s.to_owned()));
    }
    let mut by_language = IndexMap::new();
    for pair in array_of(v)? {
        let pair = array_of(pair)?;
        by_language.insert(str_of(&pair[0])?.to_owned(), str_of(&pair[1])?.to_owned());
    }
    Ok(AccessorEntry::ByLanguage(by_language))
}

fn accessor_names(v: &Value) -> Result<IndexMap<String, AccessorEntry>> {
    let mut result = IndexMap::new();
    for pair in array_of(v)? {
        let pair = array_of(pair)?;
        result.insert(str_of(&pair[0])?.to_owned(), accessor_entry(&pair[1])?);
    }
    Ok(result)
}

fn min_max(v: &Value) -> Result<MinMaxConstraint> {
    let pair = array_of(v)?;
    let side = |x: &Value| -> Result<Option<f64>> {
        if x.is_null() {
            Ok(None)
        } else {
            Ok(Some(number(x)?))
        }
    };
    Ok(MinMaxConstraint(side(&pair[0])?, side(&pair[1])?))
}

fn kind_of(name: &str) -> Result<TypeKind> {
    TypeKind::from_str(name).ok_or_else(|| err(format!("unknown kind {name}")))
}

/// The type at a dumped index.
fn type_ref_at(v: &Value, refs: &[TypeRef]) -> Result<TypeRef> {
    let i = index(v)?;
    refs.get(i)
        .copied()
        .ok_or_else(|| err(format!("type index {i} out of range")))
}

fn optional_number(v: &Value) -> Result<Option<f64>> {
    if v.is_null() {
        Ok(None)
    } else {
        Ok(Some(number(v)?))
    }
}

/// A dumped transformer, or `None` for `null`.
fn optional_transformer(v: &Value, refs: &[TypeRef]) -> Result<Option<Rc<Transformer>>> {
    if v.is_null() {
        Ok(None)
    } else {
        Ok(Some(transformer(v, refs)?))
    }
}

/// A dumped transformer tree (`dumpTransformer` in `dump-transformation.mjs`).
pub fn transformer(v: &Value, refs: &[TypeRef]) -> Result<Rc<Transformer>> {
    let source = type_ref_at(&v["s"], refs)?;
    let consumer = || optional_transformer(&v["c"], refs);
    let child = || transformer(&v["x"], refs);
    Ok(match str_of(&v["k"])? {
        "decode" => Transformer::decoding(source, consumer()?),
        "encode" => Transformer::encoding(source),
        "decode-array" => Transformer::array_decoding(
            source,
            consumer()?,
            type_ref_at(&v["item"], refs)?,
            child()?,
        ),
        "encode-array" => {
            Transformer::array_encoding(source, type_ref_at(&v["item"], refs)?, child()?)
        }
        "choice" => Transformer::choice(
            source,
            array_of(&v["xs"])?
                .iter()
                .map(|x| transformer(x, refs))
                .collect::<Result<_>>()?,
        )?,
        "decoding-choice" => {
            let case = |key: &str| optional_transformer(&v[key], refs);
            Transformer::decoding_choice(
                source,
                DecodingChoiceCases {
                    null: case("null")?,
                    integer: case("integer")?,
                    double: case("double")?,
                    bool: case("bool")?,
                    string: case("string")?,
                    array: case("array")?,
                    object: case("object")?,
                },
            )
        }
        "union-member-match" => {
            Transformer::union_member_match(source, child()?, type_ref_at(&v["member"], refs)?)
        }
        "string-match" => {
            Transformer::string_match(source, child()?, str_of(&v["case"])?.to_owned())
        }
        "union-instantiation" => Transformer::union_instantiation(source),
        "string-producer" => {
            Transformer::string_producer(source, consumer()?, str_of(&v["result"])?.to_owned())
        }
        "parse-string" => Transformer::parse_string(source, consumer()?),
        "stringify" => Transformer::stringify(source, consumer()?),
        "min-max-length-check" => Transformer::min_max_length_check(
            source,
            consumer()?,
            optional_number(&v["min"])?,
            optional_number(&v["max"])?,
        ),
        "min-max-value-check" => Transformer::min_max_value(
            source,
            consumer()?,
            optional_number(&v["min"])?,
            optional_number(&v["max"])?,
        ),
        other => return Err(err(format!("unknown transformer {other}"))),
    })
}

/// The attributes of a dumped type that has no `transformation` attribute
/// (which refers to other types; see [`attributes_in_graph`]).
pub fn attributes(v: &Value) -> Result<TypeAttributes> {
    if v.get("transformation").is_some() {
        return Err(err(
            "a transformation attribute refers to other types by index: \
             rebuild it with attributes_in_graph and the graph's type refs",
        ));
    }
    attributes_in_graph(v, &[])
}

/// The attributes of a dumped type in a graph whose types are `refs` (in
/// index order); a `transformation` refers to types by index.
pub fn attributes_in_graph(v: &Value, refs: &[TypeRef]) -> Result<TypeAttributes> {
    let mut result = TypeAttributes::new();
    let Some(object) = v.as_object() else {
        return Ok(result);
    };
    for (kind, value) in object {
        let attribute = match kind.as_str() {
            "names" => {
                let distance = index(&value["d"])? as u32;
                let names = match str_of(&value["t"])? {
                    "regular" => {
                        let alternatives = if value["alts"].is_null() {
                            None
                        } else {
                            Some(strings(&value["alts"])?)
                        };
                        TypeNames::make_with_distance(
                            strings(&value["names"])?,
                            alternatives,
                            distance,
                        )
                    }
                    _ => TypeNames::TooMany(TooManyTypeNames::new(
                        distance,
                        Some(str_of(&value["name"])?.to_owned()),
                    )),
                };
                TypeAttributeValue::Names(Rc::new(names))
            }
            "description" => TypeAttributeValue::Description(Rc::new(strings(value)?)),
            "propertyDescriptions" => {
                let mut map = IndexMap::new();
                for pair in array_of(value)? {
                    let pair = array_of(pair)?;
                    map.insert(str_of(&pair[0])?.to_owned(), strings(&pair[1])?);
                }
                TypeAttributeValue::PropertyDescriptions(Rc::new(map))
            }
            "accessorNames" => TypeAttributeValue::AccessorNames(Rc::new(accessor_names(value)?)),
            "enumValues" => TypeAttributeValue::EnumValues(Rc::new(accessor_names(value)?)),
            "unionIdentifier" => TypeAttributeValue::UnionIdentifier(Rc::new(
                array_of(value)?
                    .iter()
                    .map(|n| Ok(index(n)? as u32))
                    .collect::<Result<_>>()?,
            )),
            "unionMemberNames" => {
                let mut map = IndexMap::new();
                for pair in array_of(value)? {
                    let pair = array_of(pair)?;
                    map.insert(index(&pair[0])? as u32, accessor_entry(&pair[1])?);
                }
                TypeAttributeValue::UnionMemberNames(Rc::new(map))
            }
            "minMax" => TypeAttributeValue::MinMax(min_max(value)?),
            "minMaxLength" => TypeAttributeValue::MinMaxLength(min_max(value)?),
            "minMaxItems" => TypeAttributeValue::MinMaxItems(min_max(value)?),
            "pattern" => TypeAttributeValue::Pattern(Rc::new(str_of(value)?.to_owned())),
            "defaultValue" => TypeAttributeValue::DefaultValue(match value {
                Value::Null => DefaultValue::Null,
                Value::Bool(b) => DefaultValue::Bool(*b),
                Value::Number(_) => DefaultValue::Number(number(value)?),
                Value::String(s) => DefaultValue::String(s.clone()),
                _ => return Err(err("unsupported default value")),
            }),
            "stringTypes" => {
                let cases = if value["cases"].is_null() {
                    None
                } else {
                    let mut cases = IndexMap::new();
                    for pair in array_of(&value["cases"])? {
                        let pair = array_of(pair)?;
                        cases.insert(str_of(&pair[0])?.to_owned(), index(&pair[1])? as u64);
                    }
                    Some(cases)
                };
                let transformations = array_of(&value["tx"])?
                    .iter()
                    .map(|k| kind_of(str_of(k)?))
                    .collect::<Result<_>>()?;
                TypeAttributeValue::StringTypes(Rc::new(StringTypes {
                    cases,
                    transformations,
                }))
            }
            "uriAttributes" => {
                let pair = array_of(value)?;
                TypeAttributeValue::UriAttributes(Rc::new((strings(&pair[0])?, strings(&pair[1])?)))
            }
            "transformation" => TypeAttributeValue::Transformation(Rc::new(Transformation::new(
                type_ref_at(&value["target"], refs)?,
                transformer(&value["xfer"], refs)?,
            ))),
            other => return Err(err(format!("unknown attribute {other}"))),
        };
        result.insert(attribute);
    }
    Ok(result)
}

fn properties(v: &Value, refs: &[TypeRef]) -> Result<IndexMap<String, ClassProperty>> {
    let mut result = IndexMap::new();
    for p in array_of(v)? {
        let p = array_of(p)?;
        let t = refs[index(&p[1])?];
        let optional = p[2].as_bool().unwrap_or(false);
        result.insert(str_of(&p[0])?.to_owned(), ClassProperty::new(t, optional));
    }
    Ok(result)
}

/// Rebuilds the dumped graph with the same type indexes.
pub fn build_graph(dump: &Value) -> Result<TypeGraph> {
    let types = array_of(&dump["types"])?;
    let mut b = TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false)?;
    let refs: Vec<TypeRef> = (0..types.len())
        .map(|_| b.reserve_type_ref())
        .collect::<Result<_>>()?;

    for (i, t) in types.iter().enumerate() {
        let kind = kind_of(str_of(&t["k"])?)?;
        let attrs = attributes_in_graph(&t["a"], &refs)?;
        let fwd = Some(refs[i]);
        let fixed = t["fixed"].as_bool().unwrap_or(false);
        let r = match kind {
            TypeKind::Enum => b.get_enum_type(attrs, strings(&t["cases"])?, fwd)?,
            TypeKind::Array => b.get_unique_array_type(attrs, fwd)?,
            TypeKind::Class => b.get_unique_class_type(attrs, fixed, None, fwd)?,
            TypeKind::Object => b.get_unique_object_type(attrs, None, None, fwd)?,
            TypeKind::Map => {
                let r = b.get_unique_map_type(fwd)?;
                b.add_attributes(r, &attrs)?;
                r
            }
            TypeKind::Union => b.get_unique_union_type(attrs, None, fwd)?,
            TypeKind::Intersection => b.get_unique_intersection_type(attrs, None, fwd)?,
            _ => b.get_primitive_type(kind, attrs, fwd)?,
        };
        if r != refs[i] {
            return Err(err(format!("type {i} was not created at its index")));
        }
    }

    for (i, t) in types.iter().enumerate() {
        let r = refs[i];
        match kind_of(str_of(&t["k"])?)? {
            TypeKind::Array => b.set_array_items(r, refs[index(&t["items"])?])?,
            TypeKind::Class | TypeKind::Object | TypeKind::Map => {
                let additional = if t["add"].is_null() {
                    None
                } else {
                    Some(refs[index(&t["add"])?])
                };
                b.set_object_properties(r, properties(&t["props"], &refs)?, additional)?;
            }
            TypeKind::Union | TypeKind::Intersection => {
                let members = array_of(&t["members"])?
                    .iter()
                    .map(|m| Ok(refs[index(m)?]))
                    .collect::<Result<_>>()?;
                b.set_set_operation_members(r, members)?;
            }
            _ => {}
        }
    }

    for top in array_of(&dump["topLevels"])? {
        let top = array_of(top)?;
        b.add_top_level(str_of(&top[0])?, refs[index(&top[1])?])?;
    }
    b.finish()
}

/// Renderer options from a JSON object of strings and booleans.
pub fn renderer_options(v: &Value) -> Result<RendererOptions> {
    let mut options = RendererOptions::new();
    if let Some(object) = v.as_object() {
        for (k, value) in object {
            let value = match value {
                Value::Null => OptionValue::Null,
                Value::Bool(b) => OptionValue::Bool(*b),
                Value::String(s) => OptionValue::String(s.clone()),
                other => OptionValue::String(other.to_string()),
            };
            options.set(k.clone(), value);
        }
    }
    Ok(options)
}

/// Runs name gathering (after drawing `random_names` random names, as the
/// reference had by then) and renders like `renderGraphAndSerialize`.
pub fn gather_and_render(
    graph: &mut TypeGraph,
    gather: &Value,
    render: &Value,
) -> Result<MultiFileRenderResult> {
    init_type_names();
    for _ in 0..gather["randomNames"].as_u64().unwrap_or(0) {
        let _ = TooManyTypeNames::new(0, None);
    }
    let destructive = gather["destructive"].as_bool().unwrap_or(false);
    gather_names(graph, destructive, false)?;
    render_graph(graph, render)
}

/// `renderGraphAndSerialize` with the recorded arguments.
pub fn render_graph(graph: &TypeGraph, render: &Value) -> Result<MultiFileRenderResult> {
    let lang = str_of(&render["lang"])?;
    let language =
        language_named(lang, &ALL).ok_or_else(|| err(format!("unknown language {lang}")))?;
    let options = renderer_options(&render["rendererOptions"])?;
    let indentation = render["indentation"].as_str();
    language.render_graph_and_serialize(
        graph,
        str_of(&render["filename"])?,
        render["alphabetize"].as_bool().unwrap_or(false),
        None,
        &options,
        indentation,
    )
}

/// The first line where `actual` differs from `expected`, for reports.
pub fn first_difference(expected: &str, actual: &str) -> String {
    let e: Vec<&str> = expected.split('\n').collect();
    let a: Vec<&str> = actual.split('\n').collect();
    for i in 0..e.len().max(a.len()) {
        let x = e.get(i).copied();
        let y = a.get(i).copied();
        if x != y {
            return format!(
                "line {}:\n    expected: {:?}\n    actual:   {:?}",
                i + 1,
                x.unwrap_or("<end>"),
                y.unwrap_or("<end>")
            );
        }
    }
    "identical".to_owned()
}
