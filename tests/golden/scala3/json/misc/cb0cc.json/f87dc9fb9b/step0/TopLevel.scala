package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val prizes : Seq[Prize]
) derives Encoder.AsObject, Decoder

case class Prize (
    val category : Category,
    val laureates : Seq[Laureate],
    val overallMotivation : Option[String] = None,
    val year : String
) derives Encoder.AsObject, Decoder

enum Category : 
    case Physics
    case Chemistry
    case Medicine
    case Literature
    case Peace
    case Economics

given Decoder[Category] = Decoder.decodeString.emap {
    case "physics" => scala.Right(Category.Physics)
    case "chemistry" => scala.Right(Category.Chemistry)
    case "medicine" => scala.Right(Category.Medicine)
    case "literature" => scala.Right(Category.Literature)
    case "peace" => scala.Right(Category.Peace)
    case "economics" => scala.Right(Category.Economics)
    case other => scala.Left("invalid Category: " + other)
}
given Encoder[Category] = Encoder.encodeString.contramap {
    case Category.Physics => "physics"
    case Category.Chemistry => "chemistry"
    case Category.Medicine => "medicine"
    case Category.Literature => "literature"
    case Category.Peace => "peace"
    case Category.Economics => "economics"
}

case class Laureate (
    val firstname : String,
    val id : String,
    val motivation : Option[String] = None,
    val share : String,
    val surname : String
) derives Encoder.AsObject, Decoder
