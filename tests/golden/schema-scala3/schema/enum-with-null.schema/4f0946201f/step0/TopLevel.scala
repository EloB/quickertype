package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val `enum` : Option[EnumEnum] = None
) derives Encoder.AsObject, Decoder

enum EnumEnum : 
    case Foo
    case Bar

given Decoder[EnumEnum] = Decoder.decodeString.emap {
    case "foo" => scala.Right(EnumEnum.Foo)
    case "bar" => scala.Right(EnumEnum.Bar)
    case other => scala.Left("invalid EnumEnum: " + other)
}
given Encoder[EnumEnum] = Encoder.encodeString.contramap {
    case EnumEnum.Foo => "foo"
    case EnumEnum.Bar => "bar"
}
