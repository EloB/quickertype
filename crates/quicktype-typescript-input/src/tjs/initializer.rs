//! Class property initializers as default values.
//!
//! typescript-json-schema evaluates an initializer's source text in a `vm2`
//! sandbox (`new VM().run("sandboxvar=" + initial.getText())`) and keeps the
//! result when it is `null`, a string, a number, a boolean or an array. This
//! evaluates the initializer's syntax tree instead, with JavaScript's
//! semantics, for the expressions that need no environment:
//!
//! - literals (numbers, strings, `true`/`false`/`null`, template literals
//!   with substitutions), array and object literals, and the globals
//!   `undefined`, `NaN` and `Infinity`;
//! - unary `+ - ! ~`, `typeof` and `void`;
//! - binary arithmetic (`+ - * / % **`, with string concatenation), relational
//!   (`< > <= >=`), equality (`== != === !==`), bitwise (`& | ^`), shift
//!   (`<< >> >>>`), logical (`&& || ??`) and comma operators;
//! - parentheses and the conditional operator.
//!
//! Anything else, such as a reference to another binding or a call, is an
//! evaluation error, which typescript-json-schema reports as `exception
//! evaluating initializer`. Function and class expressions, regular
//! expressions and bigints evaluate to opaque values whose `String()` is
//! their source text. Conversions follow ECMAScript (`ToNumber`,
//! `ToPrimitive`, `ToInt32`, `IsLooselyEqual`).

use std::cmp::Ordering;

use crate::js::{self, Value};
use crate::tsc::ast::Node;
use crate::tsc::generated::syntax_kind as sk;

type Eval = Result<Value, ()>;

fn child(node: &Node, name: &str) -> Result<Node, ()> {
    node.named(name).ok_or(())
}

/// Evaluates an initializer expression.
pub fn evaluate(node: &Node) -> Eval {
    match node.kind() {
        sk::NumericLiteral => Ok(Value::Number(numeric_literal(&node.text().ok_or(())?)?)),
        sk::StringLiteral | sk::NoSubstitutionTemplateLiteral => {
            Ok(Value::String(node.text().ok_or(())?))
        }
        sk::BigIntLiteral => {
            let text = node.text().ok_or(())?;
            Ok(Value::Opaque(text.trim_end_matches('n').to_owned()))
        }
        sk::RegularExpressionLiteral => Ok(Value::Opaque(node.get_text())),
        sk::TemplateExpression => {
            let mut out = child(node, "head")?.text().ok_or(())?;
            for span in node.named_list("templateSpans") {
                out.push_str(&evaluate(&child(&span, "expression")?)?.to_js_string());
                out.push_str(&child(&span, "literal")?.text().ok_or(())?);
            }
            Ok(Value::String(out))
        }
        sk::TrueKeyword => Ok(Value::Bool(true)),
        sk::FalseKeyword => Ok(Value::Bool(false)),
        sk::NullKeyword => Ok(Value::Null),
        sk::Identifier => match node.text().as_deref() {
            Some("undefined") => Ok(Value::Undefined),
            Some("NaN") => Ok(Value::Number(f64::NAN)),
            Some("Infinity") => Ok(Value::Number(f64::INFINITY)),
            _ => Err(()),
        },
        sk::ParenthesizedExpression => evaluate(&child(node, "expression")?),
        sk::ArrayLiteralExpression => {
            let mut items = Vec::new();
            for e in node.named_list("elements") {
                if e.kind() == sk::OmittedExpression {
                    items.push(Value::Undefined);
                } else {
                    items.push(evaluate(&e)?);
                }
            }
            Ok(Value::array(items))
        }
        sk::ObjectLiteralExpression => {
            let obj = Value::object();
            for p in node.named_list("properties") {
                if p.kind() != sk::PropertyAssignment {
                    return Err(());
                }
                let name = child(&p, "name")?;
                let key = match name.kind() {
                    sk::Identifier | sk::StringLiteral => name.text().ok_or(())?,
                    sk::NumericLiteral => {
                        js::number_to_string(numeric_literal(&name.text().ok_or(())?)?)
                    }
                    _ => return Err(()),
                };
                let value = evaluate(&child(&p, "initializer")?)?;
                obj.borrow_mut().define(&key, value);
            }
            Ok(Value::Object(obj))
        }
        sk::PrefixUnaryExpression => {
            let operand = evaluate(&child(node, "operand")?)?;
            Ok(match node.operator().ok_or(())? {
                sk::MinusToken => Value::Number(-to_number(&operand)),
                sk::PlusToken => Value::Number(to_number(&operand)),
                sk::ExclamationToken => Value::Bool(!operand.truthy()),
                sk::TildeToken => Value::Number(f64::from(!to_int32(to_number(&operand)))),
                _ => return Err(()),
            })
        }
        sk::TypeOfExpression => {
            let operand = child(node, "expression")?;
            // `typeof` of an unresolvable name is "undefined", not an error.
            let value = match evaluate(&operand) {
                Ok(v) => v,
                Err(()) if operand.kind() == sk::Identifier => Value::Undefined,
                Err(()) => return Err(()),
            };
            Ok(Value::str(value.type_of()))
        }
        sk::VoidExpression => {
            evaluate(&child(node, "expression")?)?;
            Ok(Value::Undefined)
        }
        sk::BinaryExpression => {
            let op = child(node, "operatorToken")?.kind();
            let left = evaluate(&child(node, "left")?)?;
            let right = || evaluate(&child(node, "right")?);
            match op {
                sk::AmpersandAmpersandToken => {
                    if left.truthy() {
                        right()
                    } else {
                        Ok(left)
                    }
                }
                sk::BarBarToken => {
                    if left.truthy() {
                        Ok(left)
                    } else {
                        right()
                    }
                }
                sk::QuestionQuestionToken => {
                    if matches!(left, Value::Null | Value::Undefined) {
                        right()
                    } else {
                        Ok(left)
                    }
                }
                sk::CommaToken => right(),
                _ => binary(op, &left, &right()?),
            }
        }
        sk::ConditionalExpression => {
            let cond = evaluate(&child(node, "condition")?)?;
            evaluate(&child(
                node,
                if cond.truthy() {
                    "whenTrue"
                } else {
                    "whenFalse"
                },
            )?)
        }
        sk::ArrowFunction | sk::FunctionExpression | sk::ClassExpression => {
            Ok(Value::Opaque(node.get_text()))
        }
        _ => Err(()),
    }
}

/// `ToPrimitive`: arrays and objects become strings (their `toString`).
fn to_primitive(v: &Value) -> Value {
    match v {
        Value::Array(_) | Value::Object(_) | Value::Opaque(_) => Value::String(v.to_js_string()),
        v => v.clone(),
    }
}

/// `ToNumber`.
fn to_number(v: &Value) -> f64 {
    match v {
        Value::Number(n) => *n,
        Value::Bool(b) => f64::from(u8::from(*b)),
        Value::Null => 0.0,
        Value::Undefined => f64::NAN,
        Value::String(s) => string_to_number(s),
        Value::Array(_) | Value::Object(_) | Value::Opaque(_) => to_number(&to_primitive(v)),
    }
}

/// `StringToNumber`: trimmed; empty is 0; an optionally signed decimal
/// literal or `Infinity`, or an unsigned `0x`/`0o`/`0b` literal; else NaN.
/// Numeric separators are not allowed.
fn string_to_number(s: &str) -> f64 {
    let t = js::trim(s);
    if t.is_empty() {
        return 0.0;
    }
    for (prefix, radix) in [("0x", 16), ("0o", 8), ("0b", 2)] {
        if t.len() > 2 && t.get(..2).is_some_and(|p| p.eq_ignore_ascii_case(prefix)) {
            let mut v = 0f64;
            for c in t[2..].chars() {
                match c.to_digit(radix) {
                    Some(d) => v = v * f64::from(radix) + f64::from(d),
                    None => return f64::NAN,
                }
            }
            return v;
        }
    }
    let (sign, body) = match t.as_bytes()[0] {
        b'+' => (1.0, &t[1..]),
        b'-' => (-1.0, &t[1..]),
        _ => (1.0, t),
    };
    if body == "Infinity" {
        return sign * f64::INFINITY;
    }
    if is_decimal_literal(body) {
        body.parse::<f64>().map_or(f64::NAN, |v| sign * v)
    } else {
        f64::NAN
    }
}

/// `StrUnsignedDecimalLiteral` without `Infinity`: digits with an optional
/// fraction (either side may be empty, not both) and exponent.
fn is_decimal_literal(s: &str) -> bool {
    let b = s.as_bytes();
    let mut i = 0;
    let int_start = i;
    while i < b.len() && b[i].is_ascii_digit() {
        i += 1;
    }
    let mut digits = i - int_start;
    if i < b.len() && b[i] == b'.' {
        i += 1;
        let frac = i;
        while i < b.len() && b[i].is_ascii_digit() {
            i += 1;
        }
        digits += i - frac;
    }
    if digits == 0 {
        return false;
    }
    if i < b.len() && (b[i] == b'e' || b[i] == b'E') {
        i += 1;
        if i < b.len() && (b[i] == b'+' || b[i] == b'-') {
            i += 1;
        }
        let exp = i;
        while i < b.len() && b[i].is_ascii_digit() {
            i += 1;
        }
        if i == exp {
            return false;
        }
    }
    i == b.len()
}

/// `ToInt32`.
fn to_int32(x: f64) -> i32 {
    to_uint32(x) as i32
}

/// `ToUint32`.
fn to_uint32(x: f64) -> u32 {
    if !x.is_finite() {
        return 0;
    }
    x.trunc().rem_euclid(4_294_967_296.0) as u64 as u32
}

/// `IsLooselyEqual` (`==`).
fn loosely_equal(l: &Value, r: &Value) -> bool {
    match (l, r) {
        (Value::Null | Value::Undefined, Value::Null | Value::Undefined) => true,
        (Value::Null | Value::Undefined, _) | (_, Value::Null | Value::Undefined) => false,
        (
            Value::Array(_) | Value::Object(_) | Value::Opaque(_),
            Value::Array(_) | Value::Object(_) | Value::Opaque(_),
        ) => l.strict_equals(r),
        (Value::Array(_) | Value::Object(_) | Value::Opaque(_), _) => {
            loosely_equal(&to_primitive(l), r)
        }
        (_, Value::Array(_) | Value::Object(_) | Value::Opaque(_)) => {
            loosely_equal(l, &to_primitive(r))
        }
        (Value::String(a), Value::String(b)) => a == b,
        (Value::Bool(a), Value::Bool(b)) => a == b,
        _ => to_number(l) == to_number(r),
    }
}

/// `IsLessThan` after `ToPrimitive`: strings by UTF-16 units, else numbers.
fn compare(l: &Value, r: &Value) -> Option<Ordering> {
    match (to_primitive(l), to_primitive(r)) {
        (Value::String(a), Value::String(b)) => Some(js::compare_utf16(&a, &b)),
        (a, b) => to_number(&a).partial_cmp(&to_number(&b)),
    }
}

fn binary(op: u32, l: &Value, r: &Value) -> Eval {
    let num = |f: fn(f64, f64) -> f64| Ok(Value::Number(f(to_number(l), to_number(r))));
    let int = |f: fn(i32, u32) -> f64| {
        Ok(Value::Number(f(
            to_int32(to_number(l)),
            to_uint32(to_number(r)),
        )))
    };
    let cmp = |f: fn(Ordering) -> bool| Ok(Value::Bool(compare(l, r).is_some_and(f)));
    match op {
        sk::PlusToken => {
            let (pl, pr) = (to_primitive(l), to_primitive(r));
            if matches!(pl, Value::String(_)) || matches!(pr, Value::String(_)) {
                Ok(Value::String(format!(
                    "{}{}",
                    pl.to_js_string(),
                    pr.to_js_string()
                )))
            } else {
                Ok(Value::Number(to_number(&pl) + to_number(&pr)))
            }
        }
        sk::MinusToken => num(|a, b| a - b),
        sk::AsteriskToken => num(|a, b| a * b),
        sk::SlashToken => num(|a, b| a / b),
        sk::PercentToken => num(|a, b| a % b),
        sk::AsteriskAsteriskToken => num(quicktype_js_compat::number::pow),
        sk::LessThanToken => cmp(|o| o == Ordering::Less),
        sk::GreaterThanToken => cmp(|o| o == Ordering::Greater),
        sk::LessThanEqualsToken => cmp(|o| o != Ordering::Greater),
        sk::GreaterThanEqualsToken => cmp(|o| o != Ordering::Less),
        sk::EqualsEqualsToken => Ok(Value::Bool(loosely_equal(l, r))),
        sk::ExclamationEqualsToken => Ok(Value::Bool(!loosely_equal(l, r))),
        sk::EqualsEqualsEqualsToken => Ok(Value::Bool(l.strict_equals(r))),
        sk::ExclamationEqualsEqualsToken => Ok(Value::Bool(!l.strict_equals(r))),
        sk::AmpersandToken => int(|a, b| f64::from(a & b as i32)),
        sk::BarToken => int(|a, b| f64::from(a | b as i32)),
        sk::CaretToken => int(|a, b| f64::from(a ^ b as i32)),
        sk::LessThanLessThanToken => int(|a, b| f64::from(a.wrapping_shl(b & 31))),
        sk::GreaterThanGreaterThanToken => int(|a, b| f64::from(a >> (b & 31))),
        sk::GreaterThanGreaterThanGreaterThanToken => Ok(Value::Number(f64::from(
            to_uint32(to_number(l)) >> (to_uint32(to_number(r)) & 31),
        ))),
        _ => Err(()),
    }
}

/// The value of a JavaScript numeric literal's text (separators allowed).
fn numeric_literal(text: &str) -> Result<f64, ()> {
    let t: String = text.chars().filter(|c| *c != '_').collect();
    let v = string_to_number(&t);
    if v.is_nan() || t.starts_with(['+', '-']) || t.contains("Infinity") {
        return Err(());
    }
    Ok(v)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn numeric_literals() {
        assert_eq!(numeric_literal("42"), Ok(42.0));
        assert_eq!(numeric_literal("1_000"), Ok(1000.0));
        assert_eq!(numeric_literal("0x1F"), Ok(31.0));
        assert_eq!(numeric_literal("0b101"), Ok(5.0));
        assert_eq!(numeric_literal(".5e1"), Ok(5.0));
        assert_eq!(numeric_literal("5."), Ok(5.0));
        assert!(numeric_literal("abc").is_err());
    }

    #[test]
    fn string_to_number_follows_ecmascript() {
        let cases = [
            ("0x10", 16.0),
            (" 12 ", 12.0),
            ("", 0.0),
            ("  ", 0.0),
            ("-Infinity", f64::NEG_INFINITY),
            ("+5", 5.0),
            ("0b11", 3.0),
            ("1e3", 1000.0),
            (".5", 0.5),
            ("5.", 5.0),
            ("\n7\t", 7.0),
            ("0O17", 15.0),
            ("\u{a0}12", 12.0),
        ];
        for (s, n) in cases {
            assert_eq!(string_to_number(s), n, "{s:?}");
        }
        for s in ["1_000", "-0x10", "12px", "1e", ".", "+-1", "0x"] {
            assert!(string_to_number(s).is_nan(), "{s:?}");
        }
    }

    #[test]
    fn operators() {
        let n = Value::Number;
        let num = |v: Eval| match v {
            Ok(Value::Number(x)) => x,
            _ => f64::NAN,
        };
        assert_eq!(
            num(binary(sk::LessThanLessThanToken, &n(1.0), &n(3.0))),
            8.0
        );
        assert_eq!(
            num(binary(
                sk::GreaterThanGreaterThanGreaterThanToken,
                &n(-1.0),
                &n(0.0)
            )),
            4_294_967_295.0
        );
        assert_eq!(
            num(binary(sk::GreaterThanGreaterThanToken, &n(-16.0), &n(2.0))),
            -4.0
        );
        assert_eq!(num(binary(sk::CaretToken, &n(6.0), &n(3.0))), 5.0);
        assert!(loosely_equal(&Value::str("1"), &n(1.0)));
        assert!(loosely_equal(&Value::Null, &Value::Undefined));
        assert!(!loosely_equal(&Value::Null, &n(0.0)));
        assert_eq!(
            compare(&Value::str("b"), &Value::str("a")),
            Some(Ordering::Greater)
        );
        assert_eq!(compare(&n(f64::NAN), &n(1.0)), None);
    }

    #[test]
    fn int32_conversion() {
        assert_eq!(to_int32(1.0), 1);
        assert_eq!(to_int32(4_294_967_295.0), -1);
        assert_eq!(to_int32(f64::NAN), 0);
    }
}
