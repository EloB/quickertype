//! Port of `packages/quicktype-core/src/attributes/Constraints.ts`.
//!
//! The JSON Schema constraints `minimum`/`maximum`, `minLength`/`maxLength`,
//! `minItems`/`maxItems` and `pattern`. All of them are part of a type's
//! identity. The schema attribute producers (`minMaxAttributeProducer`, ...)
//! and `addToSchema` belong with the JSON Schema input and output and are
//! ported there.

use crate::attributes::type_attributes::AttributeKind;
use crate::messages::{ErrorKind, MessageValue, Result, message_error};
use crate::support::collection_utils::{HASH_CODE_INIT, JsEquals, JsHash, add_hash_code};
use crate::support::js_shim;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `MinMaxConstraint`: `[min, max]`, either side possibly `undefined`.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct MinMaxConstraint(pub Option<f64>, pub Option<f64>);

impl JsHash for MinMaxConstraint {
    /// Hashed as the two-element array it is in TypeScript.
    fn hash_code(&self) -> i64 {
        let h = add_hash_code(HASH_CODE_INIT, self.0.hash_code());
        add_hash_code(h, self.1.hash_code())
    }
}

impl JsEquals for MinMaxConstraint {
    fn js_equals(&self, other: &Self) -> bool {
        self.0.js_equals(&other.0) && self.1.js_equals(&other.1)
    }
}

/// `minMaxTypeAttributeKind`: `minimum`/`maximum` of numbers.
#[derive(Clone, Copy, Debug, Default)]
pub struct MinMaxTypeAttributeKind;

/// `minMaxLengthTypeAttributeKind`: `minLength`/`maxLength` of strings.
#[derive(Clone, Copy, Debug, Default)]
pub struct MinMaxLengthTypeAttributeKind;

/// `minMaxItemsTypeAttributeKind`: `minItems`/`maxItems` of arrays.
#[derive(Clone, Copy, Debug, Default)]
pub struct MinMaxItemsTypeAttributeKind;

/// `patternTypeAttributeKind`: `pattern` of strings.
#[derive(Clone, Copy, Debug, Default)]
pub struct PatternTypeAttributeKind;

/// The type kinds a min/max attribute is written to JSON Schema for, and
/// the schema property names (`MinMaxConstraintTypeAttributeKind`'s
/// constructor arguments).
pub fn min_max_schema_info(
    kind: crate::attributes::type_attributes::TypeAttributeKind,
) -> Option<(&'static [TypeKind], &'static str, &'static str)> {
    use crate::attributes::type_attributes::TypeAttributeKind as K;
    match kind {
        K::MinMax => Some((&[TypeKind::Integer, TypeKind::Double], "minimum", "maximum")),
        K::MinMaxLength => Some((&[TypeKind::String], "minLength", "maxLength")),
        K::MinMaxItems => Some((&[TypeKind::Array], "minItems", "maxItems")),
        _ => None,
    }
}

/// JavaScript `Math.min(a, b)`.
fn js_min(a: f64, b: f64) -> f64 {
    if a.is_nan() || b.is_nan() {
        f64::NAN
    } else if a == b {
        // Math.min(0, -0) is -0.
        if a.is_sign_negative() { a } else { b }
    } else {
        a.min(b)
    }
}

/// JavaScript `Math.max(a, b)`.
fn js_max(a: f64, b: f64) -> f64 {
    if a.is_nan() || b.is_nan() {
        f64::NAN
    } else if a == b {
        // Math.max(0, -0) is 0.
        if a.is_sign_negative() { b } else { a }
    } else {
        a.max(b)
    }
}

/// `checkMinMaxConstraint(minmax)`.
fn check_min_max_constraint(minmax: MinMaxConstraint) -> Result<Option<MinMaxConstraint>> {
    let MinMaxConstraint(min, max) = minmax;
    if let (Some(min), Some(max)) = (min, max)
        && min > max
    {
        return message_error(
            ErrorKind::MiscInvalidMinMaxConstraint,
            vec![
                ("min", MessageValue::Number(min)),
                ("max", MessageValue::Number(max)),
            ],
        );
    }
    if min.is_none() && max.is_none() {
        return Ok(None);
    }
    Ok(Some(minmax))
}

/// `MinMaxConstraintTypeAttributeKind.combine`: the loosest bounds; an
/// unbounded side stays unbounded.
pub(crate) fn combine_min_max(arr: &[MinMaxConstraint]) -> Result<Option<MinMaxConstraint>> {
    let Some(&MinMaxConstraint(mut min, mut max)) = arr.first() else {
        return crate::support::support::panic("Assertion failed");
    };
    for &MinMaxConstraint(other_min, other_max) in &arr[1..] {
        min = match (min, other_min) {
            (Some(a), Some(b)) => Some(js_min(a, b)),
            _ => None,
        };
        max = match (max, other_max) {
            (Some(a), Some(b)) => Some(js_max(a, b)),
            _ => None,
        };
    }
    check_min_max_constraint(MinMaxConstraint(min, max))
}

/// `MinMaxConstraintTypeAttributeKind.intersect`: the tightest bounds; an
/// unbounded side adopts the other's bound.
pub(crate) fn intersect_min_max(arr: &[MinMaxConstraint]) -> Result<Option<MinMaxConstraint>> {
    let Some(&MinMaxConstraint(mut min, mut max)) = arr.first() else {
        return crate::support::support::panic("Assertion failed");
    };
    for &MinMaxConstraint(other_min, other_max) in &arr[1..] {
        min = match (min, other_min) {
            (Some(a), Some(b)) => Some(js_max(a, b)),
            (None, other) => other,
            (Some(a), None) => Some(a),
        };
        max = match (max, other_max) {
            (Some(a), Some(b)) => Some(js_min(a, b)),
            (None, other) => other,
            (Some(a), None) => Some(a),
        };
    }
    check_min_max_constraint(MinMaxConstraint(min, max))
}

/// `stringify([min, max])`: `${min}-${max}`.
pub(crate) fn stringify_min_max(c: &MinMaxConstraint) -> String {
    let side = |x: Option<f64>| x.map_or_else(|| "undefined".to_owned(), js_shim::number_to_string);
    format!("{}-{}", side(c.0), side(c.1))
}

/// `PatternTypeAttributeKind.combine`: `(p1)|(p2)|...`.
pub(crate) fn combine_patterns(arr: &[&String]) -> String {
    arr.iter()
        .map(|p| format!("({p})"))
        .collect::<Vec<_>>()
        .join("|")
}

/// `minMaxValueForType(t)`.
pub fn min_max_value_for_type(graph: &TypeGraph, t: TypeRef) -> Result<Option<MinMaxConstraint>> {
    Ok(MinMaxTypeAttributeKind
        .try_get_in_attributes(graph.attributes(t)?)
        .copied())
}

/// `minMaxLengthForType(t)`.
pub fn min_max_length_for_type(graph: &TypeGraph, t: TypeRef) -> Result<Option<MinMaxConstraint>> {
    Ok(MinMaxLengthTypeAttributeKind
        .try_get_in_attributes(graph.attributes(t)?)
        .copied())
}

/// `minMaxItemsForType(t)`.
pub fn min_max_items_for_type(graph: &TypeGraph, t: TypeRef) -> Result<Option<MinMaxConstraint>> {
    Ok(MinMaxItemsTypeAttributeKind
        .try_get_in_attributes(graph.attributes(t)?)
        .copied())
}

/// `patternForType(t)`.
pub fn pattern_for_type(graph: &TypeGraph, t: TypeRef) -> Result<Option<String>> {
    Ok(PatternTypeAttributeKind
        .try_get_in_attributes(graph.attributes(t)?)
        .cloned())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn combine_loosens_and_intersect_tightens() {
        let a = MinMaxConstraint(Some(1.0), Some(5.0));
        let b = MinMaxConstraint(Some(3.0), None);
        assert_eq!(
            combine_min_max(&[a, b]).unwrap(),
            Some(MinMaxConstraint(Some(1.0), None))
        );
        assert_eq!(
            intersect_min_max(&[a, b]).unwrap(),
            Some(MinMaxConstraint(Some(3.0), Some(5.0)))
        );
        let c = MinMaxConstraint(None, Some(2.0));
        assert_eq!(combine_min_max(&[b, c]).unwrap(), None);
    }

    #[test]
    fn invalid_constraints_are_errors() {
        let a = MinMaxConstraint(Some(5.0), None);
        let b = MinMaxConstraint(None, Some(2.5));
        let e = intersect_min_max(&[a, b]).unwrap_err();
        assert_eq!(e.user_message(), "Invalid min-max constraint: 5-2.5");
    }

    #[test]
    fn stringify_and_hash() {
        assert_eq!(
            stringify_min_max(&MinMaxConstraint(Some(1.0), None)),
            "1-undefined"
        );
        let h = MinMaxConstraint(Some(1.0), None).hash_code();
        assert_eq!(h, add_hash_code(add_hash_code(17, 1), 17));
        assert_eq!(
            combine_patterns(&[&"a".to_owned(), &"b+".to_owned()]),
            "(a)|(b+)"
        );
    }
}
