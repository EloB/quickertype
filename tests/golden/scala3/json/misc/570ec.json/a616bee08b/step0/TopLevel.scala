package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val id : String,
    val identifiers : Seq[Identifier],
    val keywords : Seq[String],
    val links : Seq[Link],
    val name : String,
    val other_names : Seq[OtherName],
    val superseded_by : Option[Json] = None,
    val text : Seq[Text]
) derives Encoder.AsObject, Decoder

case class Identifier (
    val identifier : String,
    val scheme : Scheme
) derives Encoder.AsObject, Decoder

enum Scheme : 
    case Dep5
    case Spdx
    case Trove

given Decoder[Scheme] = Decoder.decodeString.emap {
    case "DEP5" => scala.Right(Scheme.Dep5)
    case "SPDX" => scala.Right(Scheme.Spdx)
    case "Trove" => scala.Right(Scheme.Trove)
    case other => scala.Left("invalid Scheme: " + other)
}
given Encoder[Scheme] = Encoder.encodeString.contramap {
    case Scheme.Dep5 => "DEP5"
    case Scheme.Spdx => "SPDX"
    case Scheme.Trove => "Trove"
}

case class Link (
    val note : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class OtherName (
    val name : String,
    val note : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Text (
    val media_type : String,
    val title : String,
    val url : String
) derives Encoder.AsObject, Decoder
