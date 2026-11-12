package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val number : Number
) derives Encoder.AsObject, Decoder

type Number = Double | Long
given Decoder[Number] = {
    List[Decoder[Number]](
        Decoder[Long].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Number] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}
