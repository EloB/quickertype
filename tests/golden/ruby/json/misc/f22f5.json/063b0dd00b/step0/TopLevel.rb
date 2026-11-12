# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.data.children.first.data.user_reports.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer               = Strict::Integer
  Nil                   = Strict::Nil
  Bool                  = Strict::Bool
  Hash                  = Strict::Hash
  String                = Strict::String
  Double                = Strict::Float | Strict::Integer
  Subreddit             = Strict::String.enum("worldnews")
  SubredditID           = Strict::String.enum("t5_2qh13")
  SubredditNamePrefixed = Strict::String.enum("r/worldnews")
  SubredditType         = Strict::String.enum("public")
  Kind                  = Strict::String.enum("t3")
end

class MediaEmbed < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Subreddit
  Worldnews = "worldnews"
end

module SubredditID
  T52Qh13 = "t5_2qh13"
end

module SubredditNamePrefixed
  RWorldnews = "r/worldnews"
end

module SubredditType
  Public = "public"
end

class ChildData < Dry::Struct
  attribute :approved_at_utc,         Types::Nil
  attribute :approved_by,             Types::Nil
  attribute :archived,                Types::Bool
  attribute :author,                  Types::String
  attribute :author_flair_css_class,  Types::Nil
  attribute :author_flair_text,       Types::Nil
  attribute :banned_at_utc,           Types::Nil
  attribute :banned_by,               Types::Nil
  attribute :brand_safe,              Types::Bool
  attribute :can_gild,                Types::Bool
  attribute :can_mod_post,            Types::Bool
  attribute :clicked,                 Types::Bool
  attribute :contest_mode,            Types::Bool
  attribute :created,                 Types::Double
  attribute :created_utc,             Types::Double
  attribute :data_name,               Types::String
  attribute :distinguished,           Types::Nil
  attribute :domain,                  Types::String
  attribute :downs,                   Types::Integer
  attribute :edited,                  Types::Bool
  attribute :gilded,                  Types::Integer
  attribute :hidden,                  Types::Bool
  attribute :hide_score,              Types::Bool
  attribute :id,                      Types::String
  attribute :is_self,                 Types::Bool
  attribute :is_video,                Types::Bool
  attribute :likes,                   Types::Nil
  attribute :link_flair_css_class,    Types::String.optional
  attribute :link_flair_text,         Types::String.optional
  attribute :locked,                  Types::Bool
  attribute :media,                   Types::Nil
  attribute :media_embed,             MediaEmbed
  attribute :mod_reports,             Types.Array(Types::Any)
  attribute :num_comments,            Types::Integer
  attribute :num_reports,             Types::Nil
  attribute :over_18,                 Types::Bool
  attribute :permalink,               Types::String
  attribute :quarantine,              Types::Bool
  attribute :removal_reason,          Types::Nil
  attribute :report_reasons,          Types::Nil
  attribute :saved,                   Types::Bool
  attribute :score,                   Types::Integer
  attribute :secure_media,            Types::Nil
  attribute :secure_media_embed,      MediaEmbed
  attribute :selftext,                Types::String
  attribute :selftext_html,           Types::Nil
  attribute :spoiler,                 Types::Bool
  attribute :stickied,                Types::Bool
  attribute :subreddit,               Types::Subreddit
  attribute :subreddit_id,            Types::SubredditID
  attribute :subreddit_name_prefixed, Types::SubredditNamePrefixed
  attribute :subreddit_type,          Types::SubredditType
  attribute :suggested_sort,          Types::Nil
  attribute :thumbnail,               Types::String
  attribute :title,                   Types::String
  attribute :ups,                     Types::Integer
  attribute :url,                     Types::String
  attribute :user_reports,            Types.Array(Types::Any)
  attribute :view_count,              Types::Nil
  attribute :visited,                 Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      approved_at_utc:         d.fetch("approved_at_utc"),
      approved_by:             d.fetch("approved_by"),
      archived:                d.fetch("archived"),
      author:                  d.fetch("author"),
      author_flair_css_class:  d.fetch("author_flair_css_class"),
      author_flair_text:       d.fetch("author_flair_text"),
      banned_at_utc:           d.fetch("banned_at_utc"),
      banned_by:               d.fetch("banned_by"),
      brand_safe:              d.fetch("brand_safe"),
      can_gild:                d.fetch("can_gild"),
      can_mod_post:            d.fetch("can_mod_post"),
      clicked:                 d.fetch("clicked"),
      contest_mode:            d.fetch("contest_mode"),
      created:                 d.fetch("created"),
      created_utc:             d.fetch("created_utc"),
      data_name:               d.fetch("name"),
      distinguished:           d.fetch("distinguished"),
      domain:                  d.fetch("domain"),
      downs:                   d.fetch("downs"),
      edited:                  d.fetch("edited"),
      gilded:                  d.fetch("gilded"),
      hidden:                  d.fetch("hidden"),
      hide_score:              d.fetch("hide_score"),
      id:                      d.fetch("id"),
      is_self:                 d.fetch("is_self"),
      is_video:                d.fetch("is_video"),
      likes:                   d.fetch("likes"),
      link_flair_css_class:    d.fetch("link_flair_css_class"),
      link_flair_text:         d.fetch("link_flair_text"),
      locked:                  d.fetch("locked"),
      media:                   d.fetch("media"),
      media_embed:             MediaEmbed.from_dynamic!(d.fetch("media_embed")),
      mod_reports:             d.fetch("mod_reports"),
      num_comments:            d.fetch("num_comments"),
      num_reports:             d.fetch("num_reports"),
      over_18:                 d.fetch("over_18"),
      permalink:               d.fetch("permalink"),
      quarantine:              d.fetch("quarantine"),
      removal_reason:          d.fetch("removal_reason"),
      report_reasons:          d.fetch("report_reasons"),
      saved:                   d.fetch("saved"),
      score:                   d.fetch("score"),
      secure_media:            d.fetch("secure_media"),
      secure_media_embed:      MediaEmbed.from_dynamic!(d.fetch("secure_media_embed")),
      selftext:                d.fetch("selftext"),
      selftext_html:           d.fetch("selftext_html"),
      spoiler:                 d.fetch("spoiler"),
      stickied:                d.fetch("stickied"),
      subreddit:               d.fetch("subreddit"),
      subreddit_id:            d.fetch("subreddit_id"),
      subreddit_name_prefixed: d.fetch("subreddit_name_prefixed"),
      subreddit_type:          d.fetch("subreddit_type"),
      suggested_sort:          d.fetch("suggested_sort"),
      thumbnail:               d.fetch("thumbnail"),
      title:                   d.fetch("title"),
      ups:                     d.fetch("ups"),
      url:                     d.fetch("url"),
      user_reports:            d.fetch("user_reports"),
      view_count:              d.fetch("view_count"),
      visited:                 d.fetch("visited"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "approved_at_utc"         => approved_at_utc,
      "approved_by"             => approved_by,
      "archived"                => archived,
      "author"                  => author,
      "author_flair_css_class"  => author_flair_css_class,
      "author_flair_text"       => author_flair_text,
      "banned_at_utc"           => banned_at_utc,
      "banned_by"               => banned_by,
      "brand_safe"              => brand_safe,
      "can_gild"                => can_gild,
      "can_mod_post"            => can_mod_post,
      "clicked"                 => clicked,
      "contest_mode"            => contest_mode,
      "created"                 => created,
      "created_utc"             => created_utc,
      "name"                    => data_name,
      "distinguished"           => distinguished,
      "domain"                  => domain,
      "downs"                   => downs,
      "edited"                  => edited,
      "gilded"                  => gilded,
      "hidden"                  => hidden,
      "hide_score"              => hide_score,
      "id"                      => id,
      "is_self"                 => is_self,
      "is_video"                => is_video,
      "likes"                   => likes,
      "link_flair_css_class"    => link_flair_css_class,
      "link_flair_text"         => link_flair_text,
      "locked"                  => locked,
      "media"                   => media,
      "media_embed"             => media_embed.to_dynamic,
      "mod_reports"             => mod_reports,
      "num_comments"            => num_comments,
      "num_reports"             => num_reports,
      "over_18"                 => over_18,
      "permalink"               => permalink,
      "quarantine"              => quarantine,
      "removal_reason"          => removal_reason,
      "report_reasons"          => report_reasons,
      "saved"                   => saved,
      "score"                   => score,
      "secure_media"            => secure_media,
      "secure_media_embed"      => secure_media_embed.to_dynamic,
      "selftext"                => selftext,
      "selftext_html"           => selftext_html,
      "spoiler"                 => spoiler,
      "stickied"                => stickied,
      "subreddit"               => subreddit,
      "subreddit_id"            => subreddit_id,
      "subreddit_name_prefixed" => subreddit_name_prefixed,
      "subreddit_type"          => subreddit_type,
      "suggested_sort"          => suggested_sort,
      "thumbnail"               => thumbnail,
      "title"                   => title,
      "ups"                     => ups,
      "url"                     => url,
      "user_reports"            => user_reports,
      "view_count"              => view_count,
      "visited"                 => visited,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Kind
  T3 = "t3"
end

class Child < Dry::Struct
  attribute :data, ChildData
  attribute :kind, Types::Kind

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data: ChildData.from_dynamic!(d.fetch("data")),
      kind: d.fetch("kind"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data" => data.to_dynamic,
      "kind" => kind,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelData < Dry::Struct
  attribute :after,    Types::String
  attribute :before,   Types::Nil
  attribute :children, Types.Array(Child)
  attribute :modhash,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      after:    d.fetch("after"),
      before:   d.fetch("before"),
      children: d.fetch("children").map { |x| Child.from_dynamic!(x) },
      modhash:  d.fetch("modhash"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "after"    => after,
      "before"   => before,
      "children" => children.map { |x| x.to_dynamic },
      "modhash"  => modhash,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :data, TopLevelData
  attribute :kind, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data: TopLevelData.from_dynamic!(d.fetch("data")),
      kind: d.fetch("kind"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data" => data.to_dynamic,
      "kind" => kind,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
