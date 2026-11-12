require "json"

class TopLevel
  include JSON::Serializable

  property pokemon : Array(Pokemon)
end

class Pokemon
  include JSON::Serializable

  property avg_spawns : Float64

  property candy : String

  property candy_count : Int64?

  property egg : String

  property height : String

  property id : Int64

  property img : String

  property multipliers : Array(Float64)?

  property name : String

  property next_evolution : Array(Evolution)?

  property num : String

  @[JSON::Field(key: "type")]
  property pokemon_type : Array(String)

  property prev_evolution : Array(Evolution)?

  property spawn_chance : Float64

  property spawn_time : String

  property weaknesses : Array(String)

  property weight : String
end

class Evolution
  include JSON::Serializable

  property name : String

  property num : String
end
