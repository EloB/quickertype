package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val intersection : Option[Intersection] = None
) derives Encoder.AsObject, Decoder

case class Intersection (
    val foo : Double,
    val bar : Option[String] = None
) derives Encoder.AsObject, Decoder
