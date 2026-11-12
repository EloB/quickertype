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
    val entity : String,
    val first_name : String,
    val id : String,
    val last_name : String,
    val name : String,
    val position : Option[String] = None,
    val status : Status,
    val title : Option[Title] = None,
    val updated_at : java.time.Instant,
    val uri : String
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

enum Title : 
    case Mr
    case MS

given Decoder[Title] = Decoder.decodeString.emap {
    case "Mr" => scala.Right(Title.Mr)
    case "Ms" => scala.Right(Title.MS)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.Mr => "Mr"
    case Title.MS => "Ms"
}
