// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
            override fun getNullValue(ctxt: DeserializationContext) = if (isUnion) fromJson(NullNode.instance) else null
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(YArrayHeterogeneousJSON::class, { YArrayHeterogeneousJSON.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty("y_number_0e1.json", required=true)@field:JsonProperty("y_number_0e1.json", required=true)
    val topLevelYNumber0E1JSON: List<Double>,

    @get:JsonProperty("y_array_arraysWithSpaces.json", required=true)@field:JsonProperty("y_array_arraysWithSpaces.json", required=true)
    val yArrayArraysWithSpacesJSON: List<List<Any?>>,

    @get:JsonProperty("y_array_empty.json", required=true)@field:JsonProperty("y_array_empty.json", required=true)
    val yArrayEmptyJSON: List<Any?>,

    @get:JsonProperty("y_array_empty-string.json", required=true)@field:JsonProperty("y_array_empty-string.json", required=true)
    val yArrayEmptyStringJSON: List<String>,

    @get:JsonProperty("y_array_ending_with_newline.json", required=true)@field:JsonProperty("y_array_ending_with_newline.json", required=true)
    val yArrayEndingWithNewlineJSON: List<String>,

    @get:JsonProperty("y_array_false.json", required=true)@field:JsonProperty("y_array_false.json", required=true)
    val yArrayFalseJSON: List<Boolean>,

    @get:JsonProperty("y_array_heterogeneous.json", required=true)@field:JsonProperty("y_array_heterogeneous.json", required=true)
    val yArrayHeterogeneousJSON: List<YArrayHeterogeneousJSON>,

    @get:JsonProperty("y_array_null.json", required=true)@field:JsonProperty("y_array_null.json", required=true)
    val yArrayNullJSON: List<Any?>,

    @get:JsonProperty("y_array_with_1_and_newline.json", required=true)@field:JsonProperty("y_array_with_1_and_newline.json", required=true)
    val yArrayWith1_AndNewlineJSON: List<Long>,

    @get:JsonProperty("y_array_with_leading_space.json", required=true)@field:JsonProperty("y_array_with_leading_space.json", required=true)
    val yArrayWithLeadingSpaceJSON: List<Long>,

    @get:JsonProperty("y_array_with_several_null.json", required=true)@field:JsonProperty("y_array_with_several_null.json", required=true)
    val yArrayWithSeveralNullJSON: List<Long?>,

    @get:JsonProperty("y_array_with_trailing_space.json", required=true)@field:JsonProperty("y_array_with_trailing_space.json", required=true)
    val yArrayWithTrailingSpaceJSON: List<Long>,

    @get:JsonProperty("y_number_0e+1.json", required=true)@field:JsonProperty("y_number_0e+1.json", required=true)
    val yNumber0E1JSON: List<Double>,

    @get:JsonProperty("y_number_after_space.json", required=true)@field:JsonProperty("y_number_after_space.json", required=true)
    val yNumberAfterSpaceJSON: List<Long>,

    @get:JsonProperty("y_number_double_close_to_zero.json", required=true)@field:JsonProperty("y_number_double_close_to_zero.json", required=true)
    val yNumberDoubleCloseToZeroJSON: List<Double>,

    @get:JsonProperty("y_number_int_with_exp.json", required=true)@field:JsonProperty("y_number_int_with_exp.json", required=true)
    val yNumberIntWithExpJSON: List<Double>,

    @get:JsonProperty("y_number.json", required=true)@field:JsonProperty("y_number.json", required=true)
    val yNumberJSON: List<Double>,

    @get:JsonProperty("y_number_minus_zero.json", required=true)@field:JsonProperty("y_number_minus_zero.json", required=true)
    val yNumberMinusZeroJSON: List<Long>,

    @get:JsonProperty("y_number_negative_int.json", required=true)@field:JsonProperty("y_number_negative_int.json", required=true)
    val yNumberNegativeIntJSON: List<Long>,

    @get:JsonProperty("y_number_negative_one.json", required=true)@field:JsonProperty("y_number_negative_one.json", required=true)
    val yNumberNegativeOneJSON: List<Long>,

    @get:JsonProperty("y_number_negative_zero.json", required=true)@field:JsonProperty("y_number_negative_zero.json", required=true)
    val yNumberNegativeZeroJSON: List<Long>,

    @get:JsonProperty("y_number_real_capital_e.json", required=true)@field:JsonProperty("y_number_real_capital_e.json", required=true)
    val yNumberRealCapitalEJSON: List<Double>,

    @get:JsonProperty("y_number_real_capital_e_neg_exp.json", required=true)@field:JsonProperty("y_number_real_capital_e_neg_exp.json", required=true)
    val yNumberRealCapitalENegExpJSON: List<Double>,

    @get:JsonProperty("y_number_real_capital_e_pos_exp.json", required=true)@field:JsonProperty("y_number_real_capital_e_pos_exp.json", required=true)
    val yNumberRealCapitalEPosExpJSON: List<Double>,

    @get:JsonProperty("y_number_real_exponent.json", required=true)@field:JsonProperty("y_number_real_exponent.json", required=true)
    val yNumberRealExponentJSON: List<Double>,

    @get:JsonProperty("y_number_real_fraction_exponent.json", required=true)@field:JsonProperty("y_number_real_fraction_exponent.json", required=true)
    val yNumberRealFractionExponentJSON: List<Double>,

    @get:JsonProperty("y_number_real_neg_exp.json", required=true)@field:JsonProperty("y_number_real_neg_exp.json", required=true)
    val yNumberRealNegExpJSON: List<Double>,

    @get:JsonProperty("y_number_real_pos_exponent.json", required=true)@field:JsonProperty("y_number_real_pos_exponent.json", required=true)
    val yNumberRealPosExponentJSON: List<Double>,

    @get:JsonProperty("y_number_simple_int.json", required=true)@field:JsonProperty("y_number_simple_int.json", required=true)
    val yNumberSimpleIntJSON: List<Long>,

    @get:JsonProperty("y_number_simple_real.json", required=true)@field:JsonProperty("y_number_simple_real.json", required=true)
    val yNumberSimpleRealJSON: List<Double>,

    @get:JsonProperty("y_object_basic.json", required=true)@field:JsonProperty("y_object_basic.json", required=true)
    val yObjectBasicJSON: YObjectBasicJSON,

    @get:JsonProperty("y_object_empty.json", required=true)@field:JsonProperty("y_object_empty.json", required=true)
    val yObjectEmptyJSON: JSON,

    @get:JsonProperty("y_object_empty_key.json", required=true)@field:JsonProperty("y_object_empty_key.json", required=true)
    val yObjectEmptyKeyJSON: YObjectEmptyKeyJSON,

    @get:JsonProperty("y_object_escaped_null_in_key.json", required=true)@field:JsonProperty("y_object_escaped_null_in_key.json", required=true)
    val yObjectEscapedNullInKeyJSON: YObjectEscapedNullInKeyJSON,

    @get:JsonProperty("y_object_extreme_numbers.json", required=true)@field:JsonProperty("y_object_extreme_numbers.json", required=true)
    val yObjectExtremeNumbersJSON: YObjectExtremeNumbersJSON,

    @get:JsonProperty("y_object.json", required=true)@field:JsonProperty("y_object.json", required=true)
    val yObjectJSON: YObjectJSON,

    @get:JsonProperty("y_object_long_strings.json", required=true)@field:JsonProperty("y_object_long_strings.json", required=true)
    val yObjectLongStringsJSON: YObjectLongStringsJSON,

    @get:JsonProperty("y_object_simple.json", required=true)@field:JsonProperty("y_object_simple.json", required=true)
    val yObjectSimpleJSON: YObjectSimpleJSON,

    @get:JsonProperty("y_object_string_unicode.json", required=true)@field:JsonProperty("y_object_string_unicode.json", required=true)
    val yObjectStringUnicodeJSON: YObjectStringUnicodeJSON,

    @get:JsonProperty("y_object_with_newlines.json", required=true)@field:JsonProperty("y_object_with_newlines.json", required=true)
    val yObjectWithNewlinesJSON: YObjectWithNewlinesJSON,

    @get:JsonProperty("y_string_1_2_3_bytes_UTF-8_sequences.json", required=true)@field:JsonProperty("y_string_1_2_3_bytes_UTF-8_sequences.json", required=true)
    val yString1_2_3_BytesUTF8_SequencesJSON: List<String>,

    @get:JsonProperty("y_string_accepted_surrogate_pair.json", required=true)@field:JsonProperty("y_string_accepted_surrogate_pair.json", required=true)
    val yStringAcceptedSurrogatePairJSON: List<String>,

    @get:JsonProperty("y_string_accepted_surrogate_pairs.json", required=true)@field:JsonProperty("y_string_accepted_surrogate_pairs.json", required=true)
    val yStringAcceptedSurrogatePairsJSON: List<String>,

    @get:JsonProperty("y_string_allowed_escapes.json", required=true)@field:JsonProperty("y_string_allowed_escapes.json", required=true)
    val yStringAllowedEscapesJSON: List<String>,

    @get:JsonProperty("y_string_backslash_and_u_escaped_zero.json", required=true)@field:JsonProperty("y_string_backslash_and_u_escaped_zero.json", required=true)
    val yStringBackslashAndUEscapedZeroJSON: List<String>,

    @get:JsonProperty("y_string_backslash_doublequotes.json", required=true)@field:JsonProperty("y_string_backslash_doublequotes.json", required=true)
    val yStringBackslashDoublequotesJSON: List<String>,

    @get:JsonProperty("y_string_comments.json", required=true)@field:JsonProperty("y_string_comments.json", required=true)
    val yStringCommentsJSON: List<String>,

    @get:JsonProperty("y_string_double_escape_a.json", required=true)@field:JsonProperty("y_string_double_escape_a.json", required=true)
    val yStringDoubleEscapeAJSON: List<String>,

    @get:JsonProperty("y_string_double_escape_n.json", required=true)@field:JsonProperty("y_string_double_escape_n.json", required=true)
    val yStringDoubleEscapeNJSON: List<String>,

    @get:JsonProperty("y_string_escaped_control_character.json", required=true)@field:JsonProperty("y_string_escaped_control_character.json", required=true)
    val yStringEscapedControlCharacterJSON: List<String>,

    @get:JsonProperty("y_string_escaped_noncharacter.json", required=true)@field:JsonProperty("y_string_escaped_noncharacter.json", required=true)
    val yStringEscapedNoncharacterJSON: List<String>,

    @get:JsonProperty("y_string_in_array.json", required=true)@field:JsonProperty("y_string_in_array.json", required=true)
    val yStringInArrayJSON: List<String>,

    @get:JsonProperty("y_string_in_array_with_leading_space.json", required=true)@field:JsonProperty("y_string_in_array_with_leading_space.json", required=true)
    val yStringInArrayWithLeadingSpaceJSON: List<String>,

    @get:JsonProperty("y_string_last_surrogates_1_and_2.json", required=true)@field:JsonProperty("y_string_last_surrogates_1_and_2.json", required=true)
    val yStringLastSurrogates1_And2JSON: List<String>,

    @get:JsonProperty("y_string_nbsp_uescaped.json", required=true)@field:JsonProperty("y_string_nbsp_uescaped.json", required=true)
    val yStringNbspUescapedJSON: List<String>,

    @get:JsonProperty("y_string_nonCharacterInUTF-8_U+10FFFF.json", required=true)@field:JsonProperty("y_string_nonCharacterInUTF-8_U+10FFFF.json", required=true)
    val yStringNonCharacterInUTF8_U10FFFFJSON: List<String>,

    @get:JsonProperty("y_string_nonCharacterInUTF-8_U+1FFFF.json", required=true)@field:JsonProperty("y_string_nonCharacterInUTF-8_U+1FFFF.json", required=true)
    val yStringNonCharacterInUTF8_U1FFFFJSON: List<String>,

    @get:JsonProperty("y_string_nonCharacterInUTF-8_U+FFFF.json", required=true)@field:JsonProperty("y_string_nonCharacterInUTF-8_U+FFFF.json", required=true)
    val yStringNonCharacterInUTF8_UFFFFJSON: List<String>,

    @get:JsonProperty("y_string_null_escape.json", required=true)@field:JsonProperty("y_string_null_escape.json", required=true)
    val yStringNullEscapeJSON: List<String>,

    @get:JsonProperty("y_string_one-byte-utf-8.json", required=true)@field:JsonProperty("y_string_one-byte-utf-8.json", required=true)
    val yStringOneByteUTF8JSON: List<String>,

    @get:JsonProperty("y_string_pi.json", required=true)@field:JsonProperty("y_string_pi.json", required=true)
    val yStringPiJSON: List<String>,

    @get:JsonProperty("y_string_simple_ascii.json", required=true)@field:JsonProperty("y_string_simple_ascii.json", required=true)
    val yStringSimpleASCIIJSON: List<String>,

    @get:JsonProperty("y_string_space.json", required=true)@field:JsonProperty("y_string_space.json", required=true)
    val yStringSpaceJSON: String,

    @get:JsonProperty("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json", required=true)@field:JsonProperty("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json", required=true)
    val yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON: List<String>,

    @get:JsonProperty("y_string_three-byte-utf-8.json", required=true)@field:JsonProperty("y_string_three-byte-utf-8.json", required=true)
    val yStringThreeByteUTF8JSON: List<String>,

    @get:JsonProperty("y_string_two-byte-utf-8.json", required=true)@field:JsonProperty("y_string_two-byte-utf-8.json", required=true)
    val yStringTwoByteUTF8JSON: List<String>,

    @get:JsonProperty("y_string_u+2028_line_sep.json", required=true)@field:JsonProperty("y_string_u+2028_line_sep.json", required=true)
    val yStringU2028_LineSepJSON: List<String>,

    @get:JsonProperty("y_string_u+2029_par_sep.json", required=true)@field:JsonProperty("y_string_u+2029_par_sep.json", required=true)
    val yStringU2029_ParSepJSON: List<String>,

    @get:JsonProperty("y_string_uEscape.json", required=true)@field:JsonProperty("y_string_uEscape.json", required=true)
    val yStringUEscapeJSON: List<String>,

    @get:JsonProperty("y_string_uescaped_newline.json", required=true)@field:JsonProperty("y_string_uescaped_newline.json", required=true)
    val yStringUescapedNewlineJSON: List<String>,

    @get:JsonProperty("y_string_unescaped_char_delete.json", required=true)@field:JsonProperty("y_string_unescaped_char_delete.json", required=true)
    val yStringUnescapedCharDeleteJSON: List<String>,

    @get:JsonProperty("y_string_unicode_2.json", required=true)@field:JsonProperty("y_string_unicode_2.json", required=true)
    val yStringUnicode2JSON: List<String>,

    @get:JsonProperty("y_string_unicodeEscapedBackslash.json", required=true)@field:JsonProperty("y_string_unicodeEscapedBackslash.json", required=true)
    val yStringUnicodeEscapedBackslashJSON: List<String>,

    @get:JsonProperty("y_string_unicode_escaped_double_quote.json", required=true)@field:JsonProperty("y_string_unicode_escaped_double_quote.json", required=true)
    val yStringUnicodeEscapedDoubleQuoteJSON: List<String>,

    @get:JsonProperty("y_string_unicode.json", required=true)@field:JsonProperty("y_string_unicode.json", required=true)
    val yStringUnicodeJSON: List<String>,

    @get:JsonProperty("y_string_unicode_U+10FFFE_nonchar.json", required=true)@field:JsonProperty("y_string_unicode_U+10FFFE_nonchar.json", required=true)
    val yStringUnicodeU10FFFENoncharJSON: List<String>,

    @get:JsonProperty("y_string_unicode_U+1FFFE_nonchar.json", required=true)@field:JsonProperty("y_string_unicode_U+1FFFE_nonchar.json", required=true)
    val yStringUnicodeU1FFFENoncharJSON: List<String>,

    @get:JsonProperty("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json", required=true)@field:JsonProperty("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json", required=true)
    val yStringUnicodeU200BZEROWIDTHSPACEJSON: List<String>,

    @get:JsonProperty("y_string_unicode_U+2064_invisible_plus.json", required=true)@field:JsonProperty("y_string_unicode_U+2064_invisible_plus.json", required=true)
    val yStringUnicodeU2064_InvisiblePlusJSON: List<String>,

    @get:JsonProperty("y_string_unicode_U+FDD0_nonchar.json", required=true)@field:JsonProperty("y_string_unicode_U+FDD0_nonchar.json", required=true)
    val yStringUnicodeUFDD0NoncharJSON: List<String>,

    @get:JsonProperty("y_string_unicode_U+FFFE_nonchar.json", required=true)@field:JsonProperty("y_string_unicode_U+FFFE_nonchar.json", required=true)
    val yStringUnicodeUFFFENoncharJSON: List<String>,

    @get:JsonProperty("y_string_utf8.json", required=true)@field:JsonProperty("y_string_utf8.json", required=true)
    val yStringUtf8JSON: List<String>,

    @get:JsonProperty("y_string_with_del_character.json", required=true)@field:JsonProperty("y_string_with_del_character.json", required=true)
    val yStringWithDelCharacterJSON: List<String>,

    @get:JsonProperty("y_structure_lonely_false.json", required=true)@field:JsonProperty("y_structure_lonely_false.json", required=true)
    val yStructureLonelyFalseJSON: Boolean,

    @get:JsonProperty("y_structure_lonely_int.json", required=true)@field:JsonProperty("y_structure_lonely_int.json", required=true)
    val yStructureLonelyIntJSON: Long,

    @get:JsonProperty("y_structure_lonely_negative_real.json", required=true)@field:JsonProperty("y_structure_lonely_negative_real.json", required=true)
    val yStructureLonelyNegativeRealJSON: Double,

    @get:JsonProperty("y_structure_lonely_null.json", required=true)@field:JsonProperty("y_structure_lonely_null.json", required=true)
    val yStructureLonelyNullJSON: Any? = null,

    @get:JsonProperty("y_structure_lonely_string.json", required=true)@field:JsonProperty("y_structure_lonely_string.json", required=true)
    val yStructureLonelyStringJSON: String,

    @get:JsonProperty("y_structure_lonely_true.json", required=true)@field:JsonProperty("y_structure_lonely_true.json", required=true)
    val yStructureLonelyTrueJSON: Boolean,

    @get:JsonProperty("y_structure_string_empty.json", required=true)@field:JsonProperty("y_structure_string_empty.json", required=true)
    val yStructureStringEmptyJSON: String,

    @get:JsonProperty("y_structure_trailing_newline.json", required=true)@field:JsonProperty("y_structure_trailing_newline.json", required=true)
    val yStructureTrailingNewlineJSON: List<String>,

    @get:JsonProperty("y_structure_true_in_array.json", required=true)@field:JsonProperty("y_structure_true_in_array.json", required=true)
    val yStructureTrueInArrayJSON: List<Boolean>,

    @get:JsonProperty("y_structure_whitespace_array.json", required=true)@field:JsonProperty("y_structure_whitespace_array.json", required=true)
    val yStructureWhitespaceArrayJSON: List<Any?>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class YArrayHeterogeneousJSON {
    class IntegerValue(val value: Long)  : YArrayHeterogeneousJSON()
    class JSONValue(val value: JSON)     : YArrayHeterogeneousJSON()
    class StringValue(val value: String) : YArrayHeterogeneousJSON()
    class NullValue()                    : YArrayHeterogeneousJSON()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is JSONValue    -> this.value
        is StringValue  -> this.value
        is NullValue    -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): YArrayHeterogeneousJSON = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> JSONValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

typealias JSON = ObjectNode

data class YObjectBasicJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val asd: String
)

data class YObjectEmptyKeyJSON (
    @get:JsonProperty("", required=true)@field:JsonProperty("", required=true)
    val empty: Long
)

data class YObjectEscapedNullInKeyJSON (
    @get:JsonProperty("foo\u0000bar", required=true)@field:JsonProperty("foo\u0000bar", required=true)
    val fooBar: Long
)

data class YObjectExtremeNumbersJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val max: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val min: Double
)

data class YObjectJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val asd: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dfg: String
)

data class YObjectLongStringsJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val x: List<X>
)

data class X (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String
)

data class YObjectSimpleJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val a: List<Any?>
)

data class YObjectStringUnicodeJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String
)

data class YObjectWithNewlinesJSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val a: String
)
