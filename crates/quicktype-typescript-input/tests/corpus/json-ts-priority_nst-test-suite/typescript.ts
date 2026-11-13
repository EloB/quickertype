export interface TopLevel {
    "y_array_arraysWithSpaces.json":                          Array<unknown[]>;
    "y_array_empty-string.json":                              string[];
    "y_array_empty.json":                                     unknown[];
    "y_array_ending_with_newline.json":                       string[];
    "y_array_false.json":                                     boolean[];
    "y_array_heterogeneous.json":                             Array<object | number | null | string>;
    "y_array_null.json":                                      null[];
    "y_array_with_1_and_newline.json":                        number[];
    "y_array_with_leading_space.json":                        number[];
    "y_array_with_several_null.json":                         Array<number | null>;
    "y_array_with_trailing_space.json":                       number[];
    "y_number.json":                                          number[];
    "y_number_0e+1.json":                                     number[];
    "y_number_0e1.json":                                      number[];
    "y_number_after_space.json":                              number[];
    "y_number_double_close_to_zero.json":                     number[];
    "y_number_int_with_exp.json":                             number[];
    "y_number_minus_zero.json":                               number[];
    "y_number_negative_int.json":                             number[];
    "y_number_negative_one.json":                             number[];
    "y_number_negative_zero.json":                            number[];
    "y_number_real_capital_e.json":                           number[];
    "y_number_real_capital_e_neg_exp.json":                   number[];
    "y_number_real_capital_e_pos_exp.json":                   number[];
    "y_number_real_exponent.json":                            number[];
    "y_number_real_fraction_exponent.json":                   number[];
    "y_number_real_neg_exp.json":                             number[];
    "y_number_real_pos_exponent.json":                        number[];
    "y_number_simple_int.json":                               number[];
    "y_number_simple_real.json":                              number[];
    "y_object.json":                                          YObjectJSON;
    "y_object_basic.json":                                    YObjectBasicJSON;
    "y_object_empty.json":                                    object;
    "y_object_empty_key.json":                                YObjectEmptyKeyJSON;
    "y_object_escaped_null_in_key.json":                      YObjectEscapedNullInKeyJSON;
    "y_object_extreme_numbers.json":                          YObjectExtremeNumbersJSON;
    "y_object_long_strings.json":                             YObjectLongStringsJSON;
    "y_object_simple.json":                                   YObjectSimpleJSON;
    "y_object_string_unicode.json":                           YObjectStringUnicodeJSON;
    "y_object_with_newlines.json":                            YObjectWithNewlinesJSON;
    "y_string_1_2_3_bytes_UTF-8_sequences.json":              string[];
    "y_string_accepted_surrogate_pair.json":                  string[];
    "y_string_accepted_surrogate_pairs.json":                 string[];
    "y_string_allowed_escapes.json":                          string[];
    "y_string_backslash_and_u_escaped_zero.json":             string[];
    "y_string_backslash_doublequotes.json":                   string[];
    "y_string_comments.json":                                 string[];
    "y_string_double_escape_a.json":                          string[];
    "y_string_double_escape_n.json":                          string[];
    "y_string_escaped_control_character.json":                string[];
    "y_string_escaped_noncharacter.json":                     string[];
    "y_string_in_array.json":                                 string[];
    "y_string_in_array_with_leading_space.json":              string[];
    "y_string_last_surrogates_1_and_2.json":                  string[];
    "y_string_nbsp_uescaped.json":                            string[];
    "y_string_nonCharacterInUTF-8_U+10FFFF.json":             string[];
    "y_string_nonCharacterInUTF-8_U+1FFFF.json":              string[];
    "y_string_nonCharacterInUTF-8_U+FFFF.json":               string[];
    "y_string_null_escape.json":                              string[];
    "y_string_one-byte-utf-8.json":                           string[];
    "y_string_pi.json":                                       string[];
    "y_string_simple_ascii.json":                             string[];
    "y_string_space.json":                                    string;
    "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json": string[];
    "y_string_three-byte-utf-8.json":                         string[];
    "y_string_two-byte-utf-8.json":                           string[];
    "y_string_u+2028_line_sep.json":                          string[];
    "y_string_u+2029_par_sep.json":                           string[];
    "y_string_uEscape.json":                                  string[];
    "y_string_uescaped_newline.json":                         string[];
    "y_string_unescaped_char_delete.json":                    string[];
    "y_string_unicode.json":                                  string[];
    "y_string_unicodeEscapedBackslash.json":                  string[];
    "y_string_unicode_2.json":                                string[];
    "y_string_unicode_U+10FFFE_nonchar.json":                 string[];
    "y_string_unicode_U+1FFFE_nonchar.json":                  string[];
    "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json":          string[];
    "y_string_unicode_U+2064_invisible_plus.json":            string[];
    "y_string_unicode_U+FDD0_nonchar.json":                   string[];
    "y_string_unicode_U+FFFE_nonchar.json":                   string[];
    "y_string_unicode_escaped_double_quote.json":             string[];
    "y_string_utf8.json":                                     string[];
    "y_string_with_del_character.json":                       string[];
    "y_structure_lonely_false.json":                          boolean;
    "y_structure_lonely_int.json":                            number;
    "y_structure_lonely_negative_real.json":                  number;
    "y_structure_lonely_null.json":                           null;
    "y_structure_lonely_string.json":                         string;
    "y_structure_lonely_true.json":                           boolean;
    "y_structure_string_empty.json":                          string;
    "y_structure_trailing_newline.json":                      string[];
    "y_structure_true_in_array.json":                         boolean[];
    "y_structure_whitespace_array.json":                      unknown[];
}

export interface YObjectJSON {
    asd: string;
    dfg: string;
}

export interface YObjectBasicJSON {
    asd: string;
}

export interface YObjectEmptyKeyJSON {
    "": number;
}

export interface YObjectEscapedNullInKeyJSON {
    "foo\u0000bar": number;
}

export interface YObjectExtremeNumbersJSON {
    max: number;
    min: number;
}

export interface YObjectLongStringsJSON {
    id: string;
    x:  X[];
}

export interface X {
    id: string;
}

export interface YObjectSimpleJSON {
    a: unknown[];
}

export interface YObjectStringUnicodeJSON {
    title: string;
}

export interface YObjectWithNewlinesJSON {
    a: string;
}
