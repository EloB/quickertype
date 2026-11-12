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
    val superseded_by : Option[String] = None,
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

enum Keyword : 
    case OSIApproved
    case Popular
    case Copyleft
    case International

given Decoder[Keyword] = Decoder.decodeString.emap {
    case "osi-approved" => scala.Right(Keyword.OSIApproved)
    case "popular" => scala.Right(Keyword.Popular)
    case "copyleft" => scala.Right(Keyword.Copyleft)
    case "international" => scala.Right(Keyword.International)
    case other => scala.Left("invalid Keyword: " + other)
}
given Encoder[Keyword] = Encoder.encodeString.contramap {
    case Keyword.OSIApproved => "osi-approved"
    case Keyword.Popular => "popular"
    case Keyword.Copyleft => "copyleft"
    case Keyword.International => "international"
}

case class Link (
    val note : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class Text (
    val media_type : MediaType,
    val title : Title,
    val url : String
) derives Encoder.AsObject, Decoder

enum MediaType : 
    case TextPlain
    case TextHTML

given Decoder[MediaType] = Decoder.decodeString.emap {
    case "text/plain" => scala.Right(MediaType.TextPlain)
    case "text/html" => scala.Right(MediaType.TextHTML)
    case other => scala.Left("invalid MediaType: " + other)
}
given Encoder[MediaType] = Encoder.encodeString.contramap {
    case MediaType.TextPlain => "text/plain"
    case MediaType.TextHTML => "text/html"
}

enum Title : 
    case PlainText
    case HTML

given Decoder[Title] = Decoder.decodeString.emap {
    case "Plain Text" => scala.Right(Title.PlainText)
    case "HTML" => scala.Right(Title.HTML)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.PlainText => "Plain Text"
    case Title.HTML => "HTML"
}
