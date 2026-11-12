package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val arrNullable : Option[Seq[Option[String]]] = None,
    val arrOne : Option[Seq[String]] = None,
    val nullable : Option[String] = None,
    val one : String,
    val optional : Option[String] = None,
    val unionWithBool : UnionWithBool,
    val unionWithBoolAndEnum : UnionWithBool
) derives Encoder.AsObject, Decoder

type UnionWithBool = Boolean | String
given Decoder[UnionWithBool] = {
    List[Decoder[UnionWithBool]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionWithBool] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
}
