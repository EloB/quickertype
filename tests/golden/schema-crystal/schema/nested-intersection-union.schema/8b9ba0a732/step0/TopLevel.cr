require "json"

class TopLevel
  include JSON::Serializable

  property input : Array(Item)
end

class Item
  include JSON::Serializable

  property content : String?

  property id : String?

  property output : String?

  property summary : String?
end
