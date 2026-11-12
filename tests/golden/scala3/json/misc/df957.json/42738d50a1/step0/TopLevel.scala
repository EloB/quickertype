package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val query : Query
) derives Encoder.AsObject, Decoder

case class Query (
    val count : Long,
    val created : java.time.Instant,
    val lang : String,
    val results : Results
) derives Encoder.AsObject, Decoder

case class Results (
    val channel : Channel
) derives Encoder.AsObject, Decoder

case class Channel (
    val astronomy : Astronomy,
    val atmosphere : Atmosphere,
    val description : String,
    val image : Image,
    val item : Item,
    val language : String,
    val lastBuildDate : String,
    val link : String,
    val location : Location,
    val title : String,
    val ttl : String,
    val units : Units,
    val wind : Wind
) derives Encoder.AsObject, Decoder

case class Astronomy (
    val sunrise : String,
    val sunset : String
) derives Encoder.AsObject, Decoder

case class Atmosphere (
    val humidity : String,
    val pressure : String,
    val rising : String,
    val visibility : String
) derives Encoder.AsObject, Decoder

case class Image (
    val height : String,
    val link : String,
    val title : String,
    val url : String,
    val width : String
) derives Encoder.AsObject, Decoder

case class Item (
    val condition : Condition,
    val description : String,
    val forecast : Seq[Forecast],
    val guid : GUID,
    val lat : String,
    val link : String,
    val long : String,
    val pubDate : String,
    val title : String
) derives Encoder.AsObject, Decoder

case class Condition (
    val code : String,
    val date : String,
    val temp : String,
    val text : String
) derives Encoder.AsObject, Decoder

case class Forecast (
    val code : String,
    val date : String,
    val day : String,
    val high : String,
    val low : String,
    val text : String
) derives Encoder.AsObject, Decoder

case class GUID (
    val isPermaLink : String
) derives Encoder.AsObject, Decoder

case class Location (
    val city : String,
    val country : String,
    val region : String
) derives Encoder.AsObject, Decoder

case class Units (
    val distance : String,
    val pressure : String,
    val speed : String,
    val temperature : String
) derives Encoder.AsObject, Decoder

case class Wind (
    val chill : String,
    val direction : String,
    val speed : String
) derives Encoder.AsObject, Decoder
