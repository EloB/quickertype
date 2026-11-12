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
    val basePath : String,
    val definitions : Definitions,
    val host : String,
    val info : Info,
    val paths : Paths,
    val produces : Seq[String],
    val schemes : Seq[String],
    val swagger : String
) derives OptionPickler.ReadWriter

case class Definitions (
    val `List` : ListClass
) derives OptionPickler.ReadWriter

case class ListClass (
    val properties : Map[String, Property]
) derives OptionPickler.ReadWriter

case class Property (
    val description : String,
    val `type` : Type
) derives OptionPickler.ReadWriter

enum Type : 
    case TypeString

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.TypeString => "string"
    },
    {
        case "string" => Type.TypeString
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)

case class Info (
    val description : String,
    val title : String,
    val version : String
) derives OptionPickler.ReadWriter

case class Paths (
    val `/consolidated_screening_list/search` : ConsolidatedScreeningListSearch
) derives OptionPickler.ReadWriter

case class ConsolidatedScreeningListSearch (
    val get : Get
) derives OptionPickler.ReadWriter

case class Get (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : Responses,
    val summary : String,
    val tags : Seq[String]
) derives OptionPickler.ReadWriter

case class Parameter (
    val description : String,
    val format : Type,
    val in : In,
    val name : String,
    val `type` : Type,
    val required : Boolean
) derives OptionPickler.ReadWriter

enum In : 
    case Query

given OptionPickler.ReadWriter[In] = OptionPickler.readwriter[String].bimap[In](
    {
        case In.Query => "query"
    },
    {
        case "query" => In.Query
        case other => throw new upickle.core.Abort("invalid In: " + other)
    }
)

case class Responses (
    val `200` : The200
) derives OptionPickler.ReadWriter

case class The200 (
    val description : String,
    val schema : Schema
) derives OptionPickler.ReadWriter

case class Schema (
    val items : Items,
    val `type` : String
) derives OptionPickler.ReadWriter

case class Items (
    val `$ref` : String
) derives OptionPickler.ReadWriter
