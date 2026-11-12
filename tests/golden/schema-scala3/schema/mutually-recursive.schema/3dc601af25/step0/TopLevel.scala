package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type Foo = Seq[TopLevel] | TopLevel
given Decoder[Foo] = {
    List[Decoder[Foo]](
        Decoder[Seq[TopLevel]].widen,
        Decoder[TopLevel].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Foo] = Encoder.instance {
    case enc0 : Seq[TopLevel] => Encoder.encodeSeq[TopLevel].apply(enc0)
    case enc1 : TopLevel => Encoder.AsObject[TopLevel].apply(enc1)
}

case class Bar (
    val foo : Foo
) derives Encoder.AsObject, Decoder

case class TopLevel (
    val bar : Option[Bar] = None
) derives Encoder.AsObject, Decoder
