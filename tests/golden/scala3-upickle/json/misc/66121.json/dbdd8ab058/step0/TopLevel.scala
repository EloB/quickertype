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


type TopLevel = List[TopLevelElement]

case class TopLevelElement (
    val id : String,
    val identifiers : Seq[Identifier],
    val keywords : Seq[Keyword],
    val links : Seq[Link],
    val name : String,
    val other_names : Seq[Option[ujson.Value]],
    val superseded_by : Option[String],
    val text : Seq[Text]
) derives OptionPickler.ReadWriter

case class Identifier (
    val identifier : String,
    val scheme : Scheme
) derives OptionPickler.ReadWriter

enum Scheme : 
    case Spdx
    case Trove
    case Dep5

given OptionPickler.ReadWriter[Scheme] = OptionPickler.readwriter[String].bimap[Scheme](
    {
        case Scheme.Spdx => "SPDX"
        case Scheme.Trove => "Trove"
        case Scheme.Dep5 => "DEP5"
    },
    {
        case "SPDX" => Scheme.Spdx
        case "Trove" => Scheme.Trove
        case "DEP5" => Scheme.Dep5
        case other => throw new upickle.core.Abort("invalid Scheme: " + other)
    }
)

enum Keyword : 
    case OSIApproved
    case Discouraged
    case Redundant

given OptionPickler.ReadWriter[Keyword] = OptionPickler.readwriter[String].bimap[Keyword](
    {
        case Keyword.OSIApproved => "osi-approved"
        case Keyword.Discouraged => "discouraged"
        case Keyword.Redundant => "redundant"
    },
    {
        case "osi-approved" => Keyword.OSIApproved
        case "discouraged" => Keyword.Discouraged
        case "redundant" => Keyword.Redundant
        case other => throw new upickle.core.Abort("invalid Keyword: " + other)
    }
)

case class Link (
    val note : Note,
    val url : String
) derives OptionPickler.ReadWriter

enum Note : 
    case OSIPage

given OptionPickler.ReadWriter[Note] = OptionPickler.readwriter[String].bimap[Note](
    {
        case Note.OSIPage => "OSI Page"
    },
    {
        case "OSI Page" => Note.OSIPage
        case other => throw new upickle.core.Abort("invalid Note: " + other)
    }
)

case class Text (
    val media_type : MediaType,
    val title : Title,
    val url : String
) derives OptionPickler.ReadWriter

enum MediaType : 
    case TextHTML

given OptionPickler.ReadWriter[MediaType] = OptionPickler.readwriter[String].bimap[MediaType](
    {
        case MediaType.TextHTML => "text/html"
    },
    {
        case "text/html" => MediaType.TextHTML
        case other => throw new upickle.core.Abort("invalid MediaType: " + other)
    }
)

enum Title : 
    case HTML

given OptionPickler.ReadWriter[Title] = OptionPickler.readwriter[String].bimap[Title](
    {
        case Title.HTML => "HTML"
    },
    {
        case "HTML" => Title.HTML
        case other => throw new upickle.core.Abort("invalid Title: " + other)
    }
)
