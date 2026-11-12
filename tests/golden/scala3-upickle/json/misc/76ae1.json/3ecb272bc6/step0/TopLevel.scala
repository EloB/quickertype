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
    val Article : Article,
    val Center : Article,
    val DeMinimis : DeMinimis,
    val Event : Article,
    val FAQ : FAQ,
    val Lead : Article,
    val `List` : Article,
    val MarketIntelligence : Article,
    val Office : Article,
    val Provider : Article,
    val Rate : Article,
    val Report : Report,
    val Taxonomy : Taxonomy
) derives OptionPickler.ReadWriter

case class Article (
    val properties : Map[String, Property]
) derives OptionPickler.ReadWriter

case class Property (
    val description : String,
    val `type` : FormatEnum
) derives OptionPickler.ReadWriter

enum FormatEnum : 
    case TypeString

given OptionPickler.ReadWriter[FormatEnum] = OptionPickler.readwriter[String].bimap[FormatEnum](
    {
        case FormatEnum.TypeString => "string"
    },
    {
        case "string" => FormatEnum.TypeString
        case other => throw new upickle.core.Abort("invalid FormatEnum: " + other)
    }
)

case class DeMinimis (
    val properties : DeMinimisProperties
) derives OptionPickler.ReadWriter

case class DeMinimisProperties (
    val countries : Property,
    val country : Property,
    val de_minimis_currency : Property,
    val de_minimis_value : Property,
    val notes : Property,
    val vat_amount : Property,
    val vat_currency : Property
) derives OptionPickler.ReadWriter

case class FAQ (
    val properties : FAQProperties
) derives OptionPickler.ReadWriter

case class FAQProperties (
    val answer : Property,
    val countries : Property,
    val first_published_date : Property,
    val id : Property,
    val industries : Property,
    val last_published_date : Property,
    val question : Property,
    val topics : Property,
    val trade_regions : Property,
    val url : Property,
    val world_regions : Property
) derives OptionPickler.ReadWriter

case class Report (
    val properties : ReportProperties
) derives OptionPickler.ReadWriter

case class ReportProperties (
    val countries : Property,
    val description : Property,
    val expiration_date : Property,
    val id : Property,
    val industries : Property,
    val ita_industries : Property,
    val report_type : Property,
    val title : Property,
    val url : Property
) derives OptionPickler.ReadWriter

case class Taxonomy (
    val properties : TaxonomyProperties
) derives OptionPickler.ReadWriter

case class TaxonomyProperties (
    val annotations : Property,
    val datatype_properties : Property,
    val id : Property,
    val label : Property,
    val `type` : Property,
    val sub_class_of : Property
) derives OptionPickler.ReadWriter

case class Info (
    val description : String,
    val title : String,
    val version : String
) derives OptionPickler.ReadWriter

case class Paths (
    val `/business_service_providers/search` : BusinessServiceProvidersSearchClass,
    val `/consolidated_screening_list/search` : ConsolidatedScreeningListSearchClass,
    val `/de_minimis/search` : ConsolidatedScreeningListSearchClass,
    val `/ita_faqs/search` : ConsolidatedScreeningListSearchClass,
    val `/ita_office_locations/search` : ConsolidatedScreeningListSearchClass,
    val `/ita_taxonomies/search` : BusinessServiceProvidersSearchClass,
    val `/ita_zipcode_to_post/search` : BusinessServiceProvidersSearchClass,
    val `/market_intelligence/search` : ConsolidatedScreeningListSearchClass,
    val `/market_research_library/search` : ConsolidatedScreeningListSearchClass,
    val `/tariff_rates/search` : ConsolidatedScreeningListSearchClass,
    val `/trade_articles/search` : ConsolidatedScreeningListSearchClass,
    val `/trade_events/search` : ConsolidatedScreeningListSearchClass,
    val `/trade_leads/search` : ConsolidatedScreeningListSearchClass
) derives OptionPickler.ReadWriter

case class BusinessServiceProvidersSearchClass (
    val get : BusinessServiceProvidersSearchGet
) derives OptionPickler.ReadWriter

case class BusinessServiceProvidersSearchGet (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : PurpleResponses,
    val summary : String,
    val tags : Seq[String]
) derives OptionPickler.ReadWriter

case class Parameter (
    val description : String,
    val format : FormatEnum,
    val in : In,
    val name : String,
    val `type` : FormatEnum,
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

case class PurpleResponses (
    val `200` : Purple200
) derives OptionPickler.ReadWriter

case class Purple200 (
    val description : String,
    val schema : ItemsClass
) derives OptionPickler.ReadWriter

case class ItemsClass (
    val `$ref` : String
) derives OptionPickler.ReadWriter

case class ConsolidatedScreeningListSearchClass (
    val get : ConsolidatedScreeningListSearchGet
) derives OptionPickler.ReadWriter

case class ConsolidatedScreeningListSearchGet (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : FluffyResponses,
    val summary : String,
    val tags : Seq[String]
) derives OptionPickler.ReadWriter

case class FluffyResponses (
    val `200` : Fluffy200
) derives OptionPickler.ReadWriter

case class Fluffy200 (
    val description : String,
    val schema : PurpleSchema
) derives OptionPickler.ReadWriter

case class PurpleSchema (
    val items : ItemsClass,
    val `type` : SchemaType
) derives OptionPickler.ReadWriter

enum SchemaType : 
    case TypeArray

given OptionPickler.ReadWriter[SchemaType] = OptionPickler.readwriter[String].bimap[SchemaType](
    {
        case SchemaType.TypeArray => "array"
    },
    {
        case "array" => SchemaType.TypeArray
        case other => throw new upickle.core.Abort("invalid SchemaType: " + other)
    }
)
