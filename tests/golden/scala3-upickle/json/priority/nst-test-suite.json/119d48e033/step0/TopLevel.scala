package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


case class TopLevel (
    val `y_number_0e1.json` : Seq[Double],
    val `y_array_arraysWithSpaces.json` : Seq[Seq[Option[ujson.Value]]],
    val `y_array_empty.json` : Seq[Option[ujson.Value]],
    val `y_array_empty-string.json` : Seq[String],
    val `y_array_ending_with_newline.json` : Seq[String],
    val `y_array_false.json` : Seq[Boolean],
    val `y_array_heterogeneous.json` : Seq[YArrayHeterogeneousJSON],
    val `y_array_null.json` : Seq[Option[ujson.Value]],
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
    val `y_structure_lonely_null.json` : Option[ujson.Value],
    val `y_structure_lonely_string.json` : String,
    val `y_structure_lonely_true.json` : Boolean,
    val `y_structure_string_empty.json` : String,
    val `y_structure_trailing_newline.json` : Seq[String],
    val `y_structure_true_in_array.json` : Seq[Boolean],
    val `y_structure_whitespace_array.json` : Seq[Option[ujson.Value]]
) derives OptionPickler.ReadWriter

type YArrayHeterogeneousJSON = Long | JSON | String | NullValue
given unionReaderYArrayHeterogeneousJSON: OptionPickler.Reader[YArrayHeterogeneousJSON] = JsonExt.badMerge[YArrayHeterogeneousJSON](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[JSON]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterYArrayHeterogeneousJSON: OptionPickler.Writer[YArrayHeterogeneousJSON] = OptionPickler.writer[ujson.Value].comap[YArrayHeterogeneousJSON]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: JSON => OptionPickler.writeJs[JSON](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class JSON()
 derives OptionPickler.ReadWriter
case class YObjectBasicJSON (
    val asd : String
) derives OptionPickler.ReadWriter

case class YObjectEmptyKeyJSON (
    @upickle.implicits.key("")
    val empty : Long
) derives OptionPickler.ReadWriter

case class YObjectEscapedNullInKeyJSON (
    @upickle.implicits.key("foo\u0000bar")
    val fooBar : Long
) derives OptionPickler.ReadWriter

case class YObjectExtremeNumbersJSON (
    val max : Double,
    val min : Double
) derives OptionPickler.ReadWriter

case class YObjectJSON (
    val asd : String,
    val dfg : String
) derives OptionPickler.ReadWriter

case class YObjectLongStringsJSON (
    val id : String,
    val x : Seq[X]
) derives OptionPickler.ReadWriter

case class X (
    val id : String
) derives OptionPickler.ReadWriter

case class YObjectSimpleJSON (
    val a : Seq[Option[ujson.Value]]
) derives OptionPickler.ReadWriter

case class YObjectStringUnicodeJSON (
    val title : String
) derives OptionPickler.ReadWriter

case class YObjectWithNewlinesJSON (
    val a : String
) derives OptionPickler.ReadWriter
