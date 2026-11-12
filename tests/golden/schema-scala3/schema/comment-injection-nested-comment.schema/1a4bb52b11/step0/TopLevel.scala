package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

/**
 * Nested block comment openers:
 * {-
 * / *
 * This text must remain inside the generated documentation comment.
 */
case class TopLevel (
    /**
     * Nested property block comment openers:
     * {-
     * / *
     * This text must remain inside the generated property documentation comment.
     */
    val value : String
) derives Encoder.AsObject, Decoder
