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


type TopLevel = List[TopLevelUnion]

type TopLevelUnion = FluffyTopLevel | Seq[PurpleTopLevel]
given unionReaderTopLevelUnion: OptionPickler.Reader[TopLevelUnion] = JsonExt.badMerge[TopLevelUnion](
    summon[OptionPickler.Reader[Seq[PurpleTopLevel]]],
    summon[OptionPickler.Reader[FluffyTopLevel]],
    )

given unionWriterTopLevelUnion: OptionPickler.Writer[TopLevelUnion] = OptionPickler.writer[ujson.Value].comap[TopLevelUnion]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[PurpleTopLevel] => OptionPickler.writeJs[Seq[PurpleTopLevel]](v)
        case v: FluffyTopLevel => OptionPickler.writeJs[FluffyTopLevel](v)
}

case class PurpleTopLevel (
    val country : Country,
    val date : String,
    val decimal : String,
    val indicator : Country,
    val value : String
) derives OptionPickler.ReadWriter

case class Country (
    val id : ID,
    val value : Value
) derives OptionPickler.ReadWriter

enum ID : 
    case Us
    case NyGdpMktpCD

given OptionPickler.ReadWriter[ID] = OptionPickler.readwriter[String].bimap[ID](
    {
        case ID.Us => "US"
        case ID.NyGdpMktpCD => "NY.GDP.MKTP.CD"
    },
    {
        case "US" => ID.Us
        case "NY.GDP.MKTP.CD" => ID.NyGdpMktpCD
        case other => throw new upickle.core.Abort("invalid ID: " + other)
    }
)

enum Value : 
    case UnitedStates
    case GDPCurrentUS

given OptionPickler.ReadWriter[Value] = OptionPickler.readwriter[String].bimap[Value](
    {
        case Value.UnitedStates => "United States"
        case Value.GDPCurrentUS => "GDP (current US$)"
    },
    {
        case "United States" => Value.UnitedStates
        case "GDP (current US$)" => Value.GDPCurrentUS
        case other => throw new upickle.core.Abort("invalid Value: " + other)
    }
)

case class FluffyTopLevel (
    val page : Long,
    val pages : Long,
    val per_page : String,
    val total : Long
) derives OptionPickler.ReadWriter
