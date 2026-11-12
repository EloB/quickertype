# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.group
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
end

class TopLevel < Dry::Struct
  attribute :group,       Types::String
  attribute :movie,       Types::String
  attribute :movie_image, Types::String
  attribute :theater,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      group:       d.fetch("group"),
      movie:       d.fetch("movie"),
      movie_image: d.fetch("movie-image"),
      theater:     d.fetch("theater"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "group"       => group,
      "movie"       => movie,
      "movie-image" => movie_image,
      "theater"     => theater,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
