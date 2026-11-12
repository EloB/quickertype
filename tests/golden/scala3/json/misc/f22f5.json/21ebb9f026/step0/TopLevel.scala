package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val data : TopLevelData,
    val kind : String
) derives Encoder.AsObject, Decoder

case class TopLevelData (
    val after : String,
    val before : Option[Json] = None,
    val children : Seq[Child],
    val modhash : String
) derives Encoder.AsObject, Decoder

case class Child (
    val data : ChildData,
    val kind : Kind
) derives Encoder.AsObject, Decoder

case class ChildData (
    val approved_at_utc : Option[Json] = None,
    val approved_by : Option[Json] = None,
    val archived : Boolean,
    val author : String,
    val author_flair_css_class : Option[Json] = None,
    val author_flair_text : Option[Json] = None,
    val banned_at_utc : Option[Json] = None,
    val banned_by : Option[Json] = None,
    val brand_safe : Boolean,
    val can_gild : Boolean,
    val can_mod_post : Boolean,
    val clicked : Boolean,
    val contest_mode : Boolean,
    val created : Double,
    val created_utc : Double,
    val distinguished : Option[Json] = None,
    val domain : String,
    val downs : Long,
    val edited : Boolean,
    val gilded : Long,
    val hidden : Boolean,
    val hide_score : Boolean,
    val id : String,
    val is_self : Boolean,
    val is_video : Boolean,
    val likes : Option[Json] = None,
    val link_flair_css_class : Option[String] = None,
    val link_flair_text : Option[String] = None,
    val locked : Boolean,
    val media : Option[Json] = None,
    val media_embed : MediaEmbed,
    val mod_reports : Seq[Option[Json]],
    val name : String,
    val num_comments : Long,
    val num_reports : Option[Json] = None,
    val over_18 : Boolean,
    val permalink : String,
    val quarantine : Boolean,
    val removal_reason : Option[Json] = None,
    val report_reasons : Option[Json] = None,
    val saved : Boolean,
    val score : Long,
    val secure_media : Option[Json] = None,
    val secure_media_embed : MediaEmbed,
    val selftext : String,
    val selftext_html : Option[Json] = None,
    val spoiler : Boolean,
    val stickied : Boolean,
    val subreddit : Subreddit,
    val subreddit_id : SubredditID,
    val subreddit_name_prefixed : SubredditNamePrefixed,
    val subreddit_type : SubredditType,
    val suggested_sort : Option[Json] = None,
    val thumbnail : String,
    val title : String,
    val ups : Long,
    val url : String,
    val user_reports : Seq[Option[Json]],
    val view_count : Option[Json] = None,
    val visited : Boolean
) derives Encoder.AsObject, Decoder

case class MediaEmbed()  derives Encoder.AsObject, Decoder

enum Subreddit : 
    case Worldnews

given Decoder[Subreddit] = Decoder.decodeString.emap {
    case "worldnews" => scala.Right(Subreddit.Worldnews)
    case other => scala.Left("invalid Subreddit: " + other)
}
given Encoder[Subreddit] = Encoder.encodeString.contramap {
    case Subreddit.Worldnews => "worldnews"
}

enum SubredditID : 
    case T52Qh13

given Decoder[SubredditID] = Decoder.decodeString.emap {
    case "t5_2qh13" => scala.Right(SubredditID.T52Qh13)
    case other => scala.Left("invalid SubredditID: " + other)
}
given Encoder[SubredditID] = Encoder.encodeString.contramap {
    case SubredditID.T52Qh13 => "t5_2qh13"
}

enum SubredditNamePrefixed : 
    case RWorldnews

given Decoder[SubredditNamePrefixed] = Decoder.decodeString.emap {
    case "r/worldnews" => scala.Right(SubredditNamePrefixed.RWorldnews)
    case other => scala.Left("invalid SubredditNamePrefixed: " + other)
}
given Encoder[SubredditNamePrefixed] = Encoder.encodeString.contramap {
    case SubredditNamePrefixed.RWorldnews => "r/worldnews"
}

enum SubredditType : 
    case Public

given Decoder[SubredditType] = Decoder.decodeString.emap {
    case "public" => scala.Right(SubredditType.Public)
    case other => scala.Left("invalid SubredditType: " + other)
}
given Encoder[SubredditType] = Encoder.encodeString.contramap {
    case SubredditType.Public => "public"
}

enum Kind : 
    case T3

given Decoder[Kind] = Decoder.decodeString.emap {
    case "t3" => scala.Right(Kind.T3)
    case other => scala.Left("invalid Kind: " + other)
}
given Encoder[Kind] = Encoder.encodeString.contramap {
    case Kind.T3 => "t3"
}
