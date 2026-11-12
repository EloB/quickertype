package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val age : Long,
    val country : Country,
    val females : Long,
    val males : Long,
    val total : Long,
    val year : Long
) derives Encoder.AsObject, Decoder

enum Country : 
    case UnitedStates

given Decoder[Country] = Decoder.decodeString.emap {
    case "United States" => scala.Right(Country.UnitedStates)
    case other => scala.Left("invalid Country: " + other)
}
given Encoder[Country] = Encoder.encodeString.contramap {
    case Country.UnitedStates => "United States"
}
