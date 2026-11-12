package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Double> topLevelYNumber0E1JSON;
    private List<List<Object>> yArrayArraysWithSpacesJSON;
    private List<Object> yArrayEmptyJSON;
    private List<String> yArrayEmptyStringJSON;
    private List<String> yArrayEndingWithNewlineJSON;
    private List<Boolean> yArrayFalseJSON;
    private List<YArrayHeterogeneousJSON> yArrayHeterogeneousJSON;
    private List<Object> yArrayNullJSON;
    private List<Long> yArrayWith1_AndNewlineJSON;
    private List<Long> yArrayWithLeadingSpaceJSON;
    private List<Long> yArrayWithSeveralNullJSON;
    private List<Long> yArrayWithTrailingSpaceJSON;
    private List<Double> yNumber0E1JSON;
    private List<Long> yNumberAfterSpaceJSON;
    private List<Double> yNumberDoubleCloseToZeroJSON;
    private List<Double> yNumberIntWithExpJSON;
    private List<Double> yNumberJSON;
    private List<Long> yNumberMinusZeroJSON;
    private List<Long> yNumberNegativeIntJSON;
    private List<Long> yNumberNegativeOneJSON;
    private List<Long> yNumberNegativeZeroJSON;
    private List<Double> yNumberRealCapitalEJSON;
    private List<Double> yNumberRealCapitalENegExpJSON;
    private List<Double> yNumberRealCapitalEPosExpJSON;
    private List<Double> yNumberRealExponentJSON;
    private List<Double> yNumberRealFractionExponentJSON;
    private List<Double> yNumberRealNegExpJSON;
    private List<Double> yNumberRealPosExponentJSON;
    private List<Long> yNumberSimpleIntJSON;
    private List<Double> yNumberSimpleRealJSON;
    private YObjectBasicJSON yObjectBasicJSON;
    private JSON yObjectEmptyJSON;
    private YObjectEmptyKeyJSON yObjectEmptyKeyJSON;
    private YObjectEscapedNullInKeyJSON yObjectEscapedNullInKeyJSON;
    private YObjectExtremeNumbersJSON yObjectExtremeNumbersJSON;
    private YObjectJSON yObjectJSON;
    private YObjectLongStringsJSON yObjectLongStringsJSON;
    private YObjectSimpleJSON yObjectSimpleJSON;
    private YObjectStringUnicodeJSON yObjectStringUnicodeJSON;
    private YObjectWithNewlinesJSON yObjectWithNewlinesJSON;
    private List<String> yString1_2_3_BytesUTF8_SequencesJSON;
    private List<String> yStringAcceptedSurrogatePairJSON;
    private List<String> yStringAcceptedSurrogatePairsJSON;
    private List<String> yStringAllowedEscapesJSON;
    private List<String> yStringBackslashAndUEscapedZeroJSON;
    private List<String> yStringBackslashDoublequotesJSON;
    private List<String> yStringCommentsJSON;
    private List<String> yStringDoubleEscapeAJSON;
    private List<String> yStringDoubleEscapeNJSON;
    private List<String> yStringEscapedControlCharacterJSON;
    private List<String> yStringEscapedNoncharacterJSON;
    private List<String> yStringInArrayJSON;
    private List<String> yStringInArrayWithLeadingSpaceJSON;
    private List<String> yStringLastSurrogates1_And2JSON;
    private List<String> yStringNbspUescapedJSON;
    private List<String> yStringNonCharacterInUTF8_U10FFFFJSON;
    private List<String> yStringNonCharacterInUTF8_U1FFFFJSON;
    private List<String> yStringNonCharacterInUTF8_UFFFFJSON;
    private List<String> yStringNullEscapeJSON;
    private List<String> yStringOneByteUTF8JSON;
    private List<String> yStringPiJSON;
    private List<String> yStringSimpleASCIIJSON;
    private String yStringSpaceJSON;
    private List<String> yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON;
    private List<String> yStringThreeByteUTF8JSON;
    private List<String> yStringTwoByteUTF8JSON;
    private List<String> yStringU2028_LineSepJSON;
    private List<String> yStringU2029_ParSepJSON;
    private List<String> yStringUEscapeJSON;
    private List<String> yStringUescapedNewlineJSON;
    private List<String> yStringUnescapedCharDeleteJSON;
    private List<String> yStringUnicode2JSON;
    private List<String> yStringUnicodeEscapedBackslashJSON;
    private List<String> yStringUnicodeEscapedDoubleQuoteJSON;
    private List<String> yStringUnicodeJSON;
    private List<String> yStringUnicodeU10FFFENoncharJSON;
    private List<String> yStringUnicodeU1FFFENoncharJSON;
    private List<String> yStringUnicodeU200BZEROWIDTHSPACEJSON;
    private List<String> yStringUnicodeU2064_InvisiblePlusJSON;
    private List<String> yStringUnicodeUFDD0NoncharJSON;
    private List<String> yStringUnicodeUFFFENoncharJSON;
    private List<String> yStringUtf8JSON;
    private List<String> yStringWithDelCharacterJSON;
    private boolean yStructureLonelyFalseJSON;
    private long yStructureLonelyIntJSON;
    private double yStructureLonelyNegativeRealJSON;
    private Object yStructureLonelyNullJSON;
    private String yStructureLonelyStringJSON;
    private boolean yStructureLonelyTrueJSON;
    private String yStructureStringEmptyJSON;
    private List<String> yStructureTrailingNewlineJSON;
    private List<Boolean> yStructureTrueInArrayJSON;
    private List<Object> yStructureWhitespaceArrayJSON;

    @JsonProperty("y_number_0e1.json")
    public List<Double> getTopLevelYNumber0E1JSON() { return topLevelYNumber0E1JSON; }
    @JsonProperty("y_number_0e1.json")
    public void setTopLevelYNumber0E1JSON(List<Double> value) { this.topLevelYNumber0E1JSON = value; }

    @JsonProperty("y_array_arraysWithSpaces.json")
    public List<List<Object>> getYArrayArraysWithSpacesJSON() { return yArrayArraysWithSpacesJSON; }
    @JsonProperty("y_array_arraysWithSpaces.json")
    public void setYArrayArraysWithSpacesJSON(List<List<Object>> value) { this.yArrayArraysWithSpacesJSON = value; }

    @JsonProperty("y_array_empty.json")
    public List<Object> getYArrayEmptyJSON() { return yArrayEmptyJSON; }
    @JsonProperty("y_array_empty.json")
    public void setYArrayEmptyJSON(List<Object> value) { this.yArrayEmptyJSON = value; }

    @JsonProperty("y_array_empty-string.json")
    public List<String> getYArrayEmptyStringJSON() { return yArrayEmptyStringJSON; }
    @JsonProperty("y_array_empty-string.json")
    public void setYArrayEmptyStringJSON(List<String> value) { this.yArrayEmptyStringJSON = value; }

    @JsonProperty("y_array_ending_with_newline.json")
    public List<String> getYArrayEndingWithNewlineJSON() { return yArrayEndingWithNewlineJSON; }
    @JsonProperty("y_array_ending_with_newline.json")
    public void setYArrayEndingWithNewlineJSON(List<String> value) { this.yArrayEndingWithNewlineJSON = value; }

    @JsonProperty("y_array_false.json")
    public List<Boolean> getYArrayFalseJSON() { return yArrayFalseJSON; }
    @JsonProperty("y_array_false.json")
    public void setYArrayFalseJSON(List<Boolean> value) { this.yArrayFalseJSON = value; }

    @JsonProperty("y_array_heterogeneous.json")
    public List<YArrayHeterogeneousJSON> getYArrayHeterogeneousJSON() { return yArrayHeterogeneousJSON; }
    @JsonProperty("y_array_heterogeneous.json")
    public void setYArrayHeterogeneousJSON(List<YArrayHeterogeneousJSON> value) { this.yArrayHeterogeneousJSON = value; }

    @JsonProperty("y_array_null.json")
    public List<Object> getYArrayNullJSON() { return yArrayNullJSON; }
    @JsonProperty("y_array_null.json")
    public void setYArrayNullJSON(List<Object> value) { this.yArrayNullJSON = value; }

    @JsonProperty("y_array_with_1_and_newline.json")
    public List<Long> getYArrayWith1AndNewlineJSON() { return yArrayWith1_AndNewlineJSON; }
    @JsonProperty("y_array_with_1_and_newline.json")
    public void setYArrayWith1AndNewlineJSON(List<Long> value) { this.yArrayWith1_AndNewlineJSON = value; }

    @JsonProperty("y_array_with_leading_space.json")
    public List<Long> getYArrayWithLeadingSpaceJSON() { return yArrayWithLeadingSpaceJSON; }
    @JsonProperty("y_array_with_leading_space.json")
    public void setYArrayWithLeadingSpaceJSON(List<Long> value) { this.yArrayWithLeadingSpaceJSON = value; }

    @JsonProperty("y_array_with_several_null.json")
    public List<Long> getYArrayWithSeveralNullJSON() { return yArrayWithSeveralNullJSON; }
    @JsonProperty("y_array_with_several_null.json")
    public void setYArrayWithSeveralNullJSON(List<Long> value) { this.yArrayWithSeveralNullJSON = value; }

    @JsonProperty("y_array_with_trailing_space.json")
    public List<Long> getYArrayWithTrailingSpaceJSON() { return yArrayWithTrailingSpaceJSON; }
    @JsonProperty("y_array_with_trailing_space.json")
    public void setYArrayWithTrailingSpaceJSON(List<Long> value) { this.yArrayWithTrailingSpaceJSON = value; }

    @JsonProperty("y_number_0e+1.json")
    public List<Double> getYNumber0E1JSON() { return yNumber0E1JSON; }
    @JsonProperty("y_number_0e+1.json")
    public void setYNumber0E1JSON(List<Double> value) { this.yNumber0E1JSON = value; }

    @JsonProperty("y_number_after_space.json")
    public List<Long> getYNumberAfterSpaceJSON() { return yNumberAfterSpaceJSON; }
    @JsonProperty("y_number_after_space.json")
    public void setYNumberAfterSpaceJSON(List<Long> value) { this.yNumberAfterSpaceJSON = value; }

    @JsonProperty("y_number_double_close_to_zero.json")
    public List<Double> getYNumberDoubleCloseToZeroJSON() { return yNumberDoubleCloseToZeroJSON; }
    @JsonProperty("y_number_double_close_to_zero.json")
    public void setYNumberDoubleCloseToZeroJSON(List<Double> value) { this.yNumberDoubleCloseToZeroJSON = value; }

    @JsonProperty("y_number_int_with_exp.json")
    public List<Double> getYNumberIntWithExpJSON() { return yNumberIntWithExpJSON; }
    @JsonProperty("y_number_int_with_exp.json")
    public void setYNumberIntWithExpJSON(List<Double> value) { this.yNumberIntWithExpJSON = value; }

    @JsonProperty("y_number.json")
    public List<Double> getYNumberJSON() { return yNumberJSON; }
    @JsonProperty("y_number.json")
    public void setYNumberJSON(List<Double> value) { this.yNumberJSON = value; }

    @JsonProperty("y_number_minus_zero.json")
    public List<Long> getYNumberMinusZeroJSON() { return yNumberMinusZeroJSON; }
    @JsonProperty("y_number_minus_zero.json")
    public void setYNumberMinusZeroJSON(List<Long> value) { this.yNumberMinusZeroJSON = value; }

    @JsonProperty("y_number_negative_int.json")
    public List<Long> getYNumberNegativeIntJSON() { return yNumberNegativeIntJSON; }
    @JsonProperty("y_number_negative_int.json")
    public void setYNumberNegativeIntJSON(List<Long> value) { this.yNumberNegativeIntJSON = value; }

    @JsonProperty("y_number_negative_one.json")
    public List<Long> getYNumberNegativeOneJSON() { return yNumberNegativeOneJSON; }
    @JsonProperty("y_number_negative_one.json")
    public void setYNumberNegativeOneJSON(List<Long> value) { this.yNumberNegativeOneJSON = value; }

    @JsonProperty("y_number_negative_zero.json")
    public List<Long> getYNumberNegativeZeroJSON() { return yNumberNegativeZeroJSON; }
    @JsonProperty("y_number_negative_zero.json")
    public void setYNumberNegativeZeroJSON(List<Long> value) { this.yNumberNegativeZeroJSON = value; }

    @JsonProperty("y_number_real_capital_e.json")
    public List<Double> getYNumberRealCapitalEJSON() { return yNumberRealCapitalEJSON; }
    @JsonProperty("y_number_real_capital_e.json")
    public void setYNumberRealCapitalEJSON(List<Double> value) { this.yNumberRealCapitalEJSON = value; }

    @JsonProperty("y_number_real_capital_e_neg_exp.json")
    public List<Double> getYNumberRealCapitalENegExpJSON() { return yNumberRealCapitalENegExpJSON; }
    @JsonProperty("y_number_real_capital_e_neg_exp.json")
    public void setYNumberRealCapitalENegExpJSON(List<Double> value) { this.yNumberRealCapitalENegExpJSON = value; }

    @JsonProperty("y_number_real_capital_e_pos_exp.json")
    public List<Double> getYNumberRealCapitalEPosExpJSON() { return yNumberRealCapitalEPosExpJSON; }
    @JsonProperty("y_number_real_capital_e_pos_exp.json")
    public void setYNumberRealCapitalEPosExpJSON(List<Double> value) { this.yNumberRealCapitalEPosExpJSON = value; }

    @JsonProperty("y_number_real_exponent.json")
    public List<Double> getYNumberRealExponentJSON() { return yNumberRealExponentJSON; }
    @JsonProperty("y_number_real_exponent.json")
    public void setYNumberRealExponentJSON(List<Double> value) { this.yNumberRealExponentJSON = value; }

    @JsonProperty("y_number_real_fraction_exponent.json")
    public List<Double> getYNumberRealFractionExponentJSON() { return yNumberRealFractionExponentJSON; }
    @JsonProperty("y_number_real_fraction_exponent.json")
    public void setYNumberRealFractionExponentJSON(List<Double> value) { this.yNumberRealFractionExponentJSON = value; }

    @JsonProperty("y_number_real_neg_exp.json")
    public List<Double> getYNumberRealNegExpJSON() { return yNumberRealNegExpJSON; }
    @JsonProperty("y_number_real_neg_exp.json")
    public void setYNumberRealNegExpJSON(List<Double> value) { this.yNumberRealNegExpJSON = value; }

    @JsonProperty("y_number_real_pos_exponent.json")
    public List<Double> getYNumberRealPosExponentJSON() { return yNumberRealPosExponentJSON; }
    @JsonProperty("y_number_real_pos_exponent.json")
    public void setYNumberRealPosExponentJSON(List<Double> value) { this.yNumberRealPosExponentJSON = value; }

    @JsonProperty("y_number_simple_int.json")
    public List<Long> getYNumberSimpleIntJSON() { return yNumberSimpleIntJSON; }
    @JsonProperty("y_number_simple_int.json")
    public void setYNumberSimpleIntJSON(List<Long> value) { this.yNumberSimpleIntJSON = value; }

    @JsonProperty("y_number_simple_real.json")
    public List<Double> getYNumberSimpleRealJSON() { return yNumberSimpleRealJSON; }
    @JsonProperty("y_number_simple_real.json")
    public void setYNumberSimpleRealJSON(List<Double> value) { this.yNumberSimpleRealJSON = value; }

    @JsonProperty("y_object_basic.json")
    public YObjectBasicJSON getYObjectBasicJSON() { return yObjectBasicJSON; }
    @JsonProperty("y_object_basic.json")
    public void setYObjectBasicJSON(YObjectBasicJSON value) { this.yObjectBasicJSON = value; }

    @JsonProperty("y_object_empty.json")
    public JSON getYObjectEmptyJSON() { return yObjectEmptyJSON; }
    @JsonProperty("y_object_empty.json")
    public void setYObjectEmptyJSON(JSON value) { this.yObjectEmptyJSON = value; }

    @JsonProperty("y_object_empty_key.json")
    public YObjectEmptyKeyJSON getYObjectEmptyKeyJSON() { return yObjectEmptyKeyJSON; }
    @JsonProperty("y_object_empty_key.json")
    public void setYObjectEmptyKeyJSON(YObjectEmptyKeyJSON value) { this.yObjectEmptyKeyJSON = value; }

    @JsonProperty("y_object_escaped_null_in_key.json")
    public YObjectEscapedNullInKeyJSON getYObjectEscapedNullInKeyJSON() { return yObjectEscapedNullInKeyJSON; }
    @JsonProperty("y_object_escaped_null_in_key.json")
    public void setYObjectEscapedNullInKeyJSON(YObjectEscapedNullInKeyJSON value) { this.yObjectEscapedNullInKeyJSON = value; }

    @JsonProperty("y_object_extreme_numbers.json")
    public YObjectExtremeNumbersJSON getYObjectExtremeNumbersJSON() { return yObjectExtremeNumbersJSON; }
    @JsonProperty("y_object_extreme_numbers.json")
    public void setYObjectExtremeNumbersJSON(YObjectExtremeNumbersJSON value) { this.yObjectExtremeNumbersJSON = value; }

    @JsonProperty("y_object.json")
    public YObjectJSON getYObjectJSON() { return yObjectJSON; }
    @JsonProperty("y_object.json")
    public void setYObjectJSON(YObjectJSON value) { this.yObjectJSON = value; }

    @JsonProperty("y_object_long_strings.json")
    public YObjectLongStringsJSON getYObjectLongStringsJSON() { return yObjectLongStringsJSON; }
    @JsonProperty("y_object_long_strings.json")
    public void setYObjectLongStringsJSON(YObjectLongStringsJSON value) { this.yObjectLongStringsJSON = value; }

    @JsonProperty("y_object_simple.json")
    public YObjectSimpleJSON getYObjectSimpleJSON() { return yObjectSimpleJSON; }
    @JsonProperty("y_object_simple.json")
    public void setYObjectSimpleJSON(YObjectSimpleJSON value) { this.yObjectSimpleJSON = value; }

    @JsonProperty("y_object_string_unicode.json")
    public YObjectStringUnicodeJSON getYObjectStringUnicodeJSON() { return yObjectStringUnicodeJSON; }
    @JsonProperty("y_object_string_unicode.json")
    public void setYObjectStringUnicodeJSON(YObjectStringUnicodeJSON value) { this.yObjectStringUnicodeJSON = value; }

    @JsonProperty("y_object_with_newlines.json")
    public YObjectWithNewlinesJSON getYObjectWithNewlinesJSON() { return yObjectWithNewlinesJSON; }
    @JsonProperty("y_object_with_newlines.json")
    public void setYObjectWithNewlinesJSON(YObjectWithNewlinesJSON value) { this.yObjectWithNewlinesJSON = value; }

    @JsonProperty("y_string_1_2_3_bytes_UTF-8_sequences.json")
    public List<String> getYString12_3_BytesUTF8SequencesJSON() { return yString1_2_3_BytesUTF8_SequencesJSON; }
    @JsonProperty("y_string_1_2_3_bytes_UTF-8_sequences.json")
    public void setYString12_3_BytesUTF8SequencesJSON(List<String> value) { this.yString1_2_3_BytesUTF8_SequencesJSON = value; }

    @JsonProperty("y_string_accepted_surrogate_pair.json")
    public List<String> getYStringAcceptedSurrogatePairJSON() { return yStringAcceptedSurrogatePairJSON; }
    @JsonProperty("y_string_accepted_surrogate_pair.json")
    public void setYStringAcceptedSurrogatePairJSON(List<String> value) { this.yStringAcceptedSurrogatePairJSON = value; }

    @JsonProperty("y_string_accepted_surrogate_pairs.json")
    public List<String> getYStringAcceptedSurrogatePairsJSON() { return yStringAcceptedSurrogatePairsJSON; }
    @JsonProperty("y_string_accepted_surrogate_pairs.json")
    public void setYStringAcceptedSurrogatePairsJSON(List<String> value) { this.yStringAcceptedSurrogatePairsJSON = value; }

    @JsonProperty("y_string_allowed_escapes.json")
    public List<String> getYStringAllowedEscapesJSON() { return yStringAllowedEscapesJSON; }
    @JsonProperty("y_string_allowed_escapes.json")
    public void setYStringAllowedEscapesJSON(List<String> value) { this.yStringAllowedEscapesJSON = value; }

    @JsonProperty("y_string_backslash_and_u_escaped_zero.json")
    public List<String> getYStringBackslashAndUEscapedZeroJSON() { return yStringBackslashAndUEscapedZeroJSON; }
    @JsonProperty("y_string_backslash_and_u_escaped_zero.json")
    public void setYStringBackslashAndUEscapedZeroJSON(List<String> value) { this.yStringBackslashAndUEscapedZeroJSON = value; }

    @JsonProperty("y_string_backslash_doublequotes.json")
    public List<String> getYStringBackslashDoublequotesJSON() { return yStringBackslashDoublequotesJSON; }
    @JsonProperty("y_string_backslash_doublequotes.json")
    public void setYStringBackslashDoublequotesJSON(List<String> value) { this.yStringBackslashDoublequotesJSON = value; }

    @JsonProperty("y_string_comments.json")
    public List<String> getYStringCommentsJSON() { return yStringCommentsJSON; }
    @JsonProperty("y_string_comments.json")
    public void setYStringCommentsJSON(List<String> value) { this.yStringCommentsJSON = value; }

    @JsonProperty("y_string_double_escape_a.json")
    public List<String> getYStringDoubleEscapeAJSON() { return yStringDoubleEscapeAJSON; }
    @JsonProperty("y_string_double_escape_a.json")
    public void setYStringDoubleEscapeAJSON(List<String> value) { this.yStringDoubleEscapeAJSON = value; }

    @JsonProperty("y_string_double_escape_n.json")
    public List<String> getYStringDoubleEscapeNJSON() { return yStringDoubleEscapeNJSON; }
    @JsonProperty("y_string_double_escape_n.json")
    public void setYStringDoubleEscapeNJSON(List<String> value) { this.yStringDoubleEscapeNJSON = value; }

    @JsonProperty("y_string_escaped_control_character.json")
    public List<String> getYStringEscapedControlCharacterJSON() { return yStringEscapedControlCharacterJSON; }
    @JsonProperty("y_string_escaped_control_character.json")
    public void setYStringEscapedControlCharacterJSON(List<String> value) { this.yStringEscapedControlCharacterJSON = value; }

    @JsonProperty("y_string_escaped_noncharacter.json")
    public List<String> getYStringEscapedNoncharacterJSON() { return yStringEscapedNoncharacterJSON; }
    @JsonProperty("y_string_escaped_noncharacter.json")
    public void setYStringEscapedNoncharacterJSON(List<String> value) { this.yStringEscapedNoncharacterJSON = value; }

    @JsonProperty("y_string_in_array.json")
    public List<String> getYStringInArrayJSON() { return yStringInArrayJSON; }
    @JsonProperty("y_string_in_array.json")
    public void setYStringInArrayJSON(List<String> value) { this.yStringInArrayJSON = value; }

    @JsonProperty("y_string_in_array_with_leading_space.json")
    public List<String> getYStringInArrayWithLeadingSpaceJSON() { return yStringInArrayWithLeadingSpaceJSON; }
    @JsonProperty("y_string_in_array_with_leading_space.json")
    public void setYStringInArrayWithLeadingSpaceJSON(List<String> value) { this.yStringInArrayWithLeadingSpaceJSON = value; }

    @JsonProperty("y_string_last_surrogates_1_and_2.json")
    public List<String> getYStringLastSurrogates1And2JSON() { return yStringLastSurrogates1_And2JSON; }
    @JsonProperty("y_string_last_surrogates_1_and_2.json")
    public void setYStringLastSurrogates1And2JSON(List<String> value) { this.yStringLastSurrogates1_And2JSON = value; }

    @JsonProperty("y_string_nbsp_uescaped.json")
    public List<String> getYStringNbspUescapedJSON() { return yStringNbspUescapedJSON; }
    @JsonProperty("y_string_nbsp_uescaped.json")
    public void setYStringNbspUescapedJSON(List<String> value) { this.yStringNbspUescapedJSON = value; }

    @JsonProperty("y_string_nonCharacterInUTF-8_U+10FFFF.json")
    public List<String> getYStringNonCharacterInUTF8U10FFFFJSON() { return yStringNonCharacterInUTF8_U10FFFFJSON; }
    @JsonProperty("y_string_nonCharacterInUTF-8_U+10FFFF.json")
    public void setYStringNonCharacterInUTF8U10FFFFJSON(List<String> value) { this.yStringNonCharacterInUTF8_U10FFFFJSON = value; }

    @JsonProperty("y_string_nonCharacterInUTF-8_U+1FFFF.json")
    public List<String> getYStringNonCharacterInUTF8U1FFFFJSON() { return yStringNonCharacterInUTF8_U1FFFFJSON; }
    @JsonProperty("y_string_nonCharacterInUTF-8_U+1FFFF.json")
    public void setYStringNonCharacterInUTF8U1FFFFJSON(List<String> value) { this.yStringNonCharacterInUTF8_U1FFFFJSON = value; }

    @JsonProperty("y_string_nonCharacterInUTF-8_U+FFFF.json")
    public List<String> getYStringNonCharacterInUTF8UFFFFJSON() { return yStringNonCharacterInUTF8_UFFFFJSON; }
    @JsonProperty("y_string_nonCharacterInUTF-8_U+FFFF.json")
    public void setYStringNonCharacterInUTF8UFFFFJSON(List<String> value) { this.yStringNonCharacterInUTF8_UFFFFJSON = value; }

    @JsonProperty("y_string_null_escape.json")
    public List<String> getYStringNullEscapeJSON() { return yStringNullEscapeJSON; }
    @JsonProperty("y_string_null_escape.json")
    public void setYStringNullEscapeJSON(List<String> value) { this.yStringNullEscapeJSON = value; }

    @JsonProperty("y_string_one-byte-utf-8.json")
    public List<String> getYStringOneByteUTF8JSON() { return yStringOneByteUTF8JSON; }
    @JsonProperty("y_string_one-byte-utf-8.json")
    public void setYStringOneByteUTF8JSON(List<String> value) { this.yStringOneByteUTF8JSON = value; }

    @JsonProperty("y_string_pi.json")
    public List<String> getYStringPiJSON() { return yStringPiJSON; }
    @JsonProperty("y_string_pi.json")
    public void setYStringPiJSON(List<String> value) { this.yStringPiJSON = value; }

    @JsonProperty("y_string_simple_ascii.json")
    public List<String> getYStringSimpleASCIIJSON() { return yStringSimpleASCIIJSON; }
    @JsonProperty("y_string_simple_ascii.json")
    public void setYStringSimpleASCIIJSON(List<String> value) { this.yStringSimpleASCIIJSON = value; }

    @JsonProperty("y_string_space.json")
    public String getYStringSpaceJSON() { return yStringSpaceJSON; }
    @JsonProperty("y_string_space.json")
    public void setYStringSpaceJSON(String value) { this.yStringSpaceJSON = value; }

    @JsonProperty("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json")
    public List<String> getYStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON() { return yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON; }
    @JsonProperty("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json")
    public void setYStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON(List<String> value) { this.yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON = value; }

    @JsonProperty("y_string_three-byte-utf-8.json")
    public List<String> getYStringThreeByteUTF8JSON() { return yStringThreeByteUTF8JSON; }
    @JsonProperty("y_string_three-byte-utf-8.json")
    public void setYStringThreeByteUTF8JSON(List<String> value) { this.yStringThreeByteUTF8JSON = value; }

    @JsonProperty("y_string_two-byte-utf-8.json")
    public List<String> getYStringTwoByteUTF8JSON() { return yStringTwoByteUTF8JSON; }
    @JsonProperty("y_string_two-byte-utf-8.json")
    public void setYStringTwoByteUTF8JSON(List<String> value) { this.yStringTwoByteUTF8JSON = value; }

    @JsonProperty("y_string_u+2028_line_sep.json")
    public List<String> getYStringU2028LineSepJSON() { return yStringU2028_LineSepJSON; }
    @JsonProperty("y_string_u+2028_line_sep.json")
    public void setYStringU2028LineSepJSON(List<String> value) { this.yStringU2028_LineSepJSON = value; }

    @JsonProperty("y_string_u+2029_par_sep.json")
    public List<String> getYStringU2029ParSepJSON() { return yStringU2029_ParSepJSON; }
    @JsonProperty("y_string_u+2029_par_sep.json")
    public void setYStringU2029ParSepJSON(List<String> value) { this.yStringU2029_ParSepJSON = value; }

    @JsonProperty("y_string_uEscape.json")
    public List<String> getYStringUEscapeJSON() { return yStringUEscapeJSON; }
    @JsonProperty("y_string_uEscape.json")
    public void setYStringUEscapeJSON(List<String> value) { this.yStringUEscapeJSON = value; }

    @JsonProperty("y_string_uescaped_newline.json")
    public List<String> getYStringUescapedNewlineJSON() { return yStringUescapedNewlineJSON; }
    @JsonProperty("y_string_uescaped_newline.json")
    public void setYStringUescapedNewlineJSON(List<String> value) { this.yStringUescapedNewlineJSON = value; }

    @JsonProperty("y_string_unescaped_char_delete.json")
    public List<String> getYStringUnescapedCharDeleteJSON() { return yStringUnescapedCharDeleteJSON; }
    @JsonProperty("y_string_unescaped_char_delete.json")
    public void setYStringUnescapedCharDeleteJSON(List<String> value) { this.yStringUnescapedCharDeleteJSON = value; }

    @JsonProperty("y_string_unicode_2.json")
    public List<String> getYStringUnicode2JSON() { return yStringUnicode2JSON; }
    @JsonProperty("y_string_unicode_2.json")
    public void setYStringUnicode2JSON(List<String> value) { this.yStringUnicode2JSON = value; }

    @JsonProperty("y_string_unicodeEscapedBackslash.json")
    public List<String> getYStringUnicodeEscapedBackslashJSON() { return yStringUnicodeEscapedBackslashJSON; }
    @JsonProperty("y_string_unicodeEscapedBackslash.json")
    public void setYStringUnicodeEscapedBackslashJSON(List<String> value) { this.yStringUnicodeEscapedBackslashJSON = value; }

    @JsonProperty("y_string_unicode_escaped_double_quote.json")
    public List<String> getYStringUnicodeEscapedDoubleQuoteJSON() { return yStringUnicodeEscapedDoubleQuoteJSON; }
    @JsonProperty("y_string_unicode_escaped_double_quote.json")
    public void setYStringUnicodeEscapedDoubleQuoteJSON(List<String> value) { this.yStringUnicodeEscapedDoubleQuoteJSON = value; }

    @JsonProperty("y_string_unicode.json")
    public List<String> getYStringUnicodeJSON() { return yStringUnicodeJSON; }
    @JsonProperty("y_string_unicode.json")
    public void setYStringUnicodeJSON(List<String> value) { this.yStringUnicodeJSON = value; }

    @JsonProperty("y_string_unicode_U+10FFFE_nonchar.json")
    public List<String> getYStringUnicodeU10FFFENoncharJSON() { return yStringUnicodeU10FFFENoncharJSON; }
    @JsonProperty("y_string_unicode_U+10FFFE_nonchar.json")
    public void setYStringUnicodeU10FFFENoncharJSON(List<String> value) { this.yStringUnicodeU10FFFENoncharJSON = value; }

    @JsonProperty("y_string_unicode_U+1FFFE_nonchar.json")
    public List<String> getYStringUnicodeU1FFFENoncharJSON() { return yStringUnicodeU1FFFENoncharJSON; }
    @JsonProperty("y_string_unicode_U+1FFFE_nonchar.json")
    public void setYStringUnicodeU1FFFENoncharJSON(List<String> value) { this.yStringUnicodeU1FFFENoncharJSON = value; }

    @JsonProperty("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json")
    public List<String> getYStringUnicodeU200BZEROWIDTHSPACEJSON() { return yStringUnicodeU200BZEROWIDTHSPACEJSON; }
    @JsonProperty("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json")
    public void setYStringUnicodeU200BZEROWIDTHSPACEJSON(List<String> value) { this.yStringUnicodeU200BZEROWIDTHSPACEJSON = value; }

    @JsonProperty("y_string_unicode_U+2064_invisible_plus.json")
    public List<String> getYStringUnicodeU2064InvisiblePlusJSON() { return yStringUnicodeU2064_InvisiblePlusJSON; }
    @JsonProperty("y_string_unicode_U+2064_invisible_plus.json")
    public void setYStringUnicodeU2064InvisiblePlusJSON(List<String> value) { this.yStringUnicodeU2064_InvisiblePlusJSON = value; }

    @JsonProperty("y_string_unicode_U+FDD0_nonchar.json")
    public List<String> getYStringUnicodeUFDD0NoncharJSON() { return yStringUnicodeUFDD0NoncharJSON; }
    @JsonProperty("y_string_unicode_U+FDD0_nonchar.json")
    public void setYStringUnicodeUFDD0NoncharJSON(List<String> value) { this.yStringUnicodeUFDD0NoncharJSON = value; }

    @JsonProperty("y_string_unicode_U+FFFE_nonchar.json")
    public List<String> getYStringUnicodeUFFFENoncharJSON() { return yStringUnicodeUFFFENoncharJSON; }
    @JsonProperty("y_string_unicode_U+FFFE_nonchar.json")
    public void setYStringUnicodeUFFFENoncharJSON(List<String> value) { this.yStringUnicodeUFFFENoncharJSON = value; }

    @JsonProperty("y_string_utf8.json")
    public List<String> getYStringUtf8JSON() { return yStringUtf8JSON; }
    @JsonProperty("y_string_utf8.json")
    public void setYStringUtf8JSON(List<String> value) { this.yStringUtf8JSON = value; }

    @JsonProperty("y_string_with_del_character.json")
    public List<String> getYStringWithDelCharacterJSON() { return yStringWithDelCharacterJSON; }
    @JsonProperty("y_string_with_del_character.json")
    public void setYStringWithDelCharacterJSON(List<String> value) { this.yStringWithDelCharacterJSON = value; }

    @JsonProperty("y_structure_lonely_false.json")
    public boolean getYStructureLonelyFalseJSON() { return yStructureLonelyFalseJSON; }
    @JsonProperty("y_structure_lonely_false.json")
    public void setYStructureLonelyFalseJSON(boolean value) { this.yStructureLonelyFalseJSON = value; }

    @JsonProperty("y_structure_lonely_int.json")
    public long getYStructureLonelyIntJSON() { return yStructureLonelyIntJSON; }
    @JsonProperty("y_structure_lonely_int.json")
    public void setYStructureLonelyIntJSON(long value) { this.yStructureLonelyIntJSON = value; }

    @JsonProperty("y_structure_lonely_negative_real.json")
    public double getYStructureLonelyNegativeRealJSON() { return yStructureLonelyNegativeRealJSON; }
    @JsonProperty("y_structure_lonely_negative_real.json")
    public void setYStructureLonelyNegativeRealJSON(double value) { this.yStructureLonelyNegativeRealJSON = value; }

    @JsonProperty("y_structure_lonely_null.json")
    public Object getYStructureLonelyNullJSON() { return yStructureLonelyNullJSON; }
    @JsonProperty("y_structure_lonely_null.json")
    public void setYStructureLonelyNullJSON(Object value) { this.yStructureLonelyNullJSON = value; }

    @JsonProperty("y_structure_lonely_string.json")
    public String getYStructureLonelyStringJSON() { return yStructureLonelyStringJSON; }
    @JsonProperty("y_structure_lonely_string.json")
    public void setYStructureLonelyStringJSON(String value) { this.yStructureLonelyStringJSON = value; }

    @JsonProperty("y_structure_lonely_true.json")
    public boolean getYStructureLonelyTrueJSON() { return yStructureLonelyTrueJSON; }
    @JsonProperty("y_structure_lonely_true.json")
    public void setYStructureLonelyTrueJSON(boolean value) { this.yStructureLonelyTrueJSON = value; }

    @JsonProperty("y_structure_string_empty.json")
    public String getYStructureStringEmptyJSON() { return yStructureStringEmptyJSON; }
    @JsonProperty("y_structure_string_empty.json")
    public void setYStructureStringEmptyJSON(String value) { this.yStructureStringEmptyJSON = value; }

    @JsonProperty("y_structure_trailing_newline.json")
    public List<String> getYStructureTrailingNewlineJSON() { return yStructureTrailingNewlineJSON; }
    @JsonProperty("y_structure_trailing_newline.json")
    public void setYStructureTrailingNewlineJSON(List<String> value) { this.yStructureTrailingNewlineJSON = value; }

    @JsonProperty("y_structure_true_in_array.json")
    public List<Boolean> getYStructureTrueInArrayJSON() { return yStructureTrueInArrayJSON; }
    @JsonProperty("y_structure_true_in_array.json")
    public void setYStructureTrueInArrayJSON(List<Boolean> value) { this.yStructureTrueInArrayJSON = value; }

    @JsonProperty("y_structure_whitespace_array.json")
    public List<Object> getYStructureWhitespaceArrayJSON() { return yStructureWhitespaceArrayJSON; }
    @JsonProperty("y_structure_whitespace_array.json")
    public void setYStructureWhitespaceArrayJSON(List<Object> value) { this.yStructureWhitespaceArrayJSON = value; }
}
