# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.pokemon.first.weaknesses.first == Type::Fire
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module QuickType
  module Types
    include Dry.Types(default: :nominal)

    Integer = Strict::Integer
    Nil     = Strict::Nil
    Hash    = Strict::Hash
    String  = Strict::String
    Double  = Strict::Float | Strict::Integer
    Egg     = Strict::String.enum("2 km", "Not in Eggs", "5 km", "10 km", "Omanyte Candy")
    Type    = Strict::String.enum("Fire", "Ice", "Flying", "Psychic", "Water", "Ground", "Rock", "Electric", "Grass", "Fighting", "Poison", "Bug", "Fairy", "Ghost", "Dark", "Steel", "Dragon", "Normal")
  end

  module Egg
    The2KM       = "2 km"
    NotInEggs    = "Not in Eggs"
    The5KM       = "5 km"
    The10KM      = "10 km"
    OmanyteCandy = "Omanyte Candy"
  end

  class Evolution < Dry::Struct
    attribute :evolution_name, Types::String
    attribute :num,            Types::String

    def self.from_dynamic!(d)
      d = Types::Hash[d]
      new(
        evolution_name: d.fetch("name"),
        num:            d.fetch("num"),
      )
    end

    def self.from_json!(json)
      from_dynamic!(JSON.parse(json))
    end

    def to_dynamic
      {
        "name" => evolution_name,
        "num"  => num,
      }
    end

    def to_json(options = nil)
      JSON.generate(to_dynamic, options)
    end
  end

  module Type
    Fire     = "Fire"
    Ice      = "Ice"
    Flying   = "Flying"
    Psychic  = "Psychic"
    Water    = "Water"
    Ground   = "Ground"
    Rock     = "Rock"
    Electric = "Electric"
    Grass    = "Grass"
    Fighting = "Fighting"
    Poison   = "Poison"
    Bug      = "Bug"
    Fairy    = "Fairy"
    Ghost    = "Ghost"
    Dark     = "Dark"
    Steel    = "Steel"
    Dragon   = "Dragon"
    Normal   = "Normal"
  end

  class Pokemon < Dry::Struct
    attribute :avg_spawns,     Types::Double
    attribute :candy,          Types::String
    attribute :candy_count,    Types::Integer.optional
    attribute :egg,            Types::Egg
    attribute :height,         Types::String
    attribute :id,             Types::Integer
    attribute :img,            Types::String
    attribute :multipliers,    Types.Array(Types::Double).optional
    attribute :next_evolution, Types.Array(Evolution).optional
    attribute :num,            Types::String
    attribute :pokemon_name,   Types::String
    attribute :pokemon_type,   Types.Array(Types::Type)
    attribute :prev_evolution, Types.Array(Evolution).optional
    attribute :spawn_chance,   Types::Double
    attribute :spawn_time,     Types::String
    attribute :weaknesses,     Types.Array(Types::Type)
    attribute :weight,         Types::String

    def self.from_dynamic!(d)
      d = Types::Hash[d]
      new(
        avg_spawns:     d.fetch("avg_spawns"),
        candy:          d.fetch("candy"),
        candy_count:    d.key?("candy_count") ? Types::Integer[d["candy_count"]] : nil,
        egg:            d.fetch("egg"),
        height:         d.fetch("height"),
        id:             d.fetch("id"),
        img:            d.fetch("img"),
        multipliers:    d.fetch("multipliers"),
        next_evolution: d.key?("next_evolution") ? d["next_evolution"].map { |x| Evolution.from_dynamic!(x) } : nil,
        num:            d.fetch("num"),
        pokemon_name:   d.fetch("name"),
        pokemon_type:   d.fetch("type"),
        prev_evolution: d.key?("prev_evolution") ? d["prev_evolution"].map { |x| Evolution.from_dynamic!(x) } : nil,
        spawn_chance:   d.fetch("spawn_chance"),
        spawn_time:     d.fetch("spawn_time"),
        weaknesses:     d.fetch("weaknesses"),
        weight:         d.fetch("weight"),
      )
    end

    def self.from_json!(json)
      from_dynamic!(JSON.parse(json))
    end

    def to_dynamic
      {
        "avg_spawns"     => avg_spawns,
        "candy"          => candy,
        "candy_count"    => candy_count,
        "egg"            => egg,
        "height"         => height,
        "id"             => id,
        "img"            => img,
        "multipliers"    => multipliers,
        "next_evolution" => next_evolution&.map { |x| x.to_dynamic },
        "num"            => num,
        "name"           => pokemon_name,
        "type"           => pokemon_type,
        "prev_evolution" => prev_evolution&.map { |x| x.to_dynamic },
        "spawn_chance"   => spawn_chance,
        "spawn_time"     => spawn_time,
        "weaknesses"     => weaknesses,
        "weight"         => weight,
      }
    end

    def to_json(options = nil)
      JSON.generate(to_dynamic, options)
    end
  end

  class TopLevel < Dry::Struct
    attribute :pokemon, Types.Array(Pokemon)

    def self.from_dynamic!(d)
      d = Types::Hash[d]
      new(
        pokemon: d.fetch("pokemon").map { |x| Pokemon.from_dynamic!(x) },
      )
    end

    def self.from_json!(json)
      from_dynamic!(JSON.parse(json))
    end

    def to_dynamic
      {
        "pokemon" => pokemon.map { |x| x.to_dynamic },
      }
    end

    def to_json(options = nil)
      JSON.generate(to_dynamic, options)
    end
  end
end
