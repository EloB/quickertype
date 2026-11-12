package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val booleanValue : Boolean,
    val doubleValue : Double,
    val intValue : Long,
    val stringValue : String,
    val uuidValue : java.util.UUID,
    val uuidValues : Seq[java.util.UUID]
) derives Encoder.AsObject, Decoder
