import * as S from "effect/Schema";


export class YObjectWithNewlinesJson extends S.Class<YObjectWithNewlinesJson>("YObjectWithNewlinesJson")({
    "a": S.String,
}) {}

export class YObjectStringUnicodeJson extends S.Class<YObjectStringUnicodeJson>("YObjectStringUnicodeJson")({
    "title": S.String,
}) {}

export class YObjectSimpleJson extends S.Class<YObjectSimpleJson>("YObjectSimpleJson")({
    "a": S.Array(S.Any),
}) {}

export class X extends S.Class<X>("X")({
    "id": S.String,
}) {}

export class YObjectLongStringsJson extends S.Class<YObjectLongStringsJson>("YObjectLongStringsJson")({
    "id": S.String,
    "x": S.Array(X),
}) {}

export class YObjectJson extends S.Class<YObjectJson>("YObjectJson")({
    "asd": S.String,
    "dfg": S.String,
}) {}

export class YObjectExtremeNumbersJson extends S.Class<YObjectExtremeNumbersJson>("YObjectExtremeNumbersJson")({
    "max": S.Number,
    "min": S.Number,
}) {}

export class YObjectEscapedNullInKeyJson extends S.Class<YObjectEscapedNullInKeyJson>("YObjectEscapedNullInKeyJson")({
    "foo\u0000bar": S.Int,
}) {}

export class YObjectEmptyKeyJson extends S.Class<YObjectEmptyKeyJson>("YObjectEmptyKeyJson")({
    "": S.Int,
}) {}

export class YObjectBasicJson extends S.Class<YObjectBasicJson>("YObjectBasicJson")({
    "asd": S.String,
}) {}

export class Json extends S.Class<Json>("Json")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "y_number_0e1.json": S.Array(S.Number),
    "y_array_arraysWithSpaces.json": S.Array(S.Array(S.Any)),
    "y_array_empty.json": S.Array(S.Any),
    "y_array_empty-string.json": S.Array(S.String),
    "y_array_ending_with_newline.json": S.Array(S.String),
    "y_array_false.json": S.Array(S.Boolean),
    "y_array_heterogeneous.json": S.Array(S.Union(S.Int, S.NumberFromString.pipe(S.int()), Json, S.Null)),
    "y_array_null.json": S.Array(S.Null),
    "y_array_with_1_and_newline.json": S.Array(S.Int),
    "y_array_with_leading_space.json": S.Array(S.Int),
    "y_array_with_several_null.json": S.Array(S.NullOr(S.Int)),
    "y_array_with_trailing_space.json": S.Array(S.Int),
    "y_number_0e+1.json": S.Array(S.Number),
    "y_number_after_space.json": S.Array(S.Int),
    "y_number_double_close_to_zero.json": S.Array(S.Number),
    "y_number_int_with_exp.json": S.Array(S.Number),
    "y_number.json": S.Array(S.Number),
    "y_number_minus_zero.json": S.Array(S.Int),
    "y_number_negative_int.json": S.Array(S.Int),
    "y_number_negative_one.json": S.Array(S.Int),
    "y_number_negative_zero.json": S.Array(S.Int),
    "y_number_real_capital_e.json": S.Array(S.Number),
    "y_number_real_capital_e_neg_exp.json": S.Array(S.Number),
    "y_number_real_capital_e_pos_exp.json": S.Array(S.Number),
    "y_number_real_exponent.json": S.Array(S.Number),
    "y_number_real_fraction_exponent.json": S.Array(S.Number),
    "y_number_real_neg_exp.json": S.Array(S.Number),
    "y_number_real_pos_exponent.json": S.Array(S.Number),
    "y_number_simple_int.json": S.Array(S.Int),
    "y_number_simple_real.json": S.Array(S.Number),
    "y_object_basic.json": YObjectBasicJson,
    "y_object_empty.json": Json,
    "y_object_empty_key.json": YObjectEmptyKeyJson,
    "y_object_escaped_null_in_key.json": YObjectEscapedNullInKeyJson,
    "y_object_extreme_numbers.json": YObjectExtremeNumbersJson,
    "y_object.json": YObjectJson,
    "y_object_long_strings.json": YObjectLongStringsJson,
    "y_object_simple.json": YObjectSimpleJson,
    "y_object_string_unicode.json": YObjectStringUnicodeJson,
    "y_object_with_newlines.json": YObjectWithNewlinesJson,
    "y_string_1_2_3_bytes_UTF-8_sequences.json": S.Array(S.String),
    "y_string_accepted_surrogate_pair.json": S.Array(S.String),
    "y_string_accepted_surrogate_pairs.json": S.Array(S.String),
    "y_string_allowed_escapes.json": S.Array(S.String),
    "y_string_backslash_and_u_escaped_zero.json": S.Array(S.String),
    "y_string_backslash_doublequotes.json": S.Array(S.String),
    "y_string_comments.json": S.Array(S.String),
    "y_string_double_escape_a.json": S.Array(S.String),
    "y_string_double_escape_n.json": S.Array(S.String),
    "y_string_escaped_control_character.json": S.Array(S.String),
    "y_string_escaped_noncharacter.json": S.Array(S.String),
    "y_string_in_array.json": S.Array(S.String),
    "y_string_in_array_with_leading_space.json": S.Array(S.String),
    "y_string_last_surrogates_1_and_2.json": S.Array(S.String),
    "y_string_nbsp_uescaped.json": S.Array(S.String),
    "y_string_nonCharacterInUTF-8_U+10FFFF.json": S.Array(S.String),
    "y_string_nonCharacterInUTF-8_U+1FFFF.json": S.Array(S.String),
    "y_string_nonCharacterInUTF-8_U+FFFF.json": S.Array(S.String),
    "y_string_null_escape.json": S.Array(S.String),
    "y_string_one-byte-utf-8.json": S.Array(S.String),
    "y_string_pi.json": S.Array(S.String),
    "y_string_simple_ascii.json": S.Array(S.String),
    "y_string_space.json": S.String,
    "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json": S.Array(S.String),
    "y_string_three-byte-utf-8.json": S.Array(S.String),
    "y_string_two-byte-utf-8.json": S.Array(S.String),
    "y_string_u+2028_line_sep.json": S.Array(S.String),
    "y_string_u+2029_par_sep.json": S.Array(S.String),
    "y_string_uEscape.json": S.Array(S.String),
    "y_string_uescaped_newline.json": S.Array(S.String),
    "y_string_unescaped_char_delete.json": S.Array(S.String),
    "y_string_unicode_2.json": S.Array(S.String),
    "y_string_unicodeEscapedBackslash.json": S.Array(S.String),
    "y_string_unicode_escaped_double_quote.json": S.Array(S.String),
    "y_string_unicode.json": S.Array(S.String),
    "y_string_unicode_U+10FFFE_nonchar.json": S.Array(S.String),
    "y_string_unicode_U+1FFFE_nonchar.json": S.Array(S.String),
    "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json": S.Array(S.String),
    "y_string_unicode_U+2064_invisible_plus.json": S.Array(S.String),
    "y_string_unicode_U+FDD0_nonchar.json": S.Array(S.String),
    "y_string_unicode_U+FFFE_nonchar.json": S.Array(S.String),
    "y_string_utf8.json": S.Array(S.String),
    "y_string_with_del_character.json": S.Array(S.String),
    "y_structure_lonely_false.json": S.Boolean,
    "y_structure_lonely_int.json": S.Int,
    "y_structure_lonely_negative_real.json": S.Number,
    "y_structure_lonely_null.json": S.Null,
    "y_structure_lonely_string.json": S.String,
    "y_structure_lonely_true.json": S.Boolean,
    "y_structure_string_empty.json": S.String,
    "y_structure_trailing_newline.json": S.Array(S.String),
    "y_structure_true_in_array.json": S.Array(S.Boolean),
    "y_structure_whitespace_array.json": S.Array(S.Any),
}) {}
