package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    /**
     * Nested enum block comment openers:
     * {-
     * / *
     * This text must remain inside the generated enum documentation comment.
     */
    val kind : Kind
) derives Encoder.AsObject, Decoder

/**
 * Nested enum block comment openers:
 * {-
 * / *
 * This text must remain inside the generated enum documentation comment.
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
