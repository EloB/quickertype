package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val health : Health
) derives Encoder.AsObject, Decoder

enum Health : 
    case Ok
    case Error

given Decoder[Health] = Decoder.decodeString.emap {
    case "ok" => scala.Right(Health.Ok)
    case "error" => scala.Right(Health.Error)
    case other => scala.Left("invalid Health: " + other)
}
given Encoder[Health] = Encoder.encodeString.contramap {
    case Health.Ok => "ok"
    case Health.Error => "error"
}
