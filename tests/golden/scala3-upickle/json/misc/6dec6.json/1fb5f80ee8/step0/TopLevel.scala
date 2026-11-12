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
    val query : Query
) derives OptionPickler.ReadWriter

case class Query (
    val count : Long,
    val created : java.time.Instant,
    val lang : String,
    val results : Results
) derives OptionPickler.ReadWriter

case class Results (
    val channel : Channel
) derives OptionPickler.ReadWriter

case class Channel (
    val astronomy : Astronomy,
    val atmosphere : Atmosphere,
    val description : String,
    val image : Image,
    val item : Item,
    val language : String,
    val lastBuildDate : String,
    val link : String,
    val location : Location,
    val title : String,
    val ttl : String,
    val units : Units,
    val wind : Wind
) derives OptionPickler.ReadWriter

case class Astronomy (
    val sunrise : String,
    val sunset : String
) derives OptionPickler.ReadWriter

case class Atmosphere (
    val humidity : String,
    val pressure : String,
    val rising : String,
    val visibility : String
) derives OptionPickler.ReadWriter

case class Image (
    val height : String,
    val link : String,
    val title : String,
    val url : String,
    val width : String
) derives OptionPickler.ReadWriter

case class Item (
    val condition : Condition,
    val description : String,
    val forecast : Seq[Forecast],
    val guid : GUID,
    val lat : String,
    val link : String,
    val long : String,
    val pubDate : String,
    val title : String
) derives OptionPickler.ReadWriter

case class Condition (
    val code : String,
    val date : String,
    val temp : String,
    val text : String
) derives OptionPickler.ReadWriter

case class Forecast (
    val code : String,
    val date : String,
    val day : String,
    val high : String,
    val low : String,
    val text : Text
) derives OptionPickler.ReadWriter

enum Text : 
    case Showers
    case MostlySunny
    case PartlyCloudy

given OptionPickler.ReadWriter[Text] = OptionPickler.readwriter[String].bimap[Text](
    {
        case Text.Showers => "Showers"
        case Text.MostlySunny => "Mostly Sunny"
        case Text.PartlyCloudy => "Partly Cloudy"
    },
    {
        case "Showers" => Text.Showers
        case "Mostly Sunny" => Text.MostlySunny
        case "Partly Cloudy" => Text.PartlyCloudy
        case other => throw new upickle.core.Abort("invalid Text: " + other)
    }
)

case class GUID (
    val isPermaLink : String
) derives OptionPickler.ReadWriter

case class Location (
    val city : String,
    val country : String,
    val region : String
) derives OptionPickler.ReadWriter

case class Units (
    val distance : String,
    val pressure : String,
    val speed : String,
    val temperature : String
) derives OptionPickler.ReadWriter

case class Wind (
    val chill : String,
    val direction : String,
    val speed : String
) derives OptionPickler.ReadWriter
