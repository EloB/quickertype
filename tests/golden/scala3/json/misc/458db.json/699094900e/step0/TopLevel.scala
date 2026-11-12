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
    val attachments : Seq[Option[Json]],
    val body : String,
    val changed : String,
    val component : Seq[Component],
    val created : String,
    val date : String,
    val image : Seq[Option[Json]],
    val teaser : Seq[Option[Json]],
    val title : String,
    val topic : Seq[Option[Json]],
    val url : String,
    val uuid : java.util.UUID,
    val vuuid : java.util.UUID
) derives Encoder.AsObject, Decoder

case class Component (
    val name : Name,
    val uuid : java.util.UUID
) derives Encoder.AsObject, Decoder

enum Name : 
    case OfficeOnViolenceAgainstWomen

given Decoder[Name] = Decoder.decodeString.emap {
    case "Office on Violence Against Women" => scala.Right(Name.OfficeOnViolenceAgainstWomen)
    case other => scala.Left("invalid Name: " + other)
}
given Encoder[Name] = Encoder.encodeString.contramap {
    case Name.OfficeOnViolenceAgainstWomen => "Office on Violence Against Women"
}
