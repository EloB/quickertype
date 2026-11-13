//! Port of `packages/quicktype-core/src/language/CPlusPlus/utils.ts`.
//!
//! Constraint lookup, the identifier legalizer, the generated global and
//! member names, and the narrow/wide string flavours of the C++ renderer.

use crate::attributes::constraints::{
    MinMaxConstraint, min_max_length_for_type, min_max_value_for_type, pattern_for_type,
};
use crate::messages::Result;
use crate::naming::Name;
use crate::sl;
use crate::source::Source;
use crate::support::strings::{is_ascii, is_letter_or_underscore_or_digit, legalize_characters};
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// The constraints of a type (TS `constraintsForType`'s result).
#[derive(Clone, Debug, PartialEq)]
pub struct Constraints {
    /// `minMax`.
    pub min_max: Option<MinMaxConstraint>,
    /// `minMaxLength`.
    pub min_max_length: Option<MinMaxConstraint>,
    /// `pattern`.
    pub pattern: Option<String>,
}

/// `constraintsForType(t)`: `None` if the type has no value, length or
/// pattern constraint.
pub fn constraints_for_type(graph: &TypeGraph, t: TypeRef) -> Result<Option<Constraints>> {
    let min_max = min_max_value_for_type(graph, t)?;
    let min_max_length = min_max_length_for_type(graph, t)?;
    let pattern = pattern_for_type(graph, t)?;
    if min_max.is_none() && min_max_length.is_none() && pattern.is_none() {
        return Ok(None);
    }
    Ok(Some(Constraints {
        min_max,
        min_max_length,
        pattern,
    }))
}

/// `legalizeName`: keeps ASCII letters, digits and underscores.
pub fn legalize_name(s: &str) -> String {
    legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
}

/// `optionalAsSharedType`: the optional type to use if cycle breaking is
/// required.
pub const OPTIONAL_AS_SHARED_TYPE: &str = "std::shared_ptr";

/// `optionalFactoryAsSharedType`: the factory for an optional if cycle
/// breaking is required.
pub const OPTIONAL_FACTORY_AS_SHARED_TYPE: &str = "std::make_shared";

/// `IncludeKind`: how a type is made known in another file of the
/// multi-source output (classes in a cycle across files are forward
/// declared).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum IncludeKind {
    /// `"ForwardDeclare"`.
    ForwardDeclare,
    /// `"Include"`.
    Include,
}

/// `GlobalNames`: the generated helper classes and functions.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum GlobalNames {
    /// `ClassMemberConstraints`.
    ClassMemberConstraints = 1,
    /// `ClassMemberConstraintException`.
    ClassMemberConstraintException = 2,
    /// `ValueTooLowException`.
    ValueTooLowException = 3,
    /// `ValueTooHighException`.
    ValueTooHighException = 4,
    /// `ValueTooShortException`.
    ValueTooShortException = 5,
    /// `ValueTooLongException`.
    ValueTooLongException = 6,
    /// `InvalidPatternException`.
    InvalidPatternException = 7,
    /// `CheckConstraint`.
    CheckConstraint = 8,
    /// `CodePointLength`.
    CodePointLength = 9,
}

impl GlobalNames {
    /// `numberEnumValues(GlobalNames)`: every value, in numeric order.
    pub const ALL: [GlobalNames; 9] = [
        GlobalNames::ClassMemberConstraints,
        GlobalNames::ClassMemberConstraintException,
        GlobalNames::ValueTooLowException,
        GlobalNames::ValueTooHighException,
        GlobalNames::ValueTooShortException,
        GlobalNames::ValueTooLongException,
        GlobalNames::InvalidPatternException,
        GlobalNames::CheckConstraint,
        GlobalNames::CodePointLength,
    ];

    /// `GlobalNames[value]`: the member's name.
    pub fn as_str(self) -> &'static str {
        match self {
            GlobalNames::ClassMemberConstraints => "ClassMemberConstraints",
            GlobalNames::ClassMemberConstraintException => "ClassMemberConstraintException",
            GlobalNames::ValueTooLowException => "ValueTooLowException",
            GlobalNames::ValueTooHighException => "ValueTooHighException",
            GlobalNames::ValueTooShortException => "ValueTooShortException",
            GlobalNames::ValueTooLongException => "ValueTooLongException",
            GlobalNames::InvalidPatternException => "InvalidPatternException",
            GlobalNames::CheckConstraint => "CheckConstraint",
            GlobalNames::CodePointLength => "CodePointLength",
        }
    }
}

/// `MemberNames`: the members of the generated constraint class.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum MemberNames {
    /// `MinIntValue`.
    MinIntValue = 1,
    /// `GetMinIntValue`.
    GetMinIntValue = 2,
    /// `SetMinIntValue`.
    SetMinIntValue = 3,
    /// `MaxIntValue`.
    MaxIntValue = 4,
    /// `GetMaxIntValue`.
    GetMaxIntValue = 5,
    /// `SetMaxIntValue`.
    SetMaxIntValue = 6,
    /// `MinDoubleValue`.
    MinDoubleValue = 7,
    /// `GetMinDoubleValue`.
    GetMinDoubleValue = 8,
    /// `SetMinDoubleValue`.
    SetMinDoubleValue = 9,
    /// `MaxDoubleValue`.
    MaxDoubleValue = 10,
    /// `GetMaxDoubleValue`.
    GetMaxDoubleValue = 11,
    /// `SetMaxDoubleValue`.
    SetMaxDoubleValue = 12,
    /// `MinLength`.
    MinLength = 13,
    /// `GetMinLength`.
    GetMinLength = 14,
    /// `SetMinLength`.
    SetMinLength = 15,
    /// `MaxLength`.
    MaxLength = 16,
    /// `GetMaxLength`.
    GetMaxLength = 17,
    /// `SetMaxLength`.
    SetMaxLength = 18,
    /// `Pattern`.
    Pattern = 19,
    /// `GetPattern`.
    GetPattern = 20,
    /// `SetPattern`.
    SetPattern = 21,
}

impl MemberNames {
    /// `numberEnumValues(MemberNames)`: every value, in numeric order.
    pub const ALL: [MemberNames; 21] = [
        MemberNames::MinIntValue,
        MemberNames::GetMinIntValue,
        MemberNames::SetMinIntValue,
        MemberNames::MaxIntValue,
        MemberNames::GetMaxIntValue,
        MemberNames::SetMaxIntValue,
        MemberNames::MinDoubleValue,
        MemberNames::GetMinDoubleValue,
        MemberNames::SetMinDoubleValue,
        MemberNames::MaxDoubleValue,
        MemberNames::GetMaxDoubleValue,
        MemberNames::SetMaxDoubleValue,
        MemberNames::MinLength,
        MemberNames::GetMinLength,
        MemberNames::SetMinLength,
        MemberNames::MaxLength,
        MemberNames::GetMaxLength,
        MemberNames::SetMaxLength,
        MemberNames::Pattern,
        MemberNames::GetPattern,
        MemberNames::SetPattern,
    ];

    /// `MemberNames[value]`: the member's name.
    pub fn as_str(self) -> &'static str {
        match self {
            MemberNames::MinIntValue => "MinIntValue",
            MemberNames::GetMinIntValue => "GetMinIntValue",
            MemberNames::SetMinIntValue => "SetMinIntValue",
            MemberNames::MaxIntValue => "MaxIntValue",
            MemberNames::GetMaxIntValue => "GetMaxIntValue",
            MemberNames::SetMaxIntValue => "SetMaxIntValue",
            MemberNames::MinDoubleValue => "MinDoubleValue",
            MemberNames::GetMinDoubleValue => "GetMinDoubleValue",
            MemberNames::SetMinDoubleValue => "SetMinDoubleValue",
            MemberNames::MaxDoubleValue => "MaxDoubleValue",
            MemberNames::GetMaxDoubleValue => "GetMaxDoubleValue",
            MemberNames::SetMaxDoubleValue => "SetMaxDoubleValue",
            MemberNames::MinLength => "MinLength",
            MemberNames::GetMinLength => "GetMinLength",
            MemberNames::SetMinLength => "SetMinLength",
            MemberNames::MaxLength => "MaxLength",
            MemberNames::GetMaxLength => "GetMaxLength",
            MemberNames::SetMaxLength => "SetMaxLength",
            MemberNames::Pattern => "Pattern",
            MemberNames::GetPattern => "GetPattern",
            MemberNames::SetPattern => "SetPattern",
        }
    }
}

/// `ConstraintMember`: a member of the generated constraint class.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct ConstraintMember {
    /// `cppConstType`: the setter's parameter type, if not `cpp_type`.
    pub cpp_const_type: Option<String>,
    /// `cppType`.
    pub cpp_type: String,
    /// `getter`.
    pub getter: MemberNames,
    /// `name`.
    pub name: MemberNames,
    /// `setter`.
    pub setter: MemberNames,
}

/// The `typeKind` of an [`IncludeRecord`]: what is included.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum IncludeTypeKind {
    /// `"class"`.
    Class,
    /// `"enum"`.
    Enum,
    /// `"union"`.
    Union,
}

/// `IncludeRecord`: how to include a type, and what it is.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct IncludeRecord {
    /// `kind`.
    pub kind: Option<IncludeKind>,
    /// `typeKind`.
    pub type_kind: Option<IncludeTypeKind>,
}

/// `TypeRecord`: a generated type reached from a property or union.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TypeRecord {
    /// `forceInclude`.
    pub force_include: bool,
    /// `level`: the nesting depth inside arrays, maps and unions.
    pub level: usize,
    /// `name`.
    pub name: Name,
    /// `type`.
    pub type_ref: TypeRef,
    /// `variant`.
    pub variant: bool,
}

/// `TypeContext`: where a C++ type expression is used.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TypeContext {
    /// `inJsonNamespace`: the expression is in `namespace nlohmann`, so our
    /// types are qualified.
    pub in_json_namespace: bool,
    /// `needsForwardIndirection`.
    pub needs_forward_indirection: bool,
    /// `needsOptionalIndirection`.
    pub needs_optional_indirection: bool,
}

/// `addQualifier(qualifier, qualified)`: `[]` if there is nothing to
/// qualify, else `[qualifier, qualified]`.
pub fn add_qualifier(qualifier: Source, qualified: &[Source]) -> Source {
    if qualified.is_empty() {
        return sl![];
    }
    sl![qualifier, Source::Sequence(qualified.to_vec())]
}

/// `WrappingCode`: code around an expression, e.g. `std::to_string(...)`.
#[derive(Clone, Debug)]
pub struct WrappingCode {
    start: Vec<Source>,
    end: Vec<Source>,
}

impl WrappingCode {
    /// `new WrappingCode(start, end)`.
    pub fn new(start: Vec<Source>, end: Vec<Source>) -> Self {
        WrappingCode { start, end }
    }

    /// `wrap(qualifier, inner)`.
    pub fn wrap(&self, qualifier: Source, inner: Source) -> Source {
        sl![
            add_qualifier(qualifier, &self.start),
            inner,
            Source::Sequence(self.end.clone())
        ]
    }
}

/// Which `StringType` a [`BaseString`] is: the renderer's `NarrowString`
/// or `WideString` (whose `wrapEncodingChange` and `emitHelperFunctions`
/// the renderer implements).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum StringKind {
    /// `NarrowString`: `std::string`.
    Narrow,
    /// `WideString`: `std::wstring`.
    Wide,
}

/// `BaseString`: the C++ spelling of a string flavour.
#[derive(Clone, Debug)]
pub struct BaseString {
    /// Narrow or wide.
    pub kind: StringKind,
    /// `_stringType`.
    pub string_type: &'static str,
    /// `_constStringType`.
    pub const_string_type: &'static str,
    /// `_smatch`.
    pub smatch: &'static str,
    /// `_regex`.
    pub regex: &'static str,
    /// `_stringLiteralPrefix`.
    pub string_literal_prefix: &'static str,
    /// `_toString`.
    pub to_string: WrappingCode,
    /// `_encodingClass`.
    pub encoding_class: &'static str,
    /// `_encodingFunction`.
    pub encoding_function: &'static str,
}

impl BaseString {
    /// The renderer's `NarrowString`.
    pub fn narrow() -> Self {
        BaseString {
            kind: StringKind::Narrow,
            string_type: "std::string",
            const_string_type: "const std::string & ",
            smatch: "std::smatch",
            regex: "std::regex",
            string_literal_prefix: "",
            to_string: WrappingCode::new(vec!["std::to_string(".into()], vec![")".into()]),
            encoding_class: "",
            encoding_function: "",
        }
    }

    /// The renderer's `WideString`.
    pub fn wide() -> Self {
        BaseString {
            kind: StringKind::Wide,
            string_type: "std::wstring",
            const_string_type: "const std::wstring & ",
            smatch: "std::wsmatch",
            regex: "std::wregex",
            string_literal_prefix: "L",
            to_string: WrappingCode::new(vec!["std::to_wstring(".into()], vec![")".into()]),
            encoding_class: "Utf16_Utf8",
            encoding_function: "convert",
        }
    }

    /// `getType()`.
    pub fn get_type(&self) -> &'static str {
        self.string_type
    }

    /// `getConstType()`.
    pub fn get_const_type(&self) -> &'static str {
        self.const_string_type
    }

    /// `getSMatch()`.
    pub fn get_smatch(&self) -> &'static str {
        self.smatch
    }

    /// `getRegex()`.
    pub fn get_regex(&self) -> &'static str {
        self.regex
    }

    /// `createStringLiteral(inner)`: `"inner"` with the literal prefix; a
    /// literal with an escaped NUL is built with its length, so that it is
    /// not cut at the NUL.
    pub fn create_string_literal(&self, inner: Source) -> Source {
        let has_nul = has_nul(&inner);
        let literal = sl![self.string_literal_prefix, "\"", inner, "\""];
        if !has_nul {
            return literal;
        }
        sl![
            "([] { constexpr auto &s = ",
            literal,
            "; return ",
            self.string_type,
            "(s, sizeof(s) / sizeof(s[0]) - 1); }())"
        ]
    }

    /// `wrapToString(inner)`.
    pub fn wrap_to_string(&self, inner: Source) -> Source {
        self.to_string.wrap(sl![], inner)
    }
}

/// `hasNul(source)` in `createStringLiteral`: whether a string in the
/// (nested) array contains an unescaped `\u0000`, i.e. matches
/// `/(^|[^\\])(?:\\\\)*\\u0000/`.
fn has_nul(source: &Source) -> bool {
    match source {
        Source::Sequence(parts) => parts.iter().any(has_nul),
        Source::Text(s) => text_has_escaped_nul(s),
        _ => false,
    }
}

/// Whether `s` has `\u0000` preceded by an odd run of backslashes (the
/// escape itself plus escaped backslashes).
fn text_has_escaped_nul(s: &str) -> bool {
    let bytes = s.as_bytes();
    let needle = b"u0000";
    let mut i = 0;
    while i + needle.len() <= bytes.len() {
        if &bytes[i..i + needle.len()] == needle {
            let backslashes = bytes[..i].iter().rev().take_while(|&&b| b == b'\\').count();
            if backslashes % 2 == 1 {
                return true;
            }
        }
        i += 1;
    }
    false
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn detects_escaped_nul() {
        assert!(text_has_escaped_nul("\\u0000"));
        assert!(text_has_escaped_nul("a\\\\\\u0000"));
        assert!(!text_has_escaped_nul("a\\\\u0000"));
        assert!(!text_has_escaped_nul("u0000"));
        assert!(text_has_escaped_nul("x\\\\u0000\\u0000"));
    }

    #[test]
    fn legalizes_names() {
        assert_eq!(legalize_name("a-b_c1é"), "ab_c1");
    }
}
