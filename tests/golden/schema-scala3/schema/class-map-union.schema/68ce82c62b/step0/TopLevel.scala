package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val union : Option[Map[String, UnionValue]] = None
) derives Encoder.AsObject, Decoder

type UnionValue = Boolean | Double | String | UnionClass
given Decoder[UnionValue] = {
    List[Decoder[UnionValue]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[UnionClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionValue] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Double => Encoder.encodeDouble(enc2)
    case enc3 : UnionClass => Encoder.AsObject[UnionClass].apply(enc3)
}

case class UnionClass (
    val quux : Option[Long] = None
) derives Encoder.AsObject, Decoder
