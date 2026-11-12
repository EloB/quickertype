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
    val data : Seq[Datum],
    val meta : Meta,
    val pagination : Pagination
) derives OptionPickler.ReadWriter

case class Datum (
    val bitly_gif_url : String,
    val bitly_url : String,
    val content_url : String,
    val `type` : Type,
    val embed_url : String,
    val id : String,
    val images : Images,
    val import_datetime : String,
    val is_indexable : Long,
    val rating : Rating,
    val slug : String,
    val source : String,
    val source_post_url : String,
    val source_tld : String,
    val trending_datetime : String,
    val url : String,
    val user : Option[User] = None,
    val username : Username
) derives OptionPickler.ReadWriter

enum Type : 
    case GIF

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.GIF => "gif"
    },
    {
        case "gif" => Type.GIF
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)

case class Images (
    val downsized : The480_WStill,
    val downsized_large : The480_WStill,
    val downsized_medium : The480_WStill,
    val downsized_small : DownsizedSmall,
    val downsized_still : The480_WStill,
    val fixed_height : FixedHeight,
    val fixed_height_downsampled : FixedHeight,
    val fixed_height_small : FixedHeight,
    val fixed_height_small_still : The480_WStill,
    val fixed_height_still : The480_WStill,
    val fixed_width : FixedHeight,
    val fixed_width_downsampled : FixedHeight,
    val fixed_width_small : FixedHeight,
    val fixed_width_small_still : The480_WStill,
    val fixed_width_still : The480_WStill,
    val looping : Looping,
    val original : FixedHeight,
    val original_mp4 : DownsizedSmall,
    val original_still : The480_WStill,
    val preview : DownsizedSmall,
    val preview_gif : The480_WStill,
    val preview_webp : The480_WStill,
    val `480w_still` : Option[The480_WStill] = None
) derives OptionPickler.ReadWriter

case class The480_WStill (
    val height : String,
    val size : Option[String] = None,
    val url : String,
    val width : String
) derives OptionPickler.ReadWriter

case class DownsizedSmall (
    val height : String,
    val mp4 : String,
    val mp4_size : String,
    val width : String
) derives OptionPickler.ReadWriter

case class FixedHeight (
    val frames : Option[String] = None,
    val hash : Option[String] = None,
    val height : String,
    val mp4 : Option[String] = None,
    val mp4_size : Option[String] = None,
    val size : String,
    val url : String,
    val webp : String,
    val webp_size : String,
    val width : String
) derives OptionPickler.ReadWriter

case class Looping (
    val mp4 : String,
    val mp4_size : String
) derives OptionPickler.ReadWriter

enum Rating : 
    case G
    case PG

given OptionPickler.ReadWriter[Rating] = OptionPickler.readwriter[String].bimap[Rating](
    {
        case Rating.G => "g"
        case Rating.PG => "pg"
    },
    {
        case "g" => Rating.G
        case "pg" => Rating.PG
        case other => throw new upickle.core.Abort("invalid Rating: " + other)
    }
)

case class User (
    val avatar_url : String,
    val banner_url : String,
    val display_name : String,
    val profile_url : String,
    val twitter : String,
    val username : Username
) derives OptionPickler.ReadWriter

enum Username : 
    case Cheezburger
    case Empty
    case Natgeowild
    case Nowthis

given OptionPickler.ReadWriter[Username] = OptionPickler.readwriter[String].bimap[Username](
    {
        case Username.Cheezburger => "cheezburger"
        case Username.Empty => ""
        case Username.Natgeowild => "natgeowild"
        case Username.Nowthis => "nowthis"
    },
    {
        case "cheezburger" => Username.Cheezburger
        case "" => Username.Empty
        case "natgeowild" => Username.Natgeowild
        case "nowthis" => Username.Nowthis
        case other => throw new upickle.core.Abort("invalid Username: " + other)
    }
)

case class Meta (
    val msg : String,
    val response_id : String,
    val status : Long
) derives OptionPickler.ReadWriter

case class Pagination (
    val count : Long,
    val offset : Long,
    val total_count : Long
) derives OptionPickler.ReadWriter
