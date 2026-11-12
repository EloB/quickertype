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
    val count : Long,
    val next : String,
    val previous : Option[ujson.Value],
    val results : Seq[Result]
) derives OptionPickler.ReadWriter

case class Result (
    val active_screens : Long,
    val collections : Seq[Collection],
    val details : Seq[Detail],
    val duration : Long,
    val fav_movie : FavMovie,
    val id : Long,
    val images : Seq[Image],
    val language : ResultLanguage,
    val release_date : String,
    val stars : Long,
    val tags : Option[Seq[Option[ujson.Value]]],
    val title : String,
    val videos : Seq[Video],
    val vote_score : VoteScore,
    val watches : Long
) derives OptionPickler.ReadWriter

case class Collection (
    val id : Long,
    val movies : Seq[Long],
    val name : String,
    val slug : String
) derives OptionPickler.ReadWriter

case class Detail (
    val cast : String,
    val director : String,
    val id : Long,
    val language : DetailLanguage,
    val storyline : String,
    val tagline : String,
    val title : String
) derives OptionPickler.ReadWriter

enum DetailLanguage : 
    case En
    case Th

given OptionPickler.ReadWriter[DetailLanguage] = OptionPickler.readwriter[String].bimap[DetailLanguage](
    {
        case DetailLanguage.En => "en"
        case DetailLanguage.Th => "th"
    },
    {
        case "en" => DetailLanguage.En
        case "th" => DetailLanguage.Th
        case other => throw new upickle.core.Abort("invalid DetailLanguage: " + other)
    }
)

case class FavMovie (
    val follow : Boolean,
    val star : Boolean,
    val watched : Boolean
) derives OptionPickler.ReadWriter

case class Image (
    val favs : Long,
    val id : Long,
    val `type` : Type,
    val thumbnail : String,
    val url : String
) derives OptionPickler.ReadWriter

enum Type : 
    case Poster
    case Backdrop

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.Poster => "Poster"
        case Type.Backdrop => "Backdrop"
    },
    {
        case "Poster" => Type.Poster
        case "Backdrop" => Type.Backdrop
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)

enum ResultLanguage : 
    case En
    case Empty

given OptionPickler.ReadWriter[ResultLanguage] = OptionPickler.readwriter[String].bimap[ResultLanguage](
    {
        case ResultLanguage.En => "en"
        case ResultLanguage.Empty => "-"
    },
    {
        case "en" => ResultLanguage.En
        case "-" => ResultLanguage.Empty
        case other => throw new upickle.core.Abort("invalid ResultLanguage: " + other)
    }
)

case class Video (
    val kind : String,
    val language : ResultLanguage,
    val source : String,
    val url : String
) derives OptionPickler.ReadWriter

case class VoteScore (
    val avg : Long,
    val score : Long,
    val total : Long
) derives OptionPickler.ReadWriter
