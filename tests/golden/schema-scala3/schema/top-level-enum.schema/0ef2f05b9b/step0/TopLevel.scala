package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

enum TopLevel : 
    case One
    case Three
    case Two

given Decoder[TopLevel] = Decoder.decodeString.emap {
    case "one" => scala.Right(TopLevel.One)
    case "three" => scala.Right(TopLevel.Three)
    case "two" => scala.Right(TopLevel.Two)
    case other => scala.Left("invalid TopLevel: " + other)
}
given Encoder[TopLevel] = Encoder.encodeString.contramap {
    case TopLevel.One => "one"
    case TopLevel.Three => "three"
    case TopLevel.Two => "two"
}
