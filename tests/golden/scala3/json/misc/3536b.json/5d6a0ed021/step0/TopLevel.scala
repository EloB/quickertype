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
    val keywords : Seq[Keyword],
    val links : Seq[Link],
    val name : String,
    val other_names : Seq[Option[Json]],
    val superseded_by : String,
    val text : Seq[Text]
) derives Encoder.AsObject, Decoder

case class Identifier (
    val identifier : String,
    val scheme : Scheme
) derives Encoder.AsObject, Decoder

enum Scheme : 
    case Spdx
    case Dep5
    case Trove

given Decoder[Scheme] = Decoder.decodeString.emap {
    case "SPDX" => scala.Right(Scheme.Spdx)
    case "DEP5" => scala.Right(Scheme.Dep5)
    case "Trove" => scala.Right(Scheme.Trove)
    case other => scala.Left("invalid Scheme: " + other)
}
given Encoder[Scheme] = Encoder.encodeString.contramap {
    case Scheme.Spdx => "SPDX"
    case Scheme.Dep5 => "DEP5"
    case Scheme.Trove => "Trove"
}

enum Keyword : 
    case Discouraged
    case Obsolete
    case OSIApproved

given Decoder[Keyword] = Decoder.decodeString.emap {
    case "discouraged" => scala.Right(Keyword.Discouraged)
    case "obsolete" => scala.Right(Keyword.Obsolete)
    case "osi-approved" => scala.Right(Keyword.OSIApproved)
    case other => scala.Left("invalid Keyword: " + other)
}
given Encoder[Keyword] = Encoder.encodeString.contramap {
    case Keyword.Discouraged => "discouraged"
    case Keyword.Obsolete => "obsolete"
    case Keyword.OSIApproved => "osi-approved"
}

case class Link (
    val note : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class Text (
    val media_type : String,
    val title : String,
    val url : String
) derives Encoder.AsObject, Decoder
