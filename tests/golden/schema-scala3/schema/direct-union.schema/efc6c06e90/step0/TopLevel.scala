package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val arrayNode : Option[ArrayNode] = None,
    val booleanNode : Option[BooleanNode] = None,
    val doubleNode : Option[DoubleNode] = None,
    val intNode : Option[IntNode] = None,
    val longNode : Option[LongNode] = None,
    val nullNode : Option[NullNode] = None,
    val objectNode : Option[ObjectNode] = None,
    val stuff : Map[String, Thing],
    val textNode : Option[TextNode] = None
) derives Encoder.AsObject, Decoder

case class ArrayNode()  derives Encoder.AsObject, Decoder

case class BooleanNode()  derives Encoder.AsObject, Decoder

case class DoubleNode()  derives Encoder.AsObject, Decoder

case class IntNode()  derives Encoder.AsObject, Decoder

case class LongNode()  derives Encoder.AsObject, Decoder

case class NullNode()  derives Encoder.AsObject, Decoder

case class ObjectNode()  derives Encoder.AsObject, Decoder

case class Thing (
    val optional : Option[Anything] = None,
    val required : Anything
) derives Encoder.AsObject, Decoder

type Anything = Seq[Option[Json]] | Map[String, Option[Json]] | Boolean | Double | Long | String | NullValue
given Decoder[Anything] = {
    List[Decoder[Anything]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Anything] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc4)
    case enc5 : Map[String, Option[Json]] => Encoder.encodeMap[String,Option[Json]].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}

case class TextNode()  derives Encoder.AsObject, Decoder
