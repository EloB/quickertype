package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val value : Value
) derives Encoder.AsObject, Decoder

type Value = Double | Long | String
given Decoder[Value] = {
    List[Decoder[Value]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Value] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Double => Encoder.encodeDouble(enc2)
}
