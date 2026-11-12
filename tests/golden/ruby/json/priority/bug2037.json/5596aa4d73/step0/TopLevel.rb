# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.mission_specs["…"].objectives["…"].rewards["…"]
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash = Strict::Hash
end

class Reward < Dry::Struct

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

class Objective < Dry::Struct
  attribute :rewards, Types::Hash.meta(of: Reward)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      rewards: Types::Hash[d.fetch("rewards")].map { |k, v| [k, Reward.from_dynamic!(v)] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "rewards" => rewards.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MissionSpec < Dry::Struct
  attribute :objectives, Types::Hash.meta(of: Objective)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      objectives: Types::Hash[d.fetch("objectives")].map { |k, v| [k, Objective.from_dynamic!(v)] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "objectives" => objectives.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :mission_specs, Types::Hash.meta(of: MissionSpec)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      mission_specs: Types::Hash[d.fetch("mission_specs")].map { |k, v| [k, MissionSpec.from_dynamic!(v)] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "mission_specs" => mission_specs.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
