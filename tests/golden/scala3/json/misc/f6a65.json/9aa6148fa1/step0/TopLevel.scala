package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val data : Seq[Datum],
    val meta : Meta,
    val pagination : Pagination
) derives Encoder.AsObject, Decoder

case class Datum (
    val bitly_gif_url : String,
    val bitly_url : String,
    val content_url : String,
    val `type` : Type,
    val embed_url : String,
    val id : String,
    val images : Images,
    val import_datetime : String,
    val is_indexable : Long,
    val rating : Rating,
    val slug : String,
    val source : String,
    val source_post_url : String,
    val source_tld : String,
    val trending_datetime : String,
    val url : String,
    val user : Option[User] = None,
    val username : Username
) derives Encoder.AsObject, Decoder

enum Type : 
    case GIF

given Decoder[Type] = Decoder.decodeString.emap {
    case "gif" => scala.Right(Type.GIF)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.GIF => "gif"
}

case class Images (
    val downsized : The480_WStill,
    val downsized_large : The480_WStill,
    val downsized_medium : The480_WStill,
    val downsized_small : DownsizedSmall,
    val downsized_still : The480_WStill,
    val fixed_height : FixedHeight,
    val fixed_height_downsampled : FixedHeight,
    val fixed_height_small : FixedHeight,
    val fixed_height_small_still : The480_WStill,
    val fixed_height_still : The480_WStill,
    val fixed_width : FixedHeight,
    val fixed_width_downsampled : FixedHeight,
    val fixed_width_small : FixedHeight,
    val fixed_width_small_still : The480_WStill,
    val fixed_width_still : The480_WStill,
    val looping : Looping,
    val original : FixedHeight,
    val original_mp4 : DownsizedSmall,
    val original_still : The480_WStill,
    val preview : DownsizedSmall,
    val preview_gif : The480_WStill,
    val preview_webp : The480_WStill,
    val `480w_still` : Option[The480_WStill] = None
) derives Encoder.AsObject, Decoder

case class The480_WStill (
    val height : String,
    val size : Option[String] = None,
    val url : String,
    val width : String
) derives Encoder.AsObject, Decoder

case class DownsizedSmall (
    val height : String,
    val mp4 : String,
    val mp4_size : String,
    val width : String
) derives Encoder.AsObject, Decoder

case class FixedHeight (
    val frames : Option[String] = None,
    val hash : Option[String] = None,
    val height : String,
    val mp4 : Option[String] = None,
    val mp4_size : Option[String] = None,
    val size : String,
    val url : String,
    val webp : String,
    val webp_size : String,
    val width : String
) derives Encoder.AsObject, Decoder

case class Looping (
    val mp4 : String,
    val mp4_size : String
) derives Encoder.AsObject, Decoder

enum Rating : 
    case G
    case Y
    case PG
    case PG13

given Decoder[Rating] = Decoder.decodeString.emap {
    case "g" => scala.Right(Rating.G)
    case "y" => scala.Right(Rating.Y)
    case "pg" => scala.Right(Rating.PG)
    case "pg-13" => scala.Right(Rating.PG13)
    case other => scala.Left("invalid Rating: " + other)
}
given Encoder[Rating] = Encoder.encodeString.contramap {
    case Rating.G => "g"
    case Rating.Y => "y"
    case Rating.PG => "pg"
    case Rating.PG13 => "pg-13"
}

case class User (
    val avatar_url : String,
    val banner_url : String,
    val display_name : String,
    val profile_url : String,
    val twitter : String,
    val username : Username
) derives Encoder.AsObject, Decoder

enum Username : 
    case Empty
    case Producthunt
    case Meetaiko
    case Cheezburger

given Decoder[Username] = Decoder.decodeString.emap {
    case "" => scala.Right(Username.Empty)
    case "producthunt" => scala.Right(Username.Producthunt)
    case "meetaiko" => scala.Right(Username.Meetaiko)
    case "cheezburger" => scala.Right(Username.Cheezburger)
    case other => scala.Left("invalid Username: " + other)
}
given Encoder[Username] = Encoder.encodeString.contramap {
    case Username.Empty => ""
    case Username.Producthunt => "producthunt"
    case Username.Meetaiko => "meetaiko"
    case Username.Cheezburger => "cheezburger"
}

case class Meta (
    val msg : String,
    val response_id : String,
    val status : Long
) derives Encoder.AsObject, Decoder

case class Pagination (
    val count : Long,
    val offset : Long,
    val total_count : Long
) derives Encoder.AsObject, Decoder
