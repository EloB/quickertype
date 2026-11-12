package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val cookies : Seq[Cookie]
) derives Encoder.AsObject, Decoder

case class Cookie (
    val name : String,
    val value : String
) derives Encoder.AsObject, Decoder
