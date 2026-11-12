# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.response&.first.body
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

class Response < Dry::Struct
  attribute :body, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      body: d.key?("body") ? Types::String[d["body"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "body" => body,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Postman collection
class TopLevel < Dry::Struct
  attribute :item,           Types.Array(TopLevel).optional
  attribute :top_level_name, Types::String.optional
  attribute :response,       Types.Array(Response).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      item:           d.key?("item") ? d["item"].map { |x| TopLevel.from_dynamic!(x) } : nil,
      top_level_name: d.key?("name") ? Types::String[d["name"]] : nil,
      response:       d.key?("response") ? d["response"].map { |x| Response.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "item"     => item&.map { |x| x.to_dynamic },
      "name"     => top_level_name,
      "response" => response&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
