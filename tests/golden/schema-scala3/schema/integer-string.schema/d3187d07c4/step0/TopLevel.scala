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
    val unionWithInt : UnionWithInt,
    val unionWithIntAndEnum : UnionWithInt
) derives Encoder.AsObject, Decoder

type UnionWithInt = Long | String
given Decoder[UnionWithInt] = {
    List[Decoder[UnionWithInt]](
        Decoder[String].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionWithInt] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}
