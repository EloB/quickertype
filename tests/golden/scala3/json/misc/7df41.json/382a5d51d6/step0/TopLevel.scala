package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val pc : PC,
    val ps3 : PC,
    val ps4 : PC,
    val xbox : PC,
    val xone : PC
) derives Encoder.AsObject, Decoder

case class PC (
    val count : Long,
    val label : String,
    val peak24 : Long
) derives Encoder.AsObject, Decoder
