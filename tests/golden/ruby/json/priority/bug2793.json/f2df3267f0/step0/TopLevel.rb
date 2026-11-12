# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.labels.account_number
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

class Hints < Dry::Struct

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

class Labels < Dry::Struct
  attribute :account_number, Types::String
  attribute :title,          Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      account_number: d.fetch("AccountNumber"),
      title:          d.fetch("Title"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "AccountNumber" => account_number,
      "Title"         => title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :hints,  Hints
  attribute :labels, Labels

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      hints:  Hints.from_dynamic!(d.fetch("Hints")),
      labels: Labels.from_dynamic!(d.fetch("Labels")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Hints"  => hints.to_dynamic,
      "Labels" => labels.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
