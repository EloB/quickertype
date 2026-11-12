package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val `optional-date` : Option[String] = None,
    val `optional-date-time` : Option[java.time.Instant] = None,
    val `optional-time` : Option[String] = None,
    val `required-date` : String,
    val `required-date-time` : java.time.Instant,
    val `required-time` : String
) derives Encoder.AsObject, Decoder
