# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.tx_indexes.first.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  String  = Strict::String
end

class TopLevel < Dry::Struct
  attribute :block_index,    Types::Integer
  attribute :height,         Types::Integer
  attribute :time,           Types::Integer
  attribute :top_level_hash, Types::String
  attribute :tx_indexes,     Types.Array(Types::Integer)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      block_index:    d.fetch("block_index"),
      height:         d.fetch("height"),
      time:           d.fetch("time"),
      top_level_hash: d.fetch("hash"),
      tx_indexes:     d.fetch("txIndexes"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "block_index" => block_index,
      "height"      => height,
      "time"        => time,
      "hash"        => top_level_hash,
      "txIndexes"   => tx_indexes,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
