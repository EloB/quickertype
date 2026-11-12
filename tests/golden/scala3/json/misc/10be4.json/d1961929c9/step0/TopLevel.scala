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
    case Miscellaneous
    case NonReusable
    case Obsolete
    case Popular
    case Permissive
    case Retired
    case SpecialPurpose
    case Copyleft
    case International

given Decoder[Keyword] = Decoder.decodeString.emap {
    case "osi-approved" => scala.Right(Keyword.OSIApproved)
    case "discouraged" => scala.Right(Keyword.Discouraged)
    case "redundant" => scala.Right(Keyword.Redundant)
    case "miscellaneous" => scala.Right(Keyword.Miscellaneous)
    case "non-reusable" => scala.Right(Keyword.NonReusable)
    case "obsolete" => scala.Right(Keyword.Obsolete)
    case "popular" => scala.Right(Keyword.Popular)
    case "permissive" => scala.Right(Keyword.Permissive)
    case "retired" => scala.Right(Keyword.Retired)
    case "special-purpose" => scala.Right(Keyword.SpecialPurpose)
    case "copyleft" => scala.Right(Keyword.Copyleft)
    case "international" => scala.Right(Keyword.International)
    case other => scala.Left("invalid Keyword: " + other)
}
given Encoder[Keyword] = Encoder.encodeString.contramap {
    case Keyword.OSIApproved => "osi-approved"
    case Keyword.Discouraged => "discouraged"
    case Keyword.Redundant => "redundant"
    case Keyword.Miscellaneous => "miscellaneous"
    case Keyword.NonReusable => "non-reusable"
    case Keyword.Obsolete => "obsolete"
    case Keyword.Popular => "popular"
    case Keyword.Permissive => "permissive"
    case Keyword.Retired => "retired"
    case Keyword.SpecialPurpose => "special-purpose"
    case Keyword.Copyleft => "copyleft"
    case Keyword.International => "international"
}

case class Link (
    val note : Note,
    val url : String
) derives Encoder.AsObject, Decoder

enum Note : 
    case OSIPage
    case TlDRLegal
    case WikipediaPage
    case NoteWikipediaPage
    case MozillaPage
    case OSETFoundationPage

given Decoder[Note] = Decoder.decodeString.emap {
    case "OSI Page" => scala.Right(Note.OSIPage)
    case "tl;dr legal" => scala.Right(Note.TlDRLegal)
    case "Wikipedia page" => scala.Right(Note.WikipediaPage)
    case "Wikipedia Page" => scala.Right(Note.NoteWikipediaPage)
    case "Mozilla Page" => scala.Right(Note.MozillaPage)
    case "OSET Foundation Page" => scala.Right(Note.OSETFoundationPage)
    case other => scala.Left("invalid Note: " + other)
}
given Encoder[Note] = Encoder.encodeString.contramap {
    case Note.OSIPage => "OSI Page"
    case Note.TlDRLegal => "tl;dr legal"
    case Note.WikipediaPage => "Wikipedia page"
    case Note.NoteWikipediaPage => "Wikipedia Page"
    case Note.MozillaPage => "Mozilla Page"
    case Note.OSETFoundationPage => "OSET Foundation Page"
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
    case ApplicationPDF

given Decoder[MediaType] = Decoder.decodeString.emap {
    case "text/html" => scala.Right(MediaType.TextHTML)
    case "text/plain" => scala.Right(MediaType.TextPlain)
    case "application/pdf" => scala.Right(MediaType.ApplicationPDF)
    case other => scala.Left("invalid MediaType: " + other)
}
given Encoder[MediaType] = Encoder.encodeString.contramap {
    case MediaType.TextHTML => "text/html"
    case MediaType.TextPlain => "text/plain"
    case MediaType.ApplicationPDF => "application/pdf"
}

enum Title : 
    case HTML
    case PlainText
    case PDF

given Decoder[Title] = Decoder.decodeString.emap {
    case "HTML" => scala.Right(Title.HTML)
    case "Plain Text" => scala.Right(Title.PlainText)
    case "PDF" => scala.Right(Title.PDF)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.HTML => "HTML"
    case Title.PlainText => "Plain Text"
    case Title.PDF => "PDF"
}
