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
    val category : Category,
    val details : Details,
    val page : Long,
    val product : Seq[ProductElement],
    val schk : Boolean,
    val `match` : String,
    val totallooseoffers : Long,
    val totalpages : Long,
    val totalresultsavailable : Long,
    val totalresultsreturned : Long
) derives OptionPickler.ReadWriter

case class Category (
    val concatenatecategoryname : Boolean,
    val hasoffer : Boolean,
    val id : Long,
    val isfinal : Boolean,
    val links : Seq[LinkElement],
    val name : String,
    val parentcategoryid : Long,
    val thumbnail : CategoryThumbnail
) derives OptionPickler.ReadWriter

case class LinkElement (
    val link : LinkLink
) derives OptionPickler.ReadWriter

case class LinkLink (
    val `type` : String,
    val url : String
) derives OptionPickler.ReadWriter

case class CategoryThumbnail (
    val url : String
) derives OptionPickler.ReadWriter

case class Details (
    val applicationid : String,
    val applicationversion : String,
    val code : Long,
    val date : Date,
    val elapsedtime : Long,
    val message : String,
    val status : String
) derives OptionPickler.ReadWriter

case class Date (
    val day : Long,
    val eonandyear : Eonandyear,
    val hour : Long,
    val millisecond : Long,
    val minute : Long,
    val month : Long,
    val second : Long,
    val timezone : Long,
    val valid : Boolean,
    val xmlschematype : Xmlschematype,
    val year : Long
) derives OptionPickler.ReadWriter

case class Eonandyear (
    val lowestsetbit : Long
) derives OptionPickler.ReadWriter

case class Xmlschematype (
    val localpart : String,
    val namespaceuri : String,
    val prefix : String
) derives OptionPickler.ReadWriter

case class ProductElement (
    val product : ProductProduct
) derives OptionPickler.ReadWriter

case class ProductProduct (
    val categoryid : Long,
    val currency : Currency,
    val eco : Boolean,
    val fulldescription : Boolean,
    val hasmetasearch : Boolean,
    val id : Long,
    val links : Seq[LinkElement],
    val numoffers : Long,
    val pricemax : String,
    val pricemin : String,
    val productname : String,
    val quantity : Long,
    val rating : Rating,
    val specification : Specification,
    val thumbnail : FormatsClass,
    val totalsellers : Long
) derives OptionPickler.ReadWriter

case class Currency (
    val abbreviation : String
) derives OptionPickler.ReadWriter

case class Rating (
    val useraveragerating : Useraveragerating
) derives OptionPickler.ReadWriter

case class Useraveragerating (
    val links : Seq[LinkElement],
    val numcomments : Long,
    val rating : String
) derives OptionPickler.ReadWriter

case class Specification (
    val links : Seq[LinkElement]
) derives OptionPickler.ReadWriter

case class Format (
    val formats : FormatsClass
) derives OptionPickler.ReadWriter

case class FormatsClass (
    val formats : Option[Seq[Format]] = None,
    val height : Long,
    val url : String,
    val width : Long
) derives OptionPickler.ReadWriter
