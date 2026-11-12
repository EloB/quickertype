package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val iss_position : IssPosition,
    val message : String,
    val timestamp : Long
) derives Encoder.AsObject, Decoder

case class IssPosition (
    val latitude : String,
    val longitude : String
) derives Encoder.AsObject, Decoder
