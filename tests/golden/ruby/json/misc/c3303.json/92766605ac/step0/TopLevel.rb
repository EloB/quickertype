# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_meta.msg
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer  = Strict::Integer
  Hash     = Strict::Hash
  String   = Strict::String
  Type     = Strict::String.enum("gif")
  Rating   = Strict::String.enum("pg", "g", "pg-13")
  Username = Strict::String.enum("", "disneypixar")
end

module Type
  GIF = "gif"
end

class The480_WStill < Dry::Struct
  attribute :height, Types::String
  attribute :size,   Types::String.optional
  attribute :url,    Types::String
  attribute :width,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      height: d.fetch("height"),
      size:   d.key?("size") ? Types::String[d["size"]] : nil,
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
      "size"   => size,
      "url"    => url,
      "width"  => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DownsizedSmall < Dry::Struct
  attribute :height,   Types::String
  attribute :mp4,      Types::String
  attribute :mp4_size, Types::String
  attribute :width,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      height:   d.fetch("height"),
      mp4:      d.fetch("mp4"),
      mp4_size: d.fetch("mp4_size"),
      width:    d.fetch("width"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "height"   => height,
      "mp4"      => mp4,
      "mp4_size" => mp4_size,
      "width"    => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FixedHeight < Dry::Struct
  attribute :fixed_height_hash, Types::String.optional
  attribute :frames,            Types::String.optional
  attribute :height,            Types::String
  attribute :mp4,               Types::String.optional
  attribute :mp4_size,          Types::String.optional
  attribute :size,              Types::String
  attribute :url,               Types::String
  attribute :webp,              Types::String
  attribute :webp_size,         Types::String
  attribute :width,             Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fixed_height_hash: d.key?("hash") ? Types::String[d["hash"]] : nil,
      frames:            d.key?("frames") ? Types::String[d["frames"]] : nil,
      height:            d.fetch("height"),
      mp4:               d.key?("mp4") ? Types::String[d["mp4"]] : nil,
      mp4_size:          d.key?("mp4_size") ? Types::String[d["mp4_size"]] : nil,
      size:              d.fetch("size"),
      url:               d.fetch("url"),
      webp:              d.fetch("webp"),
      webp_size:         d.fetch("webp_size"),
      width:             d.fetch("width"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "hash"      => fixed_height_hash,
      "frames"    => frames,
      "height"    => height,
      "mp4"       => mp4,
      "mp4_size"  => mp4_size,
      "size"      => size,
      "url"       => url,
      "webp"      => webp,
      "webp_size" => webp_size,
      "width"     => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Looping < Dry::Struct
  attribute :mp4,      Types::String
  attribute :mp4_size, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      mp4:      d.fetch("mp4"),
      mp4_size: d.fetch("mp4_size"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "mp4"      => mp4,
      "mp4_size" => mp4_size,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Images < Dry::Struct
  attribute :downsized,                The480_WStill
  attribute :downsized_large,          The480_WStill
  attribute :downsized_medium,         The480_WStill
  attribute :downsized_small,          DownsizedSmall
  attribute :downsized_still,          The480_WStill
  attribute :fixed_height,             FixedHeight
  attribute :fixed_height_downsampled, FixedHeight
  attribute :fixed_height_small,       FixedHeight
  attribute :fixed_height_small_still, The480_WStill
  attribute :fixed_height_still,       The480_WStill
  attribute :fixed_width,              FixedHeight
  attribute :fixed_width_downsampled,  FixedHeight
  attribute :fixed_width_small,        FixedHeight
  attribute :fixed_width_small_still,  The480_WStill
  attribute :fixed_width_still,        The480_WStill
  attribute :looping,                  Looping
  attribute :original,                 FixedHeight
  attribute :original_mp4,             DownsizedSmall
  attribute :original_still,           The480_WStill
  attribute :preview,                  DownsizedSmall
  attribute :preview_gif,              The480_WStill
  attribute :preview_webp,             The480_WStill
  attribute :the_480_w_still,          The480_WStill.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      downsized:                The480_WStill.from_dynamic!(d.fetch("downsized")),
      downsized_large:          The480_WStill.from_dynamic!(d.fetch("downsized_large")),
      downsized_medium:         The480_WStill.from_dynamic!(d.fetch("downsized_medium")),
      downsized_small:          DownsizedSmall.from_dynamic!(d.fetch("downsized_small")),
      downsized_still:          The480_WStill.from_dynamic!(d.fetch("downsized_still")),
      fixed_height:             FixedHeight.from_dynamic!(d.fetch("fixed_height")),
      fixed_height_downsampled: FixedHeight.from_dynamic!(d.fetch("fixed_height_downsampled")),
      fixed_height_small:       FixedHeight.from_dynamic!(d.fetch("fixed_height_small")),
      fixed_height_small_still: The480_WStill.from_dynamic!(d.fetch("fixed_height_small_still")),
      fixed_height_still:       The480_WStill.from_dynamic!(d.fetch("fixed_height_still")),
      fixed_width:              FixedHeight.from_dynamic!(d.fetch("fixed_width")),
      fixed_width_downsampled:  FixedHeight.from_dynamic!(d.fetch("fixed_width_downsampled")),
      fixed_width_small:        FixedHeight.from_dynamic!(d.fetch("fixed_width_small")),
      fixed_width_small_still:  The480_WStill.from_dynamic!(d.fetch("fixed_width_small_still")),
      fixed_width_still:        The480_WStill.from_dynamic!(d.fetch("fixed_width_still")),
      looping:                  Looping.from_dynamic!(d.fetch("looping")),
      original:                 FixedHeight.from_dynamic!(d.fetch("original")),
      original_mp4:             DownsizedSmall.from_dynamic!(d.fetch("original_mp4")),
      original_still:           The480_WStill.from_dynamic!(d.fetch("original_still")),
      preview:                  DownsizedSmall.from_dynamic!(d.fetch("preview")),
      preview_gif:              The480_WStill.from_dynamic!(d.fetch("preview_gif")),
      preview_webp:             The480_WStill.from_dynamic!(d.fetch("preview_webp")),
      the_480_w_still:          d.key?("480w_still") ? The480_WStill.from_dynamic!(d["480w_still"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "downsized"                => downsized.to_dynamic,
      "downsized_large"          => downsized_large.to_dynamic,
      "downsized_medium"         => downsized_medium.to_dynamic,
      "downsized_small"          => downsized_small.to_dynamic,
      "downsized_still"          => downsized_still.to_dynamic,
      "fixed_height"             => fixed_height.to_dynamic,
      "fixed_height_downsampled" => fixed_height_downsampled.to_dynamic,
      "fixed_height_small"       => fixed_height_small.to_dynamic,
      "fixed_height_small_still" => fixed_height_small_still.to_dynamic,
      "fixed_height_still"       => fixed_height_still.to_dynamic,
      "fixed_width"              => fixed_width.to_dynamic,
      "fixed_width_downsampled"  => fixed_width_downsampled.to_dynamic,
      "fixed_width_small"        => fixed_width_small.to_dynamic,
      "fixed_width_small_still"  => fixed_width_small_still.to_dynamic,
      "fixed_width_still"        => fixed_width_still.to_dynamic,
      "looping"                  => looping.to_dynamic,
      "original"                 => original.to_dynamic,
      "original_mp4"             => original_mp4.to_dynamic,
      "original_still"           => original_still.to_dynamic,
      "preview"                  => preview.to_dynamic,
      "preview_gif"              => preview_gif.to_dynamic,
      "preview_webp"             => preview_webp.to_dynamic,
      "480w_still"               => the_480_w_still&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Rating
  PG   = "pg"
  G    = "g"
  PG13 = "pg-13"
end

module Username
  Empty       = ""
  Disneypixar = "disneypixar"
end

class User < Dry::Struct
  attribute :avatar_url,   Types::String
  attribute :banner_url,   Types::String
  attribute :display_name, Types::String
  attribute :profile_url,  Types::String
  attribute :username,     Types::Username

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      avatar_url:   d.fetch("avatar_url"),
      banner_url:   d.fetch("banner_url"),
      display_name: d.fetch("display_name"),
      profile_url:  d.fetch("profile_url"),
      username:     d.fetch("username"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "avatar_url"   => avatar_url,
      "banner_url"   => banner_url,
      "display_name" => display_name,
      "profile_url"  => profile_url,
      "username"     => username,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Datum < Dry::Struct
  attribute :bitly_gif_url,     Types::String
  attribute :bitly_url,         Types::String
  attribute :content_url,       Types::String
  attribute :datum_type,        Types::Type
  attribute :embed_url,         Types::String
  attribute :id,                Types::String
  attribute :images,            Images
  attribute :import_datetime,   Types::String
  attribute :is_indexable,      Types::Integer
  attribute :rating,            Types::Rating
  attribute :slug,              Types::String
  attribute :source,            Types::String
  attribute :source_post_url,   Types::String
  attribute :source_tld,        Types::String
  attribute :trending_datetime, Types::String
  attribute :url,               Types::String
  attribute :user,              User.optional
  attribute :username,          Types::Username

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bitly_gif_url:     d.fetch("bitly_gif_url"),
      bitly_url:         d.fetch("bitly_url"),
      content_url:       d.fetch("content_url"),
      datum_type:        d.fetch("type"),
      embed_url:         d.fetch("embed_url"),
      id:                d.fetch("id"),
      images:            Images.from_dynamic!(d.fetch("images")),
      import_datetime:   d.fetch("import_datetime"),
      is_indexable:      d.fetch("is_indexable"),
      rating:            d.fetch("rating"),
      slug:              d.fetch("slug"),
      source:            d.fetch("source"),
      source_post_url:   d.fetch("source_post_url"),
      source_tld:        d.fetch("source_tld"),
      trending_datetime: d.fetch("trending_datetime"),
      url:               d.fetch("url"),
      user:              d.key?("user") ? User.from_dynamic!(d["user"]) : nil,
      username:          d.fetch("username"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bitly_gif_url"     => bitly_gif_url,
      "bitly_url"         => bitly_url,
      "content_url"       => content_url,
      "type"              => datum_type,
      "embed_url"         => embed_url,
      "id"                => id,
      "images"            => images.to_dynamic,
      "import_datetime"   => import_datetime,
      "is_indexable"      => is_indexable,
      "rating"            => rating,
      "slug"              => slug,
      "source"            => source,
      "source_post_url"   => source_post_url,
      "source_tld"        => source_tld,
      "trending_datetime" => trending_datetime,
      "url"               => url,
      "user"              => user&.to_dynamic,
      "username"          => username,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pagination < Dry::Struct
  attribute :count,       Types::Integer
  attribute :offset,      Types::Integer
  attribute :total_count, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:       d.fetch("count"),
      offset:      d.fetch("offset"),
      total_count: d.fetch("total_count"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"       => count,
      "offset"      => offset,
      "total_count" => total_count,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Meta < Dry::Struct
  attribute :msg,         Types::String
  attribute :response_id, Types::String
  attribute :status,      Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      msg:         d.fetch("msg"),
      response_id: d.fetch("response_id"),
      status:      d.fetch("status"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "msg"         => msg,
      "response_id" => response_id,
      "status"      => status,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :data,           Types.Array(Datum)
  attribute :pagination,     Pagination
  attribute :top_level_meta, Meta

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:           d.fetch("data").map { |x| Datum.from_dynamic!(x) },
      pagination:     Pagination.from_dynamic!(d.fetch("pagination")),
      top_level_meta: Meta.from_dynamic!(d.fetch("meta")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data"       => data.map { |x| x.to_dynamic },
      "pagination" => pagination.to_dynamic,
      "meta"       => top_level_meta.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
