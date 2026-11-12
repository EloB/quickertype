require "json"

class TopLevel
  include JSON::Serializable

  property a : Hash(String, Int64)

  property b : Hash(String, Int64)
end
