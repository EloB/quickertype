package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val b : Option[String] = None,
    val kind : Kind
) derives Encoder.AsObject, Decoder

enum Kind : 
    case One
    case Two

given Decoder[Kind] = Decoder.decodeString.emap {
    case "one" => scala.Right(Kind.One)
    case "two" => scala.Right(Kind.Two)
    case other => scala.Left("invalid Kind: " + other)
}
given Encoder[Kind] = Encoder.encodeString.contramap {
    case Kind.One => "one"
    case Kind.Two => "two"
}
