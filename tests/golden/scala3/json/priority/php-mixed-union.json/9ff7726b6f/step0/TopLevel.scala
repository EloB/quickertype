package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val mixed : Seq[MixedElement]
) derives Encoder.AsObject, Decoder

type MixedElement = Boolean | Long | MixedClass | String | NullValue
given Decoder[MixedElement] = {
    List[Decoder[MixedElement]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[MixedClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[MixedElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : MixedClass => Encoder.AsObject[MixedClass].apply(enc3)
    case enc4 : NullValue => Encoder.encodeNone(enc4)
}

case class MixedClass (
    val nested : String
) derives Encoder.AsObject, Decoder
