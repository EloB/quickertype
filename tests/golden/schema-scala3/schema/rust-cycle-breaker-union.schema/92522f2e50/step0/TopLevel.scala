package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val next : Option[Next] = None,
    val value : String
) derives Encoder.AsObject, Decoder

case class Node (
    val next : Option[Next] = None,
    val value : String
) derives Encoder.AsObject, Decoder

type Next = Node | String | NullValue
given Decoder[Next] = {
    List[Decoder[Next]](
        Decoder[String].widen,
        Decoder[Node].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Next] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Node => Encoder.AsObject[Node].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}
