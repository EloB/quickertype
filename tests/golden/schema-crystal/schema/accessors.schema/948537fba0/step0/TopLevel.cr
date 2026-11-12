require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "bar")]
  property barre : String

  @[JSON::Field(key: "enum")]
  property enumerification : String

  property foo : String

  @[JSON::Field(key: "union")]
  property unionization : UnionUnion
end

alias UnionUnion = Float64 | Bool
