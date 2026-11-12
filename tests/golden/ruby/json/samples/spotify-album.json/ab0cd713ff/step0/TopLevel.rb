# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.tracks.items.first.external_urls.spotify
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class ExternalUrls < Dry::Struct
  attribute :spotify, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      spotify: d.fetch("spotify"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "spotify" => spotify,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Artist < Dry::Struct
  attribute :artist_name,   Types::String
  attribute :artist_type,   Types::String
  attribute :external_urls, ExternalUrls
  attribute :href,          Types::String
  attribute :id,            Types::String
  attribute :uri,           Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      artist_name:   d.fetch("name"),
      artist_type:   d.fetch("type"),
      external_urls: ExternalUrls.from_dynamic!(d.fetch("external_urls")),
      href:          d.fetch("href"),
      id:            d.fetch("id"),
      uri:           d.fetch("uri"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"          => artist_name,
      "type"          => artist_type,
      "external_urls" => external_urls.to_dynamic,
      "href"          => href,
      "id"            => id,
      "uri"           => uri,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Copyright < Dry::Struct
  attribute :copyright_type, Types::String
  attribute :text,           Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      copyright_type: d.fetch("type"),
      text:           d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type" => copyright_type,
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ExternalIDS < Dry::Struct
  attribute :upc, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      upc: d.fetch("upc"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "upc" => upc,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Image < Dry::Struct
  attribute :height, Types::Integer
  attribute :url,    Types::String
  attribute :width,  Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      height: d.fetch("height"),
      url:    d.fetch("url"),
      width:  d.fetch("width"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "height" => height,
      "url"    => url,
      "width"  => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Item < Dry::Struct
  attribute :artists,           Types.Array(Artist)
  attribute :available_markets, Types.Array(Types::String)
  attribute :disc_number,       Types::Integer
  attribute :duration_ms,       Types::Integer
  attribute :explicit,          Types::Bool
  attribute :external_urls,     ExternalUrls
  attribute :href,              Types::String
  attribute :id,                Types::String
  attribute :item_name,         Types::String
  attribute :item_type,         Types::String
  attribute :preview_url,       Types::String
  attribute :track_number,      Types::Integer
  attribute :uri,               Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      artists:           d.fetch("artists").map { |x| Artist.from_dynamic!(x) },
      available_markets: d.fetch("available_markets"),
      disc_number:       d.fetch("disc_number"),
      duration_ms:       d.fetch("duration_ms"),
      explicit:          d.fetch("explicit"),
      external_urls:     ExternalUrls.from_dynamic!(d.fetch("external_urls")),
      href:              d.fetch("href"),
      id:                d.fetch("id"),
      item_name:         d.fetch("name"),
      item_type:         d.fetch("type"),
      preview_url:       d.fetch("preview_url"),
      track_number:      d.fetch("track_number"),
      uri:               d.fetch("uri"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "artists"           => artists.map { |x| x.to_dynamic },
      "available_markets" => available_markets,
      "disc_number"       => disc_number,
      "duration_ms"       => duration_ms,
      "explicit"          => explicit,
      "external_urls"     => external_urls.to_dynamic,
      "href"              => href,
      "id"                => id,
      "name"              => item_name,
      "type"              => item_type,
      "preview_url"       => preview_url,
      "track_number"      => track_number,
      "uri"               => uri,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Tracks < Dry::Struct
  attribute :href,        Types::String
  attribute :items,       Types.Array(Item)
  attribute :limit,       Types::Integer
  attribute :offset,      Types::Integer
  attribute :previous,    Types::Nil
  attribute :total,       Types::Integer
  attribute :tracks_next, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      href:        d.fetch("href"),
      items:       d.fetch("items").map { |x| Item.from_dynamic!(x) },
      limit:       d.fetch("limit"),
      offset:      d.fetch("offset"),
      previous:    d.fetch("previous"),
      total:       d.fetch("total"),
      tracks_next: d.fetch("next"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "href"     => href,
      "items"    => items.map { |x| x.to_dynamic },
      "limit"    => limit,
      "offset"   => offset,
      "previous" => previous,
      "total"    => total,
      "next"     => tracks_next,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :album_type,             Types::String
  attribute :artists,                Types.Array(Artist)
  attribute :available_markets,      Types.Array(Types::String)
  attribute :copyrights,             Types.Array(Copyright)
  attribute :external_ids,           ExternalIDS
  attribute :external_urls,          ExternalUrls
  attribute :genres,                 Types.Array(Types::Any)
  attribute :href,                   Types::String
  attribute :id,                     Types::String
  attribute :images,                 Types.Array(Image)
  attribute :popularity,             Types::Integer
  attribute :release_date,           Types::String
  attribute :release_date_precision, Types::String
  attribute :top_level_name,         Types::String
  attribute :top_level_type,         Types::String
  attribute :tracks,                 Tracks
  attribute :uri,                    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      album_type:             d.fetch("album_type"),
      artists:                d.fetch("artists").map { |x| Artist.from_dynamic!(x) },
      available_markets:      d.fetch("available_markets"),
      copyrights:             d.fetch("copyrights").map { |x| Copyright.from_dynamic!(x) },
      external_ids:           ExternalIDS.from_dynamic!(d.fetch("external_ids")),
      external_urls:          ExternalUrls.from_dynamic!(d.fetch("external_urls")),
      genres:                 d.fetch("genres"),
      href:                   d.fetch("href"),
      id:                     d.fetch("id"),
      images:                 d.fetch("images").map { |x| Image.from_dynamic!(x) },
      popularity:             d.fetch("popularity"),
      release_date:           d.fetch("release_date"),
      release_date_precision: d.fetch("release_date_precision"),
      top_level_name:         d.fetch("name"),
      top_level_type:         d.fetch("type"),
      tracks:                 Tracks.from_dynamic!(d.fetch("tracks")),
      uri:                    d.fetch("uri"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "album_type"             => album_type,
      "artists"                => artists.map { |x| x.to_dynamic },
      "available_markets"      => available_markets,
      "copyrights"             => copyrights.map { |x| x.to_dynamic },
      "external_ids"           => external_ids.to_dynamic,
      "external_urls"          => external_urls.to_dynamic,
      "genres"                 => genres,
      "href"                   => href,
      "id"                     => id,
      "images"                 => images.map { |x| x.to_dynamic },
      "popularity"             => popularity,
      "release_date"           => release_date,
      "release_date_precision" => release_date_precision,
      "name"                   => top_level_name,
      "type"                   => top_level_type,
      "tracks"                 => tracks.to_dynamic,
      "uri"                    => uri,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
