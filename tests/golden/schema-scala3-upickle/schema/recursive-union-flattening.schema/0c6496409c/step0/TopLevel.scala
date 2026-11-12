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


type TopLevel = Map[String, Option[ujson.Value]] | Boolean | Double | Long | String | Seq[TopLevelElement] | NullValue
given unionReaderTopLevel: OptionPickler.Reader[TopLevel] = JsonExt.badMerge[TopLevel](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[TopLevelElement]]],
    summon[OptionPickler.Reader[Map[String, Option[ujson.Value]]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterTopLevel: OptionPickler.Writer[TopLevel] = OptionPickler.writer[ujson.Value].comap[TopLevel]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[TopLevelElement] => OptionPickler.writeJs[Seq[TopLevelElement]](v)
        case v: Map[String, Option[ujson.Value]] => OptionPickler.writeJs[Map[String, Option[ujson.Value]]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type TopLevelElement = Seq[Option[ujson.Value]] | Boolean | Double | Long | String | TopLevelClass | NullValue
given unionReaderTopLevelElement: OptionPickler.Reader[TopLevelElement] = JsonExt.badMerge[TopLevelElement](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[TopLevelClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterTopLevelElement: OptionPickler.Writer[TopLevelElement] = OptionPickler.writer[ujson.Value].comap[TopLevelElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: TopLevelClass => OptionPickler.writeJs[TopLevelClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class TopLevelClass (
    val x : Option[X] = None
) derives OptionPickler.ReadWriter

case class XClass (
    val x : Option[X] = None
) derives OptionPickler.ReadWriter

type XElement = Seq[Option[ujson.Value]] | Boolean | Double | Long | String | XClass | NullValue
given unionReaderXElement: OptionPickler.Reader[XElement] = JsonExt.badMerge[XElement](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[XClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterXElement: OptionPickler.Writer[XElement] = OptionPickler.writer[ujson.Value].comap[XElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: XClass => OptionPickler.writeJs[XClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type X = Map[String, Option[ujson.Value]] | Boolean | Double | Long | String | Seq[XElement] | NullValue
given unionReaderX: OptionPickler.Reader[X] = JsonExt.badMerge[X](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[XElement]]],
    summon[OptionPickler.Reader[Map[String, Option[ujson.Value]]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterX: OptionPickler.Writer[X] = OptionPickler.writer[ujson.Value].comap[X]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[XElement] => OptionPickler.writeJs[Seq[XElement]](v)
        case v: Map[String, Option[ujson.Value]] => OptionPickler.writeJs[Map[String, Option[ujson.Value]]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}
