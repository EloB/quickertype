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

class Args < Dry::Struct

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
  attribute :args,    Args
  attribute :data,    Types::String
  attribute :files,   Args
  attribute :form,    Args
  attribute :headers, Headers
  attribute :origin,  Types::String
  attribute :url,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      args:    Args.from_dynamic!(d.fetch("args")),
      data:    d.fetch("data"),
      files:   Args.from_dynamic!(d.fetch("files")),
      form:    Args.from_dynamic!(d.fetch("form")),
      headers: Headers.from_dynamic!(d.fetch("headers")),
      origin:  d.fetch("origin"),
      url:     d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "args"    => args.to_dynamic,
      "data"    => data,
      "files"   => files.to_dynamic,
      "form"    => form.to_dynamic,
      "headers" => headers.to_dynamic,
      "origin"  => origin,
      "url"     => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
