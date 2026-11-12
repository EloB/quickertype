# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.people.first.craft
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

class Person < Dry::Struct
  attribute :craft,       Types::String
  attribute :person_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      craft:       d.fetch("craft"),
      person_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "craft" => craft,
      "name"  => person_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :message, Types::String
  attribute :number,  Types::Integer
  attribute :people,  Types.Array(Person)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      message: d.fetch("message"),
      number:  d.fetch("number"),
      people:  d.fetch("people").map { |x| Person.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "message" => message,
      "number"  => number,
      "people"  => people.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
