//! Class property initializers as default values.
//!
//! typescript-json-schema evaluates an initializer's source text in a
//! sandbox (`new VM().run("sandboxvar=" + initial.getText())`) and keeps the
//! result when it is `null`, a string, a number, a boolean or an array. This
//! evaluates the initializer's syntax tree instead, for the subset of
//! JavaScript that can appear there as a constant: literals, array and
//! object literals, `undefined`/`NaN`/`Infinity`, unary `+ - ! ~`,
//! arithmetic, comparison, logical and string concatenation operators,
//! parentheses and the conditional operator. Anything else, such as a
//! reference to another binding, counts as an evaluation error, which
//! typescript-json-schema reports as `exception evaluating initializer`.
//! Function and class expressions evaluate to opaque values whose
//! `String()` is their source text.

use crate::js::{self, Value};
use crate::tsc::ast::Node;
use crate::tsc::generated::syntax_kind as sk;

type Eval = Result<Value, ()>;

/// Evaluates an initializer expression.
pub fn evaluate(node: &Node) -> Eval {
    match node.kind() {
        sk::NumericLiteral => Ok(Value::Number(numeric_literal(&node.text().ok_or(())?)?)),
        sk::StringLiteral | sk::NoSubstitutionTemplateLiteral => {
            Ok(Value::String(node.text().ok_or(())?))
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
        sk::ParenthesizedExpression => evaluate(&node.named("expression").ok_or(())?),
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
                let name = p.named("name").ok_or(())?;
                let key = match name.kind() {
                    sk::Identifier | sk::StringLiteral => name.text().ok_or(())?,
                    sk::NumericLiteral => {
                        js::number_to_string(numeric_literal(&name.text().ok_or(())?)?)
                    }
                    _ => return Err(()),
                };
                let value = evaluate(&p.named("initializer").ok_or(())?)?;
                obj.borrow_mut().define(&key, value);
            }
            Ok(Value::Object(obj))
        }
        sk::PrefixUnaryExpression => {
            let operand = evaluate(&node.named("operand").ok_or(())?)?;
            let op = node.operator().ok_or(())?;
            Ok(match op {
                sk::MinusToken => Value::Number(-to_number(&operand)),
                sk::PlusToken => Value::Number(to_number(&operand)),
                sk::ExclamationToken => Value::Bool(!operand.truthy()),
                sk::TildeToken => Value::Number(f64::from(!to_int32(to_number(&operand)))),
                _ => return Err(()),
            })
        }
        sk::BinaryExpression => {
            let op = node.named("operatorToken").ok_or(())?.kind();
            let left = evaluate(&node.named("left").ok_or(())?)?;
            match op {
                sk::AmpersandAmpersandToken => {
                    return if left.truthy() {
                        evaluate(&node.named("right").ok_or(())?)
                    } else {
                        Ok(left)
                    };
                }
                sk::BarBarToken => {
                    return if left.truthy() {
                        Ok(left)
                    } else {
                        evaluate(&node.named("right").ok_or(())?)
                    };
                }
                sk::QuestionQuestionToken => {
                    return if matches!(left, Value::Null | Value::Undefined) {
                        evaluate(&node.named("right").ok_or(())?)
                    } else {
                        Ok(left)
                    };
                }
                _ => {}
            }
            let right = evaluate(&node.named("right").ok_or(())?)?;
            binary(op, &left, &right)
        }
        sk::ConditionalExpression => {
            let cond = evaluate(&node.named("condition").ok_or(())?)?;
            evaluate(
                &node
                    .named(if cond.truthy() {
                        "whenTrue"
                    } else {
                        "whenFalse"
                    })
                    .ok_or(())?,
            )
        }
        sk::ArrowFunction | sk::FunctionExpression | sk::ClassExpression => {
            Ok(Value::Opaque(node.get_text()))
        }
        _ => Err(()),
    }
}

fn to_number(v: &Value) -> f64 {
    match v {
        Value::Number(n) => *n,
        Value::Bool(b) => f64::from(u8::from(*b)),
        Value::Null => 0.0,
        Value::String(s) => {
            let t = js::trim(s);
            if t.is_empty() {
                0.0
            } else {
                numeric_literal(t).unwrap_or(f64::NAN)
            }
        }
        Value::Array(a) => match a.borrow().as_slice() {
            [] => 0.0,
            [only] => to_number(&Value::String(only.to_js_string())),
            _ => f64::NAN,
        },
        _ => f64::NAN,
    }
}

fn to_int32(x: f64) -> i32 {
    if !x.is_finite() {
        return 0;
    }
    (x.trunc().rem_euclid(4_294_967_296.0) as u64 as u32) as i32
}

fn binary(op: u32, l: &Value, r: &Value) -> Eval {
    let num = |f: fn(f64, f64) -> f64| Ok(Value::Number(f(to_number(l), to_number(r))));
    match op {
        sk::PlusToken => {
            let prim = |v: &Value| {
                matches!(
                    v,
                    Value::String(_) | Value::Array(_) | Value::Object(_) | Value::Opaque(_)
                )
            };
            if prim(l) || prim(r) {
                Ok(Value::String(format!(
                    "{}{}",
                    l.to_js_string(),
                    r.to_js_string()
                )))
            } else {
                num(|a, b| a + b)
            }
        }
        sk::MinusToken => num(|a, b| a - b),
        sk::AsteriskToken => num(|a, b| a * b),
        sk::SlashToken => num(|a, b| a / b),
        sk::PercentToken => num(|a, b| a % b),
        sk::AsteriskAsteriskToken => num(quicktype_js_compat::number::pow),
        _ => Err(()),
    }
}

/// The value of a JavaScript numeric literal's text.
fn numeric_literal(text: &str) -> Result<f64, ()> {
    let t: String = text.chars().filter(|c| *c != '_').collect();
    let radix = |p: &str, r: u32| -> Option<f64> {
        let digits = t
            .strip_prefix(p)
            .or_else(|| t.strip_prefix(&p.to_uppercase()))?;
        let mut v = 0f64;
        for c in digits.chars() {
            v = v * f64::from(r) + f64::from(c.to_digit(r)?);
        }
        Some(v)
    };
    if let Some(v) = radix("0x", 16)
        .or_else(|| radix("0o", 8))
        .or_else(|| radix("0b", 2))
    {
        return Ok(v);
    }
    let is_decimal = !t.is_empty()
        && t.chars()
            .all(|c| c.is_ascii_digit() || matches!(c, '.' | 'e' | 'E' | '+' | '-'))
        && t.chars()
            .next()
            .is_some_and(|c| c.is_ascii_digit() || c == '.');
    if is_decimal {
        if let Ok(v) = t.parse::<f64>() {
            return Ok(v);
        }
    }
    Err(())
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
        assert!(numeric_literal("abc").is_err());
    }

    #[test]
    fn int32_conversion() {
        assert_eq!(to_int32(1.0), 1);
        assert_eq!(to_int32(4_294_967_295.0), -1);
        assert_eq!(to_int32(f64::NAN), 0);
    }
}
