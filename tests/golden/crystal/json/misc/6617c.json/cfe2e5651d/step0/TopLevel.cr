require "json"

class TopLevel
  include JSON::Serializable

  property iss_position : IssPosition

  property message : String

  property timestamp : Int64
end

class IssPosition
  include JSON::Serializable

  property latitude : String

  property longitude : String
end
