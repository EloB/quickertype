package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val intersection : String,
    val inUnion : InUnion,
    val maxlength : String,
    val minlength : String,
    val minMaxIntersection : String,
    val minmaxlength : String,
    val minMaxUnion : String,
    val union : String
) derives Encoder.AsObject, Decoder

type InUnion = Double | String
given Decoder[InUnion] = {
    List[Decoder[InUnion]](
        Decoder[String].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[InUnion] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}
