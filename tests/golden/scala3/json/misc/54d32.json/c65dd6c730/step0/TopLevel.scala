package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val count : Long,
    val facets : Facets,
    val limit : Long,
    val next : String,
    val offset : Long,
    val previous : Boolean,
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Facets()  derives Encoder.AsObject, Decoder

case class Result (
    val created_at : java.time.Instant,
    val id : String,
    val person_id : String,
    val representative_id : String,
    val status : Status,
    val updated_at : java.time.Instant
) derives Encoder.AsObject, Decoder

enum Status : 
    case Inactive
    case Active

given Decoder[Status] = Decoder.decodeString.emap {
    case "inactive" => scala.Right(Status.Inactive)
    case "active" => scala.Right(Status.Active)
    case other => scala.Left("invalid Status: " + other)
}
given Encoder[Status] = Encoder.encodeString.contramap {
    case Status.Inactive => "inactive"
    case Status.Active => "active"
}
