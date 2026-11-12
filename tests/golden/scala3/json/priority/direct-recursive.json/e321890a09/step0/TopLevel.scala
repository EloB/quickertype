package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val also : Option[TopLevel] = None,
    val bar : Boolean,
    val foo : Long,
    val moo : Double,
    val quux : String
) derives Encoder.AsObject, Decoder
