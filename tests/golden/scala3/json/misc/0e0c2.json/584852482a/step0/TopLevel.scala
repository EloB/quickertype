package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val count : Long,
    val next : String,
    val previous : Option[Json] = None,
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Result (
    val active_screens : Long,
    val collections : Seq[Collection],
    val details : Seq[Detail],
    val duration : Long,
    val fav_movie : FavMovie,
    val id : Long,
    val images : Seq[Image],
    val language : ResultLanguage,
    val release_date : String,
    val stars : Long,
    val tags : Option[Seq[Option[Json]]] = None,
    val title : String,
    val videos : Seq[Video],
    val vote_score : VoteScore,
    val watches : Long
) derives Encoder.AsObject, Decoder

case class Collection (
    val id : Long,
    val movies : Seq[Long],
    val name : String,
    val slug : String
) derives Encoder.AsObject, Decoder

case class Detail (
    val cast : String,
    val director : String,
    val id : Long,
    val language : DetailLanguage,
    val storyline : String,
    val tagline : String,
    val title : String
) derives Encoder.AsObject, Decoder

enum DetailLanguage : 
    case En
    case Th

given Decoder[DetailLanguage] = Decoder.decodeString.emap {
    case "en" => scala.Right(DetailLanguage.En)
    case "th" => scala.Right(DetailLanguage.Th)
    case other => scala.Left("invalid DetailLanguage: " + other)
}
given Encoder[DetailLanguage] = Encoder.encodeString.contramap {
    case DetailLanguage.En => "en"
    case DetailLanguage.Th => "th"
}

case class FavMovie (
    val follow : Boolean,
    val star : Boolean,
    val watched : Boolean
) derives Encoder.AsObject, Decoder

case class Image (
    val favs : Long,
    val id : Long,
    val `type` : Type,
    val thumbnail : String,
    val url : String
) derives Encoder.AsObject, Decoder

enum Type : 
    case Poster
    case Backdrop

given Decoder[Type] = Decoder.decodeString.emap {
    case "Poster" => scala.Right(Type.Poster)
    case "Backdrop" => scala.Right(Type.Backdrop)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.Poster => "Poster"
    case Type.Backdrop => "Backdrop"
}

enum ResultLanguage : 
    case En
    case Empty

given Decoder[ResultLanguage] = Decoder.decodeString.emap {
    case "en" => scala.Right(ResultLanguage.En)
    case "-" => scala.Right(ResultLanguage.Empty)
    case other => scala.Left("invalid ResultLanguage: " + other)
}
given Encoder[ResultLanguage] = Encoder.encodeString.contramap {
    case ResultLanguage.En => "en"
    case ResultLanguage.Empty => "-"
}

case class Video (
    val kind : String,
    val language : ResultLanguage,
    val source : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class VoteScore (
    val avg : Long,
    val score : Long,
    val total : Long
) derives Encoder.AsObject, Decoder
