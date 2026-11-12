require "json"

class TopLevel
  include JSON::Serializable

  property pc : Pc

  property ps3 : Pc

  property ps4 : Pc

  property xbox : Pc

  property xone : Pc
end

class Pc
  include JSON::Serializable

  property count : Int64

  property label : String

  property peak24 : Int64
end
