package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val amount : Double,
    val frequency : Frequency,
    val description : Option[String] = None,
    val `type` : Type
) derives Encoder.AsObject, Decoder

enum Frequency : 
    case Weekly
    case Monthly
    case Annually

given Decoder[Frequency] = Decoder.decodeString.emap {
    case "Weekly" => scala.Right(Frequency.Weekly)
    case "Monthly" => scala.Right(Frequency.Monthly)
    case "Annually" => scala.Right(Frequency.Annually)
    case other => scala.Left("invalid Frequency: " + other)
}
given Encoder[Frequency] = Encoder.encodeString.contramap {
    case Frequency.Weekly => "Weekly"
    case Frequency.Monthly => "Monthly"
    case Frequency.Annually => "Annually"
}

enum Type : 
    case GrossSalaryAmount
    case Overtime

given Decoder[Type] = Decoder.decodeString.emap {
    case "GrossSalaryAmount" => scala.Right(Type.GrossSalaryAmount)
    case "Overtime" => scala.Right(Type.Overtime)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.GrossSalaryAmount => "GrossSalaryAmount"
    case Type.Overtime => "Overtime"
}
