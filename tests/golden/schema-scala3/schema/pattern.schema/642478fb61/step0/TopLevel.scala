package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val pattern1 : String,
    val pattern2 : String,
    val RegExp : Option[RegExp] = None,
    val union : String
) derives Encoder.AsObject, Decoder

case class RegExp (
    val pattern3 : String
) derives Encoder.AsObject, Decoder
