# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.headers.accept_encoding
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

class Headers < Dry::Struct
  attribute :accept_encoding, Types::String
  attribute :connection,      Types::String
  attribute :host,            Types::String
  attribute :user_agent,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      accept_encoding: d.fetch("Accept-Encoding"),
      connection:      d.fetch("Connection"),
      host:            d.fetch("Host"),
      user_agent:      d.fetch("User-Agent"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Accept-Encoding" => accept_encoding,
      "Connection"      => connection,
      "Host"            => host,
      "User-Agent"      => user_agent,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :headers, Headers

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      headers: Headers.from_dynamic!(d.fetch("headers")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "headers" => headers.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
