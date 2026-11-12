package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val arr : Option[Seq[Arr]] = None,
    val `for` : Option[String] = None,
    val gve : Gve,
    val lvc : Option[Lvc] = None,
    val otherArr : Option[Seq[OtherArr]] = None
) derives Encoder.AsObject, Decoder

type Arr = OtherArr | Long
given Decoder[Arr] = {
    List[Decoder[Arr]](
        Decoder[OtherArr].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Arr] = Encoder.instance {
    case enc0 : OtherArr => summon[Encoder[OtherArr]].apply(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}

enum OtherArr : 
    case Foo
    case Bar
    case If

given Decoder[OtherArr] = Decoder.decodeString.emap {
    case "foo" => scala.Right(OtherArr.Foo)
    case "bar" => scala.Right(OtherArr.Bar)
    case "if" => scala.Right(OtherArr.If)
    case other => scala.Left("invalid OtherArr: " + other)
}
given Encoder[OtherArr] = Encoder.encodeString.contramap {
    case OtherArr.Foo => "foo"
    case OtherArr.Bar => "bar"
    case OtherArr.If => "if"
}

enum Gve : 
    case Good
    case Neutral
    case Evil

given Decoder[Gve] = Decoder.decodeString.emap {
    case "good" => scala.Right(Gve.Good)
    case "neutral" => scala.Right(Gve.Neutral)
    case "evil" => scala.Right(Gve.Evil)
    case other => scala.Left("invalid Gve: " + other)
}
given Encoder[Gve] = Encoder.encodeString.contramap {
    case Gve.Good => "good"
    case Gve.Neutral => "neutral"
    case Gve.Evil => "evil"
}

enum Lvc : 
    case Lawful
    case Neutral
    case Chaotic

given Decoder[Lvc] = Decoder.decodeString.emap {
    case "lawful" => scala.Right(Lvc.Lawful)
    case "neutral" => scala.Right(Lvc.Neutral)
    case "chaotic" => scala.Right(Lvc.Chaotic)
    case other => scala.Left("invalid Lvc: " + other)
}
given Encoder[Lvc] = Encoder.encodeString.contramap {
    case Lvc.Lawful => "lawful"
    case Lvc.Neutral => "neutral"
    case Lvc.Chaotic => "chaotic"
}
