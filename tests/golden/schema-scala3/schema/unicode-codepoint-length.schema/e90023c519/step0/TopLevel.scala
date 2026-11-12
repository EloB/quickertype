package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val exact : String,
    val maximum : String,
    val minimum : String
) derives Encoder.AsObject, Decoder
