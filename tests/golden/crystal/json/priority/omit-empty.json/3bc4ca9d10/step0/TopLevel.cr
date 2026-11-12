require "json"

class TopLevel
  include JSON::Serializable

  property results : Array(Result)
end

class Result
  include JSON::Serializable

  property age : Int64

  property name : Nil
end
