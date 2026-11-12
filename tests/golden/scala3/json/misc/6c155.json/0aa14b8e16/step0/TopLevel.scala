package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val metadata : Metadata,
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Metadata (
    val executionTime : Double,
    val responseInfo : ResponseInfo,
    val resultset : Resultset
) derives Encoder.AsObject, Decoder

case class ResponseInfo (
    val developerMessage : String,
    val status : Long
) derives Encoder.AsObject, Decoder

case class Resultset (
    val count : Long,
    val page : Long,
    val pagesize : Long
) derives Encoder.AsObject, Decoder

case class Result (
    val attachment : Seq[Option[Json]],
    val body : String,
    val changed : String,
    val component : Seq[Component],
    val created : String,
    val date : String,
    val image : Seq[Option[Json]],
    val location : Location,
    val teaser : Option[Json] = None,
    val title : String,
    val topic : Seq[Option[Json]],
    val url : String,
    val uuid : java.util.UUID,
    val vuuid : java.util.UUID
) derives Encoder.AsObject, Decoder

case class Component (
    val name : String,
    val uuid : java.util.UUID
) derives Encoder.AsObject, Decoder

case class Location (
    val administrative_area : String,
    val country : String,
    val fax_number : String,
    val locality : String,
    val mobile_number : String,
    val phone_number : String,
    val phone_number_extension : String,
    val postal_code : String,
    val sub_premise : Option[Json] = None,
    val thoroughfare : String
) derives Encoder.AsObject, Decoder
