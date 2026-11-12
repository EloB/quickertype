require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "minMaxLength")]
  property min_max_length : String

  property percent : Float64
end
