require "json"

# An object with a scalar default
class TopLevel
  include JSON::Serializable

  property id : Int64
end
