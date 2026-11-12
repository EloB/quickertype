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
    val distinguished : Distinguished,
    val domain : Domain,
    val downs : Long,
    val edited : Edited,
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
    val media : Option[Json] = None,
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
    val secure_media : Option[Json] = None,
    val secure_media_embed : MediaEmbed,
    val selftext : String,
    val selftext_html : Option[String] = None,
    val spoiler : Boolean,
    val stickied : Boolean,
    val subreddit : Subreddit,
    val subreddit_id : SubredditID,
    val subreddit_name_prefixed : SubredditNamePrefixed,
    val subreddit_type : SubredditType,
    val suggested_sort : Option[String] = None,
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

enum Distinguished : 
    case Admin

given Decoder[Distinguished] = Decoder.decodeString.emap {
    case "admin" => scala.Right(Distinguished.Admin)
    case other => scala.Left("invalid Distinguished: " + other)
}
given Encoder[Distinguished] = Encoder.encodeString.contramap {
    case Distinguished.Admin => "admin"
}

enum Domain : 
    case SelfAnnouncements
    case IReddIt

given Decoder[Domain] = Decoder.decodeString.emap {
    case "self.announcements" => scala.Right(Domain.SelfAnnouncements)
    case "i.redd.it" => scala.Right(Domain.IReddIt)
    case other => scala.Left("invalid Domain: " + other)
}
given Encoder[Domain] = Encoder.encodeString.contramap {
    case Domain.SelfAnnouncements => "self.announcements"
    case Domain.IReddIt => "i.redd.it"
}

type Edited = Boolean | Double
given Decoder[Edited] = {
    List[Decoder[Edited]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Edited] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}

case class MediaEmbed()  derives Encoder.AsObject, Decoder

enum PostHint : 
    case Self
    case Image

given Decoder[PostHint] = Decoder.decodeString.emap {
    case "self" => scala.Right(PostHint.Self)
    case "image" => scala.Right(PostHint.Image)
    case other => scala.Left("invalid PostHint: " + other)
}
given Encoder[PostHint] = Encoder.encodeString.contramap {
    case PostHint.Self => "self"
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
    case Announcements

given Decoder[Subreddit] = Decoder.decodeString.emap {
    case "announcements" => scala.Right(Subreddit.Announcements)
    case other => scala.Left("invalid Subreddit: " + other)
}
given Encoder[Subreddit] = Encoder.encodeString.contramap {
    case Subreddit.Announcements => "announcements"
}

enum SubredditID : 
    case T52R0Ij

given Decoder[SubredditID] = Decoder.decodeString.emap {
    case "t5_2r0ij" => scala.Right(SubredditID.T52R0Ij)
    case other => scala.Left("invalid SubredditID: " + other)
}
given Encoder[SubredditID] = Encoder.encodeString.contramap {
    case SubredditID.T52R0Ij => "t5_2r0ij"
}

enum SubredditNamePrefixed : 
    case RAnnouncements

given Decoder[SubredditNamePrefixed] = Decoder.decodeString.emap {
    case "r/announcements" => scala.Right(SubredditNamePrefixed.RAnnouncements)
    case other => scala.Left("invalid SubredditNamePrefixed: " + other)
}
given Encoder[SubredditNamePrefixed] = Encoder.encodeString.contramap {
    case SubredditNamePrefixed.RAnnouncements => "r/announcements"
}

enum SubredditType : 
    case Restricted

given Decoder[SubredditType] = Decoder.decodeString.emap {
    case "restricted" => scala.Right(SubredditType.Restricted)
    case other => scala.Left("invalid SubredditType: " + other)
}
given Encoder[SubredditType] = Encoder.encodeString.contramap {
    case SubredditType.Restricted => "restricted"
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
