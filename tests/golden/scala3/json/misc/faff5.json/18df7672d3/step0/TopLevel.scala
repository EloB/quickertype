package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val response : Response
) derives Encoder.AsObject, Decoder

case class Response (
    val player_count : Long,
    val result : Long
) derives Encoder.AsObject, Decoder
