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
    val Report : Report
) derives Encoder.AsObject, Decoder

case class Report (
    val properties : Properties
) derives Encoder.AsObject, Decoder

case class Properties (
    val click_url : ClickURL,
    val country : ClickURL,
    val description : ClickURL,
    val expiration_date : ClickURL,
    val id : ClickURL,
    val industry : ClickURL,
    val report_type : ClickURL,
    val source_industry : ClickURL,
    val title : ClickURL,
    val url : ClickURL
) derives Encoder.AsObject, Decoder

case class ClickURL (
    val `type` : Type,
    val description : String
) derives Encoder.AsObject, Decoder

enum Type : 
    case TypeString

given Decoder[Type] = Decoder.decodeString.emap {
    case "string" => scala.Right(Type.TypeString)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.TypeString => "string"
}

case class Info (
    val description : String,
    val title : String,
    val version : String
) derives Encoder.AsObject, Decoder

case class Paths (
    val `/market_research_library/search` : MarketResearchLibrarySearch
) derives Encoder.AsObject, Decoder

case class MarketResearchLibrarySearch (
    val get : Get
) derives Encoder.AsObject, Decoder

case class Get (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : Responses,
    val summary : String,
    val tags : Seq[String]
) derives Encoder.AsObject, Decoder

case class Parameter (
    val description : String,
    val format : Type,
    val in : String,
    val name : String,
    val `type` : Type,
    val required : Boolean
) derives Encoder.AsObject, Decoder

case class Responses (
    val `200` : The200
) derives Encoder.AsObject, Decoder

case class The200 (
    val description : String,
    val schema : Schema
) derives Encoder.AsObject, Decoder

case class Schema (
    val items : Items,
    val `type` : String
) derives Encoder.AsObject, Decoder

case class Items (
    val `$ref` : String
) derives Encoder.AsObject, Decoder
