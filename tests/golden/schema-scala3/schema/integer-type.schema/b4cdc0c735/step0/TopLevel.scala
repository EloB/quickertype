package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val above_i32_max : Long,
    val below_i32_min : Long,
    val i32_range : Long,
    val large_bounds : Long,
    val only_maximum : Long,
    val only_minimum : Long,
    val small_negative : Long,
    val small_positive : Long,
    val unbounded : Long
) derives Encoder.AsObject, Decoder
