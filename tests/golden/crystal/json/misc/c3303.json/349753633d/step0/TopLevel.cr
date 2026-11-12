require "json"

class TopLevel
  include JSON::Serializable

  property data : Array(Datum)

  property meta : Meta

  property pagination : Pagination
end

class Datum
  include JSON::Serializable

  property bitly_gif_url : String

  property bitly_url : String

  property content_url : String

  @[JSON::Field(key: "type")]
  property datum_type : String

  property embed_url : String

  property id : String

  property images : Images

  property import_datetime : String

  property is_indexable : Int64

  property rating : String

  property slug : String

  property source : String

  property source_post_url : String

  property source_tld : String

  property trending_datetime : String

  property url : String

  property user : User?

  property username : String
end

class Images
  include JSON::Serializable

  property downsized : Downsized

  property downsized_large : Downsized

  property downsized_medium : Downsized

  property downsized_small : DownsizedSmall

  property downsized_still : Downsized

  property fixed_height : FixedHeight

  property fixed_height_downsampled : FixedHeight

  property fixed_height_small : FixedHeight

  property fixed_height_small_still : Downsized

  property fixed_height_still : Downsized

  property fixed_width : FixedHeight

  property fixed_width_downsampled : FixedHeight

  property fixed_width_small : FixedHeight

  property fixed_width_small_still : Downsized

  property fixed_width_still : Downsized

  property looping : Looping

  property original : FixedHeight

  property original_mp4 : DownsizedSmall

  property original_still : Downsized

  property preview : DownsizedSmall

  property preview_gif : Downsized

  property preview_webp : Downsized

  @[JSON::Field(key: "480w_still")]
  property the_480_w_still : Downsized?
end

class Downsized
  include JSON::Serializable

  property height : String

  property size : String?

  property url : String

  property width : String
end

class DownsizedSmall
  include JSON::Serializable

  property height : String

  property mp4 : String

  property mp4_size : String

  property width : String
end

class FixedHeight
  include JSON::Serializable

  property frames : String?

  property hash : String?

  property height : String

  property mp4 : String?

  property mp4_size : String?

  property size : String

  property url : String

  property webp : String

  property webp_size : String

  property width : String
end

class Looping
  include JSON::Serializable

  property mp4 : String

  property mp4_size : String
end

class User
  include JSON::Serializable

  property avatar_url : String

  property banner_url : String

  property display_name : String

  property profile_url : String

  property username : String
end

class Meta
  include JSON::Serializable

  property msg : String

  property response_id : String

  property status : Int64
end

class Pagination
  include JSON::Serializable

  property count : Int64

  property offset : Int64

  property total_count : Int64
end
