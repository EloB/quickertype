package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val pairs : Map[String, Pair],
    val server_time : Long
) derives Encoder.AsObject, Decoder

case class Pair (
    val decimal_places : Long,
    val fee : Double,
    val hidden : Long,
    val max_amount : Long,
    val max_price : Long,
    val min_amount : Double,
    val min_price : Double,
    val min_total : Double
) derives Encoder.AsObject, Decoder
