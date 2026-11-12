package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val bar : String,
    val `enum` : EnumEnum,
    val foo : String,
    val union : Union
) derives Encoder.AsObject, Decoder

enum EnumEnum : 
    case Fire
    case Grass
    case Blue

given Decoder[EnumEnum] = Decoder.decodeString.emap {
    case "red" => scala.Right(EnumEnum.Fire)
    case "green" => scala.Right(EnumEnum.Grass)
    case "blue" => scala.Right(EnumEnum.Blue)
    case other => scala.Left("invalid EnumEnum: " + other)
}
given Encoder[EnumEnum] = Encoder.encodeString.contramap {
    case EnumEnum.Fire => "red"
    case EnumEnum.Grass => "green"
    case EnumEnum.Blue => "blue"
}

type Union = Double | Boolean
given Decoder[Union] = {
    List[Decoder[Union]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Union] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}
