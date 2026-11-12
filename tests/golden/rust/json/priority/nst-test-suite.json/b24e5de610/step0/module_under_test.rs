// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    #[serde(rename = "y_array_arraysWithSpaces.json")]
    pub y_array_arrays_with_spaces_json: Vec<Vec<Option<serde_json::Value>>>,

    #[serde(rename = "y_array_empty.json")]
    pub y_array_empty_json: Vec<Option<serde_json::Value>>,

    #[serde(rename = "y_array_empty-string.json")]
    pub y_array_empty_string_json: Vec<String>,

    #[serde(rename = "y_array_ending_with_newline.json")]
    pub y_array_ending_with_newline_json: Vec<String>,

    #[serde(rename = "y_array_false.json")]
    pub y_array_false_json: Vec<bool>,

    #[serde(rename = "y_array_heterogeneous.json")]
    pub y_array_heterogeneous_json: Vec<Option<YArrayHeterogeneousJson>>,

    #[serde(rename = "y_array_null.json")]
    pub y_array_null_json: Vec<Option<serde_json::Value>>,

    #[serde(rename = "y_array_with_1_and_newline.json")]
    pub y_array_with_1__and_newline_json: Vec<i64>,

    #[serde(rename = "y_array_with_leading_space.json")]
    pub y_array_with_leading_space_json: Vec<i64>,

    #[serde(rename = "y_array_with_several_null.json")]
    pub y_array_with_several_null_json: Vec<Option<i64>>,

    #[serde(rename = "y_array_with_trailing_space.json")]
    pub y_array_with_trailing_space_json: Vec<i64>,

    #[serde(rename = "y_number_0e1.json")]
    pub y_number_0_e1_json: Vec<f64>,

    #[serde(rename = "y_number_0e+1.json")]
    pub y_number_0_e_1_json: Vec<f64>,

    #[serde(rename = "y_number_after_space.json")]
    pub y_number_after_space_json: Vec<i64>,

    #[serde(rename = "y_number_double_close_to_zero.json")]
    pub y_number_double_close_to_zero_json: Vec<f64>,

    #[serde(rename = "y_number_int_with_exp.json")]
    pub y_number_int_with_exp_json: Vec<f64>,

    #[serde(rename = "y_number.json")]
    pub y_number_json: Vec<f64>,

    #[serde(rename = "y_number_minus_zero.json")]
    pub y_number_minus_zero_json: Vec<i64>,

    #[serde(rename = "y_number_negative_int.json")]
    pub y_number_negative_int_json: Vec<i64>,

    #[serde(rename = "y_number_negative_one.json")]
    pub y_number_negative_one_json: Vec<i64>,

    #[serde(rename = "y_number_negative_zero.json")]
    pub y_number_negative_zero_json: Vec<i64>,

    #[serde(rename = "y_number_real_capital_e.json")]
    pub y_number_real_capital_e_json: Vec<f64>,

    #[serde(rename = "y_number_real_capital_e_neg_exp.json")]
    pub y_number_real_capital_e_neg_exp_json: Vec<f64>,

    #[serde(rename = "y_number_real_capital_e_pos_exp.json")]
    pub y_number_real_capital_e_pos_exp_json: Vec<f64>,

    #[serde(rename = "y_number_real_exponent.json")]
    pub y_number_real_exponent_json: Vec<f64>,

    #[serde(rename = "y_number_real_fraction_exponent.json")]
    pub y_number_real_fraction_exponent_json: Vec<f64>,

    #[serde(rename = "y_number_real_neg_exp.json")]
    pub y_number_real_neg_exp_json: Vec<f64>,

    #[serde(rename = "y_number_real_pos_exponent.json")]
    pub y_number_real_pos_exponent_json: Vec<f64>,

    #[serde(rename = "y_number_simple_int.json")]
    pub y_number_simple_int_json: Vec<i64>,

    #[serde(rename = "y_number_simple_real.json")]
    pub y_number_simple_real_json: Vec<f64>,

    #[serde(rename = "y_object_basic.json")]
    pub y_object_basic_json: YObjectBasicJson,

    #[serde(rename = "y_object_empty.json")]
    pub y_object_empty_json: Json,

    #[serde(rename = "y_object_empty_key.json")]
    pub y_object_empty_key_json: YObjectEmptyKeyJson,

    #[serde(rename = "y_object_escaped_null_in_key.json")]
    pub y_object_escaped_null_in_key_json: YObjectEscapedNullInKeyJson,

    #[serde(rename = "y_object_extreme_numbers.json")]
    pub y_object_extreme_numbers_json: YObjectExtremeNumbersJson,

    #[serde(rename = "y_object.json")]
    pub y_object_json: YObjectJson,

    #[serde(rename = "y_object_long_strings.json")]
    pub y_object_long_strings_json: YObjectLongStringsJson,

    #[serde(rename = "y_object_simple.json")]
    pub y_object_simple_json: YObjectSimpleJson,

    #[serde(rename = "y_object_string_unicode.json")]
    pub y_object_string_unicode_json: YObjectStringUnicodeJson,

    #[serde(rename = "y_object_with_newlines.json")]
    pub y_object_with_newlines_json: YObjectWithNewlinesJson,

    #[serde(rename = "y_string_1_2_3_bytes_UTF-8_sequences.json")]
    pub y_string_1_2_3__bytes_utf_8__sequences_json: Vec<String>,

    #[serde(rename = "y_string_accepted_surrogate_pair.json")]
    pub y_string_accepted_surrogate_pair_json: Vec<String>,

    #[serde(rename = "y_string_accepted_surrogate_pairs.json")]
    pub y_string_accepted_surrogate_pairs_json: Vec<String>,

    #[serde(rename = "y_string_allowed_escapes.json")]
    pub y_string_allowed_escapes_json: Vec<String>,

    #[serde(rename = "y_string_backslash_and_u_escaped_zero.json")]
    pub y_string_backslash_and_u_escaped_zero_json: Vec<String>,

    #[serde(rename = "y_string_backslash_doublequotes.json")]
    pub y_string_backslash_doublequotes_json: Vec<String>,

    #[serde(rename = "y_string_comments.json")]
    pub y_string_comments_json: Vec<String>,

    #[serde(rename = "y_string_double_escape_a.json")]
    pub y_string_double_escape_a_json: Vec<String>,

    #[serde(rename = "y_string_double_escape_n.json")]
    pub y_string_double_escape_n_json: Vec<String>,

    #[serde(rename = "y_string_escaped_control_character.json")]
    pub y_string_escaped_control_character_json: Vec<String>,

    #[serde(rename = "y_string_escaped_noncharacter.json")]
    pub y_string_escaped_noncharacter_json: Vec<String>,

    #[serde(rename = "y_string_in_array.json")]
    pub y_string_in_array_json: Vec<String>,

    #[serde(rename = "y_string_in_array_with_leading_space.json")]
    pub y_string_in_array_with_leading_space_json: Vec<String>,

    #[serde(rename = "y_string_last_surrogates_1_and_2.json")]
    pub y_string_last_surrogates_1__and_2_json: Vec<String>,

    #[serde(rename = "y_string_nbsp_uescaped.json")]
    pub y_string_nbsp_uescaped_json: Vec<String>,

    #[serde(rename = "y_string_nonCharacterInUTF-8_U+10FFFF.json")]
    pub y_string_non_character_in_utf_8__u_10_ffff_json: Vec<String>,

    #[serde(rename = "y_string_nonCharacterInUTF-8_U+1FFFF.json")]
    pub y_string_non_character_in_utf_8__u_1_ffff_json: Vec<String>,

    #[serde(rename = "y_string_nonCharacterInUTF-8_U+FFFF.json")]
    pub y_string_non_character_in_utf_8__u_ffff_json: Vec<String>,

    #[serde(rename = "y_string_null_escape.json")]
    pub y_string_null_escape_json: Vec<String>,

    #[serde(rename = "y_string_one-byte-utf-8.json")]
    pub y_string_one_byte_utf_8_json: Vec<String>,

    #[serde(rename = "y_string_pi.json")]
    pub y_string_pi_json: Vec<String>,

    #[serde(rename = "y_string_simple_ascii.json")]
    pub y_string_simple_ascii_json: Vec<String>,

    #[serde(rename = "y_string_space.json")]
    pub y_string_space_json: String,

    #[serde(rename = "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json")]
    pub y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json: Vec<String>,

    #[serde(rename = "y_string_three-byte-utf-8.json")]
    pub y_string_three_byte_utf_8_json: Vec<String>,

    #[serde(rename = "y_string_two-byte-utf-8.json")]
    pub y_string_two_byte_utf_8_json: Vec<String>,

    #[serde(rename = "y_string_u+2028_line_sep.json")]
    pub y_string_u_2028__line_sep_json: Vec<String>,

    #[serde(rename = "y_string_u+2029_par_sep.json")]
    pub y_string_u_2029__par_sep_json: Vec<String>,

    #[serde(rename = "y_string_uEscape.json")]
    pub y_string_u_escape_json: Vec<String>,

    #[serde(rename = "y_string_uescaped_newline.json")]
    pub y_string_uescaped_newline_json: Vec<String>,

    #[serde(rename = "y_string_unescaped_char_delete.json")]
    pub y_string_unescaped_char_delete_json: Vec<String>,

    #[serde(rename = "y_string_unicode_2.json")]
    pub y_string_unicode_2_json: Vec<String>,

    #[serde(rename = "y_string_unicodeEscapedBackslash.json")]
    pub y_string_unicode_escaped_backslash_json: Vec<String>,

    #[serde(rename = "y_string_unicode_escaped_double_quote.json")]
    pub y_string_unicode_escaped_double_quote_json: Vec<String>,

    #[serde(rename = "y_string_unicode.json")]
    pub y_string_unicode_json: Vec<String>,

    #[serde(rename = "y_string_unicode_U+10FFFE_nonchar.json")]
    pub y_string_unicode_u_10_fffe_nonchar_json: Vec<String>,

    #[serde(rename = "y_string_unicode_U+1FFFE_nonchar.json")]
    pub y_string_unicode_u_1_fffe_nonchar_json: Vec<String>,

    #[serde(rename = "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json")]
    pub y_string_unicode_u_200_b_zero_width_space_json: Vec<String>,

    #[serde(rename = "y_string_unicode_U+2064_invisible_plus.json")]
    pub y_string_unicode_u_2064__invisible_plus_json: Vec<String>,

    #[serde(rename = "y_string_unicode_U+FDD0_nonchar.json")]
    pub y_string_unicode_u_fdd0_nonchar_json: Vec<String>,

    #[serde(rename = "y_string_unicode_U+FFFE_nonchar.json")]
    pub y_string_unicode_u_fffe_nonchar_json: Vec<String>,

    #[serde(rename = "y_string_utf8.json")]
    pub y_string_utf8_json: Vec<String>,

    #[serde(rename = "y_string_with_del_character.json")]
    pub y_string_with_del_character_json: Vec<String>,

    #[serde(rename = "y_structure_lonely_false.json")]
    pub y_structure_lonely_false_json: bool,

    #[serde(rename = "y_structure_lonely_int.json")]
    pub y_structure_lonely_int_json: i64,

    #[serde(rename = "y_structure_lonely_negative_real.json")]
    pub y_structure_lonely_negative_real_json: f64,

    #[serde(rename = "y_structure_lonely_null.json")]
    pub y_structure_lonely_null_json: Option<serde_json::Value>,

    #[serde(rename = "y_structure_lonely_string.json")]
    pub y_structure_lonely_string_json: String,

    #[serde(rename = "y_structure_lonely_true.json")]
    pub y_structure_lonely_true_json: bool,

    #[serde(rename = "y_structure_string_empty.json")]
    pub y_structure_string_empty_json: String,

    #[serde(rename = "y_structure_trailing_newline.json")]
    pub y_structure_trailing_newline_json: Vec<String>,

    #[serde(rename = "y_structure_true_in_array.json")]
    pub y_structure_true_in_array_json: Vec<bool>,

    #[serde(rename = "y_structure_whitespace_array.json")]
    pub y_structure_whitespace_array_json: Vec<Option<serde_json::Value>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum YArrayHeterogeneousJson {
    Integer(i64),

    Json(Json),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Json {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectBasicJson {
    pub asd: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectEmptyKeyJson {
    #[serde(rename = "")]
    pub empty: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectEscapedNullInKeyJson {
    #[serde(rename = "foo\u{0000}bar")]
    pub foo_bar: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectExtremeNumbersJson {
    pub max: f64,

    pub min: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectJson {
    pub asd: String,

    pub dfg: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectLongStringsJson {
    pub id: String,

    pub x: Vec<X>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct X {
    pub id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectSimpleJson {
    pub a: Vec<Option<serde_json::Value>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectStringUnicodeJson {
    pub title: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct YObjectWithNewlinesJson {
    pub a: String,
}
