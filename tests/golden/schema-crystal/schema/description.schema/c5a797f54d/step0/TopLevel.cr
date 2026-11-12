require "json"

# The top-level class.
# Its description has two lines.
class TopLevel
  include JSON::Serializable

  # A pretty boolean
  property bar : Bool?

  # An enumeration
  @[JSON::Field(key: "enum")]
  property top_level_enum : String

  property foo : Float64?

  @[JSON::Field(key: "object-or-string")]
  property object_or_string : ObjectOrStringUnion

  # Either a number or a string
  @[JSON::Field(key: "union")]
  property top_level_union : UnionUnion
end

class ObjectOrStringClass
  include JSON::Serializable

  # This must not get lost
  property prop : Float64
end

alias ObjectOrStringUnion = ObjectOrStringClass | String

# Either a number or a string
alias UnionUnion = Float64 | String
