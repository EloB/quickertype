# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.input.first.content
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

class Item < Dry::Struct
  attribute :content, Types::String.optional
  attribute :id,      Types::String.optional
  attribute :output,  Types::String.optional
  attribute :summary, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      content: d.key?("content") ? Types::String[d["content"]] : nil,
      id:      d.key?("id") ? Types::String[d["id"]] : nil,
      output:  d.key?("output") ? Types::String[d["output"]] : nil,
      summary: d.key?("summary") ? Types::String[d["summary"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "content" => content,
      "id"      => id,
      "output"  => output,
      "summary" => summary,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :input, Types.Array(Item)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      input: d.fetch("input").map { |x| Item.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "input" => input.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
