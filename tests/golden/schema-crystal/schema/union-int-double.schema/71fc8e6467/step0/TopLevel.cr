require "json"

class TopLevel
  include JSON::Serializable

  property value : ValueUnion
end

alias ValueUnion = Float64 | String
