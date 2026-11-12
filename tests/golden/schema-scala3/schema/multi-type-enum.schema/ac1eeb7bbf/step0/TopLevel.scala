package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val foo : FooUnion
) derives Encoder.AsObject, Decoder

type FooUnion = Boolean | Double | FooEnum | Long
given Decoder[FooUnion] = {
    List[Decoder[FooUnion]](
        Decoder[FooEnum].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[FooUnion] = Encoder.instance {
    case enc0 : FooEnum => summon[Encoder[FooEnum]].apply(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
}

enum FooEnum : 
    case A
    case B
    case C

given Decoder[FooEnum] = Decoder.decodeString.emap {
    case "a" => scala.Right(FooEnum.A)
    case "b" => scala.Right(FooEnum.B)
    case "c" => scala.Right(FooEnum.C)
    case other => scala.Left("invalid FooEnum: " + other)
}
given Encoder[FooEnum] = Encoder.encodeString.contramap {
    case FooEnum.A => "a"
    case FooEnum.B => "b"
    case FooEnum.C => "c"
}
