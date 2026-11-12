package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val constructor : Option[UnionConstructor] = None
) derives Encoder.AsObject, Decoder

type UnionConstructor = Constructor | Double
given Decoder[UnionConstructor] = {
    List[Decoder[UnionConstructor]](
        Decoder[Double].widen,
        Decoder[Constructor].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionConstructor] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Constructor => Encoder.AsObject[Constructor].apply(enc1)
}

case class Constructor()  derives Encoder.AsObject, Decoder
