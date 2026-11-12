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
    val booleanValue : Boolean,
    val dateValue : String,
    val differentThings : Seq[DifferentThingElement],
    val doubleValue : Double,
    val intValue : Long,
    val mapValue : Map[String, Option[Long]],
    val `name with spaces` : Option[ujson.Value],
    val nullValue : Option[ujson.Value],
    val nullableMapValue : Map[String, Option[Long]],
    val people : Seq[PersonElement],
    val person : PurplePerson,
    val stringValue : String,
    val tuples : Seq[Seq[IntOrString]],
    val uuidValue : String
) derives OptionPickler.ReadWriter

type DifferentThingElement = DifferentThingClass | Long | String
given unionReaderDifferentThingElement: OptionPickler.Reader[DifferentThingElement] = JsonExt.badMerge[DifferentThingElement](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[DifferentThingClass]],
    )

given unionWriterDifferentThingElement: OptionPickler.Writer[DifferentThingElement] = OptionPickler.writer[ujson.Value].comap[DifferentThingElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: DifferentThingClass => OptionPickler.writeJs[DifferentThingClass](v)
}

case class DifferentThingClass (
    val name : String
) derives OptionPickler.ReadWriter

case class PersonElement (
    val intOrString : IntOrString,
    val name : String,
    val optionalValue : Option[Boolean] = None
) derives OptionPickler.ReadWriter

type IntOrString = Long | String
given unionReaderIntOrString: OptionPickler.Reader[IntOrString] = JsonExt.badMerge[IntOrString](
    JsonExt.strictString,
    JsonExt.strictLong,
    )

given unionWriterIntOrString: OptionPickler.Writer[IntOrString] = OptionPickler.writer[ujson.Value].comap[IntOrString]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

case class PurplePerson (
    val intOrString : Long,
    val name : String
) derives OptionPickler.ReadWriter
