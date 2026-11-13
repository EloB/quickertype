//! Port of `packages/quicktype-core/src/language/Php/utils.ts`.
//!
//! PHP string escaping, identifier styling and reserved class names.

use crate::support::strings::{
    MapperOutput, all_lower_word_style, all_upper_word_style, combine_words,
    first_upper_word_style, is_ascii, is_digit, is_letter, split_into_words, utf16_concat_map,
    utf16_legalize_characters,
};

/// `stringEscape`: escapes `'` and `\` for a single-quoted PHP string, and
/// splices LF and CR in as `' . "\n" . '` (per UTF-16 code unit).
pub fn string_escape(s: &str) -> String {
    utf16_concat_map(s, |code_point| match code_point {
        0x0a => "' . \"\\n\" . '".into(),
        0x0d => "' . \"\\r\" . '".into(),
        0x27 => "\\'".into(),
        0x5c => "\\\\".into(),
        _ => MapperOutput::CharCode(code_point),
    })
}

fn is_start_character(code_point: u32) -> bool {
    if code_point == 0x5f {
        return true; // underscore
    }
    is_ascii(code_point) && is_letter(code_point)
}

fn is_part_character(code_point: u32) -> bool {
    is_start_character(code_point) || (is_ascii(code_point) && is_digit(code_point))
}

fn legalize_name(s: &str) -> String {
    utf16_legalize_characters(s, is_part_character)
}

/// `phpNameStyle(startWithUpper, upperUnderscore, original,
/// acronymsStyle)`: PascalCase, camelCase or `UPPER_UNDERSCORE` names
/// (ASCII only), with `acronyms_style` for acronyms after the first word.
pub fn php_name_style(
    start_with_upper: bool,
    upper_underscore: bool,
    original: &str,
    acronyms_style: fn(&str) -> String,
) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        if upper_underscore {
            &all_upper_word_style
        } else if start_with_upper {
            &first_upper_word_style
        } else {
            &all_lower_word_style
        },
        if upper_underscore {
            &all_upper_word_style
        } else {
            &first_upper_word_style
        },
        if upper_underscore || start_with_upper {
            &all_upper_word_style
        } else {
            &all_lower_word_style
        },
        &acronyms_style,
        if upper_underscore { "_" } else { "" },
        &is_start_character,
    )
}

/// `phpForbiddenClassNames`: words that cannot be used as class names in
/// PHP, in the PascalCase form the type namer produces (PHP reserves them
/// case-insensitively): keywords, plus the reserved type and constant
/// names, plus the classes the generated code itself refers to.
pub const PHP_FORBIDDEN_CLASS_NAMES: [&str; 92] = [
    "Abstract",
    "And",
    "Array",
    "As",
    "Bool",
    "Break",
    "Callable",
    "Case",
    "Catch",
    "Class",
    "Clone",
    "Const",
    "Continue",
    "Converter",
    "DateTime",
    "DateTimeInterface",
    "Declare",
    "Default",
    "Die",
    "Do",
    "Echo",
    "Else",
    "Elseif",
    "Empty",
    "Enddeclare",
    "Endfor",
    "Endforeach",
    "Endif",
    "Endswitch",
    "Endwhile",
    "Enum",
    "Eval",
    "Exception",
    "JSONException",
    "Exit",
    "Extends",
    "False",
    "Final",
    "Finally",
    "Float",
    "Fn",
    "For",
    "Foreach",
    "Function",
    "Global",
    "Goto",
    "If",
    "Implements",
    "Include",
    "Instanceof",
    "Insteadof",
    "Int",
    "Interface",
    "Isset",
    "Iterable",
    "List",
    // Declared by the intl extension.
    "Locale",
    "Match",
    "Mixed",
    "Namespace",
    "Never",
    "New",
    "Null",
    "Object",
    "Or",
    "Override",
    "Parent",
    "Print",
    "Private",
    "Protected",
    "Public",
    "Readonly",
    "Require",
    "Return",
    "Self",
    "Serializable",
    "Static",
    "StdClass",
    "String",
    "Switch",
    "Throw",
    "Trait",
    "True",
    "Try",
    "Unset",
    "Use",
    "Var",
    "Void",
    "While",
    "Xor",
    "Yield",
    "stdClass",
];

#[cfg(test)]
mod tests {
    use super::*;
    use crate::support::strings::all_upper_word_style;

    #[test]
    fn escapes_like_typescript() {
        assert_eq!(string_escape("it's a\\b"), "it\\'s a\\\\b");
        assert_eq!(
            string_escape("a\nb\rc"),
            "a' . \"\\n\" . 'b' . \"\\r\" . 'c"
        );
        assert_eq!(string_escape("😀\""), "😀\"");
    }

    #[test]
    fn styles_names() {
        let upper = all_upper_word_style as fn(&str) -> String;
        assert_eq!(
            php_name_style(true, false, "foo bar url", upper),
            "FooBarURL"
        );
        assert_eq!(php_name_style(false, false, "url foo", upper), "urlFoo");
        assert_eq!(php_name_style(true, true, "foo bar", upper), "FOO_BAR");
        assert_eq!(php_name_style(false, false, "1x", upper), "the1X");
        assert_eq!(php_name_style(true, false, "héllo", upper), "Hllo");
    }
}
