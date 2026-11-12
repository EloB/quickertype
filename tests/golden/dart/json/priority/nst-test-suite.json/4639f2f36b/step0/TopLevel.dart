// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<double> topLevelYNumber0E1Json;
    final List<List<dynamic>> yArrayArraysWithSpacesJson;
    final List<dynamic> yArrayEmptyJson;
    final List<String> yArrayEmptyStringJson;
    final List<String> yArrayEndingWithNewlineJson;
    final List<bool> yArrayFalseJson;
    final List<dynamic> yArrayHeterogeneousJson;
    final List<dynamic> yArrayNullJson;
    final List<int> yArrayWith1AndNewlineJson;
    final List<int> yArrayWithLeadingSpaceJson;
    final List<int?> yArrayWithSeveralNullJson;
    final List<int> yArrayWithTrailingSpaceJson;
    final List<double> yNumber0E1Json;
    final List<int> yNumberAfterSpaceJson;
    final List<double> yNumberDoubleCloseToZeroJson;
    final List<double> yNumberIntWithExpJson;
    final List<double> yNumberJson;
    final List<int> yNumberMinusZeroJson;
    final List<int> yNumberNegativeIntJson;
    final List<int> yNumberNegativeOneJson;
    final List<int> yNumberNegativeZeroJson;
    final List<double> yNumberRealCapitalEJson;
    final List<double> yNumberRealCapitalENegExpJson;
    final List<double> yNumberRealCapitalEPosExpJson;
    final List<double> yNumberRealExponentJson;
    final List<double> yNumberRealFractionExponentJson;
    final List<double> yNumberRealNegExpJson;
    final List<double> yNumberRealPosExponentJson;
    final List<int> yNumberSimpleIntJson;
    final List<double> yNumberSimpleRealJson;
    final YObjectBasicJson yObjectBasicJson;
    final Json yObjectEmptyJson;
    final YObjectEmptyKeyJson yObjectEmptyKeyJson;
    final YObjectEscapedNullInKeyJson yObjectEscapedNullInKeyJson;
    final YObjectExtremeNumbersJson yObjectExtremeNumbersJson;
    final YObjectJson yObjectJson;
    final YObjectLongStringsJson yObjectLongStringsJson;
    final YObjectSimpleJson yObjectSimpleJson;
    final YObjectStringUnicodeJson yObjectStringUnicodeJson;
    final YObjectWithNewlinesJson yObjectWithNewlinesJson;
    final List<String> yString123BytesUtf8SequencesJson;
    final List<String> yStringAcceptedSurrogatePairJson;
    final List<String> yStringAcceptedSurrogatePairsJson;
    final List<String> yStringAllowedEscapesJson;
    final List<String> yStringBackslashAndUEscapedZeroJson;
    final List<String> yStringBackslashDoublequotesJson;
    final List<String> yStringCommentsJson;
    final List<String> yStringDoubleEscapeAJson;
    final List<String> yStringDoubleEscapeNJson;
    final List<String> yStringEscapedControlCharacterJson;
    final List<String> yStringEscapedNoncharacterJson;
    final List<String> yStringInArrayJson;
    final List<String> yStringInArrayWithLeadingSpaceJson;
    final List<String> yStringLastSurrogates1And2Json;
    final List<String> yStringNbspUescapedJson;
    final List<String> yStringNonCharacterInUtf8U10FfffJson;
    final List<String> yStringNonCharacterInUtf8U1FfffJson;
    final List<String> yStringNonCharacterInUtf8UFfffJson;
    final List<String> yStringNullEscapeJson;
    final List<String> yStringOneByteUtf8Json;
    final List<String> yStringPiJson;
    final List<String> yStringSimpleAsciiJson;
    final String yStringSpaceJson;
    final List<String> yStringSurrogatesU1D11EMusicalSymbolGClefJson;
    final List<String> yStringThreeByteUtf8Json;
    final List<String> yStringTwoByteUtf8Json;
    final List<String> yStringU2028LineSepJson;
    final List<String> yStringU2029ParSepJson;
    final List<String> yStringUEscapeJson;
    final List<String> yStringUescapedNewlineJson;
    final List<String> yStringUnescapedCharDeleteJson;
    final List<String> yStringUnicode2Json;
    final List<String> yStringUnicodeEscapedBackslashJson;
    final List<String> yStringUnicodeEscapedDoubleQuoteJson;
    final List<String> yStringUnicodeJson;
    final List<String> yStringUnicodeU10FffeNoncharJson;
    final List<String> yStringUnicodeU1FffeNoncharJson;
    final List<String> yStringUnicodeU200BZeroWidthSpaceJson;
    final List<String> yStringUnicodeU2064InvisiblePlusJson;
    final List<String> yStringUnicodeUFdd0NoncharJson;
    final List<String> yStringUnicodeUFffeNoncharJson;
    final List<String> yStringUtf8Json;
    final List<String> yStringWithDelCharacterJson;
    final bool yStructureLonelyFalseJson;
    final int yStructureLonelyIntJson;
    final double yStructureLonelyNegativeRealJson;
    final dynamic yStructureLonelyNullJson;
    final String yStructureLonelyStringJson;
    final bool yStructureLonelyTrueJson;
    final String yStructureStringEmptyJson;
    final List<String> yStructureTrailingNewlineJson;
    final List<bool> yStructureTrueInArrayJson;
    final List<dynamic> yStructureWhitespaceArrayJson;

    TopLevel({
        required this.topLevelYNumber0E1Json,
        required this.yArrayArraysWithSpacesJson,
        required this.yArrayEmptyJson,
        required this.yArrayEmptyStringJson,
        required this.yArrayEndingWithNewlineJson,
        required this.yArrayFalseJson,
        required this.yArrayHeterogeneousJson,
        required this.yArrayNullJson,
        required this.yArrayWith1AndNewlineJson,
        required this.yArrayWithLeadingSpaceJson,
        required this.yArrayWithSeveralNullJson,
        required this.yArrayWithTrailingSpaceJson,
        required this.yNumber0E1Json,
        required this.yNumberAfterSpaceJson,
        required this.yNumberDoubleCloseToZeroJson,
        required this.yNumberIntWithExpJson,
        required this.yNumberJson,
        required this.yNumberMinusZeroJson,
        required this.yNumberNegativeIntJson,
        required this.yNumberNegativeOneJson,
        required this.yNumberNegativeZeroJson,
        required this.yNumberRealCapitalEJson,
        required this.yNumberRealCapitalENegExpJson,
        required this.yNumberRealCapitalEPosExpJson,
        required this.yNumberRealExponentJson,
        required this.yNumberRealFractionExponentJson,
        required this.yNumberRealNegExpJson,
        required this.yNumberRealPosExponentJson,
        required this.yNumberSimpleIntJson,
        required this.yNumberSimpleRealJson,
        required this.yObjectBasicJson,
        required this.yObjectEmptyJson,
        required this.yObjectEmptyKeyJson,
        required this.yObjectEscapedNullInKeyJson,
        required this.yObjectExtremeNumbersJson,
        required this.yObjectJson,
        required this.yObjectLongStringsJson,
        required this.yObjectSimpleJson,
        required this.yObjectStringUnicodeJson,
        required this.yObjectWithNewlinesJson,
        required this.yString123BytesUtf8SequencesJson,
        required this.yStringAcceptedSurrogatePairJson,
        required this.yStringAcceptedSurrogatePairsJson,
        required this.yStringAllowedEscapesJson,
        required this.yStringBackslashAndUEscapedZeroJson,
        required this.yStringBackslashDoublequotesJson,
        required this.yStringCommentsJson,
        required this.yStringDoubleEscapeAJson,
        required this.yStringDoubleEscapeNJson,
        required this.yStringEscapedControlCharacterJson,
        required this.yStringEscapedNoncharacterJson,
        required this.yStringInArrayJson,
        required this.yStringInArrayWithLeadingSpaceJson,
        required this.yStringLastSurrogates1And2Json,
        required this.yStringNbspUescapedJson,
        required this.yStringNonCharacterInUtf8U10FfffJson,
        required this.yStringNonCharacterInUtf8U1FfffJson,
        required this.yStringNonCharacterInUtf8UFfffJson,
        required this.yStringNullEscapeJson,
        required this.yStringOneByteUtf8Json,
        required this.yStringPiJson,
        required this.yStringSimpleAsciiJson,
        required this.yStringSpaceJson,
        required this.yStringSurrogatesU1D11EMusicalSymbolGClefJson,
        required this.yStringThreeByteUtf8Json,
        required this.yStringTwoByteUtf8Json,
        required this.yStringU2028LineSepJson,
        required this.yStringU2029ParSepJson,
        required this.yStringUEscapeJson,
        required this.yStringUescapedNewlineJson,
        required this.yStringUnescapedCharDeleteJson,
        required this.yStringUnicode2Json,
        required this.yStringUnicodeEscapedBackslashJson,
        required this.yStringUnicodeEscapedDoubleQuoteJson,
        required this.yStringUnicodeJson,
        required this.yStringUnicodeU10FffeNoncharJson,
        required this.yStringUnicodeU1FffeNoncharJson,
        required this.yStringUnicodeU200BZeroWidthSpaceJson,
        required this.yStringUnicodeU2064InvisiblePlusJson,
        required this.yStringUnicodeUFdd0NoncharJson,
        required this.yStringUnicodeUFffeNoncharJson,
        required this.yStringUtf8Json,
        required this.yStringWithDelCharacterJson,
        required this.yStructureLonelyFalseJson,
        required this.yStructureLonelyIntJson,
        required this.yStructureLonelyNegativeRealJson,
        required this.yStructureLonelyNullJson,
        required this.yStructureLonelyStringJson,
        required this.yStructureLonelyTrueJson,
        required this.yStructureStringEmptyJson,
        required this.yStructureTrailingNewlineJson,
        required this.yStructureTrueInArrayJson,
        required this.yStructureWhitespaceArrayJson,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        topLevelYNumber0E1Json: List<double>.from(json["y_number_0e1.json"].map((x) => x?.toDouble())),
        yArrayArraysWithSpacesJson: List<List<dynamic>>.from(json["y_array_arraysWithSpaces.json"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        yArrayEmptyJson: List<dynamic>.from(json["y_array_empty.json"].map((x) => x)),
        yArrayEmptyStringJson: List<String>.from(json["y_array_empty-string.json"].map((x) => x)),
        yArrayEndingWithNewlineJson: List<String>.from(json["y_array_ending_with_newline.json"].map((x) => x)),
        yArrayFalseJson: List<bool>.from(json["y_array_false.json"].map((x) => x)),
        yArrayHeterogeneousJson: List<dynamic>.from(json["y_array_heterogeneous.json"].map((x) => x)),
        yArrayNullJson: List<dynamic>.from(json["y_array_null.json"].map((x) => x)),
        yArrayWith1AndNewlineJson: List<int>.from(json["y_array_with_1_and_newline.json"].map((x) => x)),
        yArrayWithLeadingSpaceJson: List<int>.from(json["y_array_with_leading_space.json"].map((x) => x)),
        yArrayWithSeveralNullJson: List<int?>.from(json["y_array_with_several_null.json"].map((x) => x)),
        yArrayWithTrailingSpaceJson: List<int>.from(json["y_array_with_trailing_space.json"].map((x) => x)),
        yNumber0E1Json: List<double>.from(json["y_number_0e+1.json"].map((x) => x?.toDouble())),
        yNumberAfterSpaceJson: List<int>.from(json["y_number_after_space.json"].map((x) => x)),
        yNumberDoubleCloseToZeroJson: List<double>.from(json["y_number_double_close_to_zero.json"].map((x) => x?.toDouble())),
        yNumberIntWithExpJson: List<double>.from(json["y_number_int_with_exp.json"].map((x) => x?.toDouble())),
        yNumberJson: List<double>.from(json["y_number.json"].map((x) => x?.toDouble())),
        yNumberMinusZeroJson: List<int>.from(json["y_number_minus_zero.json"].map((x) => x)),
        yNumberNegativeIntJson: List<int>.from(json["y_number_negative_int.json"].map((x) => x)),
        yNumberNegativeOneJson: List<int>.from(json["y_number_negative_one.json"].map((x) => x)),
        yNumberNegativeZeroJson: List<int>.from(json["y_number_negative_zero.json"].map((x) => x)),
        yNumberRealCapitalEJson: List<double>.from(json["y_number_real_capital_e.json"].map((x) => x?.toDouble())),
        yNumberRealCapitalENegExpJson: List<double>.from(json["y_number_real_capital_e_neg_exp.json"].map((x) => x?.toDouble())),
        yNumberRealCapitalEPosExpJson: List<double>.from(json["y_number_real_capital_e_pos_exp.json"].map((x) => x?.toDouble())),
        yNumberRealExponentJson: List<double>.from(json["y_number_real_exponent.json"].map((x) => x?.toDouble())),
        yNumberRealFractionExponentJson: List<double>.from(json["y_number_real_fraction_exponent.json"].map((x) => x?.toDouble())),
        yNumberRealNegExpJson: List<double>.from(json["y_number_real_neg_exp.json"].map((x) => x?.toDouble())),
        yNumberRealPosExponentJson: List<double>.from(json["y_number_real_pos_exponent.json"].map((x) => x?.toDouble())),
        yNumberSimpleIntJson: List<int>.from(json["y_number_simple_int.json"].map((x) => x)),
        yNumberSimpleRealJson: List<double>.from(json["y_number_simple_real.json"].map((x) => x?.toDouble())),
        yObjectBasicJson: YObjectBasicJson.fromJson(json["y_object_basic.json"]),
        yObjectEmptyJson: Json.fromJson(json["y_object_empty.json"]),
        yObjectEmptyKeyJson: YObjectEmptyKeyJson.fromJson(json["y_object_empty_key.json"]),
        yObjectEscapedNullInKeyJson: YObjectEscapedNullInKeyJson.fromJson(json["y_object_escaped_null_in_key.json"]),
        yObjectExtremeNumbersJson: YObjectExtremeNumbersJson.fromJson(json["y_object_extreme_numbers.json"]),
        yObjectJson: YObjectJson.fromJson(json["y_object.json"]),
        yObjectLongStringsJson: YObjectLongStringsJson.fromJson(json["y_object_long_strings.json"]),
        yObjectSimpleJson: YObjectSimpleJson.fromJson(json["y_object_simple.json"]),
        yObjectStringUnicodeJson: YObjectStringUnicodeJson.fromJson(json["y_object_string_unicode.json"]),
        yObjectWithNewlinesJson: YObjectWithNewlinesJson.fromJson(json["y_object_with_newlines.json"]),
        yString123BytesUtf8SequencesJson: List<String>.from(json["y_string_1_2_3_bytes_UTF-8_sequences.json"].map((x) => x)),
        yStringAcceptedSurrogatePairJson: List<String>.from(json["y_string_accepted_surrogate_pair.json"].map((x) => x)),
        yStringAcceptedSurrogatePairsJson: List<String>.from(json["y_string_accepted_surrogate_pairs.json"].map((x) => x)),
        yStringAllowedEscapesJson: List<String>.from(json["y_string_allowed_escapes.json"].map((x) => x)),
        yStringBackslashAndUEscapedZeroJson: List<String>.from(json["y_string_backslash_and_u_escaped_zero.json"].map((x) => x)),
        yStringBackslashDoublequotesJson: List<String>.from(json["y_string_backslash_doublequotes.json"].map((x) => x)),
        yStringCommentsJson: List<String>.from(json["y_string_comments.json"].map((x) => x)),
        yStringDoubleEscapeAJson: List<String>.from(json["y_string_double_escape_a.json"].map((x) => x)),
        yStringDoubleEscapeNJson: List<String>.from(json["y_string_double_escape_n.json"].map((x) => x)),
        yStringEscapedControlCharacterJson: List<String>.from(json["y_string_escaped_control_character.json"].map((x) => x)),
        yStringEscapedNoncharacterJson: List<String>.from(json["y_string_escaped_noncharacter.json"].map((x) => x)),
        yStringInArrayJson: List<String>.from(json["y_string_in_array.json"].map((x) => x)),
        yStringInArrayWithLeadingSpaceJson: List<String>.from(json["y_string_in_array_with_leading_space.json"].map((x) => x)),
        yStringLastSurrogates1And2Json: List<String>.from(json["y_string_last_surrogates_1_and_2.json"].map((x) => x)),
        yStringNbspUescapedJson: List<String>.from(json["y_string_nbsp_uescaped.json"].map((x) => x)),
        yStringNonCharacterInUtf8U10FfffJson: List<String>.from(json["y_string_nonCharacterInUTF-8_U+10FFFF.json"].map((x) => x)),
        yStringNonCharacterInUtf8U1FfffJson: List<String>.from(json["y_string_nonCharacterInUTF-8_U+1FFFF.json"].map((x) => x)),
        yStringNonCharacterInUtf8UFfffJson: List<String>.from(json["y_string_nonCharacterInUTF-8_U+FFFF.json"].map((x) => x)),
        yStringNullEscapeJson: List<String>.from(json["y_string_null_escape.json"].map((x) => x)),
        yStringOneByteUtf8Json: List<String>.from(json["y_string_one-byte-utf-8.json"].map((x) => x)),
        yStringPiJson: List<String>.from(json["y_string_pi.json"].map((x) => x)),
        yStringSimpleAsciiJson: List<String>.from(json["y_string_simple_ascii.json"].map((x) => x)),
        yStringSpaceJson: json["y_string_space.json"],
        yStringSurrogatesU1D11EMusicalSymbolGClefJson: List<String>.from(json["y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"].map((x) => x)),
        yStringThreeByteUtf8Json: List<String>.from(json["y_string_three-byte-utf-8.json"].map((x) => x)),
        yStringTwoByteUtf8Json: List<String>.from(json["y_string_two-byte-utf-8.json"].map((x) => x)),
        yStringU2028LineSepJson: List<String>.from(json["y_string_u+2028_line_sep.json"].map((x) => x)),
        yStringU2029ParSepJson: List<String>.from(json["y_string_u+2029_par_sep.json"].map((x) => x)),
        yStringUEscapeJson: List<String>.from(json["y_string_uEscape.json"].map((x) => x)),
        yStringUescapedNewlineJson: List<String>.from(json["y_string_uescaped_newline.json"].map((x) => x)),
        yStringUnescapedCharDeleteJson: List<String>.from(json["y_string_unescaped_char_delete.json"].map((x) => x)),
        yStringUnicode2Json: List<String>.from(json["y_string_unicode_2.json"].map((x) => x)),
        yStringUnicodeEscapedBackslashJson: List<String>.from(json["y_string_unicodeEscapedBackslash.json"].map((x) => x)),
        yStringUnicodeEscapedDoubleQuoteJson: List<String>.from(json["y_string_unicode_escaped_double_quote.json"].map((x) => x)),
        yStringUnicodeJson: List<String>.from(json["y_string_unicode.json"].map((x) => x)),
        yStringUnicodeU10FffeNoncharJson: List<String>.from(json["y_string_unicode_U+10FFFE_nonchar.json"].map((x) => x)),
        yStringUnicodeU1FffeNoncharJson: List<String>.from(json["y_string_unicode_U+1FFFE_nonchar.json"].map((x) => x)),
        yStringUnicodeU200BZeroWidthSpaceJson: List<String>.from(json["y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"].map((x) => x)),
        yStringUnicodeU2064InvisiblePlusJson: List<String>.from(json["y_string_unicode_U+2064_invisible_plus.json"].map((x) => x)),
        yStringUnicodeUFdd0NoncharJson: List<String>.from(json["y_string_unicode_U+FDD0_nonchar.json"].map((x) => x)),
        yStringUnicodeUFffeNoncharJson: List<String>.from(json["y_string_unicode_U+FFFE_nonchar.json"].map((x) => x)),
        yStringUtf8Json: List<String>.from(json["y_string_utf8.json"].map((x) => x)),
        yStringWithDelCharacterJson: List<String>.from(json["y_string_with_del_character.json"].map((x) => x)),
        yStructureLonelyFalseJson: json["y_structure_lonely_false.json"],
        yStructureLonelyIntJson: json["y_structure_lonely_int.json"],
        yStructureLonelyNegativeRealJson: json["y_structure_lonely_negative_real.json"]?.toDouble(),
        yStructureLonelyNullJson: (json.containsKey("y_structure_lonely_null.json") ? json["y_structure_lonely_null.json"] : throw FormatException('Missing required property')),
        yStructureLonelyStringJson: json["y_structure_lonely_string.json"],
        yStructureLonelyTrueJson: json["y_structure_lonely_true.json"],
        yStructureStringEmptyJson: json["y_structure_string_empty.json"],
        yStructureTrailingNewlineJson: List<String>.from(json["y_structure_trailing_newline.json"].map((x) => x)),
        yStructureTrueInArrayJson: List<bool>.from(json["y_structure_true_in_array.json"].map((x) => x)),
        yStructureWhitespaceArrayJson: List<dynamic>.from(json["y_structure_whitespace_array.json"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "y_number_0e1.json": List<dynamic>.from(topLevelYNumber0E1Json.map((x) => x)),
        "y_array_arraysWithSpaces.json": List<dynamic>.from(yArrayArraysWithSpacesJson.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "y_array_empty.json": List<dynamic>.from(yArrayEmptyJson.map((x) => x)),
        "y_array_empty-string.json": List<dynamic>.from(yArrayEmptyStringJson.map((x) => x)),
        "y_array_ending_with_newline.json": List<dynamic>.from(yArrayEndingWithNewlineJson.map((x) => x)),
        "y_array_false.json": List<dynamic>.from(yArrayFalseJson.map((x) => x)),
        "y_array_heterogeneous.json": List<dynamic>.from(yArrayHeterogeneousJson.map((x) => x)),
        "y_array_null.json": List<dynamic>.from(yArrayNullJson.map((x) => x)),
        "y_array_with_1_and_newline.json": List<dynamic>.from(yArrayWith1AndNewlineJson.map((x) => x)),
        "y_array_with_leading_space.json": List<dynamic>.from(yArrayWithLeadingSpaceJson.map((x) => x)),
        "y_array_with_several_null.json": List<dynamic>.from(yArrayWithSeveralNullJson.map((x) => x)),
        "y_array_with_trailing_space.json": List<dynamic>.from(yArrayWithTrailingSpaceJson.map((x) => x)),
        "y_number_0e+1.json": List<dynamic>.from(yNumber0E1Json.map((x) => x)),
        "y_number_after_space.json": List<dynamic>.from(yNumberAfterSpaceJson.map((x) => x)),
        "y_number_double_close_to_zero.json": List<dynamic>.from(yNumberDoubleCloseToZeroJson.map((x) => x)),
        "y_number_int_with_exp.json": List<dynamic>.from(yNumberIntWithExpJson.map((x) => x)),
        "y_number.json": List<dynamic>.from(yNumberJson.map((x) => x)),
        "y_number_minus_zero.json": List<dynamic>.from(yNumberMinusZeroJson.map((x) => x)),
        "y_number_negative_int.json": List<dynamic>.from(yNumberNegativeIntJson.map((x) => x)),
        "y_number_negative_one.json": List<dynamic>.from(yNumberNegativeOneJson.map((x) => x)),
        "y_number_negative_zero.json": List<dynamic>.from(yNumberNegativeZeroJson.map((x) => x)),
        "y_number_real_capital_e.json": List<dynamic>.from(yNumberRealCapitalEJson.map((x) => x)),
        "y_number_real_capital_e_neg_exp.json": List<dynamic>.from(yNumberRealCapitalENegExpJson.map((x) => x)),
        "y_number_real_capital_e_pos_exp.json": List<dynamic>.from(yNumberRealCapitalEPosExpJson.map((x) => x)),
        "y_number_real_exponent.json": List<dynamic>.from(yNumberRealExponentJson.map((x) => x)),
        "y_number_real_fraction_exponent.json": List<dynamic>.from(yNumberRealFractionExponentJson.map((x) => x)),
        "y_number_real_neg_exp.json": List<dynamic>.from(yNumberRealNegExpJson.map((x) => x)),
        "y_number_real_pos_exponent.json": List<dynamic>.from(yNumberRealPosExponentJson.map((x) => x)),
        "y_number_simple_int.json": List<dynamic>.from(yNumberSimpleIntJson.map((x) => x)),
        "y_number_simple_real.json": List<dynamic>.from(yNumberSimpleRealJson.map((x) => x)),
        "y_object_basic.json": yObjectBasicJson.toJson(),
        "y_object_empty.json": yObjectEmptyJson.toJson(),
        "y_object_empty_key.json": yObjectEmptyKeyJson.toJson(),
        "y_object_escaped_null_in_key.json": yObjectEscapedNullInKeyJson.toJson(),
        "y_object_extreme_numbers.json": yObjectExtremeNumbersJson.toJson(),
        "y_object.json": yObjectJson.toJson(),
        "y_object_long_strings.json": yObjectLongStringsJson.toJson(),
        "y_object_simple.json": yObjectSimpleJson.toJson(),
        "y_object_string_unicode.json": yObjectStringUnicodeJson.toJson(),
        "y_object_with_newlines.json": yObjectWithNewlinesJson.toJson(),
        "y_string_1_2_3_bytes_UTF-8_sequences.json": List<dynamic>.from(yString123BytesUtf8SequencesJson.map((x) => x)),
        "y_string_accepted_surrogate_pair.json": List<dynamic>.from(yStringAcceptedSurrogatePairJson.map((x) => x)),
        "y_string_accepted_surrogate_pairs.json": List<dynamic>.from(yStringAcceptedSurrogatePairsJson.map((x) => x)),
        "y_string_allowed_escapes.json": List<dynamic>.from(yStringAllowedEscapesJson.map((x) => x)),
        "y_string_backslash_and_u_escaped_zero.json": List<dynamic>.from(yStringBackslashAndUEscapedZeroJson.map((x) => x)),
        "y_string_backslash_doublequotes.json": List<dynamic>.from(yStringBackslashDoublequotesJson.map((x) => x)),
        "y_string_comments.json": List<dynamic>.from(yStringCommentsJson.map((x) => x)),
        "y_string_double_escape_a.json": List<dynamic>.from(yStringDoubleEscapeAJson.map((x) => x)),
        "y_string_double_escape_n.json": List<dynamic>.from(yStringDoubleEscapeNJson.map((x) => x)),
        "y_string_escaped_control_character.json": List<dynamic>.from(yStringEscapedControlCharacterJson.map((x) => x)),
        "y_string_escaped_noncharacter.json": List<dynamic>.from(yStringEscapedNoncharacterJson.map((x) => x)),
        "y_string_in_array.json": List<dynamic>.from(yStringInArrayJson.map((x) => x)),
        "y_string_in_array_with_leading_space.json": List<dynamic>.from(yStringInArrayWithLeadingSpaceJson.map((x) => x)),
        "y_string_last_surrogates_1_and_2.json": List<dynamic>.from(yStringLastSurrogates1And2Json.map((x) => x)),
        "y_string_nbsp_uescaped.json": List<dynamic>.from(yStringNbspUescapedJson.map((x) => x)),
        "y_string_nonCharacterInUTF-8_U+10FFFF.json": List<dynamic>.from(yStringNonCharacterInUtf8U10FfffJson.map((x) => x)),
        "y_string_nonCharacterInUTF-8_U+1FFFF.json": List<dynamic>.from(yStringNonCharacterInUtf8U1FfffJson.map((x) => x)),
        "y_string_nonCharacterInUTF-8_U+FFFF.json": List<dynamic>.from(yStringNonCharacterInUtf8UFfffJson.map((x) => x)),
        "y_string_null_escape.json": List<dynamic>.from(yStringNullEscapeJson.map((x) => x)),
        "y_string_one-byte-utf-8.json": List<dynamic>.from(yStringOneByteUtf8Json.map((x) => x)),
        "y_string_pi.json": List<dynamic>.from(yStringPiJson.map((x) => x)),
        "y_string_simple_ascii.json": List<dynamic>.from(yStringSimpleAsciiJson.map((x) => x)),
        "y_string_space.json": yStringSpaceJson,
        "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json": List<dynamic>.from(yStringSurrogatesU1D11EMusicalSymbolGClefJson.map((x) => x)),
        "y_string_three-byte-utf-8.json": List<dynamic>.from(yStringThreeByteUtf8Json.map((x) => x)),
        "y_string_two-byte-utf-8.json": List<dynamic>.from(yStringTwoByteUtf8Json.map((x) => x)),
        "y_string_u+2028_line_sep.json": List<dynamic>.from(yStringU2028LineSepJson.map((x) => x)),
        "y_string_u+2029_par_sep.json": List<dynamic>.from(yStringU2029ParSepJson.map((x) => x)),
        "y_string_uEscape.json": List<dynamic>.from(yStringUEscapeJson.map((x) => x)),
        "y_string_uescaped_newline.json": List<dynamic>.from(yStringUescapedNewlineJson.map((x) => x)),
        "y_string_unescaped_char_delete.json": List<dynamic>.from(yStringUnescapedCharDeleteJson.map((x) => x)),
        "y_string_unicode_2.json": List<dynamic>.from(yStringUnicode2Json.map((x) => x)),
        "y_string_unicodeEscapedBackslash.json": List<dynamic>.from(yStringUnicodeEscapedBackslashJson.map((x) => x)),
        "y_string_unicode_escaped_double_quote.json": List<dynamic>.from(yStringUnicodeEscapedDoubleQuoteJson.map((x) => x)),
        "y_string_unicode.json": List<dynamic>.from(yStringUnicodeJson.map((x) => x)),
        "y_string_unicode_U+10FFFE_nonchar.json": List<dynamic>.from(yStringUnicodeU10FffeNoncharJson.map((x) => x)),
        "y_string_unicode_U+1FFFE_nonchar.json": List<dynamic>.from(yStringUnicodeU1FffeNoncharJson.map((x) => x)),
        "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json": List<dynamic>.from(yStringUnicodeU200BZeroWidthSpaceJson.map((x) => x)),
        "y_string_unicode_U+2064_invisible_plus.json": List<dynamic>.from(yStringUnicodeU2064InvisiblePlusJson.map((x) => x)),
        "y_string_unicode_U+FDD0_nonchar.json": List<dynamic>.from(yStringUnicodeUFdd0NoncharJson.map((x) => x)),
        "y_string_unicode_U+FFFE_nonchar.json": List<dynamic>.from(yStringUnicodeUFffeNoncharJson.map((x) => x)),
        "y_string_utf8.json": List<dynamic>.from(yStringUtf8Json.map((x) => x)),
        "y_string_with_del_character.json": List<dynamic>.from(yStringWithDelCharacterJson.map((x) => x)),
        "y_structure_lonely_false.json": yStructureLonelyFalseJson,
        "y_structure_lonely_int.json": yStructureLonelyIntJson,
        "y_structure_lonely_negative_real.json": yStructureLonelyNegativeRealJson,
        "y_structure_lonely_null.json": yStructureLonelyNullJson,
        "y_structure_lonely_string.json": yStructureLonelyStringJson,
        "y_structure_lonely_true.json": yStructureLonelyTrueJson,
        "y_structure_string_empty.json": yStructureStringEmptyJson,
        "y_structure_trailing_newline.json": List<dynamic>.from(yStructureTrailingNewlineJson.map((x) => x)),
        "y_structure_true_in_array.json": List<dynamic>.from(yStructureTrueInArrayJson.map((x) => x)),
        "y_structure_whitespace_array.json": List<dynamic>.from(yStructureWhitespaceArrayJson.map((x) => x)),
    };
}

class Json {
    Json();

    factory Json.fromJson(Map<String, dynamic> json) => Json(
    );

    Map<String, dynamic> toJson() => {
    };
}

class YObjectBasicJson {
    final String asd;

    YObjectBasicJson({
        required this.asd,
    });

    factory YObjectBasicJson.fromJson(Map<String, dynamic> json) => YObjectBasicJson(
        asd: json["asd"],
    );

    Map<String, dynamic> toJson() => {
        "asd": asd,
    };
}

class YObjectEmptyKeyJson {
    final int empty;

    YObjectEmptyKeyJson({
        required this.empty,
    });

    factory YObjectEmptyKeyJson.fromJson(Map<String, dynamic> json) => YObjectEmptyKeyJson(
        empty: json[""],
    );

    Map<String, dynamic> toJson() => {
        "": empty,
    };
}

class YObjectEscapedNullInKeyJson {
    final int fooBar;

    YObjectEscapedNullInKeyJson({
        required this.fooBar,
    });

    factory YObjectEscapedNullInKeyJson.fromJson(Map<String, dynamic> json) => YObjectEscapedNullInKeyJson(
        fooBar: json["foo\u0000bar"],
    );

    Map<String, dynamic> toJson() => {
        "foo\u0000bar": fooBar,
    };
}

class YObjectExtremeNumbersJson {
    final double max;
    final double min;

    YObjectExtremeNumbersJson({
        required this.max,
        required this.min,
    });

    factory YObjectExtremeNumbersJson.fromJson(Map<String, dynamic> json) => YObjectExtremeNumbersJson(
        max: json["max"]?.toDouble(),
        min: json["min"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "max": max,
        "min": min,
    };
}

class YObjectJson {
    final String asd;
    final String dfg;

    YObjectJson({
        required this.asd,
        required this.dfg,
    });

    factory YObjectJson.fromJson(Map<String, dynamic> json) => YObjectJson(
        asd: json["asd"],
        dfg: json["dfg"],
    );

    Map<String, dynamic> toJson() => {
        "asd": asd,
        "dfg": dfg,
    };
}

class YObjectLongStringsJson {
    final String id;
    final List<X> x;

    YObjectLongStringsJson({
        required this.id,
        required this.x,
    });

    factory YObjectLongStringsJson.fromJson(Map<String, dynamic> json) => YObjectLongStringsJson(
        id: json["id"],
        x: List<X>.from(json["x"].map((x) => X.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "x": List<dynamic>.from(x.map((x) => x.toJson())),
    };
}

class X {
    final String id;

    X({
        required this.id,
    });

    factory X.fromJson(Map<String, dynamic> json) => X(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class YObjectSimpleJson {
    final List<dynamic> a;

    YObjectSimpleJson({
        required this.a,
    });

    factory YObjectSimpleJson.fromJson(Map<String, dynamic> json) => YObjectSimpleJson(
        a: List<dynamic>.from(json["a"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "a": List<dynamic>.from(a.map((x) => x)),
    };
}

class YObjectStringUnicodeJson {
    final String title;

    YObjectStringUnicodeJson({
        required this.title,
    });

    factory YObjectStringUnicodeJson.fromJson(Map<String, dynamic> json) => YObjectStringUnicodeJson(
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
    };
}

class YObjectWithNewlinesJson {
    final String a;

    YObjectWithNewlinesJson({
        required this.a,
    });

    factory YObjectWithNewlinesJson.fromJson(Map<String, dynamic> json) => YObjectWithNewlinesJson(
        a: json["a"],
    );

    Map<String, dynamic> toJson() => {
        "a": a,
    };
}
