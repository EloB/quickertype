# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.cookies.first.cookie_name
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

class Cookie < Dry::Struct
  attribute :cookie_name, Types::String
  attribute :value,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      cookie_name: d.fetch("name"),
      value:       d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"  => cookie_name,
      "value" => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :cookies, Types.Array(Cookie)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      cookies: d.fetch("cookies").map { |x| Cookie.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "cookies" => cookies.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
