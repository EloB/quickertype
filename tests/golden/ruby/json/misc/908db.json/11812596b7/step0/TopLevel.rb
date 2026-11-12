# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.states.first.state.state_id
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

class StateState < Dry::Struct
  attribute :state_id,   Types::String
  attribute :state_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      state_id:   d.fetch("state_id"),
      state_name: d.fetch("state_name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "state_id"   => state_id,
      "state_name" => state_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StateElement < Dry::Struct
  attribute :state, StateState

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      state: StateState.from_dynamic!(d.fetch("state")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "state" => state.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :states, Types.Array(StateElement)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      states: d.fetch("states").map { |x| StateElement.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "states" => states.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
