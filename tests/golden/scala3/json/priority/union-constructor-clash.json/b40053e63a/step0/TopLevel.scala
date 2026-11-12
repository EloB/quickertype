package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val BoolInUnion : BoolInUnion,
    val union : Seq[Union]
) derives Encoder.AsObject, Decoder

case class BoolInUnion (
    val a : Boolean
) derives Encoder.AsObject, Decoder

type Union = Boolean | Long
given Decoder[Union] = {
    List[Decoder[Union]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Union] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}
