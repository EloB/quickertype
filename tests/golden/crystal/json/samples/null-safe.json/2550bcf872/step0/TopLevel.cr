require "json"

class TopLevel
  include JSON::Serializable

  property item : Array(Item)
end

class Item
  include JSON::Serializable

  property address : Address?

  property created_at : String?

  property name : String

  property sex : Int64?
end

class Address
  include JSON::Serializable

  property city : String

  property country : String

  property street : String
end
