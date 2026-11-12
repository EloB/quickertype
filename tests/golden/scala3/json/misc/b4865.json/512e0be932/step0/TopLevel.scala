package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val `:@computed_region_cbhk_fwbd` : Option[String] = None,
    val `:@computed_region_nnqa_25f4` : Option[String] = None,
    val fall : Fall,
    val geolocation : Option[Geolocation] = None,
    val id : String,
    val mass : Option[String] = None,
    val name : String,
    val nametype : Nametype,
    val recclass : String,
    val reclat : Option[String] = None,
    val reclong : Option[String] = None,
    val year : Option[java.time.Instant] = None
) derives Encoder.AsObject, Decoder

enum Fall : 
    case Fell
    case Found

given Decoder[Fall] = Decoder.decodeString.emap {
    case "Fell" => scala.Right(Fall.Fell)
    case "Found" => scala.Right(Fall.Found)
    case other => scala.Left("invalid Fall: " + other)
}
given Encoder[Fall] = Encoder.encodeString.contramap {
    case Fall.Fell => "Fell"
    case Fall.Found => "Found"
}

case class Geolocation (
    val coordinates : Seq[Double],
    val `type` : Type
) derives Encoder.AsObject, Decoder

enum Type : 
    case Point

given Decoder[Type] = Decoder.decodeString.emap {
    case "Point" => scala.Right(Type.Point)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.Point => "Point"
}

enum Nametype : 
    case Valid

given Decoder[Nametype] = Decoder.decodeString.emap {
    case "Valid" => scala.Right(Nametype.Valid)
    case other => scala.Left("invalid Nametype: " + other)
}
given Encoder[Nametype] = Encoder.encodeString.contramap {
    case Nametype.Valid => "Valid"
}
