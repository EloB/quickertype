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
    case Spdx
    case Trove
    case Dep5

given Decoder[Scheme] = Decoder.decodeString.emap {
    case "SPDX" => scala.Right(Scheme.Spdx)
    case "Trove" => scala.Right(Scheme.Trove)
    case "DEP5" => scala.Right(Scheme.Dep5)
    case other => scala.Left("invalid Scheme: " + other)
}
given Encoder[Scheme] = Encoder.encodeString.contramap {
    case Scheme.Spdx => "SPDX"
    case Scheme.Trove => "Trove"
    case Scheme.Dep5 => "DEP5"
}

enum Keyword : 
    case OSIApproved
    case Discouraged
    case Redundant

given Decoder[Keyword] = Decoder.decodeString.emap {
    case "osi-approved" => scala.Right(Keyword.OSIApproved)
    case "discouraged" => scala.Right(Keyword.Discouraged)
    case "redundant" => scala.Right(Keyword.Redundant)
    case other => scala.Left("invalid Keyword: " + other)
}
given Encoder[Keyword] = Encoder.encodeString.contramap {
    case Keyword.OSIApproved => "osi-approved"
    case Keyword.Discouraged => "discouraged"
    case Keyword.Redundant => "redundant"
}

case class Link (
    val note : Note,
    val url : String
) derives Encoder.AsObject, Decoder

enum Note : 
    case OSIPage

given Decoder[Note] = Decoder.decodeString.emap {
    case "OSI Page" => scala.Right(Note.OSIPage)
    case other => scala.Left("invalid Note: " + other)
}
given Encoder[Note] = Encoder.encodeString.contramap {
    case Note.OSIPage => "OSI Page"
}

case class Text (
    val media_type : MediaType,
    val title : Title,
    val url : String
) derives Encoder.AsObject, Decoder

enum MediaType : 
    case TextHTML

given Decoder[MediaType] = Decoder.decodeString.emap {
    case "text/html" => scala.Right(MediaType.TextHTML)
    case other => scala.Left("invalid MediaType: " + other)
}
given Encoder[MediaType] = Encoder.encodeString.contramap {
    case MediaType.TextHTML => "text/html"
}

enum Title : 
    case HTML

given Decoder[Title] = Decoder.decodeString.emap {
    case "HTML" => scala.Right(Title.HTML)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.HTML => "HTML"
}
