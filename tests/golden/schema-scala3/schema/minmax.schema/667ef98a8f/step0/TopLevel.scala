package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val free : Double,
    val intersection : Double,
    val max : Double,
    val min : Double,
    val minmax : Double,
    val minMaxIntersection : Double,
    val minMaxUnion : Double,
    val union : Double
) derives Encoder.AsObject, Decoder
