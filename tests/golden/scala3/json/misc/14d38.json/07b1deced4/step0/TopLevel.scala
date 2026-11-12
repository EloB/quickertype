package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val headers : Headers
) derives Encoder.AsObject, Decoder

case class Headers (
    val `Accept-Encoding` : String,
    val Connection : String,
    val Host : String,
    val `User-Agent` : String
) derives Encoder.AsObject, Decoder
