package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val foo : FooUnion
) derives Encoder.AsObject, Decoder

type FooUnion = Boolean | Double | FooClass | Seq[Long] | Long | String | NullValue
given Decoder[FooUnion] = {
    List[Decoder[FooUnion]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
        Decoder[FooClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[FooUnion] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc4)
    case enc5 : FooClass => Encoder.AsObject[FooClass].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}

case class FooClass (
    val bar : Long
) derives Encoder.AsObject, Decoder
