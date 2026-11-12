package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

/**
 * An object with a scalar default
 */
case class TopLevel (
    val id : Long
) derives Encoder.AsObject, Decoder
