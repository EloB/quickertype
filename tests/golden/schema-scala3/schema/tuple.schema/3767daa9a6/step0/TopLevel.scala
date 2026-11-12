package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val tuple : Seq[Tuple]
) derives Encoder.AsObject, Decoder

type Tuple = Boolean | Long
given Decoder[Tuple] = {
    List[Decoder[Tuple]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Tuple] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}
