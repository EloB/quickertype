package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

/**
 * An integer or non-integer number
 */
type TopLevel = Double | Long
given Decoder[TopLevel] = {
    List[Decoder[TopLevel]](
        Decoder[Long].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[TopLevel] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}
