package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val basePath : String,
    val definitions : Definitions,
    val host : String,
    val info : Info,
    val paths : Paths,
    val produces : Seq[String],
    val schemes : Seq[String],
    val swagger : String
) derives Encoder.AsObject, Decoder

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
) derives Encoder.AsObject, Decoder

case class Article (
    val properties : Map[String, Property]
) derives Encoder.AsObject, Decoder

case class Property (
    val description : String,
    val `type` : FormatEnum
) derives Encoder.AsObject, Decoder

enum FormatEnum : 
    case TypeString

given Decoder[FormatEnum] = Decoder.decodeString.emap {
    case "string" => scala.Right(FormatEnum.TypeString)
    case other => scala.Left("invalid FormatEnum: " + other)
}
given Encoder[FormatEnum] = Encoder.encodeString.contramap {
    case FormatEnum.TypeString => "string"
}

case class DeMinimis (
    val properties : DeMinimisProperties
) derives Encoder.AsObject, Decoder

case class DeMinimisProperties (
    val countries : Property,
    val country : Property,
    val de_minimis_currency : Property,
    val de_minimis_value : Property,
    val notes : Property,
    val vat_amount : Property,
    val vat_currency : Property
) derives Encoder.AsObject, Decoder

case class FAQ (
    val properties : FAQProperties
) derives Encoder.AsObject, Decoder

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
) derives Encoder.AsObject, Decoder

case class Report (
    val properties : ReportProperties
) derives Encoder.AsObject, Decoder

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
) derives Encoder.AsObject, Decoder

case class Taxonomy (
    val properties : TaxonomyProperties
) derives Encoder.AsObject, Decoder

case class TaxonomyProperties (
    val annotations : Property,
    val datatype_properties : Property,
    val id : Property,
    val label : Property,
    val `type` : Property,
    val sub_class_of : Property
) derives Encoder.AsObject, Decoder

case class Info (
    val description : String,
    val title : String,
    val version : String
) derives Encoder.AsObject, Decoder

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
) derives Encoder.AsObject, Decoder

case class BusinessServiceProvidersSearchClass (
    val get : BusinessServiceProvidersSearchGet
) derives Encoder.AsObject, Decoder

case class BusinessServiceProvidersSearchGet (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : PurpleResponses,
    val summary : String,
    val tags : Seq[String]
) derives Encoder.AsObject, Decoder

case class Parameter (
    val description : String,
    val format : FormatEnum,
    val in : In,
    val name : String,
    val `type` : FormatEnum,
    val required : Boolean
) derives Encoder.AsObject, Decoder

enum In : 
    case Query

given Decoder[In] = Decoder.decodeString.emap {
    case "query" => scala.Right(In.Query)
    case other => scala.Left("invalid In: " + other)
}
given Encoder[In] = Encoder.encodeString.contramap {
    case In.Query => "query"
}

case class PurpleResponses (
    val `200` : Purple200
) derives Encoder.AsObject, Decoder

case class Purple200 (
    val description : String,
    val schema : ItemsClass
) derives Encoder.AsObject, Decoder

case class ItemsClass (
    val `$ref` : String
) derives Encoder.AsObject, Decoder

case class ConsolidatedScreeningListSearchClass (
    val get : ConsolidatedScreeningListSearchGet
) derives Encoder.AsObject, Decoder

case class ConsolidatedScreeningListSearchGet (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : FluffyResponses,
    val summary : String,
    val tags : Seq[String]
) derives Encoder.AsObject, Decoder

case class FluffyResponses (
    val `200` : Fluffy200
) derives Encoder.AsObject, Decoder

case class Fluffy200 (
    val description : String,
    val schema : PurpleSchema
) derives Encoder.AsObject, Decoder

case class PurpleSchema (
    val items : ItemsClass,
    val `type` : SchemaType
) derives Encoder.AsObject, Decoder

enum SchemaType : 
    case TypeArray

given Decoder[SchemaType] = Decoder.decodeString.emap {
    case "array" => scala.Right(SchemaType.TypeArray)
    case other => scala.Left("invalid SchemaType: " + other)
}
given Encoder[SchemaType] = Encoder.encodeString.contramap {
    case SchemaType.TypeArray => "array"
}
