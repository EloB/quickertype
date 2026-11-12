import * as z from "zod";


export const JsonSchema = z.object({
});
export type Json = z.infer<typeof JsonSchema>;

export const YObjectBasicJsonSchema = z.object({
    "asd": z.string(),
});
export type YObjectBasicJson = z.infer<typeof YObjectBasicJsonSchema>;

export const YObjectEmptyKeyJsonSchema = z.object({
    "": z.number().int(),
});
export type YObjectEmptyKeyJson = z.infer<typeof YObjectEmptyKeyJsonSchema>;

export const YObjectEscapedNullInKeyJsonSchema = z.object({
    "foo\u0000bar": z.number().int(),
});
export type YObjectEscapedNullInKeyJson = z.infer<typeof YObjectEscapedNullInKeyJsonSchema>;

export const YObjectExtremeNumbersJsonSchema = z.object({
    "max": z.number(),
    "min": z.number(),
});
export type YObjectExtremeNumbersJson = z.infer<typeof YObjectExtremeNumbersJsonSchema>;

export const YObjectJsonSchema = z.object({
    "asd": z.string(),
    "dfg": z.string(),
});
export type YObjectJson = z.infer<typeof YObjectJsonSchema>;

export const XSchema = z.object({
    "id": z.string(),
});
export type X = z.infer<typeof XSchema>;

export const YObjectSimpleJsonSchema = z.object({
    "a": z.array(z.any()),
});
export type YObjectSimpleJson = z.infer<typeof YObjectSimpleJsonSchema>;

export const YObjectStringUnicodeJsonSchema = z.object({
    "title": z.string(),
});
export type YObjectStringUnicodeJson = z.infer<typeof YObjectStringUnicodeJsonSchema>;

export const YObjectWithNewlinesJsonSchema = z.object({
    "a": z.string(),
});
export type YObjectWithNewlinesJson = z.infer<typeof YObjectWithNewlinesJsonSchema>;

export const YObjectLongStringsJsonSchema = z.object({
    "id": z.string(),
    "x": z.array(XSchema),
});
export type YObjectLongStringsJson = z.infer<typeof YObjectLongStringsJsonSchema>;

export const TopLevelSchema = z.object({
    "y_number_0e1.json": z.array(z.number()),
    "y_array_arraysWithSpaces.json": z.array(z.array(z.any())),
    "y_array_empty.json": z.array(z.any()),
    "y_array_empty-string.json": z.array(z.string()),
    "y_array_ending_with_newline.json": z.array(z.string()),
    "y_array_false.json": z.array(z.boolean()),
    "y_array_heterogeneous.json": z.array(z.union([z.null(), JsonSchema, z.number().int(), z.string().regex(/^-?\d+$/).transform(Number)])),
    "y_array_null.json": z.array(z.null()),
    "y_array_with_1_and_newline.json": z.array(z.number().int()),
    "y_array_with_leading_space.json": z.array(z.number().int()),
    "y_array_with_several_null.json": z.array(z.union([z.null(), z.number().int()])),
    "y_array_with_trailing_space.json": z.array(z.number().int()),
    "y_number_0e+1.json": z.array(z.number()),
    "y_number_after_space.json": z.array(z.number().int()),
    "y_number_double_close_to_zero.json": z.array(z.number()),
    "y_number_int_with_exp.json": z.array(z.number()),
    "y_number.json": z.array(z.number()),
    "y_number_minus_zero.json": z.array(z.number().int()),
    "y_number_negative_int.json": z.array(z.number().int()),
    "y_number_negative_one.json": z.array(z.number().int()),
    "y_number_negative_zero.json": z.array(z.number().int()),
    "y_number_real_capital_e.json": z.array(z.number()),
    "y_number_real_capital_e_neg_exp.json": z.array(z.number()),
    "y_number_real_capital_e_pos_exp.json": z.array(z.number()),
    "y_number_real_exponent.json": z.array(z.number()),
    "y_number_real_fraction_exponent.json": z.array(z.number()),
    "y_number_real_neg_exp.json": z.array(z.number()),
    "y_number_real_pos_exponent.json": z.array(z.number()),
    "y_number_simple_int.json": z.array(z.number().int()),
    "y_number_simple_real.json": z.array(z.number()),
    "y_object_basic.json": YObjectBasicJsonSchema,
    "y_object_empty.json": JsonSchema,
    "y_object_empty_key.json": YObjectEmptyKeyJsonSchema,
    "y_object_escaped_null_in_key.json": YObjectEscapedNullInKeyJsonSchema,
    "y_object_extreme_numbers.json": YObjectExtremeNumbersJsonSchema,
    "y_object.json": YObjectJsonSchema,
    "y_object_long_strings.json": YObjectLongStringsJsonSchema,
    "y_object_simple.json": YObjectSimpleJsonSchema,
    "y_object_string_unicode.json": YObjectStringUnicodeJsonSchema,
    "y_object_with_newlines.json": YObjectWithNewlinesJsonSchema,
    "y_string_1_2_3_bytes_UTF-8_sequences.json": z.array(z.string()),
    "y_string_accepted_surrogate_pair.json": z.array(z.string()),
    "y_string_accepted_surrogate_pairs.json": z.array(z.string()),
    "y_string_allowed_escapes.json": z.array(z.string()),
    "y_string_backslash_and_u_escaped_zero.json": z.array(z.string()),
    "y_string_backslash_doublequotes.json": z.array(z.string()),
    "y_string_comments.json": z.array(z.string()),
    "y_string_double_escape_a.json": z.array(z.string()),
    "y_string_double_escape_n.json": z.array(z.string()),
    "y_string_escaped_control_character.json": z.array(z.string()),
    "y_string_escaped_noncharacter.json": z.array(z.string()),
    "y_string_in_array.json": z.array(z.string()),
    "y_string_in_array_with_leading_space.json": z.array(z.string()),
    "y_string_last_surrogates_1_and_2.json": z.array(z.string()),
    "y_string_nbsp_uescaped.json": z.array(z.string()),
    "y_string_nonCharacterInUTF-8_U+10FFFF.json": z.array(z.string()),
    "y_string_nonCharacterInUTF-8_U+1FFFF.json": z.array(z.string()),
    "y_string_nonCharacterInUTF-8_U+FFFF.json": z.array(z.string()),
    "y_string_null_escape.json": z.array(z.string()),
    "y_string_one-byte-utf-8.json": z.array(z.string()),
    "y_string_pi.json": z.array(z.string()),
    "y_string_simple_ascii.json": z.array(z.string()),
    "y_string_space.json": z.string(),
    "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json": z.array(z.string()),
    "y_string_three-byte-utf-8.json": z.array(z.string()),
    "y_string_two-byte-utf-8.json": z.array(z.string()),
    "y_string_u+2028_line_sep.json": z.array(z.string()),
    "y_string_u+2029_par_sep.json": z.array(z.string()),
    "y_string_uEscape.json": z.array(z.string()),
    "y_string_uescaped_newline.json": z.array(z.string()),
    "y_string_unescaped_char_delete.json": z.array(z.string()),
    "y_string_unicode_2.json": z.array(z.string()),
    "y_string_unicodeEscapedBackslash.json": z.array(z.string()),
    "y_string_unicode_escaped_double_quote.json": z.array(z.string()),
    "y_string_unicode.json": z.array(z.string()),
    "y_string_unicode_U+10FFFE_nonchar.json": z.array(z.string()),
    "y_string_unicode_U+1FFFE_nonchar.json": z.array(z.string()),
    "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json": z.array(z.string()),
    "y_string_unicode_U+2064_invisible_plus.json": z.array(z.string()),
    "y_string_unicode_U+FDD0_nonchar.json": z.array(z.string()),
    "y_string_unicode_U+FFFE_nonchar.json": z.array(z.string()),
    "y_string_utf8.json": z.array(z.string()),
    "y_string_with_del_character.json": z.array(z.string()),
    "y_structure_lonely_false.json": z.boolean(),
    "y_structure_lonely_int.json": z.number().int(),
    "y_structure_lonely_negative_real.json": z.number(),
    "y_structure_lonely_null.json": z.null(),
    "y_structure_lonely_string.json": z.string(),
    "y_structure_lonely_true.json": z.boolean(),
    "y_structure_string_empty.json": z.string(),
    "y_structure_trailing_newline.json": z.array(z.string()),
    "y_structure_true_in_array.json": z.array(z.boolean()),
    "y_structure_whitespace_array.json": z.array(z.any()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
