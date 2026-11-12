package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val date : Long,
    val title : String,
    val validity : Boolean
) derives Encoder.AsObject, Decoder
