// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _JSON;
let _YObjectJSON;
let _YObjectBasicJSON;
let _YObjectEmptyKeyJSON;
let _YObjectEscapedNullInKeyJSON;
let _YObjectExtremeNumbersJSON;
let _YObjectLongStringsJSON;
let _X;
let _YObjectSimpleJSON;
let _YObjectStringUnicodeJSON;
let _YObjectWithNewlinesJSON;
_JSON = PropTypes.shape({
});
_YObjectJSON = PropTypes.shape({
    "asd": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "dfg": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_YObjectBasicJSON = PropTypes.shape({
    "asd": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_YObjectEmptyKeyJSON = PropTypes.shape({
    "": PropTypes.oneOfType([Integer]).isRequired,
});
_YObjectEscapedNullInKeyJSON = PropTypes.shape({
    "foo\u0000bar": PropTypes.oneOfType([Integer]).isRequired,
});
_YObjectExtremeNumbersJSON = PropTypes.shape({
    "max": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "min": PropTypes.oneOfType([PropTypes.number]).isRequired,
});
_X = PropTypes.shape({
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_YObjectLongStringsJSON = PropTypes.shape({
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "x": PropTypes.oneOfType([PropTypes.arrayOf(_X)]).isRequired,
});
_YObjectSimpleJSON = PropTypes.shape({
    "a": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
});
_YObjectStringUnicodeJSON = PropTypes.shape({
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_YObjectWithNewlinesJSON = PropTypes.shape({
    "a": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "y_array_arraysWithSpaces.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.any))]).isRequired,
    "y_array_empty-string.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_array_empty.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "y_array_ending_with_newline.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_array_false.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.bool)]).isRequired,
    "y_array_heterogeneous.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([_JSON, Integer, PropTypes.oneOf([null]), PropTypes.string]))]).isRequired,
    "y_array_null.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOf([null]))]).isRequired,
    "y_array_with_1_and_newline.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_array_with_leading_space.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_array_with_several_null.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]))]).isRequired,
    "y_array_with_trailing_space.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_0e+1.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_0e1.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_after_space.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number_double_close_to_zero.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_int_with_exp.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_minus_zero.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number_negative_int.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number_negative_one.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number_negative_zero.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number_real_capital_e.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_real_capital_e_neg_exp.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_real_capital_e_pos_exp.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_real_exponent.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_real_fraction_exponent.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_real_neg_exp.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_real_pos_exponent.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_number_simple_int.json": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "y_number_simple_real.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "y_object.json": _YObjectJSON,
    "y_object_basic.json": _YObjectBasicJSON,
    "y_object_empty.json": _JSON,
    "y_object_empty_key.json": _YObjectEmptyKeyJSON,
    "y_object_escaped_null_in_key.json": _YObjectEscapedNullInKeyJSON,
    "y_object_extreme_numbers.json": _YObjectExtremeNumbersJSON,
    "y_object_long_strings.json": _YObjectLongStringsJSON,
    "y_object_simple.json": _YObjectSimpleJSON,
    "y_object_string_unicode.json": _YObjectStringUnicodeJSON,
    "y_object_with_newlines.json": _YObjectWithNewlinesJSON,
    "y_string_1_2_3_bytes_UTF-8_sequences.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_accepted_surrogate_pair.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_accepted_surrogate_pairs.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_allowed_escapes.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_backslash_and_u_escaped_zero.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_backslash_doublequotes.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_comments.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_double_escape_a.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_double_escape_n.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_escaped_control_character.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_escaped_noncharacter.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_in_array.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_in_array_with_leading_space.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_last_surrogates_1_and_2.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_nbsp_uescaped.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_nonCharacterInUTF-8_U+10FFFF.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_nonCharacterInUTF-8_U+1FFFF.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_nonCharacterInUTF-8_U+FFFF.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_null_escape.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_one-byte-utf-8.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_pi.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_simple_ascii.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_space.json": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_three-byte-utf-8.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_two-byte-utf-8.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_u+2028_line_sep.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_u+2029_par_sep.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_uEscape.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_uescaped_newline.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unescaped_char_delete.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicodeEscapedBackslash.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_2.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_U+10FFFE_nonchar.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_U+1FFFE_nonchar.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_U+2064_invisible_plus.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_U+FDD0_nonchar.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_U+FFFE_nonchar.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_unicode_escaped_double_quote.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_utf8.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_string_with_del_character.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_structure_lonely_false.json": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "y_structure_lonely_int.json": PropTypes.oneOfType([Integer]).isRequired,
    "y_structure_lonely_negative_real.json": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "y_structure_lonely_null.json": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "y_structure_lonely_string.json": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "y_structure_lonely_true.json": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "y_structure_string_empty.json": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "y_structure_trailing_newline.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "y_structure_true_in_array.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.bool)]).isRequired,
    "y_structure_whitespace_array.json": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
});

export const TopLevel = _TopLevel;
