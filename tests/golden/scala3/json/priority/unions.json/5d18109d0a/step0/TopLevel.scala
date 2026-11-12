package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val x : Seq[X],
    val y : Seq[Option[Long]],
    val z : Seq[ZElement]
) derives Encoder.AsObject, Decoder

type X = Long | String | NullValue
given Decoder[X] = {
    List[Decoder[X]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[X] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type ZElement = Seq[Long] | Long | ZClass
given Decoder[ZElement] = {
    List[Decoder[ZElement]](
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
        Decoder[ZClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[ZElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : ZClass => Encoder.AsObject[ZClass].apply(enc2)
}

case class ZClass (
    val a : Boolean
) derives Encoder.AsObject, Decoder
