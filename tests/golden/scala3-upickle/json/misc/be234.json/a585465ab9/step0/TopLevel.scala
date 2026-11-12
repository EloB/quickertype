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
    val data : TopLevelData,
    val kind : String
) derives OptionPickler.ReadWriter

case class TopLevelData (
    val after : String,
    val before : Option[ujson.Value],
    val children : Seq[Child],
    val modhash : String
) derives OptionPickler.ReadWriter

case class Child (
    val data : ChildData,
    val kind : Kind
) derives OptionPickler.ReadWriter

case class ChildData (
    val approved_at_utc : Option[ujson.Value],
    val approved_by : Option[ujson.Value],
    val archived : Boolean,
    val author : String,
    val author_flair_css_class : Option[ujson.Value],
    val author_flair_text : Option[String],
    val banned_at_utc : Option[ujson.Value],
    val banned_by : Option[ujson.Value],
    val brand_safe : Boolean,
    val can_gild : Boolean,
    val can_mod_post : Boolean,
    val clicked : Boolean,
    val contest_mode : Boolean,
    val created : Double,
    val created_utc : Double,
    val distinguished : Option[String],
    val domain : Domain,
    val downs : Long,
    val edited : Boolean,
    val gilded : Long,
    val hidden : Boolean,
    val hide_score : Boolean,
    val id : String,
    val is_self : Boolean,
    val is_video : Boolean,
    val likes : Option[ujson.Value],
    val link_flair_css_class : Option[ujson.Value],
    val link_flair_text : Option[ujson.Value],
    val locked : Boolean,
    val media : Option[Media],
    val media_embed : MediaEmbed,
    val mod_reports : Seq[Option[ujson.Value]],
    val name : String,
    val num_comments : Long,
    val num_reports : Option[ujson.Value],
    val over_18 : Boolean,
    val permalink : String,
    val post_hint : PostHint,
    val preview : Preview,
    val quarantine : Boolean,
    val removal_reason : Option[ujson.Value],
    val report_reasons : Option[ujson.Value],
    val saved : Boolean,
    val score : Long,
    val secure_media : Option[Media],
    val secure_media_embed : MediaEmbed,
    val selftext : String,
    val selftext_html : Option[ujson.Value],
    val spoiler : Boolean,
    val stickied : Boolean,
    val subreddit : Subreddit,
    val subreddit_id : SubredditID,
    val subreddit_name_prefixed : SubredditNamePrefixed,
    val subreddit_type : SubredditType,
    val suggested_sort : Option[ujson.Value],
    val thumbnail : String,
    val thumbnail_height : Long,
    val thumbnail_width : Long,
    val title : String,
    val ups : Long,
    val url : String,
    val user_reports : Seq[Option[ujson.Value]],
    val view_count : Option[ujson.Value],
    val visited : Boolean
) derives OptionPickler.ReadWriter

enum Domain : 
    case RedditCOM
    case IReddIt
    case IImgurCOM
    case GfycatCOM
    case ImgurCOM

given OptionPickler.ReadWriter[Domain] = OptionPickler.readwriter[String].bimap[Domain](
    {
        case Domain.RedditCOM => "reddit.com"
        case Domain.IReddIt => "i.redd.it"
        case Domain.IImgurCOM => "i.imgur.com"
        case Domain.GfycatCOM => "gfycat.com"
        case Domain.ImgurCOM => "imgur.com"
    },
    {
        case "reddit.com" => Domain.RedditCOM
        case "i.redd.it" => Domain.IReddIt
        case "i.imgur.com" => Domain.IImgurCOM
        case "gfycat.com" => Domain.GfycatCOM
        case "imgur.com" => Domain.ImgurCOM
        case other => throw new upickle.core.Abort("invalid Domain: " + other)
    }
)

case class Media (
    val `type` : Domain,
    val oembed : Oembed
) derives OptionPickler.ReadWriter

case class Oembed (
    val description : String,
    val height : Long,
    val html : String,
    val `type` : String,
    val provider_name : String,
    val provider_url : String,
    val thumbnail_height : Long,
    val thumbnail_url : String,
    val thumbnail_width : Long,
    val title : String,
    val version : String,
    val width : Long
) derives OptionPickler.ReadWriter

case class MediaEmbed (
    val content : Option[String] = None,
    val height : Option[Long] = None,
    val scrolling : Option[Boolean] = None,
    val width : Option[Long] = None
) derives OptionPickler.ReadWriter

enum PostHint : 
    case Link
    case Image
    case RichVideo

given OptionPickler.ReadWriter[PostHint] = OptionPickler.readwriter[String].bimap[PostHint](
    {
        case PostHint.Link => "link"
        case PostHint.Image => "image"
        case PostHint.RichVideo => "rich:video"
    },
    {
        case "link" => PostHint.Link
        case "image" => PostHint.Image
        case "rich:video" => PostHint.RichVideo
        case other => throw new upickle.core.Abort("invalid PostHint: " + other)
    }
)

case class Preview (
    val enabled : Boolean,
    val images : Seq[Image]
) derives OptionPickler.ReadWriter

case class Image (
    val id : String,
    val resolutions : Seq[Source],
    val source : Source,
    val variants : Variants
) derives OptionPickler.ReadWriter

case class Source (
    val height : Long,
    val url : String,
    val width : Long
) derives OptionPickler.ReadWriter

case class Variants (
    val gif : Option[GIF] = None,
    val mp4 : Option[GIF] = None
) derives OptionPickler.ReadWriter

case class GIF (
    val resolutions : Seq[Source],
    val source : Source
) derives OptionPickler.ReadWriter

enum Subreddit : 
    case Funny

given OptionPickler.ReadWriter[Subreddit] = OptionPickler.readwriter[String].bimap[Subreddit](
    {
        case Subreddit.Funny => "funny"
    },
    {
        case "funny" => Subreddit.Funny
        case other => throw new upickle.core.Abort("invalid Subreddit: " + other)
    }
)

enum SubredditID : 
    case T52Qh33

given OptionPickler.ReadWriter[SubredditID] = OptionPickler.readwriter[String].bimap[SubredditID](
    {
        case SubredditID.T52Qh33 => "t5_2qh33"
    },
    {
        case "t5_2qh33" => SubredditID.T52Qh33
        case other => throw new upickle.core.Abort("invalid SubredditID: " + other)
    }
)

enum SubredditNamePrefixed : 
    case RFunny

given OptionPickler.ReadWriter[SubredditNamePrefixed] = OptionPickler.readwriter[String].bimap[SubredditNamePrefixed](
    {
        case SubredditNamePrefixed.RFunny => "r/funny"
    },
    {
        case "r/funny" => SubredditNamePrefixed.RFunny
        case other => throw new upickle.core.Abort("invalid SubredditNamePrefixed: " + other)
    }
)

enum SubredditType : 
    case Public

given OptionPickler.ReadWriter[SubredditType] = OptionPickler.readwriter[String].bimap[SubredditType](
    {
        case SubredditType.Public => "public"
    },
    {
        case "public" => SubredditType.Public
        case other => throw new upickle.core.Abort("invalid SubredditType: " + other)
    }
)

enum Kind : 
    case T3

given OptionPickler.ReadWriter[Kind] = OptionPickler.readwriter[String].bimap[Kind](
    {
        case Kind.T3 => "t3"
    },
    {
        case "t3" => Kind.T3
        case other => throw new upickle.core.Abort("invalid Kind: " + other)
    }
)
