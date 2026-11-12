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
    val link_flair_css_class : Option[Json] = None,
    val link_flair_text : Option[Json] = None,
    val locked : Boolean,
    val media : Option[Media] = None,
    val media_embed : MediaEmbed,
    val mod_reports : Seq[Option[Json]],
    val name : String,
    val num_comments : Long,
    val num_reports : Option[Json] = None,
    val over_18 : Boolean,
    val permalink : String,
    val post_hint : Option[PostHint] = None,
    val preview : Option[Preview] = None,
    val quarantine : Boolean,
    val removal_reason : Option[Json] = None,
    val report_reasons : Option[Json] = None,
    val saved : Boolean,
    val score : Long,
    val secure_media : Option[Media] = None,
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
    val thumbnail_height : Option[Long] = None,
    val thumbnail_width : Option[Long] = None,
    val title : String,
    val ups : Long,
    val url : String,
    val user_reports : Seq[Option[Json]],
    val view_count : Option[Json] = None,
    val visited : Boolean
) derives Encoder.AsObject, Decoder

case class Media (
    val `type` : String,
    val oembed : Oembed
) derives Encoder.AsObject, Decoder

case class Oembed (
    val author_name : String,
    val author_url : String,
    val height : Long,
    val html : String,
    val `type` : String,
    val provider_name : String,
    val provider_url : String,
    val thumbnail_height : Long,
    val thumbnail_url : String,
    val thumbnail_width : Long,
    val title : String,
    val version : String,
    val width : Long
) derives Encoder.AsObject, Decoder

case class MediaEmbed (
    val content : Option[String] = None,
    val height : Option[Long] = None,
    val scrolling : Option[Boolean] = None,
    val width : Option[Long] = None
) derives Encoder.AsObject, Decoder

enum PostHint : 
    case RichVideo
    case Link

given Decoder[PostHint] = Decoder.decodeString.emap {
    case "rich:video" => scala.Right(PostHint.RichVideo)
    case "link" => scala.Right(PostHint.Link)
    case other => scala.Left("invalid PostHint: " + other)
}
given Encoder[PostHint] = Encoder.encodeString.contramap {
    case PostHint.RichVideo => "rich:video"
    case PostHint.Link => "link"
}

case class Preview (
    val enabled : Boolean,
    val images : Seq[Image]
) derives Encoder.AsObject, Decoder

case class Image (
    val id : String,
    val resolutions : Seq[Source],
    val source : Source,
    val variants : Variants
) derives Encoder.AsObject, Decoder

case class Source (
    val height : Long,
    val url : String,
    val width : Long
) derives Encoder.AsObject, Decoder

case class Variants()  derives Encoder.AsObject, Decoder

enum Subreddit : 
    case Todayilearned

given Decoder[Subreddit] = Decoder.decodeString.emap {
    case "todayilearned" => scala.Right(Subreddit.Todayilearned)
    case other => scala.Left("invalid Subreddit: " + other)
}
given Encoder[Subreddit] = Encoder.encodeString.contramap {
    case Subreddit.Todayilearned => "todayilearned"
}

enum SubredditID : 
    case T52Qqjc

given Decoder[SubredditID] = Decoder.decodeString.emap {
    case "t5_2qqjc" => scala.Right(SubredditID.T52Qqjc)
    case other => scala.Left("invalid SubredditID: " + other)
}
given Encoder[SubredditID] = Encoder.encodeString.contramap {
    case SubredditID.T52Qqjc => "t5_2qqjc"
}

enum SubredditNamePrefixed : 
    case RTodayilearned

given Decoder[SubredditNamePrefixed] = Decoder.decodeString.emap {
    case "r/todayilearned" => scala.Right(SubredditNamePrefixed.RTodayilearned)
    case other => scala.Left("invalid SubredditNamePrefixed: " + other)
}
given Encoder[SubredditNamePrefixed] = Encoder.encodeString.contramap {
    case SubredditNamePrefixed.RTodayilearned => "r/todayilearned"
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
