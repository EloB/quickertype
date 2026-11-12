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
    val metadata : Metadata,
    val results : Seq[Result]
) derives OptionPickler.ReadWriter

case class Metadata (
    val executionTime : Double,
    val responseInfo : ResponseInfo,
    val resultset : Resultset
) derives OptionPickler.ReadWriter

case class ResponseInfo (
    val developerMessage : String,
    val status : Long
) derives OptionPickler.ReadWriter

case class Resultset (
    val count : Long,
    val page : Long,
    val pagesize : Long
) derives OptionPickler.ReadWriter

case class Result (
    val about_office : String,
    val application_process : String,
    val body : String,
    val changed : String,
    val created : String,
    val deadline : Option[ujson.Value],
    val hiring_office : Option[ujson.Value],
    val hiring_org : HiringOrg,
    val job_id : Option[ujson.Value],
    val language : String,
    val location : Location,
    val num_positions : String,
    val position : String,
    val practice_area : String,
    val qualifications : String,
    val relocation_expenses : Option[ujson.Value],
    val salary : String,
    val title : String,
    val travel : String,
    val url : String,
    val uuid : java.util.UUID,
    val vuuid : java.util.UUID
) derives OptionPickler.ReadWriter

case class HiringOrg (
    val name : String,
    val uuid : java.util.UUID
) derives OptionPickler.ReadWriter

case class Location (
    val administrative_area : String,
    val country : String,
    val fax_number : String,
    val locality : String,
    val mobile_number : String,
    val phone_number : String,
    val phone_number_extension : String,
    val postal_code : String,
    val sub_premise : Option[ujson.Value],
    val thoroughfare : String
) derives OptionPickler.ReadWriter
