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
    val superseded_by : Option[Json] = None,
    val text : Seq[Text]
) derives Encoder.AsObject, Decoder

case class Identifier (
    val identifier : String,
    val scheme : String
) derives Encoder.AsObject, Decoder

enum Keyword : 
    case SpecialPurpose
    case OSIApproved

given Decoder[Keyword] = Decoder.decodeString.emap {
    case "special-purpose" => scala.Right(Keyword.SpecialPurpose)
    case "osi-approved" => scala.Right(Keyword.OSIApproved)
    case other => scala.Left("invalid Keyword: " + other)
}
given Encoder[Keyword] = Encoder.encodeString.contramap {
    case Keyword.SpecialPurpose => "special-purpose"
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
