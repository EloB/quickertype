package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val maxOnly : Seq[Long],
    val minAndMax : Seq[Double],
    val minOnly : Seq[String],
    val plain : Seq[String],
    val unionItems : Seq[UnionItem]
) derives Encoder.AsObject, Decoder

type UnionItem = Long | String
given Decoder[UnionItem] = {
    List[Decoder[UnionItem]](
        Decoder[String].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionItem] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}
