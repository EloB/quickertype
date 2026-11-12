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
    val author_flair_css_class : Option[String] = None,
    val author_flair_text : Option[String] = None,
    val banned_at_utc : Option[Json] = None,
    val banned_by : Option[Json] = None,
    val brand_safe : Boolean,
    val can_gild : Boolean,
    val can_mod_post : Boolean,
    val clicked : Boolean,
    val contest_mode : Boolean,
    val created : Long,
    val created_utc : Long,
    val distinguished : Option[String] = None,
    val domain : Domain,
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
    val parent_whitelist_status : WhitelistStatus,
    val permalink : String,
    val post_hint : PostHint,
    val preview : Preview,
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
    val thumbnail_height : Long,
    val thumbnail_width : Long,
    val title : String,
    val ups : Long,
    val url : String,
    val user_reports : Seq[Option[Json]],
    val view_count : Option[Json] = None,
    val visited : Boolean,
    val whitelist_status : WhitelistStatus
) derives Encoder.AsObject, Decoder

enum Domain : 
    case RedditCOM
    case IImgurCOM
    case ImgurCOM
    case IReddIt

given Decoder[Domain] = Decoder.decodeString.emap {
    case "reddit.com" => scala.Right(Domain.RedditCOM)
    case "i.imgur.com" => scala.Right(Domain.IImgurCOM)
    case "imgur.com" => scala.Right(Domain.ImgurCOM)
    case "i.redd.it" => scala.Right(Domain.IReddIt)
    case other => scala.Left("invalid Domain: " + other)
}
given Encoder[Domain] = Encoder.encodeString.contramap {
    case Domain.RedditCOM => "reddit.com"
    case Domain.IImgurCOM => "i.imgur.com"
    case Domain.ImgurCOM => "imgur.com"
    case Domain.IReddIt => "i.redd.it"
}

case class MediaEmbed()  derives Encoder.AsObject, Decoder

enum WhitelistStatus : 
    case AllAds

given Decoder[WhitelistStatus] = Decoder.decodeString.emap {
    case "all_ads" => scala.Right(WhitelistStatus.AllAds)
    case other => scala.Left("invalid WhitelistStatus: " + other)
}
given Encoder[WhitelistStatus] = Encoder.encodeString.contramap {
    case WhitelistStatus.AllAds => "all_ads"
}

enum PostHint : 
    case Link
    case Image

given Decoder[PostHint] = Decoder.decodeString.emap {
    case "link" => scala.Right(PostHint.Link)
    case "image" => scala.Right(PostHint.Image)
    case other => scala.Left("invalid PostHint: " + other)
}
given Encoder[PostHint] = Encoder.encodeString.contramap {
    case PostHint.Link => "link"
    case PostHint.Image => "image"
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

case class Variants (
    val gif : Option[GIF] = None,
    val mp4 : Option[GIF] = None
) derives Encoder.AsObject, Decoder

case class GIF (
    val resolutions : Seq[Source],
    val source : Source
) derives Encoder.AsObject, Decoder

enum Subreddit : 
    case Funny

given Decoder[Subreddit] = Decoder.decodeString.emap {
    case "funny" => scala.Right(Subreddit.Funny)
    case other => scala.Left("invalid Subreddit: " + other)
}
given Encoder[Subreddit] = Encoder.encodeString.contramap {
    case Subreddit.Funny => "funny"
}

enum SubredditID : 
    case T52Qh33

given Decoder[SubredditID] = Decoder.decodeString.emap {
    case "t5_2qh33" => scala.Right(SubredditID.T52Qh33)
    case other => scala.Left("invalid SubredditID: " + other)
}
given Encoder[SubredditID] = Encoder.encodeString.contramap {
    case SubredditID.T52Qh33 => "t5_2qh33"
}

enum SubredditNamePrefixed : 
    case RFunny

given Decoder[SubredditNamePrefixed] = Decoder.decodeString.emap {
    case "r/funny" => scala.Right(SubredditNamePrefixed.RFunny)
    case other => scala.Left("invalid SubredditNamePrefixed: " + other)
}
given Encoder[SubredditNamePrefixed] = Encoder.encodeString.contramap {
    case SubredditNamePrefixed.RFunny => "r/funny"
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
