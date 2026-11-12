package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Result (
    val age : Long,
    val name : Option[Json] = None
) derives Encoder.AsObject, Decoder
