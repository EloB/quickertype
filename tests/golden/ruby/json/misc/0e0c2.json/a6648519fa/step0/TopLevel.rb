# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.vote_score.avg.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer        = Strict::Integer
  Nil            = Strict::Nil
  Bool           = Strict::Bool
  Hash           = Strict::Hash
  String         = Strict::String
  DetailLanguage = Strict::String.enum("en", "th")
  Type           = Strict::String.enum("Poster", "Backdrop")
  ResultLanguage = Strict::String.enum("en", "-")
end

class Collection < Dry::Struct
  attribute :collection_name, Types::String
  attribute :id,              Types::Integer
  attribute :movies,          Types.Array(Types::Integer)
  attribute :slug,            Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      collection_name: d.fetch("name"),
      id:              d.fetch("id"),
      movies:          d.fetch("movies"),
      slug:            d.fetch("slug"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"   => collection_name,
      "id"     => id,
      "movies" => movies,
      "slug"   => slug,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module DetailLanguage
  En = "en"
  Th = "th"
end

class Detail < Dry::Struct
  attribute :cast,      Types::String
  attribute :director,  Types::String
  attribute :id,        Types::Integer
  attribute :language,  Types::DetailLanguage
  attribute :storyline, Types::String
  attribute :tagline,   Types::String
  attribute :title,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      cast:      d.fetch("cast"),
      director:  d.fetch("director"),
      id:        d.fetch("id"),
      language:  d.fetch("language"),
      storyline: d.fetch("storyline"),
      tagline:   d.fetch("tagline"),
      title:     d.fetch("title"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "cast"      => cast,
      "director"  => director,
      "id"        => id,
      "language"  => language,
      "storyline" => storyline,
      "tagline"   => tagline,
      "title"     => title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FavMovie < Dry::Struct
  attribute :follow,  Types::Bool
  attribute :star,    Types::Bool
  attribute :watched, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      follow:  d.fetch("follow"),
      star:    d.fetch("star"),
      watched: d.fetch("watched"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "follow"  => follow,
      "star"    => star,
      "watched" => watched,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Type
  Poster   = "Poster"
  Backdrop = "Backdrop"
end

class Image < Dry::Struct
  attribute :favs,       Types::Integer
  attribute :id,         Types::Integer
  attribute :image_type, Types::Type
  attribute :thumbnail,  Types::String
  attribute :url,        Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      favs:       d.fetch("favs"),
      id:         d.fetch("id"),
      image_type: d.fetch("type"),
      thumbnail:  d.fetch("thumbnail"),
      url:        d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "favs"      => favs,
      "id"        => id,
      "type"      => image_type,
      "thumbnail" => thumbnail,
      "url"       => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ResultLanguage
  En    = "en"
  Empty = "-"
end

class Video < Dry::Struct
  attribute :kind,     Types::String
  attribute :language, Types::ResultLanguage
  attribute :source,   Types::String
  attribute :url,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      kind:     d.fetch("kind"),
      language: d.fetch("language"),
      source:   d.fetch("source"),
      url:      d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "kind"     => kind,
      "language" => language,
      "source"   => source,
      "url"      => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class VoteScore < Dry::Struct
  attribute :avg,   Types::Integer
  attribute :score, Types::Integer
  attribute :total, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      avg:   d.fetch("avg"),
      score: d.fetch("score"),
      total: d.fetch("total"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "avg"   => avg,
      "score" => score,
      "total" => total,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Result < Dry::Struct
  attribute :active_screens, Types::Integer
  attribute :collections,    Types.Array(Collection)
  attribute :details,        Types.Array(Detail)
  attribute :duration,       Types::Integer
  attribute :fav_movie,      FavMovie
  attribute :id,             Types::Integer
  attribute :images,         Types.Array(Image)
  attribute :language,       Types::ResultLanguage
  attribute :release_date,   Types::String
  attribute :stars,          Types::Integer
  attribute :tags,           Types.Array(Types::Any).optional
  attribute :title,          Types::String
  attribute :videos,         Types.Array(Video)
  attribute :vote_score,     VoteScore
  attribute :watches,        Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      active_screens: d.fetch("active_screens"),
      collections:    d.fetch("collections").map { |x| Collection.from_dynamic!(x) },
      details:        d.fetch("details").map { |x| Detail.from_dynamic!(x) },
      duration:       d.fetch("duration"),
      fav_movie:      FavMovie.from_dynamic!(d.fetch("fav_movie")),
      id:             d.fetch("id"),
      images:         d.fetch("images").map { |x| Image.from_dynamic!(x) },
      language:       d.fetch("language"),
      release_date:   d.fetch("release_date"),
      stars:          d.fetch("stars"),
      tags:           d.fetch("tags"),
      title:          d.fetch("title"),
      videos:         d.fetch("videos").map { |x| Video.from_dynamic!(x) },
      vote_score:     VoteScore.from_dynamic!(d.fetch("vote_score")),
      watches:        d.fetch("watches"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "active_screens" => active_screens,
      "collections"    => collections.map { |x| x.to_dynamic },
      "details"        => details.map { |x| x.to_dynamic },
      "duration"       => duration,
      "fav_movie"      => fav_movie.to_dynamic,
      "id"             => id,
      "images"         => images.map { |x| x.to_dynamic },
      "language"       => language,
      "release_date"   => release_date,
      "stars"          => stars,
      "tags"           => tags,
      "title"          => title,
      "videos"         => videos.map { |x| x.to_dynamic },
      "vote_score"     => vote_score.to_dynamic,
      "watches"        => watches,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :count,          Types::Integer
  attribute :previous,       Types::Nil
  attribute :results,        Types.Array(Result)
  attribute :top_level_next, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:          d.fetch("count"),
      previous:       d.fetch("previous"),
      results:        d.fetch("results").map { |x| Result.from_dynamic!(x) },
      top_level_next: d.fetch("next"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"    => count,
      "previous" => previous,
      "results"  => results.map { |x| x.to_dynamic },
      "next"     => top_level_next,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
