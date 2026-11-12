package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val amount : Long,
    val enabled : Boolean,
    val kind : Kind,
    val ratio : Double,
    val version : Double
) derives Encoder.AsObject, Decoder

enum Kind : 
    case Widget

given Decoder[Kind] = Decoder.decodeString.emap {
    case "widget" => scala.Right(Kind.Widget)
    case other => scala.Left("invalid Kind: " + other)
}
given Encoder[Kind] = Encoder.encodeString.contramap {
    case Kind.Widget => "widget"
}
