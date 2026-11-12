package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val list : UnionList
) derives Encoder.AsObject, Decoder

case class UnionListClass (
    val next : UnionList
) derives Encoder.AsObject, Decoder

type UnionList = Double | UnionListClass
given Decoder[UnionList] = {
    List[Decoder[UnionList]](
        Decoder[Double].widen,
        Decoder[UnionListClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionList] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : UnionListClass => Encoder.AsObject[UnionListClass].apply(enc1)
}
