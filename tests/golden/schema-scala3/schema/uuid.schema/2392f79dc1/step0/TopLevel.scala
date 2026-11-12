package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val arrNullable : Option[Seq[Option[java.util.UUID]]] = None,
    val arrOne : Option[Seq[java.util.UUID]] = None,
    val nullable : Option[java.util.UUID] = None,
    val one : java.util.UUID,
    val optional : Option[java.util.UUID] = None,
    val unionWithEnum : UnionWithEnumUnion
) derives Encoder.AsObject, Decoder

type UnionWithEnumUnion = UnionWithEnumEnum | java.util.UUID
given Decoder[UnionWithEnumUnion] = {
    List[Decoder[UnionWithEnumUnion]](
        Decoder[UnionWithEnumEnum].widen,
        Decoder[java.util.UUID].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnionWithEnumUnion] = Encoder.instance {
    case enc0 : UnionWithEnumEnum => summon[Encoder[UnionWithEnumEnum]].apply(enc0)
    case enc1 : java.util.UUID => summon[Encoder[java.util.UUID]].apply(enc1)
}

enum UnionWithEnumEnum : 
    case Foo

given Decoder[UnionWithEnumEnum] = Decoder.decodeString.emap {
    case "foo" => scala.Right(UnionWithEnumEnum.Foo)
    case other => scala.Left("invalid UnionWithEnumEnum: " + other)
}
given Encoder[UnionWithEnumEnum] = Encoder.encodeString.contramap {
    case UnionWithEnumEnum.Foo => "foo"
}
