package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val comments : Long,
    val comments_url : String,
    val commits_url : String,
    val created_at : java.time.Instant,
    val description : Option[String] = None,
    val files : Map[String, File],
    val forks_url : String,
    val git_pull_url : String,
    val git_push_url : String,
    val html_url : String,
    val id : String,
    val public : Boolean,
    val truncated : Boolean,
    val updated_at : java.time.Instant,
    val url : String,
    val user : Option[Json] = None
) derives Encoder.AsObject, Decoder

case class File (
    val `type` : Type,
    val filename : String,
    val language : Option[Language] = None,
    val raw_url : String,
    val size : Long
) derives Encoder.AsObject, Decoder

enum Type : 
    case TextPlain

given Decoder[Type] = Decoder.decodeString.emap {
    case "text/plain" => scala.Right(Type.TextPlain)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.TextPlain => "text/plain"
}

enum Language : 
    case Markdown

given Decoder[Language] = Decoder.decodeString.emap {
    case "Markdown" => scala.Right(Language.Markdown)
    case other => scala.Left("invalid Language: " + other)
}
given Encoder[Language] = Encoder.encodeString.contramap {
    case Language.Markdown => "Markdown"
}
