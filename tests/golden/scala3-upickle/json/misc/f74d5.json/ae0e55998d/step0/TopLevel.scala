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
    val data : Seq[Seq[Datum]],
    val meta : Meta
) derives OptionPickler.ReadWriter

type Datum = Long | String
given unionReaderDatum: OptionPickler.Reader[Datum] = JsonExt.badMerge[Datum](
    JsonExt.strictString,
    JsonExt.strictLong,
    )

given unionWriterDatum: OptionPickler.Writer[Datum] = OptionPickler.writer[ujson.Value].comap[Datum]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

case class Meta (
    val view : View
) derives OptionPickler.ReadWriter

case class View (
    val averageRating : Long,
    val category : String,
    val columns : Seq[Column],
    val createdAt : Long,
    val displayType : String,
    val downloadCount : Long,
    val flags : Seq[String],
    val grants : Seq[Grant],
    val hideFromCatalog : Boolean,
    val hideFromDataJson : Boolean,
    val id : String,
    val indexUpdatedAt : Long,
    val license : License,
    val licenseId : String,
    val locale : String,
    val metadata : Metadata,
    val name : String,
    val newBackend : Boolean,
    val numberOfComments : Long,
    val oid : Long,
    val owner : Owner,
    val provenance : String,
    val publicationAppendEnabled : Boolean,
    val publicationDate : Long,
    val publicationGroup : Long,
    val publicationStage : String,
    val query : Query,
    val rights : Seq[String],
    val rowClass : String,
    val rowsUpdatedAt : Long,
    val rowsUpdatedBy : String,
    val tableAuthor : Owner,
    val tableId : Long,
    val totalTimesRated : Long,
    val viewCount : Long,
    val viewLastModified : Long,
    val viewType : String
) derives OptionPickler.ReadWriter

case class Column (
    val cachedContents : Option[CachedContents] = None,
    val dataTypeName : TypeName,
    val fieldName : String,
    val flags : Option[Seq[String]] = None,
    val format : Query,
    val id : Long,
    val name : String,
    val position : Long,
    val renderTypeName : TypeName,
    val tableColumnId : Option[Long] = None,
    val width : Option[Long] = None
) derives OptionPickler.ReadWriter

case class CachedContents (
    val average : Option[String] = None,
    val `null` : Long,
    val largest : String,
    val non_null : Long,
    val smallest : String,
    val sum : Option[String] = None,
    val top : Seq[Top]
) derives OptionPickler.ReadWriter

case class Top (
    val count : Long,
    val item : String
) derives OptionPickler.ReadWriter

enum TypeName : 
    case MetaData
    case Number
    case Text

given OptionPickler.ReadWriter[TypeName] = OptionPickler.readwriter[String].bimap[TypeName](
    {
        case TypeName.MetaData => "meta_data"
        case TypeName.Number => "number"
        case TypeName.Text => "text"
    },
    {
        case "meta_data" => TypeName.MetaData
        case "number" => TypeName.Number
        case "text" => TypeName.Text
        case other => throw new upickle.core.Abort("invalid TypeName: " + other)
    }
)

case class Query()
 derives OptionPickler.ReadWriter
case class Grant (
    val flags : Seq[String],
    val `type` : String,
    val inherited : Boolean
) derives OptionPickler.ReadWriter

case class License (
    val name : String
) derives OptionPickler.ReadWriter

case class Metadata (
    val availableDisplayTypes : Seq[String],
    val rdfClass : String,
    val rdfSubject : String,
    val renderTypeConfig : RenderTypeConfig,
    val rowIdentifier : String
) derives OptionPickler.ReadWriter

case class RenderTypeConfig (
    val visible : Visible
) derives OptionPickler.ReadWriter

case class Visible (
    val table : Boolean
) derives OptionPickler.ReadWriter

case class Owner (
    val displayName : String,
    val id : String,
    val screenName : String
) derives OptionPickler.ReadWriter
