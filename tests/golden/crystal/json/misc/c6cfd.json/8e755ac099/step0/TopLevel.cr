require "json"

class TopLevel
  include JSON::Serializable

  property countries : Array(Country)
end

class Country
  include JSON::Serializable

  property code : String

  property name : String
end
