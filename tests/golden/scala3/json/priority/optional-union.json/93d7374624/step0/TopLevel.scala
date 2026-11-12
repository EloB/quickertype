package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val a : Option[A] = None
) derives Encoder.AsObject, Decoder

type A = Long | String
given Decoder[A] = {
    List[Decoder[A]](
        Decoder[String].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[A] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}
