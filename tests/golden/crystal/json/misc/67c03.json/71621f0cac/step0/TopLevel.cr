require "json"

class TopLevel
  include JSON::Serializable

  property message : String

  property number : Int64

  property people : Array(Person)
end

class Person
  include JSON::Serializable

  property craft : String

  property name : String
end
