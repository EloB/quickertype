package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val empty : Empty,
    val foo : String,
    val bar : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Empty()  derives Encoder.AsObject, Decoder
