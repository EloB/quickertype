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
    val arr : Option[Seq[Arr]] = None,
    val `for` : Option[String] = None,
    val gve : Gve,
    val lvc : Option[Lvc] = None,
    val otherArr : Option[Seq[OtherArr]] = None
) derives OptionPickler.ReadWriter

type Arr = OtherArr | Long
given unionReaderArr: OptionPickler.Reader[Arr] = JsonExt.badMerge[Arr](
    summon[OptionPickler.Reader[OtherArr]],
    JsonExt.strictLong,
    )

given unionWriterArr: OptionPickler.Writer[Arr] = OptionPickler.writer[ujson.Value].comap[Arr]{ _v =>
    (_v: @unchecked) match 
        case v: OtherArr => OptionPickler.writeJs[OtherArr](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

enum OtherArr : 
    case Foo
    case Bar
    case If

given OptionPickler.ReadWriter[OtherArr] = OptionPickler.readwriter[String].bimap[OtherArr](
    {
        case OtherArr.Foo => "foo"
        case OtherArr.Bar => "bar"
        case OtherArr.If => "if"
    },
    {
        case "foo" => OtherArr.Foo
        case "bar" => OtherArr.Bar
        case "if" => OtherArr.If
        case other => throw new upickle.core.Abort("invalid OtherArr: " + other)
    }
)

enum Gve : 
    case Good
    case Neutral
    case Evil

given OptionPickler.ReadWriter[Gve] = OptionPickler.readwriter[String].bimap[Gve](
    {
        case Gve.Good => "good"
        case Gve.Neutral => "neutral"
        case Gve.Evil => "evil"
    },
    {
        case "good" => Gve.Good
        case "neutral" => Gve.Neutral
        case "evil" => Gve.Evil
        case other => throw new upickle.core.Abort("invalid Gve: " + other)
    }
)

enum Lvc : 
    case Lawful
    case Neutral
    case Chaotic

given OptionPickler.ReadWriter[Lvc] = OptionPickler.readwriter[String].bimap[Lvc](
    {
        case Lvc.Lawful => "lawful"
        case Lvc.Neutral => "neutral"
        case Lvc.Chaotic => "chaotic"
    },
    {
        case "lawful" => Lvc.Lawful
        case "neutral" => Lvc.Neutral
        case "chaotic" => Lvc.Chaotic
        case other => throw new upickle.core.Abort("invalid Lvc: " + other)
    }
)
