package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val literal : String,
    val `#{1+1}` : Long,
    val values : Seq[Value]
) derives Encoder.AsObject, Decoder

enum Value : 
    case C0
    case C1

given Decoder[Value] = Decoder.decodeString.emap {
    case "c0\u0001\u001b\u001f" => scala.Right(Value.C0)
    case "c1\u007f\u0080\u0085\u009f" => scala.Right(Value.C1)
    case other => scala.Left("invalid Value: " + other)
}
given Encoder[Value] = Encoder.encodeString.contramap {
    case Value.C0 => "c0\u0001\u001b\u001f"
    case Value.C1 => "c1\u007f\u0080\u0085\u009f"
}
