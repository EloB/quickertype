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
    val username : String
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
    val downsized : Downsized,
    val downsized_large : Downsized,
    val downsized_medium : Downsized,
    val downsized_small : DownsizedSmall,
    val downsized_still : Downsized,
    val fixed_height : FixedHeight,
    val fixed_height_downsampled : FixedHeight,
    val fixed_height_small : FixedHeight,
    val fixed_height_small_still : Downsized,
    val fixed_height_still : Downsized,
    val fixed_width : FixedHeight,
    val fixed_width_downsampled : FixedHeight,
    val fixed_width_small : FixedHeight,
    val fixed_width_small_still : Downsized,
    val fixed_width_still : Downsized,
    val hd : Option[DownsizedSmall] = None,
    val looping : Looping,
    val original : FixedHeight,
    val original_mp4 : DownsizedSmall,
    val original_still : Downsized,
    val preview : DownsizedSmall,
    val preview_gif : Downsized,
    val preview_webp : Downsized
) derives Encoder.AsObject, Decoder

case class Downsized (
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
    case PG
    case Y

given Decoder[Rating] = Decoder.decodeString.emap {
    case "g" => scala.Right(Rating.G)
    case "pg" => scala.Right(Rating.PG)
    case "y" => scala.Right(Rating.Y)
    case other => scala.Left("invalid Rating: " + other)
}
given Encoder[Rating] = Encoder.encodeString.contramap {
    case Rating.G => "g"
    case Rating.PG => "pg"
    case Rating.Y => "y"
}

case class User (
    val avatar_url : String,
    val banner_url : String,
    val display_name : String,
    val profile_url : String,
    val twitter : String,
    val username : String
) derives Encoder.AsObject, Decoder

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
