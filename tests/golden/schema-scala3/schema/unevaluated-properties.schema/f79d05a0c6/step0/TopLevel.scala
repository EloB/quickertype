package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val config : Option[Config] = None
) derives Encoder.AsObject, Decoder

case class Config (
    val closed : Option[Closed] = None,
    val name : Option[String] = None,
    val settings : Option[Map[String, Seq[Item]]] = None
) derives Encoder.AsObject, Decoder

type Closed = Seq[Option[Json]] | Boolean | ClosedClass | Double | Long | String | NullValue
given Decoder[Closed] = {
    List[Decoder[Closed]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[ClosedClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Closed] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc4)
    case enc5 : ClosedClass => Encoder.AsObject[ClosedClass].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}

case class ClosedClass()  derives Encoder.AsObject, Decoder

case class Item (
    val key : String,
    val value : String
) derives Encoder.AsObject, Decoder
