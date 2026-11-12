package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val bar : BarUnion,
    val foo : String
) derives Encoder.AsObject, Decoder

type BarUnion = java.time.Instant | BarEnum
given Decoder[BarUnion] = {
    List[Decoder[BarUnion]](
        Decoder[BarEnum].widen,
        Decoder[java.time.Instant].widen,
    ).reduceLeft(_ or _)
}

given Encoder[BarUnion] = Encoder.instance {
    case enc0 : BarEnum => summon[Encoder[BarEnum]].apply(enc0)
    case enc1 : java.time.Instant => summon[Encoder[java.time.Instant]].apply(enc1)
}

enum BarEnum : 
    case Quux

given Decoder[BarEnum] = Decoder.decodeString.emap {
    case "quux" => scala.Right(BarEnum.Quux)
    case other => scala.Left("invalid BarEnum: " + other)
}
given Encoder[BarEnum] = Encoder.encodeString.contramap {
    case BarEnum.Quux => "quux"
}
