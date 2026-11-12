package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val `y_number_0e1.json` : Seq[Double],
    val `y_array_arraysWithSpaces.json` : Seq[Seq[Option[Json]]],
    val `y_array_empty.json` : Seq[Option[Json]],
    val `y_array_empty-string.json` : Seq[String],
    val `y_array_ending_with_newline.json` : Seq[String],
    val `y_array_false.json` : Seq[Boolean],
    val `y_array_heterogeneous.json` : Seq[YArrayHeterogeneousJSON],
    val `y_array_null.json` : Seq[Option[Json]],
    val `y_array_with_1_and_newline.json` : Seq[Long],
    val `y_array_with_leading_space.json` : Seq[Long],
    val `y_array_with_several_null.json` : Seq[Option[Long]],
    val `y_array_with_trailing_space.json` : Seq[Long],
    val `y_number_0e+1.json` : Seq[Double],
    val `y_number_after_space.json` : Seq[Long],
    val `y_number_double_close_to_zero.json` : Seq[Double],
    val `y_number_int_with_exp.json` : Seq[Double],
    val `y_number.json` : Seq[Double],
    val `y_number_minus_zero.json` : Seq[Long],
    val `y_number_negative_int.json` : Seq[Long],
    val `y_number_negative_one.json` : Seq[Long],
    val `y_number_negative_zero.json` : Seq[Long],
    val `y_number_real_capital_e.json` : Seq[Double],
    val `y_number_real_capital_e_neg_exp.json` : Seq[Double],
    val `y_number_real_capital_e_pos_exp.json` : Seq[Double],
    val `y_number_real_exponent.json` : Seq[Double],
    val `y_number_real_fraction_exponent.json` : Seq[Double],
    val `y_number_real_neg_exp.json` : Seq[Double],
    val `y_number_real_pos_exponent.json` : Seq[Double],
    val `y_number_simple_int.json` : Seq[Long],
    val `y_number_simple_real.json` : Seq[Double],
    val `y_object_basic.json` : YObjectBasicJSON,
    val `y_object_empty.json` : JSON,
    val `y_object_empty_key.json` : YObjectEmptyKeyJSON,
    val `y_object_escaped_null_in_key.json` : YObjectEscapedNullInKeyJSON,
    val `y_object_extreme_numbers.json` : YObjectExtremeNumbersJSON,
    val `y_object.json` : YObjectJSON,
    val `y_object_long_strings.json` : YObjectLongStringsJSON,
    val `y_object_simple.json` : YObjectSimpleJSON,
    val `y_object_string_unicode.json` : YObjectStringUnicodeJSON,
    val `y_object_with_newlines.json` : YObjectWithNewlinesJSON,
    val `y_string_1_2_3_bytes_UTF-8_sequences.json` : Seq[String],
    val `y_string_accepted_surrogate_pair.json` : Seq[String],
    val `y_string_accepted_surrogate_pairs.json` : Seq[String],
    val `y_string_allowed_escapes.json` : Seq[String],
    val `y_string_backslash_and_u_escaped_zero.json` : Seq[String],
    val `y_string_backslash_doublequotes.json` : Seq[String],
    val `y_string_comments.json` : Seq[String],
    val `y_string_double_escape_a.json` : Seq[String],
    val `y_string_double_escape_n.json` : Seq[String],
    val `y_string_escaped_control_character.json` : Seq[String],
    val `y_string_escaped_noncharacter.json` : Seq[String],
    val `y_string_in_array.json` : Seq[String],
    val `y_string_in_array_with_leading_space.json` : Seq[String],
    val `y_string_last_surrogates_1_and_2.json` : Seq[String],
    val `y_string_nbsp_uescaped.json` : Seq[String],
    val `y_string_nonCharacterInUTF-8_U+10FFFF.json` : Seq[String],
    val `y_string_nonCharacterInUTF-8_U+1FFFF.json` : Seq[String],
    val `y_string_nonCharacterInUTF-8_U+FFFF.json` : Seq[String],
    val `y_string_null_escape.json` : Seq[String],
    val `y_string_one-byte-utf-8.json` : Seq[String],
    val `y_string_pi.json` : Seq[String],
    val `y_string_simple_ascii.json` : Seq[String],
    val `y_string_space.json` : String,
    val `y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json` : Seq[String],
    val `y_string_three-byte-utf-8.json` : Seq[String],
    val `y_string_two-byte-utf-8.json` : Seq[String],
    val `y_string_u+2028_line_sep.json` : Seq[String],
    val `y_string_u+2029_par_sep.json` : Seq[String],
    val `y_string_uEscape.json` : Seq[String],
    val `y_string_uescaped_newline.json` : Seq[String],
    val `y_string_unescaped_char_delete.json` : Seq[String],
    val `y_string_unicode_2.json` : Seq[String],
    val `y_string_unicodeEscapedBackslash.json` : Seq[String],
    val `y_string_unicode_escaped_double_quote.json` : Seq[String],
    val `y_string_unicode.json` : Seq[String],
    val `y_string_unicode_U+10FFFE_nonchar.json` : Seq[String],
    val `y_string_unicode_U+1FFFE_nonchar.json` : Seq[String],
    val `y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json` : Seq[String],
    val `y_string_unicode_U+2064_invisible_plus.json` : Seq[String],
    val `y_string_unicode_U+FDD0_nonchar.json` : Seq[String],
    val `y_string_unicode_U+FFFE_nonchar.json` : Seq[String],
    val `y_string_utf8.json` : Seq[String],
    val `y_string_with_del_character.json` : Seq[String],
    val `y_structure_lonely_false.json` : Boolean,
    val `y_structure_lonely_int.json` : Long,
    val `y_structure_lonely_negative_real.json` : Double,
    val `y_structure_lonely_null.json` : Option[Json] = None,
    val `y_structure_lonely_string.json` : String,
    val `y_structure_lonely_true.json` : Boolean,
    val `y_structure_string_empty.json` : String,
    val `y_structure_trailing_newline.json` : Seq[String],
    val `y_structure_true_in_array.json` : Seq[Boolean],
    val `y_structure_whitespace_array.json` : Seq[Option[Json]]
) derives Encoder.AsObject, Decoder

type YArrayHeterogeneousJSON = Long | JSON | String | NullValue
given Decoder[YArrayHeterogeneousJSON] = {
    List[Decoder[YArrayHeterogeneousJSON]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[JSON].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[YArrayHeterogeneousJSON] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : JSON => Encoder.AsObject[JSON].apply(enc2)
    case enc3 : NullValue => Encoder.encodeNone(enc3)
}

case class JSON()  derives Encoder.AsObject, Decoder

case class YObjectBasicJSON (
    val asd : String
) derives Encoder.AsObject, Decoder

case class YObjectEmptyKeyJSON (
    val empty : Long
)

object YObjectEmptyKeyJSON:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "empty" -> ""
            )
        )
    given io.circe.Codec.AsObject[YObjectEmptyKeyJSON] = io.circe.derivation.ConfiguredCodec.derived

case class YObjectEscapedNullInKeyJSON (
    val fooBar : Long
)

object YObjectEscapedNullInKeyJSON:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "fooBar" -> "foo\u0000bar"
            )
        )
    given io.circe.Codec.AsObject[YObjectEscapedNullInKeyJSON] = io.circe.derivation.ConfiguredCodec.derived

case class YObjectExtremeNumbersJSON (
    val max : Double,
    val min : Double
) derives Encoder.AsObject, Decoder

case class YObjectJSON (
    val asd : String,
    val dfg : String
) derives Encoder.AsObject, Decoder

case class YObjectLongStringsJSON (
    val id : String,
    val x : Seq[X]
) derives Encoder.AsObject, Decoder

case class X (
    val id : String
) derives Encoder.AsObject, Decoder

case class YObjectSimpleJSON (
    val a : Seq[Option[Json]]
) derives Encoder.AsObject, Decoder

case class YObjectStringUnicodeJSON (
    val title : String
) derives Encoder.AsObject, Decoder

case class YObjectWithNewlinesJSON (
    val a : String
) derives Encoder.AsObject, Decoder
