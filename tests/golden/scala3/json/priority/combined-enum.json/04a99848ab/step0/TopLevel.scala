package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val bar : Seq[Bar],
    val foo : Seq[Bar]
) derives Encoder.AsObject, Decoder

case class Bar (
    val x : X
) derives Encoder.AsObject, Decoder

enum X : 
    case Three
    case One
    case Two

given Decoder[X] = Decoder.decodeString.emap {
    case "three" => scala.Right(X.Three)
    case "one" => scala.Right(X.One)
    case "two" => scala.Right(X.Two)
    case other => scala.Left("invalid X: " + other)
}
given Encoder[X] = Encoder.encodeString.contramap {
    case X.Three => "three"
    case X.One => "one"
    case X.Two => "two"
}
