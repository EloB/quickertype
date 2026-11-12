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
    val other_names : Seq[OtherName],
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
    case Permissive
    case Copyleft

given Decoder[Keyword] = Decoder.decodeString.emap {
    case "osi-approved" => scala.Right(Keyword.OSIApproved)
    case "popular" => scala.Right(Keyword.Popular)
    case "permissive" => scala.Right(Keyword.Permissive)
    case "copyleft" => scala.Right(Keyword.Copyleft)
    case other => scala.Left("invalid Keyword: " + other)
}
given Encoder[Keyword] = Encoder.encodeString.contramap {
    case Keyword.OSIApproved => "osi-approved"
    case Keyword.Popular => "popular"
    case Keyword.Permissive => "permissive"
    case Keyword.Copyleft => "copyleft"
}

case class Link (
    val note : Note,
    val url : String
) derives Encoder.AsObject, Decoder

enum Note : 
    case TlDRLegal
    case WikipediaPage
    case OSIPage
    case NoteWikipediaPage
    case MozillaPage

given Decoder[Note] = Decoder.decodeString.emap {
    case "tl;dr legal" => scala.Right(Note.TlDRLegal)
    case "Wikipedia page" => scala.Right(Note.WikipediaPage)
    case "OSI Page" => scala.Right(Note.OSIPage)
    case "Wikipedia Page" => scala.Right(Note.NoteWikipediaPage)
    case "Mozilla Page" => scala.Right(Note.MozillaPage)
    case other => scala.Left("invalid Note: " + other)
}
given Encoder[Note] = Encoder.encodeString.contramap {
    case Note.TlDRLegal => "tl;dr legal"
    case Note.WikipediaPage => "Wikipedia page"
    case Note.OSIPage => "OSI Page"
    case Note.NoteWikipediaPage => "Wikipedia Page"
    case Note.MozillaPage => "Mozilla Page"
}

case class OtherName (
    val name : String,
    val note : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Text (
    val media_type : MediaType,
    val title : Title,
    val url : String
) derives Encoder.AsObject, Decoder

enum MediaType : 
    case TextHTML
    case TextPlain

given Decoder[MediaType] = Decoder.decodeString.emap {
    case "text/html" => scala.Right(MediaType.TextHTML)
    case "text/plain" => scala.Right(MediaType.TextPlain)
    case other => scala.Left("invalid MediaType: " + other)
}
given Encoder[MediaType] = Encoder.encodeString.contramap {
    case MediaType.TextHTML => "text/html"
    case MediaType.TextPlain => "text/plain"
}

enum Title : 
    case HTML
    case PlainText

given Decoder[Title] = Decoder.decodeString.emap {
    case "HTML" => scala.Right(Title.HTML)
    case "Plain Text" => scala.Right(Title.PlainText)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.HTML => "HTML"
    case Title.PlainText => "Plain Text"
}
