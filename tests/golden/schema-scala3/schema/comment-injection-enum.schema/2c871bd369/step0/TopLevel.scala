package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    /**
     * Comment delimiters:
     * * /
     * {-
     * -}
     * """
     * }
     * }
     */
    val kind : Kind
) derives Encoder.AsObject, Decoder

/**
 * Comment delimiters:
 * * /
 * {-
 * -}
 * """
 * }
 * }
 */

enum Kind : 
    case Ok

given Decoder[Kind] = Decoder.decodeString.emap {
    case "ok" => scala.Right(Kind.Ok)
    case other => scala.Left("invalid Kind: " + other)
}
given Encoder[Kind] = Encoder.encodeString.contramap {
    case Kind.Ok => "ok"
}
